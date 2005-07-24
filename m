Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVGXFja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVGXFja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 01:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVGXFja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 01:39:30 -0400
Received: from wifi.tel-ott.com ([72.1.193.4]:19883 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261903AbVGXFj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 01:39:27 -0400
Message-ID: <42E32980.2090604@trash.net>
Date: Sun, 24 Jul 2005 07:39:12 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: Andrew McDonald <andrew@mcdonald.org.uk>, netdev@vger.kernel.org,
       yoshfuji@linux-ipv6.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13rc3] IPv6: Check interface bindings on IPv6 raw
 socket reception
References: <20050723180442.GB6731@mcdonald.org.uk> <42E2DFAE.8070101@trash.net>
In-Reply-To: <42E2DFAE.8070101@trash.net>
Content-Type: multipart/mixed;
 boundary="------------000007000806090209010404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000007000806090209010404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patrick McHardy wrote:
> Andrew McDonald wrote:
> 
>> Take account of whether a socket is bound to a particular device when
>> selecting an IPv6 raw socket to receive a packet. Also perform this
>> check when receiving IPv6 packets with router alert options.
> 
> I guess this one makes sense on top.
> 
> [IPV4/6]: Check if packet was actually delivered to a raw socket to decide whether to send an ICMP unreachable

The Last patch didn't handle ICMP socket filters correctly, here is a
better one.

If a raw socket is bound to a single device the packet might not be
delivered even though there is a socket in the protocol hash. Send
back an ICMP protocol unreachable in this case.

--------------000007000806090209010404
Content-Type: text/x-patch;
 name="x.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x.diff"

[IPV4/6]: Check if packet was actually delivered to a raw socket to decide whether to send an ICMP unreachable

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit eb82d02518ac3a400663163995097749d91c7c4c
tree 1719713411b5e656ab5926ee633c39c0edfb1108
parent 36245c9aaddbed7e50d9600c8d1889ebee48a90f
author Patrick McHardy <kaber@trash.net> Sun, 24 Jul 2005 06:54:32 +0200
committer Patrick McHardy <kaber@trash.net> Sun, 24 Jul 2005 06:54:32 +0200

 include/net/raw.h    |    2 +-
 include/net/rawv6.h  |    2 +-
 net/ipv4/ip_input.c  |    4 ++--
 net/ipv4/raw.c       |    5 ++++-
 net/ipv6/ip6_input.c |    4 ++--
 net/ipv6/raw.c       |    5 ++++-
 6 files changed, 14 insertions(+), 8 deletions(-)

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
@@ -164,6 +165,7 @@ void raw_v4_input(struct sk_buff *skb, s
 			     skb->dev->ifindex);
 
 	while (sk) {
+		delivered = 1;
 		if (iph->protocol != IPPROTO_ICMP || !icmp_filter(sk, skb)) {
 			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
 
@@ -177,6 +179,7 @@ void raw_v4_input(struct sk_buff *skb, s
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
@@ -167,6 +168,7 @@ void ipv6_raw_deliver(struct sk_buff *sk
 	sk = __raw_v6_lookup(sk, nexthdr, daddr, saddr, skb->dev->ifindex);
 
 	while (sk) {
+		delivered = 1;
 		if (nexthdr != IPPROTO_ICMPV6 || !icmpv6_filter(sk, skb)) {
 			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
 
@@ -179,6 +181,7 @@ void ipv6_raw_deliver(struct sk_buff *sk
 	}
 out:
 	read_unlock(&raw_v6_lock);
+	return delivered;
 }
 
 /* This cleans up af_inet6 a bit. -DaveM */

--------------000007000806090209010404--
