Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263990AbTCWXRO>; Sun, 23 Mar 2003 18:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263994AbTCWXRO>; Sun, 23 Mar 2003 18:17:14 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:12051 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263990AbTCWXQ4>; Sun, 23 Mar 2003 18:16:56 -0500
Date: Mon, 24 Mar 2003 00:27:52 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org, <aebr@win.tue.nl>,
       Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 3/3] remove character device array
Message-ID: <Pine.LNX.4.44.0303240027230.9065-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes the character device array, so that we can handle
now an arbitrary number of character devices.
The tty hack was moved where it belongs to.
Note that this makes device (major,0) special, as any other minor device
can be opened directly (via cd_fops), but minor 0 will use the fops
registered with the major number.
This won't be a problem for dynamically allocated devices, but it's
something to keep in mind for existing drivers.

bye, Roman

diff -Nur -X /opt/home/roman/nodiff linux-2.5-dev3/drivers/char/tty_io.c linux-2.5-dev4/drivers/char/tty_io.c
--- linux-2.5-dev3/drivers/char/tty_io.c	2003-03-23 18:29:44.000000000 +0100
+++ linux-2.5-dev4/drivers/char/tty_io.c	2003-03-23 22:32:27.000000000 +0100
@@ -327,11 +327,15 @@
 /*
  * This routine returns a tty driver structure, given a device number
  */
-struct tty_driver *get_tty_driver(kdev_t device)
+static struct tty_driver *get_tty_driver(kdev_t device)
 {
 	int	major, minor;
 	struct tty_driver *p;
-	
+#ifdef CONFIG_KMOD
+	char name[20] = "";
+again:
+#endif
+
 	minor = minor(device);
 	major = major(device);
 
@@ -344,6 +348,13 @@
 			continue;
 		return p;
 	}
+#ifdef CONFIG_KMOD
+	if (!name[0]) {
+		sprintf(name, "char-major-%d", MAJOR(major));
+		request_module(name);
+		goto again;
+	}
+#endif
 	return NULL;
 }
 
@@ -2113,21 +2124,33 @@
 int tty_register_driver(struct tty_driver *driver)
 {
 	int error;
-        int i;
+	int i;
 
 	if (driver->flags & TTY_DRIVER_INSTALLED)
 		return 0;
 
+	down_tty_sem(0);
+	if (driver->major) {
+		struct char_device *cdev = cdget(MKDEV(driver->major, 0));
+		struct file_operations *fops = cdev->cd_fops;
+		cdput(cdev);
+		error = 0;
+		if (fops == &tty_fops)
+			goto skip;
+	}
 	error = register_chrdev(driver->major, driver->name, &tty_fops);
-	if (error < 0)
+	if (error < 0) {
+		up_tty_sem(0);
 		return error;
-	else if(driver->major == 0)
+	} else if (driver->major == 0)
 		driver->major = error;
+skip:
 
 	if (!driver->put_char)
 		driver->put_char = tty_default_put_char;
 	
 	list_add(&driver->tty_drivers, &tty_drivers);
+	up_tty_sem(0);
 	
 	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
 		for(i = 0; i < driver->num; i++)
@@ -2151,24 +2174,30 @@
 	if (*driver->refcount)
 		return -EBUSY;
 
+	down_tty_sem(0);
 	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		if (p == driver)
 			found++;
 		else if (p->major == driver->major)
 			othername = p->name;
 	}
-	
-	if (!found)
-		return -ENOENT;
 
-	if (othername == NULL) {
-		retval = unregister_chrdev(driver->major, driver->name);
-		if (retval)
-			return retval;
+	if (found) {
+		if (othername) {
+			struct char_device *cdev = cdget(MKDEV(driver->major, 0));
+			cdev->cd_name = othername;
+			cdput(cdev);
+			retval = 0;
+		} else
+			retval = unregister_chrdev(driver->major, driver->name);
 	} else
-		register_chrdev(driver->major, othername, &tty_fops);
+		retval = -ENOENT;
 
-	list_del(&driver->tty_drivers);
+	if (!retval)
+		list_del(&driver->tty_drivers);
+	up_tty_sem(0);
+	if (retval)
+		return retval;
 
 	/*
 	 * Free the termios and termios_locked structures because
diff -Nur -X /opt/home/roman/nodiff linux-2.5-dev3/fs/char_dev.c linux-2.5-dev4/fs/char_dev.c
--- linux-2.5-dev3/fs/char_dev.c	2003-03-23 19:09:13.000000000 +0100
+++ linux-2.5-dev4/fs/char_dev.c	2003-03-23 19:19:14.000000000 +0100
@@ -15,17 +15,8 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#include <linux/tty.h>
-
-/* serial module kmod load support */
-struct tty_driver *get_tty_driver(kdev_t device);
-#define isa_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
-#define need_serial(ma,mi) (get_tty_driver(mk_kdev(ma,mi)) == NULL)
-#endif
 
 #define HASH_BITS	6
 #define HASH_SIZE	(1UL << HASH_BITS)
@@ -33,6 +24,7 @@
 static struct list_head cdev_hashtable[HASH_SIZE];
 static spinlock_t cdev_lock = SPIN_LOCK_UNLOCKED;
 static kmem_cache_t *cdev_cachep;
+static LIST_HEAD(cdev_list);
 
 #define alloc_cdev() \
 	 ((struct char_device *) kmem_cache_alloc(cdev_cachep, SLAB_KERNEL))
@@ -43,8 +35,10 @@
 	struct char_device *cdev = (struct char_device *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR)
+	    SLAB_CTOR_CONSTRUCTOR) {
 		memset(cdev, 0, sizeof(*cdev));
+		sema_init(&cdev->cd_sem, 1);
+	}
 }
 
 void __init cdev_cache_init(void)
@@ -131,27 +125,19 @@
 	}
 }
 
-struct device_struct {
-	const char * name;
-	struct file_operations * fops;
-};
-
-static rwlock_t chrdevs_lock = RW_LOCK_UNLOCKED;
-static struct device_struct chrdevs[MAX_CHRDEV];
-
 int get_chrdev_list(char *page)
 {
-	int i;
+	struct char_device *cdev;
 	int len;
 
 	len = sprintf(page, "Character devices:\n");
-	read_lock(&chrdevs_lock);
-	for (i = 0; i < MAX_CHRDEV ; i++) {
-		if (chrdevs[i].fops) {
-			len += sprintf(page+len, "%3d %s\n", i, chrdevs[i].name);
-		}
+	spin_lock(&cdev_lock);
+	list_for_each_entry(cdev, &cdev_list, cd_list) {
+		if (cdev->cd_name)
+			len += sprintf(page+len, "%3d %s\n",
+				       MAJOR(cdev->cd_dev), cdev->cd_name);
 	}
-	read_unlock(&chrdevs_lock);
+	spin_unlock(&cdev_lock);
 	return len;
 }
 
@@ -160,80 +146,95 @@
 	Load the driver if needed.
 	Increment the reference count of module in question.
 */
-static struct file_operations * get_chrfops(unsigned int major, unsigned int minor)
+static struct file_operations *get_chrfops(struct char_device *cdev)
 {
-	struct file_operations *ret = NULL;
+	struct file_operations *fops;
 
-	if (!major || major >= MAX_CHRDEV)
-		return NULL;
-
-	read_lock(&chrdevs_lock);
-	ret = fops_get(chrdevs[major].fops);
-	read_unlock(&chrdevs_lock);
+	down(&cdev->cd_sem);
+	fops = fops_get(cdev->cd_fops);
+	up(&cdev->cd_sem);
+	if (fops || !MINOR(cdev->cd_dev))
+		return fops;
+
+	cdev = cdget(MKDEV(MAJOR(cdev->cd_dev), 0));
+	down(&cdev->cd_sem);
+	fops = fops_get(cdev->cd_fops);
+	up(&cdev->cd_sem);
 #ifdef CONFIG_KMOD
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
+	if (!fops) {
+		char name[32];
 
-		read_lock(&chrdevs_lock);
-		ret = fops_get(chrdevs[major].fops);
-		read_unlock(&chrdevs_lock);
+		sprintf(name, "char-major-%d", MAJOR(cdev->cd_dev));
+		request_module(name);
+		down(&cdev->cd_sem);
+		fops = fops_get(cdev->cd_fops);
+		up(&cdev->cd_sem);
 	}
 #endif
-	return ret;
+	cdput(cdev);
+	return fops;
 }
-
+						
 int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
 {
+	struct char_device *cdev;
+	int res;
+
 	if (major == 0) {
-		write_lock(&chrdevs_lock);
 		for (major = MAX_CHRDEV-1; major > 0; major--) {
-			if (chrdevs[major].fops == NULL) {
-				chrdevs[major].name = name;
-				chrdevs[major].fops = fops;
-				write_unlock(&chrdevs_lock);
-				return major;
+			cdev = cdget(MKDEV(major, 0));
+			down(&cdev->cd_sem);
+			if (!cdev->cd_fops) {
+				res = major;
+				goto found;
 			}
+			up(&cdev->cd_sem); 
+			cdput(cdev);
 		}
-		write_unlock(&chrdevs_lock);
 		return -EBUSY;
 	}
+
 	if (major >= MAX_CHRDEV)
 		return -EINVAL;
-	write_lock(&chrdevs_lock);
-	if (chrdevs[major].fops && chrdevs[major].fops != fops) {
-		write_unlock(&chrdevs_lock);
+
+	cdev = cdget(MKDEV(major, 0));
+	down(&cdev->cd_sem);
+	if (cdev->cd_fops) {
+		up(&cdev->cd_sem);
+		cdput(cdev);
 		return -EBUSY;
 	}
-	chrdevs[major].name = name;
-	chrdevs[major].fops = fops;
-	write_unlock(&chrdevs_lock);
+	res = 0;
+found:
+	cdev->cd_fops = fops;
+	cdev->cd_name = name;
+	list_add_tail(&cdev->cd_list, &cdev_list);
+	up(&cdev->cd_sem);
 	return 0;
 }
 
 int unregister_chrdev(unsigned int major, const char * name)
 {
+	struct char_device *cdev;
+	int res;
+
 	if (major >= MAX_CHRDEV)
 		return -EINVAL;
-	write_lock(&chrdevs_lock);
-	if (!chrdevs[major].fops || strcmp(chrdevs[major].name, name)) {
-		write_unlock(&chrdevs_lock);
-		return -EINVAL;
+
+	cdev = cdget(MKDEV(major, 0));
+	down(&cdev->cd_sem);
+	res = -EINVAL;
+	if (cdev->cd_fops && !strcmp(cdev->cd_name, name)) {
+		list_del(&cdev->cd_list);
+		cdev->cd_fops = NULL;
+		cdev->cd_name = NULL;
+		cdput(cdev);
+		res = 0;
 	}
-	chrdevs[major].name = NULL;
-	chrdevs[major].fops = NULL;
-	write_unlock(&chrdevs_lock);
-	return 0;
+	up(&cdev->cd_sem);
+
+	cdput(cdev);
+	return res;
 }
 
 /*
@@ -241,14 +242,16 @@
  */
 int chrdev_open(struct inode * inode, struct file * filp)
 {
+	struct file_operations *fops;
 	int ret = -ENODEV;
 
-	filp->f_op = get_chrfops(major(inode->i_rdev), minor(inode->i_rdev));
-	if (filp->f_op) {
+	fops = get_chrfops(inode->i_cdev);
+	if (fops) {
 		ret = 0;
-		if (filp->f_op->open != NULL) {
+		filp->f_op = fops;
+		if (fops->open) {
 			lock_kernel();
-			ret = filp->f_op->open(inode,filp);
+			ret = fops->open(inode, filp);
 			unlock_kernel();
 		}
 	}
@@ -266,11 +269,13 @@
 
 const char *cdevname(kdev_t dev)
 {
-	static char buffer[40];
-	const char * name = chrdevs[major(dev)].name;
+	static char buffer[64];
+	struct char_device *cdev;
+
+	cdev = cdget(kdev_t_to_nr(dev));
+	down(&cdev->cd_sem);
+	sprintf(buffer, "%s(%d,%d)", cdev->cd_name ? cdev->cd_name : "unknown-char", major(dev), minor(dev));
+	up(&cdev->cd_sem);
 
-	if (!name)
-		name = "unknown-char";
-	sprintf(buffer, "%s(%d,%d)", name, major(dev), minor(dev));
 	return buffer;
 }
diff -Nur -X /opt/home/roman/nodiff linux-2.5-dev3/include/linux/fs.h linux-2.5-dev4/include/linux/fs.h
--- linux-2.5-dev3/include/linux/fs.h	2003-03-23 19:01:56.000000000 +0100
+++ linux-2.5-dev4/include/linux/fs.h	2003-03-23 18:41:34.000000000 +0100
@@ -333,8 +333,13 @@
 
 struct char_device {
 	struct list_head	cd_hash;
+	struct list_head	cd_list;
+	struct file_operations *cd_fops;
+	const char *		cd_name;
 	atomic_t		cd_count;
 	dev_t			cd_dev;
+	struct semaphore	cd_sem;
+	void *			cd_data;
 };
 
 struct block_device {

