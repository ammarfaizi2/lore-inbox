Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbUJZCEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbUJZCEC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUJZCD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:03:26 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16784 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261911AbUJZBcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:32:25 -0400
Date: Mon, 25 Oct 2004 18:31:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V2 [8/8]: sh arch specific modifications
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410251831170.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Extend flush_dcache page to flush compound pages.
	* Attempt to find a solution for sh3 and sh4's
	  huge_update_mmu_cache which is likely very wrong.
	* Not built and not tested. This is the archicture
	  I know the least about.

Index: linux-2.6.9/include/asm-sh/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-sh/pgtable.h	2004-10-21 12:01:24.000000000 -0700
+++ linux-2.6.9/include/asm-sh/pgtable.h	2004-10-25 15:05:33.000000000 -0700
@@ -249,6 +249,8 @@
 struct vm_area_struct;
 extern void update_mmu_cache(struct vm_area_struct * vma,
 			     unsigned long address, pte_t pte);
+extern void huge_update_mmu_cache(struct vm_area_struct * vma,
+			     unsigned long address, pte_t pte);

 /* Encode and de-code a swap entry */
 /*
Index: linux-2.6.9/arch/sh/mm/cache-sh4.c
===================================================================
--- linux-2.6.9.orig/arch/sh/mm/cache-sh4.c	2004-10-21 12:01:21.000000000 -0700
+++ linux-2.6.9/arch/sh/mm/cache-sh4.c	2004-10-25 15:18:53.000000000 -0700
@@ -206,13 +206,25 @@
 void flush_dcache_page(struct page *page)
 {
 	if (test_bit(PG_mapped, &page->flags)) {
-		unsigned long phys = PHYSADDR(page_address(page));
+		unsigned long phys;
+		int nr = 1;

-		/* Loop all the D-cache */
-		flush_cache_4096(CACHE_OC_ADDRESS_ARRAY,          phys);
-		flush_cache_4096(CACHE_OC_ADDRESS_ARRAY | 0x1000, phys);
-		flush_cache_4096(CACHE_OC_ADDRESS_ARRAY | 0x2000, phys);
-		flush_cache_4096(CACHE_OC_ADDRESS_ARRAY | 0x3000, phys);
+		if (CompoundPage(page)) {
+			page = page->private;
+			nr = 1 << page[1].index;
+		}
+
+		phys = PHYSADDR(page_address(page));
+
+		while (nr-- > 0) {
+			/* Loop all the D-cache */
+			flush_cache_4096(CACHE_OC_ADDRESS_ARRAY,          phys);
+			flush_cache_4096(CACHE_OC_ADDRESS_ARRAY | 0x1000, phys);
+			flush_cache_4096(CACHE_OC_ADDRESS_ARRAY | 0x2000, phys);
+			flush_cache_4096(CACHE_OC_ADDRESS_ARRAY | 0x3000, phys);
+
+			phys += PAGE_SIZE;
+		}
 	}
 }

Index: linux-2.6.9/arch/sh/mm/tlb-nommu.c
===================================================================
--- linux-2.6.9.orig/arch/sh/mm/tlb-nommu.c	2004-10-18 14:54:27.000000000 -0700
+++ linux-2.6.9/arch/sh/mm/tlb-nommu.c	2004-10-25 15:06:56.000000000 -0700
@@ -55,4 +55,9 @@
 {
 	BUG();
 }
+void huge_update_mmu_cache(struct vm_area_struct * vma,
+		      unsigned long address, pte_t pte)
+{
+	BUG();
+}

Index: linux-2.6.9/arch/sh/mm/cache-sh7705.c
===================================================================
--- linux-2.6.9.orig/arch/sh/mm/cache-sh7705.c	2004-10-21 12:01:21.000000000 -0700
+++ linux-2.6.9/arch/sh/mm/cache-sh7705.c	2004-10-25 15:23:46.000000000 -0700
@@ -135,8 +135,22 @@
  */
 void flush_dcache_page(struct page *page)
 {
-	if (test_bit(PG_mapped, &page->flags))
-		__flush_dcache_page(PHYSADDR(page_address(page)));
+	if (test_bit(PG_mapped, &page->flags)) {
+		if (!CompoundPage(page))
+			__flush_dcache_page(PHYSADDR(page_address(page)));
+		else {
+			int nr;
+			unsigned long phy = PHYSADDR(page_address(page));
+
+			page = page->private;
+			nr = 1 << page[1].index;
+
+			while (nr-- >0) {
+				__flush_dcache_page(phys);
+				phys += PAGE_SIZE;
+			}
+		}
+	}
 }

 void flush_cache_all(void)
Index: linux-2.6.9/arch/sh/mm/tlb-sh3.c
===================================================================
--- linux-2.6.9.orig/arch/sh/mm/tlb-sh3.c	2004-10-21 12:01:21.000000000 -0700
+++ linux-2.6.9/arch/sh/mm/tlb-sh3.c	2004-10-25 15:13:00.000000000 -0700
@@ -67,6 +67,48 @@
 	local_irq_restore(flags);
 }

+void huge_update_mmu_cache(struct vm_area_struct * vma,
+		      unsigned long address, pte_t pte)
+{
+	unsigned long flags;
+	unsigned long pteval;
+	unsigned long vpn;
+
+	/* Ptrace may call this routine. */
+	if (vma && current->active_mm != vma->vm_mm)
+		return;
+
+#if defined(CONFIG_SH7705_CACHE_32KB)
+	struct page *page;
+	page = pte_page(pte);
+	if (VALID_PAGE(page) && !test_bit(PG_mapped, &page->flags)) {
+		unsigned long phys = pte_val(pte) & PTE_PHYS_MASK;
+		__flush_wback_region((void *)P1SEGADDR(phys), HPAGE_SIZE);
+		__set_bit(PG_mapped, &page->flags);
+	}
+#endif
+
+	local_irq_save(flags);
+
+	/* FIXME: What exactly does the code below do? pte mapping ? */
+
+	/* Set PTEH register */
+	vpn = (address & MMU_VPN_MASK) | get_asid();
+	ctrl_outl(vpn, MMU_PTEH);
+
+	pteval = pte_val(pte);
+
+	/* Set PTEL register */
+	pteval &= _PAGE_FLAGS_HARDWARE_MASK; /* drop software flags */
+	/* conveniently, we want all the software flags to be 0 anyway */
+	ctrl_outl(pteval, MMU_PTEL);
+
+	/* Load the TLB */
+	asm volatile("ldtlb": /* no output */ : /* no input */ : "memory");
+	local_irq_restore(flags);
+}
+
+
 void __flush_tlb_page(unsigned long asid, unsigned long page)
 {
 	unsigned long addr, data;
Index: linux-2.6.9/arch/sh/mm/tlb-sh4.c
===================================================================
--- linux-2.6.9.orig/arch/sh/mm/tlb-sh4.c	2004-10-18 14:54:38.000000000 -0700
+++ linux-2.6.9/arch/sh/mm/tlb-sh4.c	2004-10-25 15:14:46.000000000 -0700
@@ -28,6 +28,56 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>

+void huge_update_mmu_cache(struct vm_area_struct * vma,
+		      unsigned long address, pte_t pte)
+{
+	unsigned long flags;
+	unsigned long pteval;
+	unsigned long vpn;
+	struct page *page;
+	unsigned long pfn;
+	unsigned long ptea;
+
+	/* Ptrace may call this routine. */
+	if (vma && current->active_mm != vma->vm_mm)
+		return;
+
+	pfn = pte_pfn(pte);
+	if (pfn_valid(pfn)) {
+		page = pfn_to_page(pfn);
+		if (!test_bit(PG_mapped, &page->flags)) {
+			unsigned long phys = pte_val(pte) & PTE_PHYS_MASK;
+			__flush_wback_region((void *)P1SEGADDR(phys), HPAGE_SIZE);
+			__set_bit(PG_mapped, &page->flags);
+		}
+	}
+
+	/* FIXME: code below likely needs to be fixed up for huge pages */
+	local_irq_save(flags);
+
+	/* Set PTEH register */
+	vpn = (address & MMU_VPN_MASK) | get_asid();
+	ctrl_outl(vpn, MMU_PTEH);
+
+	pteval = pte_val(pte);
+	/* Set PTEA register */
+	/* TODO: make this look less hacky */
+	ptea = ((pteval >> 28) & 0xe) | (pteval & 0x1);
+	ctrl_outl(ptea, MMU_PTEA);
+
+	/* Set PTEL register */
+	pteval &= _PAGE_FLAGS_HARDWARE_MASK; /* drop software flags */
+#ifdef CONFIG_SH_WRITETHROUGH
+	pteval |= _PAGE_WT;
+#endif
+	/* conveniently, we want all the software flags to be 0 anyway */
+	ctrl_outl(pteval, MMU_PTEL);
+
+	/* Load the TLB */
+	asm volatile("ldtlb": /* no output */ : /* no input */ : "memory");
+	local_irq_restore(flags);
+}
+
 void update_mmu_cache(struct vm_area_struct * vma,
 		      unsigned long address, pte_t pte)
 {

