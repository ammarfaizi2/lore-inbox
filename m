Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUITQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUITQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUITQaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:30:15 -0400
Received: from linares.terra.com.br ([200.154.55.228]:22678 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S266798AbUITQ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:29:05 -0400
Date: Mon, 20 Sep 2004 12:33:26 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - adds missing checks in drivers/pci/probe.c.
Message-Id: <20040920123326.753365b9.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Greg,

 I noticed drivers/pci/probe.c::pci_scan_bus_parented() has some functions which
the return value is not checked.

 The patch bellow adds the check for device_register(), class_device_register(),
class_device_create_file() and sysfs_create_link().

(hope the error label names are not too ugly).


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/pci/probe.c |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/drivers/pci/probe.c a~/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2004-09-17 19:18:21.000000000 -0300
+++ a~/drivers/pci/probe.c	2004-09-19 22:06:30.000000000 -0300
@@ -750,6 +750,7 @@ unsigned int __devinit pci_do_scan_bus(s
 
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
+	int error;
 	struct pci_bus *b;
 	struct device *dev;
 
@@ -769,9 +770,7 @@ struct pci_bus * __devinit pci_scan_bus_
 	if (pci_find_bus(pci_domain_nr(b), bus)) {
 		/* If we already got to this bus through a different bridge, ignore it */
 		DBG("PCI: Bus %02x already known\n", bus);
-		kfree(dev);
-		kfree(b);
-		return NULL;
+		goto err_out;
 	}
 	list_add_tail(&b->node, &pci_root_buses);
 
@@ -779,15 +778,23 @@ struct pci_bus * __devinit pci_scan_bus_
 	dev->parent = parent;
 	dev->release = pci_release_bus_bridge_dev;
 	sprintf(dev->bus_id, "pci%04x:%02x", pci_domain_nr(b), bus);
-	device_register(dev);
+	error = device_register(dev);
+	if (error)
+		goto dev_reg_err;
 	b->bridge = get_device(dev);
 
 	b->class_dev.class = &pcibus_class;
 	sprintf(b->class_dev.class_id, "%04x:%02x", pci_domain_nr(b), bus);
-	class_device_register(&b->class_dev);
-	class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
-
-	sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
+	error = class_device_register(&b->class_dev);
+	if (error)
+		goto class_dev_reg_err;
+	error = class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
+	if (error)
+		goto class_dev_create_file_err;
+
+	error = sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
+	if (error)
+		goto sys_create_link_err;
 
 	b->number = b->secondary = bus;
 	b->resource[0] = &ioport_resource;
@@ -798,6 +805,19 @@ struct pci_bus * __devinit pci_scan_bus_
 	pci_bus_add_devices(b);
 
 	return b;
+
+sys_create_link_err:
+	class_device_remove_file(&b->class_dev, &class_device_attr_cpuaffinity);
+class_dev_create_file_err:
+	class_device_unregister(&b->class_dev);
+class_dev_reg_err:
+	device_unregister(dev);
+dev_reg_err:
+	list_del(&b->node);
+err_out:
+	kfree(dev);
+	kfree(b);
+	return NULL;
 }
 EXPORT_SYMBOL(pci_scan_bus_parented);
 
