Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264026AbUFCBCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUFCBCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 21:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265011AbUFCBCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 21:02:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:43652 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264026AbUFCBBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 21:01:13 -0400
Date: Wed, 2 Jun 2004 18:00:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: jeffm@suse.com, linux-kernel@vger.kernel.org
Subject: Re: ext3_orphan_del may double-decrement bh->b_count
Message-Id: <20040602180032.6c96268c.akpm@osdl.org>
In-Reply-To: <1086219035.22636.3524.camel@watt.suse.com>
References: <40BE3235.5060906@suse.com>
	<20040602150614.005e939f.akpm@osdl.org>
	<1086219035.22636.3524.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> On Wed, 2004-06-02 at 18:06, Andrew Morton wrote:
> > Jeff Mahoney <jeffm@suse.com> wrote:
> > >
> > > Chris Mason and I ran across this one while hunting down another bug.
> > 
> 
> > What was the "other bug"?
> 
> We've got many names for it, but none that could be posted here ;-)

intrigued.

> Looks like HP came up with a simplified test case:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=4536665&forum_id=6379

hm, I never received that.  If I'd known I wouldn't have removed the
buffer_error() stuff.

> I've got machines trying to reproduce now.

You need the buffer-tracing patch.  This is against 2.6.7-rc2.  It should
spit a nice trace when you hit the problem.  It'll tell us how that buffer
got itself not uptodate.

 25-akpm/drivers/ide/ide-io.c         |   22 +++
 25-akpm/fs/Kconfig                   |    4 
 25-akpm/fs/Makefile                  |    2 
 25-akpm/fs/buffer.c                  |   76 +++++++++-
 25-akpm/fs/ext3/inode.c              |    7 
 25-akpm/fs/ext3/namei.c              |   40 +++++
 25-akpm/fs/ext3/super.c              |   81 +++++++++++
 25-akpm/fs/jbd-kernel.c              |  255 +++++++++++++++++++++++++++++++++++
 25-akpm/fs/jbd/commit.c              |    9 -
 25-akpm/fs/jbd/transaction.c         |   15 +-
 25-akpm/fs/mpage.c                   |    2 
 25-akpm/include/linux/buffer-trace.h |   85 +++++++++++
 25-akpm/include/linux/buffer_head.h  |    5 
 25-akpm/include/linux/jbd.h          |   12 -
 14 files changed, 597 insertions(+), 18 deletions(-)

diff -puN drivers/ide/ide-io.c~ext3-debug drivers/ide/ide-io.c
--- 25/drivers/ide/ide-io.c~ext3-debug	2004-06-02 17:50:41.051854496 -0700
+++ 25-akpm/drivers/ide/ide-io.c	2004-06-02 17:50:41.074851000 -0700
@@ -591,6 +591,28 @@ ide_startstop_t start_request (ide_drive
 	ide_startstop_t startstop;
 	sector_t block;
 
+#ifdef CONFIG_JBD_DEBUG
+	/*
+	 * Silently stop writing to this disk to simulate a crash.
+	 */
+	extern struct block_device *journal_no_write[2];
+	int i;
+
+	if (!(rq->flags & REQ_RW))
+		goto its_a_read;
+
+	for (i = 0; i < 2; i++) {
+		struct block_device *bdev = journal_no_write[i];
+		if (bdev && bdev_get_queue(bdev) == rq->q) {
+			printk("%s: write suppressed\n", __FUNCTION__);
+			ide_end_request(drive, 1, rq->nr_sectors);
+			return ide_stopped;
+		}
+	}
+its_a_read:
+	;
+#endif
+
 	BUG_ON(!(rq->flags & REQ_STARTED));
 
 #ifdef DEBUG
diff -puN fs/buffer.c~ext3-debug fs/buffer.c
--- 25/fs/buffer.c~ext3-debug	2004-06-02 17:50:41.053854192 -0700
+++ 25-akpm/fs/buffer.c	2004-06-02 17:51:44.136264208 -0700
@@ -34,7 +34,9 @@
 #include <linux/hash.h>
 #include <linux/suspend.h>
 #include <linux/buffer_head.h>
+#include <linux/buffer-trace.h>
 #include <linux/bio.h>
+#include <linux/jbd.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <asm/bitops.h>
@@ -76,6 +78,7 @@ init_buffer(struct buffer_head *bh, bh_e
 {
 	bh->b_end_io = handler;
 	bh->b_private = private;
+	buffer_trace_init(&bh->b_history);
 }
 
 /*
@@ -196,10 +199,12 @@ static void buffer_io_error(struct buffe
  */
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
+	BUFFER_TRACE(bh, "enter");
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
 		/* This happens, due to failed READA attempts. */
+		BUFFER_TRACE(bh, "clear uptodate");
 		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
@@ -220,6 +225,7 @@ void end_buffer_write_sync(struct buffer
 				       bdevname(bh->b_bdev, b));
 		}
 		set_buffer_write_io_error(bh);
+		BUFFER_TRACE(bh, "clear uptodate");
 		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
@@ -610,12 +616,15 @@ static void end_buffer_async_read(struct
 	struct page *page;
 	int page_uptodate = 1;
 
+	BUFFER_TRACE(bh, "enter");
+
 	BUG_ON(!buffer_async_read(bh));
 
 	page = bh->b_page;
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
+		BUFFER_TRACE(bh, "clear uptodate");
 		clear_buffer_uptodate(bh);
 		buffer_io_error(bh);
 		SetPageError(page);
@@ -667,6 +676,8 @@ void end_buffer_async_write(struct buffe
 	struct buffer_head *tmp;
 	struct page *page;
 
+	BUFFER_TRACE(bh, "enter");
+
 	BUG_ON(!buffer_async_write(bh));
 
 	page = bh->b_page;
@@ -680,6 +691,7 @@ void end_buffer_async_write(struct buffe
 			       bdevname(bh->b_bdev, b));
 		}
 		set_bit(AS_EIO, &page->mapping->flags);
+		BUFFER_TRACE(bh, "clear uptodate");
 		clear_buffer_uptodate(bh);
 		SetPageError(page);
 	}
@@ -792,6 +804,7 @@ EXPORT_SYMBOL(mark_buffer_async_write);
 void buffer_insert_list(spinlock_t *lock,
 		struct buffer_head *bh, struct list_head *list)
 {
+	BUFFER_TRACE(bh, "enter");
 	spin_lock(lock);
 	list_move_tail(&bh->b_assoc_buffers, list);
 	spin_unlock(lock);
@@ -892,6 +905,7 @@ void mark_buffer_dirty_inode(struct buff
 	struct address_space *mapping = inode->i_mapping;
 	struct address_space *buffer_mapping = bh->b_page->mapping;
 
+	BUFFER_TRACE(bh, "mark dirty");
 	mark_buffer_dirty(bh);
 	if (!mapping->assoc_mapping) {
 		mapping->assoc_mapping = buffer_mapping;
@@ -940,7 +954,20 @@ int __set_page_dirty_buffers(struct page
 		struct buffer_head *bh = head;
 
 		do {
-			set_buffer_dirty(bh);
+			if (buffer_uptodate(bh)) {
+				BUFFER_TRACE(bh, "set dirty");
+				if (buffer_jbd(bh)) {
+					struct journal_head *jh;
+
+					jh = journal_add_journal_head(bh);
+					WARN_ON(jh->b_jlist == BJ_Metadata);
+					journal_put_journal_head(jh);
+				}
+				set_buffer_dirty(bh);
+			} else {
+				printk("%s: !uptodate buffer\n", __FUNCTION__);
+				buffer_assertion_failure(bh);
+			}
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
@@ -1344,6 +1371,7 @@ __getblk_slow(struct block_device *bdev,
  */
 void fastcall mark_buffer_dirty(struct buffer_head *bh)
 {
+	BUFFER_TRACE(bh, "entry");
 	if (!buffer_dirty(bh) && !test_set_buffer_dirty(bh))
 		__set_page_dirty_nobuffers(bh->b_page);
 }
@@ -1357,12 +1385,14 @@ void fastcall mark_buffer_dirty(struct b
  */
 void __brelse(struct buffer_head * buf)
 {
+	BUFFER_TRACE(buf, "entry");
 	if (atomic_read(&buf->b_count)) {
 		put_bh(buf);
 		return;
 	}
 	printk(KERN_ERR "VFS: brelse: Trying to free free buffer\n");
 	WARN_ON(1);
+	buffer_assertion_failure(buf);
 }
 
 /*
@@ -1371,6 +1401,7 @@ void __brelse(struct buffer_head * buf)
  */
 void __bforget(struct buffer_head *bh)
 {
+	BUFFER_TRACE(bh, "enter");
 	clear_buffer_dirty(bh);
 	if (!list_empty(&bh->b_assoc_buffers)) {
 		struct address_space *buffer_mapping = bh->b_page->mapping;
@@ -1631,6 +1662,7 @@ EXPORT_SYMBOL(set_bh_page);
  */
 static inline void discard_buffer(struct buffer_head * bh)
 {
+	BUFFER_TRACE(bh, "enter");
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
 	bh->b_bdev = NULL;
@@ -1779,6 +1811,7 @@ void unmap_underlying_metadata(struct bl
 
 	old_bh = __find_get_block_slow(bdev, block, 0);
 	if (old_bh) {
+		BUFFER_TRACE(old_bh, "alias: unmap it");
 		clear_buffer_dirty(old_bh);
 		wait_on_buffer(old_bh);
 		clear_buffer_req(old_bh);
@@ -1858,6 +1891,7 @@ static int __block_write_full_page(struc
 			/*
 			 * The buffer was zeroed by block_write_full_page()
 			 */
+			BUFFER_TRACE(bh, "outside last_block");
 			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
@@ -1865,6 +1899,8 @@ static int __block_write_full_page(struc
 			if (err)
 				goto recover;
 			if (buffer_new(bh)) {
+				BUFFER_TRACE(bh, "new: call "
+						"unmap_underlying_metadata");
 				/* blockdev mappings never come here */
 				clear_buffer_new(bh);
 				unmap_underlying_metadata(bh->b_bdev,
@@ -1893,6 +1929,11 @@ static int __block_write_full_page(struc
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
+			if (!buffer_uptodate(bh)) {
+				printk("%s: dirty non-uptodate buffer\n",
+						__FUNCTION__);
+				buffer_assertion_failure(bh);
+			}
 			mark_buffer_async_write(bh);
 		} else {
 			unlock_buffer(bh);
@@ -1952,6 +1993,7 @@ recover:
 	do {
 		get_bh(bh);
 		if (buffer_mapped(bh) && buffer_dirty(bh)) {
+			BUFFER_TRACE(bh, "lock it");
 			lock_buffer(bh);
 			mark_buffer_async_write(bh);
 		} else {
@@ -2019,9 +2061,12 @@ static int __block_prepare_write(struct 
 				goto out;
 			if (buffer_new(bh)) {
 				clear_buffer_new(bh);
+				BUFFER_TRACE(bh, "new: call "
+						"unmap_underlying_metadata");
 				unmap_underlying_metadata(bh->b_bdev,
 							bh->b_blocknr);
 				if (PageUptodate(page)) {
+					BUFFER_TRACE(bh, "setting uptodate");
 					set_buffer_uptodate(bh);
 					continue;
 				}
@@ -2042,12 +2087,14 @@ static int __block_prepare_write(struct 
 			}
 		}
 		if (PageUptodate(page)) {
+			BUFFER_TRACE(bh, "setting uptodate");
 			if (!buffer_uptodate(bh))
 				set_buffer_uptodate(bh);
 			continue; 
 		}
 		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
 		     (block_start < from || block_end > to)) {
+			BUFFER_TRACE(bh, "reading");
 			ll_rw_block(READ, 1, &bh);
 			*wait_bh++=bh;
 		}
@@ -2083,6 +2130,7 @@ out:
 			memset(kaddr+block_start, 0, bh->b_size);
 			kunmap_atomic(kaddr, KM_USER0);
 			set_buffer_uptodate(bh);
+			BUFFER_TRACE(bh, "mark dirty");
 			mark_buffer_dirty(bh);
 		}
 next_bh:
@@ -2111,6 +2159,7 @@ static int __block_commit_write(struct i
 				partial = 1;
 		} else {
 			set_buffer_uptodate(bh);
+			BUFFER_TRACE(bh, "mark dirty");
 			mark_buffer_dirty(bh);
 		}
 	}
@@ -2403,6 +2452,7 @@ static void end_buffer_read_nobh(struct 
 		set_buffer_uptodate(bh);
 	} else {
 		/* This happens, due to failed READA attempts. */
+		BUFFER_TRACE(bh, "clear uptodate");
 		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
@@ -2682,6 +2732,7 @@ int block_truncate_page(struct address_s
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);
 
+	BUFFER_TRACE(bh, "mark dirty");
 	mark_buffer_dirty(bh);
 	err = 0;
 
@@ -2716,11 +2767,20 @@ int block_write_full_page(struct page *p
 		 * they may have been added in ext3_writepage().  Make them
 		 * freeable here, so the page does not leak.
 		 */
+		if (page_has_buffers(page)) {
+			struct buffer_head *b = page_buffers(page);
+			BUFFER_TRACE(b, "EIO");
+		}
 		block_invalidatepage(page, 0);
 		unlock_page(page);
 		return 0; /* don't care */
 	}
 
+	if (page_has_buffers(page)) {
+		struct buffer_head *b = page_buffers(page);
+		BUFFER_TRACE(b, "partial");
+	}
+
 	/*
 	 * The page straddles i_size.  It must be zeroed out on each and every
 	 * writepage invocation because it may be mmapped.  "A file is mapped
@@ -2740,8 +2800,10 @@ sector_t generic_block_bmap(struct addre
 {
 	struct buffer_head tmp;
 	struct inode *inode = mapping->host;
+
 	tmp.b_state = 0;
 	tmp.b_blocknr = 0;
+	tmp.b_page = NULL;
 	get_block(inode, block, &tmp, 0);
 	return tmp.b_blocknr;
 }
@@ -2762,14 +2824,19 @@ void submit_bh(int rw, struct buffer_hea
 {
 	struct bio *bio;
 
-	BUG_ON(!buffer_locked(bh));
-	BUG_ON(!buffer_mapped(bh));
-	BUG_ON(!bh->b_end_io);
+	J_ASSERT_BH(bh, buffer_locked(bh));
+	J_ASSERT_BH(bh, buffer_mapped(bh));
+	J_ASSERT_BH(bh, bh->b_end_io != NULL);
 
 	/* Only clear out a write error when rewriting */
 	if (test_set_buffer_req(bh) && rw == WRITE)
 		clear_buffer_write_io_error(bh);
 
+	if (rw == WRITE)
+		BUFFER_TRACE(bh, "write");
+	else
+		BUFFER_TRACE(bh, "read");
+
 	/*
 	 * from here on down, it's all bio -- do the initial mapping,
 	 * submit_bio -> generic_make_request may further map this bio around
@@ -3044,6 +3111,7 @@ struct buffer_head *alloc_buffer_head(in
 		__get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
 		preempt_enable();
+		buffer_trace_init(&ret->b_history);
 	}
 	return ret;
 }
diff -puN fs/ext3/inode.c~ext3-debug fs/ext3/inode.c
--- 25/fs/ext3/inode.c~ext3-debug	2004-06-02 17:50:41.057853584 -0700
+++ 25-akpm/fs/ext3/inode.c	2004-06-02 17:50:41.081849936 -0700
@@ -914,6 +914,7 @@ struct buffer_head *ext3_getblk(handle_t
 
 	dummy.b_state = 0;
 	dummy.b_blocknr = -1000;
+	dummy.b_page = NULL;
 	buffer_trace_init(&dummy.b_history);
 	*errp = ext3_get_block_handle(handle, inode, block, &dummy, create, 1);
 	if (!*errp && buffer_mapped(&dummy)) {
@@ -1377,6 +1378,11 @@ static int ext3_ordered_writepage(struct
 	walk_page_buffers(handle, page_bufs, 0,
 			PAGE_CACHE_SIZE, NULL, bget_one);
 
+	{
+		struct buffer_head *b = page_buffers(page);
+		BUFFER_TRACE(b, "call block_write_full_page");
+	}
+
 	ret = block_write_full_page(page, ext3_get_block, wbc);
 
 	/*
@@ -1744,6 +1750,7 @@ static int ext3_block_truncate_page(hand
 	} else {
 		if (ext3_should_order_data(inode))
 			err = ext3_journal_dirty_data(handle, bh);
+		BUFFER_TRACE(bh, "mark dirty");
 		mark_buffer_dirty(bh);
 	}
 
diff -puN fs/ext3/namei.c~ext3-debug fs/ext3/namei.c
--- 25/fs/ext3/namei.c~ext3-debug	2004-06-02 17:50:41.058853432 -0700
+++ 25-akpm/fs/ext3/namei.c	2004-06-02 17:50:41.083849632 -0700
@@ -60,6 +60,7 @@ static struct buffer_head *ext3_append(h
 		EXT3_I(inode)->i_disksize = inode->i_size;
 		ext3_journal_get_write_access(handle,bh);
 	}
+	BUFFER_TRACE(bh, "exit");
 	return bh;
 }
 
@@ -343,6 +344,7 @@ dx_probe(struct dentry *dentry, struct i
 		dir = dentry->d_parent->d_inode;
 	if (!(bh = ext3_bread (NULL,dir, 0, 0, err)))
 		goto fail;
+	BUFFER_TRACE(bh, "bread it");
 	root = (struct dx_root *) bh->b_data;
 	if (root->info.hash_version != DX_HASH_TEA &&
 	    root->info.hash_version != DX_HASH_HALF_MD4 &&
@@ -417,18 +419,21 @@ dx_probe(struct dentry *dentry, struct i
 
 		at = p - 1;
 		dxtrace(printk(" %x->%u\n", at == entries? 0: dx_get_hash(at), dx_get_block(at)));
+		BUFFER_TRACE(bh, "add to frame");
 		frame->bh = bh;
 		frame->entries = entries;
 		frame->at = at;
 		if (!indirect--) return frame;
 		if (!(bh = ext3_bread (NULL,dir, dx_get_block(at), 0, err)))
 			goto fail2;
+		BUFFER_TRACE(bh, "read it");
 		at = entries = ((struct dx_node *) bh->b_data)->entries;
 		assert (dx_get_limit(entries) == dx_node_limit (dir));
 		frame++;
 	}
 fail2:
 	while (frame >= frame_in) {
+		BUFFER_TRACE(bh, "brelse it");
 		brelse(frame->bh);
 		frame--;
 	}
@@ -441,8 +446,11 @@ static void dx_release (struct dx_frame 
 	if (frames[0].bh == NULL)
 		return;
 
-	if (((struct dx_root *) frames[0].bh->b_data)->info.indirect_levels)
+	if (((struct dx_root *) frames[0].bh->b_data)->info.indirect_levels) {
+		BUFFER_TRACE(frames[1].bh, "brelse it");
 		brelse(frames[1].bh);
+	}
+	BUFFER_TRACE(frames[0].bh, "brelse it");
 	brelse(frames[0].bh);
 }
 
@@ -951,6 +959,8 @@ static struct buffer_head * ext3_dx_find
 			dx_release (frames);
 			return bh;
 		}
+		BUFFER_TRACE(bh, "brelse it");
+		BUFFER_TRACE(bh, "brelse it");
 		brelse (bh);
 		/* Check to see if we should continue to search */
 		retval = ext3_htree_next_block(dir, hash, frame,
@@ -985,6 +995,7 @@ static struct dentry *ext3_lookup(struct
 	inode = NULL;
 	if (bh) {
 		unsigned long ino = le32_to_cpu(de->inode);
+		BUFFER_TRACE(bh, "brelse it");
 		brelse (bh);
 		inode = iget(dir->i_sb, ino);
 
@@ -1106,16 +1117,20 @@ static struct ext3_dir_entry_2 *do_split
 
 	bh2 = ext3_append (handle, dir, &newblock, error);
 	if (!(bh2)) {
+		BUFFER_TRACE(*bh, "brelse it");
 		brelse(*bh);
 		*bh = NULL;
 		goto errout;
 	}
 
+	BUFFER_TRACE(bh2, "using it");
 	BUFFER_TRACE(*bh, "get_write_access");
 	err = ext3_journal_get_write_access(handle, *bh);
 	if (err) {
 	journal_error:
+		BUFFER_TRACE(*bh, "brelse");
 		brelse(*bh);
+		BUFFER_TRACE(bh2, "brelse");
 		brelse(bh2);
 		*bh = NULL;
 		ext3_std_error(dir->i_sb, err);
@@ -1151,6 +1166,8 @@ static struct ext3_dir_entry_2 *do_split
 	/* Which block gets the new entry? */
 	if (hinfo->hash >= hash2)
 	{
+		BUFFER_TRACE(*bh, "swapping");
+		BUFFER_TRACE(bh2, "swapping");
 		swap(*bh, bh2);
 		de = de2;
 	}
@@ -1159,8 +1176,11 @@ static struct ext3_dir_entry_2 *do_split
 	if (err)
 		goto journal_error;
 	err = ext3_journal_dirty_metadata (handle, frame->bh);
-	if (err)
+	if (err) {
+		BUFFER_TRACE(bh2, "error");
 		goto journal_error;
+	}
+	BUFFER_TRACE(*bh, "brelse");
 	brelse (bh2);
 	dxtrace(dx_show_index ("frame", frame->entries));
 errout:
@@ -1203,6 +1223,7 @@ static int add_dirent_to_buf(handle_t *h
 				return -EIO;
 			}
 			if (ext3_match (namelen, name, de)) {
+				BUFFER_TRACE(bh, "brelse");
 				brelse (bh);
 				return -EEXIST;
 			}
@@ -1260,6 +1281,7 @@ static int add_dirent_to_buf(handle_t *h
 	err = ext3_journal_dirty_metadata(handle, bh);
 	if (err)
 		ext3_std_error(dir->i_sb, err);
+	BUFFER_TRACE(bh, "brelse");
 	brelse(bh);
 	return 0;
 }
@@ -1290,6 +1312,7 @@ static int make_indexed_dir(handle_t *ha
 
 	blocksize =  dir->i_sb->s_blocksize;
 	dxtrace(printk("Creating index\n"));
+	BUFFER_TRACE(bh, "get write access");
 	retval = ext3_journal_get_write_access(handle, bh);
 	if (retval) {
 		ext3_std_error(dir->i_sb, retval);
@@ -1334,6 +1357,7 @@ static int make_indexed_dir(handle_t *ha
 	frame = frames;
 	frame->entries = entries;
 	frame->at = entries;
+	BUFFER_TRACE(bh, "adding to frame");
 	frame->bh = bh;
 	bh = bh2;
 	de = do_split(handle,dir, &bh, frame, &hinfo, &retval);
@@ -1390,6 +1414,7 @@ static int ext3_add_entry (handle_t *han
 		bh = ext3_bread(handle, dir, block, 0, &retval);
 		if(!bh)
 			return retval;
+		BUFFER_TRACE(bh, "read it");
 		retval = add_dirent_to_buf(handle, dentry, inode, 0, bh);
 		if (retval != -ENOSPC)
 			return retval;
@@ -1404,6 +1429,7 @@ static int ext3_add_entry (handle_t *han
 	bh = ext3_append(handle, dir, &block, &retval);
 	if (!bh)
 		return retval;
+	BUFFER_TRACE(bh, "append returned it");
 	de = (struct ext3_dir_entry_2 *) bh->b_data;
 	de->inode = 0;
 	de->rec_len = cpu_to_le16(rlen = blocksize);
@@ -1469,6 +1495,7 @@ static int ext3_dx_add_entry(handle_t *h
 		bh2 = ext3_append (handle, dir, &newblock, &err);
 		if (!(bh2))
 			goto cleanup;
+		BUFFER_TRACE(bh2, "append returned it");
 		node2 = (struct dx_node *)(bh2->b_data);
 		entries2 = node2->entries;
 		node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
@@ -1498,6 +1525,8 @@ static int ext3_dx_add_entry(handle_t *h
 			if (at - entries >= icount1) {
 				frame->at = at = at - entries - icount1 + entries2;
 				frame->entries = entries = entries2;
+				BUFFER_TRACE(frame->bh, "swap");
+				BUFFER_TRACE(bh2, "swap");
 				swap(frame->bh, bh2);
 			}
 			dx_insert_block (frames + 0, hash2, newblock);
@@ -1507,6 +1536,7 @@ static int ext3_dx_add_entry(handle_t *h
 			err = ext3_journal_dirty_metadata(handle, bh2);
 			if (err)
 				goto journal_error;
+			BUFFER_TRACE(bh2, "brelse");
 			brelse (bh2);
 		} else {
 			dxtrace(printk("Creating second level index...\n"));
@@ -1523,6 +1553,8 @@ static int ext3_dx_add_entry(handle_t *h
 			frame = frames + 1;
 			frame->at = at = at - entries + entries2;
 			frame->entries = entries = entries2;
+			BUFFER_TRACE(frame->bh, "overwrite");
+			BUFFER_TRACE(bh2, "add to frame");
 			frame->bh = bh2;
 			err = ext3_journal_get_write_access(handle,
 							     frame->bh);
@@ -1541,8 +1573,10 @@ static int ext3_dx_add_entry(handle_t *h
 journal_error:
 	ext3_std_error(dir->i_sb, err);
 cleanup:
-	if (bh)
+	if (bh) {
+		BUFFER_TRACE(bh, "brelse");
 		brelse(bh);
+	}
 	dx_release(frames);
 	return err;
 }
diff -puN fs/ext3/super.c~ext3-debug fs/ext3/super.c
--- 25/fs/ext3/super.c~ext3-debug	2004-06-02 17:50:41.060853128 -0700
+++ 25-akpm/fs/ext3/super.c	2004-06-02 17:50:41.086849176 -0700
@@ -39,6 +39,10 @@
 #include "xattr.h"
 #include "acl.h"
 
+#ifdef CONFIG_JBD_DEBUG
+static int ext3_ro_after; /* Make fs read-only after this many jiffies */
+#endif
+
 static int ext3_load_journal(struct super_block *, struct ext3_super_block *);
 static int ext3_create_journal(struct super_block *, struct ext3_super_block *,
 			       int);
@@ -51,6 +55,65 @@ static void ext3_clear_journal_err(struc
 				   struct ext3_super_block * es);
 static int ext3_sync_fs(struct super_block *sb, int wait);
 
+#ifdef CONFIG_JBD_DEBUG
+struct block_device *journal_no_write[2];
+
+/*
+ * Debug code for turning filesystems "read-only" after a specified
+ * amount of time.  This is for crash/recovery testing.
+ */
+
+static void make_rdonly(struct block_device *bdev,
+			struct block_device **no_write)
+{
+	char b[BDEVNAME_SIZE];
+
+	if (bdev) {
+		printk(KERN_WARNING "Turning device %s read-only\n",
+		       bdevname(bdev, b));
+		*no_write = bdev;
+	}
+}
+
+static void turn_fs_readonly(unsigned long arg)
+{
+	struct super_block *sb = (struct super_block *)arg;
+
+	make_rdonly(sb->s_bdev, &journal_no_write[0]);
+	make_rdonly(EXT3_SB(sb)->s_journal->j_dev, &journal_no_write[1]);
+	wake_up(&EXT3_SB(sb)->ro_wait_queue);
+}
+
+static void setup_ro_after(struct super_block *sb)
+{
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
+	init_timer(&sbi->turn_ro_timer);
+	if (ext3_ro_after) {
+		printk(KERN_DEBUG "fs will go read-only in %d jiffies\n",
+		       ext3_ro_after);
+		init_waitqueue_head(&sbi->ro_wait_queue);
+		journal_no_write[0] = NULL;
+		journal_no_write[1] = NULL;
+		sbi->turn_ro_timer.function = turn_fs_readonly;
+		sbi->turn_ro_timer.data = (unsigned long)sb;
+		sbi->turn_ro_timer.expires = jiffies + ext3_ro_after;
+		ext3_ro_after = 0;
+		add_timer(&sbi->turn_ro_timer);
+	}
+}
+
+static void clear_ro_after(struct super_block *sb)
+{
+	del_timer_sync(&EXT3_SB(sb)->turn_ro_timer);
+	journal_no_write[0] = NULL;
+	journal_no_write[1] = NULL;
+	ext3_ro_after = 0;
+}
+#else
+#define setup_ro_after(sb)	do {} while (0)
+#define clear_ro_after(sb)	do {} while (0)
+#endif
+
 /* 
  * Wrappers for journal_start/end.
  *
@@ -431,6 +494,7 @@ void ext3_put_super (struct super_block 
 		invalidate_bdev(sbi->journal_bdev, 0);
 		ext3_blkdev_remove(sbi);
 	}
+	clear_ro_after(sb);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return;
@@ -582,6 +646,7 @@ enum {
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
 	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
+	Opt_ro_after,
 	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl, Opt_noload,
 	Opt_commit, Opt_journal_update, Opt_journal_inum,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
@@ -610,6 +675,7 @@ static match_table_t tokens = {
 	{Opt_debug, "debug"},
 	{Opt_oldalloc, "oldalloc"},
 	{Opt_orlov, "orlov"},
+	{Opt_ro_after, "ro_after"},
 	{Opt_user_xattr, "user_xattr"},
 	{Opt_nouser_xattr, "nouser_xattr"},
 	{Opt_acl, "acl"},
@@ -741,6 +807,13 @@ static int parse_options (char * options
 		case Opt_orlov:
 			clear_opt (sbi->s_mount_opt, OLDALLOC);
 			break;
+#ifdef CONFIG_JBD_DEBUG
+		case Opt_ro_after:
+			if (match_int(&args[0], &option))
+				return 0;
+			ext3_ro_after = option;
+			break;
+#endif
 #ifdef CONFIG_EXT3_FS_XATTR
 		case Opt_user_xattr:
 			set_opt (sbi->s_mount_opt, XATTR_USER);
@@ -990,6 +1063,7 @@ static int ext3_setup_super(struct super
 		ext3_check_inodes_bitmap (sb);
 	}
 #endif
+	setup_ro_after(sb);
 	return res;
 }
 
@@ -1216,6 +1290,9 @@ static int ext3_fill_super (struct super
 	int i;
 	int needs_recovery;
 
+#ifdef CONFIG_JBD_DEBUG
+	ext3_ro_after = 0;
+#endif
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
@@ -1224,6 +1301,7 @@ static int ext3_fill_super (struct super
 	sbi->s_mount_opt = 0;
 	sbi->s_resuid = EXT3_DEF_RESUID;
 	sbi->s_resgid = EXT3_DEF_RESGID;
+	setup_ro_after(sb);
 
 	blocksize = sb_min_blocksize(sb, EXT3_MIN_BLOCK_SIZE);
 	if (!blocksize) {
@@ -2009,6 +2087,8 @@ int ext3_remount (struct super_block * s
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	unsigned long tmp;
 
+	clear_ro_after(sb);
+
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
@@ -2068,6 +2148,7 @@ int ext3_remount (struct super_block * s
 				sb->s_flags &= ~MS_RDONLY;
 		}
 	}
+	setup_ro_after(sb);
 	return 0;
 }
 
diff -puN fs/jbd/commit.c~ext3-debug fs/jbd/commit.c
--- 25/fs/jbd/commit.c~ext3-debug	2004-06-02 17:50:41.061852976 -0700
+++ 25-akpm/fs/jbd/commit.c	2004-06-02 17:52:02.789428496 -0700
@@ -28,10 +28,12 @@
 static void journal_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 {
 	BUFFER_TRACE(bh, "");
-	if (uptodate)
+	if (uptodate) {
 		set_buffer_uptodate(bh);
-	else
+	} else {
+		BUFFER_TRACE(bh, "clear uptodate");
 		clear_buffer_uptodate(bh);
+	}
 	unlock_buffer(bh);
 }
 
@@ -743,6 +745,7 @@ skip_commit: /* The journal should be un
 		 * behind for writeback and gets reallocated for another
 		 * use in a different page. */
 		if (buffer_freed(bh)) {
+			BUFFER_TRACE(bh, "buffer_freed");
 			clear_buffer_freed(bh);
 			clear_buffer_jbddirty(bh);
 		}
@@ -752,8 +755,10 @@ skip_commit: /* The journal should be un
 			__journal_insert_checkpoint(jh, commit_transaction);
 			JBUFFER_TRACE(jh, "refile for checkpoint writeback");
 			__journal_refile_buffer(jh);
+			JBUFFER_TRACE(jh, "did writepage hack");
 			jbd_unlock_bh_state(bh);
 		} else {
+			BUFFER_TRACE(bh, "not jbddirty");
 			J_ASSERT_BH(bh, !buffer_dirty(bh));
 			J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 			__journal_unfile_buffer(jh);
diff -puN /dev/null fs/jbd-kernel.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ 25-akpm/fs/jbd-kernel.c	2004-06-02 17:50:41.088848872 -0700
@@ -0,0 +1,255 @@
+/*
+ * fs/jbd-kernel.c
+ *
+ * Support code for the Journalling Block Device layer.
+ * This file contains things which have to be in-kernel when
+ * JBD is a module.
+ *
+ * 15 May 2001	Andrew Morton <andrewm@uow.edu.au>
+ *	Created
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/jbd.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+/*
+ * Some sanity testing which is called from mark_buffer_clean(),
+ * and must be present in the main kernel.
+ */
+
+void jbd_preclean_buffer_check(struct buffer_head *bh)
+{
+	if (buffer_jbd(bh)) {
+		struct journal_head *jh = bh2jh(bh);
+
+		transaction_t *transaction = jh->b_transaction;
+		journal_t *journal;
+
+		if (jh->b_jlist == 0 && transaction == NULL)
+			return;
+
+		J_ASSERT_JH(jh, transaction != NULL);
+		/* The kernel may be unmapping old data.  We expect it
+		 * to be dirty in that case, unless the buffer has
+		 * already been forgotten by a transaction. */
+		if (jh->b_jlist != BJ_Forget) {
+#if 1
+			if (!buffer_dirty(bh)) {
+				printk("%s: clean of clean buffer\n",
+					__FUNCTION__);
+				print_buffer_trace(bh);
+				return;
+			}
+#endif
+			J_ASSERT_BH(bh, buffer_dirty(bh));
+		}
+
+		journal = transaction->t_journal;
+		J_ASSERT_JH(jh,
+			    transaction == journal->j_running_transaction ||
+			    transaction == journal->j_committing_transaction);
+	}
+}
+EXPORT_SYMBOL(jbd_preclean_buffer_check);
+
+/*
+ * Support functions for BUFFER_TRACE()
+ */
+
+static spinlock_t trace_lock = SPIN_LOCK_UNLOCKED;
+
+void buffer_trace(char *function, struct buffer_head *dest,
+		struct buffer_head *src, char *info)
+{
+	struct buffer_history_item *bhist_i;
+	struct page *page;
+	unsigned long flags;
+
+	if (dest == 0 || src == 0)
+		return;
+
+	spin_lock_irqsave(&trace_lock, flags);
+
+	/*
+	 * Sometimes we don't initialise the ring pointers. (locally declared
+	 * temp buffer_heads). Feebly attempt to detect and correct that here.
+	 */
+	if ((dest->b_history.b_history_head - dest->b_history.b_history_tail >
+				BUFFER_HISTORY_SIZE)) {
+		dest->b_history.b_history_head = 0;
+		dest->b_history.b_history_tail = 0;
+	}
+	bhist_i = dest->b_history.b +
+		(dest->b_history.b_history_head & (BUFFER_HISTORY_SIZE - 1));
+	bhist_i->function = function;
+	bhist_i->info = info;
+	bhist_i->b_state = src->b_state;
+	page = src->b_page;
+	if (page)
+		bhist_i->pg_dirty = !!PageDirty(page);
+	else
+		bhist_i->pg_dirty = 0;
+
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE)
+	bhist_i->b_trans_is_running = 0;
+	bhist_i->b_trans_is_committing = 0;
+	bhist_i->b_blocknr = src->b_blocknr;
+	if (buffer_jbd(src)) {
+		struct journal_head *jh;
+		journal_t *journal;
+		transaction_t *transaction;
+
+		/* Footwork to avoid racing with journal_remove_journal_head */
+		jh = src->b_private;
+		if (jh == 0)
+			goto raced;
+		transaction = jh->b_transaction;
+		if (src->b_private == 0)
+			goto raced;
+		bhist_i->b_jcount = jh->b_jcount;
+		bhist_i->b_jbd = 1;
+		bhist_i->b_jlist = jh->b_jlist;
+		bhist_i->b_frozen_data = jh->b_frozen_data;
+		bhist_i->b_committed_data = jh->b_committed_data;
+		bhist_i->b_transaction = !!jh->b_transaction;
+		bhist_i->b_next_transaction = !!jh->b_next_transaction;
+		bhist_i->b_cp_transaction = !!jh->b_cp_transaction;
+
+		if (transaction) {
+			journal = transaction->t_journal;
+			bhist_i->b_trans_is_running = transaction ==
+					journal->j_running_transaction;
+			bhist_i->b_trans_is_committing = transaction ==
+					journal->j_committing_transaction;
+		}
+	} else {
+raced:
+		bhist_i->b_jcount = 0;
+		bhist_i->b_jbd = 0;
+		bhist_i->b_jlist = 0;
+		bhist_i->b_frozen_data = 0;
+		bhist_i->b_committed_data = 0;
+		bhist_i->b_transaction = 0;
+		bhist_i->b_next_transaction = 0;
+		bhist_i->b_cp_transaction = 0;
+	}
+#endif	/* defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE) */
+
+	bhist_i->cpu = smp_processor_id();
+	bhist_i->b_count = atomic_read(&src->b_count);
+
+	dest->b_history.b_history_head++;
+	if (dest->b_history.b_history_head - dest->b_history.b_history_tail >
+				BUFFER_HISTORY_SIZE)
+		dest->b_history.b_history_tail =
+			dest->b_history.b_history_head - BUFFER_HISTORY_SIZE;
+
+	spin_unlock_irqrestore(&trace_lock, flags);
+}
+
+static const char *b_jlist_to_string(unsigned int b_list)
+{
+	switch (b_list) {
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE)
+	case BJ_None:		return "BJ_None";
+	case BJ_SyncData:	return "BJ_SyncData";
+	case BJ_Metadata:	return "BJ_Metadata";
+	case BJ_Forget:		return "BJ_Forget";
+	case BJ_IO:		return "BJ_IO";
+	case BJ_Shadow:		return "BJ_Shadow";
+	case BJ_LogCtl:		return "BJ_LogCtl";
+	case BJ_Reserved:	return "BJ_Reserved";
+#endif
+	default:		return "Bad b_jlist";
+	}
+}
+
+static void print_one_hist(struct buffer_history_item *bhist_i)
+{
+	printk(" %s():%s\n", bhist_i->function, bhist_i->info);
+	printk("     b_state:0x%lx b_jlist:%s cpu:%d b_count:%d b_blocknr:%lu\n",
+			bhist_i->b_state,
+			b_jlist_to_string(bhist_i->b_jlist),
+			bhist_i->cpu,
+			bhist_i->b_count,
+			bhist_i->b_blocknr);
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE)
+	printk("     b_jbd:%u b_frozen_data:%p b_committed_data:%p\n",
+			bhist_i->b_jbd,
+			bhist_i->b_frozen_data,
+			bhist_i->b_committed_data);
+	printk("     b_transaction:%u b_next_transaction:%u "
+			"b_cp_transaction:%u b_trans_is_running:%u\n",
+			bhist_i->b_transaction,
+			bhist_i->b_next_transaction,
+			bhist_i->b_cp_transaction,
+			bhist_i->b_trans_is_running);
+	printk("     b_trans_is_comitting:%u b_jcount:%u pg_dirty:%u",
+			bhist_i->b_trans_is_committing,
+			bhist_i->b_jcount,
+			bhist_i->pg_dirty);
+#endif
+	printk("\n");
+}
+
+void print_buffer_fields(struct buffer_head *bh)
+{
+	printk("b_blocknr:%llu b_count:%d\n",
+		(unsigned long long)bh->b_blocknr, atomic_read(&bh->b_count));
+	printk("b_this_page:%p b_data:%p b_page:%p\n",
+			bh->b_this_page, bh->b_data, bh->b_page);
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE)
+	if (buffer_jbd(bh)) {
+		struct journal_head *jh = bh2jh(bh);
+
+		printk("b_jlist:%u b_frozen_data:%p b_committed_data:%p\n",
+			jh->b_jlist, jh->b_frozen_data, jh->b_committed_data);
+		printk(" b_transaction:%p b_next_transaction:%p "
+				"b_cp_transaction:%p\n",
+			jh->b_transaction, jh->b_next_transaction,
+			jh->b_cp_transaction);
+		printk("b_cpnext:%p b_cpprev:%p\n",
+			jh->b_cpnext, jh->b_cpprev);
+	}
+#endif
+}
+
+void print_buffer_trace(struct buffer_head *bh)
+{
+	unsigned long idx, count;
+	unsigned long flags;
+
+	printk("buffer trace for buffer at 0x%p (I am CPU %d)\n",
+			bh, smp_processor_id());
+	BUFFER_TRACE(bh, "");		/* Record state now */
+
+	spin_lock_irqsave(&trace_lock, flags);
+	for (	idx = bh->b_history.b_history_tail, count = 0;
+		idx < bh->b_history.b_history_head &&
+			count < BUFFER_HISTORY_SIZE;
+		idx++, count++)
+		print_one_hist(bh->b_history.b +
+			(idx & (BUFFER_HISTORY_SIZE - 1)));
+
+	print_buffer_fields(bh);
+	spin_unlock_irqrestore(&trace_lock, flags);
+	dump_stack();
+	printk("\n");
+}
+
+static struct buffer_head *failed_buffer_head;	/* For access with debuggers */
+
+void buffer_assertion_failure(struct buffer_head *bh)
+{
+	console_verbose();
+	failed_buffer_head = bh;
+	print_buffer_trace(bh);
+}
+EXPORT_SYMBOL(buffer_trace);
+EXPORT_SYMBOL(print_buffer_trace);
+EXPORT_SYMBOL(buffer_assertion_failure);
+EXPORT_SYMBOL(print_buffer_fields);
diff -puN fs/jbd/transaction.c~ext3-debug fs/jbd/transaction.c
--- 25/fs/jbd/transaction.c~ext3-debug	2004-06-02 17:50:41.063852672 -0700
+++ 25-akpm/fs/jbd/transaction.c	2004-06-02 17:50:41.090848568 -0700
@@ -1503,6 +1503,7 @@ void __journal_unfile_buffer(struct jour
 	transaction_t *transaction;
 	struct buffer_head *bh = jh2bh(jh);
 
+	JBUFFER_TRACE(jh, "entry");
 	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
 	transaction = jh->b_transaction;
 	if (transaction)
@@ -1545,8 +1546,10 @@ void __journal_unfile_buffer(struct jour
 
 	__blist_del_buffer(list, jh);
 	jh->b_jlist = BJ_None;
-	if (test_clear_buffer_jbddirty(bh))
+	if (test_clear_buffer_jbddirty(bh)) {
+		BUFFER_TRACE(bh, "marking dirty");
 		mark_buffer_dirty(bh);	/* Expose it to the VM */
+	}
 out:
 	jh->b_transaction = NULL;
 }
@@ -1688,6 +1691,7 @@ static int __dispose_buffer(struct journ
 	int may_free = 1;
 	struct buffer_head *bh = jh2bh(jh);
 
+	JBUFFER_TRACE(jh, "unfile");
 	__journal_unfile_buffer(jh);
 
 	if (jh->b_cp_transaction) {
@@ -1934,6 +1938,7 @@ void __journal_file_buffer(struct journa
 	int was_dirty = 0;
 	struct buffer_head *bh = jh2bh(jh);
 
+	BUFFER_TRACE(bh, "entry");
 	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
 	assert_spin_locked(&transaction->t_journal->j_list_lock);
 
@@ -1955,8 +1960,10 @@ void __journal_file_buffer(struct journa
 			was_dirty = 1;
 	}
 
-	if (jh->b_transaction)
+	if (jh->b_transaction) {
+		BUFFER_TRACE(bh, "unfile");
 		__journal_unfile_buffer(jh);
+	}
 	jh->b_transaction = transaction;
 
 	switch (jlist) {
@@ -1996,6 +2003,7 @@ void __journal_file_buffer(struct journa
 
 	if (was_dirty)
 		set_buffer_jbddirty(bh);
+	BUFFER_TRACE(bh, "filed");
 }
 
 void journal_file_buffer(struct journal_head *jh,
@@ -2023,12 +2031,14 @@ void __journal_refile_buffer(struct jour
 	int was_dirty;
 	struct buffer_head *bh = jh2bh(jh);
 
+	JBUFFER_TRACE(jh, "entry");
 	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
 	if (jh->b_transaction)
 		assert_spin_locked(&jh->b_transaction->t_journal->j_list_lock);
 
 	/* If the buffer is now unused, just drop it. */
 	if (jh->b_next_transaction == NULL) {
+		BUFFER_TRACE(bh, "unfile");
 		__journal_unfile_buffer(jh);
 		return;
 	}
@@ -2039,6 +2049,7 @@ void __journal_refile_buffer(struct jour
 	 */
 
 	was_dirty = test_clear_buffer_jbddirty(bh);
+	BUFFER_TRACE(bh, "unfile");
 	__journal_unfile_buffer(jh);
 	jh->b_transaction = jh->b_next_transaction;
 	jh->b_next_transaction = NULL;
diff -puN fs/Kconfig~ext3-debug fs/Kconfig
--- 25/fs/Kconfig~ext3-debug	2004-06-02 17:50:41.064852520 -0700
+++ 25-akpm/fs/Kconfig	2004-06-02 17:50:41.091848416 -0700
@@ -186,6 +186,10 @@ config JBD_DEBUG
 	  generated.  To turn debugging off again, do
 	  "echo 0 > /proc/sys/fs/jbd-debug".
 
+config BUFFER_DEBUG
+	bool "buffer-layer tracing"
+	depends on JBD
+
 config FS_MBCACHE
 # Meta block cache for Extended Attributes (ext2/ext3)
 	tristate
diff -puN fs/Makefile~ext3-debug fs/Makefile
--- 25/fs/Makefile~ext3-debug	2004-06-02 17:50:41.066852216 -0700
+++ 25-akpm/fs/Makefile	2004-06-02 17:50:41.092848264 -0700
@@ -22,6 +22,8 @@ obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout
 obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
 
+obj-$(CONFIG_BUFFER_DEBUG)	+= jbd-kernel.o
+
 # binfmt_script is always there
 obj-y				+= binfmt_script.o
 
diff -puN fs/mpage.c~ext3-debug fs/mpage.c
--- 25/fs/mpage.c~ext3-debug	2004-06-02 17:50:41.067852064 -0700
+++ 25-akpm/fs/mpage.c	2004-06-02 17:50:41.093848112 -0700
@@ -233,6 +233,7 @@ do_mpage_readpage(struct bio *bio, struc
 	for (page_block = 0; page_block < blocks_per_page;
 				page_block++, block_in_file++) {
 		bh.b_state = 0;
+		bh.b_page = page;
 		if (block_in_file < last_block) {
 			if (get_block(inode, block_in_file, &bh, 0))
 				goto confused;
@@ -465,6 +466,7 @@ mpage_writepage(struct bio *bio, struct 
 	for (page_block = 0; page_block < blocks_per_page; ) {
 
 		map_bh.b_state = 0;
+		map_bh.b_page = page;
 		if (get_block(inode, block_in_file, &map_bh, 1))
 			goto confused;
 		if (buffer_new(&map_bh))
diff -puN include/linux/buffer_head.h~ext3-debug include/linux/buffer_head.h
--- 25/include/linux/buffer_head.h~ext3-debug	2004-06-02 17:50:41.068851912 -0700
+++ 25-akpm/include/linux/buffer_head.h	2004-06-02 17:50:41.093848112 -0700
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/wait.h>
 #include <asm/atomic.h>
+#include <linux/buffer-trace.h>
 
 enum bh_state_bits {
 	BH_Uptodate,	/* Contains valid data */
@@ -59,6 +60,10 @@ struct buffer_head {
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
+
+#ifdef CONFIG_BUFFER_DEBUG
+	struct buffer_history b_history;
+#endif
 };
 
 /*
diff -puN /dev/null include/linux/buffer-trace.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ 25-akpm/include/linux/buffer-trace.h	2004-06-02 17:50:41.094847960 -0700
@@ -0,0 +1,85 @@
+/*
+ * include/linux/buffer-trace.h
+ *
+ * Debugging support for recording buffer_head state transitions
+ *
+ * May 2001, akpm
+ *	Created
+ */
+
+#ifndef BUFFER_TRACE_H_INCLUDED
+#define BUFFER_TRACE_H_INCLUDED
+
+#include <linux/config.h>
+
+#ifdef CONFIG_BUFFER_DEBUG
+
+/* The number of records per buffer_head.  Must be a power of two */
+#define BUFFER_HISTORY_SIZE	32
+
+struct buffer_head;
+
+/* This gets embedded in struct buffer_head */
+struct buffer_history {
+	struct buffer_history_item {
+		char *function;
+		char *info;
+		unsigned long b_state;
+		unsigned b_list:3;
+		unsigned b_jlist:4;
+		unsigned pg_dirty:1;
+		unsigned cpu:3;
+		unsigned b_count:8;
+		unsigned long b_blocknr;	/* For src != dest */
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE)
+		unsigned b_jcount:4;
+		unsigned b_jbd:1;
+		unsigned b_transaction:1;
+		unsigned b_next_transaction:1;
+		unsigned b_cp_transaction:1;
+		unsigned b_trans_is_running:1;
+		unsigned b_trans_is_committing:1;
+		void *b_frozen_data;
+		void *b_committed_data;
+#endif
+	} b[BUFFER_HISTORY_SIZE];
+	unsigned long b_history_head;	/* Next place to write */
+	unsigned long b_history_tail;	/* Oldest valid entry */
+};
+
+static inline void buffer_trace_init(struct buffer_history *bhist)
+{
+	bhist->b_history_head = 0;
+	bhist->b_history_tail = 0;
+}
+extern void buffer_trace(char *function, struct buffer_head *dest,
+			struct buffer_head *src, char *info);
+extern void print_buffer_fields(struct buffer_head *bh);
+extern void print_buffer_trace(struct buffer_head *bh);
+
+#define BUFFER_STRINGIFY2(X)		#X
+#define BUFFER_STRINGIFY(X)		BUFFER_STRINGIFY2(X)
+
+#define BUFFER_TRACE2(dest, src, info)				\
+	do {							\
+		buffer_trace(__FUNCTION__, (dest), (src),	\
+			"["__FILE__":"				\
+			BUFFER_STRINGIFY(__LINE__)"] " info);	\
+	} while (0)
+
+#define BUFFER_TRACE(bh, info) BUFFER_TRACE2(bh, bh, info)
+#define JBUFFER_TRACE(jh, info)	BUFFER_TRACE(jh2bh(jh), info)
+
+#else		/* CONFIG_BUFFER_DEBUG */
+
+#define buffer_trace_init(bh)	do {} while (0)
+#define print_buffer_fields(bh)	do {} while (0)
+#define print_buffer_trace(bh)	do {} while (0)
+#define BUFFER_TRACE(bh, info)	do {} while (0)
+#define BUFFER_TRACE2(bh, bh2, info)	do {} while (0)
+#define JBUFFER_TRACE(jh, info)	do {} while (0)
+
+#endif		/* CONFIG_BUFFER_DEBUG */
+
+#endif		/* BUFFER_TRACE_H_INCLUDED */
+
diff -puN include/linux/jbd.h~ext3-debug include/linux/jbd.h
--- 25/include/linux/jbd.h~ext3-debug	2004-06-02 17:50:41.070851608 -0700
+++ 25-akpm/include/linux/jbd.h	2004-06-02 17:50:41.095847808 -0700
@@ -54,7 +54,9 @@
  * CONFIG_JBD_DEBUG is on.
  */
 #define JBD_EXPENSIVE_CHECKING
+
 extern int journal_enable_debug;
+extern struct block_device *journal_no_write[2];
 
 #define jbd_debug(n, f, a...)						\
 	do {								\
@@ -265,6 +267,7 @@ void buffer_assertion_failure(struct buf
 #else
 #define J_ASSERT_BH(bh, expr)	J_ASSERT(expr)
 #define J_ASSERT_JH(jh, expr)	J_ASSERT(expr)
+#define buffer_assertion_failure(bh) do { } while (0)
 #endif
 
 #else
@@ -1085,6 +1088,8 @@ static inline int jbd_space_needed(journ
  * Definitions which augment the buffer_head layer
  */
 
+/* JBD additions */
+
 /* journaling buffer types */
 #define BJ_None		0	/* Not journaled */
 #define BJ_SyncData	1	/* Normal data: flush before commit */
@@ -1107,13 +1112,6 @@ extern int jbd_blocks_per_page(struct in
 #define assert_spin_locked(lock)	do {} while(0)
 #endif
 
-#define buffer_trace_init(bh)	do {} while (0)
-#define print_buffer_fields(bh)	do {} while (0)
-#define print_buffer_trace(bh)	do {} while (0)
-#define BUFFER_TRACE(bh, info)	do {} while (0)
-#define BUFFER_TRACE2(bh, bh2, info)	do {} while (0)
-#define JBUFFER_TRACE(jh, info)	do {} while (0)
-
 #endif	/* __KERNEL__ */
 
 #endif	/* CONFIG_JBD || CONFIG_JBD_MODULE || !__KERNEL__ */
_

