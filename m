Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVDBVst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVDBVst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVDBVhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:37:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22433 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261389AbVDBVXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:23:37 -0500
Date: Sat, 2 Apr 2005 23:23:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: fix u32 vs. pm_message_t in PCI, PCIE
Message-ID: <20050402212319.GA2128@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes drivers/pci (mostly pcie stuff). [These patches are
independend and change no object code; therefore not numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/drivers/pci/hotplug/pciehp_core.c	2005-01-21 23:03:34.000000000 +0100
+++ linux-cvs/drivers/pci/hotplug/pciehp_core.c	2005-03-31 23:54:46.000000000 +0200
@@ -578,7 +578,7 @@
 }
 
 #ifdef CONFIG_PM
-static int pciehp_suspend (struct pcie_device *dev, u32 state)
+static int pciehp_suspend (struct pcie_device *dev, pm_message_t state)
 {
 	printk("%s ENTRY\n", __FUNCTION__);	
 	return 0;
--- clean-cvs/drivers/pci/pcie/portdrv.h	2005-02-06 10:02:01.000000000 +0100
+++ linux-cvs/drivers/pci/pcie/portdrv.h	2005-03-31 23:54:46.000000000 +0200
@@ -31,7 +31,7 @@
 extern int pcie_port_device_probe(struct pci_dev *dev);
 extern int pcie_port_device_register(struct pci_dev *dev);
 #ifdef CONFIG_PM
-extern int pcie_port_device_suspend(struct pci_dev *dev, u32 state);
+extern int pcie_port_device_suspend(struct pci_dev *dev, pm_message_t state);
 extern int pcie_port_device_resume(struct pci_dev *dev);
 #endif
 extern void pcie_port_device_remove(struct pci_dev *dev);
--- clean-cvs/drivers/pci/pcie/portdrv_bus.c	2005-02-06 10:02:01.000000000 +0100
+++ linux-cvs/drivers/pci/pcie/portdrv_bus.c	2005-03-31 23:54:46.000000000 +0200
@@ -15,7 +15,7 @@
 #include <linux/pcieport_if.h>
 
 static int pcie_port_bus_match(struct device *dev, struct device_driver *drv);
-static int pcie_port_bus_suspend(struct device *dev, u32 state);
+static int pcie_port_bus_suspend(struct device *dev, pm_message_t state);
 static int pcie_port_bus_resume(struct device *dev);
 
 struct bus_type pcie_port_bus_type = {
@@ -46,7 +46,7 @@
 	return 1;
 }
 
-static int pcie_port_bus_suspend(struct device *dev, u32 state)
+static int pcie_port_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
--- clean-cvs/drivers/pci/pcie/portdrv_core.c	2005-02-06 10:02:01.000000000 +0100
+++ linux-cvs/drivers/pci/pcie/portdrv_core.c	2005-03-31 23:54:46.000000000 +0200
@@ -61,7 +61,7 @@
 
 static void pcie_port_shutdown_service(struct device *dev) {}
 
-static int pcie_port_suspend_service(struct device *dev, u32 state, u32 level)
+static int pcie_port_suspend_service(struct device *dev, pm_message_t state, u32 level)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
@@ -76,7 +76,7 @@
 	return 0;
 }
 
-static int pcie_port_resume_service(struct device *dev, u32 state)
+static int pcie_port_resume_service(struct device *dev, u32 level)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
@@ -317,7 +317,7 @@
 }
 
 #ifdef CONFIG_PM
-int pcie_port_device_suspend(struct pci_dev *dev, u32 state)
+int pcie_port_device_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct list_head 		*head, *tmp;
 	struct device 			*parent, *child;
--- clean-cvs/drivers/pci/pcie/portdrv_pci.c	2005-03-29 13:30:18.000000000 +0200
+++ linux-cvs/drivers/pci/pcie/portdrv_pci.c	2005-03-31 23:54:46.000000000 +0200
@@ -67,7 +67,7 @@
 }
 
 #ifdef CONFIG_PM
-static int pcie_portdrv_suspend (struct pci_dev *dev, u32 state)
+static int pcie_portdrv_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	return pcie_port_device_suspend(dev, state);
 }
--- clean-cvs/include/linux/pcieport_if.h	2005-01-18 16:48:03.000000000 +0100
+++ linux-cvs/include/linux/pcieport_if.h	2005-03-31 23:54:51.000000000 +0200
@@ -59,7 +59,7 @@
 	int (*probe) (struct pcie_device *dev, 
 		const struct pcie_port_service_id *id);
 	void (*remove) (struct pcie_device *dev);
-	int (*suspend) (struct pcie_device *dev, u32 state);
+	int (*suspend) (struct pcie_device *dev, pm_message_t state);
 	int (*resume) (struct pcie_device *dev);
 
 	const struct pcie_port_service_id *id_table;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
