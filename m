Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTISXNb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTISXNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:13:31 -0400
Received: from vena.lwn.net ([206.168.112.25]:42445 "HELO lwn.net")
	by vger.kernel.org with SMTP id S261845AbTISXKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:10:49 -0400
Message-ID: <20030919231046.4626.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] RFC: Attributes in /sys/cdev
cc: viro@parcelfarce.linux.theplanet.co.uk
From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 19 Sep 2003 17:10:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume that the (empty, currently) entries in /sys/cdev are there for
some purpose...  for purposes of my own, I've been thinking that it would
be nice to be able to find which device numbers got assigned when using the
new char dev registration functions.  Thus, the following patch, which adds
default "dev" and "count" attributes to /sys/cdev entries.

I have no idea whether this follows the original plan for /sys/cdev.
There *is* a plan for it, no...?

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

diff -urN -X dontdiff test5-vanilla/fs/char_dev.c test5/fs/char_dev.c
--- test5-vanilla/fs/char_dev.c	Mon Sep  8 13:50:01 2003
+++ test5/fs/char_dev.c	Sat Sep 20 06:46:24 2003
@@ -342,7 +342,13 @@
 
 int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 {
-	int err = kobject_add(&p->kobj);
+	int err;
+
+	/* Remember for sysfs; maybe caller should set these? */
+	p->firstdev = dev;
+	p->count = count;
+	
+	err = kobject_add(&p->kobj);
 	if (err)
 		return err;
 	err = kobj_map(cdev_map, dev, count, NULL, exact_match, exact_lock, p);
@@ -383,6 +389,61 @@
 	}
 }
 
+/*
+ * Simple /sys/cdev attribute stuff, added by corbet@lwn.net.  This is
+ * heavily patterned after the /sys/block code.
+ */
+struct cdev_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct cdev *, char *);
+};
+
+static ssize_t cdev_dev_read(struct cdev *cd, char *page)
+{
+	return sprintf(page, "%d:%d\n", MAJOR(cd->firstdev),
+			MINOR(cd->firstdev));
+}
+
+static ssize_t cdev_count_read(struct cdev *cd, char *page)
+{
+	return sprintf(page, "%d\n", cd->count);
+}
+
+static struct cdev_attribute cdev_attr_dev = {
+	.attr = { .name = "dev", .mode = S_IRUGO },
+	.show = cdev_dev_read
+};
+
+static struct cdev_attribute cdev_attr_count = {
+	.attr = { .name = "count", .mode = S_IRUGO },
+	.show = cdev_count_read
+};
+
+
+static struct attribute *default_cdev_attrs[] = {
+	&cdev_attr_dev.attr,
+	&cdev_attr_count.attr,
+	NULL
+};
+
+/*
+ * General show function.
+ */
+static ssize_t cdev_attr_show(struct kobject *kobj, struct attribute *attr,
+		char *page)
+{
+	struct cdev *cd = container_of(kobj, struct cdev, kobj);
+	struct cdev_attribute *cattr =
+		container_of(attr, struct cdev_attribute, attr);
+	if (cattr->show)
+		return cattr->show(cd, page);
+	return 0;
+}
+
+static struct sysfs_ops cdev_sysfs_ops = {
+	.show = cdev_attr_show
+};
+	
 static decl_subsys(cdev, NULL, NULL);
 
 static void cdev_default_release(struct kobject *kobj)
@@ -400,10 +461,14 @@
 
 static struct kobj_type ktype_cdev_default = {
 	.release	= cdev_default_release,
+	.sysfs_ops	= &cdev_sysfs_ops,
+	.default_attrs	= default_cdev_attrs,
 };
 
 static struct kobj_type ktype_cdev_dynamic = {
 	.release	= cdev_dynamic_release,
+	.sysfs_ops	= &cdev_sysfs_ops,
+	.default_attrs	= default_cdev_attrs,
 };
 
 static struct kset kset_dynamic = {
diff -urN -X dontdiff test5-vanilla/include/linux/cdev.h test5/include/linux/cdev.h
--- test5-vanilla/include/linux/cdev.h	Mon Sep  8 13:50:09 2003
+++ test5/include/linux/cdev.h	Sat Sep 20 06:12:52 2003
@@ -3,6 +3,8 @@
 #ifdef __KERNEL__
 
 struct cdev {
+	dev_t firstdev;
+	int count;
 	struct kobject kobj;
 	struct module *owner;
 	struct file_operations *ops;
