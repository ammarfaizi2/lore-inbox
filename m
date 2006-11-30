Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031350AbWK3ULn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031350AbWK3ULn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031348AbWK3ULm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:11:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:9089 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1031341AbWK3ULP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:11:15 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="171251589:sNHT129429244"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 04/12] md: add raid5_run_ops and support routines
Date: Thu, 30 Nov 2006 13:10:20 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201020.21313.85347.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Prepare the raid5 implementation to use async_tx and a workqueue for
running stripe operations:
* biofill (copy data into request buffers to satisfy a read request)
* compute block (generate a missing block in the cache from the other
blocks)
* prexor (subtract existing data as part of the read-modify-write process)
* biodrain (copy data out of request buffers to satisfy a write request)
* postxor (recalculate parity for new data that has entered the cache)
* check (verify that the parity is correct)
* io (submit i/o to the member disks)

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c         |  560 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/raid/raid5.h |   67 +++++
 2 files changed, 619 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0c8ada5..232f525 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -52,6 +52,7 @@ #include <asm/atomic.h>
 #include "raid6.h"
 
 #include <linux/raid/bitmap.h>
+#include <linux/async_tx.h>
 
 /*
  * Stripe cache
@@ -222,7 +223,8 @@ static void init_stripe(struct stripe_he
 
 	BUG_ON(atomic_read(&sh->count) != 0);
 	BUG_ON(test_bit(STRIPE_HANDLE, &sh->state));
-	
+	BUG_ON(sh->ops.pending || sh->ops.ack || sh->ops.complete);
+
 	CHECK_DEVLOCK();
 	PRINTK("init_stripe called, stripe %llu\n", 
 		(unsigned long long)sh->sector);
@@ -238,11 +240,11 @@ static void init_stripe(struct stripe_he
 	for (i = sh->disks; i--; ) {
 		struct r5dev *dev = &sh->dev[i];
 
-		if (dev->toread || dev->towrite || dev->written ||
+		if (dev->toread || dev->read || dev->towrite || dev->written ||
 		    test_bit(R5_LOCKED, &dev->flags)) {
-			printk("sector=%llx i=%d %p %p %p %d\n",
+			printk("sector=%llx i=%d %p %p %p %p %d\n",
 			       (unsigned long long)sh->sector, i, dev->toread,
-			       dev->towrite, dev->written,
+			       dev->read, dev->towrite, dev->written,
 			       test_bit(R5_LOCKED, &dev->flags));
 			BUG();
 		}
@@ -322,6 +324,556 @@ static struct stripe_head *get_active_st
 	return sh;
 }
 
+static int
+raid5_end_read_request(struct bio * bi, unsigned int bytes_done, int error);
+static int
+raid5_end_write_request (struct bio *bi, unsigned int bytes_done, int error);
+
+static void ops_run_io(struct stripe_head *sh)
+{
+	raid5_conf_t *conf = sh->raid_conf;
+	int i;
+
+	might_sleep();
+
+	for (i = sh->disks; i-- ;) {
+		int rw;
+		struct bio *bi;
+		mdk_rdev_t *rdev;
+		if (test_and_clear_bit(R5_Wantwrite, &sh->dev[i].flags))
+			rw = 1;
+		else if (test_and_clear_bit(R5_Wantread, &sh->dev[i].flags))
+			rw = 0;
+		else
+			continue;
+
+		bi = &sh->dev[i].req;
+
+		bi->bi_rw = rw;
+		if (rw)
+			bi->bi_end_io = raid5_end_write_request;
+		else
+			bi->bi_end_io = raid5_end_read_request;
+
+		rcu_read_lock();
+		rdev = rcu_dereference(conf->disks[i].rdev);
+		if (rdev && test_bit(Faulty, &rdev->flags))
+			rdev = NULL;
+		if (rdev)
+			atomic_inc(&rdev->nr_pending);
+		rcu_read_unlock();
+
+		if (rdev) {
+			if (test_bit(STRIPE_SYNCING, &sh->state) ||
+				test_bit(STRIPE_EXPAND_SOURCE, &sh->state) ||
+				test_bit(STRIPE_EXPAND_READY, &sh->state))
+				md_sync_acct(rdev->bdev, STRIPE_SECTORS);
+
+			bi->bi_bdev = rdev->bdev;
+			PRINTK("%s: stripe %llu schedule op %ld on disc %d\n",
+				__FUNCTION__,
+				(unsigned long long)sh->sector, bi->bi_rw, i);
+			atomic_inc(&sh->count);
+			bi->bi_sector = sh->sector + rdev->data_offset;
+			bi->bi_flags = 1 << BIO_UPTODATE;
+			bi->bi_vcnt = 1;
+			bi->bi_max_vecs = 1;
+			bi->bi_idx = 0;
+			bi->bi_io_vec = &sh->dev[i].vec;
+			bi->bi_io_vec[0].bv_len = STRIPE_SIZE;
+			bi->bi_io_vec[0].bv_offset = 0;
+			bi->bi_size = STRIPE_SIZE;
+			bi->bi_next = NULL;
+			if (rw == WRITE &&
+			    test_bit(R5_ReWrite, &sh->dev[i].flags))
+				atomic_add(STRIPE_SECTORS, &rdev->corrected_errors);
+			generic_make_request(bi);
+		} else {
+			if (rw == 1)
+				set_bit(STRIPE_DEGRADED, &sh->state);
+			PRINTK("skip op %ld on disc %d for sector %llu\n",
+				bi->bi_rw, i, (unsigned long long)sh->sector);
+			clear_bit(R5_LOCKED, &sh->dev[i].flags);
+			set_bit(STRIPE_HANDLE, &sh->state);
+		}
+	}
+}
+
+static struct dma_async_tx_descriptor *
+async_copy_data(int frombio, struct bio *bio, struct page *page, sector_t sector,
+	struct dma_async_tx_descriptor *tx)
+{
+	struct bio_vec *bvl;
+	struct page *bio_page;
+	int i;
+	int page_offset;
+
+	if (bio->bi_sector >= sector)
+		page_offset = (signed)(bio->bi_sector - sector) * 512;
+	else
+		page_offset = (signed)(sector - bio->bi_sector) * -512;
+	bio_for_each_segment(bvl, bio, i) {
+		int len = bio_iovec_idx(bio,i)->bv_len;
+		int clen;
+		int b_offset = 0;
+
+		if (page_offset < 0) {
+			b_offset = -page_offset;
+			page_offset += b_offset;
+			len -= b_offset;
+		}
+
+		if (len > 0 && page_offset + len > STRIPE_SIZE)
+			clen = STRIPE_SIZE - page_offset;
+		else clen = len;
+
+		if (clen > 0) {
+			b_offset += bio_iovec_idx(bio,i)->bv_offset;
+			bio_page = bio_iovec_idx(bio,i)->bv_page;
+			if (frombio)
+				tx = async_memcpy(page, bio_page, page_offset,
+					b_offset, clen,
+					ASYNC_TX_DEP_ACK | ASYNC_TX_KMAP_SRC,
+					tx, NULL, NULL);
+			else
+				tx = async_memcpy(bio_page, page, b_offset,
+					page_offset, clen,
+					ASYNC_TX_DEP_ACK | ASYNC_TX_KMAP_DST,
+					tx, NULL, NULL);
+		}
+		if (clen < len) /* hit end of page */
+			break;
+		page_offset +=  len;
+	}
+
+	return tx;
+}
+
+static void ops_complete_biofill(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	BUG_ON(test_and_set_bit(STRIPE_OP_BIOFILL, &sh->ops.complete));
+	set_bit(STRIPE_HANDLE, &sh->state);
+	release_stripe(sh);
+}
+
+static void ops_run_biofill(struct stripe_head *sh)
+{
+	struct bio *return_bi = NULL;
+	struct dma_async_tx_descriptor *tx = NULL;
+	raid5_conf_t *conf = sh->raid_conf;
+	int i;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	for (i=sh->disks ; i-- ;) {
+		struct r5dev *dev = &sh->dev[i];
+		if (test_bit(R5_Wantfill, &dev->flags)) {
+			struct bio *rbi, *rbi2;
+			spin_lock_irq(&conf->device_lock);
+			rbi = dev->toread;
+			dev->toread = NULL;
+			spin_unlock_irq(&conf->device_lock);
+			while (rbi && rbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+				tx = async_copy_data(0, rbi, dev->page,
+					dev->sector, tx);
+				rbi2 = r5_next_bio(rbi, dev->sector);
+				spin_lock_irq(&conf->device_lock);
+				if (--rbi->bi_phys_segments == 0) {
+					rbi->bi_next = return_bi;
+					return_bi = rbi;
+				}
+				spin_unlock_irq(&conf->device_lock);
+				rbi = rbi2;
+			}
+			dev->read = return_bi;
+		}
+	}
+
+	atomic_inc(&sh->count);
+	async_interrupt(ASYNC_TX_DEP_ACK | ASYNC_TX_ACK, tx,
+		ops_complete_biofill, sh);
+}
+
+static void ops_complete_compute5(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+	int target = sh->ops.target;
+	struct r5dev *tgt = &sh->dev[target];
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	set_bit(R5_UPTODATE, &tgt->flags);
+	BUG_ON(!test_and_clear_bit(R5_Wantcompute, &tgt->flags));
+	BUG_ON(test_and_set_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.complete));
+	set_bit(STRIPE_HANDLE, &sh->state);
+	release_stripe(sh);
+}
+
+static struct dma_async_tx_descriptor *
+ops_run_compute5(struct stripe_head *sh, unsigned long pending)
+{
+	/* since we are running in a workqueue our stack is not
+	 * very deep at this point, but kernel stack size limits the total
+	 * number of disks
+	 */
+	int disks = sh->disks;
+	struct page *xor_srcs[disks];
+	int target = sh->ops.target;
+	struct r5dev *tgt = &sh->dev[target];
+	struct page *xor_dest = tgt->page;
+	int count = 0;
+	struct dma_async_tx_descriptor *tx;
+	int i;
+
+	PRINTK("%s: stripe %llu block: %d\n",
+		__FUNCTION__, (unsigned long long)sh->sector, target);
+	BUG_ON(!test_bit(R5_Wantcompute, &tgt->flags));
+
+	for (i=disks ; i-- ; )
+		if (i != target)
+			xor_srcs[count++] = sh->dev[i].page;
+
+	atomic_inc(&sh->count);
+
+	tx = async_xor(xor_dest, xor_srcs, 0, count, STRIPE_SIZE,
+		ASYNC_TX_XOR_ZERO_DST | ASYNC_TX_INT_EN, NULL,
+		ops_complete_compute5, sh);
+
+	/* ack now if postxor is not set to be run */
+	if (tx && !test_bit(STRIPE_OP_POSTXOR, &pending))
+		async_tx_ack(tx);
+
+	return tx;
+}
+
+static void ops_complete_prexor(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	set_bit(STRIPE_OP_PREXOR, &sh->ops.complete);
+}
+
+static struct dma_async_tx_descriptor *
+ops_run_prexor(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
+{
+	/* since we are running in a workqueue our stack is not
+	 * very deep at this point, but kernel stack size limits the total
+	 * number of disks
+	 */
+	int disks = sh->disks;
+	struct page *xor_srcs[disks];
+	int count = 0, pd_idx = sh->pd_idx, i;
+
+	/* existing parity data subtracted */
+	struct page *xor_dest = xor_srcs[count++] = sh->dev[pd_idx].page;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	for (i=disks ; i-- ;) {
+		struct r5dev *dev = &sh->dev[i];
+		/* Only process blocks that are known to be uptodate */
+		if (dev->towrite && test_bit(R5_Wantprexor, &dev->flags))
+			xor_srcs[count++] = dev->page;
+	}
+
+	tx = async_xor(xor_dest, xor_srcs, 0, count, STRIPE_SIZE,
+		ASYNC_TX_DEP_ACK | ASYNC_TX_XOR_DROP_DST, tx,
+		ops_complete_prexor, sh);
+
+	/* trigger a channel switch if necesary */
+	tx = async_interrupt_cond(DMA_MEMCPY, ASYNC_TX_DEP_ACK, tx,
+		NULL, NULL);
+
+	return tx;
+}
+
+static void ops_complete_biodrain(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	BUG_ON(test_and_set_bit(STRIPE_OP_BIODRAIN, &sh->ops.complete));
+}
+
+static struct dma_async_tx_descriptor *
+ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
+{
+	int disks = sh->disks;
+	int pd_idx = sh->pd_idx, i;
+
+	/* check if prexor is active which means only process blocks
+	 * that are part of a read-modify-write (Wantprexor)
+	 */
+	int prexor = test_bit(STRIPE_OP_PREXOR, &sh->ops.pending);
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	for (i=disks ; i-- ;) {
+		struct r5dev *dev = &sh->dev[i];
+		struct bio *chosen;
+		int towrite;
+
+		towrite = 0;
+		if (prexor) { /* rmw */
+			if (dev->towrite && test_bit(R5_Wantprexor, &dev->flags))
+				towrite = 1;
+		} else { /* rcw */
+			if (i!=pd_idx && dev->towrite &&
+				test_bit(R5_LOCKED, &dev->flags))
+				towrite = 1;
+		}
+
+		if (towrite) {
+			struct bio *wbi;
+
+			spin_lock(&sh->lock);
+			chosen = dev->towrite;
+			dev->towrite = NULL;
+			BUG_ON(dev->written);
+			wbi = dev->written = chosen;
+			spin_unlock(&sh->lock);
+
+			while (wbi && wbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+				tx = async_copy_data(1, wbi, dev->page,
+					dev->sector, tx);
+				wbi = r5_next_bio(wbi, dev->sector);
+			}
+		}
+	}
+
+	tx = async_interrupt_cond(DMA_XOR, ASYNC_TX_DEP_ACK, tx,
+		ops_complete_biodrain, sh);
+
+	return tx;
+}
+
+static void ops_complete_postxor(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+	int disks = sh->disks, i, pd_idx = sh->pd_idx;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	for (i=disks ; i-- ;) {
+		struct r5dev *dev = &sh->dev[i];
+		if (dev->written || i == pd_idx)
+			set_bit(R5_UPTODATE, &dev->flags);
+	}
+
+	BUG_ON(test_and_set_bit(STRIPE_OP_POSTXOR, &sh->ops.complete));
+	set_bit(STRIPE_HANDLE, &sh->state);
+	release_stripe(sh);
+}
+
+static void
+ops_run_postxor(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
+{
+	/* since we are running in a workqueue our stack is not
+	 * very deep at this point, but kernel stack size limits the total
+	 * number of disks
+	 */
+	int disks = sh->disks;
+	struct page *xor_srcs[disks];
+
+	int count = 0, pd_idx = sh->pd_idx, i;
+	struct page *xor_dest;
+	int prexor = test_bit(STRIPE_OP_PREXOR, &sh->ops.pending);
+	unsigned long flags;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	/* check if prexor is active which means only process blocks
+	 * that are part of a read-modify-write (written)
+	 */
+	if (prexor) {
+		xor_dest = xor_srcs[count++] = sh->dev[pd_idx].page;
+		for (i=disks; i--;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (dev->written)
+				xor_srcs[count++] = dev->page;
+		}
+	} else {
+		xor_dest = sh->dev[pd_idx].page;
+		for (i=disks; i--;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (i!=pd_idx)
+				xor_srcs[count++] = dev->page;
+		}
+	}
+
+	atomic_inc(&sh->count);
+
+	/* 1/ if we prexor'd then the dest is reused as a source
+	 * 2/ if we did not prexor then we are redoing the parity
+	 * set ASYNC_TX_XOR_DROP_DST and ASYNC_TX_XOR_ZERO_DST
+	 * for the synchronous xor case
+	 */
+	flags = ASYNC_TX_DEP_ACK | ASYNC_TX_ACK | ASYNC_TX_INT_EN |
+		(prexor ? ASYNC_TX_XOR_DROP_DST : ASYNC_TX_XOR_ZERO_DST);
+
+	tx = async_xor(xor_dest, xor_srcs, 0, count, STRIPE_SIZE,
+		flags, tx, ops_complete_postxor, sh);
+}
+
+static void ops_complete_check(void *stripe_head_ref)
+{
+	struct stripe_head *sh = stripe_head_ref;
+	int pd_idx = sh->pd_idx;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	if (test_and_clear_bit(STRIPE_OP_MOD_DMA_CHECK, &sh->ops.pending) &&
+		sh->ops.zero_sum_result == 0)
+		set_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+
+	BUG_ON(test_and_set_bit(STRIPE_OP_CHECK, &sh->ops.complete));
+	set_bit(STRIPE_HANDLE, &sh->state);
+	release_stripe(sh);
+}
+
+static void ops_run_check(struct stripe_head *sh)
+{
+	/* since we are running in a workqueue our stack is not
+	 * very deep at this point, but kernel stack size limits the total
+	 * number of disks
+	 */
+	int disks = sh->disks;
+	struct page *xor_srcs[disks];
+	struct dma_async_tx_descriptor *tx;
+
+	int count = 0, pd_idx = sh->pd_idx, i;
+	struct page *xor_dest = xor_srcs[count++] = sh->dev[pd_idx].page;
+
+	PRINTK("%s: stripe %llu\n", __FUNCTION__,
+		(unsigned long long)sh->sector);
+
+	for (i=disks; i--;) {
+		struct r5dev *dev = &sh->dev[i];
+		if (i != pd_idx)
+			xor_srcs[count++] = dev->page;
+	}
+
+	tx = async_xor_zero_sum(xor_dest, xor_srcs, 0, count, STRIPE_SIZE,
+		&sh->ops.zero_sum_result, 0, NULL, NULL, NULL);
+
+	if (tx)
+		set_bit(STRIPE_OP_MOD_DMA_CHECK, &sh->ops.pending);
+	else
+		clear_bit(STRIPE_OP_MOD_DMA_CHECK, &sh->ops.pending);
+
+	atomic_inc(&sh->count);
+	tx = async_interrupt(ASYNC_TX_DEP_ACK | ASYNC_TX_ACK, tx,
+		ops_complete_check, sh);
+}
+
+/* raid5_run_ops can be called multiple times before handle_stripe
+ * has a chance to clear completed operations. check_op() ensures
+ * that we only dequeue an operation once.
+ */
+#define check_op(op) do {\
+	if (test_bit(op, &sh->ops.pending) &&\
+		!test_bit(op, &sh->ops.complete)) {\
+		if (test_and_set_bit(op, &sh->ops.ack))\
+			clear_bit(op, &pending);\
+		else\
+			ack++;\
+	} else\
+		clear_bit(op, &pending);\
+} while(0)
+
+static void raid5_run_ops(void *stripe_head_ref)
+{
+	unsigned long pending;
+	struct stripe_head *sh = stripe_head_ref;
+	raid5_conf_t *conf = sh->raid_conf;
+	int overlap=0, ack=0, i, disks = sh->disks;
+	struct dma_async_tx_descriptor *tx = NULL;
+
+	/* find new work to run, do not resubmit work that is already
+	 * in flight
+	 */
+	spin_lock(&sh->lock);
+
+	pending = sh->ops.pending;
+	check_op(STRIPE_OP_BIOFILL);
+	check_op(STRIPE_OP_COMPUTE_BLK);
+	check_op(STRIPE_OP_PREXOR);
+	check_op(STRIPE_OP_BIODRAIN);
+	check_op(STRIPE_OP_POSTXOR);
+	check_op(STRIPE_OP_CHECK);
+	if (test_and_clear_bit(STRIPE_OP_IO, &sh->ops.pending))
+		ack++;
+	spin_unlock(&sh->lock);
+
+	/* issue operations */
+
+	if (test_bit(STRIPE_OP_BIOFILL, &pending)) {
+		ops_run_biofill(sh);
+		overlap++;
+	}
+
+	if (test_bit(STRIPE_OP_COMPUTE_BLK, &pending))
+		tx = ops_run_compute5(sh, pending);
+
+	if (test_bit(STRIPE_OP_PREXOR, &pending))
+		tx = ops_run_prexor(sh, tx);
+
+	if (test_bit(STRIPE_OP_BIODRAIN, &pending)) {
+		tx = ops_run_biodrain(sh, tx);
+		overlap++;
+	}
+
+	if (test_bit(STRIPE_OP_POSTXOR, &pending))
+		ops_run_postxor(sh, tx);
+
+	if (test_bit(STRIPE_OP_CHECK, &pending))
+		ops_run_check(sh);
+
+	if (test_bit(STRIPE_OP_IO, &pending))
+		ops_run_io(sh);
+
+	spin_lock(&sh->lock);
+
+	sh->ops.count -= ack;
+	clear_bit(STRIPE_OPSQUEUE_ACTIVE, &sh->state);
+
+	if (overlap)
+		for (i=disks; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (test_and_clear_bit(R5_Overlap, &dev->flags))
+				wake_up(&sh->raid_conf->wait_for_overlap);
+		}
+
+	/* check to see if new ops arrived while we were working */
+	if (sh->ops.count > 0) {
+		set_bit(STRIPE_OPSQUEUE_ACTIVE, &sh->state);
+		issue_raid_ops(sh);
+	} else if (sh->ops.count < 0)
+		BUG();
+
+	spin_unlock(&sh->lock);
+
+	set_bit(STRIPE_HANDLE, &sh->state);
+	release_stripe(sh);
+}
+
 static int grow_one_stripe(raid5_conf_t *conf)
 {
 	struct stripe_head *sh;
diff --git a/include/linux/raid/raid5.h b/include/linux/raid/raid5.h
index f13299a..a1c3f85 100644
--- a/include/linux/raid/raid5.h
+++ b/include/linux/raid/raid5.h
@@ -116,13 +116,43 @@ #include <linux/raid/xor.h>
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
+ * -running i/o to disk
+ * These operations are carried out by raid5_run_ops which uses the async_tx
+ * api to (optionally) offload operations to dedicated hardware engines.
+ * When requesting an operation handle_stripe sets the pending bit for the
+ * operation and increments the count.  The workqueue is then run whenever
+ * the count is non-zero and is not already active (determined by the
+ * STRIPE_OPSQUEUE_ACTIVE flag).
+ * There are some critical dependencies between the operations that prevent some
+ * from being requested while another is in flight.
+ * 1/ Parity check operations destroy the in cache version of the parity block,
+ *    so we prevent parity dependent operations like writes and compute_blocks
+ *    from starting while a check is in progress.  Some dma engines can perform
+ *    the check without damaging the parity block, in these cases the parity block
+ *    is re-marked up to date (assuming the check was successful) and is not
+ *    re-read from disk.
+ * 2/ When a write operation is requested we immediately lock the affected blocks,
+ *    and mark them as not up to date.  This causes new read requests to be held
+ *    off, as well as parity checks and compute block operations.
+ * 3/ Once a compute block operation has been requested handle_stripe treats that
+ *    block as if it is up to date.  raid5_run_ops
+ *    guaruntees that any operation that is dependent on the
+ *    compute block result is initiated after the compute block completes.
  */
 
 struct stripe_head {
@@ -136,11 +166,19 @@ struct stripe_head {
 	spinlock_t		lock;
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	int			disks;			/* disks in stripe */
+	struct stripe_operations {
+		unsigned long	   pending;  /* pending operations (set for request->issue->complete) */
+		unsigned long	   ack;	     /* submitted operations (set for issue->complete */
+		unsigned long	   complete; /* completed operations flags (set for complete) */
+		int		   target;   /* STRIPE_OP_COMPUTE_BLK target */
+		int		   count;    /* workqueue runs when this is non-zero */
+		u32		   zero_sum_result;
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
@@ -156,8 +194,12 @@ #define	R5_Wantwrite	5
 #define	R5_Overlap	7	/* There is a pending overlapping request on this block */
 #define	R5_ReadError	8	/* seen a read error here recently */
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
-
 #define	R5_Expanded	10	/* This block now has post-expand data */
+#define	R5_Consistent	11	/* Block is HW DMA-able without a cache flush */
+#define	R5_Wantcompute	12	/* compute_block in progress treat as uptodate */
+#define	R5_Wantfill	13	/* dev->toread contains a bio that needs filling */
+#define	R5_Wantprexor	14	/* distinguish blocks ready for rmw from other "towrites" */
+
 /*
  * Write method
  */
@@ -179,6 +221,23 @@ #define	STRIPE_BIT_DELAY	8
 #define	STRIPE_EXPANDING	9
 #define	STRIPE_EXPAND_SOURCE	10
 #define	STRIPE_EXPAND_READY	11
+#define	STRIPE_OPSQUEUE_ACTIVE 12
+
+/*
+ * Operations flags (in issue order)
+ */
+#define STRIPE_OP_BIOFILL	0
+#define STRIPE_OP_COMPUTE_BLK	1
+#define STRIPE_OP_PREXOR	2
+#define STRIPE_OP_BIODRAIN	3
+#define STRIPE_OP_POSTXOR	4
+#define STRIPE_OP_CHECK	5
+#define STRIPE_OP_IO		6
+
+/* modifiers to the base operations */
+#define STRIPE_OP_MOD_REPAIR_PD	7 /* compute the parity block and write it back */
+#define STRIPE_OP_MOD_DMA_CHECK	8 /* parity is not corrupted by the check */
+
 /*
  * Plugging:
  *
