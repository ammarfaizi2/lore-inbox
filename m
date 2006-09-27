Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965571AbWI0LXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965571AbWI0LXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965573AbWI0LXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:23:45 -0400
Received: from mail7.hitachi.co.jp ([133.145.228.42]:11945 "EHLO
	mail7.hitachi.co.jp") by vger.kernel.org with ESMTP id S965571AbWI0LXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:23:44 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002684U451a5f21@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "Jesse Barnes" <jesse.barnes@intel.com>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: <akpm@osdl.org>, <tony.luck@intel.com>, <greg@kroah.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Wed, 27 Sep 2006 20:23:24 +0900
Importance: normal
Subject: Re: [PATCH 2.6.18] IA64: Add pci_fixup_video into IA64 kernel for
    embedded VGA
X400-Content-Identifier: X451A5F2100000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml160609272023131QD]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>On Tuesday, September 26, 2006 12:42 am, eiichiro.oiwa.nm@hitachi.com 
>>wrote:
>>> To be compatible with Xorg's handling of PCI, we need pci_fixup_video on
>>> IA64 platform like x86 platform. There are also machines, which have VGA
>>> embedded into main board, among IA64 platform. Embedded VGA generally
>>> don't have PCI ROM, and there are VGA ROM image in System BIOS.
>>> Therefore, these machines need pci_fixup_video for the sysfs rom.
>>> pci_fixup_video already exists in x86 Linux kernel. However since this
>>> function doesn't exist in IA64 kernel, we could not run X server on IA64
>>> box has embedded-VGA.
>>>
>>> I tested pci_fixup_video on IA64 box has embedded-VGA. I confirmed we
>>> can read VGA BIOS from the sysfs rom regardless of embedded-VGA.
>>
>>Looks good, Eiichiro, thanks for posting this.
>>
>>> +#include <linux/delay.h>
>>> +#include <linux/dmi.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/init.h>
>>
>>For this version, I don't think you need delay.h or dmi.h.  And like Bjorn 
>>mentioned, this could probably be turned into generic code in drivers/pci 
>>so we don't have too much duplication with x86 (and like I mentioned, 
>>x86_64 could probably use this too).
>>
>>Jesse
>>
>
>"PCI-to-PCI Bridge Architecture Specification" describes how to support VGA.
>And pci_fixup_video suits this specification because this function checks the
>Bridge Control register. I also think pci_fixup_video should be turned into
>generic quirks.c in drivers/pci.
>
>Ok, I will modify code and test.
>
>Thanks,
>Eiichiro

I moved pci_fixup_video to generic location (driver/pci/quirks.c).
I tested generic fixup_video on x86, x86_64 and IA64, and confirmed
we can read Video BIOS from the sysfs rom with embedded VGA.

Eiichiro

diff -dupNr linux-2.6.18.orig/arch/i386/pci/fixup.c linux-2.6.18/arch/i386/pci/fixup.c
--- linux-2.6.18.orig/arch/i386/pci/fixup.c	2006-09-20 12:42:06.000000000 +0900
+++ linux-2.6.18/arch/i386/pci/fixup.c	2006-09-27 14:18:55.000000000 +0900
@@ -343,51 +343,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk );
 
 /*
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
-static void __devinit pci_fixup_video(struct pci_dev *pdev)
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
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
-
-/*
  * Some Toshiba laptops need extra code to enable their TI TSB43AB22/A.
  *
  * We pretend to bring them out of full D3 state, and restore the proper
diff -dupNr linux-2.6.18.orig/drivers/pci/quirks.c linux-2.6.18/drivers/pci/quirks.c
--- linux-2.6.18.orig/drivers/pci/quirks.c	2006-09-20 12:42:06.000000000 +0900
+++ linux-2.6.18/drivers/pci/quirks.c	2006-09-27 14:46:40.000000000 +0900
@@ -1590,6 +1590,51 @@ static void __devinit fixup_rev1_53c810(
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, fixup_rev1_53c810);
 
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
+static void __devinit fixup_video(struct pci_dev *pdev)
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
+		if (bridge) {
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
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, fixup_video);
+
 
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
