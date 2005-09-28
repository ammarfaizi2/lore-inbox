Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVI1Icz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVI1Icz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVI1Icy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:32:54 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:171 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030213AbVI1Icy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:32:54 -0400
Date: Wed, 28 Sep 2005 10:32:40 +0200
From: Harald Welte <laforge@netfilter.org>
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Andi Kleen <ak@suse.de>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050928083240.GP4168@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Henrik Nordstrom <hno@marasystems.com>, Andi Kleen <ak@suse.de>,
	netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org,
	linux-kernel@vger.kernel.org
References: <432EF0C5.5090908@cosmosbay.com> <200509221503.21650.ak@suse.de> <20050923170911.GN731@sunbeam.de.gnumonks.org> <200509271823.19365.ak@suse.de> <Pine.LNX.4.61.0509280219110.25500@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UeXZ3FjlYZvuln/G"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509280219110.25500@filer.marasystems.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UeXZ3FjlYZvuln/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2005 at 02:25:16AM +0200, Henrik Nordstrom wrote:

> >That could be special cased and done lockless, with the counting
> >done per CPU.
>=20
> It's also not very hard for iptables when verifying the table to
> conclude that there really isn't any "real" rules for a certain hook

The detection should be quite straight-forward, yes.

> Allowing you to have as many ip tables modules you like in the kernel,
> but only using the hooks where you have rules. =20

I totally agree, that from a current perspective, I think the concept of
just loading a module (that has usage count 0) having severe impact on
system performance is just wrong.  But then, users are used to the
current behaviour for almost five years now.  Every decent script and/or
piece of documentation should by now refer to the fact that loading a
module implicitly registers it at the hooks, and that you only load
those modules that you really need.

In an ideal world, you would load iptables, and userspace would
configure a couple of chains, and then explicitly attach those chains to
the netfilter hooks.=20

Therefore: Let's do this right next time, but live with that fact for
now.

> Drawback is that you loose the packet counters on the policy.

That's the big problem.  People rely on that fact, because they're used
to it.  If we introduce some new tool, or something that somehow works
differently, I don't have a change.  But silently changing the semantics
with a kernel upgrade is not something that I'm willing to do on
purpose.

Just imagine all those poor sysadmins who know nothing about current
kernel development, and who upgrade their kernel because their
distributor provides a new one - suddenly their accounting (which might
be relevant for their business) doesn't work anymore :(

> Exception: iptable_nat. Needs the hooks for other purposes as well,
> not just the iptable so here the hooks can not be deactivated when
> there is no rules.

yes, even though we could make the ip_nat / iptable_nat split (that is
introduced in 2.6.14) in a way that would make ip_nat.ko register those
hooks that are implicitly needed, and iptable_nat only the user-visible
chain-related hooks.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--UeXZ3FjlYZvuln/G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDOlUoXaXGVTD0i/8RAuUdAJ458qwjm5c3R90Z3QAekVZisLYdsACghk2V
ep/tZt+J2YKe05rYMMLGsc4=
=k3Qm
-----END PGP SIGNATURE-----

--UeXZ3FjlYZvuln/G--
