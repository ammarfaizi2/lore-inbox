Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269420AbRGaTJM>; Tue, 31 Jul 2001 15:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269426AbRGaTJG>; Tue, 31 Jul 2001 15:09:06 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:13829
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S269420AbRGaTIw>; Tue, 31 Jul 2001 15:08:52 -0400
Date: Tue, 31 Jul 2001 15:07:51 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: [RFC] using writepage to start io
Message-ID: <233400000.996606471@tiny>
In-Reply-To: <76740000.996336108@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



[ linux-mm is cc'd this time, so description is included again, patch 
is slightly updated from the one on Saturday ]

Hello everyone,

This has been tested a little more now, both ext2 (1k, 4k) and reiserfs.  
dbench and iozone testing don't show any difference, but I need to 
spend a little more time on the benchmarks.

This patch changes fs/buffer.c to use writepage to start i/o,
instead of writing buffers directly.  It also changes refile_buffer
to mark the page dirty when marking buffers dirty.

The idea is that using flush_dirty_buffers to start i/o under memory
pressure is less than optimal.  flush_dirty_buffers knows the oldest
dirty buffer, but has no page aging info, so it might not flush a page
that we actually want to free.

I had to keep some of the flush_dirty_buffer calls as page_launder
wasn't triggering enough i/o on its own.  What I'd like to do now is
experiment with changing bdflush to only write pages off the inactive
dirty lists.

Since fs/buffer.c uses writepage instead of writing the page directly,
the filesystems can do more advanced things on writeout, but can still
use the generic dirty lists.

Major changes:

writepage can now be called on pages that are not up to date, so the
writepage func needs to check the page up to date bit before writing
buffers that are not marked up to date.

block_write_full_page used to send the last page in the file through
block_commit_write to mark the buffers dirty.  That doesn't work here
since writepage is used to start the io.  Instead __block_write_full_page
was changed to skip io on buffers past eof.

The ext2 directory page cache code fills placeholders in the page past
the EOF.  But, the generic block_write_full_page zeros past eof, which
makes the ext2 code very unhappy.  This adds a block_write_dir_page
that doesn't zero past eof, and changes ext2 to use it for directories.

flush_dirty_buffers now calls into the filesystem, so it is only safe
to mark a buffer dirty if you know your writepage func won't deadlock
when called by flush_dirty_buffers (thus the reiserfs_writepage changes
in this patch).

-chris

Patch is against 2.4.7:
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Tue Jul 31 14:43:40 2001
+++ b/fs/buffer.c	Tue Jul 31 14:43:40 2001
@@ -98,6 +98,21 @@
 
 static int grow_buffers(int size);
 static void __refile_buffer(struct buffer_head *);
+int block_write_anon_page(struct page *);
+static int dirty_list_writepage(struct page *page, struct buffer_head *bh) ;
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
@@ -181,66 +196,46 @@
 	put_bh(bh);
 }
 
-/*
- * The buffers have been marked clean and locked.  Just submit the dang
- * things.. 
- *
- * We'll wait for the first one of them - "sync" is not exactly
- * performance-critical, and this makes us not hog the IO subsystem
- * completely, while still allowing for a fair amount of concurrent IO. 
- */
-static void write_locked_buffers(struct buffer_head **array, unsigned int count)
-{
-	struct buffer_head *wait = *array;
-	get_bh(wait);
-	do {
-		struct buffer_head * bh = *array++;
-		bh->b_end_io = end_buffer_io_sync;
-		submit_bh(WRITE, bh);
-	} while (--count);
-	wait_on_buffer(wait);
-	put_bh(wait);
-}
-
-#define NRSYNC (32)
 static void write_unlocked_buffers(kdev_t dev)
 {
 	struct buffer_head *next;
-	struct buffer_head *array[NRSYNC];
-	unsigned int count;
+	struct page *page ;
 	int nr;
 
 repeat:
 	spin_lock(&lru_list_lock);
 	next = lru_list[BUF_DIRTY];
 	nr = nr_buffers_type[BUF_DIRTY] * 2;
-	count = 0;
 	while (next && --nr >= 0) {
 		struct buffer_head * bh = next;
 		next = bh->b_next_free;
 
 		if (dev && bh->b_dev != dev)
 			continue;
-		if (test_and_set_bit(BH_Lock, &bh->b_state))
-			continue;
-		get_bh(bh);
-		if (atomic_set_buffer_clean(bh)) {
-			__refile_buffer(bh);
-			array[count++] = bh;
-			if (count < NRSYNC)
-				continue;
+		page = bh->b_page ;
 
-			spin_unlock(&lru_list_lock);
-			write_locked_buffers(array, count);
-			goto repeat;
+		/* if we wrote the buffer the last time through, it
+		** might not have been refiled yet.  Without this check,
+		** we just end up working on the same buffer over and
+		** over again due to the goto after dirty_list_writepage
+		*/
+		if (buffer_locked(bh) || !buffer_dirty(bh)) {
+			__refile_buffer(bh) ;
+			continue ;
 		}
-		unlock_buffer(bh);
-		put_bh(bh);
+		if (TryLockPage(page)) {
+			continue ;
+		}
+		page_cache_get(page) ;
+		get_bh(bh) ;
+		spin_unlock(&lru_list_lock);
+		dirty_list_writepage(page, bh) ;
+		put_bh(bh) ;
+		page_cache_release(page) ;
+		goto repeat;
+
 	}
 	spin_unlock(&lru_list_lock);
-
-	if (count)
-		write_locked_buffers(array, count);
 }
 
 static int wait_for_locked_buffers(kdev_t dev, int index, int refile)
@@ -274,6 +269,69 @@
 	return 0;
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
+	**
+	*/
+	get_bh(bh) ;
+	lock_buffer(bh) ;
+	clear_bit(BH_Dirty, &bh->b_state) ;
+	bh->b_end_io = end_buffer_io_sync ;
+	UnlockPage(page) ;
+	submit_bh(WRITE, bh) ;
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
+		return __dirty_list_writepage(page, bh) ;
+	}
+
+	ClearPageDirty(page) ;
+	return writepage(page) ;
+}
+
 /* Call sync_buffers with wait!=0 to ensure that the call does not
  * return until all buffer writes have completed.  Sync() may return
  * before the writes have finished; fsync() may not.
@@ -775,7 +833,7 @@
 	if (free_shortage())
 		page_launder(GFP_NOFS, 0);
 	if (!grow_buffers(size)) {
-		wakeup_bdflush(1);
+		wakeup_kswapd() ;
 		current->policy |= SCHED_YIELD;
 		__set_current_state(TASK_RUNNING);
 		schedule();
@@ -795,6 +853,7 @@
 	unsigned long flags;
 	struct buffer_head *tmp;
 	struct page *page;
+	int partial = 0 ;
 
 	mark_buffer_uptodate(bh, uptodate);
 
@@ -820,6 +879,8 @@
 	unlock_buffer(bh);
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
+		if (!buffer_uptodate(tmp))
+			partial = 1 ;
 		if (tmp->b_end_io == end_buffer_io_async && buffer_locked(tmp))
 			goto still_busy;
 		tmp = tmp->b_this_page;
@@ -833,7 +894,7 @@
 	 * if none of the buffers had errors then we can set the
 	 * page uptodate:
 	 */
-	if (!PageError(page))
+	if (!PageError(page) && !partial)
 		SetPageUptodate(page);
 
 	/*
@@ -897,8 +958,16 @@
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(&lru_list_lock);
-				ll_rw_block(WRITE, 1, &bh);
-				brelse(bh);
+				lock_buffer(bh) ;
+				/* if we are the only buffer on this page,
+				** we know we have cleaned the page
+				*/
+				if (bh->b_this_page == bh) {
+					ClearPageDirty(bh->b_page) ;    
+				}
+				clear_bit(BH_Dirty, &bh->b_state) ;
+				bh->b_end_io = end_buffer_io_sync ;
+				submit_bh(WRITE, bh) ;
 				spin_lock(&lru_list_lock);
 			}
 		}
@@ -1086,7 +1155,7 @@
 
 	if (state < 0)
 		return;
-	wakeup_bdflush(state);
+	wakeup_bdflush(state) ;
 }
 
 static __inline__ void __mark_dirty(struct buffer_head *bh)
@@ -1120,8 +1189,10 @@
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
@@ -1160,10 +1231,14 @@
  */
 void __bforget(struct buffer_head * buf)
 {
+	struct address_space *mapping ;
 	/* grab the lru lock here to block bdflush. */
 	spin_lock(&lru_list_lock);
 	write_lock(&hash_table_lock);
-	if (!atomic_dec_and_test(&buf->b_count) || buffer_locked(buf) || buffer_protected(buf))
+	mapping = buf->b_page->mapping ;
+	if (mapping != &anon_space_mapping || 
+	    !atomic_dec_and_test(&buf->b_count) || 
+	    buffer_locked(buf) || buffer_protected(buf))
 		goto in_use;
 	__hash_unlink(buf);
 	remove_inode_queue(buf);
@@ -1497,6 +1572,50 @@
  * "Dirty" is valid only with the last case (mapped+uptodate).
  */
 
+int block_write_anon_page(struct page *page) 
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
+		if (buffer_dirty(bh)) {
+			get_bh(bh) ;
+			lock_buffer(bh) ;
+			set_bit(BH_Uptodate, &bh->b_state) ;
+			bh->b_end_io = end_buffer_io_async;
+			clear_bit(BH_Dirty, &bh->b_state) ;
+			arr[nr++] = bh ;
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
@@ -1505,16 +1624,23 @@
 {
 	int err, i;
 	unsigned long block;
+	unsigned long lblock ;
+	unsigned long blocksize = inode->i_sb->s_blocksize ;
 	struct buffer_head *bh, *head;
+	int page_ok = Page_Uptodate(page) ;
+	struct buffer_head *arr[MAX_BUF_PER_PAGE] ;
+	int nr = 0 ;
+	int partial = 0 ;
 
 	if (!PageLocked(page))
 		BUG();
 
 	if (!page->buffers)
-		create_empty_buffers(page, inode->i_dev, inode->i_sb->s_blocksize);
+		create_empty_buffers(page, inode->i_dev, blocksize);
 	head = page->buffers;
 
 	block = page->index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
+	lblock = (inode->i_size+blocksize-1) >> inode->i_sb->s_blocksize_bits;
 
 	bh = head;
 	i = 0;
@@ -1529,36 +1655,42 @@
 		 * Leave it to the low-level FS to make all those
 		 * decisions (block #0 may actually be a valid block)
 		 */
-		if (!buffer_mapped(bh)) {
-			err = get_block(inode, block, bh, 1);
-			if (err)
-				goto out;
-			if (buffer_new(bh))
-				unmap_underlying_metadata(bh);
+		if ((buffer_dirty(bh) || page_ok) && block < lblock) {
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
+	for(i = 0 ; i < nr ; i++) {
+		bh = arr[i] ;
 		lock_buffer(bh);
 		bh->b_end_io = end_buffer_io_async;
 		get_bh(bh);
 		set_bit(BH_Uptodate, &bh->b_state);
 		clear_bit(BH_Dirty, &bh->b_state);
-		bh = bh->b_this_page;
-	} while (bh != head);
+	} 
 
 	/* Stage 3: submit the IO */
-	do {
-		struct buffer_head *next = bh->b_this_page;
-		submit_bh(WRITE, bh);
-		bh = next;
-	} while (bh != head);
+	for(i = 0 ; i < nr ; i++) {
+		submit_bh(WRITE, arr[i]);
+	}
+	if (nr == 0)
+		UnlockPage(page) ;
 
 	/* Done - end_buffer_io_async will unlock */
-	SetPageUptodate(page);
+	if (!partial)
+		SetPageUptodate(page);
 	return 0;
 
 out:
@@ -1948,7 +2080,6 @@
 	struct inode *inode = page->mapping->host;
 	unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 	unsigned offset;
-	int err;
 
 	/* easy case */
 	if (page->index < end_index)
@@ -1963,18 +2094,35 @@
 	}
 
 	/* Sigh... will have to work, then... */
-	err = __block_prepare_write(inode, page, 0, offset, get_block);
-	if (!err) {
-		memset(page_address(page) + offset, 0, PAGE_CACHE_SIZE - offset);
-		flush_dcache_page(page);
-		__block_commit_write(inode,page,0,offset);
-done:
-		kunmap(page);
+	memset(kmap(page) + offset, 0, PAGE_CACHE_SIZE - offset);
+	flush_dcache_page(page);
+	kunmap(page);
+	return __block_write_full_page(inode, page, get_block) ;
+}
+
+int block_write_dir_page(struct page *page, get_block_t *get_block)
+{
+	struct inode *inode = page->mapping->host;
+	unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	unsigned offset;
+
+	/* easy case */
+	if (page->index < end_index)
+		return __block_write_full_page(inode, page, get_block);
+
+	/* things got complicated... */
+	offset = inode->i_size & (PAGE_CACHE_SIZE-1);
+	/* OK, are we completely out? */
+	if (page->index >= end_index+1 || !offset) {
 		UnlockPage(page);
-		return err;
+		return -EIO;
 	}
-	ClearPageUptodate(page);
-	goto done;
+
+	/* directories in the page cache don't need to have the buffers
+	** past the eof zerod out.  In fact, ext2 sets up fake entries
+	** past the eof in their algs.
+	*/
+	return __block_write_full_page(inode, page, get_block) ;
 }
 
 int generic_block_bmap(struct address_space *mapping, long block, get_block_t *get_block)
@@ -2250,7 +2398,7 @@
 	struct buffer_head *bh, *tmp;
 	struct buffer_head * insert_point;
 	int isize;
-
+	unsigned long index ;
 	if ((size & 511) || (size > PAGE_SIZE)) {
 		printk(KERN_ERR "VFS: grow_buffers: size = %d\n",size);
 		return 0;
@@ -2266,6 +2414,16 @@
 
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
@@ -2289,11 +2447,7 @@
 	free_list[isize].list = bh;
 	spin_unlock(&free_list[isize].lock);
 
-	page->buffers = bh;
-	page->flags &= ~(1 << PG_referenced);
-	lru_cache_add(page);
 	UnlockPage(page);
-	atomic_inc(&buffermem_pages);
 	return 1;
 
 no_buffer_head:
@@ -2315,10 +2469,9 @@
  *
  * Wait:
  *	0 - no wait (this does not get called - see try_to_free_buffers below)
- *	1 - start IO for dirty buffers
  *	2 - wait for completion of locked buffers
  */
-static void sync_page_buffers(struct buffer_head *bh, unsigned int gfp_mask)
+static void wait_page_buffers(struct buffer_head *bh, unsigned int gfp_mask)
 {
 	struct buffer_head * tmp = bh;
 
@@ -2326,10 +2479,8 @@
 		struct buffer_head *p = tmp;
 		tmp = tmp->b_this_page;
 		if (buffer_locked(p)) {
-			if (gfp_mask & __GFP_WAIT)
-				__wait_on_buffer(p);
-		} else if (buffer_dirty(p))
-			ll_rw_block(WRITE, 1, &p);
+			__wait_on_buffer(p);
+		} 
 	} while (tmp != bh);
 }
 
@@ -2390,6 +2541,9 @@
 
 	/* And free the page */
 	page->buffers = NULL;
+	if (page->mapping == &anon_space_mapping) {
+		atomic_dec(&buffermem_pages) ;
+	}
 	page_cache_release(page);
 	spin_unlock(&free_list[index].lock);
 	write_unlock(&hash_table_lock);
@@ -2401,14 +2555,13 @@
 	spin_unlock(&free_list[index].lock);
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
-	if (gfp_mask & __GFP_IO) {
-		sync_page_buffers(bh, gfp_mask);
+	if (gfp_mask & __GFP_WAIT) {
+		wait_page_buffers(bh, gfp_mask);
 		/* We waited synchronously, so we can free the buffers. */
-		if ((gfp_mask & __GFP_WAIT) && !loop) {
+		if (!loop) {
 			loop = 1;
 			goto cleaned_buffers_try_again;
 		}
-		wakeup_bdflush(0);
 	}
 	return 0;
 }
@@ -2541,6 +2694,7 @@
 static int flush_dirty_buffers(int check_flushtime)
 {
 	struct buffer_head * bh, *next;
+	struct page *page ;
 	int flushed = 0, i;
 
  restart:
@@ -2557,6 +2711,8 @@
 		}
 		if (buffer_locked(bh))
 			continue;
+		if (!buffer_uptodate(bh))
+			continue ;
 
 		if (check_flushtime) {
 			/* The dirty lru list is chronologically ordered so
@@ -2570,11 +2726,19 @@
 				goto out_unlock;
 		}
 
+		page = bh->b_page ;
+		if (TryLockPage(page)) {
+		    flushed-- ;
+		    continue ;
+		}
+
 		/* OK, now we are committed to write it out. */
+		page_cache_get(page) ;
 		get_bh(bh);
 		spin_unlock(&lru_list_lock);
-		ll_rw_block(WRITE, 1, &bh);
+		dirty_list_writepage(page, bh) ;
 		put_bh(bh);
+		page_cache_release(page) ;
 
 		if (current->need_resched)
 			schedule();
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Tue Jul 31 14:43:40 2001
+++ b/fs/ext2/inode.c	Tue Jul 31 14:43:40 2001
@@ -574,6 +574,10 @@
 {
 	return block_write_full_page(page,ext2_get_block);
 }
+static int ext2_dir_writepage(struct page *page)
+{
+	return block_write_dir_page(page,ext2_get_block);
+}
 static int ext2_readpage(struct file *file, struct page *page)
 {
 	return block_read_full_page(page,ext2_get_block);
@@ -595,6 +599,15 @@
 	bmap: ext2_bmap
 };
 
+struct address_space_operations ext2_dir_aops = {
+	readpage: ext2_readpage,
+	writepage: ext2_dir_writepage,
+	sync_page: block_sync_page,
+	prepare_write: ext2_prepare_write,
+	commit_write: generic_commit_write,
+	bmap: ext2_bmap
+};
+
 /*
  * Probably it should be a library function... search for first non-zero word
  * or memcmp with zero_page, whatever is better for particular architecture.
@@ -985,7 +998,7 @@
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &ext2_dir_inode_operations;
 		inode->i_fop = &ext2_dir_operations;
-		inode->i_mapping->a_ops = &ext2_aops;
+		inode->i_mapping->a_ops = &ext2_dir_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
 		if (!inode->i_blocks)
 			inode->i_op = &ext2_fast_symlink_inode_operations;
diff -Nru a/fs/ext2/namei.c b/fs/ext2/namei.c
--- a/fs/ext2/namei.c	Tue Jul 31 14:43:40 2001
+++ b/fs/ext2/namei.c	Tue Jul 31 14:43:40 2001
@@ -194,7 +194,7 @@
 
 	inode->i_op = &ext2_dir_inode_operations;
 	inode->i_fop = &ext2_dir_operations;
-	inode->i_mapping->a_ops = &ext2_aops;
+	inode->i_mapping->a_ops = &ext2_dir_aops;
 
 	ext2_inc_count(inode);
 
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Tue Jul 31 14:43:40 2001
+++ b/fs/reiserfs/inode.c	Tue Jul 31 14:43:40 2001
@@ -1694,13 +1694,19 @@
     int use_get_block = 0 ;
     int bytes_copied = 0 ;
     int copy_size ;
+    int transaction_started = 0 ;
 
 start_over:
     lock_kernel() ;
-    journal_begin(&th, inode->i_sb, jbegin_count) ;
 
     make_cpu_key(&key, inode, byte_offset, TYPE_ANY, 3) ;
 
+    /* we know we've got a direct item, start the transaction now */
+    if (buffer_mapped(bh_result) && bh_result->b_blocknr == 0) {
+	journal_begin(&th, inode->i_sb, jbegin_count) ;
+	transaction_started = 1 ;
+    }
+
 research:
     retval = search_for_position_by_key(inode->i_sb, &key, &path) ;
     if (retval != POSITION_FOUND) {
@@ -1727,6 +1733,17 @@
 	mark_buffer_uptodate(bh_result, 1);
     } else if (is_direct_le_ih(ih)) {
         char *p ; 
+
+	/* sigh, we can't start a transaction with a path held, so we
+	** have to drop the path, start the transaction, and start over
+	*/
+	if (!transaction_started) {
+	    pathrelse(&path) ;
+	    journal_begin(&th, inode->i_sb, jbegin_count) ;
+	    transaction_started = 1 ;
+	    goto research ;
+	}
+
         p = page_address(bh_result->b_page) ;
         p += (byte_offset -1) & (PAGE_CACHE_SIZE - 1) ;
         copy_size = le16_to_cpu(ih->ih_item_len) - pos_in_item ;
@@ -1761,7 +1778,8 @@
     
 out:
     pathrelse(&path) ;
-    journal_end(&th, inode->i_sb, jbegin_count) ;
+    if (transaction_started)
+	journal_end(&th, inode->i_sb, jbegin_count) ;
     unlock_kernel() ;
 
     /* this is where we fill in holes in the file. */
@@ -1813,6 +1831,7 @@
     int partial = 0 ;
     struct buffer_head *arr[PAGE_CACHE_SIZE/512] ;
     int nr = 0 ;
+    int page_ok = Page_Uptodate(page) ;
 
     if (!page->buffers) {
         block_prepare_write(page, 0, 0, NULL) ;
@@ -1837,7 +1856,7 @@
     block = page->index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits) ;
     do {
 	/* if this offset in the page is outside the file */
-	if (cur_offset >= last_offset) {
+	if (!(buffer_dirty(bh) || page_ok) || cur_offset >= last_offset) {
 	    if (!buffer_uptodate(bh))
 	        partial = 1 ;
 	} else {
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Tue Jul 31 14:43:40 2001
+++ b/fs/reiserfs/journal.c	Tue Jul 31 14:43:40 2001
@@ -702,10 +702,12 @@
       } 
       if (buffer_dirty(tbh)) {
 	printk("journal-569: flush_commit_list, block already dirty!\n") ;
-      } else {				
-	mark_buffer_dirty(tbh) ;
-      }
-      ll_rw_block(WRITE, 1, &tbh) ;
+      } 
+      get_bh(tbh) ; /* inc the count for the end_io handler */
+      lock_buffer(tbh) ;
+      clear_bit(BH_Dirty, &tbh->b_state) ;
+      tbh->b_end_io = end_buffer_io_sync ;
+      submit_bh(WRITE, tbh) ;
       count++ ;
       put_bh(tbh) ; /* once for our get_hash */
     } 
@@ -738,8 +740,11 @@
                        atomic_read(&(jl->j_commit_left)));
   }
 
-  mark_buffer_dirty(jl->j_commit_bh) ;
-  ll_rw_block(WRITE, 1, &(jl->j_commit_bh)) ;
+  get_bh(jl->j_commit_bh) ;
+  lock_buffer(jl->j_commit_bh) ;
+  clear_bit(BH_Dirty, &(jl->j_commit_bh->b_state)) ;
+  jl->j_commit_bh->b_end_io = end_buffer_io_sync ;
+  submit_bh(WRITE, jl->j_commit_bh) ;
   wait_on_buffer(jl->j_commit_bh) ;
   if (!buffer_uptodate(jl->j_commit_bh)) {
     reiserfs_panic(s, "journal-615: buffer write failed\n") ;
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Tue Jul 31 14:43:40 2001
+++ b/fs/reiserfs/tail_conversion.c	Tue Jul 31 14:43:40 2001
@@ -184,6 +184,12 @@
         cur_index += bh->b_size ;
         if (cur_index > tail_index) {
           reiserfs_unmap_buffer(bh) ;
+	  /* if we are the first buffer on the page, we know the
+	  ** page is clean 
+	  */
+	  if (bh == page->buffers) {
+	    ClearPageDirty(page) ;
+	  }
         }
 	bh = next ;
       } while (bh != head) ;
diff -Nru a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
--- a/include/linux/ext2_fs.h	Tue Jul 31 14:43:40 2001
+++ b/include/linux/ext2_fs.h	Tue Jul 31 14:43:40 2001
@@ -640,6 +640,7 @@
 extern struct inode_operations ext2_fast_symlink_inode_operations;
 
 extern struct address_space_operations ext2_aops;
+extern struct address_space_operations ext2_dir_aops;
 
 #endif	/* __KERNEL__ */
 
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Tue Jul 31 14:43:40 2001
+++ b/include/linux/fs.h	Tue Jul 31 14:43:40 2001
@@ -1326,6 +1326,8 @@
 extern int block_flushpage(struct page *, unsigned long);
 extern int block_symlink(struct inode *, const char *, int);
 extern int block_write_full_page(struct page*, get_block_t*);
+extern int block_write_dir_page(struct page*, get_block_t*);
+extern int block_write_anon_page(struct page*) ;
 extern int block_read_full_page(struct page*, get_block_t*);
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Jul 31 14:43:40 2001
+++ b/kernel/ksyms.c	Tue Jul 31 14:43:40 2001
@@ -197,6 +197,7 @@
 EXPORT_SYMBOL(__wait_on_buffer);
 EXPORT_SYMBOL(___wait_on_page);
 EXPORT_SYMBOL(block_write_full_page);
+EXPORT_SYMBOL(block_write_dir_page);
 EXPORT_SYMBOL(block_read_full_page);
 EXPORT_SYMBOL(block_prepare_write);
 EXPORT_SYMBOL(block_sync_page);
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Tue Jul 31 14:43:40 2001
+++ b/mm/vmscan.c	Tue Jul 31 14:43:40 2001
@@ -548,7 +548,6 @@
 
 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
-				atomic_dec(&buffermem_pages);
 				freed_page = 1;
 				cleaned_pages++;
 
@@ -571,10 +570,9 @@
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
@@ -609,9 +607,6 @@
 	 * free anything yet, we wait synchronously on the writeout of
 	 * MAX_SYNC_LAUNDER pages.
 	 *
-	 * We also wake up bdflush, since bdflush should, under most
-	 * loads, flush out the dirty pages before we have to wait on
-	 * IO.
 	 */
 	if (CAN_DO_IO && !launder_loop && free_shortage()) {
 		launder_loop = 1;

