Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273189AbRIJEEy>; Mon, 10 Sep 2001 00:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273190AbRIJEEo>; Mon, 10 Sep 2001 00:04:44 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:53947 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S273189AbRIJEE0>;
	Mon, 10 Sep 2001 00:04:26 -0400
Date: Sun, 09 Sep 2001 21:04:41 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: PATCH: Basic devfs support for raw IO
To: linux-kernel@vger.kernel.org, andre@linux-ide.org
Message-id: <200109100404.f8A44fi00670@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have written a small patch to create a /dev/rawctl device node and a
/dev/raw directory using devfs. Any feedback would be welcome - it
certainly seems to work on my box.

Cheers,
Chris

--- drivers/char/raw.c.orig	Wed Jun 27 17:10:55 2001
+++ drivers/char/raw.c	Sat Sep  1 14:54:43 2001
@@ -15,6 +15,7 @@
 #include <linux/raw.h>
 #include <linux/capability.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #define dprintk(x...) 
@@ -53,7 +54,24 @@
 static int __init raw_init(void)
 {
 	int i;
-	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
+
+	if (devfs_register_chrdev(RAW_MAJOR, "raw", &raw_fops) != 0) {
+		printk(KERN_ERR "Unable to get major device %d for raw block devices",
+		                RAW_MAJOR);
+	} else {
+		/*
+		 * Make a directory for raw devices to go in ...
+		 */
+		devfs_mk_dir(NULL, "raw", NULL);
+
+		/*
+		 * Make the "control" device node for raw devices ...
+		 */
+		devfs_register(NULL, "rawctl", DEVFS_FL_DEFAULT,
+		               RAW_MAJOR, 0,
+		               S_IFCHR | S_IRUSR | S_IWUSR,
+		               &raw_fops, NULL);
+	}
 
 	for (i = 0; i < 256; i++)
 		init_MUTEX(&raw_devices[i].mutex);
