Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272324AbTGYUrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272367AbTGYUpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:45:38 -0400
Received: from coruscant.franken.de ([193.174.159.226]:51858 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272324AbTGYUju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:39:50 -0400
Date: Fri, 25 Jul 2003 22:52:20 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] netfilter policy routing fixes
Message-ID: <20030725205220.GA3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="le3rj4S+jilWgWjH"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--le3rj4S+jilWgWjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 2nd of my 2.6 merge of the recent bugfixes (all tested
against 2.4.22-pre7).  You might need to apply them incrementally
(didn't test it in a different order).=20

Author: Patrick McHardy <kaber@trash.net>

This patch fixes some issues with iptables REJECT and MIRROR targets
when combined with policy routing / rp_filter.

Please apply,

diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.v=
er' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.=
cmd' --exclude '*.mod.c' --exclude '*~' linux-2.6.0-test1-nftest2/net/ipv4/=
netfilter/ipt_MIRROR.c linux-2.6.0-test1-nftest3/net/ipv4/netfilter/ipt_MIR=
ROR.c
--- linux-2.6.0-test1-nftest2/net/ipv4/netfilter/ipt_MIRROR.c	2003-07-19 16=
:05:13.000000000 +0200
+++ linux-2.6.0-test1-nftest3/net/ipv4/netfilter/ipt_MIRROR.c	2003-07-19 16=
:13:56.000000000 +0200
@@ -12,6 +12,9 @@
 	18 Jul 2003 Harald Welte <laforge@netfilter.org>
 		- merge Patrick McHardy's mirror fixes from 2.4.22 to
 		  2.6.0-test1
+	19 Jul 2003 Harald Welte <laforge@netfilter.org>
+		- merge Patrick McHardy's rp_filter fixes from 2.4.22 to
+		  2.6.0-test1
=20
   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
@@ -43,17 +46,42 @@
 #define DEBUGP(format, args...)
 #endif
=20
-static inline struct rtable *route_mirror(struct sk_buff *skb)
+static inline struct rtable *route_mirror(struct sk_buff *skb, int local)
 {
         struct iphdr *iph =3D skb->nh.iph;
-	struct flowi fl =3D { .nl_u =3D { .ip4_u =3D { .daddr =3D iph->saddr,
-						 .saddr =3D iph->daddr,
-						 .tos =3D RT_TOS(iph->tos) } } };
+	struct dst_entry *odst;
+	struct flowi fl =3D {};
 	struct rtable *rt;
=20
-	/* Backwards */
-	if (ip_route_output_key(&rt, &fl))
-		return NULL;
+	if (local) {
+		fl.nl_u.ip4_u.daddr =3D iph->saddr;
+		fl.nl_u.ip4_u.saddr =3D iph->daddr;
+		fl.nl_u.ip4_u.tos =3D RT_TOS(iph->tos);
+
+		if (ip_route_output_key(&rt, &fl) !=3D 0)
+			return NULL;
+	} else {
+		/* non-local src, find valid iif to satisfy
+		 * rp-filter when calling ip_route_input(). */
+		fl.nl_u.ip4_u.daddr =3D iph->daddr;
+		if (ip_route_output_key(&rt, &fl) !=3D 0)
+			return NULL;
+
+		odst =3D skb->dst;
+		if (ip_route_input(skb, iph->saddr, iph->daddr,
+					RT_TOS(iph->tos), rt->u.dst.dev) !=3D 0) {
+			dst_release(&rt->u.dst);
+			return NULL;
+		}
+		dst_release(&rt->u.dst);
+		rt =3D (struct rtable *)skb->dst;
+		skb->dst =3D odst;
+	}
+
+	if (rt->u.dst.error) {
+		dst_release(&rt->u.dst);
+		rt =3D NULL;
+	}
=20
 	return rt;
 }
@@ -123,7 +151,7 @@
 		ip_decrease_ttl((*pskb)->nh.iph);
 	}
=20
-	if ((rt =3D route_mirror(*pskb)) =3D=3D NULL)
+	if ((rt =3D route_mirror(*pskb, hooknum =3D=3D NF_IP_LOCAL_IN)) =3D=3D NU=
LL)
 		return NF_DROP;
=20
 	hh_len =3D (rt->u.dst.dev->hard_header_len + 15) & ~15;
diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.v=
er' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.=
cmd' --exclude '*.mod.c' --exclude '*~' linux-2.6.0-test1-nftest2/net/ipv4/=
netfilter/ipt_REJECT.c linux-2.6.0-test1-nftest3/net/ipv4/netfilter/ipt_REJ=
ECT.c
--- linux-2.6.0-test1-nftest2/net/ipv4/netfilter/ipt_REJECT.c	2003-07-19 14=
:14:23.000000000 +0200
+++ linux-2.6.0-test1-nftest3/net/ipv4/netfilter/ipt_REJECT.c	2003-07-19 16=
:13:32.000000000 +0200
@@ -35,6 +35,46 @@
 	}
 }
=20
+static inline struct rtable *route_reverse(struct sk_buff *skb, int local)
+{
+	struct iphdr *iph =3D skb->nh.iph;
+	struct dst_entry *odst;
+	struct flowi fl =3D {};
+	struct rtable *rt;
+
+	if (local) {
+		fl.nl_u.ip4_u.daddr =3D iph->saddr;
+		fl.nl_u.ip4_u.saddr =3D iph->daddr;
+		fl.nl_u.ip4_u.tos =3D RT_TOS(iph->tos);
+
+		if (ip_route_output_key(&rt, &fl) !=3D 0)
+			return NULL;
+	} else {
+		/* non-local src, find valid iif to satisfy
+		 * rp-filter when calling ip_route_input. */
+		fl.nl_u.ip4_u.daddr =3D iph->daddr;
+		if (ip_route_output_key(&rt, &fl) !=3D 0)
+			return NULL;
+
+		odst =3D skb->dst;
+		if (ip_route_input(skb, iph->saddr, iph->daddr,
+		                   RT_TOS(iph->tos), rt->u.dst.dev) !=3D 0) {
+			dst_release(&rt->u.dst);
+			return NULL;
+		}
+		dst_release(&rt->u.dst);
+		rt =3D (struct rtable *)skb->dst;
+		skb->dst =3D odst;
+	}
+
+	if (rt->u.dst.error) {
+		dst_release(&rt->u.dst);
+		rt =3D NULL;
+	}
+
+	return rt;
+}
+
 /* Send RST reply */
 static void send_reset(struct sk_buff *oldskb, int local)
 {
@@ -69,18 +109,9 @@
 			 csum_partial((char *)otcph, otcplen, 0)) !=3D 0)
 		return;
=20
-	{
-		struct flowi fl =3D { .nl_u =3D { .ip4_u =3D
-					      { .daddr =3D oldskb->nh.iph->saddr,
-						.saddr =3D (local ?
-							  oldskb->nh.iph->daddr :
-							  0),
-						.tos =3D RT_TOS(oldskb->nh.iph->tos) } } };
-
-	/* Routing: if not headed for us, route won't like source */
-	if (ip_route_output_key(&rt, &fl))
+	if ((rt =3D route_reverse(oldskb, local)) =3D=3D NULL)
 		return;
-	}	=09
+
 	hh_len =3D (rt->u.dst.dev->hard_header_len + 15)&~15;
=20
 	/* Copy skb (even if skb is about to be dropped, we can't just
--- linux-2.6.0-test1-nftest2/net/core/netfilter.c	2003-07-14 05:33:59.0000=
00000 +0200
+++ linux-2.6.0-test1-nftest3/net/core/netfilter.c	2003-07-19 16:21:26.0000=
00000 +0200
@@ -625,66 +625,62 @@
 {
 	struct iphdr *iph =3D (*pskb)->nh.iph;
 	struct rtable *rt;
-	struct flowi fl =3D { .nl_u =3D { .ip4_u =3D
-				      { .daddr =3D iph->daddr,
-					.saddr =3D iph->saddr,
-					.tos =3D RT_TOS(iph->tos)|RTO_CONN,
+	struct flowi fl =3D {};
+	struct dst_entry *odst;
+	unsigned int hh_len;
+
+	/* some non-standard hacks like ipt_REJECT.c:send_reset() can cause
+	 * packets with foreign saddr to appear on the NF_IP_LOCAL_OUT hook.
+	 */
+	if (inet_addr_type(iph->saddr) =3D=3D RTN_LOCAL) {
+		fl.nl_u.ip4_u.daddr =3D iph->daddr;
+		fl.nl_u.ip4_u.saddr =3D iph->saddr;
+		fl.nl_u.ip4_u.tos =3D RT_TOS(iph->tos);
+		fl.oif =3D (*pskb)->sk ? (*pskb)->sk->sk_bound_dev_if : 0;
 #ifdef CONFIG_IP_ROUTE_FWMARK
-					.fwmark =3D (*pskb)->nfmark
+		fl.nl_u.ip4_u.fwmark =3D (*pskb)->nfmark;
 #endif
-				      } },
-			    .oif =3D (*pskb)->sk ? (*pskb)->sk->sk_bound_dev_if : 0,
-			    };
-	struct net_device *dev_src =3D NULL;
-	int err;
-
-	/* accommodate ip_route_output_slow(), which expects the key src to be
-	   0 or a local address; however some non-standard hacks like
-	   ipt_REJECT.c:send_reset() can cause packets with foreign
-           saddr to be appear on the NF_IP_LOCAL_OUT hook -MB */
-	if(fl.fl4_src && !(dev_src =3D ip_dev_find(fl.fl4_src)))
-		fl.fl4_src =3D 0;
-
-	if ((err=3Dip_route_output_key(&rt, &fl)) !=3D 0) {
-		printk("route_me_harder: ip_route_output_key(dst=3D%u.%u.%u.%u, src=3D%u=
=2E%u.%u.%u, oif=3D%d, tos=3D0x%x, fwmark=3D0x%lx) error %d\n",
-			NIPQUAD(iph->daddr), NIPQUAD(iph->saddr),
-			(*pskb)->sk ? (*pskb)->sk->sk_bound_dev_if : 0,
-			RT_TOS(iph->tos)|RTO_CONN,
-#ifdef CONFIG_IP_ROUTE_FWMARK
-			(*pskb)->nfmark,
-#else
-			0UL,
-#endif
-			err);
-		goto out;
-	}
-
-	/* Drop old route. */
-	dst_release((*pskb)->dst);
+		if (ip_route_output_key(&rt, &fl) !=3D 0)
+			return -1;
=20
-	(*pskb)->dst =3D &rt->u.dst;
+		/* Drop old route. */
+		dst_release((*pskb)->dst);
+		(*pskb)->dst =3D &rt->u.dst;
+	} else {
+		/* non-local src, find valid iif to satisfy
+		 * rp-filter when calling ip_route_input. */
+		fl.nl_u.ip4_u.daddr =3D iph->saddr;
+		if (ip_route_output_key(&rt, &fl) !=3D 0)
+			return -1;
+
+		odst =3D (*pskb)->dst;
+		if (ip_route_input(*pskb, iph->daddr, iph->saddr,
+				   RT_TOS(iph->tos), rt->u.dst.dev) !=3D 0) {
+			dst_release(&rt->u.dst);
+			return -1;
+		}
+		dst_release(&rt->u.dst);
+		dst_release(odst);
+	}
+=09
+	if ((*pskb)->dst->error)
+		return -1;
=20
 	/* Change in oif may mean change in hh_len. */
-	if (skb_headroom(*pskb) < (*pskb)->dst->dev->hard_header_len) {
+	hh_len =3D (*pskb)->dst->dev->hard_header_len;
+	if (skb_headroom(*pskb) < hh_len) {
 		struct sk_buff *nskb;
=20
-		nskb =3D skb_realloc_headroom(*pskb,
-					    (*pskb)->dst->dev->hard_header_len);
-		if (!nskb) {
-			err =3D -ENOMEM;
-			goto out;
-		}
+		nskb =3D skb_realloc_headroom(*pskb, hh_len);
+		if (!nskb)=20
+			return -1;
 		if ((*pskb)->sk)
 			skb_set_owner_w(nskb, (*pskb)->sk);
 		kfree_skb(*pskb);
 		*pskb =3D nskb;
 	}
=20
-out:
-	if (dev_src)
-		dev_put(dev_src);
-
-	return err;
+	return 0;
 }
=20
 int skb_ip_make_writable(struct sk_buff **pskb, unsigned int writable_len)
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--le3rj4S+jilWgWjH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZiEXaXGVTD0i/8RAsCtAJ9kHBO+HnPtntI7zQGWn3brq+H5NACfQoRY
Jjf4xhSDOFXNPkdNgF2urIc=
=nzNN
-----END PGP SIGNATURE-----

--le3rj4S+jilWgWjH--
