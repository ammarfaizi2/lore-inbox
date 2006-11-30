Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031334AbWK3UKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031334AbWK3UKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031326AbWK3UKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:10:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:49717 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1031327AbWK3UKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:10:47 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="152211483:sNHT18351970"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 09/12] md: satisfy raid5 read requests via raid5_run_ops
Date: Thu, 30 Nov 2006 13:10:45 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201045.21313.73053.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Use raid5_run_ops to carry out the memory copies for a raid5 read request.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |   57 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 1764fbb..3c793dc 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2020,7 +2020,7 @@ static void handle_stripe5(struct stripe
 	int i;
 	int syncing, expanding, expanded;
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
-	int compute=0, req_compute=0, non_overwrite=0;
+	int to_fill=0, compute=0, req_compute=0, non_overwrite=0;
 	int failed_num=0;
 	struct r5dev *dev;
 
@@ -2035,42 +2035,45 @@ static void handle_stripe5(struct stripe
 	syncing = test_bit(STRIPE_SYNCING, &sh->state);
 	expanding = test_bit(STRIPE_EXPAND_SOURCE, &sh->state);
 	expanded = test_bit(STRIPE_EXPAND_READY, &sh->state);
-	/* Now to look around and see what can be done */
 
+	/* clear completed biofills */
+	if (test_and_clear_bit(STRIPE_OP_BIOFILL, &sh->ops.complete)) {
+		clear_bit(STRIPE_OP_BIOFILL, &sh->ops.ack);
+		clear_bit(STRIPE_OP_BIOFILL, &sh->ops.pending);
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
+		if (test_bit(R5_Wantfill, &dev->flags) && !dev->toread)
+			clear_bit(R5_Wantfill, &dev->flags);
+
 		/* maybe we can reply to a read */
+		if (dev->read && !test_bit(R5_Wantfill, &dev->flags) &&
+			!test_bit(STRIPE_OP_BIOFILL, &sh->ops.pending)) {
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
+			if (!test_bit(STRIPE_OP_BIOFILL, &sh->ops.pending))
+				set_bit(R5_Wantfill, &dev->flags);
 		}
 
 		/* now count some things */
 		if (test_bit(R5_LOCKED, &dev->flags)) locked++;
 		if (test_bit(R5_UPTODATE, &dev->flags)) uptodate++;
+		if (test_bit(R5_Wantfill, &dev->flags)) to_fill++;
 		if (test_bit(R5_Wantcompute, &dev->flags)) BUG_ON(++compute > 1);
 
 		if (dev->toread) to_read++;
@@ -2094,9 +2097,13 @@ static void handle_stripe5(struct stripe
 			set_bit(R5_Insync, &dev->flags);
 	}
 	rcu_read_unlock();
+
+	if (to_fill && !test_and_set_bit(STRIPE_OP_BIOFILL, &sh->ops.pending))
+		sh->ops.count++;
+
 	PRINTK("locked=%d uptodate=%d to_read=%d"
-		" to_write=%d failed=%d failed_num=%d\n",
-		locked, uptodate, to_read, to_write, failed, failed_num);
+		" to_write=%d to_fill=%d failed=%d failed_num=%d\n",
+		locked, uptodate, to_read, to_write, to_fill, failed, failed_num);
 	/* check if the array has lost two devices and, if so, some requests might
 	 * need to be failed
 	 */
