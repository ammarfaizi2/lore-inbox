Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031360AbWK3UMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031360AbWK3UMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031337AbWK3ULx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:11:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:61858 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1031339AbWK3ULH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:11:07 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="168615092:sNHT31412752"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 12/12] md: remove raid5 compute_block and compute_parity5
Date: Thu, 30 Nov 2006 13:11:00 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201100.21313.55964.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

replaced by raid5_run_ops

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c |  124 ----------------------------------------------------
 1 files changed, 0 insertions(+), 124 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7d75fbe..478741e 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1522,130 +1522,6 @@ #define check_xor()	do {						       \
 			   }						       \
 			} while(0)
 
-
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
-		xor_block(count, STRIPE_SIZE, ptr[0], &ptr[1]);
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
-		xor_block(count, STRIPE_SIZE, ptr[0], &ptr[1]);
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
-		xor_block(count, STRIPE_SIZE, ptr[0], &ptr[1]);
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
