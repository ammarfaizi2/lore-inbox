Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWCJPTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWCJPTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWCJPTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:19:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:2186 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750792AbWCJPSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:18:41 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Cc: Nick Piggin <npiggin@suse.de>
Message-Id: <20060207021849.10002.78601.sendpatchset@linux.site>
In-Reply-To: <20060207021822.10002.30448.sendpatchset@linux.site>
References: <20060207021822.10002.30448.sendpatchset@linux.site>
Subject: [patch 3/3] mm: lockless pagecache lookups
Date: Fri, 10 Mar 2006 16:18:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use page_cache_get_speculative and lockless radix tree lookups to
introduce lockless page cache lookups (ie. no mapping->tree_lock).

The only atomicity changes this should introduce is the use of a
non atomic pagevec lookup for truncate, however what atomicity
guarantees that there might have been were not used anyway, because
the size of the pagevec is not guaranteed (eg. it might be 1).

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -417,7 +417,6 @@ int add_to_page_cache(struct page *page,
 	}
 	return error;
 }
-
 EXPORT_SYMBOL(add_to_page_cache);
 
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
@@ -518,21 +517,21 @@ void fastcall __lock_page(struct page *p
 EXPORT_SYMBOL(__lock_page);
 
 /*
- * a rather lightweight function, finding and getting a reference to a
- * hashed page atomically.
+ * find_get_page finds and gets a reference to a pagecache page.
  */
-struct page * find_get_page(struct address_space *mapping, unsigned long offset)
+struct page *find_get_page(struct address_space *mapping, unsigned long offset)
 {
-	struct page *page;
+	struct page **pagep;
+	struct page *page = NULL;
 
-	read_lock_irq(&mapping->tree_lock);
-	page = radix_tree_lookup(&mapping->page_tree, offset);
-	if (page)
-		page_cache_get(page);
-	read_unlock_irq(&mapping->tree_lock);
+	rcu_read_lock();
+	pagep = (struct page **)radix_tree_lookup_slot(&mapping->page_tree,
+									offset);
+	if (likely(pagep))
+		page = page_cache_get_speculative(pagep);
+	rcu_read_unlock();
 	return page;
 }
-
 EXPORT_SYMBOL(find_get_page);
 
 /*
@@ -540,17 +539,31 @@ EXPORT_SYMBOL(find_get_page);
  */
 struct page *find_trylock_page(struct address_space *mapping, unsigned long offset)
 {
-	struct page *page;
+	struct page **pagep;
+	struct page *page = NULL;
 
-	read_lock_irq(&mapping->tree_lock);
-	page = radix_tree_lookup(&mapping->page_tree, offset);
-	if (page) {
-		if (unlikely(TestSetPageLocked(page)))
+	rcu_read_lock();
+	pagep = (struct page **)radix_tree_lookup_slot(&mapping->page_tree,
+									offset);
+	if (pagep) {
+repeat:
+		page = page_cache_get_speculative(pagep);
+
+		if (unlikely(TestSetPageLocked(page))) {
+			page_cache_release(page);
 			page = NULL;
-		else
-			get_page(page);
+			goto out;
+		}
+
+		/* Has the page been truncated before being locked? */
+		if (unlikely(page != *pagep)) {
+			unlock_page(page);
+			page_cache_release(page);
+			goto repeat;
+		}
 	}
-	read_unlock_irq(&mapping->tree_lock);
+out:
+	rcu_read_unlock();
 	return page;
 }
 
@@ -573,25 +586,17 @@ struct page *find_lock_page(struct addre
 	struct page *page;
 
 repeat:
-	read_lock_irq(&mapping->tree_lock);
-	page = radix_tree_lookup(&mapping->page_tree, offset);
+	page = find_get_page(mapping, offset);
 	if (page) {
-		page_cache_get(page);
-		if (TestSetPageLocked(page)) {
-			read_unlock_irq(&mapping->tree_lock);
-			__lock_page(page);
+		lock_page(page);
 
-			/* Has the page been truncated while we slept? */
-			if (unlikely(page->mapping != mapping)) {
-				unlock_page(page);
-				page_cache_release(page);
-				goto repeat;
-			}
-			goto out;
+		/* Has the page been truncated while we slept? */
+		if (unlikely(page->mapping != mapping)) {
+			unlock_page(page);
+			page_cache_release(page);
+			goto repeat;
 		}
 	}
-	read_unlock_irq(&mapping->tree_lock);
-out:
 	return page;
 }
 
@@ -674,6 +679,32 @@ unsigned find_get_pages(struct address_s
 	return ret;
 }
 
+unsigned find_get_pages_nonatomic(struct address_space *mapping, pgoff_t start,
+			    unsigned int nr_pages, struct page **pages)
+{
+	unsigned int i;
+	unsigned int nr_found;
+	unsigned int ret;
+
+	/*
+	 * We do some unsightly casting to use the array first for storing
+	 * pointers to the page pointers, and then for the pointers to
+	 * the pages themselves that the caller wants.
+	 */
+	rcu_read_lock();
+	nr_found = radix_tree_gang_lookup_slot(&mapping->page_tree,
+				(void ***)pages, start, nr_pages);
+	ret = 0;
+	for (i = 0; i < nr_found; i++) {
+		struct page *page;
+		page = page_cache_get_speculative(((struct page ***)pages)[i]);
+		if (likely(page))
+			pages[ret++] = page;
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 /*
  * Like find_get_pages, except we only return pages which are tagged with
  * `tag'.   We update *index to index the next page for the traversal.
Index: linux-2.6/mm/readahead.c
===================================================================
--- linux-2.6.orig/mm/readahead.c
+++ linux-2.6/mm/readahead.c
@@ -275,27 +275,26 @@ __do_page_cache_readahead(struct address
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	read_lock_irq(&mapping->tree_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		pgoff_t page_offset = offset + page_idx;
 		
 		if (page_offset > end_index)
 			break;
 
+		/* Don't need mapping->tree_lock - lookup can be racy */
+		rcu_read_lock();
 		page = radix_tree_lookup(&mapping->page_tree, page_offset);
+		rcu_read_unlock();
 		if (page)
 			continue;
 
-		read_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
-		read_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
 		ret++;
 	}
-	read_unlock_irq(&mapping->tree_lock);
 
 	/*
 	 * Now start the IO.  We ignore I/O errors - if the page is not
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -160,6 +160,8 @@ extern struct page * find_or_create_page
 				unsigned long index, gfp_t gfp_mask);
 unsigned find_get_pages(struct address_space *mapping, pgoff_t start,
 			unsigned int nr_pages, struct page **pages);
+unsigned find_get_pages_nonatomic(struct address_space *mapping, pgoff_t start,
+			unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_tag(struct address_space *mapping, pgoff_t *index,
 			int tag, unsigned int nr_pages, struct page **pages);
 
Index: linux-2.6/include/linux/pagevec.h
===================================================================
--- linux-2.6.orig/include/linux/pagevec.h
+++ linux-2.6/include/linux/pagevec.h
@@ -28,6 +28,8 @@ void __pagevec_lru_add_active(struct pag
 void pagevec_strip(struct pagevec *pvec);
 unsigned pagevec_lookup(struct pagevec *pvec, struct address_space *mapping,
 		pgoff_t start, unsigned nr_pages);
+unsigned pagevec_lookup_nonatomic(struct pagevec *pvec,
+	struct address_space *mapping, pgoff_t start, unsigned nr_pages);
 unsigned pagevec_lookup_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, int tag,
 		unsigned nr_pages);
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -428,6 +428,20 @@ unsigned pagevec_lookup(struct pagevec *
 
 EXPORT_SYMBOL(pagevec_lookup);
 
+/**
+ * pagevec_lookup_nonatomic - non atomic pagevec_lookup
+ *
+ * This routine is non-atomic in that it may return blah.
+ */
+unsigned pagevec_lookup_nonatomic(struct pagevec *pvec,
+		struct address_space *mapping, pgoff_t start, unsigned nr_pages)
+{
+	pvec->nr = find_get_pages_nonatomic(mapping, start,
+					nr_pages, pvec->pages);
+	return pagevec_count(pvec);
+}
+EXPORT_SYMBOL(pagevec_lookup_nonatomic);
+
 unsigned pagevec_lookup_tag(struct pagevec *pvec, struct address_space *mapping,
 		pgoff_t *index, int tag, unsigned nr_pages)
 {
Index: linux-2.6/mm/truncate.c
===================================================================
--- linux-2.6.orig/mm/truncate.c
+++ linux-2.6/mm/truncate.c
@@ -124,7 +124,7 @@ void truncate_inode_pages_range(struct a
 	pagevec_init(&pvec, 0);
 	next = start;
 	while (next <= end &&
-	       pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+	       pagevec_lookup_nonatomic(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			pgoff_t page_index = page->index;
@@ -163,7 +163,7 @@ void truncate_inode_pages_range(struct a
 	next = start;
 	for ( ; ; ) {
 		cond_resched();
-		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+		if (!pagevec_lookup_nonatomic(&pvec, mapping, next, PAGEVEC_SIZE)) {
 			if (next == start)
 				break;
 			next = start;
@@ -227,7 +227,7 @@ unsigned long invalidate_mapping_pages(s
 
 	pagevec_init(&pvec, 0);
 	while (next <= end &&
-			pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+		pagevec_lookup_nonatomic(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -284,7 +284,7 @@ int invalidate_inode_pages2_range(struct
 	pagevec_init(&pvec, 0);
 	next = start;
 	while (next <= end && !ret && !wrapped &&
-		pagevec_lookup(&pvec, mapping, next,
+		pagevec_lookup_nonatomic(&pvec, mapping, next,
 			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
Index: linux-2.6/mm/page-writeback.c
===================================================================
--- linux-2.6.orig/mm/page-writeback.c
+++ linux-2.6/mm/page-writeback.c
@@ -808,17 +808,15 @@ int test_set_page_writeback(struct page 
 EXPORT_SYMBOL(test_set_page_writeback);
 
 /*
- * Return true if any of the pages in the mapping are marged with the
+ * Return true if any of the pages in the mapping are marked with the
  * passed tag.
  */
 int mapping_tagged(struct address_space *mapping, int tag)
 {
-	unsigned long flags;
 	int ret;
-
-	read_lock_irqsave(&mapping->tree_lock, flags);
+	rcu_read_lock();
 	ret = radix_tree_tagged(&mapping->page_tree, tag);
-	read_unlock_irqrestore(&mapping->tree_lock, flags);
+	rcu_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL(mapping_tagged);
