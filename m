Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264079AbUDRAB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUDRABY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:01:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16286 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264079AbUDRAAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:00:34 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE cleanups/fixups for 2.6.6-rc1 [2/3]
Date: Sun, 18 Apr 2004 01:52:01 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404180152.01375.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide_init_default_hwifs() -> ide_init_default_irq()

init_ide_data() initializes default IDE interfaces but without default IRQ
(hwif->irq and hwif->hw.irq fields) so introduce ide_init_default_irq() and
remove redundant ide_init_default_hwifs() (except arm26 and arm ones).

As a side-effect it fixes:
- CONFIG_BLK_DEV_HD_IDE if !CONFIG_BLK_DEV_IDEPCI (i386)
- hwif->noprobe shouldn't be 0 if !hwif->io_ports[IDE_DATA_OFFSET]
  (alpha, i386, ia64, mips, sh, x86_64)

 linux-2.6.5-bk2-bzolnier/drivers/ide/ide.c                   |    5 ++
 linux-2.6.5-bk2-bzolnier/include/asm-alpha/ide.h             |   20 +--------
 linux-2.6.5-bk2-bzolnier/include/asm-arm/ide.h               |    2 
 linux-2.6.5-bk2-bzolnier/include/asm-arm26/ide.h             |    2 
 linux-2.6.5-bk2-bzolnier/include/asm-h8300/ide.h             |    5 --
 linux-2.6.5-bk2-bzolnier/include/asm-i386/ide.h              |   19 ++-------
 linux-2.6.5-bk2-bzolnier/include/asm-ia64/ide.h              |   18 +-------
 linux-2.6.5-bk2-bzolnier/include/asm-m68k/ide.h              |    8 ---
 linux-2.6.5-bk2-bzolnier/include/asm-m68knommu/ide.h         |   23 -----------
 linux-2.6.5-bk2-bzolnier/include/asm-mips/mach-generic/ide.h |   19 ++-------
 linux-2.6.5-bk2-bzolnier/include/asm-parisc/ide.h            |    3 -
 linux-2.6.5-bk2-bzolnier/include/asm-ppc/ide.h               |   20 +--------
 linux-2.6.5-bk2-bzolnier/include/asm-ppc64/ide.h             |    4 -
 linux-2.6.5-bk2-bzolnier/include/asm-sh/ide.h                |   19 ++-------
 linux-2.6.5-bk2-bzolnier/include/asm-sparc/ide.h             |    3 -
 linux-2.6.5-bk2-bzolnier/include/asm-sparc64/ide.h           |    3 -
 linux-2.6.5-bk2-bzolnier/include/asm-x86_64/ide.h            |   19 ++-------
 17 files changed, 48 insertions(+), 144 deletions(-)

diff -puN drivers/ide/ide.c~ide_init_default_irq drivers/ide/ide.c
--- linux-2.6.5-bk2/drivers/ide/ide.c~ide_init_default_irq	2004-04-18 01:07:16.345725464 +0200
+++ linux-2.6.5-bk2-bzolnier/drivers/ide/ide.c	2004-04-18 01:07:16.435711784 +0200
@@ -307,12 +307,17 @@ static void __init init_ide_data (void)
 		hwif = &ide_hwifs[index];
 		init_hwif_data(hwif, index);
 		init_hwif_default(hwif, index);
+		hwif->irq = hwif->hw.irq =
+			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
 	}
 
+/* OBSOLETE: still needed on arm26 and arm */
+#ifdef CONFIG_ARM
 	/* Add default hw interfaces */
 	initializing = 1;
 	ide_init_default_hwifs();
 	initializing = 0;
+#endif
 }
 
 /*
diff -puN include/asm-alpha/ide.h~ide_init_default_irq include/asm-alpha/ide.h
--- linux-2.6.5-bk2/include/asm-alpha/ide.h~ide_init_default_irq	2004-04-18 01:07:16.364722576 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-alpha/ide.h	2004-04-18 01:15:32.211342432 +0200
@@ -63,23 +63,11 @@ static inline void ide_init_hwif_ports(h
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_PCI
-	hw_regs_t hw;
-	int index;
-
-	for (index = 0; index < MAX_HWIFS; index++) {
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
+#ifdef CONFIG_PCI
+#define ide_init_default_irq(base)	(0)
+#else
+#define ide_init_default_irq(base)	ide_default_irq(base)
 #endif
-}
 
 #include <asm-generic/ide_iops.h>
 
diff -puN include/asm-arm/ide.h~ide_init_default_irq include/asm-arm/ide.h
--- linux-2.6.5-bk2/include/asm-arm/ide.h~ide_init_default_irq	2004-04-18 01:07:16.368721968 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-arm/ide.h	2004-04-18 01:07:16.437711480 +0200
@@ -26,6 +26,8 @@
 #define ide_default_io_base(i)		(0)
 #define ide_default_irq(b)		(0)
 
+#define ide_init_default_irq(base)	(0)
+
 #define __ide_mm_insw(port,addr,len)	readsw(port,addr,len)
 #define __ide_mm_insl(port,addr,len)	readsl(port,addr,len)
 #define __ide_mm_outsw(port,addr,len)	writesw(port,addr,len)
diff -puN include/asm-arm26/ide.h~ide_init_default_irq include/asm-arm26/ide.h
--- linux-2.6.5-bk2/include/asm-arm26/ide.h~ide_init_default_irq	2004-04-18 01:07:16.371721512 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-arm26/ide.h	2004-04-18 01:07:16.437711480 +0200
@@ -45,6 +45,8 @@ static inline void ide_init_hwif_ports(h
                 *irq = 0;
 }
 
+#define ide_init_default_irq(base)	(0)
+
 /*
  * This registers the standard ports for this architecture with the IDE
  * driver.
diff -puN include/asm-h8300/ide.h~ide_init_default_irq include/asm-h8300/ide.h
--- linux-2.6.5-bk2/include/asm-h8300/ide.h~ide_init_default_irq	2004-04-18 01:07:16.376720752 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-h8300/ide.h	2004-04-18 01:07:16.438711328 +0200
@@ -25,10 +25,7 @@ static __inline__ void ide_init_hwif_por
 {
 }
 
-
-static inline void ide_init_default_hwifs(void)
-{
-}
+#define ide_init_default_irq(base)	(0)
 
 #define MAX_HWIFS	1
 
diff -puN include/asm-i386/ide.h~ide_init_default_irq include/asm-i386/ide.h
--- linux-2.6.5-bk2/include/asm-i386/ide.h~ide_init_default_irq	2004-04-18 01:07:16.379720296 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-i386/ide.h	2004-04-18 01:15:32.212342280 +0200
@@ -90,20 +90,11 @@ static __inline__ void ide_init_hwif_por
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-static __inline__ void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_BLK_DEV_IDEPCI
-	hw_regs_t hw;
-	int index;
-
-	for(index = 0; index < MAX_HWIFS; index++) {
-		memset(&hw, 0, sizeof hw);
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
-}
+#ifdef CONFIG_BLK_DEV_IDEPCI
+#define ide_init_default_irq(base)	(0)
+#else
+#define ide_init_default_irq(base)	ide_default_irq(base)
+#endif
 
 #include <asm-generic/ide_iops.h>
 
diff -puN include/asm-ia64/ide.h~ide_init_default_irq include/asm-ia64/ide.h
--- linux-2.6.5-bk2/include/asm-ia64/ide.h~ide_init_default_irq	2004-04-18 01:07:16.383719688 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-ia64/ide.h	2004-04-18 01:15:32.213342128 +0200
@@ -73,21 +73,11 @@ static inline void ide_init_hwif_ports(h
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-static __inline__ void
-ide_init_default_hwifs (void)
-{
-#ifndef CONFIG_PCI
-	hw_regs_t hw;
-	int index;
-
-	for(index = 0; index < MAX_HWIFS; index++) {
-		memset(&hw, 0, sizeof hw);
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
+#ifdef CONFIG_PCI
+#define ide_init_default_irq(base)	(0)
+#else
+#define ide_init_default_irq(base)	ide_default_irq(base)
 #endif
-}
 
 #include <asm-generic/ide_iops.h>
 
diff -puN include/asm-m68k/ide.h~ide_init_default_irq include/asm-m68k/ide.h
--- linux-2.6.5-bk2/include/asm-m68k/ide.h~ide_init_default_irq	2004-04-18 01:07:16.391718472 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-m68k/ide.h	2004-04-18 01:07:16.440711024 +0200
@@ -74,13 +74,7 @@ static __inline__ void ide_init_hwif_por
 		printk("ide_init_hwif_ports: must not be called\n");
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-}
+#define ide_init_default_irq(base)	(0)
 
 /*
  * Get rid of defs from io.h - ide has its private and conflicting versions
diff -puN include/asm-m68knommu/ide.h~ide_init_default_irq include/asm-m68knommu/ide.h
--- linux-2.6.5-bk2/include/asm-m68knommu/ide.h~ide_init_default_irq	2004-04-18 01:07:16.395717864 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-m68knommu/ide.h	2004-04-18 01:07:16.441710872 +0200
@@ -139,28 +139,7 @@ static IDE_INLINE void ide_init_hwif_por
 	}
 }
 
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static IDE_INLINE void ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-	ide_ioreg_t base;
-	int index;
-
-	for (index = 0; index < MAX_HWIFS; index++) {
-		base = ide_default_io_base(index);
-		if (!base)
-			continue;
-		memset(&hw, 0, sizeof(hw));
-		ide_init_hwif_ports(&hw, base, 0, NULL);
-		hw.irq = ide_default_irq(base);
-		ide_register_hw(&hw, NULL);
-	}
-}
-
+#define ide_init_default_irq(base)	ide_default_irq(base)
 
 static IDE_INLINE int
 ide_request_irq(
diff -puN include/asm-mips/mach-generic/ide.h~ide_init_default_irq include/asm-mips/mach-generic/ide.h
--- linux-2.6.5-bk2/include/asm-mips/mach-generic/ide.h~ide_init_default_irq	2004-04-18 01:07:16.398717408 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-mips/mach-generic/ide.h	2004-04-18 01:15:32.213342128 +0200
@@ -68,19 +68,10 @@ static inline void ide_init_hwif_ports(h
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-static inline void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_BLK_DEV_IDEPCI
-	hw_regs_t hw;
-	int index;
-
-	for(index = 0; index < MAX_HWIFS; index++) {
-		memset(&hw, 0, sizeof hw);
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
-}
+#ifdef CONFIG_BLK_DEV_IDEPCI
+#define ide_init_default_irq(base)	(0)
+#else
+#define ide_init_default_irq(base)	ide_default_irq(base)
+#endif
 
 #endif /* __ASM_MACH_GENERIC_IDE_H */
diff -puN include/asm-parisc/ide.h~ide_init_default_irq include/asm-parisc/ide.h
--- linux-2.6.5-bk2/include/asm-parisc/ide.h~ide_init_default_irq	2004-04-18 01:07:16.402716800 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-parisc/ide.h	2004-04-18 01:15:32.214341976 +0200
@@ -42,8 +42,7 @@ static inline void ide_init_hwif_ports(h
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-/* There are no standard ports. */
-static inline void ide_init_default_hwifs(void)	{ ; }
+#define ide_init_default_irq(base)	(0)
 
 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
diff -puN include/asm-ppc/ide.h~ide_init_default_irq include/asm-ppc/ide.h
--- linux-2.6.5-bk2/include/asm-ppc/ide.h~ide_init_default_irq	2004-04-18 01:07:16.405716344 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-ppc/ide.h	2004-04-18 01:15:32.215341824 +0200
@@ -84,23 +84,11 @@ static __inline__ void ide_init_hwif_por
 		ppc_ide_md.ide_init_hwif(hw, data_port, ctrl_port, irq);
 }
 
-static __inline__ void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_PCI
-	hw_regs_t hw;
-	int index;
-	unsigned long base;
-
-	for (index = 0; index < MAX_HWIFS; index++) {
-		base = ide_default_io_base(index);
-		if (base == 0)
-			continue;
-		ide_init_hwif_ports(&hw, base, 0, NULL);
-		hw.irq = ide_default_irq(base);
-		ide_register_hw(&hw, NULL);
-	}
+#ifdef CONFIG_PCI
+#define ide_init_default_irq(base)	(0)
+#else
+#define ide_init_default_irq(base)	ide_default_irq(base)
 #endif
-}
 
 #if (defined CONFIG_APUS || defined CONFIG_BLK_DEV_MPC8xx_IDE )
 #define IDE_ARCH_ACK_INTR  1
diff -puN include/asm-ppc64/ide.h~ide_init_default_irq include/asm-ppc64/ide.h
--- linux-2.6.5-bk2/include/asm-ppc64/ide.h~ide_init_default_irq	2004-04-18 01:07:16.415714824 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-ppc64/ide.h	2004-04-18 01:15:32.215341824 +0200
@@ -45,9 +45,7 @@ static inline void ide_init_hwif_ports(h
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-static __inline__ void ide_init_default_hwifs(void)
-{
-}
+#define ide_init_default_irq(base)	(0)
 
 #endif /* __KERNEL__ */
 
diff -puN include/asm-sh/ide.h~ide_init_default_irq include/asm-sh/ide.h
--- linux-2.6.5-bk2/include/asm-sh/ide.h~ide_init_default_irq	2004-04-18 01:07:16.418714368 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-sh/ide.h	2004-04-18 01:15:32.216341672 +0200
@@ -92,20 +92,11 @@ static inline void ide_init_hwif_ports(h
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-static __inline__ void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_PCI
-	hw_regs_t hw;
-	int index;
-
-	for(index = 0; index < MAX_HWIFS; index++) {
-		memset(&hw, 0, sizeof hw);
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
-#endif /* CONFIG_PCI */
-}
+#ifdef CONFIG_PCI
+#define ide_init_default_irq(base)	(0)
+#else
+#define ide_init_default_irq(base)	ide_default_irq(base)
+#endif
 
 #include <asm-generic/ide_iops.h>
 
diff -puN include/asm-sparc/ide.h~ide_init_default_irq include/asm-sparc/ide.h
--- linux-2.6.5-bk2/include/asm-sparc/ide.h~ide_init_default_irq	2004-04-18 01:07:16.422713760 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-sparc/ide.h	2004-04-18 01:15:32.225340304 +0200
@@ -52,8 +52,7 @@ static __inline__ void ide_init_hwif_por
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-/* There are no standard ports. */
-static inline void ide_init_default_hwifs(void)	{ ; }
+#define ide_init_default_irq(base)	(0)
 
 #define __ide_insl(data_reg, buffer, wcount) \
 	__ide_insw(data_reg, buffer, (wcount)<<1)
diff -puN include/asm-sparc64/ide.h~ide_init_default_irq include/asm-sparc64/ide.h
--- linux-2.6.5-bk2/include/asm-sparc64/ide.h~ide_init_default_irq	2004-04-18 01:07:16.425713304 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-sparc64/ide.h	2004-04-18 01:15:32.224340456 +0200
@@ -53,8 +53,7 @@ static __inline__ void ide_init_hwif_por
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-/* There are no standard ports. */
-static inline void ide_init_default_hwifs(void)	{ ; }
+#define ide_init_default_irq(base)	(0)
 
 #define __ide_insl(data_reg, buffer, wcount) \
 	__ide_insw(data_reg, buffer, (wcount)<<1)
diff -puN include/asm-x86_64/ide.h~ide_init_default_irq include/asm-x86_64/ide.h
--- linux-2.6.5-bk2/include/asm-x86_64/ide.h~ide_init_default_irq	2004-04-18 01:07:16.429712696 +0200
+++ linux-2.6.5-bk2-bzolnier/include/asm-x86_64/ide.h	2004-04-18 01:15:32.225340304 +0200
@@ -71,20 +71,11 @@ static __inline__ void ide_init_hwif_por
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-static __inline__ void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_BLK_DEV_IDEPCI
-	hw_regs_t hw;
-	int index;
-
-	for(index = 0; index < MAX_HWIFS; index++) {
-		memset(&hw, 0, sizeof hw);
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
-}
+#ifdef CONFIG_BLK_DEV_IDEPCI
+#define ide_init_default_irq(base)	(0)
+#else
+#define ide_init_default_irq(base)	ide_default_irq(base)
+#endif
 
 #include <asm-generic/ide_iops.h>
 

_

