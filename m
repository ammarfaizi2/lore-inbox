Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWGLGFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWGLGFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWGLGFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:05:24 -0400
Received: from xenotime.net ([66.160.160.81]:43188 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932435AbWGLGFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:05:23 -0400
Date: Tue, 11 Jul 2006 23:08:11 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm <akpm@osdl.org>
Subject: [PATCH -mm] acpi/scan: handle kset/kobject errors
Message-Id: <20060711230811.9e1167e5.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check and handle kset_register() and kobject_register() init errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/scan.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

--- linux-2618-rc1mm1.orig/drivers/acpi/scan.c
+++ linux-2618-rc1mm1/drivers/acpi/scan.c
@@ -4,6 +4,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/acpi.h>
 
 #include <acpi/acpi_drivers.h>
@@ -113,6 +114,8 @@ static struct kset acpi_namespace_kset =
 static void acpi_device_register(struct acpi_device *device,
 				 struct acpi_device *parent)
 {
+	int err;
+
 	/*
 	 * Linkage
 	 * -------
@@ -138,7 +141,10 @@ static void acpi_device_register(struct 
 		device->kobj.parent = &parent->kobj;
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
-	kobject_register(&device->kobj);
+	err = kobject_register(&device->kobj);
+	if (err < 0)
+		printk(KERN_WARNING "%s: kobject_register error: %d\n",
+			__FUNCTION__, err);
 	create_sysfs_device_files(device);
 }
 
@@ -1450,7 +1456,9 @@ static int __init acpi_scan_init(void)
 	if (acpi_disabled)
 		return 0;
 
-	kset_register(&acpi_namespace_kset);
+	result = kset_register(&acpi_namespace_kset);
+	if (result < 0)
+		printk(KERN_ERR PREFIX "kset_register error: %d\n", result);
 
 	result = bus_register(&acpi_bus_type);
 	if (result) {


---
