Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTFXOFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 10:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTFXOFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 10:05:47 -0400
Received: from dm2-57.slc.aros.net ([66.219.220.57]:12417 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S262115AbTFXOFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 10:05:44 -0400
Message-ID: <3EF85E04.1090109@aros.net>
Date: Tue, 24 Jun 2003 08:19:48 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] nbd driver for 2.5+: simply remove unneeded blksize_bits
 field
Content-Type: multipart/mixed;
 boundary="------------050305000305070104000000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050305000305070104000000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This fourth patch simply removes the blksize_bits field from the 
nbd_device struct and driver implementation. How this field made it into 
this driver to begin with is a mystery (where was Al Viro when that 
patch was submitted??). :-) This patch modifies both drivers/block/nbd.c 
and include/linux/nbd.h files. It's intended to be applied incrementally 
on top of my third patch (for enhanced diagnostics support). I suspect 
this patch is small enough however that it may apply correctly without 
the preceding patches but I have not tried it myself.

There are other things that can be cleaned up this way but this change 
was so very simple I wanted to get it out of the way early on. As 
always, comments welcome.

--------------050305000305070104000000
Content-Type: text/plain;
 name="nbd-patch4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch4"

diff -urN linux-2.5.73-p3.1/drivers/block/nbd.c linux-2.5.73-p4/drivers/block/nbd.c
--- linux-2.5.73-p3.1/drivers/block/nbd.c	2003-06-23 22:00:44.000000000 -0600
+++ linux-2.5.73-p4/drivers/block/nbd.c	2003-06-24 07:48:31.000000000 -0600
@@ -33,6 +33,8 @@
  *   from sending/receiving disk data. <ldl@aros.net>
  * 03-06-23 Cosmetic changes. <ldl@aros.net>
  * 03-06-23 Enhance diagnostics support. <ldl@aros.net>
+ * 03-06-24 Remove unneeded blksize_bits field from nbd_device struct.
+ *   <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -535,7 +537,7 @@
 		     unsigned int cmd, unsigned long arg)
 {
 	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	int error, temp;
+	int error;
 	struct request sreq ;
 
 	/* Anyone capable of this syscall can do *real bad* things */
@@ -600,12 +602,6 @@
 		if ((arg & (arg-1)) || (arg < 512) || (arg > PAGE_SIZE))
 			return -EINVAL;
 		lo->blksize = arg;
-		temp = arg >> 9;
-		lo->blksize_bits = 9;
-		while (temp > 1) {
-			lo->blksize_bits++;
-			temp >>= 1;
-		}
 		lo->bytesize &= ~(lo->blksize-1); 
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
@@ -614,7 +610,7 @@
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
-		lo->bytesize = ((u64) arg) << lo->blksize_bits;
+		lo->bytesize = ((u64) arg) * lo->blksize;
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_DO_IT:
@@ -717,7 +713,6 @@
 		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
 		init_MUTEX(&nbd_dev[i].tx_lock);
 		nbd_dev[i].blksize = 1024;
-		nbd_dev[i].blksize_bits = 10;
 		nbd_dev[i].bytesize = ((u64)0x7ffffc00) << 10; /* 2TB */
 		disk->major = NBD_MAJOR;
 		disk->first_minor = i;
diff -urN linux-2.5.73-p3.1/include/linux/nbd.h linux-2.5.73-p4/include/linux/nbd.h
--- linux-2.5.73-p3.1/include/linux/nbd.h	2003-06-22 10:51:33.000000000 -0600
+++ linux-2.5.73-p4/include/linux/nbd.h	2003-06-24 08:00:41.438099149 -0600
@@ -5,6 +5,8 @@
  * 2001 Copyright (C) Steven Whitehouse
  *            New nbd_end_request() for compatibility with new linux block
  *            layer code.
+ * 2003/06/24 Louis D. Langholtz <ldl@aros.net>
+ *            Removed unneeded blksize_bits field from nbd_device struct.
  */
 
 #ifndef LINUX_NBD_H
@@ -50,7 +52,6 @@
 	struct semaphore tx_lock;
 	struct gendisk *disk;
 	int blksize;
-	int blksize_bits;
 	u64 bytesize;
 };
 

--------------050305000305070104000000--

