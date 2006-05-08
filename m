Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWEHFuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWEHFuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEHFuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:50:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:22651 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932329AbWEHFr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:47:26 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948567:sNHT730216935"
Subject: [PATCH 9/10] Allow sysdev_calss have attributes
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Greg <greg@kroah.com>, Patrick Mochel <mochel@linux.intel.com>,
       Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:57 +0800
Message-Id: <1147067157.2760.89.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


allow sysdev_class adding attribute. Next patch will use the new API to 
add an attribute under /sys/device/system/cpu/.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc3-root/drivers/base/sys.c     |   53 ++++++++++++++++++++++++++-
 linux-2.6.17-rc3-root/include/linux/sysdev.h |   18 ++++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff -puN drivers/base/sys.c~sysdev-class-attribute drivers/base/sys.c
--- linux-2.6.17-rc3/drivers/base/sys.c~sysdev-class-attribute	2006-05-07 07:46:51.000000000 +0800
+++ linux-2.6.17-rc3-root/drivers/base/sys.c	2006-05-07 07:46:51.000000000 +0800
@@ -80,10 +80,61 @@ void sysdev_remove_file(struct sys_devic
 EXPORT_SYMBOL_GPL(sysdev_create_file);
 EXPORT_SYMBOL_GPL(sysdev_remove_file);
 
+#define to_sysdev_class(k) container_of(k, struct sysdev_class, kset.kobj)
+#define to_sysdev_class_attr(a) container_of(a, \
+	struct sysdev_class_attribute, attr)
+
+static ssize_t
+sysdev_class_show(struct kobject * kobj, struct attribute * attr, char * buffer)
+{
+	struct sysdev_class * class = to_sysdev_class(kobj);
+	struct sysdev_class_attribute *class_attr = to_sysdev_class_attr(attr);
+
+	if (class_attr->show)
+		return class_attr->show(class, buffer);
+	return -EIO;
+}
+
+static ssize_t
+sysdev_class_store(struct kobject * kobj, struct attribute * attr,
+	     const char * buffer, size_t count)
+{
+	struct sysdev_class * class = to_sysdev_class(kobj);
+	struct sysdev_class_attribute * class_attr = to_sysdev_class_attr(attr);
+
+	if (class_attr->store)
+		return class_attr->store(class, buffer, count);
+	return -EIO;
+}
+
+static struct sysfs_ops sysfs_class_ops = {
+	.show	= sysdev_class_show,
+	.store	= sysdev_class_store,
+};
+
+static struct kobj_type ktype_sysdev_class = {
+	.sysfs_ops	= &sysfs_class_ops,
+};
+
+int sysdev_class_create_file(struct sysdev_class * c,
+	struct sysdev_class_attribute * a)
+{
+	return sysfs_create_file(&c->kset.kobj, &a->attr);
+}
+
+void sysdev_class_remove_file(struct sysdev_class * c,
+	struct sysdev_class_attribute * a)
+{
+	sysfs_remove_file(&c->kset.kobj, &a->attr);
+}
+
+EXPORT_SYMBOL_GPL(sysdev_class_create_file);
+EXPORT_SYMBOL_GPL(sysdev_class_remove_file);
+
 /*
  * declare system_subsys
  */
-static decl_subsys(system, &ktype_sysdev, NULL);
+static decl_subsys(system, &ktype_sysdev_class, NULL);
 
 int sysdev_class_register(struct sysdev_class * cls)
 {
diff -puN include/linux/sysdev.h~sysdev-class-attribute include/linux/sysdev.h
--- linux-2.6.17-rc3/include/linux/sysdev.h~sysdev-class-attribute	2006-05-07 07:46:51.000000000 +0800
+++ linux-2.6.17-rc3-root/include/linux/sysdev.h	2006-05-07 07:46:51.000000000 +0800
@@ -37,11 +37,27 @@ struct sysdev_class {
 	struct kset		kset;
 };
 
+struct sysdev_class_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct sysdev_class *, char *);
+	ssize_t (*store)(struct sysdev_class *, const char *, size_t);
+};
+
+#define SYSDEV_CLASS_ATTR(_name,_mode,_show,_store) 		\
+struct sysdev_class_attribute attr_##_name = { 			\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,					\
+	.store	= _store,					\
+};
+
 
 extern int sysdev_class_register(struct sysdev_class *);
 extern void sysdev_class_unregister(struct sysdev_class *);
 
-
+extern int sysdev_class_create_file(struct sysdev_class *,
+	struct sysdev_class_attribute *);
+extern void sysdev_class_remove_file(struct sysdev_class *,
+	struct sysdev_class_attribute *);
 /**
  * Auxillary system device drivers.
  */
_
