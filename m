Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUGXLTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUGXLTC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 07:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268446AbUGXLTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 07:19:02 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:20905 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268445AbUGXLRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 07:17:55 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16642.17756.820014.424826@wombat.chubb.wattle.id.au>
Date: Sat, 24 Jul 2004 21:17:48 +1000
To: linux-kernel@vger.kernel.org
Subject: [patch] Microstate accounting
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a reworking of the microstate accounting patch.

The idea is to track with high accuracy the time each process/thread spends in
each interesting state.  For example, how long does a thread spend sleeping
waiting for page I/O ? How long onteh expired queue?  How long is it
delayed by handling the system interrupt load (and how long are
interrupt handlers taking?)

Times are made available in two ways:
      -- in /proc/pid/msa and /proc/pid/task/tid/msa
      -- through a system call similar to getrusage().

Sample output from /proc/pid/msa is (values in nanoseconds)

$ cat /proc/self/msa
State:         System
Now:             7595781702103
ONCPU_USER              617797
ONCPU_SYS               354119
INTERRUPTIBLE                0
UNINTERRUPTIBLE         104935
INTERRUPTED              34034
ACTIVEQUEUE             179378
EXPIREDQUEUE                 0
STOPPED                      0
ZOMBIE                       0
SLP_POLL                     0
SLP_PAGING                   0
SLP_FUTEX                    0


For multi-threaded processes, the contents of /proc/pid/msa give the
sum of the pre-thread values.  This means that the numbers can go
backwards when threads die.  I don't have a good solution to this.

The system call interface looks like this:

#include <sys/syscall.h>
#include <asm/unistd.h>
#include <linux/msa.h>


#ifdef __ia64__
#define __NR_msa __NR_sys_msa
#endif
static inline long msa(int ntimers, int which, clk_t *timers)
{
	return syscall(__NR_msa, ntimers, which, timers);
}


`which' can take the values MSA_SELF or MSA_CHILDREN, same as
getrusage().

Timers are named in linux/msa.h; it's trivial to add new sleep states
and timers.  Timers are ordered most commonly useful first (that's
useful to me), so youcan pass in a pointer to fewer than all the
timers if you want,say, to get only user and system time.



/proc/interrupts has a new per-CPU field, the time in microseconds
spent in each interrupt handler.   This is the only way to get this
information. 

$ cat /proc/interrupts 
           CPU0       
  0:  137199205  965845866         XT-PIC  timer
  1:      80679    1121769         XT-PIC  i8042
  2:          0          0         XT-PIC  cascade
  5:          1          5         XT-PIC  yenta, ehci_hcd
  8:          4         43         XT-PIC  rtc
  9:     434868    7740500         XT-PIC  acpi, eth0
 11:    8232204   80158287         XT-PIC  ohci1394, Intel 82801CA-ICH3, uhci_hcd, uhci_hcd, radeon@PCI:1:0:0
 12:    1710866   18051864         XT-PIC  i8042
 14:     723970   18862854         XT-PIC  ide0
 15:         12        236         XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0


So far, only IA32 and IA64 are instrumented.  I'd welcome updates from
people who understand the other architectures to add them.  There's
also a problem counting system time if you're using a gate page for
system call entry.

You have a choice of timing sources, depending on what's best for your
setup.  Don't choose TSC if you want to use power management.

User mode tools and a few sample loads are available from
http://www.gelato.unsw.edu.au/patches/usrdrv/msa.tar.gz

Index: linux-2.5-import/arch/i386/Kconfig
===================================================================
--- linux-2.5-import.orig/arch/i386/Kconfig
+++ linux-2.5-import/arch/i386/Kconfig
@@ -1308,6 +1308,44 @@
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
+choice 
+       depends on MICROSTATE
+       prompt "Microstate timing source"
+       default MICROSTATE_TSC
+
+config MICROSTATE_PM
+       bool "Use Power-Management timer for microstate timings"
+       depends on X86_PM_TIMER
+       help
+	 If your machine is ACPI enabled and uses pwer-management, then the 
+	 TSC runs at a variable rate, which will distort the 
+	 microstate measurements.  Unfortunately, the PM timer has a resolution
+	 of only 279 nanoseconds or so.
+
+config MICROSTATE_TSC
+       bool "Use on-chip TSC for microstate timings"
+       depends on X86_TSC
+       help
+         If your machine's clock runs at constant rate, then this timer 
+	 gives you cycle precision in measureing times spent in microstates.
+
+config MICROSTATE_TOD
+       bool "Use time-of-day clock for microstate timings"
+       help
+         If none of the other timers are any good for you, this timer 
+	 will give you micro-second precision.
+endchoice
+	
+
 endmenu
 
 source "security/Kconfig"
Index: linux-2.5-import/arch/i386/kernel/entry.S
===================================================================
--- linux-2.5-import.orig/arch/i386/kernel/entry.S
+++ linux-2.5-import/arch/i386/kernel/entry.S
@@ -260,8 +260,16 @@
 
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
+#ifdef CONFIG_MICROSTATE
+	pushl	%eax
+	call msa_start_syscall
+	popl	%eax
+#endif
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
+#ifdef CONFIG_MICROSTATE
+	call msa_end_syscall
+#endif
 	cli
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
@@ -284,9 +292,17 @@
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 syscall_call:
+#ifdef CONFIG_MICROSTATE
+	pushl	%eax
+	call msa_start_syscall
+	popl	%eax
+#endif
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
+#ifdef CONFIG_MICROSTATE
+	call msa_end_syscall
+#endif
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
@@ -886,5 +902,6 @@
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_msa
 
 syscall_table_size=(.-sys_call_table)
Index: linux-2.5-import/arch/i386/kernel/irq.c
===================================================================
--- linux-2.5-import.orig/arch/i386/kernel/irq.c
+++ linux-2.5-import/arch/i386/kernel/irq.c
@@ -163,10 +163,18 @@
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
@@ -431,6 +439,7 @@
 	unsigned int status;
 
 	irq_enter();
+	msa_start_irq(irq);
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
@@ -567,6 +576,7 @@
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
 
+	msa_finish_irq(irq);
 	irq_exit();
 
 	return 1;
Index: linux-2.5-import/arch/i386/kernel/time.c
===================================================================
--- linux-2.5-import.orig/arch/i386/kernel/time.c
+++ linux-2.5-import/arch/i386/kernel/time.c
@@ -86,6 +86,7 @@
 EXPORT_SYMBOL(i8253_lock);
 
 struct timer_opts *cur_timer = &timer_none;
+EXPORT_SYMBOL(cur_timer);
 
 /*
  * This version of gettimeofday has microsecond resolution
Index: linux-2.5-import/arch/ia64/Kconfig
===================================================================
--- linux-2.5-import.orig/arch/ia64/Kconfig
+++ linux-2.5-import/arch/ia64/Kconfig
@@ -471,6 +471,26 @@
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
+choice
+       depends on MICROSTATE
+       prompt "Microstate timing source"
+       default MICROSTATE_ITC
+
+config MICROSTATE_ITC
+       bool "Use on-chip IDT for microstate timing"
+
+config MICROSTATE_TOD
+       bool "Use time-of-day clock for microstate timings"
+endchoice
+
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
 	depends on DEBUG_KERNEL
Index: linux-2.5-import/arch/ia64/kernel/entry.S
===================================================================
--- linux-2.5-import.orig/arch/ia64/kernel/entry.S
+++ linux-2.5-import/arch/ia64/kernel/entry.S
@@ -580,6 +580,36 @@
 .ret4:	br.cond.sptk ia64_leave_kernel
 END(ia64_strace_leave_kernel)
 
+#ifdef CONFIG_MICROSTATE
+GLOBAL_ENTRY(invoke_msa_end_syscall)
+	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(8)
+	alloc loc1=ar.pfs,8,4,0,0
+	mov loc0=rp
+	.body
+	;;
+	br.call.sptk.many rp=msa_end_syscall
+1:	mov rp=loc0
+	mov ar.pfs=loc1
+	br.ret.sptk.many rp
+END(invoke_msa_end_syscall)
+
+GLOBAL_ENTRY(invoke_msa_start_syscall)
+	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(8)
+	alloc loc1=ar.pfs,8,4,0,0
+	mov loc0=rp
+	.body
+	mov loc2=b6
+	mov loc3=r15
+	;;
+	br.call.sptk.many rp=msa_start_syscall
+1:	mov rp=loc0
+	mov r15=loc3
+	mov ar.pfs=loc1
+	mov b6=loc2
+	br.ret.sptk.many rp
+END(invoke_msa_start_syscall)
+#endif /* CONFIG_MICROSTATE */
+
 GLOBAL_ENTRY(ia64_ret_from_clone)
 	PT_REGS_UNWIND_INFO(0)
 {	/*
@@ -663,6 +693,10 @@
  */
 GLOBAL_ENTRY(ia64_leave_syscall)
 	PT_REGS_UNWIND_INFO(0)
+#ifdef CONFIG_MICROSTATE
+	br.call.sptk.many rp=invoke_msa_end_syscall
+1:	
+#endif
 	/*
 	 * work.need_resched etc. mustn't get changed by this CPU before it returns to
 	 * user- or fsys-mode, hence we disable interrupts early on.
@@ -1016,7 +1050,7 @@
 	mov loc7=0
 (pRecurse) br.call.sptk.few b0=rse_clear_invalid
 	;;
-	mov loc8=0
+1:	mov loc8=0
 	mov loc9=0
 	cmp.ne pReturn,p0=r0,in1	// if recursion count != 0, we need to do a br.ret
 	mov loc10=0
@@ -1526,8 +1560,8 @@
 	data8 sys_mq_notify
 	data8 sys_mq_getsetattr
 	data8 sys_ni_syscall			// reserved for kexec_load
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall			// 1270
+	data8 sys_ni_syscall			// reserved for vserver
+	data8 sys_msa				// 1270
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
Index: linux-2.5-import/arch/ia64/kernel/irq_ia64.c
===================================================================
--- linux-2.5-import.orig/arch/ia64/kernel/irq_ia64.c
+++ linux-2.5-import/arch/ia64/kernel/irq_ia64.c
@@ -101,7 +101,7 @@
 ia64_handle_irq (ia64_vector vector, struct pt_regs *regs)
 {
 	unsigned long saved_tpr;
-
+	ia64_vector oldvector;
 #if IRQ_DEBUG
 	{
 		unsigned long bsp, sp;
@@ -140,6 +140,8 @@
 	irq_enter();
 	saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
 	ia64_srlz_d();
+	oldvector = vector;
+	msa_start_irq(local_vector_to_irq(vector));
 	while (vector != IA64_SPURIOUS_INT_VECTOR) {
 		if (!IS_RESCHEDULE(vector)) {
 			ia64_setreg(_IA64_REG_CR_TPR, vector);
@@ -154,14 +156,23 @@
 			ia64_setreg(_IA64_REG_CR_TPR, saved_tpr);
 		}
 		ia64_eoi();
-		vector = ia64_get_ivr();
+		oldvector = vector;
+		vector = ia64_get_ivr();		
+		msa_continue_irq(local_vector_to_irq(oldvector),
+				 local_vector_to_irq(vector));
 	}
 	/*
 	 * This must be done *after* the ia64_eoi().  For example, the keyboard softirq
 	 * handler needs to be able to wait for further keyboard interrupts, which can't
 	 * come through until ia64_eoi() has been done.
 	 */
+
 	irq_exit();
+	/*
+	 * This should really happen before the preempt_reschedule and 
+	 * after softIRQs have run 
+	 */
+	msa_finish_irq(local_vector_to_irq(vector));
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: linux-2.5-import/arch/ia64/kernel/ivt.S
===================================================================
--- linux-2.5-import.orig/arch/ia64/kernel/ivt.S
+++ linux-2.5-import/arch/ia64/kernel/ivt.S
@@ -734,6 +734,10 @@
 	srlz.i					// guarantee that interruption collection is on
 	;;
 (p15)	ssm psr.i				// restore psr.i
+#ifdef CONFIG_MICROSTATE
+	br.call.sptk.many rp=invoke_msa_start_syscall
+1:	
+#endif  /* CONFIG_MICROSTATE */
 	;;
 	mov r3=NR_syscalls - 1
 	movl r16=sys_call_table
Index: linux-2.5-import/fs/proc/base.c
===================================================================
--- linux-2.5-import.orig/fs/proc/base.c
+++ linux-2.5-import/fs/proc/base.c
@@ -90,6 +90,10 @@
 	PROC_TID_ATTR_EXEC,
 	PROC_TID_ATTR_FSCREATE,
 #endif
+#ifdef CONFIG_MICROSTATE
+	PROC_TGID_MSA,
+	PROC_TID_MSA,
+#endif
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -123,6 +127,9 @@
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_MICROSTATE
+	E(PROC_TGID_MSA,        "msa",     S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -145,6 +152,9 @@
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_MICROSTATE
+	E(PROC_TID_MSA,        "msa",     S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -182,6 +192,9 @@
 int proc_pid_statm(struct task_struct*,char*);
 int proc_pid_cpu(struct task_struct*,char*);
 
+static int proc_tid_msa(struct task_struct *task, char *buffer);
+static int proc_tgid_msa(struct task_struct *task, char *buffer);
+
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct task_struct *task = proc_task(inode);
@@ -1375,6 +1388,17 @@
 			ei->op.proc_read = proc_pid_wchan;
 			break;
 #endif
+#ifdef CONFIG_MICROSTATE
+		case PROC_TID_MSA:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_tid_msa;
+			break;
+
+		case PROC_TGID_MSA:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_tgid_msa;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
@@ -1812,3 +1836,145 @@
 	filp->f_pos = pos;
 	return retval;
 }
+#ifdef CONFIG_MICROSTATE
+/*
+ * provides microstate accounting information
+ *
+ */
+static const char * const statenames[] = {
+	"User",
+	"System",
+	"Interruptible",
+	"Uninterruptible",
+	"OnActiveQueue",
+	"OnExpiredQueue",
+	"Zombie",
+	"Stopped",
+	"Paging",
+	"Futex",
+	"Poll",
+	"Interrupted",
+};
+
+static int proc_tid_msa(struct task_struct *task, char *buffer) 
+{
+	struct microstates *msp = &task->microstates;
+	clk_t now;
+	clk_t *tp;
+	struct microstates msp1;
+  
+	memcpy(&msp1, msp, sizeof(*msp));
+	tp = msp1.timers;
+
+	switch (msp1.cur_state) {
+	case ONCPU_USER:
+	case ONCPU_SYS:
+	case ONACTIVEQUEUE:
+	case ONEXPIREDQUEUE:
+		now = msp1.last_change;
+		break;
+	default:
+		MSA_NOW(now);
+		tp[msp1.cur_state] += now - msp1.last_change;
+	}
+	return sprintf(buffer, 
+		       "State:         %s\n"		\
+		       "Now:	       %15llu\n"	\
+		       "ONCPU_USER     %15llu\n"	\
+		       "ONCPU_SYS      %15llu\n"	\
+		       "INTERRUPTIBLE  %15llu\n"	\
+		       "UNINTERRUPTIBLE%15llu\n"	\
+		       "INTERRUPTED    %15llu\n"	\
+		       "ACTIVEQUEUE    %15llu\n"	\
+		       "EXPIREDQUEUE   %15llu\n"	\
+		       "STOPPED        %15llu\n"	\
+		       "ZOMBIE         %15llu\n"	\
+		       "SLP_POLL       %15llu\n"	\
+		       "SLP_PAGING     %15llu\n"	\
+		       "SLP_FUTEX      %15llu\n",	\
+		       msp1.cur_state >= 0 && msp1.cur_state < NR_MICRO_STATES ?
+		       statenames[msp1.cur_state] : "Impossible",
+		       (unsigned long long)MSA_TO_NSEC(now),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONCPU_USER]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONCPU_SYS]),
+		       (unsigned long long)MSA_TO_NSEC(tp[INTERRUPTIBLE_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[UNINTERRUPTIBLE_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[INTERRUPTED]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONACTIVEQUEUE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONEXPIREDQUEUE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[STOPPED]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ZOMBIE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[POLL_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[PAGING_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[FUTEX_SLEEP]));
+}
+
+/*
+ * Sum resource usage for self + children.
+ * Only a snapshot, don't worry about things changing under foot.
+ */
+
+static int proc_tgid_msa(struct task_struct *task, char *buffer) 
+{
+	clk_t *tp;
+	clk_t *tp1;
+	struct microstates msp1;
+	struct microstates msp2;
+	int i;
+	clk_t now;
+	
+	enum thread_state cur_state = NR_MICRO_STATES;
+
+	if (thread_group_empty(task))
+		return proc_tid_msa(task, buffer);
+	
+	memset(&msp2, 0, sizeof msp2);
+	MSA_NOW(now);
+	read_lock(&tasklist_lock);
+	do {
+		msp1 = task->microstates;
+		if (msp1.cur_state < cur_state)
+			cur_state = msp1.cur_state;
+		for (i = 0, tp = msp1.timers, tp1 = msp2.timers; 
+		     i < NR_MICRO_STATES; 
+		     i++)
+			*tp1++ += *tp++;
+		task = next_thread(task);
+	} while (!thread_group_leader(task));
+	read_unlock(&tasklist_lock);
+
+	tp = msp2.timers;
+	
+	return sprintf(buffer, 
+		       "State:         %s\n"		\
+		       "Now:	       %15llu\n"	\
+		       "ONCPU_USER     %15llu\n"	\
+		       "ONCPU_SYS      %15llu\n"	\
+		       "INTERRUPTIBLE  %15llu\n"	\
+		       "UNINTERRUPTIBLE%15llu\n"	\
+		       "INTERRUPTED    %15llu\n"	\
+		       "ACTIVEQUEUE    %15llu\n"	\
+		       "EXPIREDQUEUE   %15llu\n"	\
+		       "STOPPED        %15llu\n"	\
+		       "ZOMBIE         %15llu\n"	\
+		       "SLP_POLL       %15llu\n"	\
+		       "SLP_PAGING     %15llu\n"	\
+		       "SLP_FUTEX      %15llu\n",	\
+		       msp1.cur_state >= 0 && msp1.cur_state < NR_MICRO_STATES ?
+		       statenames[msp1.cur_state] : "Impossible",
+		       (unsigned long long)MSA_TO_NSEC(now),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONCPU_USER]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONCPU_SYS]),
+		       (unsigned long long)MSA_TO_NSEC(tp[INTERRUPTIBLE_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[UNINTERRUPTIBLE_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[INTERRUPTED]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONACTIVEQUEUE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONEXPIREDQUEUE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[STOPPED]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ZOMBIE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[POLL_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[PAGING_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[FUTEX_SLEEP]));
+}
+
+#endif /* CONFIG_MICROSTATE */
Index: linux-2.5-import/fs/select.c
===================================================================
--- linux-2.5-import.orig/fs/select.c
+++ linux-2.5-import/fs/select.c
@@ -258,6 +258,7 @@
 			retval = table.error;
 			break;
 		}
+		msa_next_state(current, POLL_SLEEP);
 		__timeout = schedule_timeout(__timeout);
 	}
 	__set_current_state(TASK_RUNNING);
@@ -450,6 +451,7 @@
 		count = wait->error;
 		if (count)
 			break;
+		msa_next_state(current, POLL_SLEEP);
 		timeout = schedule_timeout(timeout);
 	}
 	__set_current_state(TASK_RUNNING);
Index: linux-2.5-import/include/asm-i386/msa.h
===================================================================
--- /dev/null
+++ linux-2.5-import/include/asm-i386/msa.h
@@ -0,0 +1,40 @@
+/************************************************************************
+ * asm-i386/msa.h
+ *
+ * Provide an architecture-specific clock.
+ */
+
+#ifndef _ASM_I386_MSA_H
+# define _ASM_I386_MSA_H
+
+typedef __u64 clk_t;
+# ifdef __KERNEL__
+#  include <linux/config.h>
+
+
+#  if defined(CONFIG_MICROSTATE_TSC)
+#   include <asm/msr.h>
+#   include <asm/div64.h>
+#   define MSA_NOW(now)  rdtscll(now)
+
+extern unsigned long cpu_khz;
+#   define MSA_TO_NSEC(clk) ({ clk_t _x = ((clk) * 1000000ULL); do_div(_x, cpu_khz); _x; })
+
+#  elif defined(CONFIG_MICROSTATE_PM)
+unsigned long long monotonic_clock(void);
+#   define MSA_NOW(now) do { now = monotonic_clock(); } while (0)
+#   define MSA_TO_NSEC(clk) (clk)
+
+#  elif defined(CONFIG_MICROSTATE_TOD)
+static inline void msa_now(clk_t *nsp) {
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	*nsp = tv.tv_sec * 1000000 + tv.tv_usec;
+}
+#    define MSA_NOW(x) msa_now(&x)
+#    define MSA_TO_NSEC(clk) ((clk) * 1000)
+#  endif
+
+# endif /* _KERNEL */
+
+#endif /* _ASM_I386_MSA_H */
Index: linux-2.5-import/include/asm-i386/unistd.h
===================================================================
--- linux-2.5-import.orig/include/asm-i386/unistd.h
+++ linux-2.5-import/include/asm-i386/unistd.h
@@ -289,8 +289,9 @@
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
+#define __NR_msa		284
 
-#define NR_syscalls 284
+#define NR_syscalls 285
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
Index: linux-2.5-import/include/asm-ia64/msa.h
===================================================================
--- /dev/null
+++ linux-2.5-import/include/asm-ia64/msa.h
@@ -0,0 +1,35 @@
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
+typedef u64 clk_t;
+
+# if defined(CONFIG_MICROSTATE_ITC)
+#   define MSA_NOW(now)  do { now = (clk_t)get_cycles(); } while (0)
+
+#   define MSA_TO_NSEC(clk) ((1000000000*clk) / cpu_data(smp_processor_id())->itc_freq)
+
+# elif defined(CONFIG_MICROSTATE_TOD)
+static inline void msa_now(clk_t *nsp) {
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	*nsp = tv.tv_sec * 1000000 + tv.tv_usec;
+}
+#   define MSA_NOW(x) msa_now(&x)
+#   define MSA_TO_NSEC(clk) ((clk) * 1000)
+
+# endif
+
+#endif /* _KERNEL */
+
+#endif /* _ASM_IA64_MSA_H */
Index: linux-2.5-import/include/asm-ia64/unistd.h
===================================================================
--- linux-2.5-import.orig/include/asm-ia64/unistd.h
+++ linux-2.5-import/include/asm-ia64/unistd.h
@@ -259,6 +259,7 @@
 #define __NR_mq_getsetattr		1267
 #define __NR_kexec_load			1268
 #define __NR_vserver			1269
+#define __NR_msa			1270
 
 #ifdef __KERNEL__
 
Index: linux-2.5-import/include/linux/msa.h
===================================================================
--- /dev/null
+++ linux-2.5-import/include/linux/msa.h
@@ -0,0 +1,137 @@
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
+extern clk_t msa_last_flip[];
+
+/*
+ * Tracked states
+ */
+
+enum thread_state {
+	MSA_UNKNOWN = -1,
+	ONCPU_USER,
+	ONCPU_SYS,
+	INTERRUPTIBLE_SLEEP,
+	UNINTERRUPTIBLE_SLEEP,
+	ONACTIVEQUEUE,
+	ONEXPIREDQUEUE,
+	ZOMBIE,
+	STOPPED,
+	INTERRUPTED,
+	PAGING_SLEEP,
+	FUTEX_SLEEP,
+	POLL_SLEEP,
+	
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
+#define QUEUE_FLIPPED	(1<<0)	/* Active and Expired queues were swapped */
+#define MSA_SYS		(1<<1)	/* this task executing in system call */
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
+void msa_start_irq(int irq);
+void msa_continue_irq(int oldirq, int newirq);
+void msa_finish_irq(int irq);
+void msa_start_syscall(void);
+void msa_end_syscall(void);
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
+static inline void msa_syscall(void) {
+	if (current->microstates.cur_state == ONCPU_USER)
+		msa_start_syscall();
+	else
+		msa_end_syscall();
+}
+
+#else
+#define msa_next_state(p, s) ((p)->microstates.next_state = (s))
+#define msa_flip_expired(p) ((p)->microstates.flags |= QUEUE_FLIPPED)
+#define msa_syscall() do { \
+	if (current->microstates.cur_state == ONCPU_USER) \
+		msa_start_syscall(); \
+	else \
+		msa_end_syscall(); \
+} while (0)
+
+#endif
+#else /* CONFIG_MICROSTATE */
+
+
+static inline void msa_switch(struct task_struct *prev, struct task_struct *next) { }
+static inline void msa_update_parent(struct task_struct *parent, struct task_struct *this) { }
+
+static inline void msa_init(struct task_struct *p) { }
+static inline void msa_set_timer(struct task_struct *p, int state) { }
+static inline void msa_start_irq(int irq) { }
+static inline void msa_continue_irq(int oldirq, int newirq) { }
+static inline void msa_finish_irq(int irq) { };
+
+static inline clk_t msa_irq_time(int cpu, int irq) { return 0; }
+static inline void msa_next_state(struct task_struct *p, int s) { }
+static inline void msa_flip_expired(struct task_struct *p) { }
+static inline void msa_start_syscall(void) { }
+static inline void msa_end_syscall(void) { }
+
+#endif /* CONFIG_MICROSTATE */
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MSA_H */
Index: linux-2.5-import/include/linux/sched.h
===================================================================
--- linux-2.5-import.orig/include/linux/sched.h
+++ linux-2.5-import/include/linux/sched.h
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/msa.h>
 
 struct exec_domain;
 
@@ -450,6 +451,9 @@
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
 	u64 start_time;
+#ifdef CONFIG_MICROSTATE
+	struct microstates microstates;
+#endif
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 /* process credentials */
Index: linux-2.5-import/kernel/Makefile
===================================================================
--- linux-2.5-import.orig/kernel/Makefile
+++ linux-2.5-import/kernel/Makefile
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o msa.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.5-import/kernel/exit.c
===================================================================
--- linux-2.5-import.orig/kernel/exit.c
+++ linux-2.5-import/kernel/exit.c
@@ -97,6 +97,9 @@
 	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
 	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
 	sched_exit(p);
+
+	msa_update_parent(p->parent, p);
+
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
Index: linux-2.5-import/kernel/fork.c
===================================================================
--- linux-2.5-import.orig/kernel/fork.c
+++ linux-2.5-import/kernel/fork.c
@@ -943,6 +943,8 @@
 
 	p->proc_dentry = NULL;
 
+	msa_init(p);
+
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
 	init_waitqueue_head(&p->wait_chldexit);
Index: linux-2.5-import/kernel/futex.c
===================================================================
--- linux-2.5-import.orig/kernel/futex.c
+++ linux-2.5-import/kernel/futex.c
@@ -39,6 +39,7 @@
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
+#include <linux/msa.h>
 
 #define FUTEX_HASHBITS 8
 
@@ -517,6 +518,7 @@
 	 * wakes us up.
 	 */
 
+	msa_next_state(current, FUTEX_SLEEP);
 	/* add_wait_queue is the barrier after __set_current_state. */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	add_wait_queue(&q.waiters, &wait);
Index: linux-2.5-import/kernel/msa.c
===================================================================
--- /dev/null
+++ linux-2.5-import/kernel/msa.c
@@ -0,0 +1,334 @@
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
+	switch (msprev->next_state) {
+	case MSA_UNKNOWN: /*
+		       * Infer from actual state
+		       */
+		switch (prev->state) {
+		case TASK_INTERRUPTIBLE:
+			next_state = INTERRUPTIBLE_SLEEP;
+			break;
+		
+		case TASK_UNINTERRUPTIBLE:
+			next_state = UNINTERRUPTIBLE_SLEEP;
+			break;
+
+		case TASK_STOPPED:
+			next_state = STOPPED;
+			break;
+
+		case TASK_ZOMBIE:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_DEAD:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_RUNNING:		
+			next_state = ONACTIVEQUEUE;
+			break;
+
+		default:
+			next_state = MSA_UNKNOWN;
+			break;
+
+		} 
+		break;
+
+	case PAGING_SLEEP: /*
+			    * Sleep states are PAGING_SLEEP;
+			    * others inferred from task state
+			    */
+		switch(prev->state) {
+		case TASK_INTERRUPTIBLE: /* FALLTHROUGH */
+		case TASK_UNINTERRUPTIBLE:
+			next_state = PAGING_SLEEP;
+			break;
+
+		case TASK_STOPPED:
+			next_state = STOPPED;
+			break;
+
+		case TASK_ZOMBIE:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_DEAD:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_RUNNING:		
+			next_state = ONACTIVEQUEUE;
+			break;
+
+		default:
+			next_state = MSA_UNKNOWN;
+			break;
+		}
+		break;
+
+	default: /* Explicitly set next state */
+		next_state = msprev->next_state;
+		msprev->next_state = MSA_UNKNOWN;
+		break;
+	}
+
+	msprev->cur_state = next_state;
+	msprev->last_change = now;
+	msprev->lastqueued = smp_processor_id();
+
+	msnext->cur_state = interrupted ? INTERRUPTED : (
+		msnext->flags & MSA_SYS ? ONCPU_SYS : ONCPU_USER);
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
+	msp->next_state = MSA_UNKNOWN;
+}
+
+static void inline __msa_set_timer(struct microstates *msp, int next_state)
+{
+	clk_t now;
+
+	MSA_NOW(now);
+	msp->timers[msp->cur_state] += now - msp->last_change;
+	msp->last_change = now;
+	msp->cur_state = next_state;
+
+}
+
+/*
+ * Time stamp an explicit state change (called, e.g., from __activate_task())
+ */
+void
+msa_set_timer(struct task_struct *p, int next_state)
+{
+	struct microstates *msp = &p->microstates;
+
+	__msa_set_timer(msp, next_state);
+	msp->lastqueued = smp_processor_id();
+	msp->next_state = MSA_UNKNOWN;
+}
+
+/*
+ * Helper routines, to be called from assembly language stubs 
+ */
+void msa_start_syscall(void)
+{
+	struct microstates *msp = &current->microstates;
+
+	__msa_set_timer(msp, ONCPU_SYS);
+	msp->flags |= MSA_SYS;
+}
+
+void msa_end_syscall(void)
+{
+	struct microstates *msp = &current->microstates;
+
+	__msa_set_timer(msp, ONCPU_USER);
+	msp->flags &= ~MSA_SYS;
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
+void msa_start_irq(int irq) 
+{
+	struct task_struct *p = current;
+	struct microstates *mp = &p->microstates;
+	clk_t now;
+	int cpu = smp_processor_id();
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
+void msa_continue_irq(int oldirq, int newirq) 
+{
+	clk_t now;
+	int cpu = smp_processor_id();
+	MSA_NOW(now);
+
+	msa_irq_times[cpu][oldirq] += now - msa_irq_entered[cpu][oldirq];
+	msa_irq_entered[cpu][newirq] = now;
+	msa_irq_pids[cpu][newirq] = current->pid;
+}
+
+
+void msa_finish_irq(int irq) 
+{
+	struct task_struct *p = current;
+	struct microstates *mp = &p->microstates;
+	clk_t now;
+	int cpu = smp_processor_id();
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
+	for (i = 0; i < ntimers; i++) {
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
Index: linux-2.5-import/kernel/sched.c
===================================================================
--- linux-2.5-import.orig/kernel/sched.c
+++ linux-2.5-import/kernel/sched.c
@@ -366,6 +366,7 @@
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
+	msa_set_timer(p, ONACTIVEQUEUE);
 	enqueue_task(p, rq->active);
 	rq->nr_running++;
 }
@@ -951,6 +952,7 @@
 	if (unlikely(!current->array))
 		__activate_task(p, rq);
 	else {
+		msa_set_timer(p, ONACTIVEQUEUE);
 		p->prio = current->prio;
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
@@ -2054,6 +2056,7 @@
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+			msa_next_state(p, ONEXPIREDQUEUE);
 			enqueue_task(p, rq->expired);
 			if (p->static_prio < rq->best_expired_prio)
 				rq->best_expired_prio = p->static_prio;
@@ -2261,6 +2264,7 @@
 		array = rq->active;
 		rq->expired_timestamp = 0;
 		rq->best_expired_prio = MAX_PRIO;
+		msa_flip_expired(prev);
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -2303,6 +2307,8 @@
 		rq->curr = next;
 		++*switch_count;
 
+		msa_switch(prev, next);
+
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
@@ -3017,7 +3023,8 @@
 	 */
 	if (unlikely(rt_task(current)))
 		target = rq->active;
-
+	else
+		msa_next_state(current, ONEXPIREDQUEUE);
 	dequeue_task(current, array);
 	enqueue_task(current, target);
 
@@ -3922,6 +3929,7 @@
 	sched_domain_init.groups = &sched_group_init;
 	sched_domain_init.last_balance = jiffies;
 	sched_domain_init.balance_interval = INT_MAX; /* Don't balance */
+	sched_domain_init.busy_factor = 1;
 
 	memset(&sched_group_init, 0, sizeof(struct sched_group));
 	sched_group_init.cpumask = CPU_MASK_ALL;
Index: linux-2.5-import/mm/filemap.c
===================================================================
--- linux-2.5-import.orig/mm/filemap.c
+++ linux-2.5-import/mm/filemap.c
@@ -356,8 +356,11 @@
 	do {
 		prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
 		if (test_bit(bit_nr, &page->flags)) {
+			msa_next_state(current, PAGING_SLEEP);
 			sync_page(page);
+			msa_next_state(current, PAGING_SLEEP);
 			io_schedule();
+			msa_next_state(current, MSA_UNKNOWN);
 		}
 	} while (test_bit(bit_nr, &page->flags));
 	finish_wait(waitqueue, &wait.wait);
Index: linux-2.5-import/mm/memory.c
===================================================================
--- linux-2.5-import.orig/mm/memory.c
+++ linux-2.5-import/mm/memory.c
@@ -1689,6 +1689,7 @@
 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
 
+	msa_next_state(current, PAGING_SLEEP);
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
@@ -1698,10 +1699,14 @@
 
 	if (pmd) {
 		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
-			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+		if (pte) {
+			int ret = handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+			msa_next_state(current, MSA_UNKNOWN);
+			return ret;
+		}
 	}
 	spin_unlock(&mm->page_table_lock);
+	msa_next_state(current, MSA_UNKNOWN);
 	return VM_FAULT_OOM;
 }
 
