Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUA3BoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266533AbUA3Bh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:37:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:14812 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266525AbUA3BcJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:09 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263062112@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:47 -0800
Message-Id: <1075426306434@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1512, 2004/01/29 14:28:51-08:00, colpatch@us.ibm.com

[PATCH] PCI: add pci_bus sysfs class

This is needed to show pci bus topology to userspace properly.


 drivers/pci/bus.c   |    2 
 drivers/pci/probe.c |  116 +++++++++++++++++++++++++++++++++++-----------------
 include/linux/pci.h |    6 +-
 3 files changed, 86 insertions(+), 38 deletions(-)


diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Thu Jan 29 17:24:36 2004
+++ b/drivers/pci/bus.c	Thu Jan 29 17:24:36 2004
@@ -116,6 +116,8 @@
 			list_add_tail(&dev->subordinate->node, &dev->bus->children);
 			spin_unlock(&pci_bus_lock);
 			pci_bus_add_devices(dev->subordinate);
+
+			sysfs_create_link(&dev->subordinate->class_dev.kobj, &dev->dev.kobj, "bridge");
 		}
 	}
 }
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Jan 29 17:24:36 2004
+++ b/drivers/pci/probe.c	Thu Jan 29 17:24:36 2004
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/cpumask.h>
 
 #undef DEBUG
 
@@ -25,6 +26,39 @@
 LIST_HEAD(pci_devices);
 
 /*
+ * PCI Bus Class
+ */
+static void release_pcibus_dev(struct class_device *class_dev)
+{
+	struct pci_bus *pci_bus = to_pci_bus(class_dev);
+	if (pci_bus->bridge)
+		put_device(pci_bus->bridge);
+	kfree(pci_bus);
+}
+
+static struct class pcibus_class = {
+	.name		= "pci_bus",
+	.release	= &release_pcibus_dev,
+};
+
+static int __init pcibus_class_init(void)
+{
+	return class_register(&pcibus_class);
+}
+postcore_initcall(pcibus_class_init);
+
+/*
+ * PCI Bus Class Devices
+ */
+static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
+{
+	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
+
+	return sprintf(buf, "%lx\n", (unsigned long)cpumask);
+}
+static CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
+
+/*
  * Translate the low bits of the PCI base
  * to the resource type
  */
@@ -238,37 +272,40 @@
 pci_alloc_child_bus(struct pci_bus *parent, struct pci_dev *bridge, int busnr)
 {
 	struct pci_bus *child;
+	int i;
 
 	/*
 	 * Allocate a new bus, and inherit stuff from the parent..
 	 */
 	child = pci_alloc_bus();
+	if (!child)
+		return NULL;
 
-	if (child) {
-		int i;
-
-		child->self = bridge;
-		child->parent = parent;
-		child->ops = parent->ops;
-		child->sysdata = parent->sysdata;
-		child->dev = &bridge->dev;
+	child->self = bridge;
+	child->parent = parent;
+	child->ops = parent->ops;
+	child->sysdata = parent->sysdata;
+	child->bridge = get_device(&bridge->dev);
+
+	child->class_dev.class = &pcibus_class;
+	sprintf(child->class_dev.class_id, "%04x:%02x", pci_domain_nr(child), busnr);
+	class_device_register(&child->class_dev);
+	class_device_create_file(&child->class_dev, &class_device_attr_cpuaffinity);
 
-		/*
-		 * Set up the primary, secondary and subordinate
-		 * bus numbers.
-		 */
-		child->number = child->secondary = busnr;
-		child->primary = parent->secondary;
-		child->subordinate = 0xff;
-
-		/* Set up default resource pointers and names.. */
-		for (i = 0; i < 4; i++) {
-			child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
-			child->resource[i]->name = child->name;
-		}
-
-		bridge->subordinate = child;
+	/*
+	 * Set up the primary, secondary and subordinate
+	 * bus numbers.
+	 */
+	child->number = child->secondary = busnr;
+	child->primary = parent->secondary;
+	child->subordinate = 0xff;
+
+	/* Set up default resource pointers and names.. */
+	for (i = 0; i < 4; i++) {
+		child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
+		child->resource[i]->name = child->name;
 	}
+	bridge->subordinate = child;
 
 	return child;
 }
@@ -307,18 +344,17 @@
 	    pci_name(dev), buses & 0xffffff, pass);
 
 	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
-		unsigned int cmax;
+		unsigned int cmax, busnr;
 		/*
 		 * Bus already configured by firmware, process it in the first
 		 * pass and just note the configuration.
 		 */
 		if (pass)
 			return max;
-		child = pci_alloc_child_bus(bus, dev, 0);
+		busnr = (buses >> 8) & 0xFF;
+		child = pci_alloc_child_bus(bus, dev, busnr);
 		child->primary = buses & 0xFF;
-		child->secondary = (buses >> 8) & 0xFF;
 		child->subordinate = (buses >> 16) & 0xFF;
-		child->number = child->secondary;
 		cmax = pci_scan_child_bus(child);
 		if (cmax > max) max = cmax;
 	} else {
@@ -508,7 +544,7 @@
 	memset(dev, 0, sizeof(struct pci_dev));
 	dev->bus = bus;
 	dev->sysdata = bus->sysdata;
-	dev->dev.parent = bus->dev;
+	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
 	dev->devfn = devfn;
 	dev->hdr_type = hdr_type & 0x7f;
@@ -635,13 +671,14 @@
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
 	struct pci_bus *b;
+	struct device *dev;
 
 	b = pci_alloc_bus();
 	if (!b)
 		return NULL;
 
-	b->dev = kmalloc(sizeof(*(b->dev)),GFP_KERNEL);
-	if (!b->dev){
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev){
 		kfree(b);
 		return NULL;
 	}
@@ -652,17 +689,24 @@
 	if (pci_find_bus(pci_domain_nr(b), bus)) {
 		/* If we already got to this bus through a different bridge, ignore it */
 		DBG("PCI: Bus %02x already known\n", bus);
-		kfree(b->dev);
+		kfree(dev);
 		kfree(b);
 		return NULL;
 	}
-
 	list_add_tail(&b->node, &pci_root_buses);
 
-	memset(b->dev,0,sizeof(*(b->dev)));
-	b->dev->parent = parent;
-	sprintf(b->dev->bus_id,"pci%04x:%02x", pci_domain_nr(b), bus);
-	device_register(b->dev);
+	memset(dev, 0, sizeof(*dev));
+	dev->parent = parent;
+	sprintf(dev->bus_id, "pci%04x:%02x", pci_domain_nr(b), bus);
+	device_register(dev);
+	b->bridge = get_device(dev);
+
+	b->class_dev.class = &pcibus_class;
+	sprintf(b->class_dev.class_id, "%04x:%02x", pci_domain_nr(b), bus);
+	class_device_register(&b->class_dev);
+	class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
+
+	sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
 
 	b->number = b->secondary = bus;
 	b->resource[0] = &ioport_resource;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jan 29 17:24:36 2004
+++ b/include/linux/pci.h	Thu Jan 29 17:24:36 2004
@@ -473,10 +473,12 @@
 
 	char		name[48];
 
-	struct	device	* dev;
+	struct device		*bridge;
+	struct class_device	class_dev;
 };
 
-#define pci_bus_b(n) list_entry(n, struct pci_bus, node)
+#define pci_bus_b(n)	list_entry(n, struct pci_bus, node)
+#define to_pci_bus(n)	container_of(n, struct pci_bus, class_dev)
 
 /*
  * Error values that may be returned by PCI functions.

