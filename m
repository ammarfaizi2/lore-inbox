Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267996AbUHPWdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267996AbUHPWdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUHPWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:32:44 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55199 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267994AbUHPWb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:31:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 00:29:07 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408161923.19024.bzolnier@elka.pw.edu.pl> <1092677759.21013.33.camel@localhost.localdomain>
In-Reply-To: <1092677759.21013.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408170029.07912.bzolnier@elka.pw.edu.pl>
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 August 2004 19:36, Alan Cox wrote:
> On Llu, 2004-08-16 at 18:23, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 15 August 2004 17:13, Alan Cox wrote:
> > > There really isnt any sane way to break this patch down because all the
> > > changes are interlinked so closely.
> >
> > at least /proc/ide/hd?/settings:ide-scsi removal and doc fixes are very
> > easy to separate, I also think that locking fixes should be separated
> > from hotplugging ones
>
> I continue to believe splitting the locking and hotplugging ones are
> essentially impossible without inventing a fake never written version.
> The other stuff can probably be done.
>
> If you can let me know which bits you are going to apply I can work on
> sorting out the rest. In the meantime I'll keep a -ac patch for people
> who want to work on the IDE bits or who need the fixes and driver
> updates.

I'm going to apply "easy" stuff first:
- /proc/ide/hd?/settings:ide-scsi removal
  (patch attached for your convenience)
- DocBook fixes
- misc comments fixes
- bad geometry hang fix
- no slave/master decoding workaround
- ...

I will defer applying locking/hotpluggin fixes - I need to fully understand 
them and check that they don't break anything - and ITE driver - it needs 
some minor cleanup first, also I want to check if we can't go with libata
for it...


[PATCH] ide: remove /proc/ide/hd?/settings:ide-scsi / HDIO_SET_IDE_SCSI ioctl

As noticed by Alan Cox:

"It doesn't work now so it clearly isnt being used 8). We hold the lock
because its a proc function and we then replace the proc functions in the
attach method -> deadlock. It is also incredibly hard to fix without a
major rewrite."

The same is true for HDIO_SET_IDE_SCSI ioctl.

Both were broken 18 months ago in 2.5.63 as a side-effect of Alan's locking
fixes for ide settings and AFAIR there wasn't any complains about it.

Also /proc/ide/hd?/driver interface is still available.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.8.1-bzolnier/drivers/ide/ide.c     |   19 -------------------
 linux-2.6.8.1-bzolnier/include/linux/hdreg.h |    5 ++---
 linux-2.6.8.1-bzolnier/include/linux/ide.h   |    2 +-
 3 files changed, 3 insertions(+), 23 deletions(-)

diff -puN drivers/ide/ide.c~ide_scsi_proc drivers/ide/ide.c
--- linux-2.6.8.1/drivers/ide/ide.c~ide_scsi_proc	2004-08-16 
19:55:00.324694184 +0200
+++ linux-2.6.8.1-bzolnier/drivers/ide/ide.c	2004-08-16 19:55:00.353689776 
+0200
@@ -1322,23 +1322,6 @@ static int set_xfer_rate (ide_drive_t *d
 	return err;
 }
 
-int ide_atapi_to_scsi (ide_drive_t *drive, int arg)
-{
-	if (drive->media == ide_disk) {
-		drive->scsi = 0;
-		return 0;
-	}
-
-	if (DRIVER(drive)->cleanup(drive)) {
-		drive->scsi = 0;
-		return 0;
-	}
-
-	drive->scsi = (u8) arg;
-	ata_attach(drive);
-	return 0;
-}
-
 void ide_add_generic_settings (ide_drive_t *drive)
 {
 /*
@@ -1353,8 +1336,6 @@ void ide_add_generic_settings (ide_drive
 	ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	
0,	70,				1,		1,		&drive->init_speed,		NULL);
 	ide_add_setting(drive,	"current_speed",	SETTING_RW,					-1,			-1,			
TYPE_BYTE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate);
 	ide_add_setting(drive,	"number",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	
3,				1,		1,		&drive->dn,			NULL);
-	if (drive->media != ide_disk)
-		ide_add_setting(drive,	"ide-scsi",		SETTING_RW,					-1,		HDIO_SET_IDE_SCSI,		
TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			ide_atapi_to_scsi);
 }
 
 int system_bus_clock (void)
diff -puN include/linux/hdreg.h~ide_scsi_proc include/linux/hdreg.h
--- linux-2.6.8.1/include/linux/hdreg.h~ide_scsi_proc	2004-08-16 
19:55:00.349690384 +0200
+++ linux-2.6.8.1-bzolnier/include/linux/hdreg.h	2004-08-16 19:55:00.354689624 
+0200
@@ -449,9 +449,8 @@ enum {
 /* hd/ide ctl's that pass (arg) ptrs to user space are numbered 0x033n/0x033n 
*/
 /* 0x330 is reserved - used to be HDIO_GETGEO_BIG */
 /* 0x331 is reserved - used to be HDIO_GETGEO_BIG_RAW */
-
-#define HDIO_SET_IDE_SCSI      0x0338
-#define HDIO_SET_SCSI_IDE      0x0339
+/* 0x338 is reserved - used to be HDIO_SET_IDE_SCSI */
+/* 0x339 is reserved - used to be HDIO_SET_SCSI_IDE */
 
 #define __NEW_HD_DRIVE_ID
 
diff -puN include/linux/ide.h~ide_scsi_proc include/linux/ide.h
--- linux-2.6.8.1/include/linux/ide.h~ide_scsi_proc	2004-08-16 
19:55:00.350690232 +0200
+++ linux-2.6.8.1-bzolnier/include/linux/ide.h	2004-08-16 19:55:00.354689624 
+0200
@@ -756,8 +756,8 @@ typedef struct ide_drive_s {
 					 *  2=48-bit doing 28-bit
 					 *  3=64-bit
 					 */
+	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
 
-	u8	scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation 
*/
         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	suspend_reset;	/* drive suspend mode flag, soft-reset recovers */
         u8	init_speed;	/* transfer rate set at boot */
_
