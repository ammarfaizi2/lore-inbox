Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVCZErx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVCZErx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 23:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVCZErx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 23:47:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:38547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261998AbVCZEr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 23:47:27 -0500
Date: Fri, 25 Mar 2005 20:47:21 -0800
From: Greg KH <gregkh@suse.de>
To: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
Subject: Re: [0/12] More Driver Model Locking Changes
Message-ID: <20050326044721.GA19140@kroah.com>
References: <Pine.LNX.4.50.0503242145200.29800-100000@monsoon.he.net> <20050325192024.GA14290@kroah.com> <20050325233952.GA16355@kroah.com> <20050326000309.GB16602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326000309.GB16602@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 04:03:09PM -0800, Greg KH wrote:
> 
> Oh, looks like pci express now has problems too, I'll go hit that one
> next...

Here's a fix for pci express.  For some reason I don't think they are
using the driver model properly here, but I could be wrong...

thanks,

greg k-h

[pcie] use device_for_each_child() to properly access child devices.
  
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
--- a/drivers/pci/pcie/portdrv_core.c	2005-03-25 20:44:04 -08:00
+++ b/drivers/pci/pcie/portdrv_core.c	2005-03-25 20:44:04 -08:00
@@ -232,9 +232,6 @@
 	/* Initialize generic device interface */
 	device = &dev->device;
 	memset(device, 0, sizeof(struct device));
-	INIT_LIST_HEAD(&device->node);
-	INIT_LIST_HEAD(&device->children);
-	INIT_LIST_HEAD(&device->bus_list);
 	device->bus = &pcie_port_bus_type;
 	device->driver = NULL;
 	device->driver_data = NULL; 
@@ -317,84 +314,71 @@
 }
 
 #ifdef CONFIG_PM
-int pcie_port_device_suspend(struct pci_dev *dev, u32 state)
+
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
+	if ((dev->bus == &pcie_port_bus_type) && 
+	    (dev->driver)) {
+		service_driver = to_service_driver(dev->driver);
+		if (service_driver->suspend)
+			service_driver->suspend(to_pcie_device(dev), state);
 	}
+	return 0;
+}
+
+int pcie_port_device_suspend(struct pci_dev *dev, u32 state)
+{
+	device_for_each_child(&dev->dev, (void *)state, suspend_iter);
 	return 0; 
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
+	int *interrupt_mode = data;
 
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
+	if (dev->bus == &pcie_port_bus_type) {
+		if (dev->driver) {
+			service_driver = to_service_driver(dev->driver);
 			if (service_driver->remove)  
-				service_driver->remove(to_pcie_device(child));
+				service_driver->remove(to_pcie_device(dev));
 		}
-		interrupt_mode = (to_pcie_device(child))->interrupt_mode;
-		put_device(child);
-		device_unregister(child);
+		*interrupt_mode = (to_pcie_device(dev))->interrupt_mode;
+		put_device(dev);
+		device_unregister(dev);
 	}
+	return 0;
+}
+
+void pcie_port_device_remove(struct pci_dev *dev)
+{
+	int interrupt_mode = PCIE_PORT_INTx_MODE;
+
+	device_for_each_child(&dev->dev, &interrupt_mode, remove_iter);
+
 	/* Switch to INTx by default if MSI enabled */
 	if (interrupt_mode == PCIE_PORT_MSIX_MODE)
 		pci_disable_msix(dev);
