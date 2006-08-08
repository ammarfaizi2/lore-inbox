Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWHHThs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWHHThs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWHHTeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:34:44 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:31006 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030238AbWHHTeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:34:23 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:33:45 +0200
Message-Id: <20060808193345.1396.16773.sendpatchset@lappy>
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 2/9] deadlock prevention core
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The core of the VM deadlock avoidance framework.

>From the 'user' side of things it provides a function to mark a 'struct sock'
as SOCK_MEMALLOC, meaning this socket may dip into the memalloc reserves on
the receive side.

>From the net_device side of things, the extra 'struct net_device *' argument
to {,__}netdev_alloc_skb() is used to attribute/account the memalloc usage.
Converted drivers will make use of this new API and will set NETIF_F_MEMALLOC
to indicate the driver fully supports this feature.

When a SOCK_MEMALLOC socket is marked, the device is checked for this feature
and tries to increase the memalloc pool; if both succeed, the device is marked
with IFF_MEMALLOC, indicating to {,__}netdev_alloc_skb() that it is OK to dip
into the memalloc pool.

Memalloc sk_buff allocations are not done from the SLAB but are done using 
alloc_pages(). sk_buff::memalloc records this exception so that kfree_skbmem()
can do the right thing.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 include/linux/gfp.h       |    3 -
 include/linux/if.h        |    1 
 include/linux/mmzone.h    |    1 
 include/linux/netdevice.h |   48 ++++++++++++++-----
 include/linux/skbuff.h    |    3 -
 include/net/sock.h        |    8 +++
 mm/page_alloc.c           |   29 ++++++++++-
 net/core/dev.c            |    1 
 net/core/skbuff.c         |  114 +++++++++++++++++++++++++++++++++++++++++++---
 net/core/sock.c           |   54 +++++++++++++++++++++
 net/ethernet/eth.c        |    1 
 net/ipv4/af_inet.c        |   14 +++++
 net/ipv4/icmp.c           |    5 ++
 net/ipv4/tcp_ipv4.c       |    6 ++
 net/ipv4/udp.c            |   11 ++++
 15 files changed, 274 insertions(+), 25 deletions(-)

Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h
+++ linux-2.6/include/linux/gfp.h
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
--- linux-2.6.orig/include/linux/mmzone.h
+++ linux-2.6/include/linux/mmzone.h
@@ -420,6 +420,7 @@ int percpu_pagelist_fraction_sysctl_hand
 					void __user *, size_t *, loff_t *);
 int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
 			struct file *, void __user *, size_t *, loff_t *);
+int adjust_memalloc_reserve(int bytes);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
Index: linux-2.6/include/linux/netdevice.h
===================================================================
--- linux-2.6.orig/include/linux/netdevice.h
+++ linux-2.6/include/linux/netdevice.h
@@ -298,18 +298,22 @@ struct net_device
 
 	/* Net device features */
 	unsigned long		features;
-#define NETIF_F_SG		1	/* Scatter/gather IO. */
-#define NETIF_F_IP_CSUM		2	/* Can checksum only TCP/UDP over IPv4. */
-#define NETIF_F_NO_CSUM		4	/* Does not require checksum. F.e. loopack. */
-#define NETIF_F_HW_CSUM		8	/* Can checksum all the packets. */
-#define NETIF_F_HIGHDMA		32	/* Can DMA to high memory. */
-#define NETIF_F_FRAGLIST	64	/* Scatter/gather IO. */
-#define NETIF_F_HW_VLAN_TX	128	/* Transmit VLAN hw acceleration */
-#define NETIF_F_HW_VLAN_RX	256	/* Receive VLAN hw acceleration */
-#define NETIF_F_HW_VLAN_FILTER	512	/* Receive filtering on VLAN */
-#define NETIF_F_VLAN_CHALLENGED	1024	/* Device cannot handle VLAN packets */
-#define NETIF_F_GSO		2048	/* Enable software GSO. */
-#define NETIF_F_LLTX		4096	/* LockLess TX */
+#define NETIF_F_SG		0x0001	/* Scatter/gather IO. */
+#define NETIF_F_IP_CSUM		0x0002	/* Can checksum only TCP/UDP over IPv4. */
+#define NETIF_F_NO_CSUM		0x0004	/* Does not require checksum. F.e. loopack. */
+#define NETIF_F_HW_CSUM		0x0008	/* Can checksum all the packets. */
+
+#define NETIF_F_HIGHDMA		0x0010	/* Can DMA to high memory. */
+#define NETIF_F_FRAGLIST	0x0020	/* Scatter/gather IO. */
+#define NETIF_F_HW_VLAN_TX	0x0040	/* Transmit VLAN hw acceleration */
+#define NETIF_F_HW_VLAN_RX	0x0080	/* Receive VLAN hw acceleration */
+
+#define NETIF_F_HW_VLAN_FILTER	0x0100	/* Receive filtering on VLAN */
+#define NETIF_F_VLAN_CHALLENGED	0x0200	/* Device cannot handle VLAN packets */
+#define NETIF_F_GSO		0x0400	/* Enable software GSO. */
+#define NETIF_F_LLTX		0x0800	/* LockLess TX */
+
+#define NETIF_F_MEMALLOC	0x1000	/* Supports {SOCK,__GFP}_MEMALLOC */
 
 	/* Segmentation offload features */
 #define NETIF_F_GSO_SHIFT	16
@@ -409,6 +413,12 @@ struct net_device
 	struct Qdisc		*qdisc_sleeping;
 	struct list_head	qdisc_list;
 	unsigned long		tx_queue_len;	/* Max frames per queue allowed */
+	int			rx_reserve;
+	atomic_t		rx_reserve_used;
+
+	atomic_t		memalloc_socks;
+	unsigned long		memalloc_reserve;
+	spinlock_t		memalloc_lock;
 
 	/* Partially transmitted GSO packet. */
 	struct sk_buff		*gso_skb;
@@ -686,6 +696,20 @@ static inline void dev_kfree_skb_irq(str
  */
 extern void dev_kfree_skb_any(struct sk_buff *skb);
 
+/*
+ * Support for critical network IO under low memory conditions
+ */
+static inline int dev_reserve_used(struct net_device *dev)
+{
+	return atomic_read(&dev->rx_reserve_used);
+}
+
+static inline void dev_unreserve_skb(struct net_device *dev)
+{
+	if (atomic_dec_return(&dev->rx_reserve_used) < 0)
+		atomic_inc(&dev->rx_reserve_used);
+}
+
 #define HAVE_NETIF_RX 1
 extern int		netif_rx(struct sk_buff *skb);
 extern int		netif_rx_ni(struct sk_buff *skb);
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
+				memalloc:1;
 	__be16			protocol;
 
 	void			(*destructor)(struct sk_buff *skb);
Index: linux-2.6/include/net/sock.h
===================================================================
--- linux-2.6.orig/include/net/sock.h
+++ linux-2.6/include/net/sock.h
@@ -391,6 +391,7 @@ enum sock_flags {
 	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
 	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
 	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
+	SOCK_MEMALLOC, /* protocol can use memalloc reserve */
 };
 
 static inline void sock_copy_flags(struct sock *nsk, struct sock *osk)
@@ -413,6 +414,13 @@ static inline int sock_flag(struct sock 
 	return test_bit(flag, &sk->sk_flags);
 }
 
+static inline int sk_is_memalloc(struct sock *sk)
+{
+	return sock_flag(sk, SOCK_MEMALLOC);
+}
+
+extern int sk_set_memalloc(struct sock *sk);
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
@@ -2248,6 +2250,27 @@ void setup_per_zone_pages_min(void)
 	calculate_totalreserve_pages();
 }
 
+int adjust_memalloc_reserve(int pages)
+{
+	int kbytes = var_free_kbytes + (pages << (PAGE_SHIFT - 10));
+	if (kbytes < 0)
+		return -EINVAL;
+	var_free_kbytes = kbytes;
+	setup_per_zone_pages_min();
+	if (pages > 0) {
+		int i;
+		pg_data_t *pgdat;
+		for_each_online_pgdat(pgdat) {
+			for (i = 0; i < pgdat->nr_zones; ++i)
+				wakeup_kswapd(&pgdat->node_zones[i], 0);
+		}
+	}
+	printk(KERN_DEBUG "RX reserve: %d\n", var_free_kbytes);
+	return 0;
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
@@ -43,6 +43,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/interrupt.h>
 #include <linux/in.h>
 #include <linux/inet.h>
@@ -125,6 +126,8 @@ EXPORT_SYMBOL(skb_truesize_bug);
  *
  */
 
+#define ceiling_log2(x)	fls((x) - 1)
+
 /**
  *	__alloc_skb	-	allocate a network buffer
  *	@size: size to allocate
@@ -147,6 +150,49 @@ struct sk_buff *__alloc_skb(unsigned int
 	struct sk_buff *skb;
 	u8 *data;
 
+	size = SKB_DATA_ALIGN(size);
+
+	if (gfp_mask & __GFP_MEMALLOC) {
+		/*
+		 * We have to do higher order allocations for icky jumbo
+		 * frame drivers :-(
+		 * They really should be migrated to scater/gather DMA
+		 * and use skb fragments.
+		 */
+		unsigned int data_offset =
+			sizeof(struct sk_buff) + sizeof(unsigned int);
+		unsigned long length = size + data_offset +
+			sizeof(struct skb_shared_info);
+		unsigned int pages;
+		unsigned int order;
+		struct page *page;
+		void *kaddr;
+
+		/*
+		 * force fclone alloc in order to fudge a lacking in skb_clone().
+		 */
+		fclone = 1;
+		if (fclone) {
+			data_offset += sizeof(struct sk_buff) + sizeof(atomic_t);
+			length += sizeof(struct sk_buff) + sizeof(atomic_t);
+		}
+		pages = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		order = ceiling_log2(pages);
+
+		skb = NULL;
+		if (!(page = alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order)))
+			goto out;
+
+		kaddr = pfn_to_kaddr(page_to_pfn(page));
+		skb = (struct sk_buff *)kaddr;
+
+		*((unsigned int *)(kaddr + data_offset -
+					sizeof(unsigned int))) = order;
+		data = (u8 *)(kaddr + data_offset);
+
+		goto allocated;
+	}
+
 	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
 
 	/* Get the HEAD */
@@ -155,12 +201,13 @@ struct sk_buff *__alloc_skb(unsigned int
 		goto out;
 
 	/* Get the DATA. Size must match skb_add_mtu(). */
-	size = SKB_DATA_ALIGN(size);
 	data = ____kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
+allocated:
 	memset(skb, 0, offsetof(struct sk_buff, truesize));
+	skb->memalloc = !!(gfp_mask & __GFP_MEMALLOC);
 	skb->truesize = size + sizeof(struct sk_buff);
 	atomic_set(&skb->users, 1);
 	skb->head = data;
@@ -185,6 +232,7 @@ struct sk_buff *__alloc_skb(unsigned int
 		atomic_set(fclone_ref, 1);
 
 		child->fclone = SKB_FCLONE_UNAVAILABLE;
+		child->memalloc = skb->memalloc;
 	}
 out:
 	return skb;
@@ -250,7 +298,7 @@ nodata:
 }
 
 /**
- *	__netdev_alloc_skb - allocate an skbuff for rx on a specific device
+ *	___netdev_alloc_skb - allocate an skbuff for rx on a specific device
  *	@dev: network device to receive on
  *	@length: length to allocate
  *	@gfp_mask: get_free_pages mask, passed to alloc_skb
@@ -262,7 +310,7 @@ nodata:
  *
  *	%NULL is returned if there is no free memory.
  */
-struct sk_buff *__netdev_alloc_skb(struct net_device *dev,
+static struct sk_buff *___netdev_alloc_skb(struct net_device *dev,
 		unsigned int length, gfp_t gfp_mask)
 {
 	struct sk_buff *skb;
@@ -273,6 +321,34 @@ struct sk_buff *__netdev_alloc_skb(struc
 	return skb;
 }
 
+struct sk_buff *__netdev_alloc_skb(struct net_device *dev,
+		unsigned length, gfp_t gfp_mask)
+{
+	struct sk_buff *skb;
+
+	if (dev && (dev->flags & IFF_MEMALLOC)) {
+		WARN_ON(gfp_mask & (__GFP_NOMEMALLOC | __GFP_MEMALLOC));
+		gfp_mask &= ~(__GFP_NOMEMALLOC | __GFP_MEMALLOC);
+
+		if ((skb = ___netdev_alloc_skb(dev, length,
+					       gfp_mask | __GFP_NOMEMALLOC)))
+			goto done;
+		if (dev_reserve_used(dev) >= dev->rx_reserve)
+			goto out;
+		if (!(skb = ___netdev_alloc_skb(dev, length,
+						gfp_mask | __GFP_MEMALLOC)))
+			goto out;
+		atomic_inc(&dev->rx_reserve_used);
+	} else
+		if (!(skb = ___netdev_alloc_skb(dev, length, gfp_mask)))
+			goto out;
+
+done:
+	skb->dev = dev;
+out:
+	return skb;
+}
+
 static void skb_drop_list(struct sk_buff **listp)
 {
 	struct sk_buff *list = *listp;
@@ -313,10 +389,19 @@ static void skb_release_data(struct sk_b
 		if (skb_shinfo(skb)->frag_list)
 			skb_drop_fraglist(skb);
 
-		kfree(skb->head);
+		if (!skb->memalloc)
+			kfree(skb->head);
 	}
 }
 
+static void free_skb_pages(struct kmem_cache *cache, void *objp)
+{
+	struct sk_buff *skb = (struct sk_buff *)objp;
+	unsigned int order =
+		*(unsigned int *)(skb->head - sizeof(unsigned int));
+	free_pages((unsigned long)skb, order);
+}
+
 /*
  *	Free an skbuff by memory without cleaning the state.
  */
@@ -324,17 +409,21 @@ void kfree_skbmem(struct sk_buff *skb)
 {
 	struct sk_buff *other;
 	atomic_t *fclone_ref;
+	void (*free_skb)(struct kmem_cache *, void *);
 
 	skb_release_data(skb);
+
+	free_skb = skb->memalloc ? free_skb_pages : kmem_cache_free;
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
@@ -347,7 +436,7 @@ void kfree_skbmem(struct sk_buff *skb)
 		skb->fclone = SKB_FCLONE_UNAVAILABLE;
 
 		if (atomic_dec_and_test(fclone_ref))
-			kmem_cache_free(skbuff_fclone_cache, other);
+			free_skb(skbuff_fclone_cache, other);
 		break;
 	};
 }
@@ -363,6 +452,8 @@ void kfree_skbmem(struct sk_buff *skb)
 
 void __kfree_skb(struct sk_buff *skb)
 {
+	struct net_device *dev = skb->dev;
+
 	dst_release(skb->dst);
 #ifdef CONFIG_XFRM
 	secpath_put(skb->sp);
@@ -389,6 +480,8 @@ void __kfree_skb(struct sk_buff *skb)
 #endif
 
 	kfree_skbmem(skb);
+	if (dev && (dev->flags & IFF_MEMALLOC))
+		dev_unreserve_skb(dev);
 }
 
 /**
@@ -434,10 +527,15 @@ struct sk_buff *skb_clone(struct sk_buff
 		n->fclone = SKB_FCLONE_CLONE;
 		atomic_inc(fclone_ref);
 	} else {
+		/*
+		 * should we special-case skb->memalloc cloning?
+		 * for now fudge it by forcing fast-clone alloc.
+		 */
 		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
 		if (!n)
 			return NULL;
 		n->fclone = SKB_FCLONE_UNAVAILABLE;
+		n->memalloc = 0;
 	}
 
 #define C(x) n->x = skb->x
@@ -686,6 +784,8 @@ int pskb_expand_head(struct sk_buff *skb
 	if (skb_shared(skb))
 		BUG();
 
+	BUG_ON(skb->memalloc);
+
 	size = SKB_DATA_ALIGN(size);
 
 	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
Index: linux-2.6/net/ethernet/eth.c
===================================================================
--- linux-2.6.orig/net/ethernet/eth.c
+++ linux-2.6/net/ethernet/eth.c
@@ -275,6 +275,7 @@ void ether_setup(struct net_device *dev)
 	dev->mtu		= ETH_DATA_LEN;
 	dev->addr_len		= ETH_ALEN;
 	dev->tx_queue_len	= 1000;	/* Ethernet wants good queues */	
+	dev->rx_reserve		= 384;
 	dev->flags		= IFF_BROADCAST|IFF_MULTICAST;
 	
 	memset(dev->broadcast,0xFF, ETH_ALEN);
Index: linux-2.6/net/ipv4/icmp.c
===================================================================
--- linux-2.6.orig/net/ipv4/icmp.c
+++ linux-2.6/net/ipv4/icmp.c
@@ -938,6 +938,11 @@ int icmp_rcv(struct sk_buff *skb)
 			goto error;
 	}
 
+	if (unlikely(dev_reserve_used(skb->dev))) {
+		dev_unreserve_skb(skb->dev);
+		goto drop;
+	}
+
 	if (!pskb_pull(skb, sizeof(struct icmphdr)))
 		goto error;
 
Index: linux-2.6/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6.orig/net/ipv4/tcp_ipv4.c
+++ linux-2.6/net/ipv4/tcp_ipv4.c
@@ -1093,6 +1093,12 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!sk)
 		goto no_tcp_socket;
 
+	if (unlikely(dev_reserve_used(skb->dev))) {
+		dev_unreserve_skb(skb->dev);
+		if (!sk_is_memalloc(sk))
+			goto discard_and_relse;
+	}
+
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
Index: linux-2.6/net/ipv4/udp.c
===================================================================
--- linux-2.6.orig/net/ipv4/udp.c
+++ linux-2.6/net/ipv4/udp.c
@@ -1136,7 +1136,15 @@ int udp_rcv(struct sk_buff *skb)
 	sk = udp_v4_lookup(saddr, uh->source, daddr, uh->dest, skb->dev->ifindex);
 
 	if (sk != NULL) {
-		int ret = udp_queue_rcv_skb(sk, skb);
+		int ret;
+
+		if (unlikely(dev_reserve_used(skb->dev))) {
+			dev_unreserve_skb(skb->dev);
+			if (!sk_is_memalloc(sk))
+				goto drop_noncritical;
+		}
+
+		ret = udp_queue_rcv_skb(sk, skb);
 		sock_put(sk);
 
 		/* a return value > 0 means to resubmit the input, but
@@ -1147,6 +1155,7 @@ int udp_rcv(struct sk_buff *skb)
 		return 0;
 	}
 
+drop_noncritical:
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto drop;
 	nf_reset(skb);
Index: linux-2.6/include/linux/if.h
===================================================================
--- linux-2.6.orig/include/linux/if.h
+++ linux-2.6/include/linux/if.h
@@ -49,6 +49,7 @@
 
 #define IFF_LOWER_UP	0x10000		/* driver signals L1 up		*/
 #define IFF_DORMANT	0x20000		/* driver signals dormant	*/
+#define IFF_MEMALLOC	0x40000		/* driver has a reserve allocated */
 
 #define IFF_VOLATILE	(IFF_LOOPBACK|IFF_POINTOPOINT|IFF_BROADCAST|\
 		IFF_MASTER|IFF_SLAVE|IFF_RUNNING|IFF_LOWER_UP|IFF_DORMANT)
Index: linux-2.6/net/core/dev.c
===================================================================
--- linux-2.6.orig/net/core/dev.c
+++ linux-2.6/net/core/dev.c
@@ -2900,6 +2900,7 @@ int register_netdevice(struct net_device
 #ifdef CONFIG_NET_CLS_ACT
 	spin_lock_init(&dev->ingress_lock);
 #endif
+	spin_lock_init(&dev->memalloc_lock);
 
 	ret = alloc_divert_blk(dev);
 	if (ret)
Index: linux-2.6/net/ipv4/af_inet.c
===================================================================
--- linux-2.6.orig/net/ipv4/af_inet.c
+++ linux-2.6/net/ipv4/af_inet.c
@@ -131,6 +131,20 @@ static DEFINE_SPINLOCK(inetsw_lock);
 void inet_sock_destruct(struct sock *sk)
 {
 	struct inet_sock *inet = inet_sk(sk);
+	struct net_device *dev = ip_dev_find(inet->rcv_saddr);
+
+	if (dev && (dev->flags & IFF_MEMALLOC) &&
+			sk_is_memalloc(sk) &&
+			(atomic_read(&dev->memalloc_socks) == 1)) {
+		spin_lock(&dev->memalloc_lock);
+		if (atomic_dec_and_test(&dev->memalloc_socks)) {
+			dev->flags &= ~IFF_MEMALLOC;
+			WARN_ON(dev_reserve_used(dev));
+			atomic_set(&dev->rx_reserve_used, 0);
+			adjust_memalloc_reserve(-dev->memalloc_reserve);
+		}
+		spin_unlock(&dev->memalloc_lock);
+	}
 
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
+#include <linux/inetdevice.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -195,6 +196,59 @@ __u32 sysctl_rmem_default = SK_RMEM_MAX;
 /* Maximal space eaten by iovec or ancilliary data plus some space */
 int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
 
+#define ceiling_log2(x) fls((x) - 1)
+
+static inline unsigned int skb_pages(unsigned int mtu)
+{
+	unsigned int pages = (mtu + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned int order = ceiling_log2(pages);
+	pages = 1 << order;
+	if (pages > 1) ++pages;
+
+	return pages;
+}
+
+int sk_set_memalloc(struct sock *sk)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct net_device *dev = ip_dev_find(inet->rcv_saddr);
+	int err = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	if (!(dev->features & NETIF_F_MEMALLOC)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	if (atomic_read(&dev->memalloc_socks) == 0) {
+		spin_lock(&dev->memalloc_lock);
+		if (atomic_read(&dev->memalloc_socks) == 0) {
+			dev->memalloc_reserve =
+				dev->rx_reserve * skb_pages(dev->mtu);
+			err = adjust_memalloc_reserve(dev->memalloc_reserve);
+			if (err) {
+				spin_unlock(&dev->memalloc_lock);
+				printk(KERN_WARNING
+			"%s: Unable to allocate RX reserve, error: %d\n",
+					dev->name, err);
+				goto out;
+			}
+			sock_set_flag(sk, SOCK_MEMALLOC);
+			dev->flags |= IFF_MEMALLOC;
+		}
+		atomic_inc(&dev->memalloc_socks);
+		spin_unlock(&dev->memalloc_lock);
+	} else
+		atomic_inc(&dev->memalloc_socks);
+
+out:
+	dev_put(dev);
+	return err;
+}
+EXPORT_SYMBOL_GPL(sk_set_memalloc);
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
 	struct timeval tv;
