Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbTGaTES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTGaTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:04:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:20668 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S274859AbTGaTEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:04:05 -0400
Date: Fri, 1 Aug 2003 00:36:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       cmm@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 2 of 2
Message-ID: <20030731190645.GD1990@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030731185806.GC1990@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731185806.GC1990@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second part of Rusty's idea - using container_of to
get to the RCU protected structure given the rcu_head in the
callback. It assumes that the rcu_head is embedded in that structure.
This along with the singly-linked rcu_head patch reduces the
size of struct rcu_head by 50%. With rcu_head being used in dentries
and dst_entries, this is useful savings. It does require changes
in call_rcu() API. I have tested the 2 patches with some sanity
tests (dcache/route cache) and RCU works fine.

Thanks
Dipankar



This is a merge of Rusty's patch to save space in rcu_heads
along with the changes required to all the call_rcu() users.
It changes the call_rcu() API and avoids passing an
argument to the callback function. Instead, it is assumed that
the user has embedded the rcu head into a structure that is
useful in the callback and the rcu_head pointer is passed to
the callback. The callback can use container_of() to get the
pointer to its structure and work with it. Together with
the rcu-singly-link patch, it reduces the rcu_head size
by 50%. Considering that we use these in things like
struct dentry and struct dst_entry, this is good savings
in space.


 fs/dcache.c              |    6 +++---
 include/linux/rcupdate.h |   10 ++++------
 include/net/dst.h        |    6 ++++++
 ipc/util.c               |   25 ++++++++++++++++++++-----
 kernel/rcupdate.c        |   25 +++++++++++++++----------
 net/bridge/br_if.c       |    7 ++++---
 net/decnet/dn_route.c    |    4 ++--
 net/ipv4/route.c         |    4 ++--
 8 files changed, 56 insertions(+), 31 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-no-arg include/linux/rcupdate.h
--- linux-2.6.0-test2-rcu/include/linux/rcupdate.h~rcu-no-arg	2003-07-31 16:13:19.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/include/linux/rcupdate.h	2003-07-31 16:13:19.000000000 +0530
@@ -44,18 +44,16 @@
  * struct rcu_head - callback structure for use with RCU
  * @next: next update requests in a list
  * @func: actual update function to call after the grace period.
- * @arg: argument to be passed to the actual update function.
  */
 struct rcu_head {
 	struct rcu_head *next;
-	void (*func)(void *obj);
-	void *arg;
+	void (*func)(struct rcu_head *head);
 };
 
-#define RCU_HEAD_INIT(head) { .next = NULL, .func = NULL, .arg = NULL }
+#define RCU_HEAD_INIT(head) { .next = NULL, .func = NULL }
 #define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
 #define INIT_RCU_HEAD(ptr) do { \
-       (ptr)->next = NULL; (ptr)->func = NULL; (ptr)->arg = NULL; \
+       (ptr)->next = NULL; (ptr)->func = NULL; \
 } while (0)
 
 
@@ -127,7 +125,7 @@ extern void rcu_check_callbacks(int cpu,
 
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
-                          void (*func)(void *arg), void *arg));
+				void (*func)(struct rcu_head *head)));
 extern void synchronize_kernel(void);
 
 #endif /* __KERNEL__ */
diff -puN kernel/rcupdate.c~rcu-no-arg kernel/rcupdate.c
--- linux-2.6.0-test2-rcu/kernel/rcupdate.c~rcu-no-arg	2003-07-31 16:13:19.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/kernel/rcupdate.c	2003-07-31 16:13:19.000000000 +0530
@@ -59,20 +59,18 @@ static DEFINE_PER_CPU(struct tasklet_str
  * call_rcu - Queue an RCU update request.
  * @head: structure to be used for queueing the RCU updates.
  * @func: actual update function to be invoked after the grace period
- * @arg: argument to be passed to the update function
  *
  * The update function will be invoked as soon as all CPUs have performed 
  * a context switch or been seen in the idle loop or in a user process. 
  * The read-side of critical section that use call_rcu() for updation must 
  * be protected by rcu_read_lock()/rcu_read_unlock().
  */
-void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
+void call_rcu(struct rcu_head *head, void (*func)(struct rcu_head *rcu))
 {
 	int cpu;
 	unsigned long flags;
 
 	head->func = func;
-	head->arg = arg;
 	head->next = NULL;
 	local_irq_save(flags);
 	cpu = smp_processor_id();
@@ -91,7 +89,7 @@ static void rcu_do_batch(struct rcu_head
 
 	while (list) {
 		next = list->next;
-		list->func(list->arg);
+		list->func(list);
 		list = next;
 	}
 }
@@ -239,11 +237,18 @@ void __init rcu_init(void)
 	register_cpu_notifier(&rcu_nb);
 }
 
+struct rcu_synchronize {
+	struct rcu_head head;
+	struct completion completion;
+};
 
 /* Because of FASTCALL declaration of complete, we use this wrapper */
-static void wakeme_after_rcu(void *completion)
+static void wakeme_after_rcu(struct rcu_head  *head)
 {
-	complete(completion);
+	struct rcu_synchronize *rcu;
+
+	rcu = container_of(head, struct rcu_synchronize, head);
+	complete(&rcu->completion);
 }
 
 /**
@@ -252,14 +257,14 @@ static void wakeme_after_rcu(void *compl
  */
 void synchronize_kernel(void)
 {
-	struct rcu_head rcu;
-	DECLARE_COMPLETION(completion);
+	struct rcu_synchronize rcu;
 
+	init_completion(&rcu.completion);
 	/* Will wake me after RCU finished */
-	call_rcu(&rcu, wakeme_after_rcu, &completion);
+	call_rcu(&rcu.head, wakeme_after_rcu);
 
 	/* Wait for it */
-	wait_for_completion(&completion);
+	wait_for_completion(&rcu.completion);
 }
 
 
diff -puN fs/dcache.c~rcu-no-arg fs/dcache.c
--- linux-2.6.0-test2-rcu/fs/dcache.c~rcu-no-arg	2003-07-31 16:13:19.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/fs/dcache.c	2003-07-31 16:13:19.000000000 +0530
@@ -58,9 +58,9 @@ struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
-static void d_callback(void *arg)
+static void d_callback(struct rcu_head *head)
 {
-	struct dentry * dentry = (struct dentry *)arg;
+	struct dentry * dentry = container_of(head, struct dentry, d_rcu);
 
 	if (dname_external(dentry)) {
 		kfree(dentry->d_qstr);
@@ -76,7 +76,7 @@ static void d_free(struct dentry *dentry
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
- 	call_rcu(&dentry->d_rcu, d_callback, dentry);
+ 	call_rcu(&dentry->d_rcu, d_callback);
 }
 
 /*
diff -puN ipc/util.c~rcu-no-arg ipc/util.c
--- linux-2.6.0-test2-rcu/ipc/util.c~rcu-no-arg	2003-07-31 16:13:19.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/ipc/util.c	2003-07-31 16:13:19.000000000 +0530
@@ -332,25 +332,40 @@ void* ipc_rcu_alloc(int size)
  * Since RCU callback function is called in bh,
  * we need to defer the vfree to schedule_work
  */
-static void ipc_schedule_free(void* arg)
+static void ipc_schedule_free(struct rcu_head *head)
 {
-	struct ipc_rcu_vmalloc *free = arg;
+	struct ipc_rcu_vmalloc *free = 
+		container_of(head, struct ipc_rcu_vmalloc, rcu);
 
 	INIT_WORK(&free->work, vfree, free);
 	schedule_work(&free->work);
 }
 
+/**
+ *	ipc_immediate_free	- free ipc + rcu space
+ *
+ *	Free from the RCU callback context
+ * 
+ */
+static void ipc_immediate_free(struct rcu_head *head)
+{
+	struct ipc_rcu_kmalloc *free = 
+		container_of(head, struct ipc_rcu_kmalloc, rcu);
+	kfree(free);
+}
+
+
+
 void ipc_rcu_free(void* ptr, int size)
 {
 	if (rcu_use_vmalloc(size)) {
 		struct ipc_rcu_vmalloc *free;
 		free = ptr - sizeof(*free);
-		call_rcu(&free->rcu, ipc_schedule_free, free);
+		call_rcu(&free->rcu, ipc_schedule_free);
 	} else {
 		struct ipc_rcu_kmalloc *free;
 		free = ptr - sizeof(*free);
-		/* kfree takes a "const void *" so gcc warns.  So we cast. */
-		call_rcu(&free->rcu, (void (*)(void *))kfree, free);
+		call_rcu(&free->rcu, ipc_immediate_free);
 	}
 
 }
diff -puN net/bridge/br_if.c~rcu-no-arg net/bridge/br_if.c
--- linux-2.6.0-test2-rcu/net/bridge/br_if.c~rcu-no-arg	2003-07-31 16:13:19.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/net/bridge/br_if.c	2003-07-31 16:16:33.000000000 +0530
@@ -38,9 +38,10 @@ static int br_initial_port_cost(struct n
 	return 100;
 }
 
-static void destroy_nbp(void *arg)
+static void destroy_nbp(struct rcu_head *head)
 {
-	struct net_bridge_port *p = arg;
+	struct net_bridge_port *p = 
+			container_of(head, struct net_bridge_port, rcu);
 
 	p->dev->br_port = NULL;
 
@@ -69,7 +70,7 @@ static void del_nbp(struct net_bridge_po
 	del_timer(&p->forward_delay_timer);
 	del_timer(&p->hold_timer);
 	
-	call_rcu(&p->rcu, destroy_nbp, p);
+	call_rcu(&p->rcu, destroy_nbp);
 }
 
 static void del_br(struct net_bridge *br)
diff -puN net/decnet/dn_route.c~rcu-no-arg net/decnet/dn_route.c
--- linux-2.6.0-test2-rcu/net/decnet/dn_route.c~rcu-no-arg	2003-07-31 16:13:19.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/net/decnet/dn_route.c	2003-07-31 16:13:19.000000000 +0530
@@ -145,14 +145,14 @@ static __inline__ unsigned dn_hash(unsig
 
 static inline void dnrt_free(struct dn_route *rt)
 {
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static inline void dnrt_drop(struct dn_route *rt)
 {
 	if (rt)
 		dst_release(&rt->u.dst);
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static void dn_dst_check_expire(unsigned long dummy)
diff -puN include/net/dst.h~rcu-no-arg include/net/dst.h
--- linux-2.6.0-test2-rcu/include/net/dst.h~rcu-no-arg	2003-07-31 16:13:19.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/include/net/dst.h	2003-07-31 16:13:19.000000000 +0530
@@ -182,6 +182,12 @@ static inline void dst_free(struct dst_e
 	__dst_free(dst);
 }
 
+static inline void dst_rcu_free(struct rcu_head *head)
+{
+	struct dst_entry *dst = container_of(head, struct dst_entry, rcu_head);
+	dst_free(dst);
+}
+
 static inline void dst_confirm(struct dst_entry *dst)
 {
 	if (dst)
diff -puN net/ipv4/route.c~rcu-no-arg net/ipv4/route.c
--- linux-2.6.0-test2-rcu/net/ipv4/route.c~rcu-no-arg	2003-07-31 16:13:19.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/net/ipv4/route.c	2003-07-31 16:13:19.000000000 +0530
@@ -411,13 +411,13 @@ void __init rt_cache_proc_exit(void)
   
 static __inline__ void rt_free(struct rtable *rt)
 {
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static __inline__ void rt_drop(struct rtable *rt)
 {
 	ip_rt_put(rt);
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 
 static __inline__ int rt_fast_clean(struct rtable *rth)

_
