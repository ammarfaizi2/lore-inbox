Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUECXhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUECXhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUECXgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:36:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11661 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264155AbUECXfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:35:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] remove dead PC9800 IDE support
Date: Tue, 4 May 2004 01:35:14 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405040135.14688.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It was added in 2.5.66 but PC9800 subarch is still non-buildable.
Also this is one big hack and only half-merged.

 linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/Makefile   |    1 
 linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/ide-proc.c |    1 
 linux-2.6.6-rc3-bk2-bzolnier/include/asm-i386/ide.h |   34 --------
 linux-2.6.6-rc3-bk2-bzolnier/include/linux/ide.h    |    5 -
 linux-2.6.6-rc3-bk2/drivers/ide/legacy/pc9800.c     |   84 --------------------
 5 files changed, 2 insertions(+), 123 deletions(-)

diff -puN drivers/ide/ide-proc.c~ide_pc9800 drivers/ide/ide-proc.c
--- linux-2.6.6-rc3-bk2/drivers/ide/ide-proc.c~ide_pc9800	2004-05-04 01:32:52.138359128 +0200
+++ linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/ide-proc.c	2004-05-04 01:32:52.161355632 +0200
@@ -352,7 +352,6 @@ static int proc_ide_read_imodel
 		case ide_cy82c693:	name = "cy82c693";	break;
 		case ide_4drives:	name = "4drives";	break;
 		case ide_pmac:		name = "mac-io";	break;
-		case ide_pc9800:	name = "pc9800";	break;
 		default:		name = "(unknown)";	break;
 	}
 	len = sprintf(page, "%s\n", name);
diff -puN -L drivers/ide/legacy/pc9800.c drivers/ide/legacy/pc9800.c~ide_pc9800 /dev/null
--- linux-2.6.6-rc3-bk2/drivers/ide/legacy/pc9800.c
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,84 +0,0 @@
-/*
- *  ide_pc9800.c
- *
- *  Copyright (C) 1997-2000  Linux/98 project,
- *			     Kyoto University Microcomputer Club.
- */
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/pc9800.h>
-
-#define PC9800_IDE_BANKSELECT	0x432
-
-#undef PC9800_IDE_DEBUG
-
-static void pc9800_select(ide_drive_t *drive)
-{
-#ifdef PC9800_IDE_DEBUG
-	byte old;
-
-	/* Too noisy: */
-	/* printk(KERN_DEBUG "pc9800_select(%s)\n", drive->name); */
-
-	outb(0x80, PC9800_IDE_BANKSELECT);
-	old = inb(PC9800_IDE_BANKSELECT);
-	if (old != HWIF(drive)->index)
-		printk(KERN_DEBUG "ide-pc9800: switching bank #%d -> #%d\n",
-			old, HWIF(drive)->index);
-#endif
-	outb(HWIF(drive)->index, PC9800_IDE_BANKSELECT);
-}
-
-void __init ide_probe_for_pc9800(void)
-{
-	u8 saved_bank;
-
-	if (!PC9800_9821_P() /* || !PC9821_IDEIF_DOUBLE_P() */)
-		return;
-
-	if (!request_region(PC9800_IDE_BANKSELECT, 1, "ide0/1 bank")) {
-		printk(KERN_ERR
-			"ide: bank select port (%#x) is already occupied!\n",
-			PC9800_IDE_BANKSELECT);
-		return;
-	}
-
-	/* Do actual probing. */
-	if ((saved_bank = inb(PC9800_IDE_BANKSELECT)) == (u8) ~0
-	    || (outb(saved_bank ^ 1, PC9800_IDE_BANKSELECT),
-		/* Next outb is dummy for reading status. */
-		outb(0x80, PC9800_IDE_BANKSELECT),
-		inb(PC9800_IDE_BANKSELECT) != (saved_bank ^ 1))) {
-		printk(KERN_INFO
-			"ide: pc9800 type bank selecting port not found\n");
-		release_region(PC9800_IDE_BANKSELECT, 1);
-		return;
-	}
-
-	/* Restore original value, just in case. */
-	outb(saved_bank, PC9800_IDE_BANKSELECT);
-
-	/* These ports are reseved by IDE I/F.  */
-	if (!request_region(0x430, 1, "ide") ||
-	    !request_region(0x435, 1, "ide")) {
-		printk(KERN_WARNING
-			"ide: IO port 0x430 and 0x435 are reserved for IDE"
-			" the card using these ports may not work\n");
-	}
-
-	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET] == HD_DATA &&
-	    ide_hwifs[1].io_ports[IDE_DATA_OFFSET] == HD_DATA) {
-		ide_hwifs[0].chipset = ide_pc9800;
-		ide_hwifs[0].mate = &ide_hwifs[1];
-		ide_hwifs[0].selectproc = pc9800_select;
-		ide_hwifs[1].chipset = ide_pc9800;
-		ide_hwifs[1].mate = &ide_hwifs[0];
-		ide_hwifs[1].selectproc = pc9800_select;
-	}
-}
diff -puN drivers/ide/Makefile~ide_pc9800 drivers/ide/Makefile
--- linux-2.6.6-rc3-bk2/drivers/ide/Makefile~ide_pc9800	2004-05-04 01:32:52.148357608 +0200
+++ linux-2.6.6-rc3-bk2-bzolnier/drivers/ide/Makefile	2004-05-04 01:32:52.162355480 +0200
@@ -26,7 +26,6 @@ ide-core-$(CONFIG_PROC_FS)		+= ide-proc.
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 
 # built-in only drivers from legacy/
-ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= legacy/pc9800.o
 ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= legacy/buddha.o
 ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+= legacy/falconide.o
 ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= legacy/gayle.o
diff -puN include/asm-i386/ide.h~ide_pc9800 include/asm-i386/ide.h
--- linux-2.6.6-rc3-bk2/include/asm-i386/ide.h~ide_pc9800	2004-05-04 01:32:52.152357000 +0200
+++ linux-2.6.6-rc3-bk2-bzolnier/include/asm-i386/ide.h	2004-05-04 01:32:52.164355176 +0200
@@ -26,9 +26,6 @@
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
-#ifdef CONFIG_X86_PC9800
-		case 0x640: return 9;
-#endif
 		case 0x1f0: return 14;
 		case 0x170: return 15;
 		case 0x1e8: return 11;
@@ -43,48 +40,17 @@ static __inline__ int ide_default_irq(un
 static __inline__ unsigned long ide_default_io_base(int index)
 {
 	switch (index) {
-#ifdef CONFIG_X86_PC9800
-		case 0:
-		case 1:	return 0x640;
-#else
 		case 0:	return 0x1f0;
 		case 1:	return 0x170;
 		case 2: return 0x1e8;
 		case 3: return 0x168;
 		case 4: return 0x1e0;
 		case 5: return 0x160;
-#endif
 		default:
 			return 0;
 	}
 }
 
-#ifdef CONFIG_X86_PC9800
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-	 unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	unsigned long increment = data_port == 0x640 ? 2 : 1;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += increment;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else if (data_port == 0x640) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = 0x74c;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-#endif
-
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ide_init_default_irq(base)	(0)
 #else
diff -puN include/linux/ide.h~ide_pc9800 include/linux/ide.h
--- linux-2.6.6-rc3-bk2/include/linux/ide.h~ide_pc9800	2004-05-04 01:32:52.156356392 +0200
+++ linux-2.6.6-rc3-bk2-bzolnier/include/linux/ide.h	2004-05-04 01:32:52.166354872 +0200
@@ -255,7 +255,7 @@ typedef enum {	ide_unknown,	ide_generic,
 		ide_pdc4030,	ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
-		ide_pc9800,	ide_forced
+		ide_forced
 } hwif_chipset_t;
 
 /*
@@ -308,8 +308,7 @@ static inline void ide_std_init_ports(hw
 /*
  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
  *
- * arm26, arm, h8300, m68k, m68knommu (broken) and i386-pc9800 (broken)
- * still have their own versions.
+ * arm{26}, h8300, m68k and m68knommu (broken) still have their own versions.
  */
 #if !defined(CONFIG_ARM) && !defined(CONFIG_H8300) && !defined(CONFIG_M68K)
 static inline void ide_init_hwif_ports(hw_regs_t *hw,

_

