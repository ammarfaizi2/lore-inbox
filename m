Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbULOGxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbULOGxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 01:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbULOGxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 01:53:21 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:9407 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261907AbULOGxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 01:53:09 -0500
Subject: Re: 2.6.9 NAT problem
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412142222240.10830@denise.shiny.it>
References: <20041213212603.4e698de6.pochini@shiny.it>
	 <Pine.LNX.4.58.0412141025040.23132@tux.rsn.bth.se>
	 <Pine.LNX.4.58.0412142222240.10830@denise.shiny.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6GDNMm8mGlxNUn9c/RSD"
Message-Id: <1103093585.12078.55.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Dec 2004 07:53:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6GDNMm8mGlxNUn9c/RSD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-12-14 at 22:26, Giuliano Pochini wrote:

> > 2.6.9 contains a large update to the connectiontracking code. One thing
> > that was changed is that it now verifies the checksum of tcp and udp
> > packets. I know of at least one user who has been bitten by this and wh=
at
> > looks like a broken sungem NIC.
> >
> > Could you please try this:
> >
> > modprobe ipt_LOG
> > echo 255 > /proc/sys/net/ipv4/netfilter/ip_conntrack_log_invalid
> >
> > Then try again and then check the kernellog by executing 'dmesg', see i=
f
> > it complains about bad checksums.
>=20
> Yes :(

:( It seems there are silicon revisions of the apple sungem that produce
broken checksums. This is what we were worried about, we'll probably
submit a patch soon that removes the checksum checking,  then it'll
behave more like < 2.6.9-pre1

In the meantime you can use the patch below that simply comments that
code out. It's not diffed against 2.6.9 but should apply anyway.

Would be great if you could report a 'Yay' or 'Nay' on your success with
this patch.

--- linux-2.6.10-rc1-ck1/net/ipv4/netfilter/ip_conntrack_proto_tcp.c.orig	2=
004-12-15 07:46:30.000000000 +0100
+++ linux-2.6.10-rc1-ck1/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	2004-1=
2-15 07:47:34.000000000 +0100
@@ -800,7 +800,7 @@ static int tcp_error(struct sk_buff *skb
 	 * and moreover root might send raw packets.
 	 */
 	/* FIXME: Source route IP option packets --RR */
-	if (hooknum =3D=3D NF_IP_PRE_ROUTING
+/*	if (hooknum =3D=3D NF_IP_PRE_ROUTING
 	    && csum_tcpudp_magic(iph->saddr, iph->daddr, tcplen, IPPROTO_TCP,
 			         skb->ip_summed =3D=3D CHECKSUM_HW ? skb->csum
 			      	 : skb_checksum(skb, iph->ihl*4, tcplen, 0))) {
@@ -808,7 +808,7 @@ static int tcp_error(struct sk_buff *skb
 			nf_log_packet(PF_INET, 0, skb, NULL, NULL,=20
 				  "ip_ct_tcp: bad TCP checksum ");
 		return -NF_ACCEPT;
-	}
+	} */
=20
 	/* Check TCP flags. */
 	tcpflags =3D (((u_int8_t *)th)[13] & ~(TH_ECE|TH_CWR));
--- linux-2.6.10-rc1-ck1/net/ipv4/netfilter/ip_conntrack_proto_udp.c.orig	2=
004-12-15 07:46:37.000000000 +0100
+++ linux-2.6.10-rc1-ck1/net/ipv4/netfilter/ip_conntrack_proto_udp.c	2004-1=
2-15 07:47:59.000000000 +0100
@@ -119,7 +119,7 @@ static int udp_error(struct sk_buff *skb
 	 * because the semantic of CHECKSUM_HW is different there=20
 	 * and moreover root might send raw packets.
 	 * FIXME: Source route IP option packets --RR */
-	if (hooknum =3D=3D NF_IP_PRE_ROUTING
+/*	if (hooknum =3D=3D NF_IP_PRE_ROUTING
 	    && csum_tcpudp_magic(iph->saddr, iph->daddr, udplen, IPPROTO_UDP,
 			         skb->ip_summed =3D=3D CHECKSUM_HW ? skb->csum
 			      	 : skb_checksum(skb, iph->ihl*4, udplen, 0))) {
@@ -127,7 +127,7 @@ static int udp_error(struct sk_buff *skb
 			nf_log_packet(PF_INET, 0, skb, NULL, NULL,=20
 				  "ip_ct_udp: bad UDP checksum ");
 		return -NF_ACCEPT;
-	}
+	} */
 =09
 	return NF_ACCEPT;
 }
--- linux-2.6.10-rc1-ck1/net/ipv4/netfilter/ip_conntrack_proto_icmp.c.orig	=
2004-12-15 07:46:43.000000000 +0100
+++ linux-2.6.10-rc1-ck1/net/ipv4/netfilter/ip_conntrack_proto_icmp.c	2004-=
12-15 07:48:57.000000000 +0100
@@ -218,7 +218,7 @@ icmp_error(struct sk_buff *skb, enum ip_
 	}
=20
 	/* See ip_conntrack_proto_tcp.c */
-	if (hooknum !=3D NF_IP_PRE_ROUTING)
+/*	if (hooknum !=3D NF_IP_PRE_ROUTING)
 		goto checksum_skipped;
=20
 	switch (skb->ip_summed) {
@@ -238,7 +238,7 @@ icmp_error(struct sk_buff *skb, enum ip_
 		}
 	default:
 		break;
-	}
+	} */
=20
 checksum_skipped:
 	/*

--=20
/Martin

--=-6GDNMm8mGlxNUn9c/RSD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBv99RWm2vlfa207ERAgPjAJ0ah4wNuPxeb0huf5FLXTUzGTzuDgCdH93x
zDyrn15Ih1xTA7H60ud2Svs=
=mfTn
-----END PGP SIGNATURE-----

--=-6GDNMm8mGlxNUn9c/RSD--
