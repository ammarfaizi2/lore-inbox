Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSKDUQ0>; Mon, 4 Nov 2002 15:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSKDUQZ>; Mon, 4 Nov 2002 15:16:25 -0500
Received: from [198.149.18.6] ([198.149.18.6]:48776 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262708AbSKDUQY>;
	Mon, 4 Nov 2002 15:16:24 -0500
Date: Mon, 4 Nov 2002 22:37:25 -0500
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@connectiva.com.br.munich.sgi.com, Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021104223725.A23168@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	marcelo@connectiva.com.br, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
References: <1033513407.12959.91.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033513407.12959.91.camel@phantasy>; from rml@tech9.net on Tue, Oct 01, 2002 at 07:03:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

now that all vendors ship a backport of Ingo's O(1) scheduler external projects
like XFS have to track those projects in addition to the mainline kernel.

Having the common new APIs available in mainline would be a very good think for
thos projects.  We already have a proper yield() in 2.4.20, but the
set_cpus_allowed() API used e.g. for kernelthreads bound to CPUs is still missing.

Any chance you could apply Robert Love's patch to add it for 2.4.20-rc2?  Note
that it does not change any existing code but just adds that interface.


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
