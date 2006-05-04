Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWEDVA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWEDVA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWEDVA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:00:26 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32960 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932309AbWEDVAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:00:25 -0400
Date: Thu, 4 May 2006 15:59:29 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       mulix@mulix.org
Subject: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Message-ID: <20060504205929.GD14361@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Andi Kleen's suggestion in the review of our Calgary IOMMU code, I
tried to use the alloc_bootmem_nopanic that Andi recently added.
Unfortunately, it needs low mem for our translation tables, so we needed
a new function to do this.

I have updated swiotlb to take advantage of this new function (and
added an error path to lib/swiotlb.c and resulting fallout from
calling functions).

This patch has been tested individually and cumulatively on x86_64 and
cross-compile tested on IA64.  Since I have no IA64 hardware, any
testing on that platform would be appreciated.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r b5bb5fea7490 -r 62dc1eb0c5e2 arch/x86_64/kernel/pci-swiotlb.c
--- a/arch/x86_64/kernel/pci-swiotlb.c	Tue Apr 25 18:18:55 2006
+++ b/arch/x86_64/kernel/pci-swiotlb.c	Wed Apr 26 16:12:39 2006
@@ -30,13 +30,19 @@
 
 void pci_swiotlb_init(void)
 {
+	int rc;
+
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
 	if (!iommu_aperture && !no_iommu &&
 	    (end_pfn > MAX_DMA32_PFN || force_iommu))
 	       swiotlb = 1;
 	if (swiotlb) {
-		printk(KERN_INFO "PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
-		swiotlb_init();
-		dma_ops = &swiotlb_dma_ops;
+		printk(KERN_INFO "PCI-DMA: Using software bounce buffering for "
+		       "IO (SWIOTLB)\n");
+		rc = swiotlb_init();
+		if (!rc)
+			dma_ops = &swiotlb_dma_ops;
+		else
+			swiotlb = 0;
 	}
 }
diff -r b5bb5fea7490 -r 62dc1eb0c5e2 include/asm-ia64/machvec.h
--- a/include/asm-ia64/machvec.h	Tue Apr 25 18:18:55 2006
+++ b/include/asm-ia64/machvec.h	Wed Apr 26 16:12:39 2006
@@ -38,7 +38,7 @@
 typedef void ia64_mv_migrate_t(struct task_struct * task);
 
 /* DMA-mapping interface: */
-typedef void ia64_mv_dma_init (void);
+typedef int ia64_mv_dma_init (void);
 typedef void *ia64_mv_dma_alloc_coherent (struct device *, size_t, dma_addr_t *, gfp_t);
 typedef void ia64_mv_dma_free_coherent (struct device *, size_t, void *, dma_addr_t);
 typedef dma_addr_t ia64_mv_dma_map_single (struct device *, void *, size_t, int);
diff -r b5bb5fea7490 -r 62dc1eb0c5e2 include/asm-x86_64/swiotlb.h
--- a/include/asm-x86_64/swiotlb.h	Tue Apr 25 18:18:55 2006
+++ b/include/asm-x86_64/swiotlb.h	Wed Apr 26 16:12:39 2006
@@ -41,7 +41,7 @@
 extern void swiotlb_free_coherent (struct device *hwdev, size_t size,
 				   void *vaddr, dma_addr_t dma_handle);
 extern int swiotlb_dma_supported(struct device *hwdev, u64 mask);
-extern void swiotlb_init(void);
+extern int swiotlb_init(void);
 
 #ifdef CONFIG_SWIOTLB
 extern int swiotlb;
diff -r b5bb5fea7490 -r 62dc1eb0c5e2 include/linux/bootmem.h
--- a/include/linux/bootmem.h	Tue Apr 25 18:18:55 2006
+++ b/include/linux/bootmem.h	Wed Apr 26 16:12:39 2006
@@ -46,6 +46,7 @@
 extern void __init free_bootmem (unsigned long addr, unsigned long size);
 extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
 extern void * __init __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
+extern void * __init __alloc_bootmem_low_nopanic(unsigned long size, unsigned long align, unsigned long goal);
 extern void * __init __alloc_bootmem_low(unsigned long size,
 					 unsigned long align,
 					 unsigned long goal);
diff -r b5bb5fea7490 -r 62dc1eb0c5e2 lib/swiotlb.c
--- a/lib/swiotlb.c	Tue Apr 25 18:18:55 2006
+++ b/lib/swiotlb.c	Wed Apr 26 16:12:39 2006
@@ -126,7 +126,7 @@
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
  */
-void
+int
 swiotlb_init(void)
 {
 	unsigned long i;
@@ -140,10 +140,11 @@
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
-					       (1 << IO_TLB_SHIFT));
+	io_tlb_start = __alloc_bootmem_low_nopanic(io_tlb_nslabs *
+			(1 << IO_TLB_SHIFT), PAGE_SIZE, 0);
 	if (!io_tlb_start)
-		panic("Cannot allocate SWIOTLB buffer");
+		goto nomem_error;
+
 	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
 
 	/*
@@ -152,18 +153,39 @@
 	 * between io_tlb_start and io_tlb_end.
 	 */
 	io_tlb_list = alloc_bootmem(io_tlb_nslabs * sizeof(int));
+ 	if (!io_tlb_list)
+ 		goto free_io_tlb_start;
+
 	for (i = 0; i < io_tlb_nslabs; i++)
  		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
 	io_tlb_index = 0;
 	io_tlb_orig_addr = alloc_bootmem(io_tlb_nslabs * sizeof(char *));
+ 	if (!io_tlb_orig_addr)
+ 		goto free_io_tlb_list;
 
 	/*
 	 * Get the overflow emergency buffer
 	 */
 	io_tlb_overflow_buffer = alloc_bootmem_low(io_tlb_overflow);
+ 	if (!io_tlb_overflow_buffer)
+ 		goto free_io_tlb_orig_addr;
+
 	printk(KERN_INFO "Placing %dMB software IO TLB between 0x%lx - 0x%lx\n",
 	       (int) (io_tlb_nslabs * (1 << IO_TLB_SHIFT)) >> 20,
 	       virt_to_phys(io_tlb_start), virt_to_phys(io_tlb_end));
+
+	return 0;
+
+free_io_tlb_orig_addr:
+	free_bootmem(__pa(io_tlb_orig_addr), io_tlb_nslabs * sizeof(char *));
+free_io_tlb_list:
+	free_bootmem(__pa(io_tlb_list), io_tlb_nslabs * sizeof(int));
+free_io_tlb_start:
+	free_bootmem(__pa(io_tlb_start), io_tlb_nslabs * (1 << IO_TLB_SHIFT));
+nomem_error:
+	printk(KERN_ERR "SWIOTLB: Unable to allocate memory, disabling "
+	       "IOMMU\n");
+	return -ENOMEM;
 }
 
 /*
diff -r b5bb5fea7490 -r 62dc1eb0c5e2 mm/bootmem.c
--- a/mm/bootmem.c	Tue Apr 25 18:18:55 2006
+++ b/mm/bootmem.c	Wed Apr 26 16:12:39 2006
@@ -463,3 +463,16 @@
 {
 	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, LOW32LIMIT);
 }
+
+void * __init __alloc_bootmem_low_nopanic(unsigned long size, 
+					unsigned long align, unsigned long goal)
+{
+	bootmem_data_t *bdata;
+	void *ptr;
+
+	list_for_each_entry(bdata, &bdata_list, list)
+		if ((ptr = __alloc_bootmem_core(bdata, size, align, goal, 
+						LOW32LIMIT)))
+			return(ptr);
+	return NULL;
+}
