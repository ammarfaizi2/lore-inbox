Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbUJYHo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUJYHo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbUJYHoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:44:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:15776 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261686AbUJYHZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:41 -0400
Date: Mon, 25 Oct 2004 09:23:49 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 9/17] 4level support for parisc
Message-ID: <417CAA05.mail3Z011G05S@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level support for parisc

parisc		works on 32,64bit (thanks to Kyle M. for testing) 

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/parisc/kernel/pci-dma.c linux-2.6.10rc1-4level/arch/parisc/kernel/pci-dma.c
--- linux-2.6.10rc1/arch/parisc/kernel/pci-dma.c	2004-08-15 19:45:09.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/parisc/kernel/pci-dma.c	2004-10-25 04:48:09.000000000 +0200
@@ -142,7 +142,7 @@ static inline int map_uncached_pages(uns
 	pgd_t * dir;
 	unsigned long end = vaddr + size;
 
-	dir = pgd_offset_k(vaddr);
+	dir = pml4_pgd_offset_k(pml4_offset_k(vaddr), vaddr);
 	do {
 		pmd_t *pmd;
 		
@@ -221,7 +221,7 @@ static void unmap_uncached_pages(unsigne
 	pgd_t * dir;
 	unsigned long end = vaddr + size;
 
-	dir = pgd_offset_k(vaddr);
+	dir = pml4_pgd_offset_k(pml4_offset_k(vaddr), vaddr);
 	do {
 		unmap_uncached_pmd(dir, vaddr, end - vaddr);
 		vaddr = vaddr + PGDIR_SIZE;
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/parisc/mm/init.c linux-2.6.10rc1-4level/arch/parisc/mm/init.c
--- linux-2.6.10rc1/arch/parisc/mm/init.c	2004-10-19 01:55:04.000000000 +0200
+++ linux-2.6.10rc1-4level/arch/parisc/mm/init.c	2004-10-25 04:48:09.000000000 +0200
@@ -574,7 +574,7 @@ static void __init map_pages(unsigned lo
 
 	end_paddr = start_paddr + size;
 
-	pg_dir = pgd_offset_k(start_vaddr);
+	pg_dir = pml4_pgd_offset_k(pml4_offset_k(start_vaddr), start_vaddr);
 
 #if PTRS_PER_PMD == 1
 	start_pmd = 0;
@@ -737,7 +737,8 @@ map_hpux_gateway_page(struct task_struct
 	 * so it needs to be aliased into each process.
 	 */
 
-	pg_dir = pgd_offset(mm,hpux_gw_page_addr);
+	pg_dir = pml4_pgd_offset(pml4_offset(mm,hpux_gw_page_addr),
+				 hpux_gw_page_addr);
 
 #if PTRS_PER_PMD == 1
 	start_pmd = 0;
@@ -1018,3 +1019,38 @@ void free_initrd_mem(unsigned long start
 #endif
 }
 #endif
+
+
+/* Allocate the top level pgd (page directory)
+ *
+ * Here (for 64 bit kernels) we implement a Hybrid L2/L3 scheme: we
+ * allocate the first pmd adjacent to the pgd.  This means that we can
+ * subtract a constant offset to get to it.  The pmd and pgd sizes are
+ * arranged so that a single pmd covers 4GB (giving a full LP64
+ * process access to 8TB) so our lookups are effectively L2 for the
+ * first 4GB of the kernel (i.e. for all ILP32 processes and all the
+ * kernel for machines with under 4GB of memory) */
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long addr)
+{
+	pgd_t *pgd = (pgd_t *)__get_free_pages(GFP_KERNEL,
+					       PGD_ALLOC_ORDER);
+	pgd_t *actual_pgd = pgd;
+
+	if (likely(pgd != NULL)) {
+		memset(pgd, 0, PAGE_SIZE<<PGD_ALLOC_ORDER);
+#ifdef __LP64__
+		actual_pgd += PTRS_PER_PGD;
+		/* Populate first pmd with allocated memory.  We mark it
+		 * with PxD_FLAG_ATTACHED as a signal to the system that this
+		 * pmd entry may not be cleared. */
+		__pgd_val_set(*actual_pgd, (PxD_FLAG_PRESENT | 
+				        PxD_FLAG_VALID | 
+					PxD_FLAG_ATTACHED) 
+			+ (__u32)(__pa((unsigned long)pgd) >> PxD_VALUE_SHIFT));
+		/* The first pmd entry also is marked with _PAGE_GATEWAY as
+		 * a signal that this pmd may not be freed */
+		__pgd_val_set(*pgd, PxD_FLAG_ATTACHED);
+#endif
+	}
+	return actual_pgd;
+}
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/parisc/mm/ioremap.c linux-2.6.10rc1-4level/arch/parisc/mm/ioremap.c
--- linux-2.6.10rc1/arch/parisc/mm/ioremap.c	2004-03-21 21:12:09.000000000 +0100
+++ linux-2.6.10rc1-4level/arch/parisc/mm/ioremap.c	2004-10-25 04:48:09.000000000 +0200
@@ -70,7 +70,7 @@ static int remap_area_pages(unsigned lon
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	dir = pml4_pgd_offset_k(pml4_offset_k(address), address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
diff -urpN -X ../KDIFX linux-2.6.10rc1/arch/parisc/mm/kmap.c linux-2.6.10rc1-4level/arch/parisc/mm/kmap.c
--- linux-2.6.10rc1/arch/parisc/mm/kmap.c	2004-03-21 21:12:09.000000000 +0100
+++ linux-2.6.10rc1-4level/arch/parisc/mm/kmap.c	2004-10-25 04:48:09.000000000 +0200
@@ -135,7 +135,7 @@ static void iterate_pages(unsigned long 
 	pgd_t *dir;
 	unsigned long end = address + size;
 
-	dir = pgd_offset_k(address);
+	dir = pml4_pgd_offset_k(pml4_offset_k(address), address);
 	flush_cache_all();
 	do {
 		iterate_pmd(dir, address, end - address, op, arg);
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-parisc/cacheflush.h linux-2.6.10rc1-4level/include/asm-parisc/cacheflush.h
--- linux-2.6.10rc1/include/asm-parisc/cacheflush.h	2004-10-19 01:55:33.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-parisc/cacheflush.h	2004-10-25 04:48:10.000000000 +0200
@@ -113,7 +113,7 @@ static inline void flush_cache_range(str
 static inline pte_t *__translation_exists(struct mm_struct *mm,
 					  unsigned long addr)
 {
-	pgd_t *pgd = pgd_offset(mm, addr);
+	pgd_t *pgd = pml4_pgd_offset(pml4_offset(mm, addr), addr);
 	pmd_t *pmd;
 	pte_t *pte;
 
@@ -155,7 +155,7 @@ flush_user_cache_page_non_current(struct
 	preempt_disable();
 
 	/* make us current */
-	mtctl(__pa(vma->vm_mm->pgd), 25);
+	mtctl(__pa(vma->vm_mm->pml4), 25);
 	mtsp(vma->vm_mm->context, 3);
 
 	flush_user_dcache_page(vmaddr);
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-parisc/mmu_context.h linux-2.6.10rc1-4level/include/asm-parisc/mmu_context.h
--- linux-2.6.10rc1/include/asm-parisc/mmu_context.h	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.10rc1-4level/include/asm-parisc/mmu_context.h	2004-10-25 04:48:10.000000000 +0200
@@ -46,7 +46,7 @@ static inline void switch_mm(struct mm_s
 {
 
 	if (prev != next) {
-		mtctl(__pa(next->pgd), 25);
+		mtctl(__pa(next->pml4), 25);
 		load_context(next->context);
 	}
 }
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-parisc/page.h linux-2.6.10rc1-4level/include/asm-parisc/page.h
--- linux-2.6.10rc1/include/asm-parisc/page.h	2004-08-15 19:45:48.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-parisc/page.h	2004-10-25 04:48:10.000000000 +0200
@@ -157,6 +157,8 @@ extern int npmem_ranges;
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _PARISC_PAGE_H */
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-parisc/pgalloc.h linux-2.6.10rc1-4level/include/asm-parisc/pgalloc.h
--- linux-2.6.10rc1/include/asm-parisc/pgalloc.h	2004-08-15 19:45:48.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-parisc/pgalloc.h	2004-10-25 04:48:10.000000000 +0200
@@ -10,40 +10,6 @@
 #include <asm/pgtable.h>
 #include <asm/cache.h>
 
-/* Allocate the top level pgd (page directory)
- *
- * Here (for 64 bit kernels) we implement a Hybrid L2/L3 scheme: we
- * allocate the first pmd adjacent to the pgd.  This means that we can
- * subtract a constant offset to get to it.  The pmd and pgd sizes are
- * arranged so that a single pmd covers 4GB (giving a full LP64
- * process access to 8TB) so our lookups are effectively L2 for the
- * first 4GB of the kernel (i.e. for all ILP32 processes and all the
- * kernel for machines with under 4GB of memory) */
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = (pgd_t *)__get_free_pages(GFP_KERNEL,
-					       PGD_ALLOC_ORDER);
-	pgd_t *actual_pgd = pgd;
-
-	if (likely(pgd != NULL)) {
-		memset(pgd, 0, PAGE_SIZE<<PGD_ALLOC_ORDER);
-#ifdef __LP64__
-		actual_pgd += PTRS_PER_PGD;
-		/* Populate first pmd with allocated memory.  We mark it
-		 * with PxD_FLAG_ATTACHED as a signal to the system that this
-		 * pmd entry may not be cleared. */
-		__pgd_val_set(*actual_pgd, (PxD_FLAG_PRESENT | 
-				        PxD_FLAG_VALID | 
-					PxD_FLAG_ATTACHED) 
-			+ (__u32)(__pa((unsigned long)pgd) >> PxD_VALUE_SHIFT));
-		/* The first pmd entry also is marked with _PAGE_GATEWAY as
-		 * a signal that this pmd may not be freed */
-		__pgd_val_set(*pgd, PxD_FLAG_ATTACHED);
-#endif
-	}
-	return actual_pgd;
-}
-
 static inline void pgd_free(pgd_t *pgd)
 {
 #ifdef __LP64__
@@ -145,4 +111,6 @@ static inline void pte_free_kernel(pte_t
 extern int do_check_pgt_cache(int, int);
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-parisc/pgtable.h linux-2.6.10rc1-4level/include/asm-parisc/pgtable.h
--- linux-2.6.10rc1/include/asm-parisc/pgtable.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/asm-parisc/pgtable.h	2004-10-25 04:48:10.000000000 +0200
@@ -102,7 +102,7 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD    (1UL << BITS_PER_PGD)
-#define USER_PTRS_PER_PGD       PTRS_PER_PGD
+#define USER_PGDS_IN_LAST_PML4      PTRS_PER_PGD
 
 #define MAX_ADDRBITS	(PGDIR_SHIFT + BITS_PER_PGD)
 #define MAX_ADDRESS	(1UL << MAX_ADDRBITS)
@@ -380,13 +380,7 @@ extern inline pte_t pte_modify(pte_t pte
 #define pmd_page(pmd)	virt_to_page((void *)__pmd_page(pmd))
 
 #define pgd_index(address) ((address) >> PGDIR_SHIFT)
-
-/* to find an entry in a page-table-directory */
-#define pgd_offset(mm, address) \
-((mm)->pgd + ((address) >> PGDIR_SHIFT))
-
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+#define pgd_index_k(address) pgd_index(address)
 
 /* Find an entry in the second-level page table.. */
 
@@ -503,6 +497,8 @@ static inline void ptep_mkdirty(pte_t *p
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* !__ASSEMBLY__ */
 
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
