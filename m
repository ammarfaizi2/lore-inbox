Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVCCXuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVCCXuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbVCCXtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:49:33 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262737AbVCCXWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:21 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][15/26] IB/mthca: mem-free doorbell record allocation
In-Reply-To: <2005331520.6eBThkRRWYJ5HE5s@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.dH2BeQ6Ko7h8SaKM@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0941 (UTC) FILETIME=[95E38550:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mem-free mode requires the driver to allocate additional doorbell pages
for each user access region.  Add support for this in mthca_memfree.c,
and have the driver allocate a table in db_tab for kernel use.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:57.857362663 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:59.077097900 -0800
@@ -268,9 +268,10 @@
 	struct mthca_av_table  av_table;
 	struct mthca_mcg_table mcg_table;
 
-	struct mthca_uar      driver_uar;
-	struct mthca_pd       driver_pd;
-	struct mthca_mr       driver_mr;
+	struct mthca_uar       driver_uar;
+	struct mthca_db_table *db_tab;
+	struct mthca_pd        driver_pd;
+	struct mthca_mr        driver_mr;
 
 	struct ib_mad_agent  *send_agent[MTHCA_MAX_PORTS][2];
 	struct ib_ah         *sm_ah[MTHCA_MAX_PORTS];
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-03-03 14:12:56.773597912 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-03-03 14:12:59.079097466 -0800
@@ -267,3 +267,199 @@
 
 	kfree(table);
 }
+
+static u64 mthca_uarc_virt(struct mthca_dev *dev, int page)
+{
+	return dev->uar_table.uarc_base +
+		dev->driver_uar.index * dev->uar_table.uarc_size +
+		page * 4096;
+}
+
+int mthca_alloc_db(struct mthca_dev *dev, int type, u32 qn, u32 **db)
+{
+	int group;
+	int start, end, dir;
+	int i, j;
+	struct mthca_db_page *page;
+	int ret = 0;
+	u8 status;
+
+	down(&dev->db_tab->mutex);
+
+	switch (type) {
+	case MTHCA_DB_TYPE_CQ_ARM:
+	case MTHCA_DB_TYPE_SQ:
+		group = 0;
+		start = 0;
+		end   = dev->db_tab->max_group1;
+		dir   = 1;
+		break;
+
+	case MTHCA_DB_TYPE_CQ_SET_CI:
+	case MTHCA_DB_TYPE_RQ:
+	case MTHCA_DB_TYPE_SRQ:
+		group = 1;
+		start = dev->db_tab->npages - 1;
+		end   = dev->db_tab->min_group2;
+		dir   = -1;
+		break;
+
+	default:
+		return -1;
+	}
+	
+	for (i = start; i != end; i += dir)
+		if (dev->db_tab->page[i].db_rec &&
+		    !bitmap_full(dev->db_tab->page[i].used,
+				 MTHCA_DB_REC_PER_PAGE)) {
+			page = dev->db_tab->page + i;
+			goto found;
+		}
+
+	if (dev->db_tab->max_group1 >= dev->db_tab->min_group2 - 1) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	page = dev->db_tab->page + end;
+	page->db_rec = dma_alloc_coherent(&dev->pdev->dev, 4096,
+					  &page->mapping, GFP_KERNEL);
+	if (!page->db_rec) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(page->db_rec, 0, 4096);
+
+	ret = mthca_MAP_ICM_page(dev, page->mapping, mthca_uarc_virt(dev, i), &status);
+	if (!ret && status)
+		ret = -EINVAL;
+	if (ret) {
+		dma_free_coherent(&dev->pdev->dev, 4096,
+				  page->db_rec, page->mapping);
+		goto out;
+	}
+
+	bitmap_zero(page->used, MTHCA_DB_REC_PER_PAGE);
+	if (group == 0)
+		++dev->db_tab->max_group1;
+	else
+		--dev->db_tab->min_group2;
+
+found:
+	j = find_first_zero_bit(page->used, MTHCA_DB_REC_PER_PAGE);
+	set_bit(j, page->used);
+
+	if (group == 1)
+		j = MTHCA_DB_REC_PER_PAGE - 1 - j;
+
+	ret = i * MTHCA_DB_REC_PER_PAGE + j;
+
+	page->db_rec[j] = cpu_to_be64((qn << 8) | (type << 5));
+	
+	*db = (u32 *) &page->db_rec[j];
+
+out:
+	up(&dev->db_tab->mutex);
+
+	return ret;
+}
+
+void mthca_free_db(struct mthca_dev *dev, int type, int db_index)
+{
+	int i, j;
+	struct mthca_db_page *page;
+	u8 status;
+
+	i = db_index / MTHCA_DB_REC_PER_PAGE;
+	j = db_index % MTHCA_DB_REC_PER_PAGE;
+
+	page = dev->db_tab->page + i;
+
+	down(&dev->db_tab->mutex);
+
+	page->db_rec[j] = 0;
+	if (i >= dev->db_tab->min_group2)
+		j = MTHCA_DB_REC_PER_PAGE - 1 - j;
+	clear_bit(j, page->used);
+
+	if (bitmap_empty(page->used, MTHCA_DB_REC_PER_PAGE) &&
+	    i >= dev->db_tab->max_group1 - 1) {
+		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, i), 1, &status);
+		
+		dma_free_coherent(&dev->pdev->dev, 4096,
+				  page->db_rec, page->mapping);
+		page->db_rec = NULL;
+
+		if (i == dev->db_tab->max_group1) {
+			--dev->db_tab->max_group1;
+			/* XXX may be able to unmap more pages now */
+		}
+		if (i == dev->db_tab->min_group2)
+			++dev->db_tab->min_group2;
+	}
+
+	up(&dev->db_tab->mutex);
+}
+
+int mthca_init_db_tab(struct mthca_dev *dev)
+{
+	int i;
+
+	if (dev->hca_type != ARBEL_NATIVE)
+		return 0;
+
+	dev->db_tab = kmalloc(sizeof *dev->db_tab, GFP_KERNEL);
+	if (!dev->db_tab)
+		return -ENOMEM;
+
+	init_MUTEX(&dev->db_tab->mutex);
+
+	dev->db_tab->npages     = dev->uar_table.uarc_size / PAGE_SIZE;
+	dev->db_tab->max_group1 = 0;
+	dev->db_tab->min_group2 = dev->db_tab->npages - 1;
+
+	dev->db_tab->page = kmalloc(dev->db_tab->npages *
+				    sizeof *dev->db_tab->page,
+				    GFP_KERNEL);
+	if (!dev->db_tab->page) {
+		kfree(dev->db_tab);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < dev->db_tab->npages; ++i)
+		dev->db_tab->page[i].db_rec = NULL;
+
+	return 0;
+}
+
+void mthca_cleanup_db_tab(struct mthca_dev *dev)
+{
+	int i;
+	u8 status;
+
+	if (dev->hca_type != ARBEL_NATIVE)
+		return;
+
+	/*
+	 * Because we don't always free our UARC pages when they
+	 * become empty to make mthca_free_db() simpler we need to
+	 * make a sweep through the doorbell pages and free any
+	 * leftover pages now.
+	 */
+	for (i = 0; i < dev->db_tab->npages; ++i) {
+		if (!dev->db_tab->page[i].db_rec)
+			continue;
+
+		if (!bitmap_empty(dev->db_tab->page[i].used, MTHCA_DB_REC_PER_PAGE))
+			mthca_warn(dev, "Kernel UARC page %d not empty\n", i);
+
+		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, i), 1, &status);
+		
+		dma_free_coherent(&dev->pdev->dev, 4096,
+				  dev->db_tab->page[i].db_rec,
+				  dev->db_tab->page[i].mapping);
+	}
+
+	kfree(dev->db_tab->page);
+	kfree(dev->db_tab);
+}
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-03-03 14:12:56.773597912 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-03-03 14:12:59.078097683 -0800
@@ -125,4 +125,37 @@
 	return sg_dma_len(&iter->chunk->mem[iter->page_idx]);
 }
 
+enum {
+	MTHCA_DB_REC_PER_PAGE = 4096 / 8
+};
+
+struct mthca_db_page {
+	DECLARE_BITMAP(used, MTHCA_DB_REC_PER_PAGE);
+	u64       *db_rec;
+	dma_addr_t mapping;
+};
+
+struct mthca_db_table {
+	int 	       	      npages;
+	int 	       	      max_group1;
+	int 	       	      min_group2;
+	struct mthca_db_page *page;
+	struct semaphore      mutex;
+};
+
+enum {
+	MTHCA_DB_TYPE_INVALID   = 0x0,
+	MTHCA_DB_TYPE_CQ_SET_CI = 0x1,
+	MTHCA_DB_TYPE_CQ_ARM    = 0x2,
+	MTHCA_DB_TYPE_SQ        = 0x3,
+	MTHCA_DB_TYPE_RQ        = 0x4,
+	MTHCA_DB_TYPE_SRQ       = 0x5,
+	MTHCA_DB_TYPE_GROUP_SEP = 0x7
+};
+
+int mthca_init_db_tab(struct mthca_dev *dev);
+void mthca_cleanup_db_tab(struct mthca_dev *dev);
+int mthca_alloc_db(struct mthca_dev *dev, int type, u32 qn, u32 **db);
+void mthca_free_db(struct mthca_dev *dev, int type, int db_index);
+
 #endif /* MTHCA_MEMFREE_H */
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_profile.c	2005-03-03 14:12:56.153732464 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_profile.c	2005-03-03 14:12:59.078097683 -0800
@@ -244,9 +244,11 @@
 			dev->av_table.num_ddr_avs = profile[i].num;
 			break;
 		case MTHCA_RES_UARC:
-			init_hca->uarc_base   = profile[i].start;
-			init_hca->log_uarc_sz = ffs(request->uarc_size) - 13;
-			init_hca->log_uar_sz  = ffs(request->num_uar) - 1;
+			dev->uar_table.uarc_size = request->uarc_size;
+			dev->uar_table.uarc_base = profile[i].start;
+			init_hca->uarc_base   	 = profile[i].start;
+			init_hca->log_uarc_sz 	 = ffs(request->uarc_size) - 13;
+			init_hca->log_uar_sz  	 = ffs(request->num_uar) - 1;
 			break;
 		default:
 			break;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_uar.c	2005-03-03 14:12:56.152732681 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_uar.c	2005-03-03 14:12:59.078097683 -0800
@@ -33,6 +33,7 @@
  */
 
 #include "mthca_dev.h"
+#include "mthca_memfree.h"
 
 int mthca_uar_alloc(struct mthca_dev *dev, struct mthca_uar *uar)
 {
@@ -58,12 +59,20 @@
 			       dev->limits.num_uars,
 			       dev->limits.num_uars - 1,
 			       dev->limits.reserved_uars);
+	if (ret)
+		return ret;
+
+	ret = mthca_init_db_tab(dev);
+	if (ret)
+		mthca_alloc_cleanup(&dev->uar_table.alloc);
 
 	return ret;
 }
 
 void mthca_cleanup_uar_table(struct mthca_dev *dev)
 {
+	mthca_cleanup_db_tab(dev);
+
 	/* XXX check if any UARs are still allocated? */
 	mthca_alloc_cleanup(&dev->uar_table.alloc);
 }

