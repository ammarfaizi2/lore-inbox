Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVA1UuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVA1UuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVA1Utd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:49:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:53430 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262784AbVA1Uii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:38:38 -0500
Date: Fri, 28 Jan 2005 12:37:40 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: page fault scalability patch V16 [3/4]: Drop page_table_lock in
 handle_mm_fault
In-Reply-To: <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
 <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
 <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
 <20050114043944.GB41559@muc.de> <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
 <20050114170140.GB4634@muc.de> <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The page fault handler attempts to use the page_table_lock only for short
time periods. It repeatedly drops and reacquires the lock. When the lock
is reacquired, checks are made if the underlying pte has changed before
replacing the pte value. These locations are a good fit for the use of
ptep_cmpxchg.

The following patch allows to remove the first time the page_table_lock is
acquired and uses atomic operations on the page table instead. A section
using atomic pte operations is begun with

	page_table_atomic_start(struct mm_struct *)

and ends with

	page_table_atomic_stop(struct mm_struct *)

Both of these become spin_lock(page_table_lock) and
spin_unlock(page_table_lock) if atomic page table operations are not
configured (CONFIG_ATOMIC_TABLE_OPS undefined).

Atomic operations with pte_xchg and pte_cmpxchg only work for the lowest
layer of the page table. Higher layers may also be populated in an atomic
way by defining pmd_test_and_populate() etc. The generic versions of these
functions fall back to the page_table_lock (populating higher level page
table entries is rare and therefore this is not likely to be performance
critical). For ia64 the definitions for higher level atomic operations is
included and these may easily be added for other architectures.

This patch depends on the pte_cmpxchg patch to be applied first and will
only remove the first use of the page_table_lock in the page fault handler.
This will allow the following page table operations without acquiring
the page_table_lock:

1. Updating of access bits (handle_mm_faults)
2. Anonymous read faults (do_anonymous_page)

The page_table_lock is still acquired for creating a new pte for an anonymous
write fault and therefore the problems with rss that were addressed by splitting
rss into the task structure do not yet occur.

The patch also adds some diagnostic features by counting the number of cmpxchg
failures (useful for verification if this patch works right) and the number of
faults received that led to no change in the page table. These statistics may
be viewed via /proc/meminfo

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-27 16:27:59.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-27 16:28:54.000000000 -0800
@@ -36,6 +36,8 @@
  *		(Gerhard.Wichert@pdb.siemens.de)
  *
  * Aug/Sep 2004 Changed to four level page tables (Andi Kleen)
+ * Jan 2005 	Scalability improvement by reducing the use and the length of time
+ *		the page table lock is held (Christoph Lameter)
  */

 #include <linux/kernel_stat.h>
@@ -1285,8 +1287,8 @@ static inline void break_cow(struct vm_a
  * change only once the write actually happens. This avoids a few races,
  * and potentially makes it more efficient.
  *
- * We hold the mm semaphore and the page_table_lock on entry and exit
- * with the page_table_lock released.
+ * We hold the mm semaphore and have started atomic pte operations,
+ * exit with pte ops completed.
  */
 static int do_wp_page(struct mm_struct *mm, struct vm_area_struct * vma,
 	unsigned long address, pte_t *page_table, pmd_t *pmd, pte_t pte)
@@ -1304,7 +1306,7 @@ static int do_wp_page(struct mm_struct *
 		pte_unmap(page_table);
 		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
 				address);
-		spin_unlock(&mm->page_table_lock);
+		page_table_atomic_stop(mm);
 		return VM_FAULT_OOM;
 	}
 	old_page = pfn_to_page(pfn);
@@ -1316,21 +1318,27 @@ static int do_wp_page(struct mm_struct *
 			flush_cache_page(vma, address);
 			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
 					      vma);
-			ptep_set_access_flags(vma, address, page_table, entry, 1);
-			update_mmu_cache(vma, address, entry);
+			/*
+			 * If the bits are not updated then another fault
+			 * will be generated with another chance of updating.
+			 */
+			if (ptep_cmpxchg(page_table, pte, entry))
+				update_mmu_cache(vma, address, entry);
+			else
+				inc_page_state(cmpxchg_fail_flag_reuse);
 			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
+			page_table_atomic_stop(mm);
 			return VM_FAULT_MINOR;
 		}
 	}
 	pte_unmap(page_table);
+	page_table_atomic_stop(mm);

 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
 	if (!PageReserved(old_page))
 		page_cache_get(old_page);
-	spin_unlock(&mm->page_table_lock);

 	if (unlikely(anon_vma_prepare(vma)))
 		goto no_new_page;
@@ -1340,7 +1348,8 @@ static int do_wp_page(struct mm_struct *
 	copy_cow_page(old_page,new_page,address);

 	/*
-	 * Re-check the pte - we dropped the lock
+	 * Re-check the pte - so far we may not have acquired the
+	 * page_table_lock
 	 */
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
@@ -1692,8 +1701,7 @@ void swapin_readahead(swp_entry_t entry,
 }

 /*
- * We hold the mm semaphore and the page_table_lock on entry and
- * should release the pagetable lock on exit..
+ * We hold the mm semaphore and have started atomic pte operations
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
@@ -1705,15 +1713,14 @@ static int do_swap_page(struct mm_struct
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
@@ -1732,12 +1739,11 @@ static int do_swap_page(struct mm_struct
 		grab_swap_token();
 	}

-	mark_page_accessed(page);
+	SetPageReferenced(page);
 	lock_page(page);

 	/*
-	 * Back out if somebody else faulted in this pte while we
-	 * released the page table lock.
+	 * Back out if somebody else faulted in this pte
 	 */
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
@@ -1771,80 +1777,94 @@ static int do_swap_page(struct mm_struct
 	set_pte(page_table, pte);
 	page_add_anon_rmap(page, vma, address);

+	/* No need to invalidate - it was non-present before */
+	update_mmu_cache(vma, address, pte);
+	pte_unmap(page_table);
+	spin_unlock(&mm->page_table_lock);
+
 	if (write_access) {
+		page_table_atomic_start(mm);
 		if (do_wp_page(mm, vma, address,
 				page_table, pmd, pte) == VM_FAULT_OOM)
 			ret = VM_FAULT_OOM;
-		goto out;
 	}

-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, address, pte);
-	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
 out:
 	return ret;
 }

 /*
- * We are called with the MM semaphore and page_table_lock
- * spinlock held to protect against concurrent faults in
- * multithreaded programs.
+ * We are called with the MM semaphore held and atomic pte operations started.
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
+		 * If the cmpxchg fails then another fault may be
+		 * generated that may then be successful
+		 */
+
+		if (ptep_cmpxchg(page_table, orig_entry, entry))
+			update_mmu_cache(vma, addr, entry);
+		else
+			inc_page_state(cmpxchg_fail_anon_read);
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
+		page_table_atomic_stop(mm);

-		if (unlikely(anon_vma_prepare(vma)))
-			goto no_mem;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
-		if (!page)
-			goto no_mem;
-		clear_user_highpage(page, addr);
+		return VM_FAULT_MINOR;
+	}

-		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);
+	page_table_atomic_stop(mm);

-		if (!pte_none(*page_table)) {
-			pte_unmap(page_table);
-			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
-		}
-		update_mm_counter(mm, rss, 1);
-		acct_update_integrals();
-		update_mem_hiwater();
-		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
-							 vma->vm_page_prot)),
-				      vma);
-		lru_cache_add_active(page);
-		SetPageReferenced(page);
-		page_add_anon_rmap(page, vma, addr);
+	/* Allocate our own private page. */
+	if (unlikely(anon_vma_prepare(vma)))
+		return VM_FAULT_OOM;
+
+	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	if (!page)
+		return VM_FAULT_OOM;
+	clear_user_highpage(page, addr);
+
+	entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
+						 vma->vm_page_prot)),
+			      vma);
+
+	spin_lock(&mm->page_table_lock);
+
+	if (!ptep_cmpxchg(page_table, orig_entry, entry)) {
+		pte_unmap(page_table);
+		page_cache_release(page);
+		spin_unlock(&mm->page_table_lock);
+		inc_page_state(cmpxchg_fail_anon_write);
+		return VM_FAULT_MINOR;
 	}

-	set_pte(page_table, entry);
-	pte_unmap(page_table);
+	/*
+	 * These two functions must come after the cmpxchg
+	 * because if the page is on the LRU then try_to_unmap may come
+	 * in and unmap the pte.
+	 */
+	page_add_anon_rmap(page, vma, addr);
+	lru_cache_add_active(page);
+	update_mm_counter(mm, rss, 1);
+	acct_update_integrals();
+	update_mem_hiwater();

-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, addr, entry);
+	update_mmu_cache(vma, addr, entry);
+	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
-out:
+
 	return VM_FAULT_MINOR;
-no_mem:
-	return VM_FAULT_OOM;
 }

 /*
@@ -1856,12 +1876,12 @@ no_mem:
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
@@ -1872,9 +1892,9 @@ do_no_page(struct mm_struct *mm, struct

 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
-					pmd, write_access, address);
+					pmd, write_access, address, orig_entry);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);

 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1982,7 +2002,7 @@ oom:
  * nonlinear vmas.
  */
 static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd, pte_t entry)
 {
 	unsigned long pgoff;
 	int err;
@@ -1995,13 +2015,13 @@ static int do_file_page(struct mm_struct
 	if (!vma->vm_ops || !vma->vm_ops->populate ||
 			(write_access && !(vma->vm_flags & VM_SHARED))) {
 		pte_clear(pte);
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
@@ -2020,49 +2040,45 @@ static int do_file_page(struct mm_struct
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

+	new_entry = pte_mkyoung(entry);
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
-
-		entry = pte_mkdirty(entry);
+		new_entry = pte_mkdirty(new_entry);
 	}
-	entry = pte_mkyoung(entry);
-	ptep_set_access_flags(vma, address, pte, entry, write_access);
-	update_mmu_cache(vma, address, entry);
+
+	/*
+	 * If the cmpxchg fails then we will get another fault which
+ 	 * has another chance of successfully updating the page table entry.
+	 */
+	if (ptep_cmpxchg(pte, entry, new_entry)) {
+		flush_tlb_page(vma, address);
+		update_mmu_cache(vma, address, entry);
+	} else
+		inc_page_state(cmpxchg_fail_flag_update);
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);
+	if (pte_val(new_entry) == pte_val(entry))
+		inc_page_state(spurious_page_faults);
 	return VM_FAULT_MINOR;
 }

@@ -2081,33 +2097,73 @@ int handle_mm_fault(struct mm_struct *mm

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
+
+		page_table_atomic_stop(mm);
+		new = pud_alloc_one(mm, address);
+
+		if (!new)
+			return VM_FAULT_OOM;
+
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

-	pud = pud_alloc(mm, pgd, address);
-	if (!pud)
-		goto oom;
-
-	pmd = pmd_alloc(mm, pud, address);
-	if (!pmd)
-		goto oom;
-
-	pte = pte_alloc_map(mm, pmd, address);
-	if (!pte)
-		goto oom;
+		if (!new)
+			return VM_FAULT_OOM;

-	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+		page_table_atomic_start(mm);
+
+		if (!pud_test_and_populate(mm, pud, new))
+			pmd_free(new);
+	}

- oom:
-	spin_unlock(&mm->page_table_lock);
-	return VM_FAULT_OOM;
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

 #ifndef __ARCH_HAS_4LEVEL_HACK
Index: linux-2.6.10/include/asm-generic/pgtable-nopud.h
===================================================================
--- linux-2.6.10.orig/include/asm-generic/pgtable-nopud.h	2005-01-27 14:47:20.000000000 -0800
+++ linux-2.6.10/include/asm-generic/pgtable-nopud.h	2005-01-27 16:28:54.000000000 -0800
@@ -25,8 +25,14 @@ static inline int pgd_bad(pgd_t pgd)		{
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
Index: linux-2.6.10/include/asm-generic/pgtable-nopmd.h
===================================================================
--- linux-2.6.10.orig/include/asm-generic/pgtable-nopmd.h	2005-01-27 14:47:20.000000000 -0800
+++ linux-2.6.10/include/asm-generic/pgtable-nopmd.h	2005-01-27 16:28:54.000000000 -0800
@@ -29,6 +29,11 @@ static inline void pud_clear(pud_t *pud)
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))

 #define pud_populate(mm, pmd, pte)		do { } while (0)
+#define __ARCH_HAVE_PUD_TEST_AND_POPULATE
+static inline int pud_test_and_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+{
+	return 1;
+}

 /*
  * (pmds are folded into puds so this doesn't get actually called,
Index: linux-2.6.10/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.10.orig/include/asm-generic/pgtable.h	2005-01-27 16:27:40.000000000 -0800
+++ linux-2.6.10/include/asm-generic/pgtable.h	2005-01-27 16:30:35.000000000 -0800
@@ -105,8 +105,14 @@ static inline pte_t ptep_get_and_clear(p
 #ifdef CONFIG_ATOMIC_TABLE_OPS

 /*
- * The architecture does support atomic table operations.
- * Thus we may provide generic atomic ptep_xchg and ptep_cmpxchg using
+ * The architecture does support atomic table operations and
+ * all operations on page table entries must always be atomic.
+ *
+ * This means that the kernel will never encounter a partially updated
+ * page table entry.
+ *
+ * Since the architecture does support atomic table operations, we
+ * may provide generic atomic ptep_xchg and ptep_cmpxchg using
  * cmpxchg and xchg.
  */
 #ifndef __HAVE_ARCH_PTEP_XCHG
@@ -132,6 +138,65 @@ static inline pte_t ptep_get_and_clear(p
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
@@ -142,6 +207,11 @@ static inline pte_t ptep_get_and_clear(p
  * short time frame. This means that the page_table_lock must be held
  * to avoid a page fault that would install a new entry.
  */
+
+/* Fall back to the page table lock to synchronize page table access */
+#define page_table_atomic_start(mm)	spin_lock(&(mm)->page_table_lock)
+#define page_table_atomic_stop(mm)	spin_unlock(&(mm)->page_table_lock)
+
 #ifndef __HAVE_ARCH_PTEP_XCHG
 #define ptep_xchg(__ptep, __pteval)					\
 ({									\
@@ -186,6 +256,41 @@ static inline pte_t ptep_get_and_clear(p
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
Index: linux-2.6.10/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/pgtable.h	2005-01-27 14:47:20.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/pgtable.h	2005-01-27 16:33:24.000000000 -0800
@@ -554,6 +554,8 @@ do {											\
 #define FIXADDR_USER_START	GATE_ADDR
 #define FIXADDR_USER_END	(GATE_ADDR + 2*PERCPU_PAGE_SIZE)

+#define __HAVE_ARCH_PUD_TEST_AND_POPULATE
+#define __HAVE_ARCH_PMD_TEST_AND_POPULATE
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
@@ -561,7 +563,7 @@ do {											\
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
-#include <asm-generic/pgtable.h>
 #include <asm-generic/pgtable-nopud.h>
+#include <asm-generic/pgtable.h>

 #endif /* _ASM_IA64_PGTABLE_H */
Index: linux-2.6.10/include/linux/page-flags.h
===================================================================
--- linux-2.6.10.orig/include/linux/page-flags.h	2005-01-27 14:47:20.000000000 -0800
+++ linux-2.6.10/include/linux/page-flags.h	2005-01-27 16:28:54.000000000 -0800
@@ -131,6 +131,17 @@ struct page_state {
 	unsigned long allocstall;	/* direct reclaim calls */

 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
+
+	/* Low level counters */
+	unsigned long spurious_page_faults;	/* Faults with no ops */
+	unsigned long cmpxchg_fail_flag_update;	/* cmpxchg failures for pte flag update */
+	unsigned long cmpxchg_fail_flag_reuse;	/* cmpxchg failures when cow reuse of pte */
+	unsigned long cmpxchg_fail_anon_read;	/* cmpxchg failures on anonymous read */
+	unsigned long cmpxchg_fail_anon_write;	/* cmpxchg failures on anonymous write */
+
+	/* rss deltas for the current executing thread */
+	long rss;
+	long anon_rss;
 };

 extern void get_page_state(struct page_state *ret);
Index: linux-2.6.10/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.10.orig/fs/proc/proc_misc.c	2005-01-27 14:47:19.000000000 -0800
+++ linux-2.6.10/fs/proc/proc_misc.c	2005-01-27 16:28:54.000000000 -0800
@@ -127,7 +127,7 @@ static int meminfo_read_proc(char *page,
 	unsigned long allowed;
 	struct vmalloc_info vmi;

-	get_page_state(&ps);
+	get_full_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);

 /*
@@ -168,7 +168,12 @@ static int meminfo_read_proc(char *page,
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
@@ -191,7 +196,12 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_page_table_pages),
 		VMALLOC_TOTAL >> 10,
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
Index: linux-2.6.10/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/pgalloc.h	2005-01-27 14:47:20.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/pgalloc.h	2005-01-27 16:33:10.000000000 -0800
@@ -34,6 +34,10 @@
 #define pmd_quicklist		(local_cpu_data->pmd_quick)
 #define pgtable_cache_size	(local_cpu_data->pgtable_cache_sz)

+/* Empty entries of PMD and PGD */
+#define PMD_NONE       0
+#define PUD_NONE       0
+
 static inline pgd_t*
 pgd_alloc_one_fast (struct mm_struct *mm)
 {
@@ -82,6 +86,13 @@ pud_populate (struct mm_struct *mm, pud_
 	pud_val(*pud_entry) = __pa(pmd);
 }

+/* Atomic populate */
+static inline int
+pud_test_and_populate (struct mm_struct *mm, pud_t *pud_entry, pmd_t *pmd)
+{
+	return ia64_cmpxchg8_acq(pud_entry,__pa(pmd), PUD_NONE) == PUD_NONE;
+}
+
 static inline pmd_t*
 pmd_alloc_one_fast (struct mm_struct *mm, unsigned long addr)
 {
@@ -127,6 +138,14 @@ pmd_populate (struct mm_struct *mm, pmd_
 	pmd_val(*pmd_entry) = page_to_phys(pte);
 }

+/* Atomic populate */
+static inline int
+pmd_test_and_populate (struct mm_struct *mm, pmd_t *pmd_entry, struct page *pte)
+{
+	return ia64_cmpxchg8_acq(pmd_entry, page_to_phys(pte), PMD_NONE) == PMD_NONE;
+}
+
+
 static inline void
 pmd_populate_kernel (struct mm_struct *mm, pmd_t *pmd_entry, pte_t *pte)
 {

