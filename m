Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVCDCp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVCDCp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVCCXmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:42:06 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262743AbVCCXWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:30 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][21/26] IB/mthca: mem-free address vectors
In-Reply-To: <2005331520.7k4CdyDk307HOUr6@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.kqgduGt72iMbbNeg@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0347 (UTC) FILETIME=[962178B0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update address vector handling to support mem-free mode.  In mem-free
mode, the address vector (in hardware format) is copied by the driver
into each send work queue entry, so our address handle creation can
become pretty trivial: we just kmalloc() a buffer to hold the
formatted address vector.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_av.c	2005-01-15 15:19:30.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_av.c	2005-03-03 14:13:02.121437076 -0800
@@ -60,27 +60,34 @@
 	u32 index = -1;
 	struct mthca_av *av = NULL;
 
-	ah->on_hca = 0;
+	ah->type = MTHCA_AH_PCI_POOL;
 
-	if (!atomic_read(&pd->sqp_count) &&
-	    !(dev->mthca_flags & MTHCA_FLAG_DDR_HIDDEN)) {
+	if (dev->hca_type == ARBEL_NATIVE) {
+		ah->av   = kmalloc(sizeof *ah->av, GFP_KERNEL);
+		if (!ah->av)
+			return -ENOMEM;
+
+		ah->type = MTHCA_AH_KMALLOC;
+		av       = ah->av;
+	} else if (!atomic_read(&pd->sqp_count) &&
+		 !(dev->mthca_flags & MTHCA_FLAG_DDR_HIDDEN)) {
 		index = mthca_alloc(&dev->av_table.alloc);
 
 		/* fall back to allocate in host memory */
 		if (index == -1)
-			goto host_alloc;
+			goto on_hca_fail;
 
 		av = kmalloc(sizeof *av, GFP_KERNEL);
 		if (!av)
-			goto host_alloc;
+			goto on_hca_fail;
 
-		ah->on_hca = 1;
+		ah->type = MTHCA_AH_ON_HCA;
 		ah->avdma  = dev->av_table.ddr_av_base +
 			index * MTHCA_AV_SIZE;
 	}
 
- host_alloc:
-	if (!ah->on_hca) {
+on_hca_fail:
+	if (ah->type == MTHCA_AH_PCI_POOL) {
 		ah->av = pci_pool_alloc(dev->av_table.pool,
 					SLAB_KERNEL, &ah->avdma);
 		if (!ah->av)
@@ -123,7 +130,7 @@
 			       j * 4, be32_to_cpu(((u32 *) av)[j]));
 	}
 
-	if (ah->on_hca) {
+	if (ah->type == MTHCA_AH_ON_HCA) {
 		memcpy_toio(dev->av_table.av_map + index * MTHCA_AV_SIZE,
 			    av, MTHCA_AV_SIZE);
 		kfree(av);
@@ -134,12 +141,21 @@
 
 int mthca_destroy_ah(struct mthca_dev *dev, struct mthca_ah *ah)
 {
-	if (ah->on_hca)
+	switch (ah->type) {
+	case MTHCA_AH_ON_HCA:
 		mthca_free(&dev->av_table.alloc,
  			   (ah->avdma - dev->av_table.ddr_av_base) /
 			   MTHCA_AV_SIZE);
-	else
+		break;
+
+	case MTHCA_AH_PCI_POOL:
 		pci_pool_free(dev->av_table.pool, ah->av, ah->avdma);
+		break;
+
+	case MTHCA_AH_KMALLOC:
+		kfree(ah->av);
+		break;
+	}
 
 	return 0;
 }
@@ -147,7 +163,7 @@
 int mthca_read_ah(struct mthca_dev *dev, struct mthca_ah *ah,
 		  struct ib_ud_header *header)
 {
-	if (ah->on_hca)
+	if (ah->type == MTHCA_AH_ON_HCA)
 		return -EINVAL;
 
 	header->lrh.service_level   = be32_to_cpu(ah->av->sl_tclass_flowlabel) >> 28;
@@ -176,6 +192,9 @@
 {
 	int err;
 
+	if (dev->hca_type == ARBEL_NATIVE)
+		return 0;
+
 	err = mthca_alloc_init(&dev->av_table.alloc,
 			       dev->av_table.num_ddr_avs,
 			       dev->av_table.num_ddr_avs - 1,
@@ -212,6 +231,9 @@
 
 void __devexit mthca_cleanup_av_table(struct mthca_dev *dev)
 {
+	if (dev->hca_type == ARBEL_NATIVE)
+		return;
+
 	if (dev->av_table.av_map)
 		iounmap(dev->av_table.av_map);
 	pci_pool_destroy(dev->av_table.pool);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:01.712525837 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:02.120437293 -0800
@@ -82,12 +82,18 @@
 
 struct mthca_av;
 
+enum mthca_ah_type {
+	MTHCA_AH_ON_HCA,
+	MTHCA_AH_PCI_POOL,
+	MTHCA_AH_KMALLOC
+};
+
 struct mthca_ah {
-	struct ib_ah     ibah;
-	int              on_hca;
-	u32              key;
-	struct mthca_av *av;
-	dma_addr_t       avdma;
+	struct ib_ah       ibah;
+	enum mthca_ah_type type;
+	u32                key;
+	struct mthca_av   *av;
+	dma_addr_t         avdma;
 };
 
 /*

