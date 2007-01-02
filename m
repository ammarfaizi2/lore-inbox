Return-Path: <linux-kernel-owner+w=401wt.eu-S1755354AbXABQSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbXABQSU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbXABQSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:18:20 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:38645
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755349AbXABQST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:18:19 -0500
Message-Id: <459A942C.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 02 Jan 2007 16:19:40 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-ia64@vger.kernel.org>, <patches@x86-64.org>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] make swiotlb use bus_to_virt/virt_to_bus
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all phys_to_virt/virt_to_phys uses to bus_to_virt/virt_to_bus, as
is what is meant and what is needed in (at least) some virtualized
environments like Xen.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Index: 2.6.20-rc3-swiotlb-bugs/lib/swiotlb.c
===================================================================
--- 2.6.20-rc3-swiotlb-bugs.orig/lib/swiotlb.c	2007-01-02 12:31:52.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/lib/swiotlb.c	2007-01-02 16:50:42.000000000 +0100
@@ -36,7 +36,7 @@
 	                   ( (val) & ( (align) - 1)))
 
 #define SG_ENT_VIRT_ADDRESS(sg)	(page_address((sg)->page) + (sg)->offset)
-#define SG_ENT_PHYS_ADDRESS(SG)	virt_to_phys(SG_ENT_VIRT_ADDRESS(SG))
+#define SG_ENT_PHYS_ADDRESS(sg)	virt_to_bus(SG_ENT_VIRT_ADDRESS(sg))
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -163,7 +163,7 @@ swiotlb_init_with_default_size (size_t d
 	 */
 	io_tlb_overflow_buffer = alloc_bootmem_low(io_tlb_overflow);
 	printk(KERN_INFO "Placing software IO TLB between 0x%lx - 0x%lx\n",
-	       virt_to_phys(io_tlb_start), virt_to_phys(io_tlb_end));
+	       virt_to_bus(io_tlb_start), virt_to_bus(io_tlb_end));
 }
 
 void
@@ -244,7 +244,7 @@ swiotlb_late_init_with_default_size (siz
 
 	printk(KERN_INFO "Placing %ldMB software IO TLB between 0x%lx - "
 	       "0x%lx\n", (io_tlb_nslabs * (1 << IO_TLB_SHIFT)) >> 20,
-	       virt_to_phys(io_tlb_start), virt_to_phys(io_tlb_end));
+	       virt_to_bus(io_tlb_start), virt_to_bus(io_tlb_end));
 
 	return 0;
 
@@ -445,7 +445,7 @@ swiotlb_alloc_coherent(struct device *hw
 	flags |= GFP_DMA;
 
 	ret = (void *)__get_free_pages(flags, order);
-	if (ret && address_needs_mapping(hwdev, virt_to_phys(ret))) {
+	if (ret && address_needs_mapping(hwdev, virt_to_bus(ret))) {
 		/*
 		 * The allocated memory isn't reachable by the device.
 		 * Fall back on swiotlb_map_single().
@@ -465,11 +465,11 @@ swiotlb_alloc_coherent(struct device *hw
 		if (swiotlb_dma_mapping_error(handle))
 			return NULL;
 
-		ret = phys_to_virt(handle);
+		ret = bus_to_virt(handle);
 	}
 
 	memset(ret, 0, size);
-	dev_addr = virt_to_phys(ret);
+	dev_addr = virt_to_bus(ret);
 
 	/* Confirm address can be DMA'd by device */
 	if (address_needs_mapping(hwdev, dev_addr)) {
@@ -525,7 +525,7 @@ swiotlb_full(struct device *dev, size_t 
 dma_addr_t
 swiotlb_map_single(struct device *hwdev, void *ptr, size_t size, int dir)
 {
-	unsigned long dev_addr = virt_to_phys(ptr);
+	unsigned long dev_addr = virt_to_bus(ptr);
 	void *map;
 
 	BUG_ON(dir == DMA_NONE);
@@ -546,7 +546,7 @@ swiotlb_map_single(struct device *hwdev,
 		map = io_tlb_overflow_buffer;
 	}
 
-	dev_addr = virt_to_phys(map);
+	dev_addr = virt_to_bus(map);
 
 	/*
 	 * Ensure that the address returned is DMA'ble
@@ -569,7 +569,7 @@ void
 swiotlb_unmap_single(struct device *hwdev, dma_addr_t dev_addr, size_t size,
 		     int dir)
 {
-	char *dma_addr = phys_to_virt(dev_addr);
+	char *dma_addr = bus_to_virt(dev_addr);
 
 	BUG_ON(dir == DMA_NONE);
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
@@ -592,7 +592,7 @@ static inline void
 swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 		    size_t size, int dir, int target)
 {
-	char *dma_addr = phys_to_virt(dev_addr);
+	char *dma_addr = bus_to_virt(dev_addr);
 
 	BUG_ON(dir == DMA_NONE);
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
@@ -623,7 +623,7 @@ swiotlb_sync_single_range(struct device 
 			  unsigned long offset, size_t size,
 			  int dir, int target)
 {
-	char *dma_addr = phys_to_virt(dev_addr) + offset;
+	char *dma_addr = bus_to_virt(dev_addr) + offset;
 
 	BUG_ON(dir == DMA_NONE);
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
@@ -676,7 +676,7 @@ swiotlb_map_sg(struct device *hwdev, str
 
 	for (i = 0; i < nelems; i++, sg++) {
 		addr = SG_ENT_VIRT_ADDRESS(sg);
-		dev_addr = virt_to_phys(addr);
+		dev_addr = virt_to_bus(addr);
 		if (swiotlb_force || address_needs_mapping(hwdev, dev_addr)) {
 			void *map = map_single(hwdev, addr, sg->length, dir);
 			if (!map) {
@@ -709,7 +709,8 @@ swiotlb_unmap_sg(struct device *hwdev, s
 
 	for (i = 0; i < nelems; i++, sg++)
 		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
-			unmap_single(hwdev, (void *) phys_to_virt(sg->dma_address), sg->dma_length, dir);
+			unmap_single(hwdev, bus_to_virt(sg->dma_address),
+				     sg->dma_length, dir);
 		else if (dir == DMA_FROM_DEVICE)
 			dma_mark_clean(SG_ENT_VIRT_ADDRESS(sg), sg->dma_length);
 }
@@ -731,7 +732,7 @@ swiotlb_sync_sg(struct device *hwdev, st
 
 	for (i = 0; i < nelems; i++, sg++)
 		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
-			sync_single(hwdev, phys_to_virt(sg->dma_address),
+			sync_single(hwdev, bus_to_virt(sg->dma_address),
 				    sg->dma_length, dir, target);
 		else if (dir == DMA_FROM_DEVICE)
 			dma_mark_clean(SG_ENT_VIRT_ADDRESS(sg), sg->dma_length);
@@ -754,7 +755,7 @@ swiotlb_sync_sg_for_device(struct device
 int
 swiotlb_dma_mapping_error(dma_addr_t dma_addr)
 {
-	return (dma_addr == virt_to_phys(io_tlb_overflow_buffer));
+	return (dma_addr == virt_to_bus(io_tlb_overflow_buffer));
 }
 
 /*
@@ -766,7 +767,7 @@ swiotlb_dma_mapping_error(dma_addr_t dma
 int
 swiotlb_dma_supported (struct device *hwdev, u64 mask)
 {
-	return virt_to_phys(io_tlb_end - 1) <= mask;
+	return virt_to_bus(io_tlb_end - 1) <= mask;
 }
 
 EXPORT_SYMBOL(swiotlb_init);

