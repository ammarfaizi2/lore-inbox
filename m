Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVBRXzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVBRXzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVBRXzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:55:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261568AbVBRXyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:54:21 -0500
Date: Sat, 19 Feb 2005 00:54:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [RFC: 2.6 patch] drivers/pci/: possible cleanups
Message-ID: <20050218235419.GE4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- pci-acpi.c: make OSC_UUID static
- remove the following unused functions:
  - pci-acpi.c: acpi_query_osc
  - pci-acpi.c: pci_osc_support_set
  - pci.c: pci_find_ext_capability
  - rom.c: pci_map_rom_copy
  - rom.c: pci_remove_rom
- remove the following unneeded EXPORT_SYMBOL's:
  - pci-acpi.c: pci_osc_support_set
  - rom.c: pci_map_rom_copy
  - rom.c: pci_remove_rom

Which of these changes are correct and which conflict with pending 
patches?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/pci-acpi.c   |   97 ---------------------------------------
 drivers/pci/pci.c        |   48 -------------------
 drivers/pci/rom.c        |   54 ---------------------
 include/linux/pci-acpi.h |    2 
 include/linux/pci.h      |    4 -
 5 files changed, 1 insertion(+), 204 deletions(-)

--- linux-2.6.11-rc3-mm2-full/include/linux/pci-acpi.h.old	2005-02-17 23:18:44.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/include/linux/pci-acpi.h	2005-02-17 23:18:54.000000000 +0100
@@ -48,14 +48,12 @@
 
 #ifdef CONFIG_ACPI
 extern acpi_status pci_osc_control_set(u32 flags);
-extern acpi_status pci_osc_support_set(u32 flags);
 #else
 #if !defined(acpi_status)
 typedef u32 		acpi_status;
 #define AE_ERROR      	(acpi_status) (0x0001)
 #endif    
 static inline acpi_status pci_osc_control_set(u32 flags) {return AE_ERROR;}
-static inline acpi_status pci_osc_support_set(u32 flags) {return AE_ERROR;} 
 #endif
 
 #endif	/* _PCI_ACPI_H_ */
--- linux-2.6.11-rc3-mm2-full/drivers/pci/pci-acpi.c.old	2005-02-17 23:17:28.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/pci/pci-acpi.c	2005-02-17 23:48:50.000000000 +0100
@@ -19,72 +19,7 @@
 
 static u32 ctrlset_buf[3] = {0, 0, 0};
 static u32 global_ctrlsets = 0;
-u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
-
-static acpi_status  
-acpi_query_osc (
-	acpi_handle	handle,
-	u32		level,
-	void		*context,
-	void		**retval )
-{
-	acpi_status		status;
-	struct acpi_object_list	input;
-	union acpi_object 	in_params[4];
-	struct acpi_buffer	output;
-	union acpi_object 	out_obj;	
-	u32			osc_dw0;
-
-	/* Setting up output buffer */
-	output.length = sizeof(out_obj) + 3*sizeof(u32);  
-	output.pointer = &out_obj;
-	
-	/* Setting up input parameters */
-	input.count = 4;
-	input.pointer = in_params;
-	in_params[0].type 		= ACPI_TYPE_BUFFER;
-	in_params[0].buffer.length 	= 16;
-	in_params[0].buffer.pointer	= OSC_UUID;
-	in_params[1].type 		= ACPI_TYPE_INTEGER;
-	in_params[1].integer.value 	= 1;
-	in_params[2].type 		= ACPI_TYPE_INTEGER;
-	in_params[2].integer.value	= 3;
-	in_params[3].type		= ACPI_TYPE_BUFFER;
-	in_params[3].buffer.length 	= 12;
-	in_params[3].buffer.pointer 	= (u8 *)context;
-
-	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE (status)) {
-		printk(KERN_DEBUG  
-			"Evaluate _OSC Set fails. Status = 0x%04x\n", status);
-		return status;
-	}
-	if (out_obj.type != ACPI_TYPE_BUFFER) {
-		printk(KERN_DEBUG  
-			"Evaluate _OSC returns wrong type\n");
-		return AE_TYPE;
-	}
-	osc_dw0 = *((u32 *) out_obj.buffer.pointer);
-	if (osc_dw0) {
-		if (osc_dw0 & OSC_REQUEST_ERROR)
-			printk(KERN_DEBUG "_OSC request fails\n"); 
-		if (osc_dw0 & OSC_INVALID_UUID_ERROR)
-			printk(KERN_DEBUG "_OSC invalid UUID\n"); 
-		if (osc_dw0 & OSC_INVALID_REVISION_ERROR)
-			printk(KERN_DEBUG "_OSC invalid revision\n"); 
-		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
-			/* Update Global Control Set */
-			global_ctrlsets = *((u32 *)(out_obj.buffer.pointer+8));
-			return AE_OK;
-		}
-		return AE_ERROR;
-	}
-
-	/* Update Global Control Set */
-	global_ctrlsets = *((u32 *)(out_obj.buffer.pointer + 8));
-	return AE_OK;
-}
-
+static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
 
 static acpi_status  
 acpi_run_osc (
@@ -147,36 +82,6 @@
 }
 
 /**
- * pci_osc_support_set - register OS support to Firmware
- * @flags: OS support bits
- *
- * Update OS support fields and doing a _OSC Query to obtain an update
- * from Firmware on supported control bits.
- **/
-acpi_status pci_osc_support_set(u32 flags)
-{
-	u32 temp;
-
-	if (!(flags & OSC_SUPPORT_MASKS)) {
-		return AE_TYPE;
-	}
-	ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
-
-	/* do _OSC query for all possible controls */
-	temp = ctrlset_buf[OSC_CONTROL_TYPE];
-	ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
-	acpi_get_devices ( PCI_ROOT_HID_STRING,
-			acpi_query_osc,
-			ctrlset_buf,
-			NULL );
-	ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] = temp;
-	return AE_OK;
-}
-EXPORT_SYMBOL(pci_osc_support_set);
-
-/**
  * pci_osc_control_set - commit requested control to Firmware
  * @flags: driver's requested control bits
  *
--- linux-2.6.11-rc3-mm2-full/include/linux/pci.h.old	2005-02-17 23:20:31.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/include/linux/pci.h	2005-02-17 23:22:55.000000000 +0100
@@ -758,7 +758,6 @@
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
-int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from);
@@ -815,9 +814,7 @@
 
 /* ROM control related routines */
 void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size);
-void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size);
 void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom);
-void pci_remove_rom(struct pci_dev *pdev);
 
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);
@@ -945,7 +942,6 @@
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
-static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
 /* Power management related routines */
--- linux-2.6.11-rc3-mm2-full/drivers/pci/pci.c.old	2005-02-17 23:20:50.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/pci/pci.c	2005-02-17 23:21:04.000000000 +0100
@@ -147,54 +147,6 @@
 }
 
 /**
- * pci_find_ext_capability - Find an extended capability
- * @dev: PCI device to query
- * @cap: capability code
- *
- * Returns the address of the requested extended capability structure
- * within the device's PCI configuration space or 0 if the device does
- * not support it.  Possible values for @cap:
- *
- *  %PCI_EXT_CAP_ID_ERR		Advanced Error Reporting
- *  %PCI_EXT_CAP_ID_VC		Virtual Channel
- *  %PCI_EXT_CAP_ID_DSN		Device Serial Number
- *  %PCI_EXT_CAP_ID_PWR		Power Budgeting
- */
-int pci_find_ext_capability(struct pci_dev *dev, int cap)
-{
-	u32 header;
-	int ttl = 480; /* 3840 bytes, minimum 8 bytes per capability */
-	int pos = 0x100;
-
-	if (dev->cfg_size <= 256)
-		return 0;
-
-	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
-		return 0;
-
-	/*
-	 * If we have no capabilities, this is indicated by cap ID,
-	 * cap version and next pointer all being 0.
-	 */
-	if (header == 0)
-		return 0;
-
-	while (ttl-- > 0) {
-		if (PCI_EXT_CAP_ID(header) == cap)
-			return pos;
-
-		pos = PCI_EXT_CAP_NEXT(header);
-		if (pos < 0x100)
-			break;
-
-		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
-			break;
-	}
-
-	return 0;
-}
-
-/**
  * pci_find_parent_resource - return resource region of parent bus of given region
  * @dev: PCI device structure contains resources to be searched
  * @res: child resource record for which parent is sought
--- linux-2.6.11-rc3-mm2-full/drivers/pci/rom.c.old	2005-02-17 23:22:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/pci/rom.c	2005-02-17 23:23:01.000000000 +0100
@@ -131,40 +131,6 @@
 }
 
 /**
- * pci_map_rom_copy - map a PCI ROM to kernel space, create a copy
- * @dev: pointer to pci device struct
- * @size: pointer to receive size of pci window over ROM
- * @return: kernel virtual pointer to image of ROM
- *
- * Map a PCI ROM into kernel space. If ROM is boot video ROM,
- * the shadow BIOS copy will be returned instead of the
- * actual ROM.
- */
-void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size)
-{
-	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-	void __iomem *rom;
-
-	rom = pci_map_rom(pdev, size);
-	if (!rom)
-		return NULL;
-
-	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_SHADOW))
-		return rom;
-
-	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);
-	if (!res->start)
-		return rom;
-
-	res->end = res->start + *size;
-	memcpy_fromio((void*)res->start, rom, *size);
-	pci_unmap_rom(pdev, rom);
-	res->flags |= IORESOURCE_ROM_COPY;
-
-	return (void __iomem *)res->start;
-}
-
-/**
  * pci_unmap_rom - unmap the ROM from kernel space
  * @dev: pointer to pci device struct
  * @rom: virtual address of the previous mapping
@@ -186,24 +152,6 @@
 }
 
 /**
- * pci_remove_rom - disable the ROM and remove its sysfs attribute
- * @dev: pointer to pci device struct
- *
- * Remove the rom file in sysfs and disable ROM decoding.
- */
-void pci_remove_rom(struct pci_dev *pdev)
-{
-	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-
-	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
-		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
-	if (!(res->flags & (IORESOURCE_ROM_ENABLE |
-			    IORESOURCE_ROM_SHADOW |
-			    IORESOURCE_ROM_COPY)))
-		pci_disable_rom(pdev);
-}
-
-/**
  * pci_cleanup_rom - internal routine for freeing the ROM copy created
  * by pci_map_rom_copy called from remove.c
  * @dev: pointer to pci device struct
@@ -222,6 +170,4 @@
 }
 
 EXPORT_SYMBOL(pci_map_rom);
-EXPORT_SYMBOL(pci_map_rom_copy);
 EXPORT_SYMBOL(pci_unmap_rom);
-EXPORT_SYMBOL(pci_remove_rom);

