Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWEPWXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWEPWXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWEPWXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:23:30 -0400
Received: from mga03.intel.com ([143.182.124.21]:12370 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932216AbWEPWX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:23:28 -0400
X-IronPort-AV: i="4.05,135,1146466800"; 
   d="scan'208"; a="37423003:sNHT1131094741"
Subject: [RFC][PATCH] MD RAID Acceleration: Move stripe operations outside
	the spin lock
From: Dan Williams <dan.j.williams@intel.com>
To: linux-raid@vger.kernel.org, Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, dan.j.williams@gmail.com,
       daniel.j.thompson@intel.com, Chris Leech <christopher.leech@intel.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 15:22:51 -0700
Message-Id: <1147818171.18360.14.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second revision of the effort to enable offload of MD's xor
and copy operations to dedicated hardware resources.  Please comment on
the approach of this patch and whether it will be suitable to expand
this to the other areas in handle_stripe where such calculations are
performed.  Implementation of the xor offload API is a work in progress,
the intent is to reuse I/OAT.

Overview:
Neil, as you recommended, this implementation flags the necessary
operations on a stripe and then queues the execution to a separate
thread (similar to how disk cycles are handled).  See the comments added
to raid5.h for more details.

This was prepared before the raid5/raid6 merge, and applies against
Linus' git tree at commit 716f8954fb3029ca2df52a986b60af8d06f093ee

--- 

[PATCH] Move stripe operations outside the spin lock

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

---

 drivers/md/raid5.c         |  391 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/raid/raid5.h |   52 ++++++
 2 files changed, 422 insertions(+), 21 deletions(-)

cb744f0f0ea60afd7c847f6dc4e5ebaad7faee90
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3184360..9f7ae26 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -862,6 +862,144 @@ static void compute_block(struct stripe_
 	set_bit(R5_UPTODATE, &sh->dev[dd_idx].flags);
 }
 
+static int handle_write_operations(struct stripe_head *sh, int rcw)
+{
+	int i, pd_idx = sh->pd_idx, disks = sh->disks;
+	int ops=0, start=0, rcw_complete=0, rmw_complete=0;
+
+	PRINTK("%s, stripe %llu, state %lx\n", 
+		__FUNCTION__, (unsigned long long)sh->sector, sh->state);
+
+	/* If no operation is currently pending use the rcw flag to
+	 * select an operation
+	 */
+	if (!(test_bit(STRIPE_OP_RCW, &sh->state) ||
+		test_bit(STRIPE_OP_RMW, &sh->state))) {
+		if (rcw==0)
+			set_bit(STRIPE_OP_RCW, &sh->state);
+		else {
+			BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags));
+			set_bit(STRIPE_OP_RMW, &sh->state);
+		}
+		start++;
+	} else if (unlikely(test_bit(STRIPE_OP_RCW, &sh->state) &&
+	      		    test_bit(STRIPE_OP_RMW, &sh->state)))
+		BUG();
+
+	if (test_bit(STRIPE_OP_RMW, &sh->state)) {
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (i==pd_idx)
+				continue;
+
+			/* enter stage 1 of read modify write operation
+			 * (prevent new rmw operations while one is in flight)
+			 */
+			if (start && dev->towrite &&
+			    test_bit(R5_UPTODATE, &dev->flags)) {
+				set_bit(R5_LOCKED, &dev->flags);
+				set_bit(R5_WantRMWXorPre, &dev->flags);
+				ops++;
+			/* stage 1 -> stage 2 */
+			} else if (test_and_clear_bit(R5_WantRMWXorPre,
+					&dev->flags)) {
+				set_bit(R5_WantRMWDrain, &dev->flags);
+				ops++;
+			/* stage 2 -> stage 3 */
+			} else if (test_and_clear_bit(R5_WantRMWDrain,
+					&dev->flags)) {
+				set_bit(R5_WantRMWXorPost, &dev->flags);
+				set_bit(R5_UPTODATE, &dev->flags);
+				ops++;
+			/* stage 3 -> completion */
+			} else if (test_and_clear_bit(R5_WantRMWXorPost,
+					&dev->flags)) {
+				/* synchronous block_ops routines may be done 
+				 * at this point
+				 */
+				if (test_bit(STRIPE_OP_RMW, &sh->op_completion))
+					rmw_complete++;
+				/* signal the workqueue to complete this op */
+				else {
+					set_bit(R5_WantRMWCompletion,
+						&dev->flags);
+					ops++;
+				}
+			/* finish read modify write */
+			} else if (test_and_clear_bit(R5_WantRMWCompletion,
+					&dev->flags))
+				rmw_complete++;
+		}
+	} else if (test_bit(STRIPE_OP_RCW, &sh->state)) {
+		for (i=disks ; i-- ;) {
+			int pd_start=0;
+			struct r5dev *dev = &sh->dev[i];
+
+			/* enter stage 1 of reconstruct write operation
+			 * (prevent new rcw operations while one is in flight)
+			 */
+			if (start && i!=pd_idx && dev->towrite) {
+				set_bit(R5_LOCKED, &dev->flags);
+				set_bit(R5_WantRCWDrain, &dev->flags);
+				 /* The parity disk 'zero' operation can run concurrently
+				  * with the bio drain
+				  */
+				if (!pd_start) {
+					pd_start++;
+					set_bit(R5_WantZero, &sh->dev[pd_idx].flags);
+				}
+				ops++;
+			/* stage 1 -> stage 2 */
+			} else if (test_and_clear_bit(R5_WantRCWDrain,
+					&dev->flags)) {
+				set_bit(R5_UPTODATE, &dev->flags);
+				set_bit(R5_WantRCWXor, &dev->flags);
+				ops++;
+			/* stage 2 -> completion */
+			} else if (test_and_clear_bit(R5_WantRCWXor,
+					&dev->flags)) {
+				/* synchronous block_ops routines may be done 
+				 * at this point
+				 */
+				if (test_bit(STRIPE_OP_RCW, &sh->op_completion))
+					rcw_complete++;
+				/* signal the workqueue to complete this op */
+				else {
+					set_bit(R5_WantRCWCompletion,
+						&dev->flags);
+					ops++;
+				}
+			/* finish reconstruct write */
+			} else if (test_and_clear_bit(R5_WantRCWCompletion,
+					&dev->flags))
+				rcw_complete++;
+		}
+	}
+
+	/* keep the parity disk locked while asynchronous operations
+	 * are in flight
+	 */
+	if (ops) {
+		set_bit(R5_LOCKED, &sh->dev[pd_idx].flags);
+		clear_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+		set_bit(STRIPE_OP_LOCKED, &sh->state);
+		sh->op_count++;
+	} else {
+		set_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+		/* to do: add assertions if (rcw_complete || rmw_complete) != nr disks */
+		if (rcw_complete) {
+			clear_bit(STRIPE_OP_RCW, &sh->state);
+			clear_bit(STRIPE_OP_RCW, &sh->op_completion);
+		}
+		if (rmw_complete) {
+			clear_bit(STRIPE_OP_RMW, &sh->state);
+			clear_bit(STRIPE_OP_RMW, &sh->op_completion);
+		}
+	}
+
+	return ops;
+}
+
 static void compute_parity(struct stripe_head *sh, int method)
 {
 	raid5_conf_t *conf = sh->raid_conf;
@@ -1044,6 +1182,133 @@ static int stripe_to_pdidx(sector_t stri
 }
 
 
+static inline void drain_bio(struct bio *wbi, sector_t sector, struct page *page)
+{
+	while (wbi && wbi->bi_sector < sector + STRIPE_SECTORS) {
+		copy_data(1, wbi, page, sector);
+		wbi = r5_next_bio(wbi, sector);
+	}
+}
+
+/*
+ * raid5_do_soft_block_ops - perform block memory operations on stripe data
+ * outside the spin lock.
+ */
+static void raid5_do_soft_block_ops(void *stripe_work_data)
+{
+	struct stripe_work *sw = stripe_work_data;
+	struct stripe_head *sh = sw->sh;
+	raid5_conf_t *conf = sh->raid_conf;
+	int i, pd_idx = sh->pd_idx, disks = sh->disks, count = 1;
+	void *ptr[MAX_XOR_BLOCKS];
+	struct bio *chosen;
+	int overlap=0, rmw_complete=0, rcw_complete=0;
+
+	/* release resources for next op to be queued */
+	if (unlikely(sw->lock))
+		mutex_unlock(sw->lock);
+	else
+		kfree(sw);
+
+	/* it is safe to read the state bits outside the stripe lock because the
+	 * the stripe will be on the wait_for_block_ops queue or pending in the
+	 * handle_list
+	 */
+	if (test_bit(STRIPE_OP_RMW, &sh->state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_RMW\n", __FUNCTION__,
+			(unsigned long long)sh->sector);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_bit(R5_WantRMWXorPre, &dev->flags)) {
+				ptr[count++] = page_address(dev->page);
+				/* ? is the device_lock necessary; compute_parity
+				 * does not lock for this operation ?
+				 */
+				chosen = dev->towrite;
+				dev->towrite = NULL;
+
+				overlap++;
+
+				BUG_ON(dev->written);
+				dev->written = chosen;
+				check_xor();
+			} else if (test_bit(R5_WantRMWDrain, &dev->flags)) {
+				drain_bio(dev->written,
+					  dev->sector,
+					  dev->page);
+			} else if (test_bit(R5_WantRMWXorPost, &dev->flags)) {
+				ptr[count++] = page_address(dev->page);
+				check_xor();
+				rmw_complete++;
+			} else if (test_bit(R5_WantCompletion, &dev->flags))
+				rmw_complete++;
+		}
+	} else if (test_bit(STRIPE_OP_RCW, &sh->state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_RCW\n", __FUNCTION__,
+			(unsigned long long)sh->sector);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		for (i= disks; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (i==pd_idx && test_bit(R5_WantZero, &dev->flags)) {
+				memset(ptr[0], 0, STRIPE_SIZE);
+			} else if (test_bit(R5_WantRCWDrain, &dev->flags)) {
+				/* ? is the device_lock necessary; compute_parity
+				 * does not lock for this operation ?
+				 */
+				chosen = dev->towrite;
+				dev->towrite = NULL;
+
+				BUG_ON(dev->written);
+				dev->written = chosen;
+
+				overlap++;
+
+				drain_bio(dev->written,
+					  dev->sector,
+					  dev->page);
+			} else if (test_bit(R5_WantRCWXor, &dev->flags)) {
+				ptr[count++] = page_address(dev->page);
+				check_xor();
+				rcw_complete++;
+			} else if (test_bit(R5_WantCompletion, &dev->flags))
+				rcw_complete++;
+
+		}
+	}
+
+	if (count != 1)
+		xor_block(count, STRIPE_SIZE, ptr);
+
+	/* We lock the stripe to ensure handle_stripe is
+	 * not running while we signal completion of operations
+	 */
+	spin_lock(&sh->lock);
+	if (! --sh->op_count) {
+		clear_bit(STRIPE_OP_LOCKED, &sh->state);
+		wake_up(&conf->wait_for_block_op);
+	}
+	
+	if (rmw_complete)
+		set_bit(STRIPE_OP_RMW, &sh->op_completion);
+	if (rcw_complete)
+		set_bit(STRIPE_OP_RCW, &sh->op_completion);
+
+	if (overlap)
+		for (i= disks; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_and_clear_bit(R5_Overlap, &dev->flags))
+				wake_up(&conf->wait_for_overlap);
+		}
+	spin_unlock(&sh->lock);
+}
+
+static struct stripe_work stripe_work_low_mem;
+static struct mutex stripe_work_mutex;
 /*
  * handle_stripe - do things to a stripe.
  *
@@ -1056,12 +1321,10 @@ static int stripe_to_pdidx(sector_t stri
  *    schedule a write of some buffers
  *    return confirmation of parity correctness
  *
- * Parity calculations are done inside the stripe lock
  * buffers are taken off read_list or write_list, and bh_cache buffers
  * get BH_Lock set before the stripe lock is released.
  *
  */
- 
 static void handle_stripe(struct stripe_head *sh)
 {
 	raid5_conf_t *conf = sh->raid_conf;
@@ -1073,13 +1336,25 @@ static void handle_stripe(struct stripe_
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
 	int non_overwrite = 0;
 	int failed_num=0;
+	int block_ops=0;
 	struct r5dev *dev;
+	DEFINE_WAIT(wait);
+
+block_op_retry:
+	prepare_to_wait(&conf->wait_for_block_op, &wait, TASK_UNINTERRUPTIBLE);
 
 	PRINTK("handling stripe %llu, cnt=%d, pd_idx=%d\n",
 		(unsigned long long)sh->sector, atomic_read(&sh->count),
 		sh->pd_idx);
 
 	spin_lock(&sh->lock);
+	if (test_bit(STRIPE_OP_LOCKED, &sh->state))
+		/* wait for the work queue to dequeue the request */
+		goto block_op_locked;
+	else
+		/* advance the stripe state */
+		finish_wait(&conf->wait_for_block_op, &wait);
+
 	clear_bit(STRIPE_HANDLE, &sh->state);
 	clear_bit(STRIPE_DELAYED, &sh->state);
 
@@ -1152,6 +1427,8 @@ static void handle_stripe(struct stripe_
 	 * need to be failed
 	 */
 	if (failed > 1 && to_read+to_write+written) {
+		int rmw_op = test_and_clear_bit(STRIPE_OP_RMW, &sh->state) ? 1 : 0;
+		int rcw_op = test_and_clear_bit(STRIPE_OP_RCW, &sh->state) ? 1 : 0;
 		for (i=disks; i--; ) {
 			int bitmap_end = 0;
 
@@ -1167,6 +1444,19 @@ static void handle_stripe(struct stripe_
 
 			spin_lock_irq(&conf->device_lock);
 			/* fail all writes first */
+			/* cancel the write operations state machine */
+			if (rmw_op) {
+				clear_bit(R5_WantRMWXorPre, &sh->dev[i].flags);
+				clear_bit(R5_WantRMWDrain, &sh->dev[i].flags);
+				clear_bit(R5_WantRMWXorPost, &sh->dev[i].flags);
+				clear_bit(R5_WantRMWCompletion, &sh->dev[i].flags);
+			}
+			if (rcw_op) {
+				clear_bit(R5_WantRCWDrain, &sh->dev[i].flags);
+				clear_bit(R5_WantRCWXor, &sh->dev[i].flags);
+				clear_bit(R5_WantRCWCompletion, &sh->dev[i].flags);
+			}
+
 			bi = sh->dev[i].towrite;
 			sh->dev[i].towrite = NULL;
 			if (bi) { to_write--; bitmap_end = 1; }
@@ -1319,7 +1609,8 @@ #endif
 	}
 
 	/* now to consider writing and what else, if anything should be read */
-	if (to_write) {
+	if (to_write || test_bit(STRIPE_OP_RCW, &sh->state) ||
+			test_bit(STRIPE_OP_RMW, &sh->state)) {
 		int rmw=0, rcw=0;
 		for (i=disks ; i--;) {
 			/* would I have to read this buffer for read_modify_write */
@@ -1391,24 +1682,32 @@ #endif
 				}
 			}
 		/* now if nothing is locked, and if we have enough data, we can start a write request */
-		if (locked == 0 && (rcw == 0 ||rmw == 0) &&
-		    !test_bit(STRIPE_BIT_DELAY, &sh->state)) {
-			PRINTK("Computing parity...\n");
-			compute_parity(sh, rcw==0 ? RECONSTRUCT_WRITE : READ_MODIFY_WRITE);
-			/* now every locked buffer is ready to be written */
-			for (i=disks; i--;)
-				if (test_bit(R5_LOCKED, &sh->dev[i].flags)) {
-					PRINTK("Writing block %d\n", i);
-					locked++;
-					set_bit(R5_Wantwrite, &sh->dev[i].flags);
-					if (!test_bit(R5_Insync, &sh->dev[i].flags)
-					    || (i==sh->pd_idx && failed == 0))
-						set_bit(STRIPE_INSYNC, &sh->state);
+		/* ...or, if we have previously started write operations we can now advance the state */
+		if ((locked == 0 && (rcw == 0 ||rmw == 0) &&
+		    !test_bit(STRIPE_BIT_DELAY, &sh->state)) ||
+		    test_bit(STRIPE_OP_RCW, &sh->state) || test_bit(STRIPE_OP_RMW, &sh->state)) {
+			int block_ops_prev = block_ops;
+			block_ops += handle_write_operations(sh, rcw);
+			if ((block_ops -  block_ops_prev) == 0) {
+				/* now every locked buffer is ready to be written */
+				for (i=disks; i--;)
+					if (test_bit(R5_LOCKED, &sh->dev[i].flags)) {
+						PRINTK("Writing block %d\n", i);
+						locked++;
+						set_bit(R5_Wantwrite, &sh->dev[i].flags);
+						if (!test_bit(R5_Insync, &sh->dev[i].flags)
+						    || (i==sh->pd_idx && failed == 0))
+							set_bit(STRIPE_INSYNC, &sh->state);
+					}
+				if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
+					atomic_dec(&conf->preread_active_stripes);
+					if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD)
+						md_wakeup_thread(conf->mddev->thread);
 				}
-			if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
-				atomic_dec(&conf->preread_active_stripes);
-				if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD)
-					md_wakeup_thread(conf->mddev->thread);
+			} else {
+				set_bit(STRIPE_HANDLE, &sh->state);
+				if (locked == 0)
+					locked += block_ops - block_ops_prev;
 			}
 		}
 	}
@@ -1555,6 +1854,27 @@ #endif
 		bi->bi_size = 0;
 		bi->bi_end_io(bi, bytes, 0);
 	}
+
+	if (block_ops) {
+		struct stripe_work *sw = kmalloc(sizeof(*sw),
+						 GFP_KERNEL);
+
+		/* in the memory allocation failure case 
+		 * use a static resource to keep operations
+		 * limping along until memory frees up
+		 */
+		if (unlikely(!sw)) {
+			mutex_lock(&stripe_work_mutex);
+			sw = &stripe_work_low_mem;
+			sw->lock = &stripe_work_mutex;
+		} else
+			sw->lock = NULL;
+
+		INIT_WORK(&sw->work, conf->do_block_ops, sw);
+		sw->sh = sh;
+		queue_work(conf->block_ops_queue, &sw->work);
+	}
+
 	for (i=disks; i-- ;) {
 		int rw;
 		struct bio *bi;
@@ -1613,6 +1933,15 @@ #endif
 			set_bit(STRIPE_HANDLE, &sh->state);
 		}
 	}
+
+	return;
+
+block_op_locked:
+	spin_unlock(&sh->lock);
+	schedule();
+	PRINTK("stripe %llu woke up from block op wait queue\n",
+		(unsigned long long)sh->sector);
+	goto block_op_retry;
 }
 
 static void raid5_activate_delayed(raid5_conf_t *conf)
@@ -2251,9 +2580,28 @@ static int run(mddev_t *mddev)
 	if ((conf->stripe_hashtbl = kzalloc(PAGE_SIZE, GFP_KERNEL)) == NULL)
 		goto abort;
 
+	sprintf(conf->workqueue_name, "%s_raid5_ops",
+		mddev->gendisk->disk_name);
+
+	/* use a single threaded work queue to maintain ordering */
+	if ((conf->block_ops_queue = __create_workqueue(conf->workqueue_name, 1))
+				     == NULL)
+		goto abort;
+
+	mutex_init(&stripe_work_mutex);
+
+	/* To Do:
+	 * 1/ Offload to asynchronous copy / xor engines
+	 * 2/ Offload to multiple cpus
+	 * 3/ Automated selection of optimal do_block_ops
+	 *	routine similar to the xor template selection
+	 */
+	conf->do_block_ops = raid5_do_soft_block_ops;
+
 	spin_lock_init(&conf->device_lock);
 	init_waitqueue_head(&conf->wait_for_stripe);
 	init_waitqueue_head(&conf->wait_for_overlap);
+	init_waitqueue_head(&conf->wait_for_block_op);
 	INIT_LIST_HEAD(&conf->handle_list);
 	INIT_LIST_HEAD(&conf->delayed_list);
 	INIT_LIST_HEAD(&conf->bitmap_list);
@@ -2401,6 +2749,8 @@ abort:
 		print_raid5_conf(conf);
 		kfree(conf->disks);
 		kfree(conf->stripe_hashtbl);
+		if (conf->block_ops_queue)
+			destroy_workqueue(conf->block_ops_queue);
 		kfree(conf);
 	}
 	mddev->private = NULL;
@@ -2421,6 +2771,7 @@ static int stop(mddev_t *mddev)
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	sysfs_remove_group(&mddev->kobj, &raid5_attrs_group);
 	kfree(conf->disks);
+	destroy_workqueue(conf->block_ops_queue);
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;
diff --git a/include/linux/raid/raid5.h b/include/linux/raid/raid5.h
index 914af66..8225dda 100644
--- a/include/linux/raid/raid5.h
+++ b/include/linux/raid/raid5.h
@@ -3,6 +3,7 @@ #define _RAID5_H
 
 #include <linux/raid/md.h>
 #include <linux/raid/xor.h>
+#include <linux/workqueue.h>
 
 /*
  *
@@ -123,6 +124,17 @@ #include <linux/raid/xor.h>
  * The refcount counts each thread that have activated the stripe,
  * plus raid5d if it is handling it, plus one for each active request
  * on a cached buffer.
+ *
+ * Block operations (copy, xor, block fill, and block compare) are executed
+ * outside the spin lock.  A stripe can have at maximum one pending request
+ * in the workqueue at a time (* some operations may be able to run concurrently,
+ * but this is a work in progress).  The STRIPE_OP_LOCK bit prevents threads from
+ * advancing the operations state machine before the work queue has had a chance
+ * to dequeue the request.  Note that this lock is only held for the enqueue/dequeue
+ * duration.  The conf->do_block_ops routine is free to submit the operation to an
+ * asynchronous engine and release the lock, as long as it maintains the completion 
+ * order of events.  The operations state machine sends a completion request when it 
+ * is time to submit the result down to disk, or up to the filesystem.
  */
 
 struct stripe_head {
@@ -133,6 +145,8 @@ struct stripe_head {
 	int			pd_idx;			/* parity disk index */
 	unsigned long		state;			/* state flags */
 	atomic_t		count;			/* nr of active thread/requests */
+	int			op_count;		/* nr of queued block operations */
+	unsigned long		op_completion;		/* ops completion flags */
 	spinlock_t		lock;
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	int			disks;			/* disks in stripe */
@@ -145,6 +159,13 @@ struct stripe_head {
 		unsigned long	flags;
 	} dev[1]; /* allocated with extra space depending of RAID geometry */
 };
+
+struct stripe_work {
+	struct work_struct work;
+	struct mutex *lock;
+	struct stripe_head *sh;
+};
+
 /* Flags */
 #define	R5_UPTODATE	0	/* page contains current data */
 #define	R5_LOCKED	1	/* IO has been submitted on "req" */
@@ -156,8 +177,25 @@ #define	R5_Wantwrite	5
 #define	R5_Overlap	7	/* There is a pending overlapping request on this block */
 #define	R5_ReadError	8	/* seen a read error here recently */
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
-
 #define	R5_Expanded	10	/* This block now has post-expand data */
+/* block operations handled by the work queue */
+#define	R5_WantZero		11	/* Prep a block to be overwritten */
+#define	R5_WantBioDrain		12	/* Drain the write data out of the bio(s) */
+#define	R5_WantBioFill		13	/* Copy read data into bio(s) */
+#define	R5_WantCompletion	14	/* Flush pending operations */
+#define	R5_WantRCWDrain		R5_WantBioDrain
+#define	R5_WantRCWXor		15	/* Compute parity across the entire stripe */
+#define	R5_WantRCWCompletion	R5_WantCompletion
+#define	R5_WantRMWXorPre	16	/* Compute initial parity for read modify write*/
+#define	R5_WantRMWDrain		R5_WantBioDrain
+#define	R5_WantRMWXorPost	17	/* Recompute parity across updated stripes */
+#define	R5_WantRMWCompletion	R5_WantCompletion
+#define	R5_WantCheckGen		R5_WantRCWXor
+#define	R5_WantCheckVerify	18	/* Verify the parity sums to zero */
+#define	R5_WantComputeBlockPrep	19	/* Hold off state transitions until DD ready */
+#define	R5_WantComputeBlockXor	20	/* Recover block via xor */
+#define	R5_Consistent		21	/* Block is HW DMA-able */
+
 /*
  * Write method
  */
@@ -179,6 +217,12 @@ #define	STRIPE_BIT_DELAY	8
 #define	STRIPE_EXPANDING	9
 #define	STRIPE_EXPAND_SOURCE	10
 #define	STRIPE_EXPAND_READY	11
+#define	STRIPE_OP_RCW		12
+#define	STRIPE_OP_RMW		13
+#define	STRIPE_OP_CHECK		14
+#define	STRIPE_OP_COMPUTE	15
+#define	STRIPE_OP_BIOFILL	16
+#define	STRIPE_OP_LOCKED	17
 /*
  * Plugging:
  *
@@ -228,11 +272,16 @@ struct raid5_private_data {
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
 
 	atomic_t		reshape_stripes; /* stripes with pending writes for reshape */
+
+	struct workqueue_struct *block_ops_queue;
+	void (*do_block_ops)(void *);
+
 	/* unfortunately we need two cache names as we temporarily have
 	 * two caches.
 	 */
 	int			active_name;
 	char			cache_name[2][20];
+	char			workqueue_name[20];
 	kmem_cache_t		*slab_cache; /* for allocating stripes */
 
 	int			seq_flush, seq_write;
@@ -252,6 +301,7 @@ struct raid5_private_data {
 	struct list_head	inactive_list;
 	wait_queue_head_t	wait_for_stripe;
 	wait_queue_head_t	wait_for_overlap;
+	wait_queue_head_t	wait_for_block_op;
 	int			inactive_blocked;	/* release of inactive stripes blocked,
 							 * waiting for 25% to be free
 							 */
-- 
1.3.0

