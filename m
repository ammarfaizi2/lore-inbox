Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315030AbSDWCma>; Mon, 22 Apr 2002 22:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315032AbSDWCm3>; Mon, 22 Apr 2002 22:42:29 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:21520 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S315030AbSDWCm0>; Mon, 22 Apr 2002 22:42:26 -0400
Date: Mon, 22 Apr 2002 19:42:15 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module()
Message-ID: <20020422194214.D24927@one-eyed-alien.net>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020422175858.C24927@one-eyed-alien.net> <Pine.GSO.4.21.0204222101370.5686-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The question then becomes one of how do I distinguish a race condition from
a legitimate load/unload cycle?

I'm not certain that I see a way.  Unless we mark modules as "not used
yet", until the first piece of code in them is used.  But that feels like
an ugly hack, and seems likely to be problematic for some unusual
scenarios.

It looks like we might need another state for modules to be in.  Or simply
discourage people from auto-unloading "unused" modules.

I've seen this on usb-storage also, where the module count is maintained by
the SCSI layers -- it's only non-zero when someone/something is actively
using a device, which means that it will tend to get unloaded by an rmmod
-a if we're between CD burns, for example.  And, when the module is
unloaded, all sorts of state information is lost.  rmmod -a is my enemy in
this case.

Isn't the problem here just the misuse of rmmod -a?  Perhaps we should
attach a warning to the documentation to indicate the possible badness that
can happen.

Matt

On Mon, Apr 22, 2002 at 09:05:56PM -0400, Alexander Viro wrote:
>=20
>=20
> On Mon, 22 Apr 2002, Matthew Dharm wrote:
>=20
> > Isn't the real problem here that we've got a "rogue" running around
> > removing things that we might be about to use?
> >=20
> > Yes, I think that request_module() should indicate to the caller if
> > something "suitable" was found.  But I think having rmmod -a running ar=
ound
> > sweeping things randomly is bad.
> >=20
> > Perhaps what we need is a way to tell _how_long_ago_ the count on a mod=
ule
> > last changed.  Thus, rmmod -a could decide to only remove modules that =
were
> > last used more than an hour ago, or somesuch.  Push the policy question=
 into
> > userspace.
>=20
> Still doesn't solve the problem.  And BTW, there are userland races of
> similar kind - foo.o depends on bar.o, modprobe loads bar.o, goes to look
> for foo.o and gets bar.o removed from under it.
>=20
> The thing being, relying on time doesn't help - e.g. we might have modules
> on automounted volume and delays may be really long if the thing happens
> at time when load is high.

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'm just trying to think of a way to say "up yours" without getting fired.
					-- Stef
User Friendly, 10/8/1998

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8xMoGz64nssGU+ykRAsCtAKCL+k5puWaSte5BBdnOwC/lTVKOxQCgiMNs
rQlHIkhbPJ0pdHIWdSx/vuc=
=5+E4
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
