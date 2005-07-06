Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVGFFCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVGFFCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVGFFAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:00:30 -0400
Received: from [143.90.131.186] ([143.90.131.186]:33860 "EHLO t-mta8.odn.ne.jp")
	by vger.kernel.org with ESMTP id S262096AbVGFCvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:51:48 -0400
Date: Wed, 6 Jul 2005 11:51:36 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: sata_sil 3112 activity LED patch
Message-ID: <20050706025136.GA15493@alumni.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After finally getting fed up with not having my activity light working
for my SATA drives, I came up with a small patch (more like hack) to
make it work.  It works quite well, but I'm afraid that there are many
restriction that this patch does not check for that it probably
should... so consider this a work-in-progress.  My information is
based on a document from Silicon Image that appears to no longer be
available on their website (Sil-AN-0082-E; 8112-0082.pdf).  I still
have a copy if anyone is interested.

There are two restrictions that are not checked:

1) Is the chip a 3112 or 3114?  I assume that this would only work on
   a 3112, but whether it is "a bad thing" on a 3114 I do not know.

2) BAR5 + 0x54 is apparently used for the flash memory address and
   data lines.  However for most motherboards (i.e. not add-on cards)
   with the chip, like my EPOX 8RDA3+, there is no flash memory, so
   these lines are hijacked as LED GPIO.  I assume that this is a
   common practice for motherboard makers using the sil3112 since
   Silicon Image went out of their way to produce the above mentioned
   document.  Anyways, the problem is that this patch does not check
   if flash memory is installed or not before twiddling with the GPIO
   lines.  This could be extremely bad for people running the 3112
   from add-on cards (or any implementation with flash memory
   installed).

Setting the low 8bits at BAR5+54h seems to enable the LED circuit.  It
seems that this circuit is patched through into the motherboard as it
lights the regular hard drive light on the front of my case.  Setting
bits [8:15] at BAR5+54h clears the bits, disabling the LED.  I hooked
this logic into the ata_bmdma_start and ata_bmdma_stop which were made
into simple wrapper functions in sata_sil.c that just set the GPIO
bits and calls ata_bmdma_*.

As a sanity test, I ran my drive, loaded, overnight with no problems.

If there is a better way to do this, I would be happy to hear any
suggestions... it is kind of ugly as it is now.

--=20
Aric Cyr <acyr at alumni dot uwaterloo dot ca>    (http://acyr.net)
gpg fingerprint: 943A 1549 47AC D766 B7F8  D551 6703 7142 C282 D542

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_sil-led.patch"
Content-Transfer-Encoding: quoted-printable

--- sata_sil.c.orig	2005-06-15 17:48:23.000000000 +0900
+++ sata_sil.c	2005-07-06 01:58:28.000000000 +0900
@@ -45,6 +45,7 @@
 	sil_3114		=3D 1,
=20
 	SIL_SYSCFG		=3D 0x48,
+	SIL_GPIO                =3D 0x54,
 	SIL_MASK_IDE0_INT	=3D (1 << 22),
 	SIL_MASK_IDE1_INT	=3D (1 << 23),
 	SIL_MASK_IDE2_INT	=3D (1 << 24),
@@ -65,6 +66,8 @@
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 v=
al);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_bmdma_start(struct ata_queued_cmd *qc);
+static void sil_bmdma_stop(struct ata_port *ap);
=20
 static struct pci_device_id sil_pci_tbl[] =3D {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -138,8 +140,8 @@
 	.phy_reset		=3D sata_phy_reset,
 	.post_set_mode		=3D sil_post_set_mode,
 	.bmdma_setup            =3D ata_bmdma_setup,
-	.bmdma_start            =3D ata_bmdma_start,
-	.bmdma_stop		=3D ata_bmdma_stop,
+	.bmdma_start            =3D sil_bmdma_start,
+	.bmdma_stop		=3D sil_bmdma_stop,
 	.bmdma_status		=3D ata_bmdma_status,
 	.qc_prep		=3D ata_qc_prep,
 	.qc_issue		=3D ata_qc_issue_prot,
@@ -198,6 +200,35 @@
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
=20
+static void sil_bmdma_start(struct ata_queued_cmd *qc)
+{
+  void* mmio_base =3D qc->ap->host_set->mmio_base;
+  u32 gpio =3D readl(mmio_base + SIL_GPIO);
+
+  /* setting the lower 8 bits to activate the activity LED */
+  gpio |=3D 0x00ff;
+  writel(gpio, mmio_base + SIL_GPIO);
+  readl(mmio_base + SIL_GPIO);	/* flush */
+
+  ata_bmdma_start(qc);
+}
+
+static void sil_bmdma_stop(struct ata_port *ap)
+{
+  void* mmio_base =3D ap->host_set->mmio_base;
+  u32 gpio =3D readl(mmio_base + SIL_GPIO);
+
+  ata_bmdma_stop(ap);
+
+  /*=20
+   * setting bits [8:15] clears the lower 8 bits,
+   * deactivating the activity LED
+   */
+  gpio |=3D 0xff00;
+  writel(gpio, mmio_base + SIL_GPIO);
+  readl(mmio_base + SIL_GPIO);	/* flush */
+}
+
 static void sil_post_set_mode (struct ata_port *ap)
 {
 	struct ata_host_set *host_set =3D ap->host_set;

--UlVJffcvxoiEqYs2--

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCy0c4ZwNxQsKC1UIRAkMYAJ4o0M2/0f5GhLQmf1SxNhSemd7wGACgm843
Jwy5ekpL+2DRzLSJhPVBSII=
=VGVh
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
