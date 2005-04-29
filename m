Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVD2UGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVD2UGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVD2UGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:06:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56996 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262923AbVD2T7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:59:20 -0400
Date: Fri, 29 Apr 2005 12:59:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20050429195912.15694.17284.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20050429195901.15694.28520.sendpatchset@schroedinger.engr.sgi.com>
References: <20050429195901.15694.28520.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/3] Page Fault Scalability V20: Avoid first acquisition of lock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The page fault handler attempts to use the page_table_lock only for short
time periods. It repeatedly drops and reacquires the lock. When the lock
is reacquired, checks are made if the underlying pte has changed before
replacing the pte value. These locations are a good fit for the use of
ptep_cmpxchg.

The following patch allows the use of atomic operations to remove first
acquisition of the page_table_lock. A section
using atomic pte operations is begun with

	page_table_atomic_start(struct mm_struct *)

and ends with

	page_table_atomic_stop(struct mm_struct *)

Both of these become spin_lock(page_table_lock) and
spin_unlock(page_table_lock) if atomic page table operations are not
configured (CONFIG_ATOMIC_TABLE_OPS undefined).

Atomic pte operations using pte_xchg and pte_cmpxchg only work for the lowest
layer of the page table. Higher layers may also be populated in an atomic
way by defining pmd_test_and_populate() etc. The generic versions of these
functions fall back to the page_table_lock. Populating higher level page
table entries is rare and therefore this is not likely to be performance
critical. For ia64 a definition of higher level atomic operations is
included.

This patch depends on the patch to avoid spurious page faults to be applied
first and will only remove the first acquisition of the page_table_lock in
the page fault handler. This will allow the following page table operations
without acquiring the page_table_lock:

1. Updating of access bits (handle_mm_fault)
2. Anonymous read faults (do_anonymous_page)

The page_table_lock is still acquired for creating a new pte for an anonymous
write fault and therefore the problems with atomic updates of rss do not yet occur.

The patch also adds some diagnostic features by counting the number of cmpxchg
failures (useful for verification if this patch works right) and the number of
page faults that led to no change in the page table. The statistics may be
accessed via /proc/meminfo.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/mm/memory.c
===================================================================
--- linux-2.6.11.orig/mm/memory.c	2005-04-29 12:12:38.000000000 -0700
+++ linux-2.6.11/mm/memory.c	2005-04-29 12:12:45.000000000 -0700
@@ -36,6 +36,8 @@
  *		(Gerhard.Wichert@pdb.siemens.de)
  *
  * Aug/Sep 2004 Changed to four level page tables (Andi Kleen)
+ * Jan 2005 	Scalability improvement by reducing the use and the length of time
+ *		the page table lock is held (Christoph Lameter)
  */
 
 #include <linux/kernel_stat.h>
@@ -1655,8 +1657,7 @@ void swapin_readahead(swp_entry_t entry,
 }
 
 /*
- * We hold the mm semaphore and the page_table_lock on entry and
- * should release the pagetable lock on exit..
+ * We hold the mm semaphore and have started atomic pte operations
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
@@ -1668,15 +1669,14 @@ static int do_swap_page(struct mm_struct
 	int ret = VM_FAULT_MINOR;
 
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);
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
@@ -1699,8 +1699,7 @@ static int do_swap_page(struct mm_struct
 	lock_page(page);
 
 	/*
-	 * Back out if somebody else faulted in this pte while we
-	 * released the page table lock.
+	 * Back out if somebody else faulted in this pte
 	 */
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
@@ -1748,62 +1747,72 @@ out:
 }
 
 /*
- * We are called with the MM semaphore and page_table_lock
- * spinlock held to protect against concurrent faults in
- * multithreaded programs. 
+ * We are called with atomic operations started and the
+ * value of the pte that was read in orig_entry.
  */
 static int
 do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		pte_t *page_table, pmd_t *pmd, int write_access,
-		unsigned long addr)
+		unsigned long addr, pte_t orig_entry)
 {
 	pte_t entry;
-	struct page * page = ZERO_PAGE(addr);
+	struct page * page;
 
-	/* Read-only mapping of ZERO_PAGE. */
-	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+	if (unlikely(!write_access)) {
 
-	/* ..except if it's a write access */
-	if (write_access) {
-		/* Allocate our own private page. */
+		/* Read-only mapping of ZERO_PAGE. */
+		entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+
+		/*
+		 * If the cmpxchg fails then another cpu may
+		 * already have populated the entry
+		*/
+
+		if (ptep_cmpxchg(mm, addr, page_table, orig_entry, entry)) {
+			update_mmu_cache(vma, addr, entry);
+			lazy_mmu_prot_update(entry);
+		} else
+			inc_page_state(cmpxchg_fail_anon_read);
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
+		page_table_atomic_stop(mm);
+		return VM_FAULT_MINOR;
+	}
 
-		if (unlikely(anon_vma_prepare(vma)))
-			goto no_mem;
-		page = alloc_zeroed_user_highpage(vma, addr);
-		if (!page)
-			goto no_mem;
+	/* This leaves the write case */
+	page_table_atomic_stop(mm);
+	if (unlikely(anon_vma_prepare(vma)))
+		return VM_FAULT_OOM;
 
-		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);
+	page = alloc_zeroed_user_highpage(vma, addr);
+	if (!page)
+		return VM_FAULT_OOM;
 
-		if (!pte_none(*page_table)) {
-			pte_unmap(page_table);
-			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
-		}
-		inc_mm_counter(mm, rss);
-		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
-							 vma->vm_page_prot)),
-				      vma);
-		lru_cache_add_active(page);
-		SetPageReferenced(page);
-		page_add_anon_rmap(page, vma, addr);
-	}
+	entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
+						vma->vm_page_prot)),
+				vma);
+	spin_lock(&mm->page_table_lock);
 
-	set_pte_at(mm, addr, page_table, entry);
-	pte_unmap(page_table);
+	if (!ptep_cmpxchg(mm, addr, page_table, orig_entry, entry)) {
+		pte_unmap(page_table);
+		page_cache_release(page);
+		spin_unlock(&mm->page_table_lock);
+		inc_page_state(cmpxchg_fail_anon_write);
+		return VM_FAULT_MINOR;
+        }
 
-	/* No need to invalidate - it was non-present before */
+	/*
+	 * These two functions must come after the cmpxchg
+	 * because if the page is on the LRU then try_to_unmap may come
+	 * in and unmap the pte.
+	 */
+	page_add_anon_rmap(page, vma, addr);
+	lru_cache_add_active(page);
+	inc_mm_counter(mm, rss);
+	pte_unmap(page_table);
 	update_mmu_cache(vma, addr, entry);
 	lazy_mmu_prot_update(entry);
 	spin_unlock(&mm->page_table_lock);
-out:
 	return VM_FAULT_MINOR;
-no_mem:
-	return VM_FAULT_OOM;
 }
 
 /*
@@ -1815,12 +1824,12 @@ no_mem:
  * As this is called only for pages that do not currently exist, we
  * do not need to flush old virtual caches or the TLB.
  *
- * This is called with the MM semaphore held and the page table
- * spinlock held. Exit with the spinlock released.
+ * This is called with the MM semaphore held and atomic pte operations started.
  */
 static int
 do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
-	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
+	unsigned long address, int write_access, pte_t *page_table,
+        pmd_t *pmd, pte_t orig_entry)
 {
 	struct page * new_page;
 	struct address_space *mapping = NULL;
@@ -1831,9 +1840,9 @@ do_no_page(struct mm_struct *mm, struct 
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
-					pmd, write_access, address);
+					pmd, write_access, address, orig_entry);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);
 
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1940,7 +1949,7 @@ oom:
  * nonlinear vmas.
  */
 static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd, pte_t entry)
 {
 	unsigned long pgoff;
 	int err;
@@ -1953,13 +1962,13 @@ static int do_file_page(struct mm_struct
 	if (!vma->vm_ops || !vma->vm_ops->populate || 
 			(write_access && !(vma->vm_flags & VM_SHARED))) {
 		pte_clear(mm, address, pte);
-		return do_no_page(mm, vma, address, write_access, pte, pmd);
+		return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
 	}
 
-	pgoff = pte_to_pgoff(*pte);
+	pgoff = pte_to_pgoff(entry);
 
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);
 
 	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
 	if (err == -ENOMEM)
@@ -1978,50 +1987,72 @@ static int do_file_page(struct mm_struct
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
- */
+ * Note that kswapd only ever _removes_ pages, never adds them.
+ * We exploit that case if possible to avoid taking the
+ * page table lock.
+*/
 static inline int handle_pte_fault(struct mm_struct *mm,
 	struct vm_area_struct * vma, unsigned long address,
 	int write_access, pte_t *pte, pmd_t *pmd)
 {
 	pte_t entry;
+	pte_t new_entry;
 
 	entry = *pte;
 	if (!pte_present(entry)) {
 		/*
-		 * If it truly wasn't present, we know that kswapd
-		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
+		 * Pass the value of the pte to do_no_page and do_file_page
+		 * This value may be used to verify that the pte is still
+		 * not present allowing atomic insertion of ptes.
 		 */
 		if (pte_none(entry))
-			return do_no_page(mm, vma, address, write_access, pte, pmd);
+			return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
 		if (pte_file(entry))
-			return do_file_page(mm, vma, address, write_access, pte, pmd);
+			return do_file_page(mm, vma, address, write_access, pte, pmd, entry);
 		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}
 
+	new_entry = pte_mkyoung(entry);
 	if (write_access) {
-		if (!pte_write(entry))
-			return do_wp_page(mm, vma, address, pte, pmd, entry);
-
+		if (!pte_write(entry)) {
+#ifdef CONFIG_ATOMIC_TABLE_OPS
+			/* do_wp_page modifies a pte. We can add a pte without the
+			 * page_table_lock but not modify a pte since a cmpxchg
+			 * does not allow us to verify that the page was not
+			 * changed under us. So acquire the page table lock.
+			 */
+			spin_lock(&mm->page_table_lock);
+			if (pte_same(entry, *pte))
+#endif
+				return do_wp_page(mm, vma, address, pte, pmd, entry);
+#ifdef CONFIG_ATOMIC_TABLE_OPS
+			/* pte was changed under us. Another processor may have
+			 * done what we needed to do.
+			 */
+			pte_unmap(pte);
+			spin_unlock(&mm->page_table_lock);
+			return VM_FAULT_MINOR;
+#endif
+		}
 		entry = pte_mkdirty(entry);
 	}
-	entry = pte_mkyoung(entry);
-	ptep_set_access_flags(vma, address, pte, entry, write_access);
-	update_mmu_cache(vma, address, entry);
-	lazy_mmu_prot_update(entry);
+
+	/*
+	 * If the cmpxchg fails then another processor may have done
+	 * the changes for us. If not then another fault will bring
+	 * another chance to do this again.
+	*/
+	if (ptep_cmpxchg(mm, address, pte, entry, new_entry)) {
+		flush_tlb_page(vma, address);
+		update_mmu_cache(vma, address, entry);
+		lazy_mmu_prot_update(entry);
+	} else
+		inc_page_state(cmpxchg_fail_flag_update);
+
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);
+	if (pte_val(new_entry) == pte_val(entry))
+		inc_page_state(spurious_page_faults);
 	return VM_FAULT_MINOR;
 }
 
@@ -2040,33 +2071,73 @@ int handle_mm_fault(struct mm_struct *mm
 
 	inc_page_state(pgfault);
 
-	if (is_vm_hugetlb_page(vma))
+	if (unlikely(is_vm_hugetlb_page(vma)))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
 
 	/*
-	 * We need the page table lock to synchronize with kswapd
-	 * and the SMP-safe atomic PTE updates.
+	 * We try to rely on the mmap_sem and the SMP-safe atomic PTE updates.
+	 * to synchronize with kswapd. However, the arch may fall back
+	 * in page_table_atomic_start to the page table lock.
+	 *
+	 * We may be able to avoid taking and releasing the page_table_lock
+	 * for the p??_alloc functions through atomic operations so we
+	 * duplicate the functionality of pmd_alloc, pud_alloc and
+	 * pte_alloc_map here.
 	 */
+	page_table_atomic_start(mm);
 	pgd = pgd_offset(mm, address);
-	spin_lock(&mm->page_table_lock);
+	if (unlikely(pgd_none(*pgd))) {
+		pud_t *new;
 
-	pud = pud_alloc(mm, pgd, address);
-	if (!pud)
-		goto oom;
+		page_table_atomic_stop(mm);
+		new = pud_alloc_one(mm, address);
 
-	pmd = pmd_alloc(mm, pud, address);
-	if (!pmd)
-		goto oom;
+		if (!new)
+			return VM_FAULT_OOM;
 
-	pte = pte_alloc_map(mm, pmd, address);
-	if (!pte)
-		goto oom;
+		page_table_atomic_start(mm);
+		if (!pgd_test_and_populate(mm, pgd, new))
+			pud_free(new);
+	}
+
+	pud = pud_offset(pgd, address);
+	if (unlikely(pud_none(*pud))) {
+		pmd_t *new;
+
+		page_table_atomic_stop(mm);
+		new = pmd_alloc_one(mm, address);
+
+		if (!new)
+			return VM_FAULT_OOM;
 	
-	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+		page_table_atomic_start(mm);
 
- oom:
-	spin_unlock(&mm->page_table_lock);
-	return VM_FAULT_OOM;
+		if (!pud_test_and_populate(mm, pud, new))
+			pmd_free(new);
+	}
+
+	pmd = pmd_offset(pud, address);
+	if (unlikely(!pmd_present(*pmd))) {
+		struct page *new;
+
+		page_table_atomic_stop(mm);
+		new = pte_alloc_one(mm, address);
+
+		if (!new)
+			return VM_FAULT_OOM;
+
+		page_table_atomic_start(mm);
+
+		if (!pmd_test_and_populate(mm, pmd, new))
+			pte_free(new);
+		else {
+			inc_page_state(nr_page_table_pages);
+			mm->nr_ptes++;
+		}
+	}
+
+	pte = pte_offset_map(pmd, address);
+	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 }
 
 #ifndef __PAGETABLE_PUD_FOLDED
Index: linux-2.6.11/include/asm-generic/pgtable-nopud.h
===================================================================
--- linux-2.6.11.orig/include/asm-generic/pgtable-nopud.h	2005-04-29 12:12:01.000000000 -0700
+++ linux-2.6.11/include/asm-generic/pgtable-nopud.h	2005-04-29 12:12:45.000000000 -0700
@@ -27,8 +27,14 @@ static inline int pgd_bad(pgd_t pgd)		{ 
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
 static inline void pgd_clear(pgd_t *pgd)	{ }
 #define pud_ERROR(pud)				(pgd_ERROR((pud).pgd))
-
 #define pgd_populate(mm, pgd, pud)		do { } while (0)
+
+#define __HAVE_ARCH_PGD_TEST_AND_POPULATE
+static inline int pgd_test_and_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+{
+	return 1;
+}
+
 /*
  * (puds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
Index: linux-2.6.11/include/asm-generic/pgtable-nopmd.h
===================================================================
--- linux-2.6.11.orig/include/asm-generic/pgtable-nopmd.h	2005-04-29 12:12:01.000000000 -0700
+++ linux-2.6.11/include/asm-generic/pgtable-nopmd.h	2005-04-29 12:12:45.000000000 -0700
@@ -31,6 +31,11 @@ static inline void pud_clear(pud_t *pud)
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
 
 #define pud_populate(mm, pmd, pte)		do { } while (0)
+#define __ARCH_HAVE_PUD_TEST_AND_POPULATE
+static inline int pud_test_and_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+{
+	return 1;
+}
 
 /*
  * (pmds are folded into puds so this doesn't get actually called,
Index: linux-2.6.11/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.11.orig/include/asm-generic/pgtable.h	2005-04-29 12:12:38.000000000 -0700
+++ linux-2.6.11/include/asm-generic/pgtable.h	2005-04-29 12:12:45.000000000 -0700
@@ -141,6 +141,65 @@ do {				  					  \
 })
 #endif
 
+/*
+ * page_table_atomic_start and page_table_atomic_stop may be used to
+ * define special measures that an arch needs to guarantee atomic
+ * operations outside of a spinlock. In the case that an arch does
+ * not support atomic page table operations we will fall back to the
+ * page table lock.
+ */
+#ifndef __HAVE_ARCH_PAGE_TABLE_ATOMIC_START
+#define page_table_atomic_start(mm) do { } while (0)
+#endif
+
+#ifndef __HAVE_ARCH_PAGE_TABLE_ATOMIC_START
+#define page_table_atomic_stop(mm) do { } while (0)
+#endif
+
+/*
+ * Fallback functions for atomic population of higher page table
+ * structures. These simply acquire the page_table_lock for
+ * synchronization. An architecture may override these generic
+ * functions to provide atomic populate functions to make these
+ * more effective.
+ */
+
+#ifndef __HAVE_ARCH_PGD_TEST_AND_POPULATE
+#define pgd_test_and_populate(__mm, __pgd, __pud)			\
+({									\
+	int __rc;							\
+	spin_lock(&mm->page_table_lock);				\
+	__rc = pgd_none(*(__pgd));					\
+	if (__rc) pgd_populate(__mm, __pgd, __pud);			\
+	spin_unlock(&mm->page_table_lock);				\
+	__rc;								\
+})
+#endif
+
+#ifndef __HAVE_ARCH_PUD_TEST_AND_POPULATE
+#define pud_test_and_populate(__mm, __pud, __pmd)			\
+({									\
+	int __rc;							\
+	spin_lock(&mm->page_table_lock);				\
+	__rc = pud_none(*(__pud));					\
+	if (__rc) pud_populate(__mm, __pud, __pmd);			\
+	spin_unlock(&mm->page_table_lock);				\
+	__rc;								\
+})
+#endif
+
+#ifndef __HAVE_ARCH_PMD_TEST_AND_POPULATE
+#define pmd_test_and_populate(__mm, __pmd, __page)			\
+({									\
+	int __rc;							\
+	spin_lock(&mm->page_table_lock);				\
+	__rc = !pmd_present(*(__pmd));					\
+	if (__rc) pmd_populate(__mm, __pmd, __page);			\
+	spin_unlock(&mm->page_table_lock);				\
+	__rc;								\
+})
+#endif
+
 #else
 
 /*
@@ -151,6 +210,11 @@ do {				  					  \
  * short time frame. This means that the page_table_lock must be held
  * to avoid a page fault that would install a new entry.
  */
+
+/* Fall back to the page table lock to synchronize page table access */
+#define page_table_atomic_start(mm)	spin_lock(&(mm)->page_table_lock)
+#define page_table_atomic_stop(mm)	spin_unlock(&(mm)->page_table_lock)
+
 #ifndef __HAVE_ARCH_PTEP_XCHG
 #define ptep_xchg(__mm, __address, __ptep, __pteval)			\
 ({									\
@@ -195,6 +259,41 @@ do {				  					  \
 	r;								\
 })
 #endif
+
+/*
+ * Fallback functions for atomic population of higher page table
+ * structures. These rely on the page_table_lock being held.
+ */
+#ifndef __HAVE_ARCH_PGD_TEST_AND_POPULATE
+#define pgd_test_and_populate(__mm, __pgd, __pud)			\
+({									\
+	int __rc;							\
+	__rc = pgd_none(*(__pgd));					\
+	if (__rc) pgd_populate(__mm, __pgd, __pud);			\
+	__rc;								\
+})
+#endif
+
+#ifndef __HAVE_ARCH_PUD_TEST_AND_POPULATE
+#define pud_test_and_populate(__mm, __pud, __pmd)			\
+({									\
+       int __rc;							\
+       __rc = pud_none(*(__pud));					\
+       if (__rc) pud_populate(__mm, __pud, __pmd);			\
+       __rc;								\
+})
+#endif
+
+#ifndef __HAVE_ARCH_PMD_TEST_AND_POPULATE
+#define pmd_test_and_populate(__mm, __pmd, __page)			\
+({									\
+       int __rc;							\
+       __rc = !pmd_present(*(__pmd));					\
+       if (__rc) pmd_populate(__mm, __pmd, __page);			\
+       __rc;								\
+})
+#endif
+
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
Index: linux-2.6.11/include/linux/page-flags.h
===================================================================
--- linux-2.6.11.orig/include/linux/page-flags.h	2005-04-29 12:12:02.000000000 -0700
+++ linux-2.6.11/include/linux/page-flags.h	2005-04-29 12:12:45.000000000 -0700
@@ -131,6 +131,13 @@ struct page_state {
 	unsigned long allocstall;	/* direct reclaim calls */
 
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
+
+	/* Page fault related counters */
+	unsigned long spurious_page_faults;	/* Faults with no ops */
+	unsigned long cmpxchg_fail_flag_update;	/* cmpxchg failures for pte flag update */
+	unsigned long cmpxchg_fail_flag_reuse;	/* cmpxchg failures when cow reuse of pte */
+	unsigned long cmpxchg_fail_anon_read;	/* cmpxchg failures on anonymous read */
+	unsigned long cmpxchg_fail_anon_write;	/* cmpxchg failures on anonymous write */
 };
 
 extern void get_page_state(struct page_state *ret);
Index: linux-2.6.11/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.11.orig/fs/proc/proc_misc.c	2005-04-29 12:12:01.000000000 -0700
+++ linux-2.6.11/fs/proc/proc_misc.c	2005-04-29 12:12:45.000000000 -0700
@@ -128,7 +128,7 @@ static int meminfo_read_proc(char *page,
 	struct vmalloc_info vmi;
 	long cached;
 
-	get_page_state(&ps);
+	get_full_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
 /*
@@ -173,7 +173,12 @@ static int meminfo_read_proc(char *page,
 		"PageTables:   %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
-		"VmallocChunk: %8lu kB\n",
+		"VmallocChunk: %8lu kB\n"
+		"Spurious page faults    : %8lu\n"
+		"cmpxchg fail flag update: %8lu\n"
+		"cmpxchg fail COW reuse  : %8lu\n"
+		"cmpxchg fail anon read  : %8lu\n"
+		"cmpxchg fail anon write : %8lu\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
@@ -196,7 +201,12 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_page_table_pages),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
-		vmi.largest_chunk >> 10
+		vmi.largest_chunk >> 10,
+		ps.spurious_page_faults,
+		ps.cmpxchg_fail_flag_update,
+		ps.cmpxchg_fail_flag_reuse,
+		ps.cmpxchg_fail_anon_read,
+		ps.cmpxchg_fail_anon_write
 		);
 
 		len += hugetlb_report_meminfo(page + len);
Index: linux-2.6.11/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.11.orig/include/asm-ia64/pgalloc.h	2005-04-29 12:12:01.000000000 -0700
+++ linux-2.6.11/include/asm-ia64/pgalloc.h	2005-04-29 12:14:58.000000000 -0700
@@ -22,6 +22,10 @@
 
 #include <asm/mmu_context.h>
 
+/* Empty entries of PMD and PGD */
+#define PMD_NONE       0
+#define PUD_NONE       0
+
 /*
  * Very stupidly, we used to get new pgd's and pmd's, init their contents
  * to point to the NULL versions of the next level page table, later on
@@ -108,6 +112,21 @@ pmd_alloc_one (struct mm_struct *mm, uns
 	return pmd;
 }
 
+/* Atomic populate */
+static inline int
+pud_test_and_populate (struct mm_struct *mm, pud_t *pud_entry, pmd_t *pmd)
+{
+	return ia64_cmpxchg8_acq(pud_entry,__pa(pmd), PUD_NONE) == PUD_NONE;
+}
+
+/* Atomic populate */
+static inline int
+pmd_test_and_populate (struct mm_struct *mm, pmd_t *pmd_entry, struct page *pte)
+{
+	return ia64_cmpxchg8_acq(pmd_entry, page_to_phys(pte), PMD_NONE) == PMD_NONE;
+}
+
+
 static inline void
 pmd_free (pmd_t *pmd)
 {
Index: linux-2.6.11/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.11.orig/include/asm-ia64/pgtable.h	2005-04-29 12:12:01.000000000 -0700
+++ linux-2.6.11/include/asm-ia64/pgtable.h	2005-04-29 12:12:45.000000000 -0700
@@ -560,6 +560,8 @@ do {											\
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
 #define __HAVE_ARCH_LAZY_MMU_PROT_UPDATE
+#define __HAVE_ARCH_PUD_TEST_AND_POPULATE
+#define __HAVE_ARCH_PMD_TEST_AND_POPULATE
 
 #include <asm-generic/pgtable-nopud.h>
 #include <asm-generic/pgtable.h>
