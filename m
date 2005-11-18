Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVKRXnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVKRXnB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKRXnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:43:01 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:44245 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S1751197AbVKRXm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:42:59 -0500
Date: Sat, 19 Nov 2005 00:21:36 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] ide update
Message-ID: <Pine.GSO.4.62.0511190008170.20091@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Some fixes, few obvious cleanups
and slight rework of via82cxxx driver.


Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to obtain following changes:

Alexey Dobriyan:
   alim15x3: use KERN_WARNING

Amit Gud:
   cs5520: fix return value of cs5520_init_one()

Daniel Drake:
   via82cxxx IDE: remove /proc/via entry
   via82cxxx IDE: support multiple controllers

Hanna Linder:
   alim15x3: replace pci_find_device() with pci_dev_present()

James Bottomley:
   ide: fix ide_toggle_bounce() to not try to bounce if we have an IOMMU

Jeff Garzik:
   siimage: docs urls

Laurent Riffard:
   ide: remove ide_driver_t.owner field

Ralf Baechle:
   ide: make comment match reality

Thibaut VARENE:
   pmac IDE: don't release empty interfaces
   aec62xxx: remove all dead (#if0'd) code

  drivers/ide/ide-cd.c        |    2
  drivers/ide/ide-disk.c      |    2
  drivers/ide/ide-floppy.c    |    2
  drivers/ide/ide-lib.c       |    8
  drivers/ide/ide-tape.c      |    2
  drivers/ide/pci/aec62xx.c   |   47 -----
  drivers/ide/pci/alim15x3.c  |    9 -
  drivers/ide/pci/cs5520.c    |    5
  drivers/ide/pci/siimage.c   |    8
  drivers/ide/pci/via82cxxx.c |  377 +++++++++++++-------------------------------
  drivers/ide/ppc/pmac.c      |   14 -
  drivers/ide/setup-pci.c     |    2
  drivers/scsi/ide-scsi.c     |    2
  include/linux/ide.h         |    4
  14 files changed, 143 insertions(+), 341 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3328,8 +3328,8 @@ static ide_proc_entry_t idecd_proc[] = {
  #endif

  static ide_driver_t ide_cdrom_driver = {
-	.owner			= THIS_MODULE,
  	.gen_driver = {
+		.owner		= THIS_MODULE,
  		.name		= "ide-cdrom",
  		.bus		= &ide_bus_type,
  		.probe		= ide_cd_probe,
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1089,8 +1089,8 @@ static void ide_device_shutdown(struct d
  }

  static ide_driver_t idedisk_driver = {
-	.owner			= THIS_MODULE,
  	.gen_driver = {
+		.owner		= THIS_MODULE,
  		.name		= "ide-disk",
  		.bus		= &ide_bus_type,
  		.probe		= ide_disk_probe,
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1925,8 +1925,8 @@ static ide_proc_entry_t idefloppy_proc[]
  static int ide_floppy_probe(struct device *);

  static ide_driver_t idefloppy_driver = {
-	.owner			= THIS_MODULE,
  	.gen_driver = {
+		.owner		= THIS_MODULE,
  		.name		= "ide-floppy",
  		.bus		= &ide_bus_type,
  		.probe		= ide_floppy_probe,
diff --git a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -410,10 +410,10 @@ void ide_toggle_bounce(ide_drive_t *driv
  {
  	u64 addr = BLK_BOUNCE_HIGH;	/* dma64_addr_t */

-	if (on && drive->media == ide_disk) {
-		if (!PCI_DMA_BUS_IS_PHYS)
-			addr = BLK_BOUNCE_ANY;
-		else if (HWIF(drive)->pci_dev)
+	if (!PCI_DMA_BUS_IS_PHYS) {
+		addr = BLK_BOUNCE_ANY;
+	} else if (on && drive->media == ide_disk) {
+		if (HWIF(drive)->pci_dev)
  			addr = HWIF(drive)->pci_dev->dma_mask;
  	}

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4748,8 +4748,8 @@ static ide_proc_entry_t idetape_proc[] =
  static int ide_tape_probe(struct device *);

  static ide_driver_t idetape_driver = {
-	.owner			= THIS_MODULE,
  	.gen_driver = {
+		.owner		= THIS_MODULE,
  		.name		= "ide-tape",
  		.bus		= &ide_bus_type,
  		.probe		= ide_tape_probe,
diff --git a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -65,23 +65,6 @@ static struct chipset_bus_clock_list_ent
  #define BUSCLOCK(D)	\
  	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))

-#if 0
-		if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
-			(void) pci_read_config_byte(dev, 0x54, &art);
-			p += sprintf(p, "DMA Mode:       %s(%s)",
-				(c0&0x20)?((art&0x03)?"UDMA":" DMA"):" PIO",
-				(art&0x02)?"2":(art&0x01)?"1":"0");
-			p += sprintf(p, "          %s(%s)",
-				(c0&0x40)?((art&0x0c)?"UDMA":" DMA"):" PIO",
-				(art&0x08)?"2":(art&0x04)?"1":"0");
-			p += sprintf(p, "         %s(%s)",
-				(c1&0x20)?((art&0x30)?"UDMA":" DMA"):" PIO",
-				(art&0x20)?"2":(art&0x10)?"1":"0");
-			p += sprintf(p, "           %s(%s)\n",
-				(c1&0x40)?((art&0xc0)?"UDMA":" DMA"):" PIO",
-				(art&0x80)?"2":(art&0x40)?"1":"0");
-		} else {
-#endif

  /*
   * TO DO: active tuning and correction of cards without a bios.
@@ -112,13 +95,9 @@ static u8 aec62xx_ratemask (ide_drive_t
  	switch(hwif->pci_dev->device) {
  		case PCI_DEVICE_ID_ARTOP_ATP865:
  		case PCI_DEVICE_ID_ARTOP_ATP865R:
-#if 0
-			mode = (hwif->INB(hwif->dma_master) & 0x10) ? 4 : 3;
-#else
  			mode = (hwif->INB(((hwif->channel) ?
  					hwif->mate->dma_status :
  					hwif->dma_status)) & 0x10) ? 4 : 3;
-#endif
  			break;
  		case PCI_DEVICE_ID_ARTOP_ATP860:
  		case PCI_DEVICE_ID_ARTOP_ATP860R:
@@ -263,35 +242,9 @@ static int aec62xx_irq_timeout (ide_driv
  		case PCI_DEVICE_ID_ARTOP_ATP865:
  		case PCI_DEVICE_ID_ARTOP_ATP865R:
  			printk(" AEC62XX time out ");
-#if 0
-			{
-				int i = 0;
-				u8 reg49h = 0;
-				pci_read_config_byte(HWIF(drive)->pci_dev, 0x49, &reg49h);
-				for (i=0;i<256;i++)
-					pci_write_config_byte(HWIF(drive)->pci_dev, 0x49, reg49h|0x10);
-				pci_write_config_byte(HWIF(drive)->pci_dev, 0x49, reg49h & ~0x10);
-			}
-			return 0;
-#endif
  		default:
  			break;
  	}
-#if 0
-	{
-		ide_hwif_t *hwif	= HWIF(drive);
-		struct pci_dev *dev	= hwif->pci_dev;
-		u8 tmp1 = 0, tmp2 = 0, mode6 = 0;
-
-		pci_read_config_byte(dev, 0x44, &tmp1);
-		pci_read_config_byte(dev, 0x45, &tmp2);
-		printk(" AEC6280 r44=%x r45=%x ",tmp1,tmp2);
-		mode6 = HWIF(drive)->INB(((hwif->channel) ?
-					   hwif->mate->dma_status :
-					   hwif->dma_status));
-		printk(" AEC6280 133=%x ", (mode6 & 0x10));
-	}
-#endif
  	return 0;
  }

diff --git a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -876,10 +876,15 @@ static ide_pci_device_t ali15x3_chipset

  static int __devinit alim15x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
  {
+	static struct pci_device_id ati_rs100[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100) },
+		{ },
+	};
+
  	ide_pci_device_t *d = &ali15x3_chipset;

-	if(pci_find_device(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100, NULL))
-		printk(KERN_ERR "Warning: ATI Radeon IGP Northbridge is not yet fully tested.\n");
+	if (pci_dev_present(ati_rs100))
+		printk(KERN_WARNING "alim15x3: ATI Radeon IGP Northbridge is not yet fully tested.\n");

  #if defined(CONFIG_SPARC64)
  	d->init_hwif = init_hwif_common_ali15x3;
diff --git a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -222,10 +222,9 @@ static int __devinit cs5520_init_one(str

  	/* We must not grab the entire device, it has 'ISA' space in its
  	   BARS too and we will freak out other bits of the kernel */
-	if(pci_enable_device_bars(dev, 1<<2))
-	{
+	if (pci_enable_device_bars(dev, 1<<2)) {
  		printk(KERN_WARNING "%s: Unable to enable 55x0.\n", d->name);
-		return 1;
+		return -ENODEV;
  	}
  	pci_set_master(dev);
  	if (pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -6,7 +6,13 @@
   *
   *  May be copied or modified under the terms of the GNU General Public License
   *
- *  Documentation available under NDA only
+ *  Documentation for CMD680:
+ *  http://gkernel.sourceforge.net/specs/sii/sii-0680a-v1.31.pdf.bz2
+ *
+ *  Documentation for SiI 3112:
+ *  http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
+ *
+ *  Errata and other documentation only available under NDA.
   *
   *
   *  FAQ Items:
diff --git a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -100,185 +100,14 @@ static struct via_isa_bridge {
  	{ NULL }
  };

-static struct via_isa_bridge *via_config;
-static unsigned int via_80w;
  static unsigned int via_clock;
  static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };

-/*
- * VIA /proc entry.
- */
-
-#if defined(DISPLAY_VIA_TIMINGS) && defined(CONFIG_PROC_FS)
-
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 via_proc = 0;
-static unsigned long via_base;
-static struct pci_dev *bmide_dev, *isa_dev;
-
-static char *via_control3[] = { "No limit", "64", "128", "192" };
-
-#define via_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
-#define via_print_drive(name, format, arg...)\
-	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");
-
-
-/**
- *	via_get_info		-	generate via /proc file 
- *	@buffer: buffer for data
- *	@addr: set to start of data to use
- *	@offset: current file offset
- *	@count: size of read
- *
- *	Fills in buffer with the debugging/configuration information for
- *	the VIA chipset tuning and attached drives
- */
- 
-static int via_get_info(char *buffer, char **addr, off_t offset, int count)
+struct via82cxxx_dev
  {
-	int speed[4], cycle[4], setup[4], active[4], recover[4], den[4],
-		 uen[4], udma[4], umul[4], active8b[4], recover8b[4];
-	struct pci_dev *dev = bmide_dev;
-	unsigned int v, u, i;
-	int len;
-	u16 c, w;
-	u8 t, x;
-	char *p = buffer;
-
-	via_print("----------VIA BusMastering IDE Configuration"
-		"----------------");
-
-	via_print("Driver Version:                     3.38");
-	via_print("South Bridge:                       VIA %s",
-		via_config->name);
-
-	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
-	pci_read_config_byte(dev, PCI_REVISION_ID, &x);
-	via_print("Revision:                           ISA %#x IDE %#x", t, x);
-	via_print("Highest DMA rate:                   %s",
-		via_dma[via_config->flags & VIA_UDMA]);
-
-	via_print("BM-DMA base:                        %#lx", via_base);
-	via_print("PCI clock:                          %d.%dMHz",
-		via_clock / 1000, via_clock / 100 % 10);
-
-	pci_read_config_byte(dev, VIA_MISC_1, &t);
-	via_print("Master Read  Cycle IRDY:            %dws",
-		(t & 64) >> 6);
-	via_print("Master Write Cycle IRDY:            %dws",
-		(t & 32) >> 5);
-	via_print("BM IDE Status Register Read Retry:  %s",
-		(t & 8) ? "yes" : "no");
-
-	pci_read_config_byte(dev, VIA_MISC_3, &t);
-	via_print("Max DRDY Pulse Width:               %s%s",
-		via_control3[(t & 0x03)], (t & 0x03) ? " PCI clocks" : "");
-
-	via_print("-----------------------Primary IDE"
-		"-------Secondary IDE------");
-	via_print("Read DMA FIFO flush:   %10s%20s",
-		(t & 0x80) ? "yes" : "no", (t & 0x40) ? "yes" : "no");
-	via_print("End Sector FIFO flush: %10s%20s",
-		(t & 0x20) ? "yes" : "no", (t & 0x10) ? "yes" : "no");
-
-	pci_read_config_byte(dev, VIA_IDE_CONFIG, &t);
-	via_print("Prefetch Buffer:       %10s%20s",
-		(t & 0x80) ? "yes" : "no", (t & 0x20) ? "yes" : "no");
-	via_print("Post Write Buffer:     %10s%20s",
-		(t & 0x40) ? "yes" : "no", (t & 0x10) ? "yes" : "no");
-
-	pci_read_config_byte(dev, VIA_IDE_ENABLE, &t);
-	via_print("Enabled:               %10s%20s",
-		(t & 0x02) ? "yes" : "no", (t & 0x01) ? "yes" : "no");
-
-	c = inb(via_base + 0x02) | (inb(via_base + 0x0a) << 8);
-	via_print("Simplex only:          %10s%20s",
-		(c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");
-
-	via_print("Cable Type:            %10s%20s",
-		(via_80w & 1) ? "80w" : "40w", (via_80w & 2) ? "80w" : "40w");
-
-	via_print("-------------------drive0----drive1"
-		"----drive2----drive3-----");
-
-	pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
-	pci_read_config_dword(dev, VIA_DRIVE_TIMING, &v);
-	pci_read_config_word(dev, VIA_8BIT_TIMING, &w);
-
-	if (via_config->flags & VIA_UDMA)
-		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-	else u = 0;
-
-	for (i = 0; i < 4; i++) {
-
-		setup[i]     = ((t >> ((3 - i) << 1)) & 0x3) + 1;
-		recover8b[i] = ((w >> ((1 - (i >> 1)) << 3)) & 0xf) + 1;
-		active8b[i]  = ((w >> (((1 - (i >> 1)) << 3) + 4)) & 0xf) + 1;
-		active[i]    = ((v >> (((3 - i) << 3) + 4)) & 0xf) + 1;
-		recover[i]   = ((v >> ((3 - i) << 3)) & 0xf) + 1;
-		udma[i]      = ((u >> ((3 - i) << 3)) & 0x7) + 2;
-		umul[i]      = ((u >> (((3 - i) & 2) << 3)) & 0x8) ? 1 : 2;
-		uen[i]       = ((u >> ((3 - i) << 3)) & 0x20);
-		den[i]       = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
-
-		speed[i] = 2 * via_clock / (active[i] + recover[i]);
-		cycle[i] = 1000000 * (active[i] + recover[i]) / via_clock;
-
-		if (!uen[i] || !den[i])
-			continue;
-
-		switch (via_config->flags & VIA_UDMA) {
-
-			case VIA_UDMA_33:
-				speed[i] = 2 * via_clock / udma[i];
-				cycle[i] = 1000000 * udma[i] / via_clock;
-				break;
-
-			case VIA_UDMA_66:
-				speed[i] = 4 * via_clock / (udma[i] * umul[i]);
-				cycle[i] = 500000 * (udma[i] * umul[i]) / via_clock;
-				break;
-
-			case VIA_UDMA_100:
-				speed[i] = 6 * via_clock / udma[i];
-				cycle[i] = 333333 * udma[i] / via_clock;
-				break;
-
-			case VIA_UDMA_133:
-				speed[i] = 8 * via_clock / udma[i];
-				cycle[i] = 250000 * udma[i] / via_clock;
-				break;
-		}
-	}
-
-	via_print_drive("Transfer Mode: ", "%10s",
-		den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
-
-	via_print_drive("Address Setup: ", "%8dns",
-		1000000 * setup[i] / via_clock);
-	via_print_drive("Cmd Active:    ", "%8dns",
-		1000000 * active8b[i] / via_clock);
-	via_print_drive("Cmd Recovery:  ", "%8dns",
-		1000000 * recover8b[i] / via_clock);
-	via_print_drive("Data Active:   ", "%8dns",
-		1000000 * active[i] / via_clock);
-	via_print_drive("Data Recovery: ", "%8dns",
-		1000000 * recover[i] / via_clock);
-	via_print_drive("Cycle Time:    ", "%8dns",
-		cycle[i]);
-	via_print_drive("Transfer Rate: ", "%4d.%dMB/s",
-		speed[i] / 1000, speed[i] / 100 % 10);
-
-	/* hoping it is less than 4K... */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-
-	return len > count ? count : len;
-}
-
-#endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */
+	struct via_isa_bridge *via_config;
+	unsigned int via_80w;
+};

  /**
   *	via_set_speed			-	write timing registers
@@ -289,11 +118,13 @@ static int via_get_info(char *buffer, ch
   *	via_set_speed writes timing values to the chipset registers
   */

-static void via_set_speed(struct pci_dev *dev, u8 dn, struct ide_timing *timing)
+static void via_set_speed(ide_hwif_t *hwif, u8 dn, struct ide_timing *timing)
  {
+	struct pci_dev *dev = hwif->pci_dev;
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(hwif);
  	u8 t;

-	if (~via_config->flags & VIA_BAD_AST) {
+	if (~vdev->via_config->flags & VIA_BAD_AST) {
  		pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
  		t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
  		pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
@@ -305,7 +136,7 @@ static void via_set_speed(struct pci_dev
  	pci_write_config_byte(dev, VIA_DRIVE_TIMING + (3 - dn),
  		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));

-	switch (via_config->flags & VIA_UDMA) {
+	switch (vdev->via_config->flags & VIA_UDMA) {
  		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
  		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
  		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
@@ -329,6 +160,7 @@ static void via_set_speed(struct pci_dev
  static int via_set_drive(ide_drive_t *drive, u8 speed)
  {
  	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(drive->hwif);
  	struct ide_timing t, p;
  	unsigned int T, UT;

@@ -337,7 +169,7 @@ static int via_set_drive(ide_drive_t *dr

  	T = 1000000000 / via_clock;

-	switch (via_config->flags & VIA_UDMA) {
+	switch (vdev->via_config->flags & VIA_UDMA) {
  		case VIA_UDMA_33:   UT = T;   break;
  		case VIA_UDMA_66:   UT = T/2; break;
  		case VIA_UDMA_100:  UT = T/3; break;
@@ -352,7 +184,7 @@ static int via_set_drive(ide_drive_t *dr
  		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
  	}

-	via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
+	via_set_speed(HWIF(drive), drive->dn, &t);

  	if (!drive->init_speed)
  		drive->init_speed = speed;
@@ -390,20 +222,41 @@ static void via82cxxx_tune_drive(ide_dri

  static int via82cxxx_ide_dma_check (ide_drive_t *drive)
  {
-	u16 w80 = HWIF(drive)->udma_four;
+	ide_hwif_t *hwif = HWIF(drive);
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(hwif);
+	u16 w80 = hwif->udma_four;

  	u16 speed = ide_find_best_mode(drive,
  		XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
-		(via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));
+		(vdev->via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));

  	via_set_drive(drive, speed);

  	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+		return hwif->ide_dma_on(drive);
+	return hwif->ide_dma_off_quietly(drive);
+}
+
+static struct via_isa_bridge *via_config_find(struct pci_dev **isa)
+{
+	struct via_isa_bridge *via_config;
+	u8 t;
+
+	for (via_config = via_isa_bridges; via_config->id; via_config++)
+		if ((*isa = pci_find_device(PCI_VENDOR_ID_VIA +
+			!!(via_config->flags & VIA_BAD_ID),
+			via_config->id, NULL))) {
+
+			pci_read_config_byte(*isa, PCI_REVISION_ID, &t);
+			if (t >= via_config->rev_min &&
+			    t <= via_config->rev_max)
+				break;
+		}
+
+	return via_config;
  }

  /**
@@ -418,82 +271,28 @@ static int via82cxxx_ide_dma_check (ide_
  static unsigned int __devinit init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
  {
  	struct pci_dev *isa = NULL;
+	struct via_isa_bridge *via_config;
  	u8 t, v;
  	unsigned int u;
-	int i;

  	/*
  	 * Find the ISA bridge to see how good the IDE is.
  	 */
-
-	for (via_config = via_isa_bridges; via_config->id; via_config++)
-		if ((isa = pci_find_device(PCI_VENDOR_ID_VIA +
-			!!(via_config->flags & VIA_BAD_ID),
-			via_config->id, NULL))) {
-
-			pci_read_config_byte(isa, PCI_REVISION_ID, &t);
-			if (t >= via_config->rev_min &&
-			    t <= via_config->rev_max)
-				break;
-		}
-
+	via_config = via_config_find(&isa);
  	if (!via_config->id) {
  		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, disabling DMA.\n");
  		return -ENODEV;
  	}

  	/*
-	 * Check 80-wire cable presence and setup Clk66.
+	 * Setup or disable Clk66 if appropriate
  	 */

-	switch (via_config->flags & VIA_UDMA) {
-
-		case VIA_UDMA_66:
-			/* Enable Clk66 */
-			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-			pci_write_config_dword(dev, VIA_UDMA_TIMING, u|0x80008);
-			for (i = 24; i >= 0; i -= 8)
-				if (((u >> (i & 16)) & 8) &&
-				    ((u >> i) & 0x20) &&
-				     (((u >> i) & 7) < 2)) {
-					/*
-					 * 2x PCI clock and
-					 * UDMA w/ < 3T/cycle
-					 */
-					via_80w |= (1 << (1 - (i >> 4)));
-				}
-			break;
-
-		case VIA_UDMA_100:
-			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-			for (i = 24; i >= 0; i -= 8)
-				if (((u >> i) & 0x10) ||
-				    (((u >> i) & 0x20) &&
-				     (((u >> i) & 7) < 4))) {
-					/* BIOS 80-wire bit or
-					 * UDMA w/ < 60ns/cycle
-					 */
-					via_80w |= (1 << (1 - (i >> 4)));
-				}
-			break;
-
-		case VIA_UDMA_133:
-			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-			for (i = 24; i >= 0; i -= 8)
-				if (((u >> i) & 0x10) ||
-				    (((u >> i) & 0x20) &&
-				     (((u >> i) & 7) < 6))) {
-					/* BIOS 80-wire bit or
-					 * UDMA w/ < 60ns/cycle
-					 */
-					via_80w |= (1 << (1 - (i >> 4)));
-				}
-			break;
-
-	}
-
-	/* Disable Clk66 */
-	if (via_config->flags & VIA_BAD_CLK66) {
+	if ((via_config->flags & VIA_UDMA) == VIA_UDMA_66) {
+		/* Enable Clk66 */
+		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
+		pci_write_config_dword(dev, VIA_UDMA_TIMING, u|0x80008);
+	} else if (via_config->flags & VIA_BAD_CLK66) {
  		/* Would cause trouble on 596a and 686 */
  		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
  		pci_write_config_dword(dev, VIA_UDMA_TIMING, u & ~0x80008);
@@ -560,26 +359,78 @@ static unsigned int __devinit init_chips
  		via_dma[via_config->flags & VIA_UDMA],
  		pci_name(dev));

-	/*
-	 * Setup /proc/ide/via entry.
-	 */
+	return 0;
+}
+
+/*
+ * Check and handle 80-wire cable presence
+ */
+static void __devinit via_cable_detect(struct pci_dev *dev, struct via82cxxx_dev *vdev)
+{
+	unsigned int u;
+	int i;
+	pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
+
+	switch (vdev->via_config->flags & VIA_UDMA) {
+
+		case VIA_UDMA_66:
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> (i & 16)) & 8) &&
+				    ((u >> i) & 0x20) &&
+				     (((u >> i) & 7) < 2)) {
+					/*
+					 * 2x PCI clock and
+					 * UDMA w/ < 3T/cycle
+					 */
+					vdev->via_80w |= (1 << (1 - (i >> 4)));
+				}
+			break;
+
+		case VIA_UDMA_100:
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> i) & 0x10) ||
+				    (((u >> i) & 0x20) &&
+				     (((u >> i) & 7) < 4))) {
+					/* BIOS 80-wire bit or
+					 * UDMA w/ < 60ns/cycle
+					 */
+					vdev->via_80w |= (1 << (1 - (i >> 4)));
+				}
+			break;
+
+		case VIA_UDMA_133:
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> i) & 0x10) ||
+				    (((u >> i) & 0x20) &&
+				     (((u >> i) & 7) < 6))) {
+					/* BIOS 80-wire bit or
+					 * UDMA w/ < 60ns/cycle
+					 */
+					vdev->via_80w |= (1 << (1 - (i >> 4)));
+				}
+			break;

-#if defined(DISPLAY_VIA_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!via_proc) {
-		via_base = pci_resource_start(dev, 4);
-		bmide_dev = dev;
-		isa_dev = isa;
-		ide_pci_create_host_proc("via", via_get_info);
-		via_proc = 1;
  	}
-#endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */
-	return 0;
  }

  static void __devinit init_hwif_via82cxxx(ide_hwif_t *hwif)
  {
+	struct via82cxxx_dev *vdev = kmalloc(sizeof(struct via82cxxx_dev),
+		GFP_KERNEL);
+	struct pci_dev *isa = NULL;
  	int i;

+	if (vdev == NULL) {
+		printk(KERN_ERR "VP_IDE: out of memory :(\n");
+		return;
+	}
+
+	memset(vdev, 0, sizeof(struct via82cxxx_dev));
+	ide_set_hwifdata(hwif, vdev);
+
+	vdev->via_config = via_config_find(&isa);
+	via_cable_detect(hwif->pci_dev, vdev);
+
  	hwif->autodma = 0;

  	hwif->tuneproc = &via82cxxx_tune_drive;
@@ -594,7 +445,7 @@ static void __devinit init_hwif_via82cxx

  	for (i = 0; i < 2; i++) {
  		hwif->drives[i].io_32bit = 1;
-		hwif->drives[i].unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
+		hwif->drives[i].unmask = (vdev->via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
  		hwif->drives[i].autotune = 1;
  		hwif->drives[i].dn = hwif->channel * 2 + i;
  	}
@@ -608,7 +459,7 @@ static void __devinit init_hwif_via82cxx
  	hwif->swdma_mask = 0x07;

  	if (!hwif->udma_four)
-		hwif->udma_four = (via_80w >> hwif->channel) & 1;
+		hwif->udma_four = (vdev->via_80w >> hwif->channel) & 1;
  	hwif->ide_dma_check = &via82cxxx_ide_dma_check;
  	if (!noautodma)
  		hwif->autodma = 1;
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1401,20 +1401,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
  	/* We probe the hwif now */
  	probe_hwif_init(hwif);

-	/* The code IDE code will have set hwif->present if we have devices attached,
-	 * if we don't, the discard the interface except if we are on a media bay slot
-	 */
-	if (!hwif->present && !pmif->mediabay) {
-		printk(KERN_INFO "ide%d: Bus empty, interface released.\n",
-			hwif->index);
-		default_hwif_iops(hwif);
-		for (i = IDE_DATA_OFFSET; i <= IDE_CONTROL_OFFSET; ++i)
-			hwif->io_ports[i] = 0;
-		hwif->chipset = ide_unknown;
-		hwif->noprobe = 1;
-		return -ENODEV;
-	}
-
  	return 0;
  }

diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -787,7 +787,7 @@ static int pre_init = 1;		/* Before firs
  static LIST_HEAD(ide_pci_drivers);

  /*
- *	__ide_register_pci_driver	-	attach IDE driver
+ *	__ide_pci_register_driver	-	attach IDE driver
   *	@driver: pci driver
   *	@module: owner module of the driver
   *
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -784,8 +784,8 @@ static ide_proc_entry_t idescsi_proc[] =
  #endif

  static ide_driver_t idescsi_driver = {
-	.owner			= THIS_MODULE,
  	.gen_driver = {
+		.owner		= THIS_MODULE,
  		.name		= "ide-scsi",
  		.bus		= &ide_bus_type,
  		.probe		= ide_scsi_probe,
diff --git a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1089,9 +1089,11 @@ enum {

  /*
   * Subdrivers support.
+ *
+ * The gendriver.owner field should be set to the module owner of this driver.
+ * The gendriver.name field should be set to the name of this driver
   */
  typedef struct ide_driver_s {
-	struct module			*owner;
  	const char			*version;
  	u8				media;
  	unsigned supports_dsc_overlap	: 1;
