Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272247AbRIVVTg>; Sat, 22 Sep 2001 17:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRIVVT1>; Sat, 22 Sep 2001 17:19:27 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:22984 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S272247AbRIVVTP>; Sat, 22 Sep 2001 17:19:15 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: george anzinger <george@mvista.com>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Sat, 22 Sep 2001 23:09:22 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Oliver Xymoron <oxymoron@waste.org>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> <1001042255.7291.39.camel@phantasy> <3BAB614E.8600D074@mvista.com>
In-Reply-To: <3BAB614E.8600D074@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010922211919Z272247-760+15646@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. September 2001 17:48 schrieb george anzinger:
> Robert Love wrote:
> > On Thu, 2001-09-20 at 18:51, Dieter Nützel wrote:
> > > > Does your audio source depend on any files (eg mp3s) and if so, could
> > > > they be moved to a ramfs? Do the skips go away then?
> > >
> > > Good point.
> > >
> > > I've copied one video (MP2) and one Ogg-Vorbis file into /dev/shm.
> > > Little bit better but hiccup still there :-(
> >
> > As I've been saying, the problem really shouldn't be disk I/O.  I would
> > think (and really hope) the readahead code can fit a little mp3 in
> > memory.  Even if not, its a quick read to load it.  The continued blips
> > you see are caused by something, well, continual :)
>
> Are you running your application at some real time priority?  I suspect
> that, when dbench starts, it floods the system with a lot of new tasks
> and the system must visit each one until it gets back to your ap.  Nice
> will only do so much here.  Real time priority is the way to go.
> Attached are a couple of small programs to help here.  "rt" runs a given
> ap at a given priority.  I.e. > rt 10 foo, runs foo at priority 10.
> (There are more options, try rt -h.)  getrt reports the priority of a
> task.  If you do something like > rt 10 bash   everything you run from
> the new bash prompt will be at priority 10.  You must be root to run rt

Yes, I do like I've posted in all the related threads.

Here is some more input for you. I hope it could help nail it down.

Regards,
	Dieter

BTW I'll now switching to 2.4.10-pre14

SunWave1#time tar xIf /Pakete/Linux/linux-2.4.9.tar.bz2
34.570u 5.350s 0:47.84 83.4%    0+0k 0+0io 295pf+0w

I "hear" some have disk activities (disk trashing).

SunWave1#sync

Runs for ages!!!

User	 CPU  0%
System	 CPU  0%
Idle	 CPU 99%

So where did it wait???

Here comes what latencytimes show:

Worst 20 latency times of 5061 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
322263   reacqBKL        1  1375/sched.c         c01138b4   697/sched.c
216174        BKL        1    30/inode.c         c016b971    52/inode.c
158328        BKL        9   742/block_dev.c     c0144d51   697/sched.c
 66975        BKL        1  1101/super.c         c014250d   697/sched.c
 53560        BKL        1  1101/super.c         c014250d  1130/super.c
 37742  spin_lock        1   547/sched.c         c0111b04   795/block_dev.c
 24822  spin_lock        1   678/inode.c         c01551f7   704/inode.c
 24739  spin_lock        1   291/buffer.c        c014003c   285/buffer.c
 19330  spin_lock        1   547/sched.c         c0111b04   697/sched.c
 16566        BKL        1    30/inode.c         c016b971   697/sched.c
 14049  spin_lock        1  2043/tcp_ipv6.c      e9078837   119/softirq.c
 11993  spin_lock        1  2111/tcp_ipv4.c      c0220517   119/softirq.c
 11704        BKL        1   706/block_dev.c     c0144bd7  1381/sched.c
 11405  spin_lock        1   291/buffer.c        c014003c   280/buffer.c
 11288        BKL        1   706/block_dev.c     c0144bd7   697/sched.c
 11213   reacqBKL        9  1375/sched.c         c01138b4   696/block_dev.c
 11212  spin_lock        1   547/sched.c         c0111b04   696/block_dev.c
  7552  spin_lock        1   298/buffer.c        c013bb1c   285/buffer.c
  5013        BKL        0  2763/buffer.c        c013fbca   697/sched.c
  4641        BKL        1  1302/inode.c         c016de79   697/sched.c

SunWave1#ksymoops -m /boot/System.map -A " c01138b4 c016b971 c0144d51 
c014250d c014250d c0111b04 c01551f7 c014003c c0111b04 c016b971 e9078837 
c0220517 c0144bd7 c014003c c0144bd7 c01138b4 c0111b04 c013bb1c c013fbca 
c016de79"
ksymoops 2.4.3 on i686 2.4.10-pre12-preempt.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-pre12-preempt/ (default)
     -m /boot/System.map (specified)


Adhoc c01138b4 <preempt_schedule+34/b0>
Adhoc c016b970 <reiserfs_delete_inode+30/110>
Adhoc c0144d50 <blkdev_close+60/1b0>
Adhoc c014250c <kill_super+ac/280>
Adhoc c014250c <kill_super+ac/280>
Adhoc c0111b04 <schedule+34/550>
Adhoc c01551f6 <prune_icache+36/160>
Adhoc c014003c <kupdate+11c/210>
Adhoc c0111b04 <schedule+34/550>
Adhoc c016b970 <reiserfs_delete_inode+30/110>
Adhoc e9078836 <[ipv6]tcp6_get_info+4a6/770>
Adhoc c0220516 <tcp_get_info+4b6/7a0>
Adhoc c0144bd6 <blkdev_put+46/160>
Adhoc c014003c <kupdate+11c/210>
Adhoc c0144bd6 <blkdev_put+46/160>
Adhoc c01138b4 <preempt_schedule+34/b0>
Adhoc c0111b04 <schedule+34/550>
Adhoc c013bb1c <wait_for_locked_buffers+3c/60>
Adhoc c013fbca <sync_old_buffers+2a/130>
Adhoc c016de78 <reiserfs_dirty_inode+58/f0>

