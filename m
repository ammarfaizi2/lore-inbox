Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWJTOU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWJTOU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992618AbWJTOU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:20:29 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:14525 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751719AbWJTOUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:20:25 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002717U4538db22@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "Greg KH" <greg@kroah.com>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: "David Miller" <davem@davemloft.net>, <alan@redhat.com>,
       <jesse.barnes@intel.com>, <linux-kernel@vger.kernel.org>,
       <steven.c.cook@intel.com>, <bjorn.helgaas@hp.com>,
       <tony.luck@intel.com>
Date: Fri, 20 Oct 2006 23:20:21 +0900
References: <20061019092256.GC5980@devserv.devel.redhat.com> 
    <20061019.022541.85409562.davem@davemloft.net> 
    <XNM1$9$0$4$$3$3$7$A$9002707U4537582f@hitachi.com> 
    <20061019.153228.39159105.davem@davemloft.net> 
    <20061020024157.GA6722@kroah.com> 
    <XNM1$9$0$4$$3$3$7$A$9002710U453840ab@hitachi.com> 
    <20061020040324.GA8014@kroah.com>
Importance: normal
Subject: Re: pci_fixup_video change blows up on sparc64
X400-Content-Identifier: X4538DB2200000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml16061020232018MOH]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
>I can't apply a patch against an old kernel, especially when the problem
>is with the new release :)
>
>Please make it against Linus's latest tree, which is where the problem
>is.  Also, please address David's latest comments about the patch.
>
>thanks,
>
>greg k-h
>

>From comments provided by "David Miller" <davem@davemloft.net>:
>This "bridge control register" is only valid for "PCI to PCI" bridges.
>It is not valid for "host to PCI" bridges, yet the pci_fixup_video()
>code is testing the bridge control register, blindly, in every bus
>device it sees as it walks up the device tree to the root.
>The bridge control register is valid for PCI header type BRIDGE, or
>CARDBUS.  Host to PCI controllers use PCI header type NORMAL.
>
>There should be a PCI header type check here, or similar.  The PCI
>device probing layer correctly checks the PCI header type before trying
>to access the bridge control register of any PCI device.

I added this PCI header type check and David's comments.

>From comments provided by "David Miller" <davem@davemloft.net>:
>And also, it is also true that the ioremap() calls done by
>pci_map_rom() for the "0xc0000" case are totally invalid.  For several
>reasons:
>
>1) That is going to be RAM, not I/O memory space, therefore accessing
>   it with ioremap() and asm/io.h accessors such as readl() and
>   memcpy_fromio() will result in bus errors and other faults.
>
>2) It is illegal to pass raw physical addresses to ioremap() as the
>   first argument.  The first argument to ioremap() is an architecture
>   defined opaque "address cookie" which by definition must be setup
>   by platform specific code.

I'm sorry. I can't modify ioremap to portable ioremap.
I know that x86, x86_64, IA64 dig and IA64 hpzx1 are supporting legacy
memory map. But I don't know other machines. Therefore, I added machine
type check.

I attached an patch below.
I tested this patch on x86, x86_64 and our IA64 dig. I don't have
other type machines.
Could you test on other type machines?

Thank you for David's comments and bug report.
Thank you for Grep, Alan and Jesse.

From: David Miller <davem@davemloft.net>
Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
---

diff -dupNr linux-2.6.19-rc2-git3.orig/arch/i386/pci/fixup.c linux-2.6.19-rc2-git3/arch/i386/pci/fixup.c
--- linux-2.6.19-rc2-git3.orig/arch/i386/pci/fixup.c	2006-10-20 13:48:45.000000000 +0900
+++ linux-2.6.19-rc2-git3/arch/i386/pci/fixup.c	2006-10-20 15:46:06.000000000 +0900
@@ -343,6 +343,64 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
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
+	u8 config_header;
+
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	/* Is VGA routed to us? */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			/*
+			 * From information provided by 
+			 * "David Miller" <davem@davemloft.net>
+			 * The bridge control register is valid for PCI header
+			 * type BRIDGE, or CARDBUS. Host to PCI controllers use
+			 * PCI header type NORMAL.
+			 */
+			pci_read_config_byte(bridge, PCI_HEADER_TYPE,
+						&config_header);
+			if ((config_header == PCI_HEADER_TYPE_BRIDGE) 
+			    ||(config_header == PCI_HEADER_TYPE_CARDBUS)){
+				pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+							&config);
+				if (!(config & PCI_BRIDGE_CTL_VGA))
+					return;
+			}
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
@@ -0,0 +1,72 @@
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
+	u8 config_header;
+
+	if ((strcmp(platform_name, "dig") != 0)
+	    && (strcmp(platform_name, "hpzx1")  != 0))
+		return;
+	/* Maybe, this machine supports legacy memory map */
+
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	/* Is VGA routed to us? */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			/*
+			 * From information provided by 
+			 * "David Miller" <davem@davemloft.net>
+			 * The bridge control register is valid for PCI header
+			 * type BRIDGE, or CARDBUS. Host to PCI controllers use
+			 * PCI header type NORMAL.
+			 */
+			pci_read_config_byte(bridge, PCI_HEADER_TYPE,
+						&config_header);
+			if ((config_header == PCI_HEADER_TYPE_BRIDGE) 
+			    ||(config_header == PCI_HEADER_TYPE_CARDBUS)){
+				pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+							&config);
+				if (!(config & PCI_BRIDGE_CTL_VGA))
+					return;
+			}
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
