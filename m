Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVHMNgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVHMNgQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 09:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVHMNgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 09:36:16 -0400
Received: from mail.aknet.ru ([82.179.72.26]:26886 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932166AbVHMNgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 09:36:16 -0400
Message-ID: <42FDF744.2070205@aknet.ru>
Date: Sat, 13 Aug 2005 17:36:04 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [rfc][patch] API for timer hooks
Content-Type: multipart/mixed;
 boundary="------------020702020404050002090102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020702020404050002090102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Right now it seems like the only interface
for registering the timer hooks is that one
of kernel/profile.c, and it is very limited.
The arch-specific timer hooks are provided
in an arch-specific headers as a static
functions.
Since my driver needs the timer hook, I
thought it might be a good idea to add an
API for registering the timer hooks.
The attached patch adds such an API and
converts all the relevant places to use it.
I changed oprofile to use it, and also
converted the arch-specific hooks, which
looks like a fair cleanup.

The API allows to register, unregister
and grab the timer hook. The grabbing
hook will always be executed first, and
can decide to prevent an execution of
the rest ones. The hook can have the
"run_always" flag set, in which case it
won't be bypassed, regardless of the
grabbing hook.

Does such an API look viable?
As usual, it is needed for the PC-Speaker
PCM driver that is currently in an ALSA CVS,
awaiting for the proper interface to appear
in the kernel.


--------------020702020404050002090102
Content-Type: text/x-patch;
 name="timer-hook-2.6.13-rc5-mm1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timer-hook-2.6.13-rc5-mm1.diff"

diff -urN linux-2.6.13-rc5-pcsp-kern/arch/i386/kernel/time.c linux-2.6.13-rc5-pcsp/arch/i386/kernel/time.c
--- linux-2.6.13-rc5-pcsp-kern/arch/i386/kernel/time.c	2005-08-11 18:57:45.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/arch/i386/kernel/time.c	2005-08-12 14:44:36.000000000 +0400
@@ -251,6 +251,32 @@
 EXPORT_SYMBOL(profile_pc);
 #endif
 
+static int timer_mark_offset(struct pt_regs *regs)
+{
+	cur_timer->mark_offset();
+	return 0;
+}
+
+static int do_process_time(struct pt_regs *regs)
+{
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
+/*
+ * In the SMP case we use the local APIC timer interrupt to do the
+ * profiling, except when we simulate SMP mode on a uniprocessor
+ * system, in that case we have to call the local interrupt handler.
+ */
+#ifndef CONFIG_X86_LOCAL_APIC
+	profile_tick(CPU_PROFILING, regs);
+#else
+	if (!using_apic_timer)
+		smp_local_timer_interrupt(regs);
+#endif
+	return 0;
+}
+
+
 /*
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
@@ -308,8 +334,6 @@
 	 */
 	write_seqlock(&xtime_lock);
 
-	cur_timer->mark_offset();
- 
 	do_timer_interrupt(irq, NULL, regs);
 
 	write_sequnlock(&xtime_lock);
@@ -451,6 +475,10 @@
 
 device_initcall(time_init_device);
 
+static struct timer_hook hook0 = { .hook_fn = timer_mark_offset, .run_always = 0 };
+static struct timer_hook hook1 = { .hook_fn = do_timer, .run_always = 0 };
+static struct timer_hook hook2 = { .hook_fn = do_process_time, .run_always = 0 };
+
 #ifdef CONFIG_HPET_TIMER
 extern void (*late_time_init)(void);
 /* Duplicate of time_init() below, with hpet_enable part added */
@@ -468,7 +496,11 @@
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	/* register timer hooks in reverse order */
 	time_init_hook();
+	setup_timer_hook(&hook2);
+	setup_timer_hook(&hook1);
+	setup_timer_hook(&hook0);
 }
 #endif
 
@@ -492,5 +524,9 @@
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	/* register timer hooks in reverse order */
 	time_init_hook();
+	setup_timer_hook(&hook2);
+	setup_timer_hook(&hook1);
+	setup_timer_hook(&hook0);
 }
diff -urN linux-2.6.13-rc5-pcsp-kern/arch/i386/mach-visws/setup.c linux-2.6.13-rc5-pcsp/arch/i386/mach-visws/setup.c
--- linux-2.6.13-rc5-pcsp-kern/arch/i386/mach-visws/setup.c	2005-08-11 17:54:49.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/arch/i386/mach-visws/setup.c	2005-08-11 18:31:40.000000000 +0400
@@ -118,6 +118,15 @@
 	.name =		"timer",
 };
 
+static int co_clear_timerint(struct pt_regs *regs)
+{
+	/* Clear the interrupt */
+	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
+	return 0;
+}
+
+
+static struct timer_hook hook = { .hook_fn = co_clear_timerint, .run_always = 1 };
 void __init time_init_hook(void)
 {
 	printk(KERN_INFO "Starting Cobalt Timer system clock\n");
@@ -131,6 +140,8 @@
 	/* Enable (unmask) the timer interrupt */
 	co_cpu_write(CO_CPU_CTRL, co_cpu_read(CO_CPU_CTRL) & ~CO_CTRL_TIMEMASK);
 
+	setup_timer_hook(&hook);
+
 	/* Wire cpu IDT entry to s/w handler (and Cobalt APIC to IDT) */
 	setup_irq(0, &irq0);
 }
diff -urN linux-2.6.13-rc5-pcsp-kern/arch/i386/mach-voyager/setup.c linux-2.6.13-rc5-pcsp/arch/i386/mach-voyager/setup.c
--- linux-2.6.13-rc5-pcsp-kern/arch/i386/mach-voyager/setup.c	2005-08-11 17:52:50.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/arch/i386/mach-voyager/setup.c	2005-08-11 17:49:11.000000000 +0400
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
+#include <asm/voyager.h>
 
 void __init pre_intr_init_hook(void)
 {
@@ -41,8 +42,9 @@
 }
 
 static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
-
+static struct timer_hook hook = { .hook_fn = voyager_timer_interrupt, .run_always = 1 };
 void __init time_init_hook(void)
 {
+	setup_timer_hook(&hook);
 	setup_irq(0, &irq0);
 }
diff -urN linux-2.6.13-rc5-pcsp-kern/arch/i386/mach-voyager/voyager_basic.c linux-2.6.13-rc5-pcsp/arch/i386/mach-voyager/voyager_basic.c
--- linux-2.6.13-rc5-pcsp-kern/arch/i386/mach-voyager/voyager_basic.c	2005-08-11 17:54:49.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/arch/i386/mach-voyager/voyager_basic.c	2005-08-11 18:31:22.000000000 +0400
@@ -165,8 +165,7 @@
 /* voyager specific handling code for timer interrupts.  Used to hand
  * off the timer tick to the SMP code, since the VIC doesn't have an
  * internal timer (The QIC does, but that's another story). */
-void
-voyager_timer_interrupt(struct pt_regs *regs)
+int voyager_timer_interrupt(struct pt_regs *regs)
 {
 	if((jiffies & 0x3ff) == 0) {
 
@@ -204,6 +203,7 @@
 #ifdef CONFIG_SMP
 	smp_vic_timer_interrupt(regs);
 #endif
+	return 0;
 }
 
 void
diff -urN linux-2.6.13-rc5-pcsp-kern/drivers/oprofile/timer_int.c linux-2.6.13-rc5-pcsp/drivers/oprofile/timer_int.c
--- linux-2.6.13-rc5-pcsp-kern/drivers/oprofile/timer_int.c	2005-03-13 17:56:27.000000000 +0300
+++ linux-2.6.13-rc5-pcsp/drivers/oprofile/timer_int.c	2005-08-11 16:03:03.000000000 +0400
@@ -12,11 +12,14 @@
 #include <linux/smp.h>
 #include <linux/oprofile.h>
 #include <linux/profile.h>
+#include <linux/timer.h>
 #include <linux/init.h>
 #include <asm/ptrace.h>
 
 #include "oprof.h"
 
+static void *hook_ptr;
+
 static int timer_notify(struct pt_regs *regs)
 {
  	oprofile_add_sample(regs, 0);
@@ -25,13 +28,14 @@
 
 static int timer_start(void)
 {
-	return register_timer_hook(timer_notify);
+	hook_ptr = register_timer_hook(timer_notify);
+	return !hook_ptr;
 }
 
 
 static void timer_stop(void)
 {
-	unregister_timer_hook(timer_notify);
+	unregister_timer_hook(hook_ptr);
 }
 
 
diff -urN linux-2.6.13-rc5-pcsp-kern/include/asm-i386/mach-default/do_timer.h linux-2.6.13-rc5-pcsp/include/asm-i386/mach-default/do_timer.h
--- linux-2.6.13-rc5-pcsp-kern/include/asm-i386/mach-default/do_timer.h	2005-08-10 10:12:12.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/include/asm-i386/mach-default/do_timer.h	2005-08-11 11:49:51.000000000 +0400
@@ -3,37 +3,6 @@
 #include <asm/apic.h>
 #include <asm/i8259.h>
 
-/**
- * do_timer_interrupt_hook - hook into timer tick
- * @regs:	standard registers from interrupt
- *
- * Description:
- *	This hook is called immediately after the timer interrupt is ack'd.
- *	It's primary purpose is to allow architectures that don't possess
- *	individual per CPU clocks (like the CPU APICs supply) to broadcast the
- *	timer interrupt as a means of triggering reschedules etc.
- **/
-
-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
-{
-	do_timer(regs);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
-#endif
-/*
- * In the SMP case we use the local APIC timer interrupt to do the
- * profiling, except when we simulate SMP mode on a uniprocessor
- * system, in that case we have to call the local interrupt handler.
- */
-#ifndef CONFIG_X86_LOCAL_APIC
-	profile_tick(CPU_PROFILING, regs);
-#else
-	if (!using_apic_timer)
-		smp_local_timer_interrupt(regs);
-#endif
-}
-
-
 /* you can safely undefine this if you don't have the Neptune chipset */
 
 #define BUGGY_NEPTUN_TIMER
diff -urN linux-2.6.13-rc5-pcsp-kern/include/asm-i386/mach-visws/do_timer.h linux-2.6.13-rc5-pcsp/include/asm-i386/mach-visws/do_timer.h
--- linux-2.6.13-rc5-pcsp-kern/include/asm-i386/mach-visws/do_timer.h	2005-08-11 17:55:10.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/include/asm-i386/mach-visws/do_timer.h	2005-08-10 16:11:13.000000000 +0400
@@ -4,28 +4,6 @@
 #include <asm/i8259.h>
 #include "cobalt.h"
 
-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
-{
-	/* Clear the interrupt */
-	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
-
-	do_timer(regs);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
-#endif
-/*
- * In the SMP case we use the local APIC timer interrupt to do the
- * profiling, except when we simulate SMP mode on a uniprocessor
- * system, in that case we have to call the local interrupt handler.
- */
-#ifndef CONFIG_X86_LOCAL_APIC
-	profile_tick(CPU_PROFILING, regs);
-#else
-	if (!using_apic_timer)
-		smp_local_timer_interrupt(regs);
-#endif
-}
-
 static inline int do_timer_overflow(int count)
 {
 	int i;
diff -urN linux-2.6.13-rc5-pcsp-kern/include/asm-i386/mach-voyager/do_timer.h linux-2.6.13-rc5-pcsp/include/asm-i386/mach-voyager/do_timer.h
--- linux-2.6.13-rc5-pcsp-kern/include/asm-i386/mach-voyager/do_timer.h	2004-10-30 18:30:51.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/include/asm-i386/mach-voyager/do_timer.h	2005-08-11 11:48:56.000000000 +0400
@@ -1,16 +1,3 @@
-/* defines for inline arch setup functions */
-#include <asm/voyager.h>
-
-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
-{
-	do_timer(regs);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
-#endif
-
-	voyager_timer_interrupt(regs);
-}
-
 static inline int do_timer_overflow(int count)
 {
 	/* can't read the ISR, just assume 1 tick
diff -urN linux-2.6.13-rc5-pcsp-kern/include/asm-i386/voyager.h linux-2.6.13-rc5-pcsp/include/asm-i386/voyager.h
--- linux-2.6.13-rc5-pcsp-kern/include/asm-i386/voyager.h	2004-01-09 10:00:02.000000000 +0300
+++ linux-2.6.13-rc5-pcsp/include/asm-i386/voyager.h	2005-08-11 16:11:01.000000000 +0400
@@ -505,7 +505,7 @@
 extern void voyager_smp_intr_init(void);
 extern __u8 voyager_extended_cmos_read(__u16 cmos_address);
 extern void voyager_smp_dump(void);
-extern void voyager_timer_interrupt(struct pt_regs *regs);
+extern int voyager_timer_interrupt(struct pt_regs *regs);
 extern void smp_local_timer_interrupt(struct pt_regs * regs);
 extern void voyager_power_off(void);
 extern void smp_voyager_power_off(void *dummy);
diff -urN linux-2.6.13-rc5-pcsp-kern/include/linux/profile.h linux-2.6.13-rc5-pcsp/include/linux/profile.h
--- linux-2.6.13-rc5-pcsp-kern/include/linux/profile.h	2004-12-26 00:37:13.000000000 +0300
+++ linux-2.6.13-rc5-pcsp/include/linux/profile.h	2005-08-11 11:19:45.000000000 +0400
@@ -53,12 +53,6 @@
 int profile_event_register(enum profile_type, struct notifier_block * n);
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
 
-int register_timer_hook(int (*hook)(struct pt_regs *));
-void unregister_timer_hook(int (*hook)(struct pt_regs *));
-
-/* Timer based profiling hook */
-extern int (*timer_hook)(struct pt_regs *);
-
 struct pt_regs;
 
 #else
@@ -87,16 +81,6 @@
 #define profile_handoff_task(a) (0)
 #define profile_munmap(a) do { } while (0)
 
-static inline int register_timer_hook(int (*hook)(struct pt_regs *))
-{
-	return -ENOSYS;
-}
-
-static inline void unregister_timer_hook(int (*hook)(struct pt_regs *))
-{
-	return;
-}
-
 #endif /* CONFIG_PROFILING */
 
 #endif /* __KERNEL__ */
diff -urN linux-2.6.13-rc5-pcsp-kern/include/linux/sched.h linux-2.6.13-rc5-pcsp/include/linux/sched.h
--- linux-2.6.13-rc5-pcsp-kern/include/linux/sched.h	2005-08-11 17:55:13.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/include/linux/sched.h	2005-08-11 16:09:00.000000000 +0400
@@ -1005,7 +1005,7 @@
 
 #include <asm/current.h>
 
-extern void do_timer(struct pt_regs *);
+extern int do_timer(struct pt_regs *);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
diff -urN linux-2.6.13-rc5-pcsp-kern/include/linux/timer.h linux-2.6.13-rc5-pcsp/include/linux/timer.h
--- linux-2.6.13-rc5-pcsp-kern/include/linux/timer.h	2005-08-11 17:55:14.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/include/linux/timer.h	2005-08-11 16:14:58.000000000 +0400
@@ -93,4 +93,17 @@
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
+struct timer_hook {
+	int (*hook_fn)(struct pt_regs *regs);
+	int run_always;
+	struct list_head list;
+};
+extern void do_timer_interrupt_hook(struct pt_regs *regs);
+extern void setup_timer_hook(struct timer_hook *hook);
+extern void remove_timer_hook(struct timer_hook *hook);
+extern void *register_timer_hook(int (*hook)(struct pt_regs *));
+extern void unregister_timer_hook(void *hook_ptr);
+extern int grab_timer_hook(void *hook_ptr);
+extern void ungrab_timer_hook(void *hook_ptr);
+
 #endif
diff -urN linux-2.6.13-rc5-pcsp-kern/kernel/profile.c linux-2.6.13-rc5-pcsp/kernel/profile.c
--- linux-2.6.13-rc5-pcsp-kern/kernel/profile.c	2005-08-10 10:12:17.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/kernel/profile.c	2005-08-11 11:23:23.000000000 +0400
@@ -34,9 +34,6 @@
 #define NR_PROFILE_HIT		(PAGE_SIZE/sizeof(struct profile_hit))
 #define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
 
-/* Oprofile timer tick hook */
-int (*timer_hook)(struct pt_regs *) __read_mostly;
-
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
 static int prof_on __read_mostly;
@@ -175,24 +172,6 @@
 	return err;
 }
 
-int register_timer_hook(int (*hook)(struct pt_regs *))
-{
-	if (timer_hook)
-		return -EBUSY;
-	timer_hook = hook;
-	return 0;
-}
-
-void unregister_timer_hook(int (*hook)(struct pt_regs *))
-{
-	WARN_ON(hook != timer_hook);
-	timer_hook = NULL;
-	/* make sure all CPUs see the NULL hook */
-	synchronize_sched();  /* Allow ongoing interrupts to complete. */
-}
-
-EXPORT_SYMBOL_GPL(register_timer_hook);
-EXPORT_SYMBOL_GPL(unregister_timer_hook);
 EXPORT_SYMBOL_GPL(task_handoff_register);
 EXPORT_SYMBOL_GPL(task_handoff_unregister);
 
@@ -385,8 +364,6 @@
 
 void profile_tick(int type, struct pt_regs *regs)
 {
-	if (type == CPU_PROFILING && timer_hook)
-		timer_hook(regs);
 	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }
diff -urN linux-2.6.13-rc5-pcsp-kern/kernel/timer.c linux-2.6.13-rc5-pcsp/kernel/timer.c
--- linux-2.6.13-rc5-pcsp-kern/kernel/timer.c	2005-08-11 17:55:14.000000000 +0400
+++ linux-2.6.13-rc5-pcsp/kernel/timer.c	2005-08-11 16:50:50.000000000 +0400
@@ -93,6 +93,13 @@
 #endif
 }
 
+struct timer_hook_list {
+	struct list_head head;
+	struct timer_hook *grab;
+	spinlock_t lock;
+};
+static struct timer_hook_list timer_hook_list;
+
 static void check_timer_failed(struct timer_list *timer)
 {
 	static int whine_count;
@@ -961,11 +968,12 @@
  * jiffies is defined in the linker script...
  */
 
-void do_timer(struct pt_regs *regs)
+int do_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
 	update_times();
 	softlockup_tick(regs);
+	return 0;
 }
 
 #ifdef __ARCH_WANT_SYS_ALARM
@@ -1426,6 +1434,10 @@
 
 void __init init_timers(void)
 {
+	INIT_LIST_HEAD(&timer_hook_list.head);
+	spin_lock_init(&timer_hook_list.lock);
+	timer_hook_list.grab = NULL;
+
 	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
 				(void *)(long)smp_processor_id());
 	register_cpu_notifier(&timers_nb);
@@ -1651,3 +1663,70 @@
 }
 
 EXPORT_SYMBOL(msleep_interruptible);
+
+
+
+void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	struct timer_hook *ptr;
+	int done = 0;
+	if (unlikely(timer_hook_list.grab))
+		done = timer_hook_list.grab->hook_fn(regs);
+	/* called within IRQ context, rcu_read_lock not needed? */
+	list_for_each_entry_rcu(ptr, &timer_hook_list.head, list) {
+		if (!done || ptr->run_always)
+			ptr->hook_fn(regs);
+	}
+}
+
+void setup_timer_hook(struct timer_hook *hook)
+{
+	spin_lock(&timer_hook_list.lock);
+	list_add_rcu(&hook->list, &timer_hook_list.head);
+	spin_unlock(&timer_hook_list.lock);
+}
+
+void remove_timer_hook(struct timer_hook *hook)
+{
+	spin_lock(&timer_hook_list.lock);
+	list_del_rcu(&hook->list);
+	spin_unlock(&timer_hook_list.lock);
+}
+
+void *register_timer_hook(int (*func)(struct pt_regs *))
+{
+	struct timer_hook *ptr;
+	ptr = kmalloc(sizeof(struct timer_hook), GFP_ATOMIC);
+	ptr->hook_fn = func;
+	ptr->run_always = 0;
+	setup_timer_hook(ptr);
+	return ptr;
+}
+
+void unregister_timer_hook(void *hook_ptr)
+{
+	struct timer_hook *ptr = (struct timer_hook *)hook_ptr;
+	remove_timer_hook(ptr);
+	kfree(ptr);
+}
+
+int grab_timer_hook(void *hook_ptr)
+{
+	if (timer_hook_list.grab)
+		return -EBUSY;
+	timer_hook_list.grab = (struct timer_hook *)hook_ptr;
+	return 0;
+}
+
+void ungrab_timer_hook(void *hook_ptr)
+{
+	WARN_ON(timer_hook_list.grab != (struct timer_hook *)hook_ptr);
+	timer_hook_list.grab = NULL;
+}
+
+EXPORT_SYMBOL_GPL(setup_timer_hook);
+EXPORT_SYMBOL_GPL(remove_timer_hook);
+EXPORT_SYMBOL_GPL(register_timer_hook);
+EXPORT_SYMBOL_GPL(unregister_timer_hook);
+EXPORT_SYMBOL_GPL(grab_timer_hook);
+EXPORT_SYMBOL_GPL(ungrab_timer_hook);

--------------020702020404050002090102--
