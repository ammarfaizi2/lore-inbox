Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289370AbSAVT1b>; Tue, 22 Jan 2002 14:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289369AbSAVT1L>; Tue, 22 Jan 2002 14:27:11 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:37861 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289368AbSAVT1D>; Tue, 22 Jan 2002 14:27:03 -0500
Date: Tue, 22 Jan 2002 19:29:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: pre4aa1 contig kmaps patch
In-Reply-To: <20020121191539.K8292@athlon.random>
Message-ID: <Pine.LNX.4.21.0201221813430.1130-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

You've understandably gone ahead with pre4aa1, not waited for my
contiguous pkmap_page_table patch.  I've now finished testing it,
and append below, since I prefer it to what you have in pre4aa1.

Two calls to fixrange_init, the second needing contiguous page
table address space, yet sharing the page table chosen by the 
first call (FIXADDR_START is not aligned), would that really
work in general?  And your fixrange_init even more complicated
than it was before!

It didn't boot in my 1GB user virtual, 2GB physical memory,
PAE testing (yes, PAE with <= 4GB physical memory is not optimal,
but should work for testing).  I was confused when I tried that,
I was thinking I had 1GB physical, and was trying to demonstrate
that pagetable_init then left pgd[2] empty_zero, corrupted by
vmalloc.  But it must have been something else, I didn't
investigate and returned to testing my own patch.

 arch/i386/config.in        |    5 +
 arch/i386/mm/init.c        |  119 +++++++++++----------------------------------
 include/asm-i386/highmem.h |    5 -
 include/asm-i386/pgtable.h |    2 
 4 files changed, 36 insertions, 95 deletions

config.in: you're not offering user address space size configuration
when CONFIG_HIGHMEM64G, perhaps because you know of the boot failure
I got, but it's useful then too: I've added choice (without 3.5GB).

init.c: well, I resisted many of the changes I made earlier,
but had to simplify pagetable_init for the pgd[2] empty_zero issue,
it then made sense to simplify its #ifdefs and remove fixrange_init.

highmem.h: just removed the comment about "single pte table".
pgtable.h: parentheses around ptep in pte_kunmap(ptep) macro

Hugh

diff -urN 1804aa1/arch/i386/config.in 1804AA1/arch/i386/config.in
--- 1804aa1/arch/i386/config.in	Tue Jan 22 12:08:35 2002
+++ 1804AA1/arch/i386/config.in	Tue Jan 22 13:56:58 2002
@@ -168,7 +168,10 @@
 fi
 if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
    define_bool CONFIG_X86_PAE y
-   define_bool CONFIG_1GB y
+   choice 'User address space size' \
+	"3GB		CONFIG_1GB \
+	 2GB		CONFIG_2GB \
+	 1GB		CONFIG_3GB" 3GB
 else
    choice 'User address space size' \
 	"3GB		CONFIG_1GB \
diff -urN 1804aa1/arch/i386/mm/init.c 1804AA1/arch/i386/mm/init.c
--- 1804aa1/arch/i386/mm/init.c	Tue Jan 22 12:08:36 2002
+++ 1804AA1/arch/i386/mm/init.c	Tue Jan 22 14:28:42 2002
@@ -167,65 +167,6 @@
 	set_pte_phys(address, phys, flags);
 }
 
-static void __init fixrange_init (unsigned long start, unsigned long end, pgd_t *pgd_base, int contigous_pte)
-{
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte;
-	int i, j;
-	unsigned long vaddr;
-	int nr_pte;
-	void * pte_array;
-
-	vaddr = start;
-	i = __pgd_offset(vaddr);
-	j = __pmd_offset(vaddr);
-	pgd = pgd_base + i;
-
-	if (contigous_pte) {
-		if (start >= end)
-			BUG();
-		nr_pte = (end - start + PMD_SIZE - 1) >> PMD_SHIFT;
-		if (j + nr_pte > PTRS_PER_PMD)
-			BUG();
-		pte_array = alloc_bootmem_low_pages(PAGE_SIZE * nr_pte);
-	}
-	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
-#if CONFIG_X86_PAE
-		if (pgd_none(*pgd)) {
-			pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-			set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
-			if (pmd != pmd_offset(pgd, 0))
-				printk("PAE BUG #02!\n");
-		}
-		pmd = pmd_offset(pgd, vaddr);
-#else
-		pmd = (pmd_t *)pgd;
-#endif
-		for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
-			if (pmd_none(*pmd)) {
-				if (contigous_pte) {
-					pte = (pte_t *) pte_array;
-					pte_array += PAGE_SIZE;
-					nr_pte--;
-				} else
-					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-				set_pmd(pmd, mk_pmd_phys(__pa(pte), __pgprot(_KERNPG_TABLE)));
-				if (pte != pte_offset_lowmem(pmd, 0))
-					BUG();
-			}
-			vaddr += PMD_SIZE;
-		}
-		j = 0;
-	}
-	if (contigous_pte) {
-		if (nr_pte < 0)
-			BUG();
-		if (nr_pte > 0)
-			free_bootmem((unsigned long) pte_array, nr_pte * PAGE_SIZE);
-	}
-}
-
 static void __init pagetable_init (void)
 {
 	unsigned long vaddr, end;
@@ -242,8 +183,24 @@
 
 	pgd_base = swapper_pg_dir;
 #if CONFIG_X86_PAE
-	for (i = 0; i < PTRS_PER_PGD; i++)
+	/*
+	 * First set all four entries of the pgd.
+	 * Usually only one page is needed here: if PAGE_OFFSET lowered,
+	 * maybe three pages: need not be contiguous, but might as well.
+	 */
+	pmd = (pmd_t *)alloc_bootmem_low_pages(KERNEL_PGD_PTRS*PAGE_SIZE);
+	for (i = 1; i < USER_PGD_PTRS; i++)
 		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
+	for (; i < PTRS_PER_PGD; i++, pmd += PTRS_PER_PMD)
+		set_pgd(pgd_base + i, __pgd(1 + __pa(pmd)));
+	/*
+	 * Add low memory identity-mappings - SMP needs it when
+	 * starting up on an AP from real-mode. In the non-PAE
+	 * case we already have these mappings through head.S.
+	 * All user-space mappings are explicitly cleared after
+	 * SMP startup.
+	 */
+	pgd_base[0] = pgd_base[USER_PGD_PTRS];
 #endif
 	i = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + i;
@@ -252,14 +209,7 @@
 		vaddr = i*PGDIR_SIZE;
 		if (end && (vaddr >= end))
 			break;
-#if CONFIG_X86_PAE
-		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-		set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
-#else
-		pmd = (pmd_t *)pgd;
-#endif
-		if (pmd != pmd_offset(pgd, 0))
-			BUG();
+		pmd = pmd_offset(pgd, 0);
 		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
 			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
 			if (end && (vaddr >= end))
@@ -295,34 +245,27 @@
 	}
 
 	/*
-	 * Fixed mappings, only the page table structure has to be
-	 * created - mappings will be set by set_fixmap():
+	 * Leave vmalloc() to create its own page tables as needed,
+	 * but create the page tables at top of virtual memory, to be
+	 * populated by kmap_high(), kmap_atomic(), and set_fixmap().
+	 * kmap_high() assumes pkmap_page_table contiguous throughout.
 	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, 0, pgd_base, 0);
-
 #if CONFIG_HIGHMEM
-	/*
-	 * Permanent kmaps:
-	 */
 	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PKMAP_SIZE, pgd_base, 1);
+#else
+	vaddr = FIXADDR_START;
+#endif
+	pmd = pmd_offset(pgd_offset_k(vaddr), vaddr);
+	i = (0UL - (vaddr & PMD_MASK)) >> PMD_SHIFT;
+	pte = (pte_t *)alloc_bootmem_low_pages(i*PAGE_SIZE);
+	for (; --i >= 0; pmd++, pte += PTRS_PER_PTE)
+		set_pmd(pmd, mk_pmd_phys(__pa(pte), __pgprot(_KERNPG_TABLE)));
 
+#if CONFIG_HIGHMEM
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
 	pte = pte_offset_lowmem(pmd, vaddr);
 	pkmap_page_table = pte;
-#endif
-
-#if CONFIG_X86_PAE
-	/*
-	 * Add low memory identity-mappings - SMP needs it when
-	 * starting up on an AP from real-mode. In the non-PAE
-	 * case we already have these mappings through head.S.
-	 * All user-space mappings are explicitly cleared after
-	 * SMP startup.
-	 */
-	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
 #endif
 }
 
diff -urN 1804aa1/include/asm-i386/highmem.h 1804AA1/include/asm-i386/highmem.h
--- 1804aa1/include/asm-i386/highmem.h	Tue Jan 22 12:08:39 2002
+++ 1804AA1/include/asm-i386/highmem.h	Tue Jan 22 13:53:21 2002
@@ -48,11 +48,6 @@
 	KM_NR_SERIES,
 };
 
-/*
- * Right now we initialize only a single pte table. It can be extended
- * easily, subsequent pte tables have to be allocated in one physical
- * chunk of RAM.
- */
 #define LAST_PKMAP 1024
 #define LAST_PKMAP_MASK (LAST_PKMAP-1)
 #define PKMAP_SIZE ((LAST_PKMAP*KM_NR_SERIES) << PAGE_SHIFT)
diff -urN 1804aa1/include/asm-i386/pgtable.h 1804AA1/include/asm-i386/pgtable.h
--- 1804aa1/include/asm-i386/pgtable.h	Tue Jan 22 12:08:39 2002
+++ 1804AA1/include/asm-i386/pgtable.h	Tue Jan 22 13:52:37 2002
@@ -382,7 +382,7 @@
 			__pte_offset(address))
 #define pte_offset_lowmem(dir, address) ((pte_t *) pmd_page_lowmem(*(dir)) + \
 			__pte_offset(address))
-#define pte_kunmap(ptep) kunmap_vaddr((unsigned long) ptep & PAGE_MASK)
+#define pte_kunmap(ptep) kunmap_vaddr((unsigned long)(ptep) & PAGE_MASK)
 
 /*
  * The i386 doesn't have any external MMU info: the kernel page

