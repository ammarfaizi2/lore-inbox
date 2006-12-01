Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162267AbWLAXXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162267AbWLAXXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162256AbWLAXXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:05 -0500
Received: from ns2.suse.de ([195.135.220.15]:22765 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162247AbWLAXWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:47 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/36] Driver core: convert vt code to use struct device
Date: Fri,  1 Dec 2006 15:21:40 -0800
Message-Id: <116501535622-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153522862-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/vt.c |   81 +++++++++++++++++++++++++---------------------------
 1 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 8e4413f..87587b4 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -112,7 +112,7 @@
 struct con_driver {
 	const struct consw *con;
 	const char *desc;
-	struct class_device *class_dev;
+	struct device *dev;
 	int node;
 	int first;
 	int last;
@@ -3023,10 +3023,10 @@ static inline int vt_unbind(struct con_d
 }
 #endif /* CONFIG_VT_HW_CONSOLE_BINDING */
 
-static ssize_t store_bind(struct class_device *class_device,
+static ssize_t store_bind(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
-	struct con_driver *con = class_get_devdata(class_device);
+	struct con_driver *con = dev_get_drvdata(dev);
 	int bind = simple_strtoul(buf, NULL, 0);
 
 	if (bind)
@@ -3037,17 +3037,19 @@ static ssize_t store_bind(struct class_d
 	return count;
 }
 
-static ssize_t show_bind(struct class_device *class_device, char *buf)
+static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
-	struct con_driver *con = class_get_devdata(class_device);
+	struct con_driver *con = dev_get_drvdata(dev);
 	int bind = con_is_bound(con->con);
 
 	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
 }
 
-static ssize_t show_name(struct class_device *class_device, char *buf)
+static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
-	struct con_driver *con = class_get_devdata(class_device);
+	struct con_driver *con = dev_get_drvdata(dev);
 
 	return snprintf(buf, PAGE_SIZE, "%s %s\n",
 			(con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
@@ -3055,43 +3057,40 @@ static ssize_t show_name(struct class_de
 
 }
 
-static struct class_device_attribute class_device_attrs[] = {
+static struct device_attribute device_attrs[] = {
 	__ATTR(bind, S_IRUGO|S_IWUSR, show_bind, store_bind),
 	__ATTR(name, S_IRUGO, show_name, NULL),
 };
 
-static int vtconsole_init_class_device(struct con_driver *con)
+static int vtconsole_init_device(struct con_driver *con)
 {
 	int i;
 	int error = 0;
 
 	con->flag |= CON_DRIVER_FLAG_ATTR;
-	class_set_devdata(con->class_dev, con);
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++) {
-		error = class_device_create_file(con->class_dev,
-					 &class_device_attrs[i]);
+	dev_set_drvdata(con->dev, con);
+	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
+		error = device_create_file(con->dev, &device_attrs[i]);
 		if (error)
 			break;
 	}
 
 	if (error) {
 		while (--i >= 0)
-			class_device_remove_file(con->class_dev,
-					 &class_device_attrs[i]);
+			device_remove_file(con->dev, &device_attrs[i]);
 		con->flag &= ~CON_DRIVER_FLAG_ATTR;
 	}
 
 	return error;
 }
 
-static void vtconsole_deinit_class_device(struct con_driver *con)
+static void vtconsole_deinit_device(struct con_driver *con)
 {
 	int i;
 
 	if (con->flag & CON_DRIVER_FLAG_ATTR) {
-		for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-			class_device_remove_file(con->class_dev,
-						 &class_device_attrs[i]);
+		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
+			device_remove_file(con->dev, &device_attrs[i]);
 		con->flag &= ~CON_DRIVER_FLAG_ATTR;
 	}
 }
@@ -3179,18 +3178,17 @@ int register_con_driver(const struct con
 	if (retval)
 		goto err;
 
-	con_driver->class_dev = class_device_create(vtconsole_class, NULL,
-						    MKDEV(0, con_driver->node),
-						    NULL, "vtcon%i",
-						    con_driver->node);
+	con_driver->dev = device_create(vtconsole_class, NULL,
+					MKDEV(0, con_driver->node),
+					"vtcon%i", con_driver->node);
 
-	if (IS_ERR(con_driver->class_dev)) {
-		printk(KERN_WARNING "Unable to create class_device for %s; "
+	if (IS_ERR(con_driver->dev)) {
+		printk(KERN_WARNING "Unable to create device for %s; "
 		       "errno = %ld\n", con_driver->desc,
-		       PTR_ERR(con_driver->class_dev));
-		con_driver->class_dev = NULL;
+		       PTR_ERR(con_driver->dev));
+		con_driver->dev = NULL;
 	} else {
-		vtconsole_init_class_device(con_driver);
+		vtconsole_init_device(con_driver);
 	}
 
 err:
@@ -3226,12 +3224,12 @@ int unregister_con_driver(const struct c
 
 		if (con_driver->con == csw &&
 		    con_driver->flag & CON_DRIVER_FLAG_MODULE) {
-			vtconsole_deinit_class_device(con_driver);
-			class_device_destroy(vtconsole_class,
-					     MKDEV(0, con_driver->node));
+			vtconsole_deinit_device(con_driver);
+			device_destroy(vtconsole_class,
+				       MKDEV(0, con_driver->node));
 			con_driver->con = NULL;
 			con_driver->desc = NULL;
-			con_driver->class_dev = NULL;
+			con_driver->dev = NULL;
 			con_driver->node = 0;
 			con_driver->flag = 0;
 			con_driver->first = 0;
@@ -3289,19 +3287,18 @@ static int __init vtconsole_class_init(v
 	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
 		struct con_driver *con = &registered_con_driver[i];
 
-		if (con->con && !con->class_dev) {
-			con->class_dev =
-				class_device_create(vtconsole_class, NULL,
-						    MKDEV(0, con->node), NULL,
-						    "vtcon%i", con->node);
+		if (con->con && !con->dev) {
+			con->dev = device_create(vtconsole_class, NULL,
+						 MKDEV(0, con->node),
+						 "vtcon%i", con->node);
 
-			if (IS_ERR(con->class_dev)) {
+			if (IS_ERR(con->dev)) {
 				printk(KERN_WARNING "Unable to create "
-				       "class_device for %s; errno = %ld\n",
-				       con->desc, PTR_ERR(con->class_dev));
-				con->class_dev = NULL;
+				       "device for %s; errno = %ld\n",
+				       con->desc, PTR_ERR(con->dev));
+				con->dev = NULL;
 			} else {
-				vtconsole_init_class_device(con);
+				vtconsole_init_device(con);
 			}
 		}
 	}
-- 
1.4.4.1

