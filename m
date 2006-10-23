Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWJWGOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWJWGOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWJWGOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:14:30 -0400
Received: from mail9.hitachi.co.jp ([133.145.228.44]:19088 "EHLO
	mail9.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751579AbWJWGO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:14:29 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002718U453c5dab@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "David Miller" <davem@davemloft.net>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: <greg@kroah.com>, <alan@redhat.com>, <jesse.barnes@intel.com>,
       <linux-kernel@vger.kernel.org>, <steven.c.cook@intel.com>,
       <bjorn.helgaas@hp.com>, <tony.luck@intel.com>
Date: Mon, 23 Oct 2006 15:14:07 +0900
References: <XNM1$9$0$4$$3$3$7$A$9002710U453840ab@hitachi.com> 
    <20061020040324.GA8014@kroah.com> 
    <XNM1$9$0$4$$3$3$7$A$9002717U4538db22@hitachi.com> 
    <20061020.123140.48805752.davem@davemloft.net>
Importance: normal
Subject: Re: pci_fixup_video change blows up on sparc64
X400-Content-Identifier: X453C5DAB00000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml16061023151403GAB]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
>From: <eiichiro.oiwa.nm@hitachi.com>
>Date: Fri, 20 Oct 2006 23:20:21 +0900
>
>> +			/*
>> +			 * From information provided by 
>> +			 * "David Miller" <davem@davemloft.net>
>> +			 * The bridge control register is valid for PCI header
>> +			 * type BRIDGE, or CARDBUS. Host to PCI controllers use
>> +			 * PCI header type NORMAL.
>> +			 */
>> +			pci_read_config_byte(bridge, PCI_HEADER_TYPE,
>> +						&config_header);
>
>Use the software copy in "bridge->hdr_type", it's already been read
>for you by the PCI device probing layer.

Ok, I fixed, and tested on x86, x86_64 and IA64 dig.
Thank you.

From: David Miller <davem@davemloft.net>
Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
---

diff -dupNr linux-2.6.19-rc2-git3.orig/arch/i386/pci/fixup.c linux-2.6.19-rc2-git3/arch/i386/pci/fixup.c
--- linux-2.6.19-rc2-git3.orig/arch/i386/pci/fixup.c	2006-10-20 13:48:45.000000000 +0900
+++ linux-2.6.19-rc2-git3/arch/i386/pci/fixup.c	2006-10-20 15:46:06.000000000 +0900
@@ -343,6 +343,61 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk );
 
 /*
+ * Fixup to mark boot BIOS video selected by BIOS before it changes
+ *
+ * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
+ *
+ * The standard boot ROM sequence for an x86 machine uses the BIOS
+ * to select an initial video card for boot display. This boot video
+ * card will have it's BIOS copied to C0000 in system RAM.
+ * IORESOURCE_ROM_SHADOW is used to associate the boot video
+ * card with this copy. On laptops this copy has to be used since
+ * the main ROM may be compressed or combined with another image.
+ * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
+ * is marked here since the boot video device will be the only enabled
+ * video device at this point.
+ */
+
+static void __devinit pci_fixup_video(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	u16 config;
+
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	/* Is VGA routed to us? */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+
+		/*
+		 * From information provided by
+		 * "David Miller" <davem@davemloft.net>
+		 * The bridge control register is valid for PCI header
+		 * type BRIDGE, or CARDBUS. Host to PCI controllers use
+		 * PCI header type NORMAL.
+		 */
+		if (bridge
+		    &&((bridge->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		       ||(bridge->hdr_type == PCI_HEADER_TYPE_CARDBUS))) {
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+						&config);
+			if (!(config & PCI_BRIDGE_CTL_VGA))
+				return;
+		}
+		bus = bus->parent;
+	}
+	pci_read_config_word(pdev, PCI_COMMAND, &config);
+	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+		printk(KERN_DEBUG "Boot video device is %s\n", pci_name(pdev));
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
+
+/*
  * Some Toshiba laptops need extra code to enable their TI TSB43AB22/A.
  *
  * We pretend to bring them out of full D3 state, and restore the proper
diff -dupNr linux-2.6.19-rc2-git3.orig/arch/ia64/pci/fixup.c linux-2.6.19-rc2-git3/arch/ia64/pci/fixup.c
--- linux-2.6.19-rc2-git3.orig/arch/ia64/pci/fixup.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.19-rc2-git3/arch/ia64/pci/fixup.c	2006-10-20 15:46:35.000000000 +0900
@@ -0,0 +1,69 @@
+/*
+ * Exceptions for specific devices. Usually work-arounds for fatal design flaws.
+ * Derived from fixup.c of i386 tree.
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <asm/machvec.h>
+
+/*
+ * Fixup to mark boot BIOS video selected by BIOS before it changes
+ *
+ * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
+ *
+ * The standard boot ROM sequence for an x86 machine uses the BIOS
+ * to select an initial video card for boot display. This boot video
+ * card will have it's BIOS copied to C0000 in system RAM.
+ * IORESOURCE_ROM_SHADOW is used to associate the boot video
+ * card with this copy. On laptops this copy has to be used since
+ * the main ROM may be compressed or combined with another image.
+ * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
+ * is marked here since the boot video device will be the only enabled
+ * video device at this point.
+ */
+
+static void __devinit pci_fixup_video(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	u16 config;
+
+	if ((strcmp(platform_name, "dig") != 0)
+	    && (strcmp(platform_name, "hpzx1")  != 0))
+		return;
+	/* Maybe, this machine supports legacy memory map. */
+
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	/* Is VGA routed to us? */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+
+		/*
+		 * From information provided by
+		 * "David Miller" <davem@davemloft.net>
+		 * The bridge control register is valid for PCI header
+		 * type BRIDGE, or CARDBUS. Host to PCI controllers use
+		 * PCI header type NORMAL.
+		 */
+		if (bridge
+		    &&((bridge->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		       ||(bridge->hdr_type == PCI_HEADER_TYPE_CARDBUS))) {
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+						&config);
+			if (!(config & PCI_BRIDGE_CTL_VGA))
+				return;
+		}
+		bus = bus->parent;
+	}
+	pci_read_config_word(pdev, PCI_COMMAND, &config);
+	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+		printk(KERN_DEBUG "Boot video device is %s\n", pci_name(pdev));
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
diff -dupNr linux-2.6.19-rc2-git3.orig/arch/ia64/pci/Makefile linux-2.6.19-rc2-git3/arch/ia64/pci/Makefile
--- linux-2.6.19-rc2-git3.orig/arch/ia64/pci/Makefile	2006-10-14 01:25:04.000000000 +0900
+++ linux-2.6.19-rc2-git3/arch/ia64/pci/Makefile	2006-10-20 14:47:13.000000000 +0900
@@ -1,4 +1,4 @@
 #
 # Makefile for the ia64-specific parts of the pci bus
 #
-obj-y		:= pci.o
+obj-y		:= pci.o fixup.o
diff -dupNr linux-2.6.19-rc2-git3.orig/drivers/pci/quirks.c linux-2.6.19-rc2-git3/drivers/pci/quirks.c
--- linux-2.6.19-rc2-git3.orig/drivers/pci/quirks.c	2006-10-20 13:48:46.000000000 +0900
+++ linux-2.6.19-rc2-git3/drivers/pci/quirks.c	2006-10-20 14:42:57.000000000 +0900
@@ -1619,52 +1619,6 @@ static void __devinit fixup_rev1_53c810(
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, fixup_rev1_53c810);
 
-/*
- * Fixup to mark boot BIOS video selected by BIOS before it changes
- *
- * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
- *
- * The standard boot ROM sequence for an x86 machine uses the BIOS
- * to select an initial video card for boot display. This boot video
- * card will have it's BIOS copied to C0000 in system RAM.
- * IORESOURCE_ROM_SHADOW is used to associate the boot video
- * card with this copy. On laptops this copy has to be used since
- * the main ROM may be compressed or combined with another image.
- * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
- * is marked here since the boot video device will be the only enabled
- * video device at this point.
- */
-
-static void __devinit fixup_video(struct pci_dev *pdev)
-{
-	struct pci_dev *bridge;
-	struct pci_bus *bus;
-	u16 config;
-
-	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
-		return;
-
-	/* Is VGA routed to us? */
-	bus = pdev->bus;
-	while (bus) {
-		bridge = bus->self;
-		if (bridge) {
-			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
-						&config);
-			if (!(config & PCI_BRIDGE_CTL_VGA))
-				return;
-		}
-		bus = bus->parent;
-	}
-	pci_read_config_word(pdev, PCI_COMMAND, &config);
-	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
-		printk(KERN_DEBUG "Boot video device is %s\n", pci_name(pdev));
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, fixup_video);
-
-
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
 	while (f < end) {
diff -dupNr linux-2.6.19-rc2-git3.orig/drivers/pci/rom.c linux-2.6.19-rc2-git3/drivers/pci/rom.c
--- linux-2.6.19-rc2-git3.orig/drivers/pci/rom.c	2006-10-20 13:48:46.000000000 +0900
+++ linux-2.6.19-rc2-git3/drivers/pci/rom.c	2006-10-20 15:45:12.000000000 +0900
@@ -72,8 +72,9 @@ void __iomem *pci_map_rom(struct pci_dev
 	int last_image;
 
 	/*
-	 * IORESOURCE_ROM_SHADOW set if the VGA enable bit of the Bridge Control
-	 * register is set for embedded VGA.
+	 * IORESOURCE_ROM_SHADOW set on x86, x86_64 and IA64 supports legacy
+	 * memory map if the VGA enable bit of the Bridge Control register is
+	 * set for embedded VGA.
 	 */
 	if (res->flags & IORESOURCE_ROM_SHADOW) {
 		/* primary video rom always starts here */

