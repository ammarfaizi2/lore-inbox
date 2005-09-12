Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVILOy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVILOy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVILOy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:54:57 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:775 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751230AbVILOy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:54:56 -0400
Date: Mon, 12 Sep 2005 10:48:51 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org
Cc: ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com
Subject: [patch 2.6.13 4/6] swiotlb: support syncing DMA_BIDIRECTIONAL mappings
Message-ID: <09122005104851.31120@bilbo.tuxdriver.com>
In-Reply-To: <09122005104851.31056@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of sync_single in swiotlb.c chokes on
DMA_BIDIRECTIONAL mappings. This patch adds the capability to sync
those mappings, and optimizes other syncs by accounting for the
sync target (i.e. cpu or device) in addition to the DMA direction of
the mapping.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 lib/swiotlb.c |   62 +++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -49,6 +49,14 @@
  */
 #define IO_TLB_SHIFT 11
 
+/*
+ * Enumeration for sync targets
+ */
+enum dma_sync_target {
+	SYNC_FOR_CPU = 0,
+	SYNC_FOR_DEVICE = 1,
+};
+
 int swiotlb_force;
 
 /*
@@ -295,21 +303,28 @@ unmap_single(struct device *hwdev, char 
 }
 
 static void
-sync_single(struct device *hwdev, char *dma_addr, size_t size, int dir)
+sync_single(struct device *hwdev, char *dma_addr, size_t size,
+	    int dir, int target)
 {
 	int index = (dma_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	char *buffer = io_tlb_orig_addr[index];
 
-	/*
-	 * bounce... copy the data back into/from the original buffer
-	 * XXX How do you handle DMA_BIDIRECTIONAL here ?
-	 */
-	if (dir == DMA_FROM_DEVICE)
-		memcpy(buffer, dma_addr, size);
-	else if (dir == DMA_TO_DEVICE)
-		memcpy(dma_addr, buffer, size);
-	else
+	switch (target) {
+	case SYNC_FOR_CPU:
+		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
+			memcpy(buffer, dma_addr, size);
+		else if (dir != DMA_TO_DEVICE && dir != DMA_NONE)
+			BUG();
+		break;
+	case SYNC_FOR_DEVICE:
+		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
+			memcpy(dma_addr, buffer, size);
+		else if (dir != DMA_FROM_DEVICE && dir != DMA_NONE)
+			BUG();
+		break;
+	default:
 		BUG();
+	}
 }
 
 void *
@@ -494,14 +509,14 @@ swiotlb_unmap_single(struct device *hwde
  */
 static inline void
 swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
-		    size_t size, int dir)
+		    size_t size, int dir, int target)
 {
 	char *dma_addr = phys_to_virt(dev_addr);
 
 	if (dir == DMA_NONE)
 		BUG();
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
-		sync_single(hwdev, dma_addr, size, dir);
+		sync_single(hwdev, dma_addr, size, dir, target);
 	else if (dir == DMA_FROM_DEVICE)
 		mark_clean(dma_addr, size);
 }
@@ -510,14 +525,14 @@ void
 swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 			    size_t size, int dir)
 {
-	swiotlb_sync_single(hwdev, dev_addr, size, dir);
+	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
 }
 
 void
 swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 			       size_t size, int dir)
 {
-	swiotlb_sync_single(hwdev, dev_addr, size, dir);
+	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
 }
 
 /*
@@ -525,14 +540,15 @@ swiotlb_sync_single_for_device(struct de
  */
 static inline void
 swiotlb_sync_single_range(struct device *hwdev, dma_addr_t dev_addr,
-			  unsigned long offset, size_t size, int dir)
+			  unsigned long offset, size_t size,
+			  int dir, int target)
 {
 	char *dma_addr = phys_to_virt(dev_addr) + offset;
 
 	if (dir == DMA_NONE)
 		BUG();
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
-		sync_single(hwdev, dma_addr, size, dir);
+		sync_single(hwdev, dma_addr, size, dir, target);
 	else if (dir == DMA_FROM_DEVICE)
 		mark_clean(dma_addr, size);
 }
@@ -541,14 +557,16 @@ void
 swiotlb_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 				  unsigned long offset, size_t size, int dir)
 {
-	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir);
+	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir,
+				  SYNC_FOR_CPU);
 }
 
 void
 swiotlb_sync_single_range_for_device(struct device *hwdev, dma_addr_t dev_addr,
 				     unsigned long offset, size_t size, int dir)
 {
-	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir);
+	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir,
+				  SYNC_FOR_DEVICE);
 }
 
 /*
@@ -627,7 +645,7 @@ swiotlb_unmap_sg(struct device *hwdev, s
  */
 static inline void
 swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sg,
-		int nelems, int dir)
+		int nelems, int dir, int target)
 {
 	int i;
 
@@ -637,21 +655,21 @@ swiotlb_sync_sg(struct device *hwdev, st
 	for (i = 0; i < nelems; i++, sg++)
 		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
 			sync_single(hwdev, (void *) sg->dma_address,
-				    sg->dma_length, dir);
+				    sg->dma_length, dir, target);
 }
 
 void
 swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
 			int nelems, int dir)
 {
-	swiotlb_sync_sg(hwdev, sg, nelems, dir);
+	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
 }
 
 void
 swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
 			   int nelems, int dir)
 {
-	swiotlb_sync_sg(hwdev, sg, nelems, dir);
+	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
 }
 
 int
