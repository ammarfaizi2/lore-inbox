Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUJTEpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUJTEpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270145AbUJSXdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:33:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:12170 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270146AbUJSWqe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:34 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225737858@kroah.com>
Date: Tue, 19 Oct 2004 15:42:17 -0700
Message-Id: <10982257371954@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.42, 2004/10/06 13:04:58-07:00, lcapitulino@conectiva.com.br

[PATCH] PCI: add missing checks in drivers/pci/probe.c.

 I noticed drivers/pci/probe.c::pci_scan_bus_parented() has some functions which
the return value is not checked.

 The patch bellow adds the check for device_register(), class_device_register(),
class_device_create_file() and sysfs_create_link().

(hope the error label names are not too ugly).


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2004-10-19 15:23:54 -07:00
+++ b/drivers/pci/probe.c	2004-10-19 15:23:54 -07:00
@@ -750,6 +750,7 @@
 
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
+	int error;
 	struct pci_bus *b;
 	struct device *dev;
 
@@ -769,9 +770,7 @@
 	if (pci_find_bus(pci_domain_nr(b), bus)) {
 		/* If we already got to this bus through a different bridge, ignore it */
 		DBG("PCI: Bus %02x already known\n", bus);
-		kfree(dev);
-		kfree(b);
-		return NULL;
+		goto err_out;
 	}
 	list_add_tail(&b->node, &pci_root_buses);
 
@@ -779,15 +778,23 @@
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
@@ -798,6 +805,19 @@
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
 

