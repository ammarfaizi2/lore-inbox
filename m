Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUIGWgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUIGWgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUIGWgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:36:12 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:18181 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268717AbUIGWen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:34:43 -0400
Date: Tue, 7 Sep 2004 15:30:37 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: shemminger@osdl.org, ak@suse.de, dipankar@in.ibm.com, maneesh@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Add rcu_assign_pointer() to kill more memory barriers
Message-ID: <20040907223037.GA13346@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Attached is a patch that adds an rcu_assign_pointer() that allows
a number of explicit smp_wmb() memory barriers to be dispensed with,
improving readability.

 arch/x86_64/kernel/mce.c |    3 +--
 include/linux/list.h     |    2 --
 include/linux/rcupdate.h |   18 ++++++++++++++++++
 net/core/netfilter.c     |    3 +--
 net/decnet/dn_route.c    |   13 +++++--------
 net/ipv4/devinet.c       |    3 +--
 net/ipv4/route.c         |    7 +++----
 net/sched/sch_api.c      |    3 +--
 8 files changed, 30 insertions(+), 22 deletions(-)

Although this patch adds more lines that it deletes, the fact that
a number of the removed lines are smp_wmb() deserves some consideration.

------------------------------------------------------------------------

Log of changes, non-changes, and questions (search for "?" for the latter):

Instances of smp_wmb() changed to rcu_assign_pointer():

o	net/core/netfilter.c in nf_log_register() near line 754.

o	net/decnet/dn_route.c in dn_insert_route() near line 290 and 292,
	and also after the loop.

o	net/ipv4/devinet.c in inetdev_init() near line 161.

o	net/ipv4/route.c in rt_intern_hash near lines 796 and 802.

o	net/sched/sch_api.c in qdisc_create() near line 454 -- but
	instead convert list_add_tail() to list_add_tail_rcu().
	Not clear where the corresponding rcu_read_lock()s are...

RCU-related instances of smp_wmb() that I did not convert to
rcu_assign_pointer():

o	include/linux/list.h in hlist_add_head_rcu() near line 591.
	Converting this causes some include-file pain, so ignoring
	it for the moment.

o	arch/x86_64/kernel/mce.c in mce_log() near line 50.  This
	appears to be more of a communication write than a structure
	initialization.

	Ditto for the pair near the end of mce_log().

o	fs/dcache.c in d_move() near line 1241.  The actual pointer
	assignments are in the do_switch() macro.  One approach would
	be to update the do_switch() macro to use rcu_assign_pointer(),
	but only one of four do_switch() invocations requires the
	memory barrier.  Leave for now.

o	include/linux/list.h in __list_add_rcu() near line 94.
	Both prev and next may be traversed, but don't want either
	misleading code or extra smp_wmb()s.  However, currently,
	only next is traversed, so considering saying that one cannot
	traverse prev with RCU protection.  Thoughts?  Any use of
	smp_assign_pointer() here will cause the same include-file
	pain seen in hlist_add_head_rcu() above.

o	ipc/util.c in grow_ary() near line 144.  This is changed
	to use rcu_assign_pointer() in conjunction with the patch
	that places the size with the array of entries, which I
	am sending separately.

o	net/sched/sch_generic.c in qdisc_create_dflt() near line 414.
	The pointer is assigned by the caller.  If this sort of
	situation appears too often, it might be worth having an
	rcu_return_pointer()...  Another alternative would be to
	recode the callers to use rcu_assign_pointer().  A third
	alternative would be to recode the callers to pass the pointer
	to be assigned in to qdisc_create_dflt(), so that
	rcu_assign_pointer() could be used.  The value could also be
	returned to allow easy testing of the results.  Thoughts?

Instances of smp_wmb() that appeared redundant:

o	arch/x86_64/kernel/mce.c in mce_read() near line 361.
	The synchronize_kernel() implies a context switch which implies
	lots of smp_wmb() calls.  I removed the smp_wmb().

Instances of smp_wmb() that appeared to have nothing to do with RCU:

o	drivers/net/r8169.c in rtl8169_start_xmit() near line 1561.
	Looks to be interacting with the device.

	Ditto for uses in rtl8169_tx_interrupt() and rtl8169_poll() in
	this same file.

o	drivers/net/typhoon.c typhoon_hello() near line 471.
	Looks like device interaction.

	Ditto for a number of other instances in this same file.

o	drivers/net/wan/dscc4.c in dscc4_tx_irq() near line 1671.
	Interacting with device.

o	fs/aio.c in aio_complete() near line 1000.  Looks like a
	lock-free protocol in aio, but no obvious use of RCU.

o	include/asm-i386/pgtable-3level.h in set_pte() near line 54.
	Forcing proper order of 64-bit-PTE update on x86.

o	include/asm-ppc/rwsem.h in __down_read() near line 73.
	Forcing ordering needed for locking primitive.  Ditto for
	__down_read_trylock(), __down_write(), __down_write_trylock(),
	__up_read(), __up_write(), and __downgrade_write() in this
	same file.

	Ditto also for other architectures.

o	include/asm-ppc/semaphore.h in down() near line 78.
	Forcing ordering needed for locking primitive.  Ditto for
	down_interruptible(), down_trylock(), and up() in this
	same file.

	Ditto also for other architectures.

o	include/linux/seqlock.h forces ordering needed for locking
	primitive.

o	kernel/timer.c in __run_timers() near line 456.
	Locking protocol that does not use RCU.

Other questions:

o	Is hlist_del_rcu_init() what we want?  It causes a concurrent
	scan of the list to end without warning...  It also appears to
	be unused.  Nuking it, since I cannot come up with a legitimate
	use for it.  (Andi, am I missing something here?)

------------------------------------------------------------------------

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
diff -urpN -X ../dontdiff linux-2.5/include/linux/rcupdate.h linux-2.5-rap/include/linux/rcupdate.h
--- linux-2.5/include/linux/rcupdate.h	Tue Sep  7 10:04:29 2004
+++ linux-2.5-rap/include/linux/rcupdate.h	Tue Sep  7 12:12:09 2004
@@ -238,6 +238,24 @@ static inline int rcu_pending(int cpu)
 				(_________p1); \
 				})
 
+/**
+ * rcu_assign_pointer - assign (publicize) a pointer to a newly
+ * initialized structure that will be dereferenced by RCU read-side
+ * critical sections.  Returns the value assigned.
+ *
+ * Inserts memory barriers on architectures that require them
+ * (pretty much all of them other than x86), and also prevents
+ * the compiler from reordering the code that initializes the
+ * structure after the pointer assignment.  More importantly, this
+ * call documents which pointers will be dereferenced by RCU read-side
+ * code.
+ */
+
+#define rcu_assign_pointer(p, v)	({ \
+						smp_wmb(); \
+						(p) = (v); \
+					})
+
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
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
