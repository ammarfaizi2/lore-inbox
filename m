Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVAOTtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVAOTtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVAOTtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:49:03 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:15536 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262319AbVAOTqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:46:33 -0500
Date: Sat, 15 Jan 2005 19:46:31 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Memory Management List <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2/2 Satisify high-order allocations with linear scan
In-Reply-To: <Pine.LNX.4.58.0501151942020.17278@skynet>
Message-ID: <Pine.LNX.4.58.0501151945450.17278@skynet>
References: <Pine.LNX.4.58.0501151942020.17278@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch must be applied on top of the modified allocator patch.

The purpose of this patch is to linearly scan the address space when a high-order
allocation cannot be satisfied. It takes the same parameters are try_to_free_pages()
and introduced try_to_free_highorder_pages().

The concept is quiet simple. Once a process enters here, it is given a
struct reclaim_task to record it's progress and prevent multiple processes
reclaiming the same memory. It scans the zones in the usual fallback list
and finds a block of memory that is being used for UserRclm or KernRclm
allocations. Once a block is found, it finds all LRU pages in that block,
removes them from the LRU lists and asks shrink_list() to reclaim them.

Once enough pages have been freed, it returns and tries to allocate the high-order
block again. Statistics are maintained on the number of successful or failed linear
scans and printed in /proc/buddyinfo

This patch is *highly* experimental and there is all sorts of checks that
I should be making and don't. For example, this patch does not account for
"holes" in the zone when it is scanning so this could break architectures
that have holes in the middle of the mem_map. Hence, this is proof-of-concept
only.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc1-mbuddy/include/linux/swap.h linux-2.6.11-rc1-lnscan/include/linux/swap.h
--- linux-2.6.11-rc1-mbuddy/include/linux/swap.h	2005-01-13 10:53:56.000000000 +0000
+++ linux-2.6.11-rc1-lnscan/include/linux/swap.h	2005-01-15 18:33:14.000000000 +0000
@@ -173,6 +173,7 @@ extern void swap_setup(void);

 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
+extern int try_to_free_highorder_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc1-mbuddy/mm/page_alloc.c linux-2.6.11-rc1-lnscan/mm/page_alloc.c
--- linux-2.6.11-rc1-mbuddy/mm/page_alloc.c	2005-01-15 18:10:54.000000000 +0000
+++ linux-2.6.11-rc1-lnscan/mm/page_alloc.c	2005-01-15 18:33:14.000000000 +0000
@@ -53,6 +53,8 @@ int global_refill=0;
 int kernnorclm_count=0;
 int kernrclm_count=0;
 int userrclm_count=0;
+int lnscan_success=0;
+int lnscan_fail=0;

 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -850,6 +852,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	int alloc_type;
 	int do_retry;
 	int can_try_harder;
+	int tried_highorder=0;

 	might_sleep_if(wait);

@@ -926,6 +929,7 @@ rebalance:
 	p->flags &= ~PF_MEMALLOC;

 	/* go through the zonelist yet one more time */
+realloc:
 	for (i = 0; (z = zones[i]) != NULL; i++) {
 		if (!zone_watermark_ok(z, order, z->pages_min,
 				alloc_type, can_try_harder,
@@ -933,8 +937,17 @@ rebalance:
 			continue;

 		page = buffered_rmqueue(z, order, gfp_mask);
-		if (page)
+		if (page) {
+			if (tried_highorder) lnscan_success++;
 			goto got_pg;
+		}
+		if (tried_highorder) lnscan_fail++;
+	}
+
+	if (!tried_highorder && order > 0) {
+		try_to_free_highorder_pages(zones, gfp_mask, order);
+		tried_highorder=1;
+		goto realloc;
 	}

 	/*
@@ -1962,6 +1975,9 @@ static int frag_show(struct seq_file *m,
  	seq_printf(m, "KernNoRclm allocs: %d\n", kernnorclm_count);
  	seq_printf(m, "KernRclm allocs:   %d\n", kernrclm_count);
  	seq_printf(m, "UserRclm allocs:   %d\n", userrclm_count);
+ 	seq_printf(m, "lnscan success:    %d\n", lnscan_success);
+ 	seq_printf(m, "lnscan fail:       %d\n", lnscan_fail);
+
  	seq_printf(m, "%-10s Fallback count: %d\n", type_names[0],
 						    fallback_count[0]);
  	seq_printf(m, "%-10s Fallback count: %d\n", type_names[1],
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc1-mbuddy/mm/vmscan.c linux-2.6.11-rc1-lnscan/mm/vmscan.c
--- linux-2.6.11-rc1-mbuddy/mm/vmscan.c	2005-01-13 10:54:05.000000000 +0000
+++ linux-2.6.11-rc1-lnscan/mm/vmscan.c	2005-01-15 18:54:14.000000000 +0000
@@ -372,6 +372,7 @@ static int shrink_list(struct list_head
 		BUG_ON(PageActive(page));

 		sc->nr_scanned++;
+
 		/* Double the slab pressure for mapped and swapcache pages */
 		if (page_mapped(page) || PageSwapCache(page))
 			sc->nr_scanned++;
@@ -1271,4 +1272,299 @@ static int __init kswapd_init(void)
 	return 0;
 }

+/***
+ * Below this point is a different type of scanner. It is a linear scanner
+ * that tries to find large blocks of pages to be freed. Very experimental
+ * at the moment
+ *
+ * --mel
+ */
+
+/*
+ * Describes a single reclaim task. Only one process is allowed to scan
+ * a single 2^MAX_ORDER block of pages at a time. The active relcimas are
+ * kept on a reclaim_task linked list protected by reclaims_lock
+ */
+struct reclaim_task {
+	struct zone* zone;
+	struct list_head list;
+	int index;
+};
+
+struct list_head active_reclaims;
+spinlock_t reclaims_lock;
+
+/*
+ * Remember the last index scanned in a zone so the same zones do not get
+ * scanned repeatadly. This is not perfect at all as the index used is the
+ * zone index of the fallback list, not the real zone or node ID. Needs
+ * a better solution but will do for this proof of concept
+ */
+int last_reclaim_index[MAX_NR_ZONES];
+
+/*
+ * Find a block to start reclaiming pages from. Returns 1 when a suitable
+ * block is found
+ */
+int find_startblock(int zoneid, struct reclaim_task *rtask) {
+	int startindex;
+	int retval=1;
+
+	/* rtask->index will be -1 the first time a reclaim task is created */
+ 	if (rtask->index == -1) {
+		startindex = last_reclaim_index[zoneid];
+		rtask->index = startindex;
+	} else {
+		startindex = rtask->index;
+	}
+
+	/* Be sure we do not start past the zone boundary */
+	if (rtask->index >= (rtask->zone->present_pages >> MAX_ORDER)-1) {
+		rtask->index=startindex=0;
+	}
+
+
+	do {
+		int bitidx = rtask->index*2;
+
+		/* Test if this region is for UserRclm or KernRclm pages */
+		if (test_bit(bitidx, rtask->zone->free_area_usemap) ||
+		    test_bit(bitidx+1,rtask->zone->free_area_usemap)) {
+			struct list_head *curr;
+			struct reclaim_task *ltask;
+			int success=1;
+
+			/* Make sure no other task is scanning here */
+			spin_lock(&reclaims_lock);
+			list_for_each(curr, &active_reclaims) {
+				ltask = list_entry(curr,
+						struct reclaim_task,
+						list);
+				if (ltask->index == rtask->index &&
+				    ltask != rtask) {
+					success=0;
+					break;
+				}
+			}
+			spin_unlock(&reclaims_lock);
+
+			if (success) {
+				last_reclaim_index[zoneid] = rtask->index;
+				goto out;
+			}
+		}
+
+		/* Wrap around when we reach the end of the zone */
+		if (++rtask->index >=
+				(rtask->zone->present_pages >> MAX_ORDER)-1)
+			rtask->index=0;
+
+	} while (rtask->index != startindex);
+
+	/* Failed to find a suitable block */
+	retval = 0;
+out:
+	return retval;
+}
+
+/*
+ * Tries to free 2^MAX_ORDER blocks of pages starting from page
+ */
+int try_to_free_highorder_block(struct reclaim_task *rtask,
+				unsigned int order, int gfp_mask) {
+	struct page *page;
+	struct page *endpage;
+	struct page *endpageblock;
+	LIST_HEAD(free_canditates);
+	int nr_freed=0;
+	struct scan_control sc;
+	struct pagevec pvec;
+	int tryfree;
+	struct zone* zone = rtask->zone;
+
+	page = zone->zone_mem_map + (rtask->index * (1 << MAX_ORDER));
+	endpageblock = page + (1 << MAX_ORDER);
+	if (endpageblock >
+		zone->zone_mem_map + zone->present_pages)
+		endpageblock =
+			zone->zone_mem_map + zone->present_pages;
+
+retry:
+	endpage = page + (1 << order);
+	if (endpage > endpageblock) endpage = endpageblock;
+
+	/* Scan the whole block of pages */
+	tryfree=0;
+	spin_lock_irq(&zone->lru_lock);
+	while (page <= endpage && page <= endpageblock) {
+
+		/*
+		 * Only free LRU pages for now. In the future, we would also
+		 * want to scan slab pages here. The problem with slab pages
+		 * is that the lru list cannot be used as it is already used
+		 * to track what slab and cache it belongs to
+		 */
+		if (PageLRU(page)) {
+			list_del(&page->lru);
+			if (!TestClearPageLRU(page)) BUG();
+
+			/*
+			 * This will disrupt LRU ordering but in this path,
+			 * we don't really care
+			 */
+			ClearPageActive(page);
+
+			if (get_page_testone(page)) {
+				/*
+				 * It is being freed elsewhere. Put back on
+				 * LRU, move to next page
+				 */
+				__put_page(page);
+				SetPageLRU(page);
+				list_add(&page->lru,
+					&page_zone(page)->inactive_list);
+				page++;
+				continue;
+			}
+
+			list_add(&page->lru, &free_canditates);
+			tryfree++;
+		}
+
+		/* Move to next page to test */
+		page++;
+	}
+	spin_unlock_irq(&zone->lru_lock);
+
+	/* Make sure pages were found */
+	if (list_empty(&free_canditates)) {
+		/* See if it is worth going back again */
+		if (endpageblock - endpage > (1 << order)) goto retry;
+		return nr_freed;
+	}
+
+	/* Construct a scan_control for shrink_list */
+	sc.gfp_mask = gfp_mask;
+	sc.may_writepage = 1;
+	sc.nr_scanned = 0;
+	sc.nr_reclaimed = 0;
+	sc.priority = 0;
+
+	nr_freed += shrink_list(&free_canditates, &sc);
+	if (list_empty(&free_canditates)) {
+		int tofree;
+		if (nr_freed >= (1 << order)) return nr_freed;
+
+		/* Not enough free, worth going back? */
+		tofree = (1 << order) - nr_freed;
+		if (endpageblock - endpage > tofree) goto retry;
+		return nr_freed;
+	}
+
+	/*
+	 * Free up leftover pages
+	 */
+	tryfree=0;
+	pagevec_init(&pvec, 1);
+	spin_lock_irq(&zone->lru_lock);
+	while (!list_empty(&free_canditates)) {
+		page = lru_to_page(&free_canditates);
+		tryfree++;
+		if (TestSetPageLRU(page))
+			BUG();
+		list_del(&page->lru);
+		if (PageActive(page))
+			add_page_to_active_list(rtask->zone, page);
+		else
+			add_page_to_inactive_list(rtask->zone, page);
+		if (!pagevec_add(&pvec, page)) {
+			spin_unlock_irq(&rtask->zone->lru_lock);
+			__pagevec_release(&pvec);
+			spin_lock_irq(&rtask->zone->lru_lock);
+		}
+	}
+	spin_unlock_irq(&zone->lru_lock);
+	pagevec_release(&pvec);
+	return nr_freed;
+
+}
+
+/**
+ * try_to_free_highorder_pages - Linearaly scan and reclaim for high orders
+ * zones - Fallback list of zones to scan
+ * gfp_flags - Flags used for the allocation
+ * order - The order-size block of pages to free
+ *
+ * Warning, this is potentially a very long running function that has no
+ * guarentee of success.
+ */
+int try_to_free_highorder_pages(struct zone** zones,
+					  unsigned int gfp_flags,
+					  unsigned int order) {
+
+	int i, nr_freed;
+	struct reclaim_task *rtask = NULL;
+
+	/* Make sure the right flags are set to do the required work */
+	if (! gfp_flags & __GFP_WAIT ||
+	    ! gfp_flags & __GFP_IO   ||
+	    ! gfp_flags & __GFP_FS) return 0;
+
+	/*
+	 * Create a reclaim task to track our progress. The reclaim task
+	 * is added now before we start to make sure there is exclusively
+	 * one task scanning a 2^MAX_ORDER block
+	 */
+	rtask = kmalloc(sizeof(struct reclaim_task), gfp_flags);
+	memset(rtask, 0, sizeof(struct reclaim_task));
+	spin_lock(&reclaims_lock);
+	list_add(&rtask->list, &active_reclaims);
+	spin_unlock(&reclaims_lock);
+	nr_freed=0;
+
+	for (i = 0; zones[i] != NULL && nr_freed < (1 << order); i++) {
+		int scanblocks;
+
+		/* Reset the index for a new zone */
+		rtask->index=-1;
+		rtask->zone = zones[i];
+
+		/*
+		 * Try scan at least 16 blocks before changing zones. There
+		 * is no significance to the number 16
+		 */
+		for (scanblocks=16;
+			scanblocks >= 0 && nr_freed<(1 << order) ;
+			scanblocks--) {
+
+			if (!find_startblock(i, rtask)) break;
+
+			/* Try and free the block found by find_startblock */
+			nr_freed += try_to_free_highorder_block(rtask,
+								order,
+								gfp_flags);
+
+			rtask->index++;
+
+		}
+
+	}
+
+	spin_lock(&reclaims_lock);
+	list_del(&rtask->list);
+	spin_unlock(&reclaims_lock);
+	kfree(rtask);
+	return nr_freed;
+
+}
+
+static int __init lnscan_init(void) {
+	printk("Initialising lnscan\n");
+	spin_lock_init(&reclaims_lock);
+	INIT_LIST_HEAD(&active_reclaims);
+	memset(last_reclaim_index, 0, sizeof(last_reclaim_index));
+	return 0;
+}
+
 module_init(kswapd_init)
+module_init(lnscan_init);
