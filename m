Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWBLRjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWBLRjH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWBLRjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:39:07 -0500
Received: from verein.lst.de ([213.95.11.210]:53400 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750821AbWBLRjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:39:04 -0500
Date: Sun, 12 Feb 2006 18:38:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com, linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dasd: cleanup dasd_ioctl
Message-ID: <20060212173855.GB26035@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle ioctls implemented in dasd_ioctl through the normal switch
statement that most drivers use instead of the awkward
dasd_ioctl_no_register routine.   This avoids searching a linear list
on every call to dasd_ioctl(), and allows to give the various ioctl
implementation functions sane prototypes, aswell as moving the
check for bdev->bd_disk->private_data from the individual functions
to dasd_ioctl.  (I think it can't actually every be NULL, but let's keep
that for later)


 dasd.c       |    4 
 dasd_int.h   |    2 
 dasd_ioctl.c |  241 +++++++++++++++++++++--------------------------------------
 3 files changed, 86 insertions(+), 161 deletions(-)

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_int.h
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/s390/block/dasd_int.h	2006-02-11 17:32:51.000000000 +0100
+++ linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_int.h	2006-02-11 17:33:47.000000000 +0100
@@ -558,8 +558,6 @@
 void dasd_destroy_partitions(struct dasd_device *);
 
 /* externals in dasd_ioctl.c */
-int  dasd_ioctl_init(void);
-void dasd_ioctl_exit(void);
 int  dasd_ioctl_no_register(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl_no_unregister(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
Index: linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/s390/block/dasd_ioctl.c	2006-02-11 17:32:51.000000000 +0100
+++ linux-2.6.16-rc2-mm1/drivers/s390/block/dasd_ioctl.c	2006-02-11 17:34:03.000000000 +0100
@@ -77,62 +77,11 @@
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
@@ -140,15 +89,13 @@
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
 	mutex_lock(&bdev->bd_mutex);
@@ -162,15 +109,13 @@
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
@@ -194,18 +139,13 @@
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
@@ -219,18 +159,13 @@
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
 	
@@ -302,25 +237,19 @@
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
@@ -335,17 +264,8 @@
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
@@ -354,31 +274,24 @@
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
@@ -388,18 +301,14 @@
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
 
@@ -467,8 +376,8 @@
 	}
 
 	rc = 0;
-	if (copy_to_user((long __user *) args, (long *) dasd_info,
-			 ((no == (unsigned int) BIODASDINFO2) ?
+	if (copy_to_user(argp, dasd_info,
+			 ((cmd == (unsigned int) BIODASDINFO2) ?
 			  sizeof (struct dasd_information2_t) :
 			  sizeof (struct dasd_information_t))))
 		rc = -EFAULT;
@@ -480,68 +389,90 @@
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
Index: linux-2.6.16-rc2-mm1/drivers/s390/block/dasd.c
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/s390/block/dasd.c	2006-02-11 17:32:51.000000000 +0100
+++ linux-2.6.16-rc2-mm1/drivers/s390/block/dasd.c	2006-02-11 17:33:47.000000000 +0100
@@ -1803,7 +1803,6 @@
 #ifdef CONFIG_PROC_FS
 	dasd_proc_exit();
 #endif
-	dasd_ioctl_exit();
         if (dasd_page_cache != NULL) {
 		kmem_cache_destroy(dasd_page_cache);
 		dasd_page_cache = NULL;
@@ -2123,9 +2122,6 @@
 	rc = dasd_parse();
 	if (rc)
 		goto failed;
-	rc = dasd_ioctl_init();
-	if (rc)
-		goto failed;
 #ifdef CONFIG_PROC_FS
 	rc = dasd_proc_init();
 	if (rc)
