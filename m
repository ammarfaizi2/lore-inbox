Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVILOzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVILOzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVILOzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:55:37 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:3079 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751263AbVILOz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:55:26 -0400
Date: Mon, 12 Sep 2005 10:48:50 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org
Cc: ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com
Subject: [patch 2.6.13 2/6] swiotlb: cleanup some code duplication cruft
Message-ID: <09122005104850.30992@bilbo.tuxdriver.com>
In-Reply-To: <09122005104850.30928@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The implementations of swiotlb_sync_single_for_{cpu,device} are
identical. Likewise for swiotlb_syng_sg_for_{cpu,device}. This patch
move the guts of those functions to two new inline functions, and
calls the appropriate one from the bodies of those functions.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 lib/swiotlb.c |   45 ++++++++++++++++++++++-----------------------
 1 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -492,9 +492,9 @@ swiotlb_unmap_single(struct device *hwde
  * address back to the card, you must first perform a
  * swiotlb_dma_sync_for_device, and then the device again owns the buffer
  */
-void
-swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-			    size_t size, int dir)
+static inline void
+swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
+		    size_t size, int dir)
 {
 	char *dma_addr = phys_to_virt(dev_addr);
 
@@ -507,17 +507,17 @@ swiotlb_sync_single_for_cpu(struct devic
 }
 
 void
+swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
+			    size_t size, int dir)
+{
+	swiotlb_sync_single(hwdev, dev_addr, size, dir);
+}
+
+void
 swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 			       size_t size, int dir)
 {
-	char *dma_addr = phys_to_virt(dev_addr);
-
-	if (dir == DMA_NONE)
-		BUG();
-	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
-		sync_single(hwdev, dma_addr, size, dir);
-	else if (dir == DMA_FROM_DEVICE)
-		mark_clean(dma_addr, size);
+	swiotlb_sync_single(hwdev, dev_addr, size, dir);
 }
 
 /*
@@ -594,9 +594,9 @@ swiotlb_unmap_sg(struct device *hwdev, s
  * The same as swiotlb_sync_single_* but for a scatter-gather list, same rules
  * and usage.
  */
-void
-swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			int nelems, int dir)
+static inline void
+swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sg,
+		int nelems, int dir)
 {
 	int i;
 
@@ -610,18 +610,17 @@ swiotlb_sync_sg_for_cpu(struct device *h
 }
 
 void
+swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
+			int nelems, int dir)
+{
+	swiotlb_sync_sg(hwdev, sg, nelems, dir);
+}
+
+void
 swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
 			   int nelems, int dir)
 {
-	int i;
-
-	if (dir == DMA_NONE)
-		BUG();
-
-	for (i = 0; i < nelems; i++, sg++)
-		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
-			sync_single(hwdev, (void *) sg->dma_address,
-				    sg->dma_length, dir);
+	swiotlb_sync_sg(hwdev, sg, nelems, dir);
 }
 
 int
