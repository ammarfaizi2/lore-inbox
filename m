Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVKDWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVKDWRF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbVKDWRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:17:05 -0500
Received: from verein.lst.de ([213.95.11.210]:14246 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751053AbVKDWRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:17:03 -0500
Date: Fri, 4 Nov 2005 23:16:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] switch fs3270 to ->compat_ioctl
Message-ID: <20051104221658.GC9384@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

again easy because all ioctls are compat clean.


Index: linux-2.6/arch/s390/kernel/compat_ioctl.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_ioctl.c	2005-11-02 11:12:17.000000000 +0100
+++ linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-11-02 11:13:09.000000000 +0100
@@ -44,13 +44,6 @@
 #include "../../../fs/compat_ioctl.c"
 
 /* s390 only ioctls */
-COMPATIBLE_IOCTL(TUBICMD)
-COMPATIBLE_IOCTL(TUBOCMD)
-COMPATIBLE_IOCTL(TUBGETI)
-COMPATIBLE_IOCTL(TUBGETO)
-COMPATIBLE_IOCTL(TUBSETMOD)
-COMPATIBLE_IOCTL(TUBGETMOD)
-
 COMPATIBLE_IOCTL(TAPE390_DISPLAY)
 
 /* s390 doesn't need handlers here */
Index: linux-2.6/drivers/s390/char/fs3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/fs3270.c	2005-11-02 11:12:16.000000000 +0100
+++ linux-2.6/drivers/s390/char/fs3270.c	2005-11-02 11:14:03.000000000 +0100
@@ -319,9 +319,8 @@
 /*
  * process ioctl commands for the tube driver
  */
-static int
-fs3270_ioctl(struct inode *inode, struct file *filp,
-	     unsigned int cmd, unsigned long arg)
+static long
+fs3270_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct fs3270 *fp;
 	struct raw3270_iocb iocb;
@@ -331,6 +330,7 @@
 	if (!fp)
 		return -ENODEV;
 	rc = 0;
+	lock_kernel();
 	switch (cmd) {
 	case TUBICMD:
 		fp->read_command = arg;
@@ -356,6 +356,7 @@
 			rc = -EFAULT;
 		break;
 	}
+	unlock_kernel();
 	return rc;
 }
 
@@ -491,12 +492,13 @@
 }
 
 static struct file_operations fs3270_fops = {
-	.owner	 = THIS_MODULE,		/* owner */
-	.read	 = fs3270_read,		/* read */
-	.write	 = fs3270_write,	/* write */
-	.ioctl	 = fs3270_ioctl,	/* ioctl */
-	.open	 = fs3270_open,		/* open */
-	.release = fs3270_close,	/* release */
+	.owner		 = THIS_MODULE,		/* owner */
+	.read		 = fs3270_read,		/* read */
+	.write		 = fs3270_write,	/* write */
+	.unlocked_ioctl	 = fs3270_ioctl,	/* ioctl */
+	.compat_ioctl	 = fs3270_ioctl,	/* ioctl */
+	.open	 	= fs3270_open,		/* open */
+	.release 	= fs3270_close,		/* release */
 };
 
 /*
