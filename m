Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUEDW45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUEDW45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUEDW45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:56:57 -0400
Received: from zlynx.org ([199.45.143.209]:30214 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261528AbUEDW4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:56:51 -0400
Subject: Re: sigaction, fork, malloc, and futex
From: Zan Lynx <zlynx@acm.org>
To: chris@scary.beasts.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405042315001.24297@sphinx.mythic-beasts.com>
References: <200405042015.i44KFb0R001900@emess.mscd.edu>
	 <Pine.LNX.4.58.0405042315001.24297@sphinx.mythic-beasts.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LeZ+qdJeNP6oUZ9/D39G"
Message-Id: <1083711395.29189.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7jb) 
Date: Tue, 04 May 2004 16:56:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LeZ+qdJeNP6oUZ9/D39G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-05-04 at 16:30, chris@scary.beasts.org wrote:
> Hi-
>=20
> On Tue, 4 May 2004, Steve Beaty wrote:
>=20
> >
> > 	anyone have a clue on this one?  we set up a signal handler, create
> > 	a child that sends that signal, and have the signal handler fork
> > 	another child.  if there is a malloc(), the second child gets stuck
> > 	in a futex(); without the malloc(), no problem.  2.4.20-30.9
> > 	kernel.  straces at the end.  any help would be appreciated.
> > 	thanks!
>=20
> Your signal handler function is illegally calling non-reentrant functions=
.
> The *printf() family of functions are going to need to call malloc() to
> allocate buffers. malloc() cannot be re-entered.
>=20
> So specifically your deadlock sequence is:
>=20
> Parent:
> fork()
> fprintf()
> -> malloc()
>    -> take a malloc() lock
> (Child schedules and sends SIGALRM at this point)
> SIGALRM:
> fprintf()
> -> malloc()
>    -> try to take a malloc() lock
>       -> deadlock, lock is already taken and will never be released!
>=20
> Modern glibc / kernel combinations which use futexes in the malloc code
> really seem to expose this race.
>=20
> Cheers
> Chris

No, it's nothing to do with the fprintf.  I tried the program without
any fprints at all and got the same result.

I'm pretty sure the problem is in glibc.  Look at malloc_atfork and
free_atfork in glibc's malloc/arena.c.  I think the reason you are only
seeing it happen when you malloc is that glibc only initializes the
malloc system when you first use it.

I am not sure it is really a problem though.  I don't think you should
be allowed to fork inside a signal handler.  That seems very wrong.
--=20
Zan Lynx <zlynx@acm.org>

--=-LeZ+qdJeNP6oUZ9/D39G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAmB+jG8fHaOLTWwgRAq/0AKCj3rtUWKKjifAsTaWvY4lwUeRQOgCeOQcp
ipsxNgWy9H1EL0QPB6Gu6XY=
=JJih
-----END PGP SIGNATURE-----

--=-LeZ+qdJeNP6oUZ9/D39G--

