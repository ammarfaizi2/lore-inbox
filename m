Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269053AbRG3SpE>; Mon, 30 Jul 2001 14:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269078AbRG3Soz>; Mon, 30 Jul 2001 14:44:55 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:59205 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S269052AbRG3Soq>; Mon, 30 Jul 2001 14:44:46 -0400
Date: Mon, 30 Jul 2001 20:43:54 +0200
From: Kurt Garloff <garloff@suse.de>
To: Michael <leahcim@ntlworld.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        Daniela Engert <dani@ngrt.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010730204354.B26097@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Michael <leahcim@ntlworld.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Daniela Engert <dani@ngrt.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010729222830.A25964@pckurt.casa-etp.nl> <20010730125012Z268576-720+7896@vger.kernel.org> <20010730154458.C4859@pckurt.casa-etp.nl> <20010730151538.A5600@debian> <20010730174653.D4859@pckurt.casa-etp.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <20010730174653.D4859@pckurt.casa-etp.nl>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--u65IjBhB3TIa72Vp
Content-Type: multipart/mixed; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

OK, patches for different bits are attached.
The patch does modify up to 4 bits, which is more than I would like to do in
the end. But you can easily disable some parts of it, if the full patch
proves to solve your trouble.
Please test!

It seemed to solved the trouble here on first sight (booting went further
then normal) but in the end did not turn out to solve the trouble here.
(Here means: MSI K7T Turbo (Ver.3) with AMD K7 1.2GHz.)

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="247-viakt133.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.7.compile/drivers/pci/quirks.c.orig	Tue Jul 24 16:50:41 2001
+++ linux-2.4.7.compile/drivers/pci/quirks.c	Mon Jul 30 20:21:56 2001
@@ -160,6 +160,49 @@
 }
=20
 /*
+ * KT133a will fsck up under some circumstances if Burst Refresh (4 times)
+ * is enabled or if data latch delay is disabled
+ * and we use the fast streaming K7 optimized zero_page
+ * and copy_page routines from arch/i386/lib/mmx.c=20
+ * -- garloff@suse.de, 2001-07-30
+ */
+static void __init quirk_via_noburstrefresh(struct pci_dev *dev)
+{
+	u8 dram_ctrl;
+	pci_read_config_byte(dev, 0x68, &dram_ctrl);
+	if (dram_ctrl & 0x04 || !(dram_ctrl & 0x10)) {
+		if (dram_ctrl & 0x04)
+	  		printk(KERN_INFO "VIA KT133a: Disabling burst refresh.\n");
+		dram_ctrl &=3D ~0x04;
+		if (!(dram_ctrl & 0x10))
+	  		printk(KERN_INFO "VIA KT133a: Enabling data latch delay.\n");
+		dram_ctrl |=3D 0x10;
+		pci_write_config_byte(dev, 0x68, dram_ctrl);
+	}
+}
+
+/*
+ * KT133a will fsck up under some circumstances if Probe Next Tag State=20
+ * T1 is set to 1 and we use the fast streaming K7 optimized zero_page
+ * and copy_page routines from arch/i386/lib/mmx.c=20
+ * -- garloff@suse.de, 2001-07-30
+ */
+static void __init quirk_via_noprobenexttag(struct pci_dev *dev)
+{
+	u8 biu_ctrl;
+	pci_read_config_byte(dev, 0x54, &biu_ctrl);
+	if (biu_ctrl & 0x40 || biu_ctrl & 0x01) {
+		if (biu_ctrl & 0x40)
+			printk(KERN_INFO "VIA KT133a: Disabling probe next tag state T1.\n");
+		if (biu_ctrl & 0x01)
+			printk(KERN_INFO "VIA KT133a: Disabling fast write-to-read.\n");
+		biu_ctrl &=3D ~0x41;
+		pci_write_config_byte(dev, 0x54, biu_ctrl);
+	}
+}
+
+
+/*
  *	Natoma has some interesting boundary conditions with Zoran stuff
  *	at least
  */
@@ -452,6 +495,9 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_v=
ia_irqpic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_v=
ia_irqpic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_v=
ia_irqpic },
+
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_via=
_noburstrefresh },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_via=
_noprobenexttag },
=20
 	{ 0 }
 };

--O3RTKUHj+75w1tg5--

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZarqxmLh6hyYd04RAgIgAJoCJUPpYmFmR9zO+mN+9QlkaEEkdgCffFS3
ELlXzgwp/ugAYa0jP8LSRTE=
=7Nc5
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
