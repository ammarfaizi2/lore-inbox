Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265622AbRFWErd>; Sat, 23 Jun 2001 00:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265624AbRFWErY>; Sat, 23 Jun 2001 00:47:24 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:15367 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265622AbRFWErK>; Sat, 23 Jun 2001 00:47:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] Early flush: new, improved
Date: Sat, 23 Jun 2001 06:41:24 +0200
X-Mailer: KMail [version 1.2]
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Tom Sightler <ttsig@tuxyturvy.com>
MIME-Version: 1.0
Message-Id: <01062306412400.00364@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The early-flush patch I posted a couple of days ago had the virtue of being 
simple and functional, but not optimal for all loads, particularly sporadic 
loads that are neither continously heavy or light.  Today's patch is not a 
lot more complex, but works quite a lot better.

The new kflush algorithm has the following goals:

  1) Start writing as soon as there is something to write
  2) But while there is other traffic, wait as long as possible
  3) Keep the IO queues full
  4) But not too full
  5) Be efficient about all of the above

As with the previous patch, I'm running the kflush loop every 100 
milliseconds, in other words, I'm using a polling strategy as opposed to 
event-oriented.  I thought about that carefully and decided the polling 
approach would be both more efficient (because otherwise the events would 
have to have been triggered from performance-critical places like 
__mark_dirty and blk_started_io) and more robust (with a timed loop it's 
easier to prove assertions about realtime performance).

The reason for goal (3) is twofold: to give the elevator something to chew 
on, and to make sure that the queue doesn't empty out before the next 
iteration of kflushd has a chance to fill it up.  Goal (4) is there to make 
sure that the system doesn't get stalled doing an early flush when the next 
surge in demand for disk bandwidth comes along.

As before, I'm measuring the actual disk traffic rather than trying to 
predict it, say by looking at the memory pressure.  I'm still lumping 
together all disks into one bandwidth number, an unspeakably crude thing to 
do, but until someone sends me a nice test machine, I'm going to continue to 
do that. ;-)

This time around I'm measuring not only the queued_sectors IO backlog, but 
the submitted_sectors submission rate as well, the latter being incremented 
in blk_started_io.  As a slight optimization I can count the retired_sectors 
as well and replace queued_sectors wherever it's used by:

    (submitted_sectors - retired_sectors)

Submitted_sectors will eventually wrap, so the rule is: it's only valid to 
look at the difference between two sampled values, much as we do with jiffies.

Theory of operation:

  - Every 100 ms kflush checks that there were no new io submissions in the
     previous 100 ms period.  If so, and the queued IO backlog is below some
     threshold, it initiates an early flush

  - Regardless of what else happens, kflush initiates a flush at intervals no 
     greater than the usual  time prescribed by the bdflush parameters.

  - The flush (flush_dirty_buffers) makes sure all buffers older than the 
      time prescribed by the bdflush parameters are submitted, then, if the
      IO backlog is less than some threshold higher than kflush's trigger
      threshold, submitts some younger buffers opportunistically, so that
      the disk bandwidth is not wasted.

As a side effect of not wasting the bandwidth we get some improvement in data 
safety, and in my opinion at least, a system that feels nicer - no disk write 
'echo'.  Also, there's the thing that started me on this, spindown 5 seconds 
early on my laptop.

One subtle detail I mentioned earlier is concerned with not allowing kflush 
to beome confused by the traffic it generates itself - this doesn't count as 
traffic for the purpose of determining whether the opportunistic flush should 
be done.  It turned out to be possible to hande this nasty-sounding 
accounting requirement with just one add:

    submitted1 += sync_old_buffers();

To make this work I changed the accounting units used by sync_old_buffers 
from 'buffers' to 'sectors'.  However, I didn't want to have to go retune the 
VM (not that it's necessarily tuned very well at the moment ;-) so I pass 
back the sectors count from sync_old_buffers when it's called from kflush, 
otherwise, the buffers count.  Naturally, this ugliness can't be allowed to 
live.

Performance
---------

Kernel compilation is almost a worst case for the early flush because of the 
frequent load changes and extensive use of temporary files.  Nonetheless, in 
the one benchmark I ran, the measured time was virtually identical with and 
without the early flush.  (Actually, 7 seconds faster with the early flush, 
but that is not statistically significant.)

Early flush:
    real    13m40.838s
    user    10m38.460s
    sys     0m51.700s

Vanilla kernel:
    real    13m47.850s
    user    12m23.610s
    sys     0m35.030s

The patch is against 2.4.5.  To apply:

  cd /your/source/tree
  patch <this/patch -p0

--- ../uml.2.4.5.clean/drivers/block/ll_rw_blk.c	Thu Apr 12 21:15:52 2001
+++ ./drivers/block/ll_rw_blk.c	Thu Jun 21 20:35:52 2001
@@ -122,6 +122,7 @@
  * of memory with locked buffers
  */
 atomic_t queued_sectors;
+atomic_t submitted_sectors;
 
 /*
  * high and low watermark for above
--- ../uml.2.4.5.clean/fs/buffer.c	Sat May 26 02:57:46 2001
+++ ./fs/buffer.c	Sat Jun 23 04:09:12 2001
@@ -1076,7 +1076,7 @@
 
 static __inline__ void __mark_dirty(struct buffer_head *bh)
 {
-	bh->b_flushtime = jiffies + bdf_prm.b_un.age_buffer;
+	bh->b_dirtytime = jiffies;
 	refile_buffer(bh);
 }
 
@@ -2524,12 +2524,17 @@
    as all dirty buffers lives _only_ in the DIRTY lru list.
    As we never browse the LOCKED and CLEAN lru lists they are infact
    completly useless. */
-static int flush_dirty_buffers(int check_flushtime)
+
+static unsigned low_queued_goal = 200;
+static unsigned high_queued_goal = 400;
+
+static int flush_dirty_buffers (int update)
 {
 	struct buffer_head * bh, *next;
-	int flushed = 0, i;
-
- restart:
+	int submitted = 0, flushed = 0, i;
+	unsigned youngest_to_flush = jiffies - bdf_prm.b_un.age_buffer;
+	
+restart:
 	spin_lock(&lru_list_lock);
 	bh = lru_list[BUF_DIRTY];
 	if (!bh)
@@ -2544,23 +2549,21 @@
 		if (buffer_locked(bh))
 			continue;
 
-		if (check_flushtime) {
-			/* The dirty lru list is chronologically ordered so
-			   if the current bh is not yet timed out,
-			   then also all the following bhs
-			   will be too young. */
-			if (time_before(jiffies, bh->b_flushtime))
-				goto out_unlock;
+		if (update) {
+			if (time_before (youngest_to_flush, bh->b_dirtytime))
+				if (atomic_read (&queued_sectors) >= high_queued_goal)
+					goto out_unlock;
 		} else {
-			if (++flushed > bdf_prm.b_un.ndirty)
+			if (flushed >= bdf_prm.b_un.ndirty)
 				goto out_unlock;
 		}
 
-		/* OK, now we are committed to write it out. */
 		atomic_inc(&bh->b_count);
 		spin_unlock(&lru_list_lock);
 		ll_rw_block(WRITE, 1, &bh);
+		submitted += bh->b_size >> 9;
 		atomic_dec(&bh->b_count);
+		flushed++;
 
 		if (current->need_resched)
 			schedule();
@@ -2569,7 +2572,12 @@
  out_unlock:
 	spin_unlock(&lru_list_lock);
 
-	return flushed;
+#ifdef DEBUG
+	if (update)
+		printk("updated %i at %lu, %u queued\n",
+			submitted, jiffies, atomic_read (&queued_sectors));
+#endif
+	return update? submitted: flushed; // should retune vm for submitted 
(sectors)
 }
 
 DECLARE_WAIT_QUEUE_HEAD(bdflush_wait);
@@ -2717,7 +2725,8 @@
 int kupdate(void *sem)
 {
 	struct task_struct * tsk = current;
-	int interval;
+	unsigned submitted0 = atomic_read (&submitted_sectors);
+	int countdown = 0;
 
 	tsk->session = 1;
 	tsk->pgrp = 1;
@@ -2733,11 +2742,11 @@
 	up((struct semaphore *)sem);
 
 	for (;;) {
-		/* update interval */
-		interval = bdf_prm.b_un.interval;
-		if (interval) {
+		unsigned check_interval = HZ/10, update_interval = bdf_prm.b_un.interval;
+		
+		if (update_interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(interval);
+			schedule_timeout(check_interval);
 		} else {
 		stop_kupdate:
 			tsk->state = TASK_STOPPED;
@@ -2756,10 +2765,17 @@
 			if (stopped)
 				goto stop_kupdate;
 		}
-#ifdef DEBUG
-		printk("kupdate() activated...\n");
-#endif
-		sync_old_buffers();
+		{
+			unsigned submitted1 = atomic_read (&submitted_sectors);
+			if ((countdown -= check_interval) < 0 || 
+				(submitted1 == submitted0 &&
+					atomic_read(&queued_sectors) < low_queued_goal))
+			{
+				submitted1 += sync_old_buffers();
+				countdown = update_interval;
+			}
+			submitted0 = submitted1;
+		}
 	}
 }
 
@@ -2774,4 +2790,3 @@
 }
 
 module_init(bdflush_init)
-
--- ../uml.2.4.5.clean/include/linux/blkdev.h	Sat May 26 03:01:40 2001
+++ ./include/linux/blkdev.h	Thu Jun 21 23:37:49 2001
@@ -177,6 +177,7 @@
 extern int * max_segments[MAX_BLKDEV];
 
 extern atomic_t queued_sectors;
+extern atomic_t submitted_sectors;
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
@@ -213,6 +214,7 @@
 	}
 
 #define blk_started_io(nsects)				\
+	atomic_add(nsects, &submitted_sectors);		\
 	atomic_add(nsects, &queued_sectors);
 
 #endif
--- ../uml.2.4.5.clean/include/linux/fs.h	Sat May 26 03:01:28 2001
+++ ./include/linux/fs.h	Tue Jun 19 15:12:18 2001
@@ -236,7 +236,7 @@
 	atomic_t b_count;		/* users using this block */
 	kdev_t b_rdev;			/* Real device */
 	unsigned long b_state;		/* buffer state bitmap (see above) */
-	unsigned long b_flushtime;	/* Time when (dirty) buffer should be written */
+	unsigned long b_dirtytime;	/* Time buffer became dirty */
 
 	struct buffer_head *b_next_free;/* lru/free list linkage */
 	struct buffer_head *b_prev_free;/* doubly linked list of buffers */
--- ../uml.2.4.5.clean/mm/filemap.c	Thu May 31 15:29:06 2001
+++ ./mm/filemap.c	Tue Jun 19 15:32:47 2001
@@ -349,7 +349,7 @@
 		if (buffer_locked(bh) || !buffer_dirty(bh) || !buffer_uptodate(bh))
 			continue;
 
-		bh->b_flushtime = jiffies;
+		bh->b_dirtytime = jiffies /*- bdf_prm.b_un.age_buffer*/; // needed??
 		ll_rw_block(WRITE, 1, &bh);	
 	} while ((bh = bh->b_this_page) != head);
 	return 0;
--- ../uml.2.4.5.clean/mm/highmem.c	Sat May 26 02:57:46 2001
+++ ./mm/highmem.c	Tue Jun 19 15:33:22 2001
@@ -400,7 +400,7 @@
 	bh->b_rdev = bh_orig->b_rdev;
 	bh->b_state = bh_orig->b_state;
 #ifdef HIGHMEM_DEBUG
-	bh->b_flushtime = jiffies;
+	bh->b_dirtytime = jiffies /*- bdf_prm.b_un.age_buffer*/; // needed??
 	bh->b_next_free = NULL;
 	bh->b_prev_free = NULL;
 	/* bh->b_this_page */

