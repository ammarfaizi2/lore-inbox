Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbSK2Peo>; Fri, 29 Nov 2002 10:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbSK2Peo>; Fri, 29 Nov 2002 10:34:44 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:46609 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267084AbSK2Pdc>; Fri, 29 Nov 2002 10:33:32 -0500
Date: Fri, 29 Nov 2002 16:40:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [DRFC] brlock meets rcu or why even try_module_get won't scale
Message-ID: <Pine.LNX.4.44.0211291522440.2113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I promised to shut up for a while, but I was checking the locking in the 
ip stack and I got an idea to improve it, which also nicely shows why 
try_module_get is the wrong way to go as general solution. Some people 
might be interested in the former, so I'm using it as a bait to get some 
attention to the latter, which nobody seems to care about.
(Note: I haven't tested the patch very much, so it might not work at all, 
but the basic idea should work, at least I haven't found a reason why it 
shouldn't.)

The new lock basically joins the best ideas from brlock, rcu and rusty's 
module ref, which makes the read path even cheaper than try_module_get, 
but keeps the write path acceptable compared to rcu or the module unload 
massacre. It does that by adding minimal overhead to the read path to 
allow the write path to detect whether any reader is within a critical 
region. Within the write path we use rcu techniques to update pointers and 
afterwards we can synchronise with the read paths to ensure they left the 
critical region. At this point we safely removed the pointer and can check 
the state of the object. It's possible that the reader keeps the object 
busy and the writer must be able to deal with this. A possibility to avoid 
this is to do a live check like try_module_get does, so that the read path 
won't keep the object busy, when the object is about to be removed. What 
pretty much kills this idea is the cost on the write side, as it has to 
stop the whole system to prevent any reader from checking the live state 
and setting the object busy. So we have to think very carefully if we 
really want to remove the object before we shortly shutdown the system.

So the life check makes the read path more expensive (the costs only 
rises if the number of involved modules increases) and the write path 
becomes an avoid-at-all-costs-path. For what? We avoid that the writer 
either waits (by sleeping) for the reader or that it tells the reader to 
cleanup the object when it finished.

For modules this means that unloading either stays a second class citizen 
and should better be turned off and module init races probably stay 
forever. The other possibility is we fix the damn thing and make it a first 
class citizen, so it doesn't impact any fast path and makes the init and 
exit paths safe and comparatively cheap. It would require to say hello to 
the idea that a module might stay in a loaded but uninitialised state 
until we know it's safe to unload, what I think is still better than to 
keep it possibly loaded forever (it's of course always possible to force 
module removal, but I have no idea why anyone would want to risk system 
stability like this except for debugging). If a module wants to avoid this 
state, it is possible to provide start/stop functions, but this is not 
required and not needed to fix any fatal races.

All this does require quite some work, but in the end it will be worth it 
and it can be done without breaking everything at once, e.g. we can 
continue using a global module use count or allow the module to provide 
its own. Interfaces can be updated one by one after discussing them. There 
is and was also no need to abruptly break all module interfaces (I posted 
enough example code and since I wasn't flamed for it, I can assume it 
looks well possible?). But it would help a lot if this would be discussed 
a bit, at least tell me that I'm an idiot and I should just go away, but 
all the silence makes me damn nervous. I hope I get at least some 
feed back about the idea below, as it might be interesting for a quite a 
few other areas (e.g. dcache).

bye, Roman

Index: include/linux/brlock.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/linux/brlock.h,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 brlock.h
--- include/linux/brlock.h	1 Oct 2002 15:51:31 -0000	1.1.1.7
+++ include/linux/brlock.h	28 Nov 2002 14:54:15 -0000
@@ -44,38 +44,22 @@ enum brlock_indices {
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 
-#if defined(__i386__) || defined(__ia64__) || defined(__x86_64__)
-#define __BRLOCK_USE_ATOMICS
-#else
-#undef __BRLOCK_USE_ATOMICS
-#endif
-
-#ifdef __BRLOCK_USE_ATOMICS
-typedef rwlock_t	brlock_read_lock_t;
-#else
-typedef unsigned int	brlock_read_lock_t;
-#endif
-
 /*
  * align last allocated index to the next cacheline:
  */
 #define __BR_IDX_MAX \
-	(((sizeof(brlock_read_lock_t)*__BR_END + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1)) / sizeof(brlock_read_lock_t))
+	(((sizeof(unsigned int)*__BR_END + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1)) / sizeof(unsigned int))
 
-extern brlock_read_lock_t __brlock_array[NR_CPUS][__BR_IDX_MAX];
+extern unsigned int __brlock_array[NR_CPUS][__BR_IDX_MAX];
 
-#ifndef __BRLOCK_USE_ATOMICS
 struct br_wrlock {
 	spinlock_t lock;
 } __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
 
 extern struct br_wrlock __br_write_locks[__BR_IDX_MAX];
-#endif
 
 extern void __br_lock_usage_bug (void);
 
-#ifdef __BRLOCK_USE_ATOMICS
-
 static inline void br_read_lock (enum brlock_indices idx)
 {
 	/*
@@ -86,7 +70,8 @@ static inline void br_read_lock (enum br
 		__br_lock_usage_bug();
 
 	preempt_disable();
-	_raw_read_lock(&__brlock_array[smp_processor_id()][idx]);
+	__brlock_array[smp_processor_id()][idx]++;
+	wmb();
 }
 
 static inline void br_read_unlock (enum brlock_indices idx)
@@ -94,15 +79,13 @@ static inline void br_read_unlock (enum 
 	if (idx >= __BR_END)
 		__br_lock_usage_bug();
 
-	read_unlock(&__brlock_array[smp_processor_id()][idx]);
+	wmb();
+	__brlock_array[smp_processor_id()][idx]--;
+	preempt_enable();
 }
 
-#else /* ! __BRLOCK_USE_ATOMICS */
-static inline void br_read_lock (enum brlock_indices idx)
+static inline void br_write_lock (enum brlock_indices idx)
 {
-	unsigned int *ctr;
-	spinlock_t *lock;
-
 	/*
 	 * This causes a link-time bug message if an
 	 * invalid index is used:
@@ -110,73 +93,33 @@ static inline void br_read_lock (enum br
 	if (idx >= __BR_END)
 		__br_lock_usage_bug();
 
-	preempt_disable();
-	ctr = &__brlock_array[smp_processor_id()][idx];
-	lock = &__br_write_locks[idx].lock;
-again:
-	(*ctr)++;
-	mb();
-	if (spin_is_locked(lock)) {
-		(*ctr)--;
-		wmb(); /*
-			* The release of the ctr must become visible
-			* to the other cpus eventually thus wmb(),
-			* we don't care if spin_is_locked is reordered
-			* before the releasing of the ctr.
-			* However IMHO this wmb() is superflous even in theory.
-			* It would not be superflous only if on the
-			* other CPUs doing a ldl_l instead of an ldl
-			* would make a difference and I don't think this is
-			* the case.
-			* I'd like to clarify this issue further
-			* but for now this is a slow path so adding the
-			* wmb() will keep us on the safe side.
-			*/
-		while (spin_is_locked(lock))
-			barrier();
-		goto again;
-	}
+	spin_lock(&__br_write_locks[idx].lock);
 }
 
-static inline void br_read_unlock (enum brlock_indices idx)
+static inline void br_write_unlock (enum brlock_indices idx)
 {
-	unsigned int *ctr;
-
 	if (idx >= __BR_END)
 		__br_lock_usage_bug();
 
-	ctr = &__brlock_array[smp_processor_id()][idx];
-
-	wmb();
-	(*ctr)--;
-	preempt_enable();
+	spin_unlock(&__br_write_locks[idx].lock);
 }
-#endif /* __BRLOCK_USE_ATOMICS */
-
-/* write path not inlined - it's rare and larger */
 
-extern void FASTCALL(__br_write_lock (enum brlock_indices idx));
-extern void FASTCALL(__br_write_unlock (enum brlock_indices idx));
+extern void FASTCALL(__br_write_sync (enum brlock_indices idx));
 
-static inline void br_write_lock (enum brlock_indices idx)
+static inline void br_write_sync (enum brlock_indices idx)
 {
 	if (idx >= __BR_END)
 		__br_lock_usage_bug();
-	__br_write_lock(idx);
+	__br_write_sync(idx);
 }
 
-static inline void br_write_unlock (enum brlock_indices idx)
-{
-	if (idx >= __BR_END)
-		__br_lock_usage_bug();
-	__br_write_unlock(idx);
-}
 
 #else
 # define br_read_lock(idx)	({ (void)(idx); preempt_disable(); })
 # define br_read_unlock(idx)	({ (void)(idx); preempt_enable(); })
 # define br_write_lock(idx)	({ (void)(idx); preempt_disable(); })
 # define br_write_unlock(idx)	({ (void)(idx); preempt_enable(); })
+# define br_write_sync(idx)	({ (void)(idx); })
 #endif	/* CONFIG_SMP */
 
 /*
Index: lib/brlock.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/lib/brlock.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 brlock.c
--- lib/brlock.c	14 Oct 2002 08:28:36 -0000	1.1.1.3
+++ lib/brlock.c	28 Nov 2002 15:08:56 -0000
@@ -15,58 +15,26 @@
 #include <linux/sched.h>
 #include <linux/brlock.h>
 
-#ifdef __BRLOCK_USE_ATOMICS
-
-brlock_read_lock_t __brlock_array[NR_CPUS][__BR_IDX_MAX] =
-   { [0 ... NR_CPUS-1] = { [0 ... __BR_IDX_MAX-1] = RW_LOCK_UNLOCKED } };
-
-void __br_write_lock (enum brlock_indices idx)
-{
-	int i;
-
-	preempt_disable();
-	for (i = 0; i < NR_CPUS; i++)
-		_raw_write_lock(&__brlock_array[i][idx]);
-}
-
-void __br_write_unlock (enum brlock_indices idx)
-{
-	int i;
-
-	for (i = 0; i < NR_CPUS; i++)
-		_raw_write_unlock(&__brlock_array[i][idx]);
-	preempt_enable();
-}
-
-#else /* ! __BRLOCK_USE_ATOMICS */
-
-brlock_read_lock_t __brlock_array[NR_CPUS][__BR_IDX_MAX] =
+unsigned int __brlock_array[NR_CPUS][__BR_IDX_MAX] =
    { [0 ... NR_CPUS-1] = { [0 ... __BR_IDX_MAX-1] = 0 } };
 
 struct br_wrlock __br_write_locks[__BR_IDX_MAX] =
    { [0 ... __BR_IDX_MAX-1] = { SPIN_LOCK_UNLOCKED } };
 
-void __br_write_lock (enum brlock_indices idx)
+void __br_write_sync (enum brlock_indices idx)
 {
-	int i;
+	int cpu, mask, i, j;
 
-	preempt_disable();
-again:
-	_raw_spin_lock(&__br_write_locks[idx].lock);
-	for (i = 0; i < NR_CPUS; i++)
-		if (__brlock_array[i][idx] != 0) {
-			_raw_spin_unlock(&__br_write_locks[idx].lock);
-			barrier();
-			cpu_relax();
-			goto again;
+	cpu = get_cpu();
+	mask = cpu_online_map & ~(1 << cpu);
+	while (mask) {
+		for (i = 0, j = 1; i < NR_CPUS; j <<= 1, i++) {
+			if ((mask & j) && !__brlock_array[i][idx])
+				mask &= ~j;
 		}
+		cpu_relax();
+	}
+	put_cpu();
 }
-
-void __br_write_unlock (enum brlock_indices idx)
-{
-	spin_unlock(&__br_write_locks[idx].lock);
-}
-
-#endif /* __BRLOCK_USE_ATOMICS */
 
 #endif /* CONFIG_SMP */
Index: net/802/psnap.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/802/psnap.c,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 psnap.c
--- net/802/psnap.c	31 Oct 2002 13:30:59 -0000	1.1.1.6
+++ net/802/psnap.c	28 Nov 2002 11:42:02 -0000
@@ -135,7 +135,7 @@ struct datalink_proto *register_snap_cli
 		proto->rcvfunc		= rcvfunc;
 		proto->header_length	= 5 + 3; /* snap + 802.2 */
 		proto->request		= snap_request;
-		list_add(&proto->node, &snap_list);
+		list_add_rcu(&proto->node, &snap_list);
 	}
 out:
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
@@ -149,10 +149,11 @@ void unregister_snap_client(struct datal
 {
 	br_write_lock_bh(BR_NETPROTO_LOCK);
 
-	list_del(&proto->node);
-	kfree(proto);
+	list_del_rcu(&proto->node);
+	br_write_sync(BR_NETPROTO_LOCK);
 
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	kfree(proto);
 }
 
 MODULE_LICENSE("GPL");
Index: net/8021q/vlan.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/8021q/vlan.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 vlan.c
--- net/8021q/vlan.c	25 Nov 2002 11:17:57 -0000	1.1.1.7
+++ net/8021q/vlan.c	28 Nov 2002 11:43:20 -0000
@@ -233,6 +233,8 @@ static int unregister_vlan_dev(struct ne
 
 			br_write_lock(BR_NETPROTO_LOCK);
 			grp->vlan_devices[vlan_id] = NULL;
+			wmb();
+			br_write_sync(BR_NETPROTO_LOCK);
 			br_write_unlock(BR_NETPROTO_LOCK);
 
 
Index: net/bridge/br.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/bridge/br.c,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 br.c
--- net/bridge/br.c	31 Oct 2002 13:31:01 -0000	1.1.1.6
+++ net/bridge/br.c	28 Nov 2002 11:43:40 -0000
@@ -75,6 +75,8 @@ static void __exit br_deinit(void)
 
 	br_write_lock_bh(BR_NETPROTO_LOCK);
 	br_handle_frame_hook = NULL;
+	wmb();
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
Index: net/bridge/netfilter/ebtable_broute.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/bridge/netfilter/ebtable_broute.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 ebtable_broute.c
--- net/bridge/netfilter/ebtable_broute.c	1 Oct 2002 14:42:51 -0000	1.1.1.1
+++ net/bridge/netfilter/ebtable_broute.c	28 Nov 2002 11:48:15 -0000
@@ -61,6 +61,7 @@ static int __init init(void)
 	br_write_lock_bh(BR_NETPROTO_LOCK);
 	// see br_input.c
 	br_should_route_hook = ebt_broute;
+	wmb();
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	return ret;
 }
@@ -69,6 +70,8 @@ static void __exit fini(void)
 {
 	br_write_lock_bh(BR_NETPROTO_LOCK);
 	br_should_route_hook = NULL;
+	wmb();
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	ebt_unregister_table(&broute_table);
 }
Index: net/core/dev.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/core/dev.c,v
retrieving revision 1.1.1.16
diff -u -p -r1.1.1.16 dev.c
--- net/core/dev.c	25 Nov 2002 11:18:01 -0000	1.1.1.16
+++ net/core/dev.c	28 Nov 2002 14:54:32 -0000
@@ -253,6 +253,7 @@ void dev_add_pack(struct packet_type *pt
 	if (pt->type == htons(ETH_P_ALL)) {
 		netdev_nit++;
 		pt->next  = ptype_all;
+		wmb();
 		ptype_all = pt;
 	} else {
 		hash = ntohs(pt->type) & 15;
@@ -287,10 +288,12 @@ void dev_remove_pack(struct packet_type 
 	for (; *pt1; pt1 = &((*pt1)->next)) {
 		if (pt == *pt1) {
 			*pt1 = pt->next;
+			wmb();
 #ifdef CONFIG_NET_FASTROUTE
 			if (pt->data)
 				netdev_fastroute_obstacles--;
 #endif
+			br_write_sync(BR_NETPROTO_LOCK);
 			goto out;
 		}
 	}
@@ -886,7 +889,8 @@ void dev_queue_xmit_nit(struct sk_buff *
 	do_gettimeofday(&skb->stamp);
 
 	br_read_lock(BR_NETPROTO_LOCK);
-	for (ptype = ptype_all; ptype; ptype = ptype->next) {
+	for (ptype = ptype_all; ptype;
+	     ({ read_barrier_depends(); }), ptype = ptype->next) {
 		/* Never send packets back to the socket
 		 * they originated from - MvS (miquels@drinkel.ow.org)
 		 */
@@ -1869,6 +1873,7 @@ int netdev_set_master(struct net_device 
 
 	br_write_lock_bh(BR_NETPROTO_LOCK);
 	slave->master = master;
+	wmb();
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 	if (old)
@@ -2561,6 +2566,7 @@ int unregister_netdevice(struct net_devi
 
 	/* Synchronize to net_rx_action. */
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 
Index: net/core/netfilter.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/core/netfilter.c,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 netfilter.c
--- net/core/netfilter.c	11 Nov 2002 09:46:54 -0000	1.1.1.6
+++ net/core/netfilter.c	28 Nov 2002 12:54:24 -0000
@@ -68,7 +68,7 @@ int nf_register_hook(struct nf_hook_ops 
 		if (reg->priority < ((struct nf_hook_ops *)i)->priority)
 			break;
 	}
-	list_add(&reg->list, i->prev);
+	list_add_rcu(&reg->list, i->prev);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	return 0;
 }
@@ -76,7 +76,8 @@ int nf_register_hook(struct nf_hook_ops 
 void nf_unregister_hook(struct nf_hook_ops *reg)
 {
 	br_write_lock_bh(BR_NETPROTO_LOCK);
-	list_del(&reg->list);
+	list_del_rcu(&reg->list);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 }
 
@@ -344,7 +345,7 @@ static unsigned int nf_iterate(struct li
 			       int (*okfn)(struct sk_buff *),
 			       int hook_thresh)
 {
-	for (*i = (*i)->next; *i != head; *i = (*i)->next) {
+	__list_for_each_rcu(*i, head) {
 		struct nf_hook_ops *elem = (struct nf_hook_ops *)*i;
 
 		if (hook_thresh > elem->priority)
@@ -385,8 +386,9 @@ int nf_register_queue_handler(int pf, nf
 	if (queue_handler[pf].outfn)
 		ret = -EBUSY;
 	else {
-		queue_handler[pf].outfn = outfn;
 		queue_handler[pf].data = data;
+		wmb();
+		queue_handler[pf].outfn = outfn;
 		ret = 0;
 	}
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
@@ -399,7 +401,9 @@ int nf_unregister_queue_handler(int pf)
 {
 	br_write_lock_bh(BR_NETPROTO_LOCK);
 	queue_handler[pf].outfn = NULL;
+	wmb();
 	queue_handler[pf].data = NULL;
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	return 0;
 }
@@ -540,6 +544,7 @@ void nf_reinject(struct sk_buff *skb, st
 			verdict = NF_DROP;
 			break;
 		}
+		read_barrier_depends();
 	}
 
 	/* Continue traversal iff userspace said ok... */
Index: net/ipv4/af_inet.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv4/af_inet.c,v
retrieving revision 1.1.1.17
diff -u -p -r1.1.1.17 af_inet.c
--- net/ipv4/af_inet.c	18 Nov 2002 09:54:23 -0000	1.1.1.17
+++ net/ipv4/af_inet.c	28 Nov 2002 12:55:33 -0000
@@ -340,7 +340,7 @@ static int inet_create(struct socket *so
 	/* Look for the requested type/protocol pair. */
 	answer = NULL;
 	br_read_lock_bh(BR_NETPROTO_LOCK);
-	list_for_each(p, &inetsw[sock->type]) {
+	list_for_each_rcu(p, &inetsw[sock->type]) {
 		answer = list_entry(p, struct inet_protosw, list);
 
 		/* Check the non-wild match. */
@@ -1003,7 +1003,7 @@ void inet_register_protosw(struct inet_p
 	 * entry.  This means that when we remove this entry, the
 	 * system automatically returns to the old behavior.
 	 */
-	list_add(&p->list, &inetsw[p->type]);
+	list_add_rcu(&p->list, &inetsw[p->type]);
 out:
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	return;
@@ -1028,7 +1028,8 @@ void inet_unregister_protosw(struct inet
 		       p->protocol);
 	} else {
 		br_write_lock_bh(BR_NETPROTO_LOCK);
-		list_del(&p->list);
+		list_del_rcu(&p->list);
+		br_write_sync(BR_NETPROTO_LOCK);
 		br_write_unlock_bh(BR_NETPROTO_LOCK);
 	}
 }
Index: net/ipv4/protocol.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv4/protocol.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 protocol.c
--- net/ipv4/protocol.c	14 Oct 2002 08:28:45 -0000	1.1.1.3
+++ net/ipv4/protocol.c	28 Nov 2002 12:57:06 -0000
@@ -66,6 +66,7 @@ int inet_add_protocol(struct inet_protoc
 		ret = -1;
 	} else {
 		inet_protos[hash] = prot;
+		wmb();
 		ret = 0;
 	}
 
@@ -88,6 +89,8 @@ int inet_del_protocol(struct inet_protoc
 
 	if (inet_protos[hash] == prot) {
 		inet_protos[hash] = NULL;
+		wmb();
+		br_write_sync(BR_NETPROTO_LOCK);
 		ret = 0;
 	} else {
 		ret = -1;
Index: net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv4/netfilter/ip_conntrack_core.c,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 ip_conntrack_core.c
--- net/ipv4/netfilter/ip_conntrack_core.c	16 Oct 2002 09:04:04 -0000	1.1.1.6
+++ net/ipv4/netfilter/ip_conntrack_core.c	28 Nov 2002 12:55:53 -0000
@@ -1163,6 +1163,7 @@ void ip_conntrack_helper_unregister(stru
 
 	/* Someone could be still looking at the helper in a bh. */
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 	MOD_DEC_USE_COUNT;
@@ -1389,6 +1390,7 @@ void ip_conntrack_cleanup(void)
            netfilter framework.  Roll on, two-stage module
            delete... */
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
  
  i_see_dead_people:
Index: net/ipv4/netfilter/ip_conntrack_standalone.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv4/netfilter/ip_conntrack_standalone.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 ip_conntrack_standalone.c
--- net/ipv4/netfilter/ip_conntrack_standalone.c	31 Oct 2002 13:31:06 -0000	1.1.1.7
+++ net/ipv4/netfilter/ip_conntrack_standalone.c	28 Nov 2002 12:56:02 -0000
@@ -328,6 +328,7 @@ void ip_conntrack_protocol_unregister(st
 	
 	/* Somebody could be still looking at the proto in bh. */
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 	/* Remove all contrack entries for this protocol */
Index: net/ipv4/netfilter/ip_nat_helper.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv4/netfilter/ip_nat_helper.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 ip_nat_helper.c
--- net/ipv4/netfilter/ip_nat_helper.c	18 Nov 2002 09:54:25 -0000	1.1.1.5
+++ net/ipv4/netfilter/ip_nat_helper.c	28 Nov 2002 12:56:08 -0000
@@ -441,6 +441,7 @@ void ip_nat_helper_unregister(struct ip_
 
 	/* Someone could be still looking at the helper in a bh. */
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 	/* Find anything using it, and umm, kill them.  We can't turn
Index: net/ipv4/netfilter/ip_nat_snmp_basic.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv4/netfilter/ip_nat_snmp_basic.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 ip_nat_snmp_basic.c
--- net/ipv4/netfilter/ip_nat_snmp_basic.c	8 Oct 2002 09:34:30 -0000	1.1.1.5
+++ net/ipv4/netfilter/ip_nat_snmp_basic.c	28 Nov 2002 12:56:15 -0000
@@ -1352,6 +1352,7 @@ static void __exit fini(void)
 	ip_nat_helper_unregister(&snmp);
 	ip_nat_helper_unregister(&snmp_trap);
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 }
 
Index: net/ipv4/netfilter/ip_nat_standalone.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv4/netfilter/ip_nat_standalone.c,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 ip_nat_standalone.c
--- net/ipv4/netfilter/ip_nat_standalone.c	8 Oct 2002 09:34:30 -0000	1.1.1.6
+++ net/ipv4/netfilter/ip_nat_standalone.c	28 Nov 2002 12:56:25 -0000
@@ -271,6 +271,7 @@ void ip_nat_protocol_unregister(struct i
 
 	/* Someone could be still looking at the proto in a bh. */
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 	MOD_DEC_USE_COUNT;
Index: net/ipv4/netfilter/ip_queue.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv4/netfilter/ip_queue.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 ip_queue.c
--- net/ipv4/netfilter/ip_queue.c	12 Aug 2002 08:17:38 -0000	1.1.1.5
+++ net/ipv4/netfilter/ip_queue.c	28 Nov 2002 12:56:34 -0000
@@ -667,6 +667,7 @@ init_or_cleanup(int init)
 cleanup:
 	nf_unregister_queue_handler(PF_INET);
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	ipq_flush(NF_DROP);
 	
Index: net/ipv6/af_inet6.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv6/af_inet6.c,v
retrieving revision 1.1.1.10
diff -u -p -r1.1.1.10 af_inet6.c
--- net/ipv6/af_inet6.c	18 Nov 2002 09:54:26 -0000	1.1.1.10
+++ net/ipv6/af_inet6.c	28 Nov 2002 12:57:44 -0000
@@ -164,7 +164,7 @@ static int inet6_create(struct socket *s
 	/* Look for the requested type/protocol pair. */
 	answer = NULL;
 	br_read_lock_bh(BR_NETPROTO_LOCK);
-	list_for_each(p, &inetsw6[sock->type]) {
+	list_for_each_rcu(p, &inetsw6[sock->type]) {
 		answer = list_entry(p, struct inet_protosw, list);
 
 		/* Check the non-wild match. */
@@ -596,7 +596,7 @@ inet6_register_protosw(struct inet_proto
 	 * entry.  This means that when we remove this entry, the
 	 * system automatically returns to the old behavior.
 	 */
-	list_add(&p->list, &inetsw6[p->type]);
+	list_add_rcu(&p->list, &inetsw6[p->type]);
 out:
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	return;
Index: net/ipv6/protocol.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv6/protocol.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 protocol.c
--- net/ipv6/protocol.c	14 Oct 2002 08:28:48 -0000	1.1.1.2
+++ net/ipv6/protocol.c	28 Nov 2002 12:58:21 -0000
@@ -52,6 +52,7 @@ int inet6_add_protocol(struct inet6_prot
 		ret = -1;
 	} else {
 		inet6_protos[hash] = prot;
+		wmb();
 		ret = 0;
 	}
 
@@ -74,6 +75,8 @@ int inet6_del_protocol(struct inet6_prot
 		ret = -1;
 	} else {
 		inet6_protos[hash] = NULL;
+		wmb();
+		br_write_sync(BR_NETPROTO_LOCK);
 		ret = 0;
 	}
 
Index: net/ipv6/netfilter/ip6_queue.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/net/ipv6/netfilter/ip6_queue.c,v
retrieving revision 1.1.1.4
diff -u -p -r1.1.1.4 ip6_queue.c
--- net/ipv6/netfilter/ip6_queue.c	8 Oct 2002 09:34:33 -0000	1.1.1.4
+++ net/ipv6/netfilter/ip6_queue.c	28 Nov 2002 12:57:52 -0000
@@ -710,6 +710,7 @@ init_or_cleanup(int init)
 cleanup:
 	nf_unregister_queue_handler(PF_INET6);
 	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_sync(BR_NETPROTO_LOCK);
 	br_write_unlock_bh(BR_NETPROTO_LOCK);
 	ipq_flush(NF_DROP);
 	

