Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVH2Rxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVH2Rxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVH2Rxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:53:36 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42399 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751181AbVH2Rxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:53:35 -0400
Date: Mon, 29 Aug 2005 19:53:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/10] s390: machine check handler bugs.
Message-ID: <20050829175329.GA6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/10] s390: machine check handler bugs.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The new machine check handler still has a few bugs. 1) The system
entry time has to be stored in the machine check handler, 2) the
machine check return psw may not be stored at the usual place
because it might overwrite the return psw of the interrupted
context, 3) the return address for the call to s390_handle_mcck
in the i/o interrupt handler is not correct, 4) the system
call cleanup has to take the different save area of the
machine check handler into account, 5) the machine check handler
may not call UPDATE_VTIME before CREATE_STACK_FRAME, and 6) the
io leave path needs a critical section cleanup to make sure that
the TIF_MCCK_PENDING bit is really checked before switching back
to user space.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/entry.S   |  116 ++++++++++++++++++++++++++++++++++-----------
 arch/s390/kernel/entry64.S |  113 +++++++++++++++++++++++++++++++++----------
 drivers/s390/s390mach.c    |    2 
 include/asm-s390/lowcore.h |    8 ++-
 4 files changed, 181 insertions(+), 58 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2005-08-29 19:18:05.000000000 +0200
@@ -131,14 +131,14 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_
 	stg	%r12,__SF_BACKCHAIN(%r15)
         .endm
 
-	.macro	RESTORE_ALL sync
-	mvc	__LC_RETURN_PSW(16),SP_PSW(%r15) # move user PSW to lowcore
+	.macro	RESTORE_ALL psworg,sync
+	mvc	\psworg(16),SP_PSW(%r15) # move user PSW to lowcore
 	.if !\sync
-	ni	__LC_RETURN_PSW+1,0xfd	# clear wait state bit
+	ni	\psworg+1,0xfd		# clear wait state bit
 	.endif
 	lmg	%r0,%r15,SP_R0(%r15)	# load gprs 0-15 of user
 	STORE_TIMER __LC_EXIT_TIMER
-	lpswe	__LC_RETURN_PSW		# back to caller
+	lpswe	\psworg			# back to caller
 	.endm
 
 /*
@@ -233,7 +233,7 @@ sysc_return:
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jnz	sysc_work         # there is work to do (signals etc.)
 sysc_leave:
-        RESTORE_ALL 1
+        RESTORE_ALL __LC_RETURN_PSW,1
 
 #
 # recheck if there is more work to do
@@ -308,8 +308,6 @@ sysc_singlestep:
 	jg	do_single_step		# branch to do_sigtrap
 
 
-__critical_end:
-
 #
 # call syscall_trace before and after system call
 # special linkage: %r12 contains the return address for trace_svc
@@ -612,7 +610,8 @@ io_return:
 	tm	__TI_flags+7(%r9),_TIF_WORK_INT
 	jnz	io_work                # there is work to do (signals etc.)
 io_leave:
-        RESTORE_ALL 0
+        RESTORE_ALL __LC_RETURN_PSW,0
+io_done:
 
 #ifdef CONFIG_PREEMPT
 io_preempt:
@@ -711,6 +710,8 @@ ext_no_vtime:
 	brasl   %r14,do_extint
 	j	io_return
 
+__critical_end:
+
 /*
  * Machine check handler routines
  */
@@ -718,6 +719,7 @@ ext_no_vtime:
 mcck_int_handler:
 	la	%r1,4095		# revalidate r1
 	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# revalidate cpu timer
+	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_CPU_TIMER_SAVE_AREA-4095(%r1)
   	lmg     %r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# revalidate gprs
 	SAVE_ALL_BASE __LC_SAVE_AREA+64
 	la	%r12,__LC_MCK_OLD_PSW
@@ -730,17 +732,8 @@ mcck_int_handler:
 	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
 	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
 	mvc	__LC_EXIT_TIMER(8),__LC_LAST_UPDATE_TIMER
-0:	tm	__LC_MCCK_CODE+2,0x08	# mwp of old psw valid?
-	jno	mcck_no_vtime		# no -> no timer update
-	tm      __LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
-	jz	mcck_no_vtime
-	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
-	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
-mcck_no_vtime:
 #endif
-0:
-	tm	__LC_MCCK_CODE+2,0x09   # mwp + ia of old psw valid?
+0:	tm	__LC_MCCK_CODE+2,0x09   # mwp + ia of old psw valid?
 	jno	mcck_int_main		# no -> skip cleanup critical
 	tm      __LC_MCK_OLD_PSW+1,0x01 # test problem state bit
 	jnz	mcck_int_main		# from user -> load kernel stack
@@ -756,6 +749,16 @@ mcck_int_main:
 	jz	0f
 	lg      %r15,__LC_PANIC_STACK   # load panic stack
 0:	CREATE_STACK_FRAME __LC_MCK_OLD_PSW,__LC_SAVE_AREA+64
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	__LC_MCCK_CODE+2,0x08	# mwp of old psw valid?
+	jno	mcck_no_vtime		# no -> no timer update
+	tm      __LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
+	jz	mcck_no_vtime
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+mcck_no_vtime:
+#endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	la	%r2,SP_PTREGS(%r15)	# load pt_regs
 	brasl	%r14,s390_do_machine_check
@@ -771,7 +774,7 @@ mcck_int_main:
 	jno	mcck_return
 	brasl	%r14,s390_handle_mcck
 mcck_return:
-        RESTORE_ALL 0
+        RESTORE_ALL __LC_RETURN_MCCK_PSW,0
 
 #ifdef CONFIG_SMP
 /*
@@ -833,6 +836,10 @@ cleanup_table_sysc_leave:
 	.quad	sysc_leave, sysc_work_loop
 cleanup_table_sysc_work_loop:
 	.quad	sysc_work_loop, sysc_reschedule
+cleanup_table_io_leave:
+	.quad	io_leave, io_done
+cleanup_table_io_work_loop:
+	.quad	io_work_loop, io_mcck_pending
 
 cleanup_critical:
 	clc	8(8,%r12),BASED(cleanup_table_system_call)
@@ -855,10 +862,26 @@ cleanup_critical:
 	clc	8(8,%r12),BASED(cleanup_table_sysc_work_loop+8)
 	jl	cleanup_sysc_return
 0:
+	clc	8(8,%r12),BASED(cleanup_table_io_leave)
+	jl	0f
+	clc	8(8,%r12),BASED(cleanup_table_io_leave+8)
+	jl	cleanup_io_leave
+0:
+	clc	8(8,%r12),BASED(cleanup_table_io_work_loop)
+	jl	0f
+	clc	8(8,%r12),BASED(cleanup_table_io_work_loop+8)
+	jl	cleanup_io_return
+0:
 	br	%r14
 
 cleanup_system_call:
 	mvc	__LC_RETURN_PSW(16),0(%r12)
+	cghi	%r12,__LC_MCK_OLD_PSW
+	je	0f
+	la	%r12,__LC_SAVE_AREA+32
+	j	1f
+0:	la	%r12,__LC_SAVE_AREA+64
+1:
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn+8)
 	jh	0f
@@ -868,11 +891,13 @@ cleanup_system_call:
 #endif
 	clc	__LC_RETURN_PSW+8(8),BASED(cleanup_system_call_insn)
 	jh	0f
-	mvc	__LC_SAVE_AREA(32),__LC_SAVE_AREA+32
-0:	stg	%r13,__LC_SAVE_AREA+40
+	mvc	__LC_SAVE_AREA(32),0(%r12)
+0:	stg	%r13,8(%r12)
+	stg	%r12,__LC_SAVE_AREA+96	# argh
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
-	stg	%r15,__LC_SAVE_AREA+56
+	lg	%r12,__LC_SAVE_AREA+96	# argh
+	stg	%r15,24(%r12)
 	llgh	%r7,__LC_SVC_INT_CODE
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 cleanup_vtime:
@@ -909,17 +934,21 @@ cleanup_sysc_return:
 
 cleanup_sysc_leave:
 	clc	8(8,%r12),BASED(cleanup_sysc_leave_insn)
-	je	0f
+	je	2f
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
 	clc	8(8,%r12),BASED(cleanup_sysc_leave_insn+8)
-	je	0f
+	je	2f
 #endif
 	mvc	__LC_RETURN_PSW(16),SP_PSW(%r15)
-	mvc	__LC_SAVE_AREA+32(32),SP_R12(%r15)
-	lmg	%r0,%r11,SP_R0(%r15)
+	cghi	%r12,__LC_MCK_OLD_PSW
+	jne	0f
+	mvc	__LC_SAVE_AREA+64(32),SP_R12(%r15)
+	j	1f
+0:	mvc	__LC_SAVE_AREA+32(32),SP_R12(%r15)
+1:	lmg	%r0,%r11,SP_R0(%r15)
 	lg	%r15,SP_R15(%r15)
-0:	la	%r12,__LC_RETURN_PSW
+2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_sysc_leave_insn:
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
@@ -927,6 +956,36 @@ cleanup_sysc_leave_insn:
 #endif
 	.quad	sysc_leave + 12
 
+cleanup_io_return:
+	mvc	__LC_RETURN_PSW(8),0(%r12)
+	mvc	__LC_RETURN_PSW+8(8),BASED(cleanup_table_io_work_loop)
+	la	%r12,__LC_RETURN_PSW
+	br	%r14
+
+cleanup_io_leave:
+	clc	8(8,%r12),BASED(cleanup_io_leave_insn)
+	je	2f
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	clc	8(8,%r12),BASED(cleanup_io_leave_insn+8)
+	je	2f
+#endif
+	mvc	__LC_RETURN_PSW(16),SP_PSW(%r15)
+	cghi	%r12,__LC_MCK_OLD_PSW
+	jne	0f
+	mvc	__LC_SAVE_AREA+64(32),SP_R12(%r15)
+	j	1f
+0:	mvc	__LC_SAVE_AREA+32(32),SP_R12(%r15)
+1:	lmg	%r0,%r11,SP_R0(%r15)
+	lg	%r15,SP_R15(%r15)
+2:	la	%r12,__LC_RETURN_PSW
+	br	%r14
+cleanup_io_leave_insn:
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	.quad	io_leave + 20
+#endif
+	.quad	io_leave + 16
+
 /*
  * Integer constants
  */
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2005-08-29 19:18:05.000000000 +0200
@@ -138,14 +138,14 @@ STACK_SIZE  = 1 << STACK_SHIFT
 	st	%r12,__SF_BACKCHAIN(%r15)	# clear back chain
 	.endm
 
-	.macro  RESTORE_ALL sync
-	mvc	__LC_RETURN_PSW(8),SP_PSW(%r15) # move user PSW to lowcore
+	.macro  RESTORE_ALL psworg,sync
+	mvc	\psworg(8),SP_PSW(%r15) # move user PSW to lowcore
 	.if !\sync
-	ni	__LC_RETURN_PSW+1,0xfd	# clear wait state bit
+	ni	\psworg+1,0xfd		# clear wait state bit
 	.endif
 	lm	%r0,%r15,SP_R0(%r15)	# load gprs 0-15 of user
 	STORE_TIMER __LC_EXIT_TIMER
-	lpsw	__LC_RETURN_PSW		# back to caller
+	lpsw	\psworg			# back to caller
 	.endm
 
 /*
@@ -235,7 +235,7 @@ sysc_return:
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bnz	BASED(sysc_work)  # there is work to do (signals etc.)
 sysc_leave:
-        RESTORE_ALL 1
+        RESTORE_ALL __LC_RETURN_PSW,1
 
 #
 # recheck if there is more work to do
@@ -312,8 +312,6 @@ sysc_singlestep:
 	la	%r14,BASED(sysc_return)	# load adr. of system return
 	br	%r1			# branch to do_single_step
 
-__critical_end:
-
 #
 # call trace before and after sys_call
 #
@@ -571,7 +569,8 @@ io_return:
 	tm	__TI_flags+3(%r9),_TIF_WORK_INT
 	bnz	BASED(io_work)         # there is work to do (signals etc.)
 io_leave:
-        RESTORE_ALL 0
+        RESTORE_ALL __LC_RETURN_PSW,0
+io_done:
 
 #ifdef CONFIG_PREEMPT
 io_preempt:
@@ -621,7 +620,7 @@ io_work_loop:
 #
 io_mcck_pending:
 	l	%r1,BASED(.Ls390_handle_mcck)
-	l	%r14,BASED(io_work_loop)
+	la	%r14,BASED(io_work_loop)
 	br	%r1		       # TIF bit will be cleared by handler
 
 #
@@ -674,6 +673,8 @@ ext_no_vtime:
 	basr	%r14,%r1
 	b	BASED(io_return)
 
+__critical_end:
+
 /*
  * Machine check handler routines
  */
@@ -681,6 +682,7 @@ ext_no_vtime:
         .globl mcck_int_handler
 mcck_int_handler:
 	spt	__LC_CPU_TIMER_SAVE_AREA	# revalidate cpu timer
+	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_CPU_TIMER_SAVE_AREA
 	lm	%r0,%r15,__LC_GPREGS_SAVE_AREA	# revalidate gprs
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
 	la	%r12,__LC_MCK_OLD_PSW
@@ -693,17 +695,8 @@ mcck_int_handler:
 	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
 	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
 	mvc	__LC_EXIT_TIMER(8),__LC_LAST_UPDATE_TIMER
-0:	tm	__LC_MCCK_CODE+2,0x08   # mwp of old psw valid?
-	bno	BASED(mcck_no_vtime)	# no -> skip cleanup critical
-	tm	__LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
-	bz	BASED(mcck_no_vtime)
-	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
-	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
-mcck_no_vtime:
 #endif
-0:
-	tm	__LC_MCCK_CODE+2,0x09   # mwp + ia of old psw valid?
+0:	tm	__LC_MCCK_CODE+2,0x09   # mwp + ia of old psw valid?
 	bno	BASED(mcck_int_main)	# no -> skip cleanup critical
 	tm	__LC_MCK_OLD_PSW+1,0x01	# test problem state bit
 	bnz	BASED(mcck_int_main)	# from user -> load async stack
@@ -720,6 +713,16 @@ mcck_int_main:
 	be	BASED(0f)
 	l	%r15,__LC_PANIC_STACK	# load panic stack
 0:	CREATE_STACK_FRAME __LC_MCK_OLD_PSW,__LC_SAVE_AREA+32
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	tm	__LC_MCCK_CODE+2,0x08   # mwp of old psw valid?
+	bno	BASED(mcck_no_vtime)	# no -> skip cleanup critical
+	tm	__LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
+	bz	BASED(mcck_no_vtime)
+	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
+	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+mcck_no_vtime:
+#endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	la	%r2,SP_PTREGS(%r15)	# load pt_regs
 	l       %r1,BASED(.Ls390_mcck)
@@ -737,7 +740,7 @@ mcck_int_main:
 	l	%r1,BASED(.Ls390_handle_mcck)
 	basr	%r14,%r1		# call machine check handler
 mcck_return:
-        RESTORE_ALL 0
+        RESTORE_ALL __LC_RETURN_MCCK_PSW,0
 
 #ifdef CONFIG_SMP
 /*
@@ -803,6 +806,10 @@ cleanup_table_sysc_leave:
 	.long	sysc_leave + 0x80000000, sysc_work_loop + 0x80000000
 cleanup_table_sysc_work_loop:
 	.long	sysc_work_loop + 0x80000000, sysc_reschedule + 0x80000000
+cleanup_table_io_leave:
+	.long	io_leave + 0x80000000, io_done + 0x80000000
+cleanup_table_io_work_loop:
+	.long	io_work_loop + 0x80000000, io_mcck_pending + 0x80000000
 
 cleanup_critical:
 	clc	4(4,%r12),BASED(cleanup_table_system_call)
@@ -825,10 +832,26 @@ cleanup_critical:
 	clc	4(4,%r12),BASED(cleanup_table_sysc_work_loop+4)
 	bl	BASED(cleanup_sysc_return)
 0:
+	clc	4(4,%r12),BASED(cleanup_table_io_leave)
+	bl	BASED(0f)
+	clc	4(4,%r12),BASED(cleanup_table_io_leave+4)
+	bl	BASED(cleanup_io_leave)
+0:
+	clc	4(4,%r12),BASED(cleanup_table_io_work_loop)
+	bl	BASED(0f)
+	clc	4(4,%r12),BASED(cleanup_table_io_work_loop+4)
+	bl	BASED(cleanup_io_return)
+0:
 	br	%r14
 
 cleanup_system_call:
 	mvc	__LC_RETURN_PSW(8),0(%r12)
+	c	%r12,BASED(.Lmck_old_psw)
+	be	BASED(0f)
+	la	%r12,__LC_SAVE_AREA+16
+	b	BASED(1f)
+0:	la	%r12,__LC_SAVE_AREA+32
+1:
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn+4)
 	bh	BASED(0f)
@@ -838,11 +861,13 @@ cleanup_system_call:
 #endif
 	clc	__LC_RETURN_PSW+4(4),BASED(cleanup_system_call_insn)
 	bh	BASED(0f)
-	mvc	__LC_SAVE_AREA(16),__LC_SAVE_AREA+16
-0:	st	%r13,__LC_SAVE_AREA+20
+	mvc	__LC_SAVE_AREA(16),0(%r12)
+0:	st	%r13,4(%r12)
+	st	%r12,__LC_SAVE_AREA+48	# argh
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
-	st	%r15,__LC_SAVE_AREA+28
+	l	%r12,__LC_SAVE_AREA+48	# argh
+	st	%r15,12(%r12)
 	lh	%r7,0x8a
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 cleanup_vtime:
@@ -879,17 +904,21 @@ cleanup_sysc_return:
 
 cleanup_sysc_leave:
 	clc	4(4,%r12),BASED(cleanup_sysc_leave_insn)
-	be	BASED(0f)
+	be	BASED(2f)
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
 	clc	4(4,%r12),BASED(cleanup_sysc_leave_insn+4)
-	be	BASED(0f)
+	be	BASED(2f)
 #endif
 	mvc	__LC_RETURN_PSW(8),SP_PSW(%r15)
-	mvc	__LC_SAVE_AREA+16(16),SP_R12(%r15)
-	lm	%r0,%r11,SP_R0(%r15)
+	c	%r12,BASED(.Lmck_old_psw)
+	bne	BASED(0f)
+	mvc	__LC_SAVE_AREA+32(16),SP_R12(%r15)
+	b	BASED(1f)
+0:	mvc	__LC_SAVE_AREA+16(16),SP_R12(%r15)
+1:	lm	%r0,%r11,SP_R0(%r15)
 	l	%r15,SP_R15(%r15)
-0:	la	%r12,__LC_RETURN_PSW
+2:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_sysc_leave_insn:
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
@@ -897,6 +926,36 @@ cleanup_sysc_leave_insn:
 #endif
 	.long	sysc_leave + 10 + 0x80000000
 
+cleanup_io_return:
+	mvc	__LC_RETURN_PSW(4),0(%r12)
+	mvc	__LC_RETURN_PSW+4(4),BASED(cleanup_table_io_work_loop)
+	la	%r12,__LC_RETURN_PSW
+	br	%r14
+
+cleanup_io_leave:
+	clc	4(4,%r12),BASED(cleanup_io_leave_insn)
+	be	BASED(2f)
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	clc	4(4,%r12),BASED(cleanup_io_leave_insn+4)
+	be	BASED(2f)
+#endif
+	mvc	__LC_RETURN_PSW(8),SP_PSW(%r15)
+	c	%r12,BASED(.Lmck_old_psw)
+	bne	BASED(0f)
+	mvc	__LC_SAVE_AREA+32(16),SP_R12(%r15)
+	b	BASED(1f)
+0:	mvc	__LC_SAVE_AREA+16(16),SP_R12(%r15)
+1:	lm	%r0,%r11,SP_R0(%r15)
+	l	%r15,SP_R15(%r15)
+2:	la	%r12,__LC_RETURN_PSW
+	br	%r14
+cleanup_io_leave_insn:
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	.long	io_leave + 18 + 0x80000000
+#endif
+	.long	io_leave + 14 + 0x80000000
+
 /*
  * Integer constants
  */
@@ -918,6 +977,7 @@ cleanup_sysc_leave_insn:
 .Ls390_mcck:   .long  s390_do_machine_check
 .Ls390_handle_mcck:
 	       .long  s390_handle_mcck
+.Lmck_old_psw: .long  __LC_MCK_OLD_PSW
 .Ldo_IRQ:      .long  do_IRQ
 .Ldo_extint:   .long  do_extint
 .Ldo_signal:   .long  do_signal
diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/s390mach.c	2005-08-29 19:18:05.000000000 +0200
@@ -240,7 +240,7 @@ s390_revalidate_registers(struct mci *mc
 			 * Floating point control register can't be restored.
 			 * Task will be terminated.
 			 */
-			asm volatile ("lfpc 0(%0)" : : "a" (&zero));
+			asm volatile ("lfpc 0(%0)" : : "a" (&zero), "m" (zero));
 			kill_task = 1;
 
 		}
diff -urpN linux-2.6/include/asm-s390/lowcore.h linux-2.6-patched/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/lowcore.h	2005-08-29 19:18:05.000000000 +0200
@@ -68,6 +68,7 @@
 #define __LC_SYSTEM_TIMER		0x270
 #define __LC_LAST_UPDATE_CLOCK		0x278
 #define __LC_STEAL_CLOCK		0x280
+#define __LC_RETURN_MCCK_PSW            0x288
 #define __LC_KERNEL_STACK               0xC40
 #define __LC_THREAD_INFO		0xC44
 #define __LC_ASYNC_STACK                0xC48
@@ -90,6 +91,7 @@
 #define __LC_SYSTEM_TIMER		0x278
 #define __LC_LAST_UPDATE_CLOCK		0x280
 #define __LC_STEAL_CLOCK		0x288
+#define __LC_RETURN_MCCK_PSW            0x290
 #define __LC_KERNEL_STACK               0xD40
 #define __LC_THREAD_INFO		0xD48
 #define __LC_ASYNC_STACK                0xD50
@@ -196,7 +198,8 @@ struct _lowcore
 	__u64        system_timer;             /* 0x270 */
 	__u64        last_update_clock;        /* 0x278 */
 	__u64        steal_clock;              /* 0x280 */
-	__u8         pad8[0xc00-0x288];        /* 0x288 */
+        psw_t        return_mcck_psw;          /* 0x288 */
+	__u8         pad8[0xc00-0x290];        /* 0x290 */
 
         /* System info area */
 	__u32        save_area[16];            /* 0xc00 */
@@ -285,7 +288,8 @@ struct _lowcore
 	__u64        system_timer;             /* 0x278 */
 	__u64        last_update_clock;        /* 0x280 */
 	__u64        steal_clock;              /* 0x288 */
-        __u8         pad8[0xc00-0x290];        /* 0x290 */
+        psw_t        return_mcck_psw;          /* 0x290 */
+        __u8         pad8[0xc00-0x2a0];        /* 0x2a0 */
         /* System info area */
 	__u64        save_area[16];            /* 0xc00 */
         __u8         pad9[0xd40-0xc80];        /* 0xc80 */
