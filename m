Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWHLOPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWHLOPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWHLOPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:15:44 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:49365 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S964833AbWHLOPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:15:33 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Indan Zupancic <indan@nul.nu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Sat, 12 Aug 2006 16:14:45 +0200
Message-Id: <20060812141445.30842.47336.sendpatchset@lappy>
In-Reply-To: <20060812141415.30842.78695.sendpatchset@lappy>
References: <20060812141415.30842.78695.sendpatchset@lappy>
Subject: [RFC][PATCH 3/4] deadlock prevention core
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The core of the VM deadlock avoidance framework.

>From the 'user' side of things it provides a function to mark a 'struct sock'
as SOCK_MEMALLOC, meaning this socket may dip into the memalloc reserves on
the receive side.

When *dev_alloc_skb() finds it cannot allocate a struct sk_buff the regular
way it will grab some memory from the memalloc reserve.

Network paths will drop !SOCK_MEMALLOC packets ASAP when reserve is being used.

Memalloc sk_buff allocations are not done from the SLAB but are done using 
the new SROG allocator. sk_buff::memalloc records this exception so that 
kfree_skbmem()/skb_clone() and others can do the right thing.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 include/linux/gfp.h    |    3 -
 include/linux/mmzone.h |    1 
 include/linux/skbuff.h |    6 +-
 include/net/sock.h     |   40 +++++++++++++++
 mm/page_alloc.c        |   41 ++++++++++++++-
 net/core/skbuff.c      |  127 ++++++++++++++++++++++++++++++++++++++++++++-----
 net/core/sock.c        |   74 ++++++++++++++++++++++++++++
 net/ipv4/af_inet.c     |    3 +
 net/ipv4/icmp.c        |    3 +
 net/ipv4/tcp_ipv4.c    |    3 +
 net/ipv4/udp.c         |    8 ++-
 11 files changed, 290 insertions(+), 19 deletions(-)

Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/include/linux/gfp.h	2006-08-12 12:56:09.000000000 +0200
@@ -46,6 +46,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_MEMALLOC  ((__force gfp_t)0x40000u) /* Use emergency reserves */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -54,7 +55,7 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_MEMALLOC)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
Index: linux-2.6/include/linux/mmzone.h
===================================================================
--- linux-2.6.orig/include/linux/mmzone.h	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/include/linux/mmzone.h	2006-08-12 12:56:09.000000000 +0200
@@ -420,6 +420,7 @@ int percpu_pagelist_fraction_sysctl_hand
 					void __user *, size_t *, loff_t *);
 int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
 			struct file *, void __user *, size_t *, loff_t *);
+int adjust_memalloc_reserve(int bytes);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
Index: linux-2.6/include/linux/skbuff.h
===================================================================
--- linux-2.6.orig/include/linux/skbuff.h	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/include/linux/skbuff.h	2006-08-12 15:25:33.000000000 +0200
@@ -282,7 +282,8 @@ struct sk_buff {
 				nfctinfo:3;
 	__u8			pkt_type:3,
 				fclone:2,
-				ipvs_property:1;
+				ipvs_property:1,
+				memalloc:1;
 	__be16			protocol;
 
 	void			(*destructor)(struct sk_buff *skb);
@@ -1086,7 +1087,8 @@ static inline void __skb_queue_purge(str
 static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
 					      gfp_t gfp_mask)
 {
-	struct sk_buff *skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
+	struct sk_buff *skb = alloc_skb(length + NET_SKB_PAD,
+			gfp_mask | __GFP_MEMALLOC);
 	if (likely(skb))
 		skb_reserve(skb, NET_SKB_PAD);
 	return skb;
Index: linux-2.6/include/net/sock.h
===================================================================
--- linux-2.6.orig/include/net/sock.h	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/include/net/sock.h	2006-08-12 12:56:38.000000000 +0200
@@ -391,6 +391,7 @@ enum sock_flags {
 	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
 	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
 	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
+	SOCK_MEMALLOC, /* protocol can use memalloc reserve */
 };
 
 static inline void sock_copy_flags(struct sock *nsk, struct sock *osk)
@@ -413,6 +414,45 @@ static inline int sock_flag(struct sock 
 	return test_bit(flag, &sk->sk_flags);
 }
 
+static inline int sk_is_memalloc(struct sock *sk)
+{
+	return sock_flag(sk, SOCK_MEMALLOC);
+}
+
+/*
+ * Is this high enough, or do we want it to depend on the number of
+ * online devices and online CPUs?
+ *
+ *  #define MAX_CONCURRENT_SKBS (64*nr_devices*num_online_cpus())
+ */
+#define MAX_CONCURRENT_SKBS	128
+
+/*
+ * Used to count skb payloads.
+ *
+ * The assumption is that the sk_buffs themselves are small enough to fit
+ * in the remaining page space.
+ */
+extern atomic_t memalloc_skbs_used;
+
+static inline int memalloc_skbs_try_inc(void)
+{
+	return atomic_add_unless(&memalloc_skbs_used, 1, MAX_CONCURRENT_SKBS);
+}
+
+static inline void memalloc_skbs_dec(void)
+{
+	atomic_dec(&memalloc_skbs_used);
+}
+
+static inline int memalloc_skbs_available(void)
+{
+	return atomic_read(&memalloc_skbs_used) < MAX_CONCURRENT_SKBS;
+}
+
+extern int sk_adjust_memalloc(int);
+extern int sk_set_memalloc(struct sock *sk);
+
 static inline void sk_acceptq_removed(struct sock *sk)
 {
 	sk->sk_ack_backlog--;
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/mm/page_alloc.c	2006-08-12 12:56:09.000000000 +0200
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
+			&& !in_interrupt()) || (gfp_mask & __GFP_MEMALLOC)) {
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
+	printk(KERN_DEBUG "RX reserve: %d\n", var_free_kbytes);
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
--- linux-2.6.orig/net/core/skbuff.c	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/net/core/skbuff.c	2006-08-12 15:28:15.000000000 +0200
@@ -43,6 +43,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/srog.h>
 #include <linux/interrupt.h>
 #include <linux/in.h>
 #include <linux/inet.h>
@@ -126,7 +127,7 @@ EXPORT_SYMBOL(skb_truesize_bug);
  */
 
 /**
- *	__alloc_skb	-	allocate a network buffer
+ *	___alloc_skb	-	allocate a network buffer
  *	@size: size to allocate
  *	@gfp_mask: allocation mask
  *	@fclone: allocate from fclone cache instead of head cache
@@ -139,14 +140,45 @@ EXPORT_SYMBOL(skb_truesize_bug);
  *	Buffers may only be allocated from interrupts using a @gfp_mask of
  *	%GFP_ATOMIC.
  */
-struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
-			    int fclone)
+static
+struct sk_buff *___alloc_skb(unsigned int size, gfp_t gfp_mask, int fclone)
 {
 	kmem_cache_t *cache;
 	struct skb_shared_info *shinfo;
 	struct sk_buff *skb;
 	u8 *data;
 
+	size = SKB_DATA_ALIGN(size);
+
+	if (gfp_mask & __GFP_MEMALLOC) {
+		cache = NULL;
+		skb = NULL;
+		if (!memalloc_skbs_try_inc())
+			goto out;
+
+		/*
+		 * Allocate the data section first because we know the first
+		 * SROG alloc is a valid SROG entry point and skb->head is
+		 * shared between clones. This saves us from tracking SROGs.
+		 */
+		data = srog_alloc(NULL, size + sizeof(struct skb_shared_info),
+				gfp_mask);
+		if (!data)
+			goto dec_out;
+
+		skb = srog_alloc(data, fclone
+				? 2*sizeof(struct sk_buff) + sizeof(atomic_t)
+				: sizeof(struct sk_buff), gfp_mask);
+		if (!skb) {
+			srog_free(NULL, data);
+dec_out:
+			memalloc_skbs_dec();
+			goto out;
+		}
+
+		goto allocated;
+	}
+
 	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
 
 	/* Get the HEAD */
@@ -155,12 +187,13 @@ struct sk_buff *__alloc_skb(unsigned int
 		goto out;
 
 	/* Get the DATA. Size must match skb_add_mtu(). */
-	size = SKB_DATA_ALIGN(size);
 	data = ____kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
+allocated:
 	memset(skb, 0, offsetof(struct sk_buff, truesize));
+	skb->memalloc = !cache;
 	skb->truesize = size + sizeof(struct sk_buff);
 	atomic_set(&skb->users, 1);
 	skb->head = data;
@@ -185,6 +218,7 @@ struct sk_buff *__alloc_skb(unsigned int
 		atomic_set(fclone_ref, 1);
 
 		child->fclone = SKB_FCLONE_UNAVAILABLE;
+		child->memalloc = skb->memalloc;
 	}
 out:
 	return skb;
@@ -194,6 +228,18 @@ nodata:
 	goto out;
 }
 
+struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask, int fclone)
+{
+	struct sk_buff *skb;
+
+	skb = ___alloc_skb(size, gfp_mask & ~__GFP_MEMALLOC, fclone);
+
+	if (!skb && (gfp_mask & __GFP_MEMALLOC) && memalloc_skbs_available())
+		skb = ___alloc_skb(size, gfp_mask, fclone);
+
+	return skb;
+}
+
 /**
  *	alloc_skb_from_cache	-	allocate a network buffer
  *	@cp: kmem_cache from which to allocate the data area
@@ -267,7 +313,7 @@ struct sk_buff *__netdev_alloc_skb(struc
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
+	skb = alloc_skb(length + NET_SKB_PAD, gfp_mask | __GFP_MEMALLOC);
 	if (likely(skb))
 		skb_reserve(skb, NET_SKB_PAD);
 	return skb;
@@ -299,7 +345,7 @@ static void skb_clone_fraglist(struct sk
 		skb_get(list);
 }
 
-static void skb_release_data(struct sk_buff *skb)
+static int skb_release_data(struct sk_buff *skb)
 {
 	if (!skb->cloned ||
 	    !atomic_sub_return(skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1,
@@ -313,8 +359,34 @@ static void skb_release_data(struct sk_b
 		if (skb_shinfo(skb)->frag_list)
 			skb_drop_fraglist(skb);
 
-		kfree(skb->head);
+		return 1;
 	}
+	return 0;
+}
+
+static void memalloc_free_skb(struct kmem_cache *cache, void *objp, int free)
+{
+	/*
+	 * This complication is necessary because we need a valid SROG
+	 * pointer. If we let skb_release_data() free the skb data, we
+	 * loose the only valid SROG entry point we know about.
+	 */
+	struct sk_buff *skb = objp;
+	u8 *data = skb->head;
+	srog_free(data, objp);
+	if (free) {
+		srog_free(NULL, data);
+		memalloc_skbs_dec();
+	}
+}
+
+static void kmem_cache_free_skb(struct kmem_cache *cache, void *objp, int free)
+{
+	struct sk_buff *skb = objp;
+	u8 *data = skb->head;
+	kmem_cache_free(cache, objp);
+	if (free)
+		kfree(data);
 }
 
 /*
@@ -324,17 +396,22 @@ void kfree_skbmem(struct sk_buff *skb)
 {
 	struct sk_buff *other;
 	atomic_t *fclone_ref;
+	void (*free_skb)(struct kmem_cache *, void *, int);
+	int free;
+
+	free = skb_release_data(skb);
+
+	free_skb = skb->memalloc ? memalloc_free_skb : kmem_cache_free_skb;
 
-	skb_release_data(skb);
 	switch (skb->fclone) {
 	case SKB_FCLONE_UNAVAILABLE:
-		kmem_cache_free(skbuff_head_cache, skb);
+		free_skb(skbuff_head_cache, skb, free);
 		break;
 
 	case SKB_FCLONE_ORIG:
 		fclone_ref = (atomic_t *) (skb + 2);
 		if (atomic_dec_and_test(fclone_ref))
-			kmem_cache_free(skbuff_fclone_cache, skb);
+			free_skb(skbuff_fclone_cache, skb, free);
 		break;
 
 	case SKB_FCLONE_CLONE:
@@ -347,7 +424,7 @@ void kfree_skbmem(struct sk_buff *skb)
 		skb->fclone = SKB_FCLONE_UNAVAILABLE;
 
 		if (atomic_dec_and_test(fclone_ref))
-			kmem_cache_free(skbuff_fclone_cache, other);
+			free_skb(skbuff_fclone_cache, other, free);
 		break;
 	};
 }
@@ -433,6 +510,11 @@ struct sk_buff *skb_clone(struct sk_buff
 		atomic_t *fclone_ref = (atomic_t *) (n + 1);
 		n->fclone = SKB_FCLONE_CLONE;
 		atomic_inc(fclone_ref);
+	} else if (skb->memalloc) {
+		n = srog_alloc(skb->head, sizeof(struct sk_buff), gfp_mask);
+		if (!n)
+			return NULL;
+		n->fclone = SKB_FCLONE_UNAVAILABLE;
 	} else {
 		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
 		if (!n)
@@ -468,6 +550,7 @@ struct sk_buff *skb_clone(struct sk_buff
 #if defined(CONFIG_IP_VS) || defined(CONFIG_IP_VS_MODULE)
 	C(ipvs_property);
 #endif
+	C(memalloc);
 	C(protocol);
 	n->destructor = NULL;
 #ifdef CONFIG_NETFILTER
@@ -688,7 +771,27 @@ int pskb_expand_head(struct sk_buff *skb
 
 	size = SKB_DATA_ALIGN(size);
 
-	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+	if (skb->memalloc) {
+		if (!memalloc_skbs_try_inc())
+			goto nodata;
+		/*
+		 * Unfortunately we have to assume skb->head is in the first
+		 * page of the SROG, hence we cannot reuse the old one.
+		 */
+		data = srog_alloc(NULL,
+				size + sizeof(struct skb_shared_info),
+				gfp_mask | __GFP_MEMALLOC);
+		if (!data) {
+			memalloc_skbs_dec();
+			goto nodata;
+		}
+		/*
+		 * But they must end up in the same SROG otherwise we cannot
+		 * reliably free clones.
+		 */
+		srog_link(skb->head, data);
+	} else
+		data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
Index: linux-2.6/net/ipv4/icmp.c
===================================================================
--- linux-2.6.orig/net/ipv4/icmp.c	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/net/ipv4/icmp.c	2006-08-12 12:56:09.000000000 +0200
@@ -938,6 +938,9 @@ int icmp_rcv(struct sk_buff *skb)
 			goto error;
 	}
 
+	if (unlikely(skb->memalloc))
+		goto drop;
+
 	if (!pskb_pull(skb, sizeof(struct icmphdr)))
 		goto error;
 
Index: linux-2.6/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6.orig/net/ipv4/tcp_ipv4.c	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/net/ipv4/tcp_ipv4.c	2006-08-12 12:56:09.000000000 +0200
@@ -1093,6 +1093,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!sk)
 		goto no_tcp_socket;
 
+	if (unlikely(skb->memalloc && !sk_is_memalloc(sk)))
+		goto discard_and_relse;
+
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
Index: linux-2.6/net/ipv4/udp.c
===================================================================
--- linux-2.6.orig/net/ipv4/udp.c	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/net/ipv4/udp.c	2006-08-12 12:56:09.000000000 +0200
@@ -1136,7 +1136,12 @@ int udp_rcv(struct sk_buff *skb)
 	sk = udp_v4_lookup(saddr, uh->source, daddr, uh->dest, skb->dev->ifindex);
 
 	if (sk != NULL) {
-		int ret = udp_queue_rcv_skb(sk, skb);
+		int ret;
+
+		if (unlikely(skb->memalloc && !sk_is_memalloc(sk)))
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
--- linux-2.6.orig/net/ipv4/af_inet.c	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/net/ipv4/af_inet.c	2006-08-12 12:56:09.000000000 +0200
@@ -132,6 +132,9 @@ void inet_sock_destruct(struct sock *sk)
 {
 	struct inet_sock *inet = inet_sk(sk);
 
+	if (sk_is_memalloc(sk))
+		sk_adjust_memalloc(-1);
+
 	__skb_queue_purge(&sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_error_queue);
 
Index: linux-2.6/net/core/sock.c
===================================================================
--- linux-2.6.orig/net/core/sock.c	2006-08-12 12:56:06.000000000 +0200
+++ linux-2.6/net/core/sock.c	2006-08-12 13:02:59.000000000 +0200
@@ -111,6 +111,8 @@
 #include <linux/poll.h>
 #include <linux/tcp.h>
 #include <linux/init.h>
+#include <linux/inetdevice.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -195,6 +197,78 @@ __u32 sysctl_rmem_default = SK_RMEM_MAX;
 /* Maximal space eaten by iovec or ancilliary data plus some space */
 int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
 
+static DEFINE_SPINLOCK(memalloc_lock);
+static int memalloc_socks;
+static unsigned long memalloc_reserve;
+
+atomic_t memalloc_skbs_used;
+EXPORT_SYMBOL_GPL(memalloc_skbs_used);
+
+/**
+ *	sk_adjust_memalloc - adjust the global memalloc reserve for this device
+ *	@dev: device that has memalloc demands
+ *	@nr_socks: number of new %SOCK_MEMALLOC sockets
+ *
+ *	This function adjusts the memalloc reserve based on device
+ *	demand. For each %SOCK_MEMALLOC socket this device will reserve
+ *	2 * %MAX_PHYS_SEGMENTS pages for outbound traffic (assumption:
+ *	each %SOCK_MEMALLOC socket will have a %request_queue associated)
+ *	and 5 * %MAX_CONCURRENT_SKBS pages.
+ *
+ *	2 * %MAX_PHYS_SEGMENTS - the request queue can hold up to 150% the
+ *		remaining 50% goes to being sure we can write packets for
+ *		the outgoing pages.
+ *
+ *	5 * %MAX_CONCURRENT_SKBS - for each skb 4 pages for high order
+ *	        jumbo frame allocs, and 1 for good measure.
+ */
+int sk_adjust_memalloc(int nr_socks)
+{
+	unsigned long flags;
+	unsigned long reserve;
+	int err;
+
+	spin_lock_irqsave(&memalloc_lock, flags);
+
+	memalloc_socks += nr_socks;
+	BUG_ON(memalloc_socks < 0);
+
+	reserve = memalloc_socks * 2 * MAX_PHYS_SEGMENTS + /* outbound */
+		  MAX_CONCURRENT_SKBS * 5;		   /* inbound */
+
+	err = adjust_memalloc_reserve(reserve - memalloc_reserve);
+	if (err) {
+		printk(KERN_WARNING
+			"Unable to change RX reserve to: %lu, error: %d\n",
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
+ *	sk_set_memalloc - sets %SOCK_MEMALLOC
+ *	@sk: socket to set it on
+ *
+ *	Set %SOCK_MEMALLOC on a socket and increase the memalloc reserve
+ *	accordingly.
+ */
+int sk_set_memalloc(struct sock *sk)
+{
+	int err = 0;
+
+	if (!(err = sk_adjust_memalloc(1)))
+		sock_set_flag(sk, SOCK_MEMALLOC);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(sk_set_memalloc);
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
 	struct timeval tv;
