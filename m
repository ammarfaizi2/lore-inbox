Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUGLVuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUGLVuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUGLVuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:50:10 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21259 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263770AbUGLVtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:49:50 -0400
Date: Mon, 12 Jul 2004 22:49:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmaplock 1/6 PageAnon in mapping
Message-ID: <Pine.LNX.4.44.0407122248060.4005-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of a batch of six patches, based on 2.6.7-mm7 but applying easily
to 2.6.8-rc1: to eliminate rmap's page_map_lock, replace its trylocking
by spinlocking, and settle a couple of issues noticed on the way.

rmaplock 1/6 PageAnon in mapping

Replace the PG_anon page->flags bit by setting the lower bit of the
pointer in page->mapping when it's anon_vma: PAGE_MAPPING_ANON bit.

We're about to eliminate the locking which kept the flags and mapping
in synch: it's much easier to work on a local copy of page->mapping,
than worry about whether flags and mapping are in synch (though I
imagine it could be done, at greater cost, with some barriers).

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 include/linux/mm.h         |   23 ++++++++++++++++-------
 include/linux/page-flags.h |    6 ------
 mm/page_alloc.c            |    3 ---
 mm/rmap.c                  |   20 +++-----------------
 4 files changed, 19 insertions(+), 33 deletions(-)

--- 2.6.7-mm7/include/linux/mm.h	2004-07-09 10:53:43.000000000 +0100
+++ rmaplock1/include/linux/mm.h	2004-07-12 18:20:07.949982720 +0100
@@ -205,11 +205,12 @@ struct page {
 					 * if PagePrivate set; used for
 					 * swp_entry_t if PageSwapCache
 					 */
-	struct address_space *mapping;	/* If PG_anon clear, points to
+	struct address_space *mapping;	/* If low bit clear, points to
 					 * inode address_space, or NULL.
 					 * If page mapped as anonymous
-					 * memory, PG_anon is set, and
-					 * it points to anon_vma object.
+					 * memory, low bit is set, and
+					 * it points to anon_vma object:
+					 * see PAGE_MAPPING_ANON below.
 					 */
 	pgoff_t index;			/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list
@@ -433,24 +434,32 @@ void page_address_init(void);
 
 /*
  * On an anonymous page mapped into a user virtual memory area,
- * page->mapping points to its anon_vma, not to a struct address_space.
+ * page->mapping points to its anon_vma, not to a struct address_space;
+ * with the PAGE_MAPPING_ANON bit set to distinguish it.
  *
  * Please note that, confusingly, "page_mapping" refers to the inode
  * address_space which maps the page from disk; whereas "page_mapped"
  * refers to user virtual address space into which the page is mapped.
  */
+#define PAGE_MAPPING_ANON	1
+
 extern struct address_space swapper_space;
 static inline struct address_space *page_mapping(struct page *page)
 {
-	struct address_space *mapping = NULL;
+	struct address_space *mapping = page->mapping;
 
 	if (unlikely(PageSwapCache(page)))
 		mapping = &swapper_space;
-	else if (likely(!PageAnon(page)))
-		mapping = page->mapping;
+	else if (unlikely((unsigned long)mapping & PAGE_MAPPING_ANON))
+		mapping = NULL;
 	return mapping;
 }
 
+static inline int PageAnon(struct page *page)
+{
+	return ((unsigned long)page->mapping & PAGE_MAPPING_ANON) != 0;
+}
+
 /*
  * Return the pagecache index of the passed page.  Regular pagecache pages
  * use ->index whereas swapcache pages use ->private
--- 2.6.7-mm7/include/linux/page-flags.h	2004-07-09 10:53:44.000000000 +0100
+++ rmaplock1/include/linux/page-flags.h	2004-07-12 18:20:07.950982568 +0100
@@ -76,8 +76,6 @@
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
 
-#define PG_anon			20	/* Anonymous: anon_vma in mapping */
-
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -292,10 +290,6 @@ extern unsigned long __read_page_state(u
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
-#define PageAnon(page)		test_bit(PG_anon, &(page)->flags)
-#define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
-#define ClearPageAnon(page)	clear_bit(PG_anon, &(page)->flags)
-
 #ifdef CONFIG_SWAP
 #define PageSwapCache(page)	test_bit(PG_swapcache, &(page)->flags)
 #define SetPageSwapCache(page)	set_bit(PG_swapcache, &(page)->flags)
--- 2.6.7-mm7/mm/page_alloc.c	2004-07-09 10:53:46.000000000 +0100
+++ rmaplock1/mm/page_alloc.c	2004-07-12 18:20:07.952982264 +0100
@@ -88,7 +88,6 @@ static void bad_page(const char *functio
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_maplock |
-			1 << PG_anon    |
 			1 << PG_swapcache |
 			1 << PG_writeback);
 	set_page_count(page, 0);
@@ -230,7 +229,6 @@ static inline void free_pages_check(cons
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_maplock |
-			1 << PG_anon    |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(function, page);
@@ -353,7 +351,6 @@ static void prep_new_page(struct page *p
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_maplock |
-			1 << PG_anon    |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(__FUNCTION__, page);
--- 2.6.7-mm7/mm/rmap.c	2004-07-09 10:53:46.000000000 +0100
+++ rmaplock1/mm/rmap.c	2004-07-12 18:20:07.954981960 +0100
@@ -168,7 +168,6 @@ static inline void clear_page_anon(struc
 {
 	BUG_ON(!page->mapping);
 	page->mapping = NULL;
-	ClearPageAnon(page);
 }
 
 /*
@@ -243,7 +242,7 @@ out:
 static inline int page_referenced_anon(struct page *page)
 {
 	unsigned int mapcount = page->mapcount;
-	struct anon_vma *anon_vma = (struct anon_vma *) page->mapping;
+	struct anon_vma *anon_vma = (void *) page->mapping - PAGE_MAPPING_ANON;
 	struct vm_area_struct *vma;
 	int referenced = 0;
 
@@ -344,31 +343,18 @@ void page_add_anon_rmap(struct page *pag
 	BUG_ON(PageReserved(page));
 	BUG_ON(!anon_vma);
 
+	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	index = (address - vma->vm_start) >> PAGE_SHIFT;
 	index += vma->vm_pgoff;
 	index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 
-	/*
-	 * Setting and clearing PG_anon must always happen inside
-	 * page_map_lock to avoid races between mapping and
-	 * unmapping on different processes of the same
-	 * shared cow swapcache page. And while we take the
-	 * page_map_lock PG_anon cannot change from under us.
-	 * Actually PG_anon cannot change under fork either
-	 * since fork holds a reference on the page so it cannot
-	 * be unmapped under fork and in turn copy_page_range is
-	 * allowed to read PG_anon outside the page_map_lock.
-	 */
 	page_map_lock(page);
 	if (!page->mapcount) {
-		BUG_ON(PageAnon(page));
 		BUG_ON(page->mapping);
-		SetPageAnon(page);
 		page->index = index;
 		page->mapping = (struct address_space *) anon_vma;
 		inc_page_state(nr_mapped);
 	} else {
-		BUG_ON(!PageAnon(page));
 		BUG_ON(page->index != index);
 		BUG_ON(page->mapping != (struct address_space *) anon_vma);
 	}
@@ -623,7 +609,7 @@ out_unlock:
 
 static inline int try_to_unmap_anon(struct page *page)
 {
-	struct anon_vma *anon_vma = (struct anon_vma *) page->mapping;
+	struct anon_vma *anon_vma = (void *) page->mapping - PAGE_MAPPING_ANON;
 	struct vm_area_struct *vma;
 	int ret = SWAP_AGAIN;
 

