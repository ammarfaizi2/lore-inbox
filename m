Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbUKUPtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUKUPtq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbUKUPsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:48:08 -0500
Received: from [213.85.13.118] ([213.85.13.118]:15491 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261737AbUKUPov (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 21 Nov 2004 10:44:51 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16800.47066.827146.370838@gargle.gargle.HOWL>
Date: Sun, 21 Nov 2004 18:44:26 +0300
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Andrew Morton <AKPM@Osdl.ORG>, Linux MM Mailing List <linux-mm@kvack.org>
Subject: [PATCH]: 4/4 cluster page-out in VM scanner
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Implement pageout clustering at the VM level.

With this patch VM scanner calls pageout_cluster() instead of
->writepage(). pageout_cluster() tries to find a group of dirty pages around
target page, called "pivot" page of the cluster. If group of suitable size is
found, ->writepages() is called for it, otherwise, page_cluster() falls back
to ->writepage().

This is supposed to help in work-loads with significant page-out of
file-system pages from tail of the inactive list (for example, heavy dirtying
through mmap), because file system usually writes multiple pages more
efficiently. Should also be advantageous for file-systems doing delayed
allocation, as in this case they will allocate whole extents at once.

Few points:

 - swap-cache pages are not clustered (although they can be, but by
   page->private rather than page->index)

 - currently, kswapd clusters all the time, and direct reclaim only when
   device queue is not congested. Probably direct reclaim shouldn't cluster at
   all.

 - this patch adds new fields to struct writeback_control and expects
   ->writepages() to interpret them. This is needed, because pageout_cluster()
   calls ->writepages() with pivot page already locked, so that ->writepages()
   is allowed to only trylock other pages in the cluster.

   Besides, rather rough plumbing (wbc->pivot_ret field) is added to check
   whether ->writepages() failed to write pivot page for any reason (in latter
   case page_cluster() falls back to ->writepage()).

   Only mpage_writepages() was updated to honor these new fields, but
   all in-tree ->writepages() implementations seem to call
   mpage_writepages(). (Except reiser4, of course, for which I'll send a
   (trivial) patch, if necessary).

Numbers that talk:

Averaged number of microseconds it takes to dirty 1GB of
16-times-larger-than-RAM ext3 file mmaped in 1GB chunks:

without-patch:   average:    74188417.156250
               deviation:    10538258.613280

   with-patch:   average:    69449001.583333
               deviation:    12621756.615280

(Patch is for 2.6.10-rc2)

Signed-off-by: Nikita Danilov <nikita@clusterfs.com>

 fs/mpage.c                |  103 +++++++++++++++++++++++-----------------------
 include/linux/writeback.h |    6 ++
 mm/vmscan.c               |   74 ++++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 52 deletions(-)

diff -puN mm/vmscan.c~cluster-pageout mm/vmscan.c
--- bk-linux/mm/vmscan.c~cluster-pageout	2004-11-21 17:01:06.000000000 +0300
+++ bk-linux-nikita/mm/vmscan.c	2004-11-21 17:01:06.000000000 +0300
@@ -308,6 +308,78 @@ static void handle_write_error(struct ad
 	unlock_page(page);
 }
 
+enum {
+	PAGE_CLUSTER_WING = 16,
+	PAGE_CLUSTER_SIZE = 2 * PAGE_CLUSTER_WING,
+};
+
+enum {
+	PIVOT_RET_MAGIC = 42
+};
+
+static int pageout_cluster(struct page *page, struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	pgoff_t punct;
+	pgoff_t start;
+	pgoff_t end;
+	struct page *opage = page;
+
+	if (PageSwapCache(page) ||
+	    (!current_is_kswapd() &&
+	     bdi_write_congested(mapping->backing_dev_info)))
+		return mapping->a_ops->writepage(page, wbc);
+
+	wbc->pivot = page;
+	punct = page->index;
+	spin_lock_irq(&mapping->tree_lock);
+	for (start = punct - 1;
+	     start < punct && punct - start <= PAGE_CLUSTER_WING; -- start) {
+		page = radix_tree_lookup(&mapping->page_tree, start);
+		if (page == NULL || !PageDirty(page))
+			/*
+			 * no suitable page, stop cluster at this point
+			 */
+			break;
+		if ((start % PAGE_CLUSTER_SIZE) == 0)
+			/*
+			 * we reached aligned page.
+			 */
+			-- start;
+			break;
+	}
+	++ start;
+	for (end = punct + 1;
+	     end > punct && end - start < PAGE_CLUSTER_SIZE; ++ end) {
+		/*
+		 * XXX nikita: consider find_get_pages_tag()
+		 */
+		page = radix_tree_lookup(&mapping->page_tree, end);
+		if (page == NULL || !PageDirty(page))
+			/*
+			 * no suitable page, stop cluster at this point
+			 */
+			break;
+	}
+	spin_unlock_irq(&mapping->tree_lock);
+	-- end;
+	wbc->pivot_ret = PIVOT_RET_MAGIC; /* magic */
+	if (end > start) {
+		wbc->start = ((loff_t)start) << PAGE_CACHE_SHIFT;
+		wbc->end   = ((loff_t)end) << PAGE_CACHE_SHIFT;
+		wbc->end  += PAGE_CACHE_SIZE - 1;
+		wbc->nr_to_write = end - start + 1;
+		do_writepages(mapping, wbc);
+	}
+	if (wbc->pivot_ret == PIVOT_RET_MAGIC)
+		/*
+		 * single page, or ->writepages() skipped pivot for any
+		 * reason: just call ->writepage()
+		 */
+		wbc->pivot_ret = mapping->a_ops->writepage(opage, wbc);
+	return wbc->pivot_ret;
+}
+
 /*
  * Called by shrink_list() for each dirty page. Calls ->writepage().
  */
@@ -378,7 +450,7 @@ static pageout_t pageout(struct page *pa
 
 		ClearPageSkipped(page);
 		SetPageReclaim(page);
-		res = mapping->a_ops->writepage(page, &wbc);
+		res = pageout_cluster(page, mapping, &wbc);
 
 		if (res < 0)
 			handle_write_error(mapping, page, res);
diff -puN include/linux/writeback.h~cluster-pageout include/linux/writeback.h
--- bk-linux/include/linux/writeback.h~cluster-pageout	2004-11-21 17:01:06.000000000 +0300
+++ bk-linux-nikita/include/linux/writeback.h	2004-11-21 17:01:06.000000000 +0300
@@ -55,6 +55,12 @@ struct writeback_control {
 	unsigned encountered_congestion:1;	/* An output: a queue is full */
 	unsigned for_kupdate:1;			/* A kupdate writeback */
 	unsigned for_reclaim:1;			/* Invoked from the page allocator */
+	/* if non-NULL, page already locked by ->writepages()
+	 * caller. ->writepages() should use trylock on all other pages it
+	 * submits for IO */
+	struct page *pivot;
+	/* if ->pivot is not NULL, result for pivot page is stored here */
+	int pivot_ret;
 };
 
 /*
diff -puN fs/mpage.c~cluster-pageout fs/mpage.c
--- bk-linux/fs/mpage.c~cluster-pageout	2004-11-21 17:01:06.000000000 +0300
+++ bk-linux-nikita/fs/mpage.c	2004-11-21 17:01:06.000000000 +0300
@@ -407,6 +407,7 @@ mpage_writepage(struct bio *bio, struct 
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
 
+	*ret = 0;
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
 		struct buffer_head *bh = head;
@@ -581,15 +582,6 @@ confused:
 	if (bio)
 		bio = mpage_bio_submit(WRITE, bio);
 	*ret = page->mapping->a_ops->writepage(page, wbc);
-	/*
-	 * The caller has a ref on the inode, so *mapping is stable
-	 */
-	if (*ret) {
-		if (*ret == -ENOSPC)
-			set_bit(AS_ENOSPC, &mapping->flags);
-		else
-			set_bit(AS_EIO, &mapping->flags);
-	}
 out:
 	return bio;
 }
@@ -665,50 +657,59 @@ retry:
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			/*
-			 * At this point we hold neither mapping->tree_lock nor
-			 * lock on the page itself: the page may be truncated or
-			 * invalidated (changing page->mapping to NULL), or even
-			 * swizzled back from swapper_space to tmpfs file
-			 * mapping
-			 */
-
-			lock_page(page);
+			if (page != wbc->pivot) {
+				/*
+				 * At this point we hold neither
+				 * mapping->tree_lock nor lock on the page
+				 * itself: the page may be truncated or
+				 * invalidated (changing page->mapping to
+				 * NULL), or even swizzled back from
+				 * swapper_space to tmpfs file mapping
+				 */
 
-			if (unlikely(page->mapping != mapping)) {
-				unlock_page(page);
-				continue;
-			}
+				if (wbc->pivot != NULL) {
+					if (unlikely(TestSetPageLocked(page)))
+						continue;
+				} else
+					lock_page(page);
+
+				if (unlikely(page->mapping != mapping)) {
+					unlock_page(page);
+					continue;
+				}
 
-			if (unlikely(is_range) && page->index > end) {
-				done = 1;
-				unlock_page(page);
-				continue;
-			}
+				if (unlikely(is_range) && page->index > end) {
+					done = 1;
+					unlock_page(page);
+					continue;
+				}
 
-			if (wbc->sync_mode != WB_SYNC_NONE)
-				wait_on_page_writeback(page);
+				if (wbc->sync_mode != WB_SYNC_NONE)
+					wait_on_page_writeback(page);
 
-			if (PageWriteback(page) ||
-					!clear_page_dirty_for_io(page)) {
-				unlock_page(page);
-				continue;
+				if (PageWriteback(page) ||
+				    !clear_page_dirty_for_io(page)) {
+					unlock_page(page);
+					continue;
+				}
 			}
-
-			if (writepage) {
+			if (writepage)
 				ret = (*writepage)(page, wbc);
-				if (ret) {
-					if (ret == -ENOSPC)
-						set_bit(AS_ENOSPC,
-							&mapping->flags);
-					else
-						set_bit(AS_EIO,
-							&mapping->flags);
-				}
-			} else {
+			else
 				bio = mpage_writepage(bio, page, get_block,
 						&last_block_in_bio, &ret, wbc);
+			if (ret) {
+				/*
+				 * The caller has a ref on the inode, so
+				 * *mapping is stable
+				 */
+				if (ret == -ENOSPC)
+					set_bit(AS_ENOSPC, &mapping->flags);
+				else
+					set_bit(AS_EIO, &mapping->flags);
 			}
+			if (page == wbc->pivot)
+				wbc->pivot_ret = ret;
 			if (ret || (--(wbc->nr_to_write) <= 0))
 				done = 1;
 			if (wbc->nonblocking && bdi_write_congested(bdi)) {

_
