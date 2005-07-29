Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVG3Auk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVG3Auk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVG2TS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:18:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:18351 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262740AbVG2TRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:00 -0400
Date: Fri, 29 Jul 2005 12:16:22 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
Subject: [patch 15/29] PCI: remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Message-ID: <20050729191622.GQ5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/probe.c     |    2 +-
 drivers/pci/setup-bus.c |   12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

--- gregkh-2.6.orig/drivers/pci/probe.c	2005-07-29 11:29:50.000000000 -0700
+++ gregkh-2.6/drivers/pci/probe.c	2005-07-29 11:36:23.000000000 -0700
@@ -507,7 +507,7 @@
 		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
 
 		if (!is_cardbus) {
-			child->bridge_ctl = PCI_BRIDGE_CTL_NO_ISA;
+			child->bridge_ctl = bctl | PCI_BRIDGE_CTL_NO_ISA;
 			/*
 			 * Adjust subordinate busnr in parent buses.
 			 * We do this before scanning for children because
--- gregkh-2.6.orig/drivers/pci/setup-bus.c	2005-07-29 11:29:50.000000000 -0700
+++ gregkh-2.6/drivers/pci/setup-bus.c	2005-07-29 11:36:23.000000000 -0700
@@ -51,8 +51,6 @@
 	struct resource_list head, *list, *tmp;
 	int idx;
 
-	bus->bridge_ctl &= ~PCI_BRIDGE_CTL_VGA;
-
 	head.next = NULL;
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
@@ -62,10 +60,6 @@
 		    class == PCI_CLASS_BRIDGE_HOST)
 			continue;
 
-		if (class == PCI_CLASS_DISPLAY_VGA ||
-		    class == PCI_CLASS_NOT_DEFINED_VGA)
-			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
-
 		pdev_sort_resources(dev, &head);
 	}
 
@@ -509,12 +503,6 @@
 
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

--
