Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTGFVBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTGFVB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:01:28 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:61702 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263542AbTGFVBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:01:23 -0400
Message-ID: <3F089177.1A58BFE0@SteelEye.com>
Date: Sun, 06 Jul 2003 17:15:35 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@digeo.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.74-mm2] nbd: remove unneeded nbd_open/nbd_release and refcnt
Content-Type: multipart/mixed;
 boundary="------------3B0B0BC7CC042737DF408536"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3B0B0BC7CC042737DF408536
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew,

per Jeff's comments, here's the revised patch for removing
nbd_open/release

--
Paul
--------------3B0B0BC7CC042737DF408536
Content-Type: text/x-diff; charset=us-ascii;
 name="nbd-remove_open_release-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-remove_open_release-2.diff"

--- linux-2.5.74-mm2/drivers/block/nbd.c.MINUS_LL	2003-07-06 11:31:51.000000000 -0400
+++ linux-2.5.74-mm2/drivers/block/nbd.c	2003-07-06 16:55:22.224389840 -0400
@@ -77,8 +77,6 @@
 #define dprintk(flags, fmt...) do { \
 	if (debugflags & (flags)) printk(KERN_DEBUG fmt); \
 } while (0)
-#define DBG_OPEN        0x0001
-#define DBG_RELEASE     0x0002
 #define DBG_IOCTL       0x0004
 #define DBG_INIT        0x0010
 #define DBG_EXIT        0x0020
@@ -521,33 +519,6 @@ static void do_nbd_request(request_queue
 	return;
 }
 
-static int nbd_open(struct inode *inode, struct file *file)
-{
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-
-	dprintk(DBG_OPEN, "%s: nbd_open refcnt=%d\n", lo->disk->disk_name,
-			lo->refcnt);
-	lo->refcnt++;
-	return 0;
-}
-
-static int nbd_release(struct inode *inode, struct file *file)
-{
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-
-#ifdef PARANOIA
-	if (lo->refcnt <= 0) {
-		printk(KERN_ALERT "%s: nbd_release: refcount(%d) <= 0\n",
-				lo->disk->disk_name, lo->refcnt);
-		BUG();
-	}
-#endif
-	lo->refcnt--;
-	dprintk(DBG_RELEASE, "%s: nbd_release: refcnt=%d\n",
-			lo->disk->disk_name, lo->refcnt);
-	return 0;
-}
-
 static int nbd_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
@@ -555,6 +526,8 @@ static int nbd_ioctl(struct inode *inode
 	int error;
 	struct request sreq ;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
 #ifdef PARANOIA
 	BUG_ON(lo->magic != LO_MAGIC);
 #endif
@@ -562,8 +535,6 @@ static int nbd_ioctl(struct inode *inode
 	dprintk(DBG_IOCTL, "%s: nbd_ioctl cmd=%s(0x%x) arg=%lu\n",
 			lo->disk->disk_name, ioctl_cmd_to_ascii(cmd), cmd, arg);
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	switch (cmd) {
 	case NBD_DISCONNECT:
 	        printk(KERN_INFO "%s: NBD_DISCONNECT\n", lo->disk->disk_name);
@@ -678,8 +649,6 @@ static int nbd_ioctl(struct inode *inode
 static struct block_device_operations nbd_fops =
 {
 	.owner =	THIS_MODULE,
-	.open =		nbd_open,
-	.release =	nbd_release,
 	.ioctl =	nbd_ioctl,
 };
 
@@ -730,7 +699,6 @@ static int __init nbd_init(void)
 	devfs_mk_dir("nbd");
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
-		nbd_dev[i].refcnt = 0;
 		nbd_dev[i].file = NULL;
 #ifdef PARANOIA
 		nbd_dev[i].magic = LO_MAGIC;
--- linux-2.5.74-mm2/include/linux/nbd.h.PRISTINE	2003-07-06 16:49:36.710915872 -0400
+++ linux-2.5.74-mm2/include/linux/nbd.h	2003-07-06 16:49:52.826465936 -0400
@@ -36,7 +36,6 @@
 #define PARANOIA
 
 struct nbd_device {
-	int refcnt;	
 	int flags;
 	int harderror;		/* Code of hard error			*/
 #define NBD_READ_ONLY 0x0001

--------------3B0B0BC7CC042737DF408536--

