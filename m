Return-Path: <linux-kernel-owner+w=401wt.eu-S1751323AbXANQIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbXANQIm (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 11:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXANQIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 11:08:42 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:33497 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbXANQIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 11:08:41 -0500
X-Originating-Ip: 74.109.98.130
Date: Sun, 14 Jan 2007 10:50:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Adrian Bunk <bunk@stusta.de>
Subject: [PATCH][REVISED] Remove all traces of "raw device" support.
Message-ID: <Pine.LNX.4.64.0701141047320.7666@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove all traces of raw devices support, which were officially
obsolete since 2.6.3.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  crap.  the "allyesconfig" build worked, except when it came to
installing the sanitized headers, whose include/linux/Kbuild file
still had a reference to the "raw.h" header file.

  sorry.  my bad.

 Documentation/feature-removal-schedule.txt |    8
 Documentation/ioctl-number.txt             |    1
 drivers/char/Kconfig                       |   21 -
 drivers/char/Makefile                      |    1
 drivers/char/mem.c                         |    1
 drivers/char/raw.c                         |  306 -------------------
 fs/compat_ioctl.c                          |   71 ----
 include/linux/Kbuild                       |    1
 include/linux/compat_ioctl.h               |    3
 include/linux/raw.h                        |   18 -
 10 files changed, 431 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index fc53239..020b760 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -21,14 +21,6 @@ Who:	Pavel Machek <pavel@suse.cz>

 ---------------------------

-What:	RAW driver (CONFIG_RAW_DRIVER)
-When:	December 2005
-Why:	declared obsolete since kernel 2.6.3
-	O_DIRECT can be used instead
-Who:	Adrian Bunk <bunk@stusta.de>
-
----------------------------
-
 What:	raw1394: requests of type RAW1394_REQ_ISO_SEND, RAW1394_REQ_ISO_LISTEN
 When:	June 2007
 Why:	Deprecated in favour of the more efficient and robust rawiso interface.
diff --git a/Documentation/ioctl-number.txt b/Documentation/ioctl-number.txt
index 5a8bd5b..4ffd365 100644
--- a/Documentation/ioctl-number.txt
+++ b/Documentation/ioctl-number.txt
@@ -179,7 +179,6 @@ Code	Seq#	Include File		Comments
 					<mailto:tlewis@mindspring.com>
 0xA3	90-9F	linux/dtlk.h
 0xAB	00-1F	linux/nbd.h
-0xAC	00-1F	linux/raw.h
 0xAD	00	Netfilter device	in development:
 					<mailto:rusty@rustcorp.com.au>
 0xB0	all	RATIO devices		in development:
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 9e43e39..eaf021e 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -948,27 +948,6 @@ config GPIO_VR41XX
 	tristate "NEC VR4100 series General-purpose I/O Unit support"
 	depends on CPU_VR41XX

-config RAW_DRIVER
-	tristate "RAW driver (/dev/raw/rawN) (OBSOLETE)"
-	depends on BLOCK
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
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index fc11063..21d0873 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -46,7 +46,6 @@ obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi.o
 obj-$(CONFIG_HVC_ISERIES)	+= hvc_iseries.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
-obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MSPEC)		+= mspec.o
 obj-$(CONFIG_MMTIMER)		+= mmtimer.o
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 4f1813e..32a826b 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -15,7 +15,6 @@
 #include <linux/mman.h>
 #include <linux/random.h>
 #include <linux/init.h>
-#include <linux/raw.h>
 #include <linux/tty.h>
 #include <linux/capability.h>
 #include <linux/smp_lock.h>
diff --git a/drivers/char/raw.c b/drivers/char/raw.c
deleted file mode 100644
index 645e20a..0000000
--- a/drivers/char/raw.c
+++ /dev/null
@@ -1,306 +0,0 @@
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
-static const struct file_operations raw_ctl_fops; /* forward declaration */
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
-		filp->f_path.dentry->d_inode->i_mapping =
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
-	device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
-	device_create(raw_class, NULL, MKDEV(RAW_MAJOR, rq->raw_minor),
-		      "raw%d", rq->raw_minor);
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
-				device_destroy(raw_class,
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
-static const struct file_operations raw_fops = {
-	.read	=	do_sync_read,
-	.aio_read = 	generic_file_aio_read,
-	.write	=	do_sync_write,
-	.aio_write = 	generic_file_aio_write_nolock,
-	.open	=	raw_open,
-	.release=	raw_release,
-	.ioctl	=	raw_ioctl,
-	.owner	=	THIS_MODULE,
-};
-
-static const struct file_operations raw_ctl_fops = {
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
-	dev_t dev = MKDEV(RAW_MAJOR, 0);
-	int ret;
-
-	ret = register_chrdev_region(dev, MAX_RAW_MINORS, "raw");
-	if (ret)
-		goto error;
-
-	cdev_init(&raw_cdev, &raw_fops);
-	ret = cdev_add(&raw_cdev, dev, MAX_RAW_MINORS);
-	if (ret) {
-		kobject_put(&raw_cdev.kobj);
-		goto error_region;
-	}
-
-	raw_class = class_create(THIS_MODULE, "raw");
-	if (IS_ERR(raw_class)) {
-		printk(KERN_ERR "Error creating raw class.\n");
-		cdev_del(&raw_cdev);
-		ret = PTR_ERR(raw_class);
-		goto error_region;
-	}
-	device_create(raw_class, NULL, MKDEV(RAW_MAJOR, 0), "rawctl");
-
-	return 0;
-
-error_region:
-	unregister_chrdev_region(dev, MAX_RAW_MINORS);
-error:
-	return ret;
-}
-
-static void __exit raw_exit(void)
-{
-	device_destroy(raw_class, MKDEV(RAW_MAJOR, 0));
-	class_destroy(raw_class);
-	cdev_del(&raw_cdev);
-	unregister_chrdev_region(MKDEV(RAW_MAJOR, 0), MAX_RAW_MINORS);
-}
-
-module_init(raw_init);
-module_exit(raw_exit);
-MODULE_LICENSE("GPL");
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index c81c958..a1b438b 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -47,7 +47,6 @@
 #include <linux/fb.h>
 #include <linux/videodev.h>
 #include <linux/netdevice.h>
-#include <linux/raw.h>
 #include <linux/smb_fs.h>
 #include <linux/blkpg.h>
 #include <linux/blkdev.h>
@@ -1949,73 +1948,6 @@ static int mtd_rw_oob(unsigned int fd, unsigned int cmd, unsigned long arg)
 	return err;
 }

-#ifdef CONFIG_BLOCK
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
-#endif /* CONFIG_BLOCK */
-
 struct serial_struct32 {
         compat_int_t    type;
         compat_int_t    line;
@@ -2521,9 +2453,6 @@ HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
-/* Raw devices */
-HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
-HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
 #endif
 /* Serial */
 HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 862e483..c0b3d2c 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -134,7 +134,6 @@ header-y += qnxtypes.h
 header-y += quotaio_v1.h
 header-y += quotaio_v2.h
 header-y += radeonfb.h
-header-y += raw.h
 header-y += resource.h
 header-y += rose.h
 header-y += smbno.h
diff --git a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
index c26c3ad..cd56780 100644
--- a/include/linux/compat_ioctl.h
+++ b/include/linux/compat_ioctl.h
@@ -571,9 +571,6 @@ COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER)
 COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST)
 COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST)
 COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT)
-/* Raw devices */
-COMPATIBLE_IOCTL(RAW_SETBIND)
-COMPATIBLE_IOCTL(RAW_GETBIND)
 /* SMB ioctls which do not need any translations */
 COMPATIBLE_IOCTL(SMB_IOC_NEWCONN)
 /* Little a */
diff --git a/include/linux/raw.h b/include/linux/raw.h
deleted file mode 100644
index 62d543e..0000000
--- a/include/linux/raw.h
+++ /dev/null
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
