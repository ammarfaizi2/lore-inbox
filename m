Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274185AbRI3VPa>; Sun, 30 Sep 2001 17:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274190AbRI3VPW>; Sun, 30 Sep 2001 17:15:22 -0400
Received: from colin.muc.de ([193.149.48.1]:56845 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S274185AbRI3VPL>;
	Sun, 30 Sep 2001 17:15:11 -0400
Message-ID: <20010930231558.01110@colin.muc.de>
Date: Sun, 30 Sep 2001 23:15:58 +0200
From: Andi Kleen <ak@muc.de>
To: dank@kegel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp_v4_get_port() and ephemeral ports
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's tempting to patch tcp_v4_get_port() to check
> sk->rcv_saddr, and if it's nonzero, allow the
> same ephemeral port number to be reused on different interfaces.

Try this patch instead. It doesn't do load balancing for local
aliases, but it'll reuse ports if the remote address is unique. It'll
theoretically do more than the old code, but in practice the rover
variable does a good job at balancing the hash buckets so the cost is
similar (assuming user code doesn't do explicit binds before connect,
which is usually not the case)

-Andi


--- include/net/tcp.h-TCPHASH	Thu Aug 30 19:09:20 2001
+++ include/net/tcp.h	Fri Aug 31 00:07:45 2001
@@ -568,9 +568,7 @@
 							 struct sk_buff *skb,
 							 struct open_request *req,
 							 struct dst_entry *dst);
-	
-	int			(*hash_connecting)	(struct sock *sk);
-
+    
 	int			(*remember_stamp)	(struct sock *sk);
 
 	__u16			net_header_len;
@@ -774,8 +772,9 @@
 					       struct sockaddr *uaddr,
 					       int addr_len);
 
-extern int			tcp_connect(struct sock *sk,
-					    struct sk_buff *skb);
+extern void			tcp_connect_init(struct sock *sk);
+
+extern void			tcp_connect_send(struct sock *sk, struct sk_buff *skb);
 
 extern struct sk_buff *		tcp_make_synack(struct sock *sk,
 						struct dst_entry *dst,
--- net/ipv4/tcp_ipv4.c-TCPHASH	Fri Aug 24 17:13:33 2001
+++ net/ipv4/tcp_ipv4.c	Sun Sep 30 22:40:19 2001
@@ -162,6 +162,37 @@
 	local_bh_enable();
 }
 
+static inline void tcp_bind_hash(struct sock *sk, struct tcp_bind_bucket *tb, unsigned short snum) 
+{ 
+	sk->num = snum; 
+	if ((sk->bind_next = tb->owners) != NULL)
+		tb->owners->bind_pprev = &sk->bind_next;
+	tb->owners = sk;
+	sk->bind_pprev = &tb->owners;
+	sk->prev = (struct sock *) tb;
+} 
+
+static inline int tcp_bind_conflict(struct sock *sk, struct tcp_bind_bucket *tb)
+{ 
+	struct sock *sk2 = tb->owners;
+	int sk_reuse = sk->reuse;
+	
+	for( ; sk2 != NULL; sk2 = sk2->bind_next) {
+		if (sk != sk2 &&
+		    sk->bound_dev_if == sk2->bound_dev_if) {
+			if (!sk_reuse	||
+			    !sk2->reuse	||
+			    sk2->state == TCP_LISTEN) {
+				if (!sk2->rcv_saddr	||
+				    !sk->rcv_saddr	||
+				    (sk2->rcv_saddr == sk->rcv_saddr))
+					break;
+			}
+		}
+	}
+	return (int) sk2; 
+} 
+
 /* Obtain a reference to a local port for the given sock,
  * if snum is zero it means select any available local port.
  */
@@ -216,26 +247,9 @@
 		if (tb->fastreuse != 0 && sk->reuse != 0 && sk->state != TCP_LISTEN) {
 			goto success;
 		} else {
-			struct sock *sk2 = tb->owners;
-			int sk_reuse = sk->reuse;
-
-			for( ; sk2 != NULL; sk2 = sk2->bind_next) {
-				if (sk != sk2 &&
-				    sk->bound_dev_if == sk2->bound_dev_if) {
-					if (!sk_reuse	||
-					    !sk2->reuse	||
-					    sk2->state == TCP_LISTEN) {
-						if (!sk2->rcv_saddr	||
-						    !sk->rcv_saddr	||
-						    (sk2->rcv_saddr == sk->rcv_saddr))
-							break;
-					}
-				}
-			}
-			/* If we found a conflict, fail. */
-			ret = 1;
-			if (sk2 != NULL)
-				goto fail_unlock;
+			ret = 1; 
+			if (tcp_bind_conflict(sk, tb))
+				goto fail_unlock; 
 		}
 	}
 	ret = 1;
@@ -251,17 +265,10 @@
 		   ((sk->reuse == 0) || (sk->state == TCP_LISTEN)))
 		tb->fastreuse = 0;
 success:
-	sk->num = snum;
-	if (sk->prev == NULL) {
-		if ((sk->bind_next = tb->owners) != NULL)
-			tb->owners->bind_pprev = &sk->bind_next;
-		tb->owners = sk;
-		sk->bind_pprev = &tb->owners;
-		sk->prev = (struct sock *) tb;
-	} else {
-		BUG_TRAP(sk->prev == (struct sock *) tb);
-	}
-	ret = 0;
+	if (sk->prev == NULL)
+		tcp_bind_hash(sk, tb, snum); 
+	BUG_TRAP(sk->prev == (struct sock *) tb);
+ 	ret = 0;
 
 fail_unlock:
 	spin_unlock(&head->lock);
@@ -330,13 +337,13 @@
 	}
 }
 
-static __inline__ void __tcp_v4_hash(struct sock *sk)
+static __inline__ void __tcp_v4_hash(struct sock *sk,const int listen_possible)
 {
 	struct sock **skp;
 	rwlock_t *lock;
 
 	BUG_TRAP(sk->pprev==NULL);
-	if(sk->state == TCP_LISTEN) {
+	if(listen_possible && sk->state == TCP_LISTEN) {
 		skp = &tcp_listening_hash[tcp_sk_listen_hashfn(sk)];
 		lock = &tcp_lhash_lock;
 		tcp_listen_wlock();
@@ -351,7 +358,7 @@
 	sk->pprev = skp;
 	sock_prot_inc_use(sk->prot);
 	write_unlock(lock);
-	if (sk->state == TCP_LISTEN)
+	if (listen_possible && sk->state == TCP_LISTEN)
 		wake_up(&tcp_lhash_wait);
 }
 
@@ -359,7 +366,7 @@
 {
 	if (sk->state != TCP_CLOSE) {
 		local_bh_disable();
-		__tcp_v4_hash(sk);
+		__tcp_v4_hash(sk, 1);
 		local_bh_enable();
 	}
 }
@@ -368,6 +375,9 @@
 {
 	rwlock_t *lock;
 
+	if (!sk->pprev) 
+		goto ende; 
+
 	if (sk->state == TCP_LISTEN) {
 		local_bh_disable();
 		tcp_listen_wlock();
@@ -386,6 +396,8 @@
 		sock_prot_dec_use(sk->prot);
 	}
 	write_unlock_bh(lock);
+
+ ende:
 	if (sk->state == TCP_LISTEN)
 		wake_up(&tcp_lhash_wait);
 }
@@ -523,19 +535,20 @@
 					  skb->h.th->source);
 }
 
-static int tcp_v4_check_established(struct sock *sk)
+/* called with local bh disabled */ 
+static int tcp_v4_check_established(struct sock *sk, __u16 lport)
 {
 	u32 daddr = sk->rcv_saddr;
 	u32 saddr = sk->daddr;
 	int dif = sk->bound_dev_if;
 	TCP_V4_ADDR_COOKIE(acookie, saddr, daddr)
-	__u32 ports = TCP_COMBINED_PORTS(sk->dport, sk->num);
-	int hash = tcp_hashfn(daddr, sk->num, saddr, sk->dport);
+	__u32 ports = TCP_COMBINED_PORTS(sk->dport, lport);
+	int hash = tcp_hashfn(daddr, lport, saddr, sk->dport);
 	struct tcp_ehash_bucket *head = &tcp_ehash[hash];
 	struct sock *sk2, **skp;
 	struct tcp_tw_bucket *tw;
 
-	write_lock_bh(&head->lock);
+	write_lock(&head->lock);
 
 	/* Check TIME-WAIT sockets first. */
 	for(skp = &(head + tcp_ehash_size)->chain; (sk2=*skp) != NULL;
@@ -588,15 +601,13 @@
 	sk->pprev = skp;
 	sk->hashent = hash;
 	sock_prot_inc_use(sk->prot);
-	write_unlock_bh(&head->lock);
+	write_unlock(&head->lock);
 
 	if (tw) {
 		/* Silly. Should hash-dance instead... */
-		local_bh_disable();
 		tcp_tw_deschedule(tw);
 		tcp_timewait_kill(tw);
 		NET_INC_STATS_BH(TimeWaitRecycled);
-		local_bh_enable();
 
 		tcp_tw_put(tw);
 	}
@@ -604,34 +615,99 @@
 	return 0;
 
 not_unique:
-	write_unlock_bh(&head->lock);
+	write_unlock(&head->lock);
 	return -EADDRNOTAVAIL;
 }
 
-/* Hash SYN-SENT socket to established hash table after
- * checking that it is unique. Note, that without kernel lock
- * we MUST make these two operations atomically.
- *
- * Optimization: if it is bound and tcp_bind_bucket has the only
- * owner (us), we need not to scan established bucket.
- */
+int fast_checkestab_failed;
 
-int tcp_v4_hash_connecting(struct sock *sk)
+/* 
+ * Bind a port for a connect operation and hash it.
+ */ 
+static int tcp_v4_hash_connect(struct sock *sk, struct sockaddr_in *dst)
 {
 	unsigned short snum = sk->num;
-	struct tcp_bind_hashbucket *head = &tcp_bhash[tcp_bhashfn(snum)];
-	struct tcp_bind_bucket *tb = (struct tcp_bind_bucket *)sk->prev;
+	struct tcp_bind_hashbucket *head;
+	struct tcp_bind_bucket *tb;
+
+	if (snum == 0) { 
+		int rover;
+		int low = sysctl_local_port_range[0];
+		int high = sysctl_local_port_range[1];
+		int remaining = (high - low) + 1;
+		
+		local_bh_disable(); 
+		spin_lock(&tcp_portalloc_lock); 
+		rover = tcp_port_rover;
+		
+		do {	
+			rover++;
+			if ((rover < low) || (rover > high))
+				rover = low;
+			head = &tcp_bhash[tcp_bhashfn(rover)];
+			spin_lock(&head->lock);		
+				
+			/* Does not bother with rcv_saddr checks,
+			 * because the established check is already
+			 * unique enough.  
+			 */
+			for (tb = head->chain; tb; tb = tb->next) {
+				if (tb->port == rover) { 
+					if (!tb->owners) 
+						goto ok;
+					if (!tb->fastreuse)
+						goto next_port;
+					if (!tcp_v4_check_established(sk,rover))
+						goto ok; 
+					fast_checkestab_failed++; 	
+					goto next_port; 
+				} 	
+			}		
+
+			tb = tcp_bucket_create(head, rover);
+			if (!tb) { 
+				spin_unlock(&head->lock); 
+				break;
+			}
+			goto ok; 
+
+		next_port:
+			spin_unlock(&head->lock);
+		} while (--remaining > 0);
+		tcp_port_rover = rover; 		      
 
+		spin_unlock(&tcp_portalloc_lock); 
+		local_bh_enable(); 
+
+		return -EADDRNOTAVAIL;
+
+	ok:
+		/* All locks still held and bhs disabled */ 
+		tcp_port_rover = rover; 			
+		tcp_bind_hash(sk, tb, rover);  
+		sk->sport = htons(rover); 
+		spin_unlock(&tcp_portalloc_lock); 
+		__tcp_v4_hash(sk, 0); 
+		/* fastreuse state of tb is never changed in connect */ 
+		spin_unlock(&head->lock); 
+		local_bh_enable(); 
+		return 0; 			
+	}
+		
+	head  = &tcp_bhash[tcp_bhashfn(snum)];
+	tb  = (struct tcp_bind_bucket *)sk->prev;
 	spin_lock_bh(&head->lock);
 	if (tb->owners == sk && sk->bind_next == NULL) {
-		__tcp_v4_hash(sk);
+		__tcp_v4_hash(sk, 0);
 		spin_unlock_bh(&head->lock);
 		return 0;
 	} else {
-		spin_unlock_bh(&head->lock);
-
+		int ret;
+		spin_unlock(&head->lock);
 		/* No definite answer... Walk to established hash table */
-		return tcp_v4_check_established(sk);
+		ret = tcp_v4_check_established(sk, snum);
+		local_bh_enable(); 
+		return ret;
 	}
 }
 
@@ -640,7 +716,6 @@
 {
 	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
 	struct sockaddr_in *usin = (struct sockaddr_in *) uaddr;
-	struct sk_buff *buff;
 	struct rtable *rt;
 	u32 daddr, nexthop;
 	int tmp;
@@ -675,12 +750,6 @@
 	if (!sk->protinfo.af_inet.opt || !sk->protinfo.af_inet.opt->srr)
 		daddr = rt->rt_dst;
 
-	err = -ENOBUFS;
-	buff = alloc_skb(MAX_TCP_HEADER + 15, GFP_KERNEL);
-
-	if (buff == NULL)
-		goto failure;
-
 	if (!sk->saddr)
 		sk->saddr = rt->rt_src;
 	sk->rcv_saddr = sk->saddr;
@@ -722,11 +791,27 @@
 
 	tp->mss_clamp = 536;
 
-	err = tcp_connect(sk, buff);
-	if (err == 0)
-		return 0;
+	/* Initialise common fields */ 
+	tcp_connect_init(sk);
+
+	/* Socket identity change complete, no longer
+	 * in TCP_CLOSE, so enter ourselves into the
+	 * hash tables.
+	 */
+	tcp_set_state(sk,TCP_SYN_SENT);
+	err = tcp_v4_hash_connect(sk, usin); 
+	if (!err) { 
+		struct sk_buff *buff; 
+
+		err = -ENOBUFS;
+		buff = alloc_skb(MAX_TCP_HEADER + 15, GFP_KERNEL);
+		if (buff != NULL) { 
+			tcp_connect_send(sk, buff); 
+			return 0;
+		} 
+	} 
 
-failure:
+	tcp_set_state(sk, TCP_CLOSE); 
 	__sk_dst_reset(sk);
 	sk->route_caps = 0;
 	sk->dport = 0;
@@ -1450,7 +1535,7 @@
 	newtp->advmss = dst->advmss;
 	tcp_initialize_rcv_mss(newsk);
 
-	__tcp_v4_hash(newsk);
+	__tcp_v4_hash(newsk, 0);
 	__tcp_inherit_port(sk, newsk);
 
 	return newsk;
@@ -1868,7 +1953,6 @@
 	tcp_v4_rebuild_header,
 	tcp_v4_conn_request,
 	tcp_v4_syn_recv_sock,
-	tcp_v4_hash_connecting,
 	tcp_v4_remember_stamp,
 	sizeof(struct iphdr),
 
--- net/ipv4/tcp_output.c-TCPHASH	Fri Aug 24 08:36:20 2001
+++ net/ipv4/tcp_output.c	Thu Aug 30 22:26:18 2001
@@ -1157,14 +1157,15 @@
 	return skb;
 }
 
-int tcp_connect(struct sock *sk, struct sk_buff *buff)
+/* 
+ * Do all connect socket setups that can be done AF independent.
+ * Could be inlined.
+ */ 
+void tcp_connect_init(struct sock *sk)
 {
 	struct dst_entry *dst = __sk_dst_get(sk);
 	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
 
-	/* Reserve space for headers. */
-	skb_reserve(buff, MAX_TCP_HEADER);
-
 	/* We'll fix this up when we get a response from the other end.
 	 * See tcp_input.c:tcp_rcv_state_process case TCP_SYN_SENT.
 	 */
@@ -1191,14 +1192,6 @@
 
 	tp->rcv_ssthresh = tp->rcv_wnd;
 
-	/* Socket identity change complete, no longer
-	 * in TCP_CLOSE, so enter ourselves into the
-	 * hash tables.
-	 */
-	tcp_set_state(sk,TCP_SYN_SENT);
-	if (tp->af_specific->hash_connecting(sk))
-		goto err_out;
-
 	sk->err = 0;
 	sk->done = 0;
 	tp->snd_wnd = 0;
@@ -1212,9 +1205,20 @@
 	tp->rto = TCP_TIMEOUT_INIT;
 	tp->retransmits = 0;
 	tcp_clear_retrans(tp);
+}
+
+/*
+ * Build a SYN and send it off.
+ */ 
+void tcp_connect_send(struct sock *sk, struct sk_buff *buff)
+{ 
+	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
+
+	/* Reserve space for headers. */
+	skb_reserve(buff, MAX_TCP_HEADER);
 
 	TCP_SKB_CB(buff)->flags = TCPCB_FLAG_SYN;
-	TCP_ECN_send_syn(tp, buff);
+	TCP_ECN_send_syn(tp, buff);
 	TCP_SKB_CB(buff)->sacked = 0;
 	buff->csum = 0;
 	TCP_SKB_CB(buff)->seq = tp->write_seq++;
@@ -1233,12 +1237,6 @@
 
 	/* Timer for repeating the SYN until an answer. */
 	tcp_reset_xmit_timer(sk, TCP_TIME_RETRANS, tp->rto);
-	return 0;
-
-err_out:
-	tcp_set_state(sk,TCP_CLOSE);
-	kfree_skb(buff);
-	return -EADDRNOTAVAIL;
 }
 
 /* Send out a delayed ack, the caller does the policy checking
--- net/ipv6/tcp_ipv6.c-TCPHASH	Wed Jul  4 17:21:33 2001
+++ net/ipv6/tcp_ipv6.c	Thu Aug 30 22:26:18 2001
@@ -481,11 +481,21 @@
 	return -EADDRNOTAVAIL;
 }
 
-static int tcp_v6_hash_connecting(struct sock *sk)
+static int tcp_v6_hash_connect(struct sock *sk, struct sockaddr_in6 *dst)
 {
-	unsigned short snum = sk->num;
-	struct tcp_bind_hashbucket *head = &tcp_bhash[tcp_bhashfn(snum)];
-	struct tcp_bind_bucket *tb = head->chain;
+	struct tcp_bind_hashbucket *head;
+	struct tcp_bind_bucket *tb;
+
+	/* XXX */ 
+	if (sk->num == 0) { 
+		int err = tcp_v6_get_port(sk, sk->num);
+		if (err)
+			return err;
+		sk->sport = htons(sk->num); 	
+	} 
+		
+	head = &tcp_bhash[tcp_bhashfn(sk->num)];
+	tb = head->chain;
 
 	spin_lock_bh(&head->lock);
 
@@ -515,7 +525,6 @@
 	struct in6_addr saddr_buf;
 	struct flowi fl;
 	struct dst_entry *dst;
-	struct sk_buff *buff;
 	int addr_type;
 	int err;
 
@@ -655,11 +664,6 @@
 		tp->ext_header_len = np->opt->opt_flen+np->opt->opt_nflen;
 	tp->mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) - sizeof(struct ipv6hdr);
 
-	err = -ENOBUFS;
-	buff = alloc_skb(MAX_TCP_HEADER + 15, GFP_KERNEL);
-
-	if (buff == NULL)
-		goto failure;
 
 	sk->dport = usin->sin6_port;
 
@@ -671,12 +675,23 @@
 		tp->write_seq = secure_tcpv6_sequence_number(np->saddr.s6_addr32,
 							     np->daddr.s6_addr32,
 							     sk->sport, sk->dport);
+	tcp_connect_init(sk);
+
+	tcp_set_state(sk, TCP_SYN_SENT); 
+	err = tcp_v6_hash_connect(sk, usin); 
+	if (!err) {
+		struct sk_buff *buff;
+		err = -ENOBUFS;
+		buff = alloc_skb(MAX_TCP_HEADER + 15, GFP_KERNEL);
+		if (buff != NULL) { 
+			tcp_connect_send(sk, buff); 
+			return 0;
+		} 
+	}
 
-	err = tcp_connect(sk, buff);
-	if (err == 0)
-		return 0;
 
-failure:
+	tcp_set_state(sk, TCP_CLOSE); 
+ failure:
 	__sk_dst_reset(sk);
 	sk->dport = 0;
 	sk->route_caps = 0;
@@ -1756,7 +1771,6 @@
 	tcp_v6_rebuild_header,
 	tcp_v6_conn_request,
 	tcp_v6_syn_recv_sock,
-	tcp_v6_hash_connecting,
 	tcp_v6_remember_stamp,
 	sizeof(struct ipv6hdr),
 
@@ -1776,7 +1790,6 @@
 	tcp_v4_rebuild_header,
 	tcp_v6_conn_request,
 	tcp_v6_syn_recv_sock,
-	tcp_v4_hash_connecting,
 	tcp_v4_remember_stamp,
 	sizeof(struct iphdr),
 
