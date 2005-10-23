Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVJWIIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVJWIIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 04:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVJWIIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 04:08:04 -0400
Received: from mtaout4.012.net.il ([84.95.2.10]:7307 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S1751102AbVJWIIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 04:08:02 -0400
Date: Sun, 23 Oct 2005 09:59:37 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [RFC PATCH] clean up x86_64 DMA mapping dispatching - version D1
In-reply-to: <20051021161129.GB3229@granada.merseine.nu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, jimix@watson.ibm.com, niv@us.ibm.com,
       jdmason@us.ibm.com, muli@il.ibm.com
Message-id: <20051023075937.GB15528@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20051021161129.GB3229@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 06:11:29PM +0200, Muli Ben-Yehuda wrote:

> This patch cleans up x86_64's DMA mapping dispatching code. Right now
> we have three possible IOMMU types: AGP GART, swiotlb and nommu, and
> in the future we will also have Xen's x86_64 swiotlb and other HW
> IOMMUs for x86_64. In order to support all of them cleanly, this
> patch:
> 
> - introduces a struct dma_mapping_ops with function pointers for each 
>   of the DMA mapping operations of gart (AMD HW IOMMU), swiotlb
>   (software IOMMU) and nommu (no IOMMU).
> 
> - gets rid of:
> 
>   if (swiotlb)
>       return swiotlb_xxx();
> 
>   in various places in favor of:
> 
>   if (unlikely(dma_mapping && dma_mapping->xxx))
>       return dma_mapping->xxx();
> 
>   in dma-mapping.h.
> 
> - in order to keep the fast path fast, if no mapping_ops is specified
>   the default gart ops are used. For this case there's a tiny
>   additional cost of an unlikely branch in dma_xxx(), which then calls
>   gart_xxx().
> 
> - I modeled the patch after the existing code structure; that means
>   that in places nommu and swiotlb use the gart functions and in one
>   place gart calls into swiotlb. The former is on purpose; the latter
>   is a wart and will be fixed in the next iteration. Further cleanups
>   to seperate the three are certainly possible.
> 
> The patch is against 2.6.14-rc5, and has been tested with each of
> gart, swiotlb and noiommu on a dual CPU AMD machine. Your comments
> appreciated!

Changes in -D1:

- restore missing EXPORT_SYMBOLS() in pci-nommu.c
- provide dummy gart_xxx() functions for the nommu case and avoid
  including pci-gart.c for CONFIG_DUMMY_IOMMU.
- fold pci-dma.c into pci-nommu.c
- nommu needs nommu_map_sg and nommu_unmap_sg.

Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>

--- 

 a/arch/x86_64/kernel/pci-dma.c      |   60 -------
 arch/x86_64/kernel/Makefile         |    2 
 arch/x86_64/kernel/pci-gart.c       |   66 ++------
 arch/x86_64/kernel/pci-nommu.c      |  119 ++++++++++++--
 arch/x86_64/kernel/setup.c          |   21 ++
 arch/x86_64/mm/init.c               |   13 +
 b/include/asm-x86_64/gart-mapping.h |   87 ++++++++++
 include/asm-x86_64/dma-mapping.h    |  295 +++++++++++++++++++++++-------------
 include/asm-x86_64/swiotlb.h        |   17 +-
 9 files changed, 453 insertions(+), 227 deletions(-)

diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 arch/x86_64/kernel/Makefile
--- a/arch/x86_64/kernel/Makefile	Thu Oct 20 15:00:36 2005
+++ b/arch/x86_64/kernel/Makefile	Sat Oct 22 20:31:51 2005
@@ -26,7 +26,7 @@
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
-obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
+obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Thu Oct 20 15:00:36 2005
+++ b/arch/x86_64/kernel/pci-gart.c	Sat Oct 22 20:31:51 2005
@@ -40,7 +40,6 @@
 u32 *iommu_gatt_base; 		/* Remapping table */
 
 int no_iommu; 
-static int no_agp; 
 #ifdef CONFIG_IOMMU_DEBUG
 int panic_on_overflow = 1; 
 int force_iommu = 1;
@@ -203,8 +202,8 @@
  * Allocate memory for a coherent mapping.
  */
 void *
-dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		   unsigned gfp)
+gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		    gfp_t gfp)
 {
 	void *memory;
 	unsigned long dma_mask = 0;
@@ -267,7 +266,7 @@
 	
 error:
 	if (panic_on_overflow)
-		panic("dma_alloc_coherent: IOMMU overflow by %lu bytes\n", size);
+		panic("gart_alloc_coherent: IOMMU overflow by %lu bytes\n", size);
 	free_pages((unsigned long)memory, get_order(size)); 
 	return NULL; 
 }
@@ -276,15 +275,10 @@
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
 
@@ -403,14 +397,12 @@
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
 
@@ -440,7 +432,7 @@
 			addr = dma_map_area(dev, addr, s->length, dir, 0);
 			if (addr == bad_dma_address) { 
 				if (i > 0) 
-					dma_unmap_sg(dev, sg, i, dir);
+					gart_unmap_sg(dev, sg, i, dir);
 				nents = 0; 
 				sg[0].dma_length = 0;
 				break;
@@ -509,7 +501,7 @@
  * DMA map all entries in a scatterlist.
  * Merge chunks that have page aligned sizes into a continuous mapping. 
  */
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
+int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
 {
 	int i;
 	int out;
@@ -521,8 +513,6 @@
 	if (nents == 0) 
 		return 0;
 
-	if (swiotlb)
-		return swiotlb_map_sg(dev,sg,nents,dir);
 	if (!dev)
 		dev = &fallback_dev;
 
@@ -565,7 +555,7 @@
 
 error:
 	flush_gart(NULL);
-	dma_unmap_sg(dev, sg, nents, dir);
+	gart_unmap_sg(dev, sg, nents, dir);
 	/* When it was forced try again unforced */
 	if (force_iommu) 
 		return dma_map_sg_nonforce(dev, sg, nents, dir);
@@ -580,17 +570,12 @@
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
-
-	if (swiotlb) {
-		swiotlb_unmap_single(dev,dma_addr,size,direction);
-		return;
-	}
 
 	if (dma_addr < iommu_bus_base + EMERGENCY_PAGES*PAGE_SIZE || 
 	    dma_addr >= iommu_bus_base + iommu_size)
@@ -607,13 +592,10 @@
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
@@ -622,7 +604,7 @@
 	}
 }
 
-int dma_supported(struct device *dev, u64 mask)
+int gart_dma_supported(struct device *dev, u64 mask)
 {
 	/* Copied from i386. Doesn't make much sense, because it will 
 	   only work for pci_alloc_coherent.
@@ -648,24 +630,20 @@
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
 EXPORT_SYMBOL(bad_dma_address);
 EXPORT_SYMBOL(iommu_bio_merge);
 EXPORT_SYMBOL(iommu_sac_force);
-EXPORT_SYMBOL(dma_get_cache_alignment);
-EXPORT_SYMBOL(dma_alloc_coherent);
-EXPORT_SYMBOL(dma_free_coherent);
+EXPORT_SYMBOL(gart_alloc_coherent);
+EXPORT_SYMBOL(gart_free_coherent);
+
+static int no_agp; 
 
 static __init unsigned long check_iommu_size(unsigned long aper, u64 aper_size)
 { 
diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 arch/x86_64/kernel/pci-nommu.c
--- a/arch/x86_64/kernel/pci-nommu.c	Thu Oct 20 15:00:36 2005
+++ b/arch/x86_64/kernel/pci-nommu.c	Sat Oct 22 20:31:51 2005
@@ -23,8 +23,8 @@
  * Dummy IO MMU functions
  */
 
-void *dma_alloc_coherent(struct device *hwdev, size_t size,
-			 dma_addr_t *dma_handle, unsigned gfp)
+void *nommu_alloc_coherent(struct device *hwdev, size_t size,
+			 dma_addr_t *dma_handle, gfp_t gfp)
 {
 	void *ret;
 	u64 mask;
@@ -50,16 +50,16 @@
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
+int nommu_dma_supported(struct device *hwdev, u64 mask)
 {
         /*
          * we fall back to GFP_DMA when the mask isn't all 1s,
@@ -73,22 +73,115 @@
 
 	return 1;
 } 
-EXPORT_SYMBOL(dma_supported);
+EXPORT_SYMBOL(nommu_dma_supported);
 
-int dma_get_cache_alignment(void)
+dma_addr_t 
+nommu_map_single(struct device *hwdev, void *ptr, size_t size, int direction)
 {
-	return boot_cpu_data.x86_clflush_size;
+	dma_addr_t addr;
+
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+	addr = virt_to_bus(ptr);
+
+	if ((addr+size) & ~*hwdev->dma_mask)
+		out_of_line_bug();
+	return addr;
 }
-EXPORT_SYMBOL(dma_get_cache_alignment);
+EXPORT_SYMBOL(nommu_map_single);
 
-static int __init check_ram(void) 
+void
+nommu_unmap_single(struct device *hwdev, dma_addr_t dma_addr, size_t size, 
+		   int direction)
+{
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+	/* Nothing to do */
+}
+EXPORT_SYMBOL(nommu_unmap_single);
+
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
+{
+	int i;
+
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
+
+/* Unmap a set of streaming mode DMA translations.
+ * Again, cpu read rules concerning calls here are the same as for
+ * pci_unmap_single() above.
+ */
+void nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
+		  int nents, int dir)
+{
+	int i;
+	for (i = 0; i < nents; i++) { 
+		struct scatterlist *s = &sg[i];
+		BUG_ON(s->page == NULL); 
+		BUG_ON(s->dma_address == 0); 
+		dma_unmap_single(dev, s->dma_address, s->dma_length, dir);
+	} 
+}
+EXPORT_SYMBOL(nommu_unmap_sg);
+
+static void check_ram(void) 
 { 
 	if (end_pfn >= 0xffffffff>>PAGE_SHIFT) { 
 		printk(
 		KERN_ERR "WARNING more than 4GB of memory but IOMMU not compiled in.\n"
 		KERN_ERR "WARNING 32bit PCI may malfunction.\n");
 	} 
+} 
+
+struct dma_mapping_ops nommu_mapping_ops = {
+	.mapping_error = NULL, /* default */
+	.alloc_coherent = nommu_alloc_coherent,
+	.free_coherent = nommu_free_coherent,
+	.map_single = nommu_map_single,
+	.unmap_single = nommu_unmap_single,
+	.unmap_sg = nommu_unmap_sg,
+	.map_sg = nommu_map_sg,
+	.dma_supported = nommu_dma_supported,
+	.sync_single_for_cpu = NULL,
+	.sync_single_for_device = NULL,
+	.sync_sg_for_cpu = NULL,
+	.sync_sg_for_device = NULL,
+};
+
+static int __init nommu_init(void)
+{
+	printk("%s: setting mapping_ops to nommu_mapping_ops(%p)\n", 
+	       __func__, &nommu_mapping_ops);
+
+	mapping_ops = &nommu_mapping_ops;
+
+	check_ram();
+
 	return 0;
-} 
-__initcall(check_ram);
+}
 
+__initcall(nommu_init);
diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c	Thu Oct 20 15:00:36 2005
+++ b/arch/x86_64/kernel/setup.c	Sat Oct 22 20:31:51 2005
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
@@ -86,8 +88,27 @@
 
 #ifdef CONFIG_SWIOTLB
 int swiotlb;
+struct dma_mapping_ops swiotlb_mapping_ops = {
+	.mapping_error = swiotlb_dma_mapping_error,
+	.alloc_coherent = NULL, /* we are called via gart_alloc_coherent */
+	.free_coherent = swiotlb_free_coherent,
+	.map_single = swiotlb_map_single,
+	.unmap_single = swiotlb_unmap_single,
+	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
+	.sync_single_for_device = swiotlb_sync_single_for_device,
+	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device = swiotlb_sync_sg_for_device,
+	.map_sg = swiotlb_map_sg,
+	.unmap_sg = swiotlb_unmap_sg,
+	/* historically we didn't use swiotlb_dma_supported, so keep it the same way */
+	.dma_supported = NULL
+};
+
 EXPORT_SYMBOL(swiotlb);
 #endif
+
+struct dma_mapping_ops* mapping_ops;
+EXPORT_SYMBOL(mapping_ops);
 
 /*
  * Setup options
diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 arch/x86_64/mm/init.c
--- a/arch/x86_64/mm/init.c	Thu Oct 20 15:00:36 2005
+++ b/arch/x86_64/mm/init.c	Sat Oct 22 20:31:51 2005
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
@@ -388,12 +390,19 @@
 {
 	long codesize, reservedpages, datasize, initsize;
 
+	printk("%s: setting mapping_ops to NULL\n", __func__);
+	mapping_ops = NULL;
+
 #ifdef CONFIG_SWIOTLB
 	if (!iommu_aperture &&
 	    (end_pfn >= 0xffffffff>>PAGE_SHIFT || force_iommu))
 	       swiotlb = 1;
-	if (swiotlb)
-		swiotlb_init();	
+	if (swiotlb) {
+		swiotlb_init();
+		mapping_ops = &swiotlb_mapping_ops;
+		printk("%s: setting mapping_ops to swiotlb_mapping_ops(%p)\n", 
+		       __func__, &swiotlb_mapping_ops);
+	}
 #endif
 
 	/* How many end-of-memory variables you have, grandma! */
diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 include/asm-x86_64/dma-mapping.h
--- a/include/asm-x86_64/dma-mapping.h	Thu Oct 20 15:00:36 2005
+++ b/include/asm-x86_64/dma-mapping.h	Sat Oct 22 20:31:51 2005
@@ -11,120 +11,205 @@
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 #include <asm/swiotlb.h>
+#include <asm/gart-mapping.h>
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
-
-void *dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-			 unsigned gfp);
-void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-			 dma_addr_t dma_handle);
-
-#ifdef CONFIG_GART_IOMMU
-
-extern dma_addr_t dma_map_single(struct device *hwdev, void *ptr, size_t size,
-				 int direction);
-extern void dma_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
-			     int direction);
-
-#else
-
-/* No IOMMU */
-
-static inline dma_addr_t dma_map_single(struct device *hwdev, void *ptr,
-					size_t size, int direction)
-{
-	dma_addr_t addr;
-
-	if (direction == DMA_NONE)
-		out_of_line_bug();
-	addr = virt_to_bus(ptr);
-
-	if ((addr+size) & ~*hwdev->dma_mask)
-		out_of_line_bug();
-	return addr;
-}
-
-static inline void dma_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
-				    size_t size, int direction)
-{
-	if (direction == DMA_NONE)
-		out_of_line_bug();
-	/* Nothing to do */
-}
-
-#endif
+extern struct dma_mapping_ops* mapping_ops;
+
+static inline int dma_mapping_error(dma_addr_t dma_addr)
+{
+	if (mapping_ops && mapping_ops->mapping_error)
+		return mapping_ops->mapping_error(dma_addr);
+
+	return (dma_addr == bad_dma_address);
+}
+
+static inline void*
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle, 
+		   gfp_t gfp)
+{
+	if (unlikely(mapping_ops && mapping_ops->alloc_coherent))
+		return mapping_ops->alloc_coherent(dev, size, dma_handle, gfp);
+
+	return gart_alloc_coherent(dev, size, dma_handle, gfp);
+}
+
+static inline void 
+dma_free_coherent(struct device *dev, size_t size, void *vaddr,
+		   dma_addr_t dma_handle)
+{
+	if (unlikely(mapping_ops && mapping_ops->free_coherent)) {
+		mapping_ops->free_coherent(dev, size, vaddr, dma_handle);
+		return;
+	}
+	
+	gart_free_coherent(dev, size, vaddr, dma_handle);
+}
+
+static inline dma_addr_t
+dma_map_single(struct device *hwdev, void *ptr, size_t size,
+	       int direction)
+{
+	if (unlikely(mapping_ops && mapping_ops->map_single))
+		return mapping_ops->map_single(hwdev, ptr, size, direction);
+
+	return gart_map_single(hwdev, ptr, size, direction);
+}
+
+static inline void 
+dma_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
+		 int direction)
+{
+	if (unlikely(mapping_ops && mapping_ops->unmap_single)) {
+		mapping_ops->unmap_single(dev, addr, size, direction);
+		return;
+	}
+
+	gart_unmap_single(dev, addr, size, direction);
+}
 
 #define dma_map_page(dev,page,offset,size,dir) \
 	dma_map_single((dev), page_address(page)+(offset), (size), (dir))
+
+#define dma_unmap_page dma_unmap_single
 
 static inline void dma_sync_single_for_cpu(struct device *hwdev,
 					       dma_addr_t dma_handle,
 					       size_t size, int direction)
 {
-	if (direction == DMA_NONE)
-		out_of_line_bug();
-
-	if (swiotlb)
-		return swiotlb_sync_single_for_cpu(hwdev,dma_handle,size,direction);
-
-	flush_write_buffers();
-}
-
-static inline void dma_sync_single_for_device(struct device *hwdev,
-						  dma_addr_t dma_handle,
-						  size_t size, int direction)
-{
-        if (direction == DMA_NONE)
-		out_of_line_bug();
-
-	if (swiotlb)
-		return swiotlb_sync_single_for_device(hwdev,dma_handle,size,direction);
-
-	flush_write_buffers();
-}
-
-#define dma_sync_single_range_for_cpu(dev, dma_handle, offset, size, dir)       \
-        dma_sync_single_for_cpu(dev, dma_handle, size, dir)
-#define dma_sync_single_range_for_device(dev, dma_handle, offset, size, dir)    \
-        dma_sync_single_for_device(dev, dma_handle, size, dir)
-
-static inline void dma_sync_sg_for_cpu(struct device *hwdev,
-				       struct scatterlist *sg,
-				       int nelems, int direction)
-{
-	if (direction == DMA_NONE)
-		out_of_line_bug();
-
-	if (swiotlb)
-		return swiotlb_sync_sg_for_cpu(hwdev,sg,nelems,direction);
-
-	flush_write_buffers();
-}
-
-static inline void dma_sync_sg_for_device(struct device *hwdev,
-					  struct scatterlist *sg,
-					  int nelems, int direction)
-{
-	if (direction == DMA_NONE)
-		out_of_line_bug();
-
-	if (swiotlb)
-		return swiotlb_sync_sg_for_device(hwdev,sg,nelems,direction);
-
-	flush_write_buffers();
-}
-
-extern int dma_map_sg(struct device *hwdev, struct scatterlist *sg,
-		      int nents, int direction);
-extern void dma_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-			 int nents, int direction);
-
-#define dma_unmap_page dma_unmap_single
-
-extern int dma_supported(struct device *hwdev, u64 mask);
-extern int dma_get_cache_alignment(void);
+	void (*f)(struct device *hwdev, dma_addr_t dma_handle,
+		  size_t size, int direction);
+	
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+
+	if (unlikely(mapping_ops && mapping_ops->sync_single_for_cpu)) {
+		f = mapping_ops->sync_single_for_cpu;
+		f(hwdev, dma_handle, size, direction);
+		return;
+	}
+
+	flush_write_buffers();
+}
+
+static inline void 
+dma_sync_single_for_device(struct device *hwdev, dma_addr_t dma_handle,
+			   size_t size, int direction)
+{
+	void (*f)(struct device *hwdev, dma_addr_t dma_handle,
+		  size_t size, int direction);
+	
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+
+	if (unlikely(mapping_ops && mapping_ops->sync_single_for_device)) {
+		f = mapping_ops->sync_single_for_device;
+		f(hwdev, dma_handle, size, direction);
+		return;
+	}
+
+	flush_write_buffers();
+}
+
+static inline void 
+dma_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
+		    int nelems, int direction)
+{
+	void (*f)(struct device *hwdev, struct scatterlist *sg,
+		  int nelems, int direction);
+
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+
+	if (unlikely(mapping_ops && mapping_ops->sync_sg_for_cpu)) {
+		f = mapping_ops->sync_sg_for_cpu;
+		f(hwdev, sg, nelems, direction);
+		return;
+	}
+
+	flush_write_buffers();
+}
+
+static inline void 
+dma_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+		       int nelems, int direction)
+{
+	void (*f)(struct device *hwdev, struct scatterlist *sg,
+		  int nelems, int direction);
+
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+
+	if (unlikely(mapping_ops && mapping_ops->sync_sg_for_device)) {
+		f = mapping_ops->sync_sg_for_device;
+		f(hwdev, sg, nelems, direction);
+		return;
+	}
+
+	flush_write_buffers();
+}
+
+static inline int dma_map_sg(struct device *hwdev, struct scatterlist *sg,
+			     int nents, int direction)
+{
+	if (unlikely(mapping_ops && mapping_ops->map_sg))
+		return mapping_ops->map_sg(hwdev, sg, nents, direction);
+
+	return gart_map_sg(hwdev, sg, nents, direction);
+}
+
+static inline void dma_unmap_sg(struct device *hwdev, struct scatterlist *sg,
+				int nents, int direction)
+{
+	if (unlikely(mapping_ops && mapping_ops->unmap_sg)) {
+		mapping_ops->unmap_sg(hwdev, sg, nents, direction);
+		return;
+	}
+
+	gart_unmap_sg(hwdev, sg, nents, direction);
+}
+
+static inline int dma_supported(struct device *hwdev, u64 mask)
+{
+	if (mapping_ops && mapping_ops->dma_supported)
+		return mapping_ops->dma_supported(hwdev, mask);
+
+	return gart_dma_supported(hwdev, mask);
+}
+
+/* same for gart, swiotlb, and nommu */
+static inline int dma_get_cache_alignment(void)
+{
+	return boot_cpu_data.x86_clflush_size;
+}
+
 #define dma_is_consistent(h) 1
 
 static inline int dma_set_mask(struct device *dev, u64 mask)
@@ -140,4 +225,4 @@
 	flush_write_buffers();
 }
 
-#endif
+#endif /* _X8664_DMA_MAPPING_H */
diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 include/asm-x86_64/swiotlb.h
--- a/include/asm-x86_64/swiotlb.h	Thu Oct 20 15:00:36 2005
+++ b/include/asm-x86_64/swiotlb.h	Sat Oct 22 20:31:51 2005
@@ -2,6 +2,8 @@
 #define _ASM_SWTIOLB_H 1
 
 #include <linux/config.h>
+
+#include <asm/dma-mapping.h>
 
 /* SWIOTLB interface */
 
@@ -15,6 +17,14 @@
 extern void swiotlb_sync_single_for_device(struct device *hwdev,
 					    dma_addr_t dev_addr,
 					    size_t size, int dir);
+extern void swiotlb_sync_single_range_for_cpu(struct device *hwdev,
+					      dma_addr_t dev_addr,
+					      unsigned long offset,
+					      size_t size, int dir);
+extern void swiotlb_sync_single_range_for_device(struct device *hwdev,
+						 dma_addr_t dev_addr,
+						 unsigned long offset,
+						 size_t size, int dir);
 extern void swiotlb_sync_sg_for_cpu(struct device *hwdev,
 				     struct scatterlist *sg, int nelems,
 				     int dir);
@@ -27,9 +37,12 @@
 			 int nents, int direction);
 extern int swiotlb_dma_mapping_error(dma_addr_t dma_addr);
 extern void *swiotlb_alloc_coherent (struct device *hwdev, size_t size,
-				     dma_addr_t *dma_handle, int flags);
+				     dma_addr_t *dma_handle, int gfp);
 extern void swiotlb_free_coherent (struct device *hwdev, size_t size,
 				   void *vaddr, dma_addr_t dma_handle);
+extern int swiotlb_dma_supported(struct device *hwdev, u64 mask);
+
+extern struct dma_mapping_ops swiotlb_mapping_ops;
 
 #ifdef CONFIG_SWIOTLB
 extern int swiotlb;
@@ -37,4 +50,4 @@
 #define swiotlb 0
 #endif
 
-#endif
+#endif /* _ASM_SWTIOLB_H */
diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 include/asm-x86_64/gart-mapping.h
--- /dev/null	Thu Oct 20 15:00:36 2005
+++ b/include/asm-x86_64/gart-mapping.h	Sat Oct 22 20:31:51 2005
@@ -0,0 +1,87 @@
+#ifndef _ASM_GART_MAPPING_H
+#define _ASM_GART_MAPPING_H 1
+
+#include <linux/config.h>
+
+#ifdef CONFIG_GART_IOMMU
+
+/* GART DMA mapping implemenation */
+extern void* 
+gart_alloc_coherent(struct device *dev, size_t size, 
+		    dma_addr_t *dma_handle, gfp_t gfp);
+
+extern void 
+gart_free_coherent(struct device *dev, size_t size, void *vaddr,
+		   dma_addr_t dma_handle);
+
+extern dma_addr_t
+gart_map_single(struct device *hwdev, void *ptr, size_t size,
+		int direction);
+
+extern void 
+gart_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
+		  int direction);
+
+extern int 
+gart_map_sg(struct device *hwdev, struct scatterlist *sg,
+	    int nents, int direction);
+
+extern void 
+gart_unmap_sg(struct device *hwdev, struct scatterlist *sg,
+	      int nents, int direction);
+
+extern int gart_dma_supported(struct device *hwdev, u64 mask);
+
+#else /* !CONFIG_GART_IOMMU */
+
+extern dma_addr_t bad_dma_address;
+
+/* GART DMA mapping implemenation */
+static inline void* 
+gart_alloc_coherent(struct device *dev, size_t size, 
+		    dma_addr_t *dma_handle, gfp_t gfp)
+{
+	return NULL;
+}
+
+static inline void 
+gart_free_coherent(struct device *dev, size_t size, void *vaddr,
+		   dma_addr_t dma_handle)
+{
+}
+
+static inline dma_addr_t
+gart_map_single(struct device *hwdev, void *ptr, size_t size,
+		int direction)
+{
+	return bad_dma_address;
+}
+
+static inline void
+gart_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
+		  int direction)
+{
+}
+
+static inline int 
+gart_map_sg(struct device *hwdev, struct scatterlist *sg,
+	    int nents, int direction)
+{
+	return 0;	
+}
+
+static inline void 
+gart_unmap_sg(struct device *hwdev, struct scatterlist *sg,
+	      int nents, int direction)
+{
+}
+
+static inline int 
+gart_dma_supported(struct device *hwdev, u64 mask)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_GART_IOMMU */
+
+#endif /* _ASM_SWTIOLB_H */
diff -r 01355122e23bd7163ea41cc430bfb8a90a396add -r 2460a0c4cc9a5480c399ed98699d4ab0eb287c14 arch/x86_64/kernel/pci-dma.c
--- a/arch/x86_64/kernel/pci-dma.c	Thu Oct 20 15:00:36 2005
+++ /dev/null	Sat Oct 22 20:31:51 2005
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


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

