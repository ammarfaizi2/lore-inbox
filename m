Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271825AbRIPMXy>; Sun, 16 Sep 2001 08:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271826AbRIPMXr>; Sun, 16 Sep 2001 08:23:47 -0400
Received: from [144.137.81.99] ([144.137.81.99]:44163 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S271825AbRIPMXe>;
	Sun, 16 Sep 2001 08:23:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
        Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1 
In-Reply-To: Your message of "Wed, 12 Sep 2001 16:53:35 +0200."
             <20010912165335.F695@athlon.random> 
Date: Sun, 16 Sep 2001 22:23:46 +1000
Message-Id: <E15iaxe-000408-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010912165335.F695@athlon.random> you write:
> somebody reinserts itself for a long time :(. Maybe Russel's approch is
> the cleaner after all, it just adds a branch in schedule fast path but
> (once fixed properly with the IPI and need_resched and dropping the
> unused irq checks that we don't want anyways to avoid even further
> slowdown of the slow paths) then the other issues goes away as well as
> the memory consumation.

IPI and need_resched?  That's incredibly heavy: why do you want to add
this?  Real-time tasks still call schedule() every so often, so I
don't understand your aim here...

> Ok. As usual people should care to order the fields in cacheline
> optimized manner, so for example they should care to put the rcu_head at
> the very end if they want to reserve the cacheline for the "hot" fields.

Agreed.  Added a new field to rcu_head, and hence a new arg to
call_rcu(), so now you do things like:

	call_rcu(&myfoo->rcu, kfree, &myfoo);

Other changes:

      Added synchronize_kernel(), which is useful for module unload.
      Architectures which don't enter schedule() in idle loop check rcu.
      Optimizations for uniprocessor.
      RCU callbacks are allowed to sleep.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/include/linux/rcupdate.h working-2.4.9-rcu/include/linux/rcupdate.h
--- linux-2.4.9-official/include/linux/rcupdate.h	Thu Jan  1 10:00:00 1970
+++ working-2.4.9-rcu/include/linux/rcupdate.h	Sun Sep 16 22:14:44 2001
@@ -0,0 +1,51 @@
+#ifndef _LINUX_RCUPDATE_H
+#define _LINUX_RCUPDATE_H
+/* Read-Copy-Update For Linux. */
+#include <linux/config.h>
+#include <asm/atomic.h>
+
+#ifdef CONFIG_SMP
+struct rcu_head
+{
+	struct rcu_head *next;
+	void (*func)(void *data);
+	void *data;
+};
+
+/* Queues future request may sleep (if caller can sleep: on UP is
+   called immediately). */
+void call_rcu(struct rcu_head *head, void (*func)(void *data), void *data);
+
+/* Count of pending requests: for optimization in schedule() */
+extern atomic_t rcu_pending;
+static inline int is_rcu_pending(void)
+{
+	return atomic_read(&num_rcu_pending) != 0;
+}
+
+/* Wait for every CPU to have moved on.  Sleeps. */
+void synchronize_kernel(void);
+
+#else /* !SMP */
+
+/* Remember the good old days when we didn't have to worry about more
+   than one processor? */
+struct rcu_head { };
+
+#define is_rcu_pending() 0
+
+static inline void call_rcu(struct rcu_head *head,
+			    void (*func)(void *data),
+			    void *data)
+{
+	func(data);
+}
+
+static inline void synchronize_kernel(void)
+{
+}
+#endif /*CONFIG_SMP*/
+
+/* Called by schedule() when batch reference count drops to zero. */
+void rcu_batch_done(void);
+#endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/kernel/Makefile working-2.4.9-rcu/kernel/Makefile
--- linux-2.4.9-official/kernel/Makefile	Sat Dec 30 09:07:24 2000
+++ working-2.4.9-rcu/kernel/Makefile	Wed Sep 12 18:19:24 2001
@@ -9,12 +9,12 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o rcupdate.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/kernel/rcupdate.c working-2.4.9-rcu/kernel/rcupdate.c
--- linux-2.4.9-official/kernel/rcupdate.c	Thu Jan  1 10:00:00 1970
+++ working-2.4.9-rcu/kernel/rcupdate.c	Sun Sep 16 17:31:13 2001
@@ -0,0 +1,99 @@
+/* Read-Copy-Update For Linux.
+   (C)2001 Rusty Russell.
+
+      Concept stolen from original Read Copy Update paper:
+
+   http://www.rdrop.com/users/paulmck/rclock/intro/rclock_intro.html and
+   http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+*/
+#include <linux/rcupdate.h>
+#include <linux/module.h>
+#include <linux/threads.h>
+#include <asm/system.h>
+#include <linux/interrupt.h>
+
+#ifdef CONFIG_SMP
+/* Count of pending requests: for optimization in schedule() */
+atomic_t rcu_pending = ATOMIC_INIT(0);
+
+/* Two batches per CPU : one (pending) is an internal queue of waiting
+   requests, being prepended to as new requests come in.  The other
+   (rcu_waiting) is waiting completion of schedule()s on all CPUs. */
+struct rcu_batch
+{
+	/* Two sets of queues: one queueing, one waiting quiescent finish */
+	int queueing;
+	/* Three queues: hard interrupt, soft interrupt, neither */
+	struct rcu_head *head[2][3];
+} __attribute__((__aligned__(SMP_CACHE_BYTES)));
+
+static struct rcu_batch rcu_batch[NR_CPUS];
+
+void call_rcu(struct rcu_head *head, void (*func)(void *data), void *data)
+{
+	unsigned cpu = smp_processor_id();
+	unsigned state;
+	struct rcu_head **headp;
+
+	head->func = func;
+	head->data = data;
+	if (in_interrupt()) {
+		if (in_irq()) state = 2;
+		else state = 1;
+	} else state = 0;
+
+	/* Figure out which queue we're on. */
+	headp = &rcu_batch[cpu].head[rcu_batch[cpu].queueing][state];
+
+	atomic_inc(&rcu_pending);
+	/* Prepend to this CPU's list: no locks needed. */
+	head->next = *headp;
+	*headp = head;
+}
+
+/* Calls every callback in the waiting rcu batch. */
+void rcu_batch_done(void)
+{
+	struct rcu_head *i, *next;
+	struct rcu_batch *mybatch;
+	unsigned int q;
+
+	mybatch = &rcu_batch[smp_processor_id()];
+	/* Call callbacks: probably delete themselves, may schedule. */
+	for (q = 0; q < 3; q++) {
+		for (i = mybatch->head[!mybatch->queueing][q]; i; i = next) {
+			next = i->next;
+			i->func(i->data);
+			atomic_dec(&rcu_pending);
+		}
+		mybatch->head[!mybatch->queueing][q] = NULL;
+	}
+
+	/* Start queueing on this batch. */
+	mybatch->queueing = !mybatch->queueing;
+}
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(void *completion)
+{
+	complete(completion);
+}
+
+void synchronize_kernel(void)
+{
+	struct rcu_head rcu;
+	struct completion completion;
+
+	/* Will wake me after RCU finished */
+	call_rcu(&sync.head, wakeme_after_rcu, &completion);
+
+	/* Wait for it */
+	wait_for_completion(&completion);
+}
+
+EXPORT_SYMBOL(call_rcu);
+EXPORT_SYMBOL(synchronize_kernel);
+#endif /*CONFIG_SMP*/
+
+/* Uniprocessor doesn't need an rcu_batch_done, since that gets
+   dead-code-eliminated in schedule() */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/kernel/sched.c working-2.4.9-rcu/kernel/sched.c
--- linux-2.4.9-official/kernel/sched.c	Sat Jul 21 08:12:21 2001
+++ working-2.4.9-rcu/kernel/sched.c	Sun Sep 16 17:11:07 2001
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/completion.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -99,12 +100,15 @@
 	struct schedule_data {
 		struct task_struct * curr;
 		cycles_t last_schedule;
+		int ring_count, finished_count;
 	} schedule_data;
 	char __pad [SMP_CACHE_BYTES];
-} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
+} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0,0,0}}};
 
 #define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
 #define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
+#define ring_count(cpu) aligned_data[(cpu)].schedule_data.ring_count
+#define finished_count(cpu) aligned_data[(cpu)].schedule_data.finished_count
 
 struct kernel_stat kstat;
 
@@ -544,6 +548,10 @@
 
 	release_kernel_lock(prev, this_cpu);
 
+	if (is_rcu_pending())
+		goto rcu_process;
+rcu_process_back:
+
 	/*
 	 * 'sched_data' is protected by the fact that we can run
 	 * only one process per CPU.
@@ -693,6 +701,22 @@
 	c = goodness(prev, this_cpu, prev->active_mm);
 	next = prev;
 	goto still_running_back;
+
+rcu_process:
+	/* Avoid cache line effects if value hasn't changed */
+	c = ring_count((this_cpu + 1) % smp_num_cpus) + 1;
+	if (c != ring_count(this_cpu)) {
+		/* Do subtraction to avoid int wrap corner case */
+		if (c - finished_count(this_cpu) >= 0) {
+			/* Avoid reentry: temporarily set finish_count
+                           far in the future */
+			finished_count(this_cpu) = c + INT_MAX;
+			rcu_batch_done();
+			finished_count(this_cpu) = c + smp_num_cpus;
+		}
+		ring_count(this_cpu) = c;
+	}
+	goto rcu_process_back;
 
 move_rr_last:
 	if (!prev->counter) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/alpha/kernel/process.c working-2.4.9-rcu/arch/alpha/kernel/process.c
--- linux-2.4.9-official/arch/alpha/kernel/process.c	Wed Jul  4 11:15:07 2001
+++ working-2.4.9-rcu/arch/alpha/kernel/process.c	Sun Sep 16 18:26:35 2001
@@ -30,6 +30,7 @@
 #include <linux/reboot.h>
 #include <linux/tty.h>
 #include <linux/console.h>
+#include <linux/rcupdate.h>
 
 #include <asm/reg.h>
 #include <asm/uaccess.h>
@@ -86,7 +87,8 @@
 		   get into the scheduler unnecessarily.  */
 		long oldval = xchg(&current->need_resched, -1UL);
 		if (!oldval)
-			while (current->need_resched < 0);
+			while (current->need_resched < 0
+				&& !is_rcu_pending());
 		schedule();
 		check_pgt_cache();
 	}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/arm/kernel/process.c working-2.4.9-rcu/arch/arm/kernel/process.c
--- linux-2.4.9-official/arch/arm/kernel/process.c	Fri Aug 17 05:12:35 2001
+++ working-2.4.9-rcu/arch/arm/kernel/process.c	Sun Sep 16 21:55:40 2001
@@ -23,6 +23,7 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -92,7 +93,7 @@
 		if (!idle)
 			idle = arch_idle;
 		leds_event(led_idle_start);
-		while (!current->need_resched)
+		while (!current->need_resched && !is_rcu_pending())
 			idle();
 		leds_event(led_idle_end);
 		schedule();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/i386/kernel/process.c working-2.4.9-rcu/arch/i386/kernel/process.c
--- linux-2.4.9-official/arch/i386/kernel/process.c	Sat Aug 11 15:12:23 2001
+++ working-2.4.9-rcu/arch/i386/kernel/process.c	Sun Sep 16 18:26:57 2001
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -131,7 +132,7 @@
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
-		while (!current->need_resched)
+		while (!current->need_resched && !is_rcu_pending())
 			idle();
 		schedule();
 		check_pgt_cache();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/ia64/kernel/process.c working-2.4.9-rcu/arch/ia64/kernel/process.c
--- linux-2.4.9-official/arch/ia64/kernel/process.c	Sat Aug 11 15:12:23 2001
+++ working-2.4.9-rcu/arch/ia64/kernel/process.c	Sun Sep 16 21:56:37 2001
@@ -17,6 +17,7 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
+#include <linux/rcupdate.h>
 
 #include <asm/delay.h>
 #include <asm/efi.h>
@@ -121,7 +122,7 @@
 		if (!current->need_resched)
 			min_xtp();
 #endif
-		while (!current->need_resched)
+		while (!current->need_resched && !is_rcu_pending())
 			continue;
 #ifdef CONFIG_SMP
 		normal_xtp();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/mips/kernel/process.c working-2.4.9-rcu/arch/mips/kernel/process.c
--- linux-2.4.9-official/arch/mips/kernel/process.c	Wed Jul  4 11:15:08 2001
+++ working-2.4.9-rcu/arch/mips/kernel/process.c	Sun Sep 16 18:27:32 2001
@@ -19,6 +19,7 @@
 #include <linux/sys.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
+#include <linux/rcupdate.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -40,7 +41,7 @@
 	init_idle();
 
 	while (1) {
-		while (!current->need_resched)
+		while (!current->need_resched && !is_rcu_pending())
 			if (cpu_wait)
 				(*cpu_wait)();
 		schedule();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/mips64/kernel/process.c working-2.4.9-rcu/arch/mips64/kernel/process.c
--- linux-2.4.9-official/arch/mips64/kernel/process.c	Thu Feb 22 14:24:54 2001
+++ working-2.4.9-rcu/arch/mips64/kernel/process.c	Sun Sep 16 18:27:42 2001
@@ -18,6 +18,7 @@
 #include <linux/sys.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
+#include <linux/rcupdate.h>
 
 #include <asm/bootinfo.h>
 #include <asm/pgtable.h>
@@ -36,7 +37,7 @@
 	current->nice = 20;
 	current->counter = -100;
 	while (1) {
-		while (!current->need_resched)
+		while (!current->need_resched && !is_rcu_pending())
 			if (wait_available)
 				__asm__("wait");
 		schedule();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/parisc/kernel/process.c working-2.4.9-rcu/arch/parisc/kernel/process.c
--- linux-2.4.9-official/arch/parisc/kernel/process.c	Thu Feb 22 14:24:55 2001
+++ working-2.4.9-rcu/arch/parisc/kernel/process.c	Sun Sep 16 18:27:51 2001
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/version.h>
 #include <linux/elf.h>
+#include <linux/rcupdate.h>
 
 #include <asm/machdep.h>
 #include <asm/offset.h>
@@ -74,7 +75,7 @@
 	current->counter = -100;
 
 	while (1) {
-		while (!current->need_resched) {
+		while (!current->need_resched && !is_rcu_pending()) {
 		}
 		schedule();
 		check_pgt_cache();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/ppc/kernel/idle.c working-2.4.9-rcu/arch/ppc/kernel/idle.c
--- linux-2.4.9-official/arch/ppc/kernel/idle.c	Mon May 28 12:42:20 2001
+++ working-2.4.9-rcu/arch/ppc/kernel/idle.c	Sun Sep 16 18:19:32 2001
@@ -23,6 +23,7 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -74,7 +75,7 @@
 		if (do_power_save && !current->need_resched)
 			power_save();
 
-		if (current->need_resched) {
+		if (current->need_resched || is_rcu_pending()) {
 			schedule();
 			check_pgt_cache();
 		}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/s390/kernel/process.c working-2.4.9-rcu/arch/s390/kernel/process.c
--- linux-2.4.9-official/arch/s390/kernel/process.c	Fri Aug 17 05:12:35 2001
+++ working-2.4.9-rcu/arch/s390/kernel/process.c	Sun Sep 16 18:20:57 2001
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -63,7 +64,7 @@
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup | 0x80000000L;
 	while(1) {
-                if (current->need_resched) {
+                if (current->need_resched || is_rcu_pending()) {
                         schedule();
                         check_pgt_cache();
                         continue;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/s390x/kernel/process.c working-2.4.9-rcu/arch/s390x/kernel/process.c
--- linux-2.4.9-official/arch/s390x/kernel/process.c	Fri Aug 17 05:12:35 2001
+++ working-2.4.9-rcu/arch/s390x/kernel/process.c	Sun Sep 16 18:20:49 2001
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -63,7 +64,7 @@
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup;
 	while(1) {
-                if (current->need_resched) {
+                if (current->need_resched || is_rcu_pending()) {
                         schedule();
                         check_pgt_cache();
                         continue;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/sh/kernel/process.c working-2.4.9-rcu/arch/sh/kernel/process.c
--- linux-2.4.9-official/arch/sh/kernel/process.c	Sun Apr 29 06:16:37 2001
+++ working-2.4.9-rcu/arch/sh/kernel/process.c	Sun Sep 16 18:21:53 2001
@@ -34,6 +34,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -71,7 +72,7 @@
 	current->counter = -100;
 
 	while (1) {
-		while (!current->need_resched) {
+		while (!current->need_resched && !is_rcu_pending()) {
 			if (hlt_counter)
 				continue;
 			__sti();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/sparc/kernel/process.c working-2.4.9-rcu/arch/sparc/kernel/process.c
--- linux-2.4.9-official/arch/sparc/kernel/process.c	Thu Feb 22 14:24:56 2001
+++ working-2.4.9-rcu/arch/sparc/kernel/process.c	Sun Sep 16 18:24:35 2001
@@ -27,6 +27,7 @@
 #include <linux/smp_lock.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
+#include <linux/rcupdate.h>
 
 #include <asm/auxio.h>
 #include <asm/oplib.h>
@@ -114,7 +115,7 @@
 	init_idle();
 
 	while(1) {
-		if(current->need_resched) {
+		if(current->need_resched || is_rcu_pending()) {
 			schedule();
 			check_pgt_cache();
 		}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.9-official/arch/sparc64/kernel/process.c working-2.4.9-rcu/arch/sparc64/kernel/process.c
--- linux-2.4.9-official/arch/sparc64/kernel/process.c	Wed Jul  4 11:15:08 2001
+++ working-2.4.9-rcu/arch/sparc64/kernel/process.c	Sun Sep 16 18:25:34 2001
@@ -28,6 +28,7 @@
 #include <linux/config.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
+#include <linux/rcupdate.h>
 
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
@@ -88,7 +89,7 @@
 	init_idle();
 
 	while(1) {
-		if (current->need_resched != 0) {
+		if (current->need_resched != 0 || is_rcu_pending()) {
 			unidle_me();
 			schedule();
 			check_pgt_cache();
