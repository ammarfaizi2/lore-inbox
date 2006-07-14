Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWGNHjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWGNHjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 03:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWGNHjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 03:39:53 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:34242 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964797AbWGNHjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 03:39:52 -0400
Date: Fri, 14 Jul 2006 03:34:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch, take 3] PCI: use ACPI to verify extended config space
  on x86
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rajesh Shah <rajesh.shah@intel.com>, "Brown, Len" <len.brown@intel.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Message-ID: <200607140336_MC3-1-C4F8-374F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajesh Shah <rajesh.shah@intel.com>

Extend the verification for PCI-X/PCI-Express extended config
space pointer. Checks whether the MCFG address range is listed
as a motherboard resource, per the PCI firmware spec.

The old check only looked in int 15 e820 memory map, causing
several systems to fail the verification and lose extended
config space.

Uses common code shared between i386 and x86_64.

Declaration of is_acpi_reserved() is now in <acpi/acpi_drivers.h>

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc1-64.orig/arch/i386/pci/acpi.c
+++ 2.6.18-rc1-64/arch/i386/pci/acpi.c
@@ -5,6 +5,107 @@
 #include <asm/numa.h>
 #include "pci.h"
 
+static int __init is_motherboard_resource(acpi_handle handle)
+{
+       acpi_status status;
+       struct acpi_device_info *info;
+       struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+       int i;
+
+       status = acpi_get_object_info(handle, &buffer);
+       if (ACPI_FAILURE(status))
+	       return 0;
+       info = buffer.pointer;
+       if ((info->valid & ACPI_VALID_HID) &&
+		       (!strcmp(ACPI_MB_HID1, info->hardware_id.value) ||
+			!strcmp(ACPI_MB_HID2, info->hardware_id.value))) {
+	       kfree(buffer.pointer);
+	       return 1;
+       }
+       if (info->valid & ACPI_VALID_CID) {
+	       for (i=0; i < info->compatibility_id.count; i++) {
+		       if (!strcmp(ACPI_MB_HID1,
+				info->compatibility_id.id[i].value) ||
+				!strcmp(ACPI_MB_HID2,
+					info->compatibility_id.id[i].value)) {
+                                        kfree(buffer.pointer);
+                                        return 1;
+			}
+		}
+	}
+	kfree(buffer.pointer);
+        return 0;
+}
+
+static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
+		void *data)
+{
+	struct resource *mcfg_res = data;
+	struct acpi_resource_address64 address;
+	acpi_status status;
+
+	if (res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
+		struct acpi_resource_fixed_memory32 *fixmem32;
+
+		fixmem32 = &res->data.fixed_memory32;
+		if (!fixmem32)
+			return AE_OK;
+		if ((mcfg_res->start >= fixmem32->address) &&
+			(mcfg_res->end <= (fixmem32->address +
+					   fixmem32->address_length))) {
+			mcfg_res->flags = 1;
+			return AE_CTRL_TERMINATE;
+		}
+	}
+	if ((res->type != ACPI_RESOURCE_TYPE_ADDRESS32) &&
+			(res->type != ACPI_RESOURCE_TYPE_ADDRESS64))
+		return AE_OK;
+
+	status = acpi_resource_to_address64(res, &address);
+	if (ACPI_FAILURE(status) || (address.address_length <= 0) ||
+			(address.resource_type != ACPI_MEMORY_RANGE))
+		return AE_OK;
+
+	if ((mcfg_res->start >= address.minimum) &&
+			(mcfg_res->end <=
+			 (address.minimum +address.address_length))) {
+		mcfg_res->flags = 1;
+		return AE_CTRL_TERMINATE;
+	}
+	return AE_OK;
+}
+
+static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
+		void *context, void **rv)
+{
+	struct resource *mcfg_res = context;
+	acpi_status status = AE_OK;
+
+	/* Stop namespace scanning if we've already verified MMCONFIG */
+	if (mcfg_res->flags)
+		return AE_CTRL_TERMINATE;
+
+	if (is_motherboard_resource(handle)) {
+		status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				check_mcfg_resource, context);
+	}
+	return status;
+}
+
+int __init is_acpi_reserved(unsigned long start, unsigned long end)
+{
+	struct resource mcfg_res;
+
+	mcfg_res.start = start;
+	mcfg_res.end = end;
+	mcfg_res.flags = 0;
+
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, find_mboard_resource,
+			(void *)&mcfg_res, NULL);
+	return mcfg_res.flags;
+}
+
 struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_device *device, int domain, int busnum)
 {
 	struct pci_bus *bus;
--- 2.6.18-rc1-64.orig/arch/i386/pci/mmconfig.c
+++ 2.6.18-rc1-64/arch/i386/pci/mmconfig.c
@@ -201,10 +201,15 @@ void __init pci_mmcfg_init(void)
 	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
 			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+		if (!is_acpi_reserved(pci_mmcfg_config[0].base_address,
+					pci_mmcfg_config[0].base_address +
+					MMCONFIG_APER_MIN)) {
+			printk(KERN_ERR
+				"PCI: BIOS Bug: MCFG area at %x not reserved\n",
 				pci_mmcfg_config[0].base_address);
-		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
-		return;
+			printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
+			return;
+		}
 	}
 
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
--- 2.6.18-rc1-64.orig/drivers/acpi/motherboard.c
+++ 2.6.18-rc1-64/drivers/acpi/motherboard.c
@@ -32,9 +32,6 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("acpi_motherboard")
 
-/* Dell use PNP0C01 instead of PNP0C02 */
-#define ACPI_MB_HID1			"PNP0C01"
-#define ACPI_MB_HID2			"PNP0C02"
 /**
  * Doesn't care about legacy IO ports, only IO ports beyond 0x1000 are reserved
  * Doesn't care about the failure of 'request_region', since other may reserve
--- 2.6.18-rc1-64.orig/include/acpi/aclocal.h
+++ 2.6.18-rc1-64/include/acpi/aclocal.h
@@ -696,6 +696,10 @@ struct acpi_parse_state {
 
 #define PCI_ROOT_HID_STRING             "PNP0A03"
 #define PCI_EXPRESS_ROOT_HID_STRING     "PNP0A08"
+/* Dell use PNP0C01 instead of PNP0C02 */
+#define ACPI_MB_HID1			"PNP0C01"
+#define ACPI_MB_HID2			"PNP0C02"
+
 
 struct acpi_bit_register_info {
 	u8 parent_register;
--- 2.6.18-rc1-64.orig/include/acpi/acpi_drivers.h
+++ 2.6.18-rc1-64/include/acpi/acpi_drivers.h
@@ -76,6 +76,10 @@ int acpi_pci_bind_root(struct acpi_devic
 struct pci_bus *pci_acpi_scan_root(struct acpi_device *device, int domain,
 				   int bus);
 
+/* Arch-defined function to check if region is acpi-reserved */
+
+extern int is_acpi_reserved(unsigned long start, unsigned long end);
+
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
--- 2.6.18-rc1-64.orig/arch/x86_64/pci/mmconfig.c
+++ 2.6.18-rc1-64/arch/x86_64/pci/mmconfig.c
@@ -180,10 +180,15 @@ void __init pci_mmcfg_init(void)
 	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
 			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+		if (!is_acpi_reserved(pci_mmcfg_config[0].base_address,
+					pci_mmcfg_config[0].base_address +
+					MMCONFIG_APER_MIN)) {
+			printk(KERN_ERR
+				"PCI: BIOS Bug: MCFG area at %x is not reserved\n",
 				pci_mmcfg_config[0].base_address);
-		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
-		return;
+			printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
+			return;
+		}
 	}
 
 	/* RED-PEN i386 doesn't do _nocache right now */
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
