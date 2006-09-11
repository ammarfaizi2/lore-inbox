Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWIKXRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWIKXRn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWIKXRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:17:43 -0400
Received: from mga03.intel.com ([143.182.124.21]:26264 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S932154AbWIKXRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:17:42 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="114946805:sNHT151627511"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 01/19] raid5: raid5_do_soft_block_ops
Date: Mon, 11 Sep 2006 16:17:40 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231740.4737.48922.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

raid5_do_soft_block_ops consolidates all the stripe cache maintenance
operations into a single routine.  The stripe operations are:
* copying data between the stripe cache and user application buffers
* computing blocks to save a disk access, or to recover a missing block
* updating the parity on a write operation (reconstruct write and
read-modify-write)
* checking parity correctness

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c         |  289 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/raid/raid5.h |  129 +++++++++++++++++++-
 2 files changed, 415 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4500660..8fde62b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1362,6 +1362,295 @@ static int stripe_to_pdidx(sector_t stri
 	return pd_idx;
 }
 
+/*
+ * raid5_do_soft_block_ops - perform block memory operations on stripe data
+ * outside the spin lock.
+ */
+static void raid5_do_soft_block_ops(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+	int i, pd_idx = sh->pd_idx, disks = sh->disks;
+	void *ptr[MAX_XOR_BLOCKS];
+	int overlap=0, work=0, written=0, compute=0, dd_idx=0;
+	int pd_uptodate=0;
+	unsigned long state, ops_state, ops_state_orig;
+	raid5_conf_t *conf = sh->raid_conf;
+
+	/* take a snapshot of what needs to be done at this point in time */
+	spin_lock(&sh->lock);
+	state = sh->state;
+	ops_state_orig = ops_state = sh->ops.state;
+	spin_unlock(&sh->lock);
+
+	if (test_bit(STRIPE_OP_BIOFILL, &state)) {
+		struct bio *return_bi=NULL;
+
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_bit(R5_ReadReq, &dev->flags)) {
+				struct bio *rbi, *rbi2;
+				PRINTK("%s: stripe %llu STRIPE_OP_BIOFILL op_state: %lx disk: %d\n",
+					__FUNCTION__, (unsigned long long)sh->sector,
+					ops_state, i);
+				spin_lock_irq(&conf->device_lock);
+				rbi = dev->toread;
+				dev->toread = NULL;
+				spin_unlock_irq(&conf->device_lock);
+				overlap++;
+				while (rbi && rbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+					copy_data(0, rbi, dev->page, dev->sector);
+					rbi2 = r5_next_bio(rbi, dev->sector);
+					spin_lock_irq(&conf->device_lock);
+					if (--rbi->bi_phys_segments == 0) {
+						rbi->bi_next = return_bi;
+						return_bi = rbi;
+					}
+					spin_unlock_irq(&conf->device_lock);
+					rbi = rbi2;
+				}
+				dev->read = return_bi;
+			}
+		}
+		if (overlap) {
+			set_bit(STRIPE_OP_BIOFILL_Done, &ops_state);
+			work++;
+		}
+	}
+
+	if (test_bit(STRIPE_OP_COMPUTE, &state)) {
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_bit(R5_ComputeReq, &dev->flags)) {
+				dd_idx = i;
+				i = -1;
+				break;
+			}
+		}
+		BUG_ON(i >= 0);
+		PRINTK("%s: stripe %llu STRIPE_OP_COMPUTE op_state: %lx block: %d\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state, dd_idx);
+		ptr[0] = page_address(sh->dev[dd_idx].page);
+
+		if (test_and_clear_bit(STRIPE_OP_COMPUTE_Prep, &ops_state)) {
+			memset(ptr[0], 0, STRIPE_SIZE);
+			set_bit(STRIPE_OP_COMPUTE_Parity, &ops_state);
+		}
+
+		if (test_and_clear_bit(STRIPE_OP_COMPUTE_Parity, &ops_state)) {
+			int count = 1;
+			for (i = disks ; i--; ) {
+				struct r5dev *dev = &sh->dev[i];
+				void *p;
+				if (i == dd_idx)
+					continue;
+				p = page_address(dev->page);
+				ptr[count++] = p;
+
+				check_xor();
+			}
+			if (count != 1)
+				xor_block(count, STRIPE_SIZE, ptr);
+
+			work++;
+			compute++;
+			set_bit(STRIPE_OP_COMPUTE_Done, &ops_state);
+		}
+	}
+
+	if (test_bit(STRIPE_OP_RMW, &state)) {
+		BUG_ON(test_bit(STRIPE_OP_RCW, &state));
+
+		PRINTK("%s: stripe %llu STRIPE_OP_RMW op_state: %lx\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		if (test_and_clear_bit(STRIPE_OP_RMW_ParityPre, &ops_state)) {
+			int count = 1;
+
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				struct bio *chosen;
+
+				/* Only process blocks that are known to be uptodate */
+				if (dev->towrite && test_bit(R5_RMWReq, &dev->flags)) {
+					ptr[count++] = page_address(dev->page);
+
+					spin_lock(&sh->lock);
+					chosen = dev->towrite;
+					dev->towrite = NULL;
+					BUG_ON(dev->written);
+					dev->written = chosen;
+					spin_unlock(&sh->lock);
+
+					overlap++;
+
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
+				struct bio *wbi = dev->written;
+
+				if (dev->written)
+					written++;
+
+				while (wbi && wbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+					copy_data(1, wbi, dev->page, dev->sector);
+					wbi = r5_next_bio(wbi, dev->sector);
+				}
+			}
+			set_bit(STRIPE_OP_RMW_ParityPost, &ops_state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_RMW_ParityPost, &ops_state)) {
+			int count = 1;
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
+			work++;
+			pd_uptodate++;
+			set_bit(STRIPE_OP_RMW_Done, &ops_state);
+		}
+
+	}
+
+	if (test_bit(STRIPE_OP_RCW, &state)) {
+		BUG_ON(test_bit(STRIPE_OP_RMW, &state));
+
+		PRINTK("%s: stripe %llu STRIPE_OP_RCW op_state: %lx\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		if (test_and_clear_bit(STRIPE_OP_RCW_Drain, &ops_state)) {
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				struct bio *chosen;
+				struct bio *wbi;
+
+				if (i!=pd_idx && dev->towrite &&
+					test_bit(R5_LOCKED, &dev->flags)) {
+
+					spin_lock(&sh->lock);
+					chosen = dev->towrite;
+					dev->towrite = NULL;
+					spin_unlock(&sh->lock);
+
+					BUG_ON(dev->written);
+					wbi = dev->written = chosen;
+
+					overlap++;
+					written++;
+
+					while (wbi && wbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+						copy_data(1, wbi, dev->page, dev->sector);
+						wbi = r5_next_bio(wbi, dev->sector);
+					}
+				} else if (i==pd_idx)
+					memset(ptr[0], 0, STRIPE_SIZE);
+			}
+			set_bit(STRIPE_OP_RCW_Parity, &ops_state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_RCW_Parity, &ops_state)) {
+			int count = 1;
+			for (i=disks; i--;)
+				if (i != pd_idx) {
+					ptr[count++] = page_address(sh->dev[i].page);
+					check_xor();
+				}
+			if (count != 1)
+				xor_block(count, STRIPE_SIZE, ptr);
+
+			work++;
+			pd_uptodate++;
+			set_bit(STRIPE_OP_RCW_Done, &ops_state);
+
+		}
+	}
+
+	if (test_bit(STRIPE_OP_CHECK, &state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_CHECK op_state: %lx\n",
+		__FUNCTION__, (unsigned long long)sh->sector,
+		ops_state);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		if (test_and_clear_bit(STRIPE_OP_CHECK_Gen, &ops_state)) {
+			int count = 1;
+			for (i=disks; i--;)
+				if (i != pd_idx) {
+					ptr[count++] = page_address(sh->dev[i].page);
+					check_xor();
+				}
+			if (count != 1)
+				xor_block(count, STRIPE_SIZE, ptr);
+
+			set_bit(STRIPE_OP_CHECK_Verify, &ops_state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_CHECK_Verify, &ops_state)) {
+			if (page_is_zero(sh->dev[pd_idx].page))
+				set_bit(STRIPE_OP_CHECK_IsZero, &ops_state);
+
+			work++;
+			set_bit(STRIPE_OP_CHECK_Done, &ops_state);
+		}
+	}
+
+	spin_lock(&sh->lock);
+	/* Update the state of operations:
+	 * -clear incoming requests
+	 * -preserve output status (i.e. done status / check result)
+	 * -preserve requests added since 'ops_state_orig' was set
+	 */
+	sh->ops.state ^= (ops_state_orig & ~STRIPE_OP_COMPLETION_MASK);
+	sh->ops.state |= ops_state;
+
+	if (pd_uptodate)
+		set_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags);
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
+	if (compute) {
+		clear_bit(R5_ComputeReq, &sh->dev[dd_idx].flags);
+		set_bit(R5_UPTODATE, &sh->dev[dd_idx].flags);
+	}
+
+	sh->ops.pending -= work;
+	BUG_ON(sh->ops.pending < 0);
+	clear_bit(STRIPE_OP_QUEUED, &sh->state);
+	set_bit(STRIPE_HANDLE, &sh->state);
+	queue_raid_work(sh);
+	spin_unlock(&sh->lock);
+
+	release_stripe(sh);
+}
 
 /*
  * handle_stripe - do things to a stripe.
diff --git a/include/linux/raid/raid5.h b/include/linux/raid/raid5.h
index 20ed4c9..c8a315b 100644
--- a/include/linux/raid/raid5.h
+++ b/include/linux/raid/raid5.h
@@ -116,13 +116,39 @@ #include <linux/raid/xor.h>
  *  attach a request to an active stripe (add_stripe_bh())
  *     lockdev attach-buffer unlockdev
  *  handle a stripe (handle_stripe())
- *     lockstripe clrSTRIPE_HANDLE ... (lockdev check-buffers unlockdev) .. change-state .. record io needed unlockstripe schedule io
+ *     lockstripe clrSTRIPE_HANDLE ... (lockdev check-buffers unlockdev) .. change-state .. record io/ops needed unlockstripe schedule io/ops
  *  release an active stripe (release_stripe())
  *     lockdev if (!--cnt) { if  STRIPE_HANDLE, add to handle_list else add to inactive-list } unlockdev
  *
  * The refcount counts each thread that have activated the stripe,
  * plus raid5d if it is handling it, plus one for each active request
- * on a cached buffer.
+ * on a cached buffer, and plus one if the stripe is undergoing stripe
+ * operations.
+ *
+ * Stripe operations are performed outside the stripe lock,
+ * the stripe operations are:
+ * -copying data between the stripe cache and user application buffers
+ * -computing blocks to save a disk access, or to recover a missing block
+ * -updating the parity on a write operation (reconstruct write and read-modify-write)
+ * -checking parity correctness
+ * These operations are carried out by either a software routine,
+ * raid5_do_soft_block_ops, or by a routine that arranges for the work to be
+ * done by dedicated DMA engines.
+ * When requesting an operation handle_stripe sets the proper state and work
+ * request flags, it then hands control to the operations routine.  There are
+ * some critical dependencies between the operations that prevent some
+ * operations from being requested while another is in flight.
+ * Here are the inter-dependencies:
+ * -parity check operations destroy the in cache version of the parity block,
+ *  so we prevent parity dependent operations like writes and compute_blocks
+ *  from starting while a check is in progress.
+ * -when a write operation is requested we immediately lock the affected blocks,
+ *  and mark them as not up to date.  This causes new read requests to be held
+ *  off, as well as parity checks and compute block operations.
+ * -once a compute block operation has been requested handle_stripe treats that
+ *  block as if it is immediately up to date.  The routine carrying out the
+ *  operation guaruntees that any operation that is dependent on the
+ *  compute block result is initiated after the computation completes.
  */
 
 struct stripe_head {
@@ -136,11 +162,18 @@ struct stripe_head {
 	spinlock_t		lock;
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	int			disks;			/* disks in stripe */
+	struct stripe_operations {
+		int			pending;	/* number of operations requested */
+		unsigned long		state;		/* state of block operations */
+		#ifdef CONFIG_MD_RAID456_WORKQUEUE
+		struct work_struct	work;		/* work queue descriptor */
+		#endif
+	} ops;
 	struct r5dev {
 		struct bio	req;
 		struct bio_vec	vec;
 		struct page	*page;
-		struct bio	*toread, *towrite, *written;
+		struct bio	*toread, *read, *towrite, *written;
 		sector_t	sector;			/* sector of this page */
 		unsigned long	flags;
 	} dev[1]; /* allocated with extra space depending of RAID geometry */
@@ -158,6 +191,11 @@ #define	R5_ReadError	8	/* seen a read er
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
 
 #define	R5_Expanded	10	/* This block now has post-expand data */
+#define	R5_Consistent	11	/* Block is HW DMA-able without a cache flush */
+#define	R5_ComputeReq	12	/* compute_block in progress treat as uptodate */
+#define	R5_ReadReq	13	/* dev->toread contains a bio that needs filling */
+#define	R5_RMWReq	14	/* distinguish blocks ready for rmw from other "towrites" */
+
 /*
  * Write method
  */
@@ -179,6 +217,72 @@ #define	STRIPE_BIT_DELAY	8
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
+#define	STRIPE_OP_QUEUED	19
+#define	STRIPE_OP_DMA		20
+
+/*
+ * These flags are communication markers between the handle_stripe[5|6]
+ * routine and the block operations work queue
+ * - The *_Done definitions signal completion from work queue to handle_stripe
+ * - STRIPE_OP_CHECK_IsZero: signals parity correctness to handle_stripe
+ * - STRIPE_OP_RCW_Expand: expansion operations perform a modified RCW sequence
+ * - STRIPE_OP_COMPUTE_Recover_pd: recovering the parity disk involves an extra
+ *	write back step
+ * - STRIPE_OP_*_Dma: flag operations that will be done once the DMA engine
+ *	goes idle
+ * - All other definitions are service requests for the work queue
+ */
+#define	STRIPE_OP_RCW_Drain		0
+#define	STRIPE_OP_RCW_Parity		1
+#define	STRIPE_OP_RCW_Done		2
+#define	STRIPE_OP_RCW_Expand		3
+#define	STRIPE_OP_RMW_ParityPre		4
+#define	STRIPE_OP_RMW_Drain		5
+#define	STRIPE_OP_RMW_ParityPost	6
+#define	STRIPE_OP_RMW_Done		7
+#define	STRIPE_OP_CHECK_Gen   		8
+#define	STRIPE_OP_CHECK_Verify		9
+#define	STRIPE_OP_CHECK_Done		10
+#define	STRIPE_OP_CHECK_IsZero		11
+#define	STRIPE_OP_COMPUTE_Prep		12
+#define	STRIPE_OP_COMPUTE_Parity	13
+#define	STRIPE_OP_COMPUTE_Done		14
+#define	STRIPE_OP_COMPUTE_Recover_pd	15
+#define	STRIPE_OP_BIOFILL_Copy		16
+#define	STRIPE_OP_BIOFILL_Done		17
+#define	STRIPE_OP_RCW_Dma		18
+#define	STRIPE_OP_RMW_Dma		19
+#define	STRIPE_OP_UPDATE_Dma		20
+#define	STRIPE_OP_CHECK_Dma		21
+#define	STRIPE_OP_COMPUTE_Dma		22
+#define	STRIPE_OP_COMPUTE2_Dma		23
+#define	STRIPE_OP_BIOFILL_Dma		24
+
+/*
+ * Bit mask for status bits not to be auto-cleared by the work queue thread
+ */
+#define	STRIPE_OP_COMPLETION_MASK 	(1 << STRIPE_OP_RCW_Done |\
+						1 << STRIPE_OP_RMW_Done |\
+						1 << STRIPE_OP_CHECK_Done |\
+						1 << STRIPE_OP_CHECK_IsZero |\
+						1 << STRIPE_OP_COMPUTE_Done |\
+						1 << STRIPE_OP_COMPUTE_Recover_pd |\
+						1 << STRIPE_OP_BIOFILL_Done |\
+						1 << STRIPE_OP_RCW_Dma |\
+						1 << STRIPE_OP_RMW_Dma |\
+						1 << STRIPE_OP_UPDATE_Dma |\
+						1 << STRIPE_OP_CHECK_Dma |\
+						1 << STRIPE_OP_COMPUTE_Dma |\
+						1 << STRIPE_OP_COMPUTE2_Dma |\
+						1 << STRIPE_OP_BIOFILL_Dma)
+
 /*
  * Plugging:
  *
@@ -229,11 +333,19 @@ struct raid5_private_data {
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
 
 	atomic_t		reshape_stripes; /* stripes with pending writes for reshape */
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
+	struct workqueue_struct *block_ops_queue;
+	#endif
+	void (*do_block_ops)(void *);
+
 	/* unfortunately we need two cache names as we temporarily have
 	 * two caches.
 	 */
 	int			active_name;
 	char			cache_name[2][20];
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
+	char			workqueue_name[20];
+	#endif
 	kmem_cache_t		*slab_cache; /* for allocating stripes */
 
 	int			seq_flush, seq_write;
@@ -264,6 +376,17 @@ struct raid5_private_data {
 typedef struct raid5_private_data raid5_conf_t;
 
 #define mddev_to_conf(mddev) ((raid5_conf_t *) mddev->private)
+/* must be called under the stripe lock */
+static inline void queue_raid_work(struct stripe_head *sh)
+{
+	if (sh->ops.pending != 0 && !test_bit(STRIPE_OP_QUEUED, &sh->state)) {
+		set_bit(STRIPE_OP_QUEUED, &sh->state);
+		atomic_inc(&sh->count);
+		#ifdef CONFIG_MD_RAID456_WORKQUEUE
+		queue_work(sh->raid_conf->block_ops_queue, &sh->ops.work);
+		#endif
+	}
+}
 
 /*
  * Our supported algorithms
