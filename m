Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316457AbSEOR6U>; Wed, 15 May 2002 13:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSEOR6T>; Wed, 15 May 2002 13:58:19 -0400
Received: from fungus.teststation.com ([212.32.186.211]:57098 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316457AbSEOR6R>; Wed, 15 May 2002 13:58:17 -0400
Date: Wed, 15 May 2002 19:58:12 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: <linux-kernel@vger.kernel.org>
Subject: loop.c with file->read/write ?
Message-ID: <Pine.LNX.4.33.0205151840140.15115-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

The loop device does not work with smbfs (and also not with some other
filesystems?). The loopback file quickly becomes corrupted. I asked for
suggestions on linux-fsdevel and got a bunch.

One idea was to change loop.c to use the file->read/write operations. The
patch below does that and with it all tests that used to fail now work.

The patch doesn't handle transfer functions and possibly not different
blocksizes. Those things can be fixed, the transfer functions would
probably need an extra buffer to encrypt into (eh, "transfer" into ...)

Before I do any more on this I'd like to know if there is anyone that has
reasons why this is a bad idea or otherwise cares about loop.c.

/Urban


--- linux-2.4.18-orig/drivers/block/loop.c	Tue May 14 00:26:40 2002
+++ linux-2.4.18/drivers/block/loop.c	Tue May 14 00:50:49 2002
@@ -172,116 +172,44 @@
 		   loff_t pos)
 {
 	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
-	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	struct address_space_operations *aops = mapping->a_ops;
-	struct page *page;
-	char *kaddr, *data;
+	mm_segment_t fs;
+	char *data;
 	unsigned long index;
-	unsigned size, offset;
-	int len;
+	unsigned offset;
+	int len, ret;
 
-	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & (PAGE_CACHE_SIZE - 1);
 	len = bh->b_size;
 	data = bh->b_data;
-	while (len > 0) {
-		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
-		int transfer_result;
-
-		size = PAGE_CACHE_SIZE - offset;
-		if (size > len)
-			size = len;
-
-		page = grab_cache_page(mapping, index);
-		if (!page)
-			goto fail;
-		if (aops->prepare_write(file, page, offset, offset+size))
-			goto unlock;
-		kaddr = page_address(page);
-		flush_dcache_page(page);
-		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset, data, size, IV);
-		if (transfer_result) {
-			/*
-			 * The transfer failed, but we still write the data to
-			 * keep prepare/commit calls balanced.
-			 */
-			printk(KERN_ERR "loop: transfer error block %ld\n", index);
-			memset(kaddr + offset, 0, size);
-		}
-		if (aops->commit_write(file, page, offset, offset+size))
-			goto unlock;
-		if (transfer_result)
-			goto unlock;
-		data += size;
-		len -= size;
-		offset = 0;
-		index++;
-		pos += size;
-		UnlockPage(page);
-		page_cache_release(page);
-	}
-	up(&mapping->host->i_sem);
-	return 0;
-
-unlock:
-	UnlockPage(page);
-	page_cache_release(page);
-fail:
-	up(&mapping->host->i_sem);
-	return -1;
-}
 
-struct lo_read_data {
-	struct loop_device *lo;
-	char *data;
-	int bsize;
-};
+	fs = get_fs();
+	set_fs(get_ds());
+	ret = file->f_op->write(file, data, len, &pos);
+	set_fs(fs);
 
-static int lo_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
-{
-	char *kaddr;
-	unsigned long count = desc->count;
-	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
-	struct loop_device *lo = p->lo;
-	int IV = page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
-
-	if (size > count)
-		size = count;
-
-	kaddr = kmap(page);
-	if (lo_do_transfer(lo, READ, kaddr + offset, p->data, size, IV)) {
-		size = 0;
-		printk(KERN_ERR "loop: transfer error block %ld\n",page->index);
-		desc->error = -EINVAL;
-	}
-	kunmap(page);
-	
-	desc->count = count - size;
-	desc->written += size;
-	p->data += size;
-	return size;
+	return ret < 0 ? ret : 0;
 }
 
 static int lo_receive(struct loop_device *lo, struct buffer_head *bh, int bsize,
 		      loff_t pos)
 {
-	struct lo_read_data cookie;
-	read_descriptor_t desc;
 	struct file *file;
+	mm_segment_t fs;
+	int ret;
 
-	cookie.lo = lo;
-	cookie.data = bh->b_data;
-	cookie.bsize = bsize;
-	desc.written = 0;
-	desc.count = bh->b_size;
-	desc.buf = (char*)&cookie;
-	desc.error = 0;
+	/* This looks strange, if someone free's lo won't they also fput
+	   lo_backing_file? */
 	spin_lock_irq(&lo->lo_lock);
 	file = lo->lo_backing_file;
 	spin_unlock_irq(&lo->lo_lock);
-	do_generic_file_read(file, &pos, &desc, lo_read_actor);
-	return desc.error;
+
+	fs = get_fs();
+	set_fs(get_ds());
+	ret = file->f_op->read(file, bh->b_data, bsize, &pos);
+	set_fs(fs);
+
+	return ret < 0 ? ret : 0;
 }
 
 static inline int loop_get_bs(struct loop_device *lo)

