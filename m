Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbUCZSfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbUCZSfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:35:46 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:25033 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264119AbUCZSVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:21:51 -0500
Date: Fri, 26 Mar 2004 19:21:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (6/7): system call speedup part 1.
Message-ID: <20040326182132.GG2523@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System call speedup part 1.

diffstat:
 arch/s390/kernel/asm-offsets.c   |   11 +
 arch/s390/kernel/binfmt_elf32.c  |   25 +-
 arch/s390/kernel/compat_signal.c |    6 
 arch/s390/kernel/entry.S         |  346 ++++++++++++++++++++++++---------------
 arch/s390/kernel/entry64.S       |  322 +++++++++++++++++++++++-------------
 arch/s390/kernel/process.c       |   20 +-
 arch/s390/kernel/ptrace.c        |  107 +++++++-----
 arch/s390/kernel/s390_ksyms.c    |    2 
 arch/s390/kernel/setup.c         |    3 
 arch/s390/kernel/signal.c        |   17 +
 arch/s390/kernel/traps.c         |   21 +-
 arch/s390/lib/uaccess.S          |  254 +++++++++++++++++-----------
 arch/s390/lib/uaccess64.S        |  253 +++++++++++++++++-----------
 arch/s390/mm/fault.c             |    8 
 arch/s390/mm/init.c              |    4 
 15 files changed, 878 insertions(+), 521 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/asm-offsets.c linux-2.6-s390/arch/s390/kernel/asm-offsets.c
--- linux-2.6/arch/s390/kernel/asm-offsets.c	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/asm-offsets.c	Fri Mar 26 18:25:59 2004
@@ -17,10 +17,10 @@
 int main(void)
 {
 	DEFINE(__THREAD_info, offsetof(struct task_struct, thread_info),);
-	DEFINE(__THREAD_ar2, offsetof(struct task_struct, thread.ar2),);
-	DEFINE(__THREAD_ar4, offsetof(struct task_struct, thread.ar4),);
 	DEFINE(__THREAD_ksp, offsetof(struct task_struct, thread.ksp),);
 	DEFINE(__THREAD_per, offsetof(struct task_struct, thread.per_info),);
+	DEFINE(__THREAD_mm_segment,
+	       offsetof(struct task_struct, thread.mm_segment),);
 	BLANK();
 	DEFINE(__PER_atmid, offsetof(per_struct, lowcore.words.perc_atmid),);
 	DEFINE(__PER_address, offsetof(per_struct, lowcore.words.address),);
@@ -31,5 +31,12 @@
 	DEFINE(__TI_flags, offsetof(struct thread_info, flags),);
 	DEFINE(__TI_cpu, offsetof(struct thread_info, cpu),);
 	DEFINE(__TI_precount, offsetof(struct thread_info, preempt_count),);
+	BLANK();
+	DEFINE(__PT_PSW, offsetof(struct pt_regs, psw),);
+	DEFINE(__PT_GPRS, offsetof(struct pt_regs, gprs),);
+	DEFINE(__PT_ORIG_GPR2, offsetof(struct pt_regs, orig_gpr2),);
+	DEFINE(__PT_ILC, offsetof(struct pt_regs, ilc),);
+	DEFINE(__PT_TRAP, offsetof(struct pt_regs, trap),);
+	DEFINE(__PT_SIZE, sizeof(struct pt_regs),);
 	return 0;
 }
diff -urN linux-2.6/arch/s390/kernel/binfmt_elf32.c linux-2.6-s390/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6/arch/s390/kernel/binfmt_elf32.c	Thu Mar 11 03:55:44 2004
+++ linux-2.6-s390/arch/s390/kernel/binfmt_elf32.c	Fri Mar 26 18:25:59 2004
@@ -57,18 +57,7 @@
 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
    now struct_user_regs, they are different) */
 
-#define ELF_CORE_COPY_REGS(pr_reg, regs)        \
-	{ \
-	int i; \
-	memcpy(&pr_reg.psw.mask, &regs->psw.mask, 4); \
-	memcpy(&pr_reg.psw.addr, ((char*)&regs->psw.addr)+4, 4); \
-	for(i=0; i<NUM_GPRS; i++) \
-		pr_reg.gprs[i] = regs->gprs[i]; \
-	for(i=0; i<NUM_ACRS; i++) \
-		pr_reg.acrs[i] = regs->acrs[i]; \
-	pr_reg.orig_gpr2 = regs->orig_gpr2; \
-	}
-
+#define ELF_CORE_COPY_REGS(pr_reg, regs) dump_regs32(regs, &pr_reg);
 
 
 /* This yields a mask that user programs can use to figure out what
@@ -107,6 +96,18 @@
 } s390_regs32;
 typedef s390_regs32 elf_gregset_t;
 
+static inline int dump_regs32(struct pt_regs *ptregs, elf_gregset_t *regs)
+{
+	int i;
+
+	memcpy(&regs->psw.mask, &ptregs->psw.mask, 4);
+	memcpy(&regs->psw.addr, &ptregs->psw.addr, 4);
+	for (i = 0; i < NUM_GPRS; i++)
+		regs->gprs[i] = ptregs->gprs[i];
+	regs->orig_gpr2 = ptregs->orig_gpr2;
+	return 1;
+}
+
 #include <asm/processor.h>
 #include <linux/module.h>
 #include <linux/config.h>
diff -urN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-s390/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	Fri Mar 26 18:25:13 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Fri Mar 26 18:25:59 2004
@@ -297,7 +297,8 @@
 	regs32.psw.addr = PSW32_ADDR_AMODE31 | (__u32) regs->psw.addr;
 	for (i = 0; i < NUM_GPRS; i++)
 		regs32.gprs[i] = (__u32) regs->gprs[i];
-	memcpy(regs32.acrs, regs->acrs, sizeof(regs32.acrs));
+	save_access_regs(current->thread.acrs);
+	memcpy(regs32.acrs, current->thread.acrs, sizeof(regs32.acrs));
 	err = __copy_to_user(&sregs->regs, &regs32, sizeof(regs32));
 	if (err)
 		return err;
@@ -323,7 +324,8 @@
 	regs->psw.addr = (__u64)(regs32.psw.addr & PSW32_ADDR_INSN);
 	for (i = 0; i < NUM_GPRS; i++)
 		regs->gprs[i] = (__u64) regs32.gprs[i];
-	memcpy(regs->acrs, regs32.acrs, sizeof(regs32.acrs));
+	memcpy(current->thread.acrs, regs32.acrs, sizeof(current->thread.acrs));
+	restore_access_regs(current->thread.acrs);
 
 	err = __copy_from_user(&current->thread.fp_regs, &sregs->fpregs,
 			       sizeof(_s390_fp_regs32));
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Fri Mar 26 18:25:59 2004
@@ -25,40 +25,32 @@
  * The first few entries are identical to the user_regs_struct.
  */
 SP_PTREGS    =  STACK_FRAME_OVERHEAD 
-SP_PSW       =  STACK_FRAME_OVERHEAD + PT_PSWMASK
-SP_R0        =  STACK_FRAME_OVERHEAD + PT_GPR0
-SP_R1        =  STACK_FRAME_OVERHEAD + PT_GPR1
-SP_R2        =  STACK_FRAME_OVERHEAD + PT_GPR2
-SP_R3        =  STACK_FRAME_OVERHEAD + PT_GPR3
-SP_R4        =  STACK_FRAME_OVERHEAD + PT_GPR4
-SP_R5        =  STACK_FRAME_OVERHEAD + PT_GPR5
-SP_R6        =  STACK_FRAME_OVERHEAD + PT_GPR6
-SP_R7        =  STACK_FRAME_OVERHEAD + PT_GPR7
-SP_R8        =  STACK_FRAME_OVERHEAD + PT_GPR8
-SP_R9        =  STACK_FRAME_OVERHEAD + PT_GPR9
-SP_R10       =  STACK_FRAME_OVERHEAD + PT_GPR10
-SP_R11       =  STACK_FRAME_OVERHEAD + PT_GPR11
-SP_R12       =  STACK_FRAME_OVERHEAD + PT_GPR12
-SP_R13       =  STACK_FRAME_OVERHEAD + PT_GPR13
-SP_R14       =  STACK_FRAME_OVERHEAD + PT_GPR14
-SP_R15       =  STACK_FRAME_OVERHEAD + PT_GPR15
-SP_AREGS     =  STACK_FRAME_OVERHEAD + PT_ACR0
-SP_ORIG_R2   =  STACK_FRAME_OVERHEAD + PT_ORIGGPR2
-/* Now the additional entries */
-SP_ILC       =  (SP_ORIG_R2+GPR_SIZE)
-SP_TRAP      =  (SP_ILC+2)
-SP_SIZE      =  (SP_TRAP+2)
+SP_PSW       =  STACK_FRAME_OVERHEAD + __PT_PSW
+SP_R0        =  STACK_FRAME_OVERHEAD + __PT_GPRS
+SP_R1        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 4
+SP_R2        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 8
+SP_R3        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 12
+SP_R4        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 16
+SP_R5        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 20
+SP_R6        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 24
+SP_R7        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 28
+SP_R8        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 32
+SP_R9        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 36
+SP_R10       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 40
+SP_R11       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 44
+SP_R12       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 48
+SP_R13       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 52
+SP_R14       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 56
+SP_R15       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 60
+SP_ORIG_R2   =  STACK_FRAME_OVERHEAD + __PT_ORIG_GPR2
+SP_ILC       =  STACK_FRAME_OVERHEAD + __PT_ILC
+SP_TRAP      =  STACK_FRAME_OVERHEAD + __PT_TRAP
+SP_SIZE      =  STACK_FRAME_OVERHEAD + __PT_SIZE
 
 _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
 
-/*
- * Base Address of this Module --- saved in __LC_ENTRY_BASE
- */
-       .globl entry_base
-entry_base:
-
-#define BASED(name) name-entry_base(%r13)
+#define BASED(name) name-system_call(%r13)
 
 /*
  * Register usage in interrupt handlers:
@@ -68,55 +60,108 @@
  *    R15 - kernel stack pointer
  */
 
-        .macro  SAVE_ALL_BASE
-        stm     %r13,%r15,__LC_SAVE_AREA
-        basr    %r13,0                    #  temp base pointer
-0:	stam    %a2,%a4,__LC_SAVE_AREA+12
-        l       %r13,.Lentry_base-0b(%r13)# load &entry_base to %r13
+        .macro  SAVE_ALL_BASE psworg,savearea,sync
+        stm     %r12,%r15,\savearea
+	l	%r13,__LC_SVC_NEW_PSW+4   # load &system_call to %r13
 	.endm
 
-        .macro  SAVE_ALL psworg,sync      # system entry macro
-        tm      \psworg+1,0x01            # test problem state bit
+        .macro  CLEANUP_SAVE_ALL_BASE psworg,savearea,sync
+	l	%r1,SP_PSW+4(%r15)
+	cli	1(%r1),0xcf
+	jne	0f
+	mvc	\savearea(16),SP_R12(%r15)
+0:	st	%r13,SP_R13(%r15)
+	.endm
+
+        .macro  SAVE_ALL psworg,savearea,sync
 	.if	\sync
+        tm      \psworg+1,0x01            # test problem state bit
         bz      BASED(1f)                 # skip stack setup save
+        l       %r15,__LC_KERNEL_STACK    # problem state -> load ksp
 	.else
-        bnz     BASED(0f)                 # from user -> load kernel stack
+        tm      \psworg+1,0x01            # test problem state bit
+        bnz     BASED(0f)                 # from user -> load async stack
 	l	%r14,__LC_ASYNC_STACK	  # are we already on the async stack ?
 	slr     %r14,%r15
 	sra	%r14,13
 	be	BASED(1f)
-        l       %r15,__LC_ASYNC_STACK     # load async. stack
-	b	BASED(1f)
+0:	l	%r15,__LC_ASYNC_STACK
 	.endif
-0:      l       %r15,__LC_KERNEL_STACK    # problem state -> load ksp
-	lam	%a2,%a4,BASED(.Lc_ac)	  # set ac.reg. 2 to primary space
-					  # and ac.reg. 4 to home space
 1:      s       %r15,BASED(.Lc_spsize)    # make room for registers & psw
-        n       %r15,BASED(.Lc0xfffffff8) # align stack pointer to 8
-        stm     %r0,%r12,SP_R0(%r15)      # store gprs 0-12 to kernel stack
+	l	%r14,BASED(.L\psworg)
+	slr	%r12,%r12
+	icm	%r14,12,__LC_SVC_ILC
+        stm     %r0,%r11,SP_R0(%r15)      # store gprs 0-12 to kernel stack
         st      %r2,SP_ORIG_R2(%r15)      # store original content of gpr 2
-        mvc     SP_R13(12,%r15),__LC_SAVE_AREA  # move R13-R15 to stack
-        stam    %a0,%a15,SP_AREGS(%r15)   # store access registers to kst.
-        mvc     SP_AREGS+8(12,%r15),__LC_SAVE_AREA+12 # store ac. regs
+        mvc     SP_R12(16,%r15),\savearea # move R13-R15 to stack
         mvc     SP_PSW(8,%r15),\psworg    # move user PSW to stack
-	mvc	SP_ILC(2,%r15),__LC_SVC_ILC      # store instruction length
-	mvc	SP_TRAP(2,%r15),BASED(.L\psworg) # store trap indication
-        xc      0(4,%r15),0(%r15)         # clear back chain
+	st	%r14,SP_ILC(%r15)
+        st      %r12,0(%r15)              # clear back chain
         .endm
 
-        .macro  RESTORE_ALL sync          # system exit macro
+	.macro	CLEANUP_SAVE_ALL psworg,savearea,sync
+	l	%r1,\savearea+12
+	.if	\sync
+	tm	\psworg+1,0x01
+	bz	BASED(1f)
+	l	%r1,__LC_KERNEL_STACK
+	.else
+	tm	\psworg+1,0x01
+	bnz	BASED(0f)
+	l	%r0,__LC_ASYNC_STACK
+	slr	%r0,%r1
+	sra	%r0,13
+	bz	BASED(1f)
+0:	l	%r1,__LC_ASYNC_STACK
+	.endif
+1:	s	%r1,BASED(.Lc_spsize)
+	st	%r1,SP_R15(%r15)
+	l	%r0,BASED(.L\psworg)
+	xc	SP_R12(4,%r15),SP_R12(%r15)
+	icm	%r0,12,__LC_SVC_ILC
+	st	%r0,SP_R14(%r15)
+	mvc	SP_R0(48,%r1),SP_R0(%r15)
+	mvc	SP_ORIG_R2(4,%r1),SP_R2(%r15)
+	mvc	SP_R12(16,%r1),\savearea
+	mvc	SP_PSW(8,%r1),\psworg
+	st	%r0,SP_ILC(%r1)
+	xc	0(4,%r1),0(%r1)	
+	.endm
+
+        .macro  RESTORE_ALL               # system exit macro
         mvc     __LC_RETURN_PSW(8),SP_PSW(%r15)  # move user PSW to lowcore
-        lam     %a0,%a15,SP_AREGS(%r15)   # load the access registers
-        lm      %r0,%r15,SP_R0(%r15)      # load gprs 0-15 of user
         ni      __LC_RETURN_PSW+1,0xfd    # clear wait state bit
+        lm      %r0,%r15,SP_R0(%r15)      # load gprs 0-15 of user
         lpsw    __LC_RETURN_PSW           # back to caller
         .endm
 
+	.macro	CLEANUP_RESTORE_ALL
+	l	%r1,SP_PSW+4(%r15)
+	cli	0(%r1),0x82
+	jne	0f
+	mvc	SP_PSW(8,%r15),__LC_RETURN_PSW
+	j	1f
+0:	l	%r1,SP_R15(%r15)
+	mvc	SP_PSW(8,%r15),SP_PSW(%r1)
+	mvc	SP_R0(64,%r15),SP_R0(%r1)
+1:
+	.endm
+
         .macro  GET_THREAD_INFO
-	l	%r9,BASED(.Lc0xffffe000)  # load pointer to task_struct to %r9
-	al	%r9,__LC_KERNEL_STACK
+	l	%r9,__LC_THREAD_INFO
         .endm
 
+	.macro	CHECK_CRITICAL
+        tm      SP_PSW+1(%r15),0x01      # test problem state bit
+	bnz	BASED(0f)		 # from user -> not critical
+	clc	SP_PSW+4(4,%r15),BASED(.Lcritical_end)
+	jnl	0f
+	clc	SP_PSW+4(4,%r15),BASED(.Lcritical_start)
+	jl	0f
+	l	%r1,BASED(.Lcleanup_critical)
+	basr	%r14,%r1
+0:
+	.endm
 
 /*
  * Scheduler resume function, called by switch_to
@@ -139,13 +184,10 @@
         stm     %r6,%r15,24(%r15)       # store __switch_to registers of prev task
 	st	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	l	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
-	stam    %a2,%a2,__THREAD_ar2(%r2)	# store kernel access reg. 2
-	stam    %a4,%a4,__THREAD_ar4(%r2)	# store kernel access reg. 4
-	lam     %a2,%a2,__THREAD_ar2(%r3)	# load kernel access reg. 2
-	lam     %a4,%a4,__THREAD_ar4(%r3)	# load kernel access reg. 4
 	lm	%r6,%r15,24(%r15)	# load __switch_to registers of next task
 	st	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
 	l	%r3,__THREAD_info(%r3)  # load thread_info from task struct
+	st	%r3,__LC_THREAD_INFO
 	ahi	%r3,8192
 	st	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
 	br	%r14
@@ -172,6 +214,7 @@
 	lm	%r12,%r15,24(%r12)
 	br	%r14
 	
+__critical_start:	
 /*
  * SVC interrupt handler routine. System calls are synchronous events and
  * are executed with interrupts enabled.
@@ -179,10 +222,10 @@
 
 	.globl  system_call
 system_call:
-	SAVE_ALL_BASE
-        SAVE_ALL __LC_SVC_OLD_PSW,1
+	SAVE_ALL_BASE __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+        SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	lh	%r7,0x8a	  # get svc number from lowcore
-        stosm   24(%r15),0x03     # reenable interrupts
+sysc_enter:
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	sla	%r7,2             # *4 and test for svc 0
 	bnz	BASED(sysc_do_restart)  # svc number > 0
@@ -193,7 +236,7 @@
 	sla	%r7,2             # *4
 sysc_do_restart:
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
-        l       %r8,sys_call_table-entry_base(%r7,%r13) # get system call addr.
+        l       %r8,sys_call_table-system_call(%r7,%r13) # get system call addr.
         bo      BASED(sysc_tracesys)
         basr    %r14,%r8          # call sys_xxxx
         st      %r2,SP_R2(%r15)   # store return value (change R2 on stack)
@@ -201,19 +244,17 @@
                                   # changing anything here !!
 
 sysc_return:
-	stnsm   24(%r15),0xfc     # disable I/O and ext. interrupts
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
 	bno	BASED(sysc_leave)
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bnz	BASED(sysc_work)  # there is work to do (signals etc.)
 sysc_leave:
-        RESTORE_ALL 1
+        RESTORE_ALL
 
 #
 # recheck if there is more work to do
 #
 sysc_work_loop:
-	stnsm   24(%r15),0xfc     # disable I/O and ext. interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bz	BASED(sysc_leave)      # there is no work to do
@@ -234,7 +275,6 @@
 # _TIF_NEED_RESCHED is set, call schedule
 #	
 sysc_reschedule:        
-        stosm   24(%r15),0x03          # reenable interrupts
         l       %r1,BASED(.Lschedule)
 	la      %r14,BASED(sysc_work_loop)
 	br      %r1		       # call scheduler
@@ -243,12 +283,10 @@
 # _TIF_SIGPENDING is set, call do_signal
 #
 sysc_sigpending:     
-        stosm   24(%r15),0x03          # reenable interrupts
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
         sr      %r3,%r3                # clear *oldset
         l       %r1,BASED(.Ldo_signal)
 	basr	%r14,%r1               # call do_signal
-        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
 	tm	__TI_flags+3(%r9),_TIF_RESTART_SVC
 	bo	BASED(sysc_restart)
 	b	BASED(sysc_leave)      # out of here, do NOT recheck
@@ -258,13 +296,14 @@
 #
 sysc_restart:
 	ni	__TI_flags+3(%r9),255-_TIF_RESTART_SVC # clear TIF_RESTART_SVC
-	stosm	24(%r15),0x03          # reenable interrupts
 	l	%r7,SP_R2(%r15)        # load new svc number
 	sla	%r7,2
 	mvc	SP_R2(4,%r15),SP_ORIG_R2(%r15) # restore first argument
 	lm	%r2,%r6,SP_R2(%r15)    # load svc arguments
 	b	BASED(sysc_do_restart) # restart svc
 
+__critical_end:
+
 #
 # call trace before and after sys_call
 #
@@ -277,7 +316,7 @@
 	bnl	BASED(sysc_tracenogo)
 	l	%r7,SP_R2(%r15)        # strace might have changed the 
 	sll	%r7,2                  #  system call
-	l	%r8,sys_call_table-entry_base(%r7,%r13)
+	l	%r8,sys_call_table-system_call(%r7,%r13)
 sysc_tracego:
 	lm	%r3,%r6,SP_R3(%r15)
 	l	%r2,SP_ORIG_R2(%r15)
@@ -294,13 +333,13 @@
 # a new process exits the kernel with ret_from_fork
 #
         .globl  ret_from_fork
-ret_from_fork:  
-        basr    %r13,0
-        l       %r13,.Lentry_base-.(%r13)  # setup base pointer to &entry_base
+ret_from_fork:
+	l	%r13,__LC_SVC_NEW_PSW+4
         GET_THREAD_INFO           # load pointer to task_struct to R9
         l       %r1,BASED(.Lschedtail)
-	la      %r14,BASED(sysc_return)
-        br      %r1               # call schedule_tail, return to sysc_return
+	basr    %r14,%r1
+        stosm   24(%r15),0x03     # reenable interrupts
+	b	BASED(sysc_return)
 
 #
 # clone, fork, vfork, exec and sigreturn need glue,
@@ -373,12 +412,6 @@
         br      %r1                   # branch to sys_sigreturn
 
 
-#define SYSCALL(esa,esame,emu)	.long esa
-	.globl  sys_call_table
-sys_call_table:
-#include "syscalls.S"
-#undef SYSCALL
-
 /*
  * Program check handler routine
  */
@@ -398,10 +431,10 @@
  * we just ignore the PER event (FIXME: is there anything we have to do
  * for LPSW?).
  */
-	SAVE_ALL_BASE
+	SAVE_ALL_BASE __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         bnz     BASED(pgm_per)           # got per exception -> special case
-	SAVE_ALL __LC_PGM_OLD_PSW,1
+	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
         l       %r3,__LC_PGM_ILC         # load program interruption code
 	la	%r8,0x7f
         l       %r7,BASED(.Ljump_table)
@@ -430,7 +463,7 @@
 # Normal per exception
 #
 pgm_per_std:
-	SAVE_ALL __LC_PGM_OLD_PSW,1
+	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
 	GET_THREAD_INFO
 	mvc	__THREAD_per+__PER_atmid(2,%r9),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(4,%r9),__LC_PER_ADDRESS
@@ -454,7 +487,7 @@
 # it was a single stepped SVC that is causing all the trouble
 #
 pgm_svcper:
-	SAVE_ALL __LC_SVC_OLD_PSW,1
+	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	lh	%r7,0x8a	  # get svc number from lowcore
         stosm   24(%r15),0x03     # reenable interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
@@ -470,7 +503,7 @@
 	sla	%r7,2             # *4
 pgm_svcstd:
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
-        l       %r8,sys_call_table-entry_base(%r7,%r13) # get system call addr.
+        l       %r8,sys_call_table-system_call(%r7,%r13) # get system call addr.
         bo      BASED(pgm_tracesys)
         basr    %r14,%r8          # call sys_xxxx
         st      %r2,SP_R2(%r15)   # store return value (change R2 on stack)
@@ -503,7 +536,7 @@
 	bnl	BASED(pgm_svc_nogo)
 	l	%r7,SP_R2(%r15)   # strace changed the syscall
 	sll     %r7,2
-	l	%r8,sys_call_table-entry_base(%r7,%r13)
+	l	%r8,sys_call_table-system_call(%r7,%r13)
 pgm_svc_go:
 	lm      %r3,%r6,SP_R3(%r15)
 	l       %r2,SP_ORIG_R2(%r15)
@@ -522,10 +555,11 @@
 
         .globl io_int_handler
 io_int_handler:
-	SAVE_ALL_BASE
-        SAVE_ALL __LC_IO_OLD_PSW,0
-        GET_THREAD_INFO           # load pointer to task_struct to R9
+	SAVE_ALL_BASE __LC_IO_OLD_PSW,__LC_SAVE_AREA+16,0
+        SAVE_ALL __LC_IO_OLD_PSW,__LC_SAVE_AREA+16,0
 	stck	__LC_INT_CLOCK
+	CHECK_CRITICAL
+        GET_THREAD_INFO           # load pointer to task_struct to R9
         l       %r1,BASED(.Ldo_IRQ)        # load address of do_IRQ
         la      %r2,SP_PTREGS(%r15) # address of register-save area
         basr    %r14,%r1          # branch to standard irq handler
@@ -540,24 +574,21 @@
 	tm	__TI_flags+3(%r9),_TIF_WORK_INT
 	bnz	BASED(io_work)         # there is work to do (signals etc.)
 io_leave:
-        RESTORE_ALL 0
+        RESTORE_ALL
 
 #ifdef CONFIG_PREEMPT
 io_preempt:
 	icm	%r0,15,__TI_precount(%r9)
 	bnz     BASED(io_leave)
-io_resume_loop:
-	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
-	bno	BASED(io_leave)
-	mvc     __TI_precount(4,%r9),BASED(.Lc_pactive)
-	# hmpf, we are on the async. stack but to call schedule
-	# we have to move the interrupt frame to the process stack
 	l	%r1,SP_R15(%r15)
 	s	%r1,BASED(.Lc_spsize)
-	n	%r1,BASED(.Lc0xfffffff8)
-	mvc	SP_PTREGS(SP_SIZE-SP_PTREGS,%r1),SP_PTREGS(%r15)
+	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
         xc      0(4,%r1),0(%r1)        # clear back chain
 	lr	%r15,%r1
+io_resume_loop:
+	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
+	bno	BASED(io_leave)
+	mvc     __TI_precount(4,%r9),BASED(.Lc_pactive)
         stosm   24(%r15),0x03          # reenable interrupts
         l       %r1,BASED(.Lschedule)
 	basr	%r14,%r1	       # call schedule
@@ -568,18 +599,19 @@
 #endif
 
 #
-# recheck if there is more work to do
+# switch to kernel stack, then check the TIF bits
 #
-io_work_loop:
-        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
-        GET_THREAD_INFO                # load pointer to task_struct to R9
-	tm	__TI_flags+3(%r9),_TIF_WORK_INT
-	bz	BASED(io_leave)        # there is no work to do
+io_work:
+	l	%r1,__LC_KERNEL_STACK
+	s	%r1,BASED(.Lc_spsize)
+	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
+        xc      0(4,%r1),0(%r1)        # clear back chain
+	lr	%r15,%r1
 #
 # One of the work bits is on. Find out which one.
 # Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
 #
-io_work:
+io_work_loop:
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bo	BASED(io_reschedule)
 	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
@@ -590,10 +622,14 @@
 # _TIF_NEED_RESCHED is set, call schedule
 #	
 io_reschedule:        
-        stosm   24(%r15),0x03          # reenable interrupts
         l       %r1,BASED(.Lschedule)
-	la      %r14,BASED(io_work_loop)
-	br      %r1		       # call scheduler
+        stosm   24(%r15),0x03          # reenable interrupts
+	basr    %r14,%r1	       # call scheduler
+        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
+        GET_THREAD_INFO                # load pointer to task_struct to R9
+	tm	__TI_flags+3(%r9),_TIF_WORK_INT
+	bz	BASED(io_leave)        # there is no work to do
+	b	BASED(io_work_loop)
 
 #
 # _TIF_SIGPENDING is set, call do_signal
@@ -613,10 +649,11 @@
 
         .globl  ext_int_handler
 ext_int_handler:
-	SAVE_ALL_BASE
-        SAVE_ALL __LC_EXT_OLD_PSW,0
-        GET_THREAD_INFO                # load pointer to task_struct to R9
+	SAVE_ALL_BASE __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16,0
+        SAVE_ALL __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16,0
 	stck	__LC_INT_CLOCK
+	CHECK_CRITICAL
+        GET_THREAD_INFO                # load pointer to task_struct to R9
 	la	%r2,SP_PTREGS(%r15)    # address of register-save area
 	lh	%r3,__LC_EXT_INT_CODE  # get interruption code
 	l	%r1,BASED(.Ldo_extint)
@@ -629,12 +666,12 @@
 
         .globl mcck_int_handler
 mcck_int_handler:
-	SAVE_ALL_BASE
-        SAVE_ALL __LC_MCK_OLD_PSW,0
+	SAVE_ALL_BASE __LC_MCK_OLD_PSW,__LC_SAVE_AREA+32,0
+        SAVE_ALL __LC_MCK_OLD_PSW,__LC_SAVE_AREA+32,0
 	l       %r1,BASED(.Ls390_mcck)
 	basr    %r14,%r1	  # call machine check handler
 mcck_return:
-        RESTORE_ALL 0
+        RESTORE_ALL
 
 #ifdef CONFIG_SMP
 /*
@@ -667,24 +704,65 @@
 restart_go:
 #endif
 
+cleanup_table:
+	.long	system_call, sysc_enter, cleanup_sysc_enter
+	.long	sysc_return, sysc_leave, cleanup_sysc_return
+	.long	sysc_leave, sysc_work_loop, cleanup_sysc_leave
+	.long	sysc_work_loop, sysc_reschedule, cleanup_sysc_return
+cleanup_table_entries=(.-cleanup_table) / 12
+
+cleanup_critical:
+	lhi	%r0,cleanup_table_entries
+	la	%r1,BASED(cleanup_table)
+	l	%r2,SP_PSW+4(%r15)
+	la	%r2,0(%r2)
+cleanup_loop:
+	cl	%r2,0(%r1)
+	bl	BASED(cleanup_cont)
+	cl	%r2,4(%r1)
+	bl	BASED(cleanup_found)
+cleanup_cont:
+	la	%r1,12(%r1)
+	bct	%r0,BASED(cleanup_loop)
+	br	%r14
+cleanup_found:
+	l	%r1,8(%r1)
+	br	%r1
+
+cleanup_sysc_enter:
+	CLEANUP_SAVE_ALL_BASE __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	CLEANUP_SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	lh	%r0,0x8a
+	st	%r0,SP_R7(%r15)
+	la	%r1,BASED(sysc_enter)
+	o	%r1,BASED(.Lamode)
+	st	%r1,SP_PSW+4(%r15)
+	br	%r14
+
+cleanup_sysc_return:
+	la	%r1,BASED(sysc_return)
+	o	%r1,BASED(.Lamode)
+	st	%r1,SP_PSW+4(%r15)
+	br	%r14
+
+cleanup_sysc_leave:
+	CLEANUP_RESTORE_ALL
+	br	%r14
+
 /*
  * Integer constants
  */
                .align 4
-.Lc0xfffffff8: .long  -8           # to align stack pointer to 8
-.Lc0xffffe000: .long  -8192        # to round stack pointer to &task_struct
 .Lc_spsize:    .long  SP_SIZE
 .Lc_overhead:  .long  STACK_FRAME_OVERHEAD
-.Lc_ac:        .long  0,0,1
-.Lc_ENOSYS:    .long  -ENOSYS
 .Lc_pactive:   .long  PREEMPT_ACTIVE
-.Lc0xff:       .long  0xff
 .Lnr_syscalls: .long  NR_syscalls
-.L0x018:       .word  0x018
-.L0x020:       .word  0x020
-.L0x028:       .word  0x028
-.L0x030:       .word  0x030
-.L0x038:       .word  0x038
+.L0x018:       .long  0x018
+.L0x020:       .long  0x020
+.L0x028:       .long  0x028
+.L0x030:       .long  0x030
+.L0x038:       .long  0x038
+.Lamode:       .long  0x80000000
 
 /*
  * Symbol constants
@@ -694,8 +772,6 @@
 .Ldo_extint:   .long  do_extint
 .Ldo_signal:   .long  do_signal
 .Ldo_softirq:  .long  do_softirq
-.Lentry_base:  .long  entry_base
-.Lext_hash:    .long  ext_int_hash
 .Lhandle_per:  .long  do_debugger_trap
 .Ljump_table:  .long  pgm_check_table
 .Lschedule:    .long  schedule
@@ -712,4 +788,16 @@
 .Lvfork:       .long  sys_vfork
 .Lschedtail:   .long  schedule_tail
 
+.Lcritical_start:
+               .long  __critical_start + 0x80000000
+.Lcritical_end:
+               .long  __critical_end + 0x80000000
+.Lcleanup_critical:
+               .long  cleanup_critical
+
+#define SYSCALL(esa,esame,emu)	.long esa
+	.globl  sys_call_table
+sys_call_table:
+#include "syscalls.S"
+#undef SYSCALL
 
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Fri Mar 26 18:25:59 2004
@@ -25,29 +25,27 @@
  * The first few entries are identical to the user_regs_struct.
  */
 SP_PTREGS    =  STACK_FRAME_OVERHEAD 
-SP_PSW       =  STACK_FRAME_OVERHEAD + PT_PSWMASK
-SP_R0        =  STACK_FRAME_OVERHEAD + PT_GPR0
-SP_R1        =  STACK_FRAME_OVERHEAD + PT_GPR1
-SP_R2        =  STACK_FRAME_OVERHEAD + PT_GPR2
-SP_R3        =  STACK_FRAME_OVERHEAD + PT_GPR3
-SP_R4        =  STACK_FRAME_OVERHEAD + PT_GPR4
-SP_R5        =  STACK_FRAME_OVERHEAD + PT_GPR5
-SP_R6        =  STACK_FRAME_OVERHEAD + PT_GPR6
-SP_R7        =  STACK_FRAME_OVERHEAD + PT_GPR7
-SP_R8        =  STACK_FRAME_OVERHEAD + PT_GPR8
-SP_R9        =  STACK_FRAME_OVERHEAD + PT_GPR9
-SP_R10       =  STACK_FRAME_OVERHEAD + PT_GPR10
-SP_R11       =  STACK_FRAME_OVERHEAD + PT_GPR11
-SP_R12       =  STACK_FRAME_OVERHEAD + PT_GPR12
-SP_R13       =  STACK_FRAME_OVERHEAD + PT_GPR13
-SP_R14       =  STACK_FRAME_OVERHEAD + PT_GPR14
-SP_R15       =  STACK_FRAME_OVERHEAD + PT_GPR15
-SP_AREGS     =  STACK_FRAME_OVERHEAD + PT_ACR0
-SP_ORIG_R2   =  STACK_FRAME_OVERHEAD + PT_ORIGGPR2
-/* Now the additional entries */
-SP_ILC       =  (SP_ORIG_R2+GPR_SIZE)
-SP_TRAP      =  (SP_ILC+2)
-SP_SIZE      =  (SP_TRAP+2)
+SP_PSW       =  STACK_FRAME_OVERHEAD + __PT_PSW
+SP_R0        =  STACK_FRAME_OVERHEAD + __PT_GPRS
+SP_R1        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 8
+SP_R2        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 16
+SP_R3        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 24
+SP_R4        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 32
+SP_R5        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 40
+SP_R6        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 48
+SP_R7        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 56
+SP_R8        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 64
+SP_R9        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 72
+SP_R10       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 80
+SP_R11       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 88
+SP_R12       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 96
+SP_R13       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 104
+SP_R14       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 112
+SP_R15       =  STACK_FRAME_OVERHEAD + __PT_GPRS + 120
+SP_ORIG_R2   =  STACK_FRAME_OVERHEAD + __PT_ORIG_GPR2
+SP_ILC       =  STACK_FRAME_OVERHEAD + __PT_ILC
+SP_TRAP      =  STACK_FRAME_OVERHEAD + __PT_TRAP
+SP_SIZE      =  STACK_FRAME_OVERHEAD + __PT_SIZE
 
 _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
@@ -60,51 +58,100 @@
  *    R15 - kernel stack pointer
  */
 
-        .macro  SAVE_ALL psworg,sync     # system entry macro
-        stmg    %r14,%r15,__LC_SAVE_AREA
-	stam    %a2,%a4,__LC_SAVE_AREA+16
-	larl	%r14,.Lconst
-        tm      \psworg+1,0x01           # test problem state bit
+        .macro  SAVE_ALL psworg,savearea,sync
+        stmg    %r13,%r15,\savearea
 	.if	\sync
+        tm      \psworg+1,0x01           # test problem state bit
         jz      1f                       # skip stack setup save
+	lg      %r15,__LC_KERNEL_STACK   # problem state -> load ksp
 	.else
+        tm      \psworg+1,0x01           # test problem state bit
 	jnz	0f			 # from user -> load kernel stack
 	lg	%r14,__LC_ASYNC_STACK	 # are we already on the async. stack ?
 	slgr	%r14,%r15
 	srag	%r14,%r14,14
-	larl	%r14,.Lconst
 	jz	1f
-	lg	%r15,__LC_ASYNC_STACK	 # load async. stack
-	j	1f
+0:	lg      %r15,__LC_ASYNC_STACK    # load async stack
 	.endif
-0:	lg      %r15,__LC_KERNEL_STACK   # problem state -> load ksp
-	lam	%a2,%a4,.Lc_ac-.Lconst(%r14)
 1:      aghi    %r15,-SP_SIZE            # make room for registers & psw
-        nill    %r15,0xfff8              # align stack pointer to 8
-        stmg    %r0,%r13,SP_R0(%r15)     # store gprs 0-13 to kernel stack
+	lghi	%r14,\psworg
+	slgr	%r13,%r13
+	icm	%r14,12,__LC_SVC_ILC
+        stmg    %r0,%r12,SP_R0(%r15)     # store gprs 0-13 to kernel stack
         stg     %r2,SP_ORIG_R2(%r15)     # store original content of gpr 2
-        mvc     SP_R14(16,%r15),__LC_SAVE_AREA # move r14 and r15 to stack
-        stam    %a0,%a15,SP_AREGS(%r15)  # store access registers to kst.
-        mvc     SP_AREGS+8(12,%r15),__LC_SAVE_AREA+16 # store ac. regs
+        mvc     SP_R13(24,%r15),\savearea # move r13, r14 and r15 to stack
         mvc     SP_PSW(16,%r15),\psworg  # move user PSW to stack
-	mvc	SP_ILC(2,%r15),__LC_SVC_ILC # store instruction length
-	mvc	SP_TRAP(2,%r15),.L\psworg-.Lconst(%r14) # store trap ind.
-        xc      0(8,%r15),0(%r15)        # clear back chain
+	st	%r14,SP_ILC(%r15)
+	stg	%r13,0(%r15)
         .endm
 
-        .macro  RESTORE_ALL sync         # system exit macro
+	.macro	CLEANUP_SAVE_ALL psworg,savearea,sync
+	lg	%r1,SP_PSW+8(%r15)
+	cli	1(%r1),0xdf
+	jne	2f
+	mvc	\savearea(24),SP_R13(%r15)
+2:	lg	%r1,\savearea+16
+	.if	\sync
+	tm	\psworg+1,0x01
+	jz	1f
+	lg	%r1,__LC_KERNEL_STACK
+	.else
+	tm	\psworg+1,0x01
+	jnz	0f
+	lg	%r0,__LC_ASYNC_STACK
+	slgr	%r0,%r1
+	srag	%r0,%r0,14
+	jz	1f
+0:	lg	%r1,__LC_ASYNC_STACK
+	.endif
+1:	aghi	%r1,-SP_SIZE
+	stg	%r1,SP_R15(%r15)
+	lghi	%r0,\psworg
+	xc	SP_R13(8,%r15),SP_R13(%r15)
+	icm	%r0,12,__LC_SVC_ILC
+	stg	%r0,SP_R14(%r15)
+	mvc	SP_R0(104,%r1),SP_R0(%r15)
+	mvc	SP_ORIG_R2(8,%r1),SP_R2(%r15)
+	mvc	SP_R13(24,%r1),\savearea
+	mvc	SP_PSW(16,%r1),\psworg
+	st	%r0,SP_ILC(%r1)
+	xc	0(8,%r1),0(%r1)
+	.endm
+
+        .macro  RESTORE_ALL              # system exit macro
         mvc     __LC_RETURN_PSW(16),SP_PSW(%r15) # move user PSW to lowcore
-        lam     %a0,%a15,SP_AREGS(%r15)  # load the access registers
-        lmg     %r0,%r15,SP_R0(%r15)     # load gprs 0-15 of user
         ni      __LC_RETURN_PSW+1,0xfd   # clear wait state bit
+        lmg     %r0,%r15,SP_R0(%r15)     # load gprs 0-15 of user
         lpswe   __LC_RETURN_PSW          # back to caller
         .endm
 
+	.macro	CLEANUP_RESTORE_ALL
+	lg	%r1,SP_PSW+8(%r15)
+	cli	0(%r1),0xb2
+	jne	0f
+	mvc	SP_PSW(16,%r15),__LC_RETURN_PSW
+	j	1f
+0:	lg	%r1,SP_R15(%r15)
+	mvc	SP_PSW(16,%r15),SP_PSW(%r1)
+	mvc	SP_R0(128,%r15),SP_R0(%r1)
+1:
+	.endm
+
         .macro  GET_THREAD_INFO
-	lg	%r9,__LC_KERNEL_STACK    # load pointer to task_struct to %r9
-	aghi	%r9,-16384
+	lg	%r9,__LC_THREAD_INFO     # load pointer to thread_info struct
         .endm
 
+	.macro	CHECK_CRITICAL
+        tm      SP_PSW+1(%r15),0x01      # test problem state bit
+	jnz	0f			 # from user -> not critical
+	larl	%r1,.Lcritical_start
+	clc	SP_PSW+8(8,%r15),8(%r1)  # compare ip with __critical_end
+	jnl	0f
+	clc	SP_PSW+8(8,%r15),0(%r1)  # compare ip with __critical_start
+	jl	0f
+	brasl	%r14,cleanup_critical
+0:
+	.endm
 
 /*
  * Scheduler resume function, called by switch_to
@@ -125,13 +172,10 @@
         stmg    %r6,%r15,48(%r15)       # store __switch_to registers of prev task
 	stg	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	lg	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
-        stam    %a2,%a2,__THREAD_ar2(%r2)	# store kernel access reg. 2
-        stam    %a4,%a4,__THREAD_ar4(%r2)	# store kernel access reg. 4
-        lam     %a2,%a2,__THREAD_ar2(%r3)	# load kernel access reg. 2
-        lam     %a4,%a4,__THREAD_ar4(%r3)	# load kernel access reg. 4
         lmg     %r6,%r15,48(%r15)       # load __switch_to registers of next task
 	stg	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
 	lg	%r3,__THREAD_info(%r3)  # load thread_info from task struct
+	stg	%r3,__LC_THREAD_INFO
 	aghi	%r3,16384
 	stg	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
 	br	%r14
@@ -154,7 +198,8 @@
 	brasl	%r14,do_softirq
 	lmg	%r12,%r15,48(%r12)
 	br	%r14
-	
+
+__critical_start:	
 /*
  * SVC interrupt handler routine. System calls are synchronous events and
  * are executed with interrupts enabled.
@@ -162,14 +207,15 @@
 
 	.globl  system_call
 system_call:
-        SAVE_ALL __LC_SVC_OLD_PSW,1
+        SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
-	stosm   48(%r15),0x03     # reenable interrupts
+sysc_enter:
         GET_THREAD_INFO           # load pointer to task_struct to R9
         slag    %r7,%r7,2         # *4 and test for svc 0
 	jnz	sysc_do_restart
 	# svc 0: system call number in %r1
-	cl	%r1,.Lnr_syscalls-.Lconst(%r14)
+	lghi	%r0,NR_syscalls
+	clr	%r1,%r0
 	jnl	sysc_do_restart
 	lgfr	%r7,%r1           # clear high word in r1
 	slag    %r7,%r7,2         # svc 0: system call number in %r1
@@ -190,19 +236,17 @@
                                   # changing anything here !!
 
 sysc_return:
-	stnsm   48(%r15),0xfc     # disable I/O and ext. interrupts
         tm      SP_PSW+1(%r15),0x01    # returning to user ?
         jno     sysc_leave
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jnz	sysc_work         # there is work to do (signals etc.)
 sysc_leave:
-        RESTORE_ALL 1
+        RESTORE_ALL
 
 #
 # recheck if there is more work to do
 #
 sysc_work_loop:
-	stnsm   48(%r15),0xfc     # disable I/O and ext. interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jz	sysc_leave        # there is no work to do
@@ -223,7 +267,6 @@
 # _TIF_NEED_RESCHED is set, call schedule
 #	
 sysc_reschedule:        
-	stosm   48(%r15),0x03     # reenable interrupts
 	larl    %r14,sysc_work_loop
         jg      schedule            # return point is sysc_return
 
@@ -231,11 +274,9 @@
 # _TIF_SIGPENDING is set, call do_signal
 #
 sysc_sigpending:     
-	stosm   48(%r15),0x03     # reenable interrupts
         la      %r2,SP_PTREGS(%r15) # load pt_regs
         sgr     %r3,%r3           # clear *oldset
 	brasl	%r14,do_signal    # call do_signal
-	stnsm   48(%r15),0xfc     # disable I/O and ext. interrupts
 	tm	__TI_flags+7(%r9),_TIF_RESTART_SVC
 	jo	sysc_restart
 	j	sysc_leave        # out of here, do NOT recheck
@@ -245,13 +286,14 @@
 #
 sysc_restart:
 	ni	__TI_flags+7(%r9),255-_TIF_RESTART_SVC # clear TIF_RESTART_SVC
-	stosm	48(%r15),0x03          # reenable interrupts
 	lg	%r7,SP_R2(%r15)        # load new svc number
         slag    %r7,%r7,2              # *4
 	mvc	SP_R2(8,%r15),SP_ORIG_R2(%r15) # restore first argument
 	lmg	%r2,%r6,SP_R2(%r15)    # load svc arguments
 	j	sysc_do_restart        # restart svc
 
+__critical_end:
+
 #
 # call syscall_trace before and after system call
 # special linkage: %r12 contains the return address for trace_svc
@@ -260,9 +302,9 @@
 	srl	%r7,2
 	stg     %r7,SP_R2(%r15)
         brasl   %r14,syscall_trace
-	larl	%r1,.Lnr_syscalls
-	clc	SP_R2(8,%r15),0(%r1)
-	jnl	sysc_tracenogo
+	lghi	%r0,NR_syscalls
+	clg	%r0,SP_R2(%r15)
+	jnh	sysc_tracenogo
 	lg	%r7,SP_R2(%r15)   # strace might have changed the
 	sll     %r7,2             #  system call
 	lgf	%r8,0(%r7,%r10)
@@ -283,8 +325,9 @@
         .globl  ret_from_fork
 ret_from_fork:  
         GET_THREAD_INFO           # load pointer to task_struct to R9
-	larl    %r14,sysc_return
-        jg      schedule_tail     # return to sysc_return
+        brasl   %r14,schedule_tail
+        stosm   24(%r15),0x03     # reenable interrupts
+	j	sysc_return
 
 #
 # clone, fork, vfork, exec and sigreturn need glue,
@@ -405,21 +448,6 @@
         jg      sys32_sigaltstack_wrapper # branch to sys_sigreturn
 #endif
 
-#define SYSCALL(esa,esame,emu)	.long esame
-	.globl  sys_call_table	
-sys_call_table:
-#include "syscalls.S"
-#undef SYSCALL
-
-#ifdef CONFIG_S390_SUPPORT
-
-#define SYSCALL(esa,esame,emu)	.long emu
-	.globl  sys_call_table_emu
-sys_call_table_emu:
-#include "syscalls.S"
-#undef SYSCALL
-#endif
-
 /*
  * Program check handler routine
  */
@@ -441,7 +469,7 @@
  */
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         jnz     pgm_per                  # got per exception -> special case
-	SAVE_ALL __LC_PGM_OLD_PSW,1
+	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
 	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
 	lghi	%r8,0x7f
 	ngr	%r8,%r3
@@ -469,7 +497,7 @@
 # Normal per exception
 #
 pgm_per_std:
-	SAVE_ALL __LC_PGM_OLD_PSW,1
+	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
 	GET_THREAD_INFO
 	mvc	__THREAD_per+__PER_atmid(2,%r9),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(8,%r9),__LC_PER_ADDRESS
@@ -492,7 +520,7 @@
 # it was a single stepped SVC that is causing all the trouble
 #
 pgm_svcper:
-	SAVE_ALL __LC_SVC_OLD_PSW,1
+	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
 	stosm   48(%r15),0x03     # reenable interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
@@ -502,7 +530,8 @@
 	slag	%r7,%r7,2         # *4 and test for svc 0
 	jnz	pgm_svcstd
 	# svc 0: system call number in %r1
-	clg	%r1,.Lnr_syscalls-.Lconst(%r14)
+	lghi	%r0,NR_syscalls
+	clr	%r1,%r0
 	slag	%r7,%r1,2
 pgm_svcstd:
 	larl    %r10,sys_call_table
@@ -540,8 +569,9 @@
 	srlg	%r7,%r7,2
 	stg	%r7,SP_R2(%r15)
         brasl   %r14,syscall_trace
-	clc	SP_R2(8,%r15),.Lnr_syscalls
-	jnl     pgm_svc_nogo
+	lghi	%r0,NR_syscalls
+	clg	%r0,SP_R2(%r15)
+	jnh	pgm_svc_nogo
 	lg      %r7,SP_R2(%r15)
 	sllg    %r7,%r7,2           # strace wants to change the syscall
 	lgf	%r8,0(%r7,%r10)
@@ -561,9 +591,10 @@
  */
         .globl io_int_handler
 io_int_handler:
-        SAVE_ALL __LC_IO_OLD_PSW,0
-        GET_THREAD_INFO                # load pointer to task_struct to R9
+        SAVE_ALL __LC_IO_OLD_PSW,__LC_SAVE_AREA+32,0
 	stck	__LC_INT_CLOCK
+	CHECK_CRITICAL
+        GET_THREAD_INFO                # load pointer to task_struct to R9
         la      %r2,SP_PTREGS(%r15)    # address of register-save area
 	brasl   %r14,do_IRQ            # call standard irq handler
 
@@ -577,25 +608,23 @@
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
 	jnz	io_work                # there is work to do (signals etc.)
 io_leave:
-        RESTORE_ALL 0
+        RESTORE_ALL
 
 #ifdef CONFIG_PREEMPT
 io_preempt:
 	icm	%r0,15,__TI_precount(%r9)	
 	jnz     io_leave
+	# switch to kernel stack
+	lg	%r1,SP_R15(%r15)
+	aghi	%r1,-SP_SIZE
+	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
+        xc      0(8,%r1),0(%r1)        # clear back chain
+	lgr	%r15,%r1
 io_resume_loop:
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jno	io_leave
 	larl    %r1,.Lc_pactive
 	mvc     __TI_precount(4,%r9),0(%r1)
-	# hmpf, we are on the async. stack but to call schedule
-	# we have to move the interrupt frame to the process stack
-	lg	%r1,SP_R15(%r15)
-	aghi	%r1,-SP_SIZE
-	nill	%r1,0xfff8
-	mvc	SP_PTREGS(SP_SIZE-SP_PTREGS,%r1),SP_PTREGS(%r15)
-        xc      0(8,%r1),0(%r1)        # clear back chain
-	lgr	%r15,%r1
         stosm   48(%r15),0x03          # reenable interrupts
 	brasl   %r14,schedule          # call schedule
         stnsm   48(%r15),0xfc          # disable I/O and ext. interrupts
@@ -605,18 +634,19 @@
 #endif
 
 #
-# recheck if there is more work to do
+# switch to kernel stack, then check TIF bits
 #
-io_work_loop:
-        stnsm   48(%r15),0xfc          # disable I/O and ext. interrupts
-        GET_THREAD_INFO                # load pointer to task_struct to R9
-	tm	__TI_flags+7(%r9),_TIF_WORK_INT
-	jz	io_leave               # there is no work to do
+io_work:
+	lg	%r1,__LC_KERNEL_STACK
+	aghi	%r1,-SP_SIZE
+	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
+        xc      0(8,%r1),0(%r1)        # clear back chain
+	lgr	%r15,%r1
 #
 # One of the work bits is on. Find out which one.
 # Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
 #
-io_work:
+io_work_loop:
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jo	io_reschedule
 	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
@@ -628,8 +658,12 @@
 #	
 io_reschedule:        
         stosm   48(%r15),0x03       # reenable interrupts
-	larl    %r14,io_work_loop
-        jg      schedule            # call scheduler
+        brasl   %r14,schedule       # call scheduler
+        stnsm   48(%r15),0xfc       # disable I/O and ext. interrupts
+        GET_THREAD_INFO             # load pointer to task_struct to R9
+	tm	__TI_flags+7(%r9),_TIF_WORK_INT
+	jz	io_leave               # there is no work to do
+	j	io_work_loop
 
 #
 # _TIF_SIGPENDING is set, call do_signal
@@ -647,7 +681,8 @@
  */
         .globl  ext_int_handler
 ext_int_handler:
-        SAVE_ALL __LC_EXT_OLD_PSW,0
+        SAVE_ALL __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32,0
+	CHECK_CRITICAL
         GET_THREAD_INFO                # load pointer to task_struct to R9
 	stck	__LC_INT_CLOCK
 	la	%r2,SP_PTREGS(%r15)    # address of register-save area
@@ -660,10 +695,10 @@
  */
         .globl mcck_int_handler
 mcck_int_handler:
-        SAVE_ALL __LC_MCK_OLD_PSW,0
+        SAVE_ALL __LC_MCK_OLD_PSW,__LC_SAVE_AREA+64,0
 	brasl   %r14,s390_do_machine_check
 mcck_return:
-        RESTORE_ALL 0
+        RESTORE_ALL
 
 #ifdef CONFIG_SMP
 /*
@@ -694,16 +729,69 @@
 restart_go:
 #endif
 
+cleanup_table:
+	.quad	system_call, sysc_enter, cleanup_sysc_enter
+	.quad	sysc_return, sysc_leave, cleanup_sysc_return
+	.quad	sysc_leave, sysc_work_loop, cleanup_sysc_leave
+	.quad	sysc_work_loop, sysc_reschedule, cleanup_sysc_return
+cleanup_table_entries=(.-cleanup_table) / 24
+
+cleanup_critical:
+	lghi	%r0,cleanup_table_entries
+	larl	%r1,cleanup_table
+	lg	%r2,SP_PSW+8(%r15)
+cleanup_loop:
+	clg	%r2,0(%r1)
+	jl	cleanup_cont
+	clg	%r2,8(%r1)
+	jl	cleanup_found
+cleanup_cont:
+	la	%r1,24(%r1)
+	brct	%r0,cleanup_loop
+	br	%r14
+cleanup_found:
+	lg	%r1,16(%r1)
+	br	%r1
+
+cleanup_sysc_enter:
+	CLEANUP_SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	llgh	%r0,0x8a
+	stg	%r0,SP_R7(%r15)
+	larl	%r1,sysc_enter
+	stg	%r1,SP_PSW+8(%r15)
+	br	%r14
+
+cleanup_sysc_return:
+	larl	%r1,sysc_return
+	stg	%r1,SP_PSW+8(%r15)
+	br	%r14
+
+cleanup_sysc_leave:
+	CLEANUP_RESTORE_ALL
+	br	%r14
+
 /*
  * Integer constants
  */
                .align 4
 .Lconst:
-.Lc_ac:        .long  0,0,1
 .Lc_pactive:   .long  PREEMPT_ACTIVE
-.L0x0130:      .word  0x0130
-.L0x0140:      .word  0x0140
-.L0x0150:      .word  0x0150
-.L0x0160:      .word  0x0160
-.L0x0170:      .word  0x0170
-.Lnr_syscalls: .long  NR_syscalls
+.Lcritical_start:
+               .quad  __critical_start
+.Lcritical_end:
+               .quad  __critical_end
+
+#define SYSCALL(esa,esame,emu)	.long esame
+	.globl  sys_call_table	
+sys_call_table:
+#include "syscalls.S"
+#undef SYSCALL
+
+#ifdef CONFIG_S390_SUPPORT
+
+#define SYSCALL(esa,esame,emu)	.long emu
+	.globl  sys_call_table_emu
+sys_call_table_emu:
+#include "syscalls.S"
+#undef SYSCALL
+#endif
diff -urN linux-2.6/arch/s390/kernel/process.c linux-2.6-s390/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	Fri Mar 26 18:25:13 2004
+++ linux-2.6-s390/arch/s390/kernel/process.c	Fri Mar 26 18:25:59 2004
@@ -179,7 +179,7 @@
 	memset(&regs, 0, sizeof(regs));
 	regs.psw.mask = PSW_KERNEL_BITS;
 	regs.psw.addr = (unsigned long) kernel_thread_starter | PSW_ADDR_AMODE;
-	regs.gprs[7] = STACK_FRAME_OVERHEAD;
+	regs.gprs[7] = STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
 	regs.gprs[8] = __LC_KERNEL_STACK;
 	regs.gprs[9] = (unsigned long) fn;
 	regs.gprs[10] = (unsigned long) arg;
@@ -230,6 +230,7 @@
 		 (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
         p->thread.ksp = (unsigned long) frame;
 	p->set_child_tid = p->clear_child_tid = NULL;
+	/* Store access registers to kernel stack of new process. */
         frame->childregs = *regs;
 	frame->childregs.gprs[2] = 0;	/* child returns 0 on fork. */
         frame->childregs.gprs[15] = new_stackp;
@@ -240,6 +241,10 @@
 
         /* fake return stack for resume(), don't go back to schedule */
         frame->gprs[9] = (unsigned long) frame;
+
+	/* Save access registers to new thread structure. */
+	save_access_regs(&p->thread.acrs[0]);
+
 #ifndef CONFIG_ARCH_S390X
         /*
 	 * save fprs to current->thread.fp_regs to merge them with
@@ -251,7 +256,7 @@
         p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _SEGMENT_TABLE;
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS)
-		frame->childregs.acrs[0] = regs->gprs[6];
+		p->thread.acrs[0] = regs->gprs[6];
 #else /* CONFIG_ARCH_S390X */
 	/* Save the fpu registers to new thread structure. */
 	save_fp_regs(&p->thread.fp_regs);
@@ -259,18 +264,15 @@
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS) {
 		if (test_thread_flag(TIF_31BIT)) {
-			frame->childregs.acrs[0] =
-				(unsigned int) regs->gprs[6];
+			p->thread.acrs[0] = (unsigned int) regs->gprs[6];
 		} else {
-			frame->childregs.acrs[0] =
-				(unsigned int)(regs->gprs[6] >> 32);
-			frame->childregs.acrs[1] =
-				(unsigned int) regs->gprs[6];
+			p->thread.acrs[0] = (unsigned int)(regs->gprs[6] >> 32);
+			p->thread.acrs[1] = (unsigned int) regs->gprs[6];
 		}
 	}
 #endif /* CONFIG_ARCH_S390X */
 	/* start new process with ar4 pointing to the correct address space */
-	p->thread.ar4 = get_fs().ar4;
+	p->thread.mm_segment = get_fs();
         /* Don't copy debug registers */
         memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
 
diff -urN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-s390/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	Fri Mar 26 18:25:13 2004
+++ linux-2.6-s390/arch/s390/kernel/ptrace.c	Fri Mar 26 18:25:59 2004
@@ -137,25 +137,36 @@
 	if ((addr & 3) || addr > sizeof(struct user) - __ADDR_MASK)
 		return -EIO;
 
-	if (addr <= (addr_t) &dummy->regs.orig_gpr2) {
+	if (addr < (addr_t) &dummy->regs.acrs) {
 		/*
-		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 * psw and gprs are stored on the stack
 		 */
 		tmp = *(addr_t *)((addr_t) __KSTK_PTREGS(child) + addr);
 		if (addr == (addr_t) &dummy->regs.psw.mask)
 			/* Remove per bit from user psw. */
 			tmp &= ~PSW_MASK_PER;
 
-	} else if (addr >= (addr_t) &dummy->regs.fp_regs &&
-		   addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
+	} else if (addr < (addr_t) &dummy->regs.orig_gpr2) {
+		/*
+		 * access registers are stored in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy->regs.acrs;
+		tmp = *(addr_t *)((addr_t) &child->thread.acrs + offset);
+
+	} else if (addr == (addr_t) &dummy->regs.orig_gpr2) {
+		/*
+		 * orig_gpr2 is stored on the kernel stack
+		 */
+		tmp = (addr_t) __KSTK_PTREGS(child)->orig_gpr2;
+
+	} else if (addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
 		/* 
 		 * floating point regs. are stored in the thread structure
 		 */
 		offset = addr - (addr_t) &dummy->regs.fp_regs;
 		tmp = *(addr_t *)((addr_t) &child->thread.fp_regs + offset);
 
-	} else if (addr >= (addr_t) &dummy->regs.per_info &&
-		   addr < (addr_t) (&dummy->regs.per_info + 1)) {
+	} else if (addr < (addr_t) (&dummy->regs.per_info + 1)) {
 		/*
 		 * per_info is found in the thread structure
 		 */
@@ -187,9 +198,9 @@
 	if ((addr & 3) || addr > sizeof(struct user) - __ADDR_MASK)
 		return -EIO;
 
-	if (addr <= (addr_t) &dummy->regs.orig_gpr2) {
+	if (addr < (addr_t) &dummy->regs.acrs) {
 		/*
-		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 * psw and gprs are stored on the stack
 		 */
 		if (addr == (addr_t) &dummy->regs.psw.mask &&
 #ifdef CONFIG_S390_SUPPORT
@@ -206,8 +217,20 @@
 #endif
 		*(addr_t *)((addr_t) __KSTK_PTREGS(child) + addr) = data;
 
-	} else if (addr >= (addr_t) &dummy->regs.fp_regs &&
-		   addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
+	} else if (addr < (addr_t) (&dummy->regs.orig_gpr2)) {
+		/*
+		 * access registers are stored in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy->regs.acrs;
+		*(addr_t *)((addr_t) &child->thread.acrs + offset) = data;
+
+	} else if (addr == (addr_t) &dummy->regs.orig_gpr2) {
+		/*
+		 * orig_gpr2 is stored on the kernel stack
+		 */
+		__KSTK_PTREGS(child)->orig_gpr2 = data;
+
+	} else if (addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure
 		 */
@@ -217,8 +240,7 @@
 		offset = addr - (addr_t) &dummy->regs.fp_regs;
 		*(addr_t *)((addr_t) &child->thread.fp_regs + offset) = data;
 
-	} else if (addr >= (addr_t) &dummy->regs.per_info &&
-		   addr < (addr_t) (&dummy->regs.per_info + 1)) {
+	} else if (addr < (addr_t) (&dummy->regs.per_info + 1)) {
 		/*
 		 * per_info is found in the thread structure 
 		 */
@@ -324,9 +346,9 @@
 	    (addr & 3) || addr > sizeof(struct user) - 3)
 		return -EIO;
 
-	if (addr <= (addr_t) &dummy32->regs.orig_gpr2) {
+	if (addr < (addr_t) &dummy32->regs.acrs) {
 		/*
-		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 * psw and gprs are stored on the stack
 		 */
 		if (addr == (addr_t) &dummy32->regs.psw.mask) {
 			/* Fake a 31 bit psw mask. */
@@ -336,28 +358,32 @@
 			/* Fake a 31 bit psw address. */
 			tmp = (__u32) __KSTK_PTREGS(child)->psw.addr |
 				PSW32_ADDR_AMODE31;
-		} else if (addr < (addr_t) &dummy32->regs.acrs[0]) {
+		} else {
 			/* gpr 0-15 */
 			tmp = *(__u32 *)((addr_t) __KSTK_PTREGS(child) + 
 					 addr*2 + 4);
-		} else if (addr < (addr_t) &dummy32->regs.orig_gpr2) {
-			offset = PT_ACR0 + addr - (addr_t) &dummy32->regs.acrs;
-			tmp = *(__u32*)((addr_t) __KSTK_PTREGS(child) + offset);
-		} else {
-			/* orig gpr 2 */
-			offset = PT_ORIGGPR2 + 4;
-			tmp = *(__u32*)((addr_t) __KSTK_PTREGS(child) + offset);
 		}
-	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
-		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
+	} else if (addr < (addr_t) (&dummy32->regs.orig_gpr2)) {
+		/*
+		 * access registers are stored in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy32->regs.acrs;
+		tmp = *(__u32*)((addr_t) &child->thread.acrs + offset);
+		
+	} else if (addr == (addr_t) (&dummy32->regs.orig_gpr2)) {
+		/*
+		 * orig_gpr2 is stored on the kernel stack
+		 */
+		tmp = *(__u32*)((addr_t) &__KSTK_PTREGS(child)->orig_gpr2 + 4);
+
+	} else if (addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure 
 		 */
 	        offset = addr - (addr_t) &dummy32->regs.fp_regs;
 		tmp = *(__u32 *)((addr_t) &child->thread.fp_regs + offset);
 
-	} else if (addr >= (addr_t) &dummy32->regs.per_info &&
-		   addr < (addr_t) (&dummy32->regs.per_info + 1)) {
+	} else if (addr < (addr_t) (&dummy32->regs.per_info + 1)) {
 		/*
 		 * per_info is found in the thread structure
 		 */
@@ -396,7 +422,7 @@
 
 	tmp = (__u32) data;
 
-	if (addr <= (addr_t) &dummy32->regs.orig_gpr2) {
+	if (addr < (addr_t) &dummy32->regs.acrs) {
 		/*
 		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
 		 */
@@ -411,19 +437,25 @@
 			/* Build a 64 bit psw address from 31 bit address. */
 			__KSTK_PTREGS(child)->psw.addr = 
 				(__u64) tmp & PSW32_ADDR_INSN;
-		} else if (addr < (addr_t) &dummy32->regs.acrs[0]) {
+		} else {
 			/* gpr 0-15 */
 			*(__u32*)((addr_t) __KSTK_PTREGS(child) + addr*2 + 4) =
 				tmp;
-		} else if (addr < (addr_t) &dummy32->regs.orig_gpr2) {
-			offset = PT_ACR0 + addr - (addr_t) &dummy32->regs.acrs;
-			*(__u32*)((addr_t) __KSTK_PTREGS(child) + offset) = tmp;
-		} else {
-			offset = PT_ORIGGPR2 + 4;
-			*(__u32*)((addr_t) __KSTK_PTREGS(child) + offset) = tmp;
 		}
-	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
-		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
+	} else if (addr < (addr_t) (&dummy32->regs.orig_gpr2)) {
+		/*
+		 * access registers are stored in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy32->regs.acrs;
+		*(__u32*)((addr_t) &child->thread.acrs + offset) = tmp;
+
+	} else if (addr == (addr_t) (&dummy32->regs.orig_gpr2)) {
+		/*
+		 * orig_gpr2 is stored on the kernel stack
+		 */
+		*(__u32*)((addr_t) &__KSTK_PTREGS(child)->orig_gpr2 + 4) = tmp;
+
+	} else if (addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure 
 		 */
@@ -434,8 +466,7 @@
 	        offset = addr - (addr_t) &dummy32->regs.fp_regs;
 		*(__u32 *)((addr_t) &child->thread.fp_regs + offset) = tmp;
 
-	} else if (addr >= (addr_t) &dummy32->regs.per_info &&
-		   addr < (addr_t) (&dummy32->regs.per_info + 1)) {
+	} else if (addr < (addr_t) (&dummy32->regs.per_info + 1)) {
 		/*
 		 * per_info is found in the thread structure.
 		 */
diff -urN linux-2.6/arch/s390/kernel/s390_ksyms.c linux-2.6-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.6/arch/s390/kernel/s390_ksyms.c	Thu Mar 11 03:55:34 2004
+++ linux-2.6-s390/arch/s390/kernel/s390_ksyms.c	Fri Mar 26 18:25:59 2004
@@ -33,6 +33,8 @@
 EXPORT_SYMBOL_NOVERS(__copy_from_user_asm);
 EXPORT_SYMBOL_NOVERS(__copy_to_user_asm);
 EXPORT_SYMBOL_NOVERS(__clear_user_asm);
+EXPORT_SYMBOL_NOVERS(__strncpy_from_user_asm);
+EXPORT_SYMBOL_NOVERS(__strnlen_user_asm);
 EXPORT_SYMBOL(diag10);
 
 /*
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Fri Mar 26 18:25:13 2004
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Fri Mar 26 18:25:59 2004
@@ -496,7 +496,7 @@
 	lc->external_new_psw.mask = PSW_KERNEL_BITS;
 	lc->external_new_psw.addr =
 		PSW_ADDR_AMODE | (unsigned long) ext_int_handler;
-	lc->svc_new_psw.mask = PSW_KERNEL_BITS;
+	lc->svc_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_IO | PSW_MASK_EXT;
 	lc->svc_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) system_call;
 	lc->program_new_psw.mask = PSW_KERNEL_BITS;
 	lc->program_new_psw.addr =
@@ -512,6 +512,7 @@
 	lc->async_stack = (unsigned long)
 		__alloc_bootmem(ASYNC_SIZE, ASYNC_SIZE, 0) + ASYNC_SIZE;
 	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
+	lc->thread_info = (unsigned long) &init_thread_union;
 #ifdef CONFIG_ARCH_S390X
 	if (MACHINE_HAS_DIAG44)
 		lc->diag44_opcode = 0x83000044;
diff -urN linux-2.6/arch/s390/kernel/signal.c linux-2.6-s390/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/signal.c	Fri Mar 26 18:25:59 2004
@@ -151,13 +151,20 @@
 	unsigned long old_mask = regs->psw.mask;
 	int err;
   
+	save_access_regs(current->thread.acrs);
+
 	/* Copy a 'clean' PSW mask to the user to avoid leaking
 	   information about whether PER is currently on.  */
 	regs->psw.mask = PSW_MASK_MERGE(PSW_USER_BITS, regs->psw.mask);
-	err = __copy_to_user(&sregs->regs, regs, sizeof(_s390_regs_common));
+	err = __copy_to_user(&sregs->regs.psw, &regs->psw,
+			     sizeof(sregs->regs.psw)+sizeof(sregs->regs.gprs));
 	regs->psw.mask = old_mask;
 	if (err != 0)
 		return err;
+	err = __copy_to_user(&sregs->regs.acrs, current->thread.acrs,
+			     sizeof(sregs->regs.acrs));
+	if (err != 0)
+		return err;
 	/* 
 	 * We have to store the fp registers to current->thread.fp_regs
 	 * to merge them with the emulated registers.
@@ -176,11 +183,17 @@
 	/* Alwys make any pending restarted system call return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
-	err = __copy_from_user(regs, &sregs->regs, sizeof(_s390_regs_common));
+	err = __copy_from_user(&regs->psw, &sregs->regs.psw,
+			       sizeof(sregs->regs.psw)+sizeof(sregs->regs.gprs));
 	regs->psw.mask = PSW_MASK_MERGE(old_mask, regs->psw.mask);
 	regs->psw.addr |= PSW_ADDR_AMODE;
 	if (err)
 		return err;
+	err = __copy_from_user(&current->thread.acrs, &sregs->regs.acrs,
+			       sizeof(sregs->regs.acrs));
+	if (err)
+		return err;
+	restore_access_regs(current->thread.acrs);
 
 	err = __copy_from_user(&current->thread.fp_regs, &sregs->fpregs,
 			       sizeof(s390_fp_regs));
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Fri Mar 26 18:25:59 2004
@@ -173,6 +173,10 @@
 	printk("           " FOURLONG,
 	       regs->gprs[12], regs->gprs[13], regs->gprs[14], regs->gprs[15]);
 
+#if 0
+	/* FIXME: this isn't needed any more but it changes the ksymoops
+	 * input. To remove or not to remove ... */
+	save_access_regs(regs->acrs);
 	printk("%s ACRS: %08x %08x %08x %08x\n", mode,
 	       regs->acrs[0], regs->acrs[1], regs->acrs[2], regs->acrs[3]);
 	printk("           %08x %08x %08x %08x\n",
@@ -181,6 +185,7 @@
 	       regs->acrs[8], regs->acrs[9], regs->acrs[10], regs->acrs[11]);
 	printk("           %08x %08x %08x %08x\n",
 	       regs->acrs[12], regs->acrs[13], regs->acrs[14], regs->acrs[15]);
+#endif
 
 	/*
 	 * Print the first 20 byte of the instruction stream at the
@@ -229,17 +234,17 @@
 			  regs->gprs[12], regs->gprs[13],
 			  regs->gprs[14], regs->gprs[15]);
 	buffer += sprintf(buffer, "User ACRS: %08x %08x %08x %08x\n",
-			  regs->acrs[0], regs->acrs[1],
-			  regs->acrs[2], regs->acrs[3]);
+			  task->thread.acrs[0], task->thread.acrs[1],
+			  task->thread.acrs[2], task->thread.acrs[3]);
 	buffer += sprintf(buffer, "           %08x %08x %08x %08x\n",
-			  regs->acrs[4], regs->acrs[5],
-			  regs->acrs[6], regs->acrs[7]);
+			  task->thread.acrs[4], task->thread.acrs[5],
+			  task->thread.acrs[6], task->thread.acrs[7]);
 	buffer += sprintf(buffer, "           %08x %08x %08x %08x\n",
-			  regs->acrs[8], regs->acrs[9],
-			  regs->acrs[10], regs->acrs[11]);
+			  task->thread.acrs[8], task->thread.acrs[9],
+			  task->thread.acrs[10], task->thread.acrs[11]);
 	buffer += sprintf(buffer, "           %08x %08x %08x %08x\n",
-			  regs->acrs[12], regs->acrs[13],
-			  regs->acrs[14], regs->acrs[15]);
+			  task->thread.acrs[12], task->thread.acrs[13],
+			  task->thread.acrs[14], task->thread.acrs[15]);
 	return buffer;
 }
 
diff -urN linux-2.6/arch/s390/lib/uaccess.S linux-2.6-s390/arch/s390/lib/uaccess.S
--- linux-2.6/arch/s390/lib/uaccess.S	Thu Mar 11 03:55:36 2004
+++ linux-2.6-s390/arch/s390/lib/uaccess.S	Fri Mar 26 18:25:59 2004
@@ -9,135 +9,191 @@
  *  These functions have standard call interface
  */
 
+#include <linux/errno.h>
 #include <asm/lowcore.h>
+#include <asm/offsets.h>
 
         .text
         .align 4
         .globl __copy_from_user_asm
+	# %r2 = to, %r3 = n, %r4 = from
 __copy_from_user_asm:
-	lr	%r5,%r3
-	sacf	512
-0:	mvcle	%r2,%r4,0
-	jo	0b
-1:	sacf	0
-	lr	%r2,%r5
-	br	%r14
-2:	lhi	%r1,-4096
-	lr	%r3,%r4
-	slr	%r3,%r1      # %r3 = %r4 + 4096
-	nr	%r3,%r1      # %r3 = (%r4 + 4096) & -4096
-	slr	%r3,%r4      # %r3 = #bytes to next user page boundary
-	clr	%r5,%r3      # copy crosses next page boundary ?
-	jnh	1b           # no, this page fauled
-	# The page after the current user page might have faulted.
-	# We cant't find out which page because the program check handler
-	# might have callled schedule, destroying all lowcore information.
-	# We retry with the shortened length.
-3:	mvcle	%r2,%r4,0
-	jo	3b
-	j	1b
+	slr	%r0,%r0
+0:	mvcp	0(%r3,%r2),0(%r4),%r0
+	jnz	1f
+	slr	%r2,%r2
+	br	%r14
+1:	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+	ahi	%r3,-256
+2:	mvcp	0(%r3,%r2),0(%r4),%r0
+	jnz	1b
+3:	slr	%r2,%r2
+	br	%r14
+4:	lhi	%r0,-4096
+	lr	%r5,%r4
+	slr	%r5,%r0
+	nr	%r5,%r0		# %r5 = (%r4 + 4096) & -4096
+	slr	%r5,%r4		# %r5 = #bytes to next user page boundary
+	clr	%r3,%r5		# copy crosses next page boundary ?
+	jnh	6f		# no, the current page faulted
+	# move with the reduced length which is < 256
+5:	mvcp	0(%r5,%r2),0(%r4),%r0
+	slr	%r3,%r5
+6:	lr	%r2,%r3
+	br	%r14
         .section __ex_table,"a"
-	.long	0b,2b
-	.long	3b,1b
+	.long	0b,4b
+	.long	2b,4b
+	.long	5b,6b
         .previous
 
         .align 4
         .text
         .globl __copy_to_user_asm
+	# %r2 = from, %r3 = n, %r4 = to
 __copy_to_user_asm:
-	lr	%r5,%r3
-	sacf	512
-0:	mvcle	%r4,%r2,0
-	jo	0b
-1:	sacf	0
-	lr	%r2,%r3
+	slr	%r0,%r0
+0:	mvcs	0(%r3,%r4),0(%r2),%r0
+	jnz	1f
+	slr	%r2,%r2
+	br	%r14
+1:	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+	ahi	%r3,-256
+2:	mvcs	0(%r3,%r4),0(%r2),%r0
+	jnz	1b
+3:	slr	%r2,%r2
 	br	%r14
-2:	lhi	%r1,-4096
+4:	lhi	%r0,-4096
 	lr	%r5,%r4
-	slr	%r5,%r1      # %r5 = %r4 + 4096
-	nr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
-	slr	%r5,%r4      # %r5 = #bytes to next user page boundary
-	clr	%r3,%r5      # copy crosses next page boundary ?
-	jnh	1b           # no, the current page fauled
-	# The page after the current user page might have faulted.
-	# We cant't find out which page because the program check handler
-	# might have callled schedule, destroying all lowcore information.
-	# We retry with the shortened length.
-3:	mvcle	%r4,%r2,0
-	jo	3b
-	j	1b
+	slr	%r5,%r0
+	nr	%r5,%r0		# %r5 = (%r4 + 4096) & -4096
+	slr	%r5,%r4		# %r5 = #bytes to next user page boundary
+	clr	%r3,%r5		# copy crosses next page boundary ?
+	jnh	6f		# no, the current page faulted
+	# move with the reduced length which is < 256
+5:	mvcs	0(%r5,%r4),0(%r2),%r0
+	slr	%r3,%r5
+6:	lr	%r2,%r3
+	br	%r14
         .section __ex_table,"a"
-	.long	0b,2b
-	.long	3b,1b
+	.long	0b,4b
+	.long	2b,4b
+	.long	5b,6b
         .previous
 
         .align 4
         .text
         .globl __copy_in_user_asm
+	# %r2 = from, %r3 = n, %r4 = to
 __copy_in_user_asm:
-	stm	%r6,%r15,24(%r15)
-	lr	%r5,%r3
-	lr	%r7,%r3
-	lr	%r6,%r2
-	cpya	6,4          # ar6 = ar4
-	sacf	512
-0:	mvcle	%r4,%r6,0
-	jo	0b
-1:	sacf	0
-	lr	%r2,%r7
-	lm	%r6,%r15,24(%r15)
+	sacf	256
+	bras	1,1f
+	mvc	0(1,%r4),0(%r2)
+0:	mvc	0(256,%r4),0(%r2)
+	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+1:	ahi	%r3,-256
+	jnm	0b
+2:	ex	%r3,0(%r1)
+	sacf	0
+	slr	%r2,%r2
+	br	14
+3:	mvc	0(1,%r4),0(%r2)
+	la	%r2,1(%r2)
+	la	%r4,1(%r4)
+	ahi	%r3,-1
+	jnm	3b
+4:	lr	%r2,%r3
+	sacf	0
 	br	%r14
-2:	lhi	%r1,-4096
-	lr	%r5,%r4
-	slr	%r5,%r1      # %r5 = %r4 + 4096
-	nr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
-	slr	%r5,%r4      # %r5 = #bytes to next user page boundary
-	clr	%r7,%r5      # copy crosses next page boundary ?
-	jnh	1b           # no, the current page fauled
-	# The page after the current user page might have faulted.
-	# We cant't find out which page because the program check handler
-	# might have callled schedule, destroying all lowcore information.
-	# We retry with the shortened length.
-3:	mvcle	%r4,%r6,0
-	jo	3b
-	j	1b
         .section __ex_table,"a"
-	.long	0b,2b
-	.long	3b,1b
+	.long	0b,3b
+	.long	2b,3b
+	.long	3b,4b
         .previous
-
+	
         .align 4
         .text
         .globl __clear_user_asm
+	# %r2 = to, %r3 = n
 __clear_user_asm:
+	bras	%r5,0f
+	.long	empty_zero_page
+0:	l	%r5,0(%r5)
+	slr	%r0,%r0
+1:	mvcs	0(%r3,%r2),0(%r5),%r0
+	jnz	2f
+	slr	%r2,%r2
+	br	%r14
+2:	la	%r2,256(%r2)
+	ahi	%r3,-256
+3:	mvcs	0(%r3,%r2),0(%r5),%r0
+	jnz	2b
+4:	slr	%r2,%r2
+	br	%r14
+5:	lhi	%r0,-4096
 	lr	%r4,%r2
-	lr	%r5,%r3
-	sr	%r2,%r2
-	sr	%r3,%r3
-	sacf	512
-0:	mvcle	%r4,%r2,0
-	jo	0b
-1:	sacf	0
-	br	%r14
-2:	lr	%r2,%r5
-	lhi	%r1,-4096
-	slr	%r5,%r1      # %r5 = %r4 + 4096
-	nr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
-	slr	%r5,%r4      # %r5 = #bytes to next user page boundary
-	clr	%r2,%r5      # copy crosses next page boundary ?
-	jnh	1b           # no, the current page fauled
-	# The page after the current user page might have faulted.
-	# We cant't find out which page because the program check handler
-	# might have callled schedule, destroying all lowcore information.
-	# We retry with the shortened length.
-	slr	%r2,%r5
-3:	mvcle	%r4,%r2,0
-	jo	3b
-	j	1b
-4:	alr	%r2,%r5
-	j	1b
+	slr	%r4,%r0
+	nr	%r4,%r0		# %r4 = (%r2 + 4096) & -4096
+	slr	%r4,%r2		# %r4 = #bytes to next user page boundary
+	clr	%r3,%r4		# clear crosses next page boundary ?
+	jnh	7f		# no, the current page faulted
+	# clear with the reduced length which is < 256
+6:	mvcs	0(%r4,%r2),0(%r5),%r0
+	slr	%r3,%r4
+7:	lr	%r2,%r3
+	br	%r14
         .section __ex_table,"a"
-	.long	0b,2b
-        .long	3b,4b
+	.long	1b,5b
+	.long	3b,5b
+	.long	6b,7b
         .previous
 
+        .align 4
+        .text
+        .globl __strncpy_from_user_asm
+	# %r2 = dst, %r3 = src, %r4 = count
+__strncpy_from_user_asm:
+	lhi	%r0,0
+	lhi	%r1,1
+	lhi	%r5,0
+0:	mvcp	0(%r1,%r2),0(%r3),%r0
+	tm	0(%r2),0xff
+	jz	1f
+	la	%r2,1(%r2)
+	la	%r3,1(%r3)
+	ahi	%r5,1
+	clr	%r5,%r4
+	jl	0b
+1:	lr	%r2,%r5
+	br	%r14
+2:	lhi	%r2,-EFAULT
+	br	%r14
+        .section __ex_table,"a"
+	.long	0b,2b
+	.previous
+	
+        .align 4
+        .text
+        .globl __strnlen_user_asm
+	# %r2 = src, %r3 = count
+__strnlen_user_asm:
+	lhi	%r0,0
+	lhi	%r1,1
+	lhi	%r5,0
+0:	mvcp	24(%r1,%r15),0(%r2),%r0
+	ahi	%r5,1
+	tm	24(%r15),0xff
+	jz	1f
+	la	%r2,1(%r2)
+	clr	%r5,%r3
+	jl	0b
+1:	lr	%r2,%r5
+	br	%r14
+2:	lhi	%r2,-EFAULT
+	br	%r14
+        .section __ex_table,"a"
+	.long	0b,2b
+	.previous
diff -urN linux-2.6/arch/s390/lib/uaccess64.S linux-2.6-s390/arch/s390/lib/uaccess64.S
--- linux-2.6/arch/s390/lib/uaccess64.S	Thu Mar 11 03:55:43 2004
+++ linux-2.6-s390/arch/s390/lib/uaccess64.S	Fri Mar 26 18:25:59 2004
@@ -9,134 +9,189 @@
  *  These functions have standard call interface
  */
 
+#include <linux/errno.h>
 #include <asm/lowcore.h>
+#include <asm/offsets.h>
 
         .text
         .align 4
         .globl __copy_from_user_asm
+	# %r2 = to, %r3 = n, %r4 = from
 __copy_from_user_asm:
-	lgr	%r5,%r3
-	sacf	512
-0:	mvcle	%r2,%r4,0
-	jo	0b
-1:	sacf	0
-	lgr	%r2,%r5
-	br	%r14
-2:	lghi	%r1,-4096
-	lgr	%r3,%r4
-	slgr	%r3,%r1      # %r3 = %r4 + 4096
-	ngr	%r3,%r1      # %r3 = (%r4 + 4096) & -4096
-	slgr	%r3,%r4      # %r3 = #bytes to next user page boundary
-	clgr	%r5,%r3      # copy crosses next page boundary ?
-	jnh	1b           # no, this page fauled
-	# The page after the current user page might have faulted.
-	# We cant't find out which page because the program check handler
-	# might have callled schedule, destroying all lowcore information.
-	# We retry with the shortened length.
-3:	mvcle	%r2,%r4,0
-	jo	3b
-	j	1b
+	slgr	%r0,%r0
+0:	mvcp	0(%r3,%r2),0(%r4),%r0
+	jnz	1f
+	slgr	%r2,%r2
+	br	%r14
+1:	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+	aghi	%r3,-256
+2:	mvcp	0(%r3,%r2),0(%r4),%r0
+	jnz	1b
+3:	slgr	%r2,%r2
+	br	%r14
+4:	lghi	%r0,-4096
+	lgr	%r5,%r4
+	slgr	%r5,%r0
+	ngr	%r5,%r0		# %r5 = (%r4 + 4096) & -4096
+	slgr	%r5,%r4		# %r5 = #bytes to next user page boundary
+	clgr	%r3,%r5		# copy crosses next page boundary ?
+	jnh	6f		# no, the current page faulted
+	# move with the reduced length which is < 256
+5:	mvcp	0(%r5,%r2),0(%r4),%r0
+	slgr	%r3,%r5
+6:	lgr	%r2,%r3
+	br	%r14
         .section __ex_table,"a"
-	.quad	0b,2b
-	.quad	3b,1b
+	.quad	0b,4b
+	.quad	2b,4b
+	.quad	5b,6b
         .previous
 
         .align 4
         .text
         .globl __copy_to_user_asm
+	# %r2 = from, %r3 = n, %r4 = to
 __copy_to_user_asm:
-	lgr	%r5,%r3
-	sacf	512
-0:	mvcle	%r4,%r2,0
-	jo	0b
-1:	sacf	0
-	lgr	%r2,%r3
+	slgr	%r0,%r0
+0:	mvcs	0(%r3,%r4),0(%r2),%r0
+	jnz	1f
+	slgr	%r2,%r2
+	br	%r14
+1:	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+	aghi	%r3,-256
+2:	mvcs	0(%r3,%r4),0(%r2),%r0
+	jnz	1b
+3:	slgr	%r2,%r2
 	br	%r14
-2:	lghi	%r1,-4096
+4:	lghi	%r0,-4096
 	lgr	%r5,%r4
-	slgr	%r5,%r1      # %r5 = %r4 + 4096
-	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
-	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
-	clgr	%r3,%r5      # copy crosses next page boundary ?
-	jnh	1b           # no, the current page fauled
-	# The page after the current user page might have faulted.
-	# We cant't find out which page because the program check handler
-	# might have callled schedule, destroying all lowcore information.
-	# We retry with the shortened length.
-3:	mvcle	%r4,%r2,0
-	jo	3b
-	j	1b
+	slgr	%r5,%r0
+	ngr	%r5,%r0		# %r5 = (%r4 + 4096) & -4096
+	slgr	%r5,%r4		# %r5 = #bytes to next user page boundary
+	clgr	%r3,%r5		# copy crosses next page boundary ?
+	jnh	6f		# no, the current page faulted
+	# move with the reduced length which is < 256
+5:	mvcs	0(%r5,%r4),0(%r2),%r0
+	slgr	%r3,%r5
+6:	lgr	%r2,%r3
+	br	%r14
         .section __ex_table,"a"
-	.quad	0b,2b
-	.quad	3b,1b
+	.quad	0b,4b
+	.quad	2b,4b
+	.quad	5b,6b
         .previous
 
         .align 4
         .text
         .globl __copy_in_user_asm
+	# %r2 = from, %r3 = n, %r4 = to
 __copy_in_user_asm:
-	stmg	%r6,%r15,48(%r15)
-	lgr	%r5,%r3
-	lgr	%r7,%r5
-	lgr	%r6,%r2
-	cpya	6,4          # ar6 = ar4
-	sacf	512
-0:	mvcle	%r4,%r6,0
-	jo	0b
-1:	sacf	0
-	lgr	%r2,%r7
-	lmg	%r6,%r15,48(%r15)
+	sacf	256
+	bras	1,1f
+	mvc	0(1,%r4),0(%r2)
+0:	mvc	0(256,%r4),0(%r2)
+	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+1:	aghi	%r3,-256
+	jnm	0b
+2:	ex	%r3,0(%r1)
+	sacf	0
+	slgr	%r2,%r2
+	br	14
+3:	mvc	0(1,%r4),0(%r2)
+	la	%r2,1(%r2)
+	la	%r4,1(%r4)
+	aghi	%r3,-1
+	jnm	3b
+4:	lgr	%r2,%r3
+	sacf	0
 	br	%r14
-2:	lghi	%r1,-4096
-	lgr	%r5,%r4
-	slgr	%r5,%r1      # %r5 = %r4 + 4096
-	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
-	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
-	clgr	%r7,%r5      # copy crosses next page boundary ?
-	jnh	1b           # no, the current page fauled
-	# The page after the current user page might have faulted.
-	# We cant't find out which page because the program check handler
-	# might have callled schedule, destroying all lowcore information.
-	# We retry with the shortened length.
-3:	mvcle	%r4,%r6,0
-	jo	3b
-	j	1b
         .section __ex_table,"a"
-	.quad	0b,2b
-	.quad	3b,1b
+	.quad	0b,3b
+	.quad	2b,3b
+	.quad	3b,4b
         .previous
-
+	
         .align 4
         .text
         .globl __clear_user_asm
+	# %r2 = to, %r3 = n
 __clear_user_asm:
+	slgr	%r0,%r0
+	larl	%r5,empty_zero_page
+1:	mvcs	0(%r3,%r2),0(%r5),%r0
+	jnz	2f
+	slgr	%r2,%r2
+	br	%r14
+2:	la	%r2,256(%r2)
+	aghi	%r3,-256
+3:	mvcs	0(%r3,%r2),0(%r5),%r0
+	jnz	2b
+4:	slgr	%r2,%r2
+	br	%r14
+5:	lghi	%r0,-4096
 	lgr	%r4,%r2
-	lgr	%r5,%r3
-	sgr	%r2,%r2
-	sgr	%r3,%r3
-	sacf	512
-0:	mvcle	%r4,%r2,0
-	jo	0b
-1:	sacf	0
-	br	%r14
-2:	lgr	%r2,%r5
-	lghi	%r1,-4096
-	slgr	%r5,%r1      # %r5 = %r4 + 4096
-	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
-	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
-	clgr	%r2,%r5      # copy crosses next page boundary ?
-	jnh	1b           # no, the current page fauled
-	# The page after the current user page might have faulted.
-	# We cant't find out which page because the program check handler
-	# might have callled schedule, destroying all lowcore information.
-	# We retry with the shortened length.
-	slgr	%r2,%r5
-3:	mvcle	%r4,%r2,0
-	jo	3b
-	j	1b
-4:	algr	%r2,%r5
-	j	1b
+	slgr	%r4,%r0
+	ngr	%r4,%r0		# %r4 = (%r2 + 4096) & -4096
+	slgr	%r4,%r2		# %r4 = #bytes to next user page boundary
+	clgr	%r3,%r4		# clear crosses next page boundary ?
+	jnh	7f		# no, the current page faulted
+	# clear with the reduced length which is < 256
+6:	mvcs	0(%r4,%r2),0(%r5),%r0
+	slgr	%r3,%r4
+7:	lgr	%r2,%r3
+	br	%r14
         .section __ex_table,"a"
-	.quad	0b,2b
-        .quad	3b,4b
+	.quad	1b,5b
+	.quad	3b,5b
+	.quad	6b,7b
         .previous
+
+        .align 4
+        .text
+        .globl __strncpy_from_user_asm
+	# %r2 = dst, %r3 = src, %r4 = count
+__strncpy_from_user_asm:
+	lghi	%r0,0
+	lghi	%r1,1
+	lghi	%r5,0
+0:	mvcp	0(%r1,%r2),0(%r3),%r0
+	tm	0(%r2),0xff
+	jz	1f
+	la	%r2,1(%r2)
+	la	%r3,1(%r3)
+	aghi	%r5,1
+	clgr	%r5,%r4
+	jl	0b
+1:	lgr	%r2,%r5
+	br	%r14
+2:	lghi	%r2,-EFAULT
+	br	%r14
+        .section __ex_table,"a"
+	.quad	0b,2b
+	.previous
+	
+        .align 4
+        .text
+        .globl __strnlen_user_asm
+	# %r2 = src, %r3 = count
+__strnlen_user_asm:
+	lghi	%r0,0
+	lghi	%r1,1
+	lghi	%r5,0
+0:	mvcp	24(%r1,%r15),0(%r2),%r0
+	aghi	%r5,1
+	tm	24(%r15),0xff
+	jz	1f
+	la	%r2,1(%r2)
+	clgr	%r5,%r3
+	jl	0b
+1:	lgr	%r2,%r5
+	br	%r14
+2:	lghi	%r2,-EFAULT
+	br	%r14
+        .section __ex_table,"a"
+	.quad	0b,2b
+	.previous
diff -urN linux-2.6/arch/s390/mm/fault.c linux-2.6-s390/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/arch/s390/mm/fault.c	Fri Mar 26 18:25:59 2004
@@ -87,12 +87,12 @@
 	if (areg == 0)
 		/* Access via access register 0 -> kernel address */
 		return 0;
-	if (regs && areg < NUM_ACRS && regs->acrs[areg] <= 1)
+	if (regs && areg < NUM_ACRS && current->thread.acrs[areg] <= 1)
 		/*
 		 * access register contains 0 -> kernel address,
 		 * access register contains 1 -> user space address
 		 */
-		return regs->acrs[areg];
+		return current->thread.acrs[areg];
 
 	/* Something unhealthy was done with the access registers... */
 	die("page fault via unknown access register", regs, error_code);
@@ -115,8 +115,10 @@
 	 *   3: Home Segment Table Descriptor
 	 */
 	int descriptor = S390_lowcore.trans_exc_code & 3;
-	if (descriptor == 1)
+	if (descriptor == 1) {
+		save_access_regs(current->thread.acrs);
 		return __check_access_register(regs, error_code);
+	}
 	return descriptor >> 1;
 }
 
diff -urN linux-2.6/arch/s390/mm/init.c linux-2.6-s390/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/arch/s390/mm/init.c	Fri Mar 26 18:25:59 2004
@@ -138,6 +138,8 @@
                 }
         }
 
+	S390_lowcore.kernel_asce = pgdir_k;
+
         /* enable virtual mapping in kernel mode */
         __asm__ __volatile__("    LCTL  1,1,%0\n"
                              "    LCTL  7,7,%0\n"
@@ -223,6 +225,8 @@
                 }
         }
 
+	S390_lowcore.kernel_asce = pgdir_k;
+
         /* enable virtual mapping in kernel mode */
         __asm__ __volatile__("lctlg 1,1,%0\n\t"
                              "lctlg 7,7,%0\n\t"
