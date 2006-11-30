Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031332AbWK3UK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031332AbWK3UK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031322AbWK3UK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:10:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:49717 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1031332AbWK3UKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:10:53 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="21623720:sNHT19487466"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 10/12] md: use async_tx and raid5_run_ops for raid5 expansion operations
Date: Thu, 30 Nov 2006 13:10:50 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201050.21313.26868.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

handle_stripe sets STRIPE_OP_POSTXOR without setting STRIPE_OP_BIODRAIN to
carry out the postxor operation required by the expansion process.  This
distinction is needed since all blocks will need to be written back to disk
even though none of the blocks will have their 'written' pointer set.

The bulk copy operation to the new stripe is handled by async_tx.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |   48 ++++++++++++++++++++++++++++++++++++------------
 1 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3c793dc..8b36611 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2582,18 +2582,32 @@ #endif
 		}
 	}
 
-	if (expanded && test_bit(STRIPE_EXPANDING, &sh->state)) {
-		/* Need to write out all blocks after computing parity */
-		sh->disks = conf->raid_disks;
-		sh->pd_idx = stripe_to_pdidx(sh->sector, conf, conf->raid_disks);
-		compute_parity5(sh, RECONSTRUCT_WRITE);
+	/* Finish postxor operations initiated by the expansion
+	 * process
+	 */
+	if (test_bit(STRIPE_OP_POSTXOR, &sh->ops.complete) &&
+		!test_bit(STRIPE_OP_BIODRAIN, &sh->ops.pending)) {
+
+		clear_bit(STRIPE_EXPANDING, &sh->state);
+
+		clear_bit(STRIPE_OP_POSTXOR, &sh->ops.pending);
+		clear_bit(STRIPE_OP_POSTXOR, &sh->ops.ack);
+		clear_bit(STRIPE_OP_POSTXOR, &sh->ops.complete);
+
 		for (i= conf->raid_disks; i--;) {
-			set_bit(R5_LOCKED, &sh->dev[i].flags);
-			locked++;
 			set_bit(R5_Wantwrite, &sh->dev[i].flags);
+			if (!test_and_set_bit(STRIPE_OP_IO, &sh->ops.pending))
+				sh->ops.count++;
 		}
-		clear_bit(STRIPE_EXPANDING, &sh->state);
-	} else if (expanded) {
+	}
+
+	if (expanded && test_bit(STRIPE_EXPANDING, &sh->state) &&
+		!test_bit(STRIPE_OP_POSTXOR, &sh->ops.pending)) {
+		/* Need to write out all blocks after computing parity */
+		sh->disks = conf->raid_disks;
+		sh->pd_idx = stripe_to_pdidx(sh->sector, conf, conf->raid_disks);
+		locked += handle_write_operations5(sh, 0, 1);
+	} else if (expanded && !test_bit(STRIPE_OP_POSTXOR, &sh->ops.pending)) {
 		clear_bit(STRIPE_EXPAND_READY, &sh->state);
 		atomic_dec(&conf->reshape_stripes);
 		wake_up(&conf->wait_for_overlap);
@@ -2604,6 +2618,7 @@ #endif
 		/* We have read all the blocks in this stripe and now we need to
 		 * copy some of them into a target stripe for expand.
 		 */
+		struct dma_async_tx_descriptor *tx = NULL;
 		clear_bit(STRIPE_EXPAND_SOURCE, &sh->state);
 		for (i=0; i< sh->disks; i++)
 			if (i != sh->pd_idx) {
@@ -2627,9 +2642,12 @@ #endif
 					release_stripe(sh2);
 					continue;
 				}
-				memcpy(page_address(sh2->dev[dd_idx].page),
-				       page_address(sh->dev[i].page),
-				       STRIPE_SIZE);
+
+				/* place all the copies on one channel */
+				tx = async_memcpy(sh2->dev[dd_idx].page,
+					sh->dev[i].page, 0, 0, STRIPE_SIZE,
+					ASYNC_TX_DEP_ACK, tx, NULL, NULL);
+
 				set_bit(R5_Expanded, &sh2->dev[dd_idx].flags);
 				set_bit(R5_UPTODATE, &sh2->dev[dd_idx].flags);
 				for (j=0; j<conf->raid_disks; j++)
@@ -2641,6 +2659,12 @@ #endif
 					set_bit(STRIPE_HANDLE, &sh2->state);
 				}
 				release_stripe(sh2);
+
+				/* done submitting copies, wait for them to complete */
+				if (i + 1 >= sh->disks) {
+					async_tx_ack(tx);
+					dma_wait_for_async_tx(tx);
+				}
 			}
 	}
 
