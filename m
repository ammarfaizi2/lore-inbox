Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161327AbWHJNcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161327AbWHJNcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWHJNcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:32:48 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:6796 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161267AbWHJNcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:32:46 -0400
Subject: [RFC][PATCH] VM deadlock prevention core -v3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       netdev <netdev@vger.kernel.org>
Cc: Daniel Phillips <phillips@google.com>, David Miller <davem@davemloft.net>,
       Thomas Graf <tgraf@suug.ch>, Indan Zupancic <indan@nul.nu>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 15:32:49 +0200
Message-Id: <1155216769.5696.23.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So I try again, please tell me if I'm still on crack and should go detox.
However if you do so, I kindly request some words on the how and why of it.

so I try to map to net_device in several fashions:

1) netdev_alloc_skb()
  - has an argument with the actual incoming device

2) free_skb_pages()
  - uses: skb->input_dev ?: skb->dev

    this device is pinned by virtue of netdev_wait_memalloc(), which will
    wait until all skb->memalloc skbuffs are destroyed. This will delay
    module unload under severe memory pressure, I think this is acceptable
    as one has other problems at that point.

3) inet_sock_destruct(), sk_set_memalloc() 
  - both use: ip_dev_find(inet_sk(sk)->rcv_saddr))

if the later two methods do not yield the same net_device the first has, 
weird and wonderfull stuff will happen.

Why, currently the sole purpose is to be able to limit the number of 
memalloc skbs per device (and for me to learn some).

I suspect something as simple as a bridge device will destroy this, with
that I suspect (3) will return the bride device instead of the actual
input device.

So, if I'm still busted, is there any hope for this approach?

If not, I'll have to go do global skb memalloc accounting (largesmp
fanboys need not worry, this will only happen under severe load, at
that point the box will have other issues) and fudge the per deviceness.

---

The core of the VM deadlock avoidance framework.

>From the 'user' side of things it provides a function to mark a 'struct sock'
as SOCK_MEMALLOC, meaning this socket may dip into the memalloc reserves on
the receive side.

>From the net_device side of things, the extra 'struct net_device *' argument
to {,__}netdev_alloc_skb() is used to attribute/account the memalloc usage.
When netdev_alloc_skb() finds it cannot allocate a struct sk_buff the regular
way it will grab some memory from the memalloc reserve.

Drivers that have been converted to the netdev_alloc_skb() family will 
automatically receive this feature.

Network paths will drop !SOCK_MEMALLOC packets ASAP when reserve is being used.

Memalloc sk_buff allocations are not done from the SLAB but are done using 
alloc_pages(). sk_buff::memalloc records this exception so that kfree_skbmem()
can do the right thing. NOTE this does not play very nice with skb_clone()


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 include/linux/gfp.h       |    3 
 include/linux/mmzone.h    |    1 
 include/linux/netdevice.h |    7 ++
 include/linux/skbuff.h    |    3 
 include/net/sock.h        |    8 ++
 mm/page_alloc.c           |   46 ++++++++++++-
 net/core/dev.c            |   97 ++++++++++++++++++++++++++++
 net/core/skbuff.c         |  155 +++++++++++++++++++++++++++++++++++++++++++---
 net/core/sock.c           |   25 +++++++
 net/ethernet/eth.c        |    1 
 net/ipv4/af_inet.c        |    8 ++
 net/ipv4/icmp.c           |    3 
 net/ipv4/tcp_ipv4.c       |    3 
 net/ipv4/udp.c            |    8 ++
 14 files changed, 355 insertions(+), 13 deletions(-)

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
@@ -409,6 +409,12 @@ struct net_device
 	struct Qdisc		*qdisc_sleeping;
 	struct list_head	qdisc_list;
 	unsigned long		tx_queue_len;	/* Max frames per queue allowed */
+	int			rx_reserve;
+	atomic_t		rx_reserve_used;
+
+	int			memalloc_socks;
+	unsigned long		memalloc_reserve;
+	spinlock_t		memalloc_lock;
 
 	/* Partially transmitted GSO packet. */
 	struct sk_buff		*gso_skb;
@@ -576,6 +582,7 @@ extern struct net_device	*__dev_get_by_n
 extern int		dev_alloc_name(struct net_device *dev, const char *name);
 extern int		dev_open(struct net_device *dev);
 extern int		dev_close(struct net_device *dev);
+extern int 		dev_adjust_memalloc(struct net_device *dev, int a);
 extern int		dev_queue_xmit(struct sk_buff *skb);
 extern int		register_netdevice(struct net_device *dev);
 extern int		unregister_netdevice(struct net_device *dev);
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
@@ -2248,6 +2250,44 @@ void setup_per_zone_pages_min(void)
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
+	static DEFINE_SPINLOCK(var_free_lock);
+	unsigned long flags;
+	int kbytes;
+	int err = 0;
+
+	spin_lock_irqsave(&var_free_lock, flags);
+
+	kbytes = var_free_kbytes + (pages << (PAGE_SHIFT - 10));
+	if (kbytes < 0) {
+		err = -EINVAL;
+		goto unlock;
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
+unlock:
+	spin_unlock_irqrestore(&var_free_lock, flags);
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
@@ -147,6 +150,59 @@ struct sk_buff *__alloc_skb(unsigned int
 	struct sk_buff *skb;
 	u8 *data;
 
+	size = SKB_DATA_ALIGN(size);
+
+	if (gfp_mask & __GFP_MEMALLOC) {
+		/*
+		 * Fallback allocation for memalloc reserves.
+		 *
+		 * the page is populated like so:
+		 *
+		 *   struct sk_buff
+		 *   [ struct sk_buff ]
+		 *   [ atomic_t ]
+		 *   unsigned int
+		 *   struct skb_shared_info
+		 *   char []
+		 *
+		 * We have to do higher order allocations for icky jumbo
+		 * frame drivers :-(. They really should be migrated to
+		 * scather/gather DMA and use skb fragments.
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
+		 * Force fclone alloc in order to fudge a lacking in skb_clone().
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
@@ -155,12 +211,13 @@ struct sk_buff *__alloc_skb(unsigned int
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
@@ -185,6 +242,7 @@ struct sk_buff *__alloc_skb(unsigned int
 		atomic_set(fclone_ref, 1);
 
 		child->fclone = SKB_FCLONE_UNAVAILABLE;
+		child->memalloc = skb->memalloc;
 	}
 out:
 	return skb;
@@ -250,7 +308,7 @@ nodata:
 }
 
 /**
- *	__netdev_alloc_skb - allocate an skbuff for rx on a specific device
+ *	___netdev_alloc_skb - allocate an skbuff for rx on a specific device
  *	@dev: network device to receive on
  *	@length: length to allocate
  *	@gfp_mask: get_free_pages mask, passed to alloc_skb
@@ -262,7 +320,7 @@ nodata:
  *
  *	%NULL is returned if there is no free memory.
  */
-struct sk_buff *__netdev_alloc_skb(struct net_device *dev,
+static struct sk_buff *___netdev_alloc_skb(struct net_device *dev,
 		unsigned int length, gfp_t gfp_mask)
 {
 	struct sk_buff *skb;
@@ -273,6 +331,52 @@ struct sk_buff *__netdev_alloc_skb(struc
 	return skb;
 }
 
+/**
+ *	__netdev_alloc_skb - allocate an skbuff for rx on a specifix device
+ *	@dev: network device to receive on
+ *	@length: length to allocate
+ *	@gfp_mask: get_free_pages mask, passed to alloc_skb
+ *
+ * 	This function uses %___netdev_alloc_skb to do the actual allocation.
+ *
+ * 	It first tries without dipping into the memalloc pool; if such
+ * 	an allocation fails, we see if we're allowed to dip into the
+ * 	memalloc pool.
+ *
+ *	%NULL is returned if there is no free memory.
+ */
+struct sk_buff *__netdev_alloc_skb(struct net_device *dev,
+		unsigned length, gfp_t gfp_mask)
+{
+	struct sk_buff *skb;
+
+	WARN_ON(gfp_mask & (__GFP_NOMEMALLOC | __GFP_MEMALLOC));
+	gfp_mask &= ~(__GFP_NOMEMALLOC | __GFP_MEMALLOC);
+
+	skb = ___netdev_alloc_skb(dev, length, gfp_mask | __GFP_NOMEMALLOC);
+	if (skb)
+		goto done;
+
+	if (atomic_read(&dev->rx_reserve_used) >=
+			dev->rx_reserve * dev->memalloc_socks)
+		goto out;
+
+	/*
+	 * pre-inc guards against a race with netdev_wait_memalloc()
+	 */
+	atomic_inc(&dev->rx_reserve_used);
+	skb = ___netdev_alloc_skb(dev, length, gfp_mask | __GFP_MEMALLOC);
+	if (unlikely(!skb)) {
+		atomic_dec(&dev->rx_reserve_used);
+		goto out;
+	}
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
@@ -313,10 +417,35 @@ static void skb_release_data(struct sk_b
 		if (skb_shinfo(skb)->frag_list)
 			skb_drop_fraglist(skb);
 
-		kfree(skb->head);
+		if (!skb->memalloc)
+			kfree(skb->head);
+		skb->head = NULL;
 	}
 }
 
+/**
+ *	free_skb_pages - frees a memalloced skbuff
+ *	@cache: fake %kmem_cache argument
+ *	@objp: %sk_buff pointer
+ *
+ *	Function is made to look like %kmem_cache_free so we can easily
+ *	substitue the free function in %kfree_skbmem.
+ */
+static void free_skb_pages(struct kmem_cache *cache, void *objp)
+{
+	struct sk_buff *skb = (struct sk_buff *)objp;
+	/*
+	 * The input_dev is the initial input device;
+	 * we have it pinned by virtue of rx_reserve_used not being zero.
+	 */
+	struct net_device *dev = skb->input_dev ?: skb->dev;
+	unsigned int order =
+		*(unsigned int *)(skb->head - sizeof(unsigned int));
+	if (!skb->head)
+		atomic_dec(&dev->rx_reserve_used);
+	free_pages((unsigned long)skb, order);
+}
+
 /*
  *	Free an skbuff by memory without cleaning the state.
  */
@@ -324,17 +453,21 @@ void kfree_skbmem(struct sk_buff *skb)
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
@@ -347,7 +480,7 @@ void kfree_skbmem(struct sk_buff *skb)
 		skb->fclone = SKB_FCLONE_UNAVAILABLE;
 
 		if (atomic_dec_and_test(fclone_ref))
-			kmem_cache_free(skbuff_fclone_cache, other);
+			free_skb(skbuff_fclone_cache, other);
 		break;
 	};
 }
@@ -434,6 +567,12 @@ struct sk_buff *skb_clone(struct sk_buff
 		n->fclone = SKB_FCLONE_CLONE;
 		atomic_inc(fclone_ref);
 	} else {
+		/*
+		 * should we special-case skb->memalloc cloning?
+		 * for now fudge it by forcing fast-clone alloc.
+		 */
+		BUG_ON(skb->memalloc);
+
 		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
 		if (!n)
 			return NULL;
@@ -686,6 +825,8 @@ int pskb_expand_head(struct sk_buff *skb
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
+	dev->rx_reserve		= 64;
 	dev->flags		= IFF_BROADCAST|IFF_MULTICAST;
 	
 	memset(dev->broadcast,0xFF, ETH_ALEN);
Index: linux-2.6/net/ipv4/icmp.c
===================================================================
--- linux-2.6.orig/net/ipv4/icmp.c
+++ linux-2.6/net/ipv4/icmp.c
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
--- linux-2.6.orig/net/ipv4/tcp_ipv4.c
+++ linux-2.6/net/ipv4/tcp_ipv4.c
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
--- linux-2.6.orig/net/ipv4/udp.c
+++ linux-2.6/net/ipv4/udp.c
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
Index: linux-2.6/net/core/dev.c
===================================================================
--- linux-2.6.orig/net/core/dev.c
+++ linux-2.6/net/core/dev.c
@@ -116,6 +116,7 @@
 #include <linux/audit.h>
 #include <linux/dmaengine.h>
 #include <linux/err.h>
+#include <linux/blkdev.h>
 
 /*
  *	The list of packet types we will receive (as opposed to discard)
@@ -938,6 +939,68 @@ int dev_close(struct net_device *dev)
 	return 0;
 }
 
+#define ceiling_log2(x) fls((x) - 1)
+
+/**
+ *	mtu_pages - guess how many pages are needed to store this mtu size
+ *	@mtu: mtu size in bytes
+ *
+ *	This function gives a guestimation of the number of pages needed
+ *	to store the given mtu size in.
+ */
+static inline unsigned int mtu_pages(unsigned int mtu)
+{
+	unsigned int pages = (mtu + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned int order = ceiling_log2(pages);
+	pages = 1 << order;
+	/*
+	 * if we need more than one page, we need a head and fragments.
+	 */
+	if (pages > 1) ++pages;
+
+	return pages;
+}
+
+/**
+ *	dev_adjust_memalloc - adjust the global memalloc reserve for this device
+ *	@dev: device that has memalloc demands
+ *	@nr_socks: number of new %SOCK_MEMALLOC sockets
+ *
+ *	This function adjusts the memalloc reserve based on device
+ *	demand. For each %SOCK_MEMALLOC socket this device will reserve
+ *	2 * %MAX_PHYS_SEGMENTS pages for outbound traffic (assumption:
+ *	each %SOCK_MEMALLOC socket will have a %request_queue associated)
+ *	and @dev->rx_reserve mtu pages.
+ */
+int dev_adjust_memalloc(struct net_device *dev, int nr_socks)
+{
+	unsigned long flags;
+	unsigned long reserve;
+	int err;
+
+	spin_lock_irqsave(&dev->memalloc_lock, flags);
+
+	dev->memalloc_socks += nr_socks;
+	BUG_ON(dev->memalloc_socks < 0);
+
+	reserve = dev->memalloc_socks *
+		(2 * MAX_PHYS_SEGMENTS +		 /* outbound */
+		 dev->rx_reserve * mtu_pages(dev->mtu)); /* inbound */
+
+	err = adjust_memalloc_reserve(reserve - dev->memalloc_reserve);
+	if (err) {
+		printk(KERN_WARNING
+			"%s: Unable to change RX reserve to: %lu, error: %d\n",
+			dev->name, reserve, err);
+		goto unlock;
+	}
+	dev->memalloc_reserve = reserve;
+
+unlock:
+	spin_unlock_irqrestore(&dev->memalloc_lock, flags);
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_adjust_memalloc);
 
 /*
  *	Device change register/unregister. These are not inline or static
@@ -2464,6 +2527,9 @@ int dev_set_mtu(struct net_device *dev, 
 		err = dev->change_mtu(dev, new_mtu);
 	else
 		dev->mtu = new_mtu;
+
+	dev_adjust_memalloc(dev, 0);
+
 	if (!err && dev->flags & IFF_UP)
 		raw_notifier_call_chain(&netdev_chain,
 				NETDEV_CHANGEMTU, dev);
@@ -2900,6 +2966,7 @@ int register_netdevice(struct net_device
 #ifdef CONFIG_NET_CLS_ACT
 	spin_lock_init(&dev->ingress_lock);
 #endif
+	spin_lock_init(&dev->memalloc_lock);
 
 	ret = alloc_divert_blk(dev);
 	if (ret)
@@ -3106,6 +3173,28 @@ static void netdev_wait_allrefs(struct n
 	}
 }
 
+/* netdev_wait_memalloc - wait for all outstanding memalloc skbs
+ *
+ * This is called when unregistering network devices.
+ *
+ * Better make sure the skb -> dev mapping is correct, if we leak
+ * some this will stall forever.
+ */
+static void netdev_wait_memalloc(struct net_device *dev)
+{
+	unsigned long warning_time = jiffies;
+	while (atomic_read(&dev->rx_reserve_used) != 0) {
+		msleep(250);
+		if (time_after(jiffies, warning_time + 10 * HZ)) {
+			printk(KERN_EMERG "netdev_wait_memalloc: "
+			       "waiting for %s to become free. SKB "
+			       "count = %d\n",
+			       dev->name, atomic_read(&dev->rx_reserve_used));
+			warning_time = jiffies;
+		}
+	}
+}
+
 /* The sequence is:
  *
  *	rtnl_lock();
@@ -3165,6 +3254,14 @@ void netdev_run_todo(void)
 
 		netdev_wait_allrefs(dev);
 
+		netdev_wait_memalloc(dev);
+
+		/* Get rid of any SOCK_MEMALLOC reserves. */
+		if (dev->memalloc_reserve) {
+			BUG_ON(!dev->memalloc_socks);
+			dev_adjust_memalloc(dev, -dev->memalloc_socks);
+		}
+
 		/* paranoia */
 		BUG_ON(atomic_read(&dev->refcnt));
 		BUG_TRAP(!dev->ip_ptr);
Index: linux-2.6/net/ipv4/af_inet.c
===================================================================
--- linux-2.6.orig/net/ipv4/af_inet.c
+++ linux-2.6/net/ipv4/af_inet.c
@@ -132,6 +132,14 @@ void inet_sock_destruct(struct sock *sk)
 {
 	struct inet_sock *inet = inet_sk(sk);
 
+	if (sk_is_memalloc(sk)) {
+		struct net_device *dev = ip_dev_find(inet->rcv_saddr);
+		if (dev) {
+			dev_adjust_memalloc(dev, -1);
+			dev_put(dev);
+		}
+	}
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
+#include <linux/inetdevice.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -195,6 +196,30 @@ __u32 sysctl_rmem_default = SK_RMEM_MAX;
 /* Maximal space eaten by iovec or ancilliary data plus some space */
 int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
 
+/**
+ *	sk_set_memalloc - sets %SOCK_MEMALLOC
+ *	@sk: socket to set it on
+ *
+ *	Set %SOCK_MEMALLOC on a socket and increase the memalloc reserve
+ *	accordingly.
+ */
+int sk_set_memalloc(struct sock *sk)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct net_device *dev = ip_dev_find(inet->rcv_saddr);
+	int err = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	if (!(err = dev_adjust_memalloc(dev, 1)))
+		sock_set_flag(sk, SOCK_MEMALLOC);
+
+	dev_put(dev);
+	return err;
+}
+EXPORT_SYMBOL_GPL(sk_set_memalloc);
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
 	struct timeval tv;


