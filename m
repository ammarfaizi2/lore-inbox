Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUHMC2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUHMC2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 22:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268951AbUHMC2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 22:28:08 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:60081 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S268950AbUHMC2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 22:28:02 -0400
Date: Thu, 12 Aug 2004 20:27:59 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Possible dcache BUG
Message-ID: <20040813022759.GN18216@schnapps.adilger.int>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040808113930.24ae0273.akpm@osdl.org> <200408100012.08945.gene.heskett@verizon.net> <200408102342.12792.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org> <20040810211849.0d556af4@laptop.delusion.de> <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org> <20040812180033.62b389db@laptop.delusion.de> <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uWPcrH1o85ekjD8l"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uWPcrH1o85ekjD8l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 12, 2004  18:31 -0700, Linus Torvalds wrote:
> Can you figure out what triggers it for you? If nothing obvious comes to=
=20
> mind, could you do something really silly like this
>=20
> 	--- 1.141/mm/slab.c     2004-07-11 01:52:48 -07:00
> 	+++ edited/mm/slab.c    2004-08-12 18:30:00 -07:00
> 	@@ -2360,6 +2360,11 @@
> 	                 */
> 	                BUG_ON(csizep->cs_cachep =3D=3D NULL);
> 	 #endif
> 	+               if (csizep->cs_size =3D=3D 64) {
> 	+                       static unsigned count;
> 	+                       if (!(4095 & ++count))
> 	+                               dump_stack();
> 	+               }
> 	                return __cache_alloc(flags & GFP_DMA ?
> 	                         csizep->cs_dmacachep : csizep->cs_cachep, flags=
);
> 	        }

I don't know who suggested it first, but someone on l-k had a similar
problem and a more robust method of finding the offender was to dump_stack()
when the slab was grown instead of for each allocation.  That way you
don't see frequent but harmless allocators that don't leak, but rather the
process that is causing the slab to be grown repeatedly.

So putting something like the above in cache_alloc_refill() is probably
the right thing.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--uWPcrH1o85ekjD8l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBHCcvpIg59Q01vtYRAgDOAKCRLsvgm6/hGHpZoVoWF4znT9zHXwCeKS2J
ORWFj/lMdOkfJFl34inI61g=
=MeIM
-----END PGP SIGNATURE-----

--uWPcrH1o85ekjD8l--
