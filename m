Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVALW3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVALW3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVALWGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:06:53 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261488AbVALVsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:11 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.gzXWVDbfUCDwWmdf@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:47 -0800
Message-Id: <20051121347.kR765yQEXhqhoLHL@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][4/18] InfiniBand/mthca: clean up allocation mapping of HCA context memory
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:48.0923 (UTC) FILETIME=[5BCD30B0:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the way we allocate and map memory for use as ICM ("InfiniHost Context 
Memory") when running in Arbel MemFree mode.  This slightly improves the code for 
mapping the firmware area and will make future progress towards full MemFree 
support much easier.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/hw/mthca/mthca_dev.h	(revision 1425)
+++ linux/drivers/infiniband/hw/mthca/mthca_dev.h	(revision 1426)
@@ -40,7 +40,6 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <asm/semaphore.h>
-#include <asm/scatterlist.h>
 
 #include "mthca_provider.h"
 #include "mthca_doorbell.h"
@@ -214,7 +213,7 @@
 			u64 clr_int_base;
 			u64 eq_arm_base;
 			u64 eq_set_ci_base;
-			struct scatterlist *mem;
+			struct mthca_icm *icm;
 			u16 fw_pages;
 		}        arbel;
 	}                fw;
--- linux/drivers/infiniband/hw/mthca/mthca_main.c	(revision 1425)
+++ linux/drivers/infiniband/hw/mthca/mthca_main.c	(revision 1426)
@@ -48,6 +48,7 @@
 #include "mthca_config_reg.h"
 #include "mthca_cmd.h"
 #include "mthca_profile.h"
+#include "mthca_memfree.h"
 
 MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("Mellanox InfiniBand HCA low-level driver");
@@ -259,75 +260,26 @@
 {
 	u8 status;
 	int err;
-	int num_ent, num_sg, fw_pages, cur_order;
-	int i;
 
 	/* FIXME: use HCA-attached memory for FW if present */
 
-	mdev->fw.arbel.mem = kmalloc(sizeof *mdev->fw.arbel.mem *
-				     mdev->fw.arbel.fw_pages,
-				     GFP_KERNEL);
-	if (!mdev->fw.arbel.mem) {
+	mdev->fw.arbel.icm =
+		mthca_alloc_icm(mdev, mdev->fw.arbel.fw_pages,
+				GFP_HIGHUSER | __GFP_NOWARN);
+	if (!mdev->fw.arbel.icm) {
 		mthca_err(mdev, "Couldn't allocate FW area, aborting.\n");
 		return -ENOMEM;
 	}
 
-	memset(mdev->fw.arbel.mem, 0,
-	       sizeof *mdev->fw.arbel.mem * mdev->fw.arbel.fw_pages);
-
-	fw_pages = mdev->fw.arbel.fw_pages;
-	num_ent = 0;
-
-	/*
-	 * We allocate in as big chunks as we can, up to a maximum of
-	 * 256 KB per chunk.
-	 */
-	cur_order = get_order(1 << 18);
-
-	while (fw_pages > 0) {
-		while (1 << cur_order > fw_pages)
-			--cur_order;
-
-		/*
-		 * We allocate with GFP_HIGHUSER because only the
-		 * firmware is going to touch these pages, so there's
-		 * no need for a kernel virtual address.  We use
-		 * __GFP_NOWARN because we'll deal with any allocation
-		 * failures ourselves.
-		 */
-		mdev->fw.arbel.mem[num_ent].page   = alloc_pages(GFP_HIGHUSER | __GFP_NOWARN,
-								 cur_order);
-		mdev->fw.arbel.mem[num_ent].length = PAGE_SIZE << cur_order;
-		if (!mdev->fw.arbel.mem[num_ent].page) {
-			--cur_order;
-			if (cur_order < 0) {
-				mthca_err(mdev, "Couldn't allocate FW area, aborting.\n");
-				err = -ENOMEM;
-				goto err_free;
-			}
-		} else {
-			++num_ent;
-			fw_pages -= 1 << cur_order;
-		}
-	}
-
-	num_sg = pci_map_sg(mdev->pdev, mdev->fw.arbel.mem, num_ent,
-			    PCI_DMA_BIDIRECTIONAL);
-	if (num_sg <= 0) {
-		mthca_err(mdev, "Couldn't allocate FW area, aborting.\n");
-		err = -ENOMEM;
-		goto err_free;
-	}
-
-	err = mthca_MAP_FA(mdev, num_sg, mdev->fw.arbel.mem, &status);
+	err = mthca_MAP_FA(mdev, mdev->fw.arbel.icm, &status);
 	if (err) {
 		mthca_err(mdev, "MAP_FA command failed, aborting.\n");
-		goto err_unmap;
+		goto err_free;
 	}
 	if (status) {
 		mthca_err(mdev, "MAP_FA returned status 0x%02x, aborting.\n", status);
 		err = -EINVAL;
-		goto err_unmap;
+		goto err_free;
 	}
 	err = mthca_RUN_FW(mdev, &status);
 	if (err) {
@@ -345,15 +297,8 @@
 err_unmap_fa:
 	mthca_UNMAP_FA(mdev, &status);
 
-err_unmap:
-	pci_unmap_sg(mdev->pdev, mdev->fw.arbel.mem,
-		   mdev->fw.arbel.fw_pages, PCI_DMA_BIDIRECTIONAL);
 err_free:
-	for (i = 0; i < mdev->fw.arbel.fw_pages; ++i)
-		if (mdev->fw.arbel.mem[i].page)
-			__free_pages(mdev->fw.arbel.mem[i].page,
-				     get_order(mdev->fw.arbel.mem[i].length));
-	kfree(mdev->fw.arbel.mem);
+	mthca_free_icm(mdev, mdev->fw.arbel.icm);
 	return err;
 }
 
@@ -397,13 +342,17 @@
 	err = mthca_dev_lim(mdev, &dev_lim);
 	if (err) {
 		mthca_err(mdev, "QUERY_DEV_LIM command failed, aborting.\n");
-		goto err_out_disable;
+		goto err_out_stop_fw;
 	}
 
 	mthca_warn(mdev, "Sorry, native MT25208 mode support is not done, "
 		   "aborting.\n");
 	err = -ENODEV;
 
+err_out_stop_fw:
+	mthca_UNMAP_FA(mdev, &status);
+	mthca_free_icm(mdev, mdev->fw.arbel.icm);
+
 err_out_disable:
 	if (!(mdev->mthca_flags & MTHCA_FLAG_NO_LAM))
 		mthca_DISABLE_LAM(mdev, &status);
@@ -610,22 +559,13 @@
 static void mthca_close_hca(struct mthca_dev *mdev)
 {
 	u8 status;
-	int i;
 
 	mthca_CLOSE_HCA(mdev, 0, &status);
 
 	if (mdev->hca_type == ARBEL_NATIVE) {
 		mthca_UNMAP_FA(mdev, &status);
+		mthca_free_icm(mdev, mdev->fw.arbel.icm);
 
-		pci_unmap_sg(mdev->pdev, mdev->fw.arbel.mem,
-			     mdev->fw.arbel.fw_pages, PCI_DMA_BIDIRECTIONAL);
-
-		for (i = 0; i < mdev->fw.arbel.fw_pages; ++i)
-			if (mdev->fw.arbel.mem[i].page)
-				__free_pages(mdev->fw.arbel.mem[i].page,
-					     get_order(mdev->fw.arbel.mem[i].length));
-		kfree(mdev->fw.arbel.mem);
-
 		if (!(mdev->mthca_flags & MTHCA_FLAG_NO_LAM))
 			mthca_DISABLE_LAM(mdev, &status);
 	} else
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/infiniband/hw/mthca/mthca_memfree.h	(revision 1426)
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * $Id$
+ */
+
+#ifndef MTHCA_MEMFREE_H
+#define MTHCA_MEMFREE_H
+
+#include <linux/list.h>
+#include <linux/pci.h>
+
+#define MTHCA_ICM_CHUNK_LEN \
+	((512 - sizeof (struct list_head) - 2 * sizeof (int)) /		\
+	 (sizeof (struct scatterlist)))
+
+struct mthca_icm_chunk {
+	struct list_head   list;
+	int                npages;
+	int                nsg;
+	struct scatterlist mem[MTHCA_ICM_CHUNK_LEN];
+};
+
+struct mthca_icm {
+	struct list_head chunk_list;
+};
+
+struct mthca_icm_iter {
+	struct mthca_icm       *icm;
+	struct mthca_icm_chunk *chunk;
+	int                     page_idx;
+};
+
+struct mthca_dev;
+
+struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
+				  unsigned int gfp_mask);
+void mthca_free_icm(struct mthca_dev *dev, struct mthca_icm *icm);
+
+static inline void mthca_icm_first(struct mthca_icm *icm,
+				   struct mthca_icm_iter *iter)
+{
+	iter->icm      = icm;
+	iter->chunk    = list_empty(&icm->chunk_list) ?
+		NULL : list_entry(icm->chunk_list.next,
+				  struct mthca_icm_chunk, list);
+	iter->page_idx = 0;
+}
+
+static inline int mthca_icm_last(struct mthca_icm_iter *iter)
+{
+	return !iter->chunk;
+}
+
+static inline void mthca_icm_next(struct mthca_icm_iter *iter)
+{
+	if (++iter->page_idx >= iter->chunk->nsg) {
+		if (iter->chunk->list.next == &iter->icm->chunk_list) {
+			iter->chunk = NULL;
+			return;
+		}
+
+		iter->chunk = list_entry(iter->chunk->list.next,
+					 struct mthca_icm_chunk, list);
+		iter->page_idx = 0;
+	}
+}
+
+static inline dma_addr_t mthca_icm_addr(struct mthca_icm_iter *iter)
+{
+	return sg_dma_address(&iter->chunk->mem[iter->page_idx]);
+}
+
+static inline unsigned long mthca_icm_size(struct mthca_icm_iter *iter)
+{
+	return sg_dma_len(&iter->chunk->mem[iter->page_idx]);
+}
+
+#endif /* MTHCA_MEMFREE_H */
--- linux/drivers/infiniband/hw/mthca/mthca_cmd.c	(revision 1425)
+++ linux/drivers/infiniband/hw/mthca/mthca_cmd.c	(revision 1426)
@@ -40,6 +40,7 @@
 #include "mthca_dev.h"
 #include "mthca_config_reg.h"
 #include "mthca_cmd.h"
+#include "mthca_memfree.h"
 
 #define CMD_POLL_TOKEN 0xffff
 
@@ -508,38 +509,38 @@
 	return mthca_cmd(dev, 0, 0, 0, CMD_SYS_DIS, HZ, status);
 }
 
-int mthca_MAP_FA(struct mthca_dev *dev, int count,
-		 struct scatterlist *sglist, u8 *status)
+int mthca_MAP_FA(struct mthca_dev *dev, struct mthca_icm *icm, u8 *status)
 {
 	u32 *inbox;
 	dma_addr_t indma;
+	struct mthca_icm_iter iter;
 	int lg;
 	int nent = 0;
-	int i, j;
+	int i;
 	int err = 0;
 	int ts = 0;
 
 	inbox = pci_alloc_consistent(dev->pdev, PAGE_SIZE, &indma);
 	memset(inbox, 0, PAGE_SIZE);
 
-	for (i = 0; i < count; ++i) {
+	for (mthca_icm_first(icm, &iter); !mthca_icm_last(&iter); mthca_icm_next(&iter)) {
 		/*
 		 * We have to pass pages that are aligned to their
 		 * size, so find the least significant 1 in the
 		 * address or size and use that as our log2 size.
 		 */
-		lg = ffs(sg_dma_address(sglist + i) | sg_dma_len(sglist + i)) - 1;
+		lg = ffs(mthca_icm_addr(&iter) | mthca_icm_size(&iter)) - 1;
 		if (lg < 12) {
-			mthca_warn(dev, "Got FW area not aligned to 4K (%llx/%x).\n",
-				   (unsigned long long) sg_dma_address(sglist + i),
-				   sg_dma_len(sglist + i));
+			mthca_warn(dev, "Got FW area not aligned to 4K (%llx/%lx).\n",
+				   (unsigned long long) mthca_icm_addr(&iter),
+				   mthca_icm_size(&iter));
 			err = -EINVAL;
 			goto out;
 		}
-		for (j = 0; j < sg_dma_len(sglist + i) / (1 << lg); ++j, ++nent) {
+		for (i = 0; i < mthca_icm_size(&iter) / (1 << lg); ++i, ++nent) {
 			*((__be64 *) (inbox + nent * 4 + 2)) =
-				cpu_to_be64((sg_dma_address(sglist + i) +
-					     (j << lg)) |
+				cpu_to_be64((mthca_icm_addr(&iter) +
+					     (i << lg)) |
 					    (lg - 12));
 			ts += 1 << (lg - 10);
 			if (nent == PAGE_SIZE / 16) {
--- linux/drivers/infiniband/hw/mthca/mthca_cmd.h	(revision 1425)
+++ linux/drivers/infiniband/hw/mthca/mthca_cmd.h	(revision 1426)
@@ -219,8 +219,7 @@
 
 int mthca_SYS_EN(struct mthca_dev *dev, u8 *status);
 int mthca_SYS_DIS(struct mthca_dev *dev, u8 *status);
-int mthca_MAP_FA(struct mthca_dev *dev, int count,
-		 struct scatterlist *sglist, u8 *status);
+int mthca_MAP_FA(struct mthca_dev *dev, struct mthca_icm *icm, u8 *status);
 int mthca_UNMAP_FA(struct mthca_dev *dev, u8 *status);
 int mthca_RUN_FW(struct mthca_dev *dev, u8 *status);
 int mthca_QUERY_FW(struct mthca_dev *dev, u8 *status);
--- linux/drivers/infiniband/hw/mthca/Makefile	(revision 1425)
+++ linux/drivers/infiniband/hw/mthca/Makefile	(revision 1426)
@@ -9,4 +9,4 @@
 ib_mthca-y :=	mthca_main.o mthca_cmd.o mthca_profile.o mthca_reset.o \
 		mthca_allocator.o mthca_eq.o mthca_pd.o mthca_cq.o \
 		mthca_mr.o mthca_qp.o mthca_av.o mthca_mcg.o mthca_mad.o \
-		mthca_provider.o
+		mthca_provider.o mthca_memfree.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/infiniband/hw/mthca/mthca_memfree.c	(revision 1426)
@@ -0,0 +1,133 @@
+/*
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * $Id$
+ */
+
+#include "mthca_memfree.h"
+#include "mthca_dev.h"
+
+void mthca_free_icm(struct mthca_dev *dev, struct mthca_icm *icm)
+{
+	struct mthca_icm_chunk *chunk, *tmp;
+	int i;
+
+	if (!icm)
+		return;
+
+	list_for_each_entry_safe(chunk, tmp, &icm->chunk_list, list) {
+		if (chunk->nsg > 0)
+			pci_unmap_sg(dev->pdev, chunk->mem, chunk->npages,
+				     PCI_DMA_BIDIRECTIONAL);
+
+		for (i = 0; i < chunk->npages; ++i)
+			__free_pages(chunk->mem[i].page,
+				     get_order(chunk->mem[i].length));
+
+		kfree(chunk);
+	}
+
+	kfree(icm);
+}
+
+struct mthca_icm *mthca_alloc_icm(struct mthca_dev *dev, int npages,
+				  unsigned int gfp_mask)
+{
+	struct mthca_icm *icm;
+	struct mthca_icm_chunk *chunk = NULL;
+	int cur_order;
+
+	icm = kmalloc(sizeof *icm, gfp_mask & ~(__GFP_HIGHMEM | __GFP_NOWARN));
+	if (!icm)
+		return icm;
+
+	INIT_LIST_HEAD(&icm->chunk_list);
+
+	/*
+	 * We allocate in as big chunks as we can, up to a maximum of
+	 * 256 KB per chunk.
+	 */
+	cur_order = get_order(1 << 18);
+
+	while (npages > 0) {
+		if (!chunk) {
+			chunk = kmalloc(sizeof *chunk,
+					gfp_mask & ~(__GFP_HIGHMEM | __GFP_NOWARN));
+			if (!chunk)
+				goto fail;
+
+			chunk->npages = 0;
+			chunk->nsg    = 0;
+			list_add_tail(&chunk->list, &icm->chunk_list);
+		}
+
+		while (1 << cur_order > npages)
+			--cur_order;
+
+		chunk->mem[chunk->npages].page = alloc_pages(gfp_mask, cur_order);
+		if (chunk->mem[chunk->npages].page) {
+			chunk->mem[chunk->npages].length = PAGE_SIZE << cur_order;
+			chunk->mem[chunk->npages].offset = 0;
+
+			if (++chunk->npages == MTHCA_ICM_CHUNK_LEN) {
+				chunk->nsg = pci_map_sg(dev->pdev, chunk->mem,
+							chunk->npages,
+							PCI_DMA_BIDIRECTIONAL);
+
+				if (chunk->nsg <= 0)
+					goto fail;
+
+				chunk = NULL;
+			}
+
+			npages -= 1 << cur_order;
+		} else {
+			--cur_order;
+			if (cur_order < 0)
+				goto fail;
+		}
+	}
+
+	if (chunk) {
+		chunk->nsg = pci_map_sg(dev->pdev, chunk->mem,
+					chunk->npages,
+					PCI_DMA_BIDIRECTIONAL);
+
+		if (chunk->nsg <= 0)
+			goto fail;
+	}
+
+	return icm;
+
+fail:
+	mthca_free_icm(dev, icm);
+	return NULL;
+}
 

