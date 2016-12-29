FROM zim32/debian:latest

RUN \
	apt-get update && apt-get upgrade -y && apt-get install -y \
	ssh \
	curl \
	php5-fpm \
	php5-cli \
	php5-xdebug \
	php5-mysql \
	php5-json \
	php5-intl \
	php5-curl\
	git

RUN \
	sed -i -e 's/^;date.timezone =/date.timezone = UTC/g' /etc/php5/fpm/php.ini && \
	sed -i -e 's/^;date.timezone =/date.timezone = UTC/g' /etc/php5/cli/php.ini && \
	echo 'opcache.enable = Off' >> /etc/php5/mods-available/opcache.ini && \
	echo ';xdebug.remote_enable = On' >> /etc/php5/mods-available/xdebug.ini && \
	echo ';xdebug.var_display_max_depth = 5' >> /etc/php5/mods-available/xdebug.ini && \
	echo 'xdebug.max_nesting_level = 250' >> /etc/php5/mods-available/xdebug.ini && \
	mkdir /home/zim32/www && \
	mkdir /home/zim32/www/logs && \
	mkdir /home/zim32/www/logs/php && \
	touch /home/zim32/www/logs/php/error.log && \
	touch /home/zim32/www/logs/php/access.log && \
	mv /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf.back && \
	chown -R zim32:zim32 /home/zim32

COPY copy/ /

VOLUME ["/home/zim32/www/logs"]

CMD ["/bin/bash", "/root/start_all.sh"]

EXPOSE 8080
