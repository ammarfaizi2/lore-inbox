Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSEHHX6>; Wed, 8 May 2002 03:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSEHHX5>; Wed, 8 May 2002 03:23:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21240 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310435AbSEHHXy>; Wed, 8 May 2002 03:23:54 -0400
Date: Wed, 8 May 2002 12:57:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] lockfree rtcache lookup using RCU
Message-ID: <20020508125711.B10505@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During a past thread about lockfree hashtable lookups using RCU,
merits and complexities of such an approach were discussed.
Here is a patch that uses RCU to do lockfree ipv4 route cache
lookup.

I decided that I should do some microbenchmarking to see
if it really makes a difference or not. Since, we know that
lock contention is not an issue (rwlock with rare updates), I
thought I should concentrate on the cache line bouncing of
the per-bucket rwlock. I figured that if we have lots of
hits in the route cache, the corresponding rwlock cache lines
are going to bounce. So I wrote a test that
uses about 8 processes to send a large number of randomly sized packets to
a single destination. For 1 to 8 CPUs I used the test script
to send a fixed number of packets to a single destination address.
The results show that time needed for lookup continuously increases
for 2.5.3 wherease for rt_rcu-2.5.3, it remains constant.

http://lse.sourceforge.net/locking/rcu/rtcache/rttest/rttest.png

The results are in -

http://lse.sourceforge.net/locking/rcu/rtcache/rttest/

The measurements were done in an 8way PIII xeon with 1MB L2 cache
and 6GB memory.

Comments/suggestions are welcome.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


diff -urN linux-2.5.3/include/net/dst.h linux-2.5.3-rt_rcu/include/net/dst.h
--- linux-2.5.3/include/net/dst.h	Wed Jan 30 11:11:52 2002
+++ linux-2.5.3-rt_rcu/include/net/dst.h	Fri Feb  8 11:45:15 2002
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
diff -urN linux-2.5.3/net/ipv4/route.c linux-2.5.3-rt_rcu/net/ipv4/route.c
--- linux-2.5.3/net/ipv4/route.c	Wed Jan 16 00:26:35 2002
+++ linux-2.5.3-rt_rcu/net/ipv4/route.c	Fri Feb  8 11:37:22 2002
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
@@ -227,7 +228,6 @@
   	}
 	
 	for (i = rt_hash_mask; i >= 0; i--) {
-		read_lock_bh(&rt_hash_table[i].lock);
 		for (r = rt_hash_table[i].chain; r; r = r->u.rt_next) {
 			/*
 			 *	Spin through entries until we are ready
@@ -238,6 +238,8 @@
 				len = 0;
 				continue;
 			}
+			/* read_barrier_depends() here */
+			rmb();
 			sprintf(temp, "%s\t%08lX\t%08lX\t%8X\t%d\t%u\t%d\t"
 				"%08lX\t%d\t%u\t%u\t%02X\t%d\t%1d\t%08X",
 				r->u.dst.dev ? r->u.dst.dev->name : "*",
@@ -262,11 +264,9 @@
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
@@ -314,13 +314,13 @@
   
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
@@ -373,7 +373,7 @@
 		i = (i + 1) & rt_hash_mask;
 		rthp = &rt_hash_table[i].chain;
 
-		write_lock(&rt_hash_table[i].lock);
+		spin_lock(&rt_hash_table[i].lock);
 		while ((rth = *rthp) != NULL) {
 			if (rth->u.dst.expires) {
 				/* Entry is expired even if it is in use */
@@ -392,7 +392,7 @@
 			*rthp = rth->u.rt_next;
 			rt_free(rth);
 		}
-		write_unlock(&rt_hash_table[i].lock);
+		spin_unlock(&rt_hash_table[i].lock);
 
 		/* Fallback loop breaker. */
 		if ((jiffies - now) > 0)
@@ -415,11 +415,11 @@
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
@@ -538,7 +538,7 @@
 
 			k = (k + 1) & rt_hash_mask;
 			rthp = &rt_hash_table[k].chain;
-			write_lock_bh(&rt_hash_table[k].lock);
+			spin_lock_bh(&rt_hash_table[k].lock);
 			while ((rth = *rthp) != NULL) {
 				if (!rt_may_expire(rth, tmo, expire)) {
 					tmo >>= 1;
@@ -549,7 +549,7 @@
 				rt_free(rth);
 				goal--;
 			}
-			write_unlock_bh(&rt_hash_table[k].lock);
+			spin_unlock_bh(&rt_hash_table[k].lock);
 			if (goal <= 0)
 				break;
 		}
@@ -607,18 +607,20 @@
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
@@ -634,7 +636,7 @@
 	if (rt->rt_type == RTN_UNICAST || rt->key.iif == 0) {
 		int err = arp_bind_neighbour(&rt->u.dst);
 		if (err) {
-			write_unlock_bh(&rt_hash_table[hash].lock);
+			spin_unlock_bh(&rt_hash_table[hash].lock);
 
 			if (err != -ENOBUFS) {
 				rt_drop(rt);
@@ -675,7 +677,7 @@
 	}
 #endif
 	rt_hash_table[hash].chain = rt;
-	write_unlock_bh(&rt_hash_table[hash].lock);
+	spin_unlock_bh(&rt_hash_table[hash].lock);
 	*rp = rt;
 	return 0;
 }
@@ -742,7 +744,7 @@
 {
 	struct rtable **rthp;
 
-	write_lock_bh(&rt_hash_table[hash].lock);
+	spin_lock_bh(&rt_hash_table[hash].lock);
 	ip_rt_put(rt);
 	for (rthp = &rt_hash_table[hash].chain; *rthp;
 	     rthp = &(*rthp)->u.rt_next)
@@ -751,7 +753,7 @@
 			rt_free(rt);
 			break;
 		}
-	write_unlock_bh(&rt_hash_table[hash].lock);
+	spin_unlock_bh(&rt_hash_table[hash].lock);
 }
 
 void ip_rt_redirect(u32 old_gw, u32 daddr, u32 new_gw,
@@ -790,10 +792,10 @@
 
 			rthp=&rt_hash_table[hash].chain;
 
-			read_lock(&rt_hash_table[hash].lock);
 			while ((rth = *rthp) != NULL) {
 				struct rtable *rt;
-
+				/* read_barrier_depends() here */
+				rmb();
 				if (rth->key.dst != daddr ||
 				    rth->key.src != skeys[i] ||
 				    rth->key.tos != tos ||
@@ -811,7 +813,6 @@
 					break;
 
 				dst_clone(&rth->u.dst);
-				read_unlock(&rt_hash_table[hash].lock);
 
 				rt = dst_alloc(&ipv4_dst_ops);
 				if (rt == NULL) {
@@ -822,6 +823,8 @@
 
 				/* Copy all the information. */
 				*rt = *rth;
+ 				memset(&rt->u.dst.rcu_head, 0, 
+ 					sizeof(struct rcu_head));
 				rt->u.dst.__use		= 1;
 				atomic_set(&rt->u.dst.__refcnt, 1);
 				if (rt->u.dst.dev)
@@ -857,7 +860,6 @@
 					ip_rt_put(rt);
 				goto do_next;
 			}
-			read_unlock(&rt_hash_table[hash].lock);
 		do_next:
 			;
 		}
@@ -1037,9 +1039,10 @@
 	for (i = 0; i < 2; i++) {
 		unsigned hash = rt_hash_code(daddr, skeys[i], tos);
 
-		read_lock(&rt_hash_table[hash].lock);
 		for (rth = rt_hash_table[hash].chain; rth;
 		     rth = rth->u.rt_next) {
+			/* read_barrier_depends() here */
+			rmb();
 			if (rth->key.dst == daddr &&
 			    rth->key.src == skeys[i] &&
 			    rth->rt_dst  == daddr &&
@@ -1075,7 +1078,6 @@
 				}
 			}
 		}
-		read_unlock(&rt_hash_table[hash].lock);
 	}
 	return est_mtu ? : new_mtu;
 }
@@ -1629,8 +1631,9 @@
 	tos &= IPTOS_RT_MASK;
 	hash = rt_hash_code(daddr, saddr ^ (iif << 5), tos);
 
-	read_lock(&rt_hash_table[hash].lock);
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
+		/* read_barrier_depends() here */
+		rmb();
 		if (rth->key.dst == daddr &&
 		    rth->key.src == saddr &&
 		    rth->key.iif == iif &&
@@ -1643,12 +1646,10 @@
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			rt_cache_stat[smp_processor_id()].in_hit++;
-			read_unlock(&rt_hash_table[hash].lock);
 			skb->dst = (struct dst_entry*)rth;
 			return 0;
 		}
 	}
-	read_unlock(&rt_hash_table[hash].lock);
 
 	/* Multicast recognition logic is moved from route cache to here.
 	   The problem was that too many Ethernet cards have broken/missing
@@ -1988,8 +1989,9 @@
 
 	hash = rt_hash_code(key->dst, key->src ^ (key->oif << 5), key->tos);
 
-	read_lock_bh(&rt_hash_table[hash].lock);
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
+		/* read_barrier_depends() here */
+		rmb();
 		if (rth->key.dst == key->dst &&
 		    rth->key.src == key->src &&
 		    rth->key.iif == 0 &&
@@ -2003,12 +2005,10 @@
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			rt_cache_stat[smp_processor_id()].out_hit++;
-			read_unlock_bh(&rt_hash_table[hash].lock);
 			*rp = rth;
 			return 0;
 		}
 	}
-	read_unlock_bh(&rt_hash_table[hash].lock);
 
 	return ip_route_output_slow(rp, key);
 }	
@@ -2194,9 +2194,10 @@
 		if (h < s_h) continue;
 		if (h > s_h)
 			s_idx = 0;
-		read_lock_bh(&rt_hash_table[h].lock);
 		for (rt = rt_hash_table[h].chain, idx = 0; rt;
 		     rt = rt->u.rt_next, idx++) {
+			/* read_barrier_depends() here */
+			rmb();
 			if (idx < s_idx)
 				continue;
 			skb->dst = dst_clone(&rt->u.dst);
@@ -2204,12 +2205,10 @@
 					 cb->nlh->nlmsg_seq,
 					 RTM_NEWROUTE, 1) <= 0) {
 				dst_release(xchg(&skb->dst, NULL));
-				read_unlock_bh(&rt_hash_table[h].lock);
 				goto done;
 			}
 			dst_release(xchg(&skb->dst, NULL));
 		}
-		read_unlock_bh(&rt_hash_table[h].lock);
 	}
 
 done:
@@ -2496,7 +2495,7 @@
 
 	rt_hash_mask--;
 	for (i = 0; i <= rt_hash_mask; i++) {
-		rt_hash_table[i].lock = RW_LOCK_UNLOCKED;
+		rt_hash_table[i].lock = SPIN_LOCK_UNLOCKED;
 		rt_hash_table[i].chain = NULL;
 	}
 
