Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbTCTXKA>; Thu, 20 Mar 2003 18:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263274AbTCTXJR>; Thu, 20 Mar 2003 18:09:17 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:57522 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S263244AbTCTXE1>; Thu, 20 Mar 2003 18:04:27 -0500
Date: Thu, 20 Mar 2003 23:17:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [PATCH] anobjrmap 6/6 arches
In-Reply-To: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303202316470.2743-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anonjrmap 6/6 updates to arches other than i386

Some arches refer to page->mapping for their cache flushing,
generally use page_mapping instead: it appears that they're
coping with shared pagecache issues, rather than anon swap.

Change put_dirty_page(current,,) to put_stack_page(mpnt,,).
No special page table initialization needed for rmap.
Delete pte_addr_t from asm/pgtable.h.  Delete asm/rmap.h.

There's some peculiar __users code in asm-s390*/pgtable.h,
looks bogus to me (those counts are included in page_count),
I've just deleted but should confirm with Martin.  And a
fix in asm-sh/pgalloc.h: use list_empty on i_mmap_shared.

No i386 files in this patch: but note that with pte_addr_t
gone, its PAE struct page is the same size as without PAE.

 arch/arm/mm/fault-armv.c          |    4 ++--
 arch/arm/mm/mm-armv.c             |    3 +--
 arch/ia64/ia32/binfmt_elf32.c     |    3 +--
 arch/ia64/mm/init.c               |    2 +-
 arch/parisc/kernel/cache.c        |    4 ++--
 arch/ppc/mm/init.c                |   12 ------------
 arch/s390x/kernel/exec32.c        |    4 +---
 arch/sparc64/kernel/smp.c         |    8 ++++----
 arch/sparc64/mm/init.c            |   12 ++++++------
 arch/sparc64/mm/ultra.S           |    2 +-
 arch/x86_64/ia32/ia32_binfmt.c    |    5 +----
 include/asm-alpha/pgtable.h       |    2 --
 include/asm-alpha/rmap.h          |    7 -------
 include/asm-arm/pgtable.h         |    2 --
 include/asm-arm/proc-armv/cache.h |    4 ++--
 include/asm-arm/rmap.h            |    6 ------
 include/asm-cris/pgtable.h        |    2 --
 include/asm-cris/rmap.h           |    7 -------
 include/asm-ia64/pgtable.h        |    2 --
 include/asm-ia64/rmap.h           |    7 -------
 include/asm-m68k/pgtable.h        |    2 --
 include/asm-m68k/rmap.h           |    7 -------
 include/asm-m68knommu/pgtable.h   |    2 --
 include/asm-m68knommu/rmap.h      |    2 --
 include/asm-mips/pgtable.h        |    2 --
 include/asm-mips/rmap.h           |    7 -------
 include/asm-mips64/pgtable.h      |    2 --
 include/asm-mips64/rmap.h         |    7 -------
 include/asm-parisc/cacheflush.h   |    2 +-
 include/asm-parisc/pgtable.h      |    2 --
 include/asm-parisc/rmap.h         |    7 -------
 include/asm-ppc/pgtable.h         |    2 --
 include/asm-ppc/rmap.h            |    9 ---------
 include/asm-ppc64/pgtable.h       |    2 --
 include/asm-ppc64/rmap.h          |    9 ---------
 include/asm-s390/pgtable.h        |    8 ++------
 include/asm-s390/rmap.h           |    7 -------
 include/asm-s390x/pgtable.h       |    8 ++------
 include/asm-s390x/rmap.h          |    7 -------
 include/asm-sh/pgalloc.h          |    2 +-
 include/asm-sh/pgtable.h          |    2 --
 include/asm-sh/rmap.h             |    7 -------
 include/asm-sparc/pgtable.h       |    2 --
 include/asm-sparc/rmap.h          |    7 -------
 include/asm-sparc64/pgtable.h     |    2 --
 include/asm-sparc64/rmap.h        |    7 -------
 include/asm-um/pgtable.h          |   12 ------------
 include/asm-um/rmap.h             |    6 ------
 include/asm-v850/pgtable.h        |    2 --
 include/asm-v850/rmap.h           |    1 -
 include/asm-x86_64/pgtable.h      |    2 --
 include/asm-x86_64/rmap.h         |    7 -------
 52 files changed, 28 insertions(+), 223 deletions(-)

--- anobjrmap5/arch/arm/mm/fault-armv.c	Mon Nov 18 06:02:39 2002
+++ anobjrmap6/arch/arm/mm/fault-armv.c	Thu Mar 20 17:10:45 2003
@@ -188,7 +188,7 @@
 
 	cpu_cache_clean_invalidate_range(kaddr, kaddr + PAGE_SIZE, 0);
 
-	if (!page->mapping)
+	if (!page_mapping(page))
 		return;
 
 	/*
@@ -289,7 +289,7 @@
 	if (!pfn_valid(pfn))
 		return;
 	page = pfn_to_page(pfn);
-	if (page->mapping) {
+	if (page_mapping(page)) {
 		int dirty = test_and_clear_bit(PG_dcache_dirty, &page->flags);
 		unsigned long kaddr = (unsigned long)page_address(page);
 
--- anobjrmap5/arch/arm/mm/mm-armv.c	Mon Nov 18 06:02:39 2002
+++ anobjrmap6/arch/arm/mm/mm-armv.c	Thu Mar 20 17:10:45 2003
@@ -17,7 +17,6 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/page.h>
-#include <asm/rmap.h>
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/tlbflush.h>
@@ -151,7 +150,7 @@
 
 	pte = pmd_page(*pmd);
 	pmd_clear(pmd);
-	pgtable_remove_rmap(pte);
+	dec_page_state(nr_page_table_pages);
 	pte_free(pte);
 	pmd_free(pmd);
 free:
--- anobjrmap5/arch/ia64/ia32/binfmt_elf32.c	Mon Feb 10 20:12:34 2003
+++ anobjrmap6/arch/ia64/ia32/binfmt_elf32.c	Thu Mar 20 17:10:45 2003
@@ -40,7 +40,6 @@
 #define CLOCKS_PER_SEC	IA32_CLOCKS_PER_SEC
 
 extern void ia64_elf32_init (struct pt_regs *regs);
-extern void put_dirty_page (struct task_struct * tsk, struct page *page, unsigned long address);
 
 static void elf32_set_personality (void);
 
@@ -200,7 +199,7 @@
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current, page, stack_base);
+			put_stack_page(mpnt, page, stack_base);
 		}
 		stack_base += PAGE_SIZE;
 	}
--- anobjrmap5/arch/ia64/mm/init.c	Mon Feb 10 20:12:35 2003
+++ anobjrmap6/arch/ia64/mm/init.c	Thu Mar 20 17:10:45 2003
@@ -223,7 +223,7 @@
 }
 
 /*
- * This is like put_dirty_page() but installs a clean page with PAGE_GATE protection
+ * This is like put_stack_page() but installs a clean page with PAGE_GATE protection
  * (execute-only, typically).
  */
 struct page *
--- anobjrmap5/arch/parisc/kernel/cache.c	Wed Mar 19 11:05:09 2003
+++ anobjrmap6/arch/parisc/kernel/cache.c	Thu Mar 20 17:10:45 2003
@@ -64,7 +64,7 @@
 {
 	struct page *page = pte_page(pte);
 
-	if (VALID_PAGE(page) && page->mapping &&
+	if (VALID_PAGE(page) && page_mapping(page) &&
 	    test_bit(PG_dcache_dirty, &page->flags)) {
 
 		flush_kernel_dcache_page(page_address(page));
@@ -230,7 +230,7 @@
 
 	flush_kernel_dcache_page(page_address(page));
 
-	if (!page->mapping)
+	if (!page_mapping(page))
 		return;
 
 	list_for_each(l, &page->mapping->i_mmap_shared) {
--- anobjrmap5/arch/ppc/mm/init.c	Tue Mar 18 07:38:32 2003
+++ anobjrmap6/arch/ppc/mm/init.c	Thu Mar 20 17:10:45 2003
@@ -472,18 +472,6 @@
 		printk(KERN_INFO "AGP special page: 0x%08lx\n", agp_special_page);
 #endif /* defined(CONFIG_ALL_PPC) */
 
-	/* Make sure all our pagetable pages have page->mapping
-	   and page->index set correctly. */
-	for (addr = KERNELBASE; addr != 0; addr += PGDIR_SIZE) {
-		struct page *pg;
-		pmd_t *pmd = pmd_offset(pgd_offset_k(addr), addr);
-		if (pmd_present(*pmd)) {
-			pg = pmd_page(*pmd);
-			pg->mapping = (void *) &init_mm;
-			pg->index = addr;
-		}
-	}
-
 	mem_init_done = 1;
 }
 
--- anobjrmap5/arch/s390x/kernel/exec32.c	Wed Mar  5 07:26:17 2003
+++ anobjrmap6/arch/s390x/kernel/exec32.c	Thu Mar 20 17:10:45 2003
@@ -33,8 +33,6 @@
 #endif
 
 
-extern void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address);
-
 #undef STACK_TOP
 #define STACK_TOP TASK31_SIZE
 
@@ -82,7 +80,7 @@
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current,page,stack_base);
+			put_stack_page(mpnt,page,stack_base);
 		}
 		stack_base += PAGE_SIZE;
 	}
--- anobjrmap5/arch/sparc64/kernel/smp.c	Tue Mar 18 07:38:33 2003
+++ anobjrmap6/arch/sparc64/kernel/smp.c	Thu Mar 20 17:10:45 2003
@@ -750,9 +750,9 @@
 #if (L1DCACHE_SIZE > PAGE_SIZE)
 	__flush_dcache_page(page->virtual,
 			    ((tlb_type == spitfire) &&
-			     page->mapping != NULL));
+			     page_mapping(page) != NULL));
 #else
-	if (page->mapping != NULL &&
+	if (page_mapping(page) != NULL &&
 	    tlb_type == spitfire)
 		__flush_icache_page(__pa(page->virtual));
 #endif
@@ -773,7 +773,7 @@
 		if (tlb_type == spitfire) {
 			data0 =
 				((u64)&xcall_flush_dcache_page_spitfire);
-			if (page->mapping != NULL)
+			if (page_mapping(page) != NULL)
 				data0 |= ((u64)1 << 32);
 			spitfire_xcall_deliver(data0,
 					       __pa(page->virtual),
@@ -804,7 +804,7 @@
 		goto flush_self;
 	if (tlb_type == spitfire) {
 		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
-		if (page->mapping != NULL)
+		if (page_mapping(page) != NULL)
 			data0 |= ((u64)1 << 32);
 		spitfire_xcall_deliver(data0,
 				       __pa(page->virtual),
--- anobjrmap5/arch/sparc64/mm/init.c	Mon Jan 13 19:31:43 2003
+++ anobjrmap6/arch/sparc64/mm/init.c	Thu Mar 20 17:10:45 2003
@@ -129,9 +129,9 @@
 #if (L1DCACHE_SIZE > PAGE_SIZE)
 	__flush_dcache_page(page->virtual,
 			    ((tlb_type == spitfire) &&
-			     page->mapping != NULL));
+			     page_mapping(page) != NULL));
 #else
-	if (page->mapping != NULL &&
+	if (page_mapping(page) != NULL &&
 	    tlb_type == spitfire)
 		__flush_icache_page(__pa(page->virtual));
 #endif
@@ -193,7 +193,7 @@
 
 	pfn = pte_pfn(pte);
 	if (pfn_valid(pfn) &&
-	    (page = pfn_to_page(pfn), page->mapping) &&
+	    (page = pfn_to_page(pfn), page_mapping(page)) &&
 	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
 		int cpu = ((pg_flags >> 24) & (NR_CPUS - 1UL));
 
@@ -217,7 +217,7 @@
 	int dirty = test_bit(PG_dcache_dirty, &page->flags);
 	int dirty_cpu = dcache_dirty_cpu(page);
 
-	if (page->mapping &&
+	if (page_mapping(page) &&
 	    list_empty(&page->mapping->i_mmap) &&
 	    list_empty(&page->mapping->i_mmap_shared)) {
 		if (dirty) {
@@ -227,7 +227,7 @@
 		}
 		set_dcache_dirty(page);
 	} else {
-		/* We could delay the flush for the !page->mapping
+		/* We could delay the flush for the !page_mapping
 		 * case too.  But that case is for exec env/arg
 		 * pages and those are %99 certainly going to get
 		 * faulted into the tlb (and thus flushed) anyways.
@@ -269,7 +269,7 @@
 			if (!pfn_valid(pfn))
 				continue;
 			page = pfn_to_page(pfn);
-			if (PageReserved(page) || !page->mapping)
+			if (PageReserved(page) || !page_mapping(page))
 				continue;
 			pgaddr = (unsigned long) page_address(page);
 			uaddr = address + offset;
--- anobjrmap5/arch/sparc64/mm/ultra.S	Mon Feb 24 20:03:29 2003
+++ anobjrmap6/arch/sparc64/mm/ultra.S	Thu Mar 20 17:10:45 2003
@@ -615,7 +615,7 @@
 	.globl		xcall_flush_dcache_page_spitfire
 xcall_flush_dcache_page_spitfire: /* %g1 == physical page address
 				     %g7 == kernel page virtual address
-				     %g5 == (page->mapping != NULL)  */
+				     %g5 == (page_mapping != NULL)  */
 #if (L1DCACHE_SIZE > PAGE_SIZE)
 	srlx		%g1, (13 - 2), %g1	! Form tag comparitor
 	sethi		%hi(L1DCACHE_SIZE), %g3	! D$ size == 16K
--- anobjrmap5/arch/x86_64/ia32/ia32_binfmt.c	Wed Mar 19 11:05:09 2003
+++ anobjrmap6/arch/x86_64/ia32/ia32_binfmt.c	Thu Mar 20 17:10:45 2003
@@ -272,9 +272,6 @@
 	set_thread_flag(TIF_IA32); 
 }
 
-extern void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address);
- 
-
 int setup_arg_pages(struct linux_binprm *bprm)
 {
 	unsigned long stack_base;
@@ -319,7 +316,7 @@
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current,page,stack_base);
+			put_stack_page(mpnt,page,stack_base);
 		}
 		stack_base += PAGE_SIZE;
 	}
--- anobjrmap5/include/asm-alpha/pgtable.h	Tue Mar 18 07:38:41 2003
+++ anobjrmap6/include/asm-alpha/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -343,6 +343,4 @@
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
 
-typedef pte_t *pte_addr_t;
-
 #endif /* _ALPHA_PGTABLE_H */
--- anobjrmap5/include/asm-alpha/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-alpha/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _ALPHA_RMAP_H
-#define _ALPHA_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-arm/pgtable.h	Tue Mar 18 07:38:42 2003
+++ anobjrmap6/include/asm-arm/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -162,8 +162,6 @@
 #define io_remap_page_range(vma,from,phys,size,prot) \
 		remap_page_range(vma,from,phys,size,prot)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASMARM_PGTABLE_H */
--- anobjrmap5/include/asm-arm/proc-armv/cache.h	Mon Nov 18 06:02:49 2002
+++ anobjrmap6/include/asm-arm/proc-armv/cache.h	Thu Mar 20 17:10:45 2003
@@ -81,7 +81,7 @@
  * flush_dcache_page is used when the kernel has written to the page
  * cache page at virtual address page->virtual.
  *
- * If this page isn't mapped (ie, page->mapping = NULL), or it has
+ * If this page isn't mapped (ie, page_mapping == NULL), or it has
  * userspace mappings (page->mapping->i_mmap or page->mapping->i_mmap_shared)
  * then we _must_ always clean + invalidate the dcache entries associated
  * with the kernel mapping.
@@ -97,7 +97,7 @@
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page->mapping && !mapping_mapped(page->mapping))
+	if (page_mapping(page) && !mapping_mapped(page->mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else
 		__flush_dcache_page(page);
--- anobjrmap5/include/asm-arm/rmap.h	Thu Aug  1 23:58:27 2002
+++ anobjrmap6/include/asm-arm/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,6 +0,0 @@
-#ifndef _ARM_RMAP_H
-#define _ARM_RMAP_H
-
-#include <asm-generic/rmap.h>
-
-#endif /* _ARM_RMAP_H */
--- anobjrmap5/include/asm-cris/pgtable.h	Mon Sep 16 05:51:50 2002
+++ anobjrmap6/include/asm-cris/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -515,6 +515,4 @@
  */
 #define pgtable_cache_init()   do { } while (0)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* _CRIS_PGTABLE_H */
--- anobjrmap5/include/asm-cris/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-cris/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _CRIS_RMAP_H
-#define _CRIS_RMAP_H
-
-/* nothing to see, move along :) */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-ia64/pgtable.h	Tue Mar 18 07:38:42 2003
+++ anobjrmap6/include/asm-ia64/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -420,8 +420,6 @@
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
 #define HAVE_ARCH_UNMAPPED_AREA
 
-typedef pte_t *pte_addr_t;
-
 # endif /* !__ASSEMBLY__ */
 
 /*
--- anobjrmap5/include/asm-ia64/rmap.h	Wed Aug 28 06:38:20 2002
+++ anobjrmap6/include/asm-ia64/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _ASM_IA64_RMAP_H
-#define _ASM_IA64_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif /* _ASM_IA64_RMAP_H */
--- anobjrmap5/include/asm-m68k/pgtable.h	Mon Sep 16 05:51:50 2002
+++ anobjrmap6/include/asm-m68k/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -172,8 +172,6 @@
 #ifndef __ASSEMBLY__
 #include <asm-generic/pgtable.h>
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 /*
--- anobjrmap5/include/asm-m68k/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-m68k/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _M68K_RMAP_H
-#define _M68K_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-m68knommu/pgtable.h	Tue Nov  5 00:03:09 2002
+++ anobjrmap6/include/asm-m68knommu/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -11,8 +11,6 @@
 #include <asm/page.h>
 #include <asm/io.h>
 
-typedef pte_t *pte_addr_t;
-
 /*
  * Trivial page table functions.
  */
--- anobjrmap5/include/asm-m68knommu/rmap.h	Tue Nov  5 00:03:09 2002
+++ anobjrmap6/include/asm-m68knommu/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,2 +0,0 @@
-/* Do not need anything here */
-
--- anobjrmap5/include/asm-mips/pgtable.h	Wed Mar  5 07:26:32 2003
+++ anobjrmap6/include/asm-mips/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -771,8 +771,6 @@
 
 #include <asm-generic/pgtable.h>
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 #define io_remap_page_range remap_page_range
--- anobjrmap5/include/asm-mips/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-mips/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _MIPS_RMAP_H
-#define _MIPS_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-mips64/pgtable.h	Wed Mar  5 07:26:32 2003
+++ anobjrmap6/include/asm-mips64/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -811,8 +811,6 @@
 
 #include <asm-generic/pgtable.h>
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 /*
--- anobjrmap5/include/asm-mips64/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-mips64/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _MIPS64_RMAP_H
-#define _MIPS64_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-parisc/cacheflush.h	Wed Mar 19 11:05:12 2003
+++ anobjrmap6/include/asm-parisc/cacheflush.h	Thu Mar 20 17:10:45 2003
@@ -71,7 +71,7 @@
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page->mapping && list_empty(&page->mapping->i_mmap) &&
+	if (page_mapping(page) && list_empty(&page->mapping->i_mmap) &&
 			list_empty(&page->mapping->i_mmap_shared)) {
 		set_bit(PG_dcache_dirty, &page->flags);
 	} else {
--- anobjrmap5/include/asm-parisc/pgtable.h	Tue Mar 18 07:38:43 2003
+++ anobjrmap6/include/asm-parisc/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -434,8 +434,6 @@
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define io_remap_page_range remap_page_range
--- anobjrmap5/include/asm-parisc/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-parisc/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _PARISC_RMAP_H
-#define _PARISC_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-ppc/pgtable.h	Tue Mar 18 07:38:43 2003
+++ anobjrmap6/include/asm-ppc/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -570,8 +570,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 #endif /* _PPC_PGTABLE_H */
 #endif /* __KERNEL__ */
--- anobjrmap5/include/asm-ppc/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-ppc/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,9 +0,0 @@
-#ifndef _PPC_RMAP_H
-#define _PPC_RMAP_H
-
-/* PPC calls pte_alloc() before mem_map[] is setup ... */
-#define BROKEN_PPC_PTE_ALLOC_ONE
-
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-ppc64/pgtable.h	Wed Mar 19 11:05:12 2003
+++ anobjrmap6/include/asm-ppc64/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -375,7 +375,5 @@
 extern void hpte_init_pSeries(void);
 extern void hpte_init_iSeries(void);
 
-typedef pte_t *pte_addr_t;
-
 #endif /* __ASSEMBLY__ */
 #endif /* _PPC64_PGTABLE_H */
--- anobjrmap5/include/asm-ppc64/rmap.h	Thu Jul 25 13:04:58 2002
+++ anobjrmap6/include/asm-ppc64/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,9 +0,0 @@
-#ifndef _PPC64_RMAP_H
-#define _PPC64_RMAP_H
-
-/* PPC64 calls pte_alloc() before mem_map[] is setup ... */
-#define BROKEN_PPC_PTE_ALLOC_ONE
-
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-s390/pgtable.h	Tue Mar 18 07:38:43 2003
+++ anobjrmap6/include/asm-s390/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -422,8 +422,7 @@
 	pte_t __pte = mk_pte_phys(__physpage, __pgprot);                  \
 	                                                                  \
 	if (!(pgprot_val(__pgprot) & _PAGE_ISCLEAN)) {			  \
-		int __users = !!PagePrivate(__page) + !!__page->mapping;  \
-		if (__users + page_count(__page) == 1)                    \
+		if (page_count(__page) == 1)                              \
 			pte_val(__pte) |= _PAGE_MKCLEAN;                  \
 	}								  \
 	__pte;                                                            \
@@ -437,8 +436,7 @@
 	pte_t __pte = mk_pte_phys(__physpage, __pgprot);                  \
 	                                                                  \
 	if (!(pgprot_val(__pgprot) & _PAGE_ISCLEAN)) {			  \
-		int __users = !!PagePrivate(__page) + !!__page->mapping;  \
-		if (__users + page_count(__page) == 1)                    \
+		if (page_count(__page) == 1)                              \
 			pte_val(__pte) |= _PAGE_MKCLEAN;                  \
 	}								  \
 	__pte;                                                            \
@@ -507,8 +505,6 @@
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)   (1)
--- anobjrmap5/include/asm-s390/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-s390/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _S390_RMAP_H
-#define _S390_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-s390x/pgtable.h	Tue Mar 18 07:38:43 2003
+++ anobjrmap6/include/asm-s390x/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -441,8 +441,7 @@
 	pte_t __pte = mk_pte_phys(__physpage, __pgprot);                  \
  	                                                                  \
 	if (!(pgprot_val(__pgprot) & _PAGE_ISCLEAN)) {			  \
-		int __users = !!PagePrivate(__page) + !!__page->mapping;  \
-		if (__users + page_count(__page) == 1)                    \
+		if (page_count(__page) == 1)                              \
 			pte_val(__pte) |= _PAGE_MKCLEAN;                  \
 	}								  \
 	__pte;                                                            \
@@ -456,8 +455,7 @@
 	pte_t __pte = mk_pte_phys(__physpage, __pgprot);                  \
 	                                                                  \
 	if (!(pgprot_val(__pgprot) & _PAGE_ISCLEAN)) {			  \
-		int __users = !!PagePrivate(__page) + !!__page->mapping;  \
-		if (__users + page_count(__page) == 1)                    \
+		if (page_count(__page) == 1)                              \
 			pte_val(__pte) |= _PAGE_MKCLEAN;                  \
 	}								  \
 	__pte;                                                            \
@@ -533,8 +531,6 @@
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)   (1)
--- anobjrmap5/include/asm-s390x/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-s390x/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _S390X_RMAP_H
-#define _S390X_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-sh/pgalloc.h	Wed May  8 20:42:40 2002
+++ anobjrmap6/include/asm-sh/pgalloc.h	Thu Mar 20 17:10:45 2003
@@ -109,7 +109,7 @@
 		unsigned long pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(page);
-			if (!page->mapping || !page->mapping->i_mmap_shared)
+			if (!page_mapping(page) || list_empty(&page->mapping->i_mmap_shared))
 				__clear_bit(PG_mapped, &page->flags);
 		}
 	}
--- anobjrmap5/include/asm-sh/pgtable.h	Tue Mar 18 07:38:43 2003
+++ anobjrmap6/include/asm-sh/pgtable.h	Thu Mar 20 17:10:45 2003
@@ -307,8 +307,6 @@
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)	(1)
--- anobjrmap5/include/asm-sh/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-sh/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _SH_RMAP_H
-#define _SH_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-sparc/pgtable.h	Mon Sep 16 05:51:51 2002
+++ anobjrmap6/include/asm-sparc/pgtable.h	Thu Mar 20 17:10:46 2003
@@ -442,8 +442,6 @@
 
 #include <asm-generic/pgtable.h>
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !(__ASSEMBLY__) */
 
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
--- anobjrmap5/include/asm-sparc/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-sparc/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _SPARC_RMAP_H
-#define _SPARC_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-sparc64/pgtable.h	Tue Mar 18 07:38:44 2003
+++ anobjrmap6/include/asm-sparc64/pgtable.h	Thu Mar 20 17:10:46 2003
@@ -369,8 +369,6 @@
 
 extern void check_pgt_cache(void);
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC64_PGTABLE_H) */
--- anobjrmap5/include/asm-sparc64/rmap.h	Sat Jul 20 20:56:06 2002
+++ anobjrmap6/include/asm-sparc64/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _SPARC64_RMAP_H
-#define _SPARC64_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- anobjrmap5/include/asm-um/pgtable.h	Tue Mar 18 07:38:44 2003
+++ anobjrmap6/include/asm-um/pgtable.h	Thu Mar 20 17:10:46 2003
@@ -385,18 +385,6 @@
 #define pte_unmap(pte) kunmap_atomic((pte), KM_PTE0)
 #define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
 
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM4G)
-typedef u32 pte_addr_t;
-#endif
-
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM64G)
-typedef u64 pte_addr_t;
-#endif
-
-#if !defined(CONFIG_HIGHPTE)
-typedef pte_t *pte_addr_t;
-#endif
-
 #define update_mmu_cache(vma,address,pte) do ; while (0)
 
 /* Encode and de-code a swap entry */
--- anobjrmap5/include/asm-um/rmap.h	Mon Sep 16 05:51:51 2002
+++ anobjrmap6/include/asm-um/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,6 +0,0 @@
-#ifndef __UM_RMAP_H
-#define __UM_RMAP_H
-
-#include "asm/arch/rmap.h"
-
-#endif
--- anobjrmap5/include/asm-v850/pgtable.h	Tue Nov  5 00:03:09 2002
+++ anobjrmap6/include/asm-v850/pgtable.h	Thu Mar 20 17:10:46 2003
@@ -5,8 +5,6 @@
 #include <asm/page.h>
 
 
-typedef pte_t *pte_addr_t;
-
 #define pgd_present(pgd)	(1) /* pages are always present on NO_MM */
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
--- anobjrmap5/include/asm-v850/rmap.h	Tue Nov  5 00:03:09 2002
+++ anobjrmap6/include/asm-v850/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1 +0,0 @@
-/* Do not need anything here */
--- anobjrmap5/include/asm-x86_64/pgtable.h	Wed Mar 19 11:05:15 2003
+++ anobjrmap6/include/asm-x86_64/pgtable.h	Thu Mar 20 17:10:46 2003
@@ -380,8 +380,6 @@
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #ifndef CONFIG_DISCONTIGMEM
--- anobjrmap5/include/asm-x86_64/rmap.h	Wed Oct 16 06:31:03 2002
+++ anobjrmap6/include/asm-x86_64/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#ifndef _X8664_RMAP_H
-#define _X8664_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif

