Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUKAD6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUKAD6f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 22:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUKAD6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 22:58:34 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:55990 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261742AbUKAD6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 22:58:16 -0500
Message-ID: <cone.1099281486.16793.26204.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>
Subject: [PATCH][plugsched additions 1/2] Add optional functions to
         set_task_cpu
Date: Mon, 01 Nov 2004 14:58:06 +1100
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1099281486-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1099281486-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Add optional functions to set_task_cpu



--=_pc.kolivas.org-1099281486-0000
Content-Description: Add optional functions to set_task_cpu
Content-Disposition: inline;
  FILENAME="optional_set_task_cpu.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Some cpu schedulers may want to do work when set task_cpu is called. For
completeness, Add a common version of task_cpu and set_task_cpu to
scheduler.c and make it privatised.

Add support to ingosched and staircase.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-30 22:00:40.000000000 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-31 22:16:59.186092025 +1100
@@ -1076,33 +1076,8 @@ extern void recalc_sigpending(void);
 
 extern void signal_wake_up(struct task_struct *t, int resume_stopped);
 
-/*
- * Wrappers for p->thread_info->cpu access. No-op on UP.
- */
-#ifdef CONFIG_SMP
-
-static inline unsigned int task_cpu(const struct task_struct *p)
-{
-	return p->thread_info->cpu;
-}
-
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-	p->thread_info->cpu = cpu;
-}
-
-#else
-
-static inline unsigned int task_cpu(const struct task_struct *p)
-{
-	return 0;
-}
-
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-}
-
-#endif /* CONFIG_SMP */
+extern unsigned int task_cpu(const struct task_struct *p);
+extern void set_task_cpu(struct task_struct *p, unsigned int cpu);
 
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 extern void arch_pick_mmap_layout(struct mm_struct *mm);
Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-30 22:00:40.000000000 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-31 22:17:25.920994749 +1100
@@ -10,6 +10,8 @@
  */
 struct sched_drv
 {
+	unsigned int (*task_cpu)(const struct task_struct *);
+	void (*set_task_cpu)(struct task_struct *, unsigned int);
 	void (*init_sched_domain_sysctl)(void);
 	void (*destroy_sched_domain_sysctl)(void);
 	void (*account_steal_time)(struct task_struct *, cputime_t);
@@ -57,6 +59,12 @@ struct sched_drv
 };
 
 /*
+ * List functions that have common variants that many schedulers use.
+ */
+extern unsigned int common_task_cpu(const struct task_struct *p);
+extern void common_set_task_cpu(struct task_struct *p, unsigned int cpu);
+
+/*
  * All private per-scheduler entries in task_struct are defined here as
  * separate structs placed into the cpusched union in task_struct.
  */
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-30 22:00:40.000000000 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-31 22:09:06.263548556 +1100
@@ -4085,6 +4085,8 @@ static void ingo_destroy_sched_domain_sy
 #endif
 
 struct sched_drv ingo_sched_drv = {
+	.task_cpu		= common_task_cpu,
+	.set_task_cpu		= common_set_task_cpu,
 	.init_sched_domain_sysctl = ingo_init_sched_domain_sysctl,
 	.destroy_sched_domain_sysctl = ingo_destroy_sched_domain_sysctl,
 	.account_steal_time	= ingo_account_steal_time,
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-30 22:00:40.000000000 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-31 22:17:43.240340395 +1100
@@ -44,6 +44,10 @@
 DEFINE_PER_CPU(struct kernel_stat, kstat);
 EXPORT_PER_CPU_SYMBOL(kstat);
 
+unsigned int task_cpu(const struct task_struct *p);
+
+void set_task_cpu(struct task_struct *p, unsigned int cpu);
+
 #ifdef CONFIG_SMP
 /***
  * kick_process - kick a running thread to enter/exit the kernel
@@ -62,7 +66,31 @@ void kick_process(task_t *p)
 		smp_send_reschedule(cpu);
 	preempt_enable();
 }
-#endif
+
+/*
+ * Wrappers for p->thread_info->cpu access. No-op on UP.
+ */
+unsigned int common_task_cpu(const struct task_struct *p)
+{
+	return p->thread_info->cpu;
+}
+
+void common_set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+	p->thread_info->cpu = cpu;
+}
+
+#else
+
+unsigned int common_task_cpu(const struct task_struct *p)
+{
+	return 0;
+}
+
+void common_set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+}
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PREEMPT
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -1000,6 +1028,16 @@ static int __init scheduler_setup(char *
 
 __setup ("cpusched=", scheduler_setup);
 
+unsigned int task_cpu(const struct task_struct *p)
+{
+	return scheduler->task_cpu(p);
+}
+
+void set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+	scheduler->set_task_cpu(p, cpu);
+}
+
 void init_sched_domain_sysctl(void)
 {
 	scheduler->init_sched_domain_sysctl();
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/staircase.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/staircase.c	2004-10-30 22:00:40.000000000 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/staircase.c	2004-10-31 22:09:18.226716200 +1100
@@ -3817,6 +3817,8 @@ static void sc_destroy_sched_domain_sysc
 #endif
 
 struct sched_drv sc_sched_drv = {
+	.task_cpu		= common_task_cpu,
+	.set_task_cpu		= common_set_task_cpu,
 	.init_sched_domain_sysctl = sc_init_sched_domain_sysctl,
 	.destroy_sched_domain_sysctl = sc_destroy_sched_domain_sysctl,
 	.account_steal_time	= sc_account_steal_time,

--=_pc.kolivas.org-1099281486-0000--
