Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313610AbSDQI11>; Wed, 17 Apr 2002 04:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313705AbSDQI11>; Wed, 17 Apr 2002 04:27:27 -0400
Received: from holomorphy.com ([66.224.33.161]:18838 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313610AbSDQI1Y>;
	Wed, 17 Apr 2002 04:27:24 -0400
Date: Wed, 17 Apr 2002 01:25:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: riel@surriel.com, akpm@zip.com.au, hch@infradead.org, arjanv@redhat.com,
        viro@math.psu.edu, Martin.Bligh@us.ibm.com
Subject: [PATCH] per-zone pte_chain freelists
Message-ID: <20020417082510.GQ21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, akpm@zip.com.au,
	hch@infradead.org, arjanv@redhat.com, viro@math.psu.edu,
	Martin.Bligh@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against current rmap bk sources.
Available from bk://linux-wli.bkbits.net/rmap_locking/


In order to remove broader locks, smaller critical sections manipulating
some well-defined portion of the program state must be identified and
removed from the scope of its protection. This patch identifies one such
set of critical sections and its associated program state, and endows
it with its own partitioned dataset and set of locks.

While redundant by itself, after a later removal of global locks it
becomes quite necessary, as the global pte_chain_freelist falls under
the protection of the pagemap_lru_lock.

Tested in isolation on top of current rmap bk sources with 10 hours
of Cerberus on an 8-way logical HT i386 machine. Other stress testing
was done in combination with other patches.


Cheers,
Bill

P.S.	This one's pretty safe; I can make some noise with this while
	brewing up docs I should put out after getting all the background
	resarch done for this and letting stress tests spin on the later
	stuff in the series.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.402   -> 1.403  
#	           mm/rmap.c	1.1     -> 1.2    
#	include/linux/mmzone.h	1.9     -> 1.10   
#	     mm/page_alloc.c	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/16	wli@elm3b52.eng.beaverton.ibm.com	1.403
# logging_ok:
#   Logging to logging@openlogging.org accepted
# rmap.c:
#   Eliminate global pte_chain_freelist and use per-zone pte_chain_freelists, protected by per-zone pte_chain_freelist_locks.
# page_alloc.c:
#   Initialize per-zone pte_chain_freelist and pte_chain_freelist_locks.
# mmzone.h:
#   Add per-zone pte_chain_freelist and pte_chain_freelist_lock fields to mmzone.h
# --------------------------------------------
#
diff --minimal -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Tue Apr 16 23:26:13 2002
+++ b/include/linux/mmzone.h	Tue Apr 16 23:26:13 2002
@@ -25,6 +25,7 @@
 } free_area_t;
 
 struct pglist_data;
+struct pte_chain;
 
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
@@ -53,6 +54,8 @@
 	struct list_head	inactive_dirty_list;
 	struct list_head	inactive_clean_list;
 	free_area_t		free_area[MAX_ORDER];
+	spinlock_t		pte_chain_freelist_lock;
+	struct pte_chain	*pte_chain_freelist;
 
 	/*
 	 * wait_table		-- the array holding the hash table
diff --minimal -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Tue Apr 16 23:26:13 2002
+++ b/mm/page_alloc.c	Tue Apr 16 23:26:13 2002
@@ -910,9 +910,11 @@
 		zone->inactive_clean_pages = 0;
 		zone->inactive_dirty_pages = 0;
 		zone->need_balance = 0;
+		zone->pte_chain_freelist = NULL;
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_dirty_list);
 		INIT_LIST_HEAD(&zone->inactive_clean_list);
+		spin_lock_init(&zone->pte_chain_freelist_lock);
 
 		if (!size)
 			continue;
diff --minimal -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	Tue Apr 16 23:26:12 2002
+++ b/mm/rmap.c	Tue Apr 16 23:26:12 2002
@@ -48,10 +48,27 @@
 	pte_t * ptep;
 };
 
-static struct pte_chain * pte_chain_freelist;
-static inline struct pte_chain * pte_chain_alloc(void);
-static inline void pte_chain_free(struct pte_chain *, struct pte_chain *, struct page *);
-static void alloc_new_pte_chains(void);
+static inline struct pte_chain * pte_chain_alloc(zone_t *);
+static inline void pte_chain_free(zone_t *, struct pte_chain *, struct pte_chain *, struct page *);
+static void alloc_new_pte_chains(zone_t *);
+
+static inline void pte_chain_push(zone_t *zone, struct pte_chain *pte_chain)
+{
+	pte_chain->ptep = NULL;
+	pte_chain->next = zone->pte_chain_freelist;
+	zone->pte_chain_freelist = pte_chain;
+}
+
+static inline struct pte_chain *pte_chain_pop(zone_t *zone)
+{
+	struct pte_chain *pte_chain;
+
+	pte_chain = zone->pte_chain_freelist;
+	zone->pte_chain_freelist = pte_chain->next;
+	pte_chain->next = NULL;
+
+	return pte_chain;
+}
 
 /**
  * page_referenced - test if the page was referenced
@@ -91,10 +108,13 @@
 void page_add_rmap(struct page * page, pte_t * ptep)
 {
 	struct pte_chain * pte_chain;
+	zone_t *zone;
 
 	if (!VALID_PAGE(page) || PageReserved(page))
 		return;
 
+	zone = page_zone(page);
+
 	spin_lock(&pagemap_lru_lock);
 #ifdef DEBUG_RMAP
 	if (!page || !ptep)
@@ -111,7 +131,7 @@
 		}
 	}
 #endif
-	pte_chain = pte_chain_alloc();
+	pte_chain = pte_chain_alloc(zone);
 
 	/* Hook up the pte_chain to the page. */
 	pte_chain->ptep = ptep;
@@ -135,16 +155,19 @@
 void page_remove_rmap(struct page * page, pte_t * ptep)
 {
 	struct pte_chain * pc, * prev_pc = NULL;
+	zone_t *zone;
 
 	if (!page || !ptep)
 		BUG();
 	if (!VALID_PAGE(page) || PageReserved(page))
 		return;
 
+	zone = page_zone(page);
+
 	spin_lock(&pagemap_lru_lock);
 	for (pc = page->pte_chain; pc; prev_pc = pc, pc = pc->next) {
 		if (pc->ptep == ptep) {
-			pte_chain_free(pc, prev_pc, page);
+			pte_chain_free(zone, pc, prev_pc, page);
 			goto out;
 		}
 	}
@@ -252,6 +275,7 @@
 int try_to_unmap(struct page * page)
 {
 	struct pte_chain * pc, * next_pc, * prev_pc = NULL;
+	zone_t *zone = page_zone(page);
 	int ret = SWAP_SUCCESS;
 
 	/* This page should not be on the pageout lists. */
@@ -268,7 +292,7 @@
 		switch (try_to_unmap_one(page, pc->ptep)) {
 			case SWAP_SUCCESS:
 				/* Free the pte_chain struct. */
-				pte_chain_free(pc, prev_pc, page);
+				pte_chain_free(zone, pc, prev_pc, page);
 				break;
 			case SWAP_AGAIN:
 				/* Skip this pte, remembering status. */
@@ -334,16 +358,19 @@
  * called for new pte_chain structures which aren't on any list yet.
  * Caller needs to hold the pagemap_lru_list.
  */
-static inline void pte_chain_free(struct pte_chain * pte_chain, struct pte_chain * prev_pte_chain, struct page * page)
+static inline void pte_chain_free(	zone_t *zone,
+					struct pte_chain * pte_chain,
+					struct pte_chain * prev_pte_chain,
+					struct page * page)
 {
 	if (prev_pte_chain)
 		prev_pte_chain->next = pte_chain->next;
 	else if (page)
 		page->pte_chain = pte_chain->next;
 
-	pte_chain->ptep = NULL;
-	pte_chain->next = pte_chain_freelist;
-	pte_chain_freelist = pte_chain;
+	spin_lock(&zone->pte_chain_freelist_lock);
+	pte_chain_push(zone, pte_chain);
+	spin_unlock(&zone->pte_chain_freelist_lock);
 }
 
 /**
@@ -353,18 +380,20 @@
  * pte_chain structures as required.
  * Caller needs to hold the pagemap_lru_lock.
  */
-static inline struct pte_chain * pte_chain_alloc(void)
+static inline struct pte_chain * pte_chain_alloc(zone_t *zone)
 {
 	struct pte_chain * pte_chain;
 
+	spin_lock(&zone->pte_chain_freelist_lock);
+
 	/* Allocate new pte_chain structs as needed. */
-	if (!pte_chain_freelist)
-		alloc_new_pte_chains();
+	if (!zone->pte_chain_freelist)
+		alloc_new_pte_chains(zone);
 
 	/* Grab the first pte_chain from the freelist. */
-	pte_chain = pte_chain_freelist;
-	pte_chain_freelist = pte_chain->next;
-	pte_chain->next = NULL;
+	pte_chain = pte_chain_pop(zone);
+
+	spin_unlock(&zone->pte_chain_freelist_lock);
 
 	return pte_chain;
 }
@@ -378,15 +407,16 @@
  *
  * Note that we cannot use the slab cache because the pte_chain structure
  * is way smaller than the minimum size of a slab cache allocation.
+ * Caller needs to hold the zone->pte_chain_freelist_lock
  */
-static void alloc_new_pte_chains(void)
+static void alloc_new_pte_chains(zone_t *zone)
 {
 	struct pte_chain * pte_chain = (void *) get_zeroed_page(GFP_ATOMIC);
 	int i = PAGE_SIZE / sizeof(struct pte_chain);
 
 	if (pte_chain) {
 		for (; i-- > 0; pte_chain++)
-			pte_chain_free(pte_chain, NULL, NULL);
+			pte_chain_push(zone, pte_chain);
 	} else {
 		/* Yeah yeah, I'll fix the pte_chain allocation ... */
 		panic("Fix pte_chain allocation, you lazy bastard!\n");
