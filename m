Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVIWIqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVIWIqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVIWIqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:46:35 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:4260 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750816AbVIWIqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:46:34 -0400
Date: Fri, 23 Sep 2005 04:44:29 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.14-rc2] x86_64: Detect ATI timer quirk
  automatically
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509230446_MC3-1-AAFC-CB7B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is only lightly tested so far.  It boots and works on IOAPIC + ACPI.
I tested with and without kernel option "enable_timer_pin_1" and it works as
expected on the affected ATI chipsets.

It's unknown whether disabling the ACPI timer override is a good idea in all cases.
Should I add a command-line override for it?

Since I had to rearrange the code, I cleaned it up a bit as well.  I couldn't
test whether I broke the existing quirk code, though.

Patch: Automatically detect and enable timer quirk for ATI chipsets
Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/x86_64/kernel/io_apic.c |  105 +++++++++++++++++++++++++++++++------------
 1 files changed, 77 insertions(+), 28 deletions(-)

--- 2.6.14-rc2-64.orig/arch/x86_64/kernel/io_apic.c
+++ 2.6.14-rc2-64/arch/x86_64/kernel/io_apic.c
@@ -252,7 +252,66 @@ __setup("apic", enable_ioapic_setup);
 
    And another hack to disable the IOMMU on VIA chipsets.
 
+   Yet another to fix double speed clock on ATI RS480.
+
    Kludge-O-Rama. */
+
+static int __init host_bridge_quirk(int vendor, int device)
+{
+	switch (vendor) {
+
+	case PCI_VENDOR_ID_ATI:
+		/* Some ATI chipsets have doubly-connected timers.  Disable
+		   IOAPIC timer pin.  Also, ignore ACPI timer override. */
+		if (device == PCI_DEVICE_ID_ATI_RS480 ||
+		    device == 0x5951 /* RED-PEN: what is this? */ ) {
+#ifdef CONFIG_ACPI
+			printk(KERN_INFO "Ignoring ACPI timer override.\n");
+			acpi_skip_timer_override = 1;
+#endif
+			if (++disable_timer_pin_1 <= 0)
+				return 1;
+			printk(KERN_INFO "ATI host bridge timer quirk detected."
+					 " Disabling IOAPIC timer pin.\n");
+			return 1;
+		}
+		break;
+
+	}
+	return 0;
+}
+
+static int __init pci_bridge_quirk(int vendor, int device)
+{
+	switch (vendor) {
+
+	case PCI_VENDOR_ID_VIA:
+#ifdef CONFIG_GART_IOMMU
+		if ((end_pfn >= (0xffffffff>>PAGE_SHIFT) || force_iommu) &&
+		    !iommu_aperture_allowed) {
+			printk(KERN_INFO "Looks like a VIA chipset."
+					 " Disabling IOMMU."
+					 " Overwrite with \"iommu=allowed\"\n");
+			iommu_aperture_disabled = 1;
+		}
+#endif
+		return 1;
+
+	case PCI_VENDOR_ID_NVIDIA:
+#ifdef CONFIG_ACPI
+		/* All timer overrides on Nvidia
+	           seem to be wrong. Skip them. */
+		/* RED-PEN skip them on mptables too? */
+		printk(KERN_INFO "Nvidia board detected."
+				 " Ignoring ACPI timer override.\n");
+		acpi_skip_timer_override = 1;
+#endif
+		return 1;
+
+	}
+	return 0;
+}
+
 void __init check_ioapic(void) 
 { 
 	int num,slot,func; 
@@ -264,42 +323,32 @@ void __init check_ioapic(void) 
 		for (slot = 0; slot < 32; slot++) { 
 			for (func = 0; func < 8; func++) { 
 				u32 class;
-				u32 vendor;
+				u32 vend_dev;
+				u16 vendor, device;
 				u8 type;
+
 				class = read_pci_config(num,slot,func,
 							PCI_CLASS_REVISION);
 				if (class == 0xffffffff)
 					break; 
+				class >>= 16;
 
-		       		if ((class >> 16) != PCI_CLASS_BRIDGE_PCI)
+		       		if (class != PCI_CLASS_BRIDGE_PCI &&
+		       		    class != PCI_CLASS_BRIDGE_HOST)
 					continue; 
 
-				vendor = read_pci_config(num, slot, func, 
-							 PCI_VENDOR_ID);
-				vendor &= 0xffff;
-				switch (vendor) { 
-				case PCI_VENDOR_ID_VIA:
-#ifdef CONFIG_GART_IOMMU
-					if ((end_pfn >= (0xffffffff>>PAGE_SHIFT) ||
-					     force_iommu) &&
-					    !iommu_aperture_allowed) {
-						printk(KERN_INFO
-    "Looks like a VIA chipset. Disabling IOMMU. Overwrite with \"iommu=allowed\"\n");
-						iommu_aperture_disabled = 1;
-					}
-#endif
-					return;
-				case PCI_VENDOR_ID_NVIDIA:
-#ifdef CONFIG_ACPI
-					/* All timer overrides on Nvidia
-				           seem to be wrong. Skip them. */
-					acpi_skip_timer_override = 1;
-					printk(KERN_INFO 
-	     "Nvidia board detected. Ignoring ACPI timer override.\n");
-#endif
-					/* RED-PEN skip them on mptables too? */
-					return;
-				} 
+				vend_dev = read_pci_config(num, slot, func,
+							   PCI_VENDOR_ID);
+				vendor = vend_dev & 0xffff;
+				device = vend_dev >> 16;
+
+		       		if (class == PCI_CLASS_BRIDGE_HOST)
+					if (host_bridge_quirk(vendor, device))
+						return;
+
+		       		if (class == PCI_CLASS_BRIDGE_PCI)
+					if (pci_bridge_quirk(vendor, device))
+						return;
 
 				/* No multi-function device? */
 				type = read_pci_config_byte(num,slot,func,
__
Chuck
