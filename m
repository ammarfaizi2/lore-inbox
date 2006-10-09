Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWJIG16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWJIG16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 02:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWJIG15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 02:27:57 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:29361 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S932259AbWJIG15
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 02:27:57 -0400
Message-ID: <4529EBEA.4070602@web.de>
Date: Mon, 09 Oct 2006 08:27:54 +0200
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x: i386/x86_64 bitops clobberings
References: <452970AF.8020605@web.de> <20061008224440.GA30172@1wt.eu> <45298184.1050006@web.de> <20061008233617.GA30255@1wt.eu>
In-Reply-To: <20061008233617.GA30255@1wt.eu>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAD7129A824F2351567CC00EC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD7129A824F2351567CC00EC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Willy Tarreau wrote:
> I've done it too, but unfortunately, I discovered that it does not buil=
d
> with gcc-2.95 anymore, while 3.3 is fine :
>=20
> cyclades.c: In function `cyy_interrupt':
> /usr/src/git/linux-2.4/include/asm/bitops.h:130: inconsistent operand c=
onstraints in an `asm'
> cyclades.c: In function `cyz_handle_rx':
> /usr/src/git/linux-2.4/include/asm/bitops.h:130: inconsistent operand c=
onstraints in an `asm'
>=20
> 127        __asm__ __volatile__( LOCK_PREFIX
> 128                "btsl %2,%1\n\tsbbl %0,%0"
> 129                :"=3Dr" (oldbit),"+m" (ADDR)
> 130                :"Ir" (nr) : "memory");
>=20
>=20
> I don't know what the right solution should be. I'm not fond of #ifdefs=
,
> and I'm embarrassed to know that gcc can do all sorts of nasty things d=
ue
> to a wrong clobbering :-/
>=20
> If you have any idea on the subject, I'm willing to try.

What about

#if __GNUC__ < 3
#define ADDR_DEPS "=3Dm"
#else
#define ADDR_DEPS "+m"
#endif

	__asm__ __volatile__( LOCK_PREFIX
		"btsl %2,%1\n\tsbbl %0,%0"
		:"=3Dr" (oldbit),ADDR_DEPS (ADDR)
		:"Ir" (nr) : "memory");

or something similar? Would keep the number of #ifs low.

Jan


--------------enigAD7129A824F2351567CC00EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKevrniDOoMHTA+kRAoVNAJ4tFBlGGts8ulbB1y0Wkxi7k8TfAwCfZIsA
TA4BKJmYbhLgMxsBDEpVJwo=
=O6zK
-----END PGP SIGNATURE-----

--------------enigAD7129A824F2351567CC00EC--
