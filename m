Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbTFUVfL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 17:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTFUVfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 17:35:11 -0400
Received: from dm4-159.slc.aros.net ([66.219.220.159]:12422 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265361AbTFUVfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 17:35:00 -0400
Message-ID: <3EF4D2C8.6060608@aros.net>
Date: Sat, 21 Jun 2003 15:48:56 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Pavel Machek <pavel@ucw.cz>, Steven Whitehouse <steve@chygwyn.com>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] nbd driver for 2.5+: fix for module removal & new block device
 layer
Content-Type: multipart/mixed;
 boundary="------------010005070109090808010302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010005070109090808010302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch prevents memory corruption from "rmmod nbd" with the existing 
2.5.72 (and earlier) nbd driver. It does this by updating the nbd driver 
to the new block layer requirement that every disk has its own 
request_queue structure. This is the first of a series of patchlets 
designed to break down the essential changes I proposed in my last 
"enormous" patch. Note that another patchlet will make the whole 
allocation of per nbd_device memory be dynamic (rather than staticly 
tied to MAX_NBD). Please try out this patch and let me know how nbd is 
working for you before versus after. With any luck, some of these 
smaller patch breakdowns can actually see there way into new kernel 
releases. Thanks.

--------------010005070109090808010302
Content-Type: text/plain;
 name="nbd-patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch1"

diff -urN linux-2.5.72/drivers/block/nbd.c linux-2.5.72-patched/drivers/block/nbd.c
--- linux-2.5.72/drivers/block/nbd.c	2003-06-16 22:19:44.000000000 -0600
+++ linux-2.5.72-patched/drivers/block/nbd.c	2003-06-21 15:30:17.860967573 -0600
@@ -28,6 +28,7 @@
  *   the transmit lock. <steve@chygwyn.com>
  * 02-10-11 Allow hung xmit to be aborted via SIGKILL & various fixes.
  *   <Paul.Clements@SteelEye.com> <James.Bottomley@SteelEye.com>
+ * 03-06-21 Fix memory corruption from module removal. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -63,7 +64,18 @@
 
 static struct nbd_device nbd_dev[MAX_NBD];
 
-static spinlock_t nbd_lock = SPIN_LOCK_UNLOCKED;
+/*
+ * Have these per nbd_device as is now required by the new block layer.
+ * This also helps prevent I/O bottle necks between multiple nbd_devices
+ * resulting in better overall response times!
+ *
+ * ldl: Keep these out from nbd_device for now till the whole 2.5 blockdev
+ *   reworking shakes out. Who knows... maybe struct request_queue's
+ *   queue_lock field will someday actually be the spinlock instead of just
+ *   being a pointer to it!
+ */
+static struct request_queue nbd_queue[MAX_NBD];
+static spinlock_t nbd_lock[MAX_NBD];
 
 #define DEBUG( s )
 /* #define DEBUG( s ) printk( s ) 
@@ -538,8 +550,6 @@
  *  (Just smiley confuses emacs :-)
  */
 
-static struct request_queue nbd_queue;
-
 static int __init nbd_init(void)
 {
 	int err = -ENOMEM;
@@ -551,6 +561,11 @@
 	}
 
 	for (i = 0; i < MAX_NBD; i++) {
+		nbd_lock[i] = SPIN_LOCK_UNLOCKED;
+		blk_init_queue(&nbd_queue[i], do_nbd_request, &nbd_lock[i]);
+	}
+
+	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = alloc_disk(1);
 		if (!disk)
 			goto out;
@@ -564,7 +579,6 @@
 #ifdef MODULE
 	printk("nbd: registered device at major %d\n", NBD_MAJOR);
 #endif
-	blk_init_queue(&nbd_queue, do_nbd_request, &nbd_lock);
 	devfs_mk_dir("nbd");
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
@@ -582,7 +596,7 @@
 		disk->first_minor = i;
 		disk->fops = &nbd_fops;
 		disk->private_data = &nbd_dev[i];
-		disk->queue = &nbd_queue;
+		disk->queue = &nbd_queue[i];
 		sprintf(disk->disk_name, "nbd%d", i);
 		sprintf(disk->devfs_name, "nbd/%d", i);
 		set_capacity(disk, 0x3ffffe);
@@ -602,9 +616,9 @@
 	for (i = 0; i < MAX_NBD; i++) {
 		del_gendisk(nbd_dev[i].disk);
 		put_disk(nbd_dev[i].disk);
+		blk_cleanup_queue(&nbd_queue[i]);
 	}
 	devfs_remove("nbd");
-	blk_cleanup_queue(&nbd_queue);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
 

--------------010005070109090808010302--

