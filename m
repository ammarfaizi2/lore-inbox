Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263599AbSITWOd>; Fri, 20 Sep 2002 18:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263613AbSITWOd>; Fri, 20 Sep 2002 18:14:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43149 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263599AbSITWOZ>;
	Fri, 20 Sep 2002 18:14:25 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209202219.g8KMJ2x26455@eng2.beaverton.ibm.com>
Subject: [RFC][PATCH] 2.5.37 patch for making DIO async
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Date: Fri, 20 Sep 2002 15:19:02 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is 2.5.37 patch for making DIO code async. Waiting for IO completion
will be done at the higher level. This patch adds support for RAW Async IO.
We already posted performance comparisions numbers earlier on 2.5.35.

ISSUE: This patch does set_page_dirty() on a page, from the interrupt 
handler (io completion handler). Which is NOT safe.  Any suggestions
on (where and how to) moving this outside the interrupt handler ?
Ben & Andrew, any ideas ?

Thanks,
Badari


diff -Naur -X dontdiff linux-2.5.37/drivers/char/raw.c linux-2.5.37-aio/drivers/char/raw.c
--- linux-2.5.37/drivers/char/raw.c	Fri Sep 20 08:20:30 2002
+++ linux-2.5.37-aio/drivers/char/raw.c	Fri Sep 20 14:01:05 2002
@@ -201,8 +201,9 @@
 }
 
 static ssize_t
-rw_raw_dev(int rw, struct file *filp, const struct iovec *iov, unsigned long nr_segs, loff_t *offp)
+rw_raw_aio_dev(int rw, struct kiocb *iocb, const struct iovec *iov, unsigned long nr_segs, loff_t *offp)
 {
+	struct file *filp = iocb->ki_filp;
 	const int minor = minor(filp->f_dentry->d_inode->i_rdev);
 	struct block_device *bdev = raw_devices[minor].binding;
 	struct inode *inode = bdev->bd_inode;
@@ -222,11 +223,24 @@
 		count = inode->i_size - *offp;
 		nr_segs = iov_shorten((struct iovec *)iov, nr_segs, count);
 	}
-	ret = generic_file_direct_IO(rw, inode, iov, *offp, nr_segs);
+	ret = generic_file_direct_IO(rw, iocb, inode, iov, *offp, nr_segs);
+
+out:
+	return ret;
+}
 
+static ssize_t
+rw_raw_dev(int rw, struct file *filp, const struct iovec *iov, unsigned long nr_segs, loff_t *offp)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	ret = rw_raw_aio_dev(rw, &kiocb, iov, nr_segs, offp);
+	if (-EIOCBQUEUED == ret) 
+		ret = wait_on_sync_kiocb(&kiocb);
 	if (ret > 0)
 		*offp += ret;
-out:
 	return ret;
 }
 
@@ -246,6 +260,22 @@
 	return rw_raw_dev(WRITE, filp, &local_iov, 1, offp);
 }
 
+static ssize_t
+raw_aio_read(struct kiocb *iocb, char *buf, size_t size, loff_t offp)
+{
+	struct iovec local_iov = { .iov_base = buf, .iov_len = size};
+
+	return rw_raw_aio_dev(READ, iocb, &local_iov, 1, &offp);
+}
+
+static ssize_t
+raw_aio_write(struct kiocb *iocb, char *buf, size_t size, loff_t *offp)
+{
+	struct iovec local_iov = { .iov_base = buf, .iov_len = size};
+
+	return rw_raw_aio_dev(WRITE, iocb, &local_iov, 1, &offp);
+}
+
 static ssize_t 
 raw_readv(struct file *filp, const struct iovec *iov, unsigned long nr_segs, loff_t *offp) 
 {
@@ -260,7 +290,9 @@
 
 static struct file_operations raw_fops = {
 	.read	=	raw_read,
+	.aio_read=	raw_aio_read,
 	.write	=	raw_write,
+	.aio_write=	raw_aio_write,
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
diff -Naur -X dontdiff linux-2.5.37/fs/aio.c linux-2.5.37-aio/fs/aio.c
--- linux-2.5.37/fs/aio.c	Fri Sep 20 08:20:25 2002
+++ linux-2.5.37-aio/fs/aio.c	Fri Sep 20 13:38:39 2002
@@ -318,6 +318,7 @@
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!iocb->ki_users)
 			break;
+		blk_run_queues();
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -399,8 +400,10 @@
 		req->ki_user_obj = NULL;
 		req->ki_ctx = ctx;
 		req->ki_users = 1;
-	} else
+	} else {
 		kmem_cache_free(kiocb_cachep, req);
+		req = NULL;
+	}
 	kunmap_atomic(ring, KM_USER0);
 	spin_unlock_irq(&ctx->ctx_lock);
 
@@ -980,7 +983,7 @@
 		ret = -EINVAL;
 	}
 
-	if (likely(EIOCBQUEUED == ret))
+	if (likely(-EIOCBQUEUED == ret))
 		return 0;
 	if (ret >= 0) {
 		aio_complete(req, ret, 0);
@@ -1042,6 +1045,7 @@
 	}
 
 	put_ioctx(ctx);
+	blk_run_queues();
 	return i ? i : ret;
 }
 
diff -Naur -X dontdiff linux-2.5.37/fs/block_dev.c linux-2.5.37-aio/fs/block_dev.c
--- linux-2.5.37/fs/block_dev.c	Fri Sep 20 08:20:37 2002
+++ linux-2.5.37-aio/fs/block_dev.c	Fri Sep 20 13:38:39 2002
@@ -116,10 +116,10 @@
 }
 
 static int
-blkdev_direct_IO(int rw, struct inode *inode, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs)
+blkdev_direct_IO(int rw, struct kiocb *iocb, struct inode * inode, 
+		const struct iovec *iov, loff_t offset, unsigned long nr_segs)
 {
-	return generic_direct_IO(rw, inode, iov, offset,
+	return generic_direct_IO(rw, iocb, inode, iov, offset,
 				nr_segs, blkdev_get_blocks);
 }
 
diff -Naur -X dontdiff linux-2.5.37/fs/direct-io.c linux-2.5.37-aio/fs/direct-io.c
--- linux-2.5.37/fs/direct-io.c	Fri Sep 20 08:20:30 2002
+++ linux-2.5.37-aio/fs/direct-io.c	Fri Sep 20 14:52:44 2002
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/buffer_head.h>
 #include <linux/rwsem.h>
+#include <linux/slab.h>
 #include <asm/atomic.h>
 
 /*
@@ -46,7 +47,6 @@
 	sector_t final_block_in_request;/* doesn't change */
 	unsigned first_block_in_page;	/* doesn't change, Used only once */
 	int boundary;			/* prev block is at a boundary */
-	int reap_counter;		/* rate limit reaping */
 	get_blocks_t *get_blocks;	/* block mapping function */
 	sector_t last_block_in_bio;	/* current final block in bio */
 	sector_t next_block_in_bio;	/* next block to be added to bio */
@@ -65,9 +65,9 @@
 
 	/* BIO completion state */
 	atomic_t bio_count;		/* nr bios in flight */
-	spinlock_t bio_list_lock;	/* protects bio_list */
-	struct bio *bio_list;		/* singly linked via bi_private */
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
+	struct kiocb *iocb;		/* iocb ptr */
+	int results;
 };
 
 /*
@@ -144,27 +144,41 @@
 	return dio->pages[dio->head++];
 }
 
+static void dio_bio_count(struct dio *dio)
+{
+	if (atomic_dec_and_test(&dio->bio_count)) {
+		aio_complete(dio->iocb, dio->results, 0);
+		if (dio->waiter)
+			wake_up_process(dio->waiter);
+		kfree(dio);
+	}
+}
+
 /*
- * The BIO completion handler simply queues the BIO up for the process-context
- * handler.
- *
- * During I/O bi_private points at the dio.  After I/O, bi_private is used to
- * implement a singly-linked list of completed BIOs, at dio->bio_list.
+ * The BIO completion handler 
  */
-static int dio_bio_end_io(struct bio *bio, unsigned int bytes_done, int error)
+static int dio_bio_end_aio(struct bio *bio, unsigned int bytes_done, int error)
 {
 	struct dio *dio = bio->bi_private;
-	unsigned long flags;
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio_vec *bvec = bio->bi_io_vec;
+	int page_no;
 
 	if (bio->bi_size)
 		return 1;
 
-	spin_lock_irqsave(&dio->bio_list_lock, flags);
-	bio->bi_private = dio->bio_list;
-	dio->bio_list = bio;
-	if (dio->waiter)
-		wake_up_process(dio->waiter);
-	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+	for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
+		struct page *page = bvec[page_no].bv_page;
+
+		if (dio->rw == READ)
+			set_page_dirty(page);
+		page_cache_release(page);
+	}
+	if (!uptodate) 
+		dio->results = -EIO;
+
+	dio_bio_count(dio);
+	bio_put(bio);
 	return 0;
 }
 
@@ -184,7 +198,7 @@
 	bio->bi_size = 0;
 	bio->bi_sector = first_sector;
 	bio->bi_io_vec[0].bv_page = NULL;
-	bio->bi_end_io = dio_bio_end_io;
+	bio->bi_end_io = dio_bio_end_aio;
 
 	dio->bio = bio;
 	dio->bvec = NULL;		/* debug */
@@ -216,102 +230,6 @@
 }
 
 /*
- * Wait for the next BIO to complete.  Remove it and return it.
- */
-static struct bio *dio_await_one(struct dio *dio)
-{
-	unsigned long flags;
-	struct bio *bio;
-
-	spin_lock_irqsave(&dio->bio_list_lock, flags);
-	while (dio->bio_list == NULL) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (dio->bio_list == NULL) {
-			dio->waiter = current;
-			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
-			blk_run_queues();
-			schedule();
-			spin_lock_irqsave(&dio->bio_list_lock, flags);
-			dio->waiter = NULL;
-		}
-		set_current_state(TASK_RUNNING);
-	}
-	bio = dio->bio_list;
-	dio->bio_list = bio->bi_private;
-	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
-	return bio;
-}
-
-/*
- * Process one completed BIO.  No locks are held.
- */
-static int dio_bio_complete(struct dio *dio, struct bio *bio)
-{
-	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
-	struct bio_vec *bvec = bio->bi_io_vec;
-	int page_no;
-
-	for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
-		struct page *page = bvec[page_no].bv_page;
-
-		if (dio->rw == READ)
-			set_page_dirty(page);
-		page_cache_release(page);
-	}
-	atomic_dec(&dio->bio_count);
-	bio_put(bio);
-	return uptodate ? 0 : -EIO;
-}
-
-/*
- * Wait on and process all in-flight BIOs.
- */
-static int dio_await_completion(struct dio *dio)
-{
-	int ret = 0;
-
-	if (dio->bio)
-		dio_bio_submit(dio);
-
-	while (atomic_read(&dio->bio_count)) {
-		struct bio *bio = dio_await_one(dio);
-		int ret2;
-
-		ret2 = dio_bio_complete(dio, bio);
-		if (ret == 0)
-			ret = ret2;
-	}
-	return ret;
-}
-
-/*
- * A really large O_DIRECT read or write can generate a lot of BIOs.  So
- * to keep the memory consumption sane we periodically reap any completed BIOs
- * during the BIO generation phase.
- *
- * This also helps to limit the peak amount of pinned userspace memory.
- */
-static int dio_bio_reap(struct dio *dio)
-{
-	int ret = 0;
-
-	if (dio->reap_counter++ >= 64) {
-		while (dio->bio_list) {
-			unsigned long flags;
-			struct bio *bio;
-
-			spin_lock_irqsave(&dio->bio_list_lock, flags);
-			bio = dio->bio_list;
-			dio->bio_list = bio->bi_private;
-			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
-			ret = dio_bio_complete(dio, bio);
-		}
-		dio->reap_counter = 0;
-	}
-	return ret;
-}
-
-/*
  * Call into the fs to map some more disk blocks.  We record the current number
  * of available blocks at dio->blocks_available.  These are in units of the
  * fs blocksize, (1 << inode->i_blkbits).
@@ -407,9 +325,6 @@
 	sector_t sector;
 	int ret;
 
-	ret = dio_bio_reap(dio);
-	if (ret)
-		goto out;
 	sector = dio->next_block_in_bio << (dio->blkbits - 9);
 	ret = dio_bio_alloc(dio, dio->map_bh.b_bdev, sector,
 				DIO_BIO_MAX_SIZE / PAGE_SIZE);
@@ -532,77 +447,84 @@
 }
 
 int
-direct_io_worker(int rw, struct inode *inode, const struct iovec *iov, 
-	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks)
+direct_io_worker(int rw, struct kiocb *iocb, struct inode * inode, 
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
+	get_blocks_t get_blocks)
 {
 	const unsigned blkbits = inode->i_blkbits;
 	unsigned long user_addr; 
-	int seg, ret2, ret = 0;
-	struct dio dio;
-	size_t bytes, tot_bytes = 0;
-
-	dio.bio = NULL;
-	dio.bvec = NULL;
-	dio.inode = inode;
-	dio.rw = rw;
-	dio.blkbits = blkbits;
-	dio.block_in_file = offset >> blkbits;
-	dio.blocks_available = 0;
-
-	dio.boundary = 0;
-	dio.reap_counter = 0;
-	dio.get_blocks = get_blocks;
-	dio.last_block_in_bio = -1;
-	dio.next_block_in_bio = -1;
+	int seg, ret = 0;
+	struct dio *dio;
+	size_t bytes;
 
-	dio.page_errors = 0;
+	dio = (struct dio *)kmalloc(sizeof(struct dio), GFP_KERNEL);
+	if (!dio)
+		return -ENOMEM;
+
+	dio->bio = NULL;
+	dio->bvec = NULL;
+	dio->inode = inode;
+	dio->iocb = iocb;
+	dio->rw = rw;
+	dio->blkbits = blkbits;
+	dio->block_in_file = offset >> blkbits;
+	dio->blocks_available = 0;
+
+	dio->results = 0;
+	dio->boundary = 0;
+	dio->get_blocks = get_blocks;
+	dio->last_block_in_bio = -1;
+	dio->next_block_in_bio = -1;
+
+	dio->page_errors = 0;
 
 	/* BIO completion state */
-	atomic_set(&dio.bio_count, 0);
-	spin_lock_init(&dio.bio_list_lock);
-	dio.bio_list = NULL;
-	dio.waiter = NULL;
+	atomic_set(&dio->bio_count, 1);
+	dio->waiter = NULL;
 
 	for (seg = 0; seg < nr_segs; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
 		bytes = iov[seg].iov_len;
 
 		/* Index into the first page of the first block */
-		dio.first_block_in_page = (user_addr & (PAGE_SIZE - 1)) >> blkbits;
-		dio.final_block_in_request = dio.block_in_file + (bytes >> blkbits);
+		dio->first_block_in_page = (user_addr & (PAGE_SIZE - 1)) >> blkbits;
+		dio->final_block_in_request = dio->block_in_file + (bytes >> blkbits);
 		/* Page fetching state */
-		dio.head = 0;
-		dio.tail = 0;
-		dio.curr_page = 0;
+		dio->head = 0;
+		dio->tail = 0;
+		dio->curr_page = 0;
 
-		dio.total_pages = 0;
+		dio->total_pages = 0;
 		if (user_addr & (PAGE_SIZE-1)) {
-			dio.total_pages++;
+			dio->total_pages++;
 			bytes -= PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
 		}
-		dio.total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
-		dio.curr_user_address = user_addr;
+		dio->total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+		dio->curr_user_address = user_addr;
 	
-		ret = do_direct_IO(&dio);
+		ret = do_direct_IO(dio);
 
 		if (ret) {
-			dio_cleanup(&dio);
+			dio_cleanup(dio);
 			break;
 		}
 
-		tot_bytes += iov[seg].iov_len - ((dio.final_block_in_request -
-					dio.block_in_file) << blkbits);
+		dio->results += iov[seg].iov_len - ((dio->final_block_in_request -
+					dio->block_in_file) << blkbits);
 
 	} /* end iovec loop */
 
-	ret2 = dio_await_completion(&dio);
-	if (ret == 0)
-		ret = ret2;
-	if (ret == 0)
-		ret = dio.page_errors;
-	if (ret == 0)
-		ret = tot_bytes; 
+	if (dio->bio)
+                dio_bio_submit(dio);
 
+	if (ret == 0)
+		ret = dio->page_errors;
+	if (ret == 0) {
+		if (iocb->ki_key == KIOCB_SYNC_KEY)
+			dio->waiter = current;
+		ret = -EIOCBQUEUED;
+	}
+	dio_bio_count(dio);
 	return ret;
 }
 
@@ -610,8 +532,9 @@
  * This is a library function for use by filesystem drivers.
  */
 int
-generic_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
-	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks)
+generic_direct_IO(int rw, struct kiocb *iocb, struct inode *inode, 
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
+	get_blocks_t get_blocks)
 {
 	int seg;
 	size_t size;
@@ -640,19 +563,21 @@
 			goto out;
 	}
 
-	retval = direct_io_worker(rw, inode, iov, offset, nr_segs, get_blocks);
+	retval = direct_io_worker(rw, iocb, inode, iov, offset, 
+				nr_segs, get_blocks);
 out:
 	return retval;
 }
 
 ssize_t
-generic_file_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
-	loff_t offset, unsigned long nr_segs)
+generic_file_direct_IO(int rw, struct  kiocb *iocb, struct inode *inode, 
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs)
 {
 	struct address_space *mapping = inode->i_mapping;
 	ssize_t retval;
 
-	retval = mapping->a_ops->direct_IO(rw, inode, iov, offset, nr_segs);
+	retval = mapping->a_ops->direct_IO(rw, iocb, inode, iov, 
+						offset, nr_segs);
 	if (inode->i_mapping->nrpages)
 		invalidate_inode_pages2(inode->i_mapping);
 	return retval;
diff -Naur -X dontdiff linux-2.5.37/fs/ext2/inode.c linux-2.5.37-aio/fs/ext2/inode.c
--- linux-2.5.37/fs/ext2/inode.c	Fri Sep 20 08:20:15 2002
+++ linux-2.5.37-aio/fs/ext2/inode.c	Fri Sep 20 13:38:39 2002
@@ -619,10 +619,10 @@
 }
 
 static int
-ext2_direct_IO(int rw, struct inode *inode, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs)
+ext2_direct_IO(int rw, struct kiocb *iocb, struct inode *inode, 
+		const struct iovec *iov,loff_t offset, unsigned long nr_segs)
 {
-	return generic_direct_IO(rw, inode, iov,
+	return generic_direct_IO(rw, iocb, inode, iov,
 				offset, nr_segs, ext2_get_blocks);
 }
 
diff -Naur -X dontdiff linux-2.5.37/fs/ext3/inode.c linux-2.5.37-aio/fs/ext3/inode.c
--- linux-2.5.37/fs/ext3/inode.c	Fri Sep 20 08:20:31 2002
+++ linux-2.5.37-aio/fs/ext3/inode.c	Fri Sep 20 13:38:39 2002
@@ -1399,7 +1399,7 @@
  * If the O_DIRECT write is intantiating holes inside i_size and the machine
  * crashes then stale disk data _may_ be exposed inside the file.
  */
-static int ext3_direct_IO(int rw, struct inode *inode,
+static int ext3_direct_IO(int rw, struct kiocb *iocb, struct inode * inode,
 			const struct iovec *iov, loff_t offset,
 			unsigned long nr_segs)
 {
@@ -1430,7 +1430,7 @@
 		}
 	}
 
-	ret = generic_direct_IO(rw, inode, iov, offset,
+	ret = generic_direct_IO(rw, iocb, inode, iov, offset,
 				nr_segs, ext3_direct_io_get_blocks);
 
 out_stop:
diff -Naur -X dontdiff linux-2.5.37/fs/jfs/inode.c linux-2.5.37-aio/fs/jfs/inode.c
--- linux-2.5.37/fs/jfs/inode.c	Fri Sep 20 08:20:13 2002
+++ linux-2.5.37-aio/fs/jfs/inode.c	Fri Sep 20 13:38:39 2002
@@ -310,10 +310,11 @@
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
-static int jfs_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
-			loff_t offset, unsigned long nr_segs)
+static int jfs_direct_IO(int rw, struct kiocb *iocb, struct inode *inode, 
+			const struct iovec *iov, loff_t offset, 
+			unsigned long nr_segs)
 {
-	return generic_direct_IO(rw, inode, iov,
+	return generic_direct_IO(rw, iocb, inode, iov,
 				offset, nr_segs, jfs_get_blocks);
 }
 
diff -Naur -X dontdiff linux-2.5.37/include/linux/aio.h linux-2.5.37-aio/include/linux/aio.h
--- linux-2.5.37/include/linux/aio.h	Fri Sep 20 08:20:14 2002
+++ linux-2.5.37-aio/include/linux/aio.h	Fri Sep 20 13:38:39 2002
@@ -25,7 +25,7 @@
 #define KIOCB_PRIVATE_SIZE	(16 * sizeof(long))
 
 struct kiocb {
-	int			ki_users;
+	volatile int		ki_users;
 	unsigned		ki_key;		/* id of this request */
 
 	struct file		*ki_filp;
diff -Naur -X dontdiff linux-2.5.37/include/linux/fs.h linux-2.5.37-aio/include/linux/fs.h
--- linux-2.5.37/include/linux/fs.h	Fri Sep 20 08:20:21 2002
+++ linux-2.5.37-aio/include/linux/fs.h	Fri Sep 20 13:41:25 2002
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/radix-tree.h>
 #include <linux/bitops.h>
+#include <linux/fs.h>
 
 #include <asm/atomic.h>
 
@@ -279,6 +280,7 @@
  */
 struct page;
 struct address_space;
+struct kiocb;
 struct writeback_control;
 
 struct address_space_operations {
@@ -308,7 +310,7 @@
 	int (*bmap)(struct address_space *, long);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-	int (*direct_IO)(int, struct inode *, const struct iovec *iov, loff_t offset, unsigned long nr_segs);
+	int (*direct_IO)(int, struct kiocb *, struct inode *, const struct iovec *iov, loff_t offset, unsigned long nr_segs);
 };
 
 struct backing_dev_info;
@@ -744,7 +746,6 @@
  * read, write, poll, fsync, readv, writev can be called
  *   without the big kernel lock held in all filesystems.
  */
-struct kiocb;
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -1247,10 +1248,10 @@
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, struct file *, loff_t *, size_t);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
-extern ssize_t generic_file_direct_IO(int rw, struct inode *inode, 
-	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
-extern int generic_direct_IO(int rw, struct inode *inode, const struct iovec 
-	*iov, loff_t offset, unsigned long nr_segs, get_blocks_t *get_blocks);
+extern ssize_t generic_file_direct_IO(int rw, struct kiocb *iocb, struct inode *	 inode,	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
+extern int generic_direct_IO(int rw, struct kiocb *iocb, struct inode * inode, 
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
+	get_blocks_t *get_blocks);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
 	unsigned long nr_segs, loff_t *ppos);
 ssize_t generic_file_writev(struct file *filp, const struct iovec *iov, 
diff -Naur -X dontdiff linux-2.5.37/mm/filemap.c linux-2.5.37-aio/mm/filemap.c
--- linux-2.5.37/mm/filemap.c	Fri Sep 20 08:20:23 2002
+++ linux-2.5.37-aio/mm/filemap.c	Fri Sep 20 13:57:36 2002
@@ -1173,7 +1173,7 @@
 				nr_segs = iov_shorten((struct iovec *)iov,
 							nr_segs, count);
 			}
-			retval = generic_file_direct_IO(READ, inode, 
+			retval = generic_file_direct_IO(READ, iocb, inode, 
 					iov, pos, nr_segs);
 			if (retval > 0)
 				*ppos = pos + retval;
@@ -1224,6 +1224,16 @@
 	ret = __generic_file_aio_read(&kiocb, &local_iov, 1, ppos);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
+
+	/* FIXME: Need to update f_pos and ATIME. But do_generic_file_read() 
+	 * is already updating them for buffered IO. Needs to fix this
+	 * when we make do_generic_file_read() async.
+	 */
+	if ((filp->f_flags & O_DIRECT) && (ret > 0)) {
+		*ppos += ret;
+		UPDATE_ATIME(filp->f_dentry->d_inode);
+	}
+
 	return ret;
 }
 
@@ -1730,6 +1740,9 @@
 	unsigned	iov_base = 0;	   /* offset in the current iovec */
 	unsigned long	seg;
 	char		*buf;
+	struct  kiocb   kiocb;
+
+	init_sync_kiocb(&kiocb, file);	
 
 	ocount = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
@@ -1852,8 +1865,14 @@
 		if (count != ocount)
 			nr_segs = iov_shorten((struct iovec *)iov,
 						nr_segs, count);
-		written = generic_file_direct_IO(WRITE, inode, 
+		written = generic_file_direct_IO(WRITE, &kiocb, inode, 
 					iov, pos, nr_segs);
+		/* FIXME: waiting for IO completion has to be done higher level
+		 * But generic_file_write/generic_file_writev are not changed yet.
+		 */
+		if (written == -EIOCBQUEUED)
+			written = wait_on_sync_kiocb(&kiocb);
+		
 		if (written > 0) {
 			loff_t end = pos + written;
 			if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {

