Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVBHQ1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVBHQ1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVBHQ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:27:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:27146 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261575AbVBHQ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:27:37 -0500
Date: Tue, 8 Feb 2005 16:26:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
In-Reply-To: <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> 
    <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005, Hugh Dickins wrote:
> On Thu, 3 Feb 2005, IWAMOTO Toshihiro wrote:
> > The current implementation of memory hotremoval relies on that pages
> > can be unmapped from process spaces.  After successful unmapping,
> > subsequent accesses to the pages are blocked and don't interfere
> > the hotremoval operation.
> > 
> > However, this code
> > 
> >         if (PageSwapCache(page) &&
> >             page_count(page) != page_mapcount(page) + 2) {
> >                 ret = SWAP_FAIL;
> >                 goto out_unmap;
> >         }
> 
> Yes, that is odd code.  It would be nice to have a solution without it.
> 
> > in try_to_unmap_one() prevents unmapping pages that are referenced via
> > get_user_pages(), and such references can be held for a long time if
> > they are due to such as direct IO.
> > I've made a test program that issues multiple direct IO read requests
> > against a single read buffer, and pages that belong to the buffer
> > cannot be hotremoved because they aren't unmapped.
> 
> ....
> 
> I was hoping to append my own patch to this response, but I haven't
> got it working right yet (swap seems too full).  I hope tomorrow,
> but thought I'd better not delay these comments any longer.

Seems it was okay after all, I got confused by an unrelated issue.
Here's what I had in mind, what do you think?  Does it indeed help
with your problem?  I'm copying Andrea because it was he who devised
that fix to the get_user_pages issue, and also (I think, longer ago)
can_share_swap_page itself.

This does rely on us moving 1 from mapcount to swapcount or back only
while page is locked - there are places (e.g. exit) where mapcount
comes down without page being locked, but that's not an issue: we just
have to be sure that once we have mapcount, it can't go up while reading
swapcount (I've probably changed more than is strictly necessary, but
this seemed clearest to me).

I've left out how we ensure swapoff makes progress on a page with high
mapcount, haven't quite made my mind out about that: it's less of an
issue now there's an activate_page in unuse_pte, plus it's not an
issue which will much bother anyone but me, can wait until after.

That PageAnon check in do_wp_page: seems worthwhile to avoid locking
and unlocking the page if it's a file page, leaves can_share_swap_page
simpler (a PageReserved is never PageAnon).  But the patch is against
2.6.11-rc3-mm1, so I appear to be breaking the intention of
do_wp_page_mk_pte_writable ("on a shared-writable page"),
believe that's already broken but need to study it more.

Hugh

--- 2.6.11-rc3-mm1/mm/memory.c	2005-02-05 07:09:40.000000000 +0000
+++ linux/mm/memory.c	2005-02-07 19:50:47.000000000 +0000
@@ -1339,7 +1339,7 @@ static int do_wp_page(struct mm_struct *
 	}
 	old_page = pfn_to_page(pfn);
 
-	if (!TestSetPageLocked(old_page)) {
+	if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
 		int reuse = can_share_swap_page(old_page);
 		unlock_page(old_page);
 		if (reuse) {
@@ -1779,10 +1779,6 @@ static int do_swap_page(struct mm_struct
 	}
 
 	/* The page isn't present yet, go ahead with the fault. */
-		
-	swap_free(entry);
-	if (vm_swap_full())
-		remove_exclusive_swap_page(page);
 
 	mm->rss++;
 	pte = mk_pte(page, vma->vm_page_prot);
@@ -1790,12 +1786,16 @@ static int do_swap_page(struct mm_struct
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 		write_access = 0;
 	}
-	unlock_page(page);
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 
+	swap_free(entry);
+	if (vm_swap_full())
+		remove_exclusive_swap_page(page);
+	unlock_page(page);
+
 	if (write_access) {
 		if (do_wp_page(mm, vma, address,
 				page_table, pmd, pte) == VM_FAULT_OOM)
--- 2.6.11-rc3-mm1/mm/rmap.c	2005-02-05 07:09:40.000000000 +0000
+++ linux/mm/rmap.c	2005-02-07 12:59:21.000000000 +0000
@@ -551,27 +551,6 @@ static int try_to_unmap_one(struct page 
 		goto out_unmap;
 	}
 
-	/*
-	 * Don't pull an anonymous page out from under get_user_pages.
-	 * GUP carefully breaks COW and raises page count (while holding
-	 * page_table_lock, as we have here) to make sure that the page
-	 * cannot be freed.  If we unmap that page here, a user write
-	 * access to the virtual address will bring back the page, but
-	 * its raised count will (ironically) be taken to mean it's not
-	 * an exclusive swap page, do_wp_page will replace it by a copy
-	 * page, and the user never get to see the data GUP was holding
-	 * the original page for.
-	 *
-	 * This test is also useful for when swapoff (unuse_process) has
-	 * to drop page lock: its reference to the page stops existing
-	 * ptes from being unmapped, so swapoff can make progress.
-	 */
-	if (PageSwapCache(page) &&
-	    page_count(page) != page_mapcount(page) + 2) {
-		ret = SWAP_FAIL;
-		goto out_unmap;
-	}
-
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
 	pteval = ptep_clear_flush(vma, address, pte);
--- 2.6.11-rc3-mm1/mm/swapfile.c	2005-02-05 07:09:40.000000000 +0000
+++ linux/mm/swapfile.c	2005-02-07 19:48:50.000000000 +0000
@@ -257,61 +257,37 @@ void swap_free(swp_entry_t entry)
 }
 
 /*
- * Check if we're the only user of a swap page,
- * when the page is locked.
+ * How many references to page are currently swapped out?
  */
-static int exclusive_swap_page(struct page *page)
+static inline int page_swapcount(struct page *page)
 {
-	int retval = 0;
-	struct swap_info_struct * p;
+	int count = 0;
+	struct swap_info_struct *p;
 	swp_entry_t entry;
 
 	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (p) {
-		/* Is the only swap cache user the cache itself? */
-		if (p->swap_map[swp_offset(entry)] == 1) {
-			/* Recheck the page count with the swapcache lock held.. */
-			write_lock_irq(&swapper_space.tree_lock);
-			if (page_count(page) == 2)
-				retval = 1;
-			write_unlock_irq(&swapper_space.tree_lock);
-		}
+		/* Subtract the 1 for the swap cache itself */
+		count = p->swap_map[swp_offset(entry)] - 1;
 		swap_info_put(p);
 	}
-	return retval;
+	return count;
 }
 
 /*
  * We can use this swap cache entry directly
  * if there are no other references to it.
- *
- * Here "exclusive_swap_page()" does the real
- * work, but we opportunistically check whether
- * we need to get all the locks first..
  */
 int can_share_swap_page(struct page *page)
 {
-	int retval = 0;
+	int count;
 
-	if (!PageLocked(page))
-		BUG();
-	switch (page_count(page)) {
-	case 3:
-		if (!PagePrivate(page))
-			break;
-		/* Fallthrough */
-	case 2:
-		if (!PageSwapCache(page))
-			break;
-		retval = exclusive_swap_page(page);
-		break;
-	case 1:
-		if (PageReserved(page))
-			break;
-		retval = 1;
-	}
-	return retval;
+	BUG_ON(!PageLocked(page));
+	count = page_mapcount(page);
+	if (count <= 1 && PageSwapCache(page))
+		count += page_swapcount(page);
+	return count == 1;
 }
 
 /*
