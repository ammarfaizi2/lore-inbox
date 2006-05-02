Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWEBWPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWEBWPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWEBWPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:15:55 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:57038 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S965017AbWEBWPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:15:54 -0400
Message-ID: <4457D9D2.30206@ru.mvista.com>
Date: Wed, 03 May 2006 02:14:42 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH][RFT] Fix HPT3xx hotswap support
References: <444B3BDE.1030106@ru.mvista.com>
In-Reply-To: <444B3BDE.1030106@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090500070209040901080500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500070209040901080500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Fix the broken hotswap code: on HPT37x it caused RESET- to glitch  when
tristating the bus (the MISC control 3/6 and soft control 2 need to be
written to in the certain order), and for HPT36x the obsolete
HDIO_TRISTATE_HWIF ioctl() handler was called instead which treated the state
argument wrong. Also, get rid of the soft control reg. 1 wtite to enable IDE
interrupt -- this is done in init_hpt37x() already...
    Have been tested on HPT370 and 371N. Should apply on top of the HPT37x
timing table fix.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------090500070209040901080500
Content-Type: text/plain;
 name="HPT3xx-fix-hotswap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-fix-hotswap.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -71,6 +71,8 @@
  *   needed and had many modes over- and  underclocked,  HPT372 33 MHz table was
  *   for 66 MHz and 50 MHz table missed UltraDMA mode 6, HPT374 33 MHz table was
  *   really for 50 MHz; switch to using HPT372 tables for HPT374...
+ * - fix the hotswap code:  it caused RESET- to glitch when tristating the bus,
+ *   and for HPT36x the obsolete HDIO_TRISTATE_HWIF handler was called instead
  *		<source@mvista.com>
  *
  */
@@ -954,101 +956,68 @@ static void hpt3xxn_rw_disk(ide_drive_t 
 	hpt3xxn_set_clock(hwif, wantclock);
 }
 
-/*
- * Since SUN Cobalt is attempting to do this operation, I should disclose
- * this has been a long time ago Thu Jul 27 16:40:57 2000 was the patch date
- * HOTSWAP ATA Infrastructure.
- */
-
-static void hpt3xx_reset (ide_drive_t *drive)
-{
-}
-
-static int hpt3xx_tristate (ide_drive_t * drive, int state)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	u8 reg59h = 0, reset	= (hwif->channel) ? 0x80 : 0x40;
-	u8 regXXh = 0, state_reg= (hwif->channel) ? 0x57 : 0x53;
-
-	pci_read_config_byte(dev, 0x59, &reg59h);
-	pci_read_config_byte(dev, state_reg, &regXXh);
-
-	if (state) {
-		(void) ide_do_reset(drive);
-		pci_write_config_byte(dev, state_reg, regXXh|0x80);
-		pci_write_config_byte(dev, 0x59, reg59h|reset);
-	} else {
-		pci_write_config_byte(dev, 0x59, reg59h & ~(reset));
-		pci_write_config_byte(dev, state_reg, regXXh & ~(0x80));
-		(void) ide_do_reset(drive);
-	}
-	return 0;
-}
-
 /* 
- * set/get power state for a drive.
- * turning the power off does the following things:
- *   1) soft-reset the drive
- *   2) tri-states the ide bus
+ * Set/get power state for a drive.
  *
- * when we turn things back on, we need to re-initialize things.
+ * When we turn the power back on, we need to re-initialize things.
  */
 #define TRISTATE_BIT  0x8000
-static int hpt370_busproc(ide_drive_t * drive, int state)
+
+static int hpt3xx_busproc(ide_drive_t *drive, int state)
 {
 	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 tristate = 0, resetmask = 0, bus_reg = 0;
-	u16 tri_reg;
+	u8  tristate, resetmask, bus_reg = 0;
+	u16 tri_reg = 0;
 
 	hwif->bus_state = state;
 
 	if (hwif->channel) { 
 		/* secondary channel */
-		tristate = 0x56;
-		resetmask = 0x80; 
+		tristate  = 0x56;
+		resetmask = 0x80;
 	} else { 
 		/* primary channel */
-		tristate = 0x52;
+		tristate  = 0x52;
 		resetmask = 0x40;
 	}
 
-	/* grab status */
+	/* Grab the status. */
 	pci_read_config_word(dev, tristate, &tri_reg);
 	pci_read_config_byte(dev, 0x59, &bus_reg);
 
-	/* set the state. we don't set it if we don't need to do so.
-	 * make sure that the drive knows that it has failed if it's off */
+	/*
+	 * Set the state. We don't set it if we don't need to do so.
+	 * Make sure that the drive knows that it has failed if it's off.
+	 */
 	switch (state) {
 	case BUSSTATE_ON:
-		hwif->drives[0].failures = 0;
-		hwif->drives[1].failures = 0;
-		if ((bus_reg & resetmask) == 0)
+		if (!(bus_reg & resetmask))
 			return 0;
-		tri_reg &= ~TRISTATE_BIT;
-		bus_reg &= ~resetmask;
-		break;
+		hwif->drives[0].failures = hwif->drives[1].failures = 0;
+
+		pci_write_config_byte(dev, 0x59, bus_reg & ~resetmask);
+		pci_write_config_word(dev, tristate, tri_reg & ~TRISTATE_BIT);
+		return 0;
 	case BUSSTATE_OFF:
-		hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
-		hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
-		if ((tri_reg & TRISTATE_BIT) == 0 && (bus_reg & resetmask))
+		if ((bus_reg & resetmask) && !(tri_reg & TRISTATE_BIT))
 			return 0;
 		tri_reg &= ~TRISTATE_BIT;
-		bus_reg |= resetmask;
 		break;
 	case BUSSTATE_TRISTATE:
-		hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
-		hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
-		if ((tri_reg & TRISTATE_BIT) && (bus_reg & resetmask))
+		if ((bus_reg & resetmask) &&  (tri_reg & TRISTATE_BIT))
 			return 0;
 		tri_reg |= TRISTATE_BIT;
-		bus_reg |= resetmask;
 		break;
+	default:
+		return -EINVAL;
 	}
-	pci_write_config_byte(dev, 0x59, bus_reg);
-	pci_write_config_word(dev, tristate, tri_reg);
 
+	hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
+	hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
+
+	pci_write_config_word(dev, tristate, tri_reg);
+	pci_write_config_byte(dev, 0x59, bus_reg | resetmask);
 	return 0;
 }
 
@@ -1363,23 +1332,11 @@ static void __devinit init_hwif_hpt366(i
 	if (serialize && hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
 
-	if (info->revision >= 3) {
-		u8 reg5ah = 0;
-			pci_write_config_byte(dev, 0x5a, reg5ah & ~0x10);
-		/*
-		 * set up ioctl for power status.
-		 * note: power affects both
-		 * drives on each channel
-		 */
-		hwif->resetproc	= &hpt3xx_reset;
-		hwif->busproc	= &hpt370_busproc;
-	} else if (info->revision >= 2) {
-		hwif->resetproc	= &hpt3xx_reset;
-		hwif->busproc	= &hpt3xx_tristate;
-	} else {
-		hwif->resetproc = &hpt3xx_reset;
-		hwif->busproc   = &hpt3xx_tristate;
-	}
+	/*
+	 * Set up ioctl for power status.
+	 * NOTE:  power affects both drives on each channel.
+	 */
+	hwif->busproc = &hpt3xx_busproc;
 
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = 1;




--------------090500070209040901080500--
