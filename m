Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUHYUiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUHYUiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUHYUdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:33:55 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:40097 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S268590AbUHYUcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:32:19 -0400
Date: Wed, 25 Aug 2004 22:32:06 +0200
From: Harald Welte <laforge@netfilter.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       David Miller <davem@redhat.com>
Subject: Re: Linux 2.6.9-rc1
Message-ID: <20040825203206.GS5824@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	David Miller <davem@redhat.com>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <412CDFEE.1010505@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <412CDFEE.1010505@triplehelix.org>
User-Agent: Mutt/1.5.6+20040722i
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2004 at 11:52:30AM -0700, Joshua Kwan wrote:
> Linus Torvalds wrote:
> >Harald Welte:
> ...
> >  o [NETFILTER]: Make 'helper' list of ip_nat_core static
> ...
>=20
> I suspect that this changeset[1] somehow caused this to happen (many=20
> times) in dmesg:
>=20
> ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked

yes, indeed.

> It seems to be working properly (NATting two machines behind a local=20
> network to the Internet.)

The 'problem' is that we try to get a readlock while we're already
protected under a write lock.

Please see the following [quite trivial, but yet untested] patch:

--- linux-2.6.9-rc1/net/ipv4/netfilter/ip_nat_core.c	2004-08-25 22:22:36.45=
0340504 +0200
+++ linux-2.6.9-rc1-find_helper/net/ipv4/netfilter/ip_nat_core.c	2004-08-25=
 22:28:37.668273271 +0200
@@ -635,7 +635,7 @@
=20
 	/* If there's a helper, assign it; based on new tuple. */
 	if (!conntrack->master)
-		info->helper =3D ip_nat_find_helper(&reply);
+		info->helper =3D __ip_nat_find_helper(&reply);
=20
 	/* It's done. */
 	info->initialized |=3D (1 << HOOK2MANIP(hooknum));
--- linux-2.6.9-rc1/net/ipv4/netfilter/ip_nat_helper.c	2004-08-25 22:22:36.=
453340376 +0200
+++ linux-2.6.9-rc1-find_helper/net/ipv4/netfilter/ip_nat_helper.c	2004-08-=
25 22:27:47.880335112 +0200
@@ -421,12 +421,18 @@
 }
=20
 struct ip_nat_helper *
+__ip_nat_find_helper(const struct ip_conntrack_tuple *tuple)
+{
+	return LIST_FIND(&helpers, helper_cmp, struct ip_nat_helper *, tuple);
+}
+
+struct ip_nat_helper *
 ip_nat_find_helper(const struct ip_conntrack_tuple *tuple)
 {
 	struct ip_nat_helper *h;
=20
 	READ_LOCK(&ip_nat_lock);
-	h =3D LIST_FIND(&helpers, helper_cmp, struct ip_nat_helper *, tuple);
+	h =3D __ip_nat_find_helper(tuple);
 	READ_UNLOCK(&ip_nat_lock);
=20
 	return h;
--- linux-2.6.9-rc1/net/ipv4/netfilter/ip_nat_standalone.c	2004-08-25 22:22=
:36.461340035 +0200
+++ linux-2.6.9-rc1-find_helper/net/ipv4/netfilter/ip_nat_standalone.c	2004=
-08-25 22:29:30.047102589 +0200
@@ -394,4 +394,5 @@
 EXPORT_SYMBOL(ip_nat_mangle_tcp_packet);
 EXPORT_SYMBOL(ip_nat_mangle_udp_packet);
 EXPORT_SYMBOL(ip_nat_used_tuple);
+EXPORT_SYMBOL(ip_nat_find_helper);
 MODULE_LICENSE("GPL");

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBLPdGXaXGVTD0i/8RAlWUAJ0UiBXNbG4Qu8yxyzFsz8IQgeq8WQCfcV0P
9Eghv4PZhnYCZUfsYegyEZU=
=CxAk
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
