Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTD1BNG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTD1BNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:13:06 -0400
Received: from holomorphy.com ([66.224.33.161]:6593 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262577AbTD1BNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:13:04 -0400
Date: Sun, 27 Apr 2003 18:25:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.5.68-1
Message-ID: <20030428012517.GB8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030422122747.GD8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422122747.GD8931@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 05:27:47AM -0700, William Lee Irwin III wrote:
> (1) merge the asm-i386/pci.h fixes
> (2) fix up the bootmem stuff so current works
> (3) fix up the memmap_init() stuff so current works
> (4) PAGE_SIZE -align pkmap and kmap portions of fixmapspace to remove
> 	core dependencies on FIX_KMAP_END for aligning addresses.


(1) PAGE_SIZE-align kmap() and kmap_atomic() slots, albeit at the cost
	of ca. PAGE_SIZE virtualspace
(2) fix up pci_dac_dma_to_page()
(3) remove mm/memory.c's dependency on FIX_KMAP_END
(4) fix mm/page_alloc.c mismerge
(5) do nothing for bootmem, it was actually innocent wrt. the merging bug

diff -prauN pgcl-2.5.68-1/include/asm-i386/fixmap.h pgcl-2.5.68-1D/include/asm-i386/fixmap.h
--- pgcl-2.5.68-1/include/asm-i386/fixmap.h	2003-04-21 02:12:17.000000000 -0700
+++ pgcl-2.5.68-1D/include/asm-i386/fixmap.h	2003-04-27 14:13:23.000000000 -0700
@@ -53,7 +53,17 @@
 #define LAST_PKMAP_MASK	(LAST_PKMAP-1)
 
 enum fixed_addresses {
-	FIX_HOLE,
+	/*
+	 * leave a hole of exactly PAGE_SIZE at the top for CONFIG_HIGHMEM
+	 * this makes things easier on core code; the math works out funny
+	 */
+	FIX_HOLE = PAGE_MMUCOUNT > 1 ? PAGE_MMUCOUNT - 1 : 0,
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_END = FIX_KMAP_BEGIN+((KM_TYPE_NR*NR_CPUS+1)*PAGE_MMUCOUNT)-1,
+	FIX_PKMAP_BEGIN,
+	FIX_PKMAP_END = FIX_PKMAP_BEGIN + (LAST_PKMAP+1)*PAGE_MMUCOUNT - 1,
+#endif
 	FIX_VSYSCALL,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
@@ -74,12 +84,6 @@ enum fixed_addresses {
 #ifdef CONFIG_X86_SUMMIT
 	FIX_CYCLONE_TIMER, /*cyclone timer register*/
 #endif 
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+((KM_TYPE_NR*NR_CPUS+1)*PAGE_MMUCOUNT)-1,
-	FIX_PKMAP_BEGIN,
-	FIX_PKMAP_END = FIX_PKMAP_BEGIN + (LAST_PKMAP+1)*PAGE_MMUCOUNT - 1,
-#endif
 #ifdef CONFIG_ACPI_BOOT
 	FIX_ACPI_BEGIN,
 	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
diff -prauN pgcl-2.5.68-1/include/asm-i386/pci.h pgcl-2.5.68-1D/include/asm-i386/pci.h
--- pgcl-2.5.68-1/include/asm-i386/pci.h	2003-04-19 19:49:19.000000000 -0700
+++ pgcl-2.5.68-1D/include/asm-i386/pci.h	2003-04-27 14:16:31.000000000 -0700
@@ -67,13 +67,13 @@ pci_dac_page_to_dma(struct pci_dev *pdev
 static __inline__ struct page *
 pci_dac_dma_to_page(struct pci_dev *pdev, dma64_addr_t dma_addr)
 {
-	return pfn_to_page(dma_addr >> PAGE_SHIFT);
+	return pfn_to_page(dma_addr >> MMUPAGE_SHIFT);
 }
 
 static __inline__ unsigned long
 pci_dac_dma_to_offset(struct pci_dev *pdev, dma64_addr_t dma_addr)
 {
-	return (dma_addr & ~PAGE_MASK);
+	return dma_addr & ~PAGE_MASK;
 }
 
 static __inline__ void
diff -prauN pgcl-2.5.68-1/mm/memory.c pgcl-2.5.68-1D/mm/memory.c
--- pgcl-2.5.68-1/mm/memory.c	2003-04-21 02:12:17.000000000 -0700
+++ pgcl-2.5.68-1D/mm/memory.c	2003-04-27 13:21:29.000000000 -0700
@@ -1473,19 +1473,9 @@ do_anonymous_page(struct mm_struct *mm, 
 				pr_debug("pte vaddr = 0x%lx\n", vaddr);
 
 				/*
-				 * this will not port to non-x86
-				 * it computes the offset from the possibly
-				 * non-PAGE_SIZE-aligned kmap_atomic() aperture
-				 * KMAP_END is the highest kmap_atomic() fixmap,
-				 * but __fix_to_virt(KMAP_END) is the lowest vaddr
-				 * A more portable solution needs to be found,
-				 * and it appears that aligning PTE kmap slots
-				 * would suffice.
+				 * this computes the offset from the
+				 * PAGE_SIZE-aligned kmap_atomic() aperture
 				 */
-#ifdef CONFIG_HIGHPTE
-				if (vaddr >= __fix_to_virt(FIX_KMAP_END))
-					vaddr -= __fix_to_virt(FIX_KMAP_END);
-#endif
 				vaddr &= PAGE_MASK;
 
 				pr_debug("vaddr offset = 0x%lx\n", vaddr);
diff -prauN pgcl-2.5.68-1/mm/page_alloc.c pgcl-2.5.68-1D/mm/page_alloc.c
--- pgcl-2.5.68-1/mm/page_alloc.c	2003-04-21 02:12:17.000000000 -0700
+++ pgcl-2.5.68-1D/mm/page_alloc.c	2003-04-27 11:55:59.000000000 -0700
@@ -1283,7 +1283,7 @@ static void __init free_area_init_core(s
 
 		memmap_init(lmem_map, size, nid, j, zone_start_pfn);
 
-		zone_start_pfn += size;
+		zone_start_pfn += PAGE_MMUCOUNT*size;
 		lmem_map += size;
 
 		for (i = 0; ; i++) {
