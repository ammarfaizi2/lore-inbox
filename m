Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVAAPiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVAAPiA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 10:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVAAPiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 10:38:00 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:2027 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261367AbVAAPhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 10:37:51 -0500
Subject: [PATCH] Fix broken RST handling in ip_conntrack
From: Martin Josefsson <gandalf@netfilter.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Netfilter-devel@tux.rsn.bth.se, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-B4MWPshc24Htjg8G4FGs"
Date: Sat, 01 Jan 2005 16:37:47 +0100
Message-Id: <1104593867.3821.36.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B4MWPshc24Htjg8G4FGs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Linus, Andrew
(Sending this mail to you since Davem is on vacation)

Here's a patch that fixes a pretty serious bug introduced by a recent
"bugfix". The problem is that RST packets are ignored if they follow an
ACK packet, this means that the timeout of the connection isn't
decreased, so we get lots of old connections lingering around until the
timeout expires, the default timeout for state ESTABLISHED is 5 days.

This needs to go into -bk as soon as possible. The bug is present in
2.6.10 as well.

--- linux-2.6.10-rc3-bk14/net/ipv4/netfilter/ip_conntrack_proto_tcp.c.orig	=
2004-12-30 19:48:33.000000000 +0100
+++ linux-2.6.10-rc3-bk14/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	2004-=
12-30 19:49:46.000000000 +0100
@@ -906,7 +906,8 @@ static int tcp_packet(struct ip_conntrac
 		if (index =3D=3D TCP_RST_SET
 		    && ((test_bit(IPS_SEEN_REPLY_BIT, &conntrack->status)
 		         && conntrack->proto.tcp.last_index <=3D TCP_SYNACK_SET)
-		        || conntrack->proto.tcp.last_index =3D=3D TCP_ACK_SET)
+		        || (!test_bit(IPS_ASSURED_BIT, &conntrack->status)
+			 && conntrack->proto.tcp.last_index =3D=3D TCP_ACK_SET))
 		    && after(ntohl(th->ack_seq),
 		    	     conntrack->proto.tcp.last_seq)) {
 			/* Ignore RST closing down invalid SYN or ACK

--=20
/Martin

--=-B4MWPshc24Htjg8G4FGs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB1sPLWm2vlfa207ERAqRTAKCJ8j1g0MCYiksRDLJTid1xCIYz9wCfRHw+
QZDTC/eNyI++VISmQBh4oMo=
=sV0B
-----END PGP SIGNATURE-----

--=-B4MWPshc24Htjg8G4FGs--
