Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbSIXRZW>; Tue, 24 Sep 2002 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSIXRXQ>; Tue, 24 Sep 2002 13:23:16 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:53148 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261719AbSIXRWl> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 06_xpram.
Date: Tue, 24 Sep 2002 19:19:08 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241919.08998.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove reference to xpram_release. Correct calls to bi_end_io and bio_io_error.

diff -urN linux-2.5.38/drivers/s390/block/xpram.c linux-2.5.38-s390/drivers/s390/block/xpram.c
--- linux-2.5.38/drivers/s390/block/xpram.c	Sun Sep 22 06:25:16 2002
+++ linux-2.5.38-s390/drivers/s390/block/xpram.c	Tue Sep 24 17:42:09 2002
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

