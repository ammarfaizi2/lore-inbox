Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbVFXDQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbVFXDQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVFXDOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:14:41 -0400
Received: from graphe.net ([209.204.138.32]:6530 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263021AbVFXDKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:10:09 -0400
Date: Thu, 23 Jun 2005 20:10:06 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org
cc: linux-net@vger.kernel.org, davem@davemloft.net, shai@scalex86.org,
       akpm@osdl.org
Subject: [PATCH] dst numa: Avoid dst counter cacheline bouncing
In-Reply-To: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
Message-ID: <Pine.LNX.4.62.0506232005030.28244@graphe.net>
References: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dst_entry structure contains an atomic counter that is incremented and
decremented for each network packet being sent. If there is a high number of
packets being sent from multiple processors then cacheline bouncing between
NUMA nodes can limit the tcp performance in a NUMA system.

The following patch splits the usage counter into counters per node.

Patch depends on the numa slab allocator in mm in order to be able to allocate
node local memory in a fast way. Patch will work without the numa slab allocator
but the node specific allocations will be very slow.

The patch also depends on the dst abstraction patch.

AIM7 results (tcp_test and udp_test) on i386 (IBM x445 8p 16G):

No patch	94788.2
w/patch		97739.2 (+3.11%)

The numbers will be much higher on larger NUMA machines.

Detailed AIM7 result no patch:

Benchmark       Version Machine Run Date
AIM Multiuser Benchmark - Suite VII     "1.1"           Jun 22 07:58:48 2005

Tasks   Jobs/Min        JTI     Real    CPU     Jobs/sec/task
1       568.4           100     10.4    0.5     9.4737
101     37148.0         87      16.1    48.0    6.1300
201     54024.4         81      22.1    95.5    4.4796
301     63424.6         76      28.2    143.2   3.5119
401     69913.1         75      34.1    191.4   2.9058
501     74157.5         72      40.1    239.2   2.4670
601     77388.7         70      46.1    286.9   2.1461
701     79784.2         68      52.2    335.1   1.8969
914     83809.2         67      64.8    435.7   1.5282
1127    86123.5         71      77.7    539.1   1.2736
1595    89371.8         67      106.0   764.3   0.9339
1792    90047.2         64      118.2   861.2   0.8375
2208    91729.8         64      143.0   1059.9  0.6924
2624    92699.9         63      168.1   1260.2  0.5888
3529    93853.9         63      223.3   1701.4  0.4433
3917    94339.6         70      246.6   1886.8  0.4014
4733    94698.3         64      296.9   2285.2  0.3335
5000    94788.2         64      313.3   2413.5  0.3160

AIM7 with patch:

Benchmark       Version Machine Run Date
AIM Multiuser Benchmark - Suite VII     "1.1"           Jun 22 06:27:47 2005

Tasks   Jobs/Min        JTI     Real    CPU     Jobs/sec/task
1       568.4           100     10.4    0.4     9.4737
101     37426.1         87      16.0    46.5    6.1759
201     54742.8         81      21.8    92.5    4.5392
301     64898.0         77      27.6    138.7   3.5935
401     71272.9         74      33.4    185.2   2.9623
501     75955.6         73      39.2    231.2   2.5268
601     79473.3         73      44.9    277.6   2.2039
701     81967.3         70      50.8    323.7   1.9488
914     85836.5         70      63.2    422.6   1.5652
1127    88585.2         67      75.6    521.7   1.3100
1594    92194.4         78      102.7   738.6   0.9640
1791    93091.9         67      114.3   830.9   0.8663
2207    94517.5         72      138.7   1025.4  0.7138
2623    95358.5         64      163.4   1221.5  0.6059
3529    96449.2         65      217.3   1650.9  0.4555
3917    97075.2         64      239.7   1829.8  0.4131
4732    97485.8         63      288.3   2214.5  0.3434
5000    97739.2         67      303.9   2341.2  0.3258

Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off-by: Shobhit Dayal <shobhit@calsoftinc.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Christoph Lameter <christoph@scalex86.org>

Index: linux-2.6.12/include/net/dst.h
===================================================================
--- linux-2.6.12.orig/include/net/dst.h	2005-06-24 02:18:00.000000000 +0000
+++ linux-2.6.12/include/net/dst.h	2005-06-24 02:18:02.000000000 +0000
@@ -12,6 +12,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/rcupdate.h>
 #include <linux/jiffies.h>
+#include <linux/nodemask.h>
 #include <net/neighbour.h>
 #include <asm/processor.h>
 
@@ -35,11 +36,34 @@
 
 struct sk_buff;
 
+#ifdef CONFIG_NUMA
+
+/*	A per node instance of this exist for every dst_entry.
+ *	These are the most written fields of dst_entry.
+ */
+struct per_node_cnt
+{
+	atomic_t	refcnt;
+	int 		use;
+	unsigned long	lastuse;
+};
+
+extern kmem_cache_t *rtu_cachep;
+#endif
+
 struct dst_entry
 {
 	struct dst_entry        *next;
+#ifdef CONFIG_NUMA
+	/* first node that should be checked for time-out */
+	int 			s_nid;
+	/* per node client references   */
+	struct per_node_cnt	*__ncnt[MAX_NUMNODES];
+#else
 	atomic_t		__refcnt;	/* client references	*/
 	int			__use;
+	unsigned long		lastuse;
+#endif
 	struct dst_entry	*child;
 	struct net_device       *dev;
 	short			error;
@@ -50,7 +74,6 @@ struct dst_entry
 #define DST_NOPOLICY		4
 #define DST_NOHASH		8
 #define DST_BALANCED            0x10
-	unsigned long		lastuse;
 	unsigned long		expires;
 
 	unsigned short		header_len;	/* more space at head required */
@@ -103,25 +126,70 @@ struct dst_ops
 
 #ifdef __KERNEL__
 
+#ifdef CONFIG_NUMA
+
+static inline int dst_use(struct dst_entry *dst)
+{
+	int total = 0, nid;
+
+	for_each_online_node(nid)
+		total += dst->__ncnt[nid]->use;
+	return total;
+}
+
+#define dst_use_inc(__dst) (__dst)->__ncnt[numa_node_id()]->use++
+
+static inline unsigned long dst_lastuse(struct dst_entry *dst)
+{
+	unsigned long max = 0;
+	int nid;
+
+	for_each_online_node(nid)
+		if (max < dst->__ncnt[nid]->lastuse)
+			max = dst->__ncnt[nid]->lastuse;
+	return max;
+}
+
+#define dst_lastuse_set(__dst) (__dst)->__ncnt[numa_node_id()]->lastuse = jiffies
+
+static inline int dst_refcnt(struct dst_entry *dst)
+{
+	int nid, sum = 0;
+
+	for_each_online_node(nid)
+		sum += atomic_read(&dst->__ncnt[nid]->refcnt);
+
+	return sum;
+}
+
+#define dst_refcnt_one(__dst) atomic_set(&(__dst)->__ncnt[numa_node_id()]->refcnt, 1)
+#define dst_refcnt_dec(__dst) atomic_dec(&(__dst)->__ncnt[numa_node_id()]->refcnt)
+#define dst_hold(__dst) atomic_inc(&(__dst)->__ncnt[numa_node_id()]->refcnt)
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
+#define dst_update_tu(__dst) do { dst_lastuse_set(__dst);dst_use_inc(__dst); } while (0)
+#define dst_update_rtu(__dst) do { dst_lastuse_set(__dst);dst_hold(__dst);dst_use_inc(__dst); } while (0)
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
@@ -271,6 +339,55 @@ static inline struct dst_entry *dst_chec
 
 extern void		dst_init(void);
 
+/*	This function allocates and initializes rtu array of given dst-entry.
+ */
+static inline int dst_init_rtu_array(struct dst_entry *dst)
+{
+#ifdef CONFIG_NUMA
+	int nid, curr_node;
+
+	curr_node = numa_node_id();
+	for_each_node(nid) {
+		int online_node;
+		online_node = node_online(nid) ? nid : curr_node;
+		if (!(dst->__ncnt[nid] = kmem_cache_alloc_node(rtu_cachep,
+						SLAB_ATOMIC, online_node))) {
+			for(; nid>=0; nid--)
+				kmem_cache_free(rtu_cachep, dst->__ncnt[nid]);
+			return -ENOMEM;
+		}
+		dst->__ncnt[nid]->use = 0;
+		atomic_set(&dst->__ncnt[nid]->refcnt, 0);
+		dst->__ncnt[nid]->lastuse = jiffies;
+	}
+	dst->s_nid = curr_node;
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
+	int nid;
+	for_each_node(nid)
+		kmem_cache_free(rtu_cachep, dst->__ncnt[nid]);
+#endif
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+inline static void dst_ref_xfr_node_down(struct dst_entry *dst, int nid)
+{
+	int refcnt = atomic_read(&dst->__ncnt[nid]->refcnt);
+	if (refcnt) {
+		atomic_add(refcnt, &dst->__ncnt[numa_node_id()]->refcnt);
+		atomic_set(&dst->__ncnt[nid]->refcnt, 0);
+	}
+}
+#endif
+
 struct flowi;
 #ifndef CONFIG_XFRM
 static inline int xfrm_lookup(struct dst_entry **dst_p, struct flowi *fl,
Index: linux-2.6.12/net/bridge/br_netfilter.c
===================================================================
--- linux-2.6.12.orig/net/bridge/br_netfilter.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/bridge/br_netfilter.c	2005-06-24 02:18:02.000000000 +0000
@@ -85,7 +85,6 @@ static struct net_device __fake_net_devi
 static struct rtable __fake_rtable = {
 	.u = {
 		.dst = {
-			.__refcnt		= ATOMIC_INIT(1),
 			.dev			= &__fake_net_device,
 			.path			= &__fake_rtable.u.dst,
 			.metrics		= {[RTAX_MTU - 1] = 1500},
@@ -1048,6 +1047,10 @@ int br_netfilter_init(void)
 {
 	int i;
 
+	if (dst_init_rtu_array(&__fake_rtable.u.dst) < 0)
+		panic("br_netfilter : cannot allocate memory for dst-entry rtu array");
+	dst_refcnt_one(&__fake_rtable.u.dst);
+
 	for (i = 0; i < ARRAY_SIZE(br_nf_ops); i++) {
 		int ret;
 
@@ -1084,4 +1087,5 @@ void br_netfilter_fini(void)
 #ifdef CONFIG_SYSCTL
 	unregister_sysctl_table(brnf_sysctl_header);
 #endif
+	dst_free_rtu_array(&__fake_rtable.u.dst);
 }
Index: linux-2.6.12/net/core/dst.c
===================================================================
--- linux-2.6.12.orig/net/core/dst.c	2005-06-24 02:18:00.000000000 +0000
+++ linux-2.6.12/net/core/dst.c	2005-06-24 02:18:02.000000000 +0000
@@ -124,9 +124,9 @@ void * dst_alloc(struct dst_ops * ops)
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
@@ -193,6 +193,7 @@ again:
 #if RT_CACHE_DEBUG >= 2 
 	atomic_dec(&dst_total);
 #endif
+	dst_free_rtu_array(dst);
 	kmem_cache_free(dst->ops->kmem_cachep, dst);
 
 	dst = child;
@@ -267,8 +268,20 @@ static struct notifier_block dst_dev_not
 	.notifier_call	= dst_dev_event,
 };
 
+#ifdef CONFIG_NUMA
+kmem_cache_t *rtu_cachep;
+#endif
+
 void __init dst_init(void)
 {
+#ifdef CONFIG_NUMA
+	rtu_cachep =  kmem_cache_create("dst_rtu",
+			sizeof(struct per_node_cnt),
+			0, 0, NULL, NULL);
+
+	if (!rtu_cachep)
+		panic("IP: failed to create rtu_cachep\n");
+#endif
 	register_netdevice_notifier(&dst_dev_notifier);
 }
 
Index: linux-2.6.12/net/decnet/dn_route.c
===================================================================
--- linux-2.6.12.orig/net/decnet/dn_route.c	2005-06-24 02:18:00.000000000 +0000
+++ linux-2.6.12/net/decnet/dn_route.c	2005-06-24 02:18:02.000000000 +0000
@@ -77,6 +77,7 @@
 #include <linux/netfilter_decnet.h>
 #include <linux/rcupdate.h>
 #include <linux/times.h>
+#include <linux/cpu.h>
 #include <asm/errno.h>
 #include <net/neighbour.h>
 #include <net/dst.h>
@@ -157,7 +158,29 @@ static inline void dnrt_drop(struct dn_r
 
 static inline int dn_dst_useful(struct dn_route *rth, unsigned long now, unsigned long expire)
 {
+#ifdef CONFIG_NUMA
+	{
+		int max, sum = 0, age, nid;
+		struct dst_entry *dst = &rth->u.dst;
+
+		nid = dst->s_nid;
+		max = nid + MAX_NUMNODES;
+		for(sum = 0; nid < max; nid++) {
+			int nid_ = nid % MAX_NUMNODES;
+			if (node_online(nid_)) {
+				sum += atomic_read(&dst->__ncnt[nid_]->refcnt);
+				age = now - dst->__ncnt[nid_]->lastuse;
+				if (age <= expire) {
+					dst->s_nid = nid_ ;
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
@@ -1766,6 +1789,45 @@ static struct file_operations dn_rt_cach
 
 #endif /* CONFIG_PROC_FS */
 
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+static int __devinit dn_rtcache_cpu_callback(struct notifier_block *nfb,
+                                   unsigned long action,
+                                   void *hcpu)
+{
+	int node = cpu_to_node((int) hcpu);
+	if ( node_online(node))
+		return NOTIFY_OK;
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
+				dst_ref_xfr_node_down(&rt->u.dst, node);
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
@@ -1822,10 +1884,16 @@ void __init dn_route_init(void)
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
 
Index: linux-2.6.12/net/ipv4/route.c
===================================================================
--- linux-2.6.12.orig/net/ipv4/route.c	2005-06-24 02:18:00.000000000 +0000
+++ linux-2.6.12/net/ipv4/route.c	2005-06-24 02:18:02.000000000 +0000
@@ -90,6 +90,7 @@
 #include <linux/jhash.h>
 #include <linux/rcupdate.h>
 #include <linux/times.h>
+#include <linux/cpu.h>
 #include <net/protocol.h>
 #include <net/ip.h>
 #include <net/route.h>
@@ -476,6 +477,54 @@ static __inline__ int rt_valuable(struct
 		rth->u.dst.expires;
 }
 
+#ifdef CONFIG_NUMA
+
+/*
+ * For NUMA systems, we do not want to sum up all local node refcnts every
+ * time. So we consider lastuse element of the dst_entry and start loop
+ * with the node where this entry was allocated. If dst_entry is not timed
+ * out then update s_nid of this dst_entry so that next time we can start from
+ * that node.
+ */
+static inline int rt_check_age(struct rtable *rth,
+			unsigned long tmo1, unsigned long tmo2)
+{
+	int max, sum = 0, age, idx;
+	struct dst_entry *dst = &rth->u.dst;
+	unsigned long now = jiffies;
+
+	idx = dst->s_nid;
+	max = idx + MAX_NUMNODES;
+	for(sum = 0; idx < max; idx++) {
+		int nid_ = idx % MAX_NUMNODES;
+		if (node_online(nid_)) {
+			sum += atomic_read(&dst->__ncnt[nid_]->refcnt);
+			age = now - dst->__ncnt[nid_]->lastuse;
+			if ((age <= tmo1 && !rt_fast_clean(rth)) ||
+					(age <= tmo2 && rt_valuable(rth))) {
+				dst->s_nid = nid_ ;
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
+ * which are localized for each node on NUMA.
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
@@ -498,6 +547,8 @@ static int rt_may_expire(struct rtable *
 out:	return ret;
 }
 
+#endif
+
 /* Bits of score are:
  * 31: very valuable
  * 30: not quite useless
@@ -1071,8 +1122,21 @@ static void rt_del(unsigned hash, struct
 
 void ip_rt_copy(struct rtable *to, struct rtable *from)
 {
+#ifdef CONFIG_NUMA
+	struct per_node_cnt *tmp_pnc[MAX_NUMNODES];
+
+	memcpy(&tmp_pnc[0], &to->u.dst.__ncnt[0],
+			sizeof(struct per_node_cnt *)*MAX_NUMNODES);
+	*to = *from;
+	memcpy(&to->u.dst.__ncnt[0], &tmp_pnc[0],
+			sizeof(struct per_node_cnt *)*MAX_NUMNODES);
+
+	to->u.dst.__ncnt[numa_node_id()]->use = 1;
+	to->u.dst.s_nid = numa_node_id();
+#else
 	*to = *from;
 	to->u.dst.__use 	= 1;
+#endif
 }
 
 void ip_rt_redirect(u32 old_gw, u32 daddr, u32 new_gw,
@@ -3066,6 +3130,35 @@ static int __init set_rhash_entries(char
 }
 __setup("rhash_entries=", set_rhash_entries);
 
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+static int __devinit rtcache_cpu_callback(struct notifier_block *nfb,
+                                   unsigned long action,
+				   void *hcpu)
+{
+	int node = cpu_to_node((int) hcpu);
+	if (node_online(node))
+		return NOTIFY_OK;
+
+	switch(action) {
+		int i ;
+		struct rtable *rth;
+		case CPU_DEAD:
+			for(i = rt_hash_mask; i >= 0; i--) {
+				spin_lock_irq(&rt_hash_table[i].lock);
+				rth = rt_hash_table[i].chain;
+				while(rth) {
+					dst_ref_xfr_node_down(&rth->u.dst, node);
+					rth = rth->u.rt_next;
+				}
+				spin_unlock_irq(&rt_hash_table[i].lock);
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
 	int i, order, goal, rc = 0;
@@ -3169,6 +3262,9 @@ int __init ip_rt_init(void)
 	xfrm_init();
 	xfrm4_init();
 #endif
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+	register_cpu_notifier(&rtcache_cpu_notifier);
+#endif
 	return rc;
 }
 
Index: linux-2.6.12/net/ipv6/ip6_fib.c
===================================================================
--- linux-2.6.12.orig/net/ipv6/ip6_fib.c	2005-06-24 02:18:00.000000000 +0000
+++ linux-2.6.12/net/ipv6/ip6_fib.c	2005-06-24 02:18:02.000000000 +0000
@@ -1208,6 +1208,37 @@ void fib6_run_gc(unsigned long dummy)
 	spin_unlock_bh(&fib6_gc_lock);
 }
 
+#if defined(CONFIG_NUMA) && defined(CONFIG_HOTPLUG_CPU)
+#include <linux/cpu.h>
+inline static int rt6_ref_xfr_node_down(struct rt6_info *rt, void *arg)
+{
+	dst_ref_xfr_node_down(&rt->u.dst, (int)arg);
+	return 0;
+}
+
+static int __devinit ipv6_rtcache_cpu_callback(struct notifier_block *nfb,
+                                   unsigned long action,
+                                   void *hcpu)
+{
+	int node = cpu_to_node((int) hcpu);
+	if ( node_online(node))
+		return NOTIFY_OK;
+
+	switch(action) {
+		case CPU_DEAD:
+			write_lock_bh(&rt6_lock);
+			fib6_clean_tree(&ip6_routing_table, rt6_ref_xfr_node_down,
+					0, (void *)node);
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
@@ -1216,10 +1247,16 @@ void __init fib6_init(void)
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
Index: linux-2.6.12/net/ipv6/route.c
===================================================================
--- linux-2.6.12.orig/net/ipv6/route.c	2005-06-24 02:18:00.000000000 +0000
+++ linux-2.6.12/net/ipv6/route.c	2005-06-24 02:58:08.000000000 +0000
@@ -110,8 +110,6 @@ static struct dst_ops ip6_dst_ops = {
 struct rt6_info ip6_null_entry = {
 	.u = {
 		.dst = {
-			.__refcnt	= ATOMIC_INIT(1),
-			.__use		= 1,
 			.dev		= &loopback_dev,
 			.obsolete	= -1,
 			.error		= -ENETUNREACH,
@@ -2100,6 +2098,10 @@ void __init ip6_route_init(void)
 						     NULL, NULL);
 	if (!ip6_dst_ops.kmem_cachep)
 		panic("cannot create ip6_dst_cache");
+	if (dst_init_rtu_array(&ip6_null_entry.u.dst) < 0)
+		panic("ip6_route : can't allocate memory for dst-entry array");
+	dst_use_inc(&ipv6_null_entry.u.dist);
+	dst_refcnt_one(&ip6_null_entry.u.dst);
 
 	fib6_init();
 #ifdef 	CONFIG_PROC_FS
@@ -2126,4 +2128,5 @@ void ip6_route_cleanup(void)
 	rt6_ifdown(NULL);
 	fib6_gc_cleanup();
 	kmem_cache_destroy(ip6_dst_ops.kmem_cachep);
+	dst_free_rtu_array(&ip6_null_entry.u.dst);
 }
