Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWFQDBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWFQDBy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 23:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWFQDBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 23:01:54 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:41465 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751186AbWFQDBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 23:01:53 -0400
Message-ID: <4493709A.7050603@myri.com>
Date: Fri, 16 Jun 2006 23:01:46 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: linux-pci@atrey.karlin.mff.cuni.cz
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport
 capabilities
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several chipsets are known to not support MSI. Some support MSI but
disable it by default. Thus, several drivers implement their own way to
detect whether MSI works.

We introduce whitelisting of chipsets that are known to support MSI and
keep the existing backlisting to disable MSI for other chipsets. When it
is unknown whether the root chipset support MSI or not, we disable MSI
by default except if pci=forcemsi was passed.

Whitelisting is done by setting a new PCI_BUS_FLAGS_MSI in the chipset
subordinate bus. pci_enable_msi() thus starts by checking whether the
root chipset of the device has the MSI or NOMSI flag set.

Bus flags inheritance is dropped since it has been reported to be broken.

We currently whitelist all Intel chipsets, nVidia CK804 and ServerWorks
HT2000. Some others are probably missing such as nVidia chipsets for
Intel processors.

We introduces a generic code to check the MSI capability in the
HyperTransport configuration space, and use it in the generic HT MSI
quirk (only used for HT2000 so far) and in the CK804 specific quirk
(needs to check 2 HT MSI mapping).

Finally, we rename PCI_CAP_ID_HT_IRQCONF to PCI_CAP_ID_HT since its
value is the capability and not the irqconf subtype.

Signed-off-by: Brice Goglin <brice@myri.com>

---

I do not split this patch in multiple pieces since it is still small
and this is just a RFC. I will split it for the actual submission.

The patch adds PCI_DEVICE_ID_NVIDIA_CK804_PCIE to pciids.h and may thus
conflict with pci-nvidia-quirk-to-make-aer-pci-e-extended-capability-visible.patch
which adds it too (it has been pushed in Greg K-H's patchset today).


 Documentation/kernel-parameters.txt |    6 +
 arch/powerpc/sysdev/mpic.c          |    2
 drivers/pci/msi.c                   |   58 ++++++++++-----
 drivers/pci/pci.c                   |    2
 drivers/pci/pci.h                   |    1
 drivers/pci/probe.c                 |    2
 drivers/pci/quirks.c                |   95 +++++++++++++++++++++++++-
 include/linux/pci.h                 |    3
 include/linux/pci_ids.h             |    2
 include/linux/pci_regs.h            |    2
 10 files changed, 147 insertions(+), 26 deletions(-)

Index: linux-mm/drivers/pci/msi.c
===================================================================
--- linux-mm.orig/drivers/pci/msi.c	2006-06-12 10:08:25.000000000 -0400
+++ linux-mm/drivers/pci/msi.c	2006-06-13 14:55:36.000000000 -0400
@@ -28,6 +28,7 @@
 static kmem_cache_t* msi_cachep;
 
 static int pci_msi_enable = 1;
+static int pci_msi_force = 0;
 static int last_alloc_vector;
 static int nr_released_vectors;
 static int nr_reserved_vectors = NR_HP_RESERVED_VECTORS;
@@ -902,6 +903,34 @@
 }
 
 /**
+ * pci_msi_enabled - check whether MSI may be enabled on device
+ * @dev: pointer to the pci_dev data structure of MSI device function
+ *
+ * Check parent busses for MSI or NO_MSI flags, or disable except
+ * if forced.
+ **/
+int pci_msi_enabled(struct pci_dev * dev)
+{
+	struct pci_dev *pdev;
+
+	if (!pci_msi_enable || !dev || dev->no_msi)
+ 		return -1;
+
+	/* find root complex for our device */
+	pdev = dev;
+	while (pdev->bus && pdev->bus->self)
+		pdev = pdev->bus->self;
+
+	/* check its bus flags */
+	if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_MSI)
+		return 0;
+	if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+		return -1;
+
+	return pci_msi_force ? 0 : -1;
+}
+
+/**
  * pci_enable_msi - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
  *
@@ -913,19 +942,11 @@
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
-	struct pci_bus *bus;
-	int pos, temp, status = -EINVAL;
+	int pos, temp, status;
 	u16 control;
 
-	if (!pci_msi_enable || !dev)
- 		return status;
-
-	if (dev->no_msi)
-		return status;
-
-	for (bus = dev->bus; bus; bus = bus->parent)
-		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			return -EINVAL;
+	if (pci_msi_enabled(dev) < 0)
+		return -EINVAL;
 
 	temp = dev->irq;
 
@@ -1135,22 +1156,14 @@
  **/
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 {
-	struct pci_bus *bus;
 	int status, pos, nr_entries, free_vectors;
 	int i, j, temp;
 	u16 control;
 	unsigned long flags;
 
-	if (!pci_msi_enable || !dev || !entries)
- 		return -EINVAL;
-
-	if (dev->no_msi)
+	if (!entries || pci_msi_enabled(dev) < 0)
 		return -EINVAL;
 
-	for (bus = dev->bus; bus; bus = bus->parent)
-		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			return -EINVAL;
-
 	status = msi_init();
 	if (status < 0)
 		return status;
@@ -1350,6 +1363,11 @@
 	pci_msi_enable = 0;
 }
 
+void pci_force_msi(void)
+{
+	pci_msi_force = 1;
+}
+
 EXPORT_SYMBOL(pci_enable_msi);
 EXPORT_SYMBOL(pci_disable_msi);
 EXPORT_SYMBOL(pci_enable_msix);
Index: linux-mm/drivers/pci/pci.c
===================================================================
--- linux-mm.orig/drivers/pci/pci.c	2006-06-12 10:08:25.000000000 -0400
+++ linux-mm/drivers/pci/pci.c	2006-06-13 14:55:36.000000000 -0400
@@ -978,6 +978,8 @@
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
+			} else if (!strcmp(str, "forcemsi")) {
+				pci_force_msi();
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
Index: linux-mm/drivers/pci/pci.h
===================================================================
--- linux-mm.orig/drivers/pci/pci.h	2006-06-12 10:08:25.000000000 -0400
+++ linux-mm/drivers/pci/pci.h	2006-06-13 14:55:36.000000000 -0400
@@ -51,6 +51,7 @@
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
 void pci_no_msi(void);
+void pci_force_msi(void);
 #else
 static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
 static inline void pci_no_msi(void) { }
Index: linux-mm/drivers/pci/quirks.c
===================================================================
--- linux-mm.orig/drivers/pci/quirks.c	2006-06-12 10:08:25.000000000 -0400
+++ linux-mm/drivers/pci/quirks.c	2006-06-16 22:26:42.000000000 -0400
@@ -588,7 +588,8 @@
         
 	if (dev->subordinate) {
 		printk(KERN_WARNING "PCI: MSI quirk detected. "
-		       "PCI_BUS_FLAGS_NO_MSI set for subordinate bus.\n");
+		       "PCI_BUS_FLAGS_NO_MSI set for %s subordinate bus.\n",
+		       pci_name(dev));
 		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 	}
 
@@ -608,7 +609,9 @@
 static void __init quirk_svw_msi(struct pci_dev *dev)
 {
 	pci_msi_quirk = 1;
-	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
+	printk(KERN_WARNING "PCI: MSI quirk detected for %s. "
+	       "pci_msi_quirk set.\n",
+	       pci_name(dev));
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_svw_msi );
 #endif /* CONFIG_X86_IO_APIC */
@@ -1556,6 +1559,94 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	0x1460,		quirk_p64h2_1k_io);
 
+/* Mark MSI bus flags on chipset that are known to support it */
+static void __devinit quirk_msi_supported(struct pci_dev *dev)
+{
+	if (dev->subordinate) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "PCI_BUS_FLAGS_MSI set for subordinate bus.\n");
+		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_MSI;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, quirk_msi_supported);
+
+/* Return MSI bus flags depending on MSI HT cap */
+static pci_bus_flags_t __devinit check_msi_ht_cap(struct pci_dev *dev)
+{
+	u8 cap_off;
+	int nbcap = 0;
+	cap_off = PCI_CAPABILITY_LIST - 1;
+
+	/* go through all caps looking for a hypertransport msi mapping */
+	while (pci_read_config_byte(dev, cap_off + 1, &cap_off) == 0 &&
+		nbcap++ <= 256 / 4) {
+		u32 cap_hdr;
+		if (cap_off == 0 || cap_off == 0xff)
+			break;
+		cap_off &= 0xfc;
+		/* msi mapping section according to hypertransport spec */
+		if (pci_read_config_dword(dev, cap_off, &cap_hdr) == 0
+		    && (cap_hdr & 0xff) == PCI_CAP_ID_HT /* hypertransport cap */
+		    && (cap_hdr & 0xf8000000) == 0xa8000000 /* msi mapping */) {
+			printk(KERN_INFO "PCI: Found MSI HT mapping on %s\n",
+			       pci_name(dev));
+			return cap_hdr & 0x10000 /* msi mapping cap enabled */
+			    ? PCI_BUS_FLAGS_MSI : PCI_BUS_FLAGS_NO_MSI;
+		}
+	}
+	return 0;
+}
+
+/* Check the hypertransport MSI mapping to know whether MSI is enabled or not */
+static void __devinit quirk_msi_ht_cap(struct pci_dev *dev)
+{
+	pci_bus_flags_t flags;
+
+	if (!dev->subordinate)
+		return;
+
+	flags = check_msi_ht_cap(dev);
+	if (flags) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "%s set for %s subordinate bus.\n",
+		       flags == PCI_BUS_FLAGS_NO_MSI ?
+			   "PCI_BUS_FLAGS_NO_MSI" : "PCI_BUS_FLAGS_MSI",
+		       pci_name(dev));
+		dev->subordinate->bus_flags |= flags;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE, quirk_msi_ht_cap);
+
+/* The nVidia CK804 PCI-E might have 2 hypertransport MSI mapping.
+ * MSI are supported if the MSI cap is enabled on one of them.
+ */
+static void __devinit quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
+{
+	struct pci_dev *pdev;
+	pci_bus_flags_t flags;
+
+	if (!dev->subordinate)
+		return;
+
+	/* check MSI HT cap on this chipset and the root one.
+	 * a single MSI flag is enough to be sure that MSI are supported.
+	 */
+	pdev = pci_find_slot(dev->bus->number, 0);
+	flags = check_msi_ht_cap(dev) | check_msi_ht_cap(pdev);
+	if (flags & PCI_BUS_FLAGS_MSI)
+		flags = PCI_BUS_FLAGS_MSI;
+
+	if (flags) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "%s set for %s subordinate bus.\n",
+		       flags == PCI_BUS_FLAGS_NO_MSI ?
+			   "PCI_BUS_FLAGS_NO_MSI" : "PCI_BUS_FLAGS_MSI",
+		       pci_name(dev));
+		dev->subordinate->bus_flags |= flags;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE, quirk_nvidia_ck804_msi_ht_cap);
+
 EXPORT_SYMBOL(pcie_mch_quirk);
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_fixup_device);
Index: linux-mm/include/linux/pci.h
===================================================================
--- linux-mm.orig/include/linux/pci.h	2006-06-12 10:08:25.000000000 -0400
+++ linux-mm/include/linux/pci.h	2006-06-13 14:55:37.000000000 -0400
@@ -97,6 +97,7 @@
 typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI = (__force pci_bus_flags_t) 1,
+	PCI_BUS_FLAGS_MSI = (__force pci_bus_flags_t) 2,
 };
 
 struct pci_cap_saved_state {
@@ -242,7 +243,7 @@
 	char		name[48];
 
 	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
-	pci_bus_flags_t bus_flags;	/* Inherited by child busses */
+	pci_bus_flags_t bus_flags;
 	struct device		*bridge;
 	struct class_device	class_dev;
 	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
Index: linux-mm/include/linux/pci_ids.h
===================================================================
--- linux-mm.orig/include/linux/pci_ids.h	2006-06-12 10:08:25.000000000 -0400
+++ linux-mm/include/linux/pci_ids.h	2006-06-13 14:59:58.000000000 -0400
@@ -1027,6 +1027,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
 #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
 #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
+#define PCI_DEVICE_ID_NVIDIA_CK804_PCIE		0x005d
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
@@ -1405,6 +1406,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_LE	  0x0009
 #define PCI_DEVICE_ID_SERVERWORKS_GCNB_LE 0x0017
 #define PCI_DEVICE_ID_SERVERWORKS_EPB	  0x0103
+#define PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE	0x0132
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6    0x0203
Index: linux-mm/Documentation/kernel-parameters.txt
===================================================================
--- linux-mm.orig/Documentation/kernel-parameters.txt	2006-06-12 10:08:25.000000000 -0400
+++ linux-mm/Documentation/kernel-parameters.txt	2006-06-13 14:55:37.000000000 -0400
@@ -1190,6 +1190,12 @@
 		nomsi		[MSI] If the PCI_MSI kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of MSI interrupts system-wide.
+		forcemsi	[MSI] If the PCI_MSI kernel config parameter is
+				enabled, force MSI to be enabled when its support
+				in parent busses is unknown. By default, MSI
+				are only enabled when parent busses are known
+				to support it. This option does not force MSI
+				when parent busses are known to not support it.
 		nosort		[IA-32] Don't sort PCI devices according to
 				order given by the PCI BIOS. This sorting is
 				done to get a device order compatible with
Index: linux-mm/drivers/pci/probe.c
===================================================================
--- linux-mm.orig/drivers/pci/probe.c	2006-06-12 10:08:25.000000000 -0400
+++ linux-mm/drivers/pci/probe.c	2006-06-13 14:55:37.000000000 -0400
@@ -351,7 +351,7 @@
 	child->parent = parent;
 	child->ops = parent->ops;
 	child->sysdata = parent->sysdata;
-	child->bus_flags = parent->bus_flags;
+	child->bus_flags = 0;
 	child->bridge = get_device(&bridge->dev);
 
 	child->class_dev.class = &pcibus_class;
Index: linux-mm/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-mm.orig/arch/powerpc/sysdev/mpic.c	2006-06-16 22:20:49.000000000 -0400
+++ linux-mm/arch/powerpc/sysdev/mpic.c	2006-06-16 22:20:57.000000000 -0400
@@ -250,7 +250,7 @@
 	for (pos = readb(devbase + PCI_CAPABILITY_LIST); pos != 0;
 	     pos = readb(devbase + pos + PCI_CAP_LIST_NEXT)) {
 		u8 id = readb(devbase + pos + PCI_CAP_LIST_ID);
-		if (id == PCI_CAP_ID_HT_IRQCONF) {
+		if (id == PCI_CAP_ID_HT) {
 			id = readb(devbase + pos + 3);
 			if (id == 0x80)
 				break;
Index: linux-mm/include/linux/pci_regs.h
===================================================================
--- linux-mm.orig/include/linux/pci_regs.h	2006-06-16 22:21:33.000000000 -0400
+++ linux-mm/include/linux/pci_regs.h	2006-06-16 22:22:00.000000000 -0400
@@ -196,7 +196,7 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
-#define  PCI_CAP_ID_HT_IRQCONF	0x08	/* HyperTransport IRQ Configuration */
+#define  PCI_CAP_ID_HT		0x08	/* HyperTransport capability */
 #define  PCI_CAP_ID_VNDR	0x09	/* Vendor specific capability */
 #define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
 #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */


