Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275196AbRIZNpi>; Wed, 26 Sep 2001 09:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275195AbRIZNp3>; Wed, 26 Sep 2001 09:45:29 -0400
Received: from [195.223.140.107] ([195.223.140.107]:11773 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275198AbRIZNpL>;
	Wed, 26 Sep 2001 09:45:11 -0400
Date: Wed, 26 Sep 2001 15:42:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Osma Ahvenlampi <oa@iki.fi>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.10 swap behaviour (with vm-tweaks-2)
Message-ID: <20010926154225.D27945@athlon.random>
In-Reply-To: <1001490108.1444.34.camel@136.quartal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1001490108.1444.34.camel@136.quartal.com>; from oa@iki.fi on Wed, Sep 26, 2001 at 10:41:48AM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 10:41:48AM +0300, Osma Ahvenlampi wrote:
> quickly lost all response. The mouse pointer would not move, the active

You really want to apply vm-tweaks-1, (or better vm-tweaks-2 inlined
here with the bugfix for Cary's div by zero, woops) and try again. It
applies cleanly to vanilla 2.4.10.

Linus I'd suggest for inclusion, I know you hate it but think at least
at the huge benefit in light vm-pressure load when just heavy non-mapped
cache pollution is going on, even if you disagree about the
pageout-trigger condition (but swapout behaviour is much better too this
way, and I disagree in constantly wasting cpu to know when to swap
anyways).

(btw, after this patch we can also drop the "survive" cruft into the
page fault handler, not included here since not very important cleanup)

diff -urN 2.4.10/include/linux/fs.h vm/include/linux/fs.h
--- 2.4.10/include/linux/fs.h	Sun Sep 23 21:11:42 2001
+++ vm/include/linux/fs.h	Wed Sep 26 15:34:35 2001
@@ -282,7 +282,7 @@
 
 extern void set_bh_page(struct buffer_head *bh, struct page *page, unsigned long offset);
 
-#define touch_buffer(bh)	SetPageReferenced(bh->b_page)
+#define touch_buffer(bh)	mark_page_accessed(bh->b_page)
 
 
 #include <linux/pipe_fs_i.h>
diff -urN 2.4.10/mm/filemap.c vm/mm/filemap.c
--- 2.4.10/mm/filemap.c	Sun Sep 23 21:11:43 2001
+++ vm/mm/filemap.c	Wed Sep 26 15:34:35 2001
@@ -1704,7 +1704,7 @@
 	 * and possibly copy it over to another page..
 	 */
 	old_page = page;
-	mark_page_accessed(page);
+	activate_page(page);
 	if (no_share) {
 		struct page *new_page = alloc_page(GFP_HIGHUSER);
 
diff -urN 2.4.10/mm/swap.c vm/mm/swap.c
--- 2.4.10/mm/swap.c	Sun Sep 23 21:11:43 2001
+++ vm/mm/swap.c	Wed Sep 26 15:34:35 2001
@@ -54,6 +54,7 @@
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
 	}
+	SetPageReferenced(page);
 }	
 
 void deactivate_page(struct page * page)
@@ -72,6 +73,7 @@
 		del_page_from_inactive_list(page);
 		add_page_to_active_list(page);
 	}
+	ClearPageReferenced(page);
 }
 
 void activate_page(struct page * page)
diff -urN 2.4.10/mm/vmscan.c vm/mm/vmscan.c
--- 2.4.10/mm/vmscan.c	Sun Sep 23 21:11:43 2001
+++ vm/mm/vmscan.c	Wed Sep 26 15:35:03 2001
@@ -55,6 +55,9 @@
 		return 0;
 	}
 
+	if (PageActive(page) || (PageInactive(page) && PageReferenced(page)))
+		return 0;
+
 	if (TryLockPage(page))
 		return 0;
 
@@ -329,7 +332,6 @@
 {
 	struct list_head * entry;
 
-	spin_lock(&pagemap_lru_lock);
 	while (max_scan && (entry = inactive_list.prev) != &inactive_list) {
 		struct page * page;
 		swp_entry_t swap;
@@ -358,8 +360,10 @@
 			continue;
 
 		/* Racy check to avoid trylocking when not worthwhile */
-		if (!page->buffers && page_count(page) != 1)
+		if (!page->buffers && page_count(page) != 1) {
+			activate_page_nolock(page);
 			continue;
+		}
 
 		/*
 		 * The page is locked. IO in progress?
@@ -514,7 +518,6 @@
 {
 	struct list_head * entry;
 
-	spin_lock(&pagemap_lru_lock);
 	entry = active_list.prev;
 	while (nr_pages-- && entry != &active_list) {
 		struct page * page;
@@ -529,23 +532,28 @@
 
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
+		SetPageReferenced(page);
 	}
-	spin_unlock(&pagemap_lru_lock);
 }
 
 static int FASTCALL(shrink_caches(int priority, zone_t * classzone, unsigned int gfp_mask, int nr_pages));
 static int shrink_caches(int priority, zone_t * classzone, unsigned int gfp_mask, int nr_pages)
 {
-	int max_scan = nr_inactive_pages / priority;
+	int max_scan;
+	int chunk_size = nr_pages;
+	unsigned long ratio;
 
 	nr_pages -= kmem_cache_reap(gfp_mask);
 	if (nr_pages <= 0)
 		return 0;
 
-	/* Do we want to age the active list? */
-	if (nr_inactive_pages < nr_active_pages*2)
-		refill_inactive(nr_pages);
+	spin_lock(&pagemap_lru_lock);
+	nr_pages = chunk_size;
+	/* try to keep the active list 2/3 of the size of the cache */
+	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
+	refill_inactive(ratio);
 
+	max_scan = nr_inactive_pages / priority;
 	nr_pages = shrink_cache(nr_pages, max_scan, classzone, gfp_mask);
 	if (nr_pages <= 0)
 		return 0;
@@ -558,17 +566,28 @@
 
 int try_to_free_pages(zone_t * classzone, unsigned int gfp_mask, unsigned int order)
 {
-	int priority = DEF_PRIORITY;
-	int ret = 0;
+	int priority, nr_pages, ret = 0;
 
-	do {
-		int nr_pages = SWAP_CLUSTER_MAX;
-		nr_pages = shrink_caches(priority, classzone, gfp_mask, nr_pages);
-		if (nr_pages <= 0)
-			return 1;
+	for (;;) {
+		priority = DEF_PRIORITY;
+		nr_pages = SWAP_CLUSTER_MAX;
+
+		do {
+			nr_pages = shrink_caches(priority, classzone, gfp_mask, nr_pages);
+			if (nr_pages <= 0)
+				return 1;
+
+			ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
+		} while (--priority);
 
-		ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
-	} while (--priority);
+		if (likely(ret))
+			break;
+		if (likely(current->pid != 1))
+			break;
+		current->policy |= SCHED_YIELD;
+		__set_current_state(TASK_RUNNING);
+		schedule();
+	}
 
 	return ret;
 }

Andrea
