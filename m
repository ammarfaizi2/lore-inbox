Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUFKRdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUFKRdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbUFKRc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:32:59 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:20721 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S264198AbUFKRcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:32:15 -0400
Date: Fri, 11 Jun 2004 19:32:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: simplify single stepped svc code.
Message-ID: <20040611173222.GC3279@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: simplify single stepped svc code.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Introduce a TIF_SINGLE_STEP bit that causes do_debugger_trap
to get called at the end of a system call. This way some code
duplication in the program check handler can get removed.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/entry.S       |   85 +++++++++------------------------------
 arch/s390/kernel/entry64.S     |   89 +++++++++--------------------------------
 include/asm-s390/thread_info.h |    2 
 3 files changed, 44 insertions(+), 132 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Fri Jun 11 19:09:20 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Fri Jun 11 19:09:55 2004
@@ -48,7 +48,8 @@
 SP_TRAP      =  STACK_FRAME_OVERHEAD + __PT_TRAP
 SP_SIZE      =  STACK_FRAME_OVERHEAD + __PT_SIZE
 
-_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
+_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
+		 _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
 
 #define BASED(name) name-system_call(%r13)
@@ -230,6 +231,7 @@
 	lh	%r7,0x8a	  # get svc number from lowcore
 sysc_enter:
         GET_THREAD_INFO           # load pointer to task_struct to R9
+sysc_do_svc:
 	sla	%r7,2             # *4 and test for svc 0
 	bnz	BASED(sysc_nr_ok) # svc number > 0
 	# svc 0: system call number in %r1
@@ -265,7 +267,6 @@
 	bz	BASED(sysc_leave)      # there is no work to do
 #
 # One of the work bits is on. Find out which one.
-# Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
 #
 sysc_work:
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
@@ -274,6 +275,8 @@
 	bo	BASED(sysc_sigpending)
 	tm	__TI_flags+3(%r9),_TIF_RESTART_SVC
 	bo	BASED(sysc_restart)
+	tm	__TI_flags+3(%r9),_TIF_SINGLE_STEP
+	bo	BASED(sysc_singlestep)
 	b	BASED(sysc_leave)
 
 #
@@ -307,6 +310,17 @@
 	lm	%r2,%r6,SP_R2(%r15)    # load svc arguments
 	b	BASED(sysc_do_restart) # restart svc
 
+#
+# _TIF_SINGLE_STEP is set, call do_debugger_trap
+#
+sysc_singlestep:
+	ni	__TI_flags+3(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
+	mvi	SP_TRAP+1(%r15),0x28	# set trap indication to pgm check
+	la	%r2,SP_PTREGS(%r15)	# address of register-save area
+	l	%r1,BASED(.Lhandle_per)	# load adr. of per handler
+	la	%r14,BASED(sysc_return)	# load adr. of system return
+	br	%r1			# branch to do_debugger_trap
+
 __critical_end:
 
 #
@@ -498,72 +512,15 @@
 #
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
-	lh	%r7,0x8a	  # get svc number from lowcore
-        GET_THREAD_INFO           # load pointer to task_struct to R9
+	lh	%r7,0x8a		# get svc number from lowcore
+	GET_THREAD_INFO			# load pointer to task_struct to R9
 	l	%r1,__TI_task(%r9)
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
-        stosm   24(%r15),0x03     # reenable interrupts
-        sla     %r7,2             # *4 and test for svc 0
-	bnz	BASED(pgm_svcstd) # svc number > 0 ?
-	# svc 0: system call number in %r1
-	cl	%r1,BASED(.Lnr_syscalls)
-	bnl	BASED(pgm_svcstd)
-	lr	%r7,%r1           # copy svc number to %r7
-	sla	%r7,2             # *4
-pgm_svcstd:
-	mvc	SP_ARGS(4,%r15),SP_R7(%r15)
-	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        l       %r8,sys_call_table-system_call(%r7,%r13) # get system call addr.
-        bnz     BASED(pgm_tracesys)
-        basr    %r14,%r8          # call sys_xxxx
-        st      %r2,SP_R2(%r15)   # store return value (change R2 on stack)
-                                  # ATTENTION: check sys_execve_glue before
-                                  # changing anything here !!
-
-pgm_svcret:
-	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
-	bno	BASED(pgm_svcper_nosig)
-	la	%r2,SP_PTREGS(%r15) # load pt_regs
-	sr	%r3,%r3		  # clear *oldset
-	l	%r1,BASED(.Ldo_signal)
-	basr	%r14,%r1	  # call do_signal
-	
-pgm_svcper_nosig:
-        mvi     SP_TRAP+3(%r15),0x28     # set trap indication to pgm check
-	la      %r2,SP_PTREGS(15)        # address of register-save area
-        l       %r1,BASED(.Lhandle_per)  # load adr. of per handler
-        la      %r14,BASED(sysc_return)  # load adr. of system return
-        br      %r1                      # branch to do_debugger_trap
-#
-# call trace before and after sys_call
-#
-pgm_tracesys:
-        l       %r1,BASED(.Ltrace)
-	la	%r2,SP_PTREGS(%r15)    # load pt_regs
-	la	%r3,0
-	srl	%r7,2
-	st	%r7,SP_R2(%r15)
-        basr    %r14,%r1
-	clc	SP_R2(4,%r15),BASED(.Lnr_syscalls)
-	bnl	BASED(pgm_svc_nogo)
-	l	%r7,SP_R2(%r15)   # strace changed the syscall
-	sll     %r7,2
-	l	%r8,sys_call_table-system_call(%r7,%r13)
-pgm_svc_go:
-	lm      %r3,%r6,SP_R3(%r15)
-	l       %r2,SP_ORIG_R2(%r15)
-        basr    %r14,%r8          # call sys_xxx
-        st      %r2,SP_R2(%r15)   # store return value
-pgm_svc_nogo:
-	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        bz      BASED(pgm_svcret)
-        l       %r1,BASED(.Ltrace)
-	la	%r2,SP_PTREGS(%r15)    # load pt_regs
-	la	%r3,1
-	la	%r14,BASED(pgm_svcret)
-        br      %r1
+	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
+	stosm	24(%r15),0x03		# reenable interrupts
+	b	BASED(sysc_do_svc)
 
 /*
  * IO interrupt handler routine
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Fri Jun 11 19:09:20 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Fri Jun 11 19:09:55 2004
@@ -48,7 +48,8 @@
 SP_TRAP      =  STACK_FRAME_OVERHEAD + __PT_TRAP
 SP_SIZE      =  STACK_FRAME_OVERHEAD + __PT_SIZE
 
-_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
+_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
+		 _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
 
 /*
@@ -214,6 +215,7 @@
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
 sysc_enter:
         GET_THREAD_INFO           # load pointer to task_struct to R9
+sysc_do_svc:
         slag    %r7,%r7,2         # *4 and test for svc 0
 	jnz	sysc_nr_ok
 	# svc 0: system call number in %r1
@@ -257,7 +259,6 @@
 	jz	sysc_leave        # there is no work to do
 #
 # One of the work bits is on. Find out which one.
-# Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
 #
 sysc_work:
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
@@ -266,6 +267,8 @@
 	jo	sysc_sigpending
 	tm	__TI_flags+7(%r9),_TIF_RESTART_SVC
 	jo	sysc_restart
+	tm	__TI_flags+7(%r9),_TIF_SINGLE_STEP
+	jo	sysc_singlestep
 	j	sysc_leave
 
 #
@@ -297,6 +300,17 @@
 	lmg	%r2,%r6,SP_R2(%r15)    # load svc arguments
 	j	sysc_do_restart        # restart svc
 
+#
+# _TIF_SINGLE_STEP is set, call do_debugger_trap
+#
+sysc_singlestep:
+	ni	__TI_flags+7(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
+	mvi	SP_TRAP+1(%r15),0x28	# set trap indication to pgm check
+	la	%r2,SP_PTREGS(%r15)	# address of register-save area
+	larl	%r14,sysc_return	# load adr. of system return
+	jg	do_debugger_trap	# branch to do_debugger_trap
+
+
 __critical_end:
 
 #
@@ -531,76 +545,15 @@
 #
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
-	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
-        GET_THREAD_INFO           # load pointer to task_struct to R9
+	llgh    %r7,__LC_SVC_INT_CODE	# get svc number from lowcore
+	GET_THREAD_INFO			# load pointer to task_struct to R9
 	lg	%r1,__TI_task(%r9)
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
-	stosm   48(%r15),0x03     # reenable interrupts
-	slag	%r7,%r7,2         # *4 and test for svc 0
-	jnz	pgm_svcstd
-	# svc 0: system call number in %r1
-	lghi	%r0,NR_syscalls
-	clr	%r1,%r0
-	slag	%r7,%r1,2
-pgm_svcstd:
-	mvc	SP_ARGS(8,%r15),SP_R7(%r15)
-	larl    %r10,sys_call_table
-#ifdef CONFIG_S390_SUPPORT
-        tm      SP_PSW+3(%r15),0x01  # are we running in 31 bit mode ?
-        jo      pgm_svcper_noemu
-	larl    %r10,sys_call_table_emu # use 31 bit emulation system calls
-pgm_svcper_noemu:
-#endif
-	tm	__TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        lgf     %r8,0(%r7,%r10)   # load address of system call routine
-        jnz     pgm_tracesys
-        basr    %r14,%r8          # call sys_xxxx
-        stg     %r2,SP_R2(%r15)   # store return value (change R2 on stack)
-                                  # ATTENTION: check sys_execve_glue before
-                                  # changing anything here !!
-
-pgm_svcret:
-	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
-	jno	pgm_svcper_nosig
-        la      %r2,SP_PTREGS(%r15) # load pt_regs
-        sgr     %r3,%r3             # clear *oldset
-	brasl	%r14,do_signal
-	
-pgm_svcper_nosig:
-	lhi     %r0,__LC_PGM_OLD_PSW     # set trap indication back to pgm_chk
-	st      %r0,SP_TRAP(%r15)
-        la      %r2,SP_PTREGS(15) # address of register-save area
-        larl    %r14,sysc_return  # load adr. of system return
-        jg      do_debugger_trap
-#
-# call trace before and after sys_call
-#
-pgm_tracesys:
-	la	%r2,SP_PTREGS(%r15)    # load pt_regs
-	la	%r3,0
-	srlg	%r7,%r7,2
-	stg	%r7,SP_R2(%r15)
-        brasl   %r14,syscall_trace
-	lghi	%r0,NR_syscalls
-	clg	%r0,SP_R2(%r15)
-	jnh	pgm_svc_nogo
-	lg      %r7,SP_R2(%r15)
-	sllg    %r7,%r7,2           # strace wants to change the syscall
-	lgf	%r8,0(%r7,%r10)
-pgm_svc_go:
-	lmg     %r3,%r6,SP_R3(%r15)
-	lg      %r2,SP_ORIG_R2(%r15)
-        basr    %r14,%r8            # call sys_xxx
-        stg     %r2,SP_R2(%r15)     # store return value
-pgm_svc_nogo:
-	tm	__TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        jz      pgm_svcret
-	la	%r2,SP_PTREGS(%r15)    # load pt_regs
-	la	%r3,1
-	larl	%r14,pgm_svcret     # return point is sysc_return
-	jg	syscall_trace
+	oi	__TI_flags+7(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
+	stosm	48(%r15),0x03		# reenable interrupts
+	j	sysc_do_svc
 
 /*
  * IO interrupt handler routine
diff -urN linux-2.6/include/asm-s390/thread_info.h linux-2.6-s390/include/asm-s390/thread_info.h
--- linux-2.6/include/asm-s390/thread_info.h	Mon May 10 04:32:53 2004
+++ linux-2.6-s390/include/asm-s390/thread_info.h	Fri Jun 11 19:09:55 2004
@@ -85,6 +85,7 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTART_SVC		4	/* restart svc with new svc number */
 #define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
+#define TIF_SINGLE_STEP		6	/* single stepped svc */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
@@ -96,6 +97,7 @@
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SINGLE_STEP	(1<<TIF_SINGLE_STEP)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_31BIT		(1<<TIF_31BIT)
