Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSKRNu1>; Mon, 18 Nov 2002 08:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSKRNu0>; Mon, 18 Nov 2002 08:50:26 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:56743 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S262486AbSKRNuM>; Mon, 18 Nov 2002 08:50:12 -0500
Message-ID: <3DD8F1A7.9000500@quark.didntduck.org>
Date: Mon, 18 Nov 2002 08:56:55 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] break up fs/devices.c
Content-Type: multipart/mixed;
 boundary="------------070607060808080200040109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607060808080200040109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Resend against 2.5.48

This patch breaks up and removes fs/devices.c:
Character device functions -> char_dev.c
init_special_inode() -> inode.c
kdevname() -> libfs.c

--
				Brian Gerst

--------------070607060808080200040109
Content-Type: text/plain;
 name="devices-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devices-2"

diff -urN linux-2.5.48/fs/Makefile linux/fs/Makefile
--- linux-2.5.48/fs/Makefile	Sun Nov 17 21:16:06 2002
+++ linux/fs/Makefile	Mon Nov 18 08:49:37 2002
@@ -8,7 +8,7 @@
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
                 fcntl.o read_write.o dcookies.o mbcache.o posix_acl.o xattr_acl.o
 
-obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
+obj-y :=	open.o read_write.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
diff -urN linux-2.5.48/fs/char_dev.c linux/fs/char_dev.c
--- linux-2.5.48/fs/char_dev.c	Sun Nov 17 23:43:29 2002
+++ linux/fs/char_dev.c	Mon Nov 18 08:49:37 2002
@@ -10,6 +10,23 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
+
+#ifdef CONFIG_KMOD
+#include <linux/kmod.h>
+#include <linux/tty.h>
+
+/* serial module kmod load support */
+struct tty_driver *get_tty_driver(kdev_t device);
+#define isa_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
+#define need_serial(ma,mi) (get_tty_driver(mk_kdev(ma,mi)) == NULL)
+#endif
+
 #define HASH_BITS	6
 #define HASH_SIZE	(1UL << HASH_BITS)
 #define HASH_MASK	(HASH_SIZE-1)
@@ -113,3 +130,150 @@
 	}
 }
 
+struct device_struct {
+	const char * name;
+	struct file_operations * fops;
+};
+
+static rwlock_t chrdevs_lock = RW_LOCK_UNLOCKED;
+static struct device_struct chrdevs[MAX_CHRDEV];
+
+int get_chrdev_list(char *page)
+{
+	int i;
+	int len;
+
+	len = sprintf(page, "Character devices:\n");
+	read_lock(&chrdevs_lock);
+	for (i = 0; i < MAX_CHRDEV ; i++) {
+		if (chrdevs[i].fops) {
+			len += sprintf(page+len, "%3d %s\n", i, chrdevs[i].name);
+		}
+	}
+	read_unlock(&chrdevs_lock);
+	return len;
+}
+
+/*
+	Return the function table of a device.
+	Load the driver if needed.
+	Increment the reference count of module in question.
+*/
+static struct file_operations * get_chrfops(unsigned int major, unsigned int minor)
+{
+	struct file_operations *ret = NULL;
+
+	if (!major || major >= MAX_CHRDEV)
+		return NULL;
+
+	read_lock(&chrdevs_lock);
+	ret = fops_get(chrdevs[major].fops);
+	read_unlock(&chrdevs_lock);
+#ifdef CONFIG_KMOD
+	if (ret && isa_tty_dev(major)) {
+		lock_kernel();
+		if (need_serial(major,minor)) {
+			/* Force request_module anyway, but what for? */
+			fops_put(ret);
+			ret = NULL;
+		}
+		unlock_kernel();
+	}
+	if (!ret) {
+		char name[20];
+		sprintf(name, "char-major-%d", major);
+		request_module(name);
+
+		read_lock(&chrdevs_lock);
+		ret = fops_get(chrdevs[major].fops);
+		read_unlock(&chrdevs_lock);
+	}
+#endif
+	return ret;
+}
+
+int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
+{
+	if (devfs_only())
+		return 0;
+	if (major == 0) {
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
+	write_lock(&chrdevs_lock);
+	if (chrdevs[major].fops && chrdevs[major].fops != fops) {
+		write_unlock(&chrdevs_lock);
+		return -EBUSY;
+	}
+	chrdevs[major].name = name;
+	chrdevs[major].fops = fops;
+	write_unlock(&chrdevs_lock);
+	return 0;
+}
+
+int unregister_chrdev(unsigned int major, const char * name)
+{
+	if (devfs_only())
+		return 0;
+	if (major >= MAX_CHRDEV)
+		return -EINVAL;
+	write_lock(&chrdevs_lock);
+	if (!chrdevs[major].fops || strcmp(chrdevs[major].name, name)) {
+		write_unlock(&chrdevs_lock);
+		return -EINVAL;
+	}
+	chrdevs[major].name = NULL;
+	chrdevs[major].fops = NULL;
+	write_unlock(&chrdevs_lock);
+	return 0;
+}
+
+/*
+ * Called every time a character special file is opened
+ */
+int chrdev_open(struct inode * inode, struct file * filp)
+{
+	int ret = -ENODEV;
+
+	filp->f_op = get_chrfops(major(inode->i_rdev), minor(inode->i_rdev));
+	if (filp->f_op) {
+		ret = 0;
+		if (filp->f_op->open != NULL) {
+			lock_kernel();
+			ret = filp->f_op->open(inode,filp);
+			unlock_kernel();
+		}
+	}
+	return ret;
+}
+
+/*
+ * Dummy default file-operations: the only thing this does
+ * is contain the open that then fills in the correct operations
+ * depending on the special file...
+ */
+struct file_operations def_chr_fops = {
+	.open		= chrdev_open,
+};
+
+const char * cdevname(kdev_t dev)
+{
+	static char buffer[32];
+	const char * name = chrdevs[major(dev)].name;
+
+	if (!name)
+		name = "unknown-char";
+	sprintf(buffer, "%s(%d,%d)", name, major(dev), minor(dev));
+	return buffer;
+}
diff -urN linux-2.5.48/fs/devices.c linux/fs/devices.c
--- linux-2.5.48/fs/devices.c	Sun Nov 17 21:15:43 2002
+++ linux/fs/devices.c	Wed Dec 31 19:00:00 1969
@@ -1,221 +0,0 @@
-/*
- *  linux/fs/devices.c
- *
- * (C) 1993 Matthias Urlichs -- collected common code and tables.
- * 
- *  Copyright (C) 1991, 1992  Linus Torvalds
- *
- *  Added kerneld support: Jacques Gelinas and Bjorn Ekwall
- *  (changed to kmod)
- */
-
-#include <linux/config.h>
-#include <linux/fs.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/time.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-
-#include <linux/tty.h>
-
-/* serial module kmod load support */
-struct tty_driver *get_tty_driver(kdev_t device);
-#define isa_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
-#define need_serial(ma,mi) (get_tty_driver(mk_kdev(ma,mi)) == NULL)
-#endif
-
-struct device_struct {
-	const char * name;
-	struct file_operations * fops;
-};
-
-static rwlock_t chrdevs_lock = RW_LOCK_UNLOCKED;
-static struct device_struct chrdevs[MAX_CHRDEV];
-
-extern int get_blkdev_list(char *);
-
-int get_device_list(char * page)
-{
-	int i;
-	int len;
-
-	len = sprintf(page, "Character devices:\n");
-	read_lock(&chrdevs_lock);
-	for (i = 0; i < MAX_CHRDEV ; i++) {
-		if (chrdevs[i].fops) {
-			len += sprintf(page+len, "%3d %s\n", i, chrdevs[i].name);
-		}
-	}
-	read_unlock(&chrdevs_lock);
-	len += get_blkdev_list(page+len);
-	return len;
-}
-
-/*
-	Return the function table of a device.
-	Load the driver if needed.
-	Increment the reference count of module in question.
-*/
-static struct file_operations * get_chrfops(unsigned int major, unsigned int minor)
-{
-	struct file_operations *ret = NULL;
-
-	if (!major || major >= MAX_CHRDEV)
-		return NULL;
-
-	read_lock(&chrdevs_lock);
-	ret = fops_get(chrdevs[major].fops);
-	read_unlock(&chrdevs_lock);
-#ifdef CONFIG_KMOD
-	if (ret && isa_tty_dev(major)) {
-		lock_kernel();
-		if (need_serial(major,minor)) {
-			/* Force request_module anyway, but what for? */
-			fops_put(ret);
-			ret = NULL;
-		}
-		unlock_kernel();
-	}
-	if (!ret) {
-		char name[20];
-		sprintf(name, "char-major-%d", major);
-		request_module(name);
-
-		read_lock(&chrdevs_lock);
-		ret = fops_get(chrdevs[major].fops);
-		read_unlock(&chrdevs_lock);
-	}
-#endif
-	return ret;
-}
-
-int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
-{
-	if (devfs_only())
-		return 0;
-	if (major == 0) {
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
-	write_lock(&chrdevs_lock);
-	if (chrdevs[major].fops && chrdevs[major].fops != fops) {
-		write_unlock(&chrdevs_lock);
-		return -EBUSY;
-	}
-	chrdevs[major].name = name;
-	chrdevs[major].fops = fops;
-	write_unlock(&chrdevs_lock);
-	return 0;
-}
-
-int unregister_chrdev(unsigned int major, const char * name)
-{
-	if (devfs_only())
-		return 0;
-	if (major >= MAX_CHRDEV)
-		return -EINVAL;
-	write_lock(&chrdevs_lock);
-	if (!chrdevs[major].fops || strcmp(chrdevs[major].name, name)) {
-		write_unlock(&chrdevs_lock);
-		return -EINVAL;
-	}
-	chrdevs[major].name = NULL;
-	chrdevs[major].fops = NULL;
-	write_unlock(&chrdevs_lock);
-	return 0;
-}
-
-/*
- * Called every time a character special file is opened
- */
-int chrdev_open(struct inode * inode, struct file * filp)
-{
-	int ret = -ENODEV;
-
-	filp->f_op = get_chrfops(major(inode->i_rdev), minor(inode->i_rdev));
-	if (filp->f_op) {
-		ret = 0;
-		if (filp->f_op->open != NULL) {
-			lock_kernel();
-			ret = filp->f_op->open(inode,filp);
-			unlock_kernel();
-		}
-	}
-	return ret;
-}
-
-/*
- * Dummy default file-operations: the only thing this does
- * is contain the open that then fills in the correct operations
- * depending on the special file...
- */
-static struct file_operations def_chr_fops = {
-	.open		= chrdev_open,
-};
-
-/*
- * Print device name (in decimal, hexadecimal or symbolic)
- * Note: returns pointer to static data!
- */
-const char * kdevname(kdev_t dev)
-{
-	static char buffer[32];
-	sprintf(buffer, "%02x:%02x", major(dev), minor(dev));
-	return buffer;
-}
-
-const char * cdevname(kdev_t dev)
-{
-	static char buffer[32];
-	const char * name = chrdevs[major(dev)].name;
-
-	if (!name)
-		name = "unknown-char";
-	sprintf(buffer, "%s(%d,%d)", name, major(dev), minor(dev));
-	return buffer;
-}
-  
-static int sock_no_open(struct inode *irrelevant, struct file *dontcare)
-{
-	return -ENXIO;
-}
-
-static struct file_operations bad_sock_fops = {
-	.open		= sock_no_open
-};
-
-void init_special_inode(struct inode *inode, umode_t mode, int rdev)
-{
-	inode->i_mode = mode;
-	if (S_ISCHR(mode)) {
-		inode->i_fop = &def_chr_fops;
-		inode->i_rdev = to_kdev_t(rdev);
-		inode->i_cdev = cdget(rdev);
-	} else if (S_ISBLK(mode)) {
-		inode->i_fop = &def_blk_fops;
-		inode->i_rdev = to_kdev_t(rdev);
-	} else if (S_ISFIFO(mode))
-		inode->i_fop = &def_fifo_fops;
-	else if (S_ISSOCK(mode))
-		inode->i_fop = &bad_sock_fops;
-	else
-		printk(KERN_DEBUG "init_special_inode: bogus imode (%o)\n", mode);
-}
diff -urN linux-2.5.48/fs/inode.c linux/fs/inode.c
--- linux-2.5.48/fs/inode.c	Sun Nov 17 23:43:29 2002
+++ linux/fs/inode.c	Mon Nov 18 08:49:37 2002
@@ -1270,3 +1270,30 @@
 
 	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
 }
+
+static int sock_no_open(struct inode *irrelevant, struct file *dontcare)
+{
+	return -ENXIO;
+}
+
+static struct file_operations bad_sock_fops = {
+	.open		= sock_no_open
+};
+
+void init_special_inode(struct inode *inode, umode_t mode, int rdev)
+{
+	inode->i_mode = mode;
+	if (S_ISCHR(mode)) {
+		inode->i_fop = &def_chr_fops;
+		inode->i_rdev = to_kdev_t(rdev);
+		inode->i_cdev = cdget(rdev);
+	} else if (S_ISBLK(mode)) {
+		inode->i_fop = &def_blk_fops;
+		inode->i_rdev = to_kdev_t(rdev);
+	} else if (S_ISFIFO(mode))
+		inode->i_fop = &def_fifo_fops;
+	else if (S_ISSOCK(mode))
+		inode->i_fop = &bad_sock_fops;
+	else
+		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o)\n", mode);
+}
diff -urN linux-2.5.48/fs/libfs.c linux/fs/libfs.c
--- linux-2.5.48/fs/libfs.c	Sun Nov 17 21:16:04 2002
+++ linux/fs/libfs.c	Mon Nov 18 08:49:37 2002
@@ -323,3 +323,14 @@
 	set_page_dirty(page);
 	return 0;
 }
+
+/*
+ * Print device name (in decimal, hexadecimal or symbolic)
+ * Note: returns pointer to static data!
+ */
+const char * kdevname(kdev_t dev)
+{
+	static char buffer[32];
+	sprintf(buffer, "%02x:%02x", major(dev), minor(dev));
+	return buffer;
+}
diff -urN linux-2.5.48/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- linux-2.5.48/fs/proc/proc_misc.c	Sun Nov 17 23:43:30 2002
+++ linux/fs/proc/proc_misc.c	Mon Nov 18 08:49:37 2002
@@ -57,7 +57,8 @@
  */
 extern int get_hardware_list(char *);
 extern int get_stram_list(char *);
-extern int get_device_list(char *);
+extern int get_chrdev_list(char *);
+extern int get_blkdev_list(char *);
 extern int get_filesystem_list(char *);
 extern int get_exec_domain_list(char *);
 extern int get_dma_list(char *);
@@ -376,7 +377,8 @@
 static int devices_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	int len = get_device_list(page);
+	int len = get_chrdev_list(page);
+	len += get_blkdev_list(page+len);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
diff -urN linux-2.5.48/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.48/include/linux/fs.h	Sun Nov 17 23:43:31 2002
+++ linux/include/linux/fs.h	Mon Nov 18 08:49:37 2002
@@ -1089,6 +1089,7 @@
 extern int blkdev_close(struct inode *, struct file *);
 extern struct file_operations def_blk_fops;
 extern struct address_space_operations def_blk_aops;
+extern struct file_operations def_chr_fops;
 extern struct file_operations def_fifo_fops;
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct inode *, struct file *, unsigned, unsigned long);

--------------070607060808080200040109--

