Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVALV74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVALV74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVALV73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:59:29 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261494AbVALVsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:30 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.YiTPGKcPKdqWU1cs@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:48:04 -0800
Message-Id: <20051121348.wTtIj6K84YZQwY0U@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][11/18] InfiniBand/mthca: clean up computation of HCA memory map
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:48:07.0173 (UTC) FILETIME=[66ADEB50:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the computation of the HCA context memory map.  This serves two purposes:
 - make it easier to change the HCA "profile" (eg add more QPs)
 - make it easier to implement mem-free Arbel support

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/hw/mthca/mthca_dev.h	(revision 1493)
+++ linux/drivers/infiniband/hw/mthca/mthca_dev.h	(revision 1494)
@@ -70,13 +70,16 @@
 };
 
 enum {
-	MTHCA_MPT_ENTRY_SIZE  =  0x40,
 	MTHCA_EQ_CONTEXT_SIZE =  0x40,
 	MTHCA_CQ_CONTEXT_SIZE =  0x40,
 	MTHCA_QP_CONTEXT_SIZE = 0x200,
 	MTHCA_RDB_ENTRY_SIZE  =  0x20,
 	MTHCA_AV_SIZE         =  0x20,
-	MTHCA_MGM_ENTRY_SIZE  =  0x40
+	MTHCA_MGM_ENTRY_SIZE  =  0x40,
+
+	/* Arbel FW gives us these, but we need them for Tavor */
+	MTHCA_MPT_ENTRY_SIZE  =  0x40,
+	MTHCA_MTT_SEG_SIZE    =  0x40,
 };
 
 enum {
--- linux/drivers/infiniband/hw/mthca/mthca_main.c	(revision 1493)
+++ linux/drivers/infiniband/hw/mthca/mthca_main.c	(revision 1494)
@@ -76,6 +76,20 @@
 	"ib_mthca: Mellanox InfiniBand HCA driver v"
 	DRV_VERSION " (" DRV_RELDATE ")\n";
 
+static struct mthca_profile default_profile = {
+	.num_qp     = 1 << 16,
+	.rdb_per_qp = 4,
+	.num_cq     = 1 << 16,
+	.num_mcg    = 1 << 13,
+	.num_mpt    = 1 << 17,
+	.num_mtt    = 1 << 20
+};
+
+enum {
+	MTHCA_TAVOR_NUM_UDAV  = 1 << 15,
+	MTHCA_ARBEL_UARC_SIZE = 1 << 18
+};
+
 static int __devinit mthca_tune_pci(struct mthca_dev *mdev)
 {
 	int cap;
@@ -175,6 +189,7 @@
 	u8 status;
 	int err;
 	struct mthca_dev_lim        dev_lim;
+	struct mthca_profile        profile;
 	struct mthca_init_hca_param init_hca;
 	struct mthca_adapter        adapter;
 
@@ -214,7 +229,11 @@
 
 	err = mthca_dev_lim(mdev, &dev_lim);
 
-	err = mthca_make_profile(mdev, &dev_lim, &init_hca);
+	profile = default_profile;
+	profile.num_uar  = dev_lim.uar_size / PAGE_SIZE;
+	profile.num_udav = MTHCA_TAVOR_NUM_UDAV;
+
+	err = mthca_make_profile(mdev, &profile, &dev_lim, &init_hca);
 	if (err)
 		goto err_out_disable;
 
--- linux/drivers/infiniband/hw/mthca/mthca_profile.c	(revision 1493)
+++ linux/drivers/infiniband/hw/mthca/mthca_profile.c	(revision 1494)
@@ -37,31 +37,34 @@
 
 #include "mthca_profile.h"
 
-static int default_profile[MTHCA_RES_NUM] = {
-	[MTHCA_RES_QP]    = 1 << 16,
-	[MTHCA_RES_EQP]   = 1 << 16,
-	[MTHCA_RES_CQ]    = 1 << 16,
-	[MTHCA_RES_EQ]    = 32,
-	[MTHCA_RES_RDB]   = 1 << 18,
-	[MTHCA_RES_MCG]   = 1 << 13,
-	[MTHCA_RES_MPT]   = 1 << 17,
-	[MTHCA_RES_MTT]   = 1 << 20,
-	[MTHCA_RES_UDAV]  = 1 << 15
-};
-
 enum {
-	MTHCA_MTT_SEG_SIZE   = 64
+	MTHCA_RES_QP,
+	MTHCA_RES_EEC,
+	MTHCA_RES_SRQ,
+	MTHCA_RES_CQ,
+	MTHCA_RES_EQP,
+	MTHCA_RES_EEEC,
+	MTHCA_RES_EQ,
+	MTHCA_RES_RDB,
+	MTHCA_RES_MCG,
+	MTHCA_RES_MPT,
+	MTHCA_RES_MTT,
+	MTHCA_RES_UAR,
+	MTHCA_RES_UDAV,
+	MTHCA_RES_UARC,
+	MTHCA_RES_NUM
 };
 
 enum {
+	MTHCA_NUM_EQS = 32,
 	MTHCA_NUM_PDS = 1 << 15
 };
 
 int mthca_make_profile(struct mthca_dev *dev,
+		       struct mthca_profile *request,
 		       struct mthca_dev_lim *dev_lim,
 		       struct mthca_init_hca_param *init_hca)
 {
-	/* just use default profile for now */
 	struct mthca_resource {
 		u64 size;
 		u64 start;
@@ -70,17 +73,18 @@
 		int log_num;
 	};
 
+	u64 mem_base, mem_avail;
 	u64 total_size = 0;
 	struct mthca_resource *profile;
 	struct mthca_resource tmp;
 	int i, j;
 
-	default_profile[MTHCA_RES_UAR] = dev_lim->uar_size / PAGE_SIZE;
-
 	profile = kmalloc(MTHCA_RES_NUM * sizeof *profile, GFP_KERNEL);
 	if (!profile)
 		return -ENOMEM;
 
+	memset(profile, 0, MTHCA_RES_NUM * sizeof *profile);
+
 	profile[MTHCA_RES_QP].size   = dev_lim->qpc_entry_sz;
 	profile[MTHCA_RES_EEC].size  = dev_lim->eec_entry_sz;
 	profile[MTHCA_RES_SRQ].size  = dev_lim->srq_entry_sz;
@@ -90,18 +94,38 @@
 	profile[MTHCA_RES_EQ].size   = dev_lim->eqc_entry_sz;
 	profile[MTHCA_RES_RDB].size  = MTHCA_RDB_ENTRY_SIZE;
 	profile[MTHCA_RES_MCG].size  = MTHCA_MGM_ENTRY_SIZE;
-	profile[MTHCA_RES_MPT].size  = MTHCA_MPT_ENTRY_SIZE;
-	profile[MTHCA_RES_MTT].size  = MTHCA_MTT_SEG_SIZE;
+	profile[MTHCA_RES_MPT].size  = dev_lim->mpt_entry_sz;
+	profile[MTHCA_RES_MTT].size  = dev_lim->mtt_seg_sz;
 	profile[MTHCA_RES_UAR].size  = dev_lim->uar_scratch_entry_sz;
 	profile[MTHCA_RES_UDAV].size = MTHCA_AV_SIZE;
+	profile[MTHCA_RES_UARC].size = request->uarc_size;
 
+	profile[MTHCA_RES_QP].num    = request->num_qp;
+	profile[MTHCA_RES_EQP].num   = request->num_qp;
+	profile[MTHCA_RES_RDB].num   = request->num_qp * request->rdb_per_qp;
+	profile[MTHCA_RES_CQ].num    = request->num_cq;
+	profile[MTHCA_RES_EQ].num    = MTHCA_NUM_EQS;
+	profile[MTHCA_RES_MCG].num   = request->num_mcg;
+	profile[MTHCA_RES_MPT].num   = request->num_mpt;
+	profile[MTHCA_RES_MTT].num   = request->num_mtt;
+	profile[MTHCA_RES_UAR].num   = request->num_uar;
+	profile[MTHCA_RES_UARC].num  = request->num_uar;
+	profile[MTHCA_RES_UDAV].num  = request->num_udav;
+
 	for (i = 0; i < MTHCA_RES_NUM; ++i) {
 		profile[i].type     = i;
-		profile[i].num      = default_profile[i];
-		profile[i].log_num  = max(ffs(default_profile[i]) - 1, 0);
-		profile[i].size    *= default_profile[i];
+		profile[i].log_num  = max(ffs(profile[i].num) - 1, 0);
+		profile[i].size    *= profile[i].num;
 	}
 
+	if (dev->hca_type == ARBEL_NATIVE) {
+		mem_base  = 0;
+		mem_avail = dev_lim->hca.arbel.max_icm_sz;
+	} else {
+		mem_base  = dev->ddr_start;
+		mem_avail = dev->fw.tavor.fw_start - dev->ddr_start;
+	}
+
 	/*
 	 * Sort the resources in decreasing order of size.  Since they
 	 * all have sizes that are powers of 2, we'll be able to keep
@@ -119,16 +143,14 @@
 
 	for (i = 0; i < MTHCA_RES_NUM; ++i) {
 		if (profile[i].size) {
-			profile[i].start = dev->ddr_start + total_size;
+			profile[i].start = mem_base + total_size;
 			total_size      += profile[i].size;
 		}
-		if (total_size > dev->fw.tavor.fw_start - dev->ddr_start) {
+		if (total_size > mem_avail) {
 			mthca_err(dev, "Profile requires 0x%llx bytes; "
-				  "won't fit between DDR start at 0x%016llx "
-				  "and FW start at 0x%016llx.\n",
+				  "won't in 0x%llx bytes of context memory.\n",
 				  (unsigned long long) total_size,
-				  (unsigned long long) dev->ddr_start,
-				  (unsigned long long) dev->fw.tavor.fw_start);
+				  (unsigned long long) mem_avail);
 			kfree(profile);
 			return -ENOMEM;
 		}
@@ -141,10 +163,13 @@
 				  (unsigned long long) profile[i].size);
 	}
 
-	mthca_dbg(dev, "HCA memory: allocated %d KB/%d KB (%d KB free)\n",
-		  (int) (total_size >> 10),
-		  (int) ((dev->fw.tavor.fw_start - dev->ddr_start) >> 10),
-		  (int) ((dev->fw.tavor.fw_start - dev->ddr_start - total_size) >> 10));
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_dbg(dev, "HCA context memory: reserving %d KB\n",
+			  (int) (total_size >> 10));
+	else
+		mthca_dbg(dev, "HCA memory: allocated %d KB/%d KB (%d KB free)\n",
+			  (int) (total_size >> 10), (int) (mem_avail >> 10),
+			  (int) ((mem_avail - total_size) >> 10));
 
 	for (i = 0; i < MTHCA_RES_NUM; ++i) {
 		switch (profile[i].type) {
@@ -203,10 +228,10 @@
 			break;
 		case MTHCA_RES_MTT:
 			dev->limits.num_mtt_segs = profile[i].num;
-			dev->limits.mtt_seg_size = MTHCA_MTT_SEG_SIZE;
+			dev->limits.mtt_seg_size = dev_lim->mtt_seg_sz;
 			dev->mr_table.mtt_base   = profile[i].start;
 			init_hca->mtt_base       = profile[i].start;
-			init_hca->mtt_seg_sz     = ffs(MTHCA_MTT_SEG_SIZE) - 7;
+			init_hca->mtt_seg_sz     = ffs(dev_lim->mtt_seg_sz) - 7;
 			break;
 		case MTHCA_RES_UAR:
 			init_hca->uar_scratch_base = profile[i].start;
--- linux/drivers/infiniband/hw/mthca/mthca_cmd.c	(revision 1493)
+++ linux/drivers/infiniband/hw/mthca/mthca_cmd.c	(revision 1494)
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -959,9 +959,9 @@
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_RSZ_SRQ_OFFSET);
 		dev_lim->hca.arbel.resize_srq = field & 1;
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MTT_ENTRY_SZ_OFFSET);
-		dev_lim->hca.arbel.mtt_entry_sz = size;
+		dev_lim->mtt_seg_sz = size;
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MPT_ENTRY_SZ_OFFSET);
-		dev_lim->hca.arbel.mpt_entry_sz = size;
+		dev_lim->mpt_entry_sz = size;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_PBL_SZ_OFFSET);
 		dev_lim->hca.arbel.max_pbl_sz = 1 << (field & 0x3f);
 		MTHCA_GET(dev_lim->hca.arbel.bmme_flags, outbox,
@@ -987,6 +987,8 @@
 	} else {
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_AV_OFFSET);
 		dev_lim->hca.tavor.max_avs = 1 << (field & 0x3f);
+		dev_lim->mtt_seg_sz   = MTHCA_MTT_SEG_SIZE;
+		dev_lim->mpt_entry_sz = MTHCA_MPT_ENTRY_SIZE;
 	}
 
 out:
--- linux/drivers/infiniband/hw/mthca/mthca_profile.h	(revision 1493)
+++ linux/drivers/infiniband/hw/mthca/mthca_profile.h	(revision 1494)
@@ -38,24 +38,20 @@
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
 
-enum {
-	MTHCA_RES_QP,
-	MTHCA_RES_EEC,
-	MTHCA_RES_SRQ,
-	MTHCA_RES_CQ,
-	MTHCA_RES_EQP,
-	MTHCA_RES_EEEC,
-	MTHCA_RES_EQ,
-	MTHCA_RES_RDB,
-	MTHCA_RES_MCG,
-	MTHCA_RES_MPT,
-	MTHCA_RES_MTT,
-	MTHCA_RES_UAR,
-	MTHCA_RES_UDAV,
-	MTHCA_RES_NUM
+struct mthca_profile {
+	int num_qp;
+	int rdb_per_qp;
+	int num_cq;
+	int num_mcg;
+	int num_mpt;
+	int num_mtt;
+	int num_udav;
+	int num_uar;
+	int uarc_size;
 };
 
 int mthca_make_profile(struct mthca_dev *mdev,
+		       struct mthca_profile *request,
 		       struct mthca_dev_lim *dev_lim,
 		       struct mthca_init_hca_param *init_hca);
 
--- linux/drivers/infiniband/hw/mthca/mthca_cmd.h	(revision 1493)
+++ linux/drivers/infiniband/hw/mthca/mthca_cmd.h	(revision 1494)
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -148,14 +148,14 @@
 	int cqc_entry_sz;
 	int srq_entry_sz;
 	int uar_scratch_entry_sz;
+	int mtt_seg_sz;
+	int mpt_entry_sz;
 	union {
 		struct {
 			int max_avs;
 		} tavor;
 		struct {
 			int resize_srq;
-			int mtt_entry_sz;
-			int mpt_entry_sz;
 			int max_pbl_sz;
 			u8  bmme_flags;
 			u32 reserved_lkey;

