Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTAKPU0>; Sat, 11 Jan 2003 10:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTAKPU0>; Sat, 11 Jan 2003 10:20:26 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:22532 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267260AbTAKPUY>; Sat, 11 Jan 2003 10:20:24 -0500
Date: Sat, 11 Jan 2003 15:29:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3
Message-ID: <20030111152910.A30903@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Jan 06, 2003 at 07:32:37PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o bring APM up to date

This doesn't compile on SMP.  To get Alan's update working you need rml's patch
for set_cpus_allowed() in 2.4, that I try to feed you for two month now..


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
@@ -850,6 +850,44 @@
 
 void scheduling_functions_end_here(void) { }
 
+#if CONFIG_SMP
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
+#endif /* CONFIG_SMP */
+
 #ifndef __alpha__
 
 /*
diff -urN linux-2.4.20-pre8/kernel/softirq.c linux/kernel/softirq.c
--- linux-2.4.20-pre8/kernel/softirq.c	Mon Sep 30 17:41:22 2002
+++ linux/kernel/softirq.c	Tue Oct  1 18:53:01 2002
@@ -368,9 +368,7 @@
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
-	current->cpus_allowed = 1UL << cpu;
-	while (smp_processor_id() != cpu)
-		schedule();
+	set_cpus_allowed(current, 1UL << cpu);
 
 	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
