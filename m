Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031339AbWK3UM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031339AbWK3UM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031329AbWK3UMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:12:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:53315 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1031348AbWK3ULt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:11:49 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="171251885:sNHT44276932"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 11/12] md: raid5 io requests to raid5_run_ops
Date: Thu, 30 Nov 2006 13:10:55 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201055.21313.86049.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

generic_make_request may sleep, moving io to raid5_run_ops allows raid5d to
run freely.  Since raid5_run_ops is a workqueue other cpus can make forward
progress on other stripes.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |   68 ++++++++--------------------------------------------
 1 files changed, 10 insertions(+), 58 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8b36611..7d75fbe 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2431,6 +2431,8 @@ #endif
 						PRINTK("Read_old block %d for r-m-w\n", i);
 						set_bit(R5_LOCKED, &dev->flags);
 						set_bit(R5_Wantread, &dev->flags);
+						if (!test_and_set_bit(STRIPE_OP_IO, &sh->ops.pending))
+							sh->ops.count++;
 						locked++;
 					} else {
 						set_bit(STRIPE_DELAYED, &sh->state);
@@ -2451,6 +2453,8 @@ #endif
 						PRINTK("Read_old block %d for Reconstruct\n", i);
 						set_bit(R5_LOCKED, &dev->flags);
 						set_bit(R5_Wantread, &dev->flags);
+						if (!test_and_set_bit(STRIPE_OP_IO, &sh->ops.pending))
+							sh->ops.count++;
 						locked++;
 					} else {
 						set_bit(STRIPE_DELAYED, &sh->state);
@@ -2550,6 +2554,8 @@ #endif
 
 			set_bit(R5_LOCKED, &dev->flags);
 			set_bit(R5_Wantwrite, &dev->flags);
+			if (!test_and_set_bit(STRIPE_OP_IO, &sh->ops.pending))
+				sh->ops.count++;
 			clear_bit(STRIPE_DEGRADED, &sh->state);
 			locked++;
 			set_bit(STRIPE_INSYNC, &sh->state);
@@ -2571,12 +2577,16 @@ #endif
 		dev = &sh->dev[failed_num];
 		if (!test_bit(R5_ReWrite, &dev->flags)) {
 			set_bit(R5_Wantwrite, &dev->flags);
+			if (!test_and_set_bit(STRIPE_OP_IO, &sh->ops.pending))
+				sh->ops.count++;
 			set_bit(R5_ReWrite, &dev->flags);
 			set_bit(R5_LOCKED, &dev->flags);
 			locked++;
 		} else {
 			/* let's read it back */
 			set_bit(R5_Wantread, &dev->flags);
+			if (!test_and_set_bit(STRIPE_OP_IO, &sh->ops.pending))
+				sh->ops.count++;
 			set_bit(R5_LOCKED, &dev->flags);
 			locked++;
 		}
@@ -2682,64 +2692,6 @@ #endif
 		bi->bi_size = 0;
 		bi->bi_end_io(bi, bytes, 0);
 	}
-	for (i=disks; i-- ;) {
-		int rw;
-		struct bio *bi;
-		mdk_rdev_t *rdev;
-		if (test_and_clear_bit(R5_Wantwrite, &sh->dev[i].flags))
-			rw = 1;
-		else if (test_and_clear_bit(R5_Wantread, &sh->dev[i].flags))
-			rw = 0;
-		else
-			continue;
- 
-		bi = &sh->dev[i].req;
- 
-		bi->bi_rw = rw;
-		if (rw)
-			bi->bi_end_io = raid5_end_write_request;
-		else
-			bi->bi_end_io = raid5_end_read_request;
- 
-		rcu_read_lock();
-		rdev = rcu_dereference(conf->disks[i].rdev);
-		if (rdev && test_bit(Faulty, &rdev->flags))
-			rdev = NULL;
-		if (rdev)
-			atomic_inc(&rdev->nr_pending);
-		rcu_read_unlock();
- 
-		if (rdev) {
-			if (syncing || expanding || expanded)
-				md_sync_acct(rdev->bdev, STRIPE_SECTORS);
-
-			bi->bi_bdev = rdev->bdev;
-			PRINTK("for %llu schedule op %ld on disc %d\n",
-				(unsigned long long)sh->sector, bi->bi_rw, i);
-			atomic_inc(&sh->count);
-			bi->bi_sector = sh->sector + rdev->data_offset;
-			bi->bi_flags = 1 << BIO_UPTODATE;
-			bi->bi_vcnt = 1;	
-			bi->bi_max_vecs = 1;
-			bi->bi_idx = 0;
-			bi->bi_io_vec = &sh->dev[i].vec;
-			bi->bi_io_vec[0].bv_len = STRIPE_SIZE;
-			bi->bi_io_vec[0].bv_offset = 0;
-			bi->bi_size = STRIPE_SIZE;
-			bi->bi_next = NULL;
-			if (rw == WRITE &&
-			    test_bit(R5_ReWrite, &sh->dev[i].flags))
-				atomic_add(STRIPE_SECTORS, &rdev->corrected_errors);
-			generic_make_request(bi);
-		} else {
-			if (rw == 1)
-				set_bit(STRIPE_DEGRADED, &sh->state);
-			PRINTK("skip op %ld on disc %d for sector %llu\n",
-				bi->bi_rw, i, (unsigned long long)sh->sector);
-			clear_bit(R5_LOCKED, &sh->dev[i].flags);
-			set_bit(STRIPE_HANDLE, &sh->state);
-		}
-	}
 }
 
 static void handle_stripe6(struct stripe_head *sh, struct page *tmp_page)
