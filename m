Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272363AbTGYUrc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272324AbTGYUqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:46:11 -0400
Received: from coruscant.franken.de ([193.174.159.226]:51090 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272321AbTGYUjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:39:47 -0400
Date: Fri, 25 Jul 2003 22:52:17 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] iptables MIRROR target fixes
Message-ID: <20030725205217.GZ3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CD1rT0yj7A8qvce7"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CD1rT0yj7A8qvce7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the first of my 2.6 merge of the recent bugfixes (all tested
against 2.6.0-test1).  You might need to apply them incrementally
(didn't test it in a different order).

Author: Patrick McHardy <kaber@trash.net>

This patch fixes various problems with the experimental=20
iptables MIRROR target:

- check TTL before rewriting so icmp_send gets clean packet
- skb_copy_expand(skb) for tcpdump and asymmetric routing
- inline some function
- remove unneccessary 'struct in_device' declaration
- remove RTO_CONN

Please apply,

=20
--- linux-2.6.0-test1-nftest/net/ipv4/netfilter/ipt_MIRROR.c	2003-07-14 05:=
39:23.000000000 +0200
+++ linux-2.6.0-test1-nftest2/net/ipv4/netfilter/ipt_MIRROR.c	2003-07-19 16=
:05:13.000000000 +0200
@@ -9,6 +9,9 @@
   Changes:
 	25 Aug 2001 Harald Welte <laforge@gnumonks.org>
 		- decrement and check TTL if not called from FORWARD hook
+	18 Jul 2003 Harald Welte <laforge@netfilter.org>
+		- merge Patrick McHardy's mirror fixes from 2.4.22 to
+		  2.6.0-test1
=20
   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
@@ -32,7 +35,6 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netdevice.h>
 #include <linux/route.h>
-struct in_device;
 #include <net/route.h>
=20
 #if 0
@@ -41,46 +43,33 @@
 #define DEBUGP(format, args...)
 #endif
=20
-static int route_mirror(struct sk_buff *skb)
+static inline struct rtable *route_mirror(struct sk_buff *skb)
 {
         struct iphdr *iph =3D skb->nh.iph;
 	struct flowi fl =3D { .nl_u =3D { .ip4_u =3D { .daddr =3D iph->saddr,
 						 .saddr =3D iph->daddr,
-						 .tos =3D RT_TOS(iph->tos) | RTO_CONN } } };
+						 .tos =3D RT_TOS(iph->tos) } } };
 	struct rtable *rt;
=20
 	/* Backwards */
-	if (ip_route_output_key(&rt, &fl)) {
-		return 0;
-	}
+	if (ip_route_output_key(&rt, &fl))
+		return NULL;
=20
-	/* check if the interface we are leaving by is the same as the
-           one we arrived on */
-	if (skb->dev =3D=3D rt->u.dst.dev) {
-		/* Drop old route. */
-		dst_release(skb->dst);
-		skb->dst =3D &rt->u.dst;
-		return 1;
-	}
-	return 0;
+	return rt;
 }
=20
-static int ip_rewrite(struct sk_buff **pskb)
+static inline void ip_rewrite(struct sk_buff *skb)
 {
 	u32 odaddr, osaddr;
=20
-	if (!skb_ip_make_writable(pskb, sizeof(struct iphdr)))
-		return 0;
+	odaddr =3D skb->nh.iph->saddr;
+	osaddr =3D skb->nh.iph->daddr;
=20
-	odaddr =3D (*pskb)->nh.iph->saddr;
-	osaddr =3D (*pskb)->nh.iph->daddr;
-
-	(*pskb)->nfcache |=3D NFC_ALTERED;
+	skb->nfcache |=3D NFC_ALTERED;
=20
 	/* Rewrite IP header */
-	(*pskb)->nh.iph->daddr =3D odaddr;
-	(*pskb)->nh.iph->saddr =3D osaddr;
-	return 1;
+	skb->nh.iph->daddr =3D odaddr;
+	skb->nh.iph->saddr =3D osaddr;
 }
=20
 /* Stolen from ip_finish_output2 */
@@ -113,31 +102,51 @@
 				      const void *targinfo,
 				      void *userinfo)
 {
-	if (((*pskb)->dst !=3D NULL) && route_mirror(*pskb)) {
-		if (!ip_rewrite(pskb))
-			return NF_DROP;
+	struct rtable *rt;
+	struct sk_buff *nskb;
+	unsigned int hh_len;
=20
-		/* If we are not at FORWARD hook (INPUT/PREROUTING),
-		 * the TTL isn't decreased by the IP stack */
-		if (hooknum !=3D NF_IP_FORWARD) {
-			if ((*pskb)->nh.iph->ttl <=3D 1) {
-				/* this will traverse normal stack, and=20
-				 * thus call conntrack on the icmp packet */
-				icmp_send(*pskb, ICMP_TIME_EXCEEDED,=20
-					  ICMP_EXC_TTL, 0);
-				return NF_DROP;
-			}
-			/* Made writable by ip_rewrite */
-			ip_decrease_ttl((*pskb)->nh.iph);
+	/* Make skb writable */
+	if (!skb_ip_make_writable(pskb, sizeof(struct iphdr)))
+		return 0;
+
+	/* If we are not at FORWARD hook (INPUT/PREROUTING),
+	 * the TTL isn't decreased by the IP stack */
+	if (hooknum !=3D NF_IP_FORWARD) {
+		if ((*pskb)->nh.iph->ttl <=3D 1) {
+			/* this will traverse normal stack, and=20
+			 * thus call conntrack on the icmp packet */
+			icmp_send(*pskb, ICMP_TIME_EXCEEDED,=20
+				  ICMP_EXC_TTL, 0);
+			return NF_DROP;
 		}
+		ip_decrease_ttl((*pskb)->nh.iph);
+	}
=20
-		/* Don't let conntrack code see this packet:
-                   it will think we are starting a new
-                   connection! --RR */
-		ip_direct_send(*pskb);
+	if ((rt =3D route_mirror(*pskb)) =3D=3D NULL)
+		return NF_DROP;
=20
-		return NF_STOLEN;
+	hh_len =3D (rt->u.dst.dev->hard_header_len + 15) & ~15;
+
+	/* Copy skb (even if skb is about to be dropped, we can't just
+	 * clone it because there may be other things, such as tcpdump,
+	 * interested in it). We also need to expand headroom in case
+	 * hh_len of incoming interface < hh_len of outgoing interface */
+	nskb =3D skb_copy_expand(*pskb, hh_len, skb_tailroom(*pskb), GFP_ATOMIC);
+	if (nskb =3D=3D NULL) {
+		dst_release(&rt->u.dst);
+		return NF_DROP;
 	}
+
+	dst_release(nskb->dst);
+	nskb->dst =3D &rt->u.dst;
+
+	ip_rewrite(nskb);
+	/* Don't let conntrack code see this packet:
+	 * it will think we are starting a new
+	 * connection! --RR */
+	ip_direct_send(*pskb);
+
 	return NF_DROP;
 }
=20
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--CD1rT0yj7A8qvce7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZiBXaXGVTD0i/8RAiMqAKCXDSpX/Vk957m0l6+LC+g9gaIHRgCeMg7P
mtZ0tAyt9UW92NTeHjLCGeE=
=TxZD
-----END PGP SIGNATURE-----

--CD1rT0yj7A8qvce7--
