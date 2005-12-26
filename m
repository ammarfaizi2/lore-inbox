Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVLZTUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVLZTUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLZTT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:19:56 -0500
Received: from smtp4.libero.it ([193.70.192.54]:25784 "EHLO smtp4.libero.it")
	by vger.kernel.org with ESMTP id S932108AbVLZTTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:19:36 -0500
Date: Mon, 26 Dec 2005 19:58:26 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 5/7] RTC subsystem, dev interface
Message-ID: <20051226195826.280c5ef8@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the dev interface to the RTC
subsystem.

The first RTC driver that registers with the class
will be available under /dev/rtc .

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--

 drivers/rtc/Kconfig   |   11 +
 drivers/rtc/Makefile  |    1 
 drivers/rtc/rtc-dev.c |  359 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/rtc/rtc-dev.c	2005-12-26 19:33:32.000000000 +0100
@@ -0,0 +1,359 @@
+/*
+ * RTC subsystem, dev interface
+ *
+ * Copyright (C) 2005 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * based on arch/arm/common/rtctime.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/rtc.h>
+
+static dev_t rtc_devt;
+
+#define RTC_DEV_MAX 16 /* 16 RTCs should be enough for everyone... */
+
+static int rtc_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+	struct rtc_device *rtc = container_of(inode->i_cdev,
+					struct rtc_device, char_dev);
+	struct rtc_class_ops *ops = rtc->ops;
+
+	/* We keep the lock as long as the device is in use
+	 * and return immediately if busy
+	 */
+	if (down_trylock(&rtc->char_sem))
+		return -EBUSY;
+
+	file->private_data = &rtc->class_dev;
+
+	err = ops->open ? ops->open(rtc->class_dev.dev) : 0;
+	if (err == 0) {
+
+		spin_lock_irq(&rtc->irq_lock);
+		rtc->irq_data = 0;
+		spin_unlock_irq(&rtc->irq_lock);
+
+		return 0;
+	}
+
+	/* something has gone wrong, release the lock */
+	up(&rtc->char_sem);
+	return err;
+}
+
+
+static ssize_t
+rtc_dev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct rtc_device *rtc = to_rtc_device(file->private_data);
+
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long data;
+	ssize_t ret;
+
+	if (count < sizeof(unsigned long))
+		return -EINVAL;
+
+	add_wait_queue(&rtc->irq_queue, &wait);
+	do {
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_irq(&rtc->irq_lock);
+		data = rtc->irq_data;
+		rtc->irq_data = 0;
+		spin_unlock_irq(&rtc->irq_lock);
+
+		if (data != 0) {
+			ret = 0;
+			break;
+		}
+		if (file->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			break;
+		}
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+		schedule();
+	} while (1);
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&rtc->irq_queue, &wait);
+
+	if (ret == 0) {
+		ret = put_user(data, (unsigned long __user *)buf);
+		if (ret == 0)
+			ret = sizeof(unsigned long);
+	}
+	return ret;
+}
+
+static unsigned int rtc_dev_poll(struct file *file, poll_table *wait)
+{
+	struct rtc_device *rtc = to_rtc_device(file->private_data);
+	unsigned long data;
+
+	poll_wait(file, &rtc->irq_queue, wait);
+
+	spin_lock_irq(&rtc->irq_lock);
+	data = rtc->irq_data;
+	spin_unlock_irq(&rtc->irq_lock);
+
+	return data != 0 ? POLLIN | POLLRDNORM : 0;
+}
+
+static int rtc_dev_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg)
+{
+	int err = -EINVAL;
+	struct class_device *class_dev = file->private_data;
+	struct rtc_class_ops *ops = rtc_get_ops(class_dev);
+	struct rtc_time tm;
+	struct rtc_wkalrm alarm;
+	void __user *uarg = (void __user *)arg;
+
+	/* try the driver's ioctl interface */
+	if (ops->ioctl) {
+		err = ops->ioctl(class_dev->dev, cmd, arg);
+		if (err < 0 && err != -EINVAL)
+			return err;
+	}
+
+	/* if the driver does not provide the ioctl interface
+	 * or if that particular ioctl was not implemented
+	 * (-EINVAL), we will try to emulate here.
+	 */
+
+	switch (cmd) {
+	case RTC_ALM_READ:
+		if ((err = rtc_read_alarm(class_dev, &alarm)) < 0)
+			return err;
+
+		if ((err = copy_to_user(uarg, &alarm.time, sizeof(tm))))
+			return -EFAULT;
+		break;
+
+	case RTC_ALM_SET:
+		if ((err = copy_from_user(&alarm.time, uarg, sizeof(tm))))
+			return -EFAULT;
+
+		alarm.enabled = 0;
+		alarm.pending = 0;
+		alarm.time.tm_mday = -1;
+		alarm.time.tm_mon = -1;
+		alarm.time.tm_year = -1;
+		alarm.time.tm_wday = -1;
+		alarm.time.tm_yday = -1;
+		alarm.time.tm_isdst = -1;
+		err = rtc_set_alarm(class_dev, &alarm);
+		break;
+
+	case RTC_RD_TIME:
+		if ((err = rtc_read_time(class_dev, &tm)) < 0)
+			return err;
+
+		if ((err = copy_to_user(uarg, &tm, sizeof(tm))))
+			return -EFAULT;
+		break;
+
+	case RTC_SET_TIME:
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		if ((err = copy_from_user(&tm, uarg, sizeof(tm))))
+			return -EFAULT;
+
+		err = rtc_set_time(class_dev, &tm);
+		break;
+#if 0
+	case RTC_EPOCH_SET:
+#ifndef rtc_epoch
+		/*
+		 * There were no RTC clocks before 1900.
+		 */
+		if (arg < 1900) {
+			err = -EINVAL;
+			break;
+		}
+		if (!capable(CAP_SYS_TIME)) {
+			err = -EACCES;
+			break;
+		}
+		rtc_epoch = arg;
+		err = 0;
+#endif
+		break;
+
+	case RTC_EPOCH_READ:
+		err = put_user(rtc_epoch, (unsigned long __user *)uarg);
+		break;
+#endif
+	case RTC_WKALM_SET:
+		if ((err = copy_from_user(&alarm, uarg, sizeof(alarm))))
+			return -EFAULT;
+
+		err = rtc_set_alarm(class_dev, &alarm);
+		break;
+
+	case RTC_WKALM_RD:
+		if ((err = rtc_read_alarm(class_dev, &alarm)) < 0)
+			return err;
+
+		if ((err = copy_to_user(uarg, &alarm, sizeof(alarm))))
+			return -EFAULT;
+		break;
+	}
+
+	return err;
+}
+
+static int rtc_dev_release(struct inode *inode, struct file *file)
+{
+	struct rtc_device *rtc = to_rtc_device(file->private_data);
+
+	if (rtc->ops->release)
+		rtc->ops->release(rtc->class_dev.dev);
+
+	spin_lock_irq(&rtc->irq_lock);
+	rtc->irq_data = 0;
+	spin_unlock_irq(&rtc->irq_lock);
+
+	up(&rtc->char_sem);
+	return 0;
+}
+
+static int rtc_dev_fasync(int fd, struct file *file, int on)
+{
+	struct rtc_device *rtc = to_rtc_device(file->private_data);
+	return fasync_helper(fd, file, on, &rtc->async_queue);
+}
+
+static struct file_operations rtc_dev_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= rtc_dev_read,
+	.poll		= rtc_dev_poll,
+	.ioctl		= rtc_dev_ioctl,
+	.open		= rtc_dev_open,
+	.release	= rtc_dev_release,
+	.fasync		= rtc_dev_fasync,
+};
+
+static ssize_t rtc_dev_show_dev(struct class_device *class_dev, char *buf)
+{
+        return print_dev_t(buf, class_dev->devt);
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, rtc_dev_show_dev, NULL);
+
+/* insertion/removal hooks */
+
+static int rtc_dev_add_device(struct class_device *class_dev,
+				struct class_interface *class_intf)
+{
+	struct rtc_device *rtc = to_rtc_device(class_dev);
+
+	if (rtc->id >= RTC_DEV_MAX) {
+		dev_err(class_dev->dev, "too many RTCs\n");
+		return -EINVAL;
+	}
+
+	init_MUTEX(&rtc->char_sem);
+	init_MUTEX(&rtc->irq_lock);
+	init_waitqueue_head(&rtc->irq_queue);
+
+	cdev_init(&rtc->char_dev, &rtc_dev_fops);
+	rtc->char_dev.owner = rtc->ops->owner;
+	class_dev->devt = MKDEV(MAJOR(rtc_devt), rtc->id);
+
+	if (cdev_add(&rtc->char_dev, class_dev->devt, 1)) {
+		cdev_del(&rtc->char_dev);
+
+		dev_err(class_dev->dev,
+			"failed to add char device %d:%d\n",
+			MAJOR(class_dev->devt),
+			MINOR(class_dev->devt));
+
+		class_dev->devt = MKDEV(0, 0);
+		return -ENODEV;
+	}
+
+	class_device_create_file(class_dev, &class_device_attr_dev);
+
+	dev_info(class_dev->dev, "rtc intf: dev (%d:%d)\n",
+		MAJOR(class_dev->devt),
+		MINOR(class_dev->devt));
+
+	/* XXX this call will let udevd add the device node
+	 * in /dev . Is it correct?
+	 */
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+
+	return 0;
+}
+
+static void rtc_dev_remove_device(struct class_device *class_dev,
+					struct class_interface *class_intf)
+{
+	struct rtc_device *rtc = to_rtc_device(class_dev);
+
+	class_device_remove_file(class_dev, &class_device_attr_dev);
+
+	if (MAJOR(class_dev->devt)) {
+		dev_dbg(class_dev->dev, "removing char %d:%d\n",
+			MAJOR(class_dev->devt),
+			MINOR(class_dev->devt));
+		cdev_del(&rtc->char_dev);
+
+		kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
+
+		class_dev->devt = MKDEV(0, 0);
+	}
+}
+
+/* interface registration */
+
+struct class_interface rtc_dev_interface = {
+	.add = &rtc_dev_add_device,
+	.remove = &rtc_dev_remove_device,
+};
+
+static int __init rtc_dev_init(void)
+{
+	int err;
+
+	if ((err = alloc_chrdev_region(&rtc_devt, 0, RTC_DEV_MAX, "rtc")) < 0) {
+		printk(KERN_ERR "%s: failed to allocate char dev region\n",
+			__FILE__);
+		return err;
+	}
+
+	if ((err = rtc_interface_register(&rtc_dev_interface)) < 0) {
+		printk(KERN_ERR "%s: failed to register the interface\n",
+			__FILE__);
+		unregister_chrdev_region(rtc_devt, RTC_DEV_MAX);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit rtc_dev_exit(void)
+{
+	class_interface_unregister(&rtc_dev_interface);
+
+	unregister_chrdev_region(rtc_devt, RTC_DEV_MAX);
+}
+
+module_init(rtc_dev_init);
+module_exit(rtc_dev_exit);
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("RTC class dev interface");
+MODULE_LICENSE("GPL");
--- linux.orig/drivers/rtc/Kconfig	2005-12-26 19:33:16.000000000 +0100
+++ linux/drivers/rtc/Kconfig	2005-12-26 19:35:09.000000000 +0100
@@ -41,6 +41,17 @@
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-proc.
 
+config RTC_INTF_DEV
+	tristate "dev"
+	depends on RTC_CLASS
+	default RTC_CLASS
+	help
+	  Say yes here if you want to use your RTC using the dev
+	  interface, /dev/rtc .
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-dev.
+
 comment "RTC drivers"
 	depends on RTC_CLASS
 
--- linux.orig/drivers/rtc/Makefile	2005-12-26 19:33:16.000000000 +0100
+++ linux/drivers/rtc/Makefile	2005-12-26 19:35:09.000000000 +0100
@@ -7,3 +7,4 @@
 rtc-core-y			:= class.o interface.o
 obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
 obj-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
+obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
