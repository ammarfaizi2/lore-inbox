Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWDXWyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWDXWyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWDXWyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:54:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:55014 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751359AbWDXWyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:54:14 -0400
Date: Mon, 24 Apr 2006 17:53:42 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mulix@mulix.org, ak@suse.de
Subject: [PATCH] x86-64: trivial gart clean-up
Message-ID: <20060424225342.GB14575@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial change to have gart_unmap_sg call gart_unmap_single directly,
instead of bouncing through the dma_unmap_single wrapper in
dma-mapping.h.  This change required moving the gart_unmap_single above
gart_unmap_sg, and under gart_map_single (which seems a more logical
place that its current location IMHO).

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 742849676406 arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Sun Apr 23 16:44:10 2006
+++ b/arch/x86_64/kernel/pci-gart.c	Mon Apr 24 15:17:52 2006
@@ -289,6 +289,28 @@
 }
 
 /*
+ * Free a DMA mapping.
+ */ 
+void gart_unmap_single(struct device *dev, dma_addr_t dma_addr,
+		      size_t size, int direction)
+{
+	unsigned long iommu_page; 
+	int npages;
+	int i;
+
+	if (dma_addr < iommu_bus_base + EMERGENCY_PAGES*PAGE_SIZE || 
+	    dma_addr >= iommu_bus_base + iommu_size)
+		return;
+	iommu_page = (dma_addr - iommu_bus_base)>>PAGE_SHIFT;	
+	npages = to_pages(dma_addr, size);
+	for (i = 0; i < npages; i++) { 
+		iommu_gatt_base[iommu_page + i] = gart_unmapped_entry; 
+		CLEAR_LEAK(iommu_page + i);
+	}
+	free_iommu(iommu_page, npages);
+}
+
+/*
  * Wrapper for pci_unmap_single working with scatterlists.
  */
 void gart_unmap_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
@@ -299,7 +321,7 @@
 		struct scatterlist *s = &sg[i];
 		if (!s->dma_length || !s->length)
 			break;
-		dma_unmap_single(dev, s->dma_address, s->dma_length, dir);
+		gart_unmap_single(dev, s->dma_address, s->dma_length, dir);
 	}
 }
 
@@ -457,28 +479,6 @@
 		sg[i].dma_address = bad_dma_address;
 	return 0;
 } 
-
-/*
- * Free a DMA mapping.
- */ 
-void gart_unmap_single(struct device *dev, dma_addr_t dma_addr,
-		      size_t size, int direction)
-{
-	unsigned long iommu_page; 
-	int npages;
-	int i;
-
-	if (dma_addr < iommu_bus_base + EMERGENCY_PAGES*PAGE_SIZE || 
-	    dma_addr >= iommu_bus_base + iommu_size)
-		return;
-	iommu_page = (dma_addr - iommu_bus_base)>>PAGE_SHIFT;	
-	npages = to_pages(dma_addr, size);
-	for (i = 0; i < npages; i++) { 
-		iommu_gatt_base[iommu_page + i] = gart_unmapped_entry; 
-		CLEAR_LEAK(iommu_page + i);
-	}
-	free_iommu(iommu_page, npages);
-}
 
 static int no_agp;
 
