Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVGNJJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVGNJJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbVGNJHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:07:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:5513 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262962AbVGNJF3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:29 -0400
Subject: [RFC][PATCH] add PCI bus registration support [2/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:55:12 -0400
Message-Id: <1121331313.3398.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds pci_add_bus() for PCI bus registration.  It also moves
pci_remove_bus() from remove.c to bus/bus.c for consistency.

Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/pci/bus/bus.c	2005-07-12 00:59:58.000000000 -0400
+++ b/drivers/pci/bus/bus.c	2005-07-12 01:01:13.992787920 -0400
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 
 #include "bus.h"
+#include "../pci.h"
 
 #undef DEBUG
 
@@ -50,7 +51,7 @@
  */
 
 /**
- *	pci_alloc_bus - allocates a "pci_bus" structure
+ * pci_alloc_bus - allocates a "pci_bus" structure
  */
 struct pci_bus * pci_alloc_bus(void)
 {
@@ -67,3 +68,61 @@
 }
 
 EXPORT_SYMBOL(pci_alloc_bus);
+
+/**
+ * pci_add_bus - registers a bus with the pci bus class
+ * @bus: the bus
+ *
+ * Setup class data, register with the driver core, proc, etc...
+ */
+int pci_add_bus(struct pci_bus *bus)
+{
+	int ret;
+
+	bus->class_dev.class = &pcibus_class;
+	sprintf(bus->class_dev.class_id, "%04x:%02x", pci_domain_nr(bus),
+		bus->primary);
+
+	ret = class_device_register(&bus->class_dev);
+	if (ret)
+		return ret;
+
+	class_device_create_file(&bus->class_dev,
+				 &class_device_attr_cpuaffinity);
+	if (bus->self)
+		sysfs_create_link(&bus->class_dev.kobj,
+				  &bus->self->dev.kobj, "bridge");
+
+	spin_lock(&pci_bus_lock);
+	list_add_tail(&bus->node, &bus->parent->children);
+	spin_unlock(&pci_bus_lock);
+
+	pci_proc_attach_bus(bus);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_add_bus);
+
+/**
+ * pci_remove_bus - unregisters a bus with the pci bus class
+ * @bus: the bus
+ *
+ * Remove the bus from bus lists, remove proc/sysfs files, and unregister
+ * from the driver core.
+ */
+void pci_remove_bus(struct pci_bus *pci_bus)
+{
+	pci_proc_detach_bus(pci_bus);
+
+	spin_lock(&pci_bus_lock);
+	list_del(&pci_bus->node);
+	spin_unlock(&pci_bus_lock);
+	pci_remove_legacy_files(pci_bus);
+	class_device_remove_file(&pci_bus->class_dev,
+		&class_device_attr_cpuaffinity);
+	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
+	class_device_unregister(&pci_bus->class_dev);
+}
+
+EXPORT_SYMBOL(pci_remove_bus);
--- a/drivers/pci/remove.c	2005-07-08 17:06:20.000000000 -0400
+++ b/drivers/pci/remove.c	2005-07-12 01:01:13.998787008 -0400
@@ -57,20 +57,6 @@
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
 
-void pci_remove_bus(struct pci_bus *pci_bus)
-{
-	pci_proc_detach_bus(pci_bus);
-
-	spin_lock(&pci_bus_lock);
-	list_del(&pci_bus->node);
-	spin_unlock(&pci_bus_lock);
-	pci_remove_legacy_files(pci_bus);
-	class_device_remove_file(&pci_bus->class_dev,
-		&class_device_attr_cpuaffinity);
-	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
-	class_device_unregister(&pci_bus->class_dev);
-}
-EXPORT_SYMBOL(pci_remove_bus);
 
 /**
  * pci_remove_bus_device - remove a PCI device and any children
--- a/include/linux/pci.h	2005-07-12 00:59:58.000000000 -0400
+++ b/include/linux/pci.h	2005-07-12 01:01:14.065776824 -0400
@@ -734,6 +734,8 @@
 /* Generic PCI functions used internally */
 
 extern struct pci_bus * pci_alloc_bus(void);
+extern int pci_add_bus(struct pci_bus *bus);
+extern void pci_remove_bus(struct pci_bus *bus);
 extern struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(struct pci_bus *bus);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
@@ -756,7 +758,6 @@
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
 extern void pci_dev_put(struct pci_dev *dev);
-extern void pci_remove_bus(struct pci_bus *b);
 extern void pci_remove_bus_device(struct pci_dev *dev);
 
 /* Generic PCI functions exported to card drivers */


