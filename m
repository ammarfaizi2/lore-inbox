Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVIZVCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVIZVCB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVIZVCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:02:01 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:56328 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750807AbVIZVCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:02:00 -0400
Date: Mon, 26 Sep 2005 17:01:20 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Cc: ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com, gregkh@suse.de
Subject: [patch 2.6.14-rc2 3/5] swiotlb: support syncing sub-ranges of mappings
Message-ID: <09262005170120.15812@bilbo.tuxdriver.com>
In-Reply-To: <09262005170120.15749@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements swiotlb_sync_single_range_for_{cpu,device}. This
is intended to support an x86_64 implementation of
dma_sync_single_range_for_{cpu,device}.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/pci/swiotlb.c        |   33 +++++++++++++++++++++++++++++++++
 include/asm-x86_64/swiotlb.h |    8 ++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/pci/swiotlb.c b/drivers/pci/swiotlb.c
--- a/drivers/pci/swiotlb.c
+++ b/drivers/pci/swiotlb.c
@@ -521,6 +521,37 @@ swiotlb_sync_single_for_device(struct de
 }
 
 /*
+ * Same as above, but for a sub-range of the mapping.
+ */
+static inline void
+swiotlb_sync_single_range(struct device *hwdev, dma_addr_t dev_addr,
+			  unsigned long offset, size_t size, int dir)
+{
+	char *dma_addr = phys_to_virt(dev_addr) + offset;
+
+	if (dir == DMA_NONE)
+		BUG();
+	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
+		sync_single(hwdev, dma_addr, size, dir);
+	else if (dir == DMA_FROM_DEVICE)
+		mark_clean(dma_addr, size);
+}
+
+void
+swiotlb_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
+				  unsigned long offset, size_t size, int dir)
+{
+	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir);
+}
+
+void
+swiotlb_sync_single_range_for_device(struct device *hwdev, dma_addr_t dev_addr,
+				     unsigned long offset, size_t size, int dir)
+{
+	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir);
+}
+
+/*
  * Map a set of buffers described by scatterlist in streaming mode for DMA.
  * This is the scatter-gather version of the above swiotlb_map_single
  * interface.  Here the scatter gather list elements are each tagged with the
@@ -648,6 +679,8 @@ EXPORT_SYMBOL(swiotlb_map_sg);
 EXPORT_SYMBOL(swiotlb_unmap_sg);
 EXPORT_SYMBOL(swiotlb_sync_single_for_cpu);
 EXPORT_SYMBOL(swiotlb_sync_single_for_device);
+EXPORT_SYMBOL_GPL(swiotlb_sync_single_range_for_cpu);
+EXPORT_SYMBOL_GPL(swiotlb_sync_single_range_for_device);
 EXPORT_SYMBOL(swiotlb_sync_sg_for_cpu);
 EXPORT_SYMBOL(swiotlb_sync_sg_for_device);
 EXPORT_SYMBOL(swiotlb_dma_mapping_error);
diff --git a/include/asm-x86_64/swiotlb.h b/include/asm-x86_64/swiotlb.h
--- a/include/asm-x86_64/swiotlb.h
+++ b/include/asm-x86_64/swiotlb.h
@@ -15,6 +15,14 @@ extern void swiotlb_sync_single_for_cpu(
 extern void swiotlb_sync_single_for_device(struct device *hwdev,
 					    dma_addr_t dev_addr,
 					    size_t size, int dir);
+extern void swiotlb_sync_single_range_for_cpu(struct device *hwdev,
+					      dma_addr_t dev_addr,
+					      unsigned long offset,
+					      size_t size, int dir);
+extern void swiotlb_sync_single_range_for_device(struct device *hwdev,
+						 dma_addr_t dev_addr,
+						 unsigned long offset,
+						 size_t size, int dir);
 extern void swiotlb_sync_sg_for_cpu(struct device *hwdev,
 				     struct scatterlist *sg, int nelems,
 				     int dir);
