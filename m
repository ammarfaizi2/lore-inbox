Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWBSXf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWBSXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWBSXf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:35:28 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:4034 "EHLO
	linux") by vger.kernel.org with ESMTP id S932419AbWBSXep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:34:45 -0500
Message-Id: <20060219232212.253270000@towertech.it>
References: <20060219232211.368740000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 20 Feb 2006 00:22:15 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] RTC subsystem, sysfs interface
Content-Disposition: inline; filename=rtc-intf-sysfs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the sysfs interface to the
RTC subsystem.

Each RTC client will have his own entry
under /sys/classs/rtc/rtcN .

Within this entry some attributes are
exported by the subsystem, like date and time.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--

 drivers/rtc/Kconfig     |   11 ++++
 drivers/rtc/Makefile    |    2 
 drivers/rtc/rtc-sysfs.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/rtc-sysfs.c	2006-02-19 23:49:10.000000000 +0100
@@ -0,0 +1,120 @@
+/*
+ * RTC subsystem, sysfs interface
+ *
+ * Copyright (C) 2005 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/rtc.h>
+
+/* device attributes */
+
+static ssize_t rtc_sysfs_show_name(struct class_device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", to_rtc_device(dev)->name);
+}
+static CLASS_DEVICE_ATTR(name, S_IRUGO, rtc_sysfs_show_name, NULL);
+
+static ssize_t rtc_sysfs_show_date(struct class_device *dev, char *buf)
+{
+	ssize_t retval;
+	struct rtc_time tm;
+
+	if ((retval = rtc_read_time(dev, &tm)) == 0) {
+		retval = sprintf(buf, "%04d-%02d-%02d\n",
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+	}
+
+	return retval;
+}
+static CLASS_DEVICE_ATTR(date, S_IRUGO, rtc_sysfs_show_date, NULL);
+
+static ssize_t rtc_sysfs_show_time(struct class_device *dev, char *buf)
+{
+	ssize_t retval;
+	struct rtc_time tm;
+
+	if ((retval = rtc_read_time(dev, &tm)) == 0) {
+		retval = sprintf(buf, "%02d:%02d:%02d\n",
+			tm.tm_hour, tm.tm_min, tm.tm_sec);
+	}
+
+	return retval;
+}
+static CLASS_DEVICE_ATTR(time, S_IRUGO, rtc_sysfs_show_time, NULL);
+
+static ssize_t rtc_sysfs_show_since_epoch(struct class_device *dev, char *buf)
+{
+	ssize_t retval;
+	struct rtc_time tm;
+
+	if ((retval = rtc_read_time(dev, &tm)) == 0) {
+		unsigned long time;
+		rtc_tm_to_time(&tm, &time);
+		retval = sprintf(buf, "%lu\n", time);
+	}
+
+	return retval;
+}
+static CLASS_DEVICE_ATTR(since_epoch, S_IRUGO, rtc_sysfs_show_since_epoch, NULL);
+
+static struct attribute *rtc_attrs[] = {
+        &class_device_attr_name.attr,
+        &class_device_attr_date.attr,
+        &class_device_attr_time.attr,
+        &class_device_attr_since_epoch.attr,
+        NULL,
+};
+
+static struct attribute_group rtc_attr_group = {
+        .attrs  = rtc_attrs,
+};
+
+static int __devinit rtc_sysfs_add_device(struct class_device *class_dev,
+					   struct class_interface *class_intf)
+{
+	int err;
+
+	dev_info(class_dev->dev, "rtc intf: sysfs\n");
+
+	if ((err = sysfs_create_group(&class_dev->kobj, &rtc_attr_group)) != 0)
+		dev_err(class_dev->dev,
+			"failed to create sysfs attributes\n");
+
+	return err;
+}
+
+static void rtc_sysfs_remove_device(struct class_device *class_dev,
+				      struct class_interface *class_intf)
+{
+	sysfs_remove_group(&class_dev->kobj, &rtc_attr_group);
+}
+
+/* interface registration */
+
+struct class_interface rtc_sysfs_interface = {
+	.add = &rtc_sysfs_add_device,
+	.remove = &rtc_sysfs_remove_device,
+};
+
+static int __init rtc_sysfs_init(void)
+{
+	return rtc_interface_register(&rtc_sysfs_interface);
+}
+
+static void __exit rtc_sysfs_exit(void)
+{
+	class_interface_unregister(&rtc_sysfs_interface);
+}
+
+module_init(rtc_sysfs_init);
+module_exit(rtc_sysfs_exit);
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("RTC class sysfs interface");
+MODULE_LICENSE("GPL");
--- linux-rtc.orig/drivers/rtc/Kconfig	2006-02-19 23:48:02.000000000 +0100
+++ linux-rtc/drivers/rtc/Kconfig	2006-02-19 23:48:06.000000000 +0100
@@ -36,6 +36,17 @@ config RTC_HCTOSYS_DEVICE
 comment "RTC interfaces"
 	depends on RTC_CLASS
 
+config RTC_INTF_SYSFS
+	tristate "sysfs"
+	depends on RTC_CLASS && SYSFS
+	default RTC_CLASS
+	help
+	  Say yes here if you want to use your RTC using the sysfs
+	  interface, /sys/class/rtc/rtcX .
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-sysfs.
+
 comment "RTC drivers"
 	depends on RTC_CLASS
 
--- linux-rtc.orig/drivers/rtc/Makefile	2006-02-19 23:48:02.000000000 +0100
+++ linux-rtc/drivers/rtc/Makefile	2006-02-19 23:48:06.000000000 +0100
@@ -6,4 +6,4 @@ obj-y				+= utils.o
 obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 rtc-core-y			:= class.o interface.o
-
+obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o

--
