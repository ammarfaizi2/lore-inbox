Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274499AbRITRIZ>; Thu, 20 Sep 2001 13:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274565AbRITRIQ>; Thu, 20 Sep 2001 13:08:16 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:13483 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274499AbRITRIC>; Thu, 20 Sep 2001 13:08:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
Date: Thu, 20 Sep 2001 19:08:25 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920170810Z274499-760+14561@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Beau Kuiper wrote:
> > On Thu, 20 Sep 2001, Chris Mason wrote:
> > >
> > On Thursday, September 20, 2001 03:12:44 PM +0800 Beau Kuiper
> <kuib-kl@ljbc.wa.edu.au> wrote:
> >
> > > Hi,
> > >
> > > Resierfs on 2.4 has always been bog slow.
> > >
> > > I have identified kupdated as the culprit, and have 3 patches that fix
> > > the peformance problems I have had been suffering.
> >
> > Thanks for sending these along.
> >
> > >
> > > I would like these patches to be reviewed an put into the mainline
> > > kernel so that others can testthe changes.
> >
> > > Patch 1.
> > >
> > > This patch fixes reiserfs to use the kupdated code path when told to
> > > resync its super block, like it did in 2.2.19. This is the culpit for
> > > bad reiserfs performace in 2.4. Unfortunately, this fix relies on the
> > > second patch to work properly.
> >
> > I promised linus I would never reactivate this code, it is just too nasty
> > ;-)  The problem is that write_super doesn't know if it is called from
> > sync or from kupdated.  The right fix is to have an extra param to
> > write_super, or another super_block method that gets called instead of
> > write_super when an immediate commit is not required.

I examined that ReiserFS suffer from kupdated since 2.4.7-ac3.
When ever I do "kill -STOP kupdated" the performance is much better.
I know this is unsafe...

> I don't think that this could happen until 2.5.x though, as either
> solution touches every file system. However, if we added an extra methed,
> we could do this while only slightly touching the other filesystems (where
> kupdated sync == real sync) Simply see if the method exists (is non-null)
> and call that instead with a kupdate sync instead of the normal
> super_sync. Are you interested in me writing a patch to do this?
>
> >
> > It is possible to get almost the same behaviour as 2.2.x by changing the
> > metadata sync interval in bdflush to 30 seconds.
> >
>
> But then kupdate doesn't flush normal data as regularly as it should, plus
> it is almost as messy as Patch 1 :-)
>
> > >
> > > Patch 2
> > >
> > > This patch implements a simple mechinism to ensure that each superblock
> > > only gets told to be flushed once. With reiserfs and the first patch,
> > > the superblock is still dirty after being told to sync (probably
> > > becasue it doesn't want to write out the entire journal every 5 seconds
> > > when kupdate calls it). This caused an infinite loop because sync_supers
> > > would always find the reiserfs superblock dirty when called from
> > > kupdated. I am not convinced that this patch is the best one for this
> > > problem (suggestions?)
> >
> > It is ok to leave the superblock dirty, after all, since the commit wasn't
> > done, the super is still dirty.  If the checks from reiserfs_write_super
> > are actually slowing things down, then it is probably best to fix the
> > checks.
>
> I meant, there might be better wway to prevent the endless loop than
> adding an extra field to the superblock data structure. I beleive (I
> havn't explored reiserfs code much) the slowdown is caused by the journal
> being synced with the superblock, thus causing:
>
> 1) Too much contention for disk resources.
> 2) A huge increase in the number of times programs must be suspended to
> wait for the disk

Please have a look at Robert Love's Linux kernel preemption patches and the 
conversation about my reported latency results.

It seems that ReiserFS is involved in the poor audio behavior (hiccups during 
MP2/MP3/Ogg-Vorbis playback).

Re: [PATCH] Preemption Latency Measurement Tool
http://marc.theaimsgroup.com/?l=linux-kernel&m=100097432006605&w=2

Taken from Andrea's latest post:

> those are kernel addresses, can you resolve them via System.map rather
> than trying to find their start/end line number?
>
> > Worst 20 latency times of 8033 measured in this period.
> >   usec      cause     mask   start line/file      address   end line/file
> >  10856  spin_lock        1  1376/sched.c         c0114db3   697/sched.c

I can (with Randy Dunlap's ksysmap, 
http://www.osdlab.org/sw_resources/scripts/ksysmap).

SunWave1>./ksysmap /boot/System.map c0114db3
ksysmap: searching '/boot/System.map' for 'c0114db3'

c0114d60 T preempt_schedule
c0114db3 ..... <<<<<
c0114e10 T wake_up_process

> with dbench 48 we gone to 10msec latency as far I can see (still far
> from 0.5~1 sec). dbench 48 is longer so more probability to get the
> higher latency, and it does more I/O, probably also seeks more, so thre
> are many variables (slower insection in I/O queues first of all, etcll).
> However 10msec isn't that bad, it means 100hz, something that the human
> eye cannot see. 0.5~1 sec would been horribly bad latency instead.. :)
>
> >   10705        BKL        1  1302/inode.c         c016f359   697/sched.c

c016f300 T reiserfs_dirty_inode
c016f359 ..... <<<<<
c016f3f0 T reiserfs_sync_inode

> >   10577  spin_lock        1  1376/sched.c         c0114db3   303/namei.c

c0114d60 T preempt_schedule
c0114db3 ..... <<<<<
c0114e10 T wake_up_process

> >   9427  spin_lock        1   547/sched.c         c0112fe4   697/sched.c

c0112fb0 T schedule
c0112fe4 ..... <<<<<
c0113500 T __wake_up

> >   8526   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c

c0114d60 T preempt_schedule
c0114d94 ..... <<<<<
c0114e10 T wake_up_process

> >   4492   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c

c0114d60 T preempt_schedule
c0114d94 ..... <<<<<
c0114e10 T wake_up_process

> >   4171        BKL        1  1302/inode.c         c016f359  1381/sched.c

c016f300 T reiserfs_dirty_inode
c016f359 ..... <<<<<
c016f3f0 T reiserfs_sync_inode

> >   3902   reacqBKL        0  1375/sched.c         c0114d94  1306/inode.c

c0114d60 T preempt_schedule
c0114d94 ..... <<<<<
c0114e10 T wake_up_process

> >   3376  spin_lock        0  1376/sched.c         c0114db3  1380/sched.c

c0114d60 T preempt_schedule
c0114db3 ..... <<<<<
c0114e10 T wake_up_process

> >   3132        BKL        0  1302/inode.c         c016f359  1380/sched.c

c016f300 T reiserfs_dirty_inode
c016f359 ..... <<<<<
c016f3f0 T reiserfs_sync_inode

> >   3096  spin_lock        1   547/sched.c         c0112fe4  1380/sched.c

c0112fb0 T schedule
c0112fe4 ..... <<<<<
c0113500 T __wake_up

> >   2808        BKL        0    30/inode.c         c016ce51  1381/sched.c

c016ce20 T reiserfs_delete_inode
c016ce51 ..... <<<<<
c016cf30 t _make_cpu_key

> >   2807  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c

c0112fb0 T schedule
c0112fe4 ..... <<<<<
c0113500 T __wake_up

> >   2782        BKL        0   452/exit.c          c011af61  1380/sched.c

c011ae30 T do_exit
c011af61 ..... <<<<<
c011b190 T complete_and_exit

> >   2631  spin_lock        0   483/dcache.c        c0153efa   520/dcache.c

c0153ec0 t select_parent
c0153efa ..... <<<<<
c0153fc0 T shrink_dcache_parent

> >   2533        BKL        0   533/inode.c         c016d9cd  1380/sched.c

c016d930 T reiserfs_get_block
c016d9cd ..... <<<<<
c016e860 t init_inode

> >   2489        BKL        0   927/namei.c         c014b2bf  1380/sched.c

c014b210 T vfs_create
c014b2bf ..... <<<<<
c014b360 T open_namei

> >   2389        BKL        1   452/exit.c          c011af61    52/inode.c

c011ae30 T do_exit
c011af61 ..... <<<<<
c011b190 T complete_and_exit

> >   2369        BKL        1  1302/inode.c         c016f359   842/inode.c

c016f300 T reiserfs_dirty_inode
c016f359 ..... <<<<<
c016f3f0 T reiserfs_sync_inode

> >   2327        BKL        1    30/inode.c         c016ce51  1380/sched.c

c016ce20 T reiserfs_delete_inode
c016ce51 ..... <<<<<
c016cf30 t _make_cpu_key

> 3) Poor CPU utilization in code that uses the filesystem regularly (like
> compiling)

Unneeded kernel locks/stalls which hurt latency and (global) throughput.

>
> >
> > >
> > > Patch 3
> > >
> > > This patch was generated as I was exploring the buffer cache, wondering
> > > why reiserfs was so slow on 2.4. I found that kupdated may write buffers
> > > that are not actually old back to disk. Eg
> > >
> > > Imagine that there are 20 dirty buffers. 16 of them are more that 30
> > > seconds old (and should be written back), but the other 4 are younger
> > > than 30 seconds. The current code would force all 20 out to disk,
> > > interrupting
> > > programs still using the young 4 until the disk write was complete.
> > >
> > > I know that it isn't a major problem, but I found it and I have written
> > > the patch for it :-)
> > >
> > > Please try out these patches and give comments about style, performace
> > > ect. They fixed my problems, sliced almost a minute off 2.2.19 kernel
> > > compile time on my duron 700 (from 4min 30sec to 3min 45sec)
> >
> > Doe you have the results of the individual fixes?
>
> Patch 3 doesn't improve performace much (even in theory the number of
> dirty buffers being wrongly flushed is pretty low)
>
> Patch 2 doesn't improve performace at all (unless you apply patch 1,
> without it, the computer will bog itself into the ground on the
> first kupdated)
>
> Patch 1 makes a huge difference because it stops reiserfs from reacting
> badly on a kupdated.
>
> Are there any good benchmarks you want me to run, on the plain and modded
> kernels.

I will do some benchmarks against Andrea's VM
2.4.10-pre12 + patch-rml-2.4.10-pre12-preempt-kernel-1 + 
patch-rml-2.4.10-pre12-preempt-stats-1

Hope this post isn't to long and nonbody feels offended.

Regards,
	Dieter
