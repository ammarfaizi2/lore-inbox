Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWCHCAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWCHCAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWCHCAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:00:38 -0500
Received: from ns1.siteground.net ([207.218.208.2]:35499 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964877AbWCHCAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:00:37 -0500
Date: Tue, 7 Mar 2006 18:01:18 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: [patch 2/4] net: percpufy frequently used vars -- struct proto.memory_allocated
Message-ID: <20060308020118.GC9062@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308015808.GA9062@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change struct proto->memory_allocated to a batching per-CPU counter 
(percpu_counter) from an atomic_t.  A batching counter is better than a 
plain per-CPU counter as this field is read often.

Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc5mm3/include/net/sock.h
===================================================================
--- linux-2.6.16-rc5mm3.orig/include/net/sock.h	2006-03-07 15:07:43.000000000 -0800
+++ linux-2.6.16-rc5mm3/include/net/sock.h	2006-03-07 15:11:48.000000000 -0800
@@ -48,6 +48,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/security.h>
+#include <linux/percpu_counter.h>
 
 #include <linux/filter.h>
 
@@ -541,8 +542,9 @@ struct proto {
 
 	/* Memory pressure */
 	void			(*enter_memory_pressure)(void);
-	atomic_t		*memory_allocated;	/* Current allocated memory. */
+	struct percpu_counter	*memory_allocated;	/* Current allocated memory. */
 	atomic_t		*sockets_allocated;	/* Current number of sockets. */
+
 	/*
 	 * Pressure flag: try to collapse.
 	 * Technical note: it is used by multiple contexts non atomically.
Index: linux-2.6.16-rc5mm3/include/net/tcp.h
===================================================================
--- linux-2.6.16-rc5mm3.orig/include/net/tcp.h	2006-03-07 15:08:00.000000000 -0800
+++ linux-2.6.16-rc5mm3/include/net/tcp.h	2006-03-07 15:11:48.000000000 -0800
@@ -225,7 +225,7 @@ extern int sysctl_tcp_abc;
 extern int sysctl_tcp_mtu_probing;
 extern int sysctl_tcp_base_mss;
 
-extern atomic_t tcp_memory_allocated;
+extern struct percpu_counter tcp_memory_allocated;
 extern atomic_t tcp_sockets_allocated;
 extern int tcp_memory_pressure;
 
Index: linux-2.6.16-rc5mm3/net/core/sock.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/core/sock.c	2006-03-07 15:07:43.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/core/sock.c	2006-03-07 15:11:48.000000000 -0800
@@ -1616,12 +1616,13 @@ static char proto_method_implemented(con
 
 static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 {
-	seq_printf(seq, "%-9s %4u %6d  %6d   %-3s %6u   %-3s  %-10s "
+	seq_printf(seq, "%-9s %4u %6d  %6lu   %-3s %6u   %-3s  %-10s "
 			"%2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c\n",
 		   proto->name,
 		   proto->obj_size,
 		   proto->sockets_allocated != NULL ? atomic_read(proto->sockets_allocated) : -1,
-		   proto->memory_allocated != NULL ? atomic_read(proto->memory_allocated) : -1,
+		   proto->memory_allocated != NULL ?
+				percpu_counter_read_positive(proto->memory_allocated) : -1,
 		   proto->memory_pressure != NULL ? *proto->memory_pressure ? "yes" : "no" : "NI",
 		   proto->max_header,
 		   proto->slab == NULL ? "no" : "yes",
Index: linux-2.6.16-rc5mm3/net/core/stream.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/core/stream.c	2006-03-07 15:07:43.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/core/stream.c	2006-03-07 15:11:48.000000000 -0800
@@ -196,11 +196,11 @@ EXPORT_SYMBOL(sk_stream_error);
 void __sk_stream_mem_reclaim(struct sock *sk)
 {
 	if (sk->sk_forward_alloc >= SK_STREAM_MEM_QUANTUM) {
-		atomic_sub(sk->sk_forward_alloc / SK_STREAM_MEM_QUANTUM,
-			   sk->sk_prot->memory_allocated);
+		percpu_counter_mod_bh(sk->sk_prot->memory_allocated,
+				-(sk->sk_forward_alloc / SK_STREAM_MEM_QUANTUM));
 		sk->sk_forward_alloc &= SK_STREAM_MEM_QUANTUM - 1;
 		if (*sk->sk_prot->memory_pressure &&
-		    (atomic_read(sk->sk_prot->memory_allocated) <
+		    (percpu_counter_read(sk->sk_prot->memory_allocated) <
 		     sk->sk_prot->sysctl_mem[0]))
 			*sk->sk_prot->memory_pressure = 0;
 	}
@@ -213,23 +213,26 @@ int sk_stream_mem_schedule(struct sock *
 	int amt = sk_stream_pages(size);
 
 	sk->sk_forward_alloc += amt * SK_STREAM_MEM_QUANTUM;
-	atomic_add(amt, sk->sk_prot->memory_allocated);
+	percpu_counter_mod_bh(sk->sk_prot->memory_allocated, amt);
 
 	/* Under limit. */
-	if (atomic_read(sk->sk_prot->memory_allocated) < sk->sk_prot->sysctl_mem[0]) {
+	if (percpu_counter_read(sk->sk_prot->memory_allocated) <
+			sk->sk_prot->sysctl_mem[0]) {
 		if (*sk->sk_prot->memory_pressure)
 			*sk->sk_prot->memory_pressure = 0;
 		return 1;
 	}
 
 	/* Over hard limit. */
-	if (atomic_read(sk->sk_prot->memory_allocated) > sk->sk_prot->sysctl_mem[2]) {
+	if (percpu_counter_read(sk->sk_prot->memory_allocated) >
+			sk->sk_prot->sysctl_mem[2]) {
 		sk->sk_prot->enter_memory_pressure();
 		goto suppress_allocation;
 	}
 
 	/* Under pressure. */
-	if (atomic_read(sk->sk_prot->memory_allocated) > sk->sk_prot->sysctl_mem[1])
+	if (percpu_counter_read(sk->sk_prot->memory_allocated) >
+			sk->sk_prot->sysctl_mem[1])
 		sk->sk_prot->enter_memory_pressure();
 
 	if (kind) {
@@ -259,7 +262,7 @@ suppress_allocation:
 
 	/* Alas. Undo changes. */
 	sk->sk_forward_alloc -= amt * SK_STREAM_MEM_QUANTUM;
-	atomic_sub(amt, sk->sk_prot->memory_allocated);
+	percpu_counter_mod_bh(sk->sk_prot->memory_allocated, -amt);
 	return 0;
 }
 
Index: linux-2.6.16-rc5mm3/net/decnet/af_decnet.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/decnet/af_decnet.c	2006-03-07 15:07:43.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/decnet/af_decnet.c	2006-03-07 15:09:22.000000000 -0800
@@ -154,7 +154,7 @@ static const struct proto_ops dn_proto_o
 static DEFINE_RWLOCK(dn_hash_lock);
 static struct hlist_head dn_sk_hash[DN_SK_HASH_SIZE];
 static struct hlist_head dn_wild_sk;
-static atomic_t decnet_memory_allocated;
+static struct percpu_counter decnet_memory_allocated;
 
 static int __dn_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen, int flags);
 static int __dn_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen, int flags);
@@ -2383,7 +2383,8 @@ static int __init decnet_init(void)
 	rc = proto_register(&dn_proto, 1);
 	if (rc != 0)
 		goto out;
-
+	
+	percpu_counter_init(&decnet_memory_allocated);
 	dn_neigh_init();
 	dn_dev_init();
 	dn_route_init();
@@ -2424,6 +2425,7 @@ static void __exit decnet_exit(void)
 	proc_net_remove("decnet");
 
 	proto_unregister(&dn_proto);
+	percpu_counter_destroy(&decnet_memory_allocated);
 }
 module_exit(decnet_exit);
 #endif
Index: linux-2.6.16-rc5mm3/net/ipv4/proc.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/ipv4/proc.c	2006-03-07 15:07:44.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/ipv4/proc.c	2006-03-07 15:11:48.000000000 -0800
@@ -61,10 +61,10 @@ static int fold_prot_inuse(struct proto 
 static int sockstat_seq_show(struct seq_file *seq, void *v)
 {
 	socket_seq_show(seq);
-	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %d\n",
+	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %lu\n",
 		   fold_prot_inuse(&tcp_prot), atomic_read(&tcp_orphan_count),
 		   tcp_death_row.tw_count, atomic_read(&tcp_sockets_allocated),
-		   atomic_read(&tcp_memory_allocated));
+		   percpu_counter_read_positive(&tcp_memory_allocated));
 	seq_printf(seq, "UDP: inuse %d\n", fold_prot_inuse(&udp_prot));
 	seq_printf(seq, "RAW: inuse %d\n", fold_prot_inuse(&raw_prot));
 	seq_printf(seq,  "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
Index: linux-2.6.16-rc5mm3/net/ipv4/tcp.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/ipv4/tcp.c	2006-03-07 15:07:44.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/ipv4/tcp.c	2006-03-07 15:11:48.000000000 -0800
@@ -283,7 +283,7 @@ EXPORT_SYMBOL(sysctl_tcp_mem);
 EXPORT_SYMBOL(sysctl_tcp_rmem);
 EXPORT_SYMBOL(sysctl_tcp_wmem);
 
-atomic_t tcp_memory_allocated;	/* Current allocated memory. */
+struct percpu_counter tcp_memory_allocated;	/* Current allocated memory. */
 atomic_t tcp_sockets_allocated;	/* Current number of TCP sockets. */
 
 EXPORT_SYMBOL(tcp_memory_allocated);
@@ -1593,7 +1593,7 @@ adjudge_to_death:
 		sk_stream_mem_reclaim(sk);
 		if (atomic_read(sk->sk_prot->orphan_count) > sysctl_tcp_max_orphans ||
 		    (sk->sk_wmem_queued > SOCK_MIN_SNDBUF &&
-		     atomic_read(&tcp_memory_allocated) > sysctl_tcp_mem[2])) {
+		     percpu_counter_read(&tcp_memory_allocated) > sysctl_tcp_mem[2])) {
 			if (net_ratelimit())
 				printk(KERN_INFO "TCP: too many of orphaned "
 				       "sockets\n");
@@ -2127,6 +2127,8 @@ void __init tcp_init(void)
 	       "(established %d bind %d)\n",
 	       tcp_hashinfo.ehash_size << 1, tcp_hashinfo.bhash_size);
 
+	percpu_counter_init(&tcp_memory_allocated);
+
 	tcp_register_congestion_control(&tcp_reno);
 }
 
Index: linux-2.6.16-rc5mm3/net/ipv4/tcp_input.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/ipv4/tcp_input.c	2006-03-07 15:08:01.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/ipv4/tcp_input.c	2006-03-07 15:09:22.000000000 -0800
@@ -333,7 +333,7 @@ static void tcp_clamp_window(struct sock
 	if (sk->sk_rcvbuf < sysctl_tcp_rmem[2] &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
 	    !tcp_memory_pressure &&
-	    atomic_read(&tcp_memory_allocated) < sysctl_tcp_mem[0]) {
+	    percpu_counter_read(&tcp_memory_allocated) < sysctl_tcp_mem[0]) {
 		sk->sk_rcvbuf = min(atomic_read(&sk->sk_rmem_alloc),
 				    sysctl_tcp_rmem[2]);
 	}
@@ -3555,7 +3555,7 @@ static int tcp_should_expand_sndbuf(stru
 		return 0;
 
 	/* If we are under soft global TCP memory pressure, do not expand.  */
-	if (atomic_read(&tcp_memory_allocated) >= sysctl_tcp_mem[0])
+	if (percpu_counter_read(&tcp_memory_allocated) >= sysctl_tcp_mem[0])
 		return 0;
 
 	/* If we filled the congestion window, do not expand.  */
Index: linux-2.6.16-rc5mm3/net/ipv4/tcp_timer.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/ipv4/tcp_timer.c	2006-03-07 15:08:01.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/ipv4/tcp_timer.c	2006-03-07 15:09:22.000000000 -0800
@@ -80,7 +80,7 @@ static int tcp_out_of_resources(struct s
 
 	if (orphans >= sysctl_tcp_max_orphans ||
 	    (sk->sk_wmem_queued > SOCK_MIN_SNDBUF &&
-	     atomic_read(&tcp_memory_allocated) > sysctl_tcp_mem[2])) {
+	     percpu_counter_read(&tcp_memory_allocated) > sysctl_tcp_mem[2])) {
 		if (net_ratelimit())
 			printk(KERN_INFO "Out of socket memory\n");
 
