Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVBDHeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVBDHeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVBDHd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:33:57 -0500
Received: from [211.58.254.17] ([211.58.254.17]:42153 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263299AbVBDHNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:24 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 09/14] ide_pci: Merges pdc202xx_new.h into pdc202xx_new.c
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071318.E58DB1326FA@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:18 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


09_ide_pci_pdc202xx_new_merge.patch

	Merges ide/pci/pdc202xx_new.h into pdc202xx_new.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/pdc202xx_new.c	2005-02-04 16:07:36.612406299 +0900
+++ linux-idepci-export/drivers/ide/pci/pdc202xx_new.c	2005-02-04 16:08:25.989364519 +0900
@@ -37,10 +37,46 @@
 #include <asm/pci-bridge.h>
 #endif
 
-#include "pdc202xx_new.h"
-
 #define PDC202_DEBUG_CABLE	0
 
+const static char *pdc_quirk_drives[] = {
+	"QUANTUM FIREBALLlct08 08",
+	"QUANTUM FIREBALLP KA6.4",
+	"QUANTUM FIREBALLP KA9.1",
+	"QUANTUM FIREBALLP LM20.4",
+	"QUANTUM FIREBALLP KX13.6",
+	"QUANTUM FIREBALLP KX20.5",
+	"QUANTUM FIREBALLP KX27.3",
+	"QUANTUM FIREBALLP LM20.5",
+	NULL
+};
+
+#define set_2regs(a, b)					\
+	do {						\
+		hwif->OUTB((a + adj), indexreg);	\
+		hwif->OUTB(b, datareg);			\
+	} while(0)
+
+#define set_ultra(a, b, c)				\
+	do {						\
+		set_2regs(0x10,(a));			\
+		set_2regs(0x11,(b));			\
+		set_2regs(0x12,(c));			\
+	} while(0)
+
+#define set_ata2(a, b)					\
+	do {						\
+		set_2regs(0x0e,(a));			\
+		set_2regs(0x0f,(b));			\
+	} while(0)
+
+#define set_pio(a, b, c)				\
+	do { 						\
+		set_2regs(0x0c,(a));			\
+		set_2regs(0x0d,(b));			\
+		set_2regs(0x13,(c));			\
+	} while(0)
+
 static u8 pdcnew_ratemask (ide_drive_t *drive)
 {
 	u8 mode;
@@ -360,6 +396,72 @@ static int __devinit init_setup_pdc20276
 	return ide_setup_pci_device(dev, d);
 }
 
+static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "PDC20268",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 1 */
+		.name		= "PDC20269",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 2 */
+		.name		= "PDC20270",
+		.init_setup	= init_setup_pdc20270,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+	},{	/* 3 */
+		.name		= "PDC20271",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 4 */
+		.name		= "PDC20275",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{	/* 5 */
+		.name		= "PDC20276",
+		.init_setup	= init_setup_pdc20276,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+#ifndef CONFIG_PDC202XX_FORCE
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+#endif
+		.bootable	= OFF_BOARD,
+	},{	/* 6 */
+		.name		= "PDC20277",
+		.init_setup	= init_setup_pdcnew,
+		.init_chipset	= init_chipset_pdcnew,
+		.init_hwif	= init_hwif_pdc202new,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	}
+};
+
 /**
  *	pdc202new_init_one	-	called when a pdc202xx is found
  *	@dev: the pdc202new device
Index: linux-idepci-export/drivers/ide/pci/pdc202xx_new.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/pdc202xx_new.h	2005-02-04 16:07:36.612406299 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,118 +0,0 @@
-#ifndef PDC202XX_H
-#define PDC202XX_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-const static char *pdc_quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP KA9.1",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP KX13.6",
-	"QUANTUM FIREBALLP KX20.5",
-	"QUANTUM FIREBALLP KX27.3",
-	"QUANTUM FIREBALLP LM20.5",
-	NULL
-};
-
-#define set_2regs(a, b)					\
-	do {						\
-		hwif->OUTB((a + adj), indexreg);	\
-		hwif->OUTB(b, datareg);			\
-	} while(0)
-
-#define set_ultra(a, b, c)				\
-	do {						\
-		set_2regs(0x10,(a));			\
-		set_2regs(0x11,(b));			\
-		set_2regs(0x12,(c));			\
-	} while(0)
-
-#define set_ata2(a, b)					\
-	do {						\
-		set_2regs(0x0e,(a));			\
-		set_2regs(0x0f,(b));			\
-	} while(0)
-
-#define set_pio(a, b, c)				\
-	do { 						\
-		set_2regs(0x0c,(a));			\
-		set_2regs(0x0d,(b));			\
-		set_2regs(0x13,(c));			\
-	} while(0)
-
-static int init_setup_pdcnew(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_pdc20270(struct pci_dev *, ide_pci_device_t *);
-static int init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d);
-static unsigned int init_chipset_pdcnew(struct pci_dev *, const char *);
-static void init_hwif_pdc202new(ide_hwif_t *);
-
-static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "PDC20268",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 1 */
-		.name		= "PDC20269",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 2 */
-		.name		= "PDC20270",
-		.init_setup	= init_setup_pdc20270,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-	},{	/* 3 */
-		.name		= "PDC20271",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 4 */
-		.name		= "PDC20275",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 5 */
-		.name		= "PDC20276",
-		.init_setup	= init_setup_pdc20276,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
-		.bootable	= OFF_BOARD,
-	},{	/* 6 */
-		.name		= "PDC20277",
-		.init_setup	= init_setup_pdcnew,
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	}
-};
-
-#endif /* PDC202XX_H */
