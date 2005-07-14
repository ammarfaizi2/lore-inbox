Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVGNJJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVGNJJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVGNJHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:07:36 -0400
Received: from peabody.ximian.com ([130.57.169.10]:8585 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262969AbVGNJFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:32 -0400
Subject: [RFC][PATCH] root PCI bridge registration updates [5/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:55:23 -0400
Message-Id: <1121331323.3398.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates pci_scan_bus_parented() and also has some important
fixes to the PCI bus class.

Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/pci/bus/bus.c	2005-07-12 01:08:20.000000000 -0400
+++ b/drivers/pci/bus/bus.c	2005-07-13 02:01:57.000000000 -0400
@@ -81,7 +81,7 @@
 
 	bus->class_dev.class = &pcibus_class;
 	sprintf(bus->class_dev.class_id, "%04x:%02x", pci_domain_nr(bus),
-		bus->primary);
+		bus->number);
 
 	ret = class_device_register(&bus->class_dev);
 	if (ret)
@@ -89,13 +89,15 @@
 
 	class_device_create_file(&bus->class_dev,
 				 &class_device_attr_cpuaffinity);
-	if (bus->self)
+	if (bus->bridge)
 		sysfs_create_link(&bus->class_dev.kobj,
-				  &bus->self->dev.kobj, "bridge");
+				  &bus->bridge->kobj, "bridge");
 
-	spin_lock(&pci_bus_lock);
-	list_add_tail(&bus->node, &bus->parent->children);
-	spin_unlock(&pci_bus_lock);
+	if (bus->parent) {
+		spin_lock(&pci_bus_lock);
+		list_add_tail(&bus->node, &bus->parent->children);
+		spin_unlock(&pci_bus_lock);
+	}
 
 	pci_proc_attach_bus(bus);
 
--- a/drivers/pci/bus/probe.c	2005-07-12 00:59:58.000000000 -0400
+++ b/drivers/pci/bus/probe.c	2005-07-13 01:58:54.000000000 -0400
@@ -427,37 +427,24 @@
 	error = device_register(dev);
 	if (error)
 		goto dev_reg_err;
+
 	b->bridge = get_device(dev);
+	b->number = b->secondary = bus;
+	b->resource[0] = &ioport_resource;
+	b->resource[1] = &iomem_resource;
 
-	b->class_dev.class = &pcibus_class;
-	sprintf(b->class_dev.class_id, "%04x:%02x", pci_domain_nr(b), bus);
-	error = class_device_register(&b->class_dev);
-	if (error)
-		goto class_dev_reg_err;
-	error = class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
+	error = pci_add_bus(b);
 	if (error)
-		goto class_dev_create_file_err;
+		goto bus_class_reg_err;
 
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(b);
 
-	error = sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
-	if (error)
-		goto sys_create_link_err;
-
-	b->number = b->secondary = bus;
-	b->resource[0] = &ioport_resource;
-	b->resource[1] = &iomem_resource;
-
 	b->subordinate = pci_scan_child_bus(b);
 
 	return b;
 
-sys_create_link_err:
-	class_device_remove_file(&b->class_dev, &class_device_attr_cpuaffinity);
-class_dev_create_file_err:
-	class_device_unregister(&b->class_dev);
-class_dev_reg_err:
+bus_class_reg_err:
 	device_unregister(dev);
 dev_reg_err:
 	spin_lock(&pci_bus_lock);


