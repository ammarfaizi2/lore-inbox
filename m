Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVCRWQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVCRWQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVCRWQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:16:25 -0500
Received: from fmr22.intel.com ([143.183.121.14]:12509 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262106AbVCRWJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:09:40 -0500
Date: Fri, 18 Mar 2005 14:09:22 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 06/12] Link newly created pci child bus to its parent on creation
Message-ID: <20050318140922.F1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a pci child bus is created, add it to the parent's children
list immediately rather than waiting till pci_bus_add_devices().
For hot-plug bridges/devices, pci_bus_add_devices() may be called
much later, after they have been properly configured. In the 
meantime, this allows us to use the normal pci bus search functions
for the hot-plug bridges/buses.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/bus.c   |   11 +++++++----
 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c |    4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff -puN drivers/pci/probe.c~pci_link_child_bus drivers/pci/probe.c
--- linux-2.6.11-mm4-iohp/drivers/pci/probe.c~pci_link_child_bus	2005-03-16 13:07:18.745444812 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c	2005-03-16 13:07:18.857749498 -0800
@@ -457,7 +457,7 @@ int __devinit pci_scan_bridge(struct pci
 			return max;
 		}
 
-		child = pci_alloc_child_bus(bus, dev, busnr);
+		child = pci_add_new_bus(bus, dev, busnr);
 		if (!child)
 			return max;
 		child->primary = buses & 0xFF;
@@ -484,7 +484,7 @@ int __devinit pci_scan_bridge(struct pci
 		 * This can happen when a bridge is hot-plugged */
 		if (pci_find_bus(pci_domain_nr(bus), max+1))
 			return max;
-		child = pci_alloc_child_bus(bus, dev, ++max);
+		child = pci_add_new_bus(bus, dev, ++max);
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->secondary)   <<  8)
diff -puN drivers/pci/bus.c~pci_link_child_bus drivers/pci/bus.c
--- linux-2.6.11-mm4-iohp/drivers/pci/bus.c~pci_link_child_bus	2005-03-16 13:07:18.749351062 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/bus.c	2005-03-16 13:07:18.858726061 -0800
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
_
