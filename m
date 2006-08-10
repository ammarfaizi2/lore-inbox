Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWHJWTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWHJWTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 18:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWHJWTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 18:19:05 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:12215 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750963AbWHJWTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 18:19:02 -0400
Date: Thu, 10 Aug 2006 17:18:46 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Message-Id: <20060810221846.11811.10135.sendpatch@wildcat>
Subject: [PATCH] Standardize pxx_page macros
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of the changes necessary for shared page tables is to standardize
the pxx_page macros.  pte_page and pmd_page have always returned the
struct page associated with their entry, while pte_page_kernel and
pmd_page_kernel have returned the kernel virtual address. pud_page and
pgd_page, on the other hand, return the kernel virtual address.

Shared page tables needs pud_page and pgd_page to return the actual
page structures.  There are very few actual users of these functions,
so it is simple to standardize their usage.

Since this is basic cleanup, I am submitting these changes as a
standalone patch.    Per Hugh Dickins' comments about it, I am
also changing the pxx_page_kernel macros to pxx_page_vaddr to clarify
their meaning.

Dave McCracken

Signed-off-by: Dave McCracken <dmccr@us.ibm.com>

------------------------

Diffstat:

 arch/sh/mm/cache-sh7705.c           |    2 +-
 arch/sparc/mm/srmmu.c               |    2 +-
 arch/sparc/mm/sun4c.c               |    2 +-
 arch/um/kernel/skas/mmu.c           |    2 +-
 arch/x86_64/mm/fault.c              |    6 +++---
 include/asm-alpha/mmzone.h          |    1 +
 include/asm-alpha/pgtable.h         |    9 +++++----
 include/asm-arm/pgtable.h           |    8 ++++----
 include/asm-arm26/pgtable.h         |    8 ++++----
 include/asm-cris/pgtable.h          |    4 ++--
 include/asm-frv/pgtable.h           |    8 ++++----
 include/asm-generic/4level-fixup.h  |    4 ++++
 include/asm-generic/pgtable-nopmd.h |    2 +-
 include/asm-generic/pgtable-nopud.h |    2 +-
 include/asm-i386/pgtable-3level.h   |    2 +-
 include/asm-i386/pgtable.h          |    4 ++--
 include/asm-ia64/pgtable.h          |   14 ++++++++------
 include/asm-m32r/pgtable-2level.h   |    6 +++++-
 include/asm-m32r/pgtable.h          |    4 ++--
 include/asm-m68k/motorola_pgtable.h |    1 +
 include/asm-mips/pgtable-32.h       |    4 ++--
 include/asm-mips/pgtable-64.h       |   10 ++++++----
 include/asm-mips/pgtable.h          |    2 +-
 include/asm-parisc/pgtable.h        |    9 +++++----
 include/asm-powerpc/pgtable-4k.h    |    5 +++--
 include/asm-powerpc/pgtable.h       |   11 ++++++-----
 include/asm-ppc/pgtable.h           |    8 ++++----
 include/asm-s390/pgtable.h          |   10 ++++++----
 include/asm-sh/pgtable-2level.h     |    5 ++++-
 include/asm-sh/pgtable.h            |    4 ++--
 include/asm-sh64/pgtable.h          |    6 ++++--
 include/asm-sparc/pgtable.h         |    4 ++--
 include/asm-sparc64/pgtable.h       |    5 +++--
 include/asm-um/pgtable-2level.h     |    2 +-
 include/asm-um/pgtable-3level.h     |    5 +++--
 include/asm-um/pgtable.h            |    4 ++--
 include/asm-x86_64/pgtable.h        |   16 ++++++++--------
 include/asm-xtensa/pgtable.h        |    4 ++--
 38 files changed, 116 insertions(+), 89 deletions(-)

------------------------

--- 2.6.18-rc4/./arch/sh/mm/cache-sh7705.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./arch/sh/mm/cache-sh7705.c	2006-08-07 19:28:26.000000000 -0500
@@ -30,7 +30,7 @@
 
 #define __pte_offset(address) \
 		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
-#define pte_offset(dir, address) ((pte_t *) pmd_page_kernel(*(dir)) + \
+#define pte_offset(dir, address) ((pte_t *) pmd_page_vaddr(*(dir)) + \
 		__pte_offset(address))
 
 static inline void cache_wback_all(void)
--- 2.6.18-rc4/./arch/sparc/mm/srmmu.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./arch/sparc/mm/srmmu.c	2006-08-07 19:28:26.000000000 -0500
@@ -2175,7 +2175,7 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(pte_pfn, srmmu_pte_pfn, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_page, srmmu_pmd_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgd_page, srmmu_pgd_page, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(pgd_page_vaddr, srmmu_pgd_page, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_SETHI(none_mask, 0xF0000000);
 
--- 2.6.18-rc4/./arch/sparc/mm/sun4c.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./arch/sparc/mm/sun4c.c	2006-08-07 19:28:26.000000000 -0500
@@ -2280,5 +2280,5 @@ void __init ld_mmu_sun4c(void)
 
 	/* These should _never_ get called with two level tables. */
 	BTFIXUPSET_CALL(pgd_set, sun4c_pgd_set, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(pgd_page, sun4c_pgd_page, BTFIXUPCALL_RETO0);
+	BTFIXUPSET_CALL(pgd_page_vaddr, sun4c_pgd_page, BTFIXUPCALL_RETO0);
 }
--- 2.6.18-rc4/./arch/um/kernel/skas/mmu.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./arch/um/kernel/skas/mmu.c	2006-08-07 19:28:26.000000000 -0500
@@ -55,7 +55,7 @@ static int init_stub_pte(struct mm_struc
 	 * destroy_context_skas.
 	 */
 
-        mm->context.skas.last_page_table = pmd_page_kernel(*pmd);
+        mm->context.skas.last_page_table = pmd_page_vaddr(*pmd);
 #ifdef CONFIG_3_LEVEL_PGTABLES
         mm->context.skas.last_pmd = (unsigned long) __va(pud_val(*pud));
 #endif
--- 2.6.18-rc4/./arch/x86_64/mm/fault.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./arch/x86_64/mm/fault.c	2006-08-07 19:28:26.000000000 -0500
@@ -299,7 +299,7 @@ static int vmalloc_fault(unsigned long a
 	if (pgd_none(*pgd))
 		set_pgd(pgd, *pgd_ref);
 	else
-		BUG_ON(pgd_page(*pgd) != pgd_page(*pgd_ref));
+		BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
 
 	/* Below here mismatches are bugs because these lower tables
 	   are shared */
@@ -308,7 +308,7 @@ static int vmalloc_fault(unsigned long a
 	pud_ref = pud_offset(pgd_ref, address);
 	if (pud_none(*pud_ref))
 		return -1;
-	if (pud_none(*pud) || pud_page(*pud) != pud_page(*pud_ref))
+	if (pud_none(*pud) || pud_page_vaddr(*pud) != pud_page_vaddr(*pud_ref))
 		BUG();
 	pmd = pmd_offset(pud, address);
 	pmd_ref = pmd_offset(pud_ref, address);
@@ -641,7 +641,7 @@ void vmalloc_sync_all(void)
 				if (pgd_none(*pgd))
 					set_pgd(pgd, *pgd_ref);
 				else
-					BUG_ON(pgd_page(*pgd) != pgd_page(*pgd_ref));
+					BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
 			}
 			spin_unlock(&pgd_lock);
 			set_bit(pgd_index(address), insync);
--- 2.6.18-rc4/./include/asm-alpha/mmzone.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-alpha/mmzone.h	2006-08-07 19:28:26.000000000 -0500
@@ -75,6 +75,7 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p, 
 #define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
 
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> 32))
+#define pgd_page(pgd)		(pfn_to_page(pgd_val(pgd) >> 32))
 #define pte_pfn(pte)		(pte_val(pte) >> 32)
 
 #define mk_pte(page, pgprot)						     \
--- 2.6.18-rc4/./include/asm-alpha/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-alpha/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -230,16 +230,17 @@ extern inline void pgd_set(pgd_t * pgdp,
 
 
 extern inline unsigned long
-pmd_page_kernel(pmd_t pmd)
+pmd_page_vaddr(pmd_t pmd)
 {
 	return ((pmd_val(pmd) & _PFN_MASK) >> (32-PAGE_SHIFT)) + PAGE_OFFSET;
 }
 
 #ifndef CONFIG_DISCONTIGMEM
 #define pmd_page(pmd)	(mem_map + ((pmd_val(pmd) & _PFN_MASK) >> 32))
+#define pgd_page(pgd)	(mem_map + ((pgd_val(pgd) & _PFN_MASK) >> 32))
 #endif
 
-extern inline unsigned long pgd_page(pgd_t pgd)
+extern inline unsigned long pgd_page_vaddr(pgd_t pgd)
 { return PAGE_OFFSET + ((pgd_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
 
 extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
@@ -293,13 +294,13 @@ extern inline pte_t pte_mkyoung(pte_t pt
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
-	return (pmd_t *) pgd_page(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
+	return (pmd_t *) pgd_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
 }
 
 /* Find an entry in the third-level page table.. */
 extern inline pte_t * pte_offset_kernel(pmd_t * dir, unsigned long address)
 {
-	return (pte_t *) pmd_page_kernel(*dir)
+	return (pte_t *) pmd_page_vaddr(*dir)
 		+ ((address >> PAGE_SHIFT) & (PTRS_PER_PAGE - 1));
 }
 
--- 2.6.18-rc4/./include/asm-arm/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-arm/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -224,9 +224,9 @@ extern struct page *empty_zero_page;
 #define pte_none(pte)		(!pte_val(pte))
 #define pte_clear(mm,addr,ptep)	set_pte_at((mm),(addr),(ptep), __pte(0))
 #define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
-#define pte_offset_kernel(dir,addr)	(pmd_page_kernel(*(dir)) + __pte_index(addr))
-#define pte_offset_map(dir,addr)	(pmd_page_kernel(*(dir)) + __pte_index(addr))
-#define pte_offset_map_nested(dir,addr)	(pmd_page_kernel(*(dir)) + __pte_index(addr))
+#define pte_offset_kernel(dir,addr)	(pmd_page_vaddr(*(dir)) + __pte_index(addr))
+#define pte_offset_map(dir,addr)	(pmd_page_vaddr(*(dir)) + __pte_index(addr))
+#define pte_offset_map_nested(dir,addr)	(pmd_page_vaddr(*(dir)) + __pte_index(addr))
 #define pte_unmap(pte)		do { } while (0)
 #define pte_unmap_nested(pte)	do { } while (0)
 
@@ -291,7 +291,7 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 		clean_pmd_entry(pmdp);	\
 	} while (0)
 
-static inline pte_t *pmd_page_kernel(pmd_t pmd)
+static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
 	unsigned long ptr;
 
--- 2.6.18-rc4/./include/asm-arm26/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-arm26/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -186,12 +186,12 @@ extern struct page *empty_zero_page;
  * return a pointer to memory (no special alignment)
  */
 #define pmd_page(pmd)  ((struct page *)(pmd_val((pmd)) & ~_PMD_PRESENT))
-#define pmd_page_kernel(pmd) ((pte_t *)(pmd_val((pmd)) & ~_PMD_PRESENT))
+#define pmd_page_vaddr(pmd) ((pte_t *)(pmd_val((pmd)) & ~_PMD_PRESENT))
 
-#define pte_offset_kernel(dir,addr)     (pmd_page_kernel(*(dir)) + __pte_index(addr))
+#define pte_offset_kernel(dir,addr)     (pmd_page_vaddr(*(dir)) + __pte_index(addr))
 
-#define pte_offset_map(dir,addr)        (pmd_page_kernel(*(dir)) + __pte_index(addr))
-#define pte_offset_map_nested(dir,addr) (pmd_page_kernel(*(dir)) + __pte_index(addr))
+#define pte_offset_map(dir,addr)        (pmd_page_vaddr(*(dir)) + __pte_index(addr))
+#define pte_offset_map_nested(dir,addr) (pmd_page_vaddr(*(dir)) + __pte_index(addr))
 #define pte_unmap(pte)                  do { } while (0)
 #define pte_unmap_nested(pte)           do { } while (0)
 
--- 2.6.18-rc4/./include/asm-cris/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-cris/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -253,7 +253,7 @@ static inline void pmd_set(pmd_t * pmdp,
 { pmd_val(*pmdp) = _PAGE_TABLE | (unsigned long) ptep; }
 
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
-#define pmd_page_kernel(pmd)	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+#define pmd_page_vaddr(pmd)	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
@@ -271,7 +271,7 @@ static inline pgd_t * pgd_offset(struct 
 #define __pte_offset(address) \
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) \
-	((pte_t *) pmd_page_kernel(*(dir)) +  __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) +  __pte_offset(address))
 #define pte_offset_map(dir, address) \
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
 #define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
--- 2.6.18-rc4/./include/asm-frv/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-frv/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -217,7 +217,7 @@ static inline pud_t *pud_offset(pgd_t *p
 }
 
 #define pgd_page(pgd)				(pud_page((pud_t){ pgd }))
-#define pgd_page_kernel(pgd)			(pud_page_kernel((pud_t){ pgd }))
+#define pgd_page_vaddr(pgd)			(pud_page_vaddr((pud_t){ pgd }))
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is
@@ -246,7 +246,7 @@ static inline void pud_clear(pud_t *pud)
 #define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
 
 #define pud_page(pud)				(pmd_page((pmd_t){ pud }))
-#define pud_page_kernel(pud)			(pmd_page_kernel((pmd_t){ pud }))
+#define pud_page_vaddr(pud)			(pmd_page_vaddr((pmd_t){ pud }))
 
 /*
  * (pmds are folded into pgds so this doesn't get actually called,
@@ -362,7 +362,7 @@ static inline pmd_t *pmd_offset(pud_t *d
 #define	pmd_bad(x)	(pmd_val(x) & xAMPRx_SS)
 #define pmd_clear(xp)	do { __set_pmd(xp, 0); } while(0)
 
-#define pmd_page_kernel(pmd) \
+#define pmd_page_vaddr(pmd) \
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -458,7 +458,7 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_index(address) \
 		(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) \
-	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) +  pte_index(address))
 
 #if defined(CONFIG_HIGHPTE)
 #define pte_offset_map(dir, address) \
--- 2.6.18-rc4/./include/asm-generic/4level-fixup.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-generic/4level-fixup.h	2006-08-07 19:28:26.000000000 -0500
@@ -21,6 +21,10 @@
 #define pud_present(pud)		1
 #define pud_ERROR(pud)			do { } while (0)
 #define pud_clear(pud)			pgd_clear(pud)
+#define pud_val(pud)			pgd_val(pud)
+#define pud_populate(mm, pud, pmd)	pgd_populate(mm, pud, pmd)
+#define pud_page(pud)			pgd_page(pud)
+#define pud_page_vaddr(pud)		pgd_page_vaddr(pud)
 
 #undef pud_free_tlb
 #define pud_free_tlb(tlb, x)            do { } while (0)
--- 2.6.18-rc4/./include/asm-generic/pgtable-nopmd.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-generic/pgtable-nopmd.h	2006-08-07 19:28:26.000000000 -0500
@@ -47,7 +47,7 @@ static inline pmd_t * pmd_offset(pud_t *
 #define __pmd(x)				((pmd_t) { __pud(x) } )
 
 #define pud_page(pud)				(pmd_page((pmd_t){ pud }))
-#define pud_page_kernel(pud)			(pmd_page_kernel((pmd_t){ pud }))
+#define pud_page_vaddr(pud)			(pmd_page_vaddr((pmd_t){ pud }))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
--- 2.6.18-rc4/./include/asm-generic/pgtable-nopud.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-generic/pgtable-nopud.h	2006-08-07 19:28:26.000000000 -0500
@@ -44,7 +44,7 @@ static inline pud_t * pud_offset(pgd_t *
 #define __pud(x)				((pud_t) { __pgd(x) } )
 
 #define pgd_page(pgd)				(pud_page((pud_t){ pgd }))
-#define pgd_page_kernel(pgd)			(pud_page_kernel((pud_t){ pgd }))
+#define pgd_page_vaddr(pgd)			(pud_page_vaddr((pud_t){ pgd }))
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is
--- 2.6.18-rc4/./include/asm-i386/pgtable-3level.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-i386/pgtable-3level.h	2006-08-07 19:28:26.000000000 -0500
@@ -77,7 +77,7 @@ static inline void pud_clear (pud_t * pu
 #define pud_page(pud) \
 ((struct page *) __va(pud_val(pud) & PAGE_MASK))
 
-#define pud_page_kernel(pud) \
+#define pud_page_vaddr(pud) \
 ((unsigned long) __va(pud_val(pud) & PAGE_MASK))
 
 
--- 2.6.18-rc4/./include/asm-i386/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-i386/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -364,11 +364,11 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_index(address) \
 		(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) \
-	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) +  pte_index(address))
 
 #define pmd_page(pmd) (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
-#define pmd_page_kernel(pmd) \
+#define pmd_page_vaddr(pmd) \
 		((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
--- 2.6.18-rc4/./include/asm-ia64/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-ia64/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -275,21 +275,23 @@ ia64_phys_addr_valid (unsigned long addr
 #define pmd_bad(pmd)			(!ia64_phys_addr_valid(pmd_val(pmd)))
 #define pmd_present(pmd)		(pmd_val(pmd) != 0UL)
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
-#define pmd_page_kernel(pmd)		((unsigned long) __va(pmd_val(pmd) & _PFN_MASK))
+#define pmd_page_vaddr(pmd)		((unsigned long) __va(pmd_val(pmd) & _PFN_MASK))
 #define pmd_page(pmd)			virt_to_page((pmd_val(pmd) + PAGE_OFFSET))
 
 #define pud_none(pud)			(!pud_val(pud))
 #define pud_bad(pud)			(!ia64_phys_addr_valid(pud_val(pud)))
 #define pud_present(pud)		(pud_val(pud) != 0UL)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define pud_page(pud)			((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_page_vaddr(pud)		((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
 
 #ifdef CONFIG_PGTABLE_4
 #define pgd_none(pgd)			(!pgd_val(pgd))
 #define pgd_bad(pgd)			(!ia64_phys_addr_valid(pgd_val(pgd)))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0UL)
 #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
-#define pgd_page(pgd)			((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
+#define pgd_page_vaddr(pgd)		((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
+#define pgd_page(pgd)			virt_to_page((pgd_val(pgd) + PAGE_OFFSET))
 #endif
 
 /*
@@ -360,19 +362,19 @@ pgd_offset (struct mm_struct *mm, unsign
 #ifdef CONFIG_PGTABLE_4
 /* Find an entry in the second-level page table.. */
 #define pud_offset(dir,addr) \
-	((pud_t *) pgd_page(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
+	((pud_t *) pgd_page_vaddr(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 #endif
 
 /* Find an entry in the third-level page table.. */
 #define pmd_offset(dir,addr) \
-	((pmd_t *) pud_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+	((pmd_t *) pud_page_vaddr(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
 
 /*
  * Find an entry in the third-level page table.  This looks more complicated than it
  * should be because some platforms place page tables in high memory.
  */
 #define pte_index(addr)	 	(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
-#define pte_offset_kernel(dir,addr)	((pte_t *) pmd_page_kernel(*(dir)) + pte_index(addr))
+#define pte_offset_kernel(dir,addr)	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(addr))
 #define pte_offset_map(dir,addr)	pte_offset_kernel(dir, addr)
 #define pte_offset_map_nested(dir,addr)	pte_offset_map(dir, addr)
 #define pte_unmap(pte)			do { } while (0)
--- 2.6.18-rc4/./include/asm-m32r/pgtable-2level.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-m32r/pgtable-2level.h	2006-08-07 19:28:26.000000000 -0500
@@ -52,9 +52,13 @@ static inline int pgd_present(pgd_t pgd)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
 #define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)
 
-#define pgd_page(pgd) \
+#define pgd_page_vaddr(pgd) \
 ((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
 
+#ifndef CONFIG_DISCONTIGMEM
+#define pgd_page(pgd)	(mem_map + ((pgd_val(pgd) >> PAGE_SHIFT) - PFN_BASE))
+#endif /* !CONFIG_DISCONTIGMEM */
+
 static inline pmd_t *pmd_offset(pgd_t * dir, unsigned long address)
 {
 	return (pmd_t *) dir;
--- 2.6.18-rc4/./include/asm-m32r/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-m32r/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -336,7 +336,7 @@ static inline void pmd_set(pmd_t * pmdp,
 	pmd_val(*pmdp) = (((unsigned long) ptep) & PAGE_MASK);
 }
 
-#define pmd_page_kernel(pmd)	\
+#define pmd_page_vaddr(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -358,7 +358,7 @@ static inline void pmd_set(pmd_t * pmdp,
 #define pte_index(address)	\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address)	\
-	((pte_t *)pmd_page_kernel(*(dir)) + pte_index(address))
+	((pte_t *)pmd_page_vaddr(*(dir)) + pte_index(address))
 #define pte_offset_map(dir, address)	\
 	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
 #define pte_offset_map_nested(dir, address)	pte_offset_map(dir, address)
--- 2.6.18-rc4/./include/asm-m68k/motorola_pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-m68k/motorola_pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -150,6 +150,7 @@ static inline void pgd_set(pgd_t *pgdp, 
 #define pgd_bad(pgd)		((pgd_val(pgd) & _DESCTYPE_MASK) != _PAGE_TABLE)
 #define pgd_present(pgd)	(pgd_val(pgd) & _PAGE_TABLE)
 #define pgd_clear(pgdp)		({ pgd_val(*pgdp) = 0; })
+#define pgd_page(pgd)		(mem_map + ((unsigned long)(__va(pgd_val(pgd)) - PAGE_OFFSET) >> PAGE_SHIFT))
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
--- 2.6.18-rc4/./include/asm-mips/pgtable-32.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-mips/pgtable-32.h	2006-08-07 19:28:26.000000000 -0500
@@ -156,9 +156,9 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 #define __pte_offset(address)						\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address)					\
-	((pte_t *) (pmd_page_kernel(*dir)) + __pte_offset(address))
+	((pte_t *) (pmd_page_vaddr(*dir)) + __pte_offset(address))
 #define pte_offset_kernel(dir, address) \
-	((pte_t *) pmd_page_kernel(*(dir)) +  __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) +  __pte_offset(address))
 
 #define pte_offset_map(dir, address)                                    \
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
--- 2.6.18-rc4/./include/asm-mips/pgtable-64.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-mips/pgtable-64.h	2006-08-07 19:28:26.000000000 -0500
@@ -178,24 +178,26 @@ static inline void pud_clear(pud_t *pudp
 /* to find an entry in a page-table-directory */
 #define pgd_offset(mm,addr)	((mm)->pgd + pgd_index(addr))
 
-static inline unsigned long pud_page(pud_t pud)
+static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	return pud_val(pud);
 }
+#define pud_phys(pud)		(pud_val(pud) - PAGE_OFFSET)
+#define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
 
 /* Find an entry in the second-level page table.. */
 static inline pmd_t *pmd_offset(pud_t * pud, unsigned long address)
 {
-	return (pmd_t *) pud_page(*pud) + pmd_index(address);
+	return (pmd_t *) pud_page_vaddr(*pud) + pmd_index(address);
 }
 
 /* Find an entry in the third-level page table.. */
 #define __pte_offset(address)						\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address)					\
-	((pte_t *) (pmd_page_kernel(*dir)) + __pte_offset(address))
+	((pte_t *) (pmd_page_vaddr(*dir)) + __pte_offset(address))
 #define pte_offset_kernel(dir, address)					\
-	((pte_t *) pmd_page_kernel(*(dir)) +  __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) +  __pte_offset(address))
 #define pte_offset_map(dir, address)					\
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
 #define pte_offset_map_nested(dir, address)				\
--- 2.6.18-rc4/./include/asm-mips/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-mips/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -87,7 +87,7 @@ extern void paging_init(void);
  */
 #define pmd_phys(pmd)		(pmd_val(pmd) - PAGE_OFFSET)
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
-#define pmd_page_kernel(pmd)	pmd_val(pmd)
+#define pmd_page_vaddr(pmd)	pmd_val(pmd)
 
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
 
--- 2.6.18-rc4/./include/asm-parisc/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-parisc/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -303,7 +303,8 @@ static inline void pmd_clear(pmd_t *pmd)
 
 
 #if PT_NLEVELS == 3
-#define pgd_page(pgd) ((unsigned long) __va(pgd_address(pgd)))
+#define pgd_page_vaddr(pgd) ((unsigned long) __va(pgd_address(pgd)))
+#define pgd_page(pgd)	virt_to_page((void *)pgd_page_vaddr(pgd))
 
 /* For 64 bit we have three level tables */
 
@@ -382,7 +383,7 @@ extern inline pte_t pte_modify(pte_t pte
 
 #define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
 
-#define pmd_page_kernel(pmd)	((unsigned long) __va(pmd_address(pmd)))
+#define pmd_page_vaddr(pmd)	((unsigned long) __va(pmd_address(pmd)))
 
 #define __pmd_page(pmd) ((unsigned long) __va(pmd_address(pmd)))
 #define pmd_page(pmd)	virt_to_page((void *)__pmd_page(pmd))
@@ -400,7 +401,7 @@ extern inline pte_t pte_modify(pte_t pte
 
 #if PT_NLEVELS == 3
 #define pmd_offset(dir,address) \
-((pmd_t *) pgd_page(*(dir)) + (((address)>>PMD_SHIFT) & (PTRS_PER_PMD-1)))
+((pmd_t *) pgd_page_vaddr(*(dir)) + (((address)>>PMD_SHIFT) & (PTRS_PER_PMD-1)))
 #else
 #define pmd_offset(dir,addr) ((pmd_t *) dir)
 #endif
@@ -408,7 +409,7 @@ extern inline pte_t pte_modify(pte_t pte
 /* Find an entry in the third-level page table.. */ 
 #define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 #define pte_offset_kernel(pmd, address) \
-	((pte_t *) pmd_page_kernel(*(pmd)) + pte_index(address))
+	((pte_t *) pmd_page_vaddr(*(pmd)) + pte_index(address))
 #define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
 #define pte_offset_map_nested(pmd, address) pte_offset_kernel(pmd, address)
 #define pte_unmap(pte) do { } while (0)
--- 2.6.18-rc4/./include/asm-powerpc/pgtable-4k.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-powerpc/pgtable-4k.h	2006-08-07 19:28:26.000000000 -0500
@@ -88,10 +88,11 @@
 #define pgd_bad(pgd)		(pgd_val(pgd) == 0)
 #define pgd_present(pgd)	(pgd_val(pgd) != 0)
 #define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0)
-#define pgd_page(pgd)		(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define pgd_page(pgd)		virt_to_page(pgd_page_vaddr(pgd))
 
 #define pud_offset(pgdp, addr)	\
-  (((pud_t *) pgd_page(*(pgdp))) + \
+  (((pud_t *) pgd_page_vaddr(*(pgdp))) + \
     (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 
 #define pud_ERROR(e) \
--- 2.6.18-rc4/./include/asm-powerpc/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-powerpc/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -196,8 +196,8 @@ static inline pte_t pfn_pte(unsigned lon
 				 || (pmd_val(pmd) & PMD_BAD_BITS))
 #define	pmd_present(pmd)	(pmd_val(pmd) != 0)
 #define	pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0)
-#define pmd_page_kernel(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
-#define pmd_page(pmd)		virt_to_page(pmd_page_kernel(pmd))
+#define pmd_page_vaddr(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
+#define pmd_page(pmd)		virt_to_page(pmd_page_vaddr(pmd))
 
 #define pud_set(pudp, pudval)	(pud_val(*(pudp)) = (pudval))
 #define pud_none(pud)		(!pud_val(pud))
@@ -205,7 +205,8 @@ static inline pte_t pfn_pte(unsigned lon
 				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
 #define pud_clear(pudp)		(pud_val(*(pudp)) = 0)
-#define pud_page(pud)		(pud_val(pud) & ~PUD_MASKED_BITS)
+#define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+#define pud_page(pud)		virt_to_page(pud_page_vaddr(pud))
 
 #define pgd_set(pgdp, pudp)	({pgd_val(*(pgdp)) = (unsigned long)(pudp);})
 
@@ -219,10 +220,10 @@ static inline pte_t pfn_pte(unsigned lon
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
 #define pmd_offset(pudp,addr) \
-  (((pmd_t *) pud_page(*(pudp))) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+  (((pmd_t *) pud_page_vaddr(*(pudp))) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
 
 #define pte_offset_kernel(dir,addr) \
-  (((pte_t *) pmd_page_kernel(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
+  (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
--- 2.6.18-rc4/./include/asm-ppc/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-ppc/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -526,7 +526,7 @@ static inline int pgd_bad(pgd_t pgd)		{ 
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
 #define pgd_clear(xp)				do { } while (0)
 
-#define pgd_page(pgd) \
+#define pgd_page_vaddr(pgd) \
 	((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
 
 /*
@@ -720,12 +720,12 @@ extern pgprot_t phys_mem_access_prot(str
  * of the pte page.  -- paulus
  */
 #ifndef CONFIG_BOOKE
-#define pmd_page_kernel(pmd)	\
+#define pmd_page_vaddr(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
 	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
 #else
-#define pmd_page_kernel(pmd)	\
+#define pmd_page_vaddr(pmd)	\
 	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
 	(mem_map + (__pa(pmd_val(pmd)) >> PAGE_SHIFT))
@@ -748,7 +748,7 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define pte_index(address)		\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, addr)	\
-	((pte_t *) pmd_page_kernel(*(dir)) + pte_index(addr))
+	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(addr))
 #define pte_offset_map(dir, addr)		\
 	((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE0) + pte_index(addr))
 #define pte_offset_map_nested(dir, addr)	\
--- 2.6.18-rc4/./include/asm-s390/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-s390/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -672,11 +672,13 @@ static inline pte_t mk_pte_phys(unsigned
 #define pte_pfn(x) (pte_val(x) >> PAGE_SHIFT)
 #define pte_page(x) pfn_to_page(pte_pfn(x))
 
-#define pmd_page_kernel(pmd) (pmd_val(pmd) & PAGE_MASK)
+#define pmd_page_vaddr(pmd) (pmd_val(pmd) & PAGE_MASK)
 
 #define pmd_page(pmd) (mem_map+(pmd_val(pmd) >> PAGE_SHIFT))
 
-#define pgd_page_kernel(pgd) (pgd_val(pgd) & PAGE_MASK)
+#define pgd_page_vaddr(pgd) (pgd_val(pgd) & PAGE_MASK)
+
+#define pgd_page(pgd) (mem_map+(pgd_val(pgd) >> PAGE_SHIFT))
 
 /* to find an entry in a page-table-directory */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
@@ -698,14 +700,14 @@ static inline pmd_t * pmd_offset(pgd_t *
 /* Find an entry in the second-level page table.. */
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 #define pmd_offset(dir,addr) \
-	((pmd_t *) pgd_page_kernel(*(dir)) + pmd_index(addr))
+	((pmd_t *) pgd_page_vaddr(*(dir)) + pmd_index(addr))
 
 #endif /* __s390x__ */
 
 /* Find an entry in the third-level page table.. */
 #define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 #define pte_offset_kernel(pmd, address) \
-	((pte_t *) pmd_page_kernel(*(pmd)) + pte_index(address))
+	((pte_t *) pmd_page_vaddr(*(pmd)) + pte_index(address))
 #define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
 #define pte_offset_map_nested(pmd, address) pte_offset_kernel(pmd, address)
 #define pte_unmap(pte) do { } while (0)
--- 2.6.18-rc4/./include/asm-sh/pgtable-2level.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-sh/pgtable-2level.h	2006-08-07 19:28:26.000000000 -0500
@@ -50,9 +50,12 @@ static inline void pgd_clear (pgd_t * pg
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
 #define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)
 
-#define pgd_page(pgd) \
+#define pgd_page_vaddr(pgd) \
 ((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
 
+#define pgd_page(pgd) \
+	(phys_to_page(pgd_val(pgd)))
+
 static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
 	return (pmd_t *) dir;
--- 2.6.18-rc4/./include/asm-sh/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-sh/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -225,7 +225,7 @@ static inline pgprot_t pgprot_noncached(
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { set_pte(&pte, __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot))); return pte; }
 
-#define pmd_page_kernel(pmd) \
+#define pmd_page_vaddr(pmd) \
 ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 #define pmd_page(pmd) \
@@ -242,7 +242,7 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_index(address) \
 		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) \
-	((pte_t *) pmd_page_kernel(*(dir)) + pte_index(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(address))
 #define pte_offset_map(dir, address) pte_offset_kernel(dir, address)
 #define pte_offset_map_nested(dir, address) pte_offset_kernel(dir, address)
 #define pte_unmap(pte)		do { } while (0)
--- 2.6.18-rc4/./include/asm-sh64/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-sh64/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -190,7 +190,9 @@ static inline int pgd_bad(pgd_t pgd)		{ 
 #endif
 
 
-#define pgd_page(pgd_entry)	((unsigned long) (pgd_val(pgd_entry) & PAGE_MASK))
+#define pgd_page_vaddr(pgd_entry)	((unsigned long) (pgd_val(pgd_entry) & PAGE_MASK))
+#define pgd_page(pgd)	(virt_to_page(pgd_val(pgd)))
+
 
 /*
  * PMD defines. Middle level.
@@ -219,7 +221,7 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define pmd_none(pmd_entry)	(pmd_val((pmd_entry)) == _PMD_EMPTY)
 #define pmd_bad(pmd_entry)	((pmd_val(pmd_entry) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
-#define pmd_page_kernel(pmd_entry) \
+#define pmd_page_vaddr(pmd_entry) \
 	((unsigned long) __va(pmd_val(pmd_entry) & PAGE_MASK))
 
 #define pmd_page(pmd) \
--- 2.6.18-rc4/./include/asm-sparc/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-sparc/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -143,10 +143,10 @@ extern unsigned long empty_zero_page;
 /*
  */
 BTFIXUPDEF_CALL_CONST(struct page *, pmd_page, pmd_t)
-BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page, pgd_t)
+BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page_vaddr, pgd_t)
 
 #define pmd_page(pmd) BTFIXUP_CALL(pmd_page)(pmd)
-#define pgd_page(pgd) BTFIXUP_CALL(pgd_page)(pgd)
+#define pgd_page_vaddr(pgd) BTFIXUP_CALL(pgd_page_vaddr)(pgd)
 
 BTFIXUPDEF_SETHI(none_mask)
 BTFIXUPDEF_CALL_CONST(int, pte_present, pte_t)
--- 2.6.18-rc4/./include/asm-sparc64/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-sparc64/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -630,8 +630,9 @@ static inline unsigned long pte_present(
 #define __pmd_page(pmd)		\
 	((unsigned long) __va((((unsigned long)pmd_val(pmd))<<11UL)))
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
-#define pud_page(pud)		\
+#define pud_page_vaddr(pud)		\
 	((unsigned long) __va((((unsigned long)pud_val(pud))<<11UL)))
+#define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
 #define pmd_none(pmd)			(!pmd_val(pmd))
 #define pmd_bad(pmd)			(0)
 #define pmd_present(pmd)		(pmd_val(pmd) != 0U)
@@ -653,7 +654,7 @@ static inline unsigned long pte_present(
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(pudp, address)	\
-	((pmd_t *) pud_page(*(pudp)) + \
+	((pmd_t *) pud_page_vaddr(*(pudp)) + \
 	 (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1)))
 
 /* Find an entry in the third-level page table.. */
--- 2.6.18-rc4/./include/asm-um/pgtable-2level.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-um/pgtable-2level.h	2006-08-07 19:28:26.000000000 -0500
@@ -41,7 +41,7 @@ static inline void pgd_mkuptodate(pgd_t 
 #define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot) __pmd(pfn_to_phys(pfn) | pgprot_val(prot))
 
-#define pmd_page_kernel(pmd) \
+#define pmd_page_vaddr(pmd) \
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
--- 2.6.18-rc4/./include/asm-um/pgtable-3level.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-um/pgtable-3level.h	2006-08-07 19:28:26.000000000 -0500
@@ -74,11 +74,12 @@ extern inline void pud_clear (pud_t *pud
         set_pud(pud, __pud(0));
 }
 
-#define pud_page(pud) \
+#define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
+#define pud_page_vaddr(pud) \
 	((struct page *) __va(pud_val(pud) & PAGE_MASK))
 
 /* Find an entry in the second-level page table.. */
-#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
+#define pmd_offset(pud, address) ((pmd_t *) pud_page_vaddr(*(pud)) + \
 			pmd_index(address))
 
 static inline unsigned long pte_pfn(pte_t pte)
--- 2.6.18-rc4/./include/asm-um/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-um/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -349,7 +349,7 @@ static inline pte_t pte_modify(pte_t pte
 	return pte; 
 }
 
-#define pmd_page_kernel(pmd) ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+#define pmd_page_vaddr(pmd) ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
  * the pgd page can be thought of an array like this: pgd_t[PTRS_PER_PGD]
@@ -389,7 +389,7 @@ static inline pte_t pte_modify(pte_t pte
  */
 #define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) \
-	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) +  pte_index(address))
 #define pte_offset_map(dir, address) \
 	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
 #define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
--- 2.6.18-rc4/./include/asm-x86_64/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-x86_64/pgtable.h	2006-08-07 19:28:26.000000000 -0500
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
+#define pgd_page_vaddr(pgd) ((unsigned long) __va((unsigned long)pgd_val(pgd) & PTE_MASK))
+#define pgd_page(pgd)		(pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT))
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pgd_offset(mm, addr) ((mm)->pgd + pgd_index(addr))
 #define pgd_offset_k(address) (init_level4_pgt + pgd_index(address))
@@ -335,16 +333,18 @@ static inline int pmd_large(pmd_t pte) {
 
 /* PUD - Level3 access */
 /* to find an entry in a page-table-directory. */
+#define pud_page_vaddr(pud) ((unsigned long) __va(pud_val(pud) & PHYSICAL_PAGE_MASK))
+#define pud_page(pud)		(pfn_to_page(pud_val(pud) >> PAGE_SHIFT))
 #define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-#define pud_offset(pgd, address) ((pud_t *) pgd_page(*(pgd)) + pud_index(address))
+#define pud_offset(pgd, address) ((pud_t *) pgd_page_vaddr(*(pgd)) + pud_index(address))
 #define pud_present(pud) (pud_val(pud) & _PAGE_PRESENT)
 
 /* PMD  - Level 2 access */
-#define pmd_page_kernel(pmd) ((unsigned long) __va(pmd_val(pmd) & PTE_MASK))
+#define pmd_page_vaddr(pmd) ((unsigned long) __va(pmd_val(pmd) & PTE_MASK))
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-#define pmd_offset(dir, address) ((pmd_t *) pud_page(*(dir)) + \
+#define pmd_offset(dir, address) ((pmd_t *) pud_page_vaddr(*(dir)) + \
 			pmd_index(address))
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
@@ -382,7 +382,7 @@ static inline pte_t pte_modify(pte_t pte
 
 #define pte_index(address) \
 		(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
-#define pte_offset_kernel(dir, address) ((pte_t *) pmd_page_kernel(*(dir)) + \
+#define pte_offset_kernel(dir, address) ((pte_t *) pmd_page_vaddr(*(dir)) + \
 			pte_index(address))
 
 /* x86-64 always has all page tables mapped. */
--- 2.6.18-rc4/./include/asm-xtensa/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-macro/./include/asm-xtensa/pgtable.h	2006-08-07 19:28:26.000000000 -0500
@@ -218,7 +218,7 @@ extern pgd_t swapper_pg_dir[PAGE_SIZE/si
 /*
  * The pmd contains the kernel virtual address of the pte page.
  */
-#define pmd_page_kernel(pmd) ((unsigned long)(pmd_val(pmd) & PAGE_MASK))
+#define pmd_page_vaddr(pmd) ((unsigned long)(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd) virt_to_page(pmd_val(pmd))
 
 /*
@@ -349,7 +349,7 @@ ptep_set_wrprotect(struct mm_struct *mm,
 /* Find an entry in the third-level page table.. */
 #define pte_index(address)	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir,addr) 					\
-	((pte_t*) pmd_page_kernel(*(dir)) + pte_index(addr))
+	((pte_t*) pmd_page_vaddr(*(dir)) + pte_index(addr))
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir),(addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir),(addr))
 
