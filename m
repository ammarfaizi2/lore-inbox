Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUEFStw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUEFStw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUEFStw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:49:52 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:26188 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261867AbUEFSs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:48:57 -0400
Date: Thu, 6 May 2004 11:48:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 2/15] pj-fix-2-ashoks-updated-cpuhotplug-6-7
Message-Id: <20040506114808.65617fe1.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: cpu_present_map.patch
Author: Ashok Raj (Intel Corporation)
D: This patch adds cpu_present_map, cpu_present() and for_each_cpu_present()
D: to distinguish between possible cpu's in a system and cpu's physically
D: present in a system. Before cpu hotplug was introduced cpu_possible()
D: represented cpu's physically present in the system. With hotplug capable
D: Kernel, there is a requirement to distinguish a cpu as possible verses a 
D: CPU physically present in the system. This is required so thta when
D: smp_init() attempts to start all cpu's it should now only attempt
D: to start cpu's present in the system. When a hotplug cpu is
D: physically inserted cpu_present_map will have bits updated
D: dynamically.


Index: 2.6.6-rc3-mm2-bitmapv5/arch/ia64/kernel/smpboot.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/ia64/kernel/smpboot.c	2004-05-06 03:57:36.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/ia64/kernel/smpboot.c	2004-05-06 04:22:43.000000000 -0700
@@ -75,11 +75,11 @@
 
 task_t *task_for_booting_cpu;
 
-/* Bitmask of currently online CPUs */
+/* Bitmasks of currently online, and possible CPUs */
 cpumask_t cpu_online_map;
 EXPORT_SYMBOL(cpu_online_map);
-cpumask_t phys_cpu_present_map;
-EXPORT_SYMBOL(phys_cpu_present_map);
+cpumask_t cpu_possible_map;
+EXPORT_SYMBOL(cpu_possible_map);
 
 /* which logical CPU number maps to which CPU (physical APIC ID) */
 volatile int ia64_cpu_to_sapicid[NR_CPUS];
@@ -99,6 +99,7 @@
 nointroute (char *str)
 {
 	no_int_routing = 1;
+	printk ("no_int_routing on\n");
 	return 1;
 }
 
@@ -441,14 +442,15 @@
 		ia64_cpu_to_sapicid[cpu] = -1;
 
 	ia64_cpu_to_sapicid[0] = boot_cpu_id;
-	cpus_clear(phys_cpu_present_map);
-	cpu_set(0, phys_cpu_present_map);
-
+	cpus_clear(cpu_present_map);
+	cpu_set(0, cpu_present_map);
+	cpu_set(0, cpu_possible_map);
 	for (cpu = 1, i = 0; i < smp_boot_data.cpu_count; i++) {
 		sapicid = smp_boot_data.cpu_phys_id[i];
 		if (sapicid == boot_cpu_id)
 			continue;
-		cpu_set(cpu, phys_cpu_present_map);
+		cpu_set(cpu, cpu_present_map);
+		cpu_set(cpu, cpu_possible_map);
 		ia64_cpu_to_sapicid[cpu] = sapicid;
 		cpu++;
 	}
@@ -529,9 +531,11 @@
 	if (!max_cpus) {
 		printk(KERN_INFO "SMP mode deactivated.\n");
 		cpus_clear(cpu_online_map);
-		cpus_clear(phys_cpu_present_map);
+		cpus_clear(cpu_present_map);
+		cpus_clear(cpu_possible_map);
 		cpu_set(0, cpu_online_map);
-		cpu_set(0, phys_cpu_present_map);
+		cpu_set(0, cpu_present_map);
+		cpu_set(0, cpu_possible_map);
 		return;
 	}
 }
Index: 2.6.6-rc3-mm2-bitmapv5/include/linux/cpumask.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/linux/cpumask.h	2004-05-06 03:50:12.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/linux/cpumask.h	2004-05-06 04:22:43.000000000 -0700
@@ -10,11 +10,15 @@
 
 extern cpumask_t cpu_online_map;
 extern cpumask_t cpu_possible_map;
+extern cpumask_t cpu_present_map;
 
 #define num_online_cpus()		cpus_weight(cpu_online_map)
 #define num_possible_cpus()		cpus_weight(cpu_possible_map)
+#define num_present_cpus()		cpus_weight(cpu_present_map)
+
 #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
 #define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
+#define cpu_present(cpu)		cpu_isset(cpu, cpu_present_map)
 
 #define for_each_cpu_mask(cpu, mask)					\
 	for (cpu = first_cpu_const(mk_cpumask_const(mask));		\
@@ -23,16 +27,23 @@
 
 #define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
 #define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
+#define for_each_present_cpu(cpu) for_each_cpu_mask(cpu, cpu_present_map)
 #else
 #define	cpu_online_map			cpumask_of_cpu(0)
 #define	cpu_possible_map		cpumask_of_cpu(0)
+#define	cpu_present_map			cpumask_of_cpu(0)
+
 #define num_online_cpus()		1
 #define num_possible_cpus()		1
+#define num_present_cpus()		1
+
 #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
+#define cpu_present(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
 #define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#define for_each_present_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #endif
 
 #define cpumask_scnprintf(buf, buflen, map)				\
Index: 2.6.6-rc3-mm2-bitmapv5/init/main.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/init/main.c	2004-05-06 04:22:41.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/init/main.c	2004-05-06 04:22:43.000000000 -0700
@@ -360,10 +360,10 @@
 	unsigned j = 1;
 
 	/* FIXME: This should be done in userspace --RR */
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_present_cpu(i) {
 		if (num_online_cpus() >= max_cpus)
 			break;
-		if (cpu_possible(i) && !cpu_online(i)) {
+		if (!cpu_online(i)) {
 			cpu_up(i);
 			j++;
 		}
@@ -620,6 +620,22 @@
 	execve(init_filename, argv_init, envp_init);
 }
 
+static void fixup_cpu_present_map(void)
+{
+	int i;
+
+	/*
+	 * If arch is not hotplug ready and did not populate
+	 * cpu_present_map, just make cpu_present_map same as cpu_possible_map
+	 * for other cpu bringup code to function as normal. e.g smp_init() etc.
+	 */
+	if (cpus_empty(cpu_present_map)) {
+		for_each_cpu(i) {
+			cpu_set(i, cpu_present_map);
+		}
+	}
+}
+
 static int init(void * unused)
 {
 	lock_kernel();
@@ -638,6 +654,7 @@
 
 	do_pre_smp_initcalls();
 
+	fixup_cpu_present_map();
 	smp_init();
 	sched_init_smp();
 	do_basic_setup();
Index: 2.6.6-rc3-mm2-bitmapv5/kernel/cpu.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/kernel/cpu.c	2004-05-06 03:57:16.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/kernel/cpu.c	2004-05-06 04:22:43.000000000 -0700
@@ -20,6 +20,14 @@
 DECLARE_MUTEX(cpucontrol);
 
 static struct notifier_block *cpu_chain;
+/*
+ * Represents all cpu's present in the system
+ * In systems capable of hotplug, this map could dynamically grow
+ * as new cpu's are detected in the system via any platform specific
+ * method, such as ACPI for e.g.
+ */
+cpumask_t	cpu_present_map;
+EXPORT_SYMBOL(cpu_present_map);
 
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
@@ -180,7 +188,7 @@
 	if ((ret = down_interruptible(&cpucontrol)) != 0)
 		return ret;
 
-	if (cpu_online(cpu)) {
+	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
 	}
Index: 2.6.6-rc3-mm2-bitmapv5/fs/proc/proc_misc.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/fs/proc/proc_misc.c	2004-05-06 03:57:24.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/fs/proc/proc_misc.c	2004-05-06 04:22:43.000000000 -0700
@@ -371,7 +371,7 @@
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
 
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		int j;
 
 		user += kstat_cpu(i).cpustat.user;
@@ -393,7 +393,7 @@
 		(unsigned long long)jiffies_64_to_clock_t(iowait),
 		(unsigned long long)jiffies_64_to_clock_t(irq),
 		(unsigned long long)jiffies_64_to_clock_t(softirq));
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user = kstat_cpu(i).cpustat.user;
Index: 2.6.6-rc3-mm2-bitmapv5/kernel/sched.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/kernel/sched.c	2004-05-06 04:00:27.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/kernel/sched.c	2004-05-06 04:22:43.000000000 -0700
@@ -1219,7 +1219,7 @@
 {
 	unsigned long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_uninterruptible;
 
 	return sum;
@@ -1229,7 +1229,7 @@
 {
 	unsigned long long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_switches;
 
 	return sum;
@@ -1239,7 +1239,7 @@
 {
 	unsigned long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		sum += atomic_read(&cpu_rq(i)->nr_iowait);
 
 	return sum;
Index: 2.6.6-rc3-mm2-bitmapv5/fs/buffer.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/fs/buffer.c	2004-05-06 04:00:27.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/fs/buffer.c	2004-05-06 04:22:43.000000000 -0700
@@ -2989,7 +2989,7 @@
 	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
 		return;
 	__get_cpu_var(bh_accounting).ratelimit = 0;
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		tot += per_cpu(bh_accounting, i).nr;
 	buffer_heads_over_limit = (tot > max_buffer_heads);
 }
Index: 2.6.6-rc3-mm2-bitmapv5/kernel/fork.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/kernel/fork.c	2004-05-06 03:57:16.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/kernel/fork.c	2004-05-06 04:22:43.000000000 -0700
@@ -63,7 +63,7 @@
 	int cpu;
 	int total = 0;
 
-	for_each_cpu(cpu)
+	for_each_online_cpu(cpu)
 		total += per_cpu(process_counts, cpu);
 
 	return total;
Index: 2.6.6-rc3-mm2-bitmapv5/kernel/timer.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/kernel/timer.c	2004-05-06 03:50:20.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/kernel/timer.c	2004-05-06 04:22:43.000000000 -0700
@@ -332,7 +332,7 @@
 del_again:
 	ret += del_timer(timer);
 
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		base = &per_cpu(tvec_bases, i);
 		if (base->running_timer == timer) {
 			while (base->running_timer == timer) {
Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-ia64/smp.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-ia64/smp.h	2004-05-06 03:57:36.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-ia64/smp.h	2004-05-06 04:22:43.000000000 -0700
@@ -38,7 +38,6 @@
 
 extern char no_int_routing __devinitdata;
 
-extern cpumask_t phys_cpu_present_map;
 extern cpumask_t cpu_online_map;
 extern unsigned long ipi_base_addr;
 extern unsigned char smp_int_redirect;
@@ -48,8 +47,6 @@
 
 extern unsigned long ap_wakeup_vector;
 
-#define cpu_possible_map phys_cpu_present_map
-
 /*
  * Function to map hard smp processor id to logical id.  Slow, so don't use this in
  * performance-critical code.


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
