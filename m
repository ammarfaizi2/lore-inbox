Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbTFWBNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 21:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbTFWBNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 21:13:34 -0400
Received: from dm5-226.slc.aros.net ([66.219.220.226]:2005 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264792AbTFWBN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 21:13:29 -0400
Message-ID: <3EF65781.50708@aros.net>
Date: Sun, 22 Jun 2003 19:27:29 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@digeo.com>, torvalds@osdl.org
Subject: Re: [PATCH] nbd driver for 2.5+: fix for 2.5 block layer (improved)
References: <3EF6034C.1070204@aros.net> <20030622214412.GM6754@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030622214412.GM6754@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed;
 boundary="------------040502000202060202020707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040502000202060202020707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sun, Jun 22, 2003 at 01:28:12PM -0600, Lou Langholtz wrote:
>
>  
>
>>4. that the allocation of request_queue is dynamic and seperate from 
>>other allocated objects [Al]
>>    
>>
>
>*Ugh*.  Not on ->open(), please...  _If_ you really want that sort of
>on-demand allocation - make it happen via blk_register_region() and
>allocate both gendisk and queue at once.
>
>However, I would suggest to make that a separate patch and for now allocate
>queues at the same place where you allocate gendisks, without any on-demand
>stuff.
>  
>
Okay, here's the patch now updated to be without the on-demand stuff and 
with queues allocated all where alloc_disk is used. How is this patch now?

--------------040502000202060202020707
Content-Type: text/plain;
 name="nbd-patch1.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch1.3"

diff -urN linux-2.5.72/drivers/block/nbd.c linux-2.5.72-p1.5/drivers/block/nbd.c
--- linux-2.5.72/drivers/block/nbd.c	2003-06-16 22:19:44.000000000 -0600
+++ linux-2.5.72-p1.5/drivers/block/nbd.c	2003-06-22 19:13:08.199124846 -0600
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
@@ -168,6 +181,17 @@
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
@@ -209,7 +233,7 @@
 				if ((i < (bio->bi_vcnt - 1)) || bio->bi_next)
 					flags = MSG_MORE;
 				DEBUG("data, ");
-				result = nbd_xmit(1, sock, page_address(bvec->bv_page) + bvec->bv_offset, bvec->bv_len, flags);
+				result = sock_send_bvec(sock, bvec, flags);
 				if (result <= 0)
 					FAIL("Send data failed.");
 			}
@@ -244,6 +268,16 @@
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
@@ -251,10 +285,11 @@
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
@@ -268,14 +303,17 @@
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
@@ -538,8 +576,6 @@
  *  (Just smiley confuses emacs :-)
  */
 
-static struct request_queue nbd_queue;
-
 static int __init nbd_init(void)
 {
 	int err = -ENOMEM;
@@ -555,6 +591,17 @@
 		if (!disk)
 			goto out;
 		nbd_dev[i].disk = disk;
+		/*
+		 * The new linux 2.5 block layer implementation requires
+		 * every gendisk to have its very own request_queue struct.
+		 * These structs are big so we dynamically allocate them.
+		 */
+		disk->queue = kmalloc(sizeof(struct request_queue), GFP_KERNEL);
+		if (!disk->queue) {
+			put_disk(disk);
+			goto out;
+		}
+		blk_init_queue(disk->queue, do_nbd_request, &nbd_lock);
 	}
 
 	if (register_blkdev(NBD_MAJOR, "nbd")) {
@@ -564,7 +611,6 @@
 #ifdef MODULE
 	printk("nbd: registered device at major %d\n", NBD_MAJOR);
 #endif
-	blk_init_queue(&nbd_queue, do_nbd_request, &nbd_lock);
 	devfs_mk_dir("nbd");
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
@@ -582,7 +628,6 @@
 		disk->first_minor = i;
 		disk->fops = &nbd_fops;
 		disk->private_data = &nbd_dev[i];
-		disk->queue = &nbd_queue;
 		sprintf(disk->disk_name, "nbd%d", i);
 		sprintf(disk->devfs_name, "nbd/%d", i);
 		set_capacity(disk, 0x3ffffe);
@@ -591,8 +636,10 @@
 
 	return 0;
 out:
-	while (i--)
+	while (i--) {
+		kfree(nbd_dev[i].disk->queue);
 		put_disk(nbd_dev[i].disk);
+	}
 	return err;
 }
 
@@ -600,12 +647,22 @@
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
+	printk("nbd: unregistered device at major %d\n", NBD_MAJOR);
+#endif
 }
 
 module_init(nbd_init);

--------------040502000202060202020707--

