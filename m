Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWCDQo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWCDQo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWCDQnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:43:52 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:44363 "EHLO
	linux") by vger.kernel.org with ESMTP id S932159AbWCDQna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:43:30 -0500
Message-Id: <20060304164249.441734000@towertech.it>
References: <20060304164247.963655000@towertech.it>
User-Agent: quilt/0.43-1
Date: Sat, 04 Mar 2006 17:42:54 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: [PATCH 07/13] RTC subsystem, proc interface
Content-Disposition: inline; filename=rtc-intf-proc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the proc interface to the
RTC subsystem.

The first RTC driver which registers with
the class will be accessible by /proc/driver/rtc .

This is required for compatibility with the standard
RTC driver and to avoid breaking any user space
application which may erroneusly rely on this.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>
--

 drivers/rtc/Kconfig    |   11 +++
 drivers/rtc/Makefile   |    1 
 drivers/rtc/rtc-proc.c |  162 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/rtc-proc.c	2006-03-04 16:17:10.000000000 +0100
@@ -0,0 +1,162 @@
+/*
+ * RTC subsystem, proc interface
+ *
+ * Copyright (C) 2005-06 Tower Technologies
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
+static DEFINE_MUTEX(rtc_lock);
+
+static int rtc_proc_show(struct seq_file *seq, void *offset)
+{
+	int err;
+	struct class_device *class_dev = seq->private;
+	struct rtc_class_ops *ops = to_rtc_device(class_dev)->ops;
+	struct rtc_wkalrm alrm;
+	struct rtc_time tm;
+
+	err = rtc_read_time(class_dev, &tm);
+	if (err == 0) {
+		seq_printf(seq,
+			"rtc_time\t: %02d:%02d:%02d\n"
+			"rtc_date\t: %04d-%02d-%02d\n",
+			tm.tm_hour, tm.tm_min, tm.tm_sec,
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+	}
+
+	err = rtc_read_alarm(class_dev, &alrm);
+	if (err == 0) {
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
+	struct class_device *class_dev = PDE(inode)->data;
+
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	return single_open(file, rtc_proc_show, class_dev);
+}
+
+static int rtc_proc_release(struct inode *inode, struct file *file)
+{
+	int res = single_release(inode, file);
+	module_put(THIS_MODULE);
+	return res;
+}
+
+static struct file_operations rtc_proc_fops = {
+	.open		= rtc_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= rtc_proc_release,
+};
+
+static int rtc_proc_add_device(struct class_device *class_dev,
+					   struct class_interface *class_intf)
+{
+	mutex_lock(&rtc_lock);
+	if (rtc_dev == NULL) {
+		struct proc_dir_entry *ent;
+
+		rtc_dev = class_dev;
+
+		ent = create_proc_entry("driver/rtc", 0, NULL);
+		if (ent) {
+			struct rtc_device *rtc = to_rtc_device(class_dev);
+
+			ent->proc_fops = &rtc_proc_fops;
+			ent->owner = rtc->owner;
+			ent->data = class_dev;
+
+			dev_info(class_dev->dev, "rtc intf: proc\n");
+		}
+		else
+			rtc_dev = NULL;
+	}
+	mutex_unlock(&rtc_lock);
+
+	return 0;
+}
+
+static void rtc_proc_remove_device(struct class_device *class_dev,
+					      struct class_interface *class_intf)
+{
+	mutex_lock(&rtc_lock);
+	if (rtc_dev == class_dev) {
+		remove_proc_entry("driver/rtc", NULL);
+		rtc_dev = NULL;
+	}
+	mutex_unlock(&rtc_lock);
+}
+
+static struct class_interface rtc_proc_interface = {
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
--- linux-rtc.orig/drivers/rtc/Kconfig	2006-03-04 16:17:08.000000000 +0100
+++ linux-rtc/drivers/rtc/Kconfig	2006-03-04 16:17:10.000000000 +0100
@@ -50,6 +50,17 @@ config RTC_INTF_SYSFS
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
 
--- linux-rtc.orig/drivers/rtc/Makefile	2006-03-04 16:17:08.000000000 +0100
+++ linux-rtc/drivers/rtc/Makefile	2006-03-04 16:17:10.000000000 +0100
@@ -9,3 +9,4 @@ obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 rtc-core-y			:= class.o interface.o
 obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
+obj-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o

--
