Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262643AbTCYNnf>; Tue, 25 Mar 2003 08:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbTCYNnf>; Tue, 25 Mar 2003 08:43:35 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:25609 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262643AbTCYNnX>; Tue, 25 Mar 2003 08:43:23 -0500
Date: Tue, 25 Mar 2003 14:54:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] revert register_chrdev_region change
Message-ID: <Pine.LNX.4.44.0303251452290.16739-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes Andries dev patch, which was unfortunately merged.
It doesn't really help to manage a large number of character devices
and I still don't know what this patch is good for.

bye, Roman

diff -pur -X /home/devel/roman/nodiff linux-2.5.66/drivers/char/tty_io.c linux-2.5.66-cdev1/drivers/char/tty_io.c
--- linux-2.5.66/drivers/char/tty_io.c	2003-03-25 10:46:27.000000000 +0100
+++ linux-2.5.66-cdev1/drivers/char/tty_io.c	2003-03-25 11:02:13.000000000 +0100
@@ -2118,8 +2118,7 @@ int tty_register_driver(struct tty_drive
 	if (driver->flags & TTY_DRIVER_INSTALLED)
 		return 0;
 
-	error = register_chrdev_region(driver->major, driver->minor_start,
-				       driver->num, driver->name, &tty_fops);
+	error = register_chrdev(driver->major, driver->name, &tty_fops);
 	if (error < 0)
 		return error;
 	else if(driver->major == 0)
diff -pur -X /home/devel/roman/nodiff linux-2.5.66/fs/char_dev.c linux-2.5.66-cdev1/fs/char_dev.c
--- linux-2.5.66/fs/char_dev.c	2003-03-25 10:47:05.000000000 +0100
+++ linux-2.5.66-cdev1/fs/char_dev.c	2003-03-25 11:02:13.000000000 +0100
@@ -19,183 +19,122 @@
 
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
+#include <linux/tty.h>
+
+/* serial module kmod load support */
+struct tty_driver *get_tty_driver(kdev_t device);
+#define is_a_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
+#define need_serial(ma,mi) (get_tty_driver(mk_kdev(ma,mi)) == NULL)
 #endif
 
-#define MAX_PROBE_HASH 255	/* random */
+struct device_struct {
+	const char * name;
+	struct file_operations * fops;
+};
 
 static rwlock_t chrdevs_lock = RW_LOCK_UNLOCKED;
+static struct device_struct chrdevs[MAX_CHRDEV];
 
-static struct char_device_struct {
-	struct char_device_struct *next;
-	unsigned int major;
-	unsigned int baseminor;
-	int minorct;
-	const char *name;
-	struct file_operations *fops;
-} *chrdevs[MAX_PROBE_HASH];
-
-/* index in the above */
-static inline int major_to_index(int major)
-{
-	return major % MAX_PROBE_HASH;
-}
-
-/* get char device names in somewhat random order */
 int get_chrdev_list(char *page)
 {
-	struct char_device_struct *cd;
-	int i, len;
+	int i;
+	int len;
 
 	len = sprintf(page, "Character devices:\n");
-
 	read_lock(&chrdevs_lock);
-	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
-		for (cd = chrdevs[i]; cd; cd = cd->next)
+	for (i = 0; i < MAX_CHRDEV ; i++) {
+		if (chrdevs[i].fops) {
 			len += sprintf(page+len, "%3d %s\n",
-				       cd->major, cd->name);
-	}
-	read_unlock(&chrdevs_lock);
-
-	return len;
-}
-
-/*
- * Return the function table of a device, if present.
- * Increment the reference count of module in question.
- */
-static struct file_operations *
-lookup_chrfops(unsigned int major, unsigned int minor)
-{
-	struct char_device_struct *cd;
-	struct file_operations *ret = NULL;
-	int i;
-
-	i = major_to_index(major);
-
-	read_lock(&chrdevs_lock);
-	for (cd = chrdevs[i]; cd; cd = cd->next) {
-		if (major == cd->major &&
-		    minor - cd->baseminor < cd->minorct) {
-			ret = fops_get(cd->fops);
-			break;
+				       i, chrdevs[i].name);
 		}
 	}
 	read_unlock(&chrdevs_lock);
-
-	return ret;
+	return len;
 }
 
 /*
- * Return the function table of a device, if present.
- * Load the driver if needed.
- * Increment the reference count of module in question.
+ *	Return the function table of a device.
+ *	Load the driver if needed.
+ *	Increment the reference count of module in question.
  */
 static struct file_operations *
 get_chrfops(unsigned int major, unsigned int minor)
 {
-	struct file_operations *ret = NULL;
+	struct file_operations *ret;
 
-	if (!major)
+	if (!major || major >= MAX_CHRDEV)
 		return NULL;
 
-	ret = lookup_chrfops(major, minor);
-
+	read_lock(&chrdevs_lock);
+	ret = fops_get(chrdevs[major].fops);
+	read_unlock(&chrdevs_lock);
 #ifdef CONFIG_KMOD
+	if (ret && is_a_tty_dev(major)) {
+		lock_kernel();
+		if (need_serial(major,minor)) {
+			/* Force request_module anyway, but what for? */
+			/* The reason is that we may have a driver for
+			   /dev/tty1 already, but need one for /dev/ttyS1. */
+			fops_put(ret);
+			ret = NULL;
+		}
+		unlock_kernel();
+	}
 	if (!ret) {
-		char name[32];
+		char name[20];
 		sprintf(name, "char-major-%d", major);
 		request_module(name);
 
 		read_lock(&chrdevs_lock);
-		ret = lookup_chrfops(major, minor);
+		ret = fops_get(chrdevs[major].fops);
 		read_unlock(&chrdevs_lock);
 	}
 #endif
 	return ret;
 }
 
-/*
- * Register a single major with a specified minor range
- */
-int register_chrdev_region(unsigned int major, unsigned int baseminor,
-			   int minorct, const char *name,
-			   struct file_operations *fops)
+int register_chrdev(unsigned int major, const char *name,
+		    struct file_operations *fops)
 {
-	struct char_device_struct *cd, **cp;
-	int ret = 0;
-	int i;
-
-	/* temporary */
 	if (major == 0) {
-		read_lock(&chrdevs_lock);
-		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--)
-			if (chrdevs[i] == NULL)
-				break;
-		read_unlock(&chrdevs_lock);
-
-		if (i == 0)
-			return -EBUSY;
-		ret = major = i;
-	}
-
-	cd = kmalloc(sizeof(struct char_device_struct), GFP_KERNEL);
-	if (cd == NULL)
-		return -ENOMEM;
-
-	cd->major = major;
-	cd->baseminor = baseminor;
-	cd->minorct = minorct;
-	cd->name = name;
-	cd->fops = fops;
-
-	i = major_to_index(major);
-
+		write_lock(&chrdevs_lock);
+		for (major = MAX_CHRDEV-1; major > 0; major--) {
+			if (chrdevs[major].fops == NULL) {
+				chrdevs[major].name = name;
+				chrdevs[major].fops = fops;
+				write_unlock(&chrdevs_lock);
+				return major;
+			}
+		}
+		write_unlock(&chrdevs_lock);
+		return -EBUSY;
+	}
+	if (major >= MAX_CHRDEV)
+		return -EINVAL;
 	write_lock(&chrdevs_lock);
-	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
-		if ((*cp)->major > major ||
-		    ((*cp)->major == major && (*cp)->baseminor >= baseminor))
-			break;
-	if (*cp && (*cp)->major == major &&
-	    (*cp)->baseminor < baseminor + minorct) {
-		ret = -EBUSY;
-	} else {
-		cd->next = *cp;
-		*cp = cd;
+	if (chrdevs[major].fops && chrdevs[major].fops != fops) {
+		write_unlock(&chrdevs_lock);
+		return -EBUSY;
 	}
+	chrdevs[major].name = name;
+	chrdevs[major].fops = fops;
 	write_unlock(&chrdevs_lock);
-
-	return ret;
+	return 0;
 }
 
-int register_chrdev(unsigned int major, const char *name,
-		    struct file_operations *fops)
-{
-	return register_chrdev_region(major, 0, 256, name, fops);
-}
-
-/* todo: make void - error printk here */
 int unregister_chrdev(unsigned int major, const char * name)
 {
-	struct char_device_struct *cd, **cp;
-	int ret = 0;
-	int i;
-
-	i = major_to_index(major);
-
+	if (major >= MAX_CHRDEV)
+		return -EINVAL;
 	write_lock(&chrdevs_lock);
-	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
-		if ((*cp)->major == major)
-			break;
-	if (!*cp || strcmp((*cp)->name, name))
-		ret = -EINVAL;
-	else {
-		cd = *cp;
-		*cp = cd->next;
-		kfree(cd);
+	if (!chrdevs[major].fops || strcmp(chrdevs[major].name, name)) {
+		write_unlock(&chrdevs_lock);
+		return -EINVAL;
 	}
+	chrdevs[major].name = NULL;
+	chrdevs[major].fops = NULL;
 	write_unlock(&chrdevs_lock);
-
-	return ret;
+	return 0;
 }
 
 /*
@@ -229,20 +168,10 @@ struct file_operations def_chr_fops = {
 const char *cdevname(kdev_t dev)
 {
 	static char buffer[40];
-	const char *name = "unknown-char";
-	unsigned int major = major(dev);
-	unsigned int minor = minor(dev);
-	int i = major_to_index(major);
-	struct char_device_struct *cd;
-
-	read_lock(&chrdevs_lock);
-	for (cd = chrdevs[i]; cd; cd = cd->next)
-		if (cd->major == major)
-			break;
-	if (cd)
-		name = cd->name;
-	sprintf(buffer, "%s(%d,%d)", name, major, minor);
-	read_unlock(&chrdevs_lock);
+	const char * name = chrdevs[major(dev)].name;
 
+	if (!name)
+		name = "unknown-char";
+	sprintf(buffer, "%s(%d,%d)", name, major(dev), minor(dev));
 	return buffer;
 }
diff -pur -X /home/devel/roman/nodiff linux-2.5.66/fs/inode.c linux-2.5.66-cdev1/fs/inode.c
--- linux-2.5.66/fs/inode.c	2003-03-25 10:47:05.000000000 +0100
+++ linux-2.5.66-cdev1/fs/inode.c	2003-03-25 11:02:13.000000000 +0100
@@ -145,7 +145,7 @@ static struct inode *alloc_inode(struct 
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 		if (sb->s_bdev)
-			mapping->backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
+			inode->i_data.backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
 		inode->i_mapping = mapping;
 	}
diff -pur -X /home/devel/roman/nodiff linux-2.5.66/include/linux/fs.h linux-2.5.66-cdev1/include/linux/fs.h
--- linux-2.5.66/include/linux/fs.h	2003-03-25 10:48:20.000000000 +0100
+++ linux-2.5.66-cdev1/include/linux/fs.h	2003-03-25 11:02:13.000000000 +0100
@@ -1055,10 +1055,7 @@ extern void bd_release(struct block_devi
 extern void blk_run_queues(void);
 
 /* fs/char_dev.c */
-extern int register_chrdev_region(unsigned int, unsigned int, int,
-				  const char *, struct file_operations *);
-extern int register_chrdev(unsigned int, const char *,
-			   struct file_operations *);
+extern int register_chrdev(unsigned int, const char *, struct file_operations *);
 extern int unregister_chrdev(unsigned int, const char *);
 extern int chrdev_open(struct inode *, struct file *);
 
diff -pur -X /home/devel/roman/nodiff linux-2.5.66/include/linux/major.h linux-2.5.66-cdev1/include/linux/major.h
--- linux-2.5.66/include/linux/major.h	2003-03-25 10:48:21.000000000 +0100
+++ linux-2.5.66-cdev1/include/linux/major.h	2003-03-25 11:02:13.000000000 +0100
@@ -160,6 +160,13 @@
 #define IBM_FS3270_MAJOR	228
 
 /*
+ * Important: Don't change this to 256.  Major number 255 is and must be
+ * reserved for future expansion into a larger dev_t space.
+ */
+#define MAX_CHRDEV		255
+#define MAX_BLKDEV		255
+
+/*
  * Tests for SCSI devices.
  */
 

