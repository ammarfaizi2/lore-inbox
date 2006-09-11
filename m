Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWIKXSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWIKXSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWIKXSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:18:07 -0400
Received: from mga03.intel.com ([143.182.124.21]:31035 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S965095AbWIKXSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:02 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="114946931:sNHT79503795"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 05/19] raid5: move read completion copies to a workqueue
Date: Mon, 11 Sep 2006 16:18:02 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231801.4737.12584.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Enable handle_stripe5 to hand off the memory copy operations that satisfy
read requests to raid5_do_soft_blocks_ops, formerly this was handled in
line within handle_stripe5.

It adds a 'read' (past tense) pointer to the r5dev structure
to to track reads that have been offloaded to the workqueue.  When the copy
operation is complete the 'read' pointer is reused as the return_bi for the
bi_end_io() call.

Changelog:
* dev->read only holds reads that have been satisfied, previously it
doubled as a request queue to the operations routine
* added R5_ReadReq to mark the blocks that belong to a given bio fill
operation
* requested reads no longer count towards the 'to_read' count, 'to_fill'
tracks the number of requested reads

Signed-off-by: Dan Williams <dan.j.willams@intel.com>
---

 drivers/md/raid5.c |   67 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0c39203..1a8dfd2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -240,11 +240,11 @@ static void init_stripe(struct stripe_he
 	for (i = sh->disks; i--; ) {
 		struct r5dev *dev = &sh->dev[i];
 
-		if (dev->toread || dev->towrite || dev->written ||
+		if (dev->toread || dev->read || dev->towrite || dev->written ||
 		    test_bit(R5_LOCKED, &dev->flags)) {
-			printk("sector=%llx i=%d %p %p %p %d\n",
+			printk("sector=%llx i=%d %p %p %p %p %d\n",
 			       (unsigned long long)sh->sector, i, dev->toread,
-			       dev->towrite, dev->written,
+			       dev->read, dev->towrite, dev->written,
 			       test_bit(R5_LOCKED, &dev->flags));
 			BUG();
 		}
@@ -1749,7 +1749,7 @@ static void handle_stripe5(struct stripe
 	struct bio *bi;
 	int i;
 	int syncing, expanding, expanded;
-	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
+	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0, to_fill=0;
 	int compute=0, non_overwrite=0, write_complete=0;
 	int failed_num=0;
 	struct r5dev *dev;
@@ -1765,44 +1765,47 @@ static void handle_stripe5(struct stripe
 	syncing = test_bit(STRIPE_SYNCING, &sh->state);
 	expanding = test_bit(STRIPE_EXPAND_SOURCE, &sh->state);
 	expanded = test_bit(STRIPE_EXPAND_READY, &sh->state);
-	/* Now to look around and see what can be done */
 
+	if (test_bit(STRIPE_OP_BIOFILL, &sh->state) &&
+		test_bit(STRIPE_OP_BIOFILL_Done, &sh->ops.state)) {
+		clear_bit(STRIPE_OP_BIOFILL, &sh->state);
+		clear_bit(STRIPE_OP_BIOFILL_Done, &sh->ops.state);
+	}
+
+	/* Now to look around and see what can be done */
 	rcu_read_lock();
 	for (i=disks; i--; ) {
 		mdk_rdev_t *rdev;
 		dev = &sh->dev[i];
 		clear_bit(R5_Insync, &dev->flags);
 
-		PRINTK("check %d: state 0x%lx read %p write %p written %p\n",
-			i, dev->flags, dev->toread, dev->towrite, dev->written);
+		PRINTK("check %d: state 0x%lx toread %p read %p write %p written %p\n",
+		i, dev->flags, dev->toread, dev->read, dev->towrite, dev->written);
+
+		/* maybe we can acknowledge completion of a biofill operation */
+		if (test_bit(R5_ReadReq, &dev->flags) && !dev->toread)
+			clear_bit(R5_ReadReq, &dev->flags);
+
 		/* maybe we can reply to a read */
+		if (dev->read && !test_bit(R5_ReadReq, &dev->flags) &&
+			!test_bit(STRIPE_OP_BIOFILL, &sh->state)) {
+			return_bi = dev->read;
+			dev->read = NULL;
+		}
+
+		/* maybe we can start a biofill operation */
 		if (test_bit(R5_UPTODATE, &dev->flags) && dev->toread) {
-			struct bio *rbi, *rbi2;
-			PRINTK("Return read for disc %d\n", i);
-			spin_lock_irq(&conf->device_lock);
-			rbi = dev->toread;
-			dev->toread = NULL;
-			if (test_and_clear_bit(R5_Overlap, &dev->flags))
-				wake_up(&conf->wait_for_overlap);
-			spin_unlock_irq(&conf->device_lock);
-			while (rbi && rbi->bi_sector < dev->sector + STRIPE_SECTORS) {
-				copy_data(0, rbi, dev->page, dev->sector);
-				rbi2 = r5_next_bio(rbi, dev->sector);
-				spin_lock_irq(&conf->device_lock);
-				if (--rbi->bi_phys_segments == 0) {
-					rbi->bi_next = return_bi;
-					return_bi = rbi;
-				}
-				spin_unlock_irq(&conf->device_lock);
-				rbi = rbi2;
-			}
+			to_read--;
+			if (!test_bit(STRIPE_OP_BIOFILL, &sh->state))
+				set_bit(R5_ReadReq, &dev->flags);
 		}
 
 		/* now count some things */
 		if (test_bit(R5_LOCKED, &dev->flags)) locked++;
 		if (test_bit(R5_UPTODATE, &dev->flags)) uptodate++;
+		if (test_bit(R5_ReadReq, &dev->flags)) to_fill++;
 		if (test_bit(R5_ComputeReq, &dev->flags)) BUG_ON(++compute > 1);
-		
+
 		if (dev->toread) to_read++;
 		if (dev->towrite) {
 			to_write++;
@@ -1824,9 +1827,15 @@ static void handle_stripe5(struct stripe
 			set_bit(R5_Insync, &dev->flags);
 	}
 	rcu_read_unlock();
+
+	if (to_fill && !test_bit(STRIPE_OP_BIOFILL, &sh->state)) {
+		set_bit(STRIPE_OP_BIOFILL, &sh->state);
+		sh->ops.pending++;
+	}
+
 	PRINTK("locked=%d uptodate=%d to_read=%d"
-		" to_write=%d failed=%d failed_num=%d\n",
-		locked, uptodate, to_read, to_write, failed, failed_num);
+		" to_write=%d to_fill=%d failed=%d failed_num=%d\n",
+		locked, uptodate, to_read, to_write, to_fill, failed, failed_num);
 	/* check if the array has lost two devices and, if so, some requests might
 	 * need to be failed
 	 */
