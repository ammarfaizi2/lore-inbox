Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVKFNLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVKFNLm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 08:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVKFNLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 08:11:42 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:52594 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S1750803AbVKFNLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 08:11:40 -0500
Date: Sun, 06 Nov 2005 15:11:12 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH] x86-64: dma_ops for DMA mapping - K3
To: Andi Kleen <ak@suse.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@ScaleMP.com)" <shai@scalemp.com>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
Message-id: <20051106131112.GE24739@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Here's the latest version of the dma_ops patch, updated to address
your comments. The patch is against Linus's tree as of a few minutes
ago and applies cleanly to 2.6.14-git9. Tested on AMD64 with gart,
swiotlb, nommu and iommu=off. There are still a few cleanups left, but
I'd appreciate it if this could see wider testing at this
stage. Please apply...

Summary of changes:

This patch cleans up x86_64's DMA mapping dispatching code. Right now
we have three possible IOMMU types: AGP GART, swiotlb and nommu, and
in the future we will also have Xen's x86_64 swiotlb and other HW
IOMMUs for x86_64. In order to support all of them cleanly, this
patch:

- introduces a struct dma_mapping_ops with function pointers for each 
  of the DMA mapping operations of gart (AMD HW IOMMU), swiotlb
  (software IOMMU) and nommu (no IOMMU).

- gets rid of:

  if (swiotlb)
      return swiotlb_xxx();

  in various places in favor of:

  if (unlikely(dma_ops) && dma_ops->xxx)
      return dma_ops->xxx();

  in dma-mapping.h.
 
- in order to keep the fast path fast, if no dma_ops is specified
  the default nommu_ops are used. 

- PCI_DMA_BUS_IS_PHYS is now checked against the dma_ops being set
(gart enabled and swiotlb, BUS_IS_PHYS=0) or not set (nommu and gart
disabled via iommu=off, BUS_IS_PHYS=1).

Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>

--- 

 arch/x86_64/Kconfig                |    9 -
 arch/x86_64/kernel/Makefile        |    4 
 arch/x86_64/kernel/pci-dma.c       |   60 --------
 arch/x86_64/kernel/pci-gart.c      |  134 +++++++++++--------
 arch/x86_64/kernel/pci-nommu.c     |   83 ++++++++---
 arch/x86_64/kernel/setup.c         |   28 ++++
 arch/x86_64/mm/init.c              |   13 +
 include/asm-x86_64/dma-mapping.h   |  257 ++++++++++++++++++++++++++-----------
 include/asm-x86_64/nommu-mapping.h |   62 ++++++++
 include/asm-x86_64/pci.h           |   11 -
 include/asm-x86_64/swiotlb.h       |    7 -
 11 files changed, 437 insertions(+), 231 deletions(-)

diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/Kconfig hg/arch/x86_64/Kconfig
--- vanilla/arch/x86_64/Kconfig	2005-11-06 11:12:55.000000000 +0200
+++ hg/arch/x86_64/Kconfig	2005-11-06 11:14:28.000000000 +0200
@@ -348,15 +348,6 @@ config SWIOTLB
        depends on GART_IOMMU
        default y
 
-config DUMMY_IOMMU
-	bool
-	depends on !GART_IOMMU && !SWIOTLB
-	default y
-	help
-	  Don't use IOMMU code. This will cause problems when you have more than 4GB
-	  of memory and any 32-bit devices. Don't turn on unless you know what you
-	  are doing.
-
 config X86_MCE
 	bool "Machine check support" if EMBEDDED
 	default y
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/Makefile hg/arch/x86_64/kernel/Makefile
--- vanilla/arch/x86_64/kernel/Makefile	2005-11-03 08:38:45.000000000 +0200
+++ hg/arch/x86_64/kernel/Makefile	2005-11-05 10:34:46.000000000 +0200
@@ -7,7 +7,8 @@ EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
-		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o
+		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
+		pci-nommu.o
 
 obj-$(CONFIG_X86_MCE)         += mce.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
@@ -26,7 +27,6 @@ obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspen
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
-obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
 
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/pci-dma.c hg/arch/x86_64/kernel/pci-dma.c
--- vanilla/arch/x86_64/kernel/pci-dma.c	2005-09-08 14:06:40.000000000 +0300
+++ hg/arch/x86_64/kernel/pci-dma.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,60 +0,0 @@
-/*
- * Dynamic DMA mapping support.
- */
-
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/pci.h>
-#include <linux/module.h>
-#include <asm/io.h>
-
-/* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scatter-gather version of the
- * above pci_map_single interface.  Here the scatter gather list
- * elements are each tagged with the appropriate dma address
- * and length.  They are obtained via sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for pci_map_single are
- * the same here.
- */
-int dma_map_sg(struct device *hwdev, struct scatterlist *sg,
-	       int nents, int direction)
-{
-	int i;
-
-	BUG_ON(direction == DMA_NONE);
- 	for (i = 0; i < nents; i++ ) {
-		struct scatterlist *s = &sg[i];
-		BUG_ON(!s->page); 
-		s->dma_address = virt_to_bus(page_address(s->page) +s->offset);
-		s->dma_length = s->length;
-	}
-	return nents;
-}
-
-EXPORT_SYMBOL(dma_map_sg);
-
-/* Unmap a set of streaming mode DMA translations.
- * Again, cpu read rules concerning calls here are the same as for
- * pci_unmap_single() above.
- */
-void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		  int nents, int dir)
-{
-	int i;
-	for (i = 0; i < nents; i++) { 
-		struct scatterlist *s = &sg[i];
-		BUG_ON(s->page == NULL); 
-		BUG_ON(s->dma_address == 0); 
-		dma_unmap_single(dev, s->dma_address, s->dma_length, dir);
-	} 
-}
-
-EXPORT_SYMBOL(dma_unmap_sg);
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/pci-gart.c hg/arch/x86_64/kernel/pci-gart.c
--- vanilla/arch/x86_64/kernel/pci-gart.c	2005-10-30 11:52:08.000000000 +0200
+++ hg/arch/x86_64/kernel/pci-gart.c	2005-11-06 11:50:32.000000000 +0200
@@ -31,8 +31,6 @@
 #include <asm/cacheflush.h>
 #include <asm/kdebug.h>
 
-dma_addr_t bad_dma_address;
-
 unsigned long iommu_bus_base;	/* GART remapping area (physical) */
 static unsigned long iommu_size; 	/* size of remapping area bytes */
 static unsigned long iommu_pages;	/* .. and in pages */
@@ -40,7 +38,6 @@ static unsigned long iommu_pages;	/* .. 
 u32 *iommu_gatt_base; 		/* Remapping table */
 
 int no_iommu; 
-static int no_agp; 
 #ifdef CONFIG_IOMMU_DEBUG
 int panic_on_overflow = 1; 
 int force_iommu = 1;
@@ -48,8 +45,8 @@ int force_iommu = 1;
 int panic_on_overflow = 0;
 int force_iommu = 0;
 #endif
-int iommu_merge = 1;
-int iommu_sac_force = 0; 
+
+extern int iommu_merge;
 
 /* If this is disabled the IOMMU will use an optimized flushing strategy
    of only flushing when an mapping is reused. With it true the GART is flushed 
@@ -58,10 +55,6 @@ int iommu_sac_force = 0; 
    also seen with Qlogic at least). */
 int iommu_fullflush = 1;
 
-/* This tells the BIO block layer to assume merging. Default to off
-   because we cannot guarantee merging later. */
-int iommu_bio_merge = 0;
-
 #define MAX_NB 8
 
 /* Allocation bitmap for the remapping area */ 
@@ -113,6 +106,50 @@ static struct device fallback_dev = {
 	.dma_mask = &fallback_dev.coherent_dma_mask,
 };
 
+static void 
+gart_free_coherent(struct device *dev, size_t size, void *vaddr,
+		   dma_addr_t dma_handle);
+
+static dma_addr_t
+gart_map_single(struct device *hwdev, void *ptr, size_t size,
+		int direction);
+
+static void 
+gart_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
+		  int direction);
+
+static int 
+gart_map_sg(struct device *hwdev, struct scatterlist *sg,
+	    int nents, int direction);
+
+static void 
+gart_unmap_sg(struct device *hwdev, struct scatterlist *sg,
+	      int nents, int direction);
+
+/* these two are temporarily used by swiotlb */
+void* 
+gart_alloc_coherent(struct device *dev, size_t size, 
+		    dma_addr_t *dma_handle, gfp_t gfp);
+
+int gart_dma_supported(struct device *hwdev, u64 mask);
+
+static struct dma_mapping_ops gart_dma_ops = {
+	.mapping_error = NULL,
+	.alloc_coherent = gart_alloc_coherent,
+	.free_coherent = gart_free_coherent,
+	.map_single = gart_map_single,
+	.unmap_single = gart_unmap_single,
+	.sync_single_for_cpu = NULL,
+	.sync_single_for_device = NULL,
+	.sync_single_range_for_cpu = NULL,
+	.sync_single_range_for_device = NULL,
+	.sync_sg_for_cpu = NULL,
+	.sync_sg_for_device = NULL,
+	.map_sg = gart_map_sg,
+	.unmap_sg = gart_unmap_sg,
+	.dma_supported = gart_dma_supported,
+};
+
 static unsigned long alloc_iommu(int size) 
 { 	
 	unsigned long offset, flags;
@@ -203,8 +240,8 @@ static void *dma_alloc_pages(struct devi
  * Allocate memory for a coherent mapping.
  */
 void *
-dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		   gfp_t gfp)
+gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		    gfp_t gfp)
 {
 	void *memory;
 	unsigned long dma_mask = 0;
@@ -267,7 +304,7 @@ dma_alloc_coherent(struct device *dev, s
 	
 error:
 	if (panic_on_overflow)
-		panic("dma_alloc_coherent: IOMMU overflow by %lu bytes\n", size);
+		panic("gart_alloc_coherent: IOMMU overflow by %lu bytes\n", size);
 	free_pages((unsigned long)memory, get_order(size)); 
 	return NULL; 
 }
@@ -276,15 +313,10 @@ error:
  * Unmap coherent memory.
  * The caller must ensure that the device has finished accessing the mapping.
  */
-void dma_free_coherent(struct device *dev, size_t size,
+void gart_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t bus)
 {
-	if (swiotlb) {
-		swiotlb_free_coherent(dev, size, vaddr, bus);
-		return;
-	}
-
-	dma_unmap_single(dev, bus, size, 0);
+	gart_unmap_single(dev, bus, size, 0);
 	free_pages((unsigned long)vaddr, get_order(size)); 		
 }
 
@@ -403,14 +435,12 @@ static dma_addr_t dma_map_area(struct de
 }
 
 /* Map a single area into the IOMMU */
-dma_addr_t dma_map_single(struct device *dev, void *addr, size_t size, int dir)
+dma_addr_t gart_map_single(struct device *dev, void *addr, size_t size, int dir)
 {
 	unsigned long phys_mem, bus;
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (swiotlb)
-		return swiotlb_map_single(dev,addr,size,dir);
 	if (!dev)
 		dev = &fallback_dev;
 
@@ -440,7 +470,7 @@ static int dma_map_sg_nonforce(struct de
 			addr = dma_map_area(dev, addr, s->length, dir, 0);
 			if (addr == bad_dma_address) { 
 				if (i > 0) 
-					dma_unmap_sg(dev, sg, i, dir);
+					gart_unmap_sg(dev, sg, i, dir);
 				nents = 0; 
 				sg[0].dma_length = 0;
 				break;
@@ -509,7 +539,7 @@ static inline int dma_map_cont(struct sc
  * DMA map all entries in a scatterlist.
  * Merge chunks that have page aligned sizes into a continuous mapping. 
  */
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
+int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
 {
 	int i;
 	int out;
@@ -521,8 +551,6 @@ int dma_map_sg(struct device *dev, struc
 	if (nents == 0) 
 		return 0;
 
-	if (swiotlb)
-		return swiotlb_map_sg(dev,sg,nents,dir);
 	if (!dev)
 		dev = &fallback_dev;
 
@@ -565,7 +593,7 @@ int dma_map_sg(struct device *dev, struc
 
 error:
 	flush_gart(NULL);
-	dma_unmap_sg(dev, sg, nents, dir);
+	gart_unmap_sg(dev, sg, nents, dir);
 	/* When it was forced try again unforced */
 	if (force_iommu) 
 		return dma_map_sg_nonforce(dev, sg, nents, dir);
@@ -580,18 +608,13 @@ error:
 /*
  * Free a DMA mapping.
  */ 
-void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
+void gart_unmap_single(struct device *dev, dma_addr_t dma_addr,
 		      size_t size, int direction)
 {
 	unsigned long iommu_page; 
 	int npages;
 	int i;
 
-	if (swiotlb) {
-		swiotlb_unmap_single(dev,dma_addr,size,direction);
-		return;
-	}
-
 	if (dma_addr < iommu_bus_base + EMERGENCY_PAGES*PAGE_SIZE || 
 	    dma_addr >= iommu_bus_base + iommu_size)
 		return;
@@ -607,13 +630,10 @@ void dma_unmap_single(struct device *dev
 /* 
  * Wrapper for pci_unmap_single working with scatterlists.
  */ 
-void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
+void gart_unmap_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
 {
 	int i;
-	if (swiotlb) {
-		swiotlb_unmap_sg(dev,sg,nents,dir);
-		return;
-	}
+
 	for (i = 0; i < nents; i++) { 
 		struct scatterlist *s = &sg[i];
 		if (!s->dma_length || !s->length) 
@@ -622,7 +642,7 @@ void dma_unmap_sg(struct device *dev, st
 	}
 }
 
-int dma_supported(struct device *dev, u64 mask)
+int gart_dma_supported(struct device *dev, u64 mask)
 {
 	/* Copied from i386. Doesn't make much sense, because it will 
 	   only work for pci_alloc_coherent.
@@ -648,24 +668,17 @@ int dma_supported(struct device *dev, u6
 	return 1;
 } 
 
-int dma_get_cache_alignment(void)
-{
-	return boot_cpu_data.x86_clflush_size;
-}
-
-EXPORT_SYMBOL(dma_unmap_sg);
-EXPORT_SYMBOL(dma_map_sg);
-EXPORT_SYMBOL(dma_map_single);
-EXPORT_SYMBOL(dma_unmap_single);
-EXPORT_SYMBOL(dma_supported);
+EXPORT_SYMBOL(gart_unmap_sg);
+EXPORT_SYMBOL(gart_map_sg);
+EXPORT_SYMBOL(gart_map_single);
+EXPORT_SYMBOL(gart_unmap_single);
+EXPORT_SYMBOL(gart_dma_supported);
 EXPORT_SYMBOL(no_iommu);
 EXPORT_SYMBOL(force_iommu); 
-EXPORT_SYMBOL(bad_dma_address);
-EXPORT_SYMBOL(iommu_bio_merge);
-EXPORT_SYMBOL(iommu_sac_force);
-EXPORT_SYMBOL(dma_get_cache_alignment);
-EXPORT_SYMBOL(dma_alloc_coherent);
-EXPORT_SYMBOL(dma_free_coherent);
+EXPORT_SYMBOL(gart_alloc_coherent);
+EXPORT_SYMBOL(gart_free_coherent);
+
+static int no_agp; 
 
 static __init unsigned long check_iommu_size(unsigned long aper, u64 aper_size)
 { 
@@ -803,6 +816,7 @@ static int __init pci_iommu_init(void)
 	    (no_agp && init_k8_gatt(&info) < 0)) {
 		printk(KERN_INFO "PCI-DMA: Disabling IOMMU.\n"); 
 		no_iommu = 1;
+		dma_ops = NULL;
 		return -1;
 	}
 
@@ -879,6 +893,10 @@ static int __init pci_iommu_init(void)
 		     
 	flush_gart(NULL);
 
+	printk(KERN_DEBUG "%s: setting dma_ops to gart_dma_ops(%p)\n",
+	       __func__, &gart_dma_ops);
+	dma_ops = &gart_dma_ops;
+
 	return 0;
 } 
 
@@ -910,11 +928,15 @@ __init int iommu_setup(char *p)
 { 
     int arg;
 
+    iommu_merge = 1;
+
     while (*p) {
 	    if (!strncmp(p,"noagp",5))
 		    no_agp = 1;
-	    if (!strncmp(p,"off",3))
+	    if (!strncmp(p,"off",3)) {
 		    no_iommu = 1;
+		    dma_ops = NULL;
+	    }
 	    if (!strncmp(p,"force",5)) {
 		    force_iommu = 1;
 		    iommu_aperture_allowed = 1;
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/pci-nommu.c hg/arch/x86_64/kernel/pci-nommu.c
--- vanilla/arch/x86_64/kernel/pci-nommu.c	2005-10-30 11:52:08.000000000 +0200
+++ hg/arch/x86_64/kernel/pci-nommu.c	2005-11-05 10:45:22.000000000 +0200
@@ -7,12 +7,15 @@
 #include <asm/proto.h>
 #include <asm/processor.h>
 
+/* these are defined here because pci-nommu.c is always compiled in */
 int iommu_merge = 0;
 EXPORT_SYMBOL(iommu_merge);
 
 dma_addr_t bad_dma_address;
 EXPORT_SYMBOL(bad_dma_address);
 
+/* This tells the BIO block layer to assume merging. Default to off
+   because we cannot guarantee merging later. */
 int iommu_bio_merge = 0;
 EXPORT_SYMBOL(iommu_bio_merge);
 
@@ -23,8 +26,8 @@ EXPORT_SYMBOL(iommu_sac_force);
  * Dummy IO MMU functions
  */
 
-void *dma_alloc_coherent(struct device *hwdev, size_t size,
-			 dma_addr_t *dma_handle, gfp_t gfp)
+void *nommu_alloc_coherent(struct device *hwdev, size_t size,
+			   dma_addr_t *dma_handle, gfp_t gfp)
 {
 	void *ret;
 	u64 mask;
@@ -50,45 +53,77 @@ void *dma_alloc_coherent(struct device *
 	memset(ret, 0, size);
 	return ret;
 }
-EXPORT_SYMBOL(dma_alloc_coherent);
+EXPORT_SYMBOL(nommu_alloc_coherent);
 
-void dma_free_coherent(struct device *hwdev, size_t size,
+void nommu_free_coherent(struct device *hwdev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
 }
-EXPORT_SYMBOL(dma_free_coherent);
+EXPORT_SYMBOL(nommu_free_coherent);
 
-int dma_supported(struct device *hwdev, u64 mask)
+/* Map a set of buffers described by scatterlist in streaming
+ * mode for DMA.  This is the scatter-gather version of the
+ * above pci_map_single interface.  Here the scatter gather list
+ * elements are each tagged with the appropriate dma address
+ * and length.  They are obtained via sg_dma_{address,length}(SG).
+ *
+ * NOTE: An implementation may be able to use a smaller number of
+ *       DMA address/length pairs than there are SG table elements.
+ *       (for example via virtual mapping capabilities)
+ *       The routine returns the number of addr/length pairs actually
+ *       used, at most nents.
+ *
+ * Device ownership issues as mentioned above for pci_map_single are
+ * the same here.
+ */
+int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
+	       int nents, int direction)
 {
-        /*
-         * we fall back to GFP_DMA when the mask isn't all 1s,
-         * so we can't guarantee allocations that must be
-         * within a tighter range than GFP_DMA..
-	 * RED-PEN this won't work for pci_map_single. Caller has to
-	 * use GFP_DMA in the first place.
-         */
-        if (mask < 0x00ffffff)
-                return 0;
+	int i;
 
-	return 1;
-} 
-EXPORT_SYMBOL(dma_supported);
+	BUG_ON(direction == DMA_NONE);
+ 	for (i = 0; i < nents; i++ ) {
+		struct scatterlist *s = &sg[i];
+		BUG_ON(!s->page); 
+		s->dma_address = virt_to_bus(page_address(s->page) +s->offset);
+		s->dma_length = s->length;
+	}
+	return nents;
+}
+EXPORT_SYMBOL(nommu_map_sg);
 
-int dma_get_cache_alignment(void)
+/* Unmap a set of streaming mode DMA translations.
+ * Again, cpu read rules concerning calls here are the same as for
+ * pci_unmap_single() above.
+ */
+void nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
+		  int nents, int dir)
 {
-	return boot_cpu_data.x86_clflush_size;
+	int i;
+	for (i = 0; i < nents; i++) { 
+		struct scatterlist *s = &sg[i];
+		BUG_ON(s->page == NULL); 
+		BUG_ON(s->dma_address == 0); 
+		dma_unmap_single(dev, s->dma_address, s->dma_length, dir);
+	} 
 }
-EXPORT_SYMBOL(dma_get_cache_alignment);
+EXPORT_SYMBOL(nommu_unmap_sg);
 
-static int __init check_ram(void) 
+static void check_ram(void) 
 { 
 	if (end_pfn >= 0xffffffff>>PAGE_SHIFT) { 
 		printk(
 		KERN_ERR "WARNING more than 4GB of memory but IOMMU not compiled in.\n"
 		KERN_ERR "WARNING 32bit PCI may malfunction.\n");
 	} 
-	return 0;
 } 
-__initcall(check_ram);
 
+static int __init nommu_init(void)
+{
+	check_ram();
+
+	return 0;
+}
+
+__initcall(nommu_init);
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/setup.c hg/arch/x86_64/kernel/setup.c
--- vanilla/arch/x86_64/kernel/setup.c	2005-11-02 14:32:08.000000000 +0200
+++ hg/arch/x86_64/kernel/setup.c	2005-11-05 10:42:33.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/edd.h>
 #include <linux/mmzone.h>
 #include <linux/kexec.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
@@ -60,6 +61,7 @@
 #include <asm/setup.h>
 #include <asm/mach_apic.h>
 #include <asm/numa.h>
+#include <asm/swiotlb.h>
 
 /*
  * Machine setup..
@@ -86,6 +88,32 @@ unsigned long saved_video_mode;
 
 #ifdef CONFIG_SWIOTLB
 int swiotlb;
+
+/* these two are temporarily used by swiotlb */
+extern void* 
+gart_alloc_coherent(struct device *dev, size_t size, 
+		    dma_addr_t *dma_handle, gfp_t gfp);
+
+extern int gart_dma_supported(struct device *hwdev, u64 mask);
+
+struct dma_mapping_ops swiotlb_dma_ops = {
+	.mapping_error = swiotlb_dma_mapping_error,
+	.alloc_coherent = gart_alloc_coherent, /* FIXME: we are called via gart_alloc_coherent */
+	.free_coherent = swiotlb_free_coherent,
+	.map_single = swiotlb_map_single,
+	.unmap_single = swiotlb_unmap_single,
+	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
+	.sync_single_for_device = swiotlb_sync_single_for_device,
+	.sync_single_range_for_cpu = swiotlb_sync_single_range_for_cpu,
+	.sync_single_range_for_device = swiotlb_sync_single_range_for_device,
+	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device = swiotlb_sync_sg_for_device,
+	.map_sg = swiotlb_map_sg,
+	.unmap_sg = swiotlb_unmap_sg,
+	/* FIXME: historically we used gart_dma_supported, keep it the same way */
+	.dma_supported = gart_dma_supported,
+};
+
 EXPORT_SYMBOL(swiotlb);
 #endif
 
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/mm/init.c hg/arch/x86_64/mm/init.c
--- vanilla/arch/x86_64/mm/init.c	2005-09-26 15:10:03.000000000 +0300
+++ hg/arch/x86_64/mm/init.c	2005-11-06 11:51:00.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/proc_fs.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -36,6 +37,7 @@
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
 #include <asm/smp.h>
+#include <asm/dma-mapping.h>
 
 #ifndef Dprintk
 #define Dprintk(x...)
@@ -45,6 +47,9 @@
 extern int swiotlb;
 #endif
 
+struct dma_mapping_ops* dma_ops;
+EXPORT_SYMBOL(dma_ops);
+
 extern char _stext[];
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
@@ -392,8 +397,12 @@ void __init mem_init(void)
 	if (!iommu_aperture &&
 	    (end_pfn >= 0xffffffff>>PAGE_SHIFT || force_iommu))
 	       swiotlb = 1;
-	if (swiotlb)
-		swiotlb_init();	
+	if (swiotlb) {
+		swiotlb_init();
+		dma_ops = &swiotlb_dma_ops;
+		printk(KERN_DEBUG "%s: setting dma_ops to swiotlb_dma_ops(%p)\n",
+		       __func__, &swiotlb_dma_ops);
+	}
 #endif
 
 	/* How many end-of-memory variables you have, grandma! */
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-x86_64/dma-mapping.h hg/include/asm-x86_64/dma-mapping.h
--- vanilla/include/asm-x86_64/dma-mapping.h	2005-11-03 08:38:45.000000000 +0200
+++ hg/include/asm-x86_64/dma-mapping.h	2005-11-05 10:41:43.000000000 +0200
@@ -11,143 +11,255 @@
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 #include <asm/swiotlb.h>
+#include <asm/nommu-mapping.h>
+
+struct dma_mapping_ops {
+	int (*mapping_error)(dma_addr_t dma_addr);
+	void* (*alloc_coherent)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t gfp);
+	void (*free_coherent)(struct device *dev, size_t size,
+			     void *vaddr, dma_addr_t dma_handle);
+	dma_addr_t (*map_single)(struct device *hwdev, void *ptr,
+				     size_t size, int direction);
+	void (*unmap_single)(struct device *dev, dma_addr_t addr,
+				 size_t size, int direction);
+	void (*sync_single_for_cpu)(struct device *hwdev,
+				    dma_addr_t dma_handle,
+				    size_t size, int direction);
+	void (*sync_single_for_device)(struct device *hwdev,
+				       dma_addr_t dma_handle,
+				       size_t size, int direction);
+	void (*sync_single_range_for_cpu)(struct device *hwdev,
+					  dma_addr_t dma_handle,
+					  unsigned long offset,
+					  size_t size, int direction);
+	void (*sync_single_range_for_device)(struct device *hwdev,
+					     dma_addr_t dma_handle,
+					     unsigned long offset,
+					     size_t size,
+					     int direction);
+	void (*sync_sg_for_cpu)(struct device *hwdev, struct scatterlist *sg,
+				int nelems, int direction);
+	void (*sync_sg_for_device)(struct device *hwdev, struct scatterlist *sg,
+				   int nelems, int direction);
+	int (*map_sg)(struct device *hwdev, struct scatterlist *sg,
+		      int nents, int direction);
+	void (*unmap_sg)(struct device *hwdev, struct scatterlist *sg,
+			 int nents, int direction);
+	int (*dma_supported)(struct device *hwdev, u64 mask);
+};
 
 extern dma_addr_t bad_dma_address;
-#define dma_mapping_error(x) \
-	(swiotlb ? swiotlb_dma_mapping_error(x) : ((x) == bad_dma_address))
+extern struct dma_mapping_ops* dma_ops;
 
-void *dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-			 gfp_t gfp);
-void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-			 dma_addr_t dma_handle);
+#define have_iommu (unlikely(dma_ops != NULL))
 
-#ifdef CONFIG_GART_IOMMU
+static inline int dma_mapping_error(dma_addr_t dma_addr)
+{
+	if (have_iommu && dma_ops->mapping_error)
+		return dma_ops->mapping_error(dma_addr);
 
-extern dma_addr_t dma_map_single(struct device *hwdev, void *ptr, size_t size,
-				 int direction);
-extern void dma_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
-			     int direction);
+	return (dma_addr == bad_dma_address);
+}
 
-#else
+static inline void*
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		   gfp_t gfp)
+{
+	if (have_iommu && dma_ops->alloc_coherent)
+		return dma_ops->alloc_coherent(dev, size, dma_handle, gfp);
 
-/* No IOMMU */
+	return nommu_alloc_coherent(dev, size, dma_handle, gfp);
+}
 
-static inline dma_addr_t dma_map_single(struct device *hwdev, void *ptr,
-					size_t size, int direction)
+static inline void
+dma_free_coherent(struct device *dev, size_t size, void *vaddr,
+		  dma_addr_t dma_handle)
 {
-	dma_addr_t addr;
+	if (have_iommu && dma_ops->free_coherent) {
+		dma_ops->free_coherent(dev, size, vaddr, dma_handle);
+		return;
+	}
 
-	if (direction == DMA_NONE)
-		out_of_line_bug();
-	addr = virt_to_bus(ptr);
-
-	if ((addr+size) & ~*hwdev->dma_mask)
-		out_of_line_bug();
-	return addr;
+	nommu_free_coherent(dev, size, vaddr, dma_handle);
 }
 
-static inline void dma_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
-				    size_t size, int direction)
+static inline dma_addr_t
+dma_map_single(struct device *hwdev, void *ptr, size_t size,
+	       int direction)
 {
-	if (direction == DMA_NONE)
-		out_of_line_bug();
-	/* Nothing to do */
+	if (have_iommu && dma_ops->map_single)
+		return dma_ops->map_single(hwdev, ptr, size, direction);
+
+	return nommu_map_single(hwdev, ptr, size, direction);
 }
 
-#endif
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
+		 int direction)
+{
+	if (have_iommu && dma_ops->unmap_single) {
+		dma_ops->unmap_single(dev, addr, size, direction);
+		return;
+	}
+
+	nommu_unmap_single(dev, addr, size, direction);
+}
 
 #define dma_map_page(dev,page,offset,size,dir) \
 	dma_map_single((dev), page_address(page)+(offset), (size), (dir))
 
-static inline void dma_sync_single_for_cpu(struct device *hwdev,
-					       dma_addr_t dma_handle,
-					       size_t size, int direction)
+#define dma_unmap_page dma_unmap_single
+
+static inline void
+dma_sync_single_for_cpu(struct device *hwdev, dma_addr_t dma_handle,
+			size_t size, int direction)
 {
+	void (*f)(struct device *hwdev, dma_addr_t dma_handle,
+		  size_t size, int direction);
+
 	if (direction == DMA_NONE)
 		out_of_line_bug();
 
-	if (swiotlb)
-		return swiotlb_sync_single_for_cpu(hwdev,dma_handle,size,direction);
+	if (have_iommu && dma_ops->sync_single_for_cpu) {
+		f = dma_ops->sync_single_for_cpu;
+		f(hwdev, dma_handle, size, direction);
+		return;
+	}
 
 	flush_write_buffers();
 }
 
-static inline void dma_sync_single_for_device(struct device *hwdev,
-						  dma_addr_t dma_handle,
-						  size_t size, int direction)
+static inline void
+dma_sync_single_for_device(struct device *hwdev, dma_addr_t dma_handle,
+			   size_t size, int direction)
 {
-        if (direction == DMA_NONE)
+	void (*f)(struct device *hwdev, dma_addr_t dma_handle,
+		  size_t size, int direction);
+
+	if (direction == DMA_NONE)
 		out_of_line_bug();
 
-	if (swiotlb)
-		return swiotlb_sync_single_for_device(hwdev,dma_handle,size,direction);
+	if (have_iommu && dma_ops->sync_single_for_device) {
+		f = dma_ops->sync_single_for_device;
+		f(hwdev, dma_handle, size, direction);
+		return;
+	}
 
 	flush_write_buffers();
 }
 
-static inline void dma_sync_single_range_for_cpu(struct device *hwdev,
-						 dma_addr_t dma_handle,
-						 unsigned long offset,
-						 size_t size, int direction)
+static inline void
+dma_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dma_handle,
+			      unsigned long offset, size_t size, int direction)
 {
+	void (*f)(struct device *hwdev, dma_addr_t dma_handle,
+		  unsigned long offset, size_t size, int direction);
+
 	if (direction == DMA_NONE)
 		out_of_line_bug();
 
-	if (swiotlb)
-		return swiotlb_sync_single_range_for_cpu(hwdev,dma_handle,offset,size,direction);
+	if (have_iommu && dma_ops->sync_single_range_for_cpu) {
+		f = dma_ops->sync_single_range_for_cpu;
+		f(hwdev, dma_handle, offset, size, direction);
+		return;
+	}
 
 	flush_write_buffers();
 }
 
-static inline void dma_sync_single_range_for_device(struct device *hwdev,
-						    dma_addr_t dma_handle,
-						    unsigned long offset,
-						    size_t size, int direction)
+static inline void
+dma_sync_single_range_for_device(struct device *hwdev, dma_addr_t dma_handle,
+				 unsigned long offset, size_t size, int direction)
 {
-        if (direction == DMA_NONE)
+	void (*f)(struct device *hwdev, dma_addr_t dma_handle,
+		  unsigned long offset, size_t size, int direction);
+
+	if (direction == DMA_NONE)
 		out_of_line_bug();
 
-	if (swiotlb)
-		return swiotlb_sync_single_range_for_device(hwdev,dma_handle,offset,size,direction);
+	if (have_iommu && dma_ops->sync_single_range_for_device) {
+		f = dma_ops->sync_single_range_for_device;
+		f(hwdev, dma_handle, offset, size, direction);
+		return;
+	}
 
 	flush_write_buffers();
 }
 
-static inline void dma_sync_sg_for_cpu(struct device *hwdev,
-				       struct scatterlist *sg,
-				       int nelems, int direction)
+static inline void
+dma_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
+		    int nelems, int direction)
 {
+	void (*f)(struct device *hwdev, struct scatterlist *sg,
+		  int nelems, int direction);
+
 	if (direction == DMA_NONE)
 		out_of_line_bug();
 
-	if (swiotlb)
-		return swiotlb_sync_sg_for_cpu(hwdev,sg,nelems,direction);
+	if (have_iommu && dma_ops->sync_sg_for_cpu) {
+		f = dma_ops->sync_sg_for_cpu;
+		f(hwdev, sg, nelems, direction);
+		return;
+	}
 
 	flush_write_buffers();
 }
 
-static inline void dma_sync_sg_for_device(struct device *hwdev,
-					  struct scatterlist *sg,
-					  int nelems, int direction)
+static inline void
+dma_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+		       int nelems, int direction)
 {
+	void (*f)(struct device *hwdev, struct scatterlist *sg,
+		  int nelems, int direction);
+
 	if (direction == DMA_NONE)
 		out_of_line_bug();
 
-	if (swiotlb)
-		return swiotlb_sync_sg_for_device(hwdev,sg,nelems,direction);
+	if (have_iommu && dma_ops->sync_sg_for_device) {
+		f = dma_ops->sync_sg_for_device;
+		f(hwdev, sg, nelems, direction);
+		return;
+	}
 
 	flush_write_buffers();
 }
 
-extern int dma_map_sg(struct device *hwdev, struct scatterlist *sg,
-		      int nents, int direction);
-extern void dma_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-			 int nents, int direction);
+static inline int
+dma_map_sg(struct device *hwdev, struct scatterlist *sg, int nents, int direction)
+{
+	if (have_iommu && dma_ops->map_sg)
+		return dma_ops->map_sg(hwdev, sg, nents, direction);
 
-#define dma_unmap_page dma_unmap_single
+	return nommu_map_sg(hwdev, sg, nents, direction);
+}
+
+static inline void
+dma_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
+	     int direction)
+{
+	if (have_iommu && dma_ops->unmap_sg) {
+		dma_ops->unmap_sg(hwdev, sg, nents, direction);
+		return;
+	}
+
+	nommu_unmap_sg(hwdev, sg, nents, direction);
+}
+
+static inline int dma_supported(struct device *hwdev, u64 mask)
+{
+	if (have_iommu && dma_ops->dma_supported)
+		return dma_ops->dma_supported(hwdev, mask);
+
+	return nommu_dma_supported(hwdev, mask);
+}
+
+/* same for gart, swiotlb, and nommu */
+static inline int dma_get_cache_alignment(void)
+{
+	return boot_cpu_data.x86_clflush_size;
+}
 
-extern int dma_supported(struct device *hwdev, u64 mask);
-extern int dma_get_cache_alignment(void);
 #define dma_is_consistent(h) 1
 
 static inline int dma_set_mask(struct device *dev, u64 mask)
@@ -158,9 +270,10 @@ static inline int dma_set_mask(struct de
 	return 0;
 }
 
-static inline void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction dir)
+static inline void
+dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction dir)
 {
 	flush_write_buffers();
 }
 
-#endif
+#endif /* _X8664_DMA_MAPPING_H */
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-x86_64/nommu-mapping.h hg/include/asm-x86_64/nommu-mapping.h
--- vanilla/include/asm-x86_64/nommu-mapping.h	1970-01-01 02:00:00.000000000 +0200
+++ hg/include/asm-x86_64/nommu-mapping.h	2005-11-05 10:37:37.000000000 +0200
@@ -0,0 +1,62 @@
+#ifndef _ASM_NOMMU_MAPPING_H
+#define _ASM_NOMMU_MAPPING_H 1
+
+#include <linux/config.h>
+
+/* GART DMA mapping implemenation */
+extern void* 
+nommu_alloc_coherent(struct device *dev, size_t size, 
+		     dma_addr_t *dma_handle, gfp_t gfp);
+
+extern void 
+nommu_free_coherent(struct device *dev, size_t size, void *vaddr,
+		    dma_addr_t dma_handle);
+
+static inline dma_addr_t 
+nommu_map_single(struct device *hwdev, void *ptr, size_t size, int direction)
+{
+	dma_addr_t addr;
+
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+	addr = virt_to_bus(ptr);
+
+	if ((addr+size) & ~*hwdev->dma_mask)
+		out_of_line_bug();
+	return addr;
+}
+
+static inline void 
+nommu_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
+		   int direction)
+{
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+	/* Nothing to do */
+}
+
+extern int 
+nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
+	     int nents, int direction);
+
+extern void 
+nommu_unmap_sg(struct device *hwdev, struct scatterlist *sg,
+	       int nents, int direction);
+
+static inline int 
+nommu_dma_supported(struct device *hwdev, u64 mask)
+{
+        /*
+         * we fall back to GFP_DMA when the mask isn't all 1s,
+         * so we can't guarantee allocations that must be
+         * within a tighter range than GFP_DMA..
+	 * RED-PEN this won't work for pci_map_single. Caller has to
+	 * use GFP_DMA in the first place.
+         */
+        if (mask < 0x00ffffff)
+                return 0;
+
+	return 1;
+}
+
+#endif /* _ASM_NOMMU_MAPPING_H */
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-x86_64/pci.h hg/include/asm-x86_64/pci.h
--- vanilla/include/asm-x86_64/pci.h	2005-10-28 16:49:06.000000000 +0200
+++ hg/include/asm-x86_64/pci.h	2005-11-06 12:01:10.000000000 +0200
@@ -42,18 +42,20 @@ int pcibios_set_irq_routing(struct pci_d
 #include <asm/scatterlist.h>
 #include <linux/string.h>
 #include <asm/page.h>
+#include <linux/dma-mapping.h> /* for have_iommu */
 
 extern int iommu_setup(char *opt);
 
-#ifdef CONFIG_GART_IOMMU
 /* The PCI address space does equal the physical memory
  * address space.  The networking and block device layers use
  * this boolean for bounce buffer decisions
  *
- * On AMD64 it mostly equals, but we set it to zero to tell some subsystems
- * that an IOMMU is available.
+ * On AMD64 it mostly equals, but we set it to zero if a hardware
+ * IOMMU (gart) of sotware IOMMU (swiotlb) is available.
  */
-#define PCI_DMA_BUS_IS_PHYS	(no_iommu ? 1 : 0)
+#define PCI_DMA_BUS_IS_PHYS (have_iommu ? 0 : 1)
+
+#ifdef CONFIG_GART_IOMMU
 
 /*
  * x86-64 always supports DAC, but sometimes it is useful to force
@@ -79,7 +81,6 @@ extern int iommu_sac_force;
 #else
 /* No IOMMU */
 
-#define PCI_DMA_BUS_IS_PHYS	1
 #define pci_dac_dma_supported(pci_dev, mask)    1
 
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-x86_64/swiotlb.h hg/include/asm-x86_64/swiotlb.h
--- vanilla/include/asm-x86_64/swiotlb.h	2005-11-03 08:38:45.000000000 +0200
+++ hg/include/asm-x86_64/swiotlb.h	2005-11-04 15:18:18.000000000 +0200
@@ -3,6 +3,8 @@
 
 #include <linux/config.h>
 
+#include <asm/dma-mapping.h>
+
 /* SWIOTLB interface */
 
 extern dma_addr_t swiotlb_map_single(struct device *hwdev, void *ptr, size_t size,
@@ -38,6 +40,9 @@ extern void *swiotlb_alloc_coherent (str
 				     dma_addr_t *dma_handle, gfp_t flags);
 extern void swiotlb_free_coherent (struct device *hwdev, size_t size,
 				   void *vaddr, dma_addr_t dma_handle);
+extern int swiotlb_dma_supported(struct device *hwdev, u64 mask);
+
+extern struct dma_mapping_ops swiotlb_dma_ops;
 
 #ifdef CONFIG_SWIOTLB
 extern int swiotlb;
@@ -45,4 +50,4 @@ extern int swiotlb;
 #define swiotlb 0
 #endif
 
-#endif
+#endif /* _ASM_SWTIOLB_H */


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

