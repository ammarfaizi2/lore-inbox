Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVLTUvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVLTUvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVLTUvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:51:00 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:3820 "EHLO mail.towertech.it")
	by vger.kernel.org with ESMTP id S932098AbVLTUum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:50:42 -0500
Date: Tue, 20 Dec 2005 21:47:14 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3/6] RTC subsystem, sysfs interface
Message-ID: <20051220214714.611abec9@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
 drivers/rtc/Kconfig     |   11 +++++
 drivers/rtc/Makefile    |    1 
 drivers/rtc/rtc-sysfs.c |  101 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/rtc-sysfs.c	2005-12-20 19:39:03.000000000 +0100
@@ -0,0 +1,101 @@
+/*
+    hwmon.c - part of lm_sensors, Linux kernel modules for hardware monitoring
+
+    This file defines the sysfs class "hwmon", for use by sensors drivers.
+
+    Copyright (C) 2005 Mark M. Hoffman <mhoffman@lightlink.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/rtc.h>
+
+/* device attributes */
+
+static ssize_t rtc_sysfs_show_date(struct class_device *dev, char *buf)
+{
+	struct rtc_time tm;
+
+        if (rtc_read_time(dev, &tm) == 0) {
+                return sprintf(buf,
+                        "%04d-%02d-%02d\n",
+                        tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+        }
+	return 0;
+}
+static CLASS_DEVICE_ATTR(date, 0666, rtc_sysfs_show_date, NULL);
+
+static ssize_t rtc_sysfs_show_time(struct class_device *dev, char *buf)
+{
+	struct rtc_time tm;
+
+        if (rtc_read_time(dev, &tm) == 0) {
+                return sprintf(buf,
+                        "%02d:%02d:%02d\n",
+                        tm.tm_hour, tm.tm_min, tm.tm_sec);
+        }
+	return 0;
+}
+static CLASS_DEVICE_ATTR(time, 0666, rtc_sysfs_show_time, NULL);
+
+static ssize_t rtc_sysfs_show_since_epoch(struct class_device *dev, char *buf)
+{
+	unsigned long time;
+	struct rtc_time tm;
+
+        if (rtc_read_time(dev, &tm) == 0) {
+		rtc_tm_to_time(&tm, &time);
+
+                return sprintf(buf, "%lu\n", time);
+        }
+	return 0;
+}
+static CLASS_DEVICE_ATTR(since_epoch, 0666, rtc_sysfs_show_since_epoch, NULL);
+
+/* insertion/removal hooks */
+
+static int __devinit rtc_sysfs_add_device(struct class_device *class_dev,
+					   struct class_interface *class_intf)
+{
+	class_device_create_file(class_dev, &class_device_attr_date);
+	class_device_create_file(class_dev, &class_device_attr_time);
+	class_device_create_file(class_dev, &class_device_attr_since_epoch);
+	dev_info(class_dev->dev, "rtc intf: sysfs\n");
+	return 0;
+}
+
+static void rtc_sysfs_remove_device(struct class_device *class_dev,
+					      struct class_interface *class_intf)
+{
+	class_device_remove_file(class_dev, &class_device_attr_date);
+	class_device_remove_file(class_dev, &class_device_attr_time);
+	class_device_remove_file(class_dev, &class_device_attr_since_epoch);
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
--- linux-nslu2.orig/drivers/rtc/Kconfig	2005-12-20 19:37:24.000000000 +0100
+++ linux-nslu2/drivers/rtc/Kconfig	2005-12-20 19:52:07.000000000 +0100
@@ -19,6 +19,17 @@ config RTC_CLASS
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
 
--- linux-nslu2.orig/drivers/rtc/Makefile	2005-12-20 19:35:13.000000000 +0100
+++ linux-nslu2/drivers/rtc/Makefile	2005-12-20 19:51:54.000000000 +0100
@@ -6,3 +6,4 @@ obj-y				+= utils.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 rtc-core-y			:= class.o intf.o
 rtc-core-objs			:= $(rtc-core-y)
+obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o


