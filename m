Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUEOW1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUEOW1W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 18:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbUEOW1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 18:27:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:22955 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264760AbUEOW0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 18:26:08 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
Subject: Re: [PATCH] ARM/ARM26 IDE cleanups
Date: Sun, 16 May 2004 00:26:48 +0200
User-Agent: KMail/1.5.3
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200405151621.29291.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405151621.29291.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405160026.48525.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I changed IDE_ARCH_NO_OBSOLETE_INIT to IDE_ARCH_OBSOLETE_INIT
(per jgarzik's suggestion) and fixed patch description.


[PATCH] ARM/ARM26 IDE cleanups

- clear hwif->hw in setup-pci.c before using it

- fix arch/arm/Kconfig to allow IDE only on platforms supporting it

- introduce IDE_ARCH_OBSOLETE_INIT and ide_default_io_ctl() so
  we can use generic ide_init_hwif_ports() and kill no longer needed
  <asm-arm/arch-*/ide.h> (leave broken lh7a40x and sa1100 versions)

Cross-compile tested on ARM.

 linux-2.6.6-bk1-bzolnier/arch/arm/Kconfig                    |    2 
 linux-2.6.6-bk1-bzolnier/drivers/ide/ide.c                   |    7 -
 linux-2.6.6-bk1-bzolnier/drivers/ide/setup-pci.c             |    7 -
 linux-2.6.6-bk1-bzolnier/include/asm-alpha/ide.h             |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-arm/arch-lh7a40x/ide.h  |    7 -
 linux-2.6.6-bk1-bzolnier/include/asm-arm/ide.h               |   18 ++-
 linux-2.6.6-bk1-bzolnier/include/asm-arm26/ide.h             |   28 -----
 linux-2.6.6-bk1-bzolnier/include/asm-i386/ide.h              |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-ia64/ide.h              |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-mips/mach-generic/ide.h |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-parisc/ide.h            |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-ppc/ide.h               |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-ppc64/ide.h             |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-sh/ide.h                |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-sparc/ide.h             |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-sparc64/ide.h           |    3 
 linux-2.6.6-bk1-bzolnier/include/asm-x86_64/ide.h            |    3 
 linux-2.6.6-bk1-bzolnier/include/linux/ide.h                 |   13 +-
 linux-2.6.6-bk1/include/asm-arm/arch-cl7500/ide.h            |   36 -------
 linux-2.6.6-bk1/include/asm-arm/arch-ebsa110/ide.h           |    1 
 linux-2.6.6-bk1/include/asm-arm/arch-ebsa285/ide.h           |   49 ---------
 linux-2.6.6-bk1/include/asm-arm/arch-iop3xx/ide.h            |   49 ---------
 linux-2.6.6-bk1/include/asm-arm/arch-l7200/ide.h             |   27 -----
 linux-2.6.6-bk1/include/asm-arm/arch-nexuspci/ide.h          |   37 -------
 linux-2.6.6-bk1/include/asm-arm/arch-pxa/ide.h               |   54 -----------
 linux-2.6.6-bk1/include/asm-arm/arch-rpc/ide.h               |   35 -------
 linux-2.6.6-bk1/include/asm-arm/arch-s3c2410/ide.h           |   49 ---------
 linux-2.6.6-bk1/include/asm-arm/arch-shark/ide.h             |   32 ------
 linux-2.6.6-bk1/include/asm-arm/arch-tbox/ide.h              |    3 
 29 files changed, 63 insertions(+), 424 deletions(-)

diff -puN arch/arm/Kconfig~ide_arch_arm arch/arm/Kconfig
--- linux-2.6.6-bk1/arch/arm/Kconfig~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/arch/arm/Kconfig	2004-05-15 16:01:25.000000000 +0200
@@ -604,7 +604,9 @@ source "drivers/acorn/block/Kconfig"
 
 source "net/Kconfig"
 
+if ARCH_CLPS7500 || ARCH_IOP3XX || ARCH_L7200 || ARCH_LH7A40X || ARCH_FTVPCI || ARCH_PXA || ARCH_RPC || ARCH_S3C2410 || ARCH_SA1100 || ARCH_SHARK || FOOTBRIDGE
 source "drivers/ide/Kconfig"
+endif
 
 source "drivers/scsi/Kconfig"
 
diff -puN drivers/ide/ide.c~ide_arch_arm drivers/ide/ide.c
--- linux-2.6.6-bk1/drivers/ide/ide.c~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/drivers/ide/ide.c	2004-05-15 20:13:47.196378784 +0200
@@ -315,13 +315,6 @@ static void __init init_ide_data (void)
 #endif
 	}
 
-/* OBSOLETE: still needed on arm26 and arm */
-#ifdef CONFIG_ARM
-	/* Add default hw interfaces */
-	initializing = 1;
-	ide_init_default_hwifs();
-	initializing = 0;
-#endif
 #ifdef CONFIG_IDE_ARM
 	ide_arm_init();
 #endif
diff -puN drivers/ide/setup-pci.c~ide_arch_arm drivers/ide/setup-pci.c
--- linux-2.6.6-bk1/drivers/ide/setup-pci.c~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/drivers/ide/setup-pci.c	2004-05-15 16:01:25.000000000 +0200
@@ -444,13 +444,12 @@ static ide_hwif_t *ide_hwif_configure(st
 	}
 	if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL)
 		return NULL;	/* no room in ide_hwifs[] */
-	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
-fixup_address:
+	if (hwif->io_ports[IDE_DATA_OFFSET] != base ||
+	    hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
+		memset(&hwif->hw, 0, sizeof(hwif->hw));
 		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
 		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
-	} else if (hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
-		goto fixup_address;
 	}
 	hwif->chipset = ide_pci;
 	hwif->pci_dev = dev;
diff -puN include/asm-alpha/ide.h~ide_arch_arm include/asm-alpha/ide.h
--- linux-2.6.6-bk1/include/asm-alpha/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-alpha/ide.h	2004-05-15 20:16:12.680261872 +0200
@@ -43,6 +43,9 @@ static inline unsigned long ide_default_
 	}
 }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #ifdef CONFIG_PCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-arm26/ide.h~ide_arch_arm include/asm-arm26/ide.h
--- linux-2.6.6-bk1/include/asm-arm26/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-arm26/ide.h	2004-05-15 20:17:28.813687832 +0200
@@ -26,36 +26,14 @@
 #define __ide_mm_outsw(port,addr,len)   writesw(port,addr,len)
 #define __ide_mm_outsl(port,addr,len)   writesl(port,addr,len)
 
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-        int i;
-
-        for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-                hw->io_ports[i] = reg;
-                reg += 1;
-        }
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-        if (irq)
-                *irq = 0;
-}
-
 #define ide_init_default_irq(base)	(0)
 
-static inline void ide_init_default_hwifs(void) { ; }
-
-/*
- * We always use the new IDE port registering,
- * so these are fixed here.
- */
 #define ide_default_io_base(i)		(0)
 #define ide_default_irq(b)		(0)
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASMARM_IDE_H */
diff -puN -L include/asm-arm/arch-cl7500/ide.h include/asm-arm/arch-cl7500/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-cl7500/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,36 +0,0 @@
-/*
- * linux/include/asm-arm/arch-cl7500/ide.h
- *
- * Copyright (c) 1997 Russell King
- *
- * Modifications:
- *  29-07-1998	RMK	Major re-work of IDE architecture specific code
- */
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = data_port + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static inline void ide_init_default_hwifs(void) { ; }
diff -puN -L include/asm-arm/arch-ebsa110/ide.h include/asm-arm/arch-ebsa110/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-ebsa110/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1 +0,0 @@
-/* no ide */
diff -puN -L include/asm-arm/arch-ebsa285/ide.h include/asm-arm/arch-ebsa285/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-ebsa285/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,49 +0,0 @@
-/*
- *  linux/include/asm-arm/arch-ebsa285/ide.h
- *
- *  Copyright (C) 1998 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Modifications:
- *   29-07-1998	RMK	Major re-work of IDE architecture specific code
- */
-#include <asm/irq.h>
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-#if 0
-	hw_regs_t hw;
-
-	memset(hw, 0, sizeof(*hw));
-
-	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
-	hw.irq = IRQ_HARDDISK;
-	ide_register_hw(&hw);
-#endif
-}
diff -puN -L include/asm-arm/arch-iop3xx/ide.h include/asm-arm/arch-iop3xx/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-iop3xx/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,49 +0,0 @@
-/*
- * include/asm-arm/arch-iop3xx/ide.h
- *
- * Generic IDE functions for IOP310 systems
- *
- * Author: Deepak Saxena <dsaxena@mvista.com>
- *
- * Copyright 2001 MontaVista Software Inc.
- *
- * 09/26/2001 - Sharon Baartmans
- * 	Fixed so it actually works.
- */
-
-#ifndef _ASM_ARCH_IDE_H_
-#define _ASM_ARCH_IDE_H_
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-	int regincr = 1;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += regincr;
-	}
-
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-
-	if (irq) *irq = 0;
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-	/* There are no standard ports */
-}
-
-#endif
diff -puN -L include/asm-arm/arch-l7200/ide.h include/asm-arm/arch-l7200/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-l7200/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,27 +0,0 @@
-/*
- * linux/include/asm-arm/arch-l7200/ide.h
- *
- * Copyright (c) 2000 Steve Hill (sjhill@cotw.com)
- *
- * Changelog:
- *  03-29-2000	SJH	Created file placeholder
- */
-#include <asm/irq.h>
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-}
diff -puN include/asm-arm/arch-lh7a40x/ide.h~ide_arch_arm include/asm-arm/arch-lh7a40x/ide.h
--- linux-2.6.6-bk1/include/asm-arm/arch-lh7a40x/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-arm/arch-lh7a40x/ide.h	2004-05-15 16:01:25.000000000 +0200
@@ -64,13 +64,6 @@ static __inline__  void ide_init_default
 	ide_register_hw (&hw, &hwif);
 	lpd7a40x_hwif_ioops (hwif); /* Override IO routines */
 }
-
-#else
-
-static __inline__ void ide_init_hwif_ports (hw_regs_t *hw, int data_port,
-					    int ctrl_port, int *irq) {}
-static __inline__ void ide_init_default_hwifs (void) {}
-
 #endif
 
 #endif
diff -puN -L include/asm-arm/arch-nexuspci/ide.h include/asm-arm/arch-nexuspci/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-nexuspci/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,37 +0,0 @@
-/*
- * linux/include/asm-arm/arch-nexuspci/ide.h
- *
- * Copyright (c) 1998 Russell King
- *
- * Modifications:
- *  29-07-1998	RMK	Major re-work of IDE architecture specific code
- */
-#include <asm/irq.h>
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-	/* There are no standard ports */
-}
diff -puN -L include/asm-arm/arch-pxa/ide.h include/asm-arm/arch-pxa/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-pxa/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,54 +0,0 @@
-/*
- * linux/include/asm-arm/arch-pxa/ide.h
- *
- * Author:	George Davis
- * Created:	Jan 10, 2002
- * Copyright:	MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *
- * Originally based upon linux/include/asm-arm/arch-sa1100/ide.h
- *
- */
-
-#include <asm/irq.h>
-#include <asm/hardware.h>
-#include <asm/mach-types.h>
-
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-	int regincr = 1;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += regincr;
-	}
-
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-
-	if (irq)
-		*irq = 0;
-}
-
-
-/*
- * Register the standard ports for this architecture with the IDE driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-	/* Nothing to declare... */
-}
diff -puN -L include/asm-arm/arch-rpc/ide.h include/asm-arm/arch-rpc/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-rpc/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,35 +0,0 @@
-/*
- *  linux/include/asm-arm/arch-rpc/ide.h
- *
- *  Copyright (C) 1997 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Modifications:
- *   29-07-1998	RMK	Major re-work of IDE architecture specific code
- */
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-static inline void ide_init_default_hwifs(void) { ; }
diff -puN -L include/asm-arm/arch-s3c2410/ide.h include/asm-arm/arch-s3c2410/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-s3c2410/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,49 +0,0 @@
-/* linux/include/asm-arm/arch-s3c2410/ide.h
- *
- *  Copyright (C) 1997 Russell King
- *  Copyright (C) 2003 Simtec Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Modifications:
- *   29-07-1998	RMK	Major re-work of IDE architecture specific code
- *   16-05-2003 BJD	Changed to work with BAST IDE ports
- *   04-09-2003 BJD	Modifications for V2.6
- */
-
-#ifndef __ASM_ARCH_IDE_H
-#define __ASM_ARCH_IDE_H
-
-#include <asm/irq.h>
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-/* we initialise our ide devices from the main ide core, due to problems
- * with doing it in this function
-*/
-
-#define ide_init_default_hwifs() do { } while(0)
-
-#endif /* __ASM_ARCH_IDE_H */
diff -puN -L include/asm-arm/arch-shark/ide.h include/asm-arm/arch-shark/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-shark/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,32 +0,0 @@
-/*
- * linux/include/asm-arm/arch-shark/ide.h
- *
- * by Alexander Schulz
- *
- * derived from:
- * linux/include/asm-arm/arch-ebsa285/ide.h
- * Copyright (c) 1998 Russell King
- */
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-static inline void ide_init_default_hwifs(void) { ; }
diff -puN -L include/asm-arm/arch-tbox/ide.h include/asm-arm/arch-tbox/ide.h~ide_arch_arm /dev/null
--- linux-2.6.6-bk1/include/asm-arm/arch-tbox/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,3 +0,0 @@
-/*
- * linux/include/asm-arm/arch-tbox/ide.h
- */
diff -puN include/asm-arm/ide.h~ide_arch_arm include/asm-arm/ide.h
--- linux-2.6.6-bk1/include/asm-arm/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-arm/ide.h	2004-05-15 20:17:02.277721912 +0200
@@ -17,13 +17,21 @@
 #define MAX_HWIFS	4
 #endif
 
-#include <asm/arch/ide.h>
+#if defined(CONFIG_ARCH_LH7A40X) || defined(CONFIG_ARCH_SA1100)
+# include <asm/arch/ide.h>	/* broken */
+#endif
 
-/*
- * We always use the new IDE port registering,
- * so these are fixed here.
- */
 #define ide_default_io_base(i)		(0)
+
+#if !defined(CONFIG_ARCH_L7200) && !defined(CONFIG_ARCH_LH7A40X)
+# define IDE_ARCH_OBSOLETE_INIT
+# ifdef CONFIG_ARCH_CLPS7500
+#  define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+# else
+#  define ide_default_io_ctl(base)	(0)
+# endif
+#endif /* !ARCH_L7200 && !ARCH_LH7A40X */
+
 #define ide_default_irq(b)		(0)
 
 #define ide_init_default_irq(base)	(0)
diff -puN include/asm-i386/ide.h~ide_arch_arm include/asm-i386/ide.h
--- linux-2.6.6-bk1/include/asm-i386/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-i386/ide.h	2004-05-15 20:18:05.041180416 +0200
@@ -85,6 +85,9 @@ static __inline__ void ide_init_hwif_por
 }
 #endif
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-ia64/ide.h~ide_arch_arm include/asm-ia64/ide.h
--- linux-2.6.6-bk1/include/asm-ia64/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-ia64/ide.h	2004-05-15 20:18:17.219329056 +0200
@@ -53,6 +53,9 @@ static inline unsigned long ide_default_
 	}
 }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #ifdef CONFIG_PCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-mips/mach-generic/ide.h~ide_arch_arm include/asm-mips/mach-generic/ide.h
--- linux-2.6.6-bk1/include/asm-mips/mach-generic/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-mips/mach-generic/ide.h	2004-05-15 20:18:36.051466136 +0200
@@ -48,6 +48,9 @@ static inline unsigned long ide_default_
 	}
 }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-parisc/ide.h~ide_arch_arm include/asm-parisc/ide.h
--- linux-2.6.6-bk1/include/asm-parisc/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-parisc/ide.h	2004-05-15 20:18:57.242244648 +0200
@@ -22,6 +22,9 @@
 #define ide_default_irq(base) (0)
 #define ide_default_io_base(index) (0)
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #define ide_init_default_irq(base)	(0)
 
 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
diff -puN include/asm-ppc64/ide.h~ide_arch_arm include/asm-ppc64/ide.h
--- linux-2.6.6-bk1/include/asm-ppc64/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-ppc64/ide.h	2004-05-15 20:19:24.960030904 +0200
@@ -25,6 +25,9 @@
 static inline int ide_default_irq(unsigned long base) { return 0; }
 static inline unsigned long ide_default_io_base(int index) { return 0; }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #define ide_init_default_irq(base)	(0)
 
 #endif /* __KERNEL__ */
diff -puN include/asm-ppc/ide.h~ide_arch_arm include/asm-ppc/ide.h
--- linux-2.6.6-bk1/include/asm-ppc/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-ppc/ide.h	2004-05-15 20:19:13.566762944 +0200
@@ -57,6 +57,9 @@ static __inline__ unsigned long ide_defa
 	return 0;
 }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #ifdef CONFIG_PCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-sh/ide.h~ide_arch_arm include/asm-sh/ide.h
--- linux-2.6.6-bk1/include/asm-sh/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-sh/ide.h	2004-05-15 20:19:55.908326048 +0200
@@ -72,6 +72,9 @@ static inline unsigned long ide_default_
 	}
 }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #ifdef CONFIG_PCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/asm-sparc64/ide.h~ide_arch_arm include/asm-sparc64/ide.h
--- linux-2.6.6-bk1/include/asm-sparc64/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-sparc64/ide.h	2004-05-15 20:20:29.356241192 +0200
@@ -34,6 +34,9 @@ static __inline__ unsigned long ide_defa
 	return 0;
 }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #define ide_init_default_irq(base)	(0)
 
 #define __ide_insl(data_reg, buffer, wcount) \
diff -puN include/asm-sparc/ide.h~ide_arch_arm include/asm-sparc/ide.h
--- linux-2.6.6-bk1/include/asm-sparc/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-sparc/ide.h	2004-05-15 20:20:11.201001208 +0200
@@ -29,6 +29,9 @@ static __inline__ unsigned long ide_defa
 	return 0;
 }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #define ide_init_default_irq(base)	(0)
 
 #define __ide_insl(data_reg, buffer, wcount) \
diff -puN include/asm-x86_64/ide.h~ide_arch_arm include/asm-x86_64/ide.h
--- linux-2.6.6-bk1/include/asm-x86_64/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/asm-x86_64/ide.h	2004-05-15 20:20:42.743206064 +0200
@@ -51,6 +51,9 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
+#define IDE_ARCH_OBSOLETE_INIT
+#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
+
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/linux/ide.h~ide_arch_arm include/linux/ide.h
--- linux-2.6.6-bk1/include/linux/ide.h~ide_arch_arm	2004-05-15 16:01:25.000000000 +0200
+++ linux-2.6.6-bk1-bzolnier/include/linux/ide.h	2004-05-15 20:15:27.324157048 +0200
@@ -307,18 +307,20 @@ static inline void ide_std_init_ports(hw
 
 /*
  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
+ * New ports shouldn't define IDE_ARCH_OBSOLETE_INIT in <asm/ide.h>.
  *
- * arm26, arm, h8300, m68k, m68knommu (broken) and i386-pc9800 (broken)
+ * h8300, m68k, m68knommu (broken) and i386-pc9800 (broken)
  * still have their own versions.
  */
-#if !defined(CONFIG_ARM) && !defined(CONFIG_H8300) && !defined(CONFIG_M68K)
+#if !defined(CONFIG_H8300) && !defined(CONFIG_M68K)
+#ifdef IDE_ARCH_OBSOLETE_INIT
 static inline void ide_init_hwif_ports(hw_regs_t *hw,
 				       unsigned long io_addr,
 				       unsigned long ctl_addr,
 				       int *irq)
 {
 	if (!ctl_addr)
-		ide_std_init_ports(hw, io_addr, io_addr + 0x206);
+		ide_std_init_ports(hw, io_addr, ide_default_io_ctl(io_addr));
 	else
 		ide_std_init_ports(hw, io_addr, ctl_addr);
 
@@ -332,7 +334,10 @@ static inline void ide_init_hwif_ports(h
 		ppc_ide_md.ide_init_hwif(hw, io_addr, ctl_addr, irq);
 #endif
 }
-#endif /* !ARM && !H8300 && !M68K */
+#else
+# define ide_init_hwif_ports(hw, io, ctl, irq)	do {} while (0)
+#endif /* IDE_ARCH_OBSOLETE_INIT */
+#endif /* !H8300 && !M68K */
 
 /* Currently only m68k, apus and m8xx need it */
 #ifndef IDE_ARCH_ACK_INTR

_

