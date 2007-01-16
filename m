Return-Path: <linux-kernel-owner+w=401wt.eu-S932313AbXAPCE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbXAPCE2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbXAPCD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:03:59 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932242AbXAPCDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:33 -0500
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
Message-Id: <20070116015450.9764.84003.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 5/10][RFC] aio: make blk_directIO use file_endio_t
X-OriginalArrivalTime: 16 Jan 2007 01:55:16.0364 (UTC) FILETIME=[5E5BA4C0:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the internals of blkdev_direct_IO to use a generic endio function,
instead of directly calling aio_complete.  This may also fix some bugs/races
in this code, for instance it checks bio->bi_size instead of assuming it's
zero, and it atomically accumulates the bytes_done counter (assuming that
the bio completion handler can't race with itself *might* be valid here, but
the direct-io code makes no such assumption).  I'm also pretty sure that
the address_space->directIO functions aren't supposed to mess with the
iocb->ki_pos or ->ki_left.

---

diff -urpN -X dontdiff a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	2007-01-12 20:26:25.000000000 -0800
+++ b/fs/block_dev.c	2007-01-12 20:23:55.000000000 -0800
@@ -131,10 +131,32 @@ blkdev_get_block(struct inode *inode, se
 	return 0;
 }
 
-static int blk_end_aio(struct bio *bio, unsigned int bytes_done, int error)
+struct bdev_aio {
+	atomic_t		iocount;	/* refcount */
+	atomic_t		bytes_done;	/* byte counter */
+	int			err;		/* error handling */
+	file_endio_t		*endio;		/* end I/O notify fn */
+	void			*endio_data;	/* notify fn private data */
+};
+
+static void blk_io_put(struct bdev_aio *io)
+{
+	if (!atomic_dec_and_test(&io->iocount))
+		return;
+
+	if (!io->endio)
+		return complete((struct completion*)io->endio_data);
+
+	io->endio(io->endio_data, atomic_read(&io->bytes_done), io->err);
+	kfree(io);
+}
+
+static int blk_bio_endio(struct bio *bio, unsigned int bytes_done, int error)
 {
-	struct kiocb *iocb = bio->bi_private;
-	atomic_t *bio_count = &iocb->ki_bio_count;
+	struct bdev_aio *io = bio->bi_private;
+
+	if (bio->bi_size)
+		return 1;
 
 	if (bio_data_dir(bio) == READ)
 		bio_check_pages_dirty(bio);
@@ -143,16 +165,21 @@ static int blk_end_aio(struct bio *bio, 
 		bio_put(bio);
 	}
 
-	/* iocb->ki_nbytes stores error code from LLDD */
-	if (error)
-		iocb->ki_nbytes = -EIO;
-
-	if (atomic_dec_and_test(bio_count))
-		aio_complete(iocb, iocb->ki_left, iocb->ki_nbytes);
+  	if (error)
+		io->err = error;
+	atomic_add(bytes_done, &io->bytes_done);
 
+	blk_io_put(io);
 	return 0;
 }
 
+static void blk_io_init(struct bdev_aio *io)
+{
+	atomic_set(&io->iocount, 1);
+	atomic_set(&io->bytes_done, 0);
+	io->err = 0;
+}
+
 #define VEC_SIZE	16
 struct pvec {
 	unsigned short nr;
@@ -208,24 +235,33 @@ blkdev_direct_IO(int rw, struct kiocb *i
 
 	unsigned long addr;	/* user iovec address */
 	size_t count;		/* user iovec len */
-	size_t nbytes = iocb->ki_nbytes = iocb->ki_left; /* total xfer size */
+	size_t nbytes;		 /* total xfer size */
 	loff_t size;		/* size of block device */
 	struct bio *bio;
-	atomic_t *bio_count = &iocb->ki_bio_count;
+	struct bdev_aio stack_io, *io;
+	file_endio_t *endio = aio_complete;
+	void *endio_data = iocb;
 	struct page *page;
 	struct pvec pvec;
 
 	pvec.nr = 0;
 	pvec.idx = 0;
 
+	io = &stack_io;
+	if (endio) {
+		io = kmalloc(sizeof(struct bdev_aio), GFP_KERNEL);
+		if (!io)
+			return -ENOMEM;
+	}
+	blk_io_init(io);
+
 	if (pos & blocksize_mask)
 		return -EINVAL;
 
+	nbytes = iov_length(iov, nr_segs);
 	size = i_size_read(inode);
-	if (pos + nbytes > size) {
+	if (pos + nbytes > size)
 		nbytes = size - pos;
-		iocb->ki_left = nbytes;
-	}
 
 	/*
 	 * check first non-zero iov alignment, the remaining
@@ -237,7 +273,6 @@ blkdev_direct_IO(int rw, struct kiocb *i
 		if (addr & blocksize_mask || count & blocksize_mask)
 			return -EINVAL;
 	} while (!count && ++seg < nr_segs);
-	atomic_set(bio_count, 1);
 
 	while (nbytes) {
 		/* roughly estimate number of bio vec needed */
@@ -248,8 +283,8 @@ blkdev_direct_IO(int rw, struct kiocb *i
 		/* bio_alloc should not fail with GFP_KERNEL flag */
 		bio = bio_alloc(GFP_KERNEL, nvec);
 		bio->bi_bdev = I_BDEV(inode);
-		bio->bi_end_io = blk_end_aio;
-		bio->bi_private = iocb;
+		bio->bi_end_io = blk_bio_endio;
+		bio->bi_private = io;
 		bio->bi_sector = pos >> blkbits;
 same_bio:
 		cur_off = addr & ~PAGE_MASK;
@@ -289,18 +324,27 @@ same_bio:
 		/* bio is ready, submit it */
 		if (rw == READ)
 			bio_set_pages_dirty(bio);
-		atomic_inc(bio_count);
+		atomic_inc(&io->iocount);
 		submit_bio(rw, bio);
 	}
 
 completion:
-	iocb->ki_left -= nbytes;
-	nbytes = iocb->ki_left;
-	iocb->ki_pos += nbytes;
+	if (!endio) {
+		struct completion event;
+
+		init_completion(&event);
+		io->endio = NULL;
+		io->endio_data = &event;
+
+		if (!atomic_dec_and_test(&io->iocount))
+			wait_for_completion(&event);
+		return io->err ? io->err : atomic_read(&io->bytes_done);
+	}
 
-	if (atomic_dec_and_test(bio_count))
-		aio_complete(iocb, nbytes, 0);
+	io->endio = endio;
+	io->endio_data = endio_data;
 
+	blk_io_put(io);
 	return -EIOCBQUEUED;
 
 backout:
@@ -316,7 +360,7 @@ backout:
 	 * if no bio was submmitted, return the error code.
 	 * otherwise, proceed with pending I/O completion.
 	 */
-	if (atomic_read(bio_count) == 1)
+	if (atomic_read(&io->iocount) == 1)
 		return PTR_ERR(page);
 	goto completion;
 }
