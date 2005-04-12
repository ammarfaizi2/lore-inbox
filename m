Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVDLPsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVDLPsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVDLKud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:50:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:46538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262276AbVDLKdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:36 -0400
Message-Id: <200504121033.j3CAXO2p005866@shell0.pdx.osdl.net>
Subject: [patch 176/198] IB/mthca: fix MTT allocation in mem-free mode
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Fix bug in MTT allocation in mem-free mode.

I misunderstood the MTT size value returned by the firmware -- it is really
the size of a single MTT entry, since mem-free mode does not segment the MTT
as the original firmware did.  This meant that our MTT addresses ended up
being off by a factor of 8.  This meant that our MTT allocations might
overlap, and so we could overwrite and corrupt earlier memory regions when
writing new MTT entries.

We fix this by always using our 64-byte MTT segment size.  This allows some
simplification of the code as well, since there's no reason to put the MTT
segment size in a variable -- we can always use our enum value directly.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.c     |    2 --
 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.h     |    1 -
 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h     |    1 -
 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c    |    2 +-
 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c      |    6 +++---
 25-akpm/drivers/infiniband/hw/mthca/mthca_profile.c |    5 ++---
 6 files changed, 6 insertions(+), 11 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_cmd.c~ib-mthca-fix-mtt-allocation-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_cmd.c
--- 25/drivers/infiniband/hw/mthca/mthca_cmd.c~ib-mthca-fix-mtt-allocation-in-mem-free-mode	2005-04-12 03:21:45.316247784 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-12 03:21:45.327246112 -0700
@@ -990,7 +990,6 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
 		dev_lim->max_sg = min_t(int, field, dev_lim->max_sg);
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MTT_ENTRY_SZ_OFFSET);
-		dev_lim->mtt_seg_sz = size;
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MPT_ENTRY_SZ_OFFSET);
 		dev_lim->mpt_entry_sz = size;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_PBL_SZ_OFFSET);
@@ -1018,7 +1017,6 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	} else {
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_AV_OFFSET);
 		dev_lim->hca.tavor.max_avs = 1 << (field & 0x3f);
-		dev_lim->mtt_seg_sz   = MTHCA_MTT_SEG_SIZE;
 		dev_lim->mpt_entry_sz = MTHCA_MPT_ENTRY_SIZE;
 	}
 
diff -puN drivers/infiniband/hw/mthca/mthca_cmd.h~ib-mthca-fix-mtt-allocation-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_cmd.h
--- 25/drivers/infiniband/hw/mthca/mthca_cmd.h~ib-mthca-fix-mtt-allocation-in-mem-free-mode	2005-04-12 03:21:45.318247480 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-04-12 03:21:45.328245960 -0700
@@ -162,7 +162,6 @@ struct mthca_dev_lim {
 	int cqc_entry_sz;
 	int srq_entry_sz;
 	int uar_scratch_entry_sz;
-	int mtt_seg_sz;
 	int mpt_entry_sz;
 	union {
 		struct {
diff -puN drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-fix-mtt-allocation-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_dev.h
--- 25/drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-fix-mtt-allocation-in-mem-free-mode	2005-04-12 03:21:45.319247328 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-12 03:21:45.328245960 -0700
@@ -121,7 +121,6 @@ struct mthca_limits {
 	int      reserved_eqs;
 	int      num_mpts;
 	int      num_mtt_segs;
-	int      mtt_seg_size;
 	int      reserved_mtts;
 	int      reserved_mrws;
 	int      reserved_uars;
diff -puN drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-fix-mtt-allocation-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_main.c
--- 25/drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-fix-mtt-allocation-in-mem-free-mode	2005-04-12 03:21:45.321247024 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-12 03:21:45.329245808 -0700
@@ -390,7 +390,7 @@ static int __devinit mthca_init_icm(stru
 	}
 
 	mdev->mr_table.mtt_table = mthca_alloc_icm_table(mdev, init_hca->mtt_base,
-							 dev_lim->mtt_seg_sz,
+							 MTHCA_MTT_SEG_SIZE,
 							 mdev->limits.num_mtt_segs,
 							 mdev->limits.reserved_mtts, 1);
 	if (!mdev->mr_table.mtt_table) {
diff -puN drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-fix-mtt-allocation-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_mr.c
--- 25/drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-fix-mtt-allocation-in-mem-free-mode	2005-04-12 03:21:45.322246872 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-12 03:21:45.330245656 -0700
@@ -263,7 +263,7 @@ int mthca_mr_alloc_phys(struct mthca_dev
 			goto err_out_mpt_free;
 	}
 
-	for (i = dev->limits.mtt_seg_size / 8, mr->order = 0;
+	for (i = MTHCA_MTT_SEG_SIZE / 8, mr->order = 0;
 	     i < list_len;
 	     i <<= 1, ++mr->order)
 		; /* nothing */
@@ -286,7 +286,7 @@ int mthca_mr_alloc_phys(struct mthca_dev
 	mtt_entry = MAILBOX_ALIGN(mailbox);
 
 	mtt_entry[0] = cpu_to_be64(dev->mr_table.mtt_base +
-				   mr->first_seg * dev->limits.mtt_seg_size);
+				   mr->first_seg * MTHCA_MTT_SEG_SIZE);
 	mtt_entry[1] = 0;
 	for (i = 0; i < list_len; ++i)
 		mtt_entry[i + 2] = cpu_to_be64(buffer_list[i] |
@@ -330,7 +330,7 @@ int mthca_mr_alloc_phys(struct mthca_dev
 	memset(&mpt_entry->lkey, 0,
 	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
 	mpt_entry->mtt_seg   = cpu_to_be64(dev->mr_table.mtt_base +
-					   mr->first_seg * dev->limits.mtt_seg_size);
+					   mr->first_seg * MTHCA_MTT_SEG_SIZE);
 
 	if (0) {
 		mthca_dbg(dev, "Dumping MPT entry %08x:\n", mr->ibmr.lkey);
diff -puN drivers/infiniband/hw/mthca/mthca_profile.c~ib-mthca-fix-mtt-allocation-in-mem-free-mode drivers/infiniband/hw/mthca/mthca_profile.c
--- 25/drivers/infiniband/hw/mthca/mthca_profile.c~ib-mthca-fix-mtt-allocation-in-mem-free-mode	2005-04-12 03:21:45.323246720 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_profile.c	2005-04-12 03:21:45.331245504 -0700
@@ -95,7 +95,7 @@ u64 mthca_make_profile(struct mthca_dev 
 	profile[MTHCA_RES_RDB].size  = MTHCA_RDB_ENTRY_SIZE;
 	profile[MTHCA_RES_MCG].size  = MTHCA_MGM_ENTRY_SIZE;
 	profile[MTHCA_RES_MPT].size  = dev_lim->mpt_entry_sz;
-	profile[MTHCA_RES_MTT].size  = dev_lim->mtt_seg_sz;
+	profile[MTHCA_RES_MTT].size  = MTHCA_MTT_SEG_SIZE;
 	profile[MTHCA_RES_UAR].size  = dev_lim->uar_scratch_entry_sz;
 	profile[MTHCA_RES_UDAV].size = MTHCA_AV_SIZE;
 	profile[MTHCA_RES_UARC].size = request->uarc_size;
@@ -229,10 +229,9 @@ u64 mthca_make_profile(struct mthca_dev 
 			break;
 		case MTHCA_RES_MTT:
 			dev->limits.num_mtt_segs = profile[i].num;
-			dev->limits.mtt_seg_size = dev_lim->mtt_seg_sz;
 			dev->mr_table.mtt_base   = profile[i].start;
 			init_hca->mtt_base       = profile[i].start;
-			init_hca->mtt_seg_sz     = ffs(dev_lim->mtt_seg_sz) - 7;
+			init_hca->mtt_seg_sz     = ffs(MTHCA_MTT_SEG_SIZE) - 7;
 			break;
 		case MTHCA_RES_UAR:
 			dev->limits.num_uars       = profile[i].num;
_
