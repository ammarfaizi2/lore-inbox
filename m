Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbTFZKmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 06:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbTFZKmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 06:42:00 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:56718 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S265540AbTFZKli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 06:41:38 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
Message-ID: <16122.53548.124707.251403@wombat.chubb.wattle.id.au>
Date: Thu, 26 Jun 2003 20:55:40 +1000
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CLNIlsFpsO"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
CC: akpm@digeo.com, kernel@kolivas.org
Subject: Microstate accounting patch, try 2.
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CLNIlsFpsO
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


Hi,
	Thanks to Andrew Morton who tried some things that I probably
should have but didn't, here's the second version of a patch to give
microstate accounting capability to Linux 2.5.73

I've also included a sample program to use the new system call, and to
print out the times spent on active and expired queues, time spent
sleeping, and time spent interrupted, etc.

To save you having to dig up my previous email, here's what it does
again:
	-- The results of getrusage() are unreliable in two ways:
	   1. Interrupt handlers are charged to the task that was
	      interrupted, giving too high a system time.
	   2. User and system times are accrued at scheduler_tick
	      time.  If a task is I/O bound, then it tends to do a
	      little bit of work (less than a tick) then sleep,
	      so it's almost never running when the tick happens, so
	      the user time is too low.

	-- To diagnose some of the interactivity problems we've been
	seeing in 2.5, you really want to know if the problem is that
	a task is spending too much time on the EXPIRED queue, is being
	starved because of interrupt load, or whatever. The attached
	patch allows one to measure these directly.

The Microstate accounting patch (MSA) measures with the precision of
the in-chip clock (TSC on IA32, ITC on IA64) the time spent in the
various states, and exports the timers via a new system call (msa())
and through a new file /proc/pid/msa

It gives misleading results on my laptop, where the power management
seems to change the TSC frequency rather often, but on the UP P4
desktop machine, and the single and dual Itanium-2 boxes I tried, the
results correlate extremely well with other timing information that I
have (e.g., perfmon).  I tried using the monotonic clock but that had
the same problem (i.e., when the machine is less than 100% utilised,
the clock speed drops and the INTERRUPTIBLE SLEEP timer reads low)

The measured overhead of having MSA in place is available on
http://www.gelato.unsw.edu.au/IA64wiki/MicroStateAccounting 
To summarise: the cost of a context switch goes up by under 5%; but
kernbench shows no significant time differences between with and without the
patch in and enabled.


--CLNIlsFpsO
Content-Type: text/plain
Content-Description: ruse.c -- exercise sys_msa
Content-Disposition: inline;
	filename="ruse.c"
Content-Transfer-Encoding: 7bit

/*************************************************************************
 * ruse.c -- get as much info as possible out of the system about a process,
 * and print it out.
 */

#include <asm/types.h>
#include <linux/msa.h>
#include <linux/unistd.h>

#include <stdlib.h>
#include <sys/resource.h>
#include <assert.h>
#include <signal.h>
#include <stdio.h>

#ifdef __IA64
static inline long msa(int ntimers, int which, clk_t *timers)
{
	return syscall(__NR_sys_msa, ntimers, which, timers);
}
#else
static inline long msa(int ntimers, int which, clk_t *timers)
{
	return syscall(__NR_msa, ntimers, which, timers);
}
#endif
struct {
	int index;
	char *name;
} names[NR_MICRO_STATES] = {
#define X(a) {a, #a}
	X(UNKNOWN),
	X(ONCPU_USER),
	X(ONCPU_SYS),
	X(INTERRUPTIBLE_SLEEP),
	X(UNINTERRUPTIBLE_SLEEP),
	X(ONACTIVEQUEUE),
	X(ONEXPIREDQUEUE),
	X(ZOMBIE),
	X(STOPPED),
	X(INTERRUPTED),
};
	

int
main(int ac, char **av)
{
	clk_t posttimers[NR_MICRO_STATES];
	struct rusage usage;
	pid_t kidpid;
	int i;
	int status;
	struct timeval before;
	struct timeval after;


	gettimeofday(&before, NULL);
	switch(kidpid = fork()) {
	case -1:
		perror("fork");
		return 1;

	case 0: {
		/* child */
		for (i = 3; i < 512; i++)
			close(i);
		execvp(av[1], &av[1]);
		perror("exec");
		return 1;
	}
	default:
		break;
	}
	signal(SIGINT, SIG_IGN);

	wait4(kidpid, &status, 0, &usage);
	gettimeofday(&after, NULL);
	after.tv_sec -= before.tv_sec;
	while (after.tv_usec  < before.tv_usec) {
		after.tv_sec--;
		after.tv_usec += 1000000;
	}
	after.tv_usec -= before.tv_usec;

	msa(NR_MICRO_STATES, MSA_CHILDREN, posttimers);

	printf("%2d.%03d User %2d.%03d Sys %2d.%03d Real\n",
	       usage.ru_utime.tv_sec,
	       usage.ru_utime.tv_usec / 1000,
	       usage.ru_stime.tv_sec,
	       usage.ru_stime.tv_usec / 1000,
	       after.tv_sec,
	       after.tv_usec / 1000);

	for (i = 0; i < NR_MICRO_STATES; i++) {
		assert(names[i].index == i);
		printf("%s %g\n", names[i].name, (double)posttimers[i]/1.0e9);
	}

	return status;
}

--CLNIlsFpsO
Content-Type: text/plain
Content-Description: MSA patch against 2.5.73+bk
Content-Disposition: inline;
	filename="p1"
Content-Transfer-Encoding: 7bit

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/Kconfig linux-2.5-ustate-import/arch/i386/Kconfig
--- linux-2.5-import/arch/i386/Kconfig	Fri Jun 20 10:31:15 2003
+++ linux-2.5-ustate-import/arch/i386/Kconfig	Wed Jun 25 12:00:41 2003
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/entry.S linux-2.5-ustate-import/arch/i386/kernel/entry.S
--- linux-2.5-import/arch/i386/kernel/entry.S	Tue Jun 24 09:37:32 2003
+++ linux-2.5-ustate-import/arch/i386/kernel/entry.S	Wed Jun 25 12:00:41 2003
@@ -876,5 +876,6 @@
  	.long sys_clock_nanosleep
 	.long sys_statfs64
 	.long sys_fstatfs64	
+	.long sys_msa			/* 270 */
  
 nr_syscalls=(.-sys_call_table)/4
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/irq.c linux-2.5-ustate-import/arch/i386/kernel/irq.c
--- linux-2.5-import/arch/i386/kernel/irq.c	Tue Jun 10 09:07:32 2003
+++ linux-2.5-ustate-import/arch/i386/kernel/irq.c	Wed Jun 25 12:00:41 2003
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/Kconfig linux-2.5-ustate-import/arch/ia64/Kconfig
--- linux-2.5-import/arch/ia64/Kconfig	Fri Jun 20 10:31:15 2003
+++ linux-2.5-ustate-import/arch/ia64/Kconfig	Wed Jun 25 12:00:41 2003
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/kernel/entry.S linux-2.5-ustate-import/arch/ia64/kernel/entry.S
--- linux-2.5-import/arch/ia64/kernel/entry.S	Tue Jun 24 09:37:34 2003
+++ linux-2.5-ustate-import/arch/ia64/kernel/entry.S	Wed Jun 25 12:00:41 2003
@@ -1432,7 +1432,7 @@
 	data8 sys_clock_nanosleep
 	data8 sys_fstatfs64
 	data8 sys_statfs64
-	data8 ia64_ni_syscall
+	data8 sys_msa
 	data8 ia64_ni_syscall			// 1260
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/kernel/irq_ia64.c linux-2.5-ustate-import/arch/ia64/kernel/irq_ia64.c
--- linux-2.5-import/arch/ia64/kernel/irq_ia64.c	Tue May 13 09:24:57 2003
+++ linux-2.5-ustate-import/arch/ia64/kernel/irq_ia64.c	Wed Jun 25 12:00:41 2003
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/proc/base.c linux-2.5-ustate-import/fs/proc/base.c
--- linux-2.5-import/fs/proc/base.c	Tue Jun 24 09:37:52 2003
+++ linux-2.5-ustate-import/fs/proc/base.c	Wed Jun 25 12:00:41 2003
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-i386/msa.h linux-2.5-ustate-import/include/asm-i386/msa.h
--- linux-2.5-import/include/asm-i386/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate-import/include/asm-i386/msa.h	Thu Jun 26 19:40:19 2003
@@ -0,0 +1,29 @@
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
+#if defined(CONFIG_X86_TSC)
+#include <asm/msr.h>
+#include <asm/div64.h>
+#define MSA_NOW(now)  rdtscll(now)
+
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-i386/unistd.h linux-2.5-ustate-import/include/asm-i386/unistd.h
--- linux-2.5-import/include/asm-i386/unistd.h	Tue Jun 24 09:37:52 2003
+++ linux-2.5-ustate-import/include/asm-i386/unistd.h	Wed Jun 25 12:00:41 2003
@@ -275,8 +275,9 @@
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
 #define __NR_statfs64		268
 #define __NR_fstatfs64		269
+#define __NR_msa		270
 
-#define NR_syscalls 270
+#define NR_syscalls 271
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-ia64/msa.h linux-2.5-ustate-import/include/asm-ia64/msa.h
--- linux-2.5-import/include/asm-ia64/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate-import/include/asm-ia64/msa.h	Thu Jun 26 11:48:30 2003
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
+#define MSA_TO_NSEC(clk) ((1000000000*clk) / cpu_data(smp_processor_id())->itc_freq)
+
+#endif /* _KERNEL */
+
+#endif /* _ASM_IA64_MSA_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-ia64/unistd.h linux-2.5-ustate-import/include/asm-ia64/unistd.h
--- linux-2.5-import/include/asm-ia64/unistd.h	Tue Jun 24 09:37:52 2003
+++ linux-2.5-ustate-import/include/asm-ia64/unistd.h	Wed Jun 25 12:00:41 2003
@@ -248,10 +248,10 @@
 #define __NR_sys_clock_nanosleep	1256
 #define __NR_sys_fstatfs64		1257
 #define __NR_sys_statfs64		1258
-
+#define __NR_sys_msa			1259
 #ifdef __KERNEL__
 
-#define NR_syscalls			256 /* length of syscall table */
+#define NR_syscalls			271 /* length of syscall table */
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/msa.h linux-2.5-ustate-import/include/linux/msa.h
--- linux-2.5-import/include/linux/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate-import/include/linux/msa.h	Wed Jun 25 12:36:15 2003
@@ -0,0 +1,116 @@
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
+
+
+#if defined __KERNEL__
+extern long sys_msa(int ntimers, int which, clk_t *timers);
+#if defined(CONFIG_MICROSTATE)
+#include <asm/current.h>
+#include <asm/irq.h>
+
+
+#define MSA_SOFTIRQ NR_IRQS
+
+void msa_init_timer(struct task_struct *task);
+void msa_switch(struct task_struct *prev, struct task_struct *next);
+void msa_update_parent(struct task_struct *parent, struct task_struct *this);
+void msa_init(struct task_struct *p);
+void msa_set_timer(struct task_struct *p, int state);
+void msa_start_irq(int cpu, int irq);
+void msa_continue_irq(int cpu, int oldirq, int newirq);
+void msa_finish_irq(int cpu, int irq);
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
+#else /* CONFIG_MICROSTATE */
+
+
+static inline void msa_switch(struct task_struct *prev, struct task_struct *next) { }
+static inline void msa_update_parent(struct task_struct *parent, struct task_struct *this) { }
+
+static inline void msa_init(struct task_struct *p) { }
+static inline void msa_set_timer(struct task_struct *p, int state) { }
+static inline void msa_start_irq(int cpu, int irq) { }
+static inline void msa_continue_irq(int cpu, int oldirq, int newirq) { }
+static inline void msa_finish_irq(int cpu, int irq) { };
+
+static inline clk_t msa_irq_time(int cpu, int irq) { return 0; }
+static inline void msa_next_state(struct task_struct *p, int s) { }
+static inline void  msa_flip_expired(struct task_struct *p) { }
+
+
+#endif /* CONFIG_MICROSTATE */
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MSA_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/sched.h linux-2.5-ustate-import/include/linux/sched.h
--- linux-2.5-import/include/linux/sched.h	Tue Jun 24 09:37:53 2003
+++ linux-2.5-ustate-import/include/linux/sched.h	Wed Jun 25 12:00:42 2003
@@ -28,6 +28,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/msa.h>
 
 struct exec_domain;
 
@@ -388,6 +389,9 @@
 	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
 	u64 start_time;
+#ifdef CONFIG_MICROSTATE
+	struct microstates microstates;
+#endif
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 /* process credentials */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/Makefile linux-2.5-ustate-import/kernel/Makefile
--- linux-2.5-import/kernel/Makefile	Mon Jun  2 07:55:05 2003
+++ linux-2.5-ustate-import/kernel/Makefile	Wed Jun 25 12:00:42 2003
@@ -6,7 +6,8 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    msa.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
@@ -19,6 +20,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/exit.c linux-2.5-ustate-import/kernel/exit.c
--- linux-2.5-import/kernel/exit.c	Tue Jun 24 09:37:53 2003
+++ linux-2.5-ustate-import/kernel/exit.c	Wed Jun 25 12:00:42 2003
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/fork.c linux-2.5-ustate-import/kernel/fork.c
--- linux-2.5-import/kernel/fork.c	Tue Jun 24 09:37:53 2003
+++ linux-2.5-ustate-import/kernel/fork.c	Wed Jun 25 12:00:42 2003
@@ -821,6 +821,7 @@
 #endif
 	p->did_exec = 0;
 	p->state = TASK_UNINTERRUPTIBLE;
+	msa_init(p);
 
 	copy_flags(clone_flags, p);
 	if (clone_flags & CLONE_IDLETASK)
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/msa.c linux-2.5-ustate-import/kernel/msa.c
--- linux-2.5-import/kernel/msa.c	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate-import/kernel/msa.c	Wed Jun 25 12:00:42 2003
@@ -0,0 +1,265 @@
+/*
+ * Microstate accounting.
+ * Try to account for various states much more accurately than
+ * the normal code does.
+ */
+
+
+#include <config/microstate.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#ifdef CONFIG_MICROSTATE
+#include <asm/irq.h>
+#include <asm/hardirq.h>
+#include <linux/sched.h>
+#include <asm/uaccess.h>
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
+ * The msa system call --- get microstate data for self or waited-for children.
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
+asmlinkage long sys_msa(int ntimers, __u64 *timers)
+{
+	return -ENOSYS;
+}
+#endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/sched.c linux-2.5-ustate-import/kernel/sched.c
--- linux-2.5-import/kernel/sched.c	Tue Jun 24 09:37:53 2003
+++ linux-2.5-ustate-import/kernel/sched.c	Thu Jun 26 13:23:53 2003
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
@@ -1966,6 +1972,7 @@
 	 */
 	if (likely(!rt_task(current))) {
 		dequeue_task(current, array);
+		msa_next_state(current, ONEXPIREDQUEUE);
 		enqueue_task(current, rq->expired);
 	} else {
 		list_del(&current->run_list);

--CLNIlsFpsO--
