Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTLXL2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 06:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTLXL2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 06:28:16 -0500
Received: from coruscant.franken.de ([193.174.159.226]:5286 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S263564AbTLXL2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 06:28:14 -0500
Date: Wed, 24 Dec 2003 12:10:55 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] fix pci_update_resource() / IORESOURCE_UNSET on PPC
Message-ID: <20031224111054.GB941@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.0-ben1
X-Date: Today is Prickle-Prickle, the 62nd day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

[disclaimer:  This was posted on the linuxppc list before, BenH asked me=20
 to re-post it to lkml]

The prism54 (http://prism54.org) driver for my cardbus adapter works
with 2.4.x, but not 2.6.x on a Titanium G4 Powerbook IV.

On 2.6.x the error message was
PCI:0001:02:00.0 Resource 0 [00000000-00001fff] is unassigned

After investigating differences in the PCI code of 2.4.x and 2.6.x, i
noticed that 2.4.x/arc/ppc/kernel/pci.c:pcibios_update_resource()
contained a couple of lines that unset the IORESOURCE_UNSET bitflag.

In 2.6.x, this is handled by the generic PCI core in
drivers/pci/setup-res.c:pci_update_resource() code.  However, the code
is missing the 'res->flags &=3D ~IORESOURCE_UNSET' part.

The below fix re-adds that section from 2.4.x.=20

I'm not sure wether this belongs into the arch-independent PCI api.
Anyway, on PPC it seems to be needed for certain cardbus devices.

Any comments welcome.

diff -Nru linuxppc25bh-031214-plain/drivers/pci/setup-res.c linuxppc25bh-03=
1214-orinoco_monitor/drivers/pci/setup-res.c
--- linuxppc25bh-031214-plain/drivers/pci/setup-res.c	2003-12-05 02:37:16.0=
00000000 +0100
+++ linuxppc25bh-031214-orinoco_monitor/drivers/pci/setup-res.c	2003-12-15 =
12:08:11.000000000 +0100
@@ -84,6 +84,10 @@
 			       pci_name(dev), resno, new, check);
 		}
 	}
+	res->flags &=3D ~IORESOURCE_UNSET;
+	printk(KERN_INFO "PCI: moved device %s resource %d (%lx) to %x\n",
+		dev->slot_name, resno, res->flags,
+		new & ~PCI_REGION_FLAG_MASK);
 }
=20
 int __init

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6XQ+XaXGVTD0i/8RAv1XAKCSG19r7LQxdmdUrMBUxAG/rM5L3gCfT4JM
bf7Zx4yhtRyKUyMrkKT3SUA=
=eW/c
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
