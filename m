Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRJNEbD>; Sun, 14 Oct 2001 00:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274194AbRJNEax>; Sun, 14 Oct 2001 00:30:53 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:44517 "EHLO pltn13.pbi.net")
	by vger.kernel.org with ESMTP id <S274064AbRJNEat>;
	Sun, 14 Oct 2001 00:30:49 -0400
Date: Sat, 13 Oct 2001 21:31:20 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: Re: xine pauses with recent (not -ac) kernels
To: linux-kernel@vger.kernel.org
Message-id: <200110140431.f9E4VKpp000976@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL6]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is interesting, because I am using 2.4.12 SMP with > 1 GB RAM,
devfs, and I am also seeing large unnatural pauses with xine. However,
only with one particular DVD ("BlackAdder : Back and Forth"). I tried
the suggested fix of:

sleep 100000 < /dev/cdroms/rdvd&

and it *did* work. The slider control started working again as well.

I have no idea why it affects this one particular DVD and not others;
I had thought that it was a xine bug.

BTW, I have patched my kernel to at least create the /dev/rawctl
device and /dev/raw directory when using devfs. It's better than
nothing.

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
