Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTGFT51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTGFT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 15:57:27 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:15622 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263354AbTGFT5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 15:57:24 -0400
Message-ID: <3F088277.3EB39CE2@SteelEye.com>
Date: Sun, 06 Jul 2003 16:11:35 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@digeo.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCHES 2.5.74-mm2] misc. nbd cleanups/fixes
Content-Type: multipart/mixed;
 boundary="------------F4E9F0EA00216578467DFE16"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F4E9F0EA00216578467DFE16
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew,

here are two nbd patches to apply to 2.5.74-mm2 after two of the
previous patches (from Lou Langholtz) are reverted:

nbd-ioctl-compat.patch  (patch 6)
nbd-locking-fixes.patch (patch 7)

I'm fine with leaving the first 5 patches of his in there.


The two attached patches are:

1) nbd-remove_open_release.diff - remove the unneeded nbd_open and
nbd_release functions

2) nbd-block_layer_compat.diff - ensure that nbd and the block layer
agree about device block sizes and total device sizes

and should be applied in this order.

Thanks,
Paul
--------------F4E9F0EA00216578467DFE16
Content-Type: text/x-diff; charset=us-ascii;
 name="nbd-remove_open_release.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-remove_open_release.diff"

--- linux-2.5.74-mm2/drivers/block/nbd.c.MINUS_LL	2003-07-06 11:31:51.000000000 -0400
+++ linux-2.5.74-mm2/drivers/block/nbd.c	2003-07-06 11:36:51.000000000 -0400
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
 

--------------F4E9F0EA00216578467DFE16
Content-Type: text/x-diff; charset=us-ascii;
 name="nbd-block_layer_compat.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-block_layer_compat.diff"

--- linux-2.5.74-mm2/drivers/block/nbd.c.MINUS_OPEN_RELEASE	2003-07-06 11:36:51.000000000 -0400
+++ linux-2.5.74-mm2/drivers/block/nbd.c	2003-07-06 11:43:54.000000000 -0400
@@ -591,15 +591,21 @@ static int nbd_ioctl(struct inode *inode
 		if ((arg & (arg-1)) || (arg < 512) || (arg > PAGE_SIZE))
 			return -EINVAL;
 		lo->blksize = arg;
-		lo->bytesize &= ~(lo->blksize-1); 
+		lo->bytesize &= ~(lo->blksize-1);
+		inode->i_bdev->bd_inode->i_size = lo->bytesize;
+		inode->i_bdev->bd_block_size = lo->blksize;
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_SET_SIZE:
-		lo->bytesize = arg & ~(lo->blksize-1); 
+		lo->bytesize = arg & ~(lo->blksize-1);
+		inode->i_bdev->bd_inode->i_size = lo->bytesize;
+		inode->i_bdev->bd_block_size = lo->blksize;
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
 		lo->bytesize = ((u64) arg) * lo->blksize;
+		inode->i_bdev->bd_inode->i_size = lo->bytesize;
+		inode->i_bdev->bd_block_size = lo->blksize;
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_DO_IT:

--------------F4E9F0EA00216578467DFE16--

