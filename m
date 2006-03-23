Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWCWNYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWCWNYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWCWNYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:24:04 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:3221 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932083AbWCWNYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:24:02 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
Date: Thu, 23 Mar 2006 23:22:16 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603232151.47346.ncunningham@cyclades.com> <20060323130919.GZ4285@suse.de>
In-Reply-To: <20060323130919.GZ4285@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1466819.bTI7Xrgqi0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603232322.23852.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1466819.bTI7Xrgqi0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

At the moment libata doesn't pass pm_message_t down ata_device_suspend.
This causes drives to be powered down when we just want a freeze,
causing unnecessary wear and tear. This patch gets pm_message_t passed
down so that it can be used to determine whether to power down the
drive.

Prepared against git at the time of writing. Please apply.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 drivers/scsi/libata-core.c |    5 +++--
 drivers/scsi/libata-scsi.c |    4 ++--
 drivers/scsi/scsi_sysfs.c  |    2 +-
 include/linux/libata.h     |    4 ++--
 include/scsi/scsi_host.h   |    2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)
diff -ruNp 9904-libata-freeze.patch-old/drivers/scsi/libata-core.c 9904-lib=
ata-freeze.patch-new/drivers/scsi/libata-core.c
=2D-- 9904-libata-freeze.patch-old/drivers/scsi/libata-core.c	2006-03-23 23=
:19:36.000000000 +1000
+++ 9904-libata-freeze.patch-new/drivers/scsi/libata-core.c	2006-03-23 21:5=
3:09.000000000 +1000
@@ -4506,14 +4506,15 @@ int ata_device_resume(struct ata_port *a
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
  */
=2Dint ata_device_suspend(struct ata_port *ap, struct ata_device *dev)
+int ata_device_suspend(struct ata_port *ap, struct ata_device *dev, pm_mes=
sage_t state)
 {
 	if (!ata_dev_present(dev))
 		return 0;
 	if (dev->class =3D=3D ATA_DEV_ATA)
 		ata_flush_cache(ap, dev);
=20
=2D	ata_standby_drive(ap, dev);
+	if (state.event !=3D PM_EVENT_FREEZE)
+		ata_standby_drive(ap, dev);
 	ap->flags |=3D ATA_FLAG_SUSPENDED;
 	return 0;
 }
diff -ruNp 9904-libata-freeze.patch-old/drivers/scsi/libata-scsi.c 9904-lib=
ata-freeze.patch-new/drivers/scsi/libata-scsi.c
=2D-- 9904-libata-freeze.patch-old/drivers/scsi/libata-scsi.c	2006-03-23 14=
:49:52.000000000 +1000
+++ 9904-libata-freeze.patch-new/drivers/scsi/libata-scsi.c	2006-03-23 23:1=
9:23.000000000 +1000
@@ -414,12 +414,12 @@ int ata_scsi_device_resume(struct scsi_d
 	return ata_device_resume(ap, dev);
 }
=20
=2Dint ata_scsi_device_suspend(struct scsi_device *sdev)
+int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
 {
 	struct ata_port *ap =3D (struct ata_port *) &sdev->host->hostdata[0];
 	struct ata_device *dev =3D &ap->device[sdev->id];
=20
=2D	return ata_device_suspend(ap, dev);
+	return ata_device_suspend(ap, dev, state);
 }
=20
 /**
diff -ruNp 9904-libata-freeze.patch-old/drivers/scsi/scsi_sysfs.c 9904-liba=
ta-freeze.patch-new/drivers/scsi/scsi_sysfs.c
=2D-- 9904-libata-freeze.patch-old/drivers/scsi/scsi_sysfs.c	2006-03-23 14:=
49:53.000000000 +1000
+++ 9904-libata-freeze.patch-new/drivers/scsi/scsi_sysfs.c	2006-03-23 21:53=
:09.000000000 +1000
@@ -286,7 +286,7 @@ static int scsi_bus_suspend(struct devic
 		return err;
=20
 	if (sht->suspend)
=2D		err =3D sht->suspend(sdev);
+		err =3D sht->suspend(sdev, state);
=20
 	return err;
 }
diff -ruNp 9904-libata-freeze.patch-old/include/linux/libata.h 9904-libata-=
freeze.patch-new/include/linux/libata.h
=2D-- 9904-libata-freeze.patch-old/include/linux/libata.h	2006-03-23 14:50:=
10.000000000 +1000
+++ 9904-libata-freeze.patch-new/include/linux/libata.h	2006-03-23 21:53:09=
=2E000000000 +1000
@@ -515,9 +515,9 @@ extern void ata_eh_qc_retry(struct ata_q
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_c=
md *qc);
 extern int ata_scsi_device_resume(struct scsi_device *);
=2Dextern int ata_scsi_device_suspend(struct scsi_device *);
+extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t stat=
e);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
=2Dextern int ata_device_suspend(struct ata_port *, struct ata_device *);
+extern int ata_device_suspend(struct ata_port *, struct ata_device *, pm_m=
essage_t state);
 extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
diff -ruNp 9904-libata-freeze.patch-old/include/scsi/scsi_host.h 9904-libat=
a-freeze.patch-new/include/scsi/scsi_host.h
=2D-- 9904-libata-freeze.patch-old/include/scsi/scsi_host.h	2006-03-23 14:5=
0:12.000000000 +1000
+++ 9904-libata-freeze.patch-new/include/scsi/scsi_host.h	2006-03-23 21:53:=
09.000000000 +1000
@@ -286,7 +286,7 @@ struct scsi_host_template {
 	 * suspend support
 	 */
 	int (*resume)(struct scsi_device *);
=2D	int (*suspend)(struct scsi_device *);
+	int (*suspend)(struct scsi_device *, pm_message_t state);
=20
 	/*
 	 * Name of proc directory

--nextPart1466819.bTI7Xrgqi0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIqEPN0y+n1M3mo0RArMkAJsHMSUN8MSYq33L4PVTiur4+RqUDgCfcx0l
EBmqnctne8UzBFzgDKdghHE=
=ywVn
-----END PGP SIGNATURE-----

--nextPart1466819.bTI7Xrgqi0--
