Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTEJJpn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTEJJpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:45:43 -0400
Received: from palrel13.hp.com ([156.153.255.238]:26563 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263717AbTEJJpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:45:34 -0400
Date: Sat, 10 May 2003 02:56:58 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200305100956.h4A9uwSd012171@napali.hpl.hp.com>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: fix AGP drivers for ia64 hp zx1 and intel i460 chipsets
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

More fixes for the ia64 AGP drivers.

Thanks,

	--david

diff -Nru a/drivers/char/agp/hp-agp.c b/drivers/char/agp/hp-agp.c
--- a/drivers/char/agp/hp-agp.c	Sat May 10 01:47:43 2003
+++ b/drivers/char/agp/hp-agp.c	Sat May 10 01:47:43 2003
@@ -1,17 +1,36 @@
 /*
- * HP AGPGART routines. 
+ * HP AGPGART routines.
+ *	Copyright (C) 2002-2003 Hewlett-Packard Co
+ *		Bjorn Helgaas <bjorn_helgaas@hp.com>
  */
 
+#include <linux/acpi.h>
+#include <linux/agp_backend.h>
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/agp_backend.h>
+
+#include <asm/acpi-ext.h>
+
 #include "agp.h"
 
 #ifndef log2
 #define log2(x)		ffz(~(x))
 #endif
 
+#define HP_ZX1_IOC_OFFSET	0x1000  /* ACPI reports SBA, we want IOC */
+
+/* HP ZX1 IOC registers */
+#define HP_ZX1_IBASE		0x300
+#define HP_ZX1_IMASK		0x308
+#define HP_ZX1_PCOM		0x310
+#define HP_ZX1_TCNFG		0x318
+#define HP_ZX1_PDIR_BASE	0x320
+
+/* HP ZX1 LBA registers */
+#define HP_ZX1_AGP_STATUS	0x64
+#define HP_ZX1_AGP_COMMAND	0x68
+
 #define HP_ZX1_IOVA_BASE	GB(1UL)
 #define HP_ZX1_IOVA_SIZE	GB(1UL)
 #define HP_ZX1_GART_SIZE	(HP_ZX1_IOVA_SIZE / 2)
@@ -20,6 +39,9 @@
 #define HP_ZX1_PDIR_VALID_BIT	0x8000000000000000UL
 #define HP_ZX1_IOVA_TO_PDIR(va)	((va - hp_private.iova_base) >> hp_private.io_tlb_shift)
 
+/* AGP bridge need not be PCI device, but DRM thinks it is. */
+static struct pci_dev fake_bridge_dev;
+
 static struct aper_size_info_fixed hp_zx1_sizes[] =
 {
 	{0, 0, 0},		/* filled in by hp_zx1_fetch_size() */
@@ -31,8 +53,8 @@
 };
 
 static struct _hp_private {
-	struct pci_dev *ioc;
-	volatile u8 *registers;
+	volatile u8 *ioc_regs;
+	volatile u8 *lba_regs;
 	u64 *io_pdir;		// PDIR for entire IOVA
 	u64 *gatt;		// PDIR just for GART (subset of above)
 	u64 gatt_entries;
@@ -47,7 +69,8 @@
 	int io_pages_per_kpage;
 } hp_private;
 
-static int __init hp_zx1_ioc_shared(void)
+static int __init
+hp_zx1_ioc_shared (void)
 {
 	struct _hp_private *hp = &hp_private;
 
@@ -59,7 +82,7 @@
 	 * 	- IOVA space is 1Gb in size
 	 * 	- first 512Mb is IOMMU, second 512Mb is GART
 	 */
-	hp->io_tlb_ps = INREG64(hp->registers, HP_ZX1_TCNFG);
+	hp->io_tlb_ps = INREG64(hp->ioc_regs, HP_ZX1_TCNFG);
 	switch (hp->io_tlb_ps) {
 		case 0: hp->io_tlb_shift = 12; break;
 		case 1: hp->io_tlb_shift = 13; break;
@@ -75,13 +98,13 @@
 	hp->io_page_size = 1 << hp->io_tlb_shift;
 	hp->io_pages_per_kpage = PAGE_SIZE / hp->io_page_size;
 
-	hp->iova_base = INREG64(hp->registers, HP_ZX1_IBASE) & ~0x1;
+	hp->iova_base = INREG64(hp->ioc_regs, HP_ZX1_IBASE) & ~0x1;
 	hp->gart_base = hp->iova_base + HP_ZX1_IOVA_SIZE - HP_ZX1_GART_SIZE;
 
 	hp->gart_size = HP_ZX1_GART_SIZE;
 	hp->gatt_entries = hp->gart_size / hp->io_page_size;
 
-	hp->io_pdir = phys_to_virt(INREG64(hp->registers, HP_ZX1_PDIR_BASE));
+	hp->io_pdir = phys_to_virt(INREG64(hp->ioc_regs, HP_ZX1_PDIR_BASE));
 	hp->gatt = &hp->io_pdir[HP_ZX1_IOVA_TO_PDIR(hp->gart_base)];
 
 	if (hp->gatt[0] != HP_ZX1_SBA_IOMMU_COOKIE) {
@@ -95,7 +118,8 @@
 	return 0;
 }
 
-static int __init hp_zx1_ioc_owner(u8 ioc_rev)
+static int __init
+hp_zx1_ioc_owner (void)
 {
 	struct _hp_private *hp = &hp_private;
 
@@ -130,47 +154,28 @@
 	return 0;
 }
 
-static int __init hp_zx1_ioc_init(void)
+static int __init
+hp_zx1_ioc_init (u64 ioc_hpa, u64 lba_hpa)
 {
 	struct _hp_private *hp = &hp_private;
-	struct pci_dev *ioc;
-	int i;
-	u8 ioc_rev;
-
-	ioc = pci_find_device(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_ZX1_IOC, NULL);
-	if (!ioc) {
-		printk(KERN_ERR PFX "Detected HP ZX1 AGP bridge but no IOC\n");
-		return -ENODEV;
-	}
-	hp->ioc = ioc;
-
-	pci_read_config_byte(ioc, PCI_REVISION_ID, &ioc_rev);
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		if (pci_resource_flags(ioc, i) == IORESOURCE_MEM) {
-			hp->registers = (u8 *) ioremap(pci_resource_start(ioc, i),
-						    pci_resource_len(ioc, i));
-			break;
-		}
-	}
-	if (!hp->registers) {
-		printk(KERN_ERR PFX "Detected HP ZX1 AGP bridge but no CSRs\n");
-		return -ENODEV;
-	}
+	hp->ioc_regs = ioremap(ioc_hpa, 1024);
+	hp->lba_regs = ioremap(lba_hpa, 256);
 
 	/*
 	 * If the IOTLB is currently disabled, we can take it over.
 	 * Otherwise, we have to share with sba_iommu.
 	 */
-	hp->io_pdir_owner = (INREG64(hp->registers, HP_ZX1_IBASE) & 0x1) == 0;
+	hp->io_pdir_owner = (INREG64(hp->ioc_regs, HP_ZX1_IBASE) & 0x1) == 0;
 
 	if (hp->io_pdir_owner)
-		return hp_zx1_ioc_owner(ioc_rev);
+		return hp_zx1_ioc_owner();
 
 	return hp_zx1_ioc_shared();
 }
 
-static int hp_zx1_fetch_size(void)
+static int
+hp_zx1_fetch_size (void)
 {
 	int size;
 
@@ -180,47 +185,49 @@
 	return size;
 }
 
-static int hp_zx1_configure(void)
+static int
+hp_zx1_configure (void)
 {
 	struct _hp_private *hp = &hp_private;
 
 	agp_bridge->gart_bus_addr = hp->gart_base;
-	agp_bridge->capndx = pci_find_capability(agp_bridge->dev, PCI_CAP_ID_AGP);
-	pci_read_config_dword(agp_bridge->dev,
-		agp_bridge->capndx + PCI_AGP_STATUS, &agp_bridge->mode);
+	agp_bridge->mode = INREG32(hp->lba_regs, HP_ZX1_AGP_STATUS);
 
 	if (hp->io_pdir_owner) {
-		OUTREG64(hp->registers, HP_ZX1_PDIR_BASE,
+		OUTREG64(hp->ioc_regs, HP_ZX1_PDIR_BASE,
 			virt_to_phys(hp->io_pdir));
-		OUTREG64(hp->registers, HP_ZX1_TCNFG, hp->io_tlb_ps);
-		OUTREG64(hp->registers, HP_ZX1_IMASK, ~(HP_ZX1_IOVA_SIZE - 1));
-		OUTREG64(hp->registers, HP_ZX1_IBASE, hp->iova_base | 0x1);
-		OUTREG64(hp->registers, HP_ZX1_PCOM,
+		OUTREG64(hp->ioc_regs, HP_ZX1_TCNFG, hp->io_tlb_ps);
+		OUTREG64(hp->ioc_regs, HP_ZX1_IMASK, ~(HP_ZX1_IOVA_SIZE - 1));
+		OUTREG64(hp->ioc_regs, HP_ZX1_IBASE, hp->iova_base | 0x1);
+		OUTREG64(hp->ioc_regs, HP_ZX1_PCOM,
 			hp->iova_base | log2(HP_ZX1_IOVA_SIZE));
-		INREG64(hp->registers, HP_ZX1_PCOM);
+		INREG64(hp->ioc_regs, HP_ZX1_PCOM);
 	}
 
 	return 0;
 }
 
-static void hp_zx1_cleanup(void)
+static void
+hp_zx1_cleanup (void)
 {
 	struct _hp_private *hp = &hp_private;
 
 	if (hp->io_pdir_owner)
-		OUTREG64(hp->registers, HP_ZX1_IBASE, 0);
-	iounmap((void *) hp->registers);
+		OUTREG64(hp->ioc_regs, HP_ZX1_IBASE, 0);
+	iounmap((void *) hp->ioc_regs);
 }
 
-static void hp_zx1_tlbflush(agp_memory * mem)
+static void
+hp_zx1_tlbflush (agp_memory * mem)
 {
 	struct _hp_private *hp = &hp_private;
 
-	OUTREG64(hp->registers, HP_ZX1_PCOM, hp->gart_base | log2(hp->gart_size));
-	INREG64(hp->registers, HP_ZX1_PCOM);
+	OUTREG64(hp->ioc_regs, HP_ZX1_PCOM, hp->gart_base | log2(hp->gart_size));
+	INREG64(hp->ioc_regs, HP_ZX1_PCOM);
 }
 
-static int hp_zx1_create_gatt_table(void)
+static int
+hp_zx1_create_gatt_table (void)
 {
 	struct _hp_private *hp = &hp_private;
 	int i;
@@ -247,7 +254,8 @@
 	return 0;
 }
 
-static int hp_zx1_free_gatt_table(void)
+static int
+hp_zx1_free_gatt_table (void)
 {
 	struct _hp_private *hp = &hp_private;
 
@@ -259,7 +267,8 @@
 	return 0;
 }
 
-static int hp_zx1_insert_memory(agp_memory * mem, off_t pg_start, int type)
+static int
+hp_zx1_insert_memory (agp_memory * mem, off_t pg_start, int type)
 {
 	struct _hp_private *hp = &hp_private;
 	int i, k;
@@ -304,7 +313,8 @@
 	return 0;
 }
 
-static int hp_zx1_remove_memory(agp_memory * mem, off_t pg_start, int type)
+static int
+hp_zx1_remove_memory (agp_memory * mem, off_t pg_start, int type)
 {
 	struct _hp_private *hp = &hp_private;
 	int i, io_pg_start, io_pg_count;
@@ -323,12 +333,30 @@
 	return 0;
 }
 
-static unsigned long hp_zx1_mask_memory(unsigned long addr, int type)
+static unsigned long
+hp_zx1_mask_memory(unsigned long addr, int type)
 {
 	return HP_ZX1_PDIR_VALID_BIT | addr;
 }
 
-static int __init hp_zx1_setup (struct pci_dev *pdev __attribute__((unused)))
+static void
+hp_zx1_agp_enable (u32 mode)
+{
+	struct _hp_private *hp = &hp_private;
+	u32 command;
+
+	command = INREG32(hp->lba_regs, HP_ZX1_AGP_STATUS);
+
+	command = agp_collect_device_status(mode, command);
+	command |= 0x00000100;
+
+	OUTREG32(hp->lba_regs, HP_ZX1_AGP_COMMAND, command);
+
+	agp_device_command(command, 0);
+}
+
+static int __init
+hp_zx1_setup (u64 ioc_hpa, u64 lba_hpa)
 {
 	agp_bridge->masks = hp_zx1_masks;
 	agp_bridge->dev_private_data = NULL;
@@ -339,7 +367,7 @@
 	agp_bridge->cleanup = hp_zx1_cleanup;
 	agp_bridge->tlb_flush = hp_zx1_tlbflush;
 	agp_bridge->mask_memory = hp_zx1_mask_memory;
-	agp_bridge->agp_enable = agp_generic_enable;
+	agp_bridge->agp_enable = hp_zx1_agp_enable;
 	agp_bridge->cache_flush = global_cache_flush;
 	agp_bridge->create_gatt_table = hp_zx1_create_gatt_table;
 	agp_bridge->free_gatt_table = hp_zx1_free_gatt_table;
@@ -350,73 +378,85 @@
 	agp_bridge->agp_alloc_page = agp_generic_alloc_page;
 	agp_bridge->agp_destroy_page = agp_generic_destroy_page;
 	agp_bridge->cant_use_aperture = 1;
-	return hp_zx1_ioc_init();
+
+	return hp_zx1_ioc_init(ioc_hpa, lba_hpa);
 }
 
-static int __init agp_find_supported_device(struct pci_dev *dev)
+static acpi_status __init
+zx1_gart_probe (acpi_handle obj, u32 depth, void *context, void **ret)
 {
-	agp_bridge->dev = dev;
+	acpi_handle handle, parent;
+	acpi_status status;
+	struct acpi_device_info info;
+	u64 lba_hpa, sba_hpa, length;
+
+	status = hp_acpi_csr_space(obj, &lba_hpa, &length);
+	if (ACPI_FAILURE(status))
+		return 1;
+
+	/* Look for an enclosing IOC scope and find its CSR space */
+	handle = obj;
+	do {
+		status = acpi_get_object_info(handle, &info);
+		if (ACPI_SUCCESS(status)) {
+			/* TBD check _CID also */
+			info.hardware_id[sizeof(info.hardware_id)-1] = '\0';
+			if (!strcmp(info.hardware_id, "HWP0001")) {
+				status = hp_acpi_csr_space(handle, &sba_hpa, &length);
+				if (ACPI_SUCCESS(status))
+					break;
+				else {
+					printk(KERN_ERR PFX "Detected HP ZX1 "
+					       "AGP LBA but no IOC.\n");
+					return status;
+				}
+			}
+		}
 
-	/* ZX1 LBAs can be either PCI or AGP bridges */
-	if (pci_find_capability(dev, PCI_CAP_ID_AGP)) {
-		printk(KERN_INFO PFX "Detected HP ZX1 AGP chipset at %s\n",
-			dev->slot_name);
-		agp_bridge->type = HP_ZX1;
-		agp_bridge->dev = dev;
-		return hp_zx1_setup(dev);
-	}
-	return -ENODEV;
-}
+		status = acpi_get_parent(handle, &parent);
+		handle = parent;
+	} while (ACPI_SUCCESS(status));
 
-static struct agp_driver hp_agp_driver = {
-	.owner = THIS_MODULE,
-};
+	if (hp_zx1_setup(sba_hpa + HP_ZX1_IOC_OFFSET, lba_hpa))
+		return 1;
 
-static int __init agp_hp_probe (struct pci_dev *dev, const struct pci_device_id *ent)
-{
-	if (agp_find_supported_device(dev) == 0) {
-		hp_agp_driver.dev = dev;
-		agp_register_driver(&hp_agp_driver);
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static struct pci_device_id agp_hp_pci_table[] __initdata = {
-	{
-	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
-	.class_mask	= ~0,
-	.vendor		= PCI_VENDOR_ID_HP,
-	.device		= PCI_DEVICE_ID_HP_ZX1_LBA,
-	.subvendor	= PCI_ANY_ID,
-	.subdevice	= PCI_ANY_ID,
-	},
-	{ }
-};
+	fake_bridge_dev.vendor = PCI_VENDOR_ID_HP;
+	fake_bridge_dev.device = PCI_DEVICE_ID_HP_ZX1_LBA;
 
-MODULE_DEVICE_TABLE(pci, agp_hp_pci_table);
+	return 0;
+}
 
-static struct __initdata pci_driver agp_hp_pci_driver = {
-	.name		= "agpgart-hp",
-	.id_table	= agp_hp_pci_table,
-	.probe		= agp_hp_probe,
+static struct agp_driver hp_agp_driver = {
+	.owner = THIS_MODULE,
 };
 
-static int __init agp_hp_init(void)
+static int __init
+agp_hp_init (void)
 {
-	int ret_val;
+	acpi_status status;
 
-	ret_val = pci_module_init(&agp_hp_pci_driver);
-	if (ret_val)
+	status = acpi_get_devices("HWP0003", zx1_gart_probe, "HWP0003 AGP LBA", NULL);
+	if (!(ACPI_SUCCESS(status))) {
 		agp_bridge->type = NOT_SUPPORTED;
+		printk(KERN_INFO PFX "Failed to initialize zx1 AGP.\n");
+		return -ENODEV;
+	}
 
-	return ret_val;
+	if (fake_bridge_dev.vendor && !agp_bridge->type) {
+		hp_agp_driver.dev = &fake_bridge_dev;
+		agp_bridge->type = HP_ZX1;
+		agp_bridge->dev = &fake_bridge_dev;
+		return agp_register_driver(&hp_agp_driver);
+
+	} else {
+		return -ENODEV;
+	}
 }
 
-static void __exit agp_hp_cleanup(void)
+static void __exit
+agp_hp_cleanup (void)
 {
 	agp_unregister_driver(&hp_agp_driver);
-	pci_unregister_driver(&agp_hp_pci_driver);
 }
 
 module_init(agp_hp_init);
diff -Nru a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
--- a/drivers/char/agp/i460-agp.c	Sat May 10 01:47:43 2003
+++ b/drivers/char/agp/i460-agp.c	Sat May 10 01:47:43 2003
@@ -571,6 +571,7 @@
 	if (cap_ptr == 0)
 		return -ENODEV;
 
+	agp_bridge->type = INTEL_460GX;
 	agp_bridge->dev = dev;
 	agp_bridge->capndx = cap_ptr;
 	intel_i460_setup(dev);
