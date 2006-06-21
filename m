Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWFUTzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWFUTzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWFUTuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:17306 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030250AbWFUTto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:44 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/22] [PATCH] Driver Core: Allow sysdev_class have attributes
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:54 -0700
Message-Id: <11509191982588-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509191951525-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaohua Li <shaohua.li@intel.com>

allow sysdev_class adding attribute. Next patch will use the new API to
add an attribute under /sys/device/system/cpu/.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/sys.c     |   51 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/sysdev.h |   18 ++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/base/sys.c b/drivers/base/sys.c
index 6fc23ab..6858178 100644
--- a/drivers/base/sys.c
+++ b/drivers/base/sys.c
@@ -80,10 +80,59 @@ void sysdev_remove_file(struct sys_devic
 EXPORT_SYMBOL_GPL(sysdev_create_file);
 EXPORT_SYMBOL_GPL(sysdev_remove_file);
 
+#define to_sysdev_class(k) container_of(k, struct sysdev_class, kset.kobj)
+#define to_sysdev_class_attr(a) container_of(a, \
+	struct sysdev_class_attribute, attr)
+
+static ssize_t sysdev_class_show(struct kobject *kobj, struct attribute *attr,
+				 char *buffer)
+{
+	struct sysdev_class * class = to_sysdev_class(kobj);
+	struct sysdev_class_attribute *class_attr = to_sysdev_class_attr(attr);
+
+	if (class_attr->show)
+		return class_attr->show(class, buffer);
+	return -EIO;
+}
+
+static ssize_t sysdev_class_store(struct kobject *kobj, struct attribute *attr,
+				  const char *buffer, size_t count)
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
+int sysdev_class_create_file(struct sysdev_class *c,
+			     struct sysdev_class_attribute *a)
+{
+	return sysfs_create_file(&c->kset.kobj, &a->attr);
+}
+EXPORT_SYMBOL_GPL(sysdev_class_create_file);
+
+void sysdev_class_remove_file(struct sysdev_class *c,
+			      struct sysdev_class_attribute *a)
+{
+	sysfs_remove_file(&c->kset.kobj, &a->attr);
+}
+EXPORT_SYMBOL_GPL(sysdev_class_remove_file);
+
 /*
  * declare system_subsys
  */
-static decl_subsys(system, &ktype_sysdev, NULL);
+static decl_subsys(system, &ktype_sysdev_class, NULL);
 
 int sysdev_class_register(struct sysdev_class * cls)
 {
diff --git a/include/linux/sysdev.h b/include/linux/sysdev.h
index 2a4b432..166a2e5 100644
--- a/include/linux/sysdev.h
+++ b/include/linux/sysdev.h
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
-- 
1.4.0

