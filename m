Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261469AbTCJTly>; Mon, 10 Mar 2003 14:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbTCJTly>; Mon, 10 Mar 2003 14:41:54 -0500
Received: from verein.lst.de ([212.34.181.86]:14345 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261469AbTCJTlq>;
	Mon, 10 Mar 2003 14:41:46 -0500
Date: Mon, 10 Mar 2003 20:52:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove devfs_only()
Message-ID: <20030310205223.A23487@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:  devfs_only does nothing but disabling {un,}register_blkdev
and {un,}register_chrdev.  {un,}register_blkdev already do nothing but
adding it's name argument to a lookup table for the __bdevname and
/proc/device output so this use is already bogus.  The disabling of
the character device per-major arrays can work in practice but is
useless as any driver relying on it can't be used on non-devfs systems.



--- 1.73/drivers/block/genhd.c	Sat Mar  8 23:50:30 2003
+++ edited/drivers/block/genhd.c	Mon Mar 10 19:47:07 2003
@@ -91,9 +91,6 @@
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
 
-	if (devfs_only())
-		return 0;
-
 	/* temporary */
 	if (major == 0) {
 		down_read(&block_subsys.rwsem);
@@ -141,12 +138,8 @@
 int unregister_blkdev(unsigned int major, const char *name)
 {
 	struct blk_major_name **n, *p;
-	int index;
+	int index = major_to_index(major);
 	int ret = 0;
-
-	if (devfs_only())
-		return 0;
-	index = major_to_index(major);
 
 	down_write(&block_subsys.rwsem);
 	for (n = &major_names[index]; *n; n = &(*n)->next)
--- 1.7/fs/char_dev.c	Fri Feb  7 01:20:33 2003
+++ edited/fs/char_dev.c	Mon Mar 10 20:22:35 2003
@@ -191,8 +191,6 @@
 
 int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
 {
-	if (devfs_only())
-		return 0;
 	if (major == 0) {
 		write_lock(&chrdevs_lock);
 		for (major = MAX_CHRDEV-1; major > 0; major--) {
@@ -221,8 +219,6 @@
 
 int unregister_chrdev(unsigned int major, const char * name)
 {
-	if (devfs_only())
-		return 0;
 	if (major >= MAX_CHRDEV)
 		return -EINVAL;
 	write_lock(&chrdevs_lock);
--- 1.71/fs/devfs/base.c	Tue Feb 25 19:47:06 2003
+++ edited/fs/devfs/base.c	Mon Mar 10 20:22:35 2003
@@ -729,7 +729,6 @@
 
 #define OPTION_NONE             0x00
 #define OPTION_MOUNT            0x01
-#define OPTION_ONLY             0x02
 
 #define PRINTK(format, args...) \
    {printk (KERN_ERR "%s" format, __FUNCTION__ , ## args);}
@@ -773,7 +772,6 @@
 {
     struct block_device_operations *ops;
     dev_t dev;
-    unsigned char autogen:1;
     unsigned char removable:1;
 };
 
@@ -938,8 +936,6 @@
     if ( S_ISLNK (de->mode) ) kfree (de->u.symlink.linkname);
     if ( S_ISCHR (de->mode) && de->u.cdev.autogen )
 	devfs_dealloc_devnum (de->mode, de->u.cdev.dev);
-    if ( S_ISBLK (de->mode) && de->u.bdev.autogen )
-	devfs_dealloc_devnum (de->mode, de->u.bdev.dev);
     WRITE_ENTRY_MAGIC (de, 0);
 #ifdef CONFIG_DEVFS_DEBUG
     spin_lock (&stat_lock);
@@ -1495,17 +1491,6 @@
 	PRINTK ("(%s): creating symlinks is not allowed\n", name);
 	return NULL;
     }
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
-    }
     if ( ( de = _devfs_prepare_leaf (&dir, name, mode) ) == NULL )
     {
 	PRINTK ("(%s): could not prepare leaf\n", name);
@@ -1870,18 +1855,6 @@
 
 
 /**
- *	devfs_only - returns true if "devfs=only" is a boot option
- *
- *	If "devfs=only" this function will return 1, otherwise 0 is returned.
- */
-
-int devfs_only (void)
-{
-    return (boot_options & OPTION_ONLY) ? 1 : 0;
-}   /*  End Function devfs_only  */
-
-
-/**
  *	devfs_setup - Process kernel boot options.
  *	@str: The boot options after the "devfs=".
  */
@@ -1909,7 +1882,6 @@
 	{"dilookup",  DEBUG_I_LOOKUP,     &devfs_debug_init},
 	{"diunlink",  DEBUG_I_UNLINK,     &devfs_debug_init},
 #endif  /*  CONFIG_DEVFS_DEBUG  */
-	{"only",      OPTION_ONLY,        &boot_options},
 	{"mount",     OPTION_MOUNT,       &boot_options},
 	{NULL,        0,                  NULL}
     };
===== include/linux/devfs_fs_kernel.h 1.28 vs edited =====
--- 1.28/include/linux/devfs_fs_kernel.h	Wed Jan 15 21:56:40 2003
+++ edited/include/linux/devfs_fs_kernel.h	Mon Mar 10 20:22:35 2003
@@ -13,8 +13,6 @@
 
 #define DEVFS_FL_NONE           0x000 /* This helps to make code more readable
 				       */
-#define DEVFS_FL_AUTO_DEVNUM    0x002 /* Automatically generate device number
-				       */
 #define DEVFS_FL_REMOVABLE      0x008 /* This is a removable media device    */
 #define DEVFS_FL_WAIT           0x010 /* Wait for devfsd to finish           */
 #define DEVFS_FL_CURRENT_OWNER  0x020 /* Set initial ownership to current    */
@@ -52,7 +50,6 @@
 				    void *info);
 extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
 extern int devfs_set_file_size (devfs_handle_t de, unsigned long size);
-extern int devfs_only (void);
 extern int devfs_register_tape (devfs_handle_t de);
 extern void devfs_unregister_tape(int num);
 extern int devfs_alloc_unique_number (struct unique_numspace *space);
@@ -110,10 +107,6 @@
 static inline int devfs_set_file_size (devfs_handle_t de, unsigned long size)
 {
     return -ENOSYS;
-}
-static inline int devfs_only (void)
-{
-    return 0;
 }
 static inline int devfs_register_tape (devfs_handle_t de)
 {
