Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbTFVTOY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbTFVTOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:14:24 -0400
Received: from dm1-25.slc.aros.net ([66.219.220.25]:5316 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265728AbTFVTOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:14:18 -0400
Message-ID: <3EF6034C.1070204@aros.net>
Date: Sun, 22 Jun 2003 13:28:12 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
       torvalds@osdl.org
Subject: [PATCH] nbd driver for 2.5+: fix for 2.5 block layer (improved)
Content-Type: multipart/mixed;
 boundary="------------080104020500090506000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080104020500090506000408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Okay... this patch against the linux-2.5.72 nbd driver I think will be 
to a lot more peoples liking. This patch makes NBD work with the new 
linux 2.5 block layer design. Specifically, it fixes memory corruption 
that results from module removal and possible memory corruption from 
sending or receiving disk data from the server. This patch  essentially 
rolls together the changes from two of the last patchlets that I 
emailed: the fix for module removal & the fix for incorrect struct bio 
usage. I believe it's wisest to roll these both together into this one 
patch since they both deal with making NBD work better with the 2.5 
linux block layer design and without either of which, it's possible that 
NBD will corrupt memory. Other changes I'd like to see introduced (like 
in the earlier jumbo patch) meanwhile are feature enhancements so they 
can wait. This patch also should address all the very helpful concerns 
that have been raised so far. Particularly:

1. that the very first submitted NBD patch was broken down [Andrew]
2. that only 1 spinlock is used for all the NBD request_queue structures 
used [Jens,Al]
3. that kmap() is used in case of highmem pages [Jens]
4. that the allocation of request_queue is dynamic and seperate from 
other allocated objects [Al]

If no one has any problems with this patch, would someone be so kind as 
to put it into the next distribution?

--------------080104020500090506000408
Content-Type: text/plain;
 name="nbd-patch1.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch1.2"

diff -urN linux-2.5.72/drivers/block/nbd.c linux-2.5.72-p1.5/drivers/block/nbd.c
--- linux-2.5.72/drivers/block/nbd.c	2003-06-16 22:19:44.000000000 -0600
+++ linux-2.5.72-p1.5/drivers/block/nbd.c	2003-06-22 12:42:05.086640056 -0600
@@ -28,6 +28,9 @@
  *   the transmit lock. <steve@chygwyn.com>
  * 02-10-11 Allow hung xmit to be aborted via SIGKILL & various fixes.
  *   <Paul.Clements@SteelEye.com> <James.Bottomley@SteelEye.com>
+ * 03-06-22 Make nbd work with new linux 2.5 block layer design. This fixes
+ *   memory corruption from module removal and possible memory corruption
+ *   from sending/receiving disk data. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -63,6 +66,16 @@
 
 static struct nbd_device nbd_dev[MAX_NBD];
 
+/*
+ * Use just one lock (or at most 1 per NIC). Two arguments for this:
+ * 1. Each NIC is essentially a synchronization point for all servers
+ *    accessed through that NIC so there's no need to have more locks
+ *    than NICs anyway.
+ * 2. More locks lead to more "Dirty cache line bouncing" which will slow
+ *    down each lock to the point where they're actually slower than just
+ *    a single lock.
+ * Thanks go to Jens Axboe and Al Viro for their LKML emails explaining this!
+ */
 static spinlock_t nbd_lock = SPIN_LOCK_UNLOCKED;
 
 #define DEBUG( s )
@@ -88,13 +101,6 @@
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
-static int nbd_open(struct inode *inode, struct file *file)
-{
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	lo->refcnt++;
-	return 0;
-}
-
 /*
  *  Send or receive packet.
  */
@@ -168,6 +174,17 @@
 	return result;
 }
 
+static inline int sock_send_bvec(struct socket *sock, struct bio_vec *bvec,
+		int flags)
+{
+	int result;
+	void *kaddr = kmap(bvec->bv_page);
+	result = nbd_xmit(1, sock, kaddr + bvec->bv_offset, bvec->bv_len,
+			flags);
+	kunmap(bvec->bv_page);
+	return result;
+}
+
 #define FAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); goto error_out; }
 
 void nbd_send_req(struct nbd_device *lo, struct request *req)
@@ -209,7 +226,7 @@
 				if ((i < (bio->bi_vcnt - 1)) || bio->bi_next)
 					flags = MSG_MORE;
 				DEBUG("data, ");
-				result = nbd_xmit(1, sock, page_address(bvec->bv_page) + bvec->bv_offset, bvec->bv_len, flags);
+				result = sock_send_bvec(sock, bvec, flags);
 				if (result <= 0)
 					FAIL("Send data failed.");
 			}
@@ -244,6 +261,16 @@
 	return NULL;
 }
 
+static inline int sock_recv_bvec(struct socket *sock, struct bio_vec *bvec)
+{
+	int result;
+	void *kaddr = kmap(bvec->bv_page);
+	result = nbd_xmit(0, sock, kaddr + bvec->bv_offset, bvec->bv_len,
+			MSG_WAITALL);
+	kunmap(bvec->bv_page);
+	return result;
+}
+
 #define HARDFAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); lo->harderror = result; return NULL; }
 struct request *nbd_read_stat(struct nbd_device *lo)
 		/* NULL returned = something went wrong, inform userspace       */ 
@@ -251,10 +278,11 @@
 	int result;
 	struct nbd_reply reply;
 	struct request *req;
+	struct socket *sock = lo->sock;
 
 	DEBUG("reading control, ");
 	reply.magic = 0;
-	result = nbd_xmit(0, lo->sock, (char *) &reply, sizeof(reply), MSG_WAITALL);
+	result = nbd_xmit(0, sock, (char *) &reply, sizeof(reply), MSG_WAITALL);
 	if (result <= 0)
 		HARDFAIL("Recv control failed.");
 	req = nbd_find_request(lo, reply.handle);
@@ -268,14 +296,17 @@
 		FAIL("Other side returned error.");
 
 	if (nbd_cmd(req) == NBD_CMD_READ) {
-		struct bio *bio = req->bio;
+		int i;
+		struct bio *bio;
 		DEBUG("data, ");
-		do {
-			result = nbd_xmit(0, lo->sock, bio_data(bio), bio->bi_size, MSG_WAITALL);
-			if (result <= 0)
-				HARDFAIL("Recv data failed.");
-			bio = bio->bi_next;
-		} while(bio);
+		rq_for_each_bio(bio, req) {
+			struct bio_vec *bvec;
+			bio_for_each_segment(bvec, bio, i) {
+				result = sock_recv_bvec(sock, bvec);
+				if (result <= 0)
+					HARDFAIL("Recv data failed.");
+			}
+		}
 	}
 	DEBUG("done.\n");
 	return req;
@@ -515,12 +546,52 @@
 	return -EINVAL;
 }
 
+static int nbd_open(struct inode *inode, struct file *file)
+{
+	struct block_device *bdev = inode->i_bdev;
+	struct gendisk *disk = bdev->bd_disk;
+	struct nbd_device *lo = disk->private_data;
+
+	/*
+	 * linux 2.5 fs/block_dev.c ensures that while herein, this same
+	 * nbd_device can not be simultaneously opened by another thread.
+	 */
+	if (!disk->queue) {
+		struct request_queue *rq;
+
+		/*
+		 * The new linux 2.5 block layer implementation requires
+		 * every gendisk to have its very own request_queue struct.
+		 * These structs are big so we dynamically allocate them and
+		 * do so as late as possible (here)...
+		 */
+		rq = kmalloc(sizeof(struct request_queue), GFP_KERNEL);
+		if (!rq)
+			return -ENOMEM;
+		blk_init_queue(rq, do_nbd_request, &nbd_lock);
+		disk->queue = rq;
+	}
+	lo->refcnt++;
+	return 0;
+}
+
 static int nbd_release(struct inode *inode, struct file *file)
 {
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	if (lo->refcnt <= 0)
-		printk(KERN_ALERT "nbd_release: refcount(%d) <= 0\n", lo->refcnt);
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct nbd_device *lo = disk->private_data;
+
+	/*
+	 * linux 2.5 fs/block_dev.c ensures that while herein, this same
+	 * nbd_device can not be simultaneously released by another thread.
+	 */
 	lo->refcnt--;
+	if (lo->refcnt == 0) {
+		if (disk->queue) {
+			blk_cleanup_queue(disk->queue);
+			kfree(disk->queue);
+			disk->queue = NULL;
+		}
+	}
 	/* N.B. Doesn't lo->file need an fput?? */
 	return 0;
 }
@@ -538,8 +609,6 @@
  *  (Just smiley confuses emacs :-)
  */
 
-static struct request_queue nbd_queue;
-
 static int __init nbd_init(void)
 {
 	int err = -ENOMEM;
@@ -562,9 +631,8 @@
 		goto out;
 	}
 #ifdef MODULE
-	printk("nbd: registered device at major %d\n", NBD_MAJOR);
+	printk(KERN_NOTICE "nbd: registered device at major %d\n", NBD_MAJOR);
 #endif
-	blk_init_queue(&nbd_queue, do_nbd_request, &nbd_lock);
 	devfs_mk_dir("nbd");
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
@@ -582,7 +650,7 @@
 		disk->first_minor = i;
 		disk->fops = &nbd_fops;
 		disk->private_data = &nbd_dev[i];
-		disk->queue = &nbd_queue;
+		disk->queue = NULL;
 		sprintf(disk->disk_name, "nbd%d", i);
 		sprintf(disk->devfs_name, "nbd/%d", i);
 		set_capacity(disk, 0x3ffffe);
@@ -600,12 +668,22 @@
 {
 	int i;
 	for (i = 0; i < MAX_NBD; i++) {
-		del_gendisk(nbd_dev[i].disk);
-		put_disk(nbd_dev[i].disk);
+		struct gendisk *disk = nbd_dev[i].disk;
+		if (disk) {
+			if (disk->queue) {
+				blk_cleanup_queue(disk->queue);
+				kfree(disk->queue);
+				disk->queue = NULL;
+			}
+			del_gendisk(disk);
+			put_disk(disk);
+		}
 	}
 	devfs_remove("nbd");
-	blk_cleanup_queue(&nbd_queue);
 	unregister_blkdev(NBD_MAJOR, "nbd");
+#ifdef MODULE
+	printk(KERN_NOTICE "nbd: unregistered device at major %d\n", NBD_MAJOR);
+#endif
 }
 
 module_init(nbd_init);

--------------080104020500090506000408--

