Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274872AbRI0AC5>; Wed, 26 Sep 2001 20:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275711AbRI0ACk>; Wed, 26 Sep 2001 20:02:40 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:51366 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274872AbRI0ACe>; Wed, 26 Sep 2001 20:02:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: Re: [reiserfs-list] Re: [PATCH] Preemption Latency Measurement Tool
Date: Thu, 27 Sep 2001 02:02:58 +0200
X-Mailer: KMail [version 1.3.1]
Cc: george anzinger <george@mvista.com>, Andrea Arcangeli <andrea@suse.de>,
        Ingo Molnar <mingo@elte.hu>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> <200109222347.f8MNlMG25157@zero.tech9.net> <1001213691.873.15.camel@phantasy>
In-Reply-To: <1001213691.873.15.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010927000236Z274872-760+17449@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robert, all the others,

here are my latest results.
I've tried 2.4.10+preempt with some additional patches.
Latest that I have applied was softirq-2.4.10-A7. But it all didn't fix my 
reported MP3 playback hiccup during dbench 16/32.

See the numbers below.

Regards,
	Dieter

2.4.10+
patch-rml-2.4.10-preempt-kernel-1+
patch-rml-2.4.10-preempt-ptrace-and-jobs-fix+
patch-rml-2.4.10-preempt-stats-1+
inode.c-schedule.patch+
journal.c-1-patch

32 clients started
.....................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................++............................................+.......+++..+....+++..+...+.....+.++...+.++++.+++.++++++.+++********************************
Throughput 38.6878 MB/sec (NB=48.3597 MB/sec  386.878 MBit/sec)
14.200u 54.940s 1:50.21 62.7%   0+0k 0+0io 911pf+0w
max load: 1777

Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M    79  97 16034  21  5719   6   147  98 22904  16 269.0   
4
Latency               138ms    2546ms     201ms   97838us   58940us    3207ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  6121  75 +++++ +++ 12753  95  8422  80 +++++ +++ 11152  
95
Latency             26126us   11425us   11879us    5325us   12082us   13025us
1.92a,1.92a,SunWave1,1001286857,1248M,79,97,16034,21,5719,6,147,98,22904,16,269.0,4,16,,,,,6121,75,+++++,+++,12753,95,8422,80,+++++,+++,11152,95,138ms,2546ms,201ms,97838us,58940us,3207ms,26126us,11425us,11879us,5325us,12082us,13025us

After running VTK (VIS app) I get this:

Worst 20 latency times of 1648 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  7239  spin_lock        1   381/memory.c        c012808f   402/memory.c
   321        BKL        0  2754/buffer.c        c01415ba   697/sched.c
   312        BKL        0   359/buffer.c        c013d6dc  1381/sched.c
   280        BKL        0   359/buffer.c        c013d6dc  1380/sched.c
   252   reacqBKL        0  1375/sched.c         c0115334  1381/sched.c
   232  spin_lock        0   547/sched.c         c0113574   697/sched.c
   215       eth1        0   585/irq.c           c01089af   647/irq.c
   164        BKL        0   452/exit.c          c011b4d1   681/tty_io.c
   119        BKL        0  1437/namei.c         c014cabf   697/sched.c
   105        BKL        0   452/exit.c          c011b4d1   697/sched.c
   101        BKL        5   712/tty_io.c        c01a6edb   714/tty_io.c
   100        BKL        0   452/exit.c          c011b4d1  1380/sched.c
    99    unknown        1    76/softirq.c       c011cba4   119/softirq.c
    92  spin_lock        4   468/netfilter.c     c01fe263   119/softirq.c
    79        BKL        0    42/file.c          c01714b0    63/file.c
    72        BKL        0   752/namei.c         c014b73f   697/sched.c
    71        BKL        0   533/inode.c         c016e0ad  1381/sched.c
    71        BKL        0    30/inode.c         c016d531    52/inode.c
    68        BKL        0   452/exit.c          c011b4d1  1381/sched.c
    66        BKL        0   927/namei.c         c014b94f   929/namei.c

Adhoc c012808e <zap_page_range+5e/260>

Do we need Rik's patch?

****************************************************************************

2.4.10+
patch-rml-2.4.10-preempt-kernel-1+
patch-rml-2.4.10-preempt-ptrace-and-jobs-fix+
patch-rml-2.4.10-preempt-stats-1+
inode.c-schedule.patch+
journal.c-1-patch+
kupdated-patch

32 clients started
...............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+..........................................+.................+...........++.....................++.....++......+......+++++...++++++++.+++++++.++********************************
Throughput 38.9015 MB/sec (NB=48.6269 MB/sec  389.015 MBit/sec)
15.140u 60.640s 1:49.66 69.1%   0+0k 0+0io 911pf+0w
max load: 1654

Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M    84  99 16348  21  5746   6   142  99 23411  17 265.9   
4
Latency               130ms    1868ms     192ms   88459us   54625us    3367ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  4941  65 +++++ +++ 12916  96  6847  76 +++++ +++ 10785  
94
Latency              8468us   11334us   11736us    8520us   12205us   12856us
1.92a,1.92a,SunWave1,1001358471,1248M,84,99,16348,21,5746,6,142,99,23411,17,265.9,4,16,,,,,4941,65,+++++,+++,12916,96,6847,76,+++++,+++,10785,94,130ms,1868ms,192ms,88459us,54625us,3367ms,8468us,11334us,11736us,8520us,12205us,12856us

Dbench run during MP3 playback:
32 clients started
.................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+.........+.........................................+.+.....+...............+...........................................................................+...................++...........+.+.......+..++++.++.+.++.++++++.+++++********************************
Throughput 34.7025 MB/sec (NB=43.3782 MB/sec  347.025 MBit/sec)
15.290u 63.820s 2:02.74 64.4%   0+0k 0+0io 911pf+0w

Worst 20 latency times of 16578 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 26795  spin_lock        1   291/buffer.c        c0141a2c   280/buffer.c
 17330  spin_lock        1   341/vmscan.c        c0133f0a   402/vmscan.c
 12925  spin_lock        1   439/vmscan.c        c0133ea5   338/vmscan.c
 11923  spin_lock        1   291/buffer.c        c0141a2c   285/buffer.c
  7253        BKL        0  1302/inode.c         c016faa9  1381/sched.c
  7117        BKL        1  1302/inode.c         c016faa9   697/sched.c
  6097        BKL        0  1302/inode.c         c016faa9  1380/sched.c
  6000        BKL        1   533/inode.c         c016e11d   697/sched.c
  4870   reacqBKL        1  1375/sched.c         c0115334   929/namei.c
  4015  spin_lock        0   439/vmscan.c        c0133ea5   402/vmscan.c
  2075        BKL        1   452/exit.c          c011b4d1   697/sched.c
  2029  spin_lock        1   547/sched.c         c0113574   697/sched.c
  2010        BKL        0  1302/inode.c         c016faa9   842/inode.c
  1730        BKL        0  2754/buffer.c        c01415ba  2757/buffer.c
  1668        BKL        1  2754/buffer.c        c01415ba   697/sched.c
  1574  spin_lock        0   483/dcache.c        c01545da   520/dcache.c
  1416  spin_lock        0  1376/sched.c         c0115353  1380/sched.c
  1396  spin_lock        1  1376/sched.c         c0115353   697/sched.c
  1387    aic7xxx        1    76/softirq.c       c011cba4   119/softirq.c
  1341        BKL        1   533/inode.c         c016e11d   842/inode.c

Adhoc c0141a2c <kupdate+11c/210>
Adhoc c0133f0a <shrink_cache+37a/5b0>
Adhoc c0133ea4 <shrink_cache+314/5b0>
Adhoc c0141a2c <kupdate+11c/210>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c016e11c <reiserfs_get_block+9c/f30>
Adhoc c0115334 <preempt_schedule+34/b0>
Adhoc c0133ea4 <shrink_cache+314/5b0>
Adhoc c011b4d0 <do_exit+130/360>
Adhoc c0113574 <schedule+34/550>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c01545da <select_parent+3a/100>
Adhoc c0115352 <preempt_schedule+52/b0>
Adhoc c0115352 <preempt_schedule+52/b0>
Adhoc c011cba4 <do_softirq+34/150>
Adhoc c016e11c <reiserfs_get_block+9c/f30>

Redo after some seconds:

Worst 20 latency times of 1944 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  2028        BKL        1  1302/inode.c         c016faa9   697/sched.c
   584        BKL        0  1302/inode.c         c016faa9  1306/inode.c
   572  spin_lock        0  1376/sched.c         c0115353  1380/sched.c
   415        BKL        0  1302/inode.c         c016faa9  1381/sched.c
   356        BKL        0  2754/buffer.c        c01415ba  2757/buffer.c
   353        BKL        0  2754/buffer.c        c01415ba   697/sched.c
   328        BKL        0  2754/buffer.c        c01415ba  1381/sched.c
   278  spin_lock        0   381/memory.c        c012808f   402/memory.c
   274   reacqBKL        0  1375/sched.c         c0115334  1381/sched.c
   245  spin_lock        0   547/sched.c         c0113574   697/sched.c
   208       eth1        0   585/irq.c           c01089af   647/irq.c
   188        BKL        1   301/namei.c         c014a4b1   697/sched.c
   176        BKL        1   927/namei.c         c014b9bf   929/namei.c
   161        BKL        0   301/namei.c         c014a4b1  1380/sched.c
   154        BKL        0   533/inode.c         c016e11d   842/inode.c
   147        BKL        6   712/tty_io.c        c01a6f6b   714/tty_io.c
   141        BKL        0   301/namei.c         c014a4b1  1381/sched.c
   141        BKL        0    30/inode.c         c016d5a1    52/inode.c
   126   reacqBKL        0  1375/sched.c         c0115334  2757/buffer.c
   121   reacqBKL        0  1375/sched.c         c0115334   929/namei.c

Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c0115352 <preempt_schedule+52/b0>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c012808e <zap_page_range+5e/260>
Adhoc c0115334 <preempt_schedule+34/b0>
Adhoc c0113574 <schedule+34/550>
Adhoc c01089ae <do_IRQ+3e/1d0>
Adhoc c014a4b0 <real_lookup+70/150>
Adhoc c014b9be <vfs_create+ae/150>
Adhoc c014a4b0 <real_lookup+70/150>
Adhoc c016e11c <reiserfs_get_block+9c/f30>
Adhoc c01a6f6a <tty_write+21a/2f0>
Adhoc c014a4b0 <real_lookup+70/150>
Adhoc c016d5a0 <reiserfs_delete_inode+30/110>
Adhoc c0115334 <preempt_schedule+34/b0>
Adhoc c0115334 <preempt_schedule+34/b0>

****************************************************************************

2.4.10+
patch-rml-2.4.10-preempt-kernel-1+
patch-rml-2.4.10-preempt-ptrace-and-jobs-fix+
patch-rml-2.4.10-preempt-stats-1+
inode.c-schedule.patch+
journal.c-1-patch+
kupdated-patch+
00_vm-tweaks-1

32 clients started
............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+......................................+..+...+...+...............+...+...................+.....+++...+.++.+.+..+++++.+...++++++++++********************************
Throughput 37.9905 MB/sec (NB=47.4881 MB/sec  379.905 MBit/sec)
14.810u 62.280s 1:52.26 68.6%   0+0k 0+0io 911pf+0w
max load: 1764

Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M    87  98 16359  21  5839   6   155  99 23709  16 275.7   
4
Latency               247ms    2351ms     191ms   84684us   67700us    3791ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  5545  52 +++++ +++ 13434  95  5138  67 +++++ +++ 11297  
95
Latency              4894us   11251us   11868us    4922us   12265us   12863us
1.92a,1.92a,SunWave1,1001467140,1248M,87,98,16359,21,5839,6,155,99,23709,16,275.7,4,16,,,,,5545,52,+++++,+++,13434,95,5138,67,+++++,+++,11297,95,247ms,2351ms,191ms,84684us,67700us,3791ms,4894us,11251us,11868us,4922us,12265us,12863us

Dbench run during MP3 playback:
32 clients started
.................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................++..........+.+..+..............................................+...................................................+.....+..........+.....+.+..++++.+..+....+++++++.+.++++.+++********************************
Throughput 36.1736 MB/sec (NB=45.217 MB/sec  361.736 MBit/sec)
14.920u 61.240s 1:57.82 64.6%   0+0k 0+0io 911pf+0w

Worst 20 latency times of 19595 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 40920  spin_lock        1   291/buffer.c        c0141a5c   280/buffer.c
 16812  spin_lock        1   443/vmscan.c        c0133eb5   340/vmscan.c
  8114        BKL        1   533/inode.c         c016e14d   697/sched.c
  7932  spin_lock        1   443/vmscan.c        c0133eb5   406/vmscan.c
  6886        BKL        1  1302/inode.c         c016fad9   697/sched.c
  6660        BKL        0  1302/inode.c         c016fad9  1306/inode.c
  6260  spin_lock        1   343/vmscan.c        c0133f1a   406/vmscan.c
  4273        BKL        1  1302/inode.c         c016fad9   842/inode.c
  2410   reacqBKL        1  1375/sched.c         c0115334   697/sched.c
  2153   reacqBKL        0  1375/sched.c         c0115334  1381/sched.c
  1876        BKL        0   452/exit.c          c011b4d1   697/sched.c
  1609  spin_lock        1   483/dcache.c        c015460a   520/dcache.c
  1536        BKL        0  2754/buffer.c        c01415ea  2757/buffer.c
  1533  spin_lock        0   291/buffer.c        c0141a5c   285/buffer.c
  1311        BKL        0  2754/buffer.c        c01415ea  1380/sched.c
  1308  spin_lock        0   547/sched.c         c0113574   697/sched.c
  1286        BKL        1   533/inode.c         c016e14d   842/inode.c
  1222        BKL        0    30/inode.c         c016d5d1    52/inode.c
  1110        BKL        0  2754/buffer.c        c01415ea  1381/sched.c
   850  spin_lock        1  1376/sched.c         c0115353  1380/sched.c

Adhoc c0141a5c <kupdate+11c/210>
Adhoc c0133eb4 <shrink_cache+2f4/590>
Adhoc c016e14c <reiserfs_get_block+9c/f30>
Adhoc c0133eb4 <shrink_cache+2f4/590>
Adhoc c016fad8 <reiserfs_dirty_inode+58/f0>
Adhoc c016fad8 <reiserfs_dirty_inode+58/f0>
Adhoc c0133f1a <shrink_cache+35a/590>
Adhoc c016fad8 <reiserfs_dirty_inode+58/f0>
Adhoc c0115334c0115334 <END_OF_CODE+c0115333d122a04e/????>
Adhoc c011b4d0 <do_exit+130/360>
Adhoc c015460a <select_parent+3a/100>
Adhoc c01415ea <sync_old_buffers+2a/130>
Adhoc c0141a5c <kupdate+11c/210>
Adhoc c01415ea <sync_old_buffers+2a/130>
Adhoc c0113574 <schedule+34/550>
Adhoc c016e14c <reiserfs_get_block+9c/f30>
Adhoc c016d5d0 <reiserfs_delete_inode+30/110>
Adhoc c01415ea <sync_old_buffers+2a/130>
Adhoc c0115352 <preempt_schedule+52/b0>

SunWave1#free -t
             total       used       free     shared    buffers     cached
Mem:        642824     168212     474612          0      11404      47612
-/+ buffers/cache:     109196     533628
Swap:            0          0          0
Total:      642824     168212     474612

SunWave1#cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  658251776 172527616 485724160        0 11677696 49016832
Swap:        0        0        0
MemTotal:       642824 kB
MemFree:        474340 kB
MemShared:           0 kB
Buffers:         11404 kB
Cached:          47868 kB
SwapCached:          0 kB
Active:          37356 kB
Inactive:        21916 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       642824 kB
LowFree:        474340 kB
SwapTotal:           0 kB
SwapFree:            0 kB

****************************************************************************

2.4.10+
patch-rml-2.4.10-preempt-kernel-1+
patch-rml-2.4.10-preempt-ptrace-and-jobs-fix+
patch-rml-2.4.10-preempt-stats-1+
inode.c-schedule.patch+
journal.c-1-patch+
kupdated-patch+
00_vm-tweaks-2+
softirq-2.4.10-A7

32 clients started
....................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+............+.....................................+...+................................+.....................+........+..+++..+++...+++++++..+++++.++++.+++********************************
Throughput 38.061 MB/sec (NB=47.5762 MB/sec  380.61 MBit/sec)
14.850u 60.210s 1:52.00 67.0%   0+0k 0+0io 911pf+0w
max load: 1872

Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M    86  99 16238  21  5950   6   160  99 23612  16 270.9   
4
Latency               186ms    1905ms     170ms   81429us   58393us    2869ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  5351  51 +++++ +++ 13298  94  8670  82 +++++ +++ 11260  
95
Latency              7799us   11631us   11649us    4801us   12097us   12804us
1.92a,1.92a,SunWave1,1001546561,1248M,86,99,16238,21,5950,6,160,99,23612,16,270.9,4,16,,,,,5351,51,+++++,+++,13298,94,8670,82,+++++,+++,11260,95,186ms,1905ms,170ms,81429us,58393us,2869ms,7799us,11631us,11649us,4801us,12097us,12804us

Dbench run during MP3 playback:
SunWave1>time ./dbench 32
32 clients started
........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+.+.+................++.....+........+......................+...................+++.+...........+........+.......++..+++.+..++.+.++...++++.+.+.........+********************************
Throughput 37.9649 MB/sec (NB=47.4562 MB/sec  379.649 MBit/sec)
14.900u 61.430s 1:52.34 67.9%   0+0k 0+0io 911pf+0w

Worst 20 latency times of 13895 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 32066  spin_lock        1   291/buffer.c        c0141aac   285/buffer.c
 13058  spin_lock        1   443/vmscan.c        c0133f05   340/vmscan.c
 10875  spin_lock        1   343/vmscan.c        c0133f6a   340/vmscan.c
  9627  spin_lock        1   291/buffer.c        c0141aac   280/buffer.c
  7310  spin_lock        0   343/vmscan.c        c0133f6a   406/vmscan.c
  7003        BKL        1  1302/inode.c         c016fb29  1402/sched.c
  6906        BKL        0  1302/inode.c         c016fb29   719/sched.c
  6723        BKL        0  1302/inode.c         c016fb29  1306/inode.c
  4036        BKL        1  1302/inode.c         c016fb29   842/inode.c
  3978        BKL        1   533/inode.c         c016e19d   842/inode.c
  3636        BKL        1    30/inode.c         c016d621    52/inode.c
  3359   reacqBKL        1  1397/sched.c         c01153f4    52/inode.c
  3005        BKL        1   452/exit.c          c011b591   719/sched.c
  2137   reacqBKL        1  1397/sched.c         c01153f4   929/namei.c
  2064  spin_lock        0   443/vmscan.c        c0133f05   406/vmscan.c
  1776   reacqBKL        1  1397/sched.c         c01153f4   719/sched.c
  1695  spin_lock        0   569/sched.c         c0113634   719/sched.c
  1557  spin_lock        0   483/dcache.c        c015465a   520/dcache.c
  1385        BKL        1  2754/buffer.c        c014163a  2757/buffer.c
  1324  spin_lock        0  1398/sched.c         c0115413   719/sched.c

Adhoc c0141aac <kupdate+11c/210>
Adhoc c0133f04 <shrink_cache+2f4/590>
Adhoc c0133f6a <shrink_cache+35a/590>
Adhoc c0141aac <kupdate+11c/210>
Adhoc c0133f6a <shrink_cache+35a/590>
Adhoc c016fb28 <reiserfs_dirty_inode+58/f0>
Adhoc c016fb28 <reiserfs_dirty_inode+58/f0>
Adhoc c016fb28 <reiserfs_dirty_inode+58/f0>
Adhoc c016fb28 <reiserfs_dirty_inode+58/f0>
Adhoc c016e19c <reiserfs_get_block+9c/f30>
Adhoc c016d620 <reiserfs_delete_inode+30/110>
Adhoc c01153f4 <preempt_schedule+34/b0>
Adhoc c011b590 <do_exit+130/360>
Adhoc c01153f4 <preempt_schedule+34/b0>
Adhoc c0133f04 <shrink_cache+2f4/590>
Adhoc c01153f4 <preempt_schedule+34/b0>
Adhoc c0113634 <schedule+34/550>
Adhoc c015465a <select_parent+3a/100>
Adhoc c014163a <sync_old_buffers+2a/130>
Adhoc c0115412 <preempt_schedule+52/b0>
