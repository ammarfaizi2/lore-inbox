Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTGASc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTGASc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:32:26 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:27530 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263309AbTGAScK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:32:10 -0400
Date: Tue, 1 Jul 2003 20:45:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH] s390 (2/6): ptrace.
Message-ID: <20030701184526.GC12212@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ptrace system call number replacement code.

diffstat:
 arch/s390/kernel/entry.S   |    6 ++++--
 arch/s390/kernel/entry64.S |   22 ++++++++++++----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff -urN linux-2.5/arch/s390/kernel/entry.S linux-2.5-s390/arch/s390/kernel/entry.S
--- linux-2.5/arch/s390/kernel/entry.S	Sun Jun 22 20:32:35 2003
+++ linux-2.5-s390/arch/s390/kernel/entry.S	Tue Jul  1 20:48:26 2003
@@ -267,7 +267,7 @@
 	st	%r7,SP_R2(%r15)
 	basr	%r14,%r1
 	clc	SP_R2(4,%r15),BASED(.Lnr_syscalls)
-	bl	BASED(sysc_tracego)
+	bnl	BASED(sysc_tracenogo)
 	l	%r7,SP_R2(%r15)        # strace might have changed the 
 	sll	%r7,2                  #  system call
 	l	%r8,sys_call_table-entry_base(%r7,%r13)
@@ -276,6 +276,7 @@
 	l	%r2,SP_ORIG_R2(%r15)
 	basr	%r14,%r8          # call sys_xxx
 	st	%r2,SP_R2(%r15)   # store return value
+sysc_tracenogo:
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
         bno     BASED(sysc_return)
 	l	%r1,BASED(.Ltrace)
@@ -486,7 +487,7 @@
 	st	%r7,SP_R2(%r15)
         basr    %r14,%r1
 	clc	SP_R2(4,%r15),BASED(.Lnr_syscalls)
-	bl	BASED(pgm_svc_go)
+	bnl	BASED(pgm_svc_nogo)
 	l	%r7,SP_R2(%r15)   # strace changed the syscall
 	sll     %r7,2
 	l	%r8,sys_call_table-entry_base(%r7,%r13)
@@ -495,6 +496,7 @@
 	l       %r2,SP_ORIG_R2(%r15)
         basr    %r14,%r8          # call sys_xxx
         st      %r2,SP_R2(%r15)   # store return value
+pgm_svc_nogo:
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
         bno     BASED(pgm_svcret)
         l       %r1,BASED(.Ltrace)
diff -urN linux-2.5/arch/s390/kernel/entry64.S linux-2.5-s390/arch/s390/kernel/entry64.S
--- linux-2.5/arch/s390/kernel/entry64.S	Sun Jun 22 20:32:35 2003
+++ linux-2.5-s390/arch/s390/kernel/entry64.S	Tue Jul  1 20:48:26 2003
@@ -254,7 +254,7 @@
         brasl   %r14,syscall_trace
 	larl	%r1,.Lnr_syscalls
 	clc	SP_R2(8,%r15),0(%r1)
-	jl	sysc_tracego
+	jnl	sysc_tracenogo
 	lg	%r7,SP_R2(%r15)   # strace might have changed the
 	sll     %r7,2             #  system call
 	lgf	%r8,0(%r7,%r10)
@@ -263,6 +263,7 @@
 	lg      %r2,SP_ORIG_R2(%r15)
         basr    %r14,%r8            # call sys_xxx
         stg     %r2,SP_R2(%r15)     # store return value
+sysc_tracenogo:
 	tm	__TI_flags+7(%r9),_TIF_SYSCALL_TRACE
         jno     sysc_return
 	larl	%r14,sysc_return    # return point is sysc_return
@@ -481,7 +482,7 @@
 #
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,1
-	llgh    %r8,__LC_SVC_INT_CODE # get svc number from lowcore
+	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
 	stosm   48(%r15),0x03     # reenable interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	slag	%r7,%r7,2         # *4 and test for svc 0
@@ -490,15 +491,15 @@
 	clg	%r1,.Lnr_syscalls-.Lconst(%r14)
 	slag	%r7,%r1,2
 pgm_svcstd:
-	larl    %r7,sys_call_table
+	larl    %r10,sys_call_table
 #ifdef CONFIG_S390_SUPPORT
         tm      SP_PSW+3(%r15),0x01  # are we running in 31 bit mode ?
         jo      pgm_svcper_noemu
-	larl    %r7,sys_call_table_emu # use 31 bit emulation system calls
+	larl    %r10,sys_call_table_emu # use 31 bit emulation system calls
 pgm_svcper_noemu:
 #endif
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
-        lgf     %r8,0(%r8,%r7)    # load address of system call routine
+        lgf     %r8,0(%r7,%r10)   # load address of system call routine
         jo      pgm_tracesys
         basr    %r14,%r8          # call sys_xxxx
         stg     %r2,SP_R2(%r15)   # store return value (change R2 on stack)
@@ -522,19 +523,20 @@
 # call trace before and after sys_call
 #
 pgm_tracesys:
-	lgfr	%r7,%r7
+	srlg	%r7,%r7,2
 	stg	%r7,SP_R2(%r15)
         brasl   %r14,syscall_trace
 	clc	SP_R2(8,%r15),.Lnr_syscalls
-	jnl     pgm_svc_go
-	lg      %r2,SP_R2(%r15)
-	sllg    %r2,%r2,3           # strace wants to change the syscall
-	lgf	%r8,0(%r2,%r7)
+	jnl     pgm_svc_nogo
+	lg      %r7,SP_R2(%r15)
+	sllg    %r7,%r7,2           # strace wants to change the syscall
+	lgf	%r8,0(%r7,%r10)
 pgm_svc_go:
 	lmg     %r3,%r6,SP_R3(%r15)
 	lg      %r2,SP_ORIG_R2(%r15)
         basr    %r14,%r8            # call sys_xxx
         stg     %r2,SP_R2(%r15)     # store return value
+pgm_svc_nogo:
 	tm	__TI_flags+7(%r9),_TIF_SYSCALL_TRACE
         jno     pgm_svcret
 	larl	%r14,pgm_svcret     # return point is sysc_return
