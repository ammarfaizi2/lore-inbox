Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVJMA5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVJMA5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVJMA5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:57:10 -0400
Received: from gold.veritas.com ([143.127.12.110]:50706 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964831AbVJMA5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:57:08 -0400
Date: Thu, 13 Oct 2005 01:56:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] mm: ptd_alloc take ptlock
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130155520.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:57:07.0776 (UTC) FILETIME=[08FA5C00:01C5CF91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second step in pushing down the page_table_lock.  Remove the temporary
bridging hack from __pud_alloc, __pmd_alloc, __pte_alloc: expect callers
not to hold page_table_lock, whether it's on init_mm or a user mm; take
page_table_lock internally to check if a racing task already allocated.

Convert their callers from common code.  But avoid coming back to change
them again later: instead of moving the spin_lock(&mm->page_table_lock)
down, switch over to new macros pte_alloc_map_lock and pte_unmap_unlock,
which encapsulate the mapping+locking and unlocking+unmapping together,
and in the end may use alternatives to the mm page_table_lock itself.

These callers all hold mmap_sem (some exclusively, some not), so at no
level can a page table be whipped away from beneath them; and pte_alloc
uses the "atomic" pmd_present to test whether it needs to allocate.  It
appears that on all arches we can safely descend without page_table_lock.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/exec.c          |   14 ++-----
 include/linux/mm.h |   18 +++++++++
 kernel/fork.c      |    2 -
 mm/fremap.c        |   46 ++++++++---------------
 mm/hugetlb.c       |   12 ++++--
 mm/memory.c        |  104 ++++++++++++++++-------------------------------------
 mm/mremap.c        |   27 ++++---------
 7 files changed, 89 insertions(+), 134 deletions(-)

--- mm10/fs/exec.c	2005-10-11 23:54:33.000000000 +0100
+++ mm11/fs/exec.c	2005-10-11 23:56:25.000000000 +0100
@@ -309,25 +309,24 @@ void install_arg_page(struct vm_area_str
 	pud_t * pud;
 	pmd_t * pmd;
 	pte_t * pte;
+	spinlock_t *ptl;
 
 	if (unlikely(anon_vma_prepare(vma)))
-		goto out_sig;
+		goto out;
 
 	flush_dcache_page(page);
 	pgd = pgd_offset(mm, address);
-
-	spin_lock(&mm->page_table_lock);
 	pud = pud_alloc(mm, pgd, address);
 	if (!pud)
 		goto out;
 	pmd = pmd_alloc(mm, pud, address);
 	if (!pmd)
 		goto out;
-	pte = pte_alloc_map(mm, pmd, address);
+	pte = pte_alloc_map_lock(mm, pmd, address, &ptl);
 	if (!pte)
 		goto out;
 	if (!pte_none(*pte)) {
-		pte_unmap(pte);
+		pte_unmap_unlock(pte, ptl);
 		goto out;
 	}
 	inc_mm_counter(mm, anon_rss);
@@ -335,14 +334,11 @@ void install_arg_page(struct vm_area_str
 	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
 	page_add_anon_rmap(page, vma, address);
-	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(pte, ptl);
 
 	/* no need for flush_tlb */
 	return;
 out:
-	spin_unlock(&mm->page_table_lock);
-out_sig:
 	__free_page(page);
 	force_sig(SIGKILL, current);
 }
--- mm10/include/linux/mm.h	2005-10-11 23:56:11.000000000 +0100
+++ mm11/include/linux/mm.h	2005-10-11 23:56:25.000000000 +0100
@@ -784,10 +784,28 @@ static inline pmd_t *pmd_alloc(struct mm
 }
 #endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
 
+#define pte_offset_map_lock(mm, pmd, address, ptlp)	\
+({							\
+	spinlock_t *__ptl = &(mm)->page_table_lock;	\
+	pte_t *__pte = pte_offset_map(pmd, address);	\
+	*(ptlp) = __ptl;				\
+	spin_lock(__ptl);				\
+	__pte;						\
+})
+
+#define pte_unmap_unlock(pte, ptl)	do {		\
+	spin_unlock(ptl);				\
+	pte_unmap(pte);					\
+} while (0)
+
 #define pte_alloc_map(mm, pmd, address)			\
 	((unlikely(!pmd_present(*(pmd))) && __pte_alloc(mm, pmd, address))? \
 		NULL: pte_offset_map(pmd, address))
 
+#define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
+	((unlikely(!pmd_present(*(pmd))) && __pte_alloc(mm, pmd, address))? \
+		NULL: pte_offset_map_lock(mm, pmd, address, ptlp))
+
 #define pte_alloc_kernel(pmd, address)			\
 	((unlikely(!pmd_present(*(pmd))) && __pte_alloc_kernel(pmd, address))? \
 		NULL: pte_offset_kernel(pmd, address))
--- mm10/kernel/fork.c	2005-09-30 11:59:12.000000000 +0100
+++ mm11/kernel/fork.c	2005-10-11 23:56:25.000000000 +0100
@@ -255,7 +255,6 @@ static inline int dup_mmap(struct mm_str
 		/*
 		 * Link in the new vma and copy the page table entries.
 		 */
-		spin_lock(&mm->page_table_lock);
 		*pprev = tmp;
 		pprev = &tmp->vm_next;
 
@@ -265,7 +264,6 @@ static inline int dup_mmap(struct mm_str
 
 		mm->map_count++;
 		retval = copy_page_range(mm, oldmm, tmp);
-		spin_unlock(&mm->page_table_lock);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
--- mm10/mm/fremap.c	2005-10-11 23:54:33.000000000 +0100
+++ mm11/mm/fremap.c	2005-10-11 23:56:25.000000000 +0100
@@ -63,23 +63,20 @@ int install_page(struct mm_struct *mm, s
 	pud_t *pud;
 	pgd_t *pgd;
 	pte_t pte_val;
+	spinlock_t *ptl;
 
 	BUG_ON(vma->vm_flags & VM_RESERVED);
 
 	pgd = pgd_offset(mm, addr);
-	spin_lock(&mm->page_table_lock);
-	
 	pud = pud_alloc(mm, pgd, addr);
 	if (!pud)
-		goto err_unlock;
-
+		goto out;
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
-		goto err_unlock;
-
-	pte = pte_alloc_map(mm, pmd, addr);
+		goto out;
+	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
-		goto err_unlock;
+		goto out;
 
 	/*
 	 * This page may have been truncated. Tell the
@@ -89,7 +86,7 @@ int install_page(struct mm_struct *mm, s
 	inode = vma->vm_file->f_mapping->host;
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if (!page->mapping || page->index >= size)
-		goto err_unlock;
+		goto unlock;
 
 	if (pte_none(*pte) || !zap_pte(mm, vma, addr, pte))
 		inc_mm_counter(mm, file_rss);
@@ -98,17 +95,15 @@ int install_page(struct mm_struct *mm, s
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
 	pte_val = *pte;
-	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
-
 	err = 0;
-err_unlock:
-	spin_unlock(&mm->page_table_lock);
+unlock:
+	pte_unmap_unlock(pte, ptl);
+out:
 	return err;
 }
 EXPORT_SYMBOL(install_page);
 
-
 /*
  * Install a file pte to a given virtual memory address, release any
  * previously existing mapping.
@@ -122,23 +117,20 @@ int install_file_pte(struct mm_struct *m
 	pud_t *pud;
 	pgd_t *pgd;
 	pte_t pte_val;
+	spinlock_t *ptl;
 
 	BUG_ON(vma->vm_flags & VM_RESERVED);
 
 	pgd = pgd_offset(mm, addr);
-	spin_lock(&mm->page_table_lock);
-	
 	pud = pud_alloc(mm, pgd, addr);
 	if (!pud)
-		goto err_unlock;
-
+		goto out;
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
-		goto err_unlock;
-
-	pte = pte_alloc_map(mm, pmd, addr);
+		goto out;
+	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
-		goto err_unlock;
+		goto out;
 
 	if (!pte_none(*pte) && zap_pte(mm, vma, addr, pte)) {
 		update_hiwater_rss(mm);
@@ -147,17 +139,13 @@ int install_file_pte(struct mm_struct *m
 
 	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
 	pte_val = *pte;
-	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
-	spin_unlock(&mm->page_table_lock);
-	return 0;
-
-err_unlock:
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(pte, ptl);
+	err = 0;
+out:
 	return err;
 }
 
-
 /***
  * sys_remap_file_pages - remap arbitrary pages of a shared backing store
  *                        file within an existing vma.
--- mm10/mm/hugetlb.c	2005-10-11 23:54:33.000000000 +0100
+++ mm11/mm/hugetlb.c	2005-10-11 23:56:25.000000000 +0100
@@ -276,12 +276,15 @@ int copy_hugetlb_page_range(struct mm_st
 	unsigned long addr;
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte)
+			continue;
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
+		spin_lock(&dst->page_table_lock);
 		spin_lock(&src->page_table_lock);
-		src_pte = huge_pte_offset(src, addr);
-		if (src_pte && !pte_none(*src_pte)) {
+		if (!pte_none(*src_pte)) {
 			entry = *src_pte;
 			ptepage = pte_page(entry);
 			get_page(ptepage);
@@ -289,6 +292,7 @@ int copy_hugetlb_page_range(struct mm_st
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		}
 		spin_unlock(&src->page_table_lock);
+		spin_unlock(&dst->page_table_lock);
 	}
 	return 0;
 
@@ -353,7 +357,6 @@ int hugetlb_prefault(struct address_spac
 
 	hugetlb_prefault_arch_hook(mm);
 
-	spin_lock(&mm->page_table_lock);
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
@@ -388,11 +391,12 @@ int hugetlb_prefault(struct address_spac
 				goto out;
 			}
 		}
+		spin_lock(&mm->page_table_lock);
 		add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
 		set_huge_pte_at(mm, addr, pte, make_huge_pte(vma, page));
+		spin_unlock(&mm->page_table_lock);
 	}
 out:
-	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
 
--- mm10/mm/memory.c	2005-10-11 23:56:11.000000000 +0100
+++ mm11/mm/memory.c	2005-10-11 23:56:25.000000000 +0100
@@ -282,14 +282,11 @@ void free_pgtables(struct mmu_gather **t
 
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
-	struct page *new;
-
-	spin_unlock(&mm->page_table_lock);
-	new = pte_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
+	struct page *new = pte_alloc_one(mm, address);
 	if (!new)
 		return -ENOMEM;
 
+	spin_lock(&mm->page_table_lock);
 	if (pmd_present(*pmd))		/* Another has populated it */
 		pte_free(new);
 	else {
@@ -297,6 +294,7 @@ int __pte_alloc(struct mm_struct *mm, pm
 		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
+	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
 
@@ -344,9 +342,6 @@ void print_bad_pte(struct vm_area_struct
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.
- *
- * dst->page_table_lock is held on entry and exit,
- * but may be dropped within p[mg]d_alloc() and pte_alloc_map().
  */
 
 static inline void
@@ -419,17 +414,19 @@ static int copy_pte_range(struct mm_stru
 		unsigned long addr, unsigned long end)
 {
 	pte_t *src_pte, *dst_pte;
+	spinlock_t *src_ptl, *dst_ptl;
 	int progress = 0;
 	int rss[2];
 
 again:
 	rss[1] = rss[0] = 0;
-	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
+	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
 	if (!dst_pte)
 		return -ENOMEM;
 	src_pte = pte_offset_map_nested(src_pmd, addr);
+	src_ptl = &src_mm->page_table_lock;
+	spin_lock(src_ptl);
 
-	spin_lock(&src_mm->page_table_lock);
 	do {
 		/*
 		 * We are holding two locks at this point - either of them
@@ -438,8 +435,8 @@ again:
 		if (progress >= 32) {
 			progress = 0;
 			if (need_resched() ||
-			    need_lockbreak(&src_mm->page_table_lock) ||
-			    need_lockbreak(&dst_mm->page_table_lock))
+			    need_lockbreak(src_ptl) ||
+			    need_lockbreak(dst_ptl))
 				break;
 		}
 		if (pte_none(*src_pte)) {
@@ -449,12 +446,12 @@ again:
 		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma, addr, rss);
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
-	spin_unlock(&src_mm->page_table_lock);
 
+	spin_unlock(src_ptl);
 	pte_unmap_nested(src_pte - 1);
-	pte_unmap(dst_pte - 1);
 	add_mm_rss(dst_mm, rss[0], rss[1]);
-	cond_resched_lock(&dst_mm->page_table_lock);
+	pte_unmap_unlock(dst_pte - 1, dst_ptl);
+	cond_resched();
 	if (addr != end)
 		goto again;
 	return 0;
@@ -1049,8 +1046,9 @@ static int zeromap_pte_range(struct mm_s
 			unsigned long addr, unsigned long end, pgprot_t prot)
 {
 	pte_t *pte;
+	spinlock_t *ptl;
 
-	pte = pte_alloc_map(mm, pmd, addr);
+	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
 	do {
@@ -1062,7 +1060,7 @@ static int zeromap_pte_range(struct mm_s
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, zero_pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(pte - 1);
+	pte_unmap_unlock(pte - 1, ptl);
 	return 0;
 }
 
@@ -1112,14 +1110,12 @@ int zeromap_page_range(struct vm_area_st
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
-	spin_lock(&mm->page_table_lock);
 	do {
 		next = pgd_addr_end(addr, end);
 		err = zeromap_pud_range(mm, pgd, addr, next, prot);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
-	spin_unlock(&mm->page_table_lock);
 	return err;
 }
 
@@ -1133,8 +1129,9 @@ static int remap_pte_range(struct mm_str
 			unsigned long pfn, pgprot_t prot)
 {
 	pte_t *pte;
+	spinlock_t *ptl;
 
-	pte = pte_alloc_map(mm, pmd, addr);
+	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
 	do {
@@ -1142,7 +1139,7 @@ static int remap_pte_range(struct mm_str
 		set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(pte - 1);
+	pte_unmap_unlock(pte - 1, ptl);
 	return 0;
 }
 
@@ -1210,7 +1207,6 @@ int remap_pfn_range(struct vm_area_struc
 	pfn -= addr >> PAGE_SHIFT;
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
-	spin_lock(&mm->page_table_lock);
 	do {
 		next = pgd_addr_end(addr, end);
 		err = remap_pud_range(mm, pgd, addr, next,
@@ -1218,7 +1214,6 @@ int remap_pfn_range(struct vm_area_struc
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
-	spin_unlock(&mm->page_table_lock);
 	return err;
 }
 EXPORT_SYMBOL(remap_pfn_range);
@@ -1985,17 +1980,9 @@ static int do_file_page(struct mm_struct
  * with external mmu caches can use to update those (ie the Sparc or
  * PowerPC hashed page tables that act as extended TLBs).
  *
- * Note the "page_table_lock". It is to protect against kswapd removing
- * pages from under us. Note that kswapd only ever _removes_ pages, never
- * adds them. As such, once we have noticed that the page is not present,
- * we can drop the lock early.
- *
- * The adding of pages is protected by the MM semaphore (which we hold),
- * so we don't need to worry about a page being suddenly been added into
- * our VM.
- *
- * We enter with the pagetable spinlock held, we are supposed to
- * release it when done.
+ * We enter with non-exclusive mmap_sem (to exclude vma changes,
+ * but allow concurrent faults), and pte mapped but not yet locked.
+ * We return with mmap_sem still held, but pte unmapped and unlocked.
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long address,
@@ -2003,6 +1990,7 @@ static inline int handle_pte_fault(struc
 {
 	pte_t entry;
 
+	spin_lock(&mm->page_table_lock);
 	entry = *pte;
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
@@ -2051,30 +2039,18 @@ int __handle_mm_fault(struct mm_struct *
 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
 
-	/*
-	 * We need the page table lock to synchronize with kswapd
-	 * and the SMP-safe atomic PTE updates.
-	 */
 	pgd = pgd_offset(mm, address);
-	spin_lock(&mm->page_table_lock);
-
 	pud = pud_alloc(mm, pgd, address);
 	if (!pud)
-		goto oom;
-
+		return VM_FAULT_OOM;
 	pmd = pmd_alloc(mm, pud, address);
 	if (!pmd)
-		goto oom;
-
+		return VM_FAULT_OOM;
 	pte = pte_alloc_map(mm, pmd, address);
 	if (!pte)
-		goto oom;
-	
-	return handle_pte_fault(mm, vma, address, pte, pmd, write_access);
+		return VM_FAULT_OOM;
 
- oom:
-	spin_unlock(&mm->page_table_lock);
-	return VM_FAULT_OOM;
+	return handle_pte_fault(mm, vma, address, pte, pmd, write_access);
 }
 
 #ifndef __PAGETABLE_PUD_FOLDED
@@ -2084,24 +2060,16 @@ int __handle_mm_fault(struct mm_struct *
  */
 int __pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
-	pud_t *new;
-
-	if (mm != &init_mm)		/* Temporary bridging hack */
-		spin_unlock(&mm->page_table_lock);
-	new = pud_alloc_one(mm, address);
-	if (!new) {
-		if (mm != &init_mm)	/* Temporary bridging hack */
-			spin_lock(&mm->page_table_lock);
+	pud_t *new = pud_alloc_one(mm, address);
+	if (!new)
 		return -ENOMEM;
-	}
 
 	spin_lock(&mm->page_table_lock);
 	if (pgd_present(*pgd))		/* Another has populated it */
 		pud_free(new);
 	else
 		pgd_populate(mm, pgd, new);
-	if (mm == &init_mm)		/* Temporary bridging hack */
-		spin_unlock(&mm->page_table_lock);
+	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
 #endif /* __PAGETABLE_PUD_FOLDED */
@@ -2113,16 +2081,9 @@ int __pud_alloc(struct mm_struct *mm, pg
  */
 int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
-	pmd_t *new;
-
-	if (mm != &init_mm)		/* Temporary bridging hack */
-		spin_unlock(&mm->page_table_lock);
-	new = pmd_alloc_one(mm, address);
-	if (!new) {
-		if (mm != &init_mm)	/* Temporary bridging hack */
-			spin_lock(&mm->page_table_lock);
+	pmd_t *new = pmd_alloc_one(mm, address);
+	if (!new)
 		return -ENOMEM;
-	}
 
 	spin_lock(&mm->page_table_lock);
 #ifndef __ARCH_HAS_4LEVEL_HACK
@@ -2136,8 +2097,7 @@ int __pmd_alloc(struct mm_struct *mm, pu
 	else
 		pgd_populate(mm, pud, new);
 #endif /* __ARCH_HAS_4LEVEL_HACK */
-	if (mm == &init_mm)		/* Temporary bridging hack */
-		spin_unlock(&mm->page_table_lock);
+	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
--- mm10/mm/mremap.c	2005-10-11 23:56:11.000000000 +0100
+++ mm11/mm/mremap.c	2005-10-11 23:56:25.000000000 +0100
@@ -28,9 +28,6 @@ static pmd_t *get_old_pmd(struct mm_stru
 	pud_t *pud;
 	pmd_t *pmd;
 
-	/*
-	 * We don't need page_table_lock: we have mmap_sem exclusively.
-	 */
 	pgd = pgd_offset(mm, addr);
 	if (pgd_none_or_clear_bad(pgd))
 		return NULL;
@@ -50,25 +47,20 @@ static pmd_t *alloc_new_pmd(struct mm_st
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd = NULL;
+	pmd_t *pmd;
 
-	/*
-	 * We do need page_table_lock: because allocators expect that.
-	 */
-	spin_lock(&mm->page_table_lock);
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
 	if (!pud)
-		goto out;
+		return NULL;
 
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
-		goto out;
+		return NULL;
 
 	if (!pmd_present(*pmd) && __pte_alloc(mm, pmd, addr))
-		pmd = NULL;
-out:
-	spin_unlock(&mm->page_table_lock);
+		return NULL;
+
 	return pmd;
 }
 
@@ -80,6 +72,7 @@ static void move_ptes(struct vm_area_str
 	struct address_space *mapping = NULL;
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
+	spinlock_t *old_ptl;
 
 	if (vma->vm_file) {
 		/*
@@ -95,9 +88,8 @@ static void move_ptes(struct vm_area_str
 			new_vma->vm_truncate_count = 0;
 	}
 
-	spin_lock(&mm->page_table_lock);
-	old_pte = pte_offset_map(old_pmd, old_addr);
-	new_pte = pte_offset_map_nested(new_pmd, new_addr);
+	old_pte = pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl);
+ 	new_pte = pte_offset_map_nested(new_pmd, new_addr);
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
@@ -110,8 +102,7 @@ static void move_ptes(struct vm_area_str
 	}
 
 	pte_unmap_nested(new_pte - 1);
-	pte_unmap(old_pte - 1);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(old_pte - 1, old_ptl);
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
 }
