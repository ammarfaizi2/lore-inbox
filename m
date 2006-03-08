Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWCHUzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWCHUzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCHUzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:55:43 -0500
Received: from ns1.siteground.net ([207.218.208.2]:21421 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932282AbWCHUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:55:41 -0500
Date: Wed, 8 Mar 2006 12:56:20 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch 3/4] net: percpufy frequently used vars -- proto.sockets_allocated
Message-ID: <20060308205620.GC4493@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain> <20060308020227.GD9062@localhost.localdomain> <20060307181602.77030e2a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307181602.77030e2a.akpm@osdl.org>
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

On Tue, Mar 07, 2006 at 06:16:02PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >   
> >  +static inline int read_sockets_allocated(struct proto *prot)
> >  +{
> >  +	int total = 0;
> >  +	int cpu;
> >  +	for_each_cpu(cpu)
> >  +		total += *per_cpu_ptr(prot->sockets_allocated, cpu);
> >  +	return total;
> >  +}
> 
> This is likely too big to be inlined, plus sock.h doesn't include enough
> headers to reliably compile this code.
> 
> >  +static inline void mod_sockets_allocated(int *sockets_allocated, int count)
> >  +{
> >  +	(*per_cpu_ptr(sockets_allocated, get_cpu())) += count;
> >  +	put_cpu();
> >  +}
> >  +
> 
> Ditto.

OK, here is a revised patch.


Change the atomic_t sockets_allocated member of struct proto to a 
per-cpu counter.

Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc5mm3/include/net/sock.h
===================================================================
--- linux-2.6.16-rc5mm3.orig/include/net/sock.h	2006-03-08 11:03:19.000000000 -0800
+++ linux-2.6.16-rc5mm3/include/net/sock.h	2006-03-08 12:06:52.000000000 -0800
@@ -543,7 +543,7 @@ struct proto {
 	/* Memory pressure */
 	void			(*enter_memory_pressure)(void);
 	struct percpu_counter	*memory_allocated;	/* Current allocated memory. */
-	atomic_t		*sockets_allocated;	/* Current number of sockets. */
+	int                     *sockets_allocated;     /* Current number of sockets (percpu counter). */
 
 	/*
 	 * Pressure flag: try to collapse.
@@ -579,6 +579,12 @@ struct proto {
 	} stats[NR_CPUS];
 };
 
+extern int read_sockets_allocated(struct proto *prot);
+extern void mod_sockets_allocated(int *sockets_allocated, int count);
+
+#define inc_sockets_allocated(c) mod_sockets_allocated(c, 1)
+#define dec_sockets_allocated(c) mod_sockets_allocated(c, -1)
+
 extern int proto_register(struct proto *prot, int alloc_slab);
 extern void proto_unregister(struct proto *prot);
 
Index: linux-2.6.16-rc5mm3/include/net/tcp.h
===================================================================
--- linux-2.6.16-rc5mm3.orig/include/net/tcp.h	2006-03-08 11:03:19.000000000 -0800
+++ linux-2.6.16-rc5mm3/include/net/tcp.h	2006-03-08 11:39:40.000000000 -0800
@@ -226,7 +226,7 @@ extern int sysctl_tcp_mtu_probing;
 extern int sysctl_tcp_base_mss;
 
 extern struct percpu_counter tcp_memory_allocated;
-extern atomic_t tcp_sockets_allocated;
+extern int *tcp_sockets_allocated;
 extern int tcp_memory_pressure;
 
 /*
Index: linux-2.6.16-rc5mm3/net/core/sock.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/core/sock.c	2006-03-08 11:03:19.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/core/sock.c	2006-03-08 12:09:19.000000000 -0800
@@ -771,7 +771,7 @@ struct sock *sk_clone(const struct sock 
 		newsk->sk_sleep	 = NULL;
 
 		if (newsk->sk_prot->sockets_allocated)
-			atomic_inc(newsk->sk_prot->sockets_allocated);
+			inc_sockets_allocated(newsk->sk_prot->sockets_allocated); 
 	}
 out:
 	return newsk;
@@ -1451,6 +1451,25 @@ void sk_common_release(struct sock *sk)
 
 EXPORT_SYMBOL(sk_common_release);
 
+int read_sockets_allocated(struct proto *prot)
+{
+	int total = 0;
+	int cpu;
+	for_each_cpu(cpu)
+		total += *per_cpu_ptr(prot->sockets_allocated, cpu);
+	return total;
+}
+
+EXPORT_SYMBOL(read_sockets_allocated);
+
+void mod_sockets_allocated(int *sockets_allocated, int count)
+{
+	(*per_cpu_ptr(sockets_allocated, get_cpu())) += count;
+	put_cpu();
+}
+
+EXPORT_SYMBOL(mod_sockets_allocated);
+
 static DEFINE_RWLOCK(proto_list_lock);
 static LIST_HEAD(proto_list);
 
@@ -1620,7 +1639,7 @@ static void proto_seq_printf(struct seq_
 			"%2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c\n",
 		   proto->name,
 		   proto->obj_size,
-		   proto->sockets_allocated != NULL ? atomic_read(proto->sockets_allocated) : -1,
+		   proto->sockets_allocated != NULL ? read_sockets_allocated(proto) : -1,
 		   proto->memory_allocated != NULL ?
 				percpu_counter_read_positive(proto->memory_allocated) : -1,
 		   proto->memory_pressure != NULL ? *proto->memory_pressure ? "yes" : "no" : "NI",
Index: linux-2.6.16-rc5mm3/net/core/stream.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/core/stream.c	2006-03-08 11:08:28.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/core/stream.c	2006-03-08 11:39:40.000000000 -0800
@@ -242,7 +242,7 @@ int sk_stream_mem_schedule(struct sock *
 		return 1;
 
 	if (!*sk->sk_prot->memory_pressure ||
-	    sk->sk_prot->sysctl_mem[2] > atomic_read(sk->sk_prot->sockets_allocated) *
+	    sk->sk_prot->sysctl_mem[2] > read_sockets_allocated(sk->sk_prot) *
 				sk_stream_pages(sk->sk_wmem_queued +
 						atomic_read(&sk->sk_rmem_alloc) +
 						sk->sk_forward_alloc))
Index: linux-2.6.16-rc5mm3/net/ipv4/proc.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/ipv4/proc.c	2006-03-08 11:03:19.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/ipv4/proc.c	2006-03-08 11:39:40.000000000 -0800
@@ -63,7 +63,7 @@ static int sockstat_seq_show(struct seq_
 	socket_seq_show(seq);
 	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %lu\n",
 		   fold_prot_inuse(&tcp_prot), atomic_read(&tcp_orphan_count),
-		   tcp_death_row.tw_count, atomic_read(&tcp_sockets_allocated),
+		   tcp_death_row.tw_count, read_sockets_allocated(&tcp_prot),
 		   percpu_counter_read_positive(&tcp_memory_allocated));
 	seq_printf(seq, "UDP: inuse %d\n", fold_prot_inuse(&udp_prot));
 	seq_printf(seq, "RAW: inuse %d\n", fold_prot_inuse(&raw_prot));
Index: linux-2.6.16-rc5mm3/net/ipv4/tcp.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/ipv4/tcp.c	2006-03-08 11:16:33.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/ipv4/tcp.c	2006-03-08 11:39:40.000000000 -0800
@@ -284,7 +284,7 @@ EXPORT_SYMBOL(sysctl_tcp_rmem);
 EXPORT_SYMBOL(sysctl_tcp_wmem);
 
 struct percpu_counter tcp_memory_allocated;	/* Current allocated memory. */
-atomic_t tcp_sockets_allocated;	/* Current number of TCP sockets. */
+int *tcp_sockets_allocated;   /* Current number of TCP sockets. */
 
 EXPORT_SYMBOL(tcp_memory_allocated);
 EXPORT_SYMBOL(tcp_sockets_allocated);
@@ -2055,6 +2055,12 @@ void __init tcp_init(void)
 	if (!tcp_hashinfo.bind_bucket_cachep)
 		panic("tcp_init: Cannot alloc tcp_bind_bucket cache.");
 
+	tcp_sockets_allocated = alloc_percpu(int);
+	if (!tcp_sockets_allocated)
+		panic("tcp_init: Cannot alloc tcp_sockets_allocated");
+
+	tcp_prot.sockets_allocated = tcp_sockets_allocated;
+
 	/* Size and allocate the main established and bind bucket
 	 * hash tables.
 	 *
Index: linux-2.6.16-rc5mm3/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/ipv4/tcp_ipv4.c	2006-03-08 10:36:03.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/ipv4/tcp_ipv4.c	2006-03-08 11:39:40.000000000 -0800
@@ -1273,7 +1273,7 @@ static int tcp_v4_init_sock(struct sock 
 	sk->sk_sndbuf = sysctl_tcp_wmem[1];
 	sk->sk_rcvbuf = sysctl_tcp_rmem[1];
 
-	atomic_inc(&tcp_sockets_allocated);
+	inc_sockets_allocated(tcp_sockets_allocated);
 
 	return 0;
 }
@@ -1307,7 +1307,7 @@ int tcp_v4_destroy_sock(struct sock *sk)
 		sk->sk_sndmsg_page = NULL;
 	}
 
-	atomic_dec(&tcp_sockets_allocated);
+	dec_sockets_allocated(tcp_sockets_allocated);
 
 	return 0;
 }
@@ -1815,7 +1815,6 @@ struct proto tcp_prot = {
 	.unhash			= tcp_unhash,
 	.get_port		= tcp_v4_get_port,
 	.enter_memory_pressure	= tcp_enter_memory_pressure,
-	.sockets_allocated	= &tcp_sockets_allocated,
 	.orphan_count		= &tcp_orphan_count,
 	.memory_allocated	= &tcp_memory_allocated,
 	.memory_pressure	= &tcp_memory_pressure,
Index: linux-2.6.16-rc5mm3/net/ipv6/tcp_ipv6.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/net/ipv6/tcp_ipv6.c	2006-03-08 10:36:03.000000000 -0800
+++ linux-2.6.16-rc5mm3/net/ipv6/tcp_ipv6.c	2006-03-08 11:39:40.000000000 -0800
@@ -1375,7 +1375,7 @@ static int tcp_v6_init_sock(struct sock 
 	sk->sk_sndbuf = sysctl_tcp_wmem[1];
 	sk->sk_rcvbuf = sysctl_tcp_rmem[1];
 
-	atomic_inc(&tcp_sockets_allocated);
+	inc_sockets_allocated(tcp_sockets_allocated);
 
 	return 0;
 }
@@ -1573,7 +1573,6 @@ struct proto tcpv6_prot = {
 	.unhash			= tcp_unhash,
 	.get_port		= tcp_v6_get_port,
 	.enter_memory_pressure	= tcp_enter_memory_pressure,
-	.sockets_allocated	= &tcp_sockets_allocated,
 	.memory_allocated	= &tcp_memory_allocated,
 	.memory_pressure	= &tcp_memory_pressure,
 	.orphan_count		= &tcp_orphan_count,
@@ -1605,6 +1604,7 @@ static struct inet_protosw tcpv6_protosw
 
 void __init tcpv6_init(void)
 {
+	tcpv6_prot.sockets_allocated = tcp_sockets_allocated;
 	/* register inet6 protocol */
 	if (inet6_add_protocol(&tcpv6_protocol, IPPROTO_TCP) < 0)
 		printk(KERN_ERR "tcpv6_init: Could not register protocol\n");
