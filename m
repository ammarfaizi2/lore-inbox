Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314478AbSDRWKi>; Thu, 18 Apr 2002 18:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314479AbSDRWKh>; Thu, 18 Apr 2002 18:10:37 -0400
Received: from holomorphy.com ([66.224.33.161]:14239 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314478AbSDRWKd>;
	Thu, 18 Apr 2002 18:10:33 -0400
Date: Thu, 18 Apr 2002 15:09:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: riel@surriel.com
Subject: [PATCH] per-page pte_chain locking
Message-ID: <20020418220944.GY21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically the same patch as before with a correction to some
code in page_add_rmap() under a #ifdef DEBUG_RMAP (whose bug I
introduced myself).

riel, please apply.


Cheers,
Bill


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.404   -> 1.406  
#	           mm/rmap.c	1.3     -> 1.5    
#	  include/linux/mm.h	1.39    -> 1.40   
#	         mm/vmscan.c	1.61    -> 1.62   
#	        mm/filemap.c	1.66    -> 1.67   
#	           mm/swap.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/17	wli@elm3b52.eng.beaverton.ibm.com	1.405
# mm.h:
#   Add pte_chain's lock bit and locking routines to the list of page flag accessor declarations.
# vmscan.c:
#   Protect accesses to page->pte_chain with the pte_chain_lock
# rmap.c:
#   Convert reverse-mapping helper routines to using per-page pte_chain locks, with comment updates.
# swap.c:
#   Protect against concurrent modification of page->pte_chain in drop_page()
# filemap.c:
#   truncate_complete_page() requires eliminating all references arising from ->pte_chain; if it is non-NULL, BUG()
# --------------------------------------------
# 02/04/18	wli@holomorphy.com	1.406
# rmap.c:
#   Repair the DEBUG_RMAP code in page_add_rmap() so it doesn't deadlock.
# --------------------------------------------
#
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Thu Apr 18 08:17:26 2002
+++ b/include/linux/mm.h	Thu Apr 18 08:17:26 2002
@@ -299,6 +299,7 @@
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
+#define PG_chainlock		16	/* lock bit for ->pte_chain */
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)
@@ -315,6 +316,20 @@
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
+
+/*
+ * inlines for acquisition and release of PG_chainlock
+ */
+static inline void pte_chain_lock(struct page *page)
+{
+	while (test_and_set_bit(PG_chainlock, &page->flags))
+		cpu_relax();
+}
+
+static inline void pte_chain_unlock(struct page *page)
+{
+	clear_bit(PG_chainlock, &page->flags);
+}
 
 /*
  * The zone field is never updated after free_area_init_core()
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Thu Apr 18 08:17:26 2002
+++ b/mm/filemap.c	Thu Apr 18 08:17:26 2002
@@ -233,8 +233,14 @@
 
 static void truncate_complete_page(struct page *page)
 {
-	/* Leave it on the LRU if it gets converted into anonymous buffers */
-	if (!page->pte_chain && (!page->buffers || do_flushpage(page, 0)))
+	/*
+	 * Leave it on the LRU if it gets converted into anonymous buffers
+	 * It is furthermore assumed that no process has mapped this page.
+	 */
+	if (page->pte_chain)
+		BUG();
+
+	if (!page->buffers || do_flushpage(page, 0))
 		lru_cache_del(page);
 
 	/*
diff -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	Thu Apr 18 08:17:26 2002
+++ b/mm/rmap.c	Thu Apr 18 08:17:26 2002
@@ -13,9 +13,9 @@
 
 /*
  * Locking:
- * - the page->pte_chain is protected by the pagemap_lru_lock,
- *   we probably want to change this to a per-page lock in the
- *   future
+ * - the page->pte_chain is protected by the PG_chainlock bit,
+ *   which nests within the pagemap_lru_lock, then the
+ *   mm->page_table_lock, and then the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
  *   on the mm->page_table_lock
@@ -59,7 +59,7 @@
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
- * Caller needs to hold the pagemap_lru_lock.
+ * Caller needs to hold the pte_chain_lock.
  */
 int FASTCALL(page_referenced(struct page *));
 int page_referenced(struct page * page)
@@ -91,14 +91,7 @@
 void page_add_rmap(struct page * page, pte_t * ptep)
 {
 	struct pte_chain * pte_chain;
-	zone_t *zone;
-
-	if (!VALID_PAGE(page) || PageReserved(page))
-		return;
 
-	zone = page_zone(page);
-
-	spin_lock(&pagemap_lru_lock);
 #ifdef DEBUG_RMAP
 	if (!page || !ptep)
 		BUG();
@@ -106,6 +99,10 @@
 		BUG();
 	if (!ptep_to_mm(ptep));
 		BUG();
+	if (!VALID_PAGE(page) || PageReserved(page))
+		return;
+
+	pte_chain_lock(page);
 	{
 		struct pte_chain * pc;
 		for (pc = page->pte_chain; pc; pc = pc->next) {
@@ -113,15 +110,22 @@
 				BUG();
 		}
 	}
+	pte_chain_unlock(page);
 #endif
-	pte_chain = pte_chain_alloc(zone);
+
+	if (!VALID_PAGE(page) || PageReserved(page))
+		return;
+
+	pte_chain = pte_chain_alloc(page_zone(page));
+
+	pte_chain_lock(page);
 
 	/* Hook up the pte_chain to the page. */
 	pte_chain->ptep = ptep;
 	pte_chain->next = page->pte_chain;
 	page->pte_chain = pte_chain;
 
-	spin_unlock(&pagemap_lru_lock);
+	pte_chain_unlock(page);
 }
 
 /**
@@ -147,7 +151,7 @@
 
 	zone = page_zone(page);
 
-	spin_lock(&pagemap_lru_lock);
+	pte_chain_lock(page);
 	for (pc = page->pte_chain; pc; prev_pc = pc, pc = pc->next) {
 		if (pc->ptep == ptep) {
 			pte_chain_free(pc, prev_pc, page, zone);
@@ -165,7 +169,7 @@
 #endif
 
 out:
-	spin_unlock(&pagemap_lru_lock);
+	pte_chain_unlock(page);
 	return;
 			
 }
@@ -181,7 +185,8 @@
  * Locking:
  *	pagemap_lru_lock		page_launder()
  *	    page lock			page_launder(), trylock
- *		mm->page_table_lock	try_to_unmap_one(), trylock
+ *		pte_chain_lock		page_launder()
+ *		    mm->page_table_lock	try_to_unmap_one(), trylock
  */
 int FASTCALL(try_to_unmap_one(struct page *, pte_t *));
 int try_to_unmap_one(struct page * page, pte_t * ptep)
@@ -300,7 +305,7 @@
  * is over its RSS (resident set size) limit.  For shared pages
  * we penalise it only if all processes using it are over their
  * rss limits.
- * The caller needs to hold the pagemap_lru_lock.
+ * The caller needs to hold the page's pte_chain_lock.
  */
 int FASTCALL(page_over_rsslimit(struct page *));
 int page_over_rsslimit(struct page * page)
@@ -364,6 +369,7 @@
  * This function unlinks pte_chain from the singly linked list it
  * may be on and adds the pte_chain to the free list. May also be
  * called for new pte_chain structures which aren't on any list yet.
+ * Caller needs to hold the pte_chain_lock if the page is non-NULL.
  */
 static inline void pte_chain_free(struct pte_chain * pte_chain,
 		struct pte_chain * prev_pte_chain, struct page * page,
@@ -385,6 +391,7 @@
  *
  * Returns a pointer to a fresh pte_chain structure. Allocates new
  * pte_chain structures as required.
+ * Caller needs to hold the page's pte_chain_lock.
  */
 static inline struct pte_chain * pte_chain_alloc(zone_t * zone)
 {
diff -Nru a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c	Thu Apr 18 08:17:26 2002
+++ b/mm/swap.c	Thu Apr 18 08:17:26 2002
@@ -104,6 +104,7 @@
 	}
 
 	/* Make sure the page really is reclaimable. */
+	pte_chain_lock(page);
 	if (!page->mapping || PageDirty(page) || page->pte_chain ||
 			page->buffers || page_count(page) > 1)
 		deactivate_page_nolock(page);
@@ -119,6 +120,7 @@
 			add_page_to_inactive_clean_list(page);
 		}
 	}
+	pte_chain_unlock(page);
 }
 
 /*
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu Apr 18 08:17:26 2002
+++ b/mm/vmscan.c	Thu Apr 18 08:17:26 2002
@@ -47,6 +47,7 @@
 	page->age -= min(PAGE_AGE_DECL, (int)page->age);
 }
 
+/* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page * page)
 {
 	struct address_space * mapping = page->mapping;
@@ -108,14 +109,21 @@
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
 
+		/*
+		 * From here until reaching either the bottom of the loop
+		 * or found_page: the pte_chain_lock is held.
+		 */
+
 		/* OK, remove the page from the caches. */
                 if (PageSwapCache(page)) {
 			entry.val = page->index;
@@ -132,6 +140,7 @@
 		printk(KERN_ERR "VM: reclaim_page, found unknown page\n");
 		list_del(page_lru);
 		zone->inactive_clean_pages--;
+		pte_chain_unlock(page);
 		UnlockPage(page);
 	}
 	spin_unlock(&pagecache_lock);
@@ -141,6 +150,7 @@
 
 found_page:
 	del_page_from_inactive_clean_list(page);
+	pte_chain_unlock(page);
 	spin_unlock(&pagecache_lock);
 	spin_unlock(&pagemap_lru_lock);
 	if (entry.val)
@@ -243,13 +253,16 @@
 		 * The page is in active use or really unfreeable. Move to
 		 * the active list and adjust the page age if needed.
 		 */
+		pte_chain_lock(page);
 		if (page_referenced(page) && page_mapping_inuse(page) &&
 				!page_over_rsslimit(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
 			page->age = max((int)page->age, PAGE_AGE_START);
+			pte_chain_unlock(page);
 			continue;
 		}
+		pte_chain_unlock(page);
 
 		/*
 		 * Page is being freed, don't worry about it.
@@ -270,8 +283,10 @@
 		 *
 		 * XXX: implement swap clustering ?
 		 */
+		pte_chain_lock(page);
 		if (page->pte_chain && !page->mapping && !page->buffers) {
 			page_cache_get(page);
+			pte_chain_unlock(page);
 			spin_unlock(&pagemap_lru_lock);
 			if (!add_to_swap(page)) {
 				activate_page(page);
@@ -282,24 +297,28 @@
 			}
 			page_cache_release(page);
 			spin_lock(&pagemap_lru_lock);
-		}
+		} else
+			pte_chain_unlock(page);
 
 		/*
 		 * The page is mapped into the page tables of one or more
 		 * processes. Try to unmap it here.
 		 */
+		pte_chain_lock(page);
 		if (page->pte_chain) {
 			switch (try_to_unmap(page)) {
 				case SWAP_ERROR:
 				case SWAP_FAIL:
 					goto page_active;
 				case SWAP_AGAIN:
+					pte_chain_unlock(page);
 					UnlockPage(page);
 					continue;
 				case SWAP_SUCCESS:
 					; /* try to free the page below */
 			}
 		}
+		pte_chain_unlock(page);
 
 		if (PageDirty(page) && page->mapping) {
 			/*
@@ -386,10 +405,12 @@
 		 * This test is not safe from races, but only the one
 		 * in reclaim_page() needs to be.
 		 */
+		pte_chain_lock(page);
 		if (page->mapping && !PageDirty(page) && !page->pte_chain &&
 				page_count(page) == 1) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_inactive_clean_list(page);
+			pte_chain_unlock(page);
 			UnlockPage(page);
 			cleaned_pages++;
 		} else {
@@ -401,6 +422,7 @@
 page_active:
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
+			pte_chain_unlock(page);
 			UnlockPage(page);
 		}
 	}
@@ -471,8 +493,12 @@
 		 * If the object the page is in is not in use we don't
 		 * bother with page aging.  If the page is touched again
 		 * while on the inactive_clean list it'll be reactivated.
+		 * From here until the end of the current iteration
+		 * the pte_chain_lock is held.
 		 */
+		pte_chain_lock(page);
 		if (!page_mapping_inuse(page)) {
+			pte_chain_unlock(page);
 			drop_page(page);
 			continue;
 		}
@@ -496,9 +522,12 @@
 			list_add(page_lru, &zone->active_list);
 		} else {
 			deactivate_page_nolock(page);
-			if (++nr_deactivated > target)
-				break;
+			if (++nr_deactivated > target) {
+				pte_chain_unlock(page);
+				goto done;
+			}
 		}
+		pte_chain_unlock(page);
 
 		/* Low latency reschedule point */
 		if (current->need_resched) {
@@ -507,6 +536,8 @@
 			spin_lock(&pagemap_lru_lock);
 		}
 	}
+
+done:
 	spin_unlock(&pagemap_lru_lock);
 
 	return nr_deactivated;
