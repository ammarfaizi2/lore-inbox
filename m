Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUK0X14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUK0X14 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUK0X14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:27:56 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:56751 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261362AbUK0X1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:27:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sun, 28 Nov 2004 00:21:50 +0100
User-Agent: KMail/1.6.2
Cc: Sam Ravnborg <sam@ravnborg.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       dwmw2@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <20041127211923.GA21765@mars.ravnborg.org> <41A8F67E.1060908@domdv.de>
In-Reply-To: <41A8F67E.1060908@domdv.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_PwQqBlAnbzie6+9";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411280021.51574.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_PwQqBlAnbzie6+9
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnnavend 27 November 2004 22:49, Andreas Steinmetz wrote:
> Ok, this is not in the kernel, but think of the following: an=20
> application needs and include/asm header. The application may be=20
> compiled as 32 bit and as 64 bit. Then you could use a real asm=20
> directory instead of a symlink and use, e.g. for asm/byteorder.h:
>=20
> #ifdef __x86_64__
> #include <asm-x86_64/byteorder.h>
> #else
> #include <asm-i386/byteorder.h>
> #endif
>=20

I think we can get rid of this hack when we move to split kernel headers.
parisc, s390 and mips already have combined headers, and it should not be
too hard to combine the user ABI headers for sparc, ppc and x86_64 as well,
without having to merge the complete architecture and kernel header trees
for them.

Building for ppc64 would then use something like 'gcc -Iinclude
=2DIinclude/ppc64 -Iinclude/user -Iinclude/user/ppc/' for a layout
that has files in

include/linux/foo.h
include/$arch/asm/foo.h
include/generic/asm/foo.h
include/user/linux/foo.h           (installed as <linux/foo.h>)
include/user/$arch32/asm/foo.h     (installed as <asm/foo.h>
include/user/asm-generic/foo.h     (installed as <asm-generic/foo.h>

[Note how the first three become optional in this scheme. For files
 that need an internal version an a user version, ppc64/asm/foo.h
 can use #include_next <asm/foo.h> to get to generic/asm/foo.h and
 user/ppc/asm/foo.h.]

=46or ia64, the headers should probably stay separate because I would expect
them to differ more from i386/x86_64 than the other dual 32/64 architecture=
s.
I don't think that is a problem because you need separate tool chains for
ia64 and i386 anyway, while the others can share the libc headers and the
compiler backend already.

	Arnd <><

--Boundary-02=_PwQqBlAnbzie6+9
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqQwP5t5GS2LDRf4RAr4pAJwIlYsUYjp3Odo0QZDKW6xO5fHCGwCZAQ7h
7XVENjORAOq2/UtMqAmyYAg=
=Y/S+
-----END PGP SIGNATURE-----

--Boundary-02=_PwQqBlAnbzie6+9--
