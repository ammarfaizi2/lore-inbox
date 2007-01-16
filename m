Return-Path: <linux-kernel-owner+w=401wt.eu-S1750948AbXAPK24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbXAPK24 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbXAPK2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:28:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43221 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbXAPK2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:28:24 -0500
Message-Id: <20070116101816.115266000@taijtu.programming.kicks-ass.net>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
User-Agent: quilt/0.46-1
Date: Tue, 16 Jan 2007 10:46:06 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Cc: David Miller <davem@davemloft.net>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 9/9] net: vm deadlock avoidance core
Content-Disposition: inline; filename=vm_deadlock_core.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to provide robust networked storage there must be a guarantee
of progress. That is, the storage device must never stall because of (physical)
OOM, because the device itself might be needed to get out of it (reclaim).

This means that the device must always find enough memory to build/send packets
over the network _and_ receive (level 7) ACKs for those packets.

The network stack has a huge capacity for buffering packets; waiting for 
user-space to read them. There is a practical limit imposed to avoid DoS 
scenarios. These two things make for a deadlock; what if the receive limit is
reached and all packets are buffered in non-critical sockets (those not serving
the network storage device waiting for an ACK to free a page). 

Memory pressure will add to that; what if there is simply no memory left to
receive packets in.

This patch provides a service to register sockets as critical; SOCK_VMIO
is a promise the socket will never block on receive. Along with with a memory
reserve that will service a limited number of packets this can guarantee a
limited service to these critical sockets.

When we make sure that packets allocated from the reserve will only service
critical sockets we will not lose the memory and can guarantee progress.

The reserve is calculated to exceed the IP fragment caches and match the route
cache.

(Note on the name SOCK_VMIO; the basic problem is a circular dependency between
the network and virtual memory subsystems which needs to be broken. This does
make VM network IO - and only VM network IO - special, it does not generalize)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/skbuff.h     |   13 +++-
 include/net/sock.h         |   42 ++++++++++++++-
 net/core/dev.c             |   40 +++++++++++++-
 net/core/skbuff.c          |   50 ++++++++++++++++--
 net/core/sock.c            |  121 +++++++++++++++++++++++++++++++++++++++++++++
 net/core/stream.c          |    5 +
 net/ipv4/ip_fragment.c     |    1 
 net/ipv4/ipmr.c            |    4 +
 net/ipv4/route.c           |   15 +++++
 net/ipv4/sysctl_net_ipv4.c |   14 ++++-
 net/ipv4/tcp_ipv4.c        |   27 +++++++++-
 net/ipv6/reassembly.c      |    1 
 net/ipv6/route.c           |   15 +++++
 net/ipv6/sysctl_net_ipv6.c |    6 +-
 net/ipv6/tcp_ipv6.c        |   27 +++++++++-
 net/netfilter/core.c       |    5 +
 security/selinux/avc.c     |    2 
 17 files changed, 361 insertions(+), 27 deletions(-)

Index: linux-2.6-git/include/linux/skbuff.h
===================================================================
--- linux-2.6-git.orig/include/linux/skbuff.h	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/include/linux/skbuff.h	2007-01-12 12:21:14.000000000 +0100
@@ -284,7 +284,8 @@ struct sk_buff {
 				nfctinfo:3;
 	__u8			pkt_type:3,
 				fclone:2,
-				ipvs_property:1;
+				ipvs_property:1,
+				emergency:1;
 	__be16			protocol;
 
 	void			(*destructor)(struct sk_buff *skb);
@@ -329,10 +330,13 @@ struct sk_buff {
 
 #include <asm/system.h>
 
+#define SKB_ALLOC_FCLONE	0x01
+#define SKB_ALLOC_RX		0x02
+
 extern void kfree_skb(struct sk_buff *skb);
 extern void	       __kfree_skb(struct sk_buff *skb);
 extern struct sk_buff *__alloc_skb(unsigned int size,
-				   gfp_t priority, int fclone, int node);
+				   gfp_t priority, int flags, int node);
 static inline struct sk_buff *alloc_skb(unsigned int size,
 					gfp_t priority)
 {
@@ -342,7 +346,7 @@ static inline struct sk_buff *alloc_skb(
 static inline struct sk_buff *alloc_skb_fclone(unsigned int size,
 					       gfp_t priority)
 {
-	return __alloc_skb(size, priority, 1, -1);
+	return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, -1);
 }
 
 extern struct sk_buff *alloc_skb_from_cache(struct kmem_cache *cp,
@@ -1103,7 +1107,8 @@ static inline void __skb_queue_purge(str
 static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
 					      gfp_t gfp_mask)
 {
-	struct sk_buff *skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
+	struct sk_buff *skb =
+		__alloc_skb(length + NET_SKB_PAD, gfp_mask, SKB_ALLOC_RX, -1);
 	if (likely(skb))
 		skb_reserve(skb, NET_SKB_PAD);
 	return skb;
Index: linux-2.6-git/include/net/sock.h
===================================================================
--- linux-2.6-git.orig/include/net/sock.h	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/include/net/sock.h	2007-01-12 13:17:45.000000000 +0100
@@ -392,6 +392,7 @@ enum sock_flags {
 	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
 	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
 	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
+	SOCK_VMIO, /* the VM depends on us - make sure we're serviced */
 };
 
 static inline void sock_copy_flags(struct sock *nsk, struct sock *osk)
@@ -414,6 +415,40 @@ static inline int sock_flag(struct sock 
 	return test_bit(flag, &sk->sk_flags);
 }
 
+static inline int sk_has_vmio(struct sock *sk)
+{
+	return sock_flag(sk, SOCK_VMIO);
+}
+
+#define MAX_PAGES_PER_SKB 3
+#define MAX_FRAGMENTS ((65536 + 1500 - 1) / 1500)
+/*
+ * Guestimate the per request queue TX upper bound.
+ */
+#define TX_RESERVE_PAGES \
+	(4 * MAX_FRAGMENTS * MAX_PAGES_PER_SKB)
+
+extern atomic_t vmio_socks;
+extern atomic_t emergency_rx_skbs;
+
+static inline int sk_vmio_socks(void)
+{
+	return atomic_read(&vmio_socks);
+}
+
+extern int sk_emergency_skb_get(void);
+
+static inline void sk_emergency_skb_put(void)
+{
+	return atomic_dec(&emergency_rx_skbs);
+}
+
+extern void sk_adjust_memalloc(int socks, int tx_reserve_pages);
+extern void ipfrag_reserve_memory(int ipfrag_reserve);
+extern void iprt_reserve_memory(int rt_reserve);
+extern int sk_set_vmio(struct sock *sk);
+extern int sk_clear_vmio(struct sock *sk);
+
 static inline void sk_acceptq_removed(struct sock *sk)
 {
 	sk->sk_ack_backlog--;
@@ -695,7 +730,8 @@ static inline struct inode *SOCK_INODE(s
 }
 
 extern void __sk_stream_mem_reclaim(struct sock *sk);
-extern int sk_stream_mem_schedule(struct sock *sk, int size, int kind);
+extern int sk_stream_mem_schedule(struct sock *sk, struct sk_buff *skb,
+		int size, int kind);
 
 #define SK_STREAM_MEM_QUANTUM ((int)PAGE_SIZE)
 
@@ -722,13 +758,13 @@ static inline void sk_stream_writequeue_
 static inline int sk_stream_rmem_schedule(struct sock *sk, struct sk_buff *skb)
 {
 	return (int)skb->truesize <= sk->sk_forward_alloc ||
-		sk_stream_mem_schedule(sk, skb->truesize, 1);
+		sk_stream_mem_schedule(sk, skb, skb->truesize, 1);
 }
 
 static inline int sk_stream_wmem_schedule(struct sock *sk, int size)
 {
 	return size <= sk->sk_forward_alloc ||
-	       sk_stream_mem_schedule(sk, size, 0);
+	       sk_stream_mem_schedule(sk, NULL, size, 0);
 }
 
 /* Used by processes to "lock" a socket state, so that
Index: linux-2.6-git/net/core/dev.c
===================================================================
--- linux-2.6-git.orig/net/core/dev.c	2007-01-12 12:20:07.000000000 +0100
+++ linux-2.6-git/net/core/dev.c	2007-01-12 12:21:55.000000000 +0100
@@ -1767,10 +1767,23 @@ int netif_receive_skb(struct sk_buff *sk
 	struct net_device *orig_dev;
 	int ret = NET_RX_DROP;
 	__be16 type;
+	unsigned long pflags = current->flags;
+
+	/* Emergency skb are special, they should
+	 *  - be delivered to SOCK_VMIO sockets only
+	 *  - stay away from userspace
+	 *  - have bounded memory usage
+	 *
+	 * Use PF_MEMALLOC as a poor mans memory pool - the grouping kind.
+	 * This saves us from propagating the allocation context down to all
+	 * allocation sites.
+	 */
+	if (unlikely(skb->emergency))
+		current->flags |= PF_MEMALLOC;
 
 	/* if we've gotten here through NAPI, check netpoll */
 	if (skb->dev->poll && netpoll_rx(skb))
-		return NET_RX_DROP;
+		goto out;
 
 	if (!skb->tstamp.off_sec)
 		net_timestamp(skb);
@@ -1781,7 +1794,7 @@ int netif_receive_skb(struct sk_buff *sk
 	orig_dev = skb_bond(skb);
 
 	if (!orig_dev)
-		return NET_RX_DROP;
+		goto out;
 
 	__get_cpu_var(netdev_rx_stat).total++;
 
@@ -1798,6 +1811,8 @@ int netif_receive_skb(struct sk_buff *sk
 		goto ncls;
 	}
 #endif
+	if (unlikely(skb->emergency))
+		goto skip_taps;
 
 	list_for_each_entry_rcu(ptype, &ptype_all, list) {
 		if (!ptype->dev || ptype->dev == skb->dev) {
@@ -1807,6 +1822,7 @@ int netif_receive_skb(struct sk_buff *sk
 		}
 	}
 
+skip_taps:
 #ifdef CONFIG_NET_CLS_ACT
 	if (pt_prev) {
 		ret = deliver_skb(skb, pt_prev, orig_dev);
@@ -1819,15 +1835,26 @@ int netif_receive_skb(struct sk_buff *sk
 
 	if (ret == TC_ACT_SHOT || (ret == TC_ACT_STOLEN)) {
 		kfree_skb(skb);
-		goto out;
+		goto unlock;
 	}
 
 	skb->tc_verd = 0;
 ncls:
 #endif
 
+	if (unlikely(skb->emergency))
+		switch(skb->protocol) {
+			case __constant_htons(ETH_P_ARP):
+			case __constant_htons(ETH_P_IP):
+			case __constant_htons(ETH_P_IPV6):
+				break;
+
+			default:
+				goto drop;
+		}
+
 	if (handle_bridge(&skb, &pt_prev, &ret, orig_dev))
-		goto out;
+		goto unlock;
 
 	type = skb->protocol;
 	list_for_each_entry_rcu(ptype, &ptype_base[ntohs(type)&15], list) {
@@ -1842,6 +1869,7 @@ ncls:
 	if (pt_prev) {
 		ret = pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
 	} else {
+drop:
 		kfree_skb(skb);
 		/* Jamal, now you will not able to escape explaining
 		 * me how you were going to use this. :-)
@@ -1849,8 +1877,10 @@ ncls:
 		ret = NET_RX_DROP;
 	}
 
-out:
+unlock:
 	rcu_read_unlock();
+out:
+	current->flags = pflags;
 	return ret;
 }
 
Index: linux-2.6-git/net/core/skbuff.c
===================================================================
--- linux-2.6-git.orig/net/core/skbuff.c	2007-01-12 12:20:07.000000000 +0100
+++ linux-2.6-git/net/core/skbuff.c	2007-01-12 13:29:51.000000000 +0100
@@ -142,28 +142,34 @@ EXPORT_SYMBOL(skb_truesize_bug);
  *	%GFP_ATOMIC.
  */
 struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
-			    int fclone, int node)
+			    int flags, int node)
 {
 	struct kmem_cache *cache;
 	struct skb_shared_info *shinfo;
 	struct sk_buff *skb;
 	u8 *data;
+	int emergency = 0;
 
-	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
+	size = SKB_DATA_ALIGN(size);
+	cache = (flags & SKB_ALLOC_FCLONE)
+		? skbuff_fclone_cache : skbuff_head_cache;
+	if (flags & SKB_ALLOC_RX)
+		gfp_mask |= __GFP_NOMEMALLOC|__GFP_NOWARN;
 
+retry_alloc:
 	/* Get the HEAD */
 	skb = kmem_cache_alloc_node(cache, gfp_mask & ~__GFP_DMA, node);
 	if (!skb)
-		goto out;
+		goto noskb;
 
 	/* Get the DATA. Size must match skb_add_mtu(). */
-	size = SKB_DATA_ALIGN(size);
 	data = kmalloc_node_track_caller(size + sizeof(struct skb_shared_info),
 			gfp_mask, node);
 	if (!data)
 		goto nodata;
 
 	memset(skb, 0, offsetof(struct sk_buff, truesize));
+	skb->emergency = emergency;
 	skb->truesize = size + sizeof(struct sk_buff);
 	atomic_set(&skb->users, 1);
 	skb->head = data;
@@ -180,7 +186,7 @@ struct sk_buff *__alloc_skb(unsigned int
 	shinfo->ip6_frag_id = 0;
 	shinfo->frag_list = NULL;
 
-	if (fclone) {
+	if (flags & SKB_ALLOC_FCLONE) {
 		struct sk_buff *child = skb + 1;
 		atomic_t *fclone_ref = (atomic_t *) (child + 1);
 
@@ -188,12 +194,29 @@ struct sk_buff *__alloc_skb(unsigned int
 		atomic_set(fclone_ref, 1);
 
 		child->fclone = SKB_FCLONE_UNAVAILABLE;
+		child->emergency = skb->emergency;
 	}
 out:
 	return skb;
+
 nodata:
 	kmem_cache_free(cache, skb);
 	skb = NULL;
+noskb:
+	/* Attempt emergency allocation when RX skb. */
+	if (likely(!(flags & SKB_ALLOC_RX) || !sk_vmio_socks()))
+		goto out;
+
+	if (!emergency) {
+		if (sk_emergency_skb_get()) {
+			gfp_mask &= ~(__GFP_NOMEMALLOC|__GFP_NOWARN);
+			gfp_mask |= __GFP_EMERGENCY;
+			emergency = 1;
+			goto retry_alloc;
+		}
+	} else
+		sk_emergency_skb_put();
+
 	goto out;
 }
 
@@ -271,7 +294,7 @@ struct sk_buff *__netdev_alloc_skb(struc
 	int node = dev->class_dev.dev ? dev_to_node(dev->class_dev.dev) : -1;
 	struct sk_buff *skb;
 
- 	skb = __alloc_skb(length + NET_SKB_PAD, gfp_mask, 0, node);
+ 	skb = __alloc_skb(length + NET_SKB_PAD, gfp_mask, SKB_ALLOC_RX, node);
 	if (likely(skb)) {
 		skb_reserve(skb, NET_SKB_PAD);
 		skb->dev = dev;
@@ -320,6 +343,8 @@ static void skb_release_data(struct sk_b
 			skb_drop_fraglist(skb);
 
 		kfree(skb->head);
+		if (unlikely(skb->emergency))
+			sk_emergency_skb_put();
 	}
 }
 
@@ -440,6 +465,9 @@ struct sk_buff *skb_clone(struct sk_buff
 		n->fclone = SKB_FCLONE_CLONE;
 		atomic_inc(fclone_ref);
 	} else {
+		if (unlikely(skb->emergency))
+			gfp_mask |= __GFP_EMERGENCY;
+
 		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
 		if (!n)
 			return NULL;
@@ -474,6 +502,7 @@ struct sk_buff *skb_clone(struct sk_buff
 #if defined(CONFIG_IP_VS) || defined(CONFIG_IP_VS_MODULE)
 	C(ipvs_property);
 #endif
+	C(emergency);
 	C(protocol);
 	n->destructor = NULL;
 	C(mark);
@@ -689,12 +718,19 @@ int pskb_expand_head(struct sk_buff *skb
 	u8 *data;
 	int size = nhead + (skb->end - skb->head) + ntail;
 	long off;
+	int emergency = 0;
 
 	if (skb_shared(skb))
 		BUG();
 
 	size = SKB_DATA_ALIGN(size);
 
+	if (unlikely(skb->emergency) && sk_emergency_skb_get()) {
+		gfp_mask |= __GFP_EMERGENCY;
+		emergency = 1;
+	} else
+		gfp_mask |= __GFP_NOMEMALLOC;
+
 	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
@@ -727,6 +763,8 @@ int pskb_expand_head(struct sk_buff *skb
 	return 0;
 
 nodata:
+	if (unlikely(emergency))
+		sk_emergency_skb_put();
 	return -ENOMEM;
 }
 
Index: linux-2.6-git/net/core/sock.c
===================================================================
--- linux-2.6-git.orig/net/core/sock.c	2007-01-12 12:20:07.000000000 +0100
+++ linux-2.6-git/net/core/sock.c	2007-01-12 12:21:14.000000000 +0100
@@ -196,6 +196,120 @@ __u32 sysctl_rmem_default __read_mostly 
 /* Maximal space eaten by iovec or ancilliary data plus some space */
 int sysctl_optmem_max __read_mostly = sizeof(unsigned long)*(2*UIO_MAXIOV+512);
 
+static DEFINE_SPINLOCK(memalloc_lock);
+static int rx_net_reserve;
+
+atomic_t vmio_socks;
+atomic_t emergency_rx_skbs;
+
+static int ipfrag_threshold;
+
+#define ipfrag_mtu()	(1500) /* XXX: should be smallest mtu system wide */
+#define ipfrag_skbs()	(ipfrag_threshold / ipfrag_mtu())
+#define ipfrag_pages()	(ipfrag_threshold / (ipfrag_mtu() * (PAGE_SIZE / ipfrag_mtu())))
+
+static int iprt_pages;
+
+/*
+ * is there room for another emergency skb.
+ */
+int sk_emergency_skb_get(void)
+{
+	int nr = atomic_add_return(1, &emergency_rx_skbs);
+	int thresh = (3 * ipfrag_skbs()) / 2;
+	if (nr < thresh)
+		return 1;
+
+	atomic_dec(&emergency_rx_skbs);
+	return 0;
+}
+
+/**
+ *	sk_adjust_memalloc - adjust the global memalloc reserve for critical RX
+ *	@socks: number of new %SOCK_VMIO sockets
+ *	@tx_resserve_pages: number of pages to (un)reserve for TX
+ *
+ *	This function adjusts the memalloc reserve based on system demand.
+ *	The RX reserve is a limit, and only added once, not for each socket.
+ *
+ *	NOTE:
+ *	   @tx_reserve_pages is an upper-bound of memory used for TX hence
+ *	   we need not account the pages like we do for RX pages.
+ */
+void sk_adjust_memalloc(int socks, int tx_reserve_pages)
+{
+	unsigned long flags;
+	int reserve = tx_reserve_pages;
+	int nr_socks;
+
+	spin_lock_irqsave(&memalloc_lock, flags);
+	nr_socks = atomic_add_return(socks, &vmio_socks);
+	BUG_ON(nr_socks < 0);
+
+	if (nr_socks) {
+		int rx_pages = 2 * ipfrag_pages() + iprt_pages;
+		reserve += rx_pages - rx_net_reserve;
+		rx_net_reserve = rx_pages;
+	} else {
+		reserve -= rx_net_reserve;
+		rx_net_reserve = 0;
+	}
+
+	if (reserve)
+		adjust_memalloc_reserve(reserve);
+	spin_unlock_irqrestore(&memalloc_lock, flags);
+}
+EXPORT_SYMBOL_GPL(sk_adjust_memalloc);
+
+/*
+ * tiny helper function to track the total ipfragment memory
+ * needed because of modular ipv6
+ */
+void ipfrag_reserve_memory(int frags)
+{
+	ipfrag_threshold += frags;
+	sk_adjust_memalloc(0, 0);
+}
+EXPORT_SYMBOL_GPL(ipfrag_reserve_memory);
+
+void iprt_reserve_memory(int pages)
+{
+	iprt_pages += pages;
+	sk_adjust_memalloc(0, 0);
+}
+EXPORT_SYMBOL_GPL(iprt_reserve_memory);
+
+/**
+ *	sk_set_vmio - sets %SOCK_VMIO
+ *	@sk: socket to set it on
+ *
+ *	Set %SOCK_VMIO on a socket and increase the memalloc reserve
+ *	accordingly.
+ */
+int sk_set_vmio(struct sock *sk)
+{
+	int set = sock_flag(sk, SOCK_VMIO);
+	if (!set) {
+		sk_adjust_memalloc(1, 0);
+		sock_set_flag(sk, SOCK_VMIO);
+		sk->sk_allocation |= __GFP_EMERGENCY;
+	}
+	return !set;
+}
+EXPORT_SYMBOL_GPL(sk_set_vmio);
+
+int sk_clear_vmio(struct sock *sk)
+{
+	int set = sock_flag(sk, SOCK_VMIO);
+	if (set) {
+		sk_adjust_memalloc(-1, 0);
+		sock_reset_flag(sk, SOCK_VMIO);
+		sk->sk_allocation &= ~__GFP_EMERGENCY;
+	}
+	return set;
+}
+EXPORT_SYMBOL_GPL(sk_clear_vmio);
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
 	struct timeval tv;
@@ -239,6 +353,12 @@ int sock_queue_rcv_skb(struct sock *sk, 
 	int err = 0;
 	int skb_len;
 
+	if (unlikely(skb->emergency)) {
+		if (!sk_has_vmio(sk)) {
+			err = -ENOMEM;
+			goto out;
+		}
+	} else
 	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
 	   number of warnings when compiling with -W --ANK
 	 */
@@ -868,6 +988,7 @@ void sk_free(struct sock *sk)
 	struct sk_filter *filter;
 	struct module *owner = sk->sk_prot_creator->owner;
 
+	sk_clear_vmio(sk);
 	if (sk->sk_destruct)
 		sk->sk_destruct(sk);
 
Index: linux-2.6-git/net/ipv4/ipmr.c
===================================================================
--- linux-2.6-git.orig/net/ipv4/ipmr.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/net/ipv4/ipmr.c	2007-01-12 12:21:14.000000000 +0100
@@ -1340,6 +1340,9 @@ int ip_mr_input(struct sk_buff *skb)
 	struct mfc_cache *cache;
 	int local = ((struct rtable*)skb->dst)->rt_flags&RTCF_LOCAL;
 
+	if (unlikely(skb->emergency))
+		goto drop;
+
 	/* Packet is looped back after forward, it should not be
 	   forwarded second time, but still can be delivered locally.
 	 */
@@ -1411,6 +1414,7 @@ int ip_mr_input(struct sk_buff *skb)
 dont_forward:
 	if (local)
 		return ip_local_deliver(skb);
+drop:
 	kfree_skb(skb);
 	return 0;
 }
Index: linux-2.6-git/net/ipv4/sysctl_net_ipv4.c
===================================================================
--- linux-2.6-git.orig/net/ipv4/sysctl_net_ipv4.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/net/ipv4/sysctl_net_ipv4.c	2007-01-12 12:21:14.000000000 +0100
@@ -18,6 +18,7 @@
 #include <net/route.h>
 #include <net/tcp.h>
 #include <net/cipso_ipv4.h>
+#include <net/sock.h>
 
 /* From af_inet.c */
 extern int sysctl_ip_nonlocal_bind;
@@ -186,6 +187,17 @@ static int strategy_allowed_congestion_c
 
 }
 
+int proc_dointvec_fragment(ctl_table *table, int write, struct file *filp,
+		     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+	int old_thresh = *(int *)table->data;
+	ret = proc_dointvec(table,write,filp,buffer,lenp,ppos);
+	ipfrag_reserve_memory(*(int *)table->data - old_thresh);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(proc_dointvec_fragment);
+
 ctl_table ipv4_table[] = {
         {
 		.ctl_name	= NET_IPV4_TCP_TIMESTAMPS,
@@ -291,7 +303,7 @@ ctl_table ipv4_table[] = {
 		.data		= &sysctl_ipfrag_high_thresh,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec
+		.proc_handler	= &proc_dointvec_fragment
 	},
 	{
 		.ctl_name	= NET_IPV4_IPFRAG_LOW_THRESH,
Index: linux-2.6-git/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6-git.orig/net/ipv4/tcp_ipv4.c	2007-01-12 12:20:07.000000000 +0100
+++ linux-2.6-git/net/ipv4/tcp_ipv4.c	2007-01-12 12:21:14.000000000 +0100
@@ -1604,6 +1604,22 @@ csum_err:
 	goto discard;
 }
 
+static int tcp_v4_backlog_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	int ret;
+	unsigned long pflags = current->flags;
+	if (unlikely(skb->emergency)) {
+		BUG_ON(!sk_has_vmio(sk)); /* we dropped those before queueing */
+		if (!(pflags & PF_MEMALLOC))
+			current->flags |= PF_MEMALLOC;
+	}
+
+	ret = tcp_v4_do_rcv(sk, skb);
+
+	current->flags = pflags;
+	return ret;
+}
+
 /*
  *	From tcp_input.c
  */
@@ -1654,6 +1670,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!sk)
 		goto no_tcp_socket;
 
+	if (unlikely(skb->emergency)) {
+	       	if (!sk_has_vmio(sk))
+			goto discard_and_relse;
+		/*
+		   decrease window size..
+		   tcp_enter_quickack_mode(sk);
+		*/
+	}
+
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
@@ -2429,7 +2454,7 @@ struct proto tcp_prot = {
 	.getsockopt		= tcp_getsockopt,
 	.sendmsg		= tcp_sendmsg,
 	.recvmsg		= tcp_recvmsg,
-	.backlog_rcv		= tcp_v4_do_rcv,
+	.backlog_rcv		= tcp_v4_backlog_rcv,
 	.hash			= tcp_v4_hash,
 	.unhash			= tcp_unhash,
 	.get_port		= tcp_v4_get_port,
Index: linux-2.6-git/net/ipv6/sysctl_net_ipv6.c
===================================================================
--- linux-2.6-git.orig/net/ipv6/sysctl_net_ipv6.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/net/ipv6/sysctl_net_ipv6.c	2007-01-12 12:21:14.000000000 +0100
@@ -15,6 +15,10 @@
 
 #ifdef CONFIG_SYSCTL
 
+extern int proc_dointvec_fragment(ctl_table *table, int write,
+	       	struct file *filp, void __user *buffer, size_t *lenp,
+	       	loff_t *ppos);
+
 static ctl_table ipv6_table[] = {
 	{
 		.ctl_name	= NET_IPV6_ROUTE,
@@ -44,7 +48,7 @@ static ctl_table ipv6_table[] = {
 		.data		= &sysctl_ip6frag_high_thresh,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec
+		.proc_handler	= &proc_dointvec_fragment
 	},
 	{
 		.ctl_name	= NET_IPV6_IP6FRAG_LOW_THRESH,
Index: linux-2.6-git/net/netfilter/core.c
===================================================================
--- linux-2.6-git.orig/net/netfilter/core.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/net/netfilter/core.c	2007-01-12 12:21:14.000000000 +0100
@@ -181,6 +181,11 @@ next_hook:
 		kfree_skb(*pskb);
 		ret = -EPERM;
 	} else if ((verdict & NF_VERDICT_MASK)  == NF_QUEUE) {
+		if (unlikely((*pskb)->emergency)) {
+			printk(KERN_ERR "nf_hook: NF_QUEUE encountered for "
+					"emergency skb - skipping rule.\n");
+			goto next_hook;
+		}
 		NFDEBUG("nf_hook: Verdict = QUEUE.\n");
 		if (!nf_queue(*pskb, elem, pf, hook, indev, outdev, okfn,
 			      verdict >> NF_VERDICT_BITS))
Index: linux-2.6-git/security/selinux/avc.c
===================================================================
--- linux-2.6-git.orig/security/selinux/avc.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/security/selinux/avc.c	2007-01-12 12:21:14.000000000 +0100
@@ -332,7 +332,7 @@ static struct avc_node *avc_alloc_node(v
 {
 	struct avc_node *node;
 
-	node = kmem_cache_alloc(avc_node_cachep, GFP_ATOMIC);
+	node = kmem_cache_alloc(avc_node_cachep, GFP_ATOMIC|__GFP_NOMEMALLOC);
 	if (!node)
 		goto out;
 
Index: linux-2.6-git/net/ipv4/ip_fragment.c
===================================================================
--- linux-2.6-git.orig/net/ipv4/ip_fragment.c	2007-01-12 12:20:07.000000000 +0100
+++ linux-2.6-git/net/ipv4/ip_fragment.c	2007-01-12 12:21:14.000000000 +0100
@@ -743,6 +743,7 @@ void ipfrag_init(void)
 	ipfrag_secret_timer.function = ipfrag_secret_rebuild;
 	ipfrag_secret_timer.expires = jiffies + sysctl_ipfrag_secret_interval;
 	add_timer(&ipfrag_secret_timer);
+	ipfrag_reserve_memory(sysctl_ipfrag_high_thresh);
 }
 
 EXPORT_SYMBOL(ip_defrag);
Index: linux-2.6-git/net/ipv6/reassembly.c
===================================================================
--- linux-2.6-git.orig/net/ipv6/reassembly.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/net/ipv6/reassembly.c	2007-01-12 12:21:14.000000000 +0100
@@ -772,4 +772,5 @@ void __init ipv6_frag_init(void)
 	ip6_frag_secret_timer.function = ip6_frag_secret_rebuild;
 	ip6_frag_secret_timer.expires = jiffies + sysctl_ip6frag_secret_interval;
 	add_timer(&ip6_frag_secret_timer);
+	ipfrag_reserve_memory(sysctl_ip6frag_high_thresh);
 }
Index: linux-2.6-git/net/ipv4/route.c
===================================================================
--- linux-2.6-git.orig/net/ipv4/route.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/net/ipv4/route.c	2007-01-12 12:21:14.000000000 +0100
@@ -2884,6 +2884,17 @@ static int ipv4_sysctl_rtcache_flush_str
 	return 0;
 }
 
+static int proc_dointvec_rt_size(ctl_table *table, int write, struct file *filp,
+		     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+	int old = *(int *)table->data;
+	ret = proc_dointvec(table,write,filp,buffer,lenp,ppos);
+	iprt_reserve_memory(kmem_cache_objs_to_pages(ipv4_dst_ops.kmem_cachep,
+				*(int *)table->data - old));
+	return ret;
+}
+
 ctl_table ipv4_route_table[] = {
         {
 		.ctl_name 	= NET_IPV4_ROUTE_FLUSH,
@@ -2926,7 +2937,7 @@ ctl_table ipv4_route_table[] = {
 		.data		= &ip_rt_max_size,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_dointvec_rt_size,
 	},
 	{
 		/*  Deprecated. Use gc_min_interval_ms */
@@ -3153,6 +3164,8 @@ int __init ip_rt_init(void)
 
 	ipv4_dst_ops.gc_thresh = (rt_hash_mask + 1);
 	ip_rt_max_size = (rt_hash_mask + 1) * 16;
+	iprt_reserve_memory(kmem_cache_objs_to_pages(ipv4_dst_ops.kmem_cachep,
+				ip_rt_max_size));
 
 	devinet_init();
 	ip_fib_init();
Index: linux-2.6-git/net/ipv6/route.c
===================================================================
--- linux-2.6-git.orig/net/ipv6/route.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/net/ipv6/route.c	2007-01-12 12:21:14.000000000 +0100
@@ -2356,6 +2356,17 @@ int ipv6_sysctl_rtcache_flush(ctl_table 
 		return -EINVAL;
 }
 
+static int proc_dointvec_rt_size(ctl_table *table, int write, struct file *filp,
+		     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+	int old = *(int *)table->data;
+	ret = proc_dointvec(table,write,filp,buffer,lenp,ppos);
+	iprt_reserve_memory(kmem_cache_objs_to_pages(ip6_dst_ops.kmem_cachep,
+				*(int *)table->data - old));
+	return ret;
+}
+
 ctl_table ipv6_route_table[] = {
         {
 		.ctl_name	=	NET_IPV6_ROUTE_FLUSH, 
@@ -2379,7 +2390,7 @@ ctl_table ipv6_route_table[] = {
          	.data		=	&ip6_rt_max_size,
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
-         	.proc_handler	=	&proc_dointvec,
+         	.proc_handler	=	&proc_dointvec_rt_size,
 	},
 	{
 		.ctl_name	=	NET_IPV6_ROUTE_GC_MIN_INTERVAL,
@@ -2464,6 +2475,8 @@ void __init ip6_route_init(void)
 
 	proc_net_fops_create("rt6_stats", S_IRUGO, &rt6_stats_seq_fops);
 #endif
+	iprt_reserve_memory(kmem_cache_objs_to_pages(ip6_dst_ops.kmem_cachep,
+				ip6_rt_max_size));
 #ifdef CONFIG_XFRM
 	xfrm6_init();
 #endif
Index: linux-2.6-git/net/ipv6/tcp_ipv6.c
===================================================================
--- linux-2.6-git.orig/net/ipv6/tcp_ipv6.c	2007-01-12 12:20:08.000000000 +0100
+++ linux-2.6-git/net/ipv6/tcp_ipv6.c	2007-01-12 12:21:14.000000000 +0100
@@ -1678,6 +1678,22 @@ ipv6_pktoptions:
 	return 0;
 }
 
+static int tcp_v6_backlog_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	int ret;
+	unsigned long pflags = current->flags;
+	if (unlikely(skb->emergency)) {
+		BUG_ON(!sk_has_vmio(sk)); /* we dropped those before queueing */
+		if (!(pflags & PF_MEMALLOC))
+			current->flags |= PF_MEMALLOC;
+	}
+
+	ret = tcp_v6_do_rcv(sk, skb);
+
+	current->flags = pflags;
+	return ret;
+}
+
 static int tcp_v6_rcv(struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
@@ -1723,6 +1739,15 @@ static int tcp_v6_rcv(struct sk_buff **p
 	if (!sk)
 		goto no_tcp_socket;
 
+	if (unlikely(skb->emergency)) {
+	       	if (!sk_has_vmio(sk))
+			goto discard_and_relse;
+		/*
+		   decrease window size..
+		   tcp_enter_quickack_mode(sk);
+		*/
+	}
+
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
@@ -2127,7 +2152,7 @@ struct proto tcpv6_prot = {
 	.getsockopt		= tcp_getsockopt,
 	.sendmsg		= tcp_sendmsg,
 	.recvmsg		= tcp_recvmsg,
-	.backlog_rcv		= tcp_v6_do_rcv,
+	.backlog_rcv		= tcp_v6_backlog_rcv,
 	.hash			= tcp_v6_hash,
 	.unhash			= tcp_unhash,
 	.get_port		= tcp_v6_get_port,
Index: linux-2.6-git/net/core/stream.c
===================================================================
--- linux-2.6-git.orig/net/core/stream.c	2007-01-12 12:20:07.000000000 +0100
+++ linux-2.6-git/net/core/stream.c	2007-01-12 13:17:08.000000000 +0100
@@ -207,7 +207,7 @@ void __sk_stream_mem_reclaim(struct sock
 
 EXPORT_SYMBOL(__sk_stream_mem_reclaim);
 
-int sk_stream_mem_schedule(struct sock *sk, int size, int kind)
+int sk_stream_mem_schedule(struct sock *sk, struct sk_buff *skb, int size, int kind)
 {
 	int amt = sk_stream_pages(size);
 
@@ -224,7 +224,8 @@ int sk_stream_mem_schedule(struct sock *
 	/* Over hard limit. */
 	if (atomic_read(sk->sk_prot->memory_allocated) > sk->sk_prot->sysctl_mem[2]) {
 		sk->sk_prot->enter_memory_pressure();
-		goto suppress_allocation;
+		if (likely(!skb || !skb->emergency))
+			goto suppress_allocation;
 	}
 
 	/* Under pressure. */

-- 

