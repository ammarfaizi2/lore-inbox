Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318732AbSG0Kwc>; Sat, 27 Jul 2002 06:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSG0Kwc>; Sat, 27 Jul 2002 06:52:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28386 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318732AbSG0Kwa>;
	Sat, 27 Jul 2002 06:52:30 -0400
Date: Sat, 27 Jul 2002 12:54:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] scheduler, migration startup fixes, 2.5.29
Message-ID: <Pine.LNX.4.44.0207271254200.13591-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes the scheduler's migration thread startup bug that
got unearthed by Rusty's recent CPU-startup enhancements.

the fix is to let a startup-helper thread migrate the migration thread,
instead of the migration thread calling set_cpus_allowed() itself.  
Migrating a not running thread is a simple and robust thing, and needs no
cooperation from migration threads - thus the catch-22 problem of how to
migrate the migration threads is solved finally.

the patch is against Rusty's initcall fix/hack which calls
migration_init() before other CPUs are brought up - this ordering is
clearly the clean way of doing migration init. [the patch also fixes a UP
compiliation bug in Rusty's hack.]

tested on x86 SMP and UP.

	Ingo

--- linux/kernel/sched.c.orig	Sat Jul 27 12:25:07 2002
+++ linux/kernel/sched.c	Sat Jul 27 12:48:33 2002
@@ -16,19 +16,23 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  */
 
+#define __KERNEL_SYSCALLS__
+
 #include <linux/mm.h>
 #include <linux/nmi.h>
 #include <linux/init.h>
-#include <asm/uaccess.h>
+#include <linux/delay.h>
+#include <linux/unistd.h>
 #include <linux/highmem.h>
+#include <linux/security.h>
+#include <linux/notifier.h>
 #include <linux/smp_lock.h>
-#include <asm/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
-#include <linux/security.h>
-#include <linux/notifier.h>
-#include <linux/delay.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -1816,18 +1820,57 @@
 	preempt_enable();
 }
 
+/*
+ * The migration thread startup relies on the following property
+ * of set_cpus_allowed(): if the thread is not running currently
+ * then we can just put it into the target runqueue.
+ */
+DECLARE_MUTEX_LOCKED(migration_startup);
+
+typedef struct migration_startup_data {
+	int cpu;
+	task_t *thread;
+} migration_startup_t;
+
+static int migration_startup_thread(void * data)
+{
+	migration_startup_t *startup = data;
+
+	wait_task_inactive(startup->thread);
+	set_cpus_allowed(startup->thread, 1UL << startup->cpu);
+	up(&migration_startup);
+
+	return 0;
+}
+
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = (int) (long) bind_cpu;
 	struct sched_param param = { sched_priority: MAX_RT_PRIO-1 };
+	migration_startup_t startup;
 	runqueue_t *rq;
-	int ret;
+	int ret, pid;
 
 	daemonize();
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 
-	set_cpus_allowed(current, 1UL << cpu);
+	startup.cpu = cpu;
+	startup.thread = current;
+	pid = kernel_thread(migration_startup_thread, &startup,
+		CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+	down(&migration_startup);
+
+	/* we need to waitpid() to release the helper thread */
+	waitpid(pid, NULL, __WCLONE);
+
+	/*
+	 * At this point the startup helper thread must have
+	 * migrated us to the proper CPU already:
+	 */
+	if (smp_processor_id() != (int)bind_cpu)
+		BUG();
+
 	printk("migration_task %d on cpu=%d\n", cpu, smp_processor_id());
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
@@ -1888,13 +1931,14 @@
 			  unsigned long action,
 			  void *hcpu)
 {
+	unsigned long cpu = (unsigned long)hcpu;
+
 	switch (action) {
 	case CPU_ONLINE:
-		printk("Starting migration thread for cpu %li\n",
-		       (long)hcpu);
-		kernel_thread(migration_thread, hcpu,
+		printk("Starting migration thread for cpu %li\n", cpu);
+		kernel_thread(migration_thread, (void *)cpu,
 			      CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
-		while (!cpu_rq((long)hcpu)->migration_thread)
+		while (!cpu_rq(cpu)->migration_thread)
 			yield();
 		break;
 	}
--- linux/init/main.c.orig	Sat Jul 27 12:50:10 2002
+++ linux/init/main.c	Sat Jul 27 12:50:46 2002
@@ -526,10 +526,14 @@
 
 static void do_pre_smp_initcalls(void)
 {
+#if CONFIG_SMP
 	extern int migration_init(void);
+#endif
 	extern int spawn_ksoftirqd(void);
 
+#if CONFIG_SMP
 	migration_init();
+#endif
 	spawn_ksoftirqd();
 }
 


