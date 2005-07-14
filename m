Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVGNJS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVGNJS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVGNJGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:06:44 -0400
Received: from peabody.ximian.com ([130.57.169.10]:9609 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262971AbVGNJFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:33 -0400
Subject: [RFC][PATCH] master abort on scanning fixes [6/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:55:26 -0400
Message-Id: <1121331326.3398.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI bridge driver now checks if changing bridge_ctrl is necessary.
It also restores the original bridge_ctl settings when finished scanning
for devices.  Finally, a pci_bus setup fix is included.

Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/pci/bus/pci-bridge.c	2005-07-12 01:45:46.000000000 -0400
+++ b/drivers/pci/bus/pci-bridge.c	2005-07-14 02:09:15.000000000 -0400
@@ -30,7 +30,7 @@
 	bus->bridge = &dev->dev;
 	bus->ops = bus->parent->ops;
 	bus->sysdata = bus->parent->sysdata;
-	bus->bridge = get_device(&dev->dev);
+	bus->self = dev;
 
 	/* Set up default resource pointers and names.. */
 	for (i = 0; i < 4; i++) {
@@ -82,12 +82,7 @@
 	if (!bus)
 		return NULL;
 
-	/* Disable MasterAbortMode during probing to avoid reporting
-	 * of bus errors (in some architectures)
-	 */ 
 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
-			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
 	bus->number = bus->secondary = busnr;
 	bus->primary = buses & 0xFF;
@@ -105,10 +100,22 @@
 {
 	unsigned int devfn;
 
+	/* Disable MasterAbortMode during probing to avoid reporting
+	 * of bus errors (in some architectures)
+	 */ 
+	if (!(bus->bridge_ctl & PCI_BRIDGE_CTL_MASTER_ABORT))
+		pci_write_config_word(bus->self, PCI_BRIDGE_CONTROL,
+			bus->bridge_ctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
+
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 0x100; devfn += 8)
 		pci_scan_slot(bus, devfn);
 
+	/* restore the original bridge_ctl configuration */
+	if (!(bus->bridge_ctl & PCI_BRIDGE_CTL_MASTER_ABORT))
+		pci_write_config_word(bus->self, PCI_BRIDGE_CONTROL,
+				      bus->bridge_ctl);
+
 	pcibios_fixup_bus(bus);
 	pci_bus_add_devices(bus);
 }


