Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261470AbTCJTmF>; Mon, 10 Mar 2003 14:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTCJTmF>; Mon, 10 Mar 2003 14:42:05 -0500
Received: from verein.lst.de ([212.34.181.86]:14857 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261470AbTCJTlu>;
	Mon, 10 Mar 2003 14:41:50 -0500
Date: Mon, 10 Mar 2003 20:52:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove DEVFS_FL_AUTO_DEVNUM
Message-ID: <20030310205228.B23487@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the DEVFS_FL_AUTO_DEVNUM flag that makes devfs_register()
allocate a dev_t for it's caller.

Rationale:  while dynamic major/minors are a good idea, devfs is the
wrong layer to do it because all code relying on it would break with
out devfs.

There were three users (outside the SN1 IRIX compat layer that needs
a large rewrite for 2.5/2.6 anyway):

drivers/media/dvb/dvb-core/dvbdev.c:
	only used under CONFIG_DVB_DEVFS_ONLY, which isn't exposed in
	the kernel configurator, removed that code.
drivers/media/radio/miropcm20-rds.c:
	driver was devfs-only.  Add a miscdevice with dynamic minor
	allocation.


--- 1.12/Documentation/filesystems/devfs/README	Wed Aug 21 00:09:12 2002
+++ edited/Documentation/filesystems/devfs/README	Sat Mar  1 11:17:22 2003
@@ -1466,13 +1466,6 @@
 keep using the old major and minor numbers. Devfs will take whatever
 values are given for major&minor and pass them onto userspace.
 
-Alternatively, you can have devfs choose unique device numbers for
-you. When you register a character or block device using
-devfs_register you can provide the optional
-DEVFS_FL_AUTO_DEVNUM flag, which will then automatically allocate a
-unique device number (the allocation is separated for the character
-and block devices).
-
 This device number is a 16 bit number, so this leaves plenty of space
 for large numbers of discs and partitions. This scheme can also be
 used for character devices, in particular the tty devices, which are
--- 1.3/drivers/media/dvb/dvb-core/dvbdev.c	Mon Nov 25 10:57:37 2002
+++ edited/drivers/media/dvb/dvb-core/dvbdev.c	Sat Mar  1 11:57:26 2003
@@ -21,8 +21,6 @@
  *
  */
 
-/*#define CONFIG_DVB_DEVFS_ONLY 1*/
-
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
@@ -56,18 +54,8 @@
 };
 
 
-#ifdef CONFIG_DVB_DEVFS_ONLY
-
-	#define DVB_MAX_IDS              ~0
-	#define nums2minor(num,type,id)  0
-	#define DVB_DEVFS_FLAGS          (DEVFS_FL_DEFAULT|DEVFS_FL_AUTO_DEVNUM)
-
-#else
-
-	#define DVB_MAX_IDS              4
-	#define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
-	#define DVB_DEVFS_FLAGS          (DEVFS_FL_DEFAULT)
-
+#define DVB_MAX_IDS              4
+#define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
 
 static
 struct dvb_device* dvbdev_find_device (int minor)
@@ -122,9 +110,6 @@
 	.owner =	THIS_MODULE,
 	.open =		dvb_device_open,
 };
-#endif /* CONFIG_DVB_DEVFS_ONLY */
-
-
 
 int dvb_generic_open(struct inode *inode, struct file *file)
 {
@@ -234,7 +219,7 @@
 
 	sprintf(name, "%s%d", dnames[type], id);
 	dvbdev->devfs_handle = devfs_register(adap->devfs_handle, name,
-					      DVB_DEVFS_FLAGS,
+					      DEVFS_FL_DEFAULT,
 					      DVB_MAJOR,
 					      nums2minor(adap->num, type, id),
 					      S_IFCHR | S_IRUSR | S_IWUSR,
===== drivers/media/radio/miropcm20-rds.c 1.6 vs edited =====
--- 1.6/drivers/media/radio/miropcm20-rds.c	Wed Jan  1 14:31:32 2003
+++ edited/drivers/media/radio/miropcm20-rds.c	Sat Mar  1 11:16:45 2003
@@ -12,8 +12,9 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <asm/uaccess.h>
+#include <linux/miscdevice.h>
 #include <linux/devfs_fs_kernel.h>
+#include <asm/uaccess.h>
 #include "miropcm20-rds-core.h"
 
 static char * text_buffer;
@@ -103,28 +104,39 @@
 	}
 }
 
-static struct file_operations rds_f_ops = {
+static struct file_operations rds_fops = {
 	.owner		= THIS_MODULE,
 	.read		= rds_f_read,
 	.open		= rds_f_open,
 	.release	= rds_f_release
 };
 
+static struct miscdevice rds_miscdev = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "radiotext"
+	.fops		= &rds_fops,
+};
 
 static int __init miropcm20_rds_init(void)
 {
-	if (!devfs_register(NULL, "v4l/rds/radiotext", 
-				   DEVFS_FL_DEFAULT | DEVFS_FL_AUTO_DEVNUM,
-				   0, 0, S_IRUGO | S_IFCHR, &rds_f_ops, NULL))
-		return -EINVAL;
+	int error;
 
-	printk("miropcm20-rds: userinterface driver loaded.\n");
-	return 0;
+	error = misc_register(&rds_miscdev);
+	if (error)
+		return error;
+
+	error = devfs_mk_symlink(NULL, "v4l/rds/radiotext", 0,
+				 "../misc/radiotext", NULL, NULL);
+	if (error)
+		misc_deregister(&rds_miscdev)
+
+	return error;
 }
 
 static void __exit miropcm20_rds_cleanup(void)
 {
 	devfs_remove("v4l/rds/radiotext");
+	misc_deregister(&rds_miscdev)
 }
 
 module_init(miropcm20_rds_init);
--- 1.71/fs/devfs/base.c	Tue Feb 25 13:47:06 2003
+++ edited/fs/devfs/base.c	Sat Mar  1 18:05:46 2003
@@ -773,7 +773,6 @@
 {
     struct block_device_operations *ops;
     dev_t dev;
-    unsigned char autogen:1;
     unsigned char removable:1;
 };
 
@@ -938,8 +937,6 @@
     if ( S_ISLNK (de->mode) ) kfree (de->u.symlink.linkname);
     if ( S_ISCHR (de->mode) && de->u.cdev.autogen )
 	devfs_dealloc_devnum (de->mode, de->u.cdev.dev);
-    if ( S_ISBLK (de->mode) && de->u.bdev.autogen )
-	devfs_dealloc_devnum (de->mode, de->u.bdev.dev);
     WRITE_ENTRY_MAGIC (de, 0);
 #ifdef CONFIG_DEVFS_DEBUG
     spin_lock (&stat_lock);
@@ -1494,17 +1491,6 @@
     {
 	PRINTK ("(%s): creating symlinks is not allowed\n", name);
 	return NULL;
-    }
-    if ( ( S_ISCHR (mode) || S_ISBLK (mode) ) &&
-	 (flags & DEVFS_FL_AUTO_DEVNUM) )
-    {
-	devnum = devfs_alloc_devnum (mode);
-	if (!devnum) {
-	    PRINTK ("(%s): exhausted %s device numbers\n",
-		    name, S_ISCHR (mode) ? "char" : "block");
-	    return NULL;
-	}
-	dev = devnum;
     }
     if ( ( de = _devfs_prepare_leaf (&dir, name, mode) ) == NULL )
     {
--- 1.28/include/linux/devfs_fs_kernel.h	Wed Jan 15 15:56:40 2003
+++ edited/include/linux/devfs_fs_kernel.h	Sat Mar  1 11:43:44 2003
@@ -13,8 +13,6 @@
 
 #define DEVFS_FL_NONE           0x000 /* This helps to make code more readable
 				       */
-#define DEVFS_FL_AUTO_DEVNUM    0x002 /* Automatically generate device number
-				       */
 #define DEVFS_FL_REMOVABLE      0x008 /* This is a removable media device    */
 #define DEVFS_FL_WAIT           0x010 /* Wait for devfsd to finish           */
 #define DEVFS_FL_CURRENT_OWNER  0x020 /* Set initial ownership to current    */
