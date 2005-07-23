Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVGWSEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVGWSEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 14:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVGWSEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 14:04:51 -0400
Received: from widget.mcdonald.org.uk ([81.187.229.140]:45717 "EHLO
	widget.mcdonald.org.uk") by vger.kernel.org with ESMTP
	id S261422AbVGWSEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 14:04:49 -0400
Date: Sat, 23 Jul 2005 19:04:43 +0100
From: Andrew McDonald <andrew@mcdonald.org.uk>
To: netdev@vger.kernel.org
Cc: yoshfuji@linux-ipv6.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13rc3] IPv6: Check interface bindings on IPv6 raw socket reception
Message-ID: <20050723180442.GB6731@mcdonald.org.uk>
Mail-Followup-To: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take account of whether a socket is bound to a particular device when
selecting an IPv6 raw socket to receive a packet. Also perform this
check when receiving IPv6 packets with router alert options.

Signed-off-by: Andrew McDonald <andrew@mcdonald.org.uk>

diff -uprN linux-2.6.13-rc3.orig/include/net/rawv6.h linux-2.6.13-rc3/include/net/rawv6.h
--- linux-2.6.13-rc3.orig/include/net/rawv6.h	2004-10-18 22:53:52.000000000 +0100
+++ linux-2.6.13-rc3/include/net/rawv6.h	2005-07-23 13:18:46.000000000 +0100
@@ -10,7 +10,8 @@ extern rwlock_t raw_v6_lock;
 extern void ipv6_raw_deliver(struct sk_buff *skb, int nexthdr);
 
 extern struct sock *__raw_v6_lookup(struct sock *sk, unsigned short num,
-				    struct in6_addr *loc_addr, struct in6_addr *rmt_addr);
+				    struct in6_addr *loc_addr, struct in6_addr *rmt_addr,
+				    int dif);
 
 extern int			rawv6_rcv(struct sock *sk,
 					  struct sk_buff *skb);
diff -uprN linux-2.6.13-rc3.orig/net/ipv6/icmp.c linux-2.6.13-rc3/net/ipv6/icmp.c
--- linux-2.6.13-rc3.orig/net/ipv6/icmp.c	2005-07-23 10:28:47.000000000 +0100
+++ linux-2.6.13-rc3/net/ipv6/icmp.c	2005-07-23 13:23:03.000000000 +0100
@@ -551,7 +551,8 @@ static void icmpv6_notify(struct sk_buff
 
 	read_lock(&raw_v6_lock);
 	if ((sk = sk_head(&raw_v6_htable[hash])) != NULL) {
-		while((sk = __raw_v6_lookup(sk, nexthdr, daddr, saddr))) {
+		while((sk = __raw_v6_lookup(sk, nexthdr, daddr, saddr,
+					    skb->dev->ifindex))) {
 			rawv6_err(sk, skb, NULL, type, code, inner_offset, info);
 			sk = sk_next(sk);
 		}
diff -uprN linux-2.6.13-rc3.orig/net/ipv6/ip6_output.c linux-2.6.13-rc3/net/ipv6/ip6_output.c
--- linux-2.6.13-rc3.orig/net/ipv6/ip6_output.c	2005-07-23 10:29:40.000000000 +0100
+++ linux-2.6.13-rc3/net/ipv6/ip6_output.c	2005-07-23 12:37:34.000000000 +0100
@@ -321,7 +321,9 @@ static int ip6_call_ra_chain(struct sk_b
 	read_lock(&ip6_ra_lock);
 	for (ra = ip6_ra_chain; ra; ra = ra->next) {
 		struct sock *sk = ra->sk;
-		if (sk && ra->sel == sel) {
+		if (sk && ra->sel == sel &&
+		    (!sk->sk_bound_dev_if ||
+		     sk->sk_bound_dev_if == skb->dev->ifindex)) {
 			if (last) {
 				struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
 				if (skb2)
diff -uprN linux-2.6.13-rc3.orig/net/ipv6/raw.c linux-2.6.13-rc3/net/ipv6/raw.c
--- linux-2.6.13-rc3.orig/net/ipv6/raw.c	2005-07-23 10:29:40.000000000 +0100
+++ linux-2.6.13-rc3/net/ipv6/raw.c	2005-07-23 17:07:58.000000000 +0100
@@ -81,7 +81,8 @@ static void raw_v6_unhash(struct sock *s
 
 /* Grumble... icmp and ip_input want to get at this... */
 struct sock *__raw_v6_lookup(struct sock *sk, unsigned short num,
-			     struct in6_addr *loc_addr, struct in6_addr *rmt_addr)
+			     struct in6_addr *loc_addr, struct in6_addr *rmt_addr,
+			     int dif)
 {
 	struct hlist_node *node;
 	int is_multicast = ipv6_addr_is_multicast(loc_addr);
@@ -94,6 +95,9 @@ struct sock *__raw_v6_lookup(struct sock
 			    !ipv6_addr_equal(&np->daddr, rmt_addr))
 				continue;
 
+			if (sk->sk_bound_dev_if && sk->sk_bound_dev_if != dif)
+				continue;
+
 			if (!ipv6_addr_any(&np->rcv_saddr)) {
 				if (ipv6_addr_equal(&np->rcv_saddr, loc_addr))
 					goto found;
@@ -160,7 +164,7 @@ void ipv6_raw_deliver(struct sk_buff *sk
 	if (sk == NULL)
 		goto out;
 
-	sk = __raw_v6_lookup(sk, nexthdr, daddr, saddr);
+	sk = __raw_v6_lookup(sk, nexthdr, daddr, saddr, skb->dev->ifindex);
 
 	while (sk) {
 		if (nexthdr != IPPROTO_ICMPV6 || !icmpv6_filter(sk, skb)) {
@@ -170,7 +174,8 @@ void ipv6_raw_deliver(struct sk_buff *sk
 			if (clone)
 				rawv6_rcv(sk, clone);
 		}
-		sk = __raw_v6_lookup(sk_next(sk), nexthdr, daddr, saddr);
+		sk = __raw_v6_lookup(sk_next(sk), nexthdr, daddr, saddr,
+				     skb->dev->ifindex);
 	}
 out:
 	read_unlock(&raw_v6_lock);
