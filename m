Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSIBJDe>; Mon, 2 Sep 2002 05:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSIBJDe>; Mon, 2 Sep 2002 05:03:34 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:41673 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317182AbSIBJD3>; Mon, 2 Sep 2002 05:03:29 -0400
Date: Mon, 2 Sep 2002 14:41:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Dave Miller <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paul McKenney <paul.mckenney@us.ibm.com>
Subject: [BKPATCH] lockfree rtcache lookup using RCU
Message-ID: <20020902144120.A11489@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The lockfree ipv4 route cache lookup code is now available
for pulling from -

http://lse.bkbits.net/linux-2.5-rcu-rtcache

It speeds up route cache lookup by 30-50% approximately as measured
with synthetic benchmark suggested by Dave.

http://marc.theaimsgroup.com/?l=linux-kernel&m=102258603404836&w=2

The entire discussion is in -
http://marc.theaimsgroup.com/?t=102258611100001&r=1&w=2

Changes from Linus' tree are -

ChangeSet@1.500, 2002-09-02 12:34:24+05:30, dipankar@in.ibm.com
  Implemented lockfree lookup of routes from ipv4 route cache using RCU.

ChangeSet@1.499, 2002-09-02 11:54:55+05:30, dipankar@in.ibm.com
  Add a lightweight read barrier (read_barrier_depends()) for data 
  dependent reads. Also, add more explicit versions of barrier names like
  read_barrier()/write_barrier().

ChangeSet@1.498, 2002-08-27 00:27:13+05:30, dipankar@in.ibm.com
    Add RCU infrastructure based on rcu_poll in -aa kernels with support
    for preemption and per-CPU queues.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.499   -> 1.500  
#	   include/net/dst.h	1.1     -> 1.2    
#	    net/ipv4/route.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/02	dipankar@in.ibm.com	1.500
# Implemented lockfree lookup of routes from ipv4 route cache using RCU.
# --------------------------------------------
#
diff -Nru a/include/net/dst.h b/include/net/dst.h
--- a/include/net/dst.h	Mon Sep  2 14:28:56 2002
+++ b/include/net/dst.h	Mon Sep  2 14:28:56 2002
@@ -9,6 +9,7 @@
 #define _NET_DST_H
 
 #include <linux/config.h>
+#include <linux/rcupdate.h>
 #include <net/neighbour.h>
 
 /*
@@ -62,6 +63,7 @@
 #endif
 
 	struct  dst_ops	        *ops;
+	struct rcu_head		rcu_head;
 		
 	char			info[0];
 };
diff -Nru a/net/ipv4/route.c b/net/ipv4/route.c
--- a/net/ipv4/route.c	Mon Sep  2 14:28:56 2002
+++ b/net/ipv4/route.c	Mon Sep  2 14:28:56 2002
@@ -85,6 +85,7 @@
 #include <linux/mroute.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/random.h>
+#include <linux/rcupdate.h>
 #include <net/protocol.h>
 #include <net/ip.h>
 #include <net/route.h>
@@ -188,7 +189,7 @@
 
 struct rt_hash_bucket {
 	struct rtable	*chain;
-	rwlock_t	lock;
+	spinlock_t	lock;
 } __attribute__((__aligned__(8)));
 
 static struct rt_hash_bucket 	*rt_hash_table;
@@ -226,8 +227,8 @@
 		len = 128;
   	}
 	
+	rcu_read_lock();
 	for (i = rt_hash_mask; i >= 0; i--) {
-		read_lock_bh(&rt_hash_table[i].lock);
 		for (r = rt_hash_table[i].chain; r; r = r->u.rt_next) {
 			/*
 			 *	Spin through entries until we are ready
@@ -238,6 +239,7 @@
 				len = 0;
 				continue;
 			}
+			read_barrier_depends();
 			sprintf(temp, "%s\t%08lX\t%08lX\t%8X\t%d\t%u\t%d\t"
 				"%08lX\t%d\t%u\t%u\t%02X\t%d\t%1d\t%08X",
 				r->u.dst.dev ? r->u.dst.dev->name : "*",
@@ -262,14 +264,13 @@
 			sprintf(buffer + len, "%-127s\n", temp);
 			len += 128;
 			if (pos >= offset+length) {
-				read_unlock_bh(&rt_hash_table[i].lock);
 				goto done;
 			}
 		}
-		read_unlock_bh(&rt_hash_table[i].lock);
         }
 
 done:
+	rcu_read_unlock();
   	*start = buffer + len - (pos - offset);
   	len = pos - offset;
   	if (len > length)
@@ -318,13 +319,13 @@
   
 static __inline__ void rt_free(struct rtable *rt)
 {
-	dst_free(&rt->u.dst);
+	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
 }
 
 static __inline__ void rt_drop(struct rtable *rt)
 {
 	ip_rt_put(rt);
-	dst_free(&rt->u.dst);
+	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
 }
 
 static __inline__ int rt_fast_clean(struct rtable *rth)
@@ -377,7 +378,7 @@
 		i = (i + 1) & rt_hash_mask;
 		rthp = &rt_hash_table[i].chain;
 
-		write_lock(&rt_hash_table[i].lock);
+		spin_lock(&rt_hash_table[i].lock);
 		while ((rth = *rthp) != NULL) {
 			if (rth->u.dst.expires) {
 				/* Entry is expired even if it is in use */
@@ -396,7 +397,7 @@
 			*rthp = rth->u.rt_next;
 			rt_free(rth);
 		}
-		write_unlock(&rt_hash_table[i].lock);
+		spin_unlock(&rt_hash_table[i].lock);
 
 		/* Fallback loop breaker. */
 		if ((jiffies - now) > 0)
@@ -419,11 +420,11 @@
 	rt_deadline = 0;
 
 	for (i = rt_hash_mask; i >= 0; i--) {
-		write_lock_bh(&rt_hash_table[i].lock);
+		spin_lock_bh(&rt_hash_table[i].lock);
 		rth = rt_hash_table[i].chain;
 		if (rth)
 			rt_hash_table[i].chain = NULL;
-		write_unlock_bh(&rt_hash_table[i].lock);
+		spin_unlock_bh(&rt_hash_table[i].lock);
 
 		for (; rth; rth = next) {
 			next = rth->u.rt_next;
@@ -547,7 +548,7 @@
 
 			k = (k + 1) & rt_hash_mask;
 			rthp = &rt_hash_table[k].chain;
-			write_lock_bh(&rt_hash_table[k].lock);
+			spin_lock_bh(&rt_hash_table[k].lock);
 			while ((rth = *rthp) != NULL) {
 				if (!rt_may_expire(rth, tmo, expire)) {
 					tmo >>= 1;
@@ -558,7 +559,7 @@
 				rt_free(rth);
 				goal--;
 			}
-			write_unlock_bh(&rt_hash_table[k].lock);
+			spin_unlock_bh(&rt_hash_table[k].lock);
 			if (goal <= 0)
 				break;
 		}
@@ -619,18 +620,20 @@
 restart:
 	rthp = &rt_hash_table[hash].chain;
 
-	write_lock_bh(&rt_hash_table[hash].lock);
+	spin_lock_bh(&rt_hash_table[hash].lock);
 	while ((rth = *rthp) != NULL) {
 		if (memcmp(&rth->key, &rt->key, sizeof(rt->key)) == 0) {
 			/* Put it first */
 			*rthp = rth->u.rt_next;
+			wmb();
 			rth->u.rt_next = rt_hash_table[hash].chain;
+			wmb();
 			rt_hash_table[hash].chain = rth;
 
 			rth->u.dst.__use++;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.lastuse = now;
-			write_unlock_bh(&rt_hash_table[hash].lock);
+			spin_unlock_bh(&rt_hash_table[hash].lock);
 
 			rt_drop(rt);
 			*rp = rth;
@@ -646,7 +649,7 @@
 	if (rt->rt_type == RTN_UNICAST || rt->key.iif == 0) {
 		int err = arp_bind_neighbour(&rt->u.dst);
 		if (err) {
-			write_unlock_bh(&rt_hash_table[hash].lock);
+			spin_unlock_bh(&rt_hash_table[hash].lock);
 
 			if (err != -ENOBUFS) {
 				rt_drop(rt);
@@ -687,7 +690,7 @@
 	}
 #endif
 	rt_hash_table[hash].chain = rt;
-	write_unlock_bh(&rt_hash_table[hash].lock);
+	spin_unlock_bh(&rt_hash_table[hash].lock);
 	*rp = rt;
 	return 0;
 }
@@ -754,7 +757,7 @@
 {
 	struct rtable **rthp;
 
-	write_lock_bh(&rt_hash_table[hash].lock);
+	spin_lock_bh(&rt_hash_table[hash].lock);
 	ip_rt_put(rt);
 	for (rthp = &rt_hash_table[hash].chain; *rthp;
 	     rthp = &(*rthp)->u.rt_next)
@@ -763,7 +766,7 @@
 			rt_free(rt);
 			break;
 		}
-	write_unlock_bh(&rt_hash_table[hash].lock);
+	spin_unlock_bh(&rt_hash_table[hash].lock);
 }
 
 void ip_rt_redirect(u32 old_gw, u32 daddr, u32 new_gw,
@@ -802,10 +805,10 @@
 
 			rthp=&rt_hash_table[hash].chain;
 
-			read_lock(&rt_hash_table[hash].lock);
+			rcu_read_lock();
 			while ((rth = *rthp) != NULL) {
 				struct rtable *rt;
-
+				read_barrier_depends();
 				if (rth->key.dst != daddr ||
 				    rth->key.src != skeys[i] ||
 				    rth->key.tos != tos ||
@@ -823,7 +826,7 @@
 					break;
 
 				dst_clone(&rth->u.dst);
-				read_unlock(&rt_hash_table[hash].lock);
+				rcu_read_unlock();
 
 				rt = dst_alloc(&ipv4_dst_ops);
 				if (rt == NULL) {
@@ -834,6 +837,8 @@
 
 				/* Copy all the information. */
 				*rt = *rth;
+ 				memset(&rt->u.dst.rcu_head, 0, 
+ 					sizeof(struct rcu_head));
 				rt->u.dst.__use		= 1;
 				atomic_set(&rt->u.dst.__refcnt, 1);
 				if (rt->u.dst.dev)
@@ -869,7 +874,7 @@
 					ip_rt_put(rt);
 				goto do_next;
 			}
-			read_unlock(&rt_hash_table[hash].lock);
+			rcu_read_unlock();
 		do_next:
 			;
 		}
@@ -1049,9 +1054,10 @@
 	for (i = 0; i < 2; i++) {
 		unsigned hash = rt_hash_code(daddr, skeys[i], tos);
 
-		read_lock(&rt_hash_table[hash].lock);
+		rcu_read_lock();
 		for (rth = rt_hash_table[hash].chain; rth;
 		     rth = rth->u.rt_next) {
+			read_barrier_depends();
 			if (rth->key.dst == daddr &&
 			    rth->key.src == skeys[i] &&
 			    rth->rt_dst  == daddr &&
@@ -1087,7 +1093,7 @@
 				}
 			}
 		}
-		read_unlock(&rt_hash_table[hash].lock);
+		rcu_read_unlock();
 	}
 	return est_mtu ? : new_mtu;
 }
@@ -1641,8 +1647,9 @@
 	tos &= IPTOS_RT_MASK;
 	hash = rt_hash_code(daddr, saddr ^ (iif << 5), tos);
 
-	read_lock(&rt_hash_table[hash].lock);
+	rcu_read_lock();
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
+		read_barrier_depends();
 		if (rth->key.dst == daddr &&
 		    rth->key.src == saddr &&
 		    rth->key.iif == iif &&
@@ -1655,12 +1662,12 @@
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			rt_cache_stat[smp_processor_id()].in_hit++;
-			read_unlock(&rt_hash_table[hash].lock);
+			rcu_read_unlock();
 			skb->dst = (struct dst_entry*)rth;
 			return 0;
 		}
 	}
-	read_unlock(&rt_hash_table[hash].lock);
+	rcu_read_unlock();
 
 	/* Multicast recognition logic is moved from route cache to here.
 	   The problem was that too many Ethernet cards have broken/missing
@@ -2000,8 +2007,9 @@
 
 	hash = rt_hash_code(key->dst, key->src ^ (key->oif << 5), key->tos);
 
-	read_lock_bh(&rt_hash_table[hash].lock);
+	rcu_read_lock();
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
+		read_barrier_depends();
 		if (rth->key.dst == key->dst &&
 		    rth->key.src == key->src &&
 		    rth->key.iif == 0 &&
@@ -2015,12 +2023,12 @@
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			rt_cache_stat[smp_processor_id()].out_hit++;
-			read_unlock_bh(&rt_hash_table[hash].lock);
+			rcu_read_unlock();
 			*rp = rth;
 			return 0;
 		}
 	}
-	read_unlock_bh(&rt_hash_table[hash].lock);
+	rcu_read_unlock();
 
 	return ip_route_output_slow(rp, key);
 }	
@@ -2206,9 +2214,10 @@
 		if (h < s_h) continue;
 		if (h > s_h)
 			s_idx = 0;
-		read_lock_bh(&rt_hash_table[h].lock);
+		rcu_read_lock();
 		for (rt = rt_hash_table[h].chain, idx = 0; rt;
 		     rt = rt->u.rt_next, idx++) {
+			read_barrier_depends();
 			if (idx < s_idx)
 				continue;
 			skb->dst = dst_clone(&rt->u.dst);
@@ -2216,12 +2225,12 @@
 					 cb->nlh->nlmsg_seq,
 					 RTM_NEWROUTE, 1) <= 0) {
 				dst_release(xchg(&skb->dst, NULL));
-				read_unlock_bh(&rt_hash_table[h].lock);
+				rcu_read_unlock();
 				goto done;
 			}
 			dst_release(xchg(&skb->dst, NULL));
 		}
-		read_unlock_bh(&rt_hash_table[h].lock);
+		rcu_read_unlock();
 	}
 
 done:
@@ -2503,7 +2512,7 @@
 
 	rt_hash_mask--;
 	for (i = 0; i <= rt_hash_mask; i++) {
-		rt_hash_table[i].lock = RW_LOCK_UNLOCKED;
+		rt_hash_table[i].lock = SPIN_LOCK_UNLOCKED;
 		rt_hash_table[i].chain = NULL;
 	}
 
