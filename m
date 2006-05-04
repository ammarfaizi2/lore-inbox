Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWEDU7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWEDU7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWEDU7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:59:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:52412 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932077AbWEDU7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:59:18 -0400
Date: Thu, 4 May 2006 15:58:23 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       mulix@mulix.org
Subject: [PATCH 1/3] swiotlb: SWIOTLB Cleanup.
Message-ID: <20060504205822.GC14361@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SWIOTLB Cleanup.  Mostly a comment and white space clean-up.
However, some compiler cache optimizations (via the static and
__read_mostly keywords) were added, and
swiotlb_init_with_default_size was renamed swiotlb_init (as that
functional was redundant)

This patch has been tested individually and cumulatively on x86_64 and
cross-compile tested on IA64.  Since I have no IA64 hardware, any
testing on that platform would be appreciated.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 457bff6b2b2f -r b5bb5fea7490 lib/swiotlb.c
--- a/lib/swiotlb.c	Tue Apr 25 14:51:06 2006
+++ b/lib/swiotlb.c	Tue Apr 25 18:18:55 2006
@@ -8,9 +8,9 @@
  * Copyright (C) 2000, 2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  *
- * 03/05/07 davidm	Switch from PCI-DMA to generic device DMA API.
  * 00/12/13 davidm	Rename to swiotlb.c and add mark_clean() to avoid
  *			unnecessary i-cache flushing.
+ * 03/05/07 davidm	Switch from PCI-DMA to generic device DMA API.
  * 04/07/.. ak		Better overflow handling. Assorted fixes.
  * 05/09/10 linville	Add support for syncing ranges, support syncing for
  *			DMA_BIDIRECTIONAL mappings, miscellaneous cleanup.
@@ -24,13 +24,11 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/ctype.h>
-
+#include <linux/init.h>
+#include <linux/bootmem.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/scatterlist.h>
-
-#include <linux/init.h>
-#include <linux/bootmem.h>
 
 #define OFFSET(val,align) ((unsigned long)	\
 	                   ( (val) & ( (align) - 1)))
@@ -68,27 +66,26 @@
 	SYNC_FOR_DEVICE = 1,
 };
 
-int swiotlb_force;
+int __read_mostly swiotlb_force;
 
 /*
  * Used to do a quick range check in swiotlb_unmap_single and
  * swiotlb_sync_single_*, to see if the memory was in fact allocated by this
  * API.
  */
-static char *io_tlb_start, *io_tlb_end;
+static __read_mostly char *io_tlb_start, *io_tlb_end;
 
 /*
  * The number of IO TLB blocks (in groups of 64) betweeen io_tlb_start and
  * io_tlb_end.  This is command line adjustable via setup_io_tlb_npages.
  */
-static unsigned long io_tlb_nslabs;
+static __read_mostly unsigned long io_tlb_nslabs;
 
 /*
  * When the IOMMU overflows we return a fallback buffer. This sets the size.
  */
-static unsigned long io_tlb_overflow = 32*1024;
-
-void *io_tlb_overflow_buffer;
+static __read_mostly unsigned long io_tlb_overflow = 32*1024;
+static void *io_tlb_overflow_buffer;
 
 /*
  * This is a free list describing the number of free entries available from
@@ -130,19 +127,21 @@
  * structures for the software IO TLB used to implement the DMA API.
  */
 void
-swiotlb_init_with_default_size (size_t default_size)
+swiotlb_init(void)
 {
 	unsigned long i;
 
 	if (!io_tlb_nslabs) {
-		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
+		/* if not defined via boot arg, default to 64MB */
+		io_tlb_nslabs = ((64 * (1 << 20)) >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
 	}
 
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs * (1 << IO_TLB_SHIFT));
+	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
+					       (1 << IO_TLB_SHIFT));
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
@@ -162,14 +161,9 @@
 	 * Get the overflow emergency buffer
 	 */
 	io_tlb_overflow_buffer = alloc_bootmem_low(io_tlb_overflow);
-	printk(KERN_INFO "Placing software IO TLB between 0x%lx - 0x%lx\n",
+	printk(KERN_INFO "Placing %dMB software IO TLB between 0x%lx - 0x%lx\n",
+	       (int) (io_tlb_nslabs * (1 << IO_TLB_SHIFT)) >> 20,
 	       virt_to_phys(io_tlb_start), virt_to_phys(io_tlb_end));
-}
-
-void
-swiotlb_init (void)
-{
-	swiotlb_init_with_default_size(64 * (1<<20));	/* default to 64MB */
 }
 
 /*
@@ -178,7 +172,7 @@
  * This should be just like above, but with some error catching.
  */
 int
-swiotlb_late_init_with_default_size (size_t default_size)
+swiotlb_late_init_with_default_size(size_t default_size)
 {
 	unsigned long i, req_nslabs = io_tlb_nslabs;
 	unsigned int order;
@@ -250,11 +244,11 @@
 
 cleanup4:
 	free_pages((unsigned long)io_tlb_orig_addr, get_order(io_tlb_nslabs *
-	                                                      sizeof(char *)));
+							      sizeof(char *)));
 	io_tlb_orig_addr = NULL;
 cleanup3:
 	free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
-	                                                 sizeof(int)));
+							 sizeof(int)));
 	io_tlb_list = NULL;
 	io_tlb_end = NULL;
 cleanup2:
@@ -268,7 +262,7 @@
 static inline int
 address_needs_mapping(struct device *hwdev, dma_addr_t addr)
 {
-	dma_addr_t mask = 0xffffffff;
+	dma_addr_t mask = DMA_32BIT_MASK;
 	/* If the device has a mask, use it, otherwise default to 32 bits */
 	if (hwdev && hwdev->dma_mask)
 		mask = *hwdev->dma_mask;
@@ -491,7 +485,7 @@
 		free_pages((unsigned long) vaddr, get_order(size));
 	else
 		/* DMA_TO_DEVICE to avoid memcpy in unmap_single */
-		swiotlb_unmap_single (hwdev, dma_handle, size, DMA_TO_DEVICE);
+		swiotlb_unmap_single(hwdev, dma_handle, size, DMA_TO_DEVICE);
 }
 
 static void
