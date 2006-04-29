Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWD2CDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWD2CDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 22:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWD2CDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 22:03:15 -0400
Received: from ozlabs.org ([203.10.76.45]:59605 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751469AbWD2CDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 22:03:15 -0400
Subject: Re: [PATCH 1/3] powerpc: Make rtas console _much_ faster
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Ryan Arnold <rsa@us.ibm.com>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200604290245.57507.arnd@arndb.de>
References: <20060429004019.126937000@localhost.localdomain>
	 <200604290245.57507.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Wjcki+kFBXd9yGX5NeKB"
Date: Sat, 29 Apr 2006 11:56:57 +1000
Message-Id: <1146275817.14733.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wjcki+kFBXd9yGX5NeKB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'll clean this one up a little before merging it as per Ryan's email of
a week or two ago. New patch today or tomorrow.

Even though this is 1/3 the rest of the series should be fine to merge,
right Arnd?

cheers

On Sat, 2006-04-29 at 02:45 +0200, Arnd Bergmann wrote:
> Currently the hvc_rtas driver is painfully slow to use. Our "benchmark" i=
s
> ls -R /etc, which spits out about 27866 characters. The theoretical maxim=
um
> speed would be about 2.2 seconds, the current code takes ~50 seconds.
>=20
> The core of the problem is that sometimes when the tty layer asks us to p=
ush
> characters the firmware isn't able to handle some or all of them, and so
> returns an error. The current code sees this and just returns to the tty =
code
> with the buffer half sent.
>=20
> There's the khvcd thread which will eventually wake up and try to push mo=
re
> characters, that will usually work because the firmware's had time to pus=
h
> the characters out. But the thread only wakes up every 10 milliseconds, w=
hich
> isn't fast enough.
>=20
> There's already code in the hvc_console driver to make the khvcd thread d=
o
> a "quick" loop, where it just calls yield() instead of sleeping. The only=
 code
> that triggered that behaviour was recently removed though, which I don't
> quite understand.
>=20
> Still, if we set HVC_POLL_QUICK whenever the push hvc_push() doesn't push=
 all
> characters (ie. RTAS blocks), we can get good performance out of the hvc_=
rtas
> backend. With this patch the "benchmark" takes ~2.8 seconds.
>=20
> Cc: Ryan Arnold <rsa@us.ibm.com>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
>=20
> ---
>=20
>  drivers/char/hvc_console.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linus-2.6/drivers/char/hvc_console.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linus-2.6.orig/drivers/char/hvc_console.c
> +++ linus-2.6/drivers/char/hvc_console.c
> @@ -570,7 +570,7 @@ static int hvc_poll(struct hvc_struct *h
>  		hvc_push(hp);
>  	/* Reschedule us if still some write pending */
>  	if (hp->n_outbuf > 0)
> -		poll_mask |=3D HVC_POLL_WRITE;
> +		poll_mask |=3D HVC_POLL_WRITE | HVC_POLL_QUICK;
> =20
>  	/* No tty attached, just skip */
>  	tty =3D hp->tty;
>=20
> --
--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Wjcki+kFBXd9yGX5NeKB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEUsfodSjSd0sB4dIRAu44AJ9IvqVQ7yr80ifObCySAID1TprrMwCgnZkp
ln8rPHvHMiDp5rRxiKRne8c=
=cmwQ
-----END PGP SIGNATURE-----

--=-Wjcki+kFBXd9yGX5NeKB--

