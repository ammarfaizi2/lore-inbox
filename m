Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274248AbRJNFBd>; Sun, 14 Oct 2001 01:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274255AbRJNFBY>; Sun, 14 Oct 2001 01:01:24 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:4321 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S274248AbRJNFBH>; Sun, 14 Oct 2001 01:01:07 -0400
From: rwhron@earthlink.net
Date: Sun, 14 Oct 2001 01:03:33 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM test on 2.4.12-ac1, 2.4.12aa1, and 2.4.13-pre2
Message-ID: <20011014010333.A245@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kernels test summary:

2.4.12-ac1	Wide variance in memory allocation
2.4.12aa1	Interesting vmstat/mp3blaster pattern
2.4.13-pre2	Locked up on 7th iteration

Test:	

Run loop of 10 iterations of Linux Test Project's "mtest01 -p80 -w"
This test attempts to allocate 80% of virtual memory and write to
each page.  Simulataneously listen to mp3blaster.

Reboot before each test.

Hardware:
Athlon 1333
512 Mb RAM
1024 Mb swap

Note: On all kernels I tested, mp3blaster plays smoothly with "mtest01 -p30 -w",
(allocate 30% of virtual memory).  I put this in an infinite loop.

When I bumped up the percentage, so the test would start to use swap, 
mp3blaster would begin to stutter.  Using a higher percentage, like 60 
made it clear that going into swap is the stutter trigger.  However, 
I discovered something interesting with Andrea's kernel.  More on that below.


Notes from each kernel:


2.4.12-ac1

The odd thing here is the enormous variation of memory allocated per run:

PASS ... 1224736768 bytes allocated.
PASS ... 857735168 bytes allocated.
PASS ... 727711744 bytes allocated.
PASS ... 964689920 bytes allocated.
PASS ... 455081984 bytes allocated.
PASS ... 636485632 bytes allocated.
PASS ... 960495616 bytes allocated.
PASS ... 332398592 bytes allocated.
PASS ... 881852416 bytes allocated.
PASS ... 394264576 bytes allocated.

mp3blaster stuttered the entire run.  It finished fast, but since it didn't
allocate the full 80% of memory after the first run, timing may not be meaningful.

Below is vmstat 1 from approximately 3 iterations of "mmtest01 -p80 -w" on 2.4.12-ac1:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  0      0 456060  21348  16160   0   0   283    11  173   225   0   4  95
 2  0  0      0 199644  21348  16164   0   0    24     0  282   590  47  50   3
 1  0  1   1444   2780  21348   8208   0   0    32     0  276   734  40  60   0
 7  1  2 466392   2048   1244   2388   0 126816    12 126828 1394  2699   1  23  76
 2  5  0 466392   5724   1236   2480 304 323536   500 323604 5876 73316   4  12  83
 7  3  1 909752   3064   1252   1884 2016 373688  3208 373716 5480 58698   4  18  78
 1  3  0 201388 299828   1288   3436 1800   0  3228    16  391   437   0   3  97
 2  0  0 201348 162784   1316   4112 1600   0  2296     0  431   706  44  26  31
 1  0  0 120756   3060   1328   5116 140   0  1152     0  418   622  44  56   0
 1  3  1 438156   2840   1332   1812  28   0   344    12  389   864  13  87   0
 0  2  3 416380   1296   1240   1744 140 72700   256 72696  437   874   7  26  67
 3  6  3 416380   3064   1256   1748  76 79548    80 79564 1062  9106   1  12  87
 2  4  2 423448   3724   1240   1752  60 120032    72 120044 1476  2115   4  15  81
 1  4  1 423448   3660   1252   1644  48 61552    92 61568  771   697   7  19  73
 0  3  0 267416 239308   1284   2268 1212 80868  2128 80912 2274  2218   3  15  82
 1  1  0 267376  73188   1308   3644 448   0  1840     0  520   446  32  32  37
 3  0  1 337996   2684   1304   1972 316 280   780   292  421   821  28  72   0
 1  1  1 390856   4280   1312   1732 368 5220   652  5224  392   645  22  78   0
 0  8  2 317276   3064   1248   1748 212 67616   264 67596  422   872  20  58  22
 1  8  2 317276   3064   1252   1752   0 27276     4 27276  378   225   0   2  98
 0  6  2 317276   2840   1252   1752   0 22680     0 22680  315   287   0   4  96

The vmstat 1 command didn't seem like it was pulsing smoothly every second.



2.4.12aa1 - Andrea's patch

This kernel behaved the best for the test.  

It allocated 1.2 gigs of virtual memory for each run.

PASS ... 1244659712 bytes allocated.
PASS ... 1251999744 bytes allocated.
PASS ... 1253048320 bytes allocated.
PASS ... 1254096896 bytes allocated.
PASS ... 1255145472 bytes allocated.
PASS ... 1254096896 bytes allocated.
PASS ... 1254096896 bytes allocated.
PASS ... 1255145472 bytes allocated.
PASS ... 1256194048 bytes allocated.
PASS ... 1255145472 bytes allocated.


mp3blaster with Andrea's patch stuttered during a portion of each run, then 
played continuously for the rest of each test.  

Here is a sample of vmstat 1 during an iteration.  vmstat output was consistant 
for each loop iteration.  This is just one cycle.  There is a note in the output 
where mp3blaster goes from smooth to stutter.  

This vmstat picks up towards the end of an mtest01 iteration.  You can see where 
swapd drops, which indicates the new run.  Note that mp3blaster is playing fine for
about 45 seconds before this vmstat output:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  3  1 696556   3256   1188   2460   0 15456    88 15504  486   762   4  11  86
 1  1  1 714984   1560   1176   2456  64 17380   136 17384  478   742   6   9  85
 0  3  1 732392   1624   1188   2448   0 18072    96 18076  513   784   2  12  87
 2  0  0   9912 372812   1236   2632 296 3216   540  3216  376   647  19  34  47


 Here mp3blaster begins to stutter.

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0   9912 107668   1236   2660   0   0    28     0  282   557  39  61   0
 0  4  1  30812   3352   1184    820 504 28016  2676 28060 1434  1515   5  11  84
 0  5  1  49592   2592   1180    860 124 14664   692 14692  538   477   2   3  95
 0  3  1  62760   2604   1192    844 172 12240   624 12244  473   331   3   4  93
 0  3  1  74440   2212   1184    900  96 11392   440 11392  342   215   3   4  93
 2  1  1  84048   2404   1184    904 120 10560   336 10560  366   239   3   3  95
 0  4  1  95716   2624   1212    948 104 12136   316 12160  388   349   2   4  94
 1  3  1 104268   3112   1184    940 152 8868   400  8868  365   348   3   6  90
 0  4  1 115468   2180   1176   1000  64 10752   276 10752  358   315   5   1  94
 0  4  1 126120   2592   1180    952 100 11116   324 11116  351   355   4   5  91
 0  4  0 137308   3880   1184   1020  96 11152   316 11152  334   342   3   5  92

 Interestingly, when swapd gets around 130000 - 140000, mp3blaster plays great 
 for the rest of the iteration, even though swap usage continues to increase.


   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  4  1 146956   2548   1180    976 140 9752   424  9776  308   326   4   7  90
 1  3  1 157544   2636   1184   1060 104 10984   632 10984  465   405   3   3  93
 0  3  1 167696   3148   1192   1068  88 10432   528 10432  397   369   2   3  96
 0  3  1 178800   3340   1176   1096 212 10560   588 10560  425   365   0   5  95
 1  3  2 188948   1624   1200   1244 104 10012   488 10028  355   370   2   2  96
 1  2  1 199088   1680   1192   1184 104 9840   296  9848  366   389   2   4  94
 1  3  1 211804   2004   1180   1108  84 11384   400 11384  379   395   3   3  94
 0  2  1 220852   1540   1176   1232 168 12264   480 12264  433   353   3   7  90
 0  2  1 237652   2564   1184   1108  96 15936   148 15936  391   367   2   7  91
 2  1  1 252852   1908   1180   1108 160 14696   220 14720  406   395   2   7  91
 0  2  1 269640   3556   1184   1108 112 17560   180 17560  479   385   4   4  93
 1  4  1 281324   3244   1184   1164 216 12612   392 12612  448   634   3   5  92
 1  4  1 290992   3076   1196   1260  68 8928   400  8928  442   691   5   4  92
 0  5  1 300672   1652   1208   1164  48 10604   308 10604  477   731   1   7  92
 0  4  1 309328   2904   1172   1384  68 8152   392  8184  414   657   3   6  91
 0  4  1 320032   2380   1192   1208  40 10616   328 10616  465   742   4   4  92
 0  4  1 334800   2020   1192   1228 100 9984   272  9984  449   704   4   7  89
 0  3  1 346044   1940   1192   1260  24 9224   476  9224  440   685   2   6  92
 1  1  1 354232   1908   1180   1280   4 15036   180 15036  478   697   5   6  90
 2  1  1 371640   2228   1180   1284   0 17164   184 17188  473   679   2   6  93
 2  2  1 388532   1864   1184   1280   4 16936    92 16940  487   716   6   4  89
 0  2  1 405428   1556   1180   1284   0 17568    76 17572  474   648   2  12  86
 0  1  1 420276   1960   1180   1284   0 15688    76 15692  473   685   6   7  87
 2  1  2 436660   2340   1212   1328   0 15260   208 15284  474   698   4  12  85
 2  3  1 459700   2032   1188   1284   0 20104    84 20128  541   793   4   7  89
 1  2  1 472500   1568   1176   1280   0 16296    68 16300  456   639   6  10  84
 2  1  1 496564   1908   1180   1280   0 23732    84 23736  598   841   2   9  88
 3  1  1 511252   2260   1184   1128   0 13880    96 13884  465   682   5   6  88
 1  3  1 531220   2940   1184   1124   0 20820   312 20848  491   705   1  12  87
 0  2  0 549140   3696   1180   1120   0 17852    88 17856  506   725   6  11  83
 1  0  1 565012   2860   1176   1128   0 16108   100 16112  502   727   6   5  89
 3  1  1 585480   1788   1180   1124  64 16576   200 16580  532   777   2   9  89
 2  1  2 601352   1900   1204   1132   0 16924    80 16952  500   721   4  10  87
 0  3  1 613636   2536   1188   1128  64 13948   136 13952  426   619   3   5  92
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  2  1 627460   2920   1188   1128   0 14568    96 14572  481   692   6   9  85
 1  0  1 642308   2008   1184   1136   0 13724    72 13724  439   605   4   8  88
 1  2  1 660228   3572   1176   1128   0 18600    64 18600  472   682   4  11  85
 3  0  1 673540   3568   1172   1132   0 14320   328 14352  499   687   6   6  88
 1  3  1 691972   2268   1196   1156   0 17636   120 17636  530   740   4   9  86
 0  3  1 701684   3656   1192   1180  16 10592   292 10592  441   674   5   3  93
 0  3  1 711920   2592   1196   1176   4 8928   248  8928  427   657   5   6  90
 2  1  1 725732   1856   1184   1240  12 15124   236 15124  486   697   5   6  89
 0  2  0 741084   3696   1176   1188  44 15360   188 15396  505   728   4   5  90
 1  0  0  10136 411540   1236   2232 240   0  1336     0  437   700  18  22  60


 mp3blaster played beautifully to this point.  Now as the next iteration of the 
 loop begins to hit swap, mp3blaster stutters again.  
 
 This cycle of smooth until RAM is gone, stutter until swap about 140000, 
 then smooth until the loop completes repeated over and over.

 Note: I moved the vmstat headers around in the output above, but didn't remove
 any data.  



2.4.13-pre2

My system became unusable during seventh loop iteration.  I wasn't able to 
abort the test with <ctrl c>, <ctrl \>.  I could switch consoles, but the
keyboard was unresponsive.  Sync in sysrq worked.  showMem, tErm didn't 
work.  I was able to sysrq unmount a couple filesystems, but I had to
hit the reset button to recover.

PASS ... 1243611136 bytes allocated.
PASS ... 1255145472 bytes allocated.
PASS ... 1254096896 bytes allocated.
PASS ... 1253048320 bytes allocated.
PASS ... 1253048320 bytes allocated.
PASS ... 1253048320 bytes allocated.

I won't include vmstat output for this kernel, but it behaved a lot like 2.4.12aa1.



Sound Card:

00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)


Hope the information above is useful to the kernel hackers.


Scripty:


#!/bin/bash

# script to exercise vm.  
#
# Uses "mtest01" memory test from Linux Test Project
#
# see: http://ltp.sourceforge.net/
#

# allocate p percent of virtual memory and write to each page.
# (write implied by -w option in mtest01)

mtest01=/usr/src/sources/l/cvs/ltp/testcases/bin/mtest01
mtest_log=mtest01-`uname -r`.log
vmstat_log=vmstat-`uname -r`.log

# percent of virtual memory to fill
p=80

# iterations
typeset -i i=10

# watch memory usage every second
vmstat 1 > $vmstat_log &

echo running $i iterations of $mtest01
echo "output is going to $mtest_log and $vmstat_log"

# need full featured bash for (( arith )).
while	((i > 0))
do	/usr/bin/time -v $mtest01 -p $p -w
	((i--))
done > $mtest_log  2>&1
# end of script.

-- 
Randy Hron

