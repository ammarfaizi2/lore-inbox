Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282683AbRLKSvv>; Tue, 11 Dec 2001 13:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282655AbRLKSvj>; Tue, 11 Dec 2001 13:51:39 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:6664 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282640AbRLKSvY>; Tue, 11 Dec 2001 13:51:24 -0500
Date: Tue, 11 Dec 2001 16:51:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <Pine.LNX.4.21.0112111441170.26181-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0112111647330.1352-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, Marcelo Tosatti wrote:

> > I'll take a stab at completely removing the use-once stuff as an
> > emergency measure.
>
> Could you please make a patch without use-once and post the patch to
> lkml ?
>
> This way people can test it and report performance results.

OK, here's a quick hack to migrate 2.4 to second-chance
replacement. In this implementation that means:

1) for pages in the working set of processes, we keep
   the pages resident whenever we find a referenced
   bit in the page table

2) for pages which are not mapped, we unconditionally
   move the page to the inactive list; the page only
   gets reactivated if it is referenced while on the
   inactive list

This should give us some small protection against use-once
data, since the referenced bit doesn't count, while allowing
us to protect the working set of processes.

It also makes shrinking of the slab-based filesystem caches
unconditional, to prevent bad effects there.

Note that I'm still compiling and haven't tested it yet,
please give it a spin.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/



--- linux-2.4.17-pre8/mm/filemap.c.orig	Tue Dec 11 16:11:16 2001
+++ linux-2.4.17-pre8/mm/filemap.c	Tue Dec 11 16:27:44 2001
@@ -1249,23 +1249,20 @@
 }

 /*
- * Mark a page as having seen activity.
- *
- * If it was already so marked, move it
- * to the active queue and drop the referenced
- * bit. Otherwise, just mark it for future
- * action..
+ * Simple second-chance replacement.
+ * As long as a page is on the active list, further references
+ * are ignored so used-once pages get replaced quickly.
+ * If a page on the inactive list gets referenced or has a
+ * referenced bit in the page table page, it gets moved back
+ * to the far end of the active list.
  */
 void mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page)) {
+	if (PageLRU(page) && !PageActive(page)) {
 		activate_page(page);
 		ClearPageReferenced(page);
 		return;
 	}
-
-	/* Mark the page referenced, AFTER checking for previous usage.. */
-	SetPageReferenced(page);
 }

 /*
--- linux-2.4.17-pre8/mm/swap.c.orig	Tue Dec 11 16:11:16 2001
+++ linux-2.4.17-pre8/mm/swap.c	Tue Dec 11 16:13:11 2001
@@ -59,7 +59,7 @@
 {
 	if (!TestSetPageLRU(page)) {
 		spin_lock(&pagemap_lru_lock);
-		add_page_to_inactive_list(page);
+		add_page_to_active_list(page);
 		spin_unlock(&pagemap_lru_lock);
 	}
 }
--- linux-2.4.17-pre8/mm/vmscan.c.orig	Tue Dec 11 16:11:16 2001
+++ linux-2.4.17-pre8/mm/vmscan.c	Tue Dec 11 16:43:10 2001
@@ -526,10 +526,14 @@

 /*
  * This moves pages from the active list to
- * the inactive list.
+ * the inactive list. If they get referenced
+ * while on the inactive list, they will be
+ * activated again.
  *
- * We move them the other way when we see the
- * reference bit on the page.
+ * Note that we cannot (and don't want to)
+ * clear the referenced bits in the page tables
+ * of pages, so the working sets of processes
+ * have an edge on cache pages.
  */
 static void refill_inactive(int nr_pages)
 {
@@ -542,15 +546,10 @@

 		page = list_entry(entry, struct page, lru);
 		entry = entry->prev;
-		if (PageTestandClearReferenced(page)) {
-			list_del(&page->lru);
-			list_add(&page->lru, &active_list);
-			continue;
-		}

 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
-		SetPageReferenced(page);
+		ClearPageReferenced(page);
 	}
 	spin_unlock(&pagemap_lru_lock);
 }
@@ -570,16 +569,16 @@
 	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
 	refill_inactive(ratio);

-	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
-	if (nr_pages <= 0)
-		return 0;
-
 	shrink_dcache_memory(priority, gfp_mask);
 	shrink_icache_memory(priority, gfp_mask);
 #ifdef CONFIG_QUOTA
 	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
 #endif

+	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
+
+	if (nr_pages <= 0)
+		return 0;
 	return nr_pages;
 }


