Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVLUWhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVLUWhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVLUWhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:37:16 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:44773 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964852AbVLUWhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:37:14 -0500
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
	latencies
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1135145065.29182.10.camel@mindpipe>
References: <1135145065.29182.10.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 17:37:09 -0500
Message-Id: <1135204629.14810.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 01:04 -0500, Lee Revell wrote:
> Here is a 13ms+ trace caused by "netstat -anop".  I noticed that the
> preempt count is 0 so there are no locks to drop, would adding a
> cond_resched() be acceptable?  Or should this be considered more
> evidence of the need for softirq preemption?
> 
> preemption latency trace v1.1.5 on 2.6.14-rt22
> --------------------------------------------------------------------
>  latency: 13824 us, #16533/16533, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
>     -----------------
>     | task: softirq-timer/0-3 (uid:0 nice:0 policy:1 rt_prio:1)
>     -----------------
>  
>                  _------=> CPU#            
>                 / _-----=> irqs-off        
>                | / _----=> need-resched    
>                || / _---=> hardirq/softirq 
>                ||| / _--=> preempt-depth   
>                |||| /                      
>                |||||     delay             
>    cmd     pid ||||| time  |   caller      
>       \   /    |||||   \   |   /           
>  netstat-29157 0D.h2    0us : __trace_start_sched_wakeup (try_to_wake_up)
>  netstat-29157 0D.h2    1us : __trace_start_sched_wakeup <<...>-3> (62 0)
>  netstat-29157 0D.h.    2us : wake_up_process (wakeup_softirqd)

Hi Lee, I've seen the same thing here.  I wrote up this patch as a case
study to see if it can work and it does.  Now this sacrifices memory for
speed.  I added a bitmask in the inet_hash to keep track of all the
buckets that are used, and use the find_next_bit to search the list in
established_get_first.

After running the netstat -anop I get the following:

preemption latency trace v1.1.5 on 2.6.14-rt22
--------------------------------------------------------------------
 latency: 377 us, #225/225, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
    -----------------
    | task: softirq-timer/0-3 (uid:0 nice:0 policy:1 rt_prio:1)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
  <idle>-0     0D.h4    0us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0D.h4    0us : __trace_start_sched_wakeup <<...>-3> (62 0)
  <idle>-0     0Dnh3    0us : try_to_wake_up <<...>-3> (62 8c)
  <idle>-0     0Dnh2    1us : preempt_schedule (try_to_wake_up)
  <idle>-0     0Dnh2    1us : wake_up_process (wakeup_softirqd)
[snip]

So it really does improve the latency here.  Now is this worth the
overhead?  This might be useful in other places to.

Ingo,

What do you think?

-- Steve

Index: linux-2.6.14-rt22/include/net/inet_hashtables.h
===================================================================
--- linux-2.6.14-rt22.orig/include/net/inet_hashtables.h	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.14-rt22/include/net/inet_hashtables.h	2005-12-21 17:05:35.000000000 -0500
@@ -101,6 +101,7 @@
 	 * is for TIME_WAIT sockets only.
 	 */
 	struct inet_ehash_bucket	*ehash;
+	unsigned long			*ebitmask;
 
 	/* Ok, let's try this, I give up, we do need a local binding
 	 * TCP hash as well as the others for fast bind/connect.
@@ -157,6 +158,13 @@
 	return &hashinfo->ehash[hash & (hashinfo->ehash_size - 1)];
 }
 
+static inline unsigned int inet_ehash_index(
+	struct inet_hashinfo *hashinfo,
+	unsigned int hash)
+{
+	return hash & (hashinfo->ehash_size - 1);
+}
+
 extern struct inet_bind_bucket *
 		    inet_bind_bucket_create(kmem_cache_t *cachep,
 					    struct inet_bind_hashbucket *head,
@@ -229,11 +237,25 @@
 		wake_up(&hashinfo->lhash_wait);
 }
 
+static inline void __inet_hash_setbit(unsigned long *bitmask, unsigned int index)
+{
+	if (bitmask)
+		set_bit(index, bitmask);
+}
+
+static inline void __inet_hash_clearbit(unsigned long *bitmask, unsigned int index)
+{
+	if (bitmask)
+		clear_bit(index, bitmask);
+}
+
 static inline void __inet_hash(struct inet_hashinfo *hashinfo,
 			       struct sock *sk, const int listen_possible)
 {
 	struct hlist_head *list;
 	rwlock_t *lock;
+	unsigned long *bitmask = NULL;
+	unsigned int index = 0;
 
 	BUG_TRAP(sk_unhashed(sk));
 	if (listen_possible && sk->sk_state == TCP_LISTEN) {
@@ -243,12 +265,15 @@
 	} else {
 		struct inet_ehash_bucket *head;
 		sk->sk_hash = inet_sk_ehashfn(sk);
+		index = inet_ehash_index(hashinfo, sk->sk_hash);
 		head = inet_ehash_bucket(hashinfo, sk->sk_hash);
 		list = &head->chain;
 		lock = &head->lock;
+		bitmask = hashinfo->ebitmask;
 		write_lock(lock);
 	}
 	__sk_add_node(sk, list);
+	__inet_hash_setbit(bitmask, index);
 	sock_prot_inc_use(sk->sk_prot);
 	write_unlock(lock);
 	if (listen_possible && sk->sk_state == TCP_LISTEN)
@@ -267,6 +292,8 @@
 static inline void inet_unhash(struct inet_hashinfo *hashinfo, struct sock *sk)
 {
 	rwlock_t *lock;
+	unsigned long *bitmask = NULL;
+	unsigned int index = 0;
 
 	if (sk_unhashed(sk))
 		goto out;
@@ -276,12 +303,16 @@
 		inet_listen_wlock(hashinfo);
 		lock = &hashinfo->lhash_lock;
 	} else {
+		index = inet_ehash_index(hashinfo, sk->sk_hash);
 		lock = &inet_ehash_bucket(hashinfo, sk->sk_hash)->lock;
+		bitmask = hashinfo->ebitmask;
 		write_lock_bh(lock);
 	}
 
-	if (__sk_del_node_init(sk))
+	if (__sk_del_node_init(sk)) {
+		__inet_hash_clearbit(bitmask, index);
 		sock_prot_dec_use(sk->sk_prot);
+	}
 	write_unlock_bh(lock);
 out:
 	if (sk->sk_state == TCP_LISTEN)
Index: linux-2.6.14-rt22/mm/page_alloc.c
===================================================================
--- linux-2.6.14-rt22.orig/mm/page_alloc.c	2005-12-15 21:46:16.000000000 -0500
+++ linux-2.6.14-rt22/mm/page_alloc.c	2005-12-21 17:05:23.000000000 -0500
@@ -2601,3 +2601,30 @@
 
 	return table;
 }
+
+void *__init alloc_large_system_bitmask(char *bitmaskname,
+					unsigned long bits, int flags)
+{
+	unsigned long words = bits / (sizeof(unsigned long)*8);
+	unsigned long size = words * sizeof(unsigned long);
+	unsigned long *bitmask = NULL;
+
+	if (flags & HASH_EARLY)
+		bitmask = alloc_bootmem(size);
+	else if (hashdist)
+		bitmask = __vmalloc(size, GFP_ATOMIC, PAGE_KERNEL);
+	else {
+		bitmask = kmalloc(size, GFP_ATOMIC);
+		if (!bitmask) {
+			unsigned long order;
+			for (order = 0; ((1UL << order) << PAGE_SHIFT) < size; order++)
+				;
+			bitmask = (void*) __get_free_pages(GFP_ATOMIC, order);
+		}
+	}
+
+	if (!bitmask)
+		panic("Failed to allocate %s bitmask\n", bitmaskname);
+
+	return bitmask;
+}
Index: linux-2.6.14-rt22/net/ipv4/tcp.c
===================================================================
--- linux-2.6.14-rt22.orig/net/ipv4/tcp.c	2005-12-21 16:49:59.000000000 -0500
+++ linux-2.6.14-rt22/net/ipv4/tcp.c	2005-12-21 17:31:07.000000000 -0500
@@ -2038,6 +2038,8 @@
 }
 __setup("thash_entries=", set_thash_entries);
 
+void *__init alloc_large_system_bitmask(char *bitmaskname,
+					unsigned long bits, int flags);
 void __init tcp_init(void)
 {
 	struct sk_buff *skb = NULL;
@@ -2071,6 +2073,10 @@
 					NULL,
 					0);
 	tcp_hashinfo.ehash_size = (1 << tcp_hashinfo.ehash_size) >> 1;
+	tcp_hashinfo.ebitmask =
+		alloc_large_system_bitmask("TCP established",
+					  tcp_hashinfo.ehash_size,
+					  HASH_HIGHMEM);
 
 	for (i = 0; i < (tcp_hashinfo.ehash_size << 1); i++) {
 		rwlock_init(&tcp_hashinfo.ehash[i].lock);
Index: linux-2.6.14-rt22/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6.14-rt22.orig/net/ipv4/tcp_ipv4.c	2005-12-21 17:08:20.000000000 -0500
+++ linux-2.6.14-rt22/net/ipv4/tcp_ipv4.c	2005-12-21 17:26:18.000000000 -0500
@@ -1590,7 +1590,12 @@
 	struct tcp_iter_state* st = seq->private;
 	void *rc = NULL;
 
-	for (st->bucket = 0; st->bucket < tcp_hashinfo.ehash_size; ++st->bucket) {
+	for (st->bucket = find_first_bit(tcp_hashinfo.ebitmask,
+					 tcp_hashinfo.ehash_size);
+	     st->bucket < tcp_hashinfo.ehash_size;
+	     st->bucket = find_next_bit(tcp_hashinfo.ebitmask,
+					tcp_hashinfo.ehash_size,
+					st->bucket+1)) {
 		struct sock *sk;
 		struct hlist_node *node;
 		struct inet_timewait_sock *tw;


