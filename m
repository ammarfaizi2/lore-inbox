Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSLBT3B>; Mon, 2 Dec 2002 14:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSLBT3B>; Mon, 2 Dec 2002 14:29:01 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8905 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264944AbSLBT27>;
	Mon, 2 Dec 2002 14:28:59 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 2 Dec 2002 20:36:26 +0100 (MET)
Message-Id: <UTC200212021936.gB2JaQu06012.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] kill probe_cmos_for_drives
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-geometry.c b/drivers/ide/ide-geometry.c
--- a/drivers/ide/ide-geometry.c	Fri Nov 22 22:40:57 2002
+++ b/drivers/ide/ide-geometry.c	Mon Dec  2 18:17:04 2002
@@ -6,83 +6,6 @@
 #include <linux/mc146818rtc.h>
 #include <asm/io.h>
 
-/*
- * We query CMOS about hard disks : it could be that we have a SCSI/ESDI/etc
- * controller that is BIOS compatible with ST-506, and thus showing up in our
- * BIOS table, but not register compatible, and therefore not present in CMOS.
- *
- * Furthermore, we will assume that our ST-506 drives <if any> are the primary
- * drives in the system -- the ones reflected as drive 1 or 2.  The first
- * drive is stored in the high nibble of CMOS byte 0x12, the second in the low
- * nibble.  This will be either a 4 bit drive type or 0xf indicating use byte
- * 0x19 for an 8 bit type, drive 1, 0x1a for drive 2 in CMOS.  A non-zero value
- * means we have an AT controller hard disk for that drive.
- *
- * Of course, there is no guarantee that either drive is actually on the
- * "primary" IDE interface, but we don't bother trying to sort that out here.
- * If a drive is not actually on the primary interface, then these parameters
- * will be ignored.  This results in the user having to supply the logical
- * drive geometry as a boot parameter for each drive not on the primary i/f.
- *
- * The only "perfect" way to handle this would be to modify the setup.[cS] code
- * to do BIOS calls Int13h/Fn08h and Int13h/Fn48h to get all of the drive info
- * for us during initialization.  I have the necessary docs -- any takers?  -ml
- *
- * I did this, but it doesn't work - there is no reasonable way to find the
- * correspondence between the BIOS numbering of the disks and the Linux
- * numbering. -aeb
- *
- * The code below is bad. One of the problems is that drives 1 and 2
- * may be SCSI disks (even when IDE disks are present), so that
- * the geometry we read here from BIOS is attributed to the wrong disks.
- * Consequently, also the former "drive->present = 1" below was a mistake.
- *
- * Eventually the entire routine below should be removed.
- *
- * 17-OCT-2000 rjohnson@analogic.com Added spin-locks for reading CMOS
- * chip.
- */
-
-void probe_cmos_for_drives (ide_hwif_t *hwif)
-{
-#ifdef __i386__
-	extern struct drive_info_struct drive_info;
-	u8 cmos_disks, *BIOS = (u8 *) &drive_info;
-	int unit;
-	unsigned long flags;
-
-	if (hwif->chipset == ide_pdc4030 && hwif->channel != 0)
-		return;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	cmos_disks = CMOS_READ(0x12);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	/* Extract drive geometry from CMOS+BIOS if not already setup */
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		ide_drive_t *drive = &hwif->drives[unit];
-
-		if ((cmos_disks & (0xf0 >> (unit*4)))
-		   && !drive->present && !drive->nobios) {
-			u16 cyl = *(u16 *)BIOS;
-			unsigned char head = *(BIOS+2);
-			unsigned char sect = *(BIOS+14);
-			if (cyl > 0 && head > 0 && sect > 0 && sect < 64) {
-				drive->cyl   = drive->bios_cyl  = cyl;
-				drive->head  = drive->bios_head = head;
-				drive->sect  = drive->bios_sect = sect;
-				drive->ctl   = *(BIOS+8);
-			} else {
-				printk("hd%c: C/H/S=%d/%d/%d from BIOS ignored\n",
-				       unit+'a', cyl, head, sect);
-			}
-		}
-
-		BIOS += 16;
-	}
-#endif
-}
-
-
 extern unsigned long current_capacity (ide_drive_t *);
 
 /*
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Thu Nov 28 15:28:18 2002
+++ b/drivers/ide/ide-probe.c	Mon Dec  2 18:19:20 2002
@@ -639,12 +639,6 @@
 
 	if (hwif->noprobe)
 		return;
-#ifdef CONFIG_BLK_DEV_IDE
-	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA) {
-		extern void probe_cmos_for_drives(ide_hwif_t *);
-		probe_cmos_for_drives(hwif);
-	}
-#endif
 
 	if ((hwif->chipset != ide_4drives || !hwif->mate || !hwif->mate->present) &&
 #if CONFIG_BLK_DEV_PDC4030
