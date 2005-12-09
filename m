Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVLIWJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVLIWJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVLIWJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:09:25 -0500
Received: from silver.veritas.com ([143.127.12.111]:60986 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932453AbVLIWJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:09:25 -0500
Date: Fri, 9 Dec 2005 21:56:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: David Gibson <david@gibson.dropbear.id.au>, Jens Axboe <axboe@suse.de>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       William Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] PageCompound avoid page[1].mapping
Message-ID: <Pine.LNX.4.61.0512092151240.28965@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Dec 2005 22:09:20.0781 (UTC) FILETIME=[348A53D0:01C5FD0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a compound page has its own put_page_testzero destructor (the only
current example is free_huge_page), that is noted in page[1].mapping of
the compound page.  But David Gibson's recent fix to access_process_vm
shows that to be rather a poor place to keep it: functions which call
set_page_dirty(_lock) after get_user_pages ought to check !PageCompound
first, otherwise set_page_dirty may crash on what's not the address of
a struct address_space; but Infiniband for one is unaware of this issue.

Even if we fixed all callers, or set_page_dirty(_lock) itself, it would
still be unsatisfactory: e.g. get_user_pages calls flush_dcache_page,
which involves page->mapping on some architectures - not a problem while
hugetlb goes its own way in get_user_pages, but needs a test if another
compound page destructor were added.  page->mapping is used too widely
to be a safe field to reuse in this way.

The safest field to reuse, given how PageCompound redirects callers to
the page count of the first page, is actually the _count field of the
second page: save order (only used for debug) there, and move destructor
address from mapping to index.  Add __page_count inline for internal
debug use - to avoid reliance on page_private when page is in doubt.

Revert David's mod to access_process_vm, no longer required.  But leave
the PageCompound tests in fs/bio.c and fs/direct-io.c: perhaps those are
worthwhile optimizations when working on hugetlb areas.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/ptrace.c |    3 +--
 mm/hugetlb.c    |    5 ++---
 mm/page_alloc.c |   25 ++++++++++++++++++-------
 mm/swap.c       |    2 +-
 4 files changed, 22 insertions(+), 13 deletions(-)

--- 2.6.15-rc5/kernel/ptrace.c	2005-12-04 06:48:17.000000000 +0000
+++ linux/kernel/ptrace.c	2005-12-09 20:45:21.000000000 +0000
@@ -241,8 +241,7 @@ int access_process_vm(struct task_struct
 		if (write) {
 			copy_to_user_page(vma, page, addr,
 					  maddr + offset, buf, bytes);
-			if (!PageCompound(page))
-				set_page_dirty_lock(page);
+			set_page_dirty_lock(page);
 		} else {
 			copy_from_user_page(vma, page, addr,
 					    buf, maddr + offset, bytes);
--- 2.6.15-rc5/mm/hugetlb.c	2005-12-04 06:48:17.000000000 +0000
+++ linux/mm/hugetlb.c	2005-12-09 20:45:21.000000000 +0000
@@ -78,7 +78,7 @@ void free_huge_page(struct page *page)
 	BUG_ON(page_count(page));
 
 	INIT_LIST_HEAD(&page->lru);
-	page[1].mapping = NULL;
+	page[1].index = 0;		/* reset dtor */
 
 	spin_lock(&hugetlb_lock);
 	enqueue_huge_page(page);
@@ -98,7 +98,7 @@ struct page *alloc_huge_page(void)
 	}
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
-	page[1].mapping = (void *)free_huge_page;
+	page[1].index = (unsigned long)free_huge_page;	/* set dtor */
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
 		clear_highpage(&page[i]);
 	return page;
@@ -147,7 +147,6 @@ static void update_and_free_page(struct 
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
 				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
 				1 << PG_private | 1<< PG_writeback);
-		set_page_count(&page[i], 0);
 	}
 	set_page_count(page, 1);
 	__free_pages(page, HUGETLB_PAGE_ORDER);
--- 2.6.15-rc5/mm/page_alloc.c	2005-12-04 06:48:17.000000000 +0000
+++ linux/mm/page_alloc.c	2005-12-09 20:45:21.000000000 +0000
@@ -122,13 +122,22 @@ static int bad_range(struct zone *zone, 
 	return 0;
 }
 
+/*
+ * Ignore PageCompound when checking page_count for debugging -
+ * page_private might be corrupt; but never expose this to wider use.
+ */
+static inline int __page_count(struct page *page)
+{
+	return atomic_read(&page->_count) + 1;
+}
+
 static void bad_page(const char *function, struct page *page)
 {
 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
 		function, current->comm, page);
 	printk(KERN_EMERG "flags:0x%0*lx mapping:%p mapcount:%d count:%d\n",
 		(int)(2*sizeof(unsigned long)), (unsigned long)page->flags,
-		page->mapping, page_mapcount(page), page_count(page));
+		page->mapping, page_mapcount(page), __page_count(page));
 	printk(KERN_EMERG "Backtrace:\n");
 	dump_stack();
 	printk(KERN_EMERG "Trying to fix it up, but a reboot is needed\n");
@@ -157,10 +166,10 @@ static void bad_page(const char *functio
  * All pages have PG_compound set.  All pages have their ->private pointing at
  * the head page (even the head page has this).
  *
- * The first tail page's ->mapping, if non-zero, holds the address of the
+ * The first tail page's ->index, if non-zero, holds the address of the
  * compound page's put_page() function.
  *
- * The order of the allocation is stored in the first tail page's ->index
+ * The order of the allocation is stored in the first tail page's ->count.
  * This is only for debug at present.  This usage means that zero-order pages
  * may not be compound.
  */
@@ -169,8 +178,9 @@ static void prep_compound_page(struct pa
 	int i;
 	int nr_pages = 1 << order;
 
-	page[1].mapping = NULL;
-	page[1].index = order;
+	set_page_count(&page[1], order);
+	page[1].index = 0;			/* reset dtor */
+
 	for (i = 0; i < nr_pages; i++) {
 		struct page *p = page + i;
 
@@ -187,8 +197,9 @@ static void destroy_compound_page(struct
 	if (!PageCompound(page))
 		return;
 
-	if (page[1].index != order)
+	if (__page_count(&page[1]) != order)
 		bad_page(__FUNCTION__, page);
+	set_page_count(&page[1], 0);
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *p = page + i;
@@ -403,7 +414,7 @@ void __free_pages_ok(struct page *page, 
 
 #ifndef CONFIG_MMU
 	if (order > 0)
-		for (i = 1 ; i < (1 << order) ; ++i)
+		for (i = 1 + PageCompound(page); i < (1 << order); ++i)
 			__put_page(page + i);
 #endif
 
--- 2.6.15-rc5/mm/swap.c	2005-12-04 06:48:17.000000000 +0000
+++ linux/mm/swap.c	2005-12-09 20:45:21.000000000 +0000
@@ -41,7 +41,7 @@ void put_page(struct page *page)
 		if (put_page_testzero(page)) {
 			void (*dtor)(struct page *page);
 
-			dtor = (void (*)(struct page *))page[1].mapping;
+			dtor = (void (*)(struct page *))page[1].index;
 			(*dtor)(page);
 		}
 		return;
