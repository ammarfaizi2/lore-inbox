Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310864AbSCVLWp>; Fri, 22 Mar 2002 06:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311211AbSCVLWg>; Fri, 22 Mar 2002 06:22:36 -0500
Received: from [195.39.17.254] ([195.39.17.254]:51075 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S310864AbSCVLWS>;
	Fri, 22 Mar 2002 06:22:18 -0500
Date: Fri, 22 Mar 2002 12:21:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: IDE suspend small fixes
Message-ID: <20020322112120.GA6343@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Its bad idea to try to restore state twice for one suspend, this fixes
it. Please apply,
								Pavel

--- clean/drivers/ide/ide-disk.c	Thu Mar 21 11:35:59 2002
+++ linux-acpi/drivers/ide/ide-disk.c	Fri Mar 22 12:08:58 2002
@@ -123,7 +123,7 @@
 
 	while (drive->blocked) {
 		yield();
-		// panic("ide: Request while drive blocked?");
+		printk("ide: Request while drive blocked?");
 	}
 
 	if (!(rq->flags & REQ_CMD)) {
@@ -915,6 +915,9 @@
 	 * already been done...
 	 */
 
+	if (level != SUSPEND_SAVE_STATE)
+		return 0;
+
 	/* wait until all commands are finished */
 	printk("ide_disk_suspend()\n");
 	while (HWGROUP(drive)->handler)
@@ -934,6 +937,9 @@
 static int idedisk_resume(struct device *dev, u32 level)
 {
 	ide_drive_t *drive = dev->driver_data;
+
+	if (level != RESUME_RESTORE_STATE)
+		return 0;
 	if (!drive->blocked)
 		panic("ide: Resume but not suspended?\n");
 

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
