Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVD1Bhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVD1Bhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 21:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVD1Bhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 21:37:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:17375 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261600AbVD1Be6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 21:34:58 -0400
Subject: [PATCH] ppc64: update to use the new 4L headers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 11:33:59 +1000
Message-Id: <1114652039.7112.213.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch converts ppc64 to use the generic pgtable-nopud.h instead of
the "fixup" header.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc64/pgalloc.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pgalloc.h	2005-04-28 10:58:13.000000000 +1000
+++ linux-work/include/asm-ppc64/pgalloc.h	2005-04-28 11:14:57.000000000 +1000
@@ -27,7 +27,7 @@
 	kmem_cache_free(zero_cache, pgd);
 }
 
-#define pgd_populate(MM, PGD, PMD)	pgd_set(PGD, PMD)
+#define pud_populate(MM, PUD, PMD)	pud_set(PUD, PMD)
 
 static inline pmd_t *
 pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
Index: linux-work/include/asm-ppc64/pgtable.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pgtable.h	2005-04-28 10:58:13.000000000 +1000
+++ linux-work/include/asm-ppc64/pgtable.h	2005-04-28 11:14:57.000000000 +1000
@@ -1,8 +1,6 @@
 #ifndef _PPC64_PGTABLE_H
 #define _PPC64_PGTABLE_H
 
-#include <asm-generic/4level-fixup.h>
-
 /*
  * This file contains the functions and defines necessary to modify and use
  * the ppc64 hashed page table.
@@ -17,6 +15,8 @@
 #include <asm/tlbflush.h>
 #endif /* __ASSEMBLY__ */
 
+#include <asm-generic/pgtable-nopud.h>
+
 /* PMD_SHIFT determines what a second-level page table entry can map */
 #define PMD_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
 #define PMD_SIZE	(1UL << PMD_SHIFT)
@@ -228,12 +228,13 @@
 #define pmd_page_kernel(pmd)	\
 	(__bpn_to_ba(pmd_val(pmd) >> PMD_TO_PTEPAGE_SHIFT))
 #define pmd_page(pmd)		virt_to_page(pmd_page_kernel(pmd))
-#define pgd_set(pgdp, pmdp)	(pgd_val(*(pgdp)) = (__ba_to_bpn(pmdp)))
-#define pgd_none(pgd)		(!pgd_val(pgd))
-#define pgd_bad(pgd)		((pgd_val(pgd)) == 0)
-#define pgd_present(pgd)	(pgd_val(pgd) != 0UL)
-#define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0UL)
-#define pgd_page(pgd)		(__bpn_to_ba(pgd_val(pgd))) 
+
+#define pud_set(pudp, pmdp)	(pud_val(*(pudp)) = (__ba_to_bpn(pmdp)))
+#define pud_none(pud)		(!pud_val(pud))
+#define pud_bad(pud)		((pud_val(pud)) == 0UL)
+#define pud_present(pud)	(pud_val(pud) != 0UL)
+#define pud_clear(pudp)		(pud_val(*(pudp)) = 0UL)
+#define pud_page(pud)		(__bpn_to_ba(pud_val(pud))) 
 
 /* 
  * Find an entry in a page-table-directory.  We combine the address region 
@@ -245,12 +246,13 @@
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
 /* Find an entry in the second-level page table.. */
-#define pmd_offset(dir,addr) \
-  ((pmd_t *) pgd_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+#define pmd_offset(pudp,addr) \
+  ((pmd_t *) pud_page(*(pudp)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
 
 /* Find an entry in the third-level page table.. */
 #define pte_offset_kernel(dir,addr) \
-  ((pte_t *) pmd_page_kernel(*(dir)) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
+  ((pte_t *) pmd_page_kernel(*(dir)) \
+ + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
@@ -582,20 +584,23 @@
 static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea)
 {
 	pgd_t *pg;
+	pud_t *pu;
 	pmd_t *pm;
 	pte_t *pt = NULL;
 	pte_t pte;
 
 	pg = pgdir + pgd_index(ea);
 	if (!pgd_none(*pg)) {
-
-		pm = pmd_offset(pg, ea);
-		if (pmd_present(*pm)) { 
-			pt = pte_offset_kernel(pm, ea);
-			pte = *pt;
-			if (!pte_present(pte))
-				pt = NULL;
-		}
+		pu = pud_offset(pg, ea);
+		if (!pud_none(*pu)) {			
+			pm = pmd_offset(pu, ea);
+			if (pmd_present(*pm)) { 
+				pt = pte_offset_kernel(pm, ea);
+				pte = *pt;
+				if (!pte_present(pte))
+					pt = NULL;
+			}
+		}			
 	}
 
 	return pt;
Index: linux-work/arch/ppc64/mm/init.c
===================================================================
--- linux-work.orig/arch/ppc64/mm/init.c	2005-04-28 10:58:10.000000000 +1000
+++ linux-work/arch/ppc64/mm/init.c	2005-04-28 11:14:57.000000000 +1000
@@ -136,14 +136,78 @@
 
 #else
 
+static void unmap_im_area_pte(pmd_t *pmd, unsigned long addr,
+				  unsigned long end)
+{
+	pte_t *pte;
+
+	pte = pte_offset_kernel(pmd, addr);
+	do {
+		pte_t ptent = ptep_get_and_clear(&ioremap_mm, addr, pte);
+		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+}
+
+static inline void unmap_im_area_pmd(pud_t *pud, unsigned long addr,
+				     unsigned long end)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		unmap_im_area_pte(pmd, addr, next);
+	} while (pmd++, addr = next, addr != end);
+}
+
+static inline void unmap_im_area_pud(pgd_t *pgd, unsigned long addr,
+				     unsigned long end)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		unmap_im_area_pmd(pud, addr, next);
+	} while (pud++, addr = next, addr != end);
+}
+
+static void unmap_im_area(unsigned long addr, unsigned long end)
+{
+	struct mm_struct *mm = &ioremap_mm;
+	unsigned long next;
+	pgd_t *pgd;
+
+	spin_lock(&mm->page_table_lock);
+
+	pgd = pgd_offset_i(addr);
+	flush_cache_vunmap(addr, end);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		unmap_im_area_pud(pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+	flush_tlb_kernel_range(start, end);
+
+	spin_unlock(&mm->page_table_lock);
+}
+
 /*
  * map_io_page currently only called by __ioremap
  * map_io_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-static void map_io_page(unsigned long ea, unsigned long pa, int flags)
+static int map_io_page(unsigned long ea, unsigned long pa, int flags)
 {
 	pgd_t *pgdp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 	unsigned long vsid;
@@ -151,9 +215,15 @@
 	if (mem_init_done) {
 		spin_lock(&ioremap_mm.page_table_lock);
 		pgdp = pgd_offset_i(ea);
-		pmdp = pmd_alloc(&ioremap_mm, pgdp, ea);
+		pudp = pud_alloc(&ioremap_mm, pgdp, ea);
+		if (!pudp)
+			return -ENOMEM;
+		pmdp = pmd_alloc(&ioremap_mm, pudp, ea);
+		if (!pmdp)
+			return -ENOMEM;
 		ptep = pte_alloc_kernel(&ioremap_mm, pmdp, ea);
-
+		if (!ptep)
+			return -ENOMEM;
 		pa = abs_to_phys(pa);
 		set_pte_at(&ioremap_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
 							  __pgprot(flags)));
@@ -181,6 +251,7 @@
 			panic("map_io_page: could not insert mapping");
 		}
 	}
+	return 0;
 }
 
 
@@ -194,9 +265,14 @@
 		flags |= pgprot_val(PAGE_KERNEL);
 
 	for (i = 0; i < size; i += PAGE_SIZE)
-		map_io_page(ea+i, pa+i, flags);
+		if (map_io_page(ea+i, pa+i, flags))
+			goto failure;
 
 	return (void __iomem *) (ea + (addr & ~PAGE_MASK));
+ failure:
+	if (mem_init_done)
+		unmap_im_area(ea, ea + size);
+	return NULL;
 }
 
 
@@ -206,10 +282,11 @@
 	return __ioremap(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED);
 }
 
-void __iomem *
-__ioremap(unsigned long addr, unsigned long size, unsigned long flags)
+void __iomem * __ioremap(unsigned long addr, unsigned long size,
+			 unsigned long flags)
 {
 	unsigned long pa, ea;
+	void __iomem *ret;
 
 	/*
 	 * Choose an address to map it to.
@@ -232,12 +309,16 @@
 		if (area == NULL)
 			return NULL;
 		ea = (unsigned long)(area->addr);
+		ret = __ioremap_com(addr, pa, ea, size, flags);
+		if (!ret)
+			im_free(area->addr);
 	} else {
 		ea = ioremap_bot;
-		ioremap_bot += size;
+		ret = __ioremap_com(addr, pa, ea, size, flags);
+		if (ret)
+			ioremap_bot += size;
 	}
-
-	return __ioremap_com(addr, pa, ea, size, flags);
+	return ret;
 }
 
 #define IS_PAGE_ALIGNED(_val) ((_val) == ((_val) & PAGE_MASK))
@@ -246,6 +327,7 @@
 		       unsigned long size, unsigned long flags)
 {
 	struct vm_struct *area;
+	void __iomem *ret;
 	
 	/* For now, require page-aligned values for pa, ea, and size */
 	if (!IS_PAGE_ALIGNED(pa) || !IS_PAGE_ALIGNED(ea) ||
@@ -276,7 +358,12 @@
 		}
 	}
 	
-	if (__ioremap_com(pa, pa, ea, size, flags) != (void *) ea) {
+	ret = __ioremap_com(pa, pa, ea, size, flags);
+	if (ret == NULL) {
+		printk(KERN_ERR "ioremap_explicit() allocation failure !\n");
+		return 1;
+	}
+	if (ret != (void *) ea) {
 		printk(KERN_ERR "__ioremap_com() returned unexpected addr\n");
 		return 1;
 	}
@@ -284,69 +371,6 @@
 	return 0;
 }
 
-static void unmap_im_area_pte(pmd_t *pmd, unsigned long address,
-				  unsigned long size)
-{
-	unsigned long base, end;
-	pte_t *pte;
-
-	if (pmd_none(*pmd))
-		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-
-	pte = pte_offset_kernel(pmd, address);
-	base = address & PMD_MASK;
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-
-	do {
-		pte_t page;
-		page = ptep_get_and_clear(&ioremap_mm, base + address, pte);
-		address += PAGE_SIZE;
-		pte++;
-		if (pte_none(page))
-			continue;
-		if (pte_present(page))
-			continue;
-		printk(KERN_CRIT "Whee.. Swapped out page in kernel page"
-		       " table\n");
-	} while (address < end);
-}
-
-static void unmap_im_area_pmd(pgd_t *dir, unsigned long address,
-				  unsigned long size)
-{
-	unsigned long base, end;
-	pmd_t *pmd;
-
-	if (pgd_none(*dir))
-		return;
-	if (pgd_bad(*dir)) {
-		pgd_ERROR(*dir);
-		pgd_clear(dir);
-		return;
-	}
-
-	pmd = pmd_offset(dir, address);
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-
-	do {
-		unmap_im_area_pte(pmd, base + address, end - address);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
-}
-
 /*  
  * Unmap an IO region and remove it from imalloc'd list.
  * Access to IO memory should be serialized by driver.
@@ -356,39 +380,19 @@
  */
 void iounmap(volatile void __iomem *token)
 {
-	unsigned long address, start, end, size;
-	struct mm_struct *mm;
-	pgd_t *dir;
+	unsigned long address, size;
 	void *addr;
 
-	if (!mem_init_done) {
+	if (!mem_init_done)
 		return;
-	}
 	
 	addr = (void *) ((unsigned long __force) token & PAGE_MASK);
 	
-	if ((size = im_free(addr)) == 0) {
+	if ((size = im_free(addr)) == 0)
 		return;
-	}
 
 	address = (unsigned long)addr; 
-	start = address;
-	end = address + size;
-
-	mm = &ioremap_mm;
-	spin_lock(&mm->page_table_lock);
-
-	dir = pgd_offset_i(address);
-	flush_cache_vunmap(address, end);
-	do {
-		unmap_im_area_pmd(dir, address, end - address);
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	flush_tlb_kernel_range(start, end);
-
-	spin_unlock(&mm->page_table_lock);
-	return;
+	unmap_im_area(address, address + size);
 }
 
 static int iounmap_subset_regions(unsigned long addr, unsigned long size)
Index: linux-work/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- linux-work.orig/arch/ppc64/mm/hugetlbpage.c	2005-04-28 10:58:10.000000000 +1000
+++ linux-work/arch/ppc64/mm/hugetlbpage.c	2005-04-28 11:14:57.000000000 +1000
@@ -42,7 +42,7 @@
 	return (addr & ~REGION_MASK) >> HUGEPGDIR_SHIFT;
 }
 
-static pgd_t *hugepgd_offset(struct mm_struct *mm, unsigned long addr)
+static pud_t *hugepgd_offset(struct mm_struct *mm, unsigned long addr)
 {
 	int index;
 
@@ -52,21 +52,21 @@
 
 	index = hugepgd_index(addr);
 	BUG_ON(index >= PTRS_PER_HUGEPGD);
-	return mm->context.huge_pgdir + index;
+	return (pud_t *)(mm->context.huge_pgdir + index);
 }
 
-static inline pte_t *hugepte_offset(pgd_t *dir, unsigned long addr)
+static inline pte_t *hugepte_offset(pud_t *dir, unsigned long addr)
 {
 	int index;
 
-	if (pgd_none(*dir))
+	if (pud_none(*dir))
 		return NULL;
 
 	index = (addr >> HPAGE_SHIFT) % PTRS_PER_HUGEPTE;
-	return (pte_t *)pgd_page(*dir) + index;
+	return (pte_t *)pud_page(*dir) + index;
 }
 
-static pgd_t *hugepgd_alloc(struct mm_struct *mm, unsigned long addr)
+static pud_t *hugepgd_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	BUG_ON(! in_hugepage_area(mm->context, addr));
 
@@ -90,10 +90,9 @@
 	return hugepgd_offset(mm, addr);
 }
 
-static pte_t *hugepte_alloc(struct mm_struct *mm, pgd_t *dir,
-			    unsigned long addr)
+static pte_t *hugepte_alloc(struct mm_struct *mm, pud_t *dir, unsigned long addr)
 {
-	if (! pgd_present(*dir)) {
+	if (! pud_present(*dir)) {
 		pte_t *new;
 
 		spin_unlock(&mm->page_table_lock);
@@ -104,7 +103,7 @@
 		 * Because we dropped the lock, we should re-check the
 		 * entry, as somebody else could have populated it..
 		 */
-		if (pgd_present(*dir)) {
+		if (pud_present(*dir)) {
 			if (new)
 				kmem_cache_free(zero_cache, new);
 		} else {
@@ -115,7 +114,7 @@
 			ptepage = virt_to_page(new);
 			ptepage->mapping = (void *) mm;
 			ptepage->index = addr & HUGEPGDIR_MASK;
-			pgd_populate(mm, dir, new);
+			pud_populate(mm, dir, new);
 		}
 	}
 
@@ -124,28 +123,28 @@
 
 static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
-	pgd_t *pgd;
+	pud_t *pud;
 
 	BUG_ON(! in_hugepage_area(mm->context, addr));
 
-	pgd = hugepgd_offset(mm, addr);
-	if (! pgd)
+	pud = hugepgd_offset(mm, addr);
+	if (! pud)
 		return NULL;
 
-	return hugepte_offset(pgd, addr);
+	return hugepte_offset(pud, addr);
 }
 
 static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
-	pgd_t *pgd;
+	pud_t *pud;
 
 	BUG_ON(! in_hugepage_area(mm->context, addr));
 
-	pgd = hugepgd_alloc(mm, addr);
-	if (! pgd)
+	pud = hugepgd_alloc(mm, addr);
+	if (! pud)
 		return NULL;
 
-	return hugepte_alloc(mm, pgd, addr);
+	return hugepte_alloc(mm, pud, addr);
 }
 
 static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -709,10 +708,10 @@
 
 	/* cleanup any hugepte pages leftover */
 	for (i = 0; i < PTRS_PER_HUGEPGD; i++) {
-		pgd_t *pgd = pgdir + i;
+		pud_t *pud = (pud_t *)(pgdir + i);
 
-		if (! pgd_none(*pgd)) {
-			pte_t *pte = (pte_t *)pgd_page(*pgd);
+		if (! pud_none(*pud)) {
+			pte_t *pte = (pte_t *)pud_page(*pud);
 			struct page *ptepage = virt_to_page(pte);
 
 			ptepage->mapping = NULL;
@@ -720,7 +719,7 @@
 			BUG_ON(memcmp(pte, empty_zero_page, PAGE_SIZE));
 			kmem_cache_free(zero_cache, pte);
 		}
-		pgd_clear(pgd);
+		pud_clear(pud);
 	}
 
 	BUG_ON(memcmp(pgdir, empty_zero_page, PAGE_SIZE));


