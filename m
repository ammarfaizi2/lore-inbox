Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUHDBop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUHDBop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHDBop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:44:45 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.70]:2250 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267191AbUHDBoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:44:06 -0400
Date: Tue, 03 Aug 2004 21:42:58 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger@gmx.at>
Message-id: <41103F22.4090303@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Ijh9nVakT+w9yxxZMLT64w)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_Ijh9nVakT+w9yxxZMLT64w)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


This patch should fix multiple user-visible problems with the ACPI IRQ 
routing after S3 resume:

"irq x: nobody cared"
"my interrupts are gone"

It probably applies to multiple bugzilla entries and mailing list posts.

Tested on my machine, which is experiencing similar problems. Seems to 
work - although I get some non-fatal "nobody cared" messages that might 
be caused by the i8042 driver.

Comments?
Stefan, can you test this?

--Boundary_(ID_Ijh9nVakT+w9yxxZMLT64w)
Content-type: text/x-patch; name=acpi-fixes.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=acpi-fixes.patch

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/03 19:37:56-04:00 nbryant@optonline.net 
#   drivers/acpi/pci_link.c: use device_initcall(irqrouter_init_sysfs);
# 
# drivers/acpi/pci_link.c
#   2004/08/03 19:37:47-04:00 nbryant@optonline.net +13 -3
#   use device_initcall(irqrouter_init_sysfs);
# 
# ChangeSet
#   2004/08/03 18:09:20-04:00 nbryant@optonline.net 
#   fix ACPI_FUNCTION_TRACE("irqrouter_resume");
# 
# drivers/acpi/pci_link.c
#   2004/08/03 18:09:12-04:00 nbryant@optonline.net +1 -1
#   fix ACPI_FUNCTION_TRACE("irqrouter_resume");
# 
# ChangeSet
#   2004/08/03 18:03:39-04:00 nbryant@optonline.net 
#   drivers/acpi/pci_link.c: register us as a sys_device so that we can get
#   resume callbacks and restore interrupt state. Fixes interrupt problems
#   reported on the mailing lists:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# drivers/acpi/pci_link.c
#   2004/08/03 18:03:31-04:00 nbryant@optonline.net +51 -14
#   drivers/acpi/pci_link.c: register us as a sys_device so that we can get
#   resume callbacks and restore interrupt state. Fixes interrupt problems
#   reported on the mailing lists:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# ChangeSet
#   2004/08/02 20:41:54-04:00 nbryant@optonline.net 
#   [ACPI] drivers/acpi/pci_link.c: add acpi_pci_link_resume(), which will be
#   called when resuming from a suspend state that needs IRQ routing to be
#   restored. This fixes issues reported on the mailing lists, e.g.:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# drivers/acpi/pci_link.c
#   2004/08/02 20:41:45-04:00 nbryant@optonline.net +23 -0
#   [ACPI] drivers/acpi/pci_link.c: add acpi_pci_link_resume(), which will be
#   called when resuming from a suspend state that needs IRQ routing to be
#   restored. This fixes issues reported on the mailing lists, e.g.:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# BitKeeper/etc/ignore
#   2004/08/02 20:41:45-04:00 nbryant@optonline.net +2 -0
#   Added Module.symvers drivers/acpi/pci_link.c~ to the ignore list
# 
diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	2004-08-03 19:41:29 -04:00
+++ b/drivers/acpi/pci_link.c	2004-08-03 19:41:29 -04:00
@@ -29,6 +29,7 @@
  *	   for IRQ management (e.g. start()->_SRS).
  */
 
+#include <linux/sysdev.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -84,6 +85,8 @@
 	struct acpi_pci_link_irq irq;
 };
 
+static int acpi_pci_link_resume (struct acpi_pci_link *link);
+
 static struct {
 	int			count;
 	struct list_head	entries;
@@ -695,6 +698,42 @@
 
 
 static int
+acpi_pci_link_resume (
+	struct acpi_pci_link	*link)
+{
+	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
+	
+	if (link->irq.active && link->irq.setonboot)
+		return_VALUE(acpi_pci_link_set(link, link->irq.active));
+	else
+		return_VALUE(0);
+}
+
+
+static int
+irqrouter_resume(
+	struct sys_device *dev)
+{
+	struct list_head        *node = NULL;
+	struct acpi_pci_link    *link = NULL;
+
+	ACPI_FUNCTION_TRACE("irqrouter_resume");
+
+	list_for_each(node, &acpi_link.entries) {
+
+		link = list_entry(node, struct acpi_pci_link, node);
+		if (!link) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+			continue;
+		}
+
+		acpi_pci_link_resume(link);
+	}
+	return_VALUE(0);
+}
+
+
+static int
 acpi_pci_link_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -786,11 +825,42 @@
 __setup("acpi_irq_balance", acpi_irq_balance_set);
 
 
+static struct sysdev_class irqrouter_sysdev_class = {
+        set_kset_name("irqrouter"),
+        .resume = irqrouter_resume,
+};
+
+
+static struct sys_device device_irqrouter = {
+	.id     = 0,
+	.cls    = &irqrouter_sysdev_class,
+};
+
+
+static int __init irqrouter_init_sysfs(void)
+{
+	int error;
+
+	ACPI_FUNCTION_TRACE("irqrouter_init_sysfs");
+
+	if (acpi_disabled || acpi_noirq)
+		return_VALUE(0);
+
+        error = sysdev_class_register(&irqrouter_sysdev_class);
+        if (!error)
+        	error = sysdev_register(&device_irqrouter);
+
+        return_VALUE(error);
+}                                        
+
+device_initcall(irqrouter_init_sysfs);
+
+
 static int __init acpi_pci_link_init (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_pci_link_init");
 
-	if (acpi_pci_disabled)
+	if (acpi_disabled || acpi_noirq)
 		return_VALUE(0);
 
 	acpi_link.count = 0;
@@ -798,7 +868,7 @@
 
 	if (acpi_bus_register_driver(&acpi_pci_link_driver) < 0)
 		return_VALUE(-ENODEV);
-
+		
 	return_VALUE(0);
 }
 

--Boundary_(ID_Ijh9nVakT+w9yxxZMLT64w)--
