Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSKYSuY>; Mon, 25 Nov 2002 13:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSKYSuX>; Mon, 25 Nov 2002 13:50:23 -0500
Received: from [195.223.140.107] ([195.223.140.107]:13216 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264936AbSKYSuV>;
	Mon, 25 Nov 2002 13:50:21 -0500
Date: Mon, 25 Nov 2002 19:57:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>, rwhron@earthlink.net
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.4.20-rc2-aa1 with contest
Message-ID: <20021125185719.GF9623@dualathlon.random>
References: <200211230929.31413.conman@kolivas.net> <20021124162845.GC12212@dualathlon.random> <200211251744.35509.conman@kolivas.net> <3DE1CBE5.C6576272@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DE1CBE5.C6576272@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 11:06:13PM -0800, Andrew Morton wrote:
> Con Kolivas wrote:
> > 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > >On Sat, Nov 23, 2002 at 09:29:22AM +1100, Con Kolivas wrote:
> > >> -----BEGIN PGP SIGNED MESSAGE-----
> > >> Hash: SHA1
> > >> process_load:
> > >> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > >> 2.4.18 [3]              109.5   57      119     44      1.50
> > >> 2.4.19 [3]              106.5   59      112     43      1.45
> > >> 2.4.20-rc1 [3]          110.7   58      119     43      1.51
> > >> 2.4.20-rc1aa1 [3]       110.5   58      117     43      1.51*
> > >> 2420rc2aa1 [1]          212.5   31      412     69      2.90*
> > >>
> > >> This load just copies data between 4 processes repeatedly. Seems to take
> > >> longer.
> > >
> > >you go into linux/include/blkdev.h and increase MAX_QUEUE_SECTORS to (2
> > ><< (20 - 9)) and see if it makes any differences here? if it doesn't
> > >make differences it could be the a bit increased readhaead but I doubt
> > >it's the latter.
> > 
> > No significant difference:
> > 2420rc2aa1              212.53  31%     412     69%
> > 2420rc2aa1mqs2          227.72  29%     455     71%
> 
> process_load is a CPU scheduler thing, not a disk scheduler thing.  Something
> must have changed in kernel/sched.c.
> 
> It's debatable whether 210 seconds is worse than 110 seconds in
> this test, really.  You have four processes madly piping stuff around and
> four to eight processes compiling stuff.  I don't see why it's "worse"
> that the compile happens to get 31% of the CPU time in this kernel.  One
> would need to decide how much CPU it _should_ get before making that decision.

I see, so it's probably one of the core o1 scheduler design fixes I did
in my tree to avoid losing around 60% of the available cpu power in smp
in critical workloads due design bugs in the o1 scheduler (partly
reduced by a factor of 10 in 2.5 because of the HZ=1000 but that's also
additional overhead that showup in all the userspace cpu intensive
benchmarks posted to l-k, compared to the right fix that is needed
anyways in 2.5 too since HZ=1000 only hides the problem partially, and
s390 idle patch won't let the local smp interrupts running on idle
cpus anyways). So this result should be a good thing, or anyways it's
not interesting for what we're trying to benchmark here.

> 
> > ...
> > 
> > The machine stops responding but sysrq works. It wont write anything to the
> > logs. To get the error I have to run the mem_load portion of contest, not
> > just mem_load by itself. The purpose of mem_load is to be just that - a
> > memory load during the contest benchmark and contest will kill it when it
> > finishes testing in that load. To reproduce it yourself, run mem_load then do
> > a kernel compile make -j(4xnum_cpus).  If that doesnt do it I'm not sure how
> > else you can see it. sys-rq-T shows too much stuff on screen for me to make
> > any sense of it and scrolls away without me being able to scroll up.
> 
> Try sysrq-p.

indeed it might be sysrq+p the interesting one, I would had find out
from the sysrq+t. the problem with sysrq+p is that with the improved
irq-balance patch in my tree will likely dump only 1 cpu, I should send
an IPI to get a reliable sysrq+p from all cpus at the same time like I
did in the alpha port some time ago. Of course this is not a problem at
all if his testbox is UP.

The main problem of the elevator-lowlatency patch is that it increases fariness
of an order of magnitude so it can hardly be the fastest kernel on dbench
anymore.

Again many thanks to Randy for these so useful accurate benchmarks.

2.4.20-rc1aa1                            73.92           75.22           71.79
					 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2.4.20-rc2-ac1-rmap15-O1                 53.09           54.85           51.09
2.4.20-rc2aa1                            64.60           65.33           63.98
					 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2.5.31-mm1-dl-ew                         59.55           61.51           57.00
2.5.32-mm1-dl-ew                         55.43           57.15           53.13
2.5.32-mm2-dl-ew                         54.01           57.38           47.48
2.5.33-mm1-dl-ew                         52.02           54.86           46.74
2.5.33-mm5                               49.61           53.42           41.31
2.5.40-mm1                               70.39           73.85           65.24
2.5.42                                   67.72           70.50           66.05
2.5.43-mm2                               67.32           69.92           65.11
2.5.44-mm5                               69.47           71.86           66.14
2.5.44-mm6                               69.03           71.66           64.11

you see rc2aa1 is slower than rc1aa1. Not that much as I would had expected,
I was expecting something horrible of the order of the 30mbyte/sec, so it's
quite a great result IMHO considering the queue was only 1Mbyte, but still it's
noticeable (note that the queue now is 1M even for seeks, not only for
contigous I/O, previously it was 32M for contigous I/O where it's
useless to apply the elevator because I/O is contigous in the first
place and it was something like 256k for seeks). It would be interesting
to see how dbench 192 on reiserfs reacts to this patch applied on top of
2.4.20rc2aa1. 4M is a saner value for the queue size, 1M was too small
but I wanted to show the lowest latency ever in contest.  With this one
contest should show still a very low read latency (and write latency too
unlike read-latency, if you would ever test fsync or O_SYNC/O_DIRECT and
not only read latency), but dbench should run faster, I doubt it's as
fast as rc1aa1 but it could be a good tradeoff.

--- 2.4.20rc2aa1/drivers/block/ll_rw_blk.c.~1~	2002-11-21 06:06:02.000000000 +0100
+++ 2.4.20rc2aa1/drivers/block/ll_rw_blk.c	2002-11-25 19:45:03.000000000 +0100
@@ -421,7 +421,7 @@ int blk_grow_request_list(request_queue_
 	}
 	q->batch_requests = q->nr_requests;
 	q->max_queue_sectors = max_queue_sectors;
-	q->batch_sectors = max_queue_sectors / 2;
+	q->batch_sectors = max_queue_sectors / 4;
 	BUG_ON(!q->batch_sectors);
 	atomic_set(&q->nr_sectors, 0);
 	spin_unlock_irqrestore(q->queue_lock, flags);
--- 2.4.20rc2aa1/include/linux/blkdev.h.~1~	2002-11-21 06:24:18.000000000 +0100
+++ 2.4.20rc2aa1/include/linux/blkdev.h	2002-11-25 19:44:09.000000000 +0100
@@ -244,7 +244,7 @@ extern char * blkdev_varyio[MAX_BLKDEV];
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
-#define MAX_QUEUE_SECTORS (1 << (20 - 9)) /* 1 mbytes when full sized */
+#define MAX_QUEUE_SECTORS (4 << (20 - 9)) /* 4 mbytes when full sized */
 #define MAX_NR_REQUESTS (MAX_QUEUE_SECTORS >> (10 - 9)) /* 1mbyte queue when all requests are 1k */
 
 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)

Andrea
