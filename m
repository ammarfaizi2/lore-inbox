Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758246AbWK2WDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246AbWK2WDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758283AbWK2WCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:02:42 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64945 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758210AbWK2WCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:02:20 -0500
Message-Id: <20061129220357.585139000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net, Ken Brownfield <krb@irridia.com>,
       Simon Horman <horms@verge.net.au>
Subject: [patch 07/23] NETFILTER: Honour source routing for LVS-NAT
Content-Disposition: inline; filename=netfilter-honour-source-routing-for-lvs-nat.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

For policy routing, packets originating from this machine itself may be
routed differently to packets passing through. We want this packet to be
routed as if it came from this machine itself. So re-compute the routing
information using ip_route_me_harder().

This patch is derived from work by Ken Brownfield

This patch (-stable version) also includes commit
b4c4ed175ff0ee816df48571cfa9b73f521964b6 ([NETFILTER]: add type parameter
to ip_route_me_harder), which is a precondition for the fix.

Cc: Ken Brownfield <krb@irridia.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
commit cf08e74a590c945d3c0b95886ea3fad8ff73793d
tree d5c1a44360bb9a4a2d59e37a9f0dc3c6ce0b6c49
parent 6b22b99ecd431b63aece1fa5b1faa01b75a8302e
author Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:25:11 +0100
committer Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:25:11 +0100

 include/linux/netfilter_ipv4.h         |    2 +-
 net/ipv4/ipvs/ip_vs_core.c             |   10 ++++++++++
 net/ipv4/netfilter.c                   |    9 ++++++---
 net/ipv4/netfilter/ip_nat_standalone.c |    3 ++-
 net/ipv4/netfilter/iptable_mangle.c    |    3 ++-
 5 files changed, 21 insertions(+), 6 deletions(-)

--- linux-2.6.18.4.orig/include/linux/netfilter_ipv4.h
+++ linux-2.6.18.4/include/linux/netfilter_ipv4.h
@@ -77,7 +77,7 @@ enum nf_ip_hook_priorities {
 #define SO_ORIGINAL_DST 80
 
 #ifdef __KERNEL__
-extern int ip_route_me_harder(struct sk_buff **pskb);
+extern int ip_route_me_harder(struct sk_buff **pskb, unsigned addr_type);
 extern int ip_xfrm_me_harder(struct sk_buff **pskb);
 extern unsigned int nf_ip_checksum(struct sk_buff *skb, unsigned int hook,
 				   unsigned int dataoff, u_int8_t protocol);
--- linux-2.6.18.4.orig/net/ipv4/ipvs/ip_vs_core.c
+++ linux-2.6.18.4/net/ipv4/ipvs/ip_vs_core.c
@@ -813,6 +813,16 @@ ip_vs_out(unsigned int hooknum, struct s
 	skb->nh.iph->saddr = cp->vaddr;
 	ip_send_check(skb->nh.iph);
 
+ 	/* For policy routing, packets originating from this
+ 	 * machine itself may be routed differently to packets
+ 	 * passing through.  We want this packet to be routed as
+ 	 * if it came from this machine itself.  So re-compute
+ 	 * the routing information.
+ 	 */
+ 	if (ip_route_me_harder(pskb, RTN_LOCAL) != 0)
+ 		goto drop;
+	skb = *pskb;
+
 	IP_VS_DBG_PKT(10, pp, skb, 0, "After SNAT");
 
 	ip_vs_out_stats(cp, skb);
--- linux-2.6.18.4.orig/net/ipv4/netfilter.c
+++ linux-2.6.18.4/net/ipv4/netfilter.c
@@ -8,7 +8,7 @@
 #include <net/ip.h>
 
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
-int ip_route_me_harder(struct sk_buff **pskb)
+int ip_route_me_harder(struct sk_buff **pskb, unsigned addr_type)
 {
 	struct iphdr *iph = (*pskb)->nh.iph;
 	struct rtable *rt;
@@ -16,10 +16,13 @@ int ip_route_me_harder(struct sk_buff **
 	struct dst_entry *odst;
 	unsigned int hh_len;
 
+	if (addr_type == RTN_UNSPEC)
+		addr_type = inet_addr_type(iph->saddr);
+
 	/* some non-standard hacks like ipt_REJECT.c:send_reset() can cause
 	 * packets with foreign saddr to appear on the NF_IP_LOCAL_OUT hook.
 	 */
-	if (inet_addr_type(iph->saddr) == RTN_LOCAL) {
+	if (addr_type == RTN_LOCAL) {
 		fl.nl_u.ip4_u.daddr = iph->daddr;
 		fl.nl_u.ip4_u.saddr = iph->saddr;
 		fl.nl_u.ip4_u.tos = RT_TOS(iph->tos);
@@ -156,7 +159,7 @@ static int nf_ip_reroute(struct sk_buff 
 		if (!(iph->tos == rt_info->tos
 		      && iph->daddr == rt_info->daddr
 		      && iph->saddr == rt_info->saddr))
-			return ip_route_me_harder(pskb);
+			return ip_route_me_harder(pskb, RTN_UNSPEC);
 	}
 	return 0;
 }
--- linux-2.6.18.4.orig/net/ipv4/netfilter/ip_nat_standalone.c
+++ linux-2.6.18.4/net/ipv4/netfilter/ip_nat_standalone.c
@@ -275,7 +275,8 @@ ip_nat_local_fn(unsigned int hooknum,
 		       ct->tuplehash[!dir].tuple.src.u.all
 #endif
 		    )
-			return ip_route_me_harder(pskb) == 0 ? ret : NF_DROP;
+			if (ip_route_me_harder(pskb, RTN_UNSPEC))
+				ret = NF_DROP;
 	}
 	return ret;
 }
--- linux-2.6.18.4.orig/net/ipv4/netfilter/iptable_mangle.c
+++ linux-2.6.18.4/net/ipv4/netfilter/iptable_mangle.c
@@ -157,7 +157,8 @@ ipt_local_hook(unsigned int hook,
 		|| (*pskb)->nfmark != nfmark
 #endif
 		|| (*pskb)->nh.iph->tos != tos))
-		return ip_route_me_harder(pskb) == 0 ? ret : NF_DROP;
+		if (ip_route_me_harder(pskb, RTN_UNSPEC))
+			ret = NF_DROP;
 
 	return ret;
 }

--
