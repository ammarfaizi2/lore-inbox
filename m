Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVEaWxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVEaWxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVEaWxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:53:09 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:11716 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261190AbVEaWw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:52:58 -0400
Date: Wed, 1 Jun 2005 00:31:58 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [RFT][PATCH] IDE devfs fixes
Message-ID: <Pine.GSO.4.62.0506010023470.21923@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anybody using devfs + modular IDE support?  If so please test, thanks.

[PATCH] IDE devfs fixes

* don't remove drive->devfs_name in drive_release_dev(), this should
   fix OOPS for ide-floppy driver (drive->devfs_name is already removed
   by del_gendisk()) and ide-{cd,floppy,tape} drivers (drive->devfs_name
   is not registered et all)
* remove workaround for the above bug from ide-disk driver (which probably
   caused devfs support to brake if ide-disk module was reloaded)
* remove dead code from ide_unregister() (drive->devfs_name is only set
   if drive->present == 1)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

Index: ide-2.6.git/drivers/ide/ide-disk.c
===================================================================
--- ide-2.6.git.orig/drivers/ide/ide-disk.c
+++ ide-2.6.git/drivers/ide/ide-disk.c
@@ -1048,7 +1048,6 @@ static void ide_disk_release(struct kref
  	struct gendisk *g = idkp->disk;

  	drive->driver_data = NULL;
-	drive->devfs_name[0] = '\0';
  	g->private_data = NULL;
  	put_disk(g);
  	kfree(idkp);
Index: ide-2.6.git/drivers/ide/ide-probe.c
===================================================================
--- ide-2.6.git.orig/drivers/ide/ide-probe.c
+++ ide-2.6.git/drivers/ide/ide-probe.c
@@ -1308,10 +1308,6 @@ static void drive_release_dev (struct de
  	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);

  	spin_lock_irq(&ide_lock);
-	if (drive->devfs_name[0] != '\0') {
-		devfs_remove(drive->devfs_name);
-		drive->devfs_name[0] = '\0';
-	}
  	ide_remove_drive_from_hwgroup(drive);
  	if (drive->id != NULL) {
  		kfree(drive->id);
Index: ide-2.6.git/drivers/ide/ide.c
===================================================================
--- ide-2.6.git.orig/drivers/ide/ide.c
+++ ide-2.6.git/drivers/ide/ide.c
@@ -593,13 +593,8 @@ void ide_unregister(unsigned int index)
  		goto abort;
  	for (unit = 0; unit < MAX_DRIVES; ++unit) {
  		drive = &hwif->drives[unit];
-		if (!drive->present) {
-			if (drive->devfs_name[0] != '\0') {
-				devfs_remove(drive->devfs_name);
-				drive->devfs_name[0] = '\0';
-			}
+		if (!drive->present)
  			continue;
-		}
  		spin_unlock_irq(&ide_lock);
  		device_unregister(&drive->gendev);
  		down(&drive->gendev_rel_sem);
