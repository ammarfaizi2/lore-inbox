Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316905AbSEVJZt>; Wed, 22 May 2002 05:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316907AbSEVJZs>; Wed, 22 May 2002 05:25:48 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:3085 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S316905AbSEVJZr>;
	Wed, 22 May 2002 05:25:47 -0400
Date: Wed, 22 May 2002 13:30:13 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] duplicate clock calculation code in 3 IDE drivers
Message-ID: <20020522093013.GD312@pazke.ipt>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.15 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: multipart/mixed; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

now it is more interesting patch. AMD, PIIX and VIA IDE drivers contain
some duplicated code for (amd|piix|via)_clock calculation. Attached
patch moves this code into one function in ata-timing.c file.

Please take a look at it.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ide-bus-clock
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/ata-timing.c lin=
ux/drivers/ide/ata-timing.c
--- linux.vanilla/drivers/ide/ata-timing.c	Tue May 21 01:56:18 2002
+++ linux/drivers/ide/ata-timing.c	Wed May 22 04:06:53 2002
@@ -256,3 +256,22 @@
=20
 	return 0;
 }
+
+unsigned int ata_system_bus_clock(void)
+{
+	unsigned int clock =3D system_bus_speed * 1000;
+
+	switch (clock) {
+		case 33000: clock =3D 33333; break;
+		case 37000: clock =3D 37500; break;
+		case 41000: clock =3D 41666; break;
+	}
+
+	if (clock < 20000 || clock > 50000) {
+		printk(KERN_WARNING "ATA: User given PCI clock speed impossible (%d), us=
ing 33 MHz instead.\n", clock);
+		printk(KERN_WARNING "ATA: Use ide0=3Data66 if you want to assume 80-wire=
 cable\n");
+		clock =3D 33333;
+	}
+
+	return clock;
+}
diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/ata-timing.h lin=
ux/drivers/ide/ata-timing.h
--- linux.vanilla/drivers/ide/ata-timing.h	Tue May  7 23:50:09 2002
+++ linux/drivers/ide/ata-timing.h	Wed May 22 04:02:13 2002
@@ -82,4 +82,6 @@
 extern struct ata_timing* ata_timing_data(short speed);
 extern int ata_timing_compute(struct ata_device *drive,
 		short speed, struct ata_timing *t, int T, int UT);
+
+extern unsigned int ata_system_bus_clock(void);
 #endif
diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/amd74xx.c linux/=
drivers/ide/amd74xx.c
--- linux.vanilla/drivers/ide/amd74xx.c	Tue May 21 01:55:57 2002
+++ linux/drivers/ide/amd74xx.c	Wed May 22 03:59:12 2002
@@ -360,20 +360,7 @@
 /*
  * Determine the system bus clock.
  */
-
-	amd_clock =3D system_bus_speed * 1000;
-
-	switch (amd_clock) {
-		case 33000: amd_clock =3D 33333; break;
-		case 37000: amd_clock =3D 37500; break;
-		case 41000: amd_clock =3D 41666; break;
-	}
-
-	if (amd_clock < 20000 || amd_clock > 50000) {
-		printk(KERN_WARNING "AMD_IDE: User given PCI clock speed impossible (%d)=
, using 33 MHz instead.\n", amd_clock);
-		printk(KERN_WARNING "AMD_IDE: Use ide0=3Data66 if you want to assume 80-=
wire cable\n");
-		amd_clock =3D 33333;
-	}
+	amd_clock =3D ata_system_bus_clock();
=20
 /*
  * Print the boot message.
diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/piix.c linux/dri=
vers/ide/piix.c
--- linux.vanilla/drivers/ide/piix.c	Tue May 21 01:55:58 2002
+++ linux/drivers/ide/piix.c	Wed May 22 04:03:37 2002
@@ -497,19 +497,7 @@
  * Determine the system bus clock.
  */
=20
-	piix_clock =3D system_bus_speed * 1000;
-
-	switch (piix_clock) {
-		case 33000: piix_clock =3D 33333; break;
-		case 37000: piix_clock =3D 37500; break;
-		case 41000: piix_clock =3D 41666; break;
-	}
-
-	if (piix_clock < 20000 || piix_clock > 50000) {
-		printk(KERN_WARNING "PIIX: User given PCI clock speed impossible (%d), u=
sing 33 MHz instead.\n", piix_clock);
-		printk(KERN_WARNING "PIIX: Use ide0=3Data66 if you want to assume 80-wir=
e cable\n");
-		piix_clock =3D 33333;
-	}
+	piix_clock =3D ata_system_bus_clock();
=20
 /*
  * Print the boot message.
diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/via82cxxx.c linu=
x/drivers/ide/via82cxxx.c
--- linux.vanilla/drivers/ide/via82cxxx.c	Tue May 21 01:55:59 2002
+++ linux/drivers/ide/via82cxxx.c	Wed May 22 04:03:17 2002
@@ -474,19 +474,7 @@
  * Determine system bus clock.
  */
=20
-	via_clock =3D system_bus_speed * 1000;
-
-	switch (via_clock) {
-		case 33000: via_clock =3D 33333; break;
-		case 37000: via_clock =3D 37500; break;
-		case 41000: via_clock =3D 41666; break;
-	}
-
-	if (via_clock < 20000 || via_clock > 50000) {
-		printk(KERN_WARNING "VP_IDE: User given PCI clock speed impossible (%d),=
 using 33 MHz instead.\n", via_clock);
-		printk(KERN_WARNING "VP_IDE: Use ide0=3Data66 if you want to assume 80-w=
ire cable.\n");
-		via_clock =3D 33333;
-	}
+	via_clock =3D ata_system_bus_clock();
=20
 /*
  * Print the boot message.

--lHGcFxmlz1yfXmOs--

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE862UlBm4rlNOo3YgRAlsyAJ0W4/wXg7IeeaXjVLOPkZoux+5l2QCfZZb0
8UUJ9qmISQkbWGodd0PHgjE=
=DYnQ
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
