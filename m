Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVIBUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVIBUSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVIBUSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:18:14 -0400
Received: from smtp06.web.de ([217.72.192.224]:41958 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S1751320AbVIBUSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:18:13 -0400
From: Thomas Schlichter <thomas.schlichter@web.de>
To: vatsa@in.ibm.com
Subject: Re: [PATCH 2/3] dyntick - Fix lost tick calculation in timer pm.c
Date: Fri, 2 Sep 2005 22:18:01 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       john stultz <johnstul@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509030145.18368.kernel@kolivas.org> <20050902172504.GB4650@in.ibm.com>
In-Reply-To: <20050902172504.GB4650@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_8NLGD1fRzh4wz21";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509022218.04796.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_8NLGD1fRzh4wz21
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi Srivatsa,

thank you for improving your patch by fixing the two problems. Now I do hav=
e=20
just two minor nits which you may consider:

1. You don't need to hold the monotonic_lock that long, it is only necessar=
y=20
when updating offset_last and monotonic_base. So I would propose something=
=20
like this:

  offset_now =3D read_pmtmr();

  /* calculate tick interval */
  delta =3D (offset_now - offset_last) & ACPI_PM_MASK;

  /* convert to ticks */
  lost =3D delta / pm_ticks_per_jiffy;

  /* convert ticks to usecs */
  deltaus =3D cyc2us(lost * pm_ticks_per_jiffy);
  // can we use this instead: ?
  // deltaus =3D jiffies_to_usecs(lost);

  write_seqlock(&monotonic_lock);
  offset_last +=3D lost * pm_ticks_per_jiffy;
  offset_last &=3D ACPI_PM_MASK;

  /* update the monotonic base value */
  monotonic_base +=3D deltaus * NSEC_PER_USEC;
  write_sequnlock(&monotonic_lock);

2. Can we really assure that the monotonic clock is still monotonic?
I think with your new code we estimate the monotonic clock value and the=20
offset_last at the last tick.
But if we underestimate monotonic_base or overestimate offset_last (even=20
simply by rounding errors), the time will make a small step backwards with=
=20
the value-update.
And as far as I understand the monotonic clock its not that bad if it drift=
s a=20
bit, but it is really bad if time makes steps backward...

But maybe you can show me that I am wrong with my second point.
I hope I don't bother you too much with this kind of stuff...

  Thomas

P.S.: I CC'd John because he knows the monotonic clock better than I do... =
:-)

Am Freitag, 2. September 2005 19:25 schrieb Srivatsa Vaddagiri:
> Con,
> 	Pls use this updated "Lost tick" calculation patch, which rectifies the
> two problems Thomas pointed out. I have done some basic test with it.
>
> Would it be possible to incorporate this updated patch in
> http://ck.kolivas.org/patches/dyn-ticks/2.6.13-mm1-dtck1.patch?
>
> Sorry for the inconvenience!

--Boundary-02=_8NLGD1fRzh4wz21
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBDGLN8YAiN+WRIZzQRAkVMAKDoBToOorMe2SYjFHIPL8YRmHYCdgCfYLnY
Dohx7oLgPGE8o7YpuEMxNGg=
=RPpG
-----END PGP SIGNATURE-----

--Boundary-02=_8NLGD1fRzh4wz21--

