Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUADS6T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 13:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUADS6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 13:58:18 -0500
Received: from scrat.hensema.net ([62.212.82.150]:13700 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S264271AbUADS6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 13:58:03 -0500
From: Erik Hensema <erik@hensema.net>
Subject: 2.6.0: something is leaking memory
Date: Sun, 4 Jan 2004 18:57:59 +0000 (UTC)
Message-ID: <slrnbvgohn.1pb.erik@dexter.hensema.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.3 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

About a month ago I installed 2.6.0-test11 on my home server (NAT
gateway, NFS server, news, mail, ntp, ldap, you name it). From
that moment there's some memory leak in the system. It could be
userspace, but there are no changes there since before the
upgrade.

The leak can be most easily seen in my rrdtool graphs of memory
usage: http://dexter.hensema.net/~erik/stats/mem-mon.gif and
http://dexter.hensema.net/~erik/stats/mem-year.gif - try to guess
when I switched to 2.6.0-test11 ;-)

At Dec 31 I upgraded to 2.6.0-final.

Output from ps aux, /proc/vmstat and /proc/meminfo, are attached.
My .config isn't compiled in and I haven't got it at hand
currently. If anyone is interested I can post it tomorrow.

The machine is running SuSE 8.2, fairly standard. INN is compiled
from source, it's 2.4.0, but the other daemons came with the
distribution.
LVM, procps, modutils are all updated. All filesystems are
reiserfs on LVM (except for the root partition, which is a
regular partition, and /boot which is ext2 on a partition).

It's a Duron 700 with 256 MB ram, IDE disk. No preempt, no
framebuffer. Three network cards: de4x5, tulip and 8139too
drivers.

Modules:

Module                  Size  Used by
i2c_dev                 8256  0 
eeprom                  5960  0 
i2c_isa                 1664  0 
tun                     6784  1 
nfsd                   94768  8 
exportfs                5056  1 nfsd
ip6t_MARK               1664  5 
ipt_MARK                1664  4 
ipt_mark                1344  1 
ipt_TOS                 1920  5 
ipt_length              1344  5 
ipt_tos                 1280  5 
ip6table_mangle         1920  1 
iptable_mangle          2112  1 
cls_fw                  3520  4 
sch_sfq                 4480  4 
sch_htb                22016  1 
ip6t_LOG                4672  1 
ip6table_filter         2048  1 
ip6_tables             16000  4 ip6t_MARK,ip6table_mangle,ip6t_LOG,ip6table_filter
ipt_MASQUERADE          2752  4 
ip_nat_ftp              3952  0 
ipt_REJECT              5376  4 
ipt_state               1408  4 
ipt_LOG                 4736  8 
ipt_limit               1856  5 
ipt_ULOG                5480  21 
iptable_filter          2112  1 
ip_nat_irc              3312  0 
iptable_nat            18668  4 ipt_MASQUERADE,ip_nat_ftp,ip_nat_irc
ip_conntrack_irc       70260  1 ip_nat_irc
ip_conntrack_ftp       70964  1 ip_nat_ftp
ip_conntrack           26160  7 ipt_MASQUERADE,ip_nat_ftp,ipt_state,ip_nat_irc,iptable_nat,ip_conntrack_irc,ip_conntrack_ftp
ip_tables              15104  14 ipt_MARK,ipt_mark,ipt_TOS,ipt_length,ipt_tos,iptable_mangle,ipt_MASQUERADE,ipt_REJECT,ipt_state,ipt_LOG,ipt_limit,ipt_ULOG,iptable_filter,iptable_nat
8139too                19136  0 
mii                     4096  1 8139too
tulip                  43872  0 
de4x5                  48416  0 
via686a                18376  0 
lm75                    6532  0 
i2c_sensor              2304  3 eeprom,via686a,lm75
i2c_viapro              5900  0 
i2c_core               20808  7 i2c_dev,eeprom,i2c_isa,via686a,lm75,i2c_sensor,i2c_viapro


The following dumps were made just before rebooting on Dec 31:


USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   500   72 ?        S    Dec02   0:14 init [3]  
root         2  0.0  0.0     0    0 ?        SWN  Dec02   0:00 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        SW<  Dec02   0:00 [events/0]
root         4  0.0  0.0     0    0 ?        SW<  Dec02   2:05 [kblockd/0]
root         7  0.0  0.0     0    0 ?        SW   Dec02   2:57 [kswapd0]
root         8  0.0  0.0     0    0 ?        SW<  Dec02   0:00 [aio/0]
root         9  0.0  0.0     0    0 ?        SW   Dec02   0:00 [kseriod]
root        10  0.0  0.0     0    0 ?        SW<  Dec02   0:00 [reiserfs/0]
root       213  0.0  0.1  1488  444 ttyS0    S    Dec02   0:01 /sbin/powerd
root       350  0.0  0.1  1516  340 ?        S    Dec02   2:54 /sbin/dhcpcd -D -R -N -Y -t 999999 -h cc78409-a eth0
root       689  0.0  0.2  1788  628 ?        S    Dec02  22:24 /sbin/syslogd -a /var/lib/dhcp/dev/log -a /var/lib/named/dev/log
root       692  0.0  0.1  2632  440 ?        S    Dec02   0:07 /sbin/klogd -c 1 -2
root       873  0.0  0.5  2344 1300 ?        S    Dec02  17:17 /usr/local/sbin/ulog-acctd
root       883  0.0  0.1  1524  380 ?        S    Dec02   0:00 /sbin/resmgrd
bin        893  0.0  0.1  1528  440 ?        S    Dec02   0:01 /sbin/portmap
root       906  0.0  0.2  2764  568 ?        S    Dec02   0:03 /usr/sbin/zebra -d
root       924  0.0  0.0     0    0 ?        SW   Dec02   4:09 [nfsd]
root       925  0.0  0.0     0    0 ?        SW   Dec02   4:15 [nfsd]
root       926  0.0  0.0     0    0 ?        SW   Dec02   4:45 [nfsd]
root       927  0.0  0.0     0    0 ?        SW   Dec02   4:30 [nfsd]
root       928  0.0  0.0     0    0 ?        SW   Dec02   4:55 [nfsd]
root       932  0.0  0.0     0    0 ?        SW   Dec02   0:01 [lockd]
root       933  0.0  0.0     0    0 ?        SW   Dec02   0:00 [rpciod]
root       929  0.0  0.0     0    0 ?        SW   Dec02   4:02 [nfsd]
root       930  0.0  0.0     0    0 ?        SW   Dec02   4:05 [nfsd]
root       931  0.0  0.0     0    0 ?        SW   Dec02   4:20 [nfsd]
root       947  0.0  0.2  1804  648 ?        S    Dec02   0:01 /usr/sbin/rpc.mountd
root      1118  0.0  0.1  2608  472 ?        S    Dec02   0:00 /bin/sh /usr/bin/safe_mysqld --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --socket=/var/lib/mysql/mysql.sock --datadir=/var/lib/mysql
mysql     1155  0.0  0.5 26244 1472 ?        S    Dec02   3:34 /usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --skip-locking
mysql     1156  0.0  0.5 26244 1472 ?        S    Dec02   0:13 /usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --skip-locking
mysql     1157  0.0  0.5 26244 1472 ?        S    Dec02   0:03 /usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --skip-locking
root      1210  0.0  0.2  4388  688 ?        S    Dec03   0:18 /usr/sbin/sshd -o PidFile /var/run/sshd.init.pid
root      1235  0.1  0.3  3152  792 ?        S    Dec03  57:14 /usr/local/sbin/tincd -n wlan
ntp       1307  0.0  0.8  2164 2156 ?        SL   Dec03   0:09 /usr/sbin/ntpd -U ntp
at        1377  0.0  0.0  1656  112 ?        S    Dec03   0:00 /usr/sbin/atd
root      1467  0.0  0.0  1640  168 ?        S    Dec03   0:05 /usr/sbin/cron
root      1472  0.0  0.1  2064  392 ?        S    Dec03   0:17 /usr/local/bin/fetchmail -f /etc/fetchmailrc
root      1483  0.0  0.0  1548  224 ?        S    Dec03   0:01 /usr/sbin/inetd
root      1495  0.0  0.2  1756  552 ?        S    Dec03   0:00 /sbin/rpc.statd
root      1500  0.0  0.0  1624   72 tty1     S    Dec03   0:00 /sbin/mingetty --noclear tty1
root      1501  0.0  0.1  1624  364 tty2     S    Dec03   0:00 /sbin/mingetty tty2
root      1502  0.0  0.0  1624   72 tty3     S    Dec03   0:00 /sbin/mingetty tty3
root      1503  0.0  0.0  1624   72 tty4     S    Dec03   0:00 /sbin/mingetty tty4
root      1504  0.0  0.0  1624   72 tty5     S    Dec03   0:00 /sbin/mingetty tty5
root      1505  0.0  0.0  1624   72 tty6     S    Dec03   0:00 /sbin/mingetty tty6
logger   23531  0.0  0.0  6924  252 ?        S    Dec03   0:06 SCREEN irssi
logger   23532  0.0  0.5  8292 1320 pts/1    S    Dec03   2:03 irssi
erik      9850  0.0  0.0  7308   88 ?        S    Dec07   0:00 /usr/bin/perl -w /home/erik/swentrap.pl
erik      9851  0.0  0.0  1644   72 ?        S    Dec07   0:00 whois -h whois.abuse.net smtp4.hy.skanova.net.
erik      9852  0.0  0.0  7176   88 ?        S    Dec07   0:00 /usr/bin/perl -w /home/erik/swentrap.pl
erik      9853  0.0  0.0  1644   72 ?        S    Dec07   0:00 whois -h whois.abuse.net smtp5.clb.oleane.net.
erik     30466  0.0  0.0  6460   88 ?        S    Dec08   0:00 /usr/bin/perl ./siggen.pl
erik     30467  0.0  0.0  6460   88 ?        S    Dec08   0:00 /usr/bin/perl ./siggen.pl
erik     30468  0.0  0.0  6460   88 ?        S    Dec08   0:00 /usr/bin/perl ./siggen.pl
erik     30469  0.0  0.0  6460   88 ?        S    Dec08   0:00 /usr/bin/perl ./siggen.pl
erik     30470  0.0  0.0  6460   88 ?        S    Dec08   0:00 /usr/bin/perl ./siggen.pl
erik      5387  0.0  0.0  7176   88 ?        S    Dec09   0:00 /usr/bin/perl -w /home/erik/swentrap.pl
erik      5388  0.0  0.0  1644   72 ?        S    Dec09   0:00 whois -h whois.abuse.net outbound04.telus.net.
root     22934  0.0  0.2  5404  632 ?        S    Dec13   0:31 sendmail: accepting connections                 
mail     22938  0.0  0.1  4872  428 ?        S    Dec13   0:00 sendmail: Queue runner@00:30:00 for /var/spool/clientmqueue
root      1532  0.0  0.1  2724  408 ?        S    Dec21   0:09 /usr/sbin/dhcpd eth1 eth2
named     3932  0.0  2.0 21292 5348 ?        S    Dec22   0:00 /usr/sbin/named -t /var/named -u named
named     3933  0.0  2.0 21292 5352 ?        S    Dec22   0:00 /usr/sbin/named -t /var/named -u named
named     3934  0.0  2.0 21292 5352 ?        S    Dec22  12:04 /usr/sbin/named -t /var/named -u named
named     3935  0.0  2.0 21292 5352 ?        S    Dec22   0:06 /usr/sbin/named -t /var/named -u named
named     3936  0.0  2.0 21292 5352 ?        S    Dec22   2:54 /usr/sbin/named -t /var/named -u named
ldap     24050  0.0  1.1 187432 3012 ?       S    Dec25   0:00 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24051  0.0  1.1 187432 3012 ?       S    Dec25   0:00 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24052  0.0  1.1 187432 3012 ?       S    Dec25   1:51 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24083  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24084  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24085  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24086  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24087  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24088  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
root     24562  0.0  0.0 95704  236 ?        S    Dec25   0:02 /usr/sbin/httpd -f /etc/httpd/httpd.conf
wwwrun   24564  0.0  0.4 96128 1140 ?        S    Dec25   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf
wwwrun   24565  0.0  0.4 96132 1160 ?        S    Dec25   0:00 /usr/sbin/httpd -f /etc/httpd/httpd.conf
ldap     24568  0.0  1.1 187432 3012 ?       S    Dec25   0:30 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24595  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24596  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24597  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24598  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     24599  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     25146  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     25416  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     25565  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     25566  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     26104  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     26105  0.0  1.1 187432 3012 ?       S    Dec25   0:27 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     26106  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     26107  0.0  1.1 187432 3012 ?       S    Dec25   0:30 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     26108  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     26109  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     26503  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     26504  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     27006  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     27117  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     27120  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     27392  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     27393  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     27394  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     27395  0.0  1.1 187432 3012 ?       S    Dec25   0:29 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
ldap     27396  0.0  1.1 187432 3012 ?       S    Dec25   0:28 /usr/lib/openldap/slapd -h ldap:/// -u ldap -g ldap
news      4451  0.1  1.7 15324 4492 ?        S    Dec30   1:56 /usr/lib/news/bin/innd -p 3,4 -C
news      4452  0.0  0.0  4728   80 ?        S    Dec30   0:00 /bin/sh /usr/lib/news/bin/rc.news start
news      4456  0.0  0.2  2832  572 ?        SN   Dec30   0:15 /usr/lib/news/bin/innfeed
news      4457  0.0  0.1  4872  276 ?        SN   Dec30   0:00 /usr/bin/perl -w /usr/lib/news/bin/controlchan
news      4458  0.0  0.2  3620  536 ?        SN   Dec30   0:10 /usr/bin/perl -w /etc/news/bin/indexchan
news      4459  0.0  0.0  2476   76 ?        SN   Dec30   0:00 /bin/sh /etc/news/autocancel/startautocancel
news      4460  0.0  0.3  3620  788 ?        SN   Dec30   0:10 /usr/bin/perl -w /home/erik/src/cancelchan/cancelchan.pl
news      4463  0.0  0.5  6116 1456 ?        SN   Dec30   0:55 /etc/news/autocancel/autocancel
news      4514  0.2  0.2  4856  644 ?        S    Dec30   2:35 /bin/sh /usr/lib/news/bin/innwatch
root     30876  0.0  0.4 16676 1092 ?        S     2004   0:01 /usr/sbin/nscd
root     30877  0.0  0.4 16676 1092 ?        S     2004   0:00 /usr/sbin/nscd
root     30878  0.0  0.4 16676 1092 ?        S     2004   0:00 /usr/sbin/nscd
root     30879  0.0  0.4 16676 1092 ?        S     2004   0:00 /usr/sbin/nscd
root     30880  0.0  0.4 16676 1092 ?        S     2004   0:00 /usr/sbin/nscd
root     30881  0.0  0.4 16676 1092 ?        S     2004   0:00 /usr/sbin/nscd
root     30882  0.0  0.4 16676 1092 ?        S     2004   0:00 /usr/sbin/nscd
root      5176  0.0  0.0     0    0 ?        SW    2004   0:01 [pdflush]
root     26637  0.0  0.0     0    0 ?        SW    2004   0:10 [pdflush]
news     17883  0.0  0.5 20544 1356 ?        SN    2004   0:00 - nnrpd: bender.ipv6.hensema.net ARTICLE                                  
root     17919  0.0  0.8  8324 2172 ?        S     2004   0:00 /usr/sbin/sshd -o PidFile /var/run/sshd.init.pid
erik     17921  0.0  0.8  8336 2288 ?        S     2004   0:00 /usr/sbin/sshd -o PidFile /var/run/sshd.init.pid
erik     17922  0.0  0.6  4792 1564 pts/0    S     2004   0:00 -bash
news     19089  0.0  0.2  4084  552 ?        S     2004   0:00 sleep 120
erik     19102  0.0  0.2  2780  708 pts/0    R     2004   0:00 ps aux



nr_dirty 35
nr_writeback 0
nr_unstable 0
nr_page_table_pages 286
nr_mapped 6113
nr_slab 49479
pgpgin 70810333
pgpgout 164438264
pswpin 1046860
pswpout 591665
pgalloc 512977858
pgfree 512979155
pgactivate 16200881
pgdeactivate 14230409
pgfault 1132924331
pgmajfault 729065
pgscan 72463905
pgrefill 37275398
pgsteal 34042946
pginodesteal 0
kswapd_steal 33967753
kswapd_inodesteal 155251
pageoutrun 108132
allocstall 2656
pgrotated 1446342



MemTotal:       256012 kB
MemFree:          5088 kB
Buffers:          2988 kB
Cached:          16948 kB
SwapCached:      15332 kB
Active:          35976 kB
Inactive:         1916 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256012 kB
LowFree:          5088 kB
SwapTotal:      500464 kB
SwapFree:       451456 kB
Dirty:              72 kB
Writeback:           0 kB
Mapped:          24444 kB
Slab:           197940 kB
Committed_AS:   379592 kB
PageTables:       1144 kB
VmallocTotal:   778168 kB
VmallocUsed:      4100 kB
VmallocChunk:   773940 kB


-- 
Erik Hensema <erik@hensema.net>
