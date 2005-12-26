Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVLZTT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVLZTT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVLZTT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:19:58 -0500
Received: from smtp7.libero.it ([193.70.192.90]:36506 "EHLO smtp7.libero.it")
	by vger.kernel.org with ESMTP id S932113AbVLZTTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:19:36 -0500
Date: Mon, 26 Dec 2005 19:58:08 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 4/7] RTC subsystem, proc interface
Message-ID: <20051226195808.5247b180@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the proc interface to the
RTC subsystem.

The first RTC driver which registers with
the class will be accessible by /proc/driver/rtc .

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--

 drivers/rtc/Kconfig    |   11 +++
 drivers/rtc/Makefile   |    1 
 drivers/rtc/rtc-proc.c |  146 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/rtc/rtc-proc.c	2005-12-26 19:33:16.000000000 +0100
@@ -0,0 +1,146 @@
+/*
+ * RTC subsystem, proc interface
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
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+static struct class_device *rtc_dev = NULL;
+static DECLARE_MUTEX(rtc_sem);
+
+static int rtc_proc_show(struct seq_file *seq, void *offset)
+{
+	struct class_device *class_dev = seq->private;
+	struct rtc_class_ops *ops = rtc_get_ops(class_dev);
+	struct rtc_wkalrm alrm;
+	struct rtc_time tm;
+
+	if (rtc_read_time(class_dev, &tm) == 0) {
+		seq_printf(seq,
+			"rtc_time\t: %02d:%02d:%02d\n"
+			"rtc_date\t: %04d-%02d-%02d\n",
+			tm.tm_hour, tm.tm_min, tm.tm_sec,
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+	}
+
+	if (rtc_read_alarm(class_dev, &alrm) == 0) {
+		seq_printf(seq, "alrm_time\t: ");
+		if ((unsigned int)alrm.time.tm_hour <= 24)
+			seq_printf(seq, "%02d:", alrm.time.tm_hour);
+		else
+			seq_printf(seq, "**:");
+		if ((unsigned int)alrm.time.tm_min <= 59)
+			seq_printf(seq, "%02d:", alrm.time.tm_min);
+		else
+			seq_printf(seq, "**:");
+		if ((unsigned int)alrm.time.tm_sec <= 59)
+			seq_printf(seq, "%02d\n", alrm.time.tm_sec);
+		else
+			seq_printf(seq, "**\n");
+
+		seq_printf(seq, "alrm_date\t: ");
+		if ((unsigned int)alrm.time.tm_year <= 200)
+			seq_printf(seq, "%04d-", alrm.time.tm_year + 1900);
+		else
+			seq_printf(seq, "****-");
+		if ((unsigned int)alrm.time.tm_mon <= 11)
+			seq_printf(seq, "%02d-", alrm.time.tm_mon + 1);
+		else
+			seq_printf(seq, "**-");
+		if ((unsigned int)alrm.time.tm_mday <= 31)
+			seq_printf(seq, "%02d\n", alrm.time.tm_mday);
+		else
+			seq_printf(seq, "**\n");
+		seq_printf(seq, "alrm_wakeup\t: %s\n",
+			     alrm.enabled ? "yes" : "no");
+		seq_printf(seq, "alrm_pending\t: %s\n",
+			     alrm.pending ? "yes" : "no");
+	}
+
+	if (ops->proc)
+		ops->proc(class_dev->dev, seq);
+
+	return 0;
+}
+
+static int rtc_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtc_proc_show, rtc_dev);
+}
+
+static struct file_operations rtc_proc_fops = {
+	.open		= rtc_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int rtc_proc_add_device(struct class_device *class_dev,
+					   struct class_interface *class_intf)
+{
+	down(&rtc_sem);
+	if (rtc_dev == NULL) {
+		struct proc_dir_entry *ent;
+
+		rtc_dev = class_dev;
+
+		if ((ent = create_proc_entry("driver/rtc", 0, NULL))) {
+			struct rtc_class_ops *ops = rtc_get_ops(class_dev);
+
+			ent->proc_fops = &rtc_proc_fops;
+			ent->owner = ops->owner;
+			ent->data = class_dev;
+
+			dev_info(class_dev->dev, "rtc intf: proc\n");
+		}
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
--- linux.orig/drivers/rtc/Kconfig	2005-12-26 19:32:52.000000000 +0100
+++ linux/drivers/rtc/Kconfig	2005-12-26 19:35:19.000000000 +0100
@@ -30,6 +30,17 @@
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
 
--- linux.orig/drivers/rtc/Makefile	2005-12-26 19:32:52.000000000 +0100
+++ linux/drivers/rtc/Makefile	2005-12-26 19:35:19.000000000 +0100
@@ -6,3 +6,4 @@
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 rtc-core-y			:= class.o interface.o
 obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
+obj-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
