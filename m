Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVLTUw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVLTUw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVLTUvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:51:06 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:2796 "EHLO mail.towertech.it")
	by vger.kernel.org with ESMTP id S932095AbVLTUul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:50:41 -0500
Date: Tue, 20 Dec 2005 21:45:11 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051220214511.12bbb69c@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the basic RTC subsytem infrastructure
to the kernel.

rtc/class.c - registration facilities for RTC drivers
rtc/intf.c - kernel/rtc interface functions 
rtc/utils.c - misc rtc-related utility functions

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--
 drivers/Kconfig      |    2 
 drivers/Makefile     |    2 
 drivers/rtc/Kconfig  |   25 +++++++++++
 drivers/rtc/Makefile |    8 +++
 drivers/rtc/class.c  |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/rtc/intf.c   |   67 +++++++++++++++++++++++++++++++
 drivers/rtc/utils.c  |   99 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/rtc.h  |   30 +++++++++++++
 8 files changed, 343 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/class.c	2005-12-15 10:22:20.000000000 +0100
@@ -0,0 +1,110 @@
+/*
+ * rtc-class.c - rtc subsystem, base class
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
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kdev_t.h>
+#include <linux/idr.h>
+#include <linux/rtc.h>
+
+#define RTC_ID_PREFIX "rtc"
+#define RTC_ID_FORMAT RTC_ID_PREFIX "%d"
+
+static struct class *rtc_class;
+
+static DEFINE_IDR(rtc_idr);
+
+/**
+ * rtc_device_register - register w/ hwmon sysfs class
+ * @dev: the device to register
+ *
+ * rtc_device_unregister() must be called when the class device is no
+ * longer needed.
+ *
+ * Returns the pointer to the new struct class device.
+ */
+struct class_device *rtc_device_register(struct device *dev,
+					struct rtc_class_ops *ops)
+{
+	struct class_device *cdev;
+	int id;
+
+	if (idr_pre_get(&rtc_idr, GFP_KERNEL) == 0)
+		return ERR_PTR(-ENOMEM);
+
+	if (idr_get_new(&rtc_idr, NULL, &id) < 0)
+		return ERR_PTR(-ENOMEM);
+
+	id = id & MAX_ID_MASK;
+	cdev = class_device_create(rtc_class, NULL, MKDEV(0,0), dev,
+					RTC_ID_FORMAT, id);
+
+	if (IS_ERR(cdev))
+		idr_remove(&rtc_idr, id);
+	else
+		dev_info(dev, "rtc core: registered\n");
+
+	class_set_devdata(cdev, ops);
+
+	return cdev;
+}
+
+/**
+ * rtc_device_unregister - removes the previously registered class device
+ *
+ * @cdev: the class device to destroy
+ */
+void rtc_device_unregister(struct class_device *cdev)
+{
+	int id;
+
+	if (sscanf(cdev->class_id, RTC_ID_FORMAT, &id) == 1) {
+		class_device_unregister(cdev);
+		idr_remove(&rtc_idr, id);
+	} else
+		dev_dbg(cdev->dev,
+			"rtc_device_unregister() failed: bad class ID!\n");
+}
+
+int rtc_interface_register(struct class_interface *intf)
+{
+	intf->class = rtc_class;
+        return class_interface_register(intf);
+}
+EXPORT_SYMBOL(rtc_interface_register);
+
+static int __init rtc_init(void)
+{
+	rtc_class = class_create(THIS_MODULE, "rtc");
+	if (IS_ERR(rtc_class)) {
+		printk(KERN_ERR "rtc-class.c: couldn't create class\n");
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
+EXPORT_SYMBOL_GPL(rtc_device_register);
+EXPORT_SYMBOL_GPL(rtc_device_unregister);
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towerteh.it>");
+MODULE_DESCRIPTION("RTC class support");
+MODULE_LICENSE("GPL");
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/intf.c	2005-12-15 09:28:14.000000000 +0100
@@ -0,0 +1,67 @@
+/*
+ * rtc-intf.c - rtc subsystem, interface functions
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
+#include <linux/rtc.h>
+
+int rtc_read_time(struct class_device *class_dev, struct rtc_time *tm)
+{
+	int err = -EINVAL;
+	struct rtc_class_ops *ops = class_get_devdata(class_dev);
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
+	int err = -EINVAL;
+	struct rtc_class_ops *ops = class_get_devdata(class_dev);
+
+	err = rtc_valid_tm(tm);
+	if (err == 0 && ops->set_time)
+		err = ops->set_time(class_dev->dev, tm);
+
+	return err;
+}
+EXPORT_SYMBOL(rtc_set_time);
+
+int rtc_read_alarm(struct class_device *class_dev, struct rtc_wkalrm *alrm)
+{
+	struct rtc_class_ops *ops = class_get_devdata(class_dev);
+	int err = -EINVAL;
+
+	if (ops->read_alarm) {
+		memset(alrm, 0, sizeof(struct rtc_wkalrm));
+		err = ops->read_alarm(class_dev->dev, alrm);
+	}
+	return err;
+}
+EXPORT_SYMBOL(rtc_read_alarm);
+
+int rtc_set_alarm(struct class_device *class_dev, struct rtc_wkalrm *alrm)
+{
+	int err = -EINVAL;
+	struct rtc_class_ops *ops = class_get_devdata(class_dev);
+
+	if (ops->set_alarm)
+		err = ops->set_alarm(class_dev->dev, alrm);
+	return err;
+}
+EXPORT_SYMBOL(rtc_set_alarm);
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/Kconfig	2005-12-20 19:52:39.000000000 +0100
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
+++ linux-nslu2/drivers/rtc/Makefile	2005-12-20 19:52:39.000000000 +0100
@@ -0,0 +1,8 @@
+#
+# Makefile for RTC class/drivers.
+#
+
+obj-y				+= utils.o
+obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
+rtc-core-y			:= class.o intf.o
+rtc-core-objs			:= $(rtc-core-y)
--- linux-nslu2.orig/include/linux/rtc.h	2005-12-15 09:28:09.000000000 +0100
+++ linux-nslu2/include/linux/rtc.h	2005-12-15 09:28:14.000000000 +0100
@@ -93,6 +93,36 @@ struct rtc_pll_info {
 
 #ifdef __KERNEL__
 
+#include <linux/device.h>
+
+struct rtc_class_ops {
+	struct module *owner;
+	int (*open)(struct device *);
+	void (*release)(struct device *);
+	int (*ioctl)(struct device *, unsigned int, unsigned long);
+	int (*read_time)(struct device *, struct rtc_time *);
+	int (*set_time)(struct device *, struct rtc_time *);
+	int (*read_alarm)(struct device *, struct rtc_wkalrm *);
+	int (*set_alarm)(struct device *, struct rtc_wkalrm *);
+	int (*proc)(struct device *, char *buf);
+	int (*set_mmss)(struct device *, unsigned long secs);
+};
+
+extern int rtc_interface_register(struct class_interface *intf);
+extern struct class_device *rtc_device_register(struct device *dev,
+					struct rtc_class_ops *ops);
+extern void rtc_device_unregister(struct class_device *cdev);
+
+
+extern int rtc_month_days(unsigned int month, unsigned int year);
+extern int rtc_valid_tm(struct rtc_time *tm);
+extern int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time);
+
+extern int rtc_read_time(struct class_device *class_dev, struct rtc_time *tm);
+extern int rtc_set_time(struct class_device *class_dev, struct rtc_time *tm);
+extern int rtc_read_alarm(struct class_device *class_dev, struct rtc_wkalrm *alrm);
+extern int rtc_set_alarm(struct class_device *class_dev, struct rtc_wkalrm *alrm);
+
 typedef struct rtc_task {
 	void (*func)(void *private_data);
 	void *private_data;
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/utils.c	2005-12-15 09:28:14.000000000 +0100
@@ -0,0 +1,99 @@
+/*
+ * rtc-utils.c - rtc subsystem, utility functions
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
+#include <linux/module.h>
+#include <linux/rtc.h>
+
+static const unsigned char rtc_days_in_month[] = {
+	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
+};
+EXPORT_SYMBOL(rtc_days_in_month);
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
+
+	return 0;
+}
+EXPORT_SYMBOL(rtc_tm_to_time);
--- linux-nslu2.orig/drivers/Kconfig	2005-12-15 09:28:09.000000000 +0100
+++ linux-nslu2/drivers/Kconfig	2005-12-15 09:28:14.000000000 +0100
@@ -66,4 +66,6 @@ source "drivers/infiniband/Kconfig"
 
 source "drivers/sn/Kconfig"
 
+source "drivers/rtc/Kconfig"
+
 endmenu
--- linux-nslu2.orig/drivers/Makefile	2005-12-15 09:28:09.000000000 +0100
+++ linux-nslu2/drivers/Makefile	2005-12-15 09:51:34.000000000 +0100
@@ -54,6 +54,8 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
+# rtc should be before i2c for now.
+obj-y				+= rtc/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_HWMON)		+= hwmon/
