Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWFNODg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWFNODg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWFNODg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:03:36 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:40986 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964951AbWFNODf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:03:35 -0400
Date: Wed, 14 Jun 2006 16:03:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 14/24] s390: virtual cpu accounting vs. machine checks.
Message-ID: <20060614140336.GO9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] virtual cpu accounting vs. machine checks.

If a machine checks interrupts the external or the i/o interrupt
handler before they have completed the cpu time calculations, the
accounting goes wrong. After the cpu returned from the machine check
handler to the interrupted interrupt handler, a negative cpu time delta
can occur.  If the accumulated cpu time in lowcore is small enough
this value can get negative as well. The next jiffy interrupt will pick
up that negative value, shift it by 12 and add the now huge positive
value to the cpu time of the process.
To solve this the machine check handler is modified not to change any
of the timestamps in the lowcore if the machine check interrupted kernel
context.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |   79 +++++++++++++++++++++++++++++++++------------
 arch/s390/kernel/entry64.S |   78 ++++++++++++++++++++++++++++++++------------
 2 files changed, 116 insertions(+), 41 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2006-06-14 14:29:50.000000000 +0200
@@ -87,13 +87,22 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_
 	larl	%r13,system_call
 	.endm
 
-        .macro  SAVE_ALL psworg,savearea,sync
+	.macro	SAVE_ALL_SYNC psworg,savearea
 	la	%r12,\psworg
-	.if	\sync
 	tm	\psworg+1,0x01		# test problem state bit
 	jz	2f			# skip stack setup save
 	lg	%r15,__LC_KERNEL_STACK	# problem state -> load ksp
-	.else
+#ifdef CONFIG_CHECK_STACK
+	j	3f
+2:	tml	%r15,STACK_SIZE - CONFIG_STACK_GUARD
+	jz	stack_overflow
+3:
+#endif
+2:
+	.endm
+
+	.macro	SAVE_ALL_ASYNC psworg,savearea
+	la	%r12,\psworg
 	tm	\psworg+1,0x01		# test problem state bit
 	jnz	1f			# from user -> load kernel stack
 	clc	\psworg+8(8),BASED(.Lcritical_end)
@@ -108,7 +117,6 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_
 	srag	%r14,%r14,STACK_SHIFT
 	jz	2f
 1:	lg	%r15,__LC_ASYNC_STACK	# load async stack
-	.endif
 #ifdef CONFIG_CHECK_STACK
 	j	3f
 2:	tml	%r15,STACK_SIZE - CONFIG_STACK_GUARD
@@ -187,7 +195,7 @@ system_call:
 	STORE_TIMER __LC_SYNC_ENTER_TIMER
 sysc_saveall:
 	SAVE_ALL_BASE __LC_SAVE_AREA
-        SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
         CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
@@ -446,7 +454,7 @@ pgm_check_handler:
 	SAVE_ALL_BASE __LC_SAVE_AREA
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         jnz     pgm_per                  # got per exception -> special case
-	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -485,7 +493,7 @@ pgm_per:
 # Normal per exception
 #
 pgm_per_std:
-	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -511,7 +519,7 @@ pgm_no_vtime2:
 # it was a single stepped SVC that is causing all the trouble
 #
 pgm_svcper:
-	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -539,7 +547,7 @@ io_int_handler:
 	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
-        SAVE_ALL __LC_IO_OLD_PSW,__LC_SAVE_AREA+32,0
+	SAVE_ALL_ASYNC __LC_IO_OLD_PSW,__LC_SAVE_AREA+32
 	CREATE_STACK_FRAME __LC_IO_OLD_PSW,__LC_SAVE_AREA+32
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -647,7 +655,7 @@ ext_int_handler:
 	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
-        SAVE_ALL __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32,0
+	SAVE_ALL_ASYNC __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32
 	CREATE_STACK_FRAME __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -672,21 +680,32 @@ __critical_end:
 mcck_int_handler:
 	la	%r1,4095		# revalidate r1
 	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# revalidate cpu timer
-	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_CPU_TIMER_SAVE_AREA-4095(%r1)
   	lmg     %r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# revalidate gprs
 	SAVE_ALL_BASE __LC_SAVE_AREA+64
 	la	%r12,__LC_MCK_OLD_PSW
 	tm	__LC_MCCK_CODE,0x80     # system damage?
 	jo	mcck_int_main		# yes -> rest of mcck code invalid
-	tm	__LC_MCCK_CODE+5,0x02   # stored cpu timer value valid?
-	jo	0f
-	spt	__LC_LAST_UPDATE_TIMER
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
-	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
-	mvc	__LC_EXIT_TIMER(8),__LC_LAST_UPDATE_TIMER
+	la	%r14,4095
+	mvc	__LC_SAVE_AREA+104(8),__LC_ASYNC_ENTER_TIMER
+	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_CPU_TIMER_SAVE_AREA-4095(%r14)
+	tm	__LC_MCCK_CODE+5,0x02	# stored cpu timer value valid?
+	jo	1f
+	la	%r14,__LC_SYNC_ENTER_TIMER
+	clc	0(8,%r14),__LC_ASYNC_ENTER_TIMER
+	jl	0f
+	la	%r14,__LC_ASYNC_ENTER_TIMER
+0:	clc	0(8,%r14),__LC_EXIT_TIMER
+	jl	0f
+	la	%r14,__LC_EXIT_TIMER
+0:	clc	0(8,%r14),__LC_LAST_UPDATE_TIMER
+	jl	0f
+	la	%r14,__LC_LAST_UPDATE_TIMER
+0:	spt	0(%r14)
+	mvc	__LC_ASYNC_ENTER_TIMER(8),0(%r14)
+1:
 #endif
-0:	tm	__LC_MCCK_CODE+2,0x09   # mwp + ia of old psw valid?
+	tm	__LC_MCCK_CODE+2,0x09	# mwp + ia of old psw valid?
 	jno	mcck_int_main		# no -> skip cleanup critical
 	tm      __LC_MCK_OLD_PSW+1,0x01 # test problem state bit
 	jnz	mcck_int_main		# from user -> load kernel stack
@@ -705,7 +724,7 @@ mcck_int_main:
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	__LC_MCCK_CODE+2,0x08	# mwp of old psw valid?
 	jno	mcck_no_vtime		# no -> no timer update
-	tm      __LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	jz	mcck_no_vtime
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
@@ -727,7 +746,17 @@ mcck_no_vtime:
 	jno	mcck_return
 	brasl	%r14,s390_handle_mcck
 mcck_return:
-        RESTORE_ALL __LC_RETURN_MCCK_PSW,0
+	mvc	__LC_RETURN_MCCK_PSW(16),SP_PSW(%r15) # move return PSW
+	ni	__LC_RETURN_MCCK_PSW+1,0xfd # clear wait state bit
+	lmg	%r0,%r15,SP_R0(%r15)	# load gprs 0-15
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_SAVE_AREA+104
+	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
+	jno	0f
+	stpt	__LC_EXIT_TIMER
+0:
+#endif
+	lpswe	__LC_RETURN_MCCK_PSW	# back to caller
 
 #ifdef CONFIG_SMP
 /*
@@ -789,6 +818,8 @@ cleanup_table_sysc_leave:
 	.quad	sysc_leave, sysc_work_loop
 cleanup_table_sysc_work_loop:
 	.quad	sysc_work_loop, sysc_reschedule
+cleanup_table_io_return:
+	.quad	io_return, io_leave
 cleanup_table_io_leave:
 	.quad	io_leave, io_done
 cleanup_table_io_work_loop:
@@ -815,6 +846,11 @@ cleanup_critical:
 	clc	8(8,%r12),BASED(cleanup_table_sysc_work_loop+8)
 	jl	cleanup_sysc_return
 0:
+	clc	8(8,%r12),BASED(cleanup_table_io_return)
+	jl	0f
+	clc	8(8,%r12),BASED(cleanup_table_io_return+8)
+	jl	cleanup_io_return
+0:
 	clc	8(8,%r12),BASED(cleanup_table_io_leave)
 	jl	0f
 	clc	8(8,%r12),BASED(cleanup_table_io_leave+8)
@@ -847,7 +883,7 @@ cleanup_system_call:
 	mvc	__LC_SAVE_AREA(32),0(%r12)
 0:	stg	%r13,8(%r12)
 	stg	%r12,__LC_SAVE_AREA+96	# argh
-	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	lg	%r12,__LC_SAVE_AREA+96	# argh
 	stg	%r15,24(%r12)
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2006-06-14 14:29:50.000000000 +0200
@@ -93,13 +93,22 @@ STACK_SIZE  = 1 << STACK_SHIFT
 	l	%r13,__LC_SVC_NEW_PSW+4	# load &system_call to %r13
 	.endm
 
-	.macro	SAVE_ALL psworg,savearea,sync
+	.macro	SAVE_ALL_SYNC psworg,savearea
 	la	%r12,\psworg
-	.if	\sync
 	tm	\psworg+1,0x01		# test problem state bit
 	bz	BASED(2f)		# skip stack setup save
 	l	%r15,__LC_KERNEL_STACK	# problem state -> load ksp
-	.else
+#ifdef CONFIG_CHECK_STACK
+	b	BASED(3f)
+2:	tml	%r15,STACK_SIZE - CONFIG_STACK_GUARD
+	bz	BASED(stack_overflow)
+3:
+#endif
+2:
+	.endm
+
+	.macro	SAVE_ALL_ASYNC psworg,savearea
+	la	%r12,\psworg
 	tm	\psworg+1,0x01		# test problem state bit
 	bnz	BASED(1f)		# from user -> load async stack
 	clc	\psworg+4(4),BASED(.Lcritical_end)
@@ -115,7 +124,6 @@ STACK_SIZE  = 1 << STACK_SHIFT
 	sra	%r14,STACK_SHIFT
 	be	BASED(2f)
 1:	l	%r15,__LC_ASYNC_STACK
-	.endif
 #ifdef CONFIG_CHECK_STACK
 	b	BASED(3f)
 2:	tml	%r15,STACK_SIZE - CONFIG_STACK_GUARD
@@ -196,7 +204,7 @@ system_call:
 	STORE_TIMER __LC_SYNC_ENTER_TIMER
 sysc_saveall:
 	SAVE_ALL_BASE __LC_SAVE_AREA
-        SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	lh	%r7,0x8a	  # get svc number from lowcore
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
@@ -425,7 +433,7 @@ pgm_check_handler:
 	SAVE_ALL_BASE __LC_SAVE_AREA
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         bnz     BASED(pgm_per)           # got per exception -> special case
-	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -464,7 +472,7 @@ pgm_per:
 # Normal per exception
 #
 pgm_per_std:
-	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -490,7 +498,7 @@ pgm_no_vtime2:
 # it was a single stepped SVC that is causing all the trouble
 #
 pgm_svcper:
-	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -519,7 +527,7 @@ io_int_handler:
 	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+16
-        SAVE_ALL __LC_IO_OLD_PSW,__LC_SAVE_AREA+16,0
+	SAVE_ALL_ASYNC __LC_IO_OLD_PSW,__LC_SAVE_AREA+16
 	CREATE_STACK_FRAME __LC_IO_OLD_PSW,__LC_SAVE_AREA+16
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -631,7 +639,7 @@ ext_int_handler:
 	STORE_TIMER __LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+16
-        SAVE_ALL __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16,0
+	SAVE_ALL_ASYNC __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16
 	CREATE_STACK_FRAME __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
@@ -657,21 +665,31 @@ __critical_end:
         .globl mcck_int_handler
 mcck_int_handler:
 	spt	__LC_CPU_TIMER_SAVE_AREA	# revalidate cpu timer
-	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_CPU_TIMER_SAVE_AREA
 	lm	%r0,%r15,__LC_GPREGS_SAVE_AREA	# revalidate gprs
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
 	la	%r12,__LC_MCK_OLD_PSW
 	tm	__LC_MCCK_CODE,0x80     # system damage?
 	bo	BASED(mcck_int_main)	# yes -> rest of mcck code invalid
-	tm	__LC_MCCK_CODE+5,0x02   # stored cpu timer value valid?
-	bo	BASED(0f)
-	spt	__LC_LAST_UPDATE_TIMER	# revalidate cpu timer
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
-	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
-	mvc	__LC_EXIT_TIMER(8),__LC_LAST_UPDATE_TIMER
+	mvc	__LC_SAVE_AREA+52(8),__LC_ASYNC_ENTER_TIMER
+	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_CPU_TIMER_SAVE_AREA
+	tm	__LC_MCCK_CODE+5,0x02	# stored cpu timer value valid?
+	bo	BASED(1f)
+	la	%r14,__LC_SYNC_ENTER_TIMER
+	clc	0(8,%r14),__LC_ASYNC_ENTER_TIMER
+	bl	BASED(0f)
+	la	%r14,__LC_ASYNC_ENTER_TIMER
+0:	clc	0(8,%r14),__LC_EXIT_TIMER
+	bl	BASED(0f)
+	la	%r14,__LC_EXIT_TIMER
+0:	clc	0(8,%r14),__LC_LAST_UPDATE_TIMER
+	bl	BASED(0f)
+	la	%r14,__LC_LAST_UPDATE_TIMER
+0:	spt	0(%r14)
+	mvc	__LC_ASYNC_ENTER_TIMER(8),0(%r14)
+1:
 #endif
-0:	tm	__LC_MCCK_CODE+2,0x09   # mwp + ia of old psw valid?
+	tm	__LC_MCCK_CODE+2,0x09	# mwp + ia of old psw valid?
 	bno	BASED(mcck_int_main)	# no -> skip cleanup critical
 	tm	__LC_MCK_OLD_PSW+1,0x01	# test problem state bit
 	bnz	BASED(mcck_int_main)	# from user -> load async stack
@@ -691,7 +709,7 @@ mcck_int_main:
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	__LC_MCCK_CODE+2,0x08   # mwp of old psw valid?
 	bno	BASED(mcck_no_vtime)	# no -> skip cleanup critical
-	tm	__LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
+	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	bz	BASED(mcck_no_vtime)
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
@@ -715,6 +733,20 @@ mcck_no_vtime:
 	l	%r1,BASED(.Ls390_handle_mcck)
 	basr	%r14,%r1		# call machine check handler
 mcck_return:
+	mvc	__LC_RETURN_MCCK_PSW(8),SP_PSW(%r15) # move return PSW
+	ni	__LC_RETURN_MCCK_PSW+1,0xfd # clear wait state bit
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_SAVE_AREA+52
+	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
+	bno	BASED(0f)
+	lm	%r0,%r15,SP_R0(%r15)	# load gprs 0-15
+	stpt	__LC_EXIT_TIMER
+	lpsw	__LC_RETURN_MCCK_PSW	# back to caller
+0:
+#endif
+	lm	%r0,%r15,SP_R0(%r15)	# load gprs 0-15
+	lpsw	__LC_RETURN_MCCK_PSW	# back to caller
+
         RESTORE_ALL __LC_RETURN_MCCK_PSW,0
 
 #ifdef CONFIG_SMP
@@ -781,6 +813,8 @@ cleanup_table_sysc_leave:
 	.long	sysc_leave + 0x80000000, sysc_work_loop + 0x80000000
 cleanup_table_sysc_work_loop:
 	.long	sysc_work_loop + 0x80000000, sysc_reschedule + 0x80000000
+cleanup_table_io_return:
+	.long	io_return + 0x80000000, io_leave + 0x80000000
 cleanup_table_io_leave:
 	.long	io_leave + 0x80000000, io_done + 0x80000000
 cleanup_table_io_work_loop:
@@ -807,6 +841,11 @@ cleanup_critical:
 	clc	4(4,%r12),BASED(cleanup_table_sysc_work_loop+4)
 	bl	BASED(cleanup_sysc_return)
 0:
+	clc	4(4,%r12),BASED(cleanup_table_io_return)
+	bl	BASED(0f)
+	clc	4(4,%r12),BASED(cleanup_table_io_return+4)
+	bl	BASED(cleanup_io_return)
+0:
 	clc	4(4,%r12),BASED(cleanup_table_io_leave)
 	bl	BASED(0f)
 	clc	4(4,%r12),BASED(cleanup_table_io_leave+4)
@@ -839,7 +878,7 @@ cleanup_system_call:
 	mvc	__LC_SAVE_AREA(16),0(%r12)
 0:	st	%r13,4(%r12)
 	st	%r12,__LC_SAVE_AREA+48	# argh
-	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	SAVE_ALL_SYNC __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	l	%r12,__LC_SAVE_AREA+48	# argh
 	st	%r15,12(%r12)
