Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285347AbRLNM0f>; Fri, 14 Dec 2001 07:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285342AbRLNM02>; Fri, 14 Dec 2001 07:26:28 -0500
Received: from CPE-203-51-30-59.nsw.bigpond.net.au ([203.51.30.59]:13443 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S285347AbRLNM0U>; Fri, 14 Dec 2001 07:26:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.1-pre11 Read-Copy-Update Patch 
Date: Fri, 14 Dec 2001 22:27:14 +1100
Message-Id: <E16EqUk-0002OG-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	The hotplug CPU patch needs read-copy-update, otherwise
everyone has to lock around references to smp_num_cpus.  By waiting
until everyone has scheduled, we cleanly implement two-stage CPU
removal.

	Now, this patch is (obviously) currently a NOOP on UP: with
preemption on UP this would change.  Are you intending to implement
preemption in 2.5, and if so, for UP or SMP?

	My module loader replacement also uses RCU, to ensure noone is
still inside the module.  Otherwise we continue down the current path,
and force every registration interface in the kernel to lock on entry,
unlock on exit.  (If you want this, it's then a fairly short hop to a
microkernel).

	I'd love to know if I should implement RCU-with-preemption on
UP, abandon the RCU approach, or send my patches as is.

Thanks,
Rusty.

URLs:
Hotplug CPU:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu/hotcpu.patch.bz2

New module loader:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/module.patch.bz2

Overview:
http://www.kernel.org/pub/linux/kernel/people/rusty

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/include/linux/rcupdate.h tmp/include/linux/rcupdate.h
--- linux-2.4.15-pre9/include/linux/rcupdate.h	Thu Jan  1 10:00:00 1970
+++ tmp/include/linux/rcupdate.h	Thu Nov 22 18:25:25 2001
@@ -0,0 +1,43 @@
+#ifndef _LINUX_RCUPDATE_H
+#define _LINUX_RCUPDATE_H
+/* Read-Copy-Update For Linux. (c) 2001 Rusty Russell. */
+#include <linux/config.h>
+#include <linux/tqueue.h>
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
+/* Count of pending requests: for optimization in schedule() */
+extern atomic_t rcu_pending;
+static inline int is_rcu_pending(void)
+{
+	return atomic_read(&rcu_pending) != 0;
+}
+
+/* Wait for every CPU to have moved on.  Sleeps. */
+void synchronize_kernel(void);
+
+/* Queues future request: may sleep on UP if func doesn't sleep... */
+void call_rcu(struct rcu_head *head, void (*func)(void *data), void *data);
+
+#else /* !SMP */
+
+#define is_rcu_pending() 0
+
+static inline void synchronize_kernel(void)
+{
+}
+
+/* Call immediately for UP */
+#define call_rcu(head, func, data) (func(data))
+#endif /*CONFIG_SMP*/
+
+/* Called by schedule() when batch reference count drops to zero. */
+void rcu_batch_done(void);
+#endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/alpha/kernel/process.c tmp/arch/alpha/kernel/process.c
--- linux-2.4.15-pre9/arch/alpha/kernel/process.c	Mon Oct  1 05:26:08 2001
+++ tmp/arch/alpha/kernel/process.c	Thu Nov 22 18:25:25 2001
@@ -30,6 +30,7 @@
 #include <linux/reboot.h>
 #include <linux/tty.h>
 #include <linux/console.h>
+#include <linux/rcupdate.h>
 
 #include <asm/reg.h>
 #include <asm/uaccess.h>
@@ -85,7 +86,8 @@
 		   get into the scheduler unnecessarily.  */
 		long oldval = xchg(&current->need_resched, -1UL);
 		if (!oldval)
-			while (current->need_resched < 0);
+			while (current->need_resched < 0
+				&& !is_rcu_pending());
 		schedule();
 		check_pgt_cache();
 	}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/arm/kernel/process.c tmp/arch/arm/kernel/process.c
--- linux-2.4.15-pre9/arch/arm/kernel/process.c	Mon Oct  1 05:26:08 2001
+++ tmp/arch/arm/kernel/process.c	Thu Nov 22 18:25:25 2001
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/i386/kernel/apm.c tmp/arch/i386/kernel/apm.c
--- linux-2.4.15-pre9/arch/i386/kernel/apm.c	Thu Nov 22 18:18:11 2001
+++ tmp/arch/i386/kernel/apm.c	Thu Nov 22 18:25:25 2001
@@ -204,6 +204,7 @@
 #include <linux/pm.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/rcupdate.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -1342,7 +1343,7 @@
  * decide if we should just power down.
  *
  */
-#define system_idle() (nr_running == 1)
+#define system_idle() (nr_running == 1 && !is_rcu_pending())
 
 static void apm_mainloop(void)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/i386/kernel/process.c tmp/arch/i386/kernel/process.c
--- linux-2.4.15-pre9/arch/i386/kernel/process.c	Fri Oct  5 11:42:54 2001
+++ tmp/arch/i386/kernel/process.c	Thu Nov 22 18:25:25 2001
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -81,7 +82,7 @@
 {
 	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
 		__cli();
-		if (!current->need_resched)
+		if (!current->need_resched && !is_rcu_pending())
 			safe_halt();
 		else
 			__sti();
@@ -131,7 +132,7 @@
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
-		while (!current->need_resched)
+		while (!current->need_resched && !is_rcu_pending())
 			idle();
 		schedule();
 		check_pgt_cache();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/ia64/kernel/process.c tmp/arch/ia64/kernel/process.c
--- linux-2.4.15-pre9/arch/ia64/kernel/process.c	Thu Nov 22 18:18:11 2001
+++ tmp/arch/ia64/kernel/process.c	Thu Nov 22 18:25:25 2001
@@ -17,6 +17,7 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
+#include <linux/rcupdate.h>
 
 #include <asm/delay.h>
 #include <asm/efi.h>
@@ -122,7 +123,7 @@
 		if (!current->need_resched)
 			min_xtp();
 #endif
-		while (!current->need_resched)
+		while (!current->need_resched && !is_rcu_pending())
 			continue;
 #ifdef CONFIG_SMP
 		normal_xtp();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/mips/kernel/process.c tmp/arch/mips/kernel/process.c
--- linux-2.4.15-pre9/arch/mips/kernel/process.c	Mon Sep 10 03:43:01 2001
+++ tmp/arch/mips/kernel/process.c	Thu Nov 22 18:25:25 2001
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/mips64/kernel/process.c tmp/arch/mips64/kernel/process.c
--- linux-2.4.15-pre9/arch/mips64/kernel/process.c	Sat Feb 10 06:29:44 2001
+++ tmp/arch/mips64/kernel/process.c	Thu Nov 22 18:25:25 2001
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/parisc/kernel/process.c tmp/arch/parisc/kernel/process.c
--- linux-2.4.15-pre9/arch/parisc/kernel/process.c	Sat Feb 10 06:29:44 2001
+++ tmp/arch/parisc/kernel/process.c	Thu Nov 22 18:25:25 2001
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/ppc/kernel/idle.c tmp/arch/ppc/kernel/idle.c
--- linux-2.4.15-pre9/arch/ppc/kernel/idle.c	Tue Nov  6 11:41:28 2001
+++ tmp/arch/ppc/kernel/idle.c	Thu Nov 22 18:25:25 2001
@@ -23,6 +23,7 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -75,7 +76,7 @@
 		if (do_power_save && !current->need_resched)
 			power_save();
 
-		if (current->need_resched) {
+		if (current->need_resched || is_rcu_pending()) {
 			schedule();
 			check_pgt_cache();
 		}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/s390/kernel/process.c tmp/arch/s390/kernel/process.c
--- linux-2.4.15-pre9/arch/s390/kernel/process.c	Fri Oct 12 02:04:57 2001
+++ tmp/arch/s390/kernel/process.c	Thu Nov 22 18:25:25 2001
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -61,7 +62,7 @@
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup | 0x80000000L;
 	while(1) {
-                if (current->need_resched) {
+                if (current->need_resched || is_rcu_pending()) {
                         schedule();
                         check_pgt_cache();
                         continue;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/s390x/kernel/process.c tmp/arch/s390x/kernel/process.c
--- linux-2.4.15-pre9/arch/s390x/kernel/process.c	Fri Oct 12 02:04:57 2001
+++ tmp/arch/s390x/kernel/process.c	Thu Nov 22 18:25:25 2001
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -61,7 +62,7 @@
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup;
 	while(1) {
-                if (current->need_resched) {
+                if (current->need_resched || is_rcu_pending()) {
                         schedule();
                         check_pgt_cache();
                         continue;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/sh/kernel/process.c tmp/arch/sh/kernel/process.c
--- linux-2.4.15-pre9/arch/sh/kernel/process.c	Tue Oct 16 06:36:48 2001
+++ tmp/arch/sh/kernel/process.c	Thu Nov 22 18:25:25 2001
@@ -13,6 +13,7 @@
 
 #include <linux/unistd.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -49,7 +50,7 @@
 				break;
 		} else {
 			__cli();
-			while (!current->need_resched) {
+			while (!current->need_resched && !is_rcu_pending()) {
 				__sti();
 				asm volatile("sleep" : : : "memory");
 				__cli();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/sparc/kernel/process.c tmp/arch/sparc/kernel/process.c
--- linux-2.4.15-pre9/arch/sparc/kernel/process.c	Thu Nov 22 18:18:12 2001
+++ tmp/arch/sparc/kernel/process.c	Thu Nov 22 18:25:25 2001
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/arch/sparc64/kernel/process.c tmp/arch/sparc64/kernel/process.c
--- linux-2.4.15-pre9/arch/sparc64/kernel/process.c	Mon Oct 22 03:36:54 2001
+++ tmp/arch/sparc64/kernel/process.c	Thu Nov 22 18:25:25 2001
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/kernel/Makefile tmp/kernel/Makefile
--- linux-2.4.15-pre9/kernel/Makefile	Mon Sep 17 14:22:40 2001
+++ tmp/kernel/Makefile	Thu Nov 22 18:25:25 2001
@@ -9,7 +9,7 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
@@ -19,6 +19,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_SMP) += rcupdate.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/kernel/rcupdate.c tmp/kernel/rcupdate.c
--- linux-2.4.15-pre9/kernel/rcupdate.c	Thu Jan  1 10:00:00 1970
+++ tmp/kernel/rcupdate.c	Thu Nov 22 18:25:25 2001
@@ -0,0 +1,113 @@
+/* Read-Copy-Update For Linux.
+   Copyright (C) 2001 Rusty Russell.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+      Concept stolen from original Read Copy Update paper:
+
+   http://www.rdrop.com/users/paulmck/rclock/intro/rclock_intro.html and
+   http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+
+      Or the OLS paper:
+
+   http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf
+*/
+#include <linux/rcupdate.h>
+#include <linux/module.h>
+#include <linux/threads.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <asm/system.h>
+
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
+	call_rcu(&rcu, wakeme_after_rcu, &completion);
+
+	/* Wait for it */
+	wait_for_completion(&completion);
+}
+
+EXPORT_SYMBOL(synchronize_kernel);
+EXPORT_SYMBOL(call_rcu);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.15-pre9/kernel/sched.c tmp/kernel/sched.c
--- linux-2.4.15-pre9/kernel/sched.c	Thu Nov 22 18:18:54 2001
+++ tmp/kernel/sched.c	Thu Nov 22 18:29:08 2001
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/prefetch.h>
 #include <linux/compiler.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -102,12 +103,15 @@
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
 extern struct task_struct *child_reaper;
@@ -552,6 +556,22 @@
 	}
 
 	release_kernel_lock(prev, this_cpu);
+
+	if (unlikely(is_rcu_pending())) {
+		/* Avoid cache line effects if value hasn't changed */
+		c = ring_count((this_cpu + 1) % smp_num_cpus) + 1;
+		if (c != ring_count(this_cpu)) {
+			/* Do subtraction to avoid int wrap corner case */
+			if (c - finished_count(this_cpu) >= 0) {
+				/* Avoid reentry: temporarily set finish_count
+				   far in the future */
+				finished_count(this_cpu) = c + INT_MAX;
+				rcu_batch_done();
+				finished_count(this_cpu) = c + smp_num_cpus;
+			}
+			ring_count(this_cpu) = c;
+		}
+	}
 
 	/*
 	 * 'sched_data' is protected by the fact that we can run
