Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbWBOCoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbWBOCoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030600AbWBOCoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:44:34 -0500
Received: from fmr22.intel.com ([143.183.121.14]:19898 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030593AbWBOCod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:44:33 -0500
Message-ID: <43F3059A.9070601@linux.intel.com>
Date: Wed, 15 Feb 2006 18:42:34 +0800
From: bibo mao <bibo_mao@linux.intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: akpm@osdl.org
CC: anil.s.keshavamurthy@intel.com, yanmin.zhang@intel.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] kretprobe instance recycled by parent process
Content-Type: multipart/mixed;
 boundary="------------080509010202060007000703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509010202060007000703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When kretprobe probe schedule() function, if probed process exit then 
schedule() function will never return, so some kretprobe instance will 
never be recycled. By this patch the parent process will recycle 
retprobe instance of probed function, there will be no memory leak of 
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
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(tsk);
-
  	/* The process may have allocated an io port bitmap... nuke it. */
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
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(current);
-
  	ia64_drop_fpu(current);
  #ifdef CONFIG_PERFMON
         /* if needed, stop monitoring and flush state to perfmon context */
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
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(me);
-
  	if (me->thread.io_bitmap_ptr) {
  		struct tss_struct *tss = &per_cpu(init_tss, get_cpu());

diff -Nruap linux-2.6.16-rc3.org/kernel/kprobes.c 
linux-2.6.16-rc3/kernel/kprobes.c
--- linux-2.6.16-rc3.org/kernel/kprobes.c	2006-02-14 05:46:38.000000000 
+0800
+++ linux-2.6.16-rc3/kernel/kprobes.c	2006-02-14 08:16:55.000000000 +0800
@@ -323,10 +323,10 @@ struct hlist_head __kprobes *kretprobe_i
  }

  /*
- * This function is called from exit_thread or flush_thread when task tk's
- * stack is being recycled so that we can recycle any function-return probe
- * instances associated with this task. These left over instances represent
- * probed functions that have been called but will never return.
+ * This function is called from finish_task_switch when task tk becomes 
dead,
+ * so that we can recycle any function-return probe instances associated
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
--- linux-2.6.16-rc3.org/kernel/sched.c	2006-02-14 05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/kernel/sched.c	2006-02-14 06:11:57.000000000 +0800
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
+	 	 * Remove function-return probe instances associated with this task
+	 	 * and put them back on the free list.
+	 	 */
+		kprobe_flush_task(prev);
  		put_task_struct(prev);
+	}
  }

  /**

--------------080509010202060007000703
Content-Type: text/plain;
 name="kretprobe_instance_patch_2.6.16-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kretprobe_instance_patch_2.6.16-rc3"

 arch/i386/kernel/process.c    |    8 --------
 arch/ia64/kernel/process.c    |    8 --------
 arch/powerpc/kernel/process.c |    2 --
 arch/x86_64/kernel/process.c  |    8 --------
 kernel/kprobes.c              |   10 +++++-----
 kernel/sched.c                |    9 ++++++++-
 6 files changed, 13 insertions(+), 32 deletions(-)
diff -Nruap linux-2.6.16-rc3.org/arch/i386/kernel/process.c linux-2.6.16-rc3/arch/i386/kernel/process.c
--- linux-2.6.16-rc3.org/arch/i386/kernel/process.c	2006-02-14 05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/arch/i386/kernel/process.c	2006-02-14 05:48:06.000000000 +0800
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
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(tsk);
-
 	/* The process may have allocated an io port bitmap... nuke it. */
 	if (unlikely(NULL != t->io_bitmap_ptr)) {
 		int cpu = get_cpu();
diff -Nruap linux-2.6.16-rc3.org/arch/ia64/kernel/process.c linux-2.6.16-rc3/arch/ia64/kernel/process.c
--- linux-2.6.16-rc3.org/arch/ia64/kernel/process.c	2006-02-14 05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/arch/ia64/kernel/process.c	2006-02-14 05:48:40.000000000 +0800
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
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(current);
-
 	ia64_drop_fpu(current);
 #ifdef CONFIG_PERFMON
        /* if needed, stop monitoring and flush state to perfmon context */
diff -Nruap linux-2.6.16-rc3.org/arch/powerpc/kernel/process.c linux-2.6.16-rc3/arch/powerpc/kernel/process.c
--- linux-2.6.16-rc3.org/arch/powerpc/kernel/process.c	2006-02-14 05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/arch/powerpc/kernel/process.c	2006-02-14 05:49:33.000000000 +0800
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
 
diff -Nruap linux-2.6.16-rc3.org/arch/x86_64/kernel/process.c linux-2.6.16-rc3/arch/x86_64/kernel/process.c
--- linux-2.6.16-rc3.org/arch/x86_64/kernel/process.c	2006-02-14 05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/arch/x86_64/kernel/process.c	2006-02-14 05:50:02.000000000 +0800
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
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(me);
-
 	if (me->thread.io_bitmap_ptr) { 
 		struct tss_struct *tss = &per_cpu(init_tss, get_cpu());
 
diff -Nruap linux-2.6.16-rc3.org/kernel/kprobes.c linux-2.6.16-rc3/kernel/kprobes.c
--- linux-2.6.16-rc3.org/kernel/kprobes.c	2006-02-14 05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/kernel/kprobes.c	2006-02-14 08:16:55.000000000 +0800
@@ -323,10 +323,10 @@ struct hlist_head __kprobes *kretprobe_i
 }
 
 /*
- * This function is called from exit_thread or flush_thread when task tk's
- * stack is being recycled so that we can recycle any function-return probe
- * instances associated with this task. These left over instances represent
- * probed functions that have been called but will never return.
+ * This function is called from finish_task_switch when task tk becomes dead,
+ * so that we can recycle any function-return probe instances associated 
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
diff -Nruap linux-2.6.16-rc3.org/kernel/sched.c linux-2.6.16-rc3/kernel/sched.c
--- linux-2.6.16-rc3.org/kernel/sched.c	2006-02-14 05:46:38.000000000 +0800
+++ linux-2.6.16-rc3/kernel/sched.c	2006-02-14 06:11:57.000000000 +0800
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
+	 	 * Remove function-return probe instances associated with this task
+	 	 * and put them back on the free list.
+	 	 */
+		kprobe_flush_task(prev);
 		put_task_struct(prev);
+	}
 }
 
 /**

--------------080509010202060007000703--
