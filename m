Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUECCPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUECCPx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbUECCPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:15:53 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:21482 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263460AbUECCPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:15:44 -0400
Date: Sun, 2 May 2004 19:18:28 -0700
From: Paul Jackson <pj@sgi.com>
To: ashok.raj@intel.com
Cc: rusty@rustcorp.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Revisited: ia64-cpu-hotplug-cpu_present.patch
Message-Id: <20040502191828.7d22e599.pj@sgi.com>
In-Reply-To: <20040428023238.76244ed2.pj@sgi.com>
References: <20040428023238.76244ed2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it's time to become visible again on the kernel mailing list
with this thread - instead of just conversing privately with Ashok on
this.

  ==> This is not ready for prime time yet, Andrew.

      It still has one issue, still needs review by Ashok,
      and has not been tested except to build and boot
      one ia64 system.

      Ashok ... review required.
      Rusty, Andrew, anyone else ... review welcome.

On April 25, Andrew included several cpu-hotplug patches from
Ashok Raj in his 2.6.6-rc2-mm2 patch set, including one named
ia64-cpu-hotplug-cpu_present.patch

On April 28, I posted Ashok's patch to lkml, with some concerns,
under the subject:

  Concerns with ia64-cpu-hotplug-cpu_present.patch

My concerns were roughly:

    It didn't build for ia64 sn2_defconfig, it added another ARCH_specific
    conditional compilation flag, it added more ifdef'd code, and it had
    various cpu_present_map, phys_cpu_present_map, cpu_possible_map
    variables, which were sometimes aliased to be the same thing, and
    sometimes distinct.  And, the item that first caught my eye, it added
    a critical #ifdef to the file asm-ia64/cpumask.h, which file I want
    to remove in my pending bitmap/cpumask cleanup patch set.

Here is an alternative proposal for this patch.  It cleans up the
ifdef's and makes the present/possible names more consistent.  And
it builds and boots ia64 sn2_defconfig.  And it doesn't add anything
to the (soon to be nuked I hope) asm-ia64/cpumask.h file.

The build/boot testing was done using 2.6.6-rc2-mm2, with this one
ia64-cpu-hotplug-cpu_present.patch replaced, and a couple other
unrelated fixes that are needed to build/boot this patch set on
sn2, which have been persued on other lkml threads.

The one known issue, as I described to Ashok a couple days ago:

> I had to hack the setting of cpu_possible_map to _not_ set all
> NR_CPUS bits, but only set the same bits as initially are set
> in cpus_present_map.  If I didn't do that, then the boot hung
> earlier, after displaying:
> 
>   Total of 4 processors activated (4983.96 BogoMIPS).
> 
> before displaying:
> 
>   Starting migration thread for cpu 0

I have not had time yet to investigate this issue further.
Perhaps Ashok will have some input here.

Beware that I am not sufficiently clueful of this hot plug patch
set to really be composing such a patch.  Ashok and/or others
will have to examine it carefully to see that it actually does
anything such as might be desired.  My feedback is more on code
quality - it was easier to teach by example than it was to do so
by berating further on the items of my concerns.

=========== ia64-cpu-hotplug-cpu_present.patch, v2 ===========

With a hotplug capable kernel, there is a requirement to distinguish a
possible CPU from one actually present.  The set of possible CPU numbers
doesn't change during a single system boot, but the set of present CPUs
changes as CPUs are physically inserted into or removed from a system.
The cpu_possible_map does not change once initialized at boot, but the
cpu_present_map changes dynamically as CPUs are inserted or removed.


Index: 2.6.6-rc2-cpu_present/arch/ia64/kernel/smpboot.c
===================================================================
--- 2.6.6-rc2-cpu_present.orig/arch/ia64/kernel/smpboot.c	2004-04-30 00:45:13.000000000 -0700
+++ 2.6.6-rc2-cpu_present/arch/ia64/kernel/smpboot.c	2004-05-02 16:24:28.000000000 -0700
@@ -84,11 +84,12 @@
  */
 DEFINE_PER_CPU(int, cpu_state) = { 0 };
 
-/* Bitmask of currently online CPUs */
+/* Bitmasks of currently online, present and possible CPUs */
 cpumask_t cpu_online_map;
 EXPORT_SYMBOL(cpu_online_map);
-cpumask_t phys_cpu_present_map;
-EXPORT_SYMBOL(phys_cpu_present_map);
+extern cpumask_t cpu_present_map;
+cpumask_t cpu_possible_map = CPU_MASK_NONE;
+EXPORT_SYMBOL(cpu_possible_map);
 
 /* which logical CPU number maps to which CPU (physical APIC ID) */
 volatile int ia64_cpu_to_sapicid[NR_CPUS];
@@ -476,14 +477,16 @@
 		ia64_cpu_to_sapicid[cpu] = -1;
 
 	ia64_cpu_to_sapicid[0] = boot_cpu_id;
-	cpus_clear(phys_cpu_present_map);
-	cpu_set(0, phys_cpu_present_map);
+	cpus_clear(cpu_present_map);
+	cpu_set(0, cpu_possible_map);
+	cpu_set(0, cpu_present_map);
 
 	for (cpu = 1, i = 0; i < smp_boot_data.cpu_count; i++) {
 		sapicid = smp_boot_data.cpu_phys_id[i];
 		if (sapicid == boot_cpu_id)
 			continue;
-		cpu_set(cpu, phys_cpu_present_map);
+		cpu_set(cpu, cpu_possible_map);
+		cpu_set(cpu, cpu_present_map);
 		ia64_cpu_to_sapicid[cpu] = sapicid;
 		cpu++;
 	}
@@ -564,9 +567,9 @@
 	if (!max_cpus) {
 		printk(KERN_INFO "SMP mode deactivated.\n");
 		cpus_clear(cpu_online_map);
-		cpus_clear(phys_cpu_present_map);
+		cpus_clear(cpu_present_map);
 		cpu_set(0, cpu_online_map);
-		cpu_set(0, phys_cpu_present_map);
+		cpu_set(0, cpu_present_map);
 		return;
 	}
 }
Index: 2.6.6-rc2-cpu_present/fs/proc/proc_misc.c
===================================================================
--- 2.6.6-rc2-cpu_present.orig/fs/proc/proc_misc.c	2004-04-30 00:45:09.000000000 -0700
+++ 2.6.6-rc2-cpu_present/fs/proc/proc_misc.c	2004-04-30 00:55:01.000000000 -0700
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
Index: 2.6.6-rc2-cpu_present/include/asm-ia64/smp.h
===================================================================
--- 2.6.6-rc2-cpu_present.orig/include/asm-ia64/smp.h	2004-04-30 00:45:13.000000000 -0700
+++ 2.6.6-rc2-cpu_present/include/asm-ia64/smp.h	2004-04-30 00:55:01.000000000 -0700
@@ -38,7 +38,8 @@
 
 extern char no_int_routing __devinitdata;
 
-extern cpumask_t phys_cpu_present_map;
+extern cpumask_t cpu_possible_map;
+extern cpumask_t cpu_present_map;
 extern cpumask_t cpu_online_map;
 extern unsigned long ipi_base_addr;
 extern unsigned char smp_int_redirect;
@@ -48,8 +49,6 @@
 
 extern unsigned long ap_wakeup_vector;
 
-#define cpu_possible_map phys_cpu_present_map
-
 /*
  * Function to map hard smp processor id to logical id.  Slow, so don't use this in
  * performance-critical code.
Index: 2.6.6-rc2-cpu_present/include/linux/cpumask.h
===================================================================
--- 2.6.6-rc2-cpu_present.orig/include/linux/cpumask.h	2004-04-30 00:42:45.000000000 -0700
+++ 2.6.6-rc2-cpu_present/include/linux/cpumask.h	2004-04-30 00:55:01.000000000 -0700
@@ -6,6 +6,8 @@
 #include <asm/cpumask.h>
 #include <asm/bug.h>
 
+extern cpumask_t cpu_present_map;
+
 #ifdef CONFIG_SMP
 
 extern cpumask_t cpu_online_map;
@@ -13,8 +15,10 @@
 
 #define num_online_cpus()		cpus_weight(cpu_online_map)
 #define num_possible_cpus()		cpus_weight(cpu_possible_map)
+#define num_present_cpus()		cpus_weight(cpu_present_map)
 #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
 #define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
+#define cpu_present(cpu) 		cpu_isset((cpu), cpu_present_map)
 
 #define for_each_cpu_mask(cpu, mask)					\
 	for (cpu = first_cpu_const(mk_cpumask_const(mask));		\
@@ -23,16 +27,20 @@
 
 #define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
 #define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
+#define for_each_present_cpu(cpu) for_each_cpu_mask(cpu, cpu_present_map)
 #else
 #define	cpu_online_map			cpumask_of_cpu(0)
 #define	cpu_possible_map		cpumask_of_cpu(0)
 #define num_online_cpus()		1
 #define num_possible_cpus()		1
+#define num_present_cpus()		1
 #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
+#define cpu_present(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
 #define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#define for_each_present_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #endif
 
 #define cpumask_scnprintf(buf, buflen, map)				\
Index: 2.6.6-rc2-cpu_present/init/main.c
===================================================================
--- 2.6.6-rc2-cpu_present.orig/init/main.c	2004-04-30 00:45:13.000000000 -0700
+++ 2.6.6-rc2-cpu_present/init/main.c	2004-04-30 00:55:01.000000000 -0700
@@ -359,10 +359,10 @@
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
Index: 2.6.6-rc2-cpu_present/kernel/cpu.c
===================================================================
--- 2.6.6-rc2-cpu_present.orig/kernel/cpu.c	2004-04-30 00:42:47.000000000 -0700
+++ 2.6.6-rc2-cpu_present/kernel/cpu.c	2004-04-30 00:55:01.000000000 -0700
@@ -169,7 +169,7 @@
 	if ((ret = down_interruptible(&cpucontrol)) != 0)
 		return ret;
 
-	if (cpu_online(cpu)) {
+	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
 	}
Index: 2.6.6-rc2-cpu_present/kernel/sched.c
===================================================================
--- 2.6.6-rc2-cpu_present.orig/kernel/sched.c	2004-04-30 00:45:13.000000000 -0700
+++ 2.6.6-rc2-cpu_present/kernel/sched.c	2004-05-02 16:22:42.000000000 -0700
@@ -3030,6 +3030,9 @@
 	return retval;
 }
 
+cpumask_t cpu_present_map = CPU_MASK_ALL;
+EXPORT_SYMBOL(cpu_present_map);
+
 /**
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
