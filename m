Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbUDXU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUDXU3y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUDXU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 16:29:54 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2477 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262134AbUDXU3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 16:29:48 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: PROBLEM: Oops when using both channels of the PDC20262
Date: Sat, 24 Apr 2004 22:30:20 +0200
User-Agent: KMail/1.5.3
References: <40898ADA.8020708@hasw.net> <200404242242.36154.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404242242.36154.vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Sebastian Witt <se.witt@gmx.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, frankt@promise.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404242230.20985.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 of April 2004 21:42, Denis Vlasenko wrote:
> On Saturday 24 April 2004 00:30, Sebastian Witt wrote:
> > Hello,
> >
> > I'm getting some Oopses with kernel 2.6.5 when there is high load on
> > both channels of a Promise PDC20262 (Ultra66) card on a SMP machine
> > (Tyan S1834, Via Apollo Pro chipset).
>
> I recall similar report. Reporter found that there is a #define
> in the source which can be enabled to make driver serialize access
> to channels. That 'fixed' (most probably worked around, though)
> the problem.

Denis, you are talking about hpt366.c not pdc202xx_old.c. ;-)

> I can't say whether it was a hardware or driver problem,
> I didn't look into it.
>
> > There are no problems when I use 2.6.1, but I have this problem
> > since 2.6.2.
> > It only occurs when I use the PDC20262, not when using the onboard
> > IDE-controller.

There were some change in pdc202xx_old.c driver in 2.6.2.
Please revert this patch and report if it helps.

diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	Tue Feb  3 19:45:42 2004
+++ b/drivers/ide/pci/pdc202xx_old.c	Tue Feb  3 19:45:42 2004
@@ -361,16 +361,38 @@
 	return ((u8)(CIS & mask));
 }
 
+/*
+ * Set the control register to use the 66MHz system
+ * clock for UDMA 3/4/5 mode operation when necessary.
+ *
+ * It may also be possible to leave the 66MHz clock on
+ * and readjust the timing parameters.
+ */
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
@@ -394,21 +416,6 @@
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
@@ -416,29 +423,12 @@
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
-			 * is u66 capable
-			 */
-			if (hwif->drives[!(drive->dn%2)].id) {
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
@@ -536,6 +526,8 @@
 
 static int pdc202xx_old_ide_dma_begin(ide_drive_t *drive)
 {
+	if (drive->current_speed > XFER_UDMA_2)
+		pdc_old_enable_66MHz_clock(drive->hwif);
 	if (drive->addressing == 1) {
 		struct request *rq	= HWGROUP(drive)->rq;
 		ide_hwif_t *hwif	= HWIF(drive);
@@ -569,6 +561,8 @@
 		clock = hwif->INB(high_16 + 0x11);
 		hwif->OUTB(clock & ~(hwif->channel ? 0x08:0x02), high_16+0x11);
 	}
+	if (drive->current_speed > XFER_UDMA_2)
+		pdc_old_disable_66MHz_clock(drive->hwif);
 	return __ide_dma_end(drive);
 }
 
@@ -757,10 +751,7 @@
 
 	hwif->speedproc = &pdc202xx_tune_chipset;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-		return;
-	}
+	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
 	hwif->ultra_mask = 0x3f;
 	hwif->mwdma_mask = 0x07;


> > It is reproduceable after a few seconds when I use 'dd if=/dev/hde
> > of=/dev/hdh bs=512'.
> > Using of=/dev/null also works, but it takes longer.
> >
> > Mostly it reports smp_apic_timer_interrupt+1c/140, but the last time
> > I tried it, it also reports <__mask_IO_APIC_irq+40/e0>.
> >
> > I've attached the logs and the ksymoops trace.

Strange, it looks like IO-APIC problem.
Have you tried booting with "noapic" kernel parameter?

Regards,
Bartlomiej

