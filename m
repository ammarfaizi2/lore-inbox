Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268248AbTCCBx5>; Sun, 2 Mar 2003 20:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268255AbTCCBx5>; Sun, 2 Mar 2003 20:53:57 -0500
Received: from mail.tbdnetworks.com ([63.209.25.99]:8320 "EHLO tbdnetworks.com")
	by vger.kernel.org with ESMTP id <S268248AbTCCBxy>;
	Sun, 2 Mar 2003 20:53:54 -0500
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E6247F7.8060301@redhat.com>
References: <20030302121425.GA27040@defiant>  <3E6247F7.8060301@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SGDbtsmio+jKspo9pOz4"
Organization: 
Message-Id: <1046656929.16780.13.camel@voyager.tbdnetworks.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Mar 2003 18:03:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SGDbtsmio+jKspo9pOz4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
yes I agree that the code will be slightly less efficient in this case
(though looking a bit around, there are way more places which could be
optimized, e.g. the useless "&& !acm->throttle" in the next line).=20
What's IMHO more important is that the original code was producing the
correct result, so the patch for acm.c is not really necessary.  This is
also true for the patches for gus_midi.c, gus-wave.c, and i2c-proc.c.

OTOH, I still think that in most (all?) of this cases the bit-op was not
intended.

Anyway, I'll wait another day or two to collect replies from the
maintainers and then resend the remaining patches where the code really
produces wrong results.

so long
	Norbert

On Sun, 2003-03-02 at 10:05, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Norbert Kiesel wrote:
>=20
> > --- linux-2.4.20/drivers/usb/acm.c~	2002-12-03 00:17:50.000000000 -0800
> > +++ linux-2.4.20/drivers/usb/acm.c	2003-03-02 03:03:34.000000000 -0800
> > @@ -240,7 +240,7 @@
> >  	if (urb->status)
> >  		dbg("nonzero read bulk status received: %d", urb->status);
> > =20
> > -	if (!urb->status & !acm->throttle)  {
> > +	if (!urb->status && !acm->throttle)  {
> >  		for (i =3D 0; i < urb->actual_length && !acm->throttle; i++) {
> >  			/* if we insert more than TTY_FLIPBUF_SIZE characters,
> >  			 * we drop them. */
>=20
> Have you really looked at detail at all these cases?  The problem is
> that you have made the code less efficient on some platforms.  The use
> of && requires shortcut evaluation.  I.e., the compiler is forced to not
> evaluate !acm->throttle if !urb->status is true.  The causes, unless the
> architecture has condition bits, a conditional jump.
>=20
> The original code didn't need and normally has no jump and thi specific
> case was certainly fine before since the result of the ! operator is
> either 0 or 1 and therefore the & operator has no strange side effects.
>=20
> As an example, here is how the code for x86 could have looked before
>=20
>    movl   status(%edx), %edx
>    testl  %edx, %edx
>    movl   throttle(%eax), %eax
>    sete   %dl
>    testl  %eax, %eax
>    sete   %al
>    andb   %dl, %al
>    jne    ...
>    [if code]
>=20
> After the change the code must look something like this:
>=20
>    movl   status(%edx), %edx
>    testl  %edx, %edx
>    jne    ...
>    movl   throttle(%eax), %eax
>    testl  %eax, %eax
>    jne    ...
>    [if code]
>=20
>=20
> Observe the extra 'jne' and the fact that the value of 'throttle'
> element cannot be loaded until after the conditional jump.   Not even
> out of order execution can arrange that.
>=20
>=20
> To summarize, I'd probably not be amused if you would change any of my
> code which takes advantage of such programming finess.  I would probably
> have added appropriate comments to explain the code but nevertheless,
> replacing the more efficient code with some which is easier to
> understand should probably be considered on a case by case basis.
> Incorrect branch prediction is costly.
>=20
> - --=20
> - --------------.                        ,-.            444 Castro Street
> Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
> Red Hat         `--' drepper at redhat.com `---------------------------
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
>=20
> iD8DBQE+Ykf82ijCOnn/RHQRApJaAKCxM4hwu12mJVbQuD3o+t13YVxrsACgsnVH
> RZmgjNB5KP3Qu27iqpf5aiU=3D
> =3Dl7xl
> -----END PGP SIGNATURE-----
--=20
Norbert Kiesel <nkiesel@tbdnetworks.com>

--=-SGDbtsmio+jKspo9pOz4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+YregOIJDAvi0wRwRAi6jAJ0VHLqDweLkI7FIxFDBjuGSMHMmdwCgnImh
kUH9tHQgCv5lzULyx7kr8gQ=
=bQuw
-----END PGP SIGNATURE-----

--=-SGDbtsmio+jKspo9pOz4--

