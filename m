Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWCACva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWCACva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWCACva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:51:30 -0500
Received: from fmr17.intel.com ([134.134.136.16]:54198 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932361AbWCACva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:51:30 -0500
Subject: [Patch] Move swiotlb_init early on X86_64
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1141175458.2642.78.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 01 Mar 2006 09:10:58 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on X86_64, swiotlb buffer is allocated in mem_init, after memmap and vfs cache allocation.

On platforms with huge physical memory, 
large memmap and vfs cache may eat up all usable system memory 
under 4G.

Move swiotlb_init early before memmap is allocated can
solve this issue.

Signed-off-by: Zou Nan hai <Nanhai.zou@intel.com>



diff -Nraup linux-2.6.16-rc5/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
--- linux-2.6.16-rc5/arch/ia64/mm/init.c	2006-03-01 17:43:29.000000000 +0800
+++ b/arch/ia64/mm/init.c	2006-03-01 17:40:58.000000000 +0800
@@ -585,7 +585,7 @@ mem_init (void)
 	 * any drivers that may need the PCI DMA interface are initialized or bootmem has
 	 * been freed.
 	 */
-	platform_dma_init();
+	platform_dma_init(0);
 #endif
 
 #ifdef CONFIG_FLATMEM
diff -Nraup linux-2.6.16-rc5/arch/x86_64/kernel/pci-swiotlb.c b/arch/x86_64/kernel/pci-swiotlb.c
--- linux-2.6.16-rc5/arch/x86_64/kernel/pci-swiotlb.c	2006-03-01 17:43:29.000000000 +0800
+++ b/arch/x86_64/kernel/pci-swiotlb.c	2006-03-01 17:41:01.000000000 +0800
@@ -36,7 +36,7 @@ void pci_swiotlb_init(void)
 	       swiotlb = 1;
 	if (swiotlb) {
 		printk(KERN_INFO "PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
-		swiotlb_init();
+		swiotlb_init(__pa(MAX_DMA_ADDRESS));
 		dma_ops = &swiotlb_dma_ops;
 	}
 }
diff -Nraup linux-2.6.16-rc5/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
--- linux-2.6.16-rc5/arch/x86_64/mm/init.c	2006-03-01 17:43:29.000000000 +0800
+++ b/arch/x86_64/mm/init.c	2006-03-01 17:41:01.000000000 +0800
@@ -437,6 +437,9 @@ void __init paging_init(void)
 
 	memory_present(0, 0, end_pfn);
 	sparse_init();
+#ifdef CONFIG_SWIOTLB
+	pci_swiotlb_init();
+#endif
 	size_zones(zones, holes, 0, end_pfn);
 	free_area_init_node(0, NODE_DATA(0), zones,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, holes);
@@ -528,9 +531,6 @@ void __init mem_init(void)
 {
 	long codesize, reservedpages, datasize, initsize;
 
-#ifdef CONFIG_SWIOTLB
-	pci_swiotlb_init();
-#endif
 	no_iommu_init();
 
 	/* How many end-of-memory variables you have, grandma! */
diff -Nraup linux-2.6.16-rc5/arch/x86_64/mm/numa.c b/arch/x86_64/mm/numa.c
--- linux-2.6.16-rc5/arch/x86_64/mm/numa.c	2006-03-01 17:43:29.000000000 +0800
+++ b/arch/x86_64/mm/numa.c	2006-03-01 17:41:01.000000000 +0800
@@ -305,7 +305,9 @@ void __init paging_init(void)
 	int i;
 
 	arch_sparse_init();
-
+#ifdef CONFIG_SWIOTLB
+	pci_swiotlb_init();
+#endif
 	for_each_online_node(i) {
 		setup_node_zones(i); 
 	}
diff -Nraup linux-2.6.16-rc5/include/asm-ia64/machvec.h b/include/asm-ia64/machvec.h
--- linux-2.6.16-rc5/include/asm-ia64/machvec.h	2006-02-17 00:23:50.000000000 +0800
+++ b/include/asm-ia64/machvec.h	2006-03-01 17:41:10.000000000 +0800
@@ -36,7 +36,7 @@ typedef int ia64_mv_pci_legacy_write_t (
 					u8 size);
 
 /* DMA-mapping interface: */
-typedef void ia64_mv_dma_init (void);
+typedef void ia64_mv_dma_init (size_t);
 typedef void *ia64_mv_dma_alloc_coherent (struct device *, size_t, dma_addr_t *, gfp_t);
 typedef void ia64_mv_dma_free_coherent (struct device *, size_t, void *, dma_addr_t);
 typedef dma_addr_t ia64_mv_dma_map_single (struct device *, void *, size_t, int);
@@ -76,6 +76,11 @@ typedef unsigned int ia64_mv_readl_relax
 typedef unsigned long ia64_mv_readq_relaxed_t (const volatile void __iomem *);
 
 static inline void
+machvec_noop_size_t (size_t size)
+{
+}
+
+static inline void
 machvec_noop (void)
 {
 }
diff -Nraup linux-2.6.16-rc5/include/asm-ia64/machvec_hpzx1.h b/include/asm-ia64/machvec_hpzx1.h
--- linux-2.6.16-rc5/include/asm-ia64/machvec_hpzx1.h	2006-02-17 00:23:50.000000000 +0800
+++ b/include/asm-ia64/machvec_hpzx1.h	2006-03-01 17:41:10.000000000 +0800
@@ -20,7 +20,7 @@ extern ia64_mv_dma_mapping_error	sba_dma
  */
 #define platform_name				"hpzx1"
 #define platform_setup				dig_setup
-#define platform_dma_init			machvec_noop
+#define platform_dma_init			machvec_noop_size_t
 #define platform_dma_alloc_coherent		sba_alloc_coherent
 #define platform_dma_free_coherent		sba_free_coherent
 #define platform_dma_map_single			sba_map_single
diff -Nraup linux-2.6.16-rc5/include/asm-ia64/machvec_sn2.h b/include/asm-ia64/machvec_sn2.h
--- linux-2.6.16-rc5/include/asm-ia64/machvec_sn2.h	2006-03-01 17:43:31.000000000 +0800
+++ b/include/asm-ia64/machvec_sn2.h	2006-03-01 17:41:10.000000000 +0800
@@ -102,7 +102,7 @@ extern ia64_mv_dma_supported		sn_dma_sup
 #define platform_pci_get_legacy_mem	sn_pci_get_legacy_mem
 #define platform_pci_legacy_read	sn_pci_legacy_read
 #define platform_pci_legacy_write	sn_pci_legacy_write
-#define platform_dma_init		machvec_noop
+#define platform_dma_init		machvec_noop_size_t
 #define platform_dma_alloc_coherent	sn_dma_alloc_coherent
 #define platform_dma_free_coherent	sn_dma_free_coherent
 #define platform_dma_map_single		sn_dma_map_single
diff -Nraup linux-2.6.16-rc5/include/asm-x86_64/swiotlb.h b/include/asm-x86_64/swiotlb.h
--- linux-2.6.16-rc5/include/asm-x86_64/swiotlb.h	2006-03-01 17:43:31.000000000 +0800
+++ b/include/asm-x86_64/swiotlb.h	2006-03-01 17:41:11.000000000 +0800
@@ -41,7 +41,7 @@ extern int swiotlb_dma_mapping_error(dma
 extern void swiotlb_free_coherent (struct device *hwdev, size_t size,
 				   void *vaddr, dma_addr_t dma_handle);
 extern int swiotlb_dma_supported(struct device *hwdev, u64 mask);
-extern void swiotlb_init(void);
+extern void swiotlb_init(size_t);
 
 #ifdef CONFIG_SWIOTLB
 extern int swiotlb;
diff -Nraup linux-2.6.16-rc5/include/linux/bootmem.h b/include/linux/bootmem.h
--- linux-2.6.16-rc5/include/linux/bootmem.h	2006-03-01 17:43:31.000000000 +0800
+++ b/include/linux/bootmem.h	2006-03-01 17:41:11.000000000 +0800
@@ -57,10 +57,14 @@ extern void __init reserve_bootmem (unsi
 	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low(x) \
 	__alloc_bootmem_low((x), SMP_CACHE_BYTES, 0)
+#define alloc_bootmem_low_goal(x,goal) \
+	__alloc_bootmem_low((x), SMP_CACHE_BYTES, goal)
 #define alloc_bootmem_pages(x) \
 	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem_low((x), PAGE_SIZE, 0)
+#define alloc_bootmem_low_pages_goal(x,goal) \
+	__alloc_bootmem_low((x), PAGE_SIZE, goal)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 extern unsigned long __init free_all_bootmem (void);
 extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
diff -Nraup linux-2.6.16-rc5/lib/swiotlb.c b/lib/swiotlb.c
--- linux-2.6.16-rc5/lib/swiotlb.c	2006-03-01 17:43:31.000000000 +0800
+++ b/lib/swiotlb.c	2006-03-01 17:41:12.000000000 +0800
@@ -129,8 +129,8 @@ __setup("swiotlb=", setup_io_tlb_npages)
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
  */
-void
-swiotlb_init_with_default_size (size_t default_size)
+static void
+swiotlb_init_with_default_size (size_t default_size, size_t goal)
 {
 	unsigned long i;
 
@@ -142,7 +142,7 @@ swiotlb_init_with_default_size (size_t d
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs * (1 << IO_TLB_SHIFT));
+	io_tlb_start = alloc_bootmem_low_pages_goal(io_tlb_nslabs * (1 << IO_TLB_SHIFT), goal);
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
@@ -161,15 +161,15 @@ swiotlb_init_with_default_size (size_t d
 	/*
 	 * Get the overflow emergency buffer
 	 */
-	io_tlb_overflow_buffer = alloc_bootmem_low(io_tlb_overflow);
+	io_tlb_overflow_buffer = alloc_bootmem_low_goal(io_tlb_overflow, goal);
 	printk(KERN_INFO "Placing software IO TLB between 0x%lx - 0x%lx\n",
 	       virt_to_phys(io_tlb_start), virt_to_phys(io_tlb_end));
 }
 
 void
-swiotlb_init (void)
+swiotlb_init (size_t goal)
 {
-	swiotlb_init_with_default_size(64 * (1<<20));	/* default to 64MB */
+	swiotlb_init_with_default_size(64 * (1<<20), goal);	/* default to 64MB */
 }
 
 /*



