Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315660AbSEIIyc>; Thu, 9 May 2002 04:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315661AbSEIIyb>; Thu, 9 May 2002 04:54:31 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:20743 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315660AbSEIIyZ>; Thu, 9 May 2002 04:54:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug CPU prep IV: non-linear CPU numbers
Date: Thu, 09 May 2002 18:57:41 +1000
Message-Id: <E175jk6-0003Ws-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes:
1) cpu_logical_map & cpu_number_map
2) smp_num_cpus.
3) The sense of complacency caused by too much 2.5 stability.

When CPUs can appear and disappear, "neatening" the numbers becomes
impractical anyway: it's also one of the top 10 causes of bugs.

This is just the core code: x86 fixups are in the next patch.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Non-linear CPU Numbers Patch
Author: Rusty Russell
Status: Experimental

D: This patch removes the concept of "logical" CPU numbers, in
D: preparation for CPU hotplugging.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/include/linux/smp.h linux-2.5.14.23963.updated/include/linux/smp.h
--- linux-2.5.14.23963/include/linux/smp.h	Tue Apr 23 11:39:40 2002
+++ linux-2.5.14.23963.updated/include/linux/smp.h	Mon May  6 18:06:41 2002
@@ -57,8 +57,6 @@
  */
 extern int smp_threads_ready;
 
-extern int smp_num_cpus;
-
 extern volatile unsigned long smp_msg_data;
 extern volatile int smp_src_cpu;
 extern volatile int smp_msg_id;
@@ -79,19 +77,17 @@
  *	These macros fold the SMP functionality into a single CPU system
  */
  
-#define smp_num_cpus				1
 #define smp_processor_id()			0
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
 #ifndef CONFIG_PREEMPT
 #define kernel_lock()
 #endif
-#define cpu_logical_map(cpu)			0
-#define cpu_number_map(cpu)			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
-#define cpu_online_map				1
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define cpu_online(cpu)				1
+#define num_online_cpus()			1
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/drivers/acpi/acpi_processor.c linux-2.5.14.23963.updated/drivers/acpi/acpi_processor.c
--- linux-2.5.14.23963/drivers/acpi/acpi_processor.c	Mon Apr 15 11:47:17 2002
+++ linux-2.5.14.23963.updated/drivers/acpi/acpi_processor.c	Mon May  6 18:06:41 2002
@@ -2038,8 +2038,9 @@
 		return_VALUE(-EINVAL);
 
 #ifdef CONFIG_SMP
-	if (smp_num_cpus > 1)
-		errata.smp = smp_num_cpus;
+	/* FIXME: Used to be smp_num_cpus: what should it be? --RR */
+	if (num_online_cpus() > 1)
+		errata.smp = num_online_cpus();
 #endif
 
 	acpi_processor_errata(pr);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/drivers/char/agp/agpgart_be.c linux-2.5.14.23963.updated/drivers/char/agp/agpgart_be.c
--- linux-2.5.14.23963/drivers/char/agp/agpgart_be.c	Wed May  1 15:09:20 2002
+++ linux-2.5.14.23963.updated/drivers/char/agp/agpgart_be.c	Mon May  6 18:06:41 2002
@@ -98,7 +98,7 @@
 
 static void smp_flush_cache(void)
 {
-	atomic_set(&cpus_waiting, smp_num_cpus - 1);
+	atomic_set(&cpus_waiting, num_online_cpus() - 1);
 	if (smp_call_function(ipi_handler, NULL, 1, 0) != 0)
 		panic(PFX "timed out waiting for the other CPUs!\n");
 	flush_cache();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/drivers/net/aironet4500_core.c linux-2.5.14.23963.updated/drivers/net/aironet4500_core.c
--- linux-2.5.14.23963/drivers/net/aironet4500_core.c	Wed Feb 20 17:57:08 2002
+++ linux-2.5.14.23963.updated/drivers/net/aironet4500_core.c	Mon May  6 18:06:41 2002
@@ -2669,10 +2669,8 @@
 	 * but without it card gets screwed up 
 	 */ 
 #ifdef CONFIG_SMP
-	if(smp_num_cpus > 1){
 		both_bap_lock = 1;
 		bap_setup_spinlock = 1;
-	}
 #endif
 	//awc_dump_registers(dev);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/drivers/video/fbcon.c linux-2.5.14.23963.updated/drivers/video/fbcon.c
--- linux-2.5.14.23963/drivers/video/fbcon.c	Mon Apr 29 16:00:26 2002
+++ linux-2.5.14.23963.updated/drivers/video/fbcon.c	Mon May  6 18:06:41 2002
@@ -2177,7 +2177,7 @@
     if (p->fb_info->fbops->fb_rasterimg)
     	p->fb_info->fbops->fb_rasterimg(p->fb_info, 1);
 
-    for (x = 0; x < smp_num_cpus * (LOGO_W + 8) &&
+    for (x = 0; x < num_online_cpus() * (LOGO_W + 8) &&
     	 x < p->var.xres - (LOGO_W + 8); x += (LOGO_W + 8)) {
     	 
 #if defined(CONFIG_FBCON_CFB16) || defined(CONFIG_FBCON_CFB24) || \
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/fs/proc/array.c linux-2.5.14.23963.updated/fs/proc/array.c
--- linux-2.5.14.23963/fs/proc/array.c	Mon May  6 16:00:10 2002
+++ linux-2.5.14.23963.updated/fs/proc/array.c	Mon May  6 18:06:41 2002
@@ -693,12 +693,14 @@
 		task->times.tms_utime,
 		task->times.tms_stime);
 		
-	for (i = 0 ; i < smp_num_cpus; i++)
+	for (i = 0 ; i < NR_CPUS; i++) {
+		if (cpu_online(i))
 		len += sprintf(buffer + len, "cpu%d %lu %lu\n",
 			i,
-			task->per_cpu_utime[cpu_logical_map(i)],
-			task->per_cpu_stime[cpu_logical_map(i)]);
+				       task->per_cpu_utime[i],
+				       task->per_cpu_stime[i]);
 
+	}
 	return len;
 }
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/fs/proc/proc_misc.c linux-2.5.14.23963.updated/fs/proc/proc_misc.c
--- linux-2.5.14.23963/fs/proc/proc_misc.c	Mon May  6 11:11:59 2002
+++ linux-2.5.14.23963.updated/fs/proc/proc_misc.c	Mon May  6 18:06:41 2002
@@ -265,29 +265,32 @@
 	unsigned int sum = 0, user = 0, nice = 0, system = 0;
 	int major, disk;
 
-	for (i = 0 ; i < smp_num_cpus; i++) {
-		int cpu = cpu_logical_map(i), j;
+	for (i = 0 ; i < NR_CPUS; i++) {
+		int j;
 
-		user += kstat.per_cpu_user[cpu];
-		nice += kstat.per_cpu_nice[cpu];
-		system += kstat.per_cpu_system[cpu];
+		if(!cpu_online(i)) continue;
+		user += kstat.per_cpu_user[i];
+		nice += kstat.per_cpu_nice[i];
+		system += kstat.per_cpu_system[i];
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
-			sum += kstat.irqs[cpu][j];
+			sum += kstat.irqs[i][j];
 #endif
 	}
 
 	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
-	for (i = 0 ; i < smp_num_cpus; i++)
+		      jif * num_online_cpus() - (user + nice + system));
+	for (i = 0 ; i < NR_CPUS; i++){
+		if (!cpu_online(i)) continue;
 		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
 			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+			kstat.per_cpu_user[i],
+			kstat.per_cpu_nice[i],
+			kstat.per_cpu_system[i],
+			jif - (  kstat.per_cpu_user[i] \
+				   + kstat.per_cpu_nice[i] \
+				   + kstat.per_cpu_system[i]));
+	}
 	len += sprintf(page + len,
 		"page %u %u\n"
 		"swap %u %u\n"
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/include/linux/kernel_stat.h linux-2.5.14.23963.updated/include/linux/kernel_stat.h
--- linux-2.5.14.23963/include/linux/kernel_stat.h	Mon May  6 11:12:01 2002
+++ linux-2.5.14.23963.updated/include/linux/kernel_stat.h	Mon May  6 18:06:41 2002
@@ -43,8 +43,8 @@
 {
 	int i, sum=0;
 
-	for (i = 0 ; i < smp_num_cpus ; i++)
-		sum += kstat.irqs[cpu_logical_map(i)][irq];
+	for (i = 0 ; i < NR_CPUS ; i++)
+		sum += kstat.irqs[i][irq];
 
 	return sum;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/kernel/fork.c linux-2.5.14.23963.updated/kernel/fork.c
--- linux-2.5.14.23963/kernel/fork.c	Mon Apr 29 16:00:29 2002
+++ linux-2.5.14.23963.updated/kernel/fork.c	Mon May  6 18:06:41 2002
@@ -701,9 +701,8 @@
 		int i;
 
 		/* ?? should we just memset this ?? */
-		for(i = 0; i < smp_num_cpus; i++)
-			p->per_cpu_utime[cpu_logical_map(i)] =
-				p->per_cpu_stime[cpu_logical_map(i)] = 0;
+		for(i = 0; i < NR_CPUS; i++)
+			p->per_cpu_utime[i] = p->per_cpu_stime[i] = 0;
 		spin_lock_init(&p->sigmask_lock);
 	}
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/kernel/sched.c linux-2.5.14.23963.updated/kernel/sched.c
--- linux-2.5.14.23963/kernel/sched.c	Wed May  1 15:09:29 2002
+++ linux-2.5.14.23963.updated/kernel/sched.c	Mon May  6 18:06:41 2002
@@ -437,8 +437,8 @@
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(cpu_logical_map(i))->nr_running;
+	for (i = 0; i < NR_CPUS; i++)
+		sum += cpu_rq(i)->nr_running;
 
 	return sum;
 }
@@ -447,8 +447,8 @@
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(cpu_logical_map(i))->nr_switches;
+	for (i = 0; i < NR_CPUS; i++)
+		sum += cpu_rq(i)->nr_switches;
 
 	return sum;
 }
@@ -523,15 +523,16 @@
 
 	busiest = NULL;
 	max_load = 1;
-	for (i = 0; i < smp_num_cpus; i++) {
-		int logical = cpu_logical_map(i);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
 
-		rq_src = cpu_rq(logical);
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[logical]))
+		rq_src = cpu_rq(i);
+		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
 			load = rq_src->nr_running;
 		else
-			load = this_rq->prev_nr_running[logical];
-		this_rq->prev_nr_running[logical] = rq_src->nr_running;
+			load = this_rq->prev_nr_running[i];
+		this_rq->prev_nr_running[i] = rq_src->nr_running;
 
 		if ((load > max_load) && (rq_src != this_rq)) {
 			busiest = rq_src;
@@ -1691,7 +1692,7 @@
 
 static int migration_thread(void * bind_cpu)
 {
-	int cpu = cpu_logical_map((int) (long) bind_cpu);
+	int cpu = (int) (long) bind_cpu;
 	struct sched_param param = { sched_priority: MAX_RT_PRIO-1 };
 	runqueue_t *rq;
 	int ret;
@@ -1699,12 +1700,15 @@
 	daemonize();
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
+
+	/* FIXME: First CPU may not be zero, but this crap code
+           vanishes with hotplug cpu patch anyway. --RR */
 	/*
 	 * The first migration thread is started on CPU #0. This one can migrate
 	 * the other migration threads to their destination CPUs.
 	 */
 	if (cpu != 0) {
-		while (!cpu_rq(cpu_logical_map(0))->migration_thread)
+		while (!cpu_rq(0)->migration_thread)
 			yield();
 		set_cpus_allowed(current, 1UL << cpu);
 	}
@@ -1768,16 +1772,21 @@
 {
 	int cpu;
 
-	current->cpus_allowed = 1UL << cpu_logical_map(0);
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	current->cpus_allowed = 1UL << 0;
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu))
+			continue;
 		if (kernel_thread(migration_thread, (void *) (long) cpu,
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
 	}
 	current->cpus_allowed = -1L;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu))
+			continue;
 		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
 			schedule_timeout(2);
+	}
 }
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/kernel/softirq.c linux-2.5.14.23963.updated/kernel/softirq.c
--- linux-2.5.14.23963/kernel/softirq.c	Wed Feb 20 17:56:17 2002
+++ linux-2.5.14.23963.updated/kernel/softirq.c	Mon May  6 18:06:41 2002
@@ -360,20 +360,19 @@
 
 static int ksoftirqd(void * __bind_cpu)
 {
-	int bind_cpu = (int) (long) __bind_cpu;
-	int cpu = cpu_logical_map(bind_cpu);
+	int cpu = (int) (long) __bind_cpu;
 
 	daemonize();
 	set_user_nice(current, 19);
 	sigfillset(&current->blocked);
 
+	sprintf(current->comm, "ksoftirqd_CPU%d", cpu);
+
 	/* Migrate to the right CPU */
 	set_cpus_allowed(current, 1UL << cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
 
-	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
-
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
 
@@ -398,13 +397,16 @@
 {
 	int cpu;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu))
+			continue;
 		if (kernel_thread(ksoftirqd, (void *) (long) cpu,
 				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			printk("spawn_ksoftirqd() failed for cpu %d\n", cpu);
 		else
-			while (!ksoftirqd_task(cpu_logical_map(cpu)))
+			while (!ksoftirqd_task(cpu))
 				yield();
+	}
 	return 0;
 }
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/lib/brlock.c linux-2.5.14.23963.updated/lib/brlock.c
--- linux-2.5.14.23963/lib/brlock.c	Sat Nov 10 09:11:15 2001
+++ linux-2.5.14.23963.updated/lib/brlock.c	Mon May  6 18:06:41 2002
@@ -24,16 +24,16 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		write_lock(&__brlock_array[cpu_logical_map(i)][idx]);
+	for (i = 0; i < NR_CPUS; i++)
+		write_lock(&__brlock_array[i][idx]);
 }
 
 void __br_write_unlock (enum brlock_indices idx)
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		write_unlock(&__brlock_array[cpu_logical_map(i)][idx]);
+	for (i = 0; i < NR_CPUS; i++)
+		write_unlock(&__brlock_array[i][idx]);
 }
 
 #else /* ! __BRLOCK_USE_ATOMICS */
@@ -50,8 +50,8 @@
 
 again:
 	spin_lock(&__br_write_locks[idx].lock);
-	for (i = 0; i < smp_num_cpus; i++)
-		if (__brlock_array[cpu_logical_map(i)][idx] != 0) {
+	for (i = 0; i < NR_CPUS; i++)
+		if (__brlock_array[i][idx] != 0) {
 			spin_unlock(&__br_write_locks[idx].lock);
 			barrier();
 			cpu_relax();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.14/mm/page_alloc.c working-2.5.14-hotcpu/mm/page_alloc.c
--- linux-2.5.14/mm/page_alloc.c	Mon May  6 16:00:11 2002
+++ working-2.5.14-hotcpu/mm/page_alloc.c	Mon May  6 18:25:24 2002
@@ -590,10 +590,10 @@
 	ret->nr_writeback = 0;
 	ret->nr_pagecache = 0;
 
-	for (pcpu = 0; pcpu < smp_num_cpus; pcpu++) {
+	for (pcpu = 0; pcpu < NR_CPUS; pcpu++) {
 		struct page_state *ps;
 
-		ps = &page_states[cpu_logical_map(pcpu)];
+		ps = &page_states[pcpu];
 		ret->nr_dirty += ps->nr_dirty;
 		ret->nr_writeback += ps->nr_writeback;
 		ret->nr_pagecache += ps->nr_pagecache;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/mm/slab.c linux-2.5.14.23963.updated/mm/slab.c
--- linux-2.5.14.23963/mm/slab.c	Mon May  6 16:00:11 2002
+++ linux-2.5.14.23963.updated/mm/slab.c	Mon May  6 18:06:41 2002
@@ -937,8 +937,8 @@
 	down(&cache_chain_sem);
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
 
-	for (i = 0; i < smp_num_cpus; i++) {
-		cpucache_t* ccold = new.new[cpu_logical_map(i)];
+	for (i = 0; i < NR_CPUS; i++) {
+		cpucache_t* ccold = new.new[i];
 		if (!ccold || (ccold->avail == 0))
 			continue;
 		local_irq_disable();
@@ -1671,16 +1671,18 @@
 
 	memset(&new.new,0,sizeof(new.new));
 	if (limit) {
-		for (i = 0; i< smp_num_cpus; i++) {
+		for (i = 0; i < NR_CPUS; i++) {
 			cpucache_t* ccnew;
 
 			ccnew = kmalloc(sizeof(void*)*limit+
 					sizeof(cpucache_t), GFP_KERNEL);
-			if (!ccnew)
-				goto oom;
+			if (!ccnew) {
+				for (i--; i >= 0; i--) kfree(new.new[i]);
+				return -ENOMEM;
+			}
 			ccnew->limit = limit;
 			ccnew->avail = 0;
-			new.new[cpu_logical_map(i)] = ccnew;
+			new.new[i] = ccnew;
 		}
 	}
 	new.cachep = cachep;
@@ -1690,8 +1692,8 @@
 
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
 
-	for (i = 0; i < smp_num_cpus; i++) {
-		cpucache_t* ccold = new.new[cpu_logical_map(i)];
+	for (i = 0; i < NR_CPUS; i++) {
+		cpucache_t* ccold = new.new[i];
 		if (!ccold)
 			continue;
 		local_irq_disable();
@@ -1700,10 +1702,6 @@
 		kfree(ccold);
 	}
 	return 0;
-oom:
-	for (i--; i >= 0; i--)
-		kfree(new.new[cpu_logical_map(i)]);
-	return -ENOMEM;
 }
 
 static void enable_cpucache (kmem_cache_t *cachep)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/core/dev.c linux-2.5.14.23963.updated/net/core/dev.c
--- linux-2.5.14.23963/net/core/dev.c	Thu Mar 21 14:14:56 2002
+++ linux-2.5.14.23963.updated/net/core/dev.c	Mon May  6 18:06:41 2002
@@ -1815,11 +1815,11 @@
 static int dev_proc_stats(char *buffer, char **start, off_t offset,
 			  int length, int *eof, void *data)
 {
-	int i, lcpu;
+	int i;
 	int len=0;
 
-	for (lcpu=0; lcpu<smp_num_cpus; lcpu++) {
-		i = cpu_logical_map(lcpu);
+	for (i=0; i<NR_CPUS; i++) {
+		if (cpu_online(i)) {
 		len += sprintf(buffer+len, "%08x %08x %08x %08x %08x %08x %08x %08x %08x\n",
 			       netdev_rx_stat[i].total,
 			       netdev_rx_stat[i].dropped,
@@ -1835,6 +1835,7 @@
 			       netdev_rx_stat[i].cpu_collision
 #endif
 			       );
+	}
 	}
 
 	len -= offset;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/ipv4/netfilter/arp_tables.c linux-2.5.14.23963.updated/net/ipv4/netfilter/arp_tables.c
--- linux-2.5.14.23963/net/ipv4/netfilter/arp_tables.c	Thu Mar 21 14:14:57 2002
+++ linux-2.5.14.23963.updated/net/ipv4/netfilter/arp_tables.c	Mon May  6 18:06:41 2002
@@ -259,7 +259,7 @@
 	read_lock_bh(&table->lock);
 	table_base = (void *)table->private->entries
 		+ TABLE_OFFSET(table->private,
-			       cpu_number_map(smp_processor_id()));
+			       smp_processor_id());
 	e = get_entry(table_base, table->private->hook_entry[hook]);
 	back = get_entry(table_base, table->private->underflow[hook]);
 
@@ -705,7 +705,7 @@
 	}
 
 	/* And one copy for every other CPU */
-	for (i = 1; i < smp_num_cpus; i++) {
+	for (i = 1; i < NR_CPUS; i++) {
 		memcpy(newinfo->entries + SMP_ALIGN(newinfo->size)*i,
 		       newinfo->entries,
 		       SMP_ALIGN(newinfo->size));
@@ -756,7 +756,7 @@
 	unsigned int cpu;
 	unsigned int i;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		i = 0;
 		ARPT_ENTRY_ITERATE(t->entries + TABLE_OFFSET(t, cpu),
 				   t->size,
@@ -874,7 +874,7 @@
 		return -ENOMEM;
 
 	newinfo = vmalloc(sizeof(struct arpt_table_info)
-			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
+			  + SMP_ALIGN(tmp.size) * NR_CPUS);
 	if (!newinfo)
 		return -ENOMEM;
 
@@ -1143,7 +1143,7 @@
 
 	MOD_INC_USE_COUNT;
 	newinfo = vmalloc(sizeof(struct arpt_table_info)
-			  + SMP_ALIGN(table->table->size) * smp_num_cpus);
+			  + SMP_ALIGN(table->table->size) * NR_CPUS);
 	if (!newinfo) {
 		ret = -ENOMEM;
 		MOD_DEC_USE_COUNT;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/ipv4/netfilter/ip_tables.c linux-2.5.14.23963.updated/net/ipv4/netfilter/ip_tables.c
--- linux-2.5.14.23963/net/ipv4/netfilter/ip_tables.c	Wed Feb 20 17:56:17 2002
+++ linux-2.5.14.23963.updated/net/ipv4/netfilter/ip_tables.c	Mon May  6 18:06:41 2002
@@ -288,8 +288,7 @@
 	read_lock_bh(&table->lock);
 	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
 	table_base = (void *)table->private->entries
-		+ TABLE_OFFSET(table->private,
-			       cpu_number_map(smp_processor_id()));
+		+ TABLE_OFFSET(table->private, smp_processor_id());
 	e = get_entry(table_base, table->private->hook_entry[hook]);
 
 #ifdef CONFIG_NETFILTER_DEBUG
@@ -865,7 +864,7 @@
 	}
 
 	/* And one copy for every other CPU */
-	for (i = 1; i < smp_num_cpus; i++) {
+	for (i = 1; i < NR_CPUS; i++) {
 		memcpy(newinfo->entries + SMP_ALIGN(newinfo->size)*i,
 		       newinfo->entries,
 		       SMP_ALIGN(newinfo->size));
@@ -887,7 +886,7 @@
 		struct ipt_entry *table_base;
 		unsigned int i;
 
-		for (i = 0; i < smp_num_cpus; i++) {
+		for (i = 0; i < NR_CPUS; i++) {
 			table_base =
 				(void *)newinfo->entries
 				+ TABLE_OFFSET(newinfo, i);
@@ -934,7 +933,7 @@
 	unsigned int cpu;
 	unsigned int i;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		i = 0;
 		IPT_ENTRY_ITERATE(t->entries + TABLE_OFFSET(t, cpu),
 				  t->size,
@@ -1072,7 +1071,7 @@
 		return -ENOMEM;
 
 	newinfo = vmalloc(sizeof(struct ipt_table_info)
-			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
+			  + SMP_ALIGN(tmp.size) * NR_CPUS);
 	if (!newinfo)
 		return -ENOMEM;
 
@@ -1385,7 +1384,7 @@
 
 	MOD_INC_USE_COUNT;
 	newinfo = vmalloc(sizeof(struct ipt_table_info)
-			  + SMP_ALIGN(table->table->size) * smp_num_cpus);
+			  + SMP_ALIGN(table->table->size) * NR_CPUS);
 	if (!newinfo) {
 		ret = -ENOMEM;
 		MOD_DEC_USE_COUNT;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/ipv4/netfilter/ipchains_core.c linux-2.5.14.23963.updated/net/ipv4/netfilter/ipchains_core.c
--- linux-2.5.14.23963/net/ipv4/netfilter/ipchains_core.c	Wed Feb 20 17:56:17 2002
+++ linux-2.5.14.23963.updated/net/ipv4/netfilter/ipchains_core.c	Mon May  6 18:06:41 2002
@@ -125,8 +125,8 @@
  * UP.
  *
  * For backchains and counters, we use an array, indexed by
- * [cpu_number_map[smp_processor_id()]*2 + !in_interrupt()]; the array is of
- * size [smp_num_cpus*2].  For v2.0, smp_num_cpus is effectively 1.  So,
+ * [smp_processor_id()*2 + !in_interrupt()]; the array is of
+ * size [NR_CPUS*2].  For v2.0, NR_CPUS is effectively 1.  So,
  * confident of uniqueness, we modify counters even though we only
  * have a read lock (to read the counters, you need a write lock,
  * though).  */
@@ -151,11 +151,11 @@
 #endif
 
 #ifdef CONFIG_SMP
-#define SLOT_NUMBER() (cpu_number_map(smp_processor_id())*2 + !in_interrupt())
+#define SLOT_NUMBER() (smp_processor_id()*2 + !in_interrupt())
 #else /* !SMP */
 #define SLOT_NUMBER() (!in_interrupt())
 #endif /* CONFIG_SMP */
-#define NUM_SLOTS (smp_num_cpus*2)
+#define NUM_SLOTS (NR_CPUS*2)
 
 #define SIZEOF_STRUCT_IP_CHAIN (sizeof(struct ip_chain) \
 				+ NUM_SLOTS*sizeof(struct ip_reent))
@@ -1121,7 +1121,7 @@
 	label->chain = NULL;
 	label->refcount = ref;
 	label->policy = policy;
-	for (i = 0; i < smp_num_cpus*2; i++) {
+	for (i = 0; i < NUM_SLOTS; i++) {
 		label->reent[i].counters.pcnt = label->reent[i].counters.bcnt
 			= 0;
 		label->reent[i].prevchain = NULL;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/ipv4/proc.c linux-2.5.14.23963.updated/net/ipv4/proc.c
--- linux-2.5.14.23963/net/ipv4/proc.c	Thu May 17 03:21:45 2001
+++ linux-2.5.14.23963.updated/net/ipv4/proc.c	Mon May  6 18:06:41 2002
@@ -55,8 +55,8 @@
 	int res = 0;
 	int cpu;
 
-	for (cpu=0; cpu<smp_num_cpus; cpu++)
-		res += proto->stats[cpu_logical_map(cpu)].inuse;
+	for (cpu=0; cpu<NR_CPUS; cpu++)
+		res += proto->stats[cpu].inuse;
 
 	return res;
 }
@@ -103,9 +103,9 @@
 
 	sz /= sizeof(unsigned long);
 
-	for (i=0; i<smp_num_cpus; i++) {
-		res += begin[2*cpu_logical_map(i)*sz + nr];
-		res += begin[(2*cpu_logical_map(i)+1)*sz + nr];
+	for (i=0; i<NR_CPUS; i++) {
+		res += begin[2*i*sz + nr];
+		res += begin[(2*i+1)*sz + nr];
 	}
 	return res;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/ipv4/route.c linux-2.5.14.23963.updated/net/ipv4/route.c
--- linux-2.5.14.23963/net/ipv4/route.c	Mon Apr 15 11:47:52 2002
+++ linux-2.5.14.23963.updated/net/ipv4/route.c	Mon May  6 18:06:41 2002
@@ -280,12 +280,10 @@
 static int rt_cache_stat_get_info(char *buffer, char **start, off_t offset, int length)
 {
 	unsigned int dst_entries = atomic_read(&ipv4_dst_ops.entries);
-	int i, lcpu;
+	int i;
 	int len = 0;
 
-        for (lcpu = 0; lcpu < smp_num_cpus; lcpu++) {
-                i = cpu_logical_map(lcpu);
-
+        for (i = 0; i < NR_CPUS; i++) {
 		len += sprintf(buffer+len, "%08x  %08x %08x %08x %08x %08x %08x %08x  %08x %08x %08x\n",
 			       dst_entries,		       
 			       rt_cache_stat[i].in_hit,
@@ -2423,19 +2421,16 @@
 		memcpy(dst, src, length);
 
 #ifdef CONFIG_SMP
-		if (smp_num_cpus > 1 || cpu_logical_map(0) != 0) {
+		/* Alexey, be ashamed: speed gained, horror unleashed. --RR */
+		if (num_online_cpus() > 1 || !cpu_online(0)) {
 			int i;
 			int cnt = length / 4;
 
-			for (i = 0; i < smp_num_cpus; i++) {
-				int cpu = cpu_logical_map(i);
+			for (i = 1; i < NR_CPUS; i++) {
 				int k;
 
-				if (cpu == 0)
-					continue;
-
 				src = (u32*)(((u8*)ip_rt_acct) + offset +
-					cpu * 256 * sizeof(struct ip_rt_acct));
+					i * 256 * sizeof(struct ip_rt_acct));
 
 				for (k = 0; k < cnt; k++)
 					dst[k] += src[k];
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/ipv6/netfilter/ip6_tables.c linux-2.5.14.23963.updated/net/ipv6/netfilter/ip6_tables.c
--- linux-2.5.14.23963/net/ipv6/netfilter/ip6_tables.c	Mon May  6 11:12:01 2002
+++ linux-2.5.14.23963.updated/net/ipv6/netfilter/ip6_tables.c	Mon May  6 18:08:28 2002
@@ -913,7 +913,7 @@
 	}
 
 	/* And one copy for every other CPU */
-	for (i = 1; i < smp_num_cpus; i++) {
+	for (i = 1; i < NR_CPUS; i++) {
 		memcpy(newinfo->entries + SMP_ALIGN(newinfo->size)*i,
 		       newinfo->entries,
 		       SMP_ALIGN(newinfo->size));
@@ -935,7 +935,7 @@
 		struct ip6t_entry *table_base;
 		unsigned int i;
 
-		for (i = 0; i < smp_num_cpus; i++) {
+		for (i = 0; i < NR_CPUS; i++) {
 			table_base =
 				(void *)newinfo->entries
 				+ TABLE_OFFSET(newinfo, i);
@@ -982,7 +982,7 @@
 	unsigned int cpu;
 	unsigned int i;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		i = 0;
 		IP6T_ENTRY_ITERATE(t->entries + TABLE_OFFSET(t, cpu),
 				  t->size,
@@ -1116,7 +1116,7 @@
 		return -ENOMEM;
 
 	newinfo = vmalloc(sizeof(struct ip6t_table_info)
-			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
+			  + SMP_ALIGN(tmp.size) * NR_CPUS);
 	if (!newinfo)
 		return -ENOMEM;
 
@@ -1429,7 +1429,7 @@
 
 	MOD_INC_USE_COUNT;
 	newinfo = vmalloc(sizeof(struct ip6t_table_info)
-			  + SMP_ALIGN(table->table->size) * smp_num_cpus);
+			  + SMP_ALIGN(table->table->size) * NR_CPUS);
 	if (!newinfo) {
 		ret = -ENOMEM;
 		MOD_DEC_USE_COUNT;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/ipv6/proc.c linux-2.5.14.23963.updated/net/ipv6/proc.c
--- linux-2.5.14.23963/net/ipv6/proc.c	Wed Feb 20 17:57:22 2002
+++ linux-2.5.14.23963.updated/net/ipv6/proc.c	Mon May  6 18:06:41 2002
@@ -31,8 +31,8 @@
 	int res = 0;
 	int cpu;
 
-	for (cpu=0; cpu<smp_num_cpus; cpu++)
-		res += proto->stats[cpu_logical_map(cpu)].inuse;
+	for (cpu=0; cpu<NR_CPUS; cpu++)
+		res += proto->stats[cpu].inuse;
 
 	return res;
 }
@@ -140,9 +140,9 @@
 	unsigned long res = 0;
 	int i;
 
-	for (i=0; i<smp_num_cpus; i++) {
-		res += ptr[2*cpu_logical_map(i)*size];
-		res += ptr[(2*cpu_logical_map(i)+1)*size];
+	for (i=0; i<NR_CPUS; i++) {
+		res += ptr[2*i*size];
+		res += ptr[(2*i+1)*size];
 	}
 
 	return res;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14.23963/net/socket.c linux-2.5.14.23963.updated/net/socket.c
--- linux-2.5.14.23963/net/socket.c	Thu Mar 21 14:14:57 2002
+++ linux-2.5.14.23963.updated/net/socket.c	Mon May  6 18:06:41 2002
@@ -1773,8 +1773,8 @@
 	int len, cpu;
 	int counter = 0;
 
-	for (cpu=0; cpu<smp_num_cpus; cpu++)
-		counter += sockets_in_use[cpu_logical_map(cpu)].counter;
+	for (cpu=0; cpu<NR_CPUS; cpu++)
+		counter += sockets_in_use[cpu].counter;
 
 	/* It can be negative, by the way. 8) */
 	if (counter < 0)
