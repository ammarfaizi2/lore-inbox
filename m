Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVF1GKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVF1GKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVF1GKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:10:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:26860 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261862AbVF1Fdk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:40 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Link newly created pci child bus to its parent on creation
In-Reply-To: <11199367721790@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:52 -0700
Message-Id: <1119936772835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Link newly created pci child bus to its parent on creation

When a pci child bus is created, add it to the parent's children list
immediately rather than waiting till pci_bus_add_devices().  For hot-plug
bridges/devices, pci_bus_add_devices() may be called much later, after they
have been properly configured.  In the meantime, this allows us to use the
normal pci bus search functions for the hot-plug bridges/buses.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6ef6f0e33c4645fc8d23201ad5a6a289b4303cbb
tree ff7861a550b5eea24788ccc07ca0df5294f9067b
parent e4ea9bb7e9f177e03a917b1f1213de0315f819ee
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:49 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:40 -0700

 drivers/pci/bus.c   |   11 +++++++----
 drivers/pci/probe.c |    4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -121,10 +121,13 @@ void __devinit pci_bus_add_devices(struc
 		 * If there is an unattached subordinate bus, attach
 		 * it and then scan for unattached PCI devices.
 		 */
-		if (dev->subordinate && list_empty(&dev->subordinate->node)) {
-			spin_lock(&pci_bus_lock);
-			list_add_tail(&dev->subordinate->node, &dev->bus->children);
-			spin_unlock(&pci_bus_lock);
+		if (dev->subordinate) {
+		       if (list_empty(&dev->subordinate->node)) {
+			       spin_lock(&pci_bus_lock);
+			       list_add_tail(&dev->subordinate->node,
+					       &dev->bus->children);
+			       spin_unlock(&pci_bus_lock);
+		       }
 			pci_bus_add_devices(dev->subordinate);
 
 			sysfs_create_link(&dev->subordinate->class_dev.kobj, &dev->dev.kobj, "bridge");
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -450,7 +450,7 @@ int __devinit pci_scan_bridge(struct pci
 			return max;
 		}
 
-		child = pci_alloc_child_bus(bus, dev, busnr);
+		child = pci_add_new_bus(bus, dev, busnr);
 		if (!child)
 			return max;
 		child->primary = buses & 0xFF;
@@ -477,7 +477,7 @@ int __devinit pci_scan_bridge(struct pci
 		 * This can happen when a bridge is hot-plugged */
 		if (pci_find_bus(pci_domain_nr(bus), max+1))
 			return max;
-		child = pci_alloc_child_bus(bus, dev, ++max);
+		child = pci_add_new_bus(bus, dev, ++max);
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->secondary)   <<  8)

