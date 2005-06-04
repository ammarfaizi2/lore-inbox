Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFDVDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFDVDX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 17:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVFDVDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 17:03:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54697 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261252AbVFDVBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 17:01:40 -0400
Date: Sat, 4 Jun 2005 13:09:33 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Ray Bryant <raybry@engr.sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Mel Gorman <mel@csn.ul.ie>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <20050604160933.GA13953@logos.cnet>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay> <429E483D.8010106@yahoo.com.au> <434510000.1117670555@flay> <429E50B8.1060405@yahoo.com.au> <429F2B26.9070509@austin.ibm.com> <429F631E.6020401@engr.sgi.com> <429F67C4.9060506@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429F67C4.9060506@austin.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:10:44PM -0500, Joel Schopp wrote:
> >Could someone point me at the "Page migration defrag" patch, or
> >describe what this is.  Does this depend on the page migration
> >patches from memory hotplug to move pages or is it something
> >different?
> 
> I don't think anybody has actually written such a patch yet (correct me 
> if I'm wrong).  When somebody does it will certainly depend on the page 
> migration patches.  As far as describing what it is, the concept is 
> pretty simple.  Migrate in use pieces of memory around to make lots of 
> smaller unallocated memory into fewer larger unallocated memory.

I've tried to experiment with such memory defragmentation - this is the 
latest version (a bit crippled, with debugging printks's, etc). 

Major part of this patch is "creation" of nonblocking versions of the
page migration functions (which can be used by any defragmentation 
scheme).

The defragmentation I have implemented is pretty simple: coalesce_memory()
walks the highest order free list, looking for contiguous freeable
pages to migrate.

Testing shows that it works reliably - a test scenario which demands 
large amounts of high order pages shows great improvement: such awaraness 
makes it possible for the memory reclaim code to easily free contiguous 
regions, while in the current situation a scenario with a demand 
for high order pages simply crawls the box down while VM is madly 
reclaiming single pages. 

The problem with using the free lists as a starting point for 
inspection is that, under severe memory shortage, the probability
of finding freeable regions goes down as the number of pages
on the free list goes down. Ought to find another starting
point for inspection.

On the other side of the coin, it requires a huge amount of 
locking and data copying.


--- mmigrate.c.orig	2005-01-15 16:06:35.000000000 -0200
+++ mmigrate.c	2005-03-21 19:58:56.000000000 -0300
@@ -21,6 +21,9 @@
 #include <linux/rmap.h>
 #include <linux/mmigrate.h>
 #include <linux/delay.h>
+#include <linux/idr.h>
+#include <linux/page-flags.h>
+#include <linux/swap.h>
 
 /*
  * The concept of memory migration is to replace a target page with
@@ -36,6 +39,462 @@
  */
 
 
+struct page * migrate_onepage_nonblock(struct page *);
+
+
+int is_page_busy(struct page *page)
+{
+
+	if (PageLocked(page))
+		return -EBUSY;
+
+	if (PageWriteback(page))
+		return -EAGAIN;
+
+	if (!PageLRU(page))
+		return -ENOENT;
+
+	if (PageReserved(page))
+		return -EBUSY;
+
+	if (page_count(page) != 1)
+		return -EBUSY;
+
+	if (page_mapping(page) == NULL)
+		return -ENOENT;
+
+	return 0;
+}
+
+#define total_nr_freeable (back_nr_freeable + fwd_nr_freeable)
+
+extern inline void extract_pages(struct page *, struct zone *,
+                unsigned int, unsigned int,
+                struct free_area *);
+
+extern inline void set_page_order(struct page *page, int order);
+
+
+static void moveback_to_lru(struct list_head *list, struct zone *zone)
+{
+	struct page *page;
+
+	list_for_each_entry(page, list, lru) {
+		__putback_page_to_lru(zone, page);
+		page_cache_release(page);
+	}
+}
+
+static void moveback_to_freelist(struct page *page, struct zone *zone, unsigned int order)
+{
+	int order_size = 1UL << order;
+
+        zone->free_pages += order_size;
+	set_page_order(page, order);
+        list_add_tail(&page->lru, &zone->free_area[order].free_list);
+        zone->free_area[order].nr_free++;
+}
+
+int coalesce_memory(struct zone *zone, unsigned int order, struct list_head *freedlist)
+{
+	unsigned int max_order_delta = 2;
+	unsigned int torder, nr_pages;
+	unsigned int back_nr_freeable = 0, fwd_nr_freeable = 0;
+	int ret = 0;
+	unsigned long flags;
+
+
+	printk(KERN_ERR "coalesce_memory!!\n");
+
+
+	for (torder = order-1; torder > max_order_delta; torder--) {
+		struct list_head *entry;
+		struct page *page, *pwalk, *tmp;
+		struct free_area *area = zone->free_area + torder;
+		int count = area->nr_free;
+		LIST_HEAD(page_list);
+		LIST_HEAD(freed_page_list);
+
+		nr_pages = (1UL << order) - (1UL << torder); 
+
+		if (list_empty(&area->free_list))
+			continue;
+
+        	spin_lock_irqsave(&zone->lock, flags);
+
+		entry = area->free_list.next;
+
+		while (--count > 0) {
+			unsigned int wcount, freed = 0;
+			unsigned int back_moved = 0, fwd_moved = 0;
+			struct page *tpage, *npage = NULL;
+			int err = 0;
+
+			INIT_LIST_HEAD(&page_list);
+			INIT_LIST_HEAD(&freed_page_list);
+
+			back_nr_freeable = 0;
+			fwd_nr_freeable = 0; 
+
+			page = list_entry(entry, struct page, lru);
+			
+			/* Look backwards */
+			for (wcount=1; wcount<=nr_pages; wcount++) {
+				pwalk = page - wcount; 
+
+				if (!is_page_busy(pwalk))
+					back_nr_freeable++;
+				else {
+					err = 1;
+					break;
+				}
+
+				if (back_nr_freeable == nr_pages)
+					break;
+			}
+
+			if (err) {
+				entry = entry->next;
+				continue;
+			}
+
+			/* Look forward */
+			for (wcount = (1UL<<torder); wcount < nr_pages+(1UL<<torder); 
+				wcount++) {
+
+				if (total_nr_freeable == nr_pages)
+					break;
+
+				pwalk = page + wcount;
+				if (!is_page_busy(pwalk))
+					fwd_nr_freeable++;
+				else {
+					err = 1;
+					break;
+				}
+			}
+
+			if (err) {
+				entry = entry->next;
+				continue;
+			}
+
+			/* found enough freeable pages, remove the middle 
+		 	 * page from the free list, target pages 
+			 * pages from LRU, and try to migrate.
+			 */
+
+			extract_pages(page, zone, 0, torder, area); 
+
+			printk(KERN_ERR "extract page!\n");
+
+        		spin_unlock_irqrestore(&zone->lock, flags);
+
+			spin_lock_irq(&zone->lru_lock);
+
+			for (tpage = page - back_nr_freeable; tpage < page; tpage++) {
+
+				if (back_moved == back_nr_freeable)
+					break;
+
+				if (likely(PageLRU(tpage))) {
+					if (__steal_page_from_lru(zone, tpage)) {
+						back_moved++;
+						list_add(&tpage->lru, &page_list);
+						continue;
+					}
+				}
+					
+				moveback_to_lru(&page_list, zone);
+        			spin_unlock_irq(&zone->lru_lock);
+
+        			spin_lock_irqsave(&zone->lock, flags);
+				moveback_to_freelist(page, zone, torder);
+				err = 1;
+			}
+
+			if (err) {
+				entry = area->free_list.next;
+				continue;
+			}
+
+			for (tpage = page + (1UL<<torder);
+				tpage < page + (1UL<<torder) + fwd_nr_freeable; tpage++) {
+				if (fwd_moved == fwd_nr_freeable)
+					break;
+
+				if (likely(PageLRU(tpage))) {
+					if (__steal_page_from_lru(zone, tpage)) {
+						fwd_moved++;
+						list_add(&tpage->lru, &page_list);
+						continue;
+					}
+				}
+
+				moveback_to_lru(&page_list, zone);
+        			spin_unlock_irq(&zone->lru_lock);
+
+        			spin_lock_irqsave(&zone->lock, flags);
+				moveback_to_freelist(page, zone, torder);
+				err = 1;
+				break;
+			}
+
+			if (err) {
+				entry = area->free_list.next;
+				continue;
+			}
+
+			spin_unlock_irq(&zone->lru_lock);
+
+			list_for_each_entry_safe(tpage, tmp, &page_list, lru) {
+				list_del(&tpage->lru);
+				npage = migrate_onepage_nonblock(tpage);
+				
+				printk(KERN_ERR "migrate page!\n");
+
+				if (IS_ERR(npage)) {
+        				spin_lock_irq(&zone->lru_lock);
+					__putback_page_to_lru(zone, tpage);
+					page_cache_release(tpage);
+					moveback_to_lru(&page_list, zone);
+        				spin_unlock_irq(&zone->lru_lock);
+
+					printk(KERN_ERR "migrate failure!\n");
+
+
+				list_for_each_entry(tpage, &freed_page_list, lru) {
+				//	__putback_page_to_lru(zone, tpage);
+					if(page_count(tpage) != 1) {
+						printk(KERN_ERR "Damn, freed_list page has page_count!= 2 (%d) - flags:%lx\n", page_count(tpage), page->flags);
+						page_cache_release(tpage);
+					}
+				}
+
+        				spin_lock_irqsave(&zone->lock, flags);
+					moveback_to_freelist(page, zone, torder); 
+					break;
+				}
+
+				putback_page_to_lru(page_zone(npage), npage);
+				page_cache_release(npage);
+
+				list_add(&tpage->lru, &freed_page_list);
+				freed++;
+			}
+
+			if (freed == nr_pages) {
+
+				struct page *freed_page;
+				printk(KERN_ERR "successfully freed %d pages\n",
+					freed);
+				spin_lock_irqsave(&zone->lock, flags); 
+				moveback_to_freelist(page, zone, torder);
+        			spin_unlock_irqrestore(&zone->lock, flags);
+
+				list_for_each_entry(tpage, &freed_page_list, lru) {
+				//	__putback_page_to_lru(zone, tpage);
+					if(page_count(tpage) != 1) {
+						printk(KERN_ERR "Damn, freed_list page has page_count!= 1 (%d) - flags:%lx\n", page_count(tpage), page->flags);
+						page_cache_release(tpage);
+					}
+				}
+			
+				printk(KERN_ERR "successfully freed %d pages\n",
+				freed);
+
+				return 1;
+			} else {
+				struct page *freed_page;
+				spin_lock_irq(&zone->lru_lock);
+				list_for_each_entry(tpage, &freed_page_list, lru) {
+				//	__putback_page_to_lru(zone, tpage);
+					BUG_ON(page_count(tpage) != 1);
+					page_cache_release(tpage);
+				}
+        			spin_unlock_irq(&zone->lru_lock);
+				printk(KERN_ERR "could'nt free pages %d pages (only %d), bailing out!\n", nr_pages, freed);
+				return NULL;
+			}
+
+		}
+	}
+	
+	printk(KERN_ERR "finished loop but failed to migrate any page!\n");
+
+	return NULL;
+}
+
+
+struct counter {
+	int i;
+};
+
+struct idr migration_idr;
+
+static struct address_space_operations migration_aops = {
+        .writepage      = NULL,
+        .sync_page      = NULL,
+        .set_page_dirty = __set_page_dirty_nobuffers,
+};
+
+static struct backing_dev_info migration_backing_dev_info = {
+        .memory_backed  = 1,    /* Does not contribute to dirty memory */
+        .unplug_io_fn   = NULL,
+};
+
+struct address_space migration_space = {
+        .page_tree      = RADIX_TREE_INIT(GFP_ATOMIC),
+        .tree_lock      = RW_LOCK_UNLOCKED,
+        .a_ops          = &migration_aops,
+        .flags          = GFP_HIGHUSER,
+        .i_mmap_nonlinear = LIST_HEAD_INIT(migration_space.i_mmap_nonlinear),
+        .backing_dev_info = &migration_backing_dev_info,
+};
+
+int init_migration_cache(void) 
+{
+	idr_init(&migration_idr);
+
+	return 0;
+}
+
+__initcall(init_migration_cache);
+
+struct page *lookup_migration_cache(int id) 
+{ 
+	return find_get_page(&migration_space, id);
+}
+
+void migration_duplicate(swp_entry_t entry)
+{
+	struct counter *cnt;
+
+	read_lock_irq(&migration_space.tree_lock);
+
+	cnt = idr_find(&migration_idr, swp_offset(entry));
+	cnt->i = cnt->i + 1;
+
+	read_unlock_irq(&migration_space.tree_lock);
+}
+
+void remove_from_migration_cache(struct page *page, int id)
+{
+	write_lock_irq(&migration_space.tree_lock);
+        idr_remove(&migration_idr, id);
+	radix_tree_delete(&migration_space.page_tree, id);
+	ClearPageSwapCache(page);
+	page->private = NULL;
+	total_migration_pages--;
+	write_unlock_irq(&migration_space.tree_lock);
+}
+
+// FIXME: if the page is locked will it be correctly removed from migr cache?
+// check races
+
+void migration_remove_entry(swp_entry_t entry)
+{
+	struct page *page;
+	
+	page = find_get_page(&migration_space, entry.val);
+
+	if (!page)
+		BUG();
+
+	lock_page(page);	
+
+	migration_remove_reference(page, 1);
+
+	unlock_page(page);
+
+	page_cache_release(page);
+}
+
+int migration_remove_reference(struct page *page, int dec)
+{
+	struct counter *c;
+	swp_entry_t entry;
+
+	entry.val = page->private;
+
+	read_lock_irq(&migration_space.tree_lock);
+
+	c = idr_find(&migration_idr, swp_offset(entry));
+
+	read_unlock_irq(&migration_space.tree_lock);
+
+	BUG_ON(c->i < dec);
+
+	c->i -= dec;
+
+	if (!c->i) {
+		printk(KERN_ERR "removing page from migration cache!\n");
+		remove_from_migration_cache(page, page->private);
+		kfree(c);
+		page_cache_release(page);
+	}
+}
+
+int detach_from_migration_cache(struct page *page)
+{
+
+	lock_page(page);	
+	migration_remove_reference(page, 0);
+	unlock_page(page);
+
+	return 0;
+}
+
+int add_to_migration_cache(struct page *page, int gfp_mask) 
+{
+	int error, offset;
+	struct counter *counter;
+	swp_entry_t entry;
+	
+	BUG_ON(PageSwapCache(page));
+
+	BUG_ON(PagePrivate(page));
+
+        if (idr_pre_get(&migration_idr, GFP_ATOMIC) == 0)
+                return -ENOMEM;
+
+	counter = kmalloc(sizeof(struct counter), GFP_KERNEL);
+
+	if (!counter)
+		return -ENOMEM;
+
+	error = radix_tree_preload(gfp_mask);
+
+	counter->i = 0;
+
+	printk(KERN_ERR "adding to migration cache!\n");
+
+	if (!error) {
+		write_lock_irq(&migration_space.tree_lock);
+	        error = idr_get_new_above(&migration_idr, counter, 1, &offset);
+
+		if (error < 0)
+			BUG();
+
+		entry = swp_entry(MIGRATION_TYPE, offset);
+
+		error = radix_tree_insert(&migration_space.page_tree, entry.val,
+							page);
+		if (!error) {
+			page_cache_get(page);
+			SetPageLocked(page);
+			page->private = entry.val;
+			total_migration_pages++;
+			SetPageSwapCache(page);
+		}
+		write_unlock_irq(&migration_space.tree_lock);
+                radix_tree_preload_end();
+
+	}
+
+	return error;
+}
+
 /*
  * Try to writeback a dirty page to free its buffers.
  */
@@ -121,9 +580,11 @@
 	if (PageWriteback(page))
 		return -EAGAIN;
 	/* The page might have been truncated */
-	truncated = !PageSwapCache(newpage) && page_mapping(page) == NULL;
-	if (page_count(page) + truncated <= freeable_page_count)
+	truncated = !PageSwapCache(newpage) &&
+		page_mapping(page) == NULL;
+	if (page_count(page) + truncated <= freeable_page_count) 
 		return truncated ? -ENOENT : 0;
+
 	return -EAGAIN;
 }
 
@@ -133,7 +594,7 @@
  */
 int
 migrate_page_common(struct page *page, struct page *newpage,
-					struct list_head *vlist)
+					struct list_head *vlist, int block)
 {
 	long timeout = 5000;	/* XXXX */
 	int ret;
@@ -149,6 +610,8 @@
 		case -EBUSY:
 			return ret;
 		case -EAGAIN:
+			if (!block)
+				return ret;
 			writeback_and_free_buffers(page);
 			unlock_page(page);
 			msleep(10);
@@ -268,6 +731,136 @@
 	return 0;
 }
 
+
+/*
+ * Try to migrate one page.  Returns non-zero on failure.
+ *   - Lock for the page must be held when invoked.
+ *   - The page must be attached to an address_space.
+ */
+int
+generic_migrate_page_nonblock(struct page *page, struct page *newpage,
+	int (*migrate_fn)(struct page *, struct page *, struct list_head *, int))
+{
+	int ret;
+
+	/*
+	 * Make sure that the newpage must be locked and keep not up-to-date
+	 * during the page migration, so that it's guaranteed that all
+	 * accesses to the newpage will be blocked until everything has
+	 * become ok.
+	 */
+	if (TestSetPageLocked(newpage))
+		BUG();
+
+	if ((ret = replace_pages(page, newpage)))
+		goto out_removing;
+
+	/*
+	 * With cleared PTEs, any accesses via the PTEs to the page
+	 * can be caught and blocked in a pagefault handler.
+	 */
+	if (page_mapped(page)) {
+		if ((ret = try_to_unmap(page, NULL)) != SWAP_SUCCESS) {
+			ret = -EBUSY;
+			goto out_busy;
+		}
+	}
+
+	if (PageSwapCache(page)) {
+		/*
+		 * The page is not mapped from anywhere now.
+		 * Detach it from the swapcache completely.
+		 */
+		ClearPageSwapCache(page);
+		page->private = 0;
+		page->mapping = NULL;
+	}
+
+	ret = migrate_fn(page, newpage, NULL, 0);
+	switch (ret) {
+	default:
+		/* The page is busy. Try it later. */
+		goto out_busy;
+	case -ENOENT:
+		/* The file the page belongs to has been truncated. */
+		page_cache_get(page);
+		page_cache_release(newpage);
+		newpage->mapping = NULL;
+		/* fall thru */
+	case 0:
+		/* fall thru */
+	}
+
+	arch_migrate_page(page, newpage);
+
+	if (PageError(page))
+		SetPageError(newpage);
+	if (PageReferenced(page))
+		SetPageReferenced(newpage);
+	if (PageActive(page)) {
+		SetPageActive(newpage);
+		ClearPageActive(page);
+	}
+	if (PageMappedToDisk(page))
+		SetPageMappedToDisk(newpage);
+	if (PageChecked(page))
+		SetPageChecked(newpage);
+	if (PageUptodate(page))
+		SetPageUptodate(newpage);
+	if (PageDirty(page)) {
+		clear_page_dirty_for_io(page);
+		/* this will make a whole page dirty (if it has buffers) */
+		set_page_dirty(newpage);
+	}
+	if (PagePrivate(newpage)) {
+		BUG_ON(newpage->mapping == NULL);
+		unlock_page_buffer(newpage);
+	}
+
+	if (PageWriteback(newpage))
+		BUG();
+
+	unlock_page(newpage);
+
+	/* map the newpage where the old page have been mapped. */
+	if (PageMigration(newpage))
+		detach_from_migration_cache(newpage);
+	else if (PageSwapCache(newpage)) {
+		lock_page(newpage);
+		__remove_exclusive_swap_page(newpage, 1);
+		unlock_page(newpage);
+	}
+
+	page->mapping = NULL;
+	unlock_page(page);
+	page_cache_release(page);
+
+	return 0;
+
+out_busy:
+	/* Roll back all operations. */
+	unwind_page(page, newpage);
+/*	touch_unmapped_address(&vlist);
+	if (PageMigration(page))
+		detach_from_migration_cache(page);
+	else if (PageSwapCache(page)) {
+		lock_page(page);
+		__remove_exclusive_swap_page(page, 1);
+		unlock_page(page);
+	} */
+
+	return ret;
+
+out_removing:
+	if (PagePrivate(newpage))
+		BUG();
+	unlock_page(page);
+	unlock_page(newpage);
+	if (PageMigration(page))
+		detach_from_migration_cache(page);
+	return ret;
+}
+
 /*
  * Try to migrate one page.  Returns non-zero on failure.
  *   - Lock for the page must be held when invoked.
@@ -275,7 +868,7 @@
  */
 int
 generic_migrate_page(struct page *page, struct page *newpage,
-	int (*migrate_fn)(struct page *, struct page *, struct list_head *))
+	int (*migrate_fn)(struct page *, struct page *, struct list_head *, int))
 {
 	LIST_HEAD(vlist);
 	int ret;
@@ -317,7 +910,7 @@
 	}
 
 	/* Wait for all operations against the page to finish. */
-	ret = migrate_fn(page, newpage, &vlist);
+	ret = migrate_fn(page, newpage, &vlist, 1);
 	switch (ret) {
 	default:
 		/* The page is busy. Try it later. */
@@ -367,7 +960,9 @@
 
 	/* map the newpage where the old page have been mapped. */
 	touch_unmapped_address(&vlist);
-	if (PageSwapCache(newpage)) {
+	if (PageMigration(newpage))
+		detach_from_migration_cache(newpage);
+	else if (PageSwapCache(newpage)) {
 		lock_page(newpage);
 		__remove_exclusive_swap_page(newpage, 1);
 		unlock_page(newpage);
@@ -383,7 +978,9 @@
 	/* Roll back all operations. */
 	unwind_page(page, newpage);
 	touch_unmapped_address(&vlist);
-	if (PageSwapCache(page)) {
+	if (PageMigration(page))
+		detach_from_migration_cache(page);
+	else if (PageSwapCache(page)) {
 		lock_page(page);
 		__remove_exclusive_swap_page(page, 1);
 		unlock_page(page);
@@ -396,6 +993,8 @@
 		BUG();
 	unlock_page(page);
 	unlock_page(newpage);
+	if (PageMigration(page))
+		detach_from_migration_cache(page);
 	return ret;
 }
 
@@ -417,10 +1016,14 @@
 	 */
 #ifdef CONFIG_SWAP
 	if (PageAnon(page) && !PageSwapCache(page))
-		if (!add_to_swap(page, GFP_KERNEL)) {
+		if (add_to_migration_cache(page, GFP_KERNEL)) {
 			unlock_page(page);
 			return ERR_PTR(-ENOSPC);
 		}
+/*		if (!add_to_swap(page, GFP_KERNEL)) {
+			unlock_page(page);
+			return ERR_PTR(-ENOSPC);
+		} */
 #endif /* CONFIG_SWAP */
 	if ((mapping = page_mapping(page)) == NULL) {
 		/* truncation is in progress */
@@ -440,8 +1043,9 @@
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (mapping->a_ops->migrate_page)
+	if (mapping->a_ops && mapping->a_ops->migrate_page) {
 		ret = mapping->a_ops->migrate_page(page, newpage);
+	}
 	else
 		ret = generic_migrate_page(page, newpage, migrate_page_common);
 	if (ret) {
@@ -454,6 +1058,59 @@
 	return newpage;
 }
 
+/*
+ * migrate_onepage_nonblock() is equivalent to migrate_onepage() but fails 
+ * if the page is busy.
+ */
+struct page *
+migrate_onepage_nonblock(struct page *page)
+{
+	struct page *newpage;
+	struct address_space *mapping;
+	int ret;
+
+	if (TestSetPageLocked(page))
+		return ERR_PTR(-EBUSY);
+
+	/*
+	 * Put the page in a radix tree if it isn't in the tree yet.
+	 */
+	if (PageAnon(page) && !PageSwapCache(page)) {
+		if (add_to_migration_cache(page, GFP_KERNEL)) {
+			unlock_page(page);
+			return ERR_PTR(-ENOSPC);
+		}
+	}
+
+	if ((mapping = page_mapping(page)) == NULL)
+		return ERR_PTR(-ENOENT); 
+
+	/*
+	 * Allocate a new page with the same gfp_mask
+	 * as the target page has.
+	 */
+	newpage = page_cache_alloc(mapping);
+	if (newpage == NULL) {
+		unlock_page(page);
+		return ERR_PTR(-ENOMEM);
+	}
+
+
+	if (mapping->a_ops && mapping->a_ops->migrate_page) {
+		ret = mapping->a_ops->migrate_page(page, newpage);
+	}
+	else
+		ret = generic_migrate_page_nonblock(page, newpage, migrate_page_common);
+	if (ret) {
+		BUG_ON(page_count(newpage) != 1);
+		page_cache_release(newpage);
+		return ERR_PTR(ret);
+	}
+	BUG_ON(page_count(page) != 1);
+//	page_cache_release(page);
+	return newpage;
+}
+
 static inline int
 need_writeback(struct page *page)
 {


