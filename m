Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWF0AwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWF0AwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWF0Avv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:51:51 -0400
Received: from mga06.intel.com ([134.134.136.21]:48020 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030303AbWF0Avr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:51:47 -0400
X-IronPort-AV: i="4.06,178,1149490800"; 
   d="scan'208"; a="57046543:sNHT96092696"
Message-Id: <20060627004920.378187000@rshah1-sfield.jf.intel.com>
References: <20060627004556.809330000@rshah1-sfield.jf.intel.com>
Date: Mon, 26 Jun 2006 17:45:57 -0700
From: rajesh.shah@intel.com
To: ak@suse.de, gregkh@suse.de, len.brown@intel.com
Cc: akpm@osdl.org, arjan@linux.intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Rajesh Shah <rajesh.shah@intel.com>
Subject: [patch 1/2] i386 PCI: improve extended config space verification
Content-Disposition: inline; filename=i386-fix-mcfg-check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the verification for PCI-X/PCI-Express extended config
space pointer. This patch checks whether the MCFG address range
is listed as a motherboard resource, per the PCI firmware spec.
The old check only looked in int 15 e820 memory map, causing
several systems to fail the verification and lose extended
config space.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 arch/i386/pci/acpi.c       |  101 +++++++++++++++++++++++++++++++++++++++++++++
 arch/i386/pci/mmconfig.c   |   11 +++-
 drivers/acpi/motherboard.c |    3 -
 include/acpi/aclocal.h     |    4 +
 4 files changed, 113 insertions(+), 6 deletions(-)

Index: linux-2.6.17-mm2/arch/i386/pci/acpi.c
===================================================================
--- linux-2.6.17-mm2.orig/arch/i386/pci/acpi.c
+++ linux-2.6.17-mm2/arch/i386/pci/acpi.c
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
Index: linux-2.6.17-mm2/arch/i386/pci/mmconfig.c
===================================================================
--- linux-2.6.17-mm2.orig/arch/i386/pci/mmconfig.c
+++ linux-2.6.17-mm2/arch/i386/pci/mmconfig.c
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
Index: linux-2.6.17-mm2/drivers/acpi/motherboard.c
===================================================================
--- linux-2.6.17-mm2.orig/drivers/acpi/motherboard.c
+++ linux-2.6.17-mm2/drivers/acpi/motherboard.c
@@ -32,9 +32,6 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("acpi_motherboard")
 
-/* Dell use PNP0C01 instead of PNP0C02 */
-#define ACPI_MB_HID1			"PNP0C01"
-#define ACPI_MB_HID2			"PNP0C02"
 /**
  * Doesn't care about legacy IO ports, only IO ports beyond 0x1000 are reserved
  * Doesn't care about the failure of 'request_region', since other may reserve
Index: linux-2.6.17-mm2/include/acpi/aclocal.h
===================================================================
--- linux-2.6.17-mm2.orig/include/acpi/aclocal.h
+++ linux-2.6.17-mm2/include/acpi/aclocal.h
@@ -697,6 +697,10 @@ struct acpi_parse_state {
 
 #define PCI_ROOT_HID_STRING             "PNP0A03"
 #define PCI_EXPRESS_ROOT_HID_STRING     "PNP0A08"
+/* Dell use PNP0C01 instead of PNP0C02 */
+#define ACPI_MB_HID1			"PNP0C01"
+#define ACPI_MB_HID2			"PNP0C02"
+
 
 struct acpi_bit_register_info {
 	u8 parent_register;

--
