Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVANGMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVANGMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVANGMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:12:40 -0500
Received: from opersys.com ([64.40.108.71]:60432 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261606AbVANGDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:03:46 -0500
Message-ID: <41E76284.6090009@opersys.com>
Date: Fri, 14 Jan 2005 01:11:16 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 3/8 ] ltt for 2.6.10 : kernel/ events
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


signed-off-by: Karim Yaghmour (karim@opersys.com)

--- linux-2.6.10-relayfs/kernel/exit.c	2004-12-24 16:35:27.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/exit.c	2005-01-13 22:21:51.000000000 -0500
@@ -24,6 +24,7 @@
 #include <linux/profile.h>
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
+#include <linux/ltt-events.h>
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>

@@ -811,6 +812,8 @@ fastcall NORET_TYPE void do_exit(long co
 		acct_process(code);
 	__exit_mm(tsk);

+	ltt_ev_process_exit(0, 0);
+
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
@@ -1316,6 +1319,8 @@ static long do_wait(pid_t pid, int optio
 	struct task_struct *tsk;
 	int flag, retval;

+	ltt_ev_process(LTT_EV_PROCESS_WAIT, pid, 0);
+
 	add_wait_queue(&current->wait_chldexit,&wait);
 repeat:
 	/*
--- linux-2.6.10-relayfs/kernel/fork.c	2004-12-24 16:33:59.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/fork.c	2005-01-13 22:21:51.000000000 -0500
@@ -39,6 +39,7 @@
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
+#include <linux/ltt-events.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1159,6 +1160,8 @@ long do_fork(unsigned long clone_flags,
 			ptrace_notify ((trace << 8) | SIGTRAP);
 		}

+		ltt_ev_process(LTT_EV_PROCESS_FORK, p->pid, 0);
+
 		if (clone_flags & CLONE_VFORK) {
 			wait_for_completion(&vfork);
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
--- linux-2.6.10-relayfs/kernel/irq/handle.c	2004-12-24 16:35:50.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/irq/handle.c	2005-01-13 22:21:51.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/random.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/ltt-events.h>

 #include "internals.h"

@@ -91,6 +92,8 @@ fastcall int handle_IRQ_event(unsigned i
 {
 	int ret, retval = 0, status = 0;

+	ltt_ev_irq_entry(irq, !(user_mode(regs)));
+
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();

@@ -106,6 +109,8 @@ fastcall int handle_IRQ_event(unsigned i
 		add_interrupt_randomness(irq);
 	local_irq_disable();

+	ltt_ev_irq_exit();
+
 	return retval;
 }

--- linux-2.6.10-relayfs/kernel/itimer.c	2004-12-24 16:34:32.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/itimer.c	2005-01-13 22:21:51.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/syscalls.h>
 #include <linux/time.h>
+#include <linux/ltt-events.h>

 #include <asm/uaccess.h>

@@ -69,6 +70,8 @@ void it_real_fn(unsigned long __data)
 	struct task_struct * p = (struct task_struct *) __data;
 	unsigned long interval;

+	ltt_ev_timer(LTT_EV_TIMER_EXPIRED, 0, 0, 0);
+
 	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, p);
 	interval = p->it_real_incr;
 	if (interval) {
@@ -88,6 +91,7 @@ int do_setitimer(int which, struct itime
 	j = timeval_to_jiffies(&value->it_value);
 	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)
 		return k;
+	ltt_ev_timer(LTT_EV_TIMER_SETITIMER, which, i, j);
 	switch (which) {
 		case ITIMER_REAL:
 			del_timer_sync(&current->real_timer);
--- linux-2.6.10-relayfs/kernel/Makefile	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/Makefile	2005-01-13 22:21:56.000000000 -0500
@@ -17,6 +17,7 @@ obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
+obj-$(CONFIG_LTT) += ltt-core.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
--- linux-2.6.10-relayfs/kernel/sched.c	2004-12-24 16:35:24.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/sched.c	2005-01-13 22:21:51.000000000 -0500
@@ -44,6 +44,7 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
+#include <linux/ltt-events.h>
 #include <asm/tlb.h>

 #include <asm/unistd.h>
@@ -317,6 +318,8 @@ static runqueue_t *task_rq_lock(task_t *
 {
 	struct runqueue *rq;

+	ltt_ev_process(LTT_EV_PROCESS_WAKEUP, p->pid, p->state);
+
 repeat_lock_task:
 	local_irq_save(*flags);
 	rq = task_rq(p);
@@ -2685,6 +2688,7 @@ switch_tasks:
 		++*switch_count;

 		prepare_arch_switch(rq, next);
+		ltt_ev_schedchange(prev, next);
 		prev = context_switch(rq, prev, next);
 		barrier();

--- linux-2.6.10-relayfs/kernel/signal.c	2004-12-24 16:34:32.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/signal.c	2005-01-13 22:21:51.000000000 -0500
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/ptrace.h>
+#include <linux/ltt-events.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -833,6 +834,8 @@ specific_send_sig_info(int sig, struct s
 	if (sig_ignored(t, sig))
 		goto out;

+	ltt_ev_process(LTT_EV_PROCESS_SIGNAL, sig, t->pid);
+
 	/* Support queueing exactly one non-rt signal, so that we
 	   can get more detailed information about the cause of
 	   the signal. */
--- linux-2.6.10-relayfs/kernel/softirq.c	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/softirq.c	2005-01-13 22:21:51.000000000 -0500
@@ -16,6 +16,7 @@
 #include <linux/cpu.h>
 #include <linux/kthread.h>
 #include <linux/rcupdate.h>
+#include <linux/ltt-events.h>

 #include <asm/irq.h>
 /*
@@ -92,6 +93,7 @@ restart:

 	do {
 		if (pending & 1) {
+			ltt_ev_soft_irq(LTT_EV_SOFT_IRQ_SOFT_IRQ, (h - softirq_vec));
 			h->action(h);
 			rcu_bh_qsctr_inc(cpu);
 		}
@@ -246,6 +248,9 @@ static void tasklet_action(struct softir
 			if (!atomic_read(&t->count)) {
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
+
+				ltt_ev_soft_irq(LTT_EV_SOFT_IRQ_TASKLET_ACTION, (unsigned long) (t->func));
+
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
@@ -279,6 +284,9 @@ static void tasklet_hi_action(struct sof
 			if (!atomic_read(&t->count)) {
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
+
+				ltt_ev_soft_irq(LTT_EV_SOFT_IRQ_TASKLET_HI_ACTION, (unsigned long) (t->func));
+
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
--- linux-2.6.10-relayfs/kernel/timer.c	2004-12-24 16:35:24.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/timer.c	2005-01-13 22:21:51.000000000 -0500
@@ -32,6 +32,7 @@
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/ltt-events.h>

 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -923,6 +924,8 @@ static void run_timer_softirq(struct sof
 {
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);

+	ltt_ev(LTT_EV_KERNEL_TIMER, NULL);
+
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }
@@ -1081,6 +1084,7 @@ asmlinkage long sys_getegid(void)

 static void process_timeout(unsigned long __data)
 {
+	ltt_ev_timer(LTT_EV_TIMER_EXPIRED, 0, 0, 0);
 	wake_up_process((task_t *)__data);
 }


