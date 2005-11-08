Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVKHQtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVKHQtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKHQtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:49:04 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:2737 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932393AbVKHQtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:49:02 -0500
From: ext3crypt@comcast.net
To: linux-kernel@vger.kernel.org
Subject: Guidance Please
Date: Tue, 08 Nov 2005 16:49:01 +0000
Message-Id: <110820051649.20930.4370D6FD0005672D000051C222007507849B9F979D0CCC9B980A@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: ZXh0M2NyeXB0QGNvbWNhc3QubmV0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_20930_1131468541_0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_20930_1131468541_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

I'm working on a master's project to add a switch to ext3 to do native
encryption, and I have an issue I'm looking for direction on.

To write the enciphered pages from ordered_writepage et. al. I've made a new
version of __block_write_full_page.  It creates a new page and sets up the
buffer_head data to point into the page's memory at the same boundaries as
the page that needs written out.  I then send it's buffer_head to submit_bh.


The data in the buffer is encrypted before the call to submit_bh() and the
data is encrypted in the buffer after the call to submit_bh().  A simple xor
encryption for now.


My working assumptions are that submit_bh() sends an IO to the IO scheduler.
The buffer_head that is passed to it gets mapped to a bio and submit_bio()
then sends it forward to schedule the IO.


When I do this, the plaintext data is written to disk.  I.E. it is though
the submit_bh() ignores the buffers that are passed to it, and somehow
refers back to the page that I copied in the first place.


I do the following to test it:

mount the fs
cd to it
cp file1 to file2
cat file2 (before the sync) --> it is OK
sync (or wait for pdflush)
cat file2 --> it is OK
cd off the disk
umount the fs
mount the fs
cd to it
cat file2 --> it is the unencrypted form of the data i.e. what was in the
page_cache not what I sent to submit_bh().

I'm working on 2.6.13 kernel.


I can only conclude that:

submit_bh() does not initiate the block_IO; but I've read that it does so
this is unlikely.

The block device driver somehow knows the address of the page that is mapped
to the disk device and offset (or sector and size combination) then issues
IO on the initial page address ot the one I sent in the buffer_head struct . . .

Can someone point me in the right direction?  A simple "no it does not work
that way" you need to look here, would be helpful. I've attached the source
that I've modified see the __ext3_crypt_block_write_full_page().  Please
ignore the prefix ext3_crypt on everything in the source, I'm using ext3 and
needed a seperate branch to work modify without risking damage to ext3.

The attachment is part of the fs/ext3-crypt/inode.c changes for writing.

--NextPart_Webmail_9m3u9jl4l_20930_1131468541_0
Content-Type: text/plain; name="write_changes.c"
Content-Transfer-Encoding: 7bit

/* BEGIN ADDITIONS -- JGB

*/
/* Assumes that the number of buffers are the same between the source and 
   destination.
*/
static inline void __copy_buffers(struct page *page_dest,struct page *page_src)
{
	char * src, * dest;
	int	i;

	src = kmap(page_src);
	dest = kmap(page_dest);

	// memcpy(dest,src,PAGE_SIZE);

	for(i=0; i < PAGE_SIZE; i++,src++,dest++) 
		{
		*dest = 0xff ^ *src;
		// *src ^= 0xff;
		// printk("%c <==> %c\n",*src,*dest);
		}

	kunmap(page_src);
	kunmap(page_dest);
}

static inline void __dump_page_contents(struct page *page)
{
	int i;
	unsigned char *c;
	
	c = kmap(page);
	printk("PAGE ADDRESS = %X\n",(unsigned int) page);
	for (i=0;i<PAGE_SIZE;i++)
		{
		if ((i%40) == 0) printk("\n");
		printk("%c",(*c < 128)?*c:'.');
		}
	printk("\n");
	kunmap(page);

}



static inline void __dump_buffer_struct(struct buffer_head *bh)
{
	printk("State = %x\n",(unsigned int) bh->b_state);
	printk("Page = %x\n",(unsigned int) bh->b_page);
	// printk("Count = %i\n",(unsigned int) bh->b_count);
	printk("Size = %i\n",(unsigned int) bh->b_size);
	printk("Block = %i\n",(unsigned int) bh->b_blocknr);
	printk("Data = %x\n",(unsigned int) bh->b_data);
	printk("Dev = %x\n",(unsigned int) bh->b_bdev);
}


static inline void __new_buffers(struct page *page,
		unsigned long blocksize, unsigned long b_state)
{
	struct buffer_head *bh, *head, *tail;

	head = alloc_page_buffers(page, blocksize, 1);
	bh = head;
	do {
		bh->b_state |= b_state;
		tail = bh;
		printk("New BH = %X\n",(unsigned int)bh);
		set_buffer_uptodate(bh); // Page is known to be UpToDate
		bh = bh->b_this_page;
	} while (bh);
	tail->b_this_page = head;
	// Probably needs locked look at create_empty_buffers in fs/buffer.c
	attach_page_buffers(page, head);
}





/*
 * NOTE! All mapped/uptodate combinations are valid:
 *
 *	Mapped	Uptodate	Meaning
 *
 *	No	No		"unknown" - must do get_block()
 *	No	Yes		"hole" - zero-filled
 *	Yes	No		"allocated" - allocated on disk, not read in
 *	Yes	Yes		"valid" - allocated and up-to-date in memory.
 *
 * "Dirty" is valid only with the last case (mapped+uptodate).
 */

/*
 * While block_write_full_page is writing back the dirty buffers under
 * the page lock, whoever dirtied the buffers may decide to clean them
 * again at any time.  We handle that by only looking at the buffer
 * state inside lock_buffer().
 *
 * If block_write_full_page() is called for regular writeback
 * (wbc->sync_mode == WB_SYNC_NONE) then it will redirty a page which has a
 * locked buffer.   This only can happen if someone has written the buffer
 * directly, with submit_bh().  At the address_space level PageWriteback
 * prevents this contention from occurring.
 */
static int __ext3_crypt_block_write_full_page(struct inode *inode, 
	struct page *page, get_block_t *get_block, 
	struct writeback_control *wbc)
{
	int err;
	sector_t block;
	sector_t last_block;
	struct buffer_head *bh, *head;
	struct buffer_head *bh_orig, *head_orig;
	int nr_underway = 0;
	struct page *tmp_page;

	BUG_ON(!PageLocked(page));

	last_block = (i_size_read(inode) - 1) >> inode->i_blkbits;

	if (!page_has_buffers(page)) {
		create_empty_buffers(page, 1 << inode->i_blkbits,
					(1 << BH_Dirty)|(1 << BH_Uptodate));
	}

	/*
	 * Be very careful.  We have no exclusion from __set_page_dirty_buffers
	 * here, and the (potentially unmapped) buffers may become dirty at
	 * any time.  If a buffer becomes dirty here after we've inspected it
	 * then we just miss that fact, and the page stays dirty.
	 *
	 * Buffers outside i_size may be dirtied by __set_page_dirty_buffers;
	 * handle that here by just cleaning them.
	 */

// JGB -- Create a new page and copy the buffers to it to submit the copied
//        buffers to bio.

	// Allocate a page w/o starting FS IO in NORMAL ZONE
	tmp_page = alloc_page(GFP_NOFS); 
	if (!tmp_page)
		{
		return -ENOMEM;
		}
	// LOCK IT ?  -- mark clean to avoid flush? Uptodate?
	// need to get_bh() for the new buffer_head. in copy_buffers too
	lock_page(tmp_page);


	__new_buffers(tmp_page, 1 << inode->i_blkbits,
		(1 << BH_Dirty)|(1 << BH_Uptodate));


	__copy_buffers(tmp_page, page); // XOR ENCRYPT TOO


	SetPageReferenced(tmp_page);
	SetPageUptodate(tmp_page);
	SetPageLRU(tmp_page);

//	printk("\npage = %X\n",(unsigned int)page);
	__dump_buffer_struct(page_buffers(page));
	
//	printk("tmp_page = %X\n",(unsigned int)tmp_page);
	__dump_buffer_struct(page_buffers(tmp_page));

// 	printk("P= %x  ;  T = %x\n",page->flags, tmp_page->flags);


	

	block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
	//head = page_buffers(page);
	head = page_buffers(tmp_page);
	bh = head;
	head_orig = page_buffers(page);
	bh_orig = head;
	/*
	 * Get all the dirty buffers mapped to disk addresses and
	 * handle any aliases from the underlying blockdev's mapping.
	 */
	do {
		
		bh->b_state = bh_orig->b_state;
		bh->b_blocknr = bh_orig->b_blocknr;
		bh->b_bdev = bh_orig->b_bdev;
		bh->b_data = 0;


		if (block > last_block) {
			/*
			 * mapped buffers outside i_size will occur, because
			 * this page can be outside i_size when there is a
			 * truncate in progress.
			 */
			/*
			 * The buffer was zeroed by block_write_full_page()
			 */
			clear_buffer_dirty(bh);
			set_buffer_uptodate(bh);
		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
			err = get_block(inode, block, bh, 1);
			if (err)
				goto recover;
			if (buffer_new(bh)) {
				/* blockdev mappings never come here */
				clear_buffer_new(bh);
				unmap_underlying_metadata(bh->b_bdev,
							bh->b_blocknr);
			}
		}
		bh = bh->b_this_page;
		bh_orig = bh_orig->b_this_page;
		block++;
	} while (bh != head);

	do {
		if (!buffer_mapped(bh))
			continue;
		/*
		 * If it's a fully non-blocking write attempt and we cannot
		 * lock the buffer then redirty the page.  Note that this can
		 * potentially cause a busy-wait loop from pdflush and kswapd
		 * activity, but those code paths have their own higher-level
		 * throttling.
		 */
		if (wbc->sync_mode != WB_SYNC_NONE || !wbc->nonblocking) {
			lock_buffer(bh);
		} else if (test_set_buffer_locked(bh)) {
			printk("Redirty page\n");
			redirty_page_for_writepage(wbc, tmp_page);
			continue;
		}
		if (test_clear_buffer_dirty(bh)) {
			mark_buffer_async_write(bh);
		} else {
			unlock_buffer(bh);
		}
	} while ((bh = bh->b_this_page) != head);

	/*
	 * The page and its buffers are protected by PageWriteback(), so we can
	 * drop the bh refcounts early.
	 */
	BUG_ON(PageWriteback(page));
	set_page_writeback(tmp_page);

	do {
		struct buffer_head *next = bh->b_this_page;
		if (buffer_async_write(bh)) {
			submit_bh(WRITE, bh);
//			printk("BH = %X\n",(unsigned int)bh);
//			printk("Page = %X\n",(unsigned int)bh->b_page);
			printk("Buffer Page:\n");
			__dump_page_contents(bh->b_page);
			printk("Temp Page:\n");
			__dump_page_contents(tmp_page);
			printk("\n");
			nr_underway++;
		}
		bh = next;
	} while (bh != head);
	unlock_page(tmp_page);
	unlock_page(page);

	err = 0;
done:
	if (nr_underway == 0) {
		/*
		 * The page was marked dirty, but the buffers were
		 * clean.  Someone wrote them back by hand with
		 * ll_rw_block/submit_bh.  A rare case.
		 */
		int uptodate = 1;
		do {
			if (!buffer_uptodate(bh)) {
				uptodate = 0;
				break;
			}
			bh = bh->b_this_page;
		} while (bh != head);
		if (uptodate)
			{
			SetPageUptodate(page);
			SetPageUptodate(tmp_page);
			}
		end_page_writeback(tmp_page);
		/*
		 * The page and buffer_heads can be released at any time from
		 * here on.
		 */
		wbc->pages_skipped++;	/* We didn't write this page */
	}
	return err;

recover:
	/*
	 * ENOSPC, or some other error.  We may already have added some
	 * blocks to the file, so we need to write these out to avoid
	 * exposing stale data.
	 * The page is currently locked and not marked for writeback
	 */
	bh = head;
	/* Recovery: lock and submit the mapped buffers */
	do {
		if (buffer_mapped(bh) && buffer_dirty(bh)) {
			lock_buffer(bh);
			mark_buffer_async_write(bh);
		} else {
			/*
			 * The buffer may have been set dirty during
			 * attachment to a dirty page.
			 */
			clear_buffer_dirty(bh);
		}
	} while ((bh = bh->b_this_page) != head);
	SetPageError(page);
	BUG_ON(PageWriteback(page));
	set_page_writeback(page);
	unlock_page(page);
	do {
		struct buffer_head *next = bh->b_this_page;
		if (buffer_async_write(bh)) {
			clear_buffer_dirty(bh);
			submit_bh(WRITE, bh);
			nr_underway++;
		}
		bh = next;
	} while (bh != head);
	goto done;
}



/*
 * The generic ->writepage function for buffer-backed address_spaces
 */
int ext3_crypt_block_write_full_page(struct page *page, get_block_t *get_block,
			struct writeback_control *wbc)
{
	struct inode * const inode = page->mapping->host;
	loff_t i_size = i_size_read(inode);
	const pgoff_t end_index = i_size >> PAGE_CACHE_SHIFT;
	unsigned offset;
	void *kaddr;

	/* Is the page fully inside i_size? */
	if (page->index < end_index)
		return __ext3_crypt_block_write_full_page(inode, page, 
				get_block, wbc);

	/* Is the page fully outside i_size? (truncate in progress) */
	offset = i_size & (PAGE_CACHE_SIZE-1);
	if (page->index >= end_index+1 || !offset) {
		/*
		 * The page may have dirty, unmapped buffers.  For example,
		 * they may have been added in ext3_writepage().  Make them
		 * freeable here, so the page does not leak.
		 */
		block_invalidatepage(page, 0);
		unlock_page(page);
		return 0; /* don't care */
	}

	/*
	 * The page straddles i_size.  It must be zeroed out on each and every
	 * writepage invokation because it may be mmapped.  "A file is mapped
	 * in multiples of the page size.  For a file that is not a multiple of
	 * the  page size, the remaining memory is zeroed when mapped, and
	 * writes to that region are not written out to the file."
	 */
	kaddr = kmap_atomic(page, KM_USER0);
	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
	flush_dcache_page(page);
	kunmap_atomic(kaddr, KM_USER0);
	return __ext3_crypt_block_write_full_page(inode, page, get_block, wbc);
}




/* END ADDITIONS -- JGB */


/*
 * Note that we always start a transaction even if we're not journalling
 * data.  This is to preserve ordering: any hole instantiation within
 * __block_write_full_page -> ext3_crypt_get_block() should be journalled
 * along with the data so we don't crash and then get metadata which
 * refers to old data.
 *
 * In all journalling modes block_write_full_page() will start the I/O.
 *
 * Problem:
 *
 *  ext3_crypt_writepage() -> kmalloc() -> __alloc_pages() -> page_launder() ->
 *  ext3_crypt_writepage()
 *
 * Similar for:
 *
 *  ext3_crypt_file_write() -> generic_file_write() -> __alloc_pages() -> ...
 *
 * Same applies to ext3_crypt_get_block().  We will deadlock on various things 
 * like lock_journal and i_truncate_sem.
 *
 * Setting PF_MEMALLOC here doesn't work - too many internal memory
 * allocations fail.
 *
 * 16May01: If we're reentered then journal_current_handle() will be
 *	    non-zero. We simply *return*.
 *
 * 1 July 2001: @@@ FIXME:
 *   In journalled data mode, a data buffer may be metadata against the
 *   current transaction.  But the same file is part of a shared mapping
 *   and someone does a writepage() on it.
 *
 *   We will move the buffer onto the async_data list, but *after* it has
 *   been dirtied. So there's a small window where we have dirty data on
 *   BJ_Metadata.
 *
 *   Note that this only applies to the last partial page in the file.  The
 *   bit which block_write_full_page() uses prepare/commit for.  (That's
 *   broken code anyway: it's wrong for msync()).
 *
 *   It's a rare case: affects the final partial page, for journalled data
 *   where the file is subject to bith write() and writepage() in the same
 *   transction.  To fix it we'll need a custom block_write_full_page().
 *   We'll probably need that anyway for journalling writepage() output.
 *
 * We don't honour synchronous mounts for writepage().  That would be
 * disastrous.  Any write() or metadata operation will sync the fs for
 * us.
 *
 * AKPM2: if all the page's buffers are mapped to disk and !data=journal,
 * we don't need to open a transaction here.
 */


static int ext3_crypt_ordered_writepage(struct page *page,
			struct writeback_control *wbc)
{
	struct inode *inode = page->mapping->host;
	struct buffer_head *page_bufs;
	handle_t *handle = NULL;
	int ret = 0;
	int err;

	J_ASSERT(PageLocked(page));

	/*
	 * We give up here if we're reentered, because it might be for a
	 * different filesystem.
	 */
	if (ext3_crypt_journal_current_handle())
		goto out_fail;

	handle = ext3_crypt_journal_start(inode, ext3_crypt_writepage_trans_blocks(inode));

	if (IS_ERR(handle)) {
		ret = PTR_ERR(handle);
		goto out_fail;
	}

	if (!page_has_buffers(page)) {
		create_empty_buffers(page, inode->i_sb->s_blocksize,
				(1 << BH_Dirty)|(1 << BH_Uptodate));
	}
	page_bufs = page_buffers(page);
	walk_page_buffers(handle, page_bufs, 0,
			PAGE_CACHE_SIZE, NULL, bget_one);

	
	ret = ext3_crypt_block_write_full_page(page, ext3_crypt_get_block, wbc);

	/*
	 * The page can become unlocked at any point now, and
	 * truncate can then come in and change things.  So we
	 * can't touch *page from now on.  But *page_bufs is
	 * safe due to elevated refcount.
	 */

	/*
	 * And attach them to the current transaction.  But only if 
	 * block_write_full_page() succeeded.  Otherwise they are unmapped,
	 * and generally junk.
	 */
	if (ret == 0) {
		err = walk_page_buffers(handle, page_bufs, 0, PAGE_CACHE_SIZE,
					NULL, journal_dirty_data_fn);
		if (!ret)
			ret = err;
	}
	walk_page_buffers(handle, page_bufs, 0,
			PAGE_CACHE_SIZE, NULL, bput_one);

	err = ext3_crypt_journal_stop(handle);

	if (!ret)
		ret = err;
	return ret;

out_fail:
	redirty_page_for_writepage(wbc, page);
	unlock_page(page);
	return ret;
}


--NextPart_Webmail_9m3u9jl4l_20930_1131468541_0--
