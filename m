Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318439AbSGaSdR>; Wed, 31 Jul 2002 14:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318440AbSGaSdR>; Wed, 31 Jul 2002 14:33:17 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:63495 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318439AbSGaSdO>;
	Wed, 31 Jul 2002 14:33:14 -0400
Date: Wed, 31 Jul 2002 11:35:08 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29 - take 2
Message-ID: <20020731183508.GB21793@kroah.com>
References: <20020731183358.GA21793@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731183358.GA21793@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 03 Jul 2002 17:31:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here's the additional patch that I made on top of the previous two I
sent to the list yesterday:


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.545   -> 1.546  
#	     fs/devfs/base.c	1.47    -> 1.48   
#	        fs/devices.c	1.8     -> 1.9    
#	include/linux/devfs_fs_kernel.h	1.14    -> 1.15   
#	      fs/block_dev.c	1.76    -> 1.77   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/30	greg@kroah.com	1.546
# Remove the devfs_should* functions I added, and replace them with one devfs_only() call
# 
# This now explains what is really going on much better than before.
# --------------------------------------------
#
diff -Nru a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	Wed Jul 31 11:23:15 2002
+++ b/fs/block_dev.c	Wed Jul 31 11:23:15 2002
@@ -453,7 +453,7 @@
 
 int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
 {
-	if (devfs_should_register_blkdev())
+	if (devfs_only())
 		return 0;
 	if (major == 0) {
 		for (major = MAX_BLKDEV-1; major > 0; major--) {
@@ -476,7 +476,7 @@
 
 int unregister_blkdev(unsigned int major, const char * name)
 {
-	if (devfs_should_unregister_blkdev())
+	if (devfs_only())
 		return 0;
 	if (major >= MAX_BLKDEV)
 		return -EINVAL;
diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Wed Jul 31 11:23:15 2002
+++ b/fs/devfs/base.c	Wed Jul 31 11:23:15 2002
@@ -2228,59 +2228,17 @@
 
 
 /**
- *	devfs_should_register_chrdev - should we register a conventional character driver.
+ *	devfs_only - returns if "devfs=only" is a boot option
  *
- *	If "devfs=only" this function will return -1, otherwise 0 is returned.
+ *	If "devfs=only" this function will return 1, otherwise 0 is returned.
  */
-int devfs_should_register_chrdev (void)
+int devfs_only (void)
 {
     if (boot_options & OPTION_ONLY)
-	    return -1;
+	    return 1;
     return 0;
 }
 
-
-/**
- *	devfs_should_register_blkdev - should we register a conventional block driver.
- *
- *	If the "devfs=only" option was provided at boot time, this function will
- *	return -1, otherwise 0 is returned.
- */
-
-int devfs_should_register_blkdev (void)
-{
-    if (boot_options & OPTION_ONLY)
-	    return -1;
-    return 0;
-}
-
-
-/**
- *	devfs_should_unregister_chrdev - should we unregister a conventional character driver.
- *
- *	If "devfs=only" this function will return -1, otherwise 0 is returned
- */
-int devfs_should_unregister_chrdev (void)
-{
-    if (boot_options & OPTION_ONLY)
-	    return -1;
-    return 0;
-}
-
-
-/**
- *	devfs_should_unregister_blkdev - should we unregister a conventional block driver.
- *
- *	If the "devfs=only" option was provided at boot time, this function will
- *	return -1, otherwise 0 is returned.
- */
-
-int devfs_should_unregister_blkdev (void)
-{
-    if (boot_options & OPTION_ONLY)
-	    return -1;
-    return 0;
-}
 
 /**
  *	devfs_setup - Process kernel boot options.
diff -Nru a/fs/devices.c b/fs/devices.c
--- a/fs/devices.c	Wed Jul 31 11:23:15 2002
+++ b/fs/devices.c	Wed Jul 31 11:23:15 2002
@@ -98,7 +98,7 @@
 
 int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
 {
-	if (devfs_should_register_chrdev())
+	if (devfs_only())
 		return 0;
 	if (major == 0) {
 		write_lock(&chrdevs_lock);
@@ -128,7 +128,7 @@
 
 int unregister_chrdev(unsigned int major, const char * name)
 {
-	if (devfs_should_register_chrdev())
+	if (devfs_only())
 		return 0;
 	if (major >= MAX_CHRDEV)
 		return -EINVAL;
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Wed Jul 31 11:23:15 2002
+++ b/include/linux/devfs_fs_kernel.h	Wed Jul 31 11:23:15 2002
@@ -94,10 +94,7 @@
 extern void devfs_auto_unregister (devfs_handle_t master,devfs_handle_t slave);
 extern devfs_handle_t devfs_get_unregister_slave (devfs_handle_t master);
 extern const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen);
-extern int devfs_should_register_chrdev (void);
-extern int devfs_should_register_blkdev (void);
-extern int devfs_should_unregister_chrdev (void);
-extern int devfs_should_unregister_blkdev (void);
+extern int devfs_only (void);
 
 extern void devfs_register_tape (devfs_handle_t de);
 extern void devfs_register_series (devfs_handle_t dir, const char *format,
@@ -237,19 +234,7 @@
 {
     return NULL;
 }
-static inline int devfs_should_register_chrdev (void)
-{
-    return 0;
-}
-static inline int devfs_should_register_blkdev (void)
-{
-    return 0;
-}
-static inline int devfs_should_unregister_chrdev (void)
-{
-    return 0;
-}
-static inline int devfs_should_unregister_blkdev (void)
+static inline int devfs_only (void)
 {
     return 0;
 }
