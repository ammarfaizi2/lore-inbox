Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261420AbSJCWtM>; Thu, 3 Oct 2002 18:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbSJCWtM>; Thu, 3 Oct 2002 18:49:12 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:54794 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261420AbSJCWsr>; Thu, 3 Oct 2002 18:48:47 -0400
Date: Fri, 04 Oct 2002 07:36:42 +0900 (JST)
Message-Id: <20021004.073642.125593159.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Miscellaneous clean-ups
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021003.103617.04446177.davem@redhat.com>
References: <20021004.011315.05129566.yoshfuji@linux-ipv6.org>
	<20021003.103617.04446177.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021003.103617.04446177.davem@redhat.com> (at Thu, 03 Oct 2002 10:36:17 -0700 (PDT)), "David S. Miller" <davem@redhat.com> says:

>    -	addr.s6_addr[15] = 1;
>    +	addr.s6_addr32[3] = __constant_htonl(0x00000001);
>     
> Do not use __constant_htonl() in runtime code, use htonl().
> Arnaldo de Melo told you this the other day for another one
> of your patches, so you must fix this kind of stuff up before
> I'll apply any of your patches which have this problem.

I saw many __constant_{hton,ntoh}{s,l}()s, so fixed.

      1. use s6_addrXX instead of in6_u.s6_addrXX.
      2. avoid using magic number.
      3. use 32bit constants.
 -->  4. avoid __constant_{hton,ntoh}{l,s}() in runtime code.

Index: net/ipv4/arp.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/arp.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/arp.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/arp.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -513,7 +513,7 @@
 	skb->nh.raw = skb->data;
 	arp = (struct arphdr *) skb_put(skb,sizeof(struct arphdr) + 2*(dev->addr_len+4));
 	skb->dev = dev;
-	skb->protocol = __constant_htons (ETH_P_ARP);
+	skb->protocol = htons (ETH_P_ARP);
 	if (src_hw == NULL)
 		src_hw = dev->dev_addr;
 	if (dest_hw == NULL)
@@ -539,33 +539,33 @@
 	switch (dev->type) {
 	default:
 		arp->ar_hrd = htons(dev->type);
-		arp->ar_pro = __constant_htons(ETH_P_IP);
+		arp->ar_pro = htons(ETH_P_IP);
 		break;
 
 #if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
 	case ARPHRD_AX25:
-		arp->ar_hrd = __constant_htons(ARPHRD_AX25);
-		arp->ar_pro = __constant_htons(AX25_P_IP);
+		arp->ar_hrd = htons(ARPHRD_AX25);
+		arp->ar_pro = htons(AX25_P_IP);
 		break;
 
 #if defined(CONFIG_NETROM) || defined(CONFIG_NETROM_MODULE)
 	case ARPHRD_NETROM:
-		arp->ar_hrd = __constant_htons(ARPHRD_NETROM);
-		arp->ar_pro = __constant_htons(AX25_P_IP);
+		arp->ar_hrd = htons(ARPHRD_NETROM);
+		arp->ar_pro = htons(AX25_P_IP);
 		break;
 #endif
 #endif
 
 #ifdef CONFIG_FDDI
 	case ARPHRD_FDDI:
-		arp->ar_hrd = __constant_htons(ARPHRD_ETHER);
-		arp->ar_pro = __constant_htons(ETH_P_IP);
+		arp->ar_hrd = htons(ARPHRD_ETHER);
+		arp->ar_pro = htons(ETH_P_IP);
 		break;
 #endif
 #ifdef CONFIG_TR
 	case ARPHRD_IEEE802_TR:
-		arp->ar_hrd = __constant_htons(ARPHRD_IEEE802);
-		arp->ar_pro = __constant_htons(ETH_P_IP);
+		arp->ar_hrd = htons(ARPHRD_IEEE802);
+		arp->ar_pro = htons(ETH_P_IP);
 		break;
 #endif
 	}
@@ -629,7 +629,7 @@
 
 	switch (dev_type) {
 	default:	
-		if (arp->ar_pro != __constant_htons(ETH_P_IP))
+		if (arp->ar_pro != htons(ETH_P_IP))
 			goto out;
 		if (htons(dev_type) != arp->ar_hrd)
 			goto out;
@@ -640,10 +640,10 @@
 		 * ETHERNET devices will accept ARP hardware types of either
 		 * 1 (Ethernet) or 6 (IEEE 802.2).
 		 */
-		if (arp->ar_hrd != __constant_htons(ARPHRD_ETHER) &&
-		    arp->ar_hrd != __constant_htons(ARPHRD_IEEE802))
+		if (arp->ar_hrd != htons(ARPHRD_ETHER) &&
+		    arp->ar_hrd != htons(ARPHRD_IEEE802))
 			goto out;
-		if (arp->ar_pro != __constant_htons(ETH_P_IP))
+		if (arp->ar_pro != htons(ETH_P_IP))
 			goto out;
 		break;
 #endif
@@ -653,10 +653,10 @@
 		 * Token ring devices will accept ARP hardware types of either
 		 * 1 (Ethernet) or 6 (IEEE 802.2).
 		 */
-		if (arp->ar_hrd != __constant_htons(ARPHRD_ETHER) &&
-		    arp->ar_hrd != __constant_htons(ARPHRD_IEEE802))
+		if (arp->ar_hrd != htons(ARPHRD_ETHER) &&
+		    arp->ar_hrd != htons(ARPHRD_IEEE802))
 			goto out;
-		if (arp->ar_pro != __constant_htons(ETH_P_IP))
+		if (arp->ar_pro != htons(ETH_P_IP))
 			goto out;
 		break;
 #endif
@@ -667,10 +667,10 @@
 		 * of 1 (Ethernet).  However, to be more robust, we'll accept hardware
 		 * types of either 1 (Ethernet) or 6 (IEEE 802.2).
 		 */
-		if (arp->ar_hrd != __constant_htons(ARPHRD_ETHER) &&
-		    arp->ar_hrd != __constant_htons(ARPHRD_IEEE802))
+		if (arp->ar_hrd != htons(ARPHRD_ETHER) &&
+		    arp->ar_hrd != htons(ARPHRD_IEEE802))
 			goto out;
-		if (arp->ar_pro != __constant_htons(ETH_P_IP))
+		if (arp->ar_pro != htons(ETH_P_IP))
 			goto out;
 		break;
 #endif
@@ -681,25 +681,25 @@
 		 * 802 devices) should accept ARP hardware types of 6 (IEEE 802)
 		 * and 1 (Ethernet).
 		 */
-		if (arp->ar_hrd != __constant_htons(ARPHRD_ETHER) &&
-		    arp->ar_hrd != __constant_htons(ARPHRD_IEEE802))
+		if (arp->ar_hrd != htons(ARPHRD_ETHER) &&
+		    arp->ar_hrd != htons(ARPHRD_IEEE802))
 			goto out;
-		if (arp->ar_pro != __constant_htons(ETH_P_IP))
+		if (arp->ar_pro != htons(ETH_P_IP))
 			goto out;
 		break;
 #endif
 #if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
 	case ARPHRD_AX25:
-		if (arp->ar_pro != __constant_htons(AX25_P_IP))
+		if (arp->ar_pro != htons(AX25_P_IP))
 			goto out;
-		if (arp->ar_hrd != __constant_htons(ARPHRD_AX25))
+		if (arp->ar_hrd != htons(ARPHRD_AX25))
 			goto out;
 		break;
 #if defined(CONFIG_NETROM) || defined(CONFIG_NETROM_MODULE)
 	case ARPHRD_NETROM:
-		if (arp->ar_pro != __constant_htons(AX25_P_IP))
+		if (arp->ar_pro != htons(AX25_P_IP))
 			goto out;
-		if (arp->ar_hrd != __constant_htons(ARPHRD_NETROM))
+		if (arp->ar_hrd != htons(ARPHRD_NETROM))
 			goto out;
 		break;
 #endif
@@ -708,8 +708,8 @@
 
 	/* Understand only these message types */
 
-	if (arp->ar_op != __constant_htons(ARPOP_REPLY) &&
-	    arp->ar_op != __constant_htons(ARPOP_REQUEST))
+	if (arp->ar_op != htons(ARPOP_REPLY) &&
+	    arp->ar_op != htons(ARPOP_REQUEST))
 		goto out;
 
 /*
@@ -754,13 +754,13 @@
 
 	/* Special case: IPv4 duplicate address detection packet (RFC2131) */
 	if (sip == 0) {
-		if (arp->ar_op == __constant_htons(ARPOP_REQUEST) &&
+		if (arp->ar_op == htons(ARPOP_REQUEST) &&
 		    inet_addr_type(tip) == RTN_LOCAL)
 			arp_send(ARPOP_REPLY,ETH_P_ARP,tip,dev,tip,sha,dev->dev_addr,dev->dev_addr);
 		goto out;
 	}
 
-	if (arp->ar_op == __constant_htons(ARPOP_REQUEST) &&
+	if (arp->ar_op == htons(ARPOP_REQUEST) &&
 	    ip_route_input(skb, tip, sip, 0, dev) == 0) {
 
 		rt = (struct rtable*)skb->dst;
@@ -810,7 +810,7 @@
 	   devices (strip is candidate)
 	 */
 	if (n == NULL &&
-	    arp->ar_op == __constant_htons(ARPOP_REPLY) &&
+	    arp->ar_op == htons(ARPOP_REPLY) &&
 	    inet_addr_type(sip) == RTN_UNICAST)
 		n = __neigh_lookup(&arp_tbl, &sip, dev, -1);
 #endif
@@ -830,7 +830,7 @@
 		/* Broadcast replies and request packets
 		   do not assert neighbour reachability.
 		 */
-		if (arp->ar_op != __constant_htons(ARPOP_REPLY) ||
+		if (arp->ar_op != htons(ARPOP_REPLY) ||
 		    skb->pkt_type != PACKET_HOST)
 			state = NUD_STALE;
 		neigh_update(n, sha, state, override, 1);
@@ -1050,7 +1050,7 @@
 	    (r.arp_flags & (ATF_NETMASK|ATF_DONTPUB)))
 		return -EINVAL;
 	if (!(r.arp_flags & ATF_NETMASK))
-		((struct sockaddr_in *)&r.arp_netmask)->sin_addr.s_addr=__constant_htonl(0xFFFFFFFFUL);
+		((struct sockaddr_in *)&r.arp_netmask)->sin_addr.s_addr=htonl(0xFFFFFFFFUL);
 
 	rtnl_lock();
 	if (r.arp_dev[0]) {
Index: net/ipv4/igmp.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/igmp.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/igmp.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/igmp.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -229,7 +229,7 @@
 	iph->version  = 4;
 	iph->ihl      = (sizeof(struct iphdr)+4)>>2;
 	iph->tos      = 0;
-	iph->frag_off = __constant_htons(IP_DF);
+	iph->frag_off = htons(IP_DF);
 	iph->ttl      = 1;
 	iph->daddr    = dst;
 	iph->saddr    = rt->rt_src;
Index: net/ipv4/ip_gre.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/ip_gre.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/ip_gre.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/ip_gre.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -412,7 +412,7 @@
 	struct sk_buff *skb2;
 	struct rtable *rt;
 
-	if (p[1] != __constant_htons(ETH_P_IP))
+	if (p[1] != htons(ETH_P_IP))
 		return;
 
 	flags = p[0];
@@ -535,10 +535,10 @@
 static inline void ipgre_ecn_decapsulate(struct iphdr *iph, struct sk_buff *skb)
 {
 	if (INET_ECN_is_ce(iph->tos)) {
-		if (skb->protocol == __constant_htons(ETH_P_IP)) {
+		if (skb->protocol == htons(ETH_P_IP)) {
 			if (INET_ECN_is_not_ce(skb->nh.iph->tos))
 				IP_ECN_set_ce(skb->nh.iph);
-		} else if (skb->protocol == __constant_htons(ETH_P_IPV6)) {
+		} else if (skb->protocol == htons(ETH_P_IPV6)) {
 			if (INET_ECN_is_not_ce(ip6_get_dsfield(skb->nh.ipv6h)))
 				IP6_ECN_set_ce(skb->nh.ipv6h);
 		}
@@ -549,9 +549,9 @@
 ipgre_ecn_encapsulate(u8 tos, struct iphdr *old_iph, struct sk_buff *skb)
 {
 	u8 inner = 0;
-	if (skb->protocol == __constant_htons(ETH_P_IP))
+	if (skb->protocol == htons(ETH_P_IP))
 		inner = old_iph->tos;
-	else if (skb->protocol == __constant_htons(ETH_P_IPV6))
+	else if (skb->protocol == htons(ETH_P_IPV6))
 		inner = ip6_get_dsfield((struct ipv6hdr*)old_iph);
 	return INET_ECN_encapsulate(tos, inner);
 }
@@ -708,13 +708,13 @@
 			goto tx_error;
 		}
 
-		if (skb->protocol == __constant_htons(ETH_P_IP)) {
+		if (skb->protocol == htons(ETH_P_IP)) {
 			rt = (struct rtable*)skb->dst;
 			if ((dst = rt->rt_gateway) == 0)
 				goto tx_error_icmp;
 		}
 #ifdef CONFIG_IPV6
-		else if (skb->protocol == __constant_htons(ETH_P_IPV6)) {
+		else if (skb->protocol == htons(ETH_P_IPV6)) {
 			struct in6_addr *addr6;
 			int addr_type;
 			struct neighbour *neigh = skb->dst->neighbour;
@@ -742,7 +742,7 @@
 
 	tos = tiph->tos;
 	if (tos&1) {
-		if (skb->protocol == __constant_htons(ETH_P_IP))
+		if (skb->protocol == htons(ETH_P_IP))
 			tos = old_iph->tos;
 		tos &= ~1;
 	}
@@ -765,13 +765,13 @@
 	else
 		mtu = skb->dst ? skb->dst->pmtu : dev->mtu;
 
-	if (skb->protocol == __constant_htons(ETH_P_IP)) {
+	if (skb->protocol == htons(ETH_P_IP)) {
 		if (skb->dst && mtu < skb->dst->pmtu && mtu >= 68)
 			skb->dst->pmtu = mtu;
 
-		df |= (old_iph->frag_off&__constant_htons(IP_DF));
+		df |= (old_iph->frag_off&htons(IP_DF));
 
-		if ((old_iph->frag_off&__constant_htons(IP_DF)) &&
+		if ((old_iph->frag_off&htons(IP_DF)) &&
 		    mtu < ntohs(old_iph->tot_len)) {
 			icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED, htonl(mtu));
 			ip_rt_put(rt);
@@ -779,7 +779,7 @@
 		}
 	}
 #ifdef CONFIG_IPV6
-	else if (skb->protocol == __constant_htons(ETH_P_IPV6)) {
+	else if (skb->protocol == htons(ETH_P_IPV6)) {
 		struct rt6_info *rt6 = (struct rt6_info*)skb->dst;
 
 		if (rt6 && mtu < rt6->u.dst.pmtu && mtu >= IPV6_MIN_MTU) {
@@ -845,10 +845,10 @@
 	iph->saddr		=	rt->rt_src;
 
 	if ((iph->ttl = tiph->ttl) == 0) {
-		if (skb->protocol == __constant_htons(ETH_P_IP))
+		if (skb->protocol == htons(ETH_P_IP))
 			iph->ttl = old_iph->ttl;
 #ifdef CONFIG_IPV6
-		else if (skb->protocol == __constant_htons(ETH_P_IPV6))
+		else if (skb->protocol == htons(ETH_P_IPV6))
 			iph->ttl = ((struct ipv6hdr*)old_iph)->hop_limit;
 #endif
 		else
@@ -936,11 +936,11 @@
 
 		err = -EINVAL;
 		if (p.iph.version != 4 || p.iph.protocol != IPPROTO_GRE ||
-		    p.iph.ihl != 5 || (p.iph.frag_off&__constant_htons(~IP_DF)) ||
+		    p.iph.ihl != 5 || (p.iph.frag_off&htons(~IP_DF)) ||
 		    ((p.i_flags|p.o_flags)&(GRE_VERSION|GRE_ROUTING)))
 			goto done;
 		if (p.iph.ttl)
-			p.iph.frag_off |= __constant_htons(IP_DF);
+			p.iph.frag_off |= htons(IP_DF);
 
 		if (!(p.i_flags&GRE_KEY))
 			p.i_key = 0;
Index: net/ipv4/ip_output.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/ip_output.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/ip_output.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/ip_output.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -186,7 +186,7 @@
 	struct net_device *dev = skb->dst->dev;
 
 	skb->dev = dev;
-	skb->protocol = __constant_htons(ETH_P_IP);
+	skb->protocol = htons(ETH_P_IP);
 
 	return NF_HOOK(PF_INET, NF_IP_POST_ROUTING, skb, NULL, dev,
 		       ip_finish_output2);
@@ -208,7 +208,7 @@
 #endif
 
 	skb->dev = dev;
-	skb->protocol = __constant_htons(ETH_P_IP);
+	skb->protocol = htons(ETH_P_IP);
 
 	/*
 	 *	Multicasts are looped back for other local users
@@ -382,7 +382,7 @@
 	*((__u16 *)iph)	= htons((4 << 12) | (5 << 8) | (sk->protinfo.af_inet.tos & 0xff));
 	iph->tot_len = htons(skb->len);
 	if (ip_dont_fragment(sk, &rt->u.dst))
-		iph->frag_off = __constant_htons(IP_DF);
+		iph->frag_off = htons(IP_DF);
 	else
 		iph->frag_off = 0;
 	iph->ttl      = sk->protinfo.af_inet.ttl;
Index: net/ipv4/ipconfig.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/ipconfig.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/ipconfig.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/ipconfig.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -356,11 +356,11 @@
 
 	if (ic_netmask == INADDR_NONE) {
 		if (IN_CLASSA(ntohl(ic_myaddr)))
-			ic_netmask = __constant_htonl(IN_CLASSA_NET);
+			ic_netmask = htonl(IN_CLASSA_NET);
 		else if (IN_CLASSB(ntohl(ic_myaddr)))
-			ic_netmask = __constant_htonl(IN_CLASSB_NET);
+			ic_netmask = htonl(IN_CLASSB_NET);
 		else if (IN_CLASSC(ntohl(ic_myaddr)))
-			ic_netmask = __constant_htonl(IN_CLASSC_NET);
+			ic_netmask = htonl(IN_CLASSC_NET);
 		else {
 			printk(KERN_ERR "IP-Config: Unable to guess netmask for address %u.%u.%u.%u\n",
 				NIPQUAD(ic_myaddr));
@@ -426,11 +426,11 @@
 		goto drop;
 
 	/* If it's not a RARP reply, delete it. */
-	if (rarp->ar_op != __constant_htons(ARPOP_RREPLY))
+	if (rarp->ar_op != htons(ARPOP_RREPLY))
 		goto drop;
 
 	/* If it's not Ethernet, delete it. */
-	if (rarp->ar_pro != __constant_htons(ETH_P_IP))
+	if (rarp->ar_pro != htons(ETH_P_IP))
 		goto drop;
 
 	/* Extract variable-width fields */
@@ -661,15 +661,15 @@
 	h->version = 4;
 	h->ihl = 5;
 	h->tot_len = htons(sizeof(struct bootp_pkt));
-	h->frag_off = __constant_htons(IP_DF);
+	h->frag_off = htons(IP_DF);
 	h->ttl = 64;
 	h->protocol = IPPROTO_UDP;
 	h->daddr = INADDR_BROADCAST;
 	h->check = ip_fast_csum((unsigned char *) h, h->ihl);
 
 	/* Construct UDP header */
-	b->udph.source = __constant_htons(68);
-	b->udph.dest = __constant_htons(67);
+	b->udph.source = htons(68);
+	b->udph.dest = htons(67);
 	b->udph.len = htons(sizeof(struct bootp_pkt) - sizeof(struct iphdr));
 	/* UDP checksum not calculated -- explicitly allowed in BOOTP RFC */
 
@@ -700,7 +700,7 @@
 
 	/* Chain packet down the line... */
 	skb->dev = dev;
-	skb->protocol = __constant_htons(ETH_P_IP);
+	skb->protocol = htons(ETH_P_IP);
 	if ((dev->hard_header &&
 	     dev->hard_header(skb, dev, ntohs(skb->protocol), dev->broadcast, dev->dev_addr, skb->len) < 0) ||
 	    dev_queue_xmit(skb) < 0)
@@ -800,13 +800,13 @@
 	    ip_fast_csum((char *) h, h->ihl) != 0 ||
 	    skb->len < ntohs(h->tot_len) ||
 	    h->protocol != IPPROTO_UDP ||
-	    b->udph.source != __constant_htons(67) ||
-	    b->udph.dest != __constant_htons(68) ||
+	    b->udph.source != htons(67) ||
+	    b->udph.dest != htons(68) ||
 	    ntohs(h->tot_len) < ntohs(b->udph.len) + sizeof(struct iphdr))
 		goto drop;
 
 	/* Fragments are not supported */
-	if (h->frag_off & __constant_htons(IP_OFFSET | IP_MF)) {
+	if (h->frag_off & htons(IP_OFFSET | IP_MF)) {
 		printk(KERN_ERR "DHCP/BOOTP: Ignoring fragmented reply.\n");
 		goto drop;
 	}
Index: net/ipv4/ipip.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/ipip.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/ipip.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/ipip.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -483,7 +483,7 @@
 	skb->mac.raw = skb->nh.raw;
 	skb->nh.raw = skb->data;
 	memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
-	skb->protocol = __constant_htons(ETH_P_IP);
+	skb->protocol = htons(ETH_P_IP);
 	skb->pkt_type = PACKET_HOST;
 
 	read_lock(&ipip_lock);
@@ -544,7 +544,7 @@
 		goto tx_error;
 	}
 
-	if (skb->protocol != __constant_htons(ETH_P_IP))
+	if (skb->protocol != htons(ETH_P_IP))
 		goto tx_error;
 
 	if (tos&1)
@@ -585,9 +585,9 @@
 	if (skb->dst && mtu < skb->dst->pmtu)
 		skb->dst->pmtu = mtu;
 
-	df |= (old_iph->frag_off&__constant_htons(IP_DF));
+	df |= (old_iph->frag_off&htons(IP_DF));
 
-	if ((old_iph->frag_off&__constant_htons(IP_DF)) && mtu < ntohs(old_iph->tot_len)) {
+	if ((old_iph->frag_off&htons(IP_DF)) && mtu < ntohs(old_iph->tot_len)) {
 		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED, htonl(mtu));
 		ip_rt_put(rt);
 		goto tx_error;
@@ -703,10 +703,10 @@
 
 		err = -EINVAL;
 		if (p.iph.version != 4 || p.iph.protocol != IPPROTO_IPIP ||
-		    p.iph.ihl != 5 || (p.iph.frag_off&__constant_htons(~IP_DF)))
+		    p.iph.ihl != 5 || (p.iph.frag_off&htons(~IP_DF)))
 			goto done;
 		if (p.iph.ttl)
-			p.iph.frag_off |= __constant_htons(IP_DF);
+			p.iph.frag_off |= htons(IP_DF);
 
 		t = ipip_tunnel_locate(&p, cmd == SIOCADDTUNNEL);
 
Index: net/ipv4/ipmr.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/ipmr.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/ipmr.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/ipmr.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -1434,7 +1434,7 @@
 	skb->nh.iph = (struct iphdr *)skb->data;
 	skb->dev = reg_dev;
 	memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
-	skb->protocol = __constant_htons(ETH_P_IP);
+	skb->protocol = htons(ETH_P_IP);
 	skb->ip_summed = 0;
 	skb->pkt_type = PACKET_HOST;
 	dst_release(skb->dst);
@@ -1501,7 +1501,7 @@
 	skb->nh.iph = (struct iphdr *)skb->data;
 	skb->dev = reg_dev;
 	memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
-	skb->protocol = __constant_htons(ETH_P_IP);
+	skb->protocol = htons(ETH_P_IP);
 	skb->ip_summed = 0;
 	skb->pkt_type = PACKET_HOST;
 	dst_release(skb->dst);
Index: net/ipv4/route.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/route.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/route.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/route.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -1246,7 +1246,7 @@
 		return -EINVAL;
 
 	if (MULTICAST(saddr) || BADCLASS(saddr) || LOOPBACK(saddr) ||
-	    skb->protocol != __constant_htons(ETH_P_IP))
+	    skb->protocol != htons(ETH_P_IP))
 		goto e_inval;
 
 	if (ZERONET(saddr)) {
@@ -1457,7 +1457,7 @@
 	     inet_addr_onlink(out_dev, saddr, FIB_RES_GW(res))))
 		flags |= RTCF_DOREDIRECT;
 
-	if (skb->protocol != __constant_htons(ETH_P_IP)) {
+	if (skb->protocol != htons(ETH_P_IP)) {
 		/* Not IP (i.e. ARP). Do not create route, if it is
 		 * invalid for proxy arp. DNAT routes are always valid.
 		 */
@@ -1522,7 +1522,7 @@
 out:	return err;
 
 brd_input:
-	if (skb->protocol != __constant_htons(ETH_P_IP))
+	if (skb->protocol != htons(ETH_P_IP))
 		goto e_inval;
 
 	if (ZERONET(saddr))
@@ -2156,7 +2156,7 @@
 		err = -ENODEV;
 		if (!dev)
 			goto out;
-		skb->protocol	= __constant_htons(ETH_P_IP);
+		skb->protocol	= htons(ETH_P_IP);
 		skb->dev	= dev;
 		local_bh_disable();
 		err = ip_route_input(skb, dst, src, rtm->rtm_tos, dev);
Index: net/ipv4/tcp_diag.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/tcp_diag.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/tcp_diag.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/tcp_diag.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -346,7 +346,7 @@
 				break;
 			if (sk->family == AF_INET6 && cond->family == AF_INET) {
 				if (addr[0] == 0 && addr[1] == 0 &&
-				    addr[2] == __constant_htonl(0xffff) &&
+				    addr[2] == htonl(0xffff) &&
 				    bitstring_match(addr+3, cond->addr, cond->prefix_len))
 					break;
 			}
Index: net/ipv4/tcp_input.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/tcp_input.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/tcp_input.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/tcp_input.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -2083,8 +2083,8 @@
 	} else if (tp->tstamp_ok &&
 		   th->doff == (sizeof(struct tcphdr)>>2)+(TCPOLEN_TSTAMP_ALIGNED>>2)) {
 		__u32 *ptr = (__u32 *)(th + 1);
-		if (*ptr == __constant_ntohl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16)
-					     | (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP)) {
+		if (*ptr == ntohl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16)
+				  | (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP)) {
 			tp->saw_tstamp = 1;
 			++ptr;
 			tp->rcv_tsval = ntohl(*ptr);
@@ -3252,8 +3252,8 @@
 			__u32 *ptr = (__u32 *)(th + 1);
 
 			/* No? Slow path! */
-			if (*ptr != __constant_ntohl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16)
-						     | (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP))
+			if (*ptr != ntohl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16)
+					   | (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP))
 				goto slow_path;
 
 			tp->saw_tstamp = 1;
Index: net/ipv4/tcp_ipv4.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/tcp_ipv4.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/tcp_ipv4.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/tcp_ipv4.c	2002/10/03 22:05:55	1.1.1.1.12.1
@@ -1210,10 +1210,10 @@
 	arg.iov[0].iov_len  = sizeof(rep.th);
 	arg.n_iov = 1;
 	if (ts) {
-		rep.tsopt[0] = __constant_htonl((TCPOPT_NOP << 24) |
-						(TCPOPT_NOP << 16) |
-						(TCPOPT_TIMESTAMP << 8) |
-						TCPOLEN_TIMESTAMP);
+		rep.tsopt[0] = htonl((TCPOPT_NOP << 24) |
+				     (TCPOPT_NOP << 16) |
+				     (TCPOPT_TIMESTAMP << 8) |
+				     TCPOLEN_TIMESTAMP);
 		rep.tsopt[1] = htonl(tcp_time_stamp);
 		rep.tsopt[2] = htonl(ts);
 		arg.iov[0].iov_len = sizeof(rep);
Index: net/ipv4/netfilter/ip_nat_core.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/netfilter/ip_nat_core.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/netfilter/ip_nat_core.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/netfilter/ip_nat_core.c	2002/10/03 22:13:47	1.1.1.1.12.1
@@ -775,7 +775,7 @@
 	if (helper) {
 		/* Always defragged for helpers */
 		IP_NF_ASSERT(!((*pskb)->nh.iph->frag_off
-			       & __constant_htons(IP_MF|IP_OFFSET)));
+			       & htons(IP_MF|IP_OFFSET)));
 		return helper->help(ct, info, ctinfo, hooknum, pskb);
 	} else return NF_ACCEPT;
 }
Index: net/ipv4/netfilter/ip_nat_snmp_basic.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/netfilter/ip_nat_snmp_basic.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/netfilter/ip_nat_snmp_basic.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/netfilter/ip_nat_snmp_basic.c	2002/10/03 22:13:47	1.1.1.1.12.1
@@ -1259,9 +1259,9 @@
 	 * on post routing (SNAT).
 	 */
 	if (!((dir == IP_CT_DIR_REPLY && hooknum == NF_IP_PRE_ROUTING &&
-			udph->source == __constant_ntohs(SNMP_PORT)) ||
+			udph->source == ntohs(SNMP_PORT)) ||
 	      (dir == IP_CT_DIR_ORIGINAL && hooknum == NF_IP_POST_ROUTING &&
-	      		udph->dest == __constant_ntohs(SNMP_TRAP_PORT)))) {
+	      		udph->dest == ntohs(SNMP_TRAP_PORT)))) {
 		spin_unlock_bh(&snmp_lock);
 		return NF_ACCEPT;
 	}
Index: net/ipv4/netfilter/ip_nat_standalone.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/netfilter/ip_nat_standalone.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv4/netfilter/ip_nat_standalone.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv4/netfilter/ip_nat_standalone.c	2002/10/03 22:13:47	1.1.1.1.12.1
@@ -60,7 +60,7 @@
 	/* We never see fragments: conntrack defrags on pre-routing
 	   and local-out, and ip_nat_out protects post-routing. */
 	IP_NF_ASSERT(!((*pskb)->nh.iph->frag_off
-		       & __constant_htons(IP_MF|IP_OFFSET)));
+		       & htons(IP_MF|IP_OFFSET)));
 
 	(*pskb)->nfcache |= NFC_UNKNOWN;
 
@@ -163,7 +163,7 @@
 
 	   I'm starting to have nightmares about fragments.  */
 
-	if ((*pskb)->nh.iph->frag_off & __constant_htons(IP_MF|IP_OFFSET)) {
+	if ((*pskb)->nh.iph->frag_off & htons(IP_MF|IP_OFFSET)) {
 		*pskb = ip_ct_gather_frags(*pskb);
 
 		if (!*pskb)
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 addrconf.c
--- net/ipv6/addrconf.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/addrconf.c	2002/10/03 22:16:13
@@ -172,7 +172,7 @@
 
 	if ((addr->s6_addr32[0] | addr->s6_addr32[1]) == 0) {
 		if (addr->s6_addr32[2] == 0) {
-			if (addr->in6_u.u6_addr32[3] == 0)
+			if (addr->s6_addr32[3] == 0)
 				return IPV6_ADDR_ANY;
 
 			if (addr->s6_addr32[3] == __constant_htonl(0x00000001))
@@ -1187,7 +1187,7 @@
 	ASSERT_RTNL();
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-	addr.s6_addr[15] = 1;
+	addr.s6_addr32[3] = __constant_htonl(0x00000001);
 
 	if ((idev = ipv6_find_idev(dev)) == NULL) {
 		printk(KERN_DEBUG "init loopback: add_dev failed\n");
@@ -1234,9 +1234,7 @@
 		return;
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-
-	addr.s6_addr[0] = 0xFE;
-	addr.s6_addr[1] = 0x80;
+	addr.s6_addr32[0] = __contant_htonl(0xFE800000);
 
 	if (ipv6_generate_eui64(addr.s6_addr + 8, dev) == 0)
 		addrconf_add_linklocal(idev, &addr);
Index: net/ipv6/icmp.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/icmp.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv6/icmp.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/icmp.c	2002/09/12 09:41:58	1.1.1.1.12.1
@@ -198,7 +198,7 @@
 		u8 type;
 		if (skb_copy_bits(skb, ptr+offsetof(struct icmp6hdr, icmp6_type),
 				  &type, 1)
-		    || !(type & 0x80))
+		    || !(type & ICMPV6_INFOMSG_MASK))
 			return 1;
 	}
 	return 0;
@@ -216,7 +216,7 @@
 	int res = 0;
 
 	/* Informational messages are not limited. */
-	if (type & 0x80)
+	if (type & ICMPV6_INFOMSG_MASK)
 		return 1;
 
 	/* Do not limit pmtu discovery, it would break it. */
@@ -519,22 +519,22 @@
 				    skb_checksum(skb, 0, skb->len, 0))) {
 			if (net_ratelimit())
 				printk(KERN_DEBUG "ICMPv6 checksum failed [%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x > %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x]\n",
-				       ntohs(saddr->in6_u.u6_addr16[0]),
-				       ntohs(saddr->in6_u.u6_addr16[1]),
-				       ntohs(saddr->in6_u.u6_addr16[2]),
-				       ntohs(saddr->in6_u.u6_addr16[3]),
-				       ntohs(saddr->in6_u.u6_addr16[4]),
-				       ntohs(saddr->in6_u.u6_addr16[5]),
-				       ntohs(saddr->in6_u.u6_addr16[6]),
-				       ntohs(saddr->in6_u.u6_addr16[7]),
-				       ntohs(daddr->in6_u.u6_addr16[0]),
-				       ntohs(daddr->in6_u.u6_addr16[1]),
-				       ntohs(daddr->in6_u.u6_addr16[2]),
-				       ntohs(daddr->in6_u.u6_addr16[3]),
-				       ntohs(daddr->in6_u.u6_addr16[4]),
-				       ntohs(daddr->in6_u.u6_addr16[5]),
-				       ntohs(daddr->in6_u.u6_addr16[6]),
-				       ntohs(daddr->in6_u.u6_addr16[7]));
+				       ntohs(saddr->s6_addr16[0]),
+				       ntohs(saddr->s6_addr16[1]),
+				       ntohs(saddr->s6_addr16[2]),
+				       ntohs(saddr->s6_addr16[3]),
+				       ntohs(saddr->s6_addr16[4]),
+				       ntohs(saddr->s6_addr16[5]),
+				       ntohs(saddr->s6_addr16[6]),
+				       ntohs(saddr->s6_addr16[7]),
+				       ntohs(daddr->s6_addr16[0]),
+				       ntohs(daddr->s6_addr16[1]),
+				       ntohs(daddr->s6_addr16[2]),
+				       ntohs(daddr->s6_addr16[3]),
+				       ntohs(daddr->s6_addr16[4]),
+				       ntohs(daddr->s6_addr16[5]),
+				       ntohs(daddr->s6_addr16[6]),
+				       ntohs(daddr->s6_addr16[7]));
 			goto discard_it;
 		}
 	}
@@ -613,7 +613,7 @@
 			printk(KERN_DEBUG "icmpv6: msg of unkown type\n");
 
 		/* informational */
-		if (type & 0x80)
+		if (type & ICMPV6_INFOMSG_MASK)
 			break;
 
 		/* 
Index: net/ipv6/netfilter/ip6_queue.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/netfilter/ip6_queue.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.2
diff -u -r1.1.1.1 -r1.1.1.1.12.2
--- net/ipv6/netfilter/ip6_queue.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/netfilter/ip6_queue.c	2002/09/19 03:57:51	1.1.1.1.12.2
@@ -306,14 +306,8 @@
 	 */
 	if (e->info->hook == NF_IP_LOCAL_OUT) {
 		struct ipv6hdr *iph = e->skb->nh.ipv6h;
-		if (!(   iph->daddr.in6_u.u6_addr32[0] == e->rt_info.daddr.in6_u.u6_addr32[0]
-                      && iph->daddr.in6_u.u6_addr32[1] == e->rt_info.daddr.in6_u.u6_addr32[1]
-                      && iph->daddr.in6_u.u6_addr32[2] == e->rt_info.daddr.in6_u.u6_addr32[2]
-                      && iph->daddr.in6_u.u6_addr32[3] == e->rt_info.daddr.in6_u.u6_addr32[3]
-		      && iph->saddr.in6_u.u6_addr32[0] == e->rt_info.saddr.in6_u.u6_addr32[0]
-		      && iph->saddr.in6_u.u6_addr32[1] == e->rt_info.saddr.in6_u.u6_addr32[1]
-		      && iph->saddr.in6_u.u6_addr32[2] == e->rt_info.saddr.in6_u.u6_addr32[2]
-		      && iph->saddr.in6_u.u6_addr32[3] == e->rt_info.saddr.in6_u.u6_addr32[3]))
+		if (ipv6_addr_cmp(&iph->daddr, &e->rt_info.daddr) ||
+		    ipv6_addr_cmp(&iph->saddr, &e->rt_info.saddr))
 			return route6_me_harder(e->skb);
 	}
 	return 0;
Index: net/ipv6/netfilter/ip6t_LOG.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/netfilter/ip6t_LOG.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv6/netfilter/ip6t_LOG.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/netfilter/ip6t_LOG.c	2002/10/03 22:07:26	1.1.1.1.12.1
@@ -112,7 +112,7 @@
 			printk("FRAG:%u ", ntohs(fhdr->frag_off) & 0xFFF8);
 
 			/* Max length: 11 "INCOMPLETE " */
-			if (fhdr->frag_off & __constant_htons(0x0001))
+			if (fhdr->frag_off & htons(0x0001))
 				printk("INCOMPLETE ");
 
 			printk("ID:%08x ", fhdr->identification);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
