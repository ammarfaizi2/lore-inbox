Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTBBTNN>; Sun, 2 Feb 2003 14:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTBBTNN>; Sun, 2 Feb 2003 14:13:13 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:45330 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265508AbTBBTNL>; Sun, 2 Feb 2003 14:13:11 -0500
Date: Sun, 2 Feb 2003 19:22:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alex Riesen <alexander.riesen@synopsys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre4+bk: undefined references for smp + apm
Message-ID: <20030202192240.B1723@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alex Riesen <alexander.riesen@synopsys.COM>,
	linux-kernel@vger.kernel.org
References: <20030201153428.GJ5239@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030201153428.GJ5239@riesen-pc.gr05.synopsys.com>; from alexander.riesen@synopsys.COM on Sat, Feb 01, 2003 at 04:34:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2003 at 04:34:28PM +0100, Alex Riesen wrote:
> 
> arch/i386/kernel/kernel.o(.text+0xcd12): In function `apm_save_cpus':
> : undefined reference to `set_cpus_allowed'
> arch/i386/kernel/kernel.o(.text+0xcdbf): In function `apm_bios_call':
> : undefined reference to `set_cpus_allowed'
> arch/i386/kernel/kernel.o(.text+0xce56): In function `apm_bios_call_simple':
> : undefined reference to `set_cpus_allowed'

I sent this patch (from rml) to Marcelo about a dozend times even before
people started using it for intree code and a few times after this got
introduces, but he always ignored it.  Here it is again anyway:


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
