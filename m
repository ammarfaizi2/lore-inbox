Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSLPNqg>; Mon, 16 Dec 2002 08:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSLPNqg>; Mon, 16 Dec 2002 08:46:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3263 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266721AbSLPNqb>;
	Mon, 16 Dec 2002 08:46:31 -0500
Date: Mon, 16 Dec 2002 19:22:12 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: "David S. Miller " <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev <netdev@oss.sgi.com>,
       dipankar@in.ibm.com, Andrew Morton <akpm@digeo.com>
Subject: [patch] Make rt_cache_stat use kmalloc_percpu
Message-ID: <20021216192212.C26076@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here's another patch to use kmalloc_percpu.  As usual, this removes
NR_CPUS bloat, can work when modulized and helps node local allocation.

Thanks,
Kiran

D: Name: rtstats-2.5.52-1.patch
D: Author: Ravikiran Thirumalai
D: Description: Make rt_cache_stat use kmalloc_percpu


 include/net/route.h |    6 +++-
 net/ipv4/route.c    |   71 +++++++++++++++++++++++++++++-----------------------
 2 files changed, 45 insertions(+), 32 deletions(-)


diff -ruN -X dontdiff linux-2.5.52/include/net/route.h rtstats-2.5.52/include/net/route.h
--- linux-2.5.52/include/net/route.h	Mon Dec 16 07:37:42 2002
+++ rtstats-2.5.52/include/net/route.h	Mon Dec 16 14:56:01 2002
@@ -102,7 +102,11 @@
         unsigned int gc_ignored;
         unsigned int gc_goal_miss;
         unsigned int gc_dst_overflow;
-} ____cacheline_aligned_in_smp;
+};
+
+extern struct rt_cache_stat *rt_cache_stat;
+#define RT_CACHE_STAT_INC(field)					  \
+		(per_cpu_ptr(rt_cache_stat, smp_processor_id())->field++)
 
 extern struct ip_rt_acct *ip_rt_acct;
 
diff -ruN -X dontdiff linux-2.5.52/net/ipv4/route.c rtstats-2.5.52/net/ipv4/route.c
--- linux-2.5.52/net/ipv4/route.c	Mon Dec 16 07:38:23 2002
+++ rtstats-2.5.52/net/ipv4/route.c	Mon Dec 16 16:14:09 2002
@@ -195,7 +195,7 @@
 static unsigned			rt_hash_mask;
 static int			rt_hash_log;
 
-struct rt_cache_stat rt_cache_stat[NR_CPUS];
+struct rt_cache_stat *rt_cache_stat;
 
 static int rt_intern_hash(unsigned hash, struct rtable *rth,
 				struct rtable **res);
@@ -319,24 +319,26 @@
 	int len = 0;
 
 	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
 		len += sprintf(buffer+len, "%08x  %08x %08x %08x %08x %08x %08x %08x  %08x %08x %08x %08x %08x %08x %08x \n",
 			       dst_entries,		       
-			       rt_cache_stat[i].in_hit,
-			       rt_cache_stat[i].in_slow_tot,
-			       rt_cache_stat[i].in_slow_mc,
-			       rt_cache_stat[i].in_no_route,
-			       rt_cache_stat[i].in_brd,
-			       rt_cache_stat[i].in_martian_dst,
-			       rt_cache_stat[i].in_martian_src,
-
-			       rt_cache_stat[i].out_hit,
-			       rt_cache_stat[i].out_slow_tot,
-			       rt_cache_stat[i].out_slow_mc, 
-
-			       rt_cache_stat[i].gc_total,
-			       rt_cache_stat[i].gc_ignored,
-			       rt_cache_stat[i].gc_goal_miss,
-			       rt_cache_stat[i].gc_dst_overflow
+			       per_cpu_ptr(rt_cache_stat, i)->in_hit,
+			       per_cpu_ptr(rt_cache_stat, i)->in_slow_tot,
+			       per_cpu_ptr(rt_cache_stat, i)->in_slow_mc,
+			       per_cpu_ptr(rt_cache_stat, i)->in_no_route,
+			       per_cpu_ptr(rt_cache_stat, i)->in_brd,
+			       per_cpu_ptr(rt_cache_stat, i)->in_martian_dst,
+			       per_cpu_ptr(rt_cache_stat, i)->in_martian_src,
+
+			       per_cpu_ptr(rt_cache_stat, i)->out_hit,
+			       per_cpu_ptr(rt_cache_stat, i)->out_slow_tot,
+			       per_cpu_ptr(rt_cache_stat, i)->out_slow_mc, 
+
+			       per_cpu_ptr(rt_cache_stat, i)->gc_total,
+			       per_cpu_ptr(rt_cache_stat, i)->gc_ignored,
+			       per_cpu_ptr(rt_cache_stat, i)->gc_goal_miss,
+			       per_cpu_ptr(rt_cache_stat, i)->gc_dst_overflow
 
 			);
 	}
@@ -592,11 +594,11 @@
 	 * do not make it too frequently.
 	 */
 
-	rt_cache_stat[smp_processor_id()].gc_total++;
+	RT_CACHE_STAT_INC(gc_total);
 
 	if (now - last_gc < ip_rt_gc_min_interval &&
 	    atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size) {
-		rt_cache_stat[smp_processor_id()].gc_ignored++;
+		RT_CACHE_STAT_INC(gc_ignored);
 		goto out;
 	}
 
@@ -664,7 +666,7 @@
 		     We will not spin here for long time in any case.
 		 */
 
-		rt_cache_stat[smp_processor_id()].gc_goal_miss++;
+		RT_CACHE_STAT_INC(gc_goal_miss);
 
 		if (expire == 0)
 			break;
@@ -683,7 +685,7 @@
 		goto out;
 	if (net_ratelimit())
 		printk(KERN_WARNING "dst cache overflow\n");
-	rt_cache_stat[smp_processor_id()].gc_dst_overflow++;
+	RT_CACHE_STAT_INC(gc_dst_overflow);
 	return 1;
 
 work_done:
@@ -1387,7 +1389,7 @@
 	if (!LOCAL_MCAST(daddr) && IN_DEV_MFORWARD(in_dev))
 		rth->u.dst.input = ip_mr_input;
 #endif
-	rt_cache_stat[smp_processor_id()].in_slow_mc++;
+	RT_CACHE_STAT_INC(in_slow_mc);
 
 	in_dev_put(in_dev);
 	hash = rt_hash_code(daddr, saddr ^ (dev->ifindex << 5), tos);
@@ -1472,7 +1474,7 @@
 	}
 	free_res = 1;
 
-	rt_cache_stat[smp_processor_id()].in_slow_tot++;
+	RT_CACHE_STAT_INC(in_slow_tot);
 
 #ifdef CONFIG_IP_ROUTE_NAT
 	/* Policy is applied before mapping destination,
@@ -1629,7 +1631,7 @@
 	}
 	flags |= RTCF_BROADCAST;
 	res.type = RTN_BROADCAST;
-	rt_cache_stat[smp_processor_id()].in_brd++;
+	RT_CACHE_STAT_INC(in_brd);
 
 local_input:
 	rth = dst_alloc(&ipv4_dst_ops);
@@ -1674,7 +1676,7 @@
 	goto intern;
 
 no_route:
-	rt_cache_stat[smp_processor_id()].in_no_route++;
+	RT_CACHE_STAT_INC(in_no_route);
 	spec_dst = inet_select_addr(dev, 0, RT_SCOPE_UNIVERSE);
 	res.type = RTN_UNREACHABLE;
 	goto local_input;
@@ -1683,7 +1685,7 @@
 	 *	Do not cache martian addresses: they should be logged (RFC1812)
 	 */
 martian_destination:
-	rt_cache_stat[smp_processor_id()].in_martian_dst++;
+	RT_CACHE_STAT_INC(in_martian_dst);
 #ifdef CONFIG_IP_ROUTE_VERBOSE
 	if (IN_DEV_LOG_MARTIANS(in_dev) && net_ratelimit())
 		printk(KERN_WARNING "martian destination %u.%u.%u.%u from "
@@ -1700,7 +1702,7 @@
 
 martian_source:
 
-	rt_cache_stat[smp_processor_id()].in_martian_src++;
+	RT_CACHE_STAT_INC(in_martian_src);
 #ifdef CONFIG_IP_ROUTE_VERBOSE
 	if (IN_DEV_LOG_MARTIANS(in_dev) && net_ratelimit()) {
 		/*
@@ -1749,7 +1751,7 @@
 			rth->u.dst.lastuse = jiffies;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
-			rt_cache_stat[smp_processor_id()].in_hit++;
+			RT_CACHE_STAT_INC(in_hit);
 			read_unlock(&rt_hash_table[hash].lock);
 			skb->dst = (struct dst_entry*)rth;
 			return 0;
@@ -2046,7 +2048,7 @@
 
 	rth->u.dst.output=ip_output;
 
-	rt_cache_stat[smp_processor_id()].out_slow_tot++;
+	RT_CACHE_STAT_INC(out_slow_tot);
 
 	if (flags & RTCF_LOCAL) {
 		rth->u.dst.input = ip_local_deliver;
@@ -2056,7 +2058,7 @@
 		rth->rt_spec_dst = fl.fl4_src;
 		if (flags & RTCF_LOCAL && !(dev_out->flags & IFF_LOOPBACK)) {
 			rth->u.dst.output = ip_mc_output;
-			rt_cache_stat[smp_processor_id()].out_slow_mc++;
+			RT_CACHE_STAT_INC(out_slow_mc);
 		}
 #ifdef CONFIG_IP_MROUTE
 		if (res.type == RTN_MULTICAST) {
@@ -2114,7 +2116,7 @@
 			rth->u.dst.lastuse = jiffies;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
-			rt_cache_stat[smp_processor_id()].out_hit++;
+			RT_CACHE_STAT_INC(out_hit);
 			read_unlock_bh(&rt_hash_table[hash].lock);
 			*rp = rth;
 			return 0;
@@ -2634,6 +2636,11 @@
 	ipv4_dst_ops.gc_thresh = (rt_hash_mask + 1);
 	ip_rt_max_size = (rt_hash_mask + 1) * 16;
 
+	rt_cache_stat = kmalloc_percpu(sizeof (struct rt_cache_stat),
+					GFP_KERNEL);
+	if (!rt_cache_stat) 
+		goto out_enomem1;
+
 	devinet_init();
 	ip_fib_init();
 
@@ -2659,6 +2666,8 @@
 out:
 	return rc;
 out_enomem:
+	kfree_percpu(rt_cache_stat);
+out_enomem1:
 	rc = -ENOMEM;
 	goto out;
 }
