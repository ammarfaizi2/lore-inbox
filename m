Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbRFYVHN>; Mon, 25 Jun 2001 17:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbRFYVGy>; Mon, 25 Jun 2001 17:06:54 -0400
Received: from tyranny.egregious.net ([206.159.99.12]:40712 "HELO
	tyranny.egregious.net") by vger.kernel.org with SMTP
	id <S261558AbRFYVGe>; Mon, 25 Jun 2001 17:06:34 -0400
Date: Mon, 25 Jun 2001 14:06:13 -0700
From: Will <will@egregious.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] skb destructor enhancement idea
Message-ID: <20010625140613.A17207@egregious.net>
In-Reply-To: <20010618134644.A5938@egregious.net> <20010618145331.A32166@wacko.asicdesigners.com> <20010621161349.A27654@egregious.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621161349.A27654@egregious.net>; from will@egregious.net on Thu, Jun 21, 2001 at 04:13:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is a patch against 2.4.6pre5 that implements a gneric, 'chainable' destructor
mechanism for sk_buff structures. It allows for an arbitrary number of ordered
destructor calls for skbs.

We are currently using this change in a low-level packet monitoring module so we can
allocate our own packet memory and get called back when the skb is done moving
through the stack. It seems like it should be useful to allow network drivers to
implement their own device-specific memory management and thus reduce mem copying
overhead, too.

Any driver people want to try it out and see if they can make their driver use it to
reduce copying?

Any comments on the idea in general?

-- 
-Will  :: AD6XL :: http://tyranny.egregious.net/~will/
 Orton :: finger will@tyranny.egregious.net for GPG public key

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=skbd-246p5

diff -ur linux-246p5-clean/include/linux/skbuff.h linux/include/linux/skbuff.h
--- linux-246p5-clean/include/linux/skbuff.h	Fri May 25 18:01:43 2001
+++ linux/include/linux/skbuff.h	Mon Jun 25 12:23:49 2001
@@ -25,6 +25,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/slab.h>
 
 #define HAVE_ALLOC_SKB		/* For the drivers to know */
 #define HAVE_ALIGNABLE_SKB	/* Ditto 8)		   */
@@ -114,6 +115,18 @@
 	__u16 size;
 };
 
+struct sk_buff_dest {
+	struct sk_buff_dest	*next;
+	void (*destructor)(void *);
+	void *context;
+};
+
+struct sk_buff_dest_pool {
+	struct sk_buff_dest	*head;	
+	spinlock_t	lock;
+	kmem_cache_t	*cache;
+};
+
 /* This data is invariant across clones and lives at
  * the end of the header data, ie. at skb->end.
  */
@@ -191,7 +204,7 @@
 	unsigned char	*tail;			/* Tail pointer					*/
 	unsigned char 	*end;			/* End pointer					*/
 
-	void 		(*destructor)(struct sk_buff *);	/* Destruct function		*/
+	struct sk_buff_dest_pool	destructor;
 #ifdef CONFIG_NETFILTER
 	/* Can be used for communication between hooks. */
         unsigned long	nfmark;
@@ -245,6 +258,78 @@
 /* Internal */
 #define skb_shinfo(SKB)		((struct skb_shared_info *)((SKB)->end))
 
+/* SKB destructor stuff */
+extern unsigned int skbd_stat_add_head;
+extern unsigned int skbd_stat_add_dest;
+extern unsigned int skbd_stat_alloc;
+extern unsigned int skbd_stat_call_dest;
+extern unsigned int skbd_stat_maybe_call_dest;
+
+extern struct sk_buff_dest_pool sk_buff_dest_free_pool; 
+
+static inline void skbd_add_head(struct sk_buff_dest_pool *pool,
+				 struct sk_buff_dest *newnode)
+{
+	skbd_stat_add_head++;
+	newnode->next = pool->head;
+	pool->head = newnode;
+}
+
+static inline void skbd_remove_head(struct sk_buff_dest_pool *pool,
+				    struct sk_buff_dest **rmnode)
+{
+	if ((*rmnode = pool->head) != NULL)
+		pool->head = pool->head->next;
+}
+
+
+static inline int skb_add_dest(struct sk_buff *skb, void (*destructor)(void *),
+			       void *context, unsigned long gfp_mask)
+{
+	unsigned long flags;
+	struct sk_buff_dest *skbd;
+
+	skbd_stat_add_dest++;
+
+	spin_lock_irqsave(&sk_buff_dest_free_pool.lock, flags);
+	skbd_remove_head(&sk_buff_dest_free_pool, &skbd); 
+	spin_unlock_irqrestore(&sk_buff_dest_free_pool.lock, flags);
+
+	if (!skbd) {
+		skbd_stat_alloc++;
+		skbd = kmem_cache_alloc( sk_buff_dest_free_pool.cache, gfp_mask);
+		if (!skbd) {
+			printk(" out of memory allocating skbd\n");
+			return 1;
+		}
+	}
+
+	skbd->destructor = destructor;
+	skbd->context = context;
+	skbd_add_head(&skb->destructor, skbd);
+	return 0;
+}																								   
+
+static inline void skb_call_dest(struct sk_buff *skb)
+{
+	unsigned long flags;
+	struct sk_buff_dest *skbd;
+
+	skbd_stat_maybe_call_dest++;
+	skbd_remove_head(&skb->destructor, &skbd);
+
+	while (skbd) {
+		skbd_stat_call_dest++;
+		skbd->destructor(skbd->context);
+
+		spin_lock_irqsave(&sk_buff_dest_free_pool.lock, flags);
+		skbd_add_head(&sk_buff_dest_free_pool, skbd);
+		spin_unlock_irqrestore(&sk_buff_dest_free_pool.lock, flags);
+
+		skbd_remove_head(&skb->destructor, &skbd);
+	}
+}
+
 /**
  *	skb_queue_empty - check if a queue is empty
  *	@list: queue head
@@ -971,9 +1056,7 @@
 
 static inline void skb_orphan(struct sk_buff *skb)
 {
-	if (skb->destructor)
-		skb->destructor(skb);
-	skb->destructor = NULL;
+	skb_call_dest(skb);
 	skb->sk = NULL;
 }
 
diff -ur linux-246p5-clean/include/net/sock.h linux/include/net/sock.h
--- linux-246p5-clean/include/net/sock.h	Fri May 25 18:03:05 2001
+++ linux/include/net/sock.h	Mon Jun 25 11:33:14 2001
@@ -1143,19 +1143,23 @@
  *	packet ever received.
  */
 
-static inline void skb_set_owner_w(struct sk_buff *skb, struct sock *sk)
+static inline int skb_set_owner_w(struct sk_buff *skb, struct sock *sk)
 {
 	sock_hold(sk);
 	skb->sk = sk;
-	skb->destructor = sock_wfree;
+	if (skb_add_dest(skb, (void (*)(void *))sock_wfree, skb, GFP_ATOMIC))
+		return 1;
 	atomic_add(skb->truesize, &sk->wmem_alloc);
+	return 0;
 }
 
-static inline void skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
+static inline int skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 	skb->sk = sk;
-	skb->destructor = sock_rfree;
+	if (skb_add_dest(skb, (void (*)(void *))sock_rfree, skb, GFP_ATOMIC))
+		return 1;
 	atomic_add(skb->truesize, &sk->rmem_alloc);
+	return 0;
 }
 
 static inline int sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
@@ -1185,7 +1189,7 @@
 #endif /* CONFIG_FILTER */
 
 	skb->dev = NULL;
-	skb_set_owner_r(skb, sk);
+	if (skb_set_owner_r(skb, sk) == 1) return -ENOMEM;
 	skb_queue_tail(&sk->receive_queue, skb);
 	if (!sk->dead)
 		sk->data_ready(sk,skb->len);
@@ -1199,7 +1203,7 @@
 	 */
 	if (atomic_read(&sk->rmem_alloc) + skb->truesize >= (unsigned)sk->rcvbuf)
 		return -ENOMEM;
-	skb_set_owner_r(skb, sk);
+	if (skb_set_owner_r(skb, sk) == 1) return -ENOMEM;
 	skb_queue_tail(&sk->error_queue,skb);
 	if (!sk->dead)
 		sk->data_ready(sk,skb->len);
diff -ur linux-246p5-clean/include/net/tcp.h linux/include/net/tcp.h
--- linux-246p5-clean/include/net/tcp.h	Fri May 25 18:03:37 2001
+++ linux/include/net/tcp.h	Mon Jun 25 11:34:26 2001
@@ -1745,12 +1745,14 @@
 
 extern void tcp_rfree(struct sk_buff *skb);
 
-static inline void tcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
+static inline int tcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 	skb->sk = sk;
-	skb->destructor = tcp_rfree;
+	if (skb_add_dest(skb, (void (*)(void *))tcp_rfree, skb, GFP_ATOMIC))
+		return 1;
 	atomic_add(skb->truesize, &sk->rmem_alloc);
 	sk->forward_alloc -= skb->truesize;
+	return 0;
 }
 
 extern void tcp_listen_wlock(void);
diff -ur linux-246p5-clean/net/core/skbuff.c linux/net/core/skbuff.c
--- linux-246p5-clean/net/core/skbuff.c	Thu Apr 12 12:11:39 2001
+++ linux/net/core/skbuff.c	Mon Jun 25 12:34:48 2001
@@ -46,6 +46,7 @@
 #include <linux/inet.h>
 #include <linux/slab.h>
 #include <linux/netdevice.h>
+#include <linux/proc_fs.h>
 #include <linux/string.h>
 #include <linux/skbuff.h>
 #include <linux/cache.h>
@@ -71,6 +72,45 @@
 	char			pad[SMP_CACHE_BYTES];
 } skb_head_pool[NR_CPUS];
 
+struct sk_buff_dest_pool sk_buff_dest_free_pool;
+unsigned int skbd_stat_add_dest;
+unsigned int skbd_stat_alloc;
+unsigned int skbd_stat_add_head;
+unsigned int skbd_stat_maybe_call_dest;
+unsigned int skbd_stat_call_dest;
+
+static int skbd_get_info(char *buffer, char **start, off_t offset, int length)
+{
+	int size = 0;
+
+	size += sprintf(buffer + size, "add_head: %d\n", skbd_stat_add_head);
+	size += sprintf(buffer + size, "add_dest: %d\n", skbd_stat_add_dest);
+	size += sprintf(buffer + size, "alloc: %d\n", skbd_stat_alloc);
+	size += sprintf(buffer + size, "maybe_call_dest: %d\n", skbd_stat_maybe_call_dest);
+	size += sprintf(buffer + size, "call_dest: %d\n", skbd_stat_call_dest);
+	return size;
+}
+
+void __init skb_dest_init(void)
+{
+	sk_buff_dest_free_pool.cache = kmem_cache_create("dest_pool_cache",
+		sizeof(struct sk_buff_dest),
+		0,
+		SLAB_HWCACHE_ALIGN,
+		NULL, NULL);
+	if (!sk_buff_dest_free_pool.cache)
+		panic("cannot create sk_buff_dest_pool.cache");
+	spin_lock_init(&sk_buff_dest_free_pool.lock);
+	sk_buff_dest_free_pool.head	 = NULL;
+
+	proc_net_create("skbd", 0, skbd_get_info);
+	skbd_stat_add_head = 0;
+	skbd_stat_add_dest = 0;
+	skbd_stat_alloc = 0;
+	skbd_stat_maybe_call_dest = 0;
+	skbd_stat_call_dest = 0;
+}
+
 /*
  *	Keep out-of-line to prevent kernel bloat.
  *	__builtin_return_address is not used because it is not always
@@ -238,7 +278,7 @@
 	skb->ip_summed = 0;
 	skb->priority = 0;
 	skb->security = 0;	/* By default packets are insecure */
-	skb->destructor = NULL;
+	skb->destructor.head =  NULL;
 
 #ifdef CONFIG_NETFILTER
 	skb->nfmark = skb->nfcache = 0;
@@ -317,13 +357,8 @@
 	}
 
 	dst_release(skb->dst);
-	if(skb->destructor) {
-		if (in_irq()) {
-			printk(KERN_WARNING "Warning: kfree_skb on hard IRQ %p\n",
-				NET_CALLER(skb));
-		}
-		skb->destructor(skb);
-	}
+	skb_call_dest(skb);
+
 #ifdef CONFIG_NETFILTER
 	nf_conntrack_put(skb->nfct);
 #endif
@@ -384,7 +419,7 @@
 	C(data);
 	C(tail);
 	C(end);
-	n->destructor = NULL;
+	n->destructor.head = NULL;
 #ifdef CONFIG_NETFILTER
 	C(nfmark);
 	C(nfcache);
@@ -428,7 +463,7 @@
 	atomic_set(&new->users, 1);
 	new->pkt_type=old->pkt_type;
 	new->stamp=old->stamp;
-	new->destructor = NULL;
+	new->destructor.head = NULL;
 	new->security=old->security;
 #ifdef CONFIG_NETFILTER
 	new->nfmark=old->nfmark;
@@ -1177,4 +1212,6 @@
 
 	for (i=0; i<NR_CPUS; i++)
 		skb_queue_head_init(&skb_head_pool[i].list);
+
+	skb_dest_init();
 }
diff -ur linux-246p5-clean/net/ipv4/ip_gre.c linux/net/ipv4/ip_gre.c
--- linux-246p5-clean/net/ipv4/ip_gre.c	Tue May 15 01:29:35 2001
+++ linux/net/ipv4/ip_gre.c	Mon Jun 25 12:36:11 2001
@@ -821,8 +821,13 @@
 			tunnel->recursion--;
 			return 0;
 		}
-		if (skb->sk)
-			skb_set_owner_w(new_skb, skb->sk);
+		if (skb->sk && skb_set_owner_w(new_skb, skb->sk)) {
+			ip_rt_put(rt);
+			stats->tx_dropped++;
+			dev_kfree_skb(new_skb);
+			tunnel->recursion--;
+			return 0;
+		}
 		dev_kfree_skb(skb);
 		skb = new_skb;
 	}
diff -ur linux-246p5-clean/net/ipv4/ip_output.c linux/net/ipv4/ip_output.c
--- linux-246p5-clean/net/ipv4/ip_output.c	Fri Jun 22 17:29:27 2001
+++ linux/net/ipv4/ip_output.c	Mon Jun 25 10:38:34 2001
@@ -295,8 +295,10 @@
 		kfree_skb(skb);
 		if (skb2 == NULL)
 			return -ENOMEM;
-		if (sk)
-			skb_set_owner_w(skb2, sk);
+		if (sk && skb_set_owner_w(skb2, sk)) {
+			kfree_skb(skb2);	
+			return -ENOMEM;
+		}
 		skb = skb2;
 		iph = skb->nh.iph;
 	}
@@ -802,8 +804,10 @@
 		 *	it might possess
 		 */
 
-		if (skb->sk)
-			skb_set_owner_w(skb2, skb->sk);
+		if (skb->sk && skb_set_owner_w(skb2, skb->sk)) {
+			kfree_skb(skb2);
+			goto fail;
+		}		
 		skb2->dst = dst_clone(skb->dst);
 		skb2->dev = skb->dev;
 
diff -ur linux-246p5-clean/net/ipv4/ipip.c linux/net/ipv4/ipip.c
--- linux-246p5-clean/net/ipv4/ipip.c	Thu May 24 15:00:59 2001
+++ linux/net/ipv4/ipip.c	Mon Jun 25 10:39:46 2001
@@ -613,8 +613,14 @@
 			tunnel->recursion--;
 			return 0;
 		}
-		if (skb->sk)
-			skb_set_owner_w(new_skb, skb->sk);
+		if (skb->sk && skb_set_owner_w(new_skb, skb->sk)) {
+			dev_kfree_skb(new_skb);
+			dev_kfree_skb(skb);
+			ip_rt_put(rt);
+			stats->tx_dropped++;
+			tunnel->recursion--;
+			return 0;
+		}
 		dev_kfree_skb(skb);
 		skb = new_skb;
 	}
diff -ur linux-246p5-clean/net/ipv4/tcp_input.c linux/net/ipv4/tcp_input.c
--- linux-246p5-clean/net/ipv4/tcp_input.c	Fri Jun 22 17:29:27 2001
+++ linux/net/ipv4/tcp_input.c	Mon Jun 25 10:49:27 2001
@@ -2577,7 +2577,11 @@
 				if (tcp_prune_queue(sk) < 0 || !tcp_rmem_schedule(sk, skb))
 					goto drop;
 			}
-			tcp_set_owner_r(skb, sk);
+			if (tcp_set_owner_r(skb, sk)) {
+				printk(" tcp_set_owner_r failed\n");
+				__kfree_skb( skb );
+				return;
+			}	
 			__skb_queue_tail(&sk->receive_queue, skb);
 		}
 		tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
@@ -2658,7 +2662,11 @@
 	SOCK_DEBUG(sk, "out of order segment: rcv_next %X seq %X - %X\n",
 		   tp->rcv_nxt, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
 
-	tcp_set_owner_r(skb, sk);
+	if (tcp_set_owner_r(skb, sk)) {
+		printk(" tcp_set_owner_r (2) failed\n");
+		__kfree_skb(skb);
+		return;
+	}
 
 	if (skb_peek(&tp->out_of_order_queue) == NULL) {
 		/* Initial out of order segment, build 1 SACK. */
@@ -2794,8 +2802,10 @@
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		__skb_insert(nskb, skb->prev, skb, skb->list);
-		tcp_set_owner_r(nskb, sk);
-
+		if (tcp_set_owner_r(nskb, sk)) {
+			//do something to handle failure
+		}
+		
 		/* Copy data, releasing collapsed skbs. */
 		while (copy > 0) {
 			int offset = start - TCP_SKB_CB(skb)->seq;
@@ -3332,7 +3342,8 @@
 				/* Bulk data transfer: receiver */
 				__skb_pull(skb,tcp_header_len);
 				__skb_queue_tail(&sk->receive_queue, skb);
-				tcp_set_owner_r(skb, sk);
+				if (tcp_set_owner_r(skb, sk))
+					goto csum_error;
 				tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 			}
 
diff -ur linux-246p5-clean/net/ipv4/tcp_output.c linux/net/ipv4/tcp_output.c
--- linux-246p5-clean/net/ipv4/tcp_output.c	Thu Apr 12 12:11:39 2001
+++ linux/net/ipv4/tcp_output.c	Mon Jun 25 10:50:02 2001
@@ -224,7 +224,8 @@
 		}
 		th = (struct tcphdr *) skb_push(skb, tcp_header_size);
 		skb->h.th = th;
-		skb_set_owner_w(skb, sk);
+		if (skb_set_owner_w(skb, sk))
+			return -ENOMEM;
 
 		/* Build TCP header and checksum it. */
 		th->source		= sk->sport;
diff -ur linux-246p5-clean/net/netsyms.c linux/net/netsyms.c
--- linux-246p5-clean/net/netsyms.c	Fri Jun 22 17:29:28 2001
+++ linux/net/netsyms.c	Mon Jun 25 10:50:29 2001
@@ -92,6 +92,14 @@
 EXPORT_SYMBOL(skb_over_panic);
 EXPORT_SYMBOL(skb_under_panic);
 
+/* Skbuff destructor list and stats */
+EXPORT_SYMBOL(sk_buff_dest_free_pool);
+EXPORT_SYMBOL(skbd_stat_add_dest);
+EXPORT_SYMBOL(skbd_stat_alloc);
+EXPORT_SYMBOL(skbd_stat_add_head);
+EXPORT_SYMBOL(skbd_stat_maybe_call_dest);
+EXPORT_SYMBOL(skbd_stat_call_dest);
+
 /* Socket layer registration */
 EXPORT_SYMBOL(sock_register);
 EXPORT_SYMBOL(sock_unregister);
diff -ur linux-246p5-clean/net/unix/af_unix.c linux/net/unix/af_unix.c
--- linux-246p5-clean/net/unix/af_unix.c	Thu Apr 12 12:11:39 2001
+++ linux/net/unix/af_unix.c	Mon Jun 25 10:55:24 2001
@@ -1107,16 +1107,18 @@
 	return err;
 }
 
-static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+static int unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	int i;
 
 	scm->fp = UNIXCB(skb).fp;
-	skb->destructor = sock_wfree;
+	if (skb_add_dest(skb, (void (*)(void *))sock_wfree, skb, GFP_ATOMIC))
+		return 1;
 	UNIXCB(skb).fp = NULL;
 
 	for (i=scm->fp->count-1; i>=0; i--)
 		unix_notinflight(scm->fp->fp[i]);
+	return 0;
 }
 
 static void unix_destruct_fds(struct sk_buff *skb)
@@ -1131,14 +1133,16 @@
 	sock_wfree(skb);
 }
 
-static void unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	int i;
 	for (i=scm->fp->count-1; i>=0; i--)
 		unix_inflight(scm->fp->fp[i]);
 	UNIXCB(skb).fp = scm->fp;
-	skb->destructor = unix_destruct_fds;
+	if (skb_add_dest(skb, (void (*)(void *))unix_destruct_fds, skb, GFP_ATOMIC))
+		return 1;
 	scm->fp = NULL;
+	return 0;
 }
 
 /*
@@ -1187,9 +1191,9 @@
 		goto out;
 
 	memcpy(UNIXCREDS(skb), &scm->creds, sizeof(struct ucred));
-	if (scm->fp)
-		unix_attach_fds(scm, skb);
-
+	if (scm->fp && unix_attach_fds(scm, skb))
+		goto out;
+	
 	skb->h.raw = skb->data;
 	err = memcpy_fromiovec(skb_put(skb,len), msg->msg_iov, len);
 	if (err)
@@ -1340,8 +1344,8 @@
 		size = min(size, skb_tailroom(skb));
 
 		memcpy(UNIXCREDS(skb), &scm->creds, sizeof(struct ucred));
-		if (scm->fp)
-			unix_attach_fds(scm, skb);
+		if (scm->fp && unix_attach_fds(scm, skb))
+			goto out_err;
 
 		if ((err = memcpy_fromiovec(skb_put(skb,size), msg->msg_iov, size)) != 0) {
 			kfree_skb(skb);
@@ -1421,8 +1425,8 @@
 
 	if (!(flags & MSG_PEEK))
 	{
-		if (UNIXCB(skb).fp)
-			unix_detach_fds(scm, skb);
+		if (UNIXCB(skb).fp && unix_detach_fds(scm, skb))
+			goto out_free;
 	}
 	else 
 	{
@@ -1584,8 +1588,11 @@
 		{
 			skb_pull(skb, chunk);
 
-			if (UNIXCB(skb).fp)
-				unix_detach_fds(scm, skb);
+			if (UNIXCB(skb).fp && unix_detach_fds(scm, skb)) {
+				skb_queue_head( &sk->receive_queue, skb );
+				copied = -EFAULT;
+				break;
+			}
 
 			/* put the skb back if we didn't use it up.. */
 			if (skb->len)

--LZvS9be/3tNcYl/X--
