Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274857AbTGaSz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 14:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274859AbTGaSz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 14:55:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:36002 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S274857AbTGaSzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 14:55:14 -0400
Date: Fri, 1 Aug 2003 00:28:06 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-ID: <20030731185806.GC1990@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have merged Rusty's original patch for reducing the size of
rcu_heads by splitting the two main changes into two patches.
This first patch just changes the rcu_heads to use a singly linked
list for internal per-CPU lists. I also added the tail pointer
so that the rcu_heads can be queued in the same order (and
hence invoked) as it was done earlier. That way we are not
messing with callback semantics at all.

Thanks
Dipankar




This reduces the RCU head size by using a singly linked to maintain
them. The ordering of the callbacks is still maintained as before
by using a tail pointer for the next list. Rusty wrote the originial
patch which I merged and changed to make it use a tail pointer so
that ordering of callbacks is not changed.


 include/linux/rcupdate.h |   21 ++++++++++-----------
 kernel/rcupdate.c        |   40 ++++++++++++++++++++--------------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-singly-link include/linux/rcupdate.h
--- linux-2.6.0-test2-rcu/include/linux/rcupdate.h~rcu-singly-link	2003-07-31 16:12:45.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/include/linux/rcupdate.h	2003-07-31 16:12:45.000000000 +0530
@@ -36,28 +36,26 @@
 #ifdef __KERNEL__
 
 #include <linux/cache.h>
-#include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
- * @list: list_head to queue the update requests
+ * @next: next update requests in a list
  * @func: actual update function to call after the grace period.
  * @arg: argument to be passed to the actual update function.
  */
 struct rcu_head {
-	struct list_head list;
+	struct rcu_head *next;
 	void (*func)(void *obj);
 	void *arg;
 };
 
-#define RCU_HEAD_INIT(head) \
-		{ list: LIST_HEAD_INIT(head.list), func: NULL, arg: NULL }
+#define RCU_HEAD_INIT(head) { .next = NULL, .func = NULL, .arg = NULL }
 #define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
 #define INIT_RCU_HEAD(ptr) do { \
-       INIT_LIST_HEAD(&(ptr)->list); (ptr)->func = NULL; (ptr)->arg = NULL; \
+       (ptr)->next = NULL; (ptr)->func = NULL; (ptr)->arg = NULL; \
 } while (0)
 
 
@@ -93,8 +91,9 @@ struct rcu_data {
         long            last_qsctr;	 /* value of qsctr at beginning */
                                          /* of rcu grace period */
         long  	       	batch;           /* Batch # for current RCU batch */
-        struct list_head  nxtlist;
-        struct list_head  curlist;
+        struct rcu_head *nxtlist;
+	struct rcu_head **nxttail;
+        struct rcu_head *curlist;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -104,16 +103,16 @@ extern struct rcu_ctrlblk rcu_ctrlblk;
 #define RCU_last_qsctr(cpu) 	(per_cpu(rcu_data, (cpu)).last_qsctr)
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
+#define RCU_nxttail(cpu) 	(per_cpu(rcu_data, (cpu)).nxttail)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
 
 #define RCU_QSCTR_INVALID	0
 
 static inline int rcu_pending(int cpu) 
 {
-	if ((!list_empty(&RCU_curlist(cpu)) &&
+	if ((RCU_curlist(cpu) &&
 	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
-	    (list_empty(&RCU_curlist(cpu)) &&
-			 !list_empty(&RCU_nxtlist(cpu))) ||
+	    (!RCU_curlist(cpu) && RCU_nxtlist(cpu)) ||
 	    test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask))
 		return 1;
 	else
diff -puN kernel/rcupdate.c~rcu-singly-link kernel/rcupdate.c
--- linux-2.6.0-test2-rcu/kernel/rcupdate.c~rcu-singly-link	2003-07-31 16:12:45.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/kernel/rcupdate.c	2003-07-31 16:12:45.000000000 +0530
@@ -73,9 +73,11 @@ void call_rcu(struct rcu_head *head, voi
 
 	head->func = func;
 	head->arg = arg;
+	head->next = NULL;
 	local_irq_save(flags);
 	cpu = smp_processor_id();
-	list_add_tail(&head->list, &RCU_nxtlist(cpu));
+	*RCU_nxttail(cpu) = head;
+	RCU_nxttail(cpu) = &head->next;
 	local_irq_restore(flags);
 }
 
@@ -83,16 +85,14 @@ void call_rcu(struct rcu_head *head, voi
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
  */
-static void rcu_do_batch(struct list_head *list)
+static void rcu_do_batch(struct rcu_head *list)
 {
-	struct list_head *entry;
-	struct rcu_head *head;
+	struct rcu_head *next;
 
-	while (!list_empty(list)) {
-		entry = list->next;
-		list_del(entry);
-		head = list_entry(entry, struct rcu_head, list);
-		head->func(head->arg);
+	while (list) {
+		next = list->next;
+		list->func(list->arg);
+		list = next;
 	}
 }
 
@@ -160,18 +160,19 @@ out_unlock:
 static void rcu_process_callbacks(unsigned long unused)
 {
 	int cpu = smp_processor_id();
-	LIST_HEAD(list);
+	struct rcu_head *rcu_list = NULL;
 
-	if (!list_empty(&RCU_curlist(cpu)) &&
+	if (RCU_curlist(cpu) &&
 	    rcu_batch_after(rcu_ctrlblk.curbatch, RCU_batch(cpu))) {
-		list_splice(&RCU_curlist(cpu), &list);
-		INIT_LIST_HEAD(&RCU_curlist(cpu));
+		rcu_list = RCU_curlist(cpu);
+		RCU_curlist(cpu) = NULL;
 	}
 
 	local_irq_disable();
-	if (!list_empty(&RCU_nxtlist(cpu)) && list_empty(&RCU_curlist(cpu))) {
-		list_splice(&RCU_nxtlist(cpu), &RCU_curlist(cpu));
-		INIT_LIST_HEAD(&RCU_nxtlist(cpu));
+	if (RCU_nxtlist(cpu) && !RCU_curlist(cpu)) {
+		RCU_curlist(cpu) = RCU_nxtlist(cpu);
+		RCU_nxtlist(cpu) = NULL;
+		RCU_nxttail(cpu) = &RCU_nxtlist(cpu);
 		local_irq_enable();
 
 		/*
@@ -185,8 +186,8 @@ static void rcu_process_callbacks(unsign
 		local_irq_enable();
 	}
 	rcu_check_quiescent_state();
-	if (!list_empty(&list))
-		rcu_do_batch(&list);
+	if (rcu_list)
+		rcu_do_batch(rcu_list);
 }
 
 void rcu_check_callbacks(int cpu, int user)
@@ -202,8 +203,7 @@ static void __devinit rcu_online_cpu(int
 {
 	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
 	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
-	INIT_LIST_HEAD(&RCU_nxtlist(cpu));
-	INIT_LIST_HEAD(&RCU_curlist(cpu));
+	RCU_nxttail(cpu) = &RCU_nxtlist(cpu);
 }
 
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 

_
