Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbTCQWGx>; Mon, 17 Mar 2003 17:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbTCQWGx>; Mon, 17 Mar 2003 17:06:53 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:25063 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S261947AbTCQWGt>; Mon, 17 Mar 2003 17:06:49 -0500
Date: Tue, 18 Mar 2003 10:17:59 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Patch: Fix BUGging in ide-disk.c
To: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Message-id: <1047939287.5426.5.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch fixes a problem with the suspend/resume code in ide-disk.c
which is triggered when the code is called multiple times for a drive.
When the second resume call was made, the BUG was activated.

Please apply if something hasn't already been done about this.

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

diff -ruN linux-2.5.64-original/drivers/ide/ide-disk.c
linux-2.5.64-clean/drivers/ide/ide-disk.c
--- linux-2.5.64-original/drivers/ide/ide-disk.c	2002-12-11 11:45:51.000000000 +1300
+++ linux-2.5.64-clean/drivers/ide/ide-disk.c	2003-03-18 08:59:29.000000000 +1200
@@ -1552,7 +1552,8 @@
 	/* set the drive to standby */
 	printk(KERN_INFO "suspending: %s ", drive->name);
 	do_idedisk_standby(drive);
-	drive->blocked = 1;
+	/* Handle multiple calls for the same drive without bugging */
+	drive->blocked++;
 
 	BUG_ON (HWGROUP(drive)->handler);
 	return 0;
@@ -1562,10 +1563,14 @@
 {
 	ide_drive_t *drive = dev->driver_data;
 
+	printk("Resuming device %p\n", dev->driver_data);
+
 	if (level != RESUME_RESTORE_STATE)
 		return 0;
-	BUG_ON(!drive->blocked);
-	drive->blocked = 0;
+	if (drive->blocked)
+		drive->blocked--;
+	else
+		printk("Warning: More calls to resume device %p than calls to suspend it.\n", dev->driver_data);
 	return 0;
 }


