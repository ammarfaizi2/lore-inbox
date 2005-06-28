Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVF1XdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVF1XdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVF1XdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:33:01 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:41396 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262230AbVF1XDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:55 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037106:sNHT30930172"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 09/16] IB uverbs: add mthca user doorbell record support
In-Reply-To: <2005628163.kTUk6BiHHfEXJhoz@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.UOpVQTxEtDs4UiFi@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for userspace doorbell records to mthca.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_memfree.c |  141 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/mthca/mthca_memfree.h |   14 ++
 2 files changed, 149 insertions(+), 6 deletions(-)



--- linux.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-06-28 15:19:22.793941807 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-06-28 15:20:12.995098113 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -47,6 +48,15 @@ enum {
 	MTHCA_TABLE_CHUNK_SIZE = 1 << 18
 };
 
+struct mthca_user_db_table {
+	struct semaphore mutex;
+	struct {
+		u64                uvirt;
+		struct scatterlist mem;
+		int                refcount;
+	}                page[0];
+};
+
 void mthca_free_icm(struct mthca_dev *dev, struct mthca_icm *icm)
 {
 	struct mthca_icm_chunk *chunk, *tmp;
@@ -344,13 +354,133 @@ void mthca_free_icm_table(struct mthca_d
 	kfree(table);
 }
 
-static u64 mthca_uarc_virt(struct mthca_dev *dev, int page)
+static u64 mthca_uarc_virt(struct mthca_dev *dev, struct mthca_uar *uar, int page)
 {
 	return dev->uar_table.uarc_base +
-		dev->driver_uar.index * dev->uar_table.uarc_size +
+		uar->index * dev->uar_table.uarc_size +
 		page * 4096;
 }
 
+int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
+		      struct mthca_user_db_table *db_tab, int index, u64 uaddr)
+{
+	int ret = 0;
+	u8 status;
+	int i;
+
+	if (!mthca_is_memfree(dev))
+		return 0;
+
+	if (index < 0 || index > dev->uar_table.uarc_size / 8)
+		return -EINVAL;
+
+	down(&db_tab->mutex);
+
+	i = index / MTHCA_DB_REC_PER_PAGE;
+
+	if ((db_tab->page[i].refcount >= MTHCA_DB_REC_PER_PAGE)       ||
+	    (db_tab->page[i].uvirt && db_tab->page[i].uvirt != uaddr) ||
+	    (uaddr & 4095)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (db_tab->page[i].refcount) {
+		++db_tab->page[i].refcount;
+		goto out;
+	}
+
+	ret = get_user_pages(current, current->mm, uaddr & PAGE_MASK, 1, 1, 0,
+			     &db_tab->page[i].mem.page, NULL);
+	if (ret < 0)
+		goto out;
+
+	db_tab->page[i].mem.length = 4096;
+	db_tab->page[i].mem.offset = uaddr & ~PAGE_MASK;
+
+	ret = pci_map_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+	if (ret < 0) {
+		put_page(db_tab->page[i].mem.page);
+		goto out;
+	}
+
+	ret = mthca_MAP_ICM_page(dev, sg_dma_address(&db_tab->page[i].mem),
+				 mthca_uarc_virt(dev, uar, i), &status);
+	if (!ret && status)
+		ret = -EINVAL;
+	if (ret) {
+		pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+		put_page(db_tab->page[i].mem.page);
+		goto out;
+	}
+
+	db_tab->page[i].uvirt    = uaddr;
+	db_tab->page[i].refcount = 1;
+
+out:
+	up(&db_tab->mutex);
+	return ret;
+}
+
+void mthca_unmap_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
+			 struct mthca_user_db_table *db_tab, int index)
+{
+	if (!mthca_is_memfree(dev))
+		return;
+
+	/*
+	 * To make our bookkeeping simpler, we don't unmap DB
+	 * pages until we clean up the whole db table.
+	 */
+
+	down(&db_tab->mutex);
+
+	--db_tab->page[index / MTHCA_DB_REC_PER_PAGE].refcount;
+
+	up(&db_tab->mutex);
+}
+
+struct mthca_user_db_table *mthca_init_user_db_tab(struct mthca_dev *dev)
+{
+	struct mthca_user_db_table *db_tab;
+	int npages;
+	int i;
+
+	if (!mthca_is_memfree(dev))
+		return NULL;
+
+	npages = dev->uar_table.uarc_size / 4096;
+	db_tab = kmalloc(sizeof *db_tab + npages * sizeof *db_tab->page, GFP_KERNEL);
+	if (!db_tab)
+		return ERR_PTR(-ENOMEM);
+
+	init_MUTEX(&db_tab->mutex);
+	for (i = 0; i < npages; ++i) {
+		db_tab->page[i].refcount = 0;
+		db_tab->page[i].uvirt    = 0;
+	}
+
+	return db_tab;
+}
+
+void mthca_cleanup_user_db_tab(struct mthca_dev *dev, struct mthca_uar *uar,
+			       struct mthca_user_db_table *db_tab)
+{
+	int i;
+	u8 status;
+
+	if (!mthca_is_memfree(dev))
+		return;
+
+	for (i = 0; i < dev->uar_table.uarc_size / 4096; ++i) {
+		if (db_tab->page[i].uvirt) {
+			mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, uar, i), 1, &status);
+			pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+			put_page(db_tab->page[i].mem.page);
+		}
+	}
+}
+
 int mthca_alloc_db(struct mthca_dev *dev, int type, u32 qn, u32 **db)
 {
 	int group;
@@ -407,7 +537,8 @@ int mthca_alloc_db(struct mthca_dev *dev
 	}
 	memset(page->db_rec, 0, 4096);
 
-	ret = mthca_MAP_ICM_page(dev, page->mapping, mthca_uarc_virt(dev, i), &status);
+	ret = mthca_MAP_ICM_page(dev, page->mapping,
+				 mthca_uarc_virt(dev, &dev->driver_uar, i), &status);
 	if (!ret && status)
 		ret = -EINVAL;
 	if (ret) {
@@ -461,7 +592,7 @@ void mthca_free_db(struct mthca_dev *dev
 
 	if (bitmap_empty(page->used, MTHCA_DB_REC_PER_PAGE) &&
 	    i >= dev->db_tab->max_group1 - 1) {
-		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, i), 1, &status);
+		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, &dev->driver_uar, i), 1, &status);
 
 		dma_free_coherent(&dev->pdev->dev, 4096,
 				  page->db_rec, page->mapping);
@@ -530,7 +661,7 @@ void mthca_cleanup_db_tab(struct mthca_d
 		if (!bitmap_empty(dev->db_tab->page[i].used, MTHCA_DB_REC_PER_PAGE))
 			mthca_warn(dev, "Kernel UARC page %d not empty\n", i);
 
-		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, i), 1, &status);
+		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, &dev->driver_uar, i), 1, &status);
 
 		dma_free_coherent(&dev->pdev->dev, 4096,
 				  dev->db_tab->page[i].db_rec,
--- linux.orig/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-06-28 15:19:22.793941807 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-06-28 15:20:12.995098113 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -148,7 +149,7 @@ struct mthca_db_table {
 	struct semaphore      mutex;
 };
 
-enum {
+enum mthca_db_type {
 	MTHCA_DB_TYPE_INVALID   = 0x0,
 	MTHCA_DB_TYPE_CQ_SET_CI = 0x1,
 	MTHCA_DB_TYPE_CQ_ARM    = 0x2,
@@ -158,6 +159,17 @@ enum {
 	MTHCA_DB_TYPE_GROUP_SEP = 0x7
 };
 
+struct mthca_user_db_table;
+struct mthca_uar;
+
+int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
+		      struct mthca_user_db_table *db_tab, int index, u64 uaddr);
+void mthca_unmap_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
+			 struct mthca_user_db_table *db_tab, int index);
+struct mthca_user_db_table *mthca_init_user_db_tab(struct mthca_dev *dev);
+void mthca_cleanup_user_db_tab(struct mthca_dev *dev, struct mthca_uar *uar,
+			       struct mthca_user_db_table *db_tab);
+
 int mthca_init_db_tab(struct mthca_dev *dev);
 void mthca_cleanup_db_tab(struct mthca_dev *dev);
 int mthca_alloc_db(struct mthca_dev *dev, int type, u32 qn, u32 **db);
