Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSBXNxN>; Sun, 24 Feb 2002 08:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288971AbSBXNxF>; Sun, 24 Feb 2002 08:53:05 -0500
Received: from hera.cwi.nl ([192.16.191.8]:19406 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288736AbSBXNwo>;
	Sun, 24 Feb 2002 08:52:44 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 24 Feb 2002 14:52:40 +0100 (MET)
Message-Id: <UTC200202241352.g1ODqeb08003.aeb@apps.cwi.nl>
To: dalecki@evision-ventures.com, torvalds@transmeta.com
Subject: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since this apparently didn't get through to the mailing list
> I'm sending it again. This time compressed.

Pity - noncompressed is better, now only people with too much time
will look at it.

There is something else one might do.
In ide-geometry.c there is the routine probe_cmos_for_drives().
Long ago I already wrote "Eventually the entire routine below
should be removed". I think this is the proper time to do this.

This probe is done only for the i386 architecture, and only
for the first two IDE disks, and only influences their geometry.
It has been a pain - for example, it gives the first two disks
a different geometry from the others, which is inconvenient
when one want a RAID of identical disks.

So, it is good to rip this out and push the inconvenience to
people with ancient hardware. (People with MFM disks may need
boot parameters now.)
When this is gone, much more can go, both in the IDE code and
in setup.S.

Andries


diff -u ../linux-2.5.5/linux/drivers/ide/ide-geometry.c linux/drivers/ide/ide-geometry.c
--- ../linux-2.5.5/linux/drivers/ide/ide-geometry.c	Sun Feb  3 12:35:52 2002
+++ linux/drivers/ide/ide-geometry.c	Mon Feb 25 15:18:09 2002
@@ -6,89 +6,6 @@
 #include <linux/mc146818rtc.h>
 #include <asm/io.h>
 
-#ifdef CONFIG_BLK_DEV_IDE
-
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
- */
-/*
- * The only "perfect" way to handle this would be to modify the setup.[cS] code
- * to do BIOS calls Int13h/Fn08h and Int13h/Fn48h to get all of the drive info
- * for us during initialization.  I have the necessary docs -- any takers?  -ml
- */
-/*
- * I did this, but it doesnt work - there is no reasonable way to find the
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
-	byte cmos_disks, *BIOS = (byte *) &drive_info;
-	int unit;
-	unsigned long flags;
-
-#ifdef CONFIG_BLK_DEV_PDC4030
-	if (hwif->chipset == ide_pdc4030 && hwif->channel != 0)
-		return;
-#endif /* CONFIG_BLK_DEV_PDC4030 */
-	spin_lock_irqsave(&rtc_lock, flags);
-	cmos_disks = CMOS_READ(0x12);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	/* Extract drive geometry from CMOS+BIOS if not already setup */
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		ide_drive_t *drive = &hwif->drives[unit];
-
-		if ((cmos_disks & (0xf0 >> (unit*4)))
-		   && !drive->present && !drive->nobios) {
-			unsigned short cyl = *(unsigned short *)BIOS;
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
-#endif /* CONFIG_BLK_DEV_IDE */
-
-
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 
 extern ide_drive_t * get_info_ptr(kdev_t);
diff -u ../linux-2.5.5/linux/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- ../linux-2.5.5/linux/drivers/ide/ide-probe.c	Thu Feb 21 23:50:02 2002
+++ linux/drivers/ide/ide-probe.c	Mon Feb 25 15:18:45 2002
@@ -509,13 +509,6 @@
 
 	if (hwif->noprobe)
 		return;
-#ifdef CONFIG_BLK_DEV_IDE
-	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA) {
-		extern void probe_cmos_for_drives(ide_hwif_t *);
-
-		probe_cmos_for_drives (hwif);
-	}
-#endif
 
 	if ((hwif->chipset != ide_4drives || !hwif->mate->present) &&
 #if CONFIG_BLK_DEV_PDC4030
