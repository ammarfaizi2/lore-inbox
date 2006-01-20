Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWATR2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWATR2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWATR2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:28:18 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:28832 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750962AbWATR2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:28:18 -0500
Date: Fri, 20 Jan 2006 18:28:11 +0100
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: netfilter-devel@lists.netfilter.org, mikpe@user.it.uu.se,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Jiri Slaby <xslaby@fi.muni.cz>
Subject: Re: [PATCH] x_tables: fix alignment on [at least] ppc32
Message-ID: <20060120172811.GO4603@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	netfilter-devel@lists.netfilter.org, mikpe@user.it.uu.se,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <xslaby@fi.muni.cz>
References: <17358.19458.555996.684819@alkaid.it.uu.se> <20060118150158.GL4603@sunbeam.de.gnumonks.org> <20060120004512.GT4603@sunbeam.de.gnumonks.org> <20060119.165635.104653932.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KOBxLkMFRQI9H+bc"
Content-Disposition: inline
In-Reply-To: <20060119.165635.104653932.davem@davemloft.net>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KOBxLkMFRQI9H+bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2006 at 04:56:35PM -0800, David S. Miller wrote:
> > [NETFILTER] x_tables: Fix XT_ALIGN() macro on [at least] ppc32
> > [...]
> > The fix is an ugly kludge, but it has been tested to solve the problem.=
 Yet
> > another reason to move away from the current {ip,ip6,arp,eb}tables like
> > data structures.
> >=20
> > Signed-off-by: Harald Welte <laforge@netfilter.org>
>=20
> Harald, I'm going to modify this to just use u_int64_t as that
> should be totally sufficient.
>
> It is the largest type, and will produce the desired results without
> the silly structure.

Sorry dave, as I just learned, it isn't.   As reported by Jiri Slaby
<xslaby@fi.muni.cz>, Linus' tree now breaks on i386 :(

Interestingly, on i386:

__alignof__(struct _xt_align)	4
__alignof__(u_int64_t)		8
__alignof__(void *)		4

whereas on ppc:

__alignof__(struct _xt_align)	8
__alignof__(u_int64_t)		8
__alignof__(void *)		4

So your assumption that __alignof__(u_int64_t) =3D=3D __alignof__(struct xt=
_align)
doesn't hold true for all archs.

I would therefore recommend applying my unmodified patch, and hope that
it then works on all archs simultaneously.

> Some malloc() implementations use "long double" to figure out the
> largest type size and alignment requirements any C type might have
> on the machine.  But there is no reason to use that here.

Our main problem is that we have to stay compatible with old userspace
programs that had a different definition for what has now become
XT_ALIGN().  So independent what might be the best solution from an
alignment point of view, we must match what old userspace thinks.

Yes, this all sucks.  And yes, we will see a new interface this year.
Promised.

Cheers,
	Harald.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--KOBxLkMFRQI9H+bc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0R2rXaXGVTD0i/8RAmlFAKCvc74CiV6R/7Dz4X+Ak3/eLE0zbQCghxGa
jefK0vhDAk9RS0WIS9dxw8o=
=wKFS
-----END PGP SIGNATURE-----

--KOBxLkMFRQI9H+bc--
