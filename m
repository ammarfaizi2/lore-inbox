Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSGHDKq>; Sun, 7 Jul 2002 23:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSGHDKp>; Sun, 7 Jul 2002 23:10:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57604 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316768AbSGHDKh>;
	Sun, 7 Jul 2002 23:10:37 -0400
Message-ID: <3D2904C5.53E38ED4@zip.com.au>
Date: Sun, 07 Jul 2002 20:19:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
Subject: direct-to-BIO for O_DIRECT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch which converts O_DIRECT to go direct-to-BIO, bypassing
the kiovec layer.  It's followed by a patch which converts the raw
driver to use the O_DIRECT engine.

CPU utilisation is about the same as the kiovec-based implementation.
Read and write bandwidth are the same too, for 128k chunks.   But with
one megabyte chunks, this implementation is 20% faster at writing.

I assume this is because the kiobuf-based implementation has to stop
and wait for each 128k chunk, whereas this code streams the entire
request, regardless of its size.

This is with a single (oldish) scsi disk on aic7xxx.  I'd expect the
margin to widen on higher-end hardware which likes to have more 
requests in flight.

Question is: what do we want to do with this sucker?  These are the
remaining users of kiovecs:

	drivers/md/lvm-snap.c
	drivers/media/video/video-buf.c
	drivers/mtd/devices/blkmtd.c
	drivers/scsi/sg.c

the video and mtd drivers seems to be fairly easy to de-kiobufize.
I'm aware of one proprietary driver which uses kiobufs.  XFS uses
kiobufs a little bit - just to map the pages.

So with a bit of effort and maintainer-irritation, we can extract
the kiobuf layer from the kernel.

Do we want to do that?



 fs/Makefile                 |    2 
 fs/block_dev.c              |    7 
 fs/buffer.c                 |    2 
 fs/direct-io.c              |  491 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ext2/inode.c             |    7 
 include/linux/buffer_head.h |    2 
 include/linux/fs.h          |   11 
 mm/filemap.c                |   64 ++---
 8 files changed, 543 insertions(+), 43 deletions(-)

--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.25-akpm/fs/direct-io.c	Sun Jul  7 19:40:20 2002
@@ -0,0 +1,491 @@
+/*
+ * mm/direct-io.c
+ *
+ * Copyright (C) 2002, Linus Torvalds.
+ *
+ * O_DIRECT
+ *
+ * 04Jul2002	akpm@zip.com.au
+ *		Initial version
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/bio.h>
+#include <linux/wait.h>
+#include <linux/err.h>
+#include <linux/buffer_head.h>
+#include <linux/rwsem.h>
+#include <asm/atomic.h>
+
+/*
+ * The largest-sized BIO which this code will assemble, in bytes.  Set this
+ * to PAGE_SIZE if your drivers are broken.
+ */
+#define DIO_BIO_MAX_SIZE BIO_MAX_SIZE
+
+/*
+ * How many user pages to map in one call to get_user_pages().  This determines
+ * the size of a structure on the stack.
+ */
+#define DIO_PAGES	64
+
+struct dio {
+	/* BIO submission state */
+	struct bio *bio;		/* bio under assembly */
+	struct bio_vec *bvec;		/* current bvec in that bio */
+	struct inode *inode;
+	int rw;
+	sector_t block_in_file;		/* changes */
+	sector_t final_block_in_request;/* doesn't change */
+	unsigned first_block_in_page;	/* doesn't change */
+	int boundary;			/* prev block is at a boundary */
+	int reap_counter;		/* rate limit reaping */
+	get_block_t *get_block;
+	sector_t last_block_in_bio;
+
+	/* Page fetching state */
+	int curr_page;			/* changes */
+	int total_pages;		/* doesn't change */
+	unsigned long curr_user_address;/* changes */
+
+	/* Page queue */
+	struct page *pages[DIO_PAGES];
+	unsigned head;
+	unsigned tail;
+
+	/* BIO completion state */
+	atomic_t bio_count;
+	spinlock_t bio_list_lock;
+	struct bio *bio_list;		/* singly linked via bi_private */
+	wait_queue_head_t wait_q;
+};
+
+/*
+ * How many pages are in the queue?
+ */
+static inline unsigned dio_pages_present(struct dio *dio)
+{
+	return dio->head - dio->tail;
+}
+
+/*
+ * Go grab and pin some userspace pages.   Typically we'll get 64 at a time.
+ */
+static int dio_refill_pages(struct dio *dio)
+{
+	int ret;
+	int nr_pages;
+
+	nr_pages = min(dio->total_pages - dio->curr_page, DIO_PAGES);
+	ret = get_user_pages(
+		current,			/* Task for fault acounting */
+		current->mm,			/* whose pages? */
+		dio->curr_user_address,		/* Where from? */
+		nr_pages,			/* How many pages? */
+		dio->rw == READ,		/* Write to memory? */
+		0,				/* force (?) */
+		&dio->pages[0],
+		NULL);				/* vmas */
+
+	if (ret >= 0) {
+		dio->curr_user_address += ret * PAGE_SIZE;
+		dio->curr_page += ret;
+		dio->head = 0;
+		dio->tail = ret;
+		ret = 0;
+	}
+	return ret;	
+}
+
+/*
+ * Get another userspace page.  Returns an ERR_PTR on error.  Pages are
+ * buffered inside the dio so that we can call get_user_pages() against a
+ * decent number of pages, less frequently.  To provide nicer use of the
+ * L1 cache.
+ */
+static struct page *dio_get_page(struct dio *dio)
+{
+	if (dio_pages_present(dio) == 0) {
+		int ret;
+
+		ret = dio_refill_pages(dio);
+		if (ret) {
+			printk("%s: dio_refill_pages returns %d\n",
+				__FUNCTION__, ret);
+			return ERR_PTR(ret);
+		}
+		BUG_ON(dio_pages_present(dio) == 0);
+	}
+	return dio->pages[dio->head++];
+}
+
+/*
+ * The BIO completion handler simply queues the BIO up for the process-context
+ * handler.
+ *
+ * During I/O bi_private points at the dio.  After I/O, bi_private is used to
+ * implement a singly-linked list of completed BIOs, at dio->bio_list.
+ */
+static void dio_bio_end_io(struct bio *bio)
+{
+	struct dio *dio = bio->bi_private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dio->bio_list_lock, flags);
+	bio->bi_private = dio->bio_list;
+	dio->bio_list = bio;
+	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+	wake_up(&dio->wait_q);
+}
+
+static int
+dio_bio_alloc(struct dio *dio, struct block_device *bdev,
+		sector_t first_sector, int nr_vecs)
+{
+	struct bio *bio;
+
+	bio = bio_alloc(GFP_KERNEL, nr_vecs);
+	if (bio == NULL)
+		return -ENOMEM;
+
+	bio->bi_bdev = bdev;
+	bio->bi_vcnt = nr_vecs;
+	bio->bi_idx = 0;
+	bio->bi_size = 0;
+	bio->bi_sector = first_sector;
+	bio->bi_io_vec[0].bv_page = NULL;
+	bio->bi_end_io = dio_bio_end_io;
+
+	dio->bio = bio;
+	dio->bvec = NULL;		/* debug */
+	return 0;
+}
+
+static void dio_bio_submit(struct dio *dio)
+{
+	struct bio *bio = dio->bio;
+
+	bio->bi_vcnt = bio->bi_idx;
+	bio->bi_idx = 0;
+	bio->bi_private = dio;
+	atomic_inc(&dio->bio_count);
+	submit_bio(dio->rw, bio);
+
+	dio->bio = NULL;
+	dio->bvec = NULL;
+}
+
+/*
+ * Release any resources in case of a failure
+ */
+static void dio_cleanup(struct dio *dio)
+{
+	while (dio_pages_present(dio))
+		page_cache_release(dio_get_page(dio));
+}
+
+/*
+ * Wait for the next BIO to complete.  Remove it and return it.
+ */
+static struct bio *dio_await_one(struct dio *dio)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long flags;
+	struct bio *bio;
+
+	spin_lock_irqsave(&dio->bio_list_lock, flags);
+	while (dio->bio_list == NULL) {
+		add_wait_queue(&dio->wait_q, &wait);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (dio->bio_list == NULL) {
+			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+			blk_run_queues();
+			schedule();
+			spin_lock_irqsave(&dio->bio_list_lock, flags);
+		}
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&dio->wait_q, &wait);
+	}
+	bio = dio->bio_list;
+	dio->bio_list = bio->bi_private;
+	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+	return bio;
+}
+
+/*
+ * Process one completed BIO.  No locks are held.
+ */
+static int dio_bio_complete(struct dio *dio, struct bio *bio)
+{
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio_vec *bvec = bio->bi_io_vec;
+	int page_no;
+	int ret = 0;
+
+	for (page_no = 0; page_no < bio->bi_vcnt; page_no++) {
+		struct page *page = bvec[page_no].bv_page;
+
+		if (!uptodate) {
+			if (ret == 0)
+				ret = -EIO;
+		}
+
+		if (dio->rw == READ)
+			set_page_dirty(page);
+		page_cache_release(page);
+	}
+	atomic_dec(&dio->bio_count);
+	bio_put(bio);
+	return ret;
+}
+
+/*
+ * Wait on and process all in-flight BIOs.
+ */
+static int dio_await_completion(struct dio *dio)
+{
+	int ret = 0;
+	while (atomic_read(&dio->bio_count)) {
+		struct bio *bio = dio_await_one(dio);
+		int ret2;
+
+		ret2 = dio_bio_complete(dio, bio);
+		if (ret == 0)
+			ret = ret2;
+	}
+	return ret;
+}
+
+/*
+ * A really large O_DIRECT read or write can generate a lot of BIOs.  So
+ * to keep the memory consumption sane we periodically reap any completed BIOs
+ * during the BIO generation phase.
+ *
+ * This also helps to limis the peak amount of pinned userspace memory.
+ */
+static int dio_bio_reap(struct dio *dio)
+{
+	int ret = 0;
+
+	if (dio->reap_counter++ >= 64) {
+		while (dio->bio_list) {
+			unsigned long flags;
+			struct bio *bio;
+			int ret2;
+
+			spin_lock_irqsave(&dio->bio_list_lock, flags);
+			bio = dio->bio_list;
+			dio->bio_list = bio->bi_private;
+			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+			ret2 = dio_bio_complete(dio, bio);
+			if (ret == 0)
+				ret = ret2;
+		}
+		dio->reap_counter = 0;
+	}
+	return ret;
+}
+
+/*
+ * Walk the user pages, and the file, mapping blocks to disk and emitting BIOs.
+ */
+int do_direct_IO(struct dio *dio)
+{
+	struct inode * const inode = dio->inode;
+	const unsigned blkbits = inode->i_blkbits;
+	const unsigned blocksize = 1 << blkbits;
+	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
+	struct page *page;
+	unsigned block_in_page;
+	int ret;
+
+	/* The I/O can start at any block offset within the first page */
+	block_in_page = dio->first_block_in_page;
+
+	while (dio->block_in_file < dio->final_block_in_request) {
+		int new_page;	/* Need to insert this page into the BIO? */
+
+		page = dio_get_page(dio);
+		if (IS_ERR(page)) {
+			ret = PTR_ERR(page);
+			goto out;
+		}
+
+		new_page = 1;
+		for ( ; block_in_page < blocks_per_page; block_in_page++) {
+			struct buffer_head map_bh;
+			struct bio *bio;
+
+			map_bh.b_state = 0;
+			ret = (*dio->get_block)(inode, dio->block_in_file,
+						&map_bh, dio->rw == WRITE);
+			if (ret) {
+				printk("%s: get_block returns %d\n",
+					__FUNCTION__, ret);
+				goto fail_release;
+			}
+			/* blockdevs do not set buffer_new */
+			if (buffer_new(&map_bh))
+				unmap_underlying_metadata(map_bh.b_bdev,
+							map_bh.b_blocknr);
+			if (!buffer_mapped(&map_bh)) {
+				ret = -EINVAL;		/* A hole */
+				goto fail_release;
+			}
+			if (dio->bio) {
+				if (dio->bio->bi_idx == dio->bio->bi_vcnt ||
+						dio->boundary ||
+						dio->last_block_in_bio !=
+							map_bh.b_blocknr - 1) {
+					dio_bio_submit(dio);
+					dio->boundary = 0;
+				}
+			}
+			if (dio->bio == NULL) {
+				ret = dio_bio_reap(dio);
+				if (ret)
+					goto fail_release;
+				ret = dio_bio_alloc(dio, map_bh.b_bdev,
+					map_bh.b_blocknr << (blkbits - 9),
+					DIO_BIO_MAX_SIZE / PAGE_SIZE);
+				if (ret)
+					goto fail_release;
+				new_page = 1;
+				dio->boundary = 0;
+			}
+
+			bio = dio->bio;
+			if (new_page) {
+				dio->bvec = &bio->bi_io_vec[bio->bi_idx];
+				page_cache_get(page);
+				dio->bvec->bv_page = page;
+				dio->bvec->bv_len = 0;
+				dio->bvec->bv_offset = block_in_page*blocksize;
+				bio->bi_idx++;
+			}
+			new_page = 0;
+			dio->bvec->bv_len += blocksize;
+			bio->bi_size += blocksize;
+			dio->last_block_in_bio = map_bh.b_blocknr;
+			dio->boundary = buffer_boundary(&map_bh);
+
+			dio->block_in_file++;
+			if (dio->block_in_file >= dio->final_block_in_request)
+				break;
+		}
+		block_in_page = 0;
+		page_cache_release(page);
+	}
+	ret = 0;
+	goto out;
+fail_release:
+	page_cache_release(page);
+out:
+	return ret;
+}
+
+struct dio *g_dio;
+
+int
+generic_direct_IO(int rw, struct inode *inode, char *buf, loff_t offset,
+			size_t count, get_block_t get_block)
+{
+	const unsigned blocksize_mask = (1 << inode->i_blkbits) - 1;
+	const unsigned long user_addr = (unsigned long)buf;
+	int ret = 0;
+	int ret2;
+	struct dio dio;
+	size_t bytes;
+
+	/* Check the memory alignment.  Blocks cannot straddle pages */
+	if ((user_addr & blocksize_mask) || (count & blocksize_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	g_dio = &dio;
+
+	/* BIO submission state */
+	dio.bio = NULL;
+	dio.bvec = NULL;
+	dio.inode = inode;
+	dio.rw = rw;
+	dio.block_in_file = offset >> inode->i_blkbits;
+	dio.final_block_in_request = (offset + count) >> inode->i_blkbits;
+
+	/* Index into the first page of the first block */
+	dio.first_block_in_page = (user_addr & (PAGE_SIZE - 1))
+						>> inode->i_blkbits;
+	dio.boundary = 0;
+	dio.reap_counter = 0;
+	dio.get_block = get_block;
+	dio.last_block_in_bio = -1;
+
+	/* Page fetching state */
+	dio.curr_page = 0;
+	bytes = count;
+	dio.total_pages = 0;
+	if (offset & PAGE_SIZE) {
+		dio.total_pages++;
+		bytes -= PAGE_SIZE - (offset & ~(PAGE_SIZE - 1));
+	}
+	dio.total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+	dio.curr_user_address = user_addr;
+
+	/* Page queue */
+	dio.head = 0;
+	dio.tail = 0;
+
+	/* BIO completion state */
+	atomic_set(&dio.bio_count, 0);
+	spin_lock_init(&dio.bio_list_lock);
+	dio.bio_list = NULL;
+	init_waitqueue_head(&dio.wait_q);
+
+	down_read(&current->mm->mmap_sem);
+	ret = do_direct_IO(&dio);
+	up_read(&current->mm->mmap_sem);
+
+	if (dio.bio)
+		dio_bio_submit(&dio);
+	if (ret)
+		dio_cleanup(&dio);
+	ret2 = dio_await_completion(&dio);
+	if (ret == 0)
+		ret = ret2;
+	if (ret == 0)
+		ret = count - ((dio.final_block_in_request -
+				dio.block_in_file) << inode->i_blkbits);
+out:
+	return ret;
+}
+
+ssize_t
+generic_file_direct_IO(int rw, struct inode *inode, char *buf,
+			loff_t offset, size_t count)
+{
+	struct address_space *mapping = inode->i_mapping;
+	unsigned blocksize_mask;
+	ssize_t retval;
+
+	blocksize_mask = (1 << inode->i_blkbits) - 1;
+	if ((offset & blocksize_mask) || (count & blocksize_mask)) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	if (mapping->nrpages) {
+		retval = filemap_fdatawrite(mapping);
+		if (retval == 0)
+			retval = filemap_fdatawait(mapping);
+		if (retval)
+			goto out;
+	}
+	retval = mapping->a_ops->direct_IO(rw, inode, buf, offset, count);
+out:
+	return retval;
+}
--- 2.5.25/include/linux/fs.h~odirect-redux	Sun Jul  7 19:35:39 2002
+++ 2.5.25-akpm/include/linux/fs.h	Sun Jul  7 19:35:39 2002
@@ -303,8 +303,8 @@ struct address_space_operations {
 	int (*bmap)(struct address_space *, long);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-#define KERNEL_HAS_O_DIRECT /* this is for modules out of the kernel */
-	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
+	int (*direct_IO)(int, struct inode *, char *buf,
+				loff_t offset, size_t count);
 };
 
 struct backing_dev_info;
@@ -1128,7 +1128,7 @@ extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
 extern int invalidate_device(kdev_t, int);
 extern void invalidate_inode_pages(struct inode *);
-extern void invalidate_inode_pages2(struct address_space *);
+extern void invalidate_inode_pages2(struct address_space *mapping);
 extern void write_inode_now(struct inode *, int);
 extern int filemap_fdatawrite(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
@@ -1233,6 +1233,11 @@ extern int file_read_actor(read_descript
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
+ssize_t generic_file_direct_IO(int rw, struct inode *inode, char *buf,
+				loff_t offset, size_t count);
+int generic_direct_IO(int rw, struct inode *inode, char *buf,
+			loff_t offset, size_t count, get_block_t *get_block);
+
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t remote_llseek(struct file *file, loff_t offset, int origin);
--- 2.5.25/include/linux/buffer_head.h~odirect-redux	Sun Jul  7 19:35:39 2002
+++ 2.5.25-akpm/include/linux/buffer_head.h	Sun Jul  7 19:35:39 2002
@@ -182,8 +182,6 @@ int block_sync_page(struct page *);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
-int generic_direct_IO(int, struct inode *, struct kiobuf *,
-			unsigned long, int, get_block_t *);
 int file_fsync(struct file *, struct dentry *, int);
 
 #define OSYNC_METADATA	(1<<0)
--- 2.5.25/fs/buffer.c~odirect-redux	Sun Jul  7 19:35:39 2002
+++ 2.5.25-akpm/fs/buffer.c	Sun Jul  7 19:35:39 2002
@@ -2298,6 +2298,7 @@ sector_t generic_block_bmap(struct addre
 	return tmp.b_blocknr;
 }
 
+#if 0
 int generic_direct_IO(int rw, struct inode *inode,
 			struct kiobuf *iobuf, unsigned long blocknr,
 			int blocksize, get_block_t *get_block)
@@ -2344,6 +2345,7 @@ int generic_direct_IO(int rw, struct ino
  out:
 	return retval;
 }
+#endif
 
 /*
  * Start I/O on a physical range of kernel memory, defined by a vector
--- 2.5.25/mm/filemap.c~odirect-redux	Sun Jul  7 19:35:39 2002
+++ 2.5.25-akpm/mm/filemap.c	Sun Jul  7 19:35:39 2002
@@ -413,7 +413,7 @@ static int invalidate_list_pages2(struct
  * free the pages because they're mapped.
  * @mapping: the address_space which pages we want to invalidate
  */
-void invalidate_inode_pages2(struct address_space * mapping)
+void invalidate_inode_pages2(struct address_space *mapping)
 {
 	int unlocked;
 
@@ -1101,6 +1101,7 @@ no_cached_page:
 	UPDATE_ATIME(inode);
 }
 
+#if 0
 static ssize_t generic_file_direct_IO(int rw, struct file * filp, char * buf, size_t count, loff_t offset)
 {
 	ssize_t retval;
@@ -1181,6 +1182,7 @@ static ssize_t generic_file_direct_IO(in
  out:	
 	return retval;
 }
+#endif
 
 int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
@@ -1208,15 +1210,36 @@ int file_read_actor(read_descriptor_t * 
  * This is the "read()" routine for all filesystems
  * that can use the page cache directly.
  */
-ssize_t generic_file_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
+ssize_t
+generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	ssize_t retval;
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;
 
-	if (filp->f_flags & O_DIRECT)
-		goto o_direct;
+	if (filp->f_flags & O_DIRECT) {
+		loff_t pos = *ppos, size;
+		struct address_space *mapping;
+		struct inode *inode;
+
+		mapping = filp->f_dentry->d_inode->i_mapping;
+		inode = mapping->host;
+		retval = 0;
+		if (!count)
+			goto out; /* skip atime */
+		size = inode->i_size;
+		if (pos < size) {
+			if (pos + count > size)
+				count = size - pos;
+			retval = generic_file_direct_IO(READ, inode,
+							buf, pos, count);
+			if (retval > 0)
+				*ppos = pos + retval;
+		}
+		UPDATE_ATIME(filp->f_dentry->d_inode);
+		goto out;
+	}
 
 	retval = -EFAULT;
 	if (access_ok(VERIFY_WRITE, buf, count)) {
@@ -1229,36 +1252,14 @@ ssize_t generic_file_read(struct file * 
 			desc.count = count;
 			desc.buf = buf;
 			desc.error = 0;
-			do_generic_file_read(filp, ppos, &desc, file_read_actor);
-
+			do_generic_file_read(filp,ppos,&desc,file_read_actor);
 			retval = desc.written;
 			if (!retval)
 				retval = desc.error;
 		}
 	}
- out:
+out:
 	return retval;
-
- o_direct:
-	{
-		loff_t pos = *ppos, size;
-		struct address_space *mapping = filp->f_dentry->d_inode->i_mapping;
-		struct inode *inode = mapping->host;
-
-		retval = 0;
-		if (!count)
-			goto out; /* skip atime */
-		size = inode->i_size;
-		if (pos < size) {
-			if (pos + count > size)
-				count = size - pos;
-			retval = generic_file_direct_IO(READ, filp, buf, count, pos);
-			if (retval > 0)
-				*ppos = pos + retval;
-		}
-		UPDATE_ATIME(filp->f_dentry->d_inode);
-		goto out;
-	}
 }
 
 static int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset , unsigned long size)
@@ -2199,8 +2200,8 @@ generic_file_write(struct file *file, co
 	}
 
 	if (unlikely(file->f_flags & O_DIRECT)) {
-		written = generic_file_direct_IO(WRITE, file,
-						(char *) buf, count, pos);
+		written = generic_file_direct_IO(WRITE, inode,
+						(char *)buf, pos, count);
 		if (written > 0) {
 			loff_t end = pos + written;
 			if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {
@@ -2208,7 +2209,8 @@ generic_file_write(struct file *file, co
 				mark_inode_dirty(inode);
 			}
 			*ppos = end;
-			invalidate_inode_pages2(mapping);
+			if (mapping->nrpages)
+				invalidate_inode_pages2(mapping);
 		}
 		/*
 		 * Sync the fs metadata but not the minor inode changes and
--- 2.5.25/fs/ext2/inode.c~odirect-redux	Sun Jul  7 19:35:39 2002
+++ 2.5.25-akpm/fs/ext2/inode.c	Sun Jul  7 19:35:39 2002
@@ -607,11 +607,10 @@ static int ext2_bmap(struct address_spac
 }
 
 static int
-ext2_direct_IO(int rw, struct inode *inode, struct kiobuf *iobuf,
-			unsigned long blocknr, int blocksize)
+ext2_direct_IO(int rw, struct inode *inode, char *buf,
+			loff_t offset, size_t count)
 {
-	return generic_direct_IO(rw, inode, iobuf, blocknr,
-				blocksize, ext2_get_block);
+	return generic_direct_IO(rw, inode, buf, offset, count, ext2_get_block);
 }
 
 static int
--- 2.5.25/fs/Makefile~odirect-redux	Sun Jul  7 19:35:39 2002
+++ 2.5.25-akpm/fs/Makefile	Sun Jul  7 19:35:39 2002
@@ -15,7 +15,7 @@ obj-y :=	open.o read_write.o devices.o f
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o
+		fs-writeback.o mpage.o direct-io.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
--- 2.5.25/fs/block_dev.c~odirect-redux	Sun Jul  7 19:35:39 2002
+++ 2.5.25-akpm/fs/block_dev.c	Sun Jul  7 19:35:39 2002
@@ -105,9 +105,12 @@ static int blkdev_get_block(struct inode
 	return 0;
 }
 
-static int blkdev_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
+static int
+blkdev_direct_IO(int rw, struct inode *inode, char *buf,
+			loff_t offset, size_t count)
 {
-	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, blkdev_get_block);
+	return generic_direct_IO(rw, inode, buf, offset,
+				count, blkdev_get_block);
 }
 
 static int blkdev_writepage(struct page * page)

-


 raw.c |  136 ++++++++++++------------------------------------------------------
 1 files changed, 26 insertions(+), 110 deletions(-)

--- 2.5.25/drivers/char/raw.c~raw-use-generic	Sun Jul  7 19:35:44 2002
+++ 2.5.25-akpm/drivers/char/raw.c	Sun Jul  7 19:58:33 2002
@@ -8,8 +8,8 @@
  * device are used to bind the other minor numbers to block devices.
  */
 
+#include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/iobuf.h>
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/raw.h>
@@ -86,12 +86,6 @@ int raw_open(struct inode *inode, struct
 		return 0;
 	}
 	
-	if (!filp->f_iobuf) {
-		err = alloc_kiovec(1, &filp->f_iobuf);
-		if (err)
-			return err;
-	}
-
 	down(&raw_devices[minor].mutex);
 	/*
 	 * No, it is a normal raw device.  All we need to do on open is
@@ -256,124 +250,46 @@ int raw_ctl_ioctl(struct inode *inode, 
 	return err;
 }
 
-
-
-ssize_t	raw_read(struct file *filp, char * buf, 
-		 size_t size, loff_t *offp)
+ssize_t raw_read(struct file *filp, char * buf, size_t size, loff_t *offp)
 {
 	return rw_raw_dev(READ, filp, buf, size, offp);
 }
 
-ssize_t	raw_write(struct file *filp, const char *buf, 
-		  size_t size, loff_t *offp)
+ssize_t	raw_write(struct file *filp, const char *buf, size_t size, loff_t *offp)
 {
 	return rw_raw_dev(WRITE, filp, (char *) buf, size, offp);
 }
 
-#define SECTOR_BITS 9
-#define SECTOR_SIZE (1U << SECTOR_BITS)
-#define SECTOR_MASK (SECTOR_SIZE - 1)
-
-ssize_t	rw_raw_dev(int rw, struct file *filp, char *buf, 
-		   size_t size, loff_t *offp)
+ssize_t
+rw_raw_dev(int rw, struct file *filp, char *buf, size_t size, loff_t *offp)
 {
-	struct kiobuf * iobuf;
-	int		new_iobuf;
-	int		err = 0;
-	unsigned long	blocks;
-	size_t		transferred;
-	int		iosize;
-	int		minor;
-	kdev_t		dev;
-	unsigned long	limit;
-	int		sector_size, sector_bits, sector_mask;
-	sector_t	blocknr;
 	struct block_device *bdev;
-	
-	/*
-	 * First, a few checks on device size limits 
-	 */
+	struct inode *inode;
+	int minor;
+	ssize_t ret = 0;
 
 	minor = minor(filp->f_dentry->d_inode->i_rdev);
-
-	new_iobuf = 0;
-	iobuf = filp->f_iobuf;
-	if (test_and_set_bit(0, &filp->f_iobuf_lock)) {
-		/*
-		 * A parallel read/write is using the preallocated iobuf
-		 * so just run slow and allocate a new one.
-		 */
-		err = alloc_kiovec(1, &iobuf);
-		if (err)
-			goto out;
-		new_iobuf = 1;
-	}
-
 	bdev = raw_devices[minor].binding;
-	dev = to_kdev_t(bdev->bd_dev);
-	sector_size = raw_devices[minor].sector_size;
-	sector_bits = raw_devices[minor].sector_bits;
-	sector_mask = sector_size - 1;
-
-	limit = bdev->bd_inode->i_size >> sector_bits;
-	if (!limit)
-		limit = INT_MAX;
-	dprintk ("rw_raw_dev: dev %d:%d (+%d)\n",
-		 major(dev), minor(dev), limit);
-	
-	err = -EINVAL;
-	if ((*offp & sector_mask) || (size & sector_mask))
-		goto out_free;
-	err = 0;
-	if (size)
-		err = -ENXIO;
-	if ((*offp >> sector_bits) >= limit)
-		goto out_free;
-
-	transferred = 0;
-	blocknr = *offp >> sector_bits;
-	while (size > 0) {
-		blocks = size >> sector_bits;
-		if (blocks > limit - blocknr)
-			blocks = limit - blocknr;
-		if (!blocks)
-			break;
-
-		iosize = blocks << sector_bits;
+	inode = bdev->bd_inode;
 
-		err = map_user_kiobuf(rw, iobuf, (unsigned long) buf, iosize);
-		if (err)
-			break;
-
-		err = brw_kiovec(rw, 1, &iobuf, raw_devices[minor].binding, &blocknr, sector_size);
-
-		if (rw == READ && err > 0)
-			mark_dirty_kiobuf(iobuf, err);
-		
-		if (err >= 0) {
-			transferred += err;
-			size -= err;
-			buf += err;
-		}
-
-		blocknr += blocks;
-
-		unmap_kiobuf(iobuf);
-
-		if (err != iosize)
-			break;
+	if (size == 0)
+		goto out;
+	if (size < 0) {
+		ret = -EINVAL;
+		goto out;
 	}
-	
-	if (transferred) {
-		*offp += transferred;
-		err = transferred;
+	if (*offp >= inode->i_size) {
+		ret = -ENXIO;
+		goto out;
 	}
+	if (size + *offp > inode->i_size)
+		size = inode->i_size - *offp;
 
- out_free:
-	if (!new_iobuf)
-		clear_bit(0, &filp->f_iobuf_lock);
-	else
-		free_kiovec(1, &iobuf);
- out:	
-	return err;
+	ret = generic_file_direct_IO(rw, inode, buf, *offp, size);
+	if (ret > 0)
+		*offp += ret;
+	if (inode->i_mapping->nrpages)
+		invalidate_inode_pages2(inode->i_mapping);
+out:
+	return ret;
 }

-
