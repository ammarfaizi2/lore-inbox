Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVCIBzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVCIBzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVCIBxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:53:44 -0500
Received: from fmr23.intel.com ([143.183.121.15]:62163 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261507AbVCIBpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:45:22 -0500
Message-Id: <200503090145.j291j7g16386@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Jens Axboe'" <axboe@suse.de>
Subject: Direct io on block device has performance regression on 2.6.x kernel - fix sync I/O path
Date: Tue, 8 Mar 2005 17:45:07 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUkSNzKYDObGXK9SD6A7gSOX+GhIwAAAqtQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds block device direct I/O for synchronous path.
I added in the raw device code to demo the performance effect.

48% performance gain!!


			synchronous I/O
			(pread/pwrite/read/write)
2.6.9			218,565
2.6.9+patches	323,016

- Ken


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.9/drivers/char/raw.c linux-2.6.9.ken/drivers/char/raw.c
--- linux-2.6.9/drivers/char/raw.c	2004-10-18 14:54:37.000000000 -0700
+++ linux-2.6.9.ken/drivers/char/raw.c	2005-03-08 17:22:07.000000000 -0800
@@ -238,15 +238,151 @@ out:
 	return err;
 }

+struct rio {
+	atomic_t bio_count;
+	struct task_struct *p;
+};
+
+int raw_end_io(struct bio *bio, unsigned int bytes_done, int error)
+{
+	struct rio * rio = bio->bi_private;
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
+
+	if (atomic_dec_and_test(&rio->bio_count))
+		wake_up_process(rio->p);
+	return 0;
+}
+
+#define PAGE_QUICK_LIST	16
+static ssize_t raw_file_rw(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos, int rw)
+{
+	struct inode * inode = filp->f_mapping->host;
+	unsigned long blkbits = inode->i_blkbits;
+	unsigned long blocksize_mask = (1<< blkbits) - 1;
+	struct page * quick_list[PAGE_QUICK_LIST];
+	int nr_pages, cur_offset, cur_len, pg_idx;
+	struct bio * bio;
+	unsigned long ret;
+	unsigned long addr = (unsigned long) buf;
+	loff_t pos = *ppos, size;
+	struct rio rio;
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
+	atomic_set(&rio.bio_count, 1);
+	rio.p = current;
+
+start:
+	bio = bio_alloc(GFP_KERNEL, nr_pages);
+	if (unlikely(bio == NULL)) {
+		if (atomic_read(&rio.bio_count) == 1)
+			return -ENOMEM;
+		else {
+			goto out;
+		}
+	}
+
+	/* initialize bio */
+	bio->bi_bdev = I_BDEV(inode);
+	bio->bi_end_io = raw_end_io;
+	bio->bi_private = &rio;
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
+				if (atomic_read(&rio.bio_count) == 1)
+					return ret;
+				else {
+					goto out;
+				}
+			}
+			pg_idx = 0;
+		}
+
+		if (unlikely(!bio_add_page(bio, quick_list[pg_idx], cur_len,
+			cur_offset))) {
+			atomic_inc(&rio.bio_count);
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
+	atomic_inc(&rio.bio_count);
+	if (rw == READ)
+		bio_set_pages_dirty(bio);
+	submit_bio(rw, bio);
+out:
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	blk_run_address_space(inode->i_mapping);
+	if (!atomic_dec_and_test(&rio.bio_count))
+		io_schedule();
+	set_current_state(TASK_RUNNING);
+
+	ret = addr - (unsigned long) buf;
+	*ppos += ret;
+	return ret;
+}
+
+static ssize_t raw_file_read(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	return raw_file_rw(filp, buf, count, ppos, READ);
+}
+
 static ssize_t raw_file_write(struct file *file, const char __user *buf,
 				   size_t count, loff_t *ppos)
 {
-	struct iovec local_iov = {
-		.iov_base = (char __user *)buf,
-		.iov_len = count
-	};
-
-	return generic_file_write_nolock(file, &local_iov, 1, ppos);
+	return raw_file_rw(file, (char __user *) buf, count, ppos, WRITE);
 }

 static ssize_t raw_file_aio_write(struct kiocb *iocb, const char __user *buf,
@@ -262,7 +398,7 @@ static ssize_t raw_file_aio_write(struct


 static struct file_operations raw_fops = {
-	.read	=	generic_file_read,
+	.read	=	raw_file_read,
 	.aio_read = 	generic_file_aio_read,
 	.write	=	raw_file_write,
 	.aio_write = 	raw_file_aio_write,


