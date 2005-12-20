Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVLTUui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVLTUui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVLTUui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:50:38 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:4332 "EHLO mail.towertech.it")
	by vger.kernel.org with ESMTP id S932090AbVLTUuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:50:37 -0500
Date: Tue, 20 Dec 2005 21:48:01 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 4/6] RTC subsystem, proc interface
Message-ID: <20051220214801.0f4cee7f@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the proc interface to the
RTC subsystem.

The first RTC driver which registers with
the class will be accessible by /proc/driver/rtc .

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--
 drivers/rtc/Kconfig    |   11 ++++
 drivers/rtc/Makefile   |    1 
 drivers/rtc/rtc-proc.c |  132 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/rtc-proc.c	2005-12-20 20:38:50.000000000 +0100
@@ -0,0 +1,132 @@
+/*
+ * rtc-proc.c - rtc subsystem, proc interface
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
+#include <linux/proc_fs.h>
+
+static struct class_device *rtc_dev = NULL;
+static DECLARE_MUTEX(rtc_sem);
+
+static int rtc_proc_read(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	struct class_device *class_dev = data;
+	struct rtc_class_ops *ops = class_get_devdata(class_dev);
+	struct rtc_wkalrm alrm;
+	struct rtc_time tm;
+	char *p = page;
+
+	if (!try_module_get(ops->owner))
+		return -ENODEV;
+
+	if (rtc_read_time(class_dev, &tm) == 0) {
+		p += sprintf(p,
+			"rtc_time\t: %02d:%02d:%02d\n"
+			"rtc_date\t: %04d-%02d-%02d\n",
+			tm.tm_hour, tm.tm_min, tm.tm_sec,
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+	}
+
+	if (rtc_read_alarm(class_dev, &alrm) == 0) {
+		p += sprintf(p, "alrm_time\t: ");
+		if ((unsigned int)alrm.time.tm_hour <= 24)
+			p += sprintf(p, "%02d:", alrm.time.tm_hour);
+		else
+			p += sprintf(p, "**:");
+		if ((unsigned int)alrm.time.tm_min <= 59)
+			p += sprintf(p, "%02d:", alrm.time.tm_min);
+		else
+			p += sprintf(p, "**:");
+		if ((unsigned int)alrm.time.tm_sec <= 59)
+			p += sprintf(p, "%02d\n", alrm.time.tm_sec);
+		else
+			p += sprintf(p, "**\n");
+
+		p += sprintf(p, "alrm_date\t: ");
+		if ((unsigned int)alrm.time.tm_year <= 200)
+			p += sprintf(p, "%04d-", alrm.time.tm_year + 1900);
+		else
+			p += sprintf(p, "****-");
+		if ((unsigned int)alrm.time.tm_mon <= 11)
+			p += sprintf(p, "%02d-", alrm.time.tm_mon + 1);
+		else
+			p += sprintf(p, "**-");
+		if ((unsigned int)alrm.time.tm_mday <= 31)
+			p += sprintf(p, "%02d\n", alrm.time.tm_mday);
+		else
+			p += sprintf(p, "**\n");
+		p += sprintf(p, "alrm_wakeup\t: %s\n",
+			     alrm.enabled ? "yes" : "no");
+		p += sprintf(p, "alrm_pending\t: %s\n",
+			     alrm.pending ? "yes" : "no");
+	}
+
+	if (ops->proc)
+		p += ops->proc(class_dev->dev, p);
+
+	module_put(ops->owner);
+
+	return p - page;
+}
+
+static int rtc_proc_add_device(struct class_device *class_dev,
+					   struct class_interface *class_intf)
+{
+	down(&rtc_sem);
+	if (rtc_dev == NULL) {
+		rtc_dev = class_dev;
+
+		if (create_proc_read_entry("driver/rtc", 0, NULL, rtc_proc_read,
+						class_dev))
+			dev_info(class_dev->dev, "rtc intf: proc\n");
+		else
+			rtc_dev = NULL;
+	}
+	up(&rtc_sem);
+
+	return 0;
+}
+
+static void rtc_proc_remove_device(struct class_device *class_dev,
+					      struct class_interface *class_intf)
+{
+	down(&rtc_sem);
+	if (rtc_dev == class_dev) {
+		remove_proc_entry("driver/rtc", NULL);
+		rtc_dev = NULL;
+	}
+	up(&rtc_sem);
+}
+
+struct class_interface rtc_proc_interface = {
+	.add = &rtc_proc_add_device,
+	.remove = &rtc_proc_remove_device,
+};
+
+static int __init rtc_proc_init(void)
+{
+	return rtc_interface_register(&rtc_proc_interface);
+}
+
+static void __exit rtc_proc_exit(void)
+{
+	class_interface_unregister(&rtc_proc_interface);
+}
+
+module_init(rtc_proc_init);
+module_exit(rtc_proc_exit);
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("RTC class proc interface");
+MODULE_LICENSE("GPL");
--- linux-nslu2.orig/drivers/rtc/Kconfig	2005-12-20 20:37:42.000000000 +0100
+++ linux-nslu2/drivers/rtc/Kconfig	2005-12-20 20:38:50.000000000 +0100
@@ -30,6 +30,17 @@ config RTC_INTF_SYSFS
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-sysfs.
 
+config RTC_INTF_PROC
+	tristate "proc"
+	depends on RTC_CLASS && PROC_FS
+	default RTC_CLASS
+	help
+	  Say yes here if you want to use your RTC using the proc
+	  interface, /proc/driver/rtc .
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-proc.
+
 comment "RTC drivers"
 	depends on RTC_CLASS
 
--- linux-nslu2.orig/drivers/rtc/Makefile	2005-12-20 20:37:42.000000000 +0100
+++ linux-nslu2/drivers/rtc/Makefile	2005-12-20 20:39:16.000000000 +0100
@@ -7,3 +7,4 @@ obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 rtc-core-y			:= class.o intf.o
 rtc-core-objs			:= $(rtc-core-y)
 obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
+obj-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
