Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVAUX3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVAUX3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVAUX1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:27:45 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62382 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262591AbVAUXXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:23:22 -0500
Date: Sat, 22 Jan 2005 00:19:41 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [patch 2/8] kill setup_driver_defaults()
Message-ID: <Pine.GSO.4.58.0501220019090.28844@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* move default_do_request() to ide-default.c
* fix drivers to set ide_driver_t->{do_request,end_request,error,abort}
* kill setup_driver_defaults()

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-21 22:27:18 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-21 22:27:18 +01:00
@@ -3279,6 +3279,9 @@
 	.supports_dsc_overlap	= 1,
 	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
+	.end_request		= ide_end_request,
+	.error			= __ide_error,
+	.abort			= __ide_abort,
 	.proc			= idecd_proc,
 	.attach			= ide_cdrom_attach,
 	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
diff -Nru a/drivers/ide/ide-default.c b/drivers/ide/ide-default.c
--- a/drivers/ide/ide-default.c	2005-01-21 22:27:18 +01:00
+++ b/drivers/ide/ide-default.c	2005-01-21 22:27:18 +01:00
@@ -38,6 +38,12 @@

 static int idedefault_attach(ide_drive_t *drive);

+static ide_startstop_t idedefault_do_request(ide_drive_t *drive, struct request *rq, sector_t block)
+{
+	ide_end_request(drive, 0, 0);
+	return ide_stopped;
+}
+
 /*
  *	IDE subdriver functions, registered with ide.c
  */
@@ -47,6 +53,10 @@
 	.version	=	IDEDEFAULT_VERSION,
 	.attach		=	idedefault_attach,
 	.cleanup	=	ide_unregister_subdriver,
+	.do_request	=	idedefault_do_request,
+	.end_request	=	ide_end_request,
+	.error		=	__ide_error,
+	.abort		=	__ide_abort,
 	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
 };

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-01-21 22:27:18 +01:00
+++ b/drivers/ide/ide-disk.c	2005-01-21 22:27:18 +01:00
@@ -996,6 +996,9 @@
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
 	.do_request		= ide_do_rw_disk,
+	.end_request		= ide_end_request,
+	.error			= __ide_error,
+	.abort			= __ide_abort,
 	.proc			= idedisk_proc,
 	.attach			= idedisk_attach,
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-01-21 22:27:18 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-01-21 22:27:18 +01:00
@@ -1884,6 +1884,8 @@
 	.cleanup		= idefloppy_cleanup,
 	.do_request		= idefloppy_do_request,
 	.end_request		= idefloppy_do_end_request,
+	.error			= __ide_error,
+	.abort			= __ide_abort,
 	.proc			= idefloppy_proc,
 	.attach			= idefloppy_attach,
 	.drives			= LIST_HEAD_INIT(idefloppy_driver.drives),
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-01-21 22:27:18 +01:00
+++ b/drivers/ide/ide-io.c	2005-01-21 22:27:18 +01:00
@@ -622,6 +622,8 @@
 	return ide_atapi_error(drive, rq, stat, err);
 }

+EXPORT_SYMBOL_GPL(__ide_error);
+
 /**
  *	ide_error	-	handle an error on the IDE
  *	@drive: drive the error occurred on
@@ -665,6 +667,8 @@
 	DRIVER(drive)->end_request(drive, 0, 0);
 	return ide_stopped;
 }
+
+EXPORT_SYMBOL_GPL(__ide_abort);

 /**
  *	ide_abort	-	abort pending IDE operatins
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-01-21 22:27:18 +01:00
+++ b/drivers/ide/ide-tape.c	2005-01-21 22:27:18 +01:00
@@ -4686,6 +4686,8 @@
 	.cleanup		= idetape_cleanup,
 	.do_request		= idetape_do_request,
 	.end_request		= idetape_end_request,
+	.error			= __ide_error,
+	.abort			= __ide_abort,
 	.proc			= idetape_proc,
 	.attach			= idetape_attach,
 	.drives			= LIST_HEAD_INIT(idetape_driver.drives),
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-21 22:27:18 +01:00
+++ b/drivers/ide/ide.c	2005-01-21 22:27:18 +01:00
@@ -197,7 +197,6 @@
 EXPORT_SYMBOL(ide_hwifs);

 extern ide_driver_t idedefault_driver;
-static void setup_driver_defaults(ide_driver_t *driver);

 /*
  * Do not even *think* about calling this!
@@ -301,8 +300,6 @@
 		return;		/* already initialized */
 	magic_cookie = 0;

-	setup_driver_defaults(&idedefault_driver);
-
 	/* Initialise all interface structures */
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		hwif = &ide_hwifs[index];
@@ -2015,38 +2012,6 @@
 #endif
 }

-static ide_startstop_t default_do_request (ide_drive_t *drive, struct request *rq, sector_t block)
-{
-	ide_end_request(drive, 0, 0);
-	return ide_stopped;
-}
-
-static int default_end_request (ide_drive_t *drive, int uptodate, int nr_sects)
-{
-	return ide_end_request(drive, uptodate, nr_sects);
-}
-
-static ide_startstop_t
-default_error(ide_drive_t *drive, struct request *rq, u8 stat, u8 err)
-{
-	return __ide_error(drive, rq, stat, err);
-}
-
-static ide_startstop_t default_abort(ide_drive_t *drive, struct request *rq)
-{
-	return __ide_abort(drive, rq);
-}
-
-static void setup_driver_defaults (ide_driver_t *d)
-{
-	BUG_ON(d->attach == NULL || d->cleanup == NULL);
-
-	if (d->do_request == NULL)	d->do_request = default_do_request;
-	if (d->end_request == NULL)	d->end_request = default_end_request;
-	if (d->error == NULL)		d->error = default_error;
-	if (d->abort == NULL)		d->abort = default_abort;
-}
-
 int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
 	unsigned long flags;
@@ -2144,8 +2109,6 @@
 	struct list_head list;
 	struct list_head *list_loop;
 	struct list_head *tmp_storage;
-
-	setup_driver_defaults(driver);

 	spin_lock(&drivers_lock);
 	list_add(&driver->drivers, &drivers);
