Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274816AbRIUUSB>; Fri, 21 Sep 2001 16:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274810AbRIUURu>; Fri, 21 Sep 2001 16:17:50 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:62087 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274816AbRIUURm>; Fri, 21 Sep 2001 16:17:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Stefan Westerfeld <stefan@space.twc.de>,
        Roger Larsson <roger.larsson@norran.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Fri, 21 Sep 2001 22:18:06 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Oliver Xymoron <oxymoron@waste.org>, Robert Love <rml@tech9.net>,
        Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.30.0109201756400.20823-100000@waste.org> <200109210047.f8L0lkv26045@maile.telia.com> <20010921181800.36609@space.twc.de>
In-Reply-To: <20010921181800.36609@space.twc.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010921201744Z274816-760+15037@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. September 2001 18:18 schrieb Stefan Westerfeld:
>    Hi!
>
> On Fri, Sep 21, 2001 at 02:42:56AM +0200, Roger Larsson wrote:
> > > You might try stracing artsd to see if it hangs at a particular
> > > syscall. Use -tt or -r for timestamps and pipe the output through tee
> > > (to a file on your ramfs).
> >
> > I tried playing a mp3 with noatun via artsd. Starting dbench 32 I get the
> > same kind of dropouts - and no indication with my latency profiling patch
> > => no process with higher prio is waiting to run!
> >
> > One of noatun or artsd is waiting for something else! (That is why I
> > included Stefan Westerfeld... artsd)
> >
> > I noticed very nice improvement then reniceing (all) artsd and noatun.
> > (I did also change the buffer size in artsd down to 40 ms)
> >
> > (This part most for Stefan...
> > So I thought - lets try to run artsd with RT prio - changed the option
> > HOW can it get RT prio when it is not suid? I guess it can not...
> >
> > So I manually added suid bit - but then noatun could not connect with
> > artsd... bug?, backed out the suid change... but is behaves as it works,
> > could be that it has so short bursts that prio never get a chance to
> > drop)
>
> If you want to run artsd with RT prio, add suid root to artswrapper if it
> is not already there - it should by default, but some
> distributors/packagers don't get this right. If you start artsd via
> kcminit, check the realtime checkbox, if you do manually, run artswrapper
> instead of artsd, i.e.

Thank you very much Stefan!

I've an updated SuSE 7.1 (KDE-2.2.1, etc.) apart from my kernel and XFree86 
DRI hacking running, here.

SuSE missed the suid root on artswrapper (security).
I've changed it.

-rwxr-xr-x    1 root     root       211892 Sep 15 22:59 
/opt/kde2/bin/artsbuilder
-rwxr-xr-x    1 root     root          690 Sep 15 20:19 
/opt/kde2/bin/artsc-config
-rwxr-xr-x    1 root     root        30388 Sep 15 20:48 /opt/kde2/bin/artscat
-rwxr-xr-x    1 root     root       157576 Sep 15 23:00 
/opt/kde2/bin/artscontrol
-rwxr-xr-x    1 root     root       125040 Sep 15 20:48 /opt/kde2/bin/artsd
-rwxr-xr-x    1 root     root         2271 Sep 15 20:19 /opt/kde2/bin/artsdsp
-rwxr-xr-x    1 root     root         8568 Sep 15 20:50 
/opt/kde2/bin/artsmessage
-rwxr-xr-x    1 root     root        17924 Sep 15 20:48 /opt/kde2/bin/artsplay
-rwxr-xr-x    1 root     root        30396 Sep 15 20:49 
/opt/kde2/bin/artsshell
-rwsr-xr-x    1 root     root         4452 Sep 15 20:48 
/opt/kde2/bin/artswrapper

After that I've tested, again.

This time 2.4.10-pre10 + patch-rml-2.4.10-pre12-preempt-kernel-1 + 
patch-rml-2.4.10-pre12-preempt-stats-1 + journal.c (from Chris Mason)

dbench 32
Throughput 26.485 MB/sec (NB=33.1062 MB/sec  264.85 MBit/sec)
15.070u 60.340s 2:40.50 46.9%   0+0k 0+0io 911pf+0w
max load: 2936

Artsd daemon wait in "wait_on_b" (WCHAN), D state (STAT) during the hiccup 
(for nearly 3 seconds).
The hiccup appears at the beginning of dbench (after 9-10 seconds).
I've noticed no other hiccup.

snapshot

  9:33pm  up  2:03,  1 user,  load average: 27.28, 10.53, 5.87
122 processes: 112 sleeping, 10 running, 0 zombie, 0 stopped
CPU states: 15.4% user, 43.2% system,  0.0% nice, 41.3% idle
Mem:   642840K av,  607640K used,   35200K free,       0K shrd,   20244K buff
Swap: 1028120K av,     196K used, 1027924K free                  465668K 
cached

  PID USER     PRI  NI PAGEIN  SIZE SWAP  RSS SHARE WCHAN     STAT %CPU %MEM  
 TIME COMMA
 7529 nuetzel   20   0   1274  7128    0 7128  4252 do_select S     2.7  1.1  
 0:05 artsd
 7682 nuetzel   20   0     17  7128    0 7128  4252 rt_sigsus S     2.7  1.1  
 0:05 artsd
 7725 nuetzel   18   0     25   524    0  524   400 wait_on_b D     1.9  0.0  
 0:01 dbench
 7726 nuetzel   19   0     25   524    0  524   400 do_journa D     1.9  0.0  
 0:01 dbench
 7727 nuetzel   18   0     25   524    0  524   400 wait_on_b D     1.9  0.0  
 0:01 dbench
 7724 nuetzel   18   0     25   524    0  524   400 do_journa D     1.7  0.0  
 0:01 dbench
 7729 nuetzel   18   0     25   524    0  524   400 wait_on_b D     1.7  0.0  
 0:01 dbench
 7730 nuetzel   18   0     25   524    0  524   400 do_journa D     1.7  0.0  
 0:01 dbench
 7737 nuetzel   18   0     25   524    0  524   400 do_journa D     1.7  0.0  
 0:01 dbench
 7738 nuetzel   18   0     25   524    0  524   400           R     1.7  0.0  
 0:01 dbench
 7731 nuetzel   18   0     25   524    0  524   400 wait_on_b D     1.5  0.0  
 0:01 dbench
 7732 nuetzel   18   0     25   524    0  524   400 wait_on_b D     1.5  0.0  
 0:01 dbench
 7733 nuetzel   18   0     25   524    0  524   400 do_journa D     1.5  0.0  
 0:01 dbench
 7734 nuetzel   18   0     25   524    0  524   400 do_journa D     1.5  0.0  
 0:01 dbench
 7735 nuetzel   18   0     25   524    0  524   400 do_journa D     1.5  0.0  
 0:01 dbench
 7736 nuetzel   18   0     25   524    0  524   400 wait_on_b D     1.5  0.0  
 0:01 dbench
 7740 nuetzel   18   0     25   524    0  524   400           R     1.5  0.0  
 0:01 dbench
 7741 nuetzel   18   0     25   524    0  524   400 do_journa D     1.5  0.0  
 0:01 dbench
 7747 nuetzel   18   0     25   524    0  524   400           R     1.5  0.0  
 0:01 dbench
 7748 nuetzel   18   0     25   524    0  524   400 do_journa D     1.5  0.0  
 0:01 dbench

Worst 20 latency times of 6314 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  6927        BKL        1  1302/inode.c         c016de79  1306/inode.c
  6622  spin_lock        1   547/sched.c         c0111b04   697/sched.c
  4823        BKL        1  1302/inode.c         c016de79   842/inode.c
  4421   reacqBKL        1  1375/sched.c         c01138b4   697/sched.c
  3546   reacqBKL        1  1375/sched.c         c01138b4  1873/namei.c
  3302        BKL        1  1302/inode.c         c016de79    52/inode.c
  2651   reacqBKL        0  1375/sched.c         c01138b4  1439/namei.c
  2597        BKL        0   533/inode.c         c016c4ed  1380/sched.c
  2585        BKL        0  1302/inode.c         c016de79  1381/sched.c
  2517        BKL        1  1302/inode.c         c016de79   697/sched.c
  2473        BKL        0    30/inode.c         c016b971  1380/sched.c
  2442        BKL        0  1437/namei.c         c014af4f  1306/inode.c
  2428   reacqBKL        0  1375/sched.c         c01138b4  1381/sched.c
  2409        BKL        0  1302/inode.c         c016de79  1380/sched.c
  2294  spin_lock        0   547/sched.c         c0111b04  1380/sched.c
  2289        BKL        1   927/namei.c         c0149ddf   697/sched.c
  2235        BKL        1    30/inode.c         c016b971   697/sched.c
  2225        BKL        0  1437/namei.c         c014af4f   697/sched.c
  2158        BKL        0   533/inode.c         c016c4ed  1381/sched.c
  2136        BKL        1  1366/namei.c         c014ac4c  1381/sched.c

c016de20 T reiserfs_dirty_inode
c016de79 ..... <<<<<
c016df10 T reiserfs_sync_inode

c0111ad0 T schedule
c0111b04 ..... <<<<<
c0112020 T __wake_up

c016de20 T reiserfs_dirty_inode
c016de79 ..... <<<<<
c016df10 T reiserfs_sync_inode

Regards,
	Dieter
