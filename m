Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWA1CU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWA1CU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWA1CUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:20:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:29399 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422793AbWA1CUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:20:12 -0500
Message-ID: <43DAD4DB.4090708@us.ibm.com>
Date: Fri, 27 Jan 2006 21:20:11 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: xen-devel@lists.xensource.com
CC: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [PATCH 2.6.12.6-xen] sysfs attributes for xen
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Creates /sys/hypervisor/xen and populates that dir with xen version, changeset, compilation, and capabilities info. Intended for the xen merge tree and later upstream. 

# HG changeset patch
# User mdday@dual.silverwood.home
# Node ID 9a9f2a5f087c97186bd43561b90f30510413a3e2
# Parent  2e82fd7a69212955b75c6adaed4ae2a58ae45399
add /sys/hypervisor/xen to sysfs and populate with xen version attributes. 

signed-off-by: Mike D. Day <ncmike@us.ibmcom>

diff -r 2e82fd7a6921 -r 9a9f2a5f087c linux-2.6-xen-sparse/arch/xen/kernel/Makefile
--- a/linux-2.6-xen-sparse/arch/xen/kernel/Makefile	Fri Jan 27 11:48:32 2006
+++ b/linux-2.6-xen-sparse/arch/xen/kernel/Makefile	Fri Jan 27 14:28:42 2006
@@ -16,3 +16,4 @@
obj-$(CONFIG_PROC_FS) += xen_proc.o
obj-$(CONFIG_NET)     += skbuff.o
obj-$(CONFIG_SMP)     += smpboot.o
+obj-$(CONFIG_SYSFS)   += xen_sysfs.o xen_sysfs_version.o
diff -r 2e82fd7a6921 -r 9a9f2a5f087c linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c
--- /dev/null	Fri Jan 27 11:48:32 2006
+++ b/linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c	Fri Jan 27 14:28:42 2006
@@ -0,0 +1,73 @@
+/* 
+    copyright (c) 2006 IBM Corporation 
+    Mike Day <ncmike@us.ibm.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
+#include <asm-xen/xen_sysfs.h>
+
+
+static struct subsystem hypervisor_subsys = {
+	.kset = {
+		.kobj = {
+			 .name = "hypervisor",
+		 },
+	},
+};
+
+static struct kset xen_kset = {
+
+	.kobj = {
+		.name = "xen",
+	},
+};
+
+struct subsystem * 
+get_hyper_subsys(void) 
+{
+	return &hypervisor_subsys;
+}
+
+
+struct kset *
+get_xen_kset(void)
+{
+	return &xen_kset;
+}
+
+int __init
+hyper_sysfs_init(void)
+{
+	int err ;
+	
+	if( 0 ==  (err = subsystem_register(&hypervisor_subsys)) ) {
+		xen_kset.subsys = &hypervisor_subsys;
+		err = kset_register(&xen_kset);
+	}
+	return err;
+}
+
+arch_initcall(hyper_sysfs_init);
+EXPORT_SYMBOL_GPL(get_hyper_subsys);
+EXPORT_SYMBOL_GPL(get_xen_kset);
diff -r 2e82fd7a6921 -r 9a9f2a5f087c linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs_version.c
--- /dev/null	Fri Jan 27 11:48:32 2006
+++ b/linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs_version.c	Fri Jan 27 14:28:42 2006
@@ -0,0 +1,194 @@
+/* 
+    copyright (c) 2006 IBM Corporation 
+    Mike Day <ncmike@us.ibm.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <asm/page.h>
+
+#include <asm-xen/xen-public/dom0_ops.h>
+#include <asm-xen/xen-public/version.h>
+#include <asm-xen/asm/hypercall.h>
+#include <asm-xen/xen_sysfs.h>
+
+/* xen version info */
+static ssize_t xen_version_show(struct kobject * kobj, 
+				struct attribute * attr, 
+				char *page)
+{
+	long version;
+	long major, minor;
+	char extra_version[16];
+	
+	if ( (version = HYPERVISOR_xen_version(XENVER_version, NULL)) ) {
+		
+		major = version >> 16;
+		minor = version & 0xff;
+		if( ! HYPERVISOR_xen_version(XENVER_extraversion, 
+					    extra_version) ) {
+			page[PAGE_SIZE - 1] = 0x00;
+			return snprintf(page, PAGE_SIZE - 1, 
+					"xen-%ld.%ld%s\n",
+					major, minor, extra_version);
+		}
+	}
+	return 0;
+}
+
+static struct xen_attr xen_ver_attr = {
+	.attr = {
+		.name = "version", 
+		.mode = 0444, 
+		.owner = THIS_MODULE, 
+	},
+	.show = xen_version_show,
+};
+
+static struct kobject xen_ver_obj = {
+	.name = "version",
+};
+
+/* xen compile info */
+static ssize_t xen_compile_show(struct kobject * kobj, 
+				struct attribute * attr, 
+				char * page)
+{
+	struct xen_compile_info info;
+	
+	if( 0 == HYPERVISOR_xen_version(XENVER_compile_info, &info) ) {
+		page[PAGE_SIZE - 1] = 0x00;
+		return snprintf(page, PAGE_SIZE - 1, 
+				"compiled by %s, using %s, on %s\n", 
+				info.compile_by, 
+				info.compile_date, 
+				info.compiler);
+	}
+	return 0;
+}
+
+static struct xen_attr xen_compile_attr = {
+	.attr = {
+		.name = "compilation", 
+		.mode = 0444, 
+		.owner = THIS_MODULE, 
+	},
+	.show = xen_compile_show,
+};
+
+static struct kobject xen_compile_obj = {
+	.name = "compilation",
+};
+
+/* xen changeset info */
+static ssize_t xen_cset_show(struct kobject * kobj, 
+				struct attribute * attr, 
+				char * page)
+{
+	char info[64];
+	
+	if( 0 == HYPERVISOR_xen_version(XENVER_changeset, &info) ) {
+		page[PAGE_SIZE - 1] = 0x00;
+		return snprintf(page, PAGE_SIZE - 1, 
+				"%s\n", info);
+	}
+	return 0;
+}
+
+static struct xen_attr xen_cset_attr = {
+	.attr = {
+		.name = "changeset", 
+		.mode = 0444, 
+		.owner = THIS_MODULE, 
+	},
+	.show = xen_cset_show,
+};
+
+static struct kobject xen_cset_obj = {
+	.name = "changeset",
+};
+
+
+/* xen capabilities info */
+static ssize_t xen_cap_show(struct kobject * kobj, 
+				struct attribute * attr, 
+				char * page)
+{
+	char info[1024];
+	
+	if( 0 == HYPERVISOR_xen_version(XENVER_capabilities, &info) ) {
+		page[PAGE_SIZE - 1] = 0x00;
+		return snprintf(page, PAGE_SIZE - 1, 
+				"%s\n", info);
+	}
+	return 0;
+}
+
+static struct xen_attr xen_cap_attr = {
+	.attr = {
+		.name = "capabilities", 
+		.mode = 0444, 
+		.owner = THIS_MODULE, 
+	},
+	.show = xen_cap_show,
+};
+
+static struct kobject xen_cap_obj = {
+	.name = "capabilities",
+};
+
+int __init
+sysfs_xen_version_init(void)
+{
+	__label__  out;
+	
+	struct kset * parent = get_xen_kset();
+	if ( parent != NULL ) {
+		kobject_init(&xen_ver_obj);
+		xen_ver_obj.parent = &parent->kobj;		
+		xen_ver_obj.dentry = parent->kobj.dentry;
+		kobject_get(&parent->kobj);
+		if ( sysfs_create_file(&xen_ver_obj, &xen_ver_attr.attr) )
+			goto out;
+		
+		kobject_init(&xen_compile_obj);
+		xen_compile_obj.parent = &parent->kobj;
+		xen_compile_obj.dentry = parent->kobj.dentry;
+		kobject_get(&parent->kobj);
+		if( sysfs_create_file(&xen_compile_obj, &xen_compile_attr.attr) )
+			goto out;
+
+		kobject_init(&xen_cset_obj);
+		xen_cset_obj.parent = &parent->kobj;
+		xen_cset_obj.dentry = parent->kobj.dentry;
+		kobject_get(&parent->kobj);
+		if( sysfs_create_file(&xen_cset_obj, &xen_cset_attr.attr) )
+			goto out;
+
+		kobject_init(&xen_cap_obj);
+		xen_cap_obj.parent = &parent->kobj;
+		xen_cap_obj.dentry = parent->kobj.dentry;
+		kobject_get(&parent->kobj);
+		return sysfs_create_file(&xen_cap_obj, &xen_cap_attr.attr);
+	}
+out:
+	return 1;
+}
+
+device_initcall(sysfs_xen_version_init);
diff -r 2e82fd7a6921 -r 9a9f2a5f087c linux-2.6-xen-sparse/include/asm-xen/xen_sysfs.h
--- /dev/null	Fri Jan 27 11:48:32 2006
+++ b/linux-2.6-xen-sparse/include/asm-xen/xen_sysfs.h	Fri Jan 27 14:28:42 2006
@@ -0,0 +1,45 @@
+/* 
+    copyright (c) 2006 IBM Corporation 
+    Mike Day <ncmike@us.ibm.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+
+
+#ifndef _XEN_SYSFS_H_
+#define _XEN_SYSFS_H_
+
+#ifdef __KERNEL__ 
+
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <asm-xen/asm/hypercall.h>
+#include <asm-xen/xen-public/version.h>
+
+
+struct xen_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *, struct attribute *, char *);
+	ssize_t (*store)(struct kobject *, struct attribute *, char *);
+};
+
+extern int HYPERVISOR_xen_version(int, void*);
+extern struct subsystem * get_hyper_subsys(void);
+extern struct kset * get_xen_kset(void);
+
+#endif /* __KERNEL__ */
+#endif /* _XEN_SYSFS_H_ */

-- 



