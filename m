Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVFFUGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVFFUGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVFFUFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:05:22 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25967 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261651AbVFFUAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:00:45 -0400
Date: Mon, 6 Jun 2005 21:00:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, Christoph Lameter <clameter@sgi.com>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Timur Tabi <timur.tabi@ammasso.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] can_share_swap_page: use page_mapcount
In-Reply-To: <Pine.LNX.4.61.0506062055350.5000@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0506062058090.5000@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0506062055350.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:59:49.0270 (UTC) 
    FILETIME=[4B865B60:01C56AD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remember that ironic get_user_pages race?  when the raised page_count on a
page swapped out led do_wp_page to decide that it had to copy on write, so
substituted a different page into userspace.  2.6.7 onwards have Andrea's
solution, where try_to_unmap_one backs out if it finds page_count raised.

Which works, but is unsatisfying (rmap.c has no other page_count heuristics),
and was found a few months ago to hang an intensive page migration test.  A
year ago I was hesitant to engage page_mapcount, now it seems the right fix.

So remove the page_count hack from try_to_unmap_one; and use activate_page
in unuse_mm when dropping lock, to replace its secondary effect of helping
swapoff to make progress in that case.

Simplify can_share_swap_page (now called only on anonymous pages) to check
page_mapcount + page_swapcount == 1: still needs the page lock to stabilize
their (pessimistic) sum, but does not need swapper_space.tree_lock for that.

In do_swap_page, move swap_free and unlock_page below page_add_anon_rmap,
to keep sum on the high side, and correct when can_share_swap_page called.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c   |   10 +++++-----
 mm/rmap.c     |   21 ---------------------
 mm/swapfile.c |   55 ++++++++++++++++---------------------------------------
 3 files changed, 21 insertions(+), 65 deletions(-)

--- 2.6.10-rc6+/mm/memory.c	2005-06-05 11:29:35.000000000 +0100
+++ linux/mm/memory.c	2005-06-05 11:53:31.000000000 +0100
@@ -1711,10 +1711,6 @@ static int do_swap_page(struct mm_struct
 	}
 
 	/* The page isn't present yet, go ahead with the fault. */
-		
-	swap_free(entry);
-	if (vm_swap_full())
-		remove_exclusive_swap_page(page);
 
 	inc_mm_counter(mm, rss);
 	pte = mk_pte(page, vma->vm_page_prot);
@@ -1722,12 +1718,16 @@ static int do_swap_page(struct mm_struct
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 		write_access = 0;
 	}
-	unlock_page(page);
 
 	flush_icache_page(vma, page);
 	set_pte_at(mm, address, page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 
+	swap_free(entry);
+	if (vm_swap_full())
+		remove_exclusive_swap_page(page);
+	unlock_page(page);
+
 	if (write_access) {
 		if (do_wp_page(mm, vma, address,
 				page_table, pmd, pte) == VM_FAULT_OOM)
--- 2.6.10-rc6+/mm/rmap.c	2005-05-25 18:09:21.000000000 +0100
+++ linux/mm/rmap.c	2005-06-05 11:53:31.000000000 +0100
@@ -539,27 +539,6 @@ static int try_to_unmap_one(struct page 
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
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
--- 2.6.12-rc6+/mm/swapfile.c	2005-05-25 18:09:21.000000000 +0100
+++ linux/mm/swapfile.c	2005-06-05 11:53:31.000000000 +0100
@@ -276,61 +276,37 @@ void swap_free(swp_entry_t entry)
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
@@ -529,9 +505,10 @@ static int unuse_mm(struct mm_struct *mm
 
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		/*
-		 * Our reference to the page stops try_to_unmap_one from
-		 * unmapping its ptes, so swapoff can make progress.
+		 * Activate page so shrink_cache is unlikely to unmap its
+		 * ptes while lock is dropped, so swapoff can make progress.
 		 */
+		activate_page(page);
 		unlock_page(page);
 		down_read(&mm->mmap_sem);
 		lock_page(page);
