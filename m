Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWDJQNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWDJQNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWDJQNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 12:13:24 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:60918 "EHLO
	ms-smtp-03.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751084AbWDJQNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 12:13:22 -0400
Subject: [RFC/PATCH] Shared Page Tables [2/2]
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 11:13:13 -0500
Message-Id: <1144685593.570.37.camel@wildcat.int.mccr.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Share page tables when possible.

Signed-off-by: Dave McCracken <dmccr@us.ibm.com>

----

 arch/i386/Kconfig             |   12 +
 arch/s390/Kconfig             |   22 +
 arch/x86_64/Kconfig           |   22 +
 include/asm-generic/pgtable.h |   31 ++
 include/linux/mm.h            |   12 -
 include/linux/ptshare.h       |  175 +++++++++++++++
 include/linux/rmap.h          |    2 
 include/linux/sched.h         |    2 
 mm/Makefile                   |    1 
 mm/filemap_xip.c              |    3 
 mm/fremap.c                   |    6 
 mm/hugetlb.c                  |   54 +++-
 mm/memory.c                   |   39 ++-
 mm/mmap.c                     |    3 
 mm/mprotect.c                 |   10 
 mm/mremap.c                   |    7 
 mm/ptshare.c                  |  463 ++++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c                     |   21 +
 18 files changed, 846 insertions(+), 39 deletions(-)

----

--- 2.6.17-rc1-macro/./arch/i386/Kconfig	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./arch/i386/Kconfig	2006-04-10 08:46:01.000000000 -0500
@@ -512,6 +512,18 @@ config X86_PAE
 	depends on HIGHMEM64G
 	default y
 
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
--- 2.6.17-rc1-macro/./arch/s390/Kconfig	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./arch/s390/Kconfig	2006-04-10 08:46:01.000000000 -0500
@@ -218,6 +218,28 @@ config WARN_STACK_SIZE
 
 source "mm/Kconfig"
 
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
+	depends on PTSHARE && 64BIT
+	default y
+
+endmenu
+
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
--- 2.6.17-rc1-macro/./arch/x86_64/Kconfig	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./arch/x86_64/Kconfig	2006-04-10 08:46:01.000000000 -0500
@@ -302,6 +302,28 @@ config NUMA_EMU
 	  into virtual nodes when booted with "numa=fake=N", where N is the
 	  number of nodes. This is only useful for debugging.
 
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
+config PTSHARE_PMD
+	bool
+	depends on PTSHARE
+	default y
+
+config PTSHARE_HUGEPAGE
+	bool
+	depends on PTSHARE && PTSHARE_PMD
+	default y
+
 config ARCH_DISCONTIGMEM_ENABLE
        bool
        depends on NUMA
--- 2.6.17-rc1-macro/./include/asm-generic/pgtable.h	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./include/asm-generic/pgtable.h	2006-04-10 08:46:01.000000000 -0500
@@ -127,6 +127,16 @@ do {									\
 })
 #endif
 
+#ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH_ALL
+#define ptep_clear_flush_all(__vma, __address, __ptep)			\
+({									\
+	pte_t __pte;							\
+	__pte = ptep_get_and_clear((__vma)->vm_mm, __address, __ptep);	\
+	flush_tlb_all();				\
+	__pte;								\
+})
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
@@ -173,6 +183,27 @@ static inline void ptep_set_wrprotect(st
 #endif
 
 /*
+ * Some architectures might need flushes when higher levels of page table
+ * are unshared.
+ */
+
+#ifndef __HAVE_ARCH_PMD_CLEAR_FLUSH
+#define pmd_clear_flush(__mm, __addr, __pmd)				\
+({									\
+	pmd_clear(__pmd);						\
+	flush_tlb_all();						\
+})
+#endif
+
+#ifndef __HAVE_ARCH_PUD_CLEAR_FLUSH
+#define pud_clear_flush(__mm, __addr, __pud)				\
+({									\
+	pud_clear(__pud);						\
+	flush_tlb_all();						\
+})
+#endif
+
+/*
  * When walking page tables, get the address of the next boundary,
  * or the end address of the range if that comes earlier.  Although no
  * vma end wraps to 0, rounded up __boundary may wrap to 0 throughout.
--- 2.6.17-rc1-macro/./include/linux/mm.h	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./include/linux/mm.h	2006-04-10 08:46:01.000000000 -0500
@@ -166,6 +166,8 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
+#define VM_TRANSITION	0x04000000	/* The vma is in transition (mprotect, mremap, etc) */
+#define VM_PTSHARE	0x08000000	/* This vma has shared one or more page tables */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
@@ -242,7 +244,7 @@ struct page {
 						 * see PAGE_MAPPING_ANON below.
 						 */
 	    };
-#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 	    spinlock_t ptl;
 #endif
 	};
@@ -815,19 +817,19 @@ static inline pmd_t *pmd_alloc(struct mm
 }
 #endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
 
-#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 /*
  * We tuck a spinlock to guard each pagetable page into its struct page,
  * at page->private, with BUILD_BUG_ON to make sure that this will not
  * overflow into the next struct page (as it might with DEBUG_SPINLOCK).
  * When freeing, reset page->mapping so free_pages_check won't complain.
  */
-#define __pte_lockptr(page)	&((page)->ptl)
+#define __pt_lockptr(page)	&((page)->ptl)
 #define pte_lock_init(_page)	do {					\
-	spin_lock_init(__pte_lockptr(_page));				\
+	spin_lock_init(__pt_lockptr(_page));				\
 } while (0)
 #define pte_lock_deinit(page)	((page)->mapping = NULL)
-#define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(*(pmd)));})
+#define pte_lockptr(mm, pmd)	({(void)(mm); __pt_lockptr(pmd_page(*(pmd)));})
 #else
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
--- 2.6.17-rc1-macro/./include/linux/rmap.h	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./include/linux/rmap.h	2006-04-10 08:46:01.000000000 -0500
@@ -98,7 +98,7 @@ void remove_from_swap(struct page *page)
  * Called from mm/filemap_xip.c to unmap empty zero page
  */
 pte_t *page_check_address(struct page *, struct mm_struct *,
-				unsigned long, spinlock_t **);
+				unsigned long, spinlock_t **, int *);
 
 /*
  * Used by swapoff to help locate where page is expected in vma.
--- 2.6.17-rc1-macro/./include/linux/sched.h	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./include/linux/sched.h	2006-04-10 08:46:01.000000000 -0500
@@ -254,7 +254,7 @@ arch_get_unmapped_area_topdown(struct fi
 extern void arch_unmap_area(struct mm_struct *, unsigned long);
 extern void arch_unmap_area_topdown(struct mm_struct *, unsigned long);
 
-#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 /*
  * The mm counters are not protected by its page_table_lock,
  * so must be incremented atomically.
--- 2.6.17-rc1-macro/./include/linux/ptshare.h	1969-12-31 18:00:00.000000000 -0600
+++ 2.6.17-rc1-shpt/./include/linux/ptshare.h	2006-04-10 08:46:01.000000000 -0500
@@ -0,0 +1,175 @@
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
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2005
+ *
+ * Author: Dave McCracken <dmccr@us.ibm.com>
+ */
+
+#undef	PT_DEBUG
+
+#ifdef CONFIG_PTSHARE
+static inline int pt_is_shared(struct page *page)
+{
+	return (page_mapcount(page) > 0);
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
+static inline int pt_vmashared(struct vm_area_struct *vma) {
+	return vma->vm_flags & VM_PTSHARE;
+}
+extern void pt_unshare_range(struct vm_area_struct *vma, unsigned long address,
+			     unsigned long end);
+#else /* CONFIG_PTSHARE */
+#define pt_is_shared(page)	(0)
+#define pt_increment_share(page)
+#define pt_decrement_share(page)
+#define pt_vmashared(vma) 0
+#define pt_unshare_range(vma, address, end)
+#endif /* CONFIG_PTSHARE */
+
+#ifdef CONFIG_PTSHARE_PTE
+static inline int pt_is_shared_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page = pmd_page(pmdval);
+	return pt_is_shared(page);
+}
+
+static inline void pt_increment_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page = pmd_page(pmdval);
+	pt_increment_share(page);
+}
+
+static inline void pt_decrement_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page = pmd_page(pmdval);
+	pt_decrement_share(page);
+}
+
+extern pte_t * pt_share_pte(struct vm_area_struct *vma, unsigned long address,
+			    pmd_t *pmd);
+extern int pt_check_unshare_pte(struct mm_struct *mm, unsigned long address,
+				pmd_t *pmd);
+#else /* CONFIG_PTSHARE_PTE */
+static inline int pt_is_shared_pte(pmd_t pmdval)
+{
+	return 0;
+}
+static inline int pt_check_unshare_pte(struct mm_struct *mm, unsigned long address,
+				       pmd_t *pmd)
+{
+	return 0;
+}
+#define pt_increment_pte(pmdval)
+#define pt_decrement_pte(pmdval)
+#define pt_share_pte(vma, address, pmd) pte_alloc_map(vma->vm_mm, pmd, address)
+#endif /* CONFIG_PTSHARE_PTE */
+
+#ifdef CONFIG_PTSHARE_PMD
+static inline int pt_is_shared_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page = pud_page(pudval);
+	return pt_is_shared(page);
+}
+
+static inline void pt_increment_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page = pud_page(pudval);
+	pt_increment_share(page);
+}
+
+static inline void pt_decrement_pmd(pud_t pudval)
+{
+	struct page *page;
+
+	page = pud_page(pudval);
+	pt_decrement_share(page);
+}
+extern pmd_t * pt_share_pmd(struct vm_area_struct *vma, unsigned long address,
+			    pud_t *pud);
+extern int pt_check_unshare_pmd(struct mm_struct *mm, unsigned long address,
+				pud_t *pud);
+#else /* CONFIG_PTSHARE_PMD */
+static inline int pt_is_shared_pmd(pud_t pudval)
+{
+	return 0;
+}
+static inline int pt_check_unshare_pmd(struct mm_struct *mm, unsigned long address,
+				       pud_t *pud)
+{
+	return 0;
+}
+#define pt_increment_pmd(pudval)
+#define pt_decrement_pmd(pudval)
+#define pt_share_pmd(vma, address, pud) pmd_alloc(vma->vm_mm, pud, address)
+#endif /* CONFIG_PTSHARE_PMD */
+
+#ifdef CONFIG_PTSHARE_HUGEPAGE
+extern pte_t *pt_share_hugepage(struct mm_struct *mm, struct vm_area_struct *vma,
+			       unsigned long address);
+extern void pt_unshare_huge_range(struct vm_area_struct *vma, unsigned long address,
+				  unsigned long end);
+#else
+#define pt_share_hugepage(mm, vma, address)	huge_pte_alloc(mm, address)
+#define pt_unshare_huge_range(vma, address, end)
+#endif	/* CONFIG_PTSHARE_HUGEPAGE */
+
+/*
+ *  Locking macros...
+ *  All levels of page table at or above the level(s) we share use page_table_lock.
+ *  Each level below the share level uses the pt_lockptr in struct page in the level
+ *  above.
+ */
+
+#ifdef CONFIG_PTSHARE_PMD
+#define pmd_lock_init(pmd)	do {					\
+	spin_lock_init(__pt_lockptr(virt_to_page(pmd)));		\
+} while (0)
+#define pmd_lock_deinit(pmd)	((virt_to_page(pmd))->mapping = NULL)
+#define pmd_lockptr(mm, pmd)	({(void)(mm); __pt_lockptr(virt_to_page(pmd));})
+#else
+#define pmd_lock_init(pmd)	do {} while (0)
+#define pmd_lock_deinit(pmd)	do {} while (0)
+#define pmd_lockptr(mm, pmd)	({(void)(pmd); &(mm)->page_table_lock;})
+#endif
+#ifdef CONFIG_PTSHARE_HUGEPAGE
+#define hugepte_lockptr(mm, pte)	pmd_lockptr(mm, pte)
+#else
+#define hugepte_lockptr(mm, pte)	({(void)(pte); &(mm)->page_table_lock;})
+#endif
+#endif /* _LINUX_PTSHARE_H */
--- 2.6.17-rc1-macro/./mm/Makefile	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/Makefile	2006-04-10 08:47:12.000000000 -0500
@@ -23,4 +23,5 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_PTSHARE) += ptshare.o
 
--- 2.6.17-rc1-macro/./mm/filemap_xip.c	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/filemap_xip.c	2006-04-10 08:46:01.000000000 -0500
@@ -174,6 +174,7 @@ __xip_unmap (struct address_space * mapp
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
+	int shared;
 	spinlock_t *ptl;
 	struct page *page;
 
@@ -184,7 +185,7 @@ __xip_unmap (struct address_space * mapp
 			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 		page = ZERO_PAGE(address);
-		pte = page_check_address(page, mm, address, &ptl);
+		pte = page_check_address(page, mm, address, &ptl, &shared);
 		if (pte) {
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
--- 2.6.17-rc1-macro/./mm/fremap.c	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/fremap.c	2006-04-10 08:46:01.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
 
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -193,6 +194,10 @@ asmlinkage long sys_remap_file_pages(uns
 				has_write_lock = 1;
 				goto retry;
 			}
+			vma->vm_flags |= VM_TRANSITION;
+			if (pt_vmashared(vma))
+				pt_unshare_range(vma, vma->vm_start, vma->vm_end);
+
 			mapping = vma->vm_file->f_mapping;
 			spin_lock(&mapping->i_mmap_lock);
 			flush_dcache_mmap_lock(mapping);
@@ -201,6 +206,7 @@ asmlinkage long sys_remap_file_pages(uns
 			vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
 			flush_dcache_mmap_unlock(mapping);
 			spin_unlock(&mapping->i_mmap_lock);
+			vma->vm_flags &= ~VM_TRANSITION;
 		}
 
 		err = vma->vm_ops->populate(vma, start, size,
--- 2.6.17-rc1-macro/./mm/hugetlb.c	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/hugetlb.c	2006-04-10 09:05:39.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/highmem.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
+#include <linux/ptshare.h>
 #include <linux/mempolicy.h>
 #include <linux/cpuset.h>
 #include <linux/mutex.h>
@@ -437,6 +438,7 @@ int copy_hugetlb_page_range(struct mm_st
 	struct page *ptepage;
 	unsigned long addr;
 	int cow;
+	spinlock_t *src_ptl, *dst_ptl;
 
 	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
@@ -447,8 +449,10 @@ int copy_hugetlb_page_range(struct mm_st
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		spin_lock(&dst->page_table_lock);
-		spin_lock(&src->page_table_lock);
+		dst_ptl = hugepte_lockptr(dst, dst_pte);
+		src_ptl = hugepte_lockptr(src, src_pte);
+		spin_lock(dst_ptl);
+		spin_lock(src_ptl);
 		if (!pte_none(*src_pte)) {
 			if (cow)
 				ptep_set_wrprotect(src, addr, src_pte);
@@ -458,8 +462,8 @@ int copy_hugetlb_page_range(struct mm_st
 			add_mm_counter(dst, file_rss, HPAGE_SIZE / PAGE_SIZE);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		}
-		spin_unlock(&src->page_table_lock);
-		spin_unlock(&dst->page_table_lock);
+		spin_unlock(src_ptl);
+		spin_unlock(dst_ptl);
 	}
 	return 0;
 
@@ -475,12 +479,14 @@ void unmap_hugepage_range(struct vm_area
 	pte_t *ptep;
 	pte_t pte;
 	struct page *page;
+	spinlock_t *ptl = NULL, *new_ptl;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~HPAGE_MASK);
 	BUG_ON(end & ~HPAGE_MASK);
 
-	spin_lock(&mm->page_table_lock);
+	if (pt_vmashared(vma))
+		pt_unshare_huge_range(vma, start, end);
 
 	/* Update high watermark before we lower rss */
 	update_hiwater_rss(mm);
@@ -490,6 +496,13 @@ void unmap_hugepage_range(struct vm_area
 		if (!ptep)
 			continue;
 
+		new_ptl = hugepte_lockptr(mm, ptep);
+		if (new_ptl != ptl) {
+			if (ptl)
+				spin_unlock(ptl);
+			ptl = new_ptl;
+			spin_lock(ptl);
+		}
 		pte = huge_ptep_get_and_clear(mm, address, ptep);
 		if (pte_none(pte))
 			continue;
@@ -499,12 +512,15 @@ void unmap_hugepage_range(struct vm_area
 		add_mm_counter(mm, file_rss, (int) -(HPAGE_SIZE / PAGE_SIZE));
 	}
 
-	spin_unlock(&mm->page_table_lock);
+	if (ptl)
+		spin_unlock(ptl);
+
 	flush_tlb_range(vma, start, end);
 }
 
 static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long address, pte_t *ptep, pte_t pte)
+			unsigned long address, pte_t *ptep, pte_t pte,
+		       spinlock_t *ptl)
 {
 	struct page *old_page, *new_page;
 	int avoidcopy;
@@ -527,9 +543,9 @@ static int hugetlb_cow(struct mm_struct 
 		return VM_FAULT_OOM;
 	}
 
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(ptl);
 	copy_huge_page(new_page, old_page, address);
-	spin_lock(&mm->page_table_lock);
+	spin_lock(ptl);
 
 	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
 	if (likely(pte_same(*ptep, pte))) {
@@ -553,6 +569,7 @@ int hugetlb_no_page(struct mm_struct *mm
 	struct page *page;
 	struct address_space *mapping;
 	pte_t new_pte;
+	spinlock_t *ptl;
 
 	mapping = vma->vm_file->f_mapping;
 	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
@@ -590,7 +607,8 @@ retry:
 			lock_page(page);
 	}
 
-	spin_lock(&mm->page_table_lock);
+	ptl = hugepte_lockptr(mm, ptep);
+	spin_lock(ptl);
 	size = i_size_read(mapping->host) >> HPAGE_SHIFT;
 	if (idx >= size)
 		goto backout;
@@ -606,16 +624,16 @@ retry:
 
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_cow(mm, vma, address, ptep, new_pte);
+		ret = hugetlb_cow(mm, vma, address, ptep, new_pte, ptl);
 	}
 
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(ptl);
 	unlock_page(page);
 out:
 	return ret;
 
 backout:
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(ptl);
 	hugetlb_put_quota(mapping);
 	unlock_page(page);
 	put_page(page);
@@ -628,9 +646,10 @@ int hugetlb_fault(struct mm_struct *mm, 
 	pte_t *ptep;
 	pte_t entry;
 	int ret;
+	spinlock_t *ptl;
 	static DEFINE_MUTEX(hugetlb_instantiation_mutex);
 
-	ptep = huge_pte_alloc(mm, address);
+	ptep = pt_share_hugepage(mm, vma, address & HPAGE_MASK);
 	if (!ptep)
 		return VM_FAULT_OOM;
 
@@ -649,12 +668,13 @@ int hugetlb_fault(struct mm_struct *mm, 
 
 	ret = VM_FAULT_MINOR;
 
-	spin_lock(&mm->page_table_lock);
+	ptl = hugepte_lockptr(mm, ptep);
+	spin_lock(ptl);
 	/* Check for a racing update before calling hugetlb_cow */
 	if (likely(pte_same(entry, *ptep)))
 		if (write_access && !pte_write(entry))
-			ret = hugetlb_cow(mm, vma, address, ptep, entry);
-	spin_unlock(&mm->page_table_lock);
+			ret = hugetlb_cow(mm, vma, address, ptep, entry, ptl);
+	spin_unlock(ptl);
 	mutex_unlock(&hugetlb_instantiation_mutex);
 
 	return ret;
--- 2.6.17-rc1-macro/./mm/memory.c	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/memory.c	2006-04-10 08:46:01.000000000 -0500
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/ptshare.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -144,6 +145,10 @@ static inline void free_pmd_range(struct
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
+		if (pt_is_shared_pte(*pmd)) {
+			if (pt_check_unshare_pte(tlb->mm, addr, pmd))
+				continue;
+		}
 		free_pte_range(tlb, pmd);
 	} while (pmd++, addr = next, addr != end);
 
@@ -160,6 +165,7 @@ static inline void free_pmd_range(struct
 
 	pmd = pmd_offset(pud, start);
 	pud_clear(pud);
+	pmd_lock_deinit(pmd);
 	pmd_free_tlb(tlb, pmd);
 }
 
@@ -177,6 +183,10 @@ static inline void free_pud_range(struct
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
+		if (pt_is_shared_pmd(*pud)) {
+			if (pt_check_unshare_pmd(tlb->mm, addr, pud))
+				continue;
+		}
 		free_pmd_range(tlb, pud, addr, next, floor, ceiling);
 	} while (pud++, addr = next, addr != end);
 
@@ -301,20 +311,21 @@ void free_pgtables(struct mmu_gather **t
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
 	struct page *new = pte_alloc_one(mm, address);
+	spinlock_t *ptl = pmd_lockptr(mm, pmd);
+
 	if (!new)
 		return -ENOMEM;
 
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
 	}
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(ptl);
 	return 0;
 }
 
@@ -581,7 +592,7 @@ int copy_page_range(struct mm_struct *ds
 	 * readonly mappings. The tradeoff is that copy_page_range is more
 	 * efficient than faulting.
 	 */
-	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_PFNMAP|VM_INSERTPAGE))) {
+	if (!(vma->vm_flags & (VM_NONLINEAR|VM_PFNMAP|VM_INSERTPAGE))) {
 		if (!vma->anon_vma)
 			return 0;
 	}
@@ -613,6 +624,10 @@ static unsigned long zap_pte_range(struc
 	int file_rss = 0;
 	int anon_rss = 0;
 
+	if (pt_is_shared_pte(*pmd)) {
+		if (pt_check_unshare_pte(mm, addr, pmd))
+			return end;
+	}
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
 		pte_t ptent = *pte;
@@ -694,6 +709,10 @@ static inline unsigned long zap_pmd_rang
 	unsigned long next;
 
 	pmd = pmd_offset(pud, addr);
+	if (pt_is_shared_pmd(*pud)) {
+		if (pt_check_unshare_pmd(tlb->mm, addr, pud))
+			return end;
+	}
 	do {
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd)) {
@@ -2272,10 +2291,10 @@ int __handle_mm_fault(struct mm_struct *
 	pud = pud_alloc(mm, pgd, address);
 	if (!pud)
 		return VM_FAULT_OOM;
-	pmd = pmd_alloc(mm, pud, address);
+	pmd = pt_share_pmd(vma, address, pud);
 	if (!pmd)
 		return VM_FAULT_OOM;
-	pte = pte_alloc_map(mm, pmd, address);
+	pte = pt_share_pte(vma, address, pmd);
 	if (!pte)
 		return VM_FAULT_OOM;
 
@@ -2326,13 +2345,17 @@ int __pmd_alloc(struct mm_struct *mm, pu
 #ifndef __ARCH_HAS_4LEVEL_HACK
 	if (pud_present(*pud))		/* Another has populated it */
 		pmd_free(new);
-	else
+	else {
+		pmd_lock_init(new);
 		pud_populate(mm, pud, new);
+	}
 #else
 	if (pgd_present(*pud))		/* Another has populated it */
 		pmd_free(new);
-	else
+	else {
+		pmd_lock_init(new);
 		pgd_populate(mm, pud, new);
+	}
 #endif /* __ARCH_HAS_4LEVEL_HACK */
 	spin_unlock(&mm->page_table_lock);
 	return 0;
--- 2.6.17-rc1-macro/./mm/mmap.c	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/mmap.c	2006-04-10 08:46:01.000000000 -0500
@@ -1706,6 +1706,8 @@ int split_vma(struct mm_struct * mm, str
 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;
 
+	new->vm_flags &= ~VM_TRANSITION;
+
 	if (new_below)
 		new->vm_end = addr;
 	else {
@@ -1941,7 +1943,6 @@ void exit_mmap(struct mm_struct *mm)
 	while (vma)
 		vma = remove_vma(vma);
 
-	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
 }
 
 /* Insert vm structure into process list sorted by address
--- 2.6.17-rc1-macro/./mm/mprotect.c	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/mprotect.c	2006-04-10 08:46:01.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -115,6 +116,10 @@ mprotect_fixup(struct vm_area_struct *vm
 		return 0;
 	}
 
+	vma->vm_flags |= VM_TRANSITION;
+	if (pt_vmashared(vma))
+		pt_unshare_range(vma, start, end);
+
 	/*
 	 * If we make a private mapping writable we increase our commit;
 	 * but (without finer accounting) cannot reduce our commit if we
@@ -126,8 +131,10 @@ mprotect_fixup(struct vm_area_struct *vm
 	if (newflags & VM_WRITE) {
 		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
 			charged = nrpages;
-			if (security_vm_enough_memory(charged))
+			if (security_vm_enough_memory(charged)) {
+				vma->vm_flags &= ~VM_TRANSITION;
 				return -ENOMEM;
+			}
 			newflags |= VM_ACCOUNT;
 		}
 	}
@@ -175,6 +182,7 @@ success:
 	return 0;
 
 fail:
+	vma->vm_flags &= ~VM_TRANSITION;
 	vm_unacct_memory(charged);
 	return error;
 }
--- 2.6.17-rc1-macro/./mm/mremap.c	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/mremap.c	2006-04-10 08:46:01.000000000 -0500
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -178,6 +179,10 @@ static unsigned long move_vma(struct vm_
 	if (!new_vma)
 		return -ENOMEM;
 
+	vma->vm_flags |= VM_TRANSITION;
+	if (pt_vmashared(vma))
+		pt_unshare_range(vma, old_addr, old_addr + old_len);
+
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len);
 	if (moved_len < old_len) {
 		/*
@@ -221,6 +226,8 @@ static unsigned long move_vma(struct vm_
 	}
 	mm->hiwater_vm = hiwater_vm;
 
+	vma->vm_flags &= ~VM_TRANSITION;
+
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
 	if (excess) {
 		vma->vm_flags |= VM_ACCOUNT;
--- 2.6.17-rc1-macro/./mm/rmap.c	2006-04-02 22:22:10.000000000 -0500
+++ 2.6.17-rc1-shpt/./mm/rmap.c	2006-04-10 08:46:01.000000000 -0500
@@ -53,6 +53,7 @@
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
 #include <linux/module.h>
+#include <linux/ptshare.h>
 
 #include <asm/tlbflush.h>
 
@@ -286,7 +287,8 @@ unsigned long page_address_in_vma(struct
  * On success returns with pte mapped and locked.
  */
 pte_t *page_check_address(struct page *page, struct mm_struct *mm,
-			  unsigned long address, spinlock_t **ptlp)
+			  unsigned long address, spinlock_t **ptlp,
+			  int *shared)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -306,6 +308,9 @@ pte_t *page_check_address(struct page *p
 	if (!pmd_present(*pmd))
 		return NULL;
 
+	if (pt_is_shared_pmd(*pud))
+		*shared++;
+
 	pte = pte_offset_map(pmd, address);
 	/* Make a quick check before getting the lock */
 	if (!pte_present(*pte)) {
@@ -313,6 +318,9 @@ pte_t *page_check_address(struct page *p
 		return NULL;
 	}
 
+	if (pt_is_shared_pte(*pmd))
+		*shared++;
+
 	ptl = pte_lockptr(mm, pmd);
 	spin_lock(ptl);
 	if (pte_present(*pte) && page_to_pfn(page) == pte_pfn(*pte)) {
@@ -333,6 +341,7 @@ static int page_referenced_one(struct pa
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
 	pte_t *pte;
+	int shared;
 	spinlock_t *ptl;
 	int referenced = 0;
 
@@ -340,7 +349,7 @@ static int page_referenced_one(struct pa
 	if (address == -EFAULT)
 		goto out;
 
-	pte = page_check_address(page, mm, address, &ptl);
+	pte = page_check_address(page, mm, address, &ptl, &shared);
 	if (!pte)
 		goto out;
 
@@ -584,6 +593,7 @@ static int try_to_unmap_one(struct page 
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
+	int shared = 0;
 	spinlock_t *ptl;
 	int ret = SWAP_AGAIN;
 
@@ -591,7 +601,7 @@ static int try_to_unmap_one(struct page 
 	if (address == -EFAULT)
 		goto out;
 
-	pte = page_check_address(page, mm, address, &ptl);
+	pte = page_check_address(page, mm, address, &ptl, &shared);
 	if (!pte)
 		goto out;
 
@@ -609,7 +619,10 @@ static int try_to_unmap_one(struct page 
 
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address, page_to_pfn(page));
-	pteval = ptep_clear_flush(vma, address, pte);
+	if (shared)
+		pteval = ptep_clear_flush_all(vma, address, pte);
+	else
+		pteval = ptep_clear_flush(vma, address, pte);
 
 	/* Move the dirty bit to the physical page now the pte is gone. */
 	if (pte_dirty(pteval))
--- 2.6.17-rc1-macro/./mm/ptshare.c	1969-12-31 18:00:00.000000000 -0600
+++ 2.6.17-rc1-shpt/./mm/ptshare.c	2006-04-10 08:46:01.000000000 -0500
@@ -0,0 +1,463 @@
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
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
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
+#include <asm/tlbflush.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+#define VM_PGEND(vma)	(((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) -1)
+
+#define	VMFLAG_COMPARE	(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)
+
+static int pt_shareable_vma(struct vm_area_struct *vma)
+{
+	/* We can't share anonymous memory */
+	if (!vma->vm_file)
+		return 0;
+
+	/* No sharing of nonlinear areas or vmas in transition */
+	if (vma->vm_flags & (VM_NONLINEAR|VM_TRANSITION|VM_PFNMAP|VM_INSERTPAGE))
+		return 0;
+
+	/* Only share shared mappings or read-only mappings */
+	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) == VM_WRITE)
+		return 0;
+
+	/* If it's smaller than the smallest shareable unit, don't bother
+	   calling it shareable */
+	if ((vma->vm_end - vma->vm_start) < PMD_SIZE)
+		return 0;
+
+	return 1;
+}
+
+#ifdef CONFIG_PTSHARE_PTE
+static inline void pt_unshare_pte(struct mm_struct *mm, pmd_t *pmd,
+				  unsigned long address)
+{
+	struct page *page;
+	spinlock_t *ptl;
+
+	if (pmd_present(*pmd)) {
+		page = pmd_page(*pmd);
+		ptl = __pt_lockptr(page);
+		spin_lock(ptl);
+		if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Unsharing pte page at address 0x%lx\n",
+			       address);
+#endif
+			pt_decrement_share(page);
+			pmd_clear_flush(mm, address, pmd);
+		}
+		spin_unlock(ptl);
+	}
+}
+#endif
+
+#ifndef __PAGETABLE_PMD_FOLDED
+static void pt_unshare_pmd(struct mm_struct *mm, pud_t *pud, unsigned long address,
+			   unsigned long end, int hugepage)
+{
+	if (!pud_present(*pud))
+	    return;
+
+#ifdef CONFIG_PTSHARE_PMD
+	{
+		struct page *page;
+		spinlock_t *ptl;
+
+		page = pud_page(*pud);
+		ptl = __pt_lockptr(page);
+		spin_lock(ptl);
+		if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Unsharing pmd page at address 0x%lx\n",
+			       address);
+#endif
+			pt_decrement_share(page);
+			spin_unlock(ptl);
+			pud_clear_flush(mm, address, pud);
+			return;
+		}
+		spin_unlock(ptl);
+	}
+#endif
+#ifdef CONFIG_PTSHARE_PTE
+	if (hugepage)
+		return;
+
+	{
+		pmd_t *pmd;
+
+		pmd = pmd_offset(pud, address);
+		end = pud_addr_end(address, end);
+		while (address <= end) {
+			pt_unshare_pte(mm, pmd, address);
+			pmd++;
+			address += PMD_SIZE;
+		}
+	}
+#endif
+}
+
+#ifndef __PAGETABLE_PUD_FOLDED
+static void pt_unshare_pud(struct mm_struct *mm, pgd_t *pgd, unsigned long address,
+			   unsigned long end, int hugepage)
+{
+	pud_t *pud;
+
+	if (!pgd_present(*pgd))
+	    return;
+
+	pud = pud_offset(pgd, address);
+	end = pgd_addr_end(address, end);
+	while (address <= end) {
+		pt_unshare_pmd(mm, pud, address, end, hugepage);
+		pud++;
+		address += PUD_SIZE;
+	}
+}
+#endif /* __PAGETABLE_PUD_FOLDED */
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+static void pt_unshare_pgd(struct mm_struct *mm, unsigned long address,
+			   unsigned long end, int hugepage)
+{
+	pgd_t *pgd;
+
+	pgd = pgd_offset(mm, address);
+
+	spin_lock(&mm->page_table_lock);
+	while (address <= end) {
+#ifdef __PAGETABLE_PMD_FOLDED
+		if (!hugepage)
+			pt_unshare_pte(mm, (pmd_t *)pgd, address);
+#else
+#ifdef __PAGETABLE_PUD_FOLDED
+		pt_unshare_pmd(mm, (pud_t *)pgd, address, end, hugepage);
+#else
+		pt_unshare_pud(mm, pgd, address, end, hugepage);
+#endif
+#endif
+		pgd++;
+		address += PGDIR_SIZE;
+	}
+	spin_unlock(&mm->page_table_lock);
+}
+
+void pt_unshare_range(struct vm_area_struct *vma, unsigned long address,
+		      unsigned long end)
+{
+	struct address_space *mapping;
+
+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	spin_lock(&mapping->i_mmap_lock);
+
+	pt_unshare_pgd(vma->vm_mm, address, end, 0);
+
+	spin_unlock(&mapping->i_mmap_lock);
+
+	/* If we unshare the entire vma it's safe to clear the share flag */
+	if (vma->vm_start == address &&
+	    vma->vm_end == end)
+		vma->vm_flags &= ~VM_PTSHARE;
+}
+
+static struct vm_area_struct *next_shareable_vma(struct vm_area_struct *vma,
+						 struct vm_area_struct *svma,
+						 struct prio_tree_iter *iter)
+{
+	while ((svma = vma_prio_tree_next(svma, iter))) {
+		if ((svma != vma) &&
+		    ((vma->vm_flags&VMFLAG_COMPARE) == (svma->vm_flags&VMFLAG_COMPARE)) &&
+		    (vma->vm_start == svma->vm_start) &&
+		    (vma->vm_end == svma->vm_end) &&
+		    (vma->vm_pgoff == svma->vm_pgoff))
+			break;
+	}
+	return svma;
+}
+
+#ifdef CONFIG_PTSHARE_PTE
+static int pt_shareable_pte(struct vm_area_struct *vma, unsigned long address)
+{
+	unsigned long base = address & PMD_MASK;
+	unsigned long end = base + (PMD_SIZE-1);
+
+	if (pt_shareable_vma(vma) &&
+	   (vma->vm_start <= base) &&
+	    (vma->vm_end >= end))
+		return 1;
+
+	return 0;
+}
+
+pte_t *pt_share_pte(struct vm_area_struct *vma, unsigned long address, pmd_t *pmd)
+{
+	struct prio_tree_iter iter;
+	struct vm_area_struct *svma = NULL;
+	pgd_t *spgd, spgde;
+	pud_t *spud, spude;
+	pmd_t *spmd, spmde;
+	pte_t *pte;
+	struct page *page;
+	struct address_space *mapping;
+	spinlock_t *ptl;
+
+	pmd_clear(&spmde);
+	page = NULL;
+	if (pmd_none(*pmd) &&
+	    pt_shareable_pte(vma, address)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Looking for shareable pte page at address 0x%lx\n",
+		       address);
+#endif
+		mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+		spin_lock(&mapping->i_mmap_lock);
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_pgoff, VM_PGEND(vma));
+
+		while ((svma = next_shareable_vma(vma, svma, &iter))) {
+			spgd = pgd_offset(svma->vm_mm, address);
+			spgde = *spgd;
+			if (pgd_none(spgde))
+				continue;
+
+			spud = pud_offset(&spgde, address);
+			spude = *spud;
+			if (pud_none(spude))
+				continue;
+
+			spmd = pmd_offset(&spude, address);
+			spmde = *spmd;
+			if (pmd_none(spmde))
+				continue;
+
+			/* Found a shareable page */
+			page = pmd_page(spmde);
+			pt_increment_share(page);
+			break;
+		}
+		spin_unlock(&mapping->i_mmap_lock);
+		if (pmd_present(spmde)) {
+			ptl = pmd_lockptr(vma->vm_mm, pmd);
+			spin_lock(ptl);
+			if (pmd_none(*pmd)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Sharing pte page at address 0x%lx\n",
+				       address);
+#endif
+				pmd_populate(vma->vm_mm, pmd, page);
+				/* Both vmas now have shared pt */
+				vma->vm_flags |= VM_PTSHARE;
+				svma->vm_flags |= VM_PTSHARE;
+			} else {
+				/* Oops, already mapped... undo it */
+				pt_decrement_share(page);
+			}
+			spin_unlock(ptl);
+		}
+
+	}
+	pte = pte_alloc_map(vma->vm_mm, pmd, address);
+
+	return pte;
+}
+int pt_check_unshare_pte(struct mm_struct *mm, unsigned long address, pmd_t *pmd)
+{
+	struct page *page;
+	spinlock_t *ptl;
+
+	page = pmd_page(*pmd);
+	ptl = __pt_lockptr(page);
+	spin_lock(ptl);
+	/* Doublecheck now that we hold the lock */
+	if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Unsharing pte at address 0x%lx\n",
+		       address);
+#endif
+		pt_decrement_share(page);
+		spin_unlock(ptl);
+		pmd_clear_flush(mm, address, pmd);
+		return 1;
+	}
+	spin_unlock(ptl);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PTSHARE_PMD
+static int pt_shareable_pmd(struct vm_area_struct *vma,
+		 unsigned long address)
+{
+	unsigned long base = address & PUD_MASK;
+	unsigned long end = base + (PUD_SIZE-1);
+
+	if (pt_shareable_vma(vma) &&
+	    (vma->vm_start <= base) &&
+	    (vma->vm_end >= end))
+		return 1;
+
+	return 0;
+}
+
+pmd_t *pt_share_pmd(struct vm_area_struct *vma, unsigned long address, pud_t *pud)
+{
+	struct prio_tree_iter iter;
+	struct mm_struct *mm = vma->vm_mm;
+	struct vm_area_struct *svma = NULL;
+	pgd_t *spgd, spgde;
+	pud_t *spud, spude;
+	pmd_t *pmd;
+	struct page *page;
+	struct address_space *mapping;
+
+	pud_clear(&spude);
+	page = NULL;
+	if (pud_none(*pud) &&
+	    pt_shareable_pmd(vma, address)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Looking for shareable pmd page at address 0x%lx\n",
+		       address);
+#endif
+		mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+
+		spin_lock(&mapping->i_mmap_lock);
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_pgoff, VM_PGEND(vma));
+
+		while ((svma = next_shareable_vma(vma, svma, &iter))) {
+			spgd = pgd_offset(svma->vm_mm, address);
+			spgde = *spgd;
+			if (pgd_none(spgde))
+				continue;
+
+			spud = pud_offset(spgd, address);
+			spude = *spud;
+			if (pud_none(spude))
+				continue;
+
+			/* Found a shareable page */
+			page = pud_page(spude);
+			pt_increment_share(page);
+			break;
+		}
+		spin_unlock(&mapping->i_mmap_lock);
+		if (pud_present(spude)) {
+			spin_lock(&mm->page_table_lock);
+			if (pud_none(*pud)) {
+#ifdef PT_DEBUG
+				printk(KERN_DEBUG "Sharing pmd page at address 0x%lx\n",
+				       address);
+#endif
+				pud_populate(mm, pud,
+					     (pmd_t *)pud_page_kernel(spude));
+				/* These vmas now have shared pt */
+				vma->vm_flags |= VM_PTSHARE;
+				svma->vm_flags |= VM_PTSHARE;
+			} else {
+				/* Oops, already mapped... undo it */
+				pt_decrement_share(page);
+			}
+			spin_unlock(&mm->page_table_lock);
+		}
+	}
+	pmd = pmd_alloc(mm, pud, address);
+
+	return pmd;
+}
+int pt_check_unshare_pmd(struct mm_struct *mm, unsigned long address, pud_t *pud)
+{
+	struct page *page;
+	spinlock_t *ptl;
+
+	page = pud_page(*pud);
+	ptl = __pt_lockptr(page);
+	spin_lock(ptl);
+	/* Doublecheck now that we hold the lock */
+	if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Unsharing pmd at address 0x%lx\n",
+			       address);
+#endif
+		pt_decrement_share(page);
+		spin_unlock(ptl);
+		pud_clear_flush(mm, address, pud);
+		return 1;
+	}
+	spin_unlock(ptl);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PTSHARE_HUGEPAGE
+
+void pt_unshare_huge_range(struct vm_area_struct *vma, unsigned long address,
+			   unsigned long end)
+{
+	struct address_space *mapping;
+
+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	spin_lock(&mapping->i_mmap_lock);
+
+#ifdef CONFIG_PTSHARE_HUGEPAGE_PTE
+	pt_unshare_pgd(vma->vm_mm, address, end, 0);
+#else
+	pt_unshare_pgd(vma->vm_mm, address, end, 1);
+#endif
+
+	spin_unlock(&mapping->i_mmap_lock);
+
+	/* If we unshare the entire vma it's safe to clear the share flag */
+	if (vma->vm_start >= address &&
+	    vma->vm_end <= end)
+		vma->vm_flags &= ~VM_PTSHARE;
+}
+
+pte_t *pt_share_hugepage(struct mm_struct *mm, struct vm_area_struct *vma,
+			 unsigned long address)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, address);
+	pud = pud_alloc(mm, pgd, address);
+	if (!pud)
+		return VM_FAULT_OOM;
+	pmd = pt_share_pmd(vma, address, pud);
+	if (!pmd)
+		return VM_FAULT_OOM;
+#ifdef CONFIG_PTSHARE_HUGEPAGE_PTE
+	pte = pt_share_pte(vma, address, pmd);
+#else
+	pte = (pte_t *)pmd;
+#endif
+	return pte;
+}
+#endif


