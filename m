Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVANMBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVANMBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVANMBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:01:45 -0500
Received: from mail.donpac.ru ([80.254.111.2]:20378 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261962AbVANMBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:01:05 -0500
Date: Fri, 14 Jan 2005 15:01:01 +0300
From: Andrey Panin <pazke@donpac.ru>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+serial@arm.linux.org.uk>
Subject: Re: [PATCH] [2.6] Clean up useless 8250 siig functions and header
Message-ID: <20050114120101.GA29859@pazke>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <rmk+serial@arm.linux.org.uk>
References: <71216E5F-5F6C-11D9-B39F-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <71216E5F-5F6C-11D9-B39F-000393ACC76E@mac.com>
X-Uname: Linux 2.6.6 i686
User-Agent: Mutt/1.5.6+20040907i
X-SMTP-Authenticated: pazke@donpac.ru (ntlm)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 005, 01 05, 2005 at 05:52:14PM -0500, Kyle Moffett wrote:
> This removes two simple siig functions that should just be integrated=20
> into the calling code.

Good idea, wrong patch. You deleted wrapper code, but actual init
functions left not exported for use by parport_serial module.
Even worse, they are left static, so monilithic kernel build will
not work too :/

Did you compiled the kernel with your patch applied ?

Please use attached patch instead.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-siig-cleanup
Content-Transfer-Encoding: quoted-printable

diff -urdpNX /usr/share/dontdiff linux-2.6.11-rc1.vanilla/drivers/parport/p=
arport_serial.c linux-2.6.11-rc1/drivers/parport/parport_serial.c
--- linux-2.6.11-rc1.vanilla/drivers/parport/parport_serial.c	2004-12-25 00=
:35:28.000000000 +0300
+++ linux-2.6.11-rc1/drivers/parport/parport_serial.c	2005-01-14 10:38:53.0=
00000000 +0300
@@ -159,12 +159,12 @@ struct pci_board_no_ids {
=20
 static int __devinit siig10x_init_fn(struct pci_dev *dev, struct pci_board=
_no_ids *board, int enable)
 {
-	return pci_siig10x_fn(dev, enable);
+	return enable ? pci_siig10x_init(dev) : 0;
 }
=20
 static int __devinit siig20x_init_fn(struct pci_dev *dev, struct pci_board=
_no_ids *board, int enable)
 {
-	return pci_siig20x_fn(dev, enable);
+	return enable ? pci_siig20x_init(dev) : 0;
 }
=20
 static struct pci_board_no_ids pci_boards[] __devinitdata =3D {
diff -urdpNX /usr/share/dontdiff linux-2.6.11-rc1.vanilla/drivers/serial/82=
50_pci.c linux-2.6.11-rc1/drivers/serial/8250_pci.c
--- linux-2.6.11-rc1.vanilla/drivers/serial/8250_pci.c	2004-12-25 00:35:23.=
000000000 +0300
+++ linux-2.6.11-rc1/drivers/serial/8250_pci.c	2005-01-14 10:57:26.00000000=
0 +0300
@@ -393,7 +392,7 @@ static void __devexit sbs_exit(struct pc
 #define PCI_DEVICE_ID_SIIG_1S_10x (PCI_DEVICE_ID_SIIG_1S_10x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S_10x (PCI_DEVICE_ID_SIIG_2S_10x_550 & 0xfff8)
=20
-static int pci_siig10x_init(struct pci_dev *dev)
+int pci_siig10x_init(struct pci_dev *dev)
 {
 	u16 data;
 	void __iomem *p;
@@ -419,11 +418,12 @@ static int pci_siig10x_init(struct pci_d
 	iounmap(p);
 	return 0;
 }
+EXPORT_SYMBOL(pci_siig10x_init);
=20
 #define PCI_DEVICE_ID_SIIG_2S_20x (PCI_DEVICE_ID_SIIG_2S_20x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S1P_20x (PCI_DEVICE_ID_SIIG_2S1P_20x_550 & 0xf=
ffc)
=20
-static int pci_siig20x_init(struct pci_dev *dev)
+int pci_siig20x_init(struct pci_dev *dev)
 {
 	u8 data;
=20
@@ -439,25 +439,7 @@ static int pci_siig20x_init(struct pci_d
 	}
 	return 0;
 }
-
-int pci_siig10x_fn(struct pci_dev *dev, int enable)
-{
-	int ret =3D 0;
-	if (enable)
-		ret =3D pci_siig10x_init(dev);
-	return ret;
-}
-
-int pci_siig20x_fn(struct pci_dev *dev, int enable)
-{
-	int ret =3D 0;
-	if (enable)
-		ret =3D pci_siig20x_init(dev);
-	return ret;
-}
-
-EXPORT_SYMBOL(pci_siig10x_fn);
-EXPORT_SYMBOL(pci_siig20x_fn);
+EXPORT_SYMBOL(pci_siig20x_init);
=20
 /*
  * Timedia has an explosion of boards, and to avoid the PCI table from
diff -urdpNX /usr/share/dontdiff linux-2.6.11-rc1.vanilla/include/linux/825=
0_pci.h linux-2.6.11-rc1/include/linux/8250_pci.h
--- linux-2.6.11-rc1.vanilla/include/linux/8250_pci.h	2004-12-25 00:35:25.0=
00000000 +0300
+++ linux-2.6.11-rc1/include/linux/8250_pci.h	2005-01-14 10:57:42.000000000=
 +0300
@@ -1,2 +1,2 @@
-int pci_siig10x_fn(struct pci_dev *dev, int enable);
-int pci_siig20x_fn(struct pci_dev *dev, int enable);
+int pci_siig10x_init(struct pci_dev *dev);
+int pci_siig20x_init(struct pci_dev *dev);

--envbJBWh7q8WU6mo--

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB57R9by9O0+A2ZecRAq9rAJ45kEzBHG2+LrL5pcr+d9CD2hjkzwCgsYaw
+xe5HFu59KRzRl3bpeb+9dM=
=HVb/
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
