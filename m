Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbULLFt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbULLFt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 00:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbULLFt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 00:49:59 -0500
Received: from fsmlabs.com ([168.103.115.128]:29157 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262047AbULLFtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 00:49:45 -0500
Date: Sat, 11 Dec 2004 22:49:28 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
In-Reply-To: <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com> <20041206111634.44d6d29c.sfr@canb.auug.org.au>
 <20041205232007.7edc4a78.akpm@osdl.org> <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
 <20041206160405.GB1271@us.ibm.com> <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
 <20041206192243.GC1435@us.ibm.com> <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004, Zwane Mwaikambo wrote:

> > Introduce cpu_idle_wait() on architectures requiring modification of 
> > pm_idle from modules, this will ensure that all processors have updated 
> > their cached values of pm_idle upon exit. This patch is to address the bug 
> > report at http://bugme.osdl.org/show_bug.cgi?id=1716 and replaces the 
> > current code fix which is in violation of normal RCU usage as pointed out 
> > by Stephen, Dipankar and Paul.

 arch/i386/kernel/apm.c       |    2 +-
 arch/i386/kernel/process.c   |   30 +++++++++++++++++++++++-------
 arch/ia64/kernel/process.c   |   30 +++++++++++++++++++++++-------
 arch/x86_64/kernel/process.c |   31 ++++++++++++++++++++++++-------
 drivers/acpi/processor.c     |    2 +-
 include/asm-i386/system.h    |    1 +
 include/asm-ia64/system.h    |    1 +
 include/asm-x86_64/system.h  |    2 ++
 8 files changed, 76 insertions(+), 23 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-rc2/arch/i386/kernel/apm.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/i386/kernel/apm.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 apm.c
--- linux-2.6.10-rc2/arch/i386/kernel/apm.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/i386/kernel/apm.c	12 Dec 2004 04:28:11 -0000
@@ -2369,7 +2369,7 @@ static void __exit apm_exit(void)
 		 * (pm_idle), Wait for all processors to update cached/local
 		 * copies of pm_idle before proceeding.
 		 */
-		synchronize_kernel();
+		cpu_idle_wait();
 	}
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {
Index: linux-2.6.10-rc2/arch/i386/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.10-rc2/arch/i386/kernel/process.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/i386/kernel/process.c	12 Dec 2004 05:11:27 -0000
@@ -72,6 +72,7 @@ unsigned long thread_saved_pc(struct tas
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
+static cpumask_t cpu_idle_map;
 
 void disable_hlt(void)
 {
@@ -142,16 +143,16 @@ static void poll_idle (void)
  */
 void cpu_idle (void)
 {
+	int cpu = smp_processor_id();
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
 			void (*idle)(void);
-			/*
-			 * Mark this as an RCU critical section so that
-			 * synchronize_kernel() in the unload path waits
-			 * for our completion.
-			 */
-			rcu_read_lock();
+
+			if (cpu_isset(cpu, cpu_idle_map))
+				cpu_clear(cpu, cpu_idle_map);
+			rmb();
 			idle = pm_idle;
 
 			if (!idle)
@@ -159,12 +160,27 @@ void cpu_idle (void)
 
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
-			rcu_read_unlock();
 		}
 		schedule();
 	}
 }
 
+void cpu_idle_wait(void)
+{
+	int cpu;
+	cpumask_t map;
+
+	for_each_online_cpu(cpu)
+		cpu_set(cpu, cpu_idle_map);
+
+	wmb();
+	do {
+		schedule_timeout(HZ);
+		cpus_and(map, cpu_idle_map, cpu_online_map);
+	} while (!cpus_empty(map));
+}
+EXPORT_SYMBOL_GPL(cpu_idle_wait);
+
 /*
  * This uses new MONITOR/MWAIT instructions on P4 processors with PNI,
  * which can obviate IPI to trigger checking of need_resched.
Index: linux-2.6.10-rc2/arch/ia64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/ia64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.10-rc2/arch/ia64/kernel/process.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/ia64/kernel/process.c	12 Dec 2004 05:11:56 -0000
@@ -46,6 +46,7 @@
 #include "sigframe.h"
 
 void (*ia64_mark_idle)(int);
+static cpumask_t cpu_idle_map;
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
@@ -223,10 +224,28 @@ static inline void play_dead(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+
+void cpu_idle_wait(void)
+{
+        int cpu;
+        cpumask_t map;
+
+        for_each_online_cpu(cpu)
+                cpu_set(cpu, cpu_idle_map);
+
+        wmb();
+        do {
+                schedule_timeout(HZ);
+                cpus_and(map, cpu_idle_map, cpu_online_map);
+        } while (!cpus_empty(map));
+}
+EXPORT_SYMBOL_GPL(cpu_idle_wait);
+
 void __attribute__((noreturn))
 cpu_idle (void *unused)
 {
 	void (*mark_idle)(int) = ia64_mark_idle;
+	int cpu = smp_processor_id();
 
 	/* endless idle loop with no priority at all */
 	while (1) {
@@ -239,17 +258,14 @@ cpu_idle (void *unused)
 
 			if (mark_idle)
 				(*mark_idle)(1);
-			/*
-			 * Mark this as an RCU critical section so that
-			 * synchronize_kernel() in the unload path waits
-			 * for our completion.
-			 */
-			rcu_read_lock();
+
+			if (cpu_isset(cpu, cpu_idle_map))
+				cpu_clear(cpu, cpu_idle_map);
+			rmb();
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
 			(*idle)();
-			rcu_read_unlock();
 		}
 
 		if (mark_idle)
Index: linux-2.6.10-rc2/arch/x86_64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/x86_64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.10-rc2/arch/x86_64/kernel/process.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/x86_64/kernel/process.c	12 Dec 2004 05:26:48 -0000
@@ -61,6 +61,7 @@ EXPORT_SYMBOL(boot_option_idle_override)
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
+static cpumask_t cpu_idle_map;
 
 void disable_hlt(void)
 {
@@ -123,6 +124,23 @@ static void poll_idle (void)
 	}
 }
 
+
+void cpu_idle_wait(void)
+{
+        int cpu;
+        cpumask_t map;
+
+        for_each_online_cpu(cpu)
+                cpu_set(cpu, cpu_idle_map);
+
+        wmb();
+        do {
+                schedule_timeout(HZ);
+                cpus_and(map, cpu_idle_map, cpu_online_map);
+        } while (!cpus_empty(map));
+}
+EXPORT_SYMBOL_GPL(cpu_idle_wait);
+
 /*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
@@ -131,21 +149,20 @@ static void poll_idle (void)
  */
 void cpu_idle (void)
 {
+	int cpu = smp_processor_id();
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
 			void (*idle)(void);
-			/*
-			 * Mark this as an RCU critical section so that
-			 * synchronize_kernel() in the unload path waits
-			 * for our completion.
-			 */
-			rcu_read_lock();
+
+			if (cpu_isset(cpu, cpu_idle_map))
+				cpu_clear(cpu, cpu_idle_map);
+			rmb();
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
 			idle();
-			rcu_read_unlock();
 		}
 		schedule();
 	}
Index: linux-2.6.10-rc2/drivers/acpi/processor.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/drivers/acpi/processor.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.c
--- linux-2.6.10-rc2/drivers/acpi/processor.c	25 Nov 2004 19:45:34 -0000	1.1.1.1
+++ linux-2.6.10-rc2/drivers/acpi/processor.c	12 Dec 2004 04:28:11 -0000
@@ -2535,7 +2535,7 @@ acpi_processor_remove (
 		 * (pm_idle), Wait for all processors to update cached/local
 		 * copies of pm_idle before proceeding.
 		 */
-		synchronize_kernel();
+		cpu_idle_wait();
 	}
 
 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY, 
Index: linux-2.6.10-rc2/include/asm-i386/system.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/include/asm-i386/system.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 system.h
--- linux-2.6.10-rc2/include/asm-i386/system.h	25 Nov 2004 19:45:33 -0000	1.1.1.1
+++ linux-2.6.10-rc2/include/asm-i386/system.h	12 Dec 2004 04:28:11 -0000
@@ -466,5 +466,6 @@ void disable_hlt(void);
 void enable_hlt(void);
 
 extern int es7000_plat;
+void cpu_idle_wait(void);
 
 #endif
Index: linux-2.6.10-rc2/include/asm-ia64/system.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/include/asm-ia64/system.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 system.h
--- linux-2.6.10-rc2/include/asm-ia64/system.h	25 Nov 2004 19:45:33 -0000	1.1.1.1
+++ linux-2.6.10-rc2/include/asm-ia64/system.h	12 Dec 2004 04:28:11 -0000
@@ -284,6 +284,7 @@ do {						\
 
 #define ia64_platform_is(x) (strcmp(x, platform_name) == 0)
 
+void cpu_idle_wait(void);
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
Index: linux-2.6.10-rc2/include/asm-x86_64/system.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/include/asm-x86_64/system.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 system.h
--- linux-2.6.10-rc2/include/asm-x86_64/system.h	25 Nov 2004 19:45:33 -0000	1.1.1.1
+++ linux-2.6.10-rc2/include/asm-x86_64/system.h	12 Dec 2004 04:28:11 -0000
@@ -326,6 +326,8 @@ static inline unsigned long __cmpxchg(vo
 /* For spinlocks etc */
 #define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
 
+void cpu_idle_wait(void);
+
 /*
  * disable hlt during certain critical i/o operations
  */
