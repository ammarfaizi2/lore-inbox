Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbTAFCZJ>; Sun, 5 Jan 2003 21:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbTAFCZJ>; Sun, 5 Jan 2003 21:25:09 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15051 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265773AbTAFCZB>; Sun, 5 Jan 2003 21:25:01 -0500
Date: Sun, 05 Jan 2003 18:33:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Timer interrupt cleanups [1/3] - global timer
Message-ID: <196440000.1041820405@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames:

do_timer                  -> do_global_timer
do_timer_interrupt_hook   -> do_global_timer_interrupt_hook
do_timer_interrupt        -> do_global_timer_interrupt
timer_interrupt           -> global_timer_interrupt

--------------------

Assuming we're SMP with a local apic timer all firing away:

global_timer_interrupt
	do_global_timer_interrupt
		{ack the interrupt}
		do_global_timer_interrupt_hook
			do_global_timer
				jiffies_64++;
				update_times
		{update CMOS clock}    (In the interrupt still ??!!)

apic_timer_interrupt
	smp_apic_timer_interrupt
		{ack the interrupt}
		smp_local_timer_interrupt
			x86_do_profile
			update_process_times

--------------------

On UP with local apic timer:

global_timer_interrupt
	do_global_timer_interrupt
		{ack the interrupt}
		do_global_timer_interrupt_hook
			do_global_timer
				jiffies_64++;
				update_process_times
				update_times
		{update CMOS clock}    (In the interrupt still ??!!)

apic_timer_interrupt
	smp_apic_timer_interrupt
		{ack the interrupt}
		smp_local_timer_interrupt
			x86_do_profile

--------------------

On a UP 386 with stale crusty breadcrumbs, and no local timer:

global_timer_interrupt
	do_global_timer_interrupt
		{ack the interrupt}
		do_global_timer_interrupt_hook
			do_global_timer
				jiffies_64++;
				update_process_times
				update_times
			x86_do_profile()
		{update CMOS clock}    (In the interrupt still ??!!)

--------------------

diff -urpN -X /home/fletch/.diff.exclude 
00-virgin/arch/i386/kernel/io_apic.c 
01-rename_global_timer/arch/i386/kernel/io_apic.c
--- 00-virgin/arch/i386/kernel/io_apic.c	Mon Dec 23 23:01:44 2002
+++ 01-rename_global_timer/arch/i386/kernel/io_apic.c	Sun Jan  5 10:47:59 
2003
@@ -1612,7 +1612,7 @@ static inline void check_timer(void)
 	set_intr_gate(vector, interrupt[0]);

 	/*
-	 * Subtle, code in do_timer_interrupt() expects an AEOI
+	 * Subtle, code in do_global_timer_interrupt() expects an AEOI
 	 * mode for the 8259A whenever interrupts are routed
 	 * through I/O APICs.  Also IRQ0 has to be enabled in
 	 * the 8259A which implies the virtual wire has to be
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/kernel/time.c 
01-rename_global_timer/arch/i386/kernel/time.c
--- 00-virgin/arch/i386/kernel/time.c	Thu Jan  2 22:04:58 2003
+++ 01-rename_global_timer/arch/i386/kernel/time.c	Sat Jan  4 20:04:20 2003
@@ -209,10 +209,10 @@ static long last_rtc_update;
 int timer_ack;

 /*
- * timer_interrupt() needs to keep up the real-time clock,
- * as well as call the "do_timer()" routine every clocktick
+ * global_timer_interrupt() needs to keep up the real-time clock,
+ * as well as call the "do_global_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, void *dev_id, struct 
pt_regs *regs)
+static inline void do_global_timer_interrupt(int irq, void *dev_id, struct 
pt_regs *regs)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -230,7 +230,7 @@ static inline void do_timer_interrupt(in
 	}
 #endif

-	do_timer_interrupt_hook(regs);
+	do_global_timer_interrupt_hook(regs);

 	/*
 	 * If we have an externally synchronized Linux clock, then update
@@ -269,7 +269,7 @@ static inline void do_timer_interrupt(in
  * Time Stamp Counter value at the time of the timer interrupt, so that
  * we later on can estimate the time of day more exactly.
  */
-void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+void global_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
@@ -282,7 +282,7 @@ void timer_interrupt(int irq, void *dev_

 	timer->mark_offset();

-	do_timer_interrupt(irq, NULL, regs);
+	do_global_timer_interrupt(irq, NULL, regs);

 	write_unlock(&xtime_lock);

diff -urpN -X /home/fletch/.diff.exclude 
00-virgin/arch/i386/mach-default/setup.c 
01-rename_global_timer/arch/i386/mach-default/setup.c
--- 00-virgin/arch/i386/mach-default/setup.c	Mon Dec 23 23:01:45 2002
+++ 01-rename_global_timer/arch/i386/mach-default/setup.c	Sat Jan  4 
18:46:16 2003
@@ -69,7 +69,7 @@ void __init trap_init_hook(void)
 {
 }

-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, 
"timer", NULL, NULL};
+static struct irqaction irq0  = { global_timer_interrupt, SA_INTERRUPT, 0, 
"timer", NULL, NULL};

 /**
  * time_init_hook - do any specific initialisations for the system timer.
diff -urpN -X /home/fletch/.diff.exclude 
00-virgin/arch/i386/mach-visws/setup.c 
01-rename_global_timer/arch/i386/mach-visws/setup.c
--- 00-virgin/arch/i386/mach-visws/setup.c	Sun Nov 17 20:29:25 2002
+++ 01-rename_global_timer/arch/i386/mach-visws/setup.c	Sat Jan  4 18:46:16 
2003
@@ -150,7 +150,7 @@ void __init pre_setup_arch_hook()
 {
 	visws_get_board_type_and_rev();
 }
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, 
"timer", NULL, NULL};
+static struct irqaction irq0  = { global_timer_interrupt, SA_INTERRUPT, 0, 
"timer", NULL, NULL};

 void __init time_init_hook(void)
 {
diff -urpN -X /home/fletch/.diff.exclude 
00-virgin/arch/i386/mach-voyager/setup.c 
01-rename_global_timer/arch/i386/mach-voyager/setup.c
--- 00-virgin/arch/i386/mach-voyager/setup.c	Thu Jan  2 22:04:58 2003
+++ 01-rename_global_timer/arch/i386/mach-voyager/setup.c	Sat Jan  4 
18:46:16 2003
@@ -38,7 +38,7 @@ void __init trap_init_hook(void)
 {
 }

-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, 
"timer", NULL, NULL};
+static struct irqaction irq0  = { global_timer_interrupt, SA_INTERRUPT, 0, 
"timer", NULL, NULL};

 void __init time_init_hook(void)
 {
diff -urpN -X /home/fletch/.diff.exclude 
00-virgin/include/asm-i386/arch_hooks.h 
01-rename_global_timer/include/asm-i386/arch_hooks.h
--- 00-virgin/include/asm-i386/arch_hooks.h	Sun Nov 17 20:29:48 2002
+++ 01-rename_global_timer/include/asm-i386/arch_hooks.h	Sat Jan  4 
18:46:16 2003
@@ -12,7 +12,7 @@
 extern void init_ISA_irqs(void);
 extern void apic_intr_init(void);
 extern void smp_intr_init(void);
-extern void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern void global_timer_interrupt(int irq, void *dev_id, struct pt_regs 
*regs);

 /* these are the defined hooks */
 extern void intr_init_hook(void);
diff -urpN -X /home/fletch/.diff.exclude 
00-virgin/include/asm-i386/mach-default/do_timer.h 
01-rename_global_timer/include/asm-i386/mach-default/do_timer.h
--- 00-virgin/include/asm-i386/mach-default/do_timer.h	Mon Dec 23 23:01:56 
2002
+++ 01-rename_global_timer/include/asm-i386/mach-default/do_timer.h	Sun Jan 
5 10:48:34 2003
@@ -3,7 +3,7 @@
 #include <asm/apic.h>

 /**
- * do_timer_interrupt_hook - hook into timer tick
+ * do_global_timer_interrupt_hook - hook into timer tick
  * @regs:	standard registers from interrupt
  *
  * Description:
@@ -13,9 +13,9 @@
  *	timer interrupt as a means of triggering reschedules etc.
  **/

-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+static inline void do_global_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_global_timer(regs);
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
@@ -50,7 +50,7 @@ static inline int do_timer_overflow(int
 	spin_lock(&i8259A_lock);
 	/*
 	 * This is tricky when I/O APICs are used;
-	 * see do_timer_interrupt().
+	 * see do_global_timer_interrupt().
 	 */
 	i = inb(0x20);
 	spin_unlock(&i8259A_lock);
diff -urpN -X /home/fletch/.diff.exclude 
00-virgin/include/asm-i386/mach-visws/do_timer.h 
01-rename_global_timer/include/asm-i386/mach-visws/do_timer.h
--- 00-virgin/include/asm-i386/mach-visws/do_timer.h	Mon Dec 23 23:01:56 
2002
+++ 01-rename_global_timer/include/asm-i386/mach-visws/do_timer.h	Sun Jan 
5 10:48:57 2003
@@ -3,12 +3,12 @@
 #include <asm/fixmap.h>
 #include <asm/cobalt.h>

-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+static inline void do_global_timer_interrupt_hook(struct pt_regs *regs)
 {
 	/* Clear the interrupt */
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);

-	do_timer(regs);
+	do_global_timer(regs);
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
@@ -29,7 +29,7 @@ static inline int do_timer_overflow(int
 	spin_lock(&i8259A_lock);
 	/*
 	 * This is tricky when I/O APICs are used;
-	 * see do_timer_interrupt().
+	 * see do_global_timer_interrupt().
 	 */
 	i = inb(0x20);
 	spin_unlock(&i8259A_lock);
diff -urpN -X /home/fletch/.diff.exclude 
00-virgin/include/asm-i386/mach-voyager/do_timer.h 
01-rename_global_timer/include/asm-i386/mach-voyager/do_timer.h
--- 00-virgin/include/asm-i386/mach-voyager/do_timer.h	Mon Dec 23 23:01:56 
2002
+++ 01-rename_global_timer/include/asm-i386/mach-voyager/do_timer.h	Sat Jan 
4 18:46:16 2003
@@ -1,9 +1,9 @@
 /* defines for inline arch setup functions */
 #include <asm/voyager.h>

-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+static inline void do_global_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	do_global_timer(regs);

 	voyager_timer_interrupt(regs);
 }
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/linux/sched.h 
01-rename_global_timer/include/linux/sched.h
--- 00-virgin/include/linux/sched.h	Thu Jan  2 22:05:17 2003
+++ 01-rename_global_timer/include/linux/sched.h	Sat Jan  4 20:06:32 2003
@@ -481,7 +481,7 @@ extern void free_uid(struct user_struct

 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
-extern void do_timer(struct pt_regs *);
+extern void do_global_timer(struct pt_regs *);

 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/kernel/timer.c 
01-rename_global_timer/kernel/timer.c
--- 00-virgin/kernel/timer.c	Mon Dec 16 21:50:51 2002
+++ 01-rename_global_timer/kernel/timer.c	Sat Jan  4 20:08:46 2003
@@ -803,7 +803,7 @@ static inline void update_times(void)
  * jiffies is defined in the linker script...
  */

-void do_timer(struct pt_regs *regs)
+void do_global_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
 #ifndef CONFIG_SMP

