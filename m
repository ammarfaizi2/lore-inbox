Return-Path: <linux-kernel-owner+w=401wt.eu-S1755350AbXABQRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbXABQRL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbXABQRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:17:11 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:38592
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754899AbXABQRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:17:10 -0500
Message-Id: <459A93E5.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 02 Jan 2007 16:18:29 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-ia64@vger.kernel.org>, <patches@x86-64.org>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] swiotlb bug fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes
- marking I-cache clean of pages DMAed to now only done for IA64
- broken multiple inclusion in include/asm-x86_64/swiotlb.h
- missing phys-to-virt translation in swiotlb_sync_sg()
- missing call to mark_clean in swiotlb_sync_sg()
- a (perhaps only theoretical) issue in swiotlb_dma_supported() when
  io_tlb_end is exactly at the end of memory

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.20-rc3/arch/ia64/mm/init.c	2007-01-02 16:04:52.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/arch/ia64/mm/init.c	2006-12-20 12:02:01.000000000 +0100
@@ -128,6 +128,25 @@ lazy_mmu_prot_update (pte_t pte)
 	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
 }
 
+/*
+ * Since DMA is i-cache coherent, any (complete) pages that were written via
+ * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
+ * flush them when they get mapped into an executable vm-area.
+ */
+void
+dma_mark_clean(void *addr, size_t size)
+{
+	unsigned long pg_addr, end;
+
+	pg_addr = PAGE_ALIGN((unsigned long) addr);
+	end = (unsigned long) addr + size;
+	while (pg_addr + PAGE_SIZE <= end) {
+		struct page *page = virt_to_page(pg_addr);
+		set_bit(PG_arch_1, &page->flags);
+		pg_addr += PAGE_SIZE;
+	}
+}
+
 inline void
 ia64_set_rbs_bot (void)
 {
--- linux-2.6.20-rc3/include/asm-ia64/dma.h	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/include/asm-ia64/dma.h	2006-12-20 12:02:01.000000000 +0100
@@ -19,4 +19,6 @@ extern unsigned long MAX_DMA_ADDRESS;
 
 #define free_dma(x)
 
+void dma_mark_clean(void *addr, size_t size);
+
 #endif /* _ASM_IA64_DMA_H */
--- linux-2.6.20-rc3/include/asm-x86_64/swiotlb.h	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/include/asm-x86_64/swiotlb.h	2007-01-02 16:12:20.000000000 +0100
@@ -1,6 +1,5 @@
 #ifndef _ASM_SWIOTLB_H
-#define _ASM_SWTIOLB_H 1
-
+#define _ASM_SWIOTLB_H 1
 
 #include <asm/dma-mapping.h>
 
@@ -52,4 +51,6 @@ extern int swiotlb;
 
 extern void pci_swiotlb_init(void);
 
-#endif /* _ASM_SWTIOLB_H */
+static inline void dma_mark_clean(void *addr, size_t size) {}
+
+#endif /* _ASM_SWIOTLB_H */
--- linux-2.6.20-rc3/lib/swiotlb.c	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.20-rc3-swiotlb-bugs/lib/swiotlb.c	2007-01-02 12:31:52.000000000 +0100
@@ -558,25 +558,6 @@ swiotlb_map_single(struct device *hwdev,
 }
 
 /*
- * Since DMA is i-cache coherent, any (complete) pages that were written via
- * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
- * flush them when they get mapped into an executable vm-area.
- */
-static void
-mark_clean(void *addr, size_t size)
-{
-	unsigned long pg_addr, end;
-
-	pg_addr = PAGE_ALIGN((unsigned long) addr);
-	end = (unsigned long) addr + size;
-	while (pg_addr + PAGE_SIZE <= end) {
-		struct page *page = virt_to_page(pg_addr);
-		set_bit(PG_arch_1, &page->flags);
-		pg_addr += PAGE_SIZE;
-	}
-}
-
-/*
  * Unmap a single streaming mode DMA translation.  The dma_addr and size must
  * match what was provided for in a previous swiotlb_map_single call.  All
  * other usages are undefined.
@@ -594,7 +575,7 @@ swiotlb_unmap_single(struct device *hwde
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
 		unmap_single(hwdev, dma_addr, size, dir);
 	else if (dir == DMA_FROM_DEVICE)
-		mark_clean(dma_addr, size);
+		dma_mark_clean(dma_addr, size);
 }
 
 /*
@@ -617,7 +598,7 @@ swiotlb_sync_single(struct device *hwdev
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
 		sync_single(hwdev, dma_addr, size, dir, target);
 	else if (dir == DMA_FROM_DEVICE)
-		mark_clean(dma_addr, size);
+		dma_mark_clean(dma_addr, size);
 }
 
 void
@@ -648,7 +629,7 @@ swiotlb_sync_single_range(struct device 
 	if (dma_addr >= io_tlb_start && dma_addr < io_tlb_end)
 		sync_single(hwdev, dma_addr, size, dir, target);
 	else if (dir == DMA_FROM_DEVICE)
-		mark_clean(dma_addr, size);
+		dma_mark_clean(dma_addr, size);
 }
 
 void
@@ -698,7 +679,6 @@ swiotlb_map_sg(struct device *hwdev, str
 		dev_addr = virt_to_phys(addr);
 		if (swiotlb_force || address_needs_mapping(hwdev, dev_addr)) {
 			void *map = map_single(hwdev, addr, sg->length, dir);
-			sg->dma_address = virt_to_bus(map);
 			if (!map) {
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
@@ -707,6 +687,7 @@ swiotlb_map_sg(struct device *hwdev, str
 				sg[0].dma_length = 0;
 				return 0;
 			}
+			sg->dma_address = virt_to_bus(map);
 		} else
 			sg->dma_address = dev_addr;
 		sg->dma_length = sg->length;
@@ -730,7 +711,7 @@ swiotlb_unmap_sg(struct device *hwdev, s
 		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
 			unmap_single(hwdev, (void *) phys_to_virt(sg->dma_address), sg->dma_length, dir);
 		else if (dir == DMA_FROM_DEVICE)
-			mark_clean(SG_ENT_VIRT_ADDRESS(sg), sg->dma_length);
+			dma_mark_clean(SG_ENT_VIRT_ADDRESS(sg), sg->dma_length);
 }
 
 /*
@@ -750,8 +731,10 @@ swiotlb_sync_sg(struct device *hwdev, st
 
 	for (i = 0; i < nelems; i++, sg++)
 		if (sg->dma_address != SG_ENT_PHYS_ADDRESS(sg))
-			sync_single(hwdev, (void *) sg->dma_address,
+			sync_single(hwdev, phys_to_virt(sg->dma_address),
 				    sg->dma_length, dir, target);
+		else if (dir == DMA_FROM_DEVICE)
+			dma_mark_clean(SG_ENT_VIRT_ADDRESS(sg), sg->dma_length);
 }
 
 void
@@ -783,7 +766,7 @@ swiotlb_dma_mapping_error(dma_addr_t dma
 int
 swiotlb_dma_supported (struct device *hwdev, u64 mask)
 {
-	return (virt_to_phys (io_tlb_end) - 1) <= mask;
+	return virt_to_phys(io_tlb_end - 1) <= mask;
 }
 
 EXPORT_SYMBOL(swiotlb_init);

