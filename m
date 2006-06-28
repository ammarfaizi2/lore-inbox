Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWF1Sab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWF1Sab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWF1Sab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:30:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:46873 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750851AbWF1SaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:30:10 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="90665399:sNHT15679580"
Subject: [PATCH 006 of 006] raid5: Remove compute_block and compute_parity
From: Dan Williams <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:24:20 -0700
Message-Id: <1151519060.2232.68.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compute_block and compute_parity5 are replaced by the work queue and the
handle_*_operations5 routines.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 raid5.c |  123 ----------------------------------------------------------------
 1 files changed, 123 deletions(-)

===================================================================
--- linux-2.6-raid.orig/drivers/md/raid5.c	2006-06-27 16:16:31.000000000 -0700
+++ linux-2.6-raid/drivers/md/raid5.c	2006-06-27 16:19:13.000000000 -0700
@@ -918,129 +918,6 @@
 			} while(0)
 
 
-static void compute_block(struct stripe_head *sh, int dd_idx)
-{
-	int i, count, disks = sh->disks;
-	void *ptr[MAX_XOR_BLOCKS], *p;
-
-	PRINTK("compute_block, stripe %llu, idx %d\n", 
-		(unsigned long long)sh->sector, dd_idx);
-
-	ptr[0] = page_address(sh->dev[dd_idx].page);
-	memset(ptr[0], 0, STRIPE_SIZE);
-	count = 1;
-	for (i = disks ; i--; ) {
-		if (i == dd_idx)
-			continue;
-		p = page_address(sh->dev[i].page);
-		if (test_bit(R5_UPTODATE, &sh->dev[i].flags))
-			ptr[count++] = p;
-		else
-			printk(KERN_ERR "compute_block() %d, stripe %llu, %d"
-				" not present\n", dd_idx,
-				(unsigned long long)sh->sector, i);
-
-		check_xor();
-	}
-	if (count != 1)
-		xor_block(count, STRIPE_SIZE, ptr);
-	set_bit(R5_UPTODATE, &sh->dev[dd_idx].flags);
-}
-
-static void compute_parity5(struct stripe_head *sh, int method)
-{
-	raid5_conf_t *conf = sh->raid_conf;
-	int i, pd_idx = sh->pd_idx, disks = sh->disks, count;
-	void *ptr[MAX_XOR_BLOCKS];
-	struct bio *chosen;
-
-	PRINTK("compute_parity5, stripe %llu, method %d\n",
-		(unsigned long long)sh->sector, method);
-
-	count = 1;
-	ptr[0] = page_address(sh->dev[pd_idx].page);
-	switch(method) {
-	case READ_MODIFY_WRITE:
-		BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags));
-		for (i=disks ; i-- ;) {
-			if (i==pd_idx)
-				continue;
-			if (sh->dev[i].towrite &&
-			    test_bit(R5_UPTODATE, &sh->dev[i].flags)) {
-				ptr[count++] = page_address(sh->dev[i].page);
-				chosen = sh->dev[i].towrite;
-				sh->dev[i].towrite = NULL;
-
-				if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
-					wake_up(&conf->wait_for_overlap);
-
-				BUG_ON(sh->dev[i].written);
-				sh->dev[i].written = chosen;
-				check_xor();
-			}
-		}
-		break;
-	case RECONSTRUCT_WRITE:
-		memset(ptr[0], 0, STRIPE_SIZE);
-		for (i= disks; i-- ;)
-			if (i!=pd_idx && sh->dev[i].towrite) {
-				chosen = sh->dev[i].towrite;
-				sh->dev[i].towrite = NULL;
-
-				if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
-					wake_up(&conf->wait_for_overlap);
-
-				BUG_ON(sh->dev[i].written);
-				sh->dev[i].written = chosen;
-			}
-		break;
-	case CHECK_PARITY:
-		break;
-	}
-	if (count>1) {
-		xor_block(count, STRIPE_SIZE, ptr);
-		count = 1;
-	}
-	
-	for (i = disks; i--;)
-		if (sh->dev[i].written) {
-			sector_t sector = sh->dev[i].sector;
-			struct bio *wbi = sh->dev[i].written;
-			while (wbi && wbi->bi_sector < sector + STRIPE_SECTORS) {
-				copy_data(1, wbi, sh->dev[i].page, sector);
-				wbi = r5_next_bio(wbi, sector);
-			}
-
-			set_bit(R5_LOCKED, &sh->dev[i].flags);
-			set_bit(R5_UPTODATE, &sh->dev[i].flags);
-		}
-
-	switch(method) {
-	case RECONSTRUCT_WRITE:
-	case CHECK_PARITY:
-		for (i=disks; i--;)
-			if (i != pd_idx) {
-				ptr[count++] = page_address(sh->dev[i].page);
-				check_xor();
-			}
-		break;
-	case READ_MODIFY_WRITE:
-		for (i = disks; i--;)
-			if (sh->dev[i].written) {
-				ptr[count++] = page_address(sh->dev[i].page);
-				check_xor();
-			}
-	}
-	if (count != 1)
-		xor_block(count, STRIPE_SIZE, ptr);
-	
-	if (method != CHECK_PARITY) {
-		set_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
-		set_bit(R5_LOCKED,   &sh->dev[pd_idx].flags);
-	} else
-		clear_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
-}
-
 static void compute_parity6(struct stripe_head *sh, int method)
 {
 	raid6_conf_t *conf = sh->raid_conf;
