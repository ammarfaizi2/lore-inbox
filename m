Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbWJKQWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWJKQWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWJKQWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:22:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45244 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161099AbWJKQWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:22:36 -0400
To: torvalds@osdl.org
Subject: [PATCH] arm-versatile iomem annotations
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Message-Id: <E1GXgqo-0005Tf-FW@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:22:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/mach-versatile/core.c            |    4 ++--
 arch/arm/mach-versatile/pci.c             |   32 +++++++++++++++--------------
 include/asm-arm/arch-versatile/hardware.h |    4 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 2aa150b..3b85761 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -188,12 +188,12 @@ #ifdef CONFIG_PCI
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	=  VERSATILE_PCI_VIRT_BASE,
+		.virtual	=  (unsigned long)VERSATILE_PCI_VIRT_BASE,
 		.pfn		= __phys_to_pfn(VERSATILE_PCI_BASE),
 		.length		= VERSATILE_PCI_BASE_SIZE,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	=  VERSATILE_PCI_CFG_VIRT_BASE,
+		.virtual	=  (unsigned long)VERSATILE_PCI_CFG_VIRT_BASE,
 		.pfn		= __phys_to_pfn(VERSATILE_PCI_CFG_BASE),
 		.length		= VERSATILE_PCI_CFG_BASE_SIZE,
 		.type		= MT_DEVICE
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 13bbd08..5cd0b5d 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -40,14 +40,15 @@ #include <asm/mach/pci.h>
  * Cfg   42000000 - 42FFFFFF	  PCI config
  *
  */
-#define SYS_PCICTL			IO_ADDRESS(VERSATILE_SYS_PCICTL)
-#define PCI_IMAP0			IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x0)
-#define PCI_IMAP1			IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x4)
-#define PCI_IMAP2			IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x8)
-#define PCI_SMAP0			IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x10)
-#define PCI_SMAP1			IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x14)
-#define PCI_SMAP2			IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x18)
-#define PCI_SELFID			IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0xc)
+#define __IO_ADDRESS(n) ((void __iomem *)(unsigned long)IO_ADDRESS(n))
+#define SYS_PCICTL		__IO_ADDRESS(VERSATILE_SYS_PCICTL)
+#define PCI_IMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x0)
+#define PCI_IMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x4)
+#define PCI_IMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x8)
+#define PCI_SMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x10)
+#define PCI_SMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x14)
+#define PCI_SMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x18)
+#define PCI_SELFID		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0xc)
 
 #define DEVICE_ID_OFFSET		0x00
 #define CSR_OFFSET			0x04
@@ -76,7 +77,7 @@ static int __init versatile_pci_slot_ign
 __setup("pci_slot_ignore=", versatile_pci_slot_ignore);
 
 
-static unsigned long __pci_addr(struct pci_bus *bus,
+static void __iomem *__pci_addr(struct pci_bus *bus,
 				unsigned int devfn, int offset)
 {
 	unsigned int busnr = bus->number;
@@ -91,14 +92,14 @@ static unsigned long __pci_addr(struct p
 	if (devfn > 255)
 		BUG();
 
-	return (VERSATILE_PCI_CFG_VIRT_BASE | (busnr << 16) |
+	return VERSATILE_PCI_CFG_VIRT_BASE + ((busnr << 16) |
 		(PCI_SLOT(devfn) << 11) | (PCI_FUNC(devfn) << 8) | offset);
 }
 
 static int versatile_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 				 int size, u32 *val)
 {
-	unsigned long addr = __pci_addr(bus, devfn, where);
+	void __iomem *addr = __pci_addr(bus, devfn, where & ~3);
 	u32 v;
 	int slot = PCI_SLOT(devfn);
 
@@ -121,13 +122,12 @@ static int versatile_read_config(struct 
 			break;
 
 		case 2:
-			v = __raw_readl(addr & ~3);
-			if (addr & 2) v >>= 16;
+			v = __raw_readl(addr);
+			if (where & 2) v >>= 16;
  			v &= 0xffff;
 			break;
 
 		default:
-			addr &= ~3;
 			v = __raw_readl(addr);
 			break;
 		}
@@ -140,7 +140,7 @@ static int versatile_read_config(struct 
 static int versatile_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 				  int size, u32 val)
 {
-	unsigned long addr = __pci_addr(bus, devfn, where);
+	void __iomem *addr = __pci_addr(bus, devfn, where);
 	int slot = PCI_SLOT(devfn);
 
 	if (pci_slot_ignore & (1 << slot)) {
@@ -279,7 +279,7 @@ int __init pci_versatile_setup(int nr, s
 	printk("PCI core found (slot %d)\n",myslot);
 
 	__raw_writel(myslot, PCI_SELFID);
-	local_pci_cfg_base = (void *) VERSATILE_PCI_CFG_VIRT_BASE + (myslot << 11);
+	local_pci_cfg_base = VERSATILE_PCI_CFG_VIRT_BASE + (myslot << 11);
 
 	val = __raw_readl(local_pci_cfg_base + CSR_OFFSET);
 	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
diff --git a/include/asm-arm/arch-versatile/hardware.h b/include/asm-arm/arch-versatile/hardware.h
index 41c1bee..edc0659 100644
--- a/include/asm-arm/arch-versatile/hardware.h
+++ b/include/asm-arm/arch-versatile/hardware.h
@@ -28,8 +28,8 @@ #include <asm/arch/platform.h>
 /*
  * PCI space virtual addresses
  */
-#define VERSATILE_PCI_VIRT_BASE		0xe8000000
-#define VERSATILE_PCI_CFG_VIRT_BASE	0xe9000000
+#define VERSATILE_PCI_VIRT_BASE		(void __iomem *)0xe8000000ul
+#define VERSATILE_PCI_CFG_VIRT_BASE	(void __iomem *)0xe9000000ul
 
 #if 0
 #define VERSATILE_PCI_VIRT_MEM_BASE0	0xf4000000
-- 
1.4.2.GIT


