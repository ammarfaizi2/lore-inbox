Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSFKHIk>; Tue, 11 Jun 2002 03:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316877AbSFKHIj>; Tue, 11 Jun 2002 03:08:39 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:65434 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316864AbSFKHIU>; Tue, 11 Jun 2002 03:08:20 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp
Subject: [PATCH] 2.5.21 Nonlinear CPU support
Date: Tue, 11 Jun 2002 17:08:50 +1000
Message-Id: <E17Hflq-0005Hf-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  Tested on my dual x86 box.

This patch removes smp_num_cpus, cpu_number_map and cpu_logical_map
from generic code, and uses cpu_online(cpu) instead, in preparation
for hotplug CPUS.

Given how problematic the logical/number mapping of CPUs has been
(eg. Ingo's recent scheduler work), I think this is a win anyway,
independent of the fact that adding/removing CPUs makes it pointless.

[BTW: I didn't *have* to remove smp_num_cpus, but I did because almost
 all code using it is buggy once cpus go nonlinear...]

Next patch does updates i386, PPC and ia64 (thanks Kimio!)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Non-linear CPU Numbers Patch
Author: Rusty Russell
Status: Experimental

D: This patch removes the concept of "logical" CPU numbers, in
D: preparation for CPU hotplugging.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/Documentation/DocBook/kernel-hacking.tmpl linux-2.5.21.24110.updated/Documentation/DocBook/kernel-hacking.tmpl
--- linux-2.5.21.24110/Documentation/DocBook/kernel-hacking.tmpl	Tue Apr 23 11:39:29 2002
+++ linux-2.5.21.24110.updated/Documentation/DocBook/kernel-hacking.tmpl	Tue Jun 11 13:53:32 2002
@@ -702,19 +702,14 @@
   </sect1>
 
   <sect1 id="routines-processorids">
-   <title><function>smp_processor_id</function>()/<function>cpu_[number/logical]_map()</function>
+   <title><function>smp_processor_id</function>()
     <filename class=headerfile>include/asm/smp.h</filename></title>
    
    <para>
     <function>smp_processor_id()</function> returns the current
     processor number, between 0 and <symbol>NR_CPUS</symbol> (the
     maximum number of CPUs supported by Linux, currently 32).  These
-    values are not necessarily continuous: to get a number between 0
-    and <function>smp_num_cpus()</function> (the number of actual
-    processors in this machine), the
-    <function>cpu_number_map()</function> function is used to map the
-    processor id to a logical number.
-    <function>cpu_logical_map()</function> does the reverse.
+    values are not necessarily continuous.
    </para>
   </sect1>
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/drivers/acpi/processor.c linux-2.5.21.24110.updated/drivers/acpi/processor.c
--- linux-2.5.21.24110/drivers/acpi/processor.c	Mon Jun  3 12:21:22 2002
+++ linux-2.5.21.24110.updated/drivers/acpi/processor.c	Tue Jun 11 13:53:32 2002
@@ -2060,8 +2060,9 @@
 		return_VALUE(-EINVAL);
 
 #ifdef CONFIG_SMP
-	if (smp_num_cpus > 1)
-		errata.smp = smp_num_cpus;
+	/* FIXME: What should this be? -- RR */
+	if (num_online_cpus() > 1)
+		errata.smp = num_online_cpus();
 #endif
 
 	acpi_processor_errata(pr);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/drivers/char/agp/agpgart_be.c linux-2.5.21.24110.updated/drivers/char/agp/agpgart_be.c
--- linux-2.5.21.24110/drivers/char/agp/agpgart_be.c	Mon Jun  3 12:21:23 2002
+++ linux-2.5.21.24110.updated/drivers/char/agp/agpgart_be.c	Tue Jun 11 13:53:32 2002
@@ -98,7 +98,7 @@
 
 static void smp_flush_cache(void)
 {
-	atomic_set(&cpus_waiting, smp_num_cpus - 1);
+	atomic_set(&cpus_waiting, num_online_cpus() - 1);
 	if (smp_call_function(ipi_handler, NULL, 1, 0) != 0)
 		panic(PFX "timed out waiting for the other CPUs!\n");
 	flush_cache();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/drivers/net/aironet4500_core.c linux-2.5.21.24110.updated/drivers/net/aironet4500_core.c
--- linux-2.5.21.24110/drivers/net/aironet4500_core.c	Wed Feb 20 17:57:08 2002
+++ linux-2.5.21.24110.updated/drivers/net/aironet4500_core.c	Tue Jun 11 13:53:32 2002
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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/drivers/video/fbcon.c linux-2.5.21.24110.updated/drivers/video/fbcon.c
--- linux-2.5.21.24110/drivers/video/fbcon.c	Mon Apr 29 16:00:26 2002
+++ linux-2.5.21.24110.updated/drivers/video/fbcon.c	Tue Jun 11 13:53:32 2002
@@ -2177,7 +2177,7 @@
     if (p->fb_info->fbops->fb_rasterimg)
     	p->fb_info->fbops->fb_rasterimg(p->fb_info, 1);
 
-    for (x = 0; x < smp_num_cpus * (LOGO_W + 8) &&
+    for (x = 0; x < num_online_cpus() * (LOGO_W + 8) &&
     	 x < p->var.xres - (LOGO_W + 8); x += (LOGO_W + 8)) {
     	 
 #if defined(CONFIG_FBCON_CFB16) || defined(CONFIG_FBCON_CFB24) || \
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/fs/ntfs/compress.c linux-2.5.21.24110.updated/fs/ntfs/compress.c
--- linux-2.5.21.24110/fs/ntfs/compress.c	Sat May 25 14:34:53 2002
+++ linux-2.5.21.24110.updated/fs/ntfs/compress.c	Tue Jun 11 13:53:32 2002
@@ -69,16 +69,16 @@
 
 	BUG_ON(ntfs_compression_buffers);
 
-	ntfs_compression_buffers =  (u8**)kmalloc(smp_num_cpus * sizeof(u8*),
+	ntfs_compression_buffers =  (u8**)kmalloc(NR_CPUS * sizeof(u8*),
 			GFP_KERNEL);
 	if (!ntfs_compression_buffers)
 		return -ENOMEM;
-	for (i = 0; i < smp_num_cpus; i++) {
+	for (i = 0; i < NR_CPUS; i++) {
 		ntfs_compression_buffers[i] = (u8*)vmalloc(NTFS_MAX_CB_SIZE);
 		if (!ntfs_compression_buffers[i])
 			break;
 	}
-	if (i == smp_num_cpus)
+	if (i == NR_CPUS)
 		return 0;
 	/* Allocation failed, cleanup and return error. */
 	for (j = 0; j < i; j++)
@@ -100,7 +100,7 @@
 
 	BUG_ON(!ntfs_compression_buffers);
 
-	for (i = 0; i < smp_num_cpus; i++)
+	for (i = 0; i < NR_CPUS; i++)
 		vfree(ntfs_compression_buffers[i]);
 	kfree(ntfs_compression_buffers);
 	ntfs_compression_buffers = NULL;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/fs/proc/array.c linux-2.5.21.24110.updated/fs/proc/array.c
--- linux-2.5.21.24110/fs/proc/array.c	Thu May 30 10:00:57 2002
+++ linux-2.5.21.24110.updated/fs/proc/array.c	Tue Jun 11 13:53:32 2002
@@ -695,12 +695,14 @@
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/fs/proc/proc_misc.c linux-2.5.21.24110.updated/fs/proc/proc_misc.c
--- linux-2.5.21.24110/fs/proc/proc_misc.c	Thu May 30 10:00:57 2002
+++ linux-2.5.21.24110.updated/fs/proc/proc_misc.c	Tue Jun 11 13:53:32 2002
@@ -281,29 +281,32 @@
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/include/asm-generic/tlb.h linux-2.5.21.24110.updated/include/asm-generic/tlb.h
--- linux-2.5.21.24110/include/asm-generic/tlb.h	Sat May 25 14:34:56 2002
+++ linux-2.5.21.24110.updated/include/asm-generic/tlb.h	Tue Jun 11 13:53:32 2002
@@ -54,7 +54,7 @@
 	tlb->freed = 0;
 
 	/* Use fast mode if only one CPU is online */
-	tlb->nr = smp_num_cpus > 1 ? 0UL : ~0UL;
+	tlb->nr = num_online_cpus() > 1 ? 0UL : ~0UL;
 	return tlb;
 }
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/include/linux/kernel_stat.h linux-2.5.21.24110.updated/include/linux/kernel_stat.h
--- linux-2.5.21.24110/include/linux/kernel_stat.h	Sat May 18 15:53:43 2002
+++ linux-2.5.21.24110.updated/include/linux/kernel_stat.h	Tue Jun 11 13:53:32 2002
@@ -43,8 +43,8 @@
 {
 	int i, sum=0;
 
-	for (i = 0 ; i < smp_num_cpus ; i++)
-		sum += kstat.irqs[cpu_logical_map(i)][irq];
+	for (i = 0 ; i < NR_CPUS ; i++)
+		sum += kstat.irqs[i][irq];
 
 	return sum;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/include/linux/smp.h linux-2.5.21.24110.updated/include/linux/smp.h
--- linux-2.5.21.24110/include/linux/smp.h	Fri Jun  7 13:59:08 2002
+++ linux-2.5.21.24110.updated/include/linux/smp.h	Tue Jun 11 13:53:32 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/kernel/fork.c linux-2.5.21.24110.updated/kernel/fork.c
--- linux-2.5.21.24110/kernel/fork.c	Mon Jun 10 16:03:56 2002
+++ linux-2.5.21.24110.updated/kernel/fork.c	Tue Jun 11 13:53:32 2002
@@ -692,9 +692,8 @@
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/kernel/sched.c linux-2.5.21.24110.updated/kernel/sched.c
--- linux-2.5.21.24110/kernel/sched.c	Mon Jun 10 16:03:56 2002
+++ linux-2.5.21.24110.updated/kernel/sched.c	Tue Jun 11 13:53:32 2002
@@ -434,8 +434,8 @@
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(cpu_logical_map(i))->nr_running;
+	for (i = 0; i < NR_CPUS; i++)
+		sum += cpu_rq(i)->nr_running;
 
 	return sum;
 }
@@ -444,8 +444,8 @@
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(cpu_logical_map(i))->nr_uninterruptible;
+	for (i = 0; i < NR_CPUS; i++)
+		sum += cpu_rq(i)->nr_uninterruptible;
 
 	return sum;
 }
@@ -454,8 +454,8 @@
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(cpu_logical_map(i))->nr_switches;
+	for (i = 0; i < NR_CPUS; i++)
+		sum += cpu_rq(i)->nr_switches;
 
 	return sum;
 }
@@ -530,15 +530,16 @@
 
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
@@ -1701,7 +1702,7 @@
 
 static int migration_thread(void * bind_cpu)
 {
-	int cpu = cpu_logical_map((int) (long) bind_cpu);
+	int cpu = (int) (long) bind_cpu;
 	struct sched_param param = { sched_priority: MAX_RT_PRIO-1 };
 	runqueue_t *rq;
 	int ret;
@@ -1709,12 +1710,15 @@
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
@@ -1778,16 +1782,21 @@
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
-		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu))
+			continue;
+		while (!cpu_rq(cpu)->migration_thread)
 			schedule_timeout(2);
+	}
 }
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/kernel/softirq.c linux-2.5.21.24110.updated/kernel/softirq.c
--- linux-2.5.21.24110/kernel/softirq.c	Mon Jun  3 12:21:28 2002
+++ linux-2.5.21.24110.updated/kernel/softirq.c	Tue Jun 11 13:53:32 2002
@@ -363,8 +363,7 @@
 
 static int ksoftirqd(void * __bind_cpu)
 {
-	int bind_cpu = (int) (long) __bind_cpu;
-	int cpu = cpu_logical_map(bind_cpu);
+	int cpu = (int) (long) __bind_cpu;
 
 	daemonize();
 	set_user_nice(current, 19);
@@ -376,7 +375,7 @@
 	if (smp_processor_id() != cpu)
 		BUG();
 
-	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
+	sprintf(current->comm, "ksoftirqd_CPU%d", cpu);
 
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
@@ -402,13 +401,16 @@
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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/kernel/suspend.c linux-2.5.21.24110.updated/kernel/suspend.c
--- linux-2.5.21.24110/kernel/suspend.c	Mon Jun 10 16:03:56 2002
+++ linux-2.5.21.24110.updated/kernel/suspend.c	Tue Jun 11 13:53:32 2002
@@ -282,7 +282,8 @@
 	sh->num_physpages = num_physpages;
 	strncpy(sh->machine, system_utsname.machine, 8);
 	strncpy(sh->version, system_utsname.version, 20);
-	sh->num_cpus = smp_num_cpus;
+	/* FIXME: Is this bogus? --RR */
+	sh->num_cpus = num_online_cpus();
 	sh->page_size = PAGE_SIZE;
 	sh->suspend_pagedir = pagedir_nosave;
 	if (pagedir_save != pagedir_nosave)
@@ -1013,7 +1014,7 @@
 		return sanity_check_failed("Incorrect machine type");
 	if(strncmp(sh->version, system_utsname.version, 20))
 		return sanity_check_failed("Incorrect version");
-	if(sh->num_cpus != smp_num_cpus)
+	if(sh->num_cpus != num_online_cpus())
 		return sanity_check_failed("Incorrect number of cpus");
 	if(sh->page_size != PAGE_SIZE)
 		return sanity_check_failed("Incorrect PAGE_SIZE");
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/lib/brlock.c linux-2.5.21.24110.updated/lib/brlock.c
--- linux-2.5.21.24110/lib/brlock.c	Sat Nov 10 09:11:15 2001
+++ linux-2.5.21.24110.updated/lib/brlock.c	Tue Jun 11 13:53:32 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/mm/page_alloc.c linux-2.5.21.24110.updated/mm/page_alloc.c
--- linux-2.5.21.24110/mm/page_alloc.c	Mon Jun 10 16:03:56 2002
+++ linux-2.5.21.24110.updated/mm/page_alloc.c	Tue Jun 11 13:53:32 2002
@@ -574,10 +574,13 @@
 	int pcpu;
 
 	memset(ret, 0, sizeof(*ret));
-	for (pcpu = 0; pcpu < smp_num_cpus; pcpu++) {
+	for (pcpu = 0; pcpu < NR_CPUS; pcpu++) {
 		struct page_state *ps;
 
-		ps = &page_states[cpu_logical_map(pcpu)];
+		if (!cpu_online(pcpu))
+			continue;
+
+		ps = &page_states[pcpu];
 		ret->nr_dirty += ps->nr_dirty;
 		ret->nr_writeback += ps->nr_writeback;
 		ret->nr_pagecache += ps->nr_pagecache;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/mm/slab.c linux-2.5.21.24110.updated/mm/slab.c
--- linux-2.5.21.24110/mm/slab.c	Mon May 13 12:00:40 2002
+++ linux-2.5.21.24110.updated/mm/slab.c	Tue Jun 11 13:53:32 2002
@@ -941,8 +941,8 @@
 	down(&cache_chain_sem);
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
 
-	for (i = 0; i < smp_num_cpus; i++) {
-		cpucache_t* ccold = new.new[cpu_logical_map(i)];
+	for (i = 0; i < NR_CPUS; i++) {
+		cpucache_t* ccold = new.new[i];
 		if (!ccold || (ccold->avail == 0))
 			continue;
 		local_irq_disable();
@@ -1675,16 +1675,18 @@
 
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
@@ -1694,8 +1696,8 @@
 
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
 
-	for (i = 0; i < smp_num_cpus; i++) {
-		cpucache_t* ccold = new.new[cpu_logical_map(i)];
+	for (i = 0; i < NR_CPUS; i++) {
+		cpucache_t* ccold = new.new[i];
 		if (!ccold)
 			continue;
 		local_irq_disable();
@@ -1704,10 +1706,6 @@
 		kfree(ccold);
 	}
 	return 0;
-oom:
-	for (i--; i >= 0; i--)
-		kfree(new.new[cpu_logical_map(i)]);
-	return -ENOMEM;
 }
 
 static void enable_cpucache (kmem_cache_t *cachep)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/core/dev.c linux-2.5.21.24110.updated/net/core/dev.c
--- linux-2.5.21.24110/net/core/dev.c	Mon Jun 10 16:03:56 2002
+++ linux-2.5.21.24110.updated/net/core/dev.c	Tue Jun 11 13:54:41 2002
@@ -1817,11 +1817,13 @@
 static int dev_proc_stats(char *buffer, char **start, off_t offset,
 			  int length, int *eof, void *data)
 {
-	int i, lcpu;
+	int i;
 	int len = 0;
 
-	for (lcpu = 0; lcpu < smp_num_cpus; lcpu++) {
-		i = cpu_logical_map(lcpu);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+
 		len += sprintf(buffer + len, "%08x %08x %08x %08x %08x %08x "
 					     "%08x %08x %08x\n",
 			       netdev_rx_stat[i].total,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/ipv4/netfilter/arp_tables.c linux-2.5.21.24110.updated/net/ipv4/netfilter/arp_tables.c
--- linux-2.5.21.24110/net/ipv4/netfilter/arp_tables.c	Thu Mar 21 14:14:57 2002
+++ linux-2.5.21.24110.updated/net/ipv4/netfilter/arp_tables.c	Tue Jun 11 13:53:32 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/ipv4/netfilter/ip_tables.c linux-2.5.21.24110.updated/net/ipv4/netfilter/ip_tables.c
--- linux-2.5.21.24110/net/ipv4/netfilter/ip_tables.c	Wed Feb 20 17:56:17 2002
+++ linux-2.5.21.24110.updated/net/ipv4/netfilter/ip_tables.c	Tue Jun 11 13:53:32 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/ipv4/netfilter/ipchains_core.c linux-2.5.21.24110.updated/net/ipv4/netfilter/ipchains_core.c
--- linux-2.5.21.24110/net/ipv4/netfilter/ipchains_core.c	Mon Jun 10 16:03:56 2002
+++ linux-2.5.21.24110.updated/net/ipv4/netfilter/ipchains_core.c	Tue Jun 11 13:53:32 2002
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
@@ -1122,7 +1122,7 @@
 	label->chain = NULL;
 	label->refcount = ref;
 	label->policy = policy;
-	for (i = 0; i < smp_num_cpus*2; i++) {
+	for (i = 0; i < NUM_SLOTS; i++) {
 		label->reent[i].counters.pcnt = label->reent[i].counters.bcnt
 			= 0;
 		label->reent[i].prevchain = NULL;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/ipv4/proc.c linux-2.5.21.24110.updated/net/ipv4/proc.c
--- linux-2.5.21.24110/net/ipv4/proc.c	Thu May 17 03:21:45 2001
+++ linux-2.5.21.24110.updated/net/ipv4/proc.c	Tue Jun 11 13:53:32 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/ipv4/route.c linux-2.5.21.24110.updated/net/ipv4/route.c
--- linux-2.5.21.24110/net/ipv4/route.c	Mon May 13 12:00:40 2002
+++ linux-2.5.21.24110.updated/net/ipv4/route.c	Tue Jun 11 13:53:32 2002
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
+	for (i = 0; i < NR_CPUS; i++) {
 		len += sprintf(buffer+len, "%08x  %08x %08x %08x %08x %08x %08x %08x  %08x %08x %08x %08x %08x %08x %08x \n",
 			       dst_entries,		       
 			       rt_cache_stat[i].in_hit,
@@ -2437,19 +2435,16 @@
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/ipv6/netfilter/ip6_tables.c linux-2.5.21.24110.updated/net/ipv6/netfilter/ip6_tables.c
--- linux-2.5.21.24110/net/ipv6/netfilter/ip6_tables.c	Mon May  6 11:12:01 2002
+++ linux-2.5.21.24110.updated/net/ipv6/netfilter/ip6_tables.c	Tue Jun 11 13:53:32 2002
@@ -336,8 +336,7 @@
 	read_lock_bh(&table->lock);
 	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
 	table_base = (void *)table->private->entries
-		+ TABLE_OFFSET(table->private, 
-				cpu_number_map(smp_processor_id()));
+		+ TABLE_OFFSET(table->private, smp_processor_id());
 	e = get_entry(table_base, table->private->hook_entry[hook]);
 
 #ifdef CONFIG_NETFILTER_DEBUG
@@ -913,7 +912,7 @@
 	}
 
 	/* And one copy for every other CPU */
-	for (i = 1; i < smp_num_cpus; i++) {
+	for (i = 1; i < NR_CPUS; i++) {
 		memcpy(newinfo->entries + SMP_ALIGN(newinfo->size)*i,
 		       newinfo->entries,
 		       SMP_ALIGN(newinfo->size));
@@ -935,7 +934,7 @@
 		struct ip6t_entry *table_base;
 		unsigned int i;
 
-		for (i = 0; i < smp_num_cpus; i++) {
+		for (i = 0; i < NR_CPUS; i++) {
 			table_base =
 				(void *)newinfo->entries
 				+ TABLE_OFFSET(newinfo, i);
@@ -982,7 +981,7 @@
 	unsigned int cpu;
 	unsigned int i;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		i = 0;
 		IP6T_ENTRY_ITERATE(t->entries + TABLE_OFFSET(t, cpu),
 				  t->size,
@@ -1116,7 +1115,7 @@
 		return -ENOMEM;
 
 	newinfo = vmalloc(sizeof(struct ip6t_table_info)
-			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
+			  + SMP_ALIGN(tmp.size) * NR_CPUS);
 	if (!newinfo)
 		return -ENOMEM;
 
@@ -1429,7 +1428,7 @@
 
 	MOD_INC_USE_COUNT;
 	newinfo = vmalloc(sizeof(struct ip6t_table_info)
-			  + SMP_ALIGN(table->table->size) * smp_num_cpus);
+			  + SMP_ALIGN(table->table->size) * NR_CPUS);
 	if (!newinfo) {
 		ret = -ENOMEM;
 		MOD_DEC_USE_COUNT;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/ipv6/proc.c linux-2.5.21.24110.updated/net/ipv6/proc.c
--- linux-2.5.21.24110/net/ipv6/proc.c	Wed Feb 20 17:57:22 2002
+++ linux-2.5.21.24110.updated/net/ipv6/proc.c	Tue Jun 11 13:53:32 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.24110/net/socket.c linux-2.5.21.24110.updated/net/socket.c
--- linux-2.5.21.24110/net/socket.c	Thu Mar 21 14:14:57 2002
+++ linux-2.5.21.24110.updated/net/socket.c	Tue Jun 11 13:53:32 2002
@@ -1773,8 +1773,8 @@
 	int len, cpu;
 	int counter = 0;
 
-	for (cpu=0; cpu<smp_num_cpus; cpu++)
-		counter += sockets_in_use[cpu_logical_map(cpu)].counter;
+	for (cpu=0; cpu<NR_CPUS; cpu++)
+		counter += sockets_in_use[cpu].counter;
 
 	/* It can be negative, by the way. 8) */
 	if (counter < 0)
