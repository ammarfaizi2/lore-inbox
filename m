Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264846AbRFZBh6>; Mon, 25 Jun 2001 21:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264851AbRFZBhr>; Mon, 25 Jun 2001 21:37:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:57095 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264846AbRFZBhl>; Mon, 25 Jun 2001 21:37:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] Early flush: new, improved (updated)
Date: Tue, 26 Jun 2001 03:40:51 +0200
X-Mailer: KMail [version 1.2]
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Tom Sightler <ttsig@tuxyturvy.com>
In-Reply-To: <01062306412400.00364@starship>
In-Reply-To: <01062306412400.00364@starship>
MIME-Version: 1.0
Message-Id: <0106260340510A.01008@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an incremental update to the early flush patch.

Changes:

  - flush_dirty_buffers returns sectors flushed instead of buffers flushed

  - submitted_sectors now treated as signed for robustness

  - misc cleanups

To do:

  - Add retired_sectors, redefine queued_sectors in terms of submitted and
    retired.

  - Let the user set the bandwidth estimate through the bdflush_param
    interface or alternatively, attempt to measure the bandwidth automatically

The first item needs a careful audit to make sure the two variables can't get 
out of sync, specifically, to ensure their mutual consistancy is properly 
protected by the io_request_lock.  The retired_sectors value would be useful 
for automatic estimation of disk throughput but regardless of whether it gets 
used this way, it is slightly more efficient to derive queued_sectors than to 
maintain it explicitly, and this also eliminates the chance for it to get out 
of sync with submitted_sectors.

I expect automatic estimation of disk throughput to be a tricky item.  It's 
possible it would be better to leave it to be estimated in userspace via 
hdparm -t.

The default settings for low_queued_goal and high_queued_goal are probably 
way too low, which would have the effect of limiting the rate at which the 
early flush proceeds.  These are supposed to be set to the disk throughput in 
terms of sectors per 100 ms polling interval, and twice that, respectively.  
The low setting should not cause any performance degradation but it would 
probably eliminate the chance to see any significant throughput increase.  
Currently I'm working under the theory that the patch should never cause a 
performance loss and should sometimes show a performance gain.  I'd 
appreciate hearing feedback from anyone who feels inspired to do some tests 
:-)

As before, the patch is against 2.4.5.  To apply:

  cd /your/source/tree
  patch <this/patch -p0

--- ../uml.2.4.5.clean/drivers/block/ll_rw_blk.c	Thu Apr 12 21:15:52 2001
+++ ./drivers/block/ll_rw_blk.c	Tue Jun 26 01:20:29 2001
@@ -122,6 +122,7 @@
  * of memory with locked buffers
  */
 atomic_t queued_sectors;
+atomic_t submitted_sectors;
 
 /*
  * high and low watermark for above
--- ../uml.2.4.5.clean/fs/buffer.c	Sat May 26 02:57:46 2001
+++ ./fs/buffer.c	Tue Jun 26 02:20:04 2001
@@ -1076,7 +1076,7 @@
 
 static __inline__ void __mark_dirty(struct buffer_head *bh)
 {
-	bh->b_flushtime = jiffies + bdf_prm.b_un.age_buffer;
+	bh->b_dirtytime = jiffies;
 	refile_buffer(bh);
 }
 
@@ -2524,12 +2524,18 @@
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
+	unsigned sectors_to_flush = bdf_prm.b_un.ndirty << 3;
+	unsigned youngest_to_flush = jiffies - bdf_prm.b_un.age_buffer;
+	int submitted = 0, i;
+	
+restart:
 	spin_lock(&lru_list_lock);
 	bh = lru_list[BUF_DIRTY];
 	if (!bh)
@@ -2544,22 +2550,18 @@
 		if (buffer_locked(bh))
 			continue;
 
-		if (check_flushtime) {
-			/* The dirty lru list is chronologically ordered so
-			   if the current bh is not yet timed out,
-			   then also all the following bhs
-			   will be too young. */
-			if (time_before(jiffies, bh->b_flushtime))
-				goto out_unlock;
-		} else {
-			if (++flushed > bdf_prm.b_un.ndirty)
+		if (update) {
+			if (time_before (youngest_to_flush, bh->b_dirtytime))
+				if (atomic_read (&queued_sectors) >= high_queued_goal)
+					goto out_unlock;
+		} else
+			if (sectors_to_flush >= sectors_to_flush)
 				goto out_unlock;
-		}
 
-		/* OK, now we are committed to write it out. */
 		atomic_inc(&bh->b_count);
 		spin_unlock(&lru_list_lock);
 		ll_rw_block(WRITE, 1, &bh);
+		submitted += bh->b_size >> 9;
 		atomic_dec(&bh->b_count);
 
 		if (current->need_resched)
@@ -2569,7 +2571,12 @@
  out_unlock:
 	spin_unlock(&lru_list_lock);
 
-	return flushed;
+#ifdef DEBUG
+	if (update)
+		printk("updated %i at %lu, %u queued\n",
+			submitted, jiffies, atomic_read (&queued_sectors));
+#endif
+	return submitted;
 }
 
 DECLARE_WAIT_QUEUE_HEAD(bdflush_wait);
@@ -2717,7 +2724,7 @@
 int kupdate(void *sem)
 {
 	struct task_struct * tsk = current;
-	int interval;
+	int submitted0 = atomic_read (&submitted_sectors), countdown = 0;
 
 	tsk->session = 1;
 	tsk->pgrp = 1;
@@ -2733,11 +2740,12 @@
 	up((struct semaphore *)sem);
 
 	for (;;) {
-		/* update interval */
-		interval = bdf_prm.b_un.interval;
-		if (interval) {
+		unsigned sync_interval = bdf_prm.b_un.interval;
+		unsigned poll_interval = HZ/10;
+		
+		if (sync_interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(interval);
+			schedule_timeout(poll_interval);
 		} else {
 		stop_kupdate:
 			tsk->state = TASK_STOPPED;
@@ -2756,10 +2764,17 @@
 			if (stopped)
 				goto stop_kupdate;
 		}
-#ifdef DEBUG
-		printk("kupdate() activated...\n");
-#endif
-		sync_old_buffers();
+		{
+			int submitted1 = atomic_read (&submitted_sectors);
+			if ((countdown -= poll_interval) < 0 || 
+				(submitted1 == submitted0 &&
+					atomic_read(&queued_sectors) < low_queued_goal))
+			{
+				submitted1 += sync_old_buffers();
+				countdown = sync_interval;
+			}
+			submitted0 = submitted1;
+		}
 	}
 }
 
@@ -2774,4 +2789,3 @@
 }
 
 module_init(bdflush_init)
-
--- ../uml.2.4.5.clean/include/linux/blkdev.h	Sat May 26 03:01:40 2001
+++ ./include/linux/blkdev.h	Tue Jun 26 01:45:40 2001
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
+++ ./include/linux/fs.h	Tue Jun 26 01:20:30 2001
@@ -236,7 +236,7 @@
 	atomic_t b_count;		/* users using this block */
 	kdev_t b_rdev;			/* Real device */
 	unsigned long b_state;		/* buffer state bitmap (see above) */
-	unsigned long b_flushtime;	/* Time when (dirty) buffer should be written */
+	unsigned long b_dirtytime;	/* Time buffer became dirty */
 
 	struct buffer_head *b_next_free;/* lru/free list linkage */
 	struct buffer_head *b_prev_free;/* doubly linked list of buffers */
--- ../uml.2.4.5.clean/mm/filemap.c	Thu May 31 15:29:06 2001
+++ ./mm/filemap.c	Tue Jun 26 01:20:30 2001
@@ -349,7 +349,7 @@
 		if (buffer_locked(bh) || !buffer_dirty(bh) || !buffer_uptodate(bh))
 			continue;
 
-		bh->b_flushtime = jiffies;
+		bh->b_dirtytime = jiffies /*- bdf_prm.b_un.age_buffer*/; // needed??
 		ll_rw_block(WRITE, 1, &bh);	
 	} while ((bh = bh->b_this_page) != head);
 	return 0;
--- ../uml.2.4.5.clean/mm/highmem.c	Sat May 26 02:57:46 2001
+++ ./mm/highmem.c	Tue Jun 26 01:20:30 2001
@@ -400,7 +400,7 @@
 	bh->b_rdev = bh_orig->b_rdev;
 	bh->b_state = bh_orig->b_state;
 #ifdef HIGHMEM_DEBUG
-	bh->b_flushtime = jiffies;
+	bh->b_dirtytime = jiffies /*- bdf_prm.b_un.age_buffer*/; // needed??
 	bh->b_next_free = NULL;
 	bh->b_prev_free = NULL;
 	/* bh->b_this_page */
