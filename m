Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVKUVzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVKUVzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKUVzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:55:48 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:62267 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S1751098AbVKUVzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:55:47 -0500
Date: Mon, 21 Nov 2005 23:55:42 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [RFC PATCH 2/3] move swiotlb header file into common code - x86-64 bits
In-reply-to: <20051121215403.GF22728@granada.merseine.nu>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Message-id: <20051121215542.GG22728@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20051121215048.GE22728@granada.merseine.nu>
 <20051121215403.GF22728@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/x86_64/kernel/pci-gart.c    |   22 +++++++++++++--------
 include/asm-x86_64/dma-mapping.h |   33 +++++++++++++++++++-------------
 include/asm-x86_64/swiotlb.h     |   40 +--------------------------------------
 3 files changed, 36 insertions(+), 59 deletions(-)

---

diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/pci-gart.c dma_data_direction.hg/arch/x86_64/kernel/pci-gart.c
--- vanilla/arch/x86_64/kernel/pci-gart.c	2005-11-15 09:52:45.000000000 -0500
+++ dma_data_direction.hg/arch/x86_64/kernel/pci-gart.c	2005-11-18 16:28:06.000000000 -0500
@@ -30,6 +30,7 @@
 #include <asm/proto.h>
 #include <asm/cacheflush.h>
 #include <asm/kdebug.h>
+#include <asm/swiotlb.h>
 
 dma_addr_t bad_dma_address;
 
@@ -103,7 +104,7 @@ AGPEXTERN __u32 *agp_gatt_table;
 static unsigned long next_bit;  /* protected by iommu_bitmap_lock */
 static int need_flush; 		/* global flush state. set for each gart wrap */
 static dma_addr_t dma_map_area(struct device *dev, unsigned long phys_mem,
-			       size_t size, int dir, int do_panic);
+			       size_t size, enum dma_data_direction dir, int do_panic);
 
 /* Dummy device used for NULL arguments (normally ISA). Better would
    be probably a smaller DMA mask, but this is bug-to-bug compatible to i386. */
@@ -326,7 +327,8 @@ void dump_leak(void)
 #define CLEAR_LEAK(x)
 #endif
 
-static void iommu_full(struct device *dev, size_t size, int dir, int do_panic)
+static void iommu_full(struct device *dev, size_t size, enum dma_data_direction dir,
+		       int do_panic)
 {
 	/* 
 	 * Ran out of IOMMU space for this operation. This is very bad.
@@ -386,7 +388,8 @@ static inline int nonforced_iommu(struct
  * Caller needs to check if the iommu is needed and flush.
  */
 static dma_addr_t dma_map_area(struct device *dev, unsigned long phys_mem,
-				size_t size, int dir, int do_panic)
+				size_t size, enum dma_data_direction dir,
+			       int do_panic)
 { 
 	unsigned long npages = to_pages(phys_mem, size);
 	unsigned long iommu_page = alloc_iommu(npages);
@@ -409,7 +412,8 @@ static dma_addr_t dma_map_area(struct de
 }
 
 /* Map a single area into the IOMMU */
-dma_addr_t dma_map_single(struct device *dev, void *addr, size_t size, int dir)
+dma_addr_t dma_map_single(struct device *dev, void *addr, size_t size,
+			  enum dma_data_direction dir)
 {
 	unsigned long phys_mem, bus;
 
@@ -431,7 +435,7 @@ dma_addr_t dma_map_single(struct device 
 
 /* Fallback for dma_map_sg in case of overflow */
 static int dma_map_sg_nonforce(struct device *dev, struct scatterlist *sg,
-			       int nents, int dir)
+			       int nents, enum dma_data_direction dir)
 {
 	int i;
 
@@ -515,7 +519,8 @@ static inline int dma_map_cont(struct sc
  * DMA map all entries in a scatterlist.
  * Merge chunks that have page aligned sizes into a continuous mapping. 
  */
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
+int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	       enum dma_data_direction dir)
 {
 	int i;
 	int out;
@@ -587,7 +592,7 @@ error:
  * Free a DMA mapping.
  */ 
 void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
-		      size_t size, int direction)
+		      size_t size, enum dma_data_direction direction)
 {
 	unsigned long iommu_page; 
 	int npages;
@@ -613,7 +618,8 @@ void dma_unmap_single(struct device *dev
 /* 
  * Wrapper for pci_unmap_single working with scatterlists.
  */ 
-void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
+void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+		  enum dma_data_direction dir)
 {
 	int i;
 	if (swiotlb) {
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-x86_64/dma-mapping.h dma_data_direction.hg/include/asm-x86_64/dma-mapping.h
--- vanilla/include/asm-x86_64/dma-mapping.h	2005-11-03 01:38:45.000000000 -0500
+++ dma_data_direction.hg/include/asm-x86_64/dma-mapping.h	2005-11-18 16:29:39.000000000 -0500
@@ -24,16 +24,16 @@ void dma_free_coherent(struct device *de
 #ifdef CONFIG_GART_IOMMU
 
 extern dma_addr_t dma_map_single(struct device *hwdev, void *ptr, size_t size,
-				 int direction);
+				 enum dma_data_direction direction);
 extern void dma_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
-			     int direction);
+			     enum dma_data_direction direction);
 
 #else
 
 /* No IOMMU */
 
 static inline dma_addr_t dma_map_single(struct device *hwdev, void *ptr,
-					size_t size, int direction)
+					size_t size, enum dma_data_direction direction)
 {
 	dma_addr_t addr;
 
@@ -47,7 +47,7 @@ static inline dma_addr_t dma_map_single(
 }
 
 static inline void dma_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
-				    size_t size, int direction)
+				    size_t size, enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
 		out_of_line_bug();
@@ -61,7 +61,8 @@ static inline void dma_unmap_single(stru
 
 static inline void dma_sync_single_for_cpu(struct device *hwdev,
 					       dma_addr_t dma_handle,
-					       size_t size, int direction)
+					       size_t size,
+					       enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
 		out_of_line_bug();
@@ -74,7 +75,8 @@ static inline void dma_sync_single_for_c
 
 static inline void dma_sync_single_for_device(struct device *hwdev,
 						  dma_addr_t dma_handle,
-						  size_t size, int direction)
+						  size_t size,
+					          enum dma_data_direction direction)
 {
         if (direction == DMA_NONE)
 		out_of_line_bug();
@@ -88,7 +90,8 @@ static inline void dma_sync_single_for_d
 static inline void dma_sync_single_range_for_cpu(struct device *hwdev,
 						 dma_addr_t dma_handle,
 						 unsigned long offset,
-						 size_t size, int direction)
+						 size_t size,
+						 enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
 		out_of_line_bug();
@@ -102,7 +105,8 @@ static inline void dma_sync_single_range
 static inline void dma_sync_single_range_for_device(struct device *hwdev,
 						    dma_addr_t dma_handle,
 						    unsigned long offset,
-						    size_t size, int direction)
+						    size_t size,
+						    enum dma_data_direction direction)
 {
         if (direction == DMA_NONE)
 		out_of_line_bug();
@@ -115,7 +119,8 @@ static inline void dma_sync_single_range
 
 static inline void dma_sync_sg_for_cpu(struct device *hwdev,
 				       struct scatterlist *sg,
-				       int nelems, int direction)
+				       int nelems,
+				       enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
 		out_of_line_bug();
@@ -128,7 +133,8 @@ static inline void dma_sync_sg_for_cpu(s
 
 static inline void dma_sync_sg_for_device(struct device *hwdev,
 					  struct scatterlist *sg,
-					  int nelems, int direction)
+					  int nelems,
+					  enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
 		out_of_line_bug();
@@ -140,9 +146,9 @@ static inline void dma_sync_sg_for_devic
 }
 
 extern int dma_map_sg(struct device *hwdev, struct scatterlist *sg,
-		      int nents, int direction);
+		      int nents, enum dma_data_direction direction);
 extern void dma_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-			 int nents, int direction);
+			 int nents, enum dma_data_direction direction);
 
 #define dma_unmap_page dma_unmap_single
 
@@ -158,7 +164,8 @@ static inline int dma_set_mask(struct de
 	return 0;
 }
 
-static inline void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction dir)
+static inline void dma_cache_sync(void *vaddr, size_t size,
+				  enum dma_data_direction dir)
 {
 	flush_write_buffers();
 }
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-x86_64/swiotlb.h dma_data_direction.hg/include/asm-x86_64/swiotlb.h
--- vanilla/include/asm-x86_64/swiotlb.h	2005-11-03 01:38:45.000000000 -0500
+++ dma_data_direction.hg/include/asm-x86_64/swiotlb.h	2005-11-18 16:13:27.000000000 -0500
@@ -1,43 +1,7 @@
 #ifndef _ASM_SWIOTLB_H
 #define _ASM_SWTIOLB_H 1
 
-#include <linux/config.h>
-
-/* SWIOTLB interface */
-
-extern dma_addr_t swiotlb_map_single(struct device *hwdev, void *ptr, size_t size,
-				      int dir);
-extern void swiotlb_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-				  size_t size, int dir);
-extern void swiotlb_sync_single_for_cpu(struct device *hwdev,
-					 dma_addr_t dev_addr,
-					 size_t size, int dir);
-extern void swiotlb_sync_single_for_device(struct device *hwdev,
-					    dma_addr_t dev_addr,
-					    size_t size, int dir);
-extern void swiotlb_sync_single_range_for_cpu(struct device *hwdev,
-					      dma_addr_t dev_addr,
-					      unsigned long offset,
-					      size_t size, int dir);
-extern void swiotlb_sync_single_range_for_device(struct device *hwdev,
-						 dma_addr_t dev_addr,
-						 unsigned long offset,
-						 size_t size, int dir);
-extern void swiotlb_sync_sg_for_cpu(struct device *hwdev,
-				     struct scatterlist *sg, int nelems,
-				     int dir);
-extern void swiotlb_sync_sg_for_device(struct device *hwdev,
-					struct scatterlist *sg, int nelems,
-					int dir);
-extern int swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg,
-		      int nents, int direction);
-extern void swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-			 int nents, int direction);
-extern int swiotlb_dma_mapping_error(dma_addr_t dma_addr);
-extern void *swiotlb_alloc_coherent (struct device *hwdev, size_t size,
-				     dma_addr_t *dma_handle, gfp_t flags);
-extern void swiotlb_free_coherent (struct device *hwdev, size_t size,
-				   void *vaddr, dma_addr_t dma_handle);
+#include <asm-generic/swiotlb.h>
 
 #ifdef CONFIG_SWIOTLB
 extern int swiotlb;
@@ -45,4 +9,4 @@ extern int swiotlb;
 #define swiotlb 0
 #endif
 
-#endif
+#endif /* _ASM_SWTIOLB_H */


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

