Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUA3BtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUA3BgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:36:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:11484 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266512AbUA3BcE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:04 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <1075426310499@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:50 -0800
Message-Id: <10754263103006@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1521, 2004/01/29 16:54:22-08:00, johnrose@austin.ibm.com

[PATCH] PCI: Allow pci hotplug drivers to initialize individual devices.

This lets the PPC pci hotplug driver initialize single devices, not just
entire slots.


 drivers/pci/probe.c |   66 +++++++++++++++++++++++++++++++---------------------
 include/linux/pci.h |    1 
 2 files changed, 41 insertions(+), 26 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Jan 29 17:23:56 2004
+++ b/drivers/pci/probe.c	Thu Jan 29 17:23:56 2004
@@ -580,6 +580,30 @@
 	return dev;
 }
 
+struct pci_dev * __devinit
+pci_scan_single_device(struct pci_bus *bus, int devfn)
+{
+	struct pci_dev *dev;
+
+	dev = pci_scan_device(bus, devfn);
+	pci_scan_msi_device(dev);
+
+	if (!dev)
+		return NULL;
+	
+	/* Fix up broken headers */
+	pci_fixup_device(PCI_FIXUP_HEADER, dev);
+
+	/*
+	 * Add the device to our list of discovered devices
+	 * and the bus list for fixup functions, etc.
+	 */
+	INIT_LIST_HEAD(&dev->global_list);
+	list_add_tail(&dev->bus_list, &bus->devices);
+
+	return dev;
+}
+
 /**
  * pci_scan_slot - scan a PCI slot on a bus for devices.
  * @bus: PCI bus to scan
@@ -596,34 +620,23 @@
 	for (func = 0; func < 8; func++, devfn++) {
 		struct pci_dev *dev;
 
-		dev = pci_scan_device(bus, devfn);
-		pci_scan_msi_device(dev);
-		if (func == 0) {
-			if (!dev)
-				break;
+		dev = pci_scan_single_device(bus, devfn);
+		if (dev) {
+			nr++;
+
+			/*
+		 	 * If this is a single function device,
+		 	 * don't scan past the first function.
+		 	 */
+			if (!dev->multifunction)
+				if (func > 0)
+					dev->multifunction = 1;
+				else
+ 					break;
 		} else {
-			if (!dev)
-				continue;
-			dev->multifunction = 1;
+			if (func == 0)
+				break;
 		}
-
-		/* Fix up broken headers */
-		pci_fixup_device(PCI_FIXUP_HEADER, dev);
-
-		/*
-		 * Add the device to our list of discovered devices
-		 * and the bus list for fixup functions, etc.
-		 */
-		INIT_LIST_HEAD(&dev->global_list);
-		list_add_tail(&dev->bus_list, &bus->devices);
-		nr++;
-
-		/*
-		 * If this is a single function device,
-		 * don't scan past the first function.
-		 */
-		if (!dev->multifunction)
-			break;
 	}
 	return nr;
 }
@@ -734,4 +747,5 @@
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bridge);
+EXPORT_SYMBOL(pci_scan_single_device);
 #endif
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jan 29 17:23:56 2004
+++ b/include/linux/pci.h	Thu Jan 29 17:23:56 2004
@@ -587,6 +587,7 @@
 	return pci_scan_bus_parented(NULL, bus, ops, sysdata);
 }
 int pci_scan_slot(struct pci_bus *bus, int devfn);
+struct pci_dev * pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_bus_add_devices(struct pci_bus *bus);
 void pci_name_device(struct pci_dev *dev);
 char *pci_class_name(u32 class);

