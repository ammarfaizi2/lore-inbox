Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbVKXD4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbVKXD4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVKXD4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:56:36 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:12362 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S1030587AbVKXD4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:56:35 -0500
Date: Thu, 24 Nov 2005 05:56:28 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH 1/3] move swiotlb header file into common code - generic bits
In-reply-to: <20051124035544.GA5913@granada.merseine.nu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>, Andi Kleen <ak@suse.de>,
       Tony Luck <tony.luck@intel.com>
Message-id: <20051124035628.GB5913@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20051124035544.GA5913@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>

muli@granada:~/tmp$ diffstat move-swiotlb-into-generic-code-generic-bits-A1
 include/asm-generic/swiotlb.h      |   60 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-data-direction.h |   13 ++++++++
 include/linux/dma-mapping.h        |   10 ------
 lib/swiotlb.c                      |   36 +++++++++++-----------
 4 files changed, 93 insertions(+), 26 deletions(-)

---

diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-generic/swiotlb.h dma_data_direction.hg/include/asm-generic/swiotlb.h
--- vanilla/include/asm-generic/swiotlb.h	1969-12-31 19:00:00.000000000 -0500
+++ dma_data_direction.hg/include/asm-generic/swiotlb.h	2005-11-21 13:32:14.000000000 -0500
@@ -0,0 +1,60 @@
+#ifndef _ASM_GENERIC_SWIOTLB_H
+#define _ASM_GENERIC_SWTIOLB_H 1
+
+#include <linux/dma-data-direction.h>
+
+struct device;
+struct scatterlist;
+
+extern dma_addr_t
+swiotlb_map_single(struct device *hwdev, void *ptr, size_t size,
+        enum dma_data_direction dir);
+
+extern void
+swiotlb_unmap_single(struct device *hwdev, dma_addr_t dev_addr, size_t size,
+        enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr, size_t size,
+       enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
+       size_t size, enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
+       unsigned long offset, size_t size, enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_single_range_for_device(struct device *hwdev, dma_addr_t dev_addr,
+       unsigned long offset, size_t size, enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg, int nelems,
+       enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+       int nelems, enum dma_data_direction dir);
+
+extern int
+swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nents,
+       enum dma_data_direction direction);
+
+extern void
+swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
+       enum dma_data_direction direction);
+
+extern int
+swiotlb_dma_mapping_error(dma_addr_t dma_addr);
+
+extern void*
+swiotlb_alloc_coherent (struct device *hwdev, size_t size, dma_addr_t *dma_handle,
+       gfp_t flags);
+
+extern void
+swiotlb_free_coherent (struct device *hwdev, size_t size, void *vaddr,
+       dma_addr_t dma_handle);
+
+#endif /* _ASM_GENERIC_SWTIOLB_H */
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/linux/dma-data-direction.h dma_data_direction.hg/include/linux/dma-data-direction.h
--- vanilla/include/linux/dma-data-direction.h	1969-12-31 19:00:00.000000000 -0500
+++ dma_data_direction.hg/include/linux/dma-data-direction.h	2005-11-21 13:31:18.000000000 -0500
@@ -0,0 +1,13 @@
+#ifndef _ASM_LINUX_DMA_DATA_DIRECTION_H
+#define _ASM_LINUX_DMA_DATA_DIRECTION_H
+
+/* These definitions mirror those in pci.h, so they can be used
+ * interchangeably with their PCI_ counterparts */
+enum dma_data_direction {
+	DMA_BIDIRECTIONAL = 0,
+	DMA_TO_DEVICE = 1,
+	DMA_FROM_DEVICE = 2,
+	DMA_NONE = 3,
+};
+
+#endif /* _ASM_LINUX_DMA_DATA_DIRECTION_H */
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/linux/dma-mapping.h dma_data_direction.hg/include/linux/dma-mapping.h
--- vanilla/include/linux/dma-mapping.h	2005-09-08 07:07:32.000000000 -0400
+++ dma_data_direction.hg/include/linux/dma-mapping.h	2005-11-21 13:31:40.000000000 -0500
@@ -3,15 +3,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
-
-/* These definitions mirror those in pci.h, so they can be used
- * interchangeably with their PCI_ counterparts */
-enum dma_data_direction {
-	DMA_BIDIRECTIONAL = 0,
-	DMA_TO_DEVICE = 1,
-	DMA_FROM_DEVICE = 2,
-	DMA_NONE = 3,
-};
+#include <linux/dma-data-direction.h>
 
 #define DMA_64BIT_MASK	0xffffffffffffffffULL
 #define DMA_40BIT_MASK	0x000000ffffffffffULL
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/lib/swiotlb.c dma_data_direction.hg/lib/swiotlb.c
--- vanilla/lib/swiotlb.c	2005-11-12 15:52:15.000000000 -0500
+++ dma_data_direction.hg/lib/swiotlb.c	2005-11-18 16:24:29.000000000 -0500
@@ -280,7 +280,7 @@ address_needs_mapping(struct device *hwd
  * Allocates bounce buffer and returns its kernel virtual address.
  */
 static void *
-map_single(struct device *hwdev, char *buffer, size_t size, int dir)
+map_single(struct device *hwdev, char *buffer, size_t size, enum dma_data_direction dir)
 {
 	unsigned long flags;
 	char *dma_addr;
@@ -363,7 +363,7 @@ map_single(struct device *hwdev, char *b
  * dma_addr is the kernel virtual address of the bounce buffer to unmap.
  */
 static void
-unmap_single(struct device *hwdev, char *dma_addr, size_t size, int dir)
+unmap_single(struct device *hwdev, char *dma_addr, size_t size, enum dma_data_direction dir)
 {
 	unsigned long flags;
 	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
@@ -408,7 +408,7 @@ unmap_single(struct device *hwdev, char 
 
 static void
 sync_single(struct device *hwdev, char *dma_addr, size_t size,
-	    int dir, int target)
+	    enum dma_data_direction dir, int target)
 {
 	int index = (dma_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	char *buffer = io_tlb_orig_addr[index];
@@ -497,7 +497,7 @@ swiotlb_free_coherent(struct device *hwd
 }
 
 static void
-swiotlb_full(struct device *dev, size_t size, int dir, int do_panic)
+swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir, int do_panic)
 {
 	/*
 	 * Ran out of IOMMU space for this operation. This is very bad.
@@ -525,7 +525,7 @@ swiotlb_full(struct device *dev, size_t 
  * either swiotlb_unmap_single or swiotlb_dma_sync_single is performed.
  */
 dma_addr_t
-swiotlb_map_single(struct device *hwdev, void *ptr, size_t size, int dir)
+swiotlb_map_single(struct device *hwdev, void *ptr, size_t size, enum dma_data_direction dir)
 {
 	unsigned long dev_addr = virt_to_phys(ptr);
 	void *map;
@@ -589,7 +589,7 @@ mark_clean(void *addr, size_t size)
  */
 void
 swiotlb_unmap_single(struct device *hwdev, dma_addr_t dev_addr, size_t size,
-		     int dir)
+		     enum dma_data_direction dir)
 {
 	char *dma_addr = phys_to_virt(dev_addr);
 
@@ -613,7 +613,7 @@ swiotlb_unmap_single(struct device *hwde
  */
 static inline void
 swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
-		    size_t size, int dir, int target)
+		    size_t size, enum dma_data_direction dir, int target)
 {
 	char *dma_addr = phys_to_virt(dev_addr);
 
@@ -627,14 +627,14 @@ swiotlb_sync_single(struct device *hwdev
 
 void
 swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-			    size_t size, int dir)
+			    size_t size, enum dma_data_direction dir)
 {
 	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
 }
 
 void
 swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
-			       size_t size, int dir)
+			       size_t size, enum dma_data_direction dir)
 {
 	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
 }
@@ -645,7 +645,7 @@ swiotlb_sync_single_for_device(struct de
 static inline void
 swiotlb_sync_single_range(struct device *hwdev, dma_addr_t dev_addr,
 			  unsigned long offset, size_t size,
-			  int dir, int target)
+			  enum dma_data_direction dir, int target)
 {
 	char *dma_addr = phys_to_virt(dev_addr) + offset;
 
@@ -659,7 +659,8 @@ swiotlb_sync_single_range(struct device 
 
 void
 swiotlb_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-				  unsigned long offset, size_t size, int dir)
+				  unsigned long offset, size_t size,
+				  enum dma_data_direction dir)
 {
 	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir,
 				  SYNC_FOR_CPU);
@@ -667,7 +668,8 @@ swiotlb_sync_single_range_for_cpu(struct
 
 void
 swiotlb_sync_single_range_for_device(struct device *hwdev, dma_addr_t dev_addr,
-				     unsigned long offset, size_t size, int dir)
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir)
 {
 	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir,
 				  SYNC_FOR_DEVICE);
@@ -691,7 +693,7 @@ swiotlb_sync_single_range_for_device(str
  */
 int
 swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nelems,
-	       int dir)
+	       enum dma_data_direction dir)
 {
 	void *addr;
 	unsigned long dev_addr;
@@ -726,7 +728,7 @@ swiotlb_map_sg(struct device *hwdev, str
  */
 void
 swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nelems,
-		 int dir)
+		 enum dma_data_direction dir)
 {
 	int i;
 
@@ -749,7 +751,7 @@ swiotlb_unmap_sg(struct device *hwdev, s
  */
 static inline void
 swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sg,
-		int nelems, int dir, int target)
+		int nelems, enum dma_data_direction dir, int target)
 {
 	int i;
 
@@ -764,14 +766,14 @@ swiotlb_sync_sg(struct device *hwdev, st
 
 void
 swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			int nelems, int dir)
+			int nelems, enum dma_data_direction dir)
 {
 	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
 }
 
 void
 swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
-			   int nelems, int dir)
+			   int nelems, enum dma_data_direction dir)
 {
 	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
 }


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

