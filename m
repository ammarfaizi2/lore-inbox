Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVLCHOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVLCHOc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 02:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVLCHOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 02:14:04 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:15555 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751209AbVLCHN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 02:13:57 -0500
Message-Id: <20051203072004.352506000@localhost.localdomain>
References: <20051203071444.260068000@localhost.localdomain>
Date: Sat, 03 Dec 2005 15:15:00 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: [PATCH 16/16] io: prevent too much latency in the read-ahead code
Content-Disposition: inline; filename=io-low-latency.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the VM_MAX_READAHEAD is greatly enlarged and the algorithm become more
complex, it may be necessary to insert some cond_resched() calls in the
read-ahead path.

----------------------------------------------------------------------------
If you feel more latency with the new read-ahead code, the cause can
either be the complex read-ahead code, or some low level routines not ready
to support the larger default 1M read-ahead size. It can be cleared out with
the following commands:

dd if=/dev/zero of=sparse bs=1M seek=10000 count=1
cp sparse /dev/null

If the above copy does not lead to audio jitters, then it's an low level
issue. There are basicly two ways:
1) compile kernel with CONFIG_PREEMPT_VOLUNTARY/CONFIG_PREEMPT
2) reduce the read-ahead request size by
	blockdev --setra 256 /dev/hda # or whatever device you are using

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


This is recommended by Con Kolivas to improve respond time for desktop.
Thanks!

 fs/mpage.c     |    4 +++-
 mm/readahead.c |   16 +++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -499,8 +499,10 @@ static int read_pages(struct address_spa
 					page->index, GFP_KERNEL)) {
 			ret = mapping->a_ops->readpage(filp, page);
 			if (ret != AOP_TRUNCATED_PAGE) {
-				if (!pagevec_add(&lru_pvec, page))
+				if (!pagevec_add(&lru_pvec, page)) {
 					__pagevec_lru_add(&lru_pvec);
+					cond_resched();
+				}
 				continue;
 			} /* else fall through to release */
 		}
@@ -620,6 +622,7 @@ __do_page_cache_readahead(struct address
 		}
 
 		read_unlock_irq(&mapping->tree_lock);
+		cond_resched();
 		page = page_cache_alloc_cold(mapping);
 		read_lock_irq(&mapping->tree_lock);
 		if (!page)
@@ -1019,6 +1022,7 @@ static int rescue_pages(struct page *pag
 
 		spin_unlock_irq(&zone->lru_lock);
 
+		cond_resched();
 		page = find_page(mapping, index);
 		if (!page)
 			goto out;
@@ -1093,6 +1097,7 @@ static unsigned long node_readahead_agin
 	unsigned long sum = 0;
 	cpumask_t mask = node_to_cpumask(numa_node_id());
 
+	cond_resched();
 	for_each_cpu_mask(cpu, mask)
 		sum += per_cpu(readahead_aging, cpu);
 
@@ -1223,6 +1228,7 @@ static int ra_dispatch(struct file_ra_st
 	int actual;
 	enum ra_class ra_class;
 
+	cond_resched();
 	ra_class = (ra->flags & RA_CLASS_MASK);
 	BUG_ON(ra_class == 0 || ra_class > RA_CLASS_END);
 
@@ -1245,6 +1251,7 @@ static int ra_dispatch(struct file_ra_st
 
 	actual = __do_page_cache_readahead(mapping, filp,
 					ra->ra_index, ra_size, la_size);
+	cond_resched();
 
 #ifdef READAHEAD_STREAMING
 	if (actual < ra_size) {
@@ -1483,6 +1490,7 @@ static int count_cache_hit(struct addres
 	int count = 0;
 	int i;
 
+	cond_resched();
 	read_lock_irq(&mapping->tree_lock);
 
 	/*
@@ -1520,6 +1528,7 @@ static int query_page_cache(struct addre
 	 * Scan backward and check the near @ra_max pages.
 	 * The count here determines ra_size.
 	 */
+	cond_resched();
 	read_lock_irq(&mapping->tree_lock);
 	index = radix_tree_lookup_head(&mapping->page_tree, offset, ra_max);
 	read_unlock_irq(&mapping->tree_lock);
@@ -1565,6 +1574,7 @@ static int query_page_cache(struct addre
 	if (nr_lookback > offset)
 		nr_lookback = offset;
 
+	cond_resched();
 	radix_tree_cache_init(&cache);
 	read_lock_irq(&mapping->tree_lock);
 	for (count += ra_max; count < nr_lookback; count += ra_max) {
@@ -1611,6 +1621,7 @@ static inline pgoff_t first_absent_page_
 	if (max_scan > index)
 		max_scan = index;
 
+	cond_resched();
 	radix_tree_cache_init(&cache);
 	read_lock_irq(&mapping->tree_lock);
 	for (; origin - index <= max_scan;) {
@@ -1634,6 +1645,7 @@ static inline pgoff_t first_absent_page(
 {
 	pgoff_t ra_index;
 
+	cond_resched();
 	read_lock_irq(&mapping->tree_lock);
 	ra_index = radix_tree_lookup_tail(&mapping->page_tree,
 					index + 1, max_scan);
@@ -1884,6 +1896,7 @@ page_cache_readaround(struct address_spa
 	else if ((unsigned)(index - ra->prev_page) <= hit_rate)
 		ra_size = 4 * (index - ra->prev_page);
 	else {
+		cond_resched();
 		read_lock_irq(&mapping->tree_lock);
 		if (radix_tree_lookup_node(&mapping->page_tree, index, 1))
 			ra_size = RADIX_TREE_MAP_SIZE;
@@ -2390,6 +2403,7 @@ save_chunk:
 			n <= 3)
 		ret += save_chunk(chunk_head, live_head, page, save_list);
 
+	cond_resched();
 	if (&page->lru != page_list)
 		goto next_chunk;
 
--- linux.orig/fs/mpage.c
+++ linux/fs/mpage.c
@@ -343,8 +343,10 @@ mpage_readpages(struct address_space *ma
 			bio = do_mpage_readpage(bio, page,
 					nr_pages - page_idx,
 					&last_block_in_bio, get_block);
-			if (!pagevec_add(&lru_pvec, page))
+			if (!pagevec_add(&lru_pvec, page)) {
 				__pagevec_lru_add(&lru_pvec);
+				cond_resched();
+			}
 		} else {
 			page_cache_release(page);
 		}

--
