Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWILL0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWILL0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWILL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:26:11 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:20976 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965161AbWILL0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:26:09 -0400
Date: Tue, 12 Sep 2006 13:26:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [S390] Cleanup in page table related code.
Message-ID: <20060912112605.GB2826@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] Cleanup in page table related code.

Changed and simplified some page table related #defines and code.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/init.c        |   36 +++++--------
 include/asm-s390/pgalloc.h |   65 +++++++++++------------
 include/asm-s390/pgtable.h |  124 +++++++++++++++++++++------------------------
 3 files changed, 105 insertions(+), 120 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2006-09-12 10:56:59.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/init.c	2006-09-12 10:57:56.000000000 +0200
@@ -108,16 +108,23 @@ void __init paging_init(void)
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERNSEG_TABLE;
         static const int ssm_mask = 0x04000000L;
 	unsigned long ro_start_pfn, ro_end_pfn;
+	unsigned long zones_size[MAX_NR_ZONES];
 
 	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
 	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
+	memset(zones_size, 0, sizeof(zones_size));
+	zones_size[ZONE_DMA] = max_low_pfn;
+	free_area_init_node(0, &contig_page_data, zones_size,
+			    __pa(PAGE_OFFSET) >> PAGE_SHIFT,
+			    zholes_size);
+
 	/* unmap whole virtual address space */
 	
         pg_dir = swapper_pg_dir;
 
-	for (i=0;i<KERNEL_PGD_PTRS;i++) 
-	        pmd_clear((pmd_t*)pg_dir++);
+	for (i = 0; i < PTRS_PER_PGD; i++)
+		pmd_clear((pmd_t *) pg_dir++);
 		
 	/*
 	 * map whole physical memory to virtual memory (identity mapping) 
@@ -131,10 +138,7 @@ void __init paging_init(void)
                  */
 		pg_table = (pte_t *) alloc_bootmem_pages(PAGE_SIZE);
 
-                pg_dir->pgd0 =  (_PAGE_TABLE | __pa(pg_table));
-                pg_dir->pgd1 =  (_PAGE_TABLE | (__pa(pg_table)+1024));
-                pg_dir->pgd2 =  (_PAGE_TABLE | (__pa(pg_table)+2048));
-                pg_dir->pgd3 =  (_PAGE_TABLE | (__pa(pg_table)+3072));
+		pmd_populate_kernel(&init_mm, (pmd_t *) pg_dir, pg_table);
                 pg_dir++;
 
                 for (tmp = 0 ; tmp < PTRS_PER_PTE ; tmp++,pg_table++) {
@@ -143,8 +147,8 @@ void __init paging_init(void)
 			else
 				pte = pfn_pte(pfn, PAGE_KERNEL);
                         if (pfn >= max_low_pfn)
-                                pte_clear(&init_mm, 0, &pte);
-                        set_pte(pg_table, pte);
+				pte_val(pte) = _PAGE_TYPE_EMPTY;
+			set_pte(pg_table, pte);
                         pfn++;
                 }
         }
@@ -159,16 +163,6 @@ void __init paging_init(void)
 			     : : "m" (pgdir_k), "m" (ssm_mask));
 
         local_flush_tlb();
-
-	{
-		unsigned long zones_size[MAX_NR_ZONES];
-
-		memset(zones_size, 0, sizeof(zones_size));
-		zones_size[ZONE_DMA] = max_low_pfn;
-		free_area_init_node(0, &contig_page_data, zones_size,
-				    __pa(PAGE_OFFSET) >> PAGE_SHIFT,
-				    zholes_size);
-	}
         return;
 }
 
@@ -236,10 +230,8 @@ void __init paging_init(void)
 					pte = pfn_pte(pfn, __pgprot(_PAGE_RO));
 				else
 					pte = pfn_pte(pfn, PAGE_KERNEL);
-                                if (pfn >= max_low_pfn) {
-                                        pte_clear(&init_mm, 0, &pte); 
-                                        continue;
-                                }
+				if (pfn >= max_low_pfn)
+					pte_val(pte) = _PAGE_TYPE_EMPTY;
                                 set_pte(pt_dir, pte);
                                 pfn++;
                         }
diff -urpN linux-2.6/include/asm-s390/pgalloc.h linux-2.6-patched/include/asm-s390/pgalloc.h
--- linux-2.6/include/asm-s390/pgalloc.h	2006-09-12 10:57:10.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/pgalloc.h	2006-09-12 10:57:56.000000000 +0200
@@ -22,6 +22,16 @@
 extern void diag10(unsigned long addr);
 
 /*
+ * Page allocation orders.
+ */
+#ifndef __s390x__
+# define PGD_ALLOC_ORDER	1
+#else /* __s390x__ */
+# define PMD_ALLOC_ORDER	2
+# define PGD_ALLOC_ORDER	2
+#endif /* __s390x__ */
+
+/*
  * Allocate and free page tables. The xxx_kernel() versions are
  * used to allocate a kernel page table - this turns on ASN bits
  * if any.
@@ -29,30 +39,23 @@ extern void diag10(unsigned long addr);
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *pgd;
+	pgd_t *pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ALLOC_ORDER);
 	int i;
 
+	if (!pgd)
+		return NULL;
+	for (i = 0; i < PTRS_PER_PGD; i++)
 #ifndef __s390x__
-	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,1);
-        if (pgd != NULL)
-		for (i = 0; i < USER_PTRS_PER_PGD; i++)
-			pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
-#else /* __s390x__ */
-	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,2);
-        if (pgd != NULL)
-		for (i = 0; i < PTRS_PER_PGD; i++)
-			pgd_clear(pgd + i);
-#endif /* __s390x__ */
+		pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
+#else
+		pgd_clear(pgd + i);
+#endif
 	return pgd;
 }
 
 static inline void pgd_free(pgd_t *pgd)
 {
-#ifndef __s390x__
-        free_pages((unsigned long) pgd, 1);
-#else /* __s390x__ */
-        free_pages((unsigned long) pgd, 2);
-#endif /* __s390x__ */
+	free_pages((unsigned long) pgd, PGD_ALLOC_ORDER);
 }
 
 #ifndef __s390x__
@@ -68,20 +71,19 @@ static inline void pgd_free(pgd_t *pgd)
 #else /* __s390x__ */
 static inline pmd_t * pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 {
-	pmd_t *pmd;
-        int i;
+	pmd_t *pmd = (pmd_t *) __get_free_pages(GFP_KERNEL, PMD_ALLOC_ORDER);
+	int i;
 
-	pmd = (pmd_t *) __get_free_pages(GFP_KERNEL, 2);
-	if (pmd != NULL) {
-		for (i=0; i < PTRS_PER_PMD; i++)
-			pmd_clear(pmd+i);
-	}
+	if (!pmd)
+		return NULL;
+	for (i=0; i < PTRS_PER_PMD; i++)
+		pmd_clear(pmd + i);
 	return pmd;
 }
 
 static inline void pmd_free (pmd_t *pmd)
 {
-	free_pages((unsigned long) pmd, 2);
+	free_pages((unsigned long) pmd, PMD_ALLOC_ORDER);
 }
 
 #define __pmd_free_tlb(tlb,pmd)			\
@@ -123,15 +125,14 @@ pmd_populate(struct mm_struct *mm, pmd_t
 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long vmaddr)
 {
-	pte_t *pte;
-        int i;
+	pte_t *pte = (pte_t *) __get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	int i;
 
-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte != NULL) {
-		for (i=0; i < PTRS_PER_PTE; i++) {
-			pte_clear(mm, vmaddr, pte+i);
-			vmaddr += PAGE_SIZE;
-		}
+	if (!pte)
+		return NULL;
+	for (i=0; i < PTRS_PER_PTE; i++) {
+		pte_clear(mm, vmaddr, pte + i);
+		vmaddr += PAGE_SIZE;
 	}
 	return pte;
 }
diff -urpN linux-2.6/include/asm-s390/pgtable.h linux-2.6-patched/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2006-09-12 10:57:10.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/pgtable.h	2006-09-12 10:57:56.000000000 +0200
@@ -89,19 +89,6 @@ extern char empty_zero_page[PAGE_SIZE];
 # define PTRS_PER_PGD    2048
 #endif /* __s390x__ */
 
-/*
- * pgd entries used up by user/kernel:
- */
-#ifndef __s390x__
-# define USER_PTRS_PER_PGD  512
-# define USER_PGD_PTRS      512
-# define KERNEL_PGD_PTRS    512
-#else /* __s390x__ */
-# define USER_PTRS_PER_PGD  2048
-# define USER_PGD_PTRS      2048
-# define KERNEL_PGD_PTRS    2048
-#endif /* __s390x__ */
-
 #define FIRST_USER_ADDRESS  0
 
 #define pte_ERROR(e) \
@@ -216,12 +203,14 @@ extern char empty_zero_page[PAGE_SIZE];
 #define _PAGE_RO        0x200          /* HW read-only                     */
 #define _PAGE_INVALID   0x400          /* HW invalid                       */
 
-/* Mask and four different kinds of invalid pages. */
-#define _PAGE_INVALID_MASK	0x601
-#define _PAGE_INVALID_EMPTY	0x400
-#define _PAGE_INVALID_NONE	0x401
-#define _PAGE_INVALID_SWAP	0x600
-#define _PAGE_INVALID_FILE	0x601
+/* Mask and six different types of pages. */
+#define _PAGE_TYPE_MASK		0x601
+#define _PAGE_TYPE_EMPTY	0x400
+#define _PAGE_TYPE_NONE		0x401
+#define _PAGE_TYPE_SWAP		0x600
+#define _PAGE_TYPE_FILE		0x601
+#define _PAGE_TYPE_RO		0x200
+#define _PAGE_TYPE_RW		0x000
 
 #ifndef __s390x__
 
@@ -280,15 +269,14 @@ extern char empty_zero_page[PAGE_SIZE];
 #endif /* __s390x__ */
 
 /*
- * No mapping available
+ * Page protection definitions.
  */
-#define PAGE_NONE_SHARED  __pgprot(_PAGE_INVALID_NONE)
-#define PAGE_NONE_PRIVATE __pgprot(_PAGE_INVALID_NONE)
-#define PAGE_RO_SHARED	  __pgprot(_PAGE_RO)
-#define PAGE_RO_PRIVATE	  __pgprot(_PAGE_RO)
-#define PAGE_COPY	  __pgprot(_PAGE_RO)
-#define PAGE_SHARED	  __pgprot(0)
-#define PAGE_KERNEL	  __pgprot(0)
+#define PAGE_NONE	__pgprot(_PAGE_TYPE_NONE)
+#define PAGE_RO		__pgprot(_PAGE_TYPE_RO)
+#define PAGE_RW		__pgprot(_PAGE_TYPE_RW)
+
+#define PAGE_KERNEL	PAGE_RW
+#define PAGE_COPY	PAGE_RO
 
 /*
  * The S390 can't do page protection for execute, and considers that the
@@ -296,23 +284,23 @@ extern char empty_zero_page[PAGE_SIZE];
  * the closest we can get..
  */
          /*xwr*/
-#define __P000  PAGE_NONE_PRIVATE
-#define __P001  PAGE_RO_PRIVATE
-#define __P010  PAGE_COPY
-#define __P011  PAGE_COPY
-#define __P100  PAGE_RO_PRIVATE
-#define __P101  PAGE_RO_PRIVATE
-#define __P110  PAGE_COPY
-#define __P111  PAGE_COPY
-
-#define __S000  PAGE_NONE_SHARED
-#define __S001  PAGE_RO_SHARED
-#define __S010  PAGE_SHARED
-#define __S011  PAGE_SHARED
-#define __S100  PAGE_RO_SHARED
-#define __S101  PAGE_RO_SHARED
-#define __S110  PAGE_SHARED
-#define __S111  PAGE_SHARED
+#define __P000	PAGE_NONE
+#define __P001	PAGE_RO
+#define __P010	PAGE_RO
+#define __P011	PAGE_RO
+#define __P100	PAGE_RO
+#define __P101	PAGE_RO
+#define __P110	PAGE_RO
+#define __P111	PAGE_RO
+
+#define __S000	PAGE_NONE
+#define __S001	PAGE_RO
+#define __S010	PAGE_RW
+#define __S011	PAGE_RW
+#define __S100	PAGE_RO
+#define __S101	PAGE_RO
+#define __S110	PAGE_RW
+#define __S111	PAGE_RW
 
 /*
  * Certain architectures need to do special things when PTEs
@@ -377,18 +365,18 @@ static inline int pmd_bad(pmd_t pmd)
 
 static inline int pte_none(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_EMPTY;
+	return (pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_EMPTY;
 }
 
 static inline int pte_present(pte_t pte)
 {
 	return !(pte_val(pte) & _PAGE_INVALID) ||
-		(pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_NONE;
+		(pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_NONE;
 }
 
 static inline int pte_file(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_FILE;
+	return (pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_FILE;
 }
 
 #define pte_same(a,b)	(pte_val(a) == pte_val(b))
@@ -461,7 +449,7 @@ static inline void pmd_clear(pmd_t * pmd
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	pte_val(*ptep) = _PAGE_INVALID_EMPTY;
+	pte_val(*ptep) = _PAGE_TYPE_EMPTY;
 }
 
 /*
@@ -477,7 +465,7 @@ static inline pte_t pte_modify(pte_t pte
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	/* Do not clobber _PAGE_INVALID_NONE pages!  */
+	/* Do not clobber _PAGE_TYPE_NONE pages!  */
 	if (!(pte_val(pte) & _PAGE_INVALID))
 		pte_val(pte) |= _PAGE_RO;
 	return pte;
@@ -556,26 +544,30 @@ static inline pte_t ptep_get_and_clear(s
 	return pte;
 }
 
-static inline pte_t
-ptep_clear_flush(struct vm_area_struct *vma,
-		 unsigned long address, pte_t *ptep)
+static inline void __ptep_ipte(unsigned long address, pte_t *ptep)
 {
-	pte_t pte = *ptep;
+	if (!(pte_val(*ptep) & _PAGE_INVALID)) {
 #ifndef __s390x__
-	if (!(pte_val(pte) & _PAGE_INVALID)) {
 		/* S390 has 1mb segments, we are emulating 4MB segments */
 		pte_t *pto = (pte_t *) (((unsigned long) ptep) & 0x7ffffc00);
-		__asm__ __volatile__ ("ipte %2,%3"
-				      : "=m" (*ptep) : "m" (*ptep),
-				        "a" (pto), "a" (address) );
+#else
+		/* ipte in zarch mode can do the math */
+		pte_t *pto = ptep;
+#endif
+		asm volatile ("ipte %2,%3"
+			      : "=m" (*ptep) : "m" (*ptep),
+				"a" (pto), "a" (address) );
 	}
-#else /* __s390x__ */
-	if (!(pte_val(pte) & _PAGE_INVALID)) 
-		__asm__ __volatile__ ("ipte %2,%3"
-				      : "=m" (*ptep) : "m" (*ptep),
-				        "a" (ptep), "a" (address) );
-#endif /* __s390x__ */
-	pte_val(*ptep) = _PAGE_INVALID_EMPTY;
+	pte_val(*ptep) = _PAGE_TYPE_EMPTY;
+}
+
+static inline pte_t
+ptep_clear_flush(struct vm_area_struct *vma,
+		 unsigned long address, pte_t *ptep)
+{
+	pte_t pte = *ptep;
+
+	__ptep_ipte(address, ptep);
 	return pte;
 }
 
@@ -755,7 +747,7 @@ static inline pte_t mk_swap_pte(unsigned
 {
 	pte_t pte;
 	offset &= __SWP_OFFSET_MASK;
-	pte_val(pte) = _PAGE_INVALID_SWAP | ((type & 0x1f) << 2) |
+	pte_val(pte) = _PAGE_TYPE_SWAP | ((type & 0x1f) << 2) |
 		((offset & 1UL) << 7) | ((offset & ~1UL) << 11);
 	return pte;
 }
@@ -778,7 +770,7 @@ static inline pte_t mk_swap_pte(unsigned
 
 #define pgoff_to_pte(__off) \
 	((pte_t) { ((((__off) & 0x7f) << 1) + (((__off) >> 7) << 12)) \
-		   | _PAGE_INVALID_FILE })
+		   | _PAGE_TYPE_FILE })
 
 #endif /* !__ASSEMBLY__ */
 
