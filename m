Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318224AbSGQFUC>; Wed, 17 Jul 2002 01:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSGQFS4>; Wed, 17 Jul 2002 01:18:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13068 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318211AbSGQFSr>;
	Wed, 17 Jul 2002 01:18:47 -0400
Message-ID: <3D3500BD.1B9347E1@zip.com.au>
Date: Tue, 16 Jul 2002 22:29:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/13] avoid allocating pte_chains for unshared pages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch from David McCracken.  It is an optimisation to the rmap
pte_chains.

In the common case where a page is mapped by only a single pte, we
don't need to allocate a pte_chain structure.  Just make the page's
pte_chain pointer point straight at that pte and flag this with
PG_direct.


 include/linux/mm.h         |    5 +
 include/linux/page-flags.h |   12 +++-
 mm/page_alloc.c            |    2 
 mm/rmap.c                  |  128 ++++++++++++++++++++++++++++++++-------------
 mm/vmscan.c                |    8 +-
 5 files changed, 112 insertions(+), 43 deletions(-)

--- 2.5.26/include/linux/mm.h~rmap-opt	Tue Jul 16 21:46:29 2002
+++ 2.5.26-akpm/include/linux/mm.h	Tue Jul 16 21:59:38 2002
@@ -157,8 +157,11 @@ struct page {
 					   updated asynchronously */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by pagemap_lru_lock !! */
-	struct pte_chain * pte_chain;	/* Reverse pte mapping pointer.
+	union {
+		struct pte_chain * chain;	/* Reverse pte mapping pointer.
 					 * protected by PG_chainlock */
+		pte_t		 * direct;
+	} pte;
 	unsigned long private;		/* mapping-private opaque data */
 
 	/*
--- 2.5.26/include/linux/page-flags.h~rmap-opt	Tue Jul 16 21:46:29 2002
+++ 2.5.26-akpm/include/linux/page-flags.h	Tue Jul 16 21:59:40 2002
@@ -64,8 +64,10 @@
 
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
-#define PG_nosave		15	/* Used for system suspend/resume */
-#define PG_chainlock		16	/* lock bit for ->pte_chain */
+#define PG_nosave		14	/* Used for system suspend/resume */
+#define PG_chainlock		15	/* lock bit for ->pte_chain */
+
+#define PG_direct		16	/* ->pte_chain points directly at pte */
 
 /*
  * Global page accounting.  One instance per CPU.
@@ -217,6 +219,12 @@ extern void get_page_state(struct page_s
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
+#define PageDirect(page)	test_bit(PG_direct, &(page)->flags)
+#define SetPageDirect(page)	set_bit(PG_direct, &(page)->flags)
+#define TestSetPageDirect(page)	test_and_set_bit(PG_direct, &(page)->flags)
+#define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
+#define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
+
 /*
  * inlines for acquisition and release of PG_chainlock
  */
--- 2.5.26/mm/page_alloc.c~rmap-opt	Tue Jul 16 21:46:29 2002
+++ 2.5.26-akpm/mm/page_alloc.c	Tue Jul 16 21:59:40 2002
@@ -92,7 +92,7 @@ static void __free_pages_ok (struct page
 	BUG_ON(PageLRU(page));
 	BUG_ON(PageActive(page));
 	BUG_ON(PageWriteback(page));
-	BUG_ON(page->pte_chain != NULL);
+	BUG_ON(page->pte.chain != NULL);
 	if (PageDirty(page))
 		ClearPageDirty(page);
 	BUG_ON(page_count(page) != 0);
--- 2.5.26/mm/rmap.c~rmap-opt	Tue Jul 16 21:46:29 2002
+++ 2.5.26-akpm/mm/rmap.c	Tue Jul 16 21:59:40 2002
@@ -13,7 +13,7 @@
 
 /*
  * Locking:
- * - the page->pte_chain is protected by the PG_chainlock bit,
+ * - the page->pte.chain is protected by the PG_chainlock bit,
  *   which nests within the pagemap_lru_lock, then the
  *   mm->page_table_lock, and then the page lock.
  * - because swapout locking is opposite to the locking order
@@ -71,10 +71,15 @@ int page_referenced(struct page * page)
 	if (TestClearPageReferenced(page))
 		referenced++;
 
-	/* Check all the page tables mapping this page. */
-	for (pc = page->pte_chain; pc; pc = pc->next) {
-		if (ptep_test_and_clear_young(pc->ptep))
+	if (PageDirect(page)) {
+		if (ptep_test_and_clear_young(page->pte.direct))
 			referenced++;
+	} else {
+		/* Check all the page tables mapping this page. */
+		for (pc = page->pte.chain; pc; pc = pc->next) {
+			if (ptep_test_and_clear_young(pc->ptep))
+				referenced++;
+		}
 	}
 	return referenced;
 }
@@ -108,22 +113,39 @@ void page_add_rmap(struct page * page, p
 	pte_chain_lock(page);
 	{
 		struct pte_chain * pc;
-		for (pc = page->pte_chain; pc; pc = pc->next) {
-			if (pc->ptep == ptep)
+		if (PageDirect(page)) {
+			if (page->pte.direct == ptep)
 				BUG();
+		} else {
+			for (pc = page->pte.chain; pc; pc = pc->next) {
+				if (pc->ptep == ptep)
+					BUG();
+			}
 		}
 	}
 	pte_chain_unlock(page);
 #endif
 
-	pte_chain = pte_chain_alloc();
-
 	pte_chain_lock(page);
 
-	/* Hook up the pte_chain to the page. */
-	pte_chain->ptep = ptep;
-	pte_chain->next = page->pte_chain;
-	page->pte_chain = pte_chain;
+	if (PageDirect(page)) {
+		/* Convert a direct pointer into a pte_chain */
+		pte_chain = pte_chain_alloc();
+		pte_chain->ptep = page->pte.direct;
+		pte_chain->next = NULL;
+		page->pte.chain = pte_chain;
+		ClearPageDirect(page);
+	}
+	if (page->pte.chain) {
+		/* Hook up the pte_chain to the page. */
+		pte_chain = pte_chain_alloc();
+		pte_chain->ptep = ptep;
+		pte_chain->next = page->pte.chain;
+		page->pte.chain = pte_chain;
+	} else {
+		page->pte.direct = ptep;
+		SetPageDirect(page);
+	}
 
 	pte_chain_unlock(page);
 }
@@ -149,18 +171,38 @@ void page_remove_rmap(struct page * page
 		return;
 
 	pte_chain_lock(page);
-	for (pc = page->pte_chain; pc; prev_pc = pc, pc = pc->next) {
-		if (pc->ptep == ptep) {
-			pte_chain_free(pc, prev_pc, page);
+
+	if (PageDirect(page)) {
+		if (page->pte.direct == ptep) {
+			page->pte.direct = NULL;
+			ClearPageDirect(page);
 			goto out;
 		}
+	} else {
+		for (pc = page->pte.chain; pc; prev_pc = pc, pc = pc->next) {
+			if (pc->ptep == ptep) {
+				pte_chain_free(pc, prev_pc, page);
+				/* Check whether we can convert to direct */
+				pc = page->pte.chain;
+				if (!pc->next) {
+					page->pte.direct = pc->ptep;
+					SetPageDirect(page);
+					pte_chain_free(pc, NULL, NULL);
+				}
+				goto out;
+			}
+		}
 	}
 #ifdef DEBUG_RMAP
 	/* Not found. This should NEVER happen! */
 	printk(KERN_ERR "page_remove_rmap: pte_chain %p not present.\n", ptep);
 	printk(KERN_ERR "page_remove_rmap: only found: ");
-	for (pc = page->pte_chain; pc; pc = pc->next)
-		printk("%p ", pc->ptep);
+	if (PageDirect(page)) {
+		printk("%p ", page->pte.direct);
+	} else {
+		for (pc = page->pte.chain; pc; pc = pc->next)
+			printk("%p ", pc->ptep);
+	}
 	printk("\n");
 	printk(KERN_ERR "page_remove_rmap: driver cleared PG_reserved ?\n");
 #endif
@@ -270,25 +312,41 @@ int try_to_unmap(struct page * page)
 	if (!page->mapping)
 		BUG();
 
-	for (pc = page->pte_chain; pc; pc = next_pc) {
-		next_pc = pc->next;
-		switch (try_to_unmap_one(page, pc->ptep)) {
-			case SWAP_SUCCESS:
-				/* Free the pte_chain struct. */
-				pte_chain_free(pc, prev_pc, page);
-				break;
-			case SWAP_AGAIN:
-				/* Skip this pte, remembering status. */
-				prev_pc = pc;
-				ret = SWAP_AGAIN;
-				continue;
-			case SWAP_FAIL:
-				return SWAP_FAIL;
-			case SWAP_ERROR:
-				return SWAP_ERROR;
+	if (PageDirect(page)) {
+		ret = try_to_unmap_one(page, page->pte.direct);
+		if (ret == SWAP_SUCCESS) {
+			page->pte.direct = NULL;
+			ClearPageDirect(page);
+		}
+	} else {		
+		for (pc = page->pte.chain; pc; pc = next_pc) {
+			next_pc = pc->next;
+			switch (try_to_unmap_one(page, pc->ptep)) {
+				case SWAP_SUCCESS:
+					/* Free the pte_chain struct. */
+					pte_chain_free(pc, prev_pc, page);
+					break;
+				case SWAP_AGAIN:
+					/* Skip this pte, remembering status. */
+					prev_pc = pc;
+					ret = SWAP_AGAIN;
+					continue;
+				case SWAP_FAIL:
+					ret = SWAP_FAIL;
+					break;
+				case SWAP_ERROR:
+					ret = SWAP_ERROR;
+					break;
+			}
+		}
+		/* Check whether we can convert to direct pte pointer */
+		pc = page->pte.chain;
+		if (pc && !pc->next) {
+			page->pte.direct = pc->ptep;
+			SetPageDirect(page);
+			pte_chain_free(pc, NULL, NULL);
 		}
 	}
-
 	return ret;
 }
 
@@ -336,7 +394,7 @@ static inline void pte_chain_free(struct
 	if (prev_pte_chain)
 		prev_pte_chain->next = pte_chain->next;
 	else if (page)
-		page->pte_chain = pte_chain->next;
+		page->pte.chain = pte_chain->next;
 
 	spin_lock(&pte_chain_freelist_lock);
 	pte_chain_push(pte_chain);
--- 2.5.26/mm/vmscan.c~rmap-opt	Tue Jul 16 21:46:29 2002
+++ 2.5.26-akpm/mm/vmscan.c	Tue Jul 16 21:59:40 2002
@@ -48,7 +48,7 @@ static inline int page_mapping_inuse(str
 	struct address_space *mapping = page->mapping;
 
 	/* Page is in somebody's page tables. */
-	if (page->pte_chain)
+	if (page->pte.chain)
 		return 1;
 
 	/* XXX: does this happen ? */
@@ -151,7 +151,7 @@ shrink_cache(int nr_pages, zone_t *class
 		 *
 		 * XXX: implement swap clustering ?
 		 */
-		if (page->pte_chain && !page->mapping && !PagePrivate(page)) {
+		if (page->pte.chain && !page->mapping && !PagePrivate(page)) {
 			page_cache_get(page);
 			pte_chain_unlock(page);
 			spin_unlock(&pagemap_lru_lock);
@@ -171,7 +171,7 @@ shrink_cache(int nr_pages, zone_t *class
 		 * The page is mapped into the page tables of one or more
 		 * processes. Try to unmap it here.
 		 */
-		if (page->pte_chain) {
+		if (page->pte.chain) {
 			switch (try_to_unmap(page)) {
 				case SWAP_ERROR:
 				case SWAP_FAIL:
@@ -340,7 +340,7 @@ static void refill_inactive(int nr_pages
 		entry = entry->prev;
 
 		pte_chain_lock(page);
-		if (page->pte_chain && page_referenced(page)) {
+		if (page->pte.chain && page_referenced(page)) {
 			list_del(&page->lru);
 			list_add(&page->lru, &active_list);
 			pte_chain_unlock(page);

.
