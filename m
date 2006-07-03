Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWGCPd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWGCPd5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 11:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWGCPd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 11:33:56 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:37060 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751199AbWGCPd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 11:33:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [patch] reduce IPI noise due to /dev/cdrom open/close
From: Jes Sorensen <jes@sgi.com>
Date: 03 Jul 2006 11:33:54 -0400
Message-ID: <yq0mzbqhfdp.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Certain applications cause a lot of IPI noise due to them constantly
doing open/close on /dev/cdrom. hald is a particularly annoying case
of this. However since every distribution insists on shipping it, it's
one of those that are hard to get rid of :(

Anyway, this patch reduces the IPI noise by keeping a cpumask of CPUs
which have items in the bh lru and only flushing on the relevant
CPUs. On systems with larger CPU counts it's quite normal that only a
few CPUs are actively doing block IO, so spewing IPIs everywhere to
flush this is unnecessary.

I also switched the code to use schedule_on_each_cpu() as suggested by
Andrew, and I made the API there more flexible by introducing
schedule_on_each_cpu_mask().

Cheers,
Jes

Introduce more flexible schedule_on_each_cpu_mask() API allowing one
to specify a CPU mask to schedule on and implement
schedule_on_each_cpu_mask() on top of it.

Use a cpumask to keep track of which CPUs have items in the per CPU
buffer_head lru. Let invalidate_bh_lrus() use the new cpumask API to
limit the number of cross-CPU calls when a block device is
open/closed.

This significantly reduces IPI noise on large CPU number systems which
are running hald.

Signed-off-by: Jes Sorensen <jes@sgi.com>


---
 fs/buffer.c               |   23 +++++++++++++++++++----
 include/linux/workqueue.h |    3 +++
 kernel/workqueue.c        |   31 +++++++++++++++++++++++++++----
 3 files changed, 49 insertions(+), 8 deletions(-)

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -1323,6 +1323,7 @@ struct bh_lru {
 };
 
 static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
+static cpumask_t lru_in_use;
 
 #ifdef CONFIG_SMP
 #define bh_lru_lock()	local_irq_disable()
@@ -1352,9 +1353,14 @@ static void bh_lru_install(struct buffer
 	lru = &__get_cpu_var(bh_lrus);
 	if (lru->bhs[0] != bh) {
 		struct buffer_head *bhs[BH_LRU_SIZE];
-		int in;
-		int out = 0;
+		int in, out, cpu;
 
+		cpu = raw_smp_processor_id();
+		/* Test first to avoid cache lines bouncing around */
+		if (!cpu_isset(cpu, lru_in_use))
+			cpu_set(cpu, lru_in_use);
+
+		out = 0;
 		get_bh(bh);
 		bhs[out++] = bh;
 		for (in = 0; in < BH_LRU_SIZE; in++) {
@@ -1500,19 +1506,28 @@ EXPORT_SYMBOL(__bread);
  */
 static void invalidate_bh_lru(void *arg)
 {
-	struct bh_lru *b = &get_cpu_var(bh_lrus);
+	struct bh_lru *b;
 	int i;
 
+	local_irq_disable();
+	b = &get_cpu_var(bh_lrus);
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		brelse(b->bhs[i]);
 		b->bhs[i] = NULL;
 	}
 	put_cpu_var(bh_lrus);
+	local_irq_enable();
 }
 	
 static void invalidate_bh_lrus(void)
 {
-	on_each_cpu(invalidate_bh_lru, NULL, 1, 1);
+	/*
+	 * Need to hand down a copy of the mask or we wouldn't be run
+	 * anywhere due to the original mask being cleared
+	 */
+	cpumask_t mask = lru_in_use;
+	cpus_clear(lru_in_use);
+	schedule_on_each_cpu_mask(invalidate_bh_lru, NULL, mask);
 }
 
 void set_bh_page(struct buffer_head *bh,
Index: linux-2.6/include/linux/workqueue.h
===================================================================
--- linux-2.6.orig/include/linux/workqueue.h
+++ linux-2.6/include/linux/workqueue.h
@@ -8,6 +8,7 @@
 #include <linux/timer.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
+#include <linux/cpumask.h>
 
 struct workqueue_struct;
 
@@ -70,6 +71,8 @@ extern int FASTCALL(schedule_delayed_wor
 
 extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
 extern int schedule_on_each_cpu(void (*func)(void *info), void *info);
+extern int schedule_on_each_cpu_mask(void (*func)(void *info),
+				     void *info, cpumask_t mask);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
 extern int keventd_up(void);
Index: linux-2.6/kernel/workqueue.c
===================================================================
--- linux-2.6.orig/kernel/workqueue.c
+++ linux-2.6/kernel/workqueue.c
@@ -429,9 +429,11 @@ int schedule_delayed_work_on(int cpu,
 }
 
 /**
- * schedule_on_each_cpu - call a function on each online CPU from keventd
+ * schedule_on_each_cpu_mask -  call a function on each online CPU in the
+ *				mask from keventd
  * @func: the function to call
  * @info: a pointer to pass to func()
+ * @mask: a cpumask_t of CPUs to schedule on
  *
  * Returns zero on success.
  * Returns -ve errno on failure.
@@ -440,7 +442,8 @@ int schedule_delayed_work_on(int cpu,
  *
  * schedule_on_each_cpu() is very slow.
  */
-int schedule_on_each_cpu(void (*func)(void *info), void *info)
+int
+schedule_on_each_cpu_mask(void (*func)(void *info), void *info, cpumask_t mask)
 {
 	int cpu;
 	struct work_struct *works;
@@ -451,14 +454,34 @@ int schedule_on_each_cpu(void (*func)(vo
 
 	for_each_online_cpu(cpu) {
 		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
-		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
-				per_cpu_ptr(works, cpu));
+		if (cpu_isset(cpu, mask))
+			__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
+				     per_cpu_ptr(works, cpu));
 	}
 	flush_workqueue(keventd_wq);
 	free_percpu(works);
 	return 0;
 }
 
+/**
+ * schedule_on_each_cpu_mask -  call a function on each online CPU from keventd
+ *
+ * @func: the function to call
+ * @info: a pointer to pass to func()
+ *
+ * Returns zero on success.
+ * Returns -ve errno on failure.
+ *
+ * Appears to be racy against CPU hotplug.
+ *
+ * schedule_on_each_cpu() is very slow.
+ */
+int
+schedule_on_each_cpu(void (*func)(void *info), void *info)
+{
+	return schedule_on_each_cpu_mask(func, info, CPU_MASK_ALL);
+}
+
 void flush_scheduled_work(void)
 {
 	flush_workqueue(keventd_wq);
