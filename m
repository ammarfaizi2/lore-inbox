Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264193AbRFSLnU>; Tue, 19 Jun 2001 07:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264196AbRFSLnL>; Tue, 19 Jun 2001 07:43:11 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:64773 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S264193AbRFSLmz>;
	Tue, 19 Jun 2001 07:42:55 -0400
Date: Tue, 19 Jun 2001 15:42:59 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Intel ICHx PCI quirk
Message-ID: <20010619154259.A31000@orbita1.ru>
Reply-To: pazke@orbita1.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
User-Agent: Mutt/1.0.1i
X-Uptime: 3:25pm  up 19 days, 23:07,  3 users,  load average: 0.10, 0.10, 0.17
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

this patch adds quirk for Intel ICHx (I/O Controller Hub) LPC bridge to pro=
perly
report ACPI/TCO and GPIO base addresses.

Also quirk_via_acpi() function merged with quirk_vt82c586_acpi(). IMHO it's
not right to have two quirks for one device.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ichx-quirk
Content-Transfer-Encoding: quoted-printable

diff -u linux.vanilla/drivers/pci/quirks.c linux/drivers/pci/quirks.c
--- linux.vanilla/drivers/pci/quirks.c	Thu Jun 14 10:12:38 2001
+++ linux/drivers/pci/quirks.c	Mon Jun 18 16:11:52 2001
@@ -223,18 +223,38 @@
 }
=20
 /*
+ * Intel ICHx LPC bridge: Two IO regions pointed to by longwords at
+ *	0x40 (128 bytes of ACPI and TCO registers)
+ *	0x58 (64 bytes of GPIO registers)
+ */
+static void __init quirk_ichx_lpc(struct pci_dev *dev)
+{
+	u32 region;
+
+	pci_read_config_dword(dev, 0x40, &region);
+	quirk_io_region(dev, region, 128, PCI_BRIDGE_RESOURCES);
+	pci_read_config_dword(dev, 0x58, &region);
+	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);
+}
+
+/*
  * VIA ACPI: One IO region pointed to by longword at
  *	0x48 or 0x20 (256 bytes of ACPI registers)
+ *	SCI IRQ line in PCI config byte 0x42
  */
 static void __init quirk_vt82c586_acpi(struct pci_dev *dev)
 {
-	u8 rev;
+	u8 rev, irq;
 	u32 region;
=20
+	pci_read_config_byte(dev, 0x42, &irq);
+	irq &=3D 0xf;
+	if (irq && (irq !=3D 2))
+		dev->irq =3D irq;
+
 	pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
 	if (rev & 0x10) {
 		pci_read_config_dword(dev, 0x48, &region);
-		region &=3D PCI_BASE_ADDRESS_IO_MASK;
 		quirk_io_region(dev, region, 256, PCI_BRIDGE_RESOURCES);
 	}
 }
@@ -244,6 +264,7 @@
  *	0x48 (256 bytes of ACPI registers)
  *	0x70 (128 bytes of hardware monitoring register)
  *	0x90 (16 bytes of SMB registers)
+ *	SCI IRQ line in PCI config byte 0x42
  */
 static void __init quirk_vt82c686_acpi(struct pci_dev *dev)
 {
@@ -253,11 +274,9 @@
 	quirk_vt82c586_acpi(dev);
=20
 	pci_read_config_word(dev, 0x70, &hm);
-	hm &=3D PCI_BASE_ADDRESS_IO_MASK;
 	quirk_io_region(dev, hm, 128, PCI_BRIDGE_RESOURCES + 1);
=20
 	pci_read_config_dword(dev, 0x90, &smb);
-	smb &=3D PCI_BASE_ADDRESS_IO_MASK;
 	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 2);
 }
=20
@@ -313,17 +332,6 @@
  * value of the ACPI SCI interrupt is only done for convenience.
  *	-jgarzik
  */
-static void __init quirk_via_acpi(struct pci_dev *d)
-{
-	/*
-	 * VIA ACPI device: SCI IRQ line in PCI config byte 0x42
-	 */
-	u8 irq;
-	pci_read_config_byte(d, 0x42, &irq);
-	irq &=3D 0xf;
-	if (irq && (irq !=3D 2))
-		d->irq =3D irq;
-}
=20
 static void __init quirk_via_irqpic(struct pci_dev *dev)
 {
@@ -421,6 +429,9 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_=
vt82c586_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_=
vt82c686_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	q=
uirk_piix4_acpi },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AA_0,	q=
uirk_ichx_lpc },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AB_0,	q=
uirk_ichx_lpc },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	q=
uirk_ichx_lpc },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7=
101_acpi },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	=
quirk_piix3_usb },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	q=
uirk_piix3_usb },
@@ -429,8 +440,6 @@
 #ifdef CONFIG_X86_IO_APIC=20
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via=
_ioapic },
 #endif
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_=
via_acpi },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_=
via_acpi },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_v=
ia_irqpic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_v=
ia_irqpic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_v=
ia_irqpic },

--tKW2IUtsqtDRztdT--

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7LzrDBm4rlNOo3YgRAr3OAJ9vc3RO8ykyGC4r/3ssiqjHK8QOdQCdHPmN
duMOpyM6wHh36IPlclpr0UM=
=ubOv
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
