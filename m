Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289251AbSA1Q6M>; Mon, 28 Jan 2002 11:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289250AbSA1Q57>; Mon, 28 Jan 2002 11:57:59 -0500
Received: from mx2.elte.hu ([157.181.151.9]:24531 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289236AbSA1Q5j>;
	Mon, 28 Jan 2002 11:57:39 -0500
Date: Mon, 28 Jan 2002 19:55:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] idle startup fixes, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201281916590.12284-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch should fix the idle-thread related bootup problems
reported by a number of people with bigger systems.

the basic bug was that we kept freshly forked idle threads on the
runqueue. CPUs which started up earlier might have load-balanced those
idle threads away before the startup of the other CPU was finished.

The solution is to get rid of the current init_idle() and
idle_startup_done() method and do all the idle-thread setup (including
removal from the runqueue) right after fork_by_hand(), in the boot CPU's
context.

Furthermore, the APIC timer interrupt needs to be disabled until all idle
threads have started up, to avoid rebalancing ticks to steal tasks from
CPU0's runqueue, in the small window between fork() and init_idle().

the patch also includes hpa's improvement to __ffs().

(hopefully this idle-startup variation is the final one.)

2.5.3-pre5 + the -J9 patch has been test-compiled and test-booted on an
8-way SMP, 2-way SMP, and UP x86 system. (-J9 is this patch plus the 16
scheduler patches i sent against 2.5.3-pre5.)

	Ingo

diff -rNu linux-J8/arch/i386/kernel/apic.c linux-J9/arch/i386/kernel/apic.c
--- linux-J8/arch/i386/kernel/apic.c	Mon Jan 28 15:24:19 2002
+++ linux-J9/arch/i386/kernel/apic.c	Mon Jan 28 17:41:45 2002
@@ -918,6 +918,26 @@
 	smp_call_function(setup_APIC_timer, (void *)calibration_result, 1, 1);
 }

+void __init disable_APIC_timer(void)
+{
+	if (using_apic_timer) {
+		unsigned long v;
+
+		v = apic_read(APIC_LVTT);
+		apic_write_around(APIC_LVTT, v | APIC_LVT_MASKED);
+	}
+}
+
+void enable_APIC_timer(void)
+{
+	if (using_apic_timer) {
+		unsigned long v;
+
+		v = apic_read(APIC_LVTT);
+		apic_write_around(APIC_LVTT, v & ~APIC_LVT_MASKED);
+	}
+}
+
 /*
  * the frequency of the profiling timer can be changed
  * by writing a multiplier value into /proc/profile.
diff -rNu linux-J8/arch/i386/kernel/smpboot.c linux-J9/arch/i386/kernel/smpboot.c
--- linux-J8/arch/i386/kernel/smpboot.c	Mon Jan 28 15:24:44 2002
+++ linux-J9/arch/i386/kernel/smpboot.c	Mon Jan 28 17:41:45 2002
@@ -435,6 +435,7 @@
 	 */
  	smp_store_cpu_info(cpuid);

+	disable_APIC_timer();
 	/*
 	 * Allow the master to continue.
 	 */
@@ -456,8 +457,6 @@
  */
 int __init start_secondary(void *unused)
 {
-	__cli();
-	init_idle();
 	/*
 	 * Dont put anything before smp_callin(), SMP
 	 * booting is too fragile that we want to limit the
@@ -467,12 +466,12 @@
 	smp_callin();
 	while (!atomic_read(&smp_commenced))
 		rep_nop();
+	enable_APIC_timer();
 	/*
 	 * low-memory mappings have been cleared, flush them from
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
-	idle_startup_done();

 	return cpu_idle();
 }
@@ -806,7 +805,7 @@
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);

-	idle->cpu = cpu;
+	init_idle(idle, cpu);

 	map_cpu_to_boot_apicid(cpu, apicid);

diff -rNu linux-J8/include/asm-i386/apic.h linux-J9/include/asm-i386/apic.h
--- linux-J8/include/asm-i386/apic.h	Thu Nov 22 20:46:19 2001
+++ linux-J9/include/asm-i386/apic.h	Mon Jan 28 17:41:45 2002
@@ -79,6 +79,8 @@
 extern void setup_apic_nmi_watchdog (void);
 extern inline void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
+extern void disable_APIC_timer(void);
+extern void enable_APIC_timer(void);

 extern struct pm_dev *apic_pm_register(pm_dev_t, unsigned long, pm_callback);
 extern void apic_pm_unregister(struct pm_dev*);
diff -rNu linux-J8/include/asm-i386/bitops.h linux-J9/include/asm-i386/bitops.h
--- linux-J8/include/asm-i386/bitops.h	Mon Jan 28 15:24:44 2002
+++ linux-J9/include/asm-i386/bitops.h	Mon Jan 28 17:41:45 2002
@@ -409,7 +409,7 @@
 {
 	__asm__("bsfl %1,%0"
 		:"=r" (word)
-		:"r" (word));
+		:"rm" (word));
 	return word;
 }

diff -rNu linux-J8/include/linux/sched.h linux-J9/include/linux/sched.h
--- linux-J8/include/linux/sched.h	Mon Jan 28 15:24:44 2002
+++ linux-J9/include/linux/sched.h	Mon Jan 28 17:41:45 2002
@@ -140,8 +140,7 @@
 typedef struct task_struct task_t;

 extern void sched_init(void);
-extern void init_idle(void);
-extern void idle_startup_done(void);
+extern void init_idle(task_t *idle, int cpu);
 extern void show_state(void);
 extern void cpu_init (void);
 extern void trap_init(void);
diff -rNu linux-J8/init/main.c linux-J9/init/main.c
--- linux-J8/init/main.c	Mon Jan 28 15:24:21 2002
+++ linux-J9/init/main.c	Mon Jan 28 17:41:45 2002
@@ -274,27 +274,14 @@

 #else

-static unsigned long __initdata wait_init_idle;
-
-void __init idle_startup_done(void)
-{
-	clear_bit(smp_processor_id(), &wait_init_idle);
-	while (wait_init_idle) {
-		cpu_relax();
-		barrier();
-	}
-}
-
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
 	/* Get other processors into their bootup holding patterns. */
 	smp_boot_cpus();
-	wait_init_idle = cpu_online_map;

 	smp_threads_ready=1;
 	smp_commence();
-	idle_startup_done();
 }

 #endif
@@ -391,7 +378,7 @@
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");

-	init_idle();
+	init_idle(current, smp_processor_id());
 	/*
 	 *	We count on the initial thread going ok
 	 *	Like idlers init is an unlocked kernel thread, which will
diff -rNu linux-J8/kernel/sched.c linux-J9/kernel/sched.c
--- linux-J8/kernel/sched.c	Mon Jan 28 15:24:44 2002
+++ linux-J9/kernel/sched.c	Mon Jan 28 17:41:45 2002
@@ -1302,24 +1302,23 @@
 		spin_unlock(&rq2->lock);
 }

-void __init init_idle(void)
+void __init init_idle(task_t *idle, int cpu)
 {
-	runqueue_t *this_rq = this_rq(), *rq = current->array->rq;
+	runqueue_t *idle_rq = cpu_rq(cpu), *rq = idle->array->rq;
 	unsigned long flags;

 	__save_flags(flags);
 	__cli();
-	printk("init_idle() ENTER on CPU#%d.\n", smp_processor_id());
-	double_rq_lock(this_rq, rq);
+	double_rq_lock(idle_rq, rq);

-	this_rq->curr = this_rq->idle = current;
-	deactivate_task(current, rq);
-	current->array = NULL;
-	current->prio = MAX_PRIO;
-	current->state = TASK_RUNNING;
-	double_rq_unlock(this_rq, rq);
-	current->need_resched = 1;
-	printk("init_idle() EXIT on CPU#%d.\n", smp_processor_id());
+	idle_rq->curr = idle_rq->idle = idle;
+	deactivate_task(idle, rq);
+	idle->array = NULL;
+	idle->prio = MAX_PRIO;
+	idle->state = TASK_RUNNING;
+	idle->cpu = cpu;
+	double_rq_unlock(idle_rq, rq);
+	idle->need_resched = 1;
 	__restore_flags(flags);
 }


