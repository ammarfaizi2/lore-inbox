Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSHBTii>; Fri, 2 Aug 2002 15:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSHBTii>; Fri, 2 Aug 2002 15:38:38 -0400
Received: from dsl-213-023-043-125.arcor-ip.net ([213.23.43.125]:28856 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316880AbSHBTiC>;
	Fri, 2 Aug 2002 15:38:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] Rmap speedup
Date: Fri, 2 Aug 2002 21:42:42 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17aiJv-0007cr-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch eliminates about 35% of the raw rmap setup/teardown overhead by 
adopting a new locking interface that allows the add_rmaps to be batched in 
copy_page_range.  This is work-in-progress.  I expect to show a further 35% 
overhead reduction shortly, by batching the remove_rmaps as well.  Further 
gains will come more slowly, but I hope that an immediate 70% reduction in 
overhead gets us into the doesn't-suck-too-much range, and we can move on
to other benchmarks.

This patch is against 2.4.19-pre7+rmap13b.  I'll forward port to 2.5 in due 
course, however this should allow you to verify my results.

Here is the script I used, essentially the same as the one you originally 
posted, but all in one piece:

---------------------------
#!/bin/sh

doit()
{
        ( cat $1 | wc -l )
}
        
doitlots()
{
count=0
        
while (( count<500 ))
do
        doit foo >/dev/null

        count=$(expr $count + 1)
done
echo done
}

echo hello >foobar
rm -f foocount
echo >foocount

count=0
while (( count<10 ))
do
	doitlots foobar >>foocount &
	let count++
done

count=0
while (( count<10 ))
do
	count=$(cat foocount | wc -l)
done
---------------------------

--- 2.4.19-pre7.clean/include/linux/mm.h	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/include/linux/mm.h	Fri Aug  2 17:45:04 2002
@@ -131,8 +131,10 @@
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
 };
 
-/* forward declaration; pte_chain is meant to be internal to rmap.c */
-struct pte_chain;
+struct pte_chain {
+	struct pte_chain * next;
+	pte_t * ptep;
+};
 
 /*
  * Each physical page in the system has a struct page associated with
@@ -324,29 +326,40 @@
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
 
-/*
- * inlines for acquisition and release of PG_chainlock
- */
-static inline void pte_chain_lock(struct page *page)
+#define num_rmap_locks (1 << 8)
+
+extern spinlock_t rmap_locks[num_rmap_locks];
+
+void init_rmap_locks(void);
+
+static inline unsigned long rmap_locknum(unsigned long index)
 {
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
-			cpu_relax();
-	}
+	return (index >> 4) & (num_rmap_locks - 1);
 }
 
-static inline void pte_chain_unlock(struct page *page)
+static inline spinlock_t *lock_rmap(struct page *page)
 {
-	clear_bit(PG_chainlock, &page->flags);
+	unsigned long index = page->index;
+	while (1) {
+		spinlock_t *lock = rmap_locks + rmap_locknum(index);
+		spin_lock(lock);
+		if (index == page->index)
+			return lock;
+		spin_unlock(lock);
+	}	
 }
 
+static inline void set_page_index(struct page *page, unsigned long index)
+{
+	spinlock_t *lock = lock_rmap(page);
+	page->index = index;
+	spin_unlock(lock);
+}
+
+struct pte_chain *pte_chain_alloc(zone_t *zone);
+void pte_chain_push(zone_t *zone, struct pte_chain *pte_chain);
+void add_rmap_nolock(struct page* page, pte_t *ptep, struct pte_chain *pte_chain);
+
 /*
  * The zone field is never updated after free_area_init_core()
  * sets it, so none of the operations on it need to be atomic.
@@ -519,7 +532,7 @@
 extern int shmem_zero_setup(struct vm_area_struct *);
 
 extern void zap_page_range(struct mm_struct *mm, unsigned long address, unsigned long size);
-extern int copy_page_range(struct mm_struct *dst, struct mm_struct *src, struct vm_area_struct *vma);
+extern int copy_page_range(struct mm_struct *dst, struct mm_struct *src, struct vm_area_struct *vma, unsigned *locknum);
 extern int remap_page_range(unsigned long from, unsigned long to, unsigned long size, pgprot_t prot);
 extern int zeromap_page_range(unsigned long from, unsigned long size, pgprot_t prot);
 
--- 2.4.19-pre7.clean/kernel/fork.c	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/kernel/fork.c	Fri Aug  2 16:25:22 2002
@@ -132,6 +132,7 @@
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
+	unsigned rmap_locknum = -1;
 
 	flush_cache_mm(current->mm);
 	mm->locked_vm = 0;
@@ -191,7 +192,7 @@
 		*pprev = tmp;
 		pprev = &tmp->vm_next;
 		mm->map_count++;
-		retval = copy_page_range(mm, current->mm, tmp);
+		retval = copy_page_range(mm, current->mm, tmp, &rmap_locknum);
 		spin_unlock(&mm->page_table_lock);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
--- 2.4.19-pre7.clean/mm/bootmem.c	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/mm/bootmem.c	Fri Aug  2 16:25:22 2002
@@ -61,6 +61,8 @@
 	 */
 	memset(bdata->node_bootmem_map, 0xff, mapsize);
 
+	init_rmap_locks(); // is there a better place for this?
+
 	return mapsize;
 }
 
--- 2.4.19-pre7.clean/mm/filemap.c	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/mm/filemap.c	Fri Aug  2 16:25:22 2002
@@ -635,7 +635,7 @@
 	if (!PageLocked(page))
 		BUG();
 
-	page->index = index;
+	set_page_index(page, index);
 	page_cache_get(page);
 	spin_lock(&pagecache_lock);
 	add_page_to_inode_queue(mapping, page);
@@ -658,7 +658,7 @@
 	flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_dirty | 1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked);
 	page->flags = flags | (1 << PG_locked);
 	page_cache_get(page);
-	page->index = offset;
+	set_page_index(page, offset);
 	add_page_to_inode_queue(mapping, page);
 	add_page_to_hash_queue(page, hash);
 }
--- 2.4.19-pre7.clean/mm/memory.c	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/mm/memory.c	Fri Aug  2 17:48:29 2002
@@ -176,13 +176,17 @@
  * dst->page_table_lock is held on entry and exit,
  * but may be dropped within pmd_alloc() and pte_alloc().
  */
+struct pte_chain *pte_chain_alloc(zone_t *zone);
+
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma)
+			struct vm_area_struct *vma, unsigned *unused_locknum)
 {
 	pgd_t * src_pgd, * dst_pgd;
 	unsigned long address = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
+	zone_t *pte_chain_zone = zone_table[ZONE_NORMAL];
+	struct pte_chain *local_pte_chain = NULL, *pte_chain;
 
 	src_pgd = pgd_offset(src, address)-1;
 	dst_pgd = pgd_offset(dst, address)-1;
@@ -212,6 +216,8 @@
 
 		do {
 			pte_t * src_pte, * dst_pte;
+			unsigned last_locknum = -1;
+			spinlock_t *rmap_lock = NULL;
 		
 			/* copy_pte_range */
 		
@@ -247,6 +253,28 @@
 					goto cont_copy_pte_range_noset;
 				}
 				ptepage = pte_page(pte);
+
+				if (!local_pte_chain) {
+					unsigned more = 16;
+					if (last_locknum != -1) {
+						spin_unlock(rmap_lock);
+						last_locknum = -1;
+					}
+					while (more--) {
+						struct pte_chain *new = pte_chain_alloc(pte_chain_zone);
+						new->next = local_pte_chain;
+						local_pte_chain = new;
+					}
+				}
+
+				if (last_locknum != rmap_locknum(ptepage->index)) {
+					if (last_locknum != -1) {
+
+						spin_unlock(rmap_lock);
+					}
+					rmap_lock = lock_rmap(ptepage);
+					last_locknum = rmap_locknum(ptepage->index);
+				}
 				if ((!VALID_PAGE(ptepage)) || 
 				    PageReserved(ptepage))
 					goto cont_copy_pte_range;
@@ -265,15 +293,24 @@
 				dst->rss++;
 
 cont_copy_pte_range:		set_pte(dst_pte, pte);
-				page_add_rmap(ptepage, dst_pte);
+				pte_chain = local_pte_chain;
+				local_pte_chain = local_pte_chain->next;
+				add_rmap_nolock(ptepage, dst_pte, pte_chain);
+
 cont_copy_pte_range_noset:	address += PAGE_SIZE;
-				if (address >= end)
+				if (address >= end) {
+					if (last_locknum != -1)
+						spin_unlock(rmap_lock);
 					goto out_unlock;
+				}
 				src_pte++;
 				dst_pte++;
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
 			spin_unlock(&src->page_table_lock);
-		
+
+			if (last_locknum != -1)
+				spin_unlock(rmap_lock);
+
 cont_copy_pmd_range:	src_pmd++;
 			dst_pmd++;
 		} while ((unsigned long)src_pmd & PMD_TABLE_MASK);
@@ -281,6 +318,13 @@
 out_unlock:
 	spin_unlock(&src->page_table_lock);
 out:
+	spin_lock(&pte_chain_zone->pte_chain_freelist_lock);
+	while (local_pte_chain) {
+		struct pte_chain *next = local_pte_chain->next;
+		pte_chain_push(pte_chain_zone, local_pte_chain);
+		local_pte_chain = next;
+	}
+	spin_unlock(&pte_chain_zone->pte_chain_freelist_lock);
 	return 0;
 nomem:
 	return -ENOMEM;
@@ -1518,3 +1562,4 @@
 	}
 	return page;
 }
+
--- 2.4.19-pre7.clean/mm/page_alloc.c	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/mm/page_alloc.c	Fri Aug  2 17:49:36 2002
@@ -213,6 +213,7 @@
 
 		if (curr != head) {
 			unsigned int index;
+			static unsigned foo_page_allocs;
 
 			page = memlist_entry(curr, struct page, list);
 			if (BAD_RANGE(zone,page))
@@ -227,6 +228,7 @@
 			spin_unlock_irqrestore(&zone->lock, flags);
 
 			set_page_count(page, 1);
+			page->index = foo_page_allocs++ >> PAGE_CACHE_SHIFT;
 			if (BAD_RANGE(zone,page))
 				BUG();
 			DEBUG_LRU_PAGE(page);
--- 2.4.19-pre7.clean/mm/rmap.c	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/mm/rmap.c	Fri Aug  2 17:33:51 2002
@@ -43,16 +43,20 @@
  * in systems with long-lived applications the relative overhead of
  * exit() will be lower since the applications are long-lived.
  */
-struct pte_chain {
-	struct pte_chain * next;
-	pte_t * ptep;
-};
 
-static inline struct pte_chain * pte_chain_alloc(zone_t *);
+spinlock_t rmap_locks[num_rmap_locks];
+
 static inline void pte_chain_free(struct pte_chain *, struct pte_chain *,
 		struct page *, zone_t *);
 static void alloc_new_pte_chains(zone_t *);
 
+void init_rmap_locks(void)
+{
+	int i = 0;
+	while (i < num_rmap_locks)
+		spin_lock_init(rmap_locks + i++);
+}
+
 /**
  * page_referenced - test if the page was referenced
  * @page: the page to test
@@ -86,9 +90,10 @@
  * Add a new pte reverse mapping to a page.
  * The caller needs to hold the mm->page_table_lock.
  */
-void page_add_rmap(struct page * page, pte_t * ptep)
+void page_add_rmap(struct page *page, pte_t *ptep)
 {
-	struct pte_chain * pte_chain;
+	struct pte_chain *pte_chain;
+	spinlock_t *rmap_lock;
 
 #ifdef DEBUG_RMAP
 	if (!page || !ptep)
@@ -103,7 +108,7 @@
 		return;
 
 #ifdef DEBUG_RMAP
-	pte_chain_lock(page);
+	rmap_lock = lock_rmap(page);
 	{
 		struct pte_chain * pc;
 		for (pc = page->pte_chain; pc; pc = pc->next) {
@@ -111,19 +116,48 @@
 				BUG();
 		}
 	}
-	pte_chain_unlock(page);
+	spin_unlock(rmap_lock);
 #endif
 
 	pte_chain = pte_chain_alloc(page_zone(page));
-
-	pte_chain_lock(page);
+	rmap_lock = lock_rmap(page);
 
 	/* Hook up the pte_chain to the page. */
 	pte_chain->ptep = ptep;
 	pte_chain->next = page->pte_chain;
 	page->pte_chain = pte_chain;
 
-	pte_chain_unlock(page);
+	spin_unlock(rmap_lock);
+}
+
+void add_rmap_nolock(struct page* page, pte_t *ptep, struct pte_chain *pte_chain)
+{
+#ifdef DEBUG_RMAP
+	if (!page || !ptep)
+		BUG();
+	if (!pte_present(*ptep))
+		BUG();
+	if (!ptep_to_mm(ptep));
+		BUG();
+#endif
+
+	if (!VALID_PAGE(page) || PageReserved(page))
+		return;
+
+#ifdef DEBUG_RMAP
+	{
+		struct pte_chain * pc;
+		for (pc = page->pte_chain; pc; pc = pc->next) {
+			if (pc->ptep == ptep)
+				BUG();
+		}
+	}
+#endif
+
+	/* Hook up the pte_chain to the page. */
+	pte_chain->ptep = ptep;
+	pte_chain->next = page->pte_chain;
+	page->pte_chain = pte_chain;
 }
 
 /**
@@ -140,6 +174,7 @@
 {
 	struct pte_chain * pc, * prev_pc = NULL;
 	zone_t *zone;
+	spinlock_t *rmap_lock;
 
 	if (!page || !ptep)
 		BUG();
@@ -148,7 +183,7 @@
 
 	zone = page_zone(page);
 
-	pte_chain_lock(page);
+	rmap_lock = lock_rmap(page);
 	for (pc = page->pte_chain; pc; prev_pc = pc, pc = pc->next) {
 		if (pc->ptep == ptep) {
 			pte_chain_free(pc, prev_pc, page, zone);
@@ -166,7 +201,7 @@
 #endif
 
 out:
-	pte_chain_unlock(page);
+	spin_unlock(rmap_lock);
 	return;
 			
 }
@@ -335,8 +370,7 @@
  ** functions.
  **/
 
-static inline void pte_chain_push(zone_t * zone,
-		struct pte_chain * pte_chain)
+void pte_chain_push(zone_t *zone, struct pte_chain *pte_chain)
 {
 	pte_chain->ptep = NULL;
 	pte_chain->next = zone->pte_chain_freelist;
@@ -388,7 +422,7 @@
  * pte_chain structures as required.
  * Caller needs to hold the page's pte_chain_lock.
  */
-static inline struct pte_chain * pte_chain_alloc(zone_t * zone)
+struct pte_chain *pte_chain_alloc(zone_t *zone)
 {
 	struct pte_chain * pte_chain;
 
--- 2.4.19-pre7.clean/mm/swap.c	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/mm/swap.c	Fri Aug  2 17:35:47 2002
@@ -78,6 +78,8 @@
  */
 void drop_page(struct page * page)
 {
+	spinlock_t *rmap_lock;
+
 	if (!TryLockPage(page)) {
 		if (page->mapping && page->buffers) {
 			page_cache_get(page);
@@ -90,7 +92,7 @@
 	}
 
 	/* Make sure the page really is reclaimable. */
-	pte_chain_lock(page);
+	rmap_lock = lock_rmap(page);
 	if (!page->mapping || PageDirty(page) || page->pte_chain ||
 			page->buffers || page_count(page) > 1)
 		deactivate_page_nolock(page);
@@ -106,7 +108,7 @@
 			add_page_to_inactive_clean_list(page);
 		}
 	}
-	pte_chain_unlock(page);
+	spin_unlock(rmap_lock);
 }
 
 /*
--- 2.4.19-pre7.clean/mm/vmscan.c	Wed Jul 31 00:38:09 2002
+++ 2.4.19-pre7/mm/vmscan.c	Fri Aug  2 17:33:46 2002
@@ -81,6 +81,7 @@
 	struct list_head * page_lru;
 	swp_entry_t entry = {0};
 	int maxscan;
+	spinlock_t *rmap_lock;
 
 	/*
 	 * We need to hold the pagecache_lock around all tests to make sure
@@ -109,13 +110,13 @@
 		}
 
 		/* Page cannot be reclaimed ?  Move to inactive_dirty list. */
-		pte_chain_lock(page);
+		rmap_lock = lock_rmap(page);
 		if (unlikely(page->pte_chain || page->buffers ||
 				PageReferenced(page) || PageDirty(page) ||
 				page_count(page) > 1 || TryLockPage(page))) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_inactive_dirty_list(page);
-			pte_chain_unlock(page);
+			spin_unlock(rmap_lock);
 			continue;
 		}
 
@@ -140,7 +141,7 @@
 		printk(KERN_ERR "VM: reclaim_page, found unknown page\n");
 		list_del(page_lru);
 		zone->inactive_clean_pages--;
-		pte_chain_unlock(page);
+		spin_unlock(rmap_lock);
 		UnlockPage(page);
 	}
 	spin_unlock(&pagecache_lock);
@@ -150,7 +151,7 @@
 
 found_page:
 	__lru_cache_del(page);
-	pte_chain_unlock(page);
+	spin_unlock(rmap_lock);
 	spin_unlock(&pagecache_lock);
 	spin_unlock(&pagemap_lru_lock);
 	if (entry.val)
@@ -213,6 +214,7 @@
 {
 	int maxscan, cleaned_pages, target;
 	struct list_head * entry;
+	spinlock_t *rmap_lock;
 
 	target = free_plenty(zone);
 	cleaned_pages = 0;
@@ -268,17 +270,17 @@
 		 * The page is in active use or really unfreeable. Move to
 		 * the active list and adjust the page age if needed.
 		 */
-		pte_chain_lock(page);
+		rmap_lock = lock_rmap(page);
 		if (page_referenced(page) && page_mapping_inuse(page) &&
 				!page_over_rsslimit(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
 			page->age = max((int)page->age, PAGE_AGE_START);
-			pte_chain_unlock(page);
+			spin_unlock(rmap_lock);
 			UnlockPage(page);
 			continue;
 		}
-		pte_chain_unlock(page);
+		spin_unlock(rmap_lock);
 
 		/*
 		 * Anonymous process memory without backing store. Try to
@@ -286,10 +288,10 @@
 		 *
 		 * XXX: implement swap clustering ?
 		 */
-		pte_chain_lock(page);
+		rmap_lock = lock_rmap(page);
 		if (page->pte_chain && !page->mapping && !page->buffers) {
 			page_cache_get(page);
-			pte_chain_unlock(page);
+			spin_unlock(rmap_lock);
 			spin_unlock(&pagemap_lru_lock);
 			if (!add_to_swap(page)) {
 				activate_page(page);
@@ -300,7 +302,7 @@
 			}
 			page_cache_release(page);
 			spin_lock(&pagemap_lru_lock);
-			pte_chain_lock(page);
+			rmap_lock = lock_rmap(page);
 		}
 
 		/*
@@ -313,14 +315,14 @@
 				case SWAP_FAIL:
 					goto page_active;
 				case SWAP_AGAIN:
-					pte_chain_unlock(page);
+					spin_unlock(rmap_lock);
 					UnlockPage(page);
 					continue;
 				case SWAP_SUCCESS:
 					; /* try to free the page below */
 			}
 		}
-		pte_chain_unlock(page);
+		spin_unlock(rmap_lock);
 
 		if (PageDirty(page) && page->mapping) {
 			/*
@@ -407,12 +409,12 @@
 		 * This test is not safe from races, but only the one
 		 * in reclaim_page() needs to be.
 		 */
-		pte_chain_lock(page);
+		rmap_lock = lock_rmap(page);
 		if (page->mapping && !PageDirty(page) && !page->pte_chain &&
 				page_count(page) == 1) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_inactive_clean_list(page);
-			pte_chain_unlock(page);
+			spin_unlock(rmap_lock);
 			UnlockPage(page);
 			cleaned_pages++;
 		} else {
@@ -424,7 +426,7 @@
 page_active:
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
-			pte_chain_unlock(page);
+			spin_unlock(rmap_lock);
 			UnlockPage(page);
 		}
 	}
@@ -476,6 +478,7 @@
 	struct list_head * page_lru;
 	int nr_deactivated = 0;
 	struct page * page;
+	spinlock_t *rmap_lock;
 
 	/* Take the lock while messing with the list... */
 	spin_lock(&pagemap_lru_lock);
@@ -505,9 +508,9 @@
 		 * From here until the end of the current iteration
 		 * both PG_locked and the pte_chain_lock are held.
 		 */
-		pte_chain_lock(page);
+		rmap_lock = lock_rmap(page);
 		if (!page_mapping_inuse(page)) {
-			pte_chain_unlock(page);
+			spin_unlock(rmap_lock);
 			UnlockPage(page);
 			drop_page(page);
 			continue;
@@ -533,12 +536,12 @@
 		} else {
 			deactivate_page_nolock(page);
 			if (++nr_deactivated > target) {
-				pte_chain_unlock(page);
+				spin_unlock(rmap_lock);
 				UnlockPage(page);
 				goto done;
 			}
 		}
-		pte_chain_unlock(page);
+		spin_unlock(rmap_lock);
 		UnlockPage(page);
 
 		/* Low latency reschedule point */
