Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTE2OOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTE2OOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:14:05 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:12334 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262259AbTE2OOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:14:04 -0400
Subject: [PATCH] 2.5.70 tty_register_driver
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>
In-Reply-To: <1054150058.2025.18.camel@diemos>
References: <1054138158.2107.4.camel@diemos>
	 <1054150058.2025.18.camel@diemos>
Content-Type: text/plain
Organization: 
Message-Id: <1054218448.2099.5.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 May 2003 09:27:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects changes made in 2.5.70 to
tty_register_device() which caused the device
minor base specified by tty drivers using dynamically
allocated device major number to be ignored.

I have posted to lkml and to the originator of the
2.5.70 patch, and have received no dissenting views.

Please apply.

--- linux-2.5.70/drivers/char/tty_io.c	2003-05-29 09:14:30.000000000 -0500
+++ linux-2.5.70-mg/drivers/char/tty_io.c	2003-05-29 08:24:41.000000000 -0500
@@ -2255,7 +2255,7 @@
 		return 0;
 
 	if (!driver->major) {
-		error = alloc_chrdev_region(&dev, driver->num,
+		error = alloc_chrdev_region(&dev, driver->minor_start, driver->num,
 						(char*)driver->name);
 		if (!error) {
 			driver->major = MAJOR(dev);
--- linux-2.5.70/include/linux/fs.h	2003-05-29 09:14:01.000000000 -0500
+++ linux-2.5.70-mg/include/linux/fs.h	2003-05-29 08:23:46.000000000 -0500
@@ -1059,7 +1059,7 @@
 extern void blk_run_queues(void);
 
 /* fs/char_dev.c */
-extern int alloc_chrdev_region(dev_t *, unsigned, char *);
+extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, char *);
 extern int register_chrdev_region(dev_t, unsigned, char *);
 extern int register_chrdev(unsigned int, const char *,
 			   struct file_operations *);
--- linux-2.5.70/fs/char_dev.c	2003-05-29 09:14:18.000000000 -0500
+++ linux-2.5.70-mg/fs/char_dev.c	2003-05-29 08:24:25.000000000 -0500
@@ -177,10 +177,10 @@
 	return PTR_ERR(cd);
 }
 
-int alloc_chrdev_region(dev_t *dev, unsigned count, char *name)
+int alloc_chrdev_region(dev_t *dev, unsigned baseminor, unsigned count, char *name)
 {
 	struct char_device_struct *cd;
-	cd = __register_chrdev_region(0, 0, count, name);
+	cd = __register_chrdev_region(0, baseminor, count, name);
 	if (IS_ERR(cd))
 		return PTR_ERR(cd);
 	*dev = MKDEV(cd->major, cd->baseminor);




-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


