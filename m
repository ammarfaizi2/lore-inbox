Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVH3WNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVH3WNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVH3WNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:13:52 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:60290 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932453AbVH3WNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:13:50 -0400
Date: Tue, 30 Aug 2005 17:13:23 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 1/1] Implement shared page tables
Message-ID: <7C49DFF721CB4E671DB260F9@[10.1.1.4]>
X-Mailer: Mulberry/3.1.6 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========91145FC619E762F17993=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========91145FC619E762F17993==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


This patch implements page table sharing for all shared memory regions that
span an entire page table page.  It supports sharing at multiple page
levels, depending on the architecture.

Performance testing has shown no degradation with this patch for tests with
small processes.  Preliminary tests with large benchmarks have shown as
much as 3% improvement in overall results.

For those familiar with the shared page table patch I did a couple of years
ago, this patch does not implement copy-on-write page tables for private
mappings.  Analysis showed the cost and complexity far outweighed any
potential benefit.

This version of the patch supports i386 and x86_64.  I have additional
patches to support ppc64, but they are not quite ready for public
consumption.

The patch is against 2.6.13.

Dave McCracken

--==========91145FC619E762F17993==========
Content-Type: text/plain; charset=iso-8859-1;
 name="shpt-generic-2.6.13-3.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shpt-generic-2.6.13-3.diff";
 size=31902

--- 2.6.13/./arch/i386/Kconfig	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./arch/i386/Kconfig	2005-08-29 10:02:47.000000000 -0500
@@ -748,6 +748,18 @@ config X86_PAE
 	depends on HIGHMEM64G
 	default y
=20
+config PTSHARE
+	bool "Share page tables"
+	default y
+	help
+	  Turn on sharing of page tables between processes for large shared
+	  memory regions.
+
+config PTSHARE_PTE
+	bool
+	depends on PTSHARE
+	default y
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
--- 2.6.13/./arch/x86_64/Kconfig	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./arch/x86_64/Kconfig	2005-08-29 10:02:47.000000000 -0500
@@ -240,6 +240,38 @@ config NUMA_EMU
 	  into virtual nodes when booted with "numa=3Dfake=3DN", where N is the
 	  number of nodes. This is only useful for debugging.
=20
+config PTSHARE
+	bool "Share page tables"
+	default y
+	help
+	  Turn on sharing of page tables between processes for large shared
+	  memory regions.
+
+menu "Page table levels to share"
+	depends on PTSHARE
+
+config PTSHARE_PTE
+	bool "Bottom level table (PTE)"
+	depends on PTSHARE
+	default y
+
+config PTSHARE_PMD
+	bool "Middle level table (PMD)"
+	depends on PTSHARE
+	default y
+
+config PTSHARE_PUD
+	bool "Upper level table (PUD)"
+	depends on PTSHARE
+	default n
+
+endmenu
+
+config PTSHARE_HUGEPAGE
+	bool
+	depends on PTSHARE && PTSHARE_PMD
+	default y
+
 config ARCH_DISCONTIGMEM_ENABLE
        bool
        depends on NUMA
--- 2.6.13/./arch/x86_64/mm/fault.c	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./arch/x86_64/mm/fault.c	2005-08-29 10:02:47.000000000 =
-0500
@@ -153,7 +153,7 @@ void dump_pagetable(unsigned long addres
 	if (bad_address(pgd)) goto bad;
 	if (!pgd_present(*pgd)) goto ret;=20
=20
-	pud =3D __pud_offset_k((pud_t *)pgd_page(*pgd), address);
+	pud =3D __pud_offset_k((pud_t *)pgd_page_kernel(*pgd), address);
 	if (bad_address(pud)) goto bad;
 	printk("PUD %lx ", pud_val(*pud));
 	if (!pud_present(*pud))	goto ret;
@@ -259,7 +259,7 @@ static int vmalloc_fault(unsigned long a
 	pud_ref =3D pud_offset(pgd_ref, address);
 	if (pud_none(*pud_ref))
 		return -1;
-	if (pud_none(*pud) || pud_page(*pud) !=3D pud_page(*pud_ref))
+	if (pud_none(*pud) || pud_page_kernel(*pud) !=3D =
pud_page_kernel(*pud_ref))
 		BUG();
 	pmd =3D pmd_offset(pud, address);
 	pmd_ref =3D pmd_offset(pud_ref, address);
--- 2.6.13/./include/asm-x86_64/pgtable.h	2005-08-28 18:41:01.000000000 =
-0500
+++ 2.6.13-shpt/./include/asm-x86_64/pgtable.h	2005-08-29 =
10:02:47.000000000 -0500
@@ -100,9 +100,6 @@ extern inline void pgd_clear (pgd_t * pg
 	set_pgd(pgd, __pgd(0));
 }
=20
-#define pud_page(pud) \
-((unsigned long) __va(pud_val(pud) & PHYSICAL_PAGE_MASK))
-
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
 #define pte_same(a, b)		((a).pte =3D=3D (b).pte)
=20
@@ -309,7 +306,8 @@ static inline int pmd_large(pmd_t pte) {
 /*
  * Level 4 access.
  */
-#define pgd_page(pgd) ((unsigned long) __va((unsigned long)pgd_val(pgd) & =
PTE_MASK))
+#define pgd_page_kernel(pgd) ((unsigned long) __va((unsigned =
long)pgd_val(pgd) & PTE_MASK))
+#define pgd_page(pgd)		(pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT))
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pgd_offset(mm, addr) ((mm)->pgd + pgd_index(addr))
 #define pgd_offset_k(address) (init_level4_pgt + pgd_index(address))
@@ -317,9 +315,11 @@ static inline int pmd_large(pmd_t pte) {
 #define mk_kernel_pgd(address) ((pgd_t){ (address) | _KERNPG_TABLE })
=20
 /* PUD - Level3 access */
+#define pud_page_kernel(pud) ((unsigned long) __va(pud_val(pud) & =
PHYSICAL_PAGE_MASK))
+#define pud_page(pud)		(pfn_to_page(pud_val(pud) >> PAGE_SHIFT))
 /* to find an entry in a page-table-directory. */
 #define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-#define pud_offset(pgd, address) ((pud_t *) pgd_page(*(pgd)) + =
pud_index(address))
+#define pud_offset(pgd, address) ((pud_t *) pgd_page_kernel(*(pgd)) + =
pud_index(address))
 #define pud_offset_k(pgd, addr) pud_offset(pgd, addr)
 #define pud_present(pud) (pud_val(pud) & _PAGE_PRESENT)
=20
@@ -333,7 +333,7 @@ static inline pud_t *__pud_offset_k(pud_
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
=20
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-#define pmd_offset(dir, address) ((pmd_t *) pud_page(*(dir)) + \
+#define pmd_offset(dir, address) ((pmd_t *) pud_page_kernel(*(dir)) + \
 			pmd_index(address))
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
--- 2.6.13/./include/linux/ptshare.h	1969-12-31 18:00:00.000000000 -0600
+++ 2.6.13-shpt/./include/linux/ptshare.h	2005-08-29 10:02:47.000000000 =
-0500
@@ -0,0 +1,274 @@
+#ifndef _LINUX_PTSHARE_H
+#define _LINUX_PTSHARE_H
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, =
USA.
+ *
+ * Copyright (C) IBM Corporation, 2005
+ *
+ * Author: Dave McCracken <dmccr@us.ibm.com>
+ */
+
+#ifdef CONFIG_PTSHARE
+static inline int pt_is_shared(struct page *page)
+{
+	return (page_mapcount(page) > 1);
+}
+
+static inline void pt_increment_share(struct page *page)
+{
+	atomic_inc(&page->_mapcount);
+}
+
+static inline void pt_decrement_share(struct page *page)
+{
+	atomic_dec(&page->_mapcount);
+}
+
+static inline int
+pt_shareable_vma(struct vm_area_struct *vma)
+{
+	/* We can't share anonymous memory */
+	if (!vma->vm_file)
+		return 0;
+
+	/* No sharing of nonlinear areas */
+	if (vma->vm_flags & VM_NONLINEAR)
+		return 0;
+
+	/* Only share shared mappings or read-only mappings */
+	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) =3D=3D VM_WRITE)
+		return 0;
+
+	/* If it's smaller than the smallest shareable unit, don't bother
+	   calling it shareable */
+	if ((vma->vm_end - vma->vm_start) < PMD_SIZE)
+		return 0;
+
+	return 1;
+}
+extern void pt_unshare_range(struct mm_struct *mm,
+			     unsigned long address,
+			     unsigned long end);
+#else /* CONFIG_PTSHARE */
+#define	pt_is_shared(page)	(0)
+#define	pt_increment_share(page)
+#define	pt_decrement_share(page)
+#define pt_shareable_vma(vma)	(0)
+#define	pt_unshare_range(mm, address, end)
+#endif /* CONFIG_PTSHARE */
+
+#ifdef CONFIG_PTSHARE_PTE
+static inline int
+pt_is_shared_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page =3D pmd_page(pmdval);
+	return pt_is_shared(page);
+}
+
+static inline void
+pt_increment_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page =3D pmd_page(pmdval);
+	pt_increment_share(page);
+	return;
+}
+
+static inline void
+pt_decrement_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page =3D pmd_page(pmdval);
+	pt_decrement_share(page);
+	return;
+}
+
+static inline int
+pt_shareable_pte(struct vm_area_struct *vma,
+		 unsigned long address)
+{
+	unsigned long base =3D address & PMD_MASK;
+	unsigned long end =3D base + (PMD_SIZE-1);
+
+		if ((vma->vm_start <=3D base) &&
+	    (vma->vm_end >=3D end))
+		return 1;
+
+	return 0;
+}
+extern pte_t * pt_share_pte(struct vm_area_struct *vma,
+			    unsigned long address,
+			    pmd_t *pmd,
+			    struct address_space *mapping);
+extern void pt_copy_pte(struct mm_struct *mm,
+			pmd_t *dst_pmd,
+			pmd_t *src_pmd);
+#else /* CONFIG_PTSHARE_PTE */
+static inline int
+pt_is_shared_pte(pmd_t pmdval)
+{
+	return 0;
+}
+#define	pt_increment_pte(pmdval)
+#define	pt_decrement_pte(pmdval)
+#define	pt_copy_pte(mm, dst_pmd, src_pmd)
+#define	pt_shareable_pte(vma, address) (0)
+#define	pt_share_pte(vma, address, pmd, mapping) pte_alloc_map(vma->vm_mm, =
pmd, address)
+#endif /* CONFIG_PTSHARE_PTE */
+
+#ifdef CONFIG_PTSHARE_PMD
+static inline int
+pt_is_shared_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page =3D pud_page(pudval);
+	return pt_is_shared(page);
+}
+
+static inline void
+pt_increment_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page =3D pud_page(pudval);
+	pt_increment_share(page);
+	return;
+}
+
+static inline void
+pt_decrement_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page =3D pud_page(pudval);
+	pt_decrement_share(page);
+	return;
+}
+
+static inline int
+pt_shareable_pmd(struct vm_area_struct *vma,
+		 unsigned long address)
+{
+	unsigned long base =3D address & PUD_MASK;
+	unsigned long end =3D base + (PUD_SIZE-1);
+
+		if ((vma->vm_start <=3D base) &&
+	    (vma->vm_end >=3D end))
+		return 1;
+
+	return 0;
+}
+extern pmd_t * pt_share_pmd(struct vm_area_struct *vma,
+			    unsigned long address,
+			    pud_t *pud,
+			    struct address_space *mapping);
+extern void pt_copy_pmd(struct mm_struct *mm,
+			pud_t *dst_pud,
+			pud_t *src_pud);
+#else /* CONFIG_PTSHARE_PMD */
+static inline int
+pt_is_shared_pmd(pud_t pudval)
+{
+	return 0;
+}
+#define	pt_increment_pmd(pudval)
+#define	pt_decrement_pmd(pudval)
+#define	pt_copy_pmd(mm, dst_pud, src_pud)
+#define	pt_shareable_pmd(vma, address) (0)
+#define	pt_share_pmd(vma, address, pud, mapping) pmd_alloc(vma->vm_mm, =
pud, address)
+#endif /* CONFIG_PTSHARE_PMD */
+
+#ifdef CONFIG_PTSHARE_PUD
+static inline int
+pt_is_shared_pud(pgd_t pgdval)
+{
+	struct page *page;
+
+	page =3D pgd_page(pgdval);
+	return pt_is_shared(page);
+}
+
+static inline void
+pt_increment_pud(pgd_t pgdval)
+{
+	struct page *page;
+
+	page =3D pgd_page(pgdval);
+	pt_increment_share(page);
+	return;
+}
+
+static inline void
+pt_decrement_pud(pgd_t pgdval)
+{
+	struct page *page;
+
+	page =3D pgd_page(pgdval);
+	pt_decrement_share(page);
+	return;
+}
+
+static inline int
+pt_shareable_pud(struct vm_area_struct *vma,
+		 unsigned long address)
+{
+	unsigned long base =3D address & PGDIR_MASK;
+	unsigned long end =3D base + (PGDIR_SIZE-1);
+
+		if ((vma->vm_start <=3D base) &&
+	    (vma->vm_end >=3D end))
+		return 1;
+
+	return 0;
+}
+extern pud_t * pt_share_pud(struct vm_area_struct *vma,
+			    unsigned long address,
+			    pgd_t *pgd,
+			    struct address_space *mapping);
+extern void pt_copy_pud(struct mm_struct *mm,
+			pgd_t *dst_pgd,
+			pgd_t *src_pgd);
+#else /* CONFIG_PTSHARE_PUD */
+static inline int
+pt_is_shared_pud(pgd_t pgdval)
+{
+	return 0;
+}
+#define	pt_increment_pud(pgdval)
+#define	pt_decrement_pud(pgdval)
+#define	pt_copy_pud(mm, dst_pgd, src_pgd)
+#define	pt_shareable_pud(vma, address) (0)
+#define	pt_share_pud(vma, address, pgd, mapping) pud_alloc(vma->vm_mm, =
pgd, address)
+#endif /* CONFIG_PTSHARE_PUD */
+
+#ifdef CONFIG_PTSHARE_HUGEPAGE
+extern pte_t *pt_share_hugepage(struct mm_struct *mm,
+			       struct vm_area_struct *vma,
+			       unsigned long address);
+extern void pt_unshare_huge_range(struct mm_struct *mm,
+				  unsigned long address,
+				  unsigned long end);
+#else
+#define	pt_share_hugepage(mm, vma, address)	huge_pte_alloc(mm, address)
+#define	pt_unshare_huge_range(mm, address, end)
+#endif	/* CONFIG_PTSHARE_HUGEPAGE */
+
+#endif /* _LINUX_PTSHARE_H */
--- 2.6.13/./mm/Makefile	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./mm/Makefile	2005-08-29 10:02:47.000000000 -0500
@@ -18,5 +18,6 @@ obj-$(CONFIG_NUMA) 	+=3D mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+=3D sparse.o
 obj-$(CONFIG_SHMEM) +=3D shmem.o
 obj-$(CONFIG_TINY_SHMEM) +=3D tiny-shmem.o
+obj-$(CONFIG_PTSHARE) +=3D ptshare.o
=20
 obj-$(CONFIG_FS_XIP) +=3D filemap_xip.o
--- 2.6.13/./mm/fremap.c	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./mm/fremap.c	2005-08-29 10:02:47.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
=20
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -226,6 +227,9 @@ asmlinkage long sys_remap_file_pages(uns
 				has_write_lock =3D 1;
 				goto retry;
 			}
+			if (pt_shareable_vma(vma))
+				pt_unshare_range(vma->vm_mm, vma->vm_start, vma->vm_end);
+
 			mapping =3D vma->vm_file->f_mapping;
 			spin_lock(&mapping->i_mmap_lock);
 			flush_dcache_mmap_lock(mapping);
--- 2.6.13/./mm/hugetlb.c	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./mm/hugetlb.c	2005-08-29 10:02:47.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/highmem.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
+#include <linux/ptshare.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
=20
@@ -278,7 +279,7 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long end =3D vma->vm_end;
=20
 	while (addr < end) {
-		dst_pte =3D huge_pte_alloc(dst, addr);
+		dst_pte =3D pt_share_hugepage(dst, vma, addr);
 		if (!dst_pte)
 			goto nomem;
 		src_pte =3D huge_pte_offset(src, addr);
@@ -309,6 +310,7 @@ void unmap_hugepage_range(struct vm_area
 	BUG_ON(start & ~HPAGE_MASK);
 	BUG_ON(end & ~HPAGE_MASK);
=20
+	pt_unshare_huge_range(mm, start, end);
 	for (address =3D start; address < end; address +=3D HPAGE_SIZE) {
 		ptep =3D huge_pte_offset(mm, address);
 		if (! ptep)
@@ -353,7 +355,7 @@ int hugetlb_prefault(struct address_spac
 	spin_lock(&mm->page_table_lock);
 	for (addr =3D vma->vm_start; addr < vma->vm_end; addr +=3D HPAGE_SIZE) {
 		unsigned long idx;
-		pte_t *pte =3D huge_pte_alloc(mm, addr);
+		pte_t *pte =3D pt_share_hugepage(mm, vma, addr);
 		struct page *page;
=20
 		if (!pte) {
--- 2.6.13/./mm/memory.c	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./mm/memory.c	2005-08-30 13:14:46.000000000 -0500
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/ptshare.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -113,10 +114,16 @@ void pmd_clear_bad(pmd_t *pmd)
 static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
 {
 	struct page *page =3D pmd_page(*pmd);
-	pmd_clear(pmd);
-	pte_free_tlb(tlb, page);
-	dec_page_state(nr_page_table_pages);
-	tlb->mm->nr_ptes--;
+	pmd_t pmdval=3D *pmd;
+	int share;
+
+	share =3D pt_is_shared_pte(pmdval);
+  	pmd_clear(pmd);
+	pt_decrement_pte(pmdval);
+	if (!share) {
+		pte_free_tlb(tlb, page);
+		dec_page_state(nr_page_table_pages);
+	}
 }
=20
 static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
@@ -124,17 +131,22 @@ static inline void free_pmd_range(struct
 				unsigned long floor, unsigned long ceiling)
 {
 	pmd_t *pmd;
-	unsigned long next;
-	unsigned long start;
-
-	start =3D addr;
-	pmd =3D pmd_offset(pud, addr);
-	do {
-		next =3D pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
-		free_pte_range(tlb, pmd);
-	} while (pmd++, addr =3D next, addr !=3D end);
+	pud_t pudval =3D *pud;
+  	unsigned long next;
+  	unsigned long start;
+	int share;
+ =20
+	share =3D pt_is_shared_pmd(pudval);
+  	start =3D addr;
+  	pmd =3D pmd_offset(pud, addr);
+	if (!share) {
+		do {
+			next =3D pmd_addr_end(addr, end);
+			if (pmd_none_or_clear_bad(pmd))
+				continue;
+			free_pte_range(tlb, pmd);
+		} while (pmd++, addr =3D next, addr !=3D end);
+	}
=20
 	start &=3D PUD_MASK;
 	if (start < floor)
@@ -149,7 +161,10 @@ static inline void free_pmd_range(struct
=20
 	pmd =3D pmd_offset(pud, start);
 	pud_clear(pud);
-	pmd_free_tlb(tlb, pmd);
+	pt_decrement_pmd(pudval);
+	if (!share)
+		pmd_free_tlb(tlb, pmd);
+
 }
=20
 static inline void free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
@@ -157,17 +172,22 @@ static inline void free_pud_range(struct
 				unsigned long floor, unsigned long ceiling)
 {
 	pud_t *pud;
+	pgd_t pgdval =3D *pgd;
 	unsigned long next;
 	unsigned long start;
+	int share;
=20
+	share =3D pt_is_shared_pud(pgdval);
 	start =3D addr;
 	pud =3D pud_offset(pgd, addr);
-	do {
-		next =3D pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		free_pmd_range(tlb, pud, addr, next, floor, ceiling);
-	} while (pud++, addr =3D next, addr !=3D end);
+	if (!share) {
+		do {
+			next =3D pud_addr_end(addr, end);
+			if (pud_none_or_clear_bad(pud))
+				continue;
+			free_pmd_range(tlb, pud, addr, next, floor, ceiling);
+		} while (pud++, addr =3D next, addr !=3D end);
+	}
=20
 	start &=3D PGDIR_MASK;
 	if (start < floor)
@@ -182,7 +202,10 @@ static inline void free_pud_range(struct
=20
 	pud =3D pud_offset(pgd, start);
 	pgd_clear(pgd);
-	pud_free_tlb(tlb, pud);
+	pt_decrement_pud(pgdval);
+	if (!share)
+		pud_free_tlb(tlb, pud);
+
 }
=20
 /*
@@ -299,9 +322,13 @@ pte_t fastcall *pte_alloc_map(struct mm_
 			pte_free(new);
 			goto out;
 		}
+#if 0
 		mm->nr_ptes++;
+#endif
 		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
+
+		pt_increment_pte(*pmd);
 	}
 out:
 	return pte_offset_map(pmd, address);
@@ -327,6 +354,8 @@ pte_t fastcall * pte_alloc_kernel(struct
 			goto out;
 		}
 		pmd_populate_kernel(mm, pmd, new);
+
+		pt_increment_pte(*pmd);
 	}
 out:
 	return pte_offset_kernel(pmd, address);
@@ -448,7 +477,7 @@ again:
=20
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct =
mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end, int shareable)
 {
 	pmd_t *src_pmd, *dst_pmd;
 	unsigned long next;
@@ -461,16 +490,20 @@ static inline int copy_pmd_range(struct=20
 		next =3D pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
-		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-						vma, addr, next))
-			return -ENOMEM;
+		if (shareable && pt_shareable_pte(vma, addr)) {
+			pt_copy_pte(dst_mm, dst_pmd, src_pmd);
+		} else {
+			if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
+					   vma, addr, next))
+				return -ENOMEM;
+		}
 	} while (dst_pmd++, src_pmd++, addr =3D next, addr !=3D end);
 	return 0;
 }
=20
 static inline int copy_pud_range(struct mm_struct *dst_mm, struct =
mm_struct *src_mm,
 		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end, int shareable)
 {
 	pud_t *src_pud, *dst_pud;
 	unsigned long next;
@@ -483,9 +516,13 @@ static inline int copy_pud_range(struct=20
 		next =3D pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(src_pud))
 			continue;
-		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-						vma, addr, next))
-			return -ENOMEM;
+		if (shareable && pt_shareable_pmd(vma, addr)) {
+			pt_copy_pmd(dst_mm, dst_pud, src_pud);
+		} else {
+			if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
+					   vma, addr, next, shareable))
+				return -ENOMEM;
+		}
 	} while (dst_pud++, src_pud++, addr =3D next, addr !=3D end);
 	return 0;
 }
@@ -497,19 +534,26 @@ int copy_page_range(struct mm_struct *ds
 	unsigned long next;
 	unsigned long addr =3D vma->vm_start;
 	unsigned long end =3D vma->vm_end;
+	int shareable;
=20
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
=20
+	shareable =3D pt_shareable_vma(vma);
+
 	dst_pgd =3D pgd_offset(dst_mm, addr);
 	src_pgd =3D pgd_offset(src_mm, addr);
 	do {
 		next =3D pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(src_pgd))
 			continue;
-		if (copy_pud_range(dst_mm, src_mm, dst_pgd, src_pgd,
-						vma, addr, next))
-			return -ENOMEM;
+		if (shareable && pt_shareable_pud(vma, addr)) {
+			pt_copy_pud(dst_mm, dst_pgd, src_pgd);
+		} else {
+			if (copy_pud_range(dst_mm, src_mm, dst_pgd, src_pgd,
+					   vma, addr, next, shareable))
+				return -ENOMEM;
+		}
 	} while (dst_pgd++, src_pgd++, addr =3D next, addr !=3D end);
 	return 0;
 }
@@ -520,6 +564,12 @@ static void zap_pte_range(struct mmu_gat
 {
 	pte_t *pte;
=20
+	if (pt_is_shared_pte(*pmd)) {
+		pt_decrement_pte(*pmd);
+		pmd_clear(pmd);
+		return;
+	}
+
 	pte =3D pte_offset_map(pmd, addr);
 	do {
 		pte_t ptent =3D *pte;
@@ -591,6 +641,12 @@ static inline void zap_pmd_range(struct=20
 	pmd_t *pmd;
 	unsigned long next;
=20
+	if (pt_is_shared_pmd(*pud)) {
+		pt_decrement_pmd(*pud);
+		pud_clear(pud);
+		return;
+	}
+
 	pmd =3D pmd_offset(pud, addr);
 	do {
 		next =3D pmd_addr_end(addr, end);
@@ -607,6 +663,12 @@ static inline void zap_pud_range(struct=20
 	pud_t *pud;
 	unsigned long next;
=20
+	if (pt_is_shared_pud(*pgd)) {
+		pt_decrement_pud(*pgd);
+		pgd_clear(pgd);
+		return;
+	}
+
 	pud =3D pud_offset(pgd, addr);
 	do {
 		next =3D pud_addr_end(addr, end);
@@ -2028,6 +2090,7 @@ int __handle_mm_fault(struct mm_struct *
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	struct address_space *mapping =3D NULL;
=20
 	__set_current_state(TASK_RUNNING);
=20
@@ -2036,6 +2099,9 @@ int __handle_mm_fault(struct mm_struct *
 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
=20
+	if (pt_shareable_vma(vma))
+		mapping =3D vma->vm_file->f_dentry->d_inode->i_mapping;
+
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
@@ -2043,18 +2109,18 @@ int __handle_mm_fault(struct mm_struct *
 	pgd =3D pgd_offset(mm, address);
 	spin_lock(&mm->page_table_lock);
=20
-	pud =3D pud_alloc(mm, pgd, address);
+	pud =3D pt_share_pud(vma, address, pgd, mapping);
 	if (!pud)
 		goto oom;
=20
-	pmd =3D pmd_alloc(mm, pud, address);
+	pmd =3D pt_share_pmd(vma, address, pud, mapping);
 	if (!pmd)
 		goto oom;
=20
-	pte =3D pte_alloc_map(mm, pmd, address);
+	pte =3D pt_share_pte(vma, address, pmd, mapping);
 	if (!pte)
 		goto oom;
-	
+
 	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
=20
  oom:
@@ -2088,6 +2154,8 @@ pud_t fastcall *__pud_alloc(struct mm_st
 		goto out;
 	}
 	pgd_populate(mm, pgd, new);
+
+	pt_increment_pud(*pgd);
  out:
 	return pud_offset(pgd, address);
 }
@@ -2128,6 +2196,8 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
 	pgd_populate(mm, pud, new);
 #endif /* __ARCH_HAS_4LEVEL_HACK */
=20
+	pt_increment_pmd(*pud);
+
  out:
 	return pmd_offset(pud, address);
 }
--- 2.6.13/./mm/mmap.c	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./mm/mmap.c	2005-08-30 13:33:54.000000000 -0500
@@ -1969,7 +1969,6 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D next;
 	}
=20
-	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
 }
=20
 /* Insert vm structure into process list sorted by address
--- 2.6.13/./mm/mprotect.c	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./mm/mprotect.c	2005-08-29 10:02:47.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -116,6 +117,9 @@ mprotect_fixup(struct vm_area_struct *vm
 		return 0;
 	}
=20
+	if (pt_shareable_vma(vma))
+		pt_unshare_range(vma->vm_mm, start, end);
+
 	/*
 	 * If we make a private mapping writable we increase our commit;
 	 * but (without finer accounting) cannot reduce our commit if we
--- 2.6.13/./mm/mremap.c	2005-08-28 18:41:01.000000000 -0500
+++ 2.6.13-shpt/./mm/mremap.c	2005-08-29 10:02:47.000000000 -0500
@@ -17,6 +17,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
=20
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -163,6 +164,9 @@ static unsigned long move_page_tables(st
=20
 	flush_cache_range(vma, old_addr, old_addr + len);
=20
+	if (pt_shareable_vma(vma))
+		pt_unshare_range(vma->vm_mm, old_addr, old_addr + len);
+
 	/*
 	 * This is not the clever way to do this, but we're taking the
 	 * easy way out on the assumption that most remappings will be
--- 2.6.13/./mm/ptshare.c	1969-12-31 18:00:00.000000000 -0600
+++ 2.6.13-shpt/./mm/ptshare.c	2005-08-29 10:02:47.000000000 -0500
@@ -0,0 +1,366 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, =
USA.
+ *
+ * Copyright (C) IBM Corporation, 2005
+ *
+ * Author: Dave McCracken <dmccr@us.ibm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/prio_tree.h>
+#include <linux/mm.h>
+#include <linux/ptshare.h>
+
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+#undef	PT_DEBUG
+
+#ifndef __PAGETABLE_PMD_FOLDED
+static void
+pt_unshare_pmd(pud_t *pud,
+	       unsigned long address,
+	       unsigned long end)
+{
+	pmd_t *pmd;
+	struct page *page;
+
+	pmd =3D pmd_offset(pud, address);
+	end =3D pud_addr_end(address, end);
+	while (address <=3D end) {
+		if (pmd_present(*pmd)) {
+			page =3D pmd_page(*pmd);
+			if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Unsharing pte page at address 0x%lx\n",
+				       address);
+#endif
+				pt_decrement_share(page);
+				pmd_clear(pmd);
+			}
+		}
+		pmd++;
+		address +=3D PMD_SIZE;
+	}
+}
+
+#ifndef __PAGETABLE_PUD_FOLDED
+static void
+pt_unshare_pud(pgd_t *pgd,
+	       unsigned long address,
+	       unsigned long end,
+	       int hugepage)
+{
+	pud_t *pud;
+	struct page *page;
+
+	pud =3D pud_offset(pgd, address);
+	end =3D pgd_addr_end(address, end);
+	while (address <=3D end) {
+		if (pud_present(*pud)) {
+			page =3D pud_page(*pud);
+			if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Unsharing pmd page at address 0x%lx\n",
+				       address);
+#endif
+				pt_decrement_share(page);
+				pud_clear(pud);
+			} else if (!hugepage) {
+				pt_unshare_pmd(pud, address, end);
+			}
+		}
+		pud++;
+		address +=3D PUD_SIZE;
+	}
+}
+#endif /* __PAGETABLE_PUD_FOLDED */
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+static void
+pt_unshare_pgd(struct mm_struct *mm,
+		 unsigned long address,
+		 unsigned long end,
+		 int hugepage)
+{
+	pgd_t *pgd;
+	struct page *page;
+
+	pgd =3D pgd_offset(mm, address);
+
+	while (address <=3D end) {
+		if (pgd_present(*pgd)) {
+			page =3D pgd_page(*pgd);
+			if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Unsharing pud page at address 0x%lx\n",
+				       address);
+#endif
+				pt_decrement_share(page);
+				pgd_clear(pgd);
+#ifndef __PAGETABLE_PMD_FOLDED
+			} else {
+#ifndef __PAGETABLE_PUD_FOLDED
+				pt_unshare_pud(pgd, address, end, hugepage);
+#else /* __PAGETABLE_PUD_FOLDED */
+				if (!hugepage)
+					pt_unshare_pmd((pud_t *)pgd, address, end);
+#endif /* __PAGETABLE_PUD_FOLDED */
+#endif /* __PAGETABLE_PMD_FOLDED */
+			}
+		}
+		pgd++;
+		address +=3D PGDIR_SIZE;
+	}
+}
+
+void
+pt_unshare_range(struct mm_struct *mm,
+		 unsigned long address,
+		 unsigned long end)
+{
+	pt_unshare_pgd(mm, address, end, 0);
+}
+
+static struct vm_area_struct *
+next_shareable_vma(struct vm_area_struct *vma,
+		   struct vm_area_struct *svma,
+		   struct prio_tree_iter *iter)
+{
+	while ((svma =3D vma_prio_tree_next(svma, iter))) {
+		if ((svma !=3D vma) &&
+		    (vma->vm_flags =3D=3D svma->vm_flags) &&
+		    (vma->vm_start =3D=3D svma->vm_start) &&
+		    (vma->vm_end =3D=3D svma->vm_end) &&
+		    (vma->vm_pgoff =3D=3D svma->vm_pgoff))
+			break;
+	}
+	return svma;
+}
+
+#ifdef CONFIG_PTSHARE_PTE
+pte_t *
+pt_share_pte(struct vm_area_struct *vma,
+	     unsigned long address,
+	     pmd_t *pmd,
+	     struct address_space *mapping)
+{
+	struct prio_tree_iter iter;
+	struct page *page;
+	struct vm_area_struct *svma =3D NULL;
+	pgd_t *spgd;
+	pud_t *spud;
+	pmd_t *spmd;
+	pte_t *pte;
+
+	if (pmd_none(*pmd) &&
+	    mapping &&
+	    pt_shareable_pte(vma, address)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Looking for shareable pte page at address 0x%lx\n",
+		       address);
+#endif
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_start, vma->vm_end);
+
+		while ((svma =3D next_shareable_vma(vma, svma, &iter))) {
+			spgd =3D pgd_offset(svma->vm_mm, address);
+			if (pgd_none(*spgd))
+				continue;
+
+			spud =3D pud_offset(spgd, address);
+			if (pud_none(*spud))
+				continue;
+
+			spmd =3D pmd_offset(spud, address);
+			if (pmd_none(*spmd))
+				continue;
+
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Sharing pte page at address 0x%lx\n",
+			       address);
+#endif
+			page =3D pmd_page(*spmd);
+			pt_increment_share(page);
+			pmd_populate(vma->vm_mm, pmd, page);
+		}
+	}
+	pte =3D pte_alloc_map(vma->vm_mm, pmd, address);
+
+	return pte;
+}
+
+void
+pt_copy_pte(struct mm_struct *mm,
+	    pmd_t *dst_pmd,
+	    pmd_t *src_pmd)
+{
+	struct page *page;
+
+	page =3D pmd_page(*src_pmd);
+	pmd_populate(mm, dst_pmd, page);
+	pt_increment_share(page);
+}
+#endif
+
+#ifdef CONFIG_PTSHARE_PMD
+pmd_t *
+pt_share_pmd(struct vm_area_struct *vma,
+	     unsigned long address,
+	     pud_t *pud,
+	     struct address_space *mapping)
+{
+	struct prio_tree_iter iter;
+	struct page *page;
+	struct vm_area_struct *svma =3D NULL;
+	pgd_t *spgd;
+	pud_t *spud;
+	pmd_t *pmd;
+
+	if (pud_none(*pud) &&
+	    mapping &&=20
+	    pt_shareable_pmd(vma, address)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Looking for shareable pmd page at address 0x%lx\n",
+		       address);
+#endif
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_start, vma->vm_end);
+
+		while ((svma =3D next_shareable_vma(vma, svma, &iter))) {
+			spgd =3D pgd_offset(svma->vm_mm, address);
+			if (pgd_none(*spgd))
+				continue;
+
+			spud =3D pud_offset(spgd, address);
+			if (pud_none(*spud))
+				continue;
+
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Sharing pmd page at address 0x%lx\n",
+			       address);
+#endif
+			page =3D pud_page(*spud);
+			pt_increment_share(page);
+			pud_populate(vma->vm_mm, pud, page);
+		}
+	}
+	pmd =3D pmd_alloc(vma->vm_mm, pud, address);
+
+	return pmd;
+}
+
+void
+pt_copy_pmd(struct mm_struct *mm,
+	    pud_t *dst_pud,
+	    pud_t *src_pud)
+{
+	struct page *page;
+
+	page =3D pud_page(*src_pud);
+	pud_populate(mm, dst_pud, page);
+	pt_increment_share(page);
+}
+#endif
+
+#ifdef CONFIG_PTSHARE_PUD
+pud_t *
+pt_share_pud(struct vm_area_struct *vma,
+	     unsigned long address,
+	     pgd_t *pgd,
+	     struct address_space *mapping)
+{
+	struct prio_tree_iter iter;
+	struct page *page;
+	struct vm_area_struct *svma =3D NULL;
+	pgd_t *spgd;
+	pud_t *pud;
+
+	if (pgd_none(*pgd) &&
+	    mapping &&=20
+	    pt_shareable_pud(vma, address)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Looking for shareable pud page at address 0x%lx\n",
+		       address);
+#endif
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_start, vma->vm_end);
+
+		while ((svma =3D next_shareable_vma(vma, svma, &iter))) {
+			spgd =3D pgd_offset(svma->vm_mm, address);
+			if (pgd_none(*spgd))
+				continue;
+
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Sharing pud page at address 0x%lx\n",
+			       address);
+#endif
+			page =3D pgd_page(*spgd);
+			pt_increment_share(page);
+			pgd_populate(vma->vm_mm, pgd, page);
+		}
+	}
+	pud =3D pud_alloc(vma->vm_mm, pgd, address);
+	
+	return pud;
+}
+
+void
+pt_copy_pud(struct mm_struct *mm,
+	    pgd_t *dst_pgd,
+	    pgd_t *src_pgd)
+{
+	struct page *page;
+
+	page =3D pgd_page(*src_pgd);
+	pgd_populate(mm, dst_pgd, page);
+	pt_increment_share(page);
+}
+#endif
+
+#ifdef CONFIG_PTSHARE_HUGEPAGE
+
+void
+pt_unshare_huge_range(struct mm_struct *mm,
+		      unsigned long address,
+		      unsigned long end)
+{
+	pt_unshare_pgd(mm, address, end, 1);
+}
+
+pte_t *
+pt_share_hugepage(struct mm_struct *mm,
+		  struct vm_area_struct *vma,
+		  unsigned long address)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pte_t *pte;
+	struct address_space *mapping =3D NULL;
+
+	if (pt_shareable_vma(vma))
+		mapping =3D vma->vm_file->f_dentry->d_inode->i_mapping;
+
+	pgd =3D pgd_offset(mm, address);
+
+	pud =3D pt_share_pud(vma, address, pgd, mapping);
+	if (!pud)
+		return NULL;
+
+	pte =3D (pte_t *)pt_share_pmd(vma, address, pud, mapping);
+
+	return pte;
+}
+#endif

--==========91145FC619E762F17993==========--

