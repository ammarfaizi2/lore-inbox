Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVLZTUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVLZTUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVLZTT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:19:59 -0500
Received: from smtp4.libero.it ([193.70.192.54]:17080 "EHLO smtp4.libero.it")
	by vger.kernel.org with ESMTP id S932112AbVLZTTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:19:34 -0500
Date: Mon, 26 Dec 2005 19:57:50 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3/7] RTC subsystem, sysfs interface
Message-ID: <20051226195750.36d63c6d@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned: with antispam and antivirus automated system at libero.it
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
 drivers/rtc/Makefile    |    2 
 drivers/rtc/rtc-sysfs.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/rtc/rtc-sysfs.c	2005-12-26 19:32:52.000000000 +0100
@@ -0,0 +1,99 @@
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
+static CLASS_DEVICE_ATTR(date, S_IRUGO, rtc_sysfs_show_date, NULL);
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
+static CLASS_DEVICE_ATTR(time, S_IRUGO, rtc_sysfs_show_time, NULL);
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
+static CLASS_DEVICE_ATTR(since_epoch, S_IRUGO, rtc_sysfs_show_since_epoch, NULL);
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
--- linux.orig/drivers/rtc/Kconfig	2005-12-26 19:14:29.000000000 +0100
+++ linux/drivers/rtc/Kconfig	2005-12-26 19:35:31.000000000 +0100
@@ -19,6 +19,17 @@
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
 
--- linux.orig/drivers/rtc/Makefile	2005-12-26 19:14:29.000000000 +0100
+++ linux/drivers/rtc/Makefile	2005-12-26 19:35:31.000000000 +0100
@@ -5,4 +5,4 @@
 obj-y				+= utils.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 rtc-core-y			:= class.o interface.o
-
+obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
