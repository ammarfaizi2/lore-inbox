Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUDVO64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUDVO64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbUDVO64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:58:56 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:19331 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S264103AbUDVO6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:58:16 -0400
Date: Thu, 22 Apr 2004 16:56:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: dipankar@in.ibm.com
Cc: hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040422145625.GA2116@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dipankar,
here is my newest version of the timer patch. I picked up your
suggestion to add idle_cpu_mask to sched.c. Anything else ?

blue skies,
  Martin.

---
[PATCH] s390: no timer interrupts in idle.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

This patch add a system control that allows to switch off the jiffies
timer interrupts while a cpu sleeps in idle. This is useful for a system
running with virtual cpus under z/VM.

diffstat:
 arch/s390/Kconfig          |   19 +++++
 arch/s390/defconfig        |    1 
 arch/s390/kernel/process.c |   10 ++
 arch/s390/kernel/time.c    |  156 ++++++++++++++++++++++++++++++++++++++-------
 arch/s390/kernel/traps.c   |    4 -
 include/linux/sched.h      |    2 
 include/linux/sysctl.h     |    1 
 include/linux/timer.h      |    2 
 kernel/rcupdate.c          |    6 +
 kernel/sched.c             |    9 ++
 kernel/sysctl.c            |   12 +++
 kernel/timer.c             |   69 +++++++++++++++++++
 12 files changed, 262 insertions(+), 29 deletions(-)

diff -urN linux-2.6/arch/s390/Kconfig linux-2.6-s390/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	Thu Apr 22 15:54:53 2004
+++ linux-2.6-s390/arch/s390/Kconfig	Thu Apr 22 15:54:54 2004
@@ -333,6 +333,25 @@
 	  This can also be compiled as a module, which will be called
 	  appldata_net_sum.o.
 
+config NO_IDLE_HZ
+	bool "No HZ timer ticks in idle"
+	help
+	  Switches the regular HZ timer off when the system is going idle.
+	  This helps z/VM to detect that the Linux system is idle. VM can
+	  then "swap-out" this guest which reduces memory usage. It also
+	  reduces the overhead of idle systems. 
+
+	  The HZ timer can be switched on/off via /proc/sys/kernel/hz_timer.
+	  hz_timer=0 means HZ timer is disabled. hz_timer=1 means HZ 
+	  timer is active.
+
+config NO_IDLE_HZ_INIT
+	bool "HZ timer in idle off by default"
+	depends on NO_IDLE_HZ
+	help
+	  The HZ timer is switched off in idle by default. That means the
+	  HZ timer is already disabled at boot time.
+
 endmenu
 
 config PCMCIA
diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Thu Apr 22 15:54:54 2004
+++ linux-2.6-s390/arch/s390/defconfig	Thu Apr 22 15:54:54 2004
@@ -83,6 +83,7 @@
 # CONFIG_SHARED_KERNEL is not set
 # CONFIG_CMM is not set
 # CONFIG_VIRT_TIMER is not set
+# CONFIG_NO_IDLE_HZ is not set
 # CONFIG_PCMCIA is not set
 
 #
diff -urN linux-2.6/arch/s390/kernel/process.c linux-2.6-s390/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	Thu Apr 22 15:54:27 2004
+++ linux-2.6-s390/arch/s390/kernel/process.c	Thu Apr 22 15:54:54 2004
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/irq.h>
-#ifdef CONFIG_VIRT_TIMER
+#if defined(CONFIG_VIRT_TIMER) || defined (CONFIG_NO_IDLE_HZ)
 #include <asm/timer.h>
 #endif
 
@@ -75,17 +75,21 @@
 	psw_t wait_psw;
 	unsigned long reg;
 
+	local_irq_disable();
         if (need_resched()) {
+		local_irq_enable();
                 schedule();
                 return;
         }
 
-#ifdef CONFIG_VIRT_TIMER
+#if defined(CONFIG_VIRT_TIMER) || defined (CONFIG_NO_IDLE_HZ)
 	/*
 	 * hook to stop timers that should not tick while CPU is idle
 	 */
-	if (stop_timers())
+	if (stop_timers()) {
+		local_irq_enable();
 		return;
+	}
 #endif
 
 	/* 
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-s390/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	Thu Apr 22 15:54:53 2004
+++ linux-2.6-s390/arch/s390/kernel/time.c	Thu Apr 22 15:54:54 2004
@@ -331,29 +331,6 @@
 	return 0;
 }
 
-void do_monitor_call(struct pt_regs *regs, long interruption_code)
-{
-	/* disable monitor call class 0 */
-	__ctl_clear_bit(8, 15);
-
-	start_cpu_timer();
-}
-
-/*
- * called from cpu_idle to stop any timers
- * returns 1 if CPU should not be stopped
- */
-int stop_timers(void)
-{
-	if (stop_cpu_timer())
-		return 1;
-
-	/* enable monitor call class 0 */
-	__ctl_set_bit(8, 15);
-
-	return 0;
-}
-
 void set_vtimer(__u64 expires)
 {
 	asm volatile ("SPT %0" : : "m" (expires));
@@ -474,6 +451,139 @@
 }
 #endif
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+#ifdef CONFIG_NO_IDLE_HZ_INIT
+int sysctl_hz_timer = 0;
+#else
+int sysctl_hz_timer = 1;
+#endif
+
+/*
+ * Start the HZ tick on the current CPU.
+ * Only cpu_idle may call this function.
+ */
+void start_hz_timer(struct pt_regs *regs)
+{
+	__u64 tmp;
+	__u32 ticks;
+
+	if (!cpu_isset(smp_processor_id(), idle_cpu_mask))
+		return;
+
+	/* Calculate how many ticks have passed */
+	asm volatile ("STCK 0(%0)" : : "a" (&tmp) : "memory", "cc");
+	tmp = tmp + CLK_TICKS_PER_JIFFY - S390_lowcore.jiffy_timer;
+	ticks = __calculate_ticks(tmp);
+	S390_lowcore.jiffy_timer += CLK_TICKS_PER_JIFFY * (__u64) ticks;
+
+	/* Set the clock comparator to the next tick. */
+	tmp = S390_lowcore.jiffy_timer + CPU_DEVIATION;
+	asm volatile ("SCKC %0" : : "m" (tmp));
+
+	/* Charge the ticks. */
+	if (ticks > 0) {
+#ifdef CONFIG_SMP
+		/*
+		 * Do not rely on the boot cpu to do the calls to do_timer.
+		 * Spread it over all cpus instead.
+		 */
+		write_seqlock(&xtime_lock);
+		if (S390_lowcore.jiffy_timer > xtime_cc) {
+			__u32 xticks;
+			
+			tmp = S390_lowcore.jiffy_timer - xtime_cc;
+			if (tmp >= 2*CLK_TICKS_PER_JIFFY) {
+				xticks = __calculate_ticks(tmp);
+				xtime_cc += (__u64) xticks*CLK_TICKS_PER_JIFFY;
+			} else {
+				xticks = 1;
+				xtime_cc += CLK_TICKS_PER_JIFFY;
+			}
+			while (xticks--)
+				do_timer(regs);
+		}
+		write_sequnlock(&xtime_lock);
+		while (ticks--)
+			update_process_times(user_mode(regs));
+#else
+		while (ticks--)
+			do_timer(regs);
+#endif
+	}
+	cpu_clear(smp_processor_id(), idle_cpu_mask);
+}
+
+/*
+ * Stop the HZ tick on the current CPU.
+ * Only cpu_idle may call this function.
+ */
+int stop_hz_timer(void)
+{
+	__u64 timer;
+
+	if (sysctl_hz_timer != 0)
+		return 1;
+
+	/*
+	 * Leave the clock comparator set up for the next timer
+	 * tick if either rcu or a softirq is pending.
+	 */
+	if (rcu_pending(smp_processor_id()) || local_softirq_pending())
+		return 1;
+
+	/*
+	 * This cpu is going really idle. Set up the clock comparator
+	 * for the next event.
+	 */
+	cpu_set(smp_processor_id(), idle_cpu_mask);
+	timer = (__u64) (next_timer_interrupt() - jiffies) + jiffies_64;
+	timer = jiffies_timer_cc + timer * CLK_TICKS_PER_JIFFY;
+	asm volatile ("SCKC %0" : : "m" (timer));
+
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_VIRT_TIMER) || defined(CONFIG_NO_IDLE_HZ)
+
+void do_monitor_call(struct pt_regs *regs, long interruption_code)
+{
+	/* disable monitor call class 0 */
+	__ctl_clear_bit(8, 15);
+
+#ifdef CONFIG_VIRT_TIMER
+	start_cpu_timer();
+#endif
+#ifdef CONFIG_NO_IDLE_HZ
+	start_hz_timer(regs);
+#endif
+}
+
+/* 
+ * called from cpu_idle to stop any timers 
+ * returns 1 if CPU should not be stopped
+ */
+int stop_timers(void)
+{
+#ifdef CONFIG_VIRT_TIMER
+	if (stop_cpu_timer())
+		return 1;
+#endif
+
+#ifdef CONFIG_NO_IDLE_HZ
+	if (stop_hz_timer())
+		return 1;
+#endif
+
+	/* enable monitor call class 0 */
+	__ctl_set_bit(8, 15);
+
+	return 0;
+}
+
+#endif
+
 /*
  * Start the clock comparator and the virtual CPU timer
  * on the current CPU.
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Sun Apr  4 05:36:55 2004
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Thu Apr 22 15:54:54 2004
@@ -64,7 +64,7 @@
 extern void pfault_interrupt(struct pt_regs *regs, __u16 error_code);
 static ext_int_info_t ext_int_pfault;
 #endif
-#ifdef CONFIG_VIRT_TIMER
+#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_VIRT_TIMER)
 extern pgm_check_handler_t do_monitor_call;
 #endif
 
@@ -631,7 +631,7 @@
 #endif /* CONFIG_ARCH_S390X */
         pgm_check_table[0x15] = &operand_exception;
         pgm_check_table[0x1C] = &privileged_op;
-#ifdef CONFIG_VIRT_TIMER
+#if defined(CONFIG_VIRT_TIMER) || defined(CONFIG_NO_IDLE_HZ)
 	pgm_check_table[0x40] = &do_monitor_call;
 #endif
 	if (MACHINE_IS_VM) {
diff -urN linux-2.6/include/linux/sched.h linux-2.6-s390/include/linux/sched.h
--- linux-2.6/include/linux/sched.h	Thu Apr 22 15:54:34 2004
+++ linux-2.6-s390/include/linux/sched.h	Thu Apr 22 15:54:54 2004
@@ -149,6 +149,8 @@
 extern void sched_init(void);
 extern void init_idle(task_t *idle, int cpu);
 
+extern cpumask_t idle_cpu_mask;
+
 extern void show_state(void);
 extern void show_regs(struct pt_regs *);
 extern void show_trace_task(task_t *tsk);
diff -urN linux-2.6/include/linux/sysctl.h linux-2.6-s390/include/linux/sysctl.h
--- linux-2.6/include/linux/sysctl.h	Thu Apr 22 15:54:34 2004
+++ linux-2.6-s390/include/linux/sysctl.h	Thu Apr 22 15:54:54 2004
@@ -132,6 +132,7 @@
 	KERN_PTY=62,		/* dir: pty driver */
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
+	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 };
 
 
diff -urN linux-2.6/include/linux/timer.h linux-2.6-s390/include/linux/timer.h
--- linux-2.6/include/linux/timer.h	Sun Apr  4 05:37:37 2004
+++ linux-2.6-s390/include/linux/timer.h	Thu Apr 22 15:54:54 2004
@@ -65,6 +65,8 @@
 extern int __mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 
+extern unsigned long next_timer_interrupt(void);
+
 /***
  * add_timer - start a timer
  * @timer: the timer to be added
diff -urN linux-2.6/kernel/rcupdate.c linux-2.6-s390/kernel/rcupdate.c
--- linux-2.6/kernel/rcupdate.c	Thu Apr 22 15:54:34 2004
+++ linux-2.6-s390/kernel/rcupdate.c	Thu Apr 22 15:54:54 2004
@@ -103,6 +103,8 @@
  */
 static void rcu_start_batch(long newbatch)
 {
+	cpumask_t active;
+
 	if (rcu_batch_before(rcu_ctrlblk.maxbatch, newbatch)) {
 		rcu_ctrlblk.maxbatch = newbatch;
 	}
@@ -111,7 +113,9 @@
 		return;
 	}
 	/* Can't change, since spin lock held. */
-	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
+	active = idle_cpu_mask;
+	cpus_complement(active);
+	cpus_and(rcu_ctrlblk.rcu_cpu_mask, cpu_online_map, active);
 }
 
 /*
diff -urN linux-2.6/kernel/sched.c linux-2.6-s390/kernel/sched.c
--- linux-2.6/kernel/sched.c	Thu Apr 22 15:54:34 2004
+++ linux-2.6-s390/kernel/sched.c	Thu Apr 22 15:54:54 2004
@@ -2684,6 +2684,15 @@
 #endif
 }
 
+/*
+ * In a system that switches off the HZ timer idle_cpu_mask
+ * indicates which cpus entered this state. This is used
+ * in the rcu update to wait only for active cpus. For system
+ * which do not switch off the HZ timer idle_cpu_mask should
+ * always be CPU_MASK_NONE.
+ */
+cpumask_t idle_cpu_mask = CPU_MASK_NONE;
+
 #ifdef CONFIG_SMP
 /*
  * This is how migration works:
diff -urN linux-2.6/kernel/sysctl.c linux-2.6-s390/kernel/sysctl.c
--- linux-2.6/kernel/sysctl.c	Thu Apr 22 15:54:34 2004
+++ linux-2.6-s390/kernel/sysctl.c	Thu Apr 22 15:54:54 2004
@@ -108,6 +108,8 @@
 extern int sysctl_userprocess_debug;
 #endif
 
+extern int sysctl_hz_timer;
+
 #if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
 extern unsigned long powersave_nap;
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
@@ -573,6 +575,16 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#endif 
+#ifdef CONFIG_NO_IDLE_HZ
+	{
+		.ctl_name       = KERN_HZ_TIMER,
+		.procname       = "hz_timer",
+		.data           = &sysctl_hz_timer,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = &proc_dointvec,
+	},
 #endif
 	{
 		.ctl_name	= KERN_S390_USER_DEBUG_LOGGING,
diff -urN linux-2.6/kernel/timer.c linux-2.6-s390/kernel/timer.c
--- linux-2.6/kernel/timer.c	Thu Apr 22 15:54:34 2004
+++ linux-2.6-s390/kernel/timer.c	Thu Apr 22 15:54:54 2004
@@ -428,6 +428,75 @@
 	spin_unlock_irq(&base->lock);
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+/*
+ * Find out when the next timer event is due to happen. This
+ * is used on S/390 to stop all activity when a cpus is idle.
+ * This functions needs to be called disabled.
+ */
+unsigned long next_timer_interrupt(void)
+{
+	tvec_base_t *base;
+	struct list_head *list;
+	struct timer_list *nte;
+	unsigned long expires;
+	tvec_t *varray[4];
+	int i, j;
+
+	base = &__get_cpu_var(tvec_bases);
+	spin_lock(&base->lock);
+	expires = base->timer_jiffies + (LONG_MAX >> 1);
+	list = 0;
+
+	/* Look for timer events in tv1. */
+	j = base->timer_jiffies & TVR_MASK;
+	do {
+		list_for_each_entry(nte, base->tv1.vec + j, entry) {
+			expires = nte->expires;
+			if (j < (base->timer_jiffies & TVR_MASK))
+				list = base->tv2.vec + (INDEX(0));
+			goto found;
+		}
+		j = (j + 1) & TVR_MASK;
+	} while (j != (base->timer_jiffies & TVR_MASK));
+
+	/* Check tv2-tv5. */
+	varray[0] = &base->tv2;
+	varray[1] = &base->tv3;
+	varray[2] = &base->tv4;
+	varray[3] = &base->tv5;
+	for (i = 0; i < 4; i++) {
+		j = INDEX(i);
+		do {
+			if (list_empty(varray[i]->vec + j)) {
+				j = (j + 1) & TVN_MASK;
+				continue;
+			}
+			list_for_each_entry(nte, varray[i]->vec + j, entry)
+				if (time_before(nte->expires, expires))
+					expires = nte->expires;
+			if (j < (INDEX(i)) && i < 3)
+				list = varray[i + 1]->vec + (INDEX(i + 1));
+			goto found;
+		} while (j != (INDEX(i)));
+	}
+found:
+	if (list) {
+		/*
+		 * The search wrapped. We need to look at the next list
+		 * from next tv element that would cascade into tv element
+		 * where we found the timer element.
+		 */
+		list_for_each_entry(nte, list, entry) {
+			if (time_before(nte->expires, expires))
+				expires = nte->expires;
+		}
+	}
+	spin_unlock(&base->lock);
+	return expires;
+}
+#endif
+
 /******************************************************************/
 
 /*
