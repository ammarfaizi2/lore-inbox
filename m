Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUGGKf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUGGKf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 06:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUGGKf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 06:35:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35731 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265044AbUGGKfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 06:35:39 -0400
Date: Wed, 7 Jul 2004 12:35:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] bio_copy_user
Message-ID: <20040707103526.GA10373@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

blk_rq_map_user() is a bit of a hack currently, since it drops back to
kmalloc() of bio_map_user() fails. This is unfortunate since it means we
do no real segment or size checking (and the request segment counts
contain crap, already found one bug in a scsi lld). It's also pretty
nasty for > PAGE_SIZE requests, as we attempt to do higher order page
allocations. Even worse still, ide-cd will drop back to pio for
non-sg/bio requests. All in all, very suboptimal.

This patch adds bio_copy_user() which simply sets up a bio with kernel
pages and copies data as needed for reads and writes. It also changes
bio_map_user() to return an error pointer like bio_copy_user(), so we
can return something sane to the user instead of always -ENOMEM.

Against 2.6.7-mm6.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff -urp -X /home/axboe/exclude /opt/kernel/linux-2.6.7-mm6/drivers/block/ll_rw_blk.c linux-2.6.7-mm6/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.6.7-mm6/drivers/block/ll_rw_blk.c	2004-07-07 10:33:29.000000000 +0200
+++ linux-2.6.7-mm6/drivers/block/ll_rw_blk.c	2004-07-07 11:24:11.000000000 +0200
@@ -1857,50 +1857,43 @@ EXPORT_SYMBOL(blk_insert_request);
 struct request *blk_rq_map_user(request_queue_t *q, int rw, void __user *ubuf,
 				unsigned int len)
 {
-	struct request *rq = NULL;
-	char *buf = NULL;
+	unsigned long uaddr;
+	struct request *rq;
 	struct bio *bio;
-	int ret;
+
+	if (len > (q->max_sectors << 9))
+		return ERR_PTR(-EINVAL);
+	if ((!len && ubuf) || (len && !ubuf))
+		return ERR_PTR(-EINVAL);
 
 	rq = blk_get_request(q, rw, __GFP_WAIT);
 	if (!rq)
 		return ERR_PTR(-ENOMEM);
 
-	bio = bio_map_user(q, NULL, (unsigned long) ubuf, len, rw == READ);
-	if (!bio) {
-		int bytes = (len + 511) & ~511;
-
-		buf = kmalloc(bytes, q->bounce_gfp | GFP_USER);
-		if (!buf) {
-			ret = -ENOMEM;
-			goto fault;
-		}
-
-		if (rw == WRITE) {
-			if (copy_from_user(buf, ubuf, len)) {
-				ret = -EFAULT;
-				goto fault;
-			}
-		} else
-			memset(buf, 0, len);
-	}
+	/*
+	 * if alignment requirement is satisfied, map in user pages for
+	 * direct dma. else, set up kernel bounce buffers
+	 */
+	uaddr = (unsigned long) ubuf;
+	if (!(uaddr & queue_dma_alignment(q)) && !(len & queue_dma_alignment(q)))
+		bio = bio_map_user(q, NULL, uaddr, len, rw == READ);
+	else
+		bio = bio_copy_user(q, uaddr, len, rw == READ);
 
-	rq->bio = rq->biotail = bio;
-	if (rq->bio)
+	if (!IS_ERR(bio)) {
+		rq->bio = rq->biotail = bio;
 		blk_rq_bio_prep(q, rq, bio);
 
-	rq->buffer = rq->data = buf;
-	rq->data_len = len;
-	return rq;
-fault:
-	if (buf)
-		kfree(buf);
-	if (bio)
-		bio_unmap_user(bio, 1);
-	if (rq)
-		blk_put_request(rq);
-
-	return ERR_PTR(ret);
+		rq->buffer = rq->data = NULL;
+		rq->data_len = len;
+		return rq;
+	}
+	
+	/*
+	 * bio is the err-ptr
+	 */
+	blk_put_request(rq);
+	return (struct request *) bio;
 }
 
 EXPORT_SYMBOL(blk_rq_map_user);
@@ -1914,18 +1907,15 @@ EXPORT_SYMBOL(blk_rq_map_user);
  * Description:
  *    Unmap a request previously mapped by blk_rq_map_user().
  */
-int blk_rq_unmap_user(struct request *rq, void __user *ubuf, struct bio *bio,
-		      unsigned int ulen)
+int blk_rq_unmap_user(struct request *rq, struct bio *bio, unsigned int ulen)
 {
-	const int read = rq_data_dir(rq) == READ;
 	int ret = 0;
 
-	if (bio)
-		bio_unmap_user(bio, read);
-	if (rq->buffer) {
-		if (read && copy_to_user(ubuf, rq->buffer, ulen))
-			ret = -EFAULT;
-		kfree(rq->buffer);
+	if (bio) {
+		if (bio_flagged(bio, BIO_USER_MAPPED))
+			bio_unmap_user(bio);
+		else
+			ret = bio_uncopy_user(bio);
 	}
 
 	blk_put_request(rq);
diff -urp -X /home/axboe/exclude /opt/kernel/linux-2.6.7-mm6/drivers/block/scsi_ioctl.c linux-2.6.7-mm6/drivers/block/scsi_ioctl.c
--- /opt/kernel/linux-2.6.7-mm6/drivers/block/scsi_ioctl.c	2004-06-16 07:20:26.000000000 +0200
+++ linux-2.6.7-mm6/drivers/block/scsi_ioctl.c	2004-07-07 10:47:55.000000000 +0200
@@ -204,7 +204,7 @@ static int sg_io(request_queue_t *q, str
 			hdr->sb_len_wr = len;
 	}
 
-	if (blk_rq_unmap_user(rq, hdr->dxferp, bio, hdr->dxfer_len))
+	if (blk_rq_unmap_user(rq, bio, hdr->dxfer_len))
 		return -EFAULT;
 
 	/* may not have succeeded, but output values written to control
diff -urp -X /home/axboe/exclude /opt/kernel/linux-2.6.7-mm6/drivers/cdrom/cdrom.c linux-2.6.7-mm6/drivers/cdrom/cdrom.c
--- /opt/kernel/linux-2.6.7-mm6/drivers/cdrom/cdrom.c	2004-07-07 10:33:29.000000000 +0200
+++ linux-2.6.7-mm6/drivers/cdrom/cdrom.c	2004-07-07 10:48:02.000000000 +0200
@@ -2088,7 +2088,7 @@ static int cdrom_read_cdda_bpc(struct cd
 			cdi->last_sense = s->sense_key;
 		}
 
-		if (blk_rq_unmap_user(rq, ubuf, bio, len))
+		if (blk_rq_unmap_user(rq, bio, len))
 			ret = -EFAULT;
 
 		if (ret)
diff -urp -X /home/axboe/exclude /opt/kernel/linux-2.6.7-mm6/drivers/ide/ide-cd.c linux-2.6.7-mm6/drivers/ide/ide-cd.c
--- /opt/kernel/linux-2.6.7-mm6/drivers/ide/ide-cd.c	2004-07-07 10:33:29.000000000 +0200
+++ linux-2.6.7-mm6/drivers/ide/ide-cd.c	2004-07-07 12:25:26.000000000 +0200
@@ -1969,11 +1969,6 @@ static ide_startstop_t cdrom_do_block_pc
 	 * sg request
 	 */
 	if (rq->bio) {
-		if (rq->data_len & 3) {
-			printk("%s: block pc not aligned, len=%d\n", drive->name, rq->data_len);
-			cdrom_end_request(drive, 0);
-			return ide_stopped;
-		}
 		info->dma = drive->using_dma;
 		info->cmd = rq_data_dir(rq);
 	}
@@ -3145,7 +3140,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	int nslots;
 
 	blk_queue_prep_rq(drive->queue, ide_cdrom_prep_fn);
-	blk_queue_dma_alignment(drive->queue, 3);
+	blk_queue_dma_alignment(drive->queue, 15);
 	drive->queue->unplug_delay = (1 * HZ) / 1000;
 	if (!drive->queue->unplug_delay)
 		drive->queue->unplug_delay = 1;
diff -urp -X /home/axboe/exclude /opt/kernel/linux-2.6.7-mm6/fs/bio.c linux-2.6.7-mm6/fs/bio.c
--- /opt/kernel/linux-2.6.7-mm6/fs/bio.c	2004-07-07 10:33:31.000000000 +0200
+++ linux-2.6.7-mm6/fs/bio.c	2004-07-07 12:26:53.000000000 +0200
@@ -376,6 +376,115 @@ int bio_add_page(struct bio *bio, struct
 			      len, offset);
 }
 
+/**
+ *	bio_uncopy_user	-	finish previously mapped bio
+ *	@bio: bio being terminated
+ *
+ *	Free pages allocated from bio_copy_user() and write back data
+ *	to user space in case of a read.
+ */
+int bio_uncopy_user(struct bio *bio)
+{
+	struct bio_vec *bvec;
+	int i, ret = 0;
+
+	if (bio_data_dir(bio) == READ) {
+		char *uaddr = bio->bi_private;
+
+		__bio_for_each_segment(bvec, bio, i, 0) {
+			char *addr = page_address(bvec->bv_page) + bvec->bv_offset;
+			if (!ret && copy_to_user(uaddr, addr, bvec->bv_len))
+				ret = -EFAULT;
+
+			__free_page(bvec->bv_page);
+			uaddr += bvec->bv_len;
+		}
+	}
+
+	bio_put(bio);
+	return ret;
+}
+
+/**
+ *	bio_copy_user	-	copy user data to bio
+ *	@q: destination block queue
+ *	@uaddr: start of user address
+ *	@len: length in bytes
+ *	@write_to_vm: bool indicating writing to pages or not
+ *
+ *	Prepares and returns a bio for indirect user io, bouncing data
+ *	to/from kernel pages as necessary. Must be paired with
+ *	call bio_uncopy_user() on io completion.
+ */
+struct bio *bio_copy_user(request_queue_t *q, unsigned long uaddr,
+			  unsigned int len, int write_to_vm)
+{
+	unsigned long end = (uaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = uaddr >> PAGE_SHIFT;
+	struct bio_vec *bvec;
+	struct page *page;
+	struct bio *bio;
+	int offset, i, ret;
+
+	bio = bio_alloc(GFP_KERNEL, end - start);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+
+	ret = 0;
+	offset = uaddr & ~PAGE_MASK;
+	while (len) {
+		unsigned int bytes = PAGE_SIZE - offset;
+
+		if (bytes > len)
+			bytes = len;
+
+		page = alloc_page(q->bounce_gfp | GFP_KERNEL);
+		if (!page) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		if (__bio_add_page(q, bio, page, bytes, offset) < bytes) {
+			ret = -EINVAL;
+			break;
+		}
+
+		offset = 0;
+		len -= bytes;
+	}
+
+	/*
+	 * success
+	 */
+	if (!ret) {
+		if (!write_to_vm) {
+			bio->bi_rw |= (1 << BIO_RW);
+			/*
+	 		 * for a write, copy in data to kernel pages
+			 */
+			ret = -EFAULT;
+			bio_for_each_segment(bvec, bio, i) {
+				char *addr = page_address(bvec->bv_page) + bvec->bv_offset;
+				if (copy_from_user(addr, (char *) uaddr, bvec->bv_len))
+					goto cleanup;
+			}
+		}
+
+		bio->bi_private = (void *) uaddr;
+		return bio;
+	}
+
+	/*
+	 * cleanup
+	 */
+cleanup:
+	bio_for_each_segment(bvec, bio, i)
+		__free_page(bvec->bv_page);
+
+	bio_put(bio);
+	return ERR_PTR(ret);
+}
+
 static struct bio *__bio_map_user(request_queue_t *q, struct block_device *bdev,
 				  unsigned long uaddr, unsigned int len,
 				  int write_to_vm)
@@ -392,12 +501,13 @@ static struct bio *__bio_map_user(reques
 	 * size for now, in the future we can relax this restriction
 	 */
 	if ((uaddr & queue_dma_alignment(q)) || (len & queue_dma_alignment(q)))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	bio = bio_alloc(GFP_KERNEL, nr_pages);
 	if (!bio)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
+	ret = -ENOMEM;
 	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		goto out;
@@ -446,12 +556,13 @@ static struct bio *__bio_map_user(reques
 	if (!write_to_vm)
 		bio->bi_rw |= (1 << BIO_RW);
 
+	bio->bi_flags |= (1 << BIO_USER_MAPPED);
 	blk_queue_bounce(q, &bio);
 	return bio;
 out:
 	kfree(pages);
 	bio_put(bio);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /**
@@ -462,7 +573,7 @@ out:
  *	@write_to_vm: bool indicating writing to pages or not
  *
  *	Map the user space address into a bio suitable for io to a block
- *	device.
+ *	device. Returns an error pointer in case of error.
  */
 struct bio *bio_map_user(request_queue_t *q, struct block_device *bdev,
 			 unsigned long uaddr, unsigned int len, int write_to_vm)
@@ -471,26 +582,29 @@ struct bio *bio_map_user(request_queue_t
 
 	bio = __bio_map_user(q, bdev, uaddr, len, write_to_vm);
 
-	if (bio) {
-		/*
-		 * subtle -- if __bio_map_user() ended up bouncing a bio,
-		 * it would normally disappear when its bi_end_io is run.
-		 * however, we need it for the unmap, so grab an extra
-		 * reference to it
-		 */
-		bio_get(bio);
+	if (IS_ERR(bio))
+		return bio;
 
-		if (bio->bi_size < len) {
-			bio_endio(bio, bio->bi_size, 0);
-			bio_unmap_user(bio, 0);
-			return NULL;
-		}
-	}
+	/*
+	 * subtle -- if __bio_map_user() ended up bouncing a bio,
+	 * it would normally disappear when its bi_end_io is run.
+	 * however, we need it for the unmap, so grab an extra
+	 * reference to it
+	 */
+	bio_get(bio);
 
-	return bio;
+	if (bio->bi_size == len)
+		return bio;
+
+	/*
+	 * don't support partial mappings
+	 */
+	bio_endio(bio, bio->bi_size, 0);
+	bio_unmap_user(bio);
+	return ERR_PTR(-EINVAL);
 }
 
-static void __bio_unmap_user(struct bio *bio, int write_to_vm)
+static void __bio_unmap_user(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
@@ -511,7 +625,7 @@ static void __bio_unmap_user(struct bio 
 	 * make sure we dirty pages we wrote to
 	 */
 	__bio_for_each_segment(bvec, bio, i, 0) {
-		if (write_to_vm)
+		if (bio_data_dir(bio) == READ)
 			set_page_dirty_lock(bvec->bv_page);
 
 		page_cache_release(bvec->bv_page);
@@ -523,17 +637,15 @@ static void __bio_unmap_user(struct bio 
 /**
  *	bio_unmap_user	-	unmap a bio
  *	@bio:		the bio being unmapped
- *	@write_to_vm:	bool indicating whether pages were written to
  *
- *	Unmap a bio previously mapped by bio_map_user(). The @write_to_vm
- *	must be the same as passed into bio_map_user(). Must be called with
+ *	Unmap a bio previously mapped by bio_map_user(). Must be called with
  *	a process context.
  *
  *	bio_unmap_user() may sleep.
  */
-void bio_unmap_user(struct bio *bio, int write_to_vm)
+void bio_unmap_user(struct bio *bio)
 {
-	__bio_unmap_user(bio, write_to_vm);
+	__bio_unmap_user(bio);
 	bio_put(bio);
 }
 
@@ -864,3 +976,5 @@ EXPORT_SYMBOL(bio_unmap_user);
 EXPORT_SYMBOL(bio_pair_release);
 EXPORT_SYMBOL(bio_split);
 EXPORT_SYMBOL(bio_split_pool);
+EXPORT_SYMBOL(bio_copy_user);
+EXPORT_SYMBOL(bio_uncopy_user);
diff -urp -X /home/axboe/exclude /opt/kernel/linux-2.6.7-mm6/include/linux/bio.h linux-2.6.7-mm6/include/linux/bio.h
--- /opt/kernel/linux-2.6.7-mm6/include/linux/bio.h	2004-07-07 10:33:32.000000000 +0200
+++ linux-2.6.7-mm6/include/linux/bio.h	2004-07-07 10:47:20.000000000 +0200
@@ -121,6 +121,7 @@ struct bio {
 #define BIO_CLONED	4	/* doesn't own data */
 #define BIO_BOUNCED	5	/* bio is a bounce bio */
 #define BIO_EOPNOTSUPP	6	/* not supported */
+#define BIO_USER_MAPPED 7	/* contains user pages */
 #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
 
 /*
@@ -267,9 +268,11 @@ extern int bio_add_page(struct bio *, st
 extern int bio_get_nr_vecs(struct block_device *);
 extern struct bio *bio_map_user(struct request_queue *, struct block_device *,
 				unsigned long, unsigned int, int);
-extern void bio_unmap_user(struct bio *, int);
+extern void bio_unmap_user(struct bio *);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
+extern struct bio *bio_copy_user(struct request_queue *, unsigned long, unsigned int, int);
+extern int bio_uncopy_user(struct bio *);
 
 #ifdef CONFIG_HIGHMEM
 /*
diff -urp -X /home/axboe/exclude /opt/kernel/linux-2.6.7-mm6/include/linux/blkdev.h linux-2.6.7-mm6/include/linux/blkdev.h
--- /opt/kernel/linux-2.6.7-mm6/include/linux/blkdev.h	2004-07-07 10:33:32.000000000 +0200
+++ linux-2.6.7-mm6/include/linux/blkdev.h	2004-07-07 10:48:45.000000000 +0200
@@ -535,7 +535,7 @@ extern void __blk_stop_queue(request_que
 extern void blk_run_queue(request_queue_t *);
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
 extern struct request *blk_rq_map_user(request_queue_t *, int, void __user *, unsigned int);
-extern int blk_rq_unmap_user(struct request *, void __user *, struct bio *, unsigned int);
+extern int blk_rq_unmap_user(struct request *, struct bio *, unsigned int);
 extern int blk_execute_rq(request_queue_t *, struct gendisk *, struct request *);
 
 static inline request_queue_t *bdev_get_queue(struct block_device *bdev)

-- 
Jens Axboe

