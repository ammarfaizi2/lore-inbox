Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUIALfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUIALfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUIALfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:35:48 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1532 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265887AbUIALen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:34:43 -0400
Date: Wed, 1 Sep 2004 17:06:41 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: davem@redhat.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Dipankar <dipankar@in.ibm.com>, paulmck@us.ibm.com
Subject: Re: [RFC] Use RCU for tcp_ehash lookup
Message-ID: <20040901113641.GA3918@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040831125941.GA5534@in.ibm.com> <20040831135419.GA17642@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831135419.GA17642@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 03:54:20PM +0200, Andi Kleen wrote:
> I bet also when you just do rdtsc timing for the TCP receive
> path the cycle numbers will be way down (excluding the copy).

I got cycle numbers for the lookup routine (with CONFIG_PREEMPT turned off).
They were taken on a 900MHz 8way Intel P3 SMP box.  The results are as below:


-------------------------------------------------------------------------------
			     |	2.6.8.1		      |	2.6.8.1 + my patch
-------------------------------------------------------------------------------
Average cycles 		     |			      |
spent in 		     |			      |
__tcp_v4_lookup_established  |	2970.65               |	668.227
			     | (~3.3 micro-seconds)   | (~0.74 microseconds)
-------------------------------------------------------------------------------

This repesents improvement by a factor of 77.5%!


> 
> And it should also fix the performance problems with
> cat /proc/net/tcp on ppc64/ia64 for large hash tables because the rw locks 
> are gone.

But spinlocks are in! Would that still improve the performance compared to rw 
locks?  (See me earlier note where I have explained that lookup done for 
/proc/net/tcp is _not_ lock-free yet).

> I haven't studied it in detail (yet), just two minor style 
> comments: 

[snip]

> Can you rewrite that without goto? 

[snip]

> And that too.

I have avoided the goto's in the updated patch below.

Thanks!!


---

 linux-2.6.8.1-vatsa/include/net/sock.h       |   22 +++++++++--
 linux-2.6.8.1-vatsa/include/net/tcp.h        |   24 +++++++++---
 linux-2.6.8.1-vatsa/net/core/sock.c          |   11 +++++
 linux-2.6.8.1-vatsa/net/ipv4/tcp.c           |    2 -
 linux-2.6.8.1-vatsa/net/ipv4/tcp_diag.c      |   11 +++--
 linux-2.6.8.1-vatsa/net/ipv4/tcp_ipv4.c      |   50 ++++++++++++++++-----------
 linux-2.6.8.1-vatsa/net/ipv4/tcp_minisocks.c |   47 ++++++++++++++++++++-----
 linux-2.6.8.1-vatsa/net/ipv6/tcp_ipv6.c      |   22 +++++++----
 8 files changed, 135 insertions(+), 54 deletions(-)

diff -puN include/net/sock.h~tcp_ehash include/net/sock.h
--- linux-2.6.8.1/include/net/sock.h~tcp_ehash	2004-08-25 18:06:42.000000000 +0530
+++ linux-2.6.8.1-vatsa/include/net/sock.h	2004-09-01 10:09:43.000000000 +0530
@@ -50,6 +50,7 @@
 #include <linux/security.h>
 
 #include <linux/filter.h>
+#include <linux/rcupdate.h>
 
 #include <asm/atomic.h>
 #include <net/dst.h>
@@ -178,6 +179,7 @@ struct sock_common {
   *	@sk_error_report - callback to indicate errors (e.g. %MSG_ERRQUEUE)
   *	@sk_backlog_rcv - callback to process the backlog
   *	@sk_destruct - called at sock freeing time, i.e. when all refcnt == 0
+  *	@sk_rcu - RCU callback structure
  */
 struct sock {
 	/*
@@ -266,6 +268,7 @@ struct sock {
   	int			(*sk_backlog_rcv)(struct sock *sk,
 						  struct sk_buff *skb);  
 	void                    (*sk_destruct)(struct sock *sk);
+	struct rcu_head		sk_rcu;
 };
 
 /*
@@ -350,7 +353,7 @@ static __inline__ int sk_del_node_init(s
 
 static __inline__ void __sk_add_node(struct sock *sk, struct hlist_head *list)
 {
-	hlist_add_head(&sk->sk_node, list);
+	hlist_add_head_rcu(&sk->sk_node, list);
 }
 
 static __inline__ void sk_add_node(struct sock *sk, struct hlist_head *list)
@@ -371,7 +374,7 @@ static __inline__ void sk_add_bind_node(
 }
 
 #define sk_for_each(__sk, node, list) \
-	hlist_for_each_entry(__sk, node, list, sk_node)
+	hlist_for_each_entry_rcu(__sk, node, list, sk_node)
 #define sk_for_each_from(__sk, node) \
 	if (__sk && ({ node = &(__sk)->sk_node; 1; })) \
 		hlist_for_each_entry_from(__sk, node, sk_node)
@@ -703,6 +706,7 @@ extern void FASTCALL(release_sock(struct
 extern struct sock *		sk_alloc(int family, int priority, int zero_it,
 					 kmem_cache_t *slab);
 extern void			sk_free(struct sock *sk);
+extern void			sk_free_rcu(struct rcu_head *head);
 
 extern struct sk_buff		*sock_wmalloc(struct sock *sk,
 					      unsigned long size, int force,
@@ -888,8 +892,18 @@ static inline void sk_filter_charge(stru
 /* Ungrab socket and destroy it, if it was the last reference. */
 static inline void sock_put(struct sock *sk)
 {
-	if (atomic_dec_and_test(&sk->sk_refcnt))
-		sk_free(sk);
+	while (atomic_dec_and_test(&sk->sk_refcnt)) {
+		/* Restore ref count and schedule callback.
+		 * If we don't restore ref count, then the callback can be
+		 * scheduled by more than one CPU.
+		 */
+		atomic_inc(&sk->sk_refcnt);
+
+		if (atomic_read(&sk->sk_refcnt) == 1) {
+			call_rcu(&sk->sk_rcu, sk_free_rcu);
+			break;
+		}
+	}
 }
 
 /* Detach socket from process context.
diff -puN include/net/tcp.h~tcp_ehash include/net/tcp.h
--- linux-2.6.8.1/include/net/tcp.h~tcp_ehash	2004-08-25 18:06:42.000000000 +0530
+++ linux-2.6.8.1-vatsa/include/net/tcp.h	2004-09-01 10:13:40.000000000 +0530
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
+#include <linux/rcupdate.h>
 #include <net/checksum.h>
 #include <net/sock.h>
 #include <net/snmp.h>
@@ -44,7 +45,7 @@
  * for the rest.  I'll experiment with dynamic table growth later.
  */
 struct tcp_ehash_bucket {
-	rwlock_t	  lock;
+	spinlock_t	  lock;
 	struct hlist_head chain;
 } __attribute__((__aligned__(8)));
 
@@ -222,12 +223,13 @@ struct tcp_tw_bucket {
 	struct in6_addr		tw_v6_rcv_saddr;
 	int			tw_v6_ipv6only;
 #endif
+	struct rcu_head		tw_rcu;
 };
 
 static __inline__ void tw_add_node(struct tcp_tw_bucket *tw,
 				   struct hlist_head *list)
 {
-	hlist_add_head(&tw->tw_node, list);
+	hlist_add_head_rcu(&tw->tw_node, list);
 }
 
 static __inline__ void tw_add_bind_node(struct tcp_tw_bucket *tw,
@@ -305,14 +307,22 @@ static inline int tcp_v6_ipv6only(const 
 #endif
 
 extern kmem_cache_t *tcp_timewait_cachep;
+extern void tcp_tw_free(struct rcu_head *head);
 
 static inline void tcp_tw_put(struct tcp_tw_bucket *tw)
 {
-	if (atomic_dec_and_test(&tw->tw_refcnt)) {
-#ifdef INET_REFCNT_DEBUG
-		printk(KERN_DEBUG "tw_bucket %p released\n", tw);
-#endif
-		kmem_cache_free(tcp_timewait_cachep, tw);
+	while (atomic_dec_and_test(&tw->tw_refcnt)) {
+		/* Restore ref count and schedule callback.
+		 * If we don't restore ref count, then the callback can be
+		 * scheduled by more than one CPU.
+		 */
+
+		atomic_inc(&tw->tw_refcnt);
+
+		if (atomic_read(&tw->tw_refcnt) == 1) {
+			call_rcu(&tw->tw_rcu, tcp_tw_free);
+			break;
+		}
 	}
 }
 
diff -puN net/core/sock.c~tcp_ehash net/core/sock.c
--- linux-2.6.8.1/net/core/sock.c~tcp_ehash	2004-08-25 18:06:42.000000000 +0530
+++ linux-2.6.8.1-vatsa/net/core/sock.c	2004-08-26 16:53:14.000000000 +0530
@@ -657,6 +657,16 @@ void sk_free(struct sock *sk)
 	module_put(owner);
 }
 
+/* RCU callback to free a socket */
+
+void sk_free_rcu(struct rcu_head *head)
+{
+	struct sock *sk = container_of(head, struct sock, sk_rcu);
+
+	if (atomic_dec_and_test(&sk->sk_refcnt))
+		sk_free(sk);
+}
+
 void __init sk_init(void)
 {
 	sk_cachep = kmem_cache_create("sock", sizeof(struct sock), 0,
@@ -1347,6 +1357,7 @@ EXPORT_SYMBOL(__lock_sock);
 EXPORT_SYMBOL(__release_sock);
 EXPORT_SYMBOL(sk_alloc);
 EXPORT_SYMBOL(sk_free);
+EXPORT_SYMBOL(sk_free_rcu);
 EXPORT_SYMBOL(sk_send_sigurg);
 EXPORT_SYMBOL(sock_alloc_send_pskb);
 EXPORT_SYMBOL(sock_alloc_send_skb);
diff -puN net/ipv4/tcp_ipv4.c~tcp_ehash net/ipv4/tcp_ipv4.c
--- linux-2.6.8.1/net/ipv4/tcp_ipv4.c~tcp_ehash	2004-08-25 18:06:42.000000000 +0530
+++ linux-2.6.8.1-vatsa/net/ipv4/tcp_ipv4.c	2004-08-25 18:07:27.000000000 +0530
@@ -351,7 +351,8 @@ void tcp_listen_wlock(void)
 static __inline__ void __tcp_v4_hash(struct sock *sk, const int listen_possible)
 {
 	struct hlist_head *list;
-	rwlock_t *lock;
+	rwlock_t *lock = NULL;
+	spinlock_t *slock = NULL;
 
 	BUG_TRAP(sk_unhashed(sk));
 	if (listen_possible && sk->sk_state == TCP_LISTEN) {
@@ -360,14 +361,16 @@ static __inline__ void __tcp_v4_hash(str
 		tcp_listen_wlock();
 	} else {
 		list = &tcp_ehash[(sk->sk_hashent = tcp_sk_hashfn(sk))].chain;
-		lock = &tcp_ehash[sk->sk_hashent].lock;
-		write_lock(lock);
+		slock = &tcp_ehash[sk->sk_hashent].lock;
+		spin_lock(slock);
 	}
 	__sk_add_node(sk, list);
 	sock_prot_inc_use(sk->sk_prot);
-	write_unlock(lock);
-	if (listen_possible && sk->sk_state == TCP_LISTEN)
+	if (listen_possible && sk->sk_state == TCP_LISTEN) {
+		write_unlock(lock);
 		wake_up(&tcp_lhash_wait);
+	} else
+		spin_unlock(slock);
 }
 
 static void tcp_v4_hash(struct sock *sk)
@@ -381,7 +384,8 @@ static void tcp_v4_hash(struct sock *sk)
 
 void tcp_unhash(struct sock *sk)
 {
-	rwlock_t *lock;
+	rwlock_t *lock = NULL;
+	spinlock_t *slock = NULL;
 
 	if (sk_unhashed(sk))
 		goto ende;
@@ -392,17 +396,20 @@ void tcp_unhash(struct sock *sk)
 		lock = &tcp_lhash_lock;
 	} else {
 		struct tcp_ehash_bucket *head = &tcp_ehash[sk->sk_hashent];
-		lock = &head->lock;
-		write_lock_bh(&head->lock);
+		slock = &head->lock;
+		spin_lock_bh(&head->lock);
 	}
 
 	if (__sk_del_node_init(sk))
 		sock_prot_dec_use(sk->sk_prot);
-	write_unlock_bh(lock);
 
+	if (sk->sk_state != TCP_LISTEN)
+		spin_unlock_bh(slock);
+	else {
+		write_unlock_bh(lock);
  ende:
-	if (sk->sk_state == TCP_LISTEN)
 		wake_up(&tcp_lhash_wait);
+	}
 }
 
 /* Don't inline this cruft.  Here are some nice properties to
@@ -494,7 +501,7 @@ static inline struct sock *__tcp_v4_look
 	 */
 	int hash = tcp_hashfn(daddr, hnum, saddr, sport);
 	head = &tcp_ehash[hash];
-	read_lock(&head->lock);
+	rcu_read_lock();
 	sk_for_each(sk, node, &head->chain) {
 		if (TCP_IPV4_MATCH(sk, acookie, saddr, daddr, ports, dif))
 			goto hit; /* You sunk my battleship! */
@@ -507,7 +514,7 @@ static inline struct sock *__tcp_v4_look
 	}
 	sk = NULL;
 out:
-	read_unlock(&head->lock);
+	rcu_read_unlock();
 	return sk;
 hit:
 	sock_hold(sk);
@@ -559,7 +566,7 @@ static int __tcp_v4_check_established(st
 	struct hlist_node *node;
 	struct tcp_tw_bucket *tw;
 
-	write_lock(&head->lock);
+	spin_lock(&head->lock);
 
 	/* Check TIME-WAIT sockets first. */
 	sk_for_each(sk2, node, &(head + tcp_ehash_size)->chain) {
@@ -614,7 +621,7 @@ unique:
 	BUG_TRAP(sk_unhashed(sk));
 	__sk_add_node(sk, &head->chain);
 	sock_prot_inc_use(sk->sk_prot);
-	write_unlock(&head->lock);
+	spin_unlock(&head->lock);
 
 	if (twp) {
 		*twp = tw;
@@ -630,7 +637,7 @@ unique:
 	return 0;
 
 not_unique:
-	write_unlock(&head->lock);
+	spin_unlock(&head->lock);
 	return -EADDRNOTAVAIL;
 }
 
@@ -2228,7 +2235,10 @@ static void *established_get_first(struc
 		struct hlist_node *node;
 		struct tcp_tw_bucket *tw;
 	       
-		read_lock(&tcp_ehash[st->bucket].lock);
+		/* Take the spinlock. Otherwise a dancing socket
+		 * (__tcp_tw_hashdance) may be reported twice!
+		 */
+		spin_lock(&tcp_ehash[st->bucket].lock);
 		sk_for_each(sk, node, &tcp_ehash[st->bucket].chain) {
 			if (sk->sk_family != st->family) {
 				continue;
@@ -2245,7 +2255,7 @@ static void *established_get_first(struc
 			rc = tw;
 			goto out;
 		}
-		read_unlock(&tcp_ehash[st->bucket].lock);
+		spin_unlock(&tcp_ehash[st->bucket].lock);
 		st->state = TCP_SEQ_STATE_ESTABLISHED;
 	}
 out:
@@ -2272,10 +2282,10 @@ get_tw:
 			cur = tw;
 			goto out;
 		}
-		read_unlock(&tcp_ehash[st->bucket].lock);
+		spin_unlock(&tcp_ehash[st->bucket].lock);
 		st->state = TCP_SEQ_STATE_ESTABLISHED;
 		if (++st->bucket < tcp_ehash_size) {
-			read_lock(&tcp_ehash[st->bucket].lock);
+			spin_lock(&tcp_ehash[st->bucket].lock);
 			sk = sk_head(&tcp_ehash[st->bucket].chain);
 		} else {
 			cur = NULL;
@@ -2385,7 +2395,7 @@ static void tcp_seq_stop(struct seq_file
 	case TCP_SEQ_STATE_TIME_WAIT:
 	case TCP_SEQ_STATE_ESTABLISHED:
 		if (v)
-			read_unlock(&tcp_ehash[st->bucket].lock);
+			spin_unlock(&tcp_ehash[st->bucket].lock);
 		local_bh_enable();
 		break;
 	}
diff -puN net/ipv4/tcp.c~tcp_ehash net/ipv4/tcp.c
--- linux-2.6.8.1/net/ipv4/tcp.c~tcp_ehash	2004-08-25 18:06:42.000000000 +0530
+++ linux-2.6.8.1-vatsa/net/ipv4/tcp.c	2004-08-25 18:07:27.000000000 +0530
@@ -2258,7 +2258,7 @@ void __init tcp_init(void)
 	if (!tcp_ehash)
 		panic("Failed to allocate TCP established hash table\n");
 	for (i = 0; i < (tcp_ehash_size << 1); i++) {
-		tcp_ehash[i].lock = RW_LOCK_UNLOCKED;
+		tcp_ehash[i].lock = SPIN_LOCK_UNLOCKED;
 		INIT_HLIST_HEAD(&tcp_ehash[i].chain);
 	}
 
diff -puN net/ipv4/tcp_diag.c~tcp_ehash net/ipv4/tcp_diag.c
--- linux-2.6.8.1/net/ipv4/tcp_diag.c~tcp_ehash	2004-08-25 18:06:42.000000000 +0530
+++ linux-2.6.8.1-vatsa/net/ipv4/tcp_diag.c	2004-08-25 18:07:27.000000000 +0530
@@ -522,7 +522,10 @@ skip_listen_ht:
 		if (i > s_i)
 			s_num = 0;
 
-		read_lock_bh(&head->lock);
+		/* Take the spinlock. Otherwise a dancing socket
+		 * (__tcp_tw_hashdance) may be reported twice!
+		 */
+		spin_lock_bh(&head->lock);
 
 		num = 0;
 		sk_for_each(sk, node, &head->chain) {
@@ -542,7 +545,7 @@ skip_listen_ht:
 			if (tcpdiag_fill(skb, sk, r->tcpdiag_ext,
 					 NETLINK_CB(cb->skb).pid,
 					 cb->nlh->nlmsg_seq) <= 0) {
-				read_unlock_bh(&head->lock);
+				spin_unlock_bh(&head->lock);
 				goto done;
 			}
 			++num;
@@ -568,13 +571,13 @@ skip_listen_ht:
 				if (tcpdiag_fill(skb, sk, r->tcpdiag_ext,
 						 NETLINK_CB(cb->skb).pid,
 						 cb->nlh->nlmsg_seq) <= 0) {
-					read_unlock_bh(&head->lock);
+					spin_unlock_bh(&head->lock);
 					goto done;
 				}
 				++num;
 			}
 		}
-		read_unlock_bh(&head->lock);
+		spin_unlock_bh(&head->lock);
 	}
 
 done:
diff -puN net/ipv4/tcp_minisocks.c~tcp_ehash net/ipv4/tcp_minisocks.c
--- linux-2.6.8.1/net/ipv4/tcp_minisocks.c~tcp_ehash	2004-08-25 18:06:42.000000000 +0530
+++ linux-2.6.8.1-vatsa/net/ipv4/tcp_minisocks.c	2004-08-26 16:58:08.000000000 +0530
@@ -64,14 +64,14 @@ static void tcp_timewait_kill(struct tcp
 
 	/* Unlink from established hashes. */
 	ehead = &tcp_ehash[tw->tw_hashent];
-	write_lock(&ehead->lock);
+	spin_lock(&ehead->lock);
 	if (hlist_unhashed(&tw->tw_node)) {
-		write_unlock(&ehead->lock);
+		spin_unlock(&ehead->lock);
 		return;
 	}
 	__hlist_del(&tw->tw_node);
 	sk_node_init(&tw->tw_node);
-	write_unlock(&ehead->lock);
+	spin_unlock(&ehead->lock);
 
 	/* Disassociate with bind bucket. */
 	bhead = &tcp_bhash[tcp_bhashfn(tw->tw_num)];
@@ -308,17 +308,28 @@ static void __tcp_tw_hashdance(struct so
 	tw_add_bind_node(tw, &tw->tw_tb->owners);
 	spin_unlock(&bhead->lock);
 
-	write_lock(&ehead->lock);
+	spin_lock(&ehead->lock);
 
-	/* Step 2: Remove SK from established hash. */
-	if (__sk_del_node_init(sk))
-		sock_prot_dec_use(sk->sk_prot);
+	/*
+	 * We have to be carefull here since there could be racing
+	 * (lock-free) lookups happening on other CPUs. If we remove SK first
+	 * and then add TW, then there is a tiny window where this socket is
+	 * in neither the established half nor in the TIMEWAIT half of the ehash
+	 * table. Lookups occuring in that window can drop packets!
+	 * Hence we first add TW and then remove SK, with a barrier in between.
+	 */
 
-	/* Step 3: Hash TW into TIMEWAIT half of established hash table. */
+	/* Step 2: Hash TW into TIMEWAIT half of established hash table. */
 	tw_add_node(tw, &(ehead + tcp_ehash_size)->chain);
 	atomic_inc(&tw->tw_refcnt);
 
-	write_unlock(&ehead->lock);
+	smp_wmb();
+
+	/* Step 3: Remove SK from established hash. */
+	if (__sk_del_node_init(sk))
+		sock_prot_dec_use(sk->sk_prot);
+
+	spin_unlock(&ehead->lock);
 }
 
 /* 
@@ -1069,11 +1080,29 @@ int tcp_child_process(struct sock *paren
 	return ret;
 }
 
+/* RCU callback to free a timewait bucket */
+
+void tcp_tw_free(struct rcu_head *head)
+{
+	struct tcp_tw_bucket *tw =
+		container_of(head, struct tcp_tw_bucket, tw_rcu);
+
+	if (atomic_dec_and_test(&tw->tw_refcnt)) {
+#ifdef INET_REFCNT_DEBUG
+		printk(KERN_DEBUG "tw_bucket %p released\n", tw);
+#endif
+        	kmem_cache_free(tcp_timewait_cachep, tw);
+	}
+}
+
+
+
 EXPORT_SYMBOL(tcp_check_req);
 EXPORT_SYMBOL(tcp_child_process);
 EXPORT_SYMBOL(tcp_create_openreq_child);
 EXPORT_SYMBOL(tcp_timewait_state_process);
 EXPORT_SYMBOL(tcp_tw_deschedule);
+EXPORT_SYMBOL(tcp_tw_free);
 
 #ifdef CONFIG_SYSCTL
 EXPORT_SYMBOL(sysctl_tcp_tw_recycle);
diff -puN net/ipv6/tcp_ipv6.c~tcp_ehash net/ipv6/tcp_ipv6.c
--- linux-2.6.8.1/net/ipv6/tcp_ipv6.c~tcp_ehash	2004-08-25 18:06:42.000000000 +0530
+++ linux-2.6.8.1-vatsa/net/ipv6/tcp_ipv6.c	2004-08-25 18:07:27.000000000 +0530
@@ -210,7 +210,8 @@ fail:
 static __inline__ void __tcp_v6_hash(struct sock *sk)
 {
 	struct hlist_head *list;
-	rwlock_t *lock;
+	rwlock_t *lock = NULL;
+	spinlock_t *slock = NULL;
 
 	BUG_TRAP(sk_unhashed(sk));
 
@@ -221,13 +222,16 @@ static __inline__ void __tcp_v6_hash(str
 	} else {
 		sk->sk_hashent = tcp_v6_sk_hashfn(sk);
 		list = &tcp_ehash[sk->sk_hashent].chain;
-		lock = &tcp_ehash[sk->sk_hashent].lock;
-		write_lock(lock);
+		slock = &tcp_ehash[sk->sk_hashent].lock;
+		spin_lock(slock);
 	}
 
 	__sk_add_node(sk, list);
 	sock_prot_inc_use(sk->sk_prot);
-	write_unlock(lock);
+	if (sk->sk_state == TCP_LISTEN)
+		write_unlock(lock);
+	else
+		spin_unlock(slock);
 }
 
 
@@ -307,7 +311,7 @@ static inline struct sock *__tcp_v6_look
 	 */
 	hash = tcp_v6_hashfn(daddr, hnum, saddr, sport);
 	head = &tcp_ehash[hash];
-	read_lock(&head->lock);
+	rcu_read_lock();
 	sk_for_each(sk, node, &head->chain) {
 		/* For IPV6 do the cheaper port and family tests first. */
 		if(TCP_IPV6_MATCH(sk, saddr, daddr, ports, dif))
@@ -326,12 +330,12 @@ static inline struct sock *__tcp_v6_look
 				goto hit;
 		}
 	}
-	read_unlock(&head->lock);
+	rcu_read_unlock();
 	return NULL;
 
 hit:
 	sock_hold(sk);
-	read_unlock(&head->lock);
+	rcu_read_unlock();
 	return sk;
 }
 
@@ -452,7 +456,7 @@ static int tcp_v6_check_established(stru
 	struct hlist_node *node;
 	struct tcp_tw_bucket *tw;
 
-	write_lock_bh(&head->lock);
+	spin_lock_bh(&head->lock);
 
 	/* Check TIME-WAIT sockets first. */
 	sk_for_each(sk2, node, &(head + tcp_ehash_size)->chain) {
@@ -491,7 +495,7 @@ unique:
 	__sk_add_node(sk, &head->chain);
 	sk->sk_hashent = hash;
 	sock_prot_inc_use(sk->sk_prot);
-	write_unlock_bh(&head->lock);
+	spin_unlock_bh(&head->lock);
 
 	if (tw) {
 		/* Silly. Should hash-dance instead... */

_
-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
