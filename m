Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUFKK2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUFKK2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 06:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUFKK2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 06:28:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:55222 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263784AbUFKK2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 06:28:41 -0400
Date: Fri, 11 Jun 2004 12:25:45 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Tigerjet 320 chipset fix
Message-ID: <20040611102545.GB10075@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.4-52-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this fix solve a endless IRQ loop for Tigerjet 320 based ISDN cards.
Please apply.

--- linux/drivers/isdn/hisax/nj_s.c.old	2004-05-18 17:00:38.000000000 +0200
+++ linux/drivers/isdn/hisax/nj_s.c	2004-05-18 17:00:38.000000000 +0200
@@ -104,9 +104,12 @@
 	cs->hw.njet.ctrl_reg =3D 0xff;  /* Reset On */
 	byteout(cs->hw.njet.base + NETJET_CTRL, cs->hw.njet.ctrl_reg);
 	mdelay(10);
-	cs->hw.njet.ctrl_reg =3D 0x00;  /* Reset Off and status read clear */
 	/* now edge triggered for TJ320 GE 13/07/00 */
 	/* see comment in IRQ function */
+	if (cs->subtyp) /* TJ320 */
+		cs->hw.njet.ctrl_reg =3D 0x40;  /* Reset Off and status read clear */
+	else
+		cs->hw.njet.ctrl_reg =3D 0x00;  /* Reset Off and status read clear */
 	byteout(cs->hw.njet.base + NETJET_CTRL, cs->hw.njet.ctrl_reg);
 	mdelay(10);
 	cs->hw.njet.auxd =3D 0;
@@ -151,7 +154,7 @@
 int __init
 setup_netjet_s(struct IsdnCard *card)
 {
-	int bytecnt;
+	int bytecnt,cfg;
 	struct IsdnCardState *cs =3D card->cs;
 	char tmp[64];
=20
@@ -183,6 +186,15 @@
 				printk(KERN_WARNING "NETjet-S: No IO-Adr for PCI card found\n");
 				return(0);
 			}
+			/* the TJ300 and TJ320 must be detected, the IRQ handling is different
+			 * unfortunatly the chips use the same device ID, but the TJ320 has
+			 * the bit20 in status PCI cfg register set
+			 */
+			pci_read_config_dword(dev_netjet, 0x04, &cfg);
+			if (cfg & 0x00100000)
+				cs->subtyp =3D 1; /* TJ320 */
+			else
+				cs->subtyp =3D 0; /* TJ300 */
 			/* 2001/10/04 Christoph Ersfeld, Formula-n Europe AG www.formula-n.com =
*/
 			if ((dev_netjet->subsystem_vendor =3D=3D 0x55) &&
 				(dev_netjet->subsystem_device =3D=3D 0x02)) {
@@ -240,8 +252,8 @@
 	bytecnt =3D 256;
=20
 	printk(KERN_INFO
-		"NETjet-S: PCI card configured at %#lx IRQ %d\n",
-		cs->hw.njet.base, cs->irq);
+		"NETjet-S: %s card configured at %#lx IRQ %d\n",
+		cs->subtyp ? "TJ320" : "TJ300", cs->hw.njet.base, cs->irq);
 	if (!request_region(cs->hw.njet.base, bytecnt, "netjet-s isdn")) {
 		printk(KERN_WARNING
 		       "HiSax: %s config port %#lx-%#lx already in use\n",

--=20
Karsten Keil
SuSE Labs
ISDN development

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyYipo5VVC52CNcQRAueQAJ0fIduj/BxULEI1DRw98XtmwnRCPQCfZGDF
obmg1dw04eUXUm7rWjrokVc=
=K2fa
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
