Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291124AbSBLPia>; Tue, 12 Feb 2002 10:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291132AbSBLPiL>; Tue, 12 Feb 2002 10:38:11 -0500
Received: from mx02.qsc.de ([213.148.130.14]:28870 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id <S291124AbSBLPiA>;
	Tue, 12 Feb 2002 10:38:00 -0500
Subject: Re: pci_pool reap?
From: Daniel Stodden <stodden@in.tum.de>
To: "David S. Miller" <davem@redhat.com>
Cc: groudier@free.fr, alan@lxorguk.ukuu.org.uk, zaitcev@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020211.184412.35663889.davem@redhat.com>
In-Reply-To: <E16a6sw-0005Jw-00@the-village.bc.nu>
	<20020210211352.Q1910-100000@gerard> 
	<20020211.184412.35663889.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-hG7i5kykPNDPzyD99zgH"
X-Mailer: Evolution/1.0.2 
Date: 12 Feb 2002 16:36:34 +0100
Message-Id: <1013528224.2240.245.camel@bitch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hG7i5kykPNDPzyD99zgH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi.
=20
On Tue, 2002-02-12 at 03:44, David S. Miller wrote:
>    From: G=E9rard Roudier <groudier@free.fr>
>    Date: Sun, 10 Feb 2002 21:20:05 +0100 (CET)
>=20
>    On Mon, 11 Feb 2002, Alan Cox wrote:
>   =20
>    > This function may not be called in interrupt context.
>   =20
>    Such limitation looks poor implementation to me.
>=20
> I agree with you Gerard, and probably nobody truly even requires
> this limitation.  I do plan to remove it after I've done a thorough
> investigation of the platform implementations.

ok, i've looked through most of 2.5.4 now.
results look like this:

			pci_alloc_consistent()	pci_free_consistent()
i386:
		[1]	ok			ok

ppc:
		[1]	ok			ok

mips:
		[1]	ok			ok

sh:
		[1]	ok			ok
  stm:		[1]	ok			ok
  dc:		[3]	ok			ok

mips64:
  ip32:		[1]	ok			ok
  ip27:		[1]	ok			ok

sparc:
		[1]	GFP_KERNEL		ok
sparc64:
		[2]	ok			ok

arm:		[4]	BUG()/GFP_KERNEL	BUG()

alpha:
		[2]	ok			ok

ia64:		[5]	ok?			ok?

	=09
[1]
gfp() + __pa() (or similar)

[2]
gfp() + IOMMU

[3]
dummy, offsets only

[4]    =20
ARM does GFP_KERNEL, and then __ioremaps the underlying pages.
ugh. is that the only way to get the area coherent?
furthermore i don't see why this could not be interrupt safe.

[5]
i don't understand ia64. but it looks somewhat atomic :)

well, assuming i didn't oversee anything, there are indeed few reasons
left why the whole _consistent() machinery shouldn't be callable from
interrupts.=20

back to my original question: what were the last trees with shrinking
pools? would the original version still work or any redesigns needed?


regards,
dns

--=20
___________________________________________________________________________
 mailto:stodden@in.tum.de


--=-hG7i5kykPNDPzyD99zgH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8aTaBSPSplX5M5nQRAgapAJ96NCMvx4iLkdgvMWPWHDmNpljKHgCfQhqM
7fOA6lOkDbkzBK7LfZZXP/s=
=VKiF
-----END PGP SIGNATURE-----

--=-hG7i5kykPNDPzyD99zgH--

