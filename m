Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758839AbWK2WHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758839AbWK2WHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758270AbWK2WEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:04:30 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2517 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758344AbWK2WEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:04:20 -0500
Message-Id: <20061129220606.993069000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:29 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       David S Miller <davem@davemloft.net>
Subject: [patch 18/23] IPV6: Fix address/interface handling in UDP and DCCP, according to the scoping architecture.
Content-Disposition: inline; filename=ipv6-fix-address-interface-handling-in-udp-and-dccp-according-to-the-scoping-architecture.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

TCP and RAW do not have this issue.  Closes Bug #7432.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/dccp/ipv6.c |    2 +-
 net/ipv6/udp.c  |    7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.18.4.orig/net/dccp/ipv6.c
+++ linux-2.6.18.4/net/dccp/ipv6.c
@@ -276,7 +276,7 @@ static void dccp_v6_err(struct sk_buff *
 	__u64 seq;
 
 	sk = inet6_lookup(&dccp_hashinfo, &hdr->daddr, dh->dccph_dport,
-			  &hdr->saddr, dh->dccph_sport, skb->dev->ifindex);
+			  &hdr->saddr, dh->dccph_sport, inet6_iif(skb));
 
 	if (sk == NULL) {
 		ICMP6_INC_STATS_BH(__in6_dev_get(skb->dev), ICMP6_MIB_INERRORS);
--- linux-2.6.18.4.orig/net/ipv6/udp.c
+++ linux-2.6.18.4/net/ipv6/udp.c
@@ -314,14 +314,13 @@ static void udpv6_err(struct sk_buff *sk
 {
 	struct ipv6_pinfo *np;
 	struct ipv6hdr *hdr = (struct ipv6hdr*)skb->data;
-	struct net_device *dev = skb->dev;
 	struct in6_addr *saddr = &hdr->saddr;
 	struct in6_addr *daddr = &hdr->daddr;
 	struct udphdr *uh = (struct udphdr*)(skb->data+offset);
 	struct sock *sk;
 	int err;
 
-	sk = udp_v6_lookup(daddr, uh->dest, saddr, uh->source, dev->ifindex);
+	sk = udp_v6_lookup(daddr, uh->dest, saddr, uh->source, inet6_iif(skb));
    
 	if (sk == NULL)
 		return;
@@ -415,7 +414,7 @@ static void udpv6_mcast_deliver(struct u
 
 	read_lock(&udp_hash_lock);
 	sk = sk_head(&udp_hash[ntohs(uh->dest) & (UDP_HTABLE_SIZE - 1)]);
-	dif = skb->dev->ifindex;
+	dif = inet6_iif(skb);
 	sk = udp_v6_mcast_next(sk, uh->dest, daddr, uh->source, saddr, dif);
 	if (!sk) {
 		kfree_skb(skb);
@@ -496,7 +495,7 @@ static int udpv6_rcv(struct sk_buff **ps
 	 * check socket cache ... must talk to Alan about his plans
 	 * for sock caches... i'll skip this for now.
 	 */
-	sk = udp_v6_lookup(saddr, uh->source, daddr, uh->dest, dev->ifindex);
+	sk = udp_v6_lookup(saddr, uh->source, daddr, uh->dest, inet6_iif(skb));
 
 	if (sk == NULL) {
 		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))

--
