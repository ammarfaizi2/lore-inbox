Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWBLTq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWBLTq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWBLTq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:46:27 -0500
Received: from silver.veritas.com ([143.127.12.111]:38990 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750898AbWBLTq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:46:27 -0500
Date: Sun, 12 Feb 2006 19:46:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: William Irwin <wli@holomorphy.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] compound page: use page[1].lru
Message-ID: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Feb 2006 19:46:20.0426 (UTC) FILETIME=[FF19CEA0:01C6300C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a compound page has its own put_page_testzero destructor (the only
current example is free_huge_page), that is noted in page[1].mapping of
the compound page.  But that's rather a poor place to keep it: functions
which call set_page_dirty_lock after get_user_pages (e.g. Infiniband's
__ib_umem_release) ought to be checking first, otherwise set_page_dirty
is liable to crash on what's not the address of a struct address_space.

And now I'm about to make that worse: it turns out that every compound
page needs a destructor, so we can no longer rely on hugetlb pages going
their own special way, to avoid further problems of page->mapping reuse.
For example, not many people know that: on 50% of i386 -Os builds, the
first tail page of a compound page purports to be PageAnon (when its
destructor has an odd address), which surprises page_add_file_rmap.

Keep the compound page destructor in page[1].lru.next instead.  And to
free up the common pairing of mapping and index, also move compound page
order from index to lru.prev.  Slab reuses page->lru too: but if we ever
need slab to use compound pages, it can easily stack its use above this.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/hugetlb.c    |    4 ++--
 mm/page_alloc.c |   15 ++++++---------
 mm/swap.c       |    2 +-
 3 files changed, 9 insertions(+), 12 deletions(-)

--- 2.6.16-rc2-git11/mm/hugetlb.c	2006-02-10 12:28:04.000000000 +0000
+++ 2.6.16-rc2-git11+/mm/hugetlb.c	2006-02-10 19:54:44.000000000 +0000
@@ -85,7 +85,7 @@ void free_huge_page(struct page *page)
 	BUG_ON(page_count(page));
 
 	INIT_LIST_HEAD(&page->lru);
-	page[1].mapping = NULL;
+	page[1].lru.next = NULL;			/* reset dtor */
 
 	spin_lock(&hugetlb_lock);
 	enqueue_huge_page(page);
@@ -105,7 +105,7 @@ struct page *alloc_huge_page(struct vm_a
 	}
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
-	page[1].mapping = (void *)free_huge_page;
+	page[1].lru.next = (void *)free_huge_page;	/* set dtor */
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
 		clear_user_highpage(&page[i], addr);
 	return page;
--- 2.6.16-rc2-git11/mm/page_alloc.c	2006-02-10 12:28:04.000000000 +0000
+++ 2.6.16-rc2-git11+/mm/page_alloc.c	2006-02-10 20:03:19.000000000 +0000
@@ -169,20 +169,17 @@ static void bad_page(struct page *page)
  * All pages have PG_compound set.  All pages have their ->private pointing at
  * the head page (even the head page has this).
  *
- * The first tail page's ->mapping, if non-zero, holds the address of the
- * compound page's put_page() function.
- *
- * The order of the allocation is stored in the first tail page's ->index
- * This is only for debug at present.  This usage means that zero-order pages
- * may not be compound.
+ * The first tail page's ->lru.next holds the address of the compound page's
+ * put_page() function.  Its ->lru.prev holds the order of allocation.
+ * This usage means that zero-order pages may not be compound.
  */
 static void prep_compound_page(struct page *page, unsigned long order)
 {
 	int i;
 	int nr_pages = 1 << order;
 
-	page[1].mapping = NULL;
-	page[1].index = order;
+	page[1].lru.next = NULL;			/* set dtor */
+	page[1].lru.prev = (void *)order;
 	for (i = 0; i < nr_pages; i++) {
 		struct page *p = page + i;
 
@@ -196,7 +193,7 @@ static void destroy_compound_page(struct
 	int i;
 	int nr_pages = 1 << order;
 
-	if (unlikely(page[1].index != order))
+	if (unlikely((unsigned long)page[1].lru.prev != order))
 		bad_page(page);
 
 	for (i = 0; i < nr_pages; i++) {
--- 2.6.16-rc2-git11/mm/swap.c	2006-02-10 12:28:04.000000000 +0000
+++ 2.6.16-rc2-git11+/mm/swap.c	2006-02-10 19:54:44.000000000 +0000
@@ -40,7 +40,7 @@ static void put_compound_page(struct pag
 	if (put_page_testzero(page)) {
 		void (*dtor)(struct page *page);
 
-		dtor = (void (*)(struct page *))page[1].mapping;
+		dtor = (void (*)(struct page *))page[1].lru.next;
 		(*dtor)(page);
 	}
 }
