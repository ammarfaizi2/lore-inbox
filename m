Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTLLHGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 02:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTLLHGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 02:06:51 -0500
Received: from coruscant.franken.de ([193.174.159.226]:24272 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S264497AbTLLHGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 02:06:48 -0500
Date: Fri, 12 Dec 2003 08:01:31 +0100
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mukansai@emailplus.org, scott.feldman@intel.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: TSO and netfilter (Re: Extremely slow network with e1000 & ip_conntrack)
Message-ID: <20031212070131.GN15606@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@redhat.com>, mukansai@emailplus.org,
	scott.feldman@intel.com, netfilter-devel@lists.netfilter.org,
	linux-kernel@vger.kernel.org
References: <20031204213030.2B75.MUKANSAI@emailplus.org> <20031205122819.25ac14ab.davem@redhat.com> <20031211110315.GJ22826@sunbeam.de.gnumonks.org> <20031211174136.1ed23e2e.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
Content-Disposition: inline
In-Reply-To: <20031211174136.1ed23e2e.davem@redhat.com>
User-Agent: Mutt/1.5.4i
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2003 at 05:41:36PM -0800, David S. Miller wrote:
> On Thu, 11 Dec 2003 12:03:15 +0100
> Harald Welte <laforge@netfilter.org> wrote:
>=20
> > The only interesting case is in ip_output.c:ip_queue_xmit(), where
> > tso_size and tso_segs are calculated, before NF_IP_LOCAL_OUT is run.
> >=20
> > But changing the content or the size of the tcp payload should not
> > affect those calculations.=20
>=20
> It changes at least tso_segs, since if you decrease of increase the
> size of the payload the number of real TCP/IP packets the TSO engine
> will end up spitting out could be different.

I see.  So what about the networking core exporting an [inline] function
that recalculates tso_segs and tso_size (like the 'Hack zone' code
fragment in ip_queue_xmit() right now), called skb_tso_recalc() or
whatever name you prefer.

Or even better (since I assume TSO can only happen with
locally-originated datagrams), why don't we move the tso_size/tso_segs
calculation to happen after the LOCAL_OUT netfilter hook?  This way we
also get the ip_select_ident_more() right, which we couldn't easily
update from the proposed skb_tso_recalc() function.

yes, in that case we would need to have some fake code like
	if (skb->len > mtu && (sk->sk_route_caps&NETIF_F_TSO))
		skb_shinfo(skb)->tso_segs =3D 1;
in order to make the newly-created check for refragmentation in
conntrack still work.  Alternatively, create some inline function that=20
gives a yes/no return if the skb would later become TSO or not.

> The one netfilter module I'm most concerned about is the one that
> handles non-passive FTP, I remember that one did strange things with
> the data stream, removed TCP options, and stuff like that.

There are no NAT helper modules as of now that touch the size of the TCP
header.  We have some experimental stuff in patch-o-matic (like
IPV3OPTSSTRIP target), but nothing in the stock kernel.  I will put a
review of those on our TODO list - but for the vanilla kernel there
shouldn't be a problem.

> > Even in the past, when we used to remove SACKPERM from the tcp
> > header, we just NOP'ed it out instead of resizing the header.
>=20
> This may be what I was thinking about.

We now don't do that anymore and mangle the SACK options accordingly.
In any way, there is nothing that changes the size of the tcp or udp
header. =20

> Currently all the TSO supporting drivers set the ip and tcp header
> checksum values themselves as appropriate, so there are no worries in
> this area.

good news.

Please get back to me with any comments you might have, thanks.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2WfLXaXGVTD0i/8RAmWOAJ9Er60Kd/D3SvjMTWB2H6f0Q1JZEwCfUTGz
FPnm0qaY4QGR5xN8TDHwAtY=
=JwZG
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--
