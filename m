Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262587AbTCRVvm>; Tue, 18 Mar 2003 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbTCRVvl>; Tue, 18 Mar 2003 16:51:41 -0500
Received: from hera.cwi.nl ([192.16.191.8]:22515 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262587AbTCRVvZ>;
	Tue, 18 Mar 2003 16:51:25 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 18 Mar 2003 23:02:21 +0100 (MET)
Message-Id: <UTC200303182202.h2IM2Lx00966.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] dev_t [2/3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The actual patch for today is this part. I already quoted
most of this on the list earlier this week.

In order not to have to change all drivers, I did

+int register_chrdev(unsigned int major, const char *name,
+                   struct file_operations *fops)
+{
+       return register_chrdev_region(major, 0, 256, name, fops);
+}

so that the old register_chrdev registers a single major
and 256 minors. Later this can be changed (but see my letter
to Al last week).

The only driver that is tricky is the tty driver.
Here some major cleanup happened - all tty specific stuff
disappeared from char_dev.c, and tty uses the actual
register_chrdev_region() call.

There is a race in register_chrdev_region() that I did not
worry about: when two dynamic majors 0 are registered
simultaneously, one of them will be first and the other one
gets -EBUSY. If this is a problem, the code there will have
to be uglified a little. I didn't do that because it disappears
again in a subsequent patch.

Andries

----------------- 02-chardev-patch ------------------

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/ip2/ip2.h b/drivers/char/ip2/ip2.h
--- a/drivers/char/ip2/ip2.h	Fri Nov 22 22:40:25 2002
+++ b/drivers/char/ip2/ip2.h	Tue Mar 18 21:35:32 2003
@@ -23,21 +23,10 @@
 /* Constants */
 /*************/
 
-/* Device major numbers
- * The first set are the major numbers allocated from the Linux Device Registry.
- * This was expanded from 64 to 128 with version 2.0.26. If this code is built
- * under earlier versions we use majors from the LOCAL/EXPERIMENTAL range.
- */
-#if MAX_CHRDEV > 64
-#	define IP2_TTY_MAJOR      71
-#	define IP2_CALLOUT_MAJOR  72
-#	define IP2_IPL_MAJOR      73
-#else
-#	define IP2_TTY_MAJOR      60
-#	define IP2_CALLOUT_MAJOR  61
-#	define IP2_IPL_MAJOR      62
-#endif
-
+/* Device major numbers - since version 2.0.26. */
+#define IP2_TTY_MAJOR      71
+#define IP2_CALLOUT_MAJOR  72
+#define IP2_IPL_MAJOR      73
 
 /* Board configuration array.
  * This array defines the hardware irq and address for up to IP2_MAX_BOARDS
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Mar 18 11:48:19 2003
+++ b/drivers/char/tty_io.c	Tue Mar 18 21:35:32 2003
@@ -2114,7 +2114,8 @@
 	if (driver->flags & TTY_DRIVER_INSTALLED)
 		return 0;
 
-	error = register_chrdev(driver->major, driver->name, &tty_fops);
+	error = register_chrdev_region(driver->major, driver->minor_start,
+				       driver->num, driver->name, &tty_fops);
 	if (error < 0)
 		return error;
 	else if(driver->major == 0)
diff -u --recursive --new-file -X /linux/dontdiff a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	Tue Mar 18 21:14:21 2003
+++ b/fs/char_dev.c	Tue Mar 18 21:35:32 2003
@@ -19,122 +19,183 @@
 
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#include <linux/tty.h>
-
-/* serial module kmod load support */
-struct tty_driver *get_tty_driver(kdev_t device);
-#define is_a_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
-#define need_serial(ma,mi) (get_tty_driver(mk_kdev(ma,mi)) == NULL)
 #endif
 
-struct device_struct {
-	const char * name;
-	struct file_operations * fops;
-};
+#define MAX_PROBE_HASH 255	/* random */
 
 static rwlock_t chrdevs_lock = RW_LOCK_UNLOCKED;
-static struct device_struct chrdevs[MAX_CHRDEV];
 
+static struct char_device_struct {
+	struct char_device_struct *next;
+	unsigned int major;
+	unsigned int baseminor;
+	int minorct;
+	const char *name;
+	struct file_operations *fops;
+} *chrdevs[MAX_PROBE_HASH];
+
+/* index in the above */
+static inline int major_to_index(int major)
+{
+	return major % MAX_PROBE_HASH;
+}
+
+/* get char device names in somewhat random order */
 int get_chrdev_list(char *page)
 {
-	int i;
-	int len;
+	struct char_device_struct *cd;
+	int i, len;
 
 	len = sprintf(page, "Character devices:\n");
+
 	read_lock(&chrdevs_lock);
-	for (i = 0; i < MAX_CHRDEV ; i++) {
-		if (chrdevs[i].fops) {
+	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
+		for (cd = chrdevs[i]; cd; cd = cd->next)
 			len += sprintf(page+len, "%3d %s\n",
-				       i, chrdevs[i].name);
-		}
+				       cd->major, cd->name);
 	}
 	read_unlock(&chrdevs_lock);
+
 	return len;
 }
 
 /*
- *	Return the function table of a device.
- *	Load the driver if needed.
- *	Increment the reference count of module in question.
+ * Return the function table of a device, if present.
+ * Increment the reference count of module in question.
  */
 static struct file_operations *
-get_chrfops(unsigned int major, unsigned int minor)
+lookup_chrfops(unsigned int major, unsigned int minor)
 {
-	struct file_operations *ret;
+	struct char_device_struct *cd;
+	struct file_operations *ret = NULL;
+	int i;
 
-	if (!major || major >= MAX_CHRDEV)
-		return NULL;
+	i = major_to_index(major);
 
 	read_lock(&chrdevs_lock);
-	ret = fops_get(chrdevs[major].fops);
-	read_unlock(&chrdevs_lock);
-#ifdef CONFIG_KMOD
-	if (ret && is_a_tty_dev(major)) {
-		lock_kernel();
-		if (need_serial(major,minor)) {
-			/* Force request_module anyway, but what for? */
-			/* The reason is that we may have a driver for
-			   /dev/tty1 already, but need one for /dev/ttyS1. */
-			fops_put(ret);
-			ret = NULL;
+	for (cd = chrdevs[i]; cd; cd = cd->next) {
+		if (major == cd->major &&
+		    minor - cd->baseminor < cd->minorct) {
+			ret = fops_get(cd->fops);
+			break;
 		}
-		unlock_kernel();
 	}
+	read_unlock(&chrdevs_lock);
+
+	return ret;
+}
+
+/*
+ * Return the function table of a device, if present.
+ * Load the driver if needed.
+ * Increment the reference count of module in question.
+ */
+static struct file_operations *
+get_chrfops(unsigned int major, unsigned int minor)
+{
+	struct file_operations *ret = NULL;
+
+	if (!major)
+		return NULL;
+
+	ret = lookup_chrfops(major, minor);
+
+#ifdef CONFIG_KMOD
 	if (!ret) {
-		char name[20];
+		char name[32];
 		sprintf(name, "char-major-%d", major);
 		request_module(name);
 
 		read_lock(&chrdevs_lock);
-		ret = fops_get(chrdevs[major].fops);
+		ret = lookup_chrfops(major, minor);
 		read_unlock(&chrdevs_lock);
 	}
 #endif
 	return ret;
 }
 
-int register_chrdev(unsigned int major, const char *name,
-		    struct file_operations *fops)
+/*
+ * Register a single major with a specified minor range
+ */
+int register_chrdev_region(unsigned int major, unsigned int baseminor,
+			   int minorct, const char *name,
+			   struct file_operations *fops)
 {
+	struct char_device_struct *cd, **cp;
+	int ret = 0;
+	int i;
+
+	/* temporary */
 	if (major == 0) {
-		write_lock(&chrdevs_lock);
-		for (major = MAX_CHRDEV-1; major > 0; major--) {
-			if (chrdevs[major].fops == NULL) {
-				chrdevs[major].name = name;
-				chrdevs[major].fops = fops;
-				write_unlock(&chrdevs_lock);
-				return major;
-			}
-		}
-		write_unlock(&chrdevs_lock);
-		return -EBUSY;
-	}
-	if (major >= MAX_CHRDEV)
-		return -EINVAL;
+		read_lock(&chrdevs_lock);
+		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--)
+			if (chrdevs[i] == NULL)
+				break;
+		read_unlock(&chrdevs_lock);
+
+		if (i == 0)
+			return -EBUSY;
+		ret = major = i;
+	}
+
+	cd = kmalloc(sizeof(struct char_device_struct), GFP_KERNEL);
+	if (cd == NULL)
+		return -ENOMEM;
+
+	cd->major = major;
+	cd->baseminor = baseminor;
+	cd->minorct = minorct;
+	cd->name = name;
+	cd->fops = fops;
+
+	i = major_to_index(major);
+
 	write_lock(&chrdevs_lock);
-	if (chrdevs[major].fops && chrdevs[major].fops != fops) {
-		write_unlock(&chrdevs_lock);
-		return -EBUSY;
+	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
+		if ((*cp)->major > major ||
+		    ((*cp)->major == major && (*cp)->baseminor >= baseminor))
+			break;
+	if (*cp && (*cp)->major == major &&
+	    (*cp)->baseminor < baseminor + minorct) {
+		ret = -EBUSY;
+	} else {
+		cd->next = *cp;
+		*cp = cd;
 	}
-	chrdevs[major].name = name;
-	chrdevs[major].fops = fops;
 	write_unlock(&chrdevs_lock);
-	return 0;
+
+	return ret;
 }
 
+int register_chrdev(unsigned int major, const char *name,
+		    struct file_operations *fops)
+{
+	return register_chrdev_region(major, 0, 256, name, fops);
+}
+
+/* todo: make void - error printk here */
 int unregister_chrdev(unsigned int major, const char * name)
 {
-	if (major >= MAX_CHRDEV)
-		return -EINVAL;
+	struct char_device_struct *cd, **cp;
+	int ret = 0;
+	int i;
+
+	i = major_to_index(major);
+
 	write_lock(&chrdevs_lock);
-	if (!chrdevs[major].fops || strcmp(chrdevs[major].name, name)) {
-		write_unlock(&chrdevs_lock);
-		return -EINVAL;
+	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
+		if ((*cp)->major == major)
+			break;
+	if (!*cp || strcmp((*cp)->name, name))
+		ret = -EINVAL;
+	else {
+		cd = *cp;
+		*cp = cd->next;
+		kfree(cd);
 	}
-	chrdevs[major].name = NULL;
-	chrdevs[major].fops = NULL;
 	write_unlock(&chrdevs_lock);
-	return 0;
+
+	return ret;
 }
 
 /*
@@ -165,13 +226,23 @@
 	.open = chrdev_open,
 };
 
-const char * cdevname(kdev_t dev)
+const char *cdevname(kdev_t dev)
 {
-	static char buffer[32];
-	const char * name = chrdevs[major(dev)].name;
+	static char buffer[40];
+	const char *name = "unknown-char";
+	unsigned int major = major(dev);
+	unsigned int minor = minor(dev);
+	int i = major_to_index(major);
+	struct char_device_struct *cd;
+
+	read_lock(&chrdevs_lock);
+	for (cd = chrdevs[i]; cd; cd = cd->next)
+		if (cd->major == major)
+			break;
+	if (cd)
+		name = cd->name;
+	sprintf(buffer, "%s(%d,%d)", name, major, minor);
+	read_unlock(&chrdevs_lock);
 
-	if (!name)
-		name = "unknown-char";
-	sprintf(buffer, "%s(%d,%d)", name, major(dev), minor(dev));
 	return buffer;
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Tue Mar 18 21:14:48 2003
+++ b/fs/inode.c	Tue Mar 18 21:35:32 2003
@@ -145,7 +145,7 @@
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 		if (sb->s_bdev)
-			inode->i_data.backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
+			mapping->backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
 		inode->i_mapping = mapping;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Tue Mar 18 21:14:21 2003
+++ b/include/linux/fs.h	Tue Mar 18 21:35:32 2003
@@ -1053,7 +1053,10 @@
 extern void blk_run_queues(void);
 
 /* fs/char_dev.c */
-extern int register_chrdev(unsigned int, const char *, struct file_operations *);
+extern int register_chrdev_region(unsigned int, unsigned int, int,
+				  const char *, struct file_operations *);
+extern int register_chrdev(unsigned int, const char *,
+			   struct file_operations *);
 extern int unregister_chrdev(unsigned int, const char *);
 extern int chrdev_open(struct inode *, struct file *);
 

