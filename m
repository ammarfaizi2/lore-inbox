Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311486AbSCTD54>; Tue, 19 Mar 2002 22:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311501AbSCTD5u>; Tue, 19 Mar 2002 22:57:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:782 "EHLO vasquez.zip.com.au")
	by vger.kernel.org with ESMTP id <S311486AbSCTD5d>;
	Tue, 19 Mar 2002 22:57:33 -0500
Message-ID: <3C980855.C5A8CED8@zip.com.au>
Date: Tue, 19 Mar 2002 19:56:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-030-writeout_scheduling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



1: Introduces two new bdflush tunables:

  ndirty

    The maximum number of buffers which bdflush will attempt to
    write out in response to a wakeup.  Previously, bdflush would write
    out the whole world.

    So this limits the amount of bdflush writeout in response to a
    single wakeup_bdflush().

    NOTE: this code appears to be broken.  If nfract_stop_bdflush
          is set at zero, ndirty will not prevent bdflush from writing out
          all dirty buffers.   IOW, ndirty doesn't do anything at present.

  nfract_stop_bdflush

    In units of "percentage of total memory".  bdflush will stop
    writing back data when the amount of memory which is dirty on the
    buffer LRU falls below this threshold.

    So this prevents bdflush from writing out *everything*. 
    bdflush will stop, and will leave some dirty data behind for
    kupdate.

    However, `ndirty' has prececdence.  So even if the amount of
    dirty data is less than nfract_bdflush_stop, bdflush will still
    attempt to write out `ndirty' buffers.


2: The mark_buffer_dirty() -> balance_dirty() path has been changed
   so that the process which is performing write(2) no longer starts
   some I/O when we're between the async and sync thresholds.  Instead,
   we just wake bdflush.

   Also, when the writer reaches the sync threshold, we no longer
   throttle the writer by waiting on some I/O.  We just start some more
   I/O, potentially asynchronously (but, in practice, usually
   blockingly, due to request queue exhaustion).


   Both these changes have the effect of weakening the
   writer-throttling at write(2) time.  Presumably this is because the
   aa-020-sync_buffers changes now allow memory allocators to throttle
   on bdflush-written buffers more successfully.

3: kupdate no longer throttles itself on each wakeup.  That always
   seemed rather pointless.

This code works well.  Fixes the problem where copying a large file
between two disks only exercises one disk at a time.

=====================================

--- 2.4.19-pre3/fs/buffer.c~aa-030-writeout_scheduling	Tue Mar 19 19:48:53 2002
+++ 2.4.19-pre3-akpm/fs/buffer.c	Tue Mar 19 19:49:17 2002
@@ -103,22 +103,23 @@ union bdflush_param {
 	struct {
 		int nfract;	/* Percentage of buffer cache dirty to 
 				   activate bdflush */
-		int dummy1;	/* old "ndirty" */
+		int ndirty;	/* Maximum number of dirty blocks to write out per
+				   wake-cycle */
 		int dummy2;	/* old "nrefill" */
 		int dummy3;	/* unused */
 		int interval;	/* jiffies delay between kupdate flushes */
 		int age_buffer;	/* Time for normal buffer to age before we flush it */
 		int nfract_sync;/* Percentage of buffer cache dirty to 
 				   activate bdflush synchronously */
-		int dummy4;	/* unused */
+		int nfract_stop_bdflush; /* Percetange of buffer cache dirty to stop bdflush */
 		int dummy5;	/* unused */
 	} b_un;
 	unsigned int data[N_PARAM];
-} bdf_prm = {{40, 0, 0, 0, 5*HZ, 30*HZ, 60, 0, 0}};
+} bdf_prm = {{30, 500, 0, 0, 5*HZ, 30*HZ, 60, 20, 0}};
 
 /* These are the min and max parameter values that we will allow to be assigned */
-int bdflush_min[N_PARAM] = {  0,  10,    5,   25,  0,   1*HZ,   0, 0, 0};
-int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,10000*HZ, 6000*HZ, 100, 0, 0};
+int bdflush_min[N_PARAM] = {  0,  1,    0,   0,  0,   1*HZ,   0, 0, 0};
+int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,10000*HZ, 10000*HZ, 100, 100, 0};
 
 void unlock_buffer(struct buffer_head *bh)
 {
@@ -240,10 +241,9 @@ static int write_some_buffers(kdev_t dev
  */
 static void write_unlocked_buffers(kdev_t dev)
 {
-	do {
+	do
 		spin_lock(&lru_list_lock);
-	} while (write_some_buffers(dev));
-	run_task_queue(&tq_disk);
+	while (write_some_buffers(dev));
 }
 
 /*
@@ -281,12 +281,6 @@ static int wait_for_buffers(kdev_t dev, 
 	return 0;
 }
 
-static inline void wait_for_some_buffers(kdev_t dev)
-{
-	spin_lock(&lru_list_lock);
-	wait_for_buffers(dev, BUF_LOCKED, 1);
-}
-
 static int wait_for_locked_buffers(kdev_t dev, int index, int refile)
 {
 	do {
@@ -1070,6 +1064,21 @@ static int balance_dirty_state(void)
 	return -1;
 }
 
+static int bdflush_stop(void)
+{
+	unsigned long dirty, tot, dirty_limit;
+
+	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
+	tot = nr_free_buffer_pages();
+
+	dirty *= 100;
+	dirty_limit = tot * bdf_prm.b_un.nfract_stop_bdflush;
+
+	if (dirty > dirty_limit)
+		return 0;
+	return 1;
+}
+
 /*
  * if a new dirty buffer is created we need to balance bdflush.
  *
@@ -1084,19 +1093,16 @@ void balance_dirty(void)
 	if (state < 0)
 		return;
 
-	/* If we're getting into imbalance, start write-out */
-	spin_lock(&lru_list_lock);
-	write_some_buffers(NODEV);
+	wakeup_bdflush();
 
 	/*
 	 * And if we're _really_ out of balance, wait for
-	 * some of the dirty/locked buffers ourselves and
-	 * start bdflush.
+	 * some of the dirty/locked buffers ourselves.
 	 * This will throttle heavy writers.
 	 */
 	if (state > 0) {
-		wait_for_some_buffers(NODEV);
-		wakeup_bdflush();
+		spin_lock(&lru_list_lock);
+		write_some_buffers(NODEV);
 	}
 }
 
@@ -2957,13 +2963,18 @@ int bdflush(void *startup)
 	complete((struct completion *)startup);
 
 	for (;;) {
+		int ndirty = bdf_prm.b_un.ndirty;
+
 		CHECK_EMERGENCY_SYNC
 
-		spin_lock(&lru_list_lock);
-		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
-			wait_for_some_buffers(NODEV);
-			interruptible_sleep_on(&bdflush_wait);
+		while (ndirty > 0) {
+			spin_lock(&lru_list_lock);
+			if (!write_some_buffers(NODEV))
+				break;
+			ndirty -= NRSYNC;
 		}
+		if (ndirty > 0 || bdflush_stop())
+			interruptible_sleep_on(&bdflush_wait);
 	}
 }
 
@@ -2992,8 +3003,6 @@ int kupdate(void *startup)
 	complete((struct completion *)startup);
 
 	for (;;) {
-		wait_for_some_buffers(NODEV);
-
 		/* update interval */
 		interval = bdf_prm.b_un.interval;
 		if (interval) {
@@ -3021,6 +3030,7 @@ int kupdate(void *startup)
 		printk(KERN_DEBUG "kupdate() activated...\n");
 #endif
 		sync_old_buffers();
+		run_task_queue(&tq_disk);
 	}
 }
