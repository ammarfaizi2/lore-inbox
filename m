Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318739AbSIPCoP>; Sun, 15 Sep 2002 22:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSIPCoP>; Sun, 15 Sep 2002 22:44:15 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:7109 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318739AbSIPCoL>; Sun, 15 Sep 2002 22:44:11 -0400
Date: Sun, 15 Sep 2002 23:47:55 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-mm@kvack.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH](1/2) rmap14 for ac  (was: Re: 2.5.34-mm4)
Message-ID: <Pine.LNX.4.44L.0209152346320.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 2002, Alan Cox wrote:

> So send me rmap-14a patches by all means

And here is the patch that takes you from rmap14 to
rmap14a + small bugfixes.  Don't be fooled by the
bitkeeper changelog, there was a one-line (whitespace)
reject I had to fix ;)

please apply,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Spamtraps of the month:  september@surriel.com trac@trac.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           mm/rmap.c	1.7     -> 1.8
#	include/linux/mmzone.h	1.12    -> 1.13
#	     mm/page_alloc.c	1.51    -> 1.53
#	         mm/vmscan.c	1.72    -> 1.77
#	        mm/filemap.c	1.71    -> 1.72
#	         mm/memory.c	1.55    -> 1.56
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/15	riel@imladris.surriel.com	1.677
# rmap 14 release
# --------------------------------------------
# 02/08/16	riel@imladris.surriel.com	1.678
# low latency zap_page_range also without preempt
# --------------------------------------------
# 02/08/16	riel@imladris.surriel.com	1.679
# remove unneeded pte_chain_unlock/lock pair from vmscan.c
# --------------------------------------------
# 02/08/16	riel@imladris.surriel.com	1.680
# semicolon day, fix typo in rmap.c w/ DEBUG_RMAP
# --------------------------------------------
# 02/08/17	riel@imladris.surriel.com	1.681
# fix smp lock in page_launder_zone (Arjan van de Ven)
# --------------------------------------------
# 02/08/17	riel@imladris.surriel.com	1.682
# Ingo Molnar's per-cpu pages
# --------------------------------------------
# 02/08/18	riel@imladris.surriel.com	1.683
# another (minor) smp fix for page_launder
# --------------------------------------------
# 02/08/18	riel@imladris.surriel.com	1.684
# - throughput tuning for page_launder
# - don't allocate swap space for pages we're not writing
# --------------------------------------------
# 02/08/18	riel@imladris.surriel.com	1.685
# rmap 14a
# --------------------------------------------
# 02/08/19	riel@imladris.surriel.com	1.686
# page_launder bug found by Andrew Morton
# --------------------------------------------
# 02/08/19	riel@imladris.surriel.com	1.687
# clean up mark_page_accessed
# --------------------------------------------
# 02/08/30	riel@imladris.surriel.com	1.688
# Alpha NUMA fix for Ingo's per-cpu pages
# --------------------------------------------
#
--- linux-2.4.20-pre5-ac6-rmap14/mm/filemap.c.orig	2002-09-15 23:39:25.000000000 -0300
+++ linux-2.4.20-pre5-ac6-rmap14/mm/filemap.c	2002-09-15 23:43:42.000000000 -0300
@@ -1383,20 +1383,17 @@
  */
 void mark_page_accessed(struct page *page)
 {
-	if (PageInactiveClean(page)) {
+	/* Mark the page referenced, AFTER checking for previous usage.. */
+	SetPageReferenced(page);
+
+	if (unlikely(PageInactiveClean(page))) {
 		struct zone_struct *zone = page_zone(page);
 		int free = zone->free_pages + zone->inactive_clean_pages;

 		activate_page(page);
 		if (free < zone->pages_low)
 			wakeup_kswapd(GFP_NOIO);
-		if (zone->free_pages < zone->pages_min)
-			fixup_freespace(zone, 1);
-		return;
 	}
-
-	/* Mark the page referenced, AFTER checking for previous usage.. */
-	SetPageReferenced(page);
 }

 /*
--- linux-2.4.20-pre5-ac6-rmap14/mm/memory.c.orig	2002-09-15 23:39:25.000000000 -0300
+++ linux-2.4.20-pre5-ac6-rmap14/mm/memory.c	2002-09-15 23:43:05.000000000 -0300
@@ -436,6 +436,9 @@

 		spin_unlock(&mm->page_table_lock);

+		if (current->need_resched)
+			schedule();
+
 		address += block;
 		size -= block;
 	}
--- linux-2.4.20-pre5-ac6-rmap14/mm/page_alloc.c.orig	2002-09-15 23:38:38.000000000 -0300
+++ linux-2.4.20-pre5-ac6-rmap14/mm/page_alloc.c	2002-09-15 23:43:05.000000000 -0300
@@ -10,6 +10,7 @@
  *  Reshaped it to be a zoned allocator, Ingo Molnar, Red Hat, 1999
  *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
+ *  Per-CPU page pool, Ingo Molnar, Red Hat, 2001, 2002
  */

 #include <linux/config.h>
@@ -22,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mm_inline.h>
+#include <linux/smp.h>

 int nr_swap_pages;
 int nr_active_pages;
@@ -85,6 +87,7 @@
 	unsigned long index, page_idx, mask, flags;
 	free_area_t *area;
 	struct page *base;
+	per_cpu_t *per_cpu;
 	zone_t *zone;

 	/* Yes, think what happens when other parts of the kernel take
@@ -93,6 +96,13 @@
 	if (PageLRU(page))
 		lru_cache_del(page);

+	/*
+	 * This late check is safe because reserved pages do not
+	 * have a valid page->count. This trick avoids overhead
+	 * in __free_pages().
+	 */
+	if (PageReserved(page))
+		return;
 	if (page->buffers)
 		BUG();
 	if (page->mapping) {
@@ -129,7 +139,18 @@

 	area = zone->free_area + order;

-	spin_lock_irqsave(&zone->lock, flags);
+	per_cpu = zone->cpu_pages + smp_processor_id();
+
+	__save_flags(flags);
+	__cli();
+	if (!order && (per_cpu->nr_pages < per_cpu->max_nr_pages) && (free_high(zone) <= 0)) {
+		list_add(&page->list, &per_cpu->head);
+		per_cpu->nr_pages++;
+		__restore_flags(flags);
+		return;
+	}
+
+	spin_lock(&zone->lock);

 	zone->free_pages -= mask;

@@ -193,13 +214,32 @@
 static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
 static struct page * rmqueue(zone_t *zone, unsigned int order)
 {
+	per_cpu_t *per_cpu = zone->cpu_pages + smp_processor_id();
 	free_area_t * area = zone->free_area + order;
 	unsigned int curr_order = order;
 	struct list_head *head, *curr;
 	unsigned long flags;
 	struct page *page;
+	int threshold = 0;
+
+	if (!(current->flags & PF_MEMALLOC))
+		 threshold = (per_cpu->max_nr_pages / 8);
+	__save_flags(flags);
+	__cli();

-	spin_lock_irqsave(&zone->lock, flags);
+	if (!order && (per_cpu->nr_pages>threshold)) {
+		if (unlikely(list_empty(&per_cpu->head)))
+			BUG();
+		page = list_entry(per_cpu->head.next, struct page, list);
+		list_del(&page->list);
+		per_cpu->nr_pages--;
+		__restore_flags(flags);
+
+		set_page_count(page, 1);
+		return page;
+	}
+
+ 	spin_lock(&zone->lock);
 	do {
 		head = &area->free_list;
 		curr = head->next;
@@ -596,7 +636,7 @@

 void __free_pages(struct page *page, unsigned int order)
 {
-	if (!PageReserved(page) && put_page_testzero(page))
+	if (put_page_testzero(page))
 		__free_pages_ok(page, order);
 }

@@ -879,6 +919,7 @@

 	offset = lmem_map - mem_map;
 	for (j = 0; j < MAX_NR_ZONES; j++) {
+		int k;
 		zone_t *zone = pgdat->node_zones + j;
 		unsigned long mask, extrafree = 0;
 		unsigned long size, realsize;
@@ -891,6 +932,18 @@
 		printk("zone(%lu): %lu pages.\n", j, size);
 		zone->size = size;
 		zone->name = zone_names[j];
+
+		for (k = 0; k < NR_CPUS; k++) {
+			per_cpu_t *per_cpu = zone->cpu_pages + k;
+
+			INIT_LIST_HEAD(&per_cpu->head);
+			per_cpu->nr_pages = 0;
+			per_cpu->max_nr_pages = realsize / smp_num_cpus / 128;
+			if (per_cpu->max_nr_pages > MAX_PER_CPU_PAGES)
+				per_cpu->max_nr_pages = MAX_PER_CPU_PAGES;
+			else if (!per_cpu->max_nr_pages)
+				per_cpu->max_nr_pages = 1;
+		}
 		zone->lock = SPIN_LOCK_UNLOCKED;
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
--- linux-2.4.20-pre5-ac6-rmap14/mm/rmap.c.orig	2002-09-15 23:38:38.000000000 -0300
+++ linux-2.4.20-pre5-ac6-rmap14/mm/rmap.c	2002-09-15 23:43:05.000000000 -0300
@@ -95,7 +95,7 @@
 		BUG();
 	if (!pte_present(*ptep))
 		BUG();
-	if (!ptep_to_mm(ptep));
+	if (!ptep_to_mm(ptep))
 		BUG();
 #endif

--- linux-2.4.20-pre5-ac6-rmap14/mm/vmscan.c.orig	2002-09-15 23:39:25.000000000 -0300
+++ linux-2.4.20-pre5-ac6-rmap14/mm/vmscan.c	2002-09-15 23:43:05.000000000 -0300
@@ -214,7 +214,7 @@
 	int maxscan, cleaned_pages, target, maxlaunder, iopages;
 	struct list_head * entry, * next;

-	target = free_plenty(zone);
+	target = max(free_plenty(zone), zone->pages_min);
 	cleaned_pages = iopages = 0;

 	/* If we can get away with it, only flush 2 MB worth of dirty pages */
@@ -222,12 +222,12 @@
 		maxlaunder = 1000000;
 	else {
 		maxlaunder = min_t(int, 512, zone->inactive_dirty_pages / 4);
-		maxlaunder = max(maxlaunder, free_plenty(zone));
+		maxlaunder = max(maxlaunder, free_plenty(zone) * 4);
 	}

 	/* The main launder loop. */
-rescan:
 	spin_lock(&pagemap_lru_lock);
+rescan:
 	maxscan = zone->inactive_dirty_pages;
 	entry = zone->inactive_dirty_list.prev;
 	next = entry->prev;
@@ -295,7 +295,6 @@
 			UnlockPage(page);
 			continue;
 		}
-		pte_chain_unlock(page);

 		/*
 		 * Anonymous process memory without backing store. Try to
@@ -303,8 +302,15 @@
 		 *
 		 * XXX: implement swap clustering ?
 		 */
-		pte_chain_lock(page);
 		if (page->pte_chain && !page->mapping && !page->buffers) {
+			/* Don't bother if we can't swap it out now. */
+			if (maxlaunder < 0) {
+				pte_chain_unlock(page);
+				UnlockPage(page);
+				list_del(entry);
+				list_add(entry, &zone->inactive_dirty_list);
+				continue;
+			}
 			page_cache_get(page);
 			pte_chain_unlock(page);
 			spin_unlock(&pagemap_lru_lock);
@@ -324,7 +330,7 @@
 		 * The page is mapped into the page tables of one or more
 		 * processes. Try to unmap it here.
 		 */
-		if (page->pte_chain) {
+		if (page->pte_chain && page->mapping) {
 			switch (try_to_unmap(page)) {
 				case SWAP_ERROR:
 				case SWAP_FAIL:
@@ -377,11 +383,11 @@
 		 * the page as well.
 		 */
 		if (page->buffers) {
-			spin_unlock(&pagemap_lru_lock);
-
 			/* To avoid freeing our page before we're done. */
 			page_cache_get(page);

+			spin_unlock(&pagemap_lru_lock);
+
 			if (try_to_release_page(page, gfp_mask)) {
 				if (!page->mapping) {
 					/*
@@ -405,10 +411,19 @@
 					 * slept; undo the stuff we did before
 					 * try_to_release_page and fall through
 					 * to the next step.
+					 * But only if the page is still on the inact. dirty
+					 * list.
 					 */
-					page_cache_release(page);

 					spin_lock(&pagemap_lru_lock);
+					/* Check if the page was removed from the list
+					 * while we looked the other way.
+					 */
+					if (!PageInactiveDirty(page)) {
+						page_cache_release(page);
+						continue;
+					}
+					page_cache_release(page);
 				}
 			} else {
 				/* failed to drop the buffers so stop here */
@@ -478,8 +493,10 @@

 	/* Clean up the remaining zones with a serious shortage, if any. */
 	for_each_zone(zone)
-		if (free_min(zone) >= 0)
-			freed += page_launder_zone(zone, gfp_mask, 1);
+		if (free_low(zone) >= 0) {
+			int fullflush = free_min(zone) > 0;
+			freed += page_launder_zone(zone, gfp_mask, fullflush);
+		}

 	return freed;
 }
--- linux-2.4.20-pre5-ac6-rmap14/include/linux/mmzone.h.orig	2002-09-15 23:39:25.000000000 -0300
+++ linux-2.4.20-pre5-ac6-rmap14/include/linux/mmzone.h	2002-09-15 23:43:04.000000000 -0300
@@ -27,6 +27,12 @@
 struct pglist_data;
 struct pte_chain;

+#define MAX_PER_CPU_PAGES 512
+typedef struct per_cpu_pages_s {
+	int			nr_pages, max_nr_pages;
+	struct list_head	head;
+} __attribute__((aligned(L1_CACHE_BYTES))) per_cpu_t;
+
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
  * into multiple physical zones. On a PC we have 3 zones:
@@ -39,6 +45,7 @@
 	/*
 	 * Commonly accessed fields:
 	 */
+	per_cpu_t		cpu_pages[NR_CPUS];
 	spinlock_t		lock;
 	unsigned long		free_pages;
 	unsigned long		active_pages;

