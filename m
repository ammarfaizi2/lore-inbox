Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVIMQRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVIMQRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVIMQRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:17:17 -0400
Received: from serv01.siteground.net ([70.85.91.68]:41149 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964842AbVIMQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:17:14 -0400
Date: Tue, 13 Sep 2005 09:17:08 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: [patch 9/11] net: dst_entry.refcount, use, lastuse to use alloc_percpu
Message-ID: <20050913161708.GK3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
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

Patch to use alloc_percpu for dst_entry.refcount.  This patch reduces the
cacheline bouncing of the atomic_t dst_entry.__refcount.  This Patch gets us
55% better tbench throughput, on a 8way x445 box.

Signed-off by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off by: Shobhit Dayal <shobhit@calsoftinc.com>
Signed-off by: Christoph Lameter <christoph@lameter.com>
Signed-off by: Ravikiran Thirumalai <kirant@scalex86.org>

Index: alloc_percpu-2.6.13/include/net/dst.h
===================================================================
--- alloc_percpu-2.6.13.orig/include/net/dst.h	2005-09-12 12:23:37.000000000 -0700
+++ alloc_percpu-2.6.13/include/net/dst.h	2005-09-12 16:44:05.000000000 -0700
@@ -35,11 +35,33 @@
 
 struct sk_buff;
 
+#ifdef CONFIG_NUMA
+
+/*	A per cpu instance of this exist for every dst_entry.
+ *	These are the most written fields of dst_entry.
+ */
+struct per_cpu_cnt
+{
+	int 		refcnt;
+	int 		use;
+	unsigned long	lastuse;
+};
+
+#endif
+
 struct dst_entry
 {
 	struct dst_entry        *next;
+#ifdef CONFIG_NUMA
+	/* first cpu that should be checked for time-out */
+	int 			s_cpu;
+	/* per cpu client references   */
+	struct per_cpu_cnt	*pcc;
+#else
 	atomic_t		__refcnt;	/* client references	*/
 	int			__use;
+	unsigned long		lastuse;
+#endif
 	struct dst_entry	*child;
 	struct net_device       *dev;
 	short			error;
@@ -50,7 +72,6 @@
 #define DST_NOPOLICY		4
 #define DST_NOHASH		8
 #define DST_BALANCED            0x10
-	unsigned long		lastuse;
 	unsigned long		expires;
 
 	unsigned short		header_len;	/* more space at head required */
@@ -103,25 +124,94 @@
 
 #ifdef __KERNEL__
 
+#ifdef CONFIG_NUMA
+
+static inline int dst_use(struct dst_entry *dst)
+{
+	int total = 0, cpu;
+
+	for_each_online_cpu(cpu)
+		total += per_cpu_ptr(dst->pcc, cpu)->use;
+	return total;
+}
+
+#define dst_use_inc(__dst) do {					\
+		per_cpu_ptr((__dst)->pcc, get_cpu())->use++ ;	\
+		put_cpu();					\
+	} while(0);
+
+static inline unsigned long dst_lastuse(struct dst_entry *dst)
+{
+	unsigned long max = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		if (max < per_cpu_ptr(dst->pcc, cpu)->lastuse)
+			max = per_cpu_ptr(dst->pcc, cpu)->lastuse;
+	return max;
+}
+
+#define dst_lastuse_set(__dst)  do {					  \
+		per_cpu_ptr((__dst)->pcc, get_cpu())->lastuse = jiffies ; \
+		put_cpu();						  \
+	} while(0);
+
+static inline int dst_refcnt(struct dst_entry *dst)
+{
+	int cpu, sum = 0;
+
+	for_each_online_cpu(cpu)
+		sum += per_cpu_ptr(dst->pcc, cpu)->refcnt;
+
+	return sum;
+}
+
+#define dst_refcnt_one(__dst) do { 					  \
+			per_cpu_ptr((__dst)->pcc, get_cpu())->refcnt = 1; \
+			put_cpu();		  			  \
+		} while(0);
+
+#define dst_refcnt_dec(__dst) do { 					\
+			per_cpu_ptr((__dst)->pcc, get_cpu())->refcnt--;	\
+			put_cpu();					\
+		} while(0);
+#define dst_hold(__dst) do { 						 \
+			per_cpu_ptr((__dst)->pcc, get_cpu())->refcnt++ ; \
+			put_cpu();					 \
+		} while(0);
+
+#else
+
 #define dst_use(__dst) (__dst)->__use
 #define dst_use_inc(__dst) (__dst)->__use++
 
 #define dst_lastuse(__dst) (__dst)->lastuse
 #define dst_lastuse_set(__dst) (__dst)->lastuse = jiffies
 
-#define dst_update_tu(__dst) do { dst_lastuse_set(__dst);dst_use_inc(__dst); } while (0)
-#define dst_update_rtu(__dst) do { dst_lastuse_set(__dst);dst_hold(__dst);dst_use_inc(__dst); } while (0)
-
 #define dst_refcnt(__dst) atomic_read(&(__dst)->__refcnt)
 #define dst_refcnt_one(__dst) atomic_set(&(__dst)->__refcnt, 1)
 #define dst_refcnt_dec(__dst) atomic_dec(&(__dst)->__refcnt)
 #define dst_hold(__dst) atomic_inc(&(__dst)->__refcnt)
 
+#endif
+#define dst_update_tu(__dst) do { 		\
+		dst_lastuse_set(__dst);		\
+		dst_use_inc(__dst); 		\
+	} while (0);
+
+#define dst_update_rtu(__dst) do { 		\
+		dst_lastuse_set(__dst);		\
+		dst_hold(__dst);		\
+		dst_use_inc(__dst); 		\
+	} while (0)
+
 static inline
 void dst_release(struct dst_entry * dst)
 {
 	if (dst) {
+#if  (!defined (CONFIG_NUMA) || (RT_CACHE_DEBUG >= 2 ))
 		WARN_ON(dst_refcnt(dst) < 1);
+#endif
 		smp_mb__before_atomic_dec();
 		dst_refcnt_dec(dst);
 	}
@@ -271,6 +361,48 @@
 
 extern void		dst_init(void);
 
+/*	This function allocates and initializes rtu array of given dst-entry.
+ */
+static inline int dst_init_rtu_array(struct dst_entry *dst)
+{
+#ifdef CONFIG_NUMA
+	int cpu;
+	dst->pcc = alloc_percpu(struct per_cpu_cnt, GFP_ATOMIC);
+	if(!dst->pcc)
+		return -ENOMEM;
+
+	for_each_cpu(cpu) {
+		per_cpu_ptr(dst->pcc, cpu)->use = 0;
+		per_cpu_ptr(dst->pcc, cpu)->refcnt = 0;
+		per_cpu_ptr(dst->pcc, cpu)->lastuse = jiffies;
+	}
+	dst->s_cpu = smp_processor_id();
+#else
+	atomic_set(&dst->__refcnt, 0);
+	dst->lastuse = jiffies;
+#endif
+	return 0;
+}
+
+static inline void dst_free_rtu_array(struct dst_entry *dst)
+{
+#ifdef CONFIG_NUMA
+	free_percpu(dst->pcc);
+#endif
+}
+
+#if	defined (CONFIG_HOTPLUG_CPU) && defined (CONFIG_NUMA)
+inline static void dst_ref_xfr_cpu_down(struct dst_entry *__dst, int cpu)
+{
+	int refcnt = per_cpu_ptr((__dst)->pcc, cpu)->refcnt;
+	if (refcnt) {
+		per_cpu_ptr((__dst)->pcc, get_cpu())->refcnt += refcnt;
+		put_cpu();
+		per_cpu_ptr((__dst)->pcc, cpu)->refcnt = 0;
+	}
+}
+#endif
+
 struct flowi;
 #ifndef CONFIG_XFRM
 static inline int xfrm_lookup(struct dst_entry **dst_p, struct flowi *fl,
Index: alloc_percpu-2.6.13/net/bridge/br_netfilter.c
===================================================================
--- alloc_percpu-2.6.13.orig/net/bridge/br_netfilter.c	2005-09-12 12:23:37.000000000 -0700
+++ alloc_percpu-2.6.13/net/bridge/br_netfilter.c	2005-09-12 12:24:01.000000000 -0700
@@ -85,7 +85,6 @@
 static struct rtable __fake_rtable = {
 	.u = {
 		.dst = {
-			.__refcnt		= ATOMIC_INIT(1),
 			.dev			= &__fake_net_device,
 			.path			= &__fake_rtable.u.dst,
 			.metrics		= {[RTAX_MTU - 1] = 1500},
@@ -1010,6 +1009,10 @@
 {
 	int i;
 
+	if (dst_init_rtu_array(&__fake_rtable.u.dst) < 0)
+		panic("br_netfilter : cannot allocate memory for dst-entry rtu array");
+	dst_refcnt_one(&__fake_rtable.u.dst);
+
 	for (i = 0; i < ARRAY_SIZE(br_nf_ops); i++) {
 		int ret;
 
@@ -1046,4 +1049,5 @@
 #ifdef CONFIG_SYSCTL
 	unregister_sysctl_table(brnf_sysctl_header);
 #endif
+	dst_free_rtu_array(&__fake_rtable.u.dst);
 }
Index: alloc_percpu-2.6.13/net/core/dst.c
===================================================================
--- alloc_percpu-2.6.13.orig/net/core/dst.c	2005-09-12 12:23:37.000000000 -0700
+++ alloc_percpu-2.6.13/net/core/dst.c	2005-09-12 12:24:01.000000000 -0700
@@ -131,9 +131,9 @@
 	if (!dst)
 		return NULL;
 	memset(dst, 0, ops->entry_size);
-	atomic_set(&dst->__refcnt, 0);
+	if (dst_init_rtu_array(dst) < 0)
+		return NULL;
 	dst->ops = ops;
-	dst->lastuse = jiffies;
 	dst->path = dst;
 	dst->input = dst_discard_in;
 	dst->output = dst_discard_out;
@@ -200,6 +200,7 @@
 #if RT_CACHE_DEBUG >= 2 
 	atomic_dec(&dst_total);
 #endif
+	dst_free_rtu_array(dst);
 	kmem_cache_free(dst->ops->kmem_cachep, dst);
 
 	dst = child;
Index: alloc_percpu-2.6.13/net/decnet/dn_route.c
===================================================================
--- alloc_percpu-2.6.13.orig/net/decnet/dn_route.c	2005-09-12 12:23:37.000000000 -0700
+++ alloc_percpu-2.6.13/net/decnet/dn_route.c	2005-09-12 12:24:01.000000000 -0700
@@ -77,6 +77,7 @@
 #include <linux/netfilter_decnet.h>
 #include <linux/rcupdate.h>
 #include <linux/times.h>
+#include <linux/cpu.h>
 #include <asm/errno.h>
 #include <net/neighbour.h>
 #include <net/dst.h>
@@ -157,7 +158,29 @@
 
 static inline int dn_dst_useful(struct dn_route *rth, unsigned long now, unsigned long expire)
 {
+#ifdef CONFIG_NUMA
+	{
+		int max, sum = 0, age, cpu;
+		struct dst_entry *dst = &rth->u.dst;
+
+		cpu = dst->s_cpu;
+		max = cpu + NR_CPUS;
+		for(sum = 0; cpu < max; cpu++) {
+			int cpu_ = cpu % NR_CPUS;
+			if (cpu_online(cpu_)) {
+				sum += per_cpu_ptr(dst->pcc, cpu_)->refcnt;
+				age = now - per_cpu_ptr(dst->pcc, cpu_)->lastuse;
+				if (age <= expire) {
+					dst->s_cpu = cpu_ ;
+					return 1;
+				}
+			}
+		}
+		return (sum != 0);
+	}
+#else
 	return  (atomic_read(&rth->u.dst.__refcnt) || (now - rth->u.dst.lastuse) < expire) ;
+#endif
 }
 
 static void dn_dst_check_expire(unsigned long dummy)
@@ -1766,6 +1789,43 @@
 
 #endif /* CONFIG_PROC_FS */
 
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+static int __devinit dn_rtcache_cpu_callback(struct notifier_block *nfb,
+                                   unsigned long action,
+                                   void *hcpu)
+{
+	int cpu = (int) hcpu;
+
+	switch(action) {
+		int i;
+		struct dn_route *rt, *next;
+
+		case CPU_DEAD:
+
+		for(i = 0; i < dn_rt_hash_mask; i++) {
+			spin_lock_bh(&dn_rt_hash_table[i].lock);
+
+			if ((rt = dn_rt_hash_table[i].chain) == NULL)
+				goto nothing_to_do;
+
+			for(; rt; rt=next) {
+				dst_ref_xfr_cpu_down(&rt->u.dst, cpu);
+				next = rt->u.rt_next;
+			}
+nothing_to_do:
+			spin_unlock_bh(&dn_rt_hash_table[i].lock);
+		}
+
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block dn_rtcache_cpu_notifier =
+			{ &dn_rtcache_cpu_callback, NULL, 0 };
+
+#endif
+
 void __init dn_route_init(void)
 {
 	int i, goal, order;
@@ -1822,10 +1882,16 @@
         dn_dst_ops.gc_thresh = (dn_rt_hash_mask + 1);
 
 	proc_net_fops_create("decnet_cache", S_IRUGO, &dn_rt_cache_seq_fops);
+#if	defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+	register_cpu_notifier(&dn_rtcache_cpu_notifier);
+#endif
 }
 
 void __exit dn_route_cleanup(void)
 {
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+	unregister_cpu_notifier(&dn_rtcache_cpu_notifier);
+#endif
 	del_timer(&dn_route_timer);
 	dn_run_flush(0);
 
Index: alloc_percpu-2.6.13/net/ipv4/route.c
===================================================================
--- alloc_percpu-2.6.13.orig/net/ipv4/route.c	2005-09-12 12:23:37.000000000 -0700
+++ alloc_percpu-2.6.13/net/ipv4/route.c	2005-09-12 12:24:01.000000000 -0700
@@ -92,6 +92,7 @@
 #include <linux/jhash.h>
 #include <linux/rcupdate.h>
 #include <linux/times.h>
+#include <linux/cpu.h>
 #include <net/protocol.h>
 #include <net/ip.h>
 #include <net/route.h>
@@ -507,6 +508,54 @@
 		rth->u.dst.expires;
 }
 
+#ifdef CONFIG_NUMA
+
+/*
+ * For NUMA systems, we do not want to sum up all local cpu refcnts every
+ * time. So we consider lastuse element of the dst_entry and start loop
+ * with the cpu where this entry was allocated. If dst_entry is not timed
+ * out then update s_cpu of this dst_entry so that next time we can start from
+ * that cpu.
+ */
+static inline int rt_check_age(struct rtable *rth,
+			unsigned long tmo1, unsigned long tmo2)
+{
+	int max, sum = 0, age, idx;
+	struct dst_entry *dst = &rth->u.dst;
+	unsigned long now = jiffies;
+
+	idx = dst->s_cpu;
+	max = idx + NR_CPUS;
+	for(sum = 0; idx < max; idx++) {
+		int cpu_ = idx % NR_CPUS;
+		if (cpu_online(cpu_)) {
+			sum += per_cpu_ptr(dst->pcc, cpu_)->refcnt;
+			age = now - per_cpu_ptr(dst->pcc, cpu_)->lastuse;
+			if ((age <= tmo1 && !rt_fast_clean(rth)) ||
+					(age <= tmo2 && rt_valuable(rth))) {
+				dst->s_cpu = cpu_ ;
+				return 0;
+			}
+		}
+	}
+	return (sum == 0);
+}
+
+/*
+ * In this function order of examining three factors (ref_cnt, expires,
+ * lastuse) is changed, considering the cost of analyzing refcnt and lastuse
+ * which are localized for each cpu on NUMA.
+ */
+static int rt_may_expire(struct rtable *rth, unsigned long tmo1, unsigned long tmo2)
+{
+	if (rth->u.dst.expires && time_after_eq(jiffies, rth->u.dst.expires))
+		return (dst_refcnt(&rth->u.dst) == 0) ;
+
+	return rt_check_age(rth, tmo1, tmo2);
+}
+
+#else
+
 static int rt_may_expire(struct rtable *rth, unsigned long tmo1, unsigned long tmo2)
 {
 	unsigned long age;
@@ -529,6 +578,8 @@
 out:	return ret;
 }
 
+#endif
+
 /* Bits of score are:
  * 31: very valuable
  * 30: not quite useless
@@ -1108,8 +1159,19 @@
 
 void ip_rt_copy(struct rtable *to, struct rtable *from)
 {
+#ifdef CONFIG_NUMA
+	struct per_cpu_cnt *tmp_pnc;
+	tmp_pnc = to->u.dst.pcc;
+
+	*to = *from;
+	to->u.dst.pcc = tmp_pnc;
+	per_cpu_ptr(to->u.dst.pcc,get_cpu())->use = 1;
+	to->u.dst.s_cpu = smp_processor_id();
+	put_cpu();
+#else
 	*to = *from;
 	to->u.dst.__use 	= 1;
+#endif
 }
 
 void ip_rt_redirect(u32 old_gw, u32 daddr, u32 new_gw,
@@ -3108,6 +3170,33 @@
 }
 __setup("rhash_entries=", set_rhash_entries);
 
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+static int __devinit rtcache_cpu_callback(struct notifier_block *nfb,
+                                   unsigned long action,
+				   void *hcpu)
+{
+	int cpu = (int) hcpu;
+
+	switch(action) {
+		int i ;
+		struct rtable *rth;
+		case CPU_DEAD:
+			for(i = rt_hash_mask; i >= 0; i--) {
+				spin_lock_irq(rt_hash_lock_addr(i));
+				rth = rt_hash_table[i].chain;
+				while(rth) {
+					dst_ref_xfr_cpu_down(&rth->u.dst, cpu);
+					rth = rth->u.rt_next;
+				}
+				spin_unlock_irq(rt_hash_lock_addr(i));
+			}
+			break;
+	}
+	return NOTIFY_OK;
+}
+static struct notifier_block rtcache_cpu_notifier = { &rtcache_cpu_callback, NULL, 0 };
+#endif
+
 int __init ip_rt_init(void)
 {
 	int rc = 0;
@@ -3197,6 +3286,9 @@
 	xfrm_init();
 	xfrm4_init();
 #endif
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+	register_cpu_notifier(&rtcache_cpu_notifier);
+#endif
 	return rc;
 }
 
Index: alloc_percpu-2.6.13/net/ipv6/ip6_fib.c
===================================================================
--- alloc_percpu-2.6.13.orig/net/ipv6/ip6_fib.c	2005-09-12 12:23:37.000000000 -0700
+++ alloc_percpu-2.6.13/net/ipv6/ip6_fib.c	2005-09-12 12:24:01.000000000 -0700
@@ -1209,6 +1209,35 @@
 	spin_unlock_bh(&fib6_gc_lock);
 }
 
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+#include <linux/cpu.h>
+inline static int rt6_ref_xfr_cpu_down(struct rt6_info *rt, void *arg)
+{
+	dst_ref_xfr_cpu_down(&rt->u.dst, (int)arg);
+	return 0;
+}
+
+static int __devinit ipv6_rtcache_cpu_callback(struct notifier_block *nfb,
+                                   unsigned long action,
+                                   void *hcpu)
+{
+	int cpu = (int) hcpu;
+
+	switch(action) {
+		case CPU_DEAD:
+			write_lock_bh(&rt6_lock);
+			fib6_clean_tree(&ip6_routing_table, rt6_ref_xfr_cpu_down,
+					0, (void *)cpu);
+			write_unlock_bh(&rt6_lock);
+			break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ipv6_rtcache_cpu_notifier =
+				{ &ipv6_rtcache_cpu_callback, NULL, 0 };
+#endif
+
 void __init fib6_init(void)
 {
 	fib6_node_kmem = kmem_cache_create("fib6_nodes",
@@ -1217,10 +1246,16 @@
 					   NULL, NULL);
 	if (!fib6_node_kmem)
 		panic("cannot create fib6_nodes cache");
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+	register_cpu_notifier(&ipv6_rtcache_cpu_notifier);
+#endif
 }
 
 void fib6_gc_cleanup(void)
 {
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+	unregister_cpu_notifier(&ipv6_rtcache_cpu_notifier);
+#endif
 	del_timer(&ip6_fib_timer);
 	kmem_cache_destroy(fib6_node_kmem);
 }
Index: alloc_percpu-2.6.13/net/ipv6/route.c
===================================================================
--- alloc_percpu-2.6.13.orig/net/ipv6/route.c	2005-09-12 12:23:37.000000000 -0700
+++ alloc_percpu-2.6.13/net/ipv6/route.c	2005-09-12 12:24:01.000000000 -0700
@@ -110,8 +110,6 @@
 struct rt6_info ip6_null_entry = {
 	.u = {
 		.dst = {
-			.__refcnt	= ATOMIC_INIT(1),
-			.__use		= 1,
 			.dev		= &loopback_dev,
 			.obsolete	= -1,
 			.error		= -ENETUNREACH,
@@ -2104,6 +2102,10 @@
 						     NULL, NULL);
 	if (!ip6_dst_ops.kmem_cachep)
 		panic("cannot create ip6_dst_cache");
+	if (dst_init_rtu_array(&ip6_null_entry.u.dst) < 0)
+		panic("ip6_route : can't allocate memory for dst-entry array");
+	dst_use_inc(&ipv6_null_entry.u.dist);
+	dst_refcnt_one(&ip6_null_entry.u.dst);
 
 	fib6_init();
 #ifdef 	CONFIG_PROC_FS
@@ -2130,4 +2132,5 @@
 	rt6_ifdown(NULL);
 	fib6_gc_cleanup();
 	kmem_cache_destroy(ip6_dst_ops.kmem_cachep);
+	dst_free_rtu_array(&ip6_null_entry.u.dst);
 }
