Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSIIMQ4>; Mon, 9 Sep 2002 08:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSIIMQ4>; Mon, 9 Sep 2002 08:16:56 -0400
Received: from h-66-166-207-97.SNVACAID.covad.net ([66.166.207.97]:64673 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317194AbSIIMQK>; Mon, 9 Sep 2002 08:16:10 -0400
Date: Mon, 9 Sep 2002 05:20:47 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.33/drivers/block/loop.c update
Message-ID: <20020909052047.A1157@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here is an update to my loop.c changes.

	Herbert Riedel reported memory corruption typically of single
bytes when using a loop device backed by a file on an XFS filesystem
on a multiprocessor.  I believe was due to lo_aops_send doing its call
to flush_dcache_page before writing to the effected memory rather than
after, which is what my new patch does.  Herbert says that he may not
have time to retest for a little while, so I thought I ought to post
this update in case anyone else wants to comment or test.

	Also in this version, <linux/loop.h> exports loop_iv_t, which
Herbert requested to simplify cryptoapi maintenance.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="loop.diff"
Content-Transfer-Encoding: 8bit

--- linux-2.5.33/include/linux/loop.h	2002-08-31 15:05:37.000000000 -0700
+++ linux/include/linux/loop.h	2002-09-08 08:03:28.000000000 -0700
@@ -1,8 +1,3 @@
-#ifndef _LINUX_LOOP_H
-#define _LINUX_LOOP_H
-
-#include <linux/kdev_t.h>
-
 /*
  * include/linux/loop.h
  *
@@ -12,11 +7,20 @@
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
 
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/completion.h>
+
 /* Possible states of device */
 enum {
 	Lo_unbound,
@@ -24,16 +28,32 @@
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
+typedef int loop_iv_t;
+
 struct loop_device {
+	request_queue_t	lo_queue;
 	int		lo_number;
-	int		lo_refcnt;
-	int		lo_offset;
+	loff_t		lo_offset;
+	sector_t	lo_sector_offset; /* lo_offset / 512 */
 	int		lo_encrypt_type;
 	int		lo_encrypt_key_size;
-	int		lo_flags;
+	void		(*thread_handle_bio)(struct loop_device *lo,
+					     struct bio *bio);
 	int		(*transfer)(struct loop_device *, int cmd,
 				    char *raw_buf, char *loop_buf, int size,
-				    int real_block);
+				    loop_iv_t real_block);
 	char		lo_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	__u32           lo_init[2];
@@ -51,11 +71,14 @@
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
+	struct semaphore	lo_backup_sem;
+	struct bio		lo_backup_bio;
 };
 
 typedef	int (* transfer_proc_t)(struct loop_device *, int cmd,
@@ -64,13 +87,6 @@
 
 #endif /* __KERNEL__ */
 
-/*
- * Loop flags
- */
-#define LO_FLAGS_DO_BMAP	1
-#define LO_FLAGS_READ_ONLY	2
-#define LO_FLAGS_BH_REMAP	4
-
 /* 
  * Note that this structure gets the wrong offsets when directly used
  * from a glibc program, because glibc has a 32bit dev_t.
@@ -94,7 +110,7 @@
 	int		lo_offset;
 	int		lo_encrypt_type;
 	int		lo_encrypt_key_size; 	/* ioctl w/o */
-	int		lo_flags;	/* ioctl r/o */
+	int		lo_flags;	/* no longer used, formerly r/o */
 	char		lo_name[LO_NAME_SIZE];
 	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
 	unsigned long	lo_init[2];
@@ -114,6 +130,7 @@
 #define LO_CRYPT_IDEA     6
 #define LO_CRYPT_DUMMY    9
 #define LO_CRYPT_SKIPJACK 10
+#define LO_CRYPT_CRYPTOAPI 18  /* international crypto patch */
 #define MAX_LO_CRYPT	20
 
 #ifdef __KERNEL__
--- linux-2.5.33/drivers/block/loop.c	2002-08-31 15:05:27.000000000 -0700
+++ linux/drivers/block/loop.c	2002-09-08 06:18:58.000000000 -0700
@@ -2,9 +2,11 @@
  *  linux/drivers/block/loop.c
  *
  *  Written by Theodore Ts'o, 3/29/93
- * 
- * Copyright 1993 by Theodore Ts'o.  Redistribution of this file is
- * permitted under the GNU General Public License.
+ *
+ * Copyright 1993 by Theodore Ts'o.
+ * Copyright 2002 Yggdrasil Computing, Inc.
+ * Redistribution of this file is permitted under the GNU General
+ * Public License.
  *
  * DES encryption plus some minor changes by Werner Almesberger, 30-MAY-1993
  * more DES encryption plus IDEA encryption by Nicholas J. Leon, June 20, 1996
@@ -21,12 +23,12 @@
  * Loadable modules and other fixes by AK, 1998
  *
  * Make real block number available to downstream transfer functions, enables
- * CBC (and relatives) mode encryption requiring unique IVs per data block. 
+ * CBC (and relatives) mode encryption requiring unique IVs per data block.
  * Reed H. Petty, rhp@draper.net
  *
  * Maximum number of loop devices now dynamic via max_loop module parameter.
  * Russell Kroll <rkroll@exploits.org> 19990701
- * 
+ *
  * Maximum number of loop devices when compiled-in now selectable by passing
  * max_loop=<1-255> to the kernel on boot.
  * Erik I. Bolsø, <eriki@himolde.no>, Oct 31, 1999
@@ -36,29 +38,46 @@
  * Al Viro too.
  * Jens Axboe <axboe@suse.de>, Nov 2000
  *
- * Support up to 256 loop devices
- * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
+ * Fixed and made IV calculation customizable by lo_iv_mode
+ * Herbert Valerio Riedel <hvr@gnu.org>, Apr 2001
  *
  * Still To Fix:
- * - Advisory locking is ignored here. 
- * - Should use an own CAP_* category instead of CAP_SYS_ADMIN 
+ * - Advisory locking is ignored here.
+ * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
  *
  * WARNING/FIXME:
  * - The block number as IV passing to low level transfer functions is broken:
  *   it passes the underlying device's block number instead of the
- *   offset. This makes it change for a given block when the file is 
- *   moved/restored/copied and also doesn't work over NFS. 
+ *   offset. This makes it change for a given block when the file is
+ *   moved/restored/copied and also doesn't work over NFS.
  * AV, Feb 12, 2000: we pass the logical block number now. It fixes the
  *   problem above. Encryption modules that used to rely on the old scheme
  *   should just call ->i_mapping->bmap() to calculate the physical block
  *   number.
- */ 
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
+ * Made device-backed loop devices work even if bio_alloc fails in the
+ * IO path.  Adam J. Richter <adam@yggdrasil.com>, Sep 2002
+ *
+ */
 
 #include <linux/config.h>
 #include <linux/module.h>
 
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/writeback.h>
 #include <linux/file.h>
 #include <linux/bio.h>
 #include <linux/stat.h>
@@ -74,194 +93,174 @@
 #include <linux/slab.h>
 #include <linux/loop.h>
 #include <linux/suspend.h>
-#include <linux/writeback.h>
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
+
+/* bvec_walk stores state of iterating through bvecs in a bio.  */
+struct bvec_walk {
+	struct bio_vec	*bvec;
+	void		*data;
+	int		remaining, total_remaining;
+};
+
+typedef ssize_t (*read_write_func_t) (struct file *, char *, size_t, loff_t *);
+
+static int max_loop;		/* = 0.  Highest /dev/loop/nnn created.  */
 static devfs_handle_t devfs_handle;      /*  For the directory */
 
-/*
- * Transfer functions
- */
-static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
-			 char *loop_buf, int size, int real_block)
-{
-	if (raw_buf != loop_buf) {
-		if (cmd == READ)
-			memcpy(loop_buf, raw_buf, size);
-		else
-			memcpy(raw_buf, loop_buf, size);
-	}
+spinlock_t loop_devs_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(loop_devs);
 
-	return 0;
+static void create_dev_loop(int dev_minor);
+
+static void
+bv_setup_walk(struct bvec_walk *walk, struct bio *bio)
+{
+	struct bio_vec *bvec;
+	bvec = walk->bvec = bio->bi_io_vec;
+	walk->data = kmap(bvec->bv_page) + bvec->bv_offset;
+	walk->remaining = bvec->bv_len;
+	walk->total_remaining = bio->bi_size;
 }
 
-static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block)
+static void
+bv_step (struct bvec_walk *walk, int step)
 {
-	char	*in, *out, *key;
-	int	i, keysize;
+	walk->total_remaining -= step;
+	walk->remaining -= step;
 
-	if (cmd == READ) {
-		in = raw_buf;
-		out = loop_buf;
+	if (walk->remaining != 0) {
+		walk->data += step;
 	} else {
-		in = loop_buf;
-		out = raw_buf;
+		kunmap(walk->bvec->bv_page);
+		if (walk->total_remaining != 0) {
+			struct bio_vec *bvec = ++(walk->bvec);
+			walk->data = kmap(bvec->bv_page) + bvec->bv_offset;
+			walk->remaining = bvec->bv_len;
+		}
 	}
-
-	key = lo->lo_encrypt_key;
-	keysize = lo->lo_encrypt_key_size;
-	for (i = 0; i < size; i++)
-		*out++ = *in++ ^ key[(i & 511) % keysize];
-	return 0;
 }
 
-static int none_status(struct loop_device *lo, struct loop_info *info)
+static inline int loop_get_bs(struct loop_device *lo)
 {
-	lo->lo_flags |= LO_FLAGS_BH_REMAP;
-	return 0;
+	struct block_device *bdev = lo->lo_device;
+	return bdev ? block_size(lo->lo_device) : PAGE_CACHE_SIZE;
 }
 
-static int xor_status(struct loop_device *lo, struct loop_info *info)
+static inline unsigned long loop_get_iv(struct loop_device *lo,
+					unsigned long sector)
 {
-	if (info->lo_encrypt_key_size <= 0)
-		return -EINVAL;
-	return 0;
-}
-
-struct loop_func_table none_funcs = { 
-	number: LO_CRYPT_NONE,
-	transfer: transfer_none,
-	init: none_status,
-}; 	
-
-struct loop_func_table xor_funcs = { 
-	number: LO_CRYPT_XOR,
-	transfer: transfer_xor,
-	init: xor_status
-}; 	
-
-/* xfer_funcs[0] is special - its release function is never called */ 
-struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
-	&none_funcs,
-	&xor_funcs  
-};
+	int bs;
+	unsigned long offset, IV;
 
-#define MAX_DISK_SIZE 1024*1024*1024
+	sector += lo->lo_sector_offset; /* FIXME.  Make IV independent of
+					   location of the loop device. */
+	switch (lo->lo_iv_mode) {
+		case LO_IV_MODE_SECTOR:
+			/* BUG_ON(LO_IV_SECTOR_BITS != 9); */
+			return sector;
 
-static unsigned long
-compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry)
-{
-	loff_t size = lo_dentry->d_inode->i_mapping->host->i_size;
-	return (size - lo->lo_offset) >> BLOCK_SIZE_BITS;
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
 }
 
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
-		flush_dcache_page(page);
-		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset, data, size, IV);
+		if (aops->prepare_write(file, page, offset, end))
+			goto unlock_fail;
+		kaddr = page_address(page) + offset;
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
+		flush_dcache_page(page);
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
-	balance_dirty_pages(mapping);
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
 
@@ -271,25 +270,35 @@
 	int bsize;
 };
 
-static int lo_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+static int lo_read_actor(read_descriptor_t * desc, struct page *page,
+			 unsigned long offset, unsigned long size)
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
+	/* BUG_ON(LO_IV_SECTOR_BITS != 9);	gcc 3.1 appears to have a problem with BUG_ON(0). */
 
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
@@ -297,94 +306,155 @@
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
+	cookie.bsize = loop_get_bs(lo);
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
+{
+	mm_segment_t fs;
+	int res;
+	struct file *file = lo->lo_backing_file;
+	struct file_operations *f_op = file->f_op;
+	read_write_func_t xfer =
+		(rw == READ) ? f_op->read : ((read_write_func_t) f_op->write);
+
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
+			break;
+
+	} while (size != 0);
+	return (res < 0);
+}
+
+static int
+lo_file_xfer(struct loop_device *lo, int rw, void *data, int size, loff_t pos)
 {
+	struct page *scratch_page = lo->lo_backup_bio.bi_io_vec[0].bv_page;
+	void *scratch;
+	int err;
+
+	down(&lo->lo_backup_sem);
+
+	scratch = kmap(scratch_page);
+
+	err =
+		(rw == READ &&
+		 lo_file_copy(lo, READ, scratch, size, pos))
+
+		|| (*lo->transfer)(lo, rw, scratch, data, size,
+				loop_get_iv(lo, (unsigned long) (pos >> 9)))
+
+		|| (rw == WRITE &&
+		    lo_file_copy(lo, WRITE, scratch, size, pos));
+
+	kunmap(scratch_page);
+
+	up(&lo->lo_backup_sem);
+
+	return err;
+}
+
+static void loop_handle_bio_file(struct loop_device *lo, struct bio *loop_bio)
+{
+	loff_t pos = ((loff_t) loop_bio->bi_sector << 9) + lo->lo_offset;
 	unsigned vecnr;
 	int ret = 0;
+	struct bio_vec *bvec = loop_bio->bi_io_vec;
+	int rw = loop_bio->bi_rw & 1;
+	loop_file_xfer_t xfer = lo->lo_file_io[rw];
+
+	bio_for_each_segment(bvec, loop_bio, vecnr) {
+		void *loop_data = kmap(bvec->bv_page) + bvec->bv_offset;
 
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+		ret = (*xfer)(lo, rw, loop_data, bvec->bv_len, pos);
 
-		ret = do_lo_receive(lo, bvec, bsize, pos);
-		if (ret < 0)
+		if (rw == READ)
+			flush_dcache_page(bvec->bv_page);
+
+		kunmap(bvec->bv_page);
+		if (ret)
 			break;
+
 		pos += bvec->bv_len;
 	}
-	return ret;
+
+	bio_endio(loop_bio, !ret);
 }
 
-static inline int loop_get_bs(struct loop_device *lo)
+static void bio_free_pages(struct bio *dev_bio, int num_pages)
 {
-	return block_size(lo->lo_device);
+	struct bio_vec *bvec = dev_bio->bi_io_vec;
+	while (num_pages--) {
+		__free_page(bvec->bv_page);
+		bvec++;
+	}
 }
 
-static inline unsigned long loop_get_iv(struct loop_device *lo,
-					unsigned long sector)
+static int bio_alloc_pages(struct bio *dev_bio, int num_pages, int gfp_mask)
 {
-	int bs = loop_get_bs(lo);
-	unsigned long offset, IV;
-
-	IV = sector / (bs >> 9) + lo->lo_offset / bs;
-	offset = ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
-	if (offset >= bs)
-		IV++;
+	struct bio_vec *bvec = dev_bio->bi_io_vec;
+	int i;
+	for (i = 0; i < num_pages; i++, bvec++) {
 
-	return IV;
+		bvec->bv_page = alloc_page(gfp_mask);
+		if (!bvec->bv_page) {
+			bio_free_pages(dev_bio, i);
+			return -ENOMEM;
+		}
+	}
+	return 0;
 }
 
-static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
+static struct bio *bio_alloc_with_pages(int num_pages)
 {
-	loff_t pos;
-	int ret;
-
-	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
-
-	do {
-		if (bio_rw(bio) == WRITE)
-			ret = lo_send(lo, bio, loop_get_bs(lo), pos);
-		else
-			ret = lo_receive(lo, bio, loop_get_bs(lo), pos);
-
-	} while (++bio->bi_idx < bio->bi_vcnt);
+	struct bio *dev_bio = bio_alloc(GFP_ATOMIC, num_pages);
 
-	return ret;
+	if (dev_bio) {
+		if (bio_alloc_pages(dev_bio, num_pages, GFP_ATOMIC) != 0) {
+			bio_put(dev_bio);
+			return NULL;
+		}
+	}
+	return dev_bio;
 }
 
-static void loop_end_io_transfer(struct bio *);
-static void loop_put_buffer(struct bio *bio)
+static void loop_put_bio(struct loop_device *lo, struct bio *dev_bio)
 {
-	/*
-	 * check bi_end_io, may just be a remapped bio
-	 */
-	if (bio && bio->bi_end_io == loop_end_io_transfer) {
-		int i;
-		for (i = 0; i < bio->bi_vcnt; i++)
-			__free_page(bio->bi_io_vec[i].bv_page);
-
-		bio_put(bio);
+	if (dev_bio == &lo->lo_backup_bio)
+		up(&lo->lo_backup_sem);
+	else {
+		bio_free_pages(dev_bio, dev_bio->bi_vcnt);
+		bio_put(dev_bio);
 	}
 }
 
@@ -409,7 +479,7 @@
 /*
  * Grab first pending buffer
  */
-static struct bio *loop_get_bio(struct loop_device *lo)
+static struct bio *loop_thread_get_bio(struct loop_device *lo)
 {
 	struct bio *bio;
 
@@ -431,152 +501,218 @@
  * bi_end_io context (we don't want to do decrypt of a page with irqs
  * disabled)
  */
-static void loop_end_io_transfer(struct bio *bio)
+static void loop_end_io_transfer(struct bio *dev_bio)
 {
-	struct bio *rbh = bio->bi_private;
-	struct loop_device *lo = &loop_dev[minor(to_kdev_t(rbh->bi_bdev->bd_dev))];
-	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio *loop_bio = dev_bio->bi_private;
+	struct loop_device *lo = loop_bio->bi_bdev->bd_queue->queuedata;
+	int uptodate = test_bit(BIO_UPTODATE, &dev_bio->bi_flags);
 
-	if (!uptodate || bio_rw(bio) == WRITE) {
-		bio_endio(rbh, uptodate);
+	if (!uptodate || bio_rw(dev_bio) == WRITE) {
+		bio_endio(loop_bio, uptodate);
 		if (atomic_dec_and_test(&lo->lo_pending))
 			up(&lo->lo_bh_mutex);
-		loop_put_buffer(bio);
+		loop_put_bio(lo, dev_bio);
 	} else
-		loop_add_bio(lo, bio);
+		loop_add_bio(lo, dev_bio);
 }
 
-static struct bio *loop_get_buffer(struct loop_device *lo, struct bio *rbh)
+static void loop_do_completion(struct bio *dev_bio)
 {
-	struct bio *bio;
+	struct completion *completion = dev_bio->bi_private;
+	complete(completion);
+}
 
-	/*
-	 * for xfer_funcs that can operate on the same bh, do that
-	 */
-	if (lo->lo_flags & LO_FLAGS_BH_REMAP) {
-		bio = rbh;
-		goto out_bh;
+static inline struct bio *alloc_dev_bio(struct loop_device *lo,
+					struct bio *loop_bio,
+					unsigned int size_wanted)
+{
+	struct bio *dev_bio;
+	struct bio_vec *bvec;
+	int npages;
+
+	npages = (size_wanted + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+
+	dev_bio = bio_alloc_with_pages(npages);
+	if (dev_bio)
+		dev_bio->bi_size = size_wanted;
+	else if ((loop_bio->bi_flags & (1 << BIO_RW_AHEAD)) != 0)
+		return NULL;
+	else {
+		unsigned int max_size;
+		blk_run_queues(); /* in case lo_backup_bio is in use. */
+		down(&lo->lo_backup_sem);
+		/* loop_put_bio releases the semaphore. */
+
+		/* bio_init preserves bi_io_vec or bi_destrutor. */
+		bio_init(&lo->lo_backup_bio);
+
+		dev_bio = &lo->lo_backup_bio;
+
+		max_size = max(lo->lo_device->bd_queue->hardsect_size,
+			       (unsigned short) PAGE_CACHE_SIZE);
+
+		dev_bio->bi_size = min(size_wanted, max_size);
+
+		npages = (dev_bio->bi_size + PAGE_CACHE_SIZE - 1)
+			>> PAGE_CACHE_SHIFT;
 	}
 
-	bio = bio_copy(rbh, GFP_NOIO, rbh->bi_rw & WRITE);
+	dev_bio->bi_vcnt = npages;
 
-	bio->bi_end_io = loop_end_io_transfer;
-	bio->bi_private = rbh;
+	bvec = dev_bio->bi_io_vec;
+	while (npages--) {
+		bvec->bv_offset = 0;
+		bvec->bv_len = PAGE_CACHE_SIZE;
+		bvec++;
+	}
 
-out_bh:
-	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
-	bio->bi_rw = rbh->bi_rw;
-	bio->bi_bdev = lo->lo_device;
+	bvec[-1].bv_len = ((dev_bio->bi_size - 1) & (PAGE_CACHE_SIZE-1)) + 1;
 
-	return bio;
+	dev_bio->bi_sector = loop_bio->bi_sector + lo->lo_sector_offset;
+	dev_bio->bi_rw = loop_bio->bi_rw;
+	dev_bio->bi_bdev = lo->lo_device;
+
+	return dev_bio;
 }
 
 static int
-bio_transfer(struct loop_device *lo, struct bio *to_bio,
-			      struct bio *from_bio)
+bio_transfer(struct loop_device *lo, struct bio *dev_bio,
+	     struct bvec_walk *loop_walk, sector_t loop_sector)
 {
-	unsigned long IV = loop_get_iv(lo, from_bio->bi_sector);
-	struct bio_vec *from_bvec, *to_bvec;
-	char *vto, *vfrom;
-	int ret = 0, i;
-
-	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
-		to_bvec = &to_bio->bi_io_vec[i];
-
-		kmap(from_bvec->bv_page);
-		kmap(to_bvec->bv_page);
-		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
-		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
-		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-					from_bvec->bv_len, IV);
-		kunmap(from_bvec->bv_page);
-		kunmap(to_bvec->bv_page);
+	unsigned long IV;
+	off_t offset = 0;
+	struct bvec_walk dev_walk;
+	int ret = 0;
+	int step;
+
+	bv_setup_walk(&dev_walk, dev_bio);
+	while (dev_walk.total_remaining) {
+		step = min(dev_walk.remaining, loop_walk->remaining);
+		IV = loop_get_iv(lo, loop_sector + (offset >> 9));
+
+		ret |= (*lo->transfer)(lo, bio_data_dir(dev_bio),
+				       dev_walk.data, loop_walk->data,
+				       step, IV);
+		offset += step;
+		bv_step(&dev_walk, step);
+		bv_step(loop_walk, step);
 	}
 
 	return ret;
 }
-		
-static int loop_make_request(request_queue_t *q, struct bio *old_bio)
+
+static int loop_make_request_err(request_queue_t *q, struct bio *loop_bio)
 {
-	struct bio *new_bio = NULL;
-	struct loop_device *lo;
-	unsigned long IV;
-	int rw = bio_rw(old_bio);
-	int unit = minor(to_kdev_t(old_bio->bi_bdev->bd_dev));
+	return -EINVAL;
+}
 
-	if (unit >= max_loop)
-		goto out;
+static int loop_make_request_file(request_queue_t *q, struct bio *loop_bio)
+{
+	struct loop_device *lo = loop_bio->bi_bdev->bd_queue->queuedata;
 
-	lo = &loop_dev[unit];
-	spin_lock_irq(&lo->lo_lock);
-	if (lo->lo_state != Lo_bound)
-		goto inactive;
+	blk_queue_bounce(q, &loop_bio);
 	atomic_inc(&lo->lo_pending);
-	spin_unlock_irq(&lo->lo_lock);
-
-	if (rw == WRITE) {
-		if (lo->lo_flags & LO_FLAGS_READ_ONLY)
-			goto err;
-	} else if (rw == READA) {
-		rw = READ;
-	} else if (rw != READ) {
-		printk(KERN_ERR "loop: unknown command (%x)\n", rw);
-		goto err;
-	}
+	loop_add_bio(lo, loop_bio);
+	return 0;
+}
 
-	blk_queue_bounce(q, &old_bio);
+static int loop_make_request_dev(request_queue_t *q, struct bio *loop_bio)
+{
+	struct bio *dev_bio = NULL;
+	struct loop_device *lo = loop_bio->bi_bdev->bd_queue->queuedata;
+	int is_write = loop_bio->bi_rw & (1 << BIO_RW);
+	struct bvec_walk loop_walk;
+	struct completion dev_bio_done;
+	int total_so_far;
+	int uptodate;
 
-	/*
-	 * file backed, queue for loop_thread to handle
-	 */
-	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		loop_add_bio(lo, old_bio);
-		return 0;
-	}
+	blk_queue_bounce(q, &loop_bio);
 
 	/*
 	 * piggy old buffer on original, and submit for I/O
 	 */
-	new_bio = loop_get_buffer(lo, old_bio);
-	IV = loop_get_iv(lo, old_bio->bi_sector);
-	if (rw == WRITE) {
-		if (bio_transfer(lo, new_bio, old_bio))
-			goto err;
-	}
 
-	generic_make_request(new_bio);
-	return 0;
+	bv_setup_walk(&loop_walk, loop_bio);
+	total_so_far = 0;
+	do {
+		sector_t sector = loop_bio->bi_sector + (total_so_far>>9);
+		dev_bio = alloc_dev_bio(lo, loop_bio,
+					loop_walk.total_remaining);
 
-err:
-	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
-	loop_put_buffer(new_bio);
-out:
-	bio_io_error(old_bio);
+		if (dev_bio == NULL) {
+			set_bit(BIO_RW_BLOCK, &loop_bio->bi_flags);
+			break;
+		}
+
+		if (is_write &&
+		    bio_transfer(lo, dev_bio, &loop_walk, sector) != 0)
+			break;
+
+		total_so_far += dev_bio->bi_size;
+
+		if (total_so_far == loop_bio->bi_size) {
+			/*
+			  dev_bio->bi_size is clobbered by
+			  end_that_request_first before loop_end_io_transfer
+			  is called.  So, loop_end_io_transfer relies
+			  on loop_bio->bi_size to store the size of
+			  the transfer.
+			*/
+			loop_bio->bi_size = dev_bio->bi_size;
+			dev_bio->bi_private = loop_bio;
+			dev_bio->bi_end_io = loop_end_io_transfer;
+			atomic_inc(&lo->lo_pending);
+			generic_make_request(dev_bio);
+			return 0;
+		}
+
+		BUG_ON(dev_bio != &lo->lo_backup_bio);
+
+		init_completion(&dev_bio_done);
+		dev_bio->bi_private = &dev_bio_done;
+		dev_bio->bi_end_io = loop_do_completion;
+
+		generic_make_request(dev_bio);
+		blk_run_queues();
+		wait_for_completion(&dev_bio_done);
+
+		uptodate = test_bit(BIO_UPTODATE, &dev_bio->bi_flags);
+		if (!is_write &&
+		    bio_transfer(lo, dev_bio, &loop_walk, sector) != 0)
+			uptodate = 0;
+
+		up(&lo->lo_backup_sem);
+	} while (uptodate);
+
+	/* The loop only exits on failure.  Clean up the mess. */
+
+	if (dev_bio)
+		loop_put_bio(lo, dev_bio);
+
+	kunmap(loop_walk.bvec->bv_page);
+	bio_io_error(loop_bio);
 	return 0;
-inactive:
-	spin_unlock_irq(&lo->lo_lock);
-	goto out;
 }
 
-static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
+static void loop_handle_bio_dev(struct loop_device *lo, struct bio *dev_bio)
 {
 	int ret;
+	struct bvec_walk loop_walk;
+	struct bio *loop_bio = dev_bio->bi_private;
 
 	/*
 	 * For block backed loop, we know this is a READ
 	 */
-	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		ret = do_bio_filebacked(lo, bio);
-		bio_endio(bio, !ret);
-	} else {
-		struct bio *rbh = bio->bi_private;
 
-		ret = bio_transfer(lo, bio, rbh);
+	bv_setup_walk(&loop_walk, loop_bio);
 
-		bio_endio(rbh, !ret);
-		loop_put_buffer(bio);
-	}
+	/* dev_bio->bi_size was clobbered by end_that_request_first. */
+	dev_bio->bi_size = loop_bio->bi_size;
+
+	ret = bio_transfer(lo, dev_bio, &loop_walk, loop_bio->bi_sector);
+
+	bio_endio(loop_bio, !ret);
+	loop_put_bio(lo, dev_bio);
 }
 
 /*
@@ -604,14 +740,8 @@
 
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
@@ -621,12 +751,12 @@
 		if (!atomic_read(&lo->lo_pending))
 			break;
 
-		bio = loop_get_bio(lo);
+		bio = loop_thread_get_bio(lo);
 		if (!bio) {
-			printk("loop: missing bio\n");
+			printk(KERN_WARNING "loop: missing bio\n");
 			continue;
 		}
-		loop_handle_bio(lo, bio);
+		(*lo->thread_handle_bio)(lo, bio);
 
 		/*
 		 * upped both for pending work and tear-down, lo_pending
@@ -636,25 +766,22 @@
 			break;
 	}
 
-	up(&lo->lo_sem);
+	complete(&lo->lo_thread_exited);
 	return 0;
 }
 
-static int loop_set_fd(struct loop_device *lo, struct file *lo_file,
+static int loop_set_fd(struct file *lo_file,
 		       struct block_device *bdev, unsigned int arg)
 {
+	struct loop_device *lo;
 	struct file	*file;
 	struct inode	*inode;
 	kdev_t		dev = to_kdev_t(bdev->bd_dev);
 	struct block_device *lo_device;
-	int		lo_flags = 0;
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
 
 	error = -EBADF;
 	file = fget(arg);
@@ -664,164 +791,298 @@
 	error = -EINVAL;
 	inode = file->f_dentry->d_inode;
 
-	if (!(file->f_mode & FMODE_WRITE))
-		lo_flags |= LO_FLAGS_READ_ONLY;
-
 	if (S_ISBLK(inode->i_mode)) {
 		lo_device = inode->i_bdev;
 		if (lo_device == bdev) {
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
-	    || !(lo_file->f_mode & FMODE_WRITE))
-		lo_flags |= LO_FLAGS_READ_ONLY;
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
+	lo->lo_backup_bio.bi_io_vec = (struct bio_vec*) &lo[1];
+	if (bio_alloc_pages(&lo->lo_backup_bio, num_pages, GFP_KERNEL)) {
+		kfree(lo);
+		goto out_putf;
+	}
+	init_MUTEX(&lo->lo_backup_sem);
 
-	set_device_ro(dev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
+	error = 0;
+
+	set_device_ro(dev,
+		      IS_RDONLY (inode)
+		      || (lo_device && bdev_read_only(lo_device))
+		      || !(lo_file->f_mode & FMODE_WRITE)
+		      || !(file->f_mode & FMODE_WRITE));
+
+	spin_lock(&loop_devs_lock);
+	list_add(&lo->lo_list, &loop_devs);
+	spin_unlock(&loop_devs_lock);
+
+	init_completion(&lo->lo_thread_exited);
+	init_MUTEX_LOCKED(&lo->lo_bh_mutex);
+	lo->lo_number = minor(dev);
+	spin_lock_init(&lo->lo_lock);
 
 	lo->lo_device = lo_device;
-	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
-	figure_loop_size(lo);
+	lo->lo_iv_mode = LO_IV_MODE_DEFAULT;
+
+	lo->lo_queue.queuedata = lo;
+	q = &lo->lo_queue;
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
-	inode->i_mapping->gfp_mask = GFP_NOIO;
+	inode->i_mapping->gfp_mask = GFP_ATOMIC;
 
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
 
-static int loop_release_xfer(struct loop_device *lo)
+/*
+ * Transfer functions
+ */
+static int copy_transfer(struct loop_device *lo, int cmd, char *raw_buf,
+			 char *loop_buf, int size, int real_block)
+{
+	if (raw_buf != loop_buf) {
+		if (cmd == READ)
+			memcpy(loop_buf, raw_buf, size);
+		else
+			memcpy(raw_buf, loop_buf, size);
+	}
+
+	return 0;
+}
+
+static int copy_init(struct loop_device *lo, struct loop_info *info)
+{
+	struct inode *inode = lo->lo_backing_file->f_dentry->d_inode;
+	if (S_ISREG(inode->i_mode) &&
+	    !inode->i_mapping->a_ops->prepare_write) {
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
+			char *loop_buf, int size, int real_block)
 {
-	int err = 0; 
-	if (lo->lo_encrypt_type) {
-		struct loop_func_table *xfer= xfer_funcs[lo->lo_encrypt_type]; 
-		if (xfer && xfer->release)
-			err = xfer->release(lo); 
-		if (xfer && xfer->unlock)
-			xfer->unlock(lo); 
-		lo->lo_encrypt_type = 0;
+	char	*in, *out, *key;
+	int	i, keysize;
+
+	if (cmd == READ) {
+		in = raw_buf;
+		out = loop_buf;
+	} else {
+		in = loop_buf;
+		out = raw_buf;
 	}
+
+	key = lo->lo_encrypt_key;
+	keysize = lo->lo_encrypt_key_size;
+	for (i = 0; i < size; i++)
+		*out++ = *in++ ^ key[(i & (SECTOR_SIZE - 1)) % keysize];
+	return 0;
+}
+
+static int xor_init(struct loop_device *lo, struct loop_info *info)
+{
+	if (info->lo_encrypt_key_size <= 0)
+		return -EINVAL;
+	return 0;
+}
+
+struct loop_func_table none_funcs = {
+	.number =	LO_CRYPT_NONE,
+	.transfer =	copy_transfer,
+	.init =		copy_init,
+}; 
+
+struct loop_func_table xor_funcs = {
+	.number =	LO_CRYPT_XOR,
+	.transfer =	xor_transfer,
+	.init =		xor_init,
+}; 
+
+struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
+	&none_funcs,
+	&xor_funcs 
+};
+
+static int loop_release_xfer(struct loop_device *lo)
+{
+	int err = 0;
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
-	int err = 0; 
-	if (type) {
-		struct loop_func_table *xfer = xfer_funcs[type]; 
-		if (xfer->init)
-			err = xfer->init(lo, i);
-		if (!err) { 
-			lo->lo_encrypt_type = type;
-			if (xfer->lock)
-				xfer->lock(lo);
-		}
+	int err = 0;
+	struct loop_func_table *xfer = xfer_funcs[type];
+	if (xfer->init)
+		err = xfer->init(lo, i);
+	if (!err) {
+		lo->lo_encrypt_type = type;
+		if (xfer->lock)
+			xfer->lock(lo);
 	}
 	return err;
-}  
+}
 
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
+	num_pages = (lo->lo_queue.hardsect_size + PAGE_CACHE_SIZE - 1)
+		>> PAGE_CACHE_SHIFT;
+
+	lo->lo_queue.queuedata = NULL;
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
+	bio_free_pages(&lo->lo_backup_bio, num_pages);
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
-	struct loop_info info; 
+	struct loop_info info;
 	int err;
 	unsigned int type;
+	struct inode *inode = lo->lo_backing_file->f_dentry->d_inode;
 
-	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid && 
+	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid &&
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
 	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
-		return -EFAULT; 
+		return -EFAULT;
 	if ((unsigned int) info.lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
-	type = info.lo_encrypt_type; 
+	type = info.lo_encrypt_type;
 	if (type >= MAX_LO_CRYPT || xfer_funcs[type] == NULL)
 		return -EINVAL;
-	if (type == LO_CRYPT_XOR && info.lo_encrypt_key_size == 0)
-		return -EINVAL;
 	err = loop_release_xfer(lo);
-	if (!err) 
+	lo->lo_offset = info.lo_offset;
+	lo->lo_sector_offset = info.lo_offset >> 9;
+
+	/* Some default handlers that can be overridden by loop_init_xfer. */
+	if (S_ISREG(inode->i_mode)) {
+		struct address_space_operations *aops = inode->i_mapping->a_ops;
+		lo->lo_file_io[READ] =
+			aops->readpage ? lo_aops_receive : lo_file_xfer;
+
+		lo->lo_file_io[WRITE] =
+			aops->prepare_write ? lo_aops_send : lo_file_xfer;
+
+		/* Kludge to accomodate opengfs (a non-mainline file system)
+		   violating Documentation/filesystems/Locking. */
+		if (strcmp(inode->i_sb->s_type->name, "gfs") == 0) {
+			lo->lo_file_io[READ] = lo_file_xfer;
+			lo->lo_file_io[WRITE] = lo_file_xfer;
+		}
+		lo->thread_handle_bio = loop_handle_bio_file;
+		lo->lo_queue.make_request_fn = loop_make_request_file;
+	} else {
+		lo->thread_handle_bio = loop_handle_bio_dev;
+		lo->lo_queue.make_request_fn = loop_make_request_dev;
+	}
+
+	if (!err)
 		err = loop_init_xfer(lo, type, &info);
 	if (err)
-		return err;	
+		return err;
+
+	bdev->bd_inode->i_size = compute_loop_size(lo);
 
-	lo->lo_offset = info.lo_offset;
 	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
 
 	lo->transfer = xfer_funcs[type]->transfer;
@@ -830,35 +1091,34 @@
 	lo->lo_init[0] = info.lo_init[0];
 	lo->lo_init[1] = info.lo_init[1];
 	if (info.lo_encrypt_key_size) {
-		memcpy(lo->lo_encrypt_key, info.lo_encrypt_key, 
+		memcpy(lo->lo_encrypt_key, info.lo_encrypt_key,
 		       info.lo_encrypt_key_size);
-		lo->lo_key_owner = current->uid; 
-	}	
-	figure_loop_size(lo);
+		lo->lo_key_owner = current->uid;
+	}
 	return 0;
 }
 
-static int loop_get_status(struct loop_device *lo, struct loop_info *arg)
+static int loop_get_status(struct loop_device *lo,
+			   struct block_device *loop_bdev,
+			   struct loop_info *arg)
 {
 	struct file *file = lo->lo_backing_file;
 	struct loop_info info;
 	struct kstat stat;
 	int error;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
 	if (!arg)
 		return -EINVAL;
 	error = vfs_getattr(file->f_vfsmnt, file->f_dentry, &stat);
 	if (error)
 		return error;
 	memset(&info, 0, sizeof(info));
-	info.lo_number = lo->lo_number;
+	info.lo_number = minor(loop_bdev->bd_inode->i_rdev);
 	info.lo_device = stat.dev;
 	info.lo_inode = stat.ino;
-	info.lo_rdevice = lo->lo_device->bd_dev;
+	info.lo_rdevice = lo->lo_device ? lo->lo_device->bd_dev : MKDEV(0,0);
 	info.lo_offset = lo->lo_offset;
-	info.lo_flags = lo->lo_flags;
+	/* info.lo_flags is no longer used. */
 	strncpy(info.lo_name, lo->lo_name, LO_NAME_SIZE);
 	info.lo_encrypt_type = lo->lo_encrypt_type;
 	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
@@ -873,121 +1133,95 @@
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
-		err = loop_get_status(lo, (struct loop_info *) arg);
+		err = loop_get_status(lo, bdev, (struct loop_info *) arg);
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
@@ -995,40 +1229,37 @@
 	if ((unsigned)funcs->number > MAX_LO_CRYPT || xfer_funcs[funcs->number])
 		return -EINVAL;
 	xfer_funcs[funcs->number] = funcs;
-	return 0; 
+	return 0;
 }
 
 int loop_unregister_transfer(int number)
 {
-	struct loop_device *lo; 
+	struct list_head *pos;
 
 	if ((unsigned)number >= MAX_LO_CRYPT)
-		return -EINVAL; 
-	for (lo = &loop_dev[0]; lo < &loop_dev[max_loop]; lo++) { 
+		return -EINVAL;
+
+	spin_lock(&loop_devs_lock);
+	list_for_each(pos, &loop_devs) {
+		struct loop_device *lo =
+			list_entry(pos, struct loop_device, lo_list);
 		int type = lo->lo_encrypt_type;
-		if (type == number) { 
+		if (type == number) {
 			xfer_funcs[type]->release(lo);
-			lo->transfer = NULL; 
-			lo->lo_encrypt_type = 0; 
+			lo->transfer = NULL;
+			lo->lo_encrypt_type = 0;
 		}
 	}
-	xfer_funcs[number] = NULL; 
-	return 0; 
+	xfer_funcs[number] = NULL;
+	spin_unlock(&loop_devs_lock);
+	return 0;
 }
 
 EXPORT_SYMBOL(loop_register_transfer);
 EXPORT_SYMBOL(loop_unregister_transfer);
 
-int __init loop_init(void) 
+int __init loop_init(void)
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
@@ -1036,66 +1267,19 @@
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
 
-void loop_exit(void) 
+void loop_exit(void)
 {
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

--Kj7319i9nmIyA2yE--
