Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269678AbUIRX3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269678AbUIRX3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269676AbUIRX3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:29:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:2237 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269675AbUIRX1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:27:04 -0400
Date: Sat, 18 Sep 2004 16:26:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: page fault scalability patch V8: [2/7] avoid page_table_lock in
 handle_mm_fault
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409181625010.24054@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
 <1094012689.6538.330.camel@gaston> <Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com>
 <1094080164.4025.17.camel@gaston> <Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com>
 <20040901215741.3538bbf4.davem@davemloft.net>
 <Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com>
 <20040902131057.0341e337.davem@davemloft.net>
 <Pine.LNX.4.58.0409021358540.28182@schroedinger.engr.sgi.com>
 <20040902140759.5f1003d5.davem@davemloft.net>
 <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
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

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linus/mm/memory.c
===================================================================
--- linus.orig/mm/memory.c	2004-09-18 15:01:05.000000000 -0700
+++ linus/mm/memory.c	2004-09-18 15:40:02.000000000 -0700
@@ -1314,8 +1314,7 @@
 }

 /*
- * We hold the mm semaphore and the page_table_lock on entry and
- * should release the pagetable lock on exit..
+ * We hold the mm semaphore
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
@@ -1327,15 +1326,13 @@
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
@@ -1406,14 +1403,12 @@
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
@@ -1425,7 +1420,6 @@
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
@@ -1434,30 +1428,40 @@
 			goto no_mem;
 		clear_user_highpage(page, addr);

-		spin_lock(&mm->page_table_lock);
+		lock_page(page);
 		page_table = pte_offset_map(pmd, addr);

-		if (!pte_none(*page_table)) {
-			pte_unmap(page_table);
-			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
-		}
-		atomic_inc(&mm->mm_rss);
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
-		lru_cache_add_active(page);
 		mark_page_accessed(page);
-		page_add_anon_rmap(page, vma, addr);
 	}

-	set_pte(page_table, entry);
+	/* update the entry */
+	if (!ptep_cmpxchg(vma, addr, page_table, orig_entry, entry))
+	{
+		if (write_access) {
+			pte_unmap(page_table);
+			unlock_page(page);
+			page_cache_release(page);
+		}
+		goto out;
+	}
+	if (write_access) {
+		/*
+		 * The following two functions are safe to use without
+		 * the page_table_lock but do they need to come before
+		 * the cmpxchg?
+		 */
+		lru_cache_add_active(page);
+		page_add_anon_rmap(page, vma, addr);
+		atomic_inc(&mm->mm_rss);
+		unlock_page(page);
+	}
 	pte_unmap(page_table);

 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
-	spin_unlock(&mm->page_table_lock);
 out:
 	return VM_FAULT_MINOR;
 no_mem:
@@ -1473,12 +1477,12 @@
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
@@ -1489,9 +1493,8 @@

 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
-					pmd, write_access, address);
+					pmd, write_access, address, orig_entry);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);

 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1589,7 +1592,7 @@
  * nonlinear vmas.
  */
 static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd, pte_t entry)
 {
 	unsigned long pgoff;
 	int err;
@@ -1602,13 +1605,12 @@
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
@@ -1627,49 +1629,49 @@
  * with external mmu caches can use to update those (ie the Sparc or
  * PowerPC hashed page tables that act as extended TLBs).
  *
- * Note the "page_table_lock". It is to protect against kswapd removing
- * pages from under us. Note that kswapd only ever _removes_ pages, never
- * adds them. As such, once we have noticed that the page is not present,
- * we can drop the lock early.
- *
+ * Note that kswapd only ever _removes_ pages, never adds them.
+ * We need to insure to handle that case properly.
+ *
  * The adding of pages is protected by the MM semaphore (which we hold),
  * so we don't need to worry about a page being suddenly been added into
  * our VM.
- *
- * We enter with the pagetable spinlock held, we are supposed to
- * release it when done.
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 	struct vm_area_struct * vma, unsigned long address,
 	int write_access, pte_t *pte, pmd_t *pmd)
 {
 	pte_t entry;
+	pte_t new_entry;

 	entry = *pte;
 	if (!pte_present(entry)) {
 		/*
 		 * If it truly wasn't present, we know that kswapd
 		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
+		 * no need to acquire the page_table_lock.
 		 */
 		if (pte_none(entry))
-			return do_no_page(mm, vma, address, write_access, pte, pmd);
+			return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
 		if (pte_file(entry))
-			return do_file_page(mm, vma, address, write_access, pte, pmd);
+			return do_file_page(mm, vma, address, write_access, pte, pmd, entry);
 		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}

+	/*
+	 * This is the case in which we may only update some bits in the pte.
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

@@ -1687,22 +1689,42 @@

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
+       		pmd_t *new = pmd_alloc_one(mm, address);
+		if (!new) return VM_FAULT_OOM;
+
+		/* Insure that the update is done in an atomic way */
+		if (!pgd_test_and_populate(mm, pgd, new)) pmd_free(new);
+	}
+
+        pmd = pmd_offset(pgd, address);
+
+	if (likely(pmd)) {
+		pte_t *pte;

-	if (pmd) {
-		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
+		if (!pmd_present(*pmd)) {
+			struct page *new;
+
+			new = pte_alloc_one(mm, address);
+			if (!new) return VM_FAULT_OOM;
+
+			if (!pmd_test_and_populate(mm, pmd, new))
+				pte_free(new);
+                        else
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

Index: linus/include/asm-generic/pgtable.h
===================================================================
--- linus.orig/include/asm-generic/pgtable.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-generic/pgtable.h	2004-09-18 15:34:59.000000000 -0700
@@ -126,4 +126,81 @@
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
+#define ptep_xchg_flush(__vma, __address, __ptep, __pteval)		\
+({									\
+	pte_t __pte;							\
+	spin_lock(&mm->page_table_lock);				\
+	__pte = *(__ptep);						\
+	set_pte(__ptep, __pteval);					\
+	flush_tlb_page(__vma, __address);				\
+	spin_unlock(&mm->page_table_lock);				\
+	__pte;								\
+})
+
+
+#define ptep_get_clear_flush(__vma, __address, __ptep)			\
+({									\
+	pte_t __pte;							\
+	spin_lock(&mm->page_table_lock);				\
+	__pte = ptep_get_and_clear(__ptep);				\
+	flush_tlb_page(__vma, __address);				\
+	spin_unlock(&mm->page_table_lock);				\
+	__pte;								\
+})
+
+
+#define ptep_cmpxchg(__vma, __addr, __ptep, __oldval, __newval)		\
+({									\
+	int __rc;							\
+	spin_lock(&mm->page_table_lock);				\
+	__rc = pte_same(*(__ptep), __oldval);				\
+	if (__rc) set_pte(__ptep, __newval);				\
+	flush_tlb_page(__vma, __addr);					\
+	spin_unlock(&mm->page_table_lock);				\
+	__rc;								\
+})
+
+#define pgd_test_and_populate(__mm, __pgd, __pmd)			\
+({									\
+	int __rc;							\
+	spin_lock(&mm->page_table_lock);				\
+	__rc = !pgd_present(*(__pgd));					\
+	if (__rc) pgd_populate(__mm, __pgd, __pmd);			\
+	spin_unlock(&mm->page_table_lock);				\
+	__rc;								\
+})
+
+#define pmd_test_and_populate(__mm, __pmd, __page)			\
+({									\
+	int __rc;							\
+	spin_lock(&mm->page_table_lock);				\
+	__rc = !pmd_present(*(__pmd));					\
+	if (__rc) pmd_populate(__mm, __pmd, __page);			\
+	spin_unlock(&mm->page_table_lock);				\
+	__rc;								\
+})
+
+
+#else
+
+#ifndef __HAVE_ARCH_PTEP_XCHG_FLUSH
+#define ptep_xchg_flush(__vma, __address, __ptep, __pteval)		\
+({									\
+	pte_t __pte = ptep_xchg((__vma)->vm_mm, __ptep, __pteval);	\
+	flush_tlb_page(__vma, __address);				\
+	__pte;								\
+})
+
+#endif
+
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
Index: linus/mm/rmap.c
===================================================================
--- linus.orig/mm/rmap.c	2004-09-18 15:13:05.000000000 -0700
+++ linus/mm/rmap.c	2004-09-18 15:41:15.000000000 -0700
@@ -420,7 +420,10 @@
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
@@ -562,11 +565,6 @@

 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
-	pteval = ptep_clear_flush(vma, address, pte);
-
-	/* Move the dirty bit to the physical page now the pte is gone. */
-	if (pte_dirty(pteval))
-		set_page_dirty(page);

 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
@@ -576,10 +574,14 @@
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
-		set_pte(pte, swp_entry_to_pte(entry));
+		pteval = ptep_xchg_flush(vma, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
-	}
+	} else
+		pteval = ptep_clear_flush(vma, address, pte);

+	/* Move the dirty bit to the physical page now the pte is gone. */
+	if (pte_dirty(pteval))
+		set_page_dirty(page);
 	atomic_dec(&mm->mm_rss);
 	page_remove_rmap(page);
 	page_cache_release(page);
@@ -666,15 +668,24 @@
 		if (ptep_clear_flush_young(vma, address, pte))
 			continue;

-		/* Nuke the page table entry. */
 		flush_cache_page(vma, address);
-		pteval = ptep_clear_flush(vma, address, pte);
+		/*
+		 * There would be a race here with the handle_mm_fault code that
+		 * bypasses the page_table_lock to allow a fast creation of ptes
+		 * if we would zap the pte before
+		 * putting something into it. On the other hand we need to
+		 * have the dirty flag when we replaced the value.
+		 * The dirty flag may be handled by a processor so we better
+		 * use an atomic operation here.
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

