Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUKIKt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUKIKt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbUKIKru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:47:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52374 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261472AbUKIKjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:39:01 -0500
Subject: [PATCH 4/11] oprofile: ia64 support for oprofile stack trace
	sampling
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-4I3gGUzWv865ZpKzB6SL"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996728.1985.787.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:38:48 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4I3gGUzWv865ZpKzB6SL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-4I3gGUzWv865ZpKzB6SL
Content-Disposition: attachment; filename=oprofile-callgraph-ia64
Content-Type: text/plain; name=oprofile-callgraph-ia64; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile ia64 arch updates, including some internal
API changes and support for stack trace sampling.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Keith Owens <kaos@melbourne.sgi.com>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---
 arch/ia64/kernel/ia64_ksyms.c  |    3 
 arch/ia64/kernel/unwind.c      |    2 
 arch/ia64/oprofile/Makefile    |    2 
 arch/ia64/oprofile/backtrace.c |  150 +++++++++++++++++++++++++++++++++++++++++
 arch/ia64/oprofile/init.c      |   10 +-
 arch/ia64/oprofile/perfmon.c   |   15 +---
 6 files changed, 167 insertions(+), 15 deletions(-)

Index: linux/arch/ia64/oprofile/perfmon.c
===================================================================
--- linux.orig/arch/ia64/oprofile/perfmon.c	2004-10-19 07:53:51.%N +1000
+++ linux/arch/ia64/oprofile/perfmon.c	2004-11-06 01:20:07.%N +1100
@@ -21,8 +21,6 @@ static int
 perfmon_handler(struct task_struct *task, void *buf, pfm_ovfl_arg_t *arg,
                 struct pt_regs *regs, unsigned long stamp)
 {
-	int cpu = smp_processor_id();
-	unsigned long eip = instruction_pointer(regs);
 	int event = arg->pmd_eventid;
  
 	arg->ovfl_ctrl.bits.reset_ovfl_pmds = 1;
@@ -31,7 +29,7 @@ perfmon_handler(struct task_struct *task
 	 * without perfmon being shutdown (e.g. SIGSEGV)
 	 */
 	if (allow_ints)
-		oprofile_add_sample(eip, !user_mode(regs), event, cpu);
+		oprofile_add_sample(regs, event);
 	return 0;
 }
 
@@ -75,21 +73,18 @@ static char * get_cpu_type(void)
 
 
 /* all the ops are handled via userspace for IA64 perfmon */
-static struct oprofile_operations perfmon_ops = {
-	.start = perfmon_start,
-	.stop = perfmon_stop,
-};
 
 static int using_perfmon;
 
-int perfmon_init(struct oprofile_operations ** ops)
+int perfmon_init(struct oprofile_operations * ops)
 {
 	int ret = pfm_register_buffer_fmt(&oprofile_fmt);
 	if (ret)
 		return -ENODEV;
 
-	perfmon_ops.cpu_type = get_cpu_type();
-	*ops = &perfmon_ops;
+	ops->cpu_type = get_cpu_type();
+	ops->start = perfmon_start;
+	ops->stop = perfmon_stop;
 	using_perfmon = 1;
 	printk(KERN_INFO "oprofile: using perfmon.\n");
 	return 0;
Index: linux/arch/ia64/oprofile/backtrace.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/ia64/oprofile/backtrace.c	2004-11-06 01:20:07.%N +1100
@@ -0,0 +1,150 @@
+/**
+ * @file backtrace.c
+ *
+ * @remark Copyright 2004 Silicon Graphics Inc.  All Rights Reserved.
+ * @remark Read the file COPYING
+ *
+ * @author Greg Banks <gnb@melbourne.sgi.com>
+ * @author Keith Owens <kaos@melbourne.sgi.com>
+ * Based on work done for the ia64 port of the SGI kernprof patch, which is
+ *    Copyright (c) 2003-2004 Silicon Graphics Inc.  All Rights Reserved.
+ */
+
+#include <linux/oprofile.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+ 
+/*
+ * For IA64 we need to perform a complex little dance to get both
+ * the struct pt_regs and a synthetic struct switch_stack in place
+ * to allow the unwind code to work.  This dance requires our unwind
+ * using code to be called from a function called from unw_init_running().
+ * There we only get a single void* data pointer, so use this struct
+ * to hold all the data we need during the unwind.
+ */
+typedef struct
+{
+	unsigned int depth;
+	struct pt_regs *regs;
+	struct unw_frame_info frame;
+	u64 *prev_pfs_loc;	/* state for WAR for old spinlock ool code */
+} ia64_backtrace_t;
+
+#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+/*
+ * Returns non-zero if the PC is in the spinlock contention out-of-line code
+ * with non-standard calling sequence (on older compilers).
+ */
+static __inline__ int in_old_ool_spinlock_code(unsigned long pc)
+{
+	extern const char ia64_spinlock_contention_pre3_4[] __attribute__ ((weak));
+	extern const char ia64_spinlock_contention_pre3_4_end[] __attribute__ ((weak));
+	unsigned long sc_start = (unsigned long)ia64_spinlock_contention_pre3_4;
+	unsigned long sc_end = (unsigned long)ia64_spinlock_contention_pre3_4_end;
+	return (sc_start && sc_end && pc >= sc_start && pc < sc_end);
+}
+#else
+/* Newer spinlock code does a proper br.call and works fine with the unwinder */
+#define in_old_ool_spinlock_code(pc)	0
+#endif
+
+/* Returns non-zero if the PC is in the Interrupt Vector Table */
+static __inline__ int in_ivt_code(unsigned long pc)
+{
+	extern char ia64_ivt[];
+	return (pc >= (u_long)ia64_ivt && pc < (u_long)ia64_ivt+32768);
+}
+
+/*
+ * Unwind to next stack frame.
+ */
+static __inline__ int next_frame(ia64_backtrace_t *bt)
+{
+	/*
+	 * Avoid unsightly console message from unw_unwind() when attempting
+	 * to unwind through the Interrupt Vector Table which has no unwind
+	 * information.
+	 */
+	if (in_ivt_code(bt->frame.ip))
+		return 0;
+
+	/*
+	 * WAR for spinlock contention from leaf functions.  ia64_spinlock_contention_pre3_4
+	 * has ar.pfs == r0.  Leaf functions do not modify ar.pfs so ar.pfs remains
+	 * as 0, stopping the backtrace.  Record the previous ar.pfs when the current
+	 * IP is in ia64_spinlock_contention_pre3_4 then unwind, if pfs_loc has not changed
+	 * after unwind then use pt_regs.ar_pfs which is where the real ar.pfs is for
+	 * leaf functions.
+	 */
+	if (bt->prev_pfs_loc && bt->regs && bt->frame.pfs_loc == bt->prev_pfs_loc)
+		bt->frame.pfs_loc = &bt->regs->ar_pfs;
+	bt->prev_pfs_loc = (in_old_ool_spinlock_code(bt->frame.ip) ? bt->frame.pfs_loc : NULL);
+	
+	return unw_unwind(&bt->frame) == 0;
+}
+
+
+static void do_ia64_backtrace(struct unw_frame_info *info, void *vdata)
+{
+	ia64_backtrace_t *bt = vdata;
+	struct switch_stack *sw;
+	int count = 0;
+	u_long pc, sp;
+
+	sw = (struct switch_stack *)(info+1);
+	/* padding from unw_init_running */
+	sw = (struct switch_stack *)(((unsigned long)sw + 15) & ~15);
+
+	unw_init_frame_info(&bt->frame, current, sw);
+
+	/* skip over interrupt frame and oprofile calls */
+	do {
+		unw_get_sp(&bt->frame, &sp);
+		if (sp >= (u_long)bt->regs)
+			break;
+		if (!next_frame(bt))
+			return;
+	} while (count++ < 200);
+
+	/* finally, grab the actual sample */
+	while (bt->depth-- && next_frame(bt)) {
+		unw_get_ip(&bt->frame, &pc);
+		oprofile_add_trace(pc);
+		if (unw_is_intr_frame(&bt->frame)) {
+			/*
+			 * Interrupt received on kernel stack; this can
+			 * happen when timer interrupt fires while processing
+			 * a softirq from the tail end of a hardware interrupt
+			 * which interrupted a system call.  Don't laugh, it
+			 * happens!  Splice the backtrace into two parts to
+			 * avoid spurious cycles in the gprof output.
+			 */
+			/* TODO: split rather than drop the 2nd half */
+			break;
+		}
+	}
+}
+
+void
+ia64_backtrace(struct pt_regs * const regs, unsigned int depth)
+{
+	ia64_backtrace_t bt;
+	unsigned long flags;
+
+	/*
+	 * On IA64 there is little hope of getting backtraces from
+	 * user space programs -- the problems of getting the unwind
+	 * information from arbitrary user programs are extreme.
+	 */
+	if (user_mode(regs))
+		return;
+
+	bt.depth = depth;
+	bt.regs = regs;
+	bt.prev_pfs_loc = NULL;
+	local_irq_save(flags);
+	unw_init_running(do_ia64_backtrace, &bt);
+	local_irq_restore(flags);
+}
Index: linux/arch/ia64/kernel/unwind.c
===================================================================
--- linux.orig/arch/ia64/kernel/unwind.c	2004-11-06 01:12:10.%N +1100
+++ linux/arch/ia64/kernel/unwind.c	2004-11-06 01:20:07.%N +1100
@@ -2110,6 +2110,8 @@ unw_init_frame_info (struct unw_frame_in
 	find_save_locs(info);
 }
 
+EXPORT_SYMBOL(unw_init_frame_info);
+
 void
 unw_init_from_blocked_task (struct unw_frame_info *info, struct task_struct *t)
 {
Index: linux/arch/ia64/oprofile/Makefile
===================================================================
--- linux.orig/arch/ia64/oprofile/Makefile	2004-10-19 07:53:43.%N +1000
+++ linux/arch/ia64/oprofile/Makefile	2004-11-06 01:20:07.%N +1100
@@ -6,5 +6,5 @@ DRIVER_OBJS := $(addprefix ../../../driv
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
-oprofile-y := $(DRIVER_OBJS) init.o
+oprofile-y := $(DRIVER_OBJS) init.o backtrace.o
 oprofile-$(CONFIG_PERFMON) += perfmon.o
Index: linux/arch/ia64/kernel/ia64_ksyms.c
===================================================================
--- linux.orig/arch/ia64/kernel/ia64_ksyms.c	2004-10-19 07:54:07.%N +1000
+++ linux/arch/ia64/kernel/ia64_ksyms.c	2004-11-06 01:20:07.%N +1100
@@ -122,3 +122,6 @@ EXPORT_SYMBOL(ia64_spinlock_contention);
 #  endif
 # endif
 #endif
+
+extern char ia64_ivt[];
+EXPORT_SYMBOL(ia64_ivt);
Index: linux/arch/ia64/oprofile/init.c
===================================================================
--- linux.orig/arch/ia64/oprofile/init.c	2004-10-19 07:53:21.%N +1000
+++ linux/arch/ia64/oprofile/init.c	2004-11-06 01:20:07.%N +1100
@@ -12,15 +12,17 @@
 #include <linux/init.h>
 #include <linux/errno.h>
  
-extern int perfmon_init(struct oprofile_operations ** ops);
+extern int perfmon_init(struct oprofile_operations * ops);
 extern void perfmon_exit(void);
+extern void ia64_backtrace(struct pt_regs * const regs, unsigned int depth);
 
-int __init oprofile_arch_init(struct oprofile_operations ** ops)
+void __init oprofile_arch_init(struct oprofile_operations * ops)
 {
 #ifdef CONFIG_PERFMON
-	return perfmon_init(ops);
+	/* perfmon_init() can fail, but we have no way to report it */
+	perfmon_init(ops);
 #endif
-	return -ENODEV;
+	ops->backtrace = ia64_backtrace;
 }
 
 

--=-4I3gGUzWv865ZpKzB6SL--

