Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTEaQTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264381AbTEaQTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:19:44 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:11426 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264372AbTEaQTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:19:38 -0400
Date: Sat, 31 May 2003 12:33:52 -0400
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARKS] 2.5.70 for 4 filesystems
Message-ID: <20030531163339.GA9426@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary: jfs had unkillable dbench processes.  I've seen dbench have 
some processes not exit (various filesystems) in recent 2.5.x.  
This was the first time they were unkillable.

Every filesystem was best in at least one test.  Filesystems
exhibit very different performance characteristics for some
workloads.  For these benchmarks, xfs with non-default mkfs/mount 
options is impressive.

Same LUN (hardware RAID 0) and partition used for each filesystem.
QLogic 2200 Fibre channel.
Quad P3 700 Xeon with 3.75 GB RAM.
System not rebooted between filesystem runs.

mkfs commands
mke2fs -q /dev/sdc1
mke2fs -q -j -J size=400 /dev/sdc1
yes  "y" | mkreiserfs /dev/sdc1 >/tmp/mkr.out 2>&1
mkfs.xfs -l size=32768b -f /dev/sdc1

mount commands
mount -t ext2     -o defaults,noatime /dev/sdc1 /fs1
mount -t ext3     -o defaults,noatime,data=writeback /dev/sdc1 /fs1
mount -t reiserfs -o defaults,noatime,notail /dev/sdc1 /fs1
mount -t xfs      -o logbufs=8,logbsize=32768,noatime /dev/sdc1 /fs1


dbench executed 5 times.  Numbers are in MB/second.

dbench 64 processe    Average		High		Low
2.5.70-ext2            254.37		255.86		252.54 MB/sec
2.5.70-xfs             143.46		144.41		142.73
2.5.70-ext3            123.77		127.68		115.50
2.5.70-reiserfs        104.46		118.11		 93.33


dbench 192 processes    Average		High		Low
2.5.70-ext2         	218.44		241.18		196.96 MB/sec
2.5.70-xfs          	114.43		115.53		113.20
2.5.70-ext3         	101.56		115.24		 91.38
2.5.70-reiserfs     	 70.44		 74.01		 66.81


bonnie++-1.02c with 8192 MB filesize

                   --------------------- Sequential Output ------------------
                   ---- Per Char -----  ------ Block -----  ---- Rewrite ----
Kernel             MB/sec   %CPU   Eff  MB/sec   %CPU  Eff  MB/sec  %CPU  Eff
2.5.70-ext2          9.42   99.0  9.51   69.42   53.0  131   16.02  17.0   94
2.5.70-xfs           9.34   99.0  9.44   62.81   51.3  122   16.02  18.3   87
2.5.70-ext3          8.64   95.0  9.10   59.80   70.0   85   16.15  18.0   90
2.5.70-reiserfs      9.06   95.3  9.51   49.64   65.0   76   16.59  21.0   79


                   -------- Sequential Input ----------   ----- Random -----
                   ---- Per Char ---  ----- Block -----   ----- Seeks  -----
Kernel             MB/sec  %CPU  Eff  MB/sec  %CPU  Eff    /sec  %CPU   Eff
2.5.70-ext2          9.28  98.7  9.4   27.06  19.7  138   488.1  3.00  16269
2.5.70-xfs           9.26  98.7  9.4   27.02  20.0  135   643.0  4.00  16076
2.5.70-ext3          9.33  99.0  9.4   27.01  19.3  140   457.7  3.00  15256
2.5.70-reiserfs      9.18  98.0  9.4   26.87  21.7  124   491.1  3.00  16371


bonnie++-1.02c with 65536 small files

reiserfs and xfs create small files faster than ext2 and ext3
but are slower at deleting them.


                  --------------- Sequential ----------
                  ----- Create -----   ---- Delete ----
                   /sec  %CPU    Eff   /sec  %CPU   Eff
2.5.70-reiserfs    7584  86.7   8751   2628  37.3  7038
2.5.70-xfs         1710  39.3   4347   2053  28.3  7247
2.5.70-ext2         150  99.0    151  60883 100.0  6088
2.5.70-ext3         119  95.0    126  26319  87.7  3002


Random small file create performance is similar to sequential.
Random small file deletes are a lot slower on ext2/ext3
compared to sequential deletes.

                    ------------- Random --------------
                    ----- Create ----  ---- Delete ----
                     /sec  %CPU   Eff  /sec  %CPU   Eff
2.5.70-reiserfs      6666  79.3  8402   956  17.0  5622
2.5.70-xfs           1701  35.7  4770  1277  20.0  6385
2.5.70-ext2           152  99.0   154   534  99.0   540
2.5.70-ext3           119  95.0   125   434  91.3   475

tiobench-0.3.3
Unit information
================
File size = 8192 megabytes
Blk Size  = 4096 bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

Sequential Reads
                    Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel              Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
------------------  ---  ------------------------------------------------------------
2.5.70-ext2           1   28.92 13.54%     0.402      670.39  0.00000  0.00000    214
2.5.70-ext3           1   28.91 13.51%     0.402      696.75  0.00000  0.00000    214
2.5.70-xfs            1   28.59 13.71%     0.407      738.63  0.00000  0.00000    208
2.5.70-reiserfs       1   28.42 15.07%     0.410       73.45  0.00000  0.00000    188

2.5.70-xfs            8   55.60 28.80%     1.616      757.41  0.00000  0.00000    193
2.5.70-ext2           8   36.13 18.05%     2.578      967.76  0.00000  0.00000    200
2.5.70-reiserfs       8   31.26 18.04%     2.973      265.99  0.00000  0.00000    173
2.5.70-ext3           8   17.27 11.90%     5.278     3321.04  0.00000  0.00000    145

2.5.70-xfs           16   50.52 25.77%     3.532      877.59  0.00000  0.00000    196
2.5.70-ext2          16   30.83 15.31%     6.012     1149.26  0.00000  0.00000    201
2.5.70-reiserfs      16   26.98 15.44%     6.884      594.97  0.00000  0.00000    175
2.5.70-ext3          16   12.15  8.84%    14.936     5434.13  0.00033  0.00000    137

2.5.70-xfs           32   49.41 25.84%     7.477     1154.73  0.00000  0.00000    191
2.5.70-ext2          32   28.38 13.84%    13.084     1523.90  0.00000  0.00000    205
2.5.70-reiserfs      32   27.90 15.32%    13.309     1337.08  0.00000  0.00000    182
2.5.70-ext3          32    8.47  7.83%    40.867    15191.64  0.07029  0.00000    108

2.5.70-xfs           64   46.24 24.20%    15.655     1618.93  0.00000  0.00000    191
2.5.70-ext2          64   27.78  9.18%    25.852    29261.64  0.09457  0.00005    303
2.5.70-reiserfs      64   27.07  9.41%    26.668    36274.53  0.15678  0.00053    287
2.5.70-ext3          64    8.18  7.95%    78.515    32956.01  1.30109  0.00024    103

2.5.70-xfs          128   47.28 24.68%    30.299     8088.06  0.00048  0.00000    192
2.5.70-ext2         128   31.29 11.40%    40.825    76550.19  0.34548  0.03205    274
2.5.70-reiserfs     128   27.95 10.24%    46.841    88666.98  0.50650  0.04029    273
2.5.70-ext3         128    8.07 10.04%   147.272    55941.86  2.85859  0.04143     80

2.5.70-xfs          256   47.72 24.96%    52.069   185880.04  0.21720  0.07501    191
2.5.70-ext2         256   34.82 13.95%    66.450   134454.22  0.57445  0.13957    249
2.5.70-reiserfs     256   26.39 10.16%    98.556   129873.62  1.11609  0.23409    260
2.5.70-ext3         256    8.08 15.67%   285.410   108616.57  3.94969  0.69022     52



Random Reads
                    Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel              Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
------------------  ---  ------------------------------------------------------------
2.5.70-xfs            1    1.04  0.95%    11.229       61.99  0.00000  0.00000    110
2.5.70-reiserfs       1    0.96  1.01%    12.233      109.56  0.00000  0.00000     95
2.5.70-ext3           1    0.90  0.90%    13.025       78.39  0.00000  0.00000    100
2.5.70-ext2           1    0.84  0.80%    13.987       69.70  0.00000  0.00000    105

2.5.70-xfs            8    5.23  4.56%    16.663      109.98  0.00000  0.00000    115
2.5.70-ext3           8    5.07  4.62%    16.711      105.20  0.00000  0.00000    110
2.5.70-reiserfs       8    4.86  5.46%    17.939      121.22  0.00000  0.00000     89
2.5.70-ext2           8    4.31  4.46%    20.156      135.14  0.00000  0.00000     97

2.5.70-ext3          16    5.46  4.40%    29.942      166.29  0.00000  0.00000    124
2.5.70-xfs           16    5.46  4.30%    32.314      181.00  0.00000  0.00000    127
2.5.70-reiserfs      16    4.80  4.71%    36.803      208.73  0.00000  0.00000    102
2.5.70-ext2          16    4.48  3.85%    39.028      201.53  0.00000  0.00000    116

2.5.70-xfs           32    5.58  5.34%    61.650      208.50  0.00000  0.00000    104
2.5.70-ext3          32    5.50  4.81%    55.804      225.78  0.00000  0.00000    114
2.5.70-reiserfs      32    4.78  4.85%    72.547      336.00  0.00000  0.00000     98
2.5.70-ext2          32    4.51  4.24%    78.365      350.57  0.00000  0.00000    106

2.5.70-ext3          64    5.16  4.54%   109.937      401.81  0.00000  0.00000    114
2.5.70-xfs           64    4.89  4.31%   133.968      384.25  0.00000  0.00000    113
2.5.70-ext2          64    4.87  4.50%   139.364      631.17  0.00000  0.00000    108
2.5.70-reiserfs      64    4.70  5.19%   139.623      676.06  0.00000  0.00000     90

2.5.70-ext3         128    5.49  5.19%   203.859      700.59  0.00000  0.00000    106
2.5.70-reiserfs     128    5.25  5.59%   220.590     1291.70  0.00000  0.00000     94
2.5.70-ext2         128    5.23  5.39%   222.819     1656.22  0.00000  0.00000     97
2.5.70-xfs          128    5.12  4.83%   244.213      693.75  0.00000  0.00000    106

2.5.70-ext3         256    5.66  5.96%   340.087     5869.11  0.00000  0.00000     95
2.5.70-reiserfs     256    5.39  6.49%   366.114     6565.36  0.39063  0.00000     83
2.5.70-ext2         256    5.30  5.57%   358.209     6453.99  0.44271  0.00000     95
2.5.70-xfs          256    4.91  4.87%   397.934     6717.78  1.01562  0.00000    101

Sequential Writes

xfs max latency starts is higher than other filesystems when thread count is low,
when thread count is high, xfs max latency is lowest.

                    Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel              Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
------------------  ---  ------------------------------------------------------------
2.5.70-ext2           1   56.39 41.44%     0.170     2238.18  0.00000  0.00000    136
2.5.70-xfs            1   56.14 46.50%     0.175    69039.98  0.00030  0.00030    121
2.5.70-reiserfs       1   54.77 90.98%     0.202     1959.03  0.00000  0.00000     60
2.5.70-ext3           1   52.89 61.79%     0.210    15213.72  0.00114  0.00000     86

2.5.70-xfs            8   58.01 70.52%     1.090   148705.27  0.00535  0.00315     82
2.5.70-ext2           8   33.64 31.92%     2.221    32241.37  0.03910  0.00020    105
2.5.70-reiserfs       8   26.10 105.9%     3.147    99959.42  0.02638  0.00497     25
2.5.70-ext3           8    3.37  5.67%    21.474   225029.19  0.08302  0.05707     59

2.5.70-xfs           16   57.48 78.49%     2.146   194628.15  0.00901  0.00525     73
2.5.70-ext2          16   32.77 33.64%     4.280    67553.19  0.05822  0.00529     97
2.5.70-reiserfs      16   26.16 110.4%     5.933   112234.69  0.04840  0.00963     24
2.5.70-ext3          16    2.39  4.40%    62.682   511062.66  0.16084  0.09003     54

2.5.70-xfs           32   57.69 83.55%     4.459   236439.33  0.02103  0.01159     69
2.5.70-ext2          32   28.81 32.52%     9.324   151405.98  0.08040  0.03066     89
2.5.70-reiserfs      32   28.47 106.6%     9.921   108081.18  0.10381  0.02303     27
2.5.70-ext3          32    2.11  4.89%   135.246   948909.66  0.29182  0.13547     43

2.5.70-xfs           64   57.46 84.46%     8.238   272236.51  0.04845  0.01850     68
2.5.70-ext2          64   28.86 36.76%    18.376   219132.56  0.13365  0.06003     78
2.5.70-reiserfs      64   26.48 104.7%    20.644   221498.65  0.13495  0.06079     25
2.5.70-ext3          64    1.99  5.29%   276.918  1696330.83  0.50163  0.24386     38

2.5.70-xfs          128   57.18 85.25%    16.545   276182.86  0.11464  0.04244     67
2.5.70-ext2         128   31.83 40.35%    29.891   406660.86  0.20223  0.08163     79
2.5.70-reiserfs     128   26.53 114.8%    38.856   306137.57  0.29292  0.10090     23
2.5.70-ext3         128    2.09  6.28%   492.454  3187897.55  0.88648  0.53048     33

2.5.70-xfs          256   56.39 83.96%    29.725   351180.99  0.16737  0.07796     67
2.5.70-ext2         256   35.58 49.97%    51.891   493133.54  0.30092  0.13971     71
2.5.70-reiserfs     256   21.33 161.4%    97.778   504849.92  0.82383  0.21262     13
2.5.70-ext3         256    2.32 11.65%   830.694  4474318.91  1.66059  1.01834     20



Random Writes
                    Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel              Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
------------------  ---  ------------------------------------------------------------
2.5.70-xfs            1    3.91  3.74%     0.076        1.55  0.00000  0.00000    105
2.5.70-ext2           1    3.30  3.06%     0.622       57.66  0.00000  0.00000    108
2.5.70-reiserfs       1    2.83  3.22%     1.218      430.83  0.00000  0.00000     88
2.5.70-ext3           1    2.06  2.26%     2.764      457.66  0.00000  0.00000     91

2.5.70-ext2           8    3.79  6.12%     1.377       76.30  0.00000  0.00000     62
2.5.70-reiserfs       8    3.56  3.81%     3.918     1119.27  0.00000  0.00000     93
2.5.70-ext3           8    3.47  6.20%     3.609      114.94  0.00000  0.00000     56
2.5.70-xfs            8    3.26  5.46%     0.708     1864.91  0.00000  0.00000     60

2.5.70-ext2          16    3.79  4.20%     2.223      410.09  0.00000  0.00000     90
2.5.70-reiserfs      16    3.62  3.82%     7.063     1291.33  0.00000  0.00000     95
2.5.70-xfs           16    3.49  7.84%     0.454     1143.64  0.00000  0.00000     44
2.5.70-ext3          16    3.43  5.51%     6.481      835.05  0.00000  0.00000     62

2.5.70-xfs           32    3.77  6.66%     0.349      448.57  0.00000  0.00000     57
2.5.70-reiserfs      32    3.76  3.74%     7.401     3053.12  0.02500  0.00000    100
2.5.70-ext2          32    3.71  4.37%     2.026      296.68  0.00000  0.00000     85
2.5.70-ext3          32    3.59  7.92%     7.573      907.51  0.00000  0.00000     45

2.5.70-ext2          64    3.81  5.23%     2.277      387.93  0.00000  0.00000     73
2.5.70-reiserfs      64    3.78  6.02%     5.438      866.49  0.00000  0.00000     63
2.5.70-xfs           64    3.74  7.29%     0.222      184.15  0.00000  0.00000     51
2.5.70-ext3          64    3.56  8.74%    10.799     1276.71  0.00000  0.00000     41

2.5.70-ext2         128    3.86  6.83%     2.844     4862.76  0.02520  0.00000     56
2.5.70-reiserfs     128    3.85  9.40%     4.324     2293.99  0.00000  0.00000     41
2.5.70-ext3         128    3.68 12.35%    10.807      873.82  0.00000  0.00000     30
2.5.70-xfs          128    3.63  6.93%     2.272     7922.55  0.07560  0.00000     52

2.5.70-ext2         256    3.62  6.43%     6.602     8693.57  0.05208  0.00000     56
2.5.70-ext3         256    3.56 16.74%    39.608     1447.47  0.00000  0.00000     21
2.5.70-reiserfs     256    3.47  6.57%    11.627     3941.93  0.00000  0.00000     53
2.5.70-xfs          256    3.42  6.56%     2.040     3681.95  0.02604  0.00000     52

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

