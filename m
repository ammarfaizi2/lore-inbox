Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSHJRsY>; Sat, 10 Aug 2002 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSHJRsY>; Sat, 10 Aug 2002 13:48:24 -0400
Received: from verein.lst.de ([212.34.181.86]:35337 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S317096AbSHJRsX>;
	Sat, 10 Aug 2002 13:48:23 -0400
Date: Sat, 10 Aug 2002 19:51:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] misc pagecache cleanups / tweaks
Message-ID: <20020810195154.A5531@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- inline grab_cache_page() in pagemap.h, it's just a simple wrapper
  around find_or_create_page()
- rename (__)remove_inode_page to (__)remove_from_page_cache and
  move them from mm.h and swap.h to pagemap.h because they reverse
  add_to_page_cache and that's where they belong.


--- linux/include/linux/mm.h	2002/08/02 19:57:07	1.93
+++ linux/include/linux/mm.h	2002/08/10 17:41:25
@@ -453,7 +453,6 @@ static inline int can_vma_merge(struct v
 
 struct zone_t;
 /* filemap.c */
-extern void remove_inode_page(struct page *);
 extern unsigned long page_unuse(struct page *);
 extern void truncate_inode_pages(struct address_space *, loff_t);
 
--- linux/include/linux/pagemap.h	2002/07/30 21:04:55	1.43
+++ linux/include/linux/pagemap.h	2002/08/10 17:41:25
@@ -42,8 +42,14 @@ extern struct page * find_trylock_page(s
 extern struct page * find_or_create_page(struct address_space *mapping,
 				unsigned long index, unsigned int gfp_mask);
 
-extern struct page * grab_cache_page(struct address_space *mapping,
-				unsigned long index);
+/*
+ * Returns locked page at given index in given cache, creating it if needed.
+ */
+static inline struct page *grab_cache_page(struct address_space *mapping, unsigned long index)
+{
+	return find_or_create_page(mapping, index, mapping->gfp_mask);
+}
+
 extern struct page * grab_cache_page_nowait(struct address_space *mapping,
 				unsigned long index);
 extern struct page * read_cache_page(struct address_space *mapping,
@@ -52,6 +58,8 @@ extern struct page * read_cache_page(str
 
 extern int add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long index);
+extern void remove_from_page_cache(struct page *page);
+extern void __remove_from_page_cache(struct page *page);
 
 static inline void ___add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long index)
--- linux/include/linux/swap.h	2002/08/02 19:57:07	1.61
+++ linux/include/linux/swap.h	2002/08/10 17:41:25
@@ -133,7 +133,6 @@ extern unsigned long totalhigh_pages;
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
-extern void __remove_inode_page(struct page *);
 
 /* Incomplete types for prototype declarations: */
 struct task_struct;
--- linux/kernel/ksyms.c	2002/08/02 19:57:07	1.154
+++ linux/kernel/ksyms.c	2002/08/10 17:41:26
@@ -285,7 +285,7 @@ EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
 EXPORT_SYMBOL(find_get_page);
 EXPORT_SYMBOL(find_lock_page);
-EXPORT_SYMBOL(grab_cache_page);
+EXPORT_SYMBOL(find_or_create_page);
 EXPORT_SYMBOL(grab_cache_page_nowait);
 EXPORT_SYMBOL(read_cache_page);
 EXPORT_SYMBOL(vfs_readlink);
--- linux/mm/filemap.c	2002/08/02 19:57:07	1.128
+++ linux/mm/filemap.c	2002/08/10 17:41:28
@@ -68,7 +68,7 @@ spinlock_t pagemap_lru_lock __cacheline_
  * sure the page is locked and that nobody else uses it - or that usage
  * is safe.  The caller must hold a write_lock on the mapping's page_lock.
  */
-void __remove_inode_page(struct page *page)
+void __remove_from_page_cache(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 
@@ -83,7 +83,7 @@ void __remove_inode_page(struct page *pa
 	dec_page_state(nr_pagecache);
 }
 
-void remove_inode_page(struct page *page)
+void remove_from_page_cache(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 
@@ -91,7 +91,7 @@ void remove_inode_page(struct page *page
 		PAGE_BUG(page);
 
 	write_lock(&mapping->page_lock);
-	__remove_inode_page(page);
+	__remove_from_page_cache(page);
 	write_unlock(&mapping->page_lock);
 }
 
@@ -143,7 +143,7 @@ void invalidate_inode_pages(struct inode
 			goto unlock;
 
 		__lru_cache_del(page);
-		__remove_inode_page(page);
+		__remove_from_page_cache(page);
 		unlock_page(page);
 		page_cache_release(page);
 		continue;
@@ -186,7 +186,7 @@ static void truncate_complete_page(struc
 
 	ClearPageDirty(page);
 	ClearPageUptodate(page);
-	remove_inode_page(page);
+	remove_from_page_cache(page);
 	page_cache_release(page);
 }
 
@@ -809,15 +809,6 @@ repeat:
 }
 
 /*
- * Returns locked page at given index in given cache, creating it if needed.
- */
-struct page *grab_cache_page(struct address_space *mapping, unsigned long index)
-{
-	return find_or_create_page(mapping, index, mapping->gfp_mask);
-}
-
-
-/*
  * Same as grab_cache_page, but do not wait if the page is unavailable.
  * This is intended for speculative data generators, where the data can
  * be regenerated if the page couldn't be grabbed.  This routine should
--- linux/mm/swap_state.c	2002/08/02 19:57:07	1.44
+++ linux/mm/swap_state.c	2002/08/10 17:41:29
@@ -95,7 +95,7 @@ void __delete_from_swap_cache(struct pag
 	BUG_ON(!PageSwapCache(page));
 	BUG_ON(PageWriteback(page));
 	ClearPageDirty(page);
-	__remove_inode_page(page);
+	__remove_from_page_cache(page);
 	INC_CACHE_INFO(del_total);
 }
 
@@ -206,7 +206,7 @@ int move_to_swap_cache(struct page *page
 	err = radix_tree_reserve(&swapper_space.page_tree, entry.val, &pslot);
 	if (!err) {
 		/* Remove it from the page cache */
-		__remove_inode_page (page);
+		__remove_from_page_cache(page);
 
 		/* Add it to the swap cache */
 		*pslot = page;
--- linux/mm/vmscan.c	2002/08/02 19:57:07	1.106
+++ linux/mm/vmscan.c	2002/08/10 17:41:29
@@ -288,7 +288,7 @@ page_freeable:
 
 		/* point of no return */
 		if (likely(!PageSwapCache(page))) {
-			__remove_inode_page(page);
+			__remove_from_page_cache(page);
 			write_unlock(&mapping->page_lock);
 		} else {
 			swp_entry_t swap;
