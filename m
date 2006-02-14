Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWBNI5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWBNI5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbWBNI5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:57:49 -0500
Received: from fmr19.intel.com ([134.134.136.18]:39885 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030521AbWBNI5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:57:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] kretprobe instance recyled by parent process
Date: Tue, 14 Feb 2006 16:57:35 +0800
Message-ID: <9FBCE015AF479F46B3B410499F3AE05B0898E1@pdsmsx405>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] kretprobe instance recyled by parent process
Thread-Index: AcYxRLMXpIXdNYj9SpCVskIak3zezw==
From: "Mao, Bibo" <bibo.mao@intel.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Cc: "SystemTAP" <systemtap@sources.redhat.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>
X-OriginalArrivalTime: 14 Feb 2006 08:57:36.0169 (UTC) FILETIME=[B3430990:01C63144]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When kretprobe probe schedule() function, if probed process exit then
schedule() function will never return, so some kretprobe instance will
never be recycled. By this patch the parent process will recycle
kretprobe instance of probed function, there will be no memory leak of
kretprobe instance. This patch is based on 2.6.16-rc3.

Signed-off-by: bibo mao <bibo.mao@intel.com>

 arch/i386/kernel/process.c    |    8 --------
 arch/ia64/kernel/process.c    |    8 --------
 arch/powerpc/kernel/process.c |    2 --
 arch/x86_64/kernel/process.c  |    8 --------
 kernel/kprobes.c              |   10 +++++-----
 kernel/sched.c                |    9 ++++++++-
 6 files changed, 13 insertions(+), 32 deletions(-)

diff -Nruap linux-2.6.16-rc3.org/arch/i386/kernel/process.c
linux-2.6.16-rc3/arch/i386/kernel/process.c
--- linux-2.6.16-rc3.org/arch/i386/kernel/process.c	2006-02-14
05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/arch/i386/kernel/process.c	2006-02-14
05:48:06.000000000 +0800
@@ -38,7 +38,6 @@
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
-#include <linux/kprobes.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -364,13 +363,6 @@ void exit_thread(void)
 	struct task_struct *tsk = current;
 	struct thread_struct *t = &tsk->thread;
 
-	/*
-	 * Remove function-return probe instances associated with this
task
-	 * and put them back on the free list. Do not insert an exit
probe for
-	 * this function, it will be disabled by kprobe_flush_task if
you do.
-	 */
-	kprobe_flush_task(tsk);
-
 	/* The process may have allocated an io port bitmap... nuke it.
*/
 	if (unlikely(NULL != t->io_bitmap_ptr)) {
 		int cpu = get_cpu();
diff -Nruap linux-2.6.16-rc3.org/arch/ia64/kernel/process.c
linux-2.6.16-rc3/arch/ia64/kernel/process.c
--- linux-2.6.16-rc3.org/arch/ia64/kernel/process.c	2006-02-14
05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/arch/ia64/kernel/process.c	2006-02-14
05:48:40.000000000 +0800
@@ -30,7 +30,6 @@
 #include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/kprobes.h>
 
 #include <asm/cpu.h>
 #include <asm/delay.h>
@@ -738,13 +737,6 @@ void
 exit_thread (void)
 {
 
-	/*
-	 * Remove function-return probe instances associated with this
task
-	 * and put them back on the free list. Do not insert an exit
probe for
-	 * this function, it will be disabled by kprobe_flush_task if
you do.
-	 */
-	kprobe_flush_task(current);
-
 	ia64_drop_fpu(current);
 #ifdef CONFIG_PERFMON
        /* if needed, stop monitoring and flush state to perfmon context
*/
diff -Nruap linux-2.6.16-rc3.org/arch/powerpc/kernel/process.c
linux-2.6.16-rc3/arch/powerpc/kernel/process.c
--- linux-2.6.16-rc3.org/arch/powerpc/kernel/process.c	2006-02-14
05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/arch/powerpc/kernel/process.c	2006-02-14
05:49:33.000000000 +0800
@@ -37,7 +37,6 @@
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
 #include <linux/utsname.h>
-#include <linux/kprobes.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -457,7 +456,6 @@ void show_regs(struct pt_regs * regs)
 
 void exit_thread(void)
 {
-	kprobe_flush_task(current);
 	discard_lazy_cpu_state();
 }
 
diff -Nruap linux-2.6.16-rc3.org/arch/x86_64/kernel/process.c
linux-2.6.16-rc3/arch/x86_64/kernel/process.c
--- linux-2.6.16-rc3.org/arch/x86_64/kernel/process.c	2006-02-14
05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/arch/x86_64/kernel/process.c	2006-02-14
05:50:02.000000000 +0800
@@ -35,7 +35,6 @@
 #include <linux/ptrace.h>
 #include <linux/utsname.h>
 #include <linux/random.h>
-#include <linux/kprobes.h>
 #include <linux/notifier.h>
 
 #include <asm/uaccess.h>
@@ -353,13 +352,6 @@ void exit_thread(void)
 	struct task_struct *me = current;
 	struct thread_struct *t = &me->thread;
 
-	/*
-	 * Remove function-return probe instances associated with this
task
-	 * and put them back on the free list. Do not insert an exit
probe for
-	 * this function, it will be disabled by kprobe_flush_task if
you do.
-	 */
-	kprobe_flush_task(me);
-
 	if (me->thread.io_bitmap_ptr) { 
 		struct tss_struct *tss = &per_cpu(init_tss, get_cpu());
 
diff -Nruap linux-2.6.16-rc3.org/kernel/kprobes.c
linux-2.6.16-rc3/kernel/kprobes.c
--- linux-2.6.16-rc3.org/kernel/kprobes.c	2006-02-14
05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/kernel/kprobes.c	2006-02-14 08:16:55.000000000
+0800
@@ -323,10 +323,10 @@ struct hlist_head __kprobes *kretprobe_i
 }
 
 /*
- * This function is called from exit_thread or flush_thread when task
tk's
- * stack is being recycled so that we can recycle any function-return
probe
- * instances associated with this task. These left over instances
represent
- * probed functions that have been called but will never return.
+ * This function is called from finish_task_switch when task tk becomes
dead,
+ * so that we can recycle any function-return probe instances
associated 
+ * with this task. These left over instances represent probed functions

+ * that have been called but will never return.
  */
 void __kprobes kprobe_flush_task(struct task_struct *tk)
 {
@@ -336,7 +336,7 @@ void __kprobes kprobe_flush_task(struct 
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&kretprobe_lock, flags);
-        head = kretprobe_inst_table_head(current);
+        head = kretprobe_inst_table_head(tk);
         hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
                 if (ri->task == tk)
                         recycle_rp_inst(ri);
diff -Nruap linux-2.6.16-rc3.org/kernel/sched.c
linux-2.6.16-rc3/kernel/sched.c
--- linux-2.6.16-rc3.org/kernel/sched.c	2006-02-14 05:46:38.000000000
+0800
+++ linux-2.6.16-rc3/kernel/sched.c	2006-02-14 06:11:57.000000000
+0800
@@ -49,6 +49,7 @@
 #include <linux/syscalls.h>
 #include <linux/times.h>
 #include <linux/acct.h>
+#include <linux/kprobes.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -1566,8 +1567,14 @@ static inline void finish_task_switch(ru
 	finish_lock_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
-	if (unlikely(prev_task_flags & PF_DEAD))
+	if (unlikely(prev_task_flags & PF_DEAD)){
+		/*
+	 	 * Remove function-return probe instances associated
with this task
+	 	 * and put them back on the free list.
+	 	 */
+		kprobe_flush_task(prev);
 		put_task_struct(prev);
+	}
 }
 
 /**
