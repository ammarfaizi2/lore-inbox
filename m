Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWCHCDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWCHCDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWCHCDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:03:15 -0500
Received: from ns1.siteground.net ([207.218.208.2]:58299 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964884AbWCHCDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:03:14 -0500
Date: Tue, 7 Mar 2006 18:03:55 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: [patch 4/4] net: percpufy frequently used vars -- proto.inuse
Message-ID: <20060308020355.GE9062@localhost.localdomain>
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

This patch uses alloc_percpu to allocate per-CPU memory for the proto->inuse
field.  The inuse field is currently per-CPU as in NR_CPUS * cacheline size -- 
a big bloat on arches with large cachelines.  Also marks some frequently
used protos read mostly.

Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc2/include/net/sock.h
===================================================================
--- linux-2.6.16-rc2.orig/include/net/sock.h	2006-02-09 15:01:47.000000000 -0800
+++ linux-2.6.16-rc2/include/net/sock.h	2006-02-09 15:01:52.000000000 -0800
@@ -573,10 +573,7 @@ struct proto {
 #ifdef SOCK_REFCNT_DEBUG
 	atomic_t		socks;
 #endif
-	struct {
-		int inuse;
-		u8  __pad[SMP_CACHE_BYTES - sizeof(int)];
-	} stats[NR_CPUS];
+	int *inuse;
 };
 
 static inline int read_sockets_allocated(struct proto *prot)
@@ -628,12 +625,12 @@ static inline void sk_refcnt_debug_relea
 /* Called with local bh disabled */
 static __inline__ void sock_prot_inc_use(struct proto *prot)
 {
-	prot->stats[smp_processor_id()].inuse++;
+	(*per_cpu_ptr(prot->inuse, smp_processor_id())) += 1;
 }
 
 static __inline__ void sock_prot_dec_use(struct proto *prot)
 {
-	prot->stats[smp_processor_id()].inuse--;
+	(*per_cpu_ptr(prot->inuse, smp_processor_id())) -= 1;
 }
 
 /* With per-bucket locks this operation is not-atomic, so that
Index: linux-2.6.16-rc2/net/core/sock.c
===================================================================
--- linux-2.6.16-rc2.orig/net/core/sock.c	2006-02-09 15:01:47.000000000 -0800
+++ linux-2.6.16-rc2/net/core/sock.c	2006-02-09 15:01:52.000000000 -0800
@@ -1508,12 +1508,21 @@ int proto_register(struct proto *prot, i
 		}
 	}
 
+	prot->inuse = alloc_percpu(int);
+	if (prot->inuse == NULL) {
+		if (alloc_slab)
+			goto out_free_timewait_sock_slab_name_cache;
+		else
+			goto out;
+	}
 	write_lock(&proto_list_lock);
 	list_add(&prot->node, &proto_list);
 	write_unlock(&proto_list_lock);
 	rc = 0;
 out:
 	return rc;
+out_free_timewait_sock_slab_name_cache:
+	kmem_cache_destroy(prot->twsk_prot->twsk_slab);
 out_free_timewait_sock_slab_name:
 	kfree(timewait_sock_slab_name);
 out_free_request_sock_slab:
@@ -1537,6 +1546,11 @@ void proto_unregister(struct proto *prot
 	list_del(&prot->node);
 	write_unlock(&proto_list_lock);
 
+	if (prot->inuse != NULL) {
+		free_percpu(prot->inuse);
+		prot->inuse = NULL;
+	}
+
 	if (prot->slab != NULL) {
 		kmem_cache_destroy(prot->slab);
 		prot->slab = NULL;
Index: linux-2.6.16-rc2/net/ipv4/proc.c
===================================================================
--- linux-2.6.16-rc2.orig/net/ipv4/proc.c	2006-02-09 15:01:47.000000000 -0800
+++ linux-2.6.16-rc2/net/ipv4/proc.c	2006-02-09 15:01:52.000000000 -0800
@@ -50,7 +50,7 @@ static int fold_prot_inuse(struct proto 
 	int cpu;
 
 	for_each_cpu(cpu)
-		res += proto->stats[cpu].inuse;
+		res += (*per_cpu_ptr(proto->inuse, cpu));
 
 	return res;
 }
Index: linux-2.6.16-rc2/net/ipv4/raw.c
===================================================================
--- linux-2.6.16-rc2.orig/net/ipv4/raw.c	2006-02-07 23:14:04.000000000 -0800
+++ linux-2.6.16-rc2/net/ipv4/raw.c	2006-02-09 15:01:52.000000000 -0800
@@ -718,7 +718,7 @@ static int raw_ioctl(struct sock *sk, in
 	}
 }
 
-struct proto raw_prot = {
+struct proto raw_prot __read_mostly = {
 	.name =		"RAW",
 	.owner =	THIS_MODULE,
 	.close =	raw_close,
Index: linux-2.6.16-rc2/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6.16-rc2.orig/net/ipv4/tcp_ipv4.c	2006-02-09 15:01:47.000000000 -0800
+++ linux-2.6.16-rc2/net/ipv4/tcp_ipv4.c	2006-02-09 15:01:52.000000000 -0800
@@ -1794,7 +1794,7 @@ void tcp4_proc_exit(void)
 }
 #endif /* CONFIG_PROC_FS */
 
-struct proto tcp_prot = {
+struct proto tcp_prot __read_mostly = {
 	.name			= "TCP",
 	.owner			= THIS_MODULE,
 	.close			= tcp_close,
Index: linux-2.6.16-rc2/net/ipv4/udp.c
===================================================================
--- linux-2.6.16-rc2.orig/net/ipv4/udp.c	2006-02-07 23:14:04.000000000 -0800
+++ linux-2.6.16-rc2/net/ipv4/udp.c	2006-02-09 15:01:52.000000000 -0800
@@ -1340,7 +1340,7 @@ unsigned int udp_poll(struct file *file,
 	
 }
 
-struct proto udp_prot = {
+struct proto udp_prot __read_mostly = {
  	.name =		"UDP",
 	.owner =	THIS_MODULE,
 	.close =	udp_close,
Index: linux-2.6.16-rc2/net/ipv6/proc.c
===================================================================
--- linux-2.6.16-rc2.orig/net/ipv6/proc.c	2006-02-07 23:19:10.000000000 -0800
+++ linux-2.6.16-rc2/net/ipv6/proc.c	2006-02-09 15:01:52.000000000 -0800
@@ -39,7 +39,7 @@ static int fold_prot_inuse(struct proto 
 	int cpu;
 
 	for_each_cpu(cpu)
-		res += proto->stats[cpu].inuse;
+		res += (*per_cpu_ptr(proto->inuse, cpu));
 
 	return res;
 }
