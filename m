Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSGKUf7>; Thu, 11 Jul 2002 16:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317896AbSGKUf6>; Thu, 11 Jul 2002 16:35:58 -0400
Received: from ua150d35hel.dial.kolumbus.fi ([62.248.233.150]:47794 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S315856AbSGKUf5>; Thu, 11 Jul 2002 16:35:57 -0400
Subject: Re: [CRASH] in tulip driver?
From: Jussi Laako <jussi.laako@kolumbus.fi>
To: Andrew Morton <akpm@zip.com.au>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
In-Reply-To: <3D2CFCE0.3452F960@zip.com.au>
References: <3D2C92C0.658B954@kolumbus.fi> from "Jussi Laako" at Jul 11, 2
	00:15:01 am <200207110259.GAA27698@sex.inr.ac.ru> 
	<3D2CFCE0.3452F960@zip.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-EI0Z++fLqaK3Yv51XLqC"
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Jul 2002 23:38:39 +0300
Message-Id: <1026419920.1859.7.camel@vaarlahti.uworld>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EI0Z++fLqaK3Yv51XLqC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-07-11 at 06:34, Andrew Morton wrote:
>
> whoops.  I think the "-ll" means low-latency.  But the only
> finger I have in that pie is:
>=20
> --- 2.4.19-pre6/drivers/char/random.c~low-latency       Fri Apr  5 12:11:=
17 2002
> +++ 2.4.19-pre6-akpm/drivers/char/random.c      Fri Apr  5 12:11:17 2002
> @@ -1369,6 +1369,11 @@ static ssize_t extract_entropy(struct en
>                 buf +=3D i;
>                 ret +=3D i;
>                 add_timer_randomness(&extract_timer_state, nbytes);
> +#if LOWLATENCY_NEEDED
> +               /* This can happen in softirq's, but that's what we want =
*/
> +               if (conditional_schedule_needed())
> +                       break;
> +#endif
>         }
> =20
>         /* Wipe data just returned from memory */
>=20
> So it's a bit of a mystery.  It seems to think that it has
> EXTRACT_ENTROPY_USER.

Whoops, thanks, I found the bug. My fault...

That "break;" breaks some (apparently broken) programs that don't expect
read of /dev/urandom to return early. For security resons (to get
identical behaviour compared to the original kernel) I made a fix that
someone proposed. That fix is apparently broken on some rare situations
which seem to be difficult to trigger (requires high overall irq rates
with network load). Now I'm going to remove that part completely and see
what happens next...


	- Jussi Laako


--=-EI0Z++fLqaK3Yv51XLqC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9LezPS3txJU4L5RQRAm6+AKDLY9H3SlWu0XEipaiV1zO+9eElUACgkdK3
fLckCdFYM7qMBSOiBjNU6to=
=v/sf
-----END PGP SIGNATURE-----

--=-EI0Z++fLqaK3Yv51XLqC--

