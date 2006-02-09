Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422753AbWBIBVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWBIBVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 20:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWBIBVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 20:21:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1202 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422753AbWBIBVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 20:21:19 -0500
Date: Wed, 8 Feb 2006 20:20:58 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Eric Dumazet <dada1@cosmosbay.com>, Linus Torvalds <torvalds@osdl.org>,
       xen-devel@lists.xensource.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
In-Reply-To: <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
Message-ID: <Pine.LNX.4.63.0602082018490.31711@cuia.boston.redhat.com>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
 <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Rik van Riel wrote:

> On Sun, 5 Feb 2006, Linux Kernel Mailing List wrote:
> 
> > [PATCH] percpu data: only iterate over possible CPUs
> 
> The sched.c bit breaks Xen, and probably also other architectures
> that have CPU hotplug.  I suspect the reason is that during early 
> bootup only the boot CPU is online, so nothing initialises the
> runqueues for CPUs that are brought up afterwards.
> 
> I suspect we can get rid of this problem quite easily by moving
> runqueue initialisation to init_idle()...

Well, it works.  This (fairly trivial) patch makes hotplug cpu
work again, by ensuring that the runqueues of a newly brought
up CPU are initialized just before they are needed.

Without this patch the "spin_lock_irqsave(&rq->lock, flags);"
in init_idle() would oops if CONFIG_DEBUG_SPINLOCK was set.

With this patch, things just work.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.15.i686/kernel/sched.c.idle_init	2006-02-08 17:56:50.000000000 -0500
+++ linux-2.6.15.i686/kernel/sched.c	2006-02-08 17:58:57.000000000 -0500
@@ -4437,6 +4437,35 @@ void __devinit init_idle(task_t *idle, i
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long flags;
+	prio_array_t *array;
+	int j, k;
+
+	spin_lock_init(&rq->lock);
+	rq->nr_running = 0;
+	rq->active = rq->arrays;
+	rq->expired = rq->arrays + 1;
+	rq->best_expired_prio = MAX_PRIO;
+
+#ifdef CONFIG_SMP
+	rq->sd = NULL;
+	for (j = 1; j < 3; j++)
+		rq->cpu_load[j] = 0;
+	rq->active_balance = 0;
+	rq->push_cpu = 0;
+	rq->migration_thread = NULL;
+	INIT_LIST_HEAD(&rq->migration_queue);
+#endif
+	atomic_set(&rq->nr_iowait, 0);
+
+	for (j = 0; j < 2; j++) {
+		array = rq->arrays + j;
+		for (k = 0; k < MAX_PRIO; k++) {
+			INIT_LIST_HEAD(array->queue + k);
+			__clear_bit(k, array->bitmap);
+		}
+		// delimiter for bitsearch
+		__set_bit(MAX_PRIO, array->bitmap);
+	}
 
 	idle->sleep_avg = 0;
 	idle->array = NULL;
@@ -6110,41 +6139,6 @@ int in_sched_functions(unsigned long add
 
 void __init sched_init(void)
 {
-	runqueue_t *rq;
-	int i, j, k;
-
-	for_each_cpu(i) {
-		prio_array_t *array;
-
-		rq = cpu_rq(i);
-		spin_lock_init(&rq->lock);
-		rq->nr_running = 0;
-		rq->active = rq->arrays;
-		rq->expired = rq->arrays + 1;
-		rq->best_expired_prio = MAX_PRIO;
-
-#ifdef CONFIG_SMP
-		rq->sd = NULL;
-		for (j = 1; j < 3; j++)
-			rq->cpu_load[j] = 0;
-		rq->active_balance = 0;
-		rq->push_cpu = 0;
-		rq->migration_thread = NULL;
-		INIT_LIST_HEAD(&rq->migration_queue);
-#endif
-		atomic_set(&rq->nr_iowait, 0);
-
-		for (j = 0; j < 2; j++) {
-			array = rq->arrays + j;
-			for (k = 0; k < MAX_PRIO; k++) {
-				INIT_LIST_HEAD(array->queue + k);
-				__clear_bit(k, array->bitmap);
-			}
-			// delimiter for bitsearch
-			__set_bit(MAX_PRIO, array->bitmap);
-		}
-	}
-
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
