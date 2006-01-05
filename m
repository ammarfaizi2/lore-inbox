Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752297AbWAEXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbWAEXcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbWAEXcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:32:53 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:23789 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1752297AbWAEXcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:32:52 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface (rev. 2)
Date: Fri, 6 Jan 2006 00:34:52 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200601042340.42118.rjw@sisk.pl> <20060105001837.GA1751@elf.ucw.cz> <20060105002619.GA16714@kroah.com>
In-Reply-To: <20060105002619.GA16714@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601060034.53707.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 5 January 2006 01:26, Greg KH wrote:
> On Thu, Jan 05, 2006 at 01:18:37AM +0100, Pavel Machek wrote:
> > > > +static int __init snapshot_dev_init(void)
> > > > +{
> > > > +	int error;
> > > > +
> > > > +	error =  alloc_chrdev_region(&interface.devno, 0, 1, interface.name);
> > > > +	if (error)
> > > > +		return error;
> > > > +	cdev_init(&interface.cdev, &snapshot_fops);
> > > > +	interface.cdev.ops = &snapshot_fops;
> > > > +	error = cdev_add(&interface.cdev, interface.devno, 1);
> > > > +	if (error)
> > > > +		goto Unregister;
> > > > +	error = sysfs_create_file(&power_subsys.kset.kobj, &snapshot_attr.attr);
> > > 
> > > Heh, that's a neat hack, register a sysfs file that contains the
> > > major:minor (there is a function that will print that the correct way,
> > > if you really want to do that), in sysfs.  It's better to just register
> > > a misc character device with the name "snapshot", and then udev will
> > > create your userspace node with the proper major:minor all automatically
> > > for you.
> > > 
> > > Unless you want to turn these into syscalls :)
> > 
> > Well, I think we simply want to get static major/minor allocated for
> > this device. It really uses read/write, IIRC, so no, I do not think we
> > want to make it a syscall.
> 
> Ok, then I'd recommend using the misc device, dynamic for now, and
> reserve one when you get a bit closer to merging into mainline.

Do you mean something like in the appended patch?

Rafael


Index: linux-2.6.15-mm1/kernel/power/user.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm1/kernel/power/user.c	2006-01-06 00:22:52.000000000 +0100
@@ -0,0 +1,294 @@
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
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/pm.h>
+#include <linux/uaccess.h>
+#include <linux/fs.h>
+
+#include "power.h"
+
+static struct snapshot_data {
+	struct snapshot_handle handle;
+	int swap;
+	struct bitmap_page *bitmap;
+	int mode;
+	char frozen;
+	char ready;
+} snapshot_state;
+
+static atomic_t device_available = ATOMIC_INIT(1);
+
+int snapshot_open(struct inode *inode, struct file *filp)
+{
+	struct snapshot_data *data;
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
+	data = &snapshot_state;
+	filp->private_data = data;
+	memset(&data->handle, 0, sizeof(struct snapshot_handle));
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
+		data->swap = swsusp_get_swap_index();
+		data->mode = O_RDONLY;
+	} else {
+		data->swap = -1;
+		data->mode = O_WRONLY;
+	}
+	data->bitmap = NULL;
+	data->frozen = 0;
+	data->ready = 0;
+
+	return 0;
+}
+
+int snapshot_release(struct inode *inode, struct file *filp)
+{
+	struct snapshot_data *data;
+
+	swsusp_free();
+	data = filp->private_data;
+	free_all_swap_pages(data->swap, data->bitmap);
+	free_bitmap(data->bitmap);
+	if (data->frozen) {
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
+	struct snapshot_data *data;
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
+	struct snapshot_data *data;
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
+	struct snapshot_data *data;
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
+		if (data->frozen)
+			break;
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
+		if (!data->frozen)
+			break;
+		down(&pm_sem);
+		thaw_processes();
+		enable_nonboot_cpus();
+		up(&pm_sem);
+		data->frozen = 0;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_SNAPSHOT:
+		if (data->mode != O_RDONLY || !data->frozen  || data->ready) {
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
+			data->ready = 1;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_RESTORE:
+		if (data->mode != O_WRONLY || !data->frozen ||
+		    !snapshot_image_loaded(&data->handle)) {
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
+		memset(&data->handle, 0, sizeof(struct snapshot_handle));
+		data->ready = 0;
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
+		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
+			error = -EINVAL;
+			break;
+		}
+		if (data->swap < 0 || data->swap >= MAX_SWAPFILES) {
+			error = -ENODEV;
+			break;
+		}
+		if (!data->bitmap) {
+			data->bitmap = alloc_bitmap(swsusp_total_swap(data->swap));
+			if (!data->bitmap) {
+				error = -ENOMEM;
+				break;
+			}
+		}
+		offset = alloc_swap_page(data->swap, data->bitmap);
+		if (offset)
+			__put_user(offset, (unsigned long __user *)arg);
+		else
+			error = -ENOSPC;
+		break;
+
+	case SNAPSHOT_IOCFREE_SWAP_PAGES:
+		if (data->swap >= 0 && data->swap < MAX_SWAPFILES) {
+			error = -ENODEV;
+			break;
+		}
+		free_all_swap_pages(data->swap, data->bitmap);
+		free_bitmap(data->bitmap);
+		data->bitmap = NULL;
+		break;
+
+	case SNAPSHOT_IOCSET_SWAP_FILE:
+		if (!data->bitmap) {
+			/*
+			 * User space encodes device types as two-byte values,
+			 * so we need to recode them
+			 */
+			data->swap = swsusp_get_swap_index_of(old_decode_dev(arg));
+			if (data->swap < 0)
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
+static struct miscdevice snapshot_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "snapshot",
+	.fops = &snapshot_fops,
+};
+
+static int __init snapshot_device_init(void)
+{
+	return misc_register(&snapshot_device);
+};
+
+device_initcall(snapshot_device_init);
