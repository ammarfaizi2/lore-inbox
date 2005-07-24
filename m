Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVGXAYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVGXAYa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 20:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVGXAY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 20:24:29 -0400
Received: from wifi.tel-ott.com ([72.1.193.4]:38327 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262105AbVGXAY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 20:24:27 -0400
Message-ID: <42E2DFAE.8070101@trash.net>
Date: Sun, 24 Jul 2005 02:24:14 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew McDonald <andrew@mcdonald.org.uk>
CC: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13rc3] IPv6: Check interface bindings on IPv6 raw
 socket reception
References: <20050723180442.GB6731@mcdonald.org.uk>
In-Reply-To: <20050723180442.GB6731@mcdonald.org.uk>
Content-Type: multipart/mixed;
 boundary="------------080706060409020605050900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080706060409020605050900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew McDonald wrote:
> Take account of whether a socket is bound to a particular device when
> selecting an IPv6 raw socket to receive a packet. Also perform this
> check when receiving IPv6 packets with router alert options.

I guess this one makes sense on top.


--------------080706060409020605050900
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[IPV4/6]: Check if packet was actually delivered to a raw socket to decide whether to send an ICMP unreachable

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 0fc074eed6ad201d76392dcabbc156784570ea64
tree 913c87ad866f4abb23e9788c0170b81b564cfe7a
parent 36245c9aaddbed7e50d9600c8d1889ebee48a90f
author Patrick McHardy <kaber@trash.net> Sun, 24 Jul 2005 02:23:25 +0200
committer Patrick McHardy <kaber@trash.net> Sun, 24 Jul 2005 02:23:25 +0200

 include/net/raw.h    |    2 +-
 include/net/rawv6.h  |    2 +-
 net/ipv4/ip_input.c  |    4 ++--
 net/ipv4/raw.c       |    8 ++++++--
 net/ipv6/ip6_input.c |    4 ++--
 net/ipv6/raw.c       |    8 ++++++--
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/net/raw.h b/include/net/raw.h
--- a/include/net/raw.h
+++ b/include/net/raw.h
@@ -37,6 +37,6 @@ extern struct sock *__raw_v4_lookup(stru
 				    unsigned long raddr, unsigned long laddr,
 				    int dif);
 
-extern void raw_v4_input(struct sk_buff *skb, struct iphdr *iph, int hash);
+extern int raw_v4_input(struct sk_buff *skb, struct iphdr *iph, int hash);
 
 #endif	/* _RAW_H */
diff --git a/include/net/rawv6.h b/include/net/rawv6.h
--- a/include/net/rawv6.h
+++ b/include/net/rawv6.h
@@ -7,7 +7,7 @@
 extern struct hlist_head raw_v6_htable[RAWV6_HTABLE_SIZE];
 extern rwlock_t raw_v6_lock;
 
-extern void ipv6_raw_deliver(struct sk_buff *skb, int nexthdr);
+extern int ipv6_raw_deliver(struct sk_buff *skb, int nexthdr);
 
 extern struct sock *__raw_v6_lookup(struct sock *sk, unsigned short num,
 				    struct in6_addr *loc_addr, struct in6_addr *rmt_addr,
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -225,8 +225,8 @@ static inline int ip_local_deliver_finis
 		/* If there maybe a raw socket we must check - if not we
 		 * don't care less
 		 */
-		if (raw_sk)
-			raw_v4_input(skb, skb->nh.iph, hash);
+		if (raw_sk && !raw_v4_input(skb, skb->nh.iph, hash))
+			raw_sk = NULL;
 
 		if ((ipprot = rcu_dereference(inet_protos[hash])) != NULL) {
 			int ret;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -150,10 +150,11 @@ static __inline__ int icmp_filter(struct
  * RFC 1122: SHOULD pass TOS value up to the transport layer.
  * -> It does. And not only TOS, but all IP header.
  */
-void raw_v4_input(struct sk_buff *skb, struct iphdr *iph, int hash)
+int raw_v4_input(struct sk_buff *skb, struct iphdr *iph, int hash)
 {
 	struct sock *sk;
 	struct hlist_head *head;
+	int delivered = 0;
 
 	read_lock(&raw_v4_lock);
 	head = &raw_v4_htable[hash];
@@ -168,8 +169,10 @@ void raw_v4_input(struct sk_buff *skb, s
 			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
 
 			/* Not releasing hash table! */
-			if (clone)
+			if (clone) {
 				raw_rcv(sk, clone);
+				delivered = 1;
+			}
 		}
 		sk = __raw_v4_lookup(sk_next(sk), iph->protocol,
 				     iph->saddr, iph->daddr,
@@ -177,6 +180,7 @@ void raw_v4_input(struct sk_buff *skb, s
 	}
 out:
 	read_unlock(&raw_v4_lock);
+	return delivered;
 }
 
 void raw_err (struct sock *sk, struct sk_buff *skb, u32 info)
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -166,8 +166,8 @@ resubmit:
 	nexthdr = skb->nh.raw[nhoff];
 
 	raw_sk = sk_head(&raw_v6_htable[nexthdr & (MAX_INET_PROTOS - 1)]);
-	if (raw_sk)
-		ipv6_raw_deliver(skb, nexthdr);
+	if (raw_sk && !ipv6_raw_deliver(skb, nexthdr))
+		raw_sk = NULL;
 
 	hash = nexthdr & (MAX_INET_PROTOS - 1);
 	if ((ipprot = rcu_dereference(inet6_protos[hash])) != NULL) {
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -141,11 +141,12 @@ static __inline__ int icmpv6_filter(stru
  *
  *	Caller owns SKB so we must make clones.
  */
-void ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
+int ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 {
 	struct in6_addr *saddr;
 	struct in6_addr *daddr;
 	struct sock *sk;
+	int delivered = 0;
 	__u8 hash;
 
 	saddr = &skb->nh.ipv6h->saddr;
@@ -171,14 +172,17 @@ void ipv6_raw_deliver(struct sk_buff *sk
 			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
 
 			/* Not releasing hash table! */
-			if (clone)
+			if (clone) {
 				rawv6_rcv(sk, clone);
+				delivered = 1;
+			}
 		}
 		sk = __raw_v6_lookup(sk_next(sk), nexthdr, daddr, saddr,
 				     skb->dev->ifindex);
 	}
 out:
 	read_unlock(&raw_v6_lock);
+	return delivered;
 }
 
 /* This cleans up af_inet6 a bit. -DaveM */

--------------080706060409020605050900--
