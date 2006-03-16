Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWCPDXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWCPDXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWCPDXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:23:51 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:51383 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932222AbWCPDXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:23:50 -0500
Date: Thu, 16 Mar 2006 12:22:40 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [2/19] fixes for generic part
Message-Id: <20060316122240.2d7b850a.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

replaces for_each_cpu with for_each_possible_cpu().

 block/ll_rw_blk.c            |    2 +-
 fs/file.c                    |    2 +-
 fs/proc/proc_misc.c          |    2 +-
 include/asm-generic/percpu.h |    2 +-
 include/linux/genhd.h        |    4 ++--
 include/linux/kernel_stat.h  |    2 +-
 init/main.c                  |    4 ++--
 kernel/rcutorture.c          |    4 ++--
 kernel/sched.c               |    8 ++++----
 lib/percpu_counter.c         |    2 +-
 mm/slab.c                    |    4 ++--
 11 files changed, 18 insertions(+), 18 deletions(-)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/kernel/rcutorture.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/rcutorture.c
+++ linux-2.6.16-rc6-mm1/kernel/rcutorture.c
@@ -301,7 +301,7 @@ rcu_torture_printk(char *page)
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
 			pipesummary[i] += per_cpu(rcu_torture_count, cpu)[i];
 			batchsummary[i] += per_cpu(rcu_torture_batch, cpu)[i];
@@ -535,7 +535,7 @@ rcu_torture_init(void)
 	atomic_set(&n_rcu_torture_error, 0);
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
 		atomic_set(&rcu_torture_wcount[i], 0);
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
 			per_cpu(rcu_torture_count, cpu)[i] = 0;
 			per_cpu(rcu_torture_batch, cpu)[i] = 0;
Index: linux-2.6.16-rc6-mm1/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/sched.c
+++ linux-2.6.16-rc6-mm1/kernel/sched.c
@@ -1720,7 +1720,7 @@ unsigned long nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		sum += cpu_rq(i)->nr_uninterruptible;
 
 	/*
@@ -1737,7 +1737,7 @@ unsigned long long nr_context_switches(v
 {
 	unsigned long long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		sum += cpu_rq(i)->nr_switches;
 
 	return sum;
@@ -1747,7 +1747,7 @@ unsigned long nr_iowait(void)
 {
 	unsigned long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		sum += atomic_read(&cpu_rq(i)->nr_iowait);
 
 	return sum;
@@ -6342,7 +6342,7 @@ void __init sched_init(void)
 	runqueue_t *rq;
 	int i, j, k;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
Index: linux-2.6.16-rc6-mm1/mm/slab.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/mm/slab.c
+++ linux-2.6.16-rc6-mm1/mm/slab.c
@@ -3287,7 +3287,7 @@ void *__alloc_percpu(size_t size)
 	 * and we have no way of figuring out how to fix the array
 	 * that we have allocated then....
 	 */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		int node = cpu_to_node(i);
 
 		if (node_online(node))
@@ -3374,7 +3374,7 @@ void free_percpu(const void *objp)
 	/*
 	 * We allocate for all cpus so we cannot use for online cpu here.
 	 */
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 	    kfree(p->ptrs[i]);
 	kfree(p);
 }
Index: linux-2.6.16-rc6-mm1/fs/file.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/fs/file.c
+++ linux-2.6.16-rc6-mm1/fs/file.c
@@ -373,6 +373,6 @@ static void __devinit fdtable_defer_list
 void __init files_defer_init(void)
 {
 	int i;
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		fdtable_defer_list_init(i);
 }
Index: linux-2.6.16-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/fs/proc/proc_misc.c
+++ linux-2.6.16-rc6-mm1/fs/proc/proc_misc.c
@@ -534,7 +534,7 @@ static int show_stat(struct seq_file *p,
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		int j;
 
 		user = cputime64_add(user, kstat_cpu(i).cpustat.user);
Index: linux-2.6.16-rc6-mm1/block/ll_rw_blk.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/block/ll_rw_blk.c
+++ linux-2.6.16-rc6-mm1/block/ll_rw_blk.c
@@ -3549,7 +3549,7 @@ int __init blk_dev_init(void)
 	iocontext_cachep = kmem_cache_create("blkdev_ioc",
 			sizeof(struct io_context), 0, SLAB_PANIC, NULL, NULL);
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
 
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq, NULL);
Index: linux-2.6.16-rc6-mm1/lib/percpu_counter.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/lib/percpu_counter.c
+++ linux-2.6.16-rc6-mm1/lib/percpu_counter.c
@@ -50,7 +50,7 @@ long percpu_counter_sum(struct percpu_co
 
 	spin_lock(&fbc->lock);
 	ret = fbc->count;
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		long *pcount = per_cpu_ptr(fbc->counters, cpu);
 		ret += *pcount;
 	}
Index: linux-2.6.16-rc6-mm1/init/main.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/init/main.c
+++ linux-2.6.16-rc6-mm1/init/main.c
@@ -359,7 +359,7 @@ static void __init setup_per_cpu_areas(v
 #endif
 	ptr = alloc_bootmem(size * nr_possible_cpus);
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
 		ptr += size;
@@ -680,7 +680,7 @@ static inline void fixup_cpu_present_map
 	 * for other cpu bringup code to function as normal. e.g smp_init() etc.
 	 */
 	if (cpus_empty(cpu_present_map)) {
-		for_each_cpu(i) {
+		for_each_possible_cpu(i) {
 			cpu_set(i, cpu_present_map);
 		}
 	}
Index: linux-2.6.16-rc6-mm1/include/linux/genhd.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/genhd.h
+++ linux-2.6.16-rc6-mm1/include/linux/genhd.h
@@ -149,14 +149,14 @@ struct disk_attribute {
 ({									\
 	typeof(gendiskp->dkstats->field) res = 0;			\
 	int i;								\
-	for_each_cpu(i)							\
+	for_each_possible_cpu(i)					\
 		res += per_cpu_ptr(gendiskp->dkstats, i)->field;	\
 	res;								\
 })
 
 static inline void disk_stat_set_all(struct gendisk *gendiskp, int value)	{
 	int i;
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		memset(per_cpu_ptr(gendiskp->dkstats, i), value,
 				sizeof (struct disk_stats));
 }		
Index: linux-2.6.16-rc6-mm1/include/linux/kernel_stat.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/kernel_stat.h
+++ linux-2.6.16-rc6-mm1/include/linux/kernel_stat.h
@@ -46,7 +46,7 @@ static inline int kstat_irqs(int irq)
 {
 	int cpu, sum = 0;
 
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		sum += kstat_cpu(cpu).irqs[irq];
 
 	return sum;
Index: linux-2.6.16-rc6-mm1/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/asm-generic/percpu.h
+++ linux-2.6.16-rc6-mm1/include/asm-generic/percpu.h
@@ -19,7 +19,7 @@ extern unsigned long __per_cpu_offset[NR
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for_each_cpu(__i)					\
+	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset[__i],		\
 		       (src), (size));				\
 } while (0)
