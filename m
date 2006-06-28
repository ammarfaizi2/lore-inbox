Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWF1S0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWF1S0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWF1S0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:26:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:24947 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750762AbWF1S0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:26:09 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="58052023:sNHT2586025925"
Subject: [PATCH 005 of 006] raid5: Move expansion operations to a work queue
From: Dan Williams <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:24:12 -0700
Message-Id: <1151519052.2232.67.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies handle_write_operations5() to handle the parity
calculation request made by the reshape code.  However this patch does
not move the copy operation associated with an expand to the work queue.
First, it was difficult to find a clean way to pass the parameters of
this operation to the queue.  Second, this section of code is a good
candidate for performing the copies with inline calls to the dma
routines.

This patch also cleans up the *_End flags which as of this version
of the patch set are not needed.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 drivers/md/raid5.c         |   51 ++++++++++++++++++++++++++++++++-------------
 include/linux/raid/raid5.h |   36 +++++++++++++++----------------
 2 files changed, 54 insertions(+), 33 deletions(-)

===================================================================
Index: linux-2.6-raid/drivers/md/raid5.c
===================================================================
--- linux-2.6-raid.orig/drivers/md/raid5.c	2006-06-28 10:35:40.000000000 -0700
+++ linux-2.6-raid/drivers/md/raid5.c	2006-06-28 10:35:50.000000000 -0700
@@ -1250,16 +1250,25 @@
 	 */
 	if (locked == 0) {
 		if (rcw == 0) {
-			/* enter stage 1 of reconstruct write operation */
-			set_bit(STRIPE_OP_RCW, &sh->state);
-			set_bit(STRIPE_OP_RCW_Drain, &sh->ops.state);
-			for (i=disks ; i-- ;) {
-				struct r5dev *dev = &sh->dev[i];
-
-				if (i!=pd_idx && dev->towrite) {
-					set_bit(R5_LOCKED, &dev->flags);
+			/* skip the drain operation on an expand */
+			if (test_bit(STRIPE_OP_RCW_Expand, &sh->ops.state)) {
+				set_bit(STRIPE_OP_RCW, &sh->state);
+				set_bit(STRIPE_OP_RCW_Parity, &sh->ops.state);
+				for (i=disks ; i-- ;) {
+					set_bit(R5_LOCKED, &sh->dev[i].flags);
 					locked++;
 				}
+			} else { /* enter stage 1 of reconstruct write operation */
+				set_bit(STRIPE_OP_RCW, &sh->state);
+				set_bit(STRIPE_OP_RCW_Drain, &sh->ops.state);
+				for (i=disks ; i-- ;) {
+					struct r5dev *dev = &sh->dev[i];
+
+					if (i!=pd_idx && dev->towrite) {
+						set_bit(R5_LOCKED, &dev->flags);
+						locked++;
+					}
+				}
 			}
 		} else {
 			/* enter stage 1 of read modify write operation */
@@ -2213,16 +2222,24 @@
 	}
 
 	if (expanded && test_bit(STRIPE_EXPANDING, &sh->state)) {
+		int work_queued, start_n=1;
 		/* Need to write out all blocks after computing parity */
 		sh->disks = conf->raid_disks;
 		sh->pd_idx = stripe_to_pdidx(sh->sector, conf, conf->raid_disks);
-		compute_parity5(sh, RECONSTRUCT_WRITE);
-		for (i= conf->raid_disks; i--;) {
-			set_bit(R5_LOCKED, &sh->dev[i].flags);
-			locked++;
-			set_bit(R5_Wantwrite, &sh->dev[i].flags);
+		if (!(test_bit(STRIPE_OP_RCW, &sh->state) ||
+			test_bit(STRIPE_OP_RCW_Expand, &sh->ops.state))) {
+			start_n = 0;
+			set_bit(STRIPE_OP_RCW_Expand, &sh->ops.state);
+		}
+		work_queued = handle_write_operations5(sh, 0, start_n);
+		if (work_queued == 0) {
+			for (i= conf->raid_disks; i--;)
+				set_bit(R5_Wantwrite, &sh->dev[i].flags);
+			clear_bit(STRIPE_EXPANDING, &sh->state);
+			clear_bit(STRIPE_OP_RCW_Expand, &sh->ops.state);
+		} else if (work_queued > 0) {
+			locked += work_queued;
 		}
-		clear_bit(STRIPE_EXPANDING, &sh->state);
 	} else if (expanded) {
 		clear_bit(STRIPE_EXPAND_READY, &sh->state);
 		atomic_dec(&conf->reshape_stripes);
@@ -2257,9 +2274,15 @@
 					release_stripe(sh2);
 					continue;
 				}
+				/* to do: perform these operations with a dma engine
+				 * inline (rather than pushing to the workqueue)
+				 */
+				/*#ifdef CONFIG_DMA_ENGINE*/
+				/*#else*/
 				memcpy(page_address(sh2->dev[dd_idx].page),
 				       page_address(sh->dev[i].page),
 				       STRIPE_SIZE);
+				/*#endif*/
 				set_bit(R5_Expanded, &sh2->dev[dd_idx].flags);
 				set_bit(R5_UPTODATE, &sh2->dev[dd_idx].flags);
 				for (j=0; j<conf->raid_disks; j++)
Index: linux-2.6-raid/include/linux/raid/raid5.h
===================================================================
--- linux-2.6-raid.orig/include/linux/raid/raid5.h	2006-06-28 10:35:40.000000000 -0700
+++ linux-2.6-raid/include/linux/raid/raid5.h	2006-06-28 10:35:50.000000000 -0700
@@ -213,34 +213,32 @@
 
 /*
  * These flags are communication markers between the handle_stripe[5|6]
- * routine and the block operations work queue
- * - The *_End definitions are a signal from handle_stripe to the work queue to
- *   to ensure the completion of the operation so the results can be committed
- *   to disk
+ * routines and the block operations work queue
  * - The *_Done definitions signal completion from work queue to handle_stripe
  * - STRIPE_OP_CHECK_IsZero signals parity correctness to handle_stripe
+ * - STRIPE_OP_COMPUTE_Recover signals that a recovery took place due to a
+ *   non-zero parity check result
+ * - STRIPE_OP_RCW_Expand flags a special case of a reconstruct write where
+ *   no data is expected to be copied.
  * - All other definitions are service requests for the work queue
  */
 #define	STRIPE_OP_RCW_Drain		0
 #define	STRIPE_OP_RCW_Parity		1
-#define	STRIPE_OP_RCW_End		2
-#define	STRIPE_OP_RCW_Done		3
+#define	STRIPE_OP_RCW_Done		2
+#define	STRIPE_OP_RCW_Expand		3
 #define	STRIPE_OP_RMW_ParityPre		4
 #define	STRIPE_OP_RMW_Drain		5
 #define	STRIPE_OP_RMW_ParityPost	6
-#define	STRIPE_OP_RMW_End		7
-#define	STRIPE_OP_RMW_Done		8
-#define	STRIPE_OP_CHECK_Gen   		9
-#define	STRIPE_OP_CHECK_Verify		10
-#define	STRIPE_OP_CHECK_End		11
-#define	STRIPE_OP_CHECK_Done		12
-#define	STRIPE_OP_CHECK_IsZero		13
-#define	STRIPE_OP_COMPUTE_Prep		14
-#define	STRIPE_OP_COMPUTE_Parity	15
-#define	STRIPE_OP_COMPUTE_End		16
-#define	STRIPE_OP_COMPUTE_Done		17
-#define	STRIPE_OP_COMPUTE_Recover	18
-#define	STRIPE_OP_BIOFILL_Done		19
+#define	STRIPE_OP_RMW_Done		7
+#define	STRIPE_OP_CHECK_Gen   		8
+#define	STRIPE_OP_CHECK_Verify		9
+#define	STRIPE_OP_CHECK_Done		10
+#define	STRIPE_OP_CHECK_IsZero		11
+#define	STRIPE_OP_COMPUTE_Prep		12
+#define	STRIPE_OP_COMPUTE_Parity	13
+#define	STRIPE_OP_COMPUTE_Done		14
+#define	STRIPE_OP_COMPUTE_Recover	15
+#define	STRIPE_OP_BIOFILL_Done		16
 
 /*
  * Bit mask for status bits not to be cleared by the work queue thread
