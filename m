Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSHOMcX>; Thu, 15 Aug 2002 08:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHOMcX>; Thu, 15 Aug 2002 08:32:23 -0400
Received: from [64.105.35.243] ([64.105.35.243]:26605 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316856AbSHOMcK>; Thu, 15 Aug 2002 08:32:10 -0400
Date: Thu, 15 Aug 2002 05:34:38 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Patch: linux-2.5.31/drivers/block/loop.c update
Message-ID: <20020815053438.A4196@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here is another update to loop.c, as a patch against
pristine linux-2.5.31.

	This patch adds support for loop devices backed by
files on file systems that do not provide
address_space_operations->{prepare,commit}_write, by using
file_operations->{read,write} instead.  The change is based on patches
by Jari Ruusu and Andrew Morton.  It includes an optimization,
pointed out by Andrew Morton, that avoids an extra data copy
in the common case of using a loop device that has no data
tranformation and is backed by a tmpfs file.

	I've also dropped the "bio remapping" optimization that I
actually got working in my previous patch, because it only optimized
the case of a loop device backed by a block device with no data
transformation, in which case there isn't much need for the loop
device.

	There is some code in this version to preallocate a page
for dealing with memory allocation failures in the IO path, but
I have not put in the IO path changes to make use of it yet.
The primary difference between this approach and Jari's is
that I want to reserve just one page (or queue->hardsect_size
bytes if that is more than a page) and be able to handle bio's
bigger than that (by splitting them up in the event of memory
allocation failure).

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop.diff"

--- linux-2.5.31/include/linux/loop.h	2002-08-10 18:41:29.000000000 -0700
+++ linux/include/linux/loop.h	2002-08-15 05:18:52.000000000 -0700
@@ -1,8 +1,3 @@
-#ifndef _LINUX_LOOP_H
-#define _LINUX_LOOP_H
-
-#include <linux/kdev_t.h>
-
 /*
  * include/linux/loop.h
  *
@@ -12,11 +7,19 @@
  * permitted under the GNU General Public License.
  */
 
+#ifndef _LINUX_LOOP_H
+#define _LINUX_LOOP_H
+
+#include <linux/kdev_t.h>
+
 #define LO_NAME_SIZE	64
 #define LO_KEY_SIZE	32
 
 #ifdef __KERNEL__
 
+#include <linux/blkdev.h>
+#include <linux/completion.h>
+
 /* Possible states of device */
 enum {
 	Lo_unbound,
@@ -24,10 +27,23 @@
 	Lo_rundown,
 };
 
+/* IV calculation related constants */
+#define LO_IV_MODE_DEFAULT 0 /* old logical block size based mode */
+#define LO_IV_MODE_SECTOR  1 /* calculate IV based on relative 
+				512 byte sectors */
+#define LO_IV_SECTOR_BITS 9
+#define LO_IV_SECTOR_SIZE (1 << LO_IV_SECTOR_BITS)
+
+struct loop_device;
+
+typedef int (*loop_file_xfer_t)(struct loop_device *lo, int rw,
+				void *data, int len, loff_t pos);
+
 struct loop_device {
+	request_queue_t	queue;
 	int		lo_number;
-	int		lo_refcnt;
-	int		lo_offset;
+	loff_t		lo_offset;
+	sector_t	lo_sector_offset; /* lo_offset / 512 */
 	int		lo_encrypt_type;
 	int		lo_encrypt_key_size;
 	int		lo_flags;
@@ -51,11 +67,15 @@
 	spinlock_t		lo_lock;
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
-	int			lo_state;
-	struct semaphore	lo_sem;
-	struct semaphore	lo_ctl_mutex;
+	struct completion	lo_thread_exited;
 	struct semaphore	lo_bh_mutex;
 	atomic_t		lo_pending;
+	int			lo_iv_mode;
+	struct list_head	lo_list;
+	loop_file_xfer_t	lo_file_io[2]; /* [0]=read and [1]=write */
+
+	struct semaphore	lo_backup_sem;
+	struct bio		lo_backup_bio;
 };
 
 typedef	int (* transfer_proc_t)(struct loop_device *, int cmd,
@@ -69,7 +89,6 @@
  */
 #define LO_FLAGS_DO_BMAP	1
 #define LO_FLAGS_READ_ONLY	2
-#define LO_FLAGS_BH_REMAP	4
 
 /* 
  * Note that this structure gets the wrong offsets when directly used
@@ -114,6 +133,7 @@
 #define LO_CRYPT_IDEA     6
 #define LO_CRYPT_DUMMY    9
 #define LO_CRYPT_SKIPJACK 10
+#define LO_CRYPT_CRYPTOAPI 18  /* international crypto patch */
 #define MAX_LO_CRYPT	20
 
 #ifdef __KERNEL__
--- linux-2.5.31/drivers/block/loop.c	2002-08-10 18:41:17.000000000 -0700
+++ linux/drivers/block/loop.c	2002-08-15 05:33:22.000000000 -0700
@@ -3,8 +3,10 @@
  *
  *  Written by Theodore Ts'o, 3/29/93
  * 
- * Copyright 1993 by Theodore Ts'o.  Redistribution of this file is
- * permitted under the GNU General Public License.
+ * Copyright 1993 by Theodore Ts'o.
+ * Copyright 2002 Yggdrasil Computing, Inc.
+ * Redistribution of this file is permitted under the GNU General 
+ * Public License.
  *
  * DES encryption plus some minor changes by Werner Almesberger, 30-MAY-1993
  * more DES encryption plus IDEA encryption by Nicholas J. Leon, June 20, 1996
@@ -36,8 +38,8 @@
  * Al Viro too.
  * Jens Axboe <axboe@suse.de>, Nov 2000
  *
- * Support up to 256 loop devices
- * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
+ * Fixed and made IV calculation customizable by lo_iv_mode
+ * Herbert Valerio Riedel <hvr@gnu.org>, Apr 2001
  *
  * Still To Fix:
  * - Advisory locking is ignored here. 
@@ -52,6 +54,19 @@
  *   problem above. Encryption modules that used to rely on the old scheme
  *   should just call ->i_mapping->bmap() to calculate the physical block
  *   number.
+ *
+ * Support up to 256 loop devices
+ * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
+ *
+ * Deleted "bio remapping" optimization for loop backed by a device file
+ * with no data tranformation, because that use is so rare.  Made loop
+ * devices be created on demand, eliminating max_loop module parameter.
+ * Made loop devices export DMA limits of their underlying devices.
+ * Eliminated huge unnecessary page allocations.  Fixed bugs.
+ * Made numerous clean-ups.  Added support for tmpfs, originally by
+ * Jari Ruusu and Andrew Morton.
+ * Adam J. Richter <adam@yggdrasil.com>, Aug 2002
+ *
  */ 
 
 #include <linux/config.h>
@@ -75,20 +90,69 @@
 #include <linux/loop.h>
 #include <linux/suspend.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
+#include <linux/list.h>
 
 #include <asm/uaccess.h>
 
 #define MAJOR_NR LOOP_MAJOR
 
-static int max_loop = 8;
-static struct loop_device *loop_dev;
-static int *loop_sizes;
+#define SECTOR_SIZE		512
+#define SECTOR_MASK		(SECTOR_SIZE - 1)
+
+struct sync_xfer {
+	struct bio		*loop_bio;
+	unsigned int		offset;
+	struct completion	done;
+};
+
+typedef ssize_t (*read_write_func_t) (struct file *, char *, size_t, loff_t *);
+
+static int max_loop;		/* = 0.  Highest /dev/loop/nnn created.  */
 static devfs_handle_t devfs_handle;      /*  For the directory */
 
+spinlock_t loop_devs_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(loop_devs);
+
+static void create_dev_loop(int dev_minor);
+static int lo_file_copy(struct loop_device *lo, int rw,
+			void *data, int size, loff_t pos);
+
+
+static inline int loop_get_bs(struct loop_device *lo)
+{
+	struct block_device *bdev = lo->lo_device;
+	return bdev ? block_size(lo->lo_device) : PAGE_CACHE_SIZE;
+}
+
+static inline unsigned long loop_get_iv(struct loop_device *lo,
+					unsigned long sector)
+{
+	int bs;
+	unsigned long offset, IV;
+
+	sector += lo->lo_sector_offset; /* FIXME.  Make IV independent of
+					   location of the loop device. */
+	switch (lo->lo_iv_mode) {
+		case LO_IV_MODE_SECTOR:
+			/* BUG_ON(LO_IV_SECTOR_BITS != 9); */
+			return sector;
+
+		default:
+			printk (KERN_WARNING "loop: unexpected lo_iv_mode\n");
+		case LO_IV_MODE_DEFAULT:
+			bs = loop_get_bs(lo);
+			IV = sector / ((unsigned long) (bs >> 9));
+			offset = ((unsigned long) (((sector % (bs >> 9)) << 9) + lo->lo_offset)) % bs;
+			if (offset >= bs)
+				IV++;
+			return IV;
+	}
+}
+
 /*
  * Transfer functions
  */
-static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
+static int copy_transfer(struct loop_device *lo, int cmd, char *raw_buf,
 			 char *loop_buf, int size, int real_block)
 {
 	if (raw_buf != loop_buf) {
@@ -101,7 +165,20 @@
 	return 0;
 }
 
-static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
+static int copy_init(struct loop_device *lo, struct loop_info *info)
+{
+	if ((lo->lo_flags & LO_FLAGS_DO_BMAP) &&
+	    !lo->lo_backing_file->f_dentry->d_inode->i_mapping->a_ops->prepare_write) {
+		/* Do the transfer with file_operatios->{read,write}.
+		   No need to allocate an intermediate buffer. */
+		lo->lo_file_io[READ] = lo_file_copy;
+		lo->lo_file_io[WRITE] = lo_file_copy;
+	}
+
+	return 0;
+}
+
+static int xor_transfer(struct loop_device *lo, int cmd, char *raw_buf,
 			char *loop_buf, int size, int real_block)
 {
 	char	*in, *out, *key;
@@ -118,17 +195,11 @@
 	key = lo->lo_encrypt_key;
 	keysize = lo->lo_encrypt_key_size;
 	for (i = 0; i < size; i++)
-		*out++ = *in++ ^ key[(i & 511) % keysize];
-	return 0;
-}
-
-static int none_status(struct loop_device *lo, struct loop_info *info)
-{
-	lo->lo_flags |= LO_FLAGS_BH_REMAP;
+		*out++ = *in++ ^ key[(i & (SECTOR_SIZE - 1)) % keysize];
 	return 0;
 }
 
-static int xor_status(struct loop_device *lo, struct loop_info *info)
+static int xor_init(struct loop_device *lo, struct loop_info *info)
 {
 	if (info->lo_encrypt_key_size <= 0)
 		return -EINVAL;
@@ -136,15 +207,15 @@
 }
 
 struct loop_func_table none_funcs = { 
-	number: LO_CRYPT_NONE,
-	transfer: transfer_none,
-	init: none_status,
+	.number =	LO_CRYPT_NONE,
+	.transfer =	copy_transfer,
+	.init =		copy_init,
 }; 	
 
 struct loop_func_table xor_funcs = { 
-	number: LO_CRYPT_XOR,
-	transfer: transfer_xor,
-	init: xor_status
+	.number =	LO_CRYPT_XOR,
+	.transfer =	xor_transfer,
+	.init =		xor_init,
 }; 	
 
 /* xfer_funcs[0] is special - its release function is never called */ 
@@ -153,113 +224,87 @@
 	&xor_funcs  
 };
 
-#define MAX_DISK_SIZE 1024*1024*1024
-
-static unsigned long
-compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry)
-{
-	loff_t size = lo_dentry->d_inode->i_mapping->host->i_size;
-	return (size - lo->lo_offset) >> BLOCK_SIZE_BITS;
-}
-
-static void figure_loop_size(struct loop_device *lo)
+static loff_t
+compute_loop_size(struct loop_device *lo)
 {
-	loop_sizes[lo->lo_number] = compute_loop_size(lo,
-					lo->lo_backing_file->f_dentry);
-					
+	return lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
 }
 
-static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
-				 char *lbuf, int size, int rblock)
+static u64
+compute_loop_sectors(struct loop_device *lo)
 {
-	if (!lo->transfer)
-		return 0;
-
-	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
+	return (compute_loop_size(lo) + (SECTOR_SIZE-1) - lo->lo_offset) >> 9;
 }
 
 static int
-do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos)
+lo_aops_send(struct loop_device *lo, int rw, void *data, int size, loff_t pos)
 {
 	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
-	char *kaddr, *data;
+	char *kaddr;
 	unsigned long index;
-	unsigned size, offset;
-	int len;
-	int ret = 0;
+	unsigned offset, this_size, end;
+	int ret = -1;
+	unsigned long IV;
+	int transfer_result;
 
 	down(&mapping->host->i_sem);
+
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & (PAGE_CACHE_SIZE - 1);
-	data = kmap(bvec->bv_page) + bvec->bv_offset;
-	len = bvec->bv_len;
-	while (len > 0) {
-		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
-		int transfer_result;
-
-		size = PAGE_CACHE_SIZE - offset;
-		if (size > len)
-			size = len;
+
+	/* pos is not necessarily page aligned.  So, we loop, in
+	   case the transfer writes to two pages. */
+	for(;;) {
+		end = min(offset + size, (unsigned) PAGE_CACHE_SIZE);
+		this_size = end - offset;
+
+		IV = loop_get_iv(lo,
+				 (pos - lo->lo_offset) >> LO_IV_SECTOR_BITS);
 
 		page = grab_cache_page(mapping, index);
 		if (!page)
 			goto fail;
-		if (aops->prepare_write(file, page, offset, offset+size))
-			goto unlock;
-		kaddr = page_address(page);
+		if (aops->prepare_write(file, page, offset, end))
+			goto unlock_fail;
+		kaddr = page_address(page) + offset;
 		flush_dcache_page(page);
-		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset, data, size, IV);
+		transfer_result = (*lo->transfer)(lo, WRITE, kaddr, data,
+						 this_size, IV);
 		if (transfer_result) {
 			/*
 			 * The transfer failed, but we still write the data to
 			 * keep prepare/commit calls balanced.
 			 */
-			printk(KERN_ERR "loop: transfer error block %ld\n", index);
-			memset(kaddr + offset, 0, size);
+			printk(KERN_ERR
+			       "loop: transfer error block %ld\n", index);
+			memset(kaddr, 0, this_size);
 		}
-		if (aops->commit_write(file, page, offset, offset+size))
-			goto unlock;
-		if (transfer_result)
-			goto unlock;
-		data += size;
-		len -= size;
-		offset = 0;
-		index++;
-		pos += size;
+
+		if (aops->commit_write(file, page, offset, end) ||
+		    transfer_result)
+			goto unlock_fail;
+
+		size -= this_size;
+		if (size == 0)
+			break;
+
 		unlock_page(page);
 		page_cache_release(page);
+		index++;
+		offset = 0;
+		data += this_size;
 	}
-	up(&mapping->host->i_sem);
-out:
-	kunmap(bvec->bv_page);
-	return ret;
+	ret = 0;
 
-unlock:
+unlock_fail:
 	unlock_page(page);
 	page_cache_release(page);
+
 fail:
 	up(&mapping->host->i_sem);
-	ret = -1;
-	goto out;
-}
-
-static int
-lo_send(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
-{
-	unsigned vecnr;
-	int ret = 0;
-
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
-
-		ret = do_lo_send(lo, bvec, bsize, pos);
-		if (ret < 0)
-			break;
-		pos += bvec->bv_len;
-	}
 	return ret;
 }
 
@@ -272,22 +317,31 @@
 static int lo_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	char *kaddr;
-	unsigned long count = desc->count;
-	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
-	struct loop_device *lo = p->lo;
-	int IV = page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
+	unsigned long count;
+	struct lo_read_data *p;
+	struct loop_device *lo;
+	unsigned long IV;
+
+	count = desc->count;
+	p = (struct lo_read_data*)desc->buf;
+	lo = p->lo;
+	IV = loop_get_iv(lo,
+		((page->index <<  (PAGE_CACHE_SHIFT - LO_IV_SECTOR_BITS))
+		+ (offset >> LO_IV_SECTOR_BITS)
+		- lo->lo_sector_offset)); /* assumes LO_IV_SECTOR_BITS == 9. */
+
+	/* BUG_ON(LO_IV_SECTOR_BITS != 9); 	gcc 3.1 appears to have a problem with BUG_ON(0). */
 
 	if (size > count)
 		size = count;
 
 	kaddr = kmap(page);
-	if (lo_do_transfer(lo, READ, kaddr + offset, p->data, size, IV)) {
+	if ((*lo->transfer)(lo, READ, kaddr + offset, p->data, size, IV)) {
 		size = 0;
 		printk(KERN_ERR "loop: transfer error block %ld\n",page->index);
 		desc->error = -EINVAL;
 	}
 	kunmap(page);
-	
 	desc->count = count - size;
 	desc->written += size;
 	p->data += size;
@@ -295,95 +349,119 @@
 }
 
 static int
-do_lo_receive(struct loop_device *lo,
-		struct bio_vec *bvec, int bsize, loff_t pos)
+lo_aops_receive(struct loop_device *lo, int rw, void *data, int bv_len,
+		loff_t pos)
 {
 	struct lo_read_data cookie;
 	read_descriptor_t desc;
-	struct file *file;
 
 	cookie.lo = lo;
-	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
-	cookie.bsize = bsize;
+	cookie.data = data;
+	cookie.bsize = 	loop_get_bs(lo);
 	desc.written = 0;
-	desc.count = bvec->bv_len;
+	desc.count = bv_len;
 	desc.buf = (char*)&cookie;
 	desc.error = 0;
-	spin_lock_irq(&lo->lo_lock);
-	file = lo->lo_backing_file;
-	spin_unlock_irq(&lo->lo_lock);
-	do_generic_file_read(file, &pos, &desc, lo_read_actor);
-	kunmap(bvec->bv_page);
+	do_generic_file_read(lo->lo_backing_file, &pos, &desc, lo_read_actor);
 	return desc.error;
 }
 
 static int
-lo_receive(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+lo_file_copy(struct loop_device *lo, int rw, void *data, int size, loff_t pos)
 {
-	unsigned vecnr;
-	int ret = 0;
-
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+	mm_segment_t fs;
+	int res;
+	struct file *file = lo->lo_backing_file;
+	struct file_operations *f_op = file->f_op;
+	read_write_func_t xfer =
+		(rw == READ) ? f_op->read : ((read_write_func_t) f_op->write);
 
-		ret = do_lo_receive(lo, bvec, bsize, pos);
-		if (ret < 0)
+	fs = get_fs();
+	set_fs(get_ds());
+	do {
+		res = (*xfer)(file, data, size, &pos);
+		if (res > 0) {
+			data += res;
+			size -= res;
+		}
+		else if (res == 0 && rw == WRITE)
+			continue;
+		else if ((res == -EAGAIN) || (res == -ENOMEM)
+			   || (res == -ERESTART) || (res == -EINTR)) {
+			blk_run_queues();
+			schedule();
+			continue;
+		}
+		else
 			break;
-		pos += bvec->bv_len;
-	}
-	return ret;
-}
 
-static inline int loop_get_bs(struct loop_device *lo)
-{
-	return block_size(lo->lo_device);
+	} while (size != 0);
+	return (res < 0);
 }
 
-static inline unsigned long loop_get_iv(struct loop_device *lo,
-					unsigned long sector)
+static int
+lo_file_xfer(struct loop_device *lo, int rw, void *data, int size, loff_t pos)
 {
-	int bs = loop_get_bs(lo);
-	unsigned long offset, IV;
+	struct page *scratch_page = lo->lo_backup_bio.bi_io_vec[0].bv_page;
+	void *scratch;
+	int err;
+
+	/* down(&lo->lo_backup_sem);		Not yet necesssary */
+
+	scratch = kmap(scratch_page);
 
-	IV = sector / (bs >> 9) + lo->lo_offset / bs;
-	offset = ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
-	if (offset >= bs)
-		IV++;
+	err =
+		(rw == READ &&
+		 lo_file_copy(lo, READ, scratch, size, pos))
 
-	return IV;
+		|| (*lo->transfer)(lo, rw, scratch, data, size,
+				loop_get_iv(lo, (unsigned long) (pos >> 9)))
+
+		|| (rw == WRITE &&
+		    lo_file_copy(lo, WRITE, scratch, size, pos));
+
+	kunmap(scratch_page);
+
+	/* up(&lo->lo_backup_sem);		Not yet necesssary */
+
+	return err;
 }
 
+
 static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
 {
-	loff_t pos;
-	int ret;
+	loff_t pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
+	unsigned vecnr;
+	int ret = 0;
+	struct bio_vec *bvec = bio->bi_io_vec;
+	int rw = bio->bi_rw & 1;
+	loop_file_xfer_t xfer = lo->lo_file_io[rw];
 
-	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
+	bio_for_each_segment(bvec, bio, vecnr) {
+		void *loop_data = kmap(bvec->bv_page) + bvec->bv_offset;
 
-	do {
-		if (bio_rw(bio) == WRITE)
-			ret = lo_send(lo, bio, loop_get_bs(lo), pos);
-		else
-			ret = lo_receive(lo, bio, loop_get_bs(lo), pos);
+		ret = (*xfer)(lo, rw, loop_data, bvec->bv_len, pos);
 
-	} while (++bio->bi_idx < bio->bi_vcnt);
+		if (rw == READ)
+			flush_dcache_page(bvec->bv_page);
+
+		kunmap(bvec->bv_page);
+		if (ret < 0)
+			break;
+
+		pos += bvec->bv_len;
+	}
 
 	return ret;
 }
 
-static void loop_end_io_transfer(struct bio *);
 static void loop_put_buffer(struct bio *bio)
 {
-	/*
-	 * check bi_end_io, may just be a remapped bio
-	 */
-	if (bio && bio->bi_end_io == loop_end_io_transfer) {
-		int i;
-		for (i = 0; i < bio->bi_vcnt; i++)
-			__free_page(bio->bi_io_vec[i].bv_page);
+	int i;
+	for (i = 0; i < bio->bi_vcnt; i++)
+		__free_page(bio->bi_io_vec[i].bv_page);
 
-		bio_put(bio);
-	}
+	bio_put(bio);
 }
 
 /*
@@ -432,7 +510,7 @@
 static void loop_end_io_transfer(struct bio *bio)
 {
 	struct bio *rbh = bio->bi_private;
-	struct loop_device *lo = &loop_dev[minor(to_kdev_t(rbh->bi_bdev->bd_dev))];
+	struct loop_device *lo = rbh->bi_bdev->bd_queue->queuedata;
 	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 
 	if (!uptodate || bio_rw(bio) == WRITE) {
@@ -444,25 +522,16 @@
 		loop_add_bio(lo, bio);
 }
 
-static struct bio *loop_get_buffer(struct loop_device *lo, struct bio *rbh)
+static inline struct bio *
+loop_get_buffer(struct loop_device *lo, struct bio *rbh)
 {
 	struct bio *bio;
 
-	/*
-	 * for xfer_funcs that can operate on the same bh, do that
-	 */
-	if (lo->lo_flags & LO_FLAGS_BH_REMAP) {
-		bio = rbh;
-		goto out_bh;
-	}
-
-	bio = bio_copy(rbh, GFP_NOIO, rbh->bi_rw & WRITE);
+	bio = bio_copy(rbh, GFP_NOIO, 0);
 
 	bio->bi_end_io = loop_end_io_transfer;
 	bio->bi_private = rbh;
-
-out_bh:
-	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
+	bio->bi_sector = rbh->bi_sector + lo->lo_sector_offset;
 	bio->bi_rw = rbh->bi_rw;
 	bio->bi_bdev = lo->lo_device;
 
@@ -473,44 +542,42 @@
 bio_transfer(struct loop_device *lo, struct bio *to_bio,
 			      struct bio *from_bio)
 {
-	unsigned long IV = loop_get_iv(lo, from_bio->bi_sector);
+	const sector_t from_sector = from_bio->bi_sector;
+	unsigned long IV;
+	off_t offset = 0;
 	struct bio_vec *from_bvec, *to_bvec;
 	char *vto, *vfrom;
 	int ret = 0, i;
 
 	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
+		IV = loop_get_iv(lo, from_sector + (offset >> 9));
 		to_bvec = &to_bio->bi_io_vec[i];
 
 		kmap(from_bvec->bv_page);
 		kmap(to_bvec->bv_page);
 		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
 		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
-		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-					from_bvec->bv_len, IV);
+		ret |= (*lo->transfer)(lo, bio_data_dir(to_bio), vto, vfrom,
+				       from_bvec->bv_len, IV);
 		kunmap(from_bvec->bv_page);
 		kunmap(to_bvec->bv_page);
+		offset += from_bvec->bv_len;
 	}
 
 	return ret;
 }
-		
+
+static int loop_make_request_err(request_queue_t *q, struct bio *bio)
+{
+	return -EINVAL;
+}
+
+
 static int loop_make_request(request_queue_t *q, struct bio *old_bio)
 {
 	struct bio *new_bio = NULL;
-	struct loop_device *lo;
-	unsigned long IV;
+	struct loop_device *lo = old_bio->bi_bdev->bd_queue->queuedata;
 	int rw = bio_rw(old_bio);
-	int unit = minor(to_kdev_t(old_bio->bi_bdev->bd_dev));
-
-	if (unit >= max_loop)
-		goto out;
-
-	lo = &loop_dev[unit];
-	spin_lock_irq(&lo->lo_lock);
-	if (lo->lo_state != Lo_bound)
-		goto inactive;
-	atomic_inc(&lo->lo_pending);
-	spin_unlock_irq(&lo->lo_lock);
 
 	if (rw == WRITE) {
 		if (lo->lo_flags & LO_FLAGS_READ_ONLY)
@@ -528,6 +595,7 @@
 	 * file backed, queue for loop_thread to handle
 	 */
 	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
+		atomic_inc(&lo->lo_pending);
 		loop_add_bio(lo, old_bio);
 		return 0;
 	}
@@ -536,25 +604,20 @@
 	 * piggy old buffer on original, and submit for I/O
 	 */
 	new_bio = loop_get_buffer(lo, old_bio);
-	IV = loop_get_iv(lo, old_bio->bi_sector);
 	if (rw == WRITE) {
-		if (bio_transfer(lo, new_bio, old_bio))
+		if (bio_transfer(lo, new_bio, old_bio)) {
+			loop_put_buffer(new_bio);
 			goto err;
+		}
 	}
 
+	atomic_inc(&lo->lo_pending);
 	generic_make_request(new_bio);
 	return 0;
 
 err:
-	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
-	loop_put_buffer(new_bio);
-out:
 	bio_io_error(old_bio);
 	return 0;
-inactive:
-	spin_unlock_irq(&lo->lo_lock);
-	goto out;
 }
 
 static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
@@ -602,14 +665,8 @@
 
 	set_user_nice(current, -20);
 
-	lo->lo_state = Lo_bound;
 	atomic_inc(&lo->lo_pending);
 
-	/*
-	 * up sem, we are running
-	 */
-	up(&lo->lo_sem);
-
 	for (;;) {
 		down_interruptible(&lo->lo_bh_mutex);
 		/*
@@ -621,7 +678,7 @@
 
 		bio = loop_get_bio(lo);
 		if (!bio) {
-			printk("loop: missing bio\n");
+			printk(KERN_WARNING "loop: missing bio\n");
 			continue;
 		}
 		loop_handle_bio(lo, bio);
@@ -634,25 +691,33 @@
 			break;
 	}
 
-	up(&lo->lo_sem);
+	complete(&lo->lo_thread_exited);
 	return 0;
 }
 
-static int loop_set_fd(struct loop_device *lo, struct file *lo_file,
+static void backup_bio_destructor(struct bio *bio)
+{
+	struct loop_device *lo = bio->bi_private;
+
+	up(&lo->lo_backup_sem);
+}
+
+
+static int loop_set_fd(struct file *lo_file,
 		       struct block_device *bdev, unsigned int arg)
 {
+	struct loop_device *lo;
 	struct file	*file;
 	struct inode	*inode;
 	kdev_t		dev = to_kdev_t(bdev->bd_dev);
 	struct block_device *lo_device;
 	int		lo_flags = 0;
 	int		error;
-
-	MOD_INC_USE_COUNT;
-
-	error = -EBUSY;
-	if (lo->lo_state != Lo_unbound)
-		goto out;
+	request_queue_t *q;
+	int		num_pages;
+	int		kmalloc_size;
+	int		i;
+	struct		bio_vec *bvec;
 
 	error = -EBADF;
 	file = fget(arg);
@@ -671,83 +736,131 @@
 			error = -EBUSY;
 			goto out;
 		}
-	} else if (S_ISREG(inode->i_mode)) {
-		struct address_space_operations *aops = inode->i_mapping->a_ops;
-		/*
-		 * If we can't read - sorry. If we only can't write - well,
-		 * it's going to be read-only.
-		 */
-		if (!aops->readpage)
-			goto out_putf;
 
-		if (!aops->prepare_write || !aops->commit_write)
-			lo_flags |= LO_FLAGS_READ_ONLY;
+		/* We will ignore the underlying device's page cache, so
+		   first send any data in it to disk, without waiting.
+		   The bio layer will process these writes before any of
+		   our reads. */
+		filemap_fdatawrite(inode->i_mapping);
 
-		lo_device = inode->i_sb->s_bdev;
-		lo_flags |= LO_FLAGS_DO_BMAP;
-		error = 0;
+	} else if (S_ISREG(inode->i_mode)) {
+		lo_device = inode->i_sb->s_bdev; /* can be NULL (tmpfs) */
 	} else
 		goto out_putf;
 
 	get_file(file);
 
-	if (IS_RDONLY (inode) || bdev_read_only(lo_device)
+	if (IS_RDONLY (inode) || (lo_device && bdev_read_only(lo_device))
 	    || !(lo_file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
+
+	if (lo_device == NULL)
+		num_pages = 1;
+	else
+		num_pages = (lo_device->bd_queue->hardsect_size +
+			     PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+
+	kmalloc_size = sizeof(struct loop_device) +
+		(sizeof(struct bio_vec) * num_pages);
+
+	error = -ENOMEM;
+	lo = kmalloc(kmalloc_size, GFP_KERNEL);
+	if (lo == NULL)
+		goto out_putf;
+
+	memset(lo, 0, kmalloc_size); /* clear the bvec's as well */
+	bvec = lo->lo_backup_bio.bi_io_vec = (struct bio_vec*) &lo[1];
+	for (i = 0; i < num_pages; i++) {
+		bvec->bv_page = alloc_page(GFP_KERNEL);
+		if (!bvec->bv_page) {
+			while(i--) {
+				__free_page(bvec->bv_page);
+			}
+			kfree(lo);
+			goto out_putf;
+		}
+	}
+	lo->lo_backup_bio.bi_destructor = backup_bio_destructor;
+
+	error = 0;
+
 	set_device_ro(dev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
+	spin_lock(&loop_devs_lock);
+	list_add(&lo->lo_list, &loop_devs);
+	spin_unlock(&loop_devs_lock);
+
+	init_completion(&lo->lo_thread_exited);
+	init_MUTEX_LOCKED(&lo->lo_bh_mutex);
+	lo->lo_number = minor(dev);
+	spin_lock_init(&lo->lo_lock);
+
 	lo->lo_device = lo_device;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
-	figure_loop_size(lo);
+	lo->lo_iv_mode = LO_IV_MODE_DEFAULT;
+
+	lo->queue.queuedata = lo;
+	q = &lo->queue;
+	blk_queue_make_request(q, loop_make_request_err);
+	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
+	if (lo_device != NULL) {
+		struct request_queue *devq = lo_device->bd_queue;
+
+		blk_queue_max_sectors(q, devq->max_sectors);
+		blk_queue_max_phys_segments(q, devq->max_phys_segments);
+		blk_queue_max_hw_segments(q, devq->max_hw_segments);
+		blk_queue_hardsect_size(q, devq->hardsect_size);
+		blk_queue_max_segment_size(q, devq->max_segment_size);
+	}
+
+	bdev->bd_queue = q;
+	bdev->bd_openers++;
+	atomic_inc(&bdev->bd_count);
+	MOD_INC_USE_COUNT;
+
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask = GFP_NOIO;
 
-	set_blocksize(bdev, block_size(lo_device));
+	set_blocksize(bdev, loop_get_bs(lo));
+	bdev->bd_inode->i_size = compute_loop_size(lo);
 
 	lo->lo_bio = lo->lo_biotail = NULL;
 	kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
-	down(&lo->lo_sem);
-
-	fput(file);
-	return 0;
 
  out_putf:
 	fput(file);
  out:
-	MOD_DEC_USE_COUNT;
+
 	return error;
 }
 
 static int loop_release_xfer(struct loop_device *lo)
 {
 	int err = 0; 
-	if (lo->lo_encrypt_type) {
-		struct loop_func_table *xfer= xfer_funcs[lo->lo_encrypt_type]; 
-		if (xfer && xfer->release)
-			err = xfer->release(lo); 
-		if (xfer && xfer->unlock)
-			xfer->unlock(lo); 
-		lo->lo_encrypt_type = 0;
-	}
+	struct loop_func_table *xfer= xfer_funcs[lo->lo_encrypt_type]; 
+
+	if (xfer && xfer->release)
+		err = xfer->release(lo); 
+	if (xfer && xfer->unlock)
+		xfer->unlock(lo); 
+	lo->lo_encrypt_type = 0;
 	return err;
 }
 
 static int loop_init_xfer(struct loop_device *lo, int type,struct loop_info *i)
 {
 	int err = 0; 
-	if (type) {
-		struct loop_func_table *xfer = xfer_funcs[type]; 
-		if (xfer->init)
-			err = xfer->init(lo, i);
-		if (!err) { 
-			lo->lo_encrypt_type = type;
-			if (xfer->lock)
-				xfer->lock(lo);
-		}
+	struct loop_func_table *xfer = xfer_funcs[type]; 
+	if (xfer->init)
+		err = xfer->init(lo, i);
+	if (!err) { 
+		lo->lo_encrypt_type = type;
+		if (xfer->lock)
+			xfer->lock(lo);
 	}
 	return err;
 }  
@@ -755,71 +868,85 @@
 static int loop_clr_fd(struct loop_device *lo, struct block_device *bdev)
 {
 	struct file *filp = lo->lo_backing_file;
-	int gfp = lo->old_gfp_mask;
+	int num_pages;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
-	if (lo->lo_refcnt > 1)	/* we needed one fd for the ioctl */
+	if (bdev->bd_openers != 2)	/* one for this fd being open plus
+					   one incremented by loop_set_fd */
 		return -EBUSY;
-	if (filp==NULL)
-		return -EINVAL;
 
-	spin_lock_irq(&lo->lo_lock);
-	lo->lo_state = Lo_rundown;
+	num_pages = (lo->queue.hardsect_size + PAGE_CACHE_SIZE - 1)
+		>> PAGE_CACHE_SHIFT;
+
+	lo->queue.queuedata = NULL;
 	if (atomic_dec_and_test(&lo->lo_pending))
 		up(&lo->lo_bh_mutex);
-	spin_unlock_irq(&lo->lo_lock);
-
-	down(&lo->lo_sem);
 
-	lo->lo_backing_file = NULL;
+	wait_for_completion(&lo->lo_thread_exited);
 
 	loop_release_xfer(lo);
-	lo->transfer = NULL;
-	lo->ioctl = NULL;
-	lo->lo_device = NULL;
-	lo->lo_encrypt_type = 0;
-	lo->lo_offset = 0;
-	lo->lo_encrypt_key_size = 0;
-	lo->lo_flags = 0;
-	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
-	memset(lo->lo_name, 0, LO_NAME_SIZE);
-	loop_sizes[lo->lo_number] = 0;
 	invalidate_bdev(bdev, 0);
-	filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
-	lo->lo_state = Lo_unbound;
+	bdev->bd_queue = NULL;		/* FIXME?: Is this necessary? */
+	bdev->bd_openers--;
+	atomic_dec(&bdev->bd_count);
+	filp->f_dentry->d_inode->i_mapping->gfp_mask = lo->old_gfp_mask;
 	fput(filp);
+
+	spin_lock(&loop_devs_lock);
+	list_del(&lo->lo_list);
+	spin_unlock(&loop_devs_lock);
+
+	while (num_pages--) {
+		__free_page(lo->lo_backup_bio.bi_io_vec[num_pages].bv_page);
+	}
+
+	memset(lo, 0, sizeof(*lo)); /* Erase encryption key and other clues. */
+	kfree(lo);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
-static int loop_set_status(struct loop_device *lo, struct loop_info *arg)
+static int loop_set_status(struct loop_device *lo,
+			   struct block_device *bdev,
+			   struct loop_info *arg)
 {
 	struct loop_info info; 
 	int err;
 	unsigned int type;
+	struct inode *inode = lo->lo_backing_file->f_dentry->d_inode;
 
 	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid && 
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
 	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
 		return -EFAULT; 
 	if ((unsigned int) info.lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
-	type = info.lo_encrypt_type; 
+	type = info.lo_encrypt_type;
 	if (type >= MAX_LO_CRYPT || xfer_funcs[type] == NULL)
 		return -EINVAL;
-	if (type == LO_CRYPT_XOR && info.lo_encrypt_key_size == 0)
-		return -EINVAL;
 	err = loop_release_xfer(lo);
+	lo->lo_offset = info.lo_offset;
+	lo->lo_sector_offset = info.lo_offset >> 9;
+
+	/* Some default handlers that can be overridden by loop_init_xfer. */
+	lo->queue.make_request_fn = loop_make_request;
+	if (S_ISREG(inode->i_mode)) {
+		struct address_space_operations *aops = inode->i_mapping->a_ops;
+		lo->lo_file_io[READ] =
+			aops->readpage ? lo_aops_receive : lo_file_xfer;
+
+		lo->lo_file_io[WRITE] = 
+			aops->prepare_write ? lo_aops_send : lo_file_xfer;
+		lo->lo_flags |= LO_FLAGS_DO_BMAP;
+	}
+
 	if (!err) 
 		err = loop_init_xfer(lo, type, &info);
 	if (err)
-		return err;	
+		return err;
+
+	bdev->bd_inode->i_size = compute_loop_size(lo);
 
-	lo->lo_offset = info.lo_offset;
 	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
 
 	lo->transfer = xfer_funcs[type]->transfer;
@@ -832,7 +959,6 @@
 		       info.lo_encrypt_key_size);
 		lo->lo_key_owner = current->uid; 
 	}	
-	figure_loop_size(lo);
 	return 0;
 }
 
@@ -843,8 +969,6 @@
 	struct kstat stat;
 	int error;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
 	if (!arg)
 		return -EINVAL;
 	error = vfs_getattr(file->f_vfsmnt, file->f_dentry, &stat);
@@ -854,7 +978,7 @@
 	info.lo_number = lo->lo_number;
 	info.lo_device = stat.dev;
 	info.lo_inode = stat.ino;
-	info.lo_rdevice = lo->lo_device->bd_dev;
+	info.lo_rdevice = lo->lo_device ? lo->lo_device->bd_dev : MKDEV(0,0);
 	info.lo_offset = lo->lo_offset;
 	info.lo_flags = lo->lo_flags;
 	strncpy(info.lo_name, lo->lo_name, LO_NAME_SIZE);
@@ -871,121 +995,95 @@
 	unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo;
-	int dev, err;
+	int err;
+	struct block_device *bdev = inode->i_bdev;
 
-	if (!inode)
-		return -EINVAL;
-	if (major(inode->i_rdev) != MAJOR_NR) {
-		printk(KERN_WARNING "lo_ioctl: pseudo-major != %d\n",
-		       MAJOR_NR);
-		return -ENODEV;
-	}
-	dev = minor(inode->i_rdev);
-	if (dev >= max_loop)
-		return -ENODEV;
-	lo = &loop_dev[dev];
-	down(&lo->lo_ctl_mutex);
+	lo = (bdev->bd_queue != NULL) ? bdev->bd_queue->queuedata : NULL;
+
+	/*
+	 * LOOP_SET_FD can only be called when no device is attached.
+	 * All other ioctls can only be called when a device is attached.
+	 */
+	if (lo != NULL) {
+		if (cmd == LOOP_SET_FD)
+			return -EBUSY;
+	} else {
+		if (cmd != LOOP_SET_FD)
+			return -ENXIO;
+	}
+
+	down(&bdev->bd_sem);
 	switch (cmd) {
 	case LOOP_SET_FD:
-		err = loop_set_fd(lo, file, inode->i_bdev, arg);
+		err = loop_set_fd(file, bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		err = loop_clr_fd(lo, inode->i_bdev);
+		err = loop_clr_fd(lo, bdev);
 		break;
 	case LOOP_SET_STATUS:
-		err = loop_set_status(lo, (struct loop_info *) arg);
+		err = loop_set_status(lo, bdev, (struct loop_info *) arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status(lo, (struct loop_info *) arg);
 		break;
 	case BLKGETSIZE:
-		if (lo->lo_state != Lo_bound) {
-			err = -ENXIO;
-			break;
-		}
-		err = put_user((unsigned long) loop_sizes[lo->lo_number] << 1, (unsigned long *) arg);
+		err = put_user((unsigned long) compute_loop_sectors(lo),
+			       (unsigned long *) arg);
 		break;
 	case BLKGETSIZE64:
-		if (lo->lo_state != Lo_bound) {
-			err = -ENXIO;
-			break;
-		}
-		err = put_user((u64)loop_sizes[lo->lo_number] << 10, (u64*)arg);
+		err = put_user((u64) compute_loop_sectors(lo),
+			       (u64*)arg);
 		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	up(&lo->lo_ctl_mutex);
+	up(&bdev->bd_sem);
 	return err;
 }
 
 static int lo_open(struct inode *inode, struct file *file)
 {
-	struct loop_device *lo;
-	int	dev, type;
+	const int new_max = minor(inode->i_rdev) + 1;
+	int i;
 
-	if (!inode)
-		return -EINVAL;
-	if (major(inode->i_rdev) != MAJOR_NR) {
-		printk(KERN_WARNING "lo_open: pseudo-major != %d\n", MAJOR_NR);
-		return -ENODEV;
-	}
-	dev = minor(inode->i_rdev);
-	if (dev >= max_loop)
-		return -ENODEV;
+	if (new_max > max_loop) {
+		for (i = max_loop + 1; i <= new_max; i++)
+			create_dev_loop(i);
 
-	lo = &loop_dev[dev];
-	MOD_INC_USE_COUNT;
-	down(&lo->lo_ctl_mutex);
+		max_loop = new_max;
+	}
 
-	type = lo->lo_encrypt_type; 
-	if (type && xfer_funcs[type] && xfer_funcs[type]->lock)
-		xfer_funcs[type]->lock(lo);
-	lo->lo_refcnt++;
-	up(&lo->lo_ctl_mutex);
 	return 0;
 }
 
 static int lo_release(struct inode *inode, struct file *file)
 {
-	struct loop_device *lo;
-	int	dev, type;
-
-	if (!inode)
-		return 0;
-	if (major(inode->i_rdev) != MAJOR_NR) {
-		printk(KERN_WARNING "lo_release: pseudo-major != %d\n",
-		       MAJOR_NR);
-		return 0;
-	}
-	dev = minor(inode->i_rdev);
-	if (dev >= max_loop)
-		return 0;
-
-	lo = &loop_dev[dev];
-	down(&lo->lo_ctl_mutex);
-	type = lo->lo_encrypt_type;
-	--lo->lo_refcnt;
-	if (xfer_funcs[type] && xfer_funcs[type]->unlock)
-		xfer_funcs[type]->unlock(lo);
-
-	up(&lo->lo_ctl_mutex);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
 static struct block_device_operations lo_fops = {
-	owner:		THIS_MODULE,
-	open:		lo_open,
-	release:	lo_release,
-	ioctl:		lo_ioctl,
+	.owner =	THIS_MODULE,
+	.open =		lo_open,
+	.release =	lo_release,
+	.ioctl =	lo_ioctl,
 };
 
+/* Create /dev/loop/nnn and register it as a disk. */
+static void
+create_dev_loop(int dev_minor)
+{
+	unsigned char buf[20];
+	sprintf(buf, "%d", dev_minor);
+	devfs_register(devfs_handle, buf, DEVFS_FL_DEFAULT,
+		       MAJOR_NR, dev_minor,
+		       S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP, &lo_fops, NULL);
+
+	register_disk(NULL, mk_kdev(MAJOR_NR, dev_minor), 1, &lo_fops, 0);
+}
+
 /*
  * And now the modules code and kernel interface.
  */
-MODULE_PARM(max_loop, "i");
-MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
 MODULE_LICENSE("GPL");
 
 int loop_register_transfer(struct loop_func_table *funcs)
@@ -998,19 +1096,24 @@
 
 int loop_unregister_transfer(int number)
 {
-	struct loop_device *lo; 
+	struct list_head *pos;
 
 	if ((unsigned)number >= MAX_LO_CRYPT)
 		return -EINVAL; 
-	for (lo = &loop_dev[0]; lo < &loop_dev[max_loop]; lo++) { 
+
+	spin_lock(&loop_devs_lock);
+	list_for_each(pos, &loop_devs) {
+		struct loop_device *lo =
+			list_entry(pos, struct loop_device, lo_list);
 		int type = lo->lo_encrypt_type;
 		if (type == number) { 
 			xfer_funcs[type]->release(lo);
-			lo->transfer = NULL; 
+			lo->transfer = NULL;
 			lo->lo_encrypt_type = 0; 
 		}
 	}
 	xfer_funcs[number] = NULL; 
+	spin_unlock(&loop_devs_lock);
 	return 0; 
 }
 
@@ -1019,14 +1122,6 @@
 
 int __init loop_init(void) 
 {
-	int	i;
-
-	if ((max_loop < 1) || (max_loop > 256)) {
-		printk(KERN_WARNING "loop: invalid max_loop (must be between"
-				    " 1 and 256), using default (8)\n");
-		max_loop = 8;
-	}
-
 	if (register_blkdev(MAJOR_NR, "loop", &lo_fops)) {
 		printk(KERN_WARNING "Unable to get major number %d for loop"
 				    " device\n", MAJOR_NR);
@@ -1034,45 +1129,11 @@
 	}
 
 	devfs_handle = devfs_mk_dir(NULL, "loop", NULL);
-	devfs_register_series(devfs_handle, "%u", max_loop, DEVFS_FL_DEFAULT,
-			      MAJOR_NR, 0,
-			      S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
-			      &lo_fops, NULL);
-
-	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
-	if (!loop_dev)
-		return -ENOMEM;
-
-	loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
-	if (!loop_sizes)
-		goto out_mem;
-
-	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), loop_make_request);
-	blk_queue_bounce_limit(BLK_DEFAULT_QUEUE(MAJOR_NR), BLK_BOUNCE_HIGH);
-
-	for (i = 0; i < max_loop; i++) {
-		struct loop_device *lo = &loop_dev[i];
-		memset(lo, 0, sizeof(struct loop_device));
-		init_MUTEX(&lo->lo_ctl_mutex);
-		init_MUTEX_LOCKED(&lo->lo_sem);
-		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
-		lo->lo_number = i;
-		spin_lock_init(&lo->lo_lock);
-	}
-
-	memset(loop_sizes, 0, max_loop * sizeof(int));
-	blk_size[MAJOR_NR] = loop_sizes;
-	for (i = 0; i < max_loop; i++)
-		register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &lo_fops, 0);
+	create_dev_loop(0);
 
-	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
-	return 0;
+	BLK_DEFAULT_QUEUE(MAJOR_NR)->queuedata = NULL;
 
-out_mem:
-	kfree(loop_dev);
-	kfree(loop_sizes);
-	printk(KERN_ERR "loop: ran out of memory\n");
-	return -ENOMEM;
+	return 0;
 }
 
 void loop_exit(void) 
@@ -1080,20 +1141,7 @@
 	devfs_unregister(devfs_handle);
 	if (unregister_blkdev(MAJOR_NR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
-
-	kfree(loop_dev);
-	kfree(loop_sizes);
 }
 
 module_init(loop_init);
 module_exit(loop_exit);
-
-#ifndef MODULE
-static int __init max_loop_setup(char *str)
-{
-	max_loop = simple_strtol(str, NULL, 0);
-	return 1;
-}
-
-__setup("max_loop=", max_loop_setup);
-#endif

--FCuugMFkClbJLl1L--
