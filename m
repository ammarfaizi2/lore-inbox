Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSHEIyy>; Mon, 5 Aug 2002 04:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318344AbSHEIyy>; Mon, 5 Aug 2002 04:54:54 -0400
Received: from h-64-105-137-168.SNVACAID.covad.net ([64.105.137.168]:64672
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318342AbSHEIyq>; Mon, 5 Aug 2002 04:54:46 -0400
Date: Mon, 5 Aug 2002 01:58:12 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.30/drivers/block/loop.c big cleanup
Message-ID: <20020805015812.A1770@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch is a big cleanup of loop.c.  The
highlights are:

	1. Do you ever wonder why everyone was reporting bio_copy
	   running out of memory even when the maximum trasfer size for
	   a bio was typically 128kB and your system had hundreds of
	   megabytes of RAM?  There was a bug in loop.c where
	   there were two levels of iteration walking through the
	   bvecs in a bio.  As a result, a bio to transfer n pages
	   would usually result a transfer of n pages, a transfer of
	   n-1 pages, n-2 pages, etc. for a total of n*(n-1)/2, all
	   being queued immediately.  I have not yet accomodated bio_copy
	   failing (working on it), but this bug being fixed should make
	   it happen much less often and should make loop devices faster.

	2. Each /dev/loop device now has the same DMA parameters as
	   its underlying device.  So, bio producers can submit
	   bios at the maximum size that the underlying device can
	   handle.

	3. Space for loop devices is kmalloc'ed as they are set up.
	   There is now almost no cost to having a high max_loop.
	   max_loop is going away soon anyhow.

	4. No sector copying.  Data is either remapped or there is some
	   data transformation.  The stock linux-2.5.30 loop.c did
	   this also, but nobody realized it.  It would do data
	   copying in some cases, but would never use the copied
	   data.  It just wasted lots of memory bandwidth.

	5. Deleted some unnecessary locking, and replaced lo_sem
	   with lo_thread_exited (a struct completion rather than a
	   semaphore, making it smaller and avoiding a potential
	   problem with waiting on a semaphore to deallocate memory
	   that it occupies as described to me by some nice people on
	   irc.kernelnewbies.org whose names I don't remember).

	I have tested this with directly mapping a disk partition
and also from running from an encrypted disk partition.  More testing would
be appreciated, especially of the file mapped case.

	Known bug:

	1. The module referencing counting in fs/block_dev.c does not
	   get along well with this.  After creating and deleting
	   a loop device, the reference count of the modules is -1.
	   I think this may be a bug in block_dev.c, but I'm still
	   looking into it.  (I think not being able to unload the
	   module is a smaller bug than the bio_copy failures that this
	   patch fixes.)

	To do:

	1. Eliminate max_loop.  Let users open as many /dev/loop
	   devices as they want.  Either leave the devfs device
	   creation to user level devfsd or create /dev/loop/n+1
	   when /dev/loop/n is opened.

	2. Accomodate bio_copy failures by reserving one page (or
	   q->hardsect_size, whichever is greater.  I have not done
	   this yet because I want to at least make some changes to bio.c

	3. After the device mapper from lvm2 is integrated into 2.5,
	   consider porting the "transform" functionality to it and
	   seeing if we can the eliminate loop.c.

	If nobody identifies any glaring mistakes or test failures,
I expect to test it some more tomorrow and then I'd like to get
it blessed by the appropriate person (Jens?) and try to submit it
for 2.5.31.  There is still more to do with loop.c, but I'd like to
sync up at this point while the patch is small enough to be somewhat
readable.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop.diff"

--- linux-2.5.30/include/linux/loop.h	2002-08-01 14:16:25.000000000 -0700
+++ linux/include/linux/loop.h	2002-08-05 00:55:56.000000000 -0700
@@ -2,6 +2,8 @@
 #define _LINUX_LOOP_H
 
 #include <linux/kdev_t.h>
+#include <linux/blkdev.h>
+#include <linux/completion.h>
 
 /*
  * include/linux/loop.h
@@ -24,9 +26,16 @@
 	Lo_rundown,
 };
 
+/* IV calculation related constants */
+#define LO_IV_MODE_DEFAULT 0 /* old logical block size based mode */
+#define LO_IV_MODE_SECTOR  1 /* calculate IV based on relative 
+				512 byte sectors */
+#define LO_IV_SECTOR_BITS 9
+#define LO_IV_SECTOR_SIZE (1 << LO_IV_SECTOR_BITS)
+
 struct loop_device {
+	request_queue_t	queue;
 	int		lo_number;
-	int		lo_refcnt;
 	int		lo_offset;
 	int		lo_encrypt_type;
 	int		lo_encrypt_key_size;
@@ -51,11 +60,12 @@
 	spinlock_t		lo_lock;
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
-	int			lo_state;
-	struct semaphore	lo_sem;
-	struct semaphore	lo_ctl_mutex;
+	struct completion	lo_thread_exited;
 	struct semaphore	lo_bh_mutex;
 	atomic_t		lo_pending;
+
+	int			lo_iv_mode;
+	struct list_head	lo_list;
 };
 
 typedef	int (* transfer_proc_t)(struct loop_device *, int cmd,
@@ -114,6 +124,7 @@
 #define LO_CRYPT_IDEA     6
 #define LO_CRYPT_DUMMY    9
 #define LO_CRYPT_SKIPJACK 10
+#define LO_CRYPT_CRYPTOAPI 18  /* international crypto patch */
 #define MAX_LO_CRYPT	20
 
 #ifdef __KERNEL__
--- linux-2.5.30/drivers/block/loop.c	2002-08-01 14:16:03.000000000 -0700
+++ linux/drivers/block/loop.c	2002-08-05 01:01:59.000000000 -0700
@@ -39,6 +39,9 @@
  * Support up to 256 loop devices
  * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
  *
+ * Fixed and made IV calculation customizable by lo_iv_mode
+ * Herbert Valerio Riedel <hvr@gnu.org>, Apr 2001
+ *
  * Still To Fix:
  * - Advisory locking is ignored here. 
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN 
@@ -75,16 +78,27 @@
 #include <linux/loop.h>
 #include <linux/suspend.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
+#include <linux/list.h>
 
 #include <asm/uaccess.h>
 
 #define MAJOR_NR LOOP_MAJOR
 
+struct sync_xfer {
+	struct bio		*loop_bio;
+	unsigned int		offset;
+	struct completion	done;
+};
+
 static int max_loop = 8;
-static struct loop_device *loop_dev;
-static int *loop_sizes;
 static devfs_handle_t devfs_handle;      /*  For the directory */
 
+spinlock_t loop_devs_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(loop_devs);
+
+static inline unsigned long loop_get_iv(struct loop_device *lo,
+					unsigned long sector);
+
 /*
  * Transfer functions
  */
@@ -153,20 +167,16 @@
 	&xor_funcs  
 };
 
-#define MAX_DISK_SIZE 1024*1024*1024
-
-static unsigned long
-compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry)
+static loff_t
+compute_loop_size(struct loop_device *lo)
 {
-	loff_t size = lo_dentry->d_inode->i_mapping->host->i_size;
-	return (size - lo->lo_offset) >> BLOCK_SIZE_BITS;
+	return lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
 }
 
-static void figure_loop_size(struct loop_device *lo)
+static u64
+compute_loop_sectors(struct loop_device *lo)
 {
-	loop_sizes[lo->lo_number] = compute_loop_size(lo,
-					lo->lo_backing_file->f_dentry);
-					
+	return (compute_loop_size(lo) + 511 - lo->lo_offset) >> 9;
 }
 
 static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
@@ -188,62 +198,46 @@
 	char *kaddr, *data;
 	unsigned long index;
 	unsigned size, offset;
-	int len;
-	int ret = 0;
+	int ret = -1;
+	unsigned long IV;
+	int transfer_result;
 
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & (PAGE_CACHE_SIZE - 1);
 	data = kmap(bvec->bv_page) + bvec->bv_offset;
-	len = bvec->bv_len;
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
-		unlock_page(page);
-		page_cache_release(page);
+	size = bvec->bv_len;
+	IV = loop_get_iv(lo, (pos - lo->lo_offset) >> LO_IV_SECTOR_BITS);
+
+	page = grab_cache_page(mapping, index);
+	if (!page)
+		goto fail;
+	if (aops->prepare_write(file, page, offset, offset+size))
+		goto unlock;
+	kaddr = page_address(page) + offset;
+	flush_dcache_page(page);
+	transfer_result = lo_do_transfer(lo, WRITE, kaddr, data, size, IV);
+	if (transfer_result) {
+		/*
+		 * The transfer failed, but we still write the data to
+		 * keep prepare/commit calls balanced.
+		 */
+		printk(KERN_ERR "loop: transfer error block %ld\n", index);
+		memset(kaddr, 0, size);
 	}
-	up(&mapping->host->i_sem);
-out:
-	kunmap(bvec->bv_page);
-	return ret;
+
+	if (aops->commit_write(file, page, offset, offset+size) == 0 &&
+	    transfer_result == 0)
+		ret = 0;
 
 unlock:
 	unlock_page(page);
 	page_cache_release(page);
+
 fail:
 	up(&mapping->host->i_sem);
-	ret = -1;
-	goto out;
+	kunmap(bvec->bv_page);
+	return ret;
 }
 
 static int
@@ -275,7 +269,10 @@
 	unsigned long count = desc->count;
 	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
 	struct loop_device *lo = p->lo;
-	int IV = page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
+	unsigned long IV = loop_get_iv(lo,
+		((page->index <<  (PAGE_CACHE_SHIFT - LO_IV_SECTOR_BITS))
+		+ (offset >> LO_IV_SECTOR_BITS)
+		- (lo->lo_offset >> LO_IV_SECTOR_BITS)));
 
 	if (size > count)
 		size = count;
@@ -300,7 +297,6 @@
 {
 	struct lo_read_data cookie;
 	read_descriptor_t desc;
-	struct file *file;
 
 	cookie.lo = lo;
 	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
@@ -309,10 +305,7 @@
 	desc.count = bvec->bv_len;
 	desc.buf = (char*)&cookie;
 	desc.error = 0;
-	spin_lock_irq(&lo->lo_lock);
-	file = lo->lo_backing_file;
-	spin_unlock_irq(&lo->lo_lock);
-	do_generic_file_read(file, &pos, &desc, lo_read_actor);
+	do_generic_file_read(lo->lo_backing_file, &pos, &desc, lo_read_actor);
 	kunmap(bvec->bv_page);
 	return desc.error;
 }
@@ -342,33 +335,36 @@
 static inline unsigned long loop_get_iv(struct loop_device *lo,
 					unsigned long sector)
 {
-	int bs = loop_get_bs(lo);
+	int bs;
 	unsigned long offset, IV;
 
-	IV = sector / (bs >> 9) + lo->lo_offset / bs;
-	offset = ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
-	if (offset >= bs)
-		IV++;
+	switch (lo->lo_iv_mode) {
+		case LO_IV_MODE_SECTOR:
+			IV = sector + (lo->lo_offset >> LO_IV_SECTOR_BITS);
+			break;
+
+		default:
+			printk (KERN_WARNING "loop: unexpected lo_iv_mode\n");
+		case LO_IV_MODE_DEFAULT:
+			bs = loop_get_bs(lo);
+			IV = sector / (bs >> 9) + lo->lo_offset / bs;
+			offset = ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
+			if (offset >= bs)
+				IV++;
+			break;
+	}
 
 	return IV;
 }
 
 static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
 {
-	loff_t pos;
-	int ret;
+	const loff_t pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
 
-	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
-
-	do {
-		if (bio_rw(bio) == WRITE)
-			ret = lo_send(lo, bio, loop_get_bs(lo), pos);
-		else
-			ret = lo_receive(lo, bio, loop_get_bs(lo), pos);
-
-	} while (++bio->bi_idx < bio->bi_vcnt);
-
-	return ret;
+	if (bio_rw(bio) == WRITE)
+		return lo_send(lo, bio, loop_get_bs(lo), pos);
+	else
+		return lo_receive(lo, bio, loop_get_bs(lo), pos);
 }
 
 static void loop_end_io_transfer(struct bio *);
@@ -432,7 +428,7 @@
 static void loop_end_io_transfer(struct bio *bio)
 {
 	struct bio *rbh = bio->bi_private;
-	struct loop_device *lo = &loop_dev[minor(to_kdev_t(rbh->bi_bdev->bd_dev))];
+	struct loop_device *lo = rbh->bi_bdev->bd_queue->queuedata;
 	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 
 	if (!uptodate || bio_rw(bio) == WRITE) {
@@ -456,7 +452,7 @@
 		goto out_bh;
 	}
 
-	bio = bio_copy(rbh, GFP_NOIO, rbh->bi_rw & WRITE);
+	bio = bio_copy(rbh, GFP_NOIO, 0);
 
 	bio->bi_end_io = loop_end_io_transfer;
 	bio->bi_private = rbh;
@@ -473,12 +469,15 @@
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
@@ -489,6 +488,7 @@
 					from_bvec->bv_len, IV);
 		kunmap(from_bvec->bv_page);
 		kunmap(to_bvec->bv_page);
+		offset += from_bvec->bv_len;
 	}
 
 	return ret;
@@ -497,20 +497,13 @@
 static int loop_make_request(request_queue_t *q, struct bio *old_bio)
 {
 	struct bio *new_bio = NULL;
-	struct loop_device *lo;
-	unsigned long IV;
+	struct loop_device *lo = old_bio->bi_bdev->bd_queue->queuedata;
 	int rw = bio_rw(old_bio);
-	int unit = minor(to_kdev_t(old_bio->bi_bdev->bd_dev));
 
-	if (unit >= max_loop)
+	if (lo == NULL)
 		goto out;
 
-	lo = &loop_dev[unit];
-	spin_lock_irq(&lo->lo_lock);
-	if (lo->lo_state != Lo_bound)
-		goto inactive;
 	atomic_inc(&lo->lo_pending);
-	spin_unlock_irq(&lo->lo_lock);
 
 	if (rw == WRITE) {
 		if (lo->lo_flags & LO_FLAGS_READ_ONLY)
@@ -536,7 +529,6 @@
 	 * piggy old buffer on original, and submit for I/O
 	 */
 	new_bio = loop_get_buffer(lo, old_bio);
-	IV = loop_get_iv(lo, old_bio->bi_sector);
 	if (rw == WRITE) {
 		if (bio_transfer(lo, new_bio, old_bio))
 			goto err;
@@ -552,9 +544,6 @@
 out:
 	bio_io_error(old_bio);
 	return 0;
-inactive:
-	spin_unlock_irq(&lo->lo_lock);
-	goto out;
 }
 
 static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
@@ -602,14 +591,8 @@
 
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
@@ -621,7 +604,7 @@
 
 		bio = loop_get_bio(lo);
 		if (!bio) {
-			printk("loop: missing bio\n");
+			printk(KERN_WARNING "loop: missing bio\n");
 			continue;
 		}
 		loop_handle_bio(lo, bio);
@@ -634,25 +617,21 @@
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
 	int		lo_flags = 0;
 	int		error;
-
-	MOD_INC_USE_COUNT;
-
-	error = -EBUSY;
-	if (lo->lo_state != Lo_unbound)
-		goto out;
+	request_queue_t *q;
 
 	error = -EBADF;
 	file = fget(arg);
@@ -671,6 +650,7 @@
 			error = -EBUSY;
 			goto out;
 		}
+		error = 0;
 	} else if (S_ISREG(inode->i_mode)) {
 		struct address_space_operations *aops = inode->i_mapping->a_ops;
 		/*
@@ -695,30 +675,59 @@
 	    || !(lo_file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
+	lo = kmalloc(sizeof(struct loop_device), GFP_KERNEL);
+	if (lo == NULL) {
+		error = -ENOMEM;
+		goto out_putf;
+	}
+	memset(lo, 0, sizeof(*lo));
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
+	blk_queue_make_request(q, loop_make_request);
+	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
+	blk_queue_max_sectors(q, lo_device->bd_queue->max_sectors);
+	blk_queue_max_phys_segments(q, lo_device->bd_queue->max_phys_segments);
+	blk_queue_max_hw_segments(q, lo_device->bd_queue->max_hw_segments);
+	blk_queue_hardsect_size(q, lo_device->bd_queue->hardsect_size);
+	blk_queue_max_segment_size(q, lo_device->bd_queue->max_segment_size);
+
+	bdev->bd_queue = q;
+	bdev->bd_openers++;
+	atomic_inc(&bdev->bd_count);
+	MOD_INC_USE_COUNT;
+
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask = GFP_NOIO;
 
 	set_blocksize(bdev, block_size(lo_device));
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
 
@@ -755,45 +764,38 @@
 static int loop_clr_fd(struct loop_device *lo, struct block_device *bdev)
 {
 	struct file *filp = lo->lo_backing_file;
-	int gfp = lo->old_gfp_mask;
 
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
@@ -802,8 +804,6 @@
 	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid && 
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
 	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
 		return -EFAULT; 
 	if ((unsigned int) info.lo_encrypt_key_size > LO_KEY_SIZE)
@@ -820,6 +820,8 @@
 		return err;	
 
 	lo->lo_offset = info.lo_offset;
+	bdev->bd_inode->i_size = compute_loop_size(lo);
+
 	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
 
 	lo->transfer = xfer_funcs[type]->transfer;
@@ -832,7 +834,6 @@
 		       info.lo_encrypt_key_size);
 		lo->lo_key_owner = current->uid; 
 	}	
-	figure_loop_size(lo);
 	return 0;
 }
 
@@ -843,8 +844,6 @@
 	struct kstat stat;
 	int error;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
 	if (!arg)
 		return -EINVAL;
 	error = vfs_getattr(file->f_vfsmnt, file->f_dentry, &stat);
@@ -871,106 +870,59 @@
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
-
-	if (!inode)
-		return -EINVAL;
-	if (major(inode->i_rdev) != MAJOR_NR) {
-		printk(KERN_WARNING "lo_open: pseudo-major != %d\n", MAJOR_NR);
-		return -ENODEV;
-	}
-	dev = minor(inode->i_rdev);
-	if (dev >= max_loop)
-		return -ENODEV;
-
-	lo = &loop_dev[dev];
-	MOD_INC_USE_COUNT;
-	down(&lo->lo_ctl_mutex);
-
-	type = lo->lo_encrypt_type; 
-	if (type && xfer_funcs[type] && xfer_funcs[type]->lock)
-		xfer_funcs[type]->lock(lo);
-	lo->lo_refcnt++;
-	up(&lo->lo_ctl_mutex);
-	return 0;
+	return (minor(inode->i_rdev) >= max_loop) ? -ENODEV : 0;
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
 
@@ -998,19 +950,24 @@
 
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
 
@@ -1022,9 +979,10 @@
 	int	i;
 
 	if ((max_loop < 1) || (max_loop > 256)) {
-		printk(KERN_WARNING "loop: invalid max_loop (must be between"
-				    " 1 and 256), using default (8)\n");
 		max_loop = 8;
+		printk(KERN_WARNING "loop: invalid max_loop (must be between"
+				    " 1 and 256), using default (%d)\n",
+		       max_loop);
 	}
 
 	if (register_blkdev(MAJOR_NR, "loop", &lo_fops)) {
@@ -1039,40 +997,13 @@
 			      S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
 			      &lo_fops, NULL);
 
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
+	BLK_DEFAULT_QUEUE(MAJOR_NR)->queuedata = NULL;
 
-	memset(loop_sizes, 0, max_loop * sizeof(int));
-	blk_size[MAJOR_NR] = loop_sizes;
 	for (i = 0; i < max_loop; i++)
 		register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &lo_fops, 0);
 
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;
-
-out_mem:
-	kfree(loop_dev);
-	kfree(loop_sizes);
-	printk(KERN_ERR "loop: ran out of memory\n");
-	return -ENOMEM;
 }
 
 void loop_exit(void) 
@@ -1080,9 +1011,6 @@
 	devfs_unregister(devfs_handle);
 	if (unregister_blkdev(MAJOR_NR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
-
-	kfree(loop_dev);
-	kfree(loop_sizes);
 }
 
 module_init(loop_init);

--huq684BweRXVnRxX--
