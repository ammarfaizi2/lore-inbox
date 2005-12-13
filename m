Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVLMRXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVLMRXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVLMRXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:23:32 -0500
Received: from verein.lst.de ([213.95.11.210]:5074 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751090AbVLMRXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:23:31 -0500
Date: Tue, 13 Dec 2005 18:23:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/3] add ->compat_ioctl to dasd
Message-ID: <20051213172320.GB16392@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compat_ioctl method to the dasd driver so the last entries in
arch/s390/kernel/compat_ioctl.c can go away.  Unlike the previous
attempt this one does not replace the ioctl method with an
unlocked_ioctl method so that the ioctl_by_bdev calls in s390 partition
code continue to work.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/drivers/s390/block/dasd.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd.c	2005-12-12 19:09:39.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd.c	2005-12-12 19:09:41.000000000 +0100
@@ -1751,6 +1751,7 @@
 	.open		= dasd_open,
 	.release	= dasd_release,
 	.ioctl		= dasd_ioctl,
+	.compat_ioctl	= dasd_compat_ioctl,
 	.getgeo		= dasd_getgeo,
 };
 
Index: linux-2.6.15-rc5/drivers/s390/block/dasd_int.h
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_int.h	2005-12-12 19:09:39.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_int.h	2005-12-12 19:09:41.000000000 +0100
@@ -527,6 +527,7 @@
 int  dasd_ioctl_no_register(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl_no_unregister(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+long dasd_compat_ioctl(struct file *, unsigned int, unsigned long);
 
 /* externals in dasd_proc.c */
 int dasd_proc_init(void);
Index: linux-2.6.15-rc5/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_ioctl.c	2005-12-12 19:09:39.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_ioctl.c	2005-12-12 19:09:41.000000000 +0100
@@ -118,6 +118,18 @@
 	return -EINVAL;
 }
 
+long
+dasd_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	int rval;
+
+	lock_kernel();
+	rval = dasd_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+	unlock_kernel();
+
+	return rval;
+}
+
 static int
 dasd_ioctl_api_version(struct block_device *bdev, int no, long args)
 {
Index: linux-2.6.15-rc5/arch/s390/kernel/compat_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/s390/kernel/compat_ioctl.c	2005-12-12 19:09:39.000000000 +0100
+++ linux-2.6.15-rc5/arch/s390/kernel/compat_ioctl.c	2005-12-12 19:15:46.000000000 +0100
@@ -42,27 +42,6 @@
 #include <linux/compat_ioctl.h>
 #define DECLARES
 #include "../../../fs/compat_ioctl.c"
-
-/* s390 only ioctls */
-COMPATIBLE_IOCTL(DASDAPIVER)
-COMPATIBLE_IOCTL(BIODASDDISABLE)
-COMPATIBLE_IOCTL(BIODASDENABLE)
-COMPATIBLE_IOCTL(BIODASDRSRV)
-COMPATIBLE_IOCTL(BIODASDRLSE)
-COMPATIBLE_IOCTL(BIODASDSLCK)
-COMPATIBLE_IOCTL(BIODASDINFO)
-COMPATIBLE_IOCTL(BIODASDINFO2)
-COMPATIBLE_IOCTL(BIODASDFMT)
-COMPATIBLE_IOCTL(BIODASDPRRST)
-COMPATIBLE_IOCTL(BIODASDQUIESCE)
-COMPATIBLE_IOCTL(BIODASDRESUME)
-COMPATIBLE_IOCTL(BIODASDPRRD)
-COMPATIBLE_IOCTL(BIODASDPSRD)
-COMPATIBLE_IOCTL(BIODASDGATTR)
-COMPATIBLE_IOCTL(BIODASDSATTR)
-COMPATIBLE_IOCTL(BIODASDCMFENABLE)
-COMPATIBLE_IOCTL(BIODASDCMFDISABLE)
-COMPATIBLE_IOCTL(BIODASDREADALLCMB)
 };
 
 int ioctl_table_size = ARRAY_SIZE(ioctl_start);
