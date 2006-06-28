Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWF1Sfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWF1Sfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWF1Sfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:35:46 -0400
Received: from mga03.intel.com ([143.182.124.21]:62897 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750897AbWF1Sfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:35:44 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="58771697:sNHT3583673149"
Subject: [PATCH 003 of 006] raid5: Move compute block operations to a work
	queue
From: Dan Williams <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:24:03 -0700
Message-Id: <1151519043.2232.65.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 'compute block' capabilities to the work queue.

Here are a few notes about the new flags R5_ComputeReq and
STRIPE_OP_COMPUTE_Recover:

Previously, when handle_stripe5 found a block that needed to be computed
it updated it in the same step.  Now that these operations are separated
(across multiple calls to handle_stripe5), a R5_ComputeReq flag is
needed to tell other parts of handle_stripe5 to treat the block under
computation as if it were up to date.  The order of events in the work
queue ensures that the block is indeed up to date before performing
further operations.

STRIPE_OP_COMPUTE_Recover was added to track when the parity block is
being computed due to a failed parity check.  This allows the code in
handle_stripe5 that produces requests for check_parity and compute_block
operations to be separate from the code that consumes the result.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 drivers/md/raid5.c         |  147 +++++++++++++++++++++++++++++++++++++--------
 include/linux/raid/raid5.h |    7 +-
 2 files changed, 129 insertions(+), 25 deletions(-)

===================================================================
Index: linux-2.6-raid/drivers/md/raid5.c
===================================================================
--- linux-2.6-raid.orig/drivers/md/raid5.c	2006-06-28 10:47:43.000000000 -0700
+++ linux-2.6-raid/drivers/md/raid5.c	2006-06-28 11:06:06.000000000 -0700
@@ -1263,7 +1263,9 @@
 			}
 		} else {
 			/* enter stage 1 of read modify write operation */
-			BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags));
+			BUG_ON(!(test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags) ||
+				test_bit(R5_ComputeReq, &sh->dev[pd_idx].flags)));
+
 			set_bit(STRIPE_OP_RMW, &sh->state);
 			set_bit(STRIPE_OP_RMW_ParityPre, &sh->ops.state);
 			for (i=disks ; i-- ;) {
@@ -1272,7 +1274,8 @@
 					continue;
 
 				if (dev->towrite &&
-				    test_bit(R5_UPTODATE, &dev->flags)) {
+				    (test_bit(R5_UPTODATE, &dev->flags) ||
+				    test_bit(R5_ComputeReq, &dev->flags))) {
 					set_bit(R5_LOCKED, &dev->flags);
 					locked++;
 				}
@@ -1331,6 +1334,30 @@
 	return work_queued;
 }
 
+static int handle_compute_operations5(struct stripe_head *sh, int dd_idx)
+{
+	int work_queued = -EBUSY;
+
+	if (test_bit(STRIPE_OP_COMPUTE, &sh->state) &&
+		test_bit(STRIPE_OP_COMPUTE_Done, &sh->ops.state)) {
+		clear_bit(STRIPE_OP_COMPUTE, &sh->state);
+		clear_bit(STRIPE_OP_COMPUTE_Done, &sh->ops.state);
+		clear_bit(R5_ComputeReq, &sh->dev[dd_idx].flags);
+		work_queued = 0;
+	} else if (!test_bit(STRIPE_OP_COMPUTE, &sh->state)) {
+		set_bit(STRIPE_OP_COMPUTE, &sh->state);
+		set_bit(STRIPE_OP_COMPUTE_Prep, &sh->ops.state);
+		set_bit(R5_ComputeReq, &sh->dev[dd_idx].flags);
+		work_queued = 1;
+		sh->ops.pending++;
+	}
+
+	PRINTK("%s: stripe %llu work_queued: %d op_state: %lx dev[%d].flags: %lx\n",
+		__FUNCTION__, (unsigned long long)sh->sector,
+		work_queued, sh->ops.state, dd_idx, sh->dev[dd_idx].flags);
+
+	return work_queued;
+}
 
 /*
  * Each stripe/dev can have one or more bion attached.
@@ -1454,7 +1481,7 @@
 	int i, pd_idx = sh->pd_idx, disks = sh->disks, count = 1;
 	void *ptr[MAX_XOR_BLOCKS];
 	struct bio *chosen;
-	int overlap=0, work=0, written=0;
+	int overlap=0, work=0, written=0, compute=0, dd_idx=0;
 	unsigned long state, ops_state, ops_state_orig;
 
 	/* take a snapshot of what needs to be done at this point in time */
@@ -1463,6 +1490,51 @@
 	ops_state_orig = ops_state = sh->ops.state;
 	spin_unlock(&sh->lock);
 
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
+			for (i = disks ; i--; ) {
+				struct r5dev *dev = &sh->dev[i];
+				void *p;
+				if (i == dd_idx)
+					continue;
+				p = page_address(dev->page);
+				if (test_bit(R5_UPTODATE, &dev->flags))
+					ptr[count++] = p;
+				else
+					printk(KERN_ERR "STRIPE_OP_COMPUTE %d, stripe %llu, %d"
+						" not present\n", dd_idx,
+						(unsigned long long)sh->sector, i);
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
 	if (test_bit(STRIPE_OP_RMW, &state)) {
 		BUG_ON(test_bit(STRIPE_OP_RCW, &state));
 		PRINTK("%s: stripe %llu STRIPE_OP_RMW op_state: %lx\n",
@@ -1615,6 +1687,9 @@
 				wake_up(&sh->raid_conf->wait_for_overlap);
 		}
 
+	if (compute)
+		set_bit(R5_UPTODATE, &sh->dev[dd_idx].flags);
+
 	sh->ops.pending -= work;
 	clear_bit(STRIPE_OP_QUEUED, &sh->state);
 	set_bit(STRIPE_HANDLE, &sh->state);
@@ -1857,25 +1932,32 @@
 	 * parity, or to satisfy requests
 	 * or to load a block that is being partially written.
 	 */
-	if (to_read || non_overwrite || (syncing && (uptodate < disks)) || expanding) {
+	if (to_read || non_overwrite || (syncing && (uptodate < disks)) || expanding ||
+		test_bit(STRIPE_OP_COMPUTE, &sh->state)) {
 		for (i=disks; i--;) {
 			dev = &sh->dev[i];
-			if (!test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
-			    (dev->toread ||
+			if (test_bit(R5_ComputeReq, &dev->flags) ||
+			    (!test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
+			     (dev->toread ||
 			     (dev->towrite && !test_bit(R5_OVERWRITE, &dev->flags)) ||
 			     syncing ||
 			     expanding ||
 			     (failed && (sh->dev[failed_num].toread ||
 					 (sh->dev[failed_num].towrite && !test_bit(R5_OVERWRITE, &sh->dev[failed_num].flags))))
-				    )
+				    ))
 				) {
 				/* we would like to get this block, possibly
 				 * by computing it, but we might not be able to
 				 */
-				if (uptodate == disks-1) {
-					PRINTK("Computing block %d\n", i);
-					compute_block(sh, i);
-					uptodate++;
+				if ((uptodate == disks-1) || test_bit(STRIPE_OP_COMPUTE, &sh->state)) {
+					handle_compute_operations5(sh, i);
+					if (uptodate == disks-1)
+						uptodate++;
+					/* Careful: from this point on 'uptodate' is in the eye of the
+					 * workqueue which services 'compute' operations before writes
+					 * and parity checks.  R5_ComputeReq flags blocks that will be
+					 * R5_UPTODATE in the work queue.
+					 */
 				} else if (test_bit(R5_Insync, &dev->flags)) {
 					set_bit(R5_LOCKED, &dev->flags);
 					set_bit(R5_Wantread, &dev->flags);
@@ -1898,8 +1980,7 @@
 	}
 
 	/* now to consider writing and what else, if anything should be read */
-	if (to_write || test_bit(STRIPE_OP_RCW, &sh->state) ||
-		test_bit(STRIPE_OP_RMW, &sh->state)) {
+	if (to_write || test_bit(STRIPE_OP_RCW, &sh->state) || test_bit(STRIPE_OP_RMW, &sh->state)) {
 		int rmw=0, rcw=0;
 		for (i=disks ; i--;) {
 			/* would I have to read this buffer for read_modify_write */
@@ -1910,7 +1991,7 @@
 || sh->bh_page[i]!=bh->b_page
 #endif
 				    ) &&
-			    !test_bit(R5_UPTODATE, &dev->flags)) {
+			    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_ComputeReq, &dev->flags))) {
 				if (test_bit(R5_Insync, &dev->flags)
 /*				    && !(!mddev->insync && i == sh->pd_idx) */
 					)
@@ -1924,7 +2005,7 @@
 || sh->bh_page[i] != bh->b_page
 #endif
 				    ) &&
-			    !test_bit(R5_UPTODATE, &dev->flags)) {
+			    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_ComputeReq, &dev->flags))) {
 				if (test_bit(R5_Insync, &dev->flags)) rcw++;
 				else rcw += 2*disks;
 			}
@@ -1937,7 +2018,8 @@
 			for (i=disks; i--;) {
 				dev = &sh->dev[i];
 				if ((dev->towrite || i == sh->pd_idx) &&
-				    !test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
+				    !test_bit(R5_LOCKED, &dev->flags) &&
+				    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_ComputeReq, &dev->flags)) &&
 				    test_bit(R5_Insync, &dev->flags)) {
 					if (test_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 					{
@@ -1956,7 +2038,8 @@
 			for (i=disks; i--;) {
 				dev = &sh->dev[i];
 				if (!test_bit(R5_OVERWRITE, &dev->flags) && i != sh->pd_idx &&
-				    !test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
+				    !test_bit(R5_LOCKED, &dev->flags) &&
+				    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_ComputeReq, &dev->flags)) &&
 				    test_bit(R5_Insync, &dev->flags)) {
 					if (test_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 					{
@@ -2007,12 +2090,20 @@
 		int work_queued = 0, result = 0;
 
 		set_bit(STRIPE_HANDLE, &sh->state);
-		if (failed == 0) {
+		/* Take one of the following actions:
+		 * 1/ start a check parity operation if (uptodate == disks)
+		 * 2/ finish a check parity operation and act on the result
+		 * 3/ skip this section if we previously initiated a recovery
+		 *    operation
+		 */
+		if (failed == 0 && !test_bit(STRIPE_OP_COMPUTE_Recover, &sh->ops.state)) {
 			BUG_ON(!test_bit(STRIPE_OP_CHECK, &sh->state) &&
 				(uptodate != disks));
 			work_queued = handle_check_operations5(sh,
 							uptodate == disks);
-			result = test_and_clear_bit(STRIPE_OP_CHECK_IsZero, &sh->ops.state);
+			if (work_queued == 0)
+				result = test_and_clear_bit(STRIPE_OP_CHECK_IsZero,
+							&sh->ops.state);
 			if (work_queued > 0) {
 				uptodate--;
 			} else if (result && work_queued == 0) {
@@ -2024,15 +2115,25 @@
 					/* don't try to repair!! */
 					set_bit(STRIPE_INSYNC, &sh->state);
 				else {
-					compute_block(sh, sh->pd_idx);
-					uptodate++;
+					set_bit(STRIPE_OP_COMPUTE_Recover, &sh->ops.state);
+					handle_compute_operations5(sh, sh->pd_idx);
+					if (uptodate == disks-1)
+						uptodate++;
 				}
 			}
 		}
-		if (!test_bit(STRIPE_INSYNC, &sh->state) && work_queued == 0) {
+		/* Wait for check parity and compute block operations to complete
+		 * before write-back
+		 */
+		if (!test_bit(STRIPE_INSYNC, &sh->state) &&
+			!test_bit(STRIPE_OP_CHECK, &sh->state) &&
+			!test_bit(STRIPE_OP_COMPUTE, &sh->state)) {
 			/* either failed parity check, or recovery is happening */
-			if (failed==0)
+			if (failed==0) {
+				BUG_ON(!test_and_clear_bit(
+					STRIPE_OP_COMPUTE_Recover, &sh->ops.state));
 				failed_num = sh->pd_idx;
+			}
 			dev = &sh->dev[failed_num];
 			BUG_ON(!test_bit(R5_UPTODATE, &dev->flags));
 			BUG_ON(uptodate != disks);
Index: linux-2.6-raid/include/linux/raid/raid5.h
===================================================================
--- linux-2.6-raid.orig/include/linux/raid/raid5.h	2006-06-28 10:47:43.000000000 -0700
+++ linux-2.6-raid/include/linux/raid/raid5.h	2006-06-28 11:05:38.000000000 -0700
@@ -179,6 +179,7 @@
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
 #define	R5_Expanded	10	/* This block now has post-expand data */
 #define	R5_Consistent	11	/* Block is HW DMA-able without a cache flush */
+#define	R5_ComputeReq	12	/* compute_block in progress treat as uptodate */
 
 /*
  * Write method
@@ -238,15 +239,17 @@
 #define	STRIPE_OP_COMPUTE_Parity	15
 #define	STRIPE_OP_COMPUTE_End		16
 #define	STRIPE_OP_COMPUTE_Done		17
+#define	STRIPE_OP_COMPUTE_Recover	18
 
 /*
- * Bit mask for status bits set by the work queue thread
+ * Bit mask for status bits not to be cleared by the work queue thread
  */
 #define	STRIPE_OP_COMPLETION_MASK 	(1 << STRIPE_OP_RCW_Done |\
 						1 << STRIPE_OP_RMW_Done |\
 						1 << STRIPE_OP_CHECK_Done |\
 						1 << STRIPE_OP_CHECK_IsZero |\
-						1 << STRIPE_OP_COMPUTE_Done)
+						1 << STRIPE_OP_COMPUTE_Done |\
+						1 << STRIPE_OP_COMPUTE_Recover)
 /*
  * Plugging:
  *
