Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264710AbRFQKHK>; Sun, 17 Jun 2001 06:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264709AbRFQKHB>; Sun, 17 Jun 2001 06:07:01 -0400
Received: from www.wen-online.de ([212.223.88.39]:42255 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264711AbRFQKGu>;
	Sun, 17 Jun 2001 06:06:50 -0400
Date: Sun, 17 Jun 2001 12:05:10 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, <thunder7@xs4all.nl>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
In-Reply-To: <0106162344570L.00879@starship>
Message-ID: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2001, Daniel Phillips wrote:

> On Saturday 16 June 2001 23:06, Rik van Riel wrote:
> > On Sat, 16 Jun 2001, Daniel Phillips wrote:
> > > As a side note, the good old multisecond delay before bdflush kicks in
> > > doesn't really make a lot of sense - when bandwidth is available the
> > > filesystem-initiated writeouts should happen right away.
> >
> > ... thus spinning up the disk ?
>
> Nope, the disk is already spinning, some other writeouts just finished.
>
> > How about just making sure we write out a bigger bunch
> > of dirty pages whenever one buffer gets too old ?
>
> It's simpler than that.  It's basically just: disk traffic low? good, write
> out all the dirty buffers.  Not quite as crude as that, but nearly.
>
> > Does the patch below do anything good for your laptop? ;)
>
> I'll wait for the next one ;-)

Greetings!  (well, not next one, but one anyway)

It _juuust_ so happens that I was tinkering... what do you think of
something like the below?  (and boy do I ever wonder what a certain
box doing slrn stuff thinks of it.. hint hint;)

	-Mike

Doing Bonnie in big fragmented 1k bs partition on the worst spot on
the disk.  Bad benchmark, bad conditions.. but interesting results.

2.4.6.pre3 before
    -------Sequential Output-------- ---Sequential Input-- --Random--
    -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
 MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
500  9609 36.0 10569 14.3  3322  6.4  9509 47.6 10597 13.8 101.7  1.4

2.4.6.pre3 after  (using flushto behavior as in defaults)
    -------Sequential Output-------- ---Sequential Input-- --Random--
    -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
 MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
500  8293 30.2 11834 29.4  5072  9.5  8879 44.1 10597 13.6 100.4  0.9


2.4.6.pre3 after  (flushto = ndirty)
 -------Sequential Output-------- ---Sequential Input-- --Random--
 -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
 MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
500 10286 38.4 10715 14.4  3267  6.1  9605 47.6 10596 13.4 102.7  1.6


--- fs/buffer.c.org	Fri Jun 15 06:48:17 2001
+++ fs/buffer.c	Sun Jun 17 09:14:17 2001
@@ -118,20 +118,21 @@
 				wake-cycle */
 		int nrefill; /* Number of clean buffers to try to obtain
 				each time we call refill */
-		int dummy1;   /* unused */
+		int nflushto;   /* Level to flush down to once bdflush starts */
 		int interval; /* jiffies delay between kupdate flushes */
 		int age_buffer;  /* Time for normal buffer to age before we flush it */
 		int nfract_sync; /* Percentage of buffer cache dirty to
 				    activate bdflush synchronously */
-		int dummy2;    /* unused */
+		int nmonitor;    /* Size (%physpages) at which bdflush should
+		          begin monitoring the buffercache */
 		int dummy3;    /* unused */
 	} b_un;
 	unsigned int data[N_PARAM];
-} bdf_prm = {{30, 64, 64, 256, 5*HZ, 30*HZ, 60, 0, 0}};
+} bdf_prm = {{60, 64, 64, 50, 5*HZ, 30*HZ, 85, 15, 0}};

 /* These are the min and max parameter values that we will allow to be assigned */
-int bdflush_min[N_PARAM] = {  0,  10,    5,   25,  0,   1*HZ,   0, 0, 0};
-int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,600*HZ, 6000*HZ, 100, 0, 0};
+int bdflush_min[N_PARAM] = {0, 10, 5, 0, 0, 1*HZ, 0, 0, 0};
+int bdflush_max[N_PARAM] = {100,50000, 20000, 100,600*HZ, 6000*HZ, 100, 100, 0};

 /*
  * Rewrote the wait-routines to use the "new" wait-queue functionality,
@@ -763,12 +764,8 @@
 	balance_dirty(NODEV);
 	if (free_shortage())
 		page_launder(GFP_BUFFER, 0);
-	if (!grow_buffers(size)) {
+	if (!grow_buffers(size))
 		wakeup_bdflush(1);
-		current->policy |= SCHED_YIELD;
-		__set_current_state(TASK_RUNNING);
-		schedule();
-	}
 }

 void init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)
@@ -1042,25 +1039,43 @@
     1 -> sync flush (wait for I/O completion) */
 int balance_dirty_state(kdev_t dev)
 {
-	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
-
-	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
-	tot = nr_free_buffer_pages();
+	unsigned long dirty, cache, buffers = 0;
+	int i;

-	dirty *= 100;
-	soft_dirty_limit = tot * bdf_prm.b_un.nfract;
-	hard_dirty_limit = tot * bdf_prm.b_un.nfract_sync;
-
-	/* First, check for the "real" dirty limit. */
-	if (dirty > soft_dirty_limit) {
-		if (dirty > hard_dirty_limit)
+	for (i = 0; i < NR_LIST; i++)
+		buffers += size_buffers_type[i];
+	buffers >>= PAGE_SHIFT;
+	if (buffers * 100 < num_physpages * bdf_prm.b_un.nmonitor)
+		return -1;
+
+	buffers *= bdf_prm.b_un.nfract;
+	dirty = 100 * (size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT);
+	cache = atomic_read(&page_cache_size) + nr_free_pages();
+	cache *= bdf_prm.b_un.nfract_sync;
+	if (dirty > buffers) {
+		if (dirty > cache)
 			return 1;
 		return 0;
 	}
-
 	return -1;
 }

+int balance_dirty_done(kdev_t dev)
+{
+	unsigned long dirty, buffers = 0;
+	int i;
+
+	for (i = 0; i < NR_LIST; i++)
+		buffers += size_buffers_type[i];
+	buffers >>= PAGE_SHIFT;
+	buffers *= bdf_prm.b_un.nflushto;
+	dirty = 100 * (size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT);
+
+	if (dirty < buffers)
+		return 1;
+	return 0;
+}
+
 /*
  * if a new dirty buffer is created we need to balance bdflush.
  *
@@ -2528,9 +2543,15 @@
 static int flush_dirty_buffers(int check_flushtime)
 {
 	struct buffer_head * bh, *next;
-	int flushed = 0, i;
+	int flushed = 0, weight = 0, i;

  restart:
+	/*
+	 * If we have a shortage, we have been laundering and reclaiming
+	 * or will be.  In either case, we should adjust flush weight.
+	 */
+	if (!check_flushtime && current->mm)
+		weight += (free_shortage() + inactive_shortage()) >> 4;
 	spin_lock(&lru_list_lock);
 	bh = lru_list[BUF_DIRTY];
 	if (!bh)
@@ -2552,9 +2573,6 @@
 			   will be too young. */
 			if (time_before(jiffies, bh->b_flushtime))
 				goto out_unlock;
-		} else {
-			if (++flushed > bdf_prm.b_un.ndirty)
-				goto out_unlock;
 		}

 		/* OK, now we are committed to write it out. */
@@ -2563,8 +2581,14 @@
 		ll_rw_block(WRITE, 1, &bh);
 		atomic_dec(&bh->b_count);

-		if (current->need_resched)
+		if (++flushed >= bdf_prm.b_un.ndirty + weight ||
+				current->need_resched) {
+			/* kflushd and user tasks return to schedule points. */
+			if (!check_flushtime)
+				return flushed;
+			flushed = 0;
 			schedule();
+		}
 		goto restart;
 	}
  out_unlock:
@@ -2580,8 +2604,14 @@
 	if (waitqueue_active(&bdflush_wait))
 		wake_up_interruptible(&bdflush_wait);

-	if (block)
+	if (block) {
 		flush_dirty_buffers(0);
+		if (current->mm) {
+			current->policy |= SCHED_YIELD;
+			__set_current_state(TASK_RUNNING);
+			schedule();
+		}
+	}
 }

 /*
@@ -2672,7 +2702,7 @@
 int bdflush(void *sem)
 {
 	struct task_struct *tsk = current;
-	int flushed;
+	int flushed, state;
 	/*
 	 *	We have a bare-bones task_struct, and really should fill
 	 *	in a few more things so "top" and /proc/2/{exe,root,cwd}
@@ -2696,13 +2726,17 @@
 		CHECK_EMERGENCY_SYNC

 		flushed = flush_dirty_buffers(0);
+		state = balance_dirty_state(NODEV);
+		if (state == 1)
+			run_task_queue(&tq_disk);

 		/*
-		 * If there are still a lot of dirty buffers around,
-		 * skip the sleep and flush some more. Otherwise, we
-		 * go to sleep waiting a wakeup.
+		 * If there are still a lot of dirty buffers around, schedule
+		 * and flush some more. Otherwise, go back to sleep.
 		 */
-		if (!flushed || balance_dirty_state(NODEV) < 0) {
+		if (current->need_resched || state == 0)
+			schedule();
+		else if (!flushed || balance_dirty_done(NODEV)) {
 			run_task_queue(&tq_disk);
 			interruptible_sleep_on(&bdflush_wait);
 		}
@@ -2738,7 +2772,11 @@
 		interval = bdf_prm.b_un.interval;
 		if (interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
+sleep:
 			schedule_timeout(interval);
+			/* Get out of the way if kflushd is running. */
+			if (!waitqueue_active(&bdflush_wait))
+				goto sleep;
 		} else {
 		stop_kupdate:
 			tsk->state = TASK_STOPPED;

