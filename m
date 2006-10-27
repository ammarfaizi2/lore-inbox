Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWJ0SFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWJ0SFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWJ0SFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:05:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57245 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751311AbWJ0SFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:05:50 -0400
Subject: patch pci-fix-pci_fixup_video-as-it-blows-up-on-sparc64.patch added to gregkh-2.6 tree
To: davem@davemloft.net, alan@redhat.com, bjorn.helgaas@hp.com,
       eiichiro.oiwa.nm@hitachi.com, greg@kroah.com, gregkh@suse.de,
       jesse.barnes@intel.com, linux-kernel@vger.kernel.org,
       steven.c.cook@intel.com, tony.luck@intel.com
From: <gregkh@suse.de>
Date: Fri, 27 Oct 2006 11:05:14 -0700
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002718U453c5dab@hitachi.com>
Message-Id: <20061027180536.BAC75989E77@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: PCI: fix pci_fixup_video as it blows up on sparc64

to my gregkh-2.6 tree.  Its filename is

     pci-fix-pci_fixup_video-as-it-blows-up-on-sparc64.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From eiichiro.oiwa.nm@hitachi.com  Fri Oct 27 10:23:02 2006
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002718U453c5dab@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "David Miller" <davem@davemloft.net>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: <greg@kroah.com>, <alan@redhat.com>, <jesse.barnes@intel.com>,
	<linux-kernel@vger.kernel.org>, <steven.c.cook@intel.com>,
	<bjorn.helgaas@hp.com>, <tony.luck@intel.com>
Date: Mon, 23 Oct 2006 15:14:07 +0900
Subject: PCI: fix pci_fixup_video as it blows up on sparc64

From: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>

This reverts much of the original pci_fixup_video change and makes it
work for all arches that need it.

fixed, and tested on x86, x86_64 and IA64 dig.

Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
Acked-by: David Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/pci/fixup.c  |   55 +++++++++++++++++++++++++++++++++++++++
 arch/ia64/pci/Makefile |    2 -
 arch/ia64/pci/fixup.c  |   69 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c   |   46 --------------------------------
 drivers/pci/rom.c      |    5 ++-
 5 files changed, 128 insertions(+), 49 deletions(-)

--- gregkh-2.6.orig/arch/i386/pci/fixup.c
+++ gregkh-2.6/arch/i386/pci/fixup.c
@@ -297,6 +297,61 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
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
--- gregkh-2.6.orig/arch/ia64/pci/Makefile
+++ gregkh-2.6/arch/ia64/pci/Makefile
@@ -1,4 +1,4 @@
 #
 # Makefile for the ia64-specific parts of the pci bus
 #
-obj-y		:= pci.o
+obj-y		:= pci.o fixup.o
--- /dev/null
+++ gregkh-2.6/arch/ia64/pci/fixup.c
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
--- gregkh-2.6.orig/drivers/pci/quirks.c
+++ gregkh-2.6/drivers/pci/quirks.c
@@ -1566,52 +1566,6 @@ static void __devinit fixup_rev1_53c810(
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
--- gregkh-2.6.orig/drivers/pci/rom.c
+++ gregkh-2.6/drivers/pci/rom.c
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


Patches currently in gregkh-2.6 which might be from davem@davemloft.net are

pci/pci-fix-pci_fixup_video-as-it-blows-up-on-sparc64.patch
pci/pci-use-pci_generic_prep_mwi-on-sparc64.patch
