Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUJWUrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUJWUrq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUJWUrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:47:45 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:50829 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261308AbUJWUop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:44:45 -0400
Date: Sat, 23 Oct 2004 13:39:39 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dipankar@in.ibm.com, spraul@dbl.q-ag.de, rusty@au1.ibm.com,
       shemminger@osdl.org
Subject: [PATCH 2/3] RCU: rcu_assign_pointer() removal of memory barriers
Message-ID: <20041023203939.GA4738@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the rcu_assign_pointer() API to eliminate a number
of explicit memory barriers from code using RCU.  This has been
tested successfully on i386 and ppc64.

Signed-off-by: <paulmck@us.ibm.com>

---

 arch/x86_64/kernel/mce.c |    3 +--
 include/linux/list.h     |    2 --
 net/core/netfilter.c     |    3 +--
 net/decnet/dn_route.c    |   13 +++++--------
 net/ipv4/devinet.c       |    3 +--
 net/ipv4/route.c         |    7 +++----
 net/sched/sch_api.c      |    3 +--
 7 files changed, 12 insertions(+), 22 deletions(-)

diff -urpN -X ../dontdiff linux-2.5/arch/x86_64/kernel/mce.c linux-2.5-rap/arch/x86_64/kernel/mce.c
--- linux-2.5/arch/x86_64/kernel/mce.c	Tue Sep  7 10:02:15 2004
+++ linux-2.5-rap/arch/x86_64/kernel/mce.c	Tue Sep  7 10:29:18 2004
@@ -358,8 +358,7 @@ static ssize_t mce_read(struct file *fil
 
 	memset(mcelog.entry, 0, next * sizeof(struct mce));
 	mcelog.next = 0;
-	smp_wmb(); 
-	
+
 	synchronize_kernel();	
 
 	/* Collect entries that were still getting written before the synchronize. */
diff -urpN -X ../dontdiff linux-2.5/include/linux/list.h linux-2.5-rap/include/linux/list.h
--- linux-2.5/include/linux/list.h	Tue Sep  7 10:04:28 2004
+++ linux-2.5-rap/include/linux/list.h	Tue Sep  7 10:42:56 2004
@@ -553,8 +553,6 @@ static inline void hlist_del_init(struct
 	}
 }
 
-#define hlist_del_rcu_init hlist_del_init
-
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
diff -urpN -X ../dontdiff linux-2.5/net/core/netfilter.c linux-2.5-rap/net/core/netfilter.c
--- linux-2.5/net/core/netfilter.c	Tue Sep  7 10:04:41 2004
+++ linux-2.5-rap/net/core/netfilter.c	Tue Sep  7 10:29:20 2004
@@ -751,10 +751,9 @@ int nf_log_register(int pf, nf_logfn *lo
 
 	/* Any setup of logging members must be done before
 	 * substituting pointer. */
-	smp_wmb();
 	spin_lock(&nf_log_lock);
 	if (!nf_logging[pf]) {
-		nf_logging[pf] = logfn;
+		rcu_assign_pointer(nf_logging[pf], logfn);
 		ret = 0;
 	}
 	spin_unlock(&nf_log_lock);
diff -urpN -X ../dontdiff linux-2.5/net/decnet/dn_route.c linux-2.5-rap/net/decnet/dn_route.c
--- linux-2.5/net/decnet/dn_route.c	Tue Sep  7 10:04:41 2004
+++ linux-2.5-rap/net/decnet/dn_route.c	Tue Sep  7 10:29:24 2004
@@ -287,10 +287,9 @@ static int dn_insert_route(struct dn_rou
 		if (compare_keys(&rth->fl, &rt->fl)) {
 			/* Put it first */
 			*rthp = rth->u.rt_next;
-			smp_wmb();
-			rth->u.rt_next = dn_rt_hash_table[hash].chain;
-			smp_wmb();
-			dn_rt_hash_table[hash].chain = rth;
+			rcu_assign_pointer(rth->u.rt_next,
+					   dn_rt_hash_table[hash].chain);
+			rcu_assign_pointer(dn_rt_hash_table[hash].chain, rth);
 
 			rth->u.dst.__use++;
 			dst_hold(&rth->u.dst);
@@ -304,10 +303,8 @@ static int dn_insert_route(struct dn_rou
 		rthp = &rth->u.rt_next;
 	}
 
-	smp_wmb();
-	rt->u.rt_next = dn_rt_hash_table[hash].chain;
-	smp_wmb();
-	dn_rt_hash_table[hash].chain = rt;
+	rcu_assign_pointer(rt->u.rt_next, dn_rt_hash_table[hash].chain);
+	rcu_assign_pointer(dn_rt_hash_table[hash].chain, rt);
 	
 	dst_hold(&rt->u.dst);
 	rt->u.dst.__use++;
diff -urpN -X ../dontdiff linux-2.5/net/ipv4/devinet.c linux-2.5-rap/net/ipv4/devinet.c
--- linux-2.5/net/ipv4/devinet.c	Tue Sep  7 10:04:42 2004
+++ linux-2.5-rap/net/ipv4/devinet.c	Tue Sep  7 10:29:25 2004
@@ -158,8 +158,7 @@ struct in_device *inetdev_init(struct ne
 
 	/* Account for reference dev->ip_ptr */
 	in_dev_hold(in_dev);
-	smp_wmb();
-	dev->ip_ptr = in_dev;
+	rcu_assign_pointer(dev->ip_ptr, in_dev);
 
 #ifdef CONFIG_SYSCTL
 	devinet_sysctl_register(in_dev, &in_dev->cnf);
diff -urpN -X ../dontdiff linux-2.5/net/ipv4/route.c linux-2.5-rap/net/ipv4/route.c
--- linux-2.5/net/ipv4/route.c	Tue Sep  7 10:04:42 2004
+++ linux-2.5-rap/net/ipv4/route.c	Tue Sep  7 10:29:27 2004
@@ -793,14 +793,13 @@ restart:
 			 * must be visible to another weakly ordered CPU before
 			 * the insertion at the start of the hash chain.
 			 */
-			smp_wmb();
-			rth->u.rt_next = rt_hash_table[hash].chain;
+			rcu_assign_pointer(rth->u.rt_next,
+					   rt_hash_table[hash].chain);
 			/*
 			 * Since lookup is lockfree, the update writes
 			 * must be ordered for consistency on SMP.
 			 */
-			smp_wmb();
-			rt_hash_table[hash].chain = rth;
+			rcu_assign_pointer(rt_hash_table[hash].chain, rth);
 
 			rth->u.dst.__use++;
 			dst_hold(&rth->u.dst);
diff -urpN -X ../dontdiff linux-2.5/net/sched/sch_api.c linux-2.5-rap/net/sched/sch_api.c
--- linux-2.5/net/sched/sch_api.c	Tue Sep  7 10:04:46 2004
+++ linux-2.5-rap/net/sched/sch_api.c	Tue Sep  7 10:29:28 2004
@@ -451,10 +451,9 @@ qdisc_create(struct net_device *dev, u32
 
 	/* enqueue is accessed locklessly - make sure it's visible
 	 * before we set a netdevice's qdisc pointer to sch */
-	smp_wmb();
 	if (!ops->init || (err = ops->init(sch, tca[TCA_OPTIONS-1])) == 0) {
 		qdisc_lock_tree(dev);
-		list_add_tail(&sch->list, &dev->qdisc_list);
+		list_add_tail_rcu(&sch->list, &dev->qdisc_list);
 		qdisc_unlock_tree(dev);
 
 #ifdef CONFIG_NET_ESTIMATOR
