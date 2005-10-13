Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVJMBYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVJMBYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVJMBYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:24:44 -0400
Received: from gold.veritas.com ([143.127.12.110]:56341 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964856AbVJMBYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:24:43 -0400
Date: Thu, 13 Oct 2005 02:23:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 21/21] mm: follow_page with inner ptlock
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130223020.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:24:43.0070 (UTC) FILETIME=[E39C2DE0:01C5CF94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Final step in pushing down common core's page_table_lock.  follow_page
no longer wants caller to hold page_table_lock, uses pte_offset_map_lock
itself; and so no page_table_lock is taken in get_user_pages itself.

But get_user_pages (and get_futex_key) do then need follow_page to pin
the page for them: take Daniel's suggestion of bitflags to follow_page.

Need one for WRITE, another for TOUCH (it was the accessed flag before:
vanished along with check_user_page_readable, but surely get_numa_maps
is wrong to mark every page it finds as accessed), another for GET.

And another, ANON to dispose of untouched_anonymous_page: it seems silly
for that to descend a second time, let follow_page observe if there was
no page table and return ZERO_PAGE if so.  Fix minor bug in that: check
VM_LOCKED - make_pages_present ought to make readonly anonymous present.

Give get_numa_maps a cond_resched while we're there.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/proc/task_mmu.c |    3 -
 include/linux/mm.h |   20 ++++--
 kernel/futex.c     |    6 --
 mm/memory.c        |  152 ++++++++++++++++++++++++-----------------------------
 mm/nommu.c         |    3 -
 5 files changed, 88 insertions(+), 96 deletions(-)

--- mm20/fs/proc/task_mmu.c	2005-10-11 23:57:10.000000000 +0100
+++ mm21/fs/proc/task_mmu.c	2005-10-11 23:58:59.000000000 +0100
@@ -419,7 +419,6 @@ static struct numa_maps *get_numa_maps(c
 	for_each_node(i)
 		md->node[i] =0;
 
-	spin_lock(&mm->page_table_lock);
  	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
 		page = follow_page(mm, vaddr, 0);
 		if (page) {
@@ -434,8 +433,8 @@ static struct numa_maps *get_numa_maps(c
 				md->anon++;
 			md->node[page_to_nid(page)]++;
 		}
+		cond_resched();
 	}
-	spin_unlock(&mm->page_table_lock);
 	return md;
 }
 
--- mm20/include/linux/mm.h	2005-10-11 23:58:43.000000000 +0100
+++ mm21/include/linux/mm.h	2005-10-11 23:58:59.000000000 +0100
@@ -946,14 +946,18 @@ static inline unsigned long vma_pages(st
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
-extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
-
-extern struct page * vmalloc_to_page(void *addr);
-extern unsigned long vmalloc_to_pfn(void *addr);
-extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
-		int write);
-int remap_pfn_range(struct vm_area_struct *, unsigned long,
-		unsigned long, unsigned long, pgprot_t);
+struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
+struct page *vmalloc_to_page(void *addr);
+unsigned long vmalloc_to_pfn(void *addr);
+int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
+			unsigned long pfn, unsigned long size, pgprot_t);
+
+struct page *follow_page(struct mm_struct *, unsigned long address,
+			unsigned int foll_flags);
+#define FOLL_WRITE	0x01	/* check pte is writable */
+#define FOLL_TOUCH	0x02	/* mark page accessed */
+#define FOLL_GET	0x04	/* do get_page on page */
+#define FOLL_ANON	0x08	/* give ZERO_PAGE if no pgtable */
 
 #ifdef CONFIG_PROC_FS
 void vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
--- mm20/kernel/futex.c	2005-09-21 12:16:59.000000000 +0100
+++ mm21/kernel/futex.c	2005-10-11 23:58:59.000000000 +0100
@@ -205,15 +205,13 @@ static int get_futex_key(unsigned long u
 	/*
 	 * Do a quick atomic lookup first - this is the fastpath.
 	 */
-	spin_lock(&current->mm->page_table_lock);
-	page = follow_page(mm, uaddr, 0);
+	page = follow_page(mm, uaddr, FOLL_TOUCH|FOLL_GET);
 	if (likely(page != NULL)) {
 		key->shared.pgoff =
 			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-		spin_unlock(&current->mm->page_table_lock);
+		put_page(page);
 		return 0;
 	}
-	spin_unlock(&current->mm->page_table_lock);
 
 	/*
 	 * Do it the general way.
--- mm20/mm/memory.c	2005-10-11 23:58:43.000000000 +0100
+++ mm21/mm/memory.c	2005-10-11 23:58:59.000000000 +0100
@@ -807,86 +807,82 @@ unsigned long zap_page_range(struct vm_a
 
 /*
  * Do a quick page-table lookup for a single page.
- * mm->page_table_lock must be held.
  */
-struct page *follow_page(struct mm_struct *mm, unsigned long address, int write)
+struct page *follow_page(struct mm_struct *mm, unsigned long address,
+			unsigned int flags)
 {
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
+	spinlock_t *ptl;
 	unsigned long pfn;
 	struct page *page;
 
-	page = follow_huge_addr(mm, address, write);
-	if (! IS_ERR(page))
-		return page;
+	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
+	if (!IS_ERR(page)) {
+		BUG_ON(flags & FOLL_GET);
+		goto out;
+	}
 
+	page = NULL;
 	pgd = pgd_offset(mm, address);
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		goto out;
+		goto no_page_table;
 
 	pud = pud_offset(pgd, address);
 	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
-		goto out;
+		goto no_page_table;
 	
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		goto no_page_table;
+
+	if (pmd_huge(*pmd)) {
+		BUG_ON(flags & FOLL_GET);
+		page = follow_huge_pmd(mm, address, pmd, flags & FOLL_WRITE);
 		goto out;
-	if (pmd_huge(*pmd))
-		return follow_huge_pmd(mm, address, pmd, write);
+	}
 
-	ptep = pte_offset_map(pmd, address);
+	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!ptep)
 		goto out;
 
 	pte = *ptep;
-	pte_unmap(ptep);
-	if (pte_present(pte)) {
-		if (write && !pte_write(pte))
-			goto out;
-		pfn = pte_pfn(pte);
-		if (pfn_valid(pfn)) {
-			page = pfn_to_page(pfn);
-			if (write && !pte_dirty(pte) &&!PageDirty(page))
-				set_page_dirty(page);
-			mark_page_accessed(page);
-			return page;
-		}
-	}
+	if (!pte_present(pte))
+		goto unlock;
+	if ((flags & FOLL_WRITE) && !pte_write(pte))
+		goto unlock;
+	pfn = pte_pfn(pte);
+	if (!pfn_valid(pfn))
+		goto unlock;
 
+	page = pfn_to_page(pfn);
+	if (flags & FOLL_GET)
+		get_page(page);
+	if (flags & FOLL_TOUCH) {
+		if ((flags & FOLL_WRITE) &&
+		    !pte_dirty(pte) && !PageDirty(page))
+			set_page_dirty(page);
+		mark_page_accessed(page);
+	}
+unlock:
+	pte_unmap_unlock(ptep, ptl);
 out:
-	return NULL;
-}
-
-static inline int
-untouched_anonymous_page(struct mm_struct* mm, struct vm_area_struct *vma,
-			 unsigned long address)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	/* Check if the vma is for an anonymous mapping. */
-	if (vma->vm_ops && vma->vm_ops->nopage)
-		return 0;
-
-	/* Check if page directory entry exists. */
-	pgd = pgd_offset(mm, address);
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return 1;
-
-	pud = pud_offset(pgd, address);
-	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
-		return 1;
-
-	/* Check if page middle directory entry exists. */
-	pmd = pmd_offset(pud, address);
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		return 1;
+	return page;
 
-	/* There is a pte slot for 'address' in 'mm'. */
-	return 0;
+no_page_table:
+	/*
+	 * When core dumping an enormous anonymous area that nobody
+	 * has touched so far, we don't want to allocate page tables.
+	 */
+	if (flags & FOLL_ANON) {
+		page = ZERO_PAGE(address);
+		if (flags & FOLL_GET)
+			get_page(page);
+		BUG_ON(flags & FOLL_WRITE);
+	}
+	return page;
 }
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
@@ -894,18 +890,19 @@ int get_user_pages(struct task_struct *t
 		struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
-	unsigned int flags;
+	unsigned int vm_flags;
 
 	/* 
 	 * Require read or write permissions.
 	 * If 'force' is set, we only require the "MAY" flags.
 	 */
-	flags = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
-	flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
+	vm_flags  = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
+	vm_flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
 	i = 0;
 
 	do {
-		struct vm_area_struct *	vma;
+		struct vm_area_struct *vma;
+		unsigned int foll_flags;
 
 		vma = find_extend_vma(mm, start);
 		if (!vma && in_gate_area(tsk, start)) {
@@ -946,7 +943,7 @@ int get_user_pages(struct task_struct *t
 		}
 
 		if (!vma || (vma->vm_flags & (VM_IO | VM_RESERVED))
-				|| !(flags & vma->vm_flags))
+				|| !(vm_flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
 		if (is_vm_hugetlb_page(vma)) {
@@ -954,29 +951,25 @@ int get_user_pages(struct task_struct *t
 						&start, &len, i);
 			continue;
 		}
-		spin_lock(&mm->page_table_lock);
+
+		foll_flags = FOLL_TOUCH;
+		if (pages)
+			foll_flags |= FOLL_GET;
+		if (!write && !(vma->vm_flags & VM_LOCKED) &&
+		    (!vma->vm_ops || !vma->vm_ops->nopage))
+			foll_flags |= FOLL_ANON;
+
 		do {
-			int write_access = write;
 			struct page *page;
 
-			cond_resched_lock(&mm->page_table_lock);
-			while (!(page = follow_page(mm, start, write_access))) {
-				int ret;
-
-				/*
-				 * Shortcut for anonymous pages. We don't want
-				 * to force the creation of pages tables for
-				 * insanely big anonymously mapped areas that
-				 * nobody touched so far. This is important
-				 * for doing a core dump for these mappings.
-				 */
-				if (!write && untouched_anonymous_page(mm,vma,start)) {
-					page = ZERO_PAGE(start);
-					break;
-				}
-				spin_unlock(&mm->page_table_lock);
-				ret = __handle_mm_fault(mm, vma, start, write_access);
+			if (write)
+				foll_flags |= FOLL_WRITE;
 
+			cond_resched();
+			while (!(page = follow_page(mm, start, foll_flags))) {
+				int ret;
+				ret = __handle_mm_fault(mm, vma, start,
+						foll_flags & FOLL_WRITE);
 				/*
 				 * The VM_FAULT_WRITE bit tells us that do_wp_page has
 				 * broken COW when necessary, even if maybe_mkwrite
@@ -984,7 +977,7 @@ int get_user_pages(struct task_struct *t
 				 * subsequent page lookups as if they were reads.
 				 */
 				if (ret & VM_FAULT_WRITE)
-					write_access = 0;
+					foll_flags &= ~FOLL_WRITE;
 				
 				switch (ret & ~VM_FAULT_WRITE) {
 				case VM_FAULT_MINOR:
@@ -1000,12 +993,10 @@ int get_user_pages(struct task_struct *t
 				default:
 					BUG();
 				}
-				spin_lock(&mm->page_table_lock);
 			}
 			if (pages) {
 				pages[i] = page;
 				flush_dcache_page(page);
-				page_cache_get(page);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -1013,7 +1004,6 @@ int get_user_pages(struct task_struct *t
 			start += PAGE_SIZE;
 			len--;
 		} while (len && start < vma->vm_end);
-		spin_unlock(&mm->page_table_lock);
 	} while (len);
 	return i;
 }
--- mm20/mm/nommu.c	2005-10-11 23:54:33.000000000 +0100
+++ mm21/mm/nommu.c	2005-10-11 23:58:59.000000000 +0100
@@ -1046,7 +1046,8 @@ struct vm_area_struct *find_vma(struct m
 
 EXPORT_SYMBOL(find_vma);
 
-struct page * follow_page(struct mm_struct *mm, unsigned long addr, int write)
+struct page *follow_page(struct mm_struct *mm, unsigned long address,
+			unsigned int foll_flags)
 {
 	return NULL;
 }
