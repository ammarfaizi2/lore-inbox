Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316766AbSEUXC0>; Tue, 21 May 2002 19:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSEUXCZ>; Tue, 21 May 2002 19:02:25 -0400
Received: from holomorphy.com ([66.224.33.161]:13455 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316766AbSEUXCV>;
	Tue, 21 May 2002 19:02:21 -0400
Date: Tue, 21 May 2002 16:02:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: per-cpu pte_chain freelists
Message-ID: <20020521230214.GL2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to do a little better than per-zone.

Cheers,
Bill

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.423   -> 1.424  
#	           mm/rmap.c	1.7     -> 1.8    
#	include/linux/mmzone.h	1.11    -> 1.12   
#	     mm/page_alloc.c	1.47    -> 1.48   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/21	wli@tisifone.holomorphy.com	1.424
# per-cpu pte_chain freelists
# --------------------------------------------
#
diff --minimal -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Tue May 21 15:55:48 2002
+++ b/include/linux/mmzone.h	Tue May 21 15:55:48 2002
@@ -29,6 +29,11 @@
 
 #define MAX_CHUNKS_PER_NODE 8
 
+struct pte_chain_freelist {
+	unsigned long		count;
+	struct pte_chain 	*list;
+};
+
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
  * into multiple physical zones. On a PC we have 3 zones:
@@ -56,8 +61,8 @@
 	struct list_head	inactive_dirty_list;
 	struct list_head	inactive_clean_list;
 	free_area_t		free_area[MAX_ORDER];
-	spinlock_t		pte_chain_freelist_lock;
-	struct pte_chain	*pte_chain_freelist;
+
+	struct pte_chain_freelist pte_chain_freelists[NR_CPUS];
 
 	/*
 	 * wait_table		-- the array holding the hash table
diff --minimal -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Tue May 21 15:55:48 2002
+++ b/mm/page_alloc.c	Tue May 21 15:55:48 2002
@@ -908,11 +908,13 @@
 		zone->inactive_clean_pages = 0;
 		zone->inactive_dirty_pages = 0;
 		zone->need_balance = 0;
-		zone->pte_chain_freelist = NULL;
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_dirty_list);
 		INIT_LIST_HEAD(&zone->inactive_clean_list);
-		spin_lock_init(&zone->pte_chain_freelist_lock);
+		for (i = 0; i < NR_CPUS; ++i) {
+			zone->pte_chain_freelists[i].count = 0;
+			zone->pte_chain_freelists[i].list = NULL;
+		}
 
 		if (!size)
 			continue;
diff --minimal -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	Tue May 21 15:55:48 2002
+++ b/mm/rmap.c	Tue May 21 15:55:48 2002
@@ -51,7 +51,7 @@
 static inline struct pte_chain * pte_chain_alloc(zone_t *);
 static inline void pte_chain_free(struct pte_chain *, struct pte_chain *,
 		struct page *, zone_t *);
-static void alloc_new_pte_chains(zone_t *);
+static void alloc_new_pte_chains(zone_t *, int cpu);
 
 /**
  * page_referenced - test if the page was referenced
@@ -335,25 +335,36 @@
  ** functions.
  **/
 
-static inline void pte_chain_push(zone_t * zone,
-		struct pte_chain * pte_chain)
+static inline void pte_chain_push(struct pte_chain ** list, struct pte_chain * pte_chain)
 {
 	pte_chain->ptep = NULL;
-	pte_chain->next = zone->pte_chain_freelist;
-	zone->pte_chain_freelist = pte_chain;
+	pte_chain->next = *list;
+	*list = pte_chain;
 }
 
-static inline struct pte_chain * pte_chain_pop(zone_t * zone)
+static inline struct pte_chain * pte_chain_pop(struct pte_chain ** list)
 {
 	struct pte_chain *pte_chain;
 
-	pte_chain = zone->pte_chain_freelist;
-	zone->pte_chain_freelist = pte_chain->next;
+	pte_chain = *list;
+	*list = pte_chain->next;
 	pte_chain->next = NULL;
 
 	return pte_chain;
 }
 
+static inline void add_to_pte_chain_freelist(struct pte_chain_freelist * freelists, int cpu, struct pte_chain * pte_chain)
+{
+	pte_chain_push(&freelists[cpu].list, pte_chain);
+	freelists[cpu].count++;
+}
+
+static inline struct pte_chain * del_from_pte_chain_freelist(struct pte_chain_freelist * freelists, int cpu)
+{
+	freelists[cpu].count--;
+	return pte_chain_pop(&freelists[cpu].list);
+}
+
 /**
  * pte_chain_free - free pte_chain structure
  * @pte_chain: pte_chain struct to free
@@ -370,14 +381,17 @@
 		struct pte_chain * prev_pte_chain, struct page * page,
 		zone_t * zone)
 {
+	int cpu = smp_processor_id();
+	struct pte_chain_freelist *freelists;
+
+	freelists = zone->pte_chain_freelists;
+
 	if (prev_pte_chain)
 		prev_pte_chain->next = pte_chain->next;
 	else if (page)
 		page->pte_chain = pte_chain->next;
 
-	spin_lock(&zone->pte_chain_freelist_lock);
-	pte_chain_push(zone, pte_chain);
-	spin_unlock(&zone->pte_chain_freelist_lock);
+	add_to_pte_chain_freelist(freelists, cpu, pte_chain);
 }
 
 /**
@@ -391,17 +405,19 @@
 static inline struct pte_chain * pte_chain_alloc(zone_t * zone)
 {
 	struct pte_chain * pte_chain;
+	struct pte_chain_freelist *freelists;
+	int cpu = smp_processor_id();
+
+	freelists = zone->pte_chain_freelists;
 
-	spin_lock(&zone->pte_chain_freelist_lock);
 
 	/* Allocate new pte_chain structs as needed. */
-	if (!zone->pte_chain_freelist)
-		alloc_new_pte_chains(zone);
+	if (!freelists[cpu].list)
+		alloc_new_pte_chains(zone, cpu);
 
 	/* Grab the first pte_chain from the freelist. */
-	pte_chain = pte_chain_pop(zone);
+	pte_chain = del_from_pte_chain_freelist(freelists, cpu);
 
-	spin_unlock(&zone->pte_chain_freelist_lock);
 
 	return pte_chain;
 }
@@ -409,6 +425,7 @@
 /**
  * alloc_new_pte_chains - convert a free page to pte_chain structures
  * @zone: memory zone to allocate pte_chains for
+ * @cpu:  cpu pte_chains are to be allocated for
  *
  * Grabs a free page and converts it to pte_chain structures. We really
  * should pre-allocate these earlier in the pagefault path or come up
@@ -416,18 +433,33 @@
  *
  * Note that we cannot use the slab cache because the pte_chain structure
  * is way smaller than the minimum size of a slab cache allocation.
- * Caller needs to hold the zone->pte_chain_freelist_lock
+ * Caller needs to hold &zone->pte_chain_freelists[cpu].lock
  */
-static void alloc_new_pte_chains(zone_t *zone)
+
+#define PTE_CHAINS_PER_PAGE (PAGE_SIZE/sizeof(struct pte_chain))
+
+static void alloc_new_pte_chains(zone_t *zone, int cpu)
 {
-	struct pte_chain * pte_chain = (void *) get_zeroed_page(GFP_ATOMIC);
-	int i = PAGE_SIZE / sizeof(struct pte_chain);
+	struct pte_chain * pte_chain;
+	struct pte_chain_freelist *freelists = zone->pte_chain_freelists;
+	int i;
 
-	if (pte_chain) {
-		for (; i-- > 0; pte_chain++)
-			pte_chain_push(zone, pte_chain);
-	} else {
-		/* Yeah yeah, I'll fix the pte_chain allocation ... */
+	/*
+	 * Atomically allocate a page and hand it back. Things are not
+	 * highly unbalanced or there is good reason to allocate, so
+	 * actually get a fresh page.
+	 */
+	pte_chain = (void *) get_zeroed_page(GFP_ATOMIC);
+
+	/* Yeah yeah, I'll fix the pte_chain allocation ... */
+	if (!pte_chain)
 		panic("Fix pte_chain allocation, you lazy bastard!\n");
-	}
+
+	/*
+	 * Be greedy and give ourselves the chains. If some cpu wants
+	 * them, it'll eventually end up taking them above.
+	 */
+	freelists[cpu].count += PTE_CHAINS_PER_PAGE;
+	for (i = 0; i < PTE_CHAINS_PER_PAGE; ++i)
+		pte_chain_push(&freelists[cpu].list, &pte_chain[i]);
 }
