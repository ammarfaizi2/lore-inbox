Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWADXGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWADXGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWADXGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:06:34 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:42722 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751265AbWADXGb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:06:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface (rev. 2)
Date: Wed, 4 Jan 2006 23:51:58 +0100
User-Agent: KMail/1.9
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200601042340.42118.rjw@sisk.pl>
In-Reply-To: <200601042340.42118.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601042351.58667.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a user space interface for swsusp.  The interface is based
on the special character device allowing user space processes to perform
suspend and resume-related operations with the help of some ioctls and
the read()/write() functions.  Additionally it allows these processes to
allocate swap pages so that they know which sectors of the resume partition
are available to them (it is also possible to free the allocated swap pages).

Currently the major number of the device is allocated dynamically,
so it is exported via sysfs for convenience, but I'd like the device to
have a well-defined major number in the future, if possible/acceptable.

The interface uses the same low-level snapshot-handling functions that
are used by the in-kernel swap-writing/reading code of swsusp.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 init/do_mounts_initrd.c |    1 
 kernel/power/Makefile   |    2 
 kernel/power/power.h    |   46 ++++++
 kernel/power/swsusp.c   |   69 ++++------
 kernel/power/user.c     |  325 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 402 insertions(+), 41 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/user.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm3/kernel/power/user.c	2006-01-04 20:27:47.000000000 +0100
@@ -0,0 +1,325 @@
+/*
+ * linux/kernel/power/user.c
+ *
+ * This file provides the user space interface for software suspend/resume.
+ *
+ * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * This file is released under the GPLv2.
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/syscalls.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/pm.h>
+#include <linux/uaccess.h>
+#include <linux/fs.h>
+
+#include "power.h"
+
+struct snapshot_dev {
+	char *name;
+	dev_t devno;
+	struct cdev cdev;
+	struct snapshot_handle handle;
+	int swap;
+	struct bitmap_page *bitmap;
+	int mode;
+	char frozen;
+	char ready;
+};
+
+static atomic_t device_available = ATOMIC_INIT(1);
+
+int snapshot_open(struct inode *inode, struct file *filp)
+{
+	struct snapshot_dev *dev;
+
+	if (!atomic_dec_and_test(&device_available)) {
+		atomic_inc(&device_available);
+		return -EBUSY;
+	}
+
+	if ((filp->f_flags & O_ACCMODE) == O_RDWR)
+		return -ENOSYS;
+
+	nonseekable_open(inode, filp);
+	dev = container_of(inode->i_cdev, struct snapshot_dev, cdev);
+	filp->private_data = dev;
+	memset(&dev->handle, 0, sizeof(struct snapshot_handle));
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
+		dev->swap = swsusp_get_swap_index();
+		dev->mode = O_RDONLY;
+	} else {
+		dev->swap = -1;
+		dev->mode = O_WRONLY;
+	}
+	dev->bitmap = NULL;
+	dev->frozen = 0;
+	dev->ready = 0;
+
+	return 0;
+}
+
+int snapshot_release(struct inode *inode, struct file *filp)
+{
+	struct snapshot_dev *dev;
+
+	swsusp_free();
+	dev = filp->private_data;
+	free_all_swap_pages(dev->swap, dev->bitmap);
+	free_bitmap(dev->bitmap);
+	if (dev->frozen) {
+		down(&pm_sem);
+		thaw_processes();
+		enable_nonboot_cpus();
+		up(&pm_sem);
+	}
+	atomic_inc(&device_available);
+	return 0;
+}
+
+static ssize_t snapshot_read(struct file *filp, char __user *buf,
+                             size_t count, loff_t *offp)
+{
+	struct snapshot_dev *dev;
+	ssize_t res;
+
+	dev = filp->private_data;
+	res = snapshot_read_next(&dev->handle, count);
+	if (res > 0) {
+		if (copy_to_user(buf, data_of(dev->handle), res))
+			res = -EFAULT;
+		else
+			*offp = dev->handle.offset;
+	}
+	return res;
+}
+
+static ssize_t snapshot_write(struct file *filp, const char __user *buf,
+                              size_t count, loff_t *offp)
+{
+	struct snapshot_dev *dev;
+	ssize_t res;
+
+	dev = filp->private_data;
+	res = snapshot_write_next(&dev->handle, count);
+	if (res > 0) {
+		if (copy_from_user(data_of(dev->handle), buf, res))
+			res = -EFAULT;
+		else
+			*offp = dev->handle.offset;
+	}
+	return res;
+}
+
+static int snapshot_ioctl(struct inode *inode, struct file *filp,
+                          unsigned int cmd, unsigned long arg)
+{
+	int error = 0;
+	struct snapshot_dev *dev;
+	unsigned long offset;
+	unsigned int n;
+
+	if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC)
+		return -ENOTTY;
+	if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR)
+		return -ENOTTY;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	dev = filp->private_data;
+
+	switch (cmd) {
+
+	case SNAPSHOT_IOCFREEZE:
+		if (dev->frozen)
+			break;
+		sys_sync();
+		down(&pm_sem);
+		disable_nonboot_cpus();
+		if (freeze_processes())
+			error = -EBUSY;
+		up(&pm_sem);
+		if (!error)
+			dev->frozen = 1;
+		break;
+
+	case SNAPSHOT_IOCUNFREEZE:
+		if (!dev->frozen)
+			break;
+		down(&pm_sem);
+		thaw_processes();
+		enable_nonboot_cpus();
+		up(&pm_sem);
+		dev->frozen = 0;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_SNAPSHOT:
+		if (dev->mode != O_RDONLY || !dev->frozen  || dev->ready) {
+			error = -EPERM;
+			break;
+		}
+		down(&pm_sem);
+		pm_prepare_console();
+		/* Free memory before shutting down devices. */
+		error = swsusp_shrink_memory();
+		if (!error) {
+			error = device_suspend(PMSG_FREEZE);
+			if (!error) {
+				in_suspend = 1;
+				error = swsusp_suspend();
+				device_resume();
+			}
+		}
+		pm_restore_console();
+		up(&pm_sem);
+		if (!error)
+			error = put_user(in_suspend, (unsigned int __user *)arg);
+		if (!error)
+			dev->ready = 1;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_RESTORE:
+		if (dev->mode != O_WRONLY || !dev->frozen ||
+		    !snapshot_image_loaded(&dev->handle)) {
+			error = -EPERM;
+			break;
+		}
+		down(&pm_sem);
+		pm_prepare_console();
+		error = device_suspend(PMSG_FREEZE);
+		if (!error) {
+			mb();
+			error = swsusp_resume();
+			device_resume();
+		}
+		pm_restore_console();
+		up(&pm_sem);
+		break;
+
+	case SNAPSHOT_IOCFREE:
+		swsusp_free();
+		memset(&dev->handle, 0, sizeof(struct snapshot_handle));
+		dev->ready = 0;
+		break;
+
+	case SNAPSHOT_IOCSET_IMAGE_SIZE:
+		image_size = arg;
+		break;
+
+	case SNAPSHOT_IOCAVAIL_SWAP:
+		n = swsusp_available_swap(dev->swap);
+		error = put_user(n, (unsigned int __user *)arg);
+		break;
+
+	case SNAPSHOT_IOCGET_SWAP_PAGE:
+		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
+			error = -EINVAL;
+			break;
+		}
+		if (dev->swap < 0 || dev->swap >= MAX_SWAPFILES) {
+			error = -ENODEV;
+			break;
+		}
+		if (!dev->bitmap) {
+			dev->bitmap = alloc_bitmap(swsusp_total_swap(dev->swap));
+			if (!dev->bitmap) {
+				error = -ENOMEM;
+				break;
+			}
+		}
+		offset = alloc_swap_page(dev->swap, dev->bitmap);
+		if (offset)
+			__put_user(offset, (unsigned long __user *)arg);
+		else
+			error = -ENOSPC;
+		break;
+
+	case SNAPSHOT_IOCFREE_SWAP_PAGES:
+		if (dev->swap >= 0 && dev->swap < MAX_SWAPFILES) {
+			error = -ENODEV;
+			break;
+		}
+		free_all_swap_pages(dev->swap, dev->bitmap);
+		free_bitmap(dev->bitmap);
+		dev->bitmap = NULL;
+		break;
+
+	case SNAPSHOT_IOCSET_SWAP_FILE:
+		if (!dev->bitmap) {
+			/*
+			 * User space encodes device types as two-byte values,
+			 * so we need to recode them
+			 */
+			dev->swap = swsusp_get_swap_index_of(old_decode_dev(arg));
+			if (dev->swap < 0)
+				error = -ENODEV;
+		} else {
+			error = -EPERM;
+		}
+		break;
+
+	default:
+		error = -ENOTTY;
+
+	}
+
+	return error;
+}
+
+static struct file_operations snapshot_fops = {
+	.open = snapshot_open,
+	.release = snapshot_release,
+	.read = snapshot_read,
+	.write = snapshot_write,
+	.llseek = no_llseek,
+	.ioctl = snapshot_ioctl,
+};
+
+static struct snapshot_dev interface = {
+	.name = "snapshot",
+};
+
+static ssize_t snapshot_show(struct subsystem * subsys, char *buf)
+{
+	return sprintf(buf, "%d:%d\n", MAJOR(interface.devno),
+		       MINOR(interface.devno));
+}
+
+static struct subsys_attribute snapshot_attr = {
+	.attr = {
+		.name = __stringify(snapshot),
+		.mode = S_IRUGO,
+	},
+	.show = snapshot_show,
+};
+
+static int __init snapshot_dev_init(void)
+{
+	int error;
+
+	error =  alloc_chrdev_region(&interface.devno, 0, 1, interface.name);
+	if (error)
+		return error;
+	cdev_init(&interface.cdev, &snapshot_fops);
+	interface.cdev.ops = &snapshot_fops;
+	error = cdev_add(&interface.cdev, interface.devno, 1);
+	if (error)
+		goto Unregister;
+	error = sysfs_create_file(&power_subsys.kset.kobj, &snapshot_attr.attr);
+	if (!error)
+		return 0;
+	cdev_del(&interface.cdev);
+Unregister:
+	unregister_chrdev_region(interface.devno, 1);
+	return error;
+};
+
+late_initcall(snapshot_dev_init);
Index: linux-2.6.15-rc5-mm3/kernel/power/Makefile
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/Makefile	2005-12-31 15:54:11.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/Makefile	2006-01-04 20:26:57.000000000 +0100
@@ -5,7 +5,7 @@ endif
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o user.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
Index: linux-2.6.15-rc5-mm3/init/do_mounts_initrd.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/init/do_mounts_initrd.c	2005-12-31 15:54:11.000000000 +0100
+++ linux-2.6.15-rc5-mm3/init/do_mounts_initrd.c	2005-12-31 17:29:04.000000000 +0100
@@ -56,6 +56,7 @@ static void __init handle_initrd(void)
 	sys_chroot(".");
 	mount_devfs_fs ();
 
+	current->flags |= PF_NOFREEZE;
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
 		while (pid != sys_wait4(-1, NULL, 0, NULL))
Index: linux-2.6.15-rc5-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/power.h	2005-12-31 16:05:33.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/power.h	2006-01-04 20:26:57.000000000 +0100
@@ -77,3 +77,49 @@ struct snapshot_handle {
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
 int snapshot_image_loaded(struct snapshot_handle *handle);
+
+#define SNAPSHOT_IOC_MAGIC	'3'
+#define SNAPSHOT_IOCFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 1)
+#define SNAPSHOT_IOCUNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
+#define SNAPSHOT_IOCATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
+#define SNAPSHOT_IOCATOMIC_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 4)
+#define SNAPSHOT_IOCFREE		_IO(SNAPSHOT_IOC_MAGIC, 5)
+#define SNAPSHOT_IOCSET_IMAGE_SIZE	_IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned long)
+#define SNAPSHOT_IOCAVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
+#define SNAPSHOT_IOCGET_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
+#define SNAPSHOT_IOCFREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
+#define SNAPSHOT_IOCSET_SWAP_FILE	_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
+#define SNAPSHOT_IOC_MAXNR	10
+
+/**
+ *	The bitmap is used for tracing allocated swap pages
+ *
+ *	The entire bitmap consists of a number of bitmap_page
+ *	structures linked with the help of the .next member.
+ *	Thus each page can be allocated individually, so we only
+ *	need to make 0-order memory allocations to create
+ *	the bitmap.
+ */
+
+#define BITMAP_PAGE_SIZE	(PAGE_SIZE - sizeof(void *))
+#define BITMAP_PAGE_CHUNKS	(BITMAP_PAGE_SIZE / sizeof(long))
+#define BITS_PER_CHUNK		(sizeof(long) * 8)
+#define BITMAP_PAGE_BITS	(BITMAP_PAGE_CHUNKS * BITS_PER_CHUNK)
+
+struct bitmap_page {
+	unsigned long		chunks[BITMAP_PAGE_CHUNKS];
+	struct bitmap_page	*next;
+};
+
+extern void free_bitmap(struct bitmap_page *bitmap);
+extern struct bitmap_page *alloc_bitmap(unsigned int nr_bits);
+extern unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap);
+extern void free_all_swap_pages(int swap, struct bitmap_page *bitmap);
+
+extern int swsusp_get_swap_index_of(dev_t device);
+extern int swsusp_get_swap_index(void);
+extern unsigned int swsusp_total_swap(unsigned int swap);
+extern unsigned int swsusp_available_swap(unsigned int swap);
+extern int swsusp_shrink_memory(void);
+extern int swsusp_suspend(void);
+extern int swsusp_resume(void);
Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2005-12-31 16:51:57.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2006-01-04 20:26:57.000000000 +0100
@@ -130,41 +130,41 @@ static int mark_swapfiles(swp_entry_t st
 }
 
 /**
- * Check whether the swap device is the specified resume
- * device, irrespective of whether they are specified by
- * identical names.
+ *	is_device - check whether the specified device is a swap device,
+ *	irrespective of whether they are specified by identical names.
  *
- * (Thus, device inode aliasing is allowed.  You can say /dev/hda4
- * instead of /dev/ide/host0/bus0/target0/lun0/part4 [eg. for devfs]
- * and they'll be considered the same device.  This was *necessary* for
- * devfs, since the resume code could only recognize the form /dev/hda4,
- * but the suspend code would see the long name.)
+ *	(Thus, device inode aliasing is allowed.  You can say /dev/hda4
+ *	instead of /dev/ide/host0/bus0/target0/lun0/part4 [eg. for devfs]
+ *	and they'll be considered the same device.  This was *necessary* for
+ *	devfs, since the resume code could only recognize the form /dev/hda4,
+ *	but the suspend code would see the long name.)
  */
 
-static inline int is_resume_device(const struct swap_info_struct *swap_info)
+static inline int is_device(const struct swap_info_struct *swap_info,
+                            dev_t device)
 {
 	struct file *file = swap_info->swap_file;
 	struct inode *inode = file->f_dentry->d_inode;
 
 	return S_ISBLK(inode->i_mode) &&
-		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
+		device == MKDEV(imajor(inode), iminor(inode));
 }
 
 /**
- *	swsusp_get_swap_index - find the index of the resume device
+ *	swsusp_get_swap_index_of - find the index of the given device
  */
 
-int swsusp_get_swap_index(void)
+int swsusp_get_swap_index_of(dev_t device)
 {
 	int i;
 
-	if (!swsusp_resume_device)
-		return -ENODEV;
+	if (!device)
+		return -EINVAL;
 	spin_lock(&swap_lock);
 	for (i = 0; i < MAX_SWAPFILES; i++) {
 		if (!(swap_info[i].flags & SWP_WRITEOK))
 			continue;
-		if (is_resume_device(swap_info + i)) {
+		if (is_device(swap_info + i, device)) {
 			spin_unlock(&swap_lock);
 			return i;
 		}
@@ -173,6 +173,15 @@ int swsusp_get_swap_index(void)
 	return -ENODEV;
 }
 
+/**
+ *	swsusp_get_swap_index - find the index of the resume device
+ */
+
+int swsusp_get_swap_index(void)
+{
+	return swsusp_get_swap_index_of(swsusp_resume_device);
+}
+
 static int swsusp_swap_check(void) /* This is called before saving image */
 {
 	int res = swsusp_get_swap_index();
@@ -185,34 +194,14 @@ static int swsusp_swap_check(void) /* Th
 }
 
 /**
- *	The bitmap is used for tracing allocated swap pages
- *
- *	The entire bitmap consists of a number of bitmap_page
- *	structures linked with the help of the .next member.
- *	Thus each page can be allocated individually, so we only
- *	need to make 0-order memory allocations to create
- *	the bitmap.
- */
-
-#define BITMAP_PAGE_SIZE	(PAGE_SIZE - sizeof(void *))
-#define BITMAP_PAGE_CHUNKS	(BITMAP_PAGE_SIZE / sizeof(long))
-#define BITS_PER_CHUNK		(sizeof(long) * 8)
-#define BITMAP_PAGE_BITS	(BITMAP_PAGE_CHUNKS * BITS_PER_CHUNK)
-
-struct bitmap_page {
-	unsigned long		chunks[BITMAP_PAGE_CHUNKS];
-	struct bitmap_page	*next;
-};
-
-/**
  *	The following functions are used for tracing the allocated
  *	swap pages, so that they can be freed in case of an error.
  *
  *	The functions operate on a linked bitmap structure defined
- *	above
+ *	in power.h
  */
 
-static void free_bitmap(struct bitmap_page *bitmap)
+void free_bitmap(struct bitmap_page *bitmap)
 {
 	struct bitmap_page *bp;
 
@@ -223,7 +212,7 @@ static void free_bitmap(struct bitmap_pa
 	}
 }
 
-static struct bitmap_page *alloc_bitmap(unsigned int nr_bits)
+struct bitmap_page *alloc_bitmap(unsigned int nr_bits)
 {
 	struct bitmap_page *bitmap, *bp;
 	unsigned int n;
@@ -266,7 +255,7 @@ static inline int bitmap_set(struct bitm
 	return 0;
 }
 
-static unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap)
+unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap)
 {
 	unsigned long offset;
 
@@ -280,7 +269,7 @@ static unsigned long alloc_swap_page(int
 	return offset;
 }
 
-static void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
+void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
 {
 	unsigned int bit, n;
 	unsigned long test;
