Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSLJNAx>; Tue, 10 Dec 2002 08:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSLJNAx>; Tue, 10 Dec 2002 08:00:53 -0500
Received: from unknown.Level3.net ([63.210.233.154]:37445 "EHLO
	cinshrexc03.shermfin.com") by vger.kernel.org with ESMTP
	id <S261371AbSLJNAt> convert rfc822-to-8bit; Tue, 10 Dec 2002 08:00:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FW: Poor performance, high disk queue on software RAID partition
Date: Tue, 10 Dec 2002 08:08:32 -0500
Message-ID: <8075D5C3061B9441944E137377645118012DD3@cinshrexc03.shermfin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Poor performance, high disk queue on software RAID partition
Thread-Index: AcKdc+D5MyCb73gDThOmhqhHFNvdMgC2K+ug
From: "Rechenberg, Andrew" <arechenberg@shermfin.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted this issue to a couple of lists (linux-raid, redhat-list,
linux-poweredge) and have gotten a few responses, but none that really
point to a culprit.  One of them suggested the issue may be
kernel-related so I'm forwarding this mail to the list.

If anyone can provide any assistance, I would be indebted.

Thanks,
Andy.

-----Original Message-----
From: Rechenberg, Andrew 
Sent: Friday, December 06, 2002 5:08 PM
To: linux-poweredge@dell.com; 'redhat-list@redhat.com';
'linux-raid@vger.kernel.org'
Subject: Poor performance, high disk queue on software RAID partition


I have a Dell PowerEdge 6600, quad Xeon 1.4GHz, HT enabled, 8GB RAM,
with a PERC3/QC attached to two Dell PowerVault 220S disk SCSI disk
arrays.  The PERC is doing hardware RAID1 across twenty-four 36GB 15K
SCSI disks (12 RAID1 arrays).  Due to limitations with the PERC
firmware, I am running Linux software RAID0 across those 12 RAID1
arrays, effectively creating a RAID10 array.  There is an ext3
filesystem on top of this md device (/dev/md0) in data=ordered mode.
The box is running a standard Red Hat 7.3 installation with updates, and
kernel 2.4.18-17.7.xbigmem

The database system running on this box is IBM (Ardent/Informix)
UniVerse.  The application running on top of UniVerse accesses 25-30
large files (1-1.8GB) on a consistent basis.  All ~400 users, plus any
batch processes, access these files, sometimes simultaneously (poor
application IMO).

Lately we've double the number of records in those database files and
now there seems to be some serious problems with disk I/O.  The system
is hardly swapping at all, but the average disk queue and the average
wait time for I/O are both WAY out of wack.  If I'm reading iostat
correctly some disks are waiting up to 6000ms for I/O!?!?!  There is
nothing in 'top' that shows any process consuming more than about 60% of
one CPU.

Some stats from my box are provided below.  The first iostat is since
the system booted.  The second iostat is a sample from a 'iostat -x 1
10'

Is there any advice from the gurus out there as to where to turn next?
Would FiberChannel HBA's and drives help out any?  Is there any
kernel/filesystem tuning I could perform to help out?  If anyone needs
any information which I have forgotten, please let me know.

Thanks for your help,
Andy.


[root@mybox ~]# uname -a
Linux mybox.shermfin.com 2.4.18-17.7.xbigmem #1 SMP Tue Oct 8 12:07:59
EDT 2002 i686 unknown

[root@mybox ~]# free
             total       used       free     shared    buffers
cached
Mem:       7483280    7471648      11632          0      52812
6957472
-/+ buffers/cache:     461364    7021916
Swap:      2048248      27916    2020332

[root@mybox ~]# cat /proc/sys/vm/bdflush
40      10      0       0       60      512     60      0       0

[root@mybox ~]# vmstat 1 10
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 0  6  1  27448  12092  57000 6957196   0   0     0     3   11    14  10
10   1
 0  6  1  27448  11896  57088 6958428   0   0  1504 12536 2026   712   2
7  91
 0  6  1  27448  10668  56168 6959276   0   0  1112 13376 1806   562   2
4  94
 0  6  0  27448  11892  56248 6958616   0   0  1260  8144 2076   761   2
3  96
 0  6  1  27448  12352  56344 6958800   0   0  1792 12696 1977   897   2
5  93
 0  6  1  27448  13268  56432 6958956   0   0  1608 12636 1992   676   2
7  91
 1  6  1  27448  13316  56504 6959908   0   0  1216  9488 1922   528   2
5  93
 0  6  0  27448  11568  55464 6960596   0   0  2532 12048 2234  1218   3
7  90
 1  5  0  27448  12852  55552 6958104   0   0  1324 10620 2005   746   1
3  96
 0  6  1  27448  11772  55632 6959992   0   0  2504 14000 2004  1032   3
9  87


[root@mybox ~]# iostat -x
Linux 2.4.18-17.7.xbigmem (mybox.shermfin.com)    12/06/2002

avg-cpu:  %user   %nice    %sys   %idle
           9.31    0.66    9.94   80.09

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util
/dev/sda     2.25  17.49  1.66 19.56   28.36  297.10    14.18   148.55
15.33     0.22   12.52   6.23   1.32
/dev/sda1    0.34   0.00  0.03  0.00    0.72    0.01     0.36     0.00
27.66     0.00   54.88   9.87   0.00
/dev/sda5    0.04   7.29  0.03  5.28    0.49  101.71     0.25    50.86
19.25     0.15   13.13  32.48   1.72
/dev/sda6    1.54   1.64  1.11  2.55   20.86   33.18    10.43    16.59
14.76     0.00   35.58  25.23   0.92
/dev/sda7    0.18   2.48  0.20  5.55    2.66   63.92     1.33    31.96
11.57     0.02   23.66  35.51   2.04
/dev/sda8    0.00   0.21  0.12  0.02    0.93    1.82     0.46     0.91
20.36     0.03  227.99  22.47   0.03
/dev/sda9    0.15   5.87  0.18  6.16    2.69   96.46     1.35    48.23
15.64     0.03   22.68  20.08   1.27
/dev/sdb   107.30 343.83 11.74 20.33  952.36 2919.18   476.18  1459.59
120.72     0.09    4.71   5.89   1.89
/dev/sdb1  107.30 343.83 11.74 20.33  952.36 2919.18   476.18  1459.59
120.72     0.24    4.71   3.86   1.24
/dev/sdc    47.55  68.38 36.92 84.22  675.77 1224.12   337.88   612.06
15.68     0.10    2.92   1.39   1.69
/dev/sdc1   47.55  68.38 36.92 84.22  675.77 1224.12   337.88   612.06
15.68     0.09    2.92   0.61   0.74
/dev/sdd    47.56  71.20 37.02 73.78  676.68 1169.03   338.34   584.52
16.66     0.03    1.96   2.12   2.35
/dev/sdd1   47.56  71.20 37.02 73.78  676.68 1169.03   338.34   584.52
16.66     0.07    1.96   0.05   0.06
/dev/sde    47.57  70.71 36.86 64.76  675.44 1092.64   337.72   546.32
17.40     0.04    4.05   1.99   2.03
/dev/sde1   47.57  70.71 36.86 64.76  675.44 1092.64   337.72   546.32
17.40     0.24    4.05   1.33   1.35
/dev/sdf    47.54  68.05 36.78 64.35  674.59 1066.89   337.30   533.44
17.22     0.15    0.74   1.38   1.40
/dev/sdf1   47.54  68.05 36.78 64.35  674.59 1066.89   337.30   533.44
17.22     0.14    0.74   2.02   2.04
/dev/sdg    47.53  72.40 36.87 65.03  675.21 1112.15   337.60   556.08
17.54     0.05    2.28   1.67   1.70
/dev/sdg1   47.53  72.40 36.87 65.03  675.21 1112.15   337.60   556.08
17.54     0.04    2.28   0.97   0.98
/dev/sdh    47.51  69.04 36.95 71.88  675.75 1137.24   337.88   568.62
16.66     0.10    4.27   0.55   0.60
/dev/sdh1   47.51  69.04 36.95 71.88  675.75 1137.24   337.88   568.62
16.66     0.13    4.27   0.26   0.29
/dev/sdi    47.55  70.55 36.81 66.15  674.85 1105.14   337.42   552.57
17.29     0.15    3.24   2.26   2.33
/dev/sdi1   47.55  70.55 36.81 66.15  674.85 1105.14   337.42   552.57
17.29     0.07    3.24   1.86   1.92
/dev/sdj    47.54  71.97 36.82 72.62  674.89 1161.19   337.44   580.60
16.78     0.04    1.26   2.09   2.29
/dev/sdj1   47.54  71.97 36.82 72.62  674.89 1161.19   337.44   580.60
16.78     0.07    1.26   1.15   1.26
/dev/sdk    47.55  66.96 36.92 72.86  675.80 1125.62   337.90   562.81
16.41     0.12    0.14   2.05   2.25
/dev/sdk1   47.55  66.96 36.92 72.86  675.80 1125.62   337.90   562.81
16.41     0.21    0.14   1.91   2.10
/dev/sdl    47.55  66.37 36.98 61.95  676.19 1038.09   338.09   519.05
17.33     0.19    3.08   1.31   1.29
/dev/sdl1   47.55  66.37 36.98 61.95  676.19 1038.09   338.09   519.05
17.33     0.14    3.08   0.57   0.56
/dev/sdm    47.58  68.40 36.83 79.35  675.24 1189.25   337.62   594.62
16.05     0.14    1.84   1.17   1.36
/dev/sdm1   47.58  68.40 36.83 79.35  675.24 1189.25   337.62   594.62
16.05     0.16    1.84   1.55   1.80
/dev/sdn    47.58  72.05 36.80 92.70  675.04 1321.50   337.52   660.75
15.42     0.11    3.38   1.25   1.63
/dev/sdn1   47.58  72.05 36.80 92.70  675.04 1321.50   337.52   660.75
15.42     0.13    3.38   0.39   0.50
/dev/sdo     0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00
8.00     0.00  150.00 150.00   0.00


avg-cpu:  %user   %nice    %sys   %idle
           1.75    0.00    5.12   93.12

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util
/dev/sda     0.00   2.00  0.00  6.00    0.00   64.00     0.00    32.00
10.67 42948592.96    0.00 1666.67 100.00
/dev/sda1    0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00
0.00     0.00    0.00   0.00   0.00
/dev/sda5    0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00
0.00    20.00    0.00   0.00 100.00
/dev/sda6    0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00
0.00 42949612.96    0.00   0.00 100.00
/dev/sda7    0.00   1.00  0.00  3.00    0.00   32.00     0.00    16.00
10.67 42949662.96    0.00 3333.33 100.00
/dev/sda8    0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00
0.00     0.00    0.00   0.00   0.00
/dev/sda9    0.00   1.00  0.00  3.00    0.00   32.00     0.00    16.00
10.67 42949662.96    0.00 3333.33 100.00
/dev/sdb     0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00
0.00 42949642.96    0.00   0.00 100.00
/dev/sdb1    0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00
0.00 42949662.96    0.00   0.00 100.00
/dev/sdc     7.00 164.00 13.00 55.00  160.00 2152.00    80.00  1076.00
34.00   458.34  328.24 147.06 100.00
/dev/sdc1    7.00 164.00 13.00 55.00  160.00 2152.00    80.00  1076.00
34.00   288.34  328.38 147.06 100.00
/dev/sdd    15.00 162.00 20.00 103.00  288.00 2288.00   144.00  1144.00
20.94 42949518.02 1212.11  81.30 100.00
/dev/sdd1   15.00 162.00 20.00 103.00  288.00 2288.00   144.00  1144.00
20.94   325.06 1212.11  81.30 100.00
/dev/sde    11.00 143.00 18.00 103.00  232.00 2112.00   116.00  1056.00
19.37   347.64 1612.81  82.64 100.00
/dev/sde1   11.00 143.00 18.00 103.00  232.00 2112.00   116.00  1056.00
19.37   147.64 1612.89  70.25  85.00
/dev/sdf    13.00 164.00 30.00 126.00  328.00 2440.00   164.00  1220.00
17.74 42949618.47 1045.06  63.85  99.60
/dev/sdf1   13.00 164.00 30.00 126.00  328.00 2440.00   164.00  1220.00
17.74   315.51 1045.06  64.10 100.00
/dev/sdg     6.00 190.00 22.00 62.00  224.00 2560.00   112.00  1280.00
33.14   455.15  840.83 119.05 100.00
/dev/sdg1    6.00 190.00 22.00 62.00  224.00 2560.00   112.00  1280.00
33.14   215.15  840.71 119.05 100.00
/dev/sdh    12.00 161.00 18.00 62.00  240.00 2312.00   120.00  1156.00
31.90 42949587.08  641.62 124.50  99.60
/dev/sdh1   12.00 161.00 18.00 62.00  240.00 2312.00   120.00  1156.00
31.90 42949567.08  641.50 125.00 100.00
/dev/sdi     7.00 167.00 16.00 100.00  176.00 2328.00    88.00  1164.00
21.59   541.66 2272.07  86.21 100.00
/dev/sdi1    7.00 167.00 16.00 100.00  176.00 2328.00    88.00  1164.00
21.59    91.66 2272.16  84.91  98.50
/dev/sdj     5.00 168.00 14.00 59.00  160.00 2256.00    80.00  1128.00
33.10   108.94 1263.97 125.75  91.80
/dev/sdj1    5.00 168.00 14.00 59.00  160.00 2256.00    80.00  1128.00
33.10    58.94 1263.97 136.44  99.60
/dev/sdk    16.00 147.00 22.00 80.00  312.00 2144.00   156.00  1072.00
24.08   500.53 1574.12  98.04 100.00
/dev/sdk1   16.00 147.00 22.00 80.00  312.00 2144.00   156.00  1072.00
24.08   370.53 1574.22  98.04 100.00
/dev/sdl     5.00 146.00 15.00 96.00  152.00 2032.00    76.00  1016.00
19.68 42949660.85 2192.25  83.42  92.60
/dev/sdl1    5.00 146.00 15.00 96.00  152.00 2032.00    76.00  1016.00
19.68   477.89 2192.16  90.09 100.00
/dev/sdm    15.00 146.00 20.00 125.00  280.00 2216.00   140.00  1108.00
17.21   977.33 2383.52  68.97 100.00
/dev/sdm1   15.00 146.00 20.00 125.00  280.00 2216.00   140.00  1108.00
17.21   347.33 2383.52  68.97 100.00
/dev/sdn     9.00 166.00 13.00 79.00  184.00 2344.00    92.00  1172.00
27.48 42949470.99 1155.00 108.70 100.00
/dev/sdn1    9.00 166.00 13.00 79.00  184.00 2344.00    92.00  1172.00
27.48   178.03 1155.11 108.70 100.00
/dev/sdo     0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00
0.00     0.00    0.00   0.00   0.00



Andrew Rechenberg
Infrastructure Team, Sherman Financial Group
arechenberg@shermanfinancialgroup.com
Phone: 513.707.3809
Fax:   513.707.3838
