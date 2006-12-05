Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968354AbWLEEz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968354AbWLEEz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 23:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968355AbWLEEz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 23:55:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:18384 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968354AbWLEEzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 23:55:55 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,496,1157353200"; 
   d="scan'208"; a="23118554:sNHT1101764502"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "'Zach Brown'" <zach.brown@oracle.com>,
       "Chris Mason" <chris.mason@oracle.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [patch] optimize o_direct on block device - v2
Date: Mon, 4 Dec 2006 20:55:50 -0800
Message-ID: <000001c71829$a3378900$ba88030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccYKaLbnJHWLGUPTniHzHmlpYswQA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements block device specific .direct_IO method instead
of going through generic direct_io_worker for block device.

direct_io_worker is fairly complex because it needs to handle O_DIRECT
on file system, where it needs to perform block allocation, hole detection,
extents file on write, and tons of other corner cases. The end result is
that it takes tons of CPU time to submit an I/O.

For block device, the block allocation is much simpler and a tight triple
loop can be written to iterate each iovec and each page within the iovec
in order to construct/prepare bio structure and then subsequently submit
it to the block layer.  This significantly speeds up O_D on block device.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


---
Changes since v1->v2:

* add BUILD_BUG_ON to ensure bio_count fit inside iocb->private
* add comment that bio_alloc won't fail with GFP_KERNEL
* fix back out path if get_uer_pages fail
* fix back out path if iov segment doesn't align properly

 fs/bio.c            |    2
 fs/block_dev.c      |  173 ++++++++++++++++++++++++++++++++++++++++++++--------
 fs/read_write.c     |    2
 include/linux/bio.h |    1
 4 files changed, 150 insertions(+), 28 deletions(-)


--- ./fs/block_dev.c.orig	2006-11-29 13:57:37.000000000 -0800
+++ ./fs/block_dev.c	2006-12-04 18:38:53.000000000 -0800
@@ -129,43 +129,164 @@ blkdev_get_block(struct inode *inode, se
 	return 0;
 }
 
-static int
-blkdev_get_blocks(struct inode *inode, sector_t iblock,
-		struct buffer_head *bh, int create)
+int blk_end_aio(struct bio *bio, unsigned int bytes_done, int error)
 {
-	sector_t end_block = max_block(I_BDEV(inode));
-	unsigned long max_blocks = bh->b_size >> inode->i_blkbits;
+	struct kiocb* iocb = bio->bi_private;
+	atomic_t* bio_count = (atomic_t*) &iocb->private;
+	long res;
+
+	if ((bio->bi_rw & 1) == READ)
+		bio_check_pages_dirty(bio);
+	else {
+		bio_release_pages(bio);
+		bio_put(bio);
+	}
 
-	if ((iblock + max_blocks) > end_block) {
-		max_blocks = end_block - iblock;
-		if ((long)max_blocks <= 0) {
-			if (create)
-				return -EIO;	/* write fully beyond EOF */
-			/*
-			 * It is a read which is fully beyond EOF.  We return
-			 * a !buffer_mapped buffer
-			 */
-			max_blocks = 0;
-		}
+	if (error)
+		iocb->ki_left = -EIO;
+
+	if (atomic_dec_and_test(bio_count)) {
+		res = (iocb->ki_left < 0) ? iocb->ki_left : iocb->ki_nbytes;
+		aio_complete(iocb, res, 0);
 	}
 
-	bh->b_bdev = I_BDEV(inode);
-	bh->b_blocknr = iblock;
-	bh->b_size = max_blocks << inode->i_blkbits;
-	if (max_blocks)
-		set_buffer_mapped(bh);
 	return 0;
 }
 
+#define VEC_SIZE	16
+struct pvec {
+	unsigned short nr;
+	unsigned short idx;
+	struct page *page[VEC_SIZE];
+};
+
+
+struct page *blk_get_page(unsigned long addr, size_t count, int rw,
+			  struct pvec *pvec)
+{
+	int ret, nr_pages;
+	if (pvec->idx == pvec->nr) {
+		nr_pages = (addr + count + PAGE_SIZE - 1) / PAGE_SIZE -
+			    addr / PAGE_SIZE;
+		nr_pages = min(nr_pages, VEC_SIZE);
+		down_read(&current->mm->mmap_sem);
+		ret = get_user_pages(current, current->mm, addr, nr_pages,
+				     rw==READ, 0, pvec->page, NULL);
+		up_read(&current->mm->mmap_sem);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		pvec->nr = ret;
+		pvec->idx = 0;
+	}
+	return pvec->page[pvec->idx++];
+}
+
 static ssize_t
 blkdev_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs)
+		 loff_t pos, unsigned long nr_segs)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	unsigned blkbits = blksize_bits(bdev_hardsect_size(I_BDEV(inode)));
+	unsigned blocksize_mask = (1<< blkbits) - 1;
+	unsigned long seg, nvec, cur_off, cur_len;
+
+	unsigned long addr;
+	size_t count, nbytes = iocb->ki_nbytes;
+	loff_t size;
+	struct bio * bio;
+	atomic_t *bio_count = (atomic_t *) &iocb->private;
+	struct page *page;
+	struct pvec pvec = {.nr = 0, .idx = 0, };
+
+	BUILD_BUG_ON(sizeof(atomic_t) > sizeof(iocb->private));
+
+	size = i_size_read(inode);
+	if (pos + nbytes > size)
+		nbytes = size - pos;
+
+	seg = 0;
+	addr = (unsigned long) iov[0].iov_base;
+	count = iov[0].iov_len;
+	atomic_set(bio_count, 1);
+
+	/* first check the alignment */
+	if (addr & blocksize_mask || count & blocksize_mask ||
+		pos & blocksize_mask)
+		return -EINVAL;
+
+	while (nbytes) {
+		/* roughly estimate number of bio vec needed */
+		nvec = (nbytes + PAGE_SIZE - 1) / PAGE_SIZE;
+		nvec = max(nvec, nr_segs - seg);
+		nvec = min(nvec, (unsigned long) BIO_MAX_PAGES);
+
+		/* bio_alloc should not fail with GFP_KERNEL flag */
+		bio = bio_alloc(GFP_KERNEL, nvec);
+		bio->bi_bdev = I_BDEV(inode);
+		bio->bi_end_io = blk_end_aio;
+		bio->bi_private = iocb;
+		bio->bi_sector = pos >> blkbits;
+same_bio:
+		cur_off = addr & ~PAGE_MASK;
+		cur_len = PAGE_SIZE - cur_off;
+		if (count < cur_len)
+			cur_len = count;
+
+		page = blk_get_page(addr, count, rw, &pvec);
+		if (unlikely(IS_ERR(page)))
+			goto backout;
+
+		if (bio_add_page(bio, page, cur_len, cur_off)) {
+			pos += cur_len;
+			addr += cur_len;
+			count -= cur_len;
+			nbytes -= cur_len;
+
+			if (count)
+				goto same_bio;
+			if (++seg < nr_segs) {
+				addr = (unsigned long) iov[seg].iov_base;
+				count = iov[seg].iov_len;
+				if (unlikely(addr & blocksize_mask ||
+					     count & blocksize_mask))
+					goto backout;
+				goto same_bio;
+			}
+		}
+
+		/* bio is ready, submit it */
+		if (rw == READ)
+			bio_set_pages_dirty(bio);
+		atomic_inc(bio_count);
+		submit_bio(rw, bio);
+	}
+
+completion:
+	nbytes = iocb->ki_nbytes = iocb->ki_nbytes - nbytes;
+	iocb->ki_pos += nbytes;
 
-	return blockdev_direct_IO_no_locking(rw, iocb, inode, I_BDEV(inode),
-				iov, offset, nr_segs, blkdev_get_blocks, NULL);
+	blk_run_address_space(inode->i_mapping);
+	if (atomic_dec_and_test(bio_count))
+		aio_complete(iocb, nbytes, 0);
+
+	return -EIOCBQUEUED;
+
+backout:
+	/*
+	 * back out nbytes count constructed so far for this bio,
+	 * we will throw away current bio.
+	 */
+	nbytes -= bio->bi_size;
+	bio_release_pages(bio);
+	bio_put(bio);
+
+	/*
+	 * if no bio was submmitted, return the error code.
+	 * otherwise, proceed with pending I/O completion.
+	 */
+	if (atomic_read(bio_count) == 1)
+		return PTR_ERR(page);
+	goto completion;
 }
 
 static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
--- ./fs/read_write.c.orig	2006-11-29 13:57:37.000000000 -0800
+++ ./fs/read_write.c	2006-12-04 17:30:34.000000000 -0800
@@ -235,7 +235,7 @@ ssize_t do_sync_read(struct file *filp, 
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = *ppos;
-	kiocb.ki_left = len;
+	kiocb.ki_nbytes = kiocb.ki_left = len;
 
 	for (;;) {
 		ret = filp->f_op->aio_read(&kiocb, &iov, 1, kiocb.ki_pos);
--- ./fs/bio.c.orig	2006-11-29 13:57:37.000000000 -0800
+++ ./fs/bio.c	2006-12-04 17:30:34.000000000 -0800
@@ -931,7 +931,7 @@ void bio_set_pages_dirty(struct bio *bio
 	}
 }
 
-static void bio_release_pages(struct bio *bio)
+void bio_release_pages(struct bio *bio)
 {
 	struct bio_vec *bvec = bio->bi_io_vec;
 	int i;
--- ./include/linux/bio.h.orig	2006-11-29 13:57:37.000000000 -0800
+++ ./include/linux/bio.h	2006-12-04 17:30:34.000000000 -0800
@@ -309,6 +309,7 @@ extern struct bio *bio_map_kern(struct r
 				gfp_t);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
+extern void bio_release_pages(struct bio *bio);
 extern struct bio *bio_copy_user(struct request_queue *, unsigned long, unsigned int, int);
 extern int bio_uncopy_user(struct bio *);
 void zero_fill_bio(struct bio *bio);
