Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTJaSsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 13:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTJaSsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 13:48:18 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14047 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263518AbTJaSsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 13:48:01 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Martin Maney <maney@two14.net>
Subject: [PATCH] Re: 2.4.22-rc2 ext2 filesystem corruption
Date: Fri, 31 Oct 2003 19:52:21 +0100
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200310311941.31930.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/1164.html
  for people seeing this subject for the first time ]

Hi,

Can you try booting with "hdX=autotune" (hdX==your drive) kernel parameter?
Promise driver is not autotuning PIO modes if (U)DMA modes are going
to be used, but correct PIO timings are needed even if (U)DMA is used.

The next thing to try is the attached patch (against 2.4.23-pre9), which
sanitizes 66MHz clock usage -> now 66MHz clock is "enabled" before starting
UDMA3/4/5 transfer and "disabled" after finishing such transfer.
Therefore correct 33MHz timings will be used for non-UDMA3/4/5 operations.
It also allows using UDMA3/4/5 modes (on a capable drive) even if other
non-UDMA3/4/5 drive is connected to the same channel.

thanks,
--bartlomiej

 drivers/ide/pci/pdc202xx_old.c |   67 ++++++++++++++++++-----------------------
 1 files changed, 31 insertions(+), 36 deletions(-)

diff -puN drivers/ide/pci/pdc202xx_old.c~ide-pdc_old-66MHz_clock-fix drivers/ide/pci/pdc202xx_old.c
--- linux-2.4.23-pre9/drivers/ide/pci/pdc202xx_old.c~ide-pdc_old-66MHz_clock-fix	2003-10-31 18:42:16.816479376 +0100
+++ linux-2.4.23-pre9-root/drivers/ide/pci/pdc202xx_old.c	2003-10-31 19:23:28.015799976 +0100
@@ -359,16 +359,39 @@ static u8 pdc202xx_old_cable_detect (ide
 	return ((u8)(CIS & mask));
 }
 
+/*
+ * Set the control register to use the 66MHz system
+ * clock for UDMA 3/4/5 mode operation when necessary.
+ *
+ * It may also be possible to leave the 66MHz clock on
+ * and readjust the timing parameters.
+ */
+
+static void pdc_old_enable_66MHz_clock(ide_hwif_t *hwif)
+{
+	unsigned long clock_reg = hwif->dma_master + 0x11;
+	u8 clock = hwif->INB(clock_reg);
+
+	hwif->OUTB(clock | (hwif->channel ? 0x08 : 0x02), clock_reg);
+}
+
+static void pdc_old_disable_66MHz_clock(ide_hwif_t *hwif)
+{
+	unsigned long clock_reg = hwif->dma_master + 0x11;
+	u8 clock = hwif->INB(clock_reg);
+
+	hwif->OUTB(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
+}
+
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u32 drive_conf		= 0;
-	u8 mask			= hwif->channel ? 0x08 : 0x02;
 	u8 drive_pci		= 0x60 + (drive->dn << 2);
 	u8 test1 = 0, test2 = 0, speed = -1;
-	u8 AP = 0, CLKSPD = 0, cable = 0;
+	u8 AP = 0, cable = 0;
 
 	u8 ultra_66		= ((id->dma_ultra & 0x0010) ||
 				   (id->dma_ultra & 0x0008)) ? 1 : 0;
@@ -392,21 +415,6 @@ static int config_chipset_for_dma (ide_d
 			BUG();
 	}
 
-	CLKSPD = hwif->INB(hwif->dma_master + 0x11);
-
-	/*
-	 * Set the control register to use the 66Mhz system
-	 * clock for UDMA 3/4 mode operation. If one drive on
-	 * a channel is U66 capable but the other isn't we
-	 * fall back to U33 mode. The BIOS INT 13 hooks turn
-	 * the clock on then off for each read/write issued. I don't
-	 * do that here because it would require modifying the
-	 * kernel, separating the fop routines from the kernel or
-	 * somehow hooking the fops calls. It may also be possible to
-	 * leave the 66Mhz clock on and readjust the timing
-	 * parameters.
-	 */
-
 	if ((ultra_66) && (cable)) {
 #ifdef DEBUG
 		printk(KERN_DEBUG "ULTRA 66/100/133: %s channel of Ultra 66/100/133 "
@@ -414,29 +422,12 @@ static int config_chipset_for_dma (ide_d
 			hwif->channel ? "Secondary" : "Primary");
 		printk(KERN_DEBUG "         Switching to Ultra33 mode.\n");
 #endif /* DEBUG */
-		/* Primary   : zero out second bit */
-		/* Secondary : zero out fourth bit */
-		hwif->OUTB(CLKSPD & ~mask, (hwif->dma_master + 0x11));
 		printk(KERN_WARNING "Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
 		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
-	} else {
-		if (ultra_66) {
-			/*
-			 * check to make sure drive on same channel
-			 * is u66 capable. Ignore empty slots.
-			 */
-			if (hwif->drives[!(drive->dn%2)].present) {
-				if (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0078) {
-					hwif->OUTB(CLKSPD | mask, (hwif->dma_master + 0x11));
-				} else {
-					hwif->OUTB(CLKSPD & ~mask, (hwif->dma_master + 0x11));
-				}
-			} else { /* udma4 drive by itself */
-				hwif->OUTB(CLKSPD | mask, (hwif->dma_master + 0x11));
-			}
-		}
 	}
 
+	pdc_old_disable_66MHz_clock(drive->hwif);
+
 	drive_pci = 0x60 + (drive->dn << 2);
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
 	if ((drive_conf != 0x004ff304) && (drive_conf != 0x004ff3c4))
@@ -532,6 +523,8 @@ static int pdc202xx_quirkproc (ide_drive
 
 static int pdc202xx_old_ide_dma_begin(ide_drive_t *drive)
 {
+	if (drive->current_speed > XFER_UDMA_2)
+		pdc_old_enable_66MHz_clock(drive->hwif);
 	if (drive->addressing == 1) {
 		struct request *rq	= HWGROUP(drive)->rq;
 		ide_hwif_t *hwif	= HWIF(drive);
@@ -565,6 +558,8 @@ static int pdc202xx_old_ide_dma_end(ide_
 		clock = hwif->INB(high_16 + 0x11);
 		hwif->OUTB(clock & ~(hwif->channel ? 0x08:0x02), high_16+0x11);
 	}
+	if (drive->current_speed > XFER_UDMA_2)
+		pdc_old_disable_66MHz_clock(drive->hwif);
 	return __ide_dma_end(drive);
 }
 

_

