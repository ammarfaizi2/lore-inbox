Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTH0SRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 14:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTH0SRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 14:17:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:13214 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261369AbTH0SRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 14:17:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16204.62914.298711.293389@gargle.gargle.HOWL>
Date: Wed, 27 Aug 2003 20:17:38 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: herbert@13thfloor.at
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: UP optimizations ..
In-Reply-To: <20030827160315.GD26817@www.13thfloor.at>
References: <20030827160315.GD26817@www.13thfloor.at>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert =?iso-8859-1?Q?P=F6tzl?= writes:
 > 
 > Hi Mikael!
 > Hi Marcelo!
 > 
 > stumbled repeatedly over the patches (or what remained of them)
 > from Mikael?, replacing task->processor and friends by inline
 > functions task_cpu(task), to eliminate them on UP systems ...
 > 
 > my questions: 
 >  - is there an up to date patchset?

Yes, I've kept it up to date. In fact I've been using it in
every single 2.4 kernel I've built for the last 18+ months.
Lately also on ppc32 and x86-64.

Below is the current UP micro-optimisation patch set for 2.4.22.
It changes p->processor, p->cpus_allowed, and p->cpus_runnable
accesses (reads and writes) to use inline functions. In UP kernels
these reduce to doing nothing or returning a constant.

To keep the patch small, it doesn't change accesses in SMP-only code.
(This is also the reason why p->cpus_runnable only has a wrapper for
updates, since all reads are in SMP-only code.)

/Mikael

diff -ruN linux-2.4.22/fs/proc/array.c linux-2.4.22.up-opt/fs/proc/array.c
--- linux-2.4.22/fs/proc/array.c	2003-06-14 13:30:27.000000000 +0200
+++ linux-2.4.22.up-opt/fs/proc/array.c	2003-08-27 19:42:34.159566477 +0200
@@ -390,7 +390,7 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->processor);
+		task_cpu(task));
 	if(mm)
 		mmput(mm);
 	return res;
diff -ruN linux-2.4.22/include/linux/sched.h linux-2.4.22.up-opt/include/linux/sched.h
--- linux-2.4.22/include/linux/sched.h	2003-06-14 13:30:29.000000000 +0200
+++ linux-2.4.22.up-opt/include/linux/sched.h	2003-08-27 19:42:34.161566172 +0200
@@ -559,17 +559,77 @@
 	return p;
 }
 
+/*
+ * Wrappers for p->processor/cpus_allowed/cpus_runnable access. No-op on UP.
+ */
+#ifdef CONFIG_SMP
+
+static inline int task_cpu(const struct task_struct *p)
+{
+	return p->processor;
+}
+
+static inline void set_task_cpu(struct task_struct *p, int cpu)
+{
+	p->processor = cpu;
+}
+
+static inline unsigned long task_cpus_allowed(const struct task_struct *p)
+{
+	return p->cpus_allowed;
+}
+
+static inline void set_task_cpus_allowed(struct task_struct *p,
+					 unsigned long cpus_allowed)
+{
+	p->cpus_allowed = cpus_allowed;
+}
+
+static inline void set_task_cpus_runnable(struct task_struct *p,
+					  unsigned long cpus_runnable)
+{
+	p->cpus_runnable = cpus_runnable;
+}
+
+#else
+
+static inline int task_cpu(const struct task_struct *p)
+{
+	return 0;
+}
+
+static inline void set_task_cpu(struct task_struct *p, int cpu)
+{
+}
+
+static inline unsigned long task_cpus_allowed(const struct task_struct *p)
+{
+	return ~0UL;
+}
+
+static inline void set_task_cpus_allowed(struct task_struct *p,
+					 unsigned long cpus_allowed)
+{
+}
+
+static inline void set_task_cpus_runnable(struct task_struct *p,
+					  unsigned long cpus_runnable)
+{
+}
+
+#endif /* CONFIG_SMP */
+
 #define task_has_cpu(tsk) ((tsk)->cpus_runnable != ~0UL)
 
 static inline void task_set_cpu(struct task_struct *tsk, unsigned int cpu)
 {
-	tsk->processor = cpu;
-	tsk->cpus_runnable = 1UL << cpu;
+	set_task_cpu(tsk, cpu);
+	set_task_cpus_runnable(tsk, 1UL << cpu);
 }
 
 static inline void task_release_cpu(struct task_struct *tsk)
 {
-	tsk->cpus_runnable = ~0UL;
+	set_task_cpus_runnable(tsk, ~0UL);
 }
 
 /* per-UID process charging. */
diff -ruN linux-2.4.22/kernel/sched.c linux-2.4.22.up-opt/kernel/sched.c
--- linux-2.4.22/kernel/sched.c	2003-08-25 20:07:50.000000000 +0200
+++ linux-2.4.22.up-opt/kernel/sched.c	2003-08-27 19:42:34.163565866 +0200
@@ -359,7 +359,7 @@
 	if (task_on_runqueue(p))
 		goto out;
 	add_to_runqueue(p);
-	if (!synchronous || !(p->cpus_allowed & (1UL << smp_processor_id())))
+	if (!synchronous || !(task_cpus_allowed(p) & (1UL << smp_processor_id())))
 		reschedule_idle(p);
 	success = 1;
 out:
@@ -557,7 +557,7 @@
 	BUG_ON(!current->active_mm);
 need_resched_back:
 	prev = current;
-	this_cpu = prev->processor;
+	this_cpu = task_cpu(prev);
 
 	if (unlikely(in_interrupt())) {
 		printk("Scheduling in interrupt\n");
@@ -1364,7 +1364,7 @@
 	}
 	sched_data->curr = current;
 	sched_data->last_schedule = get_cycles();
-	clear_bit(current->processor, &wait_init_idle);
+	clear_bit(task_cpu(current), &wait_init_idle);
 }
 
 extern void init_timervecs (void);
@@ -1378,7 +1378,7 @@
 	int cpu = smp_processor_id();
 	int nr;
 
-	init_task.processor = cpu;
+	set_task_cpu(&init_task, cpu);
 
 	for(nr = 0; nr < PIDHASH_SZ; nr++)
 		pidhash[nr] = NULL;
diff -ruN linux-2.4.22/kernel/softirq.c linux-2.4.22.up-opt/kernel/softirq.c
--- linux-2.4.22/kernel/softirq.c	2002-11-30 17:12:32.000000000 +0100
+++ linux-2.4.22.up-opt/kernel/softirq.c	2003-08-27 19:42:34.164565713 +0200
@@ -368,7 +368,7 @@
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
-	current->cpus_allowed = 1UL << cpu;
+	set_task_cpus_allowed(current, 1UL << cpu);
 	while (smp_processor_id() != cpu)
 		schedule();
 
