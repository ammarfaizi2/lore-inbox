Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270037AbRHWTer>; Thu, 23 Aug 2001 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270195AbRHWTek>; Thu, 23 Aug 2001 15:34:40 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:14393 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S270194AbRHWTe0>; Thu, 23 Aug 2001 15:34:26 -0400
Date: Thu, 23 Aug 2001 14:34:40 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: "J. Imlay" <jimlay@u.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: macro conflict
Message-ID: <20010823143440.G20693@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	"J. Imlay" <jimlay@u.washington.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.33.0108231150110.64144-100000@dante14.u.washington.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.A41.4.33.0108231150110.64144-100000@dante14.u.washington.edu> from J. Imlay on 08/23/2001 14:03
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There has already been **much** discussion about this, but I think
that the bottom line is that the new version is safer and more
robust than the old version, and thus is not likely to be changed
back.

Consider what happens if someone writes min(++x,y) - the old
version expands to (without some of the extra parens):

	++x < y ? ++x : y

which will increment x twice if the condition ++x < y is true.
There's all kinds of nasty side effects possible with the old
version, including having x > y at the end of the statement, which
definitely violates the semantics of min().

The new version avoids these side effects by only evaluating
the given arguments once (assigning them to temp variables,
which will be optimized away in almost all cases anyway), but
in order to do that, the macro needs to know the variable type,
hence the additional argument. In C++, this can be done using
typename or templates, but the kernel's not written in C++
for a number of very good reasons.

Bottom line, I think the new version of min() and friends is
here to stay and is definitely a positive move. One of the down
sides to that is that a lot of people have a lot of cleaning
up to do.

			tw

On 08/23/2001 12:03 -0700, J. Imlay wrote:
>>	IN getting the AFS kernel modules to compile under linux I dicovered that
>>	the were useing the standard min(x,y) macro that whould evaluate which o=
ne
>>	is smaller. However sometime between 2.4.6 and 2.4.9 a new macro was add=
ed
>>	to linux/kernel.h
>>=09
>>	this one:
>>=09
>>	#define min(type,x,y) \
>>	        ({ type __x =3D (x), __y =3D (y); __x < __y ? __x: __y; })
>>=09
>>	the old one is
>>=09
>>	#define min(x,y) ( (x)<(y)?(x):(y) )
>>=09
>>	has been around a lot longer and is in lots of header files.
>>=09
>>	The problem here with AFS is that it needs the old definition but the old
>>	definition is being over written by the new one... you guys should know
>>	all this. But I am just saying that I really think the new macro
>>	min(type,x,y) should get a new name. like type_min or something.
>>=09
>>	Thanks,
>>=09
>>	Josie Imlay
>>=09
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
twalberg@mindspring.com

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO4VazcPlnI9tqyVmEQK1QQCgjf0bD7/m3eK5wF9DsTC5Y9oMxqkAoON1
igT866zO9VcMj5Sht5qnPDyh
=0WLL
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
