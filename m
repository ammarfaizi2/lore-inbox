Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWAOG6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWAOG6e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 01:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWAOG6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 01:58:33 -0500
Received: from mx1.suse.de ([195.135.220.2]:63432 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751878AbWAOG6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 01:58:33 -0500
Date: Sun, 15 Jan 2006 07:58:23 +0100
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
Message-ID: <20060115065822.GA11441@wotan.suse.de>
References: <20060114155517.GA30543@wotan.suse.de> <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com> <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 10:58:25AM -0800, Christoph Lameter wrote:
> On Sat, 14 Jan 2006, Nick Piggin wrote:
> 
> > > We take that reference count on the page:
> > Yes, after you have dropped all your claims to pin this page
> > (ie. pte lock). You really can't take a refcount on a page that
> 
> Oh. Now I see. I screwed that up by a fix I added.... We cannot drop the 
> ptl here. So back to the way it was before. Remove the draining from 
> isolate_lru_page and do it before scanning for pages so that we do not
> have to drop the ptl. 
> 

OK, if you prefer doing it with the pte lock held, how's this patch?

--
Migration code currently does not take a reference to target page
properly, so between unlocking the pte and trying to take a new
reference to the page with isolate_lru_page, anything could happen to
it.

Fix this by holding the pte lock until we get a chance to elevate the
refcount.

Other small cleanups while we're here.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/mempolicy.c
===================================================================
--- linux-2.6.orig/mm/mempolicy.c
+++ linux-2.6/mm/mempolicy.c
@@ -216,11 +216,8 @@ static int check_pte_range(struct vm_are
 
 		if (flags & MPOL_MF_STATS)
 			gather_stats(page, private);
-		else if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
-			spin_unlock(ptl);
+		else if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 			migrate_page_add(vma, page, private, flags);
-			spin_lock(ptl);
-		}
 		else
 			break;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
@@ -309,6 +306,10 @@ check_range(struct mm_struct *mm, unsign
 	int err;
 	struct vm_area_struct *first, *vma, *prev;
 
+	/* Clear the LRU lists so pages can be isolated */
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		lru_add_drain_all();
+
 	first = find_vma(mm, start);
 	if (!first)
 		return ERR_PTR(-EFAULT);
@@ -555,15 +556,8 @@ static void migrate_page_add(struct vm_a
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
 	}
 }
 
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -586,7 +586,7 @@ static inline void move_to_lru(struct pa
 }
 
 /*
- * Add isolated pages on the list back to the LRU
+ * Add isolated pages on the list back to the LRU.
  *
  * returns the number of pages put back.
  */
@@ -760,46 +760,33 @@ next:
 	return nr_failed + retry;
 }
 
-static void lru_add_drain_per_cpu(void *dummy)
-{
-	lru_add_drain();
-}
-
 /*
  * Isolate one page from the LRU lists and put it on the
- * indicated list. Do necessary cache draining if the
- * page is not on the LRU lists yet.
+ * indicated list with elevated refcount.
  *
  * Result:
  *  0 = page not on LRU list
  *  1 = page removed from LRU list and added to the specified list.
- * -ENOENT = page is being freed elsewhere.
  */
 int isolate_lru_page(struct page *page)
 {
-	int rc = 0;
-	struct zone *zone = page_zone(page);
+	int ret = 0;
 
-redo:
-	spin_lock_irq(&zone->lru_lock);
-	rc = __isolate_lru_page(page);
-	if (rc == 1) {
-		if (PageActive(page))
-			del_page_from_active_list(zone, page);
-		else
-			del_page_from_inactive_list(zone, page);
-	}
-	spin_unlock_irq(&zone->lru_lock);
-	if (rc == 0) {
-		/*
-		 * Maybe this page is still waiting for a cpu to drain it
-		 * from one of the lru lists?
-		 */
-		rc = schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
-		if (rc == 0 && PageLRU(page))
-			goto redo;
+	if (PageLRU(page)) {
+		struct zone *zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+		if (TestClearPageLRU(page)) {
+			ret = 1;
+			get_page(page);
+			if (PageActive(page))
+				del_page_from_active_list(zone, page);
+			else
+				del_page_from_inactive_list(zone, page);
+		}
+		spin_unlock_irq(&zone->lru_lock);
 	}
-	return rc;
+
+	return ret;
 }
 #endif
 
@@ -831,18 +818,20 @@ static int isolate_lru_pages(int nr_to_s
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
Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h
+++ linux-2.6/include/linux/swap.h
@@ -167,6 +167,7 @@ extern void FASTCALL(lru_cache_add_activ
 extern void FASTCALL(activate_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
+extern int lru_add_drain_all(void);
 extern int rotate_reclaimable_page(struct page *page);
 extern void swap_setup(void);
 
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -174,6 +174,24 @@ void lru_add_drain(void)
 	put_cpu();
 }
 
+static void lru_add_drain_per_cpu(void *dummy)
+{
+	lru_add_drain();
+}
+
+/*
+ * Returns 0 for success
+ */
+int lru_add_drain_all(void)
+{
+#ifdef CONFIG_SMP
+	return schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
+#else
+	lru_add_drain();
+	return 0;
+#endif
+}
+
 /*
  * This path almost never happens for VM activity - pages are normally
  * freed via pagevecs.  But it gets used by networking.
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -94,6 +94,7 @@ generic_file_direct_IO(int rw, struct ki
  *    ->private_lock		(try_to_unmap_one)
  *    ->tree_lock		(try_to_unmap_one)
  *    ->zone.lru_lock		(follow_page->mark_page_accessed)
+ *    ->zone.lru_lock		(check_pte_range->isolate_lru_page)
  *    ->private_lock		(page_remove_rmap->set_page_dirty)
  *    ->tree_lock		(page_remove_rmap->set_page_dirty)
  *    ->inode_lock		(page_remove_rmap->set_page_dirty)
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -33,7 +33,7 @@
  *     mapping->i_mmap_lock
  *       anon_vma->lock
  *         mm->page_table_lock or pte_lock
- *           zone->lru_lock (in mark_page_accessed)
+ *           zone->lru_lock (in mark_page_accessed, isolate_lru_page)
  *           swap_lock (in swap_duplicate, swap_info_get)
  *             mmlist_lock (in mmput, drain_mmlist and others)
  *             mapping->private_lock (in __set_page_dirty_buffers)
