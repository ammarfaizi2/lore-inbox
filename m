Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277440AbRJOMAt>; Mon, 15 Oct 2001 08:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277472AbRJOMAl>; Mon, 15 Oct 2001 08:00:41 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:39178 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S277440AbRJOMA3>;
	Mon, 15 Oct 2001 08:00:29 -0400
Date: Mon, 15 Oct 2001 16:01:00 +0400
To: linux-kernel@vger.kernel.org
Cc: Thomas Hood <jdthood@mail.com>
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
Message-ID: <20011015160100.A31571@orbita1.ru>
In-Reply-To: <jdthood@mail.com> <1002987648.764.23.camel@thanatos> <200110150637.f9F6bek14014@nova.botz.org> <20011015114556.F4523@come.alcove-fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011015114556.F4523@come.alcove-fr>; from stelian.pop@fr.alcove.com on Mon, Oct 15, 2001 at 11:45:56AM +0200
X-Uptime: 3:22pm  up 3 days,  3:30,  2 users,  load average: 0.15, 0.06, 0.01
X-Uname: Linux orbita1.ru 2.2.20pre2
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: multipart/mixed; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2001 at 11:45:56AM +0200, Stelian Pop wrote:

> On Sun, Oct 14, 2001 at 11:37:39PM -0700, Jurgen Botz wrote:
>=20
> > Thomas Hood wrote:
> > > Okay, here's a new major patch to the PnP BIOS driver
> > > which needs some testing before it's integrated.
> > >[...]=20
> > > Vaio users: Please make sure that this doesn't oops.
> >=20
> > Patched against 2.4.12-ac1, it works and doesn't oops my
> > VAIO PCG-N505VE. =20
>=20
> Same for me (against a 2.4.10-ac12), on a VAIO PCG-C1VE.
>=20
> Relevant (maybe) output:
>=20
> ...
> Sony Vaio laptop detected.
> BIOS strings suggest APM reports battery life in minutes and wrong byte o=
rder.
> PCI: PCI BIOS revision 2.10 entry at 0xfd98e, last bus=3D0
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
> PCI: Found IRQ 9 for device 00:08.0
> PCI: Sharing IRQ 9 with 00:07.2
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f8120.
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb25f, dseg 0x400.
> PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver.
> PnPBIOS: PNP0c02: 0xfff80000-0xffffffff was already reserved
		    ^^^^^^^^^^^^^^^^^^^^^
Looks wrong for me, we are trying to reserve _memory_ range with request_re=
gion().
Patch attached.

> PnPBIOS: PNP0c02: 0xfff7f600-0xfff7ffff was already reserved
> PnPBIOS: PNP0c02: 0x398-0x399 has been reserved
> PnPBIOS: PNP0c02: 0x4d0-0x4d1 has been reserved
> PnPBIOS: PNP0c02: 0x8000-0x804f was already reserved
> PnPBIOS: PNP0c02: 0x1040-0x104f has been reserved
> PnPBIOS: PNP0c01: 0xe8000-0xfffff was already reserved
> PnPBIOS: PNP0c01: 0x100000-0x70ffbff was already reserved
> PnPBIOS: PNP0c02: 0xdc000-0xdffff was already reserved
> PnPBIOS: PNP0c02: 0xd1000-0xd3fff was already reserved
> Linux NET4.0 for Linux 2.4
> ...
>=20
> Stelian.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pnpbios

diff -ur linux.old/drivers/pnp/pnp_bios.c linux/drivers/pnp/pnp_bios.c
--- linux.old/drivers/pnp/pnp_bios.c	Mon Oct 15 15:38:43 2001
+++ linux/drivers/pnp/pnp_bios.c	Mon Oct 15 15:54:56 2001
@@ -1052,8 +1052,8 @@
 	 * example do reserve stuff they know about too, so we may well
 	 * have double reservations.
 	 */
-	printk(
-		"PnPBIOS: %s: 0x%x-0x%x %s reserved\n",
+	printk( 
+		KERN_INFO "PnPBIOS: %s: 0x%x-0x%x %s reserved\n",
 		pnpid, start, end,
 		NULL != res ? "has been" : "was already"
 	);
@@ -1069,6 +1069,9 @@
 		if ( dev->resource[i].flags & IORESOURCE_UNSET )
 			/* resource record not used */
 			break;
+		if (!(dev->resource[i].flags & IORESOURCE_IO))
+			/* memory resource */
+			continue;
 		if ( dev->resource[i].start == 0 )
 			/* resource disabled */
 			continue;

--Fig2xvG2VGoz8o/s--

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ys/8Bm4rlNOo3YgRAloFAJ462AZTMk7uh8fdVqR8gFdI+q9nrQCfen0W
l2syj7vj71kYHH31IIrpssg=
=KS0o
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
