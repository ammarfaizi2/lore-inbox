Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUKHEXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUKHEXV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 23:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUKHEVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 23:21:09 -0500
Received: from fmr12.intel.com ([134.134.136.15]:58026 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261742AbUKHERh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 23:17:37 -0500
Subject: [PATCH/RFC 4/4]An experimental implementation for IDE bus
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Content-Type: multipart/mixed; boundary="=-8INMQSGffGGf3EYOjTVV"
Message-Id: <1099887081.1750.249.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 08 Nov 2004 12:11:47 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8INMQSGffGGf3EYOjTVV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
A sample patch to bind IDE devices. I'm not familar with IDE driver, so
the patch possibly is completely wrong, though it can show correct ACPI
path in my laptop. This test case just shows the framework works, please
don't apply it.

Thanks,
Shaohua
---

 2.6-root/drivers/ide/ide.c |   43
+++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+)

diff -puN drivers/ide/ide.c~ide-bind-acpi drivers/ide/ide.c
--- 2.6/drivers/ide/ide.c~ide-bind-acpi	2004-11-08 11:09:12.625009440
+0800
+++ 2.6-root/drivers/ide/ide.c	2004-11-08 11:10:04.477126720 +0800
@@ -2412,10 +2412,53 @@ EXPORT_SYMBOL(ide_fops);
 
 EXPORT_SYMBOL(ide_lock);
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+int generic_ide_platform_bind(struct device *dev)
+{
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+	int i;
+
+	/* Seems dev->parent->parent is the PCI IDE controller */
+        if (dev->parent && dev->parent->parent)
+                parent_handle = dev->parent->parent->handle;
+
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -1;
+	}
+	/* Please ref to ACPI spec for syntax of _ADR */
+	sscanf(dev->bus_id, "%d", &i);
+	address = i;
+	dev->handle = acpi_get_child(parent_handle, address);
+
+#if 1
+       {/* For debug */
+               char            name[80] = {'?','\0'};
+               struct acpi_buffer      buffer = {sizeof(name), name};
+
+               printk("IDE device %d:", i);
+               if (dev->handle) {
+                       acpi_get_name(dev->handle, ACPI_FULL_PATHNAME,
&buffer);
+                       printk("%s", name);
+               }
+               printk("\n");
+       }
+#endif
+	return 0;
+}
+#else
+int generic_ide_platform_bind(struct device *dev)
+{
+	return 0;
+}
+#endif
 struct bus_type ide_bus_type = {
 	.name		= "ide",
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
+	.platform_bind	= generic_ide_platform_bind,
 };
 
 /*
_


--=-8INMQSGffGGf3EYOjTVV
Content-Disposition: attachment; filename=p00004_ide-bind-acpi.patch
Content-Type: text/x-patch; name=p00004_ide-bind-acpi.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


A sample patch to bind IDE devices. I'm not familar with IDE driver, so the
patch possibly is completely wrong, though it can show correct ACPI path in
my laptop. This test case just shows the framework works, please don't apply.

---

 2.6-root/drivers/ide/ide.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+)

diff -puN drivers/ide/ide.c~ide-bind-acpi drivers/ide/ide.c
--- 2.6/drivers/ide/ide.c~ide-bind-acpi	2004-11-08 11:09:12.625009440 +0800
+++ 2.6-root/drivers/ide/ide.c	2004-11-08 11:10:04.477126720 +0800
@@ -2412,10 +2412,53 @@ EXPORT_SYMBOL(ide_fops);
 
 EXPORT_SYMBOL(ide_lock);
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+int generic_ide_platform_bind(struct device *dev)
+{
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+	int i;
+
+	/* Seems dev->parent->parent is the PCI IDE controller */
+        if (dev->parent && dev->parent->parent)
+                parent_handle = dev->parent->parent->handle;
+
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -1;
+	}
+	/* Please ref to ACPI spec for syntax of _ADR */
+	sscanf(dev->bus_id, "%d", &i);
+	address = i;
+	dev->handle = acpi_get_child(parent_handle, address);
+
+#if 1
+       {/* For debug */
+               char            name[80] = {'?','\0'};
+               struct acpi_buffer      buffer = {sizeof(name), name};
+
+               printk("IDE device %d:", i);
+               if (dev->handle) {
+                       acpi_get_name(dev->handle, ACPI_FULL_PATHNAME, &buffer);
+                       printk("%s", name);
+               }
+               printk("\n");
+       }
+#endif
+	return 0;
+}
+#else
+int generic_ide_platform_bind(struct device *dev)
+{
+	return 0;
+}
+#endif
 struct bus_type ide_bus_type = {
 	.name		= "ide",
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
+	.platform_bind	= generic_ide_platform_bind,
 };
 
 /*
_

--=-8INMQSGffGGf3EYOjTVV--

