Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTDUViB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDUViB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:38:01 -0400
Received: from [12.47.58.203] ([12.47.58.203]:49025 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262652AbTDUVgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:36:17 -0400
Date: Mon, 21 Apr 2003 14:46:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 67-mjb2 vs 68-mjb1 (sdet degredation)
Message-Id: <20030421144631.4987db46.akpm@digeo.com>
In-Reply-To: <1425480000.1050959528@flay>
References: <1425480000.1050959528@flay>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2003 21:48:15.0771 (UTC) FILETIME=[B6BBDEB0:01C3084F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Seem to loose about 2-3% on SDET syncing with 2.5.68. Not much change
> apart from 67-68 changes. The merge of the ext2 alloc stuff has made
> such a dramatic improvment for virgin 67-68, it's hard to see if
> there was any degredation in mainline ;-) I had those in my tree before
> though, so there should be much less change.
> 
> Just wondering if you can recognise / guess the problem from the profiles,
> else I'll poke at it some more (will probably just work out what's hitting
> .text.lock.filemap).
> 

erk.  Looks like the rwlock->spinlock conversion of mapping->page_lock.

That was a small (1%?) win on small SMP, and looks to be a small lose on
big SMP.  No real surprise there.

Here's a backout patch.  Does it fix it up?



diff -puN fs/fs-writeback.c~page_lock-is-rwlock fs/fs-writeback.c
--- 25/fs/fs-writeback.c~page_lock-is-rwlock	Mon Apr 21 14:44:55 2003
+++ 25-akpm/fs/fs-writeback.c	Mon Apr 21 14:45:00 2003
@@ -149,10 +149,10 @@ __sync_single_inode(struct inode *inode,
 	 * read speculatively by this cpu before &= ~I_DIRTY  -- mikulas
 	 */
 
-	spin_lock(&mapping->page_lock);
+	write_lock(&mapping->page_lock);
 	if (wait || !wbc->for_kupdate || list_empty(&mapping->io_pages))
 		list_splice_init(&mapping->dirty_pages, &mapping->io_pages);
-	spin_unlock(&mapping->page_lock);
+	write_unlock(&mapping->page_lock);
 	spin_unlock(&inode_lock);
 
 	do_writepages(mapping, wbc);
diff -puN fs/inode.c~page_lock-is-rwlock fs/inode.c
--- 25/fs/inode.c~page_lock-is-rwlock	Mon Apr 21 14:44:55 2003
+++ 25-akpm/fs/inode.c	Mon Apr 21 14:45:00 2003
@@ -181,7 +181,7 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
-	spin_lock_init(&inode->i_data.page_lock);
+	rwlock_init(&inode->i_data.page_lock);
 	init_MUTEX(&inode->i_data.i_shared_sem);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
diff -puN fs/mpage.c~page_lock-is-rwlock fs/mpage.c
--- 25/fs/mpage.c~page_lock-is-rwlock	Mon Apr 21 14:44:55 2003
+++ 25-akpm/fs/mpage.c	Mon Apr 21 14:45:00 2003
@@ -627,7 +627,7 @@ mpage_writepages(struct address_space *m
 		writepage = mapping->a_ops->writepage;
 
 	pagevec_init(&pvec, 0);
-	spin_lock(&mapping->page_lock);
+	write_lock(&mapping->page_lock);
 	while (!list_empty(&mapping->io_pages) && !done) {
 		struct page *page = list_entry(mapping->io_pages.prev,
 					struct page, list);
@@ -647,7 +647,7 @@ mpage_writepages(struct address_space *m
 		list_add(&page->list, &mapping->locked_pages);
 
 		page_cache_get(page);
-		spin_unlock(&mapping->page_lock);
+		write_unlock(&mapping->page_lock);
 
 		/*
 		 * At this point we hold neither mapping->page_lock nor
@@ -679,12 +679,12 @@ mpage_writepages(struct address_space *m
 			unlock_page(page);
 		}
 		page_cache_release(page);
-		spin_lock(&mapping->page_lock);
+		write_lock(&mapping->page_lock);
 	}
 	/*
 	 * Leave any remaining dirty pages on ->io_pages
 	 */
-	spin_unlock(&mapping->page_lock);
+	write_unlock(&mapping->page_lock);
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
 	return ret;
diff -puN include/linux/fs.h~page_lock-is-rwlock include/linux/fs.h
--- 25/include/linux/fs.h~page_lock-is-rwlock	Mon Apr 21 14:44:55 2003
+++ 25-akpm/include/linux/fs.h	Mon Apr 21 14:45:00 2003
@@ -313,7 +313,7 @@ struct backing_dev_info;
 struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
-	spinlock_t		page_lock;	/* and rwlock protecting it */
+	rwlock_t		page_lock;	/* and rwlock protecting it */
 	struct list_head	clean_pages;	/* list of clean pages */
 	struct list_head	dirty_pages;	/* list of dirty pages */
 	struct list_head	locked_pages;	/* list of locked pages */
diff -puN mm/filemap.c~page_lock-is-rwlock mm/filemap.c
--- 25/mm/filemap.c~page_lock-is-rwlock	Mon Apr 21 14:44:55 2003
+++ 25-akpm/mm/filemap.c	Mon Apr 21 14:45:00 2003
@@ -99,9 +99,9 @@ void remove_from_page_cache(struct page 
 	if (unlikely(!PageLocked(page)))
 		PAGE_BUG(page);
 
-	spin_lock(&mapping->page_lock);
+	write_lock(&mapping->page_lock);
 	__remove_from_page_cache(page);
-	spin_unlock(&mapping->page_lock);
+	write_unlock(&mapping->page_lock);
 }
 
 static inline int sync_page(struct page *page)
@@ -133,9 +133,9 @@ static int __filemap_fdatawrite(struct a
 	if (mapping->backing_dev_info->memory_backed)
 		return 0;
 
-	spin_lock(&mapping->page_lock);
+	write_lock(&mapping->page_lock);
 	list_splice_init(&mapping->dirty_pages, &mapping->io_pages);
-	spin_unlock(&mapping->page_lock);
+	write_unlock(&mapping->page_lock);
 	ret = do_writepages(mapping, &wbc);
 	return ret;
 }
@@ -166,7 +166,7 @@ int filemap_fdatawait(struct address_spa
 
 restart:
 	progress = 0;
-	spin_lock(&mapping->page_lock);
+	write_lock(&mapping->page_lock);
         while (!list_empty(&mapping->locked_pages)) {
 		struct page *page;
 
@@ -180,7 +180,7 @@ restart:
 		if (!PageWriteback(page)) {
 			if (++progress > 32) {
 				if (need_resched()) {
-					spin_unlock(&mapping->page_lock);
+					write_unlock(&mapping->page_lock);
 					__cond_resched();
 					goto restart;
 				}
@@ -190,16 +190,16 @@ restart:
 
 		progress = 0;
 		page_cache_get(page);
-		spin_unlock(&mapping->page_lock);
+		write_unlock(&mapping->page_lock);
 
 		wait_on_page_writeback(page);
 		if (PageError(page))
 			ret = -EIO;
 
 		page_cache_release(page);
-		spin_lock(&mapping->page_lock);
+		write_lock(&mapping->page_lock);
 	}
-	spin_unlock(&mapping->page_lock);
+	write_unlock(&mapping->page_lock);
 	return ret;
 }
 
@@ -227,7 +227,7 @@ int add_to_page_cache(struct page *page,
 
 	if (error == 0) {
 		page_cache_get(page);
-		spin_lock(&mapping->page_lock);
+		write_lock(&mapping->page_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			SetPageLocked(page);
@@ -235,7 +235,7 @@ int add_to_page_cache(struct page *page,
 		} else {
 			page_cache_release(page);
 		}
-		spin_unlock(&mapping->page_lock);
+		write_unlock(&mapping->page_lock);
 		radix_tree_preload_end();
 	}
 	return error;
@@ -364,11 +364,11 @@ struct page * find_get_page(struct addre
 	 * We scan the hash list read-only. Addition to and removal from
 	 * the hash-list needs a held write-lock.
 	 */
-	spin_lock(&mapping->page_lock);
+	read_lock(&mapping->page_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page)
 		page_cache_get(page);
-	spin_unlock(&mapping->page_lock);
+	read_unlock(&mapping->page_lock);
 	return page;
 }
 
@@ -379,11 +379,11 @@ struct page *find_trylock_page(struct ad
 {
 	struct page *page;
 
-	spin_lock(&mapping->page_lock);
+	read_lock(&mapping->page_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page && TestSetPageLocked(page))
 		page = NULL;
-	spin_unlock(&mapping->page_lock);
+	read_unlock(&mapping->page_lock);
 	return page;
 }
 
@@ -403,15 +403,15 @@ struct page *find_lock_page(struct addre
 {
 	struct page *page;
 
-	spin_lock(&mapping->page_lock);
+	read_lock(&mapping->page_lock);
 repeat:
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page) {
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
-			spin_unlock(&mapping->page_lock);
+			read_unlock(&mapping->page_lock);
 			lock_page(page);
-			spin_lock(&mapping->page_lock);
+			read_lock(&mapping->page_lock);
 
 			/* Has the page been truncated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
@@ -421,7 +421,7 @@ repeat:
 			}
 		}
 	}
-	spin_unlock(&mapping->page_lock);
+	read_unlock(&mapping->page_lock);
 	return page;
 }
 
@@ -491,12 +491,12 @@ unsigned int find_get_pages(struct addre
 	unsigned int i;
 	unsigned int ret;
 
-	spin_lock(&mapping->page_lock);
+	read_lock(&mapping->page_lock);
 	ret = radix_tree_gang_lookup(&mapping->page_tree,
 				(void **)pages, start, nr_pages);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
-	spin_unlock(&mapping->page_lock);
+	read_unlock(&mapping->page_lock);
 	return ret;
 }
 
diff -puN mm/page-writeback.c~page_lock-is-rwlock mm/page-writeback.c
--- 25/mm/page-writeback.c~page_lock-is-rwlock	Mon Apr 21 14:44:55 2003
+++ 25-akpm/mm/page-writeback.c	Mon Apr 21 14:45:00 2003
@@ -439,12 +439,12 @@ int write_one_page(struct page *page, in
 	if (wait && PageWriteback(page))
 		wait_on_page_writeback(page);
 
-	spin_lock(&mapping->page_lock);
+	write_lock(&mapping->page_lock);
 	list_del(&page->list);
 	if (test_clear_page_dirty(page)) {
 		list_add(&page->list, &mapping->locked_pages);
 		page_cache_get(page);
-		spin_unlock(&mapping->page_lock);
+		write_unlock(&mapping->page_lock);
 		ret = mapping->a_ops->writepage(page, &wbc);
 		if (ret == 0 && wait) {
 			wait_on_page_writeback(page);
@@ -454,7 +454,7 @@ int write_one_page(struct page *page, in
 		page_cache_release(page);
 	} else {
 		list_add(&page->list, &mapping->clean_pages);
-		spin_unlock(&mapping->page_lock);
+		write_unlock(&mapping->page_lock);
 		unlock_page(page);
 	}
 	return ret;
@@ -527,14 +527,14 @@ int __set_page_dirty_buffers(struct page
 	spin_unlock(&mapping->private_lock);
 
 	if (!TestSetPageDirty(page)) {
-		spin_lock(&mapping->page_lock);
+		write_lock(&mapping->page_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (!mapping->backing_dev_info->memory_backed)
 				inc_page_state(nr_dirty);
 			list_del(&page->list);
 			list_add(&page->list, &mapping->dirty_pages);
 		}
-		spin_unlock(&mapping->page_lock);
+		write_unlock(&mapping->page_lock);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
 	
@@ -564,7 +564,7 @@ int __set_page_dirty_nobuffers(struct pa
 		struct address_space *mapping = page->mapping;
 
 		if (mapping) {
-			spin_lock(&mapping->page_lock);
+			write_lock(&mapping->page_lock);
 			if (page->mapping) {	/* Race with truncate? */
 				BUG_ON(page->mapping != mapping);
 				if (!mapping->backing_dev_info->memory_backed)
@@ -572,7 +572,7 @@ int __set_page_dirty_nobuffers(struct pa
 				list_del(&page->list);
 				list_add(&page->list, &mapping->dirty_pages);
 			}
-			spin_unlock(&mapping->page_lock);
+			write_unlock(&mapping->page_lock);
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 		}
 	}
diff -puN mm/readahead.c~page_lock-is-rwlock mm/readahead.c
--- 25/mm/readahead.c~page_lock-is-rwlock	Mon Apr 21 14:44:56 2003
+++ 25-akpm/mm/readahead.c	Mon Apr 21 14:45:00 2003
@@ -217,7 +217,7 @@ __do_page_cache_readahead(struct address
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	spin_lock(&mapping->page_lock);
+	read_lock(&mapping->page_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		unsigned long page_offset = offset + page_idx;
 		
@@ -228,16 +228,16 @@ __do_page_cache_readahead(struct address
 		if (page)
 			continue;
 
-		spin_unlock(&mapping->page_lock);
+		read_unlock(&mapping->page_lock);
 		page = page_cache_alloc_cold(mapping);
-		spin_lock(&mapping->page_lock);
+		read_lock(&mapping->page_lock);
 		if (!page)
 			break;
 		page->index = page_offset;
 		list_add(&page->list, &page_pool);
 		ret++;
 	}
-	spin_unlock(&mapping->page_lock);
+	read_unlock(&mapping->page_lock);
 
 	/*
 	 * Now start the IO.  We ignore I/O errors - if the page is not
diff -puN mm/swapfile.c~page_lock-is-rwlock mm/swapfile.c
--- 25/mm/swapfile.c~page_lock-is-rwlock	Mon Apr 21 14:44:56 2003
+++ 25-akpm/mm/swapfile.c	Mon Apr 21 14:45:00 2003
@@ -248,10 +248,10 @@ static int exclusive_swap_page(struct pa
 		/* Is the only swap cache user the cache itself? */
 		if (p->swap_map[swp_offset(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
-			spin_lock(&swapper_space.page_lock);
+			read_lock(&swapper_space.page_lock);
 			if (page_count(page) - !!PagePrivate(page) == 2)
 				retval = 1;
-			spin_unlock(&swapper_space.page_lock);
+			read_unlock(&swapper_space.page_lock);
 		}
 		swap_info_put(p);
 	}
@@ -319,13 +319,13 @@ int remove_exclusive_swap_page(struct pa
 	retval = 0;
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
-		spin_lock(&swapper_space.page_lock);
+		write_lock(&swapper_space.page_lock);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		spin_unlock(&swapper_space.page_lock);
+		write_unlock(&swapper_space.page_lock);
 	}
 	swap_info_put(p);
 
diff -puN mm/swap_state.c~page_lock-is-rwlock mm/swap_state.c
--- 25/mm/swap_state.c~page_lock-is-rwlock	Mon Apr 21 14:44:56 2003
+++ 25-akpm/mm/swap_state.c	Mon Apr 21 14:45:00 2003
@@ -34,7 +34,7 @@ extern struct address_space_operations s
 
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
-	.page_lock	= SPIN_LOCK_UNLOCKED,
+	.page_lock	= RW_LOCK_UNLOCKED,
 	.clean_pages	= LIST_HEAD_INIT(swapper_space.clean_pages),
 	.dirty_pages	= LIST_HEAD_INIT(swapper_space.dirty_pages),
 	.io_pages	= LIST_HEAD_INIT(swapper_space.io_pages),
@@ -191,9 +191,9 @@ void delete_from_swap_cache(struct page 
   
 	entry.val = page->index;
 
-	spin_lock(&swapper_space.page_lock);
+	write_lock(&swapper_space.page_lock);
 	__delete_from_swap_cache(page);
-	spin_unlock(&swapper_space.page_lock);
+	write_unlock(&swapper_space.page_lock);
 
 	swap_free(entry);
 	page_cache_release(page);
@@ -204,8 +204,8 @@ int move_to_swap_cache(struct page *page
 	struct address_space *mapping = page->mapping;
 	int err;
 
-	spin_lock(&swapper_space.page_lock);
-	spin_lock(&mapping->page_lock);
+	write_lock(&swapper_space.page_lock);
+	write_lock(&mapping->page_lock);
 
 	err = radix_tree_insert(&swapper_space.page_tree, entry.val, page);
 	if (!err) {
@@ -213,8 +213,8 @@ int move_to_swap_cache(struct page *page
 		___add_to_page_cache(page, &swapper_space, entry.val);
 	}
 
-	spin_unlock(&mapping->page_lock);
-	spin_unlock(&swapper_space.page_lock);
+	write_unlock(&mapping->page_lock);
+	write_unlock(&swapper_space.page_lock);
 
 	if (!err) {
 		if (!swap_duplicate(entry))
@@ -240,8 +240,8 @@ int move_from_swap_cache(struct page *pa
 
 	entry.val = page->index;
 
-	spin_lock(&swapper_space.page_lock);
-	spin_lock(&mapping->page_lock);
+	write_lock(&swapper_space.page_lock);
+	write_lock(&mapping->page_lock);
 
 	err = radix_tree_insert(&mapping->page_tree, index, page);
 	if (!err) {
@@ -249,8 +249,8 @@ int move_from_swap_cache(struct page *pa
 		___add_to_page_cache(page, mapping, index);
 	}
 
-	spin_unlock(&mapping->page_lock);
-	spin_unlock(&swapper_space.page_lock);
+	write_unlock(&mapping->page_lock);
+	write_unlock(&swapper_space.page_lock);
 
 	if (!err) {
 		swap_free(entry);
diff -puN mm/truncate.c~page_lock-is-rwlock mm/truncate.c
--- 25/mm/truncate.c~page_lock-is-rwlock	Mon Apr 21 14:44:56 2003
+++ 25-akpm/mm/truncate.c	Mon Apr 21 14:45:00 2003
@@ -73,13 +73,13 @@ invalidate_complete_page(struct address_
 	if (PagePrivate(page) && !try_to_release_page(page, 0))
 		return 0;
 
-	spin_lock(&mapping->page_lock);
+	write_lock(&mapping->page_lock);
 	if (PageDirty(page)) {
-		spin_unlock(&mapping->page_lock);
+		write_unlock(&mapping->page_lock);
 		return 0;
 	}
 	__remove_from_page_cache(page);
-	spin_unlock(&mapping->page_lock);
+	write_unlock(&mapping->page_lock);
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
diff -puN mm/vmscan.c~page_lock-is-rwlock mm/vmscan.c
--- 25/mm/vmscan.c~page_lock-is-rwlock	Mon Apr 21 14:44:56 2003
+++ 25-akpm/mm/vmscan.c	Mon Apr 21 14:45:00 2003
@@ -325,7 +325,7 @@ shrink_list(struct list_head *page_list,
 				goto keep_locked;
 			if (!may_write_to_queue(mapping->backing_dev_info))
 				goto keep_locked;
-			spin_lock(&mapping->page_lock);
+			write_lock(&mapping->page_lock);
 			if (test_clear_page_dirty(page)) {
 				int res;
 				struct writeback_control wbc = {
@@ -336,7 +336,7 @@ shrink_list(struct list_head *page_list,
 				};
 
 				list_move(&page->list, &mapping->locked_pages);
-				spin_unlock(&mapping->page_lock);
+				write_unlock(&mapping->page_lock);
 
 				SetPageReclaim(page);
 				res = mapping->a_ops->writepage(page, &wbc);
@@ -351,7 +351,7 @@ shrink_list(struct list_head *page_list,
 				}
 				goto keep;
 			}
-			spin_unlock(&mapping->page_lock);
+			write_unlock(&mapping->page_lock);
 		}
 
 		/*
@@ -385,7 +385,7 @@ shrink_list(struct list_head *page_list,
 		if (!mapping)
 			goto keep_locked;	/* truncate got there first */
 
-		spin_lock(&mapping->page_lock);
+		write_lock(&mapping->page_lock);
 
 		/*
 		 * The non-racy check for busy page.  It is critical to check
@@ -393,7 +393,7 @@ shrink_list(struct list_head *page_list,
 		 * not in use by anybody. 	(pagecache + us == 2)
 		 */
 		if (page_count(page) != 2 || PageDirty(page)) {
-			spin_unlock(&mapping->page_lock);
+			write_unlock(&mapping->page_lock);
 			goto keep_locked;
 		}
 
@@ -401,7 +401,7 @@ shrink_list(struct list_head *page_list,
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->index };
 			__delete_from_swap_cache(page);
-			spin_unlock(&mapping->page_lock);
+			write_unlock(&mapping->page_lock);
 			swap_free(swap);
 			__put_page(page);	/* The pagecache ref */
 			goto free_it;
@@ -409,7 +409,7 @@ shrink_list(struct list_head *page_list,
 #endif /* CONFIG_SWAP */
 
 		__remove_from_page_cache(page);
-		spin_unlock(&mapping->page_lock);
+		write_unlock(&mapping->page_lock);
 		__put_page(page);
 
 free_it:

_

