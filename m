Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261554AbSJ2LPg>; Tue, 29 Oct 2002 06:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJ2LPg>; Tue, 29 Oct 2002 06:15:36 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:17427 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S261554AbSJ2LPe>;
	Tue, 29 Oct 2002 06:15:34 -0500
Date: Tue, 29 Oct 2002 12:21:08 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] radeonfb aggregated LY/LZ 8MB + ia64 void * vs u32
Message-ID: <20021029112108.GB6792@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
this is an aggregated patch of 2 i found by google - With the M6 8MB
fix i got my Picturebook to work. The other one just looks like it makes
sense and does not harm my usage. I vote for inclusion into 2.4.x and
probably 2.5 as others already did.

This is the Radeon 8MB fix by :
http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.2/0281.html

The void ptr vs u32 fix can be found here by David Mosberger:
https://external-lists.vasoftware.com/archives/linux-ia64/2002-July/003663.=
html

--- linux-2.4.19/drivers/video/radeonfb.c	Sat Aug  3 02:39:45 2002
+++ linux-2.4.19.flo/drivers/video/radeonfb.c	Thu Oct 24 22:35:36 2002
@@ -258,8 +258,8 @@
 	u32 mmio_base_phys;
 	u32 fb_base_phys;
=20
-	u32 mmio_base;
-	u32 fb_base;
+	void *mmio_base;
+	void *fb_base;
=20
 	struct pci_dev *pdev;
=20
@@ -800,7 +800,7 @@
 	}
=20
 	/* map the regions */
-	rinfo->mmio_base =3D (u32) ioremap (rinfo->mmio_base_phys,
+	rinfo->mmio_base =3D ioremap (rinfo->mmio_base_phys,
 				    		    RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
 		printk ("radeonfb: cannot map MMIO\n");
@@ -866,6 +866,13 @@
 	/* mem size is bits [28:0], mask off the rest */
 	rinfo->video_ram =3D tmp & CONFIG_MEMSIZE_MASK;
=20
+	if (rinfo->video_ram =3D=3D 0 &&
+		(pdev->device =3D=3D PCI_DEVICE_ID_RADEON_LY ||
+		pdev->device =3D=3D PCI_DEVICE_ID_RADEON_LZ)) {
+
+		rinfo->video_ram =3D 8192*1024;
+	}
+
 	/* ram type */
 	tmp =3D INREG(MEM_SDRAM_MODE_REG);
 	switch ((MEM_CFG_TYPE & tmp) >> 30) {
@@ -947,7 +954,7 @@
 		}
 	}
=20
-	rinfo->fb_base =3D (u32) ioremap (rinfo->fb_base_phys,
+	rinfo->fb_base =3D ioremap (rinfo->fb_base_phys,
 				  		  rinfo->video_ram);
 	if (!rinfo->fb_base) {
 		printk ("radeonfb: cannot map FB\n");

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9vm8kUaz2rXW+gJcRAhqYAKCIqhhbFYpei27+1uqibSO6KJ2BeACdG/rY
X9LpwWtJJRA68C5bwnAWrwM=
=5JWH
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
