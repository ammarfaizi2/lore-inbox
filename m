Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVDUFyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVDUFyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 01:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDUFyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 01:54:09 -0400
Received: from ipex1.johnshopkins.edu ([162.129.8.141]:39219 "EHLO
	ipex1.johnshopkins.edu") by vger.kernel.org with ESMTP
	id S261226AbVDUFx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 01:53:59 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="3.92,118,1112587200"; 
   d="scan'208"; a="58570025:sNHT58456184"
Date: Thu, 21 Apr 2005 01:54:15 -0400
From: Albert Lee <trisk@jhu.edu>
X-Face: :/#.G_&p&9W`T7k,`*,P`4/v+~mn&`vrX74Hd8q3s>/doPt0f9>bu_4YGUK'pW80<F"=?iso-8859-1?q?I3z=0A=09x1D6Q=7DD=7BwC6SHI?=",kYEu%K;@9+x~qj+(Zm#58J{C^9H`y_o8.efuk5e1&(e,=?iso-8859-1?q?p-=7CS=24=3F9PqU=0A=096b55bJ=7B=3AH?=<.Z*@bv&SE@WR#t@[>ec6G+An+]}6;:
Subject: [PATCH] hpt366: HPT372N rev 2 controller fix
To: linux-kernel@vger.kernel.org
Message-id: <200504210154.20031.trisk@jhu.edu>
Organization: Johns Hopkins University
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=nextPart20268482.fmVuOdh3uH
Content-transfer-encoding: 7bit
User-Agent: KMail/1.8
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Message-Flag: Get yourself a real mail client.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart20268482.fmVuOdh3uH
Content-Type: multipart/mixed;
  boundary="Boundary-01=_JA0ZC/LAHlbo5JN"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_JA0ZC/LAHlbo5JN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A particular revision of the HPT372N oopses hpt366 consistently. It's a=20
regression caused by Alan's changes in 2.6.9 to support the HPT372N using=20
only PLL timings. The driver works correctly in prior versions, where the t=
he=20
PCI clock is used instead. This patch restores that behaviour for this=20
particular revision.

More info:
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.0/0958.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D135515

Please CC replies to me.

=2DAlbert

=2D-=20
Prediction is very difficult, especially of the future.
                -- Niels Bohr

--Boundary-01=_JA0ZC/LAHlbo5JN
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hpt366-hpt372rev2-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hpt366-hpt372rev2-fix.patch"

=2D-- hpt366.c.orig	2004-11-20 17:13:52.280360000 -0500
+++ hpt366.c	2005-04-21 00:40:38.686009488 -0400
@@ -802,6 +802,9 @@
 =09
 		if((did =3D=3D 4 && rid =3D=3D 6) || (did =3D=3D 5 && rid > 1))
 			is_372n =3D 1;
+		/* Check for a HPT372 rev 2, which is a special 372N */
+		if(did =3D=3D 5 && rid =3D=3D 2)
+			is_372n =3D 2;
 	}
=20
 	/*
@@ -845,7 +848,25 @@
 		=09
 		printk(KERN_INFO "FREQ: %d PLL: %d\n", freq, pll);
 		=09
=2D		/* We always use the pll not the PCI clock on 372N */
+		/* We always use the pll not the PCI clock on 372N,
+		 * except for the 372 rev 2, which works fine with 372A
+		 * timings, and needs pci_set_drvdata().
+		 */
+		if(is_372n =3D=3D 2)
+		{
+			if (pll =3D=3D F_LOW_PCI_33) {
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt372);
+				printk("HPT37X: HPT372 rev 2 detected, using 33MHz PCI clock\n");
+			} else if (pll =3D=3D F_LOW_PCI_40) {
+				/* Unsupported */
+			} else if (pll =3D=3D F_LOW_PCI_50) {
+				pci_set_drvdata(dev, (void *) fifty_base_hpt372);
+				printk("HPT37X: HPT372 rev 2 detected, using 50MHz PCI clock\n");
+			} else {
+				pci_set_drvdata(dev, (void *) sixty_six_base_hpt372);
+				printk("HPT37X: HPT372 rev 2 detected, using 66MHz PCI clock\n");
+			}
+		}
 	}
 	else
 	{

--Boundary-01=_JA0ZC/LAHlbo5JN--

--nextPart20268482.fmVuOdh3uH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCZ0ALKqikHyIYuCkRAmTRAJ9UHzczkDQk3zR95vau+Dc+5GvpMgCfWPy4
kqoOWY06RS+aJxDCiT2ugyM=
=tczl
-----END PGP SIGNATURE-----

--nextPart20268482.fmVuOdh3uH--
