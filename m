Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262440AbSJ2WrP>; Tue, 29 Oct 2002 17:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSJ2WrP>; Tue, 29 Oct 2002 17:47:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18436 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262440AbSJ2Wql>;
	Tue, 29 Oct 2002 17:46:41 -0500
Date: Wed, 30 Oct 2002 00:14:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: prevent swsusp from eating disks
Message-ID: <20021029231402.GA134@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Patrick broke IDE so it wanted to eat data, again. Fixed, please
apply,
								Pavel


--- clean/drivers/ide/ide-disk.c	2002-10-18 23:41:15.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-10-21 14:36:36.000000000 +0200
@@ -1891,8 +1891,10 @@
 
 static int idedisk_init (void)
 {
-	ide_register_driver(&idedisk_driver);
-	return 0;
+	int status = ide_register_driver(&idedisk_driver);
+	idedisk_driver.gen_driver.suspend = idedisk_suspend;
+	idedisk_driver.gen_driver.resume = idedisk_resume;
+	return status;
 }
 
 module_init(idedisk_init);
--- clean/drivers/ide/ide-probe.c	2002-10-20 16:22:39.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-probe.c	2002-10-21 14:45:41.000000000 +0200
@@ -1059,6 +1059,7 @@
 			 "%s","IDE Drive");
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
+		drive->gendev.driver_data = drive;
 		if (drive->present)
 			device_register(&drive->gendev);
 	}
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
