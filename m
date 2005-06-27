Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVF0Gg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVF0Gg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVF0Ggz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:36:55 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:51846 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261865AbVF0Gcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:32:45 -0400
Message-ID: <42BF9D86.90204@yahoo.com.au>
Date: Mon, 27 Jun 2005 16:32:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [patch 2] mm: speculative get_page
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au>
In-Reply-To: <42BF9D67.10509@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090803000105080705040600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090803000105080705040600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
SUSE Labs, Novell Inc.

--------------090803000105080705040600
Content-Type: text/plain;
 name="mm-speculative-get_page.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-speculative-get_page.patch"

If we can be sure that elevating the page_count on a pagecache
page will pin it, we can speculatively run this operation, and
subsequently check to see if we hit the right page rather than
relying on holding a lock or otherwise pinning a reference to
the page.

This can be done if get_page/put_page behaves in the same manner
throughout the whole tree (ie. if we "get" the page after it has
been used for something else, we must be able to free it with a
put_page).

There needs to be some careful logic for freed pages so they aren't
freed again, and also some careful logic for pages in the process
of being removed from pagecache.

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -77,6 +77,7 @@
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
 #define PG_free			20	/* Page is on the free lists */
+#define PG_freeing		21	/* PG_refcount about to be freed */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -312,6 +313,11 @@ extern void __mod_page_state(unsigned lo
 #define __SetPageFree(page)	__set_bit(PG_free, &(page)->flags)
 #define __ClearPageFree(page)	__clear_bit(PG_free, &(page)->flags)
 
+#define PageFreeing(page)	test_bit(PG_freeing, &(page)->flags)
+#define SetPageFreeing(page)	set_bit(PG_freeing, &(page)->flags)
+#define ClearPageFreeing(page)	clear_bit(PG_freeing, &(page)->flags)
+#define __ClearPageFreeing(page) __clear_bit(PG_freeing, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -50,6 +50,42 @@ static inline void mapping_set_gfp_mask(
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+static inline struct page *page_cache_get_speculative(struct page **pagep)
+{
+	struct page *page;
+
+	preempt_disable();
+	page = *pagep;
+	if (!page)
+		goto out_failed;
+
+	if (unlikely(get_page_testone(page))) {
+		/* Picked up a freed page */
+		__put_page(page);
+		goto out_failed;
+	}
+	/*
+	 * preempt can really be enabled here (only needs to be disabled
+	 * because page allocation can spin on the elevated refcount, but
+	 * we don't want to hold a reference on an unrelated page for too
+	 * long, so keep preempt off until we know we have the right page
+	 */
+
+	if (unlikely(PageFreeing(page)) ||
+			unlikely(page != *pagep)) {
+		/* Picked up a page being freed, or one that's been reused */
+		put_page(page);
+		goto out_failed;
+	}
+	preempt_enable();
+
+	return page;
+
+out_failed:
+	preempt_enable();
+	return NULL;
+}
+
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return alloc_pages(mapping_gfp_mask(x)|__GFP_NORECLAIM, 0);
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -116,7 +116,6 @@ static void bad_page(const char *functio
 			1 << PG_writeback |
 			1 << PG_reserved |
 			1 << PG_free );
-	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
 	tainted |= TAINT_BAD_PAGE;
@@ -316,7 +315,6 @@ static inline void free_pages_check(cons
 {
 	if (	page_mapcount(page) ||
 		page->mapping != NULL ||
-		page_count(page) != 0 ||
 		(page->flags & (
 			1 << PG_lru	|
 			1 << PG_private |
@@ -424,7 +422,7 @@ expand(struct zone *zone, struct page *p
 void set_page_refs(struct page *page, int order)
 {
 #ifdef CONFIG_MMU
-	set_page_count(page, 1);
+	get_page(page);
 #else
 	int i;
 
@@ -434,7 +432,7 @@ void set_page_refs(struct page *page, in
 	 * - eg: access_process_vm()
 	 */
 	for (i = 0; i < (1 << order); i++)
-		set_page_count(page + i, 1);
+		get_page(page + i);
 #endif /* CONFIG_MMU */
 }
 
@@ -445,7 +443,6 @@ static void prep_new_page(struct page *p
 {
 	if (	page_mapcount(page) ||
 		page->mapping != NULL ||
-		page_count(page) != 0 ||
 		(page->flags & (
 			1 << PG_lru	|
 			1 << PG_private	|
@@ -464,7 +461,13 @@ static void prep_new_page(struct page *p
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	page->private = 0;
+
 	set_page_refs(page, order);
+	smp_mb();
+	/* Wait for speculative get_page after count has been elevated. */
+	while (unlikely(page_count(page) > 1))
+		cpu_relax();
+
 	kernel_map_pages(page, 1 << order, 1);
 }
 
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -504,6 +504,7 @@ static int shrink_list(struct list_head 
 		if (!mapping)
 			goto keep_locked;	/* truncate got there first */
 
+		SetPageFreeing(page);
 		write_lock_irq(&mapping->tree_lock);
 
 		/*
@@ -513,6 +514,7 @@ static int shrink_list(struct list_head 
 		 */
 		if (page_count(page) != 2 || PageDirty(page)) {
 			write_unlock_irq(&mapping->tree_lock);
+			ClearPageFreeing(page);
 			goto keep_locked;
 		}
 
@@ -533,6 +535,7 @@ static int shrink_list(struct list_head 
 
 free_it:
 		unlock_page(page);
+		__ClearPageFreeing(page);
 		reclaimed++;
 		if (!pagevec_add(&freed_pvec, page))
 			__pagevec_release_nonlru(&freed_pvec);
Index: linux-2.6/mm/bootmem.c
===================================================================
--- linux-2.6.orig/mm/bootmem.c
+++ linux-2.6/mm/bootmem.c
@@ -278,17 +278,19 @@ static unsigned long __init free_all_boo
 		if (gofast && v == ~0UL) {
 			int j, order;
 
+			prefetchw(page);
 			count += BITS_PER_LONG;
-			__ClearPageReserved(page);
+
 			order = ffs(BITS_PER_LONG) - 1;
-			set_page_refs(page, order);
-			for (j = 1; j < BITS_PER_LONG; j++) {
-				if (j + 16 < BITS_PER_LONG)
-					prefetchw(page + j + 16);
+			for (j = 0; j < BITS_PER_LONG; j++) {
+				if (j + 1 < BITS_PER_LONG)
+					prefetchw(page + j + 1);
 				__ClearPageReserved(page + j);
 				set_page_count(page + j, 0);
 			}
+			set_page_refs(page, order);
 			__free_pages(page, order);
+
 			i += BITS_PER_LONG;
 			page += BITS_PER_LONG;
 		} else if (v) {
@@ -297,6 +299,7 @@ static unsigned long __init free_all_boo
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
+					set_page_count(page, 0);
 					set_page_refs(page, 0);
 					__free_page(page);
 				}

--------------090803000105080705040600--
Send instant messages to your online friends http://au.messenger.yahoo.com 
