Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWCVPUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWCVPUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWCVPUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:20:08 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37597 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750745AbWCVPUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:20:06 -0500
Date: Wed, 22 Mar 2006 16:20:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org
Subject: [patch 11/24] s390: merge cmb into dasd.c.
Message-ID: <20060322152032.GK5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[patch 11/24] s390: merge cmb into dasd.c.

dasd_cmd just implements three ioctls which are wrappers around
functionality in the core kernel or other modules.  When merging those
into dasd_mod they just add 22 lines of code which is far less than the
amount of code removed in the last two patches, and which doesn't spill
into another 4k pages when build modular, while removing a 128lines
module.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/Kconfig      |   10 ---
 drivers/s390/block/Makefile     |    1 
 drivers/s390/block/dasd_cmb.c   |  128 ----------------------------------------
 drivers/s390/block/dasd_ioctl.c |   22 ++++++
 4 files changed, 22 insertions(+), 139 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_cmb.c linux-2.6-patched/drivers/s390/block/dasd_cmb.c
--- linux-2.6/drivers/s390/block/dasd_cmb.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_cmb.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,128 +0,0 @@
-/*
- * Linux on zSeries Channel Measurement Facility support
- *  (dasd device driver interface)
- *
- * Copyright 2000,2003 IBM Corporation
- *
- * Author: Arnd Bergmann <arndb@de.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <asm/ccwdev.h>
-#include <asm/cmb.h>
-
-#include "dasd_int.h"
-
-static int
-dasd_ioctl_cmf_enable(struct block_device *bdev, int no, long args)
-{
-	struct dasd_device *device;
-
-	device = bdev->bd_disk->private_data;
-	if (!device)
-		return -EINVAL;
-
-	return enable_cmf(device->cdev);
-}
-
-static int
-dasd_ioctl_cmf_disable(struct block_device *bdev, int no, long args)
-{
-	struct dasd_device *device;
-
-	device = bdev->bd_disk->private_data;
-	if (!device)
-		return -EINVAL;
-
-	return disable_cmf(device->cdev);
-}
-
-static int
-dasd_ioctl_readall_cmb(struct block_device *bdev, int no, long args)
-{
-	struct dasd_device *device;
-	struct cmbdata __user *udata;
-	struct cmbdata data;
-	size_t size;
-	int ret;
-
-	device = bdev->bd_disk->private_data;
-	if (!device)
-		return -EINVAL;
-	udata = (void __user *) args;
-	size = _IOC_SIZE(no);
-
-	if (!access_ok(VERIFY_WRITE, udata, size))
-		return -EFAULT;
-	ret = cmf_readall(device->cdev, &data);
-	if (ret)
-		return ret;
-	if (copy_to_user(udata, &data, min(size, sizeof(*udata))))
-		return -EFAULT;
-	return 0;
-}
-
-/* module initialization below here. dasd already provides a mechanism
- * to dynamically register ioctl functions, so we simply use this. */
-static inline int
-ioctl_reg(unsigned int no, dasd_ioctl_fn_t handler)
-{
-	return dasd_ioctl_no_register(THIS_MODULE, no, handler);
-}
-
-static inline void
-ioctl_unreg(unsigned int no, dasd_ioctl_fn_t handler)
-{
-	dasd_ioctl_no_unregister(THIS_MODULE, no, handler);
-}
-
-static void
-dasd_cmf_exit(void)
-{
-	ioctl_unreg(BIODASDCMFENABLE,  dasd_ioctl_cmf_enable);
-	ioctl_unreg(BIODASDCMFDISABLE, dasd_ioctl_cmf_disable);
-	ioctl_unreg(BIODASDREADALLCMB, dasd_ioctl_readall_cmb);
-}
-
-static int __init
-dasd_cmf_init(void)
-{
-	int ret;
-	ret = ioctl_reg (BIODASDCMFENABLE, dasd_ioctl_cmf_enable);
-	if (ret)
-		goto err;
-	ret = ioctl_reg (BIODASDCMFDISABLE, dasd_ioctl_cmf_disable);
-	if (ret)
-		goto err;
-	ret = ioctl_reg (BIODASDREADALLCMB, dasd_ioctl_readall_cmb);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	dasd_cmf_exit();
-
-	return ret;
-}
-
-module_init(dasd_cmf_init);
-module_exit(dasd_cmf_exit);
-
-MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("channel measurement facility interface for dasd\n"
-		   "Copyright 2003 IBM Corporation\n");
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:21.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:21.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/blkpg.h>
 
 #include <asm/ccwdev.h>
+#include <asm/cmb.h>
 #include <asm/uaccess.h>
 
 /* This is ugly... */
@@ -406,6 +407,21 @@ dasd_ioctl_set_ro(struct block_device *b
 	return dasd_set_feature(device->cdev, DASD_FEATURE_READONLY, intval);
 }
 
+static int
+dasd_ioctl_readall_cmb(struct dasd_device *device, unsigned int cmd,
+		unsigned long arg)
+{
+	struct cmbdata __user *argp = (void __user *) arg;
+	size_t size = _IOC_SIZE(cmd);
+	struct cmbdata data;
+	int ret;
+
+	ret = cmf_readall(device->cdev, &data);
+	if (!ret && copy_to_user(argp, &data, min(size, sizeof(*argp))))
+		return -EFAULT;
+	return ret;
+}
+
 int
 dasd_ioctl(struct inode *inode, struct file *file,
 	   unsigned int cmd, unsigned long arg)
@@ -447,6 +463,12 @@ dasd_ioctl(struct inode *inode, struct f
 		return dasd_ioctl_set_ro(bdev, argp);
 	case DASDAPIVER:
 		return dasd_ioctl_api_version(argp);
+	case BIODASDCMFENABLE:
+		return enable_cmf(device->cdev);
+	case BIODASDCMFDISABLE:
+		return disable_cmf(device->cdev);
+	case BIODASDREADALLCMB:
+		return dasd_ioctl_readall_cmb(device, cmd, arg);
 	default:
 		/* if the discipline has an ioctl method try it. */
 		if (device->discipline->ioctl) {
diff -urpN linux-2.6/drivers/s390/block/Kconfig linux-2.6-patched/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/Kconfig	2006-03-22 14:36:21.000000000 +0100
@@ -55,14 +55,4 @@ config DASD_DIAG
 	  Disks under VM.  If you are not running under VM or unsure what it is,
 	  say "N".
 
-config DASD_CMB
-	tristate "Compatibility interface for DASD channel measurement blocks"
-	depends on DASD
-	help
-	  This driver provides an additional interface to the channel measurement
-	  facility, which is normally accessed though sysfs, with a set of
-	  ioctl functions specific to the dasd driver.
-	  This is only needed if you want to use applications written for
-	  linux-2.4 dasd channel measurement facility interface.
-
 endif
diff -urpN linux-2.6/drivers/s390/block/Makefile linux-2.6-patched/drivers/s390/block/Makefile
--- linux-2.6/drivers/s390/block/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/Makefile	2006-03-22 14:36:21.000000000 +0100
@@ -12,6 +12,5 @@ obj-$(CONFIG_DASD) += dasd_mod.o
 obj-$(CONFIG_DASD_DIAG) += dasd_diag_mod.o
 obj-$(CONFIG_DASD_ECKD) += dasd_eckd_mod.o
 obj-$(CONFIG_DASD_FBA)  += dasd_fba_mod.o
-obj-$(CONFIG_DASD_CMB)  += dasd_cmb.o
 obj-$(CONFIG_BLK_DEV_XPRAM) += xpram.o
 obj-$(CONFIG_DCSSBLK) += dcssblk.o
