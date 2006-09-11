Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWIKXSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWIKXSB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWIKXSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:18:00 -0400
Received: from mga03.intel.com ([143.182.124.21]:31035 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S965025AbWIKXR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:17:58 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="114946901:sNHT119571452"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 04/19] raid5: move compute block operations to a workqueue
Date: Mon, 11 Sep 2006 16:17:56 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231756.4737.91223.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Enable handle_stripe5 to pass off compute block operations to
raid5_do_soft_block_ops, formerly handled by compute_block.

Here are a few notes about the new flags R5_ComputeReq and
STRIPE_OP_COMPUTE_Recover:

Previously, when handle_stripe5 found a block that needed to be computed it
updated it in the same step.  Now that these operations are separated
(across multiple calls to handle_stripe5), a R5_ComputeReq flag is needed
to tell other parts of handle_stripe5 to treat the block under computation
as if it were up to date.  The order of events in the work queue ensures that the
block is indeed up to date before performing further operations.

STRIPE_OP_COMPUTE_Recover_pd was added to track when the parity block is being
computed due to a failed parity check.  This allows the code in
handle_stripe5 that produces requests for check_parity and compute_block
operations to be separate from the code that consumes the result.

Changelog:
* count blocks under computation as uptodate
* removed handle_compute_operations5.  All logic moved into handle_stripe5
so that we do not need to go through the initiation logic to end the
operation.
* since the write operations mark blocks !uptodate we hold off the code to
compute/read blocks until it completes.
* new compute block operations and reads are held off while a compute is in
flight
* do not compute a block while a check parity operation is pending, and do
not start a new check parity operation while a compute operation is pending
* STRIPE_OP_Recover_pd holds off the clearing of the STRIPE_OP_COMPUTE state.
This allows the transition to be handled by the check parity logic that
writes recomputed parity to disk.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |  153 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 107 insertions(+), 46 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 24ed4d8..0c39203 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1300,7 +1300,8 @@ static int handle_write_operations5(stru
 		}
 	} else {
 		/* enter stage 1 of read modify write operation */
-		BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags));
+		BUG_ON(!(test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags) ||
+			test_bit(R5_ComputeReq, &sh->dev[pd_idx].flags)));
 
 		set_bit(STRIPE_OP_RMW, &sh->state);
 		set_bit(STRIPE_OP_RMW_ParityPre, &sh->ops.state);
@@ -1314,7 +1315,8 @@ static int handle_write_operations5(stru
 			 * so we distinguish these blocks by the RMWReq bit
 			 */
 			if (dev->towrite &&
-			    test_bit(R5_UPTODATE, &dev->flags)) {
+			    (test_bit(R5_UPTODATE, &dev->flags) ||
+			    test_bit(R5_ComputeReq, &dev->flags))) {
 				set_bit(R5_RMWReq, &dev->flags);
 				set_bit(R5_LOCKED, &dev->flags);
 				clear_bit(R5_UPTODATE, &dev->flags);
@@ -1748,7 +1750,7 @@ static void handle_stripe5(struct stripe
 	int i;
 	int syncing, expanding, expanded;
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
-	int non_overwrite=0, write_complete=0;
+	int compute=0, non_overwrite=0, write_complete=0;
 	int failed_num=0;
 	struct r5dev *dev;
 
@@ -1799,7 +1801,7 @@ static void handle_stripe5(struct stripe
 		/* now count some things */
 		if (test_bit(R5_LOCKED, &dev->flags)) locked++;
 		if (test_bit(R5_UPTODATE, &dev->flags)) uptodate++;
-
+		if (test_bit(R5_ComputeReq, &dev->flags)) BUG_ON(++compute > 1);
 		
 		if (dev->toread) to_read++;
 		if (dev->towrite) {
@@ -1955,40 +1957,83 @@ static void handle_stripe5(struct stripe
 	 * parity, or to satisfy requests
 	 * or to load a block that is being partially written.
 	 */
-	if (to_read || non_overwrite || (syncing && (uptodate < disks)) || expanding) {
-		for (i=disks; i--;) {
-			dev = &sh->dev[i];
-			if (!test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
-			    (dev->toread ||
-			     (dev->towrite && !test_bit(R5_OVERWRITE, &dev->flags)) ||
-			     syncing ||
-			     expanding ||
-			     (failed && (sh->dev[failed_num].toread ||
-					 (sh->dev[failed_num].towrite && !test_bit(R5_OVERWRITE, &sh->dev[failed_num].flags))))
-				    )
-				) {
-				/* we would like to get this block, possibly
-				 * by computing it, but we might not be able to
+	if (to_read || non_overwrite || (syncing && (uptodate + compute < disks)) || expanding ||
+		test_bit(STRIPE_OP_COMPUTE, &sh->state)) {
+		/* Finish any pending compute operations.  Parity recovery implies
+		 * a write-back which is handled later on in this routine
+		 */
+		if (test_bit(STRIPE_OP_COMPUTE, &sh->state) &&
+			test_bit(STRIPE_OP_COMPUTE_Done, &sh->ops.state) &&
+			!test_bit(STRIPE_OP_COMPUTE_Recover_pd, &sh->ops.state)) {
+			clear_bit(STRIPE_OP_COMPUTE, &sh->state);
+			clear_bit(STRIPE_OP_COMPUTE_Done, &sh->ops.state);
+		}
+		
+		/* blocks being written are temporarily !UPTODATE */
+		if (!test_bit(STRIPE_OP_COMPUTE, &sh->state) &&
+			!test_bit(STRIPE_OP_RCW, &sh->state) &&
+			!test_bit(STRIPE_OP_RMW, &sh->state)) {
+			for (i=disks; i--;) {
+				dev = &sh->dev[i];
+
+				/* don't schedule compute operations or reads on
+				 * the parity block while a check is in flight
 				 */
-				if (uptodate == disks-1) {
-					PRINTK("Computing block %d\n", i);
-					compute_block(sh, i);
-					uptodate++;
-				} else if (test_bit(R5_Insync, &dev->flags)) {
-					set_bit(R5_LOCKED, &dev->flags);
-					set_bit(R5_Wantread, &dev->flags);
+				if ((i == sh->pd_idx) && test_bit(STRIPE_OP_CHECK, &sh->state))
+					continue;
+
+				if (!test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
+				     (dev->toread ||
+				     (dev->towrite && !test_bit(R5_OVERWRITE, &dev->flags)) ||
+				     syncing ||
+				     expanding ||
+				     (failed && (sh->dev[failed_num].toread ||
+						 (sh->dev[failed_num].towrite &&
+						 	!test_bit(R5_OVERWRITE, &sh->dev[failed_num].flags))))
+					    )
+					) {
+					/* 1/ We would like to get this block, possibly
+					 * by computing it, but we might not be able to.
+					 *
+					 * 2/ Since parity check operations make the parity
+					 * block !uptodate it will need to be refreshed
+					 * before any compute operations on data disks are
+					 * scheduled.
+					 *
+					 * 3/ We hold off parity block re-reads until check
+					 * operations have quiesced.
+					 */
+					if ((uptodate == disks-1) && !test_bit(STRIPE_OP_CHECK, &sh->state)) {
+						set_bit(STRIPE_OP_COMPUTE, &sh->state);
+						set_bit(STRIPE_OP_COMPUTE_Prep, &sh->ops.state);
+						set_bit(R5_ComputeReq, &dev->flags);
+						sh->ops.pending++;
+						/* Careful: from this point on 'uptodate' is in the eye of the
+						 * workqueue which services 'compute' operations before writes.
+						 * R5_ComputeReq flags blocks that will be R5_UPTODATE
+						 * in the work queue.
+						 */
+						uptodate++;
+					} else if ((uptodate < disks-1) && test_bit(R5_Insync, &dev->flags)) {
+						/* Note: we hold off compute operations while checks are in flight,
+						 * but we still prefer 'compute' over 'read' hence we only read if
+						 * (uptodate < disks-1)
+						 */
+						set_bit(R5_LOCKED, &dev->flags);
+						set_bit(R5_Wantread, &dev->flags);
 #if 0
-					/* if I am just reading this block and we don't have
-					   a failed drive, or any pending writes then sidestep the cache */
-					if (sh->bh_read[i] && !sh->bh_read[i]->b_reqnext &&
-					    ! syncing && !failed && !to_write) {
-						sh->bh_cache[i]->b_page =  sh->bh_read[i]->b_page;
-						sh->bh_cache[i]->b_data =  sh->bh_read[i]->b_data;
-					}
+						/* if I am just reading this block and we don't have
+						   a failed drive, or any pending writes then sidestep the cache */
+						if (sh->bh_read[i] && !sh->bh_read[i]->b_reqnext &&
+						    ! syncing && !failed && !to_write) {
+							sh->bh_cache[i]->b_page =  sh->bh_read[i]->b_page;
+							sh->bh_cache[i]->b_data =  sh->bh_read[i]->b_data;
+						}
 #endif
-					locked++;
-					PRINTK("Reading block %d (sync=%d)\n", 
-						i, syncing);
+						locked++;
+						PRINTK("Reading block %d (sync=%d)\n", 
+							i, syncing);
+					}
 				}
 			}
 		}
@@ -2055,7 +2100,7 @@ #if 0
 || sh->bh_page[i]!=bh->b_page
 #endif
 				    ) &&
-			    !test_bit(R5_UPTODATE, &dev->flags)) {
+			    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_ComputeReq, &dev->flags))) {
 				if (test_bit(R5_Insync, &dev->flags)
 /*				    && !(!mddev->insync && i == sh->pd_idx) */
 					)
@@ -2069,7 +2114,7 @@ #if 0
 || sh->bh_page[i] != bh->b_page
 #endif
 				    ) &&
-			    !test_bit(R5_UPTODATE, &dev->flags)) {
+			    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_ComputeReq, &dev->flags))) {
 				if (test_bit(R5_Insync, &dev->flags)) rcw++;
 				else rcw += 2*disks;
 			}
@@ -2082,7 +2127,8 @@ #endif
 			for (i=disks; i--;) {
 				dev = &sh->dev[i];
 				if ((dev->towrite || i == sh->pd_idx) &&
-				    !test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
+				    !test_bit(R5_LOCKED, &dev->flags) &&
+				    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_ComputeReq, &dev->flags)) &&
 				    test_bit(R5_Insync, &dev->flags)) {
 					if (test_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 					{
@@ -2101,7 +2147,8 @@ #endif
 			for (i=disks; i--;) {
 				dev = &sh->dev[i];
 				if (!test_bit(R5_OVERWRITE, &dev->flags) && i != sh->pd_idx &&
-				    !test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
+				    !test_bit(R5_LOCKED, &dev->flags) &&
+				    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_ComputeReq, &dev->flags)) &&
 				    test_bit(R5_Insync, &dev->flags)) {
 					if (test_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 					{
@@ -2127,16 +2174,19 @@ #endif
 	 * 2/ Hold off parity checks while parity dependent operations are in flight
 	 *    (RCW and RMW are protected by 'locked')
 	 */
-	if ((syncing && locked == 0 &&
-	    !test_bit(STRIPE_INSYNC, &sh->state)) ||
-	    	test_bit(STRIPE_OP_CHECK, &sh->state)) {
+	if ((syncing && locked == 0 && !test_bit(STRIPE_OP_COMPUTE, &sh->state) &&
+		!test_bit(STRIPE_INSYNC, &sh->state)) ||
+	    	test_bit(STRIPE_OP_CHECK, &sh->state) ||
+	    	test_bit(STRIPE_OP_COMPUTE_Recover_pd, &sh->ops.state)) {
 
 		set_bit(STRIPE_HANDLE, &sh->state);
 		/* Take one of the following actions:
 		 * 1/ start a check parity operation if (uptodate == disks)
 		 * 2/ finish a check parity operation and act on the result
+		 * 3/ skip to the writeback section if we previously 
+		 *    initiated a recovery operation
 		 */
-		if (failed == 0) {
+		if (failed == 0 && !test_bit(STRIPE_OP_COMPUTE_Recover_pd, &sh->ops.state)) {
 			if (!test_bit(STRIPE_OP_CHECK, &sh->state)) {
 				BUG_ON(uptodate != disks);
 				set_bit(STRIPE_OP_CHECK, &sh->state);
@@ -2157,18 +2207,29 @@ #endif
 						/* don't try to repair!! */
 						set_bit(STRIPE_INSYNC, &sh->state);
 					else {
-						compute_block(sh, sh->pd_idx);
+						set_bit(STRIPE_OP_COMPUTE, &sh->state);
+						set_bit(STRIPE_OP_COMPUTE_Recover_pd, &sh->ops.state);
+						set_bit(STRIPE_OP_COMPUTE_Prep, &sh->ops.state);
+						set_bit(R5_ComputeReq, &sh->dev[sh->pd_idx].flags);
+						sh->ops.pending++;
 						uptodate++;
 					}
 				}
 			}
 		}
+		if (test_bit(STRIPE_OP_COMPUTE_Done, &sh->ops.state) &&
+			test_bit(STRIPE_OP_COMPUTE_Recover_pd, &sh->ops.state)) {
+			clear_bit(STRIPE_OP_COMPUTE, &sh->state);
+			clear_bit(STRIPE_OP_COMPUTE_Done, &sh->ops.state);
+			clear_bit(STRIPE_OP_COMPUTE_Recover_pd, &sh->ops.state);
+		}
 
-		/* Wait for check parity operations to complete
+		/* Wait for check parity and compute block operations to complete
 		 * before write-back
 		 */
 		if (!test_bit(STRIPE_INSYNC, &sh->state) &&
-			!test_bit(STRIPE_OP_CHECK, &sh->state)) {
+			!test_bit(STRIPE_OP_CHECK, &sh->state) &&
+			!test_bit(STRIPE_OP_COMPUTE, &sh->state)) {
 
 			/* either failed parity check, or recovery is happening */
 			if (failed==0)
