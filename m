Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSHKH2j>; Sun, 11 Aug 2002 03:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSHKH2U>; Sun, 11 Aug 2002 03:28:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37638 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318060AbSHKHZr>;
	Sun, 11 Aug 2002 03:25:47 -0400
Message-ID: <3D5614AD.4F3EA16C@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 12/21] wrapup of LRU locking changes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Some fallout from the pagemap_lru_lock changes:

- lru_cache_del() is no longer used.  Kill it.

- page_cache_release() almost never actually frees pages.  So inline
  page_cache_release() and move its rarely-called slow path into (the
  misnamed) mm/swap.c

- update the locking comment in filemap.c.  pagemap_lru_lock used to
  be one of the outermost locks in the VM locking hierarchy.  Now, we
  never take any other locks while holding pagemap_lru_lock.  So it
  doesn't have any relationship with anything.

- put_page() now removes pages from the LRU on the final put.  The
  lock is interrupt save.




 include/linux/mm.h      |    7 ++++++-
 include/linux/pagemap.h |    8 ++++++--
 include/linux/swap.h    |    2 --
 kernel/ksyms.c          |    2 +-
 mm/filemap.c            |    1 -
 mm/page_alloc.c         |   20 +-------------------
 mm/swap.c               |   31 ++++++++++++-------------------
 mm/vmscan.c             |    6 ++++++
 8 files changed, 32 insertions(+), 45 deletions(-)

--- 2.5.31/mm/swap.c~lru-mopup	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/swap.c	Sun Aug 11 00:21:01 2002
@@ -60,32 +60,25 @@ void lru_cache_add(struct page * page)
 	}
 }
 
-/**
- * __lru_cache_del: remove a page from the page lists
- * @page: the page to add
- *
- * This function is for when the caller already holds
- * the pagemap_lru_lock.
+/*
+ * This path almost never happens - pages are normally freed via pagevecs.
  */
-void __lru_cache_del(struct page * page)
+void __page_cache_release(struct page *page)
 {
-	if (TestClearPageLRU(page)) {
+	BUG_ON(page_count(page) != 0);
+	if (PageLRU(page)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&_pagemap_lru_lock, flags);
+		if (!TestClearPageLRU(page))
+			BUG();
 		if (PageActive(page))
 			del_page_from_active_list(page);
 		else
 			del_page_from_inactive_list(page);
+		spin_unlock_irqrestore(&_pagemap_lru_lock, flags);
 	}
-}
-
-/**
- * lru_cache_del: remove a page from the page lists
- * @page: the page to remove
- */
-void lru_cache_del(struct page * page)
-{
-	spin_lock_irq(&_pagemap_lru_lock);
-	__lru_cache_del(page);
-	spin_unlock_irq(&_pagemap_lru_lock);
+	__free_page(page);
 }
 
 /*
--- 2.5.31/include/linux/swap.h~lru-mopup	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/swap.h	Sun Aug 11 00:21:01 2002
@@ -157,8 +157,6 @@ extern int FASTCALL(page_over_rsslimit(s
 
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
-extern void FASTCALL(__lru_cache_del(struct page *));
-extern void FASTCALL(lru_cache_del(struct page *));
 
 extern void FASTCALL(activate_page(struct page *));
 
--- 2.5.31/mm/page_alloc.c~lru-mopup	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/page_alloc.c	Sun Aug 11 00:21:01 2002
@@ -90,6 +90,7 @@ static void __free_pages_ok (struct page
 
 	KERNEL_STAT_ADD(pgfree, 1<<order);
 
+	BUG_ON(PageLRU(page));
 	BUG_ON(PagePrivate(page));
 	BUG_ON(page->mapping != NULL);
 	BUG_ON(PageLocked(page));
@@ -450,25 +451,6 @@ unsigned long get_zeroed_page(unsigned i
 	return 0;
 }
 
-void page_cache_release(struct page *page)
-{
-	/*
-	 * FIXME: this PageReserved test is really expensive
-	 */
-	if (!PageReserved(page) && put_page_testzero(page)) {
-		/*
-		 * This path almost never happens - pages are normally freed
-		 * via pagevecs.
-		 */
-		struct pagevec pvec;
-
-		page_cache_get(page);
-		pvec.nr = 1;
-		pvec.pages[0] = page;
-		__pagevec_release(&pvec);
-	}
-}
-
 void __pagevec_free(struct pagevec *pvec)
 {
 	int i = pagevec_count(pvec);
--- 2.5.31/include/linux/pagemap.h~lru-mopup	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/pagemap.h	Sun Aug 11 00:20:33 2002
@@ -23,14 +23,18 @@
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
 
 #define page_cache_get(x)	get_page(x)
-extern void FASTCALL(page_cache_release(struct page *));
+
+static inline void page_cache_release(struct page *page)
+{
+	if (!PageReserved(page) && put_page_testzero(page))
+		__page_cache_release(page);
+}
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return alloc_pages(x->gfp_mask, 0);
 }
 
-
 typedef int filler_t(void *, struct page *);
 
 extern struct page * find_get_page(struct address_space *mapping,
--- 2.5.31/kernel/ksyms.c~lru-mopup	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/kernel/ksyms.c	Sun Aug 11 00:20:33 2002
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(__alloc_pages);
 EXPORT_SYMBOL(alloc_pages_node);
 EXPORT_SYMBOL(__get_free_pages);
 EXPORT_SYMBOL(get_zeroed_page);
-EXPORT_SYMBOL(page_cache_release);
+EXPORT_SYMBOL(__page_cache_release);
 EXPORT_SYMBOL(__free_pages);
 EXPORT_SYMBOL(free_pages);
 EXPORT_SYMBOL(num_physpages);
--- 2.5.31/mm/filemap.c~lru-mopup	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:21:01 2002
@@ -53,7 +53,6 @@
 /*
  * Lock ordering:
  *
- *  pagemap_lru_lock
  *  ->i_shared_lock		(vmtruncate)
  *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
  *      ->swap_list_lock
--- 2.5.31/include/linux/mm.h~lru-mopup	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/mm.h	Sun Aug 11 00:21:01 2002
@@ -194,11 +194,16 @@ struct page {
  * routine so they can be sure the page doesn't go away from under them.
  */
 #define get_page(p)		atomic_inc(&(p)->count)
-#define put_page(p)		__free_page(p)
 #define __put_page(p)		atomic_dec(&(p)->count)
 #define put_page_testzero(p) 	atomic_dec_and_test(&(p)->count)
 #define page_count(p)		atomic_read(&(p)->count)
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)
+extern void FASTCALL(__page_cache_release(struct page *));
+#define put_page(p)					\
+	do {						\
+		if (put_page_testzero(p))		\
+			__page_cache_release(p);	\
+	} while (0)
 
 /*
  * Multiple processes may "see" the same page. E.g. for untouched
--- 2.5.31/mm/vmscan.c~lru-mopup	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sun Aug 11 00:21:01 2002
@@ -165,6 +165,12 @@ shrink_list(struct list_head *page_list,
 		pte_chain_unlock(page);
 		mapping = page->mapping;
 
+		/*
+		 * FIXME: this is CPU-inefficient for shared mappings.
+		 * try_to_unmap() will set the page dirty and ->vm_writeback
+		 * will write it.  So we're back to page-at-a-time writepage
+		 * in LRU order.
+		 */
 		if (PageDirty(page) && is_page_cache_freeable(page) &&
 					mapping && may_enter_fs) {
 			int (*writeback)(struct page *, int *);

.
