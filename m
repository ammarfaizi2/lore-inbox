Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSGQFWu>; Wed, 17 Jul 2002 01:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318213AbSGQFVK>; Wed, 17 Jul 2002 01:21:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17164 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318221AbSGQFTT>;
	Wed, 17 Jul 2002 01:19:19 -0400
Message-ID: <3D3500DD.CB9398A7@zip.com.au>
Date: Tue, 16 Jul 2002 22:30:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/13] direct_io mopup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Some cleanup from the surprise direct-to-bio for O_DIRECT merge.

- Remove bits and pieces from the kiobuf implementation

- Replace the waitqueue in struct dio with just a task_struct pointer
  and use wake_up_process.  (Ben).

- Only take mmap_sem around the individual calls to get_user_pages().
   (It pins the vmas, yes?)

- Remove some debug code.

- Fix JFS.



 fs/buffer.c        |   49 -------------------------------
 fs/direct-io.c     |   31 +++++--------------
 fs/fcntl.c         |   17 ----------
 fs/file_table.c    |    3 -
 fs/jfs/inode.c     |    7 +---
 fs/open.c          |   11 -------
 include/linux/fs.h |    5 ---
 mm/filemap.c       |   83 -----------------------------------------------------
 8 files changed, 12 insertions(+), 194 deletions(-)

--- 2.5.26/fs/direct-io.c~direct-io-wrapup	Tue Jul 16 21:46:47 2002
+++ 2.5.26-akpm/fs/direct-io.c	Tue Jul 16 21:46:47 2002
@@ -1,5 +1,5 @@
 /*
- * mm/direct-io.c
+ * fs/direct-io.c
  *
  * Copyright (C) 2002, Linus Torvalds.
  *
@@ -61,7 +61,7 @@ struct dio {
 	atomic_t bio_count;
 	spinlock_t bio_list_lock;
 	struct bio *bio_list;		/* singly linked via bi_private */
-	wait_queue_head_t wait_q;
+	struct task_struct *waiter;
 };
 
 /*
@@ -81,6 +81,7 @@ static int dio_refill_pages(struct dio *
 	int nr_pages;
 
 	nr_pages = min(dio->total_pages - dio->curr_page, DIO_PAGES);
+	down_read(&current->mm->mmap_sem);
 	ret = get_user_pages(
 		current,			/* Task for fault acounting */
 		current->mm,			/* whose pages? */
@@ -90,6 +91,7 @@ static int dio_refill_pages(struct dio *
 		0,				/* force (?) */
 		&dio->pages[0],
 		NULL);				/* vmas */
+	up_read(&current->mm->mmap_sem);
 
 	if (ret >= 0) {
 		dio->curr_user_address += ret * PAGE_SIZE;
@@ -139,7 +141,7 @@ static void dio_bio_end_io(struct bio *b
 	bio->bi_private = dio->bio_list;
 	dio->bio_list = bio;
 	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
-	wake_up(&dio->wait_q);
+	wake_up_process(dio->waiter);
 }
 
 static int
@@ -193,13 +195,11 @@ static void dio_cleanup(struct dio *dio)
  */
 static struct bio *dio_await_one(struct dio *dio)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	struct bio *bio;
 
 	spin_lock_irqsave(&dio->bio_list_lock, flags);
 	while (dio->bio_list == NULL) {
-		add_wait_queue(&dio->wait_q, &wait);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (dio->bio_list == NULL) {
 			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
@@ -208,7 +208,6 @@ static struct bio *dio_await_one(struct 
 			spin_lock_irqsave(&dio->bio_list_lock, flags);
 		}
 		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&dio->wait_q, &wait);
 	}
 	bio = dio->bio_list;
 	dio->bio_list = bio->bi_private;
@@ -224,23 +223,17 @@ static int dio_bio_complete(struct dio *
 	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 	struct bio_vec *bvec = bio->bi_io_vec;
 	int page_no;
-	int ret = 0;
 
 	for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
 		struct page *page = bvec[page_no].bv_page;
 
-		if (!uptodate) {
-			if (ret == 0)
-				ret = -EIO;
-		}
-
 		if (dio->rw == READ)
 			set_page_dirty(page);
 		page_cache_release(page);
 	}
 	atomic_dec(&dio->bio_count);
 	bio_put(bio);
-	return ret;
+	return uptodate ? 0 : -EIO;
 }
 
 /*
@@ -265,7 +258,7 @@ static int dio_await_completion(struct d
  * to keep the memory consumption sane we periodically reap any completed BIOs
  * during the BIO generation phase.
  *
- * This also helps to limis the peak amount of pinned userspace memory.
+ * This also helps to limit the peak amount of pinned userspace memory.
  */
 static int dio_bio_reap(struct dio *dio)
 {
@@ -388,15 +381,13 @@ out:
 	return ret;
 }
 
-struct dio *g_dio;
-
 int
 generic_direct_IO(int rw, struct inode *inode, char *buf, loff_t offset,
 			size_t count, get_block_t get_block)
 {
 	const unsigned blocksize_mask = (1 << inode->i_blkbits) - 1;
 	const unsigned long user_addr = (unsigned long)buf;
-	int ret = 0;
+	int ret;
 	int ret2;
 	struct dio dio;
 	size_t bytes;
@@ -407,8 +398,6 @@ generic_direct_IO(int rw, struct inode *
 		goto out;
 	}
 
-	g_dio = &dio;
-
 	/* BIO submission state */
 	dio.bio = NULL;
 	dio.bvec = NULL;
@@ -444,11 +433,9 @@ generic_direct_IO(int rw, struct inode *
 	atomic_set(&dio.bio_count, 0);
 	spin_lock_init(&dio.bio_list_lock);
 	dio.bio_list = NULL;
-	init_waitqueue_head(&dio.wait_q);
+	dio.waiter = current;
 
-	down_read(&current->mm->mmap_sem);
 	ret = do_direct_IO(&dio);
-	up_read(&current->mm->mmap_sem);
 
 	if (dio.bio)
 		dio_bio_submit(&dio);
--- 2.5.26/fs/buffer.c~direct-io-wrapup	Tue Jul 16 21:46:47 2002
+++ 2.5.26-akpm/fs/buffer.c	Tue Jul 16 21:46:47 2002
@@ -2309,55 +2309,6 @@ sector_t generic_block_bmap(struct addre
 	return tmp.b_blocknr;
 }
 
-#if 0
-int generic_direct_IO(int rw, struct inode *inode,
-			struct kiobuf *iobuf, unsigned long blocknr,
-			int blocksize, get_block_t *get_block)
-{
-	int i, nr_blocks, retval = 0;
-	sector_t *blocks = iobuf->blocks;
-	struct block_device *bdev = NULL;
-
-	nr_blocks = iobuf->length / blocksize;
-	/* build the blocklist */
-	for (i = 0; i < nr_blocks; i++, blocknr++) {
-		struct buffer_head bh;
-
-		bh.b_state = 0;
-		bh.b_size = blocksize;
-
-		retval = get_block(inode, blocknr, &bh, rw & 1);
-		if (retval)
-			goto out;
-
-		if (rw == READ) {
-			if (buffer_new(&bh))
-				BUG();
-			if (!buffer_mapped(&bh)) {
-				/* there was an hole in the filesystem */
-				blocks[i] = -1UL;
-				continue;
-			}
-		} else {
-			if (buffer_new(&bh))
-				unmap_underlying_metadata(bh.b_bdev,
-							bh.b_blocknr);
-			if (!buffer_mapped(&bh))
-				BUG();
-		}
-		blocks[i] = bh.b_blocknr;
-		bdev = bh.b_bdev;
-	}
-
-	/* This does not understand multi-device filesystems currently */
-	if (bdev)
-		retval = brw_kiovec(rw, 1, &iobuf, bdev, blocks, blocksize);
-
- out:
-	return retval;
-}
-#endif
-
 /*
  * Start I/O on a physical range of kernel memory, defined by a vector
  * of kiobuf structs (much like a user-space iovec list).
--- 2.5.26/include/linux/fs.h~direct-io-wrapup	Tue Jul 16 21:46:47 2002
+++ 2.5.26-akpm/include/linux/fs.h	Tue Jul 16 21:59:32 2002
@@ -274,7 +274,6 @@ struct iattr {
  */
 struct page;
 struct address_space;
-struct kiobuf;
 
 struct address_space_operations {
 	int (*writepage)(struct page *);
@@ -493,10 +492,6 @@ struct file {
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
-
-	/* preallocated helper kiobuf to speedup O_DIRECT */
-	struct kiobuf		*f_iobuf;
-	long			f_iobuf_lock;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
--- 2.5.26/fs/fcntl.c~direct-io-wrapup	Tue Jul 16 21:46:47 2002
+++ 2.5.26-akpm/fs/fcntl.c	Tue Jul 16 21:46:47 2002
@@ -248,23 +248,6 @@ static int setfl(int fd, struct file * f
 		if (!inode->i_mapping || !inode->i_mapping->a_ops ||
 			!inode->i_mapping->a_ops->direct_IO)
 				return -EINVAL;
-
-		/*
-		 * alloc_kiovec() can sleep and we are only serialized by
-		 * the big kernel lock here, so abuse the i_sem to serialize
-		 * this case too. We of course wouldn't need to go deep down
-		 * to the inode layer, we could stay at the file layer, but
-		 * we don't want to pay for the memory of a semaphore in each
-		 * file structure too and we use the inode semaphore that we just
-		 * pay for anyways.
-		 */
-		error = 0;
-		down(&inode->i_sem);
-		if (!filp->f_iobuf)
-			error = alloc_kiovec(1, &filp->f_iobuf);
-		up(&inode->i_sem);
-		if (error < 0)
-			return error;
 	}
 
 	/* required for strict SunOS emulation */
--- 2.5.26/fs/file_table.c~direct-io-wrapup	Tue Jul 16 21:46:47 2002
+++ 2.5.26-akpm/fs/file_table.c	Tue Jul 16 21:59:32 2002
@@ -115,9 +115,6 @@ void __fput(struct file * file)
 
 	locks_remove_flock(file);
 
-	if (file->f_iobuf)
-		free_kiovec(1, &file->f_iobuf);
-
 	if (file->f_op && file->f_op->release)
 		file->f_op->release(inode, file);
 	fops_put(file->f_op);
--- 2.5.26/fs/open.c~direct-io-wrapup	Tue Jul 16 21:46:47 2002
+++ 2.5.26-akpm/fs/open.c	Tue Jul 16 21:46:47 2002
@@ -647,15 +647,6 @@ struct file *dentry_open(struct dentry *
 	f->f_op = fops_get(inode->i_fop);
 	file_move(f, &inode->i_sb->s_files);
 
-	/* preallocate kiobuf for O_DIRECT */
-	f->f_iobuf = NULL;
-	f->f_iobuf_lock = 0;
-	if (f->f_flags & O_DIRECT) {
-		error = alloc_kiovec(1, &f->f_iobuf);
-		if (error)
-			goto cleanup_all;
-	}
-
 	if (f->f_op && f->f_op->open) {
 		error = f->f_op->open(inode,f);
 		if (error)
@@ -675,8 +666,6 @@ struct file *dentry_open(struct dentry *
 	return f;
 
 cleanup_all:
-	if (f->f_iobuf)
-		free_kiovec(1, &f->f_iobuf);
 	fops_put(f->f_op);
 	if (f->f_mode & FMODE_WRITE)
 		put_write_access(inode);
--- 2.5.26/mm/filemap.c~direct-io-wrapup	Tue Jul 16 21:46:47 2002
+++ 2.5.26-akpm/mm/filemap.c	Tue Jul 16 21:59:37 2002
@@ -1102,89 +1102,6 @@ no_cached_page:
 	UPDATE_ATIME(inode);
 }
 
-#if 0
-static ssize_t generic_file_direct_IO(int rw, struct file * filp, char * buf, size_t count, loff_t offset)
-{
-	ssize_t retval;
-	int new_iobuf, chunk_size, blocksize_mask, blocksize, blocksize_bits, iosize, progress;
-	struct kiobuf * iobuf;
-	struct address_space * mapping = filp->f_dentry->d_inode->i_mapping;
-	struct inode * inode = mapping->host;
-
-	new_iobuf = 0;
-	iobuf = filp->f_iobuf;
-	if (test_and_set_bit(0, &filp->f_iobuf_lock)) {
-		/*
-		 * A parallel read/write is using the preallocated iobuf
-		 * so just run slow and allocate a new one.
-		 */
-		retval = alloc_kiovec(1, &iobuf);
-		if (retval)
-			goto out;
-		new_iobuf = 1;
-	}
-
-	blocksize = 1 << inode->i_blkbits;
-	blocksize_bits = inode->i_blkbits;
-	blocksize_mask = blocksize - 1;
-	chunk_size = KIO_MAX_ATOMIC_IO << 10;
-
-	retval = -EINVAL;
-	if ((offset & blocksize_mask) || (count & blocksize_mask))
-		goto out_free;
-
-	/*
-	 * Flush to disk exclusively the _data_, metadata must remain
-	 * completly asynchronous or performance will go to /dev/null.
-	 */
-	retval = filemap_fdatawait(mapping);
-	if (retval == 0)
-		retval = filemap_fdatawrite(mapping);
-	if (retval == 0)
-		retval = filemap_fdatawait(mapping);
-	if (retval < 0)
-		goto out_free;
-
-	progress = retval = 0;
-	while (count > 0) {
-		iosize = count;
-		if (iosize > chunk_size)
-			iosize = chunk_size;
-
-		retval = map_user_kiobuf(rw, iobuf, (unsigned long) buf, iosize);
-		if (retval)
-			break;
-
-		retval = mapping->a_ops->direct_IO(rw, inode, iobuf, (offset+progress) >> blocksize_bits, blocksize);
-
-		if (rw == READ && retval > 0)
-			mark_dirty_kiobuf(iobuf, retval);
-		
-		if (retval >= 0) {
-			count -= retval;
-			buf += retval;
-			progress += retval;
-		}
-
-		unmap_kiobuf(iobuf);
-
-		if (retval != iosize)
-			break;
-	}
-
-	if (progress)
-		retval = progress;
-
- out_free:
-	if (!new_iobuf)
-		clear_bit(0, &filp->f_iobuf_lock);
-	else
-		free_kiovec(1, &iobuf);
- out:	
-	return retval;
-}
-#endif
-
 int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	char *kaddr;
--- 2.5.26/fs/jfs/inode.c~direct-io-wrapup	Tue Jul 16 21:46:47 2002
+++ 2.5.26-akpm/fs/jfs/inode.c	Tue Jul 16 21:46:47 2002
@@ -293,11 +293,10 @@ static int jfs_bmap(struct address_space
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
-static int jfs_direct_IO(int rw, struct inode *inode, struct kiobuf *iobuf,
-			 unsigned long blocknr, int blocksize)
+static int jfs_direct_IO(int rw, struct inode *inode, char *buf,
+			loff_t offset, size_t count)
 {
-	return generic_direct_IO(rw, inode, iobuf, blocknr,
-				 blocksize, jfs_get_block);
+	return generic_direct_IO(rw, inode, buf, offset, count, jfs_get_block);
 }
 
 struct address_space_operations jfs_aops = {

.
