Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVHHE2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVHHE2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 00:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVHHE2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 00:28:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62969 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750700AbVHHE2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 00:28:36 -0400
Subject: [patch] IPV4 spinlock_casting
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: dwalker@mvista.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 19:04:21 -0700
Message-Id: <1123466661.20677.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a compile error in net/ipv4/route.c when RT patch is applied:

LD      .tmp_vmlinux1
net/built-in.o(.text+0x19058): In function `rt_check_expire':
net/ipv4/route.c:628: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x1907a):net/ipv4/route.c:661: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x1918b): In function `rt_run_flush':
net/ipv4/route.c:684: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x191a3):net/ipv4/route.c:688: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x193b9): In function `rt_garbage_collect':
net/ipv4/route.c:821: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x193e7):net/ipv4/route.c:853: more undefined references to `__bad_spinlock_type' follow
make: *** [.tmp_vmlinux1] Error 1

Problem is related to the RT PICK_OP function.

Adds explicit casting to spinlock_t (whatever that happens to be for the
given .config)

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@mvista.com>

Index: linux-2.6.13-rc4-RT-V0.7.52-14/net/ipv4/route.c
===================================================================
--- linux-2.6.13-rc4-RT-V0.7.52-14.orig/net/ipv4/route.c
+++ linux-2.6.13-rc4-RT-V0.7.52-14/net/ipv4/route.c
@@ -228,7 +228,7 @@
 		rt_hash_locks = kmalloc(sizeof(spinlock_t) * RT_HASH_LOCK_SZ, GFP_KERNEL); \
 		if (!rt_hash_locks) panic("IP: failed to allocate rt_hash_locks\n"); \
 		for (i = 0; i < RT_HASH_LOCK_SZ; i++) \
-			spin_lock_init(&rt_hash_locks[i]); \
+			spin_lock_init((spinlock_t *) &rt_hash_locks[i]); \
 		}
 #else
 # define rt_hash_lock_addr(slot) NULL
@@ -625,7 +625,7 @@
 
 		if (*rthp == 0)
 			continue;
-		spin_lock(rt_hash_lock_addr(i));
+		spin_lock((spinlock_t *) rt_hash_lock_addr(i));
 		while ((rth = *rthp) != NULL) {
 			if (rth->u.dst.expires) {
 				/* Entry is expired even if it is in use */
@@ -658,7 +658,7 @@
  			rt_free(rth);
 #endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 		}
-		spin_unlock(rt_hash_lock_addr(i));
+		spin_unlock((spinlock_t *) rt_hash_lock_addr(i));
 
 		/* Fallback loop breaker. */
 		if (time_after(jiffies, now))
@@ -681,11 +681,11 @@
 	get_random_bytes(&rt_hash_rnd, 4);
 
 	for (i = rt_hash_mask; i >= 0; i--) {
-		spin_lock_bh(rt_hash_lock_addr(i));
+		spin_lock_bh((spinlock_t *) rt_hash_lock_addr(i));
 		rth = rt_hash_table[i].chain;
 		if (rth)
 			rt_hash_table[i].chain = NULL;
-		spin_unlock_bh(rt_hash_lock_addr(i));
+		spin_unlock_bh((spinlock_t *) rt_hash_lock_addr(i));
 
 		for (; rth; rth = next) {
 			next = rth->u.rt_next;
@@ -818,7 +818,7 @@
 
 			k = (k + 1) & rt_hash_mask;
 			rthp = &rt_hash_table[k].chain;
-			spin_lock_bh(rt_hash_lock_addr(k));
+			spin_lock_bh((spinlock_t *) rt_hash_lock_addr(k));
 			while ((rth = *rthp) != NULL) {
 				if (!rt_may_expire(rth, tmo, expire)) {
 					tmo >>= 1;
@@ -850,7 +850,7 @@
 				goal--;
 #endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */
 			}
-			spin_unlock_bh(rt_hash_lock_addr(k));
+			spin_unlock_bh((spinlock_t *)rt_hash_lock_addr(k));
 			if (goal <= 0)
 				break;
 		}
@@ -920,7 +920,7 @@
 
 	rthp = &rt_hash_table[hash].chain;
 
-	spin_lock_bh(rt_hash_lock_addr(hash));
+	spin_lock_bh((spinlock_t *) rt_hash_lock_addr(hash));
 	while ((rth = *rthp) != NULL) {
 #ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
 		if (!(rth->u.dst.flags & DST_BALANCED) &&
@@ -946,7 +946,7 @@
 			rth->u.dst.__use++;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.lastuse = now;
-			spin_unlock_bh(rt_hash_lock_addr(hash));
+			spin_unlock_bh((spinlock_t *)rt_hash_lock_addr(hash));
 
 			rt_drop(rt);
 			*rp = rth;
@@ -987,7 +987,7 @@
 	if (rt->rt_type == RTN_UNICAST || rt->fl.iif == 0) {
 		int err = arp_bind_neighbour(&rt->u.dst);
 		if (err) {
-			spin_unlock_bh(rt_hash_lock_addr(hash));
+			spin_unlock_bh((spinlock_t *)rt_hash_lock_addr(hash));
 
 			if (err != -ENOBUFS) {
 				rt_drop(rt);
@@ -1028,7 +1028,7 @@
 	}
 #endif
 	rt_hash_table[hash].chain = rt;
-	spin_unlock_bh(rt_hash_lock_addr(hash));
+	spin_unlock_bh((spinlock_t *)rt_hash_lock_addr(hash));
 	*rp = rt;
 	return 0;
 }
@@ -1096,7 +1096,7 @@
 {
 	struct rtable **rthp;
 
-	spin_lock_bh(rt_hash_lock_addr(hash));
+	spin_lock_bh((spinlock_t *) rt_hash_lock_addr(hash));
 	ip_rt_put(rt);
 	for (rthp = &rt_hash_table[hash].chain; *rthp;
 	     rthp = &(*rthp)->u.rt_next)
@@ -1105,7 +1105,7 @@
 			rt_free(rt);
 			break;
 		}
-	spin_unlock_bh(rt_hash_lock_addr(hash));
+	spin_unlock_bh((spinlock_t *) rt_hash_lock_addr(hash));
 }
 
 void ip_rt_redirect(u32 old_gw, u32 daddr, u32 new_gw,


