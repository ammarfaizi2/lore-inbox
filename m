Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTJOX0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTJOX0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:26:39 -0400
Received: from tog-wakko4.prognet.com ([207.188.29.244]:42114 "EHLO virago")
	by vger.kernel.org with ESMTP id S262621AbTJOX00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:26:26 -0400
Date: Wed, 15 Oct 2003 16:25:53 -0700
From: Tom Marshall <tmarshall@real.com>
To: George Anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: missed itimer signals in 2.6
Message-ID: <20031015232553.GB4034@real.com>
References: <20031013163411.37423e4e.akpm@osdl.org> <3F8C8692.5010108@mvista.com> <20031014235213.GC860@real.com> <3F8D63AA.9000509@mvista.com> <20031015165016.GA2167@real.com> <3F8DCF73.3000707@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <3F8DCF73.3000707@mvista.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >I expect there are at least a few applications that will misbehave becau=
se
> >the developers did not expect a timer to behave this way (regardless of
> >whether it's proper according to the spec).
> >
> >Is it possible to choose a timer resolution that errs on the high side of
> >1ms instead of the low side? [*]  It seems to me that would result in the
> >application getting very close to the expected number of alarm signals. =
 I
> >am not at all familiar with the kernel design so I don't know if this wo=
uld
> >be feasible or not.
> >
> >[*] If this is the 8254 timer, using 1192 as a divisor should result in a
> >resolution of ~1,000,686 nanoseconds.
>=20
> Well here is the rub.  Your high side give an error of 686 PPM while the=
=20
> low side has an error of only 152 PPM.  This assumes, of course, that you=
=20
> are trying to hit exactly 1,000,000 nano seconds per tick.
>=20
> On the other hand, since we do correct for this error, I suspect one coul=
d=20
> use the high side number.

It doesn't really matter to me, as an application developer, what the actual
numbers are.  What matters is that when I ask for a timer in the 1..50ms
range, I get a reasonably close number of SIGALRMs to what I requested.=20
Having to adjust the resolution by 9% at 10ms when I know the system clock
is ticking at 10x that rate seems to be a bit broken from that perspective
(not technically, but perceptually).

> Still, if an application depends on the count rather than just reading th=
e=20
> clock, I suspect that some would consider it broken.  Timer signals can b=
e=20
> delayed and may, in fact overrun with out notice (unlike POSIX timers whi=
ch=20
> tell you when they overrun).

Our code does not depend solely on the delivery of SIGALRM.  It resyncs
periodically using gettimeofday().

> What you really need is a higher resolution timer.  Funny, there seems to=
=20
> be a reference to such a thing in my signature :)

I have rewritten our timer code to take the information learned in this
thread into account.  It turns out that at least one other *nix platform has
problems with the magical 10ms number and, unlike the 2.6 kernel, does not
seem to fill in the actual interval for getitimer().

Thanks again for taking the time to explain the timer system to me.

--=20
Never argue with an idiot.  They drag you down to their level, then beat you
with experience.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jdeBqznSmcYu2m8RAhwfAJ469EdlhKw9Wa2Y18yb8951PC7eFwCgjoyA
Bn8A7y+HJ/Tx3Vm+zKjRuRI=
=C7vf
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
