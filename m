Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274687AbRITWvn>; Thu, 20 Sep 2001 18:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274689AbRITWve>; Thu, 20 Sep 2001 18:51:34 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:28869 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274687AbRITWv3>; Thu, 20 Sep 2001 18:51:29 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Fri, 21 Sep 2001 00:51:48 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Robert Love <rml@tech9.net>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010920225130Z274687-760+14632@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. September 2001 00:03 schrieb Oliver Xymoron:
> On Thu, 20 Sep 2001, Dieter Nützel wrote:
> > Am Donnerstag, 20. September 2001 23:10 schrieb Robert Love:
> > > On Thu, 2001-09-20 at 04:21, Andrea Arcangeli wrote:
> > > > > You've forgotten a one liner.
> > > > >
> > > > >   #include <linux/locks.h>
> > > > > +#include <linux/compiler.h>
> > > >
> > > > woops, didn't trapped it because of gcc 3.0.2. thanks.
> > > >
> > > > > But this is not enough. Even with reniced artsd (-20).
> > > > > Some shorter hiccups (0.5~1 sec).
> > > >
> > > > I'm not familiar with the output of the latency bench, but I actually
> > > > read "4617" usec as the worst latency, that means 4msec, not 500/1000
> > > > msec.
> > >
> > > Right, the patch is returning the length preemption was unavailable
> > > (which is when a lock is held) in us. So it is indded 4ms.
> > >
> > > But, I think Dieter is saying he _sees_ 0.5~1s latencies (in the form
> > > of audio skips).  This is despite the 4ms locks being held.
> >
> > Yes, that's the case. During dbench 16,32,40,48, etc...
>
> You might actually be waiting on disk I/O and not blocked.
>
> Does your audio source depend on any files (eg mp3s) and if so, could they
> be moved to a ramfs? Do the skips go away then?

Good point.

I've copied one video (MP2) and one Ogg-Vorbis file into /dev/shm.
Little bit better but hiccup still there :-(

dbench 16
Throughput 25.7613 MB/sec (NB=32.2016 MB/sec  257.613 MBit/sec)
7.500u 29.870s 1:22.99 45.0%    0+0k 0+0io 511pf+0w

Worst 20 latency times of 3298 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 11549  spin_lock        1   678/inode.c         c01566d7   704/inode.c

c01566a0 T prune_icache
c01566d7 ..... <<<<<
c0156800 T shrink_icache_memory

  7395  spin_lock        1   291/buffer.c        c014151c   285/buffer.c

c0141400 T kupdate
c014151c ..... <<<<<
c0141610 T set_buffer_async_io

  7372  spin_lock        1   291/buffer.c        c01413e3   280/buffer.c

c0141290 T bdflush
c01413e3 ..... <<<<<
c0141400 T kupdate

  5702   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c

c0114d60 T preempt_schedule
c0114d94 ..... <<<<<
c0114e10 T wake_up_process

  4744        BKL        0  2763/buffer.c        c01410aa   697/sched.c

c0141080 t sync_old_buffers
c01410aa ..... <<<<<
c01411b0 T block_sync_page

  4695  spin_lock        1   291/buffer.c        c014151c   280/buffer.c
  4551  spin_lock        1  1376/sched.c         c0114db3  1380/sched.c
  4466  spin_lock        1   547/sched.c         c0112fe4  1306/inode.c
  4464  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  4146   reacqBKL        1  1375/sched.c         c0114d94   842/inode.c
  4131  spin_lock        0   547/sched.c         c0112fe4   697/sched.c
  3900   reacqBKL        1  1375/sched.c         c0114d94   929/namei.c
  3390  spin_lock        1   547/sched.c         c0112fe4  1439/namei.c
  3191        BKL        0  1302/inode.c         c016f359   842/inode.c
  2866        BKL        0  1302/inode.c         c016f359  1381/sched.c
  2803   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
  2762        BKL        0    30/inode.c         c016ce51    52/inode.c
  2633        BKL        0  2763/buffer.c        c01410aa  1380/sched.c
  2629        BKL        0  2763/buffer.c        c01410aa  1381/sched.c
  2466  spin_lock        1   468/vmscan.c        c0133c35   415/vmscan.c

*******************************************************

dbench 16 + renice artsd -20 works
GREAT!

*******************************************************

dbench 32 and above + renice artsd -20 fail

Writing this during dbench 32 ...:-)))

dbench 32 + renice artsd -20
Throughput 18.5102 MB/sec (NB=23.1378 MB/sec  185.102 MBit/sec)
15.240u 63.070s 3:49.21 34.1%   0+0k 0+0io 911pf+0w

Worst 20 latency times of 3679 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 17625  spin_lock        1   678/inode.c         c01566d7   704/inode.c

c01566a0 T prune_icache
c01566d7 ..... <<<<<
c0156800 T shrink_icache_memory

  9829  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
  9186  spin_lock        1   547/sched.c         c0112fe4  1306/inode.c
  7447   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  7097        BKL        1  1302/inode.c         c016f359   697/sched.c
  5974  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  5231        BKL        1  1437/namei.c         c014c42f   697/sched.c
  5192  spin_lock        0  1376/sched.c         c0114db3  1380/sched.c
  4992   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  4875  spin_lock        1   305/dcache.c        c0153acd    80/dcache.c
  4390        BKL        1   927/namei.c         c014b2bf   929/namei.c
  3616   reacqBKL        0  1375/sched.c         c0114d94  1306/inode.c
  3498  spin_lock        1   547/sched.c         c0112fe4   929/namei.c
  3427  spin_lock        1   547/sched.c         c0112fe4   842/inode.c
  3323        BKL        1  1302/inode.c         c016f359  1306/inode.c
  3165        BKL        1   452/exit.c          c011af61   697/sched.c
  3059  spin_lock        1   305/dcache.c        c0153acd    86/dcache.c
  3016        BKL        1   533/inode.c         c016d9cd  1306/inode.c
  2943        BKL        1  1302/inode.c         c016f359    52/inode.c
  2904  spin_lock        1   547/sched.c         c0112fe4  1439/namei.c

Thanks,
	Dieter
