Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUHWTAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUHWTAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUHWS7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:59:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:12228 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267310AbUHWShE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:04 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860853794@kroah.com>
Date: Mon, 23 Aug 2004 11:34:45 -0700
Message-Id: <10932860853384@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.13, 2004/08/04 08:45:13-04:00, dwmw2@shinybook.infradead.org

PCI quirks -- other architectures

Mostly just removing empty pcibios_fixups[] arrays.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/alpha/kernel/pci.c                |   15 +++++----------
 arch/i386/pci/numa.c                   |    5 +----
 arch/ia64/pci/pci.c                    |    2 --
 arch/m68k/kernel/bios32.c              |    5 -----
 arch/m68knommu/kernel/comempci.c       |    2 --
 arch/sh/boards/mpc1211/pci.c           |    9 +--------
 arch/sh/boards/overdrive/galileo.c     |    8 +-------
 arch/sh/drivers/pci/fixups-dreamcast.c |    6 +-----
 arch/sh/drivers/pci/pci-sh7751.c       |    9 +--------
 arch/sh/drivers/pci/pci-st40.c         |    8 +-------
 arch/sh64/kernel/pci_sh5.c             |    7 +------
 arch/sparc/kernel/pcic.c               |    4 ----
 arch/sparc64/kernel/pci.c              |    4 ----
 arch/v850/kernel/rte_mb_a_pci.c        |    2 --
 14 files changed, 12 insertions(+), 74 deletions(-)


diff -Nru a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
--- a/arch/alpha/kernel/pci.c	2004-08-23 11:06:06 -07:00
+++ b/arch/alpha/kernel/pci.c	2004-08-23 11:06:06 -07:00
@@ -67,6 +67,7 @@
 {
 	dev->class = PCI_CLASS_BRIDGE_ISA << 8;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82378, quirk_isa_bridge);
 
 static void __init
 quirk_cypress(struct pci_dev *dev)
@@ -100,6 +101,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, quirk_cypress);
 
 /* Called for each device after PCI setup is done. */
 static void __init
@@ -112,17 +114,10 @@
 		isa_bridge = dev;
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_final);
 
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82378,
-	  quirk_isa_bridge },
-	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693,
-	  quirk_cypress },
-	{ PCI_FIXUP_FINAL,  PCI_ANY_ID,	PCI_ANY_ID,
-	  pcibios_fixup_final },
-	{ 0 }
-};
-
+/* Just declaring that the power-of-ten prefixes are actually the
+   power-of-two ones doesn't make it true :) */
 #define KB			1024
 #define MB			(1024*KB)
 #define GB			(1024*MB)
diff -Nru a/arch/i386/pci/numa.c b/arch/i386/pci/numa.c
--- a/arch/i386/pci/numa.c	2004-08-23 11:06:06 -07:00
+++ b/arch/i386/pci/numa.c	2004-08-23 11:06:06 -07:00
@@ -100,10 +100,7 @@
 	}
 	pcibios_last_bus = -1;
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82451NX, pci_fixup_i450nx);
 
 static int __init pci_numa_init(void)
 {
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	2004-08-23 11:06:06 -07:00
+++ b/arch/ia64/pci/pci.c	2004-08-23 11:06:06 -07:00
@@ -46,8 +46,6 @@
 #define DBG(x...)
 #endif
 
-struct pci_fixup pcibios_fixups[1];
-
 /*
  * Low-level SAL-based PCI configuration access functions. Note that SAL
  * calls are already serialized (via sal_lock), so we don't need another
diff -Nru a/arch/m68k/kernel/bios32.c b/arch/m68k/kernel/bios32.c
--- a/arch/m68k/kernel/bios32.c	2004-08-23 11:06:06 -07:00
+++ b/arch/m68k/kernel/bios32.c	2004-08-23 11:06:06 -07:00
@@ -77,11 +77,6 @@
 static unsigned int io_base;
 static unsigned int mem_base;
 
-struct pci_fixup pcibios_fixups[] =
-{
-	{ 0 }
-};
-
 /*
  * static void disable_dev(struct pci_dev *dev)
  *
diff -Nru a/arch/m68knommu/kernel/comempci.c b/arch/m68knommu/kernel/comempci.c
--- a/arch/m68knommu/kernel/comempci.c	2004-08-23 11:06:06 -07:00
+++ b/arch/m68knommu/kernel/comempci.c	2004-08-23 11:06:06 -07:00
@@ -351,8 +351,6 @@
 }
 /*****************************************************************************/
 
-struct pci_fixup pcibios_fixups[] = { { 0 } };
-
 void pcibios_fixup_bus(struct pci_bus *b)
 {
 }
diff -Nru a/arch/sh/boards/mpc1211/pci.c b/arch/sh/boards/mpc1211/pci.c
--- a/arch/sh/boards/mpc1211/pci.c	2004-08-23 11:06:06 -07:00
+++ b/arch/sh/boards/mpc1211/pci.c	2004-08-23 11:06:06 -07:00
@@ -176,14 +176,7 @@
 	dev->resource[4].end   = 0xf00f;
 	dev->resource[4].flags = IORESOURCE_IO;
 }
-
-
-/* Add future fixups here... */
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_AL,
-	  PCI_DEVICE_ID_AL_M5229, quirk_ali_ide_ports },
-	{ 0 }
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, quirk_ali_ide_ports);
 
 char * __devinit pcibios_setup(char *str)
 {
diff -Nru a/arch/sh/boards/overdrive/galileo.c b/arch/sh/boards/overdrive/galileo.c
--- a/arch/sh/boards/overdrive/galileo.c	2004-08-23 11:06:06 -07:00
+++ b/arch/sh/boards/overdrive/galileo.c	2004-08-23 11:06:06 -07:00
@@ -455,13 +455,7 @@
 		}
 	}
 }
-
-
-/* Add future fixups here... */
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,	PCI_ANY_ID,	pci_fixup_ide_bases },
-	{ 0 }
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 
 void __init pcibios_init(void)
 {
diff -Nru a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
--- a/arch/sh/drivers/pci/fixups-dreamcast.c	2004-08-23 11:06:06 -07:00
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c	2004-08-23 11:06:06 -07:00
@@ -47,11 +47,7 @@
 	}
 }
 
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER, PCI_ANY_ID,
-	  PCI_ANY_ID, gapspci_fixup_resources },
-	{ 0, }
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, gapspci_fixup_resources);
 
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
diff -Nru a/arch/sh/drivers/pci/pci-sh7751.c b/arch/sh/drivers/pci/pci-sh7751.c
--- a/arch/sh/drivers/pci/pci-sh7751.c	2004-08-23 11:06:06 -07:00
+++ b/arch/sh/drivers/pci/pci-sh7751.c	2004-08-23 11:06:06 -07:00
@@ -177,15 +177,8 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 #endif
-
-/* Add future fixups here... */
-struct pci_fixup pcibios_fixups[] = {
-#if !defined(CONFIG_SH_HS7751RVOIP) && !defined(CONFIG_SH_RTS7751R2D)
-	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,	PCI_ANY_ID,	pci_fixup_ide_bases },
-#endif
-	{ 0 }
-};
 
 /*
  *  Called after each bus is probed, but before its children
diff -Nru a/arch/sh/drivers/pci/pci-st40.c b/arch/sh/drivers/pci/pci-st40.c
--- a/arch/sh/drivers/pci/pci-st40.c	2004-08-23 11:06:06 -07:00
+++ b/arch/sh/drivers/pci/pci-st40.c	2004-08-23 11:06:06 -07:00
@@ -160,13 +160,7 @@
 		}
 	}
 }
-
-
-/* Add future fixups here... */
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,	PCI_ANY_ID,	pci_fixup_ide_bases },
-	{ 0 }
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 
 int __init st40pci_init(unsigned memStart, unsigned memSize)
 {
diff -Nru a/arch/sh64/kernel/pci_sh5.c b/arch/sh64/kernel/pci_sh5.c
--- a/arch/sh64/kernel/pci_sh5.c	2004-08-23 11:06:06 -07:00
+++ b/arch/sh64/kernel/pci_sh5.c	2004-08-23 11:06:06 -07:00
@@ -48,12 +48,7 @@
 		}
 	}
 }
-
-/* Add future fixups here... */
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,	PCI_ANY_ID,	pci_fixup_ide_bases },
-	{ 0 }
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 
 char * __init pcibios_setup(char *str)
 {
diff -Nru a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
--- a/arch/sparc/kernel/pcic.c	2004-08-23 11:06:06 -07:00
+++ b/arch/sparc/kernel/pcic.c	2004-08-23 11:06:06 -07:00
@@ -36,10 +36,6 @@
 #include <asm/uaccess.h>
 
 
-struct pci_fixup pcibios_fixups[] = {
-	{ 0 }
-};
-
 unsigned int pcic_pin_to_irq(unsigned int pin, char *name);
 
 /*
diff -Nru a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
--- a/arch/sparc64/kernel/pci.c	2004-08-23 11:06:06 -07:00
+++ b/arch/sparc64/kernel/pci.c	2004-08-23 11:06:06 -07:00
@@ -351,10 +351,6 @@
 
 subsys_initcall(pcibios_init);
 
-struct pci_fixup pcibios_fixups[] = {
-	{ 0 }
-};
-
 void pcibios_fixup_bus(struct pci_bus *pbus)
 {
 	struct pci_pbm_info *pbm = pbus->sysdata;
diff -Nru a/arch/v850/kernel/rte_mb_a_pci.c b/arch/v850/kernel/rte_mb_a_pci.c
--- a/arch/v850/kernel/rte_mb_a_pci.c	2004-08-23 11:06:06 -07:00
+++ b/arch/v850/kernel/rte_mb_a_pci.c	2004-08-23 11:06:06 -07:00
@@ -322,8 +322,6 @@
 
 /* Stubs for things we don't use.  */
 
-struct pci_fixup pcibios_fixups[] = { { 0 } };
-
 /* Called after each bus is probed, but before its children are examined. */
 void pcibios_fixup_bus(struct pci_bus *b)
 {

