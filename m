Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWAGAUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWAGAUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWAGAUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:20:22 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41441
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965368AbWAGAUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:20:20 -0500
Date: Fri, 06 Jan 2006 16:17:21 -0800 (PST)
Message-Id: <20060106.161721.124249301.davem@davemloft.net>
To: ak@suse.de
Cc: paulmck@us.ibm.com, dada1@cosmosbay.com, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200601062157.42470.ak@suse.de>
References: <43BEA693.5010509@cosmosbay.com>
	<20060106202626.GA5677@us.ibm.com>
	<200601062157.42470.ak@suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Fri, 6 Jan 2006 21:57:41 +0100

> Perhaps a better way would be to just exclude dst entries in RCU state
> from the normal accounting and assume that if the system
> really runs short of memory because of this the results would
> trigger quiescent states more quickly, freeing the memory again.

That's one idea...

Eric, how important do you honestly think the per-hashchain spinlocks
are?  That's the big barrier from making rt_secret_rebuild() a simple
rehash instead of flushing the whole table as it does now.

The lock is only grabbed for updates, and the access to these locks is
random and as such probably non-local when taken anyways.  Back before
we used RCU for reads, this array-of-spinlock thing made a lot more
sense.

I mean something like this patch:

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f701a13..f9436c7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -204,36 +204,8 @@ __u8 ip_tos2prio[16] = {
 struct rt_hash_bucket {
 	struct rtable	*chain;
 };
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-/*
- * Instead of using one spinlock for each rt_hash_bucket, we use a table of spinlocks
- * The size of this table is a power of two and depends on the number of CPUS.
- */
-#if NR_CPUS >= 32
-#define RT_HASH_LOCK_SZ	4096
-#elif NR_CPUS >= 16
-#define RT_HASH_LOCK_SZ	2048
-#elif NR_CPUS >= 8
-#define RT_HASH_LOCK_SZ	1024
-#elif NR_CPUS >= 4
-#define RT_HASH_LOCK_SZ	512
-#else
-#define RT_HASH_LOCK_SZ	256
-#endif
 
-static spinlock_t	*rt_hash_locks;
-# define rt_hash_lock_addr(slot) &rt_hash_locks[(slot) & (RT_HASH_LOCK_SZ - 1)]
-# define rt_hash_lock_init()	{ \
-		int i; \
-		rt_hash_locks = kmalloc(sizeof(spinlock_t) * RT_HASH_LOCK_SZ, GFP_KERNEL); \
-		if (!rt_hash_locks) panic("IP: failed to allocate rt_hash_locks\n"); \
-		for (i = 0; i < RT_HASH_LOCK_SZ; i++) \
-			spin_lock_init(&rt_hash_locks[i]); \
-		}
-#else
-# define rt_hash_lock_addr(slot) NULL
-# define rt_hash_lock_init()
-#endif
+static DEFINE_SPINLOCK(rt_hash_lock);
 
 static struct rt_hash_bucket 	*rt_hash_table;
 static unsigned			rt_hash_mask;
@@ -627,7 +599,7 @@ static void rt_check_expire(unsigned lon
 
 		if (*rthp == 0)
 			continue;
-		spin_lock(rt_hash_lock_addr(i));
+		spin_lock(&rt_hash_lock);
 		while ((rth = *rthp) != NULL) {
 			if (rth->u.dst.expires) {
 				/* Entry is expired even if it is in use */
@@ -660,7 +632,7 @@ static void rt_check_expire(unsigned lon
  			rt_free(rth);
 #endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 		}
-		spin_unlock(rt_hash_lock_addr(i));
+		spin_unlock(&rt_hash_lock);
 
 		/* Fallback loop breaker. */
 		if (time_after(jiffies, now))
@@ -683,11 +655,11 @@ static void rt_run_flush(unsigned long d
 	get_random_bytes(&rt_hash_rnd, 4);
 
 	for (i = rt_hash_mask; i >= 0; i--) {
-		spin_lock_bh(rt_hash_lock_addr(i));
+		spin_lock_bh(&rt_hash_lock);
 		rth = rt_hash_table[i].chain;
 		if (rth)
 			rt_hash_table[i].chain = NULL;
-		spin_unlock_bh(rt_hash_lock_addr(i));
+		spin_unlock_bh(&rt_hash_lock);
 
 		for (; rth; rth = next) {
 			next = rth->u.rt_next;
@@ -820,7 +792,7 @@ static int rt_garbage_collect(void)
 
 			k = (k + 1) & rt_hash_mask;
 			rthp = &rt_hash_table[k].chain;
-			spin_lock_bh(rt_hash_lock_addr(k));
+			spin_lock_bh(&rt_hash_lock);
 			while ((rth = *rthp) != NULL) {
 				if (!rt_may_expire(rth, tmo, expire)) {
 					tmo >>= 1;
@@ -852,7 +824,7 @@ static int rt_garbage_collect(void)
 				goal--;
 #endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 			}
-			spin_unlock_bh(rt_hash_lock_addr(k));
+			spin_unlock_bh(&rt_hash_lock);
 			if (goal <= 0)
 				break;
 		}
@@ -922,7 +894,7 @@ restart:
 
 	rthp = &rt_hash_table[hash].chain;
 
-	spin_lock_bh(rt_hash_lock_addr(hash));
+	spin_lock_bh(&rt_hash_lock);
 	while ((rth = *rthp) != NULL) {
 #ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
 		if (!(rth->u.dst.flags & DST_BALANCED) &&
@@ -948,7 +920,7 @@ restart:
 			rth->u.dst.__use++;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.lastuse = now;
-			spin_unlock_bh(rt_hash_lock_addr(hash));
+			spin_unlock_bh(&rt_hash_lock);
 
 			rt_drop(rt);
 			*rp = rth;
@@ -989,7 +961,7 @@ restart:
 	if (rt->rt_type == RTN_UNICAST || rt->fl.iif == 0) {
 		int err = arp_bind_neighbour(&rt->u.dst);
 		if (err) {
-			spin_unlock_bh(rt_hash_lock_addr(hash));
+			spin_unlock_bh(&rt_hash_lock);
 
 			if (err != -ENOBUFS) {
 				rt_drop(rt);
@@ -1030,7 +1002,7 @@ restart:
 	}
 #endif
 	rt_hash_table[hash].chain = rt;
-	spin_unlock_bh(rt_hash_lock_addr(hash));
+	spin_unlock_bh(&rt_hash_lock);
 	*rp = rt;
 	return 0;
 }
@@ -1098,7 +1070,7 @@ static void rt_del(unsigned hash, struct
 {
 	struct rtable **rthp;
 
-	spin_lock_bh(rt_hash_lock_addr(hash));
+	spin_lock_bh(&rt_hash_lock);
 	ip_rt_put(rt);
 	for (rthp = &rt_hash_table[hash].chain; *rthp;
 	     rthp = &(*rthp)->u.rt_next)
@@ -1107,7 +1079,7 @@ static void rt_del(unsigned hash, struct
 			rt_free(rt);
 			break;
 		}
-	spin_unlock_bh(rt_hash_lock_addr(hash));
+	spin_unlock_bh(&rt_hash_lock);
 }
 
 void ip_rt_redirect(u32 old_gw, u32 daddr, u32 new_gw,
@@ -3155,7 +3127,6 @@ int __init ip_rt_init(void)
 					&rt_hash_mask,
 					0);
 	memset(rt_hash_table, 0, (rt_hash_mask + 1) * sizeof(struct rt_hash_bucket));
-	rt_hash_lock_init();
 
 	ipv4_dst_ops.gc_thresh = (rt_hash_mask + 1);
 	ip_rt_max_size = (rt_hash_mask + 1) * 16;
