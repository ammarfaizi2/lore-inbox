Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262601AbSJLBIW>; Fri, 11 Oct 2002 21:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbSJLBIW>; Fri, 11 Oct 2002 21:08:22 -0400
Received: from fastmail.fm ([209.61.183.86]:56553 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S262590AbSJLBIP>;
	Fri, 11 Oct 2002 21:08:15 -0400
X-Epoch: 1034385233
X-Sasl-enc: lQz0FJ8nU5AVYsnki+92Dg
Message-ID: <0f3201c2718c$750a13b0$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>
Subject: Strange load spikes on 2.4.19 kernel
Date: Sat, 12 Oct 2002 11:12:34 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:
We've spent the last couple of days trying to diagnose some strange load
spikes we've been observing on our server. The basic symptom is that the
load will appear to be falling gradually (often down to between 0.5 and
3), and then will appear to basically *instantly* rise to a rather large
value (between 15 and 30). This occurs at intervals of around 1 to 5
minutes or so. During the spiking time, system response is significantly
slowed. Sometimes it takes up to 10 seconds just to run an 'uptime' or
'ls' command. Oddly though, once run, it appears to be much more
responsive thereafter... (no swapping is occuring see below)

vmstat and uptime output:
To show what I mean about the load spikes, I did the following to gather
uptime and vmstat data at the same time at 5 second intervals.

vmstat -n 5 > /tmp/d1 & while true; do uptime >> /tmp/d2; sleep 5; done

These got a little out of sync after a few minutes, but it's still fairly
illustrative. I used a perl script to join these together with the time
(seconds) on the left. I've trimmed the swap columns, which didn't change,
and also the 2 longer term load average columns so it fits in 76 chars.

      procs              memory        io     system   cpu
t   r  b  w  free   buff  cache  bi    bo   in    cs  us  sy  id uptime
--|-------------------------------------------------------------|------
37| 0  0  0 66440 414628 1691196  51   983  395  963   7   8  85| 2.22,
42| 0  0  0 66860 414880 1691240  34   825  383 1023   6   9  85| 2.04,
47| 0  0  1 69736 415008 1691384  33   778  409 1285   7   9  84| 1.95,
52| 0  0  0 71596 415120 1691432   9  1021  393 1154   6   9  85| 1.80,
57| 0  0  0 66620 415972 1692476  47  4910  825 2100  11  13  76| 1.89,
02| 0  1  0 77624 416320 1694268 197  2132  761 1570  11  10  79| 1.90,
07| 0  0  0 76796 416544 1694804  99  1494  492 1209   7   9  83| 1.91,
12| 1  0  0 84736 416708 1695808 200  1178  498 1270  14  10  77| 1.76,
17| 0  0  0 86388 416792 1695824   4   972  445  994   6   7  88| 1.62,
22| 0  0  0 98276 416928 1695868   1  1322  484 1049   9  10  81| 1.49,
27| 0  1  1 94284 417164 1695564  48  1553  527 1205   9  10  81| 1.37,
32| 1  0  0 90336 417340 1695676  18  1243  497 1188   8  10  82| 17.03
37| 4  0  1 84288 417440 1695728   8   812  425 1186   6  10  84| 15.67
42| 0  0  0 89736 417648 1696504 120  1042  539 1340   9  10  81| 14.41
47| 0  1  0 85284 417764 1696692  21   852  452 1329   6  11  83| 13.34
52| 0  0  0 81272 417856 1696992  68   826  499 1552  16  12  72| 12.35
57| 0  0  0 80984 417972 1697520  22  1312  469 1223   7  10  83| 11.52
02| 0  1  2 70984 418476 1697876  38  3401  633 1530  10  11  79| 10.92
07| 0  0  0 67976 418692 1697556  13  1651  510 1444  15  11  74| 10.04
12| 1  0  0 61576 418880 1698244 132  1262  443 1040  13   8  78| 9.40,
17| 2  0  0 59852 419044 1698372  32  1249  473 1060   8   8  84| 8.65,
22| 0  0  0 58108 419268 1698584  31  1198  501 1416   8  10  82| 7.95,
27| 0  0  0 52200 419596 1698988  60  1676  708 2090  10  12  78| 7.56,
32| 0  0  0 51496 419696 1698908  25  1034  487 1280   9  10  81| 6.95,

si and so both remained at 0 the whole time, and swpd was 133920 (eg
something like this)

                               memory    swap    
 time       swpd   free   buff  cache  si  so       uptime
--------|----------------------------------------|------------------
22:54:37| 133920  66440 414628 1691196   0   0   | 2.22, 8.14, 9.14
22:54:42| 133920  66860 414880 1691240   0   0   | 2.04, 8.01, 9.09
22:54:47| 133920  69736 415008 1691384   0   0   | 1.95, 7.89, 9.05

The thing is, I can't see any reason for the load to suddenly jump from
1.37 to 17.03. Apparently there's no sudden disk activity and no sudden
CPU activity.

A few minutes later, another one of these occurs, but there's some other
odd data this time. (Again, I've removed the swap columns as there was
no swap activity at all)

      procs              memory        io     system   cpu
t   r  b  w  free   buff  cache  bi    bo   in    cs  us  sy  id uptime
--|-------------------------------------------------------------|------
17| 0  0  0 38944 425788 1708248  23   702  478 1284  11   9  80| 1.47,
22| 2  0  0 47908 426068 1708900  95  1723  594 1585   9  11  80| 1.35,
27| 0  0  0 41924 426308 1708892  66  1318  586 1625  19  11  70| 1.24,
32| 0  0  0 45108 426468 1705684  14  1099  463 1190  13   9  77| 1.30,
37| 0  0  0 45968 426536 1705760  13   864  372  651   4   7  89| 1.28,
42| 0  0  0 45776 426672 1706032  53  1003  461 1312   6  10  84| 1.17,
47| 0  0  1 44728 426824 1706116   7  1301  598 1884  10  11  79| 1.16,
52| 0  0  0 40880 427004 1706628  96  1015  496 1590   7  11  82| 1.07,
57| 1  0  0 33404 427128 1706720   8  1317  479 1309   6  11  84| 1.06,
02| 2  4  1 21756 427252 1707280  34  1514  757 2066  22  14  63| 0.98,
07| 2  0  0 14236 427612 1710672 392  2638 1231 2735  30  16  55| 18.11
12| 0  0  0 12528 426288 1706112  63  1680  563 1595  13  11  77| 17.22
17| 1  1  1 12140 424696 1704576  32  1301  567 1726  12  14  74| 15.84
22| 0  1  0 22780 425172 1704492 110  1672  796 1879  14  13  73| 14.58
27| 0 17  2 21548 425888 1704576 130   730  417 1031   4   9  87| 13.49
50| 0  1  1 18520 420628 1686628 205  3357 1790 5404   7  10  83| 12.49
55| 0  1  0 32572 420780 1686712  14  1289  584 1527   6  11  83| 14.45
00| 1  0  0 47324 420952 1686768  16  1051  493 1425   9  10  81| 18.50
05| 0  0  0 60980 421188 1687064  77  1005  611 2066   6  15  79| 23.74
10| 0  0  0 59368 421404 1687412  83  1178  600 2049  12  13  75| 22.32
15| 0  0  0 58788 421564 1687976  69  1559  612 1800  11  14  75| 20.62
20| 0  1  0 69484 421760 1688064  30  1342  499 1103  11  10  80| 19.04
25| 0  6  1 61256 421996 1688192  21  1313  530 1170   7  10  83| 17.52
30| 0 36  2 57648 421996 1688216   2    47  303  882   6   8  86| 16.12
35| 0 59  2 46020 422004 1688232   2     0  181  577   3   7  91| 14.83
40| 0 88  2 28064 422004 1688240   0     1  168  958   2   8  90| 13.64
45| 1  3  3 15968 420608 1683860 243  2803 1112 2534  31  19  50| 12.63
50| 0  0  0 36720 420812 1684072  57  1366  584 1596   8  11  80| 12.41
55| 0  1  0 54364 420960 1684360  22   971  541 1704   6  13  81| 14.78
00| 1  0  0 69724 421160 1684328  39   886  426 1371   7   8  85| 18.64
05| 0  0  0 64868 421360 1689448 158  3040  564 1279   6   9  84| 24.28
10| 0  0  0 59380 421460 1689756  53  1813  479 1492  11  13  76| 22.41
15| 0  1  0 62732 421544 1689860  16  1057  373  968   5  10  85| 20.62
20| 0  0  0 62560 421636 1689956  44   959  371 1048   6   9  85| 18.97
25| 0 20  2 59552 421836 1690344  46   950  467 1264   6   9  85| 17.45

Notice the sudden jump again, and this time there is I/O associated with
it, but not what I'd call an excessive amount. But then look 1 minute
later. All the IO activity drops off, lots of processes in the
uninterruptable state, but nothing special happening to the load,
before everything starts firing up again. I thought maybe these had
got out of sync, but I double checked, and each of these lines is
basically being dumped around the same time.

I did one more run, this time doing a dump every 1 second to see if
there was any more detail

 1  0  1 1393908 440380 1070184    0  1044  376  1405   9  8  83| 0.49,
 0  0  0 1393432 440384 1070264    0   760  508   771  15  5  80| 0.49,
 0  0  0 1392728 440384 1070280    0   316  292  1439   2  8  91| 0.45,
 0  0  0 1392656 440384 1070288    0   700  348   540   4  6  90| 0.45,
 0  0  0 1393772 440384 1070296    0   396  343  1294   1  9  90| 0.45,
 0  0  0 1393616 440384 1070332   24  1052  550   735   9  5  85| 0.45,
 0  0  0 1392096 440384 1070308    4  1216  543  1951   9 10  80| 0.45,
 2  0  0 1391060 440384 1070320    0   700  620  1896  15 10  75| 0.82,
 1  1  0 1390360 440404 1070380   64  1648  589  1431   7  8  85| 0.82,
 0  0  0 1390012 440432 1070580  116  1520  666  1567  14  9  77| 0.82,
 0  0  0 1389732 440432 1070592    8   852  347   623   5  3  92| 0.82,
 1  0  0 1390420 440432 1070604    0  1084  372   859   2  6  92| 0.82,
 0  0  0 1390104 440436 1070624    8  1004  493  1276   9  7  84| 17.33
 0  0  0 1390388 440436 1070628    0   656  369  1067   5  5  90| 17.33
 0  0  0 1390712 440436 1070636    4  1024  508  1226  10  8  82| 17.33
 0  0  0 1390324 440452 1070660   20  1200  434  1480   6  7  87| 17.33
 0  0  0 1389388 440452 1070672    0  1044  458  1403   9  8  83| 17.33
 0  0  0 1403856 440452 1070660    0   492  462   997  15  6  79| 15.94
 0  0  0 1403744 440476 1070736   84  1236  442  1230   1 10  89| 15.94
 2  0  1 1402648 440476 1070728    0  1200  567  1574  10  9  81| 15.94
 0  1  0 1400692 440524 1071960 1232  1216  725  1771  14 12  74| 15.94
 0  0  0 1399144 440560 1073840 1892  1252  839  2063  11 10  79| 15.94
 1  0  0 1399112 440564 1073832    4   712  404   986   1  7  92| 14.74
 0  0  0 1399888 440564 1073840   32   608  575  1015  13  6  81| 14.74
 1  0  0 1399240 440564 1073836    0   856  541  1249   6  6  88| 14.74
 0  0  0 1398340 440564 1073844    0  1368  790  1872  19 11  70| 14.74
 0  0  0 1397800 440584 1073916   68  1196  597  1440   5  8  87| 14.74
 0  0  0 1397836 440584 1073996   92   608  456   896   2  6  93| 13.56
 0  0  0 1397764 440584 1073992    0   756  422   953   0  7  93| 13.56

About 10 seconds after the spike, there's a big IO batch, coincidence?
Could that have something to do with it? Why was there nothing like
that in the first list?

Machine usage:
This server is being used as both an IMAP server and a web server. We're
using Apache 1.3.27 with mod_perl as the web-server, and Cyrus 2.1.7 as
the IMAP server. We use Apache/mod_accel and perdition on another machine
to act as web/imap proxies to the appropriate backend machine (of which
this is just 1 of them). The server never appears to be CPU bound by a
long way (usually 80% idle on both CPUs).

Specification:
Dual AMD Athlon 2000+ MP
Tyan Motherboard
4GB RAM
LSI Logic MegaRAID Express 500 Raid Controller
5x76 GB HD's in RAID5 config

Kernel: (lines I thought relevant from /var/log/dmesg)
Linux version 2.4.19 (root@server5.fastmail.fm) (gcc version 2.96 20000731
(Red Hat Linux 7.3 2.96-112)) #2 SMP Mon Oct 7 18:18:45 CDT 2002
megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001)
scsi0 : LSI Logic MegaRAID h132 254 commands 16 targs 4 chans 7 luns
kjournald starting.  Commit interval 5 seconds

Kernel command line: ro root=/dev/sda2 rootflags=data=journal noapic

Typical 'top' output:
  4:49am  up  3:13,  2 users,  load average: 10.60, 11.69, 12.73
1016 processes: 1015 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states: 13.1% user,  6.2% system,  0.0% nice, 80.1% idle
CPU1 states:  9.1% user,  9.5% system,  0.0% nice, 80.4% idle
Mem:  3873940K av, 2729812K used, 1144128K free,       0K shrd,  456512K
buff
Swap: 1052248K av,       0K used, 1052248K free                 1209064K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  798 nobody    10   0 31356  30M 20844 S     4.5  0.8   0:01 httpd
32296 root      16   0  1572 1572   736 R     4.4  0.0   0:21 top
  601 nobody    10   0 31772  31M 19472 S     3.4  0.8   0:03 httpd
  607 nobody    10   0 31684  30M 20296 S     2.1  0.8   0:03 httpd
 1093 cyrus      9   0 14392  14M 14088 S     2.1  0.3   0:00 imapd
32477 cyrus      9   0 14356  14M 14052 S     1.9  0.3   0:00 imapd
 1007 cyrus      9   0 14256  13M 13952 S     1.7  0.3   0:00 imapd
 1097 cyrus      9   0 14216  13M 13920 S     1.7  0.3   0:00 imapd
   10 root      11   0     0    0     0 SW    1.1  0.0   1:11 kjournald
  941 nobody     9   0 30556  29M 20896 S     1.1  0.7   0:00 httpd
  608 nobody     9   0 29740  29M 20408 S     0.9  0.7   0:02 httpd
  745 nobody     9   0  5236 5236  1528 S     0.5  0.1   0:44 rated.pl
 1441 postfix    9   0  1356 1356  1000 S     0.5  0.0   0:05 qmgr
 1452 nobody     5 -10  4668 4668  1572 S <   0.5  0.1   0:27 imappool.pl
30613 cyrus     10   0  7120 7120  5228 S     0.5  0.1   0:02 saslperld.pl
 1094 cyrus      9   0  1596 1592  1296 S     0.5  0.0   0:00 imapd
    7 root      11   0     0    0     0 SW    0.3  0.0   0:44 kupdated
  808 cyrus     15   0  1364 1364   844 S     0.3  0.0   0:18 master
 1114 cyrus     11   0  1232 1228   980 S     0.3  0.0   0:00 pop3d

(this doesn't change radically, whether the load is in a low spot or
a high spot)

/proc/meminfo output:
[root@server5 flush]# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  3966914560 2814578688 1152335872        0 468127744 1246683136
Swap: 1077501952        0 1077501952
MemTotal:      3873940 kB
MemFree:       1125328 kB
MemShared:           0 kB
Buffers:        457156 kB
Cached:        1217464 kB
SwapCached:          0 kB
Active:        1062396 kB
Inactive:      1461100 kB
HighTotal:     3006400 kB
HighFree:       937256 kB
LowTotal:       867540 kB
LowFree:        188072 kB
SwapTotal:     1052248 kB
SwapFree:      1052248 kB

Other:
All syslog files are async (- prefix)

Filesystem is ext3 with one big / partition (that's a mistake
we won't repeat, but too late now). This should be mounted
with data=journal given the kernel command line above, though
it's a bit hard to tell from the dmesg log:

EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with journal data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding Swap: 1052248k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

We've tried enabling the write-back mode on the SCSI controller.
Unfortunately the box is in a colo, so we can only take their
word that they've enabled it in the bios, even though when we
do:

[root@server5 flush]# scsiinfo -c /dev/sda

Data from Caching Page
----------------------
Write Cache                        0
Read Cache                         1
Prefetch units                     0
Demand Read Retention Priority     0
Demand Write Retention Priority    0
Disable Pre-fetch Transfer Length  0
Minimum Pre-fetch                  0
Maximum Pre-fetch                  0
Maximum Pre-fetch Ceiling          0

We're not convinced...

We've also tuned the bdflush parameters a few times. Based on this
article:
http://www-106.ibm.com/developerworks/linux/library/l-fs8.html?dwzone=linux

[root@server5 hm]# cat /proc/sys/vm/bdflush
39      500     0       0       60      300     60      0       0

We also tried playing around with these somemore, lowering the 
nfract and age_buffer and ndirty values, but none of it seemed to
make any difference.

If anyone has any clues as to what might be causing this, and what to
do about it, we'd really appreciate some information. At the moment
we're at a complete loss about where to go from here. Happy to supply
any extra info that people might think would be helpful.

Rob Mueller

