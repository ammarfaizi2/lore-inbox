Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbVKYPKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbVKYPKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbVKYPKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:10:10 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:41347 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932693AbVKYPJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:09:55 -0500
Message-Id: <20051125151809.219743000@localhost.localdomain>
References: <20051125151210.993109000@localhost.localdomain>
Date: Fri, 25 Nov 2005 23:12:29 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: [PATCH 19/19] io: avoid too much latency from read-ahead
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
issue. It's hard to find them out for now, though there's a workaround:

blockdev --setra 256 /dev/hda # or whatever device you are using

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


This is recommended by Con Kolivas to improve respond time for desktop.

 fs/mpage.c     |    4 +++-
 mm/readahead.c |   16 +++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc2-mm1.orig/mm/readahead.c
+++ linux-2.6.15-rc2-mm1/mm/readahead.c
@@ -368,6 +368,7 @@ static void collect_aging_info(void)
 	page_aging = aging_total();
 	smooth_aging = node_readahead_aging();
 
+	cond_resched();
 	spin_lock_irq(&aging_info_lock);
 
 	for (i = AGING_INFO_SHIFTS - 1; i >= 0; i--) {
@@ -625,8 +626,10 @@ static int read_pages(struct address_spa
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
@@ -746,6 +749,7 @@ __do_page_cache_readahead(struct address
 		}
 
 		read_unlock_irq(&mapping->tree_lock);
+		cond_resched();
 		page = page_cache_alloc_cold(mapping);
 		read_lock_irq(&mapping->tree_lock);
 		if (!page)
@@ -1145,6 +1149,7 @@ static int rescue_pages(struct page *pag
 
 		spin_unlock_irq(&zone->lru_lock);
 
+		cond_resched();
 		page = find_page(mapping, index);
 		if (!page)
 			goto out;
@@ -1219,6 +1224,7 @@ static unsigned long node_readahead_agin
 	unsigned long sum = 0;
 	cpumask_t mask = node_to_cpumask(numa_node_id());
 
+	cond_resched();
 	for_each_cpu_mask(cpu, mask)
 		sum += per_cpu(readahead_aging, cpu);
 
@@ -1349,6 +1355,7 @@ static int ra_dispatch(struct file_ra_st
 	int actual;
 	enum ra_class ra_class;
 
+	cond_resched();
 	ra_class = (ra->flags & RA_CLASS_MASK);
 	BUG_ON(ra_class == 0 || ra_class > RA_CLASS_END);
 
@@ -1371,6 +1378,7 @@ static int ra_dispatch(struct file_ra_st
 
 	actual = __do_page_cache_readahead(mapping, filp,
 					ra->ra_index, ra_size, la_size);
+	cond_resched();
 
 #ifdef READAHEAD_STREAMING
 	if (actual < ra_size) {
@@ -1609,6 +1617,7 @@ static int count_cache_hit(struct addres
 	int count = 0;
 	int i;
 
+	cond_resched();
 	read_lock_irq(&mapping->tree_lock);
 
 	/*
@@ -1646,6 +1655,7 @@ static int query_page_cache(struct addre
 	 * Scan backward and check the near @ra_max pages.
 	 * The count here determines ra_size.
 	 */
+	cond_resched();
 	read_lock_irq(&mapping->tree_lock);
 	index = radix_tree_lookup_head(&mapping->page_tree, offset, ra_max);
 	read_unlock_irq(&mapping->tree_lock);
@@ -1691,6 +1701,7 @@ static int query_page_cache(struct addre
 	if (nr_lookback > offset)
 		nr_lookback = offset;
 
+	cond_resched();
 	radix_tree_cache_init(&cache);
 	read_lock_irq(&mapping->tree_lock);
 	for (count += ra_max; count < nr_lookback; count += ra_max) {
@@ -1737,6 +1748,7 @@ static inline pgoff_t first_absent_page_
 	if (max_scan > index)
 		max_scan = index;
 
+	cond_resched();
 	radix_tree_cache_init(&cache);
 	read_lock_irq(&mapping->tree_lock);
 	for (; origin - index <= max_scan;) {
@@ -1760,6 +1772,7 @@ static inline pgoff_t first_absent_page(
 {
 	pgoff_t ra_index;
 
+	cond_resched();
 	read_lock_irq(&mapping->tree_lock);
 	ra_index = radix_tree_lookup_tail(&mapping->page_tree,
 					index + 1, max_scan);
@@ -2469,6 +2482,7 @@ save_chunk:
 			n <= 3)
 		ret += save_chunk(chunk_head, live_head, page, save_list);
 
+	cond_resched();
 	if (&page->lru != page_list)
 		goto next_chunk;
 
--- linux-2.6.15-rc2-mm1.orig/fs/mpage.c
+++ linux-2.6.15-rc2-mm1/fs/mpage.c
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
