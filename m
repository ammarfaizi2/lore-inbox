Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUGMRsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUGMRsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 13:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUGMRsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 13:48:35 -0400
Received: from mail.ccur.com ([208.248.32.212]:39439 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265691AbUGMRs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 13:48:26 -0400
Date: Tue, 13 Jul 2004 13:48:23 -0400
From: Joe Korty <joe.korty@ccur.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Cc: piggy@timesys.com
Subject: [PATCH] fix arbitrarily long preemption lockout times [was: re: preempt-timing-2.6.8-rc1]
Message-ID: <20040713174823.GA1941@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040713122805.GZ21066@holomorphy.com> <20040713143600.GA22758@tsunami.ccur.com> <20040713144028.GH21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713144028.GH21066@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 07:40:28AM -0700, William Lee Irwin III wrote:
> On Tue, Jul 13, 2004 at 10:36:00AM -0400, Joe Korty wrote:
>> You preemption-block hold times will improve *enormously* if you move all
>> softirq processing down to the daemon (and possibly raise the daemon to
>> one of the higher SCHED_RR priorities, to compensate for softirq processing
>> no longer happening at interrupt level).
> 
> Plausible. Got a patch?

Here it is.  Against 2.6.7.  Testing: compiles, boots, shutdown ok, ran
some disk and networking traffic under it.

IIRC, my first attempt had problems booting some configurations, my guess
is that some drivers try to raise softIRQs before the daemons came up.
So this version uses the global 'system_running' to switch at runtime
between the interrupt/daemon and daemon-only modes of operation.

This also has the advantage of switching back to the safer, interrupt/daemon
mode during system shutdown and while crash dumps are in progress (for
those who have applied that patch).

IMO, this patch would be better if it introduced a seperate, hi-priority
softirq daemon, as La Monte H.P. Yarroll's patch does.

Regards,
Joe

Signed-off-by: Joe Korty <joe.korty@ccur.com>


diff -ura base/arch/i386/kernel/irq.c new/arch/i386/kernel/irq.c
--- base/arch/i386/kernel/irq.c	2004-06-16 01:18:57.000000000 -0400
+++ new/arch/i386/kernel/irq.c	2004-07-13 12:52:33.000000000 -0400
@@ -1154,7 +1154,7 @@
 
 extern asmlinkage void __do_softirq(void);
 
-asmlinkage void do_softirq(void)
+asmlinkage void do_softirq_arch(void)
 {
 	unsigned long flags;
 	struct thread_info *curctx;
@@ -1189,5 +1189,5 @@
 	local_irq_restore(flags);
 }
 
-EXPORT_SYMBOL(do_softirq);
+EXPORT_SYMBOL(do_softirq_arch);
 #endif
diff -ura base/arch/ppc64/kernel/irq.c new/arch/ppc64/kernel/irq.c
--- base/arch/ppc64/kernel/irq.c	2004-06-16 01:19:22.000000000 -0400
+++ new/arch/ppc64/kernel/irq.c	2004-07-13 12:15:31.000000000 -0400
@@ -1015,7 +1015,7 @@
 	}
 }
 
-void do_softirq(void)
+void do_softirq_arch(void)
 {
 	unsigned long flags;
 	struct thread_info *curtp, *irqtp;
@@ -1035,7 +1035,7 @@
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(do_softirq);
+EXPORT_SYMBOL(do_softirq_arch);
 
 #endif /* CONFIG_IRQSTACKS */
 
diff -ura base/include/linux/interrupt.h new/include/linux/interrupt.h
--- base/include/linux/interrupt.h	2004-06-16 01:19:29.000000000 -0400
+++ new/include/linux/interrupt.h	2004-07-13 12:14:14.000000000 -0400
@@ -93,6 +93,7 @@
 };
 
 asmlinkage void do_softirq(void);
+asmlinkage void do_softirq_arch(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
 extern void softirq_init(void);
 #define __raise_softirq_irqoff(nr) do { local_softirq_pending() |= 1UL << (nr); } while (0)
diff -ura base/init/Kconfig new/init/Kconfig
--- base/init/Kconfig	2004-06-16 01:19:52.000000000 -0400
+++ new/init/Kconfig	2004-07-13 12:56:02.000000000 -0400
@@ -218,6 +218,43 @@
 	  This option enables access to kernel configuration file and build
 	  information through /proc/config.gz.
 
+config SOFTIRQ_PREEMPT_BLOCK
+	bool "SoftIRQs to be affected by preemption blocks"
+	default y
+	help
+	  If N then SoftIRQ interrupt handlers are to be blocked by
+	  exactly the same conditions as hard IRQ handlers.  If Y then
+	  SoftIRQ handlers are also to be blocked by preemption blocks.
+
+	  The reasons why Y is useful are too long to elaborate here.
+	  Suffice it to say that SoftIRQ handlers unlike hardIRQ handlers
+	  have no upper bounds on their execution time and allowing
+	  them to interrupt spinlocked critical regions protected only
+	  by a preemption block means that no such region can have an
+	  upper bound on the lock hold time.
+
+	  Realtime systems should say Y here, all others may say N or
+	  Y.  If unsure, say N.
+
+config SOFTIRQ_PRI
+	int "SoftIRQ daemon priority"
+	default 0
+	help
+	  Select the scheduling policy and priority for the per-cpu
+	  SoftIRQ daemons.
+
+	  If >0 then the daemons will have a policy of SCHED_FIFO and
+	  their priorities will each be set to the given value.
+
+	  If ==0 then the daemons will run with a SCHED_OTHER policy
+	  unless SOFTIRQ_PREEMPT_BLOCK is set to Y.  In that case the
+	  daemons will run under SCHED_FIFO with a priority one less
+	  than the system maximum.
+
+	  Most users should say 0 unless there is a specific priority
+	  the softIRQ daemons must run at.  If unsure, say 0.
+
+
 
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
diff -ura base/kernel/softirq.c new/kernel/softirq.c
--- base/kernel/softirq.c	2004-06-16 01:19:02.000000000 -0400
+++ new/kernel/softirq.c	2004-07-13 13:05:13.000000000 -0400
@@ -15,7 +15,9 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/kthread.h>
+#include <linux/syscalls.h>
 
+#include <asm/uaccess.h>
 #include <asm/irq.h>
 /*
    - No shared variables, all the data are CPU local.
@@ -108,7 +110,7 @@
 
 #ifndef __ARCH_HAS_DO_SOFTIRQ
 
-asmlinkage void do_softirq(void)
+asmlinkage void do_softirq_arch(void)
 {
 	__u32 pending;
 	unsigned long flags;
@@ -126,10 +128,34 @@
 	local_irq_restore(flags);
 }
 
-EXPORT_SYMBOL(do_softirq);
+EXPORT_SYMBOL(do_softirq_arch);
+
+#endif
+
+#ifdef CONFIG_SOFTIRQ_PREEMPT_BLOCK
+
+asmlinkage void do_softirq(void)
+{
+	int cpu;
+
+	cpu = get_cpu();
+	if (system_state == SYSTEM_RUNNING && per_cpu(ksoftirqd, cpu)) {
+		wakeup_softirqd();
+	} else 
+		do_softirq_arch();
+	put_cpu();
+}
+
+#else /* !CONFIG_SOFTIRQ_PREEMPT_BLOCK */
 
+asmlinkage void do_softirq()
+{
+	do_softirq_arch();
+}
 #endif
 
+EXPORT_SYMBOL(do_softirq);
+
 void local_bh_enable(void)
 {
 	__local_bh_enable();
@@ -325,6 +351,20 @@
 	set_user_nice(current, 19);
 	current->flags |= PF_NOFREEZE;
 
+#if CONFIG_SOFTIRQ_PRI > 0
+	{
+	struct sched_param priconfig = { .sched_priority = CONFIG_SOFTIRQ_PRI };
+	set_fs(KERNEL_DS);
+	sys_sched_setscheduler(0, SCHED_FIFO, &priconfig);
+	}
+#elif defined(CONFIG_SOFTIRQ_PREEMPT_BLOCK)
+	{
+	struct sched_param pridefault = { .sched_priority = MAX_RT_PRIO - 2 };
+	set_fs(KERNEL_DS);
+	sys_sched_setscheduler(0, SCHED_FIFO, &pridefault);
+	}
+#endif
+
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
@@ -340,7 +380,7 @@
 			preempt_disable();
 			if (cpu_is_offline((long)__bind_cpu))
 				goto wait_to_die;
-			do_softirq();
+			do_softirq_arch();
 			preempt_enable();
 			cond_resched();
 		}
