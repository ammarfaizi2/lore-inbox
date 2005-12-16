Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVLPVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVLPVIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVLPVIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:08:01 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:7415 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932389AbVLPVHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:07:55 -0500
Date: Fri, 16 Dec 2005 22:07:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       rhim@cc.gatech.edu
Subject: [rfc][patch 4/6] Page host virtual assist: minor fault optimization.
Message-ID: <20051216210756.GE11062@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[rfc][patch 4/6] Page host virtual assist: minor fault optimization.

On of the challenges of hva is the cost for the state transitions.
If the cost gets too big the whole concept of page state information is
in question. Therefore it is very important to avoid the state transtitions
for minor faults. Why change the page state to stable in find_get_page and
back in page_add_anon_rmap/page_add_file_rmap if the discarded pages can
be handled by the discard fault handler? If the page is in page/swap cache
just map it even if it is already discarded. The first access to the page
will cause a discard fault which needs to be able to deal with this kind
of situation anyway because of races in the memory management.

To do this we need a special variant of find_get_page, with the name
find_get_page_nohv. That function is in fact an exact copy of the original
find_get_page function which didn't care about page states as well.
This new function is then used in filemap_nopage and filemap_getpage.
After that there is only one state transition left in the minor fault.
page_add_anon_rmap/page_add_file_rmap try to get the page into volatile
state. If these two calls are removed we end up with almost all pages
in stable. The reason is that if a page is not uptodate yet, there is
an additional reference acquired from filemap_nopage. After the page
has been brought uptodate a page_hva_make_volatile needs to be done
with an offset of 2 (page cache reference + additional reference from
filemap_nopage).

That removes the state transitions on the minor fault path. A page that
has been mapped will eventually be unmapped again. On the unmap() path
each page that has been removed from the page table is freed with a call
to page_cache_release. In general that causes an unnecessary page state
transition from volatile to volatile. Not what we want. To get rid of
these state transitions as well special variants of put_page_testzero/
page_cache_release are introduced that do not try to make the page
volatile. page_cache_release_nohv is then used in free_page_and_swap_cache
and release_pages. This makes the unmap of ptes state transitions free.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 include/linux/mm.h      |   22 +++++++-----
 include/linux/pagemap.h |    1 
 include/linux/swap.h    |    2 -
 mm/filemap.c            |   88 +++++++++++++++++++++++++++++++++++++++++++-----
 mm/fremap.c             |    1 
 mm/rmap.c               |    3 -
 mm/swap.c               |   19 +++++++++-
 mm/swap_state.c         |    2 -
 8 files changed, 116 insertions(+), 22 deletions(-)

diff -urpN linux-2.6/include/linux/mm.h linux-2.6-patched/include/linux/mm.h
--- linux-2.6/include/linux/mm.h	2005-12-16 20:40:50.000000000 +0100
+++ linux-2.6-patched/include/linux/mm.h	2005-12-16 20:40:52.000000000 +0100
@@ -304,17 +304,22 @@ struct page {
  *
  * put_page_testzero checks if the page can be made volatile if the page
  * still has users and the page host virtual assist is enabled.
+ * put_page_testzero_nohv does not check the hva page state.
  */
+#define put_page_testzero_nohv(p)			\
+	({						\
+		BUG_ON(page_count(p) == 0);		\
+		atomic_add_negative(-1, &(p)->_count);	\
+	})
 
-#define put_page_testzero(p)					\
-	({							\
-		int ret;					\
-		BUG_ON(page_count(p) == 0);			\
-		ret = atomic_add_negative(-1, &(p)->_count);	\
-		if (!ret)					\
-			page_hva_make_volatile(p, 1);		\
-		ret;						\
+#define put_page_testzero(p)				\
+	({						\
+		int ret = put_page_testzero_nohv(p);    \
+		if (!ret)				\
+			page_hva_make_volatile(p, 1);	\
+		ret;					\
 	})
+
 /*
  * Grab a ref, return true if the page previously had a logical refcount of
  * zero.  ie: returns true if we just grabbed an already-deemed-to-be-free page
@@ -341,6 +346,7 @@ static inline void get_page(struct page 
 }
 
 void put_page(struct page *page);
+void put_page_nohv(struct page *page);
 
 /*
  * Multiple processes may "see" the same page. E.g. for untouched
diff -urpN linux-2.6/include/linux/pagemap.h linux-2.6-patched/include/linux/pagemap.h
--- linux-2.6/include/linux/pagemap.h	2005-12-16 20:40:34.000000000 +0100
+++ linux-2.6-patched/include/linux/pagemap.h	2005-12-16 20:40:52.000000000 +0100
@@ -49,6 +49,7 @@ static inline void mapping_set_gfp_mask(
 
 #define page_cache_get(page)		get_page(page)
 #define page_cache_release(page)	put_page(page)
+#define page_cache_release_nohv(page)	put_page_nohv(page)
 void release_pages(struct page **pages, int nr, int cold);
 
 static inline struct page *page_cache_alloc(struct address_space *x)
diff -urpN linux-2.6/include/linux/swap.h linux-2.6-patched/include/linux/swap.h
--- linux-2.6/include/linux/swap.h	2005-12-16 20:40:34.000000000 +0100
+++ linux-2.6-patched/include/linux/swap.h	2005-12-16 20:40:52.000000000 +0100
@@ -260,7 +260,7 @@ static inline void disable_swap_token(vo
 /* only sparc can not include linux/pagemap.h in this file
  * so leave page_cache_release and release_pages undeclared... */
 #define free_page_and_swap_cache(page) \
-	page_cache_release(page)
+	page_cache_release_nohv(page)
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr), 0);
 
diff -urpN linux-2.6/mm/filemap.c linux-2.6-patched/mm/filemap.c
--- linux-2.6/mm/filemap.c	2005-12-16 20:40:50.000000000 +0100
+++ linux-2.6-patched/mm/filemap.c	2005-12-16 20:40:52.000000000 +0100
@@ -550,7 +550,20 @@ EXPORT_SYMBOL(end_page_fs_misc);
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */
-struct page * find_get_page(struct address_space *mapping, unsigned long offset)
+static struct page *find_get_page_nohv(struct address_space *mapping,
+				       unsigned long offset)
+{
+	struct page *page;
+
+	read_lock_irq(&mapping->tree_lock);
+	page = radix_tree_lookup(&mapping->page_tree, offset);
+	if (page)
+		page_cache_get(page);
+	read_unlock_irq(&mapping->tree_lock);
+	return page;
+}
+
+struct page *find_get_page(struct address_space *mapping, unsigned long offset)
 {
 	struct page *page;
 
@@ -1317,7 +1330,14 @@ retry_all:
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
-	page = find_get_page(mapping, pgoff);
+	/*
+	 * The find_get_page_nohv version of find_get_page will refrain from
+	 * moving the page to stable if page is found in page cache. This is
+	 * an optimization for common case where most of the page cache pages
+	 * will not be in discarded state. In case the page indeed is
+	 * discarded, the access will result in a discard fault.
+	 */
+	page = find_get_page_nohv(mapping, pgoff);
 	if (!page) {
 		unsigned long ra_pages;
 
@@ -1351,7 +1371,7 @@ retry_find:
 				start = pgoff - ra_pages / 2;
 			do_page_cache_readahead(mapping, file, start, ra_pages);
 		}
-		page = find_get_page(mapping, pgoff);
+		page = find_get_page_nohv(mapping, pgoff);
 		if (!page)
 			goto no_cached_page;
 	}
@@ -1425,14 +1445,27 @@ page_not_uptodate:
 	/* Did somebody else get it up-to-date? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		/*
+		 * Because we held a reference to the page while somebody
+		 * else got it up-to-date the page could not be made volatile.
+		 * Do it now.
+		 */
+		page_hva_make_volatile(page, 2);
 		goto success;
 	}
 
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
-		if (PageUptodate(page))
+		if (PageUptodate(page)) {
+			/*
+			 * Because we held an additional reference to the page
+			 * while we read it in the page could not be made
+			 * volatile. Do it now.
+			 */
+			page_hva_make_volatile(page, 2);
 			goto success;
+		}
 	} else if (error == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry_find;
@@ -1456,14 +1489,27 @@ page_not_uptodate:
 	/* Somebody else successfully read it in? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		/*
+		 * Because we held a reference to the page while somebody
+		 * else read it in the page could not be made volatile.
+		 * Do it now.
+		 */
+		page_hva_make_volatile(page, 2);
 		goto success;
 	}
 	ClearPageError(page);
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
-		if (PageUptodate(page))
+		if (PageUptodate(page)) {
+			/*
+			 * Because we held an additional reference to the page
+			 * while we read it in the page could not be made
+			 * volatile. Do it now.
+			 */
+			page_hva_make_volatile(page, 2);
 			goto success;
+		}
 	} else if (error == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry_find;
@@ -1490,7 +1536,7 @@ static struct page * filemap_getpage(str
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
-	page = find_get_page(mapping, pgoff);
+	page = find_get_page_nohv(mapping, pgoff);
 	if (!page) {
 		if (nonblock)
 			return NULL;
@@ -1546,14 +1592,27 @@ page_not_uptodate:
 	/* Did somebody else get it up-to-date? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		/*
+		 * Because we held a reference to the page while somebody
+		 * else got it up-to-date the page could not be made volatile.
+		 * Do it now.
+		 */
+		page_hva_make_volatile(page, 2);
 		goto success;
 	}
 
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
-		if (PageUptodate(page))
+		if (PageUptodate(page)) {
+			/*
+			 * Because we held an additional reference to the page
+			 * while we read it in the page could not be made
+			 * volatile. Do it now.
+			 */
+			page_hva_make_volatile(page, 2);
 			goto success;
+		}
 	} else if (error == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry_find;
@@ -1575,6 +1634,12 @@ page_not_uptodate:
 	/* Somebody else successfully read it in? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		/*
+		 * Because we held a reference to the page while somebody
+		 * else got it up-to-date the page could not be made volatile.
+		 * Do it now.
+		 */
+		page_hva_make_volatile(page, 2);
 		goto success;
 	}
 
@@ -1582,8 +1647,15 @@ page_not_uptodate:
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
-		if (PageUptodate(page))
+		if (PageUptodate(page)) {
+			/*
+			 * Because we held an additional reference to the page
+			 * while we read it in the page could not be made
+			 * volatile. Do it now.
+			 */
+			page_hva_make_volatile(page, 2);
 			goto success;
+		}
 	} else if (error == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry_find;
diff -urpN linux-2.6/mm/fremap.c linux-2.6-patched/mm/fremap.c
--- linux-2.6/mm/fremap.c	2005-12-16 20:40:52.000000000 +0100
+++ linux-2.6-patched/mm/fremap.c	2005-12-16 20:40:52.000000000 +0100
@@ -83,6 +83,7 @@ int install_page(struct mm_struct *mm, s
 	page_hva_check_write(page, pte_val);
 	set_pte_at(mm, addr, pte, pte_val);
 	page_add_file_rmap(page);
+	page_hva_make_volatile(page, 1);
 	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
 	err = 0;
diff -urpN linux-2.6/mm/rmap.c linux-2.6-patched/mm/rmap.c
--- linux-2.6/mm/rmap.c	2005-12-16 20:40:52.000000000 +0100
+++ linux-2.6-patched/mm/rmap.c	2005-12-16 20:40:52.000000000 +0100
@@ -472,7 +472,6 @@ void page_add_anon_rmap(struct page *pag
 	if (atomic_inc_and_test(&page->_mapcount))
 		__page_set_anon_rmap(page, vma, address);
 	/* else checking page index and mapping is racy */
-	page_hva_make_volatile(page, 1);
 }
 
 /*
@@ -489,7 +488,6 @@ void page_add_new_anon_rmap(struct page 
 {
 	atomic_set(&page->_mapcount, 0); /* elevate count by 1 (starts at -1) */
 	__page_set_anon_rmap(page, vma, address);
-	page_hva_make_volatile(page, 1);
 }
 
 /**
@@ -505,7 +503,6 @@ void page_add_file_rmap(struct page *pag
 
 	if (atomic_inc_and_test(&page->_mapcount))
 		__inc_page_state(nr_mapped);
-	page_hva_make_volatile(page, 1);
 }
 
 #if defined(CONFIG_PAGE_HVA)
diff -urpN linux-2.6/mm/swap.c linux-2.6-patched/mm/swap.c
--- linux-2.6/mm/swap.c	2005-12-16 20:40:35.000000000 +0100
+++ linux-2.6-patched/mm/swap.c	2005-12-16 20:40:52.000000000 +0100
@@ -51,6 +51,23 @@ void put_page(struct page *page)
 }
 EXPORT_SYMBOL(put_page);
 
+void put_page_nohv(struct page *page)
+{
+	if (unlikely(PageCompound(page))) {
+		page = (struct page *)page_private(page);
+		if (put_page_testzero_nohv(page)) {
+			void (*dtor)(struct page *page);
+
+			dtor = (void (*)(struct page *))page[1].mapping;
+			(*dtor)(page);
+		}
+		return;
+	}
+	if (put_page_testzero_nohv(page))
+		__page_cache_release(page);
+}
+EXPORT_SYMBOL(put_page_nohv);
+
 /*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
@@ -218,7 +235,7 @@ void release_pages(struct page **pages, 
 		struct page *page = pages[i];
 		struct zone *pagezone;
 
-		if (!put_page_testzero(page))
+		if (!put_page_testzero_nohv(page))
 			continue;
 
 		pagezone = page_zone(page);
diff -urpN linux-2.6/mm/swap_state.c linux-2.6-patched/mm/swap_state.c
--- linux-2.6/mm/swap_state.c	2005-12-16 20:40:35.000000000 +0100
+++ linux-2.6-patched/mm/swap_state.c	2005-12-16 20:40:52.000000000 +0100
@@ -264,7 +264,7 @@ static inline void free_swap_cache(struc
 void free_page_and_swap_cache(struct page *page)
 {
 	free_swap_cache(page);
-	page_cache_release(page);
+	page_cache_release_nohv(page);
 }
 
 /*
