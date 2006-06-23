Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752017AbWFWUOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbWFWUOH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbWFWUNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:13:50 -0400
Received: from mga07.intel.com ([143.182.124.22]:48505 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1752017AbWFWUNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:13:48 -0400
X-IronPort-AV: i="4.06,170,1149490800"; 
   d="scan'208"; a="56629578:sNHT67094685"
Message-Id: <20060623201601.752629000@rshah1-sfield.jf.intel.com>
References: <20060623200928.036235000@rshah1-sfield.jf.intel.com>
Date: Fri, 23 Jun 2006 13:09:30 -0700
From: rajesh.shah@intel.com
To: ak@suse.de, gregkh@suse.de
Cc: akpm@osdl.org, brice@myri.com, 76306.1226@compuserve.com,
       arjan@linux.intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Rajesh Shah <rajesh.shah@intel.com>
Subject: [patch 2/2] x86_64 PCI: improve extended config space verification
Content-Disposition: inline; filename=x86_64-fix-mcfg-check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the verification for PCI-X/PCI-Express extended config
space pointer. This patch checks whether the MCFG address range
is listed as a motherboard resource, per the PCI firmware spec.
The old check only looked in int 15 e820 memory map, causing
several systems to fail the verification and lose extended
config space.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 arch/x86_64/pci/mmconfig.c |  112 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 109 insertions(+), 3 deletions(-)

Index: linux-2.6.17-mm1/arch/x86_64/pci/mmconfig.c
===================================================================
--- linux-2.6.17-mm1.orig/arch/x86_64/pci/mmconfig.c
+++ linux-2.6.17-mm1/arch/x86_64/pci/mmconfig.c
@@ -164,6 +164,107 @@ static __init void unreachable_devices(v
 	}
 }
 
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
 void __init pci_mmcfg_init(void)
 {
 	int i;
@@ -180,10 +281,15 @@ void __init pci_mmcfg_init(void)
 	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
 			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+		if (!is_acpi_reserved(pci_mmcfg_config[0].base_address,
+				pci_mmcfg_config[0].base_address +
+				MMCONFIG_APER_MIN)) {
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
