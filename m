Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbULAXrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbULAXrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULAXpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:45:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61909 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261498AbULAXmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:42:11 -0500
Date: Wed, 1 Dec 2004 15:42:05 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V12 [1/7]: Reduce use of thepage_table_lock
In-Reply-To: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412011541100.5721@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
        * Increase parallelism in SMP configurations by deferring
          the acquisition of page_table_lock in handle_mm_fault
        * Anonymous memory page faults bypass the page_table_lock
          through the use of atomic page table operations
        * Swapper does not set pte to empty in transition to swap
        * Simulate atomic page table operations using the
          page_table_lock if an arch does not define
          __HAVE_ARCH_ATOMIC_TABLE_OPS. This still provides
          a performance benefit since the page_table_lock
          is held for shorter periods of time.

Signed-off-by: Christoph Lameter <clameter@sgi.com

Index: linux-2.6.9/mm/memory.c
===================================================================
--- linux-2.6.9.orig/mm/memory.c	2004-11-23 10:06:03.000000000 -0800
+++ linux-2.6.9/mm/memory.c	2004-11-23 10:07:55.000000000 -0800
@@ -1330,8 +1330,7 @@
 }

 /*
- * We hold the mm semaphore and the page_table_lock on entry and
- * should release the pagetable lock on exit..
+ * We hold the mm semaphore
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
@@ -1343,15 +1342,13 @@
 	int ret = VM_FAULT_MINOR;

 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
  		page = read_swap_cache_async(entry, vma, address);
 		if (!page) {
 			/*
-			 * Back out if somebody else faulted in this pte while
-			 * we released the page table lock.
+			 * Back out if somebody else faulted in this pte
 			 */
 			spin_lock(&mm->page_table_lock);
 			page_table = pte_offset_map(pmd, address);
@@ -1374,8 +1371,7 @@
 	lock_page(page);

 	/*
-	 * Back out if somebody else faulted in this pte while we
-	 * released the page table lock.
+	 * Back out if somebody else faulted in this pte
 	 */
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
@@ -1422,14 +1418,12 @@
 }

 /*
- * We are called with the MM semaphore and page_table_lock
- * spinlock held to protect against concurrent faults in
- * multithreaded programs.
+ * We are called with the MM semaphore held.
  */
 static int
 do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		pte_t *page_table, pmd_t *pmd, int write_access,
-		unsigned long addr)
+		unsigned long addr, pte_t orig_entry)
 {
 	pte_t entry;
 	struct page * page = ZERO_PAGE(addr);
@@ -1441,7 +1435,6 @@
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
@@ -1450,30 +1443,37 @@
 			goto no_mem;
 		clear_user_highpage(page, addr);

-		spin_lock(&mm->page_table_lock);
 		page_table = pte_offset_map(pmd, addr);

-		if (!pte_none(*page_table)) {
-			pte_unmap(page_table);
-			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
-		}
-		mm->rss++;
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
-		lru_cache_add_active(page);
 		mark_page_accessed(page);
-		page_add_anon_rmap(page, vma, addr);
 	}

-	set_pte(page_table, entry);
+	/* update the entry */
+	if (!ptep_cmpxchg(vma, addr, page_table, orig_entry, entry)) {
+		if (write_access) {
+			pte_unmap(page_table);
+			page_cache_release(page);
+		}
+		goto out;
+	}
+	if (write_access) {
+		/*
+		 * These two functions must come after the cmpxchg
+		 * because if the page is on the LRU then try_to_unmap may come
+		 * in and unmap the pte.
+		 */
+		lru_cache_add_active(page);
+		page_add_anon_rmap(page, vma, addr);
+		mm->rss++;
+
+	}
 	pte_unmap(page_table);

 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
-	spin_unlock(&mm->page_table_lock);
 out:
 	return VM_FAULT_MINOR;
 no_mem:
@@ -1489,12 +1489,12 @@
  * As this is called only for pages that do not currently exist, we
  * do not need to flush old virtual caches or the TLB.
  *
- * This is called with the MM semaphore held and the page table
- * spinlock held. Exit with the spinlock released.
+ * This is called with the MM semaphore held.
  */
 static int
 do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
-	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
+	unsigned long address, int write_access, pte_t *page_table,
+        pmd_t *pmd, pte_t orig_entry)
 {
 	struct page * new_page;
 	struct address_space *mapping = NULL;
@@ -1505,9 +1505,8 @@

 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
-					pmd, write_access, address);
+					pmd, write_access, address, orig_entry);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);

 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1605,7 +1604,7 @@
  * nonlinear vmas.
  */
 static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd, pte_t entry)
 {
 	unsigned long pgoff;
 	int err;
@@ -1618,13 +1617,12 @@
 	if (!vma->vm_ops || !vma->vm_ops->populate ||
 			(write_access && !(vma->vm_flags & VM_SHARED))) {
 		pte_clear(pte);
-		return do_no_page(mm, vma, address, write_access, pte, pmd);
+		return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
 	}

 	pgoff = pte_to_pgoff(*pte);

 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);

 	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
 	if (err == -ENOMEM)
@@ -1643,49 +1641,40 @@
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
+ * Note that kswapd only ever _removes_ pages, never adds them.
+ * We need to insure to handle that case properly.
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 	struct vm_area_struct * vma, unsigned long address,
 	int write_access, pte_t *pte, pmd_t *pmd)
 {
 	pte_t entry;
+	pte_t new_entry;

 	entry = *pte;
 	if (!pte_present(entry)) {
-		/*
-		 * If it truly wasn't present, we know that kswapd
-		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
-		 */
 		if (pte_none(entry))
-			return do_no_page(mm, vma, address, write_access, pte, pmd);
+			return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
 		if (pte_file(entry))
-			return do_file_page(mm, vma, address, write_access, pte, pmd);
+			return do_file_page(mm, vma, address, write_access, pte, pmd, entry);
 		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}

+	/*
+	 * This is the case in which we only update some bits in the pte.
+	 */
+	new_entry = pte_mkyoung(entry);
 	if (write_access) {
-		if (!pte_write(entry))
+		if (!pte_write(entry)) {
+			/* do_wp_page expects us to hold the page_table_lock */
+			spin_lock(&mm->page_table_lock);
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
-
-		entry = pte_mkdirty(entry);
+		}
+		new_entry = pte_mkdirty(new_entry);
 	}
-	entry = pte_mkyoung(entry);
-	ptep_set_access_flags(vma, address, pte, entry, write_access);
-	update_mmu_cache(vma, address, entry);
+	if (ptep_cmpxchg(vma, address, pte, entry, new_entry))
+		update_mmu_cache(vma, address, new_entry);
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
 }

@@ -1703,22 +1692,45 @@

 	inc_page_state(pgfault);

-	if (is_vm_hugetlb_page(vma))
+	if (unlikely(is_vm_hugetlb_page(vma)))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */

 	/*
-	 * We need the page table lock to synchronize with kswapd
-	 * and the SMP-safe atomic PTE updates.
+	 * We rely on the mmap_sem and the SMP-safe atomic PTE updates.
+	 * to synchronize with kswapd
 	 */
-	spin_lock(&mm->page_table_lock);
-	pmd = pmd_alloc(mm, pgd, address);
+	if (unlikely(pgd_none(*pgd))) {
+		pmd_t *new = pmd_alloc_one(mm, address);
+		if (!new)
+			return VM_FAULT_OOM;
+
+		/* Insure that the update is done in an atomic way */
+		if (!pgd_test_and_populate(mm, pgd, new))
+			pmd_free(new);
+	}
+
+	pmd = pmd_offset(pgd, address);
+
+	if (likely(pmd)) {
+		pte_t *pte;
+
+		if (!pmd_present(*pmd)) {
+			struct page *new;

-	if (pmd) {
-		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
+			new = pte_alloc_one(mm, address);
+			if (!new)
+				return VM_FAULT_OOM;
+
+			if (!pmd_test_and_populate(mm, pmd, new))
+				pte_free(new);
+			else
+				inc_page_state(nr_page_table_pages);
+		}
+
+		pte = pte_offset_map(pmd, address);
+		if (likely(pte))
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
-	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;
 }

Index: linux-2.6.9/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-generic/pgtable.h	2004-10-18 14:53:46.000000000 -0700
+++ linux-2.6.9/include/asm-generic/pgtable.h	2004-11-23 10:06:12.000000000 -0800
@@ -134,4 +134,60 @@
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif

+#ifndef __HAVE_ARCH_ATOMIC_TABLE_OPS
+/*
+ * If atomic page table operations are not available then use
+ * the page_table_lock to insure some form of locking.
+ * Note thought that low level operations as well as the
+ * page_table_handling of the cpu may bypass all locking.
+ */
+
+#ifndef __HAVE_ARCH_PTEP_CMPXCHG
+#define ptep_cmpxchg(__vma, __addr, __ptep, __oldval, __newval)		\
+({									\
+	int __rc;							\
+	spin_lock(&__vma->vm_mm->page_table_lock);			\
+	__rc = pte_same(*(__ptep), __oldval);				\
+	if (__rc) set_pte(__ptep, __newval);				\
+	spin_unlock(&__vma->vm_mm->page_table_lock);			\
+	__rc;								\
+})
+#endif
+
+#ifndef __HAVE_ARCH_PGP_TEST_AND_POPULATE
+#define pgd_test_and_populate(__mm, __pgd, __pmd)			\
+({									\
+	int __rc;							\
+	spin_lock(&__mm->page_table_lock);				\
+	__rc = !pgd_present(*(__pgd));					\
+	if (__rc) pgd_populate(__mm, __pgd, __pmd);			\
+	spin_unlock(&__mm->page_table_lock);				\
+	__rc;								\
+})
+#endif
+
+#ifndef __HAVE_PMD_TEST_AND_POPULATE
+#define pmd_test_and_populate(__mm, __pmd, __page)			\
+({									\
+	int __rc;							\
+	spin_lock(&__mm->page_table_lock);				\
+	__rc = !pmd_present(*(__pmd));					\
+	if (__rc) pmd_populate(__mm, __pmd, __page);			\
+	spin_unlock(&__mm->page_table_lock);				\
+	__rc;								\
+})
+#endif
+
+#endif
+
+#ifndef __HAVE_ARCH_PTEP_XCHG_FLUSH
+#define ptep_xchg_flush(__vma, __address, __ptep, __pteval)		\
+({									\
+	pte_t __p = __pte(xchg(&pte_val(*(__ptep)), pte_val(__pteval)));\
+	flush_tlb_page(__vma, __address);				\
+	__p;								\
+})
+
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
Index: linux-2.6.9/mm/rmap.c
===================================================================
--- linux-2.6.9.orig/mm/rmap.c	2004-11-23 10:06:03.000000000 -0800
+++ linux-2.6.9/mm/rmap.c	2004-11-23 10:06:12.000000000 -0800
@@ -424,7 +424,10 @@
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
  *
- * The caller needs to hold the mm->page_table_lock.
+ * The caller needs to hold the mm->page_table_lock if page
+ * is pointing to something that is known by the vm.
+ * The lock does not need to be held if page is pointing
+ * to a newly allocated page.
  */
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
@@ -568,11 +571,6 @@

 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
-	pteval = ptep_clear_flush(vma, address, pte);
-
-	/* Move the dirty bit to the physical page now the pte is gone. */
-	if (pte_dirty(pteval))
-		set_page_dirty(page);

 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
@@ -587,11 +585,15 @@
 			list_add(&mm->mmlist, &init_mm.mmlist);
 			spin_unlock(&mmlist_lock);
 		}
-		set_pte(pte, swp_entry_to_pte(entry));
+		pteval = ptep_xchg_flush(vma, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
 		mm->anon_rss--;
-	}
+	} else
+		pteval = ptep_clear_flush(vma, address, pte);

+	/* Move the dirty bit to the physical page now the pte is gone. */
+	if (pte_dirty(pteval))
+		set_page_dirty(page);
 	mm->rss--;
 	page_remove_rmap(page);
 	page_cache_release(page);
@@ -678,15 +680,21 @@
 		if (ptep_clear_flush_young(vma, address, pte))
 			continue;

-		/* Nuke the page table entry. */
 		flush_cache_page(vma, address);
-		pteval = ptep_clear_flush(vma, address, pte);
+		/*
+		 * There would be a race here with handle_mm_fault and do_anonymous_page
+		 * which  bypasses the page_table_lock if we would zap the pte before
+		 * putting something into it. On the other hand we need to
+		 * have the dirty flag setting at the time we replaced the value.
+		 */

 		/* If nonlinear, store the file page offset in the pte. */
 		if (page->index != linear_page_index(vma, address))
-			set_pte(pte, pgoff_to_pte(page->index));
+			pteval = ptep_xchg_flush(vma, address, pte, pgoff_to_pte(page->index));
+		else
+			pteval = ptep_get_and_clear(pte);

-		/* Move the dirty bit to the physical page now the pte is gone. */
+		/* Move the dirty bit to the physical page now that the pte is gone. */
 		if (pte_dirty(pteval))
 			set_page_dirty(page);


