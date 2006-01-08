Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965378AbWAIArJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965378AbWAIArJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbWAIAqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:46:38 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:61925 "EHLO
	linux") by vger.kernel.org with ESMTP id S965371AbWAIAqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:46:37 -0500
Message-Id: <20060108231254.295544000@linux>
References: <20060108231235.153748000@linux>
Date: Mon, 09 Jan 2006 00:12:36 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] RTC subsystem, class
Content-Disposition: inline; filename=rtc-class.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the basic RTC subsytem infrastructure
to the kernel.

rtc/class.c - registration facilities for RTC drivers
rtc/interface.c - kernel/rtc interface functions 
rtc/utils.c - misc rtc-related utility functions

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--
 drivers/Kconfig         |    2 
 drivers/Makefile        |    1 
 drivers/rtc/Kconfig     |   25 ++++++
 drivers/rtc/Makefile    |    8 ++
 drivers/rtc/class.c     |  143 ++++++++++++++++++++++++++++++++++++
 drivers/rtc/interface.c |  189 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/rtc/utils.c     |   97 ++++++++++++++++++++++++
 include/linux/rtc.h     |   73 ++++++++++++++++++
 8 files changed, 538 insertions(+)

--- linux-nslu2.orig/include/linux/rtc.h	2006-01-04 02:36:34.000000000 +0100
+++ linux-nslu2/include/linux/rtc.h	2006-01-08 16:59:26.000000000 +0100
@@ -91,8 +91,81 @@ struct rtc_pll_info {
 #define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
 #define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
 
+/* interrupt flags */
+#define RTC_IRQF 0x80 /* any of the following is active */
+#define RTC_PF 0x40
+#define RTC_AF 0x20
+#define RTC_UF 0x10
+
 #ifdef __KERNEL__
 
+#include <linux/device.h>
+#include <linux/seq_file.h>
+#include <linux/cdev.h>
+#include <linux/poll.h>
+
+struct rtc_class_ops {
+	int (*open)(struct device *);
+	void (*release)(struct device *);
+	int (*ioctl)(struct device *, unsigned int, unsigned long);
+	int (*read_time)(struct device *, struct rtc_time *);
+	int (*set_time)(struct device *, struct rtc_time *);
+	int (*read_alarm)(struct device *, struct rtc_wkalrm *);
+	int (*set_alarm)(struct device *, struct rtc_wkalrm *);
+	int (*proc)(struct device *, struct seq_file *);
+	int (*set_mmss)(struct device *, unsigned long secs);
+	int (*irq_set_state)(struct device *, int enabled);
+	int (*irq_set_freq)(struct device *, int freq);
+};
+
+#define RTC_DEVICE_NAME_SIZE 20
+struct rtc_task;
+
+struct rtc_device
+{
+	int id;
+	struct module *owner;
+	struct class_device class_dev;
+	struct semaphore ops_lock;
+	struct rtc_class_ops *ops;
+	char name[RTC_DEVICE_NAME_SIZE];
+
+	struct cdev char_dev;
+	struct semaphore char_sem;
+
+	unsigned long irq_data;
+	spinlock_t irq_lock;
+	wait_queue_head_t irq_queue;
+	struct fasync_struct *async_queue;
+
+	spinlock_t irq_task_lock;
+	struct rtc_task *irq_task;
+	int irq_freq;
+};
+#define to_rtc_device(d) container_of(d, struct rtc_device, class_dev)
+
+extern struct rtc_device *rtc_device_register(char *name,
+					struct device *dev,
+					struct rtc_class_ops *ops,
+					struct module *owner);
+extern void rtc_device_unregister(struct rtc_device *rdev);
+extern int rtc_interface_register(struct class_interface *intf);
+
+
+extern int rtc_month_days(unsigned int month, unsigned int year);
+extern int rtc_valid_tm(struct rtc_time *tm);
+extern int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time);
+extern void rtc_time_to_tm(unsigned long time, struct rtc_time *tm);
+
+extern int rtc_read_time(struct class_device *class_dev, struct rtc_time *tm);
+extern int rtc_set_time(struct class_device *class_dev, struct rtc_time *tm);
+extern int rtc_read_alarm(struct class_device *class_dev,
+				struct rtc_wkalrm *alrm);
+extern int rtc_set_alarm(struct class_device *class_dev,
+				struct rtc_wkalrm *alrm);
+extern void rtc_update_irq(struct class_device *class_dev,
+			unsigned long num, unsigned long events);
+
 typedef struct rtc_task {
 	void (*func)(void *private_data);
 	void *private_data;
--- linux-nslu2.orig/drivers/Kconfig	2006-01-04 02:36:34.000000000 +0100
+++ linux-nslu2/drivers/Kconfig	2006-01-08 15:49:13.000000000 +0100
@@ -66,4 +66,6 @@ source "drivers/infiniband/Kconfig"
 
 source "drivers/sn/Kconfig"
 
+source "drivers/rtc/Kconfig"
+
 endmenu
--- linux-nslu2.orig/drivers/Makefile	2006-01-04 02:36:34.000000000 +0100
+++ linux-nslu2/drivers/Makefile	2006-01-08 15:49:13.000000000 +0100
@@ -54,6 +54,7 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
+obj-y				+= rtc/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_HWMON)		+= hwmon/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/class.c	2006-01-08 17:07:35.000000000 +0100
@@ -0,0 +1,143 @@
+/*
+ * RTC subsystem, base class
+ *
+ * Copyright (C) 2005 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * class skeleton from drivers/hwmon/hwmon.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/kdev_t.h>
+#include <linux/idr.h>
+
+static DEFINE_IDR(rtc_idr);
+static DECLARE_MUTEX(idr_lock);
+struct class *rtc_class;
+
+static void rtc_device_release(struct class_device *class_dev)
+{
+	struct rtc_device *rtc = to_rtc_device(class_dev);
+	down(&idr_lock);
+	idr_remove(&rtc_idr, rtc->id);
+	up(&idr_lock);
+	kfree(rtc);
+}
+
+/**
+ * rtc_device_register - register w/ RTC class
+ * @dev: the device to register
+ *
+ * rtc_device_unregister() must be called when the class device is no
+ * longer needed.
+ *
+ * Returns the pointer to the new struct class device.
+ */
+struct rtc_device *rtc_device_register(char *name, struct device *dev,
+					struct rtc_class_ops *ops,
+					struct module *owner)
+{
+	struct rtc_device *rtc;
+	int id, err;
+
+	if (idr_pre_get(&rtc_idr, GFP_KERNEL) == 0) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+
+	down(&idr_lock);
+	err = idr_get_new(&rtc_idr, NULL, &id);
+	up(&idr_lock);
+
+	if (err < 0)
+		goto exit;
+
+	id = id & MAX_ID_MASK;
+
+	if ((rtc = kzalloc(sizeof(struct rtc_device), GFP_KERNEL)) == NULL) {
+		err = -ENOMEM;
+		goto exit_idr;
+	}
+
+	rtc->id = id;
+	rtc->ops = ops;
+	rtc->owner = owner;
+	rtc->class_dev.dev = dev;
+	rtc->class_dev.class = rtc_class;
+	rtc->class_dev.release = rtc_device_release;
+
+	init_MUTEX(&rtc->ops_lock);
+	spin_lock_init(&rtc->irq_lock);
+	spin_lock_init(&rtc->irq_task_lock);
+
+	strlcpy(rtc->name, name, RTC_DEVICE_NAME_SIZE);
+	snprintf(rtc->class_dev.class_id, BUS_ID_SIZE, "rtc%d", id);
+
+	if ((err = class_device_register(&rtc->class_dev)))
+		goto exit_kfree;
+
+	dev_info(dev, "rtc core: registered %s as %s\n",
+			rtc->name, rtc->class_dev.class_id);
+
+	return rtc;
+
+exit_kfree:
+	kfree(rtc);
+
+exit_idr:
+	idr_remove(&rtc_idr, id);
+
+exit:
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(rtc_device_register);
+
+
+/**
+ * rtc_device_unregister - removes the previously registered RTC class device
+ *
+ * @rtc: the RTC class device to destroy
+ */
+void rtc_device_unregister(struct rtc_device *rtc)
+{
+	down(&rtc->ops_lock);
+	rtc->ops = NULL;
+	up(&rtc->ops_lock);
+	class_device_unregister(&rtc->class_dev);
+}
+EXPORT_SYMBOL_GPL(rtc_device_unregister);
+
+int rtc_interface_register(struct class_interface *intf)
+{
+	intf->class = rtc_class;
+	return class_interface_register(intf);
+}
+EXPORT_SYMBOL_GPL(rtc_interface_register);
+
+static int __init rtc_init(void)
+{
+	rtc_class = class_create(THIS_MODULE, "rtc");
+	if (IS_ERR(rtc_class)) {
+		printk(KERN_ERR "%s: couldn't create class\n", __FILE__);
+		return PTR_ERR(rtc_class);
+	}
+	return 0;
+}
+
+static void __exit rtc_exit(void)
+{
+	class_destroy(rtc_class);
+}
+
+module_init(rtc_init);
+module_exit(rtc_exit);
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towerteh.it>");
+MODULE_DESCRIPTION("RTC class support");
+MODULE_LICENSE("GPL");
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/Kconfig	2006-01-08 18:54:54.000000000 +0100
@@ -0,0 +1,25 @@
+#
+# RTC class/drivers configuration
+#
+
+menu "Real Time Clock"
+
+config RTC_CLASS
+	tristate "RTC class"
+	depends on EXPERIMENTAL
+	default y
+	help
+	  Generic RTC class support. If you say yes here, you will
+ 	  be allowed to plug one or more RTCs to your system. You will
+	  probably want to enable one of more of the interfaces below.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-class.
+
+comment "RTC interfaces"
+	depends on RTC_CLASS
+
+comment "RTC drivers"
+	depends on RTC_CLASS
+
+endmenu
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/Makefile	2006-01-08 18:54:54.000000000 +0100
@@ -0,0 +1,8 @@
+#
+# Makefile for RTC class/drivers.
+#
+
+obj-y				+= utils.o
+obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
+rtc-core-y			:= class.o interface.o
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/interface.c	2006-01-04 03:56:39.000000000 +0100
@@ -0,0 +1,189 @@
+/*
+ * RTC subsystem, interface functions
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
+#include <linux/rtc.h>
+
+extern struct class *rtc_class;
+
+int rtc_read_time(struct class_device *class_dev, struct rtc_time *tm)
+{
+	int err = -EINVAL;
+	struct rtc_class_ops *ops = to_rtc_device(class_dev)->ops;
+
+	if (ops->read_time) {
+		memset(tm, 0, sizeof(struct rtc_time));
+		err = ops->read_time(class_dev->dev, tm);
+	}
+	return err;
+}
+EXPORT_SYMBOL(rtc_read_time);
+
+int rtc_set_time(struct class_device *class_dev, struct rtc_time *tm)
+{
+	int err;
+	struct rtc_class_ops *ops = to_rtc_device(class_dev)->ops;
+
+	err = rtc_valid_tm(tm);
+	if (err == 0 && ops->set_time)
+		err = ops->set_time(class_dev->dev, tm);
+
+	return err;
+}
+EXPORT_SYMBOL(rtc_set_time);
+
+int rtc_read_alarm(struct class_device *class_dev, struct rtc_wkalrm *alarm)
+{
+	struct rtc_class_ops *ops = to_rtc_device(class_dev)->ops;
+	int err = -EINVAL;
+
+	if (ops->read_alarm) {
+		memset(alarm, 0, sizeof(struct rtc_wkalrm));
+		err = ops->read_alarm(class_dev->dev, alarm);
+	}
+	return err;
+}
+EXPORT_SYMBOL(rtc_read_alarm);
+
+int rtc_set_alarm(struct class_device *class_dev, struct rtc_wkalrm *alarm)
+{
+	int err = -EINVAL;
+	struct rtc_class_ops *ops = to_rtc_device(class_dev)->ops;
+
+	if (ops->set_alarm)
+		err = ops->set_alarm(class_dev->dev, alarm);
+	return err;
+}
+EXPORT_SYMBOL(rtc_set_alarm);
+
+void rtc_update_irq(struct class_device *class_dev,
+		unsigned long num, unsigned long events)
+{
+	struct rtc_device *rtc = to_rtc_device(class_dev);
+
+	spin_lock(&rtc->irq_lock);
+	rtc->irq_data = (rtc->irq_data + (num << 8)) | events;
+	spin_unlock(&rtc->irq_lock);
+
+	spin_lock(&rtc->irq_task_lock);
+	if (rtc->irq_task)
+		rtc->irq_task->func(rtc->irq_task->private_data);
+	spin_unlock(&rtc->irq_task_lock);
+
+	wake_up_interruptible(&rtc->irq_queue);
+	kill_fasync(&rtc->async_queue, SIGIO, POLL_IN);
+}
+EXPORT_SYMBOL(rtc_update_irq);
+
+struct class_device *rtc_open(char *name)
+{
+	struct class_device *class_dev = NULL,
+				*class_dev_tmp;
+
+	down(&rtc_class->sem);
+	list_for_each_entry(class_dev_tmp, &rtc_class->children, node) {
+		if (strncmp(class_dev_tmp->class_id, name, BUS_ID_SIZE) == 0) {
+			class_dev = class_dev_tmp;
+			break;
+		}
+	}
+	up(&rtc_class->sem);
+
+	return class_dev;
+}
+EXPORT_SYMBOL(rtc_open);
+
+void rtc_close(struct class_device *class_dev)
+{
+}
+EXPORT_SYMBOL(rtc_close);
+
+int rtc_irq_register(struct class_device *class_dev, struct rtc_task *task)
+{
+	int retval = -EBUSY;
+	struct rtc_device *rtc = to_rtc_device(class_dev);
+
+	if (task == NULL || task->func == NULL)
+		return -EINVAL;
+
+	spin_lock(&rtc->irq_task_lock);
+	if (rtc->irq_task == NULL) {
+		rtc->irq_task = task;
+		retval = 0;
+	}
+	spin_unlock(&rtc->irq_task_lock);
+
+	return retval;
+}
+EXPORT_SYMBOL(rtc_irq_register);
+
+void rtc_irq_unregister(struct class_device *class_dev, struct rtc_task *task)
+{
+	struct rtc_device *rtc = to_rtc_device(class_dev);
+
+	spin_lock(&rtc->irq_task_lock);
+	if (rtc->irq_task == task)
+		rtc->irq_task = NULL;
+	spin_unlock(&rtc->irq_task_lock);
+}
+EXPORT_SYMBOL(rtc_irq_unregister);
+
+int rtc_irq_set_state(struct class_device *class_dev, struct rtc_task *task, int enabled)
+{
+	int err = 0;
+	unsigned long flags;
+	struct rtc_device *rtc = to_rtc_device(class_dev);
+
+	spin_lock_irqsave(&rtc->irq_task_lock, flags);
+	if (rtc->irq_task != task)
+		err = -ENXIO;
+	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
+
+	if (err == 0)
+		err = rtc->ops->irq_set_state(class_dev->dev, enabled);
+
+	return err;
+}
+EXPORT_SYMBOL(rtc_irq_set_state);
+
+int rtc_irq_set_freq(struct class_device *class_dev, struct rtc_task *task, int freq)
+{
+	int err = 0, tmp = 0;
+	unsigned long flags;
+	struct rtc_device *rtc = to_rtc_device(class_dev);
+
+	/* allowed range is 2-8192 */
+	if (freq < 2 || freq > 8192)
+		return -EINVAL;
+
+/*	if ((freq > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
+		return -EACCES;
+*/
+	/* check if freq is a power of 2 */
+	while (freq > (1 << tmp))
+		tmp++;
+
+	if (freq != (1 << tmp))
+		return -EINVAL;
+
+	spin_lock_irqsave(&rtc->irq_task_lock, flags);
+	if (rtc->irq_task != task)
+		err = -ENXIO;
+	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
+
+	if (err == 0) {
+		if ((err = rtc->ops->irq_set_freq(class_dev->dev, freq)) == 0)
+			rtc->irq_freq = freq;
+	}
+	return err;
+
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/utils.c	2006-01-04 03:56:39.000000000 +0100
@@ -0,0 +1,97 @@
+/*
+ * RTC subsystem, utility functions
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
+#include <linux/rtc.h>
+
+static const unsigned char rtc_days_in_month[] = {
+	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
+};
+
+#define LEAPS_THRU_END_OF(y) ((y)/4 - (y)/100 + (y)/400)
+#define LEAP_YEAR(year) ((!(year % 4) && (year % 100)) || !(year % 400))
+
+int rtc_month_days(unsigned int month, unsigned int year)
+{
+	return rtc_days_in_month[month] + (LEAP_YEAR(year) && month == 1);
+}
+EXPORT_SYMBOL(rtc_month_days);
+
+/*
+ * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
+ */
+void rtc_time_to_tm(unsigned long time, struct rtc_time *tm)
+{
+	int days, month, year;
+
+	days = time / 86400;
+	time -= days * 86400;
+
+	tm->tm_wday = (days + 4) % 7;
+
+	year = 1970 + days / 365;
+	days -= (year - 1970) * 365
+	        + LEAPS_THRU_END_OF(year - 1)
+	        - LEAPS_THRU_END_OF(1970 - 1);
+	if (days < 0) {
+		year -= 1;
+		days += 365 + LEAP_YEAR(year);
+	}
+	tm->tm_year = year - 1900;
+	tm->tm_yday = days + 1;
+
+	for (month = 0; month < 11; month++) {
+		int newdays;
+
+		newdays = days - rtc_month_days(month, year);
+		if (newdays < 0)
+			break;
+		days = newdays;
+	}
+	tm->tm_mon = month;
+	tm->tm_mday = days + 1;
+
+	tm->tm_hour = time / 3600;
+	time -= tm->tm_hour * 3600;
+	tm->tm_min = time / 60;
+	tm->tm_sec = time - tm->tm_min * 60;
+}
+EXPORT_SYMBOL(rtc_time_to_tm);
+
+/*
+ * Does the rtc_time represent a valid date/time?
+ */
+int rtc_valid_tm(struct rtc_time *tm)
+{
+	if (tm->tm_year < 70 ||
+	    tm->tm_mon >= 12 ||
+	    tm->tm_mday < 1 ||
+	    tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900) ||
+	    tm->tm_hour >= 24 ||
+	    tm->tm_min >= 60 ||
+	    tm->tm_sec >= 60)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(rtc_valid_tm);
+
+/*
+ * Convert Gregorian date to seconds since 01-01-1970 00:00:00.
+ */
+int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time)
+{
+	*time = mktime(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
+		       tm->tm_hour, tm->tm_min, tm->tm_sec);
+	return 0;
+}
+EXPORT_SYMBOL(rtc_tm_to_time);

--
