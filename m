Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264403AbSIQRPT>; Tue, 17 Sep 2002 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264404AbSIQRPT>; Tue, 17 Sep 2002 13:15:19 -0400
Received: from dsl-213-023-022-077.arcor-ip.net ([213.23.22.77]:35968 "EHLO
	starship") by vger.kernel.org with ESMTP id <S264403AbSIQRPL>;
	Tue, 17 Sep 2002 13:15:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: [CFT] [PATCH] LRU race fix
Date: Tue, 17 Sep 2002 19:03:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17rLku-00008F-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.4.20-pre7 fixes a theoretical race where a page could
possibly be freed while still on the lru list.  The details have been
discussed at length earlier, see "[RFC] [PATCH] Include LRU in page count".

The race may not even be that theoretical, it's just so rare that when it
does happen, it might be dismissed as a driver problem or similar.  The
symptom will be "kernel BUG at /mm/page_alloc:95", or it would be if there
was not code there to try and work around the bug.  Unfortunately the code
there does not fix the race, as was shown by Christian Ehrhardt and Andrew
Morton.  Various other things have been done over the last two years that
have the net effect of making the race very rare, but it cannot be proven
to be gone.

This patch gets rid of that race.  That doesn't mean the patch is correct.
:-)

So this is a call for testing.  Please apply and give it a workout.  I
have booted this on my laptop and I tested a similar patch against 2.4.18
fairly heavily on a dual processor server.  Your machine is unlikely to
fail to boot with it, but all the same, please don't run it on a
production machine just yet.  According to my own testing the new code
is not any slower than the existing code, and maybe a little faster.  It's
hard to tell.

This needs a real workout, preferably with heavy swap load and on multiple
cpu machines.  The single cpu case also needs testing, but the heavy load
is where it gets interesting.

Marcelo, note that I exported __lru_cache_del because page_cache_release
is an inline and now calls __lru_cache_del.  I doubt that is how you want
it, so please take a look.

-- 
Daniel

--- 2.4.20-pre7.clean/include/linux/mm.h	2002-08-03 02:39:45.000000000 +0200
+++ 2.4.20-pre7/include/linux/mm.h	2002-09-17 13:53:18.000000000 +0200
@@ -180,6 +180,15 @@
 } mem_map_t;
 
 /*
+ * There is only one 'core' page-freeing function.
+ */
+extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
+extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
+
+#define __free_page(page) __free_pages((page), 0)
+#define free_page(addr) free_pages((addr),0)
+
+/*
  * Methods to modify the page usage count.
  *
  * What counts for a page usage:
@@ -191,12 +200,33 @@
  * Also, many kernel routines increase the page count before a critical
  * routine so they can be sure the page doesn't go away from under them.
  */
-#define get_page(p)		atomic_inc(&(p)->count)
-#define put_page(p)		__free_page(p)
-#define put_page_testzero(p) 	atomic_dec_and_test(&(p)->count)
 #define page_count(p)		atomic_read(&(p)->count)
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)
 
+extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
+
+static inline void get_page(struct page *page)
+{
+	atomic_inc(&page->count);
+}
+
+static inline void put_page_nofree(struct page *page)
+{
+	BUG_ON(!page_count(page));
+	atomic_dec(&page->count);
+}
+
+static inline int put_page_testzero(struct page *page)
+{
+	BUG_ON(!page_count(page));
+	return atomic_dec_and_test(&page->count);
+}
+
+static inline void put_page(struct page *page)
+{
+	__free_page(page);
+}
+
 /*
  * Various page->flags bits:
  *
@@ -394,8 +424,8 @@
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
 
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
-#define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
-#define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
+#define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
+#define ClearPageLRU(page)	clear_bit(PG_lru, &(page)->flags)
 
 #ifdef CONFIG_HIGHMEM
 #define PageHighMem(page)		test_bit(PG_highmem, &(page)->flags)
@@ -451,15 +481,6 @@
  */
 #define get_free_page get_zeroed_page
 
-/*
- * There is only one 'core' page-freeing function.
- */
-extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
-extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
-
-#define __free_page(page) __free_pages((page), 0)
-#define free_page(addr) free_pages((addr),0)
-
 extern void show_free_areas(void);
 extern void show_free_areas_node(pg_data_t *pgdat);
 
@@ -519,11 +540,6 @@
 extern struct address_space swapper_space;
 #define PageSwapCache(page) ((page)->mapping == &swapper_space)
 
-static inline int is_page_cache_freeable(struct page * page)
-{
-	return page_count(page) - !!page->buffers == 1;
-}
-
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
 
--- 2.4.20-pre7.clean/include/linux/pagemap.h	2002-09-17 13:50:07.000000000 +0200
+++ 2.4.20-pre7/include/linux/pagemap.h	2002-09-17 13:53:38.000000000 +0200
@@ -27,9 +27,32 @@
 #define PAGE_CACHE_SIZE		PAGE_SIZE
 #define PAGE_CACHE_MASK		PAGE_MASK
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
+#define LRU_PLUS_CACHE 2
 
 #define page_cache_get(x)	get_page(x)
-#define page_cache_release(x)	__free_page(x)
+
+void show_stack(unsigned long * esp);
+
+static inline void page_cache_release(struct page *page)
+{
+	if (page_count(page) == 2) {
+		spin_lock(&pagemap_lru_lock);
+		if (PageLRU(page) && page_count(page) == 2)
+			__lru_cache_del(page);
+		spin_unlock(&pagemap_lru_lock);
+	}
+	put_page(page);
+}
+
+static inline int has_buffers(struct page *page)
+{
+	return !!page->buffers;
+}
+
+static inline int is_page_cache_freeable(struct page *page)
+{
+	return page_count(page) - has_buffers(page) == LRU_PLUS_CACHE;
+}
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
--- 2.4.20-pre7.clean/include/linux/swap.h	2002-09-17 13:50:08.000000000 +0200
+++ 2.4.20-pre7/include/linux/swap.h	2002-09-17 13:53:18.000000000 +0200
@@ -169,17 +169,9 @@
  * List add/del helper macros. These must be called
  * with the pagemap_lru_lock held!
  */
-#define DEBUG_LRU_PAGE(page)			\
-do {						\
-	if (!PageLRU(page))			\
-		BUG();				\
-	if (PageActive(page))			\
-		BUG();				\
-} while (0)
-
 #define add_page_to_active_list(page)		\
 do {						\
-	DEBUG_LRU_PAGE(page);			\
+	BUG_ON(PageActive(page));		\
 	SetPageActive(page);			\
 	list_add(&(page)->lru, &active_list);	\
 	nr_active_pages++;			\
@@ -187,13 +179,13 @@
 
 #define add_page_to_inactive_list(page)		\
 do {						\
-	DEBUG_LRU_PAGE(page);			\
 	list_add(&(page)->lru, &inactive_list);	\
 	nr_inactive_pages++;			\
 } while (0)
 
 #define del_page_from_active_list(page)		\
 do {						\
+	BUG_ON(!PageActive(page));		\
 	list_del(&(page)->lru);			\
 	ClearPageActive(page);			\
 	nr_active_pages--;			\
--- 2.4.20-pre7.clean/kernel/ksyms.c	2002-09-17 13:50:10.000000000 +0200
+++ 2.4.20-pre7/kernel/ksyms.c	2002-09-17 17:56:54.000000000 +0200
@@ -96,6 +96,7 @@
 EXPORT_SYMBOL(__get_free_pages);
 EXPORT_SYMBOL(get_zeroed_page);
 EXPORT_SYMBOL(__free_pages);
+EXPORT_SYMBOL(__lru_cache_del); /* don't export me */
 EXPORT_SYMBOL(free_pages);
 EXPORT_SYMBOL(num_physpages);
 EXPORT_SYMBOL(kmem_find_general_cachep);
--- 2.4.20-pre7.clean/mm/filemap.c	2002-09-17 13:50:11.000000000 +0200
+++ 2.4.20-pre7/mm/filemap.c	2002-09-17 13:43:27.000000000 +0200
@@ -201,13 +201,13 @@
 		if (page->buffers && !try_to_free_buffers(page, 0))
 			goto unlock;
 
-		if (page_count(page) != 1)
+		if (page_count(page) != LRU_PLUS_CACHE)
 			goto unlock;
 
 		__lru_cache_del(page);
 		__remove_inode_page(page);
 		UnlockPage(page);
-		page_cache_release(page);
+		put_page(page);
 		continue;
 unlock:
 		UnlockPage(page);
@@ -348,7 +348,7 @@
 	 * The page is locked and we hold the pagecache_lock as well
 	 * so both page_count(page) and page->buffers stays constant here.
 	 */
-	if (page_count(page) == 1 + !!page->buffers) {
+	if (is_page_cache_freeable(page)) {
 		/* Restart after this page */
 		list_del(head);
 		list_add_tail(head, curr);
--- 2.4.20-pre7.clean/mm/page_alloc.c	2002-09-17 13:50:11.000000000 +0200
+++ 2.4.20-pre7/mm/page_alloc.c	2002-09-17 18:24:52.000000000 +0200
@@ -86,16 +86,7 @@
 	struct page *base;
 	zone_t *zone;
 
-	/*
-	 * Yes, think what happens when other parts of the kernel take 
-	 * a reference to a page in order to pin it for io. -ben
-	 */
-	if (PageLRU(page)) {
-		if (unlikely(in_interrupt()))
-			BUG();
-		lru_cache_del(page);
-	}
-
+	BUG_ON(PageLRU(page));
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
--- 2.4.20-pre7.clean/mm/swap.c	2002-09-17 13:50:11.000000000 +0200
+++ 2.4.20-pre7/mm/swap.c	2002-09-17 13:47:48.000000000 +0200
@@ -57,12 +57,13 @@
  */
 void lru_cache_add(struct page * page)
 {
-	if (!PageLRU(page)) {
-		spin_lock(&pagemap_lru_lock);
-		if (!TestSetPageLRU(page))
-			add_page_to_inactive_list(page);
-		spin_unlock(&pagemap_lru_lock);
+	spin_lock(&pagemap_lru_lock);
+	if (likely(!PageLRU(page))) {
+		add_page_to_inactive_list(page);
+		SetPageLRU(page);
+		get_page(page);
 	}
+	spin_unlock(&pagemap_lru_lock);
 }
 
 /**
@@ -74,13 +75,13 @@
  */
 void __lru_cache_del(struct page * page)
 {
-	if (TestClearPageLRU(page)) {
-		if (PageActive(page)) {
-			del_page_from_active_list(page);
-		} else {
-			del_page_from_inactive_list(page);
-		}
-	}
+	BUG_ON(!PageLRU(page));
+	if (PageActive(page))
+		del_page_from_active_list(page);
+	else
+		del_page_from_inactive_list(page);
+	ClearPageLRU(page);
+	put_page_nofree(page);
 }
 
 /**
--- 2.4.20-pre7.clean/mm/swapfile.c	2002-08-03 02:39:46.000000000 +0200
+++ 2.4.20-pre7/mm/swapfile.c	2002-09-17 13:43:27.000000000 +0200
@@ -239,7 +239,7 @@
 		if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
 			spin_lock(&pagecache_lock);
-			if (page_count(page) - !!page->buffers == 2)
+			if (page_count(page) - has_buffers(page) == LRU_PLUS_CACHE + 1)
 				retval = 1;
 			spin_unlock(&pagecache_lock);
 		}
@@ -263,16 +263,16 @@
 	if (!PageLocked(page))
 		BUG();
 	switch (page_count(page)) {
-	case 3:
-		if (!page->buffers)
+	case LRU_PLUS_CACHE + 2:
+		if (!has_buffers(page))
 			break;
 		/* Fallthrough */
-	case 2:
+	case LRU_PLUS_CACHE + 1:
 		if (!PageSwapCache(page))
 			break;
 		retval = exclusive_swap_page(page);
 		break;
-	case 1:
+	case LRU_PLUS_CACHE:
 		if (PageReserved(page))
 			break;
 		retval = 1;
@@ -280,6 +280,11 @@
 	return retval;
 }
 
+static inline int only_cached(struct page *page)
+{
+	return page_count(page) - has_buffers(page) == LRU_PLUS_CACHE + 1;
+}
+
 /*
  * Work out if there are any other processes sharing this
  * swap cache page. Free it if you can. Return success.
@@ -294,7 +299,7 @@
 		BUG();
 	if (!PageSwapCache(page))
 		return 0;
-	if (page_count(page) - !!page->buffers != 2)	/* 2: us + cache */
+	if (!only_cached(page))
 		return 0;
 
 	entry.val = page->index;
@@ -307,7 +312,7 @@
 	if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
 		spin_lock(&pagecache_lock);
-		if (page_count(page) - !!page->buffers == 2) {
+		if (only_cached(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
@@ -343,7 +348,7 @@
 	if (page) {
 		page_cache_get(page);
 		/* Only cache user (+us), or swap space full? Free it! */
-		if (page_count(page) - !!page->buffers == 2 || vm_swap_full()) {
+		if (only_cached(page) || vm_swap_full()) {
 			delete_from_swap_cache(page);
 			SetPageDirty(page);
 		}
--- 2.4.20-pre7.clean/mm/vmscan.c	2002-09-17 13:50:11.000000000 +0200
+++ 2.4.20-pre7/mm/vmscan.c	2002-09-17 13:43:27.000000000 +0200
@@ -92,7 +92,7 @@
 		mm->rss--;
 		UnlockPage(page);
 		{
-			int freeable = page_count(page) - !!page->buffers <= 2;
+			int freeable = page_count(page) - has_buffers(page) <= LRU_PLUS_CACHE + 1;
 			page_cache_release(page);
 			return freeable;
 		}
@@ -357,22 +357,26 @@
 
 		BUG_ON(!PageLRU(page));
 		BUG_ON(PageActive(page));
+		BUG_ON(!page_count(page));
 
 		list_del(entry);
-		list_add(entry, &inactive_list);
 
-		/*
-		 * Zero page counts can happen because we unlink the pages
-		 * _after_ decrementing the usage count..
-		 */
-		if (unlikely(!page_count(page)))
-			continue;
+		if (unlikely(page_count(page) == 1)) {
+			BUG_ON(!PageLRU(page));
+			ClearPageLRU(page);
+			put_page(page);
+			if (--nr_pages)
+				continue;
+			break;
+		}
+
+		list_add(entry, &inactive_list);
 
 		if (!memclass(page_zone(page), classzone))
 			continue;
 
 		/* Racy check to avoid trylocking when not worthwhile */
-		if (!page->buffers && (page_count(page) != 1 || !page->mapping))
+		if (!page->buffers && (page_count(page) != LRU_PLUS_CACHE || !page->mapping))
 			goto page_mapped;
 
 		/*
@@ -422,10 +426,10 @@
 		 * the page as well.
 		 */
 		if (page->buffers) {
-			spin_unlock(&pagemap_lru_lock);
-
 			/* avoid to free a locked page */
-			page_cache_get(page);
+			get_page(page);
+
+			spin_unlock(&pagemap_lru_lock);
 
 			if (try_to_release_page(page, gfp_mask)) {
 				if (!page->mapping) {
@@ -438,9 +442,7 @@
 					spin_lock(&pagemap_lru_lock);
 					UnlockPage(page);
 					__lru_cache_del(page);
-
-					/* effectively free the page here */
-					page_cache_release(page);
+					put_page(page);
 
 					if (--nr_pages)
 						continue;
@@ -451,15 +453,13 @@
 					 * before the try_to_release_page since we've not
 					 * finished and we can now try the next step.
 					 */
-					page_cache_release(page);
-
 					spin_lock(&pagemap_lru_lock);
+					put_page_nofree(page);
 				}
 			} else {
 				/* failed to drop the buffers so stop here */
 				UnlockPage(page);
 				page_cache_release(page);
-
 				spin_lock(&pagemap_lru_lock);
 				continue;
 			}
@@ -510,9 +510,7 @@
 
 		__lru_cache_del(page);
 		UnlockPage(page);
-
-		/* effectively free the page here */
-		page_cache_release(page);
+		put_page(page);
 
 		if (--nr_pages)
 			continue;
