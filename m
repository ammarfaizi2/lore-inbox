Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTFBWcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 18:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTFBWcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 18:32:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:62418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264190AbTFBWcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 18:32:45 -0400
Subject: [PATCH][2.5.70] experiment: export more info about IDE devices via
	sysfs
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-cOziG5hVAA5gr/xoYzQy"
Organization: 
Message-Id: <1054593936.1622.11.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jun 2003 15:45:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cOziG5hVAA5gr/xoYzQy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Go from this:

% grep -H "" /sysfs/bus/ide/devices/*/name
/sysfs/bus/ide/devices/0.0/name:IDE Drive
/sysfs/bus/ide/devices/0.1/name:IDE Drive
/sysfs/bus/ide/devices/1.0/name:IDE Drive
%

To this:
% grep -H "" /sysfs/bus/ide/devices/*/name
/sysfs/bus/ide/devices/0.0/name:disk IC35L040AVER07-0
/sysfs/bus/ide/devices/0.1/name:disk IC35L020AVER07-0
/sysfs/bus/ide/devices/1.0/name:removable cdrom LTN486S
% 



--=-cOziG5hVAA5gr/xoYzQy
Content-Description: 
Content-Disposition: inline; filename=ide-names-sysfs-2.5.70.patch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1427  -> 1.1428 
#	drivers/ide/ide-probe.c	1.49    -> 1.50   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/02	andyp@andyp.pdx.osdl.net	1.1428
# Cosmetic face-lift for the contents of the name file for IDE devices in sysfs.
# Rather than a boring and inspecific "IDE Drive", you can now see things like
# "removable cdrom LTN486S" or "disk IC35L020AVER07-0".
# --------------------------------------------
#
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Mon Jun  2 15:32:04 2003
+++ b/drivers/ide/ide-probe.c	Mon Jun  2 15:32:04 2003
@@ -1292,11 +1292,38 @@
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t * drive = &hwif->drives[unit];
+		struct hd_driveid * id = drive->id;
+		char * media_str;
+		char unknown_str[8];
+
 		ide_add_generic_settings(drive);
 		snprintf(drive->gendev.bus_id,BUS_ID_SIZE,"%u.%u",
 			 hwif->index,unit);
-		snprintf(drive->gendev.name,DEVICE_NAME_SIZE,
-			 "%s","IDE Drive");
+		switch (drive->media) {
+			case ide_scsi:
+				media_str = "scsi";
+				break;
+			case ide_disk:
+				media_str = "disk";
+				break;
+			case ide_optical:
+				media_str = "optical";
+				break;
+			case ide_cdrom:
+				media_str = "cdrom";
+				break;
+			case ide_tape:
+				media_str = "tape";
+				break;
+			default:
+				snprintf(unknown_str,8,"type%d",drive->media);
+				media_str = unknown_str;
+				break;
+		}
+		snprintf(drive->gendev.name,DEVICE_NAME_SIZE, "%s%s%s %s",
+			(drive->is_flash) ? "flash " : "",
+			(drive->removable) ? "removable " : "",
+			media_str, id->model);
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
 		drive->gendev.driver_data = drive;

--=-cOziG5hVAA5gr/xoYzQy--

