Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbRFTE6x>; Wed, 20 Jun 2001 00:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbRFTE6n>; Wed, 20 Jun 2001 00:58:43 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:49891 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264839AbRFTE6b>; Wed, 20 Jun 2001 00:58:31 -0400
Date: Tue, 19 Jun 2001 21:57:13 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: [PATCH] - Linux 2.4.5; devfs support for /dev/raw
To: andre@linux-ide.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Message-id: <200106200457.f5K4vDe01341@wellhouse.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have written this patch so that /dev/raw now appears in a devfs
filesystem. I haven't tried to support the /dev/rawN devices because
I'm not sure that it would be worthwhile. (Seeing as you need to bind
them by hand manually anyway.)

Cheers,
Chris

--- linux-2.4.5/drivers/char/raw.c.orig	Sat May 26 11:58:45 2001
+++ linux-2.4.5/drivers/char/raw.c	Sat Jun 16 20:54:10 2001
@@ -15,6 +15,7 @@
 #include <linux/raw.h>
 #include <linux/capability.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #define dprintk(x...) 
@@ -28,6 +29,7 @@
 } raw_device_data_t;
 
 static raw_device_data_t raw_devices[256];
+static const char RAW_DEVICE_NAME[] = "raw";
 
 static ssize_t rw_raw_dev(int rw, struct file *, char *, size_t, loff_t *);
 
@@ -53,7 +55,11 @@
 static int __init raw_init(void)
 {
 	int i;
-	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
+	devfs_register_chrdev(RAW_MAJOR, RAW_DEVICE_NAME, &raw_fops);
+	devfs_register(NULL, RAW_DEVICE_NAME, DEVFS_FL_DEFAULT,
+	               RAW_MAJOR, 0,
+	               S_IFCHR | S_IRUSR | S_IWUSR,
+	               &raw_fops, NULL);
 
 	for (i = 0; i < 256; i++)
 		init_MUTEX(&raw_devices[i].mutex);


--AA136AFB19.993012573/zappa.oak.suse.com--

