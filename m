Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSHKHbe>; Sun, 11 Aug 2002 03:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSHKH34>; Sun, 11 Aug 2002 03:29:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39942 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318111AbSHKH0C>;
	Sun, 11 Aug 2002 03:26:02 -0400
Message-ID: <3D5614BC.EB0629B6@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 15/21] multiple pte pointers per pte_chain
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The pte_chains presently consist of a pte pointer and a `next' link. 
So there's a 50% memory wastage here as well as potential for a lot of
misses during walks of the singly-linked per-page list.

This patch increases the pte_chain structure to occupy a full
cacheline.  There are 7, 15 or 31 pte pointers per structure rather
than just one.  So the wastage falls to a few percent and the number of
misses during the walk is reduced.

The patch doesn't make much difference in simple testing, because in
those tests the pte_chain list from the previous page has good cache
locality with the next page's list.  It helped with 10,000 exits
though.

For more complex, real-world patterns the improved cache footprint is
expected to help.  Plus it saves memory and reduces the amount of work
performed in the slab allocator.

Pages which are mapped by only a single process continue to not have a
pte_chain.  The pointer in struct page points directly at the mapping
pte (a "PageDirect" pte pointer).  Once the page is shared a pte_chain
is allocated and both the new and old pte pointers are moved into it.

We used to collapse the pte_chain back to a PageDirect representation
in page_remove_rmap().  That has been changed.  That collapse is now
performed inside page reclaim, via page_referenced().  The thinking
here is that if a page was previously shared then it may become shared
again, so leave the pte_chain structure in place.  But if the system is
under memory pressure then start reaping them anyway.



 rmap.c |  248 ++++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 176 insertions(+), 72 deletions(-)

--- 2.5.31/mm/rmap.c~rmap-speedup	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/mm/rmap.c	Sun Aug 11 00:21:00 2002
@@ -40,24 +40,39 @@
  * here, the page struct for the page table page contains the process
  * it belongs to and the offset within that process.
  *
- * A singly linked list should be fine for most, if not all, workloads.
- * On fork-after-exec the mapping we'll be removing will still be near
- * the start of the list, on mixed application systems the short-lived
- * processes will have their mappings near the start of the list and
- * in systems with long-lived applications the relative overhead of
- * exit() will be lower since the applications are long-lived.
+ * We use an array of pte pointers in this structure to minimise cache misses
+ * while traversing reverse maps.
  */
+#define NRPTE (L1_CACHE_BYTES/sizeof(void *) - 1)
+
 struct pte_chain {
 	struct pte_chain * next;
-	pte_t * ptep;
+	pte_t *ptes[NRPTE];
 };
 
 spinlock_t rmap_locks[NUM_RMAP_LOCKS];
 
 static kmem_cache_t	*pte_chain_cache;
 static inline struct pte_chain * pte_chain_alloc(void);
-static inline void pte_chain_free(struct pte_chain *, struct pte_chain *,
-		struct page *);
+static void pte_chain_free(struct pte_chain *pte_chain);
+
+/*
+ * pte_chain list management policy:
+ *
+ * - If a page has a pte_chain list then it is shared by at least two processes,
+ *   because a single sharing uses PageDirect. (Well, this isn't true yet,
+ *   coz this code doesn't collapse singletons back to PageDirect on the remove
+ *   path).
+ * - A pte_chain list has free space only in the head member - all succeeding
+ *   members are 100% full.
+ * - If the head element has free space, it occurs in its leading slots.
+ * - All free space in the pte_chain is at the start of the head member.
+ * - Insertion into the pte_chain puts a pte pointer in the last free slot of
+ *   the head member.
+ * - Removal from a pte chain moves the head pte of the head member onto the
+ *   victim pte and frees the head member if it became empty.
+ */
+
 
 /**
  * page_referenced - test if the page was referenced
@@ -66,6 +81,9 @@ static inline void pte_chain_free(struct
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
  * Caller needs to hold the page's rmap lock.
+ *
+ * If the page has a single-entry pte_chain, collapse that back to a PageDirect
+ * representation.  This way, it's only done under memory pressure.
  */
 int page_referenced(struct page * page)
 {
@@ -79,10 +97,27 @@ int page_referenced(struct page * page)
 		if (ptep_test_and_clear_young(page->pte.direct))
 			referenced++;
 	} else {
+		int nr_chains = 0;
+
 		/* Check all the page tables mapping this page. */
 		for (pc = page->pte.chain; pc; pc = pc->next) {
-			if (ptep_test_and_clear_young(pc->ptep))
-				referenced++;
+			int i;
+
+			for (i = NRPTE-1; i >= 0; i--) {
+				pte_t *p = pc->ptes[i];
+				if (!p)
+					break;
+				if (ptep_test_and_clear_young(p))
+					referenced++;
+				nr_chains++;
+			}
+		}
+		if (nr_chains == 1) {
+			pc = page->pte.chain;
+			page->pte.direct = pc->ptes[NRPTE-1];
+			SetPageDirect(page);
+			pte_chain_free(pc);
+			dec_page_state(nr_reverse_maps);
 		}
 	}
 	return referenced;
@@ -99,6 +134,7 @@ int page_referenced(struct page * page)
 void __page_add_rmap(struct page *page, pte_t *ptep)
 {
 	struct pte_chain * pte_chain;
+	int i;
 
 #ifdef DEBUG_RMAP
 	if (!page || !ptep)
@@ -120,32 +156,58 @@ void __page_add_rmap(struct page *page, 
 				BUG();
 		} else {
 			for (pc = page->pte.chain; pc; pc = pc->next) {
-				if (pc->ptep == ptep)
-					BUG();
+				for (i = 0; i < NRPTE; i++) {
+					pte_t *p = pc->ptes[i];
+
+					if (p && p == ptep)
+						BUG();
+				}
 			}
 		}
 	}
 #endif
 
+	if (page->pte.chain == NULL) {
+		page->pte.direct = ptep;
+		SetPageDirect(page);
+		goto out;
+	}
+	
 	if (PageDirect(page)) {
 		/* Convert a direct pointer into a pte_chain */
-		pte_chain = pte_chain_alloc();
-		pte_chain->ptep = page->pte.direct;
-		pte_chain->next = NULL;
-		page->pte.chain = pte_chain;
 		ClearPageDirect(page);
-	}
-	if (page->pte.chain) {
-		/* Hook up the pte_chain to the page. */
 		pte_chain = pte_chain_alloc();
-		pte_chain->ptep = ptep;
-		pte_chain->next = page->pte.chain;
+		pte_chain->ptes[NRPTE-1] = page->pte.direct;
+		pte_chain->ptes[NRPTE-2] = ptep;
+		mod_page_state(nr_reverse_maps, 2);
 		page->pte.chain = pte_chain;
-	} else {
-		page->pte.direct = ptep;
-		SetPageDirect(page);
+		goto out;
+	}
+
+	pte_chain = page->pte.chain;
+	if (pte_chain->ptes[0]) {	/* It's full */
+		struct pte_chain *new;
+
+		new = pte_chain_alloc();
+		new->next = pte_chain;
+		page->pte.chain = new;
+		new->ptes[NRPTE-1] = ptep;
+		inc_page_state(nr_reverse_maps);
+		goto out;
+	}
+
+	BUG_ON(pte_chain->ptes[NRPTE-1] == NULL);
+
+	for (i = NRPTE-2; i >= 0; i--) {
+		if (pte_chain->ptes[i] == NULL) {
+			pte_chain->ptes[i] = ptep;
+			inc_page_state(nr_reverse_maps);
+			goto out;
+		}
 	}
-	inc_page_state(nr_reverse_maps);
+	BUG();
+
+out:
 }
 
 void page_add_rmap(struct page *page, pte_t *ptep)
@@ -171,7 +233,7 @@ void page_add_rmap(struct page *page, pt
  */
 void __page_remove_rmap(struct page *page, pte_t *ptep)
 {
-	struct pte_chain * pc, * prev_pc = NULL;
+	struct pte_chain *pc;
 
 	if (!page || !ptep)
 		BUG();
@@ -185,15 +247,32 @@ void __page_remove_rmap(struct page *pag
 			goto out;
 		}
 	} else {
-		for (pc = page->pte.chain; pc; prev_pc = pc, pc = pc->next) {
-			if (pc->ptep == ptep) {
-				pte_chain_free(pc, prev_pc, page);
-				/* Check whether we can convert to direct */
-				pc = page->pte.chain;
-				if (!pc->next) {
-					page->pte.direct = pc->ptep;
-					SetPageDirect(page);
-					pte_chain_free(pc, NULL, NULL);
+		struct pte_chain *start = page->pte.chain;
+		int victim_i = -1;
+
+		for (pc = start; pc; pc = pc->next) {
+			int i;
+
+			if (pc->next)
+				prefetch(pc->next);
+			for (i = 0; i < NRPTE; i++) {
+				pte_t *p = pc->ptes[i];
+
+				if (!p)
+					continue;
+				if (victim_i == -1)
+					victim_i = i;
+				if (p != ptep)
+					continue;
+				pc->ptes[i] = start->ptes[victim_i];
+				start->ptes[victim_i] = NULL;
+				dec_page_state(nr_reverse_maps);
+				if (victim_i == NRPTE-1) {
+					/* Emptied a pte_chain */
+					page->pte.chain = start->next;
+					pte_chain_free(start);
+				} else {
+					/* Do singleton->PageDirect here */
 				}
 				goto out;
 			}
@@ -212,9 +291,9 @@ void __page_remove_rmap(struct page *pag
 	printk("\n");
 	printk(KERN_ERR "page_remove_rmap: driver cleared PG_reserved ?\n");
 #endif
+	return;
 
 out:
-	dec_page_state(nr_reverse_maps);
 	return;
 }
 
@@ -316,8 +395,9 @@ out_unlock:
  */
 int try_to_unmap(struct page * page)
 {
-	struct pte_chain * pc, * next_pc, * prev_pc = NULL;
+	struct pte_chain *pc, *next_pc, *start;
 	int ret = SWAP_SUCCESS;
+	int victim_i = -1;
 
 	/* This page should not be on the pageout lists. */
 	if (PageReserved(page))
@@ -334,35 +414,57 @@ int try_to_unmap(struct page * page)
 			page->pte.direct = NULL;
 			ClearPageDirect(page);
 		}
-	} else {		
-		for (pc = page->pte.chain; pc; pc = next_pc) {
-			next_pc = pc->next;
-			switch (try_to_unmap_one(page, pc->ptep)) {
-				case SWAP_SUCCESS:
-					/* Free the pte_chain struct. */
-					pte_chain_free(pc, prev_pc, page);
-					break;
-				case SWAP_AGAIN:
-					/* Skip this pte, remembering status. */
-					prev_pc = pc;
-					ret = SWAP_AGAIN;
-					continue;
-				case SWAP_FAIL:
-					ret = SWAP_FAIL;
-					break;
-				case SWAP_ERROR:
-					ret = SWAP_ERROR;
-					break;
+		goto out;
+	}		
+
+	start = page->pte.chain;
+	for (pc = start; pc; pc = next_pc) {
+		int i;
+
+		next_pc = pc->next;
+		if (next_pc)
+			prefetch(next_pc);
+		for (i = 0; i < NRPTE; i++) {
+			pte_t *p = pc->ptes[i];
+
+			if (!p)
+				continue;
+			if (victim_i == -1) 
+				victim_i = i;
+
+			switch (try_to_unmap_one(page, p)) {
+			case SWAP_SUCCESS:
+				/*
+				 * Release a slot.  If we're releasing the
+				 * first pte in the first pte_chain then
+				 * pc->ptes[i] and start->ptes[victim_i] both
+				 * refer to the same thing.  It works out.
+				 */
+				pc->ptes[i] = start->ptes[victim_i];
+				start->ptes[victim_i] = NULL;
+				dec_page_state(nr_reverse_maps);
+				victim_i++;
+				if (victim_i == NRPTE) {
+					page->pte.chain = start->next;
+					pte_chain_free(start);
+					start = page->pte.chain;
+					victim_i = 0;
+				}
+				break;
+			case SWAP_AGAIN:
+				/* Skip this pte, remembering status. */
+				ret = SWAP_AGAIN;
+				continue;
+			case SWAP_FAIL:
+				ret = SWAP_FAIL;
+				goto out;
+			case SWAP_ERROR:
+				ret = SWAP_ERROR;
+				goto out;
 			}
 		}
-		/* Check whether we can convert to direct pte pointer */
-		pc = page->pte.chain;
-		if (pc && !pc->next) {
-			page->pte.direct = pc->ptep;
-			SetPageDirect(page);
-			pte_chain_free(pc, NULL, NULL);
-		}
 	}
+out:
 	return ret;
 }
 
@@ -383,14 +485,9 @@ int try_to_unmap(struct page * page)
  * called for new pte_chain structures which aren't on any list yet.
  * Caller needs to hold the rmap_lock if the page is non-NULL.
  */
-static inline void pte_chain_free(struct pte_chain * pte_chain,
-		struct pte_chain * prev_pte_chain, struct page * page)
+static void pte_chain_free(struct pte_chain *pte_chain)
 {
-	if (prev_pte_chain)
-		prev_pte_chain->next = pte_chain->next;
-	else if (page)
-		page->pte.chain = pte_chain->next;
-
+	pte_chain->next = NULL;
 	kmem_cache_free(pte_chain_cache, pte_chain);
 }
 
@@ -405,6 +502,13 @@ static inline struct pte_chain *pte_chai
 	return kmem_cache_alloc(pte_chain_cache, GFP_ATOMIC);
 }
 
+static void pte_chain_ctor(void *p, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct pte_chain *pc = p;
+
+	memset(pc, 0, sizeof(*pc));
+}
+
 void __init pte_chain_init(void)
 {
 	int i;
@@ -416,7 +520,7 @@ void __init pte_chain_init(void)
 						sizeof(struct pte_chain),
 						0,
 						0,
-						NULL,
+						pte_chain_ctor,
 						NULL);
 
 	if (!pte_chain_cache)

.
