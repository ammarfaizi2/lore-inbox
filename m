Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWEJADV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWEJADV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 20:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWEJADV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 20:03:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22957 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932318AbWEJADT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 20:03:19 -0400
Date: Tue, 9 May 2006 19:02:11 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       mulix@mulix.org
Subject: [PATCH 5/5] swiotlb: replace free array with bitmap
Message-ID: <20060510000211.GI22385@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the io_tlb_list array used to keep track of the
bounce buffers available, and replaces it with a bitmap with the
same name.  The benefit in doing this is the reduction in memory
between the two (and simplification of the code).

The array is 1/64 the size of the aperture.  So for the default
SWIOTLB aperture size of 64MB, the io_tlb_list array is 1MB.  The
bitmap is 1/2000 the size of the aperture.  So for the default
SWIOTLB aperture size of 64MB, the bitmap is 32kB.

This necessitates the addition of some string handling functions in ia64.

This patch has been tested individually and cumulatively on x86_64 and
cross-compile tested on IA64.  Since I have no IA64 hardware, any
testing on that platform would be appreciated.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r c3a828849dd4 -r ae6b9f9e155e arch/ia64/lib/Makefile
--- a/arch/ia64/lib/Makefile	Tue May  9 15:54:45 2006
+++ b/arch/ia64/lib/Makefile	Tue May  9 16:24:57 2006
@@ -9,7 +9,7 @@
 	checksum.o clear_page.o csum_partial_copy.o			\
 	clear_user.o strncpy_from_user.o strlen_user.o strnlen_user.o	\
 	flush.o ip_fast_csum.o do_csum.o				\
-	memset.o strlen.o
+	memset.o strlen.o bitstr.o
 
 lib-$(CONFIG_ITANIUM)	+= copy_page.o copy_user.o memcpy.o
 lib-$(CONFIG_MCKINLEY)	+= copy_page_mck.o memcpy_mck.o
diff -r c3a828849dd4 -r ae6b9f9e155e include/asm-ia64/bitops.h
--- a/include/asm-ia64/bitops.h	Tue May  9 15:54:45 2006
+++ b/include/asm-ia64/bitops.h	Tue May  9 16:24:57 2006
@@ -372,6 +372,32 @@
 #define hweight16(x)	(unsigned int) hweight64((x) & 0xfffful)
 #define hweight8(x)	(unsigned int) hweight64((x) & 0xfful)
 
+/*
+ * Find string of zero bits in a bitmap. -1 when not found.
+ */
+extern unsigned long 
+find_next_zero_string(unsigned long *bitmap, long start, long nbits, int len);
+
+static inline void set_bit_string(unsigned long *bitmap, unsigned long i,
+				  int len)
+{
+	unsigned long end = i + len;
+	while (i < end) {
+		__set_bit(i, bitmap);
+		i++;
+	}
+}
+
+static inline void __clear_bit_string(unsigned long *bitmap, unsigned long i,
+				    int len)
+{
+	unsigned long end = i + len;
+	while (i < end) {
+		__clear_bit(i, bitmap);
+		i++;
+	}
+}
+
 #endif /* __KERNEL__ */
 
 #include <asm-generic/bitops/find.h>
diff -r c3a828849dd4 -r ae6b9f9e155e lib/swiotlb.c
--- a/lib/swiotlb.c	Tue May  9 15:54:45 2006
+++ b/lib/swiotlb.c	Tue May  9 16:24:57 2006
@@ -7,6 +7,7 @@
  * Copyright (C) 2000 Goutham Rao <goutham.rao@intel.com>
  * Copyright (C) 2000, 2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
+ * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
  *
  * 00/12/13 davidm	Rename to swiotlb.c and add mark_clean() to avoid
  *			unnecessary i-cache flushing.
@@ -14,6 +15,8 @@
  * 04/07/.. ak		Better overflow handling. Assorted fixes.
  * 05/09/10 linville	Add support for syncing ranges, support syncing for
  *			DMA_BIDIRECTIONAL mappings, miscellaneous cleanup.
+ * 06/05/02 jdmason	Replace free list array with bitmap, add bootmem
+ * 			allocation failure recovery, and misc cleanups
  */
 
 #include <linux/cache.h>
@@ -91,7 +94,7 @@
  * This is a free list describing the number of free entries available from
  * each index
  */
-static unsigned int *io_tlb_list;
+static unsigned long *io_tlb_list;
 static unsigned int io_tlb_index;
 
 /*
@@ -129,8 +132,6 @@
 int
 swiotlb_init(void)
 {
-	unsigned long i;
-
 	if (!io_tlb_nslabs) {
 		/* if not defined via boot arg, default to 64MB */
 		io_tlb_nslabs = ((64 * (1 << 20)) >> IO_TLB_SHIFT);
@@ -152,12 +153,11 @@
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
 	 * between io_tlb_start and io_tlb_end.
 	 */
-	io_tlb_list = alloc_bootmem(io_tlb_nslabs * sizeof(int));
+	io_tlb_list = alloc_bootmem(io_tlb_nslabs / BITS_PER_BYTE);
  	if (!io_tlb_list)
  		goto free_io_tlb_start;
 
-	for (i = 0; i < io_tlb_nslabs; i++)
- 		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+	memset(io_tlb_list, 0, io_tlb_nslabs / BITS_PER_BYTE);
 	io_tlb_index = 0;
 	io_tlb_orig_addr = alloc_bootmem(io_tlb_nslabs * sizeof(char *));
  	if (!io_tlb_orig_addr)
@@ -179,7 +179,7 @@
 free_io_tlb_orig_addr:
 	free_bootmem(__pa(io_tlb_orig_addr), io_tlb_nslabs * sizeof(char *));
 free_io_tlb_list:
-	free_bootmem(__pa(io_tlb_list), io_tlb_nslabs * sizeof(int));
+	free_bootmem(__pa(io_tlb_list), io_tlb_nslabs / BITS_PER_BYTE);
 free_io_tlb_start:
 	free_bootmem(__pa(io_tlb_start), io_tlb_nslabs * (1 << IO_TLB_SHIFT));
 nomem_error:
@@ -196,7 +196,7 @@
 int
 swiotlb_late_init_with_default_size(size_t default_size)
 {
-	unsigned long i, req_nslabs = io_tlb_nslabs;
+	unsigned long req_nslabs = io_tlb_nslabs;
 	unsigned int order;
 
 	if (!io_tlb_nslabs) {
@@ -234,13 +234,12 @@
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
 	 * between io_tlb_start and io_tlb_end.
 	 */
-	io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
-	                              get_order(io_tlb_nslabs * sizeof(int)));
+	io_tlb_list = (unsigned long *)__get_free_pages(GFP_KERNEL,
+				get_order(io_tlb_nslabs / BITS_PER_BYTE));
 	if (!io_tlb_list)
 		goto cleanup2;
 
-	for (i = 0; i < io_tlb_nslabs; i++)
- 		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+	memset(io_tlb_list, 0, io_tlb_nslabs / BITS_PER_BYTE);
 	io_tlb_index = 0;
 
 	io_tlb_orig_addr = (unsigned char **)__get_free_pages(GFP_KERNEL,
@@ -269,8 +268,8 @@
 							      sizeof(char *)));
 	io_tlb_orig_addr = NULL;
 cleanup3:
-	free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
-							 sizeof(int)));
+	free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs /
+							 BITS_PER_BYTE));
 	io_tlb_list = NULL;
 	io_tlb_end = NULL;
 cleanup2:
@@ -291,6 +290,27 @@
 	return (addr & ~mask) != 0;
 }
 
+static void
+swiotlb_full(struct device *dev, size_t size, int dir, int do_panic)
+{
+	/*
+	 * Ran out of IOMMU space for this operation. This is very bad.
+	 * Unfortunately the drivers cannot handle this operation properly.
+	 * unless they check for dma_mapping_error (most don't)
+	 * When the mapping is small enough return a static buffer to limit
+	 * the damage, or panic when the transfer is too big.
+	 */
+	printk(KERN_ERR "DMA: Out of SW-IOMMU space for %lu bytes at "
+	       "device %s\n", size, dev ? dev->bus_id : "?");
+
+	if (size > io_tlb_overflow && do_panic) {
+		if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+			panic("DMA: Memory would be corrupted\n");
+		if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+			panic("DMA: Random memory would be DMAed\n");
+	}
+}
+
 /*
  * Allocates bounce buffer and returns its kernel virtual address.
  */
@@ -299,19 +319,13 @@
 {
 	unsigned long flags;
 	char *dma_addr;
-	unsigned int nslots, stride, index, wrap;
-	int i;
+	unsigned int nslots, index;
 
 	/*
 	 * For mappings greater than a page, we limit the stride (and
 	 * hence alignment) to a page size.
 	 */
 	nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (size > PAGE_SIZE)
-		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
-	else
-		stride = 1;
-
 	BUG_ON(!nslots);
 
 	/*
@@ -320,45 +334,20 @@
 	 */
 	spin_lock_irqsave(&io_tlb_lock, flags);
 	{
-		wrap = index = ALIGN(io_tlb_index, stride);
-
-		if (index >= io_tlb_nslabs)
-			wrap = index = 0;
-
-		do {
-			/*
-			 * If we find a slot that indicates we have 'nslots'
-			 * number of contiguous buffers, we allocate the
-			 * buffers from that slot and mark the entries as '0'
-			 * indicating unavailable.
-			 */
-			if (io_tlb_list[index] >= nslots) {
-				int count = 0;
-
-				for (i = index; i < (int) (index + nslots); i++)
-					io_tlb_list[i] = 0;
-				for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
-					io_tlb_list[i] = ++count;
-				dma_addr = io_tlb_start + (index << IO_TLB_SHIFT);
-
-				/*
-				 * Update the indices to avoid searching in
-				 * the next round.
-				 */
-				io_tlb_index = ((index + nslots) < io_tlb_nslabs
-						? (index + nslots) : 0);
-
-				goto found;
-			}
-			index += stride;
-			if (index >= io_tlb_nslabs)
-				index = 0;
-		} while (index != wrap);
-
-		spin_unlock_irqrestore(&io_tlb_lock, flags);
-		return NULL;
-	}
-  found:
+		index = find_next_zero_string(io_tlb_list, io_tlb_index,
+				io_tlb_nslabs, nslots);
+		if (index == ~0U) {
+			index = find_next_zero_string(io_tlb_list, 0,
+					io_tlb_nslabs, nslots);
+			if (index == ~0U)
+				return NULL;
+		}
+
+		set_bit_string(io_tlb_list, index, nslots);
+		io_tlb_index = index + nslots;
+		BUG_ON(io_tlb_index > io_tlb_nslabs);
+		dma_addr = io_tlb_start + (index << IO_TLB_SHIFT);
+	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
 	/*
@@ -380,7 +369,7 @@
 unmap_single(struct device *hwdev, char *dma_addr, size_t size, int dir)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	int i, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (dma_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	char *buffer = io_tlb_orig_addr[index];
 
@@ -402,20 +391,14 @@
 	 */
 	spin_lock_irqsave(&io_tlb_lock, flags);
 	{
-		count = ((index + nslots) < ALIGN(index + 1, IO_TLB_SEGSIZE) ?
-			 io_tlb_list[index + nslots] : 0);
-		/*
-		 * Step 1: return the slots to the free list, merging the
-		 * slots with superceeding slots
-		 */
-		for (i = index + nslots - 1; i >= index; i--)
-			io_tlb_list[i] = ++count;
-		/*
-		 * Step 2: merge the returned slots with the preceding slots,
-		 * if available (non zero)
-		 */
-		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
-			io_tlb_list[i] = ++count;
+		for (i = 0; i < nslots; i++) {
+			if (!test_bit(index + i, io_tlb_list))
+				printk(KERN_ERR "SWIOTLB: bit is off at %#x "
+						"dma %p entry %#x "
+						"npages %u\n", index + i,
+						dma_addr, index, nslots);
+		}
+		__clear_bit_string(io_tlb_list, index, nslots);
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
@@ -478,8 +461,14 @@
 		 */
 		dma_addr_t handle;
 		handle = swiotlb_map_single(NULL, NULL, size, DMA_FROM_DEVICE);
-		if (swiotlb_dma_mapping_error(handle))
-			return NULL;
+		if (swiotlb_dma_mapping_error(handle)) {
+			/*
+			 * Since this is coherent memory being requested, we
+			 * cannot use the emergency buffer.
+			 */
+			swiotlb_full(hwdev, size, 0, 0);
+ 			return NULL;
+		}
 
 		ret = phys_to_virt(handle);
 	}
@@ -508,27 +497,6 @@
 	else
 		/* DMA_TO_DEVICE to avoid memcpy in unmap_single */
 		swiotlb_unmap_single(hwdev, dma_handle, size, DMA_TO_DEVICE);
-}
-
-static void
-swiotlb_full(struct device *dev, size_t size, int dir, int do_panic)
-{
-	/*
-	 * Ran out of IOMMU space for this operation. This is very bad.
-	 * Unfortunately the drivers cannot handle this operation properly.
-	 * unless they check for dma_mapping_error (most don't)
-	 * When the mapping is small enough return a static buffer to limit
-	 * the damage, or panic when the transfer is too big.
-	 */
-	printk(KERN_ERR "DMA: Out of SW-IOMMU space for %lu bytes at "
-	       "device %s\n", size, dev ? dev->bus_id : "?");
-
-	if (size > io_tlb_overflow && do_panic) {
-		if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-			panic("DMA: Memory would be corrupted\n");
-		if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
-			panic("DMA: Random memory would be DMAed\n");
-	}
 }
 
 /*
diff -r c3a828849dd4 -r ae6b9f9e155e arch/ia64/lib/bitstr.c
--- /dev/null	Tue May  9 15:54:45 2006
+++ b/arch/ia64/lib/bitstr.c	Tue May  9 16:24:57 2006
@@ -0,0 +1,30 @@
+/* Copied from arch/x86_64/lib/bitstr.c for IA64 usage. */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+
+/* Find string of zero bits in a bitmap */
+unsigned long
+find_next_zero_string(unsigned long *bitmap, long start, long nbits, int len)
+{
+	unsigned long n, end, i;
+
+ again:
+	n = find_next_zero_bit(bitmap, nbits, start);
+	if (n == -1) 
+		return -1;
+
+	/* could test bitsliced, but it's hardly worth it */
+	end = n+len;
+	if (end >= nbits)
+		return -1;
+	for (i = n+1; i < end; i++) {
+		if (test_bit(i, bitmap)) {
+			start = i+1;
+			goto again;
+		}
+	}
+	return n;
+}
+
+EXPORT_SYMBOL(find_next_zero_string);
