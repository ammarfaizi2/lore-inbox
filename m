Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265616AbTIEQK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbTIEQK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:10:59 -0400
Received: from [195.135.220.2] ([195.135.220.2]:18145 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265616AbTIEQKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:10:42 -0400
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       rth@redhat.com, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
References: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org>
	<ho65k76z9v.fsf@byrd.suse.de>
	<1062778587.8510.10.camel@boobies.awol.org>
From: Andreas Jaeger <aj@suse.de>
Date: Fri, 05 Sep 2003 18:10:17 +0200
In-Reply-To: <1062778587.8510.10.camel@boobies.awol.org> (Robert Love's
 message of "Fri, 05 Sep 2003 12:16:27 -0400")
Message-ID: <u8d6efmd1y.fsf@gromit.moeb>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Robert Love <rml@tech9.net> writes:

> On Fri, 2003-09-05 at 11:17, Andreas Jaeger wrote:
>
>
>> Since unit-at-a-time has better inlining heuristics the better way is
>> to add the used attribute - but that takes some time.  The short-term
>> solution would be to add the compiler flag,
>
> Won't we get a linker error if a static symbol is used but
> optimized-away?  It shouldn't be hard to fix the n linker errors that
> crop up.

Yes, we would get a linker error.

> And why are we using static symbols in inline assembly outside of the
> compilation scope?

Don't know.

> Anyhow, if it generates an error, this isn't hard to fix.

Just lots of places...

> Here is the start...
>
> 	Robert Love
>
>
> --- linux-rml/include/linux/compiler.h	Fri Sep  5 11:57:56 2003
> +++ linux/include/linux/compiler.h	Fri Sep  5 12:02:02 2003
> @@ -74,6 +74,19 @@
>  #define __attribute_pure__	/* unimplemented */
>  #endif
>=20=20
> +/*
> + * As of gcc 3.2, we can mark a function as 'used' and gcc will assume t=
hat,
> + * even if it does not find a reference to it in any compilation unit.  =
We
> + * need this for gcc 3.4 and beyond, which can optimize on a program-wide
> + * scope, and not just one file at a time, to avoid static symbols being
> + * discarded.
> + */
> +#if (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ > 1) || __GNUC__ > 3
> +#define __attribute_used__	__attribute__((used))
> +#else
> +#define __attribute_used__	/* unimplemented */

In glibc we have for the else case:
# define __attribute_used__ __attribute__ ((__unused__))

This might reduce warnings about unused functions.  But this change is
not critical IMO, so your patch looks fine!

> +#endif
> +
>  /* This macro obfuscates arithmetic on a variable address so that gcc
>     shouldn't recognize the original var, and make assumptions about it */
>  #define RELOC_HIDE(ptr, off)					\

Andreas
=2D-=20
 Andreas Jaeger, aj@suse.de, http://www.suse.de/~aj
  SuSE Linux AG, Deutschherrnstr. 15-19, 90429 N=FCrnberg, Germany
   GPG fingerprint =3D 93A3 365E CE47 B889 DF7F  FED1 389A 563C C272 A126

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA/WLVrOJpWPMJyoSYRArsyAJ9SgcNy0ntBjbst2ydpqFvOgE2S+wCfaL2w
D8wEGfJXO9Bl8u0CphAvN2g=
=pjOE
-----END PGP SIGNATURE-----
--=-=-=--
