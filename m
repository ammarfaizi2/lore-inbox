Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265164AbSJaD02>; Wed, 30 Oct 2002 22:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265162AbSJaD0Q>; Wed, 30 Oct 2002 22:26:16 -0500
Received: from nameservices.net ([208.234.25.16]:6833 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265164AbSJaDUk>;
	Wed, 30 Oct 2002 22:20:40 -0500
Message-ID: <3DC0A409.B0B92A20@opersys.com>
Date: Wed, 30 Oct 2002 22:31:21 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.45 7/10: S/390 trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D: This patch adds the bare-minimum S/390-specific low-level trace
D: statements.

diffstat:
 arch/s390/kernel/entry.S    |   18 ++++++
 arch/s390/kernel/process.c  |    5 +
 arch/s390/kernel/sys_s390.c |    3 +
 arch/s390/kernel/traps.c    |  117 ++++++++++++++++++++++++++++++++++++++++++++
 arch/s390/mm/fault.c        |   12 ++++
 drivers/s390/cio/cio.c      |    4 +
 drivers/s390/s390mach.c     |   12 ++++
 include/asm-s390/trace.h    |   16 ++++++
 8 files changed, 187 insertions(+)

diff -urpN linux-2.5.45/arch/s390/kernel/entry.S linux-2.5.45-ltt/arch/s390/kernel/entry.S
--- linux-2.5.45/arch/s390/kernel/entry.S	Wed Oct 30 19:42:16 2002
+++ linux-2.5.45-ltt/arch/s390/kernel/entry.S	Wed Oct 30 20:51:10 2002
@@ -7,6 +7,7 @@
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Hartmut Penner (hp@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
+ *  Portions added by T. Halloran: (C) Copyright 2002 IBM Poughkeepsie, IBM Corporation
  */
 
 #include <linux/sys.h>
@@ -181,6 +182,14 @@ system_call:
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	sll	%r7,2
         stosm   24(%r15),0x03     # reenable interrupts
+/* call to ltt trace done here.  R8 has the syscall (svc) number to trace */
+#if (CONFIG_TRACE) /* tjh - ltt port */
+        /* add call to trace_real_syscall_entry */                          
+        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter     
+        l       %r1,BASED(.Ltracesysent)                                    
+        basr    %r14,%r1                                                    
+        lm      %r0,%r6,SP_R0(%r15) /* restore call clobbered regs tjh */   
+#endif
         l       %r8,sys_call_table-entry_base(%r7,%r13) # get system call addr.
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
         bo      BASED(sysc_tracesys)
@@ -189,6 +198,13 @@ system_call:
                                   # ATTENTION: check sys_execve_glue before
                                   # changing anything here !!
 
+#if (CONFIG_TRACE) /* tjh - ltt port */
+        /* add call to trace_real_syscall_exit */ 
+        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter  
+        l       %r1,BASED(.Ltracesysext)                                 
+        basr    %r14,%r1                                                 
+        lm      %r0,%r6,SP_R0(%r15) /* restore call clobbered regs */
+#endif                                                                   
 sysc_return:
 	stnsm   24(%r15),0xfc     # disable I/O and ext. interrupts
 	tm	__TI_flags+3(%r9),_TIF_WORK_MASK
@@ -928,6 +944,8 @@ restart_go:
 .Lsigaltstack: .long  sys_sigaltstack
 .Ltrace:       .long  syscall_trace
 .Lvfork:       .long  sys_vfork
+.Ltracesysent: .long  trace_real_syscall_entry
+.Ltracesysext: .long  trace_real_syscall_exit 
 #if CONFIG_SMP || CONFIG_PREEMPT
 .Lschedtail:   .long  schedule_tail
 #endif
diff -urpN linux-2.5.45/arch/s390/kernel/process.c linux-2.5.45-ltt/arch/s390/kernel/process.c
--- linux-2.5.45/arch/s390/kernel/process.c	Wed Oct 30 19:43:36 2002
+++ linux-2.5.45-ltt/arch/s390/kernel/process.c	Wed Oct 30 20:51:10 2002
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -147,6 +148,10 @@ int kernel_thread(int (*fn)(void *), voi
 
 	/* Ok, create the new process.. */
 	p = do_fork(flags | CLONE_VM, 0, &regs, 0, NULL);
+#if (CONFIG_TRACE)
+	if(!IS_ERR(p))
+		TRACE_PROCESS(TRACE_EV_PROCESS_KTHREAD, p->pid, (int) fn);
+#endif
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
diff -urpN linux-2.5.45/arch/s390/kernel/sys_s390.c linux-2.5.45-ltt/arch/s390/kernel/sys_s390.c
--- linux-2.5.45/arch/s390/kernel/sys_s390.c	Wed Oct 30 19:42:27 2002
+++ linux-2.5.45-ltt/arch/s390/kernel/sys_s390.c	Wed Oct 30 20:51:10 2002
@@ -24,6 +24,7 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -145,6 +146,8 @@ asmlinkage int sys_ipc (uint call, int f
         struct ipc_kludge tmp;
 	int ret;
 
+        TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
+
         switch (call) {
         case SEMOP:
                 return sys_semop (first, (struct sembuf *)ptr, second);
diff -urpN linux-2.5.45/arch/s390/kernel/traps.c linux-2.5.45-ltt/arch/s390/kernel/traps.c
--- linux-2.5.45/arch/s390/kernel/traps.c	Wed Oct 30 19:42:26 2002
+++ linux-2.5.45-ltt/arch/s390/kernel/traps.c	Wed Oct 30 20:51:10 2002
@@ -5,6 +5,7 @@
  *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
+ *  Portions added by T. Halloran: (C) Copyright 2002 IBM Poughkeepsie, IBM Corporation
  *
  *  Derived from "arch/i386/kernel/traps.c"
  *    Copyright (C) 1991, 1992 Linus Torvalds
@@ -28,6 +29,8 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 
+#include <linux/trace.h>
+
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -283,6 +286,9 @@ void die(const char * str, struct pt_reg
 static void inline do_trap(long interruption_code, int signr, char *str,
                            struct pt_regs *regs, siginfo_t *info)
 {
+         trapid_t ltt_interruption_code; 
+         char * ic_ptr = (char *) &ltt_interruption_code;
+ 
 	/*
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
@@ -290,6 +296,10 @@ static void inline do_trap(long interrup
         if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
+	memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+	memcpy(ic_ptr+4,&interruption_code,sizeof(interruption_code));
+	TRACE_TRAP_ENTRY(ltt_interruption_code, (regs->psw.addr & PSW_ADDR_MASK));
+
         if (regs->psw.mask & PSW_MASK_PSTATE) {
                 struct task_struct *tsk = current;
 
@@ -318,6 +328,7 @@ static void inline do_trap(long interrup
                 else
                         die(str, regs, interruption_code);
         }
+	TRACE_TRAP_EXIT();
 }
 
 static inline void *get_check_address(struct pt_regs *regs)
@@ -415,6 +426,8 @@ asmlinkage void illegal_op(struct pt_reg
 {
         __u8 opcode[6];
 	__u16 *location;
+        trapid_t ltt_interruption_code;
+        char * ic_ptr = (char *) &ltt_interruption_code;
 	int signal = 0;
 
 	location = (__u16 *)(regs->psw.addr-S390_lowcore.pgm_ilc);
@@ -426,6 +439,10 @@ asmlinkage void illegal_op(struct pt_reg
 	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
+	memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+	memcpy(ic_ptr+4,&interruption_code,sizeof(interruption_code));
+	TRACE_TRAP_ENTRY(ltt_interruption_code, (regs->psw.addr & PSW_ADDR_MASK));
+
 	if (regs->psw.mask & PSW_MASK_PSTATE)
 		get_user(*((__u16 *) opcode), location);
 	else
@@ -466,6 +483,7 @@ asmlinkage void illegal_op(struct pt_reg
         else if (signal)
 		do_trap(interruption_code, signal,
 			"illegal operation", regs, NULL);
+        TRACE_TRAP_EXIT();
 }
 
 
@@ -476,6 +494,8 @@ specification_exception(struct pt_regs *
 {
         __u8 opcode[6];
 	__u16 *location = NULL;
+        trapid_t ltt_interruption_code;
+        char * ic_ptr = (char *) &ltt_interruption_code;
 	int signal = 0;
 
 	location = (__u16 *) get_check_address(regs);
@@ -486,6 +506,10 @@ specification_exception(struct pt_regs *
 	 */
 	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
+
+        memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+        memcpy(ic_ptr+4,&interruption_code,sizeof(interruption_code));
+        TRACE_TRAP_ENTRY(ltt_interruption_code, (regs->psw.addr & PSW_ADDR_MASK));
 		
         if (regs->psw.mask & PSW_MASK_PSTATE) {
 		get_user(*((__u16 *) opcode), location);
@@ -530,6 +554,7 @@ specification_exception(struct pt_regs *
 		do_trap(interruption_code, signal, 
 			"specification exception", regs, &info);
 	}
+        TRACE_TRAP_EXIT();
 }
 #else
 DO_ERROR_INFO(SIGILL, "specification exception", specification_exception,
@@ -539,6 +564,8 @@ DO_ERROR_INFO(SIGILL, "specification exc
 asmlinkage void data_exception(struct pt_regs * regs, long interruption_code)
 {
 	__u16 *location;
+        trapid_t ltt_interruption_code;
+        char * ic_ptr = (char *) &ltt_interruption_code;
 	int signal = 0;
 
 	location = (__u16 *) get_check_address(regs);
@@ -550,6 +577,10 @@ asmlinkage void data_exception(struct pt
 	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
+	memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+	memcpy(ic_ptr+4,&interruption_code,sizeof(interruption_code));
+	TRACE_TRAP_ENTRY(ltt_interruption_code, (regs->psw.addr & PSW_ADDR_MASK));
+
 	if (MACHINE_HAS_IEEE)
 		__asm__ volatile ("stfpc %0\n\t" 
 				  : "=m" (current->thread.fp_regs.fpc));
@@ -625,6 +656,7 @@ asmlinkage void data_exception(struct pt
 		do_trap(interruption_code, signal, 
 			"data exception", regs, &info);
 	}
+        TRACE_TRAP_EXIT();
 }
 
 
@@ -679,6 +711,11 @@ void __init trap_init(void)
 
 void handle_per_exception(struct pt_regs *regs)
 {
+	trapid_t ltt_interruption_code;
+	char * ic_ptr = (char *) &ltt_interruption_code;
+	memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+	memcpy(ic_ptr+6,&S390_lowcore.pgm_code,2); /* copy the interrupt code */
+	TRACE_TRAP_ENTRY(ltt_interruption_code,(regs->psw.addr & PSW_ADDR_MASK));
 	if (regs->psw.mask & PSW_MASK_PSTATE) {
 		per_struct *per_info=&current->thread.per_info;
 		per_info->lowcore.words.perc_atmid=S390_lowcore.per_perc_atmid;
@@ -693,5 +730,85 @@ void handle_per_exception(struct pt_regs
 		/* Hopefully switching off per tracing will help us survive */
 		regs->psw.mask &= ~PSW_MASK_PER;
 	}
+        TRACE_TRAP_EXIT();
+}
+
+#if (CONFIG_TRACE)
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+	int use_depth;
+	int use_bounds;
+	int depth = 0;
+	int seek_depth;
+	unsigned long lower_bound;
+	unsigned long upper_bound;
+	unsigned long addr;
+	unsigned long *stack;
+	unsigned long temp_stack;
+	trace_syscall_entry trace_syscall_event;
+	/* Set the syscall ID                               */
+	/* Register 8 is setup just prior to the call       */
+	/* This instruction is just following linkage       */
+	/* so it's ok.  If moved and chance of R8 being     */
+	/* clobbered, would need to dig it out of the stack */
+	__asm__ volatile ("  stc  8,%0\n\t"
+			  :"=m" (trace_syscall_event.syscall_id));
+	/* get the psw address */
+	trace_syscall_event.address = regs->psw.addr;
+	/* and off the hi-order bit */
+	trace_syscall_event.address &= PSW_ADDR_MASK;
+	if (!(user_mode(regs)))	/* if kernel mode, return */
+		goto trace_syscall_end;
+	/* Get the trace configuration - if none, return */
+	if (trace_get_config(&use_depth,
+			     &use_bounds,
+			     &seek_depth,
+			     (void *) &lower_bound,
+			     (void *) &upper_bound) < 0)
+		goto trace_syscall_end;
+	/* Do we have to search for an instruction pointer address range */
+	if ((use_depth == 1) || (use_bounds == 1)) {
+		/* Start at the top of the stack */
+		/* stack pointer is register 15 */
+		stack = (unsigned long *) regs->gprs[15];	/* stack pointer */
+		/* Keep on going until we reach the end of the process' stack limit */
+		do {
+			get_user(addr, stack + 14);	/* get the program address +0x38 */
+			/* and off the hi-order bit */
+			addr &= PSW_ADDR_MASK;
+			/* Does this LOOK LIKE an address in the program */
+			if ((addr > current->mm->start_code)
+			    && (addr < current->mm->end_code)) {
+				/* Does this address fit the description */
+				if (((use_depth == 1) && (depth == seek_depth))
+				    || ((use_bounds == 1) && (addr > lower_bound)
+					&& (addr < upper_bound))) {
+					/* Set the address */
+					trace_syscall_event.address = addr;
+					/* We're done */
+					goto trace_syscall_end;
+				} else
+					/* We're one depth more */
+					depth++;
+			}
+			/* Go on to the next address */
+			get_user(temp_stack, stack);	/* get contents of stack */
+			temp_stack &= PSW_ADDR_MASK;	/* and off hi order bit */
+			stack = (unsigned long *) temp_stack;	/* move into stack */
+			/* stack may or may not go to zero when end hit               */
+			/* using 0x7fffffff-_STK_LIM to validate that the address is  */
+			/* within the range of a valid stack address                  */
+			/* If outside that range, exit the loop, stack end must have  */
+			/* been hit.                                                  */
+		} while (stack >= (unsigned long *) (0x7fffffff - _STK_LIM));
+	}
+trace_syscall_end:
+	/* Trace the event */
+	trace_event(TRACE_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_event(TRACE_EV_SYSCALL_EXIT, NULL);
 }
 
+#endif				/* (CONFIG_TRACE) */
diff -urpN linux-2.5.45/arch/s390/mm/fault.c linux-2.5.45-ltt/arch/s390/mm/fault.c
--- linux-2.5.45/arch/s390/mm/fault.c	Wed Oct 30 19:43:37 2002
+++ linux-2.5.45-ltt/arch/s390/mm/fault.c	Wed Oct 30 20:51:10 2002
@@ -5,6 +5,7 @@
  *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Hartmut Penner (hp@de.ibm.com)
  *               Ulrich Weigand (uweigand@de.ibm.com)
+ *  Portions added by T. Halloran: (C) Copyright 2002 IBM Poughkeepsie, IBM Corporation
  *
  *  Derived from "arch/i386/mm/fault.c"
  *    Copyright (C) 1995  Linus Torvalds
@@ -25,6 +26,7 @@
 #include <linux/compatmac.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/trace.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -153,6 +155,8 @@ extern inline void do_exception(struct p
 	int user_address;
         unsigned long fixup;
 	int si_code = SEGV_MAPERR;
+        trapid_t ltt_interruption_code;                 
+        char * ic_ptr = (char *) &ltt_interruption_code; 
 
         tsk = current;
         mm = tsk->mm;
@@ -200,6 +204,9 @@ extern inline void do_exception(struct p
 	 */
 	local_irq_enable();
 
+        memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+        memcpy(ic_ptr+4,&error_code,sizeof(error_code));
+        TRACE_TRAP_ENTRY(ltt_interruption_code,(regs->psw.addr & PSW_ADDR_MASK));
         down_read(&mm->mmap_sem);
 
         vma = find_vma(mm, address);
@@ -248,6 +255,7 @@ survive:
 	}
 
         up_read(&mm->mmap_sem);
+        TRACE_TRAP_EXIT();
         return;
 
 /*
@@ -262,6 +270,7 @@ bad_area:
                 tsk->thread.prot_addr = address;
                 tsk->thread.trap_no = error_code;
 		force_sigsegv(regs, error_code, si_code, address);
+                TRACE_TRAP_EXIT();
                 return;
 	}
 
@@ -269,6 +278,7 @@ no_context:
         /* Are we prepared to handle this kernel fault?  */
         if ((fixup = search_exception_table(regs->psw.addr)) != 0) {
                 regs->psw.addr = fixup;
+                TRACE_TRAP_EXIT();
                 return;
         }
 
@@ -316,6 +326,8 @@ do_sigbus:
 	/* Kernel mode? Handle exceptions or die */
 	if (!(regs->psw.mask & PSW_MASK_PSTATE))
 		goto no_context;
+
+	TRACE_TRAP_EXIT();
 }
 
 void do_protection_exception(struct pt_regs *regs, unsigned long error_code)
diff -urpN linux-2.5.45/drivers/s390/cio/cio.c linux-2.5.45-ltt/drivers/s390/cio/cio.c
--- linux-2.5.45/drivers/s390/cio/cio.c	Wed Oct 30 19:43:44 2002
+++ linux-2.5.45-ltt/drivers/s390/cio/cio.c	Wed Oct 30 20:51:12 2002
@@ -18,6 +18,8 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 
+#include <linux/trace.h>
+
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
@@ -945,9 +947,11 @@ do_IRQ (struct pt_regs regs)
 			}
 
 			irq_enter ();
+			TRACE_IRQ_ENTRY(irq, !(((regs).psw.mask&PSW_PROBLEM_STATE) != 0));
 			s390irq_spin_lock (irq);
 			s390_process_IRQ (irq);
 			s390irq_spin_unlock (irq);
+			TRACE_IRQ_EXIT();
 			irq_exit ();
 		}
 
diff -urpN linux-2.5.45/drivers/s390/s390mach.c linux-2.5.45-ltt/drivers/s390/s390mach.c
--- linux-2.5.45/drivers/s390/s390mach.c	Wed Oct 30 19:43:44 2002
+++ linux-2.5.45-ltt/drivers/s390/s390mach.c	Wed Oct 30 20:51:13 2002
@@ -5,6 +5,7 @@
  *  S390 version
  *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
+ *  Portions added by T. Halloran: (C) Copyright 2002 IBM Poughkeepsie, IBM Corporation
  */
 
 #include <linux/config.h>
@@ -12,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
+#include <linux/trace.h>
 #ifdef CONFIG_SMP
 #include <linux/smp.h>
 #endif
@@ -179,10 +181,20 @@ s390_do_machine_check(void)
 {
 	int crw_count;
 	mcic_t mcic;
+        trapid_t ltt_interruption_code;
+        uint32_t ltt_old_psw;
 
 	DBG(KERN_INFO "s390_do_machine_check : starting ...\n");
 
 	memcpy(&mcic, &S390_lowcore.mcck_interruption_code, sizeof (__u64));
+	memcpy( &ltt_interruption_code,
+	        &S390_lowcore.mcck_interruption_code,
+	        sizeof(__u64));
+	memcpy( &ltt_old_psw,
+	        &S390_lowcore.mcck_old_psw,
+	        sizeof(uint32_t));
+        ltt_old_psw &=  PSW_ADDR_MASK;
+        TRACE_TRAP_ENTRY(ltt_interruption_code,ltt_old_psw);
 
 	if (mcic.mcc.mcd.sd)	/* system damage */
 		s390_handle_damage("received system damage machine check\n");
diff -urpN linux-2.5.45/include/asm-s390/trace.h linux-2.5.45-ltt/include/asm-s390/trace.h
--- linux-2.5.45/include/asm-s390/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.45-ltt/include/asm-s390/trace.h	Wed Oct 30 20:51:14 2002
@@ -0,0 +1,16 @@
+/*
+ * linux/include/asm-s390/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * S/390 definitions for tracing system
+ */
+
+#include <linux/trace.h>
+#include <asm-generic/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_S390
+
+/* Current variant type */
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_NONE
