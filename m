Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWAEQT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWAEQT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWAEQT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:19:57 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:35321 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750789AbWAEQTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:19:55 -0500
Date: Thu, 05 Jan 2006 10:19:10 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH/RFC] Shared page tables
Message-ID: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========450962CA3D9EF5351328=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========450962CA3D9EF5351328==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Here's a new version of my shared page tables patch.

The primary purpose of sharing page tables is improved performance for
large applications that share big memory areas between multiple processes.
It eliminates the redundant page tables and significantly reduces the
number of minor page faults.  Tests show significant performance
improvement for large database applications, including those using large
pages.  There is no measurable performance degradation for small processes.

This version of the patch uses Hugh's new locking mechanism, extending it
up the page table tree as far as necessary for proper concurrency control.

The patch also includes the proper locking for following the vma chains.

Hugh, I believe I have all the lock points nailed down.  I'd appreciate
your input on any I might have missed.

The architectures supported are i386 and x86_64.  I'm working on 64 bit
ppc, but there are still some issues around proper segment handling that
need more testing.  This will be available in a separate patch once it's
solid.

Dave McCracken

--==========450962CA3D9EF5351328==========
Content-Type: text/plain; charset=utf-8; name="shpt-generic-2.6.15-1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shpt-generic-2.6.15-1.diff";
 size=40765

--- 2.6.15/./arch/i386/Kconfig	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./arch/i386/Kconfig	2006-01-03 10:30:01.000000000 -0600
@@ -458,6 +458,18 @@ config X86_PAE
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
--- 2.6.15/./arch/x86_64/Kconfig	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./arch/x86_64/Kconfig	2006-01-03 10:30:01.000000000 -0600
@@ -267,6 +267,38 @@ config NUMA_EMU
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
--- 2.6.15/./arch/x86_64/mm/fault.c	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./arch/x86_64/mm/fault.c	2006-01-03 10:30:01.000000000 =
-0600
@@ -154,7 +154,7 @@ void dump_pagetable(unsigned long addres
 	if (bad_address(pgd)) goto bad;
 	if (!pgd_present(*pgd)) goto ret;=20
=20
-	pud =3D __pud_offset_k((pud_t *)pgd_page(*pgd), address);
+	pud =3D __pud_offset_k((pud_t *)pgd_page_kernel(*pgd), address);
 	if (bad_address(pud)) goto bad;
 	printk("PUD %lx ", pud_val(*pud));
 	if (!pud_present(*pud))	goto ret;
@@ -261,7 +261,7 @@ static int vmalloc_fault(unsigned long a
 	pud_ref =3D pud_offset(pgd_ref, address);
 	if (pud_none(*pud_ref))
 		return -1;
-	if (pud_none(*pud) || pud_page(*pud) !=3D pud_page(*pud_ref))
+	if (pud_none(*pud) || pud_page_kernel(*pud) !=3D =
pud_page_kernel(*pud_ref))
 		BUG();
 	pmd =3D pmd_offset(pud, address);
 	pmd_ref =3D pmd_offset(pud_ref, address);
--- 2.6.15/./include/asm-generic/pgtable.h	2006-01-02 21:21:10.000000000 =
-0600
+++ 2.6.15-shpt/./include/asm-generic/pgtable.h	2006-01-03 =
10:30:01.000000000 -0600
@@ -173,6 +173,23 @@ static inline void ptep_set_wrprotect(st
 #endif
=20
 /*
+ * Some architectures might need flushes when higher levels of page table
+ * are cleared.
+ */
+
+#ifndef __HAVE_ARCH_PMD_CLEAR_FLUSH
+#define pmd_clear_flush(__mm, __addr, __pmd)  pmd_clear(__pmd)
+#endif
+
+#ifndef __HAVE_ARCH_PUD_CLEAR_FLUSH
+#define pud_clear_flush(__mm, __addr, __pud)  pud_clear(__pud)
+#endif
+
+#ifndef __HAVE_ARCH_PGD_CLEAR_FLUSH
+#define pgd_clear_flush(__mm, __addr, __pgd)  pgd_clear(__pgd)
+#endif
+
+/*
  * When walking page tables, get the address of the next boundary,
  * or the end address of the range if that comes earlier.  Although no
  * vma end wraps to 0, rounded up __boundary may wrap to 0 throughout.
--- 2.6.15/./include/asm-x86_64/pgtable.h	2006-01-02 21:21:10.000000000 =
-0600
+++ 2.6.15-shpt/./include/asm-x86_64/pgtable.h	2006-01-03 =
10:30:01.000000000 -0600
@@ -101,9 +101,6 @@ static inline void pgd_clear (pgd_t * pg
 	set_pgd(pgd, __pgd(0));
 }
=20
-#define pud_page(pud) \
-((unsigned long) __va(pud_val(pud) & PHYSICAL_PAGE_MASK))
-
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
=20
 struct mm_struct;
@@ -324,7 +321,8 @@ static inline int pmd_large(pmd_t pte) {
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
@@ -332,9 +330,11 @@ static inline int pmd_large(pmd_t pte) {
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
@@ -348,7 +348,7 @@ static inline pud_t *__pud_offset_k(pud_
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
=20
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-#define pmd_offset(dir, address) ((pmd_t *) pud_page(*(dir)) + \
+#define pmd_offset(dir, address) ((pmd_t *) pud_page_kernel(*(dir)) + \
 			pmd_index(address))
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
--- 2.6.15/./include/linux/mm.h	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./include/linux/mm.h	2006-01-03 10:30:01.000000000 -0600
@@ -230,7 +230,7 @@ struct page {
 					 * When page is free, this indicates
 					 * order in the buddy system.
 					 */
-#if NR_CPUS >=3D CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >=3D CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 		spinlock_t ptl;
 #endif
 	} u;
@@ -767,19 +767,20 @@ static inline pmd_t *pmd_alloc(struct mm
 }
 #endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
=20
-#if NR_CPUS >=3D CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >=3D CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 /*
  * We tuck a spinlock to guard each pagetable page into its struct page,
  * at page->private, with BUILD_BUG_ON to make sure that this will not
  * overflow into the next struct page (as it might with DEBUG_SPINLOCK).
  * When freeing, reset page->mapping so free_pages_check won't complain.
  */
-#define __pte_lockptr(page)	&((page)->u.ptl)
+#define __pt_lockptr(page)	&((page)->u.ptl)
+
 #define pte_lock_init(_page)	do {					\
-	spin_lock_init(__pte_lockptr(_page));				\
+	spin_lock_init(__pt_lockptr(_page));				\
 } while (0)
 #define pte_lock_deinit(page)	((page)->mapping =3D NULL)
-#define pte_lockptr(mm, pmd)	({(void)(mm); =
__pte_lockptr(pmd_page(*(pmd)));})
+#define pte_lockptr(mm, pmd)	({(void)(mm); =
__pt_lockptr(pmd_page(*(pmd)));})
 #else
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
--- 2.6.15/./include/linux/sched.h	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./include/linux/sched.h	2006-01-03 10:30:01.000000000 -0600
@@ -249,7 +249,7 @@ arch_get_unmapped_area_topdown(struct fi
 extern void arch_unmap_area(struct mm_struct *, unsigned long);
 extern void arch_unmap_area_topdown(struct mm_struct *, unsigned long);
=20
-#if NR_CPUS >=3D CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >=3D CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 /*
  * The mm counters are not protected by its page_table_lock,
  * so must be incremented atomically.
--- 2.6.15/./include/linux/ptshare.h	1969-12-31 18:00:00.000000000 -0600
+++ 2.6.15-shpt/./include/linux/ptshare.h	2006-01-03 10:30:01.000000000 =
-0600
@@ -0,0 +1,275 @@
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
+static inline int pt_shareable_vma(struct vm_area_struct *vma)
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
+extern void pt_unshare_range(struct vm_area_struct *vma, unsigned long =
address,
+			     unsigned long end);
+#else /* CONFIG_PTSHARE */
+#define	pt_is_shared(page)	(0)
+#define	pt_increment_share(page)
+#define	pt_decrement_share(page)
+#define pt_shareable_vma(vma)	(0)
+#define	pt_unshare_range(vma, address, end)
+#endif /* CONFIG_PTSHARE */
+
+#ifdef CONFIG_PTSHARE_PTE
+static inline int pt_is_shared_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page =3D pmd_page(pmdval);
+	return pt_is_shared(page);
+}
+
+static inline void pt_increment_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page =3D pmd_page(pmdval);
+	pt_increment_share(page);
+	return;
+}
+
+static inline void pt_decrement_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page =3D pmd_page(pmdval);
+	pt_decrement_share(page);
+	return;
+}
+
+static inline int pt_shareable_pte(struct vm_area_struct *vma, unsigned =
long address)
+{
+	unsigned long base =3D address & PMD_MASK;
+	unsigned long end =3D base + (PMD_SIZE-1);
+
+	if ((vma->vm_start <=3D base) &&
+	    (vma->vm_end >=3D end))
+		return 1;
+
+	return 0;
+}
+extern pte_t * pt_share_pte(struct vm_area_struct *vma, unsigned long =
address,
+			    pmd_t *pmd, struct address_space *mapping);
+extern void pt_copy_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t =
*src_pmd);
+#else /* CONFIG_PTSHARE_PTE */
+static inline int pt_is_shared_pte(pmd_t pmdval)
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
+static inline int pt_is_shared_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page =3D pud_page(pudval);
+	return pt_is_shared(page);
+}
+
+static inline void pt_increment_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page =3D pud_page(pudval);
+	pt_increment_share(page);
+	return;
+}
+
+static inline void pt_decrement_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page =3D pud_page(pudval);
+	pt_decrement_share(page);
+	return;
+}
+
+static inline int pt_shareable_pmd(struct vm_area_struct *vma,
+		 unsigned long address)
+{
+	unsigned long base =3D address & PUD_MASK;
+	unsigned long end =3D base + (PUD_SIZE-1);
+
+	if ((vma->vm_start <=3D base) &&
+	    (vma->vm_end >=3D end))
+		return 1;
+
+	return 0;
+}
+extern pmd_t * pt_share_pmd(struct vm_area_struct *vma, unsigned long =
address,
+			    pud_t *pud, struct address_space *mapping);
+extern void pt_copy_pmd(struct mm_struct *mm, pud_t *dst_pud, pud_t =
*src_pud);
+#else /* CONFIG_PTSHARE_PMD */
+static inline int pt_is_shared_pmd(pud_t pudval)
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
+static inline int pt_is_shared_pud(pgd_t pgdval)
+{
+	struct page *page;
+
+	page =3D pgd_page(pgdval);
+	return pt_is_shared(page);
+}
+
+static inline void pt_increment_pud(pgd_t pgdval)
+{
+	struct page *page;
+
+	page =3D pgd_page(pgdval);
+	pt_increment_share(page);
+	return;
+}
+
+static inline void pt_decrement_pud(pgd_t pgdval)
+{
+	struct page *page;
+
+	page =3D pgd_page(pgdval);
+	pt_decrement_share(page);
+	return;
+}
+
+static inline int pt_shareable_pud(struct vm_area_struct *vma, unsigned =
long address)
+{
+	unsigned long base =3D address & PGDIR_MASK;
+	unsigned long end =3D base + (PGDIR_SIZE-1);
+
+	if ((vma->vm_start <=3D base) &&
+	    (vma->vm_end >=3D end))
+		return 1;
+
+	return 0;
+}
+extern pud_t *pt_share_pud(struct vm_area_struct *vma, unsigned long =
address,
+			    pgd_t *pgd, struct address_space *mapping);
+extern void pt_copy_pud(struct mm_struct *mm, pgd_t *dst_pgd, pgd_t =
*src_pgd);
+#else /* CONFIG_PTSHARE_PUD */
+static inline int pt_is_shared_pud(pgd_t pgdval)
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
+extern pte_t *pt_share_hugepage(struct mm_struct *mm, struct =
vm_area_struct *vma,
+			       unsigned long address);
+extern void pt_unshare_huge_range(struct vm_area_struct *vma, unsigned =
long address,
+				  unsigned long end);
+#else
+#define	pt_share_hugepage(mm, vma, address)	huge_pte_alloc(mm, address)
+#define	pt_unshare_huge_range(vma, address, end)
+#endif	/* CONFIG_PTSHARE_HUGEPAGE */
+
+/*
+ *  Locking macros...
+ *  All levels of page table at or above the level(s) we share use =
page_table_lock.
+ *  Each level below the share level uses the pt_lockptr in struct page in =
the level
+ *  above.
+ */
+
+#ifdef CONFIG_PTSHARE_PUD
+#define pud_lock_init(pud)	do {					\
+	spin_lock_init(__pt_lockptr(virt_to_page(pud)));		\
+} while (0)
+#define pud_lock_deinit(pud)	((virt_to_page(pud))->mapping =3D NULL)
+#define pud_lockptr(mm, pud)	({(void)(mm); =
__pt_lockptr(virt_to_page(pud));})
+#else
+#define pud_lock_init(pud)	do {} while (0)
+#define pud_lock_deinit(pud)	do {} while (0)
+#define pud_lockptr(mm, pud)	({(void)(pud); &(mm)->page_table_lock;})
+#endif
+#ifdef CONFIG_PTSHARE_PMD
+#define pmd_lock_init(pmd)	do {					\
+	spin_lock_init(__pt_lockptr(virt_to_page(pmd)));		\
+} while (0)
+#define pmd_lock_deinit(pmd)	((virt_to_page(pmd))->mapping =3D NULL)
+#define pmd_lockptr(mm, pmd)	({(void)(mm); =
__pt_lockptr(virt_to_page(pmd));})
+#else
+#define pmd_lock_init(pmd)	do {} while (0)
+#define pmd_lock_deinit(pmd)	do {} while (0)
+#define pmd_lockptr(mm, pmd)	({(void)(pmd); &(mm)->page_table_lock;})
+#endif
+#ifdef CONFIG_PTSHARE_HUGEPAGE
+#define	hugepte_lockptr(mm, pte)	pmd_lockptr(mm, pte)
+#else
+#define hugepte_lockptr(mm, pte)	({(void)(pte); &(mm)->page_table_lock;})
+#endif
+#endif /* _LINUX_PTSHARE_H */
--- 2.6.15/./mm/Makefile	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./mm/Makefile	2006-01-03 10:30:01.000000000 -0600
@@ -20,3 +20,4 @@ obj-$(CONFIG_SHMEM) +=3D shmem.o
 obj-$(CONFIG_TINY_SHMEM) +=3D tiny-shmem.o
 obj-$(CONFIG_MEMORY_HOTPLUG) +=3D memory_hotplug.o
 obj-$(CONFIG_FS_XIP) +=3D filemap_xip.o
+obj-$(CONFIG_PTSHARE) +=3D ptshare.o
--- 2.6.15/./mm/fremap.c	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./mm/fremap.c	2006-01-03 10:30:01.000000000 -0600
@@ -15,6 +15,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
=20
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -193,6 +194,9 @@ asmlinkage long sys_remap_file_pages(uns
 				has_write_lock =3D 1;
 				goto retry;
 			}
+			if (pt_shareable_vma(vma))
+				pt_unshare_range(vma, vma->vm_start, vma->vm_end);
+
 			mapping =3D vma->vm_file->f_mapping;
 			spin_lock(&mapping->i_mmap_lock);
 			flush_dcache_mmap_lock(mapping);
--- 2.6.15/./mm/hugetlb.c	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./mm/hugetlb.c	2006-01-03 10:30:01.000000000 -0600
@@ -11,6 +11,7 @@
 #include <linux/highmem.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
+#include <linux/ptshare.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
=20
@@ -322,6 +323,8 @@ void unmap_hugepage_range(struct vm_area
 	BUG_ON(start & ~HPAGE_MASK);
 	BUG_ON(end & ~HPAGE_MASK);
=20
+	pt_unshare_huge_range(vma, start, end);
+
 	spin_lock(&mm->page_table_lock);
=20
 	/* Update high watermark before we lower rss */
@@ -392,8 +395,9 @@ int hugetlb_fault(struct mm_struct *mm,=20
 	pte_t *pte;
 	struct page *page;
 	struct address_space *mapping;
+	spinlock_t *ptl;
=20
-	pte =3D huge_pte_alloc(mm, address);
+	pte =3D pt_share_hugepage(mm, vma, address);
 	if (!pte)
 		goto out;
=20
@@ -409,7 +413,8 @@ int hugetlb_fault(struct mm_struct *mm,=20
 	if (!page)
 		goto out;
=20
-	spin_lock(&mm->page_table_lock);
+	ptl =3D hugepte_lockptr(mm, pte);
+	spin_lock(ptl);
 	size =3D i_size_read(mapping->host) >> HPAGE_SHIFT;
 	if (idx >=3D size)
 		goto backout;
@@ -420,7 +425,7 @@ int hugetlb_fault(struct mm_struct *mm,=20
=20
 	add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
 	set_huge_pte_at(mm, address, pte, make_huge_pte(vma, page));
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(ptl);
 	unlock_page(page);
 out:
 	return ret;
--- 2.6.15/./mm/memory.c	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./mm/memory.c	2006-01-03 10:30:01.000000000 -0600
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/ptshare.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -82,6 +83,8 @@ EXPORT_SYMBOL(num_physpages);
 EXPORT_SYMBOL(high_memory);
 EXPORT_SYMBOL(vmalloc_earlyreserve);
=20
+#undef	PT_DEBUG
+
 /*
  * If a p?d_bad entry is found while walking page tables, report
  * the error, before resetting entry to p?d_none.  Usually (but
@@ -110,14 +113,25 @@ void pmd_clear_bad(pmd_t *pmd)
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
+static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+			   unsigned long addr)
 {
 	struct page *page =3D pmd_page(*pmd);
-	pmd_clear(pmd);
-	pte_lock_deinit(page);
-	pte_free_tlb(tlb, page);
-	dec_page_state(nr_page_table_pages);
-	tlb->mm->nr_ptes--;
+	pmd_t pmdval=3D *pmd;
+	int share;
+
+	share =3D pt_is_shared_pte(pmdval);
+	if (share)
+		pmd_clear_flush(tlb->mm, addr, pmd);
+	else
+		pmd_clear(pmd);
+
+	pt_decrement_pte(pmdval);
+	if (!share) {
+		pte_lock_deinit(page);
+		pte_free_tlb(tlb, page);
+		dec_page_state(nr_page_table_pages);
+	}
 }
=20
 static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
@@ -125,17 +139,22 @@ static inline void free_pmd_range(struct
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
+			free_pte_range(tlb, pmd, addr);
+		} while (pmd++, addr =3D next, addr !=3D end);
+	}
=20
 	start &=3D PUD_MASK;
 	if (start < floor)
@@ -148,9 +167,21 @@ static inline void free_pmd_range(struct
 	if (end - 1 > ceiling - 1)
 		return;
=20
+#ifdef PT_DEBUG
+	if (share)
+		printk(KERN_DEBUG "Free: Unsharing pmd at address 0x%lx\n", start);
+#endif
 	pmd =3D pmd_offset(pud, start);
-	pud_clear(pud);
-	pmd_free_tlb(tlb, pmd);
+	if (share)
+		pud_clear_flush(tlb->mm, addr, pud);
+	else
+		pud_clear(pud);
+
+	pt_decrement_pmd(pudval);
+	if (!share) {
+		pud_lock_deinit(pmd);
+		pmd_free_tlb(tlb, pmd);
+	}
 }
=20
 static inline void free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
@@ -158,17 +189,22 @@ static inline void free_pud_range(struct
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
@@ -182,8 +218,16 @@ static inline void free_pud_range(struct
 		return;
=20
 	pud =3D pud_offset(pgd, start);
-	pgd_clear(pgd);
-	pud_free_tlb(tlb, pud);
+	if (share)
+		pgd_clear_flush(tlb->mm, addr, pgd);
+	else
+		pgd_clear(pgd);
+
+	pt_decrement_pud(pgdval);
+	if (!share) {
+		pud_lock_deinit(pud);
+		pud_free_tlb(tlb, pud);
+	}
 }
=20
 /*
@@ -292,20 +336,22 @@ void free_pgtables(struct mmu_gather **t
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
 	struct page *new =3D pte_alloc_one(mm, address);
+	spinlock_t *ptl =3D pmd_lockptr(mm, pmd);
+
 	if (!new)
 		return -ENOMEM;
=20
 	pte_lock_init(new);
-	spin_lock(&mm->page_table_lock);
+	spin_lock(ptl);
 	if (pmd_present(*pmd)) {	/* Another has populated it */
 		pte_lock_deinit(new);
 		pte_free(new);
 	} else {
-		mm->nr_ptes++;
 		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
+		pt_increment_pte(*pmd);
 	}
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(ptl);
 	return 0;
 }
=20
@@ -318,8 +364,10 @@ int __pte_alloc_kernel(pmd_t *pmd, unsig
 	spin_lock(&init_mm.page_table_lock);
 	if (pmd_present(*pmd))		/* Another has populated it */
 		pte_free_kernel(new);
-	else
+	else {
 		pmd_populate_kernel(&init_mm, pmd, new);
+		pt_increment_pte(*pmd);
+	}
 	spin_unlock(&init_mm.page_table_lock);
 	return 0;
 }
@@ -518,7 +566,7 @@ again:
=20
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct =
mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end, int shareable)
 {
 	pmd_t *src_pmd, *dst_pmd;
 	unsigned long next;
@@ -531,16 +579,20 @@ static inline int copy_pmd_range(struct=20
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
@@ -553,9 +605,16 @@ static inline int copy_pud_range(struct=20
 		next =3D pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(src_pud))
 			continue;
-		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-						vma, addr, next))
-			return -ENOMEM;
+		if (shareable && pt_shareable_pmd(vma, addr)) {
+			pt_copy_pmd(dst_mm, dst_pud, src_pud);
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Fork: Sharing pmd at address 0x%lx\n", addr);
+#endif
+		} else {
+			if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
+					   vma, addr, next, shareable))
+				return -ENOMEM;
+		}
 	} while (dst_pud++, src_pud++, addr =3D next, addr !=3D end);
 	return 0;
 }
@@ -567,6 +626,7 @@ int copy_page_range(struct mm_struct *ds
 	unsigned long next;
 	unsigned long addr =3D vma->vm_start;
 	unsigned long end =3D vma->vm_end;
+	int shareable;
=20
 	/*
 	 * Don't copy ptes where a page fault will fill them correctly.
@@ -574,7 +634,7 @@ int copy_page_range(struct mm_struct *ds
 	 * readonly mappings. The tradeoff is that copy_page_range is more
 	 * efficient than faulting.
 	 */
-	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_PFNMAP|VM_INSERTPAGE))) =
{
+	if (!(vma->vm_flags & (VM_NONLINEAR|VM_PFNMAP|VM_INSERTPAGE))) {
 		if (!vma->anon_vma)
 			return 0;
 	}
@@ -582,15 +642,21 @@ int copy_page_range(struct mm_struct *ds
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
@@ -610,6 +676,7 @@ static unsigned long zap_pte_range(struc
 	do {
 		pte_t ptent =3D *pte;
 		if (pte_none(ptent)) {
+
 			(*zap_work)--;
 			continue;
 		}
@@ -685,6 +752,15 @@ static inline unsigned long zap_pmd_rang
 	pmd_t *pmd;
 	unsigned long next;
=20
+	if (pt_is_shared_pmd(*pud)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Zap: Unsharing pmd at address 0x%lx\n", addr);
+#endif
+		pt_decrement_pmd(*pud);
+		pud_clear_flush(tlb->mm, addr, pud);
+		return end;
+	}
+
 	pmd =3D pmd_offset(pud, addr);
 	do {
 		next =3D pmd_addr_end(addr, end);
@@ -707,6 +783,12 @@ static inline unsigned long zap_pud_rang
 	pud_t *pud;
 	unsigned long next;
=20
+	if (pt_is_shared_pud(*pgd)) {
+		pt_decrement_pud(*pgd);
+		pgd_clear_flush(tlb->mm, addr, pgd);
+		return end;
+	}
+
 	pud =3D pud_offset(pgd, addr);
 	do {
 		next =3D pud_addr_end(addr, end);
@@ -2223,6 +2305,7 @@ int __handle_mm_fault(struct mm_struct *
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	struct address_space *mapping =3D NULL;
=20
 	__set_current_state(TASK_RUNNING);
=20
@@ -2231,14 +2314,17 @@ int __handle_mm_fault(struct mm_struct *
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		return hugetlb_fault(mm, vma, address, write_access);
=20
+	if (pt_shareable_vma(vma))
+		mapping =3D vma->vm_file->f_dentry->d_inode->i_mapping;
+
 	pgd =3D pgd_offset(mm, address);
-	pud =3D pud_alloc(mm, pgd, address);
+	pud =3D pt_share_pud(vma, address, pgd, mapping);
 	if (!pud)
 		return VM_FAULT_OOM;
-	pmd =3D pmd_alloc(mm, pud, address);
+	pmd =3D pt_share_pmd(vma, address, pud, mapping);
 	if (!pmd)
 		return VM_FAULT_OOM;
-	pte =3D pte_alloc_map(mm, pmd, address);
+	pte =3D pt_share_pte(vma, address, pmd, mapping);
 	if (!pte)
 		return VM_FAULT_OOM;
=20
@@ -2259,8 +2345,11 @@ int __pud_alloc(struct mm_struct *mm, pg
 	spin_lock(&mm->page_table_lock);
 	if (pgd_present(*pgd))		/* Another has populated it */
 		pud_free(new);
-	else
+	else {
+		pud_lock_init(new);
 		pgd_populate(mm, pgd, new);
+		pt_increment_pud(*pgd);
+	}
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
@@ -2280,22 +2369,32 @@ int __pud_alloc(struct mm_struct *mm, pg
 int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	pmd_t *new =3D pmd_alloc_one(mm, address);
+	spinlock_t *ptl;
 	if (!new)
 		return -ENOMEM;
=20
-	spin_lock(&mm->page_table_lock);
 #ifndef __ARCH_HAS_4LEVEL_HACK
+	ptl =3D pud_lockptr(mm, pud);
+	spin_lock(ptl);
 	if (pud_present(*pud))		/* Another has populated it */
 		pmd_free(new);
-	else
+	else {
+		pmd_lock_init(new);
 		pud_populate(mm, pud, new);
+		pt_increment_pmd(*pud);
+	}
 #else
+	ptl =3D &mm->page_table_lock;
+	spin_lock(ptl);
 	if (pgd_present(*pud))		/* Another has populated it */
 		pmd_free(new);
-	else
+	else {
+		pmd_lock_init(new);
 		pgd_populate(mm, pud, new);
+		pt_increment_pmd(*pud);
+	}
 #endif /* __ARCH_HAS_4LEVEL_HACK */
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(ptl);
 	return 0;
 }
 #else
--- 2.6.15/./mm/mmap.c	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./mm/mmap.c	2006-01-03 10:30:01.000000000 -0600
@@ -1953,7 +1953,6 @@ void exit_mmap(struct mm_struct *mm)
 	while (vma)
 		vma =3D remove_vma(vma);
=20
-	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
 }
=20
 /* Insert vm structure into process list sorted by address
--- 2.6.15/./mm/mprotect.c	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./mm/mprotect.c	2006-01-03 10:30:01.000000000 -0600
@@ -19,6 +19,7 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -115,6 +116,9 @@ mprotect_fixup(struct vm_area_struct *vm
 		return 0;
 	}
=20
+	if (pt_shareable_vma(vma))
+		pt_unshare_range(vma, start, end);
+
 	/*
 	 * If we make a private mapping writable we increase our commit;
 	 * but (without finer accounting) cannot reduce our commit if we
--- 2.6.15/./mm/mremap.c	2006-01-02 21:21:10.000000000 -0600
+++ 2.6.15-shpt/./mm/mremap.c	2006-01-03 10:30:01.000000000 -0600
@@ -17,6 +17,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
=20
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -165,6 +166,9 @@ static unsigned long move_vma(struct vm_
 	unsigned long hiwater_vm;
 	int split =3D 0;
=20
+	if (pt_shareable_vma(vma))
+		pt_unshare_range(vma, old_addr, old_addr + old_len);
+
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
--- 2.6.15/./mm/ptshare.c	1969-12-31 18:00:00.000000000 -0600
+++ 2.6.15-shpt/./mm/ptshare.c	2006-01-03 10:30:01.000000000 -0600
@@ -0,0 +1,415 @@
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
+#define	VM_PGEND(vma)	(((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) -1)
+
+#ifndef __PAGETABLE_PMD_FOLDED
+static void pt_unshare_pmd(struct mm_struct *mm, pud_t *pud, unsigned long =
address,
+			   unsigned long end)
+{
+	pmd_t *pmd;
+	pmd_t pmdval;
+
+	pmd =3D pmd_offset(pud, address);
+	end =3D pud_addr_end(address, end);
+	while (address <=3D end) {
+		pmdval =3D *pmd;
+		if (pmd_present(*pmd)) {
+			if (pt_is_shared_pte(pmdval)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Unsharing pte page at address 0x%lx\n",
+				       address);
+#endif
+				pt_decrement_pte(pmdval);
+				pmd_clear_flush(mm, address, pmd);
+			}
+		}
+		pmd++;
+		address +=3D PMD_SIZE;
+	}
+}
+
+#ifndef __PAGETABLE_PUD_FOLDED
+static void pt_unshare_pud(struct mm_struct *mm, pgd_t *pgd, unsigned long =
address,
+			   unsigned long end, int hugepage)
+{
+	pud_t *pud;
+	pud_t pudval;
+
+	pud =3D pud_offset(pgd, address);
+	end =3D pgd_addr_end(address, end);
+	while (address <=3D end) {
+		pudval =3D *pud;
+		if (pud_present(pudval)) {
+			if (pt_is_shared_pmd(pudval)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Unsharing pmd page at address 0x%lx\n",
+				       address);
+#endif
+				pt_decrement_pmd(pudval);
+				pud_clear_flush(mm, address, pud);
+			} else if (!hugepage) {
+				pt_unshare_pmd(mm, pud, address, end);
+			}
+		}
+		pud++;
+		address +=3D PUD_SIZE;
+	}
+}
+#endif /* __PAGETABLE_PUD_FOLDED */
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+static void pt_unshare_pgd(struct mm_struct *mm, unsigned long address,
+			   unsigned long end, int hugepage)
+{
+	pgd_t *pgd;
+	pgd_t pgdval;
+
+	pgd =3D pgd_offset(mm, address);
+
+	while (address <=3D end) {
+		pgdval =3D *pgd;
+		if (pgd_present(pgdval)) {
+			if (pt_is_shared_pud(pgdval)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Unsharing pud page at address 0x%lx\n",
+				       address);
+#endif
+				pt_decrement_pud(pgdval);
+				pgd_clear_flush(mm, address, pgd);
+#ifndef __PAGETABLE_PMD_FOLDED
+			} else {
+#ifndef __PAGETABLE_PUD_FOLDED
+				pt_unshare_pud(mm, pgd, address, end, hugepage);
+#else /* __PAGETABLE_PUD_FOLDED */
+				if (!hugepage)
+					pt_unshare_pmd(mm, (pud_t *)pgd, address, end);
+#endif /* __PAGETABLE_PUD_FOLDED */
+#endif /* __PAGETABLE_PMD_FOLDED */
+			}
+		}
+		pgd++;
+		address +=3D PGDIR_SIZE;
+	}
+}
+
+void pt_unshare_range(struct vm_area_struct *vma, unsigned long address,
+		      unsigned long end)
+{
+	struct address_space *mapping;
+
+	mapping =3D vma->vm_file->f_dentry->d_inode->i_mapping;
+	spin_lock(&mapping->i_mmap_lock);
+
+	pt_unshare_pgd(vma->vm_mm, address, end, 0);
+
+	spin_unlock(&mapping->i_mmap_lock);
+}
+
+static struct vm_area_struct *next_shareable_vma(struct vm_area_struct =
*vma,
+						 struct vm_area_struct *svma,
+						 struct prio_tree_iter *iter)
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
+pte_t *pt_share_pte(struct vm_area_struct *vma, unsigned long address, =
pmd_t *pmd,
+		    struct address_space *mapping)
+{
+	struct prio_tree_iter iter;
+	struct vm_area_struct *svma =3D NULL;
+	pgd_t *spgd, spgde;
+	pud_t *spud, spude;
+	pmd_t *spmd, spmde;
+	pte_t *pte;
+	struct page *page;
+	spinlock_t *ptl;
+
+	pmd_val(spmde) =3D 0;
+	page =3D NULL;
+	if (pmd_none(*pmd) &&
+	    mapping &&
+	    pt_shareable_pte(vma, address)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Looking for shareable pte page at address 0x%lx\n",
+		       address);
+#endif
+		spin_lock(&mapping->i_mmap_lock);
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_pgoff, VM_PGEND(vma));
+
+		while ((svma =3D next_shareable_vma(vma, svma, &iter))) {
+			spgd =3D pgd_offset(svma->vm_mm, address);
+			spgde =3D *spgd;
+			if (pgd_none(spgde))
+				continue;
+
+			spud =3D pud_offset(&spgde, address);
+			spude =3D *spud;
+			if (pud_none(spude))
+				continue;
+
+			spmd =3D pmd_offset(&spude, address);
+			spmde =3D *spmd;
+			if (pmd_none(spmde))
+				continue;
+
+			page =3D pmd_page(spmde);
+			pt_increment_share(page);
+			break;
+		}
+		spin_unlock(&mapping->i_mmap_lock);
+		if (pmd_present(spmde)) {
+			ptl =3D pmd_lockptr(vma->vm_mm, pmd);
+			spin_lock(ptl);
+			if (pmd_none(*pmd)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Sharing pte page at address 0x%lx\n",
+				       address);
+#endif
+				pmd_populate(vma->vm_mm, pmd, page);
+			} else {
+				pt_decrement_share(page);
+			}
+			spin_unlock(ptl);
+		}
+
+	}
+	pte =3D pte_alloc_map(vma->vm_mm, pmd, address);
+
+	return pte;
+}
+
+void pt_copy_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd)
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
+pmd_t *pt_share_pmd(struct vm_area_struct *vma, unsigned long address, =
pud_t *pud,
+		    struct address_space *mapping)
+{
+	struct prio_tree_iter iter;
+	struct vm_area_struct *svma =3D NULL;
+	pgd_t *spgd, spgde;
+	pud_t *spud, spude;
+	pmd_t *pmd;
+	struct page *page;
+	spinlock_t *ptl;
+
+	pud_val(spude) =3D 0;
+	page =3D NULL;
+	if (pud_none(*pud) &&
+	    mapping &&=20
+	    pt_shareable_pmd(vma, address)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Looking for shareable pmd page at address 0x%lx\n",
+		       address);
+#endif
+		spin_lock(&mapping->i_mmap_lock);
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_pgoff, VM_PGEND(vma));
+
+		while ((svma =3D next_shareable_vma(vma, svma, &iter))) {
+			spgd =3D pgd_offset(svma->vm_mm, address);
+			spgde =3D *spgd;
+			if (pgd_none(spgde))
+				continue;
+
+			spud =3D pud_offset(spgd, address);
+			spude =3D *spud;
+			if (pud_none(spude))
+				continue;
+
+			page =3D pud_page(spude);
+			pt_increment_share(page);
+			break;
+		}
+		spin_unlock(&mapping->i_mmap_lock);
+		if (pud_present(spude)) {
+			ptl =3D pud_lockptr(vma->vm_mm, pud);
+			spin_lock(ptl);
+			if (pud_none(*pud)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Sharing pmd page at address 0x%lx\n",
+				       address);
+#endif
+				pud_populate(vma->vm_mm, pud,
+					     (pmd_t *)pud_page_kernel(spude));
+			} else {
+				pt_decrement_share(page);
+			}
+			spin_unlock(ptl);
+		}
+	}
+	pmd =3D pmd_alloc(vma->vm_mm, pud, address);
+
+	return pmd;
+}
+
+void pt_copy_pmd(struct mm_struct *mm, pud_t *dst_pud, pud_t *src_pud)
+{
+	struct page *page;
+
+	pud_populate(mm, dst_pud, (pmd_t *)pud_page_kernel(*src_pud));
+
+	page =3D pud_page(*src_pud);
+	pt_increment_share(page);
+}
+#endif
+
+#ifdef CONFIG_PTSHARE_PUD
+pud_t *pt_share_pud(struct vm_area_struct *vma, unsigned long address, =
pgd_t *pgd,
+		    struct address_space *mapping)
+{
+	struct prio_tree_iter iter;
+	struct vm_area_struct *svma =3D NULL;
+	pgd_t *spgd, spgde;
+	pud_t *pud;
+	struct page *page;
+
+	spged =3D pgd_val(0);
+	page =3D NULL;
+	if (pgd_none(*pgd) &&
+	    mapping &&=20
+	    pt_shareable_pud(vma, address)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Looking for shareable pud page at address 0x%lx\n",
+		       address);
+#endif
+		spin_lock(&mapping->i_mmap_lock);
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_pgoff, VM_PGEND(vma));
+
+		while ((svma =3D next_shareable_vma(vma, svma, &iter))) {
+			spgd =3D pgd_offset(svma->vm_mm, address);
+			spgde =3D *spgd;
+			if (pgd_none(spgde))
+				continue;
+
+			page =3D pgd_page(spgde);
+			pt_increment_share(page);
+			break;
+		}
+		spin_unlock(&mapping->i_mmap_lock);
+		if (pgd_present(spgde)) {
+			spin_lock(&vma->vm_mm->page_table_lock);
+			if (pgd_none(*pgd)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Sharing pud page at address 0x%lx\n",
+				       address);
+#endif
+				pgd_populate(vma->vm_mm, pgd,
+					     (pud_t *)pgd_page_kernel(spgde));
+			} else {
+				pt_decrement_share(page);
+			}
+			spin_unlock(vma->vm_mm->page_table_lock);
+		}
+	}
+	pud =3D pud_alloc(vma->vm_mm, pgd, address);
+	
+	return pud;
+}
+
+void pt_copy_pud(struct mm_struct *mm, pgd_t *dst_pgd, pgd_t *src_pgd)
+{
+	struct page *page;
+
+	pgd_populate(mm, dst_pgd, (pud_t *)pgd_page_kernel(*src_pgd));
+
+	page =3D pgd_page(*src_pgd);
+	pt_increment_share(page);
+}
+#endif
+
+#ifdef CONFIG_PTSHARE_HUGEPAGE
+
+void pt_unshare_huge_range(struct vm_area_struct *vma, unsigned long =
address,
+			   unsigned long end)
+{
+	struct address_space *mapping;
+
+	mapping =3D vma->vm_file->f_dentry->d_inode->i_mapping;
+	spin_lock(&mapping->i_mmap_lock);
+
+#ifdef CONFIG_PTSHARE_HUGEPAGE_PTE
+	pt_unshare_pgd(vma->vm_mm, address, end, 0);
+#else
+	pt_unshare_pgd(vma->vm_mm, address, end, 1);
+#endif
+
+	spin_unlock(&mapping->i_mmap_lock);
+}
+
+pte_t *pt_share_hugepage(struct mm_struct *mm, struct vm_area_struct *vma,
+			 unsigned long address)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
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
+	pmd =3D pt_share_pmd(vma, address, pud, mapping);
+	if (!pmd)
+		return NULL;
+
+#ifdef CONFIG_PTSHARE_HUGEPAGE_PTE
+	pte =3D pt_share_pte(vma, address, pmd, mapping);
+#else
+	pte =3D (pte_t *)pmd;
+#endif
+	return pte;
+}
+#endif

--==========450962CA3D9EF5351328==========--

