Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUBKG2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUBKG2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:28:41 -0500
Received: from dictum-ext.geekmail.cc ([204.239.179.245]:13228 "EHLO
	mailer01.geekmail.cc") by vger.kernel.org with ESMTP
	id S263539AbUBKG2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:28:34 -0500
Message-ID: <4029CB7B.3090409@swapped.cc>
Date: Tue, 10 Feb 2004 22:28:11 -0800
From: Alex Pankratov <ap@swapped.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: acme@conectiva.com.br, ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6] [1/2] hlist: replace explicit checks of hlist fields
 w/ func calls
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo, Andi,

I have a set of two patches that removes if() branching from
hlist_xxx() functions.

First patch replaces explicit manipulation and checks of hlist_head
and hlist_node fields with hlist_xxx() function calls. The goal
here is to hide the details of how the hlist is terminated from
the external code.

Second patch removes if's from hlist_xxx() functions. The idea
is to terminate the list not with 0, but with a pointer at a
special 'null' item. Luckily a single 'null' can be shared
between all hlists _without_ any synchronization, because its
'next' and 'pprev' fields are never read. In fact, 'next' is
not accessed at all, and 'pprev' is used only for writing.

--------------

diff -uprX dontdiff linux-2.6.2/include/linux/list.h 
linux-2.6.2.hlist/include/linux/list.h
--- linux-2.6.2/include/linux/list.h	2004-02-03 19:43:56.000000000 -0800
+++ linux-2.6.2.hlist/include/linux/list.h	2004-02-10 12:35:57.000000000 
-0800
@@ -439,6 +439,16 @@ struct hlist_node {
  #define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
  #define INIT_HLIST_NODE(ptr) ((ptr)->next = NULL, (ptr)->pprev = NULL)

+static __inline__ void hlist_node_init(struct hlist_node *h)
+{
+	h->pprev = NULL;
+}
+
+static __inline__ int hlist_last(const struct hlist_node *h)
+{
+	return !h->next;
+}
+
  static __inline__ int hlist_unhashed(const struct hlist_node *h)
  {
  	return !h->pprev;
@@ -531,6 +541,8 @@ static __inline__ void hlist_add_after(s
  }

  #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
+#define hlist_entry_safe(ptr, type, member) \
+	((ptr) == 0 ? NULL : container_of(ptr,type,member))

  /* Cannot easily do prefetch unfortunately */
  #define hlist_for_each(pos, head) \
diff -uprX dontdiff linux-2.6.2/include/net/sock.h 
linux-2.6.2.hlist/include/net/sock.h
--- linux-2.6.2/include/net/sock.h	2004-02-03 19:44:05.000000000 -0800
+++ linux-2.6.2.hlist/include/net/sock.h	2004-02-10 12:38:24.000000000 -0800
@@ -266,13 +266,12 @@ static inline struct sock *__sk_head(str

  static inline struct sock *sk_head(struct hlist_head *head)
  {
-	return hlist_empty(head) ? NULL : __sk_head(head);
+	return hlist_entry_safe(head->first, struct sock, sk_node);
  }

  static inline struct sock *sk_next(struct sock *sk)
  {
-	return sk->sk_node.next ?
-		hlist_entry(sk->sk_node.next, struct sock, sk_node) : NULL;
+	return hlist_entry_safe(sk->sk_node.next, struct sock, sk_node);
  }

  static inline int sk_unhashed(struct sock *sk)
@@ -282,12 +281,12 @@ static inline int sk_unhashed(struct soc

  static inline int sk_hashed(struct sock *sk)
  {
-	return sk->sk_node.pprev != NULL;
+	return ! hlist_unhashed(&sk->sk_node);
  }

  static __inline__ void sk_node_init(struct hlist_node *node)
  {
-	node->pprev = NULL;
+	hlist_node_init(node);
  }

  static __inline__ void __sk_del_node(struct sock *sk)
diff -uprX dontdiff linux-2.6.2/include/net/tcp.h 
linux-2.6.2.hlist/include/net/tcp.h
--- linux-2.6.2/include/net/tcp.h	2004-02-03 19:43:11.000000000 -0800
+++ linux-2.6.2.hlist/include/net/tcp.h	2004-02-10 12:47:32.000000000 -0800
@@ -102,7 +102,8 @@ static inline struct tcp_bind_bucket *__

  static inline struct tcp_bind_bucket *tb_head(struct 
tcp_bind_hashbucket *head)
  {
-	return hlist_empty(&head->chain) ? NULL : __tb_head(head);
+	return hlist_entry_safe(head->chain.first,
+				struct tcp_bind_bucket, node);
  }

  extern struct tcp_hashinfo {
@@ -237,12 +238,12 @@ static __inline__ void tw_add_bind_node(

  static inline int tw_dead_hashed(struct tcp_tw_bucket *tw)
  {
-	return tw->tw_death_node.pprev != NULL;
+	return ! hlist_unhashed(&tw->tw_death_node);
  }

  static __inline__ void tw_dead_node_init(struct tcp_tw_bucket *tw)
  {
-	tw->tw_death_node.pprev = NULL;
+	hlist_node_init(&tw->tw_death_node);
  }

  static __inline__ void __tw_del_dead_node(struct tcp_tw_bucket *tw)
diff -uprX dontdiff linux-2.6.2/net/ax25/af_ax25.c 
linux-2.6.2.hlist/net/ax25/af_ax25.c
--- linux-2.6.2/net/ax25/af_ax25.c	2004-02-03 19:44:39.000000000 -0800
+++ linux-2.6.2.hlist/net/ax25/af_ax25.c	2004-02-10 12:48:28.000000000 -0800
@@ -1860,8 +1860,8 @@ static void *ax25_info_next(struct seq_f
  {
  	++*pos;

-	return hlist_entry( ((struct ax25_cb *)v)->ax25_node.next,
-			    struct ax25_cb, ax25_node);
+	return hlist_entry_safe(((struct ax25_cb *)v)->ax25_node.next,
+				struct ax25_cb, ax25_node);
  }
  	
  static void ax25_info_stop(struct seq_file *seq, void *v)
diff -uprX dontdiff linux-2.6.2/net/ipv4/tcp_ipv4.c 
linux-2.6.2.hlist/net/ipv4/tcp_ipv4.c
--- linux-2.6.2/net/ipv4/tcp_ipv4.c	2004-02-03 19:43:41.000000000 -0800
+++ linux-2.6.2.hlist/net/ipv4/tcp_ipv4.c	2004-02-10 12:50:27.000000000 
-0800
@@ -459,7 +459,7 @@ inline struct sock *tcp_v4_lookup_listen
  	if (!hlist_empty(head)) {
  		struct inet_opt *inet = inet_sk((sk = __sk_head(head)));

-		if (inet->num == hnum && !sk->sk_node.next &&
+		if (inet->num == hnum && hlist_last(&sk->sk_node) &&
  		    (!inet->rcv_saddr || inet->rcv_saddr == daddr) &&
  		    (sk->sk_family == PF_INET || !ipv6_only_sock(sk)) &&
  		    !sk->sk_bound_dev_if)
@@ -736,7 +736,7 @@ ok:
   	head  = &tcp_bhash[tcp_bhashfn(snum)];
   	tb  = tcp_sk(sk)->bind_hash;
  	spin_lock_bh(&head->lock);
-	if (sk_head(&tb->owners) == sk && !sk->sk_bind_node.next) {
+	if (sk_head(&tb->owners) == sk && hlist_last(&sk->sk_bind_node)) {
  		__tcp_v4_hash(sk, 0);
  		spin_unlock_bh(&head->lock);
  		return 0;
@@ -2124,14 +2124,12 @@ static int tcp_v4_destroy_sock(struct so

  static inline struct tcp_tw_bucket *tw_head(struct hlist_head *head)
  {
-	return hlist_empty(head) ? NULL :
-		list_entry(head->first, struct tcp_tw_bucket, tw_node);
+	return hlist_entry_safe(head->first, struct tcp_tw_bucket, tw_node);
  }

  static inline struct tcp_tw_bucket *tw_next(struct tcp_tw_bucket *tw)
  {
-	return tw->tw_node.next ?
-		hlist_entry(tw->tw_node.next, typeof(*tw), tw_node) : NULL;
+	return hlist_entry_safe(tw->tw_node.next, typeof(*tw), tw_node);
  }

  static void *listening_get_first(struct seq_file *seq)
diff -uprX dontdiff linux-2.6.2/net/ipv6/tcp_ipv6.c 
linux-2.6.2.hlist/net/ipv6/tcp_ipv6.c
--- linux-2.6.2/net/ipv6/tcp_ipv6.c	2004-02-03 19:43:56.000000000 -0800
+++ linux-2.6.2.hlist/net/ipv6/tcp_ipv6.c	2004-02-09 21:27:23.000000000 
-0800
@@ -524,7 +524,7 @@ static int tcp_v6_hash_connect(struct so

  	spin_lock_bh(&head->lock);

-	if (sk_head(&tb->owners) == sk && !sk->sk_bind_node.next) {
+	if (sk_head(&tb->owners) == sk && hlist_last(&sk->sk_bind_node)) {
  		__tcp_v6_hash(sk);
  		spin_unlock_bh(&head->lock);
  		return 0;
diff -uprX dontdiff linux-2.6.2/net/netrom/nr_route.c 
linux-2.6.2.hlist/net/netrom/nr_route.c
--- linux-2.6.2/net/netrom/nr_route.c	2004-02-03 19:45:02.000000000 -0800
+++ linux-2.6.2.hlist/net/netrom/nr_route.c	2004-02-10 
12:53:10.000000000 -0800
@@ -870,7 +870,7 @@ static void *nr_node_next(struct seq_fil
  		? nr_node_list.first
  		: ((struct nr_node *)v)->node_node.next;

-	return hlist_entry(node, struct nr_node, node_node);
+	return hlist_entry_safe(node, struct nr_node, node_node);
  }

  static void nr_node_stop(struct seq_file *seq, void *v)
@@ -953,7 +953,7 @@ static void *nr_neigh_next(struct seq_fi
  		? nr_neigh_list.first
  		: ((struct nr_neigh *)v)->neigh_node.next;

-	return hlist_entry(node, struct nr_neigh, neigh_node);
+	return hlist_entry_safe(node, struct nr_neigh, neigh_node);
  }

  static void nr_neigh_stop(struct seq_file *seq, void *v)



