Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161316AbWALVkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWALVkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161317AbWALVkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:40:20 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:49334 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161316AbWALVkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:40:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM <linux-pm@osdl.org>
Subject: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Thu, 12 Jan 2006 22:41:06 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zzsxDYRqhzzwfFT"
Message-Id: <200601122241.07363.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_zzsxDYRqhzzwfFT
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This is the next version of the patch that adds a user space interface to
swsusp.

The interface is based on the special character device allowing user space
processes to perform suspend and resume-related operations with the help
of some ioctls and the read()/write() functions. =A0Additionally it allows =
these
processes to allocate and free swap pages so that they know which sectors
of the resume partition are available to them.

The interface uses the same low-level snapshot-handling functions that
are used by the in-kernel swap-writing/reading code of swsusp.

The patch assumes that the major and minor numbers of the device will be
10 (ie. misc device) and 231, the registration of which has already been
requested.

It contains some documentation of the interface, and there are very simple
demo userland utilities using the interface available at:
http://www.sisk.pl/kernel/utilities/suspend/
They are also attached to this message.

The "suspend" utility is designed to work from the (root) shell, but the
"resume" utility should be invoked from an initrd (I just point /linuxrc to
it and start the kernel with the "noresume" command line parameter to
prevent the in-kernel resume code from reading the image). =A0The utilities=
 are
intentionally 100% compatible with the in-kernel swap-writing and reading
code (ie. the image created by "suspend" can be restored by the in-kernel
code etc.).

The patch applies on top of the 2.6.15-mm3 kernel.

Please review it and if you can, please give it a try.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 Documentation/power/userland-swsusp.txt |  119 ++++++++++++
 init/do_mounts_initrd.c                 |    1=20
 kernel/power/Makefile                   |    2=20
 kernel/power/power.h                    |   13 +
 kernel/power/user.c                     |  296 +++++++++++++++++++++++++++=
+++++
 5 files changed, 430 insertions(+), 1 deletion(-)

Index: linux-2.6.15-mm3/kernel/power/user.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm3/kernel/power/user.c	2006-01-12 22:11:23.000000000 +0100
@@ -0,0 +1,296 @@
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
+static atomic_t device_available =3D ATOMIC_INIT(1);
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
+	if ((filp->f_flags & O_ACCMODE) =3D=3D O_RDWR)
+		return -ENOSYS;
+
+	nonseekable_open(inode, filp);
+	data =3D &snapshot_state;
+	filp->private_data =3D data;
+	memset(&data->handle, 0, sizeof(struct snapshot_handle));
+	if ((filp->f_flags & O_ACCMODE) =3D=3D O_RDONLY) {
+		data->swap =3D swap_type_of(swsusp_resume_device);
+		data->mode =3D O_RDONLY;
+	} else {
+		data->swap =3D -1;
+		data->mode =3D O_WRONLY;
+	}
+	data->bitmap =3D NULL;
+	data->frozen =3D 0;
+	data->ready =3D 0;
+
+	return 0;
+}
+
+int snapshot_release(struct inode *inode, struct file *filp)
+{
+	struct snapshot_data *data;
+
+	swsusp_free();
+	data =3D filp->private_data;
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
+	data =3D filp->private_data;
+	res =3D snapshot_read_next(&data->handle, count);
+	if (res > 0) {
+		if (copy_to_user(buf, data_of(data->handle), res))
+			res =3D -EFAULT;
+		else
+			*offp =3D data->handle.offset;
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
+	data =3D filp->private_data;
+	res =3D snapshot_write_next(&data->handle, count);
+	if (res > 0) {
+		if (copy_from_user(data_of(data->handle), buf, res))
+			res =3D -EFAULT;
+		else
+			*offp =3D data->handle.offset;
+	}
+	return res;
+}
+
+static int snapshot_ioctl(struct inode *inode, struct file *filp,
+                          unsigned int cmd, unsigned long arg)
+{
+	int error =3D 0;
+	struct snapshot_data *data;
+	unsigned long offset;
+	unsigned int n;
+
+	if (_IOC_TYPE(cmd) !=3D SNAPSHOT_IOC_MAGIC)
+		return -ENOTTY;
+	if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR)
+		return -ENOTTY;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	data =3D filp->private_data;
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
+			error =3D -EBUSY;
+		up(&pm_sem);
+		if (!error)
+			data->frozen =3D 1;
+		break;
+
+	case SNAPSHOT_IOCUNFREEZE:
+		if (!data->frozen)
+			break;
+		down(&pm_sem);
+		thaw_processes();
+		enable_nonboot_cpus();
+		up(&pm_sem);
+		data->frozen =3D 0;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_SNAPSHOT:
+		if (data->mode !=3D O_RDONLY || !data->frozen  || data->ready) {
+			error =3D -EPERM;
+			break;
+		}
+		down(&pm_sem);
+		pm_prepare_console();
+		/* Free memory before shutting down devices. */
+		error =3D swsusp_shrink_memory();
+		if (!error) {
+			error =3D device_suspend(PMSG_FREEZE);
+			if (!error) {
+				in_suspend =3D 1;
+				error =3D swsusp_suspend();
+				device_resume();
+			}
+		}
+		pm_restore_console();
+		up(&pm_sem);
+		if (!error)
+			error =3D put_user(in_suspend, (unsigned int __user *)arg);
+		if (!error)
+			data->ready =3D 1;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_RESTORE:
+		if (data->mode !=3D O_WRONLY || !data->frozen ||
+		    !snapshot_image_loaded(&data->handle)) {
+			error =3D -EPERM;
+			break;
+		}
+		down(&pm_sem);
+		pm_prepare_console();
+		error =3D device_suspend(PMSG_FREEZE);
+		if (!error) {
+			mb();
+			error =3D swsusp_resume();
+			device_resume();
+		}
+		pm_restore_console();
+		up(&pm_sem);
+		break;
+
+	case SNAPSHOT_IOCFREE:
+		swsusp_free();
+		memset(&data->handle, 0, sizeof(struct snapshot_handle));
+		data->ready =3D 0;
+		break;
+
+	case SNAPSHOT_IOCSET_IMAGE_SIZE:
+		image_size =3D arg;
+		break;
+
+	case SNAPSHOT_IOCAVAIL_SWAP:
+		n =3D count_swap_pages(data->swap, 1);
+		error =3D put_user(n, (unsigned int __user *)arg);
+		break;
+
+	case SNAPSHOT_IOCGET_SWAP_PAGE:
+		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd)=
)) {
+			error =3D -EINVAL;
+			break;
+		}
+		if (data->swap < 0 || data->swap >=3D MAX_SWAPFILES) {
+			error =3D -ENODEV;
+			break;
+		}
+		if (!data->bitmap) {
+			data->bitmap =3D alloc_bitmap(count_swap_pages(data->swap, 0));
+			if (!data->bitmap) {
+				error =3D -ENOMEM;
+				break;
+			}
+		}
+		offset =3D alloc_swap_page(data->swap, data->bitmap);
+		if (offset)
+			__put_user(offset, (unsigned long __user *)arg);
+		else
+			error =3D -ENOSPC;
+		break;
+
+	case SNAPSHOT_IOCFREE_SWAP_PAGES:
+		if (data->swap >=3D 0 && data->swap < MAX_SWAPFILES) {
+			error =3D -ENODEV;
+			break;
+		}
+		free_all_swap_pages(data->swap, data->bitmap);
+		free_bitmap(data->bitmap);
+		data->bitmap =3D NULL;
+		break;
+
+	case SNAPSHOT_IOCSET_SWAP_FILE:
+		if (!data->bitmap) {
+			/*
+			 * User space encodes device types as two-byte values,
+			 * so we need to recode them
+			 */
+			data->swap =3D swap_type_of(old_decode_dev(arg));
+			if (data->swap < 0)
+				error =3D -ENODEV;
+		} else {
+			error =3D -EPERM;
+		}
+		break;
+
+	default:
+		error =3D -ENOTTY;
+
+	}
+
+	return error;
+}
+
+static struct file_operations snapshot_fops =3D {
+	.open =3D snapshot_open,
+	.release =3D snapshot_release,
+	.read =3D snapshot_read,
+	.write =3D snapshot_write,
+	.llseek =3D no_llseek,
+	.ioctl =3D snapshot_ioctl,
+};
+
+static struct miscdevice snapshot_device =3D {
+	.minor =3D SNAPSHOT_MINOR,
+	.name =3D "snapshot",
+	.fops =3D &snapshot_fops,
+};
+
+static int __init snapshot_device_init(void)
+{
+	return misc_register(&snapshot_device);
+};
+
+device_initcall(snapshot_device_init);
Index: linux-2.6.15-mm3/kernel/power/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-mm3.orig/kernel/power/Makefile	2006-01-12 22:11:12.00000=
0000 +0100
+++ linux-2.6.15-mm3/kernel/power/Makefile	2006-01-12 22:11:23.000000000 +0=
100
@@ -5,7 +5,7 @@ endif
=20
 obj-y				:=3D main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+=3D pm.o
=2Dobj-$(CONFIG_SOFTWARE_SUSPEND)	+=3D swsusp.o disk.o snapshot.o swap.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+=3D swsusp.o disk.o snapshot.o swap.o user=
=2Eo
=20
 obj-$(CONFIG_SUSPEND_SMP)	+=3D smp.o
=20
Index: linux-2.6.15-mm3/init/do_mounts_initrd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-mm3.orig/init/do_mounts_initrd.c	2006-01-12 22:11:12.000=
000000 +0100
+++ linux-2.6.15-mm3/init/do_mounts_initrd.c	2006-01-12 22:11:23.000000000 =
+0100
@@ -56,6 +56,7 @@ static void __init handle_initrd(void)
 	sys_chroot(".");
 	mount_devfs_fs ();
=20
+	current->flags |=3D PF_NOFREEZE;
 	pid =3D kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
 		while (pid !=3D sys_wait4(-1, NULL, 0, NULL))
Index: linux-2.6.15-mm3/kernel/power/power.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-mm3.orig/kernel/power/power.h	2006-01-12 22:11:12.000000=
000 +0100
+++ linux-2.6.15-mm3/kernel/power/power.h	2006-01-12 22:11:23.000000000 +01=
00
@@ -78,6 +78,19 @@ extern int snapshot_read_next(struct sna
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t coun=
t);
 int snapshot_image_loaded(struct snapshot_handle *handle);
=20
+#define SNAPSHOT_IOC_MAGIC	'3'
+#define SNAPSHOT_IOCFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 1)
+#define SNAPSHOT_IOCUNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
+#define SNAPSHOT_IOCATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
+#define SNAPSHOT_IOCATOMIC_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 4)
+#define SNAPSHOT_IOCFREE		_IO(SNAPSHOT_IOC_MAGIC, 5)
+#define SNAPSHOT_IOCSET_IMAGE_SIZE	_IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned lo=
ng)
+#define SNAPSHOT_IOCAVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
+#define SNAPSHOT_IOCGET_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
+#define SNAPSHOT_IOCFREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
+#define SNAPSHOT_IOCSET_SWAP_FILE	_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned in=
t)
+#define SNAPSHOT_IOC_MAXNR	10
+
 /**
  *	The bitmap is used for tracing allocated swap pages
  *
Index: linux-2.6.15-mm3/Documentation/power/userland-swsusp.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm3/Documentation/power/userland-swsusp.txt	2006-01-12 22:=
16:29.000000000 +0100
@@ -0,0 +1,119 @@
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
+and writing.  It is also imposiible to have the device open more than once
+at a time.
+
+The ioctl() commands recognized by the device are:
+
+SNAPSHOT_IOCFREEZE - freeze user space processes (the current process is
+	not frozen); this is required for SNAPSHOT_IOCATOMIC_SNAPSHOT
+	and SNAPSHOT_IOCATOMIC_RESTORE to succeed
+
+SNAPSHOT_IOCUNFREEZE - thaw user space processes frozen by SNAPSHOT_IOCFRE=
EZE
+
+SNAPSHOT_IOCATOMIC_SNAPSHOT - create a snapshot of the system memory; the
+	last argument of ioctl() should be a pointer to an int variable,
+	the value of which will indicate whether the call returned after
+	creating the snapshot (1) or after restoring the system memory state
+	from it (0) (after resume the system finds itself finishing the
+	SNAPSHOT_IOCATOMIC_SNAPSHOT ioctl() again); after the snapshot
+	has been created the read() operation can be used to transfer
+	it out of the kernel
+
+SNAPSHOT_IOCATOMIC_RESTORE - restore the system memory state from the
+	uploaded snapshot image; before calling it you should transfer
+	the systme memory snapshot back to the kernel using the write()
+	operation; this call will not succeed if the snapshot
+	image is not available to the kernel
+
+SNAPSHOT_IOCFREE - free memory allocated for the snapshot image
+
+SNAPSHOT_IOCSET_IMAGE_SIZE - set the preferred maximum size of the image
+	(the kernel will do its best to ensure the image size will not exceed
+	this number, but if it turns out to be impossible, the kernel will
+	create the smallest image possible)
+
+SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argu=
ment
+	should be a pointer to an unsigned int variable that will contain
+	the result if the call is successful)
+
+SNAPSHOT_IOCGET_SWAP_PAGE - allocate a swap page from the resume partition
+	(the last argument should be a pointer to an unsigned int variable that
+	will contain the swap page offset if the call is successful)
+
+SNAPSHOT_IOCFREE_SWAP_PAGES - free all swap pages allocated with
+	SNAPSHOT_IOCGET_SWAP_PAGE
+
+SNAPSHOT_IOCSET_SWAP_FILE - set the resume partition (the last ioctl() arg=
ument
+	should specify the device's major and minor numbers in the old
+	two-byte format, as returned by the stat() function in the .st_rdev
+	member of the stat structure); it is recommended to always use this
+	call, because the other code the could have set the resume partition
+	need not be present in the kernel
+
+The device's read() operation can be used to transfer the snapshot image f=
rom
+the kernel.  It has the following limitations:
+- you cannot read() more than one virtual memory page at a time
+- read()s accross page boundaries are impossible (ie. if ypu read() 1/2 of
+	a page in the previous call, you will only be able to read()
+	_at_ _most_ 1/2 of the page in the next call)
+
+The device's write() operation is used for uploading the system memory sna=
pshot
+into the kernel.  It has the same limitations as the read() operation.
+
+The release() operation frees all memory allocated for the snapshot image
+and all swap pages allocated with SNAPSHOT_IOCGET_SWAP_PAGE (if any).
+Thus it is not necessary to use either SNAPSHOT_IOCFREE or
+SNAPSHOT_IOCFREE_SWAP_PAGES before closing the device (in fact it will also
+unfreeze user space processes frozen by SNAPSHOT_IOCUNFREEZE if they are
+still frozen when the device is being closed).
+
+Currently it is assumed that the userland utilities reading/writing the
+snapshot image from/to the kernel will use a swap parition, called the res=
ume
+partition, as storage space.  However, this is not really required, as they
+can use, for example, a special (blank) suspend partition or a file on a p=
artition
+that is unmounted before SNAPSHOT_IOCATOMIC_SNAPSHOT and mounted afterward=
s.
+
+These utilities SHOULD NOT make any assumptions regarding the ordering of
+data within the snapshot image, except for the image header that MAY be
+assumed to start with an swsusp_info structure, as specified in
+kernel/power/power.h.  This structure MAY be used by the userland utilities
+to obtain some information about the snapshot image, such as the total
+number of the image pages, including the metadata and the header itself,
+contained in the .pages member of swsusp_info.
+
+The snapshot image MUST be written to the kernel unaltered (ie. all of the=
 image
+data, metadata and header MUST be written in _exactly_ the same amount, fo=
rm
+and order in which they have been read).  Otherwise, the behavior of the
+resumed system may be totally unpredictable.
+
+While executing SNAPSHOT_IOCATOMIC_RESTORE the kernel checks if the
+structure of the snapshot image is consistent with the information stored
+in the image header.  If any inconsistencies are detected,
+SNAPSHOT_IOCATOMIC_RESTORE will not succeed.  Still, this is not a fool-pr=
oof
+mechanism and the userland utilities using the interface SHOULD use additi=
onal
+means, such as checksums, to ensure the integrity of the snapshot image.
+
+For details, please refer to the source code.

--Boundary-00=_zzsxDYRqhzzwfFT
Content-Type: text/x-chdr;
  charset="iso-8859-2";
  name="swsusp.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp.h"

/*
 * swsusp.h
 *
 * Common definitions for user space suspend and resume handlers.
 *
 * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
 *
 * This file is released under the GPLv2.
 *
 */

#define PAGE_SHIFT	12
#define PAGE_SIZE	(1UL << PAGE_SHIFT)

#define SNAPSHOT_IOC_MAGIC	'3'
#define SNAPSHOT_IOCFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 1)
#define SNAPSHOT_IOCUNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
#define SNAPSHOT_IOCATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
#define SNAPSHOT_IOCATOMIC_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 4)
#define SNAPSHOT_IOCFREE		_IO(SNAPSHOT_IOC_MAGIC, 5)
#define SNAPSHOT_IOCSET_IMAGE_SIZE	_IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned long)
#define SNAPSHOT_IOCAVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
#define SNAPSHOT_IOCGET_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
#define SNAPSHOT_IOCFREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
#define SNAPSHOT_IOCSET_SWAP_FILE	_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
#define SNAPSHOT_IOC_MAXNR	10

#define	LINUX_REBOOT_MAGIC1	0xfee1dead
#define	LINUX_REBOOT_MAGIC2	672274793

#define LINUX_REBOOT_CMD_RESTART	0x01234567
#define LINUX_REBOOT_CMD_HALT		0xCDEF0123
#define LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
#define LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
#define LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2

struct new_utsname {
	char sysname[65];
	char nodename[65];
	char release[65];
	char version[65];
	char machine[65];
	char domainname[65];
};

struct swsusp_info {
	struct new_utsname	uts;
	unsigned int		version_code;
	unsigned long		num_physpages;
	int			cpus;
	unsigned long		image_pages;
	unsigned long		pages;
} __attribute__((aligned(PAGE_SIZE)));

#define SWSUSP_SIG	"S1SUSPEND"

struct swsusp_header {
	char reserved[PAGE_SIZE - 20 - sizeof(long)];
	unsigned long image;
	char	orig_sig[10];
	char	sig[10];
} __attribute__((packed, aligned(PAGE_SIZE)));

static inline int freeze(int dev)
{
	return ioctl(dev, SNAPSHOT_IOCFREEZE, 0);
}

static inline int unfreeze(int dev)
{
	return ioctl(dev, SNAPSHOT_IOCUNFREEZE, 0);
}

static inline int atomic_snapshot(int dev, int *in_suspend)
{
	return ioctl(dev, SNAPSHOT_IOCATOMIC_SNAPSHOT, in_suspend);
}

static inline int atomic_restore(int dev)
{
	return ioctl(dev, SNAPSHOT_IOCATOMIC_RESTORE, 0);
}

static inline int free_snapshot(int dev)
{
	return ioctl(dev, SNAPSHOT_IOCFREE, 0);
}

static inline int set_image_size(int dev, unsigned int size)
{
	return ioctl(dev, SNAPSHOT_IOCSET_IMAGE_SIZE, size);
}

static inline void reboot(void)
{
	syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
		LINUX_REBOOT_CMD_RESTART, 0);
}

static inline void power_off(void)
{
	syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
		LINUX_REBOOT_CMD_POWER_OFF, 0);
}

/*
 *	The swap map is a data structure used for keeping track of each page
 *	written to a swap partition.  It consists of many swap_map_page
 *	structures that contain each an array of MAP_PAGE_SIZE swap entries.
 *	These structures are stored on the swap and linked together with the
 *	help of the .next_swap member.
 *
 *	The swap map is created during suspend.  The swap map pages are
 *	allocated and populated one at a time, so we only need one memory
 *	page to set up the entire structure.
 *
 *	During resume we also only need to use one swap_map_page structure
 *	at a time.
 */

#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(long) - 1)

struct swap_map_page {
	unsigned long		entries[MAP_PAGE_ENTRIES];
	unsigned long		next_swap;
};

#define SNAPSHOT_DEVICE	"/dev/snapshot"
#define RESUME_DEVICE "/dev/hdc3"

#define DEFAULT_IMAGE_SIZE	500


--Boundary-00=_zzsxDYRqhzzwfFT
Content-Type: text/x-csrc;
  charset="iso-8859-2";
  name="suspend.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="suspend.c"

/*
 * suspend.c
 *
 * A simple user space suspend handler for swsusp.
 *
 * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
 *
 * This file is released under the GPLv2.
 *
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <syscall.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "swsusp.h"

static int dev;
static char buffer[PAGE_SIZE];
static struct swsusp_header swsusp_header;

static inline unsigned int check_free_swap(void)
{
	int error;
	unsigned int free_swap;

	error = ioctl(dev, SNAPSHOT_IOCAVAIL_SWAP, &free_swap);
	if (!error)
		return free_swap;
	else
		printf("Error: errno = %d\n", errno);
	return 0;
}

static inline unsigned long get_swap_page(void)
{
	int error;
	unsigned long offset;

	error = ioctl(dev, SNAPSHOT_IOCGET_SWAP_PAGE, &offset);
	if (!error)
		return offset;
	return 0;
}

static inline int free_swap_pages(void)
{
	return ioctl(dev, SNAPSHOT_IOCFREE_SWAP_PAGES, 0);
}

static inline int set_swap_file(dev_t blkdev)
{
	return ioctl(dev, SNAPSHOT_IOCSET_SWAP_FILE, blkdev);
}

/**
 *	write_page - Write one page to given swap location.
 *	@fd:		File handle of the resume partition
 *	@buf:		Pointer to the area we're writing.
 *	@swap_offset:	Offset of the swap page we're writing to.
 */

static int write_page(int fd, void *buf, unsigned long swap_offset)
{
	off_t offset;
	int res = -EINVAL;
	ssize_t cnt = 0;

	if (swap_offset) {
		offset = swap_offset * PAGE_SIZE;
		if (lseek(fd, offset, SEEK_SET) == offset) 
			cnt = write(fd, buf, PAGE_SIZE);
		if (cnt == PAGE_SIZE)
			res = 0;
		else
			res = cnt < 0 ? cnt : -EIO;
	}
	return res;
}

/*
 *	The swap_map_handle structure is used for handling swap in
 *	a file-alike way
 */

struct swap_map_handle {
	struct swap_map_page cur;
	unsigned long cur_swap;
	unsigned int k;
	int fd;
};

static inline int init_swap_writer(struct swap_map_handle *handle, int fd)
{
	memset(&handle->cur, 0, PAGE_SIZE);
	handle->cur_swap = get_swap_page();
	if (!handle->cur_swap)
		return -ENOSPC;
	handle->k = 0;
	handle->fd = fd;
	return 0;
}

static int swap_write_page(struct swap_map_handle *handle, void *buf)
{
	int error;
	unsigned long offset;

	offset = get_swap_page();
	error = write_page(handle->fd, buf, offset);
	if (error)
		return error;
	handle->cur.entries[handle->k++] = offset;
	if (handle->k >= MAP_PAGE_ENTRIES) {
		offset = get_swap_page();
		if (!offset)
			return -ENOSPC;
		handle->cur.next_swap = offset;
		error = write_page(handle->fd, &handle->cur, handle->cur_swap);
		if (error)
			return error;
		memset(&handle->cur, 0, PAGE_SIZE);
		handle->cur_swap = offset;
		handle->k = 0;
	}
	return 0;
}

static inline int flush_swap_writer(struct swap_map_handle *handle)
{
	if (handle->cur_swap)
		return write_page(handle->fd, &handle->cur, handle->cur_swap);
	else
		return -EINVAL;
}

/**
 *	save_image - save the suspend image data
 */

static int save_image(struct swap_map_handle *handle,
                      unsigned int nr_pages)
{
	unsigned int m;
	int ret;
	int error = 0;

	printf("suspend: Saving image data pages (%u pages) ...     ", nr_pages);
	m = nr_pages / 100;
	if (!m)
		m = 1;
	nr_pages = 0;
	do {
		ret = read(dev, buffer, PAGE_SIZE);
		if (ret > 0) {
			error = swap_write_page(handle, buffer);
			if (error)
				break;
			if (!(nr_pages % m))
				printf("\b\b\b\b%3d%%", nr_pages / m);
			nr_pages++;
		}
	} while (ret > 0);
	if (!error)
		printf(" done\n");
	return error;
}

/**
 *	enough_swap - Make sure we have enough swap to save the image.
 *
 *	Returns TRUE or FALSE after checking the total amount of swap
 *	space avaiable from the resume partition.
 */

static int enough_swap(unsigned int nr_pages)
{
	unsigned int free_swap = check_free_swap();

	printf("suspend: Free swap pages: %u\n", free_swap);
	return free_swap > nr_pages;
}

static int mark_swap(int fd, unsigned long start)
{
	int error = 0;

	lseek(fd, 0, SEEK_SET);
	if (read(fd, &swsusp_header, PAGE_SIZE) < PAGE_SIZE)
		return -EIO;
	if (!memcmp("SWAP-SPACE", swsusp_header.sig, 10) ||
	    !memcmp("SWAPSPACE2", swsusp_header.sig, 10)) {
		memcpy(swsusp_header.orig_sig, swsusp_header.sig, 10);
		memcpy(swsusp_header.sig, SWSUSP_SIG, 10);
		swsusp_header.image = start;
		lseek(fd, 0, SEEK_SET);
		if (write(fd, &swsusp_header, PAGE_SIZE) < PAGE_SIZE)
			error = -EIO;
	} else {
		printf("suspend: Device is not a swap space.\n");
		error = -ENODEV;
	}
	return error;
}

/**
 *	write_image - Write entire image and metadata.
 */

int write_image(char *resume_dev_name)
{
	static struct swap_map_handle handle;
	struct swsusp_info *header;
	unsigned long start;
	int fd;
	int error;

	fd = open(resume_dev_name, O_RDWR | O_SYNC);
	if (fd < 0) {
		printf("suspend: Could not open resume device\n");
		return error;
	}
	error = read(dev, buffer, PAGE_SIZE);
	if (error < PAGE_SIZE)
		return error < 0 ? error : -EFAULT;
	header = (struct swsusp_info *)buffer;
	if (!enough_swap(header->pages)) {
		printf("suspend: Not enough free swap\n");
		return -ENOSPC;
	}
	error = init_swap_writer(&handle, fd);
	if (!error) {
		start = handle.cur_swap;
		error = swap_write_page(&handle, header);
	}
	if (!error)
		error = save_image(&handle, header->pages - 1);
	if (!error) {
		flush_swap_writer(&handle);
		printf( "S" );
		error = mark_swap(fd, start);
		printf( "|\n" );
	}
	fsync(fd);
	close(fd);
	return error;
}

int main(int argc, char *argv[])
{
	char *snapshot_device_name, *resume_device_name;
	struct stat *stat_buf;
	int image_size;
	int error;
	int in_suspend;

	resume_device_name = argc <= 2 ? RESUME_DEVICE : argv[2];
	snapshot_device_name = argc <= 1 ? SNAPSHOT_DEVICE : argv[1];

	stat_buf = (struct stat *)buffer;
	if (stat(resume_device_name, stat_buf)) {
		fprintf(stderr, "Could not stat the resume device file\n");
		return -ENODEV;
	}
	if (!S_ISBLK(stat_buf->st_mode)) {
		fprintf(stderr, "Invalid resume device\n");
		return -EINVAL;
	}

	sync();
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);

	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
		fprintf(stderr, "Could not lock myself\n");
		return 1;
	}

	error = 0;
	dev = open(snapshot_device_name, O_RDONLY);
	if (dev < 0)
		return -ENOENT;
	if (set_swap_file(stat_buf->st_rdev)) {
		fprintf(stderr, "Could not set the resume device file\n");
		error = errno;
		goto Close;
	}
	image_size = check_free_swap();
	if (image_size <= 0) {
		fprintf(stderr, "No swap space for suspend\n");
		error = -ENOSPC;
		goto Close;
	}
	if (image_size > DEFAULT_IMAGE_SIZE)
		image_size = DEFAULT_IMAGE_SIZE;
	if (freeze(dev)) {
		fprintf(stderr, "Could not freeze processes\n");
		error = errno;
		goto Close;
	}
	while (image_size >= 0) {
		if (set_image_size(dev, image_size)) {
			fprintf(stderr, "Could not set the image size\n");
			error = errno;
			goto Unfreeze;
		}
		if (!atomic_snapshot(dev, &in_suspend)) {
			if (!in_suspend)
				break;
			if (!write_image(resume_device_name)) {
				power_off();
			} else {
				free_swap_pages();
				free_snapshot(dev);
				image_size -= DEFAULT_IMAGE_SIZE;
			}
		}
	}
Unfreeze:
	unfreeze(dev);
Close:
	close(dev);

	return error;
}

--Boundary-00=_zzsxDYRqhzzwfFT
Content-Type: text/x-csrc;
  charset="iso-8859-2";
  name="resume.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="resume.c"

/*
 * resume.c
 *
 * A simple user space resume handler for swsusp.
 *
 * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
 *
 * This file is released under the GPLv2.
 *
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <syscall.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "swsusp.h"

static char buffer[PAGE_SIZE];
static struct swsusp_header swsusp_header;

/**
 *	read_page - Read one page from a swap location.
 *	@fd:	File handle of the resume partition
 *	@buf:	Pointer to the area we're reading into.
 *	@off:	Swap offset of the place to read from.
 */

static int read_page(int fd, void *buf, unsigned long off)
{
	off_t offset;
	int res = 0;
	ssize_t cnt = 0;

	if (off) {
		offset = off * PAGE_SIZE;
		if (lseek(fd, offset, SEEK_SET) == offset) 
			cnt = read(fd, buf, PAGE_SIZE);
		if (cnt < PAGE_SIZE) {
			if (cnt < 0)
				res = cnt;
			else
				res = -EIO;
		}
	}
	return res;
}

/*
 *	The swap_map_handle structure is used for handling the swap map in
 *	a file-alike way
 */

struct swap_map_handle {
	struct swap_map_page cur;
	unsigned int k;
	int fd;
};

/**
 *	The following functions allow us to read data using a swap map
 *	in a file-alike way
 */

static inline int init_swap_reader(struct swap_map_handle *handle,
                                      int fd, unsigned long start)
{
	int error;

	if (!start)
		return -EINVAL;
	memset(&handle->cur, 0, PAGE_SIZE);
	error = read_page(fd, &handle->cur, start);
	if (error)
		return error;
	handle->fd = fd;
	handle->k = 0;
	return 0;
}

static inline int swap_read_page(struct swap_map_handle *handle, void *buf)
{
	unsigned long offset;
	int error;

	offset = handle->cur.entries[handle->k++];
	if (!offset)
		return -EFAULT;
	error = read_page(handle->fd, buf, offset);
	if (error)
		return error;
	if (handle->k >= MAP_PAGE_ENTRIES) {
		handle->k = 0;
		offset = handle->cur.next_swap;
		if (offset)
			error = read_page(handle->fd, &handle->cur, offset);
		else
			error = -EINVAL;
	}
	return error;
}

/**
 *	load_image - load the image using the swap map handle
 *	@handle and the snapshot handle @snapshot
 *	(assume there are @nr_pages pages to load)
 */

static inline int load_image(struct swap_map_handle *handle, int dev,
                      unsigned int nr_pages)
{
	unsigned int m, n;
	int ret;
	int error = 0;

	printf("Loading image data pages (%u pages) ...     ", nr_pages);
	m = nr_pages / 100;
	if (!m)
		m = 1;
	n = 0;
	do {
		error = swap_read_page(handle, buffer);
		if (error)
			break;
		if ((ret = write(dev, buffer, PAGE_SIZE)) < PAGE_SIZE) {
			error = ret < 0 ? ret : -ENOSPC;
			break;
		}
		if (!(n % m))
			printf("\b\b\b\b%3d%%", n / m);
		n++;
	} while (n < nr_pages);
	if (!error)
		printf("\b\b\b\bdone\n");
	return error;
}

static int read_image(int dev, char *resume_dev_name)
{
	static struct swap_map_handle handle;
	int fd, ret, error = 0;
	struct swsusp_info *header;
	unsigned int nr_pages;


	fd = open(resume_dev_name, O_RDWR | O_SYNC);
	if (fd < 0) {
		printf("resume: Could not open resume device\n");
		return -ENOENT;
	}
	memset(&swsusp_header, 0, sizeof(swsusp_header));
	ret = read(fd, &swsusp_header, PAGE_SIZE);
	if (ret == PAGE_SIZE) {
		if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
			memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
			/* Reset swap signature now */
			if (lseek(fd, 0, SEEK_SET) == 0) {
				ret = write(fd, &swsusp_header, PAGE_SIZE);
				if (ret < PAGE_SIZE)
					error = ret < 0 ? ret : -EIO;
			} else {
				error = -EIO;
			}
		} else {
			error = -EINVAL;
		}
	} else {
		error = ret < 0 ? ret : -EIO;
	}
	if (!error) {
		error = init_swap_reader(&handle, fd, swsusp_header.image);
		if (!error) {
			header = (struct swsusp_info *)buffer;
			error = swap_read_page(&handle, header);
		}
		if (!error) {
			nr_pages = header->pages - 1;
			ret = write(dev, buffer, PAGE_SIZE);
			if (ret < PAGE_SIZE)
				error = ret < 0 ? ret : -EIO;
		}
		if (!error)
			error = load_image(&handle, dev, nr_pages);
	}
	fsync(fd);
	close(fd);
	if (!error)
		printf("resume: Reading resume file was successful\n");
	else
		printf("resume: Error %d resuming\n", error);
	return error;
}

int main(int argc, char *argv[])
{
	char *snapshot_device_name, *resume_device_name;
	int dev;
	int error = 0;

	resume_device_name = argc <= 2 ? RESUME_DEVICE : argv[2];
	snapshot_device_name = argc <= 1 ? SNAPSHOT_DEVICE : argv[1];

	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);

	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
		fprintf(stderr, "resume: Could not lock myself\n");
		return 1;
	}

	dev = open(snapshot_device_name, O_WRONLY);
	if (dev < 0)
		return -ENOENT;
	if (read_image(dev, resume_device_name)) {
		fprintf(stderr, "resume: Could not read the image\n");
		error = errno;
		goto Close;
	}
	if (freeze(dev)) {
		fprintf(stderr, "resume: Could not freeze processes\n");
		error = errno;
		goto Close;
	}
	atomic_restore(dev);
	unfreeze(dev);
Close:
	close(dev);
	return error;
}

--Boundary-00=_zzsxDYRqhzzwfFT--
