Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWIALKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWIALKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWIALKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:10:14 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:2936 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751476AbWIALKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:10:10 -0400
Date: Fri, 1 Sep 2006 13:10:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 4/9] Guest page hinting: volatile swap cache.
Message-ID: <20060901111006.GE15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 4/9] Guest page hinting: volatile swap cache.

The volatile page state can be used for anonymous pages as well, if
they have been added to the swap cache and the swap write is finished.
The tricky bit is in free_swap_and_cache. The call to find_get_page
dead-locks with the discard handler. If the page has been discarded
find_get_page will try to remove it. To do that it needs the page table
lock of all mappers but one is held by the caller of free_swap_and_cache.
A special variant of find_get_page is needed that does not check the
page state and returns a page reference even if the page is discarded.
The second pitfall is that the page needs to be made stable before the
swap slot gets freed. If the page cannot be made stable because it has
been discarded the swap slot may not be freed because it is still
needed to reload the discarded page from the swap device.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/pagemap.h |    7 ++++++
 include/linux/swap.h    |    5 ++++
 mm/filemap.c            |   19 ++++++++++++++++++
 mm/memory.c             |   12 +++++++++--
 mm/page-discard.c       |   26 ++++++++++++++++---------
 mm/rmap.c               |   49 ++++++++++++++++++++++++++++++++++++++++++++----
 mm/swap_state.c         |   24 ++++++++++++++++++++++-
 mm/swapfile.c           |   29 ++++++++++++++++++++++------
 8 files changed, 149 insertions(+), 22 deletions(-)

diff -urpN linux-2.6/include/linux/pagemap.h linux-2.6-patched/include/linux/pagemap.h
--- linux-2.6/include/linux/pagemap.h	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/include/linux/pagemap.h	2006-09-01 12:50:23.000000000 +0200
@@ -85,6 +85,13 @@ unsigned find_get_pages_contig(struct ad
 unsigned find_get_pages_tag(struct address_space *mapping, pgoff_t *index,
 			int tag, unsigned int nr_pages, struct page **pages);
 
+#if defined(CONFIG_PAGE_STATES)
+extern struct page * find_get_page_nodiscard(struct address_space *mapping,
+					     unsigned long index);
+#else
+#define find_get_page_nodiscard(mapping, index) find_get_page(mapping, index)
+#endif
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
diff -urpN linux-2.6/include/linux/swap.h linux-2.6-patched/include/linux/swap.h
--- linux-2.6/include/linux/swap.h	2006-09-01 12:49:32.000000000 +0200
+++ linux-2.6-patched/include/linux/swap.h	2006-09-01 12:50:23.000000000 +0200
@@ -229,6 +229,7 @@ extern struct address_space swapper_spac
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *, gfp_t);
 extern void __delete_from_swap_cache(struct page *);
+extern void __delete_from_swap_cache_nocheck(struct page *);
 extern void delete_from_swap_cache(struct page *);
 extern int move_to_swap_cache(struct page *, swp_entry_t);
 extern int move_from_swap_cache(struct page *, unsigned long,
@@ -345,6 +346,10 @@ static inline void __delete_from_swap_ca
 {
 }
 
+static inline void __delete_from_swap_cache_nocheck(struct page *page)
+{
+}
+
 static inline void delete_from_swap_cache(struct page *page)
 {
 }
diff -urpN linux-2.6/mm/filemap.c linux-2.6-patched/mm/filemap.c
--- linux-2.6/mm/filemap.c	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/mm/filemap.c	2006-09-01 12:50:23.000000000 +0200
@@ -602,6 +602,25 @@ int __probe_page(struct address_space *m
 	return !! radix_tree_lookup(&mapping->page_tree, offset);
 }
 
+#if defined(CONFIG_PAGE_STATES)
+
+struct page * find_get_page_nodiscard(struct address_space *mapping,
+				      unsigned long offset)
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
+EXPORT_SYMBOL(find_get_page_nodiscard);
+
+#endif
+
 /*
  * Here we just do not bother to grab the page, it's meaningless anyway.
  */
diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
--- linux-2.6/mm/memory.c	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/mm/memory.c	2006-09-01 12:50:23.000000000 +0200
@@ -2064,8 +2064,16 @@ static int do_swap_page(struct mm_struct
 	unlock_page(page);
 
 	if (write_access) {
-		if (do_wp_page(mm, vma, address,
-				page_table, pmd, ptl, pte) == VM_FAULT_OOM)
+		int rc = do_wp_page(mm, vma, address, page_table,
+				    pmd, ptl, pte);
+		if (page_host_discards() && rc == VM_FAULT_MAJOR)
+			/*
+			 * A discard removed the page, and do_wp_page called
+			 * page_discard which removed the pte as well.
+			 * handle_pte_fault needs to be repeated.
+			 */
+			ret = VM_FAULT_MINOR;
+		else if (rc == VM_FAULT_OOM)
 			ret = VM_FAULT_OOM;
 		goto out;
 	}
diff -urpN linux-2.6/mm/page-discard.c linux-2.6-patched/mm/page-discard.c
--- linux-2.6/mm/page-discard.c	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/mm/page-discard.c	2006-09-01 12:50:23.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/buffer_head.h>
+#include <linux/swap.h>
 
 #include "internal.h"
 
@@ -32,7 +33,8 @@ static inline int __page_discardable(str
 	 */
 	if (PageDirty(page) || PageReserved(page) || PageWriteback(page) ||
 	    PageLocked(page) || PagePrivate(page) || PageDiscarded(page) ||
-	    !PageUptodate(page) || !PageLRU(page) || PageAnon(page))
+	    !PageUptodate(page) || !PageLRU(page) ||
+	    (PageAnon(page) && !PageSwapCache(page)))
 		return 0;
 
 	/*
@@ -149,15 +151,21 @@ static void __page_discard(struct page *
 	}
 	spin_unlock_irq(&zone->lru_lock);
 
-	/* We can't handle swap cache pages (yet). */
-	BUG_ON(PageSwapCache(page));
-
-	/* Remove page from page cache. */
+	/* Remove page from page cache/swap cache. */
  	mapping = page->mapping;
-	write_lock_irq(&mapping->tree_lock);
-	__remove_from_page_cache_nocheck(page);
-	write_unlock_irq(&mapping->tree_lock);
-	__put_page(page);
+	if (PageSwapCache(page)) {
+		swp_entry_t entry = { .val = page_private(page) };
+		write_lock_irq(&swapper_space.tree_lock);
+		__delete_from_swap_cache_nocheck(page);
+		write_unlock_irq(&swapper_space.tree_lock);
+		swap_free(entry);
+		page_cache_release(page);
+	} else {
+		write_lock_irq(&mapping->tree_lock);
+		__remove_from_page_cache_nocheck(page);
+		write_unlock_irq(&mapping->tree_lock);
+ 		__put_page(page);
+	}
 }
 
 /**
diff -urpN linux-2.6/mm/rmap.c linux-2.6-patched/mm/rmap.c
--- linux-2.6/mm/rmap.c	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/mm/rmap.c	2006-09-01 12:50:23.000000000 +0200
@@ -537,6 +537,7 @@ void page_add_anon_rmap(struct page *pag
 	if (atomic_inc_and_test(&page->_mapcount))
 		__page_set_anon_rmap(page, vma, address);
 	/* else checking page index and mapping is racy */
+	page_make_volatile(page, 1);
 }
 
 /*
@@ -934,13 +935,13 @@ int try_to_unmap(struct page *page, int 
 #if defined(CONFIG_PAGE_STATES)
 
 /**
- * page_unmap_all - removes all mappings of a page
+ * page_unmap_file - removes all mappings of a file page
  *
  * @page: the page which mapping in the vma should be struck down
  *
  * the caller needs to hold page lock
  */
-void page_unmap_all(struct page* page)
+static void page_unmap_file(struct page* page)
 {
 	struct address_space *mapping = page_mapping(page);
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
@@ -948,8 +949,6 @@ void page_unmap_all(struct page* page)
 	struct prio_tree_iter iter;
 	unsigned long address;
 
-	BUG_ON(!PageLocked(page) || PageReserved(page) || PageAnon(page));
-
 	spin_lock(&mapping->i_mmap_lock);
 	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		address = vma_address(page, vma);
@@ -978,4 +977,46 @@ out:
 	spin_unlock(&mapping->i_mmap_lock);
 }
 
+/**
+ * page_unmap_anon - removes all mappings of an anonymous page
+ *
+ * @page: the page which mapping in the vma should be struck down
+ *
+ * the caller needs to hold page lock
+ */
+static void page_unmap_anon(struct page* page)
+{
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *vma;
+	unsigned long address;
+
+	anon_vma = page_lock_anon_vma(page);
+	if (!anon_vma)
+		return;
+	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
+		address = vma_address(page, vma);
+		if (address == -EFAULT)
+			continue;
+		BUG_ON(try_to_unmap_one(page, vma, address, 0) == SWAP_FAIL);
+	}
+	spin_unlock(&anon_vma->lock);
+}
+
+/**
+ * page_unmap_all - removes all mappings of a page
+ *
+ * @page: the page which mapping in the vma should be struck down
+ *
+ * the caller needs to hold page lock
+ */
+void page_unmap_all(struct page *page)
+{
+	BUG_ON(!PageLocked(page) || PageReserved(page));
+
+	if (PageAnon(page))
+		page_unmap_anon(page);
+	else
+		page_unmap_file(page);
+}
+
 #endif
diff -urpN linux-2.6/mm/swapfile.c linux-2.6-patched/mm/swapfile.c
--- linux-2.6/mm/swapfile.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/swapfile.c	2006-09-01 12:50:23.000000000 +0200
@@ -369,9 +369,11 @@ int remove_exclusive_swap_page(struct pa
 		/* Recheck the page count with the swapcache lock held.. */
 		write_lock_irq(&swapper_space.tree_lock);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
-			__delete_from_swap_cache(page);
-			SetPageDirty(page);
-			retval = 1;
+			if (likely(page_make_stable(page))) {
+				__delete_from_swap_cache(page);
+				SetPageDirty(page);
+				retval = 1;
+			}
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
 	}
@@ -400,7 +402,13 @@ void free_swap_and_cache(swp_entry_t ent
 	p = swap_info_get(entry);
 	if (p) {
 		if (swap_entry_free(p, swp_offset(entry)) == 1) {
-			page = find_get_page(&swapper_space, entry.val);
+			/*
+			 * Use find_get_page_nodiscard to avoid the deadlock
+			 * on the swap_lock and the page table lock if the
+			 * page has been discarded.
+			 */
+			page = find_get_page_nodiscard(&swapper_space,
+						       entry.val);
 			if (page && unlikely(TestSetPageLocked(page))) {
 				page_cache_release(page);
 				page = NULL;
@@ -417,8 +425,17 @@ void free_swap_and_cache(swp_entry_t ent
 		/* Also recheck PageSwapCache after page is locked (above) */
 		if (PageSwapCache(page) && !PageWriteback(page) &&
 					(one_user || vm_swap_full())) {
-			delete_from_swap_cache(page);
-			SetPageDirty(page);
+			/*
+			 * The caller of free_swap_and_cache holds a
+			 * page table lock for this page. A discarded
+			 * page can not be removed at this point. To be
+			 * able to reload the page from swap the swap
+			 * slot may not be freed.
+			 */
+			if (likely(page_make_stable(page))) {
+				delete_from_swap_cache(page);
+				SetPageDirty(page);
+			}
 		}
 		unlock_page(page);
 		page_cache_release(page);
diff -urpN linux-2.6/mm/swap_state.c linux-2.6-patched/mm/swap_state.c
--- linux-2.6/mm/swap_state.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/swap_state.c	2006-09-01 12:50:23.000000000 +0200
@@ -124,7 +124,7 @@ int add_to_swap_cache(struct page *page,
  * This must be called only on pages that have
  * been verified to be in the swap cache.
  */
-void __delete_from_swap_cache(struct page *page)
+void inline __delete_from_swap_cache_nocheck(struct page *page)
 {
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!PageSwapCache(page));
@@ -139,6 +139,28 @@ void __delete_from_swap_cache(struct pag
 	INC_CACHE_INFO(del_total);
 }
 
+void __delete_from_swap_cache(struct page *page)
+{
+	/*
+	 * Check if the discard fault handler already removed
+	 * the page from the page cache. If not set the discard
+	 * bit in the page flags to prevent double page free if
+	 * a discard fault is racing with normal page free.
+	 */
+	if (page_host_discards() && TestSetPageDiscarded(page))
+		return;
+
+	__delete_from_swap_cache_nocheck(page);
+
+	/*
+	 * Check the hardware page state and clear the discard
+	 * bit in the page flags only if the page is not
+	 * discarded.
+	 */
+	if (page_host_discards() && !page_discarded(page))
+		ClearPageDiscarded(page);
+}
+
 /**
  * add_to_swap - allocate swap space for a page
  * @page: page we want to move to swap
