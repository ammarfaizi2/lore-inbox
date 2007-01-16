Return-Path: <linux-kernel-owner+w=401wt.eu-S932255AbXAPCGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbXAPCGu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbXAPCGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:06:49 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932255AbXAPCDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:37 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 21:03:27 EST
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.99535.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 7/10][RFC] aio: make __blockdev_direct_IO use file_endio_t
X-OriginalArrivalTime: 16 Jan 2007 01:55:26.0537 (UTC) FILETIME=[646BEB90:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the internals of __blockdev_direct_IO in fs/direct-io.c to use
a generic endio function, instead of directly calling aio_complete.  It also
changes the semantics of dio_iodone to be more friendly to its only users,
xfs and ocfs2.  This allows the caller to know how to release locks and tear
down data structures on error.

It also converts the _own_locking and _no_locking variants of
blockdev_direct_IO to use a generic endio function.

---

 fs/direct-io.c              |   74 ++++++++++++++++++++++++++------------------
 fs/gfs2/ops_address.c       |    6 +--
 fs/ocfs2/aops.c             |   15 ++------
 fs/ocfs2/aops.h             |    8 ----
 fs/ocfs2/file.c             |   18 ++++------
 fs/ocfs2/inode.h            |    2 -
 fs/xfs/linux-2.6/xfs_aops.c |   33 +++++++------------
 include/linux/fs.h          |   57 ++++++++++++++++++---------------
 8 files changed, 104 insertions(+), 109 deletions(-)

---

diff -urpN -X dontdiff a/fs/direct-io.c b/fs/direct-io.c
--- a/fs/direct-io.c	2007-01-12 14:53:48.000000000 -0800
+++ b/fs/direct-io.c	2007-01-12 15:06:44.000000000 -0800
@@ -67,7 +67,7 @@ struct dio {
 	struct bio *bio;		/* bio under assembly */
 	struct inode *inode;
 	int rw;
-	loff_t i_size;			/* i_size when submitted */
+	unsigned max_to_read;		/* (i_size when submitted) - offset */
 	int lock_type;			/* doesn't change */
 	unsigned blkbits;		/* doesn't change */
 	unsigned blkfactor;		/* When we're using an alignment which
@@ -89,6 +89,7 @@ struct dio {
 	int reap_counter;		/* rate limit reaping */
 	get_block_t *get_block;		/* block mapping function */
 	dio_iodone_t *end_io;		/* IO completion function */
+	void *destructor_data;		/* private data for completion fn */
 	sector_t final_block_in_bio;	/* current final block in bio + 1 */
 	sector_t next_block_for_io;	/* next block to be put under IO,
 					   in dio_blocks units */
@@ -127,7 +128,8 @@ struct dio {
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
 
 	/* AIO related stuff */
-	struct kiocb *iocb;		/* kiocb */
+	file_endio_t *file_endio;	/* aio completion function */
+	void *endio_data;		/* private data for aio completion */
 	int is_async;			/* is IO async ? */
 	int io_error;			/* IO error in completion path */
 	ssize_t result;                 /* IO result */
@@ -222,7 +224,7 @@ static struct page *dio_get_page(struct 
  * filesystems can use it to hold additional state between get_block calls and
  * dio_complete.
  */
-static int dio_complete(struct dio *dio, loff_t offset, int ret)
+static int dio_complete(struct dio *dio, int ret)
 {
 	/*
 	 * AIO submission can race with bio completion to get here while
@@ -232,25 +234,21 @@ static int dio_complete(struct dio *dio,
 	 */
 	if (ret == -EIOCBQUEUED)
 		ret = 0;
+	if (ret == 0)
+		ret = dio->page_errors;
+	if (ret == 0)
+		ret = dio->io_error;
 
 	if (dio->result) {
 		/* Check for short read case */
-		if ((dio->rw == READ) && ((offset + dio->result) > dio->i_size))
-			dio->result = dio->i_size - offset;
+		if ((dio->rw == READ) && (dio->result > dio->max_to_read))
+			dio->result = dio->max_to_read;
 	}
 
-	if (dio->end_io && dio->result)
-		dio->end_io(dio->iocb, offset, dio->result,
-			    dio->map_bh.b_private);
 	if (dio->lock_type == DIO_LOCKING)
 		/* lockdep: non-owner release */
 		up_read_non_owner(&dio->inode->i_alloc_sem);
 
-	if (ret == 0)
-		ret = dio->page_errors;
-	if (ret == 0)
-		ret = dio->io_error;
-
 	return ret;
 }
 
@@ -277,8 +275,11 @@ static int dio_bio_end_aio(struct bio *b
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 
 	if (remaining == 0) {
-		int err = dio_complete(dio, dio->iocb->ki_pos, 0);
-		aio_complete(dio->iocb, dio->result, err);
+		int err = dio_complete(dio, 0);
+		if (dio->end_io)
+			dio->end_io(dio->destructor_data, dio->result,
+				    dio->map_bh.b_private);
+		dio->file_endio(dio->endio_data, dio->result, err);
 		kfree(dio);
 	}
 
@@ -944,10 +945,11 @@ out:
  * Releases both i_mutex and i_alloc_sem
  */
 static ssize_t
-direct_io_worker(int rw, struct kiocb *iocb, struct inode *inode, 
+direct_io_worker(int rw, struct file *file, struct inode *inode, 
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
 	unsigned blkbits, get_block_t get_block, dio_iodone_t end_io,
-	struct dio *dio)
+	void *destructor_data, struct dio *dio, file_endio_t *file_endio,
+	void *endio_data)
 {
 	unsigned long user_addr; 
 	unsigned long flags;
@@ -971,6 +973,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->reap_counter = 0;
 	dio->get_block = get_block;
 	dio->end_io = end_io;
+	dio->destructor_data = destructor_data;
 	dio->map_bh.b_private = NULL;
 	dio->final_block_in_bio = -1;
 	dio->next_block_for_io = -1;
@@ -978,8 +981,9 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->page_errors = 0;
 	dio->io_error = 0;
 	dio->result = 0;
-	dio->iocb = iocb;
-	dio->i_size = i_size_read(inode);
+	dio->file_endio = file_endio;
+	dio->endio_data = endio_data;
+	dio->max_to_read = i_size_read(inode) - offset;
 
 	spin_lock_init(&dio->bio_lock);
 	dio->refcount = 1;
@@ -1103,9 +1107,18 @@ direct_io_worker(int rw, struct kiocb *i
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 	BUG_ON(!dio->is_async && ret2 != 0);
 	if (ret2 == 0) {
-		ret = dio_complete(dio, offset, ret);
-		if (ret == 0)
+		ret = dio_complete(dio, ret);
+		if (ret == 0) {
+			/*
+			 * we guarantee to call end_io unless we return a
+			 * real error, ie. not -EIOCBQUEUED, which can never
+			 * happen here, so call it unconditionally
+			 */
+			if (dio->end_io)
+				dio->end_io(dio->destructor_data, dio->result,
+					    dio->map_bh.b_private);
 			ret = dio->result;	/* bytes transferred */
+		}
 		kfree(dio);
 	} else
 		BUG_ON(ret != -EIOCBQUEUED);
@@ -1135,14 +1148,16 @@ direct_io_worker(int rw, struct kiocb *i
  * Additional i_alloc_sem locking requirements described inline below.
  */
 ssize_t
-__blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
-	struct block_device *bdev, const struct iovec *iov, loff_t offset, 
-	unsigned long nr_segs, get_block_t get_block, dio_iodone_t end_io,
-	int dio_lock_type)
+__blockdev_direct_IO(int rw, struct file *file, const struct iovec *iov,
+	loff_t offset, unsigned long nr_segs, get_block_t get_block,
+	dio_iodone_t end_io, void *destructor_data, file_endio_t *file_endio,
+	void *endio_data, int dio_lock_type)
 {
 	int seg;
 	size_t size;
 	unsigned long addr;
+	struct inode *inode = file->f_mapping->host;
+	struct block_device *bdev = inode->i_sb->s_bdev;
 	unsigned blkbits = inode->i_blkbits;
 	unsigned bdev_blkbits = 0;
 	unsigned blocksize_mask = (1 << blkbits) - 1;
@@ -1202,7 +1217,7 @@ __blockdev_direct_IO(int rw, struct kioc
 		if (rw == READ && end > offset) {
 			struct address_space *mapping;
 
-			mapping = iocb->ki_filp->f_mapping;
+			mapping = file->f_mapping;
 			if (dio_lock_type != DIO_OWN_LOCKING) {
 				mutex_lock(&inode->i_mutex);
 				release_i_mutex = 1;
@@ -1232,11 +1247,12 @@ __blockdev_direct_IO(int rw, struct kioc
 	 * even for AIO, we need to wait for i/o to complete before
 	 * returning in this case.
 	 */
-	dio->is_async = !is_sync_kiocb(iocb) && !((rw & WRITE) &&
+	dio->is_async = file_endio && !((rw & WRITE) &&
 		(end > i_size_read(inode)));
 
-	retval = direct_io_worker(rw, iocb, inode, iov, offset,
-				nr_segs, blkbits, get_block, end_io, dio);
+	retval = direct_io_worker(rw, file, inode, iov, offset,
+				nr_segs, blkbits, get_block, end_io,
+				destructor_data, dio, file_endio, endio_data);
 
 	if (rw == READ && dio_lock_type == DIO_LOCKING)
 		release_i_mutex = 0;
diff -urpN -X dontdiff a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
--- a/fs/gfs2/ops_address.c	2007-01-12 11:19:45.000000000 -0800
+++ b/fs/gfs2/ops_address.c	2007-01-12 15:06:44.000000000 -0800
@@ -628,9 +628,9 @@ static ssize_t gfs2_direct_IO(int rw, st
 	if (rv != 1)
 		goto out; /* dio not valid, fall back to buffered i/o */
 
-	rv = blockdev_direct_IO_no_locking(rw, iocb, inode, inode->i_sb->s_bdev,
-					   iov, offset, nr_segs,
-					   gfs2_get_block_direct, NULL);
+	rv = blockdev_direct_IO_no_locking(rw, file, iov, offset, nr_segs,
+					   gfs2_get_block_direct, NULL, NULL,
+					   aio_complete, iocb);
 out:
 	gfs2_glock_dq_m(1, &gh);
 	gfs2_holder_uninit(&gh);
diff -urpN -X dontdiff a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
--- a/fs/ocfs2/aops.c	2007-01-12 11:19:45.000000000 -0800
+++ b/fs/ocfs2/aops.c	2007-01-12 15:06:44.000000000 -0800
@@ -600,16 +600,12 @@ bail:
  * i_alloc_sem, we use the rw_lock DLM lock to protect io on one node from
  * truncation on another.
  */
-static void ocfs2_dio_end_io(struct kiocb *iocb,
-			     loff_t offset,
+static void ocfs2_dio_end_io(void *destructor_data,
 			     ssize_t bytes,
 			     void *private)
 {
-	struct inode *inode = iocb->ki_filp->f_path.dentry->d_inode;
+	struct inode *inode = destructor_data;
 
-	/* this io's submitter should not have unlocked this before we could */
-	BUG_ON(!ocfs2_iocb_is_rw_locked(iocb));
-	ocfs2_iocb_clear_rw_locked(iocb);
 	up_read(&inode->i_alloc_sem);
 	ocfs2_rw_unlock(inode, 0);
 }
@@ -644,11 +640,10 @@ static ssize_t ocfs2_direct_IO(int rw,
 	}
 	ocfs2_data_unlock(inode, 0);
 
-	ret = blockdev_direct_IO_no_locking(rw, iocb, inode,
-					    inode->i_sb->s_bdev, iov, offset,
-					    nr_segs, 
+	ret = blockdev_direct_IO_no_locking(rw, file, iov, offset, nr_segs,
 					    ocfs2_direct_IO_get_blocks,
-					    ocfs2_dio_end_io);
+					    ocfs2_dio_end_io, inode,
+					    aio_complete, iocb);
 out:
 	mlog_exit(ret);
 	return ret;
diff -urpN -X dontdiff a/fs/ocfs2/aops.h b/fs/ocfs2/aops.h
--- a/fs/ocfs2/aops.h	2007-01-12 11:18:52.000000000 -0800
+++ b/fs/ocfs2/aops.h	2007-01-12 15:06:44.000000000 -0800
@@ -30,12 +30,4 @@ handle_t *ocfs2_start_walk_page_trans(st
 							 unsigned from,
 							 unsigned to);
 
-/* all ocfs2_dio_end_io()'s fault */
-#define ocfs2_iocb_is_rw_locked(iocb) \
-	test_bit(0, (unsigned long *)&iocb->private)
-#define ocfs2_iocb_set_rw_locked(iocb) \
-	set_bit(0, (unsigned long *)&iocb->private)
-#define ocfs2_iocb_clear_rw_locked(iocb) \
-	clear_bit(0, (unsigned long *)&iocb->private)
-
 #endif /* OCFS2_FILE_H */
diff -urpN -X dontdiff a/fs/ocfs2/file.c b/fs/ocfs2/file.c
--- a/fs/ocfs2/file.c	2007-01-12 14:23:40.000000000 -0800
+++ b/fs/ocfs2/file.c	2007-01-12 15:06:44.000000000 -0800
@@ -1183,9 +1183,6 @@ static ssize_t ocfs2_file_aio_write(stru
 		goto out;
 	}
 
-	/* communicate with ocfs2_dio_end_io */
-	ocfs2_iocb_set_rw_locked(iocb);
-
 	ret = generic_file_aio_write_nolock(iocb, iov, nr_segs, iocb->ki_pos);
 
 	/* buffered aio wouldn't have proper lock coverage today */
@@ -1196,12 +1193,13 @@ static ssize_t ocfs2_file_aio_write(stru
 	 * function pointer which is called when o_direct io completes so that
 	 * it can unlock our rw lock.  (it's the clustered equivalent of
 	 * i_alloc_sem; protects truncate from racing with pending ios).
-	 * Unfortunately there are error cases which call end_io and others
-	 * that don't.  so we don't have to unlock the rw_lock if either an
-	 * async dio is going to do it in the future or an end_io after an
-	 * error has already done it.
+	 *
+	 * The direct_IO code guarantees that it will call end_io unless it
+	 * encountered a real error, ie. not -EIOCBQUEUED, so we don't have
+	 * to unlock the rw_lock if either an async dio is going to do it in
+	 * the future or an end_io has already done it.
 	 */
-	if (ret == -EIOCBQUEUED || !ocfs2_iocb_is_rw_locked(iocb)) {
+	if (ret >= 0 || ret == -EIOCBQUEUED) {
 		rw_level = -1;
 		have_alloc_sem = 0;
 	}
@@ -1322,8 +1320,6 @@ static ssize_t ocfs2_file_aio_read(struc
 			goto bail;
 		}
 		rw_level = 0;
-		/* communicate with ocfs2_dio_end_io */
-		ocfs2_iocb_set_rw_locked(iocb);
 	}
 
 	/*
@@ -1350,7 +1346,7 @@ static ssize_t ocfs2_file_aio_read(struc
 	BUG_ON(ret == -EIOCBQUEUED && !(filp->f_flags & O_DIRECT));
 
 	/* see ocfs2_file_aio_write */
-	if (ret == -EIOCBQUEUED || !ocfs2_iocb_is_rw_locked(iocb)) {
+	if (ret >= 0 || ret == -EIOCBQUEUED) {
 		rw_level = -1;
 		have_alloc_sem = 0;
 	}
diff -urpN -X dontdiff a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
--- a/fs/ocfs2/inode.h	2007-01-12 11:18:52.000000000 -0800
+++ b/fs/ocfs2/inode.h	2007-01-12 15:06:44.000000000 -0800
@@ -139,8 +139,6 @@ void ocfs2_refresh_inode(struct inode *i
 int ocfs2_mark_inode_dirty(handle_t *handle,
 			   struct inode *inode,
 			   struct buffer_head *bh);
-int ocfs2_aio_read(struct file *file, struct kiocb *req, struct iocb *iocb);
-int ocfs2_aio_write(struct file *file, struct kiocb *req, struct iocb *iocb);
 
 void ocfs2_set_inode_flags(struct inode *inode);
 
diff -urpN -X dontdiff a/fs/xfs/linux-2.6/xfs_aops.c b/fs/xfs/linux-2.6/xfs_aops.c
--- a/fs/xfs/linux-2.6/xfs_aops.c	2007-01-12 11:19:47.000000000 -0800
+++ b/fs/xfs/linux-2.6/xfs_aops.c	2007-01-12 15:06:44.000000000 -0800
@@ -1332,12 +1332,11 @@ xfs_get_blocks_direct(
 
 STATIC void
 xfs_end_io_direct(
-	struct kiocb	*iocb,
-	loff_t		offset,
+	void		*destructor_data,
 	ssize_t		size,
 	void		*private)
 {
-	xfs_ioend_t	*ioend = iocb->private;
+	xfs_ioend_t	*ioend = destructor_data;
 
 	/*
 	 * Non-NULL private data means we need to issue a transaction to
@@ -1352,19 +1351,11 @@ xfs_end_io_direct(
 	 * go away.
 	 */
 	if (private && size > 0) {
-		ioend->io_offset = offset;
 		ioend->io_size = size;
 		xfs_finish_ioend(ioend);
 	} else {
 		xfs_destroy_ioend(ioend);
 	}
-
-	/*
-	 * blockdev_direct_IO can return an error even after the I/O
-	 * completion handler was called.  Thus we need to protect
-	 * against double-freeing.
-	 */
-	iocb->private = NULL;
 }
 
 STATIC ssize_t
@@ -1379,6 +1370,7 @@ xfs_vm_direct_IO(
 	struct inode	*inode = file->f_mapping->host;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
 	xfs_iomap_t	iomap;
+	xfs_ioend_t	*ioend;
 	int		maps = 1;
 	int		error;
 	ssize_t		ret;
@@ -1387,24 +1379,25 @@ xfs_vm_direct_IO(
 	if (error)
 		return -error;
 
-	iocb->private = xfs_alloc_ioend(inode, IOMAP_UNWRITTEN);
+	ioend = xfs_alloc_ioend(inode, IOMAP_UNWRITTEN);
+	ioend->io_offset = offset;
 
 	if (rw == WRITE) {
-		ret = blockdev_direct_IO_own_locking(rw, iocb, inode,
-			iomap.iomap_target->bt_bdev,
+		ret = blockdev_direct_IO_own_locking(rw, file,
 			iov, offset, nr_segs,
 			xfs_get_blocks_direct,
-			xfs_end_io_direct);
+			xfs_end_io_direct, ioend,
+			aio_complete, iocb);
 	} else {
-		ret = blockdev_direct_IO_no_locking(rw, iocb, inode,
-			iomap.iomap_target->bt_bdev,
+		ret = blockdev_direct_IO_no_locking(rw, file,
 			iov, offset, nr_segs,
 			xfs_get_blocks_direct,
-			xfs_end_io_direct);
+			xfs_end_io_direct, ioend,
+			aio_complete, iocb);
 	}
 
-	if (unlikely(ret != -EIOCBQUEUED && iocb->private))
-		xfs_destroy_ioend(iocb->private);
+	if (unlikely(ret < 0 && ret != -EIOCBQUEUED))
+		xfs_destroy_ioend(ioend);
 	return ret;
 }
 
diff -urpN -X dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2007-01-12 14:53:48.000000000 -0800
+++ b/include/linux/fs.h	2007-01-12 15:06:44.000000000 -0800
@@ -306,8 +306,8 @@ extern void __init files_init(unsigned l
 struct buffer_head;
 typedef int (get_block_t)(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create);
-typedef void (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
-			ssize_t bytes, void *private);
+typedef void (dio_iodone_t)(void *destructor_data, ssize_t bytes,
+			void *private);
 
 /*
  * Attribute flags.  These should be or-ed together to figure out what
@@ -1833,10 +1833,10 @@ static inline void do_generic_file_read(
 }
 
 #ifdef CONFIG_BLOCK
-ssize_t __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
-	struct block_device *bdev, const struct iovec *iov, loff_t offset,
-	unsigned long nr_segs, get_block_t get_block, dio_iodone_t end_io,
-	int lock_type);
+ssize_t __blockdev_direct_IO(int rw, struct file *file,
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs,
+	get_block_t get_block, dio_iodone_t end_io, void *destructor_data,
+	file_endio_t *endio, void *endio_data, int lock_type);
 
 enum {
 	DIO_LOCKING = 1, /* need locking between buffered and direct access */
@@ -1849,26 +1849,31 @@ static inline ssize_t blockdev_direct_IO
 	loff_t offset, unsigned long nr_segs, get_block_t get_block,
 	dio_iodone_t end_io)
 {
-	return __blockdev_direct_IO(rw, iocb, inode, bdev, iov, offset,
-				nr_segs, get_block, end_io, DIO_LOCKING);
-}
-
-static inline ssize_t blockdev_direct_IO_no_locking(int rw, struct kiocb *iocb,
-	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs, get_block_t get_block,
-	dio_iodone_t end_io)
-{
-	return __blockdev_direct_IO(rw, iocb, inode, bdev, iov, offset,
-				nr_segs, get_block, end_io, DIO_NO_LOCKING);
-}
-
-static inline ssize_t blockdev_direct_IO_own_locking(int rw, struct kiocb *iocb,
-	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs, get_block_t get_block,
-	dio_iodone_t end_io)
-{
-	return __blockdev_direct_IO(rw, iocb, inode, bdev, iov, offset,
-				nr_segs, get_block, end_io, DIO_OWN_LOCKING);
+	struct file *file = iocb->ki_filp;
+	file_endio_t *file_endio = &aio_complete;
+	void *endio_data = iocb;
+	return __blockdev_direct_IO(rw, file, iov, offset, nr_segs, get_block,
+			end_io, NULL, file_endio, endio_data, DIO_LOCKING);
+}
+
+static inline ssize_t blockdev_direct_IO_no_locking(int rw, struct file *file,
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs,
+	get_block_t get_block, dio_iodone_t end_io, void *destructor_data,
+	file_endio_t file_endio, void *endio_data)
+{
+	return __blockdev_direct_IO(rw, file, iov, offset, nr_segs, get_block,
+				end_io, destructor_data, file_endio, endio_data,
+				DIO_NO_LOCKING);
+}
+
+static inline ssize_t blockdev_direct_IO_own_locking(int rw, struct file *file,
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs,
+	get_block_t get_block, dio_iodone_t end_io, void *destructor_data,
+	file_endio_t file_endio, void *endio_data)
+{
+	return __blockdev_direct_IO(rw, file, iov, offset, nr_segs, get_block,
+				end_io, destructor_data, file_endio, endio_data,
+				DIO_OWN_LOCKING);
 }
 #endif
 
