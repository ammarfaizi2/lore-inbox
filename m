Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264892AbTLKLIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 06:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTLKLIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 06:08:31 -0500
Received: from coruscant.franken.de ([193.174.159.226]:31681 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S264892AbTLKLI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 06:08:28 -0500
Date: Thu, 11 Dec 2003 12:03:15 +0100
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Stephen Lee <mukansai@emailplus.org>, scott.feldman@intel.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: TSO and netfilter (Re: Extremely slow network with e1000 & ip_conntrack)
Message-ID: <20031211110315.GJ22826@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@redhat.com>,
	Stephen Lee <mukansai@emailplus.org>, scott.feldman@intel.com,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <20031204213030.2B75.MUKANSAI@emailplus.org> <20031205122819.25ac14ab.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline
In-Reply-To: <20031205122819.25ac14ab.davem@redhat.com>
X-Operating-system: Linux sunbeam 2.6.0-test5-nftest
X-Date: Today is Setting Orange, the 53rd day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2003 at 12:28:19PM -0800, David S. Miller wrote:

> Some auditing is definitely necessary wrt. TSO and netfilter.  In particu=
lar
> I am incredibly confident that we have issues in cases like when the FTP
> netfilter modules mangle the data.

I didn't have a look into how TSO is implemented until today.  From my
naive point of view, I cannot think of any issues.  From a netfilter
point of view, a TSO-enabled skb just looks like a single large packet,
right?

I mean, the TSO-enabled skb still contains a fully valid IP and TCP
packet.  If we do any changes to the IP header or tcp header bits, or
even to the payload of the packet, this happens before the TSO-enabled
driver and the network board start creating multiple tcp/ip datagrams
=66rom this skb (by using the information present in the
netfilter-modified ip/tcp headers).

The only interesting case is in ip_output.c:ip_queue_xmit(), where
tso_size and tso_segs are calculated, before NF_IP_LOCAL_OUT is run.

But changing the content or the size of the tcp payload should not
affect those calculations.=20

A real problem would be resizing the TCP header (where th.doff is
affected).  But I cannot think of any case where any of the current
netfilter/iptables/conntrack/nat code does that.  Even in the past, when
we used to remove SACKPERM from the tcp header, we just NOP'ed it out
instead of resizing the header.

> Another area for inspection are the cases where TCP header bits are
> changed and thus the checksum needs to be adjusted.

Why is this a problem?  The netfilter code has to adjust the checksum
anyway... or is the checksum calculation for TSO-enabled skb's
different?

Please enlighten me if I have missed something.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2E7zXaXGVTD0i/8RAp+OAKCoJ+hjxMn1NNNa8LZQkR8jo8DjcgCgoNGd
YfIVOi6AEOe3MZY7CuC2KcQ=
=uhHX
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--
