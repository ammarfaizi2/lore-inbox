Return-Path: <linux-kernel-owner+w=401wt.eu-S1755363AbXABQUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbXABQUG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbXABQUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:20:05 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:38710
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755364AbXABQUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:20:00 -0500
Message-Id: <459A948D.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 02 Jan 2007 16:21:17 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-ia64@vger.kernel.org>, <patches@x86-64.org>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, <xen-devel@lists.xensource.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] swiotlb abstraction (e.g. for Xen)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds abstraction so that the file can be used by environments other
than IA64 and EM64T, namely for Xen.

Even if this patch is considered too convoluted, I would appreciate if the
other three ones could still be considered for merging.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: 2.6.20-rc3-swiotlb-bugs/include/asm-ia64/swiotlb.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.20-rc3-swiotlb-bugs/include/asm-ia64/swiotlb.h	2007-01-02 16:55:32.000000000 +0100
@@ -0,0 +1,9 @@
+#ifndef _ASM_SWIOTLB_H
+#define _ASM_SWIOTLB_H 1
+
+#include <asm/machvec.h>
+
+#define SWIOTLB_ARCH_NEED_LATE_INIT
+#define SWIOTLB_ARCH_NEED_ALLOC
+
+#endif /* _ASM_SWIOTLB_H */
Index: 2.6.20-rc3-swiotlb-bugs/include/asm-x86_64/swiotlb.h
===================================================================
--- 2.6.20-rc3-swiotlb-bugs.orig/include/asm-x86_64/swiotlb.h	2007-01-02 16:12:20.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/include/asm-x86_64/swiotlb.h	2007-01-02 16:55:32.000000000 +0100
@@ -44,6 +44,7 @@ extern void swiotlb_init(void);
 extern int swiotlb_force;
 
 #ifdef CONFIG_SWIOTLB
+#define SWIOTLB_ARCH_NEED_ALLOC
 extern int swiotlb;
 #else
 #define swiotlb 0
Index: 2.6.20-rc3-swiotlb-bugs/lib/swiotlb.c
===================================================================
--- 2.6.20-rc3-swiotlb-bugs.orig/lib/swiotlb.c	2007-01-02 16:52:51.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/lib/swiotlb.c	2007-01-02 17:04:38.000000000 +0100
@@ -28,6 +28,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/scatterlist.h>
+#include <asm/swiotlb.h>
 
 #include <linux/init.h>
 #include <linux/bootmem.h>
@@ -35,8 +36,10 @@
 #define OFFSET(val,align) ((unsigned long)	\
 	                   ( (val) & ( (align) - 1)))
 
+#ifndef SG_ENT_VIRT_ADDRESS
 #define SG_ENT_VIRT_ADDRESS(sg)	(page_address((sg)->page) + (sg)->offset)
 #define SG_ENT_PHYS_ADDRESS(sg)	virt_to_bus(SG_ENT_VIRT_ADDRESS(sg))
+#endif
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -101,13 +104,25 @@ static unsigned int io_tlb_index;
  * We need to save away the original address corresponding to a mapped entry
  * for the sync operations.
  */
-static unsigned char **io_tlb_orig_addr;
+#ifndef SWIOTLB_ARCH_HAS_IO_TLB_ADDR_T
+typedef char *io_tlb_addr_t;
+#define swiotlb_orig_addr_null(buffer) (!(buffer))
+#define ptr_to_io_tlb_addr(ptr) (ptr)
+#define page_to_io_tlb_addr(pg, off) (page_address(pg) + (off))
+#define sg_to_io_tlb_addr(sg) SG_ENT_VIRT_ADDRESS(sg)
+#endif
+static io_tlb_addr_t *io_tlb_orig_addr;
 
 /*
  * Protect the above data structures in the map and unmap calls
  */
 static DEFINE_SPINLOCK(io_tlb_lock);
 
+#ifdef SWIOTLB_EXTRA_VARIABLES
+SWIOTLB_EXTRA_VARIABLES;
+#endif
+
+#ifndef SWIOTLB_ARCH_HAS_SETUP_IO_TLB_NPAGES
 static int __init
 setup_io_tlb_npages(char *str)
 {
@@ -122,9 +137,25 @@ setup_io_tlb_npages(char *str)
 		swiotlb_force = 1;
 	return 1;
 }
+#endif
 __setup("swiotlb=", setup_io_tlb_npages);
 /* make io_tlb_overflow tunable too? */
 
+#ifndef swiotlb_adjust_size
+#define swiotlb_adjust_size(size) ((void)0)
+#endif
+
+#ifndef swiotlb_adjust_seg
+#define swiotlb_adjust_seg(start, size) ((void)0)
+#endif
+
+#ifndef swiotlb_print_info
+#define swiotlb_print_info(bytes) \
+	printk(KERN_INFO "Placing %luMB software IO TLB between 0x%lx - " \
+	       "0x%lx\n", bytes >> 20, \
+	       virt_to_bus(io_tlb_start), virt_to_bus(io_tlb_end))
+#endif
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
@@ -138,6 +169,8 @@ swiotlb_init_with_default_size(size_t de
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
 	}
+	swiotlb_adjust_size(io_tlb_nslabs);
+	swiotlb_adjust_size(io_tlb_overflow);
 
 	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
 
@@ -155,10 +188,14 @@ swiotlb_init_with_default_size(size_t de
 	 * between io_tlb_start and io_tlb_end.
 	 */
 	io_tlb_list = alloc_bootmem(io_tlb_nslabs * sizeof(int));
-	for (i = 0; i < io_tlb_nslabs; i++)
+	for (i = 0; i < io_tlb_nslabs; i++) {
+		if ( !(i % IO_TLB_SEGSIZE) )
+			swiotlb_adjust_seg(io_tlb_start + (i << IO_TLB_SHIFT),
+				IO_TLB_SEGSIZE << IO_TLB_SHIFT);
  		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+ 	}
 	io_tlb_index = 0;
-	io_tlb_orig_addr = alloc_bootmem(io_tlb_nslabs * sizeof(char *));
+	io_tlb_orig_addr = alloc_bootmem(io_tlb_nslabs * sizeof(io_tlb_addr_t));
 
 	/*
 	 * Get the overflow emergency buffer
@@ -166,17 +203,21 @@ swiotlb_init_with_default_size(size_t de
 	io_tlb_overflow_buffer = alloc_bootmem_low(io_tlb_overflow);
 	if (!io_tlb_overflow_buffer)
 		panic("Cannot allocate SWIOTLB overflow buffer!\n");
+	swiotlb_adjust_seg(io_tlb_overflow_buffer, io_tlb_overflow);
 
-	printk(KERN_INFO "Placing software IO TLB between 0x%lx - 0x%lx\n",
-	       virt_to_bus(io_tlb_start), virt_to_bus(io_tlb_end));
+	swiotlb_print_info(bytes);
 }
+#ifndef __swiotlb_init_with_default_size
+#define __swiotlb_init_with_default_size swiotlb_init_with_default_size
+#endif
 
 void __init
 swiotlb_init(void)
 {
-	swiotlb_init_with_default_size(64 * (1<<20));	/* default to 64MB */
+	__swiotlb_init_with_default_size(64 * (1<<20)); /* default to 64MB */
 }
 
+#ifdef SWIOTLB_ARCH_NEED_LATE_INIT
 /*
  * Systems with larger DMA zones (those that don't support ISA) can
  * initialize the swiotlb later using the slab allocator if needed.
@@ -234,12 +275,12 @@ swiotlb_late_init_with_default_size(size
  		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
 	io_tlb_index = 0;
 
-	io_tlb_orig_addr = (unsigned char **)__get_free_pages(GFP_KERNEL,
-	                           get_order(io_tlb_nslabs * sizeof(char *)));
+	io_tlb_orig_addr = (io_tlb_addr_t *)__get_free_pages(GFP_KERNEL,
+	                           get_order(io_tlb_nslabs * sizeof(io_tlb_addr_t)));
 	if (!io_tlb_orig_addr)
 		goto cleanup3;
 
-	memset(io_tlb_orig_addr, 0, io_tlb_nslabs * sizeof(char *));
+	memset(io_tlb_orig_addr, 0, io_tlb_nslabs * sizeof(io_tlb_addr_t));
 
 	/*
 	 * Get the overflow emergency buffer
@@ -249,19 +290,17 @@ swiotlb_late_init_with_default_size(size
 	if (!io_tlb_overflow_buffer)
 		goto cleanup4;
 
-	printk(KERN_INFO "Placing %luMB software IO TLB between 0x%lx - "
-	       "0x%lx\n", bytes >> 20,
-	       virt_to_bus(io_tlb_start), virt_to_bus(io_tlb_end));
+	swiotlb_print_info(bytes);
 
 	return 0;
 
 cleanup4:
-	free_pages((unsigned long)io_tlb_orig_addr, get_order(io_tlb_nslabs *
-	                                                      sizeof(char *)));
+	free_pages((unsigned long)io_tlb_orig_addr,
+		   get_order(io_tlb_nslabs * sizeof(io_tlb_addr_t)));
 	io_tlb_orig_addr = NULL;
 cleanup3:
-	free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
-	                                                 sizeof(int)));
+	free_pages((unsigned long)io_tlb_list,
+		   get_order(io_tlb_nslabs * sizeof(int)));
 	io_tlb_list = NULL;
 cleanup2:
 	io_tlb_end = NULL;
@@ -271,7 +310,9 @@ cleanup1:
 	io_tlb_nslabs = req_nslabs;
 	return -ENOMEM;
 }
+#endif
 
+#ifndef SWIOTLB_ARCH_HAS_NEEDS_MAPPING
 static inline int
 address_needs_mapping(struct device *hwdev, dma_addr_t addr)
 {
@@ -282,11 +323,35 @@ address_needs_mapping(struct device *hwd
 	return (addr & ~mask) != 0;
 }
 
+static inline int range_needs_mapping(const void *ptr, size_t size)
+{
+	return swiotlb_force;
+}
+
+static inline int order_needs_mapping(unsigned int order)
+{
+	return 0;
+}
+#endif
+
+static void
+__sync_single(io_tlb_addr_t buffer, char *dma_addr, size_t size, int dir)
+{
+#ifndef SWIOTLB_ARCH_HAS_SYNC_SINGLE
+	if (dir == DMA_TO_DEVICE)
+		memcpy(dma_addr, buffer, size);
+	else
+		memcpy(buffer, dma_addr, size);
+#else
+	__swiotlb_arch_sync_single(buffer, dma_addr, size, dir);
+#endif
+}
+
 /*
  * Allocates bounce buffer and returns its kernel virtual address.
  */
 static void *
-map_single(struct device *hwdev, char *buffer, size_t size, int dir)
+map_single(struct device *hwdev, io_tlb_addr_t buffer, size_t size, int dir)
 {
 	unsigned long flags;
 	char *dma_addr;
@@ -359,7 +424,7 @@ map_single(struct device *hwdev, char *b
 	 */
 	io_tlb_orig_addr[index] = buffer;
 	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
-		memcpy(dma_addr, buffer, size);
+		__sync_single(buffer, dma_addr, size, DMA_TO_DEVICE);
 
 	return dma_addr;
 }
@@ -373,17 +438,18 @@ unmap_single(struct device *hwdev, char 
 	unsigned long flags;
 	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (dma_addr - io_tlb_start) >> IO_TLB_SHIFT;
-	char *buffer = io_tlb_orig_addr[index];
+	io_tlb_addr_t buffer = io_tlb_orig_addr[index];
 
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
-	if (buffer && ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
+	if (!swiotlb_orig_addr_null(buffer)
+	    && ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
 		/*
 		 * bounce... copy the data back into the original buffer * and
 		 * delete the bounce buffer.
 		 */
-		memcpy(buffer, dma_addr, size);
+		__sync_single(buffer, dma_addr, size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -416,18 +482,18 @@ sync_single(struct device *hwdev, char *
 	    int dir, int target)
 {
 	int index = (dma_addr - io_tlb_start) >> IO_TLB_SHIFT;
-	char *buffer = io_tlb_orig_addr[index];
+	io_tlb_addr_t buffer = io_tlb_orig_addr[index];
 
 	switch (target) {
 	case SYNC_FOR_CPU:
 		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-			memcpy(buffer, dma_addr, size);
+			__sync_single(buffer, dma_addr, size, DMA_FROM_DEVICE);
 		else
 			BUG_ON(dir != DMA_TO_DEVICE);
 		break;
 	case SYNC_FOR_DEVICE:
 		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-			memcpy(dma_addr, buffer, size);
+			__sync_single(buffer, dma_addr, size, DMA_TO_DEVICE);
 		else
 			BUG_ON(dir != DMA_FROM_DEVICE);
 		break;
@@ -436,6 +502,8 @@ sync_single(struct device *hwdev, char *
 	}
 }
 
+#ifdef SWIOTLB_ARCH_NEED_ALLOC
+
 void *
 swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		       dma_addr_t *dma_handle, gfp_t flags)
@@ -451,7 +519,10 @@ swiotlb_alloc_coherent(struct device *hw
 	 */
 	flags |= GFP_DMA;
 
-	ret = (void *)__get_free_pages(flags, order);
+	if (!order_needs_mapping(order))
+		ret = (void *)__get_free_pages(flags, order);
+	else
+		ret = NULL;
 	if (ret && address_needs_mapping(hwdev, virt_to_bus(ret))) {
 		/*
 		 * The allocated memory isn't reachable by the device.
@@ -489,6 +560,7 @@ swiotlb_alloc_coherent(struct device *hw
 	*dma_handle = dev_addr;
 	return ret;
 }
+EXPORT_SYMBOL(swiotlb_alloc_coherent);
 
 void
 swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
@@ -501,6 +573,9 @@ swiotlb_free_coherent(struct device *hwd
 		/* DMA_TO_DEVICE to avoid memcpy in unmap_single */
 		swiotlb_unmap_single (hwdev, dma_handle, size, DMA_TO_DEVICE);
 }
+EXPORT_SYMBOL(swiotlb_free_coherent);
+
+#endif
 
 static void
 swiotlb_full(struct device *dev, size_t size, int dir, int do_panic)
@@ -542,13 +617,14 @@ swiotlb_map_single(struct device *hwdev,
 	 * we can safely return the device addr and not worry about bounce
 	 * buffering it.
 	 */
-	if (!address_needs_mapping(hwdev, dev_addr) && !swiotlb_force)
+	if (!range_needs_mapping(ptr, size)
+	    && !address_needs_mapping(hwdev, dev_addr))
 		return dev_addr;
 
 	/*
 	 * Oh well, have to allocate and map a bounce buffer.
 	 */
-	map = map_single(hwdev, ptr, size, dir);
+	map = map_single(hwdev, ptr_to_io_tlb_addr(ptr), size, dir);
 	if (!map) {
 		swiotlb_full(hwdev, size, dir, 1);
 		map = io_tlb_overflow_buffer;
@@ -676,17 +752,16 @@ int
 swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nelems,
 	       int dir)
 {
-	void *addr;
 	dma_addr_t dev_addr;
 	int i;
 
 	BUG_ON(dir == DMA_NONE);
 
 	for (i = 0; i < nelems; i++, sg++) {
-		addr = SG_ENT_VIRT_ADDRESS(sg);
-		dev_addr = virt_to_bus(addr);
-		if (swiotlb_force || address_needs_mapping(hwdev, dev_addr)) {
-			void *map = map_single(hwdev, addr, sg->length, dir);
+		dev_addr = SG_ENT_PHYS_ADDRESS(sg);
+		if (range_needs_mapping(SG_ENT_VIRT_ADDRESS(sg), sg->length)
+		    || address_needs_mapping(hwdev, dev_addr)) {
+			void *map = map_single(hwdev, sg_to_io_tlb_addr(sg), sg->length, dir);
 			if (!map) {
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
@@ -760,6 +835,44 @@ swiotlb_sync_sg_for_device(struct device
 	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
 }
 
+#ifdef SWIOTLB_ARCH_NEED_MAP_PAGE
+
+dma_addr_t
+swiotlb_map_page(struct device *hwdev, struct page *page,
+		 unsigned long offset, size_t size,
+		 enum dma_data_direction direction)
+{
+	dma_addr_t dev_addr;
+	char *map;
+
+	dev_addr = page_to_bus(page) + offset;
+	if (address_needs_mapping(hwdev, dev_addr)) {
+		map = map_single(hwdev, page_to_io_tlb_addr(page, offset), size, direction);
+		if (!map) {
+			swiotlb_full(hwdev, size, direction, 1);
+			map = io_tlb_overflow_buffer;
+		}
+		dev_addr = virt_to_bus(map);
+	}
+
+	return dev_addr;
+}
+
+void
+swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+		   size_t size, enum dma_data_direction direction)
+{
+	char *dma_addr = bus_to_virt(dev_addr);
+
+	BUG_ON(direction == DMA_NONE);
+	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
+		unmap_single(hwdev, dma_addr, size, direction);
+	else if (direction == DMA_FROM_DEVICE)
+		dma_mark_clean(dma_addr, size);
+}
+
+#endif
+
 int
 swiotlb_dma_mapping_error(dma_addr_t dma_addr)
 {
@@ -772,10 +885,13 @@ swiotlb_dma_mapping_error(dma_addr_t dma
  * during bus mastering, then you would pass 0x00ffffff as the mask to
  * this function.
  */
+#ifndef __swiotlb_dma_supported
+#define __swiotlb_dma_supported(hwdev, mask) (virt_to_bus(io_tlb_end - 1) <= (mask))
+#endif
 int
 swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
-	return virt_to_bus(io_tlb_end - 1) <= mask;
+	return __swiotlb_dma_supported(hwdev, mask);
 }
 
 EXPORT_SYMBOL(swiotlb_init);
@@ -790,6 +906,4 @@ EXPORT_SYMBOL_GPL(swiotlb_sync_single_ra
 EXPORT_SYMBOL(swiotlb_sync_sg_for_cpu);
 EXPORT_SYMBOL(swiotlb_sync_sg_for_device);
 EXPORT_SYMBOL(swiotlb_dma_mapping_error);
-EXPORT_SYMBOL(swiotlb_alloc_coherent);
-EXPORT_SYMBOL(swiotlb_free_coherent);
 EXPORT_SYMBOL(swiotlb_dma_supported);

