Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSJDPSA>; Fri, 4 Oct 2002 11:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbSJDOj7>; Fri, 4 Oct 2002 10:39:59 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:25778 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261847AbSJDOhZ> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:37:25 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (8/27): xpram driver.
Date: Fri, 4 Oct 2002 16:39:22 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041627.32150.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove reference to xpram_release. Correct calls to bi_end_io and bio_io_error.

diff -urN linux-2.5.40/drivers/s390/block/xpram.c linux-2.5.40-s390/drivers/s390/block/xpram.c
--- linux-2.5.40/drivers/s390/block/xpram.c	Tue Oct  1 09:07:34 2002
+++ linux-2.5.40-s390/drivers/s390/block/xpram.c	Fri Oct  4 16:15:15 2002
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
@@ -47,10 +47,13 @@
 #define PRINT_WARN(x...)	printk(KERN_WARNING XPRAM_NAME " warning:" x)
 #define PRINT_ERR(x...)		printk(KERN_ERR XPRAM_NAME " error:" x)
 
-static struct device xpram_sys_device = {
-	name: "S/390 expanded memory RAM disk",
-	bus_id: "xpram",
-};
+static struct sys_device xpram_sys_device = {
+	.name = "S/390 expanded memory RAM disk",
+	.dev  = {
+		.name   = "S/390 expanded memory RAM disk",
+		.bus_id = "xpram",
+	},
+}; 
 
 typedef struct {
 	unsigned long	size;		/* size of xpram segment in pages */
@@ -312,10 +315,12 @@
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
 
@@ -329,7 +334,6 @@
 	return 0;
 }
 
-
 static int xpram_ioctl (struct inode *inode, struct file *filp,
 		 unsigned int cmd, unsigned long arg)
 {
@@ -338,7 +342,7 @@
 	int idx = minor(inode->i_rdev);
 	if (idx >= xpram_devs)
 		return -ENODEV;
-	if (cmd != HDIO_GETGEO)
+ 	if (cmd != HDIO_GETGEO)
 		return -EINVAL;
 	/*
 	 * get geometry: we have to fake one...  trim the size to a
@@ -355,14 +359,12 @@
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
@@ -492,7 +494,7 @@
 		del_gendisk(xpram_disks + i);
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	devfs_unregister(xpram_devfs_handle);
-	unregister_sys_device(&xpram_sys_device);
+	sys_device_unregister(&xpram_sys_device);
 }
 
 static int __init xpram_init(void)
@@ -510,12 +512,12 @@
 	rc = xpram_setup_sizes(xpram_pages);
 	if (rc)
 		return rc;
-	rc = register_sys_device(&xpram_sys_device);
+	rc = sys_device_register(&xpram_sys_device);
 	if (rc)
 		return rc;
 	rc = xpram_setup_blkdev();
 	if (rc)
-		unregister_sys_device(&xpram_sys_device);
+		sys_device_unregister(&xpram_sys_device);
 	return rc;
 }
 

