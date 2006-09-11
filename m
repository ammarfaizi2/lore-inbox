Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWIKXV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWIKXV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWIKXSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:18:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:34868 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S965099AbWIKXSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:40 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="128869318:sNHT401171610"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 06/19] raid5: move the reconstruct write expansion operation to a workqueue
Date: Mon, 11 Sep 2006 16:18:07 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231807.4737.40067.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Enable handle_stripe5 to use the reconstruct write operations capability
for expansion operations.  

However this does not move the copy operation associated with an expand to
the workqueue.  First, it was difficult to find a clean way to pass the
parameters of this operation to the queue.  Second, this section of code is
a good candidate for performing the copies with inline calls to the dma
routines.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |   36 +++++++++++++++++++++++++++---------
 1 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 1a8dfd2..a07b52b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2053,6 +2053,7 @@ #endif
 	 * completed
 	 */
 	if (test_bit(STRIPE_OP_RCW, &sh->state) &&
+		!test_bit(STRIPE_OP_RCW_Expand, &sh->ops.state) &&
 		test_bit(STRIPE_OP_RCW_Done, &sh->ops.state)) {
 		clear_bit(STRIPE_OP_RCW, &sh->state);
 		clear_bit(STRIPE_OP_RCW_Done, &sh->ops.state);
@@ -2226,6 +2227,7 @@ #endif
 				}
 			}
 		}
+
 		if (test_bit(STRIPE_OP_COMPUTE_Done, &sh->ops.state) &&
 			test_bit(STRIPE_OP_COMPUTE_Recover_pd, &sh->ops.state)) {
 			clear_bit(STRIPE_OP_COMPUTE, &sh->state);
@@ -2282,18 +2284,28 @@ #endif
 		}
 	}
 
-	if (expanded && test_bit(STRIPE_EXPANDING, &sh->state)) {
+	/* Finish 'rcw' operations initiated by the expansion
+	 * process
+	 */
+	if (test_bit(STRIPE_OP_RCW, &sh->state) &&
+		test_bit(STRIPE_OP_RCW_Expand, &sh->ops.state) &&
+		test_bit(STRIPE_OP_RCW_Done, &sh->ops.state)) {
+		clear_bit(STRIPE_OP_RCW, &sh->state);
+		clear_bit(STRIPE_OP_RCW_Done, &sh->ops.state);
+		clear_bit(STRIPE_OP_RCW_Expand, &sh->ops.state);
+		clear_bit(STRIPE_EXPANDING, &sh->state);
+		for (i= conf->raid_disks; i--;)
+			set_bit(R5_Wantwrite, &sh->dev[i].flags);
+	}
+
+	if (expanded && test_bit(STRIPE_EXPANDING, &sh->state) &&
+		!test_bit(STRIPE_OP_RCW, &sh->state)) {
 		/* Need to write out all blocks after computing parity */
 		sh->disks = conf->raid_disks;
 		sh->pd_idx = stripe_to_pdidx(sh->sector, conf, conf->raid_disks);
-		compute_parity5(sh, RECONSTRUCT_WRITE);
-		for (i= conf->raid_disks; i--;) {
-			set_bit(R5_LOCKED, &sh->dev[i].flags);
-			locked++;
-			set_bit(R5_Wantwrite, &sh->dev[i].flags);
-		}
-		clear_bit(STRIPE_EXPANDING, &sh->state);
-	} else if (expanded) {
+		set_bit(STRIPE_OP_RCW_Expand, &sh->ops.state);
+		locked += handle_write_operations5(sh, 0);
+	} else if (expanded && !test_bit(STRIPE_OP_RCW, &sh->state)) {
 		clear_bit(STRIPE_EXPAND_READY, &sh->state);
 		atomic_dec(&conf->reshape_stripes);
 		wake_up(&conf->wait_for_overlap);
@@ -2327,9 +2339,15 @@ #endif
 					release_stripe(sh2);
 					continue;
 				}
+				/* to do: perform these operations with a dma engine
+				 * inline (rather than pushing to the workqueue)
+				 */
+				/*#ifdef CONFIG_RAID5_DMA*/
+				/*#else*/
 				memcpy(page_address(sh2->dev[dd_idx].page),
 				       page_address(sh->dev[i].page),
 				       STRIPE_SIZE);
+				/*#endif*/
 				set_bit(R5_Expanded, &sh2->dev[dd_idx].flags);
 				set_bit(R5_UPTODATE, &sh2->dev[dd_idx].flags);
 				for (j=0; j<conf->raid_disks; j++)
