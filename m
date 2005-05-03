Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVECEoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVECEoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 00:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVECEoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 00:44:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54449 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261386AbVECEoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 00:44:00 -0400
Date: Tue, 3 May 2005 00:43:56 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: [RFC] cleanup of use-once
Message-ID: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The special cases in the use-once code have annoyed me for a while,
and I'd like to see if replacing them with something simpler could
be worthwhile.

I haven't actually benchmarked (or even tested) this code yet, but
the basic idea is that we want to ignore multiple references to the
same page if they happen really close to each other, and only keep
a page on the active list if it got accessed again on a time scale
that matters to the pageout code.  In other words, filtering out
correlated references in a simpler way.

Opinions ?

Signed-off-by: Rik van Riel <riel@redhat.com>

 include/linux/page-flags.h |    7 +++++++
 mm/filemap.c               |   11 ++---------
 mm/shmem.c                 |    7 ++-----
 mm/swap.c                  |   11 ++---------
 mm/vmscan.c                |   29 ++++++-----------------------
 5 files changed, 19 insertions(+), 46 deletions(-)

Index: linux-2.6.11/include/linux/page-flags.h
===================================================================
--- linux-2.6.11.orig/include/linux/page-flags.h
+++ linux-2.6.11/include/linux/page-flags.h
@@ -77,6 +77,8 @@
 #define PG_nosave_free		19	/* Free, should not be written */
 #define PG_uncached		20	/* Page has been mapped as uncached */
 
+#define PG_new			21	/* Newly allocated page */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -305,6 +307,11 @@ extern void __mod_page_state(unsigned of
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageNew(page)		test_bit(PG_new, &(page)->flags)
+#define SetPageNew(page)	set_bit(PG_new, &(page)->flags)
+#define ClearPageNew(page)	clear_bit(PG_new, &(page)->flags)
+#define TestClearPageNew(page)	test_and_clear_bit(PG_new, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6.11/mm/filemap.c
===================================================================
--- linux-2.6.11.orig/mm/filemap.c
+++ linux-2.6.11/mm/filemap.c
@@ -370,6 +370,7 @@ int add_to_page_cache(struct page *page,
 		if (!error) {
 			page_cache_get(page);
 			SetPageLocked(page);
+			SetPageNew(page);
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
@@ -710,7 +711,6 @@ void do_generic_mapping_read(struct addr
 	unsigned long offset;
 	unsigned long last_index;
 	unsigned long next_index;
-	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
 	int error;
@@ -719,7 +719,6 @@ void do_generic_mapping_read(struct addr
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
-	prev_index = ra.prev_page;
 	last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
@@ -776,13 +775,7 @@ page_ok:
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
-		/*
-		 * When (part of) the same page is read multiple times
-		 * in succession, only mark it as accessed the first time.
-		 */
-		if (prev_index != index)
-			mark_page_accessed(page);
-		prev_index = index;
+		mark_page_accessed(page);
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
Index: linux-2.6.11/mm/swap.c
===================================================================
--- linux-2.6.11.orig/mm/swap.c
+++ linux-2.6.11/mm/swap.c
@@ -115,19 +115,11 @@ void fastcall activate_page(struct page 
 
 /*
  * Mark a page as having seen activity.
- *
- * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
+	if (!PageReferenced(page))
 		SetPageReferenced(page);
-	}
 }
 
 EXPORT_SYMBOL(mark_page_accessed);
@@ -157,6 +149,7 @@ void fastcall lru_cache_add_active(struc
 	if (!pagevec_add(pvec, page))
 		__pagevec_lru_add_active(pvec);
 	put_cpu_var(lru_add_active_pvecs);
+	ClearPageNew(page);
 }
 
 void lru_add_drain(void)
Index: linux-2.6.11/mm/shmem.c
===================================================================
--- linux-2.6.11.orig/mm/shmem.c
+++ linux-2.6.11/mm/shmem.c
@@ -1525,11 +1525,8 @@ static void do_shmem_file_read(struct fi
 			 */
 			if (mapping_writably_mapped(mapping))
 				flush_dcache_page(page);
-			/*
-			 * Mark the page accessed if we read the beginning.
-			 */
-			if (!offset)
-				mark_page_accessed(page);
+
+			mark_page_accessed(page);
 		} else
 			page = ZERO_PAGE(0);
 
Index: linux-2.6.11/mm/vmscan.c
===================================================================
--- linux-2.6.11.orig/mm/vmscan.c
+++ linux-2.6.11/mm/vmscan.c
@@ -225,27 +225,6 @@ static int shrink_slab(unsigned long sca
 	return 0;
 }
 
-/* Called without lock on whether page is mapped, so answer is unstable */
-static inline int page_mapping_inuse(struct page *page)
-{
-	struct address_space *mapping;
-
-	/* Page is in somebody's page tables. */
-	if (page_mapped(page))
-		return 1;
-
-	/* Be more reluctant to reclaim swapcache than pagecache */
-	if (PageSwapCache(page))
-		return 1;
-
-	mapping = page_mapping(page);
-	if (!mapping)
-		return 0;
-
-	/* File is mmap'd by somebody? */
-	return mapping_mapped(mapping);
-}
-
 static inline int is_page_cache_freeable(struct page *page)
 {
 	return page_count(page) - !!PagePrivate(page) == 2;
@@ -398,9 +377,13 @@ static int shrink_list(struct list_head 
 			goto keep_locked;
 
 		referenced = page_referenced(page, 1, sc->priority <= 0);
-		/* In active use or really unfreeable?  Activate it. */
-		if (referenced && page_mapping_inuse(page))
+
+		if (referenced) {
+			/* New page. Let's see if it'll get used again... */
+			if (TestClearPageNew(page))
+				goto keep_locked;
 			goto activate_locked;
+		}
 
 #ifdef CONFIG_SWAP
 		/*
