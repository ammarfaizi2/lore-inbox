Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVLNJN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVLNJN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVLNJN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:13:28 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:5776 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932242AbVLNJMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:12:55 -0500
Date: Wed, 14 Dec 2005 01:12:53 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@w-sridhar.beaverton.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 3/3] TCP/IP Critical socket communication mechanism
Message-ID: <Pine.LNX.4.58.0512140052470.31720@w-sridhar.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass __GFP_CRITICAL flag with all allocation requests that are critical.
- All allocations needed to process incoming packets are marked as CRITICAL.
  This includes the allocations
     - made by the driver to receive incoming packets
     - to process and send ARP packets
     - to create new routes for incoming packets
     - to process incoming ipsec packets
     - to send ACKs.
- All allocations needed to send packets on a critical socket are marked as
  CRITICAL.
-----------------------------------------------------------------------------

 include/linux/skbuff.h        |    2 +-
 include/net/sock.h            |    3 +++
 net/compat.c                  |    3 ++-
 net/core/dev.c                |    2 +-
 net/core/dst.c                |    2 +-
 net/core/flow.c               |    2 +-
 net/core/neighbour.c          |    8 ++++----
 net/core/skbuff.c             |    6 +++---
 net/ipv4/ah4.c                |    2 +-
 net/ipv4/arp.c                |    4 ++--
 net/ipv4/esp4.c               |    2 +-
 net/ipv4/inet_timewait_sock.c |    2 +-
 net/ipv4/inetpeer.c           |    2 +-
 net/ipv4/ip_input.c           |    2 +-
 net/ipv4/tcp.c                |    6 +++---
 net/ipv4/tcp_input.c          |    2 +-
 net/ipv4/tcp_ipv4.c           |    2 +-
 net/ipv4/tcp_minisocks.c      |    2 +-
 net/ipv4/tcp_output.c         |   30 +++++++++++++++---------------
 net/ipv4/tcp_timer.c          |    6 +++---
 net/ipv4/xfrm4_input.c        |    2 +-
 net/socket.c                  |    6 +++---
 net/xfrm/xfrm_algo.c          |    6 +++---
 net/xfrm/xfrm_input.c         |    2 +-
 24 files changed, 55 insertions(+), 51 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8c5d600..a721cfc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1069,7 +1069,7 @@ extern struct sk_buff *__dev_alloc_skb(u
  */
 static inline struct sk_buff *dev_alloc_skb(unsigned int length)
 {
-	return __dev_alloc_skb(length, GFP_ATOMIC);
+	return __dev_alloc_skb(length, GFP_ATOMIC|__GFP_CRITICAL);
 }

 /**
diff --git a/include/net/sock.h b/include/net/sock.h
index 8de8a8b..71768e2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1405,4 +1405,7 @@ static inline int emergency_check(struct
 	return 1;
 }

+#define SK_CRIT_ALLOC(sk, flags) ((sk->sk_allocation & __GFP_CRITICAL) | flags)
+#define CRIT_ALLOC(flags) (__GFP_CRITICAL | flags)
+
 #endif	/* _SOCK_H */
diff --git a/net/compat.c b/net/compat.c
index e593dac..7de4002 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -170,7 +170,8 @@ int cmsghdr_from_user_compat_to_kern(str
 	 * from the user.
 	 */
 	if (kcmlen > stackbuf_size)
-		kcmsg_base = kcmsg = sock_kmalloc(sk, kcmlen, GFP_KERNEL);
+		kcmsg_base = kcmsg = sock_kmalloc(sk, kcmlen,
+						SK_CRIT_ALLOC(sk, GFP_KERNEL));
 	if (kcmsg == NULL)
 		return -ENOBUFS;

diff --git a/net/core/dev.c b/net/core/dev.c
index 0b48e29..70e2f87 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1087,7 +1087,7 @@ int skb_checksum_help(struct sk_buff *sk
 	}

 	if (skb_cloned(skb)) {
-		ret = pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
+		ret = pskb_expand_head(skb, 0, 0, CRIT_ALLOC(GFP_ATOMIC));
 		if (ret)
 			goto out;
 	}
diff --git a/net/core/dst.c b/net/core/dst.c
index 470c05b..c4d674d 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -126,7 +126,7 @@ void * dst_alloc(struct dst_ops * ops)
 		if (ops->gc())
 			return NULL;
 	}
-	dst = kmem_cache_alloc(ops->kmem_cachep, SLAB_ATOMIC);
+	dst = kmem_cache_alloc(ops->kmem_cachep, SLAB_ATOMIC|__GFP_CRITICAL);
 	if (!dst)
 		return NULL;
 	memset(dst, 0, ops->entry_size);
diff --git a/net/core/flow.c b/net/core/flow.c
index 7e95b39..2c86f33 100644
--- a/net/core/flow.c
+++ b/net/core/flow.c
@@ -204,7 +204,7 @@ void *flow_cache_lookup(struct flowi *ke
 		if (flow_count(cpu) > flow_hwm)
 			flow_cache_shrink(cpu);

-		fle = kmem_cache_alloc(flow_cachep, SLAB_ATOMIC);
+		fle = kmem_cache_alloc(flow_cachep, SLAB_ATOMIC|__GFP_CRITICAL);
 		if (fle) {
 			fle->next = *head;
 			*head = fle;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e68700f..26673eb 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -284,10 +284,10 @@ static struct neighbour **neigh_hash_all
 	struct neighbour **ret;

 	if (size <= PAGE_SIZE) {
-		ret = kmalloc(size, GFP_ATOMIC);
+		ret = kmalloc(size, CRIT_ALLOC(GFP_ATOMIC));
 	} else {
 		ret = (struct neighbour **)
-			__get_free_pages(GFP_ATOMIC, get_order(size));
+			__get_free_pages(CRIT_ALLOC(GFP_ATOMIC), get_order(size));
 	}
 	if (ret)
 		memset(ret, 0, size);
@@ -476,7 +476,7 @@ struct pneigh_entry * pneigh_lookup(stru
 	if (!creat)
 		goto out;

-	n = kmalloc(sizeof(*n) + key_len, GFP_KERNEL);
+	n = kmalloc(sizeof(*n) + key_len, CRIT_ALLOC(GFP_KERNEL));
 	if (!n)
 		goto out;

@@ -1081,7 +1081,7 @@ static void neigh_hh_init(struct neighbo
 		if (hh->hh_type == protocol)
 			break;

-	if (!hh && (hh = kmalloc(sizeof(*hh), GFP_ATOMIC)) != NULL) {
+	if (!hh && (hh = kmalloc(sizeof(*hh), CRIT_ALLOC(GFP_ATOMIC))) != NULL) {
 		memset(hh, 0, sizeof(struct hh_cache));
 		rwlock_init(&hh->hh_lock);
 		hh->hh_type = protocol;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b7d13a4..03923d2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -794,7 +794,7 @@ int ___pskb_trim(struct sk_buff *skb, un
 			if (skb_cloned(skb)) {
 				if (!realloc)
 					BUG();
-				if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+				if (pskb_expand_head(skb, 0, 0, CRIT_ALLOC(GFP_ATOMIC)))
 					return -ENOMEM;
 			}
 			if (len <= offset) {
@@ -861,7 +861,7 @@ unsigned char *__pskb_pull_tail(struct s

 	if (eat > 0 || skb_cloned(skb)) {
 		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
-				     GFP_ATOMIC))
+				     CRIT_ALLOC(GFP_ATOMIC)))
 			return NULL;
 	}

@@ -908,7 +908,7 @@ unsigned char *__pskb_pull_tail(struct s

 				if (skb_shared(list)) {
 					/* Sucks! We need to fork list. :-( */
-					clone = skb_clone(list, GFP_ATOMIC);
+					clone = skb_clone(list, CRIT_ALLOC(GFP_ATOMIC));
 					if (!clone)
 						return NULL;
 					insp = list->next;
diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 035ad2c..3f8fbbd 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -139,7 +139,7 @@ static int ah_input(struct xfrm_state *x
 	/* We are going to _remove_ AH header to keep sockets happy,
 	 * so... Later this can change. */
 	if (skb_cloned(skb) &&
-	    pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+	    pskb_expand_head(skb, 0, 0, CRIT_ALLOC(GFP_ATOMIC)))
 		goto out;

 	skb->ip_summed = CHECKSUM_NONE;
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index b425748..b264ea6 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -573,7 +573,7 @@ struct sk_buff *arp_create(int type, int
 	 */

 	skb = alloc_skb(sizeof(struct arphdr)+ 2*(dev->addr_len+4)
-				+ LL_RESERVED_SPACE(dev), GFP_ATOMIC);
+				+ LL_RESERVED_SPACE(dev), CRIT_ALLOC(GFP_ATOMIC));
 	if (skb == NULL)
 		return NULL;

@@ -944,7 +944,7 @@ int arp_rcv(struct sk_buff *skb, struct
 	    arp->ar_pln != 4)
 		goto freeskb;

-	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL)
+	if ((skb = skb_share_check(skb, CRIT_ALLOC(GFP_ATOMIC))) == NULL)
 		goto out_of_mem;

 	memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 1b18ce6..2a07a15 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -191,7 +191,7 @@ static int esp_input(struct xfrm_state *
 		int padlen;

 		if (unlikely(nfrags > ESP_NUM_FAST_SG)) {
-			sg = kmalloc(sizeof(struct scatterlist)*nfrags, GFP_ATOMIC);
+			sg = kmalloc(sizeof(struct scatterlist)*nfrags, CRIT_ALLOC(GFP_ATOMIC));
 			if (!sg)
 				goto out;
 		}
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index a010e9a..aba7660 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -91,7 +91,7 @@ EXPORT_SYMBOL_GPL(__inet_twsk_hashdance)
 struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk, const int state)
 {
 	struct inet_timewait_sock *tw = kmem_cache_alloc(sk->sk_prot_creator->twsk_slab,
-							 SLAB_ATOMIC);
+							 SK_CRIT_ALLOC(sk, SLAB_ATOMIC));
 	if (tw != NULL) {
 		const struct inet_sock *inet = inet_sk(sk);

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 2fc3fd3..fbd8f2d 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -396,7 +396,7 @@ struct inet_peer *inet_getpeer(__u32 dad
 		return NULL;

 	/* Allocate the space outside the locked region. */
-	n = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
+	n = kmem_cache_alloc(peer_cachep, CRIT_ALLOC(GFP_ATOMIC));
 	if (n == NULL)
 		return NULL;
 	n->v4daddr = daddr;
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 473d0f2..91f4506 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -386,7 +386,7 @@ int ip_rcv(struct sk_buff *skb, struct n

 	IP_INC_STATS_BH(IPSTATS_MIB_INRECEIVES);

-	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL) {
+	if ((skb = skb_share_check(skb, CRIT_ALLOC(GFP_ATOMIC))) == NULL) {
 		IP_INC_STATS_BH(IPSTATS_MIB_INDISCARDS);
 		goto out;
 	}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ef98b14..9a3e589 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1506,7 +1506,7 @@ void tcp_close(struct sock *sk, long tim
 		/* Unread data was tossed, zap the connection. */
 		NET_INC_STATS_USER(LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(sk, TCP_CLOSE);
-		tcp_send_active_reset(sk, GFP_KERNEL);
+		tcp_send_active_reset(sk, SK_CRIT_ALLOC(sk, GFP_KERNEL));
 	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		sk->sk_prot->disconnect(sk, 0);
@@ -1575,7 +1575,7 @@ adjudge_to_death:
 		struct tcp_sock *tp = tcp_sk(sk);
 		if (tp->linger2 < 0) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 			NET_INC_STATS_BH(LINUX_MIB_TCPABORTONLINGER);
 		} else {
 			const int tmo = tcp_fin_time(sk);
@@ -1598,7 +1598,7 @@ adjudge_to_death:
 				printk(KERN_INFO "TCP: too many of orphaned "
 				       "sockets\n");
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 			NET_INC_STATS_BH(LINUX_MIB_TCPABORTONMEMORY);
 		}
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bf2e230..fd60b86 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3289,7 +3289,7 @@ tcp_collapse(struct sock *sk, struct sk_
 			return;
 		if (end-start < copy)
 			copy = end-start;
-		nskb = alloc_skb(copy+header, GFP_ATOMIC);
+		nskb = alloc_skb(copy+header, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 		if (!nskb)
 			return;
 		skb_reserve(nskb, header);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index acfb9a1..380cb66 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -849,7 +849,7 @@ static inline struct ip_options *tcp_v4_

 	if (opt && opt->optlen) {
 		int opt_size = optlength(opt);
-		dopt = kmalloc(opt_size, GFP_ATOMIC);
+		dopt = kmalloc(opt_size, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 		if (dopt) {
 			if (ip_options_echo(dopt, skb)) {
 				kfree(dopt);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1b66a2a..9491835 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -344,7 +344,7 @@ void tcp_time_wait(struct sock *sk, int
  */
 struct sock *tcp_create_openreq_child(struct sock *sk, struct request_sock *req, struct sk_buff *skb)
 {
-	struct sock *newsk = inet_csk_clone(sk, req, GFP_ATOMIC);
+	struct sock *newsk = inet_csk_clone(sk, req, SK_CRIT_ALLOC(sk, GFP_ATOMIC));

 	if (newsk != NULL) {
 		const struct inet_request_sock *ireq = inet_rsk(req);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 029c70d..3f5ab2e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -444,11 +444,11 @@ int tcp_fragment(struct sock *sk, struct

 	if (skb_cloned(skb) &&
 	    skb_is_nonlinear(skb) &&
-	    pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+	    pskb_expand_head(skb, 0, 0, SK_CRIT_ALLOC(sk, GFP_ATOMIC)))
 		return -ENOMEM;

 	/* Get a new skb... force flag on. */
-	buff = sk_stream_alloc_skb(sk, nsize, GFP_ATOMIC);
+	buff = sk_stream_alloc_skb(sk, nsize, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 	if (buff == NULL)
 		return -ENOMEM; /* We'll just try again later. */
 	sk_charge_skb(sk, buff);
@@ -568,7 +568,7 @@ static unsigned char *__pskb_trim_head(s
 int tcp_trim_head(struct sock *sk, struct sk_buff *skb, u32 len)
 {
 	if (skb_cloned(skb) &&
-	    pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+	    pskb_expand_head(skb, 0, 0, SK_CRIT_ALLOC(sk, GFP_ATOMIC)))
 		return -ENOMEM;

 	if (len <= skb_headlen(skb)) {
@@ -887,7 +887,7 @@ static int tso_fragment(struct sock *sk,
 	if (skb->len != skb->data_len)
 		return tcp_fragment(sk, skb, len, mss_now);

-	buff = sk_stream_alloc_pskb(sk, 0, 0, GFP_ATOMIC);
+	buff = sk_stream_alloc_pskb(sk, 0, 0, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 	if (unlikely(buff == NULL))
 		return -ENOMEM;

@@ -1036,7 +1036,7 @@ static int tcp_write_xmit(struct sock *s

 		TCP_SKB_CB(skb)->when = tcp_time_stamp;

-		if (unlikely(tcp_transmit_skb(sk, skb_clone(skb, GFP_ATOMIC))))
+		if (unlikely(tcp_transmit_skb(sk, skb_clone(skb, SK_CRIT_ALLOC(sk, GFP_ATOMIC)))))
 			break;

 		/* Advance the send_head.  This one is sent out.
@@ -1430,8 +1430,8 @@ int tcp_retransmit_skb(struct sock *sk,
 	TCP_SKB_CB(skb)->when = tcp_time_stamp;

 	err = tcp_transmit_skb(sk, (skb_cloned(skb) ?
-				    pskb_copy(skb, GFP_ATOMIC):
-				    skb_clone(skb, GFP_ATOMIC)));
+				    pskb_copy(skb, SK_CRIT_ALLOC(sk, GFP_ATOMIC)):
+				    skb_clone(skb, SK_CRIT_ALLOC(sk, GFP_ATOMIC))));

 	if (err == 0) {
 		/* Update global TCP statistics. */
@@ -1614,7 +1614,7 @@ void tcp_send_fin(struct sock *sk)
 	} else {
 		/* Socket is locked, keep trying until memory is available. */
 		for (;;) {
-			skb = alloc_skb_fclone(MAX_TCP_HEADER, GFP_KERNEL);
+			skb = alloc_skb_fclone(MAX_TCP_HEADER, SK_CRIT_ALLOC(sk, GFP_KERNEL));
 			if (skb)
 				break;
 			yield();
@@ -1685,7 +1685,7 @@ int tcp_send_synack(struct sock *sk)
 	}
 	if (!(TCP_SKB_CB(skb)->flags&TCPCB_FLAG_ACK)) {
 		if (skb_cloned(skb)) {
-			struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
+			struct sk_buff *nskb = skb_copy(skb, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 			if (nskb == NULL)
 				return -ENOMEM;
 			__skb_unlink(skb, &sk->sk_write_queue);
@@ -1700,7 +1700,7 @@ int tcp_send_synack(struct sock *sk)
 		TCP_ECN_send_synack(tcp_sk(sk), skb);
 	}
 	TCP_SKB_CB(skb)->when = tcp_time_stamp;
-	return tcp_transmit_skb(sk, skb_clone(skb, GFP_ATOMIC));
+	return tcp_transmit_skb(sk, skb_clone(skb, SK_CRIT_ALLOC(sk, GFP_ATOMIC)));
 }

 /*
@@ -1715,7 +1715,7 @@ struct sk_buff * tcp_make_synack(struct
 	int tcp_header_size;
 	struct sk_buff *skb;

-	skb = sock_wmalloc(sk, MAX_TCP_HEADER + 15, 1, GFP_ATOMIC);
+	skb = sock_wmalloc(sk, MAX_TCP_HEADER + 15, 1, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 	if (skb == NULL)
 		return NULL;

@@ -1861,7 +1861,7 @@ int tcp_connect(struct sock *sk)
 	__skb_queue_tail(&sk->sk_write_queue, buff);
 	sk_charge_skb(sk, buff);
 	tp->packets_out += tcp_skb_pcount(buff);
-	tcp_transmit_skb(sk, skb_clone(buff, GFP_KERNEL));
+	tcp_transmit_skb(sk, skb_clone(buff, SK_CRIT_ALLOC(sk, GFP_KERNEL)));
 	TCP_INC_STATS(TCP_MIB_ACTIVEOPENS);

 	/* Timer for repeating the SYN until an answer. */
@@ -1937,7 +1937,7 @@ void tcp_send_ack(struct sock *sk)
 		 * tcp_transmit_skb() will set the ownership to this
 		 * sock.
 		 */
-		buff = alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
+		buff = alloc_skb(MAX_TCP_HEADER, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 		if (buff == NULL) {
 			inet_csk_schedule_ack(sk);
 			inet_csk(sk)->icsk_ack.ato = TCP_ATO_MIN;
@@ -1978,7 +1978,7 @@ static int tcp_xmit_probe_skb(struct soc
 	struct sk_buff *skb;

 	/* We don't queue it, tcp_transmit_skb() sets ownership. */
-	skb = alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
+	skb = alloc_skb(MAX_TCP_HEADER, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 	if (skb == NULL)
 		return -1;

@@ -2030,7 +2030,7 @@ int tcp_write_wakeup(struct sock *sk)

 			TCP_SKB_CB(skb)->flags |= TCPCB_FLAG_PSH;
 			TCP_SKB_CB(skb)->when = tcp_time_stamp;
-			err = tcp_transmit_skb(sk, skb_clone(skb, GFP_ATOMIC));
+			err = tcp_transmit_skb(sk, skb_clone(skb, SK_CRIT_ALLOC(sk, GFP_ATOMIC)));
 			if (!err) {
 				update_send_head(sk, tp, skb);
 			}
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index e188095..8987a17 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -91,7 +91,7 @@ static int tcp_out_of_resources(struct s
 		    (!tp->snd_wnd && !tp->packets_out))
 			do_reset = 1;
 		if (do_reset)
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 		tcp_done(sk);
 		NET_INC_STATS_BH(LINUX_MIB_TCPABORTONMEMORY);
 		return 1;
@@ -476,7 +476,7 @@ static void tcp_keepalive_timer (unsigne
 				goto out;
 			}
 		}
-		tcp_send_active_reset(sk, GFP_ATOMIC);
+		tcp_send_active_reset(sk, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 		goto death;
 	}

@@ -494,7 +494,7 @@ static void tcp_keepalive_timer (unsigne
 	if (elapsed >= keepalive_time_when(tp)) {
 		if ((!tp->keepalive_probes && icsk->icsk_probes_out >= sysctl_tcp_keepalive_probes) ||
 		     (tp->keepalive_probes && icsk->icsk_probes_out >= tp->keepalive_probes)) {
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, SK_CRIT_ALLOC(sk, GFP_ATOMIC));
 			tcp_write_err(sk);
 			goto out;
 		}
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 2d3849c..78a1874 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -102,7 +102,7 @@ int xfrm4_rcv_encap(struct sk_buff *skb,
 			if (!pskb_may_pull(skb, sizeof(struct iphdr)))
 				goto drop;
 			if (skb_cloned(skb) &&
-			    pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+			    pskb_expand_head(skb, 0, 0, CRIT_ALLOC(GFP_ATOMIC)))
 				goto drop;
 			if (x->props.flags & XFRM_STATE_DECAP_DSCP)
 				ipv4_copy_dscp(iph, skb->h.ipiph);
diff --git a/net/socket.c b/net/socket.c
index 3145103..2e11dba 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1730,7 +1730,7 @@ asmlinkage long sys_sendmsg(int fd, stru
 	err = -ENOMEM;
 	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec);
 	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
-		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
+		iov = sock_kmalloc(sock->sk, iov_size, SK_CRIT_ALLOC(sock->sk, GFP_KERNEL));
 		if (!iov)
 			goto out_put;
 	}
@@ -1758,7 +1758,7 @@ asmlinkage long sys_sendmsg(int fd, stru
 	} else if (ctl_len) {
 		if (ctl_len > sizeof(ctl))
 		{
-			ctl_buf = sock_kmalloc(sock->sk, ctl_len, GFP_KERNEL);
+			ctl_buf = sock_kmalloc(sock->sk, ctl_len, SK_CRIT_ALLOC(sock->sk, GFP_KERNEL));
 			if (ctl_buf == NULL)
 				goto out_freeiov;
 		}
@@ -1830,7 +1830,7 @@ asmlinkage long sys_recvmsg(int fd, stru
 	err = -ENOMEM;
 	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec);
 	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
-		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
+		iov = sock_kmalloc(sock->sk, iov_size, SK_CRIT_ALLOC(sock->sk, GFP_KERNEL));
 		if (!iov)
 			goto out_put;
 	}
diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
index 2f4531f..cd4dc07 100644
--- a/net/xfrm/xfrm_algo.c
+++ b/net/xfrm/xfrm_algo.c
@@ -646,7 +646,7 @@ int skb_cow_data(struct sk_buff *skb, in
 		 * space, 128 bytes is fair. */

 		if (skb_tailroom(skb) < tailbits &&
-		    pskb_expand_head(skb, 0, tailbits-skb_tailroom(skb)+128, GFP_ATOMIC))
+		    pskb_expand_head(skb, 0, tailbits-skb_tailroom(skb)+128, CRIT_ALLOC(GFP_ATOMIC)))
 			return -ENOMEM;

 		/* Voila! */
@@ -688,12 +688,12 @@ int skb_cow_data(struct sk_buff *skb, in

 			/* Fuck, we are miserable poor guys... */
 			if (ntail == 0)
-				skb2 = skb_copy(skb1, GFP_ATOMIC);
+				skb2 = skb_copy(skb1, CRIT_ALLOC(GFP_ATOMIC));
 			else
 				skb2 = skb_copy_expand(skb1,
 						       skb_headroom(skb1),
 						       ntail,
-						       GFP_ATOMIC);
+						       CRIT_ALLOC(GFP_ATOMIC));
 			if (unlikely(skb2 == NULL))
 				return -ENOMEM;

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 2407a70..7db5e1a 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -27,7 +27,7 @@ struct sec_path *secpath_dup(struct sec_
 {
 	struct sec_path *sp;

-	sp = kmem_cache_alloc(secpath_cachep, SLAB_ATOMIC);
+	sp = kmem_cache_alloc(secpath_cachep, CRIT_ALLOC(SLAB_ATOMIC));
 	if (!sp)
 		return NULL;


