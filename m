Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWCVPRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWCVPRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWCVPRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:17:46 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:33666 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751287AbWCVPRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:17:44 -0500
Date: Wed, 22 Mar 2006 16:18:11 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org
Subject: [patch 9/24] s390: use normal switch statement for ioctls in dasd_ioctl.c.
Message-ID: <20060322151811.GI5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[patch 9/24] s390: use normal switch statement for ioctls in dasd_ioctl.c.

Handle ioctls implemented in dasd_ioctl through the normal switch
statement that most drivers use instead of the awkward
dasd_ioctl_no_register routine.   This avoids searching a linear list
on every call to dasd_ioctl(), and allows to give the various ioctl
implementation functions sane prototypes, aswell as moving the
check for bdev->bd_disk->private_data from the individual functions
to dasd_ioctl.  (I think it can't actually every be NULL, but let's keep
that for later)

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c       |    4 
 drivers/s390/block/dasd_int.h   |    2 
 drivers/s390/block/dasd_ioctl.c |  241 ++++++++++++++--------------------------
 3 files changed, 86 insertions(+), 161 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-03-22 14:36:18.000000000 +0100
@@ -1807,7 +1807,6 @@ dasd_exit(void)
 #ifdef CONFIG_PROC_FS
 	dasd_proc_exit();
 #endif
-	dasd_ioctl_exit();
         if (dasd_page_cache != NULL) {
 		kmem_cache_destroy(dasd_page_cache);
 		dasd_page_cache = NULL;
@@ -2093,9 +2092,6 @@ dasd_init(void)
 	rc = dasd_parse();
 	if (rc)
 		goto failed;
-	rc = dasd_ioctl_init();
-	if (rc)
-		goto failed;
 #ifdef CONFIG_PROC_FS
 	rc = dasd_proc_init();
 	if (rc)
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-03-22 14:36:18.000000000 +0100
@@ -523,8 +523,6 @@ int dasd_scan_partitions(struct dasd_dev
 void dasd_destroy_partitions(struct dasd_device *);
 
 /* externals in dasd_ioctl.c */
-int  dasd_ioctl_init(void);
-void dasd_ioctl_exit(void);
 int  dasd_ioctl_no_register(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl_no_unregister(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:18.000000000 +0100
@@ -77,62 +77,11 @@ dasd_ioctl_no_unregister(struct module *
 	return 0;
 }
 
-int
-dasd_ioctl(struct inode *inp, struct file *filp,
-	   unsigned int no, unsigned long data)
-{
-	struct block_device *bdev = inp->i_bdev;
-	struct dasd_device *device = bdev->bd_disk->private_data;
-	struct dasd_ioctl *ioctl;
-	const char *dir;
-	int rc;
-
-	if ((_IOC_DIR(no) != _IOC_NONE) && (data == 0)) {
-		PRINT_DEBUG("empty data ptr");
-		return -EINVAL;
-	}
-	dir = _IOC_DIR (no) == _IOC_NONE ? "0" :
-		_IOC_DIR (no) == _IOC_READ ? "r" :
-		_IOC_DIR (no) == _IOC_WRITE ? "w" : 
-		_IOC_DIR (no) == (_IOC_READ | _IOC_WRITE) ? "rw" : "u";
-	DBF_DEV_EVENT(DBF_DEBUG, device,
-		      "ioctl 0x%08x %s'0x%x'%d(%d) with data %8lx", no,
-		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
-	/* Search for ioctl no in the ioctl list. */
-	list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
-		if (ioctl->no == no) {
-			/* Found a matching ioctl. Call it. */
-			if (!try_module_get(ioctl->owner))
-				continue;
-			rc = ioctl->handler(bdev, no, data);
-			module_put(ioctl->owner);
-			return rc;
-		}
-	}
-	/* No ioctl with number no. */
-	DBF_DEV_EVENT(DBF_INFO, device,
-		      "unknown ioctl 0x%08x=%s'0x%x'%d(%d) data %8lx", no,
-		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
-	return -EINVAL;
-}
-
-long
-dasd_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
-{
-	int rval;
-
-	lock_kernel();
-	rval = dasd_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
-	unlock_kernel();
-
-	return (rval == -EINVAL) ? -ENOIOCTLCMD : rval;
-}
-
 static int
-dasd_ioctl_api_version(struct block_device *bdev, int no, long args)
+dasd_ioctl_api_version(void __user *argp)
 {
 	int ver = DASD_API_VERSION;
-	return put_user(ver, (int __user *) args);
+	return put_user(ver, (int *)argp);
 }
 
 /*
@@ -140,15 +89,13 @@ dasd_ioctl_api_version(struct block_devi
  * used by dasdfmt after BIODASDDISABLE to retrigger blocksize detection
  */
 static int
-dasd_ioctl_enable(struct block_device *bdev, int no, long args)
+dasd_ioctl_enable(struct block_device *bdev)
 {
-	struct dasd_device *device;
+	struct dasd_device *device = bdev->bd_disk->private_data;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+
 	dasd_enable_device(device);
 	/* Formatting the dasd device can change the capacity. */
 	down(&bdev->bd_sem);
@@ -162,15 +109,13 @@ dasd_ioctl_enable(struct block_device *b
  * Used by dasdfmt. Disable I/O operations but allow ioctls.
  */
 static int
-dasd_ioctl_disable(struct block_device *bdev, int no, long args)
+dasd_ioctl_disable(struct block_device *bdev)
 {
-	struct dasd_device *device;
+	struct dasd_device *device = bdev->bd_disk->private_data;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+
 	/*
 	 * Man this is sick. We don't do a real disable but only downgrade
 	 * the device to DASD_STATE_BASIC. The reason is that dasdfmt uses
@@ -194,18 +139,13 @@ dasd_ioctl_disable(struct block_device *
  * Quiesce device.
  */
 static int
-dasd_ioctl_quiesce(struct block_device *bdev, int no, long args)
+dasd_ioctl_quiesce(struct dasd_device *device)
 {
-	struct dasd_device *device;
 	unsigned long flags;
 	
 	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
 	
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-	
 	DEV_MESSAGE (KERN_DEBUG, device, "%s",
 		     "Quiesce IO on device");
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
@@ -219,18 +159,13 @@ dasd_ioctl_quiesce(struct block_device *
  * Quiesce device.
  */
 static int
-dasd_ioctl_resume(struct block_device *bdev, int no, long args)
+dasd_ioctl_resume(struct dasd_device *device)
 {
-	struct dasd_device *device;
 	unsigned long flags;
 	
 	if (!capable (CAP_SYS_ADMIN)) 
 		return -EACCES;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
 	DEV_MESSAGE (KERN_DEBUG, device, "%s",
 		     "resume IO on device");
 	
@@ -302,25 +237,19 @@ dasd_format(struct dasd_device * device,
  * Format device.
  */
 static int
-dasd_ioctl_format(struct block_device *bdev, int no, long args)
+dasd_ioctl_format(struct block_device *bdev, void __user *argp)
 {
-	struct dasd_device *device;
+	struct dasd_device *device = bdev->bd_disk->private_data;
 	struct format_data_t fdata;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (!args)
+	if (!argp)
 		return -EINVAL;
-	/* fdata == NULL is no longer a valid arg to dasd_format ! */
-	device = bdev->bd_disk->private_data;
-
-	if (device == NULL)
-		return -ENODEV;
 
 	if (device->features & DASD_FEATURE_READONLY)
 		return -EROFS;
-	if (copy_from_user(&fdata, (void __user *) args,
-			   sizeof (struct format_data_t)))
+	if (copy_from_user(&fdata, argp, sizeof(struct format_data_t)))
 		return -EFAULT;
 	if (bdev != bdev->bd_contains) {
 		DEV_MESSAGE(KERN_WARNING, device, "%s",
@@ -335,17 +264,8 @@ dasd_ioctl_format(struct block_device *b
  * Reset device profile information
  */
 static int
-dasd_ioctl_reset_profile(struct block_device *bdev, int no, long args)
+dasd_ioctl_reset_profile(struct dasd_device *device)
 {
-	struct dasd_device *device;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
 	memset(&device->profile, 0, sizeof (struct dasd_profile_info_t));
 	return 0;
 }
@@ -354,31 +274,24 @@ dasd_ioctl_reset_profile(struct block_de
  * Return device profile information
  */
 static int
-dasd_ioctl_read_profile(struct block_device *bdev, int no, long args)
+dasd_ioctl_read_profile(struct dasd_device *device, void __user *argp)
 {
-	struct dasd_device *device;
-
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
 	if (dasd_profile_level == DASD_PROFILE_OFF)
 		return -EIO;
-
-	if (copy_to_user((long __user *) args, (long *) &device->profile,
+	if (copy_to_user(argp, &device->profile,
 			 sizeof (struct dasd_profile_info_t)))
 		return -EFAULT;
 	return 0;
 }
 #else
 static int
-dasd_ioctl_reset_profile(struct block_device *bdev, int no, long args)
+dasd_ioctl_reset_profile(struct dasd_device *device)
 {
 	return -ENOSYS;
 }
 
 static int
-dasd_ioctl_read_profile(struct block_device *bdev, int no, long args)
+dasd_ioctl_read_profile(struct dasd_device *device, void __user *argp)
 {
 	return -ENOSYS;
 }
@@ -388,18 +301,14 @@ dasd_ioctl_read_profile(struct block_dev
  * Return dasd information. Used for BIODASDINFO and BIODASDINFO2.
  */
 static int
-dasd_ioctl_information(struct block_device *bdev, int no, long args)
+dasd_ioctl_information(struct dasd_device *device,
+		unsigned int cmd, void __user *argp)
 {
-	struct dasd_device *device;
 	struct dasd_information2_t *dasd_info;
 	unsigned long flags;
 	int rc;
 	struct ccw_device *cdev;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
 	if (!device->discipline->fill_info)
 		return -EINVAL;
 
@@ -467,8 +376,8 @@ dasd_ioctl_information(struct block_devi
 	}
 
 	rc = 0;
-	if (copy_to_user((long __user *) args, (long *) dasd_info,
-			 ((no == (unsigned int) BIODASDINFO2) ?
+	if (copy_to_user(argp, dasd_info,
+			 ((cmd == (unsigned int) BIODASDINFO2) ?
 			  sizeof (struct dasd_information2_t) :
 			  sizeof (struct dasd_information_t))))
 		rc = -EFAULT;
@@ -480,68 +389,90 @@ dasd_ioctl_information(struct block_devi
  * Set read only
  */
 static int
-dasd_ioctl_set_ro(struct block_device *bdev, int no, long args)
+dasd_ioctl_set_ro(struct block_device *bdev, void __user *argp)
 {
-	struct dasd_device *device;
-	int intval, rc;
+	struct dasd_device *device =  bdev->bd_disk->private_data;
+	int intval;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (bdev != bdev->bd_contains)
 		// ro setting is not allowed for partitions
 		return -EINVAL;
-	if (get_user(intval, (int __user *) args))
+	if (get_user(intval, (int *)argp))
 		return -EFAULT;
-	device =  bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
 
 	set_disk_ro(bdev->bd_disk, intval);
-	rc = dasd_set_feature(device->cdev, DASD_FEATURE_READONLY, intval);
-
-	return rc;
+	return dasd_set_feature(device->cdev, DASD_FEATURE_READONLY, intval);
 }
 
-/*
- * List of static ioctls.
- */
-static struct { int no; dasd_ioctl_fn_t fn; } dasd_ioctls[] =
-{
-	{ BIODASDDISABLE, dasd_ioctl_disable },
-	{ BIODASDENABLE, dasd_ioctl_enable },
-	{ BIODASDQUIESCE, dasd_ioctl_quiesce },
-	{ BIODASDRESUME, dasd_ioctl_resume },
-	{ BIODASDFMT, dasd_ioctl_format },
-	{ BIODASDINFO, dasd_ioctl_information },
-	{ BIODASDINFO2, dasd_ioctl_information },
-	{ BIODASDPRRD, dasd_ioctl_read_profile },
-	{ BIODASDPRRST, dasd_ioctl_reset_profile },
-	{ BLKROSET, dasd_ioctl_set_ro },
-	{ DASDAPIVER, dasd_ioctl_api_version },
-	{ -1, NULL }
-};
-
 int
-dasd_ioctl_init(void)
+dasd_ioctl(struct inode *inode, struct file *file,
+	   unsigned int cmd, unsigned long arg)
 {
-	int i;
+	struct block_device *bdev = inode->i_bdev;
+	struct dasd_device *device = bdev->bd_disk->private_data;
+	void __user *argp = (void __user *)arg;
+	struct dasd_ioctl *ioctl;
+	int rc;
 
-	for (i = 0; dasd_ioctls[i].no != -1; i++)
-		dasd_ioctl_no_register(NULL, dasd_ioctls[i].no,
-				       dasd_ioctls[i].fn);
-	return 0;
+	if (!device)
+                return -ENODEV;
+
+	if ((_IOC_DIR(cmd) != _IOC_NONE) && !arg) {
+		PRINT_DEBUG("empty data ptr");
+		return -EINVAL;
+	}
 
+	switch (cmd) {
+	case BIODASDDISABLE:
+		return dasd_ioctl_disable(bdev);
+	case BIODASDENABLE:
+		return dasd_ioctl_enable(bdev);
+	case BIODASDQUIESCE:
+		return dasd_ioctl_quiesce(device);
+	case BIODASDRESUME:
+		return dasd_ioctl_resume(device);
+	case BIODASDFMT:
+		return dasd_ioctl_format(bdev, argp);
+	case BIODASDINFO:
+		return dasd_ioctl_information(device, cmd, argp);
+	case BIODASDINFO2:
+		return dasd_ioctl_information(device, cmd, argp);
+	case BIODASDPRRD:
+		return dasd_ioctl_read_profile(device, argp);
+	case BIODASDPRRST:
+		return dasd_ioctl_reset_profile(device);
+	case BLKROSET:
+		return dasd_ioctl_set_ro(bdev, argp);
+	case DASDAPIVER:
+		return dasd_ioctl_api_version(argp);
+	default:
+		/* resort to the deprecated dynamic ioctl list */
+		list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
+			if (ioctl->no == cmd) {
+				/* Found a matching ioctl. Call it. */
+				if (!try_module_get(ioctl->owner))
+					continue;
+				rc = ioctl->handler(bdev, cmd, arg);
+				module_put(ioctl->owner);
+				return rc;
+			}
+		}
+		return -EINVAL;
+	}
 }
 
-void
-dasd_ioctl_exit(void)
+long
+dasd_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	int i;
+	int rval;
 
-	for (i = 0; dasd_ioctls[i].no != -1; i++)
-		dasd_ioctl_no_unregister(NULL, dasd_ioctls[i].no,
-					 dasd_ioctls[i].fn);
+	lock_kernel();
+	rval = dasd_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+	unlock_kernel();
 
+	return (rval == -EINVAL) ? -ENOIOCTLCMD : rval;
 }
 
 EXPORT_SYMBOL(dasd_ioctl_no_register);
