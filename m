Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263212AbVBCTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbVBCTTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbVBCRs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:48:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:20904 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263078AbVBCRl0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:26 -0500
Cc: tlnguyen@snoqualmie.dp.intel.com
Subject: [PATCH] PCI: change sysfs representation of PCI-E devices
In-Reply-To: <11074524211623@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:40:21 -0800
Message-Id: <1107452421469@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2046, 2005/02/03 00:42:00-08:00, tlnguyen@snoqualmie.dp.intel.com

[PATCH] PCI: change sysfs representation of PCI-E devices

Before changes:

The patch makes the parent of the device pointing to the pci_dev
structure. The parents portX devices are in /sys/devices which
should be removed based on your suggestions. Below is /sys/devices
before any changes made.

/sys/devices
	|
	__ ide0
	|
	__ pci0000:00
	|
	__ pnp0
	|
	__ port1
	|	|
	|  	__ port1.00
	|	|
	|	__ port1.01
	|	.
	|	.
	|	.
	|
	__ port2
	|
 	__ port3
	|
	__ system

After changes:

The parents portX devices are no longer necessary because port1.00
and port1.01 devices shoud have the parent of the pci_dev structure
(based on your suggestion). The patch does the following changes:

- remove code creating and handling the parent portX devices.
- rename portX.YZ to pcieYZ (for example port1.00 renamed to pcie00)
  since portX is no longer needed.
- make pcieYZ have the parent of the pci_dev structure.

Below is /sys/devices after changes made to the patch.

/sys/devices
	|
	__ ide0
	|
	__ pci0000:00
	|	|
	|	__ 0000:00:00.0
	|	|
	|	__ 0000:00:04.0
	|	|	|
	|	.	__ class
	|	.	|
	|	.	__ pcie00
	|		|
	|		__ pcie01
	|		.
	|		.
	|		.
	|
	__ platform
	|
	__ pnp0
	|
	__ system


Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pcie/portdrv.h      |    7 +-
 drivers/pci/pcie/portdrv_bus.c  |   15 -----
 drivers/pci/pcie/portdrv_core.c |  119 ++++++++++++++++------------------------
 drivers/pci/pcie/portdrv_pci.c  |   22 +------
 4 files changed, 58 insertions(+), 105 deletions(-)


diff -Nru a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
--- a/drivers/pci/pcie/portdrv.h	2005-02-03 09:28:24 -08:00
+++ b/drivers/pci/pcie/portdrv.h	2005-02-03 09:28:24 -08:00
@@ -28,14 +28,13 @@
 #define get_descriptor_id(type, service) (((type - 4) << 4) | service)
 
 extern struct bus_type pcie_port_bus_type;
-extern struct device_driver pcieport_generic_driver;
 extern int pcie_port_device_probe(struct pci_dev *dev);
 extern int pcie_port_device_register(struct pci_dev *dev);
 #ifdef CONFIG_PM
-extern int pcie_port_device_suspend(struct pcie_device *dev, u32 state);
-extern int pcie_port_device_resume(struct pcie_device *dev);
+extern int pcie_port_device_suspend(struct pci_dev *dev, u32 state);
+extern int pcie_port_device_resume(struct pci_dev *dev);
 #endif
-extern void pcie_port_device_remove(struct pcie_device *dev);
+extern void pcie_port_device_remove(struct pci_dev *dev);
 extern void pcie_port_bus_register(void);
 extern void pcie_port_bus_unregister(void);
 
diff -Nru a/drivers/pci/pcie/portdrv_bus.c b/drivers/pci/pcie/portdrv_bus.c
--- a/drivers/pci/pcie/portdrv_bus.c	2005-02-03 09:28:24 -08:00
+++ b/drivers/pci/pcie/portdrv_bus.c	2005-02-03 09:28:24 -08:00
@@ -14,8 +14,6 @@
 
 #include <linux/pcieport_if.h>
 
-static int generic_probe (struct device *dev) {	return 0;}
-static int generic_remove (struct device *dev) { return 0;}
 static int pcie_port_bus_match(struct device *dev, struct device_driver *drv);
 static int pcie_port_bus_suspend(struct device *dev, u32 state);
 static int pcie_port_bus_resume(struct device *dev);
@@ -27,23 +25,14 @@
 	.resume		= pcie_port_bus_resume, 
 };
 
-struct device_driver pcieport_generic_driver = {
-	.name =	"pcieport",
-	.bus = &pcie_port_bus_type,
-	.probe = generic_probe,
-	.remove = generic_remove,
-};
-
 static int pcie_port_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
 
-	if (	drv->bus != &pcie_port_bus_type || 
-		dev->bus != &pcie_port_bus_type	||
-		drv == &pcieport_generic_driver) {
+	if (drv->bus != &pcie_port_bus_type || dev->bus != &pcie_port_bus_type)
 		return 0;
-	}
+	
 	pciedev = to_pcie_device(dev);
 	driver = to_service_driver(drv);
 	if (   (driver->id_table->vendor != PCI_ANY_ID && 
diff -Nru a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
--- a/drivers/pci/pcie/portdrv_core.c	2005-02-03 09:28:24 -08:00
+++ b/drivers/pci/pcie/portdrv_core.c	2005-02-03 09:28:24 -08:00
@@ -17,8 +17,6 @@
 
 extern int pcie_mch_quirk;	/* MSI-quirk Indicator */
 
-extern struct device_driver pcieport_generic_driver;
-
 static int pcie_port_probe_service(struct device *dev)
 {
 	struct pcie_device *pciedev;
@@ -103,6 +101,7 @@
  */
 static void release_pcie_device(struct device *dev)
 {
+	printk(KERN_DEBUG "Free Port Service[%s]\n", dev->bus_id);
 	kfree(to_pcie_device(dev));			
 }
 
@@ -217,18 +216,18 @@
 	return services;
 }
 
-static void pcie_device_init(struct pcie_device *parent, 
-			struct pcie_device *dev, 
-			int port_type, int service_type)
+static void pcie_device_init(struct pci_dev *parent, struct pcie_device *dev, 
+	int port_type, int service_type, int irq, int irq_mode)
 {
 	struct device *device;
 
-	if (parent) {
-		dev->id.vendor = parent->port->vendor;
-		dev->id.device = parent->port->device;
-		dev->id.port_type = port_type;
-		dev->id.service_type = (1 << service_type);
-	}
+	dev->port = parent;
+	dev->interrupt_mode = irq_mode;
+	dev->irq = irq;
+	dev->id.vendor = parent->vendor;
+	dev->id.device = parent->device;
+	dev->id.port_type = port_type;
+	dev->id.service_type = (1 << service_type);
 
 	/* Initialize generic device interface */
 	device = &dev->device;
@@ -240,35 +239,23 @@
 	device->driver = NULL;
 	device->driver_data = NULL; 
 	device->release = release_pcie_device;	/* callback to free pcie dev */
-	sprintf(&device->bus_id[0], "%s.%02x", parent->device.bus_id, 
-			get_descriptor_id(port_type, service_type));
-	device->parent = ((parent == NULL) ? NULL : &parent->device);
+	sprintf(&device->bus_id[0], "pcie%02x", 
+		get_descriptor_id(port_type, service_type));
+	device->parent = &parent->dev;
 }
 
-static struct pcie_device* alloc_pcie_device(
-	struct pcie_device *parent, struct pci_dev *bridge, 
+static struct pcie_device* alloc_pcie_device(struct pci_dev *parent, 
 	int port_type, int service_type, int irq, int irq_mode)
 {
 	struct pcie_device *device;
-	static int NR_PORTS = 0;
 
 	device = kmalloc(sizeof(struct pcie_device), GFP_KERNEL);
 	if (!device)
 		return NULL;
 
 	memset(device, 0, sizeof(struct pcie_device));
-	device->port = bridge;
-	device->interrupt_mode = irq_mode;
-	device->irq = irq;
-	if (!parent) {
-		pcie_device_init(NULL, device, port_type, service_type);
-		NR_PORTS++;
-		device->device.driver = &pcieport_generic_driver;
-		sprintf(&device->device.bus_id[0], "port%d", NR_PORTS); 
-	} else { 
-		pcie_device_init(parent, device, port_type, service_type);
-	}
-	printk(KERN_DEBUG "Allocate Port Device[%s]\n", device->device.bus_id);
+	pcie_device_init(parent, device, port_type, service_type, irq,irq_mode);
+	printk(KERN_DEBUG "Allocate Port Service[%s]\n", device->device.bus_id);
 	return device;
 }
 
@@ -291,7 +278,6 @@
 
 int pcie_port_device_register(struct pci_dev *dev)
 {
-	struct pcie_device *parent;
 	int status, type, capabilities, irq_mode, i;
 	int vectors[PCIE_PORT_DEVICE_MAXSERVICES];
 	u16 reg16;
@@ -306,27 +292,13 @@
 	capabilities = get_port_device_capability(dev);
 	irq_mode = assign_interrupt_mode(dev, vectors, capabilities);
 
-	/* Allocate parent */
-	parent = alloc_pcie_device(NULL, dev, type, 0, dev->irq, irq_mode);
-	if (!parent) 
-		return -ENOMEM;
-	
-	status = device_register(&parent->device);
-	if (status) {
-		kfree(parent);
-		return status;
-	}
-	get_device(&parent->device);
-	pci_set_drvdata(dev, parent);	
-
 	/* Allocate child services if any */
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
 		struct pcie_device *child;
 
 		if (capabilities & (1 << i)) {
 			child = alloc_pcie_device(
-				parent,		/* parent */ 
-				dev, 		/* Root/Upstream/Downstream */
+				dev, 		/* parent */
 				type,		/* port type */ 
 				i,		/* service type */
 				vectors[i],	/* irq */
@@ -345,17 +317,21 @@
 }
 
 #ifdef CONFIG_PM
-int pcie_port_device_suspend(struct pcie_device *dev, u32 state)
+int pcie_port_device_suspend(struct pci_dev *dev, u32 state)
 {
-	struct list_head 		*head;
+	struct list_head 		*head, *tmp;
 	struct device 			*parent, *child;
 	struct device_driver 		*driver;
 	struct pcie_port_service_driver *service_driver;
 
-	parent = &dev->device;
+	parent = &dev->dev;
 	head = &parent->children;
-	while (!list_empty(head)) {
-		child = container_of(head->next, struct device, node);
+	tmp = head->next;
+	while (head != tmp) {
+		child = container_of(tmp, struct device, node);
+		tmp = tmp->next;
+		if (child->bus != &pcie_port_bus_type)
+			continue;
 		driver = child->driver;
 		if (!driver)
 			continue;
@@ -366,17 +342,21 @@
 	return 0; 
 }
 
-int pcie_port_device_resume(struct pcie_device *dev) 
+int pcie_port_device_resume(struct pci_dev *dev) 
 { 
-	struct list_head 		*head;
+	struct list_head 		*head, *tmp;
 	struct device 			*parent, *child;
 	struct device_driver 		*driver;
 	struct pcie_port_service_driver *service_driver;
 
-	parent = &dev->device;
+	parent = &dev->dev;
 	head = &parent->children;
-	while (!list_empty(head)) {
-		child = container_of(head->next, struct device, node);
+	tmp = head->next;
+	while (head != tmp) {
+		child = container_of(tmp, struct device, node);
+		tmp = tmp->next;
+		if (child->bus != &pcie_port_bus_type)
+			continue;
 		driver = child->driver;
 		if (!driver)
 			continue;
@@ -389,45 +369,46 @@
 }
 #endif
 
-void pcie_port_device_remove(struct pcie_device *dev)
+void pcie_port_device_remove(struct pci_dev *dev)
 {
-	struct list_head 		*head;
+	struct list_head 		*head, *tmp;
 	struct device 			*parent, *child;
 	struct device_driver 		*driver;
 	struct pcie_port_service_driver *service_driver;
+	int interrupt_mode = PCIE_PORT_INTx_MODE;
 
-	parent = &dev->device;
+	parent = &dev->dev;
 	head = &parent->children;
-	while (!list_empty(head)) {
-		child = container_of(head->next, struct device, node);
+	tmp = head->next;
+	while (head != tmp) {
+		child = container_of(tmp, struct device, node);
+		tmp = tmp->next;
+		if (child->bus != &pcie_port_bus_type)
+			continue;
 		driver = child->driver;
 		if (driver) { 
 			service_driver = to_service_driver(driver);
 			if (service_driver->remove)  
 				service_driver->remove(to_pcie_device(child));
 		}
+		interrupt_mode = (to_pcie_device(child))->interrupt_mode;
 		put_device(child);
 		device_unregister(child);
 	}
-
 	/* Switch to INTx by default if MSI enabled */
-	if (dev->interrupt_mode == PCIE_PORT_MSIX_MODE)
-		pci_disable_msix(dev->port);
-	else if (dev->interrupt_mode == PCIE_PORT_MSI_MODE)
-		pci_disable_msi(dev->port);
-	put_device(parent);
-	device_unregister(parent);
+	if (interrupt_mode == PCIE_PORT_MSIX_MODE)
+		pci_disable_msix(dev);
+	else if (interrupt_mode == PCIE_PORT_MSI_MODE)
+		pci_disable_msi(dev);
 }
 
 void pcie_port_bus_register(void)
 {
 	bus_register(&pcie_port_bus_type);
-	driver_register(&pcieport_generic_driver);
 }
 
 void pcie_port_bus_unregister(void)
 {
-	driver_unregister(&pcieport_generic_driver);
 	bus_unregister(&pcie_port_bus_type);
 }
 
diff -Nru a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
--- a/drivers/pci/pcie/portdrv_pci.c	2005-02-03 09:28:24 -08:00
+++ b/drivers/pci/pcie/portdrv_pci.c	2005-02-03 09:28:24 -08:00
@@ -63,34 +63,18 @@
 
 static void pcie_portdrv_remove (struct pci_dev *dev)
 {
-	struct pcie_device *pciedev;
-
-      	pciedev = (struct pcie_device *)pci_get_drvdata(dev);
-	if (pciedev) {
-		pcie_port_device_remove(pciedev);
-		pci_set_drvdata(dev, NULL); 
-	}
+	pcie_port_device_remove(dev);
 }
 
 #ifdef CONFIG_PM
 static int pcie_portdrv_suspend (struct pci_dev *dev, u32 state)
 {
-	struct pcie_device *pciedev;
-	
-      	pciedev = (struct pcie_device *)pci_get_drvdata(dev);
-	if (pciedev) 
-		pcie_port_device_suspend(pciedev, state);
-	return 0;
+	return pcie_port_device_suspend(dev, state);
 }
 
 static int pcie_portdrv_resume (struct pci_dev *dev)
 {
-	struct pcie_device *pciedev;
-	
-      	pciedev = (struct pcie_device *)pci_get_drvdata(dev);
-	if (pciedev) 
-		pcie_port_device_resume(pciedev);
-	return 0;
+	return pcie_port_device_resume(dev);
 }
 #endif
 

