Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVAGWiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVAGWiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVAGWcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:32:22 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:25252 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261641AbVAGW13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:27:29 -0500
Subject: [RFC/PATCH] add support for sysdev class attributes
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1105136891.13391.20.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 Jan 2005 16:28:12 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Would you consider a patch such as the one below which adds support for
sysdev class attributes?  I would like to have this for doing cpu add
and remove on ppc64 (for "probing" and removing cpus on partitioned
machines).  I think the memory hotplug people probably will want it,
too, eventually.


Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN drivers/base/sys.c~sysdev_class-attr-support drivers/base/sys.c
--- linux-2.6.10-bk10/drivers/base/sys.c~sysdev_class-attr-support	2005-01-07 16:17:11.000000000 -0600
+++ linux-2.6.10-bk10-nathanl/drivers/base/sys.c	2005-01-07 16:17:11.000000000 -0600
@@ -76,6 +76,41 @@ void sysdev_remove_file(struct sys_devic
 EXPORT_SYMBOL_GPL(sysdev_create_file);
 EXPORT_SYMBOL_GPL(sysdev_remove_file);
 
+#define to_sysdev_class(k) container_of(to_kset(k), struct sysdev_class, kset)
+#define to_sysdev_class_attr(a) container_of(a, struct sysdev_class_attribute, attr)
+
+static ssize_t
+sysdev_class_show(struct kobject * kobj, struct attribute * attr, char * buffer)
+{
+	struct sysdev_class * sysdev_class = to_sysdev_class(kobj);
+	struct sysdev_class_attribute * sysdev_class_attr = to_sysdev_class_attr(attr);
+
+	if (sysdev_class_attr->show)
+		return sysdev_class_attr->show(sysdev_class, buffer);
+	return 0;
+}
+
+static ssize_t
+sysdev_class_store(struct kobject * kobj, struct attribute * attr,
+	     const char * buffer, size_t count)
+{
+	struct sysdev_class * sysdev_class = to_sysdev_class(kobj);
+	struct sysdev_class_attribute * sysdev_class_attr = to_sysdev_class_attr(attr);
+
+	if (sysdev_class_attr->store)
+		return sysdev_class_attr->store(sysdev_class, buffer, count);
+	return 0;
+}
+
+static struct sysfs_ops sysdev_class_sysfs_ops = {
+	.show	= sysdev_class_show,
+	.store	= sysdev_class_store,
+};
+
+static struct kobj_type sysdev_class_ktype = {
+	.sysfs_ops	= &sysdev_class_sysfs_ops,
+};
+
 /*
  * declare system_subsys
  */
@@ -88,6 +123,12 @@ int sysdev_class_register(struct sysdev_
 	INIT_LIST_HEAD(&cls->drivers);
 	cls->kset.subsys = &system_subsys;
 	kset_set_kset_s(cls, system_subsys);
+
+	/* I'm not going to claim to understand this; see
+	 * fs/sysfs/file::check_perm for how sysfs_ops are selected
+	 */
+	cls->kset.kobj.ktype = &sysdev_class_ktype;
+
 	return kset_register(&cls->kset);
 }
 
@@ -98,6 +139,19 @@ void sysdev_class_unregister(struct sysd
 	kset_unregister(&cls->kset);
 }
 
+int sysdev_class_create_file(struct sysdev_class *s, struct sysdev_class_attribute *a)
+{
+	return sysfs_create_file(&s->kset.kobj, &a->attr);
+}
+
+
+void sysdev_class_remove_file(struct sysdev_class *s, struct sysdev_class_attribute *a)
+{
+	sysfs_remove_file(&s->kset.kobj, &a->attr);
+}
+
+EXPORT_SYMBOL_GPL(sysdev_class_create_file);
+EXPORT_SYMBOL_GPL(sysdev_class_remove_file);
 EXPORT_SYMBOL_GPL(sysdev_class_register);
 EXPORT_SYMBOL_GPL(sysdev_class_unregister);
 
diff -puN include/linux/sysdev.h~sysdev_class-attr-support include/linux/sysdev.h
--- linux-2.6.10-bk10/include/linux/sysdev.h~sysdev_class-attr-support	2005-01-07 16:17:11.000000000 -0600
+++ linux-2.6.10-bk10-nathanl/include/linux/sysdev.h	2005-01-07 16:18:02.000000000 -0600
@@ -40,6 +40,21 @@ struct sysdev_class {
 extern int sysdev_class_register(struct sysdev_class *);
 extern void sysdev_class_unregister(struct sysdev_class *);
 
+struct sysdev_class_attribute {
+	struct attribute	attr;
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
+extern int sysdev_class_create_file(struct sysdev_class *, struct sysdev_class_attribute *);
+extern void sysdev_class_remove_file(struct sysdev_class *, struct sysdev_class_attribute *);
 
 /**
  * Auxillary system device drivers.

_


