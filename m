Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVDUHlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVDUHlU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVDUHj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:39:28 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:40887 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261439AbVDUHaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:10 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 3/22] W1: use attribute group for master's attributes
Date: Thu, 21 Apr 2005 02:09:34 -0500
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
Message-Id: <200504210209.34772.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: use attribute_group to create master device attributes to
    guarantee proper cleanup in case of failure. Also, hide
    most of attribute define ugliness in macros.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c |  157 +++++++++++++++++++++----------------------------------------------
 1 files changed, 51 insertions(+), 106 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -99,6 +99,23 @@ static ssize_t w1_default_read_bin(struc
 	return sprintf(buf, "No family registered.\n");
 }
 
+static struct device_attribute w1_slave_attribute =
+	__ATTR(name, S_IRUGO, w1_default_read_name, NULL);
+
+static struct device_attribute w1_slave_attribute_val =
+	__ATTR(value, S_IRUGO, w1_default_read_name, NULL);
+
+static struct bin_attribute w1_slave_bin_attribute = {
+	.attr = {
+		.name = "w1_slave",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = W1_SLAVE_DATA_SIZE,
+	.read = &w1_default_read_bin,
+};
+
+
 static struct bus_type w1_bus_type = {
 	.name = "w1",
 	.match = w1_master_match,
@@ -119,24 +136,6 @@ struct device w1_device = {
 	.release = &w1_master_release
 };
 
-static struct device_attribute w1_slave_attribute = {
-	.attr = {
-			.name = "name",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_default_read_name,
-};
-
-static struct device_attribute w1_slave_attribute_val = {
-	.attr = {
-			.name = "value",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_default_read_name,
-};
-
 static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of (dev, struct w1_master, dev);
@@ -242,73 +241,44 @@ static ssize_t w1_master_attribute_show_
 	return PAGE_SIZE - c;
 }
 
-static struct device_attribute w1_master_attribute_slaves = {
-	.attr = {
-			.name = "w1_master_slaves",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE,
-	},
-	.show = &w1_master_attribute_show_slaves,
-};
-static struct device_attribute w1_master_attribute_slave_count = {
-	.attr = {
-			.name = "w1_master_slave_count",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_slave_count,
-};
-static struct device_attribute w1_master_attribute_attempts = {
-	.attr = {
-			.name = "w1_master_attempts",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_attempts,
-};
-static struct device_attribute w1_master_attribute_max_slave_count = {
-	.attr = {
-			.name = "w1_master_max_slave_count",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_max_slave_count,
-};
-static struct device_attribute w1_master_attribute_timeout = {
-	.attr = {
-			.name = "w1_master_timeout",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_timeout,
-};
-static struct device_attribute w1_master_attribute_pointer = {
-	.attr = {
-			.name = "w1_master_pointer",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_pointer,
-};
-static struct device_attribute w1_master_attribute_name = {
-	.attr = {
-			.name = "w1_master_name",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE
-	},
-	.show = &w1_master_attribute_show_name,
+#define W1_MASTER_ATTR_RO(_name, _mode)				\
+	struct device_attribute w1_master_attribute_##_name =	\
+		__ATTR(w1_master_##_name, _mode,		\
+		       w1_master_attribute_show_##_name, NULL)
+
+static W1_MASTER_ATTR_RO(name, S_IRUGO);
+static W1_MASTER_ATTR_RO(slaves, S_IRUGO);
+static W1_MASTER_ATTR_RO(slave_count, S_IRUGO);
+static W1_MASTER_ATTR_RO(max_slave_count, S_IRUGO);
+static W1_MASTER_ATTR_RO(attempts, S_IRUGO);
+static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
+static W1_MASTER_ATTR_RO(pointer, S_IRUGO);
+
+static struct attribute *w1_master_default_attrs[] = {
+	&w1_master_attribute_name.attr,
+	&w1_master_attribute_slaves.attr,
+	&w1_master_attribute_slave_count.attr,
+	&w1_master_attribute_max_slave_count.attr,
+	&w1_master_attribute_attempts.attr,
+	&w1_master_attribute_timeout.attr,
+	&w1_master_attribute_pointer.attr,
+	NULL
 };
 
-static struct bin_attribute w1_slave_bin_attribute = {
-	.attr = {
-			.name = "w1_slave",
-			.mode = S_IRUGO,
-			.owner = THIS_MODULE,
-	},
-	.size = W1_SLAVE_DATA_SIZE,
-	.read = &w1_default_read_bin,
+static struct attribute_group w1_master_defattr_group = {
+	.attrs = w1_master_default_attrs,
 };
 
+int w1_create_master_attributes(struct w1_master *master)
+{
+	return sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
+}
+
+void w1_destroy_master_attributes(struct w1_master *master)
+{
+	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
+}
+
 static int __w1_attach_slave_device(struct w1_slave *sl)
 {
 	int err;
@@ -617,31 +587,6 @@ void w1_search(struct w1_master *dev)
 	}
 }
 
-int w1_create_master_attributes(struct w1_master *dev)
-{
-	if (	device_create_file(&dev->dev, &w1_master_attribute_slaves) < 0 ||
-		device_create_file(&dev->dev, &w1_master_attribute_slave_count) < 0 ||
-		device_create_file(&dev->dev, &w1_master_attribute_attempts) < 0 ||
-		device_create_file(&dev->dev, &w1_master_attribute_max_slave_count) < 0 ||
-		device_create_file(&dev->dev, &w1_master_attribute_timeout) < 0||
-		device_create_file(&dev->dev, &w1_master_attribute_pointer) < 0||
-		device_create_file(&dev->dev, &w1_master_attribute_name) < 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-void w1_destroy_master_attributes(struct w1_master *dev)
-{
-	device_remove_file(&dev->dev, &w1_master_attribute_slaves);
-	device_remove_file(&dev->dev, &w1_master_attribute_slave_count);
-	device_remove_file(&dev->dev, &w1_master_attribute_attempts);
-	device_remove_file(&dev->dev, &w1_master_attribute_max_slave_count);
-	device_remove_file(&dev->dev, &w1_master_attribute_timeout);
-	device_remove_file(&dev->dev, &w1_master_attribute_pointer);
-	device_remove_file(&dev->dev, &w1_master_attribute_name);
-}
-
 
 int w1_control(void *data)
 {
