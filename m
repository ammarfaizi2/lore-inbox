Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVKDWQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVKDWQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVKDWQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:16:59 -0500
Received: from verein.lst.de ([213.95.11.210]:12966 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751051AbVKDWQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:16:58 -0500
Date: Fri, 4 Nov 2005 23:16:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] add compat_ioctl methods to dasd
Message-ID: <20051104221652.GB9384@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

all dasd ioctls are directly useable from 32bit process, thus switch
the dasd driver to unlocked_ioctl/compat_ioctl and get rid of the
translations in the global table.


Index: linux-2.6/arch/s390/kernel/compat_ioctl.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_ioctl.c	2005-11-04 13:49:43.000000000 +0100
+++ linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-11-04 14:01:19.000000000 +0100
@@ -44,26 +44,6 @@
 #include "../../../fs/compat_ioctl.c"
 
 /* s390 only ioctls */
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
-
 COMPATIBLE_IOCTL(TUBICMD)
 COMPATIBLE_IOCTL(TUBOCMD)
 COMPATIBLE_IOCTL(TUBGETI)
Index: linux-2.6/drivers/s390/block/dasd.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd.c	2005-11-04 13:49:43.000000000 +0100
+++ linux-2.6/drivers/s390/block/dasd.c	2005-11-04 14:01:19.000000000 +0100
@@ -1726,7 +1726,10 @@
 	.owner		= THIS_MODULE,
 	.open		= dasd_open,
 	.release	= dasd_release,
-	.ioctl		= dasd_ioctl,
+	.unlocked_ioctl	= dasd_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= dasd_ioctl,
+#endif
 };
 
 
Index: linux-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_int.h	2005-11-04 13:49:43.000000000 +0100
+++ linux-2.6/drivers/s390/block/dasd_int.h	2005-11-04 14:01:19.000000000 +0100
@@ -525,7 +525,7 @@
 void dasd_ioctl_exit(void);
 int  dasd_ioctl_no_register(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl_no_unregister(struct module *, int, dasd_ioctl_fn_t);
-int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+long dasd_ioctl(struct file *, unsigned int, unsigned long);
 
 /* externals in dasd_proc.c */
 int dasd_proc_init(void);
Index: linux-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_ioctl.c	2005-11-04 13:49:43.000000000 +0100
+++ linux-2.6/drivers/s390/block/dasd_ioctl.c	2005-11-04 14:01:19.000000000 +0100
@@ -79,15 +79,14 @@
 	return 0;
 }
 
-int
-dasd_ioctl(struct inode *inp, struct file *filp,
-	   unsigned int no, unsigned long data)
+long
+dasd_ioctl(struct file *filp, unsigned int no, unsigned long data)
 {
-	struct block_device *bdev = inp->i_bdev;
+	struct block_device *bdev = filp->f_dentry->d_inode->i_bdev;
 	struct dasd_device *device = bdev->bd_disk->private_data;
 	struct dasd_ioctl *ioctl;
 	const char *dir;
-	int rc;
+	int rc = -EINVAL;
 
 	if ((_IOC_DIR(no) != _IOC_NONE) && (data == 0)) {
 		PRINT_DEBUG("empty data ptr");
@@ -100,6 +99,8 @@
 	DBF_DEV_EVENT(DBF_DEBUG, device,
 		      "ioctl 0x%08x %s'0x%x'%d(%d) with data %8lx", no,
 		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
+
+	lock_kernel()
 	/* Search for ioctl no in the ioctl list. */
 	list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
 		if (ioctl->no == no) {
@@ -108,14 +109,16 @@
 				continue;
 			rc = ioctl->handler(bdev, no, data);
 			module_put(ioctl->owner);
-			return rc;
+			goto out;
 		}
 	}
 	/* No ioctl with number no. */
 	DBF_DEV_EVENT(DBF_INFO, device,
 		      "unknown ioctl 0x%08x=%s'0x%x'%d(%d) data %8lx", no,
 		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
-	return -EINVAL;
+ out:
+	unlock_kernel();
+	return rc;
 }
 
 static int
