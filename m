Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEPyZ>; Fri, 5 Jan 2001 10:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131167AbRAEPyQ>; Fri, 5 Jan 2001 10:54:16 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:56590 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130682AbRAEPyH>; Fri, 5 Jan 2001 10:54:07 -0500
Date: Fri, 05 Jan 2001 10:54:04 -0500
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <662960000.978710044@tiny>
In-Reply-To: <Pine.GSO.4.21.0012291316510.29829-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the latest version of the patch, against 2.4.0.  The
biggest open issues are what to do with bdflush, since
page_launder could do everything bdflush does.  And, how to
deal with writepage funcs that return 1 for fsync_inode_buffers.

-chris

diff -urN linux.2.4.0/fs/buffer.c linux/fs/buffer.c
--- linux.2.4.0/fs/buffer.c	Thu Jan  4 23:12:28 2001
+++ linux/fs/buffer.c	Thu Jan  4 18:58:09 2001
@@ -97,6 +97,20 @@
 
 static int grow_buffers(int size);
 static void __refile_buffer(struct buffer_head *);
+static int block_write_anon_page(struct page *);
+static void end_buffer_io_async(struct buffer_head * bh, int uptodate) ;
+
+static struct address_space_operations anon_space_ops = {
+	writepage: block_write_anon_page,
+	sync_page: block_sync_page,
+} ;
+static struct address_space anon_space_mapping = {
+	LIST_HEAD_INIT(anon_space_mapping.clean_pages),
+	LIST_HEAD_INIT(anon_space_mapping.dirty_pages),
+	LIST_HEAD_INIT(anon_space_mapping.locked_pages),
+	0, /* nr_pages */
+	&anon_space_ops,
+} ;
 
 /* This is used by some architectures to estimate available memory. */
 atomic_t buffermem_pages = ATOMIC_INIT(0);
@@ -161,6 +175,73 @@
 	atomic_dec(&bh->b_count);
 }
 
+/* just for use with anon pages, or pages that don't provide their own
+** writepage func.  We just want to write bh, not the whole page, so we
+** queue that io here instead of calling writepage.
+*/
+static int __dirty_list_writepage(struct page *page, struct buffer_head *bh) {
+	int other_dirty = 0 ;
+	struct buffer_head *cur ;
+
+	/* check for other dirty buffers on this page.  If there are none,
+	** clear the page dirty bit
+	*/
+	cur = bh->b_this_page ;
+	while(cur != bh) {
+		other_dirty += buffer_dirty(cur) ;	
+		cur = cur->b_this_page ;
+	} 
+	if (other_dirty == 0) {
+		ClearPageDirty(page) ;
+	} 
+
+	/* we want the page available for locking again right away.  
+	** someone walking the dirty buffer list might find another
+	** buffer from this page, and we don't want them to skip it in
+	** favor of a younger buffer.
+	*/
+	atomic_inc(&bh->b_count) ;
+	UnlockPage(page) ;
+	ll_rw_block(WRITE, 1, &bh) ;
+	atomic_dec(&bh->b_count) ;
+	return 0 ;
+}
+
+/*
+** util function for sync_buffers and flush_dirty_buffers
+** uses either the writepage func supplied in the page's mapping,
+** or the anon address space writepage
+*/
+static int dirty_list_writepage(struct page *page, struct buffer_head *bh) {
+	int (*writepage)(struct page *)  ;
+	int ret ;
+
+	/* someone wrote this page while we were locking before */
+	if (!PageDirty(page) && !buffer_dirty(bh)) {
+		UnlockPage(page) ;
+		return 0 ;
+	}
+	writepage = page->mapping->a_ops->writepage ;
+
+	/* For anon pages, and pages that don't have a writepage
+	** func, just write this one dirty buffer.  __dirty_list_writepage
+	** does a little more work to make sure the page dirty bit is cleared
+	** when we are the only dirty buffer on this page
+	*/
+	if (!writepage || page->mapping == &anon_space_mapping) {
+		writepage = anon_space_ops.writepage ;
+		return __dirty_list_writepage(page, bh) ;
+	}
+
+	ClearPageDirty(page) ;
+	ret = writepage(page) ;
+	if (ret == 1) {
+		SetPageDirty(page) ;
+		UnlockPage(page) ;
+	}
+	return ret ;
+}
+
 /* Call sync_buffers with wait!=0 to ensure that the call does not
  * return until all buffer writes have completed.  Sync() may return
  * before the writes have finished; fsync() may not.
@@ -175,6 +256,7 @@
 {
 	int i, retry, pass = 0, err = 0;
 	struct buffer_head * bh, *next;
+	struct page *page ;
 
 	/* One pass for no-wait, three for wait:
 	 * 0) write out all dirty, unlocked buffers;
@@ -230,10 +312,27 @@
 			if (!buffer_dirty(bh) || pass >= 2)
 				continue;
 
-			atomic_inc(&bh->b_count);
+			page = bh->b_page ;
+			page_cache_get(page) ;
+			if (TryLockPage(page)) {
+				if (!wait || !pass) {
+					retry = 1 ;
+					continue ;
+				}
+				spin_unlock(&lru_list_lock);
+				wait_on_page(page) ;
+				page_cache_release(page) ;
+				goto repeat ;
+			}
 			spin_unlock(&lru_list_lock);
-			ll_rw_block(WRITE, 1, &bh);
-			atomic_dec(&bh->b_count);
+
+			/* if the writepage func returns 1, it is 
+			** responsible for marking the buffers dirty
+			** again (or not marking them clean at all).
+			** we'll catch them again on the next pass
+			*/
+			dirty_list_writepage(page, bh) ;
+			page_cache_release(page) ;
 			retry = 1;
 			goto repeat;
 		}
@@ -649,7 +748,7 @@
 			if (bh->b_dev != dev)
 				continue;
 			/* Part of a mapping? */
-			if (bh->b_page->mapping)
+			if (bh->b_page->mapping != &anon_space_mapping)
 				continue;
 			if (buffer_locked(bh)) {
 				atomic_inc(&bh->b_count);
@@ -861,13 +960,14 @@
 int fsync_inode_buffers(struct inode *inode)
 {
 	struct buffer_head *bh;
-	struct inode tmp;
+	struct inode tmp ;
 	int err = 0, err2;
+	struct page * page ;
+	int ret ;
 	
 	INIT_LIST_HEAD(&tmp.i_dirty_buffers);
 	
 	spin_lock(&lru_list_lock);
-
 	while (!list_empty(&inode->i_dirty_buffers)) {
 		bh = BH_ENTRY(inode->i_dirty_buffers.next);
 		list_del(&bh->b_inode_buffers);
@@ -877,11 +977,28 @@
 			bh->b_inode = &tmp;
 			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
 			if (buffer_dirty(bh)) {
-				atomic_inc(&bh->b_count);
+				page = bh->b_page ;
+				page_cache_get(page) ;
 				spin_unlock(&lru_list_lock);
-				ll_rw_block(WRITE, 1, &bh);
-				brelse(bh);
+
+				LockPage(page) ;
+				ret = dirty_list_writepage(page, bh) ;
+				page_cache_release(page) ;
+
 				spin_lock(&lru_list_lock);
+
+				/* if the writepage func decided to skip
+				** this page, we have to put it back onto
+				** the dirty buffer list.  we add onto the 
+				** tail so this buffer will be retried after
+				** all the other writes have gone through.
+				*/
+				if (ret == 1) {
+					list_del(&bh->b_inode_buffers) ;
+					list_add_tail(&bh->b_inode_buffers,
+						      &inode->i_dirty_buffers) ;
+					bh->b_inode = inode ;
+				}
 			}
 		}
 	}
@@ -1112,8 +1229,10 @@
 	int dispose = BUF_CLEAN;
 	if (buffer_locked(bh))
 		dispose = BUF_LOCKED;
-	if (buffer_dirty(bh))
+	if (buffer_dirty(bh)) {
 		dispose = BUF_DIRTY;
+		SetPageDirty(bh->b_page) ;
+	}
 	if (buffer_protected(bh))
 		dispose = BUF_PROTECTED;
 	if (dispose != bh->b_list) {
@@ -1489,6 +1608,53 @@
  * "Dirty" is valid only with the last case (mapped+uptodate).
  */
 
+static int block_write_anon_page(struct page *page) 
+{
+	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	int i, nr = 0 ;
+	int partial = 0 ;
+	int ret = 0 ;
+
+	if (!PageLocked(page))
+		BUG();
+
+	if (!page->buffers)
+		BUG() ;
+
+	head = page->buffers;
+	bh = head;
+
+	/* Stage 1: find the dirty buffers, lock them for submit_bh */
+	do {
+		if (!test_and_set_bit(BH_Lock, &bh->b_state)) {
+			if (buffer_uptodate(bh) && buffer_dirty(bh)) {
+				bh->b_end_io = end_buffer_io_async;
+				clear_bit(BH_Dirty, &bh->b_state) ;
+				atomic_inc(&bh->b_count);
+				arr[nr++] = bh ;
+			} else {
+				partial = 1 ;
+				unlock_buffer(bh) ;
+			}
+		} else {
+			partial = 1 ;
+		}
+		bh = bh->b_this_page;
+	} while (bh != head);
+
+	/* Stage 2: submit the IO */
+	for (i = 0 ; i < nr ; i++) {
+		submit_bh(WRITE, arr[i]) ;
+	}
+	/* Done - end_buffer_io_async will unlock */
+	if (!partial)
+		SetPageUptodate(page);
+	if (nr == 0) {
+		UnlockPage(page) ;
+	}
+	return ret ;
+}
+
 /*
  * block_write_full_page() is SMP-safe - currently it's still
  * being called with the kernel lock held, but the code is ready.
@@ -1498,6 +1664,10 @@
 	int err, i;
 	unsigned long block;
 	struct buffer_head *bh, *head;
+	int nr = 0 ;
+	struct buffer_head *arr[MAX_BUF_PER_PAGE] ;
+	int page_ok = Page_Uptodate(page) ;
+	int partial = 0;
 
 	if (!PageLocked(page))
 		BUG();
@@ -1520,36 +1690,46 @@
 		 *
 		 * Leave it to the low-level FS to make all those
 		 * decisions (block #0 may actually be a valid block)
+		 *
+		 * only bother when the page is up to date or the buffer
+		 * is dirty.
 		 */
-		if (!buffer_mapped(bh)) {
-			err = get_block(inode, block, bh, 1);
-			if (err)
-				goto out;
-			if (buffer_new(bh))
-				unmap_underlying_metadata(bh);
+		if (page_ok || buffer_dirty(bh)) {
+			if (!buffer_mapped(bh)) {
+				err = get_block(inode, block, bh, 1);
+				if (err)
+					goto out;
+				if (buffer_new(bh))
+					unmap_underlying_metadata(bh);
+			}
+			arr[nr++] = bh ; 
+		} else {
+			partial = 1 ;
 		}
 		bh = bh->b_this_page;
 		block++;
 	} while (bh != head);
 
 	/* Stage 2: lock the buffers, mark them clean */
-	do {
+	for (i = 0 ; i < nr ; i++) {
+		bh = arr[i] ;
 		lock_buffer(bh);
 		bh->b_end_io = end_buffer_io_async;
 		atomic_inc(&bh->b_count);
 		set_bit(BH_Uptodate, &bh->b_state);
 		clear_bit(BH_Dirty, &bh->b_state);
-		bh = bh->b_this_page;
-	} while (bh != head);
+	} 
 
-	/* Stage 3: submit the IO */
-	do {
-		submit_bh(WRITE, bh);
-		bh = bh->b_this_page;		
-	} while (bh != head);
+	for (i = 0 ; i < nr ; i++) {
+		submit_bh(WRITE, arr[i]) ;
+	}
+
+	if (nr == 0) 
+		UnlockPage(page) ;
 
 	/* Done - end_buffer_io_async will unlock */
-	SetPageUptodate(page);
+	if (!partial)
+		SetPageUptodate(page);
 	return 0;
 
 out:
@@ -1669,6 +1849,45 @@
 }
 
 /*
+** just sets the dirty bits for a range of buffers in the page.  Does
+** not balance the dirty list, or put the buffers onto the dirty list
+*/
+static int __block_dirty_range(struct inode *inode, struct page *page,
+		unsigned from, unsigned to)
+{
+	unsigned block_start, block_end;
+	int partial = 0 ;
+	unsigned blocksize;
+	struct buffer_head *bh, *head;
+
+	blocksize = inode->i_sb->s_blocksize;
+
+	for(bh = head = page->buffers, block_start = 0;
+	    bh != head || !block_start;
+	    block_start=block_end, bh = bh->b_this_page) {
+		block_end = block_start + blocksize;
+		if (block_end <= from || block_start >= to) {
+			if (!buffer_uptodate(bh))
+				partial = 1;
+		} else {
+			set_bit(BH_Uptodate, &bh->b_state);
+			if (!atomic_set_buffer_dirty(bh)) {
+				buffer_insert_inode_queue(bh, inode);
+			}
+		}
+	}
+	/*
+	 * is this a partial write that happened to make all buffers
+	 * uptodate then we can optimize away a bogus readpage() for
+	 * the next read(). Here we 'discover' wether the page went
+	 * uptodate as a result of this (potentially partial) write.
+	 */
+	if (!partial)
+		SetPageUptodate(page);
+	return 0;
+}
+
+/*
  * Generic "read page" function for block devices that have the normal
  * get_block functionality. This is most of the block device filesystems.
  * Reads the page asynchronously --- the unlock_buffer() and
@@ -1958,13 +2177,23 @@
 	if (!err) {
 		memset(page_address(page) + offset, 0, PAGE_CACHE_SIZE - offset);
 		flush_dcache_page(page);
-		__block_commit_write(inode,page,0,offset);
+
+		/* this will just set the dirty bits for block_write_full_page
+		** it is only safe because we have the page locked and
+		** nobody will try to write the buffers between
+		** the block_dirty_range and the write_full_page calls
+		** we have to clear the page up to date so the buffers
+		** past the end of the file won't get written
+		*/
+		__block_dirty_range(inode,page,0,offset);
+		ClearPageUptodate(page);
+		err = __block_write_full_page(inode, page, get_block) ;
 done:
 		kunmap(page);
-		UnlockPage(page);
 		return err;
 	}
 	ClearPageUptodate(page);
+	UnlockPage(page);
 	goto done;
 }
 
@@ -2255,7 +2484,7 @@
 	struct buffer_head *bh, *tmp;
 	struct buffer_head * insert_point;
 	int isize;
-
+	unsigned long index ;
 	if ((size & 511) || (size > PAGE_SIZE)) {
 		printk("VFS: grow_buffers: size = %d\n",size);
 		return 0;
@@ -2271,6 +2500,16 @@
 
 	isize = BUFSIZE_INDEX(size);
 
+	/* don't put this buffer head on the free list until the
+	** page is setup.  Is there a better index to use?  Would 0
+	** be good enough?
+	*/
+	page->flags &= ~(1 << PG_referenced);
+	index = atomic_read(&buffermem_pages) ;
+	atomic_inc(&buffermem_pages);
+	add_to_page_cache_locked(page, &anon_space_mapping, index) ;
+	page->buffers = bh;
+
 	spin_lock(&free_list[isize].lock);
 	insert_point = free_list[isize].list;
 	tmp = bh;
@@ -2294,11 +2533,7 @@
 	free_list[isize].list = bh;
 	spin_unlock(&free_list[isize].lock);
 
-	page->buffers = bh;
-	page->flags &= ~(1 << PG_referenced);
-	lru_cache_add(page);
 	UnlockPage(page);
-	atomic_inc(&buffermem_pages);
 	return 1;
 
 no_buffer_head:
@@ -2320,7 +2555,6 @@
  *
  * Wait:
  *	0 - no wait (this does not get called - see try_to_free_buffers below)
- *	1 - start IO for dirty buffers
  *	2 - wait for completion of locked buffers
  */
 static void sync_page_buffers(struct buffer_head *bh, int wait)
@@ -2330,11 +2564,9 @@
 	do {
 		struct buffer_head *p = tmp;
 		tmp = tmp->b_this_page;
-		if (buffer_locked(p)) {
-			if (wait > 1)
-				__wait_on_buffer(p);
-		} else if (buffer_dirty(p))
-			ll_rw_block(WRITE, 1, &p);
+		if (buffer_locked(p) && wait > 1) {
+			__wait_on_buffer(p);
+		} 
 	} while (tmp != bh);
 }
 
@@ -2397,6 +2629,9 @@
 
 	/* And free the page */
 	page->buffers = NULL;
+	if (page->mapping == &anon_space_mapping) {
+		atomic_dec(&buffermem_pages) ;
+	}
 	page_cache_release(page);
 	spin_unlock(&free_list[index].lock);
 	write_unlock(&hash_table_lock);
@@ -2547,6 +2782,7 @@
 static int flush_dirty_buffers(int check_flushtime)
 {
 	struct buffer_head * bh, *next;
+	struct page *page ;
 	int flushed = 0, i;
 
  restart:
@@ -2563,6 +2799,8 @@
 		}
 		if (buffer_locked(bh))
 			continue;
+		if (!buffer_uptodate(bh))
+			continue ;
 
 		if (check_flushtime) {
 			/* The dirty lru list is chronologically ordered so
@@ -2575,13 +2813,15 @@
 			if (++flushed > bdf_prm.b_un.ndirty)
 				goto out_unlock;
 		}
-
-		/* OK, now we are committed to write it out. */
-		atomic_inc(&bh->b_count);
-		spin_unlock(&lru_list_lock);
-		ll_rw_block(WRITE, 1, &bh);
-		atomic_dec(&bh->b_count);
-
+		page = bh->b_page ;
+		page_cache_get(page) ;
+		if (TryLockPage(page)) {
+			page_cache_release(page) ;
+			continue ;
+		}
+		spin_unlock(&lru_list_lock) ;
+		dirty_list_writepage(page, bh) ;
+		page_cache_release(page) ;
 		if (current->need_resched)
 			schedule();
 		goto restart;
diff -urN linux.2.4.0/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.2.4.0/mm/page_alloc.c	Thu Jan  4 23:11:21 2001
+++ linux/mm/page_alloc.c	Thu Jan  4 18:51:10 2001
@@ -307,11 +307,12 @@
 	/*
 	 * If we are about to get low on free pages and cleaning
 	 * the inactive_dirty pages would fix the situation,
-	 * wake up bdflush.
+	 * wake up kswapd here as well, so page_launder can start
+	 * sending things to disk.
 	 */
 	else if (free_shortage() && nr_inactive_dirty_pages > free_shortage()
 			&& nr_inactive_dirty_pages >= freepages.high)
-		wakeup_bdflush(0);
+		wakeup_kswapd(0);
 
 try_again:
 	/*
diff -urN linux.2.4.0/mm/vmscan.c linux/mm/vmscan.c
--- linux.2.4.0/mm/vmscan.c	Thu Jan  4 23:11:21 2001
+++ linux/mm/vmscan.c	Thu Jan  4 18:53:54 2001
@@ -615,7 +615,6 @@
 
 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
-				atomic_dec(&buffermem_pages);
 				freed_page = 1;
 				cleaned_pages++;
 
@@ -638,10 +637,9 @@
 			page_cache_release(page);
 
 			/* 
-			 * If we're freeing buffer cache pages, stop when
-			 * we've got enough free memory.
+			 * stop when we've got enough free memory.
 			 */
-			if (freed_page && !free_shortage())
+			if (!free_shortage())
 				break;
 			continue;
 		} else if (page->mapping && !PageDirty(page)) {
@@ -676,9 +674,6 @@
 	 * free anything yet, we wait synchronously on the writeout of
 	 * MAX_SYNC_LAUNDER pages.
 	 *
-	 * We also wake up bdflush, since bdflush should, under most
-	 * loads, flush out the dirty pages before we have to wait on
-	 * IO.
 	 */
 	if (can_get_io_locks && !launder_loop && free_shortage()) {
 		launder_loop = 1;
@@ -687,8 +682,6 @@
 			sync = 0;
 		/* We only do a few "out of order" flushes. */
 		maxlaunder = MAX_LAUNDER;
-		/* Kflushd takes care of the rest. */
-		wakeup_bdflush(0);
 		goto dirty_page_rescan;
 	}
 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
