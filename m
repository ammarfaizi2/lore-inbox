Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVKDWSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVKDWSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVKDWSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:18:22 -0500
Received: from verein.lst.de ([213.95.11.210]:16550 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751056AbVKDWSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:18:21 -0500
Date: Fri, 4 Nov 2005 23:18:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ->compat_ioctl for 390 tape_char
Message-ID: <20051104221816.GD9384@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only own ioctl, TAPE390_DISPLAY, is compat_clean, everything else
is routed through common translation code.


Index: linux-2.6/drivers/s390/char/tape_char.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_char.c	2005-11-02 11:18:41.000000000 +0100
+++ linux-2.6/drivers/s390/char/tape_char.c	2005-11-02 11:19:12.000000000 +0100
@@ -37,6 +37,8 @@
 static int tapechar_release(struct inode *,struct file *);
 static int tapechar_ioctl(struct inode *, struct file *, unsigned int,
 			  unsigned long);
+static long tapechar_compat_ioctl(struct file *, unsigned int,
+			  unsigned long);
 
 static struct file_operations tape_fops =
 {
@@ -44,6 +46,7 @@
 	.read = tapechar_read,
 	.write = tapechar_write,
 	.ioctl = tapechar_ioctl,
+	.compat_ioctl = tapechar_compat_ioctl,
 	.open = tapechar_open,
 	.release = tapechar_release,
 };
@@ -463,6 +466,21 @@
 	return device->discipline->ioctl_fn(device, no, data);
 }
 
+static long
+tapechar_compat_ioctl(struct file *filp, unsigned int no, unsigned long data)
+{
+	struct tape_device *device = filp->private_data;
+	int rval = -ENOIOCTLCMD;
+
+	if (device->discipline->ioctl_fn) {
+		lock_kernel();
+		rval = device->discipline->ioctl_fn(device, no, data);
+		unlock_kernel();
+	}
+
+	return rval;
+}
+
 /*
  * Initialize character device frontend.
  */
Index: linux-2.6/arch/s390/kernel/compat_ioctl.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_ioctl.c	2005-11-02 11:19:08.000000000 +0100
+++ linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-11-02 11:19:24.000000000 +0100
@@ -42,9 +42,6 @@
 #include <linux/compat_ioctl.h>
 #define DECLARES
 #include "../../../fs/compat_ioctl.c"
-
-/* s390 only ioctls */
-COMPATIBLE_IOCTL(TAPE390_DISPLAY)
 };
 
 int ioctl_table_size = ARRAY_SIZE(ioctl_start);
