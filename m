Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTFTLHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 07:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTFTLHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 07:07:22 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:50567 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S262874AbTFTLGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 07:06:52 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16114.60944.564269.875562@wombat.chubb.wattle.id.au>
Date: Fri, 20 Jun 2003 21:20:48 +1000
To: linux-kernel@vger.kernel.org
CC: akpm@digeo.com
Subject: [PATCH] `microstate' accounting for 2.5 kernels
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Herewith a patch (against 2.5.72+bk) to track time spent in each
internal state, and to track time spent in interrupt handlers.

A problem with current accounting is that it's statistical (so tasks
that run for less than a timeslice at exact multiple-of-timeslice
times can use lots of CPU without ever having a tick accrued to utinme
or stime), and it doesn't account for time stolen from a task by
interrupt handlers.

This patch uses a precise timer to measure time spend on the
processor, on the active or expired queues, or sleeping.

An extra file /proc/pid/msa displays the current state and the times
in microseconds in each state, or a new system call can be used to get
the timers, or the timers for all (waited for) children.

A new field per cpu in /proc/interrupts displays the amount of time in
microseconds spent handling each interrupt.  Nested interrupts aren't
accounted for correctly --- the `outer' interrupt's time includes the
nested interrupt's time in this patch. Fixing that is straightforward,
but I thought it too much effort for too little gain.

For uniprocessors, the TSC (Pentium) or ITC (IA64) are used to
timestamp the events; for SMP machines, an appropriate monotonic clock
is used.  I haven't run benchmarks for SMP machines yet; for a UP P4,
enabling the microstate accounting infrastructure adds about 5% to
context switch time.  This may be unacceptable with some workloads if
turned on all the time; however, while debugging, and for largely
processor-bound workloads, it may be acceptable.
The patch also increases the size of struct task_struct by 184 bytes.

It'd be easy to add new (sleep) microstates for particular tasks: just add
them in the enum thread_state, and add a call to msa_next_state() just
before sleeping.

I'm releasing this now, as it may help to debug some of the latency and
interactivity problems we've been seeing -- you can look and see for
yourself how much time is spent on the expired and active queues, and
how much of your timeslice is stolen for interrupt handling.
However, the code is still a bit rough in places, and is probably 2.7
material, as it adds a new feature.

Future work is to handle process migration (clocks on different
processors need not be synchronised, or even run at the same rate!),
to account separately for user and system time, and to do some better
benchmarks to characterise the performance impact.  Also to work out
how much time we're misaccounting in ignoring nested interrupts, and
to decide whether we should really be ignoring them!

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/Kconfig linux-2.5-ustate/arch/i386/Kconfig
--- linux-2.5-import/arch/i386/Kconfig	Fri Jun 20 10:31:15 2003
+++ linux-2.5-ustate/arch/i386/Kconfig	Fri Jun 20 20:53:26 2003
@@ -1442,6 +1442,15 @@
 	depends on X86_LOCAL_APIC && !X86_VISWS
 	default y
 
+config MICROSTATE
+       bool "Microstate accounting"
+       help
+         This option causes the kernel to keep very accurate track of
+	 how long your threads spend on the runqueues, running, or asleep or
+	 stopped.  It will slow down your kernel.
+	 Times are reported in /proc/pid/msa and through a new msa()
+	 system call.
+
 endmenu
 
 source "security/Kconfig"
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/entry.S linux-2.5-ustate/arch/i386/kernel/entry.S
--- linux-2.5-import/arch/i386/kernel/entry.S	Mon Jun  2 07:53:25 2003
+++ linux-2.5-ustate/arch/i386/kernel/entry.S	Fri Jun 20 20:53:26 2003
@@ -874,6 +874,7 @@
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
+	.long sys_msa
  
  
 nr_syscalls=(.-sys_call_table)/4
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/irq.c linux-2.5-ustate/arch/i386/kernel/irq.c
--- linux-2.5-import/arch/i386/kernel/irq.c	Tue Jun 10 09:07:32 2003
+++ linux-2.5-ustate/arch/i386/kernel/irq.c	Fri Jun 20 20:53:26 2003
@@ -157,10 +157,18 @@
 		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
+#ifdef CONFIG_MICROSTATE
+		seq_printf(p, "%10llu", msa_irq_time(0, i));
+#endif
 #else
 		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
+			if (cpu_online(j)) {
 				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+#ifdef CONFIG_MICROSTATE
+				seq_printf(p, "%10llu", msa_irq_time(j, i));
+#endif
+			}
+
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
@@ -422,6 +430,7 @@
 	unsigned int status;
 
 	irq_enter();
+	msa_start_irq(cpu, irq);
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
@@ -501,6 +510,7 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+	msa_finish_irq(cpu, irq);
 
 	return 1;
 }
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/Kconfig linux-2.5-ustate/arch/ia64/Kconfig
--- linux-2.5-import/arch/ia64/Kconfig	Fri Jun 20 10:31:15 2003
+++ linux-2.5-ustate/arch/ia64/Kconfig	Fri Jun 20 20:53:26 2003
@@ -827,6 +827,15 @@
 	  and restore instructions.  It's useful for tracking down spinlock
 	  problems, but slow!  If you're unsure, select N.
 
+config MICROSTATE
+       bool "Microstate accounting"
+       help
+         This option causes the kernel to keep very accurate track of
+	 how long your threads spend on the runqueues, running, or asleep or
+	 stopped.  It will slow down your kernel.
+	 Times are reported in /proc/pid/msa and through a new msa()
+	 system call.
+
 endmenu
 
 source "security/Kconfig"
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/kernel/entry.S linux-2.5-ustate/arch/ia64/kernel/entry.S
--- linux-2.5-import/arch/ia64/kernel/entry.S	Fri Jun 20 10:31:15 2003
+++ linux-2.5-ustate/arch/ia64/kernel/entry.S	Fri Jun 20 20:53:26 2003
@@ -1430,7 +1430,7 @@
 	data8 sys_clock_gettime
 	data8 sys_clock_getres			// 1255
 	data8 sys_clock_nanosleep
-	data8 ia64_ni_syscall
+	data8 sys_msa
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall			// 1260
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/kernel/irq_ia64.c linux-2.5-ustate/arch/ia64/kernel/irq_ia64.c
--- linux-2.5-import/arch/ia64/kernel/irq_ia64.c	Tue May 13 09:24:57 2003
+++ linux-2.5-ustate/arch/ia64/kernel/irq_ia64.c	Fri Jun 20 20:53:26 2003
@@ -76,6 +76,8 @@
 ia64_handle_irq (ia64_vector vector, struct pt_regs *regs)
 {
 	unsigned long saved_tpr;
+	int cpu = smp_processor_id();
+	ia64_vector oldvector;
 #ifdef CONFIG_SMP
 #	define IS_RESCHEDULE(vec)	(vec == IA64_IPI_RESCHEDULE)
 #else
@@ -119,6 +121,8 @@
 	 */
 	saved_tpr = ia64_get_tpr();
 	ia64_srlz_d();
+	oldvector = vector;
+	msa_start_irq(cpu, local_vector_to_irq(vector));
 	while (vector != IA64_SPURIOUS_INT_VECTOR) {
 		if (!IS_RESCHEDULE(vector)) {
 			ia64_set_tpr(vector);
@@ -133,7 +137,10 @@
 			ia64_set_tpr(saved_tpr);
 		}
 		ia64_eoi();
-		vector = ia64_get_ivr();
+		oldvector = vector;
+		vector = ia64_get_ivr();		
+		msa_continue_irq(cpu, local_vector_to_irq(oldvector),
+				 local_vector_to_irq(vector));
 	}
 	/*
 	 * This must be done *after* the ia64_eoi().  For example, the keyboard softirq
@@ -142,6 +149,8 @@
 	 */
 	if (local_softirq_pending())
 		do_softirq();
+
+	msa_finish_irq(cpu, local_vector_to_irq(vector));
 }
 
 #ifdef CONFIG_SMP
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/proc/base.c linux-2.5-ustate/fs/proc/base.c
--- linux-2.5-import/fs/proc/base.c	Tue Jun 10 09:07:39 2003
+++ linux-2.5-ustate/fs/proc/base.c	Fri Jun 20 20:53:26 2003
@@ -65,6 +65,9 @@
 	PROC_PID_ATTR_EXEC,
 	PROC_PID_ATTR_FSCREATE,
 #endif
+#ifdef CONFIG_MICROSTATE
+	PROC_PID_MSA,
+#endif
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -95,6 +98,9 @@
 #ifdef CONFIG_KALLSYMS
   E(PROC_PID_WCHAN,	"wchan",	S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_MICROSTATE
+  E(PROC_PID_MSA,	"msa",		S_IFREG|S_IRUGO),
+#endif
   {0,0,NULL,0}
 };
 #ifdef CONFIG_SECURITY
@@ -288,6 +294,54 @@
 }
 #endif /* CONFIG_KALLSYMS */
 
+#ifdef CONFIG_MICROSTATE
+/*
+ * provides microstate accounting information
+ *
+ */
+static int proc_pid_msa(struct task_struct *task, char *buffer) 
+{
+	struct microstates *msp = &task->microstates;
+  
+	static char *statenames[] = {
+		"Unknown",
+		"User",
+		"System",
+		"Interruptible",
+		"Uninterruptible",
+		"OnActiveQueue",
+		"OnExpiredQueue",
+		"Zombie",
+		"Stopped",
+		"Interrupted",
+	};
+	return sprintf(buffer, 
+		 "State:         %s\n"		\
+		 "ONCPU_USER     %15llu\n"	\
+		 "ONCPU_SYS      %15llu\n"	\
+		 "INTERRUPTIBLE  %15llu\n"	\
+		 "UNINTERRUPTIBLE%15llu\n"	\
+		 "INTERRUPTED    %15llu\n"	\
+		 "ACTIVEQUEUE    %15llu\n"	\
+		 "EXPIREDQUEUE   %15llu\n"	\
+		 "STOPPED        %15llu\n"	\
+		 "ZOMBIE         %15llu\n"	\
+		 "UNKNOWN        %15llu\n",
+		 msp->cur_state <= INTERRUPTED ?
+		       statenames[msp->cur_state] : "Impossible",
+		 msp->timers[ONCPU_USER],
+		 msp->timers[ONCPU_SYS],
+		 msp->timers[INTERRUPTIBLE_SLEEP],
+		 msp->timers[UNINTERRUPTIBLE_SLEEP],
+		 msp->timers[INTERRUPTED],
+		 msp->timers[ONACTIVEQUEUE],
+		 msp->timers[ONEXPIREDQUEUE],
+		 msp->timers[STOPPED],
+		 msp->timers[ZOMBIE],
+		 msp->timers[UNKNOWN]);
+}
+#endif /* CONFIG_MICROSTATE */
+
 /************************************************************************/
 /*                       Here the fs part begins                        */
 /************************************************************************/
@@ -1204,6 +1258,12 @@
 		case PROC_PID_WCHAN:
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_wchan;
+			break;
+#endif
+#ifdef CONFIG_MICROSTATE
+		case PROC_PID_MSA:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_msa;
 			break;
 #endif
 		default:
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-i386/msa.h linux-2.5-ustate/include/asm-i386/msa.h
--- linux-2.5-import/include/asm-i386/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate/include/asm-i386/msa.h	Fri Jun 20 20:53:26 2003
@@ -0,0 +1,33 @@
+/************************************************************************
+ * asm-i386/msa.h
+ *
+ * Provide an architecture-specific clock.
+ */
+
+#ifndef _ASM_I386_MSA_H
+#define _ASM_I386_MSA_H
+
+#ifdef __KERNEL__
+#include <config/smp.h>
+
+#if defined(CONFIG_X86_TSC) && !defined(CONFIG_SMP)
+#include <asm/msr.h>
+#include <asm/div64.h>
+#define MSA_NOW(now)  do {				\
+	unsigned long __low;			\
+	unsigned long __high;			\
+	rdtsc(__low, __high);			\
+	now = ((clk_t)__high << 32) | (clk_t)__low;	\
+} while (0)
+extern unsigned long cpu_khz;
+#define MSA_TO_NSEC(clk) ({ clk_t _x = ((clk) * 1000000); do_div(_x, cpu_khz); _x; })
+
+#else
+unsigned long long monotonic_clock(void);
+#define MSA_NOW(now) do { now = monotonic_clock(); } while (0)
+#define MSA_TO_NSEC(clk) (clk)
+#endif
+
+#endif /* _KERNEL */
+
+#endif /* _ASM_I386_MSA_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-i386/unistd.h linux-2.5-ustate/include/asm-i386/unistd.h
--- linux-2.5-import/include/asm-i386/unistd.h	Fri May  9 15:25:57 2003
+++ linux-2.5-ustate/include/asm-i386/unistd.h	Fri Jun 20 20:53:26 2003
@@ -273,8 +273,9 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_msa		268
 
-#define NR_syscalls 268
+#define NR_syscalls 269
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-ia64/msa.h linux-2.5-ustate/include/asm-ia64/msa.h
--- linux-2.5-import/include/asm-ia64/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate/include/asm-ia64/msa.h	Fri Jun 20 20:53:26 2003
@@ -0,0 +1,21 @@
+/************************************************************************
+ * asm-ia64/msa.h
+ *
+ * Provide an architecture-specific clock.
+ */
+
+#ifndef _ASM_IA64_MSA_H
+#define _ASM_IA64_MSA_H
+
+#ifdef __KERNEL__
+#include <asm/processor.h>
+#include <asm/timex.h>
+#include <asm/smp.h>
+
+#define MSA_NOW(now)  do { now = (clk_t)get_cycles(); } while (0)
+
+#define MSA_TO_NSEC(clk) ((1000*clk) / cpu_data(smp_processor_id())->itc_freq)
+
+#endif /* _KERNEL */
+
+#endif /* _ASM_IA64_MSA_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-ia64/unistd.h linux-2.5-ustate/include/asm-ia64/unistd.h
--- linux-2.5-import/include/asm-ia64/unistd.h	Fri Jun 20 10:31:27 2003
+++ linux-2.5-ustate/include/asm-ia64/unistd.h	Fri Jun 20 20:53:26 2003
@@ -246,7 +246,7 @@
 #define __NR_sys_clock_gettime		1254
 #define __NR_sys_clock_getres		1255
 #define __NR_sys_clock_nanosleep	1256
-
+#define __NR_msa			1257
 #ifdef __KERNEL__
 
 #define NR_syscalls			256 /* length of syscall table */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/msa.h linux-2.5-ustate/include/linux/msa.h
--- linux-2.5-import/include/linux/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate/include/linux/msa.h	Fri Jun 20 20:53:26 2003
@@ -0,0 +1,131 @@
+/* 
+ * msa.h
+ * microstate accouting 
+ */
+
+#ifndef _LINUX_MSA_H
+#define _LINUX_MSA_H
+#include <config/microstate.h>
+
+#include <asm/msa.h>
+
+typedef __u64 clk_t;
+
+extern clk_t msa_last_flip[];
+
+/*
+ * Tracked states
+ */
+
+enum thread_state {
+	UNKNOWN,
+	ONCPU_USER,
+	ONCPU_SYS,
+	INTERRUPTIBLE_SLEEP,
+	UNINTERRUPTIBLE_SLEEP,
+	ONACTIVEQUEUE,
+	ONEXPIREDQUEUE,
+	ZOMBIE,
+	STOPPED,
+	INTERRUPTED,
+	NR_MICRO_STATES /* Must be last */
+};
+
+#define ONCPU ONCPU_USER /* for now... */
+
+/*
+ * Times are tracked for the current task in timers[],
+ * and for the current task's children in child_timers[] (accumulated at wait() time)
+ */
+struct microstates {
+	enum thread_state cur_state;
+	enum thread_state next_state;
+	int lastqueued;
+	unsigned flags;
+	clk_t last_change;
+	clk_t timers[NR_MICRO_STATES];
+	clk_t child_timers[NR_MICRO_STATES];
+};
+
+/*
+ * Values for microstates.flags
+ */
+#define QUEUE_FLIPPED (1<<0)
+
+/*
+ * A system call for getting the timers.
+ * The number of timers wanted is passed as argument, in case not all 
+ * are needed (and to guard against when we add more timers!)
+ */
+
+#define MSA_SELF 0
+#define MSA_CHILDREN 1
+extern long sys_msa(int ntimers, int which, clk_t *timers);
+
+
+
+#ifdef CONFIG_MICROSTATE
+#include <asm/current.h>
+#include <asm/irq.h>
+
+
+#define MSA_SOFTIRQ NR_IRQS
+
+void
+msa_init_timer(struct task_struct *task);
+
+void msa_switch(struct task_struct *prev, struct task_struct *next);
+void msa_update_parent(struct task_struct *parent, struct task_struct *this);
+
+void msa_init(struct task_struct *p);
+void msa_set_timer(struct task_struct *p, int state);
+void msa_start_irq(int cpu, int irq);
+void msa_continue_irq(int cpu, int oldirq, int newirq);
+void msa_finish_irq(int cpu, int irq);
+
+clk_t msa_irq_time(int cpu, int irq);
+
+#ifdef TASK_STRUCT_DEFINED
+static inline void msa_next_state(struct task_struct *p, enum thread_state next_state) 
+{
+	p->microstates.next_state = next_state;
+}
+static inline void msa_flip_expired(struct task_struct *prev) {
+	prev->microstates.flags |= QUEUE_FLIPPED;
+}
+
+#else
+#define msa_next_state(p, s) ((p)->microstates.next_state = (s))
+#define msa_flip_expired(p) ((p)->microstates.flags |= QUEUE_FLIPPED)
+#endif
+#else
+
+
+static inline void msa_set_timer(struct task_struct *task, enum thread_state newstate) 
+{
+	(void)task;
+	(void)newstate;
+}
+
+static inline void
+msa_init_timer(struct task_struct *task)
+{
+	(void)task;
+}
+
+static inline void
+msa_flip_timer(struct task_struct *lastrun, struct task_struct *nexttorun)
+{
+	(void)lastrun;
+	(void)nextrun;
+}
+
+static inline
+void msa_update_parent(struct task_struct *parent, struct task_struct *this){
+	(void)parent;
+	(void)this;
+}
+
+
+#endif /* CONFIG_MICROSTATE */
+#endif /* _LINUX_MSA_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/sched.h linux-2.5-ustate/include/linux/sched.h
--- linux-2.5-import/include/linux/sched.h	Thu Jun 12 08:38:16 2003
+++ linux-2.5-ustate/include/linux/sched.h	Fri Jun 20 20:53:26 2003
@@ -28,6 +28,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/msa.h>
 
 struct exec_domain;
 
@@ -383,6 +384,9 @@
 	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
 	u64 start_time;
+#ifdef CONFIG_MICROSTATE
+	struct microstates microstates;
+#endif
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 /* process credentials */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/Makefile linux-2.5-ustate/kernel/Makefile
--- linux-2.5-import/kernel/Makefile	Mon Jun  2 07:55:05 2003
+++ linux-2.5-ustate/kernel/Makefile	Fri Jun 20 20:53:26 2003
@@ -19,6 +19,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_MICROSTATE) += msa.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/exit.c linux-2.5-ustate/kernel/exit.c
--- linux-2.5-import/kernel/exit.c	Mon Jun  2 07:55:05 2003
+++ linux-2.5-ustate/kernel/exit.c	Fri Jun 20 20:53:26 2003
@@ -81,6 +81,9 @@
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	p->parent->cnswap += p->nswap + p->cnswap;
 	sched_exit(p);
+
+	msa_update_parent(p->parent, p);
+
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
@@ -654,6 +657,7 @@
 	}
 
 	tsk->state = TASK_ZOMBIE;
+
 	/*
 	 * In the preemption case it must be impossible for the task
 	 * to get runnable again, so use "_raw_" unlock to keep
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/fork.c linux-2.5-ustate/kernel/fork.c
--- linux-2.5-import/kernel/fork.c	Mon Jun 16 08:49:52 2003
+++ linux-2.5-ustate/kernel/fork.c	Fri Jun 20 20:53:26 2003
@@ -821,6 +821,7 @@
 #endif
 	p->did_exec = 0;
 	p->state = TASK_UNINTERRUPTIBLE;
+	msa_init(p);
 
 	copy_flags(clone_flags, p);
 	if (clone_flags & CLONE_IDLETASK)
@@ -912,6 +913,7 @@
 	else
 		p->exit_signal = clone_flags & CSIGNAL;
 	p->pdeath_signal = 0;
+
 
 	/*
 	 * Share the timeslice between parent and child, thus the
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/msa.c linux-2.5-ustate/kernel/msa.c
--- linux-2.5-import/kernel/msa.c	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate/kernel/msa.c	Fri Jun 20 20:53:26 2003
@@ -0,0 +1,264 @@
+/*
+ * Microstate accounting.
+ * Try to account for various states much more accurately than
+ * the normal code does.
+ */
+
+
+#include <config/microstate.h>
+#ifdef CONFIG_MICROSTATE
+#include <asm/irq.h>
+#include <asm/hardirq.h>
+#include <linux/sched.h>
+#include <asm/uaccess.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+
+static clk_t queueflip_time[NR_CPUS];
+
+clk_t msa_irq_times[NR_CPUS][NR_IRQS + 1];
+clk_t msa_irq_entered[NR_CPUS][NR_IRQS + 1];
+int   msa_irq_pids[NR_CPUS][NR_IRQS + 1];
+
+/*
+ * Switch from one task to another.
+ * The retiring task is coming off the processor;
+ * the new task is about to run on the processor.
+ *
+ * Update the time in both.
+ *
+ * We'll eventually account for user and sys time separately.
+ * For now, they're both accumulated into ONCPU_USER.
+ */
+void
+msa_switch(struct task_struct *prev, struct task_struct *next)
+{
+	struct microstates *msprev = &prev->microstates;
+	struct microstates *msnext = &next->microstates;
+	clk_t now;
+	enum thread_state next_state;
+	int interrupted = msprev->cur_state == INTERRUPTED;
+
+	MSA_NOW(now);
+
+	if (msprev->flags & QUEUE_FLIPPED) {
+		queueflip_time[smp_processor_id()] = now;
+		msprev->flags &= ~QUEUE_FLIPPED;
+	}
+
+	/*
+	 * If the queues have been flipped,
+	 * update the state as of the last flip time.
+	 */
+	if (msnext->cur_state == ONEXPIREDQUEUE) {
+		msnext->cur_state = ONACTIVEQUEUE;
+		msnext->timers[ONEXPIREDQUEUE] += queueflip_time[msnext->lastqueued] - msnext->last_change;
+		msnext->last_change = queueflip_time[msnext->lastqueued];
+	}
+
+	msprev->timers[msprev->cur_state] += now - msprev->last_change;
+	msnext->timers[msnext->cur_state] += now - msnext->last_change;
+	
+	/* Update states */
+	if (msprev->next_state != UNKNOWN) {
+		next_state = msprev->next_state;
+		msprev->next_state = UNKNOWN;
+	} else switch(prev->state) {
+	case TASK_INTERRUPTIBLE:
+		next_state = INTERRUPTIBLE_SLEEP;
+		break;
+		
+	case TASK_UNINTERRUPTIBLE:
+		next_state = UNINTERRUPTIBLE_SLEEP;
+		break;
+
+	case TASK_STOPPED:
+		next_state = STOPPED;
+		break;
+
+	case TASK_ZOMBIE:
+		next_state = ZOMBIE;
+		break;
+
+	case TASK_DEAD:
+		next_state = ZOMBIE;
+		break;
+
+	case TASK_RUNNING:		
+		next_state = ONACTIVEQUEUE;
+		break;
+
+	default:
+		next_state = UNKNOWN;
+	}
+
+	msprev->cur_state = next_state;
+	msprev->last_change = now;
+	msprev->lastqueued = smp_processor_id();
+
+	msnext->cur_state = interrupted ? INTERRUPTED: ONCPU_USER;
+	msnext->last_change = now;
+}
+
+/*
+ * Initialise the struct microstates in a new task (called from copy_process())
+ */
+void msa_init(struct task_struct *p)
+{
+	struct microstates *msp = &p->microstates;
+
+	memset(msp, 0, sizeof *msp);
+	MSA_NOW(msp->last_change);
+	msp->cur_state = UNINTERRUPTIBLE_SLEEP;
+}
+
+/*
+ * Time stamp an explicit state change (called, e.g., from __activate_task())
+ */
+void
+msa_set_timer(struct task_struct *p, int next_state)
+{
+	clk_t now;
+	struct microstates *msp = &p->microstates;
+
+	if (msp->cur_state == INTERRUPTED)
+		msp->next_state = next_state;
+	else {
+		MSA_NOW(now);
+		msp->timers[msp->cur_state] += now - msp->last_change;
+		msp->last_change = now;
+		msp->cur_state = next_state;
+		msp->next_state = UNKNOWN;
+		msp->lastqueued = smp_processor_id();
+	}
+}
+
+/*
+ * Accumulate child times into parent, after zombie is over.
+ */
+void msa_update_parent(struct task_struct *parent, struct task_struct *this)
+{
+	enum thread_state s;
+	clk_t *msp = parent->microstates.child_timers;
+	struct microstates *mp = &this->microstates;
+	clk_t *msc = mp->timers;
+	clk_t *msgc = mp->child_timers;
+	clk_t now;
+
+	/*
+	 * State could be ZOMBIE (if parent is interested)
+	 * or something else (if the parent isn't interested)
+	 */
+	MSA_NOW(now);
+	msc[mp->cur_state] += now - mp->last_change;
+
+	for (s = 0; s < NR_MICRO_STATES; s++) {
+		*msp++ += *msc++ + *msgc++;
+	}
+}
+
+void msa_start_irq(int cpu, int irq) 
+{
+	struct task_struct *p = current;
+	struct microstates *mp = &p->microstates;
+	clk_t now;
+
+	MSA_NOW(now);
+	mp->timers[mp->cur_state] += now - mp->last_change;
+	mp->last_change = now;
+	mp->cur_state = INTERRUPTED;
+
+	msa_irq_entered[cpu][irq] = now;
+	/* DEBUGGING */
+	msa_irq_pids[cpu][irq] = current->pid;
+}
+
+void msa_continue_irq(int cpu, int oldirq, int newirq) 
+{
+	clk_t now;
+	MSA_NOW(now);
+
+	msa_irq_times[cpu][oldirq] += now - msa_irq_entered[cpu][oldirq];
+	msa_irq_entered[cpu][newirq] = now;
+	msa_irq_pids[cpu][newirq] = current->pid;
+}
+
+
+void msa_finish_irq(int cpu, int irq) 
+{
+	struct task_struct *p = current;
+	struct microstates *mp = &p->microstates;
+	clk_t now;
+
+	MSA_NOW(now);
+
+	/*
+	 * Interrupts can nest.
+	 * Set current state to ONCPU
+	 * iff we're not in a nested interrupt.
+	 */
+	if (irq_count() == 0) {
+		mp->timers[mp->cur_state] += now - mp->last_change;
+		mp->last_change = now;
+		mp->cur_state = ONCPU_USER;
+	}
+	msa_irq_times[cpu][irq] += now - msa_irq_entered[cpu][irq];
+
+}
+
+/* return interrupt handling duration in microseconds */
+clk_t msa_irq_time(int cpu, int irq) 
+{
+	clk_t x = MSA_TO_NSEC(msa_irq_times[cpu][irq]);
+	do_div(x, 1000);
+	return x;
+}
+
+/*
+ * The msa system call --- get microstate data for self or eaited-for children.
+ */
+long asmlinkage sys_msa(int ntimers, int which, clk_t __user *timers)
+{
+	clk_t now;
+	clk_t *tp;
+	int i;
+	struct microstates *msp = &current->microstates;
+
+	switch (which) {
+	case MSA_SELF:
+	case MSA_CHILDREN:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ntimers > NR_MICRO_STATES)
+		ntimers = NR_MICRO_STATES;
+	
+	if (which == MSA_SELF) {
+		BUG_ON(msp->cur_state != ONCPU_USER);
+	
+		if (ntimers > 0) {
+			MSA_NOW(now);
+			/* Should be ONCPU_SYS */
+			msp->timers[ONCPU_USER] += now - msp->last_change;
+			msp->last_change = now;
+		}
+	}
+
+	tp = which == MSA_SELF ? msp->timers : msp->child_timers;
+	for (i = UNKNOWN; i < ntimers; i++) {
+		clk_t x = MSA_TO_NSEC(*tp++);
+		if (copy_to_user(timers++, &x, sizeof x))
+			return -EFAULT;
+	}
+	return 0L;
+}
+
+#else
+long asmlinkage 
+sys_msa(int ntimers, __u64 *timers)
+{
+	return -ENOSYS;
+}
+#endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/sched.c linux-2.5-ustate/kernel/sched.c
--- linux-2.5-import/kernel/sched.c	Mon Jun 16 08:49:52 2003
+++ linux-2.5-ustate/kernel/sched.c	Fri Jun 20 20:53:26 2003
@@ -334,6 +334,7 @@
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
+	msa_set_timer(p, ONACTIVEQUEUE);
 	enqueue_task(p, rq->active);
 	nr_running_inc(rq);
 }
@@ -557,6 +558,7 @@
 	if (unlikely(!current->array))
 		__activate_task(p, rq);
 	else {
+		msa_set_timer(p, ONACTIVEQUEUE);
 		p->prio = current->prio;
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
@@ -1226,6 +1228,7 @@
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
+			msa_next_state(p, ONEXPIREDQUEUE);
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
@@ -1309,6 +1312,7 @@
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
+		msa_flip_expired(prev);
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -1324,6 +1328,8 @@
 		rq->nr_switches++;
 		rq->curr = next;
 
+		msa_switch(prev, next);
+
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
@@ -1971,6 +1977,7 @@
 	 */
 	if (likely(!rt_task(current))) {
 		dequeue_task(current, array);
+		msa_next_state(current, ONEXPIREDQUEUE);
 		enqueue_task(current, rq->expired);
 	} else {
 		list_del(&current->run_list);
