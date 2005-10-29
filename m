Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVJ2Fs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVJ2Fs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVJ2FsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:48:05 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:29835 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751341AbVJ2Fr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:47:29 -0400
Message-Id: <20051029060239.228334000@localhost.localdomain>
References: <20051029060216.159380000@localhost.localdomain>
Date: Sat, 29 Oct 2005 14:02:21 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 05/13] readahead: some preparation
Content-Disposition: inline; filename=readahead-prepare.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some random changes that do not fit in elsewhere.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 157 insertions(+), 8 deletions(-)

--- linux-2.6.14-rc5-mm1.orig/mm/readahead.c
+++ linux-2.6.14-rc5-mm1/mm/readahead.c
@@ -15,13 +15,36 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+/*
+ * Debug facilities.
+ */
+#define DEBUG_READAHEAD
+#ifdef DEBUG_READAHEAD
+
+#define dprintk(args...) \
+	if (readahead_ratio & 1) printk(KERN_DEBUG args)
+#define ddprintk(args...) \
+	if ((readahead_ratio & 3) == 3) printk(KERN_DEBUG args)
+
+#else /* DEBUG_READAHEAD */
+
+#define dprintk(args...)     do {} while(0)
+#define ddprintk(args...)    do {} while(0)
+
+#endif /* DEBUG_READAHEAD */
+
+
+/* The default max/min read-ahead pages. */
+#define MAX_RA_PAGES	(VM_MAX_READAHEAD >> (PAGE_CACHE_SHIFT - 10))
+#define MIN_RA_PAGES	(VM_MIN_READAHEAD >> (PAGE_CACHE_SHIFT - 10))
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
@@ -50,7 +73,7 @@ static inline unsigned long get_max_read
 
 static inline unsigned long get_min_readahead(struct file_ra_state *ra)
 {
-	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	return MIN_RA_PAGES;
 }
 
 static inline void ra_off(struct file_ra_state *ra)
@@ -255,10 +278,11 @@ out:
  */
 static int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			unsigned long offset, unsigned long nr_to_read)
+			unsigned long offset, unsigned long nr_to_read,
+			unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
+	struct page *page = NULL;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
@@ -268,7 +292,7 @@ __do_page_cache_readahead(struct address
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -291,6 +315,9 @@ __do_page_cache_readahead(struct address
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
+		if (readahead_ratio > 9 &&
+				page_idx == nr_to_read - lookahead_size)
+			SetPageReadahead(page);
 		ret++;
 	}
 	read_unlock_irq(&mapping->tree_lock);
@@ -327,7 +354,7 @@ int force_page_cache_readahead(struct ad
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+						offset, this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -374,7 +401,7 @@ int do_page_cache_readahead(struct addre
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 }
 
 /*
@@ -394,7 +421,10 @@ blockable_page_cache_readahead(struct ad
 	if (!block && bdi_read_congested(mapping->backing_dev_info))
 		return 0;
 
-	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	dprintk("blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
 
 	return check_ra_success(ra, nr_to_read, actual);
 }
@@ -559,3 +589,122 @@ unsigned long max_sane_readahead(unsigne
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
+ * In every read-ahead chunk, it selects one page and tag it with PG_readahead.
+ * Later when the page with PG_readahead is to be read, the logic knows that
+ * it's time to carry out the next read-ahead chunk in advance.
+ *
+ *                 a read-ahead chunk
+ *    +-----------------------------------------+
+ *    |       # PG_readahead                    |
+ *    +-----------------------------------------+
+ *            ^ When this page is read, we submit I/O for the next read-ahead.
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
+#define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
+#define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
+
+/*
+ * The nature of read-ahead allows most tests to fail or even be wrong.
+ * Here we just do not bother to call get_page(), it's meaningless anyway.
+ */
+static inline struct page *__find_page(struct address_space *mapping,
+						unsigned long offset)
+{
+	return radix_tree_lookup(&mapping->page_tree, offset);
+}
+
+struct page *find_page(struct address_space *mapping, unsigned long offset)
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
+static int rescue_pages(struct page *page, unsigned long nr_pages)
+{
+	unsigned long pgrescue;
+	unsigned long index;
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
+					!PageActivate(the_page) &&
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
+	ra_account(0, RA_EVENT_READAHEAD_RESCUE, pgrescue);
+
+	return nr_pages ? index : 0;
+}

--
