Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbSIXR4h>; Tue, 24 Sep 2002 13:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261713AbSIXRZ6>; Tue, 24 Sep 2002 13:25:58 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:54172 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261725AbSIXRWn> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:43 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 11_preempt.
Date: Tue, 24 Sep 2002 19:20:22 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241920.22957.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for kernel preemption on s390/s390x.

diff -urN linux-2.5.38/arch/s390/config.in linux-2.5.38-s390/arch/s390/config.in
--- linux-2.5.38/arch/s390/config.in	Tue Sep 24 17:42:03 2002
+++ linux-2.5.38-s390/arch/s390/config.in	Tue Sep 24 17:42:43 2002
@@ -30,6 +30,7 @@
 fi
 
 comment 'Misc'
+bool 'Preemptible Kernel' CONFIG_PREEMPT
 bool 'Builtin IPL record support' CONFIG_IPL
 if [ "$CONFIG_IPL" = "y" ]; then
   choice 'IPL method generated into head.S' \
diff -urN linux-2.5.38/arch/s390/defconfig linux-2.5.38-s390/arch/s390/defconfig
--- linux-2.5.38/arch/s390/defconfig	Tue Sep 24 17:42:03 2002
+++ linux-2.5.38-s390/arch/s390/defconfig	Tue Sep 24 17:42:43 2002
@@ -50,6 +50,7 @@
 #
 # Misc
 #
+# CONFIG_PREEMPT is not set
 CONFIG_IPL=y
 # CONFIG_IPL_TAPE is not set
 CONFIG_IPL_VM=y
diff -urN linux-2.5.38/arch/s390/kernel/entry.S linux-2.5.38-s390/arch/s390/kernel/entry.S
--- linux-2.5.38/arch/s390/kernel/entry.S	Tue Sep 24 17:41:45 2002
+++ linux-2.5.38-s390/arch/s390/kernel/entry.S	Tue Sep 24 17:42:43 2002
@@ -49,7 +49,7 @@
 SP_TRAP      =  (SP_ORIG_R2+GPR_SIZE)
 SP_SIZE      =  (SP_TRAP+4)
 
-_TIF_WORK_MASK = (_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED)
+_TIF_WORK_MASK = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
 
 /*
  * Base Address of this Module --- saved in __LC_ENTRY_BASE
@@ -199,33 +199,44 @@
         RESTORE_ALL 1
 
 #
-# One of the work bits _TIF_NOTIFY_RESUME, _TIF_SIGPENDING or
-# _TIF_NEED_RESCHED is on. Find out which one.
+# recheck if there is more work to do
+#
+sysc_work_loop:
+	stnsm   24(%r15),0xfc     # disable I/O and ext. interrupts
+        GET_THREAD_INFO           # load pointer to task_struct to R9
+	tm	__TI_flags+3(%r9),_TIF_WORK_MASK
+	bz	BASED(sysc_leave)      # there is no work to do
+#
+# One of the work bits is on. Find out which one.
+# Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
 #
 sysc_work:
-        tm      SP_PSW+1(%r15),0x01 # returning to user ?
-        bno     BASED(sysc_leave) # no-> skip resched & signal
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bo	BASED(sysc_reschedule)
-	# add a test for TIF_NOTIFY_RESUME here when it is used.
-	# _TIF_SIGPENDING is the only flag left
-#
-# call do_signal before return
-#
-sysc_signal_return:     
-        la      %r2,SP_PTREGS(%r15) # load pt_regs
-        sr      %r3,%r3           # clear *oldset
-        l       %r1,BASED(.Ldo_signal)
-	la      %r14,BASED(sysc_return)
-        br      %r1               # return point is sysc_return
+	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
+	bo	BASED(sysc_sigpending)
+	b	BASED(sysc_leave)
 
 #
-# call schedule with sysc_return as return-address
-#
+# _TIF_NEED_RESCHED is set, call schedule
+#	
 sysc_reschedule:        
+        stosm   24(%r15),0x03          # reenable interrupts
         l       %r1,BASED(.Lschedule)
-	la      %r14,BASED(sysc_return)
-        br      %r1               # call scheduler, return to sysc_return
+	la      %r14,BASED(sysc_work_loop)
+	br      %r1		       # call scheduler
+
+#
+# _TIF_SIGPENDING is set, call do_signal
+#
+sysc_sigpending:     
+        stosm   24(%r15),0x03          # reenable interrupts
+        la      %r2,SP_PTREGS(%r15)    # load pt_regs
+        sr      %r3,%r3                # clear *oldset
+        l       %r1,BASED(.Ldo_signal)
+	basr	%r14,%r1               # call do_signal
+        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
+	b	BASED(sysc_leave)      # out of here, do NOT recheck
 
 #
 # call trace before and after sys_call
@@ -258,9 +269,7 @@
         basr    %r13,0
         l       %r13,.Lentry_base-.(%r13)  # setup base pointer to &entry_base
         GET_THREAD_INFO           # load pointer to task_struct to R9
-        sr      %r0,%r0           # child returns 0
-        st      %r0,SP_R2(%r15)   # store return value (change R2 on stack)
-#ifdef CONFIG_SMP
+#if CONFIG_SMP || CONFIG_PREEMPT
         l       %r1,BASED(.Lschedtail)
 	la      %r14,BASED(sysc_return)
         br      %r1               # call schedule_tail, return to sysc_return
@@ -616,13 +625,15 @@
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         bnz     BASED(pgm_per)           # got per exception -> special case
 	SAVE_ALL __LC_PGM_OLD_PSW,1
+	la	%r8,0x7f
+        l       %r3,__LC_PGM_ILC         # load program interruption code
         l       %r7,BASED(.Ljump_table)
-        lh      %r8,__LC_PGM_INT_CODE
+	nr	%r8,%r3
         sll     %r8,2
 	GET_THREAD_INFO
+        stosm   24(%r15),0x03            # reenable interrupts
         l       %r7,0(%r8,%r7)		 # load address of handler routine
         la      %r2,SP_PTREGS(%r15)	 # address of register-save area
-        l       %r3,__LC_PGM_ILC         # load program interruption code
 	la      %r14,BASED(sysc_return)
 	br      %r7			 # branch to interrupt-handler
 
@@ -647,6 +658,7 @@
 	GET_THREAD_INFO
 	la	%r4,0x7f
 	l	%r3,__LC_PGM_ILC	 # load program interruption code
+        stosm   24(%r15),0x03            # reenable interrupts
         nr      %r4,%r3                  # clear per-event-bit and ilc
         be      BASED(pgm_per_only)      # only per or per+check ?
         l       %r1,BASED(.Ljump_table)
@@ -666,9 +678,9 @@
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,1
         GET_THREAD_INFO           # load pointer to task_struct to R9
+        stosm   24(%r15),0x03     # reenable interrupts
 	lh	%r8,0x8a	  # get svc number from lowcore
         sll     %r8,2
-        stosm   24(%r15),0x03     # reenable interrupts
         l       %r8,sys_call_table-entry_base(%r8,%r13) # get system call addr.
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
         bo      BASED(pgm_tracesys)
@@ -732,59 +744,81 @@
         basr    %r14,%r1          # branch to standard irq handler
 
 io_return:
-#	
-# check, if bottom-half has to be done
-#
-        l       %r1,__TI_cpu(%r9)
-        sll     %r1,L1_CACHE_SHIFT
-        al      %r1,BASED(.Lirq_stat)  # get address of irq_stat
-        icm     %r0,15,0(%r1)          # test irq_stat[#cpu].__softirq_pending
-        bnz     BASED(io_handle_bottom_half)
-io_return_bh:
+        tm      SP_PSW+1(%r15),0x01    # returning to user ?
+#ifdef CONFIG_PREEMPT
+	bno     BASED(io_preempt)      # no -> check for preemptive scheduling
+#else
+        bno     BASED(io_leave)        # no-> skip resched & signal
+#endif
 	tm	__TI_flags+3(%r9),_TIF_WORK_MASK
 	bnz	BASED(io_work)         # there is work to do (signals etc.)
 io_leave:
-        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
         RESTORE_ALL 0
 
+#ifdef CONFIG_PREEMPT
+io_preempt:
+	icm	%r0,15,__TI_precount(%r9)
+	bnz     BASED(io_leave)
+io_resume_loop:
+	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
+	bno	BASED(io_leave)
+	mvc     __TI_precount(4,%r9),.Lc_pactive
+	# hmpf, we are on the async. stack but to call schedule
+	# we have to move the interrupt frame to the process stack
+	l	%r1,SP_R15(%r15)
+	s	%r1,BASED(.Lc_spsize)
+	n	%r1,BASED(.Lc0xfffffff8)
+	mvc	SP_PTREGS(SP_SIZE-SP_PTREGS,%r1),SP_PTREGS(%r15)
+        xc      0(4,%r1),0(%r1)        # clear back chain
+	lr	%r15,%r1
+        stosm   24(%r15),0x03          # reenable interrupts
+        l       %r1,BASED(.Lschedule)
+	basr	%r14,%r1	       # call schedule
+        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
+        GET_THREAD_INFO                # load pointer to task_struct to R9
+	xc      __TI_precount(4,%r9),__TI_precount(%r9)
+	b	BASED(io_resume_loop)
+#endif
+
 #
-# call do_softirq
+# recheck if there is more work to do
 #
-io_handle_bottom_half:
-        l       %r1,BASED(.Ldo_softirq)
-        la      %r14,BASED(io_return_bh)
-        br      %r1               # call do_softirq
-
+io_work_loop:
+        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
+        GET_THREAD_INFO                # load pointer to task_struct to R9
+	tm	__TI_flags+3(%r9),_TIF_WORK_MASK
+	bz	BASED(io_leave)        # there is no work to do
 #
-# One of the work bits _TIF_NOTIFY_RESUME, _TIF_SIGPENDING or
-# _TIF_NEED_RESCHED is on. Find out which one.
+# One of the work bits is on. Find out which one.
+# Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
 #
 io_work:
-        tm      SP_PSW+1(%r15),0x01    # returning to user ?
-        bno     BASED(io_leave)        # no-> skip resched & signal
-        stosm   24(%r15),0x03          # reenable interrupts
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bo	BASED(io_reschedule)
-	# add a test for TIF_NOTIFY_RESUME here when it is used.
-	# _TIF_SIGPENDING is the only flag left
+	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
+	bo	BASED(io_sigpending)
+	b	BASED(io_leave)
 
 #
-# call do_signal before return
-#
-io_signal_return:     
-        la      %r2,SP_PTREGS(%r15) # load pt_regs
-        sr      %r3,%r3           # clear *oldset
-        l       %r1,BASED(.Ldo_signal)
-	la      %r14,BASED(io_leave)
-        br      %r1               # return point is io_leave
+# _TIF_NEED_RESCHED is set, call schedule
+#	
+io_reschedule:        
+        stosm   24(%r15),0x03          # reenable interrupts
+        l       %r1,BASED(.Lschedule)
+	la      %r14,BASED(io_work_loop)
+	br      %r1		       # call scheduler
 
 #
-# call schedule with io_return as return-address
+# _TIF_SIGPENDING is set, call do_signal
 #
-io_reschedule:        
-        l       %r1,BASED(.Lschedule)
-	la      %r14,BASED(io_return)
-        br      %r1               # call scheduler, return to io_return
+io_sigpending:     
+        stosm   24(%r15),0x03          # reenable interrupts
+        la      %r2,SP_PTREGS(%r15)    # load pt_regs
+        sr      %r3,%r3                # clear *oldset
+        l       %r1,BASED(.Ldo_signal)
+	basr    %r14,%r1	       # call do_signal
+        stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
+	b	BASED(io_leave)        # out of here, do NOT recheck
 
 /*
  * External interrupt handler routine
@@ -865,19 +899,12 @@
                .align 4
 .Lc0xfffffff8: .long  -8           # to align stack pointer to 8
 .Lc0xffffe000: .long  -8192        # to round stack pointer to &task_struct
-.Lc8191:       .long  8191
 .Lc_spsize:    .long  SP_SIZE
 .Lc_overhead:  .long  STACK_FRAME_OVERHEAD
 .Lc_ac:        .long  0,0,1
 .Lc_ENOSYS:    .long  -ENOSYS
-.Lc4:          .long  4
-.Lc20:         .long  20
-.Lc0x1202:     .long  0x1202
-.Lc0x1004:     .long  0x1004
-.Lc0x2401:     .long  0x2401
-.Lc0x4000:     .long  0x4000
+.Lc_pactive:   .long  PREEMPT_ACTIVE
 .Lc0xff:       .long  0xff
-.Lc128:        .long  128
 .Lc256:        .long  256
 
 /*
@@ -890,7 +917,6 @@
 .Lentry_base:  .long  entry_base
 .Lext_hash:    .long  ext_int_hash
 .Lhandle_per:  .long  handle_per_exception
-.Lirq_stat:    .long  irq_stat
 .Ljump_table:  .long  pgm_check_table
 .Lschedule:    .long  schedule
 .Lclone:       .long  sys_clone
@@ -904,7 +930,7 @@
 .Lsigaltstack: .long  sys_sigaltstack
 .Ltrace:       .long  syscall_trace
 .Lvfork:       .long  sys_vfork
-#ifdef CONFIG_SMP
+#if CONFIG_SMP || CONFIG_PREEMPT
 .Lschedtail:   .long  schedule_tail
 #endif
 
diff -urN linux-2.5.38/arch/s390x/config.in linux-2.5.38-s390/arch/s390x/config.in
--- linux-2.5.38/arch/s390x/config.in	Tue Sep 24 17:42:03 2002
+++ linux-2.5.38-s390/arch/s390x/config.in	Tue Sep 24 17:42:43 2002
@@ -33,6 +33,7 @@
 fi
 
 comment 'Misc'
+bool 'Preemptible Kernel' CONFIG_PREEMPT
 bool 'Builtin IPL record support' CONFIG_IPL
 if [ "$CONFIG_IPL" = "y" ]; then
   choice 'IPL method generated into head.S' \
diff -urN linux-2.5.38/arch/s390x/defconfig linux-2.5.38-s390/arch/s390x/defconfig
--- linux-2.5.38/arch/s390x/defconfig	Tue Sep 24 17:42:03 2002
+++ linux-2.5.38-s390/arch/s390x/defconfig	Tue Sep 24 17:42:43 2002
@@ -51,6 +51,7 @@
 #
 # Misc
 #
+# CONFIG_PREEMPT is not set
 CONFIG_IPL=y
 # CONFIG_IPL_TAPE is not set
 CONFIG_IPL_VM=y
diff -urN linux-2.5.38/arch/s390x/kernel/entry.S linux-2.5.38-s390/arch/s390x/kernel/entry.S
--- linux-2.5.38/arch/s390x/kernel/entry.S	Tue Sep 24 17:41:45 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/entry.S	Tue Sep 24 17:42:43 2002
@@ -49,7 +49,7 @@
 SP_TRAP      =  (SP_ORIG_R2+GPR_SIZE)
 SP_SIZE      =  (SP_TRAP+4)
 
-_TIF_WORK_MASK = (_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED)
+_TIF_WORK_MASK = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
 
 /*
  * Register usage in interrupt handlers:
@@ -185,32 +185,42 @@
         RESTORE_ALL 1
 
 #
-# One of the work bits _TIF_NOTIFY_RESUME, _TIF_SIGPENDING or
-# _TIF_NEED_RESCHED is on. Find out which one.
+# recheck if there is more work to do
+#
+sysc_work_loop:
+	stnsm   48(%r15),0xfc     # disable I/O and ext. interrupts
+        GET_THREAD_INFO           # load pointer to task_struct to R9
+	tm	__TI_flags+7(%r9),_TIF_WORK_MASK
+	jz	sysc_leave        # there is no work to do
+#
+# One of the work bits is on. Find out which one.
+# Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
 #
 sysc_work:
-        tm      SP_PSW+1(%r15),0x01 # returning to user ?
-        jno     sysc_leave        # no-> skip resched & signal
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jo	sysc_reschedule
-	# add a test for TIF_NOTIFY_RESUME here when it is used.
-	# _TIF_SIGPENDING is the only flag left
+	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
+	jo	sysc_sigpending
+	j	sysc_leave
 
 #
-# call do_signal before return
-#
-sysc_signal_return:     
-        la      %r2,SP_PTREGS(%r15) # load pt_regs
-        sgr     %r3,%r3             # clear *oldset
-	larl    %r14,sysc_return
-	jg      do_signal           # return point is sysc_return
+# _TIF_NEED_RESCHED is set, call schedule
+#	
+sysc_reschedule:        
+	stosm   48(%r15),0x03     # reenable interrupts
+	larl    %r14,sysc_work_loop
+        jg      schedule            # return point is sysc_return
 
 #
-# call schedule with sysc_return as return-address
+# _TIF_SIGPENDING is set, call do_signal
 #
-sysc_reschedule:        
-	larl    %r14,sysc_return
-        jg      schedule            # return point is sysc_return
+sysc_sigpending:     
+	stosm   48(%r15),0x03     # reenable interrupts
+        la      %r2,SP_PTREGS(%r15) # load pt_regs
+        sgr     %r3,%r3           # clear *oldset
+	brasl	%r14,do_signal    # call do_signal
+	stnsm   48(%r15),0xfc     # disable I/O and ext. interrupts
+	j	sysc_leave        # out of here, do NOT recheck
 
 #
 # call syscall_trace before and after system call
@@ -242,8 +252,7 @@
         .globl  ret_from_fork
 ret_from_fork:  
         GET_THREAD_INFO           # load pointer to task_struct to R9
-	xc      SP_R2(8,%r15),SP_R2(%r15) # child returns 0
-#ifdef CONFIG_SMP
+#if CONFIG_SMP || CONFIG_PREEMPT
 	larl    %r14,sysc_return
         jg      schedule_tail     # return to sysc_return
 #else
@@ -551,8 +560,8 @@
         .long  SYSCALL(sys_rt_sigtimedwait,sys32_rt_sigtimedwait_wrapper)
         .long  SYSCALL(sys_rt_sigqueueinfo,sys32_rt_sigqueueinfo_wrapper)
         .long  SYSCALL(sys_rt_sigsuspend_glue,sys32_rt_sigsuspend_glue)
-        .long  SYSCALL(sys_pread64,sys32_pread_wrapper)           /* 180 */
-        .long  SYSCALL(sys_pwrite64,sys32_pwrite_wrapper)
+        .long  SYSCALL(sys_pread64,sys32_pread64_wrapper)           /* 180 */
+        .long  SYSCALL(sys_pwrite64,sys32_pwrite64_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys32_chown16_wrapper)    /* old chown16 syscall */
         .long  SYSCALL(sys_getcwd,sys32_getcwd_wrapper)
         .long  SYSCALL(sys_capget,sys32_capget_wrapper)
@@ -646,13 +655,15 @@
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         jnz     pgm_per                  # got per exception -> special case
 	SAVE_ALL __LC_PGM_OLD_PSW,1
-	llgh    %r8,__LC_PGM_INT_CODE
+	lghi	%r8,0x7f
+	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
+	ngr	%r8,%r3
         sll     %r8,3
 	GET_THREAD_INFO
+	stosm   48(%r15),0x03            # reenable interrupts
         larl    %r1,pgm_check_table
         lg      %r1,0(%r8,%r1)		 # load address of handler routine
         la      %r2,SP_PTREGS(%r15)	 # address of register-save area
-	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
 	larl	%r14,sysc_return
         br      %r1			 # branch to interrupt-handler
 
@@ -676,6 +687,7 @@
 	GET_THREAD_INFO
 	lghi    %r4,0x7f
 	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
+	stosm   48(%r15),0x03            # reenable interrupts
         nr      %r4,%r3			 # clear per-event-bit and ilc
         je      pgm_per_only		 # only per of per+check ?
         sll     %r4,3
@@ -759,57 +771,79 @@
 	brasl   %r14,do_IRQ            # call standard irq handler
 
 io_return:
-#
-# check, if bottom-half has to be done
-#
-        lgf     %r1,__TI_cpu(%r9)
-	larl    %r2,irq_stat
-	sll     %r1,L1_CACHE_SHIFT
-	la      %r1,0(%r1,%r2)
-	icm     %r0,15,0(%r1)          # test irq_stat[#cpu].__softirq_pending
-        jnz     io_handle_bottom_half
-io_return_bh:	
+        tm      SP_PSW+1(%r15),0x01    # returning to user ?
+#ifdef CONFIG_PREEMPT
+	jno     io_preempt             # no -> check for preemptive scheduling
+#else
+        jno     io_leave               # no-> skip resched & signal
+#endif
 	tm	__TI_flags+7(%r9),_TIF_WORK_MASK
 	jnz	io_work                # there is work to do (signals etc.)
 io_leave:
-        stnsm   48(%r15),0xfc          # disable I/O and ext. interrupts
         RESTORE_ALL 0
 
+#ifdef CONFIG_PREEMPT
+io_preempt:
+	icm	%r0,15,__TI_precount(%r9)	
+	jnz     io_leave
+io_resume_loop:
+	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
+	jno	io_leave
+	larl    %r1,.Lc_pactive
+	mvc     __TI_precount(4,%r9),0(%r1)
+	# hmpf, we are on the async. stack but to call schedule
+	# we have to move the interrupt frame to the process stack
+	lg	%r1,SP_R15(%r15)
+	aghi	%r1,-SP_SIZE
+	nill	%r1,0xfff8
+	mvc	SP_PTREGS(SP_SIZE-SP_PTREGS,%r1),SP_PTREGS(%r15)
+        xc      0(8,%r1),0(%r1)        # clear back chain
+	lgr	%r15,%r1
+        stosm   48(%r15),0x03          # reenable interrupts
+	brasl   %r14,schedule          # call schedule
+        stnsm   48(%r15),0xfc          # disable I/O and ext. interrupts
+        GET_THREAD_INFO                # load pointer to task_struct to R9
+	xc      __TI_precount(4,%r9),__TI_precount(%r9)
+	j	io_resume_loop
+#endif
+
 #
-# call do_softirq
+# recheck if there is more work to do
 #
-io_handle_bottom_half:        
-	larl    %r14,io_return_bh
-        jg      do_softirq             # return point is io_return_bh
-
+io_work_loop:
+        stnsm   48(%r15),0xfc          # disable I/O and ext. interrupts
+        GET_THREAD_INFO                # load pointer to task_struct to R9
+	tm	__TI_flags+7(%r9),_TIF_WORK_MASK
+	jz	io_leave               # there is no work to do
 #
-# One of the work bits _TIF_NOTIFY_RESUME, _TIF_SIGPENDING or
-# _TIF_NEED_RESCHED is on. Find out which one.
+# One of the work bits is on. Find out which one.
+# Checked are: _TIF_SIGPENDING and _TIF_NEED_RESCHED
 #
 io_work:
-        tm      SP_PSW+1(%r15),0x01    # returning to user ?
-        jno     io_leave               # no-> skip resched & signal
-        stosm   48(%r15),0x03          # reenable interrupts
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jo	io_reschedule
-	# add a test for TIF_NOTIFY_RESUME here when it is used.
-	# _TIF_SIGPENDING is the only flag left
+	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
+	jo	io_sigpending
+	j	io_leave
 
 #
-# call do_signal before return
-#
-io_signal_return:     
-        la      %r2,SP_PTREGS(%r15) # load pt_regs
-        slgr    %r3,%r3             # clear *oldset
-	larl    %r14,io_leave
-        jg      do_signal           # return point is io_leave
+# _TIF_NEED_RESCHED is set, call schedule
+#	
+io_reschedule:        
+        stosm   48(%r15),0x03       # reenable interrupts
+	larl    %r14,io_work_loop
+        jg      schedule            # call scheduler
 
 #
-# call schedule with io_return as return-address
+# _TIF_SIGPENDING is set, call do_signal
 #
-io_reschedule:        
-	larl    %r14,io_return
-        jg      schedule            # call scheduler, return to io_return
+io_sigpending:     
+        stosm   48(%r15),0x03       # reenable interrupts
+        la      %r2,SP_PTREGS(%r15) # load pt_regs
+        slgr    %r3,%r3             # clear *oldset
+	brasl	%r14,do_signal      # call do_signal
+        stnsm   48(%r15),0xfc       # disable I/O and ext. interrupts
+	j	sysc_leave          # out of here, do NOT recheck
 
 /*
  * External interrupt handler routine
@@ -883,4 +917,5 @@
  */
                .align 4
 .Lc_ac:        .long  0,0,1
+.Lc_pactive:   .long  PREEMPT_ACTIVE
 .Lc256:        .quad  256
diff -urN linux-2.5.38/include/asm-s390/hardirq.h linux-2.5.38-s390/include/asm-s390/hardirq.h
--- linux-2.5.38/include/asm-s390/hardirq.h	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/include/asm-s390/hardirq.h	Tue Sep 24 17:42:43 2002
@@ -80,15 +80,21 @@
 
 extern void do_call_softirq(void);
 
-#define in_atomic()	(preempt_count() != 0)
-#define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
+#if CONFIG_PREEMPT
+# define in_atomic()	(in_interrupt() || preempt_count() == PREEMPT_ACTIVE)
+# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
+#else
+# define in_atomic()	(preempt_count() != 0)
+# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
+#endif
 
 #define irq_exit()							\
 do {									\
-	preempt_count() -= HARDIRQ_OFFSET;				\
+	preempt_count() -= IRQ_EXIT_OFFSET;				\
 	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
 		/* Use the async. stack for softirq */			\
 		do_call_softirq();					\
+	preempt_enable_no_resched();					\
 } while (0)
 
 #ifndef CONFIG_SMP
diff -urN linux-2.5.38/include/asm-s390/softirq.h linux-2.5.38-s390/include/asm-s390/softirq.h
--- linux-2.5.38/include/asm-s390/softirq.h	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/include/asm-s390/softirq.h	Tue Sep 24 17:42:43 2002
@@ -10,6 +10,7 @@
 #define __ASM_SOFTIRQ_H
 
 #include <linux/smp.h>
+#include <linux/preempt.h>
 
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
@@ -28,6 +29,7 @@
 	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
 		/* Use the async. stack for softirq */			\
 		do_call_softirq();					\
+	preempt_check_resched();					\
 } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN linux-2.5.38/include/asm-s390/thread_info.h linux-2.5.38-s390/include/asm-s390/thread_info.h
--- linux-2.5.38/include/asm-s390/thread_info.h	Sun Sep 22 06:25:12 2002
+++ linux-2.5.38-s390/include/asm-s390/thread_info.h	Tue Sep 24 17:42:43 2002
@@ -25,11 +25,9 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned int		cpu;		/* current CPU */
-	int			preempt_count; /* 0 => preemptable, <0 => BUG */
+	unsigned int		preempt_count; /* 0 => preemptable */
 };
 
-#define PREEMPT_ACTIVE		0x4000000
-
 /*
  * macros/functions for gaining access to the thread information structure
  */
@@ -84,4 +82,6 @@
 
 #endif /* __KERNEL__ */
 
+#define PREEMPT_ACTIVE		0x4000000
+
 #endif /* _ASM_THREAD_INFO_H */
diff -urN linux-2.5.38/include/asm-s390x/hardirq.h linux-2.5.38-s390/include/asm-s390x/hardirq.h
--- linux-2.5.38/include/asm-s390x/hardirq.h	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/include/asm-s390x/hardirq.h	Tue Sep 24 17:42:43 2002
@@ -81,15 +81,21 @@
 
 extern void do_call_softirq(void);
 
-#define in_atomic()	(preempt_count() != 0)
-#define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
+#if CONFIG_PREEMPT
+# define in_atomic()	(in_interrupt() || preempt_count() == PREEMPT_ACTIVE)
+# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
+#else
+# define in_atomic()	(preempt_count() != 0)
+# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
+#endif
 
 #define irq_exit()							\
 do {									\
-	preempt_count() -= HARDIRQ_OFFSET;				\
+	preempt_count() -= IRQ_EXIT_OFFSET;				\
 	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
 		/* Use the async. stack for softirq */			\
 		do_call_softirq();					\
+	preempt_enable_no_resched();					\
 } while (0)
 
 #ifndef CONFIG_SMP
diff -urN linux-2.5.38/include/asm-s390x/thread_info.h linux-2.5.38-s390/include/asm-s390x/thread_info.h
--- linux-2.5.38/include/asm-s390x/thread_info.h	Sun Sep 22 06:25:16 2002
+++ linux-2.5.38-s390/include/asm-s390x/thread_info.h	Tue Sep 24 17:42:43 2002
@@ -25,11 +25,9 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned int		cpu;		/* current CPU */
-	int 			preempt_count; /* 0 => preemptable, <0 => BUG */
+	unsigned int		preempt_count;  /* 0 => preemptable */
 };
 
-#define PREEMPT_ACTIVE		0x4000000
-
 /*
  * macros/functions for gaining access to the thread information structure
  */
@@ -84,4 +82,6 @@
 
 #endif /* __KERNEL__ */
 
+#define PREEMPT_ACTIVE		0x4000000
+
 #endif /* _ASM_THREAD_INFO_H */

