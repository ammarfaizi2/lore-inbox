Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130429AbQLWSx4>; Sat, 23 Dec 2000 13:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130754AbQLWSxq>; Sat, 23 Dec 2000 13:53:46 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:57863 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130429AbQLWSxj>; Sat, 23 Dec 2000 13:53:39 -0500
Date: Sat, 23 Dec 2000 13:21:30 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <300720000.977595690@coffee>
In-Reply-To: <Pine.LNX.4.21.0012221933050.3382-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, December 22, 2000 21:26:33 -0200 Marcelo Tosatti 
> If we use ll_rw_block directly on buffers of anonymous pages
> (page->mapping == &anon_space_mapping) instead using
> dirty_list_writepage() (which will end up calling block_write_anon_page)
> we can fix the buffer flushtime issue.
> 

Ok, I'm just being stubborn.  The point of the patch was to get rid
of the ll_rw_block calls, so I'm resisting adding one back in ;-)
But, your way does seem like the least complicated method to honor 
the flushtime param for anon pages, and I'll switch over to that.

I've updated to test13-pre4, and removed the hunk for submit_bh.
Looks as though pre4 changed the submit_bh callers to clear the dirty
bit, so my code does the same.

Other changes: sync_page_buffers doesn't write blocks on the page, it 
only waits on them.  Minor change to when the page count is
increased before writepage is called.

I still need to update fsync_inode_buffers....doesn't look like that
will happen before I head off to visit family, where for some reason
they've banned me from reading email ;-)  I'll be back on Tuesday,
hope everyone has a good holiday.  New patch below:

-chris

diff -urN linux-test13-pre4/fs/buffer.c linux-anon-space/fs/buffer.c
--- linux-test13-pre4/fs/buffer.c	Sat Dec 23 13:14:48 2000
+++ linux-anon-space/fs/buffer.c	Sat Dec 23 13:30:24 2000
@@ -97,6 +97,16 @@
 
 static int grow_buffers(int size);
 static void __refile_buffer(struct buffer_head *);
+static int block_write_anon_page(struct page *);
+
+static struct address_space_operations anon_space_ops = {
+	writepage: block_write_anon_page,
+	sync_page: block_sync_page,
+} ;
+static struct address_space anon_space_mapping = {
+	pages: { &anon_space_mapping.pages, &anon_space_mapping.pages },
+	a_ops: &anon_space_ops,
+} ;
 
 /* This is used by some architectures to estimate available memory. */
 atomic_t buffermem_pages = ATOMIC_INIT(0);
@@ -161,6 +171,30 @@
 	atomic_dec(&bh->b_count);
 }
 
+/*
+** util function for sync_buffers and flush_dirty_buffers
+** uses either the writepage func supplied in the page's mapping,
+** or the anon address space writepage
+*/
+static int dirty_list_writepage(struct page *page) {
+	int (*writepage)(struct page *)  ;
+	int ret ;
+
+	writepage = page->mapping->a_ops->writepage ;
+
+	if (!writepage) {
+		writepage = anon_space_ops.writepage ;
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
@@ -175,6 +209,7 @@
 {
 	int i, retry, pass = 0, err = 0;
 	struct buffer_head * bh, *next;
+	struct page *page ;
 
 	/* One pass for no-wait, three for wait:
 	 * 0) write out all dirty, unlocked buffers;
@@ -230,10 +265,22 @@
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
+			dirty_list_writepage(page) ;
+			page_cache_release(page) ;
 			retry = 1;
 			goto repeat;
 		}
@@ -1101,8 +1148,10 @@
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
@@ -1478,6 +1527,53 @@
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
@@ -1487,6 +1583,10 @@
 	int err, i;
 	unsigned long block;
 	struct buffer_head *bh, *head;
+	int nr = 0 ;
+	struct buffer_head *arr[MAX_BUF_PER_PAGE] ;
+	int page_ok = Page_Uptodate(page) ;
+	int partial = 0;
 
 	if (!PageLocked(page))
 		BUG();
@@ -1509,36 +1609,46 @@
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
@@ -1658,6 +1768,45 @@
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
@@ -1947,13 +2096,23 @@
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
 
@@ -2244,7 +2403,7 @@
 	struct buffer_head *bh, *tmp;
 	struct buffer_head * insert_point;
 	int isize;
-
+	unsigned long index ;
 	if ((size & 511) || (size > PAGE_SIZE)) {
 		printk("VFS: grow_buffers: size = %d\n",size);
 		return 0;
@@ -2260,6 +2419,16 @@
 
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
@@ -2283,11 +2452,7 @@
 	free_list[isize].list = bh;
 	spin_unlock(&free_list[isize].lock);
 
-	page->buffers = bh;
-	page->flags &= ~(1 << PG_referenced);
-	lru_cache_add(page);
 	UnlockPage(page);
-	atomic_inc(&buffermem_pages);
 	return 1;
 
 no_buffer_head:
@@ -2309,7 +2474,6 @@
  *
  * Wait:
  *	0 - no wait (this does not get called - see try_to_free_buffers below)
- *	1 - start IO for dirty buffers
  *	2 - wait for completion of locked buffers
  */
 static void sync_page_buffers(struct buffer_head *bh, int wait)
@@ -2319,11 +2483,9 @@
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
 
@@ -2386,6 +2548,9 @@
 
 	/* And free the page */
 	page->buffers = NULL;
+	if (page->mapping == (&anon_space_mapping)) {
+		atomic_dec(&buffermem_pages) ;
+	}
 	page_cache_release(page);
 	spin_unlock(&free_list[index].lock);
 	write_unlock(&hash_table_lock);
@@ -2564,6 +2729,7 @@
 static int flush_dirty_buffers(int check_flushtime)
 {
 	struct buffer_head * bh, *next;
+	struct page *page ;
 	int flushed = 0, i;
 
  restart:
@@ -2580,6 +2746,8 @@
 		}
 		if (buffer_locked(bh))
 			continue;
+		if (!buffer_uptodate(bh))
+			continue ;
 
 		if (check_flushtime) {
 			/* The dirty lru list is chronologically ordered so
@@ -2592,13 +2760,15 @@
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
+		dirty_list_writepage(page) ;
+		page_cache_release(page) ;
 		if (current->need_resched)
 			schedule();
 		goto restart;
diff -urN linux-test13-pre4/mm/page_alloc.c linux-anon-space/mm/page_alloc.c
--- linux-test13-pre4/mm/page_alloc.c	Tue Nov 28 13:54:31 2000
+++ linux-anon-space/mm/page_alloc.c	Thu Dec 21 16:24:44 2000
@@ -317,11 +317,12 @@
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
diff -urN linux-test13-pre4/mm/vmscan.c linux-anon-space/mm/vmscan.c
--- linux-test13-pre4/mm/vmscan.c	Sat Dec 23 13:14:26 2000
+++ linux-anon-space/mm/vmscan.c	Sat Dec 23 13:33:53 2000
@@ -678,7 +678,6 @@
 
 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
-				atomic_dec(&buffermem_pages);
 				freed_page = 1;
 				cleaned_pages++;
 
@@ -739,9 +738,6 @@
 	 * free anything yet, we wait synchronously on the writeout of
 	 * MAX_SYNC_LAUNDER pages.
 	 *
-	 * We also wake up bdflush, since bdflush should, under most
-	 * loads, flush out the dirty pages before we have to wait on
-	 * IO.
 	 */
 	if (can_get_io_locks && !launder_loop && free_shortage()) {
 		launder_loop = 1;
@@ -750,8 +746,6 @@
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
