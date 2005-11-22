Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVKVQpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVKVQpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVKVQpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:45:20 -0500
Received: from users.ccur.com ([66.10.65.2]:57547 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S964998AbVKVQpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:45:18 -0500
Date: Tue, 22 Nov 2005 11:45:02 -0500
From: Joe Korty <joe.korty@ccur.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Network lockup under load
Message-ID: <20051122164502.GA12498@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
 I traced (git bisect) a networking lockup I have been
suffering from to the attached patch, introduced between
2.6.13-rc1-git7 and 2.6.13-rc2.

The lockup consists of all processes doing IO to any
TCP socket stalling out forever.  Processes not using
networking continue to run normally.

To trigger the lockup, I do a 'scp -rp' of the kernel
tree from a machine with a defective kernel to any other
machine.  It triggers anywhere after the first file
transfered, to perhaps 30 files transfered.

I suspect there is something unusual in my configuration,
or perhaps my hardware, that is contributing to the
problem, since otherwise many others would have reported
such a serious failure by now.  I have PREEMPT and SMP
turned on, my machine is a Dell PowerEdge 2600 w/ 4 virtual
CPUs, Intel 82544GC Gigabit Ethernet.

Regards,
Joe

tree 160f85e7d9ec1df2432b4dd3fae315812558bd10
parent b8259d9ad1d0f8d0c5ea0e37bb15080b0bd395b5
author David S. Miller <davem@davemloft.net> Wed, 06 Jul 2005 05:17:25 -0700
committer David S. Miller <davem@davemloft.net> Wed, 06 Jul 2005 05:17:25 -0700

[TCP]: Simplify SKB data portion allocation with NETIF_F_SG.

The ideal and most optimal layout for an SKB when doing
scatter-gather is to put all the headers at skb->data, and
all the user data in the page array.

This makes SKB splitting and combining extremely simple,
especially before a packet goes onto the wire the first
time.

So, when sk_stream_alloc_pskb() is given a zero size, make
sure there is no skb_tailroom().  This is achieved by applying
SKB_DATA_ALIGN() to the header length used here.

Next, make select_size() in TCP output segmentation use a
length of zero when NETIF_F_SG is true on the outgoing
interface.

Signed-off-by: David S. Miller <davem@davemloft.net>


 2.6.13-rc1-git7-jak/include/net/sock.h |    7 +++++--
 2.6.13-rc1-git7-jak/net/ipv4/tcp.c     |   13 ++-----------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff -puNa include/net/sock.h~SimplifySKB.data.portion.allocation.with.NETIF_F_SG include/net/sock.h
--- 2.6.13-rc1-git7/include/net/sock.h~SimplifySKB.data.portion.allocation.with.NETIF_F_SG	2005-11-21 17:53:41.000000000 -0500
+++ 2.6.13-rc1-git7-jak/include/net/sock.h	2005-11-21 17:53:41.000000000 -0500
@@ -1134,13 +1134,16 @@ static inline void sk_stream_moderate_sn
 static inline struct sk_buff *sk_stream_alloc_pskb(struct sock *sk,
 						   int size, int mem, int gfp)
 {
-	struct sk_buff *skb = alloc_skb(size + sk->sk_prot->max_header, gfp);
+	struct sk_buff *skb;
+	int hdr_len;
 
+	hdr_len = SKB_DATA_ALIGN(sk->sk_prot->max_header);
+	skb = alloc_skb(size + hdr_len, gfp);
 	if (skb) {
 		skb->truesize += mem;
 		if (sk->sk_forward_alloc >= (int)skb->truesize ||
 		    sk_stream_mem_schedule(sk, skb->truesize, 0)) {
-			skb_reserve(skb, sk->sk_prot->max_header);
+			skb_reserve(skb, hdr_len);
 			return skb;
 		}
 		__kfree_skb(skb);
diff -puNa net/ipv4/tcp.c~SimplifySKB.data.portion.allocation.with.NETIF_F_SG net/ipv4/tcp.c
--- 2.6.13-rc1-git7/net/ipv4/tcp.c~SimplifySKB.data.portion.allocation.with.NETIF_F_SG	2005-11-21 17:53:41.000000000 -0500
+++ 2.6.13-rc1-git7-jak/net/ipv4/tcp.c	2005-11-21 17:53:48.000000000 -0500
@@ -756,13 +756,9 @@ static inline int select_size(struct soc
 {
 	int tmp = tp->mss_cache_std;
 
-	if (sk->sk_route_caps & NETIF_F_SG) {
-		int pgbreak = SKB_MAX_HEAD(MAX_TCP_HEADER);
+	if (sk->sk_route_caps & NETIF_F_SG)
+		tmp = 0;
 
-		if (tmp >= pgbreak &&
-		    tmp <= pgbreak + (MAX_SKB_FRAGS - 1) * PAGE_SIZE)
-			tmp = pgbreak;
-	}
 	return tmp;
 }
 
@@ -872,11 +868,6 @@ new_segment:
 					tcp_mark_push(tp, skb);
 					goto new_segment;
 				} else if (page) {
-					/* If page is cached, align
-					 * offset to L1 cache boundary
-					 */
-					off = (off + L1_CACHE_BYTES - 1) &
-					      ~(L1_CACHE_BYTES - 1);
 					if (off == PAGE_SIZE) {
 						put_page(page);
 						TCP_PAGE(sk) = page = NULL;

_
