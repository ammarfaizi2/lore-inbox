Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVIWRJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVIWRJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVIWRJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:09:15 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:30887 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750810AbVIWRJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:09:13 -0400
Date: Fri, 23 Sep 2005 19:09:11 +0200
From: Harald Welte <laforge@netfilter.org>
To: Andi Kleen <ak@suse.de>
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050923170911.GN731@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Andi Kleen <ak@suse.de>, Eric Dumazet <dada1@cosmosbay.com>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
	netdev@vger.kernel.org
References: <432EF0C5.5090908@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331CFA7.50104@cosmosbay.com> <200509221503.21650.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i1d8offQF8oqidLm"
Content-Disposition: inline
In-Reply-To: <200509221503.21650.ak@suse.de>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Thu, Sep 22, 2005 at 03:03:21PM +0200, Andi Kleen
	wrote: > > > 1) No more central rwlock protecting each table (filter,
	nat, mangle, raw), > > but one lock per CPU. It avoids cache line ping
	pongs for each packet. > > Another useful change would be to not take
	the lock when there are no > rules. Currently just loading iptables has
	a large overhead. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 TW_RW                  BODY: Odd Letter Triples with RW
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i1d8offQF8oqidLm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2005 at 03:03:21PM +0200, Andi Kleen wrote:
>=20
> > 1) No more central rwlock protecting each table (filter, nat, mangle, r=
aw),
> >     but one lock per CPU. It avoids cache line ping pongs for each pack=
et.
>=20
> Another useful change would be to not take the lock when there are no
> rules. Currently just loading iptables has a large overhead.

This is partially due to the netfilter hooks that are registered (so we
always take nf_hook_slow() in the NF_HOOK() macro).

The default policies inside an iptables chain are internally implemented
as a rule.  Thus, policies as built-in rules have packet/byte counters.

Therefore, without making a semantic change, we cannot do any of the
following optimizations:

1) not take a lock when the chain is empty
2) not register at the netfilter hook when the chain is empty.

This is well-known, but I don't think we can change the semantics for
the user during a stable kernel series.  That's one point where not
having 2.7.x really hurts.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--i1d8offQF8oqidLm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNDa3XaXGVTD0i/8RAhGYAJ9PMXbW3ukZmMQtTSr8Bszii7OGcQCgidIS
/wV2ladFluSb6uUZ3B+qbHI=
=PSsv
-----END PGP SIGNATURE-----

--i1d8offQF8oqidLm--
