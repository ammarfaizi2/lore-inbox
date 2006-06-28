Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWF1S3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWF1S3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWF1S3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:29:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:52484 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750846AbWF1S3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:29:48 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="90665286:sNHT21153741"
Subject: [PATCH 001 of 006] raid5: Move write operations to a work queue
From: Dan Williams <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:23:56 -0700
Message-Id: <1151519036.2232.63.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves write (reconstruct and read-modify) operations to a
work queue.  Note the next patch in this series fixes some incorrect
assumptions around having multiple operations in flight (i.e. ignore
this version of 'queue_raid_work').

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 drivers/md/raid5.c         |  314 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/raid/raid5.h |   67 +++++++++
 2 files changed, 357 insertions(+), 24 deletions(-)

===================================================================
Index: linux-2.6-raid/drivers/md/raid5.c
===================================================================
--- linux-2.6-raid.orig/drivers/md/raid5.c	2006-06-28 08:44:11.000000000 -0700
+++ linux-2.6-raid/drivers/md/raid5.c	2006-06-28 09:52:07.000000000 -0700
@@ -305,6 +305,7 @@
 	memset(sh, 0, sizeof(*sh) + (conf->raid_disks-1)*sizeof(struct r5dev));
 	sh->raid_conf = conf;
 	spin_lock_init(&sh->lock);
+	INIT_WORK(&sh->ops.work, conf->do_block_ops, sh);
 
 	if (grow_buffers(sh, conf->raid_disks)) {
 		shrink_buffers(sh, conf->raid_disks);
@@ -1224,6 +1225,80 @@
 	}
 }
 
+static int handle_write_operations5(struct stripe_head *sh, int rcw, int locked)
+{
+	int i, pd_idx = sh->pd_idx, disks = sh->disks;
+	int complete=0;
+
+	if (test_bit(STRIPE_OP_RCW, &sh->state) &&
+			test_bit(STRIPE_OP_RCW_Done, &sh->ops.state)) {
+				clear_bit(STRIPE_OP_RCW, &sh->state);
+				clear_bit(STRIPE_OP_RCW_Done, &sh->ops.state);
+				complete++;
+	}
+
+	if (test_bit(STRIPE_OP_RMW, &sh->state) &&
+			test_bit(STRIPE_OP_RMW_Done, &sh->ops.state)) {
+				clear_bit(STRIPE_OP_RMW, &sh->state);
+				clear_bit(STRIPE_OP_RMW_Done, &sh->ops.state);
+				BUG_ON(++complete == 2);
+	}
+
+
+	/* If no operation is currently in process then use the rcw flag to
+	 * select an operation
+	 */
+	if (locked == 0) {
+		if (rcw == 0) {
+			/* enter stage 1 of reconstruct write operation */
+			set_bit(STRIPE_OP_RCW, &sh->state);
+			set_bit(STRIPE_OP_RCW_Drain, &sh->ops.state);
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+
+				if (i!=pd_idx && dev->towrite) {
+					set_bit(R5_LOCKED, &dev->flags);
+					locked++;
+				}
+			}
+		} else {
+			/* enter stage 1 of read modify write operation */
+			BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags));
+			set_bit(STRIPE_OP_RMW, &sh->state);
+			set_bit(STRIPE_OP_RMW_ParityPre, &sh->ops.state);
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (i==pd_idx)
+					continue;
+
+				if (dev->towrite &&
+				    test_bit(R5_UPTODATE, &dev->flags)) {
+					set_bit(R5_LOCKED, &dev->flags);
+					locked++;
+				}
+			}
+		}
+	} else if (locked && complete == 0) /* the queue has an operation in flight */
+		locked = -EBUSY;
+	else if (complete)
+		locked = 0;
+
+	/* keep the parity disk locked while asynchronous operations
+	 * are in flight
+	 */
+	if (locked > 0) {
+		set_bit(R5_LOCKED, &sh->dev[pd_idx].flags);
+		clear_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+		sh->ops.queue_count++;
+	} else if (locked == 0)
+		set_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+
+	PRINTK("%s: stripe %llu locked: %d complete: %d op_state: %lx\n",
+		__FUNCTION__, (unsigned long long)sh->sector,
+		locked, complete, sh->ops.state);
+
+	return locked;
+}
 
 
 /*
@@ -1320,6 +1395,174 @@
 	return pd_idx;
 }
 
+static inline void drain_bio(struct bio *wbi, sector_t sector, struct page *page)
+{
+	while (wbi && wbi->bi_sector < sector + STRIPE_SECTORS) {
+		copy_data(1, wbi, page, sector);
+		wbi = r5_next_bio(wbi, sector);
+	}
+}
+
+/* must be called under the stripe lock */
+static void queue_raid_work(struct stripe_head *sh)
+{
+	if (--sh->ops.queue_count == 0) {
+		atomic_inc(&sh->count);
+		queue_work(sh->raid_conf->block_ops_queue, &sh->ops.work);
+	} else if (sh->ops.queue_count < 0)
+		sh->ops.queue_count = 0;
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
+	int overlap=0, new_work=0, written=0;
+	unsigned long state, ops_state;
+
+	/* take a snapshot of what needs to be done at this point in time */
+	spin_lock(&sh->lock);
+	state = sh->state;
+	ops_state = sh->ops.state;
+	spin_unlock(&sh->lock);
+
+	if (test_bit(STRIPE_OP_RMW, &state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_RMW op_state: %lx\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		if (test_and_clear_bit(STRIPE_OP_RMW_ParityPre, &ops_state)) {
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				/* if it is locked then servicing
+				 * has been requested
+				 */
+				if (dev->towrite && test_bit(R5_LOCKED, &dev->flags)) {
+					ptr[count++] = page_address(dev->page);
+					/* ? is the device_lock necessary here, compute_parity
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
+			if (count != 1)
+				xor_block(count, STRIPE_SIZE, ptr);
+			set_bit(STRIPE_OP_RMW_Drain, &ops_state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_RMW_Drain, &ops_state)) {
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				written++;
+				drain_bio(dev->written, dev->sector, dev->page);
+			}
+			set_bit(STRIPE_OP_RMW_ParityPost, &ops_state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_RMW_ParityPost, &ops_state)) {
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				if (dev->written) {
+					ptr[count++] = page_address(dev->page);
+					check_xor();
+				}
+			}
+			if (count != 1)
+				xor_block(count, STRIPE_SIZE, ptr);
+
+			/* signal completion and acknowledge the last state seen
+			 * by sh->ops.state
+			 */
+			set_bit(STRIPE_OP_RMW_Done, &ops_state);
+			set_bit(STRIPE_OP_RMW_ParityPre, &ops_state);
+		}
+
+	} else if (test_bit(STRIPE_OP_RCW, &state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_RCW op_state: %lx\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		if (test_and_clear_bit(STRIPE_OP_RCW_Drain, &ops_state)) {
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
+					written++;
+
+					drain_bio(dev->written, dev->sector,
+						dev->page);
+				} else if (i==pd_idx)
+					memset(ptr[0], 0, STRIPE_SIZE);
+			}
+			set_bit(STRIPE_OP_RCW_Parity, &ops_state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_RCW_Parity, &ops_state)) {
+			for (i=disks; i--;)
+				if (i != pd_idx) {
+					ptr[count++] = page_address(sh->dev[i].page);
+					check_xor();
+				}
+			if (count != 1)
+				xor_block(count, STRIPE_SIZE, ptr);
+
+			/* signal completion and acknowledge the last state seen
+			 * by sh->ops.state
+			 */
+			set_bit(STRIPE_OP_RCW_Done, &ops_state);
+			set_bit(STRIPE_OP_RCW_Drain, &ops_state);
+
+		}
+	}
+
+	spin_lock(&sh->lock);
+	/* Update the state of operations, by XORing we clear the stage 1 requests
+	 * while preserving new requests.
+	 */
+	sh->ops.state ^= ops_state;
+
+	if (written)
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (dev->written)
+				set_bit(R5_UPTODATE, &dev->flags);
+		}
+
+	if (overlap)
+		for (i= disks; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_and_clear_bit(R5_Overlap, &dev->flags))
+				wake_up(&sh->raid_conf->wait_for_overlap);
+		}
+
+	sh->ops.queue_count += new_work;
+	set_bit(STRIPE_HANDLE, &sh->state);
+	queue_raid_work(sh);
+	spin_unlock(&sh->lock);
+
+	release_stripe(sh);
+}
 
 /*
  * handle_stripe - do things to a stripe.
@@ -1333,7 +1576,6 @@
  *    schedule a write of some buffers
  *    return confirmation of parity correctness
  *
- * Parity calculations are done inside the stripe lock
  * buffers are taken off read_list or write_list, and bh_cache buffers
  * get BH_Lock set before the stripe lock is released.
  *
@@ -1352,9 +1594,9 @@
 	int failed_num=0;
 	struct r5dev *dev;
 
-	PRINTK("handling stripe %llu, cnt=%d, pd_idx=%d\n",
-		(unsigned long long)sh->sector, atomic_read(&sh->count),
-		sh->pd_idx);
+	PRINTK("handling stripe %llu, state=%#lx cnt=%d, pd_idx=%d\n",
+	       (unsigned long long)sh->sector, sh->state, atomic_read(&sh->count),
+	       sh->pd_idx);
 
 	spin_lock(&sh->lock);
 	clear_bit(STRIPE_HANDLE, &sh->state);
@@ -1596,7 +1838,8 @@
 	}
 
 	/* now to consider writing and what else, if anything should be read */
-	if (to_write) {
+	if (to_write || test_bit(STRIPE_OP_RCW, &sh->state) ||
+		test_bit(STRIPE_OP_RMW, &sh->state)) {
 		int rmw=0, rcw=0;
 		for (i=disks ; i--;) {
 			/* would I have to read this buffer for read_modify_write */
@@ -1668,25 +1911,29 @@
 				}
 			}
 		/* now if nothing is locked, and if we have enough data, we can start a write request */
-		if (locked == 0 && (rcw == 0 ||rmw == 0) &&
-		    !test_bit(STRIPE_BIT_DELAY, &sh->state)) {
-			PRINTK("Computing parity...\n");
-			compute_parity5(sh, rcw==0 ? RECONSTRUCT_WRITE : READ_MODIFY_WRITE);
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
+			int work_queued = handle_write_operations5(sh, rcw, locked);
+			if (work_queued == 0) {
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
-			}
+			} else if (work_queued > 0)
+				locked += work_queued;
 		}
 	}
 
@@ -1819,6 +2066,8 @@
 			}
 	}
 
+	queue_raid_work(sh);
+
 	spin_unlock(&sh->lock);
 
 	while ((bi=return_bi)) {
@@ -1829,6 +2078,7 @@
 		bi->bi_size = 0;
 		bi->bi_end_io(bi, bytes, 0);
 	}
+
 	for (i=disks; i-- ;) {
 		int rw;
 		struct bio *bi;
@@ -3117,6 +3367,21 @@
 		if (!conf->spare_page)
 			goto abort;
 	}
+
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
@@ -3279,6 +3544,8 @@
 		safe_put_page(conf->spare_page);
 		kfree(conf->disks);
 		kfree(conf->stripe_hashtbl);
+		if (conf->do_block_ops)
+			destroy_workqueue(conf->block_ops_queue);
 		kfree(conf);
 	}
 	mddev->private = NULL;
@@ -3299,6 +3566,7 @@
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	sysfs_remove_group(&mddev->kobj, &raid5_attrs_group);
 	kfree(conf->disks);
+	destroy_workqueue(conf->block_ops_queue);
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;
Index: linux-2.6-raid/include/linux/raid/raid5.h
===================================================================
--- linux-2.6-raid.orig/include/linux/raid/raid5.h	2006-06-28 08:44:11.000000000 -0700
+++ linux-2.6-raid/include/linux/raid/raid5.h	2006-06-28 10:34:54.000000000 -0700
@@ -3,6 +3,8 @@
 
 #include <linux/raid/md.h>
 #include <linux/raid/xor.h>
+#include <linux/workqueue.h>
+#include <linux/dmaengine.h>
 
 /*
  *
@@ -123,6 +125,14 @@
  * The refcount counts each thread that have activated the stripe,
  * plus raid5d if it is handling it, plus one for each active request
  * on a cached buffer.
+ *
+ * Block operations (copy, xor, block fill, and block compare) are executed
+ * outside the spin lock.  A stripe can have multiple operations in flight provided
+ * that the operations do not have data dependencies.  For most cases data
+ * dependencies will be avoided by the 'overlap' protection logic in add_stripe_bio.
+ * A case that violates this rule is compute block operations where the work queue must
+ * guarantee that blocks are up to date before proceeding with a write or check
+ * parity operation.
  */
 
 struct stripe_head {
@@ -136,6 +146,16 @@
 	spinlock_t		lock;
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	int			disks;			/* disks in stripe */
+	struct stripe_operations {
+		int			queue_count;	/* if == 0 places stripe in the workqueue */
+		unsigned long		state;		/* state of block operations */
+		struct work_struct	work;		/* work queue descriptor */
+		#ifdef CONFIG_DMA_ENGINE
+		u32 			dma_result;	/* storage for dma engine results */
+		dma_cookie_t		dma_cookie;	/* last issued dma operation */
+		struct dma_chan		*dma_chan;	/* dma channel for ops offload */
+		#endif
+	} ops;
 	struct r5dev {
 		struct bio	req;
 		struct bio_vec	vec;
@@ -145,6 +165,7 @@
 		unsigned long	flags;
 	} dev[1]; /* allocated with extra space depending of RAID geometry */
 };
+
 /* Flags */
 #define	R5_UPTODATE	0	/* page contains current data */
 #define	R5_LOCKED	1	/* IO has been submitted on "req" */
@@ -156,8 +177,9 @@
 #define	R5_Overlap	7	/* There is a pending overlapping request on this block */
 #define	R5_ReadError	8	/* seen a read error here recently */
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
-
 #define	R5_Expanded	10	/* This block now has post-expand data */
+#define	R5_Consistent	11	/* Block is HW DMA-able without a cache flush */
+
 /*
  * Write method
  */
@@ -179,6 +201,41 @@
 #define	STRIPE_EXPANDING	9
 #define	STRIPE_EXPAND_SOURCE	10
 #define	STRIPE_EXPAND_READY	11
+#define	STRIPE_OP_RCW		12
+#define	STRIPE_OP_RMW		13 /* RAID-5 only */
+#define	STRIPE_OP_UPDATE	14 /* RAID-6 only */
+#define	STRIPE_OP_CHECK		15
+#define	STRIPE_OP_COMPUTE	16
+#define	STRIPE_OP_COMPUTE2	17 /* RAID-6 only */
+#define	STRIPE_OP_BIOFILL	18
+
+/*
+ * These flags are communication markers between the handle_stripe[5|6]
+ * routine and the block operations work queue
+ * - The _End definitions are a signal from handle_stripe to the work queue to
+ *   to ensure the completion of the operation so the results can be committed
+ *   to disk
+ * - The _Done definitions signal completion from work queue to handle_stripe
+ * - All other definitions are service requests for the work queue
+ */
+#define	STRIPE_OP_RCW_Drain		0
+#define	STRIPE_OP_RCW_Parity		1
+#define	STRIPE_OP_RCW_End		2
+#define	STRIPE_OP_RCW_Done		3
+#define	STRIPE_OP_RMW_ParityPre		4
+#define	STRIPE_OP_RMW_Drain		5
+#define	STRIPE_OP_RMW_ParityPost	6
+#define	STRIPE_OP_RMW_End		7
+#define	STRIPE_OP_RMW_Done		8
+#define	STRIPE_OP_CHECK_Gen   		9
+#define	STRIPE_OP_CHECK_Verify		10
+#define	STRIPE_OP_CHECK_End		11
+#define	STRIPE_OP_CHECK_Done		12
+#define	STRIPE_OP_COMPUTE_Prep		13
+#define	STRIPE_OP_COMPUTE_Parity	14
+#define	STRIPE_OP_COMPUTE_End		15
+#define	STRIPE_OP_COMPUTE_Done		16
+
 /*
  * Plugging:
  *
@@ -229,11 +286,16 @@
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
