Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVCRVtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVCRVtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 16:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVCRVtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 16:49:24 -0500
Received: from fmr22.intel.com ([143.183.121.14]:53977 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261421AbVCRVsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 16:48:51 -0500
Date: Fri, 18 Mar 2005 13:48:35 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, matthew@wil.cx, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: [Patch 1/12] ACPI based root bridge hot-add
Message-ID: <20050318134834.A1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you hot-plug a (root) bridge hierarchy, it may have p2p
bridges and devices attached to it that have not been configured
by firmware. In this case, we need to configure the devices 
before starting them. This patch separates device start from
device scan so that we can introduce the configuration step in
the middle. 

I kept the existing semantics for pci_scan_bus() since there
are a huge number of callers to that function.

Also, I have no way of testing the changes I made to the parisc
files, so this needs review by those folks. Sorry for the massive
cross-post, this touches files in many different places.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/arch/i386/pci/common.c   |    2 -
 linux-2.6.11-mm4-iohp-rshah1/arch/i386/pci/legacy.c   |    2 +
 linux-2.6.11-mm4-iohp-rshah1/arch/i386/pci/numa.c     |    2 +
 linux-2.6.11-mm4-iohp-rshah1/arch/ia64/pci/pci.c      |    2 -
 linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/pci_bind.c  |   16 +++++++++++-
 linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/pci_root.c  |   24 +++++++++++++++++-
 linux-2.6.11-mm4-iohp-rshah1/drivers/parisc/dino.c    |    1 
 linux-2.6.11-mm4-iohp-rshah1/drivers/parisc/lba_pci.c |    2 +
 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c      |    2 -
 linux-2.6.11-mm4-iohp-rshah1/include/linux/pci.h      |    8 ++++--
 10 files changed, 53 insertions(+), 8 deletions(-)

diff -puN arch/i386/pci/common.c~pci_serparate_device_add arch/i386/pci/common.c
--- linux-2.6.11-mm4-iohp/arch/i386/pci/common.c~pci_serparate_device_add	2005-03-16 13:06:53.259117000 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/arch/i386/pci/common.c	2005-03-16 13:06:53.419273248 -0800
@@ -133,7 +133,7 @@ struct pci_bus * __devinit pcibios_scan_
 
 	printk("PCI: Probing PCI hardware (bus %02x)\n", busnum);
 
-	return pci_scan_bus(busnum, &pci_root_ops, NULL);
+	return pci_scan_bus_parented(NULL, busnum, &pci_root_ops, NULL);
 }
 
 extern u8 pci_cache_line_size;
diff -puN arch/i386/pci/legacy.c~pci_serparate_device_add arch/i386/pci/legacy.c
--- linux-2.6.11-mm4-iohp/arch/i386/pci/legacy.c~pci_serparate_device_add	2005-03-16 13:06:53.263999812 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/arch/i386/pci/legacy.c	2005-03-16 13:06:53.420249810 -0800
@@ -45,6 +45,8 @@ static int __init pci_legacy_init(void)
 
 	printk("PCI: Probing PCI hardware\n");
 	pci_root_bus = pcibios_scan_root(0);
+	if (pci_root_bus)
+		pci_bus_add_devices(pci_root_bus);
 
 	pcibios_fixup_peer_bridges();
 
diff -puN arch/i386/pci/numa.c~pci_serparate_device_add arch/i386/pci/numa.c
--- linux-2.6.11-mm4-iohp/arch/i386/pci/numa.c~pci_serparate_device_add	2005-03-16 13:06:53.267906062 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/arch/i386/pci/numa.c	2005-03-16 13:06:53.421226373 -0800
@@ -115,6 +115,8 @@ static int __init pci_numa_init(void)
 		return 0;
 
 	pci_root_bus = pcibios_scan_root(0);
+	if (pci_root_bus)
+		pci_bus_add_devices(pci_root_bus);
 	if (num_online_nodes() > 1)
 		for_each_online_node(quad) {
 			if (quad == 0)
diff -puN arch/ia64/pci/pci.c~pci_serparate_device_add arch/ia64/pci/pci.c
--- linux-2.6.11-mm4-iohp/arch/ia64/pci/pci.c~pci_serparate_device_add	2005-03-16 13:06:53.272788874 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/arch/ia64/pci/pci.c	2005-03-16 13:06:53.430991997 -0800
@@ -330,7 +330,7 @@ pci_acpi_scan_root(struct acpi_device *d
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, add_window,
 			&info);
 
-	pbus = pci_scan_bus(bus, &pci_root_ops, controller);
+	pbus = pci_scan_bus_parented(NULL, bus, &pci_root_ops, controller);
 	if (pbus)
 		pcibios_setup_root_windows(pbus, controller);
 
diff -puN drivers/acpi/pci_bind.c~pci_serparate_device_add drivers/acpi/pci_bind.c
--- linux-2.6.11-mm4-iohp/drivers/acpi/pci_bind.c~pci_serparate_device_add	2005-03-16 13:06:53.276695124 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/pci_bind.c	2005-03-16 13:06:53.431968560 -0800
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
diff -puN drivers/acpi/pci_root.c~pci_serparate_device_add drivers/acpi/pci_root.c
--- linux-2.6.11-mm4-iohp/drivers/acpi/pci_root.c~pci_serparate_device_add	2005-03-16 13:06:53.281577937 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/pci_root.c	2005-03-16 13:06:53.432945122 -0800
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
diff -puN drivers/parisc/dino.c~pci_serparate_device_add drivers/parisc/dino.c
--- linux-2.6.11-mm4-iohp/drivers/parisc/dino.c~pci_serparate_device_add	2005-03-16 13:06:53.285484187 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/parisc/dino.c	2005-03-16 13:06:53.433921685 -0800
@@ -993,6 +993,7 @@ dino_driver_callback(struct parisc_devic
 	bus = pci_scan_bus_parented(&dev->dev, dino_current_bus,
 				    &dino_cfg_ops, NULL);
 	if(bus) {
+		pci_bus_add_devices(bus);
 		/* This code *depends* on scanning being single threaded
 		 * if it isn't, this global bus number count will fail
 		 */
diff -puN drivers/parisc/lba_pci.c~pci_serparate_device_add drivers/parisc/lba_pci.c
--- linux-2.6.11-mm4-iohp/drivers/parisc/lba_pci.c~pci_serparate_device_add	2005-03-16 13:06:53.290366999 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/parisc/lba_pci.c	2005-03-16 13:06:53.435874810 -0800
@@ -1570,6 +1570,8 @@ lba_driver_probe(struct parisc_device *d
 	lba_bus = lba_dev->hba.hba_bus =
 		pci_scan_bus_parented(&dev->dev, lba_dev->hba.bus_num.start,
 				cfg_ops, NULL);
+	if (lba_bus)
+		pci_bus_add_devices(lba_bus);
 
 	/* This is in lieu of calling pci_assign_unassigned_resources() */
 	if (is_pdc_pat()) {
diff -puN drivers/pci/probe.c~pci_serparate_device_add drivers/pci/probe.c
--- linux-2.6.11-mm4-iohp/drivers/pci/probe.c~pci_serparate_device_add	2005-03-16 13:06:53.294273249 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c	2005-03-16 13:06:53.436851372 -0800
@@ -916,8 +916,6 @@ struct pci_bus * __devinit pci_scan_bus_
 
 	b->subordinate = pci_scan_child_bus(b);
 
-	pci_bus_add_devices(b);
-
 	return b;
 
 sys_create_link_err:
diff -puN include/linux/pci.h~pci_serparate_device_add include/linux/pci.h
--- linux-2.6.11-mm4-iohp/include/linux/pci.h~pci_serparate_device_add	2005-03-16 13:06:53.299156062 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/include/linux/pci.h	2005-03-16 13:06:53.449546685 -0800
@@ -732,16 +732,20 @@ void pcibios_update_irq(struct pci_dev *
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
_
