Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWCFB5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWCFB5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWCFB5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:57:00 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:58239 "EHLO
	linux") by vger.kernel.org with ESMTP id S1751607AbWCFBxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:53:14 -0500
Message-Id: <20060306015010.359877000@towertech.it>
References: <20060306015008.858209000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 06 Mar 2006 02:50:15 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@digeo.com, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/16] RTC subsystem, sysfs interface
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
Signed-off-by: Andrew Morton <akpm@osdl.org>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
--

 drivers/rtc/Kconfig     |   11 ++++
 drivers/rtc/Makefile    |    3 +
 drivers/rtc/rtc-sysfs.c |  124 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/rtc-sysfs.c	2006-03-05 02:46:59.000000000 +0100
@@ -0,0 +1,124 @@
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
+	retval = rtc_read_time(dev, &tm);
+	if (retval == 0) {
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
+	retval = rtc_read_time(dev, &tm);
+	if (retval == 0) {
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
+	retval = rtc_read_time(dev, &tm);
+	if (retval == 0) {
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
+	&class_device_attr_name.attr,
+	&class_device_attr_date.attr,
+	&class_device_attr_time.attr,
+	&class_device_attr_since_epoch.attr,
+	NULL,
+};
+
+static struct attribute_group rtc_attr_group = {
+	.attrs = rtc_attrs,
+};
+
+static int __devinit rtc_sysfs_add_device(struct class_device *class_dev,
+					struct class_interface *class_intf)
+{
+	int err;
+
+	dev_info(class_dev->dev, "rtc intf: sysfs\n");
+
+	err = sysfs_create_group(&class_dev->kobj, &rtc_attr_group);
+	if (err)
+		dev_err(class_dev->dev,
+			"failed to create sysfs attributes\n");
+
+	return err;
+}
+
+static void rtc_sysfs_remove_device(struct class_device *class_dev,
+				struct class_interface *class_intf)
+{
+	sysfs_remove_group(&class_dev->kobj, &rtc_attr_group);
+}
+
+/* interface registration */
+
+static struct class_interface rtc_sysfs_interface = {
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
--- linux-rtc.orig/drivers/rtc/Kconfig	2006-03-05 02:39:59.000000000 +0100
+++ linux-rtc/drivers/rtc/Kconfig	2006-03-05 02:46:23.000000000 +0100
@@ -40,6 +40,17 @@ config RTC_HCTOSYS_DEVICE
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
 
--- linux-rtc.orig/drivers/rtc/Makefile	2006-03-05 02:40:00.000000000 +0100
+++ linux-rtc/drivers/rtc/Makefile	2006-03-05 02:46:23.000000000 +0100
@@ -6,3 +6,6 @@ obj-$(CONFIG_RTC_LIB)		+= rtc-lib.o
 obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 rtc-core-y			:= class.o interface.o
+
+obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
+

--
