Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUHXEr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUHXEr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 00:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUHXEr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 00:47:29 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:30129 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264443AbUHXEpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 00:45:32 -0400
Date: Mon, 23 Aug 2004 21:43:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu
Subject: page fault scalability patch v3: use cmpxchg, make rss atomic
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0408232138540.32721@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
 <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
 <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third release of the page fault scalability patches. The scalability
patches avoid locking during the creation of page table entries for anonymous
memory in a threaded application running on a SMP system. The performance
increases significantly for more than 2 threads running concurrently.

Changes:
- use cmpxchg instead of pte_locking
- modify the existing function instead of creating a fastpath
- make rss in mm_struct atomic

Issue remaining:
- Support is only provided for i386 and ia64. Other architectures
  may need to be updated if the provided generic functions do not
  fit. This is especially necessary for architectures supporting SMP.
- i386 version builds fine but untested
- Figure out why performance drops for single thread.
- More testing needed. Is this really addressing all issues?

Ideas:
- Remove page_table_lock from __pmd_alloc and pte_alloc_map.
- Find further code paths that could benefit from removing the page_table lock

==== Test results on an 8 CPU SMP system

Unpatched:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  2   3    1    0.094s      4.500s   4.059s 85561.646  85568.398
  2   3    2    0.092s      6.390s   3.043s 60649.650 114521.474
  2   3    4    0.081s      6.500s   1.093s 59740.813 203552.963
  2   3    8    0.101s     12.001s   2.035s 32487.736 167082.560

With page fault fastpath patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4   3    1    0.176s     11.323s  11.050s 68385.368  68345.055
  4   3    2    0.174s     10.716s   5.096s 72205.329 131848.322
  4   3    4    0.170s     10.694s   3.040s 72380.552 231128.569
  4   3    8    0.177s     14.717s   2.064s 52796.567 297380.041

The patchset consists of three parts:

1. pte cmpxchg patch
 Provides the necessary changes to asm-generic, asm-ia64 and asm-i386 to implement
 pte_xchg and pte_cmpxchg.

2. page_table_lock reduction patch
- Do not allocate page_table_lock in handle_mm_fault for the most frequently used
  path. Changes functions that are used by handle_mm_fault so that everything works
  properly.
- Implement do_anonymous_page using pte_cmpxchg.
- Eliminate periods where ptes would be set to zero in the swapper code by using pte_xchg.

3. rss-atomic
- Make all uses of mm->rss atomic.

====== PTE_CMPXCHG

Index: linux-2.6.8.1/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-generic/pgtable.h	2004-08-14 03:55:10.000000000 -0700
+++ linux-2.6.8.1/include/asm-generic/pgtable.h	2004-08-23 17:52:53.000000000 -0700
@@ -85,6 +85,15 @@
 }
 #endif

+#ifndef __HAVE_ARCH_PTEP_XCHG
+static inline pte_t ptep_xchg(pte_t *ptep,pte_t pteval)
+{
+	pte_t pte = *ptep;
+	set_pte(ptep, pteval);
+	return pte;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define ptep_clear_flush(__vma, __address, __ptep)			\
 ({									\
@@ -94,6 +103,28 @@
 })
 #endif

+#ifndef __HAVE_ARCH_PTEP_XCHG_FLUSH
+#define ptep_xchg_flush(__vma, __address, __ptep, __pteval)		\
+({									\
+	pte_t __pte = ptep_xchg(__ptep, __pteval);			\
+	flush_tlb_page(__vma, __address);				\
+	__pte;								\
+})
+#endif
+
+#ifndef __HAVE_ARCH_PTEP_CMPXCHG
+static inline pte_t ptep_cmpxchg(pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	if (*ptep->pte == oldval) {
+		ptep_xchg(ptep, newval, oldval);
+		return 1;
+	}
+	else
+		return 0;
+}
+#endif
+
+
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(pte_t *ptep)
 {
Index: linux-2.6.8.1/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-i386/pgtable.h	2004-08-14 03:55:48.000000000 -0700
+++ linux-2.6.8.1/include/asm-i386/pgtable.h	2004-08-23 17:52:53.000000000 -0700
@@ -416,9 +416,13 @@
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_XCHG
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#ifdef CONFIG_X86_CMPXCHG
+#define __HAVE_ARCH_PTEP_CMPXCHG
+#endif
 #include <asm-generic/pgtable.h>

 #endif /* _I386_PGTABLE_H */
Index: linux-2.6.8.1/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-ia64/pgtable.h	2004-08-14 03:55:10.000000000 -0700
+++ linux-2.6.8.1/include/asm-ia64/pgtable.h	2004-08-23 20:50:56.000000000 -0700
@@ -387,6 +387,26 @@
 #endif
 }

+static inline pte_t
+ptep_xchg (pte_t *ptep,pte_t pteval)
+{
+#ifdef CONFIG_SMP
+	return __pte(xchg((long *) ptep, pteval.pte));
+#else
+	pte_t pte = *ptep;
+	set_pte(ptep,pteval);
+	return pte;
+#endif
+}
+
+#ifdef CONFIG_SMP
+static inline int
+ptep_cmpxchg (pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return ia64_cmpxchg8_acq(&ptep->pte, newval.pte, oldval.pte) == oldval.pte;
+}
+#endif
+
 static inline void
 ptep_set_wrprotect (pte_t *ptep)
 {
@@ -554,10 +574,14 @@
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_XCHG
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
+#ifdef CONFIG_SMP
+#define __HAVE_ARCH_PTEP_CMPXCHG
+#endif
 #include <asm-generic/pgtable.h>

 #endif /* _ASM_IA64_PGTABLE_H */
Index: linux-2.6.8.1/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-i386/pgtable-3level.h	2004-08-14 03:55:59.000000000 -0700
+++ linux-2.6.8.1/include/asm-i386/pgtable-3level.h	2004-08-23 17:52:53.000000000 -0700
@@ -88,6 +88,11 @@
 	return res;
 }

+static inline int ptep_cmpxchg(pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return cmpxchg(&ptep->pte_low, (long)oldval, (long)newval)==(long)oldval;
+}
+
 static inline int pte_same(pte_t a, pte_t b)
 {
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
Index: linux-2.6.8.1/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-i386/pgtable-2level.h	2004-08-14 03:55:33.000000000 -0700
+++ linux-2.6.8.1/include/asm-i386/pgtable-2level.h	2004-08-23 17:52:53.000000000 -0700
@@ -40,6 +40,10 @@
 	return (pmd_t *) dir;
 }
 #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
+#define ptep_xchg(xp,a)       __pte(xchg(&(xp)->pte_low, (a).pte_low))
+#ifdef CONFIG_X86_CMPXCHG
+#define ptep_cmpxchg(xp,oldpte,newpte) (cmpxchg(&(xp)->pte_low, (oldpte).pte_low, (newpte).pte_low)==(oldpte).pte_low)
+#endif
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)


====== PAGE_TABLE_LOCK_REDUCTION


Index: linux-2.6.8.1/mm/memory.c
===================================================================
--- linux-2.6.8.1.orig/mm/memory.c	2004-08-23 17:52:49.000000000 -0700
+++ linux-2.6.8.1/mm/memory.c	2004-08-23 17:52:57.000000000 -0700
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
@@ -1405,14 +1402,12 @@
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
@@ -1424,7 +1419,6 @@
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
@@ -1433,30 +1427,41 @@
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
+	if (!ptep_cmpxchg(page_table, orig_entry, entry))
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
+		/* FIXME: rss++ needs page_table_lock */
+		mm->rss++;
+		unlock_page(page);
+	}
 	pte_unmap(page_table);

 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
-	spin_unlock(&mm->page_table_lock);
 out:
 	return VM_FAULT_MINOR;
 no_mem:
@@ -1472,12 +1477,12 @@
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
@@ -1488,9 +1493,8 @@

 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
-					pmd, write_access, address);
+					pmd, write_access, address, orig_entry);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);

 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1588,7 +1592,7 @@
  * nonlinear vmas.
  */
 static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd, pte_t entry)
 {
 	unsigned long pgoff;
 	int err;
@@ -1601,13 +1605,12 @@
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
@@ -1626,17 +1629,12 @@
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
@@ -1649,15 +1647,29 @@
 		/*
 		 * If it truly wasn't present, we know that kswapd
 		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
+		 * no need to acquire the page_table_lock.
 		 */
+not_present:
 		if (pte_none(entry))
-			return do_no_page(mm, vma, address, write_access, pte, pmd);
+			return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
 		if (pte_file(entry))
-			return do_file_page(mm, vma, address, write_access, pte, pmd);
+			return do_file_page(mm, vma, address, write_access, pte, pmd, entry);
 		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}
-
+
+	/*
+	 * We really need the table_lock since we currently modify the pte
+	 * without the use of atomic operations.
+	 * FIXME: rewrite to use atomic operations
+	 */
+	spin_lock(&mm->page_table_lock);
+	/* Check again in case a swapout happened before we acquired the lock */
+	entry= *pte;
+	if (!pte_present(entry)) {
+		spin_unlock(&mm->page_table_lock);
+		goto not_present;
+	}
+
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
@@ -1686,22 +1698,37 @@

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
+		/*
+		 * This is a rare case. We need to satify the entry and exit requirement
+		 * of __pmd_alloc which will immediately drop the table lock
+		 */
+		spin_lock(&mm->page_table_lock);
+		pmd = __pmd_alloc(mm, pgd, address);
+		spin_unlock(&mm->page_table_lock);
+	} else
+		pmd = pmd_offset(pgd, address);
+
+	if (likely(pmd)) {
+		pte_t * pte;

-	if (pmd) {
-		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
+		if (unlikely(!pmd_present(*pmd))) {
+			spin_lock(&mm->page_table_lock);
+			pte = pte_alloc_map(mm, pmd, address);
+			spin_unlock(&mm->page_table_lock);
+		} else
+			pte = pte_offset_map(pmd, address);
+
+		if (likely(pte))
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
-	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;
 }

Index: linux-2.6.8.1/mm/rmap.c
===================================================================
--- linux-2.6.8.1.orig/mm/rmap.c	2004-08-14 03:56:22.000000000 -0700
+++ linux-2.6.8.1/mm/rmap.c	2004-08-23 17:52:57.000000000 -0700
@@ -333,7 +333,10 @@
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
@@ -494,11 +497,6 @@

 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
-	pteval = ptep_clear_flush(vma, address, pte);
-
-	/* Move the dirty bit to the physical page now the pte is gone. */
-	if (pte_dirty(pteval))
-		set_page_dirty(page);

 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
@@ -508,9 +506,14 @@
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
-		set_pte(pte, swp_entry_to_pte(entry));
+		pteval = ptep_xchg_flush(vma, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
-	}
+	} else
+		pteval = ptep_clear_flush(vma, address, pte);
+
+	/* Move the dirty bit to the physical page now the pte is gone. */
+	if (pte_dirty(pteval))
+		set_page_dirty(page);

 	mm->rss--;
 	BUG_ON(!page->mapcount);
@@ -602,11 +605,12 @@

 		/* Nuke the page table entry. */
 		flush_cache_page(vma, address);
-		pteval = ptep_clear_flush(vma, address, pte);

 		/* If nonlinear, store the file page offset in the pte. */
 		if (page->index != linear_page_index(vma, address))
-			set_pte(pte, pgoff_to_pte(page->index));
+			pteval = ptep_xchg_flush(vma, address, pte, pgoff_to_pte(page->index));
+		else
+			pteval = ptep_clear_flush(vma, address, pte);

 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))



====== RSS-ATOMIC




Index: linux-2.6.8.1/include/linux/sched.h
===================================================================
--- linux-2.6.8.1.orig/include/linux/sched.h	2004-08-14 03:54:49.000000000 -0700
+++ linux-2.6.8.1/include/linux/sched.h	2004-08-23 21:05:27.000000000 -0700
@@ -197,9 +197,10 @@
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
+	atomic_t mm_rss;			/* Number of pages used by this mm struct */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
-	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
+	spinlock_t page_table_lock;		/* Protects task page tables */

 	struct list_head mmlist;		/* List of all active mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
@@ -209,7 +210,7 @@
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm;
+	unsigned long total_vm, locked_vm;
 	unsigned long def_flags;

 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
Index: linux-2.6.8.1/kernel/fork.c
===================================================================
--- linux-2.6.8.1.orig/kernel/fork.c	2004-08-14 03:54:49.000000000 -0700
+++ linux-2.6.8.1/kernel/fork.c	2004-08-23 21:05:27.000000000 -0700
@@ -281,7 +281,7 @@
 	mm->mmap_cache = NULL;
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->map_count = 0;
-	mm->rss = 0;
+	atomic_set(&mm->mm_rss, 0);
 	cpus_clear(mm->cpu_vm_mask);
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
Index: linux-2.6.8.1/mm/mmap.c
===================================================================
--- linux-2.6.8.1.orig/mm/mmap.c	2004-08-14 03:55:35.000000000 -0700
+++ linux-2.6.8.1/mm/mmap.c	2004-08-23 21:05:27.000000000 -0700
@@ -1719,7 +1719,7 @@
 	vma = mm->mmap;
 	mm->mmap = mm->mmap_cache = NULL;
 	mm->mm_rb = RB_ROOT;
-	mm->rss = 0;
+	atomic_set(&mm->mm_rss, 0);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;

Index: linux-2.6.8.1/mm/memory.c
===================================================================
--- linux-2.6.8.1.orig/mm/memory.c	2004-08-23 20:51:03.000000000 -0700
+++ linux-2.6.8.1/mm/memory.c	2004-08-23 21:05:53.000000000 -0700
@@ -325,7 +325,7 @@
 					pte = pte_mkclean(pte);
 				pte = pte_mkold(pte);
 				get_page(page);
-				dst->rss++;
+				atomic_inc(&dst->mm_rss);
 				set_pte(dst_pte, pte);
 				page_dup_rmap(page);
 cont_copy_pte_range_noset:
@@ -1096,7 +1096,7 @@
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
 		if (PageReserved(old_page))
-			++mm->rss;
+			atomic_inc(&mm->mm_rss);
 		else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
@@ -1374,7 +1374,7 @@
 	if (vm_swap_full())
 		remove_exclusive_swap_page(page);

-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1444,6 +1444,7 @@
 			unlock_page(page);
 			page_cache_release(page);
 		}
+		printk(KERN_INFO "do_anon_page: cmpxchg failed. Backing out.\n");
 		goto out;
 	}
 	if (write_access) {
@@ -1454,8 +1455,7 @@
 		 */
 		lru_cache_add_active(page);
 		page_add_anon_rmap(page, vma, addr);
-		/* FIXME: rss++ needs page_table_lock */
-		mm->rss++;
+		atomic_inc(&mm->mm_rss);
 		unlock_page(page);
 	}
 	pte_unmap(page_table);
@@ -1555,7 +1555,7 @@
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
-			++mm->rss;
+			atomic_inc(&mm->mm_rss);
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
Index: linux-2.6.8.1/fs/exec.c
===================================================================
--- linux-2.6.8.1.orig/fs/exec.c	2004-08-14 03:55:10.000000000 -0700
+++ linux-2.6.8.1/fs/exec.c	2004-08-23 21:05:27.000000000 -0700
@@ -319,7 +319,7 @@
 		pte_unmap(pte);
 		goto out;
 	}
-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	lru_cache_add_active(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
Index: linux-2.6.8.1/fs/binfmt_flat.c
===================================================================
--- linux-2.6.8.1.orig/fs/binfmt_flat.c	2004-08-14 03:54:46.000000000 -0700
+++ linux-2.6.8.1/fs/binfmt_flat.c	2004-08-23 21:05:27.000000000 -0700
@@ -650,7 +650,7 @@
 		current->mm->start_brk = datapos + data_len + bss_len;
 		current->mm->brk = (current->mm->start_brk + 3) & ~3;
 		current->mm->context.end_brk = memp + ksize((void *) memp) - stack_len;
-		current->mm->rss = 0;
+		atomic_set(current->mm->mm_rss, 0);
 	}

 	if (flags & FLAT_FLAG_KTRACE)
Index: linux-2.6.8.1/mm/fremap.c
===================================================================
--- linux-2.6.8.1.orig/mm/fremap.c	2004-08-14 03:54:47.000000000 -0700
+++ linux-2.6.8.1/mm/fremap.c	2004-08-23 21:05:27.000000000 -0700
@@ -38,7 +38,7 @@
 					set_page_dirty(page);
 				page_remove_rmap(page);
 				page_cache_release(page);
-				mm->rss--;
+				atomic_dec(&mm->mm_rss);
 			}
 		}
 	} else {
@@ -86,7 +86,7 @@

 	zap_pte(mm, vma, addr, pte);

-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	flush_icache_page(vma, page);
 	set_pte(pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
Index: linux-2.6.8.1/fs/binfmt_som.c
===================================================================
--- linux-2.6.8.1.orig/fs/binfmt_som.c	2004-08-14 03:55:19.000000000 -0700
+++ linux-2.6.8.1/fs/binfmt_som.c	2004-08-23 21:05:27.000000000 -0700
@@ -259,7 +259,7 @@
 	create_som_tables(bprm);

 	current->mm->start_stack = bprm->p;
-	current->mm->rss = 0;
+	atomic_set(current->mm->mm_rss, 0);

 #if 0
 	printk("(start_brk) %08lx\n" , (unsigned long) current->mm->start_brk);
Index: linux-2.6.8.1/mm/swapfile.c
===================================================================
--- linux-2.6.8.1.orig/mm/swapfile.c	2004-08-23 17:52:49.000000000 -0700
+++ linux-2.6.8.1/mm/swapfile.c	2004-08-23 21:05:27.000000000 -0700
@@ -434,7 +434,7 @@
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
 	swp_entry_t entry, struct page *page)
 {
-	vma->vm_mm->rss++;
+	atomic_inc(&vma->vm_mm->mm_rss);
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
Index: linux-2.6.8.1/fs/binfmt_aout.c
===================================================================
--- linux-2.6.8.1.orig/fs/binfmt_aout.c	2004-08-14 03:54:51.000000000 -0700
+++ linux-2.6.8.1/fs/binfmt_aout.c	2004-08-23 21:05:27.000000000 -0700
@@ -309,7 +309,7 @@
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;

-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Index: linux-2.6.8.1/fs/binfmt_elf.c
===================================================================
--- linux-2.6.8.1.orig/fs/binfmt_elf.c	2004-08-14 03:55:23.000000000 -0700
+++ linux-2.6.8.1/fs/binfmt_elf.c	2004-08-23 21:05:27.000000000 -0700
@@ -705,7 +705,7 @@

 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;
 	retval = setup_arg_pages(bprm, executable_stack);
 	if (retval < 0) {
Index: linux-2.6.8.1/mm/rmap.c
===================================================================
--- linux-2.6.8.1.orig/mm/rmap.c	2004-08-23 20:51:03.000000000 -0700
+++ linux-2.6.8.1/mm/rmap.c	2004-08-23 21:05:27.000000000 -0700
@@ -203,7 +203,7 @@
 	pte_t *pte;
 	int referenced = 0;

-	if (!mm->rss)
+	if (!atomic_read(&mm->mm_rss))
 		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -435,7 +435,7 @@
 	pte_t pteval;
 	int ret = SWAP_AGAIN;

-	if (!mm->rss)
+	if (!atomic_read(&mm->mm_rss))
 		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -515,7 +515,7 @@
 	if (pte_dirty(pteval))
 		set_page_dirty(page);

-	mm->rss--;
+	atomic_dec(&mm->mm_rss);
 	BUG_ON(!page->mapcount);
 	page->mapcount--;
 	page_cache_release(page);
@@ -618,7 +618,7 @@

 		page_remove_rmap(page);
 		page_cache_release(page);
-		mm->rss--;
+		atomic_dec(&mm->mm_rss);
 		(*mapcount)--;
 	}

@@ -719,7 +719,7 @@
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (vma->vm_mm->rss &&
+			while (atomic_read(&vma->vm_mm->mm_rss) &&
 				cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				ret = try_to_unmap_cluster(
Index: linux-2.6.8.1/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.8.1.orig/fs/proc/task_mmu.c	2004-08-14 03:54:50.000000000 -0700
+++ linux-2.6.8.1/fs/proc/task_mmu.c	2004-08-23 21:05:27.000000000 -0700
@@ -37,7 +37,7 @@
 		"VmLib:\t%8lu kB\n",
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
+		(unsigned long)atomic_read(&mm->mm_rss) << (PAGE_SHIFT-10),
 		data - stack, stack,
 		exec - lib, lib);
 	up_read(&mm->mmap_sem);
@@ -55,7 +55,7 @@
 	struct vm_area_struct *vma;
 	int size = 0;

-	*resident = mm->rss;
+	*resident = atomic_read(&mm->mm_rss);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;

Index: linux-2.6.8.1/arch/ia64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.8.1.orig/arch/ia64/mm/hugetlbpage.c	2004-08-14 03:55:32.000000000 -0700
+++ linux-2.6.8.1/arch/ia64/mm/hugetlbpage.c	2004-08-23 21:05:27.000000000 -0700
@@ -65,7 +65,7 @@
 {
 	pte_t entry;

-	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	atomic_add(HPAGE_SIZE / PAGE_SIZE, &mm->mm_rss);
 	if (write_access) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
@@ -108,7 +108,7 @@
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		atomic_add(HPAGE_SIZE / PAGE_SIZE, &dst->mm_rss);
 		addr += HPAGE_SIZE;
 	}
 	return 0;
@@ -249,7 +249,7 @@
 		put_page(page);
 		pte_clear(pte);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
+	atomic_sub((end - start) >> PAGE_SHIFT, &mm->mm_rss);
 	flush_tlb_range(vma, start, end);
 }

Index: linux-2.6.8.1/fs/proc/array.c
===================================================================
--- linux-2.6.8.1.orig/fs/proc/array.c	2004-08-14 03:55:34.000000000 -0700
+++ linux-2.6.8.1/fs/proc/array.c	2004-08-23 21:05:27.000000000 -0700
@@ -384,7 +384,7 @@
 		jiffies_to_clock_t(task->it_real_value),
 		start_time,
 		vsize,
-		mm ? mm->rss : 0, /* you might want to shift this left 3 */
+		mm ? (unsigned long)atomic_read(&mm->mm_rss) : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
Index: linux-2.6.8.1/include/asm-ia64/tlb.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-ia64/tlb.h	2004-08-14 03:55:19.000000000 -0700
+++ linux-2.6.8.1/include/asm-ia64/tlb.h	2004-08-23 21:05:27.000000000 -0700
@@ -45,6 +45,7 @@
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
 #include <asm/machvec.h>
+#include <asm/atomic.h>

 #ifdef CONFIG_SMP
 # define FREE_PTE_NR		2048
@@ -160,11 +161,11 @@
 {
 	unsigned long freed = tlb->freed;
 	struct mm_struct *mm = tlb->mm;
-	unsigned long rss = mm->rss;
+	unsigned long rss = atomic_read(&mm->mm_rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	atomic_set(&mm->mm_rss, rss - freed);
 	/*
 	 * Note: tlb->nr may be 0 at this point, so we can't rely on tlb->start_addr and
 	 * tlb->end_addr.
Index: linux-2.6.8.1/include/asm-generic/tlb.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-generic/tlb.h	2004-08-14 03:54:46.000000000 -0700
+++ linux-2.6.8.1/include/asm-generic/tlb.h	2004-08-23 21:05:27.000000000 -0700
@@ -88,11 +88,11 @@
 {
 	int freed = tlb->freed;
 	struct mm_struct *mm = tlb->mm;
-	int rss = mm->rss;
+	int rss = atomic_read(&mm->mm_rss);

 	if (rss < freed)
 		freed = rss;
-	mm->rss = rss - freed;
+	atomic_set(&mm->mm_rss, rss - freed);
 	tlb_flush_mmu(tlb, start, end);

 	/* keep the page table cache within bounds */

