HLIST = hash.txt
SLIST = station.txt
XML = station_list.xml
URL = http://www.iheartradio.com/cc-common/iphone/$(XML)

all: $(HLIST)
$(HLIST): $(SLIST)
	cat $< | awk '!/^http/{printf "url[\"" $$0 "\"]"}/^http/{printf "=\"" $$0 "\"\n"}' | sort > $@
$(SLIST): $(XML)
	cat $< | grep 'name\|stream_url_v2' | sed 's/\(.*\[\)//;s/\(\].*\)$$//' | sed 's/<[^>]*>//g' | sed 's/^ *//;s/ *$$//' > $@

$(XML): 
	wget -nc $(URL)

clean:
	$(RM) $(HLIST) $(SLIST)
distclean:
	$(MAKE) clean
	$(RM) $(XML)
