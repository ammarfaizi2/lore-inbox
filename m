Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUC3P2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbUC3P2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:28:12 -0500
Received: from witte.sonytel.be ([80.88.33.193]:1758 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263721AbUC3P07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:26:59 -0500
Date: Tue, 30 Mar 2004 17:26:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-15?Q?Andr=E9_Hedrick?= <andre@linux-ide.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Bogus LBA48 drives
In-Reply-To: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0403301722580.9767@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Geert Uytterhoeven wrote:
> Apparently some IDE drives (e.g. a pile of 80 GB ST380020ACE drives I have
> access to) advertise to support LBA48, but don't, causing kernels that support
> LBA48 (i.e. anything newer than 2.4.18, including 2.4.25 and 2.6.4) to fail on
> them.  Older kernels (including 2.2.20 on the Debian woody CDs) work fine.
>
> One problem with those drives is that the lba_capacity_2 field in their drive
> identification is set to 0, making the IDE driver think the disk is 0 bytes
> large. At first I tried modifying the driver to use lba_capacity if
> lba_capacity_2 is set to 0, but this caused disk errors. So it looks like those
> drives don't support the increased transfer size of LBA48 neither.
>
> I added a workaround for these drives to both 2.4.25 and 2.6.4. I'll send
> patches in follow-up emails.

Patch for 2.4.25 (and 2.4.26-rc1):
  - Remove useless check for LBA48 from lba_capacity_is_ok(), which is called
    for non-LBA48 drives only
  - Add idedisk_supports_lba48() (cfr. 2.6) and check for lba_capacity_2 being
    non-zero
  - Use idedisk_supports_lba48() to check for LBA48 at various places

Caveat: originally I made the patch for the Debianized 2.4.25, and I had to
modify it a bit since the Debian kernel changed some logic.

--- linux-2.4.25/drivers/ide/ide-disk.c.orig	2003-10-23 13:35:27.000000000 +0200
+++ linux-2.4.25/drivers/ide/ide-disk.c	2004-03-30 17:21:07.000000000 +0200
@@ -105,11 +105,6 @@
 {
 	unsigned long lba_sects, chs_sects, head, tail;

-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		printk("48-bit Drive: %llu \n", id->lba_capacity_2);
-		return 1;
-	}
-
 	/*
 	 * The ATA spec tells large drives to return
 	 * C/H/S = 16383/16/63 independent of their size.
@@ -142,6 +137,12 @@
 	return 0;	/* lba_capacity value may be bad */
 }

+static inline int idedisk_supports_lba48(const ide_drive_t *drive)
+{
+	return (drive->id->command_set_2 & 0x0400) &&
+	       (drive->id->cfs_enable_2 & 0x0400) && drive->id->lba_capacity_2;
+}
+
 #ifndef CONFIG_IDE_TASKFILE_IO

 /*
@@ -560,7 +561,7 @@

 static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
 {
-	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
+	int lba48bit = idedisk_supports_lba48(drive);

 #if 1
 	lba48bit = (drive->addressing == 1) ? 1 : 0;
@@ -1170,7 +1171,7 @@

 	(void) idedisk_supports_host_protected_area(drive);

-	if (id->cfs_enable_2 & 0x0400) {
+	if (idedisk_supports_lba48(drive)) {
 		capacity_2 = id->lba_capacity_2;
 		drive->head		= drive->bios_head = 255;
 		drive->sect		= drive->bios_sect = 63;
@@ -1222,7 +1223,7 @@

 	drive->capacity = capacity;

-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
+	if (idedisk_supports_lba48(drive)) {
 		drive->capacity48 = id->lba_capacity_2;
 		drive->head = 255;
 		drive->sect = 63;
@@ -1241,7 +1242,7 @@

 static unsigned long idedisk_capacity (ide_drive_t *drive)
 {
-	if (drive->id->cfs_enable_2 & 0x0400)
+	if (idedisk_supports_lba48(drive))
 		return (drive->capacity48 - drive->sect0);
 	return (drive->capacity - drive->sect0);
 }
@@ -1567,7 +1568,7 @@
 	if (HWIF(drive)->addressing)
 		return 0;

-	if (!(drive->id->cfs_enable_2 & 0x0400))
+	if (!idedisk_supports_lba48(drive))
                 return -EIO;
 	drive->addressing = arg;
 	return 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
