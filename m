Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262101AbSJJIUr>; Thu, 10 Oct 2002 04:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbSJJIUr>; Thu, 10 Oct 2002 04:20:47 -0400
Received: from [195.39.17.254] ([195.39.17.254]:23812 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262101AbSJJIUq>;
	Thu, 10 Oct 2002 04:20:46 -0400
Date: Thu, 10 Oct 2002 10:22:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Kill dead code in ide
Message-ID: <20021010082259.GA682@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Old swsusp code somehow creeped into 2.5.X IDE. It is not used by
anything. Here's patch to kill it (we have better replacement in there
;-).

Please apply,
								Pavel

--- clean/drivers/ide/ide-disk.c	2002-10-08 21:25:24.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-10-08 12:12:39.000000000 +0200
@@ -1795,78 +1795,6 @@
 	return 0;
 }
 
-ide_startstop_t panic_box(ide_drive_t *drive)
-{
-#if 0
-	panic("%s: Attempted to corrupt something: ide operation "
-#else
-	printk(KERN_ERR "%s: Attempted to corrupt something: ide operation "
-#endif
-		"was pending accross suspend/resume.\n", drive->name);
-	return ide_stopped;
-}
-
-int ide_disks_busy(void)
-{
-	int i;
-	for (i=0; i<MAX_HWIFS; i++) {
-		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
-		if (!hwgroup) continue;
-		if ((hwgroup->handler) && (hwgroup->handler != panic_box))
-			return 1;
-	}
-	return 0;
-}
-
-void ide_disk_suspend(void)
-{
-	int i;
-	while (ide_disks_busy()) {
-		printk("*");
-		schedule();
-	}
-	for (i=0; i<MAX_HWIFS; i++) {
-		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
-
-		if (!hwgroup) continue;
-		hwgroup->handler_save = hwgroup->handler;
-		hwgroup->handler = panic_box;
-	}
-	driver_blocked = 1;
-	if (ide_disks_busy())
-		panic("How did you get that request through?!");
-}
-
-/* unsuspend and resume should be equal in the ideal world */
-
-void ide_disk_unsuspend(void)
-{
-	int i;
-	for (i=0; i<MAX_HWIFS; i++) {
-		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
-
-		if (!hwgroup) continue;
-		hwgroup->handler = NULL; /* hwgroup->handler_save; */
-		hwgroup->handler_save = NULL;
-	}
-	driver_blocked = 0;
-}
-
-void ide_disk_resume(void)
-{
-	int i;
-	for (i=0; i<MAX_HWIFS; i++) {
-		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
-
-		if (!hwgroup) continue;
-		if (hwgroup->handler != panic_box)
-			panic("Handler was not set to panic?");
-		hwgroup->handler_save = NULL;
-		hwgroup->handler = NULL;
-	}
-	driver_blocked = 0;
-}
-
 module_init(idedisk_init);
 module_exit(idedisk_exit);
 MODULE_LICENSE("GPL");

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
