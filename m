Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbUK3PKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUK3PKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbUK3PKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:10:33 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:14590 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262108AbUK3PI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:08:59 -0500
Date: Tue, 30 Nov 2004 16:08:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/6] s390: core changes.
Message-ID: <20041130150853.GB4758@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/6] s390: core changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Ulrich Weigand <uweigand@de.ibm.com>

s390 core changes:
 - Remove defines for kernel_stack_size and async_stack_size.
 - Reserve system call number for kexec.
 - Add cc-option check for new gcc option packed-stack.
 - Fix race on no_hz_cpu_mask in stop_hz_timer.
 - Fix ptrace to make it send a SIGTRAP before the first instruction
   of a single stepped signal handler is executed.
 - Use force_sig_info with a full siginfo structure for illegal operation.
 - Remove verbatim copy of si_codes from asm-s390/siginfo.h. Use the
   generic definitions.
 - Regenerate default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/Makefile          |   12 +++++++
 arch/s390/defconfig         |    6 +--
 arch/s390/kernel/entry.S    |    2 +
 arch/s390/kernel/entry64.S  |    2 +
 arch/s390/kernel/ptrace.c   |    5 ++-
 arch/s390/kernel/syscalls.S |    3 +
 arch/s390/kernel/time.c     |    7 +++-
 arch/s390/kernel/traps.c    |   68 ++++++++++++++++++++++++++----------------
 include/asm-s390/siginfo.h  |   71 --------------------------------------------
 include/asm-s390/unistd.h   |    3 +
 10 files changed, 75 insertions(+), 104 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2004-11-30 14:03:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2004-11-30 14:03:18.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1
-# Thu Nov 11 12:54:21 2004
+# Linux kernel version: 2.6.10-rc2
+# Tue Nov 30 14:00:30 2004
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -147,7 +147,6 @@
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
 CONFIG_CCW=y
@@ -197,6 +196,7 @@
 CONFIG_MD_RAID5=m
 # CONFIG_MD_RAID6 is not set
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 # CONFIG_BLK_DEV_DM is not set
 
 #
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2004-11-30 14:03:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2004-11-30 14:03:18.000000000 +0100
@@ -231,6 +231,8 @@
 	brasl	%r14,do_signal    # call do_signal
 	tm	__TI_flags+7(%r9),_TIF_RESTART_SVC
 	jo	sysc_restart
+	tm	__TI_flags+7(%r9),_TIF_SINGLE_STEP
+	jo	sysc_singlestep
 	j	sysc_leave        # out of here, do NOT recheck
 
 #
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2004-11-30 14:03:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2004-11-30 14:03:18.000000000 +0100
@@ -229,6 +229,8 @@
 	basr	%r14,%r1               # call do_signal
 	tm	__TI_flags+3(%r9),_TIF_RESTART_SVC
 	bo	BASED(sysc_restart)
+	tm	__TI_flags+3(%r9),_TIF_SINGLE_STEP
+	bo	BASED(sysc_singlestep)
 	b	BASED(sysc_leave)      # out of here, do NOT recheck
 
 #
diff -urN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-patched/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	2004-11-30 14:03:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ptrace.c	2004-11-30 14:03:18.000000000 +0100
@@ -640,7 +640,10 @@
 			return -EIO;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
-		set_single_step(child);
+		if (data)
+			set_tsk_thread_flag(child, TIF_SINGLE_STEP);
+		else
+			set_single_step(child);
 		/* give it a chance to run. */
 		wake_up_process(child);
 		return 0;
diff -urN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2004-10-18 23:53:13.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2004-11-30 14:03:18.000000000 +0100
@@ -283,5 +283,6 @@
 SYSCALL(sys_mq_unlink,sys_mq_unlink,sys32_mq_unlink_wrapper)
 SYSCALL(sys_mq_timedsend,sys_mq_timedsend,compat_sys_mq_timedsend_wrapper)
 SYSCALL(sys_mq_timedreceive,sys_mq_timedreceive,compat_sys_mq_timedreceive_wrapper)
-SYSCALL(sys_mq_notify,sys_mq_notify,compat_sys_mq_notify_wrapper)
+SYSCALL(sys_mq_notify,sys_mq_notify,compat_sys_mq_notify_wrapper) /* 275 */
 SYSCALL(sys_mq_getsetattr,sys_mq_getsetattr,compat_sys_mq_getsetattr_wrapper)
+NI_SYSCALL							/* reserved for kexec */
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2004-11-30 14:03:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/time.c	2004-11-30 14:03:18.000000000 +0100
@@ -260,18 +260,21 @@
 	if (sysctl_hz_timer != 0)
 		return;
 
+	cpu_set(smp_processor_id(), nohz_cpu_mask);
+
 	/*
 	 * Leave the clock comparator set up for the next timer
 	 * tick if either rcu or a softirq is pending.
 	 */
-	if (rcu_pending(smp_processor_id()) || local_softirq_pending())
+	if (rcu_pending(smp_processor_id()) || local_softirq_pending()) {
+		cpu_clear(smp_processor_id(), nohz_cpu_mask);
 		return;
+	}
 
 	/*
 	 * This cpu is going really idle. Set up the clock comparator
 	 * for the next event.
 	 */
-	cpu_set(smp_processor_id(), nohz_cpu_mask);
 	timer = (__u64) (next_timer_interrupt() - jiffies) + jiffies_64;
 	timer = jiffies_timer_cc + timer * CLK_TICKS_PER_JIFFY;
 	asm volatile ("SCKC %0" : : "m" (timer));
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2004-11-30 14:03:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2004-11-30 14:03:18.000000000 +0100
@@ -294,6 +294,20 @@
         do_exit(SIGSEGV);
 }
 
+static void inline
+report_user_fault(long interruption_code, struct pt_regs *regs)
+{
+#if defined(CONFIG_SYSCTL)
+	if (!sysctl_userprocess_debug)
+		return;
+#endif
+#if defined(CONFIG_SYSCTL) || defined(CONFIG_PROCESS_DEBUG)
+	printk("User process fault: interruption code 0x%lX\n",
+	       interruption_code);
+	show_regs(regs);
+#endif
+}
+
 static void inline do_trap(long interruption_code, int signr, char *str,
                            struct pt_regs *regs, siginfo_t *info)
 {
@@ -308,23 +322,8 @@
                 struct task_struct *tsk = current;
 
                 tsk->thread.trap_no = interruption_code & 0xffff;
-		if (info)
-			force_sig_info(signr, info, tsk);
-		else
-                	force_sig(signr, tsk);
-#ifndef CONFIG_SYSCTL
-#ifdef CONFIG_PROCESS_DEBUG
-                printk("User process fault: interruption code 0x%lX\n",
-                       interruption_code);
-                show_regs(regs);
-#endif
-#else
-		if (sysctl_userprocess_debug) {
-			printk("User process fault: interruption code 0x%lX\n",
-			       interruption_code);
-			show_regs(regs);
-		}
-#endif
+		force_sig_info(signr, info, tsk);
+		report_user_fault(interruption_code, regs);
         } else {
                 const struct exception_table_entry *fixup;
                 fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
@@ -346,10 +345,15 @@
 		force_sig(SIGTRAP, current);
 }
 
-#define DO_ERROR(signr, str, name) \
-asmlinkage void name(struct pt_regs * regs, long interruption_code) \
-{ \
-	do_trap(interruption_code, signr, str, regs, NULL); \
+asmlinkage void
+default_trap_handler(struct pt_regs * regs, long interruption_code)
+{
+        if (regs->psw.mask & PSW_MASK_PSTATE) {
+		local_irq_enable();
+		do_exit(SIGSEGV);
+		report_user_fault(interruption_code, regs);
+	} else
+		die("Unknown program exception", regs, interruption_code);
 }
 
 #define DO_ERROR_INFO(signr, str, name, sicode, siaddr) \
@@ -363,8 +367,6 @@
         do_trap(interruption_code, signr, str, regs, &info); \
 }
 
-DO_ERROR(SIGSEGV, "Unknown program exception", default_trap_handler)
-
 DO_ERROR_INFO(SIGILL, "addressing exception", addressing_exception,
 	      ILL_ILLADR, get_check_address(regs))
 DO_ERROR_INFO(SIGILL,  "execute exception", execute_exception,
@@ -423,6 +425,7 @@
 
 asmlinkage void illegal_op(struct pt_regs * regs, long interruption_code)
 {
+	siginfo_t info;
         __u8 opcode[6];
 	__u16 *location;
 	int signal = 0;
@@ -466,12 +469,27 @@
 	} else
 		signal = SIGILL;
 
+#ifdef CONFIG_MATHEMU
         if (signal == SIGFPE)
 		do_fp_trap(regs, location,
                            current->thread.fp_regs.fpc, interruption_code);
-        else if (signal)
+        else if (signal == SIGSEGV) {
+		info.si_signo = signal;
+		info.si_errno = 0;
+		info.si_code = SEGV_MAPERR;
+		info.si_addr = (void *) location;
 		do_trap(interruption_code, signal,
-			"illegal operation", regs, NULL);
+			"user address fault", regs, &info);
+	} else
+#endif
+        if (signal) {
+		info.si_signo = signal;
+		info.si_errno = 0;
+		info.si_code = ILL_ILLOPC;
+		info.si_addr = (void *) location;
+		do_trap(interruption_code, signal,
+			"illegal operation", regs, &info);
+	}
 }
 
 
diff -urN linux-2.6/arch/s390/Makefile linux-2.6-patched/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	2004-10-18 23:53:41.000000000 +0200
+++ linux-2.6-patched/arch/s390/Makefile	2004-11-30 14:03:18.000000000 +0100
@@ -34,6 +34,7 @@
 cflags-$(CONFIG_MARCH_Z900) += $(call cc-option,-march=z900)
 cflags-$(CONFIG_MARCH_Z990) += $(call cc-option,-march=z990)
 
+# old style option for packed stacks
 ifeq ($(call cc-option-yn,-mkernel-backchain),y)
 cflags-$(CONFIG_PACK_STACK)  += -mkernel-backchain -D__PACK_STACK
 aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
@@ -44,6 +45,17 @@
 endif
 endif
 
+# new style option for packed stacks
+ifeq ($(call cc-option-yn,-mpacked-stack),y)
+cflags-$(CONFIG_PACK_STACK)  += -mpacked-stack -D__PACK_STACK
+aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
+cflags-$(CONFIG_SMALL_STACK) += -D__SMALL_STACK
+aflags-$(CONFIG_SMALL_STACK) += -D__SMALL_STACK
+ifdef CONFIG_SMALL_STACK
+STACK_SIZE := $(shell echo $$(($(STACK_SIZE)/2)) )
+endif
+endif
+
 ifeq ($(call cc-option-yn,-mstack-size=8192 -mstack-guard=128),y)
 cflags-$(CONFIG_CHECK_STACK) += -mstack-size=$(STACK_SIZE)
 cflags-$(CONFIG_CHECK_STACK) += -mstack-guard=$(CONFIG_STACK_GUARD)
diff -urN linux-2.6/include/asm-s390/siginfo.h linux-2.6-patched/include/asm-s390/siginfo.h
--- linux-2.6/include/asm-s390/siginfo.h	2004-10-18 23:55:06.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/siginfo.h	2004-11-30 14:03:18.000000000 +0100
@@ -9,7 +9,6 @@
 #ifndef _S390_SIGINFO_H
 #define _S390_SIGINFO_H
 
-#define HAVE_ARCH_SI_CODES
 #ifdef __s390x__
 #define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
 #endif
@@ -22,74 +21,4 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGILL si_codes
- */
-#define ILL_ILLOPC	(__SI_FAULT|1)	/* illegal opcode */
-#define ILL_ILLOPN	(__SI_FAULT|2)	/* illegal operand */
-#define ILL_ILLADR	(__SI_FAULT|3)	/* illegal addressing mode */
-#define ILL_ILLTRP	(__SI_FAULT|4)	/* illegal trap */
-#define ILL_PRVOPC	(__SI_FAULT|5)	/* privileged opcode */
-#define ILL_PRVREG	(__SI_FAULT|6)	/* privileged register */
-#define ILL_COPROC	(__SI_FAULT|7)	/* coprocessor error */
-#define ILL_BADSTK	(__SI_FAULT|8)	/* internal stack error */
-#define NSIGILL		8
-
-/*
- * SIGFPE si_codes
- */
-#define FPE_INTDIV	(__SI_FAULT|1)	/* integer divide by zero */
-#define FPE_INTOVF	(__SI_FAULT|2)	/* integer overflow */
-#define FPE_FLTDIV	(__SI_FAULT|3)	/* floating point divide by zero */
-#define FPE_FLTOVF	(__SI_FAULT|4)	/* floating point overflow */
-#define FPE_FLTUND	(__SI_FAULT|5)	/* floating point underflow */
-#define FPE_FLTRES	(__SI_FAULT|6)	/* floating point inexact result */
-#define FPE_FLTINV	(__SI_FAULT|7)	/* floating point invalid operation */
-#define FPE_FLTSUB	(__SI_FAULT|8)	/* subscript out of range */
-#define NSIGFPE		8
-
-/*
- * SIGSEGV si_codes
- */
-#define SEGV_MAPERR	(__SI_FAULT|1)	/* address not mapped to object */
-#define SEGV_ACCERR	(__SI_FAULT|2)	/* invalid permissions for mapped object */
-#define NSIGSEGV	2
-
-/*
- * SIGBUS si_codes
- */
-#define BUS_ADRALN	(__SI_FAULT|1)	/* invalid address alignment */
-#define BUS_ADRERR	(__SI_FAULT|2)	/* non-existant physical address */
-#define BUS_OBJERR	(__SI_FAULT|3)	/* object specific hardware error */
-#define NSIGBUS		3
-
-/*
- * SIGTRAP si_codes
- */
-#define TRAP_BRKPT	(__SI_FAULT|1)	/* process breakpoint */
-#define TRAP_TRACE	(__SI_FAULT|2)	/* process trace trap */
-#define NSIGTRAP	2
-
-/*
- * SIGCHLD si_codes
- */
-#define CLD_EXITED	(__SI_CHLD|1)	/* child has exited */
-#define CLD_KILLED	(__SI_CHLD|2)	/* child was killed */
-#define CLD_DUMPED	(__SI_CHLD|3)	/* child terminated abnormally */
-#define CLD_TRAPPED	(__SI_CHLD|4)	/* traced child has trapped */
-#define CLD_STOPPED	(__SI_CHLD|5)	/* child has stopped */
-#define CLD_CONTINUED	(__SI_CHLD|6)	/* stopped child has continued */
-#define NSIGCHLD	6
-
-/*
- * SIGPOLL si_codes
- */
-#define POLL_IN		(__SI_POLL|1)	/* data input available */
-#define POLL_OUT	(__SI_POLL|2)	/* output buffers available */
-#define POLL_MSG	(__SI_POLL|3)	/* input message available */
-#define POLL_ERR	(__SI_POLL|4)	/* i/o error */
-#define POLL_PRI	(__SI_POLL|5)	/* high priority input available */
-#define POLL_HUP	(__SI_POLL|6)	/* device disconnected */
-#define NSIGPOLL	6
-
 #endif
diff -urN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2004-10-18 23:55:43.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/unistd.h	2004-11-30 14:03:18.000000000 +0100
@@ -269,8 +269,9 @@
 #define __NR_mq_timedreceive	274
 #define __NR_mq_notify		275
 #define __NR_mq_getsetattr	276
+/* Number 277 is reserved for new sys_kexec_load */
 
-#define NR_syscalls 277
+#define NR_syscalls 278
 
 /* 
  * There are some system calls that are not present on 64 bit, some
