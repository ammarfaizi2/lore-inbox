Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSEPNXZ>; Thu, 16 May 2002 09:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSEPNXY>; Thu, 16 May 2002 09:23:24 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19590 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312582AbSEPNXO>; Thu, 16 May 2002 09:23:14 -0400
Date: Thu, 16 May 2002 18:54:48 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave Miller <davem@redhat.com>
Subject: [RFC][PATCH] TIMER_BH-less smptimers
Message-ID: <20020516185448.A8069@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have been experimenting with Ingo's smptimers and I ended up
extending it a little bit. I would really appreciate comments
on whether these things make sense or not.

The major changes are -

1. I removed TIMER_BH. The vector is defined but not used.

2. Not having the TIMER_BH requires additional work for
serializing old protocol code (deliver_to_old_ones()) to
work with new timers.  The protocol code is already serialized 
using net_bh_lock. So, I used it to serialize old protocol
code with new timers.

3. Ingo's run_local_timers() had to do all sorts of locking
to keep legacy serialization happy. I just added net_bh_lock
to that list. This makes sure that timers don't run with
old protocol code.

4. When legacy locking fails in run_local_timers(), I use a
per-cpu tasklet to run the timers for that cpu. This tasklet
also uses the same locking scheme to support legacy stuff.

5. I expanded it to all smp architectures that I could see,
but no testing has been done yet for non-i386. As and when
I can boot 2.5 kernels on ia64 and ppc, I will test it.
I am reasonably sure I didn't get mips right, if not others.

The patch has been tested with *2.5.14* (applies cleanly) and 
ltp in a 4CPU i386. Unfortunately, the legacy code still requires 
us to do serialize timers with global locks.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="smptimers-2.5.12-2.patch"

diff -urN linux-2.5.12-base/arch/alpha/kernel/smp.c linux-2.5.12-smptimers/arch/alpha/kernel/smp.c
--- linux-2.5.12-base/arch/alpha/kernel/smp.c	Wed May  1 05:38:51 2002
+++ linux-2.5.12-smptimers/arch/alpha/kernel/smp.c	Fri May  3 19:39:38 2002
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <linux/cache.h>
+#include <linux/timer.h>
 
 #include <asm/hwrpb.h>
 #include <asm/ptrace.h>
@@ -657,6 +658,7 @@
 		if (softirq_pending(cpu))
 			do_softirq();
 	}
+	run_local_timers();
 }
 
 int __init
diff -urN linux-2.5.12-base/arch/i386/kernel/apic.c linux-2.5.12-smptimers/arch/i386/kernel/apic.c
--- linux-2.5.12-base/arch/i386/kernel/apic.c	Wed May  1 05:38:58 2002
+++ linux-2.5.12-smptimers/arch/i386/kernel/apic.c	Fri May  3 20:01:08 2002
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/timer.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -1087,7 +1088,7 @@
 	irq_enter(cpu, 0);
 	smp_local_timer_interrupt(&regs);
 	irq_exit(cpu, 0);
-
+	run_local_timers();
 	if (softirq_pending(cpu))
 		do_softirq();
 }
diff -urN linux-2.5.12-base/arch/i386/mm/fault.c linux-2.5.12-smptimers/arch/i386/mm/fault.c
--- linux-2.5.12-base/arch/i386/mm/fault.c	Wed May  1 05:38:44 2002
+++ linux-2.5.12-smptimers/arch/i386/mm/fault.c	Fri May  3 16:05:11 2002
@@ -94,16 +94,12 @@
 	goto bad_area;
 }
 
-extern spinlock_t timerlist_lock;
-
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is acquired through the
- * console unblank code)
+ * message out
  */
 void bust_spinlocks(int yes)
 {
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 #ifdef CONFIG_SMP
diff -urN linux-2.5.12-base/arch/ia64/kernel/smp.c linux-2.5.12-smptimers/arch/ia64/kernel/smp.c
--- linux-2.5.12-base/arch/ia64/kernel/smp.c	Wed May  1 05:38:57 2002
+++ linux-2.5.12-smptimers/arch/ia64/kernel/smp.c	Fri May  3 19:41:38 2002
@@ -32,6 +32,7 @@
 #include <linux/cache.h>
 #include <linux/delay.h>
 #include <linux/cache.h>
+#include <linux/timer.h>
 
 #include <asm/atomic.h>
 #include <asm/bitops.h>
@@ -330,6 +331,7 @@
 		local_cpu_data->prof_counter = local_cpu_data->prof_multiplier;
 		update_process_times(user);
 	}
+	run_local_timers();
 }
 
 /*
diff -urN linux-2.5.12-base/arch/ia64/kernel/traps.c linux-2.5.12-smptimers/arch/ia64/kernel/traps.c
--- linux-2.5.12-base/arch/ia64/kernel/traps.c	Wed May  1 05:39:01 2002
+++ linux-2.5.12-smptimers/arch/ia64/kernel/traps.c	Fri May  3 21:53:13 2002
@@ -42,7 +42,6 @@
 
 #include <asm/fpswa.h>
 
-extern spinlock_t timerlist_lock;
 
 static fpswa_interface_t *fpswa_interface;
 
@@ -56,13 +55,12 @@
 }
 
 /*
- * Unlock any spinlocks which will prevent us from getting the message out (timerlist_lock
+ * Unlock any spinlocks which will prevent us from getting the message out 
  * is acquired through the console unblank code)
  */
 void
 bust_spinlocks (int yes)
 {
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 #ifdef CONFIG_SMP
diff -urN linux-2.5.12-base/arch/mips64/mm/fault.c linux-2.5.12-smptimers/arch/mips64/mm/fault.c
--- linux-2.5.12-base/arch/mips64/mm/fault.c	Wed May  1 05:38:59 2002
+++ linux-2.5.12-smptimers/arch/mips64/mm/fault.c	Fri May  3 21:53:48 2002
@@ -58,16 +58,13 @@
 	printk("Got exception 0x%lx at 0x%lx\n", retaddr, regs.cp0_epc);
 }
 
-extern spinlock_t timerlist_lock;
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is acquired through the
- * console unblank code)
+ * message out 
  */
 void bust_spinlocks(int yes)
 {
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
diff -urN linux-2.5.12-base/arch/mips64/sgi-ip27/ip27-timer.c linux-2.5.12-smptimers/arch/mips64/sgi-ip27/ip27-timer.c
--- linux-2.5.12-base/arch/mips64/sgi-ip27/ip27-timer.c	Wed May  1 05:38:55 2002
+++ linux-2.5.12-smptimers/arch/mips64/sgi-ip27/ip27-timer.c	Fri May  3 19:44:02 2002
@@ -11,6 +11,7 @@
 #include <linux/param.h>
 #include <linux/timex.h>
 #include <linux/mm.h>		
+#include <linux/timer.h>
 
 #include <asm/pgtable.h>
 #include <asm/sgialib.h>
@@ -123,6 +124,7 @@
 		irq_exit(cpu, 0);
 	}
 #endif /* CONFIG_SMP */
+	run_local_timers();
 	
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.5.12-base/arch/ppc/kernel/time.c linux-2.5.12-smptimers/arch/ppc/kernel/time.c
--- linux-2.5.12-base/arch/ppc/kernel/time.c	Wed May  1 05:38:49 2002
+++ linux-2.5.12-smptimers/arch/ppc/kernel/time.c	Sat May  4 01:45:55 2002
@@ -59,6 +59,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/time.h>
 #include <linux/init.h>
+#include <linux/timer.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -213,6 +214,7 @@
 
 	hardirq_exit(cpu);
 
+	run_local_timers();
 	if (softirq_pending(cpu))
 		do_softirq();
 
diff -urN linux-2.5.12-base/arch/ppc64/kernel/time.c linux-2.5.12-smptimers/arch/ppc64/kernel/time.c
--- linux-2.5.12-base/arch/ppc64/kernel/time.c	Wed May  1 05:39:01 2002
+++ linux-2.5.12-smptimers/arch/ppc64/kernel/time.c	Mon May  6 13:53:36 2002
@@ -46,6 +46,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/time.h>
 #include <linux/init.h>
+#include <linux/timer.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -292,6 +293,7 @@
 
 	irq_exit(cpu);
 
+	run_local_timers();
 	if (softirq_pending(cpu))
 		do_softirq();
 	
diff -urN linux-2.5.12-base/arch/s390/kernel/time.c linux-2.5.12-smptimers/arch/s390/kernel/time.c
--- linux-2.5.12-base/arch/s390/kernel/time.c	Wed May  1 05:38:45 2002
+++ linux-2.5.12-smptimers/arch/s390/kernel/time.c	Mon May  6 13:56:26 2002
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/types.h>
+#include <linux/timer.h>
 
 #include <asm/uaccess.h>
 #include <asm/delay.h>
@@ -196,6 +197,7 @@
 	}
 
 	irq_exit(cpu, 0);
+	run_local_timers();
 }
 
 /*
diff -urN linux-2.5.12-base/arch/s390/mm/fault.c linux-2.5.12-smptimers/arch/s390/mm/fault.c
--- linux-2.5.12-base/arch/s390/mm/fault.c	Wed May  1 05:39:01 2002
+++ linux-2.5.12-smptimers/arch/s390/mm/fault.c	Fri May  3 21:54:38 2002
@@ -38,16 +38,13 @@
 extern void die(const char *,struct pt_regs *,long);
 static void force_sigsegv(struct task_struct *tsk, int code, void *address);
 
-extern spinlock_t timerlist_lock;
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is acquired through the
- * console unblank code)
+ * message out 
  */
 void bust_spinlocks(int yes)
 {
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
diff -urN linux-2.5.12-base/arch/s390x/kernel/time.c linux-2.5.12-smptimers/arch/s390x/kernel/time.c
--- linux-2.5.12-base/arch/s390x/kernel/time.c	Wed May  1 05:38:50 2002
+++ linux-2.5.12-smptimers/arch/s390x/kernel/time.c	Mon May  6 13:55:32 2002
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/types.h>
+#include <linux/timer.h>
 
 #include <asm/uaccess.h>
 #include <asm/delay.h>
@@ -202,6 +203,7 @@
 	}
 
 	irq_exit(cpu, 0);
+	run_local_timers();
 }
 
 /*
diff -urN linux-2.5.12-base/arch/s390x/mm/fault.c linux-2.5.12-smptimers/arch/s390x/mm/fault.c
--- linux-2.5.12-base/arch/s390x/mm/fault.c	Wed May  1 05:38:54 2002
+++ linux-2.5.12-smptimers/arch/s390x/mm/fault.c	Fri May  3 21:54:16 2002
@@ -37,16 +37,13 @@
 extern void die(const char *,struct pt_regs *,long);
 static void force_sigsegv(struct task_struct *tsk, int code, void *address);
 
-extern spinlock_t timerlist_lock;
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is acquired through the
- * console unblank code)
+ * message out 
  */
 void bust_spinlocks(int yes)
 {
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
diff -urN linux-2.5.12-base/arch/sparc/kernel/irq.c linux-2.5.12-smptimers/arch/sparc/kernel/irq.c
--- linux-2.5.12-base/arch/sparc/kernel/irq.c	Wed May  1 05:38:45 2002
+++ linux-2.5.12-smptimers/arch/sparc/kernel/irq.c	Fri May  3 16:05:11 2002
@@ -73,7 +73,7 @@
     prom_halt();
 }
 
-void (*init_timers)(void (*)(int, void *,struct pt_regs *)) =
+void (*sparc_init_timers)(void (*)(int, void *,struct pt_regs *)) =
     (void (*)(void (*)(int, void *,struct pt_regs *))) irq_panic;
 
 /*
diff -urN linux-2.5.12-base/arch/sparc/kernel/sun4c_irq.c linux-2.5.12-smptimers/arch/sparc/kernel/sun4c_irq.c
--- linux-2.5.12-base/arch/sparc/kernel/sun4c_irq.c	Wed May  1 05:38:46 2002
+++ linux-2.5.12-smptimers/arch/sparc/kernel/sun4c_irq.c	Fri May  3 16:05:11 2002
@@ -143,7 +143,7 @@
 	/* Errm.. not sure how to do this.. */
 }
 
-static void __init sun4c_init_timers(void (*counter_fn)(int, void *, struct pt_regs *))
+static void __init sun4c_sparc_init_timers(void (*counter_fn)(int, void *, struct pt_regs *))
 {
 	int irq;
 
@@ -221,7 +221,7 @@
 	BTFIXUPSET_CALL(clear_profile_irq, sun4c_clear_profile_irq, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(load_profile_irq, sun4c_load_profile_irq, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(__irq_itoa, sun4m_irq_itoa, BTFIXUPCALL_NORM);
-	init_timers = sun4c_init_timers;
+	sparc_init_timers = sun4c_sparc_init_timers;
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
diff -urN linux-2.5.12-base/arch/sparc/kernel/sun4d_irq.c linux-2.5.12-smptimers/arch/sparc/kernel/sun4d_irq.c
--- linux-2.5.12-base/arch/sparc/kernel/sun4d_irq.c	Wed May  1 05:38:44 2002
+++ linux-2.5.12-smptimers/arch/sparc/kernel/sun4d_irq.c	Fri May  3 16:05:11 2002
@@ -436,7 +436,7 @@
 	bw_set_prof_limit(cpu, limit);
 }
 
-static void __init sun4d_init_timers(void (*counter_fn)(int, void *, struct pt_regs *))
+static void __init sun4d_sparc_init_timers(void (*counter_fn)(int, void *, struct pt_regs *))
 {
 	int irq;
 	extern struct prom_cpuinfo linux_cpus[NR_CPUS];
@@ -547,7 +547,7 @@
 	BTFIXUPSET_CALL(clear_profile_irq, sun4d_clear_profile_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__irq_itoa, sun4d_irq_itoa, BTFIXUPCALL_NORM);
-	init_timers = sun4d_init_timers;
+	sparc_init_timers = sun4d_sparc_init_timers;
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4d_set_cpu_int, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4d_clear_ipi, BTFIXUPCALL_NOP);
diff -urN linux-2.5.12-base/arch/sparc/kernel/sun4d_smp.c linux-2.5.12-smptimers/arch/sparc/kernel/sun4d_smp.c
--- linux-2.5.12-base/arch/sparc/kernel/sun4d_smp.c	Wed May  1 05:38:47 2002
+++ linux-2.5.12-smptimers/arch/sparc/kernel/sun4d_smp.c	Fri May  3 17:13:01 2002
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/timer.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -467,6 +468,7 @@
 
 		prof_counter[cpu] = prof_multiplier[cpu];
 	}
+	run_local_timers();
 }
 
 extern unsigned int lvl14_resolution;
diff -urN linux-2.5.12-base/arch/sparc/kernel/sun4m_irq.c linux-2.5.12-smptimers/arch/sparc/kernel/sun4m_irq.c
--- linux-2.5.12-base/arch/sparc/kernel/sun4m_irq.c	Wed May  1 05:38:58 2002
+++ linux-2.5.12-smptimers/arch/sparc/kernel/sun4m_irq.c	Fri May  3 16:05:11 2002
@@ -223,7 +223,7 @@
 	return buff;
 }
 
-static void __init sun4m_init_timers(void (*counter_fn)(int, void *, struct pt_regs *))
+static void __init sun4m_sparc_init_timers(void (*counter_fn)(int, void *, struct pt_regs *))
 {
 	int reg_count, irq, cpu;
 	struct linux_prom_registers cnt_regs[PROMREG_MAX];
@@ -374,7 +374,7 @@
 	BTFIXUPSET_CALL(clear_profile_irq, sun4m_clear_profile_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4m_load_profile_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__irq_itoa, sun4m_irq_itoa, BTFIXUPCALL_NORM);
-	init_timers = sun4m_init_timers;
+	sparc_init_timers = sun4m_sparc_init_timers;
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4m_clear_ipi, BTFIXUPCALL_NORM);
diff -urN linux-2.5.12-base/arch/sparc/kernel/sun4m_smp.c linux-2.5.12-smptimers/arch/sparc/kernel/sun4m_smp.c
--- linux-2.5.12-base/arch/sparc/kernel/sun4m_smp.c	Wed May  1 05:38:53 2002
+++ linux-2.5.12-smptimers/arch/sparc/kernel/sun4m_smp.c	Fri May  3 17:13:32 2002
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/timer.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -454,6 +455,7 @@
 
 		prof_counter[cpu] = prof_multiplier[cpu];
 	}
+	run_local_timers();
 }
 
 extern unsigned int lvl14_resolution;
diff -urN linux-2.5.12-base/arch/sparc/kernel/time.c linux-2.5.12-smptimers/arch/sparc/kernel/time.c
--- linux-2.5.12-base/arch/sparc/kernel/time.c	Wed May  1 05:38:59 2002
+++ linux-2.5.12-smptimers/arch/sparc/kernel/time.c	Fri May  3 16:05:11 2002
@@ -379,7 +379,7 @@
 	else
 		clock_probe();
 
-	init_timers(timer_interrupt);
+	sparc_init_timers(timer_interrupt);
 	
 #ifdef CONFIG_SUN4
 	if(idprom->id_machtype == (SM_SUN4 | SM_4_330)) {
diff -urN linux-2.5.12-base/arch/sparc64/kernel/irq.c linux-2.5.12-smptimers/arch/sparc64/kernel/irq.c
--- linux-2.5.12-base/arch/sparc64/kernel/irq.c	Wed May  1 05:38:55 2002
+++ linux-2.5.12-smptimers/arch/sparc64/kernel/irq.c	Fri May  3 16:05:11 2002
@@ -1027,7 +1027,7 @@
 }
 
 /* This is gets the master TICK_INT timer going. */
-void init_timers(void (*cfunc)(int, void *, struct pt_regs *),
+void sparc_init_timers(void (*cfunc)(int, void *, struct pt_regs *),
 		 unsigned long *clock)
 {
 	unsigned long pstate;
diff -urN linux-2.5.12-base/arch/sparc64/kernel/smp.c linux-2.5.12-smptimers/arch/sparc64/kernel/smp.c
--- linux-2.5.12-base/arch/sparc64/kernel/smp.c	Wed May  1 05:38:44 2002
+++ linux-2.5.12-smptimers/arch/sparc64/kernel/smp.c	Fri May  3 16:48:11 2002
@@ -1027,6 +1027,7 @@
 
 			prof_counter(cpu) = prof_multiplier(cpu);
 		}
+		run_local_timers();
 
 		/* Guarentee that the following sequences execute
 		 * uninterrupted.
diff -urN linux-2.5.12-base/arch/sparc64/kernel/time.c linux-2.5.12-smptimers/arch/sparc64/kernel/time.c
--- linux-2.5.12-base/arch/sparc64/kernel/time.c	Wed May  1 05:38:58 2002
+++ linux-2.5.12-smptimers/arch/sparc64/kernel/time.c	Fri May  3 16:05:11 2002
@@ -611,7 +611,7 @@
 	__restore_flags(flags);
 }
 
-extern void init_timers(void (*func)(int, void *, struct pt_regs *),
+extern void sparc_init_timers(void (*func)(int, void *, struct pt_regs *),
 			unsigned long *);
 
 void __init time_init(void)
@@ -622,7 +622,7 @@
 	 */
 	unsigned long clock;
 
-	init_timers(timer_interrupt, &clock);
+	sparc_init_timers(timer_interrupt, &clock);
 	timer_ticks_per_usec_quotient = ((1UL<<32) / (clock / 1000020));
 }
 
diff -urN linux-2.5.12-base/arch/x86_64/kernel/apic.c linux-2.5.12-smptimers/arch/x86_64/kernel/apic.c
--- linux-2.5.12-base/arch/x86_64/kernel/apic.c	Wed May  1 05:38:48 2002
+++ linux-2.5.12-smptimers/arch/x86_64/kernel/apic.c	Sat May  4 01:38:07 2002
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/timer.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -1069,6 +1070,7 @@
 	smp_local_timer_interrupt(regs);
 	irq_exit(cpu, 0);
 
+	run_local_timers();
 	if (softirq_pending(cpu))
 		do_softirq();
 }
diff -urN linux-2.5.12-base/arch/x86_64/mm/fault.c linux-2.5.12-smptimers/arch/x86_64/mm/fault.c
--- linux-2.5.12-base/arch/x86_64/mm/fault.c	Wed May  1 05:38:45 2002
+++ linux-2.5.12-smptimers/arch/x86_64/mm/fault.c	Fri May  3 21:52:29 2002
@@ -32,11 +32,10 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
-extern spinlock_t console_lock, timerlist_lock;
+extern spinlock_t console_lock;
 
 void bust_spinlocks(int yes)
 {
- 	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 #ifdef CONFIG_SMP
diff -urN linux-2.5.12-base/drivers/net/eepro100.c linux-2.5.12-smptimers/drivers/net/eepro100.c
--- linux-2.5.12-base/drivers/net/eepro100.c	Wed May  1 05:39:00 2002
+++ linux-2.5.12-smptimers/drivers/net/eepro100.c	Fri May  3 16:05:11 2002
@@ -1171,9 +1171,6 @@
 	/* We must continue to monitor the media. */
 	sp->timer.expires = RUN_AT(2*HZ); 			/* 2.0 sec. */
 	add_timer(&sp->timer);
-#if defined(timer_exit)
-	timer_exit(&sp->timer);
-#endif
 }
 
 static void speedo_show_state(struct net_device *dev)
diff -urN linux-2.5.12-base/include/asm-sparc/irq.h linux-2.5.12-smptimers/include/asm-sparc/irq.h
--- linux-2.5.12-base/include/asm-sparc/irq.h	Wed May  1 05:38:45 2002
+++ linux-2.5.12-smptimers/include/asm-sparc/irq.h	Fri May  3 16:05:11 2002
@@ -45,7 +45,7 @@
 #define clear_profile_irq(cpu) BTFIXUP_CALL(clear_profile_irq)(cpu)
 #define load_profile_irq(cpu,limit) BTFIXUP_CALL(load_profile_irq)(cpu,limit)
 
-extern void (*init_timers)(void (*lvl10_irq)(int, void *, struct pt_regs *));
+extern void (*sparc_init_timers)(void (*lvl10_irq)(int, void *, struct pt_regs *));
 extern void claim_ticker14(void (*irq_handler)(int, void *, struct pt_regs *),
 			   int irq,
 			   unsigned int timeout);
diff -urN linux-2.5.12-base/include/asm-sparc64/irq.h linux-2.5.12-smptimers/include/asm-sparc64/irq.h
--- linux-2.5.12-base/include/asm-sparc64/irq.h	Wed May  1 05:38:59 2002
+++ linux-2.5.12-smptimers/include/asm-sparc64/irq.h	Fri May  3 16:05:11 2002
@@ -114,7 +114,7 @@
 extern void disable_irq(unsigned int);
 #define disable_irq_nosync disable_irq
 extern void enable_irq(unsigned int);
-extern void init_timers(void (*lvl10_irq)(int, void *, struct pt_regs *),
+extern void sparc_init_timers(void (*lvl10_irq)(int, void *, struct pt_regs *),
 			unsigned long *);
 extern unsigned int build_irq(int pil, int inofixup, unsigned long iclr, unsigned long imap);
 extern unsigned int sbus_build_irq(void *sbus, unsigned int ino);
diff -urN linux-2.5.12-base/include/linux/interrupt.h linux-2.5.12-smptimers/include/linux/interrupt.h
--- linux-2.5.12-base/include/linux/interrupt.h	Wed May  1 05:38:44 2002
+++ linux-2.5.12-smptimers/include/linux/interrupt.h	Tue May 14 13:15:28 2002
@@ -225,6 +225,7 @@
 
 /* It is exported _ONLY_ for wait_on_irq(). */
 extern spinlock_t global_bh_lock;
+extern spinlock_t net_bh_lock;
 
 static inline void mark_bh(int nr)
 {
diff -urN linux-2.5.12-base/include/linux/smp.h linux-2.5.12-smptimers/include/linux/smp.h
--- linux-2.5.12-base/include/linux/smp.h	Wed May  1 05:38:59 2002
+++ linux-2.5.12-smptimers/include/linux/smp.h	Tue May 14 13:15:28 2002
@@ -78,7 +78,8 @@
 /*
  *	These macros fold the SMP functionality into a single CPU system
  */
- 
+
+#define NR_CPUS					1 
 #define smp_num_cpus				1
 #define smp_processor_id()			0
 #define hard_smp_processor_id()			0
diff -urN linux-2.5.12-base/include/linux/timer.h linux-2.5.12-smptimers/include/linux/timer.h
--- linux-2.5.12-base/include/linux/timer.h	Wed May  1 05:38:48 2002
+++ linux-2.5.12-smptimers/include/linux/timer.h	Tue May 14 13:15:28 2002
@@ -1,9 +1,6 @@
 #ifndef _LINUX_TIMER_H
 #define _LINUX_TIMER_H
 
-#include <linux/config.h>
-#include <linux/list.h>
-
 /*
  * In Linux 2.4, static timers have been removed from the kernel.
  * Timers may be dynamically created and destroyed, and should be initialized
@@ -13,22 +10,80 @@
  * timeouts. You can use this field to distinguish between the different
  * invocations.
  */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/cache.h>
+
+/*
+ * Event timer code
+ */
+#define TVN_BITS 6
+#define TVR_BITS 8
+#define TVN_SIZE (1 << TVN_BITS)
+#define TVR_SIZE (1 << TVR_BITS)
+#define TVN_MASK (TVN_SIZE - 1)
+#define TVR_MASK (TVR_SIZE - 1)
+
+typedef struct tvec_s {
+	int index;
+	struct list_head vec[TVN_SIZE];
+} tvec_t;
+
+typedef struct tvec_root_s {
+	int index;
+	struct list_head vec[TVR_SIZE];
+} tvec_root_t;
+
+#define NOOF_TVECS 5
+
+typedef struct timer_list timer_t;
+
+struct tvec_t_base_s {
+	spinlock_t lock;
+	unsigned long timer_jiffies;
+	volatile timer_t * volatile running_timer;
+	tvec_root_t tv1;
+	tvec_t tv2;
+	tvec_t tv3;
+	tvec_t tv4;
+	tvec_t tv5;
+} ____cacheline_aligned_in_smp;
+
+typedef struct tvec_t_base_s tvec_base_t;
+
+/*
+ * This is the new and improved way of handling timers.
+ *
+ * The "data" field is in case you want to use the same
+ * timeout function for several timeouts. You can use this
+ * to distinguish between the different invocations.
+ */
 struct timer_list {
 	struct list_head list;
 	unsigned long expires;
 	unsigned long data;
 	void (*function)(unsigned long);
+	tvec_base_t *base;
 };
 
-extern void add_timer(struct timer_list * timer);
-extern int del_timer(struct timer_list * timer);
+extern void add_timer(timer_t * timer);
+extern int del_timer(timer_t * timer);
 
 #ifdef CONFIG_SMP
-extern int del_timer_sync(struct timer_list * timer);
+extern int del_timer_sync(timer_t * timer);
 extern void sync_timers(void);
+#define timer_enter(base, t) do { base->running_timer = t; mb(); } while (0)
+#define timer_exit(base) do { base->running_timer = NULL; } while (0)
+#define timer_is_running(base,t) (base->running_timer == t)
+#define timer_synchronize(base,t) while (timer_is_running(base,t)) barrier()
 #else
 #define del_timer_sync(t)	del_timer(t)
 #define sync_timers()		do { } while (0)
+#define timer_enter(base,t)          do { } while (0)
+#define timer_exit(base)            do { } while (0)
 #endif
 
 /*
@@ -38,17 +93,38 @@
  * If the timer is known to be not pending (ie, in the handler), mod_timer
  * is less efficient than a->expires = b; add_timer(a).
  */
-int mod_timer(struct timer_list *timer, unsigned long expires);
+int mod_timer(timer_t *timer, unsigned long expires);
 
 extern void it_real_fn(unsigned long);
 
-static inline void init_timer(struct timer_list * timer)
+extern void init_timers(void);
+
+#ifdef CONFIG_SMP
+extern void run_local_timers(void);
+#else
+#define run_local_timers() do {} while(0)
+#endif
+
+extern tvec_base_t tvec_bases[NR_CPUS];
+
+static inline void init_timer(timer_t * timer)
 {
 	timer->list.next = timer->list.prev = NULL;
+	timer->base = tvec_bases + 0;
 }
 
-static inline int timer_pending (const struct timer_list * timer)
+#define TIMER_DEBUG 0
+#if TIMER_DEBUG
+# define CHECK_BASE(base) \
+	if (base && ((base < tvec_bases) || (base >= tvec_bases + NR_CPUS))) \
+		BUG()
+#else
+# define CHECK_BASE(base)
+#endif
+
+static inline int timer_pending(const timer_t * timer)
 {
+	CHECK_BASE(timer->base);
 	return timer->list.next != NULL;
 }
 
diff -urN linux-2.5.12-base/kernel/ksyms.c linux-2.5.12-smptimers/kernel/ksyms.c
--- linux-2.5.12-base/kernel/ksyms.c	Wed May  1 05:38:45 2002
+++ linux-2.5.12-smptimers/kernel/ksyms.c	Fri May  3 16:05:11 2002
@@ -402,6 +402,7 @@
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 EXPORT_SYMBOL(mod_timer);
+EXPORT_SYMBOL(tvec_bases);
 EXPORT_SYMBOL(tq_timer);
 EXPORT_SYMBOL(tq_immediate);
 
diff -urN linux-2.5.12-base/kernel/sched.c linux-2.5.12-smptimers/kernel/sched.c
--- linux-2.5.12-base/kernel/sched.c	Wed May  1 05:38:50 2002
+++ linux-2.5.12-smptimers/kernel/sched.c	Fri May  3 16:05:11 2002
@@ -1573,7 +1573,7 @@
 	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
 }
 
-extern void init_timervecs(void);
+extern void init_timers(void);
 extern void timer_bh(void);
 extern void tqueue_bh(void);
 extern void immediate_bh(void);
@@ -1612,8 +1612,7 @@
 	rq->idle = current;
 	wake_up_process(current);
 
-	init_timervecs();
-	init_bh(TIMER_BH, timer_bh);
+	init_timers();
 	init_bh(TQUEUE_BH, tqueue_bh);
 	init_bh(IMMEDIATE_BH, immediate_bh);
 
diff -urN linux-2.5.12-base/kernel/softirq.c linux-2.5.12-smptimers/kernel/softirq.c
--- linux-2.5.12-base/kernel/softirq.c	Wed May  1 05:38:50 2002
+++ linux-2.5.12-smptimers/kernel/softirq.c	Tue May 14 19:03:49 2002
@@ -43,6 +43,12 @@
 irq_cpustat_t irq_stat[NR_CPUS];
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
+/*
+ * This is required only to support single threaded network protocol
+ * code. (see net/core/dev.c) This should GO AWAY when those protocols
+ * are fixed.
+ */
+spinlock_t net_bh_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
diff -urN linux-2.5.12-base/kernel/timer.c linux-2.5.12-smptimers/kernel/timer.c
--- linux-2.5.12-base/kernel/timer.c	Wed May  1 05:38:51 2002
+++ linux-2.5.12-smptimers/kernel/timer.c	Tue May 14 13:21:26 2002
@@ -13,15 +13,21 @@
  *              serialize accesses to xtime/lost_ticks).
  *                              Copyright (C) 1998  Andrea Arcangeli
  *  1999-03-10  Improved NTP compatibility by Ulrich Windl
+ *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
+ *                              Copyright (C) 2000  Ingo Molnar
+ *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
  */
 
 #include <linux/config.h>
+
 #include <linux/mm.h>
+#include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/percpu.h>
 
 #include <asm/uaccess.h>
 
@@ -73,83 +79,51 @@
 unsigned long prof_len;
 unsigned long prof_shift;
 
-/*
- * Event timer code
- */
-#define TVN_BITS 6
-#define TVR_BITS 8
-#define TVN_SIZE (1 << TVN_BITS)
-#define TVR_SIZE (1 << TVR_BITS)
-#define TVN_MASK (TVN_SIZE - 1)
-#define TVR_MASK (TVR_SIZE - 1)
-
-struct timer_vec {
-	int index;
-	struct list_head vec[TVN_SIZE];
-};
-
-struct timer_vec_root {
-	int index;
-	struct list_head vec[TVR_SIZE];
-};
-
-static struct timer_vec tv5;
-static struct timer_vec tv4;
-static struct timer_vec tv3;
-static struct timer_vec tv2;
-static struct timer_vec_root tv1;
+tvec_base_t tvec_bases[NR_CPUS] __cacheline_aligned;
 
-static struct timer_vec * const tvecs[] = {
-	(struct timer_vec *)&tv1, &tv2, &tv3, &tv4, &tv5
-};
+static struct tasklet_struct timer_tasklet __per_cpu_data;
 
-#define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))
-
-void init_timervecs (void)
-{
-	int i;
-
-	for (i = 0; i < TVN_SIZE; i++) {
-		INIT_LIST_HEAD(tv5.vec + i);
-		INIT_LIST_HEAD(tv4.vec + i);
-		INIT_LIST_HEAD(tv3.vec + i);
-		INIT_LIST_HEAD(tv2.vec + i);
-	}
-	for (i = 0; i < TVR_SIZE; i++)
-		INIT_LIST_HEAD(tv1.vec + i);
-}
+/* jiffies at the most recent update of wall time */
+unsigned long wall_jiffies;
 
-static unsigned long timer_jiffies;
+/*
+ * This spinlock protect us from races in SMP while playing with xtime. -arca
+ */
+rwlock_t xtime_lock = RW_LOCK_UNLOCKED;
 
-static inline void internal_add_timer(struct timer_list *timer)
+/*
+ * This is the 'global' timer BH. This gets called only if one of
+ * the local timer interrupts couldnt run timers.
+ */
+static inline void internal_add_timer(tvec_base_t *base, timer_t *timer)
 {
 	/*
 	 * must be cli-ed when calling this
 	 */
 	unsigned long expires = timer->expires;
-	unsigned long idx = expires - timer_jiffies;
+	unsigned long idx = expires - base->timer_jiffies;
 	struct list_head * vec;
 
 	if (idx < TVR_SIZE) {
 		int i = expires & TVR_MASK;
-		vec = tv1.vec + i;
+		vec = base->tv1.vec + i;
 	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
 		int i = (expires >> TVR_BITS) & TVN_MASK;
-		vec = tv2.vec + i;
+		vec = base->tv2.vec + i;
 	} else if (idx < 1 << (TVR_BITS + 2 * TVN_BITS)) {
 		int i = (expires >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
-		vec =  tv3.vec + i;
+		vec = base->tv3.vec + i;
 	} else if (idx < 1 << (TVR_BITS + 3 * TVN_BITS)) {
 		int i = (expires >> (TVR_BITS + 2 * TVN_BITS)) & TVN_MASK;
-		vec = tv4.vec + i;
+		vec = base->tv4.vec + i;
 	} else if ((signed long) idx < 0) {
 		/* can happen if you add a timer with expires == jiffies,
 		 * or you set a timer to go off in the past
 		 */
-		vec = tv1.vec + tv1.index;
+		vec = base->tv1.vec + base->tv1.index;
 	} else if (idx <= 0xffffffffUL) {
 		int i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
-		vec = tv5.vec + i;
+		vec = base->tv5.vec + i;
 	} else {
 		/* Can only get here on architectures with 64-bit jiffies */
 		INIT_LIST_HEAD(&timer->list);
@@ -161,37 +135,27 @@
 	list_add(&timer->list, vec->prev);
 }
 
-/* Initialize both explicitly - let's try to have them in the same cache line */
-spinlock_t timerlist_lock = SPIN_LOCK_UNLOCKED;
-
-#ifdef CONFIG_SMP
-volatile struct timer_list * volatile running_timer;
-#define timer_enter(t) do { running_timer = t; mb(); } while (0)
-#define timer_exit() do { running_timer = NULL; } while (0)
-#define timer_is_running(t) (running_timer == t)
-#define timer_synchronize(t) while (timer_is_running(t)) barrier()
-#else
-#define timer_enter(t)		do { } while (0)
-#define timer_exit()		do { } while (0)
-#endif
-
-void add_timer(struct timer_list *timer)
+void add_timer(timer_t *timer)
 {
+	tvec_base_t * base = tvec_bases + smp_processor_id();
 	unsigned long flags;
 
-	spin_lock_irqsave(&timerlist_lock, flags);
+	CHECK_BASE(base);
+	CHECK_BASE(timer->base);
+	spin_lock_irqsave(&base->lock, flags);
 	if (timer_pending(timer))
 		goto bug;
-	internal_add_timer(timer);
-	spin_unlock_irqrestore(&timerlist_lock, flags);
+	internal_add_timer(base, timer);
+	timer->base = base;
+	spin_unlock_irqrestore(&base->lock, flags);
 	return;
 bug:
-	spin_unlock_irqrestore(&timerlist_lock, flags);
+	spin_unlock_irqrestore(&base->lock, flags);
 	printk("bug: kernel timer added twice at %p.\n",
 			__builtin_return_address(0));
 }
 
-static inline int detach_timer (struct timer_list *timer)
+static inline int detach_timer(timer_t *timer)
 {
 	if (!timer_pending(timer))
 		return 0;
@@ -199,28 +163,81 @@
 	return 1;
 }
 
-int mod_timer(struct timer_list *timer, unsigned long expires)
+/*
+ * mod_timer() has subtle locking semantics because parallel
+ * calls to it must happen serialized.
+ */
+int mod_timer(timer_t *timer, unsigned long expires)
 {
-	int ret;
+	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
+	int ret;
+
+	new_base = tvec_bases + smp_processor_id();
+	CHECK_BASE(new_base);
+
+	__save_flags(flags);
+	__cli();
+repeat:
+	old_base = timer->base;
+	CHECK_BASE(old_base);
+
+	/*
+	 * Prevent deadlocks via ordering by old_base < new_base.
+	 */
+	if (old_base && (new_base != old_base)) {
+		if (old_base < new_base) {
+			spin_lock(&new_base->lock);
+			spin_lock(&old_base->lock);
+		} else {
+			spin_lock(&old_base->lock);
+			spin_lock(&new_base->lock);
+		}
+		/*
+		 * Subtle, we rely on timer->base being always
+		 * valid and being updated atomically.
+		 */
+		if (timer->base != old_base) {
+			spin_unlock(&new_base->lock);
+			spin_unlock(&old_base->lock);
+			goto repeat;
+		}
+	} else
+		spin_lock(&new_base->lock);
 
-	spin_lock_irqsave(&timerlist_lock, flags);
 	timer->expires = expires;
 	ret = detach_timer(timer);
-	internal_add_timer(timer);
-	spin_unlock_irqrestore(&timerlist_lock, flags);
+	internal_add_timer(new_base, timer);
+	timer->base = new_base;
+
+
+	if (old_base && (new_base != old_base))
+		spin_unlock(&old_base->lock);
+	spin_unlock_irqrestore(&new_base->lock, flags);
+
 	return ret;
 }
 
-int del_timer(struct timer_list * timer)
+int del_timer(timer_t * timer)
 {
-	int ret;
 	unsigned long flags;
+	tvec_base_t * base;
+	int ret;
 
-	spin_lock_irqsave(&timerlist_lock, flags);
+	CHECK_BASE(timer->base);
+	if (!timer->base)
+		return 0;
+repeat:
+ 	base = timer->base;
+	spin_lock_irqsave(&base->lock, flags);
+	if (base != timer->base) {
+		spin_unlock_irqrestore(&base->lock, flags);
+		goto repeat;
+	}
 	ret = detach_timer(timer);
 	timer->list.next = timer->list.prev = NULL;
-	spin_unlock_irqrestore(&timerlist_lock, flags);
+	spin_unlock_irqrestore(&base->lock, flags);
+
 	return ret;
 }
 
@@ -238,24 +255,34 @@
  * (for reference counting).
  */
 
-int del_timer_sync(struct timer_list * timer)
+int del_timer_sync(timer_t * timer)
 {
+	tvec_base_t * base;
 	int ret = 0;
 
+	CHECK_BASE(timer->base);
+	if (!timer->base)
+		return 0;
 	for (;;) {
 		unsigned long flags;
 		int running;
 
-		spin_lock_irqsave(&timerlist_lock, flags);
+repeat:
+	 	base = timer->base;
+		spin_lock_irqsave(&base->lock, flags);
+		if (base != timer->base) {
+			spin_unlock_irqrestore(&base->lock, flags);
+			goto repeat;
+		}
 		ret += detach_timer(timer);
 		timer->list.next = timer->list.prev = 0;
-		running = timer_is_running(timer);
-		spin_unlock_irqrestore(&timerlist_lock, flags);
+		running = timer_is_running(base, timer);
+		spin_unlock_irqrestore(&base->lock, flags);
 
 		if (!running)
 			break;
 
-		timer_synchronize(timer);
+		timer_synchronize(base, timer);
 	}
 
 	return ret;
@@ -263,7 +290,7 @@
 #endif
 
 
-static inline void cascade_timers(struct timer_vec *tv)
+static void cascade(tvec_base_t *base, tvec_t *tv)
 {
 	/* cascade all the timers from tv up one level */
 	struct list_head *head, *curr, *next;
@@ -275,54 +302,68 @@
 	 * detach them individually, just clear the list afterwards.
 	 */
 	while (curr != head) {
-		struct timer_list *tmp;
+		timer_t *tmp;
 
-		tmp = list_entry(curr, struct timer_list, list);
+		tmp = list_entry(curr, timer_t, list);
+		CHECK_BASE(tmp->base);
+		if (tmp->base != base)
+			BUG();
 		next = curr->next;
 		list_del(curr); // not needed
-		internal_add_timer(tmp);
+		internal_add_timer(base, tmp);
 		curr = next;
 	}
 	INIT_LIST_HEAD(head);
 	tv->index = (tv->index + 1) & TVN_MASK;
 }
 
-static inline void run_timer_list(void)
+static void __run_timers(tvec_base_t *base)
 {
-	spin_lock_irq(&timerlist_lock);
-	while ((long)(jiffies - timer_jiffies) >= 0) {
+	unsigned long flags;
+
+	spin_lock_irqsave(&base->lock, flags);
+	while ((long)(jiffies - base->timer_jiffies) >= 0) {
 		struct list_head *head, *curr;
-		if (!tv1.index) {
-			int n = 1;
-			do {
-				cascade_timers(tvecs[n]);
-			} while (tvecs[n]->index == 1 && ++n < NOOF_TVECS);
+
+		/*
+		 * Cascade timers:
+		 */
+		if (!base->tv1.index) {
+			cascade(base, &base->tv2);
+			if (base->tv2.index == 1) {
+				cascade(base, &base->tv3);
+				if (base->tv3.index == 1) {
+					cascade(base, &base->tv4);
+					if (base->tv4.index == 1)
+						cascade(base, &base->tv5);
+				}
+			}
 		}
 repeat:
-		head = tv1.vec + tv1.index;
+		head = base->tv1.vec + base->tv1.index;
 		curr = head->next;
 		if (curr != head) {
-			struct timer_list *timer;
 			void (*fn)(unsigned long);
 			unsigned long data;
+			timer_t *timer;
 
-			timer = list_entry(curr, struct timer_list, list);
+			timer = list_entry(curr, timer_t, list);
  			fn = timer->function;
- 			data= timer->data;
+ 			data = timer->data;
 
 			detach_timer(timer);
 			timer->list.next = timer->list.prev = NULL;
-			timer_enter(timer);
-			spin_unlock_irq(&timerlist_lock);
+			timer_enter(base, timer);
+			spin_unlock_irq(&base->lock);
 			fn(data);
-			spin_lock_irq(&timerlist_lock);
-			timer_exit();
+			spin_lock_irq(&base->lock);
+			timer_exit(base);
 			goto repeat;
 		}
-		++timer_jiffies; 
-		tv1.index = (tv1.index + 1) & TVR_MASK;
+		++base->timer_jiffies; 
+		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 	}
-	spin_unlock_irq(&timerlist_lock);
+	spin_unlock_irqrestore(&base->lock, flags);
 }
 
 spinlock_t tqueue_lock = SPIN_LOCK_UNLOCKED;
@@ -628,40 +669,106 @@
 	}
 }
 
-/* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+#ifdef CONFIG_SMP
+
+static void run_timer_tasklet(unsigned long data)
+{
+        int cpu = smp_processor_id();
+	tvec_base_t *base = tvec_bases + cpu;
+
+        if (!spin_trylock(&global_bh_lock))
+                goto resched;
+
+        if (!spin_trylock(&net_bh_lock))
+                goto resched_net;
+
+        if (!hardirq_trylock(cpu))
+                goto resched_unlock;
+
+	if ((long)(jiffies - base->timer_jiffies) >= 0)
+		__run_timers(base);
+
+        hardirq_endlock(cpu);
+        spin_unlock(&global_bh_lock);
+        return;
+resched_net:
+        spin_unlock(&net_bh_lock);
+resched_unlock:
+        spin_unlock(&global_bh_lock);
+resched:
+	tasklet_hi_schedule(&per_cpu(timer_tasklet, cpu));
+}
 
 /*
- * This spinlock protect us from races in SMP while playing with xtime. -arca
+ * Called by the local, per-CPU timer interrupt on SMP.
+ *
+ * This function has to do all sorts of locking to make legacy
+ * cli()-users and BH-disablers work. If locking doesnt succeed
+ * now then we fall back to TIMER_BH.
  */
-rwlock_t xtime_lock = RW_LOCK_UNLOCKED;
+void run_local_timers(void)
+{
+	int cpu = smp_processor_id();
+	tvec_base_t *base = tvec_bases + cpu;
+
+	if (in_interrupt())
+		goto out_mark;
+
+	local_bh_disable();
+	local_irq_disable();
+	if (!spin_trylock(&global_bh_lock))
+		goto out_enable_mark;
+        if (!spin_trylock(&net_bh_lock))
+                goto out_unlock_net;
+
+	if (!hardirq_trylock(cpu))
+		goto out_unlock_enable_mark;
+
+	if ((long)(jiffies - base->timer_jiffies) >= 0)
+		__run_timers(base);
+
+	hardirq_endlock(cpu);
+	spin_unlock(&global_bh_lock);
+	local_irq_enable();
+	local_bh_enable();
+	return;
+out_unlock_net:
+	spin_unlock(&net_bh_lock);
+out_unlock_enable_mark:
+	spin_unlock(&global_bh_lock);
+
+out_enable_mark:
+	local_irq_enable();
+	local_bh_enable();
 
-static inline void update_times(void)
+out_mark:
+	tasklet_hi_schedule(&per_cpu(timer_tasklet, cpu));
+}
+#else
+static void run_timer_tasklet(unsigned long data)
 {
-	unsigned long ticks;
+	tvec_base_t *base = tvec_bases + smp_processor_id();
+	if ((long)(jiffies - base->timer_jiffies) >= 0)
+		__run_timers(base);
+}
+#endif
 
-	/*
-	 * update_times() is run from the raw timer_bh handler so we
-	 * just know that the irqs are locally enabled and so we don't
-	 * need to save/restore the flags of the local CPU here. -arca
-	 */
-	write_lock_irq(&xtime_lock);
+/*
+ * Called by the timer interrupt. xtime_lock must already be taken
+ * by the timer IRQ!
+ */
+static void update_times(void)
+{
+	unsigned long ticks;
 
 	ticks = jiffies - wall_jiffies;
 	if (ticks) {
 		wall_jiffies += ticks;
 		update_wall_time(ticks);
 	}
-	write_unlock_irq(&xtime_lock);
 	calc_load(ticks);
 }
 
-void timer_bh(void)
-{
-	update_times();
-	run_timer_list();
-}
-
 void do_timer(struct pt_regs *regs)
 {
 	(*(unsigned long *)&jiffies)++;
@@ -669,8 +776,9 @@
 	/* SMP process accounting uses the local APIC timer */
 
 	update_process_times(user_mode(regs));
+	tasklet_hi_schedule(&this_cpu(timer_tasklet));
 #endif
-	mark_bh(TIMER_BH);
+	update_times();
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
@@ -915,3 +1023,24 @@
 	return 0;
 }
 
+void __init init_timers(void)
+{
+	int i, j;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		tvec_base_t *base = tvec_bases + i;
+
+		spin_lock_init(&base->lock);
+		for (j = 0; j < TVN_SIZE; j++) {
+			INIT_LIST_HEAD(base->tv5.vec + j);
+			INIT_LIST_HEAD(base->tv4.vec + j);
+			INIT_LIST_HEAD(base->tv3.vec + j);
+			INIT_LIST_HEAD(base->tv2.vec + j);
+		}
+		for (j = 0; j < TVR_SIZE; j++)
+			INIT_LIST_HEAD(base->tv1.vec + j);
+		tasklet_init(&per_cpu(timer_tasklet, cpu_logical_map(i)), 
+							run_timer_tasklet, 0);
+	}
+}
+
diff -urN linux-2.5.12-base/lib/bust_spinlocks.c linux-2.5.12-smptimers/lib/bust_spinlocks.c
--- linux-2.5.12-base/lib/bust_spinlocks.c	Wed May  1 05:38:49 2002
+++ linux-2.5.12-smptimers/lib/bust_spinlocks.c	Fri May  3 21:54:58 2002
@@ -14,11 +14,9 @@
 #include <linux/wait.h>
 #include <linux/vt_kern.h>
 
-extern spinlock_t timerlist_lock;
 
 void bust_spinlocks(int yes)
 {
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
diff -urN linux-2.5.12-base/net/core/dev.c linux-2.5.12-smptimers/net/core/dev.c
--- linux-2.5.12-base/net/core/dev.c	Wed May  1 05:38:58 2002
+++ linux-2.5.12-smptimers/net/core/dev.c	Tue May 14 13:06:47 2002
@@ -1291,7 +1291,6 @@
  */
 static int deliver_to_old_ones(struct packet_type *pt, struct sk_buff *skb, int last)
 {
-	static spinlock_t net_bh_lock = SPIN_LOCK_UNLOCKED;
 	int ret = NET_RX_DROP;
 
 
@@ -1311,13 +1310,7 @@
 
 	/* Emulate NET_BH with special spinlock */
 	spin_lock(&net_bh_lock);
-
-	/* Disable timers and wait for all timers completion */
-	tasklet_disable(bh_task_vec+TIMER_BH);
-
 	ret = pt->func(skb, skb->dev, pt);
-
-	tasklet_hi_enable(bh_task_vec+TIMER_BH);
 	spin_unlock(&net_bh_lock);
 	return ret;
 }

--wRRV7LY7NUeQGEoC--
