Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSE1GG2>; Tue, 28 May 2002 02:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSE1GG1>; Tue, 28 May 2002 02:06:27 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:14610 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S312486AbSE1GG0>;
	Tue, 28 May 2002 02:06:26 -0400
Date: Tue, 28 May 2002 10:11:11 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Serverworks IDE driver: minor cleanups
Message-ID: <20020528061111.GB2111@pazke.ipt>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: multipart/mixed; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

this patch contains some minor cleanups for Serverworks IDE driver:
	- udma_modes[] array in svwks_tune_chipset() function is=20
	  meaningless (lists  0,1,2,3,4,5). Removed;
	- same function, variable drive_pci2 =3D=3D drive_pci + 4, no
	  need to assign it in the switch statement;
	- removed some unneeded initializations of local vars;
	- svwks_proc variable moved into #ifdef DISPLAY_SVWKS_TIMING
	  where it must live.

Compiles, but untested. Please consider applyiing.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-serverworks
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/serverworks.c li=
nux/drivers/ide/serverworks.c
--- linux.vanilla/drivers/ide/serverworks.c	Tue May 28 03:45:52 2002
+++ linux/drivers/ide/serverworks.c	Tue May 28 03:49:03 2002
@@ -98,7 +98,7 @@
 #undef DISPLAY_SVWKS_TIMINGS
 #undef SVWKS_DEBUG_DRIVE_INFO
=20
-static u8 svwks_revision =3D 0;
+static u8 svwks_revision;
=20
 #if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
@@ -230,12 +230,13 @@
 				((reg40&0x005D0000)=3D=3D0x005D0000)?"0":"?");
 	return p-buffer;	 /* =3D> must be less than 4k! */
 }
+
+static byte svwks_proc;
+
 #endif  /* defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS) */
=20
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.=
0) */
=20
-byte svwks_proc =3D 0;
-
 extern char *ide_xfer_verbose (byte xfer_rate);
=20
 static struct pci_dev *isa_dev;
@@ -262,7 +263,6 @@
=20
 static int svwks_tune_chipset(struct ata_device *drive, byte speed)
 {
-	static u8 udma_modes[]	=3D { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
 	static u8 dma_modes[]	=3D { 0x77, 0x21, 0x20 };
 	static u8 pio_modes[]	=3D { 0x5d, 0x47, 0x34, 0x22, 0x20 };
=20
@@ -271,26 +271,23 @@
 	byte unit		=3D (drive->select.b.unit & 0x01);
 	byte csb5		=3D (dev->device =3D=3D PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) ? 1=
 : 0;
=20
-	byte drive_pci		=3D 0x00;
-	byte drive_pci2		=3D 0x00;
-	byte drive_pci3		=3D hwif->unit ? 0x57 : 0x56;
-
-	byte ultra_enable	=3D 0x00;
-	byte ultra_timing	=3D 0x00;
-	byte dma_timing		=3D 0x00;
-	byte pio_timing		=3D 0x00;
-	unsigned short csb5_pio	=3D 0x00;
+	byte drive_pci, drive_pci2;
+	byte drive_pci3	=3D hwif->unit ? 0x57 : 0x56;
+
+	byte ultra_enable, ultra_timing, dma_timing, pio_timing;
+	unsigned short csb5_pio;
=20
 	byte pio =3D ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
=20
         switch (drive->dn) {
-		case 0: drive_pci =3D 0x41; drive_pci2 =3D 0x45; break;
-		case 1: drive_pci =3D 0x40; drive_pci2 =3D 0x44; break;
-		case 2: drive_pci =3D 0x43; drive_pci2 =3D 0x47; break;
-		case 3: drive_pci =3D 0x42; drive_pci2 =3D 0x46; break;
+		case 0: drive_pci =3D 0x41; break;
+		case 1: drive_pci =3D 0x40; break;
+		case 2: drive_pci =3D 0x43; break;
+		case 3: drive_pci =3D 0x42; break;
 		default:
 			return -1;
 	}
+	drive_pci2 =3D drive_pci + 4;
=20
 	pci_read_config_byte(dev, drive_pci, &pio_timing);
 	pci_read_config_byte(dev, drive_pci2, &dma_timing);
@@ -337,7 +334,7 @@
 			pio_timing   |=3D pio_modes[pio];
 			csb5_pio     |=3D (pio << (4*drive->dn));
 			dma_timing   |=3D dma_modes[2];
-			ultra_timing |=3D ((udma_modes[speed - XFER_UDMA_0]) << (4*unit));
+			ultra_timing |=3D ((speed - XFER_UDMA_0) << (4*unit));
 			ultra_enable |=3D (0x01 << drive->dn);
 #endif
 		default:

--nHwqXXcoX0o6fKCv--

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE88x9/Bm4rlNOo3YgRAligAJ9nV4Vl7qcEF2OLewXHo9zbSB1G7QCeJXN1
2gutMrYERLPnVhEBETws5NQ=
=Z5WR
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
