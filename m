Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUFVSHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUFVSHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUFVSEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:04:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:43189 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265063AbUFVRn1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:27 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261101948@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:50 -0700
Message-Id: <1087926110190@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.52, 2004/06/04 13:24:29-07:00, greg@kroah.com

PCI: convert to using dev_attrs for all PCI devices.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-driver.c |    1 +
 drivers/pci/pci-sysfs.c  |   33 +++++++++++++++------------------
 drivers/pci/pci.h        |    1 +
 3 files changed, 17 insertions(+), 18 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Tue Jun 22 09:48:25 2004
+++ b/drivers/pci/pci-driver.c	Tue Jun 22 09:48:25 2004
@@ -539,6 +539,7 @@
 	.hotplug	= pci_hotplug,
 	.suspend	= pci_device_suspend,
 	.resume		= pci_device_resume,
+	.dev_attrs	= pci_dev_attrs,
 };
 
 static int __init pci_driver_init(void)
diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	Tue Jun 22 09:48:25 2004
+++ b/drivers/pci/pci-sysfs.c	Tue Jun 22 09:48:25 2004
@@ -23,14 +23,13 @@
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
-show_##field (struct device *dev, char *buf)				\
+field##_show(struct device *dev, char *buf)				\
 {									\
 	struct pci_dev *pdev;						\
 									\
 	pdev = to_pci_dev (dev);					\
 	return sprintf (buf, format_string, pdev->field);		\
-}									\
-static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+}
 
 pci_config_attr(vendor, "0x%04x\n");
 pci_config_attr(device, "0x%04x\n");
@@ -41,7 +40,7 @@
 
 /* show resources */
 static ssize_t
-pci_show_resources(struct device * dev, char * buf)
+resource_show(struct device * dev, char * buf)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	char * str = buf;
@@ -60,7 +59,16 @@
 	return (str - buf);
 }
 
-static DEVICE_ATTR(resource,S_IRUGO,pci_show_resources,NULL);
+struct device_attribute pci_dev_attrs[] = {
+	__ATTR_RO(resource),
+	__ATTR_RO(vendor),
+	__ATTR_RO(device),
+	__ATTR_RO(subsystem_vendor),
+	__ATTR_RO(subsystem_device),
+	__ATTR_RO(class),
+	__ATTR_RO(irq),
+	__ATTR_NULL,
+};
 
 static ssize_t
 pci_read_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
@@ -180,21 +188,10 @@
 
 void pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
-	struct device *dev = &pdev->dev;
-
-	/* current configuration's attributes */
-	device_create_file (dev, &dev_attr_vendor);
-	device_create_file (dev, &dev_attr_device);
-	device_create_file (dev, &dev_attr_subsystem_vendor);
-	device_create_file (dev, &dev_attr_subsystem_device);
-	device_create_file (dev, &dev_attr_class);
-	device_create_file (dev, &dev_attr_irq);
-	device_create_file (dev, &dev_attr_resource);
-
 	if (pdev->cfg_size < 4096)
-		sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
+		sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
-		sysfs_create_bin_file(&dev->kobj, &pcie_config_attr);
+		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Tue Jun 22 09:48:25 2004
+++ b/drivers/pci/pci.h	Tue Jun 22 09:48:25 2004
@@ -62,3 +62,4 @@
 extern spinlock_t pci_bus_lock;
 
 extern int pciehp_msi_quirk;
+extern struct device_attribute pci_dev_attrs[];

