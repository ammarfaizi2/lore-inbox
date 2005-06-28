Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVF1GNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVF1GNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVF1GMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:12:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:29420 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261870AbVF1Fdl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:41 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: ACPI based root bridge hot-add
In-Reply-To: <11199367713428@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:52 -0700
Message-Id: <11199367721003@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: ACPI based root bridge hot-add

When you hot-plug a (root) bridge hierarchy, it may have p2p bridges and
devices attached to it that have not been configured by firmware.  In this
case, we need to configure the devices before starting them.  This patch
separates device start from device scan so that we can introduce the
configuration step in the middle.

I kept the existing semantics for pci_scan_bus() since there are a huge number
of callers to that function.

Also, I have no way of testing the changes I made to the parisc files, so this
needs review by those folks.  Sorry for the massive cross-post, this touches
files in many different places.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c431ada45d65b305a6aab4557067e564b23ce5a5
tree 3fefb8a354860d9c39781dbbf042c992da5a9cd5
parent efe1ec27837d6639eae82e1f5876910ba6433c3f
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:45 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:39 -0700

 arch/i386/pci/common.c   |    2 +-
 arch/i386/pci/legacy.c   |    2 ++
 arch/i386/pci/numa.c     |    2 ++
 arch/ia64/pci/pci.c      |    2 +-
 drivers/acpi/pci_bind.c  |   16 +++++++++++++++-
 drivers/acpi/pci_root.c  |   24 +++++++++++++++++++++++-
 drivers/parisc/dino.c    |    1 +
 drivers/parisc/lba_pci.c |    2 ++
 drivers/pci/probe.c      |    2 --
 include/linux/pci.h      |    8 ++++++--
 10 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -134,7 +134,7 @@ struct pci_bus * __devinit pcibios_scan_
 
 	printk("PCI: Probing PCI hardware (bus %02x)\n", busnum);
 
-	return pci_scan_bus(busnum, &pci_root_ops, NULL);
+	return pci_scan_bus_parented(NULL, busnum, &pci_root_ops, NULL);
 }
 
 extern u8 pci_cache_line_size;
diff --git a/arch/i386/pci/legacy.c b/arch/i386/pci/legacy.c
--- a/arch/i386/pci/legacy.c
+++ b/arch/i386/pci/legacy.c
@@ -45,6 +45,8 @@ static int __init pci_legacy_init(void)
 
 	printk("PCI: Probing PCI hardware\n");
 	pci_root_bus = pcibios_scan_root(0);
+	if (pci_root_bus)
+		pci_bus_add_devices(pci_root_bus);
 
 	pcibios_fixup_peer_bridges();
 
diff --git a/arch/i386/pci/numa.c b/arch/i386/pci/numa.c
--- a/arch/i386/pci/numa.c
+++ b/arch/i386/pci/numa.c
@@ -115,6 +115,8 @@ static int __init pci_numa_init(void)
 		return 0;
 
 	pci_root_bus = pcibios_scan_root(0);
+	if (pci_root_bus)
+		pci_bus_add_devices(pci_root_bus);
 	if (num_online_nodes() > 1)
 		for_each_online_node(quad) {
 			if (quad == 0)
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -312,7 +312,7 @@ pci_acpi_scan_root(struct acpi_device *d
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, add_window,
 			&info);
 
-	pbus = pci_scan_bus(bus, &pci_root_ops, controller);
+	pbus = pci_scan_bus_parented(NULL, bus, &pci_root_ops, controller);
 	if (pbus)
 		pcibios_setup_root_windows(pbus, controller);
 
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -129,6 +129,8 @@ acpi_pci_bind (
 	char			*pathname = NULL;
 	struct acpi_buffer	buffer = {0, NULL};
 	acpi_handle		handle = NULL;
+	struct pci_dev		*dev;
+	struct pci_bus 		*bus;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_bind");
 
@@ -193,8 +195,20 @@ acpi_pci_bind (
 	 * Locate matching device in PCI namespace.  If it doesn't exist
 	 * this typically means that the device isn't currently inserted
 	 * (e.g. docking station, port replicator, etc.).
+	 * We cannot simply search the global pci device list, since
+	 * PCI devices are added to the global pci list when the root
+	 * bridge start ops are run, which may not have happened yet.
 	 */
-	data->dev = pci_find_slot(data->id.bus, PCI_DEVFN(data->id.device, data->id.function));
+	bus = pci_find_bus(data->id.segment, data->id.bus);
+	if (bus) {
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			if (dev->devfn == PCI_DEVFN(data->id.device,
+						data->id.function)) {
+				data->dev = dev;
+				break;
+			}
+		}
+	}
 	if (!data->dev) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 			"Device %02x:%02x:%02x.%02x not present in PCI namespace\n",
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -46,6 +46,7 @@ ACPI_MODULE_NAME		("pci_root")
 
 static int acpi_pci_root_add (struct acpi_device *device);
 static int acpi_pci_root_remove (struct acpi_device *device, int type);
+static int acpi_pci_root_start (struct acpi_device *device);
 
 static struct acpi_driver acpi_pci_root_driver = {
 	.name =		ACPI_PCI_ROOT_DRIVER_NAME,
@@ -54,6 +55,7 @@ static struct acpi_driver acpi_pci_root_
 	.ops =		{
 				.add =    acpi_pci_root_add,
 				.remove = acpi_pci_root_remove,
+				.start =  acpi_pci_root_start,
 			},
 };
 
@@ -169,6 +171,7 @@ acpi_pci_root_add (
 	if (!root)
 		return_VALUE(-ENOMEM);
 	memset(root, 0, sizeof(struct acpi_pci_root));
+	INIT_LIST_HEAD(&root->node);
 
 	root->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
@@ -298,12 +301,31 @@ acpi_pci_root_add (
 			root->id.bus);
 
 end:
-	if (result)
+	if (result) {
+		if (!list_empty(&root->node))
+			list_del(&root->node);
 		kfree(root);
+	}
 
 	return_VALUE(result);
 }
 
+static int
+acpi_pci_root_start (
+	struct acpi_device	*device)
+{
+	struct acpi_pci_root	*root;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_root_start");
+
+	list_for_each_entry(root, &acpi_pci_roots, node) {
+		if (root->handle == device->handle) {
+			pci_bus_add_devices(root->bus);
+			return_VALUE(0);
+		}
+	}
+	return_VALUE(-ENODEV);
+}
 
 static int
 acpi_pci_root_remove (
diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -993,6 +993,7 @@ dino_driver_callback(struct parisc_devic
 	bus = pci_scan_bus_parented(&dev->dev, dino_current_bus,
 				    &dino_cfg_ops, NULL);
 	if(bus) {
+		pci_bus_add_devices(bus);
 		/* This code *depends* on scanning being single threaded
 		 * if it isn't, this global bus number count will fail
 		 */
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1570,6 +1570,8 @@ lba_driver_probe(struct parisc_device *d
 	lba_bus = lba_dev->hba.hba_bus =
 		pci_scan_bus_parented(&dev->dev, lba_dev->hba.bus_num.start,
 				cfg_ops, NULL);
+	if (lba_bus)
+		pci_bus_add_devices(lba_bus);
 
 	/* This is in lieu of calling pci_assign_unassigned_resources() */
 	if (is_pdc_pat()) {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -911,8 +911,6 @@ struct pci_bus * __devinit pci_scan_bus_
 
 	b->subordinate = pci_scan_child_bus(b);
 
-	pci_bus_add_devices(b);
-
 	return b;
 
 sys_create_link_err:
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -734,16 +734,20 @@ void pcibios_update_irq(struct pci_dev *
 /* Generic PCI functions used internally */
 
 extern struct pci_bus *pci_find_bus(int domain, int busnr);
+void pci_bus_add_devices(struct pci_bus *bus);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
 static inline struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)
 {
-	return pci_scan_bus_parented(NULL, bus, ops, sysdata);
+	struct pci_bus *root_bus;
+	root_bus = pci_scan_bus_parented(NULL, bus, ops, sysdata);
+	if (root_bus)
+		pci_bus_add_devices(root_bus);
+	return root_bus;
 }
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev * pci_scan_single_device(struct pci_bus *bus, int devfn);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
 void pci_bus_add_device(struct pci_dev *dev);
-void pci_bus_add_devices(struct pci_bus *bus);
 void pci_name_device(struct pci_dev *dev);
 char *pci_class_name(u32 class);
 void pci_read_bridge_bases(struct pci_bus *child);

