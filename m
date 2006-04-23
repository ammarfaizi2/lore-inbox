Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWDWIel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWDWIel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 04:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWDWIek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 04:34:40 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:2754 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1750812AbWDWIek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 04:34:40 -0400
Message-ID: <444B3BDE.1030106@ru.mvista.com>
Date: Sun, 23 Apr 2006 12:33:34 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH][RFT] HPT3xxN clocking fixes
Content-Type: multipart/mixed;
 boundary="------------010002060503000909050401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010002060503000909050401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Fix serious problems with the HPT372N clock turnaround code:
  - wrong I/O port writes in case of the secondary channel;
  - serialize access to the channels;
  - disable turnaround for 66 MHz PCI;
  - read the current clock mode directly from register (which is shared by
    both channels, so caching its value per-channel was sub-optimal).

    Additionally, avoid calibrating PLL twice (for each channel) as the
second try results in a wrong PCI frequency, and thus in the wrong timings.
    Make the driver deal with HPT302N and HPT371N correctly -- the clocking is
the same as for HPT372N, with HPT302N needing the clock turnaround (according
to the HighPoint driver) and HPT371N not needing it.
    Also, while I'm at it, disable UltraATA/133 for HPT372 by default -- 50
MHz DPLL clock don't allow for this speed anyway. And remove the traces of the
former bad patch that wasn't even applicable to this version of driver.
    Have been tested on HPT370/371N, unfortunately I don't have access to
other chips...

MBR, Sergei

PS: The driver has many more issues which I'm dealing with in the rewrite --
the large patch is to follow soon, on top of this quick and dirty one...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------010002060503000909050401
Content-Type: text/plain;
 name="HPT3xxN-clocking-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xxN-clocking-fix.patch"

diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index 940bdd4..ce30eb9 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -4,6 +4,7 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
+ * Portions Copyright (C) 2005-2006	MontaVista Software, Inc.
  *
  * Thanks to HighPoint Technologies for their assistance, and hardware.
  * Special Thanks to Jon Burchmore in SanDiego for the deep pockets, his
@@ -11,9 +12,11 @@
  * development and support.
  *
  *
- * Highpoint have their own driver (source except for the raid part)
- * available from http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz
- * This may be useful to anyone wanting to work on the mainstream hpt IDE.
+ * HighPoint has its own drivers (open source except for the RAID part)
+ * available from http://www.highpoint-tech.com/BIOS%20+%20Driver/.
+ * This  may be useful to anyone wanting to work on this driver, however do not
+ * trust them  too much since the code tends to become less and less meaningful
+ * as the time passes... :-/
  *
  * Note that final HPT370 support was done by force extraction of GPL.
  *
@@ -52,6 +55,18 @@
  * keeping me sane. 
  *		Alan Cox <alan@redhat.com>
  *
+ * - fix  wrong I/O port writes in case of the secondary channel in the clock
+ *   turnaround code, make this code read the current clock mode directly from
+ *   register (which is shared by both channels), serialize channels, and
+ *   disable turnaround for 66 MHz PCI
+ * - avoid calibrating PLL twice (for each channel) as the second try results
+ *   in a wrong PCI frequency, thus in the wrong timings
+ * - add  support for HPT302N and HPT371N clocking (the same as for HPT372N,
+ *   with HPT302N needing the clock turnaround and HPT371N not needing it)
+ * - disable UltraATA/133 for HPT372 by default (50 MHz DPLL clock don't
+ *   allow for this speed anyway)
+ *		<source@mvista.com>
+ *
  */
 
 
@@ -77,8 +92,8 @@
 
 /* various tuning parameters */
 #define HPT_RESET_STATE_ENGINE
-#undef HPT_DELAY_INTERRUPT
-#undef HPT_SERIALIZE_IO
+#undef	HPT_DELAY_INTERRUPT
+#define HPT_SERIALIZE_IO	0
 
 static const char *quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
@@ -440,7 +455,7 @@ static struct chipset_bus_clock_list_ent
 #define HPT374_ALLOW_ATA133_6		0
 #define HPT371_ALLOW_ATA133_6		0
 #define HPT302_ALLOW_ATA133_6		0
-#define HPT372_ALLOW_ATA133_6		1
+#define HPT372_ALLOW_ATA133_6		0
 #define HPT370_ALLOW_ATA100_5		1
 #define HPT366_ALLOW_ATA66_4		1
 #define HPT366_ALLOW_ATA66_3		1
@@ -462,7 +477,9 @@ struct hpt_info
 	int revision;		/* Chipset revision */
 	int flags;		/* Chipset properties */
 #define PLL_MODE	1
-#define IS_372N		2
+#define IS_3x2N 	2
+#define IS_371N 	4
+#define PCI_66MHZ	8
 				/* Speed table */
 	struct chipset_bus_clock_list_entry *speed;
 };
@@ -957,59 +974,56 @@ static int hpt374_ide_dma_end (ide_drive
 }
 
 /**
- *	hpt372n_set_clock	-	perform clock switching dance
- *	@drive: Drive to switch
- *	@mode: Switching mode (0x21 for write, 0x23 otherwise)
+ *	hpt3x2n_set_clock	-	perform clock switching dance
+ *	@hwif: hwif to switch
+ *	@mode: clocking mode (0x21 for write, 0x23 otherwise)
  *
- *	Switch the DPLL clock on the HPT372N devices. This is a
+ *	Switch the DPLL clock on the HPT3x2N devices. This is a
  *	right mess.
  */
  
-static void hpt372n_set_clock(ide_drive_t *drive, int mode)
+static inline void hpt3x2n_set_clock(ide_hwif_t *hwif, u8 mode)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	
-	/* FIXME: should we check for DMA active and BUG() */
+	u8 scr2 = hwif->INB(hwif->dma_master + 0x7b);
+
+	if ((scr2 & 0x7f) == mode)
+		return;
+
 	/* Tristate the bus */
-	outb(0x80, hwif->dma_base+0x73);
-	outb(0x80, hwif->dma_base+0x77);
-	
+	hwif->OUTB(0x80, hwif->dma_master + 0x73);
+	hwif->OUTB(0x80, hwif->dma_master + 0x77);
+
 	/* Switch clock and reset channels */
-	outb(mode, hwif->dma_base+0x7B);
-	outb(0xC0, hwif->dma_base+0x79);
-	
+	hwif->OUTB(mode, hwif->dma_master + 0x7b);
+	hwif->OUTB(0xc0, hwif->dma_master + 0x79);
+
 	/* Reset state machines */
-	outb(0x37, hwif->dma_base+0x70);
-	outb(0x37, hwif->dma_base+0x74);
-	
+	hwif->OUTB(0x37, hwif->dma_master + 0x70);
+	hwif->OUTB(0x37, hwif->dma_master + 0x74);
+
 	/* Complete reset */
-	outb(0x00, hwif->dma_base+0x79);
-	
+	hwif->OUTB(0x00, hwif->dma_master + 0x79);
+
 	/* Reconnect channels to bus */
-	outb(0x00, hwif->dma_base+0x73);
-	outb(0x00, hwif->dma_base+0x77);
+	hwif->OUTB(0x00, hwif->dma_master + 0x73);
+	hwif->OUTB(0x00, hwif->dma_master + 0x77);
 }
 
 /**
- *	hpt372n_rw_disk		-	prepare for I/O
+ *	hpt3x2n_rw_disk		-	prepare for I/O
  *	@drive: drive for command
  *	@rq: block request structure
  *
- *	This is called when a disk I/O is issued to the 372N.
+ *	This is called when a disk I/O is issued to HPT302N/372N.
  *	We need it because of the clock switching.
  */
 
-static void hpt372n_rw_disk(ide_drive_t *drive, struct request *rq)
+static void hpt3x2n_rw_disk(ide_drive_t *drive, struct request *rq)
 {
-	ide_hwif_t *hwif = drive->hwif;
-	int wantclock;
-
-	wantclock = rq_data_dir(rq) ? 0x23 : 0x21;
+	ide_hwif_t *hwif	= HWIF(drive);
+	u8 wantclock		= rq_data_dir(rq) ? 0x23 : 0x21;
 
-	if (hwif->config_data != wantclock) {
-		hpt372n_set_clock(drive, wantclock);
-		hwif->config_data = wantclock;
-	}
+	hpt3x2n_set_clock(hwif, wantclock);
 }
 
 /*
@@ -1162,17 +1176,11 @@ static void __devinit hpt37x_clocking(id
 	freq &= 0x1FF;
 	
 	/*
-	 * The 372N uses different PCI clock information and has
-	 * some other complications
-	 *	On PCI33 timing we must clock switch
-	 *	On PCI66 timing we must NOT use the PCI clock
-	 *
-	 * Currently we always set up the PLL for the 372N
+	 * HPT3xxN chips use different PCI clock information.
+	 * Currently we always set up the PLL for them.
 	 */
-	 
-	if(info->flags & IS_372N)
-	{
-		printk(KERN_INFO "hpt: HPT372N detected, using 372N timing.\n");
+
+	if (info->flags & (IS_3x2N | IS_371N)) {
 		if(freq < 0x55)
 			pll = F_LOW_PCI_33;
 		else if(freq < 0x70)
@@ -1181,10 +1189,8 @@ static void __devinit hpt37x_clocking(id
 			pll = F_LOW_PCI_50;
 		else
 			pll = F_LOW_PCI_66;
-			
-		printk(KERN_INFO "FREQ: %d PLL: %d\n", freq, pll);
-			
-		/* We always use the pll not the PCI clock on 372N */
+
+		printk(KERN_INFO "HPT3xxN detected, FREQ: %d, PLL: %d\n", freq, pll);
 	}
 	else
 	{
@@ -1232,7 +1238,10 @@ static void __devinit hpt37x_clocking(id
 			printk(KERN_DEBUG "HPT37X: using 66MHz PCI clock\n");
 		}
 	}
-	
+
+	if (pll == F_LOW_PCI_66)
+		info->flags |= PCI_66MHZ;
+
 	/*
 	 * only try the pll if we don't have a table for the clock
 	 * speed that we're running at. NOTE: the internal PLL will
@@ -1288,10 +1297,6 @@ static void __devinit hpt37x_clocking(id
 				goto init_hpt37X_done;
 			}
 		}
-		if (!pci_get_drvdata(dev)) {
-			printk("No Clock Stabilization!!!\n");
-			return;
-		}
 pll_recal:
 		if (adjust & 1)
 			pll -= (adjust >> 1);
@@ -1301,8 +1306,8 @@ pll_recal:
 
 init_hpt37X_done:
 	if (!info->speed)
-		printk(KERN_ERR "HPT37X%s: unknown bus timing [%d %d].\n",
-			(info->flags & IS_372N)?"N":"", pll, freq);
+		printk(KERN_ERR "HPT37x%s: unknown bus timing [%d %d].\n",
+		       (info->flags & (IS_3x2N | IS_371N)) ? "N" : "", pll, freq);
 	/* reset state engine */
 	pci_write_config_byte(dev, 0x50, 0x37); 
 	pci_write_config_byte(dev, 0x54, 0x37); 
@@ -1368,6 +1373,7 @@ static void __devinit init_hwif_hpt366(i
 	struct pci_dev *dev		= hwif->pci_dev;
 	struct hpt_info *info		= ide_get_hwifdata(hwif);
 	u8 ata66 = 0, regmask		= (hwif->channel) ? 0x01 : 0x02;
+	int serialize			= HPT_SERIALIZE_IO;
 	
 	hwif->tuneproc			= &hpt3xx_tune_drive;
 	hwif->speedproc			= &hpt3xx_tune_chipset;
@@ -1375,8 +1381,20 @@ static void __devinit init_hwif_hpt366(i
 	hwif->intrproc			= &hpt3xx_intrproc;
 	hwif->maskproc			= &hpt3xx_maskproc;
 	
-	if(info->flags & IS_372N)
-		hwif->rw_disk = &hpt372n_rw_disk;
+	/*
+	 * HPT372N/302N chips have some complications:
+	 *
+	 * - on 33 MHz PCI we must clock switch
+	 * - on 66 MHz PCI we must NOT use the PCI clock
+	 */
+	if ((info->flags & (IS_3x2N | PCI_66MHZ)) == IS_3x2N) {
+		/*
+		 * Clock is shared between the channels,
+		 * so we'll have to serialize them... :-(
+		 */
+		serialize = 1;
+		hwif->rw_disk = &hpt3x2n_rw_disk;
+	}
 
 	/*
 	 * The HPT37x uses the CBLID pins as outputs for MA15/MA16
@@ -1419,11 +1437,9 @@ static void __devinit init_hwif_hpt366(i
 		PCI_FUNC(hwif->pci_dev->devfn));
 #endif /* DEBUG */
 
-#ifdef HPT_SERIALIZE_IO
-	/* serialize access to this device */
-	if (hwif->mate)
+	/* Serialize access to this device */
+	if (serialize && hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
-#endif
 
 	if (info->revision >= 3) {
 		u8 reg5ah = 0;
@@ -1491,7 +1507,7 @@ static void __devinit init_dma_hpt366(id
 		return;
 		
 	if(info->speed == NULL) {
-		printk(KERN_WARNING "hpt: no known IDE timings, disabling DMA.\n");
+		printk(KERN_WARNING "hpt366: no known IDE timings, disabling DMA.\n");
 		return;
 	}
 
@@ -1520,9 +1536,10 @@ static void __devinit init_dma_hpt366(id
 
 static void __devinit init_iops_hpt366(ide_hwif_t *hwif)
 {
-	struct hpt_info *info = kzalloc(sizeof(struct hpt_info), GFP_KERNEL);
-	unsigned long dmabase = pci_resource_start(hwif->pci_dev, 4);
-	u8 did, rid;
+	struct hpt_info *info	= kzalloc(sizeof(struct hpt_info), GFP_KERNEL);
+	struct pci_dev  *dev	= hwif->pci_dev;
+	u16 did			= dev->device;
+	u8  rid			= 0;
 
 	if(info == NULL) {
 		printk(KERN_WARNING "hpt366: out of memory.\n");
@@ -1530,15 +1547,23 @@ static void __devinit init_iops_hpt366(i
 	}
 	ide_set_hwifdata(hwif, info);
 
-	if(dmabase) {
-		did = inb(dmabase + 0x22);
-		rid = inb(dmabase + 0x28);
-
-		if((did == 4 && rid == 6) || (did == 5 && rid > 1))
-			info->flags |= IS_372N;
+	/* Avoid doing the same thing twice. */
+	if (hwif->channel && hwif->mate) {
+		memcpy(info, ide_get_hwifdata(hwif->mate), sizeof(struct hpt_info));
+		return;
 	}
 
-	info->revision = hpt_revision(hwif->pci_dev);
+	pci_read_config_byte(dev, PCI_CLASS_REVISION, &rid);
+
+	if (( did == PCI_DEVICE_ID_TTI_HPT366  && rid == 6) ||
+	    ((did == PCI_DEVICE_ID_TTI_HPT372  ||
+	      did == PCI_DEVICE_ID_TTI_HPT302) && rid >  1) ||
+	      did == PCI_DEVICE_ID_TTI_HPT372N)
+		info->flags |= IS_3x2N;
+	else if (did == PCI_DEVICE_ID_TTI_HPT371 && rid > 1)
+		info->flags |= IS_371N;
+
+	info->revision = hpt_revision(dev);
 
 	if (info->revision >= 3)
 		hpt37x_clocking(hwif);





--------------010002060503000909050401--
