Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUJ3Oge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUJ3Oge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbUJ3Oge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:36:34 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:39556 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261181AbUJ3OgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:36:01 -0400
Message-ID: <4183A6B9.4010307@kolivas.org>
Date: Sun, 31 Oct 2004 00:35:37 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 1/28] Infrastructure for plugsched
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCFA138C7C88B53E8BEE5243B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFA138C7C88B53E8BEE5243B
Content-Type: multipart/mixed;
 boundary="------------040601060902030003040208"

This is a multi-part message in MIME format.
--------------040601060902030003040208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Infrastructure for plugsched



--------------040601060902030003040208
Content-Type: text/x-patch;
 name="plugsched-infrastructure.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plugsched-infrastructure.patch"

To create the architecture for private per-cpu-scheduler functions we create
kernel/scheduler.c which is to contain functions common to all schedulers.

We add include/linux/scheduler.h as a common point to enter all per scheduler
information. In that we create the global sched_drv struct which will contain
the pointers to each private scheduler equivalent of the common functions.

The current kernel/sched.c will be the unique file for "ingosched" or the
default scheduler. I apologise that I couldn't think up a different name
for it after I nicknamed it :P

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-29 21:42:39.370500524 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-29 21:43:04.374598299 +1000
@@ -463,12 +463,12 @@ struct sched_domain {
 #endif
 };
 
+extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
 #ifdef ARCH_HAS_SCHED_DOMAIN
 /* Useful helpers that arch setup code may use. Defined in kernel/sched.c */
 extern cpumask_t cpu_isolated_map;
 extern void init_sched_build_groups(struct sched_group groups[],
 	                        cpumask_t span, int (*group_fn)(int cpu));
-extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 #endif /* CONFIG_SMP */
 
@@ -513,6 +513,8 @@ int set_current_groups(struct group_info
 struct audit_context;		/* See audit.c */
 struct mempolicy;
 
+#include <linux/scheduler.h>
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2003-03-27 19:01:40.000000000 +1100
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-29 21:44:58.339812499 +1000
@@ -0,0 +1,34 @@
+struct sched_drv
+{
+	void (*sched_idle_next)(void);
+	void (*set_oom_timeslice)(task_t *);
+	unsigned long (*nr_running)(void);
+	unsigned long (*nr_uninterruptible)(void);
+	unsigned long long (*nr_context_switches)(void);
+	unsigned long (*nr_iowait)(void);
+	int (*idle_cpu)(int);
+	void (*init_idle)(task_t *, int);
+	void (*exit)(task_t *);
+	void (*fork)(task_t *);
+	void (*init)(void);
+	void (*init_smp)(void);
+	void (*schedule)(void);
+	void (*tick)(void);
+	void (*tail)(task_t *);
+	int (*setscheduler)(pid_t, int, struct sched_param __user *);
+	void (*set_user_nice)(task_t *, long);
+	long (*rr_get_interval)(pid_t, struct timespec __user *);
+	long (*yield)(void);
+	int (*task_curr)(const task_t *);
+	int (*task_nice)(const task_t *);
+	int (*task_prio)(const task_t *);
+	int (*try_to_wake_up)(task_t *, unsigned, int);
+	void (*wake_up_new_task)(task_t *, unsigned long);
+#ifdef CONFIG_SMP
+	int (*migration_init)(void);
+	void (*exec)(void);
+	int (*set_cpus_allowed)(task_t *, cpumask_t);
+	void (*wait_task_inactive)(task_t *);
+	void (*cpu_attach_domain)(struct sched_domain *, int);
+#endif
+};
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2003-03-27 19:01:40.000000000 +1100
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:44:39.912688299 +1000
@@ -0,0 +1,197 @@
+/*
+ *  kernel/scheduler.c
+ *
+ *  Kernel scheduler and related syscalls
+ *
+ *  Copyright (C) 1991-2002  Linus Torvalds
+ *
+ *  Modular cpu scheduler infrastructure by Con Kolivas based on
+ *  work by William Lee Irwin III.
+ */
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/nmi.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/highmem.h>
+#include <linux/smp_lock.h>
+#include <asm/mmu_context.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/kernel_stat.h>
+#include <linux/security.h>
+#include <linux/notifier.h>
+#include <linux/profile.h>
+#include <linux/suspend.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/timer.h>
+#include <linux/rcupdate.h>
+#include <linux/cpu.h>
+#include <linux/cpuset.h>
+#include <linux/percpu.h>
+#include <linux/perfctr.h>
+#include <linux/kthread.h>
+#include <linux/seq_file.h>
+#include <linux/syscalls.h>
+#include <linux/times.h>
+#include <asm/tlb.h>
+
+#include <asm/unistd.h>
+
+extern struct sched_drv ingo_sched_drv;
+static const struct sched_drv *scheduler = &ingo_sched_drv;
+
+void sched_idle_next(void)
+{
+	scheduler->sched_idle_next();
+}
+
+unsigned long nr_running(void)
+{
+	return scheduler->nr_running();
+}
+
+unsigned long nr_uninterruptible(void)
+{
+	return scheduler->nr_uninterruptible();
+}
+
+unsigned long long nr_context_switches(void)
+{
+	return scheduler->nr_context_switches();
+}
+
+unsigned long nr_iowait(void)
+{
+	return scheduler->nr_iowait();
+}
+
+int idle_cpu(int cpu)
+{
+	return scheduler->idle_cpu(cpu);
+}
+EXPORT_SYMBOL_GPL(idle_cpu);
+
+void __devinit init_idle(task_t *task, int cpu)
+{
+	scheduler->init_idle(task, cpu);
+}
+
+void __init sched_init(void)
+{
+	scheduler->init();
+}
+
+void __init sched_init_smp(void)
+{
+	scheduler->init_smp();
+}
+
+asmlinkage void schedule(void)
+{
+	scheduler->schedule();
+}
+EXPORT_SYMBOL(schedule);
+
+void scheduler_tick(void)
+{
+	scheduler->tick();
+}
+
+#ifdef CONFIG_SMP
+int migration_init(void)
+{
+	return scheduler->migration_init();
+}
+
+int set_cpus_allowed(task_t *task, cpumask_t cpus)
+{
+	return scheduler->set_cpus_allowed(task, cpus);
+}
+EXPORT_SYMBOL_GPL(set_cpus_allowed);
+
+void wait_task_inactive(task_t * task)
+{
+	scheduler->wait_task_inactive(task);
+}
+
+void sched_exec(void)
+{
+	scheduler->exec();
+}
+
+void __devinit cpu_attach_domain(struct sched_domain *sd, int cpu)
+{
+	scheduler->cpu_attach_domain(sd, cpu);
+}
+#endif
+
+void set_user_nice(task_t *task, long nice)
+{
+	scheduler->set_user_nice(task, nice);
+}
+EXPORT_SYMBOL(set_user_nice);
+
+void set_oom_timeslice(task_t *p)
+{
+	scheduler->set_oom_timeslice(p);
+}
+
+asmlinkage
+long sys_sched_rr_get_interval(pid_t pid, struct timespec __user *interval)
+{
+	return scheduler->rr_get_interval(pid, interval);
+}
+
+asmlinkage long sys_sched_yield(void)
+{
+	return scheduler->yield();
+}
+
+int setscheduler(pid_t pid, int policy, struct sched_param __user *param)
+{
+	return scheduler->setscheduler(pid, policy, param);
+}
+
+int task_curr(const task_t *task)
+{
+	return scheduler->task_curr(task);
+}
+
+int task_nice(const task_t *task)
+{
+	return scheduler->task_nice(task);
+}
+EXPORT_SYMBOL(task_nice);
+
+int task_prio(const task_t *task)
+{
+	return scheduler->task_prio(task);
+}
+
+int try_to_wake_up(task_t *task, unsigned state, int sync)
+{
+	return scheduler->try_to_wake_up(task, state, sync);
+}
+
+void fastcall wake_up_new_task(task_t *task, unsigned long flags)
+{
+	scheduler->wake_up_new_task(task, flags);
+}
+
+void fastcall sched_fork(task_t *task)
+{
+	scheduler->fork(task);
+}
+
+void fastcall sched_exit(task_t *task)
+{
+	scheduler->exit(task);
+}
+
+asmlinkage void schedule_tail(task_t *task)
+{
+	scheduler->tail(task);
+}



--------------040601060902030003040208--

--------------enigCFA138C7C88B53E8BEE5243B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6a5ZUg7+tp6mRURAvtwAJ4hPZsO5GL2/7n6F6TYBJi8n+cPwgCfcv7A
+IlVEI6O7KuSkORnlUT/WF4=
=vYAu
-----END PGP SIGNATURE-----

--------------enigCFA138C7C88B53E8BEE5243B--
