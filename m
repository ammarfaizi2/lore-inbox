Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVLTUuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVLTUuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVLTUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:50:39 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:4844 "EHLO mail.towertech.it")
	by vger.kernel.org with ESMTP id S932092AbVLTUui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:50:38 -0500
Date: Tue, 20 Dec 2005 21:48:56 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 5/6] RTC subsystem, dev interface
Message-ID: <20051220214856.6289ff21@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
 drivers/rtc/rtc-dev.c |  336 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 348 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/rtc-dev.c	2005-12-20 20:43:58.000000000 +0100
@@ -0,0 +1,336 @@
+/*
+ * rtc-dev.c - rtc subsystem, dev interface
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
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kdev_t.h>
+#include <linux/gfp.h>
+#include <linux/rtc.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/time.h>
+#include <linux/rtc.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+
+#include <asm/rtc.h>
+#include <asm/semaphore.h>
+
+static struct class_device *rtc_dev = NULL;
+
+static DECLARE_WAIT_QUEUE_HEAD(rtc_wait);
+static struct fasync_struct *rtc_async_queue;
+
+/*
+ * rtc_lock protects rtc_irq_data
+ */
+static DEFINE_SPINLOCK(rtc_lock);
+static unsigned long rtc_irq_data;
+
+/*
+ * rtc_sem protects rtc_inuse and rtc_dev
+ */
+static DECLARE_MUTEX(rtc_sem);
+static unsigned long rtc_inuse;
+
+
+static int rtc_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+
+	struct rtc_class_ops *ops = class_get_devdata(rtc_dev);
+
+	down(&rtc_sem);
+
+	if (rtc_inuse) {
+		err = -EBUSY;
+	} else if (!try_module_get(ops->owner)) {
+		err = -ENODEV;
+	} else {
+		file->private_data = rtc_dev;
+
+		err = ops->open ? ops->open(rtc_dev->dev) : 0;
+		if (err == 0) {
+			spin_lock_irq(&rtc_lock);
+			rtc_irq_data = 0;
+			spin_unlock_irq(&rtc_lock);
+
+			rtc_inuse = 1;
+		}
+	}
+	up(&rtc_sem);
+
+	return err;
+}
+
+
+static ssize_t
+rtc_dev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long data;
+	ssize_t ret;
+
+	if (count < sizeof(unsigned long))
+		return -EINVAL;
+
+	add_wait_queue(&rtc_wait, &wait);
+	do {
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_irq(&rtc_lock);
+		data = rtc_irq_data;
+		rtc_irq_data = 0;
+		spin_unlock_irq(&rtc_lock);
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
+	remove_wait_queue(&rtc_wait, &wait);
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
+	unsigned long data;
+
+	poll_wait(file, &rtc_wait, wait);
+
+	spin_lock_irq(&rtc_lock);
+	data = rtc_irq_data;
+	spin_unlock_irq(&rtc_lock);
+
+	return data != 0 ? POLLIN | POLLRDNORM : 0;
+}
+
+static int rtc_dev_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg)
+{
+	int err = -EINVAL;
+	struct class_device *class_dev = file->private_data;
+	struct rtc_class_ops *ops = class_get_devdata(class_dev);
+	struct rtc_time tm;
+	struct rtc_wkalrm alrm;
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
+		if ((err = rtc_read_alarm(class_dev, &alrm)) < 0)
+			return err;
+
+		if ((err = copy_to_user(uarg, &alrm.time, sizeof(tm))))
+			return -EFAULT;
+		break;
+
+	case RTC_ALM_SET:
+		if ((err = copy_from_user(&alrm.time, uarg, sizeof(tm))))
+			return -EFAULT;
+
+		alrm.enabled = 0;
+		alrm.pending = 0;
+		alrm.time.tm_mday = -1;
+		alrm.time.tm_mon = -1;
+		alrm.time.tm_year = -1;
+		alrm.time.tm_wday = -1;
+		alrm.time.tm_yday = -1;
+		alrm.time.tm_isdst = -1;
+		err = rtc_set_alarm(class_dev, &alrm);
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
+		if ((err = copy_from_user(&alrm, uarg, sizeof(alrm))))
+			return -EFAULT;
+
+		err = rtc_set_alarm(class_dev, &alrm);
+		break;
+
+	case RTC_WKALM_RD:
+		if ((err = rtc_read_alarm(class_dev, &alrm)) < 0)
+			return err;
+
+		if ((err = copy_to_user(uarg, &alrm, sizeof(alrm))))
+			return -EFAULT;
+		break;
+
+	default:
+		if (ops->ioctl)
+			err = ops->ioctl(class_dev->dev, cmd, arg);
+		break;
+	}
+
+	return err;
+}
+
+static int rtc_dev_release(struct inode *inode, struct file *file)
+{
+	struct class_device *class_dev = file->private_data;
+	struct rtc_class_ops *ops = class_get_devdata(class_dev);
+
+	if (ops->release)
+		ops->release(class_dev->dev);
+
+	spin_lock_irq(&rtc_lock);
+	rtc_irq_data = 0;
+	spin_unlock_irq(&rtc_lock);
+
+	module_put(ops->owner);
+	rtc_inuse = 0;
+
+	return 0;
+}
+
+static int rtc_dev_fasync(int fd, struct file *file, int on)
+{
+	return fasync_helper(fd, file, on, &rtc_async_queue);
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
+static struct miscdevice rtc_misc_dev = {
+	.minor		= RTC_MINOR,
+	.name		= "rtc",
+	.fops		= &rtc_dev_fops,
+};
+
+/* insertion/removal hooks */
+
+static int rtc_dev_add_device(struct class_device *class_dev,
+					   struct class_interface *class_intf)
+{
+	down(&rtc_sem);
+	if (rtc_dev == NULL) {
+		rtc_dev = class_dev;
+		misc_register(&rtc_misc_dev);
+		dev_info(class_dev->dev, "rtc intf: dev\n");
+	}
+	up(&rtc_sem);
+
+	return 0;
+}
+
+static void rtc_dev_remove_device(struct class_device *class_dev,
+					      struct class_interface *class_intf)
+{
+	down(&rtc_sem);
+	if (class_dev == rtc_dev) {
+		misc_deregister(&rtc_misc_dev);
+		rtc_dev = NULL;
+	}
+	up(&rtc_sem);
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
+	return rtc_interface_register(&rtc_dev_interface);
+}
+
+static void __exit rtc_dev_exit(void)
+{
+	class_interface_unregister(&rtc_dev_interface);
+}
+
+module_init(rtc_dev_init);
+module_exit(rtc_dev_exit);
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("RTC class dev interface");
+MODULE_LICENSE("GPL");
--- linux-nslu2.orig/drivers/rtc/Kconfig	2005-12-20 20:43:57.000000000 +0100
+++ linux-nslu2/drivers/rtc/Kconfig	2005-12-20 20:44:01.000000000 +0100
@@ -41,6 +41,17 @@ config RTC_INTF_PROC
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
 
--- linux-nslu2.orig/drivers/rtc/Makefile	2005-12-20 20:43:57.000000000 +0100
+++ linux-nslu2/drivers/rtc/Makefile	2005-12-20 20:44:01.000000000 +0100
@@ -8,3 +8,4 @@ rtc-core-y			:= class.o intf.o
 rtc-core-objs			:= $(rtc-core-y)
 obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
 obj-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
+obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
