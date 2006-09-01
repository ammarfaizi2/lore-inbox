Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWIALLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWIALLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWIALLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:11:11 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:63316 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751479AbWIALLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:11:08 -0400
Date: Fri, 1 Sep 2006 13:11:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 7/9] Guest page hinting: minor fault optimization.
Message-ID: <20060901111101.GH15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 7/9] Guest page hinting: minor fault optimization.

On of the challenges of hva is the cost for the state transitions.
If the cost gets too big the whole concept of page state information
is in question. Therefore it is very important to avoid the state
transitions for minor faults. Why change the page state to stable in
find_get_page and back in page_add_anon_rmap/page_add_file_rmap if the
discarded pages can be handled by the discard fault handler? If the page
is in page/swap cache just map it even if it is already discarded. The
first access to the page will cause a discard fault which needs to be
able to deal with this kind of situation anyway because of races in the
memory management.

To do this the special find_get_page_nodiscard variant introduced for
volatile swap cache is used which does not change the page state. The
call to find_get_page in filemap_nopage and filemap_getpage are replaced
with find_get_page_nodiscard. By the use of this function a new race
condition is created. If a minor fault races with the discard of a page
the page may not get mapped to the page table because the discard handler
removed the page from the cache which removes the page->mapping that is
needed to find the page table entry. A check for the PG_discarded bit is
added to do_swap_page and do_no_page. The page table lock for the pte
takes care of the synchronization.

After that there is only one state transition left in the minor fault.
page_add_anon_rmap/page_add_file_rmap try to get the page into volatile
state. If these two calls are removed we end up with almost all pages
in stable. The reason is that if a page is not uptodate yet, there is
an additional reference acquired from filemap_nopage. After the page
has been brought uptodate a page_make_volatile needs to be done
with an offset of 2 (page cache reference + additional reference from
filemap_nopage).

That removes the state transitions on the minor fault path. A page that
has been mapped will eventually be unmapped again. On the unmap path
each page that has been removed from the page table is freed with a call
to page_cache_release. In general that causes an unnecessary page state
transition from volatile to volatile. Not what we want. To get rid of
these state transitions as well special variants of put_page_testzero/
page_cache_release are introduced that do not attempt to make the page
volatile. page_cache_release_nocheck is then used in free_page_and_swap_cache
and release_pages. This makes the unmap of ptes state transitions free.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/mm.h      |   11 ++++--
 include/linux/pagemap.h |    5 ++
 include/linux/swap.h    |    2 -
 mm/filemap.c            |   81 +++++++++++++++++++++++++++++++++++++++++++-----
 mm/fremap.c             |    1 
 mm/memory.c             |    6 ++-
 mm/rmap.c               |    4 --
 mm/swap.c               |   26 ++++++++++++++-
 mm/swap_state.c         |    4 +-
 9 files changed, 120 insertions(+), 20 deletions(-)

diff -urpN linux-2.6/include/linux/mm.h linux-2.6-patched/include/linux/mm.h
--- linux-2.6/include/linux/mm.h	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/include/linux/mm.h	2006-09-01 12:50:25.000000000 +0200
@@ -311,11 +311,15 @@ struct page {
  * put_page_testzero checks if the page can be made volatile if the page
  * still has users and guest page hinting is enabled.
  */
-static inline int put_page_testzero(struct page *page)
+static inline int put_page_testzero_nocheck(struct page *page)
 {
-	int ret;
 	VM_BUG_ON(atomic_read(&page->_count) == 0);
-	ret = atomic_dec_and_test(&page->_count);
+	return atomic_dec_and_test(&page->_count);
+}
+
+static inline int put_page_testzero(struct page *page)
+{
+	int ret = put_page_testzero_nocheck(page);
 	if (!ret)
 		page_make_volatile(page, 1);
 	return ret;
@@ -356,6 +360,7 @@ static inline void init_page_count(struc
 }
 
 void put_page(struct page *page);
+void put_page_nocheck(struct page *page);
 void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
diff -urpN linux-2.6/include/linux/pagemap.h linux-2.6-patched/include/linux/pagemap.h
--- linux-2.6/include/linux/pagemap.h	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/include/linux/pagemap.h	2006-09-01 12:50:25.000000000 +0200
@@ -49,6 +49,11 @@ static inline void mapping_set_gfp_mask(
 
 #define page_cache_get(page)		get_page(page)
 #define page_cache_release(page)	put_page(page)
+#if defined(CONFIG_PAGE_STATES)
+#define page_cache_release_nocheck(page)	put_page_nocheck(page)
+#else
+#define page_cache_release_nocheck(page)	put_page(page)
+#endif
 void release_pages(struct page **pages, int nr, int cold);
 
 #ifdef CONFIG_NUMA
diff -urpN linux-2.6/include/linux/swap.h linux-2.6-patched/include/linux/swap.h
--- linux-2.6/include/linux/swap.h	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/include/linux/swap.h	2006-09-01 12:50:25.000000000 +0200
@@ -292,7 +292,7 @@ static inline void disable_swap_token(vo
 /* only sparc can not include linux/pagemap.h in this file
  * so leave page_cache_release and release_pages undeclared... */
 #define free_page_and_swap_cache(page) \
-	page_cache_release(page)
+	page_cache_release_nocheck(page)
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr), 0);
 
diff -urpN linux-2.6/mm/filemap.c linux-2.6-patched/mm/filemap.c
--- linux-2.6/mm/filemap.c	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/mm/filemap.c	2006-09-01 12:50:25.000000000 +0200
@@ -1185,6 +1185,12 @@ page_not_up_to_date:
 		/* Did somebody else fill it already? */
 		if (PageUptodate(page)) {
 			unlock_page(page);
+			/*
+			 * Because we held an additional reference
+			 * to the page while we read it in the page
+			 * could not be made volatile. Do it now.
+			 */
+			page_make_volatile(page, 2);
 			goto page_ok;
 		}
 
@@ -1576,13 +1582,13 @@ retry_all:
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
-	page = find_get_page(mapping, pgoff);
+	page = find_get_page_nodiscard(mapping, pgoff);
 	if (prefer_adaptive_readahead() && VM_SequentialReadHint(area)) {
 		if (!page) {
 			page_cache_readahead_adaptive(mapping, ra,
 						file, NULL, NULL,
 						pgoff, pgoff, pgoff + 1);
-			page = find_get_page(mapping, pgoff);
+			page = find_get_page_nodiscard(mapping, pgoff);
 		} else if (PageReadahead(page)) {
 			page_cache_readahead_adaptive(mapping, ra,
 						file, NULL, page,
@@ -1623,7 +1629,7 @@ retry_find:
 				start = pgoff - ra_pages / 2;
 			do_page_cache_readahead(mapping, file, start, ra_pages);
 		}
-		page = find_get_page(mapping, pgoff);
+		page = find_get_page_nodiscard(mapping, pgoff);
 		if (!page)
 			goto no_cached_page;
 	}
@@ -1709,14 +1715,27 @@ page_not_uptodate:
 	/* Did somebody else get it up-to-date? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		/*
+		 * Because we held an additional reference
+		 * to the page while we read it in the page
+		 * could not be made volatile. Do it now.
+		 */
+		page_make_volatile(page, 2);
 		goto success;
 	}
 
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
-		if (PageUptodate(page))
+		if (PageUptodate(page)) {
+			/*
+			 * Because we held an additional reference
+			 * to the page while we read it in the page
+			 * could not be made volatile. Do it now.
+			 */
+			page_make_volatile(page, 2);
 			goto success;
+		}
 	} else if (error == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry_find;
@@ -1740,14 +1759,27 @@ page_not_uptodate:
 	/* Somebody else successfully read it in? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		/*
+		 * Because we held an additional reference
+		 * to the page while we read it in the page
+		 * could not be made volatile. Do it now.
+		 */
+		page_make_volatile(page, 2);
 		goto success;
 	}
 	ClearPageError(page);
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
-		if (PageUptodate(page))
+		if (PageUptodate(page)) {
+			/*
+			 * Because we held an additional reference
+			 * to the page while we read it in the page
+			 * could not be made volatile. Do it now.
+			 */
+			page_make_volatile(page, 2);
 			goto success;
+		}
 	} else if (error == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry_find;
@@ -1774,7 +1806,14 @@ static struct page * filemap_getpage(str
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
-	page = find_get_page(mapping, pgoff);
+	/*
+	 * The find_get_page_nodiscard version of find_get_page will refrain
+	 * from moving the page to stable if page is found in page cache.
+	 * This an optimization for common case where most of the page cache
+	 * pages will not be in discarded state. In case the page indeed is
+	 * discarded, the access will result in a discard fault.
+	 */
+	page = find_get_page_nodiscard(mapping, pgoff);
 	if (!page) {
 		if (nonblock)
 			return NULL;
@@ -1830,14 +1869,27 @@ page_not_uptodate:
 	/* Did somebody else get it up-to-date? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		/*
+		 * Because we held an additional reference
+		 * to the page while we read it in the page
+		 * could not be made volatile. Do it now.
+		 */
+		page_make_volatile(page, 2);
 		goto success;
 	}
 
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
-		if (PageUptodate(page))
+		if (PageUptodate(page)) {
+			/*
+			 * Because we held an additional reference
+			 * to the page while we read it in the page
+			 * could not be made volatile. Do it now.
+			 */
+			page_make_volatile(page, 2);
 			goto success;
+		}
 	} else if (error == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry_find;
@@ -1859,6 +1911,12 @@ page_not_uptodate:
 	/* Somebody else successfully read it in? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		/*
+		 * Because we held an additional reference
+		 * to the page while we read it in the page
+		 * could not be made volatile. Do it now.
+		 */
+		page_make_volatile(page, 2);
 		goto success;
 	}
 
@@ -1866,8 +1924,15 @@ page_not_uptodate:
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
 		wait_on_page_locked(page);
-		if (PageUptodate(page))
+		if (PageUptodate(page)) {
+			/*
+			 * Because we held an additional reference
+			 * to the page while we read it in the page
+			 * could not be made volatile. Do it now.
+			 */
+			page_make_volatile(page, 2);
 			goto success;
+		}
 	} else if (error == AOP_TRUNCATED_PAGE) {
 		page_cache_release(page);
 		goto retry_find;
diff -urpN linux-2.6/mm/fremap.c linux-2.6-patched/mm/fremap.c
--- linux-2.6/mm/fremap.c	2006-09-01 12:50:25.000000000 +0200
+++ linux-2.6-patched/mm/fremap.c	2006-09-01 12:50:25.000000000 +0200
@@ -83,6 +83,7 @@ int install_page(struct mm_struct *mm, s
 	page_check_writable(page, pte_val);
 	set_pte_at(mm, addr, pte, pte_val);
 	page_add_file_rmap(page);
+	page_make_volatile(page, 1);
 	update_mmu_cache(vma, addr, pte_val);
 	lazy_mmu_prot_update(pte_val);
 	err = 0;
diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
--- linux-2.6/mm/memory.c	2006-09-01 12:50:25.000000000 +0200
+++ linux-2.6-patched/mm/memory.c	2006-09-01 12:50:25.000000000 +0200
@@ -2039,7 +2039,8 @@ static int do_swap_page(struct mm_struct
 	 * Back out if somebody else already faulted in this pte.
 	 */
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
-	if (unlikely(!pte_same(*page_table, orig_pte)))
+	if (unlikely(!pte_same(*page_table, orig_pte) ||
+		     (page_host_discards() && PageDiscarded(page))))
 		goto out_nomap;
 
 	if (unlikely(!PageUptodate(page))) {
@@ -2267,7 +2268,8 @@ retry:
 	 * handle that later.
 	 */
 	/* Only go through if we didn't race with anybody else... */
-	if (pte_none(*page_table)) {
+	if (pte_none(*page_table) &&
+	    !unlikely(page_host_discards() && PageDiscarded(new_page))) {
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
diff -urpN linux-2.6/mm/rmap.c linux-2.6-patched/mm/rmap.c
--- linux-2.6/mm/rmap.c	2006-09-01 12:50:25.000000000 +0200
+++ linux-2.6-patched/mm/rmap.c	2006-09-01 12:50:25.000000000 +0200
@@ -537,7 +537,6 @@ void page_add_anon_rmap(struct page *pag
 	if (atomic_inc_and_test(&page->_mapcount))
 		__page_set_anon_rmap(page, vma, address);
 	/* else checking page index and mapping is racy */
-	page_make_volatile(page, 1);
 }
 
 /*
@@ -566,7 +565,6 @@ void page_add_file_rmap(struct page *pag
 {
 	if (atomic_inc_and_test(&page->_mapcount))
 		__inc_zone_page_state(page, NR_FILE_MAPPED);
-	page_make_volatile(page, 1);
 }
 
 /**
@@ -694,7 +692,7 @@ static int try_to_unmap_one(struct page 
 
 
 	page_remove_rmap(page);
-	page_cache_release(page);
+	page_cache_release_nocheck(page);
 
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
diff -urpN linux-2.6/mm/swap.c linux-2.6-patched/mm/swap.c
--- linux-2.6/mm/swap.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/swap.c	2006-09-01 12:50:25.000000000 +0200
@@ -94,6 +94,30 @@ void put_pages_list(struct list_head *pa
 }
 EXPORT_SYMBOL(put_pages_list);
 
+#if defined(CONFIG_PAGE_STATES)
+
+static void put_compound_page_nocheck(struct page *page)
+{
+	page = (struct page *)page_private(page);
+	if (put_page_testzero_nocheck(page)) {
+		void (*dtor)(struct page *page);
+
+		dtor = (void (*)(struct page *))page[1].lru.next;
+		(*dtor)(page);
+	}
+}
+
+void put_page_nocheck(struct page *page)
+{
+	if (unlikely(PageCompound(page)))
+		put_compound_page_nocheck(page);
+	else if (put_page_testzero_nocheck(page))
+		__page_cache_release(page);
+}
+EXPORT_SYMBOL(put_page_nocheck);
+
+#endif
+
 /*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
@@ -304,7 +328,7 @@ void release_pages(struct page **pages, 
 			continue;
 		}
 
-		if (!put_page_testzero(page))
+		if (!put_page_testzero_nocheck(page))
 			continue;
 
 		if (PageLRU(page)) {
diff -urpN linux-2.6/mm/swap_state.c linux-2.6-patched/mm/swap_state.c
--- linux-2.6/mm/swap_state.c	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/mm/swap_state.c	2006-09-01 12:50:25.000000000 +0200
@@ -293,7 +293,7 @@ static inline void free_swap_cache(struc
 void free_page_and_swap_cache(struct page *page)
 {
 	free_swap_cache(page);
-	page_cache_release(page);
+	page_cache_release_nocheck(page);
 }
 
 /*
@@ -327,7 +327,7 @@ struct page * lookup_swap_cache(swp_entr
 {
 	struct page *page;
 
-	page = find_get_page(&swapper_space, entry.val);
+	page = find_get_page_nodiscard(&swapper_space, entry.val);
 
 	if (page)
 		INC_CACHE_INFO(find_success);
