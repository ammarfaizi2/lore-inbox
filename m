Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992433AbWJTC5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992433AbWJTC5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992440AbWJTC5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:57:19 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:61875 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S2992433AbWJTC5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:57:18 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002709U45383afc@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "David Miller" <davem@davemloft.net>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: <jesse.barnes@intel.com>, <alan@redhat.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Date: Fri, 20 Oct 2006 11:57:06 +0900
References: <20061019.013732.30184567.davem@davemloft.net> 
    <XNM1$9$0$4$$3$3$7$A$9002706U45374cd7@hitachi.com> 
    <200610191103.16689.jesse.barnes@intel.com> 
    <20061019.155844.18310932.davem@davemloft.net>
Importance: normal
Subject: Re: pci_fixup_video change blows up on sparc64
X400-Content-Identifier: X45383AFC00000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml160610201157007OO]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
>> One check that might make this feature a bit more robust is to look
>> for a real PCI ROM on the device.  If present, we probably don't
>> need to bother with the system copy (which probably won't be there
>> anyway).
>>
>> We should probably also check whether the parent bridge of the device to 
>> be fixed up is a real pci->pci bridge (if possible).  That would remove 
>> some ambiguity that's likely to cause problems with other platforms 
>> too.
>
>At the core of this is the "definition" that 0xc0000 is a location in
>physical RAM that the video ROM might be stored.  While this might
>be a %100 valid definition on IA64, x86 and x86_64, it simply is not
>on other platforms such as sparc64.
>
>In fact even the existence of any RAM at all at that address is
>not guarenteed.  I have a few systems where physical RAM starts
>at some high physical address, such as 0x80000000.
>
>Even if presence were guarenteed, you can't access this memory using
>ioremap() and things like readl() and friends, which is exactly what
>callers of pci_map_rom() are doing.  Accesses using readl() use
>non-cacheable transactions which result in bus errors, and furthermore
>the first argument to ioremap() is not a physical address, it's an
>architecture-defined "address cookie" that must be setup by platforms
>specific code.

Ok, I checked OF specification (PCI Bus IEEE Std 1275-1994 Standard for Boot
Firmware Revision 2.1 p17)
This specification describes the following:
For VGA devices (class-code = 0x000100 or 0x030000), the address ranges are:
0x3B0-0x3BB (I/O, aliased; t=1)
0x3C0-0x3DF (I/O, aliased; t=1)
0xA0000-0xBFFFF (Memory, below 1MB, t=1)

But this specification doesn't define expansion ROM (FCode) address at 0xc0000.
I am sorry. I assumed ROM base address will be 0xc0000 if VGA Enable bit in
Bridge Control Register set. This assuming is incorrect.

IORESOURCE_ROM_SHADOW won't set and pci_map_rom will return PCI ROM base
address if sparc64's VGA Enable bit doesn't set.

David reported pci_map_rom returns 0xc0000. This mean sparc64's VGA Enable bit
set and sparc64 use legacy VGA map. 

As a result, it is possible that expansion ROM address won't point at 0xc0000
if VGA Enable bit set.

Ok, I understood that pci_fixup_video should use on x86, x86_64 and IA64 support
legacy VGA map.

We should have used the following patch:
Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
---

diff -dupNr linux-2.6.18.orig/arch/ia64/pci/Makefile linux-2.6.18/arch/ia64/pci/Makefile
--- linux-2.6.18.orig/arch/ia64/pci/Makefile	2006-09-20 12:42:06.000000000 +0900
+++ linux-2.6.18/arch/ia64/pci/Makefile	2006-09-25 18:36:50.000000000 +0900
@@ -1,4 +1,4 @@
 #
 # Makefile for the ia64-specific parts of the pci bus
 #
-obj-y		:= pci.o
+obj-y		:= pci.o fixup.o
diff -dupNr linux-2.6.18.orig/arch/ia64/pci/fixup.c linux-2.6.18/arch/ia64/pci/fixup.c
--- linux-2.6.18.orig/arch/ia64/pci/fixup.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.18/arch/ia64/pci/fixup.c	2006-09-25 18:35:12.000000000 +0900
@@ -0,0 +1,56 @@
+/*
+ * Exceptions for specific devices. Usually work-arounds for fatal design flaws.
+ *
+ * Derived from fixup.c of i386 tree.
+ */
+
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
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
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);

