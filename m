Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUJWTwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUJWTwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUJWTwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:52:47 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:57043 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261290AbUJWTwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:52:32 -0400
Date: Sat, 23 Oct 2004 12:47:21 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, karim@opersys.com
Subject: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041023194721.GB1268@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attaining hard-realtime response in an existing general-purpose operating
system has been seen as a "big-bang" conversion.  The problem is that
the entire OS kernel must be modified to ensure that all code paths
are deterministic.  It would be much better if there was an evolutionary
path to hard realtime.

Since multicore dies and multithreaded CPUs are quite common and
becoming quite inexpensive, why not simply designate a particular
CPU as the hard realtime CPU?  Interrupts can be directed to the
other CPUs, and cpus_allowed can be used to force processes requiring
hard-realtime support to run on the designated CPU.  Various other
tricks can be used to lock the user process's pages into memory.

This much has been done many times in many operating systems, and,
if the hard-realtime processes run strictly in user mode, this is
(almost) all that is required.

But even if the hard-realtime processes refrain from invoking system
calls, there are any number of traps and exceptions that can occur.
Besides, it is often convenient to use systems calls, for example,
a batch industrial process may require realtime response while the
batch is processing, but not between batches.  It is convenient to
allow the realtime processes to do things like log statistics to
mass storage or the network between batches, but without interfering
with any other realtime processes that might (for example) need
realtime response while preparing for the next batch.

One way to handle this is to offload the system calls and exceptions
from the designated realtime CPU to the other CPUs.  The attached
(raw, untested, probably does not compile) patch shows one way of
doing this.  Then any overly long kernel code paths execute on
the non-realtime CPUs, where they do not interfere with realtime
latency on the designated realtime CPU.

This patch does have a number of shortcomings (surprise, surprise!):

o	It is untested, probably doesn't even compile.

o	It has not been merged with Ingo's real-time preemption
	patch.  Perhaps Ingo sees this as a good thing.  ;-)

o	The designated realtime CPU is hardcoded, as is the CPU
	to which the system calls are offloaded.  This happens
	to line up with the purported PPC ability to direct all
	interrupts to CPU 0.  This would obviously need to be
	fixed in a production version.  Preferably in a way that
	matches where the PAGG/cpusets/CKRM guys end up, but they
	seem to still be hashing things out.

o	There is no API to set the new TIF_SYSCALL_RTOFFLOAD
	bit to designate the task as a hard-realtime task.  There
	are any number of ways this might be done, including
	a /proc interface, a new syscall, an ioctl, or who knows
	what else.  Suggestions welcome, especially those accompanied
	by a corresponding patch.

o	It currently handles only syscalls, not traps or exceptions.

o	It does not yet allow for real-time-safe system calls.
	This capability is quite important, as it would allow Linux
	to evolve towards hard realtime to the extent desired, one
	system call at a time, for example, as Ingo's real-time
	preemption made a particular system call deterministic.

o	Going further out over the edge, one could have system calls
	that are deterministic in some cases (e.g., writes to ramfs
	vs. writes to disk) and could offload themselves only as required.

o	There are some portions of the scheduler that acquire other
	CPUs' runqueue locks, which is not something that the designated
	realtime CPU ought to be doing.  Similarly, the other CPUs
	should not be acquiring the designated realtime CPU's runqueue
	lock.  For example, sched_migrate_task()'s job becomes more
	interesting.  There are no doubt other similar issues.

o	Real-time application developers would no doubt want some sort
	of per-task flag that prohibited offloading, so that executing
	a (non-deterministic) system call would result in an error
	rather than in offloading.

So, the idea is to provide an evolutionary path towards hard realtime
in Linux.  Capabilities within Linux can be given hard-realtime
response separately and as needed.  And there are likely a number of
capabilities that will never require hard realtime response, for example,
given current techological trends, a 1MB synchronous write to disk is
going to take some time, and will be subject to the usual retry and
error conditions.  This approach allows such operations to keep their
simpler non-realtime code.

[Stepping aside, and donning the asbestos suit with tungsten pinstripes...]

Thoughts?

						Thanx, Paul

PS.  This can also be applied to single-CPU systems, though it is not
     clear to me that it is worthwhile.  Think in terms of a realtime
     version of Xen that simulates two CPUs while running on a single
     CPU.  But enough heresy for one email...

diff -urpN -X ../dontdiff linux-2.5-2004.09.27/arch/ppc64/Kconfig linux-2.5-2004.09.27-rt/arch/ppc64/Kconfig
--- linux-2.5-2004.09.27/arch/ppc64/Kconfig	Mon Sep 27 12:11:43 2004
+++ linux-2.5-2004.09.27-rt/arch/ppc64/Kconfig	Sat Oct  2 14:05:08 2004
@@ -170,6 +170,18 @@ config IRQ_ALL_CPUS
 	  multiple CPUs.  Saying N here will route all IRQs to the first
 	  CPU.
 
+config HARD_REALTIME
+	bool "Reserve a CPU for hard realtime processes"
+	depends on SMP && PPC_MULTIPLATFORM
+	default n
+	help
+	  This option allows a CPU to be reserved for hard-realtime
+	  processes.  Any process running on the hard-realtime CPU
+	  that executes a system call will be migrated away to a
+	  non-realtime CPU for the duration of the system call.
+	  For best results, interrupts should also be directed
+	  away from the hard-realtime CPU.
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-128)"
 	range 2 128
diff -urpN -X ../dontdiff linux-2.5-2004.09.27/arch/ppc64/kernel/ptrace.c linux-2.5-2004.09.27-rt/arch/ppc64/kernel/ptrace.c
--- linux-2.5-2004.09.27/arch/ppc64/kernel/ptrace.c	Tue Sep 21 16:07:37 2004
+++ linux-2.5-2004.09.27-rt/arch/ppc64/kernel/ptrace.c	Fri Oct 15 08:10:47 2004
@@ -303,6 +303,12 @@ static void do_syscall_trace(void)
 
 void do_syscall_trace_enter(struct pt_regs *regs)
 {
+
+	/* The offload check must precede any non-realtime-safe code. */
+
+	if (test_thread_flag(TIF_SYSCALL_RTOFFLOAD))
+		do_syscall_rtoffload();
+
 	if (unlikely(current->audit_context))
 		audit_syscall_entry(current, regs->gpr[0],
 				    regs->gpr[3], regs->gpr[4],
@@ -321,4 +327,9 @@ void do_syscall_trace_leave(void)
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
 		do_syscall_trace();
+
+	/* The offload check must follow any non-realtime-safe code. */
+
+	if (test_thread_flag(TIF_SYSCALL_RTOFFLOAD))
+		do_syscall_rtoffload_return();
 }
diff -urpN -X ../dontdiff linux-2.5-2004.09.27/include/asm-ppc64/thread_info.h linux-2.5-2004.09.27-rt/include/asm-ppc64/thread_info.h
--- linux-2.5-2004.09.27/include/asm-ppc64/thread_info.h	Tue Sep 21 16:09:46 2004
+++ linux-2.5-2004.09.27-rt/include/asm-ppc64/thread_info.h	Thu Oct 14 15:44:31 2004
@@ -97,6 +97,9 @@ static inline struct thread_info *curren
 #define TIF_RUN_LIGHT		6	/* iSeries run light */
 #define TIF_ABI_PENDING		7	/* 32/64 bit switch needed */
 #define TIF_SYSCALL_AUDIT	8	/* syscall auditing active */
+#define TIF_SYSCALL_RTOFFLOAD	9	/* hard-realtime task for which
+					   system calls must be offloaded
+					   to other CPUs */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -108,7 +111,9 @@ static inline struct thread_info *curren
 #define _TIF_RUN_LIGHT		(1<<TIF_RUN_LIGHT)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
-#define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_RTOFFLOAD	(1<<TIF_SYSCALL_RTOFFLOAD)
+#define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
+				 _TIF_SYSCALL_RTOFFLOAD)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
 				 _TIF_NEED_RESCHED)
diff -urpN -X ../dontdiff linux-2.5-2004.09.27/include/linux/smp.h linux-2.5-2004.09.27-rt/include/linux/smp.h
--- linux-2.5-2004.09.27/include/linux/smp.h	Tue Sep 21 16:10:00 2004
+++ linux-2.5-2004.09.27-rt/include/linux/smp.h	Tue Oct 19 07:24:58 2004
@@ -69,6 +69,43 @@ static inline int on_each_cpu(void (*fun
 	return ret;
 }
 
+#ifdef CONFIG_HARD_REALTIME
+
+extern int realtime_cpu;
+extern int realtime_offload_cpu;
+
+/*
+ * Initialize the hard-realtime scheduling info.  Initial version
+ * very crude, just a single realtime CPU (CPU 1) and the rest being
+ * non-realtime CPUs.
+ */
+void hard_realtime_init(void);
+
+/*
+ * Move to a non-realtime CPU to do non-deterministic work, such as
+ * some system calls.  This is currently a crude hack, need to move
+ * to a deterministic migration procedure.
+ */
+static void do_syscall_rtoffload(void)
+{
+	sched_migrate_task(current, realtime_offload_cpu);
+}
+
+/*
+ * Move back to a realtime CPU to continue deterministic work, for example,
+ * after completing some system calls.  This, again, is a crude hack,
+ * need to move to a deterministic migration procedure.
+ */
+static void do_syscall_rtoffload_return(void)
+{
+	sched_migrate_task(current, realtime_cpu);
+}
+#else /* #ifdef CONFIG_HARD_REALTIME */
+#define hard_realtime_init()
+#define do_syscall_rtoffload()
+#define do_syscall_rtoffload_return()
+#endif /* #else #ifdef CONFIG_HARD_REALTIME */
+
 /*
  * True once the per process idle is forked
  */
diff -urpN -X ../dontdiff linux-2.5-2004.09.27/init/main.c linux-2.5-2004.09.27-rt/init/main.c
--- linux-2.5-2004.09.27/init/main.c	Tue Sep 21 16:10:08 2004
+++ linux-2.5-2004.09.27-rt/init/main.c	Tue Oct 19 07:04:23 2004
@@ -500,6 +500,7 @@ asmlinkage void __init start_kernel(void
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
+	hard_realtime_init();
 	build_all_zonelists();
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
diff -urpN -X ../dontdiff linux-2.5-2004.09.27/kernel/sched.c linux-2.5-2004.09.27-rt/kernel/sched.c
--- linux-2.5-2004.09.27/kernel/sched.c	Mon Sep 27 12:11:45 2004
+++ linux-2.5-2004.09.27-rt/kernel/sched.c	Tue Oct 19 07:25:12 2004
@@ -4766,3 +4766,18 @@ void __might_sleep(char *file, int line)
 }
 EXPORT_SYMBOL(__might_sleep);
 #endif
+
+#ifdef CONFIG_HARD_REALTIME
+
+int realtime_cpu;
+int realtime_offload_cpu;
+
+/*
+ * Initialize the hard-realtime offload.  Currently very crude.
+ */
+void hard_realtime_init(void)
+{
+	realtime_cpu = 1;
+	realtime_offload_cpu = 0;
+}
+#endif /* #ifdef CONFIG_HARD_REALTIME */
