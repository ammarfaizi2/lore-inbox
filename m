Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSFPSgk>; Sun, 16 Jun 2002 14:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSFPSgj>; Sun, 16 Jun 2002 14:36:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16652 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316499AbSFPSg1>; Sun, 16 Jun 2002 14:36:27 -0400
Message-ID: <3D0CDAA8.9090409@evision-ventures.com>
Date: Sun, 16 Jun 2002 20:36:24 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 ide 92
References: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070002090706050404090801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070002090706050404090801
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Fri Jun 14 15:32:38 CEST 2002 ide-clean-92

- Finally unify task_in_intr and task_mulin_intr. One crucial code path less to
   watch out, but a quite dangerous step in itself. PIO reading is functional
   again. The next step will be the unification of the write path of course.

- Introduce a small helper for the execution of task file commands which
   basically just send a simple command down to the drive.

- Add a buffer parameter to ide_raw_taskfile allowing to unify the handling of
   ioctl and normal ide_raw_taskfile request.

- Fix some small function pointer type mismatches.

Apply more host chip controller clenups by Bartlomiej:

- move setting drive->current_speed from *_tune_chipset()
	  to ide_config_drive_speed()

cmd64x.c:
	- convert cmd64x_tuneproc() to use ata-timing library
	- clean cmd64x_tune_chipset() and cmd680_tune_chipset()

hpt366.c:
	- remove empty timings table

it8172.c:
	- kill prototypes
	- update to new udma_setup() scheme

+ misc cleanups

--------------070002090706050404090801
Content-Type: text/plain;
 name="ide-clean-92.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-92.diff"

diff -urN linux-2.5.21/arch/i386/kernel/dmi_scan.c linux/arch/i386/kernel/dmi_scan.c
--- linux-2.5.21/arch/i386/kernel/dmi_scan.c	2002-06-09 07:29:00.000000000 +0200
+++ linux/arch/i386/kernel/dmi_scan.c	2002-06-16 01:39:27.000000000 +0200
@@ -185,28 +185,6 @@
 #define NO_MATCH	{ NONE, NULL}
 #define MATCH(a,b)	{ a, b }
 
-/*
- *	We have problems with IDE DMA on some platforms. In paticular the
- *	KT7 series. On these it seems the newer BIOS has fixed them. The
- *	rule needs to be improved to match specific BIOS revisions with
- *	corruption problems
- */ 
- 
-#if 0
-static __init int disable_ide_dma(struct dmi_blacklist *d)
-{
-#ifdef CONFIG_BLK_DEV_IDE
-	extern int noautodma;
-	if(noautodma == 0)
-	{
-		noautodma = 1;
-		printk(KERN_INFO "%s series board detected. Disabling IDE DMA.\n", d->ident);
-	}
-#endif	
-	return 0;
-}
-#endif
-
 /* 
  * Reboot options and system auto-detection code provided by
  * Dell Computer Corporation so their systems "just work". :-)
@@ -511,12 +489,6 @@
  */
  
 static __initdata struct dmi_blacklist dmi_blacklist[]={
-#if 0
-	{ disable_ide_dma, "KT7", {	/* Overbroad right now - kill DMA on problem KT7 boards */
-			MATCH(DMI_PRODUCT_NAME, "KT7-RAID"),
-			NO_MATCH, NO_MATCH, NO_MATCH
-			} },
-#endif			
 	{ broken_ps2_resume, "Dell Latitude C600", {	/* Handle problems with APM on the C600 */
 			MATCH(DMI_SYS_VENDOR, "Dell"),
 			MATCH(DMI_PRODUCT_NAME, "Latitude C600"),
diff -urN linux-2.5.21/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.21/drivers/ide/aec62xx.c	2002-06-14 12:45:00.000000000 +0200
+++ linux/drivers/ide/aec62xx.c	2002-06-14 16:11:19.000000000 +0200
@@ -141,8 +141,6 @@
 	else
 		aec_set_speed_new(drive->channel->pci_dev, drive->dn, &t);
 
-	drive->current_speed = speed;
-
 	return 0;
 }
 
diff -urN linux-2.5.21/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.21/drivers/ide/alim15x3.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-06-14 16:11:27.000000000 +0200
@@ -53,6 +53,7 @@
 
 	t = ata_timing_data(pio);
 
+	/* FIXME: use generic ata-timing library  --bkz */
 	s_time = t->setup;
 	a_time = t->active;
 	if ((s_clc = (s_time * system_bus_speed + 999999) / 1000000) >= 8)
@@ -171,8 +172,6 @@
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-	drive->current_speed = speed;
-
 	return ide_config_drive_speed(drive, speed);
 }
 
diff -urN linux-2.5.21/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.21/drivers/ide/amd74xx.c	2002-06-09 07:30:30.000000000 +0200
+++ linux/drivers/ide/amd74xx.c	2002-06-14 16:11:19.000000000 +0200
@@ -153,8 +153,6 @@
 
 	amd_set_speed(drive->channel->pci_dev, drive->dn, &t);
 
-	drive->current_speed = speed;
-
 	return 0;
 }
 
diff -urN linux-2.5.21/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.21/drivers/ide/cmd64x.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-06-14 16:11:27.000000000 +0200
@@ -156,26 +156,27 @@
  * 8: prefetch off, 9: prefetch on, 255: auto-select best mode.
  * Called with 255 at boot time.
  */
-static void cmd64x_tuneproc(struct ata_device *drive, byte mode_wanted)
+static void cmd64x_tuneproc(struct ata_device *drive, u8 pio)
 {
-	int recovery_time, clock_time;
-	u8 recovery_count2, cycle_count, speed;
-	int setup_count, active_count, recovery_count;
+	int T;
+	u8 speed, active, recover;
 	struct ata_timing *t;
 
-	switch (mode_wanted) {
+	switch (pio) {
+		/* FIXME: b0rken  --bkz */
 		case 8: /* set prefetch off */
 		case 9: /* set prefetch on */
-			mode_wanted &= 1;
+			pio &= 1;
 			/*set_prefetch_mode(index, mode_wanted);*/
-			cmdprintk("%s: %sabled cmd640 prefetch\n", drive->name, mode_wanted ? "en" : "dis");
+			cmdprintk("%s: %sabled cmd640 prefetch\n", drive->name,
+				  pio ? "en" : "dis");
 			return;
 	}
 
-	if (mode_wanted == 255)
+	if (pio == 255)
 		speed = ata_best_pio_mode(drive);
 	else
-		speed = XFER_PIO_0 + min_t(u8, mode_wanted, 4);
+		speed = XFER_PIO_0 + min_t(u8, pio, 4);
 
 	t = ata_timing_data(speed);
 
@@ -183,24 +184,21 @@
 	 * I copied all this complicated stuff from cmd640.c and made a few minor changes.
 	 * For now I am just going to pray that it is correct.
 	 */
-	/* FIXME: try to use generic ata-timings library  --bkz */
+	/* FIXME: verify it  --bkz */
+
+	T = 1000000000 / system_bus_speed;
+	ata_timing_quantize(t, t, T, T);
 
-	recovery_time = t->cycle - (t->setup + t->active);
-	clock_time = 1000000 / system_bus_speed;
-	cycle_count = (t->cycle + clock_time - 1) / clock_time;
-	setup_count = (t->setup + clock_time - 1) / clock_time;
-	active_count = (t->active + clock_time - 1) / clock_time;
-
-	recovery_count = (recovery_time + clock_time - 1) / clock_time;
-	recovery_count2 = cycle_count - (setup_count + active_count);
-	if (recovery_count2 > recovery_count)
-		recovery_count = recovery_count2;
-	if (recovery_count > 16) {
-		active_count += recovery_count - 16;
-		recovery_count = 16;
+	/* FIXME: maybe switch to ata_timing_compute()  --bkz */
+	recover = t->cycle - (t->setup + t->active);
+	active = t->active;
+
+	if (recover > 16) {
+		active += recover - 16;
+		recover = 16;
 	}
-	if (active_count > 16)
-		active_count = 16; /* maximum allowed by cmd646 */
+	if (active > 16)
+		active = 16;	/* maximum allowed by CMD646 */
 
 	/*
 	 * In a perfect world, we might set the drive pio mode here
@@ -210,13 +208,12 @@
 	 *	1) this is the wrong place to do it (proper is do_special() in ide.c)
 	 * 	2) in practice this is rarely, if ever, necessary
 	 */
-	program_drive_counts (drive, setup_count, active_count, recovery_count);
+	program_drive_counts(drive, t->setup, active, recover);
 
 	cmdprintk("%s: selected cmd646 PIO mode%d : %d (%dns), clocks=%d/%d/%d\n",
-		drive->name, t.mode - XFER_PIO_0, mode_wanted, cycle_time,
-		setup_count, active_count, recovery_count);
+		drive->name, t.mode - XFER_PIO_0, pio, t->cycle,
+		t->setup, active, recover);
 
-	drive->current_speed = speed;
 	ide_config_drive_speed(drive, speed);
 }
 
@@ -237,7 +234,7 @@
 			break;
 		case PCI_DEVICE_ID_CMD_646:
 		{
-			unsigned int class_rev	= 0;
+			u32 class_rev;
 			pci_read_config_dword(dev,
 				PCI_CLASS_REVISION, &class_rev);
 			class_rev &= 0xff;
@@ -332,11 +329,10 @@
 
 	speed = XFER_PIO_0 + min_t(u8, pio, 4);
 
-	drive->current_speed = speed;
 	ide_config_drive_speed(drive, speed);
 }
 
-static int cmd64x_tune_chipset(struct ata_device *drive, byte speed)
+static int cmd64x_tune_chipset(struct ata_device *drive, u8 speed)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	struct ata_channel *hwif = drive->channel;
@@ -345,34 +341,40 @@
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 pciU			= (hwif->unit) ? UDIDETCR1 : UDIDETCR0;
 	u8 pciD			= (hwif->unit) ? BMIDESR1 : BMIDESR0;
-	u8 regU, regD;
+	u8 regU, regD, U = 0, D = 0;
 
 	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
 		return 1;
 
-	(void) pci_read_config_byte(dev, pciD, &regD);
-	(void) pci_read_config_byte(dev, pciU, &regU);
+	pci_read_config_byte(dev, pciD, &regD);
+	pci_read_config_byte(dev, pciU, &regU);
+
+	/* unit 1 - 01000000b	unit 0 - 00100000b */
 	regD &= ~(unit ? 0x40 : 0x20);
+
+	/* unit 1 - 11001010b	unit 0 - 00110101b */
 	regU &= ~(unit ? 0xCA : 0x35);
-	(void) pci_write_config_byte(dev, pciD, regD);
-	(void) pci_write_config_byte(dev, pciU, regU);
 
-	(void) pci_read_config_byte(dev, pciD, &regD);
-	(void) pci_read_config_byte(dev, pciU, &regU);
-	/* FIXME: get unit checking out of here  --bkz */
+	pci_write_config_byte(dev, pciD, regD);
+	pci_write_config_byte(dev, pciU, regU);
+
+	pci_read_config_byte(dev, pciD, &regD);
+	pci_read_config_byte(dev, pciU, &regU);
+
 	switch(speed) {
-		case XFER_UDMA_5:	regU |= (unit ? 0x0A : 0x05); break;
-		case XFER_UDMA_4:	regU |= (unit ? 0x4A : 0x15); break;
-		case XFER_UDMA_3:	regU |= (unit ? 0x8A : 0x25); break;
-		case XFER_UDMA_2:	regU |= (unit ? 0x42 : 0x11); break;
-		case XFER_UDMA_1:	regU |= (unit ? 0x82 : 0x21); break;
-		case XFER_UDMA_0:	regU |= (unit ? 0xC2 : 0x31); break;
-		case XFER_MW_DMA_2:	regD |= (unit ? 0x40 : 0x10); break;
-		case XFER_MW_DMA_1:	regD |= (unit ? 0x80 : 0x20); break;
-		case XFER_MW_DMA_0:	regD |= (unit ? 0xC0 : 0x30); break;
-		case XFER_SW_DMA_2:	regD |= (unit ? 0x40 : 0x10); break;
-		case XFER_SW_DMA_1:	regD |= (unit ? 0x80 : 0x20); break;
-		case XFER_SW_DMA_0:	regD |= (unit ? 0xC0 : 0x30); break;
+		/* FIXME: use tables  --bkz */
+		case XFER_UDMA_5:	U = 0x05; break;
+		case XFER_UDMA_4:	U = 0x15; break;
+		case XFER_UDMA_3:	U = 0x25; break;
+		case XFER_UDMA_2:	U = 0x11; break;
+		case XFER_UDMA_1:	U = 0x21; break;
+		case XFER_UDMA_0:	U = 0x31; break;
+		case XFER_MW_DMA_2:	D = 0x10; break;
+		case XFER_MW_DMA_1:	D = 0x20; break;
+		case XFER_MW_DMA_0:	D = 0x30; break;
+		case XFER_SW_DMA_2:	D = 0x10; break;
+		case XFER_SW_DMA_1:	D = 0x20; break;
+		case XFER_SW_DMA_0:	D = 0x30; break;
 #else
 	switch(speed) {
 #endif /* CONFIG_BLK_DEV_IDEDMA */
@@ -390,15 +392,22 @@
 
 	cmd64x_tuneproc(drive, 255);
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	(void) pci_write_config_byte(dev, pciU, regU);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
-	drive->current_speed = speed;
+	if (unit) {
+		if (speed >= XFER_UDMA_0)
+			regU |= (((U & 0xf0) << 2) | ((U & 0x0f) << 1));
+		else if (speed >= XFER_SW_DMA_0)
+			regD |= ((D & 0xf0) << 2);
+	} else {
+		regU |= U;
+		regD |= D;
+	}
+
+	pci_write_config_byte(dev, pciU, regU);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
 	regD |= (unit ? 0x40 : 0x20);
-	(void) pci_write_config_byte(dev, pciD, regD);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+	pci_write_config_byte(dev, pciD, regD);
+#endif
 
 	return ide_config_drive_speed(drive, speed);
 }
@@ -410,19 +419,20 @@
 	u8 addr_mask		= (hwif->unit) ? 0x84 : 0x80;
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 dma_pci, udma_pci;
-	u8 mode_pci, scsc;
+	u8 mode_pci, scsc, scsc_on = 0;
 	u16 ultra, multi;
 
         pci_read_config_byte(dev, addr_mask, &mode_pci);
 	pci_read_config_byte(dev, 0x8A, &scsc);
 
         switch (drive->dn) {
-		case 0: dma_pci = 0xA8; udma_pci = 0xAC; break;
-		case 1: dma_pci = 0xAA; udma_pci = 0xAE; break;
-		case 2: dma_pci = 0xB8; udma_pci = 0xBC; break;
-		case 3: dma_pci = 0xBA; udma_pci = 0xBE; break;
+		case 0: dma_pci = 0xA8; break;
+		case 1: dma_pci = 0xAA; break;
+		case 2: dma_pci = 0xB8; break;
+		case 3: dma_pci = 0xBA; break;
 		default: return 1;
 	}
+	udma_pci = dma_pci + 4;
 
 	pci_read_config_byte(dev, addr_mask, &mode_pci);
 	mode_pci &= ~((unit) ? 0x30 : 0x03);
@@ -434,46 +444,38 @@
 		pci_read_config_byte(dev, 0x8A, &scsc);
 	}
 
+	if (speed >= XFER_UDMA_0) {
+		ultra &= ~0x3F;
+		multi = 0x10C1;
+		scsc_on = ((scsc & 0x30) == 0x00) ? 1 : 0;
+	}
+
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 		case XFER_UDMA_6:
-			if ((scsc & 0x30) == 0x00)
+			if (scsc_on)
 				goto speed_break;
-			multi = 0x10C1;
-			ultra &= ~0x3F;
 			ultra |= 0x01;
 			break;
 speed_break :
 			speed = XFER_UDMA_5;
 		case XFER_UDMA_5:
-			multi = 0x10C1;
-			ultra &= ~0x3F;
-			ultra |= (((scsc & 0x30) == 0x00) ? 0x01 : 0x02);
+			ultra |= (scsc_on ? 0x01 : 0x02);
 			break;
 		case XFER_UDMA_4:
-			multi = 0x10C1;
-			ultra &= ~0x3F;
-			ultra |= (((scsc & 0x30) == 0x00) ? 0x02 : 0x03);
+			ultra |= (scsc_on ? 0x02 : 0x03);
 			break;
 		case XFER_UDMA_3:
-			multi = 0x10C1;
-			ultra &= ~0x3F;
-			ultra |= (((scsc & 0x30) == 0x00) ? 0x04 : 0x05);
+			ultra |= (scsc_on ? 0x04 : 0x05);
 			break;
 		case XFER_UDMA_2:
-			multi = 0x10C1;
-			ultra &= ~0x3F;
-			ultra |= (((scsc & 0x30) == 0x00) ? 0x05 : 0x07);
+			ultra |= (scsc_on ? 0x05 : 0x07);
 			break;
 		case XFER_UDMA_1:
-			multi = 0x10C1;
-			ultra &= ~0x3F;
-			ultra |= (((scsc & 0x30) == 0x00) ? 0x07 : 0x0B);
+			ultra |= (scsc_on ? 0x07 : 0x0B);
 			break;
 		case XFER_UDMA_0:
-			multi = 0x10C1;
-			ultra &= ~0x3F;
-			ultra |= (((scsc & 0x30) == 0x00) ? 0x0C : 0x0F);
+			ultra |= (scsc_on ? 0x0C : 0x0F);
 			break;
 		case XFER_MW_DMA_2:
 			multi = 0x10C1;
@@ -509,8 +511,6 @@
 	pci_write_config_word(dev, dma_pci, multi);
 	pci_write_config_word(dev, udma_pci, ultra);
 
-	drive->current_speed = speed;
-
 	return ide_config_drive_speed(drive, speed);
 }
 
@@ -520,11 +520,6 @@
 	int map;
 	u8 mode;
 
-	if (drive->type != ATA_DISK) {
-		cmdprintk("CMD64X: drive is not a disk at double check, inital check failed!!\n");
-		return 0;
-	}
-
 	if (udma)
 		map = cmd64x_ratemask(drive);
 	else
@@ -728,8 +723,8 @@
 
 static unsigned int cmd64x_pci_init(struct pci_dev *dev)
 {
-	unsigned char mrdmode;
-	unsigned int class_rev;
+	u8 mrdmode;
+	u32 class_rev;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
diff -urN linux-2.5.21/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.21/drivers/ide/Config.help	2002-06-14 12:45:00.000000000 +0200
+++ linux/drivers/ide/Config.help	2002-06-16 02:37:54.000000000 +0200
@@ -372,6 +372,8 @@
   HPT366 is an Ultra DMA chipset for ATA-66.
   HPT368 is an Ultra DMA chipset for ATA-66 RAID Based.
   HPT370 is an Ultra DMA chipset for ATA-100.
+  HPT372 is an Ultra DMA chipset for ATA-100.
+  HPT374 is an Ultra DMA chipset for ATA-100.
 
   This driver adds up to 4 more EIDE devices sharing a single
   interrupt.
diff -urN linux-2.5.21/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.21/drivers/ide/Config.in	2002-06-14 12:45:00.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-06-16 02:37:14.000000000 +0200
@@ -50,7 +50,7 @@
       dep_bool '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
       dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
       dep_mbool '      HPT34X AUTODMA support (EXPERMENTAL)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_EXPERIMENTAL
-      dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
+      dep_bool '    HPT36X/37X chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
       dep_bool '    Intel and Efar (SMsC) chipset support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
       if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
          dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
diff -urN linux-2.5.21/drivers/ide/cy82c693.c linux/drivers/ide/cy82c693.c
--- linux-2.5.21/drivers/ide/cy82c693.c	2002-06-14 12:45:05.000000000 +0200
+++ linux/drivers/ide/cy82c693.c	2002-06-14 16:11:27.000000000 +0200
@@ -204,7 +204,7 @@
 	data = IN_BYTE(CY82_DATA_PORT);
 
 	printk (KERN_INFO "%s (ch=%d, dev=%d): DMA mode is %d (single=%d)\n", drive->name, drive->channel->unit, drive->select.b.unit, (data&0x3), ((data>>2)&1));
-#endif /* CY82C693_DEBUG_LOGS */
+#endif
 
 	data = (byte)mode|(byte)(single<<2);
 
@@ -213,7 +213,7 @@
 
 #if CY82C693_DEBUG_INFO
 	printk (KERN_INFO "%s (ch=%d, dev=%d): set DMA mode to %d (single=%d)\n", drive->name, drive->channel->unit, drive->select.b.unit, mode, single);
-#endif /* CY82C693_DEBUG_INFO */
+#endif
 
 	/*
 	 * note: below we set the value for Bus Master IDE TimeOut Register
@@ -231,7 +231,7 @@
 
 #if CY82C693_DEBUG_INFO
 	printk (KERN_INFO "%s: Set IDE Bus Master TimeOut Register to 0x%X\n", drive->name, data);
-#endif /* CY82C693_DEBUG_INFO */
+#endif
 }
 
 /*
@@ -331,7 +331,7 @@
 
 #if CY82C693_DEBUG_INFO
 	printk (KERN_INFO "%s: Selected PIO mode %d\n", drive->name, pio);
-#endif /* CY82C693_DEBUG_INFO */
+#endif
 
         compute_clocks(pio, &pclk);  /* let's calc the values for this PIO mode */
 
diff -urN linux-2.5.21/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.21/drivers/ide/hpt34x.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-06-14 16:11:19.000000000 +0200
@@ -63,7 +63,6 @@
 		udma, pio, err);
 #endif
 
-	drive->current_speed = speed;
 	return ide_config_drive_speed(drive, speed);
 }
 
diff -urN linux-2.5.21/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.21/drivers/ide/hpt366.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-06-14 16:14:21.000000000 +0200
@@ -140,7 +140,7 @@
 	unsigned int	chipset_settings;
 };
 
-/* key for bus clock timings
+/* key for bus clock timings for HPT370
  * bit
  * 0:3    data_high_time. inactive time of DIOW_/DIOR_ for PIO and MW
  *        DMA. cycles = value + 1
@@ -409,26 +409,6 @@
 };
 
 #if 0
-static struct chipset_bus_clock_list_entry fifty_base_hpt374[] = {
-	{	XFER_UDMA_6,	},
-	{	XFER_UDMA_5,	},
-	{	XFER_UDMA_4,	},
-	{	XFER_UDMA_3,	},
-	{	XFER_UDMA_2,	},
-	{	XFER_UDMA_1,	},
-	{	XFER_UDMA_0,	},
-	{	XFER_MW_DMA_2,	},
-	{	XFER_MW_DMA_1,	},
-	{	XFER_MW_DMA_0,	},
-	{	XFER_PIO_4,	},
-	{	XFER_PIO_3,	},
-	{	XFER_PIO_2,	},
-	{	XFER_PIO_1,	},
-	{	XFER_PIO_0,	},
-	{	0,	}
-};
-#endif
-#if 0
 static struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
 	{	XFER_UDMA_6,	0x12406231	},	/* checkme */
 	{	XFER_UDMA_5,	0x12446231	},
@@ -678,21 +658,13 @@
 	} else {
                 hpt366_tune_chipset(drive, speed);
         }
-	drive->current_speed = speed;
+
 	return ide_config_drive_speed(drive, speed);
 }
 
 static void hpt3xx_tune_drive(struct ata_device *drive, u8 pio)
 {
-	u8 speed;
-	switch(pio) {
-		case 4:		speed = XFER_PIO_4;break;
-		case 3:		speed = XFER_PIO_3;break;
-		case 2:		speed = XFER_PIO_2;break;
-		case 1:		speed = XFER_PIO_1;break;
-		default:	speed = XFER_PIO_0;break;
-	}
-	(void) hpt3xx_tune_chipset(drive, speed);
+	(void) hpt3xx_tune_chipset(drive, XFER_PIO_0 + min_t(u8, pio, 4));
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
diff -urN linux-2.5.21/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.21/drivers/ide/ide.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-16 16:10:28.000000000 +0200
@@ -560,7 +560,7 @@
 		memset(&args, 0, sizeof(args));
 		args.taskfile.sector_count = drive->sect;
 		args.cmd = WIN_RESTORE;
-		ide_raw_taskfile(drive, &args);
+		ide_raw_taskfile(drive, &args, NULL);
 		printk(KERN_INFO "%s: done!\n", drive->name);
 	}
 
diff -urN linux-2.5.21/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.21/drivers/ide/ide-disk.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-16 19:29:02.000000000 +0200
@@ -93,61 +93,74 @@
 /*
  * Handler for command with PIO data-in phase.
  */
-static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
+static ide_startstop_t pio_in_intr(struct ata_device *drive, struct request *rq)
 {
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
-	int ret;
+	unsigned int msect;
 
 	spin_lock_irqsave(ch->lock, flags);
-
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT | DRQ_STAT)) {
+		if (drive->status & (ERR_STAT|DRQ_STAT)) {
 			spin_unlock_irqrestore(ch->lock, flags);
 
 			return ata_error(drive, rq, __FUNCTION__);
 		}
 
-		/* no data yet, so wait for another interrupt */
-		ata_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
+		if (!(drive->status & BUSY_STAT))
+			goto cont;
+	}
 
-		ret = ide_started;
-	} else {
+	msect = drive->mult_count;
+	do {
+		unsigned int nsect;
 
-		//	printk("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
+		if (drive->mult_count) {
+			nsect = rq->current_nr_sectors;
+			/* Don't try to transfer more sectors at once then one
+			 * multi sector command can swallow.
+			 */
+			if (nsect > msect)
+				nsect = msect;
+		} else {
+			nsect = rq->current_nr_sectors;
+			nsect = 1;
+		}
+
+//		printk("Read: rq->current_nr_sectors: %d %d %d\n", msect, nsect,  (int) rq->current_nr_sectors);
 		{
 			unsigned long flags;
 			char *buf;
 
 			buf = ide_map_rq(rq, &flags);
-			ata_read(drive, buf, SECTOR_WORDS);
+			ata_read(drive, buf, nsect * SECTOR_WORDS);
 			ide_unmap_rq(rq, buf, &flags);
 		}
 
-		/* First segment of the request is complete. note that this does not
-		 * necessarily mean that the entire request is done!! this is only true
-		 * if ata_end_request() returns 0.
+		/* Segment of the request is complete. note that this does not
+		 * necessarily mean that the entire request is done!! this is
+		 * only true if ata_end_request() returns 0.
 		 */
+
 		rq->errors = 0;
-		--rq->current_nr_sectors;
+		rq->current_nr_sectors -= nsect;
 
 		if (rq->current_nr_sectors <= 0) {
 			if (!__ata_end_request(drive, rq, 1, 0)) {
-			//		printk("Request Ended stat: %02x\n", drive->status);
 				spin_unlock_irqrestore(ch->lock, flags);
 
 				return ide_stopped;
 			}
 		}
+		msect -= nsect;
+	} while (msect > 0);
 
-		/* still data left to transfer */
-		ata_set_handler(drive, task_in_intr,  WAIT_CMD, NULL);
-
-		ret = ide_started;
-	}
+cont:
+	/* still data left to transfer */
+	ata_set_handler(drive, pio_in_intr,  WAIT_CMD, NULL);
 	spin_unlock_irqrestore(ch->lock, flags);
 
-	return ret;
+	return ide_started;
 }
 
 /*
@@ -190,77 +203,6 @@
 	return ret;
 }
 
-/*
- * Handler for command with Read Multiple
- */
-static ide_startstop_t task_mulin_intr(struct ata_device *drive, struct request *rq)
-{
-	unsigned long flags;
-	struct ata_channel *ch = drive->channel;
-	int ret;
-
-	spin_lock_irqsave(ch->lock, flags);
-	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT | DRQ_STAT)) {
-			spin_unlock_irqrestore(ch->lock, flags);
-
-			return ata_error(drive, rq, __FUNCTION__);
-		}
-
-		/* no data yet, so wait for another interrupt */
-		ata_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
-
-		ret = ide_started;
-	} else {
-		unsigned int msect;
-
-		/* (ks/hs): Fixed Multi-Sector transfer */
-		msect = drive->mult_count;
-
-		do {
-			unsigned int nsect;
-
-			nsect = rq->current_nr_sectors;
-			if (nsect > msect)
-				nsect = msect;
-
-#if 0
-			printk("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
-					buf, nsect, rq->current_nr_sectors);
-#endif
-			{
-				unsigned long flags;
-				char *buf;
-
-				buf = ide_map_rq(rq, &flags);
-				ata_read(drive, buf, nsect * SECTOR_WORDS);
-				ide_unmap_rq(rq, buf, &flags);
-			}
-
-			rq->errors = 0;
-			rq->current_nr_sectors -= nsect;
-
-			/* FIXME: this seems buggy */
-			if (rq->current_nr_sectors <= 0) {
-				if (!__ata_end_request(drive, rq, 1, 0)) {
-					spin_unlock_irqrestore(ch->lock, flags);
-
-					return ide_stopped;
-				}
-			}
-			msect -= nsect;
-		} while (msect);
-
-		/* more data left */
-		ata_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
-
-		ret = ide_started;
-	}
-	spin_unlock_irqrestore(ch->lock, flags);
-
-	return ret;
-}
-
 static ide_startstop_t task_mulout_intr(struct ata_device *drive, struct request *rq)
 {
 	unsigned long flags;
@@ -610,10 +552,10 @@
 			} else if (drive->using_dma) {
 				args.cmd = WIN_READDMA_EXT;
 			} else if (drive->mult_count) {
-				args.XXX_handler = task_mulin_intr;
+				args.XXX_handler = pio_in_intr;
 				args.cmd = WIN_MULTREAD_EXT;
 			} else {
-				args.XXX_handler = task_in_intr;
+				args.XXX_handler = pio_in_intr;
 				args.cmd = WIN_READ_EXT;
 			}
 		} else {
@@ -622,11 +564,10 @@
 			} else if (drive->using_dma) {
 				args.cmd = WIN_READDMA;
 			} else if (drive->mult_count) {
-				/* FIXME : Shouldn't this be task_mulin_intr?! */
-				args.XXX_handler = task_in_intr;
+				args.XXX_handler = pio_in_intr;
 				args.cmd = WIN_MULTREAD;
 			} else {
-				args.XXX_handler = task_in_intr;
+				args.XXX_handler = pio_in_intr;
 				args.cmd = WIN_READ;
 			}
 		}
@@ -673,6 +614,19 @@
 	return __do_request(drive, &args, rq);
 }
 
+/*
+ * Small helper function used to execute simple commands.
+ */
+static int simple_taskfile(struct ata_device *drive, u8 cmd)
+{
+	struct ata_taskfile args;
+
+	memset(&args, 0, sizeof(args));
+	args.cmd = cmd;
+
+	return ide_raw_taskfile(drive, &args, NULL);
+}
+
 static int idedisk_open(struct inode *inode, struct file *__fp, struct ata_device *drive)
 {
 	MOD_INC_USE_COUNT;
@@ -681,15 +635,11 @@
 
 		/*
 		 * Ignore the return code from door_lock, since the open() has
-		 * already succeeded once, and the door_lock is irrelevant at this
-		 * time.
+		 * already succeeded once, and the door_lock is irrelevant at
+		 * this time.
 		 */
 		if (drive->doorlocking) {
-			struct ata_taskfile args;
-
-			memset(&args, 0, sizeof(args));
-			args.cmd = WIN_DOORLOCK;
-			if (ide_raw_taskfile(drive, &args))
+			if (simple_taskfile(drive, WIN_DOORLOCK))
 				drive->doorlocking = 0;
 		}
 	}
@@ -699,30 +649,21 @@
 
 static int flush_cache(struct ata_device *drive)
 {
-	struct ata_taskfile args;
-
-	memset(&args, 0, sizeof(args));
+	u8 cmd;
 
 	if (drive->id->cfs_enable_2 & 0x2400)
-		args.cmd = WIN_FLUSH_CACHE_EXT;
+		cmd = WIN_FLUSH_CACHE_EXT;
 	else
-		args.cmd = WIN_FLUSH_CACHE;
+		cmd = WIN_FLUSH_CACHE;
 
-	return ide_raw_taskfile(drive, &args);
+	return simple_taskfile(drive, cmd);
 }
 
 static void idedisk_release(struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	if (drive->removable && !drive->usage) {
-		/* XXX I don't think this is up to the lowlevel drivers..  --hch */
-		invalidate_bdev(inode->i_bdev, 0);
-
 		if (drive->doorlocking) {
-			struct ata_taskfile args;
-
-			memset(&args, 0, sizeof(args));
-			args.cmd = WIN_DOORUNLOCK;
-			if (ide_raw_taskfile(drive, &args))
+			if (simple_taskfile(drive, WIN_DOORUNLOCK))
 				drive->doorlocking = 0;
 		}
 	}
@@ -769,7 +710,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETMULT;
-	if (!ide_raw_taskfile(drive, &args)) {
+	if (!ide_raw_taskfile(drive, &args, NULL)) {
 		/* all went well track this setting as valid */
 		drive->mult_count = arg;
 
@@ -798,7 +739,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	drive->wcache = arg;
 
@@ -807,11 +748,7 @@
 
 static int idedisk_standby(struct ata_device *drive)
 {
-	struct ata_taskfile args;
-
-	memset(&args, 0, sizeof(args));
-	args.cmd = WIN_STANDBYNOW1;
-	return ide_raw_taskfile(drive, &args);
+	return simple_taskfile(drive, WIN_STANDBYNOW1);
 }
 
 static int set_acoustic(struct ata_device *drive, int arg)
@@ -822,7 +759,7 @@
 	args.taskfile.feature = (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETFEATURES;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	drive->acoustic = arg;
 
@@ -942,7 +879,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -964,10 +901,9 @@
 
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(args));
-
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX_EXT;
-        ide_raw_taskfile(drive, &args);
+        ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -1005,7 +941,7 @@
 
 	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
 	args.cmd = WIN_SET_MAX;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, read new maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -1038,7 +974,7 @@
 	args.hobfile.high_cylinder = (addr_req >>= 8);
 	args.hobfile.device_head = 0x40;
 
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
diff -urN linux-2.5.21/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.21/drivers/ide/ide-pmac.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-06-14 16:38:47.000000000 +0200
@@ -341,21 +341,6 @@
 	}
 }
 
-#if 0
-/* This one could be later extended to handle CMD IDE and be used by some kind
- * of /proc interface. I want to be able to get the devicetree path of a block
- * device for yaboot configuration
- */
-struct device_node*
-pmac_ide_get_devnode(struct ata_device *drive)
-{
-	int i = pmac_ide_find(drive);
-	if (i < 0)
-		return NULL;
-	return pmac_ide[i].node;
-}
-#endif
-
 /* Setup timings for the selected drive (master/slave). I still need to verify if this
  * is enough, I beleive selectproc will be called whenever an IDE command is started,
  * but... */
@@ -1365,7 +1350,7 @@
 	 */
 	ix = pmac_ide_find(drive);
 	if (ix < 0)
-		return ide_started;
+		return ide_stopped;
 
 	dma = pmac_ide[ix].dma_regs;
 	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
diff -urN linux-2.5.21/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.21/drivers/ide/ide-taskfile.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-16 16:07:52.000000000 +0200
@@ -242,8 +242,9 @@
 /*
  * Invoked on completion of a special REQ_SPECIAL command.
  */
-ide_startstop_t ata_special_intr(struct ata_device *drive, struct
-		request *rq) {
+static ide_startstop_t special_intr(struct ata_device *drive,
+		struct request *rq)
+{
 
 	struct ata_taskfile *ar = rq->special;
 	ide_startstop_t ret = ide_stopped;
@@ -292,16 +293,18 @@
 	return ret;
 }
 
-int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar)
+int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar,
+		char *buffer)
 {
 	struct request req;
 
 	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-	ar->XXX_handler = ata_special_intr;
+	ar->XXX_handler = special_intr;
 
 	memset(&req, 0, sizeof(req));
 	req.flags = REQ_SPECIAL;
 	req.special = ar;
+	req.buffer = buffer;
 
 	return ide_do_drive_cmd(drive, &req, ide_wait);
 }
@@ -310,5 +313,4 @@
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
-EXPORT_SYMBOL(ata_special_intr);
 EXPORT_SYMBOL(ide_raw_taskfile);
diff -urN linux-2.5.21/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.21/drivers/ide/ioctl.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-16 16:10:51.000000000 +0200
@@ -47,7 +47,6 @@
 	u8 *argbuf = vals;
 	int argsize = 4;
 	struct ata_taskfile args;
-	struct request req;
 
 	/* Second phase.
 	 */
@@ -78,17 +77,7 @@
 		memset(argbuf + 4, 0, argsize - 4);
 	}
 
-	/* Issue ATA command and wait for completion.
-	 */
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-	args.XXX_handler = ata_special_intr;
-
-	memset(&req, 0, sizeof(req));
-	req.flags = REQ_SPECIAL;
-	req.special = &args;
-
-	req.buffer = argbuf + 4;
-	err = ide_do_drive_cmd(drive, &req, ide_wait);
+	err = ide_raw_taskfile(drive, &args, argbuf + 4);
 
 	argbuf[0] = drive->status;
 	argbuf[1] = args.taskfile.feature;
diff -urN linux-2.5.21/drivers/ide/it8172.c linux/drivers/ide/it8172.c
--- linux-2.5.21/drivers/ide/it8172.c	2002-06-09 07:26:58.000000000 +0200
+++ linux/drivers/ide/it8172.c	2002-06-14 16:11:27.000000000 +0200
@@ -45,21 +45,11 @@
 #include "ata-timing.h"
 #include "pcihost.h"
 
-/*
- * Prototypes
- */
-static void it8172_tune_drive (struct ata_device *drive, byte pio);
-#if defined(CONFIG_BLK_DEV_IDEDMA) && defined(CONFIG_IT8172_TUNING)
-static byte it8172_dma_2_pio (byte xfer_rate);
-static int it8172_tune_chipset (struct ata_device *drive, byte speed);
-static int it8172_config_chipset_for_dma (struct ata_device *drive);
-static int it8172_dmaproc(ide_dma_action_t func, struct ata_device *drive);
-#endif
-void __init ide_init_it8172(struct ata_channel *channel);
-
 
-static void it8172_tune_drive (struct ata_device *drive, byte pio)
+/* FIXME: fix locking  --bkz */
+static void it8172_tune_drive (struct ata_device *drive, u8 pio)
 {
+	struct pci_dev *dev = drive->channel->pci_dev;
     unsigned long flags;
     u16 drive_enables;
     u32 drive_timing;
@@ -70,8 +60,8 @@
 	else
 		pio = min_t(byte, pio, 4);
 
-    pci_read_config_word(drive->channel->pci_dev, master_port, &master_data);
-    pci_read_config_dword(drive->channel->pci_dev, slave_port, &slave_data);
+	pci_read_config_word(dev, master_port, &master_data);
+	pci_read_config_dword(dev, slave_port, &slave_data);
 
     /*
      * FIX! The DIOR/DIOW pulse width and recovery times in port 0x44
@@ -102,7 +92,7 @@
 
     save_flags(flags);
     cli();
-    pci_write_config_word(drive->channel->pci_dev, master_port, master_data);
+	pci_write_config_word(dev, master_port, master_data);
     restore_flags(flags);
 }
 
@@ -110,7 +100,7 @@
 /*
  *
  */
-static byte it8172_dma_2_pio (byte xfer_rate)
+static u8 it8172_dma_2_pio(u8 xfer_rate)
 {
     switch(xfer_rate) {
     case XFER_UDMA_5:
@@ -139,7 +129,7 @@
     }
 }
 
-static int it8172_tune_chipset (struct ata_device *drive, byte speed)
+static int it8172_tune_chipset(struct ata_device *drive, u8 speed)
 {
     struct ata_channel *hwif = drive->channel;
     struct pci_dev *dev	= hwif->pci_dev;
@@ -147,7 +137,7 @@
     int u_flag		= 1 << drive->dn;
     int u_speed		= 0;
     int err		= 0;
-    byte reg48, reg4a;
+	u8 reg48, reg4a;
 
     pci_read_config_byte(dev, 0x48, &reg48);
     pci_read_config_byte(dev, 0x4a, &reg4a);
@@ -187,52 +177,28 @@
 
     it8172_tune_drive(drive, it8172_dma_2_pio(speed));
 
-    err = ide_config_drive_speed(drive, speed);
-    drive->current_speed = speed;
-    return err;
+	return ide_config_drive_speed(drive, speed);
 }
 
-static int it8172_config_chipset_for_dma(struct ata_device *drive)
+static int it8172_udma_setup(struct ata_device *drive)
 {
-    struct hd_driveid *id = drive->id;
-    byte speed;
-
-    speed = ata_timing_mode(drive, XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA | XFER_UDMA);
+	u8 speed = ata_timing_mode(drive, XFER_PIO | XFER_EPIO |
+				   XFER_SWDMA | XFER_MWDMA | XFER_UDMA);
 
-    (void) it8172_tune_chipset(drive, speed);
-
-    return ((int)((id->dma_ultra >> 11) & 7) ? ide_dma_on :
-	    ((id->dma_ultra >> 8) & 7) ? ide_dma_on :
-	    ((id->dma_mword >> 8) & 7) ? ide_dma_on :
-	    ((id->dma_1word >> 8) & 7) ? ide_dma_on :
-	    ide_dma_off_quietly);
-}
-
-static int it8172_dmaproc(ide_dma_action_t func, struct ata_device *drive)
-{
-    switch (func) {
-    case ide_dma_check:
-	return ide_dmaproc((ide_dma_action_t)it8172_config_chipset_for_dma(drive),
-			   drive);
-    default :
-	break;
-    }
-    /* Other cases are done by generic IDE-DMA code. */
-    return ide_dmaproc(func, drive);
+	return !it8172_tune_chipset(drive, speed);
 }
-
 #endif /* defined(CONFIG_BLK_DEV_IDEDMA) && (CONFIG_IT8172_TUNING) */
 
 
-static unsigned int __init pci_init_it8172 (struct pci_dev *dev)
+static unsigned int __init pci_init_it8172(struct pci_dev *dev)
 {
-    unsigned char progif;
+	u8 progif;
 
     /*
      * Place both IDE interfaces into PCI "native" mode
      */
-    (void)pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
-    (void)pci_write_config_byte(dev, PCI_CLASS_PROG, progif | 0x05);
+	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
+	pci_write_config_byte(dev, PCI_CLASS_PROG, progif | 0x05);
 
     return IT8172_IDE_IRQ;
 }
diff -urN linux-2.5.21/drivers/ide/opti621.c linux/drivers/ide/opti621.c
--- linux-2.5.21/drivers/ide/opti621.c	2002-06-09 07:27:36.000000000 +0200
+++ linux/drivers/ide/opti621.c	2002-06-14 16:11:27.000000000 +0200
@@ -342,9 +342,8 @@
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(chipsets); ++i) {
+	for (i = 0; i < ARRAY_SIZE(chipsets); ++i)
 		ata_register_chipset(&chipsets[i]);
-	}
 
         return 0;
 }
diff -urN linux-2.5.21/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.21/drivers/ide/pcidma.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-14 17:26:36.000000000 +0200
@@ -415,7 +415,7 @@
  *
  * Channel lock should be held.
  */
-int udma_pci_start(struct ata_device *drive, struct request *rq)
+void udma_pci_start(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
 	unsigned long dma_base = ch->dma_base;
diff -urN linux-2.5.21/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.21/drivers/ide/pdc202xx.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-06-14 16:13:07.000000000 +0200
@@ -230,8 +230,6 @@
 	printk(KERN_DEBUG "DP(%x)\n", DP);
 #endif
 
-	drive->current_speed = speed;
-
 #if PDC202XX_DEBUG_DRIVE_INFO
 	printk("%s: %02x drive%d 0x%08x ",
 		drive->name, speed,
@@ -352,8 +350,6 @@
 			;
 	}
 
-	drive->current_speed = speed;
-
 	return ide_config_drive_speed(drive, speed);
 }
 
@@ -551,7 +547,7 @@
 	return 0;
 }
 
-static int pdc202xx_udma_start(struct ata_device *drive, struct request *rq)
+static void pdc202xx_udma_start(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
 	u32 high_16 = pci_resource_start(ch->pci_dev, 4);
diff -urN linux-2.5.21/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.21/drivers/ide/piix.c	2002-06-14 12:45:00.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-06-14 16:11:19.000000000 +0200
@@ -222,8 +222,6 @@
 
 	piix_set_speed(drive->channel->pci_dev, drive->dn, &t, umul);
 
-	drive->current_speed = speed;
-
 	return 0;
 }
 
diff -urN linux-2.5.21/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.21/drivers/ide/probe.c	2002-06-14 12:45:09.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-06-14 16:11:19.000000000 +0200
@@ -339,6 +339,8 @@
 		ata_irq_enable(drive, 1);
 	udelay(1);
 
+	/* FIXME: use ata_status_poll()  --bkz */
+
 	ata_busy_poll(drive, WAIT_CMD);
 
 	/*
@@ -395,6 +397,8 @@
 		default: break;
 	}
 
+	drive->current_speed = speed;
+
 	return error;
 }
 
diff -urN linux-2.5.21/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.21/drivers/ide/serverworks.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-06-14 16:11:27.000000000 +0200
@@ -123,23 +123,21 @@
 	return map;
 }
 
-static int svwks_tune_chipset(struct ata_device *drive, byte speed)
+static int svwks_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	static u8 dma_modes[]	= { 0x77, 0x21, 0x20 };
 	static u8 pio_modes[]	= { 0x5d, 0x47, 0x34, 0x22, 0x20 };
 
-	struct ata_channel *hwif = drive->channel;
-	struct pci_dev *dev	= hwif->pci_dev;
-	byte unit		= (drive->select.b.unit & 0x01);
-	byte csb5		= (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) ? 1 : 0;
-
-	byte drive_pci, drive_pci2;
-	byte drive_pci3	= hwif->unit ? 0x57 : 0x56;
+	struct ata_channel *ch = drive->channel;
+	struct pci_dev *dev = ch->pci_dev;
+	u8 unit = drive->select.b.unit & 0x01;
+	u8 drive_pci, drive_pci2;
+	u8 drive_pci3 = ch->unit ? 0x57 : 0x56;
 
-	byte ultra_enable, ultra_timing, dma_timing, pio_timing;
-	unsigned short csb5_pio;
+	u8 ultra_enable, ultra_timing, dma_timing, pio_timing;
+	u16 csb5_pio;
 
-	byte pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
+	u8 pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
         switch (drive->dn) {
 		case 0: drive_pci = 0x41; break;
@@ -213,7 +211,8 @@
 #endif
 
 	pci_write_config_byte(dev, drive_pci, pio_timing);
-	if (csb5)
+
+	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
 		pci_write_config_word(dev, 0x4A, csb5_pio);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -221,29 +220,20 @@
 	pci_write_config_byte(dev, drive_pci3, ultra_timing);
 	pci_write_config_byte(dev, 0x54, ultra_enable);
 #endif
-	drive->current_speed = speed;
 
 	return ide_config_drive_speed(drive, speed);
 }
 
-static void svwks_tune_drive(struct ata_device *drive, byte pio)
+static void svwks_tune_drive(struct ata_device *drive, u8 pio)
 {
-	byte speed;
-	switch(pio) {
-		case 4:		speed = XFER_PIO_4;break;
-		case 3:		speed = XFER_PIO_3;break;
-		case 2:		speed = XFER_PIO_2;break;
-		case 1:		speed = XFER_PIO_1;break;
-		default:	speed = XFER_PIO_0;break;
-	}
-	(void) svwks_tune_chipset(drive, speed);
+	(void) svwks_tune_chipset(drive, XFER_PIO_0 + min_t(u8, pio, 4));
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 static int config_chipset_for_dma(struct ata_device *drive)
 {
 	int map;
-	byte mode;
+	u8 mode;
 
 	/* FIXME: check SWDMA modes --bkz */
 	map = XFER_MWDMA | svwks_ratemask(drive);
@@ -354,7 +344,7 @@
 static unsigned int __init svwks_init_chipset(struct pci_dev *dev)
 {
 	unsigned int reg;
-	byte btr;
+	u8 btr;
 
 	/* save revision id to determine DMA capability */
 	pci_read_config_byte(dev, PCI_REVISION_ID, &svwks_revision);
@@ -404,8 +394,7 @@
 static unsigned int __init ata66_svwks_dell(struct ata_channel *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL &&
-	    dev->vendor	== PCI_VENDOR_ID_SERVERWORKS &&
+	if (dev->vendor == PCI_VENDOR_ID_SERVERWORKS &&
 	    (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE ||
 	     dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE))
 		return ((1 << (hwif->unit + 14)) &
@@ -422,8 +411,7 @@
 static unsigned int __init ata66_svwks_cobalt(struct ata_channel *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN &&
-	    dev->vendor	== PCI_VENDOR_ID_SERVERWORKS &&
+	if (dev->vendor == PCI_VENDOR_ID_SERVERWORKS &&
 	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
 		return ((1 << (hwif->unit + 14)) &
 			dev->subsystem_device) ? 1 : 0;
@@ -501,9 +489,8 @@
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(chipsets); ++i) {
+	for (i = 0; i < ARRAY_SIZE(chipsets); ++i)
 		ata_register_chipset(&chipsets[i]);
-	}
 
         return 0;
 }
diff -urN linux-2.5.21/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.21/drivers/ide/sis5513.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/sis5513.c	2002-06-14 16:11:27.000000000 +0200
@@ -267,7 +267,7 @@
 {
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev = hwif->pci_dev;
-	u8 drive_pci, test1, test2, speed;
+	u8 drive_pci, test1, test2;
 
 #ifdef DEBUG
 	sis5513_load_verify_registers(dev, "config_drive_art_rwp_pio start");
@@ -280,13 +280,10 @@
 	       drive->dn, pio, timing);
 #endif
 
-	switch(drive->dn) {
-		case 0:		drive_pci = 0x40; break;
-		case 1:		drive_pci = 0x42; break;
-		case 2:		drive_pci = 0x44; break;
-		case 3:		drive_pci = 0x46; break;
-		default:	return 1;
-	}
+	if (drive->dn > 3)	/* FIXME: remove this  --bkz */
+		return 1;
+
+	drive_pci = 0x40 + (drive->dn << 1);
 
 	/* register layout changed with newer ATA100 chips */
 	if (chipset_family < ATA_100) {
@@ -321,9 +318,8 @@
 #ifdef DEBUG
 	sis5513_load_verify_registers(dev, "config_drive_art_rwp_pio start");
 #endif
-	speed = XFER_PIO_0 + min_t(u8, pio, 4);
-	drive->current_speed = speed;
-	return ide_config_drive_speed(drive, speed);
+
+	return ide_config_drive_speed(drive, XFER_PIO_0 + min_t(u8, pio, 4));
 }
 
 static int sis5513_tune_chipset(struct ata_device *drive, u8 speed)
@@ -338,13 +334,11 @@
 	printk("SIS5513: sis5513_tune_chipset, drive %d, speed %d\n",
 	       drive->dn, speed);
 #endif
-	switch(drive->dn) {
-		case 0:		drive_pci = 0x40; break;
-		case 1:		drive_pci = 0x42; break;
-		case 2:		drive_pci = 0x44; break;
-		case 3:		drive_pci = 0x46; break;
-		default:	return 0;
-	}
+
+	if (drive->dn > 3)	/* FIXME: remove this  --bkz */
+		return 1;
+
+	drive_pci = 0x40 + (drive->dn << 1);
 
 #ifdef BROKEN_LEVEL
 #ifdef DEBUG
@@ -396,11 +390,10 @@
 		default:
 			return config_art_rwp_pio(drive, 0);
 	}
-	drive->current_speed = speed;
 #ifdef DEBUG
 	sis5513_load_verify_registers(dev, "sis5513_tune_chipset end");
 #endif
-	return ((int) ide_config_drive_speed(drive, speed));
+	return ide_config_drive_speed(drive, speed);
 }
 
 static void sis5513_tune_drive(struct ata_device *drive, u8 pio)
@@ -568,8 +561,8 @@
 
 static unsigned int __init ata66_sis5513(struct ata_channel *hwif)
 {
-	byte reg48h = 0, ata66 = 0;
-	byte mask = hwif->unit ? 0x20 : 0x10;
+	u8 reg48h, ata66 = 0;
+	u8 mask = hwif->unit ? 0x20 : 0x10;
 	pci_read_config_byte(hwif->pci_dev, 0x48, &reg48h);
 
 	if (chipset_family >= ATA_66) {
diff -urN linux-2.5.21/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.21/drivers/ide/tcq.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-14 17:21:37.000000000 +0200
@@ -430,7 +430,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = 0x01;
 	args.cmd = WIN_NOP;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 	if (args.taskfile.feature & ABRT_ERR)
 		return 1;
 
@@ -458,7 +458,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args)) {
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: failed to enable write cache\n", drive->name);
 		return 1;
 	}
@@ -470,7 +470,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_DIS_RI;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args)) {
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: disabling release interrupt fail\n", drive->name);
 		return 1;
 	}
@@ -482,7 +482,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_SI;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args)) {
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: enabling service interrupt fail\n", drive->name);
 		return 1;
 	}
diff -urN linux-2.5.21/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.21/drivers/ide/trm290.c	2002-06-14 16:02:00.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-06-14 17:27:37.000000000 +0200
@@ -176,7 +176,7 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int trm290_udma_start(struct ata_device *drive, struct request *__rq)
+static void trm290_udma_start(struct ata_device *drive, struct request *__rq)
 {
 	/* Nothing to be done here. */
 }
diff -urN linux-2.5.21/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.21/drivers/ide/via82cxxx.c	2002-06-09 07:31:19.000000000 +0200
+++ linux/drivers/ide/via82cxxx.c	2002-06-14 16:11:19.000000000 +0200
@@ -199,8 +199,6 @@
 
 	via_set_speed(drive->channel->pci_dev, drive->dn, &t);
 
-	drive->current_speed = speed;
-
 	return 0;
 }
 
diff -urN linux-2.5.21/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.21/include/linux/ide.h	2002-06-14 16:02:00.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-16 16:08:00.000000000 +0200
@@ -679,8 +679,7 @@
 		bio_kunmap_irq(to, flags);
 }
 
-extern ide_startstop_t ata_special_intr(struct ata_device *, struct request *);
-extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *);
+extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *, char *);
 
 extern void ide_fix_driveid(struct hd_driveid *id);
 extern int ide_config_drive_speed(struct ata_device *, byte);
@@ -784,7 +783,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 
 extern void udma_pci_enable(struct ata_device *drive, int on, int verbose);
-extern int udma_pci_start(struct ata_device *drive, struct request *rq);
+extern void udma_pci_start(struct ata_device *drive, struct request *rq);
 extern int udma_pci_stop(struct ata_device *drive);
 extern int udma_pci_init(struct ata_device *drive, struct request *rq);
 extern int udma_pci_irq_status(struct ata_device *drive);

--------------070002090706050404090801--

