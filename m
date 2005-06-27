Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVF0Gmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVF0Gmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVF0Gl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:41:56 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:29324 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261866AbVF0Ge6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:34:58 -0400
Message-ID: <42BF9E03.9050507@yahoo.com.au>
Date: Mon, 27 Jun 2005 16:34:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [patch 5] mm: lockless pagecache lookups
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au> <42BF9DBA.3000607@yahoo.com.au> <42BF9DE5.6010701@yahoo.com.au>
In-Reply-To: <42BF9DE5.6010701@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------010006010304070405070908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010006010304070405070908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
SUSE Labs, Novell Inc.

--------------010006010304070405070908
Content-Type: text/plain;
 name="mm-lockless-pagecache-lookups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-lockless-pagecache-lookups.patch"

Use the speculative get_page and the lockless radix tree lookups
to introduce lockless page cache lookups (ie. no mapping->tree_lock).

The only atomicity changes this should introduce is the use of a
non atomic pagevec lookup for truncate, however what atomicity
guarantees there were are probably not too useful anyway.

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -378,18 +378,25 @@ int add_to_page_cache(struct page *page,
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
 	if (error == 0) {
+		page_cache_get(page);
+		__SetPageLocked(page);
+		page->mapping = mapping;
+		page->index = offset;
+
 		write_lock_irq(&mapping->tree_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
-			page_cache_get(page);
-			SetPageLocked(page);
-			page->mapping = mapping;
-			page->index = offset;
 			mapping->nrpages++;
 			pagecache_acct(1);
 		}
 		write_unlock_irq(&mapping->tree_lock);
 		radix_tree_preload_end();
+
+		if (error) {
+			page->mapping = NULL;
+			__put_page(page);
+			__ClearPageLocked(page);
+		}
 	}
 	return error;
 }
@@ -499,13 +506,13 @@ EXPORT_SYMBOL(__lock_page);
  */
 struct page * find_get_page(struct address_space *mapping, unsigned long offset)
 {
-	struct page *page;
+	struct page **pagep;
+	struct page *page = NULL;
 
-	read_lock_irq(&mapping->tree_lock);
-	page = radix_tree_lookup(&mapping->page_tree, offset);
-	if (page)
-		page_cache_get(page);
-	read_unlock_irq(&mapping->tree_lock);
+	pagep = (struct page **)radix_tree_lookup_slot(&mapping->page_tree,
+									offset);
+	if (pagep)
+		page = page_cache_get_speculative(pagep);
 	return page;
 }
 
@@ -518,12 +525,24 @@ struct page *find_trylock_page(struct ad
 {
 	struct page *page;
 
-	read_lock_irq(&mapping->tree_lock);
-	page = radix_tree_lookup(&mapping->page_tree, offset);
-	if (page && TestSetPageLocked(page))
-		page = NULL;
-	read_unlock_irq(&mapping->tree_lock);
-	return page;
+	page = find_get_page(mapping, offset);
+	if (page) {
+		if (TestSetPageLocked(page))
+			goto out_failed;
+		/* Has the page been truncated before being locked? */
+		if (page->mapping != mapping || page->index != offset) {
+			unlock_page(page);
+			goto out_failed;
+		}
+
+		/* Silly interface requires us to drop the refcount */
+		__put_page(page);
+		return page;
+
+out_failed:
+		page_cache_release(page);
+	}
+	return NULL;
 }
 
 EXPORT_SYMBOL(find_trylock_page);
@@ -544,25 +563,17 @@ struct page *find_lock_page(struct addre
 {
 	struct page *page;
 
-	read_lock_irq(&mapping->tree_lock);
 repeat:
-	page = radix_tree_lookup(&mapping->page_tree, offset);
+	page = find_get_page(mapping, offset);
 	if (page) {
-		page_cache_get(page);
-		if (TestSetPageLocked(page)) {
-			read_unlock_irq(&mapping->tree_lock);
-			lock_page(page);
-			read_lock_irq(&mapping->tree_lock);
-
-			/* Has the page been truncated while we slept? */
-			if (page->mapping != mapping || page->index != offset) {
-				unlock_page(page);
-				page_cache_release(page);
-				goto repeat;
-			}
+		lock_page(page);
+		/* Has the page been truncated before being locked? */
+		if (page->mapping != mapping || page->index != offset) {
+			unlock_page(page);
+			page_cache_release(page);
+			goto repeat;
 		}
 	}
-	read_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -645,6 +656,30 @@ unsigned find_get_pages(struct address_s
 	return ret;
 }
 
+unsigned find_get_pages_nonatomic(struct address_space *mapping, pgoff_t start,
+			    unsigned int nr_pages, struct page **pages)
+{
+	unsigned int i;
+	unsigned int ret;
+	unsigned int ret2;
+
+	/*
+	 * We do some unsightly casting to use the array first for storing
+	 * pointers to the page pointers, and then for the pointers to
+	 * the pages themselves that the caller wants.
+	 */
+	ret = radix_tree_gang_lookup_slot(&mapping->page_tree,
+				(void ***)pages, start, nr_pages);
+	ret2 = 0;
+	for (i = 0; i < ret; i++) {
+		struct page *page;
+		page = page_cache_get_speculative(((struct page ***)pages)[i]);
+		if (page)
+			pages[ret2++] = page;
+	}
+	return ret2;
+}
+
 /*
  * Like find_get_pages, except we only return pages which are tagged with
  * `tag'.   We update *index to index the next page for the traversal.
Index: linux-2.6/mm/readahead.c
===================================================================
--- linux-2.6.orig/mm/readahead.c
+++ linux-2.6/mm/readahead.c
@@ -272,27 +272,24 @@ __do_page_cache_readahead(struct address
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	read_lock_irq(&mapping->tree_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		unsigned long page_offset = offset + page_idx;
 		
 		if (page_offset > end_index)
 			break;
 
+		/* Don't need mapping->tree_lock - lookup can be racy */
 		page = radix_tree_lookup(&mapping->page_tree, page_offset);
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
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -76,19 +76,26 @@ static int __add_to_swap_cache(struct pa
 	BUG_ON(PagePrivate(page));
 	error = radix_tree_preload(gfp_mask);
 	if (!error) {
+		page_cache_get(page);
+		SetPageLocked(page);
+		SetPageSwapCache(page);
+		page->private = entry.val;
+
 		write_lock_irq(&swapper_space.tree_lock);
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
-			page_cache_get(page);
-			SetPageLocked(page);
-			SetPageSwapCache(page);
-			page->private = entry.val;
 			total_swapcache_pages++;
 			pagecache_acct(1);
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
 		radix_tree_preload_end();
+
+		if (error) {
+			__put_page(page);
+			ClearPageLocked(page);
+			ClearPageSwapCache(page);
+		}
 	}
 	return error;
 }
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -167,16 +167,13 @@ extern void __mod_page_state(unsigned lo
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
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -108,6 +108,8 @@ extern struct page * find_or_create_page
 				unsigned long index, unsigned int gfp_mask);
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
@@ -25,6 +25,8 @@ void __pagevec_lru_add_active(struct pag
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
@@ -380,6 +380,19 @@ unsigned pagevec_lookup(struct pagevec *
 	return pagevec_count(pvec);
 }
 
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
+
 unsigned pagevec_lookup_tag(struct pagevec *pvec, struct address_space *mapping,
 		pgoff_t *index, int tag, unsigned nr_pages)
 {
Index: linux-2.6/mm/truncate.c
===================================================================
--- linux-2.6.orig/mm/truncate.c
+++ linux-2.6/mm/truncate.c
@@ -126,7 +126,7 @@ void truncate_inode_pages(struct address
 
 	pagevec_init(&pvec, 0);
 	next = start;
-	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+	while (pagevec_lookup_nonatomic(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			pgoff_t page_index = page->index;
@@ -160,7 +160,7 @@ void truncate_inode_pages(struct address
 	next = start;
 	for ( ; ; ) {
 		cond_resched();
-		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+		if (!pagevec_lookup_nonatomic(&pvec, mapping, next, PAGEVEC_SIZE)) {
 			if (next == start)
 				break;
 			next = start;
@@ -206,7 +206,7 @@ unsigned long invalidate_mapping_pages(s
 
 	pagevec_init(&pvec, 0);
 	while (next <= end &&
-			pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+		pagevec_lookup_nonatomic(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
Index: linux-2.6/mm/page-writeback.c
===================================================================
--- linux-2.6.orig/mm/page-writeback.c
+++ linux-2.6/mm/page-writeback.c
@@ -811,6 +811,7 @@ int mapping_tagged(struct address_space 
 	unsigned long flags;
 	int ret;
 
+	/* XXX: radix_tree_tagged is safe to run without the lock */
 	read_lock_irqsave(&mapping->tree_lock, flags);
 	ret = radix_tree_tagged(&mapping->page_tree, tag);
 	read_unlock_irqrestore(&mapping->tree_lock, flags);
Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c
+++ linux-2.6/mm/swapfile.c
@@ -338,6 +338,7 @@ int remove_exclusive_swap_page(struct pa
 	retval = 0;
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the swapcache lock held.. */
+		SetPageFreeing(page);
 		write_lock_irq(&swapper_space.tree_lock);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
@@ -345,6 +346,7 @@ int remove_exclusive_swap_page(struct pa
 			retval = 1;
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
+		ClearPageFreeing(page);
 	}
 	swap_info_put(p);
 

--------------010006010304070405070908--
Send instant messages to your online friends http://au.messenger.yahoo.com 
