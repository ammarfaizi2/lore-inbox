Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWATTIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWATTIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWATTFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:31440 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751167AbWATTFB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:01 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: remove rpaphp_fixup_new_pci_devices()
In-Reply-To: <1137783879512@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:39 -0800
Message-Id: <1137783879865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: remove rpaphp_fixup_new_pci_devices()

The function rpaphp_fixup_new_pci_devices() has been migrated to
pcibios_fixup_new_pci_devices() in
arch/powerpc/platforms/pseries/pci_dlpar.c
This patch removes the old version.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 22a585a88bd1cdd7d3b757b1b6d57d7ce12b3e08
tree 298814389983cc63cdbaba0e45f8fa92685a2c0e
parent 42ce64544f4cfbafcf8a0fbe779414d2bf81e607
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:20:26 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:35 -0800

 drivers/pci/hotplug/rpadlpar_core.c |    2 
 drivers/pci/hotplug/rpaphp.h        |    1 
 drivers/pci/hotplug/rpaphp_pci.c    |  142 -----------------------------------
 3 files changed, 2 insertions(+), 143 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index bc17a13..6c14810 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -146,7 +146,7 @@ static struct pci_dev *dlpar_pci_add_bus
 	    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		of_scan_pci_bridge(dn, dev);
 
-	rpaphp_init_new_devs(dev->subordinate);
+	pcibios_fixup_new_pci_devices(dev->subordinate,0);
 
 	/* Claim new bus resources */
 	pcibios_claim_one_bus(dev->bus);
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index b333a35..6aa91ef 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -91,7 +91,6 @@ extern int num_slots;
 extern int rpaphp_enable_pci_slot(struct slot *slot);
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
-extern void rpaphp_init_new_devs(struct pci_bus *bus);
 
 extern int rpaphp_config_pci_adapter(struct pci_bus *bus);
 extern int rpaphp_unconfig_pci_adapter(struct pci_bus *bus);
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index f16d0f9..1a12ebd 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -101,140 +101,6 @@ exit:
 	return rc;
 }
 
-/* Must be called before pci_bus_add_devices */
-void rpaphp_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/*
-		 * Skip already-present devices (which are on the
-		 * global device list.)
-		 */
-		if (list_empty(&dev->global_list)) {
-			int i;
-			
-			/* Need to setup IOMMU tables */
-			ppc_md.iommu_dev_setup(dev);
-
-			if(fix_bus)
-				pcibios_fixup_device_resources(dev, bus);
-			pci_read_irq_line(dev);
-			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-				struct resource *r = &dev->resource[i];
-
-				if (r->parent || !r->start || !r->flags)
-					continue;
-				pci_claim_resource(dev, i);
-			}
-		}
-	}
-}
-
-static void rpaphp_eeh_add_bus_device(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		eeh_add_device_late(dev);
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-			struct pci_bus *subbus = dev->subordinate;
-			if (subbus)
-				rpaphp_eeh_add_bus_device (subbus);
-		}
-	}
-}
-
-static int rpaphp_pci_config_bridge(struct pci_dev *dev)
-{
-	u8 sec_busno;
-	struct pci_bus *child_bus;
-	struct pci_dev *child_dev;
-
-	dbg("Enter %s:  BRIDGE dev=%s\n", __FUNCTION__, pci_name(dev));
-
-	/* get busno of downstream bus */
-	pci_read_config_byte(dev, PCI_SECONDARY_BUS, &sec_busno);
-		
-	/* add to children of PCI bridge dev->bus */
-	child_bus = pci_add_new_bus(dev->bus, dev, sec_busno);
-	if (!child_bus) {
-		err("%s: could not add second bus\n", __FUNCTION__);
-		return -EIO;
-	}
-	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
-	/* do pci_scan_child_bus */
-	pci_scan_child_bus(child_bus);
-
-	list_for_each_entry(child_dev, &child_bus->devices, bus_list) {
-		eeh_add_device_late(child_dev);
-	}
-
-	 /* fixup new pci devices without touching bus struct */
-	rpaphp_fixup_new_pci_devices(child_bus, 0);
-
-	/* Make the discovered devices available */
-	pci_bus_add_devices(child_bus);
-	return 0;
-}
-
-void rpaphp_init_new_devs(struct pci_bus *bus)
-{
-	rpaphp_fixup_new_pci_devices(bus, 0);
-	rpaphp_eeh_add_bus_device(bus);
-}
-EXPORT_SYMBOL_GPL(rpaphp_init_new_devs);
-
-/*****************************************************************************
- rpaphp_pci_config_slot() will  configure all devices under the
- given slot->dn and return the the first pci_dev.
- *****************************************************************************/
-static struct pci_dev *
-rpaphp_pci_config_slot(struct pci_bus *bus)
-{
-	struct device_node *dn = pci_bus_to_OF_node(bus);
-	struct pci_dev *dev = NULL;
-	int slotno;
-	int num;
-
-	dbg("Enter %s: dn=%s bus=%s\n", __FUNCTION__, dn->full_name, bus->name);
-	if (!dn || !dn->child)
-		return NULL;
-
-	if (_machine == PLATFORM_PSERIES_LPAR) {
-		of_scan_bus(dn, bus);
-		if (list_empty(&bus->devices)) {
-			err("%s: No new device found\n", __FUNCTION__);
-			return NULL;
-		}
-
-		rpaphp_init_new_devs(bus);
-		pci_bus_add_devices(bus);
-		dev = list_entry(&bus->devices, struct pci_dev, bus_list);
-	} else {
-		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
-
-		/* pci_scan_slot should find all children */
-		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
-		if (num) {
-			rpaphp_fixup_new_pci_devices(bus, 1);
-			pci_bus_add_devices(bus);
-		}
-		if (list_empty(&bus->devices)) {
-			err("%s: No new device found\n", __FUNCTION__);
-			return NULL;
-		}
-		list_for_each_entry(dev, &bus->devices, bus_list) {
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-				rpaphp_pci_config_bridge(dev);
-
-			rpaphp_eeh_add_bus_device(bus);
-		}
-	}
-
-	return dev;
-}
-
 static void print_slot_pci_funcs(struct pci_bus *bus)
 {
 	struct device_node *dn;
@@ -253,19 +119,13 @@ static void print_slot_pci_funcs(struct 
 int rpaphp_config_pci_adapter(struct pci_bus *bus)
 {
 	struct device_node *dn = pci_bus_to_OF_node(bus);
-	struct pci_dev *dev;
 	int rc = -ENODEV;
 
 	dbg("Entry %s: slot[%s]\n", __FUNCTION__, dn->full_name);
 	if (!dn)
 		goto exit;
 
-	eeh_add_device_tree_early(dn);
-	dev = rpaphp_pci_config_slot(bus);
-	if (!dev) {
-		err("%s: can't find any devices.\n", __FUNCTION__);
-		goto exit;
-	}
+	pcibios_add_pci_devices(bus);
 	print_slot_pci_funcs(bus);
 	rc = 0;
 exit:

