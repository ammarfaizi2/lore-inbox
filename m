Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTACKPd>; Fri, 3 Jan 2003 05:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbTACKPd>; Fri, 3 Jan 2003 05:15:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45799 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267481AbTACKPa>;
	Fri, 3 Jan 2003 05:15:30 -0500
Date: Fri, 3 Jan 2003 15:56:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Dave Miller <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] barriers in lockfree rtcache
Message-ID: <20030103102600.GC8582@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

This patch fixes several things in ipv4 route cache that I missed in
the last patch -

1. All the memory barriers are SMP-only avoiding unnecessary overhead on UP.
2. My forward porting merge of the rt_rcu patch dropped two changes in
   rt_intern_hash() in around 2.5.43 that ordered the writes while
   inserting a dst entry at the start of a hash chain. The dst entry updates
   must be visible to other (weakly ordered) CPUs before it is inserted.
   The necessary smp_wmb()s are added.
3. Comments to go with the write ordering.

Please apply.

Thanks
Dipankar


diff -urN linux-2.5.54-base/net/ipv4/route.c linux-2.5.54-rt_barriers/net/ipv4/route.c
--- linux-2.5.54-base/net/ipv4/route.c	2003-01-02 08:53:15.000000000 +0530
+++ linux-2.5.54-rt_barriers/net/ipv4/route.c	2003-01-03 14:44:31.000000000 +0530
@@ -234,7 +234,7 @@
 {
 	struct rt_cache_iter_state *st = seq->private;
 
-	read_barrier_depends();
+	smp_read_barrier_depends();
 	r = r->u.rt_next;
 	while (!r) {
 		rcu_read_unlock();
@@ -718,7 +718,18 @@
 		if (compare_keys(&rth->fl, &rt->fl)) {
 			/* Put it first */
 			*rthp = rth->u.rt_next;
+			/*
+			 * Since lookup is lockfree, the deletion
+			 * must be visible to another weakly ordered CPU before
+			 * the insertion at the start of the hash chain.
+			 */
+			smp_wmb();
 			rth->u.rt_next = rt_hash_table[hash].chain;
+			/*
+			 * Since lookup is lockfree, the update writes
+			 * must be ordered for consistency on SMP.
+			 */
+			smp_wmb();
 			rt_hash_table[hash].chain = rth;
 
 			rth->u.dst.__use++;
@@ -900,7 +911,7 @@
 			while ((rth = *rthp) != NULL) {
 				struct rtable *rt;
 
-				read_barrier_depends();
+				smp_read_barrier_depends();
 				if (rth->fl.fl4_dst != daddr ||
 				    rth->fl.fl4_src != skeys[i] ||
 				    rth->fl.fl4_tos != tos ||
@@ -1148,7 +1159,7 @@
 		rcu_read_lock();
 		for (rth = rt_hash_table[hash].chain; rth;
 		     rth = rth->u.rt_next) {
-			read_barrier_depends();
+			smp_read_barrier_depends();
 			if (rth->fl.fl4_dst == daddr &&
 			    rth->fl.fl4_src == skeys[i] &&
 			    rth->rt_dst  == daddr &&
@@ -1740,7 +1751,7 @@
 
 	rcu_read_lock();
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
-		read_barrier_depends();
+		smp_read_barrier_depends();
 		if (rth->fl.fl4_dst == daddr &&
 		    rth->fl.fl4_src == saddr &&
 		    rth->fl.iif == iif &&
@@ -2105,7 +2116,7 @@
 
 	rcu_read_lock();
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
-		read_barrier_depends();
+		smp_read_barrier_depends();
 		if (rth->fl.fl4_dst == flp->fl4_dst &&
 		    rth->fl.fl4_src == flp->fl4_src &&
 		    rth->fl.iif == 0 &&
@@ -2335,7 +2346,7 @@
 		rcu_read_lock();
 		for (rt = rt_hash_table[h].chain, idx = 0; rt;
 		     rt = rt->u.rt_next, idx++) {
-			read_barrier_depends();
+			smp_read_barrier_depends();
 			if (idx < s_idx)
 				continue;
 			skb->dst = dst_clone(&rt->u.dst);
