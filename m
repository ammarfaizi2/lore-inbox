Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUFPFwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUFPFwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 01:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266178AbUFPFvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 01:51:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51379 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266176AbUFPFuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 01:50:46 -0400
Date: Wed, 16 Jun 2004 11:17:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce rcu_head size [1/2]
Message-ID: <20040616054713.GB3658@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040616054604.GA3658@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616054604.GA3658@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


singly-linked-rcu.patch

This reduces the RCU head size by using a singly linked to maintain
them. The ordering of the callbacks is still maintained as before
by using a tail pointer for the next list.

Signed-Off-By : Dipankar Sarma <dipankar@in.ibm.com>



 include/linux/rcupdate.h |   21 ++++++++++-----------
 kernel/rcupdate.c        |   40 ++++++++++++++++++++--------------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff -puN include/linux/rcupdate.h~singly-linked-rcu include/linux/rcupdate.h
--- linux-2.6.6-rcu/include/linux/rcupdate.h~singly-linked-rcu	2004-06-12 00:16:30.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/include/linux/rcupdate.h	2004-06-12 00:16:30.000000000 +0530
@@ -36,7 +36,6 @@
 #ifdef __KERNEL__
 
 #include <linux/cache.h>
-#include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
@@ -44,21 +43,20 @@
 
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
-		{ .list = LIST_HEAD_INIT(head.list), .func = NULL, .arg = NULL }
+#define RCU_HEAD_INIT(head) { .next = NULL, .func = NULL, .arg = NULL }
 #define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
 #define INIT_RCU_HEAD(ptr) do { \
-       INIT_LIST_HEAD(&(ptr)->list); (ptr)->func = NULL; (ptr)->arg = NULL; \
+       (ptr)->next = NULL; (ptr)->func = NULL; (ptr)->arg = NULL; \
 } while (0)
 
 
@@ -94,8 +92,9 @@ struct rcu_data {
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
@@ -106,15 +105,15 @@ extern struct rcu_ctrlblk rcu_ctrlblk;
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
+#define RCU_nxttail(cpu) 	(per_cpu(rcu_data, (cpu)).nxttail)
 
 #define RCU_QSCTR_INVALID	0
 
 static inline int rcu_pending(int cpu) 
 {
-	if ((!list_empty(&RCU_curlist(cpu)) &&
+	if ((RCU_curlist(cpu) &&
 	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
-	    (list_empty(&RCU_curlist(cpu)) &&
-			 !list_empty(&RCU_nxtlist(cpu))) ||
+	    (!RCU_curlist(cpu) && RCU_nxtlist(cpu)) ||
 	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
 		return 1;
 	else
diff -puN kernel/rcupdate.c~singly-linked-rcu kernel/rcupdate.c
--- linux-2.6.6-rcu/kernel/rcupdate.c~singly-linked-rcu	2004-06-12 00:16:30.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/kernel/rcupdate.c	2004-06-12 00:16:30.000000000 +0530
@@ -73,9 +73,11 @@ void fastcall call_rcu(struct rcu_head *
 
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
 
@@ -83,16 +85,14 @@ void fastcall call_rcu(struct rcu_head *
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
 
@@ -219,18 +219,19 @@ unlock:
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
@@ -244,8 +245,8 @@ static void rcu_process_callbacks(unsign
 		local_irq_enable();
 	}
 	rcu_check_quiescent_state();
-	if (!list_empty(&list))
-		rcu_do_batch(&list);
+	if (rcu_list)
+		rcu_do_batch(rcu_list);
 }
 
 void rcu_check_callbacks(int cpu, int user)
@@ -261,8 +262,7 @@ static void __devinit rcu_online_cpu(int
 {
 	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
 	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
-	INIT_LIST_HEAD(&RCU_nxtlist(cpu));
-	INIT_LIST_HEAD(&RCU_curlist(cpu));
+	RCU_nxttail(cpu) = &RCU_nxtlist(cpu);
 }
 
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 

_
