Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310673AbSCHDvK>; Thu, 7 Mar 2002 22:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310676AbSCHDu5>; Thu, 7 Mar 2002 22:50:57 -0500
Received: from maillog.promise.com.tw ([210.244.60.166]:7417 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S310673AbSCHDul>; Thu, 7 Mar 2002 22:50:41 -0500
Message-ID: <015101c1c654$454cad10$59cca8c0@hank>
From: "Hank Yang" <hanky@promise.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>,
        "Linus Chen" <linusc@promise.com.tw>
In-Reply-To: <E16ixk4-0002D4-00@the-village.bc.nu>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Fri, 8 Mar 2002 11:49:37 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_014E_01C1C697.531D8750"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPart_000_014E_01C1C697.531D8750
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi, Alan.

    Thank you for yours efforts to support this patch code.
    I sent our patch file as attachment for you reference.

    I saw the 'patch-2.4.19-pre2-ac3' and it has build-in Maxtor 48 bit lba
spec. Is these patch will be build into next kernel version 2.4.19?
Do you want us to make a patch for the 'patch-2.4.19-pre2-ac3'?

Best Regards
Hank Yang


> > Kernel Version: linux kernel 2.4.18
>
> The big IDE update is going into 2.4.19pre. Thats going to overlap with
this
> patch I suspect. You might want to cross check with 2.4.19pre3 when it
> appears and see how much you can remove.
> Other than that it looks pretty sound. Your mailer seems to have messed
> the tabs up so once 19pre3 appears and you've had a look at it can you
> send me a copy as an attachment ?
>
> Thanks
> Alan

------=_NextPart_000_014E_01C1C697.531D8750
Content-Type: application/octet-stream;
	name="ultra-2.4.18-submitting-ready.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ultra-2.4.18-submitting-ready.patch"

diff -urN linux-2.4.18.org/drivers/ide/ide-disk.c =
linux/drivers/ide/ide-disk.c=0A=
--- linux-2.4.18.org/drivers/ide/ide-disk.c	Sat Dec 22 01:41:54 2001=0A=
+++ linux/drivers/ide/ide-disk.c	Wed Feb 27 23:54:46 2002=0A=
@@ -28,6 +28,11 @@=0A=
  *			added UDMA 3/4 reporting=0A=
  * Version 1.10		request queue changes, Ultra DMA 100=0A=
  */=0A=
+/*=0A=
+ * Support UltraDMA Mode 6 and 48 bit LBA Mode.=0A=
+ * Powered by PROMISE Technology, Inc. Portions Copyright (C)2001.=0A=
+ */=0A=
+#define PCI_VENDOR_ID_PROMISE	0x105a=0A=
 =0A=
 #define IDEDISK_VERSION	"1.10"=0A=
 =0A=
@@ -371,10 +376,22 @@=0A=
 		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);=0A=
 	OUT_BYTE(0x00, IDE_FEATURE_REG);=0A=
 	OUT_BYTE(rq->nr_sectors,IDE_NSECTOR_REG);=0A=
+	if ((drive->id->command_set_2 & 0x0400) && =
HWIF(drive)->pci_devid.vid=3D=3DPCI_VENDOR_ID_PROMISE) {=0A=
+		/* 48 bits data previous */=0A=
+		OUT_BYTE(rq->nr_sectors>>8, IDE_NSECTOR_REG);=0A=
+		OUT_BYTE(block>>24, IDE_SECTOR_REG);=0A=
+		OUT_BYTE(0x00, IDE_LCYL_REG);	//block only 32 bits=0A=
+		OUT_BYTE(0x00, IDE_HCYL_REG);=0A=
+		/* 48 bits data current */=0A=
+		OUT_BYTE(rq->nr_sectors, IDE_NSECTOR_REG);=0A=
+		OUT_BYTE(block, IDE_SECTOR_REG);=0A=
+		OUT_BYTE(block>>8, IDE_LCYL_REG);=0A=
+		OUT_BYTE(block>>16, IDE_HCYL_REG);=0A=
+		OUT_BYTE(drive->select.all,IDE_SELECT_REG);=0A=
 #ifdef CONFIG_BLK_DEV_PDC4030=0A=
-	if (drive->select.b.lba || IS_PDC4030_DRIVE) {=0A=
-#else /* !CONFIG_BLK_DEV_PDC4030 */=0A=
-	if (drive->select.b.lba) {=0A=
+	} else if (drive->select.b.lba || IS_PDC4030_DRIVE) {=0A=
+#else /* !CONFIG_BLK_DEV_PDC4030 */		=0A=
+	} else if (drive->select.b.lba) {=0A=
 #endif /* CONFIG_BLK_DEV_PDC4030 */=0A=
 #ifdef DEBUG=0A=
 		printk("%s: %sing: LBAsect=3D%ld, sectors=3D%ld, buffer=3D0x%08lx\n",=0A=
@@ -413,7 +430,10 @@=0A=
 			return ide_started;=0A=
 #endif /* CONFIG_BLK_DEV_IDEDMA */=0A=
 		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);=0A=
-		OUT_BYTE(drive->mult_count ? WIN_MULTREAD : WIN_READ, =
IDE_COMMAND_REG);=0A=
+		if ((drive->id->command_set_2 & 0x0400) && =
HWIF(drive)->pci_devid.vid=3D=3DPCI_VENDOR_ID_PROMISE)=0A=
+			OUT_BYTE(drive->mult_count ? MULTI_READ_EXT : READ_EXT, =
IDE_COMMAND_REG);=0A=
+		else=0A=
+			OUT_BYTE(drive->mult_count ? WIN_MULTREAD : WIN_READ, =
IDE_COMMAND_REG);=0A=
 		return ide_started;=0A=
 	}=0A=
 	if (rq->cmd =3D=3D WRITE) {=0A=
@@ -422,7 +442,11 @@=0A=
 		if (drive->using_dma && !(HWIF(drive)->dmaproc(ide_dma_write, drive)))=0A=
 			return ide_started;=0A=
 #endif /* CONFIG_BLK_DEV_IDEDMA */=0A=
-		OUT_BYTE(drive->mult_count ? WIN_MULTWRITE : WIN_WRITE, =
IDE_COMMAND_REG);=0A=
+		/* out 48 bits R/W command here */=0A=
+		if ((drive->id->command_set_2 & 0x0400) && =
HWIF(drive)->pci_devid.vid=3D=3DPCI_VENDOR_ID_PROMISE)=0A=
+			OUT_BYTE(drive->mult_count ? MULTI_WRITE_EXT : WRITE_EXT, =
IDE_COMMAND_REG);=0A=
+		else=0A=
+			OUT_BYTE(drive->mult_count ? WIN_MULTWRITE : WIN_WRITE, =
IDE_COMMAND_REG);=0A=
 		if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, =
WAIT_DRQ)) {=0A=
 			printk(KERN_ERR "%s: no DRQ after issuing %s\n", drive->name,=0A=
 				drive->mult_count ? "MULTWRITE" : "WRITE");=0A=
@@ -481,7 +505,7 @@=0A=
 static void idedisk_release (struct inode *inode, struct file *filp, =
ide_drive_t *drive)=0A=
 {=0A=
 	if (drive->removable && !drive->usage) {=0A=
-		invalidate_bdev(inode->i_bdev, 0);=0A=
+		invalidate_buffers(inode->i_rdev);=0A=
 		if (drive->doorlocking && ide_wait_cmd(drive, WIN_DOORUNLOCK, 0, 0, =
0, NULL))=0A=
 			drive->doorlocking =3D 0;=0A=
 	}=0A=
@@ -508,12 +532,22 @@=0A=
 {=0A=
 	struct hd_driveid *id =3D drive->id;=0A=
 	unsigned long capacity =3D drive->cyl * drive->head * drive->sect;=0A=
+	int lba48=3Ddrive->id->command_set_2 & 0x0400;=0A=
+	unsigned long temp=3D0;=0A=
 =0A=
 	drive->select.b.lba =3D 0;=0A=
 =0A=
 	/* Determine capacity, and use LBA if the drive properly supports it */=0A=
 	if ((id->capability & 2) && lba_capacity_is_ok(id)) {=0A=
 		capacity =3D id->lba_capacity;=0A=
+		/* get 48 bits disk capacity if support */=0A=
+		if (lba48 && HWIF(drive)->pci_devid.vid=3D=3DPCI_VENDOR_ID_PROMISE)=0A=
+		{=0A=
+			temp=3Did->words94_125[7];=0A=
+			temp<<=3D16;=0A=
+			temp|=3Did->words94_125[6];=0A=
+			capacity=3Dtemp;=0A=
+		}=0A=
 		drive->cyl =3D capacity / (drive->head * drive->sect);=0A=
 		drive->select.b.lba =3D 1;=0A=
 	}=0A=
@@ -769,7 +803,7 @@=0A=
 =0A=
 	/* Give size in megabytes (MB), not mebibytes (MiB). */=0A=
 	/* We compute the exact rounded value, avoiding overflow. */=0A=
-	printk (" (%ld MB)", (capacity - capacity/625 + 974)/1950);=0A=
+	printk (" (%ld GB)", ((capacity - capacity/625 + 974)/1950)/1024);=0A=
 =0A=
 	/* Only print cache size when it was specified */=0A=
 	if (id->buf_size)=0A=
diff -urN linux-2.4.18.org/drivers/ide/ide-dma.c =
linux/drivers/ide/ide-dma.c=0A=
--- linux-2.4.18.org/drivers/ide/ide-dma.c	Mon Sep 10 01:43:02 2001=0A=
+++ linux/drivers/ide/ide-dma.c	Thu Feb 28 00:00:15 2002=0A=
@@ -75,6 +75,8 @@=0A=
  * ATA-66/100 and recovery functions, I forgot the rest......=0A=
  * SELECT_READ_WRITE(hwif,drive,func) for active tuning based on IO =
direction.=0A=
  *=0A=
+ * Support UltraDMA Mode 6 and 48 bit LBA Mode.=0A=
+ * Powered by PROMISE Technology, Inc. Portions Copyright (C)2001.=0A=
  */=0A=
 =0A=
 #include <linux/config.h>=0A=
@@ -101,6 +103,8 @@=0A=
 #define DEFAULT_BMCRBA	0xcc00	/* VIA's default value */=0A=
 #define DEFAULT_BMALIBA	0xd400	/* ALI's default value */=0A=
 =0A=
+#define CONFIG_BLK_DEV_IDEDMA_TIMEOUT 1	// By Promise=0A=
+=0A=
 extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);=0A=
 =0A=
 #ifdef CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=0A=
@@ -429,18 +433,22 @@=0A=
 	struct hd_driveid *id =3D drive->id;=0A=
 =0A=
 	if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&=0A=
-	    (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {=0A=
-		if ((id->dma_ultra >> 13) & 1) {=0A=
-			printk(", UDMA(100)");	/* UDMA BIOS-enabled! */=0A=
+	    (id->dma_ultra & (id->dma_ultra >> 14) & 3)) {=0A=
+	    	if ((id->dma_ultra >> 15) & 1) {=0A=
+			printk(", UDMA(166?)");	/* UDMA 7 BIOS-enabled! */=0A=
+	    	} else if ((id->dma_ultra >> 14) & 1) {=0A=
+			printk(", UDMA(133)");	/* UDMA 6 BIOS-enabled! */=0A=
+		} else if ((id->dma_ultra >> 13) & 1) {=0A=
+			printk(", UDMA(100)");	/* UDMA 5 BIOS-enabled! */=0A=
 		} else if ((id->dma_ultra >> 12) & 1) {=0A=
-			printk(", UDMA(66)");	/* UDMA BIOS-enabled! */=0A=
+			printk(", UDMA(66)");	/* UDMA 4 BIOS-enabled! */=0A=
 		} else {=0A=
 			printk(", UDMA(44)");	/* UDMA BIOS-enabled! */=0A=
 		}=0A=
 	} else if ((id->field_valid & 4) &&=0A=
 		   (id->dma_ultra & (id->dma_ultra >> 8) & 7)) {=0A=
 		if ((id->dma_ultra >> 10) & 1) {=0A=
-			printk(", UDMA(33)");	/* UDMA BIOS-enabled! */=0A=
+			printk(", UDMA(33)");	/* UDMA 2 BIOS-enabled! */=0A=
 		} else if ((id->dma_ultra >> 9) & 1) {=0A=
 			printk(", UDMA(25)");	/* UDMA BIOS-enabled! */=0A=
 		} else {=0A=
@@ -463,7 +471,11 @@=0A=
 		/* Consult the list of known "bad" drives */=0A=
 		if (ide_dmaproc(ide_dma_bad_drive, drive))=0A=
 			return hwif->dmaproc(ide_dma_off, drive);=0A=
-=0A=
+		=0A=
+		/* Enable DMA on any drive that has UltraDMA (mode 6/7) enabled */=0A=
+		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))=0A=
+			if ((id->dma_ultra & (id->dma_ultra >> 14) & 3))=0A=
+				return hwif->dmaproc(ide_dma_on, drive);=0A=
 		/* Enable DMA on any drive that has UltraDMA (mode 3/4/5) enabled */=0A=
 		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))=0A=
 			if ((id->dma_ultra & (id->dma_ultra >> 11) & 7))=0A=
@@ -550,13 +562,18 @@=0A=
  */=0A=
 int ide_dmaproc (ide_dma_action_t func, ide_drive_t *drive)=0A=
 {=0A=
-//	ide_hwgroup_t *hwgroup		=3D HWGROUP(drive);=0A=
 	ide_hwif_t *hwif		=3D HWIF(drive);=0A=
-	unsigned long dma_base		=3D hwif->dma_base;=0A=
+	unsigned long dma_base	=3D hwif->dma_base;=0A=
 	byte unit			=3D (drive->select.b.unit & 0x01);=0A=
 	unsigned int count, reading	=3D 0;=0A=
 	byte dma_stat;=0A=
-=0A=
+	int lba48			=3Ddrive->id->command_set_2 & 0x0400;=0A=
+	unsigned long high_16		=3D pci_resource_start(hwif->pci_dev, 4);=0A=
+	byte clock			=3Dinb(high_16+0x11);=0A=
+	unsigned long atapi_port	=3Dhigh_16+ 0x20 + (hwif->channel ? 0x04 : =
0x00);=0A=
+	struct request *rq 		=3D HWGROUP(drive)->rq;=0A=
+	unsigned long word_count 	=3D 0;=0A=
+	=0A=
 	switch (func) {=0A=
 		case ide_dma_off:=0A=
 			printk("%s: DMA disabled\n", drive->name);=0A=
@@ -586,18 +603,39 @@=0A=
 #else /* !CONFIG_BLK_DEV_IDEDMA_TIMEOUT */=0A=
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	=
/* issue cmd to drive */=0A=
 #endif /* CONFIG_BLK_DEV_IDEDMA_TIMEOUT */=0A=
-			OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);=0A=
+			if (lba48 && hwif->pci_devid.vid=3D=3DPCI_VENDOR_ID_PROMISE)=0A=
+				OUT_BYTE(reading ? READ_DMA_EXT : WRITE_DMA_EXT, IDE_COMMAND_REG);=0A=
+			else=0A=
+				OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);=0A=
 		case ide_dma_begin:=0A=
 			/* Note that this is done *after* the cmd has=0A=
-			 * been issued to the drive, as per the BM-IDE spec.=0A=
-			 * The Promise Ultra33 doesn't work correctly when=0A=
-			 * we do this part before issuing the drive cmd.=0A=
-			 */=0A=
-			outb(inb(dma_base)|1, dma_base);		/* start DMA */=0A=
+			 * been issued to the drive, as per the BM-IDE spec. */=0A=
+			/* Enable ATAPI UDMA port for 48bit data on PDC20267 */=0A=
+			if (lba48 && hwif->pci_devid.vid=3D=3DPCI_VENDOR_ID_PROMISE &&=0A=
+			   (hwif->pci_devid.did =3D=3D PCI_DEVICE_ID_PROMISE_20267 || =0A=
+			    hwif->pci_devid.did =3D=3D PCI_DEVICE_ID_PROMISE_20265 ||=0A=
+			    hwif->pci_devid.did =3D=3D PCI_DEVICE_ID_PROMISE_20262))=0A=
+			{=0A=
+				outb(clock|(hwif->channel ? 0x08:0x02), high_16 + 0x11);=0A=
+				word_count=3D(rq->nr_sectors << 8);=0A=
+				word_count=3Dreading ? word_count | 0x05000000 : word_count | =
0x06000000;=0A=
+				outl(word_count, atapi_port);=0A=
+			}  =0A=
+			outb(inb(dma_base)|1, dma_base);	/* start DMA */=0A=
 			return 0;=0A=
 		case ide_dma_end: /* returns 1 on error, 0 otherwise */=0A=
 			drive->waiting_for_dma =3D 0;=0A=
 			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */=0A=
+			/* Disable ATAPI UDMA port for 48bit data on PDC20267 */=0A=
+			if (lba48 && hwif->pci_devid.vid=3D=3DPCI_VENDOR_ID_PROMISE &&=0A=
+			    (hwif->pci_devid.did =3D=3D PCI_DEVICE_ID_PROMISE_20267 || =0A=
+			     hwif->pci_devid.did =3D=3D PCI_DEVICE_ID_PROMISE_20265 ||=0A=
+			     hwif->pci_devid.did =3D=3D PCI_DEVICE_ID_PROMISE_20262))=0A=
+			{=0A=
+			    	outl(0, atapi_port);=0A=
+				clock=3Dinb(high_16+0x11);=0A=
+				outb(clock & ~(hwif->channel ? 0x08:0x02), high_16+0x11);=0A=
+			}=0A=
 			dma_stat =3D inb(dma_base+2);		/* get DMA status */=0A=
 			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */=0A=
 			ide_destroy_dmatable(drive);	/* purge DMA mappings */=0A=
diff -urN linux-2.4.18.org/drivers/ide/ide-features.c =
linux/drivers/ide/ide-features.c=0A=
--- linux-2.4.18.org/drivers/ide/ide-features.c	Sat Feb 10 03:40:02 2001=0A=
+++ linux/drivers/ide/ide-features.c	Thu Feb 28 00:04:42 2002=0A=
@@ -261,6 +261,9 @@=0A=
  */=0A=
 byte eighty_ninty_three (ide_drive_t *drive)=0A=
 {=0A=
+	if (HWIF(drive)->pci_devid.vid=3D=3D0x105a)=0A=
+	    return(HWIF(drive)->udma_four);=0A=
+	/* PDC202XX: that's because some HDD will return wrong info */=0A=
 	return ((byte) ((HWIF(drive)->udma_four) &&=0A=
 #ifndef CONFIG_IDEDMA_IVB=0A=
 			(drive->id->hw_config & 0x4000) &&=0A=
diff -urN linux-2.4.18.org/drivers/ide/ide-pci.c =
linux/drivers/ide/ide-pci.c=0A=
--- linux-2.4.18.org/drivers/ide/ide-pci.c	Fri Oct 26 04:53:47 2001=0A=
+++ linux/drivers/ide/ide-pci.c	Wed Feb 27 19:26:40 2002=0A=
@@ -11,6 +11,10 @@=0A=
  *  This module provides support for automatic detection and=0A=
  *  configuration of all PCI IDE interfaces present in a system.  =0A=
  */=0A=
+/* =0A=
+ * Support PROMISE PDC20268/20269/20275 IDE Controller.=0A=
+ * Powered by PROMISE Technology, Inc. Portions Copyright (C)2001.=0A=
+ */ =0A=
 =0A=
 #include <linux/config.h>=0A=
 #include <linux/types.h>=0A=
@@ -45,8 +49,9 @@=0A=
 #define DEVID_PDC20262	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, =
PCI_DEVICE_ID_PROMISE_20262})=0A=
 #define DEVID_PDC20265	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, =
PCI_DEVICE_ID_PROMISE_20265})=0A=
 #define DEVID_PDC20267	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, =
PCI_DEVICE_ID_PROMISE_20267})=0A=
-#define DEVID_PDC20268  ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, =
PCI_DEVICE_ID_PROMISE_20268})=0A=
-#define DEVID_PDC20268R ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, =
PCI_DEVICE_ID_PROMISE_20268R})=0A=
+#define DEVID_PDC20268	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, =
PCI_DEVICE_ID_PROMISE_20268})=0A=
+#define DEVID_PDC20269	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, =
PCI_DEVICE_ID_PROMISE_20269})=0A=
+#define DEVID_PDC20275	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, =
PCI_DEVICE_ID_PROMISE_20275})=0A=
 #define DEVID_RZ1000	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  =
PCI_DEVICE_ID_PCTECH_RZ1000})=0A=
 #define DEVID_RZ1001	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  =
PCI_DEVICE_ID_PCTECH_RZ1001})=0A=
 #define DEVID_SAMURAI	((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  =
PCI_DEVICE_ID_PCTECH_SAMURAI_IDE})=0A=
@@ -402,10 +407,8 @@=0A=
 	{DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	=
INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}},	OFF_BOARD,	=
48 },=0A=
 #endif=0A=
 	{DEVID_PDC20268,"PDC20268",	PCI_PDC202XX,	ATA66_PDC202XX,	=
INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	=
16 },=0A=
-	/* Promise used a different PCI ident for the raid card apparently to =
try and=0A=
-	   prevent Linux detecting it and using our own raid code. We want to =
detect=0A=
-	   it for the ataraid drivers, so we have to list both here.. */=0A=
-	{DEVID_PDC20268R,"PDC20268",	PCI_PDC202XX,	ATA66_PDC202XX,	=
INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	=
16 },=0A=
+	{DEVID_PDC20269,"PDC20269",	PCI_PDC202XX,	ATA66_PDC202XX,	=
INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	=
16 },=0A=
+	{DEVID_PDC20275,"PDC20275",	PCI_PDC202XX,	ATA66_PDC202XX,	=
INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	=
16 },=0A=
 	{DEVID_RZ1000,	"RZ1000",	NULL,		NULL,		INIT_RZ1000,	NULL,		=
{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 },=0A=
 	{DEVID_RZ1001,	"RZ1001",	NULL,		NULL,		INIT_RZ1000,	NULL,		=
{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 },=0A=
 	{DEVID_SAMURAI,	"SAMURAI",	NULL,		NULL,		INIT_SAMURAI,	NULL,		=
{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },=0A=
@@ -458,6 +461,8 @@=0A=
 		case PCI_DEVICE_ID_PROMISE_20265:=0A=
 		case PCI_DEVICE_ID_PROMISE_20267:=0A=
 		case PCI_DEVICE_ID_PROMISE_20268:=0A=
+		case PCI_DEVICE_ID_PROMISE_20269:=0A=
+		case PCI_DEVICE_ID_PROMISE_20275:=0A=
 		case PCI_DEVICE_ID_ARTOP_ATP850UF:=0A=
 		case PCI_DEVICE_ID_ARTOP_ATP860:=0A=
 		case PCI_DEVICE_ID_ARTOP_ATP860R:=0A=
@@ -586,6 +591,7 @@=0A=
 	ide_hwif_t *hwif, *mate =3D NULL;=0A=
 	unsigned int class_rev;=0A=
 	static int secondpdc =3D 0;=0A=
+	int new_chip=3D0;=0A=
 =0A=
 #ifdef CONFIG_IDEDMA_AUTO=0A=
 	if (!noautodma)=0A=
@@ -684,6 +690,10 @@=0A=
 	/*=0A=
 	 * Set up the IDE ports=0A=
 	 */=0A=
+	if ((IDE_PCI_DEVID_EQ(d->devid,DEVID_PDC20268)) ||=0A=
+	     (IDE_PCI_DEVID_EQ(d->devid,DEVID_PDC20269)) ||=0A=
+	     (IDE_PCI_DEVID_EQ(d->devid,DEVID_PDC20275)))=0A=
+	 	new_chip=3D1; =0A=
 	for (port =3D 0; port <=3D 1; ++port) {=0A=
 		unsigned long base =3D 0, ctl =3D 0;=0A=
 		ide_pci_enablebit_t *e =3D &(d->enablebits[port]);=0A=
@@ -697,9 +707,9 @@=0A=
 			goto controller_ok;=0A=
 		if ((IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20262)) && =
(secondpdc++=3D=3D1) && (port=3D=3D1)  ) =0A=
 			goto controller_ok;=0A=
-			=0A=
-		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp & =
e->mask) !=3D e->val))=0A=
-			continue;	/* port not enabled */=0A=
+		if (!(new_chip))=0A=
+			if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp & =
e->mask) !=3D e->val))=0A=
+				continue;	/* port not enabled */=0A=
 controller_ok:			=0A=
 		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366) && (port) && (class_rev =
< 0x03))=0A=
 			return;=0A=
@@ -774,7 +784,8 @@=0A=
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265) ||=0A=
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20267) ||=0A=
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268) ||=0A=
-		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R) ||=0A=
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20269) ||=0A=
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20275) ||=0A=
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6210) ||=0A=
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||=0A=
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260R) ||=0A=
diff -urN linux-2.4.18.org/drivers/ide/ide.c linux/drivers/ide/ide.c=0A=
--- linux-2.4.18.org/drivers/ide/ide.c	Tue Feb 26 03:37:57 2002=0A=
+++ linux/drivers/ide/ide.c	Wed Feb 27 19:27:51 2002=0A=
@@ -716,7 +716,6 @@=0A=
 		}=0A=
 	}=0A=
 	hwgroup->poll_timeout =3D 0;	/* done polling */=0A=
-	return ide_stopped;=0A=
 }=0A=
 =0A=
 static void check_dma_crc (ide_drive_t *drive)=0A=
@@ -883,6 +882,7 @@=0A=
 {=0A=
 	unsigned long flags;=0A=
 	byte err =3D 0;=0A=
+	int lba48=3D(drive->id->command_set_2 & 0x0400);=0A=
 =0A=
 	__save_flags (flags);	/* local CPU only */=0A=
 	ide__sti();		/* local CPU only */=0A=
@@ -918,7 +918,16 @@=0A=
 			printk("}");=0A=
 			if ((err & (BBD_ERR | ABRT_ERR)) =3D=3D BBD_ERR || (err & =
(ECC_ERR|ID_ERR|MARK_ERR))) {=0A=
 				byte cur =3D IN_BYTE(IDE_SELECT_REG);=0A=
-				if (cur & 0x40) {	/* using LBA? */=0A=
+				if ((lba48) && (HWIF(drive)->pci_devid.vid=3D=3D0x105a)) { /* 48bit =
LBA? */=0A=
+					OUT_BYTE(0x88, IDE_CONTROL_REG);=0A=
+					cur =3D IN_BYTE(IDE_SECTOR_REG);=0A=
+					OUT_BYTE(0x08, IDE_CONTROL_REG);=0A=
+					printk(", LBAsect=3D%ld", (unsigned long)=0A=
+					(cur << 24)=0A=
+					 |(IN_BYTE(IDE_HCYL_REG)<<16)=0A=
+					 |(IN_BYTE(IDE_LCYL_REG)<<8)=0A=
+					 | IN_BYTE(IDE_SECTOR_REG));=0A=
+				} else if (cur & 0x40) {	/* using LBA? */=0A=
 					printk(", LBAsect=3D%ld", (unsigned long)=0A=
 					 ((cur&0xf)<<24)=0A=
 					 |(IN_BYTE(IDE_HCYL_REG)<<16)=0A=
@@ -3746,7 +3755,6 @@=0A=
 char *options =3D NULL;=0A=
 MODULE_PARM(options,"s");=0A=
 MODULE_LICENSE("GPL");=0A=
-=0A=
 static void __init parse_options (char *line)=0A=
 {=0A=
 	char *next =3D line;=0A=
diff -urN linux-2.4.18.org/drivers/ide/pdc202xx.c =
linux/drivers/ide/pdc202xx.c=0A=
--- linux-2.4.18.org/drivers/ide/pdc202xx.c	Thu Nov 15 03:44:03 2001=0A=
+++ linux/drivers/ide/pdc202xx.c	Thu Feb 28 00:48:45 2002=0A=
@@ -1,5 +1,5 @@=0A=
 /*=0A=
- *  linux/drivers/ide/pdc202xx.c	Version 0.30	Mar. 18, 2000=0A=
+ *  linux/drivers/ide/pdc202xx.c	Version 0.32	Feb. 27, 2002=0A=
  *=0A=
  *  Copyright (C) 1998-2000	Andre Hedrick <andre@linux-ide.org>=0A=
  *  May be copied or modified under the terms of the GNU General Public =
License=0A=
@@ -12,7 +12,8 @@=0A=
  *  Promise Ultra66 cards with BIOS v1.11 this=0A=
  *  compiled into the kernel if you have more than one card installed.=0A=
  *=0A=
- *  Promise Ultra100 cards.=0A=
+ *  Promise Ultra Series cards.=0A=
+ *  Promise Ultra100TX2 & Ultra133TX2 cards.=0A=
  *=0A=
  *  The latest chipset code will support the following ::=0A=
  *  Three Ultra33 controllers and 12 drives.=0A=
@@ -21,13 +22,29 @@=0A=
  *=0A=
  *  UNLESS you enable "CONFIG_PDC202XX_BURST"=0A=
  *=0A=
- */=0A=
-=0A=
-/*=0A=
- *  Portions Copyright (C) 1999 Promise Technology, Inc.=0A=
- *  Author: Frank Tiernan (frankt@promise.com)=0A=
+ *  Version 1.20.b1 support PDC20268=0A=
+ *                  fix cable judge function=0A=
+ *  Version 1.20.b2 support ATA-133 PDC20269/75=0A=
+ *                  support UDMA Mode 6=0A=
+ *                  fix proc report information=0A=
+ *                  set ATA133 timing=0A=
+ *                  fix ultra dma bit 14 selectable=0A=
+ *                  support 32bit LBA=0A=
+ *  Version 1.20 b3 fix eighty_ninty_three()=0A=
+ *                  fix offset address 0x1c~0x1f=0A=
+ *  Version 1.20 b4 fix 48bit LBA HOB bit=0A=
+ *                  force rescan drive under PIO modes if need=0A=
+ *  Version 1.20.0.5 could be patched with ext3 filesystem code=0A=
+ *  Version 1.20.0.6 fix LBA48 drive running without promise controller=0A=
+ *                   fix LBA48 drive running under PIO modes=0A=
+ *=0A=
+ *  Portions Copyright (C) 1999-2002 Promise Technology, Inc.=0A=
+ *  Author: Frank Tiernan <frankt@promise.com>=0A=
+ *          Hank Yang <hanky@promise.com.tw> August.13.2001=0A=
  *  Released under terms of General Public License=0A=
  */=0A=
+#define VERSION	"1.20.0.6"=0A=
+#define VERDATE "2002-01-28"=0A=
 =0A=
 #include <linux/config.h>=0A=
 #include <linux/types.h>=0A=
@@ -65,41 +82,10 @@=0A=
 extern int (*pdc202xx_display_info)(char *, char **, off_t, int); /* =
ide-proc.c */=0A=
 extern char *ide_media_verbose(ide_drive_t *);=0A=
 static struct pci_dev *bmide_dev;=0A=
-=0A=
-char *pdc202xx_pio_verbose (u32 drive_pci)=0A=
-{=0A=
-	if ((drive_pci & 0x000ff000) =3D=3D 0x000ff000) return("NOTSET");=0A=
-	if ((drive_pci & 0x00000401) =3D=3D 0x00000401) return("PIO 4");=0A=
-	if ((drive_pci & 0x00000602) =3D=3D 0x00000602) return("PIO 3");=0A=
-	if ((drive_pci & 0x00000803) =3D=3D 0x00000803) return("PIO 2");=0A=
-	if ((drive_pci & 0x00000C05) =3D=3D 0x00000C05) return("PIO 1");=0A=
-	if ((drive_pci & 0x00001309) =3D=3D 0x00001309) return("PIO 0");=0A=
-	return("PIO ?");=0A=
-}=0A=
-=0A=
-char *pdc202xx_dma_verbose (u32 drive_pci)=0A=
-{=0A=
-	if ((drive_pci & 0x00036000) =3D=3D 0x00036000) return("MWDMA 2");=0A=
-	if ((drive_pci & 0x00046000) =3D=3D 0x00046000) return("MWDMA 1");=0A=
-	if ((drive_pci & 0x00056000) =3D=3D 0x00056000) return("MWDMA 0");=0A=
-	if ((drive_pci & 0x00056000) =3D=3D 0x00056000) return("SWDMA 2");=0A=
-	if ((drive_pci & 0x00068000) =3D=3D 0x00068000) return("SWDMA 1");=0A=
-	if ((drive_pci & 0x000BC000) =3D=3D 0x000BC000) return("SWDMA 0");=0A=
-	return("PIO---");=0A=
-}=0A=
-=0A=
-char *pdc202xx_ultra_verbose (u32 drive_pci, u16 slow_cable)=0A=
-{=0A=
-	if ((drive_pci & 0x000ff000) =3D=3D 0x000ff000)=0A=
-		return("NOTSET");=0A=
-	if ((drive_pci & 0x00012000) =3D=3D 0x00012000)=0A=
-		return((slow_cable) ? "UDMA 2" : "UDMA 4");=0A=
-	if ((drive_pci & 0x00024000) =3D=3D 0x00024000)=0A=
-		return((slow_cable) ? "UDMA 1" : "UDMA 3");=0A=
-	if ((drive_pci & 0x00036000) =3D=3D 0x00036000)=0A=
-		return("UDMA 0");=0A=
-	return(pdc202xx_dma_verbose(drive_pci));=0A=
-}=0A=
+static struct hd_driveid *id[4];=0A=
+static int speed_rate[4];=0A=
+static int set_speed=3D0;=0A=
+static int new_chip=3D0;=0A=
 =0A=
 static char * pdc202xx_info (char *buf, struct pci_dev *dev)=0A=
 {=0A=
@@ -107,8 +93,8 @@=0A=
 =0A=
 	u32 bibma  =3D pci_resource_start(dev, 4);=0A=
 	u32 reg60h =3D 0, reg64h =3D 0, reg68h =3D 0, reg6ch =3D 0;=0A=
-	u16 reg50h =3D 0, pmask =3D (1<<10), smask =3D (1<<11);=0A=
-	u8 hi =3D 0, lo =3D 0, invalid_data_set =3D 0;=0A=
+	u16 reg50h =3D 0, word88=3D0;=0A=
+	int udmasel[4]=3D{0,0,0,0}, piosel[4]=3D{0,0,0,0}, i=3D0, hd=3D0;=0A=
 =0A=
         /*=0A=
          * at that point bibma+0x2 et bibma+0xa are byte registers=0A=
@@ -120,10 +106,6 @@=0A=
 	u8 sc11	=3D inb_p((unsigned short)bibma + 0x11);=0A=
 	u8 sc1a	=3D inb_p((unsigned short)bibma + 0x1a);=0A=
 	u8 sc1b	=3D inb_p((unsigned short)bibma + 0x1b);=0A=
-	u8 sc1c	=3D inb_p((unsigned short)bibma + 0x1c); =0A=
-	u8 sc1d	=3D inb_p((unsigned short)bibma + 0x1d);=0A=
-	u8 sc1e	=3D inb_p((unsigned short)bibma + 0x1e);=0A=
-	u8 sc1f	=3D inb_p((unsigned short)bibma + 0x1f);=0A=
 =0A=
 	pci_read_config_word(dev, 0x50, &reg50h);=0A=
 	pci_read_config_dword(dev, 0x60, &reg60h);=0A=
@@ -131,45 +113,35 @@=0A=
 	pci_read_config_dword(dev, 0x68, &reg68h);=0A=
 	pci_read_config_dword(dev, 0x6c, &reg6ch);=0A=
 =0A=
+	p+=3Dsprintf(p, "\nPROMISE Ultra series linux driver Ver %s %s =
Adapter: ", VERSION, VERDATE);=0A=
 	switch(dev->device) {=0A=
+		case PCI_DEVICE_ID_PROMISE_20275:=0A=
+			p +=3D sprintf(p, "MBUltra133\n");=0A=
+			break;=0A=
+		case PCI_DEVICE_ID_PROMISE_20269:=0A=
+			p +=3D sprintf(p, "Ultra133 TX2\n");=0A=
+			break;=0A=
 		case PCI_DEVICE_ID_PROMISE_20268:=0A=
-		case PCI_DEVICE_ID_PROMISE_20268R:=0A=
-			p +=3D sprintf(p, "\n                                PDC20268 TX2 =
Chipset.\n");=0A=
-			invalid_data_set =3D 1;=0A=
+			p +=3D sprintf(p, "Ultra100 TX2\n");=0A=
 			break;=0A=
 		case PCI_DEVICE_ID_PROMISE_20267:=0A=
-			p +=3D sprintf(p, "\n                                PDC20267 =
Chipset.\n");=0A=
+			p +=3D sprintf(p, "Ultra100\n");=0A=
 			break;=0A=
 		case PCI_DEVICE_ID_PROMISE_20265:=0A=
-			p +=3D sprintf(p, "\n                                PDC20265 =
Chipset.\n");=0A=
+			p +=3D sprintf(p, "Ultra100 on M/B\n");=0A=
 			break;=0A=
 		case PCI_DEVICE_ID_PROMISE_20262:=0A=
-			p +=3D sprintf(p, "\n                                PDC20262 =
Chipset.\n");=0A=
+			p +=3D sprintf(p, "Ultra66\n");=0A=
 			break;=0A=
 		case PCI_DEVICE_ID_PROMISE_20246:=0A=
-			p +=3D sprintf(p, "\n                                PDC20246 =
Chipset.\n");=0A=
+			p +=3D sprintf(p, "Ultra33\n");=0A=
 			reg50h |=3D 0x0c00;=0A=
 			break;=0A=
 		default:=0A=
-			p +=3D sprintf(p, "\n                                PDC202XX =
Chipset.\n");=0A=
+			p +=3D sprintf(p, "Ultra Series\n");=0A=
 			break;=0A=
 	}=0A=
 =0A=
-	p +=3D sprintf(p, "------------------------------- General Status =
---------------------------------\n");=0A=
-	p +=3D sprintf(p, "Burst Mode                           : %sabled\n", =
(sc1f & 0x01) ? "en" : "dis");=0A=
-	p +=3D sprintf(p, "Host Mode                            : %s\n", (sc1f =
& 0x08) ? "Tri-Stated" : "Normal");=0A=
-	p +=3D sprintf(p, "Bus Clocking                         : %s\n",=0A=
-		((sc1f & 0xC0) =3D=3D 0xC0) ? "100 External" :=0A=
-		((sc1f & 0x80) =3D=3D 0x80) ? "66 External" :=0A=
-		((sc1f & 0x40) =3D=3D 0x40) ? "33 External" : "33 PCI Internal");=0A=
-	p +=3D sprintf(p, "IO pad select                        : %s mA\n",=0A=
-		((sc1c & 0x03) =3D=3D 0x03) ? "10" :=0A=
-		((sc1c & 0x02) =3D=3D 0x02) ? "8" :=0A=
-		((sc1c & 0x01) =3D=3D 0x01) ? "6" :=0A=
-		((sc1c & 0x00) =3D=3D 0x00) ? "4" : "??");=0A=
-	SPLIT_BYTE(sc1e, hi, lo);=0A=
-	p +=3D sprintf(p, "Status Polling Period                : %d\n", hi);=0A=
-	p +=3D sprintf(p, "Interrupt Check Status Polling Delay : %d\n", lo);=0A=
 	p +=3D sprintf(p, "--------------- Primary Channel ---------------- =
Secondary Channel -------------\n");=0A=
 	p +=3D sprintf(p, "                %s                         %s\n",=0A=
 		(c0&0x80)?"disabled":"enabled ",=0A=
@@ -177,41 +149,33 @@=0A=
 	p +=3D sprintf(p, "66 Clocking     %s                         %s\n",=0A=
 		(sc11&0x02)?"enabled ":"disabled",=0A=
 		(sc11&0x08)?"enabled ":"disabled");=0A=
-	p +=3D sprintf(p, "           Mode %s                      Mode %s\n",=0A=
+	p +=3D sprintf(p, "Mode            %s                         %s\n",=0A=
 		(sc1a & 0x01) ? "MASTER" : "PCI   ",=0A=
 		(sc1b & 0x01) ? "MASTER" : "PCI   ");=0A=
-	if (!(invalid_data_set))=0A=
-		p +=3D sprintf(p, "                %s                     %s\n",=0A=
-			(sc1d & 0x08) ? "Error       " :=0A=
-			((sc1d & 0x05) =3D=3D 0x05) ? "Not My INTR " :=0A=
-			(sc1d & 0x04) ? "Interrupting" :=0A=
-			(sc1d & 0x02) ? "FIFO Full   " :=0A=
-			(sc1d & 0x01) ? "FIFO Empty  " : "????????????",=0A=
-			(sc1d & 0x80) ? "Error       " :=0A=
-			((sc1d & 0x50) =3D=3D 0x50) ? "Not My INTR " :=0A=
-			(sc1d & 0x40) ? "Interrupting" :=0A=
-			(sc1d & 0x20) ? "FIFO Full   " :=0A=
-			(sc1d & 0x10) ? "FIFO Empty  " : "????????????");=0A=
 	p +=3D sprintf(p, "--------------- drive0 --------- drive1 -------- =
drive0 ---------- drive1 ------\n");=0A=
 	p +=3D sprintf(p, "DMA enabled:    %s              %s             %s   =
            %s\n",=0A=
-		(c0&0x20)?"yes":"no ",(c0&0x40)?"yes":"no ",(c1&0x20)?"yes":"no =
",(c1&0x40)?"yes":"no ");=0A=
-	if (!(invalid_data_set))=0A=
-		p +=3D sprintf(p, "DMA Mode:       %s           %s          %s        =
    %s\n",=0A=
-			pdc202xx_ultra_verbose(reg60h, (reg50h & pmask)),=0A=
-			pdc202xx_ultra_verbose(reg64h, (reg50h & pmask)),=0A=
-			pdc202xx_ultra_verbose(reg68h, (reg50h & smask)),=0A=
-			pdc202xx_ultra_verbose(reg6ch, (reg50h & smask)));=0A=
-	if (!(invalid_data_set))=0A=
-		p +=3D sprintf(p, "PIO Mode:       %s            %s           %s      =
      %s\n",=0A=
-			pdc202xx_pio_verbose(reg60h),=0A=
-			pdc202xx_pio_verbose(reg64h),=0A=
-			pdc202xx_pio_verbose(reg68h),=0A=
-			pdc202xx_pio_verbose(reg6ch));=0A=
+		(id[0]!=3DNULL && (c0&0x20))?"yes":"no ",(id[1]!=3DNULL && =
(c0&0x40))?"yes":"no ",=0A=
+		(id[2]!=3DNULL && (c1&0x20))?"yes":"no ",(id[3]!=3DNULL && =
(c1&0x40))?"yes":"no ");=0A=
+	for(hd=3D0;hd<4;hd++)=0A=
+	{=0A=
+		if (id[hd]=3D=3DNULL)=0A=
+			continue;=0A=
+		word88=3Did[hd]->dma_ultra;=0A=
+		for (i=3D7;i>=3D0;i--)=0A=
+			if (word88>>(i+8))=0A=
+			{=0A=
+				udmasel[hd]=3Di;	/* get select UDMA mode */=0A=
+				break;=0A=
+			}=0A=
+		piosel[hd]=3D(id[hd]->eide_pio_modes >=3D 0x02) ? 4 : 3;=0A=
+        }=0A=
+	p +=3D sprintf(p, "UDMA Mode:      %d                %d               =
%d                 %d\n",=0A=
+		udmasel[0],udmasel[1],udmasel[2],udmasel[3]);=0A=
+	p +=3D sprintf(p, "PIO Mode:       %d                %d               =
%d                 %d\n",=0A=
+		piosel[0],piosel[1],piosel[2],piosel[3]);=0A=
 #if 0=0A=
 	p +=3D sprintf(p, "--------------- Can ATAPI DMA ---------------\n");=0A=
 #endif=0A=
-	if (invalid_data_set)=0A=
-		p +=3D sprintf(p, "--------------- Cannot Decode HOST =
---------------\n");=0A=
 	return (char *)p;=0A=
 }=0A=
 =0A=
@@ -376,7 +340,21 @@=0A=
 	int			err;=0A=
 	byte			drive_pci, AP, BP, CP, DP;=0A=
 	byte			TA =3D 0, TB =3D 0, TC =3D 0;=0A=
+#ifdef CONFIG_BLK_DEV_IDEDMA=0A=
+	unsigned long indexreg	=3D (hwif->dma_base + 1);=0A=
+	unsigned long datareg	=3D (hwif->dma_base + 3);=0A=
+#else=0A=
+	struct pci_dev *dev	=3D hwif->pci_dev;=0A=
+	unsigned long high_16	=3D pci_resource_start(dev, 4);=0A=
+	unsigned long indexreg	=3D high_16 + (hwif->channel ? 0x09 : 0x01);=0A=
+	unsigned long datareg	=3D (indexreg + 2);=0A=
+#endif /* CONFIG_BLK_DEV_IDEDMA */=0A=
+	byte thold		=3D0x10;=0A=
+	byte adj		=3D(drive->dn%2) ? 0x08 : 0x00;=0A=
+	int  i=3D0, j=3Dhwif->channel ? 2:0;=0A=
 =0A=
+if (!(new_chip))=0A=
+{=0A=
 	switch (drive->dn) {=0A=
 		case 0: drive_pci =3D 0x60; break;=0A=
 		case 1: drive_pci =3D 0x64; break;=0A=
@@ -387,9 +365,6 @@=0A=
 =0A=
 	if ((drive->media !=3D ide_disk) && (speed < XFER_SW_DMA_0))	return -1;=0A=
 =0A=
-	if (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20268)=0A=
-		goto skip_register_hell;=0A=
-=0A=
 	pci_read_config_dword(dev, drive_pci, &drive_conf);=0A=
 	pci_read_config_byte(dev, (drive_pci), &AP);=0A=
 	pci_read_config_byte(dev, (drive_pci)|0x01, &BP);=0A=
@@ -476,14 +451,158 @@=0A=
 	decode_registers(REG_C, CP);=0A=
 	decode_registers(REG_D, DP);=0A=
 #endif /* PDC202XX_DECODE_REGISTER_INFO */=0A=
-=0A=
-skip_register_hell:=0A=
-=0A=
+}=0A=
+	if (speed>=3DXFER_UDMA_6)=0A=
+		set_speed=3D1;	/* we need to set ATA133 timing */=0A=
 	if (!drive->init_speed)=0A=
 		drive->init_speed =3D speed;=0A=
+#if PDC202XX_DEBUG_DRIVE_INFO=0A=
+	printk("%s: Before set_feature =3D %s, word88 =3D %#x\n",=0A=
+		drive->name, ide_xfer_verbose(speed), drive->id->dma_ultra );=0A=
+#endif /* PDC202XX_DEBUG_DRIVE_INFO */=0A=
 	err =3D ide_config_drive_speed(drive, speed);=0A=
 	drive->current_speed =3D speed;=0A=
-=0A=
+#ifdef CONFIG_BLK_DEV_IDEDMA=0A=
+	/* Setting tHOLD bit to 0 if using UDMA mode 2 */=0A=
+	if ((speed=3D=3DXFER_UDMA_2) && (new_chip))=0A=
+	{=0A=
+		outb(thold+adj,indexreg);=0A=
+		outb((inb(datareg)&0x7f),datareg);=0A=
+	}=0A=
+#endif /* CONFIG_BLK_DEV_IDEDMA */=0A=
+	for (i=3D0;i<2;i++)=0A=
+		if (hwif->drives[i].present)=0A=
+	  	{=0A=
+	 		id[i+j]=3Dhwif->drives[i].id;	/* get identify structs */=0A=
+	 		speed_rate[i+j]=3Dspeed;		/* get current speed */=0A=
+	 	}=0A=
+	if (new_chip && set_speed)=0A=
+	{=0A=
+		for (i=3D0; i<4; i++)=0A=
+		{=0A=
+			if (id[i]=3D=3DNULL)=0A=
+				continue;=0A=
+			switch(speed_rate[i]){=0A=
+			case XFER_PIO_0:=0A=
+				outb(0x0c+adj, indexreg);=0A=
+				outb(0xfb, datareg);=0A=
+				outb(0x0d+adj, indexreg);=0A=
+				outb(0x2b, datareg);=0A=
+				outb(0x13+adj, indexreg);=0A=
+				outb(0xac, datareg);=0A=
+				break;=0A=
+			case XFER_PIO_1:=0A=
+				outb(0x0c+adj, indexreg);=0A=
+				outb(0x46, datareg);=0A=
+				outb(0x0d+adj, indexreg);=0A=
+				outb(0x29, datareg);=0A=
+				outb(0x13+adj, indexreg);=0A=
+				outb(0xa4, datareg);=0A=
+				break;=0A=
+			case XFER_PIO_2:=0A=
+				outb(0x0c+adj, indexreg);=0A=
+				outb(0x23, datareg);=0A=
+				outb(0x0d+adj, indexreg);=0A=
+				outb(0x26, datareg);=0A=
+				outb(0x13+adj, indexreg);=0A=
+				outb(0x64, datareg);=0A=
+				break;=0A=
+			case XFER_PIO_3:=0A=
+				outb(0x0c+adj, indexreg);=0A=
+				outb(0x27, datareg);=0A=
+				outb(0x0d+adj, indexreg);=0A=
+				outb(0x0d, datareg);=0A=
+				outb(0x13+adj, indexreg);=0A=
+				outb(0x35, datareg);=0A=
+				break;=0A=
+			case XFER_PIO_4:=0A=
+				outb(0x0c+adj, indexreg);=0A=
+				outb(0x23, datareg);=0A=
+				outb(0x0d+adj, indexreg);=0A=
+				outb(0x09, datareg);=0A=
+				outb(0x13+adj, indexreg);=0A=
+				outb(0x25, datareg);=0A=
+				break;=0A=
+#ifdef CONFIG_BLK_DEV_IDEDMA=0A=
+			case XFER_MW_DMA_0:=0A=
+				outb(0x0e +adj, indexreg);=0A=
+				outb(0xdf, datareg);=0A=
+				outb(0x0f+adj, indexreg);=0A=
+				outb(0x5f, datareg);=0A=
+				break;=0A=
+			case XFER_MW_DMA_1:=0A=
+				outb(0x0e +adj, indexreg);=0A=
+				outb(0x6b, datareg);=0A=
+				outb(0x0f+adj, indexreg);=0A=
+				outb(0x27, datareg);=0A=
+				break;=0A=
+			case XFER_MW_DMA_2:=0A=
+				outb(0x0e +adj, indexreg);=0A=
+				outb(0x69, datareg);=0A=
+				outb(0x0f+adj, indexreg);=0A=
+				outb(0x25, datareg);=0A=
+				break;=0A=
+			case XFER_UDMA_0:=0A=
+				outb(0x10+adj, indexreg);=0A=
+				outb(0x4a, datareg);=0A=
+				outb(0x11+adj, indexreg);=0A=
+				outb(0x0f, datareg);=0A=
+				outb(0x12+adj, indexreg);=0A=
+				outb(0xd5, datareg);=0A=
+				break;=0A=
+			case XFER_UDMA_1:=0A=
+				outb(0x10+adj, indexreg);=0A=
+				outb(0x3a, datareg);=0A=
+				outb(0x11+adj, indexreg);=0A=
+				outb(0x0a, datareg);=0A=
+				outb(0x12+adj, indexreg);=0A=
+				outb(0xd0, datareg);=0A=
+					break;=0A=
+			case XFER_UDMA_2:=0A=
+				outb(0x10+adj, indexreg);=0A=
+				outb(0x2a, datareg);=0A=
+				outb(0x11+adj, indexreg);=0A=
+				outb(0x07, datareg);=0A=
+				outb(0x12+adj, indexreg);=0A=
+				outb(0xcd, datareg);=0A=
+				break;=0A=
+			case XFER_UDMA_3:=0A=
+				outb(0x10+adj, indexreg);=0A=
+				outb(0x1a, datareg);=0A=
+				outb(0x11+adj, indexreg);=0A=
+				outb(0x05, datareg);=0A=
+				outb(0x12+adj, indexreg);=0A=
+				outb(0xcd, datareg);=0A=
+				break;=0A=
+			case XFER_UDMA_4:=0A=
+				outb(0x10+adj, indexreg);=0A=
+				outb(0x1a, datareg);=0A=
+				outb(0x11+adj, indexreg);=0A=
+				outb(0x03, datareg);=0A=
+				outb(0x12+adj, indexreg);=0A=
+				outb(0xcd, datareg);=0A=
+				break;=0A=
+			case XFER_UDMA_5:=0A=
+				outb(0x10+adj, indexreg);=0A=
+				outb(0x1a, datareg);=0A=
+				outb(0x11+adj, indexreg);=0A=
+				outb(0x02, datareg);=0A=
+				outb(0x12+adj, indexreg);=0A=
+				outb(0xcb, datareg);=0A=
+				break;=0A=
+			case XFER_UDMA_6:=0A=
+				outb(0x10+adj, indexreg);=0A=
+				outb(0x1a, datareg);=0A=
+				outb(0x11+adj, indexreg);=0A=
+				outb(0x01, datareg);=0A=
+				outb(0x12+adj, indexreg);=0A=
+				outb(0xcb, datareg);=0A=
+				break;=0A=
+#endif /* CONFIG_BLK_DEV_IDEDMA */=0A=
+			default:	break;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
 #if PDC202XX_DEBUG_DRIVE_INFO=0A=
 	printk("%s: %s drive%d 0x%08x ",=0A=
 		drive->name, ide_xfer_verbose(speed),=0A=
@@ -519,22 +638,38 @@=0A=
 #ifdef CONFIG_BLK_DEV_IDEDMA=0A=
 static int config_chipset_for_dma (ide_drive_t *drive, byte ultra)=0A=
 {=0A=
-	struct hd_driveid *id	=3D drive->id;=0A=
-	ide_hwif_t *hwif	=3D HWIF(drive);=0A=
-	struct pci_dev *dev	=3D hwif->pci_dev;=0A=
-	unsigned long high_16   =3D pci_resource_start(dev, 4);=0A=
-	unsigned long dma_base  =3D hwif->dma_base;=0A=
-	byte unit		=3D (drive->select.b.unit & 0x01);=0A=
+	struct hd_driveid *id		=3D drive->id;=0A=
+	ide_hwif_t *hwif		=3D HWIF(drive);=0A=
+	struct pci_dev *dev		=3D hwif->pci_dev;=0A=
+	unsigned long high_16   	=3D pci_resource_start(dev, 4);=0A=
+	unsigned long dma_base  	=3D hwif->dma_base;=0A=
+	unsigned long indexreg		=3D dma_base+1;=0A=
+	unsigned long datareg		=3D indexreg+2;=0A=
+	byte unit			=3D (drive->select.b.unit & 0x01);=0A=
+	byte	iordy			=3D 0x13;=0A=
+	byte	adj			=3D (drive->dn%2) ? 0x08 : 0x00;=0A=
+	byte 	cable			=3D 0;=0A=
 =0A=
 	unsigned int		drive_conf;=0A=
-	byte			drive_pci;=0A=
+	byte			drive_pci =3D 0;=0A=
 	byte			test1, test2, speed =3D -1;=0A=
 	byte			AP;=0A=
 	unsigned short		EP;=0A=
 	byte CLKSPD		=3D IN_BYTE(high_16 + 0x11);=0A=
-	byte udma_33		=3D ultra ? (inb(high_16 + 0x001f) & 1) : 0;=0A=
+	byte udma_33		=3D ultra;=0A=
 	byte udma_66		=3D ((eighty_ninty_three(drive)) && udma_33) ? 1 : 0;=0A=
-	byte udma_100		=3D (((dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20265) =
|| (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20267) || (dev->device =
=3D=3D PCI_DEVICE_ID_PROMISE_20268)) && udma_66) ? 1 : 0;=0A=
+	byte udma_100		=3D (((dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20265) =
||=0A=
+				    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20267) ||=0A=
+				     new_chip) && udma_66) ? 1 : 0;=0A=
+	byte udma_133		=3D (((dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20269) =
||=0A=
+				    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20275))=0A=
+				     && udma_100) ? 1 : 0;=0A=
+	byte mask		=3D hwif->channel ? 0x08 : 0x02;=0A=
+	unsigned short c_mask	=3D hwif->channel ? (1<<11) : (1<<10);=0A=
+	byte ultra_66		=3D ((id->dma_ultra & 0x0010) || =0A=
+			           (id->dma_ultra & 0x0008)) ? 1 : 0;=0A=
+	byte ultra_100		=3D ((id->dma_ultra & 0x0020) || (ultra_66)) ? 1 : 0;=0A=
+	byte ultra_133		=3D ((id->dma_ultra & 0x0040) || (ultra_100)) ? 1 : 0;=0A=
 =0A=
 	/*=0A=
 	 * Set the control register to use the 66Mhz system=0A=
@@ -548,21 +683,18 @@=0A=
 	 * leave the 66Mhz clock on and readjust the timing=0A=
 	 * parameters.=0A=
 	 */=0A=
-=0A=
-	byte mask		=3D hwif->channel ? 0x08 : 0x02;=0A=
-	unsigned short c_mask	=3D hwif->channel ? (1<<11) : (1<<10);=0A=
-	byte ultra_66		=3D ((id->dma_ultra & 0x0010) ||=0A=
-				   (id->dma_ultra & 0x0008)) ? 1 : 0;=0A=
-	byte ultra_100		=3D ((id->dma_ultra & 0x0020) ||=0A=
-				   (id->dma_ultra & 0x0010) ||=0A=
-				   (id->dma_ultra & 0x0008)) ? 1 : 0;=0A=
-=0A=
-	if (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20268)=0A=
-		goto jump_pci_mucking;=0A=
-=0A=
-	pci_read_config_word(dev, 0x50, &EP);=0A=
-=0A=
-	if (((ultra_66) || (ultra_100)) && (EP & c_mask)) {=0A=
+	=0A=
+	if (new_chip)=0A=
+	{=0A=
+		outb(0x0b,indexreg);=0A=
+		cable=3D(inb(datareg)&0x04);	/* check 80pin cable? */=0A=
+	}=0A=
+	else {=0A=
+		pci_read_config_word(dev, 0x50, &EP);=0A=
+		cable=3D(EP & c_mask);		/* check 80pin cable? */=0A=
+	}	=0A=
+	=0A=
+	if (((ultra_66) || (ultra_100) || (ultra_133)) && (cable)) {=0A=
 #ifdef DEBUG=0A=
 		printk("ULTRA66: %s channel of Ultra 66 requires an 80-pin cable for =
Ultra66 operation.\n", hwif->channel ? "Secondary" : "Primary");=0A=
 		printk("         Switching to Ultra33 mode.\n");=0A=
@@ -570,14 +702,19 @@=0A=
 		/* Primary   : zero out second bit */=0A=
 		/* Secondary : zero out fourth bit */=0A=
 		OUT_BYTE(CLKSPD & ~mask, (high_16 + 0x11));=0A=
+		printk("Warning: %s channel requires an 80-pin cable for =
operation.\n",=0A=
+			hwif->channel ? "Secondary":"Primary");=0A=
+		printk("%s reduced to Ultra33 mode.\n", drive->name);=0A=
+		udma_66=3D0;	udma_100=3D0;	udma_133=3D0;=0A=
 	} else {=0A=
-		if ((ultra_66) || (ultra_100)) {=0A=
+		if ((ultra_66) || (ultra_100) || (ultra_133)) {=0A=
 			/*=0A=
 			 * check to make sure drive on same channel=0A=
 			 * is u66 capable=0A=
 			 */=0A=
 			if (hwif->drives[!(drive->dn%2)].id) {=0A=
-				if ((hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0020) ||=0A=
+				if ((hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0040) ||=0A=
+				    (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0020) ||=0A=
 				    (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0010) ||=0A=
 				    (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0008)) {=0A=
 					OUT_BYTE(CLKSPD | mask, (high_16 + 0x11));=0A=
@@ -589,7 +726,8 @@=0A=
 			}=0A=
 		}=0A=
 	}=0A=
-=0A=
+    if (!(new_chip))=0A=
+    {=0A=
 	switch(drive->dn) {=0A=
 		case 0:	drive_pci =3D 0x60;=0A=
 			pci_read_config_dword(dev, drive_pci, &drive_conf);=0A=
@@ -639,10 +777,18 @@=0A=
 	pci_read_config_byte(dev, (drive_pci), &AP);=0A=
 	if (drive->media =3D=3D ide_disk)	/* PREFETCH_EN */=0A=
 		pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);=0A=
-=0A=
-jump_pci_mucking:=0A=
-=0A=
-	if ((id->dma_ultra & 0x0020) && (udma_100))	speed =3D XFER_UDMA_5;=0A=
+    }=0A=
+    else=0A=
+    {=0A=
+    	if (drive->media !=3D ide_disk)	return ide_dma_off_quietly;=0A=
+	if (id->capability & 4)	/* IORDY_EN & PREFETCH_EN*/=0A=
+	{=0A=
+		outb(iordy+adj, indexreg);=0A=
+		outb((inb(datareg)|0x03), datareg);=0A=
+	}=0A=
+    }=0A=
+    	if ((id->dma_ultra & 0x0040) && (udma_133))	speed =3D XFER_UDMA_6;=0A=
+	else if ((id->dma_ultra & 0x0020) && (udma_100))	speed =3D XFER_UDMA_5;=0A=
 	else if ((id->dma_ultra & 0x0010) && (udma_66))	speed =3D XFER_UDMA_4;=0A=
 	else if ((id->dma_ultra & 0x0008) && (udma_66))	speed =3D XFER_UDMA_3;=0A=
 	else if ((id->dma_ultra & 0x0004) && (udma_33))	speed =3D XFER_UDMA_2;=0A=
@@ -656,7 +802,7 @@=0A=
 	else if (id->dma_1word & 0x0001)		speed =3D XFER_SW_DMA_0;=0A=
 	else {=0A=
 		/* restore original pci-config space */=0A=
-		if (dev->device !=3D PCI_DEVICE_ID_PROMISE_20268)=0A=
+		if (!(new_chip))=0A=
 			pci_write_config_dword(dev, drive_pci, drive_conf);=0A=
 		return ide_dma_off_quietly;=0A=
 	}=0A=
@@ -664,11 +810,13 @@=0A=
 	outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);=0A=
 	(void) pdc202xx_tune_chipset(drive, speed);=0A=
 =0A=
-	return ((int)	((id->dma_ultra >> 11) & 7) ? ide_dma_on :=0A=
+	=0A=
+	return ((int)	((id->dma_ultra >> 14) & 3) ? ide_dma_on :=0A=
+			((id->dma_ultra >> 11) & 7) ? ide_dma_on :=0A=
 			((id->dma_ultra >> 8) & 7) ? ide_dma_on :=0A=
 			((id->dma_mword >> 8) & 7) ? ide_dma_on : =0A=
 			((id->dma_1word >> 8) & 7) ? ide_dma_on :=0A=
-						     ide_dma_off_quietly);=0A=
+			ide_dma_off_quietly);=0A=
 }=0A=
 =0A=
 static int config_drive_xfer_rate (ide_drive_t *drive)=0A=
@@ -685,7 +833,7 @@=0A=
 		}=0A=
 		dma_func =3D ide_dma_off_quietly;=0A=
 		if (id->field_valid & 4) {=0A=
-			if (id->dma_ultra & 0x002F) {=0A=
+			if (id->dma_ultra & 0x007F) {=0A=
 				/* Force if Capable UltraDMA */=0A=
 				dma_func =3D config_chipset_for_dma(drive, 1);=0A=
 				if ((id->field_valid & 2) &&=0A=
@@ -757,6 +905,13 @@=0A=
 		case ide_dma_timeout:=0A=
 			if (HWIF(drive)->resetproc !=3D NULL)=0A=
 				HWIF(drive)->resetproc(drive);=0A=
+			break;=0A=
+		/*=0A=
+		case ide_dma_off:=0A=
+			printk("PDC202XX: Force DMA keep on.\n");=0A=
+			return (0);=0A=
+			//func=3Dide_dma_check;	// Fix me!!=0A=
+		*/=0A=
 		default:=0A=
 			break;=0A=
 	}=0A=
@@ -766,13 +921,12 @@=0A=
 =0A=
 void pdc202xx_reset (ide_drive_t *drive)=0A=
 {=0A=
-	unsigned long high_16	=3D pci_resource_start(HWIF(drive)->pci_dev, 4);=0A=
-	byte udma_speed_flag	=3D inb(high_16 + 0x001f);=0A=
-=0A=
-	OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);=0A=
-	mdelay(100);=0A=
-	OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);=0A=
-	mdelay(2000);		/* 2 seconds ?! */=0A=
+	outb(0x04,IDE_CONTROL_REG);=0A=
+	mdelay(1000);=0A=
+	outb(0x00,IDE_CONTROL_REG);=0A=
+	mdelay(1000);=0A=
+	printk("PDC202XX: %s channel reset.\n",=0A=
+		 HWIF(drive)->channel ? "Secondary":"Primary");=0A=
 }=0A=
 =0A=
 unsigned int __init pci_init_pdc202xx (struct pci_dev *dev, const char =
*name)=0A=
@@ -784,6 +938,9 @@=0A=
 =0A=
 	if ((dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20262) ||=0A=
 	    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20265) ||=0A=
+	    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20268) ||=0A=
+	    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20269) ||=0A=
+	    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20275) ||=0A=
 	    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20267)) {=0A=
 		/*=0A=
 		 * software reset -  this is required because the bios=0A=
@@ -800,6 +957,10 @@=0A=
 		OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);=0A=
 		mdelay(2000);	/* 2 seconds ?! */=0A=
 	}=0A=
+	if ((dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20268) ||=0A=
+	    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20269) ||=0A=
+	    (dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20275))=0A=
+	        	new_chip=3D1;=0A=
 =0A=
 	if (dev->resource[PCI_ROM_RESOURCE].start) {=0A=
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, =
dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);=0A=
@@ -813,7 +974,7 @@=0A=
 		if ((irq !=3D irq2) &&=0A=
 		    (dev->device !=3D PCI_DEVICE_ID_PROMISE_20265) &&=0A=
 		    (dev->device !=3D PCI_DEVICE_ID_PROMISE_20267) &&=0A=
-		    (dev->device !=3D PCI_DEVICE_ID_PROMISE_20268)) {=0A=
+		    !(new_chip)) {=0A=
 			pci_write_config_byte(dev, (PCI_INTERRUPT_LINE)|0x80, irq);	/* 0xbc =
*/=0A=
 			printk("%s: pci-config space interrupt mirror fixed.\n", name);=0A=
 		}=0A=
@@ -866,10 +1027,19 @@=0A=
 	unsigned short mask =3D (hwif->channel) ? (1<<11) : (1<<10);=0A=
 	unsigned short CIS;=0A=
 =0A=
-	pci_read_config_word(hwif->pci_dev, 0x50, &CIS);=0A=
-	return ((CIS & mask) ? 0 : 1);=0A=
+	 switch(hwif->pci_dev->device) {=0A=
+		case PCI_DEVICE_ID_PROMISE_20275:=0A=
+		case PCI_DEVICE_ID_PROMISE_20269:=0A=
+		case PCI_DEVICE_ID_PROMISE_20268:=0A=
+			OUT_BYTE(0x0b, (hwif->dma_base + 1));=0A=
+			return (!(IN_BYTE((hwif->dma_base + 3)) & 0x04));=0A=
+			/* check 80pin cable */=0A=
+		default:=0A=
+			pci_read_config_word(hwif->pci_dev, 0x50, &CIS);=0A=
+			return (!(CIS & mask));=0A=
+			/* check 80pin cable */=0A=
+	}=0A=
 }=0A=
-=0A=
 void __init ide_init_pdc202xx (ide_hwif_t *hwif)=0A=
 {=0A=
 	hwif->tuneproc	=3D &pdc202xx_tune_drive;=0A=
@@ -878,6 +1048,9 @@=0A=
 =0A=
 	if ((hwif->pci_dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20262) ||=0A=
 	    (hwif->pci_dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20265) ||=0A=
+	    (hwif->pci_dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20268) ||=0A=
+	    (hwif->pci_dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20269) ||=0A=
+	    (hwif->pci_dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20275) ||=0A=
 	    (hwif->pci_dev->device =3D=3D PCI_DEVICE_ID_PROMISE_20267)) {=0A=
 		hwif->resetproc	=3D &pdc202xx_reset;=0A=
 	}=0A=
diff -urN linux-2.4.18.org/include/linux/hdreg.h =
linux/include/linux/hdreg.h=0A=
--- linux-2.4.18.org/include/linux/hdreg.h	Fri Nov 23 03:46:18 2001=0A=
+++ linux/include/linux/hdreg.h	Wed Feb 27 19:54:12 2002=0A=
@@ -81,6 +81,14 @@=0A=
 =0A=
 #define WIN_SMART		0xB0	/* self-monitoring and reporting */=0A=
 =0A=
+/* Additianal command for 48 Bit LBA */=0A=
+#define READ_EXT		0x24=0A=
+#define WRITE_EXT		0x34=0A=
+#define MULTI_READ_EXT		0x29=0A=
+#define MULTI_WRITE_EXT		0x39=0A=
+#define READ_DMA_EXT		0x25=0A=
+#define WRITE_DMA_EXT		0x35=0A=
+=0A=
 /* Additional drive command codes used by ATAPI devices. */=0A=
 #define WIN_PIDENTIFY		0xA1	/* identify ATAPI device	*/=0A=
 #define WIN_SRST		0x08	/* ATAPI soft reset command */=0A=
diff -urN linux-2.4.18.org/include/linux/pci_ids.h =
linux/include/linux/pci_ids.h=0A=
--- linux-2.4.18.org/include/linux/pci_ids.h	Tue Feb 26 03:38:13 2002=0A=
+++ linux/include/linux/pci_ids.h	Wed Feb 27 19:45:18 2002=0A=
@@ -603,7 +603,6 @@=0A=
 #define PCI_DEVICE_ID_PROMISE_20246	0x4d33=0A=
 #define PCI_DEVICE_ID_PROMISE_20262	0x4d38=0A=
 #define PCI_DEVICE_ID_PROMISE_20268	0x4d68=0A=
-#define PCI_DEVICE_ID_PROMISE_20268R	0x6268=0A=
 #define PCI_DEVICE_ID_PROMISE_20269	0x4d69=0A=
 #define PCI_DEVICE_ID_PROMISE_20275	0x1275=0A=
 #define PCI_DEVICE_ID_PROMISE_5300	0x5300=0A=

------=_NextPart_000_014E_01C1C697.531D8750--

