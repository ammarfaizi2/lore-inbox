Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSIZLQz>; Thu, 26 Sep 2002 07:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262497AbSIZLQz>; Thu, 26 Sep 2002 07:16:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38627 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262303AbSIZLQv>;
	Thu, 26 Sep 2002 07:16:51 -0400
Date: Thu, 26 Sep 2002 13:30:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
Message-ID: <Pine.LNX.4.44.0209261311070.11487-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


while running fork() testcases with NPTL we found a number of futex
related failures that i tracked down to the following conceptual bug in
the futex code:

if a futex is placed into private anonymous memory (eg. on the stack, or
in malloc() space, which is the common case with NPTL), then a fork()  
followed by a COW in the original threaded context breaks all pending
FUTEX_WAIT operations on that page. The COW fault in the original
(threaded) context allocates a new page and installs it into the pagetable
- while a pending futex operation is hashed on that physical page. Any
subsequent FUTEX_WAKE will get lost, and the pending FUTEX_WAITs will get
stuck indefinitely. Ie. futexes were not really designed with COW in mind
- they were designed to be used in non-COW shared memory. This is a very
bad limitation and renders NPTL essencially useless, which has ABI
compatibility and on-stack automatic use/unuse of POSIX locking primitives
as an important goal.

there are a number of approaches possible to solve this limitation, i
picked the patch below. It extends the concept of page pinning with the
'stickyness' bit - a sticky page will remain in the pinning VM's context,
no matter what. The futex code marks the pinned page as sticky, in a
pagefault-atomic way, and the fork() code detects this condition and does
the COW copy upfront.

another implementation would be an idea from Linus: the page's lru list
pointer can in theory be used for pinned pages (pinned pages do not have
much LRU meaning anyway), and this pointer could specify the 'owner' MM of
the physical page. The COW fault handler then checks the sticky page:

 - if the faulting context is a non-owner (ie. the fork()-ed child), then
   the normal COW path is taken - new page allocated and installed.

 - if the faulting context is the owner, then the pte chain is walked, and
   the new page is installed into every 'other' pte. This needs a
   cross-CPU single-page TLB flush though. The TLB flush could be
   optimized if we had a way to get to the mapping MM's of the individual
   pte chain entries - is this possible?

anyway, the attached patch is definitely the simpler approach, and any
more complex solution can be implemented ontop of this.

the downside of the sync-copy variant are the extra copies that could
perhaps be avoided via lazy copying. Code that did fork()+exec() can avoid
all of this overhead by using posix_spawn() which (will hopefully soon)  
use clone()+exec() in NPTL. But even for normal forks() the number of
pending futex operations should be realtively low most of the time - and
it can be at most one pinned page per thread, in the NPTL design. And
those pinned pages will be copied in the future anyway, they are active
futex pages.

with this patch applied (against BK-curr), all previously failing NPTL
fork testcases pass, and futexes are now full-fledged OS primitives that
can be used on any type of memory mapping concept - anonymous, shared,
cow-shared, named, etc.

	Ingo

--- linux/include/linux/page-flags.h.orig	Thu Sep 26 12:48:42 2002
+++ linux/include/linux/page-flags.h	Thu Sep 26 13:03:21 2002
@@ -69,6 +69,8 @@
 
 #define PG_direct		16	/* ->pte_chain points directly at pte */
 
+#define PG_sticky		17	/* sticks to the pinning VM */
+
 /*
  * Global page accounting.  One instance per CPU.
  */
@@ -203,6 +205,10 @@
 #define TestSetPageDirect(page)	test_and_set_bit(PG_direct, &(page)->flags)
 #define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
 #define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
+
+#define PageSticky(page)	test_bit(PG_sticky, &(page)->flags)
+#define SetPageSticky(page)	set_bit(PG_sticky, &(page)->flags)
+#define ClearPageSticky(page)	clear_bit(PG_sticky, &(page)->flags)
 
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
--- linux/kernel/futex.c.orig	Fri Sep 20 17:20:21 2002
+++ linux/kernel/futex.c	Thu Sep 26 13:03:21 2002
@@ -90,6 +90,7 @@
 	/* Avoid releasing the page which is on the LRU list.  I don't
            know if this is correct, but it stops the BUG() in
            __free_pages_ok(). */
+	ClearPageSticky(page);
 	page_cache_release(page);
 }
 
@@ -151,17 +152,23 @@
 static struct page *pin_page(unsigned long page_start)
 {
 	struct mm_struct *mm = current->mm;
-	struct page *page;
+	struct page *page = NULL;
 	int err;
 
-	down_read(&mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 	err = get_user_pages(current, mm, page_start,
 			     1 /* one page */,
-			     0 /* writable not important */,
+			     1 /* writable */,
 			     0 /* don't force */,
 			     &page,
 			     NULL /* don't return vmas */);
-	up_read(&mm->mmap_sem);
+	/*
+	 * We mark the page sticky, to make sure a COW does not
+	 * change the page from under hashed waiters.
+	 */
+	if (page)
+		SetPageSticky(page);
+	up_write(&mm->mmap_sem);
 
 	if (err < 0)
 		return ERR_PTR(err);
--- linux/mm/memory.c.orig	Fri Sep 20 17:20:25 2002
+++ linux/mm/memory.c	Thu Sep 26 13:03:21 2002
@@ -188,6 +188,75 @@
 out:
 	return pte_offset_kernel(pmd, address);
 }
+
+/*
+ * Establish a new mapping:
+ *  - flush the old one
+ *  - update the page tables
+ *  - inform the TLB about the new one
+ *
+ * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
+ */
+static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
+{
+	set_pte(page_table, entry);
+	flush_tlb_page(vma, address);
+	update_mmu_cache(vma, address, entry);
+}
+
+/*
+ * Sticky page handling.
+ *
+ * This code ensures that a sticky pinned page is not COW-ed away
+ * from the 'owner' VM. Eg. futex hashing relies on this.
+ */
+static inline int handle_sticky_page(struct mm_struct *src,
+	struct mm_struct *dst, pmd_t *src_pmd, pmd_t *dst_pmd, pte_t **src_pte,
+	pte_t **dst_pte, struct page *old_page, pte_t *pte,
+	unsigned long address, struct vm_area_struct *vma)
+{
+	struct page *new_page;
+
+	page_cache_get(old_page);
+
+	pte_unmap_nested(*src_pte);
+	pte_unmap(*dst_pte);
+	spin_unlock(&src->page_table_lock);
+
+	new_page = alloc_page(GFP_HIGHUSER);
+	if (!new_page) {
+		page_cache_release(old_page);
+		/*
+		 * Return with no locks held:
+		 */
+		return -ENOMEM;
+	}
+	if (old_page == ZERO_PAGE(address))
+		clear_user_highpage(new_page, address);
+	else
+		copy_user_highpage(new_page, old_page, address);
+
+	page_cache_release(old_page);
+
+	spin_lock(&src->page_table_lock);
+	*dst_pte = pte_offset_map(dst_pmd, address);
+	*src_pte = pte_offset_map_nested(src_pmd, address);
+	/*
+	 * If another place raced with us, just free the new page
+	 * and return - where we'll re-check what to do with the pte.
+	 */
+	if (!pte_same(**src_pte, *pte)) {
+		__free_page(new_page);
+		return 1;
+	}
+	establish_pte(vma, address, *dst_pte, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
+	page_add_rmap(new_page, *dst_pte);
+	lru_cache_add(new_page);
+	dst->rss++;
+
+	return 0;
+}
+
 #define PTE_TABLE_MASK	((PTRS_PER_PTE-1) * sizeof(pte_t))
 #define PMD_TABLE_MASK	((PTRS_PER_PMD-1) * sizeof(pmd_t))
 
@@ -240,7 +309,7 @@
 			goto nomem;
 
 		do {
-			pte_t * src_pte, * dst_pte;
+			pte_t *src_pte, *dst_pte;
 		
 			/* copy_pte_range */
 		
@@ -267,6 +336,7 @@
 				
 				/* copy_one_pte */
 
+repeat_check:
 				if (pte_none(pte))
 					goto cont_copy_pte_range_noset;
 				/* pte contains position in swap, so copy. */
@@ -276,15 +346,26 @@
 					goto cont_copy_pte_range_noset;
 				}
 				ptepage = pte_page(pte);
+				if (PageReserved(ptepage))
+					goto cont_copy_pte_range;
 				pfn = pte_pfn(pte);
 				if (!pfn_valid(pfn))
 					goto cont_copy_pte_range;
-				ptepage = pfn_to_page(pfn);
-				if (PageReserved(ptepage))
-					goto cont_copy_pte_range;
 
 				/* If it's a COW mapping, write protect it both in the parent and the child */
 				if (cow) {
+					if (unlikely(PageSticky(ptepage))) {
+						int ret = handle_sticky_page(src, dst, src_pmd, dst_pmd, &src_pte, &dst_pte, ptepage, &pte, address, vma);
+						if (ret < 0)
+							goto nomem;
+
+						/* Was there a race? */
+						if (ret) {
+							pte = *src_pte;
+							goto repeat_check;
+						}
+						goto cont_copy_pte_range_noset;
+					}
 					ptep_set_wrprotect(src_pte);
 					pte = *src_pte;
 				}
@@ -950,21 +1031,6 @@
 	flush_tlb_range(vma, beg, end);
 	spin_unlock(&mm->page_table_lock);
 	return error;
-}
-
-/*
- * Establish a new mapping:
- *  - flush the old one
- *  - update the page tables
- *  - inform the TLB about the new one
- *
- * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
- */
-static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
-{
-	set_pte(page_table, entry);
-	flush_tlb_page(vma, address);
-	update_mmu_cache(vma, address, entry);
 }
 
 /*

