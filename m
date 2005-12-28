Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVL1Caw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVL1Caw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 21:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVL1Caw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 21:30:52 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:50430 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932455AbVL1Cav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 21:30:51 -0500
Date: Tue, 27 Dec 2005 21:30:45 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
 latencies
In-Reply-To: <1135736563.22744.58.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0512272128040.12225@gandalf.stny.rr.com>
References: <1135145065.29182.10.camel@mindpipe>  <1135204629.14810.43.camel@localhost.localdomain>
  <1135732888.22744.51.camel@mindpipe>  <Pine.LNX.4.58.0512272110490.10936@gandalf.stny.rr.com>
 <1135736563.22744.58.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2005, Lee Revell wrote:

> On Tue, 2005-12-27 at 21:11 -0500, Steven Rostedt wrote:
> > On Tue, 27 Dec 2005, Lee Revell wrote:
> >
> > > > [snip]
> > > >
> > > > So it really does improve the latency here.  Now is this worth the
> > > > overhead?  This might be useful in other places to.
> > >
> > > Any chance you can regenerate the patch against 2.6.15-rc5-rt4?
> > >
> >
> > Sure, if I can find the damn thing.  Too many kernels, and too many patch
> > directories.
>
> Never mind, I applied it by hand.  I'll let you know how it works.
>

OK, I did find it though, and it only had one rej. So you probably can
easily do that change yourself.

Aw heck, here it is anyway. (look everybody, a patch pulled in with
pine!).  Complements of quilt.


-- Steve

Index: linux-2.6.15-rc5-rt4/include/net/inet_hashtables.h
===================================================================
--- linux-2.6.15-rc5-rt4.orig/include/net/inet_hashtables.h	2005-12-14 14:37:00.000000000 -0500
+++ linux-2.6.15-rc5-rt4/include/net/inet_hashtables.h	2005-12-27 21:12:57.000000000 -0500
@@ -101,6 +101,7 @@
 	 * is for TIME_WAIT sockets only.
 	 */
 	struct inet_ehash_bucket	*ehash;
+	unsigned long			*ebitmask;

 	/* Ok, let's try this, I give up, we do need a local binding
 	 * TCP hash as well as the others for fast bind/connect.
@@ -155,6 +156,13 @@
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
@@ -227,11 +235,25 @@
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
@@ -241,12 +263,15 @@
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
@@ -265,6 +290,8 @@
 static inline void inet_unhash(struct inet_hashinfo *hashinfo, struct sock *sk)
 {
 	rwlock_t *lock;
+	unsigned long *bitmask = NULL;
+	unsigned int index = 0;

 	if (sk_unhashed(sk))
 		goto out;
@@ -274,12 +301,16 @@
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
Index: linux-2.6.15-rc5-rt4/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-rt4.orig/mm/page_alloc.c	2005-12-20 18:18:14.000000000 -0500
+++ linux-2.6.15-rc5-rt4/mm/page_alloc.c	2005-12-27 21:12:57.000000000 -0500
@@ -2664,3 +2664,30 @@

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
Index: linux-2.6.15-rc5-rt4/net/ipv4/tcp.c
===================================================================
--- linux-2.6.15-rc5-rt4.orig/net/ipv4/tcp.c	2005-12-14 14:37:00.000000000 -0500
+++ linux-2.6.15-rc5-rt4/net/ipv4/tcp.c	2005-12-27 21:14:16.000000000 -0500
@@ -2039,6 +2039,8 @@
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
 		INIT_HLIST_HEAD(&tcp_hashinfo.ehash[i].chain);
Index: linux-2.6.15-rc5-rt4/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6.15-rc5-rt4.orig/net/ipv4/tcp_ipv4.c	2005-12-20 18:18:14.000000000 -0500
+++ linux-2.6.15-rc5-rt4/net/ipv4/tcp_ipv4.c	2005-12-27 21:12:57.000000000 -0500
@@ -1581,7 +1581,12 @@
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
