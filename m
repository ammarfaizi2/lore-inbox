Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274666AbRITVx3>; Thu, 20 Sep 2001 17:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274667AbRITVxK>; Thu, 20 Sep 2001 17:53:10 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:20454 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274666AbRITVxB>; Thu, 20 Sep 2001 17:53:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>, Roger Larsson <roger.larsson@norran.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Thu, 20 Sep 2001 23:53:20 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1000939458.3853.17.camel@phantasy> <200109201742.f8KHgJH04518@maild.telia.com> <1001021365.6048.187.camel@phantasy>
In-Reply-To: <1001021365.6048.187.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920215309Z274666-760+14624@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. September 2001 23:29 schrieb Robert Love:
> On Thu, 2001-09-20 at 13:37, Roger Larsson wrote:
> > > Worst 20 latency times of 4261 measured in this period.
> > >   usec      cause     mask   start line/file      address   end
> > > line/file 4617   reacqBKL        0  1375/sched.c         c0114d94 
> > > 1381/sched.c
> >
> > This is fantastic! It REALLY is!
> > When we started with the low latency work we aimed at 10 ms.
> > (in all situations, not only when running dbench... but still)
>
> Yes it really is, especially noting that that 4.6ms lock is the
> _longest_ held lock on the system.
>
> I am seeing 90% of the reported locks under 15ms, and this means that
> almost all the locks on the system are even less.
>
> However, I am also seeing some stray 20-50ms and even 60-70ms latencies
> and those bother me.  I am looking into another solution, perhaps
> conditional scheduling for now.
>
> > Lets see - no swap used? - not swapped out

swap is enabled but not used by artsd (only 8 MB for X and some kdeinit stuff)

  810 nuetzel   -1 -20  6820    0 6820  4380 S <   0.0  1.0   0:31 artsd
 2724 nuetzel    8   0  6820    0 6820  4380 S     0.0  1.0   0:00 artsd

SunWave1>cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  658395136 437657600 220737536        0  6656000 287236096
Swap: 1052794880  8990720 1043804160
MemTotal:       642964 kB
MemFree:        215564 kB
MemShared:           0 kB
Buffers:          6500 kB
Cached:         278396 kB
SwapCached:       2108 kB
Active:         265108 kB
Inactive:        21896 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       642964 kB
LowFree:        215564 kB
SwapTotal:     1028120 kB
SwapFree:      1019340 kB

> > But with priority altered - it is unlikely that it would not be scheduled
> > in for such a long time.
> >
> > Might it be that the disk is busy to handle dbench requests. 16 threads
> > -> 16 read and several (async) write requests at different disk locations
> > in queue - make it 20. Seek time 10 ms => queue length 200 ms...
> > probable??? Do you have more than one disk? Try to run dbench on one and
> > the player from the other.

OK, I moved my video and sound files to one of my "older" IBM DDRS-9GB UW 
disks (read max ~12.8 MB/s).

Did NOT help. With and without renice -20.
Same hiccup (0.5~3 sec) during the first few seconds of dbench. The hiccup 
ONLY occur at the beginning of every dbench run.

-Dieter

PS At the bottom you can find the latency and time for this copy job.

Throughput 23.7919 MB/sec (NB=29.7399 MB/sec  237.919 MBit/sec)
7.470u 29.740s 1:29.79 41.4%    0+0k 0+0io 511pf+0w
load: 1300

SunWave1>cat /proc/latencytimes
Worst 20 latency times of 5890 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 13990  spin_lock        9  2043/tcp_ipv6.c      e9072837   119/softirq.c
 11596  spin_lock        1  2111/tcp_ipv4.c      c0207287   119/softirq.c
  4616   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  4478   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  2187        BKL        1  1302/inode.c         c016f359   697/sched.c
  2172   reacqBKL        1  1375/sched.c         c0114d94   929/namei.c
  1991        BKL        0  1302/inode.c         c016f359  1381/sched.c
  1966        BKL        1  1302/inode.c         c016f359   842/inode.c
  1934        BKL        0  1437/namei.c         c014c42f  1380/sched.c
  1891        BKL        0    30/inode.c         c016ce51   697/sched.c
  1879  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c
  1865  spin_lock        0  1376/sched.c         c0114db3  1380/sched.c
  1833  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  1828        BKL        0    30/inode.c         c016ce51  1380/sched.c
  1812        BKL        0  1302/inode.c         c016f359  1380/sched.c
  1792        BKL        0  1437/namei.c         c014c42f  1381/sched.c
  1782  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
  1776        BKL        0  1437/namei.c         c014c42f   929/namei.c
  1772        BKL        1  1437/namei.c         c014c42f   697/sched.c
  1767        BKL        0   129/attr.c          c01576bd  1380/sched.c

SunWave1>cat /proc/latencytimes
Worst 20 latency times of 2260 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
   583        BKL        6   712/tty_io.c        c018cfcb   714/tty_io.c
   284        BKL        0    83/file.c          c0171024  1381/sched.c
   245        BKL        0  2763/buffer.c        c01410aa  1381/sched.c
   209        BKL        0  2763/buffer.c        c01410aa   697/sched.c
   204       eth1        0   585/irq.c           c010886f   647/irq.c
   193   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
   142   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
   111   reacqBKL        0  1375/sched.c         c0114d94    98/file.c
   109        BKL        0   452/exit.c          c011af61  1380/sched.c
   109        BKL        0   927/namei.c         c014b2bf   929/namei.c
    95        BKL        0   533/inode.c         c016d9cd   842/inode.c
    91        BKL        0  1870/namei.c         c014d420  1873/namei.c
    85    unknown        3    76/softirq.c       c011c634   119/softirq.c
    76        BKL        0    30/inode.c         c016ce51    52/inode.c
    64        BKL        1    26/readdir.c       c014ed07    28/readdir.c
    62  spin_lock        0  1715/dev.c           c01dc513  1728/dev.c
    54  spin_lock        2   468/netfilter.c     c01e4363   119/softirq.c
    49  spin_lock        0   991/dev.c           c01db583   998/dev.c
    47  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c
    45        BKL        0  1302/inode.c         c016f359  1306/inode.c

renice -20 artsd
Throughput 27.6322 MB/sec (NB=34.5402 MB/sec  276.322 MBit/sec)
7.180u 30.180s 1:17.44 48.2%    0+0k 0+0io 511pf+0w
load: 1222

Worst 20 latency times of 6170 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  4883  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
  3590        BKL        0  2763/buffer.c        c01410aa  1381/sched.c
  3192   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  2647        BKL        0  1302/inode.c         c016f359   697/sched.c
  2286        BKL        0  1302/inode.c         c016f359  1381/sched.c
  2011        BKL        1  1437/namei.c         c014c42f   697/sched.c
  1795        BKL        1   452/exit.c          c011af61   697/sched.c
  1790        BKL        1  1302/inode.c         c016f359  1380/sched.c
  1725   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
  1700  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c
  1685        BKL        1  1437/namei.c         c014c42f  1380/sched.c
  1673        BKL        0  1437/namei.c         c014c42f  1381/sched.c
  1662        BKL        0    30/inode.c         c016ce51  1381/sched.c
  1575  spin_lock        0  1376/sched.c         c0114db3  1380/sched.c
  1565        BKL        0   533/inode.c         c016d9cd  1381/sched.c
  1452        BKL        0    30/inode.c         c016ce51   697/sched.c
  1452        BKL        0   533/inode.c         c016d9cd  1380/sched.c
  1445        BKL        0   927/namei.c         c014b2bf  1380/sched.c
  1423        BKL        0   129/attr.c          c01576bd  1381/sched.c
  1413        BKL        1   927/namei.c         c014b2bf   697/sched.c

SunWave1#du -s /usr/data/sounds/
263404  /usr/data/sounds

SunWave1#time cp -a /usr/data/sounds/ /database/db1/data/
0.080u 5.800s 1:03.06 9.3%      0+0k 0+0io 127pf+0w

SunWave1#du -s /database/db1/data/sounds/
263404  /database/db1/data/sounds

Worst 20 latency times of 3398 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 10155  spin_lock        1   291/buffer.c        c014151c   285/buffer.c
  9028        BKL        8   152/devices.c       c013c282   154/devices.c
  7007   keyboard        9    76/softirq.c       c011c634   119/softirq.c
  5999  spin_lock        8    86/softirq.c       c011c66c   112/softirq.c
  4201  spin_lock        1   257/vmscan.c        c01331e6   286/vmscan.c
  4009  spin_lock        0   978/pc_keyb.c       c01a0787   983/pc_keyb.c
  3000  spin_lock        1   375/memory.c        c0127abf   389/memory.c
  1715  spin_lock        0   468/vmscan.c        c0133c35   431/vmscan.c
  1387  spin_lock        0   678/inode.c         c01566d7   704/inode.c
  1234   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  1071        BKL        1  1302/inode.c         c016f359  1380/sched.c
  1049  spin_lock        1   305/dcache.c        c0153acd    86/dcache.c
  1049  spin_lock        1   468/vmscan.c        c0133c35   344/vmscan.c
   968  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
   950   reacqBKL        0  1375/sched.c         c0114d94   697/sched.c
   858       eth1        0   585/irq.c           c010886f   647/irq.c
   803        BKL        4   927/namei.c         c014b2bf   929/namei.c
   736        BKL        0   452/exit.c          c011af61   697/sched.c
   696        BKL        4  1870/namei.c         c014d420  1873/namei.c
   694        BKL        0  2763/buffer.c        c01410aa  1381/sched.c

c0141400 T kupdate
c014151c ..... <<<<<
c0141610 T set_buffer_async_io
