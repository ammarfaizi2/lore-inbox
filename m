Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWFTJUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWFTJUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWFTJUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:20:10 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59792 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965225AbWFTJUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:20:08 -0400
Date: Tue, 20 Jun 2006 11:15:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix spinlock-debug looping
Message-ID: <20060620091505.GA9749@elte.hu>
References: <20060619070229.GA8293@elte.hu> <20060619005955.b05840e8.akpm@osdl.org> <20060619081252.GA13176@elte.hu> <20060619013238.6d19570f.akpm@osdl.org> <20060619083518.GA14265@elte.hu> <20060619021314.a6ce43f5.akpm@osdl.org> <20060619113943.GA18321@elte.hu> <20060619125531.4c72b8cc.akpm@osdl.org> <20060620084001.GC7899@elte.hu> <20060620015259.dab285d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620015259.dab285d5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5034]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 20 Jun 2006 10:40:01 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > i obviously agree that any such crash is a serious problem, but is 
> > it caused by the spinlock-debugging code?
> 
> Judging from Dave Olson <olson@unixfolk.com>'s report: no.  He's 
> getting hit by NMI watchdog expiry on write_lock(tree_lock) in a 
> !CONFIG_DEBUG_SPINLOCK kernel.

hm, that means 5 seconds of looping with irqs off? That's really insane. 
Is there any definitive testcase or testsystem where we could try a 
simple tree_lock rwlock -> spinlock conversion? Spinlocks are alot 
fairer. Or as a simple experiment, s/read_lock/write_lock, as the patch 
below (against rc6-mm2) does. This is phase #1, if it works out we can 
switch tree_lock to a spinlock. [write_lock()s are roughly as fair to 
each other as spinlocks - it's a bit more expensive but not 
significantly] Builds & boots fine here.

	Ingo

---
 drivers/mtd/devices/block2mtd.c        |    8 ++++----
 fs/reiser4/plugin/file/cryptcompress.c |    8 ++++----
 fs/reiser4/plugin/file/file.c          |   12 ++++++------
 mm/filemap.c                           |   32 ++++++++++++++++----------------
 mm/page-writeback.c                    |    4 ++--
 mm/readahead.c                         |   22 +++++++++++-----------
 mm/swap_prefetch.c                     |    4 ++--
 7 files changed, 45 insertions(+), 45 deletions(-)

Index: linux/drivers/mtd/devices/block2mtd.c
===================================================================
--- linux.orig/drivers/mtd/devices/block2mtd.c
+++ linux/drivers/mtd/devices/block2mtd.c
@@ -59,7 +59,7 @@ static void cache_readahead(struct addre
 
 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	for (i = 0; i < PAGE_READAHEAD; i++) {
 		pagei = index + i;
 		if (pagei > end_index) {
@@ -71,16 +71,16 @@ static void cache_readahead(struct addre
 			break;
 		if (page)
 			continue;
-		read_unlock_irq(&mapping->tree_lock);
+		write_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
-		read_lock_irq(&mapping->tree_lock);
+		write_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
 		page->index = pagei;
 		list_add(&page->lru, &page_pool);
 		ret++;
 	}
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	if (ret)
 		read_cache_pages(mapping, &page_pool, filler, NULL);
 }
Index: linux/fs/reiser4/plugin/file/cryptcompress.c
===================================================================
--- linux.orig/fs/reiser4/plugin/file/cryptcompress.c
+++ linux/fs/reiser4/plugin/file/cryptcompress.c
@@ -3413,7 +3413,7 @@ static void clear_moved_tag_cluster(stru
 {
 	int i;
 	void * ret;
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	for (i = 0; i < clust->nr_pages; i++) {
 		assert("edward-1438", clust->pages[i] != NULL);
 		ret = radix_tree_tag_clear(&mapping->page_tree,
@@ -3421,7 +3421,7 @@ static void clear_moved_tag_cluster(stru
 					   PAGECACHE_TAG_REISER4_MOVED);
 		assert("edward-1439", ret == clust->pages[i]);
 	}
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 }
 
 /* Capture an anonymous pager cluster. (Page cluser is
@@ -3446,11 +3446,11 @@ capture_page_cluster(reiser4_cluster_t *
 	if (unlikely(result)) {
 		/* set cleared tag back, so it will be
 		   possible to capture it again later */
-		read_lock_irq(&inode->i_mapping->tree_lock);
+		write_lock_irq(&inode->i_mapping->tree_lock);
 		radix_tree_tag_set(&inode->i_mapping->page_tree,
 				   clust_to_pg(clust->index, inode),
 				   PAGECACHE_TAG_REISER4_MOVED);
-		read_unlock_irq(&inode->i_mapping->tree_lock);
+		write_unlock_irq(&inode->i_mapping->tree_lock);
 
 		release_cluster_pages_and_jnode(clust);
 	}
Index: linux/fs/reiser4/plugin/file/file.c
===================================================================
--- linux.orig/fs/reiser4/plugin/file/file.c
+++ linux/fs/reiser4/plugin/file/file.c
@@ -832,9 +832,9 @@ static int has_anonymous_pages(struct in
 {
 	int result;
 
-	read_lock_irq(&inode->i_mapping->tree_lock);
+	write_lock_irq(&inode->i_mapping->tree_lock);
 	result = radix_tree_tagged(&inode->i_mapping->page_tree, PAGECACHE_TAG_REISER4_MOVED);
-	read_unlock_irq(&inode->i_mapping->tree_lock);
+	write_unlock_irq(&inode->i_mapping->tree_lock);
 	return result;
 }
 
@@ -1124,7 +1124,7 @@ static int sync_page_list(struct inode *
 	mapping = inode->i_mapping;
 	from = 0;
 	result = 0;
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	while (result == 0) {
 		struct page *page;
 
@@ -1138,17 +1138,17 @@ static int sync_page_list(struct inode *
 		/* page may not leave radix tree because it is protected from truncating by inode->i_mutex locked by
 		   sys_fsync */
 		page_cache_get(page);
-		read_unlock_irq(&mapping->tree_lock);
+		write_unlock_irq(&mapping->tree_lock);
 
 		from = page->index + 1;
 
 		result = sync_page(page);
 
 		page_cache_release(page);
-		read_lock_irq(&mapping->tree_lock);
+		write_lock_irq(&mapping->tree_lock);
 	}
 
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	return result;
 }
 
Index: linux/mm/filemap.c
===================================================================
--- linux.orig/mm/filemap.c
+++ linux/mm/filemap.c
@@ -568,9 +568,9 @@ int probe_page(struct address_space *map
 {
 	int exists;
 
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	exists = __probe_page(mapping, offset);
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 
 	return exists;
 }
@@ -583,11 +583,11 @@ struct page * find_get_page(struct addre
 {
 	struct page *page;
 
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page)
 		page_cache_get(page);
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -600,11 +600,11 @@ struct page *find_trylock_page(struct ad
 {
 	struct page *page;
 
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page && TestSetPageLocked(page))
 		page = NULL;
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -626,15 +626,15 @@ struct page *find_lock_page(struct addre
 {
 	struct page *page;
 
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 repeat:
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page) {
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
-			read_unlock_irq(&mapping->tree_lock);
+			write_unlock_irq(&mapping->tree_lock);
 			__lock_page(page);
-			read_lock_irq(&mapping->tree_lock);
+			write_lock_irq(&mapping->tree_lock);
 
 			/* Has the page been truncated while we slept? */
 			if (unlikely(page->mapping != mapping ||
@@ -645,7 +645,7 @@ repeat:
 			}
 		}
 	}
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -718,12 +718,12 @@ unsigned find_get_pages(struct address_s
 	unsigned int i;
 	unsigned int ret;
 
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup(&mapping->page_tree,
 				(void **)pages, start, nr_pages);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
 EXPORT_SYMBOL(find_get_pages);
@@ -746,7 +746,7 @@ unsigned find_get_pages_contig(struct ad
 	unsigned int i;
 	unsigned int ret;
 
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup(&mapping->page_tree,
 				(void **)pages, index, nr_pages);
 	for (i = 0; i < ret; i++) {
@@ -756,7 +756,7 @@ unsigned find_get_pages_contig(struct ad
 		page_cache_get(pages[i]);
 		index++;
 	}
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	return i;
 }
 
@@ -770,14 +770,14 @@ unsigned find_get_pages_tag(struct addre
 	unsigned int i;
 	unsigned int ret;
 
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup_tag(&mapping->page_tree,
 				(void **)pages, *index, nr_pages, tag);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
 	if (ret)
 		*index = pages[ret - 1]->index + 1;
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
 EXPORT_SYMBOL(find_get_pages_tag);
Index: linux/mm/page-writeback.c
===================================================================
--- linux.orig/mm/page-writeback.c
+++ linux/mm/page-writeback.c
@@ -800,9 +800,9 @@ int mapping_tagged(struct address_space 
 	unsigned long flags;
 	int ret;
 
-	read_lock_irqsave(&mapping->tree_lock, flags);
+	write_lock_irqsave(&mapping->tree_lock, flags);
 	ret = radix_tree_tagged(&mapping->page_tree, tag);
-	read_unlock_irqrestore(&mapping->tree_lock, flags);
+	write_unlock_irqrestore(&mapping->tree_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(mapping_tagged);
Index: linux/mm/readahead.c
===================================================================
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -398,7 +398,7 @@ __do_page_cache_readahead(struct address
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		pgoff_t page_offset = offset + page_idx;
 		
@@ -409,10 +409,10 @@ __do_page_cache_readahead(struct address
 		if (page)
 			continue;
 
-		read_unlock_irq(&mapping->tree_lock);
+		write_unlock_irq(&mapping->tree_lock);
 		cond_resched();
 		page = page_cache_alloc_cold(mapping);
-		read_lock_irq(&mapping->tree_lock);
+		write_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
 		page->index = page_offset;
@@ -421,7 +421,7 @@ __do_page_cache_readahead(struct address
 			SetPageReadahead(page);
 		ret++;
 	}
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 
 	/*
 	 * Now start the IO.  We ignore I/O errors - if the page is not
@@ -1318,7 +1318,7 @@ static pgoff_t find_segtail(struct addre
 	pgoff_t ra_index;
 
 	cond_resched();
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	ra_index = radix_tree_scan_hole(&mapping->page_tree, index, max_scan);
 #ifdef DEBUG_READAHEAD_RADIXTREE
 	BUG_ON(!__probe_page(mapping, index));
@@ -1330,7 +1330,7 @@ static pgoff_t find_segtail(struct addre
 	if (ra_index != ~0UL && ra_index - index < max_scan)
 		WARN_ON(__probe_page(mapping, ra_index));
 #endif
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 
 	if (ra_index <= index + max_scan)
 		return ra_index;
@@ -1353,13 +1353,13 @@ static pgoff_t find_segtail_backward(str
 	 * Poor man's radix_tree_scan_data_backward() implementation.
 	 * Acceptable because max_scan won't be large.
 	 */
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	for (; origin - index < max_scan;)
 		if (__probe_page(mapping, --index)) {
-			read_unlock_irq(&mapping->tree_lock);
+			write_unlock_irq(&mapping->tree_lock);
 			return index + 1;
 		}
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 
 	return 0;
 }
@@ -1410,7 +1410,7 @@ static unsigned long query_page_cache_se
 	 * The count here determines ra_size.
 	 */
 	cond_resched();
-	read_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	index = radix_tree_scan_hole_backward(&mapping->page_tree,
 							offset - 1, ra_max);
 #ifdef DEBUG_READAHEAD_RADIXTREE
@@ -1452,7 +1452,7 @@ static unsigned long query_page_cache_se
 			break;
 
 out_unlock:
-	read_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 
 	/*
 	 *  For sequential read that extends from index 0, the counted value
Index: linux/mm/swap_prefetch.c
===================================================================
--- linux.orig/mm/swap_prefetch.c
+++ linux/mm/swap_prefetch.c
@@ -189,10 +189,10 @@ static enum trickle_return trickle_swap_
 	enum trickle_return ret = TRICKLE_FAILED;
 	struct page *page;
 
-	read_lock_irq(&swapper_space.tree_lock);
+	write_lock_irq(&swapper_space.tree_lock);
 	/* Entry may already exist */
 	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
-	read_unlock_irq(&swapper_space.tree_lock);
+	write_unlock_irq(&swapper_space.tree_lock);
 	if (page) {
 		remove_from_swapped_list(entry.val);
 		goto out;
