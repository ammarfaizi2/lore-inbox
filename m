Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933075AbWF2WvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933075AbWF2WvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933077AbWF2WvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:51:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:56679 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S933075AbWF2WvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:51:01 -0400
X-IronPort-AV: i="4.06,193,1149490800"; 
   d="scan'208"; a="91346370:sNHT22971319"
Subject: Re: [PATCH 004 of 006] raid5: Move read completion copies to a
	work queue
From: Dan Williams <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <1151519047.2232.66.camel@dwillia2-linux.ch.intel.com>
References: <1151519047.2232.66.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 15:50:59 -0700
Message-Id: <1151621459.5038.36.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor refresh to make 'biofill' go through a test_and_clear_bit check
before performing the copy.  Which is important for the hardware offload
implementation where operations might need to be retried until DMA
resources are available.

---------

This patch moves the data copying portion of satisfying read requests into
the workqueue. It adds a 'read' (past tense) pointer to the r5dev structure
to to track reads that have been offloaded to the workqueue.  When the copy
operation is complete the 'read' pointer is reused as the return_bi for the
bi_end_io() call.

Signed-off-by: Dan Williams <dan.j.willams@intel.com>

 drivers/md/raid5.c         |   98 ++++++++++++++++++++++++++++++++-------------
 include/linux/raid/raid5.h |    7 ++-
 2 files changed, 76 insertions(+), 29 deletions(-)

===================================================================
Index: linux-2.6-raid/drivers/md/raid5.c
===================================================================
--- linux-2.6-raid.orig/drivers/md/raid5.c	2006-06-28 11:06:06.000000000 -0700
+++ linux-2.6-raid/drivers/md/raid5.c	2006-06-29 11:43:35.000000000 -0700
@@ -213,11 +213,11 @@
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
@@ -1490,6 +1490,38 @@
 	ops_state_orig = ops_state = sh->ops.state;
 	spin_unlock(&sh->lock);
 
+	if (test_bit(STRIPE_OP_BIOFILL, &state)) {
+		PRINTK("%s: stripe %llu STRIPE_OP_BIOFILL op_state: %lx\n",
+			__FUNCTION__, (unsigned long long)sh->sector,
+			ops_state);
+
+		if (test_and_clear_bit(STRIPE_OP_BIOFILL_Copy, &ops_state)) {
+			raid5_conf_t *conf = sh->raid_conf;
+			struct bio *return_bi=NULL;
+
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+				struct bio *rbi, *rbi2;
+				rbi = dev->read;
+				while (rbi && rbi->bi_sector < dev->sector + STRIPE_SECTORS) {
+					copy_data(0, rbi, dev->page, dev->sector);
+					rbi2 = r5_next_bio(rbi, dev->sector);
+					spin_lock_irq(&conf->device_lock);
+					if (--rbi->bi_phys_segments == 0) {
+						rbi->bi_next = return_bi;
+						return_bi = rbi;
+					}
+					spin_unlock_irq(&conf->device_lock);
+					rbi = rbi2;
+					dev->read = return_bi;
+				}
+			}
+
+			work++;
+			set_bit(STRIPE_OP_BIOFILL_Done, &ops_state);
+		}
+	}
+
 	if (test_bit(STRIPE_OP_COMPUTE, &state)) {
 		for (i=disks ; i-- ;) {
 			struct r5dev *dev = &sh->dev[i];
@@ -1725,6 +1757,7 @@
 	int i;
 	int syncing, expanding, expanded;
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
+	int fill_complete=0, to_fill=0;
 	int non_overwrite = 0;
 	int failed_num=0;
 	struct r5dev *dev;
@@ -1740,45 +1773,49 @@
 	syncing = test_bit(STRIPE_SYNCING, &sh->state);
 	expanding = test_bit(STRIPE_EXPAND_SOURCE, &sh->state);
 	expanded = test_bit(STRIPE_EXPAND_READY, &sh->state);
-	/* Now to look around and see what can be done */
+	if (test_bit(STRIPE_OP_BIOFILL, &sh->state) &&
+		test_bit(STRIPE_OP_BIOFILL_Done, &sh->ops.state)) {
+			clear_bit(STRIPE_OP_BIOFILL, &sh->state);
+			clear_bit(STRIPE_OP_BIOFILL_Done, &sh->ops.state);
+			fill_complete++;
+	}
 
+	/* Now to look around and see what can be done */
 	rcu_read_lock();
 	for (i=disks; i--; ) {
 		mdk_rdev_t *rdev;
 		dev = &sh->dev[i];
 		clear_bit(R5_Insync, &dev->flags);
 
-		PRINTK("check %d: state 0x%lx read %p write %p written %p\n",
-			i, dev->flags, dev->toread, dev->towrite, dev->written);
+		PRINTK("check %d: state 0x%lx toread %p read %p write %p written %p\n",
+			i, dev->flags, dev->toread, dev->read, dev->towrite, dev->written);
 		/* maybe we can reply to a read */
-		if (test_bit(R5_UPTODATE, &dev->flags) && dev->toread) {
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
+		if (dev->read && fill_complete) {
+			return_bi = dev->read;
+			dev->read = NULL;
+		}
+
+		/* maybe we can start a biofill operation */
+		if (dev->toread) {
+			if (test_bit(R5_UPTODATE, &dev->flags)) {
+				if (!test_bit(STRIPE_OP_BIOFILL, &sh->state)) {
+					BUG_ON(dev->read);
+					spin_lock_irq(&conf->device_lock);
+					dev->read = dev->toread;
+					dev->toread = NULL;
+					if (test_and_clear_bit(R5_Overlap, &dev->flags))
+						wake_up(&conf->wait_for_overlap);
+					spin_unlock_irq(&conf->device_lock);
+					to_fill++;
 				}
-				spin_unlock_irq(&conf->device_lock);
-				rbi = rbi2;
-			}
+			} else
+				to_read++;
 		}
 
 		/* now count some things */
 		if (test_bit(R5_LOCKED, &dev->flags)) locked++;
 		if (test_bit(R5_UPTODATE, &dev->flags)) uptodate++;
 
-		
-		if (dev->toread) to_read++;
 		if (dev->towrite) {
 			to_write++;
 			if (!test_bit(R5_OVERWRITE, &dev->flags))
@@ -1799,6 +1836,13 @@
 			set_bit(R5_Insync, &dev->flags);
 	}
 	rcu_read_unlock();
+
+	if (to_fill) {
+		set_bit(STRIPE_OP_BIOFILL, &sh->state);
+		set_bit(STRIPE_OP_BIOFILL_Copy, &sh->ops.state);
+		sh->ops.pending++;
+	}
+
 	PRINTK("locked=%d uptodate=%d to_read=%d"
 		" to_write=%d failed=%d failed_num=%d\n",
 		locked, uptodate, to_read, to_write, failed, failed_num);
Index: linux-2.6-raid/include/linux/raid/raid5.h
===================================================================
--- linux-2.6-raid.orig/include/linux/raid/raid5.h	2006-06-28 11:05:38.000000000 -0700
+++ linux-2.6-raid/include/linux/raid/raid5.h	2006-06-29 11:40:37.000000000 -0700
@@ -160,7 +160,7 @@
 		struct bio	req;
 		struct bio_vec	vec;
 		struct page	*page;
-		struct bio	*toread, *towrite, *written;
+		struct bio	*toread, *read, *towrite, *written;
 		sector_t	sector;			/* sector of this page */
 		unsigned long	flags;
 	} dev[1]; /* allocated with extra space depending of RAID geometry */
@@ -240,6 +240,8 @@
 #define	STRIPE_OP_COMPUTE_End		16
 #define	STRIPE_OP_COMPUTE_Done		17
 #define	STRIPE_OP_COMPUTE_Recover	18
+#define	STRIPE_OP_BIOFILL_Copy		19
+#define	STRIPE_OP_BIOFILL_Done		20
 
 /*
  * Bit mask for status bits not to be cleared by the work queue thread
@@ -249,7 +251,8 @@
 						1 << STRIPE_OP_CHECK_Done |\
 						1 << STRIPE_OP_CHECK_IsZero |\
 						1 << STRIPE_OP_COMPUTE_Done |\
-						1 << STRIPE_OP_COMPUTE_Recover)
+						1 << STRIPE_OP_COMPUTE_Recover |\
+						1 << STRIPE_OP_BIOFILL_Done)
 /*
  * Plugging:
  *
