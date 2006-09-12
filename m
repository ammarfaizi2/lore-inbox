Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWILIXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWILIXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWILIXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:23:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54182 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964999AbWILIXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:23:18 -0400
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: x86 mac testers needed
Date: Tue, 12 Sep 2006 08:58:14 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GqlBF1wACQJPwv9"
Message-Id: <200609120858.14414.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GqlBF1wACQJPwv9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello,

We need someone with a x86 Mac that didn't boot with 2.6.18rc2 or earlier
without applying patches.  We got one report of this, but the original
reporter isn't answering anymore.

Can you please add the attached patches to 2.6.18rc6 and report
if your system boots now? 

Patch order is 

pci-probe-type1-first
i386-acpi-mcfg-check
acpi-mcfg-check
remove-mcfg-dmi

Thank you,

-Andi

--Boundary-00=_GqlBF1wACQJPwv9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="acpi-mcfg-check"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi-mcfg-check"

improve extended config space verification

From: rajesh.shah@intel.com

Extend the verification for PCI-X/PCI-Express extended config
space pointer. This patch checks whether the MCFG address range
is listed as a motherboard resource, per the PCI firmware spec.
The old check only looked in int 15 e820 memory map, causing
several systems to fail the verification and lose extended
config space. x86_64 picks up the verification code from the i386
directory.

[AK: Also changed by me to use new type1 heuristic and some cleanups]

Cc: gregkh@suse.de

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 arch/x86_64/pci/mmconfig.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6.18rc6-update/arch/x86_64/pci/mmconfig.c
===================================================================
--- linux-2.6.18rc6-update.orig/arch/x86_64/pci/mmconfig.c
+++ linux-2.6.18rc6-update/arch/x86_64/pci/mmconfig.c
@@ -185,6 +185,17 @@ void __init pci_mmcfg_init(int type)
 	    (pci_mmcfg_config[0].base_address == 0))
 		return;
 
+	/* When Type1 access is not available don't check because
+	   we really need MCFG then and it's hopefully ok*/
+	if (type == 1 && !is_acpi_reserved(pci_mmcfg_config[0].base_address,
+					   pci_mmcfg_config[0].base_address +
+					   MMCONFIG_APER_MIN)) {
+		printk(KERN_ERR
+		       "PCI: BIOS Bug: MCFG area at %x not reserved in ACPI\n",
+		       pci_mmcfg_config[0].base_address);
+		return;
+	}
+
 	/* RED-PEN i386 doesn't do _nocache right now */
 	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
 	if (pci_mmcfg_virt == NULL) {

--Boundary-00=_GqlBF1wACQJPwv9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="i386-acpi-mcfg-check"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="i386-acpi-mcfg-check"

i386: PCI improve extended config space verification

From: rajesh.shah@intel.com

Extend the verification for PCI-X/PCI-Express extended config
space pointer. This patch checks whether the MCFG address range
is listed as a motherboard resource, per the PCI firmware spec.
The old check only looked in int 15 e820 memory map, causing
several systems to fail the verification and lose extended
config space.

[AK: Originally from Rajesh but somewhat hacked up by me. 
It now has a new heuristic to not do this check if Type1 
access doesn't work. This will hopefully fix the x86 iMacs.
Also assorted cleanups.]

Cc: gregkh@suse.d

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 arch/i386/pci/acpi.c       |  101 +++++++++++++++++++++++++++++++++++++++++++++
 arch/i386/pci/mmconfig.c   |   11 +++-
 drivers/acpi/motherboard.c |    3 -
 include/acpi/aclocal.h     |    4 +
 4 files changed, 113 insertions(+), 6 deletions(-)

Index: linux/arch/i386/pci/acpi.c
===================================================================
--- linux.orig/arch/i386/pci/acpi.c
+++ linux/arch/i386/pci/acpi.c
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
Index: linux/arch/i386/pci/mmconfig.c
===================================================================
--- linux.orig/arch/i386/pci/mmconfig.c
+++ linux/arch/i386/pci/mmconfig.c
@@ -221,6 +221,17 @@ void __init pci_mmcfg_init(int type)
 	    (pci_mmcfg_config[0].base_address == 0))
 		return;
 
+	/* When Type1 access is not available don't check because
+	   we really need MCFG then and it's hopefully ok*/
+	if (type == 1 && !is_acpi_reserved(pci_mmcfg_config[0].base_address,
+					   pci_mmcfg_config[0].base_address +
+					   MMCONFIG_APER_MIN)) {
+		printk(KERN_ERR
+		       "PCI: BIOS Bug: MCFG area at %x not reserved in ACPI\n",
+		       pci_mmcfg_config[0].base_address);
+		return;
+	}
+
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
Index: linux/drivers/acpi/motherboard.c
===================================================================
--- linux.orig/drivers/acpi/motherboard.c
+++ linux/drivers/acpi/motherboard.c
@@ -32,9 +32,6 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("acpi_motherboard")
 
-/* Dell use PNP0C01 instead of PNP0C02 */
-#define ACPI_MB_HID1			"PNP0C01"
-#define ACPI_MB_HID2			"PNP0C02"
 /**
  * Doesn't care about legacy IO ports, only IO ports beyond 0x1000 are reserved
  * Doesn't care about the failure of 'request_region', since other may reserve
Index: linux/include/acpi/aclocal.h
===================================================================
--- linux.orig/include/acpi/aclocal.h
+++ linux/include/acpi/aclocal.h
@@ -696,6 +696,10 @@ struct acpi_parse_state {
 
 #define PCI_ROOT_HID_STRING             "PNP0A03"
 #define PCI_EXPRESS_ROOT_HID_STRING     "PNP0A08"
+/* Dell use PNP0C01 instead of PNP0C02 */
+#define ACPI_MB_HID1			"PNP0C01"
+#define ACPI_MB_HID2			"PNP0C02"
+
 
 struct acpi_bit_register_info {
 	u8 parent_register;
Index: linux/arch/i386/pci/pci.h
===================================================================
--- linux.orig/arch/i386/pci/pci.h
+++ linux/arch/i386/pci/pci.h
@@ -88,5 +88,5 @@ extern void pci_pcbios_init(void);
 extern void pci_mmcfg_init(int type);
 extern void pcibios_sort(void);
 
-extern int is_acpi_reserved(unsigned long start, unsigned long end)
+extern int is_acpi_reserved(unsigned long start, unsigned long end);
 

--Boundary-00=_GqlBF1wACQJPwv9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pci-probe-type1-first"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pci-probe-type1-first"

i386/x86-64: PCI: split probing and initialization of type 1 config space access

First probe if type1/2 accesses work, but then only initialize them at the end.

This is useful for a later patch that needs this information inbetween.

Index: linux/arch/i386/pci/direct.c
===================================================================
--- linux.orig/arch/i386/pci/direct.c
+++ linux/arch/i386/pci/direct.c
@@ -254,7 +254,16 @@ static int __init pci_check_type2(void)
 	return works;
 }
 
-void __init pci_direct_init(void)
+void __init pci_direct_init(int type)
+{
+	printk(KERN_INFO "PCI: Using configuration type %d\n", type);
+	if (type == 1)
+		raw_pci_ops = &pci_direct_conf1;
+	else
+		raw_pci_ops = &pci_direct_conf2;
+}
+
+int __init pci_direct_probe(void)
 {
 	struct resource *region, *region2;
 
@@ -264,19 +273,16 @@ void __init pci_direct_init(void)
 	if (!region)
 		goto type2;
 
-	if (pci_check_type1()) {
-		printk(KERN_INFO "PCI: Using configuration type 1\n");
-		raw_pci_ops = &pci_direct_conf1;
-		return;
-	}
+	if (pci_check_type1())
+		return 1;
 	release_resource(region);
 
  type2:
 	if ((pci_probe & PCI_PROBE_CONF2) == 0)
-		return;
+		return 0;
 	region = request_region(0xCF8, 4, "PCI conf2");
 	if (!region)
-		return;
+		return 0;
 	region2 = request_region(0xC000, 0x1000, "PCI conf2");
 	if (!region2)
 		goto fail2;
@@ -284,10 +290,11 @@ void __init pci_direct_init(void)
 	if (pci_check_type2()) {
 		printk(KERN_INFO "PCI: Using configuration type 2\n");
 		raw_pci_ops = &pci_direct_conf2;
-		return;
+		return 2;
 	}
 
 	release_resource(region2);
  fail2:
 	release_resource(region);
+	return 0;
 }
Index: linux/arch/i386/pci/init.c
===================================================================
--- linux.orig/arch/i386/pci/init.c
+++ linux/arch/i386/pci/init.c
@@ -6,8 +6,12 @@
    in the right sequence from here. */
 static __init int pci_access_init(void)
 {
+#ifdef CONFIG_PCI_DIRECT
+	int type = pci_direct_probe();
+#endif	
+
 #ifdef CONFIG_PCI_MMCONFIG
-	pci_mmcfg_init();
+	pci_mmcfg_init(type);
 #endif
 	if (raw_pci_ops)
 		return 0;
@@ -21,7 +25,7 @@ static __init int pci_access_init(void)
 	 * fails.
 	 */
 #ifdef CONFIG_PCI_DIRECT
-	pci_direct_init();
+	pci_direct_init(type);
 #endif
 	return 0;
 }
Index: linux/arch/i386/pci/mmconfig.c
===================================================================
--- linux.orig/arch/i386/pci/mmconfig.c
+++ linux/arch/i386/pci/mmconfig.c
@@ -208,7 +208,7 @@ static struct dmi_system_id __initdata d
          {}
 };
 
-void __init pci_mmcfg_init(void)
+void __init pci_mmcfg_init(int type)
 {
 	dmi_check_system(dmi_bad_mcfg);
 
Index: linux/arch/i386/pci/pci.h
===================================================================
--- linux.orig/arch/i386/pci/pci.h
+++ linux/arch/i386/pci/pci.h
@@ -82,7 +82,11 @@ extern int pci_conf1_write(unsigned int 
 extern int pci_conf1_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value);
 
-extern void pci_direct_init(void);
+extern int pci_direct_probe(void);
+extern void pci_direct_init(int type);
 extern void pci_pcbios_init(void);
-extern void pci_mmcfg_init(void);
+extern void pci_mmcfg_init(int type);
 extern void pcibios_sort(void);
+
+extern int is_acpi_reserved(unsigned long start, unsigned long end)
+
Index: linux/arch/x86_64/pci/mmconfig.c
===================================================================
--- linux.orig/arch/x86_64/pci/mmconfig.c
+++ linux/arch/x86_64/pci/mmconfig.c
@@ -184,7 +184,7 @@ static struct dmi_system_id __initdata d
          {}
 };
 
-void __init pci_mmcfg_init(void)
+void __init pci_mmcfg_init(int type)
 {
 	int i;
 

--Boundary-00=_GqlBF1wACQJPwv9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="remove-mcfg-dmi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remove-mcfg-dmi"

Remove DMI entry to disable MCFG

We got a different heuristic now that should hopefully work it even
without blacklisting systems. So remove the entry for now.

Index: linux-2.6.18rc6-update/arch/i386/pci/mmconfig.c
===================================================================
--- linux-2.6.18rc6-update.orig/arch/i386/pci/mmconfig.c
+++ linux-2.6.18rc6-update/arch/i386/pci/mmconfig.c
@@ -188,23 +188,16 @@ static __init void unreachable_devices(v
 	}
 }
 
+#if 0
 static int disable_mcfg(struct dmi_system_id *d)
 {
 	printk("PCI: %s detected. Disabling MCFG.\n", d->ident);
 	pci_probe &= ~PCI_PROBE_MMCONF;
 	return 0;
 }
+#endif
 
 static struct dmi_system_id __initdata dmi_bad_mcfg[] = {
-	/* Has broken MCFG table that makes the system hang when used */
-        {
-         .callback = disable_mcfg,
-         .ident = "Intel D3C5105 SDV",
-         .matches = {
-                     DMI_MATCH(DMI_BIOS_VENDOR, "Intel"),
-                     DMI_MATCH(DMI_BOARD_NAME, "D26928"),
-                     },
-         },
          {}
 };
 
Index: linux-2.6.18rc6-update/arch/x86_64/pci/mmconfig.c
===================================================================
--- linux-2.6.18rc6-update.orig/arch/x86_64/pci/mmconfig.c
+++ linux-2.6.18rc6-update/arch/x86_64/pci/mmconfig.c
@@ -165,23 +165,16 @@ static __init void unreachable_devices(v
 	}
 }
 
+#if 0
 static int disable_mcfg(struct dmi_system_id *d)
 {
 	printk("PCI: %s detected. Disabling MCFG.\n", d->ident);
 	pci_probe &= ~PCI_PROBE_MMCONF;
 	return 0;
 }
+#endif
 
 static struct dmi_system_id __initdata dmi_bad_mcfg[] = {
-	/* Has broken MCFG table that makes the system hang when used */
-        {
-         .callback = disable_mcfg,
-         .ident = "Intel D3C5105 SDV",
-         .matches = {
-                     DMI_MATCH(DMI_BIOS_VENDOR, "Intel"),
-                     DMI_MATCH(DMI_BOARD_NAME, "D26928"),
-                     },
-         },
          {}
 };
 

--Boundary-00=_GqlBF1wACQJPwv9--
