Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbUKHH2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbUKHH2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKHH2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:28:05 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:31848 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261764AbUKHH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:26:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Add drvctl handler to PCI bus
Date: Mon, 8 Nov 2004 02:25:56 -0500
User-Agent: KMail/1.6.2
Cc: Tejun Heo <tj@home-tj.org>, Greg KH <greg@kroah.com>,
       rusty@rustcorp.com.au, mochel@osdl.org
References: <20041104074330.GG25567@home-tj.org> <200411080223.07639.dtor_core@ameritech.net> <200411080223.56536.dtor_core@ameritech.net>
In-Reply-To: <200411080223.56536.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411080225.58532.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1962, 2004-11-08 02:06:19-05:00, dtor_core@ameritech.net
  PCI: Add devctl method to PCI bus. The following commands are
       available: "detach", "attach <driver>", and "rescan".
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 pci-driver.c |   58 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 44 insertions(+), 14 deletions(-)


===================================================================



diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-11-08 02:20:22 -05:00
+++ b/drivers/pci/pci-driver.c	2004-11-08 02:20:22 -05:00
@@ -186,7 +186,7 @@
  *                    PCI device id structure
  * @ids: array of PCI device id structures to search in
  * @dev: the PCI device structure to match against
- * 
+ *
  * Used by a driver to check whether a PCI device present in the
  * system is in its list of supported devices.Returns the matching
  * pci_device_id structure or %NULL if there is no match.
@@ -204,12 +204,12 @@
 
 /**
  * pci_device_probe_static()
- * 
+ *
  * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
  */
 static int
 pci_device_probe_static(struct pci_driver *drv, struct pci_dev *pci_dev)
-{		   
+{
 	int error = -ENODEV;
 	const struct pci_device_id *id;
 
@@ -227,13 +227,13 @@
 
 /**
  * __pci_device_probe()
- * 
+ *
  * returns 0  on success, else error.
  * side-effect: pci_dev->driver is set to drv when drv claims pci_dev.
  */
 static int
 __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
-{		   
+{
 	int error = 0;
 
 	if (!pci_dev->driver && drv->probe) {
@@ -314,7 +314,7 @@
 }
 
 
-/* 
+/*
  * Default resume method for devices that have no driver provided resume,
  * or not even a driver at all.
  */
@@ -394,10 +394,10 @@
 /**
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
- * 
+ *
  * Adds the driver structure to the list of registered drivers.
- * Returns a negative value on error, otherwise 0. 
- * If no error occured, the driver remains registered even if 
+ * Returns a negative value on error, otherwise 0.
+ * If no error occured, the driver remains registered even if
  * no device was claimed during registration.
  */
 int pci_register_driver(struct pci_driver *drv)
@@ -425,7 +425,7 @@
 /**
  * pci_unregister_driver - unregister a pci driver
  * @drv: the driver structure to unregister
- * 
+ *
  * Deletes the driver structure from the list of registered PCI drivers,
  * gives it a chance to clean up by calling its remove() function for
  * each device it was responsible for, and marks those devices as
@@ -447,7 +447,7 @@
  * pci_dev_driver - get the pci_driver of a device
  * @dev: the device to query
  *
- * Returns the appropriate pci_driver structure or %NULL if there is no 
+ * Returns the appropriate pci_driver structure or %NULL if there is no
  * registered driver for the device.
  */
 struct pci_driver *
@@ -457,7 +457,7 @@
 		return dev->driver;
 	else {
 		int i;
-		for(i=0; i<=PCI_ROM_RESOURCE; i++)
+		for(i = 0; i <= PCI_ROM_RESOURCE; i++)
 			if (dev->resource[i].flags & IORESOURCE_BUSY)
 				return &pci_compat_driver;
 	}
@@ -468,12 +468,12 @@
  * pci_bus_match - Tell if a PCI device structure has a matching PCI device id structure
  * @ids: array of PCI device id structures to search in
  * @dev: the PCI device structure to match against
- * 
+ *
  * Used by a driver to check whether a PCI device present in the
  * system is in its list of supported devices.Returns the matching
  * pci_device_id structure or %NULL if there is no match.
  */
-static int pci_bus_match(struct device * dev, struct device_driver * drv) 
+static int pci_bus_match(struct device * dev, struct device_driver * drv)
 {
 	const struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * pci_drv = to_pci_driver(drv);
@@ -490,6 +490,35 @@
 	return pci_bus_match_dynids(pci_dev, pci_drv);
 }
 
+/*
+ * This is PCI bus's drvctl method that handles manual device binding.
+ */
+static int pci_rebind_driver(struct device *dev, const char *action,
+			     struct device_driver *drv, char *args)
+{
+	int retval = 0;
+
+	if (!strcmp(action, "detach")) {
+		down_write(&dev->bus->subsys.rwsem);
+		device_release_driver(dev);
+		up_write(&dev->bus->subsys.rwsem);
+	} else if (!strcmp(action, "rescan")) {
+		down_write(&dev->bus->subsys.rwsem);
+		device_release_driver(dev);
+		device_attach(dev);
+		up_write(&dev->bus->subsys.rwsem);
+	} else if (!strcmp(action, "attach") && drv) {
+		down_write(&dev->bus->subsys.rwsem);
+		device_release_driver(dev);
+		driver_probe_device(drv, dev);
+		up_write(&dev->bus->subsys.rwsem);
+	} else {
+		retval = -EINVAL;
+	}
+
+	return retval;
+}
+
 /**
  * pci_dev_get - increments the reference count of the pci device structure
  * @dev: the device being referenced
@@ -534,6 +563,7 @@
 	.name		= "pci",
 	.match		= pci_bus_match,
 	.hotplug	= pci_hotplug,
+	.drvctl		= pci_rebind_driver,
 	.suspend	= pci_device_suspend,
 	.resume		= pci_device_resume,
 	.dev_attrs	= pci_dev_attrs,
