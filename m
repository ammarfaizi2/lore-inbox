Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVIFTNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVIFTNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVIFTNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:13:22 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:41168 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1750808AbVIFTNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:13:22 -0400
Message-ID: <431DEA51.1080100@maintech.de>
Date: Tue, 06 Sep 2005 21:13:21 +0200
From: Thomas Kleffel <tk@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix kernel oops with CF-Cards
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when a mounted CF-Card is removed from the system, inserted back into 
the slot, removed again, and then umount is called for that device the 
kernel oopes.

(This is a slightly different issue than noted in my last mail.)

This happens because the reference counting gets confused. When a disk 
gets released by ide_disk_release() it sets the driver_data member of 
the corresponding drive to NULL. This is bad, as the pyhsical drive 
could be assigned to another idkp structure in the meantime (happens, 
when the drive is removed and inserted again).

My fix is to simply leave the drive alone when a disk is released. This 
shouldn't cause any side-effects - drive->driver_data isn't tested for 
containing NULL anywhere.

The following patch (against vanilla 2.6.13) fixes that problem:

diff -uprN -X b/Documentation/dontdiff a/drivers/ide/ide-disk.c 
b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-08-24 17:58:02.000000000 +0200
+++ b/drivers/ide/ide-disk.c	2005-09-05 02:10:30.000000000 +0200
@@ -1048,11 +1048,8 @@ static int ide_disk_remove(struct device
  static void ide_disk_release(struct kref *kref)
  {
  	struct ide_disk_obj *idkp = to_ide_disk(kref);
-	ide_drive_t *drive = idkp->drive;
  	struct gendisk *g = idkp->disk;

-	drive->driver_data = NULL;
-	drive->devfs_name[0] = '\0';
  	g->private_data = NULL;
  	put_disk(g);
  	kfree(idkp);

Signed-off-by: Thomas Kleffel <tk@maintech.de>

Best regards,
Thomas

