Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWHYPos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWHYPos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWHYPor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:44:47 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:27065 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422717AbWHYPoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:44:39 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Indan Zupancic <indan@nul.nu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Fri, 25 Aug 2006 17:39:57 +0200
Message-Id: <20060825153957.24271.6856.sendpatchset@twins>
In-Reply-To: <20060825153946.24271.42758.sendpatchset@twins>
References: <20060825153946.24271.42758.sendpatchset@twins>
Subject: [PATCH 1/4] net: VM deadlock avoidance framework
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The core of the VM deadlock avoidance framework.

In order to provide robust networked block devices there must be a guarantee
of progress. That is, the block device must never stall because of OOM because
the device itself might be needed to get out of OOM (reclaim pageout).

This means that the device queue must always be unplugable, this in turn means
that it must always find enough memory to build/send packets over the network
_and_ receive ACKs for those packets.

The network stack has a huge capacity for buffering packets; waiting for 
user-space to read them. There is a practical limit imposed to avoid DoS 
scenarios. These two things make for a deadlock; what if the receive limit is
reached and all packets are buffered in non-critical sockets (those not serving
the network block device waiting for an ACK to free a page). 

Memory pressure will add to that; what if there is simply no memory left to
receive packets in.

This patch provides a service to register sockets as critical; SOCK_VMIO
is a promise the socket will never block on receive. Along with with a memory
reserve that will service a limited number of packets this can guarantee full
service to these critical sockets.

When we make sure that packets allocated from the reserve will only service
critical sockets we will not lose the memory and can guarantee progress.

Since memory is tight and the reserve modest, we do not want to lose memory to
fragmentation effects. Hence a very simple allocator is used to guarantee that
the memory used for each packet is returned to the page allocator.

Converted protocols:
IPv4 & IPv6:
 - icmp
 - udp
 - tcp
IPv4:
 - igmp

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>
---
 include/linux/gfp.h    |    3 -
 include/linux/mmzone.h |    1 
 include/linux/skbuff.h |   13 ++++--
 include/net/sock.h     |   37 +++++++++++++++++
 mm/page_alloc.c        |   41 ++++++++++++++++++-
 net/core/skbuff.c      |  103 ++++++++++++++++++++++++++++++++++++++++++-------
 net/core/sock.c        |   97 ++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/af_inet.c     |    3 +
 net/ipv4/icmp.c        |    3 +
 net/ipv4/igmp.c        |    3 +
 net/ipv4/tcp_ipv4.c    |    3 +
 net/ipv4/udp.c         |    8 +++
 net/ipv6/af_inet6.c    |    3 +
 net/ipv6/icmp.c        |    3 +
 net/ipv6/tcp_ipv6.c    |    3 +
 net/ipv6/udp.c         |    3 +
 16 files changed, 305 insertions(+), 22 deletions(-)

Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h
+++ linux-2.6/include/linux/gfp.h
@@ -46,6 +46,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_EMERG  ((__force gfp_t)0x40000u) /* Use emergency reserves */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -54,7 +55,7 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_EMERG)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
Index: linux-2.6/include/linux/mmzone.h
===================================================================
--- linux-2.6.orig/include/linux/mmzone.h
+++ linux-2.6/include/linux/mmzone.h
@@ -420,6 +420,7 @@ int percpu_pagelist_fraction_sysctl_hand
 					void __user *, size_t *, loff_t *);
 int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
 			struct file *, void __user *, size_t *, loff_t *);
+int adjust_memalloc_reserve(int bytes);
 
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
+				emerg:1;
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
+	SOCK_VMIO, /* promise to never block on receive */
 };
 
 static inline void sock_copy_flags(struct sock *nsk, struct sock *osk)
@@ -413,6 +414,42 @@ static inline int sock_flag(struct sock 
 	return test_bit(flag, &sk->sk_flags);
 }
 
+static inline int sk_is_vmio(struct sock *sk)
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
+extern atomic_t emerg_rx_pages_used;
+
+static inline int emerg_rx_pages_try_inc(void)
+{
+	return atomic_read(&vmio_socks) &&
+		atomic_add_unless(&emerg_rx_pages_used, 1, RX_RESERVE_PAGES);
+}
+
+static inline void emerg_rx_pages_dec(void)
+{
+	atomic_dec(&emerg_rx_pages_used);
+}
+
+extern int sk_adjust_memalloc(int socks, int request_queues);
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
@@ -82,6 +82,7 @@ EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
+int var_free_kbytes;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
@@ -970,8 +971,8 @@ restart:
 
 	/* This allocation should allow future memory freeing. */
 
-	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
-			&& !in_interrupt()) {
+	if ((((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
+			&& !in_interrupt()) || (gfp_mask & __GFP_EMERG)) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 nofail_alloc:
 			/* go through the zonelist yet again, ignoring mins */
@@ -2196,7 +2197,8 @@ static void setup_per_zone_lowmem_reserv
  */
 void setup_per_zone_pages_min(void)
 {
-	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
+	unsigned pages_min = (min_free_kbytes + var_free_kbytes)
+		>> (PAGE_SHIFT - 10);
 	unsigned long lowmem_pages = 0;
 	struct zone *zone;
 	unsigned long flags;
@@ -2248,6 +2250,39 @@ void setup_per_zone_pages_min(void)
 	calculate_totalreserve_pages();
 }
 
+/**
+ *	adjust_memalloc_reserve - adjust the memalloc reserve
+ *	@pages: number of pages to add
+ *
+ *	It adds a number of pages to the memalloc reserve; if
+ *	the number was positive it kicks kswapd into action to
+ *	satisfy the higher watermarks.
+ */
+int adjust_memalloc_reserve(int pages)
+{
+	int kbytes;
+	int err = 0;
+
+	kbytes = var_free_kbytes + (pages << (PAGE_SHIFT - 10));
+	if (kbytes < 0) {
+		err = -EINVAL;
+		goto out;
+	}
+	var_free_kbytes = kbytes;
+	setup_per_zone_pages_min();
+	if (pages > 0) {
+		struct zone *zone;
+		for_each_zone(zone)
+			wakeup_kswapd(zone, 0);
+	}
+	printk(KERN_DEBUG "Emergency reserve: %d\n", var_free_kbytes);
+
+out:
+	return err;
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
+	skb->emerg = !cache;
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
 
@@ -185,13 +187,48 @@ struct sk_buff *__alloc_skb(unsigned int
 		atomic_set(fclone_ref, 1);
 
 		child->fclone = SKB_FCLONE_UNAVAILABLE;
+		child->emerg = skb->emerg;
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
+	if (!(flags & SKB_ALLOC_RX))
+		goto out;
+
+	if (size + sizeof(struct skb_shared_info) > PAGE_SIZE)
+		goto out;
+
+	if (!emerg_rx_pages_try_inc())
+		goto out;
+
+	skb = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
+	if (!skb) {
+		WARN_ON(1); /* we were promised memory but didn't get it? */
+		goto dec_out;
+	}
+
+	if (!emerg_rx_pages_try_inc())
+		goto skb_free_out;
+
+	data = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
+	if (!data) {
+		WARN_ON(1); /* we were promised memory but didn't get it? */
+		emerg_rx_pages_dec();
+skb_free_out:
+		free_page((unsigned long)skb);
+		skb = NULL;
+dec_out:
+		emerg_rx_pages_dec();
+		goto out;
+	}
+
+	cache = NULL;
+	goto allocated;
 }
 
 /**
@@ -267,7 +304,7 @@ struct sk_buff *__netdev_alloc_skb(struc
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
+	skb = __alloc_skb(length + NET_SKB_PAD, gfp_mask, SKB_ALLOC_RX);
 	if (likely(skb)) {
 		skb_reserve(skb, NET_SKB_PAD);
 		skb->dev = dev;
@@ -315,10 +352,20 @@ static void skb_release_data(struct sk_b
 		if (skb_shinfo(skb)->frag_list)
 			skb_drop_fraglist(skb);
 
-		kfree(skb->head);
+		if (skb->emerg) {
+			free_page((unsigned long)skb->head);
+			emerg_rx_pages_dec();
+		} else
+			kfree(skb->head);
 	}
 }
 
+static void emerg_free_skb(struct kmem_cache *cache, void *objp)
+{
+	free_page((unsigned long)objp);
+	emerg_rx_pages_dec();
+}
+
 /*
  *	Free an skbuff by memory without cleaning the state.
  */
@@ -326,17 +373,21 @@ void kfree_skbmem(struct sk_buff *skb)
 {
 	struct sk_buff *other;
 	atomic_t *fclone_ref;
+	void (*free_skb)(struct kmem_cache *, void *);
 
 	skb_release_data(skb);
+
+	free_skb = skb->emerg ? emerg_free_skb : kmem_cache_free;
+
 	switch (skb->fclone) {
 	case SKB_FCLONE_UNAVAILABLE:
-		kmem_cache_free(skbuff_head_cache, skb);
+		free_skb(skbuff_head_cache, skb);
 		break;
 
 	case SKB_FCLONE_ORIG:
 		fclone_ref = (atomic_t *) (skb + 2);
 		if (atomic_dec_and_test(fclone_ref))
-			kmem_cache_free(skbuff_fclone_cache, skb);
+			free_skb(skbuff_fclone_cache, skb);
 		break;
 
 	case SKB_FCLONE_CLONE:
@@ -349,7 +400,7 @@ void kfree_skbmem(struct sk_buff *skb)
 		skb->fclone = SKB_FCLONE_UNAVAILABLE;
 
 		if (atomic_dec_and_test(fclone_ref))
-			kmem_cache_free(skbuff_fclone_cache, other);
+			free_skb(skbuff_fclone_cache, other);
 		break;
 	};
 }
@@ -435,6 +486,17 @@ struct sk_buff *skb_clone(struct sk_buff
 		atomic_t *fclone_ref = (atomic_t *) (n + 1);
 		n->fclone = SKB_FCLONE_CLONE;
 		atomic_inc(fclone_ref);
+	} else if (skb->emerg) {
+		if (!emerg_rx_pages_try_inc())
+			return NULL;
+
+		n = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
+		if (!n) {
+			WARN_ON(1);
+			emerg_rx_pages_dec();
+			return NULL;
+		}
+		n->fclone = SKB_FCLONE_UNAVAILABLE;
 	} else {
 		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
 		if (!n)
@@ -470,6 +532,7 @@ struct sk_buff *skb_clone(struct sk_buff
 #if defined(CONFIG_IP_VS) || defined(CONFIG_IP_VS_MODULE)
 	C(ipvs_property);
 #endif
+	C(emerg);
 	C(protocol);
 	n->destructor = NULL;
 #ifdef CONFIG_NETFILTER
@@ -690,7 +753,21 @@ int pskb_expand_head(struct sk_buff *skb
 
 	size = SKB_DATA_ALIGN(size);
 
-	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+	if (skb->emerg) {
+		if (size + sizeof(struct skb_shared_info) > PAGE_SIZE)
+			goto nodata;
+
+		if (!emerg_rx_pages_try_inc())
+			goto nodata;
+
+		data = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
+		if (!data) {
+			WARN_ON(1);
+			emerg_rx_pages_dec();
+			goto nodata;
+		}
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
 
+	if (unlikely(skb->emerg))
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
 
+	if (unlikely(skb->emerg && !sk_is_vmio(sk)))
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
+		if (unlikely(skb->emerg && !sk_is_vmio(sk)))
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
Index: linux-2.6/net/ipv4/af_inet.c
===================================================================
--- linux-2.6.orig/net/ipv4/af_inet.c
+++ linux-2.6/net/ipv4/af_inet.c
@@ -132,6 +132,9 @@ void inet_sock_destruct(struct sock *sk)
 {
 	struct inet_sock *inet = inet_sk(sk);
 
+	if (sk_is_vmio(sk))
+		sk_clear_vmio(sk);
+
 	__skb_queue_purge(&sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_error_queue);
 
Index: linux-2.6/net/core/sock.c
===================================================================
--- linux-2.6.orig/net/core/sock.c
+++ linux-2.6/net/core/sock.c
@@ -111,6 +111,7 @@
 #include <linux/poll.h>
 #include <linux/tcp.h>
 #include <linux/init.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -195,6 +196,102 @@ __u32 sysctl_rmem_default = SK_RMEM_MAX;
 /* Maximal space eaten by iovec or ancilliary data plus some space */
 int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
 
+static DEFINE_SPINLOCK(memalloc_lock);
+static int memalloc_reserve;
+static unsigned int vmio_request_queues;
+
+atomic_t vmio_socks;
+atomic_t emerg_rx_pages_used;
+EXPORT_SYMBOL_GPL(vmio_socks);
+EXPORT_SYMBOL_GPL(emerg_rx_pages_used);
+
+/**
+ *	sk_adjust_memalloc - adjust the global memalloc reserve for critical RX
+ *	@nr_socks: number of new %SOCK_VMIO sockets
+ *
+ *	This function adjusts the memalloc reserve based on system demand.
+ *	For each %SOCK_VMIO socket this device will reserve enough
+ *	to send a few large packets (64k) at a time: %TX_RESERVE_PAGES.
+ *
+ *	Assumption:
+ *	 - each %SOCK_VMIO socket will have a %request_queue associated.
+ *
+ *	NOTE:
+ *	   %TX_RESERVE_PAGES is an upper-bound of memory used for TX hence
+ *	   we need not account the pages like we do for %RX_RESERVE_PAGES.
+ *
+ *	On top of this comes a one time charge of:
+ *	  %RX_RESERVE_PAGES pages -
+ * 		number of pages alloted for emergency skb service to critical
+ * 		sockets.
+ */
+int sk_adjust_memalloc(int socks, int request_queues)
+{
+	unsigned long flags;
+	int reserve;
+	int nr_socks;
+	int err;
+
+	spin_lock_irqsave(&memalloc_lock, flags);
+
+	atomic_add(socks, &vmio_socks);
+	nr_socks = atomic_read(&vmio_socks);
+	BUG_ON(socks < 0);
+	vmio_request_queues += request_queues;
+
+	reserve = vmio_request_queues * TX_RESERVE_PAGES + /* outbound */
+		  (!!socks) * RX_RESERVE_PAGES;            /* inbound */
+
+	err = adjust_memalloc_reserve(reserve - memalloc_reserve);
+	if (err) {
+		printk(KERN_WARNING
+			"Unable to change reserve to: %d pages, error: %d\n",
+			reserve, err);
+		goto unlock;
+	}
+	memalloc_reserve = reserve;
+
+unlock:
+	spin_unlock_irqrestore(&memalloc_lock, flags);
+	return err;
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
+	int err = 0;
+
+	if (!sock_flag(sk, SOCK_VMIO) &&
+			!(err = sk_adjust_memalloc(1, 0))) {
+		sock_set_flag(sk, SOCK_VMIO);
+		sk->sk_allocation |= __GFP_EMERG;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(sk_set_vmio);
+
+int sk_clear_vmio(struct sock *sk)
+{
+	int err = 0;
+
+	if (sock_flag(sk, SOCK_VMIO) &&
+			!(err = sk_adjust_memalloc(-1, 0))) {
+		sock_reset_flag(sk, SOCK_VMIO);
+		sk->sk_allocation &= ~__GFP_EMERG;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(sk_clear_vmio);
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
 	struct timeval tv;
Index: linux-2.6/net/ipv6/af_inet6.c
===================================================================
--- linux-2.6.orig/net/ipv6/af_inet6.c
+++ linux-2.6/net/ipv6/af_inet6.c
@@ -368,6 +368,9 @@ int inet6_destroy_sock(struct sock *sk)
 	struct sk_buff *skb;
 	struct ipv6_txoptions *opt;
 
+	if (sk_is_vmio(sk))
+		sk_clear_vmio(sk);
+
 	/* Release rx options */
 
 	if ((skb = xchg(&np->pktoptions, NULL)) != NULL)
Index: linux-2.6/net/ipv6/icmp.c
===================================================================
--- linux-2.6.orig/net/ipv6/icmp.c
+++ linux-2.6/net/ipv6/icmp.c
@@ -599,6 +599,9 @@ static int icmpv6_rcv(struct sk_buff **p
 
 	ICMP6_INC_STATS_BH(idev, ICMP6_MIB_INMSGS);
 
+	if (unlikely(skb->emerg))
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
 
+	if (unlikely(skb->emerg && !sk_is_vmio(sk)))
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
+		if (unlikely(skb->emerg && !sk_is_vmio(sk)))
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
 
+	if (unlikely(skb->emerg))
+		goto drop;
+
 	if (!pskb_may_pull(skb, sizeof(struct igmphdr)))
 		goto drop;
 
