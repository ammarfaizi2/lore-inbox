Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTFYDvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 23:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTFYDvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 23:51:13 -0400
Received: from dm5-202.slc.aros.net ([66.219.220.202]:26254 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264487AbTFYDvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 23:51:01 -0400
Message-ID: <3EF91F73.5080109@aros.net>
Date: Tue, 24 Jun 2003 22:05:07 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [PATCH] nbd driver for 2.5+: cleanup PARANOIA usage & code
Content-Type: multipart/mixed;
 boundary="------------070109080403060408000709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070109080403060408000709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This fifth patch cleans up usage of the PARANOIA sanity checking macro 
and code. This patch modifies both drivers/block/nbd.c and 
include/linux/nbd.h. It's intended to be applied incrementally on top of 
my fourth patch (4.1 really if you count the memset addition as .1's 
worth) that simply removed unneeded blksize_bits field. Again, I wanted 
to get this smaller change out of the way before my next patch will is 
much more major. Comments welcome.

--------------070109080403060408000709
Content-Type: text/plain;
 name="nbd-patch5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch5"

diff -urN linux-2.5.73-p4.1/drivers/block/nbd.c linux-2.5.73-p5/drivers/block/nbd.c
--- linux-2.5.73-p4.1/drivers/block/nbd.c	2003-06-24 15:33:30.000000000 -0600
+++ linux-2.5.73-p5/drivers/block/nbd.c	2003-06-24 21:44:14.114372240 -0600
@@ -35,13 +35,13 @@
  * 03-06-23 Enhance diagnostics support. <ldl@aros.net>
  * 03-06-24 Remove unneeded blksize_bits field from nbd_device struct.
  *   <ldl@aros.net>
+ * 03-06-24 Cleanup PARANOIA usage & code. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
  *          structure with userland
  */
 
-#define PARANOIA
 #include <linux/major.h>
 
 #include <linux/blk.h>
@@ -64,9 +64,12 @@
 #include <asm/uaccess.h>
 #include <asm/types.h>
 
+/* Define PARANOIA in linux/nbd.h to turn on extra sanity checking */
 #include <linux/nbd.h>
 
+#ifdef PARANOIA
 #define LO_MAGIC 0x68797548
+#endif
 
 #ifdef NDEBUG
 #define dprintk(flags, fmt...)
@@ -99,8 +102,10 @@
  */
 static spinlock_t nbd_lock = SPIN_LOCK_UNLOCKED;
 
+#ifdef PARANOIA
 static int requests_in;
 static int requests_out;
+#endif
 
 #ifndef NDEBUG
 static const char *ioctl_cmd_to_ascii(int cmd)
@@ -397,7 +402,9 @@
 {
 	struct request *req;
 
+#ifdef PARANOIA
 	BUG_ON(lo->magic != LO_MAGIC);
+#endif
 	while ((req = nbd_read_stat(lo)) != NULL)
 		nbd_end_request(req);
 	printk(KERN_NOTICE "%s: req should never be null\n",
@@ -409,7 +416,9 @@
 {
 	struct request *req;
 
+#ifdef PARANOIA
 	BUG_ON(lo->magic != LO_MAGIC);
+#endif
 
 	do {
 		req = NULL;
@@ -448,7 +457,9 @@
 			goto error_out;
 
 		lo = req->rq_disk->private_data;
+#ifdef PARANOIA
 		BUG_ON(lo->magic != LO_MAGIC);
+#endif
 		if (!lo->file) {
 			printk(KERN_ERR "%s: Request when not-ready\n",
 					lo->disk->disk_name);
@@ -463,7 +474,9 @@
 				goto error_out;
 			}
 		}
+#ifdef PARANOIA
 		requests_in++;
+#endif
 
 		req->errors = 0;
 		spin_unlock_irq(q->queue_lock);
@@ -522,11 +535,13 @@
 {
 	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
 
+#ifdef PARANOIA
 	if (lo->refcnt <= 0) {
 		printk(KERN_ALERT "%s: nbd_release: refcount(%d) <= 0\n",
 				lo->disk->disk_name, lo->refcnt);
 		BUG();
 	}
+#endif
 	lo->refcnt--;
 	dprintk(DBG_RELEASE, "%s: nbd_release: refcnt=%d\n",
 			lo->disk->disk_name, lo->refcnt);
@@ -540,6 +555,9 @@
 	int error;
 	struct request sreq ;
 
+#ifdef PARANOIA
+	BUG_ON(lo->magic != LO_MAGIC);
+#endif
 	/* Anyone capable of this syscall can do *real bad* things */
 	dprintk(DBG_IOCTL, "%s: nbd_ioctl cmd=%s(0x%x) arg=%lu\n",
 			lo->disk->disk_name, ioctl_cmd_to_ascii(cmd), cmd, arg);
@@ -642,13 +660,17 @@
 	case NBD_CLEAR_QUE:
 		nbd_clear_que(lo);
 		return 0;
-#ifdef PARANOIA
 	case NBD_PRINT_DEBUG:
+#ifdef PARANOIA
 		printk(KERN_INFO "%s: next = %p, prev = %p. Global: in %d, out %d\n",
-		       inode->i_bdev->bd_disk->disk_name, lo->queue_head.next,
-		       lo->queue_head.prev, requests_in, requests_out);
-		return 0;
+			inode->i_bdev->bd_disk->disk_name, lo->queue_head.next,
+			lo->queue_head.prev, requests_in, requests_out);
+#else
+		printk(KERN_INFO "%s: next = %p, prev = %p\n",
+			inode->i_bdev->bd_disk->disk_name,
+			lo->queue_head.next, lo->queue_head.prev);
 #endif
+		return 0;
 	}
 	return -EINVAL;
 }
@@ -671,10 +693,12 @@
 	int err = -ENOMEM;
 	int i;
 
+#ifdef PARANOIA
 	if (sizeof(struct nbd_request) != 28) {
 		printk(KERN_CRIT "nbd: Sizeof nbd_request needs to be 28 in order to work!\n" );
 		return -EIO;
 	}
+#endif
 
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = alloc_disk(1);
@@ -708,7 +732,9 @@
 		struct gendisk *disk = nbd_dev[i].disk;
 		nbd_dev[i].refcnt = 0;
 		nbd_dev[i].file = NULL;
+#ifdef PARANOIA
 		nbd_dev[i].magic = LO_MAGIC;
+#endif
 		nbd_dev[i].flags = 0;
 		spin_lock_init(&nbd_dev[i].queue_lock);
 		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
diff -urN linux-2.5.73-p4.1/include/linux/nbd.h linux-2.5.73-p5/include/linux/nbd.h
--- linux-2.5.73-p4.1/include/linux/nbd.h	2003-06-24 08:00:41.000000000 -0600
+++ linux-2.5.73-p5/include/linux/nbd.h	2003-06-24 21:48:44.697043654 -0600
@@ -7,6 +7,7 @@
  *            layer code.
  * 2003/06/24 Louis D. Langholtz <ldl@aros.net>
  *            Removed unneeded blksize_bits field from nbd_device struct.
+ *            Cleanup PARANOIA usage & code.
  */
 
 #ifndef LINUX_NBD_H
@@ -28,16 +29,12 @@
 	NBD_CMD_DISC = 2
 };
 
-
-#ifdef PARANOIA
-extern int requests_in;
-extern int requests_out;
-#endif
-
 #define nbd_cmd(req) ((req)->cmd[0])
-
 #define MAX_NBD 128
 
+/* Define PARANOIA to include extra sanity checking code in here & driver */
+#define PARANOIA
+
 struct nbd_device {
 	int refcnt;	
 	int flags;
@@ -46,7 +43,9 @@
 #define NBD_WRITE_NOCHK 0x0002
 	struct socket * sock;
 	struct file * file; 	/* If == NULL, device is not ready, yet	*/
+#ifdef PARANOIA
 	int magic;		/* FIXME: not if debugging is off	*/
+#endif
 	spinlock_t queue_lock;
 	struct list_head queue_head;/* Requests are added here...	*/
 	struct semaphore tx_lock;

--------------070109080403060408000709--

