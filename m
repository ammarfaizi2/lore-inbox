Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWCTX1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWCTX1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWCTX1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:27:40 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:18610 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964869AbWCTX1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:27:39 -0500
Date: Mon, 20 Mar 2006 18:35:14 -0500
Message-Id: <200603202335.k2KNZEjo005673@mdday.raleigh.ibm.com>
From: "Mike D. Day" <ncmike@us.ibm.com>
To: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: [PATCH 2.6.16-rc6-xen] export Xen Hypervisor attributes to sysfs
Reply-to: ncmike@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Creates a module that exports Xen Hypervisor attributes to sysfs. The
module has a tri-state configuration so it can be a loadable module.

Views the hypervisor as hardware device, uses sysfs as  a scripting
interface for user space tools that need these attributes.

Some user space apps, particularly for systems management, need to
know if their kernel is running in a virtual machine and if so in
what type of virtual machine. This property is contained in the
file /sys/hypervisor/type.

The file hypervisor_sysfs.c creates a generic  hypervisor subsystem
that can be linked to by any hypervisor. The file xen_sysfs.c exports
the xen-specific attributes.

signed-off-by: Mike D. Day <ncmike@us.ibm.com>

---
Initial directory = /sys/hypervisor
+---compilation
|   >---compile_date
|   >---compiled_by
|   >---compiler
+---properties
|   >---capabilities
|   >---changeset
|   >---virtual_start
|   >---writable_pt
>---type
+---version
|   >---extra
|   >---major
|   >---minor

Some examples: 
[mdday@athlon64 ~]$ cat /sys/hypervisor/type
xen

[mdday@athlon64 ~]$ cat /sys/hypervisor/version/major
3

[mdday@athlon64 ~]$ cat /sys/hypervisor/properties/changeset
Sun Mar 19 09:17:50 2006 +0100 9322:768936b2800a

[mdday@athlon64 ~]$ cat /sys/hypervisor/properties/capabilities
xen-3.0-x86_64


 b/linux-2.6-xen-sparse/drivers/xen/core/hypervisor_sysfs.c |   58 ++
 b/linux-2.6-xen-sparse/drivers/xen/core/xen_sysfs.c        |  314 +++++++++++++
 b/linux-2.6-xen-sparse/include/xen/hypervisor_sysfs.h      |   34 +
 linux-2.6-xen-sparse/drivers/xen/Kconfig                   |    8
 linux-2.6-xen-sparse/drivers/xen/core/Makefile             |    2
 5 files changed, 416 insertions(+)

# HG changeset patch
# User mdday@dual.silverwood.home
# Node ID 508bf03c36ab88226378d5e2621ec065ca04d7c6
# Parent  a8b1d4fad72d2b0bba1b121bc250b4ac80fcf9ac
export xen attributes to sysfs

diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/drivers/xen/Kconfig
--- a/linux-2.6-xen-sparse/drivers/xen/Kconfig	Mon Mar 20 12:01:32 2006 +0100
+++ b/linux-2.6-xen-sparse/drivers/xen/Kconfig	Mon Mar 20 18:06:53 2006 -0500
@@ -189,6 +189,14 @@ config XEN_DISABLE_SERIAL
 	  Disable serial port drivers, allowing the Xen console driver
 	  to provide a serial console at ttyS0.
 
+config XEN_SYSFS
+	tristate "Export Xen attributes in sysfs"
+	depends on XEN
+	depends on SYSFS
+	default y
+	help
+		Xen hypervisor attributes will show up under /sys/hypervisor/.
+
 endmenu
 
 config HAVE_ARCH_ALLOC_SKB
diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/drivers/xen/core/Makefile
--- a/linux-2.6-xen-sparse/drivers/xen/core/Makefile	Mon Mar 20 12:01:32 2006 +0100
+++ b/linux-2.6-xen-sparse/drivers/xen/core/Makefile	Mon Mar 20 18:06:53 2006 -0500
@@ -7,3 +7,5 @@ obj-$(CONFIG_PROC_FS) += xen_proc.o
 obj-$(CONFIG_PROC_FS) += xen_proc.o
 obj-$(CONFIG_NET)     += skbuff.o
 obj-$(CONFIG_SMP)     += smpboot.o
+obj-$(CONFIG_SYSFS)   += hypervisor_sysfs.o
+obj-$(CONFIG_XEN_SYSFS) += xen_sysfs.o
diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/drivers/xen/core/hypervisor_sysfs.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/linux-2.6-xen-sparse/drivers/xen/core/hypervisor_sysfs.c	Mon Mar 20 18:06:53 2006 -0500
@@ -0,0 +1,58 @@
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
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <xen/hypervisor_sysfs.h>
+
+decl_subsys(hypervisor, NULL, NULL);
+
+static ssize_t hyp_sysfs_show(struct kobject *kobj,
+			      struct attribute *attr,
+			      char *buffer)
+{
+	struct hyp_sysfs_attr *hyp_attr;
+	hyp_attr = container_of(attr, struct hyp_sysfs_attr, attr);
+	if (hyp_attr->show)
+		return hyp_attr->show(hyp_attr, buffer);
+	return 0;
+}
+
+static ssize_t hyp_sysfs_store(struct kobject *kobj,
+			       struct attribute *attr,
+			       const char *buffer,
+			       size_t len)
+{
+	struct hyp_sysfs_attr *hyp_attr;
+	hyp_attr = container_of(attr, struct hyp_sysfs_attr, attr);
+	if (hyp_attr->store)
+		return hyp_attr->store(hyp_attr, buffer, len);
+	return 0;
+}
+
+struct sysfs_ops hyp_sysfs_ops = {
+	.show = hyp_sysfs_show,
+	.store = hyp_sysfs_store,
+};
+
+static struct kobj_type hyp_sysfs_kobj_type = {
+	.sysfs_ops = &hyp_sysfs_ops,
+};
+
+static int __init hypervisor_subsys_init(void)
+{
+	hypervisor_subsys.kset.kobj.ktype = &hyp_sysfs_kobj_type;
+	return subsystem_register(&hypervisor_subsys);
+}
+
+device_initcall(hypervisor_subsys_init);
+EXPORT_SYMBOL_GPL(hypervisor_subsys);
diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/drivers/xen/core/xen_sysfs.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/linux-2.6-xen-sparse/drivers/xen/core/xen_sysfs.c	Mon Mar 20 18:06:53 2006 -0500
@@ -0,0 +1,310 @@
+/*
+    copyright (c) 2006 IBM Corporation
+    Authored by: Mike D. Day <ncmike@us.ibm.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License version 2 as
+    published by the Free Software Foundation.
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <asm/hypervisor.h>
+#include <xen/hypervisor_sysfs.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mike D. Day <ncmike@us.ibm.com>");
+
+static ssize_t type_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	return sprintf(buffer, "xen\n");
+}
+
+HYPERVISOR_ATTR_RO(type);
+
+static int __init xen_sysfs_type_init(void)
+{
+	return sysfs_create_file(&hypervisor_subsys.kset.kobj, &type_attr.attr);
+}
+
+static void xen_sysfs_type_destroy(void)
+{
+	sysfs_remove_file(&hypervisor_subsys.kset.kobj, &type_attr.attr);
+}
+
+/* xen version attributes */
+static ssize_t major_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int version = HYPERVISOR_xen_version(XENVER_version, NULL);
+	if (version)
+		return sprintf(buffer, "%d\n", version >> 16);
+	return -ENODEV;
+}
+
+HYPERVISOR_ATTR_RO(major);
+
+static ssize_t minor_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int version = HYPERVISOR_xen_version(XENVER_version, NULL);
+	if (version)
+		return sprintf(buffer, "%d\n", version & 0xff);
+	return -ENODEV;
+}
+
+HYPERVISOR_ATTR_RO(minor);
+
+static ssize_t extra_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int ret;
+	char *extra = kmalloc(XEN_EXTRAVERSION_LEN, GFP_KERNEL);
+	if (extra) {
+		ret = HYPERVISOR_xen_version(XENVER_extraversion, extra);
+		if (!ret)
+			return sprintf(buffer, "%s\n", extra);
+		kfree(extra);
+	} else
+		ret = -ENOMEM;
+	return ret;
+}
+
+HYPERVISOR_ATTR_RO(extra);
+
+static struct attribute *version_attrs[] = {
+	&major_attr.attr,
+	&minor_attr.attr,
+	&extra_attr.attr,
+	NULL
+};
+
+static struct attribute_group version_group = {
+	.name = "version",
+	.attrs = version_attrs,
+};
+
+static int __init xen_sysfs_version_init(void)
+{
+	return sysfs_create_group(&hypervisor_subsys.kset.kobj, &version_group);
+}
+
+static void xen_sysfs_version_destroy(void)
+{
+	sysfs_remove_group(&hypervisor_subsys.kset.kobj, &version_group);
+}
+
+/* xen compilation attributes */
+
+static ssize_t compiler_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int ret;
+	struct xen_compile_info *info =
+	    kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
+	if (info) {
+		ret = HYPERVISOR_xen_version(XENVER_compile_info, info);
+		if (!ret)
+			ret = sprintf(buffer, "%s\n", info->compiler);
+		kfree(info);
+	} else
+		ret = -ENOMEM;
+
+	return ret;
+}
+
+HYPERVISOR_ATTR_RO(compiler);
+
+static ssize_t compiled_by_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int ret;
+	struct xen_compile_info *info;
+
+	info = kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
+	if (info) {
+		ret = HYPERVISOR_xen_version(XENVER_compile_info, info);
+		if (!ret)
+			ret = sprintf(buffer, "%s\n", info->compile_by);
+		kfree(info);
+	} else
+		ret = -ENOMEM;
+	return ret;
+}
+
+HYPERVISOR_ATTR_RO(compiled_by);
+
+static ssize_t compile_date_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int ret;
+	struct xen_compile_info *info;
+
+	info = kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
+	if (info) {
+		ret = HYPERVISOR_xen_version(XENVER_compile_info, info);
+		if (!ret)
+			ret = sprintf(buffer, "%s\n", info->compile_date);
+		kfree(info);
+	} else
+		ret = -ENOMEM;
+	return ret;
+}
+
+HYPERVISOR_ATTR_RO(compile_date);
+
+static struct attribute *xen_compile_attrs[] = {
+	&compiler_attr.attr,
+	&compiled_by_attr.attr,
+	&compile_date_attr.attr,
+	NULL
+};
+
+static struct attribute_group xen_compilation_group = {
+	.name = "compilation",
+	.attrs = xen_compile_attrs,
+};
+
+int __init static xen_compilation_init(void)
+{
+	return sysfs_create_group(&hypervisor_subsys.kset.kobj,
+				  &xen_compilation_group);
+}
+
+static void xen_compilation_destroy(void)
+{
+	sysfs_remove_group(&hypervisor_subsys.kset.kobj,
+			   &xen_compilation_group);
+}
+
+/* xen properties info */
+
+static ssize_t capabilities_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int ret;
+	char *caps = kmalloc(XEN_CAPABILITIES_INFO_LEN, GFP_KERNEL);
+	if (caps) {
+		ret = HYPERVISOR_xen_version(XENVER_capabilities, caps);
+		if (!ret)
+			ret = sprintf(buffer, "%s\n", caps);
+		kfree(caps);
+	} else
+		ret = -ENOMEM;
+	return ret;
+}
+
+HYPERVISOR_ATTR_RO(capabilities);
+
+static ssize_t changeset_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int ret;
+	char *cset = kmalloc(XEN_CHANGESET_INFO_LEN, GFP_KERNEL);
+	if (cset) {
+		ret = HYPERVISOR_xen_version(XENVER_changeset, cset);
+		if (!ret)
+			ret = sprintf(buffer, "%s\n", cset);
+		kfree(cset);
+	} else
+		ret = -ENOMEM;
+	return ret;
+}
+
+HYPERVISOR_ATTR_RO(changeset);
+
+static ssize_t virtual_start_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	int ret;
+	struct xen_platform_parameters *parms =
+	    kmalloc(sizeof(struct xen_platform_parameters), GFP_KERNEL);
+	if (parms) {
+		ret = HYPERVISOR_xen_version(XENVER_platform_parameters, parms);
+		if (!ret)
+			ret = sprintf(buffer, "%lx\n", parms->virt_start);
+		kfree(parms);
+	} else
+		ret = -ENOMEM;
+	return ret;
+}
+
+HYPERVISOR_ATTR_RO(virtual_start);
+
+/* eventually there will be several more features to export */
+static ssize_t xen_feature_show(int index, char *buffer)
+{
+	int ret;
+
+	struct xen_feature_info *info =
+	    kmalloc(sizeof(struct xen_feature_info), GFP_KERNEL);
+	if (info) {
+		info->submap_idx = index;
+		ret = HYPERVISOR_xen_version(XENVER_get_features, info);
+		if (!ret)
+			ret = sprintf(buffer, "%d\n", info->submap);
+		kfree(info);
+	} else
+		ret = -ENOMEM;
+	return ret;
+}
+
+static ssize_t writable_pt_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	return xen_feature_show(XENFEAT_writable_page_tables, buffer);
+}
+
+HYPERVISOR_ATTR_RO(writable_pt);
+
+static struct attribute *xen_properties_attrs[] = {
+	&capabilities_attr.attr,
+	&changeset_attr.attr,
+	&virtual_start_attr.attr,
+	&writable_pt_attr.attr,
+	NULL
+};
+
+static struct attribute_group xen_properties_group = {
+	.name = "properties",
+	.attrs = xen_properties_attrs,
+};
+
+static int __init xen_properties_init(void)
+{
+	return sysfs_create_group(&hypervisor_subsys.kset.kobj,
+				  &xen_properties_group);
+}
+
+static void xen_properties_destroy(void)
+{
+	sysfs_remove_group(&hypervisor_subsys.kset.kobj, &xen_properties_group);
+}
+
+static int __init hyper_sysfs_init(void)
+{
+	int ret = xen_sysfs_type_init();
+	if (ret)
+		goto out;
+	ret = xen_sysfs_version_init();
+	if (ret)
+		goto version_out;
+	ret = xen_compilation_init();
+	if (ret)
+		goto comp_out;
+	ret = xen_properties_init();
+	if (!ret)
+		goto out;
+
+	xen_compilation_destroy();
+comp_out:
+	xen_sysfs_version_destroy();
+version_out:
+	xen_sysfs_type_destroy();
+out:
+	return ret;
+}
+
+static void hyper_sysfs_exit(void)
+{
+	xen_properties_destroy();
+	xen_compilation_destroy();
+	xen_sysfs_version_destroy();
+	xen_sysfs_type_destroy();
+
+}
+
+module_init(hyper_sysfs_init);
+module_exit(hyper_sysfs_exit);
diff -r a8b1d4fad72d -r 508bf03c36ab linux-2.6-xen-sparse/include/xen/hypervisor_sysfs.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/linux-2.6-xen-sparse/include/xen/hypervisor_sysfs.h	Mon Mar 20 18:06:53 2006 -0500
@@ -0,0 +1,34 @@
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
+#ifndef _HYP_SYSFS_H_
+#define _HYP_SYSFS_H_
+
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
+#define HYPERVISOR_ATTR_RO(_name) \
+static struct hyp_sysfs_attr  _name##_attr = __ATTR_RO(_name)
+
+#define HYPERVISOR_ATTR_RW(_name) \
+static struct hyp_sysfs_attr _name##_attr = \
+	__ATTR(_name, 0644, _name##_show, _name##_store)
+
+extern struct subsystem hypervisor_subsys;
+
+struct hyp_sysfs_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct hyp_sysfs_attr *, char *);
+	ssize_t (*store)(struct hyp_sysfs_attr *, const char *, size_t);
+	void *hyp_attr_data;
+};
+
+#endif /* _HYP_SYSFS_H_ */
