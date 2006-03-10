Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWCJPTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWCJPTB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWCJPS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:18:58 -0500
Received: from mail.suse.de ([195.135.220.2]:4738 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750868AbWCJPSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:18:49 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Cc: Nick Piggin <npiggin@suse.de>
Message-Id: <20060207021859.10002.46929.sendpatchset@linux.site>
In-Reply-To: <20060207021822.10002.30448.sendpatchset@linux.site>
References: <20060207021822.10002.30448.sendpatchset@linux.site>
Subject: [patch 4/3] mm: lockless optimisations
Date: Fri, 10 Mar 2006 16:18:46 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add_to_page_cache only deals with newly allocated pages except in the
swap -> shm case. Take advantage of this to optimise add_to_page_cache,
and introduce a new __add_to_page_cache for use on pages other than
newly allocated ones.

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -400,6 +400,45 @@ int add_to_page_cache(struct page *page,
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
 	if (error == 0) {
+		/*
+		 * Can get away with less atomic ops and without using
+		 * Set/ClearPageNoNewRefs if we order operations correctly.
+		 */
+		page_cache_get(page);
+		__SetPageLocked(page);
+		page->mapping = mapping;
+		page->index = offset;
+
+		write_lock_irq(&mapping->tree_lock);
+		error = radix_tree_insert(&mapping->page_tree, offset, page);
+		if (!error) {
+			mapping->nrpages++;
+			pagecache_acct(1);
+		}
+		write_unlock_irq(&mapping->tree_lock);
+		radix_tree_preload_end();
+
+		if (error) {
+			page->mapping = NULL;
+			__put_page(page);
+			__ClearPageLocked(page);
+		}
+	}
+	return error;
+}
+EXPORT_SYMBOL(add_to_page_cache);
+
+/*
+ * Same as add_to_page_cache, but works on pages that are already in
+ * swapcache and possibly visible to external lookups.
+ * (special case for move_from_swap_cache).
+ */
+int __add_to_page_cache(struct page *page, struct address_space *mapping,
+		pgoff_t offset, gfp_t gfp_mask)
+{
+	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+
+	if (error == 0) {
 		SetPageNoNewRefs(page);
 		write_lock_irq(&mapping->tree_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
@@ -417,7 +456,6 @@ int add_to_page_cache(struct page *page,
 	}
 	return error;
 }
-EXPORT_SYMBOL(add_to_page_cache);
 
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				pgoff_t offset, gfp_t gfp_mask)
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -234,7 +234,7 @@ int move_to_swap_cache(struct page *page
 int move_from_swap_cache(struct page *page, unsigned long index,
 		struct address_space *mapping)
 {
-	int err = add_to_page_cache(page, mapping, index, GFP_ATOMIC);
+	int err = __add_to_page_cache(page, mapping, index, GFP_ATOMIC);
 	if (!err) {
 		delete_from_swap_cache(page);
 		/* shift page from clean_pages to dirty_pages list */
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -183,6 +183,8 @@ extern int read_cache_pages(struct addre
 
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 				unsigned long index, gfp_t gfp_mask);
+int __add_to_page_cache(struct page *page, struct address_space *mapping,
+  				unsigned long index, gfp_t gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				unsigned long index, gfp_t gfp_mask);
 extern void remove_from_page_cache(struct page *page);
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -214,16 +214,13 @@ extern void __mod_page_state_offset(unsi
 /*
  * Manipulation of page state flags
  */
-#define PageLocked(page)		\
-		test_bit(PG_locked, &(page)->flags)
-#define SetPageLocked(page)		\
-		set_bit(PG_locked, &(page)->flags)
-#define TestSetPageLocked(page)		\
-		test_and_set_bit(PG_locked, &(page)->flags)
-#define ClearPageLocked(page)		\
-		clear_bit(PG_locked, &(page)->flags)
-#define TestClearPageLocked(page)	\
-		test_and_clear_bit(PG_locked, &(page)->flags)
+#define PageLocked(page)	test_bit(PG_locked, &(page)->flags)
+#define SetPageLocked(page)	set_bit(PG_locked, &(page)->flags)
+#define __SetPageLocked(page)	__set_bit(PG_locked, &(page)->flags)
+#define TestSetPageLocked(page)	test_and_set_bit(PG_locked, &(page)->flags)
+#define ClearPageLocked(page)	clear_bit(PG_locked, &(page)->flags)
+#define __ClearPageLocked(page)	__clear_bit(PG_locked, &(page)->flags)
+#define TestClearPageLocked(page) test_and_clear_bit(PG_locked, &(page)->flags)
 
 #define PageError(page)		test_bit(PG_error, &(page)->flags)
 #define SetPageError(page)	set_bit(PG_error, &(page)->flags)
