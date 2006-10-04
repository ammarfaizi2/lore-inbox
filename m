Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161547AbWJDQaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161547AbWJDQaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWJDQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:30:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:8658 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161547AbWJDQaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:30:52 -0400
Message-Id: <20061004161457.884476000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:12 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 02/14] spufs: scheduler support for NUMA.
Content-Disposition: inline; filename=spufs-sched-numa-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Nutter <mnutter@us.ibm.com>

This patch adds NUMA support to the the spufs scheduler.

The new arch/powerpc/platforms/cell/spufs/sched.c is greatly
simplified, in an attempt to reduce complexity while adding
support for NUMA scheduler domains.  SPUs are allocated starting 
from the calling thread's node, moving to others as supported by 
current->cpus_allowed.  Preemption is gone as it was buggy, but 
should be re-enabled in another patch when stable.

The new arch/powerpc/platforms/cell/spu_base.c maintains idle 
lists on a per-node basis, and allows caller to specify which
node(s) an SPU should be allocated from, while passing -1 tells
spu_alloc() that any node is allowed.

Since the patch removes the currently implemented preemptive
scheduling, it is technically a regression, but practically
all users have since migrated to this version, as it is
part of the IBM SDK and the yellowdog distribution, so there
is not much point holding it back while the new preemptive
scheduling patch gets delayed further.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -317,7 +317,7 @@ static void spu_free_irqs(struct spu *sp
 		free_irq(spu->irqs[2], spu);
 }
 
-static LIST_HEAD(spu_list);
+static struct list_head spu_list[MAX_NUMNODES];
 static DEFINE_MUTEX(spu_mutex);
 
 static void spu_init_channels(struct spu *spu)
@@ -354,32 +354,42 @@ static void spu_init_channels(struct spu
 	}
 }
 
-struct spu *spu_alloc(void)
+struct spu *spu_alloc_node(int node)
 {
-	struct spu *spu;
+	struct spu *spu = NULL;
 
 	mutex_lock(&spu_mutex);
-	if (!list_empty(&spu_list)) {
-		spu = list_entry(spu_list.next, struct spu, list);
+	if (!list_empty(&spu_list[node])) {
+		spu = list_entry(spu_list[node].next, struct spu, list);
 		list_del_init(&spu->list);
-		pr_debug("Got SPU %x %d\n", spu->isrc, spu->number);
-	} else {
-		pr_debug("No SPU left\n");
-		spu = NULL;
+		pr_debug("Got SPU %x %d %d\n",
+			 spu->isrc, spu->number, spu->node);
+		spu_init_channels(spu);
 	}
 	mutex_unlock(&spu_mutex);
 
-	if (spu)
-		spu_init_channels(spu);
+	return spu;
+}
+EXPORT_SYMBOL_GPL(spu_alloc_node);
+
+struct spu *spu_alloc(void)
+{
+	struct spu *spu = NULL;
+	int node;
+
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		spu = spu_alloc_node(node);
+		if (spu)
+			break;
+	}
 
 	return spu;
 }
-EXPORT_SYMBOL_GPL(spu_alloc);
 
 void spu_free(struct spu *spu)
 {
 	mutex_lock(&spu_mutex);
-	list_add_tail(&spu->list, &spu_list);
+	list_add_tail(&spu->list, &spu_list[spu->node]);
 	mutex_unlock(&spu_mutex);
 }
 EXPORT_SYMBOL_GPL(spu_free);
@@ -712,7 +722,7 @@ static int __init create_spu(struct devi
 	if (ret)
 		goto out_free_irqs;
 
-	list_add(&spu->list, &spu_list);
+	list_add(&spu->list, &spu_list[spu->node]);
 	mutex_unlock(&spu_mutex);
 
 	pr_debug(KERN_DEBUG "Using SPE %s %02x %p %p %p %p %d\n",
@@ -745,9 +755,13 @@ static void destroy_spu(struct spu *spu)
 static void cleanup_spu_base(void)
 {
 	struct spu *spu, *tmp;
+	int node;
+
 	mutex_lock(&spu_mutex);
-	list_for_each_entry_safe(spu, tmp, &spu_list, list)
-		destroy_spu(spu);
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		list_for_each_entry_safe(spu, tmp, &spu_list[node], list)
+			destroy_spu(spu);
+	}
 	mutex_unlock(&spu_mutex);
 	sysdev_class_unregister(&spu_sysdev_class);
 }
@@ -756,13 +770,16 @@ module_exit(cleanup_spu_base);
 static int __init init_spu_base(void)
 {
 	struct device_node *node;
-	int ret;
+	int i, ret;
 
 	/* create sysdev class for spus */
 	ret = sysdev_class_register(&spu_sysdev_class);
 	if (ret)
 		return ret;
 
+	for (i = 0; i < MAX_NUMNODES; i++)
+		INIT_LIST_HEAD(&spu_list[i]);
+
 	ret = -ENODEV;
 	for (node = of_find_node_by_type(NULL, "spe");
 			node; node = of_find_node_by_type(node, "spe")) {
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/sched.c
@@ -3,11 +3,7 @@
  * Copyright (C) IBM 2005
  * Author: Mark Nutter <mnutter@us.ibm.com>
  *
- * SPU scheduler, based on Linux thread priority.  For now use
- * a simple "cooperative" yield model with no preemption.  SPU
- * scheduling will eventually be preemptive: When a thread with
- * a higher static priority gets ready to run, then an active SPU
- * context will be preempted and returned to the waitq.
+ * 2006-03-31	NUMA domains added.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -37,6 +33,8 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
+#include <linux/numa.h>
+#include <linux/mutex.h>
 
 #include <asm/io.h>
 #include <asm/mmu_context.h>
@@ -49,125 +47,38 @@
 
 #define SPU_BITMAP_SIZE (((MAX_PRIO+BITS_PER_LONG)/BITS_PER_LONG)+1)
 struct spu_prio_array {
-	atomic_t nr_blocked;
 	unsigned long bitmap[SPU_BITMAP_SIZE];
 	wait_queue_head_t waitq[MAX_PRIO];
+	struct list_head active_list[MAX_NUMNODES];
+	struct mutex active_mutex[MAX_NUMNODES];
 };
 
-/* spu_runqueue - This is the main runqueue data structure for SPUs. */
-struct spu_runqueue {
-	struct semaphore sem;
-	unsigned long nr_active;
-	unsigned long nr_idle;
-	unsigned long nr_switches;
-	struct list_head active_list;
-	struct list_head idle_list;
-	struct spu_prio_array prio;
-};
-
-static struct spu_runqueue *spu_runqueues = NULL;
-
-static inline struct spu_runqueue *spu_rq(void)
-{
-	/* Future: make this a per-NODE array,
-	 * and use cpu_to_node(smp_processor_id())
-	 */
-	return spu_runqueues;
-}
-
-static inline struct spu *del_idle(struct spu_runqueue *rq)
-{
-	struct spu *spu;
-
-	BUG_ON(rq->nr_idle <= 0);
-	BUG_ON(list_empty(&rq->idle_list));
-	/* Future: Move SPU out of low-power SRI state. */
-	spu = list_entry(rq->idle_list.next, struct spu, sched_list);
-	list_del_init(&spu->sched_list);
-	rq->nr_idle--;
-	return spu;
-}
-
-static inline void del_active(struct spu_runqueue *rq, struct spu *spu)
-{
-	BUG_ON(rq->nr_active <= 0);
-	BUG_ON(list_empty(&rq->active_list));
-	list_del_init(&spu->sched_list);
-	rq->nr_active--;
-}
-
-static inline void add_idle(struct spu_runqueue *rq, struct spu *spu)
-{
-	/* Future: Put SPU into low-power SRI state. */
-	list_add_tail(&spu->sched_list, &rq->idle_list);
-	rq->nr_idle++;
-}
-
-static inline void add_active(struct spu_runqueue *rq, struct spu *spu)
-{
-	rq->nr_active++;
-	rq->nr_switches++;
-	list_add_tail(&spu->sched_list, &rq->active_list);
-}
-
-static void prio_wakeup(struct spu_runqueue *rq)
-{
-	if (atomic_read(&rq->prio.nr_blocked) && rq->nr_idle) {
-		int best = sched_find_first_bit(rq->prio.bitmap);
-		if (best < MAX_PRIO) {
-			wait_queue_head_t *wq = &rq->prio.waitq[best];
-			wake_up_interruptible_nr(wq, 1);
-		}
-	}
-}
-
-static void prio_wait(struct spu_runqueue *rq, struct spu_context *ctx,
-		      u64 flags)
-{
-	int prio = current->prio;
-	wait_queue_head_t *wq = &rq->prio.waitq[prio];
-	DEFINE_WAIT(wait);
-
-	__set_bit(prio, rq->prio.bitmap);
-	atomic_inc(&rq->prio.nr_blocked);
-	prepare_to_wait_exclusive(wq, &wait, TASK_INTERRUPTIBLE);
-	if (!signal_pending(current)) {
-		up(&rq->sem);
-		up_write(&ctx->state_sema);
-		pr_debug("%s: pid=%d prio=%d\n", __FUNCTION__,
-			 current->pid, current->prio);
-		schedule();
-		down_write(&ctx->state_sema);
-		down(&rq->sem);
-	}
-	finish_wait(wq, &wait);
-	atomic_dec(&rq->prio.nr_blocked);
-	if (!waitqueue_active(wq))
-		__clear_bit(prio, rq->prio.bitmap);
-}
+static struct spu_prio_array *spu_prio;
 
-static inline int is_best_prio(struct spu_runqueue *rq)
+static inline int node_allowed(int node)
 {
-	int best_prio;
+	cpumask_t mask;
 
-	best_prio = sched_find_first_bit(rq->prio.bitmap);
-	return (current->prio < best_prio) ? 1 : 0;
+	if (!nr_cpus_node(node))
+		return 0;
+	mask = node_to_cpumask(node);
+	if (!cpus_intersects(mask, current->cpus_allowed))
+		return 0;
+	return 1;
 }
 
 static inline void mm_needs_global_tlbie(struct mm_struct *mm)
 {
+	int nr = (NR_CPUS > 1) ? NR_CPUS : NR_CPUS + 1;
+
 	/* Global TLBIE broadcast required with SPEs. */
-#if (NR_CPUS > 1)
-	__cpus_setall(&mm->cpu_vm_mask, NR_CPUS);
-#else
-	__cpus_setall(&mm->cpu_vm_mask, NR_CPUS+1); /* is this ok? */
-#endif
+	__cpus_setall(&mm->cpu_vm_mask, nr);
 }
 
 static inline void bind_context(struct spu *spu, struct spu_context *ctx)
 {
-	pr_debug("%s: pid=%d SPU=%d\n", __FUNCTION__, current->pid,
-		 spu->number);
+	pr_debug("%s: pid=%d SPU=%d NODE=%d\n", __FUNCTION__, current->pid,
+		 spu->number, spu->node);
 	spu->ctx = ctx;
 	spu->flags = 0;
 	ctx->flags = 0;
@@ -185,12 +96,13 @@ static inline void bind_context(struct s
 	spu_unmap_mappings(ctx);
 	spu_restore(&ctx->csa, spu);
 	spu->timestamp = jiffies;
+	spu_cpu_affinity_set(spu, raw_smp_processor_id());
 }
 
 static inline void unbind_context(struct spu *spu, struct spu_context *ctx)
 {
-	pr_debug("%s: unbind pid=%d SPU=%d\n", __FUNCTION__,
-		 spu->pid, spu->number);
+	pr_debug("%s: unbind pid=%d SPU=%d NODE=%d\n", __FUNCTION__,
+		 spu->pid, spu->number, spu->node);
 	spu_unmap_mappings(ctx);
 	spu_save(&ctx->csa, spu);
 	spu->timestamp = jiffies;
@@ -209,163 +121,148 @@ static inline void unbind_context(struct
 	spu->ctx = NULL;
 }
 
-static void spu_reaper(void *data)
+static inline void spu_add_wq(wait_queue_head_t * wq, wait_queue_t * wait,
+			      int prio)
 {
-	struct spu_context *ctx = data;
-	struct spu *spu;
-
-	down_write(&ctx->state_sema);
-	spu = ctx->spu;
-	if (spu && test_bit(SPU_CONTEXT_PREEMPT, &ctx->flags)) {
-		if (atomic_read(&spu->rq->prio.nr_blocked)) {
-			pr_debug("%s: spu=%d\n", __func__, spu->number);
-			ctx->ops->runcntl_stop(ctx);
-			spu_deactivate(ctx);
-			wake_up_all(&ctx->stop_wq);
-		} else {
-			clear_bit(SPU_CONTEXT_PREEMPT, &ctx->flags);
-		}
-	}
-	up_write(&ctx->state_sema);
-	put_spu_context(ctx);
+	prepare_to_wait_exclusive(wq, wait, TASK_INTERRUPTIBLE);
+	set_bit(prio, spu_prio->bitmap);
 }
 
-static void schedule_spu_reaper(struct spu_runqueue *rq, struct spu *spu)
+static inline void spu_del_wq(wait_queue_head_t * wq, wait_queue_t * wait,
+			      int prio)
 {
-	struct spu_context *ctx = get_spu_context(spu->ctx);
-	unsigned long now = jiffies;
-	unsigned long expire = spu->timestamp + SPU_MIN_TIMESLICE;
+	u64 flags;
 
-	set_bit(SPU_CONTEXT_PREEMPT, &ctx->flags);
-	INIT_WORK(&ctx->reap_work, spu_reaper, ctx);
-	if (time_after(now, expire))
-		schedule_work(&ctx->reap_work);
-	else
-		schedule_delayed_work(&ctx->reap_work, expire - now);
-}
+	__set_current_state(TASK_RUNNING);
 
-static void check_preempt_active(struct spu_runqueue *rq)
-{
-	struct list_head *p;
-	struct spu *worst = NULL;
+	spin_lock_irqsave(&wq->lock, flags);
 
-	list_for_each(p, &rq->active_list) {
-		struct spu *spu = list_entry(p, struct spu, sched_list);
-		struct spu_context *ctx = spu->ctx;
-		if (!test_bit(SPU_CONTEXT_PREEMPT, &ctx->flags)) {
-			if (!worst || (spu->prio > worst->prio)) {
-				worst = spu;
-			}
-		}
-	}
-	if (worst && (current->prio < worst->prio))
-		schedule_spu_reaper(rq, worst);
+	remove_wait_queue_locked(wq, wait);
+	if (list_empty(&wq->task_list))
+		clear_bit(prio, spu_prio->bitmap);
+
+	spin_unlock_irqrestore(&wq->lock, flags);
 }
 
-static struct spu *get_idle_spu(struct spu_context *ctx, u64 flags)
+static void spu_prio_wait(struct spu_context *ctx, u64 flags)
 {
-	struct spu_runqueue *rq;
-	struct spu *spu = NULL;
+	int prio = current->prio;
+	wait_queue_head_t *wq = &spu_prio->waitq[prio];
+	DEFINE_WAIT(wait);
 
-	rq = spu_rq();
-	down(&rq->sem);
-	for (;;) {
-		if (rq->nr_idle > 0) {
-			if (is_best_prio(rq)) {
-				/* Fall through. */
-				spu = del_idle(rq);
-				break;
-			} else {
-				prio_wakeup(rq);
-				up(&rq->sem);
-				yield();
-				if (signal_pending(current)) {
-					return NULL;
-				}
-				rq = spu_rq();
-				down(&rq->sem);
-				continue;
-			}
-		} else {
-			check_preempt_active(rq);
-			prio_wait(rq, ctx, flags);
-			if (signal_pending(current)) {
-				prio_wakeup(rq);
-				spu = NULL;
-				break;
-			}
-			continue;
-		}
+	if (ctx->spu)
+		return;
+
+	spu_add_wq(wq, &wait, prio);
+
+	if (!signal_pending(current)) {
+		up_write(&ctx->state_sema);
+		pr_debug("%s: pid=%d prio=%d\n", __FUNCTION__,
+			 current->pid, current->prio);
+		schedule();
+		down_write(&ctx->state_sema);
 	}
-	up(&rq->sem);
-	return spu;
+
+	spu_del_wq(wq, &wait, prio);
 }
 
-static void put_idle_spu(struct spu *spu)
+static void spu_prio_wakeup(void)
 {
-	struct spu_runqueue *rq = spu->rq;
-
-	down(&rq->sem);
-	add_idle(rq, spu);
-	prio_wakeup(rq);
-	up(&rq->sem);
+	int best = sched_find_first_bit(spu_prio->bitmap);
+	if (best < MAX_PRIO) {
+		wait_queue_head_t *wq = &spu_prio->waitq[best];
+		wake_up_interruptible_nr(wq, 1);
+	}
 }
 
 static int get_active_spu(struct spu *spu)
 {
-	struct spu_runqueue *rq = spu->rq;
-	struct list_head *p;
+	int node = spu->node;
 	struct spu *tmp;
 	int rc = 0;
 
-	down(&rq->sem);
-	list_for_each(p, &rq->active_list) {
-		tmp = list_entry(p, struct spu, sched_list);
+	mutex_lock(&spu_prio->active_mutex[node]);
+	list_for_each_entry(tmp, &spu_prio->active_list[node], list) {
 		if (tmp == spu) {
-			del_active(rq, spu);
+			list_del_init(&spu->list);
 			rc = 1;
 			break;
 		}
 	}
-	up(&rq->sem);
+	mutex_unlock(&spu_prio->active_mutex[node]);
 	return rc;
 }
 
 static void put_active_spu(struct spu *spu)
 {
-	struct spu_runqueue *rq = spu->rq;
+	int node = spu->node;
 
-	down(&rq->sem);
-	add_active(rq, spu);
-	up(&rq->sem);
+	mutex_lock(&spu_prio->active_mutex[node]);
+	list_add_tail(&spu->list, &spu_prio->active_list[node]);
+	mutex_unlock(&spu_prio->active_mutex[node]);
 }
 
-/* Lock order:
- *	spu_activate() & spu_deactivate() require the
- *	caller to have down_write(&ctx->state_sema).
+static struct spu *spu_get_idle(struct spu_context *ctx, u64 flags)
+{
+	struct spu *spu = NULL;
+	int node = cpu_to_node(raw_smp_processor_id());
+	int n;
+
+	for (n = 0; n < MAX_NUMNODES; n++, node++) {
+		node = (node < MAX_NUMNODES) ? node : 0;
+		if (!node_allowed(node))
+			continue;
+		spu = spu_alloc_node(node);
+		if (spu)
+			break;
+	}
+	return spu;
+}
+
+static inline struct spu *spu_get(struct spu_context *ctx, u64 flags)
+{
+	/* Future: spu_get_idle() if possible,
+	 * otherwise try to preempt an active
+	 * context.
+	 */
+	return spu_get_idle(ctx, flags);
+}
+
+/* The three externally callable interfaces
+ * for the scheduler begin here.
  *
- *	The rq->sem is breifly held (inside or outside a
- *	given ctx lock) for list management, but is never
- *	held during save/restore.
+ *	spu_activate	- bind a context to SPU, waiting as needed.
+ *	spu_deactivate	- unbind a context from its SPU.
+ *	spu_yield	- yield an SPU if others are waiting.
  */
 
 int spu_activate(struct spu_context *ctx, u64 flags)
 {
 	struct spu *spu;
+	int ret = 0;
 
-	if (ctx->spu)
-		return 0;
-	spu = get_idle_spu(ctx, flags);
-	if (!spu)
-		return (signal_pending(current)) ? -ERESTARTSYS : -EAGAIN;
-	bind_context(spu, ctx);
-	/*
-	 * We're likely to wait for interrupts on the same
-	 * CPU that we are now on, so send them here.
-	 */
-	spu_cpu_affinity_set(spu, raw_smp_processor_id());
-	put_active_spu(spu);
-	return 0;
+	for (;;) {
+		if (ctx->spu)
+			return 0;
+		spu = spu_get(ctx, flags);
+		if (spu != NULL) {
+			if (ctx->spu != NULL) {
+				spu_free(spu);
+				spu_prio_wakeup();
+				break;
+			}
+			bind_context(spu, ctx);
+			put_active_spu(spu);
+			break;
+		}
+		spu_prio_wait(ctx, flags);
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			spu_prio_wakeup();
+			break;
+		}
+	}
+	return ret;
 }
 
 void spu_deactivate(struct spu_context *ctx)
@@ -378,8 +275,10 @@ void spu_deactivate(struct spu_context *
 		return;
 	needs_idle = get_active_spu(spu);
 	unbind_context(spu, ctx);
-	if (needs_idle)
-		put_idle_spu(spu);
+	if (needs_idle) {
+		spu_free(spu);
+		spu_prio_wakeup();
+	}
 }
 
 void spu_yield(struct spu_context *ctx)
@@ -387,77 +286,60 @@ void spu_yield(struct spu_context *ctx)
 	struct spu *spu;
 	int need_yield = 0;
 
-	down_write(&ctx->state_sema);
-	spu = ctx->spu;
-	if (spu && (sched_find_first_bit(spu->rq->prio.bitmap) < MAX_PRIO)) {
-		pr_debug("%s: yielding SPU %d\n", __FUNCTION__, spu->number);
-		spu_deactivate(ctx);
-		ctx->state = SPU_STATE_SAVED;
-		need_yield = 1;
-	} else if (spu) {
-		spu->prio = MAX_PRIO;
+	if (down_write_trylock(&ctx->state_sema)) {
+		if ((spu = ctx->spu) != NULL) {
+			int best = sched_find_first_bit(spu_prio->bitmap);
+			if (best < MAX_PRIO) {
+				pr_debug("%s: yielding SPU %d NODE %d\n",
+					 __FUNCTION__, spu->number, spu->node);
+				spu_deactivate(ctx);
+				ctx->state = SPU_STATE_SAVED;
+				need_yield = 1;
+			} else {
+				spu->prio = MAX_PRIO;
+			}
+		}
+		up_write(&ctx->state_sema);
 	}
-	up_write(&ctx->state_sema);
 	if (unlikely(need_yield))
 		yield();
 }
 
 int __init spu_sched_init(void)
 {
-	struct spu_runqueue *rq;
-	struct spu *spu;
 	int i;
 
-	rq = spu_runqueues = kmalloc(sizeof(struct spu_runqueue), GFP_KERNEL);
-	if (!rq) {
-		printk(KERN_WARNING "%s: Unable to allocate runqueues.\n",
+	spu_prio = kzalloc(sizeof(struct spu_prio_array), GFP_KERNEL);
+	if (!spu_prio) {
+		printk(KERN_WARNING "%s: Unable to allocate priority queue.\n",
 		       __FUNCTION__);
 		return 1;
 	}
-	memset(rq, 0, sizeof(struct spu_runqueue));
-	init_MUTEX(&rq->sem);
-	INIT_LIST_HEAD(&rq->active_list);
-	INIT_LIST_HEAD(&rq->idle_list);
-	rq->nr_active = 0;
-	rq->nr_idle = 0;
-	rq->nr_switches = 0;
-	atomic_set(&rq->prio.nr_blocked, 0);
 	for (i = 0; i < MAX_PRIO; i++) {
-		init_waitqueue_head(&rq->prio.waitq[i]);
-		__clear_bit(i, rq->prio.bitmap);
+		init_waitqueue_head(&spu_prio->waitq[i]);
+		__clear_bit(i, spu_prio->bitmap);
 	}
-	__set_bit(MAX_PRIO, rq->prio.bitmap);
-	for (;;) {
-		spu = spu_alloc();
-		if (!spu)
-			break;
-		pr_debug("%s: adding SPU[%d]\n", __FUNCTION__, spu->number);
-		add_idle(rq, spu);
-		spu->rq = rq;
-		spu->timestamp = jiffies;
-	}
-	if (!rq->nr_idle) {
-		printk(KERN_WARNING "%s: No available SPUs.\n", __FUNCTION__);
-		kfree(rq);
-		return 1;
+	__set_bit(MAX_PRIO, spu_prio->bitmap);
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		mutex_init(&spu_prio->active_mutex[i]);
+		INIT_LIST_HEAD(&spu_prio->active_list[i]);
 	}
 	return 0;
 }
 
 void __exit spu_sched_exit(void)
 {
-	struct spu_runqueue *rq = spu_rq();
-	struct spu *spu;
+	struct spu *spu, *tmp;
+	int node;
 
-	if (!rq) {
-		printk(KERN_WARNING "%s: no runqueues!\n", __FUNCTION__);
-		return;
-	}
-	while (rq->nr_idle > 0) {
-		spu = del_idle(rq);
-		if (!spu)
-			break;
-		spu_free(spu);
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		mutex_lock(&spu_prio->active_mutex[node]);
+		list_for_each_entry_safe(spu, tmp, &spu_prio->active_list[node],
+					 list) {
+			list_del_init(&spu->list);
+			spu_free(spu);
+		}
+		mutex_unlock(&spu_prio->active_mutex[node]);
 	}
-	kfree(rq);
+	kfree(spu_prio);
 }
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -147,6 +147,7 @@ struct spu {
 };
 
 struct spu *spu_alloc(void);
+struct spu *spu_alloc_node(int node);
 void spu_free(struct spu *spu);
 int spu_irq_class_0_bottom(struct spu *spu);
 int spu_irq_class_1_bottom(struct spu *spu);

--

