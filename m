Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031355AbWK3UNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031355AbWK3UNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031335AbWK3UK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:10:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:25976 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1031322AbWK3UKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:10:38 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="168614871:sNHT99236550"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 07/12] md: move raid5 compute block operations to raid5_run_ops
Date: Thu, 30 Nov 2006 13:10:35 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201035.21313.17329.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

handle_stripe sets STRIPE_OP_COMPUTE_BLK to request servicing from
raid5_run_ops.  It also sets a flag for the block being computed to let
other parts of handle_stripe submit dependent operations.  raid5_run_ops
guarantees that the compute operation completes before any dependent
operation starts.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |  139 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 100 insertions(+), 39 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 74516ef..8510183 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2020,7 +2020,7 @@ static void handle_stripe5(struct stripe
 	int i;
 	int syncing, expanding, expanded;
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
-	int non_overwrite = 0;
+	int compute=0, req_compute=0, non_overwrite=0;
 	int failed_num=0;
 	struct r5dev *dev;
 
@@ -2071,8 +2071,8 @@ static void handle_stripe5(struct stripe
 		/* now count some things */
 		if (test_bit(R5_LOCKED, &dev->flags)) locked++;
 		if (test_bit(R5_UPTODATE, &dev->flags)) uptodate++;
+		if (test_bit(R5_Wantcompute, &dev->flags)) BUG_ON(++compute > 1);
 
-		
 		if (dev->toread) to_read++;
 		if (dev->towrite) {
 			to_write++;
@@ -2227,40 +2227,91 @@ static void handle_stripe5(struct stripe
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
+		test_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.pending)) {
+
+		/* Clear completed compute operations.  Parity recovery
+		 * (STRIPE_OP_MOD_REPAIR_PD) implies a write-back which is handled
+		 * later on in this routine
+		 */
+		if (test_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.complete) &&
+			!test_bit(STRIPE_OP_MOD_REPAIR_PD, &sh->ops.pending)) {
+			clear_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.complete);
+			clear_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.ack);
+			clear_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.pending);
+		}
+
+		/* look for blocks to read/compute, skip this if a compute
+		 * is already in flight, or if the stripe contents are in the
+		 * midst of changing due to a write
+		 */
+		if (!test_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.pending) &&
+			!test_bit(STRIPE_OP_PREXOR, &sh->ops.pending) &&
+			!test_bit(STRIPE_OP_POSTXOR, &sh->ops.pending)) {
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
+				if ((i == sh->pd_idx) && test_bit(STRIPE_OP_CHECK, &sh->ops.pending))
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
+					 * 2/ Since parity check operations potentially
+					 * make the parity block !uptodate it will need
+					 * to be refreshed before any compute operations
+					 * on data disks are scheduled.
+					 *
+					 * 3/ We hold off parity block re-reads until check
+					 * operations have quiesced.
+					 */
+					if ((uptodate == disks-1) && !test_bit(STRIPE_OP_CHECK, &sh->ops.pending)) {
+						set_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.pending);
+						set_bit(R5_Wantcompute, &dev->flags);
+						sh->ops.target = i;
+						BUG_ON(req_compute++);
+						sh->ops.count++;
+						/* Careful: from this point on 'uptodate' is in the eye of the
+						 * workqueue which services 'compute' operations before writes.
+						 * R5_Wantcompute flags a block that will be R5_UPTODATE
+						 * by the time it is needed for a subsequent operation.
+						 */
+						uptodate++;
+					} else if ((uptodate < disks-1) && test_bit(R5_Insync, &dev->flags)) {
+						/* Note: we hold off compute operations while checks are in flight,
+						 * but we still prefer 'compute' over 'read' hence we only read if
+						 * (uptodate < disks-1)
+						 */
+						set_bit(R5_LOCKED, &dev->flags);
+						set_bit(R5_Wantread, &dev->flags);
+						if (!test_and_set_bit(STRIPE_OP_IO, &sh->ops.pending))
+							sh->ops.count++;
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
@@ -2338,7 +2389,7 @@ #if 0
 || sh->bh_page[i]!=bh->b_page
 #endif
 				    ) &&
-			    !test_bit(R5_UPTODATE, &dev->flags)) {
+			    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_Wantcompute, &dev->flags))) {
 				if (test_bit(R5_Insync, &dev->flags)
 /*				    && !(!mddev->insync && i == sh->pd_idx) */
 					)
@@ -2352,7 +2403,7 @@ #if 0
 || sh->bh_page[i] != bh->b_page
 #endif
 				    ) &&
-			    !test_bit(R5_UPTODATE, &dev->flags)) {
+			    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_Wantcompute, &dev->flags))) {
 				if (test_bit(R5_Insync, &dev->flags)) rcw++;
 				else rcw += 2*disks;
 			}
@@ -2365,7 +2416,8 @@ #endif
 			for (i=disks; i--;) {
 				dev = &sh->dev[i];
 				if ((dev->towrite || i == sh->pd_idx) &&
-				    !test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
+				    !test_bit(R5_LOCKED, &dev->flags) &&
+				    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_Wantcompute, &dev->flags)) &&
 				    test_bit(R5_Insync, &dev->flags)) {
 					if (test_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 					{
@@ -2384,7 +2436,8 @@ #endif
 			for (i=disks; i--;) {
 				dev = &sh->dev[i];
 				if (!test_bit(R5_OVERWRITE, &dev->flags) && i != sh->pd_idx &&
-				    !test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
+				    !test_bit(R5_LOCKED, &dev->flags) &&
+				    !(test_bit(R5_UPTODATE, &dev->flags) || test_bit(R5_Wantcompute, &dev->flags)) &&
 				    test_bit(R5_Insync, &dev->flags)) {
 					if (test_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 					{
@@ -2399,8 +2452,16 @@ #endif
 				}
 			}
 		/* now if nothing is locked, and if we have enough data, we can start a write request */
-		if (locked == 0 && (rcw == 0 ||rmw == 0) &&
-		    !test_bit(STRIPE_BIT_DELAY, &sh->state))
+		/* since handle_stripe can be called at any time we need to handle the case
+		 * where a compute block operation has been submitted and then a subsequent
+		 * call wants to start a write request.  raid5_run_ops only handles the case where
+		 * compute block and postxor are requested simultaneously.  If this
+		 * is not the case then new writes need to be held off until the compute
+		 * completes.
+		 */
+		if ((req_compute || !test_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.pending)) &&
+			(locked == 0 && (rcw == 0 ||rmw == 0) &&
+			!test_bit(STRIPE_BIT_DELAY, &sh->state)))
 			locked += handle_write_operations5(sh, rcw, 0);
 	}
 
