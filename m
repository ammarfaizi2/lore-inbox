Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVLSTlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVLSTlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVLSTl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:41:26 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:62179 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964900AbVLSTlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:41:24 -0500
Date: Mon, 19 Dec 2005 11:41:18 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hirokazu Takahashi <taka@valinux.co.jp>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Cliff Wickman <cpw@sgi.com>, Christoph Lameter <clameter@sgi.com>,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051219194118.20715.86748.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051219194108.20715.39379.sendpatchset@schroedinger.engr.sgi.com>
References: <20051219194108.20715.39379.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/5] Direct Migration V8: migrate_pages() extension
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add direct migration support with fall back to swap.

Direct migration support on top of the swap based page migration facility.

This allows the direct migration of anonymous pages and the migration of
file backed pages by dropping the associated buffers (requires writeout).

Fall back to swap out if necessary.

The patch is based on lots of patches from the hotplug project but the code
was restructured, documented and simplified as much as possible.

Note that an additional patch that defines the migrate_page() method
for filesystems is necessary in order to avoid writeback for anonymous
and file backed pages.

V7->V8:
 - Fixed by KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>:
    copy raw page->index and page->mapping to new page.

V6->V7:
 - Patch against 2.6.15-rc5-mm1.
 - Replace one occurrence of page->mapping with page_mapping(page) in
   migrate_pages_remove_references()

V4->V5:
 - Patch against 2.6.15-rc2-mm1 + double unlock fix + consolidation patch

V3->V4:
- Remove components already in the swap migration patch

V1->V2:
- Change migrate_pages() so that it can return pagelist for failed and
  moved pages. No longer free the old pages but allow caller to dispose
  of them.
- Unmap pages before changing reverse map under tree lock. Take
  a write_lock instead of a read_lock.
- Add documentation

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/swap.h	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/swap.h	2005-12-19 11:32:23.000000000 -0800
@@ -178,6 +178,9 @@ extern int vm_swappiness;
 #ifdef CONFIG_MIGRATION
 extern int isolate_lru_page(struct page *p);
 extern int putback_lru_pages(struct list_head *l);
+extern int migrate_page(struct page *, struct page *);
+extern int migrate_page_remove_references(struct page *, struct page *, int);
+extern void migrate_page_copy(struct page *, struct page *);
 extern int migrate_pages(struct list_head *l, struct list_head *t,
 		struct list_head *moved, struct list_head *failed);
 #endif
Index: linux-2.6.15-rc5-mm3/Documentation/vm/page_migration
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm3/Documentation/vm/page_migration	2005-12-19 11:39:53.000000000 -0800
@@ -0,0 +1,129 @@
+Page migration
+--------------
+
+Page migration allows the moving of the physical location of pages between
+nodes in a numa system while the process is running. This means that the
+virtual addresses that the process sees do not change. However, the
+system rearranges the physical location of those pages.
+
+The main intend of page migration is to reduce the latency of memory access
+by moving pages near to the processor where the process accessing that memory
+is running.
+
+Page migration allows a process to manually relocate the node on which its
+pages are located through the MF_MOVE and MF_MOVE_ALL options while setting
+a new memory policy. The pages of process can also be relocated
+from another process using the sys_migrate_pages() function call. The
+migrate_pages function call takes two sets of nodes and moves pages of a
+process that are located on the from nodes to the destination nodes.
+
+Manual migration is very useful if for example the scheduler has relocated
+a process to a processor on a distant node. A batch scheduler or an
+administrator may detect the situation and move the pages of the process
+nearer to the new processor. At some point in the future we may have
+some mechanism in the scheduler that will automatically move the pages.
+
+Larger installations usually partition the system using cpusets into
+sections of nodes. Paul Jackson has equipped cpusets with the ability to
+move pages when a task is moved to another cpuset. This allows automatic
+control over locality of a process. If a task is moved to a new cpuset
+then also all its pages are moved with it so that the performance of the
+process does not sink dramatically (as is the case today).
+
+Page migration allows the preservation of the relative location of pages
+within a group of nodes for all migration techniques which will preserve a
+particular memory allocation pattern generated even after migrating a
+process. This is necessary in order to preserve the memory latencies.
+Processes will run with similar performance after migration.
+
+Page migration occurs in several steps. First a high level
+description for those trying to use migrate_pages() and then
+a low level description of how the low level details work.
+
+A. Use of migrate_pages()
+-------------------------
+
+1. Remove pages from the LRU.
+
+   Lists of pages to be migrated are generated by scanning over
+   pages and moving them into lists. This is done by
+   calling isolate_lru_page() or __isolate_lru_page().
+   Calling isolate_lru_page increases the references to the page
+   so that it cannot vanish under us.
+
+2. Generate a list of newly allocates page to move the contents
+   of the first list to.
+
+3. The migrate_pages() function is called which attempts
+   to do the migration. It returns the moved pages in the
+   list specified as the third parameter and the failed
+   migrations in the fourth parameter. The first parameter
+   will contain the pages that could still be retried.
+
+4. The leftover pages of various types are returned
+   to the LRU using putback_to_lru_pages() or otherwise
+   disposed of. The pages will still have the refcount as
+   increased by isolate_lru_pages()!
+
+B. Operation of migrate_pages()
+--------------------------------
+
+migrate_pages does several passes over its list of pages. A page is moved
+if all references to a page are removable at the time.
+
+Steps:
+
+1. Lock the page to be migrated
+
+2. Insure that writeback is complete.
+
+3. Make sure that the page has assigned swap cache entry if
+   it is an anonyous page. The swap cache reference is necessary
+   to preserve the information contain in the page table maps.
+
+4. Prep the new page that we want to move to. It is locked
+   and set to not being uptodate so that all accesses to the new
+   page immediately lock while we are moving references.
+
+5. All the page table references to the page are either dropped (file backed)
+   or converted to swap references (anonymous pages). This should decrease the
+   reference count.
+
+6. The radix tree lock is taken
+
+7. The refcount of the page is examined and we back out if references remain
+   otherwise we know that we are the only one referencing this page.
+
+8. The radix tree is checked and if it does not contain the pointer to this
+   page then we back out.
+
+9. The mapping is checked. If the mapping is gone then a truncate action may
+   be in progress and we back out.
+
+10. The new page is prepped with some settings from the old page so that accesses
+   to the new page will be discovered to have the correct settings.
+
+11. The radix tree is changed to point to the new page.
+
+12. The reference count of the old page is dropped because the reference has now
+    been removed.
+
+13. The radix tree lock is dropped.
+
+14. The page contents are copied to the new page.
+
+15. The remaining page flags are copied to the new page.
+
+16. The old page flags are cleared to indicate that the page does
+    not use any information anymore.
+
+17. Queued up writeback on the new page is triggered.
+
+18. If swap pte's were generated for the page then remove them again.
+
+19. The locks are dropped from the old and new page.
+
+20. The new page is moved to the LRU.
+
+Christoph Lameter, December 19, 2005.
+
Index: linux-2.6.15-rc5-mm3/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/vmscan.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/vmscan.c	2005-12-19 11:32:23.000000000 -0800
@@ -653,6 +653,164 @@ retry:
 	return -EAGAIN;
 }
 /*
+ * Page migration was first developed in the context of the memory hotplug
+ * project. The main authors of the migration code are:
+ *
+ * IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
+ * Hirokazu Takahashi <taka@valinux.co.jp>
+ * Dave Hansen <haveblue@us.ibm.com>
+ * Christoph Lameter <clameter@sgi.com>
+ */
+
+/*
+ * Remove references for a page and establish the new page with the correct
+ * basic settings to be able to stop accesses to the page.
+ */
+int migrate_page_remove_references(struct page *newpage, struct page *page, int nr_refs)
+{
+	struct address_space *mapping = page_mapping(page);
+	struct page **radix_pointer;
+	int i;
+
+	/*
+	 * Avoid doing any of the following work if the page count
+	 * indicates that the page is in use or truncate has removed
+	 * the page.
+	 */
+	if (!mapping || page_mapcount(page) + nr_refs != page_count(page))
+		return 1;
+
+	/*
+	 * Establish swap ptes for anonymous pages or destroy pte
+	 * maps for files.
+	 *
+	 * In order to reestablish file backed mappings the fault handlers
+	 * will take the radix tree_lock which may then be used to stop
+  	 * processses from accessing this page until the new page is ready.
+	 *
+	 * A process accessing via a swap pte (an anonymous page) will take a
+	 * page_lock on the old page which will block the process until the
+	 * migration attempt is complete. At that time the PageSwapCache bit
+	 * will be examined. If the page was migrated then the PageSwapCache
+	 * bit will be clear and the operation to retrieve the page will be
+	 * retried which will find the new page in the radix tree. Then a new
+	 * direct mapping may be generated based on the radix tree contents.
+	 *
+	 * If the page was not migrated then the PageSwapCache bit
+	 * is still set and the operation may continue.
+	 */
+	for(i = 0; i < 10 && page_mapped(page); i++) {
+		int rc = try_to_unmap(page);
+
+		if (rc == SWAP_SUCCESS)
+			break;
+		/*
+		 * If there are other runnable processes then running
+		 * them may make it possible to unmap the page
+		 */
+		schedule();
+	}
+
+	/*
+	 * Give up if we were unable to remove all mappings.
+	 */
+	if (page_mapcount(page))
+		return 1;
+
+	write_lock_irq(&mapping->tree_lock);
+
+	radix_pointer = (struct page **)radix_tree_lookup_slot(
+						&mapping->page_tree,
+						page_index(page));
+
+	if (!page_mapping(page) ||
+	    page_count(page) != nr_refs ||
+	    *radix_pointer != page) {
+		write_unlock_irq(&mapping->tree_lock);
+		return 1;
+	}
+
+	/*
+	 * Now we know that no one else is looking at the page.
+	 *
+	 * Certain minimal information about a page must be available
+	 * in order for other subsystems to properly handle the page if they
+	 * find it through the radix tree update before we are finished
+	 * copying the page.
+	 */
+	get_page(newpage);
+	newpage->index = page->index;
+	newpage->mapping = page->mapping;
+	if (PageSwapCache(page)) {
+		SetPageSwapCache(newpage);
+		set_page_private(newpage, page_private(page));
+	}
+
+	*radix_pointer = newpage;
+	__put_page(page);
+	write_unlock_irq(&mapping->tree_lock);
+
+	return 0;
+}
+
+/*
+ * Copy the page to its new location
+ */
+void migrate_page_copy(struct page *newpage, struct page *page)
+{
+	copy_highpage(newpage, page);
+
+	if (PageError(page))
+		SetPageError(newpage);
+	if (PageReferenced(page))
+		SetPageReferenced(newpage);
+	if (PageUptodate(page))
+		SetPageUptodate(newpage);
+	if (PageActive(page))
+		SetPageActive(newpage);
+	if (PageChecked(page))
+		SetPageChecked(newpage);
+	if (PageMappedToDisk(page))
+		SetPageMappedToDisk(newpage);
+
+	if (PageDirty(page)) {
+		clear_page_dirty_for_io(page);
+		set_page_dirty(newpage);
+ 	}
+
+	ClearPageSwapCache(page);
+	ClearPageActive(page);
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+	page->mapping = NULL;
+
+	/*
+	 * If any waiters have accumulated on the new page then
+	 * wake them up.
+	 */
+	if (PageWriteback(newpage))
+		end_page_writeback(newpage);
+}
+
+/*
+ * Common logic to directly migrate a single page suitable for
+ * pages that do not use PagePrivate.
+ *
+ * Pages are locked upon entry and exit.
+ */
+int migrate_page(struct page *newpage, struct page *page)
+{
+	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
+
+	if (migrate_page_remove_references(newpage, page, 2))
+		return -EAGAIN;
+
+	migrate_page_copy(newpage, page);
+
+	return 0;
+}
+
+/*
  * migrate_pages
  *
  * Two lists are passed to this function. The first list
@@ -665,11 +823,6 @@ retry:
  * are movable anymore because t has become empty
  * or no retryable pages exist anymore.
  *
- * SIMPLIFIED VERSION: This implementation of migrate_pages
- * is only swapping out pages and never touches the second
- * list. The direct migration patchset
- * extends this function to avoid the use of swap.
- *
  * Return: Number of pages not migrated when "to" ran empty.
  */
 int migrate_pages(struct list_head *from, struct list_head *to,
@@ -690,6 +843,9 @@ redo:
 	retry = 0;
 
 	list_for_each_entry_safe(page, page2, from, lru) {
+		struct page *newpage = NULL;
+		struct address_space *mapping;
+
 		cond_resched();
 
 		rc = 0;
@@ -697,6 +853,9 @@ redo:
 			/* page was freed from under us. So we are done. */
 			goto next;
 
+		if (to && list_empty(to))
+			break;
+
 		/*
 		 * Skip locked pages during the first two passes to give the
 		 * functions holding the lock time to release the page. Later we
@@ -733,12 +892,64 @@ redo:
 			}
 		}
 
+		if (!to) {
+			rc = swap_page(page);
+			goto next;
+		}
+
+		newpage = lru_to_page(to);
+		lock_page(newpage);
+
 		/*
-		 * Page is properly locked and writeback is complete.
+		 * Pages are properly locked and writeback is complete.
 		 * Try to migrate the page.
 		 */
-		rc = swap_page(page);
-		goto next;
+		mapping = page_mapping(page);
+		if (!mapping)
+			goto unlock_both;
+
+		/*
+		 * Trigger writeout if page is dirty
+		 */
+		if (PageDirty(page)) {
+			switch (pageout(page, mapping)) {
+			case PAGE_KEEP:
+			case PAGE_ACTIVATE:
+				goto unlock_both;
+
+			case PAGE_SUCCESS:
+				unlock_page(newpage);
+				goto next;
+
+			case PAGE_CLEAN:
+				; /* try to migrate the page below */
+			}
+                }
+		/*
+		 * If we have no buffer or can release the buffer
+		 * then do a simple migration.
+		 */
+		if (!page_has_buffers(page) ||
+		    try_to_release_page(page, GFP_KERNEL)) {
+			rc = migrate_page(newpage, page);
+			goto unlock_both;
+		}
+
+		/*
+		 * On early passes with mapped pages simply
+		 * retry. There may be a lock held for some
+		 * buffers that may go away. Later
+		 * swap them out.
+		 */
+		if (pass > 4) {
+			unlock_page(newpage);
+			newpage = NULL;
+			rc = swap_page(page);
+			goto next;
+		}
+
+unlock_both:
+		unlock_page(newpage);
 
 unlock_page:
 		unlock_page(page);
@@ -751,7 +962,10 @@ next:
 			list_move(&page->lru, failed);
 			nr_failed++;
 		} else {
-			/* Success */
+			if (newpage)
+				/* Successful migration. Return new page to LRU */
+				move_to_lru(newpage);
+
 			list_move(&page->lru, moved);
 		}
 	}
