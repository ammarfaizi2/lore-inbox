Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTIAXBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 19:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTIAXBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 19:01:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:3227 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263330AbTIAXAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 19:00:01 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: JD Gray <kahdgarxi@grayserv.com>
Subject: [PATCH] Re: siimage 1.06 in kernel 2.6
Date: Tue, 2 Sep 2003 01:00:52 +0200
User-Agent: KMail/1.5
References: <1062453091.2075.13.camel@mikhail.grayserv.com>
In-Reply-To: <1062453091.2075.13.camel@mikhail.grayserv.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309020100.52488.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here you go.

It is against 2.6.0-test4-bk3, so please apply
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.0-test4-bk3.bz2
first.

--bartlomiej

On Monday 01 of September 2003 23:51, JD Gray wrote:
> I use an SiS SATA controller that uses the siimage driver
> (drivers/ide/pci/siimage.c) I have an -ac 2.4 kernel that uses version
> 1.06 of this driver, and it works very well (~65MB/s). Kernel 2.6 on the
> other hand has version 1.02 of this driver which gets very poor
> preformance (~1.5MB/s.) I would like to know if anyone is working on
> getting 1.06 into the 2.6 kernel. (I've tried several ways to get it
> working including copying the .c straight from my kernel and patch
> posted on this mailing list. Neither worked, it wouldn't compile either
> time.) If no one is, then this is a request per say. If anyone has time
> and/or is able to put this new driver into the 2.6 kernel I would be
> greatly thankful. Thanks alot
> -JD Gray
> (KahdgarXI)


ide: forward-port siimage driver changes from 2.4.22

 drivers/ide/pci/siimage.c |  828 +++++++++++++++++++++++++++++++++-------------
 drivers/ide/pci/siimage.h |   25 -
 include/linux/pci_ids.h   |    1 
 3 files changed, 609 insertions(+), 245 deletions(-)

diff -puN drivers/ide/pci/siimage.c~ide-siimage-port drivers/ide/pci/siimage.c
--- linux-2.6.0-test4-bk3/drivers/ide/pci/siimage.c~ide-siimage-port	2003-09-02 00:53:56.914630528 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/pci/siimage.c	2003-09-02 00:53:56.929628248 +0200
@@ -1,7 +1,24 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.02	Jan 30, 2003
+ * linux/drivers/ide/pci/siimage.c		Version 1.06	June 11, 2003
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
+ * Copyright (C) 2003		Red Hat <alan@redhat.com>
+ *
+ *  May be copied or modified under the terms of the GNU General Public License
+ *
+ *  Documentation available under NDA only
+ *
+ *
+ *  FAQ Items:
+ *	If you are using Marvell SATA-IDE adapters with Maxtor drives
+ *	ensure the system is set up for ATA100/UDMA5 not UDMA6.
+ *
+ *	If you are using WD drives with SATA bridges you must set the
+ *	drive to "Single". "Master" will hang
+ *
+ *	If you have strange problems with nVidia chipset systems please
+ *	see the SI support documentation and update your system BIOS
+ *	if neccessary
  */
 
 #include <linux/config.h>
@@ -22,16 +39,107 @@
 #include <linux/proc_fs.h>
 
 static u8 siimage_proc = 0;
-#define SIIMAGE_MAX_DEVS		5
+#define SIIMAGE_MAX_DEVS		16
 static struct pci_dev *siimage_devs[SIIMAGE_MAX_DEVS];
 static int n_siimage_devs;
 
-static char * print_siimage_get_info (char *buf, struct pci_dev *dev, int index)
+/**
+ *	pdev_is_sata		-	check if device is SATA
+ *	@pdev:	PCI device to check
+ *	
+ *	Returns true if this is a SATA controller
+ */
+ 
+static int pdev_is_sata(struct pci_dev *pdev)
+{
+	switch(pdev->device)
+	{
+		case PCI_DEVICE_ID_SII_3112:
+		case PCI_DEVICE_ID_SII_1210SA:
+			return 1;
+		case PCI_DEVICE_ID_SII_680:
+			return 0;
+	}
+	BUG();
+	return 0;
+}
+ 
+/**
+ *	is_sata			-	check if hwif is SATA
+ *	@hwif:	interface to check
+ *	
+ *	Returns true if this is a SATA controller
+ */
+ 
+static inline int is_sata(ide_hwif_t *hwif)
+{
+	return pdev_is_sata(hwif->pci_dev);
+}
+
+/**
+ *	siimage_selreg		-	return register base
+ *	@hwif: interface
+ *	@r: config offset
+ *
+ *	Turn a config register offset into the right address in either
+ *	PCI space or MMIO space to access the control register in question
+ *	Thankfully this is a configuration operation so isnt performance
+ *	criticial. 
+ */
+ 
+static unsigned long siimage_selreg(ide_hwif_t *hwif, int r)
+{
+	unsigned long base = (unsigned long)hwif->hwif_data;
+	base += 0xA0 + r;
+	if(hwif->mmio)
+		base += (hwif->channel << 6);
+	else
+		base += (hwif->channel << 4);
+	return base;
+}
+	
+/**
+ *	siimage_seldev		-	return register base
+ *	@hwif: interface
+ *	@r: config offset
+ *
+ *	Turn a config register offset into the right address in either
+ *	PCI space or MMIO space to access the control register in question
+ *	including accounting for the unit shift.
+ */
+ 
+static inline unsigned long siimage_seldev(ide_drive_t *drive, int r)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	unsigned long base = (unsigned long)hwif->hwif_data;
+	base += 0xA0 + r;
+	if(hwif->mmio)
+		base += (hwif->channel << 6);
+	else
+		base += (hwif->channel << 4);
+	base |= drive->select.b.unit << drive->select.b.unit;
+	return base;
+}
+	
+/**
+ *	print_siimage_get_info	-	print minimal proc information
+ *	@buf: buffer to write into (kernel space)
+ *	@dev: PCI device we are describing
+ *	@index: Controller number
+ *
+ *	Print the basic information for the state of the CMD680/SI3112
+ *	channel. We don't actually dump a lot of information out for
+ *	this controller although we could expand it if we needed.
+ */
+ 
+static char *print_siimage_get_info (char *buf, struct pci_dev *dev, int index)
 {
 	char *p		= buf;
 	u8 mmio		= (pci_get_drvdata(dev) != NULL) ? 1 : 0;
-	unsigned long bmdma	= (mmio) ? ((unsigned long) pci_get_drvdata(dev)) :
-				    (pci_resource_start(dev, 4));
+	unsigned long bmdma = pci_resource_start(dev, 4);
+	
+	if(mmio)
+		bmdma = pci_resource_start(dev, 5);
 
 	p += sprintf(p, "\nController: %d\n", index);
 	p += sprintf(p, "SiI%x Chipset.\n", dev->device);
@@ -39,18 +147,20 @@ static char * print_siimage_get_info (ch
 		p += sprintf(p, "MMIO Base 0x%lx\n", bmdma);
 	p += sprintf(p, "%s-DMA Base 0x%lx\n", (mmio)?"MMIO":"BM", bmdma);
 	p += sprintf(p, "%s-DMA Base 0x%lx\n", (mmio)?"MMIO":"BM", bmdma+8);
-
-	p += sprintf(p, "--------------- Primary Channel "
-			"---------------- Secondary Channel "
-			"-------------\n");
-	p += sprintf(p, "--------------- drive0 --------- drive1 "
-			"-------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "PIO Mode:       %s                %s"
-			"               %s                 %s\n",
-			"?", "?", "?", "?");
 	return (char *)p;
 }
 
+/**
+ *	siimage_get_info	-	proc callback
+ *	@buffer: kernel buffer to complete
+ *	@addr: written with base of data to return
+ *	offset: seek offset
+ *	count: bytes to fill in 
+ *
+ *	Called when the user reads data from the virtual file for this
+ *	controller from /proc
+ */
+ 
 static int siimage_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
@@ -71,46 +181,70 @@ static int siimage_get_info (char *buffe
 
 #endif	/* defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS) */
 
+/**
+ *	siimage_ratemask	-	Compute available modes
+ *	@drive: IDE drive
+ *
+ *	Compute the available speeds for the devices on the interface.
+ *	For the CMD680 this depends on the clocking mode (scsc), for the
+ *	SI3312 SATA controller life is a bit simpler. Enforce UDMA33
+ *	as a limit if there is no 80pin cable present.
+ */
+ 
 static byte siimage_ratemask (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 mode	= 0, scsc = 0;
+	unsigned long base = (unsigned long) hwif->hwif_data;
 
 	if (hwif->mmio)
-		scsc = hwif->INB(HWIFADDR(0x4A));
+		scsc = hwif->INB(base + 0x4A);
 	else
 		pci_read_config_byte(hwif->pci_dev, 0x8A, &scsc);
 
-	switch(hwif->pci_dev->device) {
-		case PCI_DEVICE_ID_SII_3112:
-			return 4;
-		case PCI_DEVICE_ID_SII_680:
-			if ((scsc & 0x10) == 0x10)	/* 133 */
-				mode = 4;
-			else if ((scsc & 0x30) == 0x00)	/* 100 */
-				mode = 3;
-			else if ((scsc & 0x20) == 0x20)	/* 66 eek */
-				BUG();	// mode = 2;
-			break;
-		default:	return 0;
+	if(is_sata(hwif))
+	{
+		if(strstr(drive->id->model, "Maxtor"))
+			return 3;
+		return 4;
 	}
+	
+	if ((scsc & 0x30) == 0x10)	/* 133 */
+		mode = 4;
+	else if ((scsc & 0x30) == 0x20)	/* 2xPCI */
+		mode = 4;
+	else if ((scsc & 0x30) == 0x00)	/* 100 */
+		mode = 3;
+	else 	/* Disabled ? */
+		BUG();
+
 	if (!eighty_ninty_three(drive))
 		mode = min(mode, (u8)1);
 	return mode;
 }
 
+/**
+ *	siimage_taskfile_timing	-	turn timing data to a mode
+ *	@hwif: interface to query
+ *
+ *	Read the timing data for the interface and return the 
+ *	mode that is being used.
+ */
+ 
 static byte siimage_taskfile_timing (ide_hwif_t *hwif)
 {
 	u16 timing	= 0x328a;
+	unsigned long addr = siimage_selreg(hwif, 2);
 
 	if (hwif->mmio)
-		timing = hwif->INW(SELADDR(2));
+		timing = hwif->INW(addr);
 	else
-		pci_read_config_word(hwif->pci_dev, SELREG(2), &timing);
+		pci_read_config_word(hwif->pci_dev, addr, &timing);
 
 	switch (timing) {
 		case 0x10c1:	return 4;
 		case 0x10c3:	return 3;
+		case 0x1104:
 		case 0x1281:	return 2;
 		case 0x2283:	return 1;
 		case 0x328a:
@@ -118,34 +252,88 @@ static byte siimage_taskfile_timing (ide
 	}
 }
 
+/**
+ *	simmage_tuneproc	-	tune a drive
+ *	@drive: drive to tune
+ *	@mode_wanted: the target operating mode
+ *
+ *	Load the timing settings for this device mode into the
+ *	controller. If we are in PIO mode 3 or 4 turn on IORDY
+ *	monitoring (bit 9). The TF timing is bits 31:16
+ */
+ 
 static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	u16 speedt		= 0;
-	u8 unit			= drive->select.b.unit;
-
-	if (hwif->mmio)
-		speedt = hwif->INW(SELADDR(0x04|(unit<<unit)));
-	else
-		pci_read_config_word(dev, SELADDR(0x04|(unit<<unit)), &speedt);
-
+	u32 speedt		= 0;
+	u16 speedp		= 0;
+	unsigned long addr	= siimage_seldev(drive, 0x04);
+	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
+	
 	/* cheat for now and use the docs */
-//	switch(siimage_taskfile_timing(hwif)) {
 	switch(mode_wanted) {
-		case 4:		speedt = 0x10c1; break;
-		case 3:		speedt = 0x10C3; break;
-		case 2:		speedt = 0x1104; break;
-		case 1:		speedt = 0x2283; break;
+		case 4:	
+			speedp = 0x10c1; 
+			speedt = 0x10c1;
+			break;
+		case 3:	
+			speedp = 0x10C3; 
+			speedt = 0x10C3;
+			break;
+		case 2:	
+			speedp = 0x1104; 
+			speedt = 0x1281;
+			break;
+		case 1:		
+			speedp = 0x2283; 
+			speedt = 0x1281;
+			break;
 		case 0:
-		default:	speedt = 0x328A; break;
+		default:
+			speedp = 0x328A; 
+			speedt = 0x328A;
+			break;
 	}
 	if (hwif->mmio)
-		hwif->OUTW(speedt, SELADDR(0x04|(unit<<unit)));
+	{
+		hwif->OUTW(speedt, addr);
+		hwif->OUTW(speedp, tfaddr);
+		/* Now set up IORDY */
+		if(mode_wanted == 3 || mode_wanted == 4)
+			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
+		else
+			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
+	}
 	else
-		pci_write_config_word(dev, SELADDR(0x04|(unit<<unit)), speedt);
+	{
+		pci_write_config_word(hwif->pci_dev, addr, speedp);
+		pci_write_config_word(hwif->pci_dev, tfaddr, speedt);
+		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);
+		speedp &= ~0x200;
+		/* Set IORDY for mode 3 or 4 */
+		if(mode_wanted == 3 || mode_wanted == 4)
+			speedp |= 0x200;
+		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
+	}
 }
 
+/**
+ *	config_siimage_chipset_for_pio	-	set drive timings
+ *	@drive: drive to tune
+ *	@speed we want
+ *
+ *	Compute the best pio mode we can for a given device. Also honour
+ *	the timings for the driver when dealing with mixed devices. Some
+ *	of this is ugly but its all wrapped up here
+ *
+ *	The SI680 can also do VDMA - we need to start using that
+ *
+ *	FIXME: we use the BIOS channel timings to avoid driving the task
+ *	files too fast at the disk. We need to compute the master/slave
+ *	drive PIO mode properly so that we can up the speed on a hotplug
+ *	system.
+ */
+ 
 static void config_siimage_chipset_for_pio (ide_drive_t *drive, byte set_speed)
 {
 	u8 channel_timings	= siimage_taskfile_timing(HWIF(drive));
@@ -166,6 +354,16 @@ static void config_chipset_for_pio (ide_
 	config_siimage_chipset_for_pio(drive, set_speed);
 }
 
+/**
+ *	siimage_tune_chipset	-	set controller timings
+ *	@drive: Drive to set up
+ *	@xferspeed: speed we want to achieve
+ *
+ *	Tune the SII chipset for the desired mode. If we can't achieve
+ *	the desired mode then tune for a lower one, but ultimately
+ *	make the thing work.
+ */
+ 
 static int siimage_tune_chipset (ide_drive_t *drive, byte xferspeed)
 {
 	u8 ultra6[]		= { 0x0F, 0x0B, 0x07, 0x05, 0x03, 0x02, 0x01 };
@@ -175,30 +373,32 @@ static int siimage_tune_chipset (ide_dri
 	ide_hwif_t *hwif	= HWIF(drive);
 	u16 ultra = 0, multi	= 0;
 	u8 mode = 0, unit	= drive->select.b.unit;
-	u8 speed	= ide_rate_filter(siimage_ratemask(drive), xferspeed);
+	u8 speed		= ide_rate_filter(siimage_ratemask(drive), xferspeed);
+	unsigned long base	= (unsigned long)hwif->hwif_data;
 	u8 scsc = 0, addr_mask	= ((hwif->channel) ?
 				    ((hwif->mmio) ? 0xF4 : 0x84) :
 				    ((hwif->mmio) ? 0xB4 : 0x80));
+				    
+	unsigned long ma	= siimage_seldev(drive, 0x08);
+	unsigned long ua	= siimage_seldev(drive, 0x0C);
 
 	if (hwif->mmio) {
-		scsc = hwif->INB(HWIFADDR(0x4A));
-		mode = hwif->INB(HWIFADDR(addr_mask));
-		multi = hwif->INW(SELADDR(0x08|(unit<<unit)));
-		ultra = hwif->INW(SELADDR(0x0C|(unit<<unit)));
+		scsc = hwif->INB(base + 0x4A);
+		mode = hwif->INB(base + addr_mask);
+		multi = hwif->INW(ma);
+		ultra = hwif->INW(ua);
 	} else {
-		pci_read_config_byte(hwif->pci_dev, HWIFADDR(0x8A), &scsc);
+		pci_read_config_byte(hwif->pci_dev, 0x8A, &scsc);
 		pci_read_config_byte(hwif->pci_dev, addr_mask, &mode);
-		pci_read_config_word(hwif->pci_dev,
-				SELREG(0x08|(unit<<unit)), &multi);
-		pci_read_config_word(hwif->pci_dev,
-				SELREG(0x0C|(unit<<unit)), &ultra);
+		pci_read_config_word(hwif->pci_dev, ma, &multi);
+		pci_read_config_word(hwif->pci_dev, ua, &ultra);
 	}
 
 	mode &= ~((unit) ? 0x30 : 0x03);
 	ultra &= ~0x3F;
 	scsc = ((scsc & 0x30) == 0x00) ? 0 : 1;
 
-	scsc = (hwif->pci_dev->device == PCI_DEVICE_ID_SII_3112) ? 1 : scsc;
+	scsc = is_sata(hwif) ? 1 : scsc;
 
 	switch(speed) {
 		case XFER_PIO_4:
@@ -224,8 +424,8 @@ static int siimage_tune_chipset (ide_dri
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
 			multi = dma[2];
-			ultra |= ((scsc) ? (ultra5[speed - XFER_UDMA_0]) :
-					   (ultra6[speed - XFER_UDMA_0]));
+			ultra |= ((scsc) ? (ultra6[speed - XFER_UDMA_0]) :
+					   (ultra5[speed - XFER_UDMA_0]));
 			mode |= ((unit) ? 0x30 : 0x03);
 			config_siimage_chipset_for_pio(drive, 0);
 			break;
@@ -234,20 +434,26 @@ static int siimage_tune_chipset (ide_dri
 	}
 
 	if (hwif->mmio) {
-		hwif->OUTB(mode, HWIFADDR(addr_mask));
-		hwif->OUTW(multi, SELADDR(0x08|(unit<<unit)));
-		hwif->OUTW(ultra, SELADDR(0x0C|(unit<<unit)));
+		hwif->OUTB(mode, base + addr_mask);
+		hwif->OUTW(multi, ma);
+		hwif->OUTW(ultra, ua);
 	} else {
 		pci_write_config_byte(hwif->pci_dev, addr_mask, mode);
-		pci_write_config_word(hwif->pci_dev,
-				SELREG(0x08|(unit<<unit)), multi);
-		pci_write_config_word(hwif->pci_dev,
-				SELREG(0x0C|(unit<<unit)), ultra);
+		pci_write_config_word(hwif->pci_dev, ma, multi);
+		pci_write_config_word(hwif->pci_dev, ua, ultra);
 	}
-
 	return (ide_config_drive_speed(drive, speed));
 }
 
+/**
+ *	config_chipset_for_dma	-	configure for DMA
+ *	@drive: drive to configure
+ *
+ *	Called by the IDE layer when it wants the timings set up.
+ *	For the CMD680 we also need to set up the PIO timings and
+ *	enable DMA.
+ */
+ 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
 	u8 speed	= ide_dma_speed(drive, siimage_ratemask(drive));
@@ -266,14 +472,22 @@ static int config_chipset_for_dma (ide_d
 	return ide_dma_enable(drive);
 }
 
+/**
+ *	siimage_configure_drive_for_dma	-	set up for DMA transfers
+ *	@drive: drive we are going to set up
+ *
+ *	Set up the drive for DMA, tune the controller and drive as 
+ *	required. If the drive isn't suitable for DMA or we hit
+ *	other problems then we will drop down to PIO and set up
+ *	PIO appropriately
+ */
+ 
 static int siimage_config_drive_for_dma (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
-	if (id != NULL && (id->capability & 1) != 0 && drive->autodma) {
-		if (!(hwif->atapi_dma))
-			goto fast_ata_pio;
+	if ((id->capability & 1) != 0 && drive->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
@@ -315,18 +529,28 @@ static int siimage_io_ide_dma_test_irq (
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 dma_altstat		= 0;
+	unsigned long addr	= siimage_selreg(hwif, 1);
 
 	/* return 1 if INTR asserted */
 	if ((hwif->INB(hwif->dma_status) & 4) == 4)
 		return 1;
 
 	/* return 1 if Device INTR asserted */
-	pci_read_config_byte(hwif->pci_dev, SELREG(1), &dma_altstat);
+	pci_read_config_byte(hwif->pci_dev, addr, &dma_altstat);
 	if (dma_altstat & 8)
 		return 0;	//return 1;
 	return 0;
 }
 
+/**
+ *	siimage_mmio_ide_dma_count	-	DMA bytes done
+ *	@drive
+ *
+ *	If we are doing VDMA the CMD680 requires a little bit
+ *	of more careful handling and we have to read the counts
+ *	off ourselves. For non VDMA life is normal.
+ */
+ 
 static int siimage_mmio_ide_dma_count (ide_drive_t *drive)
 {
 #ifdef SIIMAGE_VIRTUAL_DMAPIO
@@ -334,9 +558,10 @@ static int siimage_mmio_ide_dma_count (i
 	ide_hwif_t *hwif	= HWIF(drive);
 	u32 count		= (rq->nr_sectors * SECTOR_SIZE);
 	u32 rcount		= 0;
+	unsigned long addr	= siimage_selreg(hwif, 0x1C);
 
-	hwif->OUTL(count, SELADDR(0x1C));
-	rcount = hwif->INL(SELADDR(0x1C));
+	hwif->OUTL(count, addr);
+	rcount = hwif->INL(addr);
 
 	printk("\n%s: count = %d, rcount = %d, nr_sectors = %lu\n",
 		drive->name, count, rcount, rq->nr_sectors);
@@ -345,13 +570,22 @@ static int siimage_mmio_ide_dma_count (i
 	return __ide_dma_count(drive);
 }
 
-/* returns 1 if dma irq issued, 0 otherwise */
+/**
+ *	siimage_mmio_ide_dma_test_irq	-	check we caused an IRQ
+ *	@drive: drive we are testing
+ *
+ *	Check if we caused an IDE DMA interrupt. We may also have caused
+ *	SATA status interrupts, if so we clean them up and continue.
+ */
+ 
 static int siimage_mmio_ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
+	unsigned long base	= (unsigned long)hwif->hwif_data;
+	unsigned long addr	= siimage_selreg(hwif, 0x1);
 
 	if (SATA_ERROR_REG) {
-		u32 ext_stat = hwif->INL(HWIFADDR(0x10));
+		u32 ext_stat = hwif->INL(base + 0x10);
 		u8 watchdog = 0;
 		if (ext_stat & ((hwif->channel) ? 0x40 : 0x10)) {
 			u32 sata_error = hwif->INL(SATA_ERROR_REG);
@@ -378,7 +612,7 @@ static int siimage_mmio_ide_dma_test_irq
 		return 1;
 
 	/* return 1 if Device INTR asserted */
-	if ((hwif->INB(SELADDR(1)) & 8) == 8)
+	if ((hwif->INB(addr) & 8) == 8)
 		return 0;	//return 1;
 
 	return 0;
@@ -387,21 +621,29 @@ static int siimage_mmio_ide_dma_test_irq
 static int siimage_mmio_ide_dma_verbose (ide_drive_t *drive)
 {
 	int temp = __ide_dma_verbose(drive);
-#if 0
-	drive->using_dma = 0;
-#endif
 	return temp;
 }
 
+/**
+ *	siimage_busproc		-	bus isolation ioctl
+ *	@drive: drive to isolate/restore
+ *	@state: bus state to set
+ *
+ *	Used by the SII3112 to handle bus isolation. As this is a 
+ *	SATA controller the work required is quite limited, we 
+ *	just have to clean up the statistics
+ */
+ 
 static int siimage_busproc (ide_drive_t * drive, int state)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u32 stat_config		= 0;
+	unsigned long addr	= siimage_selreg(hwif, 0);
 
 	if (hwif->mmio) {
-		stat_config = hwif->INL(SELADDR(0));
+		stat_config = hwif->INL(addr);
 	} else
-		pci_read_config_dword(hwif->pci_dev, SELREG(0), &stat_config);
+		pci_read_config_dword(hwif->pci_dev, addr, &stat_config);
 
 	switch (state) {
 		case BUSSTATE_ON:
@@ -417,12 +659,20 @@ static int siimage_busproc (ide_drive_t 
 			hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
 			break;
 		default:
-			return 0;
+			return -EINVAL;
 	}
 	hwif->bus_state = state;
 	return 0;
 }
 
+/**
+ *	siimage_reset_poll	-	wait for sata reset
+ *	@drive: drive we are resetting
+ *
+ *	Poll the SATA phy and see whether it has come back from the dead
+ *	yet.
+ */
+ 
 static int siimage_reset_poll (ide_drive_t *drive)
 {
 	if (SATA_STATUS_REG) {
@@ -432,13 +682,7 @@ static int siimage_reset_poll (ide_drive
 			printk(KERN_WARNING "%s: reset phy dead, status=0x%08x\n",
 				hwif->name, hwif->INL(SATA_STATUS_REG));
 			HWGROUP(drive)->poll_timeout = 0;
-#if 0
-			drive->failures++;
-			return ide_stopped;
-#else
 			return ide_started;
-#endif
-			return 1;
 		}
 		return 0;
 	} else {
@@ -446,34 +690,53 @@ static int siimage_reset_poll (ide_drive
 	}
 }
 
+/**
+ *	siimage_pre_reset	-	reset hook
+ *	@drive: IDE device being reset
+ *
+ *	For the SATA devices we need to handle recalibration/geometry
+ *	differently
+ */
+ 
 static void siimage_pre_reset (ide_drive_t *drive)
 {
 	if (drive->media != ide_disk)
 		return;
 
-	if (HWIF(drive)->pci_dev->device == PCI_DEVICE_ID_SII_3112) {
+	if (is_sata(HWIF(drive)))
+	{
 		drive->special.b.set_geometry = 0;
 		drive->special.b.recalibrate = 0;
 	}
 }
 
+/**
+ *	siimage_reset	-	reset a device on an siimage controller
+ *	@drive: drive to reset
+ *
+ *	Perform a controller level reset fo the device. For
+ *	SATA we must also check the PHY.
+ */
+ 
 static void siimage_reset (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 reset		= 0;
+	unsigned long addr	= siimage_selreg(hwif, 0);
 
 	if (hwif->mmio) {
-		reset = hwif->INB(SELADDR(0));
-		hwif->OUTB((reset|0x03), SELADDR(0));
+		reset = hwif->INB(addr);
+		hwif->OUTB((reset|0x03), addr);
+		/* FIXME:posting */
 		udelay(25);
-		hwif->OUTB(reset, SELADDR(0));
-		(void) hwif->INB(SELADDR(0));
+		hwif->OUTB(reset, addr);
+		(void) hwif->INB(addr);
 	} else {
-		pci_read_config_byte(hwif->pci_dev, SELREG(0), &reset);
-		pci_write_config_byte(hwif->pci_dev, SELREG(0), reset|0x03);
+		pci_read_config_byte(hwif->pci_dev, addr, &reset);
+		pci_write_config_byte(hwif->pci_dev, addr, reset|0x03);
 		udelay(25);
-		pci_write_config_byte(hwif->pci_dev, SELREG(0), reset);
-		pci_read_config_byte(hwif->pci_dev, SELREG(0), &reset);
+		pci_write_config_byte(hwif->pci_dev, addr, reset);
+		pci_read_config_byte(hwif->pci_dev, addr, &reset);
 	}
 
 	if (SATA_STATUS_REG) {
@@ -489,20 +752,28 @@ static void siimage_reset (ide_drive_t *
 
 }
 
+/**
+ *	proc_reports_siimage		-	add siimage controller to proc
+ *	@dev: PCI device
+ *	@clocking: SCSC value
+ *	@name: controller name
+ *
+ *	Report the clocking mode of the controller and add it to
+ *	the /proc interface layer
+ */
+ 
 static void proc_reports_siimage (struct pci_dev *dev, u8 clocking, const char *name)
 {
-	if (dev->device == PCI_DEVICE_ID_SII_3112)
+	if(pdev_is_sata(dev))
 		goto sata_skip;
 
 	printk(KERN_INFO "%s: BASE CLOCK ", name);
-	clocking &= ~0x0C;
+	clocking &= 0x03;
 	switch(clocking) {
 		case 0x03: printk("DISABLED !\n"); break;
 		case 0x02: printk("== 2X PCI \n"); break;
 		case 0x01: printk("== 133 \n"); break;
 		case 0x00: printk("== 100 \n"); break;
-		default:
-			BUG();
 	}
 
 sata_skip:
@@ -517,75 +788,108 @@ sata_skip:
 #endif /* DISPLAY_SIIMAGE_TIMINGS && CONFIG_PROC_FS */
 }
 
+/**
+ *	setup_mmio_siimage	-	switch an SI controller into MMIO
+ *	@dev: PCI device we are configuring
+ *	@name: device name
+ *
+ *	Attempt to put the device into mmio mode. There are some slight
+ *	complications here with certain systems where the mmio bar isnt
+ *	mapped so we have to be sure we can fall back to I/O.
+ */
+ 
 static unsigned int setup_mmio_siimage (struct pci_dev *dev, const char *name)
 {
 	unsigned long bar5	= pci_resource_start(dev, 5);
-	unsigned long end5	= pci_resource_end(dev, 5);
+	unsigned long barsize	= pci_resource_len(dev, 5);
 	u8 tmpbyte	= 0;
 	unsigned long addr;
 	void *ioaddr;
 
-	ioaddr = ioremap_nocache(bar5, (end5 - bar5));
+	/*
+	 *	Drop back to PIO if we can't map the mmio. Some
+	 *	systems seem to get terminally confused in the PCI
+	 *	spaces.
+	 */
+	 
+	if(!request_mem_region(bar5, barsize, name))
+	{
+		printk(KERN_WARNING "siimage: IDE controller MMIO ports not available.\n");
+		return 0;
+	}
+		
+	ioaddr = ioremap(bar5, barsize);
 
 	if (ioaddr == NULL)
+	{
+		release_mem_region(bar5, barsize);
 		return 0;
+	}
 
 	pci_set_master(dev);
 	pci_set_drvdata(dev, ioaddr);
 	addr = (unsigned long) ioaddr;
 
-	if (dev->device == PCI_DEVICE_ID_SII_3112) {
-		writel(0, DEVADDR(0x148));
-		writel(0, DEVADDR(0x1C8));
+	if (pdev_is_sata(dev)) {
+		writel(0, addr + 0x148);
+		writel(0, addr + 0x1C8);
 	}
 
-	writeb(0, DEVADDR(0xB4));
-	writeb(0, DEVADDR(0xF4));
-	tmpbyte = readb(DEVADDR(0x4A));
-
-	switch(tmpbyte) {
-		case 0x01:
-			writeb(tmpbyte|0x10, DEVADDR(0x4A));
-			tmpbyte = readb(DEVADDR(0x4A));
-		case 0x31:
-			/* if clocking is disabled */
-			/* 133 clock attempt to force it on */
-			writeb(tmpbyte & ~0x20, DEVADDR(0x4A));
-			tmpbyte = readb(DEVADDR(0x4A));
-		case 0x11:
-		case 0x21:
+	writeb(0, addr + 0xB4);
+	writeb(0, addr + 0xF4);
+	tmpbyte = readb(addr + 0x4A);
+
+	switch(tmpbyte & 0x30) {
+		case 0x00:
+			/* In 100 MHz clocking, try and switch to 133 */
+			writeb(tmpbyte|0x10, addr + 0x4A);
 			break;
-		default:
-			tmpbyte &= ~0x30;
-			tmpbyte |= 0x20;
-			writeb(tmpbyte, DEVADDR(0x4A));
+		case 0x10:
+			/* On 133Mhz clocking */
+			break;
+		case 0x20:
+			/* On PCIx2 clocking */
+			break;
+		case 0x30:
+			/* Clocking is disabled */
+			/* 133 clock attempt to force it on */
+			writeb(tmpbyte & ~0x20, addr + 0x4A);
 			break;
 	}
 	
-	writeb(0x72, DEVADDR(0xA1));
-	writew(0x328A, DEVADDR(0xA2));
-	writel(0x62DD62DD, DEVADDR(0xA4));
-	writel(0x43924392, DEVADDR(0xA8));
-	writel(0x40094009, DEVADDR(0xAC));
-	writeb(0x72, DEVADDR(0xE1));
-	writew(0x328A, DEVADDR(0xE2));
-	writel(0x62DD62DD, DEVADDR(0xE4));
-	writel(0x43924392, DEVADDR(0xE8));
-	writel(0x40094009, DEVADDR(0xEC));
-
-	if (dev->device == PCI_DEVICE_ID_SII_3112) {
-		writel(0xFFFF0000, DEVADDR(0x108));
-		writel(0xFFFF0000, DEVADDR(0x188));
-		writel(0x00680000, DEVADDR(0x148));
-		writel(0x00680000, DEVADDR(0x1C8));
+	writeb(      0x72, addr + 0xA1);
+	writew(    0x328A, addr + 0xA2);
+	writel(0x62DD62DD, addr + 0xA4);
+	writel(0x43924392, addr + 0xA8);
+	writel(0x40094009, addr + 0xAC);
+	writeb(      0x72, addr + 0xE1);
+	writew(    0x328A, addr + 0xE2);
+	writel(0x62DD62DD, addr + 0xE4);
+	writel(0x43924392, addr + 0xE8);
+	writel(0x40094009, addr + 0xEC);
+
+	if (pdev_is_sata(dev)) {
+		writel(0xFFFF0000, addr + 0x108);
+		writel(0xFFFF0000, addr + 0x188);
+		writel(0x00680000, addr + 0x148);
+		writel(0x00680000, addr + 0x1C8);
 	}
 
-	tmpbyte = readb(DEVADDR(0x4A));
+	tmpbyte = readb(addr + 0x4A);
 
-	proc_reports_siimage(dev, (tmpbyte>>=4), name);
+	proc_reports_siimage(dev, (tmpbyte>>4), name);
 	return 1;
 }
 
+/**
+ *	init_chipset_siimage	-	set up an SI device
+ *	@dev: PCI device
+ *	@name: device name
+ *
+ *	Perform the initial PCI set up for this device. Attempt to switch
+ *	to 133MHz clocking if the system isn't already set up to do it.
+ */
+
 static unsigned int __init init_chipset_siimage (struct pci_dev *dev, const char *name)
 {
 	u32 class_rev	= 0;
@@ -606,139 +910,150 @@ static unsigned int __init init_chipset_
 	pci_write_config_byte(dev, 0x80, 0x00);
 	pci_write_config_byte(dev, 0x84, 0x00);
 	pci_read_config_byte(dev, 0x8A, &tmpbyte);
-	switch(tmpbyte) {
+	switch(tmpbyte & 0x30) {
 		case 0x00:
-		case 0x01:
 			/* 133 clock attempt to force it on */
 			pci_write_config_byte(dev, 0x8A, tmpbyte|0x10);
-			pci_read_config_byte(dev, 0x8A, &tmpbyte);
 		case 0x30:
-		case 0x31:
 			/* if clocking is disabled */
 			/* 133 clock attempt to force it on */
 			pci_write_config_byte(dev, 0x8A, tmpbyte & ~0x20);
-			pci_read_config_byte(dev, 0x8A, &tmpbyte);
 		case 0x10:
-		case 0x11:
-		case 0x20:
-		case 0x21:
+			/* 133 already */
 			break;
-		default:
-			tmpbyte &= ~0x30;
-			tmpbyte |= 0x20;
-			pci_write_config_byte(dev, 0x8A, tmpbyte);
+		case 0x20:
+			/* BIOS set PCI x2 clocking */
 			break;
 	}
 
-	pci_read_config_byte(dev, 0x8A, &tmpbyte);
-	pci_write_config_byte(dev, 0xA1, 0x72);
-	pci_write_config_word(dev, 0xA2, 0x328A);
+	pci_read_config_byte(dev,   0x8A, &tmpbyte);
+
+	pci_write_config_byte(dev,  0xA1, 0x72);
+	pci_write_config_word(dev,  0xA2, 0x328A);
 	pci_write_config_dword(dev, 0xA4, 0x62DD62DD);
 	pci_write_config_dword(dev, 0xA8, 0x43924392);
 	pci_write_config_dword(dev, 0xAC, 0x40094009);
-	pci_write_config_byte(dev, 0xB1, 0x72);
-	pci_write_config_word(dev, 0xB2, 0x328A);
+	pci_write_config_byte(dev,  0xB1, 0x72);
+	pci_write_config_word(dev,  0xB2, 0x328A);
 	pci_write_config_dword(dev, 0xB4, 0x62DD62DD);
 	pci_write_config_dword(dev, 0xB8, 0x43924392);
 	pci_write_config_dword(dev, 0xBC, 0x40094009);
 
-	pci_read_config_byte(dev, 0x8A, &tmpbyte);
-	proc_reports_siimage(dev, (tmpbyte>>=4), name);
+	proc_reports_siimage(dev, (tmpbyte>>4), name);
 	return 0;
 }
 
+/**
+ *	init_mmio_iops_siimage	-	set up the iops for MMIO
+ *	@hwif: interface to set up
+ *
+ *	The basic setup here is fairly simple, we can use standard MMIO
+ *	operations. However we do have to set the taskfile register offsets
+ *	by hand as there isnt a standard defined layout for them this
+ *	time.
+ *
+ *	The hardware supports buffered taskfiles and also some rather nice
+ *	extended PRD tables. Unfortunately right now we don't.
+ */
+ 
 static void __init init_mmio_iops_siimage (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
-	unsigned long addr	= (unsigned long) pci_get_drvdata(hwif->pci_dev);
+	void *addr		= pci_get_drvdata(dev);
 	u8 ch			= hwif->channel;
-//	u16 i			= 0;
-	hw_regs_t hw;
+	hw_regs_t		hw;
+	unsigned long		base;
+
+	/*
+	 *	Fill in the basic HWIF bits
+	 */
 
 	default_hwif_mmiops(hwif);
+	hwif->hwif_data			= addr;
+
+	/*
+	 *	Now set up the hw. We have to do this ourselves as
+	 *	the MMIO layout isnt the same as the the standard port
+	 *	based I/O
+	 */
+	 
 	memset(&hw, 0, sizeof(hw_regs_t));
+	hw.priv				= addr;
 
-#if 1
-#ifdef SIIMAGE_BUFFERED_TASKFILE
-	hw.io_ports[IDE_DATA_OFFSET]	= DEVADDR((ch) ? 0xD0 : 0x90);
-	hw.io_ports[IDE_ERROR_OFFSET]	= DEVADDR((ch) ? 0xD1 : 0x91);
-	hw.io_ports[IDE_NSECTOR_OFFSET]	= DEVADDR((ch) ? 0xD2 : 0x92);
-	hw.io_ports[IDE_SECTOR_OFFSET]	= DEVADDR((ch) ? 0xD3 : 0x93);
-	hw.io_ports[IDE_LCYL_OFFSET]	= DEVADDR((ch) ? 0xD4 : 0x94);
-	hw.io_ports[IDE_HCYL_OFFSET]	= DEVADDR((ch) ? 0xD5 : 0x95);
-	hw.io_ports[IDE_SELECT_OFFSET]	= DEVADDR((ch) ? 0xD6 : 0x96);
-	hw.io_ports[IDE_STATUS_OFFSET]	= DEVADDR((ch) ? 0xD7 : 0x97);
-	hw.io_ports[IDE_CONTROL_OFFSET]	= DEVADDR((ch) ? 0xDA : 0x9A);
-#else /* ! SIIMAGE_BUFFERED_TASKFILE */
-	hw.io_ports[IDE_DATA_OFFSET]	= DEVADDR((ch) ? 0xC0 : 0x80);
-	hw.io_ports[IDE_ERROR_OFFSET]	= DEVADDR((ch) ? 0xC1 : 0x81);
-	hw.io_ports[IDE_NSECTOR_OFFSET]	= DEVADDR((ch) ? 0xC2 : 0x82);
-	hw.io_ports[IDE_SECTOR_OFFSET]	= DEVADDR((ch) ? 0xC3 : 0x83);
-	hw.io_ports[IDE_LCYL_OFFSET]	= DEVADDR((ch) ? 0xC4 : 0x84);
-	hw.io_ports[IDE_HCYL_OFFSET]	= DEVADDR((ch) ? 0xC5 : 0x85);
-	hw.io_ports[IDE_SELECT_OFFSET]	= DEVADDR((ch) ? 0xC6 : 0x86);
-	hw.io_ports[IDE_STATUS_OFFSET]	= DEVADDR((ch) ? 0xC7 : 0x87);
-	hw.io_ports[IDE_CONTROL_OFFSET]	= DEVADDR((ch) ? 0xCA : 0x8A);
-#endif /* SIIMAGE_BUFFERED_TASKFILE */
-#else
-#ifdef SIIMAGE_BUFFERED_TASKFILE
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		hw.io_ports[i] = DEVADDR((ch) ? 0xD0 : 0x90)|(i);
-	hw.io_ports[IDE_CONTROL_OFFSET] = DEVADDR((ch) ? 0xDA : 0x9A);
-#else /* ! SIIMAGE_BUFFERED_TASKFILE */
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		hw.io_ports[i] = DEVADDR((ch) ? 0xC0 : 0x80)|(i);
-	hw.io_ports[IDE_CONTROL_OFFSET] = DEVADDR((ch) ? 0xCA : 0x8A);
-#endif /* SIIMAGE_BUFFERED_TASKFILE */
-#endif
+	base				= (unsigned long)addr;
+	if(ch)
+		base += 0xC0;
+	else
+		base += 0x80;
 
-#if 0
-	printk(KERN_DEBUG "%s: ", hwif->name);
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		printk("0x%08x ", DEVADDR((ch) ? 0xC0 : 0x80)|(i));
-	printk("0x%08x ", DEVADDR((ch) ? 0xCA : 0x8A)|(i));
-#endif
+	/*
+	 *	The buffered task file doesn't have status/control
+	 *	so we can't currently use it sanely since we want to
+	 *	use LBA48 mode.
+	 */	
+//	base += 0x10;
+//	hwif->no_lba48 = 1;
+
+	hw.io_ports[IDE_DATA_OFFSET]	= base;
+	hw.io_ports[IDE_ERROR_OFFSET]	= base + 1;
+	hw.io_ports[IDE_NSECTOR_OFFSET]	= base + 2;
+	hw.io_ports[IDE_SECTOR_OFFSET]	= base + 3;
+	hw.io_ports[IDE_LCYL_OFFSET]	= base + 4;
+	hw.io_ports[IDE_HCYL_OFFSET]	= base + 5;
+	hw.io_ports[IDE_SELECT_OFFSET]	= base + 6;
+	hw.io_ports[IDE_STATUS_OFFSET]	= base + 7;
+	hw.io_ports[IDE_CONTROL_OFFSET]	= base + 10;
 
 	hw.io_ports[IDE_IRQ_OFFSET]	= 0;
 
-        if (dev->device == PCI_DEVICE_ID_SII_3112) {
-		hw.sata_scr[SATA_STATUS_OFFSET]	= DEVADDR((ch) ? 0x184 : 0x104);
-		hw.sata_scr[SATA_ERROR_OFFSET]	= DEVADDR((ch) ? 0x188 : 0x108);
-		hw.sata_scr[SATA_CONTROL_OFFSET]= DEVADDR((ch) ? 0x180 : 0x100);
-		hw.sata_misc[SATA_MISC_OFFSET]	= DEVADDR((ch) ? 0x1C0 : 0x140);
-		hw.sata_misc[SATA_PHY_OFFSET]	= DEVADDR((ch) ? 0x1C4 : 0x144);
-		hw.sata_misc[SATA_IEN_OFFSET]	= DEVADDR((ch) ? 0x1C8 : 0x148);
+        if (pdev_is_sata(dev)) {
+        	base = (unsigned long) addr;
+        	if(ch)
+        		base += 0x80;
+		hw.sata_scr[SATA_STATUS_OFFSET]	= base + 0x104;
+		hw.sata_scr[SATA_ERROR_OFFSET]	= base + 0x108;
+		hw.sata_scr[SATA_CONTROL_OFFSET]= base + 0x100;
+		hw.sata_misc[SATA_MISC_OFFSET]	= base + 0x140;
+		hw.sata_misc[SATA_PHY_OFFSET]	= base + 0x144;
+		hw.sata_misc[SATA_IEN_OFFSET]	= base + 0x148;
 	}
 
-	hw.priv				= (void *) addr;
-//	hw.priv				= pci_get_drvdata(hwif->pci_dev);
 	hw.irq				= hwif->pci_dev->irq;
 
 	memcpy(&hwif->hw, &hw, sizeof(hw));
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
 
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_SII_3112) {
+	if (is_sata(hwif)) {
 		memcpy(hwif->sata_scr, hwif->hw.sata_scr, sizeof(hwif->hw.sata_scr));
 		memcpy(hwif->sata_misc, hwif->hw.sata_misc, sizeof(hwif->hw.sata_misc));
 	}
 
-#ifdef SIIMAGE_BUFFERED_TASKFILE
-	hwif->no_lba48 = 1;
-#endif /* SIIMAGE_BUFFERED_TASKFILE */
 	hwif->irq			= hw.irq;
-	hwif->hwif_data			= pci_get_drvdata(hwif->pci_dev);
+
+       	base = (unsigned long) addr;
 
 #ifdef SIIMAGE_LARGE_DMA
-	hwif->dma_base			= DEVADDR((ch) ? 0x18 : 0x10);
-	hwif->dma_base2			= DEVADDR((ch) ? 0x08 : 0x00);
-	hwif->dma_prdtable		= (hwif->dma_base2 + 4);
+/* Watch the brackets - even Ken and Dennis get some language design wrong */
+	hwif->dma_base			= base + (ch ? 0x18 : 0x10);
+	hwif->dma_base2			= base + (ch ? 0x08 : 0x00);
+	hwif->dma_prdtable		= hwif->dma_base2 + 4;
 #else /* ! SIIMAGE_LARGE_DMA */
-	hwif->dma_base			= DEVADDR((ch) ? 0x08 : 0x00);
-	hwif->dma_base2			= DEVADDR((ch) ? 0x18 : 0x10);
+	hwif->dma_base			= base + (ch ? 0x08 : 0x00);
+	hwif->dma_base2			= base + (ch ? 0x18 : 0x10);
 #endif /* SIIMAGE_LARGE_DMA */
-	hwif->mmio			= 1;
+	hwif->mmio			= 2;
 }
 
+/**
+ *	init_iops_siimage	-	set up iops
+ *	@hwif: interface to set up
+ *
+ *	Do the basic setup for the SIIMAGE hardware interface
+ *	and then do the MMIO setup if we can. This is the first
+ *	look in we get for setting up the hwif so that we
+ *	can get the iops right before using them.
+ */
+ 
 static void __init init_iops_siimage (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -746,37 +1061,60 @@ static void __init init_iops_siimage (id
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
+	
+	hwif->hwif_data = 0;
 
 	hwif->rqsize = 128;
-	if ((dev->device == PCI_DEVICE_ID_SII_3112) && (!(class_rev)))
-		hwif->rqsize = 16;
+	if (is_sata(hwif))
+		hwif->rqsize = 15;
 
 	if (pci_get_drvdata(dev) == NULL)
 		return;
 	init_mmio_iops_siimage(hwif);
 }
 
+/**
+ *	ata66_siimage	-	check for 80 pin cable
+ *	@hwif: interface to check
+ *
+ *	Check for the presence of an ATA66 capable cable on the
+ *	interface.
+ */
+ 
 static unsigned int __init ata66_siimage (ide_hwif_t *hwif)
 {
+	unsigned long addr = siimage_selreg(hwif, 0);
 	if (pci_get_drvdata(hwif->pci_dev) == NULL) {
 		u8 ata66 = 0;
-		pci_read_config_byte(hwif->pci_dev, SELREG(0), &ata66);
+		pci_read_config_byte(hwif->pci_dev, addr, &ata66);
 		return (ata66 & 0x01) ? 1 : 0;
 	}
 
-	return (hwif->INB(SELADDR(0)) & 0x01) ? 1 : 0;
+	return (hwif->INB(addr) & 0x01) ? 1 : 0;
 }
 
+/**
+ *	init_hwif_siimage	-	set up hwif structs
+ *	@hwif: interface to set up
+ *
+ *	We do the basic set up of the interface structure. The SIIMAGE
+ *	requires several custom handlers so we override the default
+ *	ide DMA handlers appropriately
+ */
+ 
 static void __init init_hwif_siimage (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
-	hwif->busproc   = &siimage_busproc;
+	
 	hwif->resetproc = &siimage_reset;
 	hwif->speedproc = &siimage_tune_chipset;
 	hwif->tuneproc	= &siimage_tuneproc;
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 
+	if(is_sata(hwif))
+		hwif->busproc   = &siimage_busproc;
+
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = 1;
 		hwif->drives[1].autotune = 1;
@@ -787,7 +1125,7 @@ static void __init init_hwif_siimage (id
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-	if (hwif->pci_dev->device != PCI_DEVICE_ID_SII_3112)
+	if (!is_sata(hwif))
 		hwif->atapi_dma = 1;
 
 	hwif->ide_dma_check = &siimage_config_drive_for_dma;
@@ -801,12 +1139,26 @@ static void __init init_hwif_siimage (id
 	} else {
 		hwif->ide_dma_test_irq = & siimage_io_ide_dma_test_irq;
 	}
-	if (!noautodma)
-		hwif->autodma = 1;
+	
+	/*
+	 *	The BIOS often doesn't set up DMA on this controller
+	 *	so we always do it.
+	 */
+
+	hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+/**
+ *	init_dma_siimage	-	set up IDE DMA
+ *	@hwif: interface
+ *	@dmabase: DMA base address to use
+ *	
+ *	For the SI chips this requires no special set up so we can just
+ *	let the IDE DMA core do the usual work.
+ */
+ 
 static void __init init_dma_siimage (ide_hwif_t *hwif, unsigned long dmabase)
 {
 	ide_setup_dma(hwif, dmabase, 8);
@@ -815,6 +1167,15 @@ static void __init init_dma_siimage (ide
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 
+/**
+ *	siimage_init_one	-	pci layer discovery entry
+ *	@dev: PCI device
+ *	@id: ident table entry
+ *
+ *	Called by the PCI code when it finds an SI680 or SI3112 controller.
+ *	We then use the IDE PCI generic helper to do most of the work.
+ */
+ 
 static int __devinit siimage_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	ide_pci_device_t *d = &siimage_chipsets[id->driver_data];
@@ -828,6 +1189,7 @@ static int __devinit siimage_init_one(st
 static struct pci_device_id siimage_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 	{ 0, },
 };
 
@@ -850,6 +1212,6 @@ static void siimage_ide_exit(void)
 module_init(siimage_ide_init);
 module_exit(siimage_ide_exit);
 
-MODULE_AUTHOR("Andre Hedrick");
+MODULE_AUTHOR("Andre Hedrick, Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for SiI IDE");
 MODULE_LICENSE("GPL");
diff -puN drivers/ide/pci/siimage.h~ide-siimage-port drivers/ide/pci/siimage.h
--- linux-2.6.0-test4-bk3/drivers/ide/pci/siimage.h~ide-siimage-port	2003-09-02 00:53:56.918629920 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/pci/siimage.h	2003-09-02 00:53:56.929628248 +0200
@@ -13,12 +13,6 @@
 #undef SIIMAGE_BUFFERED_TASKFILE
 #undef SIIMAGE_LARGE_DMA
 
-#if 0
-typedef struct ide_io_ops_s siimage_iops {
-
-}
-#endif
-
 #define SII_DEBUG 0
 
 #if SII_DEBUG
@@ -27,12 +21,6 @@ typedef struct ide_io_ops_s siimage_iops
 #define siiprintk(x...)
 #endif
 
-#define ADJREG(B,R)	((B)|(R)|((hwif->channel)<<(4+(2*(hwif->mmio)))))
-#define SELREG(R)	ADJREG((0xA0),(R))
-#define SELADDR(R)	((((unsigned long)hwif->hwif_data)*(hwif->mmio))|SELREG((R)))
-#define HWIFADDR(R)	((((unsigned long)hwif->hwif_data)*(hwif->mmio))|(R))
-#define DEVADDR(R)	(((unsigned long) pci_get_drvdata(dev))|(R))
-
 
 #if defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
@@ -85,6 +73,19 @@ static ide_pci_device_t siimage_chipsets
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
+	},{	/* 2 */
+		.vendor		= PCI_VENDOR_ID_CMD,
+		.device		= PCI_DEVICE_ID_SII_1210SA,
+		.name		= "Adaptec AAR-1210SA",
+		.init_chipset	= init_chipset_siimage,
+		.init_iops	= init_iops_siimage,
+		.init_hwif	= init_hwif_siimage,
+		.init_dma	= init_dma_siimage,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,
diff -puN include/linux/pci_ids.h~ide-siimage-port include/linux/pci_ids.h
--- linux-2.6.0-test4-bk3/include/linux/pci_ids.h~ide-siimage-port	2003-09-02 00:53:56.921629464 +0200
+++ linux-2.6.0-test4-bk3-root/include/linux/pci_ids.h	2003-09-02 00:53:56.931627944 +0200
@@ -878,6 +878,7 @@
 
 #define PCI_DEVICE_ID_SII_680		0x0680
 #define PCI_DEVICE_ID_SII_3112		0x3112
+#define PCI_DEVICE_ID_SII_1210SA	0x0240
 
 #define PCI_VENDOR_ID_VISION		0x1098
 #define PCI_DEVICE_ID_VISION_QD8500	0x0001

_

