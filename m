Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRHWQd4>; Thu, 23 Aug 2001 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRHWQdg>; Thu, 23 Aug 2001 12:33:36 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:12555 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268908AbRHWQde>; Thu, 23 Aug 2001 12:33:34 -0400
Message-ID: <3B85306C.896D85C1@zip.com.au>
Date: Thu, 23 Aug 2001 09:33:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: The cause of the "VM" performance problem with 2.4.X
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F2F@us-slc-exch-3.slc.unisys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Van Maren, Kevin" wrote:
> 
> > This (rather hastily tested) patch against 2.4.9 should give O(n)
> > behaviour in write_unlocked_buffers().  Does it help?
> 
> Yes, it helps quite a bit.  Still not as good as I'd like: I don't
> dare try lots of disks yet :-(

Great, thanks.  Aside from the lock contention and stuff, how was the
actual disk throughput affected?  You said that the stock kernel
basically stops doing anything, yes?
 
> Here is the new lockmeter output (8 parallel mkfs processes on 4X
> Lion to different disks, entire mkfs execution time).
> 
> Looks like blkdev_put() holds kernel_flag for way too long.
> 

It calls fsync_dev().

There are two n^2 loops in buffer.c.  There's one on the sync_buffers()
path, which we fixed yesterday.  But there's also a potential O(2n) path
in balance_dirty().  So if we're calling mark_buffer_dirty() a lot,
this becomes quadratic.  For this to bite us the BUF_DIRTY list would
have to be "almost full" of buffers for another device.  There's also
some weird stuff in sync_buffers() - not sure what it's trying to do.
I'll take that up with the boss when he gets back from the polar bear
hunt or whatever it is they do over there.

Here's a different patch which addresses the balance_dirty() thing
as well..


--- linux-2.4.9/fs/buffer.c	Thu Aug 16 12:23:19 2001
+++ linux-akpm/fs/buffer.c	Wed Aug 22 13:16:22 2001
@@ -199,7 +199,7 @@ static void write_locked_buffers(struct 
  * return without it!
  */
 #define NRSYNC (32)
-static int write_some_buffers(kdev_t dev)
+static int write_some_buffers(kdev_t dev, struct buffer_head **start_bh)
 {
 	struct buffer_head *next;
 	struct buffer_head *array[NRSYNC];
@@ -207,6 +207,12 @@ static int write_some_buffers(kdev_t dev
 	int nr;
 
 	next = lru_list[BUF_DIRTY];
+	if (start_bh && *start_bh) {
+		if ((*start_bh)->b_list == BUF_DIRTY)
+			next = *start_bh;
+		brelse(*start_bh);
+		*start_bh = NULL;
+	}
 	nr = nr_buffers_type[BUF_DIRTY] * 2;
 	count = 0;
 	while (next && --nr >= 0) {
@@ -215,8 +221,11 @@ static int write_some_buffers(kdev_t dev
 
 		if (dev && bh->b_dev != dev)
 			continue;
-		if (test_and_set_bit(BH_Lock, &bh->b_state))
+		if (test_and_set_bit(BH_Lock, &bh->b_state)) {
+			/* Shouldn't be on BUF_DIRTY */
+			__refile_buffer(bh);
 			continue;
+		}
 		if (atomic_set_buffer_clean(bh)) {
 			__refile_buffer(bh);
 			get_bh(bh);
@@ -224,6 +233,10 @@ static int write_some_buffers(kdev_t dev
 			if (count < NRSYNC)
 				continue;
 
+			if (start_bh && next) {
+				get_bh(next);
+				*start_bh = next;
+			}
 			spin_unlock(&lru_list_lock);
 			write_locked_buffers(array, count);
 			return -EAGAIN;
@@ -243,9 +256,11 @@ static int write_some_buffers(kdev_t dev
  */
 static void write_unlocked_buffers(kdev_t dev)
 {
+	struct buffer_head *start_bh = NULL;
 	do {
 		spin_lock(&lru_list_lock);
-	} while (write_some_buffers(dev));
+	} while (write_some_buffers(dev, &start_bh));
+	brelse(start_bh);
 	run_task_queue(&tq_disk);
 }
 
@@ -1117,13 +1132,15 @@ int balance_dirty_state(kdev_t dev)
 void balance_dirty(kdev_t dev)
 {
 	int state = balance_dirty_state(dev);
+	struct buffer_head *start_bh = NULL;
 
 	if (state < 0)
 		return;
 
 	/* If we're getting into imbalance, start write-out */
 	spin_lock(&lru_list_lock);
-	write_some_buffers(dev);
+	write_some_buffers(dev, &start_bh);
+	brelse(start_bh);
 
 	/*
 	 * And if we're _really_ out of balance, wait for
@@ -2607,7 +2624,7 @@ static int sync_old_buffers(void)
 		bh = lru_list[BUF_DIRTY];
 		if (!bh || time_before(jiffies, bh->b_flushtime))
 			break;
-		if (write_some_buffers(NODEV))
+		if (write_some_buffers(NODEV, NULL))
 			continue;
 		return 0;
 	}
@@ -2706,7 +2723,7 @@ int bdflush(void *startup)
 		CHECK_EMERGENCY_SYNC
 
 		spin_lock(&lru_list_lock);
-		if (!write_some_buffers(NODEV) || balance_dirty_state(NODEV) < 0) {
+		if (!write_some_buffers(NODEV, NULL) || balance_dirty_state(NODEV) < 0) {
 			wait_for_some_buffers(NODEV);
 			interruptible_sleep_on(&bdflush_wait);
 		}
