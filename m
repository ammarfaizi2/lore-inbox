Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbRFQEWR>; Sun, 17 Jun 2001 00:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbRFQEWH>; Sun, 17 Jun 2001 00:22:07 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:1012 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264688AbRFQEV7>; Sun, 17 Jun 2001 00:21:59 -0400
Date: Sat, 16 Jun 2001 21:21:51 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: [PATCH] Partial devfs support for raw IO devices
To: linux-kernel@vger.kernel.org
Message-id: <200106170421.f5H4Lp100459@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I hacked together this quick patch to make the "master" raw IO device
appear in devfs. It seems odd that I need *both* devfs_register...()
calls but the first one only seems to make the entry appear in
/proc/devices.

The logical corollary to this patch is to make raw IO devices
magically appear in devfs as they are bound to block devices. However,
this presents namespacing issues. Would it be reasonable to assume
that they should appear in a subdirectory called /dev/rawIO, e.g.

/dev/rawIO/1
/dev/rawIO/2  ... etc?

devfsd could then provide compatibility links.

Anyway, first things first :-)
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
