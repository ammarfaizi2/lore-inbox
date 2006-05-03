Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWECPnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWECPnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWECPnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:43:46 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:27322 "EHLO
	ms-smtp-03.texas.rr.com") by vger.kernel.org with ESMTP
	id S965227AbWECPnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:43:45 -0400
Subject: [PATCH 1/2][RFC] Shared page tables: standardize macros
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 03 May 2006 10:43:31 -0500
Message-Id: <1146671012.24422.21.camel@wildcat.int.mccr.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the pxd_page/pxd_page_kernel macros consistent
across layers for all architectures.  It is needed for shared
page tables.

Signed-off-by: Dave McCracken <dmccr@.us.ibm.com>

---
 arch/sparc/mm/srmmu.c               |    2 +-
 arch/sparc/mm/sun4c.c               |    2 +-
 arch/x86_64/mm/fault.c              |    4 ++--
 include/asm-alpha/mmzone.h          |    1 +
 include/asm-alpha/pgtable.h         |    5 +++--
 include/asm-generic/4level-fixup.h  |    4 ++++
 include/asm-ia64/pgtable.h          |   10 ++++++----
 include/asm-m32r/pgtable-2level.h   |    6 +++++-
 include/asm-m68k/motorola_pgtable.h |    1 +
 include/asm-mips/pgtable-64.h       |    6 ++++--
 include/asm-parisc/pgtable.h        |    5 +++--
 include/asm-powerpc/pgtable-4k.h    |    5 +++--
 include/asm-powerpc/pgtable.h       |    5 +++--
 include/asm-ppc/pgtable.h           |    2 +-
 include/asm-s390/pgtable.h          |    2 ++
 include/asm-sh/pgtable-2level.h     |    5 ++++-
 include/asm-sh64/pgtable.h          |    4 +++-
 include/asm-sparc/pgtable.h         |    4 ++--
 include/asm-sparc64/pgtable.h       |    5 +++--
 include/asm-um/pgtable-3level.h     |    5 +++--
 include/asm-x86_64/pgtable.h        |   12 ++++++------
 21 files changed, 61 insertions(+), 34 deletions(-)

--- 2.6.17-rc3/./arch/sparc/mm/srmmu.c	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./arch/sparc/mm/srmmu.c	2006-04-28 10:49:17.000000000 -0500
@@ -2176,7 +2176,7 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(pte_pfn, srmmu_pte_pfn, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_page, srmmu_pmd_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgd_page, srmmu_pgd_page, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(pgd_page_kernel, srmmu_pgd_page, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_SETHI(none_mask, 0xF0000000);
 
--- 2.6.17-rc3/./arch/sparc/mm/sun4c.c	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./arch/sparc/mm/sun4c.c	2006-04-28 10:49:17.000000000 -0500
@@ -2281,5 +2281,5 @@ void __init ld_mmu_sun4c(void)
 
 	/* These should _never_ get called with two level tables. */
 	BTFIXUPSET_CALL(pgd_set, sun4c_pgd_set, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(pgd_page, sun4c_pgd_page, BTFIXUPCALL_RETO0);
+	BTFIXUPSET_CALL(pgd_page_kernel, sun4c_pgd_page, BTFIXUPCALL_RETO0);
 }
--- 2.6.17-rc3/./arch/x86_64/mm/fault.c	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./arch/x86_64/mm/fault.c	2006-04-28 10:49:17.000000000 -0500
@@ -160,7 +160,7 @@ void dump_pagetable(unsigned long addres
 	printk("PGD %lx ", pgd_val(*pgd));
 	if (!pgd_present(*pgd)) goto ret; 
 
-	pud = __pud_offset_k((pud_t *)pgd_page(*pgd), address);
+	pud = __pud_offset_k((pud_t *)pgd_page_kernel(*pgd), address);
 	if (bad_address(pud)) goto bad;
 	printk("PUD %lx ", pud_val(*pud));
 	if (!pud_present(*pud))	goto ret;
@@ -274,7 +274,7 @@ static int vmalloc_fault(unsigned long a
 	pud_ref = pud_offset(pgd_ref, address);
 	if (pud_none(*pud_ref))
 		return -1;
-	if (pud_none(*pud) || pud_page(*pud) != pud_page(*pud_ref))
+	if (pud_none(*pud) || pud_page_kernel(*pud) != pud_page_kernel(*pud_ref))
 		BUG();
 	pmd = pmd_offset(pud, address);
 	pmd_ref = pmd_offset(pud_ref, address);
--- 2.6.17-rc3/./include/asm-alpha/mmzone.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-alpha/mmzone.h	2006-04-28 10:49:17.000000000 -0500
@@ -76,6 +76,7 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p, 
 #define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
 
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> 32))
+#define pgd_page(pgd)		(pfn_to_page(pgd_val(pgd) >> 32))
 #define pte_pfn(pte)		(pte_val(pte) >> 32)
 
 #define mk_pte(page, pgprot)						     \
--- 2.6.17-rc3/./include/asm-alpha/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-alpha/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -238,9 +238,10 @@ pmd_page_kernel(pmd_t pmd)
 
 #ifndef CONFIG_DISCONTIGMEM
 #define pmd_page(pmd)	(mem_map + ((pmd_val(pmd) & _PFN_MASK) >> 32))
+#define pgd_page(pgd)	(mem_map + ((pgd_val(pgd) & _PFN_MASK) >> 32))
 #endif
 
-extern inline unsigned long pgd_page(pgd_t pgd)
+extern inline unsigned long pgd_page_kernel(pgd_t pgd)
 { return PAGE_OFFSET + ((pgd_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
 
 extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
@@ -294,7 +295,7 @@ extern inline pte_t pte_mkyoung(pte_t pt
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
-	return (pmd_t *) pgd_page(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
+	return (pmd_t *) pgd_page_kernel(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
 }
 
 /* Find an entry in the third-level page table.. */
--- 2.6.17-rc3/./include/asm-generic/4level-fixup.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-generic/4level-fixup.h	2006-04-28 10:49:17.000000000 -0500
@@ -21,6 +21,10 @@
 #define pud_present(pud)		1
 #define pud_ERROR(pud)			do { } while (0)
 #define pud_clear(pud)			pgd_clear(pud)
+#define pud_val(pud)			pgd_val(pud)
+#define pud_populate(mm, pud, pmd)	pgd_populate(mm, pud, pmd)
+#define pud_page(pud)			pgd_page(pud)
+#define pud_page_kernel(pud)		pgd_page_kernel(pud)
 
 #undef pud_free_tlb
 #define pud_free_tlb(tlb, x)            do { } while (0)
--- 2.6.17-rc3/./include/asm-ia64/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-ia64/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -283,14 +283,16 @@ ia64_phys_addr_valid (unsigned long addr
 #define pud_bad(pud)			(!ia64_phys_addr_valid(pud_val(pud)))
 #define pud_present(pud)		(pud_val(pud) != 0UL)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define pud_page(pud)			((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_page_kernel(pud)		((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
 
 #ifdef CONFIG_PGTABLE_4
 #define pgd_none(pgd)			(!pgd_val(pgd))
 #define pgd_bad(pgd)			(!ia64_phys_addr_valid(pgd_val(pgd)))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0UL)
 #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
-#define pgd_page(pgd)			((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
+#define pgd_page_kernel(pgd)		((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
+#define pgd_page(pgd)			virt_to_page((pgd_val(pgd) + PAGE_OFFSET))
 #endif
 
 /*
@@ -363,12 +365,12 @@ pgd_offset (struct mm_struct *mm, unsign
 #ifdef CONFIG_PGTABLE_4
 /* Find an entry in the second-level page table.. */
 #define pud_offset(dir,addr) \
-	((pud_t *) pgd_page(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
+	((pud_t *) pgd_page_kernel(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 #endif
 
 /* Find an entry in the third-level page table.. */
 #define pmd_offset(dir,addr) \
-	((pmd_t *) pud_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+	((pmd_t *) pud_page_kernel(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
 
 /*
  * Find an entry in the third-level page table.  This looks more complicated than it
--- 2.6.17-rc3/./include/asm-m32r/pgtable-2level.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-m32r/pgtable-2level.h	2006-04-28 10:49:17.000000000 -0500
@@ -53,9 +53,13 @@ static inline int pgd_present(pgd_t pgd)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
 #define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)
 
-#define pgd_page(pgd) \
+#define pgd_page_kernel(pgd) \
 ((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
 
+#ifndef CONFIG_DISCONTIGMEM
+#define pgd_page(pgd)	(mem_map + ((pgd_val(pgd) >> PAGE_SHIFT) - PFN_BASE))
+#endif /* !CONFIG_DISCONTIGMEM */
+
 static inline pmd_t *pmd_offset(pgd_t * dir, unsigned long address)
 {
 	return (pmd_t *) dir;
--- 2.6.17-rc3/./include/asm-m68k/motorola_pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-m68k/motorola_pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -151,6 +151,7 @@ static inline void pgd_set(pgd_t *pgdp, 
 #define pgd_bad(pgd)		((pgd_val(pgd) & _DESCTYPE_MASK) != _PAGE_TABLE)
 #define pgd_present(pgd)	(pgd_val(pgd) & _PAGE_TABLE)
 #define pgd_clear(pgdp)		({ pgd_val(*pgdp) = 0; })
+#define pgd_page(pgd)		(mem_map + ((unsigned long)(__va(pgd_val(pgd)) - PAGE_OFFSET) >> PAGE_SHIFT))
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
--- 2.6.17-rc3/./include/asm-mips/pgtable-64.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-mips/pgtable-64.h	2006-04-28 10:49:17.000000000 -0500
@@ -179,15 +179,17 @@ static inline void pud_clear(pud_t *pudp
 /* to find an entry in a page-table-directory */
 #define pgd_offset(mm,addr)	((mm)->pgd + pgd_index(addr))
 
-static inline unsigned long pud_page(pud_t pud)
+static inline unsigned long pud_page_kernel(pud_t pud)
 {
 	return pud_val(pud);
 }
+#define pud_phys(pud)		(pud_val(pud) - PAGE_OFFSET)
+#define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
 
 /* Find an entry in the second-level page table.. */
 static inline pmd_t *pmd_offset(pud_t * pud, unsigned long address)
 {
-	return (pmd_t *) pud_page(*pud) + pmd_index(address);
+	return (pmd_t *) pud_page_kernel(*pud) + pmd_index(address);
 }
 
 /* Find an entry in the third-level page table.. */
--- 2.6.17-rc3/./include/asm-parisc/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-parisc/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -304,7 +304,8 @@ static inline void pmd_clear(pmd_t *pmd)
 
 
 #if PT_NLEVELS == 3
-#define pgd_page(pgd) ((unsigned long) __va(pgd_address(pgd)))
+#define pgd_page_kernel(pgd) ((unsigned long) __va(pgd_address(pgd)))
+#define pgd_page(pgd)	virt_to_page((void *)pgd_page_kernel(pgd))
 
 /* For 64 bit we have three level tables */
 
@@ -401,7 +402,7 @@ extern inline pte_t pte_modify(pte_t pte
 
 #if PT_NLEVELS == 3
 #define pmd_offset(dir,address) \
-((pmd_t *) pgd_page(*(dir)) + (((address)>>PMD_SHIFT) & (PTRS_PER_PMD-1)))
+((pmd_t *) pgd_page_kernel(*(dir)) + (((address)>>PMD_SHIFT) & (PTRS_PER_PMD-1)))
 #else
 #define pmd_offset(dir,addr) ((pmd_t *) dir)
 #endif
--- 2.6.17-rc3/./include/asm-powerpc/pgtable-4k.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-powerpc/pgtable-4k.h	2006-04-28 10:49:17.000000000 -0500
@@ -86,10 +86,11 @@
 #define pgd_bad(pgd)		(pgd_val(pgd) == 0)
 #define pgd_present(pgd)	(pgd_val(pgd) != 0)
 #define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0)
-#define pgd_page(pgd)		(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define pgd_page_kernel(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define pgd_page(pgd)		virt_to_page(pgd_page_kernel(pgd))
 
 #define pud_offset(pgdp, addr)	\
-  (((pud_t *) pgd_page(*(pgdp))) + \
+  (((pud_t *) pgd_page_kernel(*(pgdp))) + \
     (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 
 #define pud_ERROR(e) \
--- 2.6.17-rc3/./include/asm-powerpc/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-powerpc/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -206,7 +206,8 @@ static inline pte_t pfn_pte(unsigned lon
 				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
 #define pud_clear(pudp)		(pud_val(*(pudp)) = 0)
-#define pud_page(pud)		(pud_val(pud) & ~PUD_MASKED_BITS)
+#define pud_page_kernel(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+#define pud_page(pud)		virt_to_page(pud_page_kernel(pud))
 
 #define pgd_set(pgdp, pudp)	({pgd_val(*(pgdp)) = (unsigned long)(pudp);})
 
@@ -220,7 +221,7 @@ static inline pte_t pfn_pte(unsigned lon
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
 #define pmd_offset(pudp,addr) \
-  (((pmd_t *) pud_page(*(pudp))) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+  (((pmd_t *) pud_page_kernel(*(pudp))) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
 
 #define pte_offset_kernel(dir,addr) \
   (((pte_t *) pmd_page_kernel(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
--- 2.6.17-rc3/./include/asm-ppc/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-ppc/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -527,7 +527,7 @@ static inline int pgd_bad(pgd_t pgd)		{ 
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
 #define pgd_clear(xp)				do { } while (0)
 
-#define pgd_page(pgd) \
+#define pgd_page_kernel(pgd) \
 	((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
 
 /*
--- 2.6.17-rc3/./include/asm-s390/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-s390/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -685,6 +685,8 @@ static inline pte_t mk_pte_phys(unsigned
 
 #define pgd_page_kernel(pgd) (pgd_val(pgd) & PAGE_MASK)
 
+#define pgd_page(pgd) (mem_map+(pgd_val(pgd) >> PAGE_SHIFT))
+
 /* to find an entry in a page-table-directory */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
--- 2.6.17-rc3/./include/asm-sh/pgtable-2level.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-sh/pgtable-2level.h	2006-04-28 10:49:17.000000000 -0500
@@ -50,9 +50,12 @@ static inline void pgd_clear (pgd_t * pg
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
 #define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)
 
-#define pgd_page(pgd) \
+#define pgd_page_kernel(pgd) \
 ((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
 
+#define pgd_page(pgd) \
+	(phys_to_page(pgd_val(pgd)))
+
 static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
 	return (pmd_t *) dir;
--- 2.6.17-rc3/./include/asm-sh64/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-sh64/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -191,7 +191,9 @@ static inline int pgd_bad(pgd_t pgd)		{ 
 #endif
 
 
-#define pgd_page(pgd_entry)	((unsigned long) (pgd_val(pgd_entry) & PAGE_MASK))
+#define pgd_page_kernel(pgd_entry)	((unsigned long) (pgd_val(pgd_entry) & PAGE_MASK))
+#define pgd_page(pgd)	(virt_to_page(pgd_val(pgd)))
+
 
 /*
  * PMD defines. Middle level.
--- 2.6.17-rc3/./include/asm-sparc/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-sparc/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -144,10 +144,10 @@ extern unsigned long empty_zero_page;
 /*
  */
 BTFIXUPDEF_CALL_CONST(struct page *, pmd_page, pmd_t)
-BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page, pgd_t)
+BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page_kernel, pgd_t)
 
 #define pmd_page(pmd) BTFIXUP_CALL(pmd_page)(pmd)
-#define pgd_page(pgd) BTFIXUP_CALL(pgd_page)(pgd)
+#define pgd_page_kernel(pgd) BTFIXUP_CALL(pgd_page_kernel)(pgd)
 
 BTFIXUPDEF_SETHI(none_mask)
 BTFIXUPDEF_CALL_CONST(int, pte_present, pte_t)
--- 2.6.17-rc3/./include/asm-sparc64/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-sparc64/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -631,8 +631,9 @@ static inline unsigned long pte_present(
 #define __pmd_page(pmd)		\
 	((unsigned long) __va((((unsigned long)pmd_val(pmd))<<11UL)))
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
-#define pud_page(pud)		\
+#define pud_page_kernel(pud)		\
 	((unsigned long) __va((((unsigned long)pud_val(pud))<<11UL)))
+#define pud_page(pud) 			virt_to_page((void *)pud_page_kernel(pud))
 #define pmd_none(pmd)			(!pmd_val(pmd))
 #define pmd_bad(pmd)			(0)
 #define pmd_present(pmd)		(pmd_val(pmd) != 0U)
@@ -654,7 +655,7 @@ static inline unsigned long pte_present(
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(pudp, address)	\
-	((pmd_t *) pud_page(*(pudp)) + \
+	((pmd_t *) pud_page_kernel(*(pudp)) + \
 	 (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1)))
 
 /* Find an entry in the third-level page table.. */
--- 2.6.17-rc3/./include/asm-um/pgtable-3level.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-um/pgtable-3level.h	2006-04-28 10:49:17.000000000 -0500
@@ -74,11 +74,12 @@ extern inline void pud_clear (pud_t *pud
         set_pud(pud, __pud(0));
 }
 
-#define pud_page(pud) \
+#define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
+#define pud_page_kernel(pud) \
 	((struct page *) __va(pud_val(pud) & PAGE_MASK))
 
 /* Find an entry in the second-level page table.. */
-#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
+#define pmd_offset(pud, address) ((pmd_t *) pud_page_kernel(*(pud)) + \
 			pmd_index(address))
 
 static inline unsigned long pte_pfn(pte_t pte)
--- 2.6.17-rc3/./include/asm-x86_64/pgtable.h	2006-04-26 21:19:25.000000000 -0500
+++ 2.6.17-rc3-macro/./include/asm-x86_64/pgtable.h	2006-04-28 10:49:17.000000000 -0500
@@ -101,9 +101,6 @@ static inline void pgd_clear (pgd_t * pg
 	set_pgd(pgd, __pgd(0));
 }
 
-#define pud_page(pud) \
-((unsigned long) __va(pud_val(pud) & PHYSICAL_PAGE_MASK))
-
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
 
 struct mm_struct;
@@ -326,7 +323,8 @@ static inline int pmd_large(pmd_t pte) {
 /*
  * Level 4 access.
  */
-#define pgd_page(pgd) ((unsigned long) __va((unsigned long)pgd_val(pgd) & PTE_MASK))
+#define pgd_page_kernel(pgd) ((unsigned long) __va((unsigned long)pgd_val(pgd) & PTE_MASK))
+#define pgd_page(pgd)		(pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT))
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pgd_offset(mm, addr) ((mm)->pgd + pgd_index(addr))
 #define pgd_offset_k(address) (init_level4_pgt + pgd_index(address))
@@ -335,8 +333,10 @@ static inline int pmd_large(pmd_t pte) {
 
 /* PUD - Level3 access */
 /* to find an entry in a page-table-directory. */
+#define pud_page_kernel(pud) ((unsigned long) __va(pud_val(pud) & PHYSICAL_PAGE_MASK))
+#define pud_page(pud)		(pfn_to_page(pud_val(pud) >> PAGE_SHIFT))
 #define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-#define pud_offset(pgd, address) ((pud_t *) pgd_page(*(pgd)) + pud_index(address))
+#define pud_offset(pgd, address) ((pud_t *) pgd_page_kernel(*(pgd)) + pud_index(address))
 #define pud_offset_k(pgd, addr) pud_offset(pgd, addr)
 #define pud_present(pud) (pud_val(pud) & _PAGE_PRESENT)
 
@@ -350,7 +350,7 @@ static inline pud_t *__pud_offset_k(pud_
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-#define pmd_offset(dir, address) ((pmd_t *) pud_page(*(dir)) + \
+#define pmd_offset(dir, address) ((pmd_t *) pud_page_kernel(*(dir)) + \
 			pmd_index(address))
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)


