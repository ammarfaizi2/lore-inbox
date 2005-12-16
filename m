Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVLPMql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVLPMql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVLPMqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:46:32 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:63629 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932253AbVLPMqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:46:11 -0500
Message-Id: <20051216130930.687089000@localhost.localdomain>
References: <20051216130738.300284000@localhost.localdomain>
Date: Fri, 16 Dec 2005 21:07:44 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 06/12] readahead: context based method
Content-Disposition: inline; filename=readahead-method-context.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the slow code path.

No valid state info is available, so the page cache is queried to abtain the
required position/timing infomation.

Major steps:
        - look back/forward to find the ra_index;
        - look back to estimate a thrashing safe ra_size;
        - assemble the next read-ahead request in file_ra_state;
        - submit it.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  362 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 362 insertions(+)

--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -1166,6 +1166,368 @@ state_based_readahead(struct address_spa
 	return ra_dispatch(ra, mapping, filp);
 }
 
+/*
+ * Page cache context based estimation of read-ahead/look-ahead size/index.
+ *
+ * The logic first looks around to find the start point of next read-ahead,
+ * and then, if necessary, looks backward in the inactive_list to get an
+ * estimation of the thrashing-threshold.
+ *
+ * The estimation theory can be illustrated with figure:
+ *
+ *   chunk A           chunk B                      chunk C                 head
+ *
+ *   l01 l11           l12   l21                    l22
+ *| |-->|-->|       |------>|-->|                |------>|
+ *| +-------+       +-----------+                +-------------+               |
+ *| |   #   |       |       #   |                |       #     |               |
+ *| +-------+       +-----------+                +-------------+               |
+ *| |<==============|<===========================|<============================|
+ *        L0                     L1                            L2
+ *
+ * Let f(l) = L be a map from
+ * 	l: the number of pages read by the stream
+ * to
+ * 	L: the number of pages pushed into inactive_list in the mean time
+ * then
+ * 	f(l01) <= L0
+ * 	f(l11 + l12) = L1
+ * 	f(l21 + l22) = L2
+ * 	...
+ * 	f(l01 + l11 + ...) <= Sum(L0 + L1 + ...)
+ *			   <= Length(inactive_list) = f(thrashing-threshold)
+ *
+ * So the count of countinuous history pages left in the inactive_list is always
+ * a lower estimation of the true thrashing-threshold.
+ */
+
+#define PAGE_REFCNT_0           0
+#define PAGE_REFCNT_1           (1 << PG_referenced)
+#define PAGE_REFCNT_2           (1 << PG_active)
+#define PAGE_REFCNT_3           ((1 << PG_active) | (1 << PG_referenced))
+#define PAGE_REFCNT_MASK        PAGE_REFCNT_3
+
+/*
+ * STATUS   REFERENCE COUNT
+ *  __                   0
+ *  _R       PAGE_REFCNT_1
+ *  A_       PAGE_REFCNT_2
+ *  AR       PAGE_REFCNT_3
+ *
+ *  A/R: Active / Referenced
+ */
+static inline unsigned long page_refcnt(struct page *page)
+{
+        return page->flags & PAGE_REFCNT_MASK;
+}
+
+/*
+ * STATUS   REFERENCE COUNT      TYPE
+ *  __                   0      not in inactive list
+ *  __                   0      fresh
+ *  _R       PAGE_REFCNT_1      stale
+ *  A_       PAGE_REFCNT_2      disturbed once
+ *  AR       PAGE_REFCNT_3      disturbed twice
+ *
+ *  A/R: Active / Referenced
+ */
+static inline unsigned long cold_page_refcnt(struct page *page)
+{
+	if (!page || PageActive(page))
+		return 0;
+
+	return page_refcnt(page);
+}
+
+static inline char page_refcnt_symbol(struct page *page)
+{
+	if (!page)
+		return 'X';
+	switch (page_refcnt(page)) {
+		case 0:
+			return '_';
+		case PAGE_REFCNT_1:
+			return '-';
+		case PAGE_REFCNT_2:
+			return '=';
+		case PAGE_REFCNT_3:
+			return '#';
+	}
+	return '?';
+}
+
+/*
+ * Count/estimate cache hits in range [first_index, last_index].
+ * The estimation is simple and optimistic.
+ */
+static int count_cache_hit(struct address_space *mapping,
+				pgoff_t first_index, pgoff_t last_index)
+{
+	struct page *page;
+	int size = last_index - first_index + 1;
+	int count = 0;
+	int i;
+
+	read_lock_irq(&mapping->tree_lock);
+
+	/*
+	 * The first page may well is chunk head and has been accessed,
+	 * so it is index 0 that makes the estimation optimistic. This
+	 * behavior guarantees a readahead when (size < ra_max) and
+	 * (readahead_hit_rate >= 16).
+	 */
+	for (i = 0; i < 16;) {
+		page = __find_page(mapping, first_index +
+						size * ((i++ * 29) & 15) / 16);
+		if (cold_page_refcnt(page) >= PAGE_REFCNT_1 && ++count >= 2)
+			break;
+	}
+
+	read_unlock_irq(&mapping->tree_lock);
+
+	return size * count / i;
+}
+
+/*
+ * Look back and check history pages to estimate thrashing-threshold.
+ */
+static int query_page_cache(struct address_space *mapping,
+			struct file_ra_state *ra,
+			unsigned long *remain, pgoff_t offset,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	int count;
+	pgoff_t index;
+	unsigned long nr_lookback;
+	struct radix_tree_cache cache;
+
+	/*
+	 * Scan backward and check the near @ra_max pages.
+	 * The count here determines ra_size.
+	 */
+	read_lock_irq(&mapping->tree_lock);
+	index = radix_tree_lookup_head(&mapping->page_tree, offset, ra_max);
+	read_unlock_irq(&mapping->tree_lock);
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	if (index <= offset) {
+		WARN_ON(!find_page(mapping, index));
+		if (index + ra_max > offset)
+			WARN_ON(find_page(mapping, index - 1));
+	} else {
+		BUG_ON(index > offset + 1);
+		WARN_ON(find_page(mapping, offset));
+	}
+#endif
+
+	*remain = offset - index + 1;
+
+	if (unlikely(*remain <= ra_min))
+		return ra_min;
+
+	if (!index)
+		return *remain;
+
+	if (offset + 1 == ra->readahead_index && ra_cache_hit_ok(ra))
+		count = *remain;
+	else if (count_cache_hit(mapping, index, offset) *
+						readahead_hit_rate >= *remain)
+		count = *remain;
+	else
+		return ra_min;
+
+	if (count < ra_max)
+		goto out;
+
+	/*
+	 * Check the far pages coarsely.
+	 * The big count here helps increase la_size.
+	 */
+	nr_lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
+						100 / (readahead_ratio + 1);
+	if (nr_lookback > offset)
+		nr_lookback = offset;
+
+	radix_tree_cache_init(&cache);
+	read_lock_irq(&mapping->tree_lock);
+	for (count += ra_max; count < nr_lookback; count += ra_max) {
+		struct radix_tree_node *node;
+		node = radix_tree_cache_lookup_node(&mapping->page_tree,
+						&cache, offset - count, 1);
+		if (!node)
+			break;
+#ifdef DEBUG_READAHEAD_RADIXTREE
+		if (node != radix_tree_lookup_node(&mapping->page_tree,
+							offset - count, 1)) {
+			read_unlock_irq(&mapping->tree_lock);
+			printk(KERN_ERR "check radix_tree_cache_lookup_node!\n");
+			return 1;
+		}
+#endif
+	}
+	read_unlock_irq(&mapping->tree_lock);
+
+	/*
+	 *  For sequential read that extends from index 0, the counted value
+	 *  may well be far under the true threshold, so return it unmodified
+	 *  for further process in adjust_rala_accelerated().
+	 */
+	if (count >= offset)
+		return offset + 1;
+
+out:
+	count = count * readahead_ratio / 100;
+	return count;
+}
+
+/*
+ * Scan backward in the file for the first non-present page.
+ */
+static inline pgoff_t first_absent_page_bw(struct address_space *mapping,
+					pgoff_t index, unsigned long max_scan)
+{
+	struct radix_tree_cache cache;
+	struct page *page;
+	pgoff_t origin;
+
+	origin = index;
+	if (max_scan > index)
+		max_scan = index;
+
+	radix_tree_cache_init(&cache);
+	read_lock_irq(&mapping->tree_lock);
+	for (; origin - index <= max_scan;) {
+		page = radix_tree_cache_lookup(&mapping->page_tree,
+							&cache, --index);
+		if (page) {
+			index++;
+			break;
+		}
+	}
+	read_unlock_irq(&mapping->tree_lock);
+
+	return index;
+}
+
+/*
+ * Scan forward in the file for the first non-present page.
+ */
+static inline pgoff_t first_absent_page(struct address_space *mapping,
+					pgoff_t index, unsigned long max_scan)
+{
+	pgoff_t ra_index;
+
+	read_lock_irq(&mapping->tree_lock);
+	ra_index = radix_tree_lookup_tail(&mapping->page_tree,
+					index + 1, max_scan);
+	read_unlock_irq(&mapping->tree_lock);
+
+#ifdef DEBUG_READAHEAD_RADIXTREE
+	BUG_ON(ra_index <= index);
+	if (index + max_scan > index) {
+		if (ra_index <= index + max_scan)
+			WARN_ON(find_page(mapping, ra_index));
+		WARN_ON(!find_page(mapping, ra_index - 1));
+	}
+#endif
+
+	if (ra_index <= index + max_scan)
+		return ra_index;
+	else
+		return 0;
+}
+
+/*
+ * Determine the request parameters for context based read-ahead that extends
+ * from start of file.
+ *
+ * The major weakness of stateless method is perhaps the slow grow up speed of
+ * ra_size. The logic tries to make up for this in the important case of
+ * sequential reads that extend from start of file. In this case, the ra_size
+ * is not chosen to make the whole next chunk safe (as in normal ones). Only
+ * half of which is safe. The added 'unsafe' half is the look-ahead part. It
+ * is expected to be safeguarded by rescue_pages() when the previous chunks are
+ * lost.
+ */
+static inline int adjust_rala_accelerated(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	pgoff_t index = *ra_size;
+
+	*ra_size -= min(*ra_size, *la_size);
+	*ra_size = *ra_size * readahead_ratio / 100;
+	*la_size = index * readahead_ratio / 100;
+	*ra_size += *la_size;
+
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
+	return 1;
+}
+
+/*
+ * Main function for page context based read-ahead.
+ */
+static inline int
+try_context_based_readahead(struct address_space *mapping,
+			struct file_ra_state *ra,
+			struct page *prev_page, struct page *page,
+			pgoff_t index, unsigned long ra_size,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	pgoff_t ra_index;
+	unsigned long la_size;
+	unsigned long remain_pages;
+
+	/* Where to start read-ahead?
+	 * NFSv3 daemons may process adjacent requests in parallel,
+	 * leading to many locally disordered, globally sequential reads.
+	 * So do not require nearby history pages to be present or accessed.
+	 */
+	if (page) {
+		ra_index = first_absent_page(mapping, index, ra_max * 5 / 4);
+		if (unlikely(!ra_index))
+			return -1;
+	} else if (!prev_page) {
+		ra_index = first_absent_page_bw(mapping, index,
+						readahead_hit_rate + ra_min);
+		if (index - ra_index > readahead_hit_rate + ra_min)
+			return 0;
+		ra_min += 2 * (index - ra_index);
+		index = ra_index;
+	} else {
+		ra_index = index;
+		if (ra_has_index(ra, index))
+			ra_account(ra, RA_EVENT_READAHEAD_MUTILATE,
+						ra->readahead_index - index);
+	}
+
+	ra_size = query_page_cache(mapping, ra, &remain_pages,
+						index - 1, ra_min, ra_max);
+
+	la_size = ra_index - index;
+	if (remain_pages <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return -1;
+	}
+
+	if (ra_size == index) {
+		if (!adjust_rala_accelerated(ra_max, &ra_size, &la_size))
+			return -1;
+		ra_set_class(ra, RA_CLASS_CONTEXT_ACCELERATED);
+	} else {
+		if (!adjust_rala(ra_max, &ra_size, &la_size))
+			return -1;
+		ra_set_class(ra, RA_CLASS_CONTEXT);
+	}
+
+	ra_set_index(ra, index, ra_index);
+	ra_set_size(ra, ra_size, la_size);
+
+	return 1;
+}
+
 
 /*
  * ra_size is mainly determined by:

--
