Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264947AbTL1DEx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTL1DEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:04:53 -0500
Received: from dsl-202-72-159-76.wa.westnet.com.au ([202.72.159.76]:58378 "EHLO
	dagobah.blackham.com.au") by vger.kernel.org with ESMTP
	id S264940AbTL1DEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:04:46 -0500
Date: Sun, 28 Dec 2003 11:04:39 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       swsusp-devel@lists.sourceforge.net
Subject: shutdown patch
Message-ID: <20031228030438.GA1273@amidala>
Mail-Followup-To: B.Zolnierkiewicz@elka.pw.edu.pl,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	swsusp-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
Organization: Dagobah Systems
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

In 2.4, there was an IDE reboot notifier that placed HDDs into
standby before shutdown (and parking heads). These no longer exist
in 2.6's IDE code since the power management rework. Debian (and
probably most distributions) run halt(8) as the last command in
runlevel 0 which puts the disk into standby mode, so generally it
isn't a problem.

However, if the system is powered off by other means (eg,
suspend-to-disk), the drive is never placed in standby mode, and
some drives will make a very audible "thunk" (my guess is as they
race to park their heads).

This patch places the disks in standby when device_shutdown() is
called. Please consider it, or something with the same functionality
(I'm not sure if it's correct to assume that calling
device->shutdown() can be treated the same as entering S5).

Regards,

Bernard.

--=20
 Bernard Blackham <bernard at blackham dot com dot au>

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-shutdown.diff"
Content-Transfer-Encoding: quoted-printable

diff -ruN linux-2.6.0/drivers/ide/ide.c.orig linux-2.6.0/drivers/ide/ide.c
--- linux-2.6.0/drivers/ide/ide.c.orig	2003-12-18 10:58:38.000000000 +0800
+++ linux-2.6.0/drivers/ide/ide.c	2003-12-28 10:18:47.000000000 +0800
@@ -2493,6 +2493,11 @@
 	return 0;
 }
=20
+static void ide_drive_shutdown (struct device * dev)
+{
+	generic_ide_suspend(dev, 5);
+}
+
 int ide_register_driver(ide_driver_t *driver)
 {
 	struct list_head list;
@@ -2519,6 +2524,7 @@
 	driver->gen_driver.name =3D (char *) driver->name;
 	driver->gen_driver.bus =3D &ide_bus_type;
 	driver->gen_driver.remove =3D ide_drive_remove;
+	driver->gen_driver.shutdown =3D ide_drive_shutdown;
 	return driver_register(&driver->gen_driver);
 }
=20

--OgqxwSJOaUobr8KG--

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/7khGccTsdj5FJ6QRAhEPAKCTO+fLALgs2Wa8iK0GiMKclUJlKQCghGTS
Giv+gl4XjdXwCLJlJSNTyvU=
=dVTO
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
