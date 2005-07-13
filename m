Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVGMXoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVGMXoq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVGMXoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:44:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261594AbVGMXmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:42:01 -0400
Subject: [rfc patch 1/2] direct-io: rewrite to handle non-512 aligned user
	address
From: Daniel McNeil <daniel@osdl.org>
To: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1121298111.6025.19.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Jul 2005 16:41:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a re-write of direct i/o so that it does not depend on the
user address being a multiple of 512.  This is necessary to allow
relaxing the address alignment check in the 2nd patch.

I have tested this on 2.6.13-rc2 with a variety of i/o sizes and
i/o offsets on ext3 without problems (with 512 alignment).  It even
make the code smaller:

   text    data     bss     dec     hex filename
   7668       0       0    7668    1df4 direct-io.o original
   7160       0       0    7160    1bf8 direct-io.o patched

Any additional testing and/or comments welcome.

Signed-off-by: Daniel McNeil <daniel@osdl.org>

--- linux-2.6.12.orig/fs/direct-io.c	2005-06-28 15:26:50.000000000 -0700
+++ linux-2.6.12/fs/direct-io.c	2005-06-28 16:03:14.000000000 -0700
@@ -43,16 +43,6 @@
 #define DIO_PAGES	64
 
 /*
- * This code generally works in units of "dio_blocks".  A dio_block is
- * somewhere between the hard sector size and the filesystem block size.  it
- * is determined on a per-invocation basis.   When talking to the filesystem
- * we need to convert dio_blocks to fs_blocks by scaling the dio_block quantity
- * down by dio->blkfactor.  Similarly, fs-blocksize quantities are converted
- * to bio_block quantities by shifting left by blkfactor.
- *
- * If blkfactor is zero then the user's request was aligned to the filesystem's
- * blocksize.
- *
  * lock_type is DIO_LOCKING for regular files on direct-IO-naive filesystems.
  * This determines whether we need to do the fancy locking which prevents
  * direct-IO from being able to read uninitialised disk blocks.  If its zero
@@ -69,28 +59,20 @@ struct dio {
 	loff_t i_size;			/* i_size when submitted */
 	int lock_type;			/* doesn't change */
 	unsigned blkbits;		/* doesn't change */
-	unsigned blkfactor;		/* When we're using an alignment which
-					   is finer than the filesystem's soft
-					   blocksize, this specifies how much
-					   finer.  blkfactor=2 means 1/4-block
-					   alignment.  Does not change */
 	unsigned start_zero_done;	/* flag: sub-blocksize zeroing has
 					   been performed at the start of a
 					   write */
 	int pages_in_io;		/* approximate total IO pages */
 	size_t	size;			/* total request size (doesn't change)*/
-	sector_t block_in_file;		/* Current offset into the underlying
-					   file in dio_block units. */
-	unsigned blocks_available;	/* At block_in_file.  changes */
-	sector_t final_block_in_request;/* doesn't change */
-	unsigned first_block_in_page;	/* doesn't change, Used only once */
+	unsigned long user_addr;	/* user buffer addr */
+	loff_t file_offset;		/* file offset of i/o */
+	loff_t final_file_offset;	/* file offset at end of i/o */
+	unsigned bytes_available;	/* bytes available */
 	int boundary;			/* prev block is at a boundary */
 	int reap_counter;		/* rate limit reaping */
 	get_blocks_t *get_blocks;	/* block mapping function */
 	dio_iodone_t *end_io;		/* IO completion function */
 	sector_t final_block_in_bio;	/* current final block in bio + 1 */
-	sector_t next_block_for_io;	/* next block to be put under IO,
-					   in dio_blocks units */
 	struct buffer_head map_bh;	/* last get_blocks() result */
 
 	/*
@@ -161,11 +143,11 @@ static int dio_refill_pages(struct dio *
 		NULL);				/* vmas */
 	up_read(&current->mm->mmap_sem);
 
-	if (ret < 0 && dio->blocks_available && (dio->rw == WRITE)) {
+	if (ret < 0 && dio->bytes_available && (dio->rw == WRITE)) {
 		/*
 		 * A memory fault, but the filesystem has some outstanding
-		 * mapped blocks.  We need to use those blocks up to avoid
-		 * leaking stale data in the file.
+		 * mapped blocks.  We need to write zeros to those blocks
+		 * to avoid leaking stale data in the file.
 		 */
 		if (dio->page_errors == 0)
 			dio->page_errors = ret;
@@ -480,8 +462,7 @@ static int dio_bio_reap(struct dio *dio)
 
 /*
  * Call into the fs to map some more disk blocks.  We record the current number
- * of available blocks at dio->blocks_available.  These are in units of the
- * fs blocksize, (1 << inode->i_blkbits).
+ * of available bytes at dio->bytess_available.
  *
  * The fs is allowed to map lots of blocks at once.  If it wants to do that,
  * it uses the passed inode-relative block number as the file offset, as usual.
@@ -498,8 +479,7 @@ static int dio_bio_reap(struct dio *dio)
  *
  * In the case of filesystem holes: the fs may return an arbitrarily-large
  * hole by returning an appropriate value in b_size and by clearing
- * buffer_mapped().  However the direct-io code will only process holes one
- * block at a time - it will repeatedly call get_blocks() as it walks the hole.
+ * buffer_mapped().
  */
 static int get_more_blocks(struct dio *dio)
 {
@@ -507,8 +487,6 @@ static int get_more_blocks(struct dio *d
 	struct buffer_head *map_bh = &dio->map_bh;
 	sector_t fs_startblk;	/* Into file, in filesystem-sized blocks */
 	unsigned long fs_count;	/* Number of filesystem-sized blocks */
-	unsigned long dio_count;/* Number of dio_block-sized blocks */
-	unsigned long blkmask;
 	int create;
 
 	/*
@@ -519,18 +497,14 @@ static int get_more_blocks(struct dio *d
 	if (ret == 0) {
 		map_bh->b_state = 0;
 		map_bh->b_size = 0;
-		BUG_ON(dio->block_in_file >= dio->final_block_in_request);
-		fs_startblk = dio->block_in_file >> dio->blkfactor;
-		dio_count = dio->final_block_in_request - dio->block_in_file;
-		fs_count = dio_count >> dio->blkfactor;
-		blkmask = (1 << dio->blkfactor) - 1;
-		if (dio_count & blkmask)	
-			fs_count++;
+		BUG_ON(dio->file_offset >= dio->final_file_offset);
+		fs_startblk = dio->file_offset >> dio->blkbits;
+		fs_count = ((dio->final_file_offset - 1) >> 9) -
+			   fs_startblk + 1;
 
 		create = dio->rw == WRITE;
 		if (dio->lock_type == DIO_LOCKING) {
-			if (dio->block_in_file < (i_size_read(dio->inode) >>
-							dio->blkbits))
+			if (dio->file_offset < dio->i_size)
 				create = 0;
 		} else if (dio->lock_type == DIO_NO_LOCKING) {
 			create = 0;
@@ -558,7 +532,7 @@ static int dio_new_bio(struct dio *dio, 
 	ret = dio_bio_reap(dio);
 	if (ret)
 		goto out;
-	sector = start_sector << (dio->blkbits - 9);
+	sector = start_sector;
 	nr_pages = min(dio->pages_in_io, bio_get_nr_vecs(dio->map_bh.b_bdev));
 	BUG_ON(nr_pages <= 0);
 	ret = dio_bio_alloc(dio, dio->map_bh.b_bdev, sector, nr_pages);
@@ -588,7 +562,7 @@ static int dio_bio_add_page(struct dio *
 			dio->pages_in_io--;
 		page_cache_get(dio->cur_page);
 		dio->final_block_in_bio = dio->cur_page_block +
-			(dio->cur_page_len >> dio->blkbits);
+			(dio->cur_page_len >> 9);
 		ret = 0;
 	} else {
 		ret = 1;
@@ -671,7 +645,7 @@ submit_page_section(struct dio *dio, str
 	if (	(dio->cur_page == page) &&
 		(dio->cur_page_offset + dio->cur_page_len == offset) &&
 		(dio->cur_page_block +
-			(dio->cur_page_len >> dio->blkbits) == blocknr)) {
+			(dio->cur_page_len >> 9) == blocknr)) {
 		dio->cur_page_len += len;
 
 		/*
@@ -727,44 +701,41 @@ static void clean_blockdev_aliases(struc
 /*
  * If we are not writing the entire block and get_block() allocated
  * the block for us, we need to fill-in the unused portion of the
- * block with zeros. This happens only if user-buffer, fileoffset or
- * io length is not filesystem block-size multiple.
+ * block with zeros. This happens only if fileoffset or io length
+ * is not filesystem block-size multiple.
  *
  * `end' is zero if we're doing the start of the IO, 1 at the end of the
  * IO.
  */
 static void dio_zero_block(struct dio *dio, int end)
 {
-	unsigned dio_blocks_per_fs_block;
-	unsigned this_chunk_blocks;	/* In dio_blocks */
 	unsigned this_chunk_bytes;
+	unsigned long blkmask = (1 << dio->blkbits) - 1;
+	unsigned fs_offset = dio->file_offset & blkmask;
+	int start;
 	struct page *page;
 
 	dio->start_zero_done = 1;
-	if (!dio->blkfactor || !buffer_new(&dio->map_bh))
+	if (fs_offset == 0 || !buffer_new(&dio->map_bh))
 		return;
 
-	dio_blocks_per_fs_block = 1 << dio->blkfactor;
-	this_chunk_blocks = dio->block_in_file & (dio_blocks_per_fs_block - 1);
-
-	if (!this_chunk_blocks)
+	if (end == 0) {
+		/* start */
+		start = 0;
+		this_chunk_bytes = fs_offset;
+	} else {
+		/* end */
+		start = fs_offset;
+		this_chunk_bytes = dio->map_bh.b_size - fs_offset;
+	}
+	if (!this_chunk_bytes)
 		return;
 
-	/*
-	 * We need to zero out part of an fs block.  It is either at the
-	 * beginning or the end of the fs block.
-	 */
-	if (end) 
-		this_chunk_blocks = dio_blocks_per_fs_block - this_chunk_blocks;
-
-	this_chunk_bytes = this_chunk_blocks << dio->blkbits;
-
 	page = ZERO_PAGE(dio->curr_user_address);
 	if (submit_page_section(dio, page, 0, this_chunk_bytes, 
-				dio->next_block_for_io))
+				(dio->map_bh.b_blocknr << (dio->blkbits - 9)) +
+				(start >> 9)))
 		return;
-
-	dio->next_block_for_io += this_chunk_blocks;
 }
 
 /*
@@ -786,72 +757,82 @@ static void dio_zero_block(struct dio *d
 static int do_direct_IO(struct dio *dio)
 {
 	const unsigned blkbits = dio->blkbits;
-	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	struct page *page;
-	unsigned block_in_page;
+	unsigned long user_addr;
+	unsigned int fs_offset = 0;	/* offset in fs block */
+	unsigned int page_offset;	/* offset in page */
+	unsigned int bytes_this_chunk;
+	unsigned long blkmask;
 	struct buffer_head *map_bh = &dio->map_bh;
 	int ret = 0;
 
-	/* The I/O can start at any block offset within the first page */
-	block_in_page = dio->first_block_in_page;
+	user_addr = dio->user_addr;
+
+	blkmask = (1 << dio->blkbits) - 1;
+	while (dio->file_offset < dio->final_file_offset) {
+		unsigned b;
 
-	while (dio->block_in_file < dio->final_block_in_request) {
 		page = dio_get_page(dio);
 		if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
 			goto out;
 		}
 
-		while (block_in_page < blocks_per_page) {
-			unsigned offset_in_page = block_in_page << blkbits;
-			unsigned this_chunk_bytes;	/* # of bytes mapped */
-			unsigned this_chunk_blocks;	/* # of blocks */
-			unsigned u;
-
-			if (dio->blocks_available == 0) {
+		/*
+		 * loop until done with this page 
+		 */
+		do {
+			page_offset = user_addr & (PAGE_SIZE - 1);
+			if (dio->bytes_available == 0) {
+				fs_offset = dio->file_offset & blkmask;
 				/*
 				 * Need to go and map some more disk
 				 */
-				unsigned long blkmask;
-				unsigned long dio_remainder;
 
 				ret = get_more_blocks(dio);
 				if (ret) {
 					page_cache_release(page);
 					goto out;
 				}
-				if (!buffer_mapped(map_bh))
-					goto do_holes;
 
-				dio->blocks_available =
-						map_bh->b_size >> dio->blkbits;
-				dio->next_block_for_io =
-					map_bh->b_blocknr << dio->blkfactor;
+				dio->bytes_available = map_bh->b_size;
+
 				if (buffer_new(map_bh))
 					clean_blockdev_aliases(dio);
 
-				if (!dio->blkfactor)
-					goto do_holes;
-
-				blkmask = (1 << dio->blkfactor) - 1;
-				dio_remainder = (dio->block_in_file & blkmask);
-
 				/*
-				 * If we are at the start of IO and that IO
-				 * starts partway into a fs-block,
-				 * dio_remainder will be non-zero.  If the IO
-				 * is a read then we can simply advance the IO
-				 * cursor to the first block which is to be
-				 * read.  But if the IO is a write and the
-				 * block was newly allocated we cannot do that;
-				 * the start of the fs block must be zeroed out
-				 * on-disk
+				 * If write i/o starts partway into fs_block
+				 * and the block is newly allocated,
+				 * we need to clear the beginning of the block,
+				 * but only for the 1st allocation for this dio.
+				 */
+				if (!dio->start_zero_done) 
+					dio_zero_block(dio, 0);
+				/*
+				 * Adjust bytes available, if starting in
+				 * partway into fs_block.
 				 */
-				if (!buffer_new(map_bh))
-					dio->next_block_for_io += dio_remainder;
-				dio->blocks_available -= dio_remainder;
+				dio->bytes_available -= fs_offset;
 			}
-do_holes:
+			/*
+			 * At this point we know the file block to do i/o to.
+			 * Now we have to see how much of this chunk we can do.
+			 * If starting the i/o in the middle of the file
+			 * system block block, bytes_available has already
+			 * been adjusted.  For unaligned user addr, we could
+			 * hit end of page before end of the fs block.
+			 */
+			bytes_this_chunk = dio->bytes_available;
+
+			b = PAGE_SIZE - page_offset;	/* bytes to page end */
+			if (bytes_this_chunk > b)
+				bytes_this_chunk = b;
+
+			/* check end of i/o */
+			b = dio->final_file_offset - dio->file_offset;
+			if (bytes_this_chunk > b)
+				bytes_this_chunk = b;
+
 			/* Handle holes */
 			if (!buffer_mapped(map_bh)) {
 				char *kaddr;
@@ -862,66 +843,41 @@ do_holes:
 					return -ENOTBLK;
 				}
 
-				if (dio->block_in_file >=
-					i_size_read(dio->inode)>>blkbits) {
+				if (dio->file_offset >= dio->i_size) {
 					/* We hit eof */
 					page_cache_release(page);
 					goto out;
 				}
+				/*
+				 * zero out the user buffer to end of page.
+				 */
 				kaddr = kmap_atomic(page, KM_USER0);
-				memset(kaddr + (block_in_page << blkbits),
-						0, 1 << blkbits);
+				memset(kaddr + page_offset, 0, bytes_this_chunk);
 				flush_dcache_page(page);
 				kunmap_atomic(kaddr, KM_USER0);
-				dio->block_in_file++;
-				block_in_page++;
-				goto next_block;
+			} else {
+				/* add some i/o */
+				ret = submit_page_section(dio, page,
+					page_offset, bytes_this_chunk,
+					(map_bh->b_blocknr << (dio->blkbits - 9))
+					+ (fs_offset >> 9));
+				if (ret) {
+					page_cache_release(page);
+					goto out;
+				}
 			}
 
-			/*
-			 * If we're performing IO which has an alignment which
-			 * is finer than the underlying fs, go check to see if
-			 * we must zero out the start of this block.
-			 */
-			if (unlikely(dio->blkfactor && !dio->start_zero_done))
-				dio_zero_block(dio, 0);
-
-			/*
-			 * Work out, in this_chunk_blocks, how much disk we
-			 * can add to this page
-			 */
-			this_chunk_blocks = dio->blocks_available;
-			u = (PAGE_SIZE - offset_in_page) >> blkbits;
-			if (this_chunk_blocks > u)
-				this_chunk_blocks = u;
-			u = dio->final_block_in_request - dio->block_in_file;
-			if (this_chunk_blocks > u)
-				this_chunk_blocks = u;
-			this_chunk_bytes = this_chunk_blocks << blkbits;
-			BUG_ON(this_chunk_bytes == 0);
-
-			dio->boundary = buffer_boundary(map_bh);
-			ret = submit_page_section(dio, page, offset_in_page,
-				this_chunk_bytes, dio->next_block_for_io);
-			if (ret) {
-				page_cache_release(page);
-				goto out;
-			}
-			dio->next_block_for_io += this_chunk_blocks;
+			dio->bytes_available -= bytes_this_chunk;
+			dio->file_offset += bytes_this_chunk;
+			user_addr += bytes_this_chunk;
+			fs_offset += bytes_this_chunk;
 
-			dio->block_in_file += this_chunk_blocks;
-			block_in_page += this_chunk_blocks;
-			dio->blocks_available -= this_chunk_blocks;
-next_block:
-			if (dio->block_in_file > dio->final_block_in_request)
-				BUG();
-			if (dio->block_in_file == dio->final_block_in_request)
+			if (dio->file_offset >= dio->final_file_offset)
 				break;
-		}
+		} while (user_addr & (PAGE_SIZE - 1));
 
 		/* Drop the ref which was taken in get_user_pages() */
 		page_cache_release(page);
-		block_in_page = 0;
 	}
 out:
 	return ret;
@@ -941,16 +897,17 @@ direct_io_worker(int rw, struct kiocb *i
 	ssize_t ret = 0;
 	ssize_t ret2;
 	size_t bytes;
+	unsigned long blkmask = (1 << blkbits) - 1;
+	unsigned fs_offset;
 
 	dio->bio = NULL;
 	dio->inode = inode;
 	dio->rw = rw;
 	dio->blkbits = blkbits;
-	dio->blkfactor = inode->i_blkbits - blkbits;
 	dio->start_zero_done = 0;
 	dio->size = 0;
-	dio->block_in_file = offset >> blkbits;
-	dio->blocks_available = 0;
+	dio->file_offset = offset;
+	dio->bytes_available = 0;
 	dio->cur_page = NULL;
 
 	dio->boundary = 0;
@@ -959,7 +916,6 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->end_io = end_io;
 	dio->map_bh.b_private = NULL;
 	dio->final_block_in_bio = -1;
-	dio->next_block_for_io = -1;
 
 	dio->page_errors = 0;
 	dio->result = 0;
@@ -984,7 +940,8 @@ direct_io_worker(int rw, struct kiocb *i
 	 * In case of non-aligned buffers, we may need 2 more
 	 * pages since we need to zero out first and last block.
 	 */
-	if (unlikely(dio->blkfactor))
+	fs_offset = offset & blkmask;
+	if (unlikely(fs_offset))
 		dio->pages_in_io = 2;
 	else
 		dio->pages_in_io = 0;
@@ -997,13 +954,11 @@ direct_io_worker(int rw, struct kiocb *i
 	}
 
 	for (seg = 0; seg < nr_segs; seg++) {
+		loff_t start_offset;
 		user_addr = (unsigned long)iov[seg].iov_base;
 		dio->size += bytes = iov[seg].iov_len;
 
-		/* Index into the first page of the first block */
-		dio->first_block_in_page = (user_addr & ~PAGE_MASK) >> blkbits;
-		dio->final_block_in_request = dio->block_in_file +
-						(bytes >> blkbits);
+		dio->final_file_offset = dio->file_offset + bytes;
 		/* Page fetching state */
 		dio->head = 0;
 		dio->tail = 0;
@@ -1015,13 +970,16 @@ direct_io_worker(int rw, struct kiocb *i
 			bytes -= PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
 		}
 		dio->total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+		dio->user_addr = 
 		dio->curr_user_address = user_addr;
+		start_offset = dio->file_offset;
 	
 		ret = do_direct_IO(dio);
 
-		dio->result += iov[seg].iov_len -
-			((dio->final_block_in_request - dio->block_in_file) <<
-					blkbits);
+		/*
+		 * Calc bytes transferred for this i/o
+		 */
+		dio->result += (dio->file_offset - start_offset);
 
 		if (ret) {
 			dio_cleanup(dio);
@@ -1198,7 +1156,7 @@ __blockdev_direct_IO(int rw, struct kioc
 			if (bdev)
 				 blkbits = bdev_blkbits;
 			blocksize_mask = (1 << blkbits) - 1;
-			if ((addr & blocksize_mask) || (size & blocksize_mask))  
+			if ((addr & blocksize_mask) || (size & blocksize_mask))
 				goto out;
 		}
 	}
@@ -1256,8 +1214,8 @@ __blockdev_direct_IO(int rw, struct kioc
 	dio->is_async = !is_sync_kiocb(iocb) && !((rw == WRITE) &&
 		(end > i_size_read(inode)));
 
-	retval = direct_io_worker(rw, iocb, inode, iov, offset,
-				nr_segs, blkbits, get_blocks, end_io, dio);
+	retval = direct_io_worker(rw, iocb, inode, iov, offset, nr_segs,
+				inode->i_blkbits, get_blocks, end_io, dio);
 
 	if (rw == READ && dio_lock_type == DIO_LOCKING)
 		reader_with_isem = 0;


