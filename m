Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264949AbRFZNyC>; Tue, 26 Jun 2001 09:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264947AbRFZNxx>; Tue, 26 Jun 2001 09:53:53 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:46598 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S264946AbRFZNxb>;
	Tue, 26 Jun 2001 09:53:31 -0400
Date: Tue, 26 Jun 2001 17:53:26 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SMSC SLC90E66: IRQ router support and PCI quirk
Message-ID: <20010626175326.A29296@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
User-Agent: Mutt/1.0.1i
X-Uptime: 5:42pm  up 27 days,  1:25,  3 users,  load average: 0.08, 0.04, 0.00
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

SMSC SLC90E66 is southbridge chip, designed to be almost exact clone of
Intel PIIX4. So it needs same handling as an original chip.

Attached two patches against 2.4.5-ac17,=20
first adds IRQ router support (using functions for Intel PIIX4),
second adds quirk handling (ACPI/SMBus resources) same as for original PIIX=
4.

Both patches are untested, written according to SLC90E66 datasheet.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-SLC90E66-pirq
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/arch/i386/kernel/pci-irq.c linux/arch/i386/kernel/pc=
i-irq.c
--- linux.vanilla/arch/i386/kernel/pci-irq.c	Tue Jun 26 10:38:25 2001
+++ linux/arch/i386/kernel/pci-irq.c	Tue Jun 26 11:07:27 2001
@@ -174,7 +174,7 @@
 }
=20
 /*
- * The Intel PIIX4 pirq rules are fairly simple: "pirq" is
+ * The Intel PIIX4 and SMSC SLC90E66 pirq rules are fairly simple: "pirq" =
is
  * just a pointer to the config space.
  */
 static int pirq_piix_get(struct pci_dev *router, struct pci_dev *dev, int =
pirq)
@@ -448,6 +448,7 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_g=
et, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_g=
et, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_g=
et, pirq_piix_set },
+	{ "SLC90E66", PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_0, pirq_pii=
x_get, pirq_piix_set },
=20
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali=
_set },
=20

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-SLC90E66-quirk
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/arch/i386/kernel/pci-pc.c linux/arch/i386/kernel/pci=
-pc.c
--- linux.vanilla/arch/i386/kernel/pci-pc.c	Tue Jun 26 10:38:25 2001
+++ linux/arch/i386/kernel/pci-pc.c	Tue Jun 26 15:03:16 2001
@@ -943,7 +943,7 @@
 static void __init pci_fixup_piix4_acpi(struct pci_dev *d)
 {
 	/*
-	 * PIIX4 ACPI device: hardwired IRQ9
+	 * Intel PIIX4 and SMSC SLC90E66 ACPI device: hardwired IRQ9
 	 */
 	d->irq =3D 9;
 }
@@ -996,6 +996,7 @@
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C598_1,	pci_f=
ixup_via691_2 },
 #endif =09
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	=
pci_fixup_piix4_acpi },
+	{ PCI_FIXUP_HEADER,	PCI_DEVICE_ID_EFAR,	PCI_DEVICE_ID_EFAR_SLC90E66_3,	pc=
i_fixup_piix4_acpi },
 	{ 0 }
 };
=20
diff -ur linux.vanilla/drivers/pci/quirks.c linux/drivers/pci/quirks.c
--- linux.vanilla/drivers/pci/quirks.c	Tue Jun 26 10:37:55 2001
+++ linux/drivers/pci/quirks.c	Tue Jun 26 15:00:31 2001
@@ -209,7 +209,7 @@
 }
=20
 /*
- * PIIX4 ACPI: Two IO regions pointed to by longwords at
+ * Intel PIIX4 and SMSC SLC90E66 ACPI: Two IO regions pointed to by longwo=
rds at
  *	0x40 (64 bytes of ACPI registers)
  *	0x90 (32 bytes of SMB registers)
  */
@@ -423,6 +423,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_=
vt82c586_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_=
vt82c686_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	q=
uirk_piix4_acpi },
+	{ PCI_FIXUP_HEADER,	PCI_DEVICE_ID_EFAR,	PCI_DEVICE_ID_EFAR_SLC90E66_3,	qu=
irk_piix4_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7=
101_acpi },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	=
quirk_piix3_usb },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	q=
uirk_piix3_usb },

--SLDf9lqlvOQaIe6s--

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7OJPWBm4rlNOo3YgRAgy7AJ9qExLsCZX7tcquVAzVkWQJNLxdwwCgkOWS
Hbo1LJrr3Jtq7ycIhff/7Go=
=R4Wb
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
