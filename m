Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031353AbWK3ULh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031353AbWK3ULh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031349AbWK3ULe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:11:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:9089 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1031342AbWK3ULX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:11:23 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="171251697:sNHT66830477"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 06/12] md: move write operations to raid5_run_ops
Date: Thu, 30 Nov 2006 13:10:30 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201030.21313.36378.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

handle_stripe sets STRIPE_OP_PREXOR, STRIPE_OP_BIODRAIN, STRIPE_OP_POSTXOR
to request a write to the stripe cache.  raid5_run_ops is triggerred to run
and executes the request outside the stripe lock.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |  152 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 131 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index c2312d1..74516ef 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1830,7 +1830,75 @@ static void compute_block_2(struct strip
 	}
 }
 
+static int handle_write_operations5(struct stripe_head *sh, int rcw, int expand)
+{
+	int i, pd_idx = sh->pd_idx, disks = sh->disks;
+	int locked=0;
+
+	if (rcw == 0) {
+		/* skip the drain operation on an expand */
+		if (!expand) {
+			BUG_ON(test_and_set_bit(STRIPE_OP_BIODRAIN,
+				&sh->ops.pending));
+			sh->ops.count++;
+		}
+
+		BUG_ON(test_and_set_bit(STRIPE_OP_POSTXOR, &sh->ops.pending));
+		sh->ops.count++;
+
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+
+			if (dev->towrite) {
+				set_bit(R5_LOCKED, &dev->flags);
+				if (!expand)
+					clear_bit(R5_UPTODATE, &dev->flags);
+				locked++;
+			}
+		}
+	} else {
+		BUG_ON(!(test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags) ||
+			test_bit(R5_Wantcompute, &sh->dev[pd_idx].flags)));
+
+		BUG_ON(test_and_set_bit(STRIPE_OP_PREXOR, &sh->ops.pending) ||
+			test_and_set_bit(STRIPE_OP_BIODRAIN, &sh->ops.pending) ||
+			test_and_set_bit(STRIPE_OP_POSTXOR, &sh->ops.pending));
+
+		sh->ops.count += 3;
+
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (i==pd_idx)
+				continue;
 
+			/* For a read-modify write there may be blocks that are
+			 * locked for reading while others are ready to be written
+			 * so we distinguish these blocks by the R5_Wantprexor bit
+			 */
+			if (dev->towrite &&
+			    (test_bit(R5_UPTODATE, &dev->flags) ||
+			    test_bit(R5_Wantcompute, &dev->flags))) {
+				set_bit(R5_Wantprexor, &dev->flags);
+				set_bit(R5_LOCKED, &dev->flags);
+				clear_bit(R5_UPTODATE, &dev->flags);
+				locked++;
+			}
+		}
+	}
+
+	/* keep the parity disk locked while asynchronous operations
+	 * are in flight
+	 */
+	set_bit(R5_LOCKED, &sh->dev[pd_idx].flags);
+	clear_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+	locked++;
+
+	PRINTK("%s: stripe %llu locked: %d pending: %lx\n",
+		__FUNCTION__, (unsigned long long)sh->sector,
+		locked, sh->ops.pending);
+
+	return locked;
+}
 
 /*
  * Each stripe/dev can have one or more bion attached.
@@ -2199,8 +2267,67 @@ #endif
 		set_bit(STRIPE_HANDLE, &sh->state);
 	}
 
-	/* now to consider writing and what else, if anything should be read */
-	if (to_write) {
+	/* Now we check to see if any write operations have recently
+	 * completed
+	 */
+
+	/* leave prexor set until postxor is done, allows us to distinguish
+	 * a rmw from a rcw during biodrain
+	 */
+	if (test_bit(STRIPE_OP_PREXOR, &sh->ops.complete) &&
+		test_bit(STRIPE_OP_POSTXOR, &sh->ops.complete)) {
+
+		clear_bit(STRIPE_OP_PREXOR, &sh->ops.complete);
+		clear_bit(STRIPE_OP_PREXOR, &sh->ops.ack);
+		clear_bit(STRIPE_OP_PREXOR, &sh->ops.pending);
+
+		for (i=disks; i--;)
+			clear_bit(R5_Wantprexor, &sh->dev[i].flags);
+	}
+
+	/* if only POSTXOR is set then this is an 'expand' postxor */
+	if (test_bit(STRIPE_OP_BIODRAIN, &sh->ops.complete) &&
+		test_bit(STRIPE_OP_POSTXOR, &sh->ops.complete)) {
+
+		clear_bit(STRIPE_OP_BIODRAIN, &sh->ops.complete);
+		clear_bit(STRIPE_OP_BIODRAIN, &sh->ops.ack);
+		clear_bit(STRIPE_OP_BIODRAIN, &sh->ops.pending);
+
+		clear_bit(STRIPE_OP_POSTXOR, &sh->ops.complete);
+		clear_bit(STRIPE_OP_POSTXOR, &sh->ops.ack);
+		clear_bit(STRIPE_OP_POSTXOR, &sh->ops.pending);
+
+		/* All the 'written' buffers and the parity block are ready to be
+		 * written back to disk
+		 */
+		BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags));
+		for (i=disks; i--;) {
+			dev = &sh->dev[i];
+			if (test_bit(R5_LOCKED, &dev->flags) &&
+				(i == sh->pd_idx || dev->written)) {
+				PRINTK("Writing block %d\n", i);
+				set_bit(R5_Wantwrite, &dev->flags);
+				if (!test_and_set_bit(STRIPE_OP_IO, &sh->ops.pending))
+					sh->ops.count++;
+				if (!test_bit(R5_Insync, &dev->flags)
+				    || (i==sh->pd_idx && failed == 0))
+					set_bit(STRIPE_INSYNC, &sh->state);
+			}
+		}
+		if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
+			atomic_dec(&conf->preread_active_stripes);
+			if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD)
+				md_wakeup_thread(conf->mddev->thread);
+		}
+	}
+
+	/* 1/ Now to consider new write requests and what else, if anything should be read
+	 * 2/ Check operations clobber the parity block so do not start new writes while
+	 *    a check is in flight
+	 * 3/ Write operations do not stack
+	 */
+	if (to_write && !test_bit(STRIPE_OP_POSTXOR, &sh->ops.pending) &&
+		!test_bit(STRIPE_OP_CHECK, &sh->ops.pending)) {
 		int rmw=0, rcw=0;
 		for (i=disks ; i--;) {
 			/* would I have to read this buffer for read_modify_write */
@@ -2273,25 +2400,8 @@ #endif
 			}
 		/* now if nothing is locked, and if we have enough data, we can start a write request */
 		if (locked == 0 && (rcw == 0 ||rmw == 0) &&
-		    !test_bit(STRIPE_BIT_DELAY, &sh->state)) {
-			PRINTK("Computing parity...\n");
-			compute_parity5(sh, rcw==0 ? RECONSTRUCT_WRITE : READ_MODIFY_WRITE);
-			/* now every locked buffer is ready to be written */
-			for (i=disks; i--;)
-				if (test_bit(R5_LOCKED, &sh->dev[i].flags)) {
-					PRINTK("Writing block %d\n", i);
-					locked++;
-					set_bit(R5_Wantwrite, &sh->dev[i].flags);
-					if (!test_bit(R5_Insync, &sh->dev[i].flags)
-					    || (i==sh->pd_idx && failed == 0))
-						set_bit(STRIPE_INSYNC, &sh->state);
-				}
-			if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
-				atomic_dec(&conf->preread_active_stripes);
-				if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD)
-					md_wakeup_thread(conf->mddev->thread);
-			}
-		}
+		    !test_bit(STRIPE_BIT_DELAY, &sh->state))
+			locked += handle_write_operations5(sh, rcw, 0);
 	}
 
 	/* maybe we need to check and possibly fix the parity for this stripe
