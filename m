Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVCRWQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVCRWQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVCRWQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:16:04 -0500
Received: from fmr23.intel.com ([143.183.121.15]:22427 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262293AbVCRWLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:11:54 -0500
Date: Fri, 18 Mar 2005 14:11:44 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 07/12] Make the PCI remove routines safe for failed hot-plug
Message-ID: <20050318141143.G1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a root bridge hierarchy is hot-plugged, resource requirements
for the new devices may be greater than what the root bridge is
decoding. In this case, we want to remove devices that did not
get needed resources. These devices have been scanned into bus
specific lists but not yet added to the global device list.
Make sure the pci remove functions can handle this case.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/remove.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff -puN drivers/pci/remove.c~pci-remove-device-hotplug-safe drivers/pci/remove.c
--- linux-2.6.11-mm4-iohp/drivers/pci/remove.c~pci-remove-device-hotplug-safe	2005-03-16 13:07:22.667319764 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/remove.c	2005-03-16 13:07:22.775718200 -0800
@@ -26,17 +26,21 @@ static void pci_free_resources(struct pc
 
 static void pci_destroy_dev(struct pci_dev *dev)
 {
-	pci_proc_detach_device(dev);
-	pci_remove_sysfs_dev_files(dev);
-	device_unregister(&dev->dev);
+	if (!list_empty(&dev->global_list)) {
+		pci_proc_detach_device(dev);
+		pci_remove_sysfs_dev_files(dev);
+		device_unregister(&dev->dev);
+		spin_lock(&pci_bus_lock);
+		list_del(&dev->global_list);
+		dev->global_list.next = dev->global_list.prev = NULL;
+		spin_unlock(&pci_bus_lock);
+	}
 
 	/* Remove the device from the device lists, and prevent any further
 	 * list accesses from this device */
 	spin_lock(&pci_bus_lock);
 	list_del(&dev->bus_list);
-	list_del(&dev->global_list);
 	dev->bus_list.next = dev->bus_list.prev = NULL;
-	dev->global_list.next = dev->global_list.prev = NULL;
 	spin_unlock(&pci_bus_lock);
 
 	pci_free_resources(dev);
_
