Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277054AbRKAAmE>; Wed, 31 Oct 2001 19:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276973AbRKAAlz>; Wed, 31 Oct 2001 19:41:55 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:9403 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S276907AbRKAAlp>; Wed, 31 Oct 2001 19:41:45 -0500
Date: Wed, 31 Oct 2001 19:44:23 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM and OOM tests on 2.4.14-pre6
Message-ID: <20011031194423.A5719@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel:		2.4.14-pre6

Summary:	OOM works.  Takes a while to figure out what to kill, but
		eventually does the right thing.

Tests:		Test OOM behavior.
		"mtest01 -p 80 -w" and "mmap001 -m 500000" from LTP.
		Listen to mp3 on mp3blaster sampled at 128k.  (usual test).

Allocate but don't write memory
-------------------------------

Allocate 101, 120% of virtual memory. No pages are written.
Nothing dies.  These tests take .05 seconds.  Behavior seems
appropriate for the test.

root# mtest01 -p 101
Filling up 101%  of ram which is 1574421340 bytes
PASS ... 1574961152 bytes allocated.

root# mtest01 -p 120
Filling up 120%  of ram which is 1879196467 bytes
PASS ... 1880096768 bytes allocated.


Allocate (but don't write to) 500% of vm.  This also
takes .05 seconds.  Test gives "stopped" message with
negative number of bytes allocated.  

root# mtest01 -p 500
Filling up 500%  of ram which is 3679666176 bytes
stopped at -1219493888 bytes

Real OOM
--------

Now create a real oom condition.  Allocate and write to 101% of vm.
mtest01 process is terminated.  IRC clients, vmstat, iostat keep running.  
I did this test twice, and got the same behavior.  You can see the 
vmstat output wasn't updated much once the oom was reached and system
time went to 100%.  I.E. instead of 30+ vmstat samples, only 11 printed.
This is on an Athlon 1333.


root# time mtest01 -p 101 -w
Filling up 101%  of ram which is 1591169884 bytes
Terminated

real    3m11.136s
user    0m2.780s
sys     0m25.070s

vmstat 10
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0   6500 492568   2628   5284   1 271     9   604  126   118   2   2  96
 0  0  0   6500 492568   2628   5284   0   0     0     0  107    76   0   0 100
 1  0  0 235004   1612   1168   4516  12 18386    12 18386  274   321  11  15  73
 2  0  0 552012   1608   1168   4496   4 31613     6 31613  380   529   4  14  81
 5  0  0 866504   1588   1168   4496   3 31539     3 31539  381   540   5  15  80
 3  2  0 1052216   1836   1172   4500   8 22490    10 22490  427   451   2  67  31
 5  0  0 1052216   1668   1168   4512  44 559    48   559  201   146   0  99   0
 2  0  2 1052216   1532   1208   4516  18   2    27     8  240   186   0 100   0
 2  5  1   8176 497260   1172   4308  37  24    38    24 1038   800   0 100   0
 0  0  0   7668 496700   1412   3992  93   0   111    21  128    91   0   1  99
 0  0  0   7652 496688   1420   3992   0   0     1     0  172   193   0   0 100


Here is an oom test from Jay Thorne.  I tried it on 2.4.14-pre5 and didn't 
get an oom.  On 2.4.14-pre5; what I saw in vmstat was at the end of the cycle, 
system time went to 100%.  I ended up doing an <alt sysreq Sync Term>, then
relogin on pre5.

On 2.4.14-pre6, the perl hog is terminated, and all my other processes kept 
running.  Yea!  I ran this one twice too.

root# time nice perl -e 'while (1) { $foo .= " " x 512 } '
Terminated

real    2m1.349s
user    0m8.200s
sys     0m19.180s

vmstat 10
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0   7292 495648   1812   4004   1 293     8   620  126   117   2   2  96
 0  0  0   7292 495648   1812   4004   0   0     0     0  105    76   0   0 100
 1  0  0 190348   1624   1168   4244  12 13829    62 13829  235   348  29  16  55
 1  0  0 460036   1624   1168   4244   0 26970     0 26970  320   441  14  15  71
 2  0  0 729596   1580   1168   4244   3 26893     3 26893  325   455  14  16  70
 2  1  0 998512   1608   1172   4252   9 26957    16 26956  332   481  13  17  70
 5  0  1 1052216   1848   1168   4252   3 9011     6  9012  263   227   3  80  17
 3  0  1 1052216   2060   1168   4252   2 841     4   841  218   174   1  98   1
 2  4  0   8036 497756   1180   3976   6   2     7     2  456   375   0 100   0
 0  0  0   7892 497412   1232   3860  40   0    44     5  105    69   0   0 100



Below is the results of mtest01 and mmap001 tests:

2.4.14-pre6
-----------

mp3 played 225 seconds of 327 second test.

Averages for 10 mtest01 runs
bytes allocated:                    1230294220
User time (seconds):                2.089
System time (seconds):              3.013
Elapsed (wall clock) time:          32.650
Percent of CPU this job got:        15.00
Major (requiring I/O) page faults:  106.9
Minor (reclaiming a frame) faults:  301158.2

mp3 played 847 seconds of 848 second test.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.558
System time (seconds):              17.462
Elapsed (wall clock seconds) time:  169.53
Percent of CPU this job got:        21.40
Major (requiring I/O) page faults:  500163.0
Minor (reclaiming a frame) faults:  45.0


Portions of the two previous kernels:

2.4.14-pre5
-----------

mp3 played 263 seconds of 321 second run.

Averages for 10 mtest01 runs
bytes allocated:                    1241933414
Elapsed (wall clock) time:          32.104
Percent of CPU this job got:        15.70

No mp3 skips noted.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
Elapsed (wall clock seconds) time:  173.48
Percent of CPU this job got:        20.80


2.4.14-pre4 (2 oops)
-----------

mp3 played 250 of 313 seconds.

Averages for 10 mtest01 runs
bytes allocated:                    1244554854
Elapsed (wall clock) time:          31.306
Percent of CPU this job got:        16.00

mp3 played 860 of 865 seconds.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
Elapsed (wall clock seconds) time:  172.63
Percent of CPU this job got:        21.60

Have fun!
-- 
Randy Hron

