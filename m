Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWAXI1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWAXI1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWAXI1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:27:53 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46531 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932466AbWAXI1w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:27:52 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: userland interface (rev 2)
Date: Tue, 24 Jan 2006 09:29:37 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601240929.37676.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch introduces a user space interface for swsusp.

The interface is based on a special character device, called the snapshot
device, that allows user space processes to perform suspend and
resume-related operations with the help of some ioctls and the read()/write()
functions.  Additionally it allows these processes to allocate free swap pages
from a selected swap partition, called the resume partition, so that they know
which sectors of the resume partition are available to them.

The interface uses the same low-level system memory snapshot-handling
functions that are used by the built-it swap-writing/reading code of swsusp.

The interface documentation is included in the patch.

The patch assumes that the major and minor numbers of the snapshot device
will be 10 (ie. misc device) and 231, the registration of which has already been
requested.

Please apply (Pavel, please ack if it looks good).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 Documentation/power/userland-swsusp.txt |  149 +++++++++++++++
 init/do_mounts_initrd.c                 |    1 
 kernel/power/Makefile                   |    2 
 kernel/power/power.h                    |   14 +
 kernel/power/snapshot.c                 |    2 
 kernel/power/user.c                     |  302 ++++++++++++++++++++++++++++++++
 6 files changed, 469 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc1-mm2/Documentation/power/userland-swsusp.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc1-mm2/Documentation/power/userland-swsusp.txt	2006-01-23 16:04:12.000000000 +0100
@@ -0,0 +1,149 @@
+Documentation for userland software suspend interface
+	(C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+
+First, the warnings at the beginning of swsusp.txt still apply.
+
+Second, you should read the FAQ in swsusp.txt _now_ if you have not
+done it already.
+
+Now, to use the userland interface for software suspend you need special
+utilities that will read/write the system memory snapshot from/to the
+kernel.  Such utilities are available, for example, from
+<http://www.sisk.pl/kernel/utilities/suspend>.  You may want to have
+a look at them if you are going to develop your own suspend/resume
+utilities.
+
+The interface consists of a character device providing the open(),
+release(), read(), and write() operations as well as several ioctl()
+commands defined in kernel/power/power.h.  The major and minor
+numbers of the device are, respectively, 10 and 231, and they can
+be read from /sys/class/misc/snapshot/dev.
+
+The device can be open either for reading or for writing.  If open for
+reading, it is considered to be in the suspend mode.  Otherwise it is
+assumed to be in the resume mode.  The device cannot be open for reading
+and writing.  It is also impossible to have the device open more than once
+at a time.
+
+The ioctl() commands recognized by the device are:
+
+SNAPSHOT_FREEZE - freeze user space processes (the current process is
+	not frozen); this is required for SNAPSHOT_ATOMIC_SNAPSHOT
+	and SNAPSHOT_ATOMIC_RESTORE to succeed
+
+SNAPSHOT_UNFREEZE - thaw user space processes frozen by SNAPSHOT_FREEZE
+
+SNAPSHOT_ATOMIC_SNAPSHOT - create a snapshot of the system memory; the
+	last argument of ioctl() should be a pointer to an int variable,
+	the value of which will indicate whether the call returned after
+	creating the snapshot (1) or after restoring the system memory state
+	from it (0) (after resume the system finds itself finishing the
+	SNAPSHOT_ATOMIC_SNAPSHOT ioctl() again); after the snapshot
+	has been created the read() operation can be used to transfer
+	it out of the kernel
+
+SNAPSHOT_ATOMIC_RESTORE - restore the system memory state from the
+	uploaded snapshot image; before calling it you should transfer
+	the system memory snapshot back to the kernel using the write()
+	operation; this call will not succeed if the snapshot
+	image is not available to the kernel
+
+SNAPSHOT_FREE - free memory allocated for the snapshot image
+
+SNAPSHOT_SET_IMAGE_SIZE - set the preferred maximum size of the image
+	(the kernel will do its best to ensure the image size will not exceed
+	this number, but if it turns out to be impossible, the kernel will
+	create the smallest image possible)
+
+SNAPSHOT_AVAIL_SWAP - return the amount of available swap in bytes (the last
+	argument should be a pointer to an unsigned int variable that will
+	contain the result if the call is successful).
+
+SNAPSHOT_GET_SWAP_PAGE - allocate a swap page from the resume partition
+	(the last argument should be a pointer to a loff_t variable that
+	will contain the swap page offset if the call is successful)
+
+SNAPSHOT_FREE_SWAP_PAGES - free all swap pages allocated with
+	SNAPSHOT_GET_SWAP_PAGE
+
+SNAPSHOT_SET_SWAP_FILE - set the resume partition (the last ioctl() argument
+	should specify the device's major and minor numbers in the old
+	two-byte format, as returned by the stat() function in the .st_rdev
+	member of the stat structure); it is recommended to always use this
+	call, because the code to set the resume partition could be removed from
+	future kernels
+
+The device's read() operation can be used to transfer the snapshot image from
+the kernel.  It has the following limitations:
+- you cannot read() more than one virtual memory page at a time
+- read()s accross page boundaries are impossible (ie. if ypu read() 1/2 of
+	a page in the previous call, you will only be able to read()
+	_at_ _most_ 1/2 of the page in the next call)
+
+The device's write() operation is used for uploading the system memory snapshot
+into the kernel.  It has the same limitations as the read() operation.
+
+The release() operation frees all memory allocated for the snapshot image
+and all swap pages allocated with SNAPSHOT_GET_SWAP_PAGE (if any).
+Thus it is not necessary to use either SNAPSHOT_FREE or
+SNAPSHOT_FREE_SWAP_PAGES before closing the device (in fact it will also
+unfreeze user space processes frozen by SNAPSHOT_UNFREEZE if they are
+still frozen when the device is being closed).
+
+Currently it is assumed that the userland utilities reading/writing the
+snapshot image from/to the kernel will use a swap parition, called the resume
+partition, as storage space.  However, this is not really required, as they
+can use, for example, a special (blank) suspend partition or a file on a partition
+that is unmounted before SNAPSHOT_ATOMIC_SNAPSHOT and mounted afterwards.
+
+These utilities SHOULD NOT make any assumptions regarding the ordering of
+data within the snapshot image, except for the image header that MAY be
+assumed to start with an swsusp_info structure, as specified in
+kernel/power/power.h.  This structure MAY be used by the userland utilities
+to obtain some information about the snapshot image, such as the size
+of the snapshot image, including the metadata and the header itself,
+contained in the .size member of swsusp_info.
+
+The snapshot image MUST be written to the kernel unaltered (ie. all of the image
+data, metadata and header MUST be written in _exactly_ the same amount, form
+and order in which they have been read).  Otherwise, the behavior of the
+resumed system may be totally unpredictable.
+
+While executing SNAPSHOT_ATOMIC_RESTORE the kernel checks if the
+structure of the snapshot image is consistent with the information stored
+in the image header.  If any inconsistencies are detected,
+SNAPSHOT_ATOMIC_RESTORE will not succeed.  Still, this is not a fool-proof
+mechanism and the userland utilities using the interface SHOULD use additional
+means, such as checksums, to ensure the integrity of the snapshot image.
+
+The suspending and resuming utilities MUST lock themselves in memory,
+preferrably using mlockall(), before calling SNAPSHOT_FREEZE.
+
+The suspending utility MUST check the value stored by SNAPSHOT_ATOMIC_SNAPSHOT
+in the memory location pointed to by the last argument of ioctl() and proceed
+in accordance with it:
+1. 	If the value is 1 (ie. the system memory snapshot has just been
+	created and the system is ready for saving it):
+	(a)	The suspending utility MUST NOT close the snapshot device
+		_unless_ the whole suspend procedure is to be cancelled, in
+		which case, if the snapshot image has already been saved, the
+		suspending utility SHOULD destroy it, preferrably by zapping
+		its header.  If the suspend is not to be cancelled, the
+		system MUST be powered off or rebooted after the snapshot
+		image has been saved.
+	(b)	The suspending utility SHOULD NOT attempt to perform any
+		file system operations (including reads) on the file systems
+		that were mounted before SNAPSHOT_ATOMIC_SNAPSHOT has been
+		called.  However, it MAY mount a file system that was not
+		mounted at that time and perform some operations on it (eg.
+		use it for saving the image).
+2.	If the value is 0 (ie. the system state has just been restored from
+	the snapshot image), the suspending utility MUST close the snapshot
+	device.  Afterwards it will be treated as a regular userland process,
+	so it need not exit.
+
+The resuming utility SHOULD NOT attempt to mount any file systems that could
+be mounted before suspend and SHOULD NOT attempt to perform any operations
+involving such file systems.
+
+For details, please refer to the source code.
Index: linux-2.6.16-rc1-mm2/init/do_mounts_initrd.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/init/do_mounts_initrd.c	2006-01-23 15:53:39.000000000 +0100
+++ linux-2.6.16-rc1-mm2/init/do_mounts_initrd.c	2006-01-23 16:00:28.000000000 +0100
@@ -56,6 +56,7 @@
 	sys_chroot(".");
 	mount_devfs_fs ();
 
+	current->flags |= PF_NOFREEZE;
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
 		while (pid != sys_wait4(-1, NULL, 0, NULL))
Index: linux-2.6.16-rc1-mm2/kernel/power/Makefile
===================================================================
--- linux-2.6.16-rc1-mm2.orig/kernel/power/Makefile	2006-01-23 15:53:39.000000000 +0100
+++ linux-2.6.16-rc1-mm2/kernel/power/Makefile	2006-01-23 16:00:28.000000000 +0100
@@ -5,7 +5,7 @@
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
Index: linux-2.6.16-rc1-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.16-rc1-mm2.orig/kernel/power/power.h	2006-01-23 15:56:03.000000000 +0100
+++ linux-2.6.16-rc1-mm2/kernel/power/power.h	2006-01-23 16:04:12.000000000 +0100
@@ -16,6 +16,7 @@
 	int			cpus;
 	unsigned long		image_pages;
 	unsigned long		pages;
+	unsigned long		size;
 } __attribute__((aligned(PAGE_SIZE)));
 
 
@@ -76,6 +77,19 @@
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
 int snapshot_image_loaded(struct snapshot_handle *handle);
 
+#define SNAPSHOT_IOC_MAGIC	'3'
+#define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
+#define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
+#define SNAPSHOT_ATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
+#define SNAPSHOT_ATOMIC_RESTORE		_IO(SNAPSHOT_IOC_MAGIC, 4)
+#define SNAPSHOT_FREE			_IO(SNAPSHOT_IOC_MAGIC, 5)
+#define SNAPSHOT_SET_IMAGE_SIZE		_IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned long)
+#define SNAPSHOT_AVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
+#define SNAPSHOT_GET_SWAP_PAGE		_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
+#define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
+#define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
+#define SNAPSHOT_IOC_MAXNR	10
+
 /**
  *	The bitmap is used for tracing allocated swap pages
  *
Index: linux-2.6.16-rc1-mm2/kernel/power/user.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc1-mm2/kernel/power/user.c	2006-01-23 16:04:12.000000000 +0100
@@ -0,0 +1,302 @@
+/*
+ * linux/kernel/power/user.c
+ *
+ * This file provides the user space interface for software suspend/resume.
+ *
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
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
+#define SNAPSHOT_MINOR	231
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
+static int snapshot_open(struct inode *inode, struct file *filp)
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
+		data->swap = swap_type_of(swsusp_resume_device);
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
+static int snapshot_release(struct inode *inode, struct file *filp)
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
+	loff_t offset, avail;
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
+	case SNAPSHOT_FREEZE:
+		if (data->frozen)
+			break;
+		sys_sync();
+		down(&pm_sem);
+		pm_prepare_console();
+		disable_nonboot_cpus();
+		if (freeze_processes()) {
+			thaw_processes();
+			enable_nonboot_cpus();
+			pm_restore_console();
+			error = -EBUSY;
+		}
+		up(&pm_sem);
+		if (!error)
+			data->frozen = 1;
+		break;
+
+	case SNAPSHOT_UNFREEZE:
+		if (!data->frozen)
+			break;
+		down(&pm_sem);
+		thaw_processes();
+		enable_nonboot_cpus();
+		pm_restore_console();
+		up(&pm_sem);
+		data->frozen = 0;
+		break;
+
+	case SNAPSHOT_ATOMIC_SNAPSHOT:
+		if (data->mode != O_RDONLY || !data->frozen  || data->ready) {
+			error = -EPERM;
+			break;
+		}
+		down(&pm_sem);
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
+		up(&pm_sem);
+		if (!error)
+			error = put_user(in_suspend, (unsigned int __user *)arg);
+		if (!error)
+			data->ready = 1;
+		break;
+
+	case SNAPSHOT_ATOMIC_RESTORE:
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
+	case SNAPSHOT_FREE:
+		swsusp_free();
+		memset(&data->handle, 0, sizeof(struct snapshot_handle));
+		data->ready = 0;
+		break;
+
+	case SNAPSHOT_SET_IMAGE_SIZE:
+		image_size = arg;
+		break;
+
+	case SNAPSHOT_AVAIL_SWAP:
+		avail = count_swap_pages(data->swap, 1);
+		avail <<= PAGE_SHIFT;
+		error = put_user(avail, (loff_t __user *)arg);
+		break;
+
+	case SNAPSHOT_GET_SWAP_PAGE:
+		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
+			error = -EINVAL;
+			break;
+		}
+		if (data->swap < 0 || data->swap >= MAX_SWAPFILES) {
+			error = -ENODEV;
+			break;
+		}
+		if (!data->bitmap) {
+			data->bitmap = alloc_bitmap(count_swap_pages(data->swap, 0));
+			if (!data->bitmap) {
+				error = -ENOMEM;
+				break;
+			}
+		}
+		offset = alloc_swap_page(data->swap, data->bitmap);
+		if (offset) {
+			offset <<= PAGE_SHIFT;
+			__put_user(offset, (loff_t __user *)arg);
+		} else {
+			error = -ENOSPC;
+		}
+		break;
+
+	case SNAPSHOT_FREE_SWAP_PAGES:
+		if (data->swap >= 0 && data->swap < MAX_SWAPFILES) {
+			error = -ENODEV;
+			break;
+		}
+		free_all_swap_pages(data->swap, data->bitmap);
+		free_bitmap(data->bitmap);
+		data->bitmap = NULL;
+		break;
+
+	case SNAPSHOT_SET_SWAP_FILE:
+		if (!data->bitmap) {
+			/*
+			 * User space encodes device types as two-byte values,
+			 * so we need to recode them
+			 */
+			data->swap = swap_type_of(old_decode_dev(arg));
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
+	.minor = SNAPSHOT_MINOR,
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
Index: linux-2.6.16-rc1-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/kernel/power/snapshot.c	2006-01-23 15:45:38.000000000 +0100
+++ linux-2.6.16-rc1-mm2/kernel/power/snapshot.c	2006-01-23 16:04:12.000000000 +0100
@@ -525,6 +525,8 @@
 	info->cpus = num_online_cpus();
 	info->image_pages = nr_copy_pages;
 	info->pages = nr_copy_pages + nr_meta_pages + 1;
+	info->size = info->pages;
+	info->size <<= PAGE_SHIFT;
 }
 
 /**
