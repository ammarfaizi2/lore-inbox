Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVDUIFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVDUIFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVDUIFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:05:24 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:54711 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261450AbVDUHaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:18 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 13/22] W1: cleanup master attributes handling
Date: Thu, 21 Apr 2005 02:20:12 -0500
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
Message-Id: <200504210220.12670.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: clean-up master attribute implementation:
    - drop unnecessary "w1_master" prefix from attribute names;
    - do not acquire master->mutex when accessing attributes;
    - move attribute code "closer" to the rest of master code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c |  111 +++++++++++++++++++++++++------------------------------------------
 w1.h |    1 
 2 files changed, 44 insertions(+), 68 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -95,72 +95,6 @@ struct device w1_device = {
 	.release = &w1_master_release
 };
 
-static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
-{
-	struct w1_master *md = container_of (dev, struct w1_master, dev);
-	ssize_t count;
-
-	if (down_interruptible (&md->mutex))
-		return -EBUSY;
-
-	count = sprintf(buf, "%s\n", md->name);
-
-	up(&md->mutex);
-
-	return count;
-}
-
-static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
-{
-	ssize_t count;
-	count = sprintf(buf, "%d\n", w1_timeout);
-	return count;
-}
-
-static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
-{
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
-	ssize_t count;
-
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
-	count = sprintf(buf, "%d\n", md->max_slave_count);
-
-	up(&md->mutex);
-	return count;
-}
-
-#define W1_MASTER_ATTR_RO(_name, _mode)				\
-	struct device_attribute w1_master_attribute_##_name =	\
-		__ATTR(w1_master_##_name, _mode,		\
-		       w1_master_attribute_show_##_name, NULL)
-
-static W1_MASTER_ATTR_RO(name, S_IRUGO);
-static W1_MASTER_ATTR_RO(max_slave_count, S_IRUGO);
-static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
-
-static struct attribute *w1_master_default_attrs[] = {
-	&w1_master_attribute_name.attr,
-	&w1_master_attribute_max_slave_count.attr,
-	&w1_master_attribute_timeout.attr,
-	NULL
-};
-
-static struct attribute_group w1_master_defattr_group = {
-	.attrs = w1_master_default_attrs,
-};
-
-int w1_create_master_attributes(struct w1_master *master)
-{
-	return sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
-}
-
-void w1_destroy_master_attributes(struct w1_master *master)
-{
-	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
-}
-
 static ssize_t w1_slave_attribute_show_family(struct device *dev, char *buf)
 {
 	struct w1_slave *slave = to_w1_slave(dev);
@@ -460,6 +394,47 @@ static int w1_process(void *data)
 	return 0;
 }
 
+static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
+{
+	struct w1_master *master = to_w1_master(dev);
+
+	return sprintf(buf, "%s\n", master->name);
+}
+
+static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
+{
+	ssize_t count;
+	count = sprintf(buf, "%d\n", w1_timeout);
+	return count;
+}
+
+static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
+{
+	struct w1_master *master = to_w1_master(dev);
+
+	return sprintf(buf, "%d\n", master->max_slave_count);
+}
+
+#define W1_MASTER_ATTR_RO(_name, _mode)				\
+	struct device_attribute w1_master_attribute_##_name =	\
+		__ATTR(_name, _mode,				\
+		       w1_master_attribute_show_##_name, NULL)
+
+static W1_MASTER_ATTR_RO(name, S_IRUGO);
+static W1_MASTER_ATTR_RO(max_slave_count, S_IRUGO);
+static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
+
+static struct attribute *w1_master_default_attrs[] = {
+	&w1_master_attribute_name.attr,
+	&w1_master_attribute_max_slave_count.attr,
+	&w1_master_attribute_timeout.attr,
+	NULL
+};
+
+static struct attribute_group w1_master_defattr_group = {
+	.attrs = w1_master_default_attrs,
+};
+
 struct w1_master *w1_allocate_master_device(void)
 {
 	struct w1_master *dev;
@@ -535,7 +510,7 @@ int w1_add_master_device(struct w1_maste
 		goto err_out_free_dev;
 	}
 
-	error = w1_create_master_attributes(dev);
+	error = sysfs_create_group(&dev->dev.kobj, &w1_master_defattr_group);
 	if (error)
 		goto err_out_kill_thread;
 
@@ -566,7 +541,7 @@ void w1_remove_master_device(struct w1_m
 		kfree(slave);
 	}
 
-	w1_destroy_master_attributes(dev);
+	sysfs_remove_group(&dev->dev.kobj, &w1_master_defattr_group);
 
 	while (atomic_read(&dev->refcnt)) {
 		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -127,6 +127,7 @@ struct w1_master
 
 	u32			seq, groups;
 };
+#define to_w1_master(dev)	container_of((dev), struct w1_master, dev)
 
 struct w1_master *w1_allocate_master_device(void);
 int w1_add_master_device(struct w1_master *);
