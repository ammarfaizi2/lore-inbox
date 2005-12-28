Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVL1Alg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVL1Alg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVL1AlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:41:16 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:32957 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932422AbVL1AlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:41:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM <linux-pm@osdl.org>
Subject: [RFC/RFT][PATCH -mm 2/4] swsusp: userland interface
Date: Wed, 28 Dec 2005 01:25:08 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200512280108.47253.rjw@sisk.pl>
In-Reply-To: <200512280108.47253.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512280125.08706.rjw@sisk.pl>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a user space interface for swsusp.  The interface is based
on the special character device allowing user space processes to perform
suspend and resume-related operations with the help of some ioctls and
the read()/write() functions.  Additionally it allows these processes to
allocate and/or free swap pages so that they know which sectors of
the resume partition are available to them.

Currently the major number of the device is allocated dynamically,
so it is exported via sysfs for convenience, but I'd like the device to
have a well-defined major number, if possible/acceptable.

The interface uses the same low-level snapshot-handling functions that
are used by the in-kernel swap-writing and reading code of swsusp.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 init/do_mounts_initrd.c |    1 
 kernel/power/Makefile   |    2 
 kernel/power/power.h    |   11 +
 kernel/power/user.c     |  276 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 289 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/user.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm3/kernel/power/user.c	2005-12-28 01:17:31.000000000 +0100
@@ -0,0 +1,276 @@
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
+extern int swsusp_get_swap_index(void);
+extern unsigned int swsusp_available_swap(unsigned int swap);
+extern int swsusp_shrink_memory(void);
+extern int swsusp_suspend(void);
+extern int swsusp_resume(void);
+
+struct snapshot_dev {
+	char *name;
+	dev_t devno;
+	struct cdev cdev;
+	struct snapshot_handle handle;
+	int swap;
+	int mode;
+	int frozen;
+};
+
+static atomic_t device_available = ATOMIC_INIT(1);
+
+int snapshot_open(struct inode *inode, struct file *filp)
+{
+	struct snapshot_dev *data;
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
+	data = container_of(inode->i_cdev, struct snapshot_dev, cdev);
+	filp->private_data = data;
+	memset(&data->handle, 0, sizeof(struct snapshot_handle));
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
+		data->swap = swsusp_get_swap_index();
+		data->mode = O_RDONLY;
+	} else {
+		data->swap = -1;
+		data->mode = O_WRONLY;
+	}
+	data->frozen = 0;
+
+	return 0;
+}
+
+int snapshot_release(struct inode *inode, struct file *filp)
+{
+	swsusp_free();
+	atomic_inc(&device_available);
+	return 0;
+}
+
+static ssize_t snapshot_read(struct file *filp, char __user *buf,
+                             size_t count, loff_t *offp)
+{
+	struct snapshot_dev *data;
+	ssize_t res;
+
+	data = filp->private_data;
+	res = snapshot_read_next(&data->handle, count);
+	if (res > 0) {
+		if (copy_to_user(buf, data_of(data->handle), res))
+			res = -EFAULT;
+		else
+			*offp = data->handle.offset;
+	}
+	return res;
+}
+
+static ssize_t snapshot_write(struct file *filp, const char __user *buf,
+                              size_t count, loff_t *offp)
+{
+	struct snapshot_dev *data;
+	ssize_t res;
+
+	data = filp->private_data;
+	res = snapshot_write_next(&data->handle, count);
+	if (res > 0) {
+		if (copy_from_user(data_of(data->handle), buf, res))
+			res = -EFAULT;
+		else
+			*offp = data->handle.offset;
+	}
+	return res;
+}
+
+static int snapshot_ioctl(struct inode *inode, struct file *filp,
+                          unsigned int cmd, unsigned long arg)
+{
+	int error = 0;
+	struct snapshot_dev *data;
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
+	data = filp->private_data;
+
+	switch (cmd) {
+
+	case SNAPSHOT_IOCFREEZE:
+		sys_sync();
+		down(&pm_sem);
+		disable_nonboot_cpus();
+		if (freeze_processes())
+			error = -EBUSY;
+		up(&pm_sem);
+		if (!error)
+			data->frozen = 1;
+		break;
+
+	case SNAPSHOT_IOCUNFREEZE:
+		down(&pm_sem);
+		thaw_processes();
+		enable_nonboot_cpus();
+		up(&pm_sem);
+		data->frozen = 0;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_SNAPSHOT:
+		if (data->mode != O_RDONLY || !data->frozen) {
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
+		break;
+
+	case SNAPSHOT_IOCATOMIC_RESTORE:
+		if (data->mode != O_WRONLY || !data->frozen ||
+		    !snapshot_image_ready(&data->handle)) {
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
+	case SNAPSHOT_IOCSET_IMAGE_SIZE:
+		image_size = arg;
+		break;
+
+	case SNAPSHOT_IOCAVAIL_SWAP:
+		n = swsusp_available_swap(data->swap);
+		error = put_user(n, (unsigned int __user *)arg);
+		break;
+
+	case SNAPSHOT_IOCGET_SWAP_PAGE:
+		if (data->swap >= 0 && data->swap < MAX_SWAPFILES) {
+			offset = swp_offset(get_swap_page_of_type(data->swap));
+			if (offset)
+				error = put_user(offset, (unsigned long __user *)arg);
+			else
+				error = -ENOSPC;
+		} else {
+			error = -ENODEV;
+		}
+		break;
+
+	case SNAPSHOT_IOCFREE_SWAP_PAGE:
+		if (data->swap >= 0 && data->swap < MAX_SWAPFILES)
+			swap_free(swp_entry(data->swap, arg));
+		else
+			error = -ENODEV;
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
--- linux-2.6.15-rc5-mm3.orig/kernel/power/Makefile	2005-12-28 01:16:46.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/Makefile	2005-12-28 01:17:31.000000000 +0100
@@ -5,7 +5,7 @@ endif
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o user.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
Index: linux-2.6.15-rc5-mm3/init/do_mounts_initrd.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/init/do_mounts_initrd.c	2005-12-28 01:16:46.000000000 +0100
+++ linux-2.6.15-rc5-mm3/init/do_mounts_initrd.c	2005-12-28 01:17:31.000000000 +0100
@@ -56,6 +56,7 @@ static void __init handle_initrd(void)
 	sys_chroot(".");
 	mount_devfs_fs ();
 
+	current->flags |= PF_NOFREEZE;
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
 		while (pid != sys_wait4(-1, NULL, 0, NULL))
Index: linux-2.6.15-rc5-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/power.h	2005-12-28 01:17:06.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/power.h	2005-12-28 01:17:53.000000000 +0100
@@ -77,3 +77,14 @@ struct snapshot_handle {
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
 int snapshot_image_ready(struct snapshot_handle *handle);
+
+#define SNAPSHOT_IOC_MAGIC	'3'
+#define SNAPSHOT_IOCFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 1)
+#define SNAPSHOT_IOCUNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
+#define SNAPSHOT_IOCATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
+#define SNAPSHOT_IOCATOMIC_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 4)
+#define SNAPSHOT_IOCSET_IMAGE_SIZE	_IOW(SNAPSHOT_IOC_MAGIC, 5, unsigned long)
+#define SNAPSHOT_IOCAVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 6, void *)
+#define SNAPSHOT_IOCGET_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
+#define SNAPSHOT_IOCFREE_SWAP_PAGE	_IOW(SNAPSHOT_IOC_MAGIC, 8, unsigned long)
+#define SNAPSHOT_IOC_MAXNR	8

