Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbSIXJuq>; Tue, 24 Sep 2002 05:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbSIXJuq>; Tue, 24 Sep 2002 05:50:46 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:12250 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261630AbSIXJuX>;
	Tue, 24 Sep 2002 05:50:23 -0400
Date: Tue, 24 Sep 2002 15:29:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, davem@redhat.com, jgarzik@mandrakesoft.com,
       zaitcev@redhat.com
Cc: Andrew Morton <akpm@zip.com.au>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: on 2.5.38-mm2 tbench 64 smptimers shows 30% improvement
Message-ID: <20020924152921.A4085@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020924081340.GD6070@holomorphy.com> <20020924083606.GF6070@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020924083606.GF6070@holomorphy.com>; from wli@holomorphy.com on Tue, Sep 24, 2002 at 08:39:59AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 08:39:59AM +0000, William Lee Irwin III wrote:
> As tested on a 32x NUMA-Q with 32GB of RAM. Here is a demonstration of
> a 30% throughput improvement with smptimers over mainline for tbench 64.
> This gain is substantial enough I believe it a significant motive for
> its inclusion in mainline. Furthermore, gains in terms of reduced system
> time and general expense of timer manipulations are visible on smaller
> systems and less network-intensive workloads.
> 

wli ported smptimers_X3 (Ingo's smptimers A0 + my embellishments for 2.5)
to 2.5.38-mm2 and I am including that patch below. Ingo, would you
push this or any version of smptimers to Linus ?

The core smptimers implementation from Ingo remains as is. The things
that I changed over time are -

1. run_local_timers() is now run from scheduler_tick(). This avoids
having to modify arch-dependent code (local timer interrupt handlers).
run_local_timers() just schedules a per-CPU tasklet to do the
actual timer processing, in that sense it is similar to old TIMER_BH.

2. With global clis gone, locking in timer processing is simpler.
It serializes against BHs using global_bh_lock and old NET_BH
code (?) using net_bh_lock (see deliver_old_ones()). There may
be more to it that I missed completely.

3. The TIMER_BH has been removed completely. If locking fails
(can't get global_bh_lock or net_bh_lock), we
just reschedule the per-CPU tasklet. This is analogus to what
TIMER_BH did earlier.

4. Removal of TIMER_BH breaks sparc32 gettimeofday implementation
that depends on it. I don't have any clue how to fix this. Zaitcev,
is this something that you maintain ?

5. I added akpm's check for timer not changing in mod_timer().

Lastly, here are some profile comparisons from a webserver benchmark -

2.5.34-vanilla
--------------
  4055 add_timer                                 16.6189
 14876 mod_timer                                 59.0317
  1507 del_timer                                 17.9405
  2567 del_timer_sync                            17.3446
  1828 timer_bh                                   2.5819

2.5.34-smptimers_X2
-------------------
   877 add_timer                                  3.0034
 10656 mod_timer                                 28.3404
  1034 del_timer                                  8.6167
  1698 del_timer_sync                            11.4730
    55 __run_timers                               0.2022
    26 run_timer_tasklet                          0.1444

This is without akpm's mod_timer() change.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

smptimers-2.5.38-mm2.patch
--------------------------

diff -urN linux-2.5.36-base/arch/i386/mm/fault.c linux-2.5.36-smptimers_X3/arch/i386/mm/fault.c
--- linux-2.5.36-base/arch/i386/mm/fault.c	Wed Sep 18 06:28:41 2002
+++ linux-2.5.36-smptimers_X3/arch/i386/mm/fault.c	Wed Sep 18 16:13:23 2002
@@ -99,18 +99,14 @@
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
 	int loglevel_save = console_loglevel;
 
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 		return;
diff -urN linux-2.5.36-base/arch/ia64/kernel/traps.c linux-2.5.36-smptimers_X3/arch/ia64/kernel/traps.c
--- linux-2.5.36-base/arch/ia64/kernel/traps.c	Wed Sep 18 06:29:18 2002
+++ linux-2.5.36-smptimers_X3/arch/ia64/kernel/traps.c	Wed Sep 18 16:13:23 2002
@@ -42,7 +42,6 @@
 
 #include <asm/fpswa.h>
 
-extern spinlock_t timerlist_lock;
 
 static fpswa_interface_t *fpswa_interface;
 
@@ -61,7 +60,7 @@
 }
 
 /*
- * Unlock any spinlocks which will prevent us from getting the message out (timerlist_lock
+ * Unlock any spinlocks which will prevent us from getting the message out
  * is acquired through the console unblank code)
  */
 void
@@ -69,7 +68,6 @@
 {
 	int loglevel_save = console_loglevel;
 
-	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
 		return;
diff -urN linux-2.5.36-base/arch/mips64/mm/fault.c linux-2.5.36-smptimers_X3/arch/mips64/mm/fault.c
--- linux-2.5.36-base/arch/mips64/mm/fault.c	Wed Sep 18 06:28:59 2002
+++ linux-2.5.36-smptimers_X3/arch/mips64/mm/fault.c	Wed Sep 18 16:13:23 2002
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
diff -urN linux-2.5.36-base/arch/s390/mm/fault.c linux-2.5.36-smptimers_X3/arch/s390/mm/fault.c
--- linux-2.5.36-base/arch/s390/mm/fault.c	Wed Sep 18 06:29:09 2002
+++ linux-2.5.36-smptimers_X3/arch/s390/mm/fault.c	Wed Sep 18 16:13:23 2002
@@ -37,16 +37,13 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
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
diff -urN linux-2.5.36-base/arch/s390x/mm/fault.c linux-2.5.36-smptimers_X3/arch/s390x/mm/fault.c
--- linux-2.5.36-base/arch/s390x/mm/fault.c	Wed Sep 18 06:28:51 2002
+++ linux-2.5.36-smptimers_X3/arch/s390x/mm/fault.c	Wed Sep 18 16:13:23 2002
@@ -36,16 +36,13 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
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
diff -urN linux-2.5.36-base/arch/sparc/kernel/irq.c linux-2.5.36-smptimers_X3/arch/sparc/kernel/irq.c
--- linux-2.5.36-base/arch/sparc/kernel/irq.c	Wed Sep 18 06:28:43 2002
+++ linux-2.5.36-smptimers_X3/arch/sparc/kernel/irq.c	Wed Sep 18 16:13:23 2002
@@ -75,7 +75,7 @@
     prom_halt();
 }
 
-void (*init_timers)(void (*)(int, void *,struct pt_regs *)) =
+void (*sparc_init_timers)(void (*)(int, void *,struct pt_regs *)) =
     (void (*)(void (*)(int, void *,struct pt_regs *))) irq_panic;
 
 /*
diff -urN linux-2.5.36-base/arch/sparc/kernel/sun4c_irq.c linux-2.5.36-smptimers_X3/arch/sparc/kernel/sun4c_irq.c
--- linux-2.5.36-base/arch/sparc/kernel/sun4c_irq.c	Wed Sep 18 06:28:44 2002
+++ linux-2.5.36-smptimers_X3/arch/sparc/kernel/sun4c_irq.c	Wed Sep 18 16:13:23 2002
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
diff -urN linux-2.5.36-base/arch/sparc/kernel/sun4d_irq.c linux-2.5.36-smptimers_X3/arch/sparc/kernel/sun4d_irq.c
--- linux-2.5.36-base/arch/sparc/kernel/sun4d_irq.c	Wed Sep 18 06:28:40 2002
+++ linux-2.5.36-smptimers_X3/arch/sparc/kernel/sun4d_irq.c	Wed Sep 18 16:13:23 2002
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
diff -urN linux-2.5.36-base/arch/sparc/kernel/sun4m_irq.c linux-2.5.36-smptimers_X3/arch/sparc/kernel/sun4m_irq.c
--- linux-2.5.36-base/arch/sparc/kernel/sun4m_irq.c	Wed Sep 18 06:28:58 2002
+++ linux-2.5.36-smptimers_X3/arch/sparc/kernel/sun4m_irq.c	Wed Sep 18 16:13:23 2002
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
diff -urN linux-2.5.36-base/arch/sparc/kernel/time.c linux-2.5.36-smptimers_X3/arch/sparc/kernel/time.c
--- linux-2.5.36-base/arch/sparc/kernel/time.c	Wed Sep 18 06:28:59 2002
+++ linux-2.5.36-smptimers_X3/arch/sparc/kernel/time.c	Wed Sep 18 16:13:23 2002
@@ -386,7 +386,7 @@
 	else
 		clock_probe();
 
-	init_timers(timer_interrupt);
+	sparc_init_timers(timer_interrupt);
 	
 #ifdef CONFIG_SUN4
 	if(idprom->id_machtype == (SM_SUN4 | SM_4_330)) {
diff -urN linux-2.5.36-base/arch/sparc64/kernel/irq.c linux-2.5.36-smptimers_X3/arch/sparc64/kernel/irq.c
--- linux-2.5.36-base/arch/sparc64/kernel/irq.c	Wed Sep 18 06:29:18 2002
+++ linux-2.5.36-smptimers_X3/arch/sparc64/kernel/irq.c	Wed Sep 18 16:13:23 2002
@@ -950,7 +950,7 @@
 }
 
 /* This is gets the master TICK_INT timer going. */
-void init_timers(void (*cfunc)(int, void *, struct pt_regs *),
+void sparc_init_timers(void (*cfunc)(int, void *, struct pt_regs *),
 		 unsigned long *clock)
 {
 	unsigned long pstate;
diff -urN linux-2.5.36-base/arch/sparc64/kernel/time.c linux-2.5.36-smptimers_X3/arch/sparc64/kernel/time.c
--- linux-2.5.36-base/arch/sparc64/kernel/time.c	Wed Sep 18 06:28:58 2002
+++ linux-2.5.36-smptimers_X3/arch/sparc64/kernel/time.c	Wed Sep 18 16:13:23 2002
@@ -617,7 +617,7 @@
 	local_irq_restore(flags);
 }
 
-extern void init_timers(void (*func)(int, void *, struct pt_regs *),
+extern void sparc_init_timers(void (*func)(int, void *, struct pt_regs *),
 			unsigned long *);
 
 void __init time_init(void)
@@ -628,7 +628,7 @@
 	 */
 	unsigned long clock;
 
-	init_timers(timer_interrupt, &clock);
+	sparc_init_timers(timer_interrupt, &clock);
 	timer_ticks_per_usec_quotient = ((1UL<<32) / (clock / 1000020));
 }
 
diff -urN linux-2.5.36-base/arch/x86_64/mm/fault.c linux-2.5.36-smptimers_X3/arch/x86_64/mm/fault.c
--- linux-2.5.36-base/arch/x86_64/mm/fault.c	Wed Sep 18 06:28:42 2002
+++ linux-2.5.36-smptimers_X3/arch/x86_64/mm/fault.c	Wed Sep 18 16:13:23 2002
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
diff -urN linux-2.5.36-base/drivers/net/eepro100.c linux-2.5.36-smptimers_X3/drivers/net/eepro100.c
--- linux-2.5.36-base/drivers/net/eepro100.c	Wed Sep 18 06:29:00 2002
+++ linux-2.5.36-smptimers_X3/drivers/net/eepro100.c	Wed Sep 18 16:13:23 2002
@@ -1173,9 +1173,6 @@
 	/* We must continue to monitor the media. */
 	sp->timer.expires = RUN_AT(2*HZ); 			/* 2.0 sec. */
 	add_timer(&sp->timer);
-#if defined(timer_exit)
-	timer_exit(&sp->timer);
-#endif
 }
 
 static void speedo_show_state(struct net_device *dev)
diff -urN linux-2.5.36-base/include/asm-sparc/irq.h linux-2.5.36-smptimers_X3/include/asm-sparc/irq.h
--- linux-2.5.36-base/include/asm-sparc/irq.h	Wed Sep 18 06:28:41 2002
+++ linux-2.5.36-smptimers_X3/include/asm-sparc/irq.h	Wed Sep 18 16:13:23 2002
@@ -47,7 +47,7 @@
 #define clear_profile_irq(cpu) BTFIXUP_CALL(clear_profile_irq)(cpu)
 #define load_profile_irq(cpu,limit) BTFIXUP_CALL(load_profile_irq)(cpu,limit)
 
-extern void (*init_timers)(void (*lvl10_irq)(int, void *, struct pt_regs *));
+extern void (*sparc_init_timers)(void (*lvl10_irq)(int, void *, struct pt_regs *));
 extern void claim_ticker14(void (*irq_handler)(int, void *, struct pt_regs *),
 			   int irq,
 			   unsigned int timeout);
diff -urN linux-2.5.36-base/include/asm-sparc64/irq.h linux-2.5.36-smptimers_X3/include/asm-sparc64/irq.h
--- linux-2.5.36-base/include/asm-sparc64/irq.h	Wed Sep 18 06:28:59 2002
+++ linux-2.5.36-smptimers_X3/include/asm-sparc64/irq.h	Wed Sep 18 16:13:23 2002
@@ -116,7 +116,7 @@
 extern void disable_irq(unsigned int);
 #define disable_irq_nosync disable_irq
 extern void enable_irq(unsigned int);
-extern void init_timers(void (*lvl10_irq)(int, void *, struct pt_regs *),
+extern void sparc_init_timers(void (*lvl10_irq)(int, void *, struct pt_regs *),
 			unsigned long *);
 extern unsigned int build_irq(int pil, int inofixup, unsigned long iclr, unsigned long imap);
 extern unsigned int sbus_build_irq(void *sbus, unsigned int ino);
diff -urN linux-2.5.36-base/include/linux/interrupt.h linux-2.5.36-smptimers_X3/include/linux/interrupt.h
--- linux-2.5.36-base/include/linux/interrupt.h	Wed Sep 18 06:28:59 2002
+++ linux-2.5.36-smptimers_X3/include/linux/interrupt.h	Wed Sep 18 16:13:23 2002
@@ -27,7 +27,6 @@
    should come first */
    
 enum {
-	TIMER_BH = 0,
 	TQUEUE_BH = 1,
 	DIGI_BH = 2,
 	SERIAL_BH = 3,
diff -urN linux-2.5.36-base/include/linux/timer.h linux-2.5.36-smptimers_X3/include/linux/timer.h
--- linux-2.5.36-base/include/linux/timer.h	Wed Sep 18 06:28:47 2002
+++ linux-2.5.36-smptimers_X3/include/linux/timer.h	Wed Sep 18 16:13:23 2002
@@ -2,8 +2,48 @@
 #define _LINUX_TIMER_H
 
 #include <linux/config.h>
+#include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/list.h>
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
 
 /*
  * In Linux 2.4, static timers have been removed from the kernel.
@@ -19,17 +59,27 @@
 	unsigned long expires;
 	unsigned long data;
 	void (*function)(unsigned long);
+	tvec_base_t *base;
 };
 
-extern void add_timer(struct timer_list * timer);
-extern int del_timer(struct timer_list * timer);
-
+extern spinlock_t net_bh_lock;
+extern void add_timer(timer_t * timer);
+extern int del_timer(timer_t * timer);
+  
 #ifdef CONFIG_SMP
-extern int del_timer_sync(struct timer_list * timer);
+extern int del_timer_sync(timer_t * timer);
+extern void sync_timers(void);
+#define timer_enter(base, t) do { base->running_timer = t; mb(); } while (0)
+#define timer_exit(base) do { base->running_timer = NULL; } while (0)
+#define timer_is_running(base,t) (base->running_timer == t)
+#define timer_synchronize(base,t) while (timer_is_running(base,t)) barrier()
 #else
 #define del_timer_sync(t)	del_timer(t)
+#define sync_timers()		do { } while (0)
+#define timer_enter(base,t)          do { } while (0)
+#define timer_exit(base)            do { } while (0)
 #endif
-
+  
 /*
  * mod_timer is a more efficient way to update the expire field of an
  * active timer (if the timer is inactive it will be activated)
@@ -37,17 +87,33 @@
  * If the timer is known to be not pending (ie, in the handler), mod_timer
  * is less efficient than a->expires = b; add_timer(a).
  */
-int mod_timer(struct timer_list *timer, unsigned long expires);
+int mod_timer(timer_t *timer, unsigned long expires);
 
 extern void it_real_fn(unsigned long);
 
-static inline void init_timer(struct timer_list * timer)
+extern void init_timers(void);
+extern void run_local_timers(void);
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
 
diff -urN linux-2.5.36-base/kernel/ksyms.c linux-2.5.36-smptimers_X3/kernel/ksyms.c
--- linux-2.5.36-base/kernel/ksyms.c	Wed Sep 18 06:28:42 2002
+++ linux-2.5.36-smptimers_X3/kernel/ksyms.c	Wed Sep 18 16:13:23 2002
@@ -414,6 +414,7 @@
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 EXPORT_SYMBOL(mod_timer);
+EXPORT_SYMBOL(tvec_bases);
 EXPORT_SYMBOL(tq_timer);
 EXPORT_SYMBOL(tq_immediate);
 
diff -urN linux-2.5.36-base/kernel/sched.c linux-2.5.36-smptimers_X3/kernel/sched.c
--- linux-2.5.36-base/kernel/sched.c	Wed Sep 18 06:28:48 2002
+++ linux-2.5.36-smptimers_X3/kernel/sched.c	Wed Sep 18 16:13:23 2002
@@ -29,6 +29,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/rcupdate.h>
+#include <linux/timer.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -858,6 +859,7 @@
 
 	if (rcpu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
+	run_local_timers();
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
@@ -2090,7 +2092,7 @@
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 #endif
 
-extern void init_timervecs(void);
+extern void init_timers(void);
 extern void timer_bh(void);
 extern void tqueue_bh(void);
 extern void immediate_bh(void);
@@ -2129,8 +2131,7 @@
 	set_task_cpu(current, smp_processor_id());
 	wake_up_process(current);
 
-	init_timervecs();
-	init_bh(TIMER_BH, timer_bh);
+	init_timers();
 	init_bh(TQUEUE_BH, tqueue_bh);
 	init_bh(IMMEDIATE_BH, immediate_bh);
 
diff -urN linux-2.5.36-base/kernel/timer.c linux-2.5.36-smptimers_X3/kernel/timer.c
--- linux-2.5.36-base/kernel/timer.c	Wed Sep 18 06:28:50 2002
+++ linux-2.5.36-smptimers_X3/kernel/timer.c	Wed Sep 18 16:13:23 2002
@@ -14,9 +14,13 @@
  *                              Copyright (C) 1998  Andrea Arcangeli
  *  1999-03-10  Improved NTP compatibility by Ulrich Windl
  *  2002-05-31	Move sys_sysinfo here and make its locking sane, Robert Love
+ *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
+ *                              Copyright (C) 2000  Ingo Molnar
+ *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
  */
 
 #include <linux/config.h>
+#include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/timex.h>
 #include <linux/delay.h>
@@ -24,9 +28,12 @@
 #include <linux/interrupt.h>
 #include <linux/tqueue.h>
 #include <linux/kernel_stat.h>
+#include <linux/percpu.h>
 
 #include <asm/uaccess.h>
 
+spinlock_t net_bh_lock = SPIN_LOCK_UNLOCKED;
+
 struct kernel_stat kstat;
 
 /*
@@ -80,83 +87,44 @@
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
-
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
+/* Fake initialization needed to avoid compiler breakage */
+static DEFINE_PER_CPU(struct tasklet_struct, timer_tasklet) = { NULL };
 
-static unsigned long timer_jiffies;
-
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
@@ -168,34 +136,24 @@
 	list_add(&timer->list, vec->prev);
 }
 
-/* Initialize both explicitly - let's try to have them in the same cache line */
-spinlock_t timerlist_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
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
-	unsigned long flags;
-
-	spin_lock_irqsave(&timerlist_lock, flags);
-	if (unlikely(timer_pending(timer)))
-		goto bug;
-	internal_add_timer(timer);
-	spin_unlock_irqrestore(&timerlist_lock, flags);
-	return;
+	tvec_base_t * base = tvec_bases + smp_processor_id();
+  	unsigned long flags;
+  
+	CHECK_BASE(base);
+	CHECK_BASE(timer->base);
+	spin_lock_irqsave(&base->lock, flags);
+  	if (unlikely(timer_pending(timer)))
+  		goto bug;
+	internal_add_timer(base, timer);
+	timer->base = base;
+	spin_unlock_irqrestore(&base->lock, flags);
+  	return;
 bug:
-	spin_unlock_irqrestore(&timerlist_lock, flags);
-	printk(KERN_ERR "BUG: kernel timer added twice at %p.\n",
-			__builtin_return_address(0));
+	spin_unlock_irqrestore(&base->lock, flags);
+  	printk("bug: kernel timer added twice at %p.\n",
+  			__builtin_return_address(0));
 }
 
 static inline int detach_timer (struct timer_list *timer)
@@ -206,28 +164,82 @@
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
+	if (timer_pending(timer) && timer->expires == expires)
+		return 1;
+	new_base = tvec_bases + smp_processor_id();
+	CHECK_BASE(new_base);
+
+	local_irq_save(flags);
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
 
@@ -240,24 +252,34 @@
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
@@ -265,7 +287,7 @@
 #endif
 
 
-static inline void cascade_timers(struct timer_vec *tv)
+static void cascade(tvec_base_t *base, tvec_t *tv)
 {
 	/* cascade all the timers from tv up one level */
 	struct list_head *head, *curr, *next;
@@ -277,54 +299,68 @@
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
 
 spinlock_t tqueue_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
@@ -638,17 +674,61 @@
 rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
 unsigned long last_time_offset;
 
+#ifdef CONFIG_SMP
+/*
+ * This function has to do all sorts of locking to make legacy
+ * BH-disablers work. If locking doesnt succeed
+ * now then we reschedule the tasklet.
+ */
+static void run_timer_tasklet(unsigned long data)
+{
+	int cpu = smp_processor_id();
+	tvec_base_t *base = tvec_bases + cpu;
+
+	if (!spin_trylock(&global_bh_lock))
+		goto resched;
+
+	if (!spin_trylock(&net_bh_lock))
+		goto resched_net;
+
+	if ((long)(jiffies - base->timer_jiffies) >= 0)
+		__run_timers(base);
+
+	spin_unlock(&net_bh_lock);
+	spin_unlock(&global_bh_lock);
+	return;
+resched_net:
+	spin_unlock(&global_bh_lock);
+resched:
+	tasklet_hi_schedule(&per_cpu(timer_tasklet, cpu));
+}
+#else
+static void run_timer_tasklet(unsigned long data)
+{
+	tvec_base_t *base = tvec_bases + smp_processor_id();
+	if ((long)(jiffies - base->timer_jiffies) >= 0)
+		__run_timers(base);
+}
+#endif
+
+/*
+ * Called by the local, per-CPU timer interrupt on SMP.
+  *
+  */
+void run_local_timers(void)
+{
+	int cpu = smp_processor_id();
+	tasklet_hi_schedule(&per_cpu(timer_tasklet, cpu));
+}
+
+/*
+ * Called by the timer interrupt. xtime_lock must already be taken
+ * by the timer IRQ!
+ */
 static inline void update_times(void)
 {
 	unsigned long ticks;
 
-	/*
-	 * update_times() is run from the raw timer_bh handler so we
-	 * just know that the irqs are locally enabled and so we don't
-	 * need to save/restore the flags of the local CPU here. -arca
-	 */
-	write_lock_irq(&xtime_lock);
-
 	ticks = jiffies - wall_jiffies;
 	if (ticks) {
 		wall_jiffies += ticks;
@@ -656,15 +736,8 @@
 	}
 	last_time_offset = 0;
 	calc_load(ticks);
-	write_unlock_irq(&xtime_lock);
 }
-
-void timer_bh(void)
-{
-	update_times();
-	run_timer_list();
-}
-
+  
 void do_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
@@ -673,7 +746,7 @@
 
 	update_process_times(user_mode(regs));
 #endif
-	mark_bh(TIMER_BH);
+	update_times();
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
@@ -988,3 +1061,24 @@
 
 	return 0;
 }
+
+void __init init_timers(void)
+{
+	int i, j;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		tvec_base_t *base;
+	       
+		base = tvec_bases + i;
+		spin_lock_init(&base->lock);
+		for (j = 0; j < TVN_SIZE; j++) {
+			INIT_LIST_HEAD(base->tv5.vec + j);
+			INIT_LIST_HEAD(base->tv4.vec + j);
+			INIT_LIST_HEAD(base->tv3.vec + j);
+			INIT_LIST_HEAD(base->tv2.vec + j);
+		}
+		for (j = 0; j < TVR_SIZE; j++)
+			INIT_LIST_HEAD(base->tv1.vec + j);
+		tasklet_init(&per_cpu(timer_tasklet, i), run_timer_tasklet, 0);
+	}
+}
diff -urN linux-2.5.36-base/lib/bust_spinlocks.c linux-2.5.36-smptimers_X3/lib/bust_spinlocks.c
--- linux-2.5.36-base/lib/bust_spinlocks.c	Wed Sep 18 06:28:48 2002
+++ linux-2.5.36-smptimers_X3/lib/bust_spinlocks.c	Wed Sep 18 16:13:23 2002
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
diff -urN linux-2.5.36-base/net/core/dev.c linux-2.5.36-smptimers_X3/net/core/dev.c
--- linux-2.5.36-base/net/core/dev.c	Wed Sep 18 06:28:58 2002
+++ linux-2.5.36-smptimers_X3/net/core/dev.c	Wed Sep 18 16:13:23 2002
@@ -1296,7 +1296,6 @@
 static int deliver_to_old_ones(struct packet_type *pt,
 			       struct sk_buff *skb, int last)
 {
-	static spinlock_t net_bh_lock = SPIN_LOCK_UNLOCKED;
 	int ret = NET_RX_DROP;
 
 	if (!last) {
@@ -1314,12 +1313,8 @@
 	/* Emulate NET_BH with special spinlock */
 	spin_lock(&net_bh_lock);
 
-	/* Disable timers and wait for all timers completion */
-	tasklet_disable(bh_task_vec+TIMER_BH);
-
 	ret = pt->func(skb, skb->dev, pt);
 
-	tasklet_hi_enable(bh_task_vec+TIMER_BH);
 	spin_unlock(&net_bh_lock);
 out:
 	return ret;

