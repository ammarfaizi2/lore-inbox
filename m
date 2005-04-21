Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVDUIVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVDUIVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVDUIHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:07:01 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:56503 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261452AbVDUHaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 14/22] W1: rename timeout to scan_interval
Date: Thu, 21 Apr 2005 02:21:16 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210221.16881.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: more master attributes changes:
    - rename timeout parameter/attribute to scan_interval to better
      reflect its purpose;
    - make scan_timeout be a per-device attribute and allow changing
      it from userspace via sysfs;
    - allow changing max_slave_count it from userspace as well.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 w1.h |    1 +
 2 files changed, 50 insertions(+), 11 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -42,11 +42,11 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol.");
 
-static int w1_timeout = 10;
+static int w1_scan_interval = 10;
 static int w1_max_slave_count = 10;
 static int w1_max_slave_ttl = 10;
 
-module_param_named(timeout, w1_timeout, int, 0);
+module_param_named(scan_interval, w1_scan_interval, int, 0);
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
@@ -357,7 +357,7 @@ static int w1_process(void *data)
 
 	while (!dev->need_exit) {
 		try_to_freeze(PF_FREEZE);
-		msleep_interruptible(w1_timeout * 1000);
+		msleep_interruptible(dev->scan_interval * 1000);
 
 		if (signal_pending(current))
 			flush_signals(current);
@@ -401,33 +401,71 @@ static ssize_t w1_master_attribute_show_
 	return sprintf(buf, "%s\n", master->name);
 }
 
-static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
+static ssize_t
+w1_master_attribute_show_scan_interval(struct device *dev, char *buf)
 {
-	ssize_t count;
-	count = sprintf(buf, "%d\n", w1_timeout);
-	return count;
+	struct w1_master *master = to_w1_master(dev);
+
+	return sprintf(buf, "%d\n", master->scan_interval);
+}
+
+static ssize_t
+w1_master_attribute_set_scan_interval(struct device *dev, const char *buf,
+				      size_t n)
+{
+	struct w1_master *master = to_w1_master(dev);
+	int interval;
+
+	interval = simple_strtoul(buf, NULL, 10);
+	if (!interval)
+		return -EINVAL;
+
+	master->scan_interval = interval;
+	return 0;
 }
 
-static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
+static ssize_t
+w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
 {
 	struct w1_master *master = to_w1_master(dev);
 
 	return sprintf(buf, "%d\n", master->max_slave_count);
 }
 
+static ssize_t
+w1_master_attribute_set_max_slave_count(struct device *dev, const char *buf,
+					size_t n)
+{
+	struct w1_master *master = to_w1_master(dev);
+	int max_count;
+
+	max_count = simple_strtoul(buf, NULL, 10);
+	if (!max_count)
+		return -EINVAL;
+
+	master->max_slave_count = max_count;
+	return 0;
+}
+
 #define W1_MASTER_ATTR_RO(_name, _mode)				\
 	struct device_attribute w1_master_attribute_##_name =	\
 		__ATTR(_name, _mode,				\
 		       w1_master_attribute_show_##_name, NULL)
 
+#define W1_MASTER_ATTR_RW(_name, _mode)				\
+	struct device_attribute w1_master_attribute_##_name =	\
+		__ATTR(_name, _mode,				\
+		       w1_master_attribute_show_##_name,	\
+		       w1_master_attribute_set_##_name)
+
 static W1_MASTER_ATTR_RO(name, S_IRUGO);
-static W1_MASTER_ATTR_RO(max_slave_count, S_IRUGO);
-static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
+static W1_MASTER_ATTR_RW(max_slave_count, S_IWUSR | S_IRUGO);
+static W1_MASTER_ATTR_RW(scan_interval, S_IWUSR | S_IRUGO);
 
 static struct attribute *w1_master_default_attrs[] = {
 	&w1_master_attribute_name.attr,
 	&w1_master_attribute_max_slave_count.attr,
-	&w1_master_attribute_timeout.attr,
+	&w1_master_attribute_scan_interval.attr,
 	NULL
 };
 
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -107,6 +107,7 @@ struct w1_master
 	struct list_head	slist;
 	int			max_slave_count;
 	int			slave_ttl;
+	int			scan_interval;
 	int			initialized;
 	u32			id;
 
