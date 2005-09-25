Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVIYP4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVIYP4w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVIYP4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:56:52 -0400
Received: from silver.veritas.com ([143.127.12.111]:45750 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932232AbVIYP4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:56:51 -0400
Date: Sun, 25 Sep 2005 16:56:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/21] mm: page fault handlers tidyup
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251654520.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:56:50.0853 (UTC) FILETIME=[BDF6B550:01C5C1E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Impose a little more consistency on the page fault handlers do_wp_page, 
do_swap_page, do_anonymous_page, do_no_page, do_file_page: why not pass
their arguments in the same order, called the same names?

break_cow is all very well, but what it did was inlined elsewhere:
easier to compare if it's brought back into do_wp_page.

do_file_page's fallback to do_no_page dates from a time when we were
testing pte_file by using it wherever possible: currently it's peculiar
to nonlinear vmas, so just check that.  BUG_ON if not?  Better not, it's
probably page table corruption, so just show the pte: hmm, there's a
pte_ERROR macro, let's use that for do_wp_page's invalid pfn too.

Hah! Someone in the ppc64 world noticed pte_ERROR was unused so removed
it: restored (and say "pud" not "pmd" in its pud_ERROR).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-ppc64/pgtable.h |    4 
 mm/memory.c                 |  220 +++++++++++++++++++-------------------------
 2 files changed, 100 insertions(+), 124 deletions(-)

--- mm09/include/asm-ppc64/pgtable.h	2005-09-21 12:16:55.000000000 +0100
+++ mm10/include/asm-ppc64/pgtable.h	2005-09-24 19:28:28.000000000 +0100
@@ -478,10 +478,12 @@ extern pgprot_t phys_mem_access_prot(str
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
+#define pte_ERROR(e) \
+	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
 #define pud_ERROR(e) \
-	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pud_val(e))
+	printk("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
--- mm09/mm/memory.c	2005-09-24 19:27:19.000000000 +0100
+++ mm10/mm/memory.c	2005-09-24 19:28:28.000000000 +0100
@@ -1213,28 +1213,10 @@ static inline pte_t maybe_mkwrite(pte_t 
 }
 
 /*
- * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
- */
-static inline void break_cow(struct vm_area_struct * vma, struct page * new_page, unsigned long address, 
-		pte_t *page_table)
-{
-	pte_t entry;
-
-	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
-			      vma);
-	ptep_establish(vma, address, page_table, entry);
-	update_mmu_cache(vma, address, entry);
-	lazy_mmu_prot_update(entry);
-}
-
-/*
  * This routine handles present pages, when users try to write
  * to a shared page. It is done by copying the page to a new address
  * and decrementing the shared-page counter for the old page.
  *
- * Goto-purists beware: the only reason for goto's here is that it results
- * in better assembly code.. The "default" path will see no jumps at all.
- *
  * Note that this routine assumes that the protection checks have been
  * done by the caller (the low-level page fault routine in most cases).
  * Thus we can safely just mark it writable once we've done any necessary
@@ -1247,25 +1229,22 @@ static inline void break_cow(struct vm_a
  * We hold the mm semaphore and the page_table_lock on entry and exit
  * with the page_table_lock released.
  */
-static int do_wp_page(struct mm_struct *mm, struct vm_area_struct * vma,
-	unsigned long address, pte_t *page_table, pmd_t *pmd, pte_t pte)
+static int do_wp_page(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		pte_t orig_pte)
 {
 	struct page *old_page, *new_page;
-	unsigned long pfn = pte_pfn(pte);
+	unsigned long pfn = pte_pfn(orig_pte);
 	pte_t entry;
-	int ret;
+	int ret = VM_FAULT_MINOR;
 
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
-		 * This should really halt the system so it can be debugged or
-		 * at least the kernel stops what it's doing before it corrupts
-		 * data, but for the moment just pretend this is OOM.
+		 * Page table corrupted: show pte and kill process.
 		 */
-		pte_unmap(page_table);
-		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
-				address);
-		spin_unlock(&mm->page_table_lock);
-		return VM_FAULT_OOM;
+		pte_ERROR(orig_pte);
+		ret = VM_FAULT_OOM;
+		goto unlock;
 	}
 	old_page = pfn_to_page(pfn);
 
@@ -1274,52 +1253,57 @@ static int do_wp_page(struct mm_struct *
 		unlock_page(old_page);
 		if (reuse) {
 			flush_cache_page(vma, address, pfn);
-			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
-					      vma);
+			entry = pte_mkyoung(orig_pte);
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 			ptep_set_access_flags(vma, address, page_table, entry, 1);
 			update_mmu_cache(vma, address, entry);
 			lazy_mmu_prot_update(entry);
-			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
-			return VM_FAULT_MINOR|VM_FAULT_WRITE;
+			ret |= VM_FAULT_WRITE;
+			goto unlock;
 		}
 	}
-	pte_unmap(page_table);
 
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
 	if (!PageReserved(old_page))
 		page_cache_get(old_page);
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 
 	if (unlikely(anon_vma_prepare(vma)))
-		goto no_new_page;
+		goto oom;
 	if (old_page == ZERO_PAGE(address)) {
 		new_page = alloc_zeroed_user_highpage(vma, address);
 		if (!new_page)
-			goto no_new_page;
+			goto oom;
 	} else {
 		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!new_page)
-			goto no_new_page;
+			goto oom;
 		copy_user_highpage(new_page, old_page, address);
 	}
+
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	ret = VM_FAULT_MINOR;
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
-	if (likely(pte_same(*page_table, pte))) {
+	if (likely(pte_same(*page_table, orig_pte))) {
 		if (PageAnon(old_page))
 			dec_mm_counter(mm, anon_rss);
 		if (PageReserved(old_page))
 			inc_mm_counter(mm, rss);
 		else
 			page_remove_rmap(old_page);
+
 		flush_cache_page(vma, address, pfn);
-		break_cow(vma, new_page, address, page_table);
+		entry = mk_pte(new_page, vma->vm_page_prot);
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		ptep_establish(vma, address, page_table, entry);
+		update_mmu_cache(vma, address, entry);
+		lazy_mmu_prot_update(entry);
+
 		lru_cache_add_active(new_page);
 		page_add_anon_rmap(new_page, vma, address);
 
@@ -1327,13 +1311,13 @@ static int do_wp_page(struct mm_struct *
 		new_page = old_page;
 		ret |= VM_FAULT_WRITE;
 	}
-	pte_unmap(page_table);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
+unlock:
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 	return ret;
-
-no_new_page:
+oom:
 	page_cache_release(old_page);
 	return VM_FAULT_OOM;
 }
@@ -1661,17 +1645,19 @@ void swapin_readahead(swp_entry_t entry,
  * We hold the mm semaphore and the page_table_lock on entry and
  * should release the pagetable lock on exit..
  */
-static int do_swap_page(struct mm_struct * mm,
-	struct vm_area_struct * vma, unsigned long address,
-	pte_t *page_table, pmd_t *pmd, pte_t orig_pte, int write_access)
+static int do_swap_page(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		int write_access, pte_t orig_pte)
 {
 	struct page *page;
-	swp_entry_t entry = pte_to_swp_entry(orig_pte);
+	swp_entry_t entry;
 	pte_t pte;
 	int ret = VM_FAULT_MINOR;
 
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
+
+	entry = pte_to_swp_entry(orig_pte);
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1685,11 +1671,7 @@ static int do_swap_page(struct mm_struct
 			page_table = pte_offset_map(pmd, address);
 			if (likely(pte_same(*page_table, orig_pte)))
 				ret = VM_FAULT_OOM;
-			else
-				ret = VM_FAULT_MINOR;
-			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
+			goto unlock;
 		}
 
 		/* Had to read the page from swap area: Major fault */
@@ -1745,6 +1727,7 @@ static int do_swap_page(struct mm_struct
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
 	lazy_mmu_prot_update(pte);
+unlock:
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 out:
@@ -1754,7 +1737,7 @@ out_nomap:
 	spin_unlock(&mm->page_table_lock);
 	unlock_page(page);
 	page_cache_release(page);
-	goto out;
+	return ret;
 }
 
 /*
@@ -1762,17 +1745,15 @@ out_nomap:
  * spinlock held to protect against concurrent faults in
  * multithreaded programs. 
  */
-static int
-do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		pte_t *page_table, pmd_t *pmd, int write_access,
-		unsigned long addr)
+static int do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		int write_access)
 {
 	pte_t entry;
 
 	/* Mapping of ZERO_PAGE - vm_page_prot is readonly */
 	entry = mk_pte(ZERO_PAGE(addr), vma->vm_page_prot);
 
-	/* ..except if it's a write access */
 	if (write_access) {
 		struct page *page;
 
@@ -1781,39 +1762,36 @@ do_anonymous_page(struct mm_struct *mm, 
 		spin_unlock(&mm->page_table_lock);
 
 		if (unlikely(anon_vma_prepare(vma)))
-			goto no_mem;
-		page = alloc_zeroed_user_highpage(vma, addr);
+			goto oom;
+		page = alloc_zeroed_user_highpage(vma, address);
 		if (!page)
-			goto no_mem;
+			goto oom;
 
 		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);
+		page_table = pte_offset_map(pmd, address);
 
 		if (!pte_none(*page_table)) {
-			pte_unmap(page_table);
 			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
+			goto unlock;
 		}
 		inc_mm_counter(mm, rss);
-		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
-							 vma->vm_page_prot)),
-				      vma);
+		entry = mk_pte(page, vma->vm_page_prot);
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		lru_cache_add_active(page);
 		SetPageReferenced(page);
-		page_add_anon_rmap(page, vma, addr);
+		page_add_anon_rmap(page, vma, address);
 	}
 
-	set_pte_at(mm, addr, page_table, entry);
-	pte_unmap(page_table);
+	set_pte_at(mm, address, page_table, entry);
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, addr, entry);
+	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
+unlock:
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
-out:
 	return VM_FAULT_MINOR;
-no_mem:
+oom:
 	return VM_FAULT_OOM;
 }
 
@@ -1829,20 +1807,17 @@ no_mem:
  * This is called with the MM semaphore held and the page table
  * spinlock held. Exit with the spinlock released.
  */
-static int
-do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
-	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
+static int do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		int write_access)
 {
-	struct page * new_page;
+	struct page *new_page;
 	struct address_space *mapping = NULL;
 	pte_t entry;
 	unsigned int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
 
-	if (!vma->vm_ops || !vma->vm_ops->nopage)
-		return do_anonymous_page(mm, vma, page_table,
-					pmd, write_access, address);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 
@@ -1852,7 +1827,6 @@ do_no_page(struct mm_struct *mm, struct 
 		smp_rmb(); /* serializes i_size against truncate_count */
 	}
 retry:
-	cond_resched();
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
 	/*
 	 * No smp_rmb is needed here as long as there's a full
@@ -1892,9 +1866,11 @@ retry:
 	 * retry getting the page.
 	 */
 	if (mapping && unlikely(sequence != mapping->truncate_count)) {
-		sequence = mapping->truncate_count;
 		spin_unlock(&mm->page_table_lock);
 		page_cache_release(new_page);
+		cond_resched();
+		sequence = mapping->truncate_count;
+		smp_rmb();
 		goto retry;
 	}
 	page_table = pte_offset_map(pmd, address);
@@ -1924,25 +1900,22 @@ retry:
 			page_add_anon_rmap(new_page, vma, address);
 		} else
 			page_add_file_rmap(new_page);
-		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
-		pte_unmap(page_table);
 		page_cache_release(new_page);
-		spin_unlock(&mm->page_table_lock);
-		goto out;
+		goto unlock;
 	}
 
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
+unlock:
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
-out:
 	return ret;
 oom:
 	page_cache_release(new_page);
-	ret = VM_FAULT_OOM;
-	goto out;
+	return VM_FAULT_OOM;
 }
 
 /*
@@ -1950,29 +1923,28 @@ oom:
  * from the encoded file_pte if possible. This enables swappable
  * nonlinear vmas.
  */
-static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+static int do_file_page(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		int write_access, pte_t orig_pte)
 {
-	unsigned long pgoff;
+	pgoff_t pgoff;
 	int err;
 
-	BUG_ON(!vma->vm_ops || !vma->vm_ops->nopage);
-	/*
-	 * Fall back to the linear mapping if the fs does not support
-	 * ->populate:
-	 */
-	if (!vma->vm_ops->populate ||
-			(write_access && !(vma->vm_flags & VM_SHARED))) {
-		pte_clear(mm, address, pte);
-		return do_no_page(mm, vma, address, write_access, pte, pmd);
-	}
-
-	pgoff = pte_to_pgoff(*pte);
-
-	pte_unmap(pte);
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 
-	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
+	if (unlikely(!(vma->vm_flags & VM_NONLINEAR))) {
+		/*
+		 * Page table corrupted: show pte and kill process.
+		 */
+		pte_ERROR(orig_pte);
+		return VM_FAULT_OOM;
+	}
+	/* We can then assume vm->vm_ops && vma->vm_ops->populate */
+
+	pgoff = pte_to_pgoff(orig_pte);
+	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE,
+					vma->vm_page_prot, pgoff, 0);
 	if (err == -ENOMEM)
 		return VM_FAULT_OOM;
 	if (err)
@@ -2002,23 +1974,25 @@ static int do_file_page(struct mm_struct
  * release it when done.
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
-	struct vm_area_struct * vma, unsigned long address,
-	int write_access, pte_t *pte, pmd_t *pmd)
+		struct vm_area_struct *vma, unsigned long address,
+		pte_t *pte, pmd_t *pmd, int write_access)
 {
 	pte_t entry;
 
 	entry = *pte;
 	if (!pte_present(entry)) {
-		/*
-		 * If it truly wasn't present, we know that kswapd
-		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
-		 */
-		if (pte_none(entry))
-			return do_no_page(mm, vma, address, write_access, pte, pmd);
+		if (pte_none(entry)) {
+			if (!vma->vm_ops || !vma->vm_ops->nopage)
+				return do_anonymous_page(mm, vma, address,
+					pte, pmd, write_access);
+			return do_no_page(mm, vma, address,
+					pte, pmd, write_access);
+		}
 		if (pte_file(entry))
-			return do_file_page(mm, vma, address, write_access, pte, pmd);
-		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
+			return do_file_page(mm, vma, address,
+					pte, pmd, write_access, entry);
+		return do_swap_page(mm, vma, address,
+					pte, pmd, write_access, entry);
 	}
 
 	if (write_access) {
@@ -2038,7 +2012,7 @@ static inline int handle_pte_fault(struc
 /*
  * By the time we get here, we already hold the mm semaphore
  */
-int __handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+int __handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, int write_access)
 {
 	pgd_t *pgd;
@@ -2072,7 +2046,7 @@ int __handle_mm_fault(struct mm_struct *
 	if (!pte)
 		goto oom;
 	
-	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	return handle_pte_fault(mm, vma, address, pte, pmd, write_access);
 
  oom:
 	spin_unlock(&mm->page_table_lock);
