Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSHKHbf>; Sun, 11 Aug 2002 03:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318244AbSHKH33>; Sun, 11 Aug 2002 03:29:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39174 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318076AbSHKHZ7>;
	Sun, 11 Aug 2002 03:25:59 -0400
Message-ID: <3D5614B7.29BD72D8@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 14/21] hashed spinlocking for pte_chain manipulation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch and the next address rmap pte_chain CPU cost and memory
consumption.

Anton wrote a little program which forks 10,000 tasks, and times how
long it takes to kill them all - with killall which we think works in
worst-case order.  4-way 1.3GHz POWER4:

AIX:
	35 seconds to create 10k tasks, 6 seconds to kill them
2.5.30:
	2 seconds to create 10k tasks. 47 seconds to kill them
2.5.30+these patches:
	3 seconds to create 10k tasks. 16 seconds to kill them


And on the quad PIII:

2.5.30 base:
	1.6 seconds to create 5k tasks, 32 seconds to kill them

2.5.30 without these two patches:
	1.5 seconds to create 5k tasks, 30 seconds to kill them
	(Small speedup from the pagevec code)

2.5.30 with these patches:
	1.5 seconds to create 5k tasks, 12.5 seconds to kill them

2.4.20-pre1:
	2.8 seconds to create 5k tasks, 7.4 seconds to kill them.

I have 8 pointers per cacheline, Anton has 16, so he won more.



This first patch is Daniel's hashed spinlock speedup for the rmap
pte_chains.

Instead of using the controversial test_and_set_bit-based
pte_chain_lock() it uses hashed spinlocking.

page->index is used for the hash.  It is initialised in anonymous pages
in a way which will ensure that virtually-adjacent pages will share a
common lock.

Once the page is added to swapcache the index will change.  It is
expected (hoped?) that even after addition to swapcache, adjacency in
the page->index values will continue to correlate with adjacency in
virtual-address based walks across the pagetables.

Rather than taking and releasing the lock once per page the code
arranges for the lock to be held across as many pages as possible.

The rmap pte chains appear to have added a 50% overhead to simple
fork/exec/exit-based workloads on SMP.  On Daniel's dual P4 this patch
pulled that back to ~30%, but not much improvement on my 4xPIII.

Architectures which have a buslocked clear_bit and a non-buslocked
spin_unlock() will benefit from this change as well.



 include/asm-generic/rmap.h   |    1 
 include/linux/page-flags.h   |   34 -------------
 include/linux/rmap-locking.h |  109 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/swap.h         |    2 
 mm/filemap.c                 |   19 +++++--
 mm/memory.c                  |   91 ++++++++++++++++++++++++++---------
 mm/rmap.c                    |   55 ++++++++++++++-------
 mm/swap_state.c              |   10 +++
 mm/vmscan.c                  |   28 +++++------
 9 files changed, 253 insertions(+), 96 deletions(-)

--- 2.5.31/include/asm-generic/rmap.h~daniel-rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/include/asm-generic/rmap.h	Sun Aug 11 00:20:44 2002
@@ -15,6 +15,7 @@
  *   offset of the page table entry within the page table page
  */
 #include <linux/mm.h>
+#include <linux/rmap-locking.h>
 
 static inline void pgtable_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
 {
--- 2.5.31/include/linux/page-flags.h~daniel-rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/include/linux/page-flags.h	Sun Aug 11 00:21:01 2002
@@ -65,9 +65,7 @@
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
 #define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_chainlock		15	/* lock bit for ->pte_chain */
-
-#define PG_direct		16	/* ->pte_chain points directly at pte */
+#define PG_direct		15	/* ->pte_chain points directly at pte */
 
 /*
  * Global page accounting.  One instance per CPU.
@@ -230,36 +228,6 @@ extern void get_page_state(struct page_s
 #define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
 
 /*
- * inlines for acquisition and release of PG_chainlock
- */
-static inline void pte_chain_lock(struct page *page)
-{
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
-#ifdef CONFIG_SMP
-	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
-			cpu_relax();
-	}
-#endif
-}
-
-static inline void pte_chain_unlock(struct page *page)
-{
-#ifdef CONFIG_SMP
-	smp_mb__before_clear_bit();
-	clear_bit(PG_chainlock, &page->flags);
-#endif
-	preempt_enable();
-}
-
-/*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
  */
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.31-akpm/include/linux/rmap-locking.h	Sun Aug 11 00:20:34 2002
@@ -0,0 +1,109 @@
+/*
+ * include/linux/rmap-locking.h
+ */
+
+#ifdef CONFIG_SMP
+#define NUM_RMAP_LOCKS	256
+#else
+#define NUM_RMAP_LOCKS	1	/* save some RAM */
+#endif
+
+extern spinlock_t rmap_locks[NUM_RMAP_LOCKS];
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+/*
+ * Each page has a singly-linked list of pte_chain objects attached to it.
+ * These point back at the pte's which are mapping that page.   Exclusion
+ * is needed while altering that chain, for which we use a hashed lock, based
+ * on page->index.  The kernel attempts to ensure that virtually-contiguous
+ * pages have similar page->index values.  Using this, several hotpaths are
+ * able to hold onto a spinlock across multiple pages, dropping the lock and
+ * acquiring a new one only when a page which hashes onto a different lock is
+ * encountered.
+ *
+ * The hash tries to ensure that 16 contiguous pages share the same lock.
+ */
+static inline unsigned rmap_lockno(pgoff_t index)
+{
+	return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 1);
+}
+
+static inline spinlock_t *lock_rmap(struct page *page)
+{
+	pgoff_t index = page->index;
+	while (1) {
+		spinlock_t *lock = rmap_locks + rmap_lockno(index);
+		spin_lock(lock);
+		if (index == page->index)
+			return lock;
+		spin_unlock(lock);
+	}	
+}
+
+static inline void unlock_rmap(spinlock_t *lock)
+{
+	spin_unlock(lock);
+}
+
+/*
+ * Need to take the lock while changing ->index because someone else may
+ * be using page->pte.  Changing the index here will change the page's
+ * lock address and would allow someone else to think that they had locked
+ * the pte_chain when it is in fact in use.
+ */
+static inline void set_page_index(struct page *page, pgoff_t index)
+{
+	spinlock_t *lock = lock_rmap(page);
+	page->index = index;
+	spin_unlock(lock);
+}
+
+static inline void drop_rmap_lock(spinlock_t **lock, unsigned *last_lockno)
+{
+	if (*lock) {
+		unlock_rmap(*lock);
+		*lock = NULL;
+		*last_lockno = -1;
+	}
+}
+
+static inline void
+cached_rmap_lock(struct page *page, spinlock_t **lock, unsigned *last_lockno)
+{
+	if (*lock == NULL) {
+		*lock = lock_rmap(page);
+	} else {
+		if (*last_lockno != rmap_lockno(page->index)) {
+			unlock_rmap(*lock);
+			*lock = lock_rmap(page);
+			*last_lockno = rmap_lockno(page->index);
+		}
+	}
+}
+#endif	/* defined(CONFIG_SMP) || defined(CONFIG_PREEMPT) */
+
+
+#if !defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT)
+static inline spinlock_t *lock_rmap(struct page *page)
+{
+	return (spinlock_t *)1;
+}
+
+static inline void unlock_rmap(spinlock_t *lock)
+{
+}
+
+static inline void set_page_index(struct page *page, pgoff_t index)
+{
+	page->index = index;
+}
+
+static inline void drop_rmap_lock(spinlock_t **lock, unsigned *last_lockno)
+{
+}
+
+static inline void
+cached_rmap_lock(struct page *page, spinlock_t **lock, unsigned *last_lockno)
+{
+}
+#endif	/* !defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT) */
--- 2.5.31/include/linux/swap.h~daniel-rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/include/linux/swap.h	Sun Aug 11 00:21:01 2002
@@ -144,7 +144,9 @@ struct pagevec;
 
 /* linux/mm/rmap.c */
 extern int FASTCALL(page_referenced(struct page *));
+extern void FASTCALL(__page_add_rmap(struct page *, pte_t *));
 extern void FASTCALL(page_add_rmap(struct page *, pte_t *));
+extern void FASTCALL(__page_remove_rmap(struct page *, pte_t *));
 extern void FASTCALL(page_remove_rmap(struct page *, pte_t *));
 extern int FASTCALL(try_to_unmap(struct page *));
 extern int FASTCALL(page_over_rsslimit(struct page *));
--- 2.5.31/mm/filemap.c~daniel-rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:21:01 2002
@@ -53,13 +53,20 @@
 /*
  * Lock ordering:
  *
- *  ->i_shared_lock		(vmtruncate)
- *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
+ *  ->i_shared_lock			(vmtruncate)
+ *    ->private_lock			(__free_pte->__set_page_dirty_buffers)
  *      ->swap_list_lock
- *        ->swap_device_lock	(exclusive_swap_page, others)
- *          ->mapping->page_lock
- *      ->inode_lock		(__mark_inode_dirty)
- *        ->sb_lock		(fs/fs-writeback.c)
+ *        ->swap_device_lock		(exclusive_swap_page, others)
+ *	    ->rmap_lock			(to/from swapcache)
+ *            ->mapping->page_lock
+ *		->pagemap_lru_lock	(zap_pte_range)
+ *      ->inode_lock			(__mark_inode_dirty)
+ *        ->sb_lock			(fs/fs-writeback.c)
+ *
+ *  mm->page_table_lock
+ *    ->rmap_lock			(copy_page_range)
+ *    ->mapping->page_lock		(try_to_unmap_one)
+ *
  */
 spinlock_t _pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
--- 2.5.31/mm/memory.c~daniel-rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/mm/memory.c	Sun Aug 11 00:21:00 2002
@@ -59,6 +59,22 @@ unsigned long num_physpages;
 void * high_memory;
 struct page *highmem_start_page;
 
+static unsigned rmap_lock_sequence;
+
+/*
+ * Allocate a non file-backed page which is to be mapped into user page tables.
+ * Give it an ->index which will provide good locality of reference for the
+ * rmap lock hashing.
+ */
+static struct page *alloc_mapped_page(int gfp_flags)
+{
+	struct page *page = alloc_page(gfp_flags);
+
+	if (page)
+		page->index = rmap_lock_sequence++;
+	return page;
+}
+
 /*
  * We special-case the C-O-W ZERO_PAGE, because it's such
  * a common occurrence (no need to read the page to know
@@ -212,7 +228,11 @@ int copy_page_range(struct mm_struct *ds
 	pgd_t * src_pgd, * dst_pgd;
 	unsigned long address = vma->vm_start;
 	unsigned long end = vma->vm_end;
-	unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
+	unsigned last_lockno = -1;
+	spinlock_t *rmap_lock = NULL;
+	unsigned long cow;
+
+	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
 	src_pgd = pgd_offset(src, address)-1;
 	dst_pgd = pgd_offset(dst, address)-1;
@@ -261,6 +281,7 @@ skip_copy_pte_range:		address = (address
 				goto nomem;
 			spin_lock(&src->page_table_lock);			
 			src_pte = pte_offset_map_nested(src_pmd, address);
+			BUG_ON(rmap_lock != NULL);
 			do {
 				pte_t pte = *src_pte;
 				struct page *ptepage;
@@ -284,13 +305,19 @@ skip_copy_pte_range:		address = (address
 				if (PageReserved(ptepage))
 					goto cont_copy_pte_range;
 
-				/* If it's a COW mapping, write protect it both in the parent and the child */
+				/*
+				 * If it's a COW mapping, write protect it both
+				 * in the parent and the child
+				 */
 				if (cow) {
 					ptep_set_wrprotect(src_pte);
 					pte = *src_pte;
 				}
 
-				/* If it's a shared mapping, mark it clean in the child */
+				/*
+				 * If it's a shared mapping, mark it clean in
+				 * the child
+				 */
 				if (vma->vm_flags & VM_SHARED)
 					pte = pte_mkclean(pte);
 				pte = pte_mkold(pte);
@@ -298,9 +325,12 @@ skip_copy_pte_range:		address = (address
 				dst->rss++;
 
 cont_copy_pte_range:		set_pte(dst_pte, pte);
-				page_add_rmap(ptepage, dst_pte);
+				cached_rmap_lock(ptepage, &rmap_lock,
+						&last_lockno);
+				__page_add_rmap(ptepage, dst_pte);
 cont_copy_pte_range_noset:	address += PAGE_SIZE;
 				if (address >= end) {
+					drop_rmap_lock(&rmap_lock,&last_lockno);
 					pte_unmap_nested(src_pte);
 					pte_unmap(dst_pte);
 					goto out_unlock;
@@ -308,6 +338,7 @@ cont_copy_pte_range_noset:	address += PA
 				src_pte++;
 				dst_pte++;
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
+			drop_rmap_lock(&rmap_lock, &last_lockno);
 			pte_unmap_nested(src_pte-1);
 			pte_unmap(dst_pte-1);
 			spin_unlock(&src->page_table_lock);
@@ -329,6 +360,8 @@ static void zap_pte_range(mmu_gather_t *
 	unsigned long offset;
 	pte_t *ptep;
 	struct pagevec pvec;
+	spinlock_t *rmap_lock = NULL;
+	unsigned last_lockno = -1;
 
 	if (pmd_none(*pmd))
 		return;
@@ -345,28 +378,40 @@ static void zap_pte_range(mmu_gather_t *
 	pagevec_init(&pvec);
 	for (offset=0; offset < size; ptep++, offset += PAGE_SIZE) {
 		pte_t pte = *ptep;
+		unsigned long pfn;
+		struct page *page;
+
 		if (pte_none(pte))
 			continue;
-		if (pte_present(pte)) {
-			unsigned long pfn = pte_pfn(pte);
-
-			pte = ptep_get_and_clear(ptep);
-			tlb_remove_tlb_entry(tlb, ptep, address+offset);
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-				if (!PageReserved(page)) {
-					if (pte_dirty(pte))
-						set_page_dirty(page);
-					tlb->freed++;
-					page_remove_rmap(page, ptep);
-					tlb_remove_page(tlb, &pvec, page);
-				}
-			}
-		} else {
+		if (!pte_present(pte)) {
 			free_swap_and_cache(pte_to_swp_entry(pte));
 			pte_clear(ptep);
+			continue;
+		}
+
+		pfn = pte_pfn(pte);
+		pte = ptep_get_and_clear(ptep);
+		tlb_remove_tlb_entry(tlb, ptep, address+offset);
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		if (!PageReserved(page)) {
+			/*
+			 * rmap_lock nests outside mapping->page_lock
+			 */
+			if (pte_dirty(pte))
+				set_page_dirty(page);
+			tlb->freed++;
+			cached_rmap_lock(page, &rmap_lock, &last_lockno);
+			__page_remove_rmap(page, ptep);
+			/*
+			 * This will take pagemap_lru_lock.  Which nests inside
+			 * rmap_lock
+			 */
+			tlb_remove_page(tlb, &pvec, page);
 		}
 	}
+	drop_rmap_lock(&rmap_lock, &last_lockno);
 	pte_unmap(ptep-1);
 	pagevec_release(&pvec);
 }
@@ -1000,7 +1045,7 @@ static int do_wp_page(struct mm_struct *
 	page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
 
-	new_page = alloc_page(GFP_HIGHUSER);
+	new_page = alloc_mapped_page(GFP_HIGHUSER);
 	if (!new_page)
 		goto no_mem;
 	copy_cow_page(old_page,new_page,address);
@@ -1249,7 +1294,7 @@ static int do_anonymous_page(struct mm_s
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
 
-		page = alloc_page(GFP_HIGHUSER);
+		page = alloc_mapped_page(GFP_HIGHUSER);
 		if (!page)
 			goto no_mem;
 		clear_user_highpage(page, addr);
@@ -1318,7 +1363,7 @@ static int do_no_page(struct mm_struct *
 	 * Should we do an early C-O-W break?
 	 */
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
-		struct page * page = alloc_page(GFP_HIGHUSER);
+		struct page * page = alloc_mapped_page(GFP_HIGHUSER);
 		if (!page) {
 			page_cache_release(new_page);
 			return VM_FAULT_OOM;
--- 2.5.31/mm/rmap.c~daniel-rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/mm/rmap.c	Sun Aug 11 00:21:01 2002
@@ -52,6 +52,8 @@ struct pte_chain {
 	pte_t * ptep;
 };
 
+spinlock_t rmap_locks[NUM_RMAP_LOCKS];
+
 static kmem_cache_t	*pte_chain_cache;
 static inline struct pte_chain * pte_chain_alloc(void);
 static inline void pte_chain_free(struct pte_chain *, struct pte_chain *,
@@ -63,7 +65,7 @@ static inline void pte_chain_free(struct
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
- * Caller needs to hold the pte_chain_lock.
+ * Caller needs to hold the page's rmap lock.
  */
 int page_referenced(struct page * page)
 {
@@ -94,10 +96,9 @@ int page_referenced(struct page * page)
  * Add a new pte reverse mapping to a page.
  * The caller needs to hold the mm->page_table_lock.
  */
-void page_add_rmap(struct page * page, pte_t * ptep)
+void __page_add_rmap(struct page *page, pte_t *ptep)
 {
 	struct pte_chain * pte_chain;
-	unsigned long pfn = pte_pfn(*ptep);
 
 #ifdef DEBUG_RMAP
 	if (!page || !ptep)
@@ -108,11 +109,10 @@ void page_add_rmap(struct page * page, p
 		BUG();
 #endif
 
-	if (!pfn_valid(pfn) || PageReserved(page))
+	if (!pfn_valid(pte_pfn(*ptep)) || PageReserved(page))
 		return;
 
 #ifdef DEBUG_RMAP
-	pte_chain_lock(page);
 	{
 		struct pte_chain * pc;
 		if (PageDirect(page)) {
@@ -125,11 +125,8 @@ void page_add_rmap(struct page * page, p
 			}
 		}
 	}
-	pte_chain_unlock(page);
 #endif
 
-	pte_chain_lock(page);
-
 	if (PageDirect(page)) {
 		/* Convert a direct pointer into a pte_chain */
 		pte_chain = pte_chain_alloc();
@@ -148,11 +145,20 @@ void page_add_rmap(struct page * page, p
 		page->pte.direct = ptep;
 		SetPageDirect(page);
 	}
-
-	pte_chain_unlock(page);
 	inc_page_state(nr_reverse_maps);
 }
 
+void page_add_rmap(struct page *page, pte_t *ptep)
+{
+	if (pfn_valid(pte_pfn(*ptep)) && !PageReserved(page)) {
+		spinlock_t *rmap_lock;
+
+		rmap_lock = lock_rmap(page);
+		__page_add_rmap(page, ptep);
+		unlock_rmap(rmap_lock);
+	}
+}
+
 /**
  * page_remove_rmap - take down reverse mapping to a page
  * @page: page to remove mapping from
@@ -163,18 +169,15 @@ void page_add_rmap(struct page * page, p
  * the page.
  * Caller needs to hold the mm->page_table_lock.
  */
-void page_remove_rmap(struct page * page, pte_t * ptep)
+void __page_remove_rmap(struct page *page, pte_t *ptep)
 {
 	struct pte_chain * pc, * prev_pc = NULL;
-	unsigned long pfn = page_to_pfn(page);
 
 	if (!page || !ptep)
 		BUG();
-	if (!pfn_valid(pfn) || PageReserved(page))
+	if (!pfn_valid(pte_pfn(*ptep)) || PageReserved(page))
 		return;
 
-	pte_chain_lock(page);
-
 	if (PageDirect(page)) {
 		if (page->pte.direct == ptep) {
 			page->pte.direct = NULL;
@@ -212,10 +215,20 @@ void page_remove_rmap(struct page * page
 
 out:
 	dec_page_state(nr_reverse_maps);
-	pte_chain_unlock(page);
 	return;
 }
 
+void page_remove_rmap(struct page *page, pte_t *ptep)
+{
+	if (pfn_valid(pte_pfn(*ptep)) && !PageReserved(page)) {
+		spinlock_t *rmap_lock;
+
+		rmap_lock = lock_rmap(page);
+		__page_remove_rmap(page, ptep);
+		unlock_rmap(rmap_lock);
+	}
+}
+
 /**
  * try_to_unmap_one - worker function for try_to_unmap
  * @page: page to unmap
@@ -227,7 +240,7 @@ out:
  * Locking:
  *	pagemap_lru_lock		page_launder()
  *	    page lock			page_launder(), trylock
- *		pte_chain_lock		page_launder()
+ *		rmap_lock		page_launder()
  *		    mm->page_table_lock	try_to_unmap_one(), trylock
  */
 static int FASTCALL(try_to_unmap_one(struct page *, pte_t *));
@@ -368,7 +381,7 @@ int try_to_unmap(struct page * page)
  * This function unlinks pte_chain from the singly linked list it
  * may be on and adds the pte_chain to the free list. May also be
  * called for new pte_chain structures which aren't on any list yet.
- * Caller needs to hold the pte_chain_lock if the page is non-NULL.
+ * Caller needs to hold the rmap_lock if the page is non-NULL.
  */
 static inline void pte_chain_free(struct pte_chain * pte_chain,
 		struct pte_chain * prev_pte_chain, struct page * page)
@@ -386,7 +399,6 @@ static inline void pte_chain_free(struct
  *
  * Returns a pointer to a fresh pte_chain structure. Allocates new
  * pte_chain structures as required.
- * Caller needs to hold the page's pte_chain_lock.
  */
 static inline struct pte_chain *pte_chain_alloc(void)
 {
@@ -395,6 +407,11 @@ static inline struct pte_chain *pte_chai
 
 void __init pte_chain_init(void)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rmap_locks); i++)
+		spin_lock_init(&rmap_locks[i]);
+
 	pte_chain_cache = kmem_cache_create(	"pte_chain",
 						sizeof(struct pte_chain),
 						0,
--- 2.5.31/mm/swap_state.c~daniel-rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/mm/swap_state.c	Sun Aug 11 00:20:34 2002
@@ -16,6 +16,7 @@
 #include <linux/buffer_head.h>	/* block_sync_page() */
 #include <linux/pagevec.h>
 
+#include <asm/rmap.h>
 #include <asm/pgtable.h>
 
 /*
@@ -71,6 +72,12 @@ int add_to_swap_cache(struct page *page,
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
+
+	/*
+	 * Sneakily do this here so we don't add cost to add_to_page_cache().
+	 */
+	set_page_index(page, entry.val);
+
 	error = add_to_page_cache(page, &swapper_space, entry.val);
 	/*
 	 * Anon pages are already on the LRU, we don't run lru_cache_add here.
@@ -204,6 +211,7 @@ int move_to_swap_cache(struct page *page
 		return -ENOENT;
 	}
 
+	set_page_index(page, entry.val);
 	write_lock(&swapper_space.page_lock);
 	write_lock(&mapping->page_lock);
 
@@ -220,7 +228,6 @@ int move_to_swap_cache(struct page *page
 		 */
 		ClearPageUptodate(page);
 		ClearPageReferenced(page);
-
 		SetPageLocked(page);
 		ClearPageDirty(page);
 		___add_to_page_cache(page, &swapper_space, entry.val);
@@ -252,6 +259,7 @@ int move_from_swap_cache(struct page *pa
 	BUG_ON(PageWriteback(page));
 	BUG_ON(page_has_buffers(page));
 
+	set_page_index(page, index);
 	write_lock(&swapper_space.page_lock);
 	write_lock(&mapping->page_lock);
 
--- 2.5.31/mm/vmscan.c~daniel-rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sun Aug 11 00:21:01 2002
@@ -25,6 +25,7 @@
 #include <linux/buffer_head.h>		/* for try_to_release_page() */
 #include <linux/pagevec.h>
 
+#include <asm/rmap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -67,7 +68,7 @@
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif
 
-/* Must be called with page's pte_chain_lock held. */
+/* Must be called with page's rmap_lock held. */
 static inline int page_mapping_inuse(struct page * page)
 {
 	struct address_space *mapping = page->mapping;
@@ -106,6 +107,7 @@ shrink_list(struct list_head *page_list,
 	while (!list_empty(page_list)) {
 		struct page *page;
 		int may_enter_fs;
+		spinlock_t *rmap_lock;
 
 		page = list_entry(page_list->prev, struct page, lru);
 		list_del(&page->lru);
@@ -125,10 +127,10 @@ shrink_list(struct list_head *page_list,
 				goto keep_locked;
 		}
 
-		pte_chain_lock(page);
+		rmap_lock = lock_rmap(page);
 		if (page_referenced(page) && page_mapping_inuse(page)) {
 			/* In active use or really unfreeable.  Activate it. */
-			pte_chain_unlock(page);
+			unlock_rmap(rmap_lock);
 			goto activate_locked;
 		}
 
@@ -139,10 +141,10 @@ shrink_list(struct list_head *page_list,
 		 * XXX: implement swap clustering ?
 		 */
 		if (page->pte.chain && !page->mapping && !PagePrivate(page)) {
-			pte_chain_unlock(page);
+			unlock_rmap(rmap_lock);
 			if (!add_to_swap(page))
 				goto activate_locked;
-			pte_chain_lock(page);
+			rmap_lock = lock_rmap(page);
 		}
 
 		/*
@@ -153,16 +155,16 @@ shrink_list(struct list_head *page_list,
 			switch (try_to_unmap(page)) {
 			case SWAP_ERROR:
 			case SWAP_FAIL:
-				pte_chain_unlock(page);
+				unlock_rmap(rmap_lock);
 				goto activate_locked;
 			case SWAP_AGAIN:
-				pte_chain_unlock(page);
+				unlock_rmap(rmap_lock);
 				goto keep_locked;
 			case SWAP_SUCCESS:
 				; /* try to free the page below */
 			}
 		}
-		pte_chain_unlock(page);
+		unlock_rmap(rmap_lock);
 		mapping = page->mapping;
 
 		/*
@@ -380,6 +382,8 @@ static /* inline */ void refill_inactive
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
+	spinlock_t *rmap_lock = NULL;
+	unsigned last_lockno = -1;
 
 	lru_add_drain();
 	spin_lock_irq(&_pagemap_lru_lock);
@@ -398,20 +402,16 @@ static /* inline */ void refill_inactive
 		page = list_entry(l_hold.prev, struct page, lru);
 		list_del(&page->lru);
 		if (page->pte.chain) {
-			if (test_and_set_bit(PG_chainlock, &page->flags)) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
+			cached_rmap_lock(page, &rmap_lock, &last_lockno);
 			if (page->pte.chain && page_referenced(page)) {
-				pte_chain_unlock(page);
 				list_add(&page->lru, &l_active);
 				continue;
 			}
-			pte_chain_unlock(page);
 		}
 		list_add(&page->lru, &l_inactive);
 		pgdeactivate++;
 	}
+	drop_rmap_lock(&rmap_lock, &last_lockno);
 
 	pagevec_init(&pvec);
 	spin_lock_irq(&_pagemap_lru_lock);

.
