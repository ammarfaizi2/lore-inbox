Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWEJAB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWEJAB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 20:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWEJAB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 20:01:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39861 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932309AbWEJAB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 20:01:56 -0400
Date: Tue, 9 May 2006 19:00:49 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       mulix@mulix.org
Subject: [PATCH 4/5] swiotlb: support for __alloc_bootmem_low_nopanic
Message-ID: <20060510000049.GH22385@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated swiotlb to take advantage of the new
__alloc_bootmem_low_nopanic function (and added an error path to
lib/swiotlb.c and resulting fallout from calling functions).

The changing of the return value of swiotlb_init caused some fallout
in ia64, which required a new machvec_noop call.  This removed all of
the compile warnings/errors.

This patch has been tested individually and cumulatively on x86_64 and
cross-compile tested on IA64.  Since I have no IA64 hardware, any
testing on that platform would be appreciated.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 9459ba92585b -r c3a828849dd4 arch/ia64/mm/init.c
--- a/arch/ia64/mm/init.c	Mon May  8 16:30:29 2006
+++ b/arch/ia64/mm/init.c	Tue May  9 15:54:45 2006
@@ -578,7 +578,7 @@
 {
 	long reserved_pages, codesize, datasize, initsize;
 	pg_data_t *pgdat;
-	int i;
+	int i, ret;
 	static struct kcore_list kcore_mem, kcore_vmem, kcore_kernel;
 
 	BUG_ON(PTRS_PER_PGD * sizeof(pgd_t) != PAGE_SIZE);
@@ -587,11 +587,13 @@
 
 #ifdef CONFIG_PCI
 	/*
-	 * This needs to be called _after_ the command line has been parsed but _before_
-	 * any drivers that may need the PCI DMA interface are initialized or bootmem has
-	 * been freed.
-	 */
-	platform_dma_init();
+	 * This needs to be called _after_ the command line has been parsed but
+	 * _before_ any drivers that may need the PCI DMA interface are
+	 * initialized or bootmem has been freed.
+	 */
+	ret = platform_dma_init();
+	if (ret)
+		panic("platform_dma_init failed");
 #endif
 
 #ifdef CONFIG_FLATMEM
diff -r 9459ba92585b -r c3a828849dd4 arch/x86_64/kernel/pci-swiotlb.c
--- a/arch/x86_64/kernel/pci-swiotlb.c	Mon May  8 16:30:29 2006
+++ b/arch/x86_64/kernel/pci-swiotlb.c	Tue May  9 15:54:45 2006
@@ -30,13 +30,19 @@
 
 void pci_swiotlb_init(void)
 {
+	int rc;
+
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
 	if (!iommu_detected && !no_iommu &&
 	    (end_pfn > MAX_DMA32_PFN || force_iommu))
 	       swiotlb = 1;
 	if (swiotlb) {
-		printk(KERN_INFO "PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
-		swiotlb_init();
-		dma_ops = &swiotlb_dma_ops;
+ 		printk(KERN_INFO "PCI-DMA: Using software bounce buffering for "
+ 		       "IO (SWIOTLB)\n");
+ 		rc = swiotlb_init();
+ 		if (!rc)
+ 			dma_ops = &swiotlb_dma_ops;
+ 		else
+ 			swiotlb = 0;
 	}
 }
diff -r 9459ba92585b -r c3a828849dd4 include/asm-ia64/machvec.h
--- a/include/asm-ia64/machvec.h	Mon May  8 16:30:29 2006
+++ b/include/asm-ia64/machvec.h	Tue May  9 15:54:45 2006
@@ -38,7 +38,7 @@
 typedef void ia64_mv_migrate_t(struct task_struct * task);
 
 /* DMA-mapping interface: */
-typedef void ia64_mv_dma_init (void);
+typedef int ia64_mv_dma_init (void);
 typedef void *ia64_mv_dma_alloc_coherent (struct device *, size_t, dma_addr_t *, gfp_t);
 typedef void ia64_mv_dma_free_coherent (struct device *, size_t, void *, dma_addr_t);
 typedef dma_addr_t ia64_mv_dma_map_single (struct device *, void *, size_t, int);
@@ -77,9 +77,15 @@
 typedef unsigned int ia64_mv_readl_relaxed_t (const volatile void __iomem *);
 typedef unsigned long ia64_mv_readq_relaxed_t (const volatile void __iomem *);
 
-static inline void
+static inline void 
 machvec_noop (void)
 {
+}
+
+static inline int 
+machvec_noop_dma (void)
+{
+	return 0;
 }
 
 static inline void
diff -r 9459ba92585b -r c3a828849dd4 include/asm-ia64/machvec_hpzx1.h
--- a/include/asm-ia64/machvec_hpzx1.h	Mon May  8 16:30:29 2006
+++ b/include/asm-ia64/machvec_hpzx1.h	Tue May  9 15:54:45 2006
@@ -20,7 +20,7 @@
  */
 #define platform_name				"hpzx1"
 #define platform_setup				dig_setup
-#define platform_dma_init			machvec_noop
+#define platform_dma_init			machvec_noop_dma
 #define platform_dma_alloc_coherent		sba_alloc_coherent
 #define platform_dma_free_coherent		sba_free_coherent
 #define platform_dma_map_single			sba_map_single
diff -r 9459ba92585b -r c3a828849dd4 include/asm-ia64/machvec_hpzx1_swiotlb.h
--- a/include/asm-ia64/machvec_hpzx1_swiotlb.h	Mon May  8 16:30:29 2006
+++ b/include/asm-ia64/machvec_hpzx1_swiotlb.h	Tue May  9 15:54:45 2006
@@ -25,7 +25,7 @@
 #define platform_name				"hpzx1_swiotlb"
 
 #define platform_setup				dig_setup
-#define platform_dma_init			machvec_noop
+#define platform_dma_init			machvec_noop_dma
 #define platform_dma_alloc_coherent		hwsw_alloc_coherent
 #define platform_dma_free_coherent		hwsw_free_coherent
 #define platform_dma_map_single			hwsw_map_single
diff -r 9459ba92585b -r c3a828849dd4 include/asm-ia64/machvec_sn2.h
--- a/include/asm-ia64/machvec_sn2.h	Mon May  8 16:30:29 2006
+++ b/include/asm-ia64/machvec_sn2.h	Tue May  9 15:54:45 2006
@@ -103,7 +103,7 @@
 #define platform_pci_get_legacy_mem	sn_pci_get_legacy_mem
 #define platform_pci_legacy_read	sn_pci_legacy_read
 #define platform_pci_legacy_write	sn_pci_legacy_write
-#define platform_dma_init		machvec_noop
+#define platform_dma_init		machvec_noop_dma
 #define platform_dma_alloc_coherent	sn_dma_alloc_coherent
 #define platform_dma_free_coherent	sn_dma_free_coherent
 #define platform_dma_map_single		sn_dma_map_single
diff -r 9459ba92585b -r c3a828849dd4 include/asm-x86_64/swiotlb.h
--- a/include/asm-x86_64/swiotlb.h	Mon May  8 16:30:29 2006
+++ b/include/asm-x86_64/swiotlb.h	Tue May  9 15:54:45 2006
@@ -41,7 +41,7 @@
 extern void swiotlb_free_coherent (struct device *hwdev, size_t size,
 				   void *vaddr, dma_addr_t dma_handle);
 extern int swiotlb_dma_supported(struct device *hwdev, u64 mask);
-extern void swiotlb_init(void);
+extern int swiotlb_init(void);
 
 #ifdef CONFIG_SWIOTLB
 extern int swiotlb;
diff -r 9459ba92585b -r c3a828849dd4 lib/swiotlb.c
--- a/lib/swiotlb.c	Mon May  8 16:30:29 2006
+++ b/lib/swiotlb.c	Tue May  9 15:54:45 2006
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
