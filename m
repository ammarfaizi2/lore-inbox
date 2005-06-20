Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVFTXvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVFTXvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVFTXu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:50:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:58852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261787AbVFTXAD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:03 -0400
Cc: tlnguyen@snoqualmie.dp.intel.com
Subject: [PATCH] use device_for_each_child() to properly access child devices.
In-Reply-To: <11193083663947@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <11193083661546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] use device_for_each_child() to properly access child devices.

On Friday, March 25, 2005 8:47 PM Greg KH wrote:
>Here's a fix for pci express.  For some reason I don't think they are
>using the driver model properly here, but I could be wrong...

Thanks for making the changes. However, changes in functions:
void pcie_port_device_remove(struct pci_dev *dev) and
static int remove_iter(struct device *dev, void *data)
are not correct. Please use the patch, which is based on kernel
2.6.12-rc1, below for a fix for these.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d0e2b4a0a9dd3eed71b56c47268bf4e40cff6d0f
tree 567d849ed870807599d439e459e1bbe3cfec2877
parent 64360322ab3330d4881166380ad43a1eec2f123d
author long <tlnguyen@snoqualmie.dp.intel.com> Tue, 29 Mar 2005 13:36:43 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:26 -0700

 drivers/pci/pcie/portdrv_core.c |  139 ++++++++++++++++++---------------------
 1 files changed, 65 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -232,19 +232,16 @@ static void pcie_device_init(struct pci_
 	/* Initialize generic device interface */
 	device = &dev->device;
 	memset(device, 0, sizeof(struct device));
-	INIT_LIST_HEAD(&device->node);
-	INIT_LIST_HEAD(&device->children);
-	INIT_LIST_HEAD(&device->bus_list);
 	device->bus = &pcie_port_bus_type;
 	device->driver = NULL;
-	device->driver_data = NULL; 
+	device->driver_data = NULL;
 	device->release = release_pcie_device;	/* callback to free pcie dev */
-	sprintf(&device->bus_id[0], "pcie%02x", 
+	sprintf(&device->bus_id[0], "pcie%02x",
 		get_descriptor_id(port_type, service_type));
 	device->parent = &parent->dev;
 }
 
-static struct pcie_device* alloc_pcie_device(struct pci_dev *parent, 
+static struct pcie_device* alloc_pcie_device(struct pci_dev *parent,
 	int port_type, int service_type, int irq, int irq_mode)
 {
 	struct pcie_device *device;
@@ -270,9 +267,9 @@ int pcie_port_device_probe(struct pci_de
 	pci_read_config_word(dev, pos + PCIE_CAPABILITIES_REG, &reg);
 	type = (reg >> 4) & PORT_TYPE_MASK;
 	if (	type == PCIE_RC_PORT || type == PCIE_SW_UPSTREAM_PORT ||
-		type == PCIE_SW_DOWNSTREAM_PORT )  
+		type == PCIE_SW_DOWNSTREAM_PORT )
 		return 0;
- 
+
 	return -ENODEV;
 }
 
@@ -283,8 +280,8 @@ int pcie_port_device_register(struct pci
 	u16 reg16;
 
 	/* Get port type */
-	pci_read_config_word(dev, 
-		pci_find_capability(dev, PCI_CAP_ID_EXP) + 
+	pci_read_config_word(dev,
+		pci_find_capability(dev, PCI_CAP_ID_EXP) +
 		PCIE_CAPABILITIES_REG, &reg16);
 	type = (reg16 >> 4) & PORT_TYPE_MASK;
 
@@ -299,11 +296,11 @@ int pcie_port_device_register(struct pci
 		if (capabilities & (1 << i)) {
 			child = alloc_pcie_device(
 				dev, 		/* parent */
-				type,		/* port type */ 
+				type,		/* port type */
 				i,		/* service type */
 				vectors[i],	/* irq */
 				irq_mode	/* interrupt mode */);
-			if (child) { 
+			if (child) {
 				status = device_register(&child->device);
 				if (status) {
 					kfree(child);
@@ -317,84 +314,78 @@ int pcie_port_device_register(struct pci
 }
 
 #ifdef CONFIG_PM
-int pcie_port_device_suspend(struct pci_dev *dev, pm_message_t state)
+static int suspend_iter(struct device *dev, void *data)
 {
-	struct list_head 		*head, *tmp;
-	struct device 			*parent, *child;
-	struct device_driver 		*driver;
 	struct pcie_port_service_driver *service_driver;
+	u32 state = (u32)data;
 
-	parent = &dev->dev;
-	head = &parent->children;
-	tmp = head->next;
-	while (head != tmp) {
-		child = container_of(tmp, struct device, node);
-		tmp = tmp->next;
-		if (child->bus != &pcie_port_bus_type)
-			continue;
-		driver = child->driver;
-		if (!driver)
-			continue;
-		service_driver = to_service_driver(driver);
-		if (service_driver->suspend)  
-			service_driver->suspend(to_pcie_device(child), state);
-	}
-	return 0; 
+ 	if ((dev->bus == &pcie_port_bus_type) &&
+ 	    (dev->driver)) {
+ 		service_driver = to_service_driver(dev->driver);
+ 		if (service_driver->suspend)
+ 			service_driver->suspend(to_pcie_device(dev), state);
+  	}
+	return 0;
+}
+
+int pcie_port_device_suspend(struct pci_dev *dev, u32 state)
+{
+	device_for_each_child(&dev->dev, (void *)state, suspend_iter);
+	return 0;
 }
 
-int pcie_port_device_resume(struct pci_dev *dev) 
-{ 
-	struct list_head 		*head, *tmp;
-	struct device 			*parent, *child;
-	struct device_driver 		*driver;
+static int resume_iter(struct device *dev, void *data)
+{
 	struct pcie_port_service_driver *service_driver;
 
-	parent = &dev->dev;
-	head = &parent->children;
-	tmp = head->next;
-	while (head != tmp) {
-		child = container_of(tmp, struct device, node);
-		tmp = tmp->next;
-		if (child->bus != &pcie_port_bus_type)
-			continue;
-		driver = child->driver;
-		if (!driver)
-			continue;
-		service_driver = to_service_driver(driver);
-		if (service_driver->resume)  
-			service_driver->resume(to_pcie_device(child));
+	if ((dev->bus == &pcie_port_bus_type) &&
+	    (dev->driver)) {
+		service_driver = to_service_driver(dev->driver);
+		if (service_driver->resume)
+			service_driver->resume(to_pcie_device(dev));
 	}
-	return 0; 
+	return 0;
+}
 
+int pcie_port_device_resume(struct pci_dev *dev)
+{
+	device_for_each_child(&dev->dev, NULL, resume_iter);
+	return 0;
 }
 #endif
 
-void pcie_port_device_remove(struct pci_dev *dev)
+static int remove_iter(struct device *dev, void *data)
 {
-	struct list_head 		*head, *tmp;
-	struct device 			*parent, *child;
-	struct device_driver 		*driver;
 	struct pcie_port_service_driver *service_driver;
-	int interrupt_mode = PCIE_PORT_INTx_MODE;
 
-	parent = &dev->dev;
-	head = &parent->children;
-	tmp = head->next;
-	while (head != tmp) {
-		child = container_of(tmp, struct device, node);
-		tmp = tmp->next;
-		if (child->bus != &pcie_port_bus_type)
-			continue;
-		driver = child->driver;
-		if (driver) { 
-			service_driver = to_service_driver(driver);
-			if (service_driver->remove)  
-				service_driver->remove(to_pcie_device(child));
+	if (dev->bus == &pcie_port_bus_type) {
+		if (dev->driver) {
+			service_driver = to_service_driver(dev->driver);
+			if (service_driver->remove)
+				service_driver->remove(to_pcie_device(dev));
 		}
-		interrupt_mode = (to_pcie_device(child))->interrupt_mode;
-		put_device(child);
-		device_unregister(child);
+		*(unsigned long*)data = (unsigned long)dev;
+		return 1;
 	}
+	return 0;
+}
+
+void pcie_port_device_remove(struct pci_dev *dev)
+{
+	struct device *device;
+	unsigned long device_addr;
+	int interrupt_mode = PCIE_PORT_INTx_MODE;
+	int status;
+
+	do {
+		status = device_for_each_child(&dev->dev, &device_addr, remove_iter);
+		if (status) {
+			device = (struct device*)device_addr;
+			interrupt_mode = (to_pcie_device(device))->interrupt_mode;
+			put_device(device);
+			device_unregister(device);
+		}
+	} while (status);
 	/* Switch to INTx by default if MSI enabled */
 	if (interrupt_mode == PCIE_PORT_MSIX_MODE)
 		pci_disable_msix(dev);
@@ -423,7 +414,7 @@ int pcie_port_service_register(struct pc
 	new->driver.resume = pcie_port_resume_service;
 
 	return driver_register(&new->driver);
-} 
+}
 
 void pcie_port_service_unregister(struct pcie_port_service_driver *new)
 {

