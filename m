Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbTCHOkF>; Sat, 8 Mar 2003 09:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbTCHOkE>; Sat, 8 Mar 2003 09:40:04 -0500
Received: from hera.cwi.nl ([192.16.191.8]:28292 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262033AbTCHOkC>;
	Sat, 8 Mar 2003 09:40:02 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Mar 2003 15:50:39 +0100 (MET)
Message-Id: <UTC200303081450.h28Eodc28276.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] oops in raw.c + fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch in the dev_t series eliminates the last applied use
of MAX_BLKDEV - only the definition in major.h remains.

Sneaky as I am, I combine this patch with the fix for an Oops:
On open, raw_open does
	filp->f_dentry->d_inode->i_mapping =
		bdev->bd_inode->i_mapping;
storing a pointer to bdev stuff.
But on release this pointer stayed, the block device is not
referenced anymore and disappears, and the next open references
undefined stuff.
I checked, and this can actually cause an Oops - scenario:
# raw /dev/raw/raw12 /dev/hdf
# dd if=/dev/raw/raw12 of=/dev/null bs=512 count=1
# raw /dev/raw/raw12 0 0
# dd if=/dev/raw/raw12 of=/dev/null bs=512 count=1
Oops.

More precisely the problem is that dentry_open does
file_ra_state_init(&f->f_ra, inode->i_mapping);
And file_ra_state_init uses mapping->backing_dev_info->ra_pages.
Ugly, to use so much information about the inode even before
the inode has been opened.

In the patch below I reset i_mapping upon release of the raw device.

Andries

---
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Thu Jan  9 18:07:10 2003
+++ b/drivers/char/raw.c	Sat Mar  8 15:24:14 2003
@@ -19,14 +19,16 @@
 
 #include <asm/uaccess.h>
 
+#define MAX_RAW_MINORS	256
+
 struct raw_device_data {
 	struct block_device *binding;
 	int inuse;
 };
 
-static struct raw_device_data raw_devices[256];
+static struct raw_device_data raw_devices[MAX_RAW_MINORS];
 static DECLARE_MUTEX(raw_mutex);
-static struct file_operations raw_ctl_fops;
+static struct file_operations raw_ctl_fops;	     /* forward dclaration */
 
 /*
  * Open/close code for raw IO.
@@ -85,11 +87,16 @@
 {
 	const int minor= minor(inode->i_rdev);
 	struct block_device *bdev;
-	
+
 	down(&raw_mutex);
 	bdev = raw_devices[minor].binding;
 	raw_devices[minor].inuse--;
 	up(&raw_mutex);
+
+	/* Here  inode->i_mapping == bdev->bd_inode->i_mapping  */
+	inode->i_mapping = &inode->i_data;
+	inode->i_mapping->backing_dev_info = &default_backing_dev_info;
+	
 	bd_release(bdev);
 	blkdev_put(bdev, BDEV_RAW);
 	return 0;
@@ -130,11 +137,13 @@
 			goto out;
 		
 		err = -EINVAL;
-		if (rq.raw_minor < 0 || rq.raw_minor > MINORMASK)
+		if (rq.raw_minor < 0 || rq.raw_minor >= MAX_RAW_MINORS)
 			goto out;
 		rawdev = &raw_devices[rq.raw_minor];
 
 		if (command == RAW_SETBIND) {
+			dev_t dev;
+
 			/*
 			 * This is like making block devices, so demand the
 			 * same capability
@@ -151,9 +160,10 @@
 			 */
 
 			err = -EINVAL;
+			dev = MKDEV(rq.block_major, rq.block_minor);
 			if ((rq.block_major == 0 && rq.block_minor != 0) ||
-					rq.block_major > MAX_BLKDEV ||
-					rq.block_minor > MINORMASK)
+			    MAJOR(dev) != rq.block_major ||
+			    MINOR(dev) != rq.block_minor)
 				goto out;
 			
 			down(&raw_mutex);
@@ -170,10 +180,7 @@
 				/* unbind */
 				rawdev->binding = NULL;
 			} else {
-				kdev_t kdev;
-
-				kdev = mk_kdev(rq.block_major, rq.block_minor);
-				rawdev->binding = bdget(kdev_t_to_nr(kdev));
+				rawdev->binding = bdget(dev);
 				MOD_INC_USE_COUNT;
 			}
 			up(&raw_mutex);

