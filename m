Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTDEHWa (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 02:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTDEHWa (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 02:22:30 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:23951 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261916AbTDEHW2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 02:22:28 -0500
Date: Sat, 05 Apr 2003 19:31:17 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: PATCH: Fixes for ide-disk.c
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049527877.1865.17.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In working on swsusp, I've found the following patches were needed.
The first fragment is trivial, as you'll see.
The second and third handle the fact that the suspend & resume functions
can be called multiple times. Pavel asked me to pass it on immediately.
The fourth handles the fact that writeback caches seem to be implemented
in two ways. People using swsusp under 2.4 found that everything worked
fine if they rebooted after writing the image, but powering down at the
end of writing the image caused corruption. I got the additional check
from the source for hdparm, which only does the new check to determine
if a drive has a writeback cache.

Regards,

Nigel

--- linux-2.5.66-original/drivers/ide/ide-disk.c	2003-03-26 08:56:49.000000000 +1200
+++ linux-2.5.66/drivers/ide/ide-disk.c	2003-04-05 18:51:17.000000000 +1200
@@ -1515,7 +1515,7 @@
 {
 	ide_drive_t *drive = dev->driver_data;
 
-	printk("Suspending device %p\n", dev->driver_data);
+	printk(KERN_INFO "Suspending device %p\n", dev->driver_data);
 
 	/* I hope that every freeze operation from the upper levels have
 	 * already been done...
@@ -1527,7 +1527,7 @@
 	/* set the drive to standby */
 	printk(KERN_INFO "suspending: %s ", drive->name);
 	do_idedisk_standby(drive);
-	drive->blocked = 1;
+	drive->blocked++;
 
 	BUG_ON (HWGROUP(drive)->handler);
 	return 0;
@@ -1539,8 +1539,8 @@
 
 	if (level != RESUME_RESTORE_STATE)
 		return 0;
-	BUG_ON(!drive->blocked);
-	drive->blocked = 0;
+	if (drive->blocked)
+		drive->blocked--;
 	return 0;
 }
 
@@ -1804,7 +1804,8 @@
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
 			drive->name, drive->head);
-		if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
+		if (((drive->id->cfs_enable_2 & 0x3000) && drive->wcache) ||
+		    ((drive->id->command_set_1 & 0x20) && drive->id->cfs_enable_1 & 0x20))
 			if (do_idedisk_flushcache(drive))
 				printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 					drive->name);



