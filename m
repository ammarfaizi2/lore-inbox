Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264186AbTCXM6s>; Mon, 24 Mar 2003 07:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264187AbTCXM6s>; Mon, 24 Mar 2003 07:58:48 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:16512 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S264186AbTCXM6g>; Mon, 24 Mar 2003 07:58:36 -0500
Date: Mon, 24 Mar 2003 22:08:46 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac4] Complete support for PC-9800 sub-arch (4/9) IDE
Message-ID: <20030324130846.GD2508@yuzuki.cinet.co.jp>
References: <20030324130025.GA2465@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324130025.GA2465@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac4. (4/9)

PC98 standard IDE I/F support.
 - Change default IO port address and IRQ.
 - Request region exactly for other optional cards.
 - Get BIOS C/H/S parameter for PC98.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64-ac3/drivers/ide/ide-disk.c linux98-2.5.64-ac3/drivers/ide/ide-disk.c
--- linux-2.5.64-ac3/drivers/ide/ide-disk.c	2003-03-08 12:13:46.000000000 +0900
+++ linux98-2.5.64-ac3/drivers/ide/ide-disk.c	2003-03-08 12:29:29.000000000 +0900
@@ -1574,6 +1574,71 @@
 
 	(void) probe_lba_addressing(drive, 1);
 
+#ifdef CONFIG_X86_PC9800
+	/* XXX - need more checks */
+	if (!drive->nobios && !drive->scsi && !drive->removable) {
+		/* PC-9800's BIOS do pack drive numbers to be continuous,
+		   so extra work is needed here.  */
+
+		/* drive information passed from boot/setup.S */
+		struct drive_info_struct {
+			u16 cyl;
+			u8 sect, head;
+			u16 ssize;
+		} __attribute__ ((packed));
+		extern struct drive_info_struct drive_info[];
+
+		/* this pointer must be advanced only when *DRIVE is
+		   really hard disk. */
+		static struct drive_info_struct *info = drive_info;
+
+		if (info < &drive_info[4] && info->cyl) {
+			drive->cyl  = drive->bios_cyl  = info->cyl;
+			drive->head = drive->bios_head = info->head;
+			drive->sect = drive->bios_sect = info->sect;
+			++info;
+		}
+	}
+
+	/* =PC98 MEMO=
+	   physical capacity =< 65535*8*17 sect. : H/S=8/17 (fixed)
+	   physical capacity > 65535*8*17 sect. : use physical geometry
+	   (65535*8*17 = 8912760 sectors)
+	*/
+	printk("%s: CHS: physical %d/%d/%d, logical %d/%d/%d, BIOS %d/%d/%d\n",
+	       drive->name,
+	       id->cyls,	id->heads,	id->sectors,
+	       id->cur_cyls,	id->cur_heads,	id->cur_sectors,
+	       drive->bios_cyl,	drive->bios_head,drive->bios_sect);
+	if (!drive->cyl || !drive->head || !drive->sect) {
+		drive->cyl     = drive->bios_cyl  = id->cyls;
+		drive->head    = drive->bios_head = id->heads;
+		drive->sect    = drive->bios_sect = id->sectors;
+		printk("%s: not BIOS-supported device.\n",drive->name);
+	}
+	/* calculate drive capacity, and select LBA if possible */
+	init_idedisk_capacity(drive);
+
+	/*
+	 * if possible, give fdisk access to more of the drive,
+	 * by correcting bios_cyls:
+	 */
+	capacity = idedisk_capacity(drive);
+	if (capacity < 8912760 &&
+	   (drive->head != 8 || drive->sect != 17)) {
+		drive->head = drive->bios_head = 8;
+		drive->sect = drive->bios_sect = 17;
+		drive->cyl  = drive->bios_cyl  =
+			capacity / (drive->bios_head * drive->bios_sect);
+		printk("%s: Fixing Geometry :: CHS=%d/%d/%d to CHS=%d/%d/%d\n",
+			   drive->name,
+			   id->cur_cyls,id->cur_heads,id->cur_sectors,
+			   drive->bios_cyl,drive->bios_head,drive->bios_sect);
+		id->cur_cyls    = drive->bios_cyl;
+		id->cur_heads   = drive->bios_head;
+		id->cur_sectors = drive->bios_sect;
+	}
+#else /* !CONFIG_X86_PC9800 */
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
 		drive->cyl     = drive->bios_cyl  = id->cyls;
@@ -1607,6 +1672,8 @@
 	if ((capacity >= (drive->bios_cyl * drive->bios_sect * drive->bios_head)) &&
 	    (!drive->forced_geom) && drive->bios_sect && drive->bios_head)
 		drive->bios_cyl = (capacity / drive->bios_sect) / drive->bios_head;
+#endif  /* CONFIG_X86_PC9800 */
+
 	printk (KERN_INFO "%s: %ld sectors", drive->name, capacity);
 
 	/* Give size in megabytes (MB), not mebibytes (MiB). */
diff -Nru linux-2.5.65-ac2/drivers/ide/ide-probe.c linux98-2.5.65-ac2/drivers/ide/ide-probe.c
--- linux-2.5.65-ac2/drivers/ide/ide-probe.c	2003-03-22 10:41:33.000000000 +0900
+++ linux98-2.5.65-ac2/drivers/ide/ide-probe.c	2003-03-22 20:12:09.000000000 +0900
@@ -669,7 +669,7 @@
 
 	if (hwif->mmio == 2)
 		return 0;
-	addr_errs  = hwif_check_region(hwif, hwif->io_ports[IDE_DATA_OFFSET], 1);
+	addr_errs  = hwif_check_region(hwif, hwif->io_ports[IDE_DATA_OFFSET], pc98 ? 2 : 1);
 	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET; i++)
 		addr_errs += hwif_check_region(hwif, hwif->io_ports[i], 1);
 	if (hwif->io_ports[IDE_CONTROL_OFFSET])
@@ -718,7 +718,9 @@
 	}
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		hwif_request_region(hwif->io_ports[i], 1, hwif->name);
+		hwif_request_region(hwif->io_ports[i],
+					(pc98 && i == IDE_DATA_OFFSET) ? 2 : 1,
+					hwif->name);
 }
 
 //EXPORT_SYMBOL(hwif_register);
@@ -806,6 +808,9 @@
 #if CONFIG_BLK_DEV_PDC4030
 	    (hwif->chipset != ide_pdc4030 || hwif->channel == 0) &&
 #endif /* CONFIG_BLK_DEV_PDC4030 */
+#if CONFIG_BLK_DEV_IDE_PC9800
+	    (hwif->chipset != ide_pc9800 || !hwif->mate->present) &&
+#endif
 	    (hwif_check_regions(hwif))) {
 		u16 msgout = 0;
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
@@ -1172,7 +1177,7 @@
 		ide_init_drive(drive);
 	}
 
-#if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
+#if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__) && !defined(CONFIG_X86_PC9800)
 	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET],
 		hwif->io_ports[IDE_DATA_OFFSET]+7,
@@ -1182,6 +1187,11 @@
 		hwif->io_ports[IDE_DATA_OFFSET],
 		hwif->io_ports[IDE_DATA_OFFSET]+7,
 		hwif->io_ports[IDE_CONTROL_OFFSET], __irq_itoa(hwif->irq));
+#elif defined(CONFIG_X86_PC9800)
+	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
+		hwif->io_ports[IDE_DATA_OFFSET],
+		hwif->io_ports[IDE_DATA_OFFSET]+15,
+		hwif->io_ports[IDE_CONTROL_OFFSET], hwif->irq);
 #else
 	printk("%s at %x on irq 0x%08x", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET], hwif->irq);
diff -Nru linux-2.5.65-ac1/drivers/ide/ide.c linux98-2.5.65-ac1/drivers/ide/ide.c
--- linux-2.5.65-ac1/drivers/ide/ide.c	2003-03-20 09:09:44.000000000 +0900
+++ linux98-2.5.65-ac4/drivers/ide/ide.c	2003-03-20 11:20:47.000000000 +0900
@@ -550,7 +550,8 @@
 	}
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		if (hwif->io_ports[i]) {
-			hwif_release_region(hwif->io_ports[i], 1);
+			hwif_release_region(hwif->io_ports[i],
+					(pc98 && i == IDE_DATA_OFFSET) ? 2 : 1);
 		}
 	}
 }
@@ -2117,6 +2118,12 @@
 	}
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 
+#ifdef CONFIG_BLK_DEV_IDE_PC9800
+	{
+		extern void ide_probe_for_pc9800(void);
+		ide_probe_for_pc9800();
+	}
+#endif
 #ifdef CONFIG_ETRAX_IDE
 	{
 		extern void init_e100_ide(void);
diff -Nru linux/include/linux/hdreg.h linux98/include/linux/hdreg.h
--- linux/include/linux/hdreg.h	2003-02-15 08:51:42.000000000 +0900
+++ linux98/include/linux/hdreg.h	2003-02-20 10:18:37.000000000 +0900
@@ -5,11 +5,29 @@
  * This file contains some defines for the AT-hd-controller.
  * Various sources.
  */
+#include <linux/config.h>
 
 /* ide.c has its own port definitions in "ide.h" */
 
 #define HD_IRQ		14
 
+#ifdef CONFIG_X86_PC9800
+/* Hd controller regs. for NEC PC-9800 */
+#define HD_DATA		0x640	/* _CTL when writing */
+#define HD_ERROR	0x642	/* see err-bits */
+#define HD_NSECTOR	0x644	/* nr of sectors to read/write */
+#define HD_SECTOR	0x646	/* starting sector */
+#define HD_LCYL		0x648	/* starting cylinder */
+#define HD_HCYL		0x64a	/* high byte of starting cyl */
+#define HD_CURRENT	0x64c	/* 101dhhhh , d=drive, hhhh=head */
+#define HD_STATUS	0x64e	/* see status-bits */
+#define HD_FEATURE	HD_ERROR	/* same io address, read=error, write=feature */
+#define HD_PRECOMP	HD_FEATURE	/* obsolete use of this port - predates IDE */
+#define HD_COMMAND	HD_STATUS	/* same io address, read=status, write=cmd */
+
+#define HD_CMD		0x74c	/* used for resets */
+#define HD_ALTSTATUS	0x74c	/* same as HD_STATUS but doesn't clear irq */
+#else /* !CONFIG_X86_PC9800 */
 /* Hd controller regs. Ref: IBM AT Bios-listing */
 #define HD_DATA		0x1f0		/* _CTL when writing */
 #define HD_ERROR	0x1f1		/* see err-bits */
@@ -25,6 +43,7 @@
 
 #define HD_CMD		0x3f6		/* used for resets */
 #define HD_ALTSTATUS	0x3f6		/* same as HD_STATUS but doesn't clear irq */
+#endif /* CONFIG_X86_PC9800 */
 
 /* remainder is shared between hd.c, ide.c, ide-cd.c, and the hdparm utility */
 
