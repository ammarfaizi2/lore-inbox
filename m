Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWH3Vom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWH3Vom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWH3Vom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:44:42 -0400
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146]:59609 "EHLO
	pan.var.cx") by vger.kernel.org with ESMTP id S932131AbWH3Vol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:44:41 -0400
Date: Wed, 30 Aug 2006 23:44:41 +0200
From: Frank v Waveren <fvw@var.cx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-ID: <20060830214441.GA21353@var.cx>
References: <1156927468.29250.113.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1156927468.29250.113.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2006 at 10:44:28AM +0200, Thomas Gleixner wrote:
> Frank v. Waveren pointed out that on 64bit machines the timespec to
> ktime_t conversion might overflow. This is also true for timeval to
> ktime_t conversions. This breaks a "sleep inf" on 64bit machines.
=2E..
> Check the seconds argument to the conversion and limit it to the maximum
> time which can be represented by ktime_t.

It's a solution, and it more or less fixes things without any changes
to userspace, which is nice. I still prefer my patch in
<20060827083438.GA6931@var.cx> though, possibly with modifications so
it doesn't affect all timespec users but only nanosleep (we'd have to
check if the other timespec users aren't converting to ktime_t).=20

With this patch, we sleep shorter than specified, and don't signal
this in any way. Returning EINVAL for anything except negative tv_sec
or invalid tv_nsec breaks the spec too, but I prefer errors to
silently sleeping too short.

I'll grant this is more of an aesthetic point than something that'll
cause real-world problems (300 years is a long time for any sleep),
but if things break I like them to do so as loudly as possible, as a
general rule.

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFE9gbJ+gB9UUaNYsgRAu90AJ9+Ub8u5q2TCk15hlzlS18YDND7MgCeIzEY
xIbEWWhuAqF9dRD6miqpfqw=
=IKSW
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
