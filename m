Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUEOOV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUEOOV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUEOOVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:21:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64213 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262538AbUEOOV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:21:28 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
Subject: [PATCH] add default ARM/ARM26 IDE host driver
Date: Sat, 15 May 2004 16:21:27 +0200
User-Agent: KMail/1.5.3
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405151621.27450.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ported to 2.6.6-bk1 and cleaned a bit.

Add drivers/ide/arm/ide_arm.c for simple default IDE interfaces
and clean obsolete ide_init_default_hwifs() implementations
in asm-arm/arch-{cl7500,rpc,shark}/ide.h and asm-arm26/ide.h.

This allows us to kill ide_init_default_hwifs() completely
in the next patch (because lh7a40x and sa1100 are broken).

Cross-compile tested on ARM.

 linux-2.6.6-bk1-bzolnier/drivers/ide/Kconfig               |    3 
 linux-2.6.6-bk1-bzolnier/drivers/ide/Makefile              |    3 
 linux-2.6.6-bk1-bzolnier/drivers/ide/arm/ide_arm.c         |   43 +++++++++++++
 linux-2.6.6-bk1-bzolnier/drivers/ide/ide.c                 |    5 +
 linux-2.6.6-bk1-bzolnier/include/asm-arm/arch-cl7500/ide.h |   16 ----
 linux-2.6.6-bk1-bzolnier/include/asm-arm/arch-rpc/ide.h    |   15 ----
 linux-2.6.6-bk1-bzolnier/include/asm-arm/arch-shark/ide.h  |   17 -----
 linux-2.6.6-bk1-bzolnier/include/asm-arm26/ide.h           |   18 -----
 8 files changed, 58 insertions(+), 62 deletions(-)

diff -puN /dev/null drivers/ide/arm/ide_arm.c
--- /dev/null	2004-01-17 00:25:55.000000000 +0100
+++ linux-2.6.6-bk1-bzolnier/drivers/ide/arm/ide_arm.c	2004-05-15 03:30:51.000000000 +0200
@@ -0,0 +1,43 @@
+/*
+ * ARM/ARM26 default IDE host driver
+ *
+ * Copyright (C) 2004 Bartlomiej Zolnierkiewicz
+ * Based on code by: Russell King, Ian Molton and Alexander Schulz.
+ *
+ * May be copied or modified under the terms of the GNU General Public License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+
+#include <asm/mach-types.h>
+#include <asm/irq.h>
+
+#ifdef CONFIG_ARM26
+# define IDE_ARM_HOST	(machine_is_a5k())
+#else
+# define IDE_ARM_HOST	(1)
+#endif
+
+#ifdef CONFIG_ARCH_CLPS7500
+# include <asm/arch/hardware.h>
+#
+# define IDE_ARM_IO	(ISASLOT_IO + 0x1f0)
+# define IDE_ARM_IRQ	IRQ_ISA_14
+#else
+# define IDE_ARM_IO	0x1f0
+# define IDE_ARM_IRQ	IRQ_HARDDISK
+#endif
+
+void __init ide_arm_init(void)
+{
+	if (IDE_ARM_HOST) {
+		hw_regs_t hw;
+
+		memset(&hw, 0, sizeof(hw));
+		ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
+		hw.irq = IDE_ARM_IRQ;
+		ide_register_hw(&hw, NULL);
+	}
+}
diff -puN drivers/ide/ide.c~ide_arm drivers/ide/ide.c
--- linux-2.6.6-bk1/drivers/ide/ide.c~ide_arm	2004-05-15 02:51:26.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/drivers/ide/ide.c	2004-05-15 15:56:04.376084776 +0200
@@ -272,6 +272,8 @@ static void init_hwif_default(ide_hwif_t
 #endif
 }
 
+extern void ide_arm_init(void);
+
 /*
  * init_ide_data() sets reasonable default values into all fields
  * of all instances of the hwifs and drives, but only on the first call.
@@ -320,6 +322,9 @@ static void __init init_ide_data (void)
 	ide_init_default_hwifs();
 	initializing = 0;
 #endif
+#ifdef CONFIG_IDE_ARM
+	ide_arm_init();
+#endif
 }
 
 /*
diff -puN drivers/ide/Kconfig~ide_arm drivers/ide/Kconfig
--- linux-2.6.6-bk1/drivers/ide/Kconfig~ide_arm	2004-05-15 03:30:59.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/drivers/ide/Kconfig	2004-05-15 03:32:35.000000000 +0200
@@ -855,6 +855,9 @@ config BLK_DEV_IDE_SWARM
 	bool "SWARM onboard IDE support"
 	depends on SIBYTE_SWARM
 
+config IDE_ARM
+	def_bool ARM && (ARCH_A5K || ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
+
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
 	depends on ARM && ARCH_ACORN
diff -puN drivers/ide/Makefile~ide_arm drivers/ide/Makefile
--- linux-2.6.6-bk1/drivers/ide/Makefile~ide_arm	2004-05-15 02:51:26.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/drivers/ide/Makefile	2004-05-15 03:32:48.000000000 +0200
@@ -25,6 +25,9 @@ ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= id
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 
+# built-in only drivers from arm/
+ide-core-$(CONFIG_IDE_ARM)		+= arm/ide_arm.o
+
 # built-in only drivers from legacy/
 ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= legacy/pc9800.o
 ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= legacy/buddha.o
diff -puN include/asm-arm26/ide.h~ide_arm include/asm-arm26/ide.h
--- linux-2.6.6-bk1/include/asm-arm26/ide.h~ide_arm	2004-05-15 02:51:26.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-arm26/ide.h	2004-05-15 15:56:04.387083104 +0200
@@ -47,23 +47,7 @@ static inline void ide_init_hwif_ports(h
 
 #define ide_init_default_irq(base)	(0)
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-        if (machine_is_a5k()) {
-                hw_regs_t hw;
-
-                memset(&hw, 0, sizeof(hw));
-
-                ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
-                hw.irq = IRQ_HARDDISK;
-                ide_register_hw(&hw,NULL);
-        }
-}
-
+static inline void ide_init_default_hwifs(void) { ; }
 
 /*
  * We always use the new IDE port registering,
diff -puN include/asm-arm/arch-cl7500/ide.h~ide_arm include/asm-arm/arch-cl7500/ide.h
--- linux-2.6.6-bk1/include/asm-arm/arch-cl7500/ide.h~ide_arm	2004-05-15 02:51:26.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-arm/arch-cl7500/ide.h	2004-05-15 15:56:04.388082952 +0200
@@ -6,8 +6,6 @@
  * Modifications:
  *  29-07-1998	RMK	Major re-work of IDE architecture specific code
  */
-#include <asm/irq.h>
-#include <asm/arch/hardware.h>
 
 /*
  * Set up a hw structure for a specified data port, control port and IRQ.
@@ -35,16 +33,4 @@ static inline void ide_init_hwif_ports(h
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-
-	ide_init_hwif_ports(&hw, ISASLOT_IO + 0x1f0, ISASLOT_IO + 0x3f6, NULL);
-	hw.irq = IRQ_ISA_14;
-	ide_register_hw(&hw);
-}
+static inline void ide_init_default_hwifs(void) { ; }
diff -puN include/asm-arm/arch-rpc/ide.h~ide_arm include/asm-arm/arch-rpc/ide.h
--- linux-2.6.6-bk1/include/asm-arm/arch-rpc/ide.h~ide_arm	2004-05-15 02:51:26.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-arm/arch-rpc/ide.h	2004-05-15 15:56:04.393082192 +0200
@@ -10,7 +10,6 @@
  *  Modifications:
  *   29-07-1998	RMK	Major re-work of IDE architecture specific code
  */
-#include <asm/irq.h>
 
 /*
  * Set up a hw structure for a specified data port, control port and IRQ.
@@ -33,16 +32,4 @@ static inline void ide_init_hwif_ports(h
 		*irq = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-
-	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
-	hw.irq = IRQ_HARDDISK;
-	ide_register_hw(&hw, NULL);
-}
+static inline void ide_init_default_hwifs(void) { ; }
diff -puN include/asm-arm/arch-shark/ide.h~ide_arm include/asm-arm/arch-shark/ide.h
--- linux-2.6.6-bk1/include/asm-arm/arch-shark/ide.h~ide_arm	2004-05-15 02:51:26.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-arm/arch-shark/ide.h	2004-05-15 15:56:04.394082040 +0200
@@ -8,8 +8,6 @@
  * Copyright (c) 1998 Russell King
  */
 
-#include <asm/irq.h>
-
 /*
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
@@ -31,17 +29,4 @@ static inline void ide_init_hwif_ports(h
 		*irq = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-
-	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
-	hw.irq = 14;
-	ide_register_hw(&hw,NULL);
-}
-
+static inline void ide_init_default_hwifs(void) { ; }

_

