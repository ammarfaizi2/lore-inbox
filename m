Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSBYLzq>; Mon, 25 Feb 2002 06:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293387AbSBYLzg>; Mon, 25 Feb 2002 06:55:36 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:9482 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S293386AbSBYLzb>;
	Mon, 25 Feb 2002 06:55:31 -0500
Message-ID: <3C7A23E4.5EF118D1@yahoo.com>
Date: Mon, 25 Feb 2002 06:45:40 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.20 i586)
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
In-Reply-To: <UTC200202241352.g1ODqeb08003.aeb@apps.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

> There is something else one might do.
> In ide-geometry.c there is the routine probe_cmos_for_drives().
> Long ago I already wrote "Eventually the entire routine below
> should be removed". I think this is the proper time to do this.

Yes, I saw this & looked over my mail - we had similar discussion
& similar conclusion back in May 2000.  (Others may also find aeb's
notes from this old discussion useful - check the archives)

> So, it is good to rip this out and push the inconvenience to
> people with ancient hardware. (People with MFM disks may need
> boot parameters now.)

As a matter of fact, they would have needed to do so even since
2.3.28, when drive->present was no longer set.  Also from that
2 year old discussion is this patch to set capacity for non-IDE
drives. Fact is that ST-506 would even to this day not work with 
the ide driver without this patch. (Of course using hd.c on ST-506
era machines makes a lot more sense anyways, so this is pretty
much moot.)

Paul.

diff -u linux-r/drivers/ide-old/ide-disk.c linux-r/drivers/ide/ide-disk.c
--- linux-r/drivers/ide-old/ide-disk.c	Fri May 26 16:37:43 2000
+++ linux-r/drivers/ide/ide-disk.c	Sat May 27 14:33:27 2000
@@ -519,7 +519,6 @@
 
 /*
  * Compute drive->capacity, the full capacity of the drive
- * Called with drive->id != NULL.
  */
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
@@ -529,7 +528,7 @@
 	drive->select.b.lba = 0;
 
 	/* Determine capacity, and use LBA if the drive properly supports it */
-	if ((id->capability & 2) && lba_capacity_is_ok(id)) {
+	if (id != NULL && (id->capability & 2) && lba_capacity_is_ok(id)) {
 		capacity = id->lba_capacity;
 		drive->cyl = capacity / (drive->head * drive->sect);
 		drive->select.b.lba = 1;
@@ -759,8 +758,10 @@
 	
 	idedisk_add_settings(drive);
 
-	if (id == NULL)
+	if (id == NULL) {	/* Old, non-IDE drive */
+		init_idedisk_capacity(drive);
 		return;
+	}
 
 	/*
 	 * CompactFlash cards and their brethern look just like hard drives

