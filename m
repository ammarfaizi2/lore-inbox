Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbTCTAqc>; Wed, 19 Mar 2003 19:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbTCTAqb>; Wed, 19 Mar 2003 19:46:31 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:54536 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261283AbTCTAqO>; Wed, 19 Mar 2003 19:46:14 -0500
Date: Thu, 20 Mar 2003 01:57:06 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@digeo.com>
Subject: [PATCH] alternative dev patch
Message-ID: <Pine.LNX.4.44.0303200140050.12110-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes use of the character device hash and avoids introducing 
unnecessary interfaces. I also moved the tty hack where it belongs.
As an example I converted the misc device to demonstrate how drivers can 
make use of it.
Probably the most interesting part is how the open path stays short and 
fast.

bye, Roman

Index: drivers/char/misc.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/drivers/char/misc.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 misc.c
--- drivers/char/misc.c	15 Feb 2003 01:28:54 -0000	1.1.1.7
+++ drivers/char/misc.c	20 Mar 2003 00:38:23 -0000
@@ -60,11 +60,8 @@ static DECLARE_MUTEX(misc_sem);
  * Assigned numbers, used for dynamic minors
  */
 #define DYNAMIC_MINORS 64 /* like dynamic majors */
-static unsigned char misc_minors[DYNAMIC_MINORS / 8];
 
-#ifdef CONFIG_SGI_NEWPORT_GFX
 extern void gfx_register(void);
-#endif
 extern void streamable_init(void);
 extern int rtc_DP8570A_init(void);
 extern int rtc_MK48T08_init(void);
@@ -100,45 +97,21 @@ static int misc_read_proc(char *buf, cha
 
 static int misc_open(struct inode * inode, struct file * file)
 {
-	int minor = minor(inode->i_rdev);
-	struct miscdevice *c;
+	struct char_device *cdev = inode->i_cdev;
+	char modname[32];
 	int err = -ENODEV;
-	struct file_operations *old_fops, *new_fops = NULL;
-	
-	down(&misc_sem);
-	
-	c = misc_list.next;
+	struct file_operations *fops;
 
-	while ((c != &misc_list) && (c->minor != minor))
-		c = c->next;
-	if (c != &misc_list)
-		new_fops = fops_get(c->fops);
-	if (!new_fops) {
-		char modname[20];
-		up(&misc_sem);
-		sprintf(modname, "char-major-%d-%d", MISC_MAJOR, minor);
-		request_module(modname);
-		down(&misc_sem);
-		c = misc_list.next;
-		while ((c != &misc_list) && (c->minor != minor))
-			c = c->next;
-		if (c == &misc_list || (new_fops = fops_get(c->fops)) == NULL)
-			goto fail;
+	sprintf(modname, "char-major-%d-%d", MISC_MAJOR, MINOR(cdev->dev));
+	request_module(modname);
+	fops = fops_get(cdev->fops);
+	if (fops) {
+		err = 0;
+		fops_put(file->f_op);
+		file->f_op = fops;
+		if (fops->open)
+			err = fops->open(inode, file);
 	}
-
-	err = 0;
-	old_fops = file->f_op;
-	file->f_op = new_fops;
-	if (file->f_op->open) {
-		err=file->f_op->open(inode,file);
-		if (err) {
-			fops_put(file->f_op);
-			file->f_op = fops_get(old_fops);
-		}
-	}
-	fops_put(old_fops);
-fail:
-	up(&misc_sem);
 	return err;
 }
 
@@ -167,34 +140,35 @@ static struct file_operations misc_fops 
 int misc_register(struct miscdevice * misc)
 {
 	static devfs_handle_t devfs_handle, dir;
-	struct miscdevice *c;
-	
-	if (misc->next || misc->prev)
-		return -EBUSY;
-	down(&misc_sem);
-	c = misc_list.next;
-
-	while ((c != &misc_list) && (c->minor != misc->minor))
-		c = c->next;
-	if (c != &misc_list) {
-		up(&misc_sem);
-		return -EBUSY;
-	}
+	struct char_device *cdev;
 
 	if (misc->minor == MISC_DYNAMIC_MINOR) {
-		int i = DYNAMIC_MINORS;
-		while (--i >= 0)
-			if ( (misc_minors[i>>3] & (1 << (i&7))) == 0)
-				break;
-		if (i<0)
-		{
-			up(&misc_sem);
-			return -EBUSY;
+		int i;
+
+		for (i = DYNAMIC_MINORS; i > 0; i--) {
+			cdev = cdget(MKDEV(MISC_MAJOR, i));
+			down(&cdev->sem);
+			if (!cdev->fops)
+				goto found;
+			up(&cdev->sem);
+			cdput(cdev);
 		}
-		misc->minor = i;
-	}
-	if (misc->minor < DYNAMIC_MINORS)
-		misc_minors[misc->minor >> 3] |= 1 << (misc->minor & 7);
+	} else {
+		cdev = cdget(MKDEV(MISC_MAJOR, misc->minor));
+		down(&cdev->sem);
+		if (!cdev->fops)
+			goto found;
+		up(&cdev->sem);
+	}
+	return -EBUSY;
+
+found:
+	cdev->fops = misc->fops;
+	cdev->name = misc->name;
+	up(&cdev->sem);
+
+	down(&misc_sem);
+
 	if (!devfs_handle)
 		devfs_handle = devfs_mk_dir (NULL, "misc", NULL);
 	dir = strchr (misc->name, '/') ? NULL : devfs_handle;
@@ -204,14 +178,10 @@ int misc_register(struct miscdevice * mi
 				S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
 				misc->fops, NULL);
 
-	/*
-	 * Add it to the front, so that later devices can "override"
-	 * earlier defaults
-	 */
 	misc->prev = &misc_list;
 	misc->next = misc_list.next;
-	misc->prev->next = misc;
-	misc->next->prev = misc;
+	misc_list.next->prev = misc;
+	misc_list.next = misc;
 	up(&misc_sem);
 	return 0;
 }
@@ -228,18 +198,22 @@ int misc_register(struct miscdevice * mi
 
 int misc_deregister(struct miscdevice * misc)
 {
-	int i = misc->minor;
-	if (!misc->next || !misc->prev)
+	struct char_device *cdev;
+
+	cdev = cdget(MKDEV(MISC_MAJOR, misc->minor));
+	down(&cdev->sem);
+	if (cdev->fops != misc->fops) {
+		up(&cdev->sem);
 		return -EINVAL;
+	}
+	cdev->fops = NULL;
+	cdev->name = NULL;
+	up(&cdev->sem);
+
 	down(&misc_sem);
 	misc->prev->next = misc->next;
 	misc->next->prev = misc->prev;
-	misc->next = NULL;
-	misc->prev = NULL;
-	devfs_unregister (misc->devfs_handle);
-	if (i < DYNAMIC_MINORS && i>0) {
-		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
-	}
+	devfs_unregister(misc->devfs_handle);
 	up(&misc_sem);
 	return 0;
 }
Index: drivers/char/tty_io.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/drivers/char/tty_io.c,v
retrieving revision 1.1.1.32
diff -u -p -r1.1.1.32 tty_io.c
--- drivers/char/tty_io.c	17 Mar 2003 22:56:57 -0000	1.1.1.32
+++ drivers/char/tty_io.c	19 Mar 2003 23:20:07 -0000
@@ -274,7 +274,7 @@ static int tty_set_ldisc(struct tty_stru
 	/* Eduardo Blanco <ejbs@cs.cs.com.uy> */
 	/* Cyrus Durgin <cider@speakeasy.org> */
 	if (!(ldiscs[ldisc].flags & LDISC_FLAG_DEFINED)) {
-		char modname [20];
+		char modname [32];
 		sprintf(modname, "tty-ldisc-%d", ldisc);
 		request_module (modname);
 	}
@@ -327,11 +327,15 @@ static int tty_set_ldisc(struct tty_stru
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
 
@@ -344,6 +348,13 @@ struct tty_driver *get_tty_driver(kdev_t
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
 
@@ -2108,22 +2119,33 @@ EXPORT_SYMBOL(tty_unregister_device);
  */
 int tty_register_driver(struct tty_driver *driver)
 {
-	int error;
+	int error = 0;
         int i;
 
 	if (driver->flags & TTY_DRIVER_INSTALLED)
 		return 0;
 
+	down_tty_sem(0);
+	if (driver->major) {
+		struct char_device *cdev = cdget(MKDEV(driver->major, 0));
+		struct file_operations *fops = cdev->fops;
+		cdput(cdev);
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
@@ -2147,6 +2169,7 @@ int tty_unregister_driver(struct tty_dri
 	if (*driver->refcount)
 		return -EBUSY;
 
+	down_tty_sem(0);
 	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		if (p == driver)
 			found++;
@@ -2154,17 +2177,22 @@ int tty_unregister_driver(struct tty_dri
 			othername = p->name;
 	}
 	
-	if (!found)
-		return -ENOENT;
-
-	if (othername == NULL) {
-		retval = unregister_chrdev(driver->major, driver->name);
-		if (retval)
-			return retval;
+	if (found) {
+		if (othername) {
+			struct char_device *cdev = cdget(MKDEV(driver->major, 0));
+			cdev->name = othername;
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
Index: fs/char_dev.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/char_dev.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 char_dev.c
--- fs/char_dev.c	17 Mar 2003 22:53:20 -0000	1.1.1.7
+++ fs/char_dev.c	19 Mar 2003 23:20:07 -0000
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
@@ -43,8 +34,10 @@ static void init_once(void *foo, kmem_ca
 	struct char_device *cdev = (struct char_device *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR)
+	    SLAB_CTOR_CONSTRUCTOR) {
 		memset(cdev, 0, sizeof(*cdev));
+		sema_init(&cdev->sem, 1);
+	}
 }
 
 void __init cdev_cache_init(void)
@@ -127,27 +120,22 @@ void cdput(struct char_device *cdev)
 	}
 }
 
-struct device_struct {
-	const char * name;
-	struct file_operations * fops;
-};
-
-static rwlock_t chrdevs_lock = RW_LOCK_UNLOCKED;
-static struct device_struct chrdevs[MAX_CHRDEV];
 
 int get_chrdev_list(char *page)
 {
-	int i;
-	int len;
+	struct char_device *cdev;
+	dev_t dev;
+	int len, i;
 
 	len = sprintf(page, "Character devices:\n");
-	read_lock(&chrdevs_lock);
+	spin_lock(&cdev_lock);
 	for (i = 0; i < MAX_CHRDEV ; i++) {
-		if (chrdevs[i].fops) {
-			len += sprintf(page+len, "%3d %s\n", i, chrdevs[i].name);
-		}
+		dev = MKDEV(i, 0);
+		cdev = cdfind(dev, cdev_hashtable + hash(dev));
+		if (cdev && cdev->name)
+			len += sprintf(page+len, "%3d %s\n", i, cdev->name);
 	}
-	read_unlock(&chrdevs_lock);
+	spin_unlock(&cdev_lock);
 	return len;
 }
 
@@ -156,80 +144,92 @@ int get_chrdev_list(char *page)
 	Load the driver if needed.
 	Increment the reference count of module in question.
 */
-static struct file_operations * get_chrfops(unsigned int major, unsigned int minor)
+static struct file_operations *get_chrfops(struct char_device *cdev)
 {
-	struct file_operations *ret = NULL;
-
-	if (!major || major >= MAX_CHRDEV)
-		return NULL;
+	struct file_operations *fops;
 
-	read_lock(&chrdevs_lock);
-	ret = fops_get(chrdevs[major].fops);
-	read_unlock(&chrdevs_lock);
+	down(&cdev->sem);
+	fops = fops_get(cdev->fops);
+	up(&cdev->sem);
+	if (fops || !MINOR(cdev->dev))
+		return fops;
+
+	cdev = cdget(MKDEV(MAJOR(cdev->dev), 0));
+	down(&cdev->sem);
+	fops = fops_get(cdev->fops);
+	up(&cdev->sem);
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
+	if (!fops) {
 		char name[20];
-		sprintf(name, "char-major-%d", major);
-		request_module(name);
 
-		read_lock(&chrdevs_lock);
-		ret = fops_get(chrdevs[major].fops);
-		read_unlock(&chrdevs_lock);
+		sprintf(name, "char-major-%d", MAJOR(cdev->dev));
+		request_module(name);
+		down(&cdev->sem);
+		fops = fops_get(cdev->fops);
+		up(&cdev->sem);
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
+
 	if (major == 0) {
-		write_lock(&chrdevs_lock);
 		for (major = MAX_CHRDEV-1; major > 0; major--) {
-			if (chrdevs[major].fops == NULL) {
-				chrdevs[major].name = name;
-				chrdevs[major].fops = fops;
-				write_unlock(&chrdevs_lock);
+			cdev = cdget(MKDEV(major, 0));
+			down(&cdev->sem);
+			if (!cdev->fops) {
+				cdev->fops = fops; 
+				cdev->name = name; 
+				up(&cdev->sem);
 				return major;
 			}
+			up(&cdev->sem); 
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
+	down(&cdev->sem);
+	if (cdev->fops) {
+		up(&cdev->sem);
+		cdput(cdev);
 		return -EBUSY;
 	}
-	chrdevs[major].name = name;
-	chrdevs[major].fops = fops;
-	write_unlock(&chrdevs_lock);
+	cdev->fops = fops;
+	cdev->name = name;
+	up(&cdev->sem);
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
+	down(&cdev->sem);
+	res = -EINVAL;
+	if (cdev->fops && !strcmp(cdev->name, name)) {
+		cdev->fops = NULL;
+		cdev->name = NULL;
+		cdput(cdev);
+		res = 0;
 	}
-	chrdevs[major].name = NULL;
-	chrdevs[major].fops = NULL;
-	write_unlock(&chrdevs_lock);
-	return 0;
+	up(&cdev->sem);
+
+	cdput(cdev);
+	return res;
 }
 
 /*
@@ -237,14 +237,16 @@ int unregister_chrdev(unsigned int major
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
+			ret = fops->open(inode,filp);
 			unlock_kernel();
 		}
 	}
@@ -262,11 +264,13 @@ struct file_operations def_chr_fops = {
 
 const char * cdevname(kdev_t dev)
 {
-	static char buffer[32];
-	const char * name = chrdevs[major(dev)].name;
+	static char buffer[64];
+	struct char_device *cdev;
+
+	cdev = cdget(kdev_t_to_nr(dev));
+	down(&cdev->sem);
+	sprintf(buffer, "%s(%d,%d)", cdev->name ? cdev->name : "unknown-char", major(dev), minor(dev));
+	up(&cdev->sem);
 
-	if (!name)
-		name = "unknown-char";
-	sprintf(buffer, "%s(%d,%d)", name, major(dev), minor(dev));
 	return buffer;
 }
Index: include/linux/fs.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/linux/fs.h,v
retrieving revision 1.1.1.53
diff -u -p -r1.1.1.53 fs.h
--- include/linux/fs.h	17 Mar 2003 22:54:06 -0000	1.1.1.53
+++ include/linux/fs.h	19 Mar 2003 23:20:07 -0000
@@ -331,8 +331,11 @@ struct address_space {
 
 struct char_device {
 	struct list_head	hash;
+	struct file_operations *fops;
+	const char *		name;
 	atomic_t		count;
 	dev_t			dev;
+	struct semaphore	sem;
 };
 
 struct block_device {

