Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWIKXXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWIKXXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWIKXXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:23:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:34868 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S965105AbWIKXSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:38 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="128869301:sNHT214074952"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 03/19] raid5: move check parity operations to a workqueue
Date: Mon, 11 Sep 2006 16:17:51 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231751.4737.68006.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Enable handle_stripe5 to pass off check parity operations to
raid5_do_soft_block_ops formerly handled by compute_parity5.

Changelog:
* removed handle_check_operations5.  All logic moved into handle_stripe5 so
that we do not need to go through the initiation logic to end the
operation.
* clear the uptodate bit on the parity block
* hold off check operations if a parity dependent operation is in flight
like a write

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |   60 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e39d248..24ed4d8 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2121,35 +2121,59 @@ #endif
 			locked += handle_write_operations5(sh, rcw);
 	}
 
-	/* maybe we need to check and possibly fix the parity for this stripe
-	 * Any reads will already have been scheduled, so we just see if enough data
-	 * is available
+	/* 1/ Maybe we need to check and possibly fix the parity for this stripe.
+	 *    Any reads will already have been scheduled, so we just see if enough data
+	 *    is available.
+	 * 2/ Hold off parity checks while parity dependent operations are in flight
+	 *    (RCW and RMW are protected by 'locked')
 	 */
-	if (syncing && locked == 0 &&
-	    !test_bit(STRIPE_INSYNC, &sh->state)) {
+	if ((syncing && locked == 0 &&
+	    !test_bit(STRIPE_INSYNC, &sh->state)) ||
+	    	test_bit(STRIPE_OP_CHECK, &sh->state)) {
+
 		set_bit(STRIPE_HANDLE, &sh->state);
+		/* Take one of the following actions:
+		 * 1/ start a check parity operation if (uptodate == disks)
+		 * 2/ finish a check parity operation and act on the result
+		 */
 		if (failed == 0) {
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
+			if (!test_bit(STRIPE_OP_CHECK, &sh->state)) {
+				BUG_ON(uptodate != disks);
+				set_bit(STRIPE_OP_CHECK, &sh->state);
+				set_bit(STRIPE_OP_CHECK_Gen, &sh->ops.state);
+				clear_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags);
+				sh->ops.pending++;
+				uptodate--;
+			} else if (test_and_clear_bit(STRIPE_OP_CHECK_Done, &sh->ops.state)) {
+				clear_bit(STRIPE_OP_CHECK, &sh->state);
+
+				if (test_and_clear_bit(STRIPE_OP_CHECK_IsZero,
+							&sh->ops.state))
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
+						compute_block(sh, sh->pd_idx);
+						uptodate++;
+					}
 				}
 			}
 		}
-		if (!test_bit(STRIPE_INSYNC, &sh->state)) {
+
+		/* Wait for check parity operations to complete
+		 * before write-back
+		 */
+		if (!test_bit(STRIPE_INSYNC, &sh->state) &&
+			!test_bit(STRIPE_OP_CHECK, &sh->state)) {
+
 			/* either failed parity check, or recovery is happening */
 			if (failed==0)
 				failed_num = sh->pd_idx;
+
 			dev = &sh->dev[failed_num];
 			BUG_ON(!test_bit(R5_UPTODATE, &dev->flags));
 			BUG_ON(uptodate != disks);
