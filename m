Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUFTGQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUFTGQs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 02:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUFTGQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 02:16:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:43470 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264519AbUFTGQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 02:16:18 -0400
Date: Sun, 20 Jun 2004 11:42:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce rcu_head size [2/2]
Message-ID: <20040620061224.GA14123@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040616054604.GA3658@in.ibm.com> <20040616054713.GB3658@in.ibm.com> <20040616054746.GC3658@in.ibm.com> <20040619120414.57d985f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619120414.57d985f1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 12:04:14PM -0700, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> >  This patch changes the call_rcu() API and avoids passing an
> >  argument to the callback function as suggested by Rusty. 
> 
> This breaks the bridge driver:
> 
> 
> static void destroy_nbp(struct rcu_head *head)
> 
> int br_add_if(struct net_bridge *br, struct net_device *dev)
> {
> 	struct net_bridge_port *p;
> 
> 	...
> 		destroy_nbp(p);

Crap. New patch that compiles fine.


This patch changes the call_rcu() API and avoids passing an
argument to the callback function as suggested by Rusty. 
Instead, it is assumed that the user has embedded the rcu head 
into a structure that is useful in the callback and the rcu_head pointer 
is passed to the callback. The callback can use container_of() to get the
pointer to its structure and work with it. Together with
the rcu-singly-link patch, it reduces the rcu_head size
by 50%. Considering that we use these in things like
struct dentry and struct dst_entry, this is good savings
in space.

An example :

struct my_struct {
	struct rcu_head rcu;
	int x;
	int y;
};

void my_rcu_callback(struct rcu_head *head)
{
	struct my_struct *p = container_of(head, struct my_struct, rcu);
	free(p);
}

void my_delete(struct my_struct *p)
{
	...
	call_rcu(&p->rcu, my_rcu_callback);
	...
}

Signed-Off-By: Dipankar Sarma <dipankar@in.ibm.com>


 arch/ppc64/mm/tlb.c      |    7 ++++---
 fs/dcache.c              |    6 +++---
 include/linux/rcupdate.h |   10 ++++------
 include/net/dst.h        |    6 ++++++
 ipc/util.c               |   25 ++++++++++++++++++++-----
 kernel/auditsc.c         |    7 ++++---
 kernel/rcupdate.c        |   25 +++++++++++++++----------
 net/bridge/br_if.c       |   13 +++++++++----
 net/decnet/dn_route.c    |    4 ++--
 net/ipv4/route.c         |    4 ++--
 security/selinux/netif.c |    6 +++---
 11 files changed, 72 insertions(+), 41 deletions(-)

diff -puN fs/dcache.c~rcu-no-arg fs/dcache.c
--- linux-2.6.6-rcu/fs/dcache.c~rcu-no-arg	2004-06-12 00:17:28.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/fs/dcache.c	2004-06-12 00:17:28.000000000 +0530
@@ -61,9 +61,9 @@ struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
-static void d_callback(void *arg)
+static void d_callback(struct rcu_head *head)
 {
-	struct dentry * dentry = (struct dentry *)arg;
+	struct dentry * dentry = container_of(head, struct dentry, d_rcu);
 
 	if (dname_external(dentry)) {
 		kfree(dentry->d_qstr);
@@ -79,7 +79,7 @@ static void d_free(struct dentry *dentry
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
- 	call_rcu(&dentry->d_rcu, d_callback, dentry);
+ 	call_rcu(&dentry->d_rcu, d_callback);
 }
 
 /*
diff -puN include/linux/rcupdate.h~rcu-no-arg include/linux/rcupdate.h
--- linux-2.6.6-rcu/include/linux/rcupdate.h~rcu-no-arg	2004-06-12 00:17:28.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/include/linux/rcupdate.h	2004-06-12 00:17:28.000000000 +0530
@@ -45,18 +45,16 @@
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
 
 
@@ -128,7 +126,7 @@ extern void rcu_check_callbacks(int cpu,
 
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
-                          void (*func)(void *arg), void *arg));
+				void (*func)(struct rcu_head *head)));
 extern void synchronize_kernel(void);
 
 #endif /* __KERNEL__ */
diff -puN include/net/dst.h~rcu-no-arg include/net/dst.h
--- linux-2.6.6-rcu/include/net/dst.h~rcu-no-arg	2004-06-12 00:17:28.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/include/net/dst.h	2004-06-12 00:17:29.000000000 +0530
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
diff -puN ipc/util.c~rcu-no-arg ipc/util.c
--- linux-2.6.6-rcu/ipc/util.c~rcu-no-arg	2004-06-12 00:17:28.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/ipc/util.c	2004-06-12 00:17:28.000000000 +0530
@@ -331,25 +331,40 @@ void* ipc_rcu_alloc(int size)
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
diff -puN kernel/rcupdate.c~rcu-no-arg kernel/rcupdate.c
--- linux-2.6.6-rcu/kernel/rcupdate.c~rcu-no-arg	2004-06-12 00:17:28.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/kernel/rcupdate.c	2004-06-12 00:20:36.000000000 +0530
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
-void fastcall call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
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
@@ -302,11 +300,18 @@ void __init rcu_init(void)
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
@@ -315,14 +320,14 @@ static void wakeme_after_rcu(void *compl
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
 
 
diff -puN net/bridge/br_if.c~rcu-no-arg net/bridge/br_if.c
--- linux-2.6.6-rcu/net/bridge/br_if.c~rcu-no-arg	2004-06-12 00:17:28.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/net/bridge/br_if.c	2004-06-20 11:35:12.000000000 +0530
@@ -75,10 +75,8 @@ static int br_initial_port_cost(struct n
 	return 100;	/* assume old 10Mbps */
 }
 
-static void destroy_nbp(void *arg)
+static void destroy_nbp(struct net_bridge_port *p)
 {
-	struct net_bridge_port *p = arg;
-
 	p->dev->br_port = NULL;
 
 	BUG_ON(timer_pending(&p->message_age_timer));
@@ -89,6 +87,13 @@ static void destroy_nbp(void *arg)
 	kfree(p);
 }
 
+static void destroy_nbp_rcu(struct rcu_head *head)
+{
+	struct net_bridge_port *p = 
+			container_of(head, struct net_bridge_port, rcu);
+	destroy_nbp(p);
+}
+
 /* called under bridge lock */
 static void del_nbp(struct net_bridge_port *p)
 {
@@ -106,7 +111,7 @@ static void del_nbp(struct net_bridge_po
 	del_timer(&p->forward_delay_timer);
 	del_timer(&p->hold_timer);
 	
-	call_rcu(&p->rcu, destroy_nbp, p);
+	call_rcu(&p->rcu, destroy_nbp_rcu);
 }
 
 static void del_br(struct net_bridge *br)
diff -puN net/decnet/dn_route.c~rcu-no-arg net/decnet/dn_route.c
--- linux-2.6.6-rcu/net/decnet/dn_route.c~rcu-no-arg	2004-06-12 00:17:28.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/net/decnet/dn_route.c	2004-06-12 00:17:29.000000000 +0530
@@ -146,14 +146,14 @@ static __inline__ unsigned dn_hash(unsig
 
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
diff -puN net/ipv4/route.c~rcu-no-arg net/ipv4/route.c
--- linux-2.6.6-rcu/net/ipv4/route.c~rcu-no-arg	2004-06-12 00:17:28.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/net/ipv4/route.c	2004-06-12 00:17:29.000000000 +0530
@@ -437,13 +437,13 @@ static struct file_operations rt_cpu_seq
   
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
diff -puN arch/ppc64/mm/tlb.c~rcu-no-arg arch/ppc64/mm/tlb.c
--- linux-2.6.6-rcu/arch/ppc64/mm/tlb.c~rcu-no-arg	2004-06-12 00:23:38.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/arch/ppc64/mm/tlb.c	2004-06-12 00:32:37.000000000 +0530
@@ -127,9 +127,10 @@ void pte_free_now(struct page *ptepage)
 	pte_free(ptepage);
 }
 
-static void pte_free_rcu_callback(void *arg)
+static void pte_free_rcu_callback(struct rcu_head *head)
 {
-	struct pte_freelist_batch *batch = arg;
+	struct pte_freelist_batch *batch = 
+		container_of(head, struct pte_freelist_batch, rcu);
 	unsigned int i;
 
 	for (i = 0; i < batch->index; i++)
@@ -140,7 +141,7 @@ static void pte_free_rcu_callback(void *
 void pte_free_submit(struct pte_freelist_batch *batch)
 {
 	INIT_RCU_HEAD(&batch->rcu);
-	call_rcu(&batch->rcu, pte_free_rcu_callback, batch);
+	call_rcu(&batch->rcu, pte_free_rcu_callback);
 }
 
 void pte_free_finish(void)
diff -puN kernel/auditsc.c~rcu-no-arg kernel/auditsc.c
--- linux-2.6.6-rcu/kernel/auditsc.c~rcu-no-arg	2004-06-12 00:35:09.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/kernel/auditsc.c	2004-06-12 00:40:37.000000000 +0530
@@ -177,9 +177,10 @@ static inline int audit_add_rule(struct 
 	return 0;
 }
 
-static void audit_free_rule(void *arg)
+static void audit_free_rule(struct rcu_head *head)
 {
-	kfree(arg);
+	struct audit_entry *e = container_of(head, struct audit_entry, rcu);
+	kfree(e);
 }
 
 /* Note that audit_add_rule and audit_del_rule are called via
@@ -195,7 +196,7 @@ static inline int audit_del_rule(struct 
 	list_for_each_entry(e, list, list) {
 		if (!audit_compare_rule(rule, &e->rule)) {
 			list_del_rcu(&e->list);
-			call_rcu(&e->rcu, audit_free_rule, e);
+			call_rcu(&e->rcu, audit_free_rule);
 			return 0;
 		}
 	}
diff -puN security/selinux/netif.c~rcu-no-arg security/selinux/netif.c
--- linux-2.6.6-rcu/security/selinux/netif.c~rcu-no-arg	2004-06-12 00:38:57.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/security/selinux/netif.c	2004-06-12 00:40:28.000000000 +0530
@@ -134,9 +134,9 @@ out:
 	return netif;
 }
 
-static void sel_netif_free(void *p)
+static void sel_netif_free(struct rcu_head *p)
 {
-	struct sel_netif *netif = p;
+	struct sel_netif *netif = container_of(p, struct sel_netif, rcu_head);
 	
 	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
 	kfree(netif);
@@ -151,7 +151,7 @@ static void sel_netif_destroy(struct sel
 	sel_netif_total--;
 	spin_unlock_bh(&sel_netif_lock);
 
-	call_rcu(&netif->rcu_head, sel_netif_free, netif);
+	call_rcu(&netif->rcu_head, sel_netif_free);
 }
 
 void sel_netif_put(struct sel_netif *netif)

_
