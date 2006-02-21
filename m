Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWBUOkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWBUOkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWBUOkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:40:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:19112 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932459AbWBUOkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:40:07 -0500
Message-ID: <43FB2642.7020109@us.ibm.com>
Date: Tue, 21 Feb 2006 09:40:02 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor attributes
 to sysfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User mdday@dual.silverwood.home
# Node ID 10c66e0408d1b22db15b8943223f1b6d7713422d
# Parent  f5f32dc60121c32fab158a814c914aae3b77ba06
Module that exports Xen Hypervisor attributes to /sys/hypervisor. 

signed-off-by: Mike D. Day <ncmike@us.ibm.com>

diff -r f5f32dc60121 -r 10c66e0408d1 linux-2.6-xen-sparse/drivers/xen/core/Makefile
--- a/linux-2.6-xen-sparse/drivers/xen/core/Makefile	Tue Feb 21 08:12:11 2006 -0500
+++ b/linux-2.6-xen-sparse/drivers/xen/core/Makefile	Tue Feb 21 08:13:00 2006 -0500
@@ -7,3 +7,4 @@ obj-$(CONFIG_PROC_FS) += xen_proc.o
obj-$(CONFIG_PROC_FS) += xen_proc.o
obj-$(CONFIG_NET)     += skbuff.o
obj-$(CONFIG_SMP)     += smpboot.o
+obj-$(CONFIG_XEN_SYSFS) += xen_sysfs.o
diff -r f5f32dc60121 -r 10c66e0408d1 linux-2.6-xen-sparse/drivers/xen/core/xen_sysfs.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/linux-2.6-xen-sparse/drivers/xen/core/xen_sysfs.c	Tue Feb 21 08:13:00 2006 -0500
@@ -0,0 +1,411 @@
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
+#include <xen/xen_sysfs.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mike D. Day <ncmike@us.ibm.com>");
+
+decl_subsys(hypervisor, NULL, NULL);
+
+struct kset xen_kset = {
+	.subsys = &hypervisor_subsys,
+	.kobj = {
+		.name = "xen",
+	},
+};
+
+static ssize_t xen_show(struct kobject * kobj,
+			struct attribute * attr,
+			char * page)
+{
+	struct xen_attr * xattr;
+	xattr = container_of(attr, struct xen_attr, attr);
+	if (xattr->show)
+		return xattr->show(kobj, attr, page);
+	return 0;
+}
+
+static void kobj_release(struct kobject * kobj)
+{
+	kfree(kobj);
+}
+
+static struct sysfs_ops xen_ops = {
+
+	.show = xen_show,
+};
+
+/* xen version attributes */
+
+static ssize_t major_show(struct kobject * kobj,
+			  struct attribute * attr,
+			  char * page)
+{
+	int version = HYPERVISOR_xen_version(XENVER_version, NULL);
+	if (version)
+		return sprintf(page, "%d\n", version >> 16);
+	return 0;
+}
+
+static struct xen_attr major = __ATTR_RO(major);
+
+static ssize_t minor_show(struct kobject * kobj,
+			  struct attribute * attr,
+			  char * page)
+{
+	int version = HYPERVISOR_xen_version(XENVER_version, NULL);
+	if (version)
+		return sprintf(page, "%d\n", version & 0xff);
+	return 0;
+}
+
+static struct xen_attr minor = __ATTR_RO(minor);
+
+static ssize_t extra_show(struct kobject * kobj,
+			  struct attribute * attr,
+			  char * page)
+{
+	char extra_ver[XENVER_EXTRAVERSION_LEN];
+	int err = HYPERVISOR_xen_version(XENVER_extraversion, extra_ver);
+	if (0 == err)
+		return sprintf(page, "%s\n", extra_ver);
+	return 0;
+}
+
+static struct xen_attr extra = __ATTR_RO(extra);
+
+static struct attribute * version_attrs[] = {
+	&major.attr,
+	&minor.attr,
+	&extra.attr,
+	NULL
+};
+
+static struct attribute_group version_group = {
+	.name = "version",
+	.attrs = version_attrs,
+};
+	
+static struct kobj_type xen_version_type = {
+	.release = kobj_release,
+	.sysfs_ops = &xen_ops,
+	.default_attrs = version_attrs,
+};
+
+static struct kobject * v_kobj;
+
+int __init
+xen_version_init(void)
+{
+	int err = -ENOMEM;
+	v_kobj = kcalloc(sizeof(struct kobject), sizeof(char), GFP_KERNEL);
+	if (v_kobj) {
+		kobject_set_name(v_kobj, "version");
+		v_kobj->ktype = &xen_version_type;
+		kobject_init(v_kobj);
+		v_kobj->dentry = xen_kset.kobj.dentry;
+		err = sysfs_create_group(v_kobj, &version_group);
+	}
+	return err;
+}
+
+static void xen_version_destroy(void)
+{
+	sysfs_remove_group(v_kobj, &version_group);
+	kobject_put(v_kobj);
+	return;
+}
+
+
+
+/* xen compilation attributes */
+
+static ssize_t compiler_show(struct kobject * kobj,
+			     struct attribute * attr,
+			     char * page)
+{
+	int err = 0;
+	struct xen_compile_info * info =
+		kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
+	if (info ) {
+		if (0 == HYPERVISOR_xen_version(XENVER_compile_info, info))
+			err = sprintf(page, "%s\n", info->compiler);
+		kfree(info);
+	}
+	return err;
+}
+
+static struct xen_attr compiler = __ATTR_RO(compiler);
+
+static ssize_t by_show(struct kobject * kobj,
+		       struct attribute * attr,
+		       char * page)
+{
+	int err = 0;
+	struct xen_compile_info * info =
+		kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
+	if (info ) {
+		if (0 == HYPERVISOR_xen_version(XENVER_compile_info, info))
+			return sprintf(page, "%s\n", info->compile_by);
+		kfree(info);
+	}
+	return err;
+}
+
+static struct xen_attr compiled_by = __ATTR_RO(by);
+
+static ssize_t date_show(struct kobject * kobj,
+			 struct attribute * attr,
+			 char * page)
+{
+	int err = 0;
+	struct xen_compile_info * info =
+		kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
+	if (info ) {
+		if (0 == HYPERVISOR_xen_version(XENVER_compile_info, info))
+			return sprintf(page, "%s\n", info->compile_date);
+		kfree(info);
+	}
+	return err;
+}
+
+static struct xen_attr compiled_date = __ATTR_RO(date);
+
+static struct attribute * xen_compile_attrs[] = {
+	&compiler.attr,
+	&compiled_by.attr,
+	&compiled_date.attr,
+	NULL
+};
+
+static struct attribute_group xen_compilation_group = {
+	.name = "compilation",
+	.attrs = xen_compile_attrs,
+};
+	
+static struct kobj_type xen_compilation_type = {
+	.release = kobj_release,
+	.sysfs_ops = &xen_ops,
+	.default_attrs = xen_compile_attrs,
+};
+
+static struct kobject * c_kobj;
+
+
+int __init
+static xen_compilation_init(void)
+{
+	int err = -ENOMEM;
+	c_kobj = kcalloc(sizeof(struct kobject), sizeof(char), GFP_KERNEL);
+	if (c_kobj) {
+		kobject_set_name(c_kobj, "compilation");
+		c_kobj->ktype = &xen_compilation_type;
+		kobject_init(c_kobj);
+		c_kobj->dentry = xen_kset.kobj.dentry;
+		err = sysfs_create_group(c_kobj, &xen_compilation_group);
+	}
+	return err;
+}
+
+static void xen_compilation_destroy(void)
+{
+	sysfs_remove_group(c_kobj, &xen_compilation_group);
+	kobject_put(c_kobj);
+	return;
+}
+
+
+/* xen properties info */
+
+static ssize_t capabilities_show(struct kobject * kobj,
+				 struct attribute * attr,
+				 char * page)
+{
+	int err = 0;
+	char * caps = kmalloc(XENVER_CAPABILITIES_INFO_LEN, GFP_KERNEL);
+	if (caps) {
+		if (0 == HYPERVISOR_xen_version(XENVER_capabilities, caps))
+			err = sprintf(page, "%s\n", caps);
+		kfree(caps);
+	}
+	return err;
+}
+
+static struct xen_attr xen_capable = __ATTR_RO(capabilities);
+
+static ssize_t changeset_show(struct kobject * kobj,
+			      struct attribute * attr,
+			      char * page)
+{
+	int err = 0;
+	char * cset = kmalloc(XENVER_CSET_INFO_LEN, GFP_KERNEL);
+	if (cset) {
+		if (0 == HYPERVISOR_xen_version(XENVER_changeset, cset))
+			err = sprintf(page, "%s\n", cset);
+		kfree(cset);
+	}
+	return err;
+}
+
+static struct xen_attr xen_cset = __ATTR_RO(changeset);
+
+static ssize_t virt_start_show(struct kobject * kobj,
+			       struct attribute * attr,
+			       char * page)
+{
+	int err = 0;
+	struct xen_platform_parameters * parms =
+		kmalloc(sizeof(struct xen_platform_parameters), GFP_KERNEL);
+	if (parms) {
+		if (0 == HYPERVISOR_xen_version(XENVER_platform_parameters,
+						parms))
+			err = sprintf(page, "%lx\n", parms->virt_start);
+		kfree(parms);
+	}
+	return err;
+}
+
+static struct xen_attr xen_virt_start = __ATTR_RO(virt_start);
+
+
+static ssize_t writable_pt_show(struct kobject * kobj,
+				struct attribute * attr,
+				char * page)
+{
+	int err = 0;
+	struct xen_feature_info * info =
+		kmalloc(sizeof(struct xen_feature_info), GFP_KERNEL);
+	if (info) {
+		info->submap_idx = XENFEAT_writable_page_tables;
+		if (0 == HYPERVISOR_xen_version(XENVER_get_features, info))
+			err = sprintf(page, "%d\n", info->submap);
+		kfree(info);
+	}
+	return err;
+}
+
+static struct xen_attr xen_wpt = __ATTR_RO(writable_pt);
+
+static ssize_t writable_dt_show(struct kobject * kobj,
+				struct attribute * attr,
+				char * page)
+{
+	int err = 0;
+	struct xen_feature_info * info =
+		kmalloc(sizeof(struct xen_feature_info), GFP_KERNEL);
+	if (info) {
+		info->submap_idx = XENFEAT_writable_descriptor_tables;
+		if (0 == HYPERVISOR_xen_version(XENVER_get_features, info))
+			err = sprintf(page, "%d\n", info->submap);
+		kfree(info);
+	}
+	return err;
+}
+
+static struct xen_attr xen_wdt = __ATTR_RO(writable_dt);
+
+static ssize_t translated_pm_show(struct kobject * kobj,
+				  struct attribute * attr,
+				  char * page)
+{
+	int err = 0;
+	struct xen_feature_info * info =
+		kmalloc(sizeof(struct xen_feature_info), GFP_KERNEL);
+	if (info) {
+		info->submap_idx = XENFEAT_auto_translated_physmap;
+		if (0 == HYPERVISOR_xen_version(XENVER_get_features, info))
+			err = sprintf(page, "%d\n", info->submap);
+		kfree(info);
+	}
+	return err;
+}
+
+static struct xen_attr xen_atp = __ATTR_RO(translated_pm);
+
+static struct attribute * xen_properties_attrs[] = {
+	&xen_capable.attr,
+	&xen_cset.attr,
+	&xen_virt_start.attr,
+	&xen_wpt.attr,
+	&xen_wdt.attr,
+	&xen_atp.attr,
+	NULL
+};
+
+static struct attribute_group xen_properties_group = {
+	.name = "properties",
+	.attrs = xen_properties_attrs,
+};
+
+static struct kobj_type xen_properties_type = {
+	.release = kobj_release,
+	.sysfs_ops = &xen_ops,
+	.default_attrs = xen_properties_attrs,
+};
+
+static struct kobject * p_kobj;
+
+static int __init
+xen_properties_init(void)
+{
+	int err = -ENOMEM;
+	p_kobj = kcalloc(sizeof(struct kobject), sizeof(char), GFP_KERNEL);
+	if (p_kobj) {
+		kobject_set_name(p_kobj, "properties");
+		p_kobj->ktype = &xen_properties_type;
+		kobject_init(p_kobj);
+		p_kobj->dentry = xen_kset.kobj.dentry;
+		err = sysfs_create_group(p_kobj, &xen_properties_group);
+	}
+	return err;
+}
+	
+static void xen_properties_destroy(void)
+{
+	sysfs_remove_group(p_kobj, &xen_properties_group);
+	kobject_put(p_kobj);
+}
+
+
+static int __init
+hyper_sysfs_init(void)
+{
+	__label__ out;
+	
+	int err = subsystem_register(&hypervisor_subsys);
+	if (err)
+		goto out;
+	err = kset_register(&xen_kset);
+	if (err)
+		goto out;
+	err = xen_version_init();
+	if (err)
+		goto out;
+	err = xen_compilation_init();
+	if (err)
+		goto out;
+	err = xen_properties_init();
+
+out:
+	return err;
+}
+
+
+static void hyper_sysfs_exit(void)
+{
+ 	xen_properties_destroy();
+	xen_compilation_destroy();
+	xen_version_destroy();
+	kset_unregister(&xen_kset);
+	subsystem_unregister(&hypervisor_subsys);
+}
+
+
+module_init(hyper_sysfs_init);
+module_exit(hyper_sysfs_exit);
+
diff -r f5f32dc60121 -r 10c66e0408d1 linux-2.6-xen-sparse/include/xen/xen_sysfs.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/linux-2.6-xen-sparse/include/xen/xen_sysfs.h	Tue Feb 21 08:13:00 2006 -0500
@@ -0,0 +1,30 @@
+/* 
+    copyright (c) 2006 IBM Corporation 
+    Authored by: Mike D. Day <ncmike@us.ibm.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License version 2 as 
+    published by the Free Software Foundation.
+*/
+
+
+
+#ifndef _XEN_SYSFS_H_
+#define _XEN_SYSFS_H_
+
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <asm/hypercall.h>
+#include <xen/interface/version.h>
+
+
+struct xen_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *, struct attribute *, char *);
+	ssize_t (*store)(struct kobject *, struct attribute *, char *);
+};
+
+extern int HYPERVISOR_xen_version(int, void*);
+
+#endif /* _XEN_SYSFS_H_ */

-- 


