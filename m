Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbVKIKRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVKIKRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 05:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVKIKRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 05:17:41 -0500
Received: from tim.rpsys.net ([194.106.48.114]:27091 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030425AbVKIKRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 05:17:40 -0500
Subject: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
From: Richard Purdie <rpurdie@rpsys.net>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20051104163755.GB13420@kroah.com>
References: <20051103220305.77620d8f.akpm@osdl.org>
	 <20051104071932.GA6362@kroah.com>
	 <1131117293.26925.46.camel@localhost.localdomain>
	 <20051104163755.GB13420@kroah.com>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 10:17:08 +0000
Message-Id: <1131531428.8506.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 08:37 -0800, Greg KH wrote:
> On Fri, Nov 04, 2005 at 03:14:53PM +0000, Alan Cox wrote:
> > On Iau, 2005-11-03 at 23:19 -0800, Greg KH wrote:
> > > Hint, gentoo, debian, and suse don't have this problem, so you might
> > > want to look at their rules files for how to work around this.  Look for
> > > this line:
> > > 
> > > # skip accessing removable ide devices, cause the ide drivers are horrible broken
> > 
> > 
> > I was under the impression people had eventually decided the media
> > change patch someone was proposed was ok after investigating one or two
> > cases I knew of that turned out to be borked hardware ?
> 
> I was not aware of that, I'd be glad to see that patch go into the tree
> to help others who have run into this over the years.
> 
> Hm, have a pointer to the latest proposed patch for this anywhere?

This was discussed in the thread: http://lkml.org/lkml/2005/9/21/118

Alan Cox:
> On Iau, 2005-09-22 at 15:21 +0100, Richard Purdie wrote:
> > 1. Are ide-cs devices removable or not. See above.
>
> Having done testing on the cards I have based on RMK's suggestion I
> agree they are not removable except for specific cases (IDE PCMCIA cable
> adapter plugged into a Syquest). That case is already handled in the
> core code.

Alan: Can you confirm the patch below continues to handle the case
you're talking about?

> The fact cache flushing is all odd now is I guess bug 4. on the list but
> easy to fix while fixing 1

I don't know the ide code well enough to understand what needs fixing
here. Can you elaborate further?

I'll resend this patch as it still applies and we seem to be in general
agreement about what needs doing. There was also the issue of media
change serial number checking but that really needs tackling separately.


This patch stops CompactFlash devices being marked as removable. They
are not removable (as defined by Linux) as the media and device are 
inseparable. When a card is removed, the whole device is removed from 
the system and never sits in a media-less state.

This stops some nasty udev device creation/destruction loops.

Further, once this change is made, there is no need for ide to
differentiate between flash and other devices so the is_flash variable
can be removed from ide_drive_t.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net> 


Index: linux-2.6.13/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-probe.c	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13/drivers/ide/ide-probe.c	2005-09-21 20:57:34.000000000 +0100
@@ -125,45 +125,6 @@
 }
 
 /**
- *	drive_is_flashcard	-	check for compact flash
- *	@drive: drive to check
- *
- *	CompactFlash cards and their brethern pretend to be removable
- *	hard disks, except:
- * 		(1) they never have a slave unit, and
- *		(2) they don't have doorlock mechanisms.
- *	This test catches them, and is invoked elsewhere when setting
- *	appropriate config bits.
- *
- *	FIXME: This treatment is probably applicable for *all* PCMCIA (PC CARD)
- *	devices, so in linux 2.3.x we should change this to just treat all
- *	PCMCIA  drives this way, and get rid of the model-name tests below
- *	(too big of an interface change for 2.4.x).
- *	At that time, we might also consider parameterizing the timeouts and
- *	retries, since these are MUCH faster than mechanical drives. -M.Lord
- */
- 
-static inline int drive_is_flashcard (ide_drive_t *drive)
-{
-	struct hd_driveid *id = drive->id;
-
-	if (drive->removable) {
-		if (id->config == 0x848a) return 1;	/* CompactFlash */
-		if (!strncmp(id->model, "KODAK ATA_FLASH", 15)	/* Kodak */
-		 || !strncmp(id->model, "Hitachi CV", 10)	/* Hitachi */
-		 || !strncmp(id->model, "SunDisk SDCFB", 13)	/* old SanDisk */
-		 || !strncmp(id->model, "SanDisk SDCFB", 13)	/* SanDisk */
-		 || !strncmp(id->model, "HAGIWARA HPC", 12)	/* Hagiwara */
-		 || !strncmp(id->model, "LEXAR ATA_FLASH", 15)	/* Lexar */
-		 || !strncmp(id->model, "ATA_FLASH", 9))	/* Simple Tech */
-		{
-			return 1;	/* yes, it is a flash memory card */
-		}
-	}
-	return 0;	/* no, it is not a flash memory card */
-}
-
-/**
  *	do_identify	-	identify a drive
  *	@drive: drive to identify 
  *	@cmd: command used
@@ -278,13 +239,17 @@
 	/*
 	 * Not an ATAPI device: looks like a "regular" hard disk
 	 */
-	if (id->config & (1<<7))
-		drive->removable = 1;
 
-	if (drive_is_flashcard(drive))
-		drive->is_flash = 1;
+	/* 
+	 * 0x848a = CompactFlash device 
+	 * These are *not* removable in Linux definition of the term
+	 */
+
+	if ((id->config != 0x848a) && (id->config & (1<<7)))
+		drive->removable = 1;
+	
 	drive->media = ide_disk;
-	printk("%s DISK drive\n", (drive->is_flash) ? "CFA" : "ATA" );
+	printk("%s DISK drive\n", (id->config == 0x848a) ? "CFA" : "ATA" );
 	QUIRK_LIST(drive);
 	return;
 
Index: linux-2.6.13/drivers/ide/ide.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide.c	2005-09-19 10:53:59.000000000 +0100
+++ linux-2.6.13/drivers/ide/ide.c	2005-09-21 20:52:53.000000000 +0100
@@ -242,7 +242,6 @@
 		drive->name[2]			= 'a' + (index * MAX_DRIVES) + unit;
 		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
 		drive->using_dma		= 0;
-		drive->is_flash			= 0;
 		drive->vdma			= 0;
 		INIT_LIST_HEAD(&drive->list);
 		sema_init(&drive->gendev_rel_sem, 0);
Index: linux-2.6.13/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-disk.c	2005-09-19 10:53:59.000000000 +0100
+++ linux-2.6.13/drivers/ide/ide-disk.c	2005-09-21 20:51:31.000000000 +0100
@@ -895,11 +895,7 @@
 	if (drive->id_read == 0)
 		return;
 
-	/*
-	 * CompactFlash cards and their brethern look just like hard drives
-	 * to us, but they are removable and don't have a doorlock mechanism.
-	 */
-	if (drive->removable && !(drive->is_flash)) {
+	if (drive->removable) {
 		/*
 		 * Removable disks (eg. SYQUEST); ignore 'WD' drives 
 		 */
Index: linux-2.6.13/include/linux/ide.h
===================================================================
--- linux-2.6.13.orig/include/linux/ide.h	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13/include/linux/ide.h	2005-09-21 20:56:29.000000000 +0100
@@ -697,7 +697,6 @@
 	unsigned noprobe 	: 1;	/* from:  hdx=noprobe */
 	unsigned removable	: 1;	/* 1 if need to do check_media_change */
 	unsigned attach		: 1;	/* needed for removable devices */
-	unsigned is_flash	: 1;	/* 1 if probed as flash */
 	unsigned forced_geom	: 1;	/* 1 if hdx=c,h,s was given at boot */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
 	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */


