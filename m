Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUHaSCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUHaSCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUHaSCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:02:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58506 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266096AbUHaRzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:55:01 -0400
Date: Tue, 31 Aug 2004 10:54:57 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: linux-kernel@vger.kernel.org
cc: linux-ppc@vger.kernel.org
Subject: page fault scalability patch: Need help/testing for x86_64, s390,
 ppc and ppc64
Message-ID: <Pine.LNX.4.58.0408311038030.2245@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The page fault scalability patch avoids the use of the page_table_lock
through atomic operations and thereby increases the scalability of
page fault handling. However this requires atomic operations on the
ptes and these are platform specific. They are typically defined in
asm/pgtable.h and asm/pgalloc.h.

The patch needs the following additional atomic operations:

pgtable.h: ptep_xchg (variation on ptep_test_and_clear) and ptep_cmpxchg
pgalloc.h: pgd_test_and_populate, pmd_test_and_populate.

Most of these can be easily realized using the cmpxchg already provided
in asm/system.h

I have tested this on i386 and ia64 and done an implementation from the
arch specific documents for x86_64, s390, ppc and ppc64.

If you are in posssession of or are a kernel developer for x86_64, s390,
ppc or ppc64 then please review the relevant arch specific portions and
after fixing up my stuff please test and see if this actually works on
your platform.

One note on S/390: It seems that ptep_test_and_clear does not use an
atomic operation. Is this correct? I have implemenmted the ptep_xchg
on S/390 also with non-atomic operations. Maybe for some unknown reason
(cannot imagine but ??) there is no need for atomic exchange operations
for ptes?

I can provide a test program to measure the performance
improvement that this will bring ....

Index: linux-2.6.9-rc1/kernel/fork.c
===================================================================
--- linux-2.6.9-rc1.orig/kernel/fork.c	2004-08-27 19:09:57.000000000 -0700
+++ linux-2.6.9-rc1/kernel/fork.c	2004-08-30 18:50:26.000000000 -0700
@@ -302,7 +302,7 @@
 	mm->mmap_cache = NULL;
 	mm->free_area_cache = oldmm->mmap_base;
 	mm->map_count = 0;
-	mm->rss = 0;
+	atomic_set(&mm->mm_rss, 0);
 	cpus_clear(mm->cpu_vm_mask);
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
Index: linux-2.6.9-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.9-rc1.orig/include/linux/sched.h	2004-08-27 19:09:57.000000000 -0700
+++ linux-2.6.9-rc1/include/linux/sched.h	2004-08-30 18:50:26.000000000 -0700
@@ -213,9 +213,10 @@
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
@@ -225,7 +226,7 @@
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rlimit_rss, rss, total_vm, locked_vm, shared_vm;
+	unsigned long rlimit_rss, total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags;

 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
Index: linux-2.6.9-rc1/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.9-rc1.orig/fs/proc/task_mmu.c	2004-08-27 19:09:54.000000000 -0700
+++ linux-2.6.9-rc1/fs/proc/task_mmu.c	2004-08-30 18:50:26.000000000 -0700
@@ -21,7 +21,7 @@
 		"VmLib:\t%8lu kB\n",
 		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
+		(unsigned long) atomic_read(&mm->mm_rss) << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib);
 	return buffer;
@@ -38,7 +38,7 @@
 	*shared = mm->shared_vm;
 	*text = (mm->end_code - mm->start_code) >> PAGE_SHIFT;
 	*data = mm->total_vm - mm->shared_vm - *text;
-	*resident = mm->rss;
+	*resident = atomic_read(&mm->mm_rss);
 	return mm->total_vm;
 }

Index: linux-2.6.9-rc1/mm/mmap.c
===================================================================
--- linux-2.6.9-rc1.orig/mm/mmap.c	2004-08-27 19:09:57.000000000 -0700
+++ linux-2.6.9-rc1/mm/mmap.c	2004-08-30 18:50:26.000000000 -0700
@@ -1843,7 +1843,7 @@
 	vma = mm->mmap;
 	mm->mmap = mm->mmap_cache = NULL;
 	mm->mm_rb = RB_ROOT;
-	mm->rss = 0;
+	atomic_set(&mm->mm_rss, 0);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;

Index: linux-2.6.9-rc1/include/asm-generic/tlb.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-generic/tlb.h	2004-08-24 00:01:50.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-generic/tlb.h	2004-08-30 18:50:27.000000000 -0700
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
Index: linux-2.6.9-rc1/fs/binfmt_flat.c
===================================================================
--- linux-2.6.9-rc1.orig/fs/binfmt_flat.c	2004-08-24 00:01:50.000000000 -0700
+++ linux-2.6.9-rc1/fs/binfmt_flat.c	2004-08-30 18:50:27.000000000 -0700
@@ -650,7 +650,7 @@
 		current->mm->start_brk = datapos + data_len + bss_len;
 		current->mm->brk = (current->mm->start_brk + 3) & ~3;
 		current->mm->context.end_brk = memp + ksize((void *) memp) - stack_len;
-		current->mm->rss = 0;
+		atomic_set(current->mm->mm_rss, 0);
 	}

 	if (flags & FLAT_FLAG_KTRACE)
Index: linux-2.6.9-rc1/fs/exec.c
===================================================================
--- linux-2.6.9-rc1.orig/fs/exec.c	2004-08-27 19:09:53.000000000 -0700
+++ linux-2.6.9-rc1/fs/exec.c	2004-08-30 18:50:27.000000000 -0700
@@ -320,7 +320,7 @@
 		pte_unmap(pte);
 		goto out;
 	}
-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	lru_cache_add_active(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
Index: linux-2.6.9-rc1/mm/memory.c
===================================================================
--- linux-2.6.9-rc1.orig/mm/memory.c	2004-08-27 19:09:57.000000000 -0700
+++ linux-2.6.9-rc1/mm/memory.c	2004-08-30 18:50:27.000000000 -0700
@@ -158,9 +158,7 @@
 	if (!pmd_present(*pmd)) {
 		struct page *new;

-		spin_unlock(&mm->page_table_lock);
 		new = pte_alloc_one(mm, address);
-		spin_lock(&mm->page_table_lock);
 		if (!new)
 			return NULL;

@@ -172,8 +170,11 @@
 			pte_free(new);
 			goto out;
 		}
+		if (!pmd_test_and_populate(mm, pmd, new)) {
+			pte_free(new);
+			goto out;
+		}
 		inc_page_state(nr_page_table_pages);
-		pmd_populate(mm, pmd, new);
 	}
 out:
 	return pte_offset_map(pmd, address);
@@ -325,7 +326,7 @@
 					pte = pte_mkclean(pte);
 				pte = pte_mkold(pte);
 				get_page(page);
-				dst->rss++;
+				atomic_inc(&dst->mm_rss);
 				set_pte(dst_pte, pte);
 				page_dup_rmap(page);
 cont_copy_pte_range_noset:
@@ -1117,7 +1118,7 @@
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
 		if (PageReserved(old_page))
-			++mm->rss;
+			atomic_inc(&mm->mm_rss);
 		else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
@@ -1335,8 +1336,7 @@
 }

 /*
- * We hold the mm semaphore and the page_table_lock on entry and
- * should release the pagetable lock on exit..
+ * We hold the mm semaphore
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
@@ -1348,15 +1348,13 @@
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
@@ -1399,7 +1397,7 @@
 	if (vm_swap_full())
 		remove_exclusive_swap_page(page);

-	mm->rss++;
+	atomic_inc(&mm->mm_rss);
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1427,14 +1425,12 @@
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
@@ -1446,7 +1442,6 @@
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
@@ -1455,30 +1450,40 @@
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
@@ -1494,12 +1499,12 @@
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
@@ -1510,9 +1515,8 @@

 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
-					pmd, write_access, address);
+					pmd, write_access, address, orig_entry);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);

 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1573,7 +1577,7 @@
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
-			++mm->rss;
+			atomic_inc(&mm->mm_rss);
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
@@ -1610,7 +1614,7 @@
  * nonlinear vmas.
  */
 static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd, pte_t entry)
 {
 	unsigned long pgoff;
 	int err;
@@ -1623,13 +1627,12 @@
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
@@ -1648,49 +1651,54 @@
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
+	 *
+	 * The following statement was removed
+	 * ptep_set_access_flags(vma, address, pte, new_entry, write_access);
+	 * Not sure if all the side effects are replicated here for all platforms.
+	 *
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
+	if (ptep_cmpxchg(pte, entry, new_entry))
+		update_mmu_cache(vma, address, new_entry);
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
 }

@@ -1708,30 +1716,27 @@

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
 	pmd = pmd_alloc(mm, pgd, address);

-	if (pmd) {
+	if (likely(pmd)) {
 		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
+		if (likely(pte))
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
-	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;
 }

 /*
  * Allocate page middle directory.
  *
- * We've already handled the fast-path in-line, and we own the
- * page table lock.
+ * We've already handled the fast-path in-line.
  *
  * On a two-level page table, this ends up actually being entirely
  * optimized away.
@@ -1740,9 +1745,7 @@
 {
 	pmd_t *new;

-	spin_unlock(&mm->page_table_lock);
 	new = pmd_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
 	if (!new)
 		return NULL;

@@ -1754,7 +1757,11 @@
 		pmd_free(new);
 		goto out;
 	}
-	pgd_populate(mm, pgd, new);
+	/* Insure that the update is done in an atomic way */
+	if (!pgd_test_and_populate(mm, pgd, new)) {
+		pmd_free(new);
+		goto out;
+	}
 out:
 	return pmd_offset(pgd, address);
 }
Index: linux-2.6.9-rc1/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-ia64/pgalloc.h	2004-08-24 00:01:52.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-ia64/pgalloc.h	2004-08-30 18:50:27.000000000 -0700
@@ -34,6 +34,10 @@
 #define pmd_quicklist		(local_cpu_data->pmd_quick)
 #define pgtable_cache_size	(local_cpu_data->pgtable_cache_sz)

+/* Empty entries of PMD and PGD */
+#define PMD_NONE       0
+#define PTE_NONE       0
+
 static inline pgd_t*
 pgd_alloc_one_fast (struct mm_struct *mm)
 {
@@ -84,6 +88,11 @@
 	pgd_val(*pgd_entry) = __pa(pmd);
 }

+static inline int
+pgd_test_and_populate (struct mm_struct *mm, pgd_t *pgd_entry, pmd_t *pmd)
+{
+	return ia64_cmpxchg8_acq(pgd_entry,__pa(pmd), PMD_NONE) == PMD_NONE;
+}

 static inline pmd_t*
 pmd_alloc_one_fast (struct mm_struct *mm, unsigned long addr)
@@ -132,6 +141,12 @@
 	pmd_val(*pmd_entry) = page_to_phys(pte);
 }

+static inline int
+pmd_test_and_populate (struct mm_struct *mm, pmd_t *pmd_entry, struct page *pte)
+{
+	return ia64_cmpxchg8_acq(pmd_entry, page_to_phys(pte), PTE_NONE) == PTE_NONE;
+}
+
 static inline void
 pmd_populate_kernel (struct mm_struct *mm, pmd_t *pmd_entry, pte_t *pte)
 {
Index: linux-2.6.9-rc1/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-i386/pgtable.h	2004-08-27 19:09:56.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-i386/pgtable.h	2004-08-30 18:50:27.000000000 -0700
@@ -409,9 +409,11 @@
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_XCHG
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTEP_CMPXCHG
 #include <asm-generic/pgtable.h>

 #endif /* _I386_PGTABLE_H */
Index: linux-2.6.9-rc1/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-i386/pgtable-3level.h	2004-08-27 19:09:56.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-i386/pgtable-3level.h	2004-08-30 18:50:27.000000000 -0700
@@ -6,7 +6,8 @@
  * tables on PPro+ CPUs.
  *
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
- */
+ * August 26, 2004 added ptep_cmpxchg and ptep_xchg <christoph@lameter.com>
+*/

 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, &(e), (e).pte_high, (e).pte_low)
@@ -88,6 +89,26 @@
 	return res;
 }

+static inline pte_t ptep_xchg(pte_t *ptep, pte_t newval)
+{
+	pte_t res;
+
+	/* xchg acts as a barrier before the setting of the high bits.
+	 * (But we also have a cmpxchg8b. Why not use that? (cl))
+	  */
+	res.pte_low = xchg(&ptep->pte_low, newval.pte_low);
+	res.pte_high = ptep->pte_high;
+	ptep->pte_high = newval.pte_high;
+
+	return res;
+}
+
+
+static inline int ptep_cmpxchg(pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return cmpxchg(ptep, pte_val(oldval), pte_val(newval)) == pte_val(oldval);
+}
+
 static inline int pte_same(pte_t a, pte_t b)
 {
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
Index: linux-2.6.9-rc1/fs/binfmt_som.c
===================================================================
--- linux-2.6.9-rc1.orig/fs/binfmt_som.c	2004-08-24 00:02:26.000000000 -0700
+++ linux-2.6.9-rc1/fs/binfmt_som.c	2004-08-30 18:50:27.000000000 -0700
@@ -259,7 +259,7 @@
 	create_som_tables(bprm);

 	current->mm->start_stack = bprm->p;
-	current->mm->rss = 0;
+	atomic_set(current->mm->mm_rss, 0);

 #if 0
 	printk("(start_brk) %08lx\n" , (unsigned long) current->mm->start_brk);
Index: linux-2.6.9-rc1/mm/fremap.c
===================================================================
--- linux-2.6.9-rc1.orig/mm/fremap.c	2004-08-24 00:01:51.000000000 -0700
+++ linux-2.6.9-rc1/mm/fremap.c	2004-08-30 18:50:27.000000000 -0700
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
Index: linux-2.6.9-rc1/mm/swapfile.c
===================================================================
--- linux-2.6.9-rc1.orig/mm/swapfile.c	2004-08-27 19:09:57.000000000 -0700
+++ linux-2.6.9-rc1/mm/swapfile.c	2004-08-30 18:50:27.000000000 -0700
@@ -430,7 +430,7 @@
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
 	swp_entry_t entry, struct page *page)
 {
-	vma->vm_mm->rss++;
+	atomic_inc(&vma->vm_mm->mm_rss);
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
Index: linux-2.6.9-rc1/include/linux/mm.h
===================================================================
--- linux-2.6.9-rc1.orig/include/linux/mm.h	2004-08-27 19:09:57.000000000 -0700
+++ linux-2.6.9-rc1/include/linux/mm.h	2004-08-30 18:50:27.000000000 -0700
@@ -622,7 +622,7 @@
  */
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
-	if (pgd_none(*pgd))
+	if (unlikely(pgd_none(*pgd)))
 		return __pmd_alloc(mm, pgd, address);
 	return pmd_offset(pgd, address);
 }
Index: linux-2.6.9-rc1/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-generic/pgtable.h	2004-08-24 00:02:25.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-generic/pgtable.h	2004-08-30 18:50:27.000000000 -0700
@@ -85,6 +85,20 @@
 }
 #endif

+#ifndef __HAVE_ARCH_PTEP_XCHG
+/* Implementatio not suitable for SMP */
+static inline pte_t ptep_xchg(pte_t *ptep,pte_t pteval)
+{
+	unsigned int flags;
+
+	local_irq_save(flags);
+	pte_t pte = *ptep;
+	set_pte(ptep, pteval);
+	local_irq_restore(flags);
+	return pte;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define ptep_clear_flush(__vma, __address, __ptep)			\
 ({									\
@@ -94,6 +108,31 @@
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
+/* Implementation is not suitable for SMP */
+static inline pte_t ptep_cmpxchg(pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	unsigned flags;
+	pte_t val;
+
+	local_irq_save(flags);
+	val= *ptep;
+	if (pte_same(val, oldval)) set_pte(ptep, newval);
+	local_irq_restore(flags);
+	return pte_same(val, oldval);
+}
+#endif
+
+
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(pte_t *ptep)
 {
Index: linux-2.6.9-rc1/fs/binfmt_aout.c
===================================================================
--- linux-2.6.9-rc1.orig/fs/binfmt_aout.c	2004-08-27 19:09:51.000000000 -0700
+++ linux-2.6.9-rc1/fs/binfmt_aout.c	2004-08-30 18:50:27.000000000 -0700
@@ -309,7 +309,7 @@
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = current->mm->mmap_base;

-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
Index: linux-2.6.9-rc1/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-i386/pgtable-2level.h	2004-08-27 19:09:56.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-i386/pgtable-2level.h	2004-08-30 18:50:27.000000000 -0700
@@ -40,6 +40,8 @@
 	return (pmd_t *) dir;
 }
 #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
+#define ptep_xchg(xp,a)       __pte(xchg(&(xp)->pte_low, (a).pte_low))
+#define ptep_cmpxchg(xp,oldpte,newpte) (cmpxchg(&(xp)->pte_low, (oldpte).pte_low, (newpte).pte_low)==(oldpte).pte_low)
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
Index: linux-2.6.9-rc1/arch/ia64/mm/hugetlbpage.c
===================================================================
--- linux-2.6.9-rc1.orig/arch/ia64/mm/hugetlbpage.c	2004-08-24 00:02:47.000000000 -0700
+++ linux-2.6.9-rc1/arch/ia64/mm/hugetlbpage.c	2004-08-30 18:50:27.000000000 -0700
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

Index: linux-2.6.9-rc1/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-ia64/pgtable.h	2004-08-27 19:09:56.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-ia64/pgtable.h	2004-08-30 18:50:27.000000000 -0700
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
Index: linux-2.6.9-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.9-rc1.orig/fs/proc/array.c	2004-08-27 19:09:54.000000000 -0700
+++ linux-2.6.9-rc1/fs/proc/array.c	2004-08-30 18:50:27.000000000 -0700
@@ -387,7 +387,7 @@
 		jiffies_to_clock_t(task->it_real_value),
 		start_time,
 		vsize,
-		mm ? mm->rss : 0, /* you might want to shift this left 3 */
+		mm ? (unsigned long)atomic_read(&mm->mm_rss) : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
Index: linux-2.6.9-rc1/fs/binfmt_elf.c
===================================================================
--- linux-2.6.9-rc1.orig/fs/binfmt_elf.c	2004-08-27 19:09:53.000000000 -0700
+++ linux-2.6.9-rc1/fs/binfmt_elf.c	2004-08-30 18:50:27.000000000 -0700
@@ -708,7 +708,7 @@

 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
-	current->mm->rss = 0;
+	atomic_set(&current->mm->mm_rss, 0);
 	current->mm->free_area_cache = current->mm->mmap_base;
 	retval = setup_arg_pages(bprm, executable_stack);
 	if (retval < 0) {
Index: linux-2.6.9-rc1/include/asm-ia64/tlb.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-ia64/tlb.h	2004-08-27 19:09:56.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-ia64/tlb.h	2004-08-30 18:50:27.000000000 -0700
@@ -46,6 +46,7 @@
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
 #include <asm/machvec.h>
+#include <asm/atomic.h>

 #ifdef CONFIG_SMP
 # define FREE_PTE_NR		2048
@@ -161,11 +162,11 @@
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
Index: linux-2.6.9-rc1/include/asm-i386/pgalloc.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-i386/pgalloc.h	2004-08-24 00:01:53.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-i386/pgalloc.h	2004-08-30 18:50:27.000000000 -0700
@@ -7,6 +7,8 @@
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */

+#define PTE_NONE 0L
+
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))

@@ -16,6 +18,18 @@
 		((unsigned long long)page_to_pfn(pte) <<
 			(unsigned long long) PAGE_SHIFT)));
 }
+
+static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
+{
+#ifdef CONFIG_X86_PAE
+	return cmpxchg8b( ((unsigned long long *)pmd), PTE_NONE, _PAGE_TABLE +
+		((unsigned long long)page_to_pfn(pte) <<
+			(unsigned long long) PAGE_SHIFT) ) == PTE_NONE;
+#else
+	return cmpxchg( (unsigned long *)pmd, PTE_NONE, _PAGE_TABLE + (page_to_pfn(pte) << PAGE_SHIFT)) == PTE_NONE;
+#endif
+}
+
 /*
  * Allocate and free page tables.
  */
@@ -49,6 +63,7 @@
 #define pmd_free(x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
+#define pgd_test_and_populate(mm, pmd, pte)	({ BUG(); 1; })

 #define check_pgt_cache()	do { } while (0)

Index: linux-2.6.9-rc1/mm/rmap.c
===================================================================
--- linux-2.6.9-rc1.orig/mm/rmap.c	2004-08-27 19:09:57.000000000 -0700
+++ linux-2.6.9-rc1/mm/rmap.c	2004-08-30 18:50:27.000000000 -0700
@@ -262,7 +262,7 @@
 	pte_t *pte;
 	int referenced = 0;

-	if (!mm->rss)
+	if (!atomic_read(&mm->mm_rss))
 		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -291,7 +291,7 @@
 	if (mm != current->mm && has_swap_token(mm))
 		referenced++;

-	if (mm->rss > mm->rlimit_rss)
+	if (atomic_read(&mm->mm_rss) > mm->rlimit_rss)
 		referenced = 0;

 	(*mapcount)--;
@@ -422,7 +422,10 @@
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
@@ -503,7 +506,7 @@
 	pte_t pteval;
 	int ret = SWAP_AGAIN;

-	if (!mm->rss)
+	if (!atomic_read(&mm->mm_rss))
 		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
@@ -564,11 +567,6 @@

 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
-	pteval = ptep_clear_flush(vma, address, pte);
-
-	/* Move the dirty bit to the physical page now the pte is gone. */
-	if (pte_dirty(pteval))
-		set_page_dirty(page);

 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
@@ -578,11 +576,16 @@
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
-		set_pte(pte, swp_entry_to_pte(entry));
+		pteval = ptep_xchg_flush(vma, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
-	}
+ 	} else
+ 		pteval = ptep_clear_flush(vma, address, pte);

-	mm->rss--;
+ 	/* Move the dirty bit to the physical page now the pte is gone. */
+ 	if (pte_dirty(pteval))
+ 		set_page_dirty(page);
+
+ 	atomic_dec(&mm->mm_rss);
 	page_remove_rmap(page);
 	page_cache_release(page);

@@ -670,11 +673,12 @@

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
@@ -682,7 +686,7 @@

 		page_remove_rmap(page);
 		page_cache_release(page);
-		mm->rss--;
+		atomic_dec(&mm->mm_rss);
 		(*mapcount)--;
 	}

@@ -781,7 +785,7 @@
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (vma->vm_mm->rss &&
+			while (atomic_read(&vma->vm_mm->mm_rss) &&
 				cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				try_to_unmap_cluster(cursor, &mapcount, vma);
Index: linux-2.6.9-rc1/include/asm-i386/system.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-i386/system.h	2004-08-24 00:01:51.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-i386/system.h	2004-08-30 18:50:27.000000000 -0700
@@ -203,77 +203,6 @@
  __set_64bit(ptr, (unsigned int)(value), (unsigned int)((value)>>32ULL) ) : \
  __set_64bit(ptr, ll_low(value), ll_high(value)) )

-/*
- * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
- * Note 2: xchg has side effect, so that attribute volatile is necessary,
- *	  but generally the primitive is invalid, *ptr is output argument. --ANK
- */
-static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
-{
-	switch (size) {
-		case 1:
-			__asm__ __volatile__("xchgb %b0,%1"
-				:"=q" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 2:
-			__asm__ __volatile__("xchgw %w0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 4:
-			__asm__ __volatile__("xchgl %0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-	}
-	return x;
-}
-
-/*
- * Atomic compare and exchange.  Compare OLD with MEM, if identical,
- * store NEW in MEM.  Return the initial value in MEM.  Success is
- * indicated by comparing RETURN with OLD.
- */
-
-#ifdef CONFIG_X86_CMPXCHG
-#define __HAVE_ARCH_CMPXCHG 1
-#endif
-
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
-{
-	unsigned long prev;
-	switch (size) {
-	case 1:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 2:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 4:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	}
-	return old;
-}
-
-#define cmpxchg(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
-
 #ifdef __KERNEL__
 struct alt_instr {
 	__u8 *instr; 		/* original instruction */
Index: linux-2.6.9-rc1/arch/i386/Kconfig
===================================================================
--- linux-2.6.9-rc1.orig/arch/i386/Kconfig	2004-08-27 19:09:43.000000000 -0700
+++ linux-2.6.9-rc1/arch/i386/Kconfig	2004-08-30 18:50:27.000000000 -0700
@@ -341,6 +341,11 @@
 	depends on !M386
 	default y

+config X86_CMPXCHG8B
+	bool
+	depends on !M386 && !M486
+	default y
+
 config X86_XADD
 	bool
 	depends on !M386
Index: linux-2.6.9-rc1/include/asm-i386/processor.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-i386/processor.h	2004-08-27 19:09:56.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-i386/processor.h	2004-08-30 18:50:27.000000000 -0700
@@ -651,4 +651,138 @@

 #define cache_line_size() (boot_cpu_data.x86_cache_alignment)

+/*
+ * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
+ * Note 2: xchg has side effect, so that attribute volatile is necessary,
+ *	  but generally the primitive is invalid, *ptr is output argument. --ANK
+ */
+static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
+{
+	switch (size) {
+		case 1:
+			__asm__ __volatile__("xchgb %b0,%1"
+				:"=q" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 2:
+			__asm__ __volatile__("xchgw %w0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 4:
+			__asm__ __volatile__("xchgl %0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+	}
+	return x;
+}
+
+/*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+
+#ifdef CONFIG_X86_CMPXCHG
+#define __HAVE_ARCH_CMPXCHG 1
+#else
+#endif
+
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size)
+{
+	unsigned long prev;
+#ifndef CONFIG_X86_CMPXCHG
+	/*
+	 * Check if the kernel was compiled for an old cpu but the
+	 * currently running cpu can do cmpxchg after all
+	 */
+	unsigned long flags;
+
+	/* All CPUs except 386 support CMPXCHG */
+	if (cpu_data->x86 > 3) goto have_cmpxchg;
+
+	/* Poor man's cmpxchg for 386. Unsuitable for SMP */
+	local_irq_save(flags);
+	switch (size) {
+	case 1:
+		prev = * (u8 *)ptr;
+		if (prev == old) *(u8 *)ptr = new;
+		break;
+	case 2:
+		prev = * (u16 *)ptr;
+		if (prev == old) *(u16 *)ptr = new;
+	case 4:
+		prev = *(u32 *)ptr;
+		if (prev == old) *(u32 *)ptr = new;
+		break;
+	}
+	local_irq_restore(flags);
+	return prev;
+have_cmpxchg:
+#endif
+	switch (size) {
+	case 1:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return prev;
+}
+
+static inline unsigned long long cmpxchg8b(volatile unsigned long long *ptr,
+	       unsigned long long old, unsigned long long newv)
+{
+	unsigned long long prev;
+#ifndef CONFIG_X86_CMPXCHG8B
+	unsigned long flags;
+
+	/*
+	 * Check if the kernel was compiled for an old cpu but
+	 * we are running really on a cpu capable of cmpxchg8b
+	 */
+
+	if (cpu_has(cpu_data,X86_FEATURE_CX8)) goto have_cmpxchg8b;
+
+	/* Poor mans cmpxchg8b for 386 and 486. Not suitable for SMP */
+	local_irq_save(flags);
+	prev = *ptr;
+	if (prev == old) *ptr = newv;
+	local_irq_restore(flags);
+	return prev;
+
+have_cmpxchg8b:
+#endif
+
+	 __asm__ __volatile__(
+	LOCK_PREFIX "cmpxchg8b %4\n"
+	: "=A" (prev)
+	: "0" (old), "c" ((unsigned long)(newv >> 32)),
+       		"b" ((unsigned long)(newv & 0xffffffffLL)), "m" (ptr)
+	: "memory");
+	return prev ;
+}
+
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
+
 #endif /* __ASM_I386_PROCESSOR_H */
Index: linux-2.6.9-rc1/include/asm-x86_64/pgalloc.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-x86_64/pgalloc.h	2004-08-24 00:02:47.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-x86_64/pgalloc.h	2004-08-30 18:50:27.000000000 -0700
@@ -7,16 +7,26 @@
 #include <linux/threads.h>
 #include <linux/mm.h>

+#define PMD_NONE 0
+#define PTE_NONE 0
+
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE | __pa(pte)))
 #define pgd_populate(mm, pgd, pmd) \
 		set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(pmd)))
+#define pgd_test_and_populate(mm, pgd, pmd) \
+		(cmpxchg(pgd, PMD_NONE, _PAGE_TABLE | __pa(pmd)) == PMD_NONE)

 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
 	set_pmd(pmd, __pmd(_PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)));
 }

+static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
+{
+	return cmpxchg(pmd, PTE_NONE, _PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)) == PTE_NONE;
+}
+
 extern __inline__ pmd_t *get_pmd(void)
 {
 	return (pmd_t *)get_zeroed_page(GFP_KERNEL);
Index: linux-2.6.9-rc1/include/asm-x86_64/pgtable.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-x86_64/pgtable.h	2004-08-24 00:03:19.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-x86_64/pgtable.h	2004-08-30 18:50:27.000000000 -0700
@@ -102,6 +102,8 @@
 ((unsigned long) __va(pgd_val(pgd) & PHYSICAL_PAGE_MASK))

 #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte, 0))
+#define ptep_xchg(xp,newval)	__pte(xchg(&(xp)->pte, pte_val(newval))
+#define ptep_cmpxchg(xp,newval,oldval) (cmpxchg(&(xp)->pte, pte_val(newval), pte_val(oldval) == pte_val(oldval))
 #define pte_same(a, b)		((a).pte == (b).pte)

 #define PML4_SIZE	(1UL << PML4_SHIFT)
@@ -442,6 +444,8 @@
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTEP_XCHG
+#define __HAVE_ARCH_PTEP_CMPXCHG
 #include <asm-generic/pgtable.h>

 #endif /* _X86_64_PGTABLE_H */
Index: linux-2.6.9-rc1/mm/thrash.c
===================================================================
--- linux-2.6.9-rc1.orig/mm/thrash.c	2004-08-27 19:09:57.000000000 -0700
+++ linux-2.6.9-rc1/mm/thrash.c	2004-08-30 18:50:27.000000000 -0700
@@ -35,7 +35,7 @@
 		ret = SWAP_TOKEN_ENOUGH_RSS;
 	else if (time_after(jiffies, swap_token_timeout))
 		ret = SWAP_TOKEN_TIMED_OUT;
-	else if (mm->rss > mm->rlimit_rss)
+	else if (atomic_read(&mm->mm_rss) > mm->rlimit_rss)
 		ret = SWAP_TOKEN_ENOUGH_RSS;
 	mm->recent_pagein = 0;
 	return ret;
@@ -61,7 +61,7 @@
 	if (time_after(jiffies, swap_token_check)) {

 		/* Can't get swapout protection if we exceed our RSS limit. */
-		if (current->mm->rss > current->mm->rlimit_rss)
+		if (atomic_read(&current->mm->mm_rss) > current->mm->rlimit_rss)
 			return;

 		/* ... or if we recently held the token. */
Index: linux-2.6.9-rc1/include/asm-s390/pgtable.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-s390/pgtable.h	2004-08-24 00:03:30.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-s390/pgtable.h	2004-08-30 18:53:54.000000000 -0700
@@ -539,11 +539,25 @@

 static inline pte_t ptep_get_and_clear(pte_t *ptep)
 {
+/* Why is there no atomic operation or locking here ??*/
 	pte_t pte = *ptep;
 	pte_clear(ptep);
 	return pte;
 }

+static inline pte_t ptep_xchg(pte_t *ptep, pte_t pteval)
+{
+/* ptep_get_and_clear has no locks / atomic ops so we just do the same */
+	pte_t pteold = *ptep;
+	set_pte(ptep,pteval);
+	return pteold;
+}
+
+static inline int ptep_cmpxchg (pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return cmpxchg(ptep, pte_val(oldval), pte_val(newval)) == pte_val(oldval);
+}
+
 static inline pte_t
 ptep_clear_flush(struct vm_area_struct *vma,
 		 unsigned long address, pte_t *ptep)
@@ -801,6 +815,8 @@
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_YOUNG
+#define __HAVE_ARCH_PTEP_CMPXCHG
+#define __HAVE_ARCH_PTEP_XCHG
 #include <asm-generic/pgtable.h>

 #endif /* _S390_PAGE_H */
Index: linux-2.6.9-rc1/include/asm-s390/pgalloc.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-s390/pgalloc.h	2004-08-24 00:02:58.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-s390/pgalloc.h	2004-08-30 18:56:26.000000000 -0700
@@ -19,6 +19,9 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>

+#define PTE_NONE 0
+#define PMD_NONE 0
+
 #define check_pgt_cache()	do {} while (0)

 extern void diag10(unsigned long addr);
@@ -97,6 +100,10 @@
 	pgd_val(*pgd) = _PGD_ENTRY | __pa(pmd);
 }

+static inline int pgd_test_and_populate(struct mm_struct *mm, pdg_t *pgd, pmd_t *pmd)
+{
+	return cmpxchg(pgd, PMD_NONE, _PGD_ENTRY | __pa(pmd)) == PMD_NONE;
+}
 #endif /* __s390x__ */

 static inline void
@@ -119,6 +126,12 @@
 	pmd_populate_kernel(mm, pmd, (pte_t *)((page-mem_map) << PAGE_SHIFT));
 }

+static inline int
+pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
+{
+	return cmpxchg(pmd, PTE_NONE, (page-mem_map) << PAGE_SHIFT) == PTE_NONE;
+}
+
 /*
  * page table entry allocation/free routines.
  */
Index: linux-2.6.9-rc1/include/asm-ppc/pgalloc.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-ppc/pgalloc.h	2004-08-24 00:01:51.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-ppc/pgalloc.h	2004-08-30 18:50:27.000000000 -0700
@@ -10,6 +10,8 @@
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(pgd_t *pgd);

+#define PMD_NONE 0
+
 /*
  * We don't have any real pmd's, and this code never triggers because
  * the pgd will always be present..
@@ -18,17 +20,32 @@
 #define pmd_free(x)                     do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)      BUG()
+#define pgd_test_and_populate(mm, pmd, pte) { BUG(); 1; }

 #ifndef CONFIG_BOOKE
 #define pmd_populate_kernel(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = __pa(pte) | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (page_to_pfn(pte) << PAGE_SHIFT) | _PMD_PRESENT)
+
+static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
+{
+	pmd_t newval = (page_to_pfn(pte) << PAGE_SHIFT) | _PMD_PRESENT;
+	return cmpxchg(pmd, PMD_NONE, pte_val(newval)) == PMD_NONE;
+}
+
 #else
 #define pmd_populate_kernel(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (unsigned long)pte | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (unsigned long)page_to_virt(pte) | _PMD_PRESENT)
+
+static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
+{
+	pmd_t newval = (unsigned long) page_to_virt(pte) | _PMD_PRESENT;
+	return cmpxchg(pmd, PMD_NONE, pte_val(newval)) == PMD_NONE;
+}
+
 #endif

 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
Index: linux-2.6.9-rc1/include/asm-ppc/pgtable.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-ppc/pgtable.h	2004-08-24 00:02:23.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-ppc/pgtable.h	2004-08-30 19:01:48.000000000 -0700
@@ -575,6 +575,16 @@
 	return __pte(pte_update(ptep, ~_PAGE_HASHPTE, 0));
 }

+static inline pte_t ptep_xchg(pte_t *ptep, pte_t newpte)
+{
+	return __pte(pte_update(ptep, ~_PAGE_HASHPTE, newpte));
+}
+
+static inline int ptep_cmpxchg(pte_t *ptep, pte_t oldpte, pte_t newpte)
+{
+	return cmpxchg(ptep, pte_val(oldpte), pte_val(newpte)) == pte_val(oldpte);
+}
+
 static inline void ptep_set_wrprotect(pte_t *ptep)
 {
 	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), 0);
@@ -731,6 +741,8 @@
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTEP_XCHG
+#define __HAVE_ARCH_PTEP_CMPXCHG
 #include <asm-generic/pgtable.h>

 #endif /* _PPC_PGTABLE_H */
Index: linux-2.6.9-rc1/include/asm-ppc64/pgtable.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-ppc64/pgtable.h	2004-08-24 00:03:38.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-ppc64/pgtable.h	2004-08-30 18:59:44.000000000 -0700
@@ -386,6 +386,25 @@
 	return __pte(old);
 }

+static inline pte_t ptep_xchg(pte_t *ptep, pte_t newval)
+{
+	unsigned long old = pte_update(ptep, newval);
+
+	if (old & _PAGE_HASHPTE)
+		hpte_update(ptep, old, 0);
+	return __pte(old);
+}
+
+static inline int ptep_cmpxchg(pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	unsigned long old = pte_update(ptep, newval);
+
+	old = cmpxchg(ptep, pte_val(oldval), pte_val(newval));
+	if (old & _PAGE_HASHPTE)
+		hpte_update(ptep, old, 0);
+	return old == pte_val(oldval);
+}
+
 static inline void pte_clear(pte_t * ptep)
 {
 	unsigned long old = pte_update(ptep, ~0UL);
@@ -547,6 +566,8 @@
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTEP_XCHG
+#define __HAVE_ARCH_PTEP_CMPXCHG
 #include <asm-generic/pgtable.h>

 #endif /* _PPC64_PGTABLE_H */
Index: linux-2.6.9-rc1/include/asm-ppc64/pgalloc.h
===================================================================
--- linux-2.6.9-rc1.orig/include/asm-ppc64/pgalloc.h	2004-08-27 19:09:56.000000000 -0700
+++ linux-2.6.9-rc1/include/asm-ppc64/pgalloc.h	2004-08-30 18:50:27.000000000 -0700
@@ -9,6 +9,9 @@
 #include <asm/tlb.h>
 #include <asm/page.h>

+#define PMD_NONE
+#define PTE_NONE
+
 extern kmem_cache_t *zero_cache;

 /*
@@ -32,6 +35,11 @@

 #define pgd_populate(MM, PGD, PMD)	pgd_set(PGD, PMD)

+static inline int pgd_test_and_populate(struct mm_struct *mm, pgd_t *pgd, pmt_t *pmdp,)
+{
+	return cmpxchg(pgdd, PMD_NONE, __ba_to_bpn(pmdp)) == PMD_NONE;
+}
+
 static inline pmd_t *
 pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
@@ -48,6 +56,11 @@
 #define pmd_populate(mm, pmd, pte_page) \
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))

+static inline int pmd_populate(struct mm_mmstruct *mm,pmd_t *pmd, pte_t *ptep)
+{
+	return cmpxchg(pmd, PTE_NONE, __ba_to_bpn(ptep) << PMD_TO_PTEPAGE_SHIFT) == PTE_NONE;
+}
+
 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
