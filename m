Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272111AbRHVUTT>; Wed, 22 Aug 2001 16:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272110AbRHVUTK>; Wed, 22 Aug 2001 16:19:10 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:12306 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272108AbRHVUS4>; Wed, 22 Aug 2001 16:18:56 -0400
Message-ID: <3B8413C1.8815FAFB@zip.com.au>
Date: Wed, 22 Aug 2001 13:19:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: The cause of the "VM" performance problem with 2.4.X
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F24@us-slc-exch-3.slc.unisys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Van Maren, Kevin" wrote:
> 
> ...
> 
> I've been running Linux on IA64 (4 CPU LION, 8GB RAM).  2.4.4+IA64 patches through
> 2.4.8+IA64 patches all exhibit "horiffic" I/O behavior [disks are basically inactive,
> with occasional flickers, but the CPUs are pegged at 100% system time] when writing
> to multiple disks using multiple CPUs.  The easiest way for me to reproduce the
> problem is to run parallel "mkfs" processes (I use 4 SCSI disks).
> 
> First thing to do is to profile the kernel, to see why all 4 of my fast IA64
> processors are pegged at 99%+ in the kernel (and see what they are doing).
> So I get the kernel profile patches from SGI (http://oss.sgi.com/projects/kernprof/)
> and patch my kernel.  Profile 30 seconds during the "mkfs" process on 4 disks
> (plus a "sync" part way through for kicks).  Below is the "interesting" part
> of the output (truncated for brevity):

Note how fsync_dev() passes the target device to sync_buffers().  But
the dirty buffer list is global.  So to write out the dirty buffers
for a particular device, write_locked_buffers() has to do a linear
walk of the dirty buffers for *other* devices to find the target
device.

And write_unlocked_buffers() uses a quite common construct - it
scans a list but when it drops the lock, it restarts the scan
from the start of the list.  (We do this all over the kernel, and
it keeps on biting us).

So if the dirty buffer list has 10,000 buffers for device A and
then 10,000 buffers for device B, and you call fsync_dev(B),
we end up traversing the 10,000 buffers of device A 10,000/32 times,
which is a lot.

In fact, write_unlocked_buffers(A) shoots itself in the foot by
moving buffers for device A onto BUF_LOCKED, and then restarting the
scan.  So of *course* we end up with zillions on non-A buffers at the
head of the list.

fsync_dev() and balance_dirty() are the culprits in this scenario - I'd
be surprised if sys_sync() displayed similar quadratic behaviour.  (Well, it
would do so if there were a lot of locked buffers on BUF_DIRTY, but there
usually aren't).

This (rather hastily tested) patch against 2.4.9 should give O(n)
behaviour in write_unlocked_buffers().  Does it help?


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
