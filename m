Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314995AbSDWA7Q>; Mon, 22 Apr 2002 20:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314996AbSDWA7P>; Mon, 22 Apr 2002 20:59:15 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:55311 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S314995AbSDWA7M>; Mon, 22 Apr 2002 20:59:12 -0400
Date: Mon, 22 Apr 2002 17:58:59 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module()
Message-ID: <20020422175858.C24927@one-eyed-alien.net>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0204222027360.5686-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Isn't the real problem here that we've got a "rogue" running around
removing things that we might be about to use?

Yes, I think that request_module() should indicate to the caller if
something "suitable" was found.  But I think having rmmod -a running around
sweeping things randomly is bad.

Perhaps what we need is a way to tell _how_long_ago_ the count on a module
last changed.  Thus, rmmod -a could decide to only remove modules that were
last used more than an hour ago, or somesuch.  Push the policy question into
userspace.

Matt

On Mon, Apr 22, 2002 at 08:49:40PM -0400, Alexander Viro wrote:
> 	Looks like request_module() has quite a few problems:
>=20
> * there is no way to distinguish between failing modprobe and successful
>   one followed by rmmod -a (e.g. called by cron).  For one thing, we
>   don't pass exit value of modprobe to caller of request_module().
>=20
> * even if we would pass it, obvious attempt to cope with rmmod -a races
>   fails.  I.e. something like
>=20
> 	while (object doesn't exist) {
> 		if (request_module(module_name) < 0)
> 			break;
> 	}
>=20
>   would screw up for something like
>=20
> mount -t floppy <whatever>
>=20
>   since we would happily load floppy.o and look for fs type called "flopp=
y".
>   And keep doing that forever, since floppy.o doesn't define any fs.
>=20
> * we could try to protect against rmmod -a by changing semantics of module
>   syscalls and modprobe(8).  Namely, let modprobe called by request_modul=
e()
>   pin the module(s) down and make request_module() (actually its caller)
>   decrement refcounts.  That would solve the problem, but we get another =
one:
>   how to find all modules pulled in by modprobe(8) and its children.
>   Notice that argument of request_module() doesn't help at all - it can h=
ave
>   nothing to name of module we load (block-major-2 -> floppy) and we coul=
d have
>   other modules grabbed by the same modprobe.
>=20
> * we might try to pull the following trick: in sys_create_module() follow
>   ->parent until we step on request_module()-spawned task.  Then put the =
new
>   module on a list for that instance of request_module().  That would sol=
ve
>   the problem, but I'm not too happy about such solution - IMO it's ugly.
>   However, I don't see anything else...
>=20
> Comments?
>=20
>  =20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

YOU SEE!!?? It's like being born with only one nipple!
					-- Erwin
User Friendly, 10/19/1998

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8xLHSz64nssGU+ykRArofAKDeEmmYvfCeLYTJ2JWfC8h5t9aMLgCcCOjx
Rjc4Vrj1hAIJb8SB2bLRRvY=
=nH2c
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
