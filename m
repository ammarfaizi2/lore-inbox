Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVHOHhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVHOHhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVHOHhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:37:48 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:36025 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932154AbVHOHhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:37:47 -0400
Date: Mon, 15 Aug 2005 11:37:14 +0200
From: Harald Welte <laforge@netfilter.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.13-rc5-mm1: BUG: rwlock recursion on CPU#0
Message-ID: <20050815093714.GB4439@rama.de.gnumonks.org>
References: <200508141448.36562.rjw@sisk.pl> <Pine.LNX.4.61.0508141940200.6740@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508141940200.6740@montezuma.fsmlabs.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 14, 2005 at 08:15:53PM -0600, Zwane Mwaikambo wrote:

> Is the following patch correct? ip_conntrack_event_cache should never be=
=20
> called with ip_conntrack_lock held and ct_add_counters does not need to b=
e=20
> called with ip_conntrack_lock held.

No, it's not correct.  ct_add_countes has to be called from within
write_lock_bh() on ip_conntrack_lock.

So if you keep the ct_add_counters() call where it is and only apply the
rest of your patch (i.e. deferring of ip_conntrack_event_cache() call),
then I think your patch would work.

However, the whole eventcache needs to be audited, it's called from a
number of places.

As Patrick wrote he's working on a solution, I'm not going to intervene
or replicate his work.  As a interim solution I'd suggest disabling
CONFIG_IP_NF_CT_ACCT [which can't be vital anyway, since it was only
added in net-2.6.14 (and thus -mm)].

Cheers,
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDAGJJXaXGVTD0i/8RAgAoAKCXgyYsWyIzw6bKK1OnpnlhTAEvcgCgqOeG
B16+kW+DiFqW3wA/tVPX/TA=
=fakC
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
