Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTEETNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTEETNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:13:21 -0400
Received: from verein.lst.de ([212.34.181.86]:18440 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261239AbTEETNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:13:18 -0400
Date: Mon, 5 May 2003 21:25:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: davidm@mostang.com, ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] fixing the irqwcpustat mess
Message-ID: <20030505212546.A24006@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, davidm@mostang.com,
	ak@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

currently only x86_64 and ia64 don't use the generic irq_cpustat code
and both have to workaround it's brokenness for the non-default case.

x86_64 defines an empty irq_cpustat_t even if it doesn't need one and
ia64 adds CONFIG_IA64 ifdefs around all users.  What about this patch
instead to make __ARCH_IRQ_STAT useable?


--- 1.11/include/asm-ia64/hardirq.h	Wed Feb  5 06:03:22 2003
+++ edited/include/asm-ia64/hardirq.h	Tue Apr 22 22:03:09 2003
@@ -16,6 +16,9 @@
 /*
  * No irq_cpustat_t for IA-64.  The data is held in the per-CPU data structure.
  */
+
+#define __ARCH_IRQ_STAT	1
+
 #define softirq_pending(cpu)		(cpu_data(cpu)->softirq_pending)
 #define syscall_count(cpu)		/* unused on IA-64 */
 #define ksoftirqd_task(cpu)		(cpu_data(cpu)->ksoftirqd)
--- 1.3/include/asm-x86_64/hardirq.h	Tue Nov 12 18:13:39 2002
+++ edited/include/asm-x86_64/hardirq.h	Tue Apr 22 22:03:10 2003
@@ -12,10 +12,6 @@
    special access macros. This would generate better code. */ 
 #define __IRQ_STAT(cpu,member) (read_pda(me)->member)
 
-typedef struct {
-	/* Empty. All the fields have moved to the PDA. */
-} irq_cpustat_t; 
-
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
 /*
--- 1.7/include/linux/irq_cpustat.h	Mon Mar 31 18:21:49 2003
+++ edited/include/linux/irq_cpustat.h	Tue Apr 22 22:03:10 2003
@@ -17,9 +17,8 @@
  * definitions instead of differing sets for each arch.
  */
 
-extern irq_cpustat_t irq_stat[];			/* defined in asm/hardirq.h */
-
-#ifndef __ARCH_IRQ_STAT /* Some architectures can do this more efficiently */ 
+#ifndef __ARCH_IRQ_STAT
+extern irq_cpustat_t irq_stat[];		/* defined in asm/hardirq.h */
 #ifdef CONFIG_SMP
 #define __IRQ_STAT(cpu, member)	(irq_stat[cpu].member)
 #else
@@ -31,8 +30,11 @@
 #define softirq_pending(cpu)	__IRQ_STAT((cpu), __softirq_pending)
 #define local_softirq_pending()	softirq_pending(smp_processor_id())
 #define syscall_count(cpu)	__IRQ_STAT((cpu), __syscall_count)
+#define local_syscall_count()	syscall_count(smp_processor_id())
 #define ksoftirqd_task(cpu)	__IRQ_STAT((cpu), __ksoftirqd_task)
+#define local_ksoftirqd_task()	ksoftirqd_task(smp_processor_id())
+
   /* arch dependent irq_stat fields */
-#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)		/* i386, ia64 */
+#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
 
 #endif	/* __irq_cpustat_h */
--- 1.189/kernel/ksyms.c	Sat Apr 12 18:37:08 2003
+++ edited/kernel/ksyms.c	Tue Apr 22 22:03:10 2003
@@ -400,7 +400,6 @@
 EXPORT_SYMBOL(del_timer);
 EXPORT_SYMBOL(request_irq);
 EXPORT_SYMBOL(free_irq);
-EXPORT_SYMBOL(irq_stat);
 
 /* waitqueue handling */
 EXPORT_SYMBOL(add_wait_queue);
--- 1.39/kernel/softirq.c	Wed Apr 16 09:51:47 2003
+++ edited/kernel/softirq.c	Tue Apr 22 22:03:10 2003
@@ -33,7 +33,10 @@
    - Tasklets: serialized wrt itself.
  */
 
+#ifndef __ARCH_IRQ_STAT
 irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
+EXPORT_SYMBOL(irq_stat);
+#endif
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
 
@@ -321,7 +324,7 @@
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
 
-	ksoftirqd_task(cpu) = current;
+	local_ksoftirqd_task() = current;
 
 	for (;;) {
 		if (!local_softirq_pending())
