Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUGFPJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUGFPJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 11:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUGFPJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 11:09:51 -0400
Received: from pra69-d92.gd.dial-up.cz ([193.85.69.92]:34434 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S263979AbUGFPJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 11:09:48 -0400
Date: Tue, 6 Jul 2004 17:09:18 +0200
To: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, laforge@netfilter.org
Subject: [PATCH 2.6] ip6t_LOG and packets with hop-by-hop options
Message-ID: <20040706150918.GA5009@penguin.localdomain>
Mail-Followup-To: davem@redhat.com, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
	laforge@netfilter.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Packet with IPPROTO_HOPOPTS extended header isn't logged properly by
ip6t_LOG.c. It only prints PROTO=3D0 and nothing more, because
IPPROTO_HOPOPTS=3D0 and in this file 0 is used to indicate last header.
This patch fix it by using IPPROTO_NONE to indicate last header.

Signed-off-by: Marcel Sebek <sebek64@post.cz>


diff -urpN linux-2.6/net/ipv6/netfilter/ip6t_LOG.c linux-2.6-new/net/ipv6/n=
etfilter/ip6t_LOG.c
--- linux-2.6/net/ipv6/netfilter/ip6t_LOG.c	2004-04-21 20:01:54.000000000 +=
0200
+++ linux-2.6-new/net/ipv6/netfilter/ip6t_LOG.c	2004-07-06 16:48:20.0000000=
00 +0200
@@ -48,10 +48,10 @@ static spinlock_t log_lock =3D SPIN_LOCK_U
=20
 /* takes in current header and pointer to the header */
 /* if another header exists, sets hdrptr to the next header
-   and returns the new header value, else returns 0 */
+   and returns the new header value, else returns IPPROTO_NONE */
 static u_int8_t ip6_nexthdr(u_int8_t currenthdr, u_int8_t **hdrptr)
 {
-	u_int8_t hdrlen, nexthdr =3D 0;
+	u_int8_t hdrlen, nexthdr =3D IPPROTO_NONE;
=20
 	switch(currenthdr){
 		case IPPROTO_AH:
@@ -77,7 +77,6 @@ static u_int8_t ip6_nexthdr(u_int8_t cur
 			break;
 	}=09
 	return nexthdr;
-
 }
=20
 /* One level of recursion won't kill us */
@@ -101,7 +100,7 @@ static void dump_packet(const struct ip6
=20
 	fragment =3D 0;
 	hdrptr =3D (u_int8_t *)(ipv6h + 1);
-	while (currenthdr) {
+	while (currenthdr !=3D IPPROTO_NONE) {
 		if ((currenthdr =3D=3D IPPROTO_TCP) ||
 		    (currenthdr =3D=3D IPPROTO_UDP) ||
 		    (currenthdr =3D=3D IPPROTO_ICMPV6))
@@ -264,7 +263,7 @@ static void dump_packet(const struct ip6
 		}
 		break;
 	}
-	/* Max length: 10 "PROTO 255 " */
+	/* Max length: 10 "PROTO=3D255 " */
 	default:
 		printk("PROTO=3D%u ", currenthdr);
 	}

--=20
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6sCei2PKBl+Ic14RAnMzAJ0eiT7tjALg/NK/CBncrOx4T7483ACgsbLW
CH8XFhFINipmMwaX8CnB/4w=
=dWBX
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
