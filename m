Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVCIB7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVCIB7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVCIBvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:51:45 -0500
Received: from fmr21.intel.com ([143.183.121.13]:23181 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262308AbVCIBt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:49:27 -0500
Message-Id: <200503090149.j291nGg16416@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Jens Axboe'" <axboe@suse.de>
Subject: Direct io on block device has performance regression on 2.6.x kernel - fix AIO path
Date: Tue, 8 Mar 2005 17:49:16 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUkSNzKYDObGXK9SD6A7gSOX+GhIwAAM18Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds block device direct I/O for AIO path.

30% performance gain!!

			AIO (io_submit)
2.6.9			206,917
2.6.9+patches	268,484

- Ken


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.9/drivers/char/raw.c	2005-03-08 17:22:07.000000000 -0800
+++ linux-2.6.9.ken/drivers/char/raw.c	2005-03-08 17:25:38.000000000 -0800
@@ -385,21 +385,148 @@ static ssize_t raw_file_write(struct fil
 	return raw_file_rw(file, (char __user *) buf, count, ppos, WRITE);
 }

-static ssize_t raw_file_aio_write(struct kiocb *iocb, const char __user *buf,
-					size_t count, loff_t pos)
+int raw_end_aio(struct bio *bio, unsigned int bytes_done, int error)
 {
-	struct iovec local_iov = {
-		.iov_base = (char __user *)buf,
-		.iov_len = count
-	};
+	struct kiocb* iocb = bio->bi_private;
+	atomic_t* bio_count = (atomic_t*) &iocb->private;
+
+	if ((bio->bi_rw & 0x1) == READ)
+		bio_check_pages_dirty(bio);
+	else {
+		int i;
+		struct bio_vec *bvec = bio->bi_io_vec;
+		struct page *page;
+	        for (i = 0; i < bio->bi_vcnt; i++) {
+			page = bvec[i].bv_page;
+			if (page)
+				put_page(page);
+		}
+		bio_put(bio);
+	}
+	if (atomic_dec_and_test(bio_count))
+		aio_complete(iocb, iocb->ki_nbytes, 0);

-	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
+	return 0;
 }

+static ssize_t raw_file_aio_rw(struct kiocb *iocb, char __user *buf,
+				size_t count, loff_t pos, int rw)
+{
+	struct inode * inode = iocb->ki_filp->f_mapping->host;
+	unsigned long blkbits = inode->i_blkbits;
+	unsigned long blocksize_mask = (1<< blkbits) - 1;
+	struct page * quick_list[PAGE_QUICK_LIST];
+	int nr_pages, cur_offset, cur_len;
+	struct bio * bio;
+	unsigned long ret;
+	unsigned long addr = (unsigned long) buf;
+	loff_t size;
+	int pg_idx;
+	atomic_t *bio_count = (atomic_t *) &iocb->private;
+
+	if (count == 0)
+		return 0;
+
+	/* first check the alignment */
+	if (addr & blocksize_mask || count & blocksize_mask ||
+		count < 0 || pos & blocksize_mask)
+		return -EINVAL;
+
+	size = i_size_read(inode);
+	if (pos >= size)
+		return -ENXIO;
+	if (pos + count > size)
+		count = size - pos;
+
+	nr_pages = (addr + count + PAGE_SIZE - 1) / PAGE_SIZE -
+			addr / PAGE_SIZE;
+
+	pg_idx = PAGE_QUICK_LIST;
+	atomic_set(bio_count, 1);
+
+start:
+	bio = bio_alloc(GFP_KERNEL, nr_pages);
+	if (unlikely(bio == NULL)) {
+		if (atomic_read(bio_count) == 1)
+			return -ENOMEM;
+		else {
+			iocb->ki_nbytes = addr - (unsigned long) buf;
+			goto out;
+		}
+	}
+
+	/* initialize bio */
+	bio->bi_bdev = I_BDEV(inode);
+	bio->bi_end_io = raw_end_aio;
+	bio->bi_private = iocb;
+	bio->bi_sector = pos >> blkbits;
+
+	while (count > 0) {
+		cur_offset = addr & ~PAGE_MASK;
+		cur_len = PAGE_SIZE - cur_offset;
+		if (cur_len > count)
+			cur_len = count;
+
+		if (pg_idx >= PAGE_QUICK_LIST) {
+			down_read(&current->mm->mmap_sem);
+			ret = get_user_pages(current, current->mm, addr,
+						min(nr_pages, PAGE_QUICK_LIST),
+						rw==READ, 0, quick_list, NULL);
+			up_read(&current->mm->mmap_sem);
+			if (unlikely(ret < 0)) {
+				bio_put(bio);
+				if (atomic_read(bio_count) == 1)
+					return ret;
+				else {
+					iocb->ki_nbytes = addr - (unsigned long) buf;
+					goto out;
+				}
+			}
+			pg_idx = 0;
+		}
+
+		if (unlikely(!bio_add_page(bio, quick_list[pg_idx], cur_len, cur_offset))) {
+			atomic_inc(bio_count);
+			if (rw == READ)
+				bio_set_pages_dirty(bio);
+			submit_bio(rw, bio);
+			pos += addr - (unsigned long) buf;
+			goto start;
+		}
+
+		addr += cur_len;
+		count -= cur_len;
+		pg_idx++;
+		nr_pages--;
+	}
+
+	atomic_inc(bio_count);
+	if (rw == READ)
+		bio_set_pages_dirty(bio);
+	submit_bio(rw, bio);
+out:
+	blk_run_address_space(inode->i_mapping);
+	if (atomic_dec_and_test(bio_count)) {
+		aio_complete(iocb, iocb->ki_nbytes, 0);
+	}
+
+	return -EIOCBQUEUED;
+}
+
+ssize_t raw_file_aio_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
+{
+	return raw_file_aio_rw(iocb, buf, count, pos, READ);
+}
+
+static ssize_t raw_file_aio_write(struct kiocb *iocb, const char __user *buf,
+					size_t count, loff_t pos)
+{
+	return raw_file_aio_rw(iocb, (char __user *) buf, count, pos, WRITE);
+}

 static struct file_operations raw_fops = {
 	.read	=	raw_file_read,
-	.aio_read = 	generic_file_aio_read,
+	.aio_read = 	raw_file_aio_read,
 	.write	=	raw_file_write,
 	.aio_write = 	raw_file_aio_write,
 	.open	=	raw_open,


