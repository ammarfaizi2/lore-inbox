Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272360AbTGYVIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272323AbTGYUmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:42:40 -0400
Received: from coruscant.franken.de ([193.174.159.226]:41362 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272311AbTGYUiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:38:25 -0400
Date: Fri, 25 Jul 2003 22:50:51 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] netfilter policy routing fixes
Message-ID: <20030725205051.GI3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24bywM+ZyrW0DJoD"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24bywM+ZyrW0DJoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 2nd of a set of bugfixes (all tested against 2.4.22-pre7).
You might need to apply them incrementally (didn't test it in a
different order).  You will receive 2.6 merges of those patches soon.

Author: Patrick McHardy <kaber@trash.net>

This patch fixes some issues with iptables REJECT and MIRROR targets
when combined with policy routing / rp_filter.

Please apply,

diff -Nru a/net/core/netfilter.c b/net/core/netfilter.c
--- a/net/core/netfilter.c	Tue Apr 22 01:07:31 2003
+++ b/net/core/netfilter.c	Tue Apr 22 01:07:31 2003
@@ -563,64 +563,62 @@
 {
 	struct iphdr *iph =3D (*pskb)->nh.iph;
 	struct rtable *rt;
-	struct rt_key key =3D { dst:iph->daddr,
-			      src:iph->saddr,
-			      oif:(*pskb)->sk ? (*pskb)->sk->bound_dev_if : 0,
-			      tos:RT_TOS(iph->tos)|RTO_CONN,
+	struct rt_key key =3D {};
+	struct dst_entry *odst;
+	unsigned int hh_len;
+
+	/* some non-standard hacks like ipt_REJECT.c:send_reset() can cause
+	 * packets with foreign saddr to be appear on the NF_IP_LOCAL_OUT hook.
+	 */
+	if (inet_addr_type(iph->saddr) =3D=3D RTN_LOCAL) {
+		key.dst =3D iph->daddr;
+		key.src =3D iph->saddr;
+		key.oif =3D (*pskb)->sk ? (*pskb)->sk->bound_dev_if : 0;
+		key.tos =3D RT_TOS(iph->tos);
 #ifdef CONFIG_IP_ROUTE_FWMARK
-			      fwmark:(*pskb)->nfmark
+		key.fwmark =3D (*pskb)->nfmark;
 #endif
-			    };
-	struct net_device *dev_src =3D NULL;
-	int err;
-
-	/* accomodate ip_route_output_slow(), which expects the key src to be
-	   0 or a local address; however some non-standard hacks like
-	   ipt_REJECT.c:send_reset() can cause packets with foreign
-           saddr to be appear on the NF_IP_LOCAL_OUT hook -MB */
-	if(key.src && !(dev_src =3D ip_dev_find(key.src)))
-		key.src =3D 0;
-
-	if ((err=3Dip_route_output_key(&rt, &key)) !=3D 0) {
-		printk("route_me_harder: ip_route_output_key(dst=3D%u.%u.%u.%u, src=3D%u=
=2E%u.%u.%u, oif=3D%d, tos=3D0x%x, fwmark=3D0x%lx) error %d\n",
-			NIPQUAD(iph->daddr), NIPQUAD(iph->saddr),
-			(*pskb)->sk ? (*pskb)->sk->bound_dev_if : 0,
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
+		if (ip_route_output_key(&rt, &key) !=3D 0)
+			return -1;
=20
-	(*pskb)->dst =3D &rt->u.dst;
+		/* Drop old route. */
+		dst_release((*pskb)->dst);
+		(*pskb)->dst =3D &rt->u.dst;
+	} else {
+		/* non-local src, find valid iif to satisfy
+		 * rp-filter when calling ip_route_input. */
+		key.dst =3D iph->saddr;
+		if (ip_route_output_key(&rt, &key) !=3D 0)
+			return -1;
+
+		odst =3D (*pskb)->dst;
+		if (ip_route_input(*pskb, iph->daddr, iph->saddr,
+		                   RT_TOS(iph->tos), rt->u.dst.dev) !=3D 0) {
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
+		if (!nskb)
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
 #endif /*CONFIG_INET*/
=20
diff -Nru a/net/ipv4/netfilter/ipt_MIRROR.c b/net/ipv4/netfilter/ipt_MIRROR=
=2Ec
--- a/net/ipv4/netfilter/ipt_MIRROR.c	Tue Apr 22 01:07:31 2003
+++ b/net/ipv4/netfilter/ipt_MIRROR.c	Tue Apr 22 01:07:31 2003
@@ -40,15 +40,42 @@
 #define DEBUGP(format, args...)
 #endif
=20
-static inline struct rtable *route_mirror(struct sk_buff *skb)
+static inline struct rtable *route_mirror(struct sk_buff *skb, int local)
 {
         struct iphdr *iph =3D skb->nh.iph;
+	struct dst_entry *odst;
+	struct rt_key key =3D {};
 	struct rtable *rt;
=20
-	/* Backwards */
-	if (ip_route_output(&rt, iph->saddr, iph->daddr,
-			    RT_TOS(iph->tos), 0))
-		return NULL;
+	if (local) {
+		key.dst =3D iph->saddr;
+		key.src =3D iph->daddr;
+		key.tos =3D RT_TOS(iph->tos);
+
+		if (ip_route_output_key(&rt, &key) !=3D 0)
+			return NULL;
+	} else {
+		/* non-local src, find valid iif to satisfy
+		 * rp-filter when calling ip_route_input. */
+		key.dst =3D iph->daddr;
+		if (ip_route_output_key(&rt, &key) !=3D 0)
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
=20
 	return rt;
 }
@@ -111,7 +138,7 @@
 		ip_decrease_ttl(iph);
 	}
=20
-	if ((rt =3D route_mirror(*pskb)) =3D=3D NULL)
+	if ((rt =3D route_mirror(*pskb, hooknum =3D=3D NF_IP_LOCAL_IN)) =3D=3D NU=
LL)
 		return NF_DROP;
=20
 	hh_len =3D (rt->u.dst.dev->hard_header_len + 15) & ~15;
diff -Nru a/net/ipv4/netfilter/ipt_REJECT.c b/net/ipv4/netfilter/ipt_REJECT=
=2Ec
--- a/net/ipv4/netfilter/ipt_REJECT.c	Tue Apr 22 01:07:31 2003
+++ b/net/ipv4/netfilter/ipt_REJECT.c	Tue Apr 22 01:07:31 2003
@@ -33,6 +33,46 @@
 		attach(new_skb, nfct);
 }
=20
+static inline struct rtable *route_reverse(struct sk_buff *skb, int local)
+{
+	struct iphdr *iph =3D skb->nh.iph;
+	struct dst_entry *odst;
+	struct rt_key key =3D {};
+	struct rtable *rt;
+
+	if (local) {
+		key.dst =3D iph->saddr;
+		key.src =3D iph->daddr;
+		key.tos =3D RT_TOS(iph->tos);
+
+		if (ip_route_output_key(&rt, &key) !=3D 0)
+			return NULL;
+	} else {
+		/* non-local src, find valid iif to satisfy
+		 * rp-filter when calling ip_route_input. */
+		key.dst =3D iph->daddr;
+		if (ip_route_output_key(&rt, &key) !=3D 0)
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
@@ -63,10 +103,7 @@
 			 csum_partial((char *)otcph, otcplen, 0)) !=3D 0)
 		return;
=20
-	/* Routing: if not headed for us, route won't like source */
-	if (ip_route_output(&rt, oldskb->nh.iph->saddr,
-			    local ? oldskb->nh.iph->daddr : 0,
-			    RT_TOS(oldskb->nh.iph->tos), 0) !=3D 0)
+	if ((rt =3D route_reverse(oldskb, local)) =3D=3D NULL)
 		return;
=20
 	hh_len =3D (rt->u.dst.dev->hard_header_len + 15)&~15;
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--24bywM+ZyrW0DJoD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZgrXaXGVTD0i/8RAsE/AJ9NgvwfiUroAnFz4aTw5lrfaZIBWACcC8UI
kGIq+9m7tyE/lhj/RzBy4Zk=
=NCbW
-----END PGP SIGNATURE-----

--24bywM+ZyrW0DJoD--
