Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVGNLyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVGNLyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 07:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVGNLyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 07:54:03 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:26032 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262908AbVGNLyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 07:54:01 -0400
Date: Thu, 14 Jul 2005 15:53:44 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Message-ID: <20050714155344.A27478@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The setup-bus code doesn't work correctly for configurations
with more than one display adapter in the same PCI domain.
This stuff actually is a leftover of an early 2.4 PCI setup code
and apparently it stopped working after some "bridge_ctl" changes.
So the best thing we can do is just to remove it and rely on the fact
that any firmware *has* to configure VGA port forwarding for the boot
display device properly.

But then we need to ensure that the bus->bridge_ctl will always
contain valid information collected at the probe time, therefore
the following change in pci_scan_bridge() is needed.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

--- 2.6.13-rc3/drivers/pci/probe.c	Thu Jul 14 11:09:52 2005
+++ linux/drivers/pci/probe.c	Thu Jul 14 11:22:06 2005
@@ -507,7 +507,7 @@ int __devinit pci_scan_bridge(struct pci
 		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
 
 		if (!is_cardbus) {
-			child->bridge_ctl = PCI_BRIDGE_CTL_NO_ISA;
+			child->bridge_ctl = bctl | PCI_BRIDGE_CTL_NO_ISA;
 			/*
 			 * Adjust subordinate busnr in parent buses.
 			 * We do this before scanning for children because
--- 2.6.13-rc3/drivers/pci/setup-bus.c	Thu Jul 14 11:09:52 2005
+++ linux/drivers/pci/setup-bus.c	Thu Jul 14 11:22:54 2005
@@ -51,8 +51,6 @@ pbus_assign_resources_sorted(struct pci_
 	struct resource_list head, *list, *tmp;
 	int idx;
 
-	bus->bridge_ctl &= ~PCI_BRIDGE_CTL_VGA;
-
 	head.next = NULL;
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
@@ -62,10 +60,6 @@ pbus_assign_resources_sorted(struct pci_
 		    class == PCI_CLASS_BRIDGE_HOST)
 			continue;
 
-		if (class == PCI_CLASS_DISPLAY_VGA ||
-		    class == PCI_CLASS_NOT_DEFINED_VGA)
-			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
-
 		pdev_sort_resources(dev, &head);
 	}
 
@@ -509,12 +503,6 @@ pci_bus_assign_resources(struct pci_bus 
 
 	pbus_assign_resources_sorted(bus);
 
-	if (bus->bridge_ctl & PCI_BRIDGE_CTL_VGA) {
-		/* Propagate presence of the VGA to upstream bridges */
-		for (b = bus; b->parent; b = b->parent) {
-			b->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
-		}
-	}
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		b = dev->subordinate;
 		if (!b)
