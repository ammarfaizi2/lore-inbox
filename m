Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTFUOyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264852AbTFUOyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:54:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7064 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264830AbTFUOxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:53:48 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 21 Jun 2003 17:07:47 +0200 (MEST)
Message-Id: <UTC200306211507.h5LF7lM23701.aeb@smtp.cwi.nl>
To: akpm@digeo.com, axboe@suse.de, clemens@endorphin.org,
       torvalds@transmeta.com
Subject: [PATCH - RFC] loop.c
Cc: jari.ruusu@pp.inet.fi, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a long time we have had a somewhat unfortunate situation
where people wanting to use cryptoloop had to collect some
kernel patches and util-linux patches elsewhere.
Now that we have crypto in the kernel this can be rectified.

As far as I can see this requires two things:
- crypto transfer functions must be registered with loop.c,
that is, loop_register_transfer() must be called
- loop.c must be fixed

The first point is handled by cryptoloop-0.2-2.5.58.diff.
Concerning the second point, several patches are floating around.
Below a patch that Jari Ruusu sent me.

This is a RFC.
Clemens - any comments on the crypto side?
Jens - any comments on the block I/O side?

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Sun Jun 15 01:40:53 2003
+++ b/drivers/block/loop.c	Sat Jun 21 16:42:20 2003
@@ -39,19 +39,30 @@
  * Support up to 256 loop devices
  * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
  *
+ * IV is now passed as (512 byte) sector number.
+ * Jari Ruusu <jari.ruusu@pp.inet.fi>, May 18 2001
+ *
+ * External encryption module locking bug fixed.
+ * Ingo Rohloff <rohloff@in.tum.de>, June 21 2001
+ *
+ * Make device backed loop work with swap (pre-allocated buffers + queue rewrite).
+ * Jari Ruusu <jari.ruusu@pp.inet.fi>, September 2 2001
+ *
+ * Ported 'pre-allocated buffers + queue rewrite' to BIO for 2.5 kernels
+ * Ben Slusky <sluskyb@stwing.org>, March 1 2002
+ * Jari Ruusu <jari.ruusu@pp.inet.fi>, March 27 2002
+ *
+ * File backed code now uses file->f_op->read/write. Based on Andrew Morton's idea.
+ * Jari Ruusu <jari.ruusu@pp.inet.fi>, May 23 2002
+ *
+ * Exported hard sector size correctly, fixed file-backed-loop-on-tmpfs bug,
+ * plus many more enhancements and optimizations.
+ * Adam J. Richter <adam@yggdrasil.com>, Aug 2002
+ *
+ *
  * Still To Fix:
  * - Advisory locking is ignored here. 
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN 
- *
- * WARNING/FIXME:
- * - The block number as IV passing to low level transfer functions is broken:
- *   it passes the underlying device's block number instead of the
- *   offset. This makes it change for a given block when the file is 
- *   moved/restored/copied and also doesn't work over NFS. 
- * AV, Feb 12, 2000: we pass the logical block number now. It fixes the
- *   problem above. Encryption modules that used to rely on the old scheme
- *   should just call ->i_mapping->bmap() to calculate the physical block
- *   number.
  */ 
 
 #include <linux/config.h>
@@ -65,7 +76,7 @@
 #include <linux/errno.h>
 #include <linux/major.h>
 #include <linux/wait.h>
-#include <linux/blk.h>
+#include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
@@ -80,7 +91,6 @@
 #include <asm/uaccess.h>
 
 static int max_loop = 8;
-static struct loop_device *loop_dev;
 static struct gendisk **disks;
 
 /*
@@ -89,13 +99,10 @@
 static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
 			 char *loop_buf, int size, sector_t real_block)
 {
-	if (raw_buf != loop_buf) {
-		if (cmd == READ)
-			memcpy(loop_buf, raw_buf, size);
-		else
-			memcpy(raw_buf, loop_buf, size);
-	}
+	/* this code is only called from file backed loop  */
+	/* and that code expects this function to be no-op */
 
+	cond_resched();
 	return 0;
 }
 
@@ -117,10 +124,16 @@
 	keysize = lo->lo_encrypt_key_size;
 	for (i = 0; i < size; i++)
 		*out++ = *in++ ^ key[(i & 511) % keysize];
+	cond_resched();
 	return 0;
 }
 
-static int xor_status(struct loop_device *lo, const struct loop_info64 *info)
+static int none_status(struct loop_device *lo, struct loop_info64 *info)
+{
+	return 0;
+}
+
+static int xor_status(struct loop_device *lo, struct loop_info64 *info)
 {
 	if (info->lo_encrypt_key_size <= 0)
 		return -EINVAL;
@@ -130,475 +143,576 @@
 struct loop_func_table none_funcs = { 
 	.number = LO_CRYPT_NONE,
 	.transfer = transfer_none,
-}; 	
+	.init = none_status,
+};
 
 struct loop_func_table xor_funcs = { 
 	.number = LO_CRYPT_XOR,
 	.transfer = transfer_xor,
-	.init = xor_status
-}; 	
+	.init = xor_status,
+};
 
 /* xfer_funcs[0] is special - its release function is never called */ 
 struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
 	&none_funcs,
-	&xor_funcs  
+	&xor_funcs,
 };
 
-static int figure_loop_size(struct loop_device *lo)
-{
-	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
-	sector_t x;
-	/*
-	 * Unfortunately, if we want to do I/O on the device,
-	 * the number of 512-byte sectors has to fit into a sector_t.
-	 */
-	size = (size - lo->lo_offset) >> 9;
-	x = (sector_t)size;
-	if ((loff_t)x != size)
-		return -EFBIG;
-
-	set_capacity(disks[lo->lo_number], size);
-	return 0;					
-}
-
-static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
-				 char *lbuf, int size, sector_t rblock)
-{
-	if (!lo->transfer)
-		return 0;
-
-	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
-}
-
-static int
-do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos)
-{
-	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
-	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	struct address_space_operations *aops = mapping->a_ops;
-	struct page *page;
-	char *kaddr, *data;
-	pgoff_t index;
-	unsigned size, offset;
-	int len;
-	int ret = 0;
-
-	down(&mapping->host->i_sem);
-	index = pos >> PAGE_CACHE_SHIFT;
-	offset = pos & ((pgoff_t)PAGE_CACHE_SIZE - 1);
-	data = kmap(bvec->bv_page) + bvec->bv_offset;
-	len = bvec->bv_len;
-	while (len > 0) {
-		sector_t IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
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
-		kaddr = kmap(page);
-		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset, data, size, IV);
-		if (transfer_result) {
-			/*
-			 * The transfer failed, but we still write the data to
-			 * keep prepare/commit calls balanced.
-			 */
-			printk(KERN_ERR "loop: transfer error block %llu\n",
-			       (unsigned long long)index);
-			memset(kaddr + offset, 0, size);
-		}
-		flush_dcache_page(page);
-		kunmap(page);
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
-	}
-	up(&mapping->host->i_sem);
-out:
-	kunmap(bvec->bv_page);
-	return ret;
-
-unlock:
-	unlock_page(page);
-	page_cache_release(page);
-fail:
-	up(&mapping->host->i_sem);
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
+/*
+ *  First number of 'lo_prealloc' is the default number of RAM pages
+ *  to pre-allocate for each device backed loop. Every (configured)
+ *  device backed loop pre-allocates this amount of RAM pages unless
+ *  later 'lo_prealloc' numbers provide an override. 'lo_prealloc'
+ *  overrides are defined in pairs: loop_index,number_of_pages
+ */
+static int lo_prealloc[9] = { 125, -1, 0, -1, 0, -1, 0, -1, 0 };
+#define LO_PREALLOC_MIN 4    /* minimum user defined pre-allocated RAM pages */
+#define LO_PREALLOC_MAX 512  /* maximum user defined pre-allocated RAM pages */
+
+#ifdef MODULE
+MODULE_PARM(lo_prealloc, "1-9i");
+MODULE_PARM_DESC(lo_prealloc, "Number of pre-allocated pages [,index,pages]...");
+#else
+static int __init lo_prealloc_setup(char *str)
+{
+	int x, y, z;
+
+	for (x = 0; x < (sizeof(lo_prealloc) / sizeof(int)); x++) {
+		z = get_option(&str, &y);
+		if (z > 0)
+			lo_prealloc[x] = y;
+		if (z < 2)
 			break;
-		pos += bvec->bv_len;
 	}
-	return ret;
+	return 1;
 }
+__setup("lo_prealloc=", lo_prealloc_setup);
+#endif
 
-struct lo_read_data {
-	struct loop_device *lo;
-	char *data;
-	int bsize;
-};
-
-static int
-lo_read_actor(read_descriptor_t *desc, struct page *page,
-	      unsigned long offset, unsigned long size)
-{
-	char *kaddr;
-	unsigned long count = desc->count;
-	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
-	struct loop_device *lo = p->lo;
-	int IV = page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
+/*
+ * This is loop helper thread nice value in range
+ * from 0 (low priority) to -20 (high priority).
+ */
+static int lo_nice = -1;
 
-	if (size > count)
-		size = count;
+#ifdef MODULE
+MODULE_PARM(lo_nice, "1i");
+MODULE_PARM_DESC(lo_nice, "Loop thread scheduler nice (0 ... -20)");
+#else
+static int __init lo_nice_setup(char *str)
+{
+	int y;
+
+	if (get_option(&str, &y) == 1)
+		lo_nice = y;
+	return 1;
+}
+__setup("lo_nice=", lo_nice_setup);
+#endif
+
+struct loop_bio_extension {
+	struct bio		*bioext_merge;
+	struct loop_device	*bioext_loop;
+	sector_t		bioext_sector;
+	int			bioext_index;
+	int			bioext_size;
+};	
 
-	kaddr = kmap(page);
-	if (lo_do_transfer(lo, READ, kaddr + offset, p->data, size, IV)) {
-		size = 0;
-		printk(KERN_ERR "loop: transfer error block %ld\n",
-		       page->index);
-		desc->error = -EINVAL;
-	}
-	kunmap(page);
-	
-	desc->count = count - size;
-	desc->written += size;
-	p->data += size;
-	return size;
-}
+static struct loop_device **loop_dev_ptr_arr;
 
-static int
-do_lo_receive(struct loop_device *lo,
-	      struct bio_vec *bvec, int bsize, loff_t pos)
+static void loop_prealloc_cleanup(struct loop_device *lo)
 {
-	struct lo_read_data cookie;
-	struct file *file;
-	int retval;
-
-	cookie.lo = lo;
-	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
-	cookie.bsize = bsize;
-	file = lo->lo_backing_file;
-	retval = file->f_op->sendfile(file, &pos, bvec->bv_len,
-			lo_read_actor, &cookie);
-	kunmap(bvec->bv_page);
-	return (retval < 0)? retval: 0;
+	struct bio *bio;
+
+	while ((bio = lo->lo_bio_free0)) {
+		lo->lo_bio_free0 = bio->bi_next;
+		__free_page(bio->bi_io_vec[0].bv_page);
+		kfree(bio->bi_private);
+		bio->bi_next = NULL;
+		bio_put(bio);
+	}
+	while ((bio = lo->lo_bio_free1)) {
+		lo->lo_bio_free1 = bio->bi_next;
+		/* bi_flags was used for other purpose */
+		bio->bi_flags = 0;
+		/* bi_cnt was used for other purpose */
+		atomic_set(&bio->bi_cnt, 1);
+		bio->bi_next = NULL;
+		bio_put(bio);
+	}
 }
 
-static int
-lo_receive(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+static int loop_prealloc_init(struct loop_device *lo, int y)
 {
-	unsigned vecnr;
-	int ret = 0;
+	struct bio *bio;
+	int x;
 
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+	if(!y) {
+		y = lo_prealloc[0];
+		for (x = 1; x < (sizeof(lo_prealloc) / sizeof(int)); x += 2) {
+			if (lo_prealloc[x + 1] && (lo->lo_number == lo_prealloc[x])) {
+				y = lo_prealloc[x + 1];
+				break;
+			}
+		}
+	}
+	lo->lo_bio_flsh = (y * 3) / 4;
 
-		ret = do_lo_receive(lo, bvec, bsize, pos);
-		if (ret < 0)
-			break;
-		pos += bvec->bv_len;
+	for (x = 0; x < y; x++) {
+		bio = bio_alloc(GFP_KERNEL, 1);
+		if (!bio) {
+			fail1:
+			loop_prealloc_cleanup(lo);
+			return 1;
+		}
+		bio->bi_io_vec[0].bv_page = alloc_page(GFP_KERNEL);
+		if (!bio->bi_io_vec[0].bv_page) {
+			fail2:
+			bio->bi_next = NULL;
+			bio_put(bio);
+			goto fail1;
+		}
+		bio->bi_vcnt = 1;
+		bio->bi_private = kmalloc(sizeof(struct loop_bio_extension), GFP_KERNEL);
+		if (!bio->bi_private)
+			goto fail2;
+		bio->bi_next = lo->lo_bio_free0;
+		lo->lo_bio_free0 = bio;
+
+		bio = bio_alloc(GFP_KERNEL, 1);
+		if (!bio)
+			goto fail1;
+		bio->bi_vcnt = 1;
+		bio->bi_next = lo->lo_bio_free1;
+		lo->lo_bio_free1 = bio;
 	}
-	return ret;
+	return 0;
 }
 
-static inline unsigned long
-loop_get_iv(struct loop_device *lo, unsigned long sector)
+static void loop_add_queue_last(struct loop_device *lo, struct bio *bio, struct bio **q)
 {
-	int bs = lo->lo_blocksize;
-	unsigned long offset, IV;
+	unsigned long flags;
 
-	IV = sector / (bs >> 9) + lo->lo_offset / bs;
-	offset = ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
-	if (offset >= bs)
-		IV++;
+	spin_lock_irqsave(&lo->lo_lock, flags);
+	if (*q) {
+		bio->bi_next = (*q)->bi_next;
+		(*q)->bi_next = bio;
+	} else {
+		bio->bi_next = bio;
+	}
+	*q = bio;
+	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
-	return IV;
+	if (waitqueue_active(&lo->lo_bio_wait))
+		wake_up_interruptible(&lo->lo_bio_wait);
 }
 
-static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
+static void loop_add_queue_first(struct loop_device *lo, struct bio *bio, struct bio **q)
 {
-	loff_t pos;
-	int ret;
-
-	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
-	if (bio_rw(bio) == WRITE)
-		ret = lo_send(lo, bio, lo->lo_blocksize, pos);
-	else
-		ret = lo_receive(lo, bio, lo->lo_blocksize, pos);
-	return ret;
+	spin_lock_irq(&lo->lo_lock);
+	if (*q) {
+		bio->bi_next = (*q)->bi_next;
+		(*q)->bi_next = bio;
+	} else {
+		bio->bi_next = bio;
+		*q = bio;
+	}
+	spin_unlock_irq(&lo->lo_lock);
 }
 
-static int loop_end_io_transfer(struct bio *, unsigned int, int);
-
-static void loop_put_buffer(struct bio *bio)
+static struct bio *loop_get_bio(struct loop_device *lo, int *list_nr)
 {
-	/*
-	 * check bi_end_io, may just be a remapped bio
-	 */
-	if (bio && bio->bi_end_io == loop_end_io_transfer) {
-		int i;
+	struct bio *bio = NULL, *last;
 
-		for (i = 0; i < bio->bi_vcnt; i++)
-			__free_page(bio->bi_io_vec[i].bv_page);
-
-		bio_put(bio);
+	spin_lock_irq(&lo->lo_lock);
+	if ((last = lo->lo_bio_que0)) {
+		bio = last->bi_next;
+		if (bio == last)
+			lo->lo_bio_que0 = NULL;
+		else
+			last->bi_next = bio->bi_next;
+		bio->bi_next = NULL;
+		*list_nr = 0;
+	} else if ((last = lo->lo_bio_que1)) {
+		bio = last->bi_next;
+		if (bio == last)
+			lo->lo_bio_que1 = NULL;
+		else
+			last->bi_next = bio->bi_next;
+		bio->bi_next = NULL;
+		*list_nr = 1;
+	} else if ((last = lo->lo_bio_que2)) {
+		bio = last->bi_next;
+		if (bio == last)
+			lo->lo_bio_que2 = NULL;
+		else
+			last->bi_next = bio->bi_next;
+		bio->bi_next = NULL;
+		*list_nr = 2;
 	}
+	spin_unlock_irq(&lo->lo_lock);
+	return bio;
 }
 
-/*
- * Add bio to back of pending list
- */
-static void loop_add_bio(struct loop_device *lo, struct bio *bio)
+static void loop_put_buffer(struct loop_device *lo, struct bio *b, int flist)
 {
 	unsigned long flags;
+	int wk;
 
 	spin_lock_irqsave(&lo->lo_lock, flags);
-	if (lo->lo_biotail) {
-		lo->lo_biotail->bi_next = bio;
-		lo->lo_biotail = bio;
-	} else
-		lo->lo_bio = lo->lo_biotail = bio;
-	spin_unlock_irqrestore(&lo->lo_lock, flags);
-
-	up(&lo->lo_bh_mutex);
-}
-
-/*
- * Grab first pending buffer
- */
-static struct bio *loop_get_bio(struct loop_device *lo)
-{
-	struct bio *bio;
-
-	spin_lock_irq(&lo->lo_lock);
-	if ((bio = lo->lo_bio)) {
-		if (bio == lo->lo_biotail)
-			lo->lo_biotail = NULL;
-		lo->lo_bio = bio->bi_next;
-		bio->bi_next = NULL;
+	if(!flist) {
+		b->bi_next = lo->lo_bio_free0;
+		lo->lo_bio_free0 = b;
+		wk = lo->lo_bio_need & 1;
+	} else {
+		b->bi_next = lo->lo_bio_free1;
+		lo->lo_bio_free1 = b;
+		wk = lo->lo_bio_need & 2;
 	}
-	spin_unlock_irq(&lo->lo_lock);
+	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
-	return bio;
+	if (wk && waitqueue_active(&lo->lo_bio_wait))
+		wake_up_interruptible(&lo->lo_bio_wait);
 }
 
-/*
- * if this was a WRITE lo->transfer stuff has already been done. for READs,
- * queue it for the loop thread and let it do the transfer out of
- * bi_end_io context (we don't want to do decrypt of a page with irqs
- * disabled)
- */
 static int loop_end_io_transfer(struct bio *bio, unsigned int bytes_done, int err)
 {
-	struct bio *rbh = bio->bi_private;
-	struct loop_device *lo = rbh->bi_bdev->bd_disk->private_data;
+	struct loop_bio_extension *extension = bio->bi_private;
+	struct bio *merge = extension->bioext_merge;
+	struct loop_device *lo = extension->bioext_loop;
+	struct bio *origbio = merge->bi_private;
 
+	if (err)
+		clear_bit(0, &merge->bi_flags);
 	if (bio->bi_size)
 		return 1;
-
-	if (err || bio_rw(bio) == WRITE) {
-		bio_endio(rbh, rbh->bi_size, err);
+	if (bio_rw(bio) == WRITE) {
+		loop_put_buffer(lo, bio, 0);
+		if (!atomic_dec_and_test(&merge->bi_cnt))
+			return 0;
+		if (bio_barrier(origbio))
+			atomic_dec(&lo->lo_bio_barr);
+		origbio->bi_next = NULL;
+		bio_endio(origbio, origbio->bi_size, test_bit(0, &merge->bi_flags) ? 0 : -EIO);
+		loop_put_buffer(lo, merge, 1);
 		if (atomic_dec_and_test(&lo->lo_pending))
-			up(&lo->lo_bh_mutex);
-		loop_put_buffer(bio);
-	} else
-		loop_add_bio(lo, bio);
-
+			wake_up_interruptible(&lo->lo_bio_wait);
+	} else {
+		loop_add_queue_last(lo, bio, &lo->lo_bio_que0);
+	}
 	return 0;
 }
 
-static struct bio *loop_copy_bio(struct bio *rbh)
+static struct bio *loop_get_buffer(struct loop_device *lo,
+		struct bio *orig_bio, int from_thread, struct bio **merge_ptr)
 {
-	struct bio *bio;
-	struct bio_vec *bv;
-	int i;
+	struct bio *bio = NULL, *merge = *merge_ptr;
+	struct loop_bio_extension *extension;
+	unsigned long flags;
+	int len;
 
-	bio = bio_alloc(__GFP_NOWARN, rbh->bi_vcnt);
-	if (!bio)
+	/*
+	 * If called from make_request and if there are unprocessed
+	 * barrier requests, fail allocation so that request is
+	 * inserted to end of no-merge-allocated list. This guarantees
+	 * FIFO processing order of requests.
+	 */
+	if (!from_thread && atomic_read(&lo->lo_bio_barr))
 		return NULL;
 
+	spin_lock_irqsave(&lo->lo_lock, flags);
+	if (!merge) {
+		merge = lo->lo_bio_free1;
+		if (merge) {
+			lo->lo_bio_free1 = merge->bi_next;
+			if (from_thread)
+				lo->lo_bio_need = 0;
+		} else {
+			if (from_thread)
+				lo->lo_bio_need = 2;
+		}
+	}
+
 	/*
-	 * iterate iovec list and alloc pages
+	 * If there are unprocessed barrier requests and a merge-bio was just
+	 * allocated, do not allocate a buffer-bio yet. This causes request
+	 * to be moved from head of no-merge-allocated list to end of
+	 * merge-allocated list. This guarantees FIFO processing order
+	 * of requests.
 	 */
-	__bio_for_each_segment(bv, rbh, i, 0) {
-		struct bio_vec *bbv = &bio->bi_io_vec[i];
-
-		bbv->bv_page = alloc_page(__GFP_NOWARN|__GFP_HIGHMEM);
-		if (bbv->bv_page == NULL)
-			goto oom;
+	if (merge && (*merge_ptr || !atomic_read(&lo->lo_bio_barr))) {
+		bio = lo->lo_bio_free0;
+		if (bio) {
+			lo->lo_bio_free0 = bio->bi_next;
+			if (from_thread)
+				lo->lo_bio_need = 0;
+		} else {
+			if (from_thread)
+				lo->lo_bio_need = 1;
+		}
+	}
+	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
-		bbv->bv_len = bv->bv_len;
-		bbv->bv_offset = bv->bv_offset;
+	if (!(*merge_ptr) && merge) {
+		/*
+		 * initialize "merge-bio" which is used as
+		 * rendezvous point among multiple vecs
+		 */
+		*merge_ptr = merge;
+		merge->bi_sector = orig_bio->bi_sector + (lo->lo_offset >> 9);
+		set_bit(0, &merge->bi_flags);
+		merge->bi_idx = orig_bio->bi_idx;
+		atomic_set(&merge->bi_cnt, orig_bio->bi_vcnt - orig_bio->bi_idx);
+		merge->bi_private = orig_bio;
 	}
 
-	bio->bi_vcnt = rbh->bi_vcnt;
-	bio->bi_size = rbh->bi_size;
+	if (!bio)
+		return NULL;
 
-	return bio;
+	/*
+	 * initialize one page "buffer-bio"
+	 */
+	bio->bi_sector = merge->bi_sector;
+	bio->bi_next = NULL;
+	bio->bi_bdev = lo->lo_device;
+	bio->bi_flags = 0;
+	bio->bi_rw = orig_bio->bi_rw & ~(1 << BIO_RW_BARRIER);
+	if (bio_barrier(orig_bio) && ((merge->bi_idx == orig_bio->bi_idx) || (merge->bi_idx == (orig_bio->bi_vcnt - 1))))
+		bio->bi_rw |= (1 << BIO_RW_BARRIER);
+	bio->bi_vcnt = 1;
+	bio->bi_idx = 0;
+	bio->bi_phys_segments = 0;
+	bio->bi_hw_segments = 0;
+	bio->bi_size = len = orig_bio->bi_io_vec[merge->bi_idx].bv_len;
+	/* bio->bi_max_vecs not touched */
+	bio->bi_io_vec[0].bv_len = len;
+	bio->bi_io_vec[0].bv_offset = 0;
+	bio->bi_end_io = loop_end_io_transfer;
+	/* bio->bi_cnt not touched */
+	/* bio->bi_private not touched */
+	/* bio->bi_destructor not touched */
+
+	/*
+	 * initialize "buffer-bio" extension. This extension is
+	 * permanently glued to above "buffer-bio" via bio->bi_private
+	 */
+	extension = bio->bi_private;
+	extension->bioext_merge = merge;
+	extension->bioext_loop = lo;
+	extension->bioext_sector = merge->bi_sector;
+	extension->bioext_index = merge->bi_idx;
+	extension->bioext_size = len;
 
-oom:
-	while (--i >= 0)
-		__free_page(bio->bi_io_vec[i].bv_page);
+	/*
+	 * prepare "merge-bio" for next vec
+	 */
+	merge->bi_sector += len >> 9;
+	merge->bi_idx++;
 
-	bio_put(bio);
-	return NULL;
+	return bio;
 }
 
-static struct bio *loop_get_buffer(struct loop_device *lo, struct bio *rbh)
+static int figure_loop_size(struct loop_device *lo, struct block_device *bdev, loff_t info64size)
 {
-	struct bio *bio;
+	loff_t size, offs;
+	sector_t x;
+	int err = 0;
+
+	size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
+	offs = lo->lo_offset;
+	if (!(lo->lo_flags & LO_FLAGS_DO_BMAP))
+		offs &= ~((loff_t)511);
+	size = (size - offs) >> 9;
+	info64size >>= 9;
+	if ((info64size > 0) && (info64size < size))
+		size = info64size;
 
 	/*
-	 * When called on the page reclaim -> writepage path, this code can
-	 * trivially consume all memory.  So we drop PF_MEMALLOC to avoid
-	 * stealing all the page reserves and throttle to the writeout rate.
-	 * pdflush will have been woken by page reclaim.  Let it do its work.
+	 * Unfortunately, if we want to do I/O on the device,
+	 * the number of 512-byte sectors has to fit into a sector_t.
 	 */
-	do {
-		int flags = current->flags;
+	x = (sector_t)size;
+	if ((loff_t)x != size) {
+		err = -EFBIG;
+		size = 0;
+	}
 
-		current->flags &= ~PF_MEMALLOC;
-		bio = loop_copy_bio(rbh);
-		if (flags & PF_MEMALLOC)
-			current->flags |= PF_MEMALLOC;
-
-		if (bio == NULL)
-			blk_congestion_wait(WRITE, HZ/10);
-	} while (bio == NULL);
+	bdev->bd_inode->i_size = size << 9;		/* byte units */
+	set_capacity(disks[lo->lo_number], size);	/* 512 byte units */
+	return err;
+}
 
-	bio->bi_end_io = loop_end_io_transfer;
-	bio->bi_private = rbh;
-	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
-	bio->bi_rw = rbh->bi_rw;
-	bio->bi_bdev = lo->lo_device;
+static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
+				 char *lbuf, int size, sector_t rblock)
+{
+	if (!lo->transfer)
+		return 0;
 
-	return bio;
+	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
 }
 
-static int loop_transfer_bio(struct loop_device *lo,
-			     struct bio *to_bio, struct bio *from_bio)
+static int loop_file_io(struct file *file, char *buf, int size, loff_t *ppos, int w)
 {
-	unsigned long IV = loop_get_iv(lo, from_bio->bi_sector);
-	struct bio_vec *from_bvec, *to_bvec;
-	char *vto, *vfrom;
-	int ret = 0, i;
+	mm_segment_t fs;
+	int x, y, z;
 
-	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
-		to_bvec = &to_bio->bi_io_vec[i];
+	y = 0;
+	do {
+		z = size - y;
+		fs = get_fs();
+		set_fs(get_ds());
+		if (w) {
+			x = file->f_op->write(file, buf + y, z, ppos);
+			set_fs(fs);
+		} else {
+			x = file->f_op->read(file, buf + y, z, ppos);
+			set_fs(fs);
+			if (!x)
+				return 1;
+		}
+		if (x < 0) {
+			if ((x == -EAGAIN) || (x == -ENOMEM) || (x == -ERESTART) || (x == -EINTR)) {
+				blk_run_queues();
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(HZ / 2);
+				continue;
+			}
+			return 1;
+		}
+		y += x;
+	} while (y < size);
+	return 0;
+}
 
-		kmap(from_bvec->bv_page);
-		kmap(to_bvec->bv_page);
-		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
-		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
-		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-					from_bvec->bv_len, IV);
-		kunmap(from_bvec->bv_page);
-		kunmap(to_bvec->bv_page);
-	}
+static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
+{
+	loff_t pos;
+	struct file *file = lo->lo_backing_file;
+	char *data, *buf;
+	unsigned int size, len;
+	sector_t IV;
 
-	return ret;
+	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
+	buf = page_address(lo->lo_bio_free0->bi_io_vec[0].bv_page);
+	IV = bio->bi_sector + (lo->lo_offset >> 9);
+	do {
+		len = bio->bi_io_vec[bio->bi_idx].bv_len;
+		data = bio_data(bio);
+		while (len > 0) {
+			if (lo->lo_encrypt_type == LO_CRYPT_NONE) {
+				/* this code relies that NONE transfer is a no-op */
+				buf = data;
+			}
+			size = PAGE_SIZE;
+			if (size > len)
+				size = len;
+			if (bio_rw(bio) == WRITE) {
+				if (lo_do_transfer(lo, WRITE, buf, data, size, IV)) {
+					printk(KERN_ERR "loop%d: write transfer error, sector %llu\n", lo->lo_number, (unsigned long long)IV);
+					return -EIO;
+				}
+				if (loop_file_io(file, buf, size, &pos, 1)) {
+					printk(KERN_ERR "loop%d: write i/o error, sector %llu\n", lo->lo_number, (unsigned long long)IV);
+					return -EIO;
+				}
+			} else {
+				if (loop_file_io(file, buf, size, &pos, 0)) {
+					printk(KERN_ERR "loop%d: read i/o error, sector %llu\n", lo->lo_number, (unsigned long long)IV);
+					return -EIO;
+				}
+				if (lo_do_transfer(lo, READ, buf, data, size, IV)) {
+					printk(KERN_ERR "loop%d: read transfer error, sector %llu\n", lo->lo_number, (unsigned long long)IV);
+					return -EIO;
+				}
+			}
+			data += size;
+			len -= size;
+			IV += size >> 9;
+		}
+	} while (++bio->bi_idx < bio->bi_vcnt);
+	return 0;
 }
-		
-static int loop_make_request(request_queue_t *q, struct bio *old_bio)
+
+static int loop_make_request_err(request_queue_t *q, struct bio *old_bio)
+{       
+	old_bio->bi_next = NULL;
+	bio_io_error(old_bio, old_bio->bi_size);
+	return 0;
+}
+
+static int loop_make_request_real(request_queue_t *q, struct bio *old_bio)
 {
-	struct bio *new_bio = NULL;
+	struct bio *new_bio, *merge;
 	struct loop_device *lo = q->queuedata;
-	int rw = bio_rw(old_bio);
+	struct loop_bio_extension *extension;
+	int rw = bio_rw(old_bio), y;
 
+	set_current_state(TASK_RUNNING);
 	if (!lo)
 		goto out;
-
-	spin_lock_irq(&lo->lo_lock);
-	if (lo->lo_state != Lo_bound)
-		goto inactive;
+	if ((rw == WRITE) && (lo->lo_flags & LO_FLAGS_READ_ONLY))
+		goto out;
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
+	blk_queue_bounce(q, &old_bio);
 
 	/*
 	 * file backed, queue for loop_thread to handle
 	 */
 	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		loop_add_bio(lo, old_bio);
+		loop_add_queue_last(lo, old_bio, &lo->lo_bio_que0);
 		return 0;
 	}
 
 	/*
-	 * piggy old buffer on original, and submit for I/O
+	 * device backed, just remap bdev & sector for NONE transfer
 	 */
-	new_bio = loop_get_buffer(lo, old_bio);
+	if (lo->lo_encrypt_type == LO_CRYPT_NONE) {
+		old_bio->bi_sector += lo->lo_offset >> 9;
+		old_bio->bi_bdev = lo->lo_device;
+		generic_make_request(old_bio);
+		if (atomic_dec_and_test(&lo->lo_pending))
+			wake_up_interruptible(&lo->lo_bio_wait);
+		return 0;
+	}
+
+	/*
+	 * device backed, start reads and writes now if buffer available
+	 */
+	merge = NULL;
+	if (bio_barrier(old_bio))
+		atomic_inc(&lo->lo_bio_barr);
+	try_next_old_bio_vec:
+	new_bio = loop_get_buffer(lo, old_bio, 0, &merge);
+	if (!new_bio) {
+		/* just queue request and let thread handle allocs later */
+		if (merge)
+			loop_add_queue_last(lo, merge, &lo->lo_bio_que1);
+		else
+			loop_add_queue_last(lo, old_bio, &lo->lo_bio_que2);
+		return 0;
+	}
 	if (rw == WRITE) {
-		if (loop_transfer_bio(lo, new_bio, old_bio))
-			goto err;
+		extension = new_bio->bi_private;
+		y = extension->bioext_index;
+		if (lo_do_transfer(lo, WRITE, page_address(new_bio->bi_io_vec[0].bv_page), page_address(old_bio->bi_io_vec[y].bv_page) + old_bio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
+			clear_bit(0, &merge->bi_flags);
+		}
 	}
 
+	/* merge & old_bio may vanish during generic_make_request() */
+	/* if last vec gets processed before function returns   */
+	y = (merge->bi_idx < old_bio->bi_vcnt) ? 1 : 0;
 	generic_make_request(new_bio);
+
+	/* other vecs may need processing too */
+	if (y)
+		goto try_next_old_bio_vec;
 	return 0;
 
-err:
-	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
-	loop_put_buffer(new_bio);
 out:
+	old_bio->bi_next = NULL;
 	bio_io_error(old_bio, old_bio->bi_size);
 	return 0;
-inactive:
-	spin_unlock_irq(&lo->lo_lock);
-	goto out;
-}
-
-static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
-{
-	int ret;
-
-	/*
-	 * For block backed loop, we know this is a READ
-	 */
-	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		ret = do_bio_filebacked(lo, bio);
-		bio_endio(bio, bio->bi_size, ret);
-	} else {
-		struct bio *rbh = bio->bi_private;
-
-		ret = loop_transfer_bio(lo, bio, rbh);
-
-		bio_endio(rbh, rbh->bi_size, ret);
-		loop_put_buffer(bio);
-	}
 }
 
 /*
@@ -610,17 +724,27 @@
 static int loop_thread(void *data)
 {
 	struct loop_device *lo = data;
-	struct bio *bio;
+	struct bio *bio, *xbio, *merge;
+	struct loop_bio_extension *extension;
+	int x, y, flushcnt = 0;
+	wait_queue_t waitq;
+	static const struct rlimit loop_rlim_defaults[RLIM_NLIMITS] = INIT_RLIMITS;
 
+	init_waitqueue_entry(&waitq, current);
+	memcpy(&current->rlim[0], &loop_rlim_defaults[0], sizeof(current->rlim));
 	daemonize("loop%d", lo->lo_number);
 
-	current->flags |= PF_IOTHREAD;	/* loop can be used in an encrypted device
+	current->flags |= PF_IOTHREAD | PF_LESS_THROTTLE;
+					/* loop can be used in an encrypted device
 					   hence, it mustn't be stopped at all because it could
 					   be indirectly used during suspension */
 
-	set_user_nice(current, -20);
+	if (lo_nice > 0)
+		lo_nice = 0;
+	if (lo_nice < -20)
+		lo_nice = -20;
+	set_user_nice(current, lo_nice);
 
-	lo->lo_state = Lo_bound;
 	atomic_inc(&lo->lo_pending);
 
 	/*
@@ -629,23 +753,134 @@
 	up(&lo->lo_sem);
 
 	for (;;) {
-		down_interruptible(&lo->lo_bh_mutex);
+		add_wait_queue(&lo->lo_bio_wait, &waitq);
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (!atomic_read(&lo->lo_pending))
+				break;
+
+			x = 0;
+			spin_lock_irq(&lo->lo_lock);
+			if (lo->lo_bio_que0) {
+				/* don't sleep if device backed READ needs processing */
+				/* don't sleep if file backed READ/WRITE needs processing */
+				x = 1;
+			} else if (lo->lo_bio_que1) {
+				/* don't sleep if a buffer-bio is available */
+				/* don't sleep if need-buffer-bio request is not set */
+				if (lo->lo_bio_free0 || !(lo->lo_bio_need & 1))
+					x = 1;
+			} else if (lo->lo_bio_que2) {
+				/* don't sleep if a merge-bio is available */
+				/* don't sleep if need-merge-bio request is not set */
+				if (lo->lo_bio_free1 || !(lo->lo_bio_need & 2))
+					x = 1;
+			}
+			spin_unlock_irq(&lo->lo_lock);
+			if (x)
+				break;
+
+			schedule();
+		}
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&lo->lo_bio_wait, &waitq);
+
 		/*
-		 * could be upped because of tear-down, not because of
+		 * could be woken because of tear-down, not because of
 		 * pending work
 		 */
 		if (!atomic_read(&lo->lo_pending))
 			break;
 
-		bio = loop_get_bio(lo);
-		if (!bio) {
-			printk("loop: missing bio\n");
+		bio = loop_get_bio(lo, &x);
+		if (!bio)
 			continue;
+
+		/*
+		 *  x  list tag         usage(has-buffer,has-merge)
+		 * --- --------         --------------------------
+		 *  0  lo->lo_bio_que0  dev-r(y,y) / file-rw
+		 *  1  lo->lo_bio_que1  dev-rw(n,y)
+		 *  2  lo->lo_bio_que2  dev-rw(n,n)
+		 */
+		if (x >= 1) {
+			/* loop_make_request_real didn't allocate a buffer, do that now */
+			if (x == 1) {
+				merge = bio;
+				bio = merge->bi_private;
+			} else {
+				merge = NULL;
+			}
+			try_next_bio_vec:
+			xbio = loop_get_buffer(lo, bio, 1, &merge);
+			if (!xbio) {
+				blk_run_queues();
+				flushcnt = 0;
+				if (merge)
+					loop_add_queue_first(lo, merge, &lo->lo_bio_que1);
+				else
+					loop_add_queue_first(lo, bio, &lo->lo_bio_que2);
+				/* lo->lo_bio_need should be non-zero now, go back to sleep */
+				continue;
+			}
+			if (bio_rw(bio) == WRITE) {
+				extension = xbio->bi_private;
+				y = extension->bioext_index;
+				if (lo_do_transfer(lo, WRITE, page_address(xbio->bi_io_vec[0].bv_page), page_address(bio->bi_io_vec[y].bv_page) + bio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
+					clear_bit(0, &merge->bi_flags);
+				}
+			}
+
+			/* merge & bio may vanish during generic_make_request() */
+			/* if last vec gets processed before function returns   */
+			y = (merge->bi_idx < bio->bi_vcnt) ? 1 : 0;
+			generic_make_request(xbio);
+
+			/* start I/O if there are no more requests lacking buffers */
+			x = 0;
+			spin_lock_irq(&lo->lo_lock);
+			if (!y && !lo->lo_bio_que1 && !lo->lo_bio_que2)
+				x = 1;
+			spin_unlock_irq(&lo->lo_lock);
+			if (x || (++flushcnt >= lo->lo_bio_flsh)) {
+				blk_run_queues();
+				flushcnt = 0;
+			}
+
+			/* other vecs may need processing too */
+			if (y)
+				goto try_next_bio_vec;
+
+			/* request not completely processed yet */
+ 			continue;
+ 		}
+
+		if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
+			/* request is for file backed device */
+			y = do_bio_filebacked(lo, bio);
+			bio->bi_next = NULL;
+			bio_endio(bio, bio->bi_size, y);
+		} else {
+			/* device backed read has completed, do decrypt now */
+			extension = bio->bi_private;
+			merge = extension->bioext_merge;
+			y = extension->bioext_index;
+			xbio = merge->bi_private;
+			if (lo_do_transfer(lo, READ, page_address(bio->bi_io_vec[0].bv_page), page_address(xbio->bi_io_vec[y].bv_page) + xbio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
+				clear_bit(0, &merge->bi_flags);
+			}
+			loop_put_buffer(lo, bio, 0);
+			if (!atomic_dec_and_test(&merge->bi_cnt))
+				continue;
+			if (bio_barrier(xbio))
+				atomic_dec(&lo->lo_bio_barr);
+			xbio->bi_next = NULL;
+			bio_endio(xbio, xbio->bi_size, test_bit(0, &merge->bi_flags) ? 0 : -EIO);
+			loop_put_buffer(lo, merge, 1);
 		}
-		loop_handle_bio(lo, bio);
 
 		/*
-		 * upped both for pending work and tear-down, lo_pending
+		 * woken both for pending work and tear-down, lo_pending
 		 * will hit zero then
 		 */
 		if (atomic_dec_and_test(&lo->lo_pending))
@@ -656,23 +891,37 @@
 	return 0;
 }
 
+static void loop_set_softblksz(struct loop_device *lo, struct block_device *bdev)
+{
+	int	bs, x;
+
+	if (lo->lo_device)
+		bs = block_size(lo->lo_device);
+	else
+		bs = PAGE_SIZE;
+	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
+		x = (int) bdev->bd_inode->i_size;
+		if ((bs == 8192) && (x & 0x1E00))
+			bs = 4096;
+		if ((bs == 4096) && (x & 0x0E00))
+			bs = 2048;
+		if ((bs == 2048) && (x & 0x0600))
+			bs = 1024;
+		if ((bs == 1024) && (x & 0x0200))
+			bs = 512;
+	}
+	set_blocksize(bdev, bs);
+}
+
 static int loop_set_fd(struct loop_device *lo, struct file *lo_file,
 		       struct block_device *bdev, unsigned int arg)
 {
 	struct file	*file;
 	struct inode	*inode;
 	struct block_device *lo_device = NULL;
-	unsigned lo_blocksize;
 	int		lo_flags = 0;
 	int		error;
 
-	/* This is safe, since we have a reference from open(). */
-	__module_get(THIS_MODULE);
-
-	error = -EBUSY;
-	if (lo->lo_state != Lo_unbound)
-		goto out;
-
 	error = -EBADF;
 	file = fget(arg);
 	if (!file)
@@ -684,30 +933,55 @@
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
+	init_MUTEX_LOCKED(&lo->lo_sem);
+	spin_lock_init(&lo->lo_lock);
+	init_waitqueue_head(&lo->lo_bio_wait);
+	atomic_set(&lo->lo_pending, 0);
+	atomic_set(&lo->lo_bio_barr, 0);
+	lo->lo_offset = 0;
+	lo->lo_encrypt_type = 0;
+	lo->lo_encrypt_key_size = 0;
+	lo->transfer = NULL;
+	lo->lo_name[0] = 0;
+	lo->lo_init[1] = lo->lo_init[0] = 0;
+	lo->lo_key_owner = 0;
+	lo->ioctl = NULL;
+	lo->key_data = NULL;	
+	lo->lo_bio_que2 = lo->lo_bio_que1 = lo->lo_bio_que0 = NULL;
+	lo->lo_bio_free1 = lo->lo_bio_free0 = NULL;
+	lo->lo_bio_flsh = lo->lo_bio_need = 0;
+	memset(&lo->key_reserved[0], 0, sizeof(lo->key_reserved));
+
 	if (S_ISBLK(inode->i_mode)) {
 		lo_device = inode->i_bdev;
 		if (lo_device == bdev) {
 			error = -EBUSY;
-			goto out;
+			goto out_putf;
+		}
+		if (loop_prealloc_init(lo, 0)) {
+			error = -ENOMEM;
+			goto out_putf;
 		}
-		lo_blocksize = block_size(lo_device);
 		if (bdev_read_only(lo_device))
 			lo_flags |= LO_FLAGS_READ_ONLY;
+		else
+			filemap_fdatawrite(inode->i_mapping);
 	} else if (S_ISREG(inode->i_mode)) {
-		struct address_space_operations *aops = inode->i_mapping->a_ops;
 		/*
 		 * If we can't read - sorry. If we only can't write - well,
 		 * it's going to be read-only.
 		 */
-		if (!inode->i_fop->sendfile)
+		if (!file->f_op || !file->f_op->read)
 			goto out_putf;
 
-		if (!aops->prepare_write || !aops->commit_write)
+		if (!file->f_op->write)
 			lo_flags |= LO_FLAGS_READ_ONLY;
 
-		lo_blocksize = inode->i_blksize;
 		lo_flags |= LO_FLAGS_DO_BMAP;
-		error = 0;
+		if (loop_prealloc_init(lo, 1)) {
+			error = -ENOMEM;
+			goto out_putf;
+		}
 	} else
 		goto out_putf;
 
@@ -718,35 +992,28 @@
 
 	set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
-	lo->lo_blocksize = lo_blocksize;
 	lo->lo_device = lo_device;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
-	lo->transfer = NULL;
-	lo->ioctl = NULL;
-	if (figure_loop_size(lo)) {
+	if (figure_loop_size(lo, bdev, 0)) {
+		loop_prealloc_cleanup(lo);
 		error = -EFBIG;
 		fput(file);
 		goto out_putf;
 	}
-	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
-	inode->i_mapping->gfp_mask &= ~(__GFP_IO|__GFP_FS);
-
-	set_blocksize(bdev, lo_blocksize);
-
-	lo->lo_bio = lo->lo_biotail = NULL;
 
 	/*
 	 * set queue make_request_fn, and add limits based on lower level
 	 * device
 	 */
-	blk_queue_make_request(&lo->lo_queue, loop_make_request);
-	lo->lo_queue.queuedata = lo;
+	blk_queue_make_request(&lo->lo_queue, loop_make_request_err);
+	blk_queue_bounce_limit(&lo->lo_queue, BLK_BOUNCE_HIGH);
+	blk_queue_max_segment_size(&lo->lo_queue, MAX_SEGMENT_SIZE);
 
 	/*
 	 * we remap to a block device, make sure we correctly stack limits
 	 */
-	if (S_ISBLK(inode->i_mode)) {
+	if (S_ISBLK(inode->i_mode) && lo_device) {
 		request_queue_t *q = bdev_get_queue(lo_device);
 
 		blk_queue_max_sectors(&lo->lo_queue, q->max_sectors);
@@ -755,8 +1022,21 @@
 		blk_queue_max_segment_size(&lo->lo_queue, q->max_segment_size);
 		blk_queue_segment_boundary(&lo->lo_queue, q->seg_boundary_mask);
 		blk_queue_merge_bvec(&lo->lo_queue, q->merge_bvec_fn);
+		blk_queue_hardsect_size(&lo->lo_queue, q->hardsect_size);
+	}
+	bdev->bd_openers++;
+	atomic_inc(&bdev->bd_count);
+	lo->lo_queue.queuedata = lo;
+
+	if (lo_flags & LO_FLAGS_DO_BMAP) {
+		lo->old_gfp_mask = inode->i_mapping->gfp_mask;
+		inode->i_mapping->gfp_mask = GFP_NOIO | __GFP_HIGH;
+	} else {
+		lo->old_gfp_mask = -1;
 	}
 
+	loop_set_softblksz(lo, bdev);
+
 	kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 	down(&lo->lo_sem);
 
@@ -766,8 +1046,6 @@
  out_putf:
 	fput(file);
  out:
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	return error;
 }
 
@@ -775,55 +1053,55 @@
 {
 	int err = 0; 
 	if (lo->lo_encrypt_type) {
-		struct loop_func_table *xfer= xfer_funcs[lo->lo_encrypt_type]; 
+		struct loop_func_table *xfer = xfer_funcs[lo->lo_encrypt_type]; 
+		struct module *owner = xfer->owner;
+		lo->transfer = NULL; 
 		if (xfer && xfer->release)
 			err = xfer->release(lo); 
-		if (xfer && xfer->unlock)
-			xfer->unlock(lo); 
 		lo->lo_encrypt_type = 0;
+		if (xfer)
+			module_put(owner);
 	}
 	return err;
 }
 
-static int
-loop_init_xfer(struct loop_device *lo, int type, const struct loop_info64 *i)
+static int loop_init_xfer(struct loop_device *lo, int type, struct loop_info64 *i)
 {
 	int err = 0; 
 	if (type) {
-		struct loop_func_table *xfer = xfer_funcs[type]; 
-		if (xfer->init)
+		struct loop_func_table *xfer = xfer_funcs[type];
+		struct module *owner = xfer->owner;
+		if(!try_module_get(owner))
+			return -EINVAL;
+		if (xfer->init) {
 			err = xfer->init(lo, i);
-		if (!err) { 
-			lo->lo_encrypt_type = type;
-			if (xfer->lock)
-				xfer->lock(lo);
+			if (err)
+				module_put(owner);
 		}
+		if (!err)
+			lo->lo_encrypt_type = type;
 	}
 	return err;
-}  
+}
 
 static int loop_clr_fd(struct loop_device *lo, struct block_device *bdev)
 {
 	struct file *filp = lo->lo_backing_file;
 	int gfp = lo->old_gfp_mask;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
-	if (lo->lo_refcnt > 1)	/* we needed one fd for the ioctl */
+	if (bdev->bd_openers != 2)	/* one for this fd being open plus one incremented by loop_set_fd */
 		return -EBUSY;
 	if (filp==NULL)
 		return -EINVAL;
 
-	spin_lock_irq(&lo->lo_lock);
-	lo->lo_state = Lo_rundown;
+	lo->lo_queue.queuedata = NULL;
+	lo->lo_queue.make_request_fn = loop_make_request_err;
 	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
-	spin_unlock_irq(&lo->lo_lock);
-
+		wake_up_interruptible(&lo->lo_bio_wait);
 	down(&lo->lo_sem);
 
+	loop_prealloc_cleanup(lo);
 	lo->lo_backing_file = NULL;
-
 	loop_release_xfer(lo);
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
@@ -832,21 +1110,22 @@
 	lo->lo_offset = 0;
 	lo->lo_encrypt_key_size = 0;
 	lo->lo_flags = 0;
-	lo->lo_queue.queuedata = NULL;
+	lo->lo_init[1] = lo->lo_init[0] = 0;
+	lo->lo_key_owner = 0;
+	lo->key_data = NULL;
 	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
 	memset(lo->lo_name, 0, LO_NAME_SIZE);
 	invalidate_bdev(bdev, 0);
 	set_capacity(disks[lo->lo_number], 0);
-	filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
-	lo->lo_state = Lo_unbound;
+	bdev->bd_openers--;
+	atomic_dec(&bdev->bd_count);
+	if (gfp != -1)
+		filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
 	fput(filp);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	return 0;
 }
 
-static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+static int loop_set_status(struct loop_device *lo, struct block_device *bdev, struct loop_info64 *info)
 {
 	int err;
 	unsigned int type;
@@ -855,10 +1134,9 @@
 	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid && 
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
+
 	type = info->lo_encrypt_type; 
 	if (type >= MAX_LO_CRYPT || xfer_funcs[type] == NULL)
 		return -EINVAL;
@@ -866,20 +1144,22 @@
 		return -EINVAL;
 
 	err = loop_release_xfer(lo);
-	if (!err) 
+	if (!err)
 		err = loop_init_xfer(lo, type, info);
 
 	offset = lo->lo_offset;
-	if (offset != info->lo_offset) {
+	if ((offset != info->lo_offset) || info->lo_size) {
 		lo->lo_offset = info->lo_offset;
-		if (figure_loop_size(lo)){
+		if (figure_loop_size(lo, bdev, info->lo_size)) {
 			err = -EFBIG;
 			lo->lo_offset = offset;
 		}
+		if (!err) 
+			loop_set_softblksz(lo, bdev);
 	}
 
 	if (err)
-		return err;	
+		return err;
 
 	strlcpy(lo->lo_name, info->lo_name, LO_NAME_SIZE);
 
@@ -894,18 +1174,18 @@
 		lo->lo_key_owner = current->uid; 
 	}	
 
+	lo->lo_queue.make_request_fn = loop_make_request_real;
 	return 0;
 }
 
 static int
-loop_get_status(struct loop_device *lo, struct loop_info64 *info)
+loop_get_status(struct loop_device *lo, struct block_device *bdev,
+		struct loop_info64 *info)
 {
 	struct file *file = lo->lo_backing_file;
 	struct kstat stat;
 	int error;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
 	error = vfs_getattr(file->f_vfsmnt, file->f_dentry, &stat);
 	if (error)
 		return error;
@@ -918,6 +1198,7 @@
 	info->lo_flags = lo->lo_flags;
 	strlcpy(info->lo_name, lo->lo_name, LO_NAME_SIZE);
 	info->lo_encrypt_type = lo->lo_encrypt_type;
+	info->lo_size = bdev->bd_inode->i_size;
 	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
 		info->lo_encrypt_key_size = lo->lo_encrypt_key_size;
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
@@ -929,6 +1210,7 @@
 static void
 loop_info64_from_old(const struct loop_info *info, struct loop_info64 *info64)
 {
+	memset(info64, 0, sizeof(*info64));
 	info64->lo_number = info->lo_number;
 	info64->lo_device = info->lo_device;
 	info64->lo_inode = info->lo_inode;
@@ -944,8 +1226,9 @@
 }
 
 static int
-loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
+loop_info64_to_old(struct loop_info64 *info64, struct loop_info *info)
 {
+	memset(info, 0, sizeof(*info));
 	info->lo_number = info64->lo_number;
 	info->lo_device = info64->lo_device;
 	info->lo_inode = info64->lo_inode;
@@ -970,7 +1253,7 @@
 }
 
 static int
-loop_set_status_old(struct loop_device *lo, const struct loop_info *arg)
+loop_set_status_old(struct loop_device *lo, struct block_device *bdev, const struct loop_info *arg)
 {
 	struct loop_info info;
 	struct loop_info64 info64;
@@ -978,21 +1261,22 @@
 	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
 		return -EFAULT;
 	loop_info64_from_old(&info, &info64);
-	return loop_set_status(lo, &info64);
+	memset(&info.lo_encrypt_key[0], 0, sizeof(info.lo_encrypt_key));
+	return loop_set_status(lo, bdev, &info64);
 }
 
 static int
-loop_set_status64(struct loop_device *lo, const struct loop_info64 *arg)
+loop_set_status64(struct loop_device *lo, struct block_device *bdev, struct loop_info64 *arg)
 {
 	struct loop_info64 info64;
 
 	if (copy_from_user(&info64, arg, sizeof (struct loop_info64)))
 		return -EFAULT;
-	return loop_set_status(lo, &info64);
+	return loop_set_status(lo, bdev, &info64);
 }
 
 static int
-loop_get_status_old(struct loop_device *lo, struct loop_info *arg) {
+loop_get_status_old(struct loop_device *lo, struct block_device *bdev, struct loop_info *arg) {
 	struct loop_info info;
 	struct loop_info64 info64;
 	int err = 0;
@@ -1000,7 +1284,7 @@
 	if (!arg)
 		err = -EINVAL;
 	if (!err)
-		err = loop_get_status(lo, &info64);
+		err = loop_get_status(lo, bdev, &info64);
 	if (!err)
 		err = loop_info64_to_old(&info64, &info);
 	if (!err && copy_to_user(arg, &info, sizeof(info)))
@@ -1010,14 +1294,14 @@
 }
 
 static int
-loop_get_status64(struct loop_device *lo, struct loop_info64 *arg) {
+loop_get_status64(struct loop_device *lo, struct block_device *bdev, struct loop_info64 *arg) {
 	struct loop_info64 info64;
 	int err = 0;
 
 	if (!arg)
 		err = -EINVAL;
 	if (!err)
-		err = loop_get_status(lo, &info64);
+		err = loop_get_status(lo, bdev, &info64);
 	if (!err && copy_to_user(arg, &info64, sizeof(info64)))
 		err = -EFAULT;
 
@@ -1027,63 +1311,63 @@
 static int lo_ioctl(struct inode * inode, struct file * file,
 	unsigned int cmd, unsigned long arg)
 {
-	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct block_device *bdev = inode->i_bdev;
+	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	down(&lo->lo_ctl_mutex);
+	down(&bdev->bd_sem);
+
+	/*
+	 * LOOP_SET_FD can only be called when no device is attached.
+	 * All other ioctls can only be called when a device is attached.
+	 */
+	if (bdev->bd_disk->queue->queuedata != NULL) {
+		if (cmd == LOOP_SET_FD) {
+			err = -EBUSY;
+			goto out_err;
+		}
+	} else {
+		if (cmd != LOOP_SET_FD) {
+			err = -ENXIO;
+			goto out_err;
+		}
+	}
+
 	switch (cmd) {
 	case LOOP_SET_FD:
-		err = loop_set_fd(lo, file, inode->i_bdev, arg);
+		err = loop_set_fd(lo, file, bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		err = loop_clr_fd(lo, inode->i_bdev);
+		err = loop_clr_fd(lo, bdev);
 		break;
 	case LOOP_SET_STATUS:
-		err = loop_set_status_old(lo, (struct loop_info *) arg);
+		err = loop_set_status_old(lo, bdev, (struct loop_info *) arg);
 		break;
 	case LOOP_GET_STATUS:
-		err = loop_get_status_old(lo, (struct loop_info *) arg);
+		err = loop_get_status_old(lo, bdev, (struct loop_info *) arg);
 		break;
 	case LOOP_SET_STATUS64:
-		err = loop_set_status64(lo, (struct loop_info64 *) arg);
+		err = loop_set_status64(lo, bdev, (struct loop_info64 *) arg);
 		break;
 	case LOOP_GET_STATUS64:
-		err = loop_get_status64(lo, (struct loop_info64 *) arg);
+		err = loop_get_status64(lo, bdev, (struct loop_info64 *) arg);
 		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	up(&lo->lo_ctl_mutex);
+out_err:
+	up(&bdev->bd_sem);
 	return err;
 }
 
 static int lo_open(struct inode *inode, struct file *file)
 {
-	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
-	int type;
-
-	down(&lo->lo_ctl_mutex);
-
-	type = lo->lo_encrypt_type; 
-	if (type && xfer_funcs[type] && xfer_funcs[type]->lock)
-		xfer_funcs[type]->lock(lo);
-	lo->lo_refcnt++;
-	up(&lo->lo_ctl_mutex);
 	return 0;
 }
 
 static int lo_release(struct inode *inode, struct file *file)
 {
-	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
-	int type;
-
-	down(&lo->lo_ctl_mutex);
-	type = lo->lo_encrypt_type;
-	--lo->lo_refcnt;
-	if (xfer_funcs[type] && xfer_funcs[type]->unlock)
-		xfer_funcs[type]->unlock(lo);
-
-	up(&lo->lo_ctl_mutex);
+	sync_blockdev(inode->i_bdev);
 	return 0;
 }
 
@@ -1103,7 +1387,7 @@
 
 int loop_register_transfer(struct loop_func_table *funcs)
 {
-	if ((unsigned)funcs->number > MAX_LO_CRYPT || xfer_funcs[funcs->number])
+	if ((unsigned)funcs->number >= MAX_LO_CRYPT || xfer_funcs[funcs->number])
 		return -EINVAL;
 	xfer_funcs[funcs->number] = funcs;
 	return 0; 
@@ -1112,18 +1396,20 @@
 int loop_unregister_transfer(int number)
 {
 	struct loop_device *lo; 
+	int x, type;
 
 	if ((unsigned)number >= MAX_LO_CRYPT)
 		return -EINVAL; 
-	for (lo = &loop_dev[0]; lo < &loop_dev[max_loop]; lo++) { 
-		int type = lo->lo_encrypt_type;
-		if (type == number) { 
-			xfer_funcs[type]->release(lo);
-			lo->transfer = NULL; 
-			lo->lo_encrypt_type = 0; 
+	for (x = 0; x < max_loop; x++) {
+		lo = loop_dev_ptr_arr[x];
+		if (!lo)
+			continue;
+		type = lo->lo_encrypt_type;
+		if (type == number) {
+			loop_release_xfer(lo);
 		}
 	}
-	xfer_funcs[number] = NULL; 
+	xfer_funcs[number] = NULL;
 	return 0; 
 }
 
@@ -1143,31 +1429,42 @@
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;
 
-	devfs_mk_dir("loop");
-
-	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
-	if (!loop_dev)
-		return -ENOMEM;
+	loop_dev_ptr_arr = kmalloc(max_loop * sizeof(struct loop_device *), GFP_KERNEL);
+	if (!loop_dev_ptr_arr)
+		goto out_mem1;
 
 	disks = kmalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
 	if (!disks)
-		goto out_mem;
+		goto out_mem2;
+
+	for (i = 0; i < max_loop; i++) {
+		loop_dev_ptr_arr[i] = kmalloc(sizeof(struct loop_device), GFP_KERNEL);
+		if (!loop_dev_ptr_arr[i])
+			goto out_mem3;
+	}
 
 	for (i = 0; i < max_loop; i++) {
 		disks[i] = alloc_disk(1);
 		if (!disks[i])
-			goto out_mem2;
+			goto out_mem4;
 	}
 
+	for (i = 0; i < (sizeof(lo_prealloc) / sizeof(int)); i += 2) {
+		if (!lo_prealloc[i])
+			continue;
+		if (lo_prealloc[i] < LO_PREALLOC_MIN)
+			lo_prealloc[i] = LO_PREALLOC_MIN;
+		if (lo_prealloc[i] > LO_PREALLOC_MAX)
+			lo_prealloc[i] = LO_PREALLOC_MAX;
+	}
+
+	devfs_mk_dir("loop");
+
 	for (i = 0; i < max_loop; i++) {
-		struct loop_device *lo = &loop_dev[i];
+		struct loop_device *lo = loop_dev_ptr_arr[i];
 		struct gendisk *disk = disks[i];
-		memset(lo, 0, sizeof(*lo));
-		init_MUTEX(&lo->lo_ctl_mutex);
-		init_MUTEX_LOCKED(&lo->lo_sem);
-		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
+		memset(lo, 0, sizeof(struct loop_device));
 		lo->lo_number = i;
-		spin_lock_init(&lo->lo_lock);
 		disk->major = LOOP_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &lo_fops;
@@ -1177,32 +1474,39 @@
 		disk->queue = &lo->lo_queue;
 		add_disk(disk);
 	}
+
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;
 
-out_mem2:
+out_mem4:
 	while (i--)
 		put_disk(disks[i]);
+	i = max_loop;
+out_mem3:
+	while (i--)
+		kfree(loop_dev_ptr_arr[i]);
 	kfree(disks);
-out_mem:
-	kfree(loop_dev);
+out_mem2:
+	kfree(loop_dev_ptr_arr);
+out_mem1:
+	unregister_blkdev(LOOP_MAJOR, "loop");
 	printk(KERN_ERR "loop: ran out of memory\n");
 	return -ENOMEM;
 }
 
-void loop_exit(void) 
+void loop_exit(void)
 {
 	int i;
+
 	for (i = 0; i < max_loop; i++) {
 		del_gendisk(disks[i]);
 		put_disk(disks[i]);
+		kfree(loop_dev_ptr_arr[i]);
 	}
 	devfs_remove("loop");
-	if (unregister_blkdev(LOOP_MAJOR, "loop"))
-		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
-
+	unregister_blkdev(LOOP_MAJOR, "loop");
 	kfree(disks);
-	kfree(loop_dev);
+	kfree(loop_dev_ptr_arr);
 }
 
 module_init(loop_init);
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/loop.h b/include/linux/loop.h
--- a/include/linux/loop.h	Sun Jun 15 01:41:06 2003
+++ b/include/linux/loop.h	Sat Jun 21 16:36:53 2003
@@ -15,18 +15,19 @@
 
 #ifdef __KERNEL__
 
-/* Possible states of device */
-enum {
-	Lo_unbound,
-	Lo_bound,
-	Lo_rundown,
-};
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/module.h>
+
+/* definitions for IV metric -- cryptoapi specific */
+#define LOOP_IV_SECTOR_BITS 9
+#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
+typedef sector_t loop_iv_t;
 
 struct loop_device {
 	int		lo_number;
-	int		lo_refcnt;
-	int		lo_offset;
 	int		lo_encrypt_type;
+	loff_t		lo_offset;
 	int		lo_encrypt_key_size;
 	int		lo_flags;
 	int		(*transfer)(struct loop_device *, int cmd,
@@ -41,28 +42,28 @@
 
 	struct file *	lo_backing_file;
 	struct block_device *lo_device;
-	unsigned	lo_blocksize;
 	void		*key_data; 
 	char		key_reserved[48]; /* for use by the filter modules */
 
 	int		old_gfp_mask;
 
 	spinlock_t		lo_lock;
-	struct bio 		*lo_bio;
-	struct bio		*lo_biotail;
-	int			lo_state;
 	struct semaphore	lo_sem;
-	struct semaphore	lo_ctl_mutex;
-	struct semaphore	lo_bh_mutex;
 	atomic_t		lo_pending;
 
+	struct bio		*lo_bio_que0;
+	struct bio		*lo_bio_que1;
+	struct bio		*lo_bio_que2;
+	struct bio		*lo_bio_free0;
+	struct bio		*lo_bio_free1;
+	atomic_t		lo_bio_barr;
+	int			lo_bio_flsh;
+	int			lo_bio_need;
+	wait_queue_head_t	lo_bio_wait;
+
 	request_queue_t		lo_queue;
 };
 
-typedef	int (* transfer_proc_t)(struct loop_device *, int cmd,
-				char *raw_buf, char *loop_buf, int size,
-				int real_block);
-
 #endif /* __KERNEL__ */
 
 /*
@@ -102,6 +103,7 @@
 	__u8		   lo_name[LO_NAME_SIZE];
 	__u8		   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
 	__u64		   lo_init[2];
+	__u64		   lo_size;	/* bytes, 0 == max available */
 };
 
 /*
@@ -117,6 +119,8 @@
 #define LO_CRYPT_IDEA     6
 #define LO_CRYPT_DUMMY    9
 #define LO_CRYPT_SKIPJACK 10
+#define LO_CRYPT_AES      16
+#define LO_CRYPT_CRYPTOAPI 18
 #define MAX_LO_CRYPT	20
 
 #ifdef __KERNEL__
@@ -125,13 +129,11 @@
 	int number; 	/* filter type */ 
 	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
 			char *loop_buf, int size, sector_t real_block);
-	int (*init)(struct loop_device *, const struct loop_info64 *); 
+	int (*init)(struct loop_device *, struct loop_info64 *); 
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *); 
 	int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
-	/* lock and unlock manage the module use counts */ 
-	void (*lock)(struct loop_device *);
-	void (*unlock)(struct loop_device *);
+	struct module *owner;
 }; 
 
 int loop_register_transfer(struct loop_func_table *funcs);
