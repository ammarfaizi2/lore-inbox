Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266730AbUHOOl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266730AbUHOOl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUHOOl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:41:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40663 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266717AbUHOOlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:41:47 -0400
Date: Sun, 15 Aug 2004 10:40:55 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix bad geometry hang, printing of optional fields
Message-ID: <20040815144055.GA6730@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you get invalid geometry (eg a failed drive) the box hangs on boot because
we try and unregister the registered driver and end up in a locking mess.

We change the behaviour to simply leave the device unattached which avoids
the mess.

Also if a drive reports no geometry then don't try and verify the LBA
data is correct against the geometry. Also don't print the non-existant
legacy geometry.


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-disk.c linux-2.6.8-rc3/drivers/ide/ide-disk.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-disk.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-disk.c	2004-08-14 20:37:18.000000000 +0100
@@ -100,7 +100,11 @@
 	    (id->heads == 15 || id->heads == 16) &&
 	    (id->lba_capacity >= 16383*63*id->heads))
 		return 1;
-
+		
+	/* No non LBA info .. so valid! */
+	if (id->heads == 0)
+		return 1;
+		
 	lba_sects   = id->lba_capacity;
 	chs_sects   = id->cyls * id->heads * id->sectors;
 
@@ -1012,7 +1016,9 @@
 		drive->capacity64 = id->lba_capacity;
 		if (hpa)
 			idedisk_check_hpa(drive);
-	} else {
+	}
+	else
+	{
 		/* drive speaks boring old 28-bit CHS */
 		drive->capacity64 = drive->cyl * drive->head * drive->sect;
 	}
@@ -1515,8 +1521,8 @@
 	if (id->buf_size)
 		printk (" w/%dKiB Cache", id->buf_size/2);
 
-	printk(", CHS=%d/%d/%d", 
-	       drive->bios_cyl, drive->bios_head, drive->bios_sect);
+	if(drive->bios_cyl)
+		printk(", CHS=%d/%d/%d", drive->bios_cyl, drive->bios_head, drive->bios_sect);
 	if (drive->using_dma)
 		(void) HWIF(drive)->ide_dma_verbose(drive);
 	printk("\n");
@@ -1723,11 +1729,10 @@
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
 			drive->name, drive->head);
-		ide_cacheflush_p(drive);
-		ide_unregister_subdriver(drive);
-		DRIVER(drive)->busy--;
-		goto failed;
+		drive->attach = 0;
 	}
+	else
+		drive->attach = 1;
 	DRIVER(drive)->busy--;
 	g->minors = 1 << PARTN_BITS;
 	strcpy(g->devfs_name, drive->devfs_name);
@@ -1735,7 +1740,6 @@
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	set_capacity(g, current_capacity(drive));
 	g->fops = &idedisk_ops;
-	drive->attach = 1;
 	add_disk(g);
 	return 0;
 failed:
