Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272310AbTGYUnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272339AbTGYUnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:43:02 -0400
Received: from coruscant.franken.de ([193.174.159.226]:40594 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272310AbTGYUiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:38:19 -0400
Date: Fri, 25 Jul 2003 22:50:48 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] iptables MIRROR target fixes
Message-ID: <20030725205048.GH3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U/OZNOFFJieNpJU4"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U/OZNOFFJieNpJU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the first of a set of bugfixes (all tested against 2.4.22-pre7).
You might need to apply them incrementally (didn't test it in a
different order).  You will receive 2.6 merges of those patches soon.

Author: Patrick McHardy <kaber@trash.net>

This patch fixes various problems with the experimental=20
iptables MIRROR target:

- check TTL before rewriting so icmp_send gets clean packet
- skb_copy_expand(skb) for tcpdump and asymmetric routing
- inline some function
- remove unneccessary 'struct in_device' declaration
- remove RTO_CONN

Please apply,

diff -Nru a/net/ipv4/netfilter/ipt_MIRROR.c b/net/ipv4/netfilter/ipt_MIRROR=
=2Ec
--- a/net/ipv4/netfilter/ipt_MIRROR.c	Mon Apr 21 21:26:42 2003
+++ b/net/ipv4/netfilter/ipt_MIRROR.c	Mon Apr 21 21:26:42 2003
@@ -32,7 +32,6 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netdevice.h>
 #include <linux/route.h>
-struct in_device;
 #include <net/route.h>
=20
 #if 0
@@ -41,31 +40,20 @@
 #define DEBUGP(format, args...)
 #endif
=20
-static int route_mirror(struct sk_buff *skb)
+static inline struct rtable *route_mirror(struct sk_buff *skb)
 {
         struct iphdr *iph =3D skb->nh.iph;
 	struct rtable *rt;
=20
 	/* Backwards */
 	if (ip_route_output(&rt, iph->saddr, iph->daddr,
-			    RT_TOS(iph->tos) | RTO_CONN,
-			    0)) {
-		return 0;
-	}
+			    RT_TOS(iph->tos), 0))
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
-static void
-ip_rewrite(struct sk_buff *skb)
+static inline void ip_rewrite(struct sk_buff *skb)
 {
 	struct iphdr *iph =3D skb->nh.iph;
 	u32 odaddr =3D iph->saddr;
@@ -105,32 +93,48 @@
 				      const void *targinfo,
 				      void *userinfo)
 {
-	if (((*pskb)->dst !=3D NULL) &&
-	    route_mirror(*pskb)) {
-
-		ip_rewrite(*pskb);
+	struct rtable *rt;
+	struct sk_buff *nskb;
+	unsigned int hh_len;
=20
-		/* If we are not at FORWARD hook (INPUT/PREROUTING),
-		 * the TTL isn't decreased by the IP stack */
-		if (hooknum !=3D NF_IP_FORWARD) {
-			struct iphdr *iph =3D (*pskb)->nh.iph;
-			if (iph->ttl <=3D 1) {
-				/* this will traverse normal stack, and=20
-				 * thus call conntrack on the icmp packet */
-				icmp_send(*pskb, ICMP_TIME_EXCEEDED,=20
-					  ICMP_EXC_TTL, 0);
-				return NF_DROP;
-			}
-			ip_decrease_ttl(iph);
+	/* If we are not at FORWARD hook (INPUT/PREROUTING),
+	 * the TTL isn't decreased by the IP stack */
+	if (hooknum !=3D NF_IP_FORWARD) {
+		struct iphdr *iph =3D (*pskb)->nh.iph;
+		if (iph->ttl <=3D 1) {
+			/* this will traverse normal stack, and=20
+			 * thus call conntrack on the icmp packet */
+			icmp_send(*pskb, ICMP_TIME_EXCEEDED,=20
+				  ICMP_EXC_TTL, 0);
+			return NF_DROP;
 		}
+		ip_decrease_ttl(iph);
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
+           it will think we are starting a new
+           connection! --RR */
+	ip_direct_send(nskb);
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

--U/OZNOFFJieNpJU4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZgoXaXGVTD0i/8RAr7GAKCwENd6SRw+n3cqMrzm9462njYd6wCgs/OV
fFjYOZPQZmtM05/FF2G/mA8=
=F3l5
-----END PGP SIGNATURE-----

--U/OZNOFFJieNpJU4--
