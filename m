Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVLPMpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVLPMpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVLPMpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:45:11 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:48780 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932251AbVLPMpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:45:09 -0500
Message-Id: <20051216130828.786919000@localhost.localdomain>
References: <20051216130738.300284000@localhost.localdomain>
Date: Fri, 16 Dec 2005 21:07:40 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 02/12] readahead: some preparation
Content-Disposition: inline; filename=readahead-prepare.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some random changes that do not fit in elsewhere.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h |    7 +
 mm/filemap.c       |    4 +
 mm/readahead.c     |  197 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 199 insertions(+), 9 deletions(-)

--- linux.orig/include/linux/mm.h
+++ linux/include/linux/mm.h
@@ -1008,6 +1008,13 @@ void handle_ra_miss(struct address_space
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
 
+#ifdef CONFIG_DEBUG_FS
+extern u32 readahead_debug_level;
+#define READAHEAD_DEBUG_LEVEL(n)	(readahead_debug_level >= n)
+#else
+#define READAHEAD_DEBUG_LEVEL(n)	(0)
+#endif
+
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 #ifdef CONFIG_IA64
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -15,13 +15,63 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+/* The default max/min read-ahead pages. */
+#define KB(size)	(((size)*1024 + PAGE_CACHE_SIZE-1) / PAGE_CACHE_SIZE)
+#define MAX_RA_PAGES	KB(VM_MAX_READAHEAD)
+#define MIN_RA_PAGES	KB(VM_MIN_READAHEAD)
+
+#define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
+#define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
+
+/*
+ * Debug facilities.
+ */
+#ifdef CONFIG_DEBUG_FS
+#define DEBUG_READAHEAD
+#endif
+
+#ifdef DEBUG_READAHEAD
+#define dprintk(args...) \
+	do { if (READAHEAD_DEBUG_LEVEL(1)) printk(KERN_DEBUG args); } while(0)
+#define ddprintk(args...) \
+	do { if (READAHEAD_DEBUG_LEVEL(2)) printk(KERN_DEBUG args); } while(0)
+#else
+#define dprintk(args...)	do { } while(0)
+#define ddprintk(args...)	do { } while(0)
+#endif
+
+#ifdef DEBUG_READAHEAD
+#include <linux/jiffies.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+
+u32 readahead_debug_level = 0;
+
+static int __init readahead_init(void)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("readahead", NULL);
+
+	debugfs_create_u32("debug_level", 0644, root, &readahead_debug_level);
+
+	return 0;
+}
+
+module_init(readahead_init)
+#else /* !DEBUG_READAHEAD */
+
+#endif /* DEBUG_READAHEAD */
+
+
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
 EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
-	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.ra_pages	= MAX_RA_PAGES,
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
@@ -50,7 +100,7 @@ static inline unsigned long get_max_read
 
 static inline unsigned long get_min_readahead(struct file_ra_state *ra)
 {
-	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	return MIN_RA_PAGES;
 }
 
 static inline void ra_off(struct file_ra_state *ra)
@@ -258,10 +308,11 @@ out:
  */
 static int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			pgoff_t offset, unsigned long nr_to_read)
+			pgoff_t offset, unsigned long nr_to_read,
+			unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
+	struct page *page = NULL;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
@@ -271,7 +322,7 @@ __do_page_cache_readahead(struct address
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -284,8 +335,14 @@ __do_page_cache_readahead(struct address
 			break;
 
 		page = radix_tree_lookup(&mapping->page_tree, page_offset);
-		if (page)
+		if (page) {
+#ifdef READAHEAD_NONBLOCK
+			if (prefer_adaptive_readahead() &&
+				page_idx == nr_to_read - lookahead_size)
+				SetPageReadahead(page);
+#endif
 			continue;
+		}
 
 		read_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
@@ -294,6 +351,9 @@ __do_page_cache_readahead(struct address
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
+		if (prefer_adaptive_readahead() &&
+				page_idx == nr_to_read - lookahead_size)
+			SetPageReadahead(page);
 		ret++;
 	}
 	read_unlock_irq(&mapping->tree_lock);
@@ -330,7 +390,7 @@ int force_page_cache_readahead(struct ad
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+						offset, this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -377,7 +437,7 @@ int do_page_cache_readahead(struct addre
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 }
 
 /*
@@ -397,7 +457,10 @@ blockable_page_cache_readahead(struct ad
 	if (!block && bdi_read_congested(mapping->backing_dev_info))
 		return 0;
 
-	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
 
 	return check_ra_success(ra, nr_to_read, actual);
 }
@@ -575,3 +638,119 @@ unsigned long max_sane_readahead(unsigne
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
+
+/*
+ * Adaptive read-ahead.
+ *
+ * Good read patterns are compact both in space and time. The read-ahead logic
+ * tries to grant larger read-ahead size to better readers under the constraint
+ * of system memory and load pressures.
+ *
+ * It employs two methods to estimate the max thrashing safe read-ahead size:
+ *   1. state based   - the default one
+ *   2. context based - the fail safe one
+ * The integration of the dual methods has the merit of being agile and robust.
+ * It makes the overall design clean: special cases are handled in general by
+ * the stateless method, leaving the stateful one simple and fast.
+ *
+ * To improve throughput and decrease read delay, the logic 'looks ahead'.
+ * In most read-ahead chunks, one page will be selected and tagged with
+ * PG_readahead. Later when the page with PG_readahead is read, the logic
+ * will be notified to submit the next read-ahead chunk in advance.
+ *
+ *                 a read-ahead chunk
+ *    +-----------------------------------------+
+ *    |       # PG_readahead                    |
+ *    +-----------------------------------------+
+ *            ^ When this page is read, notify me for the next read-ahead.
+ *
+ *
+ * Here are some variable names used frequently:
+ *
+ *                                   |<------- la_size ------>|
+ *                  +-----------------------------------------+
+ *                  |                #                        |
+ *                  +-----------------------------------------+
+ *      ra_index -->|<---------------- ra_size -------------->|
+ *
+ */
+
+/*
+ * The nature of read-ahead allows most tests to fail or even be wrong.
+ * Here we just do not bother to call get_page(), it's meaningless anyway.
+ */
+static inline struct page *__find_page(struct address_space *mapping,
+							pgoff_t offset)
+{
+	return radix_tree_lookup(&mapping->page_tree, offset);
+}
+
+static inline struct page *find_page(struct address_space *mapping,
+							pgoff_t offset)
+{
+	struct page *page;
+
+	read_lock_irq(&mapping->tree_lock);
+	page = __find_page(mapping, offset);
+	read_unlock_irq(&mapping->tree_lock);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	if (page)
+		BUG_ON(page->index != offset);
+#endif
+	return page;
+}
+
+/*
+ * Move pages in danger (of thrashing) to the head of inactive_list.
+ * Not expected to happen frequently.
+ */
+static int rescue_pages(struct page *page, pgoff_t nr_pages)
+{
+	unsigned long pgrescue;
+	pgoff_t index;
+	struct address_space *mapping;
+	struct zone *zone;
+
+	BUG_ON(!nr_pages || !page);
+	pgrescue = 0;
+	index = page_index(page);
+	mapping = page_mapping(page);
+
+	dprintk("rescue_pages(ino=%lu, index=%lu nr=%lu)\n",
+			mapping->host->i_ino, index, nr_pages);
+
+	for(;;) {
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+
+		if (!PageLRU(page))
+			goto out_unlock;
+
+		while (page_mapping(page) == mapping &&
+				page_index(page) == index) {
+			struct page *the_page = page;
+			page = next_page(page);
+			if (!PageActive(the_page) &&
+					!PageLocked(the_page) &&
+					page_count(the_page) == 1) {
+				list_move(&the_page->lru, &zone->inactive_list);
+				pgrescue++;
+			}
+			index++;
+			if (!--nr_pages)
+				goto out_unlock;
+		}
+
+		spin_unlock_irq(&zone->lru_lock);
+
+		page = find_page(mapping, index);
+		if (!page)
+			goto out;
+	}
+out_unlock:
+	spin_unlock_irq(&zone->lru_lock);
+out:
+	ra_account(NULL, RA_EVENT_READAHEAD_RESCUE, pgrescue);
+
+	return nr_pages ? index : 0;
+}
--- linux.orig/mm/filemap.c
+++ linux/mm/filemap.c
@@ -780,6 +780,10 @@ void do_generic_mapping_read(struct addr
 	if (!isize)
 		goto out;
 
+	if (READAHEAD_DEBUG_LEVEL(5))
+		printk(KERN_DEBUG "read-file(ino=%lu, req=%lu+%lu)\n",
+			inode->i_ino, index, last_index - index);
+
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 	for (;;) {
 		struct page *page;

--
