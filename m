Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWF1SYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWF1SYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWF1SYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:24:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:7587 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750825AbWF1SYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:24:01 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="58051936:sNHT53313232"
Subject: [PATCH 002 of 006] raid5: Move check parity operations to a work
	queue
From: Dan Williams <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:23:59 -0700
Message-Id: <1151519039.2232.64.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 'check parity' capabilities to the work queue and fixes
'queue_raid_work'.

Also, raid5_do_soft_block_ops now accesses the stripe state under the
lock to ensure that it is never out of sync with handle_stripe5.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 drivers/md/raid5.c         |  123 ++++++++++++++++++++++++++++++++++-----------
 include/linux/raid/raid5.h |   25 ++++++---
 2 files changed, 113 insertions(+), 35 deletions(-)

===================================================================
Index: linux-2.6-raid/drivers/md/raid5.c
===================================================================
--- linux-2.6-raid.orig/drivers/md/raid5.c	2006-06-28 09:52:07.000000000 -0700
+++ linux-2.6-raid/drivers/md/raid5.c	2006-06-28 10:35:23.000000000 -0700
@@ -1289,7 +1289,7 @@
 	if (locked > 0) {
 		set_bit(R5_LOCKED, &sh->dev[pd_idx].flags);
 		clear_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
-		sh->ops.queue_count++;
+		sh->ops.pending++;
 	} else if (locked == 0)
 		set_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
 
@@ -1300,6 +1300,37 @@
 	return locked;
 }
 
+static int handle_check_operations5(struct stripe_head *sh, int start_n)
+{
+	int complete=0, work_queued = -EBUSY;
+
+	if (test_bit(STRIPE_OP_CHECK, &sh->state) &&
+			test_bit(STRIPE_OP_CHECK_Done, &sh->ops.state)) {
+				clear_bit(STRIPE_OP_CHECK, &sh->state);
+				clear_bit(STRIPE_OP_CHECK_Done, &sh->ops.state);
+				complete = 1;
+	}
+
+	if (start_n == 0) {
+		/* enter stage 1 of parity check operation */
+		set_bit(STRIPE_OP_CHECK, &sh->state);
+		set_bit(STRIPE_OP_CHECK_Gen, &sh->ops.state);
+		work_queued = 1;
+	} else if (complete)
+		work_queued = 0;
+
+	if (work_queued > 0) {
+		clear_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags);
+		sh->ops.pending++;
+	}
+
+	PRINTK("%s: stripe %llu start: %d complete: %d op_state: %lx\n",
+		__FUNCTION__, (unsigned long long)sh->sector,
+		start_n == 0, complete, sh->ops.state);
+
+	return work_queued;
+}
+
 
 /*
  * Each stripe/dev can have one or more bion attached.
@@ -1406,11 +1437,11 @@
 /* must be called under the stripe lock */
 static void queue_raid_work(struct stripe_head *sh)
 {
-	if (--sh->ops.queue_count == 0) {
+	if (!test_bit(STRIPE_OP_QUEUED, &sh->state) && sh->ops.pending) {
+		set_bit(STRIPE_OP_QUEUED, &sh->state);
 		atomic_inc(&sh->count);
 		queue_work(sh->raid_conf->block_ops_queue, &sh->ops.work);
-	} else if (sh->ops.queue_count < 0)
-		sh->ops.queue_count = 0;
+	}
 }
 
 /*
@@ -1423,16 +1454,17 @@
 	int i, pd_idx = sh->pd_idx, disks = sh->disks, count = 1;
 	void *ptr[MAX_XOR_BLOCKS];
 	struct bio *chosen;
-	int overlap=0, new_work=0, written=0;
-	unsigned long state, ops_state;
+	int overlap=0, work=0, written=0;
+	unsigned long state, ops_state, ops_state_orig;
 
 	/* take a snapshot of what needs to be done at this point in time */
 	spin_lock(&sh->lock);
 	state = sh->state;
-	ops_state = sh->ops.state;
+	ops_state_orig = ops_state = sh->ops.state;
 	spin_unlock(&sh->lock);
 
 	if (test_bit(STRIPE_OP_RMW, &state)) {
+		BUG_ON(test_bit(STRIPE_OP_RCW, &state));
 		PRINTK("%s: stripe %llu STRIPE_OP_RMW op_state: %lx\n",
 			__FUNCTION__, (unsigned long long)sh->sector,
 			ops_state);
@@ -1483,14 +1515,14 @@
 			if (count != 1)
 				xor_block(count, STRIPE_SIZE, ptr);
 
-			/* signal completion and acknowledge the last state seen
-			 * by sh->ops.state
-			 */
+			work++;
 			set_bit(STRIPE_OP_RMW_Done, &ops_state);
-			set_bit(STRIPE_OP_RMW_ParityPre, &ops_state);
 		}
 
-	} else if (test_bit(STRIPE_OP_RCW, &state)) {
+	}
+
+	if (test_bit(STRIPE_OP_RCW, &state)) {
+		BUG_ON(test_bit(STRIPE_OP_RMW, &state));
 		PRINTK("%s: stripe %llu STRIPE_OP_RCW op_state: %lx\n",
 			__FUNCTION__, (unsigned long long)sh->sector,
 			ops_state);
@@ -1527,20 +1559,47 @@
 			if (count != 1)
 				xor_block(count, STRIPE_SIZE, ptr);
 
-			/* signal completion and acknowledge the last state seen
-			 * by sh->ops.state
-			 */
+			work++;
 			set_bit(STRIPE_OP_RCW_Done, &ops_state);
-			set_bit(STRIPE_OP_RCW_Drain, &ops_state);
 
 		}
 	}
 
+	if (test_bit(STRIPE_OP_CHECK, &state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_CHECK op_state: %lx\n",
+		__FUNCTION__, (unsigned long long)sh->sector,
+		ops_state);
+
+		ptr[0] = page_address(sh->dev[pd_idx].page);
+
+		if (test_and_clear_bit(STRIPE_OP_CHECK_Gen, &ops_state)) {
+			for (i=disks; i--;)
+				if (i != pd_idx) {
+					ptr[count++] = page_address(sh->dev[i].page);
+					check_xor();
+				}
+			if (count != 1)
+				xor_block(count, STRIPE_SIZE, ptr);
+
+			set_bit(STRIPE_OP_CHECK_Verify, &ops_state);
+		}
+		if (test_and_clear_bit(STRIPE_OP_CHECK_Verify, &ops_state)) {
+			if (page_is_zero(sh->dev[pd_idx].page))
+				set_bit(STRIPE_OP_CHECK_IsZero, &ops_state);
+
+			work++;
+			set_bit(STRIPE_OP_CHECK_Done, &ops_state);
+		}
+	}
+
 	spin_lock(&sh->lock);
-	/* Update the state of operations, by XORing we clear the stage 1 requests
-	 * while preserving new requests.
+	/* Update the state of operations:
+	 * -clear incoming requests
+	 * -preserve output status (i.e. done status / check result)
+	 * -preserve requests added since 'ops_state_orig' was set
 	 */
-	sh->ops.state ^= ops_state;
+	sh->ops.state ^= (ops_state_orig & ~STRIPE_OP_COMPLETION_MASK);
+	sh->ops.state |= ops_state;
 
 	if (written)
 		for (i=disks ; i-- ;) {
@@ -1556,7 +1615,8 @@
 				wake_up(&sh->raid_conf->wait_for_overlap);
 		}
 
-	sh->ops.queue_count += new_work;
+	sh->ops.pending -= work;
+	clear_bit(STRIPE_OP_QUEUED, &sh->state);
 	set_bit(STRIPE_HANDLE, &sh->state);
 	queue_raid_work(sh);
 	spin_unlock(&sh->lock);
@@ -1941,17 +2001,24 @@
 	 * Any reads will already have been scheduled, so we just see if enough data
 	 * is available
 	 */
-	if (syncing && locked == 0 &&
-	    !test_bit(STRIPE_INSYNC, &sh->state)) {
+	if ((syncing && locked == 0 &&
+	    !test_bit(STRIPE_INSYNC, &sh->state)) ||
+	    	test_bit(STRIPE_OP_CHECK, &sh->state)) {
+		int work_queued = 0, result = 0;
+
 		set_bit(STRIPE_HANDLE, &sh->state);
 		if (failed == 0) {
-			BUG_ON(uptodate != disks);
-			compute_parity5(sh, CHECK_PARITY);
-			uptodate--;
-			if (page_is_zero(sh->dev[sh->pd_idx].page)) {
+			BUG_ON(!test_bit(STRIPE_OP_CHECK, &sh->state) &&
+				(uptodate != disks));
+			work_queued = handle_check_operations5(sh,
+							uptodate == disks);
+			result = test_and_clear_bit(STRIPE_OP_CHECK_IsZero, &sh->ops.state);
+			if (work_queued > 0) {
+				uptodate--;
+			} else if (result && work_queued == 0) {
 				/* parity is correct (on disc, not in buffer any more) */
 				set_bit(STRIPE_INSYNC, &sh->state);
-			} else {
+			} else if (!result && work_queued == 0) {
 				conf->mddev->resync_mismatches += STRIPE_SECTORS;
 				if (test_bit(MD_RECOVERY_CHECK, &conf->mddev->recovery))
 					/* don't try to repair!! */
@@ -1962,7 +2029,7 @@
 				}
 			}
 		}
-		if (!test_bit(STRIPE_INSYNC, &sh->state)) {
+		if (!test_bit(STRIPE_INSYNC, &sh->state) && work_queued == 0) {
 			/* either failed parity check, or recovery is happening */
 			if (failed==0)
 				failed_num = sh->pd_idx;
Index: linux-2.6-raid/include/linux/raid/raid5.h
===================================================================
--- linux-2.6-raid.orig/include/linux/raid/raid5.h	2006-06-28 10:34:54.000000000 -0700
+++ linux-2.6-raid/include/linux/raid/raid5.h	2006-06-28 10:35:23.000000000 -0700
@@ -147,7 +147,7 @@
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	int			disks;			/* disks in stripe */
 	struct stripe_operations {
-		int			queue_count;	/* if == 0 places stripe in the workqueue */
+		int			pending;	/* number of operations requested */
 		unsigned long		state;		/* state of block operations */
 		struct work_struct	work;		/* work queue descriptor */
 		#ifdef CONFIG_DMA_ENGINE
@@ -208,14 +208,16 @@
 #define	STRIPE_OP_COMPUTE	16
 #define	STRIPE_OP_COMPUTE2	17 /* RAID-6 only */
 #define	STRIPE_OP_BIOFILL	18
+#define	STRIPE_OP_QUEUED	19
 
 /*
  * These flags are communication markers between the handle_stripe[5|6]
  * routine and the block operations work queue
- * - The _End definitions are a signal from handle_stripe to the work queue to
+ * - The *_End definitions are a signal from handle_stripe to the work queue to
  *   to ensure the completion of the operation so the results can be committed
  *   to disk
- * - The _Done definitions signal completion from work queue to handle_stripe
+ * - The *_Done definitions signal completion from work queue to handle_stripe
+ * - STRIPE_OP_CHECK_IsZero signals parity correctness to handle_stripe
  * - All other definitions are service requests for the work queue
  */
 #define	STRIPE_OP_RCW_Drain		0
@@ -231,12 +233,21 @@
 #define	STRIPE_OP_CHECK_Verify		10
 #define	STRIPE_OP_CHECK_End		11
 #define	STRIPE_OP_CHECK_Done		12
-#define	STRIPE_OP_COMPUTE_Prep		13
-#define	STRIPE_OP_COMPUTE_Parity	14
-#define	STRIPE_OP_COMPUTE_End		15
-#define	STRIPE_OP_COMPUTE_Done		16
+#define	STRIPE_OP_CHECK_IsZero		13
+#define	STRIPE_OP_COMPUTE_Prep		14
+#define	STRIPE_OP_COMPUTE_Parity	15
+#define	STRIPE_OP_COMPUTE_End		16
+#define	STRIPE_OP_COMPUTE_Done		17
 
 /*
+ * Bit mask for status bits set by the work queue thread
+ */
+#define	STRIPE_OP_COMPLETION_MASK 	(1 << STRIPE_OP_RCW_Done |\
+						1 << STRIPE_OP_RMW_Done |\
+						1 << STRIPE_OP_CHECK_Done |\
+						1 << STRIPE_OP_CHECK_IsZero |\
+						1 << STRIPE_OP_COMPUTE_Done)
+/*
  * Plugging:
  *
  * To improve write throughput, we need to delay the handling of some
