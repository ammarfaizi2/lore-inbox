Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264790AbUEERsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264790AbUEERsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUEERsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:48:40 -0400
Received: from fmr04.intel.com ([143.183.121.6]:46811 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264790AbUEERsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:48:04 -0400
Date: Wed, 5 May 2004 10:47:40 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
       pj@sgi.com
Subject: Re: (resend-2) take3: Updated CPU Hotplug patches for IA64 (pj blessed) Patch [6/7]
Message-ID: <20040505104739.A24549@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com> <20040504225907.6c2fe459.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040504225907.6c2fe459.akpm@osdl.org>; from akpm@osdl.org on Tue, May 04, 2004 at 10:59:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 10:59:07PM -0700, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> >  Name: cpu_present_map.patch
> 
> This does not play happily with the sched_domains patches.
> 
> I'll drop this final patch.  Please reissue it against next -mm.  Thanks.

Ooopsy Daisy...

apparently i picked up the patches from a different directory. This was the exact problem
i fixed with the (supposed resend patch)... this one should work with sched domain, and 
i also tested with that on i386 MP as well.

below is patch 6 resend-2

cheers,
ashok


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


---

 linux-2.6.6-rc3-root/arch/ia64/kernel/smpboot.c |   22 +++++++++++++---------
 linux-2.6.6-rc3-root/fs/buffer.c                |    2 +-
 linux-2.6.6-rc3-root/fs/proc/proc_misc.c        |    4 ++--
 linux-2.6.6-rc3-root/include/asm-ia64/smp.h     |    3 ---
 linux-2.6.6-rc3-root/include/linux/cpumask.h    |   11 +++++++++++
 linux-2.6.6-rc3-root/init/main.c                |   21 +++++++++++++++++++--
 linux-2.6.6-rc3-root/kernel/cpu.c               |   10 +++++++++-
 linux-2.6.6-rc3-root/kernel/fork.c              |    2 +-
 linux-2.6.6-rc3-root/kernel/sched.c             |    6 +++---
 linux-2.6.6-rc3-root/kernel/timer.c             |    2 +-
 10 files changed, 60 insertions(+), 23 deletions(-)

diff -puN arch/ia64/kernel/smpboot.c~cpu_present arch/ia64/kernel/smpboot.c
--- linux-2.6.6-rc3/arch/ia64/kernel/smpboot.c~cpu_present	2004-05-04 13:33:45.000000000 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/smpboot.c	2004-05-04 20:46:48.966085414 -0700
@@ -75,11 +75,11 @@ extern unsigned long ia64_iobase;
 
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
@@ -99,6 +99,7 @@ static int __init
 nointroute (char *str)
 {
 	no_int_routing = 1;
+	printk ("no_int_routing on\n");
 	return 1;
 }
 
@@ -441,14 +442,15 @@ smp_build_cpu_map (void)
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
@@ -529,9 +531,11 @@ smp_prepare_cpus (unsigned int max_cpus)
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
diff -puN include/linux/cpumask.h~cpu_present include/linux/cpumask.h
--- linux-2.6.6-rc3/include/linux/cpumask.h~cpu_present	2004-05-04 13:33:45.000000000 -0700
+++ linux-2.6.6-rc3-root/include/linux/cpumask.h	2004-05-04 13:33:45.000000000 -0700
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
@@ -23,16 +27,23 @@ extern cpumask_t cpu_possible_map;
 
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
diff -puN init/main.c~cpu_present init/main.c
--- linux-2.6.6-rc3/init/main.c~cpu_present	2004-05-04 13:33:45.000000000 -0700
+++ linux-2.6.6-rc3-root/init/main.c	2004-05-04 20:51:33.582442075 -0700
@@ -354,10 +354,10 @@ static void __init smp_init(void)
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
@@ -577,6 +577,22 @@ static void run_init_process(char *init_
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
@@ -595,6 +611,7 @@ static int init(void * unused)
 
 	do_pre_smp_initcalls();
 
+	fixup_cpu_present_map();
 	smp_init();
 	do_basic_setup();
 
diff -puN kernel/cpu.c~cpu_present kernel/cpu.c
--- linux-2.6.6-rc3/kernel/cpu.c~cpu_present	2004-05-04 13:33:45.000000000 -0700
+++ linux-2.6.6-rc3-root/kernel/cpu.c	2004-05-04 13:33:45.000000000 -0700
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
@@ -169,7 +177,7 @@ int __devinit cpu_up(unsigned int cpu)
 	if ((ret = down_interruptible(&cpucontrol)) != 0)
 		return ret;
 
-	if (cpu_online(cpu)) {
+	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
 	}
diff -puN fs/proc/proc_misc.c~cpu_present fs/proc/proc_misc.c
--- linux-2.6.6-rc3/fs/proc/proc_misc.c~cpu_present	2004-05-04 13:33:45.000000000 -0700
+++ linux-2.6.6-rc3-root/fs/proc/proc_misc.c	2004-05-04 13:33:45.000000000 -0700
@@ -368,7 +368,7 @@ int show_stat(struct seq_file *p, void *
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
 
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		int j;
 
 		user += kstat_cpu(i).cpustat.user;
@@ -390,7 +390,7 @@ int show_stat(struct seq_file *p, void *
 		(unsigned long long)jiffies_64_to_clock_t(iowait),
 		(unsigned long long)jiffies_64_to_clock_t(irq),
 		(unsigned long long)jiffies_64_to_clock_t(softirq));
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user = kstat_cpu(i).cpustat.user;
diff -puN kernel/sched.c~cpu_present kernel/sched.c
--- linux-2.6.6-rc3/kernel/sched.c~cpu_present	2004-05-04 13:33:45.000000000 -0700
+++ linux-2.6.6-rc3-root/kernel/sched.c	2004-05-04 20:49:19.431982765 -0700
@@ -945,7 +945,7 @@ unsigned long nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_uninterruptible;
 
 	return sum;
@@ -955,7 +955,7 @@ unsigned long long nr_context_switches(v
 {
 	unsigned long long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_switches;
 
 	return sum;
@@ -965,7 +965,7 @@ unsigned long nr_iowait(void)
 {
 	unsigned long i, sum = 0;
 
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		sum += atomic_read(&cpu_rq(i)->nr_iowait);
 
 	return sum;
diff -puN fs/buffer.c~cpu_present fs/buffer.c
--- linux-2.6.6-rc3/fs/buffer.c~cpu_present	2004-05-04 13:38:00.000000000 -0700
+++ linux-2.6.6-rc3-root/fs/buffer.c	2004-05-04 13:39:05.000000000 -0700
@@ -2966,7 +2966,7 @@ static void recalc_bh_state(void)
 	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
 		return;
 	__get_cpu_var(bh_accounting).ratelimit = 0;
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		tot += per_cpu(bh_accounting, i).nr;
 	buffer_heads_over_limit = (tot > max_buffer_heads);
 }
diff -puN kernel/fork.c~cpu_present kernel/fork.c
--- linux-2.6.6-rc3/kernel/fork.c~cpu_present	2004-05-04 13:40:01.000000000 -0700
+++ linux-2.6.6-rc3-root/kernel/fork.c	2004-05-04 13:40:11.000000000 -0700
@@ -60,7 +60,7 @@ int nr_processes(void)
 	int cpu;
 	int total = 0;
 
-	for_each_cpu(cpu)
+	for_each_online_cpu(cpu)
 		total += per_cpu(process_counts, cpu);
 
 	return total;
diff -puN kernel/timer.c~cpu_present kernel/timer.c
--- linux-2.6.6-rc3/kernel/timer.c~cpu_present	2004-05-04 13:42:55.000000000 -0700
+++ linux-2.6.6-rc3-root/kernel/timer.c	2004-05-04 13:43:09.000000000 -0700
@@ -332,7 +332,7 @@ int del_timer_sync(struct timer_list *ti
 del_again:
 	ret += del_timer(timer);
 
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		base = &per_cpu(tvec_bases, i);
 		if (base->running_timer == timer) {
 			while (base->running_timer == timer) {
diff -puN include/asm-ia64/smp.h~cpu_present include/asm-ia64/smp.h
--- linux-2.6.6-rc3/include/asm-ia64/smp.h~cpu_present	2004-05-04 15:01:31.000000000 -0700
+++ linux-2.6.6-rc3-root/include/asm-ia64/smp.h	2004-05-04 20:46:48.967061977 -0700
@@ -38,7 +38,6 @@ extern struct smp_boot_data {
 
 extern char no_int_routing __devinitdata;
 
-extern cpumask_t phys_cpu_present_map;
 extern cpumask_t cpu_online_map;
 extern unsigned long ipi_base_addr;
 extern unsigned char smp_int_redirect;
@@ -48,8 +47,6 @@ extern volatile int ia64_cpu_to_sapicid[
 
 extern unsigned long ap_wakeup_vector;
 
-#define cpu_possible_map phys_cpu_present_map
-
 /*
  * Function to map hard smp processor id to logical id.  Slow, so don't use this in
  * performance-critical code.

_
