Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTE2UE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTE2UE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:04:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30621 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262706AbTE2UEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:04:15 -0400
Subject: [PATCH] pci bridge class code
From: Mark Haverkamp <markh@osdl.org>
To: Pat Mochel <mochel@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 May 2003 13:17:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds pci-pci bridge driver model class code.  Entries appear in 
/sys/class/pci_bridge.


 
 Makefile     |    2 
 pci-bridge.c |  205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 1 deletion(-)

===== drivers/pci/Makefile 1.28 vs edited =====
--- 1.28/drivers/pci/Makefile	Mon May  5 10:58:50 2003
+++ edited/drivers/pci/Makefile	Thu May 29 10:32:28 2003
@@ -4,7 +4,7 @@
 
 obj-y		+= access.o bus.o probe.o pci.o pool.o quirks.o \
 			names.o pci-driver.o search.o hotplug.o \
-			pci-sysfs.o
+			pci-sysfs.o pci-bridge.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
===== drivers/pci/pci-bridge.c 1.1 vs edited =====
--- 1.1/drivers/pci/pci-bridge.c	Thu May 29 11:00:38 2003
+++ edited/drivers/pci/pci-bridge.c	Thu May 29 12:57:13 2003
@@ -0,0 +1,205 @@
+/*
+ * 	drivers/pci/pci-bridge.c
+ *
+ * 	Copyright (c) 2003 Mark Haverkamp <markh@osdl.org>
+ *
+ * 	pci bridge driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ * 	
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+static int __devinit pci_bridge_probe(struct pci_dev *pci,
+					const struct pci_device_id *pci_id);
+static void  __devexit pci_bridge_remove(struct pci_dev *pci);
+
+static void pci_bridge_create_sysfs_files(struct device *device);
+
+static struct class pci_bridge_class = {
+	.name		= "pci_bridge",
+};
+
+static struct class_device class_dev_data;
+
+
+static struct pci_device_id pci_bridge_id[] __devinitdata = {
+	{ 
+		.vendor		= PCI_ANY_ID, 
+		.device 	= PCI_ANY_ID, 
+	 	.subvendor	= PCI_ANY_ID, 
+		.subdevice	= PCI_ANY_ID, 
+	 	.class		= PCI_CLASS_BRIDGE_PCI << 8, 
+		.class_mask	= 0xffff00, 
+	 	.driver_data	= 0,
+	},
+	{0},
+};
+
+static struct pci_driver driver = {
+	.name 		= "pci_bridge",
+	.id_table	= pci_bridge_id,
+	.probe		= pci_bridge_probe,
+	.remove		= __devexit_p(pci_bridge_remove),
+};
+
+struct pci_bridge_dev_data {
+	u32	br_num;
+	u8	primary_bus;
+	u8	secondary_bus;
+	u8	subordinate_bus;
+};
+
+static u32 pci_bridge_num = 0;
+static spinlock_t br_config_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * pci_bridge_probe - Initialze driver for pci-pci bridge.
+ *
+ * @pci: Pointer to pci bridge device data.
+ * @pci_id: Pointer to pci_bridge_id data.
+ */
+static int __devinit pci_bridge_probe(struct pci_dev *pci,
+					const struct pci_device_id *pci_id)
+{
+	int err = 0;
+	u32 buses;
+	struct pci_bridge_dev_data *dev;
+
+
+	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
+	if (dev == NULL) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	spin_lock(&br_config_lock);
+	dev->br_num = pci_bridge_num++;
+	spin_unlock(&br_config_lock);
+
+	pci_read_config_dword(pci, PCI_PRIMARY_BUS, &buses);
+	dev->primary_bus = buses & 0xff;
+	dev->secondary_bus = (buses >> 8) & 0xff;
+	dev->subordinate_bus = (buses >> 16) & 0xff;
+
+	pci_set_drvdata(pci, dev);
+
+	memset(&class_dev_data, 0, sizeof(class_dev_data)); 
+	class_dev_data.dev = &pci->dev;
+	class_dev_data.class = &pci_bridge_class; 
+	sprintf(class_dev_data.class_id, "pci_bridge%d", dev->br_num);
+
+	pci_bridge_create_sysfs_files(&pci->dev);
+
+	err = class_device_register(&class_dev_data);
+
+out:
+	return err;
+	
+}
+
+/*
+ * pci_bridge_remove - Clean up on device removal
+ *
+ * @pci: Pointer to pci bridge device data.
+ */ 
+static void  __devexit pci_bridge_remove(struct pci_dev *pci)
+{
+	class_device_unregister(&class_dev_data);
+}
+
+/*
+ * pci_bridge_init - initialize module.
+ */
+static int __init pci_bridge_init(void)
+{
+
+	int err;
+
+	err = class_register(&pci_bridge_class);
+	if (err < 0 ) {
+		return err;
+	}
+
+	err = pci_module_init(&driver);
+	if (err < 0) {
+		class_unregister(&pci_bridge_class);
+	}
+
+	return err;
+
+}
+
+/*
+ * pci_bridge_exit - Cleanup on module removal
+ */
+static void __exit pci_bridge_exit(void)
+{
+	pci_unregister_driver(&driver);
+	class_unregister(&pci_bridge_class);
+}
+
+/*
+ * Display pci-pci bridge attributes.
+ */
+
+static ssize_t pci_bridge_show_primary(struct device *device, char *buf)
+{
+	struct pci_bridge_dev_data *dev = dev_get_drvdata(device);
+
+	if (dev == NULL) {
+		return 0;
+	}
+
+	return sprintf(buf, "%u\n", dev->primary_bus);
+}
+static DEVICE_ATTR(primary_bus, S_IRUGO, pci_bridge_show_primary, NULL);
+
+static ssize_t pci_bridge_show_secondary(struct device *device, char *buf)
+{
+	struct pci_bridge_dev_data *dev = dev_get_drvdata(device);
+
+	if (dev == NULL) {
+		return 0;
+	}
+
+	return sprintf(buf, "%u\n", dev->secondary_bus);
+}
+static DEVICE_ATTR(secondary_bus, S_IRUGO, pci_bridge_show_secondary, NULL);
+
+static ssize_t pci_bridge_show_subordinate(struct device *device, char *buf)
+{
+	struct pci_bridge_dev_data *dev = dev_get_drvdata(device);
+
+	if (dev == NULL) {
+		return 0;
+	}
+
+	return sprintf(buf, "%u\n", dev->subordinate_bus);
+}
+static DEVICE_ATTR(subordinate_bus, S_IRUGO, pci_bridge_show_subordinate, NULL);
+
+
+/*
+ * pci_bridge_create_sysfs_files - create sysfs files for pci-pci bridge.
+ *
+ * @device: Pointer to device data for the pci-pci bridge.
+ */
+static void pci_bridge_create_sysfs_files(struct device *device)
+{
+	device_create_file(device, &dev_attr_primary_bus);
+	device_create_file(device, &dev_attr_secondary_bus);
+	device_create_file(device, &dev_attr_subordinate_bus);
+}
+
+MODULE_DEVICE_TABLE(pci, pci_bridge_id);
+module_init(pci_bridge_init);
+module_exit(pci_bridge_exit);
+MODULE_AUTHOR("Mark Haverkamp");
+MODULE_DESCRIPTION("PCI bridge driver");
+MODULE_LICENSE("GPL");



-- 
Mark Haverkamp <markh@osdl.org>

