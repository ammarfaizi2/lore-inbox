Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292482AbSCDSF3>; Mon, 4 Mar 2002 13:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292533AbSCDSFL>; Mon, 4 Mar 2002 13:05:11 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:33756 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292482AbSCDSE7>; Mon, 4 Mar 2002 13:04:59 -0500
Date: Mon, 04 Mar 2002 10:04:51 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech@lists.sourceforge.net
Subject: [PATCH] breaking up the pagemap_lru_lock in rmap
Message-ID: <194860000.1015265091@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

High contention on the pagemap_lru lock seems to be a major
scalability problem for rmap at the moment. Based on wli's and
Rik's suggestions, I've made a first cut at a patch to split up the
lock into a per-page lock for each pte_chain.

This isn't ready to go yet - I'm not going to pretend it works. I'm
looking for feedback on the approach, and any obvious blunders
I've made in coding. I plan to move the lock in the pages_struct
into the flags field to save space once it's working reliably.

If I may steal akpm's favourite disclaimer - "I know diddly squat
about ......" ;-) Flame away .....

Thanks,

Martin.

diff -urN linux-2.4.17-rmap/include/linux/mm.h linux-2.4.17-rmap-mjb/include/linux/mm.h
--- linux-2.4.17-rmap/include/linux/mm.h	Thu Feb 14 17:53:17 2002
+++ linux-2.4.17-rmap-mjb/include/linux/mm.h	Tue Feb 26 10:34:23 2002
@@ -160,6 +160,7 @@
 					   protected by pagemap_lru_lock !! */
 	unsigned char age;		/* Page aging counter. */
 	unsigned char zone;		/* Memory zone the page belongs to. */
+	spinlock_t pte_chain_lock;
 	struct pte_chain * pte_chain;	/* Reverse pte mapping pointer. */
 	struct page **pprev_hash;	/* Complement to *next_hash. */
 	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
diff -urN linux-2.4.17-rmap/mm/filemap.c linux-2.4.17-rmap-mjb/mm/filemap.c
--- linux-2.4.17-rmap/mm/filemap.c	Thu Feb 14 17:53:17 2002
+++ linux-2.4.17-rmap-mjb/mm/filemap.c	Fri Feb 15 17:23:36 2002
@@ -235,8 +235,13 @@
 static void truncate_complete_page(struct page *page)
 {
 	/* Leave it on the LRU if it gets converted into anonymous buffers */
-	if (!page->pte_chain && (!page->buffers || do_flushpage(page, 0)))
+	pte_chain_lock(page);
+	if (!page->pte_chain && (!page->buffers || do_flushpage(page, 0))) {
+		pte_chain_unlock(page);
 		lru_cache_del(page);
+	} else {
+		pte_chain_unlock(page);
+	}
 
 	/*
 	 * We remove the page from the page cache _after_ we have
diff -urN linux-2.4.17-rmap/mm/page_alloc.c linux-2.4.17-rmap-mjb/mm/page_alloc.c
--- linux-2.4.17-rmap/mm/page_alloc.c	Thu Feb 14 17:53:17 2002
+++ linux-2.4.17-rmap-mjb/mm/page_alloc.c	Tue Feb 26 10:58:42 2002
@@ -127,8 +127,10 @@
 		BUG();
 	if (PageInactiveClean(page))
 		BUG();
+	pte_chain_lock(page);
 	if (page->pte_chain)
 		BUG();
+	pte_chain_unlock(page);
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
 	page->age = PAGE_AGE_START;
 	
@@ -989,6 +991,7 @@
 			struct page *page = mem_map + offset + i;
 			set_page_zone(page, pgdat->node_id * MAX_NR_ZONES + j);
 			init_page_count(page);
+			page->pte_chain_lock = SPIN_LOCK_UNLOCKED;
 			__SetPageReserved(page);
 			memlist_init(&page->list);
 			if (j != ZONE_HIGHMEM)
diff -urN linux-2.4.17-rmap/mm/rmap.c linux-2.4.17-rmap-mjb/mm/rmap.c
--- linux-2.4.17-rmap/mm/rmap.c	Thu Feb 14 17:53:17 2002
+++ linux-2.4.17-rmap-mjb/mm/rmap.c	Tue Feb 26 16:50:55 2002
@@ -13,9 +13,8 @@
 
 /*
  * Locking:
- * - the page->pte_chain is protected by the pagemap_lru_lock,
- *   we probably want to change this to a per-page lock in the
- *   future
+ * - the page->pte_chain is protected by a per-page lock.
+ *
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
  *   on the mm->page_table_lock
@@ -53,13 +52,25 @@
 static inline void pte_chain_free(struct pte_chain *, struct pte_chain *, struct page *);
 static void alloc_new_pte_chains(void);
 
+/* lock the pte_chain for this page */
+inline void pte_chain_lock(struct page *page)
+{
+        spin_lock(&page->pte_chain_lock);
+}
+
+/* unlock the pte_chain for this page */
+inline void pte_chain_unlock(struct page *page)
+{
+        spin_unlock(&page->pte_chain_lock);
+}
+
 /**
  * page_referenced - test if the page was referenced
  * @page: the page to test
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
- * Caller needs to hold the pagemap_lru_lock.
+ * Caller needs to hold the page's pte_chain lock.
  */
 int FASTCALL(page_referenced(struct page *));
 int page_referenced(struct page * page)
@@ -95,7 +106,7 @@
 	if (!VALID_PAGE(page) || PageReserved(page))
 		return;
 
-	spin_lock(&pagemap_lru_lock);
+	pte_chain_lock(page);
 #ifdef DEBUG_RMAP
 	if (!page || !ptep)
 		BUG();
@@ -118,7 +129,7 @@
 	pte_chain->next = page->pte_chain;
 	page->pte_chain = pte_chain;
 
-	spin_unlock(&pagemap_lru_lock);
+	pte_chain_unlock(page);
 }
 
 /**
@@ -141,7 +152,7 @@
 	if (!VALID_PAGE(page) || PageReserved(page))
 		return;
 
-	spin_lock(&pagemap_lru_lock);
+	pte_chain_lock(page);
 	for (pc = page->pte_chain; pc; prev_pc = pc, pc = pc->next) {
 		if (pc->ptep == ptep) {
 			pte_chain_free(pc, prev_pc, page);
@@ -159,9 +170,8 @@
 #endif
 
 out:
-	spin_unlock(&pagemap_lru_lock);
+	pte_chain_unlock(page);
 	return;
-			
 }
 
 /**
@@ -240,7 +250,7 @@
  * @page: the page to get unmapped
  *
  * Tries to remove all the page table entries which are mapping this
- * page, used in the pageout path.  Caller must hold pagemap_lru_lock
+ * page, used in the pageout path.  Caller must hold pte_chain_lock
  * and the page lock.  Return values are:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
@@ -294,7 +304,7 @@
  * we make the optimisation of only checking the first process
  * in the pte_chain list, this should catch hogs while not
  * evicting pages shared by many processes.
- * The caller needs to hold the pagemap_lru_lock.
+ * The caller needs to hold the page's pte_chain lock
  */
 int FASTCALL(page_over_rsslimit(struct page *));
 int page_over_rsslimit(struct page * page)
@@ -322,7 +332,7 @@
  * This function unlinks pte_chain from the singly linked list it
  * may be on and adds the pte_chain to the free list. May also be
  * called for new pte_chain structures which aren't on any list yet.
- * Caller needs to hold the pagemap_lru_list.
+ * Caller needs to hold the page's pte_chain lock if page is not NULL
  */
 static inline void pte_chain_free(struct pte_chain * pte_chain, struct pte_chain * prev_pte_chain, struct page * page)
 {
@@ -341,7 +351,7 @@
  *
  * Returns a pointer to a fresh pte_chain structure. Allocates new
  * pte_chain structures as required.
- * Caller needs to hold the pagemap_lru_lock.
+ * Caller needs to hold the page's pte_chain lock
  */
 static inline struct pte_chain * pte_chain_alloc(void)
 {
diff -urN linux-2.4.17-rmap/mm/swap.c linux-2.4.17-rmap-mjb/mm/swap.c
--- linux-2.4.17-rmap/mm/swap.c	Thu Feb 14 17:53:17 2002
+++ linux-2.4.17-rmap-mjb/mm/swap.c	Fri Feb 15 17:35:53 2002
@@ -106,12 +106,14 @@
 		UnlockPage(page);
 	}
 
+	pte_chain_lock(page);
 	/* Make sure the page really is reclaimable. */
 	if (!page->mapping || PageDirty(page) || page->pte_chain ||
 			page->buffers || page_count(page) > 1)
 		deactivate_page_nolock(page);
 
 	else if (page_count(page) == 1) {
+		pte_chain_unlock(page);
 		ClearPageReferenced(page);
 		page->age = 0;
 		if (PageActive(page)) {
@@ -121,6 +123,8 @@
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_inactive_clean_list(page);
 		}
+	} else {
+		pte_chain_unlock(page);
 	}
 }
 
diff -urN linux-2.4.17-rmap/mm/vmscan.c linux-2.4.17-rmap-mjb/mm/vmscan.c
--- linux-2.4.17-rmap/mm/vmscan.c	Thu Feb 14 17:53:17 2002
+++ linux-2.4.17-rmap-mjb/mm/vmscan.c	Fri Feb 15 17:14:30 2002
@@ -48,6 +48,7 @@
 	page->age -= min(PAGE_AGE_DECL, (int)page->age);
 }
 
+/* Must be called with the page's pte_chain lock held */
 static inline int page_mapping_inuse(struct page * page)
 {
 	struct address_space * mapping = page->mapping;
@@ -109,13 +110,16 @@
 		}
 
 		/* Page cannot be reclaimed ?  Move to inactive_dirty list. */
+		pte_chain_lock(page);
 		if (unlikely(page->pte_chain || page->buffers ||
 				PageReferenced(page) || PageDirty(page) ||
 				page_count(page) > 1 || TryLockPage(page))) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_inactive_dirty_list(page);
+			pte_chain_unlock(page);
 			continue;
 		}
+		pte_chain_unlock(page);
 
 		/* OK, remove the page from the caches. */
                 if (PageSwapCache(page)) {
@@ -239,6 +243,7 @@
 			continue;
 		}
 
+		pte_chain_lock(page);
 		/*
 		 * The page is in active use or really unfreeable. Move to
 		 * the active list and adjust the page age if needed.
@@ -248,21 +253,26 @@
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
 			page->age = max((int)page->age, PAGE_AGE_START);
+			pte_chain_unlock(page);
 			continue;
 		}
 
 		/*
 		 * Page is being freed, don't worry about it.
 		 */
-		if (unlikely(page_count(page)) == 0)
+		if (unlikely(page_count(page)) == 0) {
+			pte_chain_unlock(page);
 			continue;
+		}
 
 		/*
 		 * The page is locked. IO in progress?
 		 * Move it to the back of the list.
 		 */
-		if (unlikely(TryLockPage(page)))
+		if (unlikely(TryLockPage(page))) {
+			pte_chain_unlock(page);
 			continue;
+		}
 
 		/*
 		 * Anonymous process memory without backing store. Try to
@@ -272,6 +282,7 @@
 		 */
 		if (page->pte_chain && !page->mapping && !page->buffers) {
 			page_cache_get(page);
+			pte_chain_unlock(page);
 			spin_unlock(&pagemap_lru_lock);
 			if (!add_to_swap(page)) {
 				activate_page(page);
@@ -282,6 +293,7 @@
 			}
 			page_cache_release(page);
 			spin_lock(&pagemap_lru_lock);
+			pte_chain_lock(page);
 		}
 
 		/*
@@ -295,6 +307,7 @@
 					goto page_active;
 				case SWAP_AGAIN:
 					UnlockPage(page);
+					pte_chain_unlock(page);
 					continue;
 				case SWAP_SUCCESS:
 					; /* try to free the page below */
@@ -319,6 +332,7 @@
 				page_cache_get(page);
 				spin_unlock(&pagemap_lru_lock);
 
+				pte_chain_unlock(page);
 				writepage(page);
 				page_cache_release(page);
 
@@ -348,6 +362,7 @@
 					 */
 					spin_lock(&pagemap_lru_lock);
 					UnlockPage(page);
+					pte_chain_unlock(page);
 					__lru_cache_del(page);
 
 					/* effectively free the page here */
@@ -369,6 +384,7 @@
 			} else {
 				/* failed to drop the buffers so stop here */
 				UnlockPage(page);
+				pte_chain_unlock(page);
 				page_cache_release(page);
 
 				spin_lock(&pagemap_lru_lock);
@@ -403,6 +419,7 @@
 			add_page_to_active_list(page);
 			UnlockPage(page);
 		}
+		pte_chain_unlock(page);
 	}
 	spin_unlock(&pagemap_lru_lock);
 
@@ -473,7 +490,9 @@
 		 * bother with page aging.  If the page is touched again
 		 * while on the inactive_clean list it'll be reactivated.
 		 */
+		pte_chain_lock(page);
 		if (!page_mapping_inuse(page)) {
+			pte_chain_unlock(page);
 			drop_page(page);
 			continue;
 		}
@@ -497,9 +516,12 @@
 			list_add(page_lru, &zone->active_list);
 		} else {
 			deactivate_page_nolock(page);
-			if (++nr_deactivated > target)
+			if (++nr_deactivated > target) {
+				pte_chain_unlock(page);
 				break;
+			}
 		}
+		pte_chain_unlock(page);
 
 		/* Low latency reschedule point */
 		if (current->need_resched) {

