Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVAXGTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVAXGTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVAXGTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:19:54 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261449AbVAXGO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:27 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][2/12] InfiniBand/mthca: more Arbel Mem-Free support
In-Reply-To: <20051232214.3xuiAqAqwBM4Tlb4@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:23 -0800
Message-Id: <20051232214.G5RSVEyRyy7IWtkk@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0012 (UTC) FILETIME=[F3D38B40:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Continue development of Arbel Mem-Free support: we now compute a valid
profile, allocate context memory, map sufficient aux memory for HCA
page tables, map sufficient context memory to cover all reserved
firmware resources and successfully call the INIT_HCA and
QUERY_ADAPTER firmware commands.  Fix a few error gotos that unwound
the wrong things.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-23 08:30:23.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-23 20:26:07.036379712 -0800
@@ -174,27 +174,30 @@
 
 struct mthca_init_hca_param {
 	u64 qpc_base;
-	u8  log_num_qps;
 	u64 eec_base;
-	u8  log_num_eecs;
 	u64 srqc_base;
-	u8  log_num_srqs;
 	u64 cqc_base;
-	u8  log_num_cqs;
 	u64 eqpc_base;
 	u64 eeec_base;
 	u64 eqc_base;
-	u8  log_num_eqs;
 	u64 rdb_base;
 	u64 mc_base;
+	u64 mpt_base;
+	u64 mtt_base;
+	u64 uar_scratch_base;
+	u64 uarc_base;
 	u16 log_mc_entry_sz;
 	u16 mc_hash_sz;
+	u8  log_num_qps;
+	u8  log_num_eecs;
+	u8  log_num_srqs;
+	u8  log_num_cqs;
+	u8  log_num_eqs;
 	u8  log_mc_table_sz;
-	u64 mpt_base;
 	u8  mtt_seg_sz;
 	u8  log_mpt_sz;
-	u64 mtt_base;
-	u64 uar_scratch_base;
+	u8  log_uar_sz;
+	u8  log_uarc_sz;
 };
 
 struct mthca_init_ib_param {
@@ -238,6 +241,13 @@
 		  int port, u8 *status);
 int mthca_CLOSE_IB(struct mthca_dev *dev, int port, u8 *status);
 int mthca_CLOSE_HCA(struct mthca_dev *dev, int panic, u8 *status);
+int mthca_MAP_ICM(struct mthca_dev *dev, struct mthca_icm *icm, u64 virt, u8 *status);
+int mthca_MAP_ICM_page(struct mthca_dev *dev, u64 dma_addr, u64 virt, u8 *status);
+int mthca_UNMAP_ICM(struct mthca_dev *dev, u64 virt, u32 page_count, u8 *status);
+int mthca_MAP_ICM_AUX(struct mthca_dev *dev, struct mthca_icm *icm, u8 *status);
+int mthca_UNMAP_ICM_AUX(struct mthca_dev *dev, u8 *status);
+int mthca_SET_ICM_SIZE(struct mthca_dev *dev, u64 icm_size, u64 *aux_pages,
+		       u8 *status);
 int mthca_SW2HW_MPT(struct mthca_dev *dev, void *mpt_entry,
 		    int mpt_index, u8 *status);
 int mthca_HW2SW_MPT(struct mthca_dev *dev, void *mpt_entry,
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_profile.c	2005-01-23 08:32:07.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_profile.c	2005-01-23 20:26:07.033380168 -0800
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -60,7 +60,7 @@
 	MTHCA_NUM_PDS = 1 << 15
 };
 
-int mthca_make_profile(struct mthca_dev *dev,
+u64 mthca_make_profile(struct mthca_dev *dev,
 		       struct mthca_profile *request,
 		       struct mthca_dev_lim *dev_lim,
 		       struct mthca_init_hca_param *init_hca)
@@ -116,6 +116,8 @@
 		profile[i].type     = i;
 		profile[i].log_num  = max(ffs(profile[i].num) - 1, 0);
 		profile[i].size    *= profile[i].num;
+		if (dev->hca_type == ARBEL_NATIVE)
+			profile[i].size = max(profile[i].size, (u64) PAGE_SIZE);
 	}
 
 	if (dev->hca_type == ARBEL_NATIVE) {
@@ -239,6 +241,10 @@
 		case MTHCA_RES_UDAV:
 			dev->av_table.ddr_av_base = profile[i].start;
 			dev->av_table.num_ddr_avs = profile[i].num;
+		case MTHCA_RES_UARC:
+			init_hca->uarc_base   = profile[i].start;
+			init_hca->log_uarc_sz = ffs(request->uarc_size) - 13;
+			init_hca->log_uar_sz  = ffs(request->num_uar) - 1;
 		default:
 			break;
 		}
@@ -251,5 +257,5 @@
 	dev->limits.num_pds = MTHCA_NUM_PDS;
 
 	kfree(profile);
-	return 0;
+	return total_size;
 }
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-01-23 08:30:22.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-01-23 20:26:07.037379560 -0800
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -34,6 +34,16 @@
 
 #include "mthca_memfree.h"
 #include "mthca_dev.h"
+#include "mthca_cmd.h"
+
+/*
+ * We allocate in as big chunks as we can, up to a maximum of 256 KB
+ * per chunk.
+ */
+enum {
+	MTHCA_ICM_ALLOC_SIZE   = 1 << 18,
+	MTHCA_TABLE_CHUNK_SIZE = 1 << 18
+};
 
 void mthca_free_icm(struct mthca_dev *dev, struct mthca_icm *icm)
 {
@@ -71,11 +81,7 @@
 
 	INIT_LIST_HEAD(&icm->chunk_list);
 
-	/*
-	 * We allocate in as big chunks as we can, up to a maximum of
-	 * 256 KB per chunk.
-	 */
-	cur_order = get_order(1 << 18);
+	cur_order = get_order(MTHCA_ICM_ALLOC_SIZE);
 
 	while (npages > 0) {
 		if (!chunk) {
@@ -131,3 +137,70 @@
 	mthca_free_icm(dev, icm);
 	return NULL;
 }
+
+struct mthca_icm_table *mthca_alloc_icm_table(struct mthca_dev *dev,
+					      u64 virt, unsigned size,
+					      unsigned reserved,
+					      int use_lowmem)
+{
+	struct mthca_icm_table *table;
+	int num_icm;
+	int i;
+	u8 status;
+
+	num_icm = size / MTHCA_TABLE_CHUNK_SIZE;
+
+	table = kmalloc(sizeof *table + num_icm * sizeof *table->icm, GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	table->virt    = virt;
+	table->num_icm = num_icm;
+	init_MUTEX(&table->sem);
+
+	for (i = 0; i < num_icm; ++i)
+		table->icm[i] = NULL;
+
+	for (i = 0; i < (reserved + MTHCA_TABLE_CHUNK_SIZE - 1) / MTHCA_TABLE_CHUNK_SIZE; ++i) {
+		table->icm[i] = mthca_alloc_icm(dev, MTHCA_TABLE_CHUNK_SIZE >> PAGE_SHIFT,
+						(use_lowmem ? GFP_KERNEL : GFP_HIGHUSER) |
+						__GFP_NOWARN);
+		if (!table->icm[i])
+			goto err;
+		if (mthca_MAP_ICM(dev, table->icm[i], virt + i * MTHCA_TABLE_CHUNK_SIZE,
+				  &status) || status) {
+			mthca_free_icm(dev, table->icm[i]);
+			table->icm[i] = NULL;
+			goto err;
+		}
+	}
+
+	return table;
+
+err:
+	for (i = 0; i < num_icm; ++i)
+		if (table->icm[i]) {
+			mthca_UNMAP_ICM(dev, virt + i * MTHCA_TABLE_CHUNK_SIZE,
+					MTHCA_TABLE_CHUNK_SIZE >> 12, &status);
+			mthca_free_icm(dev, table->icm[i]);
+		}
+
+	kfree(table);
+
+	return NULL;
+}
+
+void mthca_free_icm_table(struct mthca_dev *dev, struct mthca_icm_table *table)
+{
+	int i;
+	u8 status;
+
+	for (i = 0; i < table->num_icm; ++i)
+		if (table->icm[i]) {
+			mthca_UNMAP_ICM(dev, table->virt + i * MTHCA_TABLE_CHUNK_SIZE,
+					MTHCA_TABLE_CHUNK_SIZE >> 12, &status);
+			mthca_free_icm(dev, table->icm[i]);
+		}
+
+	kfree(table);
+}
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-23 08:30:57.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-23 20:26:07.036379712 -0800
@@ -574,6 +574,50 @@
 				 dev->eq_table.eq + i);
 }
 
+int __devinit mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt)
+{
+	int ret;
+	u8 status;
+
+	/*
+	 * We assume that mapping one page is enough for the whole EQ
+	 * context table.  This is fine with all current HCAs, because
+	 * we only use 32 EQs and each EQ uses 32 bytes of context
+	 * memory, or 1 KB total.
+	 */
+	dev->eq_table.icm_virt = icm_virt;
+	dev->eq_table.icm_page = alloc_page(GFP_HIGHUSER);
+	if (!dev->eq_table.icm_page)
+		return -ENOMEM;
+	dev->eq_table.icm_dma  = pci_map_page(dev->pdev, dev->eq_table.icm_page, 0,
+					      PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
+	if (pci_dma_mapping_error(dev->eq_table.icm_dma)) {
+		__free_page(dev->eq_table.icm_page);
+		return -ENOMEM;
+	}
+
+	ret = mthca_MAP_ICM_page(dev, dev->eq_table.icm_dma, icm_virt, &status);
+	if (!ret && status)
+		ret = -EINVAL;
+	if (ret) {
+		pci_unmap_page(dev->pdev, dev->eq_table.icm_dma, PAGE_SIZE,
+			       PCI_DMA_BIDIRECTIONAL);
+		__free_page(dev->eq_table.icm_page);
+	}
+
+	return ret;
+}
+
+void __devexit mthca_unmap_eq_icm(struct mthca_dev *dev)
+{
+	u8 status;
+
+	mthca_UNMAP_ICM(dev, dev->eq_table.icm_virt, PAGE_SIZE / 4096, &status);
+	pci_unmap_page(dev->pdev, dev->eq_table.icm_dma, PAGE_SIZE,
+		       PCI_DMA_BIDIRECTIONAL);
+	__free_page(dev->eq_table.icm_page);
+}
+
 int __devinit mthca_init_eq_table(struct mthca_dev *dev)
 {
 	int err;
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-23 08:30:33.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-23 20:26:07.032380320 -0800
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -82,12 +82,9 @@
 	.num_cq     = 1 << 16,
 	.num_mcg    = 1 << 13,
 	.num_mpt    = 1 << 17,
-	.num_mtt    = 1 << 20
-};
-
-enum {
-	MTHCA_TAVOR_NUM_UDAV  = 1 << 15,
-	MTHCA_ARBEL_UARC_SIZE = 1 << 18
+	.num_mtt    = 1 << 20,
+	.num_udav   = 1 << 15,	/* Tavor only */
+	.uarc_size  = 1 << 18,	/* Arbel only */
 };
 
 static int __devinit mthca_tune_pci(struct mthca_dev *mdev)
@@ -207,58 +204,58 @@
 	err = mthca_QUERY_FW(mdev, &status);
 	if (err) {
 		mthca_err(mdev, "QUERY_FW command failed, aborting.\n");
-		goto err_out_disable;
+		goto err_disable;
 	}
 	if (status) {
 		mthca_err(mdev, "QUERY_FW returned status 0x%02x, "
 			  "aborting.\n", status);
 		err = -EINVAL;
-		goto err_out_disable;
+		goto err_disable;
 	}
 	err = mthca_QUERY_DDR(mdev, &status);
 	if (err) {
 		mthca_err(mdev, "QUERY_DDR command failed, aborting.\n");
-		goto err_out_disable;
+		goto err_disable;
 	}
 	if (status) {
 		mthca_err(mdev, "QUERY_DDR returned status 0x%02x, "
 			  "aborting.\n", status);
 		err = -EINVAL;
-		goto err_out_disable;
+		goto err_disable;
 	}
 
 	err = mthca_dev_lim(mdev, &dev_lim);
 
 	profile = default_profile;
-	profile.num_uar  = dev_lim.uar_size / PAGE_SIZE;
-	profile.num_udav = MTHCA_TAVOR_NUM_UDAV;
+	profile.num_uar   = dev_lim.uar_size / PAGE_SIZE;
+	profile.uarc_size = 0;
 
 	err = mthca_make_profile(mdev, &profile, &dev_lim, &init_hca);
-	if (err)
-		goto err_out_disable;
+	if (err < 0)
+		goto err_disable;
 
 	err = mthca_INIT_HCA(mdev, &init_hca, &status);
 	if (err) {
 		mthca_err(mdev, "INIT_HCA command failed, aborting.\n");
-		goto err_out_disable;
+		goto err_disable;
 	}
 	if (status) {
 		mthca_err(mdev, "INIT_HCA returned status 0x%02x, "
 			  "aborting.\n", status);
 		err = -EINVAL;
-		goto err_out_disable;
+		goto err_disable;
 	}
 
 	err = mthca_QUERY_ADAPTER(mdev, &adapter, &status);
 	if (err) {
 		mthca_err(mdev, "QUERY_ADAPTER command failed, aborting.\n");
-		goto err_out_disable;
+		goto err_close;
 	}
 	if (status) {
 		mthca_err(mdev, "QUERY_ADAPTER returned status 0x%02x, "
 			  "aborting.\n", status);
 		err = -EINVAL;
-		goto err_out_close;
+		goto err_close;
 	}
 
 	mdev->eq_table.inta_pin = adapter.inta_pin;
@@ -266,10 +263,10 @@
 
 	return 0;
 
-err_out_close:
+err_close:
 	mthca_CLOSE_HCA(mdev, 0, &status);
 
-err_out_disable:
+err_disable:
 	mthca_SYS_DIS(mdev, &status);
 
 	return err;
@@ -282,15 +279,15 @@
 
 	/* FIXME: use HCA-attached memory for FW if present */
 
-	mdev->fw.arbel.icm =
+	mdev->fw.arbel.fw_icm =
 		mthca_alloc_icm(mdev, mdev->fw.arbel.fw_pages,
 				GFP_HIGHUSER | __GFP_NOWARN);
-	if (!mdev->fw.arbel.icm) {
+	if (!mdev->fw.arbel.fw_icm) {
 		mthca_err(mdev, "Couldn't allocate FW area, aborting.\n");
 		return -ENOMEM;
 	}
 
-	err = mthca_MAP_FA(mdev, mdev->fw.arbel.icm, &status);
+	err = mthca_MAP_FA(mdev, mdev->fw.arbel.fw_icm, &status);
 	if (err) {
 		mthca_err(mdev, "MAP_FA command failed, aborting.\n");
 		goto err_free;
@@ -317,13 +314,146 @@
 	mthca_UNMAP_FA(mdev, &status);
 
 err_free:
-	mthca_free_icm(mdev, mdev->fw.arbel.icm);
+	mthca_free_icm(mdev, mdev->fw.arbel.fw_icm);
+	return err;
+}
+
+static int __devinit mthca_init_icm(struct mthca_dev *mdev,
+				    struct mthca_dev_lim *dev_lim,
+				    struct mthca_init_hca_param *init_hca,
+				    u64 icm_size)
+{
+	u64 aux_pages;
+	u8 status;
+	int err;
+
+	err = mthca_SET_ICM_SIZE(mdev, icm_size, &aux_pages, &status);
+	if (err) {
+		mthca_err(mdev, "SET_ICM_SIZE command failed, aborting.\n");
+		return err;
+	}
+	if (status) {
+		mthca_err(mdev, "SET_ICM_SIZE returned status 0x%02x, "
+			  "aborting.\n", status);
+		return -EINVAL;
+	}
+
+	mthca_dbg(mdev, "%lld KB of HCA context requires %lld KB aux memory.\n",
+		  (unsigned long long) icm_size >> 10,
+		  (unsigned long long) aux_pages << 2);
+
+	mdev->fw.arbel.aux_icm = mthca_alloc_icm(mdev, aux_pages,
+						 GFP_HIGHUSER | __GFP_NOWARN);
+	if (!mdev->fw.arbel.aux_icm) {
+		mthca_err(mdev, "Couldn't allocate aux memory, aborting.\n");
+		return -ENOMEM;
+	}
+
+	err = mthca_MAP_ICM_AUX(mdev, mdev->fw.arbel.aux_icm, &status);
+	if (err) {
+		mthca_err(mdev, "MAP_ICM_AUX command failed, aborting.\n");
+		goto err_free_aux;
+	}
+	if (status) {
+		mthca_err(mdev, "MAP_ICM_AUX returned status 0x%02x, aborting.\n", status);
+		err = -EINVAL;
+		goto err_free_aux;
+	}
+
+	err = mthca_map_eq_icm(mdev, init_hca->eqc_base);
+	if (err) {
+		mthca_err(mdev, "Failed to map EQ context memory, aborting.\n");
+		goto err_unmap_aux;
+	}
+
+	mdev->mr_table.mtt_table = mthca_alloc_icm_table(mdev, init_hca->mtt_base,
+							 mdev->limits.num_mtt_segs *
+							 init_hca->mtt_seg_sz,
+							 mdev->limits.reserved_mtts *
+							 init_hca->mtt_seg_sz, 1);
+	if (!mdev->mr_table.mtt_table) {
+		mthca_err(mdev, "Failed to map MTT context memory, aborting.\n");
+		err = -ENOMEM;
+		goto err_unmap_eq;
+	}
+
+	mdev->mr_table.mpt_table = mthca_alloc_icm_table(mdev, init_hca->mpt_base,
+							 mdev->limits.num_mpts *
+							 dev_lim->mpt_entry_sz,
+							 mdev->limits.reserved_mrws *
+							 dev_lim->mpt_entry_sz, 1);
+	if (!mdev->mr_table.mpt_table) {
+		mthca_err(mdev, "Failed to map MPT context memory, aborting.\n");
+		err = -ENOMEM;
+		goto err_unmap_mtt;
+	}
+
+	mdev->qp_table.qp_table = mthca_alloc_icm_table(mdev, init_hca->qpc_base,
+							mdev->limits.num_qps *
+							dev_lim->qpc_entry_sz,
+							mdev->limits.reserved_qps *
+							dev_lim->qpc_entry_sz, 1);
+	if (!mdev->qp_table.qp_table) {
+		mthca_err(mdev, "Failed to map QP context memory, aborting.\n");
+		err = -ENOMEM;
+		goto err_unmap_mpt;
+	}
+
+	mdev->qp_table.eqp_table = mthca_alloc_icm_table(mdev, init_hca->eqpc_base,
+							 mdev->limits.num_qps *
+							 dev_lim->eqpc_entry_sz,
+							 mdev->limits.reserved_qps *
+							 dev_lim->eqpc_entry_sz, 1);
+	if (!mdev->qp_table.eqp_table) {
+		mthca_err(mdev, "Failed to map EQP context memory, aborting.\n");
+		err = -ENOMEM;
+		goto err_unmap_qp;
+	}
+
+	mdev->cq_table.table = mthca_alloc_icm_table(mdev, init_hca->cqc_base,
+						     mdev->limits.num_cqs *
+						     dev_lim->cqc_entry_sz,
+						     mdev->limits.reserved_cqs *
+						     dev_lim->cqc_entry_sz, 1);
+	if (!mdev->cq_table.table) {
+		mthca_err(mdev, "Failed to map CQ context memory, aborting.\n");
+		err = -ENOMEM;
+		goto err_unmap_eqp;
+	}
+
+	return 0;
+
+err_unmap_eqp:
+	mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
+
+err_unmap_qp:
+	mthca_free_icm_table(mdev, mdev->qp_table.qp_table);
+
+err_unmap_mpt:
+	mthca_free_icm_table(mdev, mdev->mr_table.mpt_table);
+
+err_unmap_mtt:
+	mthca_free_icm_table(mdev, mdev->mr_table.mtt_table);
+
+err_unmap_eq:
+	mthca_unmap_eq_icm(mdev);
+
+err_unmap_aux:
+	mthca_UNMAP_ICM_AUX(mdev, &status);
+
+err_free_aux:
+	mthca_free_icm(mdev, mdev->fw.arbel.aux_icm);
+
 	return err;
 }
 
 static int __devinit mthca_init_arbel(struct mthca_dev *mdev)
 {
-	struct mthca_dev_lim dev_lim;
+	struct mthca_dev_lim        dev_lim;
+	struct mthca_profile        profile;
+	struct mthca_init_hca_param init_hca;
+	struct mthca_adapter        adapter;
+	u64 icm_size;
 	u8 status;
 	int err;
 
@@ -355,26 +485,77 @@
 	err = mthca_load_fw(mdev);
 	if (err) {
 		mthca_err(mdev, "Failed to start FW, aborting.\n");
-		goto err_out_disable;
+		goto err_disable;
 	}
 
 	err = mthca_dev_lim(mdev, &dev_lim);
 	if (err) {
 		mthca_err(mdev, "QUERY_DEV_LIM command failed, aborting.\n");
-		goto err_out_stop_fw;
+		goto err_stop_fw;
 	}
 
-	mthca_warn(mdev, "Sorry, native MT25208 mode support is not done, "
-		   "aborting.\n");
-	err = -ENODEV;
+	profile = default_profile;
+	profile.num_uar  = dev_lim.uar_size / PAGE_SIZE;
+	profile.num_udav = 0;
 
-err_out_stop_fw:
+	icm_size = mthca_make_profile(mdev, &profile, &dev_lim, &init_hca);
+	if ((int) icm_size < 0) {
+		err = icm_size;
+		goto err_stop_fw;
+	}
+
+	err = mthca_init_icm(mdev, &dev_lim, &init_hca, icm_size);
+	if (err)
+		goto err_stop_fw;
+
+	err = mthca_INIT_HCA(mdev, &init_hca, &status);
+	if (err) {
+		mthca_err(mdev, "INIT_HCA command failed, aborting.\n");
+		goto err_free_icm;
+	}
+	if (status) {
+		mthca_err(mdev, "INIT_HCA returned status 0x%02x, "
+			  "aborting.\n", status);
+		err = -EINVAL;
+		goto err_free_icm;
+	}
+
+	err = mthca_QUERY_ADAPTER(mdev, &adapter, &status);
+	if (err) {
+		mthca_err(mdev, "QUERY_ADAPTER command failed, aborting.\n");
+		goto err_free_icm;
+	}
+	if (status) {
+		mthca_err(mdev, "QUERY_ADAPTER returned status 0x%02x, "
+			  "aborting.\n", status);
+		err = -EINVAL;
+		goto err_free_icm;
+	}
+
+	mdev->eq_table.inta_pin = adapter.inta_pin;
+	mdev->rev_id            = adapter.revision_id;
+
+	return 0;
+
+err_free_icm:
+	mthca_free_icm_table(mdev, mdev->cq_table.table);
+	mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
+	mthca_free_icm_table(mdev, mdev->qp_table.qp_table);
+	mthca_free_icm_table(mdev, mdev->mr_table.mpt_table);
+	mthca_free_icm_table(mdev, mdev->mr_table.mtt_table);
+	mthca_unmap_eq_icm(mdev);
+
+	mthca_UNMAP_ICM_AUX(mdev, &status);
+	mthca_free_icm(mdev, mdev->fw.arbel.aux_icm);
+
+err_stop_fw:
 	mthca_UNMAP_FA(mdev, &status);
-	mthca_free_icm(mdev, mdev->fw.arbel.icm);
+	mthca_free_icm(mdev, mdev->fw.arbel.fw_icm);
 
-err_out_disable:
+err_disable:
 	if (!(mdev->mthca_flags & MTHCA_FLAG_NO_LAM))
 		mthca_DISABLE_LAM(mdev, &status);
+
 	return err;
 }
 
@@ -403,82 +584,89 @@
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
 			  "memory region table, aborting.\n");
-		goto err_out_pd_table_free;
+		goto err_pd_table_free;
 	}
 
 	err = mthca_pd_alloc(dev, &dev->driver_pd);
 	if (err) {
 		mthca_err(dev, "Failed to create driver PD, "
 			  "aborting.\n");
-		goto err_out_mr_table_free;
+		goto err_mr_table_free;
+	}
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		mthca_warn(dev, "Sorry, native MT25208 mode support is not done, "
+			   "aborting.\n");
+		err = -ENODEV;
+		goto err_pd_free;
 	}
 
 	err = mthca_init_eq_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
 			  "event queue table, aborting.\n");
-		goto err_out_pd_free;
+		goto err_pd_free;
 	}
 
 	err = mthca_cmd_use_events(dev);
 	if (err) {
 		mthca_err(dev, "Failed to switch to event-driven "
 			  "firmware commands, aborting.\n");
-		goto err_out_eq_table_free;
+		goto err_eq_table_free;
 	}
 
 	err = mthca_init_cq_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
 			  "completion queue table, aborting.\n");
-		goto err_out_cmd_poll;
+		goto err_cmd_poll;
 	}
 
 	err = mthca_init_qp_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
 			  "queue pair table, aborting.\n");
-		goto err_out_cq_table_free;
+		goto err_cq_table_free;
 	}
 
 	err = mthca_init_av_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
 			  "address vector table, aborting.\n");
-		goto err_out_qp_table_free;
+		goto err_qp_table_free;
 	}
 
 	err = mthca_init_mcg_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
 			  "multicast group table, aborting.\n");
-		goto err_out_av_table_free;
+		goto err_av_table_free;
 	}
 
 	return 0;
 
-err_out_av_table_free:
+err_av_table_free:
 	mthca_cleanup_av_table(dev);
 
-err_out_qp_table_free:
+err_qp_table_free:
 	mthca_cleanup_qp_table(dev);
 
-err_out_cq_table_free:
+err_cq_table_free:
 	mthca_cleanup_cq_table(dev);
 
-err_out_cmd_poll:
+err_cmd_poll:
 	mthca_cmd_use_polling(dev);
 
-err_out_eq_table_free:
+err_eq_table_free:
 	mthca_cleanup_eq_table(dev);
 
-err_out_pd_free:
+err_pd_free:
 	mthca_pd_free(dev, &dev->driver_pd);
 
-err_out_mr_table_free:
+err_mr_table_free:
 	mthca_cleanup_mr_table(dev);
 
-err_out_pd_table_free:
+err_pd_table_free:
 	mthca_cleanup_pd_table(dev);
 	return err;
 }
@@ -507,32 +695,32 @@
 				MTHCA_CLR_INT_SIZE,
 				DRV_NAME)) {
 		err = -EBUSY;
-		goto err_out_bar0_beg;
+		goto err_bar0_beg;
 	}
 
 	err = pci_request_region(pdev, 2, DRV_NAME);
 	if (err)
-		goto err_out_bar0_end;
+		goto err_bar0_end;
 
 	if (!ddr_hidden) {
 		err = pci_request_region(pdev, 4, DRV_NAME);
 		if (err)
-			goto err_out_bar2;
+			goto err_bar2;
 	}
 
 	return 0;
 
-err_out_bar0_beg:
+err_bar0_beg:
 	release_mem_region(pci_resource_start(pdev, 0) +
 			   MTHCA_HCR_BASE,
 			   MTHCA_MAP_HCR_SIZE);
 
-err_out_bar0_end:
+err_bar0_end:
 	release_mem_region(pci_resource_start(pdev, 0) +
 			   MTHCA_CLR_INT_BASE,
 			   MTHCA_CLR_INT_SIZE);
 
-err_out_bar2:
+err_bar2:
 	pci_release_region(pdev, 2);
 	return err;
 }
@@ -582,8 +770,18 @@
 	mthca_CLOSE_HCA(mdev, 0, &status);
 
 	if (mdev->hca_type == ARBEL_NATIVE) {
+		mthca_free_icm_table(mdev, mdev->cq_table.table);
+		mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
+		mthca_free_icm_table(mdev, mdev->qp_table.qp_table);
+		mthca_free_icm_table(mdev, mdev->mr_table.mpt_table);
+		mthca_free_icm_table(mdev, mdev->mr_table.mtt_table);
+		mthca_unmap_eq_icm(mdev);
+
+		mthca_UNMAP_ICM_AUX(mdev, &status);
+		mthca_free_icm(mdev, mdev->fw.arbel.aux_icm);
+
 		mthca_UNMAP_FA(mdev, &status);
-		mthca_free_icm(mdev, mdev->fw.arbel.icm);
+		mthca_free_icm(mdev, mdev->fw.arbel.fw_icm);
 
 		if (!(mdev->mthca_flags & MTHCA_FLAG_NO_LAM))
 			mthca_DISABLE_LAM(mdev, &status);
@@ -623,13 +821,13 @@
 	    pci_resource_len(pdev, 0) != 1 << 20) {
 		dev_err(&pdev->dev, "Missing DCS, aborting.");
 		err = -ENODEV;
-		goto err_out_disable_pdev;
+		goto err_disable_pdev;
 	}
 	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM) ||
 	    pci_resource_len(pdev, 2) != 1 << 23) {
 		dev_err(&pdev->dev, "Missing UAR, aborting.");
 		err = -ENODEV;
-		goto err_out_disable_pdev;
+		goto err_disable_pdev;
 	}
 	if (!(pci_resource_flags(pdev, 4) & IORESOURCE_MEM))
 		ddr_hidden = 1;
@@ -638,7 +836,7 @@
 	if (err) {
 		dev_err(&pdev->dev, "Cannot obtain PCI resources, "
 			"aborting.\n");
-		goto err_out_disable_pdev;
+		goto err_disable_pdev;
 	}
 
 	pci_set_master(pdev);
@@ -649,7 +847,7 @@
 		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (err) {
 			dev_err(&pdev->dev, "Can't set PCI DMA mask, aborting.\n");
-			goto err_out_free_res;
+			goto err_free_res;
 		}
 	}
 	err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
@@ -660,7 +858,7 @@
 		if (err) {
 			dev_err(&pdev->dev, "Can't set consistent PCI DMA mask, "
 				"aborting.\n");
-			goto err_out_free_res;
+			goto err_free_res;
 		}
 	}
 
@@ -669,7 +867,7 @@
 		dev_err(&pdev->dev, "Device struct alloc failed, "
 			"aborting.\n");
 		err = -ENOMEM;
-		goto err_out_free_res;
+		goto err_free_res;
 	}
 
 	mdev->pdev     = pdev;
@@ -686,7 +884,7 @@
 	err = mthca_reset(mdev);
 	if (err) {
 		mthca_err(mdev, "Failed to reset HCA, aborting.\n");
-		goto err_out_free_dev;
+		goto err_free_dev;
 	}
 
 	if (msi_x && !mthca_enable_msi_x(mdev))
@@ -705,7 +903,7 @@
 		mthca_err(mdev, "Couldn't map command register, "
 			  "aborting.\n");
 		err = -ENOMEM;
-		goto err_out_free_dev;
+		goto err_free_dev;
 	}
 	mdev->clr_base = ioremap(mthca_base + MTHCA_CLR_INT_BASE,
 				 MTHCA_CLR_INT_SIZE);
@@ -713,7 +911,7 @@
 		mthca_err(mdev, "Couldn't map command register, "
 			  "aborting.\n");
 		err = -ENOMEM;
-		goto err_out_iounmap;
+		goto err_iounmap;
 	}
 
 	mthca_base = pci_resource_start(pdev, 2);
@@ -722,37 +920,37 @@
 		mthca_err(mdev, "Couldn't map kernel access region, "
 			  "aborting.\n");
 		err = -ENOMEM;
-		goto err_out_iounmap_clr;
+		goto err_iounmap_clr;
 	}
 
 	err = mthca_tune_pci(mdev);
 	if (err)
-		goto err_out_iounmap_kar;
+		goto err_iounmap_kar;
 
 	err = mthca_init_hca(mdev);
 	if (err)
-		goto err_out_iounmap_kar;
+		goto err_iounmap_kar;
 
 	err = mthca_setup_hca(mdev);
 	if (err)
-		goto err_out_close;
+		goto err_close;
 
 	err = mthca_register_device(mdev);
 	if (err)
-		goto err_out_cleanup;
+		goto err_cleanup;
 
 	err = mthca_create_agents(mdev);
 	if (err)
-		goto err_out_unregister;
+		goto err_unregister;
 
 	pci_set_drvdata(pdev, mdev);
 
 	return 0;
 
-err_out_unregister:
+err_unregister:
 	mthca_unregister_device(mdev);
 
-err_out_cleanup:
+err_cleanup:
 	mthca_cleanup_mcg_table(mdev);
 	mthca_cleanup_av_table(mdev);
 	mthca_cleanup_qp_table(mdev);
@@ -765,19 +963,19 @@
 	mthca_cleanup_mr_table(mdev);
 	mthca_cleanup_pd_table(mdev);
 
-err_out_close:
+err_close:
 	mthca_close_hca(mdev);
 
-err_out_iounmap_kar:
+err_iounmap_kar:
 	iounmap(mdev->kar);
 
-err_out_iounmap_clr:
+err_iounmap_clr:
 	iounmap(mdev->clr_base);
 
-err_out_iounmap:
+err_iounmap:
 	iounmap(mdev->hcr);
 
-err_out_free_dev:
+err_free_dev:
 	if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
 		pci_disable_msix(pdev);
 	if (mdev->mthca_flags & MTHCA_FLAG_MSI)
@@ -785,10 +983,10 @@
 
 	ib_dealloc_device(&mdev->ib_dev);
 
-err_out_free_res:
+err_free_res:
 	mthca_release_regions(pdev, ddr_hidden);
 
-err_out_disable_pdev:
+err_disable_pdev:
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 	return err;
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_profile.h	2005-01-23 08:31:33.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_profile.h	2005-01-23 20:26:07.035379864 -0800
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -50,7 +50,7 @@
 	int uarc_size;
 };
 
-int mthca_make_profile(struct mthca_dev *mdev,
+u64 mthca_make_profile(struct mthca_dev *mdev,
 		       struct mthca_profile *request,
 		       struct mthca_dev_lim *dev_lim,
 		       struct mthca_init_hca_param *init_hca);
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-23 08:31:13.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-23 20:26:07.034380016 -0800
@@ -509,7 +509,8 @@
 	return mthca_cmd(dev, 0, 0, 0, CMD_SYS_DIS, HZ, status);
 }
 
-int mthca_MAP_FA(struct mthca_dev *dev, struct mthca_icm *icm, u8 *status)
+static int mthca_map_cmd(struct mthca_dev *dev, u16 op, struct mthca_icm *icm,
+			 u64 virt, u8 *status)
 {
 	u32 *inbox;
 	dma_addr_t indma;
@@ -518,12 +519,17 @@
 	int nent = 0;
 	int i;
 	int err = 0;
-	int ts = 0;
+	int ts = 0, tc = 0;
 
 	inbox = pci_alloc_consistent(dev->pdev, PAGE_SIZE, &indma);
+	if (!inbox)
+		return -ENOMEM;
+
 	memset(inbox, 0, PAGE_SIZE);
 
-	for (mthca_icm_first(icm, &iter); !mthca_icm_last(&iter); mthca_icm_next(&iter)) {
+	for (mthca_icm_first(icm, &iter);
+	     !mthca_icm_last(&iter);
+	     mthca_icm_next(&iter)) {
 		/*
 		 * We have to pass pages that are aligned to their
 		 * size, so find the least significant 1 in the
@@ -538,13 +544,20 @@
 			goto out;
 		}
 		for (i = 0; i < mthca_icm_size(&iter) / (1 << lg); ++i, ++nent) {
+			if (virt != -1) {
+				*((__be64 *) (inbox + nent * 4)) =
+					cpu_to_be64(virt);
+				virt += 1 << lg;
+			}
+
 			*((__be64 *) (inbox + nent * 4 + 2)) =
 				cpu_to_be64((mthca_icm_addr(&iter) +
-					     (i << lg)) |
-					    (lg - 12));
+					     (i << lg)) | (lg - 12));
 			ts += 1 << (lg - 10);
+			++tc;
+
 			if (nent == PAGE_SIZE / 16) {
-				err = mthca_cmd(dev, indma, nent, 0, CMD_MAP_FA,
+				err = mthca_cmd(dev, indma, nent, 0, op,
 						CMD_TIME_CLASS_B, status);
 				if (err || *status)
 					goto out;
@@ -553,18 +566,33 @@
 		}
 	}
 
-	if (nent) {
-		err = mthca_cmd(dev, indma, nent, 0, CMD_MAP_FA,
+	if (nent)
+		err = mthca_cmd(dev, indma, nent, 0, op,
 				CMD_TIME_CLASS_B, status);
-	}
 
-	mthca_dbg(dev, "Mapped %d KB of host memory for FW.\n", ts);
+	switch (op) {
+	case CMD_MAP_FA:
+		mthca_dbg(dev, "Mapped %d chunks/%d KB for FW.\n", tc, ts);
+		break;
+	case CMD_MAP_ICM_AUX:
+		mthca_dbg(dev, "Mapped %d chunks/%d KB for ICM aux.\n", tc, ts);
+		break;
+	case CMD_MAP_ICM:
+		mthca_dbg(dev, "Mapped %d chunks/%d KB at %llx for ICM.\n",
+			  tc, ts, (unsigned long long) virt - (ts << 10));
+		break;
+	}
 
 out:
 	pci_free_consistent(dev->pdev, PAGE_SIZE, inbox, indma);
 	return err;
 }
 
+int mthca_MAP_FA(struct mthca_dev *dev, struct mthca_icm *icm, u8 *status)
+{
+	return mthca_map_cmd(dev, CMD_MAP_FA, icm, -1, status);
+}
+
 int mthca_UNMAP_FA(struct mthca_dev *dev, u8 *status)
 {
 	return mthca_cmd(dev, 0, 0, 0, CMD_UNMAP_FA, CMD_TIME_CLASS_B, status);
@@ -1068,8 +1096,11 @@
 #define  INIT_HCA_MTT_BASE_OFFSET        (INIT_HCA_TPT_OFFSET + 0x10)
 #define INIT_HCA_UAR_OFFSET              0x120
 #define  INIT_HCA_UAR_BASE_OFFSET        (INIT_HCA_UAR_OFFSET + 0x00)
+#define  INIT_HCA_UARC_SZ_OFFSET         (INIT_HCA_UAR_OFFSET + 0x09)
+#define  INIT_HCA_LOG_UAR_SZ_OFFSET      (INIT_HCA_UAR_OFFSET + 0x0a)
 #define  INIT_HCA_UAR_PAGE_SZ_OFFSET     (INIT_HCA_UAR_OFFSET + 0x0b)
 #define  INIT_HCA_UAR_SCATCH_BASE_OFFSET (INIT_HCA_UAR_OFFSET + 0x10)
+#define  INIT_HCA_UAR_CTX_BASE_OFFSET    (INIT_HCA_UAR_OFFSET + 0x18)
 
 	inbox = pci_alloc_consistent(dev->pdev, INIT_HCA_IN_SIZE, &indma);
 	if (!inbox)
@@ -1117,7 +1148,8 @@
 	/* TPT attributes */
 
 	MTHCA_PUT(inbox, param->mpt_base,   INIT_HCA_MPT_BASE_OFFSET);
-	MTHCA_PUT(inbox, param->mtt_seg_sz, INIT_HCA_MTT_SEG_SZ_OFFSET);
+	if (dev->hca_type != ARBEL_NATIVE)
+		MTHCA_PUT(inbox, param->mtt_seg_sz, INIT_HCA_MTT_SEG_SZ_OFFSET);
 	MTHCA_PUT(inbox, param->log_mpt_sz, INIT_HCA_LOG_MPT_SZ_OFFSET);
 	MTHCA_PUT(inbox, param->mtt_base,   INIT_HCA_MTT_BASE_OFFSET);
 
@@ -1125,7 +1157,14 @@
 	{
 		u8 uar_page_sz = PAGE_SHIFT - 12;
 		MTHCA_PUT(inbox, uar_page_sz, INIT_HCA_UAR_PAGE_SZ_OFFSET);
-		MTHCA_PUT(inbox, param->uar_scratch_base, INIT_HCA_UAR_SCATCH_BASE_OFFSET);
+	}
+
+	MTHCA_PUT(inbox, param->uar_scratch_base, INIT_HCA_UAR_SCATCH_BASE_OFFSET);
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		MTHCA_PUT(inbox, param->log_uarc_sz, INIT_HCA_UARC_SZ_OFFSET);
+		MTHCA_PUT(inbox, param->log_uar_sz,  INIT_HCA_LOG_UAR_SZ_OFFSET);
+		MTHCA_PUT(inbox, param->uarc_base,   INIT_HCA_UAR_CTX_BASE_OFFSET);
 	}
 
 	err = mthca_cmd(dev, indma, 0, 0, CMD_INIT_HCA,
@@ -1199,6 +1238,68 @@
 	return mthca_cmd(dev, 0, 0, panic, CMD_CLOSE_HCA, HZ, status);
 }
 
+int mthca_MAP_ICM(struct mthca_dev *dev, struct mthca_icm *icm, u64 virt, u8 *status)
+{
+	return mthca_map_cmd(dev, CMD_MAP_ICM, icm, virt, status);
+}
+
+int mthca_MAP_ICM_page(struct mthca_dev *dev, u64 dma_addr, u64 virt, u8 *status)
+{
+	u64 *inbox;
+	dma_addr_t indma;
+	int err;
+
+	inbox = pci_alloc_consistent(dev->pdev, 16, &indma);
+	if (!inbox)
+		return -ENOMEM;
+
+	inbox[0] = cpu_to_be64(virt);
+	inbox[1] = cpu_to_be64(dma_addr | (PAGE_SHIFT - 12));
+
+	err = mthca_cmd(dev, indma, 1, 0, CMD_MAP_ICM, CMD_TIME_CLASS_B, status);
+
+	pci_free_consistent(dev->pdev, 16, inbox, indma);
+
+	if (!err)
+		mthca_dbg(dev, "Mapped page at %llx for ICM.\n",
+			  (unsigned long long) virt);
+
+	return err;
+}
+
+int mthca_UNMAP_ICM(struct mthca_dev *dev, u64 virt, u32 page_count, u8 *status)
+{
+	return mthca_cmd(dev, virt, page_count, 0, CMD_UNMAP_ICM, CMD_TIME_CLASS_B, status);
+}
+
+int mthca_MAP_ICM_AUX(struct mthca_dev *dev, struct mthca_icm *icm, u8 *status)
+{
+	return mthca_map_cmd(dev, CMD_MAP_ICM_AUX, icm, -1, status);
+}
+
+int mthca_UNMAP_ICM_AUX(struct mthca_dev *dev, u8 *status)
+{
+	return mthca_cmd(dev, 0, 0, 0, CMD_UNMAP_ICM_AUX, CMD_TIME_CLASS_B, status);
+}
+
+int mthca_SET_ICM_SIZE(struct mthca_dev *dev, u64 icm_size, u64 *aux_pages,
+		       u8 *status)
+{
+	int ret = mthca_cmd_imm(dev, icm_size, aux_pages, 0, 0, CMD_SET_ICM_SIZE,
+				CMD_TIME_CLASS_A, status);
+
+	if (ret || status)
+		return ret;
+
+	/*
+	 * Arbel page size is always 4 KB; round up number of system
+	 * pages needed.
+	 */
+	*aux_pages = (*aux_pages + (1 << (PAGE_SHIFT - 12)) - 1) >> (PAGE_SHIFT - 12);
+
+	return 0;
+}
+
 int mthca_SW2HW_MPT(struct mthca_dev *dev, void *mpt_entry,
 		    int mpt_index, u8 *status)
 {
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-01-23 08:31:06.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-01-23 20:26:07.032380320 -0800
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -38,8 +38,10 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 
+#include <asm/semaphore.h>
+
 #define MTHCA_ICM_CHUNK_LEN \
-	((512 - sizeof (struct list_head) - 2 * sizeof (int)) /		\
+	((256 - sizeof (struct list_head) - 2 * sizeof (int)) /		\
 	 (sizeof (struct scatterlist)))
 
 struct mthca_icm_chunk {
@@ -53,6 +55,13 @@
 	struct list_head chunk_list;
 };
 
+struct mthca_icm_table {
+	u64               virt;
+	int               num_icm;
+	struct semaphore  sem;
+	struct mthca_icm *icm[0];
+};
+
 struct mthca_icm_iter {
 	struct mthca_icm       *icm;
 	struct mthca_icm_chunk *chunk;
@@ -65,6 +74,12 @@
 				  unsigned int gfp_mask);
 void mthca_free_icm(struct mthca_dev *dev, struct mthca_icm *icm);
 
+struct mthca_icm_table *mthca_alloc_icm_table(struct mthca_dev *dev,
+					      u64 virt, unsigned size,
+					      unsigned reserved,
+					      int use_lowmem);
+void mthca_free_icm_table(struct mthca_dev *dev, struct mthca_icm_table *table);
+
 static inline void mthca_icm_first(struct mthca_icm *icm,
 				   struct mthca_icm_iter *iter)
 {
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-01-23 08:30:19.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_dev.h	2005-01-23 20:26:07.030380624 -0800
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -153,10 +153,12 @@
 };
 
 struct mthca_mr_table {
-	struct mthca_alloc mpt_alloc;
-	int                max_mtt_order;
-	unsigned long    **mtt_buddy;
-	u64                mtt_base;
+	struct mthca_alloc      mpt_alloc;
+	int                     max_mtt_order;
+	unsigned long         **mtt_buddy;
+	u64                     mtt_base;
+	struct mthca_icm_table *mtt_table;
+	struct mthca_icm_table *mpt_table;
 };
 
 struct mthca_eq_table {
@@ -164,23 +166,29 @@
 	void __iomem      *clr_int;
 	u32                clr_mask;
 	struct mthca_eq    eq[MTHCA_NUM_EQ];
+	u64                icm_virt;
+	struct page       *icm_page;
+	dma_addr_t         icm_dma;
 	int                have_irq;
 	u8                 inta_pin;
 };
 
 struct mthca_cq_table {
-	struct mthca_alloc alloc;
-	spinlock_t         lock;
-	struct mthca_array cq;
+	struct mthca_alloc 	alloc;
+	spinlock_t         	lock;
+	struct mthca_array      cq;
+	struct mthca_icm_table *table;
 };
 
 struct mthca_qp_table {
-	struct mthca_alloc alloc;
-	u32                rdb_base;
-	int                rdb_shift;
-	int                sqp_start;
-	spinlock_t         lock;
-	struct mthca_array qp;
+	struct mthca_alloc     	alloc;
+	u32                    	rdb_base;
+	int                    	rdb_shift;
+	int                    	sqp_start;
+	spinlock_t             	lock;
+	struct mthca_array     	qp;
+	struct mthca_icm_table *qp_table;
+	struct mthca_icm_table *eqp_table;
 };
 
 struct mthca_av_table {
@@ -216,7 +224,8 @@
 			u64 clr_int_base;
 			u64 eq_arm_base;
 			u64 eq_set_ci_base;
-			struct mthca_icm *icm;
+			struct mthca_icm *fw_icm;
+			struct mthca_icm *aux_icm;
 			u16 fw_pages;
 		}        arbel;
 	}                fw;
@@ -329,6 +338,9 @@
 			u32 access, struct mthca_mr *mr);
 void mthca_free_mr(struct mthca_dev *dev, struct mthca_mr *mr);
 
+int mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt);
+void mthca_unmap_eq_icm(struct mthca_dev *dev);
+
 int mthca_poll_cq(struct ib_cq *ibcq, int num_entries,
 		  struct ib_wc *entry);
 void mthca_arm_cq(struct mthca_dev *dev, struct mthca_cq *cq,

