Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbULTWid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbULTWid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbULTWhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:37:46 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19090 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261673AbULTWgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:36:31 -0500
Date: Mon, 20 Dec 2004 10:27:11 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
Message-ID: <20041220182711.GA13972@us.ibm.com>
References: <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com> <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com> <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com> <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com> <29495f1d04121818403f949fdd@mail.gmail.com> <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com> <1103505344.5093.4.camel@npiggin-nld.site> <Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com> <1103507784.5093.9.camel@npiggin-nld.site> <Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com>
X-Operating-System: Linux 2.6.10-rc3 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2004 at 07:10:31PM -0700, Zwane Mwaikambo wrote:
> On Mon, 20 Dec 2004, Nick Piggin wrote:
> 
> > On Sun, 2004-12-19 at 18:44 -0700, Zwane Mwaikambo wrote:
> > > On Mon, 20 Dec 2004, Nick Piggin wrote:
> > > 
> > > > This thread can possibly be stalled forever if there is a CPU hog
> > > > running, right?
> > > 
> > > Yep.
> > > 
> > > > In which case, you will want to use ssleep rather than a busy loop.
> > > 
> > > Well ssleep essentially does the same thing as the schedule_timeout.
> > > 
> > 
> > Yes - so long as you set ->state when using schedule_timeout ;)
> 
> Nish could you please submit something to switch it to ssleep?

I believe the only files/patches that needed to be changed were the process.c
changes. Here they are re-worked to use ssleep(1) instead of
schedule_timeout(HZ).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-rc3-v/arch/i386/kernel/process.c	2004-12-08 13:38:42.000000000 -0800
+++ 2.6.10-rc3/arch/i386/kernel/process.c	2004-12-20 10:15:54.000000000 -0800
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
@@ -159,12 +160,24 @@ void cpu_idle (void)
 
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
+
+	for_each_online_cpu(cpu)
+		cpu_set(cpu, cpu_idle_map);
+
+	wmb();	
+	while (cpus_equal(cpu_idle_map, cpu_online_map))
+		ssleep(1);
+}
+EXPORT_SYMBOL_GPL(cpu_idle_wait);
+
 /*
  * This uses new MONITOR/MWAIT instructions on P4 processors with PNI,
  * which can obviate IPI to trigger checking of need_resched.
--- 2.6.10-rc3-v/arch/ia64/kernel/process.c	2004-12-08 13:38:43.000000000 -0800
+++ 2.6.10-rc3/arch/ia64/kernel/process.c	2004-12-20 10:16:18.000000000 -0800
@@ -46,6 +46,7 @@
 #include "sigframe.h"
 
 void (*ia64_mark_idle)(int);
+static cpumask_t cpu_idle_map;
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
@@ -225,10 +226,24 @@ static inline void play_dead(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+void cpu_idle_wait(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		cpu_set(cpu, cpu_idle_map);
+
+	wmb();	
+	while (cpus_equal(cpu_idle_map, cpu_online_map))
+		ssleep(1);
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
@@ -241,17 +256,14 @@ cpu_idle (void *unused)
 
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
--- 2.6.10-rc3-v/arch/x86_64/kernel/process.c	2004-12-08 13:38:45.000000000 -0800
+++ 2.6.10-rc3/arch/x86_64/kernel/process.c	2004-12-20 10:16:59.000000000 -0800
@@ -61,6 +61,7 @@ EXPORT_SYMBOL(boot_option_idle_override)
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
+static cpumask_t cpu_idle_map;
 
 void disable_hlt(void)
 {
@@ -123,6 +124,19 @@ static void poll_idle (void)
 	}
 }
 
+void cpu_idle_wait(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		cpu_set(cpu, cpu_idle_map);
+	
+	wmb();	
+	while (cpus_equal(cpu_idle_map, cpu_online_map))
+		ssleep(1);
+}
+EXPORT_SYMBOL_GPL(cpu_idle_wait);
+
 /*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
@@ -131,21 +145,20 @@ static void poll_idle (void)
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
