Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVFWRMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVFWRMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVFWRLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:11:05 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:17366 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262613AbVFWRGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:06:14 -0400
Date: Thu, 23 Jun 2005 19:06:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 1/3] s390: improved machine check handling.
Message-ID: <20050623170606.GA7262@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/3] s390: improved machine check handling.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Improved machine check handling. Kernel is now able to receive machine
checks while in kernel mode (system call, interrupt and program check
handling). Also register validation is now performed.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/entry.S       |  102 +++++++++++--
 arch/s390/kernel/entry64.S     |   97 +++++++++++-
 arch/s390/kernel/process.c     |   46 +----
 arch/s390/kernel/setup.c       |   13 +
 arch/s390/kernel/smp.c         |   13 +
 drivers/s390/s390mach.c        |  321 ++++++++++++++++++++++++++++++++++++-----
 drivers/s390/s390mach.h        |   35 +++-
 include/asm-s390/lowcore.h     |    7 
 include/asm-s390/processor.h   |   52 ++----
 include/asm-s390/ptrace.h      |    2 
 include/asm-s390/system.h      |   21 +-
 include/asm-s390/thread_info.h |    2 
 12 files changed, 576 insertions(+), 135 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2005-06-23 18:57:54.000000000 +0200
@@ -7,6 +7,7 @@
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Hartmut Penner (hp@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
 #include <linux/sys.h>
@@ -52,9 +53,9 @@ SP_SIZE      =  STACK_FRAME_OVERHEAD + _
 STACK_SHIFT = PAGE_SHIFT + THREAD_ORDER
 STACK_SIZE  = 1 << STACK_SHIFT
 
-_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
+_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING | \
 		 _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
-_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
+_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING)
 
 #define BASED(name) name-system_call(%r13)
 
@@ -114,7 +115,11 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_
 	jz	stack_overflow
 3:
 #endif
-2:	aghi    %r15,-SP_SIZE		# make room for registers & psw
+2:
+	.endm
+
+	.macro	CREATE_STACK_FRAME psworg,savearea
+	aghi    %r15,-SP_SIZE		# make room for registers & psw
 	mvc     SP_PSW(16,%r15),0(%r12)	# move user PSW to stack
 	la	%r12,\psworg
 	stg	%r2,SP_ORIG_R2(%r15)	# store original content of gpr 2
@@ -152,6 +157,13 @@ __switch_to:
         je      __switch_to_noper            # we got away without bashing TLB's
         lctlg   %c9,%c11,__THREAD_per(%r3)	# Nope we didn't
 __switch_to_noper:
+	lg	%r4,__THREAD_info(%r2)              # get thread_info of prev
+	tm	__TI_flags+7(%r4),_TIF_MCCK_PENDING # machine check pending?
+	jz	__switch_to_no_mcck
+	ni	__TI_flags+7(%r4),255-_TIF_MCCK_PENDING # clear flag in prev
+	lg	%r4,__THREAD_info(%r3)		    # get thread_info of next
+	oi	__TI_flags+7(%r4),_TIF_MCCK_PENDING # set it in next
+__switch_to_no_mcck:
         stmg    %r6,%r15,__SF_GPRS(%r15)# store __switch_to registers of prev task
 	stg	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	lg	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
@@ -176,6 +188,7 @@ system_call:
 sysc_saveall:
 	SAVE_ALL_BASE __LC_SAVE_AREA
         SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+        CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 sysc_vtime:
@@ -232,6 +245,8 @@ sysc_work_loop:
 # One of the work bits is on. Find out which one.
 #
 sysc_work:
+	tm	__TI_flags+7(%r9),_TIF_MCCK_PENDING
+	jo	sysc_mcck_pending
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jo	sysc_reschedule
 	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
@@ -250,6 +265,13 @@ sysc_reschedule:        
         jg      schedule            # return point is sysc_return
 
 #
+# _TIF_MCCK_PENDING is set, call handler
+#
+sysc_mcck_pending:
+	larl	%r14,sysc_work_loop
+	jg	s390_handle_mcck    # TIF bit will be cleared by handler
+
+#
 # _TIF_SIGPENDING is set, call do_signal
 #
 sysc_sigpending:     
@@ -474,6 +496,7 @@ pgm_check_handler:
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         jnz     pgm_per                  # got per exception -> special case
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	jz	pgm_no_vtime
@@ -512,6 +535,7 @@ pgm_per:
 #
 pgm_per_std:
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	jz	pgm_no_vtime2
@@ -537,6 +561,7 @@ pgm_no_vtime2:
 #
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	jz	pgm_no_vtime3
@@ -564,6 +589,7 @@ io_int_handler:
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
         SAVE_ALL __LC_IO_OLD_PSW,__LC_SAVE_AREA+32,0
+	CREATE_STACK_FRAME __LC_IO_OLD_PSW,__LC_SAVE_AREA+32
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	jz	io_no_vtime
@@ -621,9 +647,11 @@ io_work:
 	lgr	%r15,%r1
 #
 # One of the work bits is on. Find out which one.
-# Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
+# Checked are: _TIF_SIGPENDING, _TIF_NEED_RESCHED and _TIF_MCCK_PENDING
 #
 io_work_loop:
+	tm	__TI_flags+7(%r9),_TIF_MCCK_PENDING
+	jo	io_mcck_pending
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jo	io_reschedule
 	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
@@ -631,6 +659,13 @@ io_work_loop:
 	j	io_leave
 
 #
+# _TIF_MCCK_PENDING is set, call handler
+#
+io_mcck_pending:
+	larl	%r14,io_work_loop
+	jg	s390_handle_mcck	# TIF bit will be cleared by handler
+
+#
 # _TIF_NEED_RESCHED is set, call schedule
 #	
 io_reschedule:        
@@ -661,6 +696,7 @@ ext_int_handler:
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
         SAVE_ALL __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32,0
+	CREATE_STACK_FRAME __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	jz	ext_no_vtime
@@ -680,18 +716,60 @@ ext_no_vtime:
  */
         .globl mcck_int_handler
 mcck_int_handler:
-	STORE_TIMER __LC_ASYNC_ENTER_TIMER
+	la	%r1,4095		# revalidate r1
+	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# revalidate cpu timer
+  	lmg     %r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# revalidate gprs
 	SAVE_ALL_BASE __LC_SAVE_AREA+64
-        SAVE_ALL __LC_MCK_OLD_PSW,__LC_SAVE_AREA+64,0
+	la	%r12,__LC_MCK_OLD_PSW
+	tm	__LC_MCCK_CODE,0x80     # system damage?
+	jo	mcck_int_main		# yes -> rest of mcck code invalid
+	tm	__LC_MCCK_CODE+5,0x02   # stored cpu timer value valid?
+	jo	0f
+	spt	__LC_LAST_UPDATE_TIMER
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_EXIT_TIMER
+0:	tm	__LC_MCCK_CODE+2,0x08	# mwp of old psw valid?
+	jno	mcck_no_vtime		# no -> no timer update
+	tm      __LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
 	jz	mcck_no_vtime
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
 mcck_no_vtime:
 #endif
-	brasl   %r14,s390_do_machine_check
+0:
+	tm	__LC_MCCK_CODE+2,0x09   # mwp + ia of old psw valid?
+	jno	mcck_int_main		# no -> skip cleanup critical
+	tm      __LC_MCK_OLD_PSW+1,0x01 # test problem state bit
+	jnz	mcck_int_main		# from user -> load kernel stack
+	clc	__LC_MCK_OLD_PSW+8(8),BASED(.Lcritical_end)
+	jhe	mcck_int_main
+	clc     __LC_MCK_OLD_PSW+8(8),BASED(.Lcritical_start)
+	jl	mcck_int_main
+	brasl   %r14,cleanup_critical
+mcck_int_main:
+	lg      %r14,__LC_PANIC_STACK   # are we already on the panic stack?
+	slgr	%r14,%r15
+	srag	%r14,%r14,PAGE_SHIFT
+	jz	0f
+	lg      %r15,__LC_PANIC_STACK   # load panic stack
+0:	CREATE_STACK_FRAME __LC_MCK_OLD_PSW,__LC_SAVE_AREA+64
+	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	la	%r2,SP_PTREGS(%r15)	# load pt_regs
+	brasl	%r14,s390_do_machine_check
+	tm	SP_PSW+1(%r15),0x01     # returning to user ?
+	jno	mcck_return
+	lg	%r1,__LC_KERNEL_STACK	# switch to kernel stack
+	aghi	%r1,-SP_SIZE
+	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
+	xc	__SF_BACKCHAIN(8,%r1),__SF_BACKCHAIN(%r1) # clear back chain
+	lgr	%r15,%r1
+	stosm	__SF_EMPTY(%r15),0x04	# turn dat on
+	tm	__TI_flags+7(%r9),_TIF_MCCK_PENDING
+	jno	mcck_return
+	brasl	%r14,s390_handle_mcck
 mcck_return:
         RESTORE_ALL 0
 
@@ -775,7 +853,7 @@ cleanup_critical:
 	clc	8(8,%r12),BASED(cleanup_table_sysc_work_loop)
 	jl	0f
 	clc	8(8,%r12),BASED(cleanup_table_sysc_work_loop+8)
-	jl	cleanup_sysc_leave
+	jl	cleanup_sysc_return
 0:
 	br	%r14
 
@@ -793,6 +871,7 @@ cleanup_system_call:
 	mvc	__LC_SAVE_AREA(32),__LC_SAVE_AREA+32
 0:	stg	%r13,__LC_SAVE_AREA+40
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	stg	%r15,__LC_SAVE_AREA+56
 	llgh	%r7,__LC_SVC_INT_CODE
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2005-06-23 18:57:54.000000000 +0200
@@ -7,6 +7,7 @@
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Hartmut Penner (hp@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
 #include <linux/sys.h>
@@ -49,9 +50,9 @@ SP_ILC       =  STACK_FRAME_OVERHEAD + _
 SP_TRAP      =  STACK_FRAME_OVERHEAD + __PT_TRAP
 SP_SIZE      =  STACK_FRAME_OVERHEAD + __PT_SIZE
 
-_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
+_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING | \
 		 _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
-_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
+_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_MCCK_PENDING)
 
 STACK_SHIFT = PAGE_SHIFT + THREAD_ORDER
 STACK_SIZE  = 1 << STACK_SHIFT
@@ -121,7 +122,11 @@ STACK_SIZE  = 1 << STACK_SHIFT
 	bz	BASED(stack_overflow)
 3:
 #endif
-2:	s	%r15,BASED(.Lc_spsize)	# make room for registers & psw
+2:
+	.endm
+
+	.macro  CREATE_STACK_FRAME psworg,savearea
+	s	%r15,BASED(.Lc_spsize)	# make room for registers & psw
 	mvc	SP_PSW(8,%r15),0(%r12)	# move user PSW to stack
 	la	%r12,\psworg
 	st	%r2,SP_ORIG_R2(%r15)	# store original content of gpr 2
@@ -161,6 +166,13 @@ __switch_to_base:
         be      __switch_to_noper-__switch_to_base(%r1)	# we got away w/o bashing TLB's
         lctl    %c9,%c11,__THREAD_per(%r3)	# Nope we didn't
 __switch_to_noper:
+	l	%r4,__THREAD_info(%r2)		# get thread_info of prev
+	tm	__TI_flags+3(%r4),_TIF_MCCK_PENDING # machine check pending?
+	bz	__switch_to_no_mcck-__switch_to_base(%r1)
+	ni	__TI_flags+3(%r4),255-_TIF_MCCK_PENDING # clear flag in prev
+	l	%r4,__THREAD_info(%r3)		# get thread_info of next
+	oi	__TI_flags+3(%r4),_TIF_MCCK_PENDING # set it in next
+__switch_to_no_mcck:
         stm     %r6,%r15,__SF_GPRS(%r15)# store __switch_to registers of prev task
 	st	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	l	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
@@ -185,6 +197,7 @@ system_call:
 sysc_saveall:
 	SAVE_ALL_BASE __LC_SAVE_AREA
         SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	lh	%r7,0x8a	  # get svc number from lowcore
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 sysc_vtime:
@@ -234,6 +247,8 @@ sysc_work_loop:
 # One of the work bits is on. Find out which one.
 #
 sysc_work:
+	tm	__TI_flags+3(%r9),_TIF_MCCK_PENDING
+	bo	BASED(sysc_mcck_pending)
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bo	BASED(sysc_reschedule)
 	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
@@ -253,6 +268,14 @@ sysc_reschedule:        
 	br      %r1		       # call scheduler
 
 #
+# _TIF_MCCK_PENDING is set, call handler
+#
+sysc_mcck_pending:
+	l	%r1,BASED(.Ls390_handle_mcck)
+	la	%r14,BASED(sysc_work_loop)
+	br	%r1			# TIF bit will be cleared by handler
+
+#
 # _TIF_SIGPENDING is set, call do_signal
 #
 sysc_sigpending:     
@@ -430,6 +453,7 @@ pgm_check_handler:
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         bnz     BASED(pgm_per)           # got per exception -> special case
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	bz	BASED(pgm_no_vtime)
@@ -468,6 +492,7 @@ pgm_per:
 #
 pgm_per_std:
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_PGM_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	bz	BASED(pgm_no_vtime2)
@@ -493,6 +518,7 @@ pgm_no_vtime2:
 #
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	bz	BASED(pgm_no_vtime3)
@@ -521,6 +547,7 @@ io_int_handler:
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+16
         SAVE_ALL __LC_IO_OLD_PSW,__LC_SAVE_AREA+16,0
+	CREATE_STACK_FRAME __LC_IO_OLD_PSW,__LC_SAVE_AREA+16
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	bz	BASED(io_no_vtime)
@@ -578,9 +605,11 @@ io_work:
 	lr	%r15,%r1
 #
 # One of the work bits is on. Find out which one.
-# Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
+# Checked are: _TIF_SIGPENDING, _TIF_NEED_RESCHED and _TIF_MCCK_PENDING
 #
 io_work_loop:
+	tm	__TI_flags+3(%r9),_TIF_MCCK_PENDING
+	bo      BASED(io_mcck_pending)
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bo	BASED(io_reschedule)
 	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
@@ -588,6 +617,14 @@ io_work_loop:
 	b	BASED(io_leave)
 
 #
+# _TIF_MCCK_PENDING is set, call handler
+#
+io_mcck_pending:
+	l	%r1,BASED(.Ls390_handle_mcck)
+	l	%r14,BASED(io_work_loop)
+	br	%r1		       # TIF bit will be cleared by handler
+
+#
 # _TIF_NEED_RESCHED is set, call schedule
 #	
 io_reschedule:        
@@ -621,6 +658,7 @@ ext_int_handler:
 	stck	__LC_INT_CLOCK
 	SAVE_ALL_BASE __LC_SAVE_AREA+16
         SAVE_ALL __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16,0
+	CREATE_STACK_FRAME __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
 	bz	BASED(ext_no_vtime)
@@ -642,19 +680,62 @@ ext_no_vtime:
 
         .globl mcck_int_handler
 mcck_int_handler:
-	STORE_TIMER __LC_ASYNC_ENTER_TIMER
+	spt	__LC_CPU_TIMER_SAVE_AREA	# revalidate cpu timer
+	lm	%r0,%r15,__LC_GPREGS_SAVE_AREA	# revalidate gprs
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
-        SAVE_ALL __LC_MCK_OLD_PSW,__LC_SAVE_AREA+32,0
+	la	%r12,__LC_MCK_OLD_PSW
+	tm	__LC_MCCK_CODE,0x80     # system damage?
+	bo	BASED(mcck_int_main)	# yes -> rest of mcck code invalid
+	tm	__LC_MCCK_CODE+5,0x02   # stored cpu timer value valid?
+	bo	BASED(0f)
+	spt	__LC_LAST_UPDATE_TIMER	# revalidate cpu timer
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	tm	SP_PSW+1(%r15),0x01	# interrupting from user ?
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_EXIT_TIMER
+0:	tm	__LC_MCCK_CODE+2,0x08   # mwp of old psw valid?
+	bno	BASED(mcck_no_vtime)	# no -> skip cleanup critical
+	tm	__LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
 	bz	BASED(mcck_no_vtime)
 	UPDATE_VTIME __LC_EXIT_TIMER,__LC_ASYNC_ENTER_TIMER,__LC_USER_TIMER
 	UPDATE_VTIME __LC_LAST_UPDATE_TIMER,__LC_EXIT_TIMER,__LC_SYSTEM_TIMER
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
 mcck_no_vtime:
 #endif
+0:
+	tm	__LC_MCCK_CODE+2,0x09   # mwp + ia of old psw valid?
+	bno	BASED(mcck_int_main)	# no -> skip cleanup critical
+	tm	__LC_MCK_OLD_PSW+1,0x01	# test problem state bit
+	bnz	BASED(mcck_int_main)	# from user -> load async stack
+	clc	__LC_MCK_OLD_PSW+4(4),BASED(.Lcritical_end)
+	bhe	BASED(mcck_int_main)
+	clc	__LC_MCK_OLD_PSW+4(4),BASED(.Lcritical_start)
+	bl	BASED(mcck_int_main)
+	l	%r14,BASED(.Lcleanup_critical)
+	basr	%r14,%r14
+mcck_int_main:
+	l	%r14,__LC_PANIC_STACK	# are we already on the panic stack?
+	slr	%r14,%r15
+	sra	%r14,PAGE_SHIFT
+	be	BASED(0f)
+	l	%r15,__LC_PANIC_STACK	# load panic stack
+0:	CREATE_STACK_FRAME __LC_MCK_OLD_PSW,__LC_SAVE_AREA+32
+	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	la	%r2,SP_PTREGS(%r15)	# load pt_regs
 	l       %r1,BASED(.Ls390_mcck)
-	basr    %r14,%r1	  # call machine check handler
+	basr    %r14,%r1		# call machine check handler
+	tm      SP_PSW+1(%r15),0x01	# returning to user ?
+	bno	BASED(mcck_return)
+	l	%r1,__LC_KERNEL_STACK   # switch to kernel stack
+	s	%r1,BASED(.Lc_spsize)
+	mvc	SP_PTREGS(__PT_SIZE,%r1),SP_PTREGS(%r15)
+	xc      __SF_BACKCHAIN(4,%r1),__SF_BACKCHAIN(%r1) # clear back chain
+	lr	%r15,%r1
+	stosm	__SF_EMPTY(%r15),0x04	# turn dat on
+	tm	__TI_flags+3(%r9),_TIF_MCCK_PENDING
+	bno	BASED(mcck_return)
+	l	%r1,BASED(.Ls390_handle_mcck)
+	basr	%r14,%r1		# call machine check handler
 mcck_return:
         RESTORE_ALL 0
 
@@ -742,7 +823,7 @@ cleanup_critical:
 	clc	4(4,%r12),BASED(cleanup_table_sysc_work_loop)
 	bl	BASED(0f)
 	clc	4(4,%r12),BASED(cleanup_table_sysc_work_loop+4)
-	bl	BASED(cleanup_sysc_leave)
+	bl	BASED(cleanup_sysc_return)
 0:
 	br	%r14
 
@@ -760,6 +841,7 @@ cleanup_system_call:
 	mvc	__LC_SAVE_AREA(16),__LC_SAVE_AREA+16
 0:	st	%r13,__LC_SAVE_AREA+20
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
+	CREATE_STACK_FRAME __LC_SVC_OLD_PSW,__LC_SAVE_AREA
 	st	%r15,__LC_SAVE_AREA+28
 	lh	%r7,0x8a
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
@@ -834,6 +916,8 @@ cleanup_sysc_leave_insn:
  * Symbol constants
  */
 .Ls390_mcck:   .long  s390_do_machine_check
+.Ls390_handle_mcck:
+	       .long  s390_handle_mcck
 .Ldo_IRQ:      .long  do_IRQ
 .Ldo_extint:   .long  do_extint
 .Ldo_signal:   .long  do_signal
diff -urpN linux-2.6/arch/s390/kernel/process.c linux-2.6-patched/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/process.c	2005-06-23 18:57:54.000000000 +0200
@@ -91,13 +91,12 @@ void do_monitor_call(struct pt_regs *reg
 			    (void *)(long) smp_processor_id());
 }
 
+extern void s390_handle_mcck(void);
 /*
  * The idle loop on a S390...
  */
 void default_idle(void)
 {
-	psw_t wait_psw;
-	unsigned long reg;
 	int cpu, rc;
 
 	local_irq_disable();
@@ -125,38 +124,17 @@ void default_idle(void)
 		cpu_die();
 #endif
 
-	/* 
-	 * Wait for external, I/O or machine check interrupt and
-	 * switch off machine check bit after the wait has ended.
-	 */
-	wait_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK | PSW_MASK_WAIT |
-		PSW_MASK_IO | PSW_MASK_EXT;
-#ifndef CONFIG_ARCH_S390X
-	asm volatile (
-		"    basr %0,0\n"
-		"0:  la   %0,1f-0b(%0)\n"
-		"    st   %0,4(%1)\n"
-		"    oi   4(%1),0x80\n"
-		"    lpsw 0(%1)\n"
-		"1:  la   %0,2f-1b(%0)\n"
-		"    st   %0,4(%1)\n"
-		"    oi   4(%1),0x80\n"
-		"    ni   1(%1),0xf9\n"
-		"    lpsw 0(%1)\n"
-		"2:"
-		: "=&a" (reg) : "a" (&wait_psw) : "memory", "cc" );
-#else /* CONFIG_ARCH_S390X */
-	asm volatile (
-		"    larl  %0,0f\n"
-		"    stg   %0,8(%1)\n"
-		"    lpswe 0(%1)\n"
-		"0:  larl  %0,1f\n"
-		"    stg   %0,8(%1)\n"
-		"    ni    1(%1),0xf9\n"
-		"    lpswe 0(%1)\n"
-		"1:"
-		: "=&a" (reg) : "a" (&wait_psw) : "memory", "cc" );
-#endif /* CONFIG_ARCH_S390X */
+	local_mcck_disable();
+	if (test_thread_flag(TIF_MCCK_PENDING)) {
+		local_mcck_enable();
+		local_irq_enable();
+		s390_handle_mcck();
+		return;
+	}
+
+	/* Wait for external, I/O or machine check interrupt. */
+	__load_psw_mask(PSW_KERNEL_BITS | PSW_MASK_WAIT |
+			PSW_MASK_IO | PSW_MASK_EXT);
 }
 
 void cpu_idle(void)
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-06-23 18:57:54.000000000 +0200
@@ -414,7 +414,8 @@ setup_lowcore(void)
 	lc->program_new_psw.mask = PSW_KERNEL_BITS;
 	lc->program_new_psw.addr =
 		PSW_ADDR_AMODE | (unsigned long)pgm_check_handler;
-	lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
+	lc->mcck_new_psw.mask =
+		PSW_KERNEL_BITS & ~PSW_MASK_MCHECK & ~PSW_MASK_DAT;
 	lc->mcck_new_psw.addr =
 		PSW_ADDR_AMODE | (unsigned long) mcck_int_handler;
 	lc->io_new_psw.mask = PSW_KERNEL_BITS;
@@ -424,12 +425,18 @@ setup_lowcore(void)
 	lc->kernel_stack = ((unsigned long) &init_thread_union) + THREAD_SIZE;
 	lc->async_stack = (unsigned long)
 		__alloc_bootmem(ASYNC_SIZE, ASYNC_SIZE, 0) + ASYNC_SIZE;
-#ifdef CONFIG_CHECK_STACK
 	lc->panic_stack = (unsigned long)
 		__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0) + PAGE_SIZE;
-#endif
 	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
 	lc->thread_info = (unsigned long) &init_thread_union;
+#ifndef CONFIG_ARCH_S390X
+	if (MACHINE_HAS_IEEE) {
+		lc->extended_save_area_addr = (__u32)
+			__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0);
+		/* enable extended save area */
+		ctl_set_bit(14, 29);
+	}
+#endif
 #ifdef CONFIG_ARCH_S390X
 	if (MACHINE_HAS_DIAG44)
 		lc->diag44_opcode = 0x83000044;
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2005-06-23 18:57:54.000000000 +0200
@@ -771,13 +771,24 @@ void __init smp_prepare_cpus(unsigned in
 
 		*(lowcore_ptr[i]) = S390_lowcore;
 		lowcore_ptr[i]->async_stack = stack + (ASYNC_SIZE);
-#ifdef CONFIG_CHECK_STACK
 		stack = __get_free_pages(GFP_KERNEL,0);
 		if (stack == 0ULL)
 			panic("smp_boot_cpus failed to allocate memory\n");
 		lowcore_ptr[i]->panic_stack = stack + (PAGE_SIZE);
+#ifndef __s390x__
+		if (MACHINE_HAS_IEEE) {
+			lowcore_ptr[i]->extended_save_area_addr =
+				(__u32) __get_free_pages(GFP_KERNEL,0);
+			if (lowcore_ptr[i]->extended_save_area_addr == 0)
+				panic("smp_boot_cpus failed to "
+				      "allocate memory\n");
+		}
 #endif
 	}
+#ifndef __s390x__
+	if (MACHINE_HAS_IEEE)
+		ctl_set_bit(14, 29); /* enable extended save area */
+#endif
 	set_prefix((u32)(unsigned long) lowcore_ptr[smp_processor_id()]);
 
 	for_each_cpu(cpu)
diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/s390mach.c	2005-06-23 18:57:54.000000000 +0200
@@ -31,14 +31,14 @@ extern void css_reiterate_subchannels(vo
 extern struct workqueue_struct *slow_path_wq;
 extern struct work_struct slow_path_work;
 
-static void
+static NORET_TYPE void
 s390_handle_damage(char *msg)
 {
-	printk(KERN_EMERG "%s\n", msg);
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
 	disabled_wait((unsigned long) __builtin_return_address(0));
+	for(;;);
 }
 
 /*
@@ -122,40 +122,39 @@ repeat:
 	return 0;
 }
 
+struct mcck_struct {
+	int kill_task;
+	int channel_report;
+	int warning;
+	unsigned long long mcck_code;
+};
+
+static DEFINE_PER_CPU(struct mcck_struct, cpu_mcck);
+
 /*
- * machine check handler.
+ * Main machine check handler function. Will be called with interrupts enabled
+ * or disabled and machine checks enabled or disabled.
  */
 void
-s390_do_machine_check(void)
+s390_handle_mcck(void)
 {
-	struct mci *mci;
-
-	mci = (struct mci *) &S390_lowcore.mcck_interruption_code;
-
-	if (mci->sd)		/* system damage */
-		s390_handle_damage("received system damage machine check\n");
-
-	if (mci->pd)		/* instruction processing damage */
-		s390_handle_damage("received instruction processing "
-				   "damage machine check\n");
-
-	if (mci->se)		/* storage error uncorrected */
-		s390_handle_damage("received storage error uncorrected "
-				   "machine check\n");
+	unsigned long flags;
+	struct mcck_struct mcck;
 
-	if (mci->sc)		/* storage error corrected */
-		printk(KERN_WARNING
-		       "received storage error corrected machine check\n");
+	/*
+	 * Disable machine checks and get the current state of accumulated
+	 * machine checks. Afterwards delete the old state and enable machine
+	 * checks again.
+	 */
+	local_irq_save(flags);
+	local_mcck_disable();
+	mcck = __get_cpu_var(cpu_mcck);
+	memset(&__get_cpu_var(cpu_mcck), 0, sizeof(struct mcck_struct));
+	clear_thread_flag(TIF_MCCK_PENDING);
+	local_mcck_enable();
+	local_irq_restore(flags);
 
-	if (mci->ke)		/* storage key-error uncorrected */
-		s390_handle_damage("received storage key-error uncorrected "
-				   "machine check\n");
-
-	if (mci->ds && mci->fa)	/* storage degradation */
-		s390_handle_damage("received storage degradation machine "
-				   "check\n");
-
-	if (mci->cp)		/* channel report word pending */
+	if (mcck.channel_report)
 		up(&m_sem);
 
 #ifdef CONFIG_MACHCHK_WARNING
@@ -168,7 +167,7 @@ s390_do_machine_check(void)
  * On VM we only get one interrupt per virtally presented machinecheck.
  * Though one suffices, we may get one interrupt per (virtual) processor.
  */
-	if (mci->w) {	/* WARNING pending ? */
+	if (mcck.warning) {	/* WARNING pending ? */
 		static int mchchk_wng_posted = 0;
 		/*
 		 * Use single machine clear, as we cannot handle smp right now
@@ -178,6 +177,261 @@ s390_do_machine_check(void)
 			kill_proc(1, SIGPWR, 1);
 	}
 #endif
+
+	if (mcck.kill_task) {
+		local_irq_enable();
+		printk(KERN_EMERG "mcck: Terminating task because of machine "
+		       "malfunction (code 0x%016llx).\n", mcck.mcck_code);
+		printk(KERN_EMERG "mcck: task: %s, pid: %d.\n",
+		       current->comm, current->pid);
+		do_exit(SIGSEGV);
+	}
+}
+
+/*
+ * returns 0 if all registers could be validated
+ * returns 1 otherwise
+ */
+static int
+s390_revalidate_registers(struct mci *mci)
+{
+	int kill_task;
+	u64 tmpclock;
+	u64 zero;
+	void *fpt_save_area, *fpt_creg_save_area;
+
+	kill_task = 0;
+	zero = 0;
+	/* General purpose registers */
+	if (!mci->gr)
+		/*
+		 * General purpose registers couldn't be restored and have
+		 * unknown contents. Process needs to be terminated.
+		 */
+		kill_task = 1;
+
+	/* Revalidate floating point registers */
+	if (!mci->fp)
+		/*
+		 * Floating point registers can't be restored and
+		 * therefore the process needs to be terminated.
+		 */
+		kill_task = 1;
+
+#ifndef __s390x__
+	asm volatile("ld 0,0(%0)\n"
+		     "ld 2,8(%0)\n"
+		     "ld 4,16(%0)\n"
+		     "ld 6,24(%0)"
+		     : : "a" (&S390_lowcore.floating_pt_save_area));
+#endif
+
+	if (MACHINE_HAS_IEEE) {
+#ifdef __s390x__
+		fpt_save_area = &S390_lowcore.floating_pt_save_area;
+		fpt_creg_save_area = &S390_lowcore.fpt_creg_save_area;
+#else
+		fpt_save_area = (void *) S390_lowcore.extended_save_area_addr;
+		fpt_creg_save_area = fpt_save_area+128;
+#endif
+		/* Floating point control register */
+		if (!mci->fc) {
+			/*
+			 * Floating point control register can't be restored.
+			 * Task will be terminated.
+			 */
+			asm volatile ("lfpc 0(%0)" : : "a" (&zero));
+			kill_task = 1;
+
+		}
+		else
+			asm volatile (
+				"lfpc 0(%0)"
+				: : "a" (fpt_creg_save_area));
+
+		asm volatile("ld  0,0(%0)\n"
+			     "ld  1,8(%0)\n"
+			     "ld  2,16(%0)\n"
+			     "ld  3,24(%0)\n"
+			     "ld  4,32(%0)\n"
+			     "ld  5,40(%0)\n"
+			     "ld  6,48(%0)\n"
+			     "ld  7,56(%0)\n"
+			     "ld  8,64(%0)\n"
+			     "ld  9,72(%0)\n"
+			     "ld 10,80(%0)\n"
+			     "ld 11,88(%0)\n"
+			     "ld 12,96(%0)\n"
+			     "ld 13,104(%0)\n"
+			     "ld 14,112(%0)\n"
+			     "ld 15,120(%0)\n"
+			     : : "a" (fpt_save_area));
+	}
+
+	/* Revalidate access registers */
+	asm volatile("lam 0,15,0(%0)"
+		     : : "a" (&S390_lowcore.access_regs_save_area));
+	if (!mci->ar)
+		/*
+		 * Access registers have unknown contents.
+		 * Terminating task.
+		 */
+		kill_task = 1;
+
+	/* Revalidate control registers */
+	if (!mci->cr)
+		/*
+		 * Control registers have unknown contents.
+		 * Can't recover and therefore stopping machine.
+		 */
+		s390_handle_damage("invalid control registers.");
+	else
+#ifdef __s390x__
+		asm volatile("lctlg 0,15,0(%0)"
+			     : : "a" (&S390_lowcore.cregs_save_area));
+#else
+		asm volatile("lctl 0,15,0(%0)"
+			     : : "a" (&S390_lowcore.cregs_save_area));
+#endif
+
+	/*
+	 * We don't even try to revalidate the TOD register, since we simply
+	 * can't write something sensible into that register.
+	 */
+
+#ifdef __s390x__
+	/*
+	 * See if we can revalidate the TOD programmable register with its
+	 * old contents (should be zero) otherwise set it to zero.
+	 */
+	if (!mci->pr)
+		asm volatile("sr 0,0\n"
+			     "sckpf"
+			     : : : "0", "cc");
+	else
+		asm volatile(
+			"l 0,0(%0)\n"
+			"sckpf"
+			: : "a" (&S390_lowcore.tod_progreg_save_area) : "0", "cc");
+#endif
+
+	/* Revalidate clock comparator register */
+	asm volatile ("stck 0(%1)\n"
+		      "sckc 0(%1)"
+		      : "=m" (tmpclock) : "a" (&(tmpclock)) : "cc", "memory");
+
+	/* Check if old PSW is valid */
+	if (!mci->wp)
+		/*
+		 * Can't tell if we come from user or kernel mode
+		 * -> stopping machine.
+		 */
+		s390_handle_damage("old psw invalid.");
+
+	if (!mci->ms || !mci->pm || !mci->ia)
+		kill_task = 1;
+
+	return kill_task;
+}
+
+/*
+ * machine check handler.
+ */
+void
+s390_do_machine_check(struct pt_regs *regs)
+{
+	struct mci *mci;
+	struct mcck_struct *mcck;
+	int umode;
+
+	mci = (struct mci *) &S390_lowcore.mcck_interruption_code;
+	mcck = &__get_cpu_var(cpu_mcck);
+	umode = user_mode(regs);
+
+	if (mci->sd)
+		/* System damage -> stopping machine */
+		s390_handle_damage("received system damage machine check.");
+
+	if (mci->pd) {
+		if (mci->b) {
+			/* Processing backup -> verify if we can survive this */
+			u64 z_mcic, o_mcic, t_mcic;
+#ifdef __s390x__
+			z_mcic = (1ULL<<63 | 1ULL<<59 | 1ULL<<29);
+			o_mcic = (1ULL<<43 | 1ULL<<42 | 1ULL<<41 | 1ULL<<40 |
+				  1ULL<<36 | 1ULL<<35 | 1ULL<<34 | 1ULL<<32 |
+				  1ULL<<30 | 1ULL<<21 | 1ULL<<20 | 1ULL<<17 |
+				  1ULL<<16);
+#else
+			z_mcic = (1ULL<<63 | 1ULL<<59 | 1ULL<<57 | 1ULL<<50 |
+				  1ULL<<29);
+			o_mcic = (1ULL<<43 | 1ULL<<42 | 1ULL<<41 | 1ULL<<40 |
+				  1ULL<<36 | 1ULL<<35 | 1ULL<<34 | 1ULL<<32 |
+				  1ULL<<30 | 1ULL<<20 | 1ULL<<17 | 1ULL<<16);
+#endif
+			t_mcic = *(u64 *)mci;
+
+			if (((t_mcic & z_mcic) != 0) ||
+			    ((t_mcic & o_mcic) != o_mcic)) {
+				s390_handle_damage("processing backup machine "
+						   "check with damage.");
+			}
+			if (!umode)
+				s390_handle_damage("processing backup machine "
+						   "check in kernel mode.");
+			mcck->kill_task = 1;
+			mcck->mcck_code = *(unsigned long long *) mci;
+		}
+		else {
+			/* Processing damage -> stopping machine */
+			s390_handle_damage("received instruction processing "
+					   "damage machine check.");
+		}
+	}
+	if (s390_revalidate_registers(mci)) {
+		if (umode) {
+			/*
+			 * Couldn't restore all register contents while in
+			 * user mode -> mark task for termination.
+			 */
+			mcck->kill_task = 1;
+			mcck->mcck_code = *(unsigned long long *) mci;
+			set_thread_flag(TIF_MCCK_PENDING);
+		}
+		else
+			/*
+			 * Couldn't restore all register contents while in
+			 * kernel mode -> stopping machine.
+			 */
+			s390_handle_damage("unable to revalidate registers.");
+	}
+
+	if (mci->se)
+		/* Storage error uncorrected */
+		s390_handle_damage("received storage error uncorrected "
+				   "machine check.");
+
+	if (mci->ke)
+		/* Storage key-error uncorrected */
+		s390_handle_damage("received storage key-error uncorrected "
+				   "machine check.");
+
+	if (mci->ds && mci->fa)
+		/* Storage degradation */
+		s390_handle_damage("received storage degradation machine "
+				   "check.");
+
+	if (mci->cp) {
+		/* Channel report word pending */
+		mcck->channel_report = 1;
+		set_thread_flag(TIF_MCCK_PENDING);
+	}
+
+	if (mci->w) {
+		/* Warning pending */
+		mcck->warning = 1;
+		set_thread_flag(TIF_MCCK_PENDING);
+	}
 }
 
 /*
@@ -189,9 +443,8 @@ static int
 machine_check_init(void)
 {
 	init_MUTEX_LOCKED(&m_sem);
-	ctl_clear_bit(14, 25);	/* disable damage MCH */
-	ctl_set_bit(14, 26);	/* enable degradation MCH */
-	ctl_set_bit(14, 27);	/* enable system recovery MCH */
+	ctl_clear_bit(14, 25);	/* disable external damage MCH */
+	ctl_set_bit(14, 27);    /* enable system recovery MCH */
 #ifdef CONFIG_MACHCHK_WARNING
 	ctl_set_bit(14, 24);	/* enable warning MCH */
 #endif
diff -urpN linux-2.6/drivers/s390/s390mach.h linux-2.6-patched/drivers/s390/s390mach.h
--- linux-2.6/drivers/s390/s390mach.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/s390mach.h	2005-06-23 18:57:54.000000000 +0200
@@ -16,20 +16,45 @@ struct mci {
 	__u32   sd              :  1; /* 00 system damage */
 	__u32   pd              :  1; /* 01 instruction-processing damage */
 	__u32   sr              :  1; /* 02 system recovery */
-	__u32   to_be_defined_1 :  4; /* 03-06 */
+	__u32   to_be_defined_1 :  1; /* 03 */
+	__u32   cd              :  1; /* 04 timing-facility damage */
+	__u32   ed              :  1; /* 05 external damage */
+	__u32   to_be_defined_2 :  1; /* 06 */
 	__u32   dg              :  1; /* 07 degradation */
 	__u32   w               :  1; /* 08 warning pending */
 	__u32   cp              :  1; /* 09 channel-report pending */
-	__u32   to_be_defined_2 :  6; /* 10-15 */
+	__u32   sp              :  1; /* 10 service-processor damage */
+	__u32   ck              :  1; /* 11 channel-subsystem damage */
+	__u32   to_be_defined_3 :  2; /* 12-13 */
+	__u32   b               :  1; /* 14 backed up */
+	__u32   to_be_defined_4 :  1; /* 15 */
 	__u32   se              :  1; /* 16 storage error uncorrected */
 	__u32   sc              :  1; /* 17 storage error corrected */
 	__u32   ke              :  1; /* 18 storage-key error uncorrected */
 	__u32   ds              :  1; /* 19 storage degradation */
-	__u32	to_be_defined_3 :  4; /* 20-23 */
+	__u32   wp              :  1; /* 20 psw mwp validity */
+	__u32   ms              :  1; /* 21 psw mask and key validity */
+	__u32   pm              :  1; /* 22 psw program mask and cc validity */
+	__u32   ia              :  1; /* 23 psw instruction address validity */
 	__u32   fa              :  1; /* 24 failing storage address validity */
-	__u32   to_be_defined_4 :  7; /* 25-31 */
+	__u32   to_be_defined_5 :  1; /* 25 */
+	__u32   ec              :  1; /* 26 external damage code validity */
+	__u32   fp              :  1; /* 27 floating point register validity */
+	__u32   gr              :  1; /* 28 general register validity */
+	__u32   cr              :  1; /* 29 control register validity */
+	__u32   to_be_defined_6 :  1; /* 30 */
+	__u32   st              :  1; /* 31 storage logical validity */
 	__u32   ie              :  1; /* 32 indirect storage error */
-	__u32	to_be_defined_5 : 31; /* 33-63 */
+	__u32   ar              :  1; /* 33 access register validity */
+	__u32   da              :  1; /* 34 delayed access exception */
+	__u32   to_be_defined_7 :  7; /* 35-41 */
+	__u32   pr              :  1; /* 42 tod programmable register validity */
+	__u32   fc              :  1; /* 43 fp control register validity */
+	__u32   ap              :  1; /* 44 ancillary report */
+	__u32   to_be_defined_8 :  1; /* 45 */
+	__u32   ct              :  1; /* 46 cpu timer validity */
+	__u32   cc              :  1; /* 47 clock comparator validity */
+	__u32	to_be_defined_9 : 16; /* 47-63 */
 };
 
 /*
diff -urpN linux-2.6/include/asm-s390/lowcore.h linux-2.6-patched/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/lowcore.h	2005-06-23 18:57:54.000000000 +0200
@@ -109,10 +109,14 @@
 
 #ifndef __s390x__
 #define __LC_PFAULT_INTPARM             0x080
+#define __LC_CPU_TIMER_SAVE_AREA        0x0D8
 #define __LC_AREGS_SAVE_AREA            0x120
+#define __LC_GPREGS_SAVE_AREA           0x180
 #define __LC_CREGS_SAVE_AREA            0x1C0
 #else /* __s390x__ */
 #define __LC_PFAULT_INTPARM             0x11B8
+#define __LC_GPREGS_SAVE_AREA           0x1280
+#define __LC_CPU_TIMER_SAVE_AREA        0x1328
 #define __LC_AREGS_SAVE_AREA            0x1340
 #define __LC_CREGS_SAVE_AREA            0x1380
 #endif /* __s390x__ */
@@ -167,7 +171,8 @@ struct _lowcore
 	__u16        subchannel_nr;            /* 0x0ba */
 	__u32        io_int_parm;              /* 0x0bc */
 	__u32        io_int_word;              /* 0x0c0 */
-        __u8         pad3[0xD8-0xC4];          /* 0x0c4 */
+        __u8         pad3[0xD4-0xC4];          /* 0x0c4 */
+	__u32        extended_save_area_addr;  /* 0x0d4 */
 	__u32        cpu_timer_save_area[2];   /* 0x0d8 */
 	__u32        clock_comp_save_area[2];  /* 0x0e0 */
 	__u32        mcck_interruption_code[2]; /* 0x0e8 */
diff -urpN linux-2.6/include/asm-s390/processor.h linux-2.6-patched/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/processor.h	2005-06-23 18:57:54.000000000 +0200
@@ -207,6 +207,18 @@ unsigned long get_wchan(struct task_stru
 #endif /* __s390x__ */
 
 /*
+ * Set PSW to specified value.
+ */
+static inline void __load_psw(psw_t psw)
+{
+#ifndef __s390x__
+	asm volatile ("lpsw  0(%0)" : : "a" (&psw), "m" (psw) : "cc" );
+#else
+	asm volatile ("lpswe 0(%0)" : : "a" (&psw), "m" (psw) : "cc" );
+#endif
+}
+
+/*
  * Set PSW mask to specified value, while leaving the
  * PSW addr pointing to the next instruction.
  */
@@ -214,8 +226,8 @@ unsigned long get_wchan(struct task_stru
 static inline void __load_psw_mask (unsigned long mask)
 {
 	unsigned long addr;
-
 	psw_t psw;
+
 	psw.mask = mask;
 
 #ifndef __s390x__
@@ -241,30 +253,8 @@ static inline void __load_psw_mask (unsi
  */
 static inline void enabled_wait(void)
 {
-	unsigned long reg;
-	psw_t wait_psw;
-
-	wait_psw.mask = PSW_BASE_BITS | PSW_MASK_IO | PSW_MASK_EXT |
-		PSW_MASK_MCHECK | PSW_MASK_WAIT | PSW_DEFAULT_KEY;
-#ifndef __s390x__
-	asm volatile (
-		"    basr %0,0\n"
-		"0:  la   %0,1f-0b(%0)\n"
-		"    st   %0,4(%1)\n"
-		"    oi   4(%1),0x80\n"
-		"    lpsw 0(%1)\n"
-		"1:"
-		: "=&a" (reg) : "a" (&wait_psw), "m" (wait_psw)
-		: "memory", "cc" );
-#else /* __s390x__ */
-	asm volatile (
-		"    larl  %0,0f\n"
-		"    stg   %0,8(%1)\n"
-		"    lpswe 0(%1)\n"
-		"0:"
-		: "=&a" (reg) : "a" (&wait_psw), "m" (wait_psw)
-		: "memory", "cc" );
-#endif /* __s390x__ */
+	__load_psw_mask(PSW_BASE_BITS | PSW_MASK_IO | PSW_MASK_EXT |
+			PSW_MASK_MCHECK | PSW_MASK_WAIT | PSW_DEFAULT_KEY);
 }
 
 /*
@@ -273,13 +263,11 @@ static inline void enabled_wait(void)
 
 static inline void disabled_wait(unsigned long code)
 {
-        char psw_buffer[2*sizeof(psw_t)];
         unsigned long ctl_buf;
-        psw_t *dw_psw = (psw_t *)(((unsigned long) &psw_buffer+sizeof(psw_t)-1)
-                                  & -sizeof(psw_t));
+        psw_t dw_psw;
 
-        dw_psw->mask = PSW_BASE_BITS | PSW_MASK_WAIT;
-        dw_psw->addr = code;
+        dw_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
+        dw_psw.addr = code;
         /* 
          * Store status and then load disabled wait psw,
          * the processor is dead afterwards
@@ -301,7 +289,7 @@ static inline void disabled_wait(unsigne
                       "    oi    0x1c0,0x10\n" /* fake protection bit */
                       "    lpsw 0(%1)"
                       : "=m" (ctl_buf)
-		      : "a" (dw_psw), "a" (&ctl_buf), "m" (dw_psw) : "cc" );
+		      : "a" (&dw_psw), "a" (&ctl_buf), "m" (dw_psw) : "cc" );
 #else /* __s390x__ */
         asm volatile ("    stctg 0,0,0(%2)\n"
                       "    ni    4(%2),0xef\n" /* switch off protection */
@@ -333,7 +321,7 @@ static inline void disabled_wait(unsigne
                       "    oi    0x384(1),0x10\n" /* fake protection bit */
                       "    lpswe 0(%1)"
                       : "=m" (ctl_buf)
-		      : "a" (dw_psw), "a" (&ctl_buf),
+		      : "a" (&dw_psw), "a" (&ctl_buf),
 		        "m" (dw_psw) : "cc", "0", "1");
 #endif /* __s390x__ */
 }
diff -urpN linux-2.6/include/asm-s390/ptrace.h linux-2.6-patched/include/asm-s390/ptrace.h
--- linux-2.6/include/asm-s390/ptrace.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/ptrace.h	2005-06-23 18:57:54.000000000 +0200
@@ -276,7 +276,7 @@ typedef struct 
 #endif /* __s390x__ */
 
 #define PSW_KERNEL_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY | \
-			 PSW_DEFAULT_KEY)
+			 PSW_MASK_MCHECK | PSW_DEFAULT_KEY)
 #define PSW_USER_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
 			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
 			 PSW_MASK_PSTATE | PSW_DEFAULT_KEY)
diff -urpN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/system.h	2005-06-23 18:57:54.000000000 +0200
@@ -16,6 +16,7 @@
 #include <asm/types.h>
 #include <asm/ptrace.h>
 #include <asm/setup.h>
+#include <asm/processor.h>
 
 #ifdef __KERNEL__
 
@@ -331,9 +332,6 @@ __cmpxchg(volatile void *ptr, unsigned l
 
 #ifdef __s390x__
 
-#define __load_psw(psw) \
-        __asm__ __volatile__("lpswe 0(%0)" : : "a" (&psw), "m" (psw) : "cc" );
-
 #define __ctl_load(array, low, high) ({ \
 	typedef struct { char _[sizeof(array)]; } addrtype; \
 	__asm__ __volatile__ ( \
@@ -390,9 +388,6 @@ __cmpxchg(volatile void *ptr, unsigned l
 
 #else /* __s390x__ */
 
-#define __load_psw(psw) \
-	__asm__ __volatile__("lpsw 0(%0)" : : "a" (&psw) : "cc" );
-
 #define __ctl_load(array, low, high) ({ \
 	typedef struct { char _[sizeof(array)]; } addrtype; \
 	__asm__ __volatile__ ( \
@@ -451,6 +446,20 @@ __cmpxchg(volatile void *ptr, unsigned l
 /* For spinlocks etc */
 #define local_irq_save(x)	((x) = local_irq_disable())
 
+/*
+ * Use to set psw mask except for the first byte which
+ * won't be changed by this function.
+ */
+static inline void
+__set_psw_mask(unsigned long mask)
+{
+	local_save_flags(mask);
+	__load_psw_mask(mask);
+}
+
+#define local_mcck_enable()  __set_psw_mask(PSW_KERNEL_BITS)
+#define local_mcck_disable() __set_psw_mask(PSW_KERNEL_BITS & ~PSW_MASK_MCHECK)
+
 #ifdef CONFIG_SMP
 
 extern void smp_ctl_set_bit(int cr, int bit);
diff -urpN linux-2.6/include/asm-s390/thread_info.h linux-2.6-patched/include/asm-s390/thread_info.h
--- linux-2.6/include/asm-s390/thread_info.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/thread_info.h	2005-06-23 18:57:54.000000000 +0200
@@ -96,6 +96,7 @@ static inline struct thread_info *curren
 #define TIF_RESTART_SVC		4	/* restart svc with new svc number */
 #define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
 #define TIF_SINGLE_STEP		6	/* deliver sigtrap on return to user */
+#define TIF_MCCK_PENDING	7	/* machine check handling is pending */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
@@ -109,6 +110,7 @@ static inline struct thread_info *curren
 #define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLE_STEP	(1<<TIF_SINGLE_STEP)
+#define _TIF_MCCK_PENDING	(1<<TIF_MCCK_PENDING)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_31BIT		(1<<TIF_31BIT)
