Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282693AbRLLWb0>; Wed, 12 Dec 2001 17:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282771AbRLLWbR>; Wed, 12 Dec 2001 17:31:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16436 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282693AbRLLWbN>; Wed, 12 Dec 2001 17:31:13 -0500
Date: Wed, 12 Dec 2001 23:30:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ken Brownfield <brownfld@irridia.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011212233053.R4801@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva> <20011211014346.C4801@athlon.random> <20011212160551.A24992@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011212160551.A24992@asooo.flowerfire.com>; from brownfld@irridia.com on Wed, Dec 12, 2001 at 04:05:51PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 04:05:51PM -0600, Ken Brownfield wrote:
> On Tue, Dec 11, 2001 at 01:43:46AM +0100, Andrea Arcangeli wrote:
> | On Mon, Dec 10, 2001 at 05:08:44PM -0200, Marcelo Tosatti wrote:
> | > Andrea, 
> | > Could you please start looking at any 2.4 VM issues which show up ?
> | 
> | well, as far I can tell no VM bug should be present in my latest -aa, so
> | I think I'm finished. At the very least I know people is using 2.4.15aa1
> | and 2.4.17pre1aa1 in production on multigigabyte boxes under heavy VM
> | load and I didn't got any bugreport back yet.
> [...]
> 
> I look forward to this stuff.  2.4 mainline falls down reliably and
> completely when running updatedb on systems with a large number of used
> inodes.  Linus' VM/mmap patch helped a ton, but between general VM
> issues and the i/dcache bloat I'm hoping that I won't have to redirect
> my irritated users' ire into a karma pool to get these changes merged
> into mainline where all of the knowledgeable folks here can beat out the
> details.
> 
> I do think that the vast majority of users don't see this issue on
> small-ish UP desktops.  But I'm about to buy >100 SMP systems for
> production expansion which will most likely be effected by this issue.
> For me that emphasizes that these so-called corner cases really are
> show-stoppers for Linux-as-more-than-toy.
> 
> Gimme the /proc interface (bdflush?) and lets bang on this stuff in
> mainline.  I need to stick with the latest -pre so I can track progress,
> so 2.4.17pre4aa1 (or 10_vm-19) hasn't been a possibility for me... :-(

I finished fixing the bdflush stuff that Andrew kindly pointed out.
async writes are as fast as possible again now and I also introduced
some histeresis for bdflush to reduce the wakeup rate, plus I'm forcing
bdflush to do some significant work rather than just NRSYNC buffers. But
I'm doing some other swapout benchmarking before releasing a new -aa, I
hope to finish tomorrow. Once I'll feel to be finished I'll split out
something.

anyways here it is a preview of the bdflush fixes for Andrew. it
definitely cures the performance for me. previously there were too many
reschedule. I also wonder that the balance_dirty() should also write
nfract of buffers, instead of only NRSYNC (or maybe something less than
ndirty but more than NRSYNC). comments?

(then BUF_LOCKED will contain all the clean buffers too, and so it
cannot be accounted into balance_dirty anymore, the VM will throttle on
those locked buffers and so it's not a problem)

--- 2.4.17pre7aa1/fs/buffer.c.~1~	Mon Dec 10 16:10:40 2001
+++ 2.4.17pre7aa1/fs/buffer.c	Wed Dec 12 19:16:23 2001
@@ -105,22 +105,23 @@
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
-} bdf_prm = {{20, 0, 0, 0, 5*HZ, 30*HZ, 40, 0, 0}};
+} bdf_prm = {{30, 500, 0, 0, 5*HZ, 30*HZ, 60, 20, 0}};
 
 /* These are the min and max parameter values that we will allow to be assigned */
-int bdflush_min[N_PARAM] = {  0,  0,    0,   0,  0,   1*HZ,   0, 0, 0};
-int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,10000*HZ, 10000*HZ, 100, 0, 0};
+int bdflush_min[N_PARAM] = {  0,  1,    0,   0,  0,   1*HZ,   0, 0, 0};
+int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,10000*HZ, 10000*HZ, 100, 100, 0};
 
 void unlock_buffer(struct buffer_head *bh)
 {
@@ -181,7 +182,6 @@
 		bh->b_end_io = end_buffer_io_sync;
 		clear_bit(BH_Pending_IO, &bh->b_state);
 		submit_bh(WRITE, bh);
-		conditional_schedule();
 	} while (--count);
 }
 
@@ -217,11 +217,10 @@
 			array[count++] = bh;
 			if (count < NRSYNC)
 				continue;
-
 			spin_unlock(&lru_list_lock);
-			conditional_schedule();
 
 			write_locked_buffers(array, count);
+			conditional_schedule();
 			return -EAGAIN;
 		}
 		unlock_buffer(bh);
@@ -282,12 +281,6 @@
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
 	do
@@ -1043,7 +1036,6 @@
 	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
 
 	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
-	dirty += size_buffers_type[BUF_LOCKED] >> PAGE_SHIFT;
 	tot = nr_free_buffer_pages();
 
 	dirty *= 100;
@@ -1060,6 +1052,21 @@
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
@@ -1084,7 +1091,6 @@
 	if (state > 0) {
 		spin_lock(&lru_list_lock);
 		write_some_buffers(NODEV);
-		wait_for_some_buffers(NODEV);
 	}
 }
 
@@ -2789,13 +2795,18 @@
 	complete((struct completion *)startup);
 
 	for (;;) {
+		int ndirty = bdf_prm.b_un.ndirty;
+
 		CHECK_EMERGENCY_SYNC
 
-		spin_lock(&lru_list_lock);
-		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
-			run_task_queue(&tq_disk);
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
 



Andrea
