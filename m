Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268972AbTCASke>; Sat, 1 Mar 2003 13:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268969AbTCASke>; Sat, 1 Mar 2003 13:40:34 -0500
Received: from verein.lst.de ([212.34.181.86]:32780 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S268972AbTCASkc>;
	Sat, 1 Mar 2003 13:40:32 -0500
Date: Sat, 1 Mar 2003 19:50:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove devfs_only()
Message-ID: <20030301195048.A2523@lst.de>
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
(And Viro had plans to make {un,}register_chrdev behave like
{un,}register_blkdev, so if he either returns or I managed to come up
with something similar the same will happen to it in 2.7)


--- 1.122/fs/block_dev.c	Wed Jan 15 15:51:33 2003
+++ edited/fs/block_dev.c	Sat Mar  1 18:44:36 2003
@@ -453,8 +453,6 @@
 
 int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
 {
-	if (devfs_only())
-		return 0;
 	if (major == 0) {
 		for (major = MAX_BLKDEV-1; major > 0; major--) {
 			if (blkdevs[major] == NULL) {
@@ -474,8 +472,6 @@
 
 int unregister_blkdev(unsigned int major, const char * name)
 {
-	if (devfs_only())
-		return 0;
 	if (major >= MAX_BLKDEV)
 		return -EINVAL;
 	if (!blkdevs[major])
--- 1.7/fs/char_dev.c	Thu Feb  6 19:20:33 2003
+++ edited/fs/char_dev.c	Sat Mar  1 18:44:44 2003
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
--- 1.71/fs/devfs/base.c	Tue Feb 25 13:47:06 2003
+++ edited/fs/devfs/base.c	Sat Mar  1 18:47:50 2003
@@ -729,7 +729,6 @@
 
 #define OPTION_NONE             0x00
 #define OPTION_MOUNT            0x01
-#define OPTION_ONLY             0x02
 
 #define PRINTK(format, args...) \
    {printk (KERN_ERR "%s" format, __FUNCTION__ , ## args);}
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
--- 1.28/include/linux/devfs_fs_kernel.h	Wed Jan 15 15:56:40 2003
+++ edited/include/linux/devfs_fs_kernel.h	Sat Mar  1 18:47:46 2003
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

