Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264568AbSIQU6m>; Tue, 17 Sep 2002 16:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264569AbSIQU6m>; Tue, 17 Sep 2002 16:58:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40920 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264568AbSIQU6U>; Tue, 17 Sep 2002 16:58:20 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209172103.g8HL33N15574@eng2.beaverton.ibm.com>
Subject: [RFC] [PATCH] 2.5.35 patch for making DIO async
To: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Date: Tue, 17 Sep 2002 14:03:02 -0700 (PDT)
Cc: pbadari@us.ibm.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Here is a 2.5.35 patch to make DIO async. Basically, DIO does not
wait for io completion. Waiting will be done at the higher level
(same way generic_file_read does).

Here is what I did:

1) pass kiocb *iocb to DIO
2) allocated a "dio" (instead of using stack)
3) after submitting bios, dio code returns with -EIOCBQUEUED
4) removed dio_bio_end_io(), dio_await_one(), dio_await_completion()
5) added dio_bio_end_aio() which calls dio_bio_complete() for
   each bio and if the dio_biocount becomes 0, it calls aio_complete()
6) changed raw_read/raw_write/.. routines to pass a sync_cb and wait
   on it.

Any feedback on approach/patch is appreciated.

Thanks,
Badari

diff -Naur -X dontdiff linux-2.5.35/drivers/char/raw.c linux-2.5.35.aio/drivers/char/raw.c
--- linux-2.5.35/drivers/char/raw.c	Sun Sep 15 19:18:37 2002
+++ linux-2.5.35.aio/drivers/char/raw.c	Tue Sep 17 09:00:39 2002
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
@@ -222,7 +223,7 @@
 		count = inode->i_size - *offp;
 		nr_segs = iov_shorten((struct iovec *)iov, nr_segs, count);
 	}
-	ret = generic_file_direct_IO(rw, inode, iov, *offp, nr_segs);
+	ret = generic_file_direct_IO(rw, iocb, inode, iov, *offp, nr_segs);
 
 	if (ret > 0)
 		*offp += ret;
@@ -231,6 +232,19 @@
 }
 
 static ssize_t
+rw_raw_dev(int rw, struct file *filp, const struct iovec *iov, unsigned long nr_segs, loff_t *offp)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	ret = rw_raw_aio_dev(rw, &kiocb, iov, nr_segs, offp);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	return ret;
+}
+
+static ssize_t
 raw_read(struct file *filp, char *buf, size_t size, loff_t *offp)
 {
 	struct iovec local_iov = { .iov_base = buf, .iov_len = size};
@@ -246,6 +260,21 @@
 	return rw_raw_dev(WRITE, filp, &local_iov, 1, offp);
 }
 
+static ssize_t
+raw_aio_read(struct kiocb *iocb, const char *buf, size_t size, loff_t *offp)
+{
+	struct iovec local_iov = { .iov_base = buf, .iov_len = size};
+
+	return rw_raw_aio_dev(READ, iocb, &local_iov, 1, offp);
+}
+
+static ssize_t
+raw_aio_write(struct kiocb *iocb, const char *buf, size_t size, loff_t *offp)
+{
+	struct iovec local_iov = { .iov_base = buf, .iov_len = size};
+
+	return rw_raw_aio_dev(WRITE, iocb, &local_iov, 1, offp);
+}
 static ssize_t 
 raw_readv(struct file *filp, const struct iovec *iov, unsigned long nr_segs, loff_t *offp) 
 {
@@ -260,7 +289,9 @@
 
 static struct file_operations raw_fops = {
 	.read	=	raw_read,
+	.aio_read=	raw_aio_read,
 	.write	=	raw_write,
+	.aio_write=	raw_aio_write,
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
diff -Naur -X dontdiff linux-2.5.35/fs/block_dev.c linux-2.5.35.aio/fs/block_dev.c
--- linux-2.5.35/fs/block_dev.c	Sun Sep 15 19:19:09 2002
+++ linux-2.5.35.aio/fs/block_dev.c	Tue Sep 17 09:00:26 2002
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
 
diff -Naur -X dontdiff linux-2.5.35/fs/direct-io.c linux-2.5.35.aio/fs/direct-io.c
--- linux-2.5.35/fs/direct-io.c	Sun Sep 15 19:18:30 2002
+++ linux-2.5.35.aio/fs/direct-io.c	Tue Sep 17 09:48:16 2002
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/buffer_head.h>
 #include <linux/rwsem.h>
+#include <linux/slab.h>
 #include <asm/atomic.h>
 
 /*
@@ -68,6 +69,8 @@
 	spinlock_t bio_list_lock;	/* protects bio_list */
 	struct bio *bio_list;		/* singly linked via bi_private */
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
+	struct kiocb *iocb;		/* iocb ptr */
+	int results;
 };
 
 /*
@@ -145,25 +148,41 @@
 }
 
 /*
- * The BIO completion handler simply queues the BIO up for the process-context
- * handler.
- *
- * During I/O bi_private points at the dio.  After I/O, bi_private is used to
- * implement a singly-linked list of completed BIOs, at dio->bio_list.
+ * Process one completed BIO.  No locks are held.
  */
-static void dio_bio_end_io(struct bio *bio)
+static int dio_bio_complete(struct dio *dio, struct bio *bio)
 {
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio_vec *bvec = bio->bi_io_vec;
+	int page_no;
+
+	for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
+		struct page *page = bvec[page_no].bv_page;
+
+		if (dio->rw == READ)
+			set_page_dirty(page);
+		page_cache_release(page);
+	}
+	atomic_dec(&dio->bio_count);
+	bio_put(bio);
+	return uptodate ? 0 : -EIO;
+}
+
+static void dio_bio_end_aio(struct bio *bio)
+{
+	int ret;
 	struct dio *dio = bio->bi_private;
-	unsigned long flags;
+	ret = dio_bio_complete(dio, bio);
+	if (ret)
+		dio->results = ret;
 
-	spin_lock_irqsave(&dio->bio_list_lock, flags);
-	bio->bi_private = dio->bio_list;
-	dio->bio_list = bio;
-	if (dio->waiter)
-		wake_up_process(dio->waiter);
-	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+	if (atomic_read(&dio->bio_count) == 0) {
+		aio_complete(dio->iocb, dio->results, 0);
+		kfree(dio);
+	}
 }
 
+
 static int
 dio_bio_alloc(struct dio *dio, struct block_device *bdev,
 		sector_t first_sector, int nr_vecs)
@@ -180,7 +199,7 @@
 	bio->bi_size = 0;
 	bio->bi_sector = first_sector;
 	bio->bi_io_vec[0].bv_page = NULL;
-	bio->bi_end_io = dio_bio_end_io;
+	bio->bi_end_io = dio_bio_end_aio;
 
 	dio->bio = bio;
 	dio->bvec = NULL;		/* debug */
@@ -212,75 +231,6 @@
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
  * A really large O_DIRECT read or write can generate a lot of BIOs.  So
  * to keep the memory consumption sane we periodically reap any completed BIOs
  * during the BIO generation phase.
@@ -528,77 +478,83 @@
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
+
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
 
-	dio.page_errors = 0;
+	dio->results = 0;
+	dio->boundary = 0;
+	dio->reap_counter = 0;
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
+	atomic_set(&dio->bio_count, 0);
+	spin_lock_init(&dio->bio_list_lock);
+	dio->bio_list = NULL;
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
+	if (dio->bio)
+                dio_bio_submit(dio);
+
 	if (ret == 0)
-		ret = dio.page_errors;
+		ret = dio->page_errors;
 	if (ret == 0)
-		ret = tot_bytes; 
-
+		ret = -EIOCBQUEUED;
 	return ret;
 }
 
@@ -606,8 +562,9 @@
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
@@ -636,19 +593,21 @@
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
diff -Naur -X dontdiff linux-2.5.35/fs/ext2/inode.c linux-2.5.35.aio/fs/ext2/inode.c
--- linux-2.5.35/fs/ext2/inode.c	Sun Sep 15 19:18:19 2002
+++ linux-2.5.35.aio/fs/ext2/inode.c	Tue Sep 17 09:00:26 2002
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
 
diff -Naur -X dontdiff linux-2.5.35/fs/ext3/inode.c linux-2.5.35.aio/fs/ext3/inode.c
--- linux-2.5.35/fs/ext3/inode.c	Sun Sep 15 19:18:41 2002
+++ linux-2.5.35.aio/fs/ext3/inode.c	Tue Sep 17 09:00:26 2002
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
diff -Naur -X dontdiff linux-2.5.35/fs/jfs/inode.c linux-2.5.35.aio/fs/jfs/inode.c
--- linux-2.5.35/fs/jfs/inode.c	Sun Sep 15 19:18:15 2002
+++ linux-2.5.35.aio/fs/jfs/inode.c	Tue Sep 17 09:00:26 2002
@@ -309,10 +309,11 @@
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
 
diff -Naur -X dontdiff linux-2.5.35/include/linux/fs.h linux-2.5.35.aio/include/linux/fs.h
--- linux-2.5.35/include/linux/fs.h	Sun Sep 15 19:18:24 2002
+++ linux-2.5.35.aio/include/linux/fs.h	Tue Sep 17 09:04:21 2002
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
 
 struct address_space_operations {
 	int (*writepage)(struct page *);
@@ -307,7 +309,7 @@
 	int (*bmap)(struct address_space *, long);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-	int (*direct_IO)(int, struct inode *, const struct iovec *iov, loff_t offset, unsigned long nr_segs);
+	int (*direct_IO)(int, struct kiocb *, struct inode *, const struct iovec *iov, loff_t offset, unsigned long nr_segs);
 };
 
 struct backing_dev_info;
@@ -743,7 +745,6 @@
  * read, write, poll, fsync, readv, writev can be called
  *   without the big kernel lock held in all filesystems.
  */
-struct kiocb;
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -1248,10 +1249,10 @@
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
diff -Naur -X dontdiff linux-2.5.35/mm/filemap.c linux-2.5.35.aio/mm/filemap.c
--- linux-2.5.35/mm/filemap.c	Sun Sep 15 19:18:26 2002
+++ linux-2.5.35.aio/mm/filemap.c	Tue Sep 17 09:00:26 2002
@@ -1153,7 +1153,7 @@
 				nr_segs = iov_shorten((struct iovec *)iov,
 							nr_segs, count);
 			}
-			retval = generic_file_direct_IO(READ, inode, 
+			retval = generic_file_direct_IO(READ, iocb, inode, 
 					iov, pos, nr_segs);
 			if (retval > 0)
 				*ppos = pos + retval;
@@ -1989,7 +1989,9 @@
 					   current iovec */
 	unsigned long	seg;
 	char		*buf;
+	struct	kiocb	kiocb;
 
+	init_sync_kiocb(&kiocb, file);
 	if (unlikely((ssize_t)count < 0))
 		return -EINVAL;
 
@@ -2099,8 +2101,11 @@
 		if (count != ocount)
 			nr_segs = iov_shorten((struct iovec *)iov,
 						nr_segs, count);
-		written = generic_file_direct_IO(WRITE, inode, 
+		written = generic_file_direct_IO(WRITE, &kiocb, inode, 
 					iov, pos, nr_segs);
+		if (written == -EIOCBQUEUED)
+			written = wait_on_sync_kiocb(&kiocb);
+		
 		if (written > 0) {
 			loff_t end = pos + written;
 			if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {

