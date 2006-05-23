Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWEWVA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWEWVA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWEWVA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:00:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:20298 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932224AbWEWVA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:00:57 -0400
X-IronPort-AV: i="4.05,161,1146466800"; 
   d="scan'208"; a="41455306:sNHT240878827"
Subject: [RFC][PATCH] md: Move stripe operations outside the spinlock (v2)
From: Dan Williams <dan.j.williams@intel.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain
Date: Tue, 23 May 2006 14:00:50 -0700
Message-Id: <1148418050.11362.31.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a revision of the patch with the suggested changes.
-Eliminate the wait_for_block_ops queue
-Simplify the code by tracking the operations at the stripe level not
the block level
-Integrate the work struct into stripe_head (remove the need for memory
allocation)
-Make the work queue multi-threaded.  The ordering is maintained by not
advancing the operations state while STRIPE_OP_LOCKED is active.

Applies against 2.6.17-rc4.

---

[PATCH] Move stripe operations outside the spin lock (v2)

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

---

 drivers/md/raid5.c         |  334 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/raid/raid5.h |   54 +++++++
 2 files changed, 366 insertions(+), 22 deletions(-)

00e3e2bc14baea6fc25e50b9ba34f9259eadcacb
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3184360..da70f04 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -862,6 +862,116 @@ static void compute_block(struct stripe_
 	set_bit(R5_UPTODATE, &sh->dev[dd_idx].flags);
 }
 
+static int handle_write_operations(struct stripe_head *sh, int rcw)
+{
+	int i, pd_idx = sh->pd_idx, disks = sh->disks;
+	int ops=0, start=0, rcw_done=0, rmw_done=0;
+
+	PRINTK("%s, stripe %llu, state %lx, op_state %lx\n", 
+		__FUNCTION__, (unsigned long long)sh->sector, 
+		sh->state, sh->op_state);
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
+		/* enter stage 1 of read modify write operation */
+		if (start) {
+			set_bit(STRIPE_OP_RMW_XorPre, &sh->op_state);
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (i==pd_idx)
+					continue;
+
+				if (dev->towrite &&
+				    test_bit(R5_UPTODATE, &dev->flags)) {
+					set_bit(R5_LOCKED, &dev->flags);
+					ops++;
+				}
+			}
+		} else if (test_and_clear_bit(STRIPE_OP_RMW_XorPre, &sh->op_state)) {
+			set_bit(STRIPE_OP_RMW_Drain, &sh->op_state);
+			ops++;
+		} else if (test_and_clear_bit(STRIPE_OP_RMW_Drain, &sh->op_state)) {
+			set_bit(STRIPE_OP_RMW_XorPost, &sh->op_state);
+			ops++;
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (dev->written)
+					set_bit(R5_UPTODATE, &dev->flags);
+			}
+		} else if (test_and_clear_bit(STRIPE_OP_RMW_XorPost, &sh->op_state)) {
+			/* synchronous block_ops routines may be done at this point */
+			if (!test_and_clear_bit(STRIPE_OP_RMW_Done, &sh->op_state)) {
+				set_bit(STRIPE_OP_RMW_End, &sh->op_state);
+				ops++;
+			} else
+				rmw_done++;
+		}
+	} else if (test_bit(STRIPE_OP_RCW, &sh->state)) {
+		if (start) {
+			set_bit(STRIPE_OP_RCW_Drain, &sh->op_state);
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+
+				/* enter stage 1 of reconstruct write operation */
+				if (i!=pd_idx && dev->towrite) {
+					set_bit(R5_LOCKED, &dev->flags);
+					ops++;
+				}
+			}
+		} else if (test_and_clear_bit(STRIPE_OP_RCW_Drain, &sh->op_state)) {
+			set_bit(STRIPE_OP_RCW_Xor, &sh->op_state);
+			ops++;
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (dev->written)
+					set_bit(R5_UPTODATE, &dev->flags);
+			}
+		} else if (test_and_clear_bit(STRIPE_OP_RCW_Xor, &sh->op_state)) {
+			/* synchronous block_ops routines may be done at this point */
+			if (!test_and_clear_bit(STRIPE_OP_RCW_Done, &sh->op_state)) {
+				set_bit(STRIPE_OP_RCW_End, &sh->op_state);
+				ops++;
+			} else
+				rcw_done++;
+		}
+	}
+
+	/* keep the parity disk locked while asynchronous operations
+	 * are in flight
+	 */
+	if (ops) {
+		set_bit(STRIPE_OP_LOCKED, &sh->state);
+		set_bit(R5_LOCKED, &sh->dev[pd_idx].flags);
+		clear_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+		sh->op_count++;
+		atomic_inc(&sh->count);
+	} else {
+		set_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+
+		if (rcw_done)
+			clear_bit(STRIPE_OP_RCW, &sh->state);
+		if (rmw_done)
+			clear_bit(STRIPE_OP_RMW, &sh->state);
+	}
+
+	return ops;
+}
+
 static void compute_parity(struct stripe_head *sh, int method)
 {
 	raid5_conf_t *conf = sh->raid_conf;
@@ -1044,6 +1154,143 @@ static int stripe_to_pdidx(sector_t stri
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
+static void raid5_do_soft_block_ops(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+	int i, pd_idx = sh->pd_idx, disks = sh->disks, count = 1;
+	void *ptr[MAX_XOR_BLOCKS];
+	struct bio *chosen;
+	int overlap=0, rcw_done=0, rmw_done=0;
+
+	/* we only read state bits in this loop and rely on STRIPE_OP_LOCKED
+	 * to protect &sh->op_state from modification in handle_stripe
+	 */
+	if (test_bit(STRIPE_OP_RMW, &sh->state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_RMW op_state: %lx\n", 
+			__FUNCTION__, (unsigned long long)sh->sector, 
+			sh->op_state);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		if (test_bit(STRIPE_OP_RMW_XorPre, &sh->op_state)) {
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				/* if it is not locked then servicing
+				 * has not been requested
+				 */
+				if (dev->towrite && test_bit(R5_LOCKED, &dev->flags)) {
+					ptr[count++] = page_address(dev->page);
+					/* ? is the device_lock necessary, compute_parity
+					 * does not lock for this operation ?
+					 */
+					chosen = dev->towrite;
+					dev->towrite = NULL;
+
+					overlap++;
+
+					BUG_ON(dev->written);
+					dev->written = chosen;
+					check_xor();
+				}
+			}
+		} else if (test_bit(STRIPE_OP_RMW_Drain, &sh->op_state)) {
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				drain_bio(dev->written, dev->sector, dev->page);
+			}
+		} else if (test_bit(STRIPE_OP_RMW_XorPost, &sh->op_state)) {
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (dev->written) {
+					ptr[count++] = page_address(dev->page);
+					check_xor();
+				}
+			}
+			/* since this routine is synchronous we are done */
+			rmw_done++;
+		} else if (test_bit(STRIPE_OP_RMW_End, &sh->op_state)) {
+			rmw_done++;
+		} else {
+			BUG();
+		}
+	} else if (test_bit(STRIPE_OP_RCW, &sh->state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_RCW op_state: %lx\n", 
+			__FUNCTION__, (unsigned long long)sh->sector, 
+			sh->op_state);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		if (test_bit(STRIPE_OP_RCW_Drain, &sh->op_state)) {
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (i!=pd_idx && dev->towrite && 
+					test_bit(R5_LOCKED, &dev->flags)) {
+					chosen = dev->towrite;
+					dev->towrite = NULL;
+
+					BUG_ON(dev->written);
+					dev->written = chosen;
+
+					overlap++;
+
+					drain_bio(dev->written, dev->sector,
+						dev->page);
+				} else if (i==pd_idx)
+					memset(ptr[0], 0, STRIPE_SIZE);
+			}
+		} else if (test_bit(STRIPE_OP_RCW_Xor, &sh->op_state)) {
+			for (i=disks; i--;)
+				if (i != pd_idx) {
+					ptr[count++] = page_address(sh->dev[i].page);
+					check_xor();
+				}
+			/* since this routine is synchronous we are done */
+			rcw_done++;
+		} else if (test_bit(STRIPE_OP_RCW_End, &sh->op_state)) {
+			rcw_done++;
+		} else {
+			BUG();
+		}
+	}
+
+	if (count != 1)
+		xor_block(count, STRIPE_SIZE, ptr);
+
+	spin_lock(&sh->lock);
+	if (overlap)
+		for (i= disks; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_and_clear_bit(R5_Overlap, &dev->flags))
+				wake_up(&sh->raid_conf->wait_for_overlap);
+		}
+
+	if (! --sh->op_count) {
+		clear_bit(STRIPE_OP_LOCKED, &sh->state);
+		set_bit(STRIPE_HANDLE, &sh->state);
+	}
+
+	if (rcw_done)
+		set_bit(STRIPE_OP_RCW_Done, &sh->op_state);
+	if (rmw_done)
+		set_bit(STRIPE_OP_RMW_Done, &sh->op_state);
+ 
+	spin_unlock(&sh->lock);
+
+	release_stripe(sh);
+}
+
 /*
  * handle_stripe - do things to a stripe.
  *
@@ -1056,12 +1303,10 @@ static int stripe_to_pdidx(sector_t stri
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
@@ -1073,6 +1318,7 @@ static void handle_stripe(struct stripe_
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
 	int non_overwrite = 0;
 	int failed_num=0;
+	int block_ops=0;
 	struct r5dev *dev;
 
 	PRINTK("handling stripe %llu, cnt=%d, pd_idx=%d\n",
@@ -1122,7 +1368,6 @@ static void handle_stripe(struct stripe_
 		/* now count some things */
 		if (test_bit(R5_LOCKED, &dev->flags)) locked++;
 		if (test_bit(R5_UPTODATE, &dev->flags)) uptodate++;
-
 		
 		if (dev->toread) to_read++;
 		if (dev->towrite) {
@@ -1152,6 +1397,18 @@ static void handle_stripe(struct stripe_
 	 * need to be failed
 	 */
 	if (failed > 1 && to_read+to_write+written) {
+		if (test_and_clear_bit(STRIPE_OP_RMW, &sh->state)) {
+			clear_bit(STRIPE_OP_RMW_XorPre, &sh->op_state);
+			clear_bit(STRIPE_OP_RMW_Drain, &sh->op_state);
+			clear_bit(STRIPE_OP_RMW_XorPost, &sh->op_state);
+			clear_bit(STRIPE_OP_RMW_Done, &sh->op_state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_RCW, &sh->state)) {
+			clear_bit(STRIPE_OP_RCW_Drain, &sh->op_state);
+			clear_bit(STRIPE_OP_RCW_Xor, &sh->op_state);
+			clear_bit(STRIPE_OP_RCW_Done, &sh->op_state);
+		}
+
 		for (i=disks; i--; ) {
 			int bitmap_end = 0;
 
@@ -1319,7 +1576,9 @@ #endif
 	}
 
 	/* now to consider writing and what else, if anything should be read */
-	if (to_write) {
+	if ((to_write || test_bit(STRIPE_OP_RCW, &sh->state) || 
+		test_bit(STRIPE_OP_RMW, &sh->state)) && 
+		!test_bit(STRIPE_OP_LOCKED, &sh->state)) {
 		int rmw=0, rcw=0;
 		for (i=disks ; i--;) {
 			/* would I have to read this buffer for read_modify_write */
@@ -1391,24 +1650,32 @@ #endif
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
@@ -1555,6 +1822,12 @@ #endif
 		bi->bi_size = 0;
 		bi->bi_end_io(bi, bytes, 0);
 	}
+
+	if (block_ops) {
+		INIT_WORK(&sh->work, conf->do_block_ops, sh);
+		queue_work(conf->block_ops_queue, &sh->work);
+	}
+
 	for (i=disks; i-- ;) {
 		int rw;
 		struct bio *bi;
@@ -1613,6 +1886,8 @@ #endif
 			set_bit(STRIPE_HANDLE, &sh->state);
 		}
 	}
+
+	return;
 }
 
 static void raid5_activate_delayed(raid5_conf_t *conf)
@@ -2251,6 +2526,20 @@ static int run(mddev_t *mddev)
 	if ((conf->stripe_hashtbl = kzalloc(PAGE_SIZE, GFP_KERNEL)) == NULL)
 		goto abort;
 
+	sprintf(conf->workqueue_name, "%s_raid5_ops",
+		mddev->gendisk->disk_name);
+
+	if ((conf->block_ops_queue = create_workqueue(conf->workqueue_name))
+				     == NULL)
+		goto abort;
+
+	/* To Do:
+	 * 1/ Offload to asynchronous copy / xor engines
+	 * 2/ Automated selection of optimal do_block_ops
+	 *	routine similar to the xor template selection
+	 */
+	conf->do_block_ops = raid5_do_soft_block_ops;
+
 	spin_lock_init(&conf->device_lock);
 	init_waitqueue_head(&conf->wait_for_stripe);
 	init_waitqueue_head(&conf->wait_for_overlap);
@@ -2401,6 +2690,8 @@ abort:
 		print_raid5_conf(conf);
 		kfree(conf->disks);
 		kfree(conf->stripe_hashtbl);
+		if (conf->block_ops_queue)
+			destroy_workqueue(conf->block_ops_queue);
 		kfree(conf);
 	}
 	mddev->private = NULL;
@@ -2421,6 +2712,7 @@ static int stop(mddev_t *mddev)
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	sysfs_remove_group(&mddev->kobj, &raid5_attrs_group);
 	kfree(conf->disks);
+	destroy_workqueue(conf->block_ops_queue);
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;
diff --git a/include/linux/raid/raid5.h b/include/linux/raid/raid5.h
index 914af66..aa9e988 100644
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
@@ -133,9 +145,12 @@ struct stripe_head {
 	int			pd_idx;			/* parity disk index */
 	unsigned long		state;			/* state flags */
 	atomic_t		count;			/* nr of active thread/requests */
+	int			op_count;		/* nr of queued block operations */
+	unsigned long		op_state;		/* state of block operations */
 	spinlock_t		lock;
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	int			disks;			/* disks in stripe */
+	struct work_struct	work;			/* work queue descriptor */
 	struct r5dev {
 		struct bio	req;
 		struct bio_vec	vec;
@@ -145,6 +160,7 @@ struct stripe_head {
 		unsigned long	flags;
 	} dev[1]; /* allocated with extra space depending of RAID geometry */
 };
+
 /* Flags */
 #define	R5_UPTODATE	0	/* page contains current data */
 #define	R5_LOCKED	1	/* IO has been submitted on "req" */
@@ -156,8 +172,9 @@ #define	R5_Wantwrite	5
 #define	R5_Overlap	7	/* There is a pending overlapping request on this block */
 #define	R5_ReadError	8	/* seen a read error here recently */
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
-
 #define	R5_Expanded	10	/* This block now has post-expand data */
+#define	R5_Consistent	11	/* Block is HW DMA-able */
+
 /*
  * Write method
  */
@@ -179,6 +196,36 @@ #define	STRIPE_BIT_DELAY	8
 #define	STRIPE_EXPANDING	9
 #define	STRIPE_EXPAND_SOURCE	10
 #define	STRIPE_EXPAND_READY	11
+#define	STRIPE_OP_RCW		12
+#define	STRIPE_OP_RMW		13
+#define	STRIPE_OP_CHECK		14
+#define	STRIPE_OP_COMPUTE	15
+#define	STRIPE_OP_BIOFILL	16
+#define	STRIPE_OP_LOCKED	17
+
+/*
+ * Stripe operations state
+ * - these flags enumerate the stages
+ *   of the operations state machine
+ */
+#define	STRIPE_OP_RCW_Drain	0
+#define	STRIPE_OP_RCW_Xor	1
+#define	STRIPE_OP_RCW_End	2
+#define	STRIPE_OP_RCW_Done	3
+#define	STRIPE_OP_RMW_XorPre	4
+#define	STRIPE_OP_RMW_Drain	5
+#define	STRIPE_OP_RMW_XorPost	6
+#define	STRIPE_OP_RMW_End	7
+#define	STRIPE_OP_RMW_Done	8
+#define	STRIPE_OP_CHECK_Gen   	9
+#define	STRIPE_OP_CHECK_Verify	10
+#define	STRIPE_OP_CHECK_End	11
+#define	STRIPE_OP_CHECK_Done	12
+#define	STRIPE_OP_COMPUTE_Prep	13
+#define	STRIPE_OP_COMPUTE_Xor	14
+#define	STRIPE_OP_COMPUTE_End	15
+#define	STRIPE_OP_COMPUTE_Done	16
+
 /*
  * Plugging:
  *
@@ -228,11 +275,16 @@ struct raid5_private_data {
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
-- 
1.3.0

