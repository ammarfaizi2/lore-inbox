Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262944AbSJAW6f>; Tue, 1 Oct 2002 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbSJAW6e>; Tue, 1 Oct 2002 18:58:34 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24837
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262944AbSJAW6d>; Tue, 1 Oct 2002 18:58:33 -0400
Subject: [PATCH] set_cpus_allowed() for 2.4
From: Robert Love <rml@tech9.net>
To: jgarzik@pobox.com, hch@infradead.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1033513407.12959.91.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 01 Oct 2002 19:03:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch implements set_cpus_allowed() for stock 2.4 without
the O(1) scheduler.

The calling semantics and behavior remain the same as 2.5's method.

This is to provide a backward-compatible interface, specifically for
those interested in back-porting the new workqueue code to 2.4 -
set_cpus_allowed() seems to be the only nit preventing a straight
drop-in.

Patch is against 2.4.20-pre8 and untested but does compile.

	Robert Love

diff -urN linux-2.4.20-pre8/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.4.20-pre8/include/linux/sched.h	Mon Sep 30 17:41:22 2002
+++ linux/include/linux/sched.h	Tue Oct  1 18:35:28 2002
@@ -163,6 +164,12 @@
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
 
+#if CONFIG_SMP
+extern void set_cpus_allowed(struct task_struct *p, unsigned long new_mask);
+#else
+# define set_cpus_allowed(p, new_mask) do { } while (0)
+#endif
+
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
  * as this is the granularity returned by copy_fdset().
diff -urN linux-2.4.20-pre8/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.20-pre8/kernel/ksyms.c	Mon Sep 30 17:41:22 2002
+++ linux/kernel/ksyms.c	Tue Oct  1 18:34:41 2002
@@ -451,6 +451,9 @@
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 EXPORT_SYMBOL(schedule);
 EXPORT_SYMBOL(schedule_timeout);
+#if CONFIG_SMP
+EXPORT_SYMBOL(set_cpus_allowed);
+#endif
 EXPORT_SYMBOL(yield);
 EXPORT_SYMBOL(__cond_resched);
 EXPORT_SYMBOL(jiffies);
diff -urN linux-2.4.20-pre8/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.20-pre8/kernel/sched.c	Mon Sep 30 17:41:22 2002
+++ linux/kernel/sched.c	Tue Oct  1 18:54:49 2002
@@ -850,6 +850,46 @@
 
 void scheduling_functions_end_here(void) { }
 
+#if CONFIG_SMP
+
+/**
+ * set_cpus_allowed() - change a given task's processor affinity
+ * @p: task to bind
+ * @new_mask: bitmask of allowed processors
+ *
+ * Upon return, the task is running on a legal processor.  Note the caller
+ * must have a valid reference to the task: it must not exit() prematurely.
+ * This call can sleep; do not hold locks on call.
+ */
+void set_cpus_allowed(struct task_struct *p, unsigned long new_mask)
+{
+	new_mask &= cpu_online_map;
+	BUG_ON(!new_mask);
+
+	p->cpus_allowed = new_mask;
+
+	/*
+	 * If the task is on a no-longer-allowed processor, we need to move
+	 * it.  If the task is not current, then set need_resched and send
+	 * its processor an IPI to reschedule.
+	 */
+	if (!(p->cpus_runnable & p->cpus_allowed)) {
+		if (p != current) {
+			p->need_resched = 1;
+			smp_send_reschedule(p->processor);
+		}
+		/*
+		 * Wait until we are on a legal processor.  If the task is
+		 * current, then we should be on a legal processor the next
+		 * time we reschedule.  Otherwise, we need to wait for the IPI.
+		 */
+		while (!(p->cpus_runnable & p->cpus_allowed))
+			schedule();
+	}
+}
+
+#endif /* CONFIG_SMP */
+
 #ifndef __alpha__
 
 /*
diff -urN linux-2.4.20-pre8/kernel/softirq.c linux/kernel/softirq.c
--- linux-2.4.20-pre8/kernel/softirq.c	Mon Sep 30 17:41:22 2002
+++ linux/kernel/softirq.c	Tue Oct  1 18:53:01 2002
@@ -368,9 +368,8 @@
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
-	current->cpus_allowed = 1UL << cpu;
-	while (smp_processor_id() != cpu)
-		schedule();
+	set_cpus_allowed(current, 1UL << cpu);
+	BUG_ON(smp_processor_id() != cpu);
 
 	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
 



