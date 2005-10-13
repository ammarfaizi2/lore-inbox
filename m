Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVJMBOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVJMBOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVJMBOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:14:05 -0400
Received: from gold.veritas.com ([143.127.12.110]:48660 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964844AbVJMBOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:14:04 -0400
Date: Thu, 13 Oct 2005 02:13:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/21] mm: page fault handler locking
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130212370.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:14:03.0617 (UTC) FILETIME=[66776510:01C5CF93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the page fault path, the patch before last pushed acquiring the
page_table_lock down to the head of handle_pte_fault (though it's also
taken and dropped earlier when a new page table has to be allocated).

Now delete that line, read "entry = *pte" without it, and go off to this
or that page fault handler on the basis of this unlocked peek.  Usually
the handler can proceed without the lock, relying on the subsequent
locked pte_same or pte_none test to back out when necessary; though
do_wp_page needs the lock immediately, and do_file_page doesn't check
(if there's a race, install_page just zaps the entry and reinstalls it).

But on those architectures (notably i386 with PAE) whose pte is too big
to be read atomically, if SMP or preemption is enabled, do_swap_page and
do_file_page might cause irretrievable damage if passed a Frankenstein
entry stitched together from unrelated parts.  In those configs,
"pte_unmap_same" has to take page_table_lock, validate orig_pte still
the same, and drop page_table_lock before unmapping, before proceeding.

Use pte_offset_map_lock and pte_unmap_unlock throughout the handlers;
but lock avoidance leaves more lone maps and unmaps than elsewhere.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |  150 ++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 90 insertions(+), 60 deletions(-)

--- mm12/mm/memory.c	2005-10-11 23:56:25.000000000 +0100
+++ mm13/mm/memory.c	2005-10-11 23:56:56.000000000 +0100
@@ -1219,6 +1219,30 @@ int remap_pfn_range(struct vm_area_struc
 EXPORT_SYMBOL(remap_pfn_range);
 
 /*
+ * handle_pte_fault chooses page fault handler according to an entry
+ * which was read non-atomically.  Before making any commitment, on
+ * those architectures or configurations (e.g. i386 with PAE) which
+ * might give a mix of unmatched parts, do_swap_page and do_file_page
+ * must check under lock before unmapping the pte and proceeding
+ * (but do_wp_page is only called after already making such a check;
+ * and do_anonymous_page and do_no_page can safely check later on).
+ */
+static inline int pte_unmap_same(struct mm_struct *mm,
+				pte_t *page_table, pte_t orig_pte)
+{
+	int same = 1;
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+	if (sizeof(pte_t) > sizeof(unsigned long)) {
+		spin_lock(&mm->page_table_lock);
+		same = pte_same(*page_table, orig_pte);
+		spin_unlock(&mm->page_table_lock);
+	}
+#endif
+	pte_unmap(page_table);
+	return same;
+}
+
+/*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
  * servicing faults for write access.  In the normal case, do always want
  * pte_mkwrite.  But get_user_pages can cause write faults for mappings
@@ -1245,12 +1269,13 @@ static inline pte_t maybe_mkwrite(pte_t 
  * change only once the write actually happens. This avoids a few races,
  * and potentially makes it more efficient.
  *
- * We hold the mm semaphore and the page_table_lock on entry and exit
- * with the page_table_lock released.
+ * We enter with non-exclusive mmap_sem (to exclude vma changes,
+ * but allow concurrent faults), with pte both mapped and locked.
+ * We return with mmap_sem still held, but pte unmapped and unlocked.
  */
 static int do_wp_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
-		pte_t orig_pte)
+		spinlock_t *ptl, pte_t orig_pte)
 {
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(orig_pte);
@@ -1288,8 +1313,7 @@ static int do_wp_page(struct mm_struct *
 	 * Ok, we need to copy. Oh, well..
 	 */
 	page_cache_get(old_page);
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(page_table, ptl);
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
@@ -1307,8 +1331,7 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	spin_lock(&mm->page_table_lock);
-	page_table = pte_offset_map(pmd, address);
+	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (likely(pte_same(*page_table, orig_pte))) {
 		page_remove_rmap(old_page);
 		if (!PageAnon(old_page)) {
@@ -1321,7 +1344,6 @@ static int do_wp_page(struct mm_struct *
 		ptep_establish(vma, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
-
 		lru_cache_add_active(new_page);
 		page_add_anon_rmap(new_page, vma, address);
 
@@ -1332,8 +1354,7 @@ static int do_wp_page(struct mm_struct *
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 unlock:
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(page_table, ptl);
 	return ret;
 oom:
 	page_cache_release(old_page);
@@ -1660,20 +1681,22 @@ void swapin_readahead(swp_entry_t entry,
 }
 
 /*
- * We hold the mm semaphore and the page_table_lock on entry and
- * should release the pagetable lock on exit..
+ * We enter with non-exclusive mmap_sem (to exclude vma changes,
+ * but allow concurrent faults), and pte mapped but not yet locked.
+ * We return with mmap_sem still held, but pte unmapped and unlocked.
  */
 static int do_swap_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
 		int write_access, pte_t orig_pte)
 {
+	spinlock_t *ptl;
 	struct page *page;
 	swp_entry_t entry;
 	pte_t pte;
 	int ret = VM_FAULT_MINOR;
 
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	if (!pte_unmap_same(mm, page_table, orig_pte))
+		goto out;
 
 	entry = pte_to_swp_entry(orig_pte);
 	page = lookup_swap_cache(entry);
@@ -1682,11 +1705,10 @@ static int do_swap_page(struct mm_struct
  		page = read_swap_cache_async(entry, vma, address);
 		if (!page) {
 			/*
-			 * Back out if somebody else faulted in this pte while
-			 * we released the page table lock.
+			 * Back out if somebody else faulted in this pte
+			 * while we released the pte lock.
 			 */
-			spin_lock(&mm->page_table_lock);
-			page_table = pte_offset_map(pmd, address);
+			page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 			if (likely(pte_same(*page_table, orig_pte)))
 				ret = VM_FAULT_OOM;
 			goto unlock;
@@ -1702,11 +1724,9 @@ static int do_swap_page(struct mm_struct
 	lock_page(page);
 
 	/*
-	 * Back out if somebody else faulted in this pte while we
-	 * released the page table lock.
+	 * Back out if somebody else already faulted in this pte.
 	 */
-	spin_lock(&mm->page_table_lock);
-	page_table = pte_offset_map(pmd, address);
+	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (unlikely(!pte_same(*page_table, orig_pte)))
 		goto out_nomap;
 
@@ -1735,7 +1755,7 @@ static int do_swap_page(struct mm_struct
 
 	if (write_access) {
 		if (do_wp_page(mm, vma, address,
-				page_table, pmd, pte) == VM_FAULT_OOM)
+				page_table, pmd, ptl, pte) == VM_FAULT_OOM)
 			ret = VM_FAULT_OOM;
 		goto out;
 	}
@@ -1744,37 +1764,32 @@ static int do_swap_page(struct mm_struct
 	update_mmu_cache(vma, address, pte);
 	lazy_mmu_prot_update(pte);
 unlock:
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(page_table, ptl);
 out:
 	return ret;
 out_nomap:
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(page_table, ptl);
 	unlock_page(page);
 	page_cache_release(page);
 	return ret;
 }
 
 /*
- * We are called with the MM semaphore and page_table_lock
- * spinlock held to protect against concurrent faults in
- * multithreaded programs. 
+ * We enter with non-exclusive mmap_sem (to exclude vma changes,
+ * but allow concurrent faults), and pte mapped but not yet locked.
+ * We return with mmap_sem still held, but pte unmapped and unlocked.
  */
 static int do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
 		int write_access)
 {
-	struct page *page = ZERO_PAGE(addr);
+	struct page *page;
+	spinlock_t *ptl;
 	pte_t entry;
 
-	/* Mapping of ZERO_PAGE - vm_page_prot is readonly */
-	entry = mk_pte(page, vma->vm_page_prot);
-
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
 
 		if (unlikely(anon_vma_prepare(vma)))
 			goto oom;
@@ -1782,23 +1797,28 @@ static int do_anonymous_page(struct mm_s
 		if (!page)
 			goto oom;
 
-		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, address);
-
-		if (!pte_none(*page_table)) {
-			page_cache_release(page);
-			goto unlock;
-		}
-		inc_mm_counter(mm, anon_rss);
 		entry = mk_pte(page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+
+		page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
+		if (!pte_none(*page_table))
+			goto release;
+		inc_mm_counter(mm, anon_rss);
 		lru_cache_add_active(page);
 		SetPageReferenced(page);
 		page_add_anon_rmap(page, vma, address);
 	} else {
+		/* Map the ZERO_PAGE - vm_page_prot is readonly */
+		page = ZERO_PAGE(address);
+		page_cache_get(page);
+		entry = mk_pte(page, vma->vm_page_prot);
+
+		ptl = &mm->page_table_lock;
+		spin_lock(ptl);
+		if (!pte_none(*page_table))
+			goto release;
 		inc_mm_counter(mm, file_rss);
 		page_add_file_rmap(page);
-		page_cache_get(page);
 	}
 
 	set_pte_at(mm, address, page_table, entry);
@@ -1807,9 +1827,11 @@ static int do_anonymous_page(struct mm_s
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
 unlock:
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(page_table, ptl);
 	return VM_FAULT_MINOR;
+release:
+	page_cache_release(page);
+	goto unlock;
 oom:
 	return VM_FAULT_OOM;
 }
@@ -1823,13 +1845,15 @@ oom:
  * As this is called only for pages that do not currently exist, we
  * do not need to flush old virtual caches or the TLB.
  *
- * This is called with the MM semaphore held and the page table
- * spinlock held. Exit with the spinlock released.
+ * We enter with non-exclusive mmap_sem (to exclude vma changes,
+ * but allow concurrent faults), and pte mapped but not yet locked.
+ * We return with mmap_sem still held, but pte unmapped and unlocked.
  */
 static int do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
 		int write_access)
 {
+	spinlock_t *ptl;
 	struct page *new_page;
 	struct address_space *mapping = NULL;
 	pte_t entry;
@@ -1838,7 +1862,6 @@ static int do_no_page(struct mm_struct *
 	int anon = 0;
 
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
 
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1878,21 +1901,20 @@ retry:
 		anon = 1;
 	}
 
-	spin_lock(&mm->page_table_lock);
+	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	/*
 	 * For a file-backed vma, someone could have truncated or otherwise
 	 * invalidated this page.  If unmap_mapping_range got called,
 	 * retry getting the page.
 	 */
 	if (mapping && unlikely(sequence != mapping->truncate_count)) {
-		spin_unlock(&mm->page_table_lock);
+		pte_unmap_unlock(page_table, ptl);
 		page_cache_release(new_page);
 		cond_resched();
 		sequence = mapping->truncate_count;
 		smp_rmb();
 		goto retry;
 	}
-	page_table = pte_offset_map(pmd, address);
 
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
@@ -1929,8 +1951,7 @@ retry:
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
 unlock:
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(page_table, ptl);
 	return ret;
 oom:
 	page_cache_release(new_page);
@@ -1941,6 +1962,10 @@ oom:
  * Fault of a previously existing named mapping. Repopulate the pte
  * from the encoded file_pte if possible. This enables swappable
  * nonlinear vmas.
+ *
+ * We enter with non-exclusive mmap_sem (to exclude vma changes,
+ * but allow concurrent faults), and pte mapped but not yet locked.
+ * We return with mmap_sem still held, but pte unmapped and unlocked.
  */
 static int do_file_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
@@ -1949,8 +1974,8 @@ static int do_file_page(struct mm_struct
 	pgoff_t pgoff;
 	int err;
 
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	if (!pte_unmap_same(mm, page_table, orig_pte))
+		return VM_FAULT_MINOR;
 
 	if (unlikely(!(vma->vm_flags & VM_NONLINEAR))) {
 		/*
@@ -1989,8 +2014,8 @@ static inline int handle_pte_fault(struc
 		pte_t *pte, pmd_t *pmd, int write_access)
 {
 	pte_t entry;
+	spinlock_t *ptl;
 
-	spin_lock(&mm->page_table_lock);
 	entry = *pte;
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
@@ -2007,17 +2032,22 @@ static inline int handle_pte_fault(struc
 					pte, pmd, write_access, entry);
 	}
 
+	ptl = &mm->page_table_lock;
+	spin_lock(ptl);
+	if (unlikely(!pte_same(*pte, entry)))
+		goto unlock;
 	if (write_access) {
 		if (!pte_write(entry))
-			return do_wp_page(mm, vma, address, pte, pmd, entry);
+			return do_wp_page(mm, vma, address,
+					pte, pmd, ptl, entry);
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
 	ptep_set_access_flags(vma, address, pte, entry, write_access);
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
-	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+unlock:
+	pte_unmap_unlock(pte, ptl);
 	return VM_FAULT_MINOR;
 }
 
