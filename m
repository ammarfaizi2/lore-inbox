Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTFCWXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTFCWXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:23:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26265 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261589AbTFCWXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:23:36 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] create /proc/ide/hdX/capacity only once
Date: Wed, 4 Jun 2003 00:36:41 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306040036.41227.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
please apply.
--
Bartlomiej

[ide] create /proc/ide/hdX/capacity only once

In ide_register_subdriver() create drive->proc entries
only if driver is not idedefault_driver.

[ There won't be /proc/ide/hdX/capacity for devices attached
  to idedefault_driver now, it reported 0x7fffffff previously. ]

Do not create drive->proc entries in create_proc_ide_drives(),
they are added later in ide_register_subdriver().

 drivers/ide/ide-proc.c |    8 +-------
 drivers/ide/ide.c      |    6 ++++--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff -puN drivers/ide/ide-proc.c~ide_proc_capacity_fix drivers/ide/ide-proc.c
--- linux-2.5.70-bk8/drivers/ide/ide-proc.c~ide_proc_capacity_fix	Tue Jun  3 23:07:51 2003
+++ linux-2.5.70-bk8-root/drivers/ide/ide-proc.c	Tue Jun  3 23:13:49 2003
@@ -712,7 +712,6 @@ void create_proc_ide_drives(ide_hwif_t *
 
 	for (d = 0; d < MAX_DRIVES; d++) {
 		ide_drive_t *drive = &hwif->drives[d];
-		ide_driver_t *driver = drive->driver;
 
 		if (!drive->present)
 			continue;
@@ -720,13 +719,8 @@ void create_proc_ide_drives(ide_hwif_t *
 			continue;
 
 		drive->proc = proc_mkdir(drive->name, parent);
-		if (drive->proc) {
+		if (drive->proc)
 			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
-			if (driver) {
-				ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
-				ide_add_proc_entries(drive->proc, driver->proc, drive);
-			}
-		}
 		sprintf(name,"ide%d/%s", (drive->name[2]-'a')/2, drive->name);
 		ent = proc_symlink(drive->name, proc_ide_root, name);
 		if (!ent) return;
diff -puN drivers/ide/ide.c~ide_proc_capacity_fix drivers/ide/ide.c
--- linux-2.5.70-bk8/drivers/ide/ide.c~ide_proc_capacity_fix	Tue Jun  3 23:07:53 2003
+++ linux-2.5.70-bk8-root/drivers/ide/ide.c	Tue Jun  3 23:12:32 2003
@@ -2349,8 +2349,10 @@ int ide_register_subdriver (ide_drive_t 
 	}
 	drive->suspend_reset = 0;
 #ifdef CONFIG_PROC_FS
-	ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
-	ide_add_proc_entries(drive->proc, driver->proc, drive);
+	if (drive->driver != &idedefault_driver) {
+		ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
+		ide_add_proc_entries(drive->proc, driver->proc, drive);
+	}
 #endif
 	return 0;
 }

_

