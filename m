Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbSI3OIK>; Mon, 30 Sep 2002 10:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262090AbSI3NoG>; Mon, 30 Sep 2002 09:44:06 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:37070 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262068AbSI3Nnl> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:43:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (8/26): xpram driver.
Date: Mon, 30 Sep 2002 14:53:44 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301453.44582.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove reference to xpram_release. Correct calls to bi_end_io and bio_io_error.

diff -urN linux-2.5.39/drivers/s390/block/xpram.c linux-2.5.39-s390/drivers/s390/block/xpram.c
--- linux-2.5.39/drivers/s390/block/xpram.c	Fri Sep 27 23:50:26 2002
+++ linux-2.5.39-s390/drivers/s390/block/xpram.c	Mon Sep 30 13:31:58 2002
@@ -15,7 +15,6 @@
  *   Device specific file operations
  *        xpram_iotcl
  *        xpram_open
- *        xpram_release
  *
  * "ad-hoc" partitioning:
  *    the expanded memory can be partitioned among several devices 
@@ -36,6 +35,7 @@
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/device.h>
+#include <linux/bio.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
@@ -60,7 +60,7 @@
 static xpram_device_t xpram_devices[XPRAM_MAX_DEVS];
 static int xpram_sizes[XPRAM_MAX_DEVS];
 static struct gendisk xpram_disks[XPRAM_MAX_DEVS];
-static char xpram_names[XPRAM_MAX_DEV][8];
+static char xpram_names[XPRAM_MAX_DEVS][8];
 static unsigned long xpram_pages;
 static int xpram_devs;
 static devfs_handle_t xpram_devfs_handle;
@@ -313,10 +313,12 @@
 		}
 	}
 	set_bit(BIO_UPTODATE, &bio->bi_flags);
-	bio->bi_end_io(bio);
+	bytes = bio->bi_size;
+	bio->bi_size = 0;
+	bio->bi_end_io(bio, bytes, 0);
 	return 0;
 fail:
-	bio_io_error(bio);
+	bio_io_error(bio, bio->bi_size);
 	return 0;
 }
 
@@ -330,7 +332,6 @@
 	return 0;
 }
 
-
 static int xpram_ioctl (struct inode *inode, struct file *filp,
 		 unsigned int cmd, unsigned long arg)
 {
@@ -339,7 +340,7 @@
 	int idx = minor(inode->i_rdev);
 	if (idx >= xpram_devs)
 		return -ENODEV;
-	if (cmd != HDIO_GETGEO)
+ 	if (cmd != HDIO_GETGEO)
 		return -EINVAL;
 	/*
 	 * get geometry: we have to fake one...  trim the size to a
@@ -356,14 +357,12 @@
 	put_user(4, &geo->start);
 	return 0;
 }
-}
 
 static struct block_device_operations xpram_devops =
 {
 	owner:   THIS_MODULE,
 	ioctl:   xpram_ioctl,
 	open:    xpram_open,
-	release: xpram_release,
 };
 
 /*

