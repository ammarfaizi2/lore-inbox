Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVDUHlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVDUHlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVDUHk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:40:26 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:42423 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261440AbVDUHaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:11 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 4/22] W1: use attribute group for slave's attributes
Date: Thu, 21 Apr 2005 02:10:11 -0500
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
Message-Id: <200504210210.12524.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: add 2 default attributes "family" and "serial" to slave
    devices, every 1-Wire slave has them. Use attribute_group
    to handle. The rest of slave attributes are left as is -
    will be dealt with later.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++---------------------
 w1.h |    1 
 2 files changed, 81 insertions(+), 35 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -81,40 +81,6 @@ static void w1_master_release(struct dev
 	complete(&md->dev_released);
 }
 
-static void w1_slave_release(struct device *dev)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-
-	complete(&sl->dev_released);
-}
-
-static ssize_t w1_default_read_name(struct device *dev, char *buf)
-{
-	return sprintf(buf, "No family registered.\n");
-}
-
-static ssize_t w1_default_read_bin(struct kobject *kobj, char *buf, loff_t off,
-		     size_t count)
-{
-	return sprintf(buf, "No family registered.\n");
-}
-
-static struct device_attribute w1_slave_attribute =
-	__ATTR(name, S_IRUGO, w1_default_read_name, NULL);
-
-static struct device_attribute w1_slave_attribute_val =
-	__ATTR(value, S_IRUGO, w1_default_read_name, NULL);
-
-static struct bin_attribute w1_slave_bin_attribute = {
-	.attr = {
-		.name = "w1_slave",
-		.mode = S_IRUGO,
-		.owner = THIS_MODULE,
-	},
-	.size = W1_SLAVE_DATA_SIZE,
-	.read = &w1_default_read_bin,
-};
-
 
 static struct bus_type w1_bus_type = {
 	.name = "w1",
@@ -279,6 +245,72 @@ void w1_destroy_master_attributes(struct
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 }
 
+static ssize_t w1_slave_attribute_show_family(struct device *dev, char *buf)
+{
+	struct w1_slave *slave = to_w1_slave(dev);
+
+	return sprintf(buf, "%02X\n", slave->reg_num.family);
+}
+
+static ssize_t w1_slave_attribute_show_serial(struct device *dev, char *buf)
+{
+	struct w1_slave *slave = to_w1_slave(dev);
+
+	return sprintf(buf, "%llX\n", (unsigned long long)slave->reg_num.id);
+}
+
+#define W1_SLAVE_ATTR_RO(_name, _mode)					\
+	struct device_attribute w1_slave_attribute_##_name =		\
+		__ATTR(_name, _mode,					\
+		       w1_slave_attribute_show_##_name, NULL)
+
+static W1_SLAVE_ATTR_RO(family, S_IRUGO);
+static W1_SLAVE_ATTR_RO(serial, S_IRUGO);
+
+static struct attribute *w1_slave_default_attrs[] = {
+	&w1_slave_attribute_family.attr,
+	&w1_slave_attribute_serial.attr,
+	NULL
+};
+
+static struct attribute_group w1_slave_defattr_group = {
+	.attrs = w1_slave_default_attrs,
+};
+
+static ssize_t w1_default_read_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "No family registered.\n");
+}
+
+static ssize_t w1_default_read_bin(struct kobject *kobj, char *buf, loff_t off,
+		     size_t count)
+{
+	return sprintf(buf, "No family registered.\n");
+}
+
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
+static void w1_slave_release(struct device *dev)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+
+	complete(&sl->dev_released);
+}
+
 static int __w1_attach_slave_device(struct w1_slave *sl)
 {
 	int err;
@@ -347,6 +379,18 @@ static int __w1_attach_slave_device(stru
 		return err;
 	}
 
+	err = sysfs_create_group(&sl->dev.kobj, &w1_slave_defattr_group);
+	if (err < 0) {
+		dev_err(&sl->dev,
+			 "sysfs group creation for [%s] failed. err=%d\n",
+			 sl->dev.bus_id, err);
+		sysfs_remove_bin_file(&sl->dev.kobj, &sl->attr_bin);
+		device_remove_file(&sl->dev, &sl->attr_name);
+		device_remove_file(&sl->dev, &sl->attr_val);
+		device_unregister(&sl->dev);
+		return err;
+	}
+
 	list_add_tail(&sl->w1_slave_entry, &sl->master->slist);
 
 	return 0;
@@ -426,7 +470,8 @@ static void w1_slave_detach(struct w1_sl
 			flush_signals(current);
 	}
 
-	sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
+	sysfs_remove_group(&sl->dev.kobj, &w1_slave_defattr_group);
+	sysfs_remove_bin_file(&sl->dev.kobj, &sl->attr_bin);
 	device_remove_file(&sl->dev, &sl->attr_name);
 	device_remove_file(&sl->dev, &sl->attr_val);
 	device_unregister(&sl->dev);
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -81,6 +81,7 @@ struct w1_slave
 	struct bin_attribute	attr_bin;
 	struct device_attribute	attr_name, attr_val;
 };
+#define to_w1_slave(dev)	container_of((dev), struct w1_slave, dev)
 
 typedef void (* w1_slave_found_callback)(unsigned long, u64);
 
