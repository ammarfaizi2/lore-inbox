Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTD1S3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTD1S3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:29:02 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:47364 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261226AbTD1S2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:28:48 -0400
To: rth@twiddle.net, ink@jurassic.park.msu.ru
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] DMA mapping API for Alpha
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 28 Apr 2003 20:38:27 +0200
Message-ID: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard, Ivan,

As part of my effort to get the Jensen up and running on the latest
2.5 kernels, I have introduced some support for the DMA API, rather
than relying on the generic PCI based one (which introduces problems
with the EISA bus).

So this patch implements both dma_* and pci_* operations on the
Jensen, as well as dma_* operations on all the other Alpha
variants. It's been tested it on both of my Alpha/EISA plateforms
(Jensen and Mikasa). Patch is against 2.5.68.

I would appreciate any comment on this stuff.

Thanks,

        M.

===== arch/alpha/kernel/alpha_ksyms.c 1.33 vs edited =====
--- 1.33/arch/alpha/kernel/alpha_ksyms.c	Tue Apr  1 00:29:49 2003
+++ edited/arch/alpha/kernel/alpha_ksyms.c	Mon Apr 28 17:19:36 2003
@@ -17,6 +17,7 @@
 #include <linux/tty.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/console.h>
@@ -259,4 +260,16 @@
 #ifdef CONFIG_ALPHA_IRONGATE
 EXPORT_SYMBOL(irongate_ioremap);
 EXPORT_SYMBOL(irongate_iounmap);
+#endif
+
+EXPORT_SYMBOL(dma_alloc_coherent);
+EXPORT_SYMBOL(dma_free_coherent);
+#ifndef CONFIG_ALPHA_JENSEN
+EXPORT_SYMBOL(dma_supported);
+EXPORT_SYMBOL(dma_map_single);
+EXPORT_SYMBOL(dma_unmap_single);
+EXPORT_SYMBOL(dma_map_page);
+EXPORT_SYMBOL(dma_unmap_page);
+EXPORT_SYMBOL(dma_map_sg);
+EXPORT_SYMBOL(dma_unmap_sg);
 #endif
===== arch/alpha/kernel/pci-noop.c 1.7 vs edited =====
--- 1.7/arch/alpha/kernel/pci-noop.c	Fri Feb 28 08:53:37 2003
+++ edited/arch/alpha/kernel/pci-noop.c	Mon Apr 28 19:43:31 2003
@@ -9,6 +9,8 @@
 #include <linux/bootmem.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
 
 #include "proto.h"
 
@@ -101,22 +103,59 @@
 	else
 		return -ENODEV;
 }
+
+/* Shamelessly picked from arch/i386/kernel/pci-dma.c, as it should
+ * fit the Jensen quite well. The rest of the generic DMA API lives in
+ * asm-alpha/dma-mapping.h. */
+
+void *dma_alloc_coherent(struct device *dev, size_t size,
+			 dma_addr_t *dma_handle, int gfp)
+{
+        void *ret;
+
+        /* ignore region specifiers */
+        gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
+
+        if (dev == NULL || (*dev->dma_mask < 0xffffffff))
+                gfp |= GFP_DMA;
+        ret = (void *)__get_free_pages(gfp, get_order(size));
+
+        if (ret != NULL) {
+                memset(ret, 0, size);
+                *dma_handle = virt_to_bus(ret);
+        }
+        return ret;
+}
+
+void dma_free_coherent(struct device *dev, size_t size,
+		       void *vaddr, dma_addr_t dma_handle)
+{
+        free_pages((unsigned long)vaddr, get_order(size));
+}
+
 /* stubs for the routines in pci_iommu.c */
 void *
 pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp)
 {
-	return NULL;
+	if (pdev)		/* Jensen has no PCI ! */
+		return NULL;
+
+	return dma_alloc_coherent (NULL, size, dma_addrp, GFP_ATOMIC);
 }
 void
 pci_free_consistent(struct pci_dev *pdev, size_t size, void *cpu_addr,
 		    dma_addr_t dma_addr)
 {
+	if (pdev)
+		return;
+
+	dma_free_coherent (NULL, size, cpu_addr, dma_addr);
 }
 dma_addr_t
 pci_map_single(struct pci_dev *pdev, void *cpu_addr, size_t size,
 	       int direction)
 {
-	return (dma_addr_t) 0;
+	return (dma_addr_t) virt_to_bus (cpu_addr);
 }
 void
 pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr, size_t size,
@@ -127,7 +166,14 @@
 pci_map_sg(struct pci_dev *pdev, struct scatterlist *sg, int nents,
 	   int direction)
 {
-	return 0;
+	int i;
+
+	for (i = 0; i < nents; i++) {
+		sg_dma_address (sg + i) = (dma_addr_t) virt_to_bus (page_address (sg[i].page) + sg[i].offset);
+		sg_dma_len (sg + i) = sg[i].length;
+	}
+	
+	return nents;
 }
 void
 pci_unmap_sg(struct pci_dev *pdev, struct scatterlist *sg, int nents,
===== arch/alpha/kernel/pci_iommu.c 1.16 vs edited =====
--- 1.16/arch/alpha/kernel/pci_iommu.c	Fri Apr  4 00:49:57 2003
+++ edited/arch/alpha/kernel/pci_iommu.c	Mon Apr 28 20:32:45 2003
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/bootmem.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/hwrpb.h>
@@ -212,17 +213,31 @@
    until either pci_unmap_single or pci_dma_sync_single is performed.  */
 
 static dma_addr_t
-pci_map_single_1(struct pci_dev *pdev, void *cpu_addr, size_t size,
+dma_map_single_1(struct device *dev, void *cpu_addr, size_t size,
 		 int dac_allowed)
 {
-	struct pci_controller *hose = pdev ? pdev->sysdata : pci_isa_hose;
-	dma_addr_t max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
+	struct pci_controller *hose;
+	struct pci_dev *pdev = NULL;
+	dma_addr_t max_dma;
 	struct pci_iommu_arena *arena;
 	long npages, dma_ofs, i;
 	unsigned long paddr;
 	dma_addr_t ret;
 	unsigned int align = 0;
 
+	if (dev) {
+		if (dev->bus == &pci_bus_type) {
+			pdev = to_pci_dev (dev);
+			hose = pdev->sysdata;
+		} else
+			hose = pci_isa_hose;
+
+		max_dma = *dev->dma_mask;
+	} else {
+		hose    = pci_isa_hose;
+		max_dma = ISA_DMA_MASK;
+	}
+	
 	paddr = __pa(cpu_addr);
 
 #if !DEBUG_NODIRECT
@@ -290,6 +305,16 @@
 }
 
 dma_addr_t
+dma_map_single (struct device *dev, void *cpu_addr, size_t size,
+		enum dma_data_direction dir)
+{
+	if (dir == DMA_NONE)
+		BUG();
+
+	return dma_map_single_1(dev, cpu_addr, size, 0);
+}
+
+dma_addr_t
 pci_map_single(struct pci_dev *pdev, void *cpu_addr, size_t size, int dir)
 {
 	int dac_allowed; 
@@ -298,7 +323,19 @@
 		BUG();
 
 	dac_allowed = pdev ? pci_dac_dma_supported(pdev, pdev->dma_mask) : 0; 
-	return pci_map_single_1(pdev, cpu_addr, size, dac_allowed);
+	return dma_map_single_1(pdev ? &pdev->dev : NULL, cpu_addr,
+				size, dac_allowed);
+}
+
+dma_addr_t
+dma_map_page (struct device *dev, struct page *page, unsigned long offset,
+	      size_t size, enum dma_data_direction dir)
+{
+	if (dir == DMA_NONE)
+		BUG();
+
+	return dma_map_single_1(dev, (char *)page_address(page) + offset,
+				size, 0);
 }
 
 dma_addr_t
@@ -311,7 +348,8 @@
 		BUG();
 
 	dac_allowed = pdev ? pci_dac_dma_supported(pdev, pdev->dma_mask) : 0; 
-	return pci_map_single_1(pdev, (char *)page_address(page) + offset, 
+	return dma_map_single_1(pdev ? &pdev->dev : NULL,
+				(char *)page_address(page) + offset, 
 				size, dac_allowed);
 }
 
@@ -322,17 +360,22 @@
    wrote there.  */
 
 void
-pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr, size_t size,
-		 int direction)
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
 {
 	unsigned long flags;
-	struct pci_controller *hose = pdev ? pdev->sysdata : pci_isa_hose;
+	struct pci_controller *hose;
 	struct pci_iommu_arena *arena;
 	long dma_ofs, npages;
 
-	if (direction == PCI_DMA_NONE)
+	if (direction == DMA_NONE)
 		BUG();
 
+	if (dev && dev->bus == &pci_bus_type)
+		hose = to_pci_dev(dev)->sysdata;
+	else
+		hose = pci_isa_hose;
+	
 	if (dma_addr >= __direct_map_base
 	    && dma_addr < __direct_map_base + __direct_map_size) {
 		/* Nothing to do.  */
@@ -381,10 +424,26 @@
 }
 
 void
+pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr, size_t size,
+		 int direction)
+{
+	dma_unmap_single (pdev ? &pdev->dev : NULL, dma_addr, size,
+			  (enum dma_data_direction) direction);
+}
+
+void
+dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
+	       size_t size, enum dma_data_direction direction)
+{
+	dma_unmap_single(dev, dma_addr, size, direction);
+}
+
+void
 pci_unmap_page(struct pci_dev *pdev, dma_addr_t dma_addr,
 	       size_t size, int direction)
 {
-	pci_unmap_single(pdev, dma_addr, size, direction);
+	dma_unmap_single (pdev ? &pdev->dev : NULL, dma_addr, size,
+			  (enum dma_data_direction) direction);
 }
 
 /* Allocate and map kernel buffer using consistent mode DMA for PCI
@@ -393,11 +452,11 @@
    else DMA_ADDRP is undefined.  */
 
 void *
-pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp)
+dma_alloc_coherent (struct device *dev, size_t size,
+		    dma_addr_t *dma_addrp, int gfp)
 {
 	void *cpu_addr;
 	long order = get_order(size);
-	int gfp = GFP_ATOMIC;
 
 try_again:
 	cpu_addr = (void *)__get_free_pages(gfp, order);
@@ -411,7 +470,7 @@
 	}
 	memset(cpu_addr, 0, size);
 
-	*dma_addrp = pci_map_single_1(pdev, cpu_addr, size, 0);
+	*dma_addrp = dma_map_single_1(dev, cpu_addr, size, 0);
 	if (*dma_addrp == 0) {
 		free_pages((unsigned long)cpu_addr, order);
 		if (alpha_mv.mv_pci_tbi || (gfp & GFP_DMA))
@@ -422,12 +481,19 @@
 		goto try_again;
 	}
 		
-	DBGA2("pci_alloc_consistent: %lx -> [%p,%x] from %p\n",
+	DBGA2("dma_alloc_coherent: %lx -> [%p,%x] from %p\n",
 	      size, cpu_addr, *dma_addrp, __builtin_return_address(0));
 
 	return cpu_addr;
 }
 
+void *
+pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp)
+{
+	return dma_alloc_coherent (pdev ? &pdev->dev : NULL, size,
+				   dma_addrp, GFP_ATOMIC);
+}
+
 /* Free and unmap a consistent DMA buffer.  CPU_ADDR and DMA_ADDR must
    be values that were returned from pci_alloc_consistent.  SIZE must
    be the same as what as passed into pci_alloc_consistent.
@@ -435,16 +501,23 @@
    DMA_ADDR past this call are illegal.  */
 
 void
-pci_free_consistent(struct pci_dev *pdev, size_t size, void *cpu_addr,
-		    dma_addr_t dma_addr)
+dma_free_coherent (struct device *dev, size_t size, void *cpu_addr,
+		   dma_addr_t dma_addr)
 {
-	pci_unmap_single(pdev, dma_addr, size, PCI_DMA_BIDIRECTIONAL);
+	dma_unmap_single(dev, dma_addr, size, DMA_BIDIRECTIONAL);
 	free_pages((unsigned long)cpu_addr, get_order(size));
 
-	DBGA2("pci_free_consistent: [%x,%lx] from %p\n",
+	DBGA2("dma_free_coherent: [%x,%lx] from %p\n",
 	      dma_addr, size, __builtin_return_address(0));
 }
 
+void
+pci_free_consistent(struct pci_dev *pdev, size_t size, void *cpu_addr,
+		    dma_addr_t dma_addr)
+{
+	dma_free_coherent (pdev ? &pdev->dev : NULL, size, cpu_addr, dma_addr);
+}
+
 
 /* Classify the elements of the scatterlist.  Write dma_address
    of each element with:
@@ -600,25 +673,39 @@
 }
 
 int
-pci_map_sg(struct pci_dev *pdev, struct scatterlist *sg, int nents,
-	   int direction)
+dma_map_sg (struct device *dev, struct scatterlist *sg, int nents,
+	    enum dma_data_direction direction)
 {
 	struct scatterlist *start, *end, *out;
 	struct pci_controller *hose;
 	struct pci_iommu_arena *arena;
+	struct pci_dev *pdev = NULL;
 	dma_addr_t max_dma;
 	int dac_allowed;
 
-	if (direction == PCI_DMA_NONE)
+	if (direction == DMA_NONE)
 		BUG();
 
+	if (dev) {
+		if (dev->bus == &pci_bus_type) {
+			pdev = to_pci_dev (dev);
+			hose = pdev->sysdata;
+		} else
+			hose = pci_isa_hose;
+
+		max_dma = *dev->dma_mask;
+	} else {
+		hose    = pci_isa_hose;
+		max_dma = ISA_DMA_MASK;
+	}
+	
 	dac_allowed = pdev ? pci_dac_dma_supported(pdev, pdev->dma_mask) : 0;
 
 	/* Fast path single entry scatterlists.  */
 	if (nents == 1) {
 		sg->dma_length = sg->length;
 		sg->dma_address
-		  = pci_map_single_1(pdev, SG_ENT_VIRT_ADDRESS(sg),
+		  = dma_map_single_1(dev, SG_ENT_VIRT_ADDRESS(sg),
 				     sg->length, dac_allowed);
 		return sg->dma_address != 0;
 	}
@@ -631,8 +718,6 @@
 
 	/* Second, figure out where we're going to map things.  */
 	if (alpha_mv.mv_pci_tbi) {
-		hose = pdev ? pdev->sysdata : pci_isa_hose;
-		max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
 		arena = hose->sg_pci;
 		if (!arena || arena->dma_base + arena->size - 1 > max_dma)
 			arena = hose->sg_isa;
@@ -669,33 +754,53 @@
 	/* Some allocation failed while mapping the scatterlist
 	   entries.  Unmap them now.  */
 	if (out > start)
-		pci_unmap_sg(pdev, start, out - start, direction);
+		dma_unmap_sg(dev, start, out - start, direction);
 	return 0;
 }
 
+int
+pci_map_sg(struct pci_dev *pdev, struct scatterlist *sg, int nents,
+	   int direction)
+{
+	return dma_map_sg (pdev ? &pdev->dev : NULL, sg, nents,
+			   (enum dma_data_direction) direction);
+}
+
 /* Unmap a set of streaming mode DMA translations.  Again, cpu read
    rules concerning calls here are the same as for pci_unmap_single()
    above.  */
 
 void
-pci_unmap_sg(struct pci_dev *pdev, struct scatterlist *sg, int nents,
-	     int direction)
+dma_unmap_sg (struct device *dev, struct scatterlist *sg, int nents,
+	      enum dma_data_direction direction)
 {
 	unsigned long flags;
 	struct pci_controller *hose;
 	struct pci_iommu_arena *arena;
+	struct pci_dev *pdev = NULL;
 	struct scatterlist *end;
 	dma_addr_t max_dma;
 	dma_addr_t fbeg, fend;
 
-	if (direction == PCI_DMA_NONE)
+	if (direction == DMA_NONE)
 		BUG();
 
 	if (! alpha_mv.mv_pci_tbi)
 		return;
 
-	hose = pdev ? pdev->sysdata : pci_isa_hose;
-	max_dma = pdev ? pdev->dma_mask : ISA_DMA_MASK;
+	if (dev) {
+		if (dev->bus == &pci_bus_type) {
+			pdev = to_pci_dev (dev);
+			hose = pdev->sysdata;
+		} else
+			hose = pci_isa_hose;
+
+		max_dma = *dev->dma_mask;
+	} else {
+		hose    = pci_isa_hose;
+		max_dma = ISA_DMA_MASK;
+	}
+	
 	arena = hose->sg_pci;
 	if (!arena || arena->dma_base + arena->size - 1 > max_dma)
 		arena = hose->sg_isa;
@@ -750,15 +855,22 @@
 
 	spin_unlock_irqrestore(&arena->lock, flags);
 
-	DBGA("pci_unmap_sg: %ld entries\n", nents - (end - sg));
+	DBGA("dma_unmap_sg: %ld entries\n", nents - (end - sg));
+}
+
+void
+pci_unmap_sg(struct pci_dev *pdev, struct scatterlist *sg, int nents,
+	     int direction)
+{
+	dma_unmap_sg (pdev ? &pdev->dev : NULL, sg, nents,
+		      (enum dma_data_direction) direction);
 }
 
 
 /* Return whether the given PCI device DMA address mask can be
    supported properly.  */
 
-int
-pci_dma_supported(struct pci_dev *pdev, u64 mask)
+int dma_supported (struct device *dev, u64 mask)
 {
 	struct pci_controller *hose;
 	struct pci_iommu_arena *arena;
@@ -772,7 +884,10 @@
 		return 1;
 
 	/* Check that we have a scatter-gather arena that fits.  */
-	hose = pdev ? pdev->sysdata : pci_isa_hose;
+	if (dev && dev->bus == &pci_bus_type)
+		hose = to_pci_dev(dev)->sysdata;
+	else
+		hose = pci_isa_hose;
 	arena = hose->sg_isa;
 	if (arena && arena->dma_base + arena->size - 1 <= mask)
 		return 1;
@@ -785,6 +900,12 @@
 		return 1;
 
 	return 0;
+}
+
+int
+pci_dma_supported(struct pci_dev *pdev, u64 mask)
+{
+	return dma_supported (pdev ? &pdev->dev : NULL, mask);
 }
 
 
===== include/asm-alpha/dma-mapping.h 1.1 vs edited =====
--- 1.1/include/asm-alpha/dma-mapping.h	Sun Dec 22 05:36:49 2002
+++ edited/include/asm-alpha/dma-mapping.h	Mon Apr 28 19:50:32 2003
@@ -1 +1,159 @@
-#include <asm-generic/dma-mapping.h>
+#ifndef _ASM_ALPHA_DMA_MAPPING_H
+#define _ASM_ALPHA_DMA_MAPPING_H
+
+#include <linux/config.h>
+#include <asm/cache.h>
+
+#ifdef CONFIG_ALPHA_JENSEN
+#include <asm/io.h>
+
+/* Jensen is somewhat x86 like... */
+
+static inline dma_addr_t
+dma_map_single(struct device *dev, void *ptr, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+	return virt_to_bus(ptr);
+}
+
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+}
+
+static inline int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
+{
+	int i;
+
+	BUG_ON(direction == DMA_NONE);
+
+	for (i = 0; i < nents; i++ ) {
+		BUG_ON(!sg[i].page);
+
+		sg_dma_address (sg + i) = (dma_addr_t) virt_to_bus (page_address (sg[i].page) + sg[i].offset);
+		sg_dma_len (sg + i) = sg[i].length;
+	}
+
+	return nents;
+}
+
+static inline dma_addr_t
+dma_map_page(struct device *dev, struct page *page, unsigned long offset,
+	     size_t size, enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+	return (dma_addr_t)(page_to_pfn(page)) * PAGE_SIZE + offset;
+}
+
+static inline void
+dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+}
+
+
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	     enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+}
+
+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+        /*
+         * we fall back to GFP_DMA when the mask isn't all 1s,
+         * so we can't guarantee allocations that must be
+         * within a tighter range than GFP_DMA..
+         */
+        if(mask < 0x00ffffff)
+                return 0;
+
+	return 1;
+}
+
+#else
+
+/* All other Alphas are using an IOMMU */
+
+dma_addr_t dma_map_single     (struct device *dev, void *cpu_addr, size_t size,
+			       enum dma_data_direction direction);
+void       dma_unmap_single   (struct device *dev, dma_addr_t dma_addr,
+			       size_t size, enum dma_data_direction direction);
+dma_addr_t dma_map_page       (struct device *dev, struct page *page,
+			       unsigned long offset, size_t size,
+			       enum dma_data_direction direction);
+void       dma_unmap_page     (struct device *dev, dma_addr_t dma_address,
+			       size_t size, enum dma_data_direction direction);
+int        dma_map_sg         (struct device *dev, struct scatterlist *sg,
+			       int nents, enum dma_data_direction direction);
+void       dma_unmap_sg       (struct device *dev, struct scatterlist *sg,
+			       int nents, enum dma_data_direction direction);
+int        dma_supported      (struct device *dev, u64 mask);
+
+#endif
+
+/* This is common to all Alphas, at least for the time being... */
+
+#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
+#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
+#define dma_is_consistent(d)	(1)
+
+void *dma_alloc_coherent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle, int flag);
+
+void dma_free_coherent(struct device *dev, size_t size,
+			 void *vaddr, dma_addr_t dma_handle);
+
+static inline void
+dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+}
+
+static inline void
+dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
+		      unsigned long offset, size_t size,
+		      enum dma_data_direction direction)
+{
+}
+
+static inline void
+dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+	    enum dma_data_direction direction)
+{
+}
+
+static inline void
+dma_cache_sync(void *vaddr, size_t size,
+	       enum dma_data_direction direction)
+{
+}
+
+static inline int
+dma_get_cache_alignment(void)
+{
+	/* no easy way to get cache size on all processors, so return
+	 * the maximum possible, to be safe */
+	return (1 << L1_CACHE_SHIFT_MAX);
+}
+
+static inline int
+dma_set_mask(struct device *dev, u64 mask)
+{
+	if(!dev->dma_mask || !dma_supported(dev, mask))
+		return -EIO;
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+
+#endif

-- 
Places change, faces change. Life is so very strange.
