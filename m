Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWEPRtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWEPRtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWEPRth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:49:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8200 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932360AbWEPRoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:44:32 -0400
Date: Tue, 16 May 2006 19:44:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Ihno Krumreich <ihno@suse.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [2.6 patch] the overdue removal of the obsolete raw driver
Message-ID: <20060516174430.GN10077@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org> <20060516161228.GF5677@stusta.de> <20060516163726.GA13798@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516163726.GA13798@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 06:37:26PM +0200, Olaf Hering wrote:
>  On Tue, May 16, Adrian Bunk wrote:
> 
> > This driver is declared obsolete since more than two years, and while 
> > it's worth a discussion how long to keep it for legacy users, merging a 
> > patch offering an obsolete driver for even more users is silly.
> 
> If it is so deprecated, just drop it for 2.6.17. I mean, no major distro
> that counts will be based on 2.6.17, so noone will miss it from now on.
> nails with heads and stuff...

Although I fear it will still not be accepted due to legacy users,
I've attached it below.

cu
Adrian


<--  snip  -->


This patch contains the overdue removal of the obsolete raw driver.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Jan 2006

 Documentation/feature-removal-schedule.txt |    8 
 drivers/char/Kconfig                       |   20 -
 drivers/char/Makefile                      |    1 
 drivers/char/mem.c                         |    1 
 drivers/char/raw.c                         |  343 ---------------------
 fs/compat_ioctl.c                          |   69 ----
 include/linux/compat_ioctl.h               |    3 
 include/linux/raw.h                        |   18 -
 8 files changed, 463 deletions(-)

--- linux-2.6.16-rc1-mm1-full/Documentation/feature-removal-schedule.txt.old	2006-01-19 03:29:57.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/Documentation/feature-removal-schedule.txt	2006-01-19 03:30:03.000000000 +0100
@@ -20,8 +19,0 @@
-What:	RAW driver (CONFIG_RAW_DRIVER)
-When:	December 2005
-Why:	declared obsolete since kernel 2.6.3
-	O_DIRECT can be used instead
-Who:	Adrian Bunk <bunk@stusta.de>
-
----------------------------
-
--- linux-2.6.16-rc1-mm1-full/drivers/char/Kconfig.old	2006-01-19 03:30:43.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/Kconfig	2006-01-19 03:31:11.000000000 +0100
@@ -939,26 +939,6 @@
 	tristate "NEC VR4100 series General-purpose I/O Unit support"
 	depends on CPU_VR41XX
 
-config RAW_DRIVER
-	tristate "RAW driver (/dev/raw/rawN) (OBSOLETE)"
-	help
-	  The raw driver permits block devices to be bound to /dev/raw/rawN. 
-	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
-	  See the raw(8) manpage for more details.
-
-          The raw driver is deprecated and will be removed soon.
-          Applications should simply open the device (eg /dev/hda1)
-          with the O_DIRECT flag.
-
-config MAX_RAW_DEVS
-	int "Maximum number of RAW devices to support (1-8192)"
-	depends on RAW_DRIVER
-	default "256"
-	help
-	  The maximum number of RAW devices that are supported.
-	  Default is 256. Increase this number in case you need lots of
-	  raw devices.
-
 config HPET
 	bool "HPET - High Precision Event Timer" if (X86 || IA64)
 	default n
--- linux-2.6.16-rc1-mm1-full/drivers/char/Makefile.old	2006-01-19 03:32:11.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/Makefile	2006-01-19 03:32:16.000000000 +0100
@@ -42,3 +42,2 @@
-obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MMTIMER)		+= mmtimer.o
--- linux-2.6.16-rc1-mm1-full/drivers/char/mem.c.old	2006-01-19 03:32:41.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/mem.c	2006-01-19 03:32:50.000000000 +0100
@@ -16,7 +16,6 @@
 #include <linux/mman.h>
 #include <linux/random.h>
 #include <linux/init.h>
-#include <linux/raw.h>
 #include <linux/tty.h>
 #include <linux/capability.h>
 #include <linux/smp_lock.h>
--- linux-2.6.16-rc1-mm1-full/include/linux/compat_ioctl.h.old	2006-01-19 03:34:12.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/include/linux/compat_ioctl.h	2006-01-19 03:34:17.000000000 +0100
@@ -568,9 +568,6 @@
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
 COMPATIBLE_IOCTL(DEVFSDIOC_RELEASE_EVENT_QUEUE)
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_DEBUG_MASK)
-/* Raw devices */
-COMPATIBLE_IOCTL(RAW_SETBIND)
-COMPATIBLE_IOCTL(RAW_GETBIND)
 /* SMB ioctls which do not need any translations */
 COMPATIBLE_IOCTL(SMB_IOC_NEWCONN)
 /* NCP ioctls which do not need any translations */
--- linux-2.6.16-rc1-mm1-full/fs/compat_ioctl.c.old	2006-01-19 03:32:58.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/fs/compat_ioctl.c	2006-01-19 03:33:25.000000000 +0100
@@ -53,7 +53,6 @@
 #include <linux/ext3_fs.h>
 #include <linux/videodev.h>
 #include <linux/netdevice.h>
-#include <linux/raw.h>
 #include <linux/smb_fs.h>
 #include <linux/blkpg.h>
 #include <linux/blkdev.h>
@@ -2141,71 +2140,6 @@
         return sys_ioctl(fd,cmd,ptr);
 }
 
-struct raw32_config_request
-{
-        compat_int_t    raw_minor;
-        __u64   block_major;
-        __u64   block_minor;
-} __attribute__((packed));
-
-static int get_raw32_request(struct raw_config_request *req, struct raw32_config_request __user *user_req)
-{
-        int ret;
-
-        if (!access_ok(VERIFY_READ, user_req, sizeof(struct raw32_config_request)))
-                return -EFAULT;
-
-        ret = __get_user(req->raw_minor, &user_req->raw_minor);
-        ret |= __get_user(req->block_major, &user_req->block_major);
-        ret |= __get_user(req->block_minor, &user_req->block_minor);
-
-        return ret ? -EFAULT : 0;
-}
-
-static int set_raw32_request(struct raw_config_request *req, struct raw32_config_request __user *user_req)
-{
-	int ret;
-
-        if (!access_ok(VERIFY_WRITE, user_req, sizeof(struct raw32_config_request)))
-                return -EFAULT;
-
-        ret = __put_user(req->raw_minor, &user_req->raw_minor);
-        ret |= __put_user(req->block_major, &user_req->block_major);
-        ret |= __put_user(req->block_minor, &user_req->block_minor);
-
-        return ret ? -EFAULT : 0;
-}
-
-static int raw_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
-{
-        int ret;
-
-        switch (cmd) {
-        case RAW_SETBIND:
-        case RAW_GETBIND: {
-                struct raw_config_request req;
-                struct raw32_config_request __user *user_req = compat_ptr(arg);
-                mm_segment_t oldfs = get_fs();
-
-                if ((ret = get_raw32_request(&req, user_req)))
-                        return ret;
-
-                set_fs(KERNEL_DS);
-                ret = sys_ioctl(fd,cmd,(unsigned long)&req);
-                set_fs(oldfs);
-
-                if ((!ret) && (cmd == RAW_GETBIND)) {
-                        ret = set_raw32_request(&req, user_req);
-                }
-                break;
-        }
-        default:
-                ret = sys_ioctl(fd, cmd, arg);
-                break;
-        }
-        return ret;
-}
-
 struct serial_struct32 {
         compat_int_t    type;
         compat_int_t    line;
@@ -2913,9 +2847,6 @@
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
 HANDLE_IOCTL(REISERFS_IOC_UNPACK32, reiserfs_ioctl32)
-/* Raw devices */
-HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
-HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
 /* Serial */
 HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
 HANDLE_IOCTL(TIOCSSERIAL, serial_struct_ioctl)
--- linux-2.6.16-rc1-mm1-full/include/linux/raw.h	2006-01-03 04:21:10.000000000 +0100
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,18 +0,0 @@
-#ifndef __LINUX_RAW_H
-#define __LINUX_RAW_H
-
-#include <linux/types.h>
-
-#define RAW_SETBIND	_IO( 0xac, 0 )
-#define RAW_GETBIND	_IO( 0xac, 1 )
-
-struct raw_config_request 
-{
-	int	raw_minor;
-	__u64	block_major;
-	__u64	block_minor;
-};
-
-#define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
-
-#endif /* __LINUX_RAW_H */
--- linux-2.6.16-rc1-mm1-full/drivers/char/raw.c	2006-01-18 20:21:53.000000000 +0100
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,343 +0,0 @@
-/*
- * linux/drivers/char/raw.c
- *
- * Front-end raw character devices.  These can be bound to any block
- * devices to provide genuine Unix raw character device semantics.
- *
- * We reserve minor number 0 for a control interface.  ioctl()s on this
- * device are used to bind the other minor numbers to block devices.
- */
-
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
-#include <linux/major.h>
-#include <linux/blkdev.h>
-#include <linux/module.h>
-#include <linux/raw.h>
-#include <linux/capability.h>
-#include <linux/uio.h>
-#include <linux/cdev.h>
-#include <linux/device.h>
-#include <linux/mutex.h>
-
-#include <asm/uaccess.h>
-
-struct raw_device_data {
-	struct block_device *binding;
-	int inuse;
-};
-
-static struct class *raw_class;
-static struct raw_device_data raw_devices[MAX_RAW_MINORS];
-static DEFINE_MUTEX(raw_mutex);
-static struct file_operations raw_ctl_fops;	     /* forward declaration */
-
-/*
- * Open/close code for raw IO.
- *
- * We just rewrite the i_mapping for the /dev/raw/rawN file descriptor to
- * point at the blockdev's address_space and set the file handle to use
- * O_DIRECT.
- *
- * Set the device's soft blocksize to the minimum possible.  This gives the
- * finest possible alignment and has no adverse impact on performance.
- */
-static int raw_open(struct inode *inode, struct file *filp)
-{
-	const int minor = iminor(inode);
-	struct block_device *bdev;
-	int err;
-
-	if (minor == 0) {	/* It is the control device */
-		filp->f_op = &raw_ctl_fops;
-		return 0;
-	}
-
-	mutex_lock(&raw_mutex);
-
-	/*
-	 * All we need to do on open is check that the device is bound.
-	 */
-	bdev = raw_devices[minor].binding;
-	err = -ENODEV;
-	if (!bdev)
-		goto out;
-	igrab(bdev->bd_inode);
-	err = blkdev_get(bdev, filp->f_mode, 0);
-	if (err)
-		goto out;
-	err = bd_claim(bdev, raw_open);
-	if (err)
-		goto out1;
-	err = set_blocksize(bdev, bdev_hardsect_size(bdev));
-	if (err)
-		goto out2;
-	filp->f_flags |= O_DIRECT;
-	filp->f_mapping = bdev->bd_inode->i_mapping;
-	if (++raw_devices[minor].inuse == 1)
-		filp->f_dentry->d_inode->i_mapping =
-			bdev->bd_inode->i_mapping;
-	filp->private_data = bdev;
-	mutex_unlock(&raw_mutex);
-	return 0;
-
-out2:
-	bd_release(bdev);
-out1:
-	blkdev_put(bdev);
-out:
-	mutex_unlock(&raw_mutex);
-	return err;
-}
-
-/*
- * When the final fd which refers to this character-special node is closed, we
- * make its ->mapping point back at its own i_data.
- */
-static int raw_release(struct inode *inode, struct file *filp)
-{
-	const int minor= iminor(inode);
-	struct block_device *bdev;
-
-	mutex_lock(&raw_mutex);
-	bdev = raw_devices[minor].binding;
-	if (--raw_devices[minor].inuse == 0) {
-		/* Here  inode->i_mapping == bdev->bd_inode->i_mapping  */
-		inode->i_mapping = &inode->i_data;
-		inode->i_mapping->backing_dev_info = &default_backing_dev_info;
-	}
-	mutex_unlock(&raw_mutex);
-
-	bd_release(bdev);
-	blkdev_put(bdev);
-	return 0;
-}
-
-/*
- * Forward ioctls to the underlying block device.
- */
-static int
-raw_ioctl(struct inode *inode, struct file *filp,
-		  unsigned int command, unsigned long arg)
-{
-	struct block_device *bdev = filp->private_data;
-
-	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
-}
-
-static void bind_device(struct raw_config_request *rq)
-{
-	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
-	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, rq->raw_minor),
-				      NULL, "raw%d", rq->raw_minor);
-}
-
-/*
- * Deal with ioctls against the raw-device control interface, to bind
- * and unbind other raw devices.
- */
-static int raw_ctl_ioctl(struct inode *inode, struct file *filp,
-			unsigned int command, unsigned long arg)
-{
-	struct raw_config_request rq;
-	struct raw_device_data *rawdev;
-	int err = 0;
-
-	switch (command) {
-	case RAW_SETBIND:
-	case RAW_GETBIND:
-
-		/* First, find out which raw minor we want */
-
-		if (copy_from_user(&rq, (void __user *) arg, sizeof(rq))) {
-			err = -EFAULT;
-			goto out;
-		}
-
-		if (rq.raw_minor < 0 || rq.raw_minor >= MAX_RAW_MINORS) {
-			err = -EINVAL;
-			goto out;
-		}
-		rawdev = &raw_devices[rq.raw_minor];
-
-		if (command == RAW_SETBIND) {
-			dev_t dev;
-
-			/*
-			 * This is like making block devices, so demand the
-			 * same capability
-			 */
-			if (!capable(CAP_SYS_ADMIN)) {
-				err = -EPERM;
-				goto out;
-			}
-
-			/*
-			 * For now, we don't need to check that the underlying
-			 * block device is present or not: we can do that when
-			 * the raw device is opened.  Just check that the
-			 * major/minor numbers make sense.
-			 */
-
-			dev = MKDEV(rq.block_major, rq.block_minor);
-			if ((rq.block_major == 0 && rq.block_minor != 0) ||
-					MAJOR(dev) != rq.block_major ||
-					MINOR(dev) != rq.block_minor) {
-				err = -EINVAL;
-				goto out;
-			}
-
-			mutex_lock(&raw_mutex);
-			if (rawdev->inuse) {
-				mutex_unlock(&raw_mutex);
-				err = -EBUSY;
-				goto out;
-			}
-			if (rawdev->binding) {
-				bdput(rawdev->binding);
-				module_put(THIS_MODULE);
-			}
-			if (rq.block_major == 0 && rq.block_minor == 0) {
-				/* unbind */
-				rawdev->binding = NULL;
-				class_device_destroy(raw_class,
-						MKDEV(RAW_MAJOR, rq.raw_minor));
-			} else {
-				rawdev->binding = bdget(dev);
-				if (rawdev->binding == NULL)
-					err = -ENOMEM;
-				else {
-					__module_get(THIS_MODULE);
-					bind_device(&rq);
-				}
-			}
-			mutex_unlock(&raw_mutex);
-		} else {
-			struct block_device *bdev;
-
-			mutex_lock(&raw_mutex);
-			bdev = rawdev->binding;
-			if (bdev) {
-				rq.block_major = MAJOR(bdev->bd_dev);
-				rq.block_minor = MINOR(bdev->bd_dev);
-			} else {
-				rq.block_major = rq.block_minor = 0;
-			}
-			mutex_unlock(&raw_mutex);
-			if (copy_to_user((void __user *)arg, &rq, sizeof(rq))) {
-				err = -EFAULT;
-				goto out;
-			}
-		}
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-out:
-	return err;
-}
-
-static ssize_t raw_file_write(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
-{
-	struct iovec local_iov = {
-		.iov_base = (char __user *)buf,
-		.iov_len = count
-	};
-
-	return generic_file_write_nolock(file, &local_iov, 1, ppos);
-}
-
-static ssize_t raw_file_aio_write(struct kiocb *iocb, const char __user *buf,
-					size_t count, loff_t pos)
-{
-	struct iovec local_iov = {
-		.iov_base = (char __user *)buf,
-		.iov_len = count
-	};
-
-	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
-}
-
-
-static struct file_operations raw_fops = {
-	.read	=	generic_file_read,
-	.aio_read = 	generic_file_aio_read,
-	.write	=	raw_file_write,
-	.aio_write = 	raw_file_aio_write,
-	.open	=	raw_open,
-	.release=	raw_release,
-	.ioctl	=	raw_ioctl,
-	.readv	= 	generic_file_readv,
-	.writev	= 	generic_file_writev,
-	.owner	=	THIS_MODULE,
-};
-
-static struct file_operations raw_ctl_fops = {
-	.ioctl	=	raw_ctl_ioctl,
-	.open	=	raw_open,
-	.owner	=	THIS_MODULE,
-};
-
-static struct cdev raw_cdev = {
-	.kobj	=	{.name = "raw", },
-	.owner	=	THIS_MODULE,
-};
-
-static int __init raw_init(void)
-{
-	int i;
-	dev_t dev = MKDEV(RAW_MAJOR, 0);
-
-	if (register_chrdev_region(dev, MAX_RAW_MINORS, "raw"))
-		goto error;
-
-	cdev_init(&raw_cdev, &raw_fops);
-	if (cdev_add(&raw_cdev, dev, MAX_RAW_MINORS)) {
-		kobject_put(&raw_cdev.kobj);
-		unregister_chrdev_region(dev, MAX_RAW_MINORS);
-		goto error;
-	}
-
-	raw_class = class_create(THIS_MODULE, "raw");
-	if (IS_ERR(raw_class)) {
-		printk(KERN_ERR "Error creating raw class.\n");
-		cdev_del(&raw_cdev);
-		unregister_chrdev_region(dev, MAX_RAW_MINORS);
-		goto error;
-	}
-	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
-
-	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
-		      S_IFCHR | S_IRUGO | S_IWUGO,
-		      "raw/rawctl");
-	for (i = 1; i < MAX_RAW_MINORS; i++)
-		devfs_mk_cdev(MKDEV(RAW_MAJOR, i),
-			      S_IFCHR | S_IRUGO | S_IWUGO,
-			      "raw/raw%d", i);
-	return 0;
-
-error:
-	printk(KERN_ERR "error register raw device\n");
-	return 1;
-}
-
-static void __exit raw_exit(void)
-{
-	int i;
-
-	for (i = 1; i < MAX_RAW_MINORS; i++)
-		devfs_remove("raw/raw%d", i);
-	devfs_remove("raw/rawctl");
-	devfs_remove("raw");
-	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, 0));
-	class_destroy(raw_class);
-	cdev_del(&raw_cdev);
-	unregister_chrdev_region(MKDEV(RAW_MAJOR, 0), MAX_RAW_MINORS);
-}
-
-module_init(raw_init);
-module_exit(raw_exit);
-MODULE_LICENSE("GPL");

