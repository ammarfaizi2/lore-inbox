Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVIUQPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVIUQPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIUQPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:15:37 -0400
Received: from tim.rpsys.net ([194.106.48.114]:52128 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751111AbVIUQPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:15:36 -0400
Subject: [RFC/BUG?] ide_cs's removable status
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
Content-Type: text/plain
Date: Wed, 21 Sep 2005 17:15:28 +0100
Message-Id: <1127319328.8542.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a handheld system that takes compact flash memory cards and uses
ide_cs to interface to them. I've been trying to kill off a load of
hotplug scripts and switch to using udev. As HAL is too bloated for the
handheld, I hacked some evil auto-mount udev scripts together. When I
insert a memory card, I see the disk get repeatedly mounted and
unmounted in a loop.

I realise auto-mounting via udev is evil but I think this highlights a
kernel driver issue.

I'm seeing the following sequence of events:

1. I insert the card
2. The partitions are scanned and block devices are created
3. udev creates the device nodes
4. udev triggers my mount script which mounts the device
5. mounting the device triggers check_disk_change() in block_dev.c
6. The bd_invalidated flag is set
7. rescan_partitions is hence called
8. the block devices are destroyed
9. goto 2

As ide_cs only creates the block devices when a card is present, I think
it shouldn't be set as removable. As a point of reference, the MMC
system does not set the removable flag for exactly this reason (There is
an email from Russell King explaining this -
http://lkml.org/lkml/2005/1/8/165).

It is worth noting the MMC subsystem works with my evil udev script. If
I apply the patch below (which removes the removable flag for flash
devices), I don't see this loop.

With the patch below, the is_flash variable can actually be removed as
its only useful purpose is in ide-disk.c in a "if (drive->removable
&& !(drive->is_flash)) {" statement...

I'm wondering if one of the more experienced IDE developers could give
some insight into which drivers use bits of code at the end of
do_identify() in ide-probe.c. Some questions:

1. Can anyone provide details on what the bits in id->config really
mean?  
2. Which other drivers exploit the "if (id->config & (1<<7))
drive->removable = 1;" code? Is it just ide_cs?
3. Do any other drivers expose flash interfaces in the same way ide_cs
does but with "proper" removable media handling where the block device
is persistent?

If ide_cs is the only user of this code, there is scope for a reasonable
amount of cleanup here. Other than the ATAPI drivers, I can't see any
with special removable handling which leads me to believe none of this
code is required.

Comments welcome as I can't help feeling there's something I've missed.
I'll write a neater patch if there is some agreement on what needs to be
done.

Richard


Index: linux-2.6.13/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/ide-probe.c	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13/drivers/ide/ide-probe.c	2005-09-21 16:57:15.000000000 +0100
@@ -147,19 +147,19 @@
 {
 	struct hd_driveid *id = drive->id;
 
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
+	if (id->config == 0x848a) return 1;	/* CompactFlash */
+
+	if (!strncmp(id->model, "KODAK ATA_FLASH", 15)	/* Kodak */
+	 || !strncmp(id->model, "Hitachi CV", 10)	/* Hitachi */
+	 || !strncmp(id->model, "SunDisk SDCFB", 13)	/* old SanDisk */
+	 || !strncmp(id->model, "SanDisk SDCFB", 13)	/* SanDisk */
+	 || !strncmp(id->model, "HAGIWARA HPC", 12)	/* Hagiwara */
+	 || !strncmp(id->model, "LEXAR ATA_FLASH", 15)	/* Lexar */
+	 || !strncmp(id->model, "ATA_FLASH", 9))	/* Simple Tech */
+	{
+		return 1;	/* yes, it is a flash memory card */
 	}
+
 	return 0;	/* no, it is not a flash memory card */
 }
 
@@ -278,11 +278,15 @@
 	/*
 	 * Not an ATAPI device: looks like a "regular" hard disk
 	 */
+
 	if (id->config & (1<<7))
 		drive->removable = 1;
 
-	if (drive_is_flashcard(drive))
+	if (drive_is_flashcard(drive)) {
 		drive->is_flash = 1;
+		drive->removable = 0;
+	}
+	
 	drive->media = ide_disk;
 	printk("%s DISK drive\n", (drive->is_flash) ? "CFA" : "ATA" );
 	QUIRK_LIST(drive);

	

