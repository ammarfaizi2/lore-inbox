Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUHFT0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUHFT0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUHFT0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:26:03 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:53936 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268244AbUHFTWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:22:46 -0400
Date: Sun, 8 Aug 2004 00:50:23 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com
Subject: Re: RCU : Use call_rcu_bh() in route cache [3/5]
Message-ID: <20040807192023.GD3936@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040807191536.GA3936@in.ibm.com> <20040807191729.GB3936@in.ibm.com> <20040807191841.GC3936@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807191841.GC3936@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use call_rcu_bh() in route cache. This allows faster grace periods and
avoids dst cache overflows during DoS testing.

Thanks
Dipankar


This patch uses the call_rcu_bh() api in route cache code to
facilitate quicker RCU grace periods. Quicker grace periods
avoid overflow of dst cache in heavily loaded routers as
seen in Robert Olsson's testing. 

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 net/decnet/dn_route.c |   28 ++++++++++++++--------------
 net/ipv4/route.c      |   26 +++++++++++++-------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff -puN net/decnet/dn_route.c~rcu-use-call-rcu-bh net/decnet/dn_route.c
--- linux-2.6.8-rc3-mm1/net/decnet/dn_route.c~rcu-use-call-rcu-bh	2004-08-07 15:29:16.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/net/decnet/dn_route.c	2004-08-07 15:29:16.000000000 +0530
@@ -146,14 +146,14 @@ static __inline__ unsigned dn_hash(unsig
 
 static inline void dnrt_free(struct dn_route *rt)
 {
-	call_rcu(&rt->u.dst.rcu_head, dst_rcu_free);
+	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static inline void dnrt_drop(struct dn_route *rt)
 {
 	if (rt)
 		dst_release(&rt->u.dst);
-	call_rcu(&rt->u.dst.rcu_head, dst_rcu_free);
+	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static void dn_dst_check_expire(unsigned long dummy)
@@ -1174,9 +1174,9 @@ static int __dn_route_output_key(struct 
 	struct dn_route *rt = NULL;
 
 	if (!(flags & MSG_TRYHARD)) {
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		for(rt = dn_rt_hash_table[hash].chain; rt; rt = rt->u.rt_next) {
-			read_barrier_depends();
+			smp_read_barrier_depends();
 			if ((flp->fld_dst == rt->fl.fld_dst) &&
 			    (flp->fld_src == rt->fl.fld_src) &&
 #ifdef CONFIG_DECNET_ROUTE_FWMARK
@@ -1187,12 +1187,12 @@ static int __dn_route_output_key(struct 
 				rt->u.dst.lastuse = jiffies;
 				dst_hold(&rt->u.dst);
 				rt->u.dst.__use++;
-				rcu_read_unlock();
+				rcu_read_unlock_bh();
 				*pprt = &rt->u.dst;
 				return 0;
 			}
 		}
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 
 	return dn_route_output_slow(pprt, flp, flags);
@@ -1647,21 +1647,21 @@ int dn_cache_dump(struct sk_buff *skb, s
 			continue;
 		if (h > s_h)
 			s_idx = 0;
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		for(rt = dn_rt_hash_table[h].chain, idx = 0; rt; rt = rt->u.rt_next, idx++) {
-			read_barrier_depends();
+			smp_read_barrier_depends();
 			if (idx < s_idx)
 				continue;
 			skb->dst = dst_clone(&rt->u.dst);
 			if (dn_rt_fill_info(skb, NETLINK_CB(cb->skb).pid,
 					cb->nlh->nlmsg_seq, RTM_NEWROUTE, 1) <= 0) {
 				dst_release(xchg(&skb->dst, NULL));
-				rcu_read_unlock();
+				rcu_read_unlock_bh();
 				goto done;
 			}
 			dst_release(xchg(&skb->dst, NULL));
 		}
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 
 done:
@@ -1681,7 +1681,7 @@ static struct dn_route *dn_rt_cache_get_
 	struct dn_rt_cache_iter_state *s = seq->private;
 
 	for(s->bucket = dn_rt_hash_mask; s->bucket >= 0; --s->bucket) {
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		rt = dn_rt_hash_table[s->bucket].chain;
 		if (rt)
 			break;
@@ -1697,10 +1697,10 @@ static struct dn_route *dn_rt_cache_get_
 	smp_read_barrier_depends();
 	rt = rt->u.rt_next;
 	while(!rt) {
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 		if (--s->bucket < 0)
 			break;
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		rt = dn_rt_hash_table[s->bucket].chain;
 	}
 	return rt;
@@ -1727,7 +1727,7 @@ static void *dn_rt_cache_seq_next(struct
 static void dn_rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
 	if (v)
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 }
 
 static int dn_rt_cache_seq_show(struct seq_file *seq, void *v)
diff -puN net/ipv4/route.c~rcu-use-call-rcu-bh net/ipv4/route.c
--- linux-2.6.8-rc3-mm1/net/ipv4/route.c~rcu-use-call-rcu-bh	2004-08-07 15:29:16.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/net/ipv4/route.c	2004-08-07 15:29:16.000000000 +0530
@@ -226,11 +226,11 @@ static struct rtable *rt_cache_get_first
 	struct rt_cache_iter_state *st = seq->private;
 
 	for (st->bucket = rt_hash_mask; st->bucket >= 0; --st->bucket) {
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		r = rt_hash_table[st->bucket].chain;
 		if (r)
 			break;
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 	return r;
 }
@@ -242,10 +242,10 @@ static struct rtable *rt_cache_get_next(
 	smp_read_barrier_depends();
 	r = r->u.rt_next;
 	while (!r) {
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 		if (--st->bucket < 0)
 			break;
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		r = rt_hash_table[st->bucket].chain;
 	}
 	return r;
@@ -281,7 +281,7 @@ static void *rt_cache_seq_next(struct se
 static void rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
 	if (v && v != SEQ_START_TOKEN)
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 }
 
 static int rt_cache_seq_show(struct seq_file *seq, void *v)
@@ -439,13 +439,13 @@ static struct file_operations rt_cpu_seq
   
 static __inline__ void rt_free(struct rtable *rt)
 {
-	call_rcu(&rt->u.dst.rcu_head, dst_rcu_free);
+	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static __inline__ void rt_drop(struct rtable *rt)
 {
 	ip_rt_put(rt);
-	call_rcu(&rt->u.dst.rcu_head, dst_rcu_free);
+	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static __inline__ int rt_fast_clean(struct rtable *rth)
@@ -2231,7 +2231,7 @@ int __ip_route_output_key(struct rtable 
 
 	hash = rt_hash_code(flp->fl4_dst, flp->fl4_src ^ (flp->oif << 5), flp->fl4_tos);
 
-	rcu_read_lock();
+	rcu_read_lock_bh();
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
 		smp_read_barrier_depends();
 		if (rth->fl.fl4_dst == flp->fl4_dst &&
@@ -2247,13 +2247,13 @@ int __ip_route_output_key(struct rtable 
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			RT_CACHE_STAT_INC(out_hit);
-			rcu_read_unlock();
+			rcu_read_unlock_bh();
 			*rp = rth;
 			return 0;
 		}
 		RT_CACHE_STAT_INC(out_hlist_search);
 	}
-	rcu_read_unlock();
+	rcu_read_unlock_bh();
 
 	return ip_route_output_slow(rp, flp);
 }
@@ -2463,7 +2463,7 @@ int ip_rt_dump(struct sk_buff *skb,  str
 		if (h < s_h) continue;
 		if (h > s_h)
 			s_idx = 0;
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		for (rt = rt_hash_table[h].chain, idx = 0; rt;
 		     rt = rt->u.rt_next, idx++) {
 			smp_read_barrier_depends();
@@ -2474,12 +2474,12 @@ int ip_rt_dump(struct sk_buff *skb,  str
 					 cb->nlh->nlmsg_seq,
 					 RTM_NEWROUTE, 1) <= 0) {
 				dst_release(xchg(&skb->dst, NULL));
-				rcu_read_unlock();
+				rcu_read_unlock_bh();
 				goto done;
 			}
 			dst_release(xchg(&skb->dst, NULL));
 		}
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 
 done:

_
