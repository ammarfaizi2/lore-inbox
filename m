Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277700AbRJRNXH>; Thu, 18 Oct 2001 09:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277702AbRJRNW6>; Thu, 18 Oct 2001 09:22:58 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:64264 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S277700AbRJRNWw>;
	Thu, 18 Oct 2001 09:22:52 -0400
Date: Thu, 18 Oct 2001 17:23:26 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_DEVICE_TABLE for Moxa serial card drivers
Message-ID: <20011018172326.A23104@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 4:36pm  up 6 days,  4:45,  2 users,  load average: 0.00, 0.08, 0.08
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

these two patches add MODULE_DEVICE_TABLE into Moxa serial card drivers (mo=
xa.c and mxser.c).
Untested, but compiles and should work :)

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-moxa
Content-Transfer-Encoding: quoted-printable

diff -ur -X /usr/dontdiff /linux.vanilla/drivers/char/moxa.c /linux/drivers=
/char/moxa.c
--- /linux.vanilla/drivers/char/moxa.c	Wed Oct 17 11:25:43 2001
+++ /linux/drivers/char/moxa.c	Thu Oct 18 12:15:14 2001
@@ -105,18 +105,16 @@
 	"CP-204J series",
 };
=20
-typedef struct {
-	unsigned short vendor_id;
-	unsigned short device_id;
-	unsigned short board_type;
-} moxa_pciinfo;
-
-static moxa_pciinfo moxa_pcibrds[] =3D
-{
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C218, MOXA_BOARD_C218_PCI},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C320, MOXA_BOARD_C320_PCI},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP204J, MOXA_BOARD_CP204J},
+static struct pci_device_id moxa_pcibrds[] =3D {
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C218, PCI_ANY_ID, PCI_ANY_ID,=20
+	  0, 0, MOXA_BOARD_C218_PCI },
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C320, PCI_ANY_ID, PCI_ANY_ID,=20
+	  0, 0, MOXA_BOARD_C320_PCI },
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP204J, PCI_ANY_ID, PCI_ANY_ID,=20
+	  0, 0, MOXA_BOARD_CP204J },
+	{ 0 }
 };
+MODULE_DEVICE_TABLE(pci, moxa_pcibrds);
=20
 typedef struct _moxa_isa_board_conf {
 	int boardType;
@@ -487,10 +485,10 @@
 #ifdef CONFIG_PCI
 	{
 		struct pci_dev *p =3D NULL;
-		n =3D sizeof(moxa_pcibrds) / sizeof(moxa_pciinfo);
+		n =3D (sizeof(moxa_pcibrds) / sizeof(moxa_pcibrds[0])) - 1;
 		i =3D 0;
 		while (i < n) {
-			while((p =3D pci_find_device(moxa_pcibrds[i].vendor_id, moxa_pcibrds[i]=
.device_id, p))!=3DNULL)
+			while ((p =3D pci_find_device(moxa_pcibrds[i].vendor, moxa_pcibrds[i].d=
evice, p))!=3DNULL)
 			{
 				if (pci_enable_device(p))
 					continue;
@@ -498,7 +496,7 @@
 					if (verbose)
 						printk("More than %d MOXA Intellio family boards found. Board is ign=
ored.", MAX_BOARDS);
 				} else {
-					moxa_get_PCI_conf(p, moxa_pcibrds[i].board_type,
+					moxa_get_PCI_conf(p, moxa_pcibrds[i].driver_data,
 						&moxa_boards[numBoards]);
 					numBoards++;
 				}

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mxser
Content-Transfer-Encoding: quoted-printable

diff -ur -X /usr/dontdiff /linux.vanilla/drivers/char/mxser.c /linux/driver=
s/char/mxser.c
--- /linux.vanilla/drivers/char/mxser.c	Wed Oct 17 11:25:41 2001
+++ /linux/drivers/char/mxser.c	Thu Oct 18 12:14:04 2001
@@ -159,17 +159,14 @@
 #define         MOXA_GET_CUMAJOR      (MOXA + 64)
 #define         MOXA_GETMSTATUS       (MOXA + 65)
=20
-typedef struct {
-	unsigned short vendor_id;
-	unsigned short device_id;
-	unsigned short board_type;
-} mxser_pciinfo;
-
-static mxser_pciinfo mxser_pcibrds[] =3D
-{
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C168, MXSER_BOARD_C168_PCI},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C104, MXSER_BOARD_C104_PCI},
+static struct pci_device_id mxser_pcibrds[] =3D {
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C168, PCI_ANY_ID, PCI_ANY_ID, 0, 0,=
=20
+	  MXSER_BOARD_C168_PCI },
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C104, PCI_ANY_ID, PCI_ANY_ID, 0, 0,=
=20
+	  MXSER_BOARD_C104_PCI },
+	{ 0 }
 };
+MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
=20
 static int ioaddr[MXSER_BOARDS];
 static int ttymajor =3D MXSERMAJOR;
@@ -614,22 +611,22 @@
 	{
 		struct pci_dev *pdev =3D NULL;
=20
-		n =3D sizeof(mxser_pcibrds) / sizeof(mxser_pciinfo);
+		n =3D (sizeof(mxser_pcibrds) / sizeof(mxser_pcibrds[0])) - 1;
 		index =3D 0;
 		for (b =3D 0; b < n; b++) {
-			pdev =3D pci_find_device(mxser_pcibrds[b].vendor_id,
-					       mxser_pcibrds[b].device_id, pdev);
+			pdev =3D pci_find_device(mxser_pcibrds[b].vendor,
+					       mxser_pcibrds[b].device, pdev);
 			if (!pdev || pci_enable_device(pdev))
 				continue;
 			hwconf.pdev =3D pdev;
 			printk("Found MOXA %s board(BusNo=3D%d,DevNo=3D%d)\n",
-				mxser_brdname[mxser_pcibrds[b].board_type],
+				mxser_brdname[mxser_pcibrds[b].driver_data],
 				pdev->bus->number, PCI_SLOT(pdev->devfn));
 			if (m >=3D MXSER_BOARDS) {
 				printk("Too many Smartio family boards found (maximum %d),board not co=
nfigured\n", MXSER_BOARDS);
 			} else {
 				retval =3D mxser_get_PCI_conf(pdev,
-				   mxser_pcibrds[b].board_type, &hwconf);
+				   mxser_pcibrds[b].driver_data, &hwconf);
 				if (retval < 0) {
 					if (retval =3D=3D MXSER_ERR_IRQ)
 						printk("Invalid interrupt number,board not configured\n");

--zYM0uCDKw75PZbzx--

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ztfOBm4rlNOo3YgRAshFAJ4mhMcPFGHWPZ6tMm6UPAVTHCpDMACfaj4/
HjAY0eKQiI6UVtJWaXZU4IQ=
=R86o
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
