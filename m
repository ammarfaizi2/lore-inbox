Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVFXDKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVFXDKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVFXDKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:10:51 -0400
Received: from graphe.net ([209.204.138.32]:39647 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263012AbVFXDE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:04:57 -0400
Date: Thu, 23 Jun 2005 20:04:52 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org
cc: linux-net@vger.kernel.org, davem@davemloft.net, shai@scalex86.org,
       akpm@osdl.org
Subject: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
Message-ID: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces macros to handle the use, lastuse and refcnt fiels in
the dst_entry structure using macros. Having macros manipulate these fields
allows cleaner source code and provides an easy way for modifications to the
way these performance critical fields are handled.

The introduction of macros removes some code that is repeated in 
various places. Also

- decnet_dn_route: introduces dn_dst_useful to check the usefulness of a dst
		entry. dst_update_rtu used to reduce code duplication.

- net/ipv4/route.c: add ip_rt_copy. dst_update_rtu used to reduce code duplication.

The patch also removes the atomic_dec_and_test in dst_destroy. The issue
was discussed a couple of weeks ago on netdev@oss.sgi.com in the following
thread:

http://marc.theaimsgroup.com/?t=111272752600001&r=1&w=2

The patch is a prerequisite for the dst numa patch. Patch against 
2.6.12-mm1.

Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off-by: Shobhit Dayal <shobhit@calsoftinc.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Christoph Lameter <christoph@scalex86.org>

Index: linux-2.6.12/include/net/dst.h
===================================================================
--- linux-2.6.12.orig/include/net/dst.h	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/include/net/dst.h	2005-06-24 03:00:51.000000000 +0000
@@ -103,6 +103,30 @@ struct dst_ops
 
 #ifdef __KERNEL__
 
+#define dst_use(__dst) (__dst)->__use
+#define dst_use_inc(__dst) (__dst)->__use++
+
+#define dst_lastuse(__dst) (__dst)->lastuse
+#define dst_lastuse_set(__dst) (__dst)->lastuse = jiffies
+
+#define dst_update_tu(__dst) do { dst_lastuse_set(__dst);dst_use_inc(__dst); } while (0)
+#define dst_update_rtu(__dst) do { dst_lastuse_set(__dst);dst_hold(__dst);dst_use_inc(__dst); } while (0)
+
+#define dst_refcnt(__dst) atomic_read(&(__dst)->__refcnt)
+#define dst_refcnt_one(__dst) atomic_set(&(__dst)->__refcnt, 1)
+#define dst_refcnt_dec(__dst) atomic_dec(&(__dst)->__refcnt)
+#define dst_hold(__dst) atomic_inc(&(__dst)->__refcnt)
+
+static inline
+void dst_release(struct dst_entry * dst)
+{
+	if (dst) {
+		WARN_ON(dst_refcnt(dst) < 1);
+		smp_mb__before_atomic_dec();
+		dst_refcnt_dec(dst);
+	}
+}
+
 static inline u32
 dst_metric(const struct dst_entry *dst, int metric)
 {
@@ -134,29 +158,14 @@ dst_metric_locked(struct dst_entry *dst,
 	return dst_metric(dst, RTAX_LOCK) & (1<<metric);
 }
 
-static inline void dst_hold(struct dst_entry * dst)
-{
-	atomic_inc(&dst->__refcnt);
-}
-
 static inline
 struct dst_entry * dst_clone(struct dst_entry * dst)
 {
 	if (dst)
-		atomic_inc(&dst->__refcnt);
+		dst_hold(dst);
 	return dst;
 }
 
-static inline
-void dst_release(struct dst_entry * dst)
-{
-	if (dst) {
-		WARN_ON(atomic_read(&dst->__refcnt) < 1);
-		smp_mb__before_atomic_dec();
-		atomic_dec(&dst->__refcnt);
-	}
-}
-
 /* Children define the path of the packet through the
  * Linux networking.  Thus, destinations are stackable.
  */
@@ -177,7 +186,7 @@ static inline void dst_free(struct dst_e
 {
 	if (dst->obsolete > 1)
 		return;
-	if (!atomic_read(&dst->__refcnt)) {
+	if (!dst_refcnt(dst)) {
 		dst = dst_destroy(dst);
 		if (!dst)
 			return;
Index: linux-2.6.12/net/core/dst.c
===================================================================
--- linux-2.6.12.orig/net/core/dst.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/core/dst.c	2005-06-24 03:00:51.000000000 +0000
@@ -56,7 +56,7 @@ static void dst_run_gc(unsigned long dum
 	del_timer(&dst_gc_timer);
 	dstp = &dst_garbage_list;
 	while ((dst = *dstp) != NULL) {
-		if (atomic_read(&dst->__refcnt)) {
+		if (dst_refcnt(dst)) {
 			dstp = &dst->next;
 			delayed++;
 			continue;
@@ -169,9 +169,8 @@ struct dst_entry *dst_destroy(struct dst
 	struct neighbour *neigh;
 	struct hh_cache *hh;
 
-	smp_rmb();
-
 again:
+	smp_rmb();
 	neigh = dst->neighbour;
 	hh = dst->hh;
 	child = dst->child;
@@ -199,16 +198,16 @@ again:
 	dst = child;
 	if (dst) {
 		int nohash = dst->flags & DST_NOHASH;
-
-		if (atomic_dec_and_test(&dst->__refcnt)) {
-			/* We were real parent of this dst, so kill child. */
-			if (nohash)
+		dst_refcnt_dec(dst);
+		if (nohash) {
+			if (!dst_refcnt(dst)) {
+				/* We were real parent of this dst, so kill child. */
 				goto again;
-		} else {
-			/* Child is still referenced, return it for freeing. */
-			if (nohash)
+			} else {
+				/* Child is still referenced, return it for freeing. */
 				return dst;
-			/* Child is still in his hash table */
+				/* Child is still in his hash table */
+			}
 		}
 	}
 	return NULL;
Index: linux-2.6.12/net/decnet/dn_route.c
===================================================================
--- linux-2.6.12.orig/net/decnet/dn_route.c	2005-06-21 04:01:33.000000000 +0000
+++ linux-2.6.12/net/decnet/dn_route.c	2005-06-24 03:00:51.000000000 +0000
@@ -155,6 +155,11 @@ static inline void dnrt_drop(struct dn_r
 	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
+static inline int dn_dst_useful(struct dn_route *rth, unsigned long now, unsigned long expire)
+{
+	return  (atomic_read(&rth->u.dst.__refcnt) || (now - rth->u.dst.lastuse) < expire) ;
+}
+
 static void dn_dst_check_expire(unsigned long dummy)
 {
 	int i;
@@ -167,8 +172,7 @@ static void dn_dst_check_expire(unsigned
 
 		spin_lock(&dn_rt_hash_table[i].lock);
 		while((rt=*rtp) != NULL) {
-			if (atomic_read(&rt->u.dst.__refcnt) ||
-					(now - rt->u.dst.lastuse) < expire) {
+			if (dn_dst_useful(rt, now, expire)) {
 				rtp = &rt->u.rt_next;
 				continue;
 			}
@@ -198,8 +202,7 @@ static int dn_dst_gc(void)
 		rtp = &dn_rt_hash_table[i].chain;
 
 		while((rt=*rtp) != NULL) {
-			if (atomic_read(&rt->u.dst.__refcnt) ||
-					(now - rt->u.dst.lastuse) < expire) {
+			if (dn_dst_useful(rt, now, expire)) {
 				rtp = &rt->u.rt_next;
 				continue;
 			}
@@ -277,10 +280,8 @@ static inline int compare_keys(struct fl
 static int dn_insert_route(struct dn_route *rt, unsigned hash, struct dn_route **rp)
 {
 	struct dn_route *rth, **rthp;
-	unsigned long now = jiffies;
-
-	rthp = &dn_rt_hash_table[hash].chain;
 
+ 	rthp = &dn_rt_hash_table[hash].chain;
 	spin_lock_bh(&dn_rt_hash_table[hash].lock);
 	while((rth = *rthp) != NULL) {
 		if (compare_keys(&rth->fl, &rt->fl)) {
@@ -290,9 +291,7 @@ static int dn_insert_route(struct dn_rou
 					   dn_rt_hash_table[hash].chain);
 			rcu_assign_pointer(dn_rt_hash_table[hash].chain, rth);
 
-			rth->u.dst.__use++;
-			dst_hold(&rth->u.dst);
-			rth->u.dst.lastuse = now;
+			dst_update_rtu(&rth->u.dst);
 			spin_unlock_bh(&dn_rt_hash_table[hash].lock);
 
 			dnrt_drop(rt);
@@ -304,10 +303,8 @@ static int dn_insert_route(struct dn_rou
 
 	rcu_assign_pointer(rt->u.rt_next, dn_rt_hash_table[hash].chain);
 	rcu_assign_pointer(dn_rt_hash_table[hash].chain, rt);
-	
-	dst_hold(&rt->u.dst);
-	rt->u.dst.__use++;
-	rt->u.dst.lastuse = now;
+
+	dst_update_rtu(&rt->u.dst);
 	spin_unlock_bh(&dn_rt_hash_table[hash].lock);
 	*rp = rt;
 	return 0;
@@ -1091,7 +1088,7 @@ make_route:
 	if (rt == NULL)
 		goto e_nobufs;
 
-	atomic_set(&rt->u.dst.__refcnt, 1);
+	dst_refcnt_one(&rt->u.dst);
 	rt->u.dst.flags   = DST_HOST;
 
 	rt->fl.fld_src    = oldflp->fld_src;
@@ -1115,7 +1112,7 @@ make_route:
 	rt->u.dst.neighbour = neigh;
 	neigh = NULL;
 
-	rt->u.dst.lastuse = jiffies;
+	dst_lastuse_set(&rt->u.dst);
 	rt->u.dst.output  = dn_output;
 	rt->u.dst.input   = dn_rt_bug;
 	rt->rt_flags      = flags;
@@ -1173,9 +1170,7 @@ static int __dn_route_output_key(struct 
 #endif
 			    (rt->fl.iif == 0) &&
 			    (rt->fl.oif == flp->oif)) {
-				rt->u.dst.lastuse = jiffies;
-				dst_hold(&rt->u.dst);
-				rt->u.dst.__use++;
+				dst_update_rtu(&rt->u.dst);
 				rcu_read_unlock_bh();
 				*pprt = &rt->u.dst;
 				return 0;
@@ -1381,7 +1376,7 @@ make_route:
 	rt->u.dst.flags = DST_HOST;
 	rt->u.dst.neighbour = neigh;
 	rt->u.dst.dev = out_dev;
-	rt->u.dst.lastuse = jiffies;
+	dst_lastuse_set(&rt->u.dst);
 	rt->u.dst.output = dn_rt_bug;
 	switch(res.type) {
 		case RTN_UNICAST:
@@ -1452,9 +1447,7 @@ int dn_route_input(struct sk_buff *skb)
 		    (rt->fl.fld_fwmark == skb->nfmark) &&
 #endif
 		    (rt->fl.iif == cb->iif)) {
-			rt->u.dst.lastuse = jiffies;
-			dst_hold(&rt->u.dst);
-			rt->u.dst.__use++;
+			dst_update_rtu(&rt->u.dst);
 			rcu_read_unlock();
 			skb->dst = (struct dst_entry *)rt;
 			return 0;
@@ -1504,9 +1497,9 @@ static int dn_rt_fill_info(struct sk_buf
 		RTA_PUT(skb, RTA_GATEWAY, 2, &rt->rt_gateway);
 	if (rtnetlink_put_metrics(skb, rt->u.dst.metrics) < 0)
 		goto rtattr_failure;
-	ci.rta_lastuse = jiffies_to_clock_t(jiffies - rt->u.dst.lastuse);
-	ci.rta_used     = rt->u.dst.__use;
-	ci.rta_clntref  = atomic_read(&rt->u.dst.__refcnt);
+	ci.rta_lastuse = jiffies_to_clock_t(jiffies - dst_lastuse(&rt->u.dst));
+	ci.rta_used     =  dst_use(&rt->u.dst);
+	ci.rta_clntref  = dst_refcnt(&rt->u.dst);
 	if (rt->u.dst.expires)
 		ci.rta_expires = jiffies_to_clock_t(rt->u.dst.expires - jiffies);
 	else
@@ -1729,8 +1722,8 @@ static int dn_rt_cache_seq_show(struct s
 			rt->u.dst.dev ? rt->u.dst.dev->name : "*",
 			dn_addr2asc(dn_ntohs(rt->rt_daddr), buf1),
 			dn_addr2asc(dn_ntohs(rt->rt_saddr), buf2),
-			atomic_read(&rt->u.dst.__refcnt),
-			rt->u.dst.__use,
+			dst_refcnt(&rt->u.dst),
+			dst_use(&rt->u.dst),
 			(int) dst_metric(&rt->u.dst, RTAX_RTT));
 	return 0;
 } 
Index: linux-2.6.12/net/ipv4/ipvs/ip_vs_xmit.c
===================================================================
--- linux-2.6.12.orig/net/ipv4/ipvs/ip_vs_xmit.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/ipv4/ipvs/ip_vs_xmit.c	2005-06-24 02:18:00.000000000 +0000
@@ -88,7 +88,7 @@ __ip_vs_get_out_rt(struct ip_vs_conn *cp
 			__ip_vs_dst_set(dest, rtos, dst_clone(&rt->u.dst));
 			IP_VS_DBG(10, "new dst %u.%u.%u.%u, refcnt=%d, rtos=%X\n",
 				  NIPQUAD(dest->addr),
-				  atomic_read(&rt->u.dst.__refcnt), rtos);
+				  dst_refcnt(&rt->u.dst), rtos);
 		}
 		spin_unlock(&dest->dst_lock);
 	} else {
Index: linux-2.6.12/net/ipv4/multipath_drr.c
===================================================================
--- linux-2.6.12.orig/net/ipv4/multipath_drr.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/ipv4/multipath_drr.c	2005-06-24 02:18:00.000000000 +0000
@@ -149,8 +149,7 @@ static void drr_select_route(const struc
 		    multipath_comparekeys(&nh->fl, flp)) {
 			int nh_ifidx = nh->u.dst.dev->ifindex;
 
-			nh->u.dst.lastuse = jiffies;
-			nh->u.dst.__use++;
+			dst_update_tu(&nh->u.dst);
 			if (result != NULL)
 				continue;
 
Index: linux-2.6.12/net/ipv4/multipath_random.c
===================================================================
--- linux-2.6.12.orig/net/ipv4/multipath_random.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/ipv4/multipath_random.c	2005-06-24 02:18:00.000000000 +0000
@@ -94,7 +94,8 @@ static void random_select_route(const st
 		for (rt = first; rt; rt = rt->u.rt_next) {
 			if ((rt->u.dst.flags & DST_BALANCED) != 0 &&
 			    multipath_comparekeys(&rt->fl, flp)) {
-				rt->u.dst.lastuse = jiffies;
+
+				dst_lastuse_set(&rt->u.dst);
 
 				if (i == candidate_no)
 					decision = rt;
@@ -107,7 +108,7 @@ static void random_select_route(const st
 		}
 	}
 
-	decision->u.dst.__use++;
+	dst_use_inc(&decision->u.dst);
 	*rp = decision;
 }
 
Index: linux-2.6.12/net/ipv4/multipath_rr.c
===================================================================
--- linux-2.6.12.orig/net/ipv4/multipath_rr.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/ipv4/multipath_rr.c	2005-06-24 02:18:00.000000000 +0000
@@ -62,10 +62,11 @@ static void rr_select_route(const struct
  	     nh = rcu_dereference(nh->u.rt_next)) {
 		if ((nh->u.dst.flags & DST_BALANCED) != 0 &&
 		    multipath_comparekeys(&nh->fl, flp)) {
-			nh->u.dst.lastuse = jiffies;
+			int __use = dst_use(&nh->u.dst);
+			dst_lastuse_set(&nh->u.dst);
 
-			if (min_use == -1 || nh->u.dst.__use < min_use) {
-				min_use = nh->u.dst.__use;
+			if (min_use == -1 || __use < min_use) {
+				min_use = __use;
 				min_use_cand = nh;
 			}
 		}
@@ -74,7 +75,7 @@ static void rr_select_route(const struct
 	if (!result)
 		result = first;
 
-	result->u.dst.__use++;
+	dst_use_inc(&result->u.dst);
 	*rp = result;
 }
 
Index: linux-2.6.12/net/ipv4/multipath_wrandom.c
===================================================================
--- linux-2.6.12.orig/net/ipv4/multipath_wrandom.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/ipv4/multipath_wrandom.c	2005-06-24 02:18:00.000000000 +0000
@@ -202,7 +202,7 @@ static void wrandom_select_route(const s
 	decision = first;
 	last_mpc = NULL;
 	for (mpc = first_mpc; mpc; mpc = mpc->next) {
-		mpc->rt->u.dst.lastuse = jiffies;
+		dst_lastuse_set(&mpc->rt->u.dst);
 		if (last_power <= selector && selector < mpc->power)
 			decision = mpc->rt;
 
@@ -217,8 +217,7 @@ static void wrandom_select_route(const s
 		/* concurrent __multipath_flush may lead to !last_mpc */
 		kfree(last_mpc);
 	}
-
-	decision->u.dst.__use++;
+	dst_use_inc(&decision->u.dst);
 	*rp = decision;
 }
 
Index: linux-2.6.12/net/ipv4/route.c
===================================================================
--- linux-2.6.12.orig/net/ipv4/route.c	2005-06-21 04:01:33.000000000 +0000
+++ linux-2.6.12/net/ipv4/route.c	2005-06-24 03:00:51.000000000 +0000
@@ -303,8 +303,8 @@ static int rt_cache_seq_show(struct seq_
 			      "%08lX\t%d\t%u\t%u\t%02X\t%d\t%1d\t%08X",
 			r->u.dst.dev ? r->u.dst.dev->name : "*",
 			(unsigned long)r->rt_dst, (unsigned long)r->rt_gateway,
-			r->rt_flags, atomic_read(&r->u.dst.__refcnt),
-			r->u.dst.__use, 0, (unsigned long)r->rt_src,
+			r->rt_flags, dst_refcnt(&r->u.dst),
+			dst_use(&r->u.dst), 0, (unsigned long)r->rt_src,
 			(dst_metric(&r->u.dst, RTAX_ADVMSS) ?
 			     (int)dst_metric(&r->u.dst, RTAX_ADVMSS) + 40 : 0),
 			dst_metric(&r->u.dst, RTAX_WINDOW),
@@ -481,7 +481,7 @@ static int rt_may_expire(struct rtable *
 	unsigned long age;
 	int ret = 0;
 
-	if (atomic_read(&rth->u.dst.__refcnt))
+	if (dst_refcnt(&rth->u.dst))
 		goto out;
 
 	ret = 1;
@@ -505,7 +505,7 @@ out:	return ret;
  */
 static inline u32 rt_score(struct rtable *rt)
 {
-	u32 score = jiffies - rt->u.dst.lastuse;
+	u32 score = jiffies - dst_lastuse(&rt->u.dst);
 
 	score = ~score & ~(3<<30);
 
@@ -905,9 +905,8 @@ restart:
 			 */
 			rcu_assign_pointer(rt_hash_table[hash].chain, rth);
 
-			rth->u.dst.__use++;
-			dst_hold(&rth->u.dst);
-			rth->u.dst.lastuse = now;
+			dst_update_rtu(&rth->u.dst);
+
 			spin_unlock_bh(&rt_hash_table[hash].lock);
 
 			rt_drop(rt);
@@ -915,7 +914,7 @@ restart:
 			return 0;
 		}
 
-		if (!atomic_read(&rth->u.dst.__refcnt)) {
+		if (!dst_refcnt(&rth->u.dst)) {
 			u32 score = rt_score(rth);
 
 			if (score <= min_score) {
@@ -1070,6 +1069,12 @@ static void rt_del(unsigned hash, struct
 	spin_unlock_bh(&rt_hash_table[hash].lock);
 }
 
+void ip_rt_copy(struct rtable *to, struct rtable *from)
+{
+	*to = *from;
+	to->u.dst.__use 	= 1;
+}
+
 void ip_rt_redirect(u32 old_gw, u32 daddr, u32 new_gw,
 		    u32 saddr, u8 tos, struct net_device *dev)
 {
@@ -1137,17 +1142,17 @@ void ip_rt_redirect(u32 old_gw, u32 dadd
 				}
 
 				/* Copy all the information. */
-				*rt = *rth;
- 				INIT_RCU_HEAD(&rt->u.dst.rcu_head);
-				rt->u.dst.__use		= 1;
-				atomic_set(&rt->u.dst.__refcnt, 1);
+				ip_rt_copy(rt, rth);
+
+				INIT_RCU_HEAD(&rt->u.dst.rcu_head);
+				dst_lastuse_set(&rt->u.dst);
+				dst_refcnt_one(&rt->u.dst);
 				rt->u.dst.child		= NULL;
 				if (rt->u.dst.dev)
 					dev_hold(rt->u.dst.dev);
 				if (rt->idev)
 					in_dev_hold(rt->idev);
 				rt->u.dst.obsolete	= 0;
-				rt->u.dst.lastuse	= jiffies;
 				rt->u.dst.path		= &rt->u.dst;
 				rt->u.dst.neighbour	= NULL;
 				rt->u.dst.hh		= NULL;
@@ -1581,7 +1586,7 @@ static int ip_route_input_mc(struct sk_b
 
 	rth->u.dst.output= ip_rt_bug;
 
-	atomic_set(&rth->u.dst.__refcnt, 1);
+	dst_refcnt_one(&rth->u.dst);
 	rth->u.dst.flags= DST_HOST;
 	if (in_dev->cnf.no_policy)
 		rth->u.dst.flags |= DST_NOPOLICY;
@@ -1780,7 +1785,7 @@ static inline int ip_mkroute_input_def(s
 	err = __mkroute_input(skb, res, in_dev, daddr, saddr, tos, &rth);
 	if (err)
 		return err;
-	atomic_set(&rth->u.dst.__refcnt, 1);
+	dst_refcnt_one(&rth->u.dst);
 
 	/* put it into the cache */
 	hash = rt_hash_code(daddr, saddr ^ (fl->iif << 5), tos);
@@ -1838,7 +1843,7 @@ static inline int ip_mkroute_input(struc
 		 * outside
 		 */
 		if (hop == lasthop)
-			atomic_set(&(skb->dst->__refcnt), 1);
+			dst_refcnt_one(skb->dst);
 	}
 	return err;
 #else /* CONFIG_IP_ROUTE_MULTIPATH_CACHED  */
@@ -1974,7 +1979,7 @@ local_input:
 
 	rth->u.dst.output= ip_rt_bug;
 
-	atomic_set(&rth->u.dst.__refcnt, 1);
+	dst_refcnt_one(&rth->u.dst);
 	rth->u.dst.flags= DST_HOST;
 	if (in_dev->cnf.no_policy)
 		rth->u.dst.flags |= DST_NOPOLICY;
@@ -2059,9 +2064,7 @@ int ip_route_input(struct sk_buff *skb, 
 		    rth->fl.fl4_fwmark == skb->nfmark &&
 #endif
 		    rth->fl.fl4_tos == tos) {
-			rth->u.dst.lastuse = jiffies;
-			dst_hold(&rth->u.dst);
-			rth->u.dst.__use++;
+			dst_update_rtu(&rth->u.dst);
 			RT_CACHE_STAT_INC(in_hit);
 			rcu_read_unlock();
 			skb->dst = (struct dst_entry*)rth;
@@ -2245,7 +2248,7 @@ static inline int ip_mkroute_output_def(
 	if (err == 0) {
 		u32 tos = RT_FL_TOS(oldflp);
 
-		atomic_set(&rth->u.dst.__refcnt, 1);
+		dst_refcnt_one(&rth->u.dst);
 		
 		hash = rt_hash_code(oldflp->fl4_dst, 
 				    oldflp->fl4_src ^ (oldflp->oif << 5), tos);
@@ -2305,7 +2308,7 @@ static inline int ip_mkroute_output(stru
 			if (err != 0)
 				return err;
 		}
-		atomic_set(&(*rp)->u.dst.__refcnt, 1);
+		dst_refcnt_one(&(*rp)->u.dst);
 		return err;
 	} else {
 		return ip_mkroute_output_def(rp, res, fl, oldflp, dev_out,
@@ -2541,10 +2544,7 @@ int __ip_route_output_key(struct rtable 
 				rcu_read_unlock_bh();
 				return 0;
 			}
-
-			rth->u.dst.lastuse = jiffies;
-			dst_hold(&rth->u.dst);
-			rth->u.dst.__use++;
+			dst_update_rtu(&rth->u.dst);
 			RT_CACHE_STAT_INC(out_hit);
 			rcu_read_unlock_bh();
 			*rp = rth;
@@ -2630,9 +2630,9 @@ static int rt_fill_info(struct sk_buff *
 		RTA_PUT(skb, RTA_GATEWAY, 4, &rt->rt_gateway);
 	if (rtnetlink_put_metrics(skb, rt->u.dst.metrics) < 0)
 		goto rtattr_failure;
-	ci.rta_lastuse	= jiffies_to_clock_t(jiffies - rt->u.dst.lastuse);
-	ci.rta_used	= rt->u.dst.__use;
-	ci.rta_clntref	= atomic_read(&rt->u.dst.__refcnt);
+	ci.rta_lastuse	= jiffies_to_clock_t(jiffies - dst_lastuse(&rt->u.dst));
+	ci.rta_used	= dst_use(&rt->u.dst);
+	ci.rta_clntref	= dst_refcnt(&rt->u.dst);
 	if (rt->u.dst.expires)
 		ci.rta_expires = jiffies_to_clock_t(rt->u.dst.expires - jiffies);
 	else
Index: linux-2.6.12/net/ipv4/xfrm4_policy.c
===================================================================
--- linux-2.6.12.orig/net/ipv4/xfrm4_policy.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/ipv4/xfrm4_policy.c	2005-06-24 02:18:00.000000000 +0000
@@ -135,7 +135,7 @@ __xfrm4_bundle_create(struct xfrm_policy
 			dev_hold(rt->u.dst.dev);
 		dst_prev->obsolete	= -1;
 		dst_prev->flags	       |= DST_HOST;
-		dst_prev->lastuse	= jiffies;
+		dst_lastuse_set(dst_prev);
 		dst_prev->header_len	= header_len;
 		dst_prev->trailer_len	= trailer_len;
 		memcpy(&dst_prev->metrics, &x->route->metrics, sizeof(dst_prev->metrics));
Index: linux-2.6.12/net/ipv6/ip6_fib.c
===================================================================
--- linux-2.6.12.orig/net/ipv6/ip6_fib.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/ipv6/ip6_fib.c	2005-06-24 03:00:51.000000000 +0000
@@ -1159,8 +1159,8 @@ static int fib6_age(struct rt6_info *rt,
 		}
 		gc_args.more++;
 	} else if (rt->rt6i_flags & RTF_CACHE) {
-		if (atomic_read(&rt->u.dst.__refcnt) == 0 &&
-		    time_after_eq(now, rt->u.dst.lastuse + gc_args.timeout)) {
+		if (dst_refcnt(&rt->u.dst) == 0 &&
+		    time_after_eq(now, dst_lastuse(&rt->u.dst) + gc_args.timeout)) {
 			RT6_TRACE("aging clone %p\n", rt);
 			return -1;
 		} else if ((rt->rt6i_flags & RTF_GATEWAY) &&
Index: linux-2.6.12/net/ipv6/route.c
===================================================================
--- linux-2.6.12.orig/net/ipv6/route.c	2005-06-21 04:01:33.000000000 +0000
+++ linux-2.6.12/net/ipv6/route.c	2005-06-24 03:00:51.000000000 +0000
@@ -368,10 +368,9 @@ struct rt6_info *rt6_lookup(struct in6_a
 	fn = fib6_lookup(&ip6_routing_table, daddr, saddr);
 	rt = rt6_device_match(fn->leaf, oif, strict);
 	dst_hold(&rt->u.dst);
-	rt->u.dst.__use++;
-	read_unlock_bh(&rt6_lock);
 
-	rt->u.dst.lastuse = jiffies;
+	read_unlock_bh(&rt6_lock);
+	dst_update_tu(&rt->u.dst);
 	if (rt->u.dst.error == 0)
 		return rt;
 	dst_release(&rt->u.dst);
@@ -510,8 +509,7 @@ restart:
 out:
 	read_unlock_bh(&rt6_lock);
 out2:
-	rt->u.dst.lastuse = jiffies;
-	rt->u.dst.__use++;
+	dst_update_tu(&rt->u.dst);
 	skb->dst = (struct dst_entry *) rt;
 }
 
@@ -570,8 +568,7 @@ restart:
 out:
 	read_unlock_bh(&rt6_lock);
 out2:
-	rt->u.dst.lastuse = jiffies;
-	rt->u.dst.__use++;
+	dst_update_tu(&rt->u.dst);
 	return &rt->u.dst;
 }
 
@@ -683,7 +680,7 @@ struct dst_entry *ndisc_dst_alloc(struct
 	rt->rt6i_dev	  = dev;
 	rt->rt6i_idev     = idev;
 	rt->rt6i_nexthop  = neigh;
-	atomic_set(&rt->u.dst.__refcnt, 1);
+	dst_refcnt_one(&rt->u.dst);
 	rt->u.dst.metrics[RTAX_HOPLIMIT-1] = 255;
 	rt->u.dst.metrics[RTAX_MTU-1] = ipv6_get_mtu(rt->rt6i_dev);
 	rt->u.dst.metrics[RTAX_ADVMSS-1] = ipv6_advmss(dst_mtu(&rt->u.dst));
@@ -717,7 +714,7 @@ int ndisc_dst_gc(int *more)
 	pprev = &ndisc_dst_gc_list;
 	freed = 0;
 	while ((dst = *pprev) != NULL) {
-		if (!atomic_read(&dst->__refcnt)) {
+		if (!dst_refcnt(dst)) {
 			*pprev = dst->next;
 			dst_free(dst);
 			freed++;
@@ -1258,7 +1255,7 @@ static struct rt6_info * ip6_rt_copy(str
 		rt->rt6i_idev = ort->rt6i_idev;
 		if (rt->rt6i_idev)
 			in6_dev_hold(rt->rt6i_idev);
-		rt->u.dst.lastuse = jiffies;
+		dst_lastuse_set(&rt->u.dst);
 		rt->rt6i_expires = 0;
 
 		ipv6_addr_copy(&rt->rt6i_gateway, &ort->rt6i_gateway);
@@ -1421,7 +1418,7 @@ struct rt6_info *addrconf_dst_alloc(stru
 	ipv6_addr_copy(&rt->rt6i_dst.addr, addr);
 	rt->rt6i_dst.plen = 128;
 
-	atomic_set(&rt->u.dst.__refcnt, 1);
+	dst_refcnt_one(&rt->u.dst);
 
 	return rt;
 }
@@ -1641,13 +1638,13 @@ static int rt6_fill_node(struct sk_buff 
 	if (rt->u.dst.dev)
 		RTA_PUT(skb, RTA_OIF, sizeof(int), &rt->rt6i_dev->ifindex);
 	RTA_PUT(skb, RTA_PRIORITY, 4, &rt->rt6i_metric);
-	ci.rta_lastuse = jiffies_to_clock_t(jiffies - rt->u.dst.lastuse);
+	ci.rta_lastuse = jiffies_to_clock_t(jiffies - dst_lastuse(&rt->u.dst));
 	if (rt->rt6i_expires)
 		ci.rta_expires = jiffies_to_clock_t(rt->rt6i_expires - jiffies);
 	else
 		ci.rta_expires = 0;
-	ci.rta_used = rt->u.dst.__use;
-	ci.rta_clntref = atomic_read(&rt->u.dst.__refcnt);
+	ci.rta_used = dst_use(&rt->u.dst);
+	ci.rta_clntref = dst_refcnt(&rt->u.dst);
 	ci.rta_error = rt->u.dst.error;
 	ci.rta_id = 0;
 	ci.rta_ts = 0;
@@ -1923,8 +1920,8 @@ static int rt6_info_route(struct rt6_inf
 	}
 	arg->len += sprintf(arg->buffer + arg->len,
 			    " %08x %08x %08x %08x %8s\n",
-			    rt->rt6i_metric, atomic_read(&rt->u.dst.__refcnt),
-			    rt->u.dst.__use, rt->rt6i_flags, 
+			    rt->rt6i_metric, dst_refcnt(&rt->u.dst),
+			    dst_use(&rt->u.dst), rt->rt6i_flags,
 			    rt->rt6i_dev ? rt->rt6i_dev->name : "");
 	return 0;
 }
Index: linux-2.6.12/net/ipv6/xfrm6_policy.c
===================================================================
--- linux-2.6.12.orig/net/ipv6/xfrm6_policy.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/net/ipv6/xfrm6_policy.c	2005-06-24 02:18:00.000000000 +0000
@@ -156,7 +156,7 @@ __xfrm6_bundle_create(struct xfrm_policy
 			dev_hold(rt->u.dst.dev);
 		dst_prev->obsolete	= -1;
 		dst_prev->flags	       |= DST_HOST;
-		dst_prev->lastuse	= jiffies;
+		dst_lastuse_set(dst_prev);
 		dst_prev->header_len	= header_len;
 		dst_prev->trailer_len	= trailer_len;
 		memcpy(&dst_prev->metrics, &x->route->metrics, sizeof(dst_prev->metrics));
Index: linux-2.6.12/net/xfrm/xfrm_policy.c
===================================================================
--- linux-2.6.12.orig/net/xfrm/xfrm_policy.c	2005-06-21 04:01:33.000000000 +0000
+++ linux-2.6.12/net/xfrm/xfrm_policy.c	2005-06-24 02:18:00.000000000 +0000
@@ -1091,7 +1091,7 @@ static void xfrm_prune_bundles(int (*fun
 
 static int unused_bundle(struct dst_entry *dst)
 {
-	return !atomic_read(&dst->__refcnt);
+	return !dst_refcnt(dst);
 }
 
 static void __xfrm_garbage_collect(void)
