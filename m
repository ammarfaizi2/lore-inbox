Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTADC0r>; Fri, 3 Jan 2003 21:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTADC0r>; Fri, 3 Jan 2003 21:26:47 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:59031 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265815AbTADC0o>;
	Fri, 3 Jan 2003 21:26:44 -0500
Date: Sat, 4 Jan 2003 03:35:10 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301040235.DAA11671@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.54 fix ide-cd/ide-scsi oopses after module unload
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, mochel@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5 (the bug's been there since 2.5.42), rmmod:ing a
modular IDE subdriver like ide-cd or ide-scsi and then
rebooting causes an oops in device_shutdown(). This is because
the IDE layer doesn't reset the drive->gendev.driver pointer
that it previously set up to point to data structures in the
subdriver module. device_shutdown() sees a non-NULL ->driver,
dereferences it, and oopses.

The patch below for 2.5.54 fixes two generic bugs related to
unloading of modular IDE subdrivers, and one specific to ide-scsi:

1. ata_attach() needs to set drive->gendev.driver = NULL
   when no specific driver claims the drive. This prevents a
   drive previously owned by a subdriver module from keeping
   its ->gendev.driver pointing into that module.

2. ide_unregister_driver() needs to unregister &driver->gen_driver;
   this is to balance the corresponding register call in
   ide_register_driver(). [This part of the patch is originally
   by Patrick Mochel.]

3. ide-scsi.c abuses ide_driver_t's busy field as a counter
   while the field in fact is a single-bit boolean. This causes
   the busyness of the driver to be incorrect while the driver
   is active. (From my recent patch for 2.4.20-ac2/2.4.21-pre2.)

With these three fixes modular ide-cd and ide-scsi work quite
reliably for me in 2.5.54.

/Mikael

diff -ruN linux-2.5.54/drivers/ide/ide.c linux-2.5.54.ide-fixes/drivers/ide/ide.c
--- linux-2.5.54/drivers/ide/ide.c	2003-01-02 14:27:55.000000000 +0100
+++ linux-2.5.54.ide-fixes/drivers/ide/ide.c	2003-01-04 02:34:02.000000000 +0100
@@ -1346,6 +1346,7 @@
 	spin_unlock(&drivers_lock);
 	spin_lock(&drives_lock);
 	list_add_tail(&drive->list, &ata_unused);
+	drive->gendev.driver = NULL;
 	spin_unlock(&drives_lock);
 	return 1;
 }
@@ -2308,6 +2309,8 @@
 	list_del(&driver->drivers);
 	spin_unlock(&drivers_lock);
 
+	driver_unregister(&driver->gen_driver);
+
 	while(!list_empty(&driver->drives)) {
 		drive = list_entry(driver->drives.next, ide_drive_t, list);
 		if (driver->cleanup(drive)) {
diff -ruN linux-2.5.54/drivers/scsi/ide-scsi.c linux-2.5.54.ide-fixes/drivers/scsi/ide-scsi.c
--- linux-2.5.54/drivers/scsi/ide-scsi.c	2002-12-24 13:53:50.000000000 +0100
+++ linux-2.5.54.ide-fixes/drivers/scsi/ide-scsi.c	2003-01-04 02:34:02.000000000 +0100
@@ -590,6 +590,7 @@
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
 #endif /* IDESCSI_DEBUG_LOG */
 	idescsi_add_settings(drive);
+	DRIVER(drive)->busy--;
 }
 
 static int idescsi_cleanup (ide_drive_t *drive)
@@ -995,7 +996,7 @@
 	for (id = 0; id < MAX_HWIFS * MAX_DRIVES; id++) {
 		drive = idescsi_drives[id];
 		if (drive)
-			DRIVER(drive)->busy--;
+			DRIVER(drive)->busy = 0;
 	}
 	scsi_unregister   (idescsi_host);
 	device_unregister(&idescsi_primary);
