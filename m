Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312449AbSCUSzU>; Thu, 21 Mar 2002 13:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312448AbSCUSzK>; Thu, 21 Mar 2002 13:55:10 -0500
Received: from david.siemens.de ([192.35.17.14]:3561 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S312449AbSCUSzC>;
	Thu, 21 Mar 2002 13:55:02 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: devfs mailing list <devfs@oss.sgi.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: PATCH: support for IDE devices in ide-scsi with devfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-4mdk 
Date: 21 Mar 2002 21:54:51 +0300
Message-Id: <1016736897.3113.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently using ide-scsi with devfs does not allow you to use hdparm
interface because no IDE nodes (block devices) are created. The patch
adds this.

Related patch for devfsd that creates old compatibility links is going
to devfs list. I do not think spcial new compatibility links are needed.

-andrej

--- linux-2.4.18-4mdk/drivers/scsi/ide-scsi.c.orig	Tue Mar  5 06:08:04 2002
+++ linux-2.4.18-4mdk/drivers/scsi/ide-scsi.c	Thu Mar 21 21:21:31 2002
@@ -95,6 +95,7 @@
 	unsigned long flags;			/* Status/Action flags */
 	unsigned long transform;		/* SCSI cmd translation layer */
 	unsigned long log;			/* log flags */
+	devfs_handle_t de;			/* pointer to IDE device */
 } idescsi_scsi_t;
 
 /*
@@ -502,6 +503,8 @@
  */
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi, int id)
 {
+	int minor = (drive->select.b.unit) << PARTN_BITS;
+
 	DRIVER(drive)->busy++;
 	idescsi_drives[id] = drive;
 	drive->driver_data = scsi;
@@ -516,6 +519,10 @@
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
 #endif /* IDESCSI_DEBUG_LOG */
 	idescsi_add_settings(drive);
+	scsi->de = devfs_register(drive->de, "generic", DEVFS_FL_DEFAULT,
+				     HWIF(drive)->major, minor,
+				     S_IFBLK | S_IRUSR | S_IWUSR,
+				     ide_fops, NULL);
 }
 
 static int idescsi_cleanup (ide_drive_t *drive)
@@ -524,6 +531,8 @@
 
 	if (ide_unregister_subdriver (drive))
 		return 1;
+	if (scsi->de)
+		devfs_unregister(scsi->de);
 	drive->driver_data = NULL;
 	kfree (scsi);
 	return 0;



