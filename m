Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWAUUj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWAUUj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 15:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWAUUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 15:39:56 -0500
Received: from aun.it.uu.se ([130.238.12.36]:3839 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932326AbWAUUjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 15:39:55 -0500
Date: Sat, 21 Jan 2006 21:39:48 +0100 (MET)
Message-Id: <200601212039.k0LKdmsE005272@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH 2.6.16-rc1] ide-scsi: fix for IDE probe/remove ops changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.16-rc1 broke the ide-scsi driver: ide-scsi loads but
fails to find any devices to bind to. It also triggers a message
"Driver 'ide-scsi' needs updating - please use bus_type methods"
from the driver core.

The IDE core in 2.6.16-rc1 changed the location of an IDE driver's
->probe()/->remove()/->shutdown() methods: they are now in the
ide_driver_t struct not in the gen_driver sub-struct. drivers/ide/
was updated for this change but ide-scsi.c wasn't. Hence the breakage.

This patch repairs ide-scsi and also eliminates the driver core warning.
Please apply before 2.6.16 final.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/scsi/ide-scsi.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff -rupN linux-2.6.16-rc1/drivers/scsi/ide-scsi.c linux-2.6.16-rc1.ide-scsi-probe-fix/drivers/scsi/ide-scsi.c
--- linux-2.6.16-rc1/drivers/scsi/ide-scsi.c	2006-01-21 20:27:04.000000000 +0100
+++ linux-2.6.16-rc1.ide-scsi-probe-fix/drivers/scsi/ide-scsi.c	2006-01-21 21:04:53.000000000 +0100
@@ -751,9 +751,8 @@ static void idescsi_setup (ide_drive_t *
 	idescsi_add_settings(drive);
 }
 
-static int ide_scsi_remove(struct device *dev)
+static void ide_scsi_remove(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	struct Scsi_Host *scsihost = drive->driver_data;
 	struct ide_scsi_obj *scsi = scsihost_to_idescsi(scsihost);
 	struct gendisk *g = scsi->disk;
@@ -768,11 +767,9 @@ static int ide_scsi_remove(struct device
 
 	scsi_remove_host(scsihost);
 	ide_scsi_put(scsi);
-
-	return 0;
 }
 
-static int ide_scsi_probe(struct device *);
+static int ide_scsi_probe(ide_drive_t *);
 
 #ifdef CONFIG_PROC_FS
 static ide_proc_entry_t idescsi_proc[] = {
@@ -788,9 +785,9 @@ static ide_driver_t idescsi_driver = {
 		.owner		= THIS_MODULE,
 		.name		= "ide-scsi",
 		.bus		= &ide_bus_type,
-		.probe		= ide_scsi_probe,
-		.remove		= ide_scsi_remove,
 	},
+	.probe			= ide_scsi_probe,
+	.remove			= ide_scsi_remove,
 	.version		= IDESCSI_VERSION,
 	.media			= ide_scsi,
 	.supports_dsc_overlap	= 0,
@@ -1119,9 +1116,8 @@ static struct scsi_host_template idescsi
 	.proc_name		= "ide-scsi",
 };
 
-static int ide_scsi_probe(struct device *dev)
+static int ide_scsi_probe(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	idescsi_scsi_t *idescsi;
 	struct Scsi_Host *host;
 	struct gendisk *g;
