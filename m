Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSIWRwu>; Mon, 23 Sep 2002 13:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261173AbSIWRwu>; Mon, 23 Sep 2002 13:52:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27353 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261281AbSIWRtI>; Mon, 23 Sep 2002 13:49:08 -0400
Date: Mon, 23 Sep 2002 12:24:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Kevin Easton <s3159795@student.anu.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>, <phillips@arcor.de>
Subject: Re: 2.4.19 OOPS in kswapd __remove_from_queues
In-Reply-To: <20020923160908.A28264@beernut.flames.org.au>
Message-ID: <Pine.LNX.4.44.0209231221540.922-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Kevin Easton wrote:

> On a KT333 based machine running EXT3 on software RAID1, I'm seeing kswapd die
> as shown in the included oops.  I've run memtest86 on the machine, and it's
> come up clean in that.  (Unlike recent bug reports of this nature I've been
> able to find on the list, the wild pointer isn't a single-bit-modified null
> pointer).
>
> Sep 23 14:19:27 schubert kernel: Unable to handle kernel paging request at virtual address 42000030
> Sep 23 14:19:27 schubert kernel: c0135061
> Sep 23 14:19:27 schubert kernel: *pde = 00000000
> Sep 23 14:19:27 schubert kernel: Oops: 0002
> Sep 23 14:19:27 schubert kernel: CPU:    0
> Sep 23 14:19:27 schubert kernel: EIP:    0010:[__remove_from_queues+17/48]    Not tainted
> Sep 23 14:19:27 schubert kernel: EFLAGS: 00010206
> Sep 23 14:19:27 schubert kernel: eax: 42000000   ebx: ce94c1c0   ecx: ce94c1c0   edx: 40000000
> Sep 23 14:19:27 schubert kernel: esi: ce94c1c0   edi: ce94c1c0   ebp: c1465118   esp: c15bff24
> Sep 23 14:19:27 schubert kernel: ds: 0018   es: 0018   ss: 0018
> Sep 23 14:19:27 schubert kernel: Process kswapd (pid: 4, stackpage=c15bf000)
> Sep 23 14:19:27 schubert kernel: Stack: c01376cb ce94c1c0 c1465118 000001d0 0000000c 00000200 c0135ba9 ce94c1c0
> Sep 23 14:19:27 schubert kernel:        c1465118 c012d622 c1465118 000001d0 00000020 000001d0 00000020 00000006
> Sep 23 14:19:27 schubert kernel:        00000006 c15be000 00004670 000001d0 c023ec74 c012d876 00000006 00000000
> Sep 23 14:19:27 schubert kernel: Call Trace:    [try_to_free_buffers+91/224] [try_to_release_page+73/80] [shrink_cache+482/768] [shrink_caches+86/128] [try_to_free_pages+60/96]
> Sep 23 14:19:27 schubert kernel: Code: 89 50 30 89 02 c7 41 30 00 00 00 00 51 e8 7d ff ff ff 83 c4
> Using defaults from ksymoops -t elf32-i386 -a i386

> >>eax; 42000000 Before first symbol
> >>ebx; ce94c1c0 <_end+e67a10c/20560f4c>
> >>ecx; ce94c1c0 <_end+e67a10c/20560f4c>
> >>edx; 40000000 Before first symbol
> >>esi; ce94c1c0 <_end+e67a10c/20560f4c>
> >>edi; ce94c1c0 <_end+e67a10c/20560f4c>
> >>ebp; c1465118 <_end+1193064/20560f4c>
> >>esp; c15bff24 <_end+12ede70/20560f4c>
>
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   89 50 30                  mov    %edx,0x30(%eax)
> Code;  00000003 Before first symbol

Kevin,

Can you please try the following patch (against 2.4.20-pre7) from Daniel
Phillips?

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

