Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWANPzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWANPzY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWANPzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:55:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:25520 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932257AbWANPzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:55:23 -0500
Date: Sat, 14 Jan 2006 16:55:17 +0100
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Race in new page migration code?
Message-ID: <20060114155517.GA30543@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I'm fairly sure there is a race in the page migration code
due to your not taking a reference on the page. Taking the
reference also can make things less convoluted.

Also, an unsuccessful isolation attempt does not mean something is
wrong. I removed the WARN_ON, but you should probably be retrying
on this level if you are really interested in migrating all pages.

Patch is not yet tested with page migration.

Nick

--
Migration code currently does not take a reference to target page
properly, so between unlocking the pte and trying to take a new
reference to the page with isolate_lru_page, anything could happen to
it.

Index: linux-2.6/mm/mempolicy.c
===================================================================
--- linux-2.6.orig/mm/mempolicy.c
+++ linux-2.6/mm/mempolicy.c
@@ -217,6 +217,7 @@ static int check_pte_range(struct vm_are
 		if (flags & MPOL_MF_STATS)
 			gather_stats(page, private);
 		else if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+			get_page(page);
 			spin_unlock(ptl);
 			migrate_page_add(vma, page, private, flags);
 			spin_lock(ptl);
@@ -544,7 +545,8 @@ out:
 }
 
 /*
- * Add a page to be migrated to the pagelist
+ * Add a page to be migrated to the pagelist.
+ * Caller must hold a reference on the page.
  */
 static void migrate_page_add(struct vm_area_struct *vma,
 	struct page *page, struct list_head *pagelist, unsigned long flags)
@@ -555,15 +557,10 @@ static void migrate_page_add(struct vm_a
 	if ((flags & MPOL_MF_MOVE_ALL) || !page->mapping || PageAnon(page) ||
 	    mapping_writably_mapped(page->mapping) ||
 	    single_mm_mapping(vma->vm_mm, page->mapping)) {
-		int rc = isolate_lru_page(page);
-
-		if (rc == 1)
+		if (isolate_lru_page(page))
 			list_add(&page->lru, pagelist);
-		/*
-		 * If the isolate attempt was not successful then we just
-		 * encountered an unswappable page. Something must be wrong.
-	 	 */
-		WARN_ON(rc == 0);
+		else
+			put_page(page);
 	}
 }
 
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -586,7 +586,8 @@ static inline void move_to_lru(struct pa
 }
 
 /*
- * Add isolated pages on the list back to the LRU
+ * Add isolated pages on the list back to the LRU, we must hold a reference
+ * to the pages, which is dropped here.
  *
  * returns the number of pages put back.
  */
@@ -773,32 +774,33 @@ static void lru_add_drain_per_cpu(void *
  * Result:
  *  0 = page not on LRU list
  *  1 = page removed from LRU list and added to the specified list.
- * -ENOENT = page is being freed elsewhere.
+ * -ve = error
  */
 int isolate_lru_page(struct page *page)
 {
 	int rc = 0;
 	struct zone *zone = page_zone(page);
 
-redo:
+	if (!PageLRU(page)) {
+		/*
+		 * Maybe this page is still waiting for a cpu to drain it
+		 * from one of the lru lists?
+		 */
+		rc = schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
+		if (!PageLRU(page))
+			goto out;
+	}
+
 	spin_lock_irq(&zone->lru_lock);
-	rc = __isolate_lru_page(page);
-	if (rc == 1) {
+	if (TestClearPageLRU(page)) {
+		rc = 1;
 		if (PageActive(page))
 			del_page_from_active_list(zone, page);
 		else
 			del_page_from_inactive_list(zone, page);
 	}
 	spin_unlock_irq(&zone->lru_lock);
-	if (rc == 0) {
-		/*
-		 * Maybe this page is still waiting for a cpu to drain it
-		 * from one of the lru lists?
-		 */
-		rc = schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
-		if (rc == 0 && PageLRU(page))
-			goto redo;
-	}
+out:
 	return rc;
 }
 #endif
@@ -831,18 +833,20 @@ static int isolate_lru_pages(int nr_to_s
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
-		switch (__isolate_lru_page(page)) {
-		case 1:
-			/* Succeeded to isolate page */
-			list_move(&page->lru, dst);
-			nr_taken++;
-			break;
-		case -ENOENT:
-			/* Not possible to isolate */
-			list_move(&page->lru, src);
-			break;
-		default:
+		if (!TestClearPageLRU(page))
 			BUG();
+		list_del(&page->lru);
+		if (get_page_testone(page)) {
+			/*
+			 * It is being freed elsewhere
+			 */
+			__put_page(page);
+			SetPageLRU(page);
+			list_add(&page->lru, src);
+			continue;
+		} else {
+			list_add(&page->lru, dst);
+			nr_taken++;
 		}
 	}
 
Index: linux-2.6/include/linux/mm_inline.h
===================================================================
--- linux-2.6.orig/include/linux/mm_inline.h
+++ linux-2.6/include/linux/mm_inline.h
@@ -39,24 +39,3 @@ del_page_from_lru(struct zone *zone, str
 	}
 }
 
-/*
- * Isolate one page from the LRU lists.
- *
- * - zone->lru_lock must be held
- */
-static inline int __isolate_lru_page(struct page *page)
-{
-	if (unlikely(!TestClearPageLRU(page)))
-		return 0;
-
-	if (get_page_testone(page)) {
-		/*
-		 * It is being freed elsewhere
-		 */
-		__put_page(page);
-		SetPageLRU(page);
-		return -ENOENT;
-	}
-
-	return 1;
-}
