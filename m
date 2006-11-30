Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031330AbWK3UNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031330AbWK3UNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031333AbWK3UKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:10:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:49717 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1031313AbWK3UKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:10:42 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="152211465:sNHT19996585"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 08/12] md: move raid5 parity checks to raid5_run_ops
Date: Thu, 30 Nov 2006 13:10:40 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201040.21313.11515.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

handle_stripe sets STRIPE_OP_CHECK to request a check operation in
raid5_run_ops.  If raid5_run_ops is able to perform the check with a
dma engine the parity will be preserved and not re-read from disk.

Check operations re-use the compute block facility to repair the parity.
However since repairing the parity implies a write-back to disk the
STRIPE_OP_MOD_REPAIR_PD flag is added to distinguish it from other compute
block operations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |   81 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8510183..1764fbb 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2465,32 +2465,75 @@ #endif
 			locked += handle_write_operations5(sh, rcw, 0);
 	}
 
-	/* maybe we need to check and possibly fix the parity for this stripe
-	 * Any reads will already have been scheduled, so we just see if enough data
-	 * is available
+	/* 1/ Maybe we need to check and possibly fix the parity for this stripe.
+	 *    Any reads will already have been scheduled, so we just see if enough data
+	 *    is available.
+	 * 2/ Hold off parity checks while parity dependent operations are in flight
+	 *    (conflicting writes are protected by the 'locked' variable)
 	 */
-	if (syncing && locked == 0 &&
-	    !test_bit(STRIPE_INSYNC, &sh->state)) {
+	if ((syncing && locked == 0 && !test_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.pending) &&
+		!test_bit(STRIPE_INSYNC, &sh->state)) ||
+	    	test_bit(STRIPE_OP_CHECK, &sh->ops.pending) ||
+	    	test_bit(STRIPE_OP_MOD_REPAIR_PD, &sh->ops.pending)) {
+
 		set_bit(STRIPE_HANDLE, &sh->state);
-		if (failed == 0) {
-			BUG_ON(uptodate != disks);
-			compute_parity5(sh, CHECK_PARITY);
-			uptodate--;
-			if (page_is_zero(sh->dev[sh->pd_idx].page)) {
-				/* parity is correct (on disc, not in buffer any more) */
-				set_bit(STRIPE_INSYNC, &sh->state);
-			} else {
-				conf->mddev->resync_mismatches += STRIPE_SECTORS;
-				if (test_bit(MD_RECOVERY_CHECK, &conf->mddev->recovery))
-					/* don't try to repair!! */
+		/* Take one of the following actions:
+		 * 1/ start a check parity operation if (uptodate == disks)
+		 * 2/ finish a check parity operation and act on the result
+		 * 3/ skip to the writeback section if we previously
+		 *    initiated a recovery operation
+		 */
+		if (failed == 0 && !test_bit(STRIPE_OP_MOD_REPAIR_PD, &sh->ops.pending)) {
+			if (!test_and_set_bit(STRIPE_OP_CHECK, &sh->ops.pending)) {
+				BUG_ON(uptodate != disks);
+				clear_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags);
+				sh->ops.count++;
+				uptodate--;
+			} else if (test_and_clear_bit(STRIPE_OP_CHECK, &sh->ops.complete)) {
+				clear_bit(STRIPE_OP_CHECK, &sh->ops.ack);
+				clear_bit(STRIPE_OP_CHECK, &sh->ops.pending);
+
+				if (sh->ops.zero_sum_result == 0)
+					/* parity is correct (on disc, not in buffer any more) */
 					set_bit(STRIPE_INSYNC, &sh->state);
 				else {
-					compute_block(sh, sh->pd_idx);
-					uptodate++;
+					conf->mddev->resync_mismatches += STRIPE_SECTORS;
+					if (test_bit(MD_RECOVERY_CHECK, &conf->mddev->recovery))
+						/* don't try to repair!! */
+						set_bit(STRIPE_INSYNC, &sh->state);
+					else {
+						BUG_ON(test_and_set_bit(
+							STRIPE_OP_COMPUTE_BLK,
+							&sh->ops.pending));
+						set_bit(STRIPE_OP_MOD_REPAIR_PD,
+							&sh->ops.pending);
+						BUG_ON(test_and_set_bit(R5_Wantcompute,
+							&sh->dev[sh->pd_idx].flags));
+						sh->ops.target = sh->pd_idx;
+						sh->ops.count++;
+						uptodate++;
+					}
 				}
 			}
 		}
-		if (!test_bit(STRIPE_INSYNC, &sh->state)) {
+
+		/* check if we can clear a parity disk reconstruct */
+		if (test_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.complete) &&
+			test_bit(STRIPE_OP_MOD_REPAIR_PD, &sh->ops.pending)) {
+
+			clear_bit(STRIPE_OP_MOD_REPAIR_PD, &sh->ops.pending);
+			clear_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.complete);
+			clear_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.ack);
+			clear_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.pending);
+		}
+
+		/* Wait for check parity and compute block operations to complete
+		 * before write-back
+		 */
+		if (!test_bit(STRIPE_INSYNC, &sh->state) &&
+			!test_bit(STRIPE_OP_CHECK, &sh->ops.pending) &&
+			!test_bit(STRIPE_OP_COMPUTE_BLK, &sh->ops.pending)) {
+
 			/* either failed parity check, or recovery is happening */
 			if (failed==0)
 				failed_num = sh->pd_idx;
