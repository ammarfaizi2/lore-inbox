Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271141AbTHCLfR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271158AbTHCLfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:35:17 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:18448 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S271141AbTHCLfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:35:08 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: David Walser <luigiwalser@yahoo.com>
Subject: [PATCH][2.6.0-test2] fix ata_probe driver autoloading (another module failing to autoload - ide-cd)
Date: Sun, 3 Aug 2003 15:33:37 +0400
User-Agent: KMail/1.5
References: <20030802185054.35243.qmail@web14006.mail.yahoo.com>
In-Reply-To: <20030802185054.35243.qmail@web14006.mail.yahoo.com>
Cc: linux-kernel@vger.kernel.org,
       Olivier Thauvin <olivier.thauvin@aerov.jussieu.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RMPL/o00HjtSGA/"
Message-Id: <200308031533.37745.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_RMPL/o00HjtSGA/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > On Saturday 02 August 2003 21:54, David Walser
> >
> > wrote:
> > > I think in 2.4 I had ide-cd as a module, but I
> >
> > didn't
> >
> > > have to do anything special to get it loaded to
> >
> > use
> >
> > > IDE CD-ROM devices.
> > >
> > > I just noticed in 2.6 I have to load it manually.
> > > What's the best way to handle this?
> >

Apply this patch :). Apparently drive->driver is never NULL now but defaults 
to default driver.

thank you

-andrey
--Boundary-00=_RMPL/o00HjtSGA/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.0-test2-ata_probe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test2-ata_probe.patch"

--- ../tmp/linux-2.6.0-test2/drivers/ide/ide-probe.c	2003-07-27 22:33:36.000000000 +0400
+++ linux-2.6.0-test2-smp/drivers/ide/ide-probe.c	2003-08-03 15:17:10.000000000 +0400
@@ -1134,6 +1134,8 @@ static int ata_lock(dev_t dev, void *dat
 	return 0;
 }
 
+extern ide_driver_t idedefault_driver;
+
 struct kobject *ata_probe(dev_t dev, int *part, void *data)
 {
 	ide_hwif_t *hwif = data;
@@ -1141,7 +1143,7 @@ struct kobject *ata_probe(dev_t dev, int
 	ide_drive_t *drive = &hwif->drives[unit];
 	if (!drive->present)
 		return NULL;
-	if (!drive->driver) {
+	if (drive->driver == &idedefault_driver) {
 		if (drive->media == ide_disk)
 			(void) request_module("ide-disk");
 		if (drive->scsi)
@@ -1153,7 +1155,7 @@ struct kobject *ata_probe(dev_t dev, int
 		if (drive->media == ide_floppy)
 			(void) request_module("ide-floppy");
 	}
-	if (!drive->driver)
+	if (drive->driver == &idedefault_driver)
 		return NULL;
 	*part &= (1 << PARTN_BITS) - 1;
 	return get_disk(drive->disk);

--Boundary-00=_RMPL/o00HjtSGA/--

