Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTDYWun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTDYWun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:50:43 -0400
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:31165 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264515AbTDYWuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:50:37 -0400
Date: Fri, 25 Apr 2003 19:09:39 -0400
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.68 and 2.5.68-mm2
Message-ID: <20030425230939.GA2281@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few benchmarks that have changed dramatically
between 2.5.68 and 2.5.68-mm2.  

Machine is Quad P3 700 mhz Xeon with 1M cache.
3.75 GB RAM.
RAID0 LUN
QLogic 2200 Fiber channel

Some config differences.  2.5.68 has standard Qlogic driver.
2.5.68-mm2 has new Qlogic driver and the 2/2 GB memory split.

Only in 2.5.68
CONFIG_SCSI_QLOGIC_FC=y
CONFIG_SCSI_QLOGIC_FC_FIRMWARE=y
CONFIG_SCSI_QLOGIC_ISP=y

Only in 2.5.68-mm2
CONFIG_2GB=y
CONFIG_DEBUG_INFO=y
CONFIG_NR_SIBLINGS_0=y
CONFIG_SCSI_QLOGIC_ISP_NEW=y
CONFIG_SPINLINE=y

One recent change is -mm2 is 17-19% faster at tbench.  
The logfiles don't indicate any errors.  Wonder what helped?

tbench 192 processes	Average		High		Low
2.5.68-mm2              139.44		142.14		136.77 MB/sec
2.5.68                  118.78		132.41		111.45


tbench 64 processes	Average		High		Low
2.5.68-mm2              136.34		143.66		124.13 MB/sec
2.5.68                  114.30		116.88		111.33

The autoconf-2.53 make/make check is a fork test.   2.5.68
is about 13% faster here.

kernel             average	min_time	max_time
2.5.68               732.8	     729	     738 seconds
2.5.68-mm2           833.3	     824	     841


On the AIM7 database test, -mm2 was about 18% faster and
uses about 15% more CPU time.  (Real and CPU are in seconds).  
The new Qlogic driver helps AIM7.


AIM7 dbase workload
kernel          Tasks  Jobs/Min           Real    CPU    
2.5.68-mm2        32	559.8		 339.6	 164.0	
2.5.68            32	477.1		 398.4	 150.9	

2.5.68-mm2        64	714.1		 532.4	 312.3	
2.5.68            64	608.3		 625.0	 272.4	

2.5.68-mm2        96	785.6		 725.9	 458.8	
2.5.68            96	664.7		 857.8	 393.9	

2.5.68-mm2       128	832.1		 913.8	 640.0	
2.5.68           128	702.3		1082.5	 515.5	

2.5.68-mm2       160	858.5		1107.0	 712.2	
2.5.68           160	726.7		1307.8	 624.2	

2.5.68-mm2       192	880.4		1295.4	 871.1	
2.5.68           192	745.7		1529.5	 763.0	

2.5.68-mm2       224	895.1		1486.5	1005.1	
2.5.68           224	758.0		1755.3	 868.4	

2.5.68-mm2       256	907.8		1675.1	1144.5	
2.5.68           256	767.5		1981.3	 987.2	


On the AIM7 shared test, -mm2 is 15-19% faster and 
uses about 5% more CPU time.

AIM7 shared workload
kernel             Tasks   Jobs/Min        Real    CPU    
2.5.68-mm2          64	2447.0		 152.2	 180.8	
2.5.68              64	2110.4		 176.5	 170.0	

2.5.68-mm2         128	2705.0		 275.4	 357.6	
2.5.68             128	2276.9		 327.2	 337.2	

2.5.68-mm2         192	2708.3		 412.6	 537.5	
2.5.68             192	2265.4		 493.3	 506.8	

2.5.68-mm2         256	2746.1		 542.5	 716.3	
2.5.68             256	2304.7		 646.5	 677.5	

2.5.68-mm2         320	2732.9		 681.5	 900.0	
2.5.68             320	2296.3		 811.0	 849.4	




L M B E N C H  2 . 0   S U M M A R Y
------------------------------------

The lmbench process latency results go along with the autoconf
build results.  


Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
                   fork    execve  /bin/sh
kernel           process  process  process
-------------    -------  -------  -------
2.5.68               243      979     4401
2.5.68-mm2           502     1715     5200

The lmbench context switch tests have an interesting pattern.
With low processes and small packets, 2.5.68 has lower latency.
2.5.68-mm2 turns the table for high process big packet tests.

Context switching with 0K - times in microseconds - smaller is better
---------------------------------------------------------------------
                2proc/0k   4proc/0k   8proc/0k  16proc/0k  32proc/0k  64proc/0k  96proc/0k
kernel         ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
2.5.68              1.32       2.63       2.38       2.41       2.42       2.87       3.79
2.5.68-mm2          6.80       6.97       6.74       6.59       6.43       5.94       6.17

Context switching with 4K - times in microseconds - smaller is better
---------------------------------------------------------------------
                2proc/4k   4proc/4k   8proc/4k  16proc/4k  32proc/4k  64proc/4k  96proc/4k
kernel         ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
2.5.68              1.81       3.53       3.79       4.26       4.62       6.06       8.30
2.5.68-mm2          6.91       7.13       7.29       7.57       7.72       7.38       7.91

Context switching with 8K - times in microseconds - smaller is better
---------------------------------------------------------------------
                2proc/8k   4proc/8k   8proc/8k  16proc/8k  32proc/8k  64proc/8k  96proc/8k
kernel         ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
2.5.68              3.31       5.35       5.16       5.29       6.07      12.05      19.60
2.5.68-mm2          7.20       8.42       8.86       8.87       9.12       9.13      10.51

Context switching with 16K - times in microseconds - smaller is better
----------------------------------------------------------------------
               2proc/16k  4proc/16k  8proc/16k  16prc/16k  32prc/16k  64prc/16k  96prc/16k
kernel         ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
2.5.68              7.46       8.19       8.04       8.49      13.66      37.52      46.99
2.5.68-mm2         10.50      11.46      11.78      11.61      11.89      15.26      24.91

Context switching with 32K - times in microseconds - smaller is better
----------------------------------------------------------------------
               2proc/32k  4proc/32k  8proc/32k  16prc/32k  32prc/32k  64prc/32k  96prc/32k
kernel         ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
2.5.68            12.690     13.520     13.856     19.877     52.473     81.259     83.397
2.5.68-mm2        17.419     17.285     17.212     17.358     20.044     46.069     75.088

Context switching with 64K - times in microseconds - smaller is better
----------------------------------------------------------------------
               2proc/64k  4proc/64k  8proc/64k  16prc/64k  32prc/64k  64prc/64k  96prc/64k
kernel         ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
2.5.68             23.03      24.71      34.03     105.06     155.47     156.37     156.29
2.5.68-mm2         27.81      27.97      28.03      33.67      79.36     154.14     172.09

2.5.68 has lower latency in the local communcation tests.


*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel           Pipe   AF/Unix     UDP   RPC/UDP     TCP   RPC/TCP
2.5.68            9.44    14.25  32.0856  60.1722  39.8264  73.7042
2.5.68-mm2       32.71    48.45  45.4747  65.2766  56.7022  79.7929

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
                                             File     Mmap    Bcopy    Bcopy   Memory   Memory
kernel           Pipe   AF/Unix    TCP     reread   reread   (libc)   (hand)     read    write
2.5.68           511.3    546.9    174.0    296.5    363.9    170.3    172.0    364.9    211.9
2.5.68-mm2       493.2    278.0    167.2    289.2    347.8    160.9    163.1    348.1    199.3

*Local* More Communication bandwidths in MB/s - bigger is better
----------------------------------------------------------------
                  File     Mmap  Aligned  Partial   Partial  Partial  
OS                open     open    Bcopy    Bcopy      Mmap     Mmap    
                 close    close   (libc)   (hand)     write   rd/wrt     HTTP
2.5.68           299.0    286.0    167.8    182.5     212.2    212.7    10.10
2.5.68-mm2       291.9    277.5    159.7    172.4     201.2    200.5     9.82

Memory latencies in nanoseconds - smaller is better
---------------------------------------------------
kernel          Mhz     L1 $     L2 $    Main mem
2.5.68           698     4.35    13.06      165.3
2.5.68-mm2       698     4.33    13.00      173.1



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

One notable difference between -mm2 and 2.5.68 is the CPU% as
thread count goes up.  -mm2 uses less CPU as thread count rises,
and 2.5.68 uses more.  2.5.68 keeps sequential read throughput 
high as threads increase.


Sequential Reads ext2
               Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel         Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
-------------  ---  ------------------------------------------------------------
2.5.68           1   28.77 13.23%     0.405      592.14  0.00000  0.00000    217
2.5.68-mm2       1   28.77 13.80%     0.404      659.18  0.00000  0.00000    208

2.5.68           8   36.65 18.04%     2.542      945.37  0.00000  0.00000    203
2.5.68-mm2       8   23.96 11.15%     3.810     1219.85  0.00000  0.00000    215

2.5.68          16   30.56 14.94%     6.080     1224.19  0.00000  0.00000    204
2.5.68-mm2      16   20.19  9.39%     8.953     2456.76  0.00000  0.00000    215

2.5.68          32   27.74 13.84%    13.376     1498.48  0.00000  0.00000    200
2.5.68-mm2      32   20.15  9.50%    16.728     4424.53  0.00000  0.00000    212

2.5.68          64   28.47 14.54%    25.294     6204.46  0.00005  0.00000    196
2.5.68-mm2      64   19.54  9.40%    32.600    12986.20  0.04410  0.00000    208

2.5.68         128   29.87 14.99%    41.715    17752.22  0.10242  0.00000    199
2.5.68-mm2     128   19.28  9.21%    63.638    57459.95  1.27239  0.01006    209

2.5.68         256   34.10 16.88%    64.697    51122.80  1.16358  0.01163    202
2.5.68-mm2     256   18.84  8.96%   125.350   164470.88  1.43795  0.14148    210


Random Reads throughput on ext2 is a lot higher on 2.5.68.  -mm2 has a bump in
latency as thread count gets very high.

               Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel         Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
-------------  ---  ------------------------------------------------------------
2.5.68           1    0.84  0.75%    14.003      120.98  0.00000  0.00000    111
2.5.68-mm2       1    0.95  0.88%    12.383      121.84  0.00000  0.00000    108

2.5.68           8    4.56  4.29%    19.193      122.64  0.00000  0.00000    106
2.5.68-mm2       8    0.96  0.85%    95.108      715.00  0.00000  0.00000    113

2.5.68          16    4.34  3.95%    40.724      212.21  0.00000  0.00000    110
2.5.68-mm2      16    0.99  0.80%   178.652     1203.69  0.00000  0.00000    123

2.5.68          32    3.28  3.40%    98.453      335.85  0.00000  0.00000     96
2.5.68-mm2      32    0.94  0.76%   357.853     2151.68  0.00000  0.00000    124

2.5.68          64    4.20  3.87%   137.963      647.04  0.00000  0.00000    108
2.5.68-mm2      64    0.91  0.79%   677.313     3973.72  0.00000  0.00000    115

2.5.68         128    4.18  4.03%   245.390     1693.66  0.00000  0.00000    104
2.5.68-mm2     128    0.90  0.76%  1275.112     7329.02 11.84476  0.00000    119

2.5.68         256    4.96  4.47%   285.231     6121.11  0.78125  0.00000    111
2.5.68-mm2     256    0.86  0.86%  2160.203    40955.72 32.13542  3.67187     99

For Sequential Writes on ext2, -mm2 has higher throughput and lower latency.

               Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel         Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
-------------  ---  ------------------------------------------------------------
2.5.68           1   55.43 41.59%     0.173     3228.31  0.00000  0.00000    133
2.5.68-mm2       1   57.78 43.13%     0.164     3055.50  0.00000  0.00000    134

2.5.68           8   30.83 30.28%     2.473    21372.39  0.05684  0.00000    102
2.5.68-mm2       8   32.13 33.00%     2.281    20425.81  0.05011  0.00000     97

2.5.68          16   29.02 30.14%     4.886    36841.82  0.08054  0.00024     96
2.5.68-mm2      16   30.26 32.67%     4.616    33532.37  0.07949  0.00020     93

2.5.68          32   26.93 32.35%     9.834    76337.91  0.10024  0.03682     83
2.5.68-mm2      32   28.08 33.27%     9.433    75278.98  0.09423  0.01369     84

2.5.68          64   25.72 33.33%    19.158   134891.94  0.14043  0.07386     77
2.5.68-mm2      64   28.50 36.25%    18.455   133508.81  0.11492  0.06619     79

2.5.68         128   25.85 34.97%    35.961   266123.63  0.22740  0.09542     74
2.5.68-mm2     128   28.69 37.41%    33.453   217356.72  0.21301  0.08387     77

2.5.68         256   29.80 43.31%    60.387   463540.28  0.43515  0.12388     69
2.5.68-mm2     256   29.84 43.63%    60.796   404468.07  0.54049  0.11292     68


-mm2 does better with random writes.

Random Writes ext2
               Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel         Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
-------------  ---  ------------------------------------------------------------
2.5.68           1    2.86  2.73%     1.059       60.94  0.00000  0.00000    105
2.5.68-mm2       1    4.48  3.94%     0.077       22.02  0.00000  0.00000    114

2.5.68           8    3.73  4.39%     1.176       81.25  0.00000  0.00000     85
2.5.68-mm2       8    4.09  3.91%     1.984      488.24  0.00000  0.00000    104

2.5.68          16    3.69  4.21%     1.872      189.26  0.00000  0.00000     88
2.5.68-mm2      16    4.00  4.45%     3.510      969.07  0.00000  0.00000     90

2.5.68          32    3.71  4.89%     2.102      352.52  0.00000  0.00000     76
2.5.68-mm2      32    4.03  5.62%     4.660     1455.09  0.00000  0.00000     72

2.5.68          64    3.71  5.68%     2.266      701.86  0.00000  0.00000     65
2.5.68-mm2      64    4.26  7.39%     2.334     1483.77  0.00000  0.00000     58

2.5.68         128    3.79  6.87%     1.343     1042.66  0.00000  0.00000     55
2.5.68-mm2     128    4.35  8.14%     0.853      275.49  0.00000  0.00000     53

2.5.68         256    3.79  6.70%     0.304       79.07  0.00000  0.00000     57
2.5.68-mm2     256    4.36  8.87%     2.487     3519.76  0.00000  0.00000     49


bonnie++-1.02c random seek test on ext2 supports the tiobench random write
result.  

                     Sequential Output ------------------   ----- Random -----
                    ------ Block -----  ---- Rewrite ----   ----- Seeks  -----
Kernel        Size  MB/sec   %CPU  Eff  MB/sec  %CPU  Eff    /sec  %CPU   Eff
2.5.68        8192   68.62   53.3  129   15.92  17.0   94   502.5  3.00  16750
2.5.68-mm2    8192   71.61   57.0  126   17.52  19.0   92   203.9  1.00  20393

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

