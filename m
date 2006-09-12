Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWILPux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWILPux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWILPuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:50:52 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:32908 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751419AbWILPus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:48 -0400
Message-Id: <20060912144903.194177000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mike Christie <michaelc@cs.wisc.edu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 02/20] net: vm deadlock avoidance core
Content-Disposition: inline; filename=vm_deadlock_core.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to provide robust networked block devices there must be a guarantee
of progress. That is, the block device must never stall because of (physical)
OOM, because the device itself might be needed to get out of it (reclaim).

This means that the device queue must always be unplugable, this in turn means
that it must always find enough memory to build/send packets over the network
_and_ receive (level 7) ACKs for those packets.

The network stack has a huge capacity for buffering packets; waiting for 
user-space to read them. There is a practical limit imposed to avoid DoS 
scenarios. These two things make for a deadlock; what if the receive limit is
reached and all packets are buffered in non-critical sockets (those not serving
the network block device waiting for an ACK to free a page). 

Memory pressure will add to that; what if there is simply no memory left to
receive packets in.

This patch provides a service to register sockets as critical; SOCK_VMIO
is a promise the socket will never block on receive. Along with with a memory
reserve that will service a limited number of packets this can guarantee a
limited service to these critical sockets.

When we make sure that packets allocated from the reserve will only service
critical sockets we will not lose the memory and can guarantee progress.

Since memory is tight and the reserve modest, we do not want to lose memory to
fragmentation effects. Hence a very simple allocator is used to guarantee that
the memory used for each packet is returned to the page allocator.

(Note on the name SOCK_VMIO; the basic problem is a circular dependency between
the network and virtual memory subsystems which needs to be broken. This does
make VM network IO - and only VM network IO - special, it does not generalize)

Converted protocols:
IPv4 & IPv6:
 - icmp
 - udp
 - tcp
IPv4:
 - igmp

Caveat: currently there is no support for higher order allocations. So 
basically everything jumbo frame will fail for these situations. To mitigate
this one could add a tiny pool of pre-allocated 2nd-order pages to the
emergency allocator.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>
CC: David Miller <davem@davemloft.net>
CC: Mike Christie <michaelc@cs.wisc.edu>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Pavel Machek <pavel@ucw.cz>
---
 include/linux/gfp.h    |    3 +
 include/linux/mmzone.h |    1 
 include/linux/skbuff.h |   13 +++++--
 include/net/sock.h     |   39 +++++++++++++++++++++
 mm/page_alloc.c        |   35 +++++++++++++++++--
 net/core/skbuff.c      |   85 +++++++++++++++++++++++++++++++++++++----------
 net/core/sock.c        |   88 +++++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/icmp.c        |    3 +
 net/ipv4/igmp.c        |    3 +
 net/ipv4/tcp_ipv4.c    |    3 +
 net/ipv4/udp.c         |    8 +++-
 net/ipv6/icmp.c        |    3 +
 net/ipv6/tcp_ipv6.c    |    3 +
 net/ipv6/udp.c         |    3 +
 14 files changed, 263 insertions(+), 27 deletions(-)

Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h
+++ linux-2.6/include/linux/gfp.h
@@ -46,6 +46,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_EMERGENCY  ((__force gfp_t)0x40000u) /* Use emergency reserves */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -54,7 +55,7 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_EMERGENCY)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
Index: linux-2.6/include/linux/mmzone.h
===================================================================
--- linux-2.6.orig/include/linux/mmzone.h
+++ linux-2.6/include/linux/mmzone.h
@@ -421,6 +421,7 @@ int percpu_pagelist_fraction_sysctl_hand
 					void __user *, size_t *, loff_t *);
 int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
 			struct file *, void __user *, size_t *, loff_t *);
+void adjust_memalloc_reserve(int pages);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
Index: linux-2.6/include/linux/skbuff.h
===================================================================
--- linux-2.6.orig/include/linux/skbuff.h
+++ linux-2.6/include/linux/skbuff.h
@@ -282,7 +282,8 @@ struct sk_buff {
 				nfctinfo:3;
 	__u8			pkt_type:3,
 				fclone:2,
-				ipvs_property:1;
+				ipvs_property:1,
+				emergency:1;
 	__be16			protocol;
 
 	void			(*destructor)(struct sk_buff *skb);
@@ -327,10 +328,13 @@ struct sk_buff {
 
 #include <asm/system.h>
 
+#define SKB_ALLOC_FCLONE	0x01
+#define SKB_ALLOC_RX		0x02
+
 extern void kfree_skb(struct sk_buff *skb);
 extern void	       __kfree_skb(struct sk_buff *skb);
 extern struct sk_buff *__alloc_skb(unsigned int size,
-				   gfp_t priority, int fclone);
+				   gfp_t priority, int flags);
 static inline struct sk_buff *alloc_skb(unsigned int size,
 					gfp_t priority)
 {
@@ -340,7 +344,7 @@ static inline struct sk_buff *alloc_skb(
 static inline struct sk_buff *alloc_skb_fclone(unsigned int size,
 					       gfp_t priority)
 {
-	return __alloc_skb(size, priority, 1);
+	return __alloc_skb(size, priority, SKB_ALLOC_FCLONE);
 }
 
 extern struct sk_buff *alloc_skb_from_cache(kmem_cache_t *cp,
@@ -1101,7 +1105,8 @@ static inline void __skb_queue_purge(str
 static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
 					      gfp_t gfp_mask)
 {
-	struct sk_buff *skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
+	struct sk_buff *skb =
+		__alloc_skb(length + NET_SKB_PAD, gfp_mask, SKB_ALLOC_RX);
 	if (likely(skb))
 		skb_reserve(skb, NET_SKB_PAD);
 	return skb;
Index: linux-2.6/include/net/sock.h
===================================================================
--- linux-2.6.orig/include/net/sock.h
+++ linux-2.6/include/net/sock.h
@@ -391,6 +391,7 @@ enum sock_flags {
 	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
 	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
 	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
+	SOCK_VMIO, /* the VM depends on us - make sure we're serviced */
 };
 
 static inline void sock_copy_flags(struct sock *nsk, struct sock *osk)
@@ -413,6 +414,44 @@ static inline int sock_flag(struct sock 
 	return test_bit(flag, &sk->sk_flags);
 }
 
+static inline int sk_has_vmio(struct sock *sk)
+{
+	return sock_flag(sk, SOCK_VMIO);
+}
+
+#define MAX_PAGES_PER_PACKET 2
+#define MAX_FRAGMENTS ((65536 + 1500 - 1) / 1500)
+/*
+ * Set an upper limit on the number of pages used for RX skbs.
+ */
+#define RX_RESERVE_PAGES	(64 * MAX_PAGES_PER_PACKET)
+
+/*
+ * Guestimate the per request queue TX upper bound.
+ */
+#define TX_RESERVE_PAGES \
+	(4 * MAX_FRAGMENTS * MAX_PAGES_PER_PACKET)
+
+extern atomic_t vmio_socks;
+extern atomic_t emergency_rx_pages_used;
+
+static inline int sk_vmio_socks(void)
+{
+	return atomic_read(&vmio_socks);
+}
+
+extern void * sk_emergency_rx_alloc(size_t size, gfp_t gfp_mask);
+
+static inline void sk_emergency_rx_free(void *page, size_t size)
+{
+	free_page((unsigned long)page);
+	atomic_dec(&emergency_rx_pages_used);
+}
+
+extern void sk_adjust_memalloc(int socks, int tx_reserve_pages);
+extern int sk_set_vmio(struct sock *sk);
+extern int sk_clear_vmio(struct sock *sk);
+
 static inline void sk_acceptq_removed(struct sock *sk)
 {
 	sk->sk_ack_backlog--;
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -83,6 +83,7 @@ EXPORT_SYMBOL(zone_table);
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 static DEFINE_SPINLOCK(min_free_lock);
 int min_free_kbytes = 1024;
+int var_free_kbytes;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
@@ -971,8 +972,8 @@ restart:
 
 	/* This allocation should allow future memory freeing. */
 
-	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
-			&& !in_interrupt()) {
+	if ((((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
+			&& !in_interrupt()) || (gfp_mask & __GFP_EMERGENCY)) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 nofail_alloc:
 			/* go through the zonelist yet again, ignoring mins */
@@ -2197,7 +2198,8 @@ static void setup_per_zone_lowmem_reserv
  */
 static void __setup_per_zone_pages_min(void)
 {
-	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
+	unsigned pages_min = (min_free_kbytes + var_free_kbytes)
+		>> (PAGE_SHIFT - 10);
 	unsigned long lowmem_pages = 0;
 	struct zone *zone;
 	unsigned long flags;
@@ -2258,6 +2260,33 @@ void setup_per_zone_pages_min(void)
 	spin_unlock_irqrestore(&min_free_lock, flags);
 }
 
+/**
+ *	adjust_memalloc_reserve - adjust the memalloc reserve
+ *	@pages: number of pages to add
+ *
+ *	It adds a number of pages to the memalloc reserve; if
+ *	the number was positive it kicks kswapd into action to
+ *	satisfy the higher watermarks.
+ *
+ *	NOTE: there is only a single caller, hence no locking.
+ */
+void adjust_memalloc_reserve(int pages)
+{
+	var_free_kbytes += pages << (PAGE_SHIFT - 10);
+	BUG_ON(var_free_kbytes < 0);
+	setup_per_zone_pages_min();
+	if (pages > 0) {
+		struct zone *zone;
+		for_each_zone(zone)
+			wakeup_kswapd(zone, 0);
+	}
+	if (pages)
+		printk(KERN_DEBUG "Emergency reserve: %d\n",
+				var_free_kbytes);
+}
+
+EXPORT_SYMBOL_GPL(adjust_memalloc_reserve);
+
 /*
  * Initialise min_free_kbytes.
  *
Index: linux-2.6/net/core/skbuff.c
===================================================================
--- linux-2.6.orig/net/core/skbuff.c
+++ linux-2.6/net/core/skbuff.c
@@ -139,28 +139,30 @@ EXPORT_SYMBOL(skb_truesize_bug);
  *	Buffers may only be allocated from interrupts using a @gfp_mask of
  *	%GFP_ATOMIC.
  */
-struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
-			    int fclone)
+struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask, int flags)
 {
 	kmem_cache_t *cache;
 	struct skb_shared_info *shinfo;
 	struct sk_buff *skb;
 	u8 *data;
 
-	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
+	size = SKB_DATA_ALIGN(size);
+	cache = (flags & SKB_ALLOC_FCLONE)
+		? skbuff_fclone_cache : skbuff_head_cache;
 
 	/* Get the HEAD */
 	skb = kmem_cache_alloc(cache, gfp_mask & ~__GFP_DMA);
 	if (!skb)
-		goto out;
+		goto noskb;
 
 	/* Get the DATA. Size must match skb_add_mtu(). */
-	size = SKB_DATA_ALIGN(size);
 	data = ____kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
+allocated:
 	memset(skb, 0, offsetof(struct sk_buff, truesize));
+	skb->emergency = !cache;
 	skb->truesize = size + sizeof(struct sk_buff);
 	atomic_set(&skb->users, 1);
 	skb->head = data;
@@ -177,7 +179,7 @@ struct sk_buff *__alloc_skb(unsigned int
 	shinfo->ip6_frag_id = 0;
 	shinfo->frag_list = NULL;
 
-	if (fclone) {
+	if (flags & SKB_ALLOC_FCLONE) {
 		struct sk_buff *child = skb + 1;
 		atomic_t *fclone_ref = (atomic_t *) (child + 1);
 
@@ -185,13 +187,34 @@ struct sk_buff *__alloc_skb(unsigned int
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
-	goto out;
+noskb:
+	/* Attempt emergency allocation when RX skb. */
+	if (!(flags & SKB_ALLOC_RX) || !sk_vmio_socks())
+		goto out;
+
+	skb = sk_emergency_rx_alloc(kmem_cache_size(cache),
+			gfp_mask | __GFP_EMERGENCY);
+	if (!skb)
+		goto out;
+
+	data = sk_emergency_rx_alloc(size + sizeof(struct skb_shared_info),
+			gfp_mask | __GFP_EMERGENCY);
+	if (!data) {
+		sk_emergency_rx_free(skb, kmem_cache_size(cache));
+		skb = NULL;
+		goto out;
+	}
+
+	cache = NULL;
+	goto allocated;
 }
 
 /**
@@ -267,7 +290,7 @@ struct sk_buff *__netdev_alloc_skb(struc
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
+	skb = __alloc_skb(length + NET_SKB_PAD, gfp_mask, SKB_ALLOC_RX);
 	if (likely(skb)) {
 		skb_reserve(skb, NET_SKB_PAD);
 		skb->dev = dev;
@@ -315,7 +338,12 @@ static void skb_release_data(struct sk_b
 		if (skb_shinfo(skb)->frag_list)
 			skb_drop_fraglist(skb);
 
-		kfree(skb->head);
+		if (skb->emergency)
+			sk_emergency_rx_free(skb->head,
+					(skb->end - skb->head) +
+					sizeof(struct skb_shared_info));
+		else
+			kfree(skb->head);
 	}
 }
 
@@ -324,24 +352,26 @@ static void skb_release_data(struct sk_b
  */
 void kfree_skbmem(struct sk_buff *skb)
 {
-	struct sk_buff *other;
+	struct kmem_cache *cache = skbuff_head_cache;
+	struct sk_buff *free = skb;
 	atomic_t *fclone_ref;
 
 	skb_release_data(skb);
 	switch (skb->fclone) {
 	case SKB_FCLONE_UNAVAILABLE:
-		kmem_cache_free(skbuff_head_cache, skb);
-		break;
+		goto free;
 
 	case SKB_FCLONE_ORIG:
+		cache = skbuff_fclone_cache;
 		fclone_ref = (atomic_t *) (skb + 2);
 		if (atomic_dec_and_test(fclone_ref))
-			kmem_cache_free(skbuff_fclone_cache, skb);
-		break;
+			goto free;
+		return;
 
 	case SKB_FCLONE_CLONE:
+		cache = skbuff_fclone_cache;
 		fclone_ref = (atomic_t *) (skb + 1);
-		other = skb - 1;
+		free = skb - 1;
 
 		/* The clone portion is available for
 		 * fast-cloning again.
@@ -349,9 +379,15 @@ void kfree_skbmem(struct sk_buff *skb)
 		skb->fclone = SKB_FCLONE_UNAVAILABLE;
 
 		if (atomic_dec_and_test(fclone_ref))
-			kmem_cache_free(skbuff_fclone_cache, other);
-		break;
+			goto free;
+		return;
 	};
+
+free:
+	if (skb->emergency)
+		sk_emergency_rx_free(free, kmem_cache_size(cache));
+	else
+		kmem_cache_free(cache, free);
 }
 
 /**
@@ -435,6 +471,12 @@ struct sk_buff *skb_clone(struct sk_buff
 		atomic_t *fclone_ref = (atomic_t *) (n + 1);
 		n->fclone = SKB_FCLONE_CLONE;
 		atomic_inc(fclone_ref);
+	} else if (skb->emergency) {
+		n = sk_emergency_rx_alloc(kmem_cache_size(skbuff_head_cache),
+				gfp_mask | __GFP_EMERGENCY);
+		if (!n)
+			return NULL;
+		n->fclone = SKB_FCLONE_UNAVAILABLE;
 	} else {
 		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
 		if (!n)
@@ -470,6 +512,7 @@ struct sk_buff *skb_clone(struct sk_buff
 #if defined(CONFIG_IP_VS) || defined(CONFIG_IP_VS_MODULE)
 	C(ipvs_property);
 #endif
+	C(emergency);
 	C(protocol);
 	n->destructor = NULL;
 #ifdef CONFIG_NETFILTER
@@ -690,7 +733,13 @@ int pskb_expand_head(struct sk_buff *skb
 
 	size = SKB_DATA_ALIGN(size);
 
-	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+	if (skb->emergency) {
+		data = sk_emergency_rx_alloc(size + sizeof(struct skb_shared_info),
+				gfp_mask | __GFP_EMERGENCY);
+		if (!data)
+			goto nodata;
+	} else
+		data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
Index: linux-2.6/net/ipv4/icmp.c
===================================================================
--- linux-2.6.orig/net/ipv4/icmp.c
+++ linux-2.6/net/ipv4/icmp.c
@@ -938,6 +938,9 @@ int icmp_rcv(struct sk_buff *skb)
 			goto error;
 	}
 
+	if (unlikely(skb->emergency))
+		goto drop;
+
 	if (!pskb_pull(skb, sizeof(struct icmphdr)))
 		goto error;
 
Index: linux-2.6/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6.orig/net/ipv4/tcp_ipv4.c
+++ linux-2.6/net/ipv4/tcp_ipv4.c
@@ -1093,6 +1093,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!sk)
 		goto no_tcp_socket;
 
+	if (unlikely(skb->emergency && !sk_has_vmio(sk)))
+		goto discard_and_relse;
+
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
Index: linux-2.6/net/ipv4/udp.c
===================================================================
--- linux-2.6.orig/net/ipv4/udp.c
+++ linux-2.6/net/ipv4/udp.c
@@ -1136,7 +1136,12 @@ int udp_rcv(struct sk_buff *skb)
 	sk = udp_v4_lookup(saddr, uh->source, daddr, uh->dest, skb->dev->ifindex);
 
 	if (sk != NULL) {
-		int ret = udp_queue_rcv_skb(sk, skb);
+		int ret;
+
+		if (unlikely(skb->emergency && !sk_has_vmio(sk)))
+			goto drop_noncritical;
+
+		ret = udp_queue_rcv_skb(sk, skb);
 		sock_put(sk);
 
 		/* a return value > 0 means to resubmit the input, but
@@ -1147,6 +1152,7 @@ int udp_rcv(struct sk_buff *skb)
 		return 0;
 	}
 
+drop_noncritical:
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto drop;
 	nf_reset(skb);
Index: linux-2.6/net/core/sock.c
===================================================================
--- linux-2.6.orig/net/core/sock.c
+++ linux-2.6/net/core/sock.c
@@ -195,6 +195,93 @@ __u32 sysctl_rmem_default = SK_RMEM_MAX;
 /* Maximal space eaten by iovec or ancilliary data plus some space */
 int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
 
+static DEFINE_SPINLOCK(memalloc_lock);
+
+atomic_t vmio_socks;
+atomic_t emergency_rx_pages_used;
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
+ *	   we need not account the pages like we do for %RX_RESERVE_PAGES.
+ */
+void sk_adjust_memalloc(int socks, int tx_reserve_pages)
+{
+	unsigned long flags;
+	int reserve = tx_reserve_pages;
+	int nr_socks;
+
+	spin_lock_irqsave(&memalloc_lock, flags);
+	if (socks) {
+		nr_socks = atomic_add_return(socks, &vmio_socks);
+		BUG_ON(nr_socks < 0);
+
+		if (nr_socks - socks == 0)
+			reserve += RX_RESERVE_PAGES;
+		if (nr_socks == 0)
+			reserve -= RX_RESERVE_PAGES;
+	}
+	adjust_memalloc_reserve(reserve);
+	spin_unlock_irqrestore(&memalloc_lock, flags);
+}
+EXPORT_SYMBOL_GPL(sk_adjust_memalloc);
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
+void * sk_emergency_rx_alloc(size_t size, gfp_t gfp_mask)
+{
+	void * page = NULL;
+
+	if (size > PAGE_SIZE)
+		return page;
+
+	if (atomic_add_unless(&emergency_rx_pages_used, 1, RX_RESERVE_PAGES)) {
+		page = (void *)__get_free_page(gfp_mask);
+		if (!page) {
+			WARN_ON(1);
+			atomic_dec(&emergency_rx_pages_used);
+		}
+	}
+
+	return page;
+}
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
 	struct timeval tv;
@@ -881,6 +968,7 @@ void sk_free(struct sock *sk)
 	struct sk_filter *filter;
 	struct module *owner = sk->sk_prot_creator->owner;
 
+	sk_clear_vmio(sk);
 	if (sk->sk_destruct)
 		sk->sk_destruct(sk);
 
Index: linux-2.6/net/ipv6/icmp.c
===================================================================
--- linux-2.6.orig/net/ipv6/icmp.c
+++ linux-2.6/net/ipv6/icmp.c
@@ -599,6 +599,9 @@ static int icmpv6_rcv(struct sk_buff **p
 
 	ICMP6_INC_STATS_BH(idev, ICMP6_MIB_INMSGS);
 
+	if (unlikely(skb->emergency))
+		goto discard_it;
+
 	saddr = &skb->nh.ipv6h->saddr;
 	daddr = &skb->nh.ipv6h->daddr;
 
Index: linux-2.6/net/ipv6/tcp_ipv6.c
===================================================================
--- linux-2.6.orig/net/ipv6/tcp_ipv6.c
+++ linux-2.6/net/ipv6/tcp_ipv6.c
@@ -1216,6 +1216,9 @@ static int tcp_v6_rcv(struct sk_buff **p
 	if (!sk)
 		goto no_tcp_socket;
 
+	if (unlikely(skb->emergency && !sk_has_vmio(sk)))
+		goto discard_and_relse;
+
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
Index: linux-2.6/net/ipv6/udp.c
===================================================================
--- linux-2.6.orig/net/ipv6/udp.c
+++ linux-2.6/net/ipv6/udp.c
@@ -499,6 +499,9 @@ static int udpv6_rcv(struct sk_buff **ps
 	sk = udp_v6_lookup(saddr, uh->source, daddr, uh->dest, dev->ifindex);
 
 	if (sk == NULL) {
+		if (unlikely(skb->emergency && !sk_has_vmio(sk)))
+			goto discard;
+
 		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
 			goto discard;
 
Index: linux-2.6/net/ipv4/igmp.c
===================================================================
--- linux-2.6.orig/net/ipv4/igmp.c
+++ linux-2.6/net/ipv4/igmp.c
@@ -927,6 +927,9 @@ int igmp_rcv(struct sk_buff *skb)
 		return 0;
 	}
 
+	if (unlikely(skb->emergency))
+		goto drop;
+
 	if (!pskb_may_pull(skb, sizeof(struct igmphdr)))
 		goto drop;
 

--

