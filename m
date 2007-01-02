Return-Path: <linux-kernel-owner+w=401wt.eu-S1755357AbXABQS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbXABQS4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbXABQS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:18:56 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:38664
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755353AbXABQSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:18:54 -0500
Message-Id: <459A944C.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 02 Jan 2007 16:20:12 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-ia64@vger.kernel.org>, <patches@x86-64.org>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] swiotlb cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch
- adds proper __init decoration to swiotlb's init code (and the code calling
  it, where not already the case)
- replaces uses of 'unsigned long' with dma_addr_t where appropriate
- does miscellaneous simplicfication and cleanup

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: 2.6.20-rc3-swiotlb-bugs/arch/x86_64/kernel/pci-swiotlb.c
===================================================================
--- 2.6.20-rc3-swiotlb-bugs.orig/arch/x86_64/kernel/pci-swiotlb.c	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/arch/x86_64/kernel/pci-swiotlb.c	2007-01-02 16:52:51.000000000 +0100
@@ -29,7 +29,7 @@ struct dma_mapping_ops swiotlb_dma_ops =
 	.dma_supported = NULL,
 };
 
-void pci_swiotlb_init(void)
+void __init pci_swiotlb_init(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
 	if (!iommu_detected && !no_iommu && end_pfn > MAX_DMA32_PFN)
Index: 2.6.20-rc3-swiotlb-bugs/lib/swiotlb.c
===================================================================
--- 2.6.20-rc3-swiotlb-bugs.orig/lib/swiotlb.c	2007-01-02 16:50:42.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/lib/swiotlb.c	2007-01-02 16:52:51.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * Dynamic DMA mapping support.
  *
- * This implementation is for IA-64 and EM64T platforms that do not support
+ * This implementation is a fallback for platforms that do not support
  * I/O TLBs (aka DMA address translation hardware).
  * Copyright (C) 2000 Asit Mallick <Asit.K.Mallick@intel.com>
  * Copyright (C) 2000 Goutham Rao <goutham.rao@intel.com>
@@ -129,23 +129,25 @@ __setup("swiotlb=", setup_io_tlb_npages)
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
  */
-void
-swiotlb_init_with_default_size (size_t default_size)
+void __init
+swiotlb_init_with_default_size(size_t default_size)
 {
-	unsigned long i;
+	unsigned long i, bytes;
 
 	if (!io_tlb_nslabs) {
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
 	}
 
+	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs * (1 << IO_TLB_SHIFT));
+	io_tlb_start = alloc_bootmem_low_pages(bytes);
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
-	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
+	io_tlb_end = io_tlb_start + bytes;
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -162,12 +164,15 @@ swiotlb_init_with_default_size (size_t d
 	 * Get the overflow emergency buffer
 	 */
 	io_tlb_overflow_buffer = alloc_bootmem_low(io_tlb_overflow);
+	if (!io_tlb_overflow_buffer)
+		panic("Cannot allocate SWIOTLB overflow buffer!\n");
+
 	printk(KERN_INFO "Placing software IO TLB between 0x%lx - 0x%lx\n",
 	       virt_to_bus(io_tlb_start), virt_to_bus(io_tlb_end));
 }
 
-void
-swiotlb_init (void)
+void __init
+swiotlb_init(void)
 {
 	swiotlb_init_with_default_size(64 * (1<<20));	/* default to 64MB */
 }
@@ -178,9 +183,9 @@ swiotlb_init (void)
  * This should be just like above, but with some error catching.
  */
 int
-swiotlb_late_init_with_default_size (size_t default_size)
+swiotlb_late_init_with_default_size(size_t default_size)
 {
-	unsigned long i, req_nslabs = io_tlb_nslabs;
+	unsigned long i, bytes, req_nslabs = io_tlb_nslabs;
 	unsigned int order;
 
 	if (!io_tlb_nslabs) {
@@ -191,8 +196,9 @@ swiotlb_late_init_with_default_size (siz
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	order = get_order(io_tlb_nslabs * (1 << IO_TLB_SHIFT));
+	order = get_order(io_tlb_nslabs << IO_TLB_SHIFT);
 	io_tlb_nslabs = SLABS_PER_PAGE << order;
+	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
 
 	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
 		io_tlb_start = (char *)__get_free_pages(GFP_DMA | __GFP_NOWARN,
@@ -205,13 +211,14 @@ swiotlb_late_init_with_default_size (siz
 	if (!io_tlb_start)
 		goto cleanup1;
 
-	if (order != get_order(io_tlb_nslabs * (1 << IO_TLB_SHIFT))) {
+	if (order != get_order(bytes)) {
 		printk(KERN_WARNING "Warning: only able to allocate %ld MB "
 		       "for software IO TLB\n", (PAGE_SIZE << order) >> 20);
 		io_tlb_nslabs = SLABS_PER_PAGE << order;
+		bytes = io_tlb_nslabs << IO_TLB_SHIFT;
 	}
-	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
-	memset(io_tlb_start, 0, io_tlb_nslabs * (1 << IO_TLB_SHIFT));
+	io_tlb_end = io_tlb_start + bytes;
+	memset(io_tlb_start, 0, bytes);
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -242,8 +249,8 @@ swiotlb_late_init_with_default_size (siz
 	if (!io_tlb_overflow_buffer)
 		goto cleanup4;
 
-	printk(KERN_INFO "Placing %ldMB software IO TLB between 0x%lx - "
-	       "0x%lx\n", (io_tlb_nslabs * (1 << IO_TLB_SHIFT)) >> 20,
+	printk(KERN_INFO "Placing %luMB software IO TLB between 0x%lx - "
+	       "0x%lx\n", bytes >> 20,
 	       virt_to_bus(io_tlb_start), virt_to_bus(io_tlb_end));
 
 	return 0;
@@ -256,8 +263,8 @@ cleanup3:
 	free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
 	                                                 sizeof(int)));
 	io_tlb_list = NULL;
-	io_tlb_end = NULL;
 cleanup2:
+	io_tlb_end = NULL;
 	free_pages((unsigned long)io_tlb_start, order);
 	io_tlb_start = NULL;
 cleanup1:
@@ -433,7 +440,7 @@ void *
 swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		       dma_addr_t *dma_handle, gfp_t flags)
 {
-	unsigned long dev_addr;
+	dma_addr_t dev_addr;
 	void *ret;
 	int order = get_order(size);
 
@@ -473,8 +480,9 @@ swiotlb_alloc_coherent(struct device *hw
 
 	/* Confirm address can be DMA'd by device */
 	if (address_needs_mapping(hwdev, dev_addr)) {
-		printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016lx\n",
-		       (unsigned long long)*hwdev->dma_mask, dev_addr);
+		printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
+		       (unsigned long long)*hwdev->dma_mask,
+		       (unsigned long long)dev_addr);
 		panic("swiotlb_alloc_coherent: allocated memory is out of "
 		      "range for device");
 	}
@@ -504,7 +512,7 @@ swiotlb_full(struct device *dev, size_t 
 	 * When the mapping is small enough return a static buffer to limit
 	 * the damage, or panic when the transfer is too big.
 	 */
-	printk(KERN_ERR "DMA: Out of SW-IOMMU space for %lu bytes at "
+	printk(KERN_ERR "DMA: Out of SW-IOMMU space for %zu bytes at "
 	       "device %s\n", size, dev ? dev->bus_id : "?");
 
 	if (size > io_tlb_overflow && do_panic) {
@@ -525,7 +533,7 @@ swiotlb_full(struct device *dev, size_t 
 dma_addr_t
 swiotlb_map_single(struct device *hwdev, void *ptr, size_t size, int dir)
 {
-	unsigned long dev_addr = virt_to_bus(ptr);
+	dma_addr_t dev_addr = virt_to_bus(ptr);
 	void *map;
 
 	BUG_ON(dir == DMA_NONE);
@@ -669,7 +677,7 @@ swiotlb_map_sg(struct device *hwdev, str
 	       int dir)
 {
 	void *addr;
-	unsigned long dev_addr;
+	dma_addr_t dev_addr;
 	int i;
 
 	BUG_ON(dir == DMA_NONE);
@@ -765,7 +773,7 @@ swiotlb_dma_mapping_error(dma_addr_t dma
  * this function.
  */
 int
-swiotlb_dma_supported (struct device *hwdev, u64 mask)
+swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	return virt_to_bus(io_tlb_end - 1) <= mask;
 }

