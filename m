Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVCJDEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVCJDEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVCJDCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:02:50 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:47295 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262444AbVCJCkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:40:23 -0500
Date: Wed, 9 Mar 2005 19:41:35 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] Reduce cacheline bouncing in cpu_idle_wait
Message-ID: <Pine.LNX.4.61.0503091839200.2903@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi noted that during normal runtime cpu_idle_map is bounced around a 
lot, and occassionally at a higher frequency than the timer interrupt 
wakeup which we normally exit pm_idle from. So switch to a percpu 
variable. Andi i didn't move things to the slow path because it would 
involve adding scheduler code to wakeup the idle thread on the cpus we're 
waiting for.

 arch/i386/kernel/process.c   |   28 ++++++++++++++++++++--------
 arch/ia64/kernel/process.c   |   39 +++++++++++++++++++++++++--------------
 arch/x86_64/kernel/process.c |   38 +++++++++++++++++++++++++-------------
 3 files changed, 70 insertions(+), 35 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.11-mm2/arch/i386/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-mm2/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.11-mm2/arch/i386/kernel/process.c	8 Mar 2005 13:53:27 -0000	1.1.1.1
+++ linux-2.6.11-mm2/arch/i386/kernel/process.c	10 Mar 2005 02:02:33 -0000
@@ -78,7 +78,7 @@ unsigned long thread_saved_pc(struct tas
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
-static cpumask_t cpu_idle_map;
+static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
 void disable_hlt(void)
 {
@@ -185,9 +185,10 @@ void cpu_idle (void)
 	while (1) {
 		while (!need_resched()) {
 			void (*idle)(void);
-
-			if (cpu_isset(cpu, cpu_idle_map))
-				cpu_clear(cpu, cpu_idle_map);
+		
+			if (__get_cpu_var(cpu_idle_state))
+				__get_cpu_var(cpu_idle_state) = 0;
+			
 			rmb();
 			idle = pm_idle;
 
@@ -206,16 +207,27 @@ void cpu_idle (void)
 
 void cpu_idle_wait(void)
 {
-	int cpu;
+	unsigned int cpu, this_cpu = get_cpu();
 	cpumask_t map;
 
-	for_each_online_cpu(cpu)
-		cpu_set(cpu, cpu_idle_map);
+	set_cpus_allowed(current, cpumask_of_cpu(this_cpu));
+	put_cpu();
+
+	for_each_online_cpu(cpu) {
+		per_cpu(cpu_idle_state, cpu) = 1;
+		cpu_set(cpu, map);
+	}
+
+	__get_cpu_var(cpu_idle_state) = 0;
 
 	wmb();
 	do {
 		ssleep(1);
-		cpus_and(map, cpu_idle_map, cpu_online_map);
+		for_each_online_cpu(cpu) {
+			if (cpu_isset(cpu, map) && !per_cpu(cpu_idle_state, cpu))
+				cpu_clear(cpu, map);
+		}
+		cpus_and(map, map, cpu_online_map);
 	} while (!cpus_empty(map));
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
Index: linux-2.6.11-mm2/arch/ia64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-mm2/arch/ia64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.11-mm2/arch/ia64/kernel/process.c	8 Mar 2005 13:53:34 -0000	1.1.1.1
+++ linux-2.6.11-mm2/arch/ia64/kernel/process.c	10 Mar 2005 01:22:49 -0000
@@ -49,7 +49,7 @@
 #include "sigframe.h"
 
 void (*ia64_mark_idle)(int);
-static cpumask_t cpu_idle_map;
+static DEFINE_PER_CPU(unsigned int, cpu_idle_map);
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
@@ -229,20 +229,30 @@ static inline void play_dead(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-
 void cpu_idle_wait(void)
 {
-        int cpu;
-        cpumask_t map;
+	unsigned int cpu, this_cpu = get_cpu();
+	cpumask_t map;
+
+	set_cpus_allowed(current, cpumask_of_cpu(this_cpu));
+	put_cpu();
 
-        for_each_online_cpu(cpu)
-                cpu_set(cpu, cpu_idle_map);
+	for_each_online_cpu(cpu) {
+		per_cpu(cpu_idle_state, cpu) = 1;
+		cpu_set(cpu, map);
+	}
 
-        wmb();
-        do {
-                ssleep(1);
-                cpus_and(map, cpu_idle_map, cpu_online_map);
-        } while (!cpus_empty(map));
+	__get_cpu_var(cpu_idle_state) = 0;
+
+	wmb();
+	do {
+		ssleep(1);
+		for_each_online_cpu(cpu) {
+			if (cpu_isset(cpu, map) && !per_cpu(cpu_idle_state, cpu))
+				cpu_clear(cpu, map);
+		}
+		cpus_and(map, map, cpu_online_map);
+	} while (!cpus_empty(map));
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
@@ -261,12 +271,13 @@ cpu_idle (void)
 		while (!need_resched()) {
 			void (*idle)(void);
 
+			if (__get_cpu_var(cpu_idle_state))
+				__get_cpu_var(cpu_idle_state) = 0;
+			
+			rmb();
 			if (mark_idle)
 				(*mark_idle)(1);
 
-			if (cpu_isset(cpu, cpu_idle_map))
-				cpu_clear(cpu, cpu_idle_map);
-			rmb();
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
Index: linux-2.6.11-mm2/arch/x86_64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-mm2/arch/x86_64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.11-mm2/arch/x86_64/kernel/process.c	8 Mar 2005 13:53:38 -0000	1.1.1.1
+++ linux-2.6.11-mm2/arch/x86_64/kernel/process.c	10 Mar 2005 01:21:28 -0000
@@ -63,7 +63,7 @@ EXPORT_SYMBOL(boot_option_idle_override)
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
-static cpumask_t cpu_idle_map;
+static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
 void disable_hlt(void)
 {
@@ -126,20 +126,30 @@ static void poll_idle (void)
 	}
 }
 
-
 void cpu_idle_wait(void)
 {
-        int cpu;
-        cpumask_t map;
+	unsigned int cpu, this_cpu = get_cpu();
+	cpumask_t map;
+
+	set_cpus_allowed(current, cpumask_of_cpu(this_cpu));
+	put_cpu();
+
+	for_each_online_cpu(cpu) {
+		per_cpu(cpu_idle_state, cpu) = 1;
+		cpu_set(cpu, map);
+	}
 
-        for_each_online_cpu(cpu)
-                cpu_set(cpu, cpu_idle_map);
+	__get_cpu_var(cpu_idle_state) = 0;
 
-        wmb();
-        do {
-                ssleep(1);
-                cpus_and(map, cpu_idle_map, cpu_online_map);
-        } while (!cpus_empty(map));
+	wmb();
+	do {
+		ssleep(1);
+		for_each_online_cpu(cpu) {
+			if (cpu_isset(cpu, map) && !per_cpu(cpu_idle_state, cpu))
+				cpu_clear(cpu, map);
+		}
+		cpus_and(map, map, cpu_online_map);
+	} while (!cpus_empty(map));
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
@@ -158,14 +168,16 @@ void cpu_idle (void)
 		while (!need_resched()) {
 			void (*idle)(void);
 
-			if (cpu_isset(cpu, cpu_idle_map))
-				cpu_clear(cpu, cpu_idle_map);
+			if (__get_cpu_var(cpu_idle_state))
+				__get_cpu_var(cpu_idle_state) = 0;
+
 			rmb();
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
 			idle();
 		}
+		
 		schedule();
 	}
 }
