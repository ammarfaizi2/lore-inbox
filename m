Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261770AbSJIMbe>; Wed, 9 Oct 2002 08:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSJIMax>; Wed, 9 Oct 2002 08:30:53 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:37328 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261623AbSJIM3z> convert rfc822-to-8bit; Wed, 9 Oct 2002 08:29:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.41 s390 (/8): syscall tracing.
Date: Wed, 9 Oct 2002 14:31:09 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210091431.09099.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the system call number in grp2 to strace instead of -ENOSYS.

diff -urN linux-2.5.41/arch/s390/kernel/entry.S linux-2.5.41-s390/arch/s390/kernel/entry.S
--- linux-2.5.41/arch/s390/kernel/entry.S	Wed Oct  9 14:01:13 2002
+++ linux-2.5.41-s390/arch/s390/kernel/entry.S	Wed Oct  9 14:01:41 2002
@@ -177,11 +177,11 @@
 system_call:
 	SAVE_ALL_BASE
         SAVE_ALL __LC_SVC_OLD_PSW,1
-	lh	%r8,0x8a	  # get svc number from lowcore
-        sll     %r8,2
+	lh	%r7,0x8a	  # get svc number from lowcore
         GET_THREAD_INFO           # load pointer to task_struct to R9
+	sll	%r7,2
         stosm   24(%r15),0x03     # reenable interrupts
-        l       %r8,sys_call_table-entry_base(%r8,%r13) # get system call addr.
+        l       %r8,sys_call_table-entry_base(%r7,%r13) # get system call addr.
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
         bo      BASED(sysc_tracesys)
         basr    %r14,%r8          # call sys_xxxx
@@ -241,13 +241,13 @@
 #
 sysc_tracesys:
         l       %r1,BASED(.Ltrace)
-	mvc	SP_R2(4,%r15),BASED(.Lc_ENOSYS)
+	srl	%r7,2
+	st	%r7,SP_R2(4,%r15)
 	basr	%r14,%r1
-	clc	SP_R2(4,%r15),BASED(.Lc256)
-	bnl	BASED(sysc_tracego)
-	l	%r8,SP_R2(%r15)   # strace changed the syscall
-	sll     %r8,2
-	l	%r8,sys_call_table-entry_base(%r8,%r13)
+	l	%r7,SP_R2(4,%r15)      # strace might have changed the 
+	n	%r7,BASED(.Lc256)      #  system call
+	sll	%r7,2
+	l	%r8,sys_call_table-entry_base(%r7,%r13)
 sysc_tracego:
 	lm	%r3,%r6,SP_R3(%r15)
 	l	%r2,SP_ORIG_R2(%r15)
diff -urN linux-2.5.41/arch/s390x/kernel/entry.S linux-2.5.41-s390/arch/s390x/kernel/entry.S
--- linux-2.5.41/arch/s390x/kernel/entry.S	Wed Oct  9 14:01:13 2002
+++ linux-2.5.41-s390/arch/s390x/kernel/entry.S	Wed Oct  9 14:01:41 2002
@@ -158,16 +158,16 @@
 	.globl  system_call
 system_call:
         SAVE_ALL __LC_SVC_OLD_PSW,1
-	llgh    %r8,__LC_SVC_INT_CODE # get svc number from lowcore
+	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	stosm   48(%r15),0x03     # reenable interrupts
-	larl    %r7,sys_call_table
-        sll     %r8,3
+	larl    %r10,sys_call_table
+        sll     %r7,3
         tm      SP_PSW+3(%r15),0x01  # are we running in 31 bit mode ?
         jo      sysc_noemu
-	la      %r7,4(%r7)        # use 31 bit emulation system calls
+	la      %r10,4(%r10)      # use 31 bit emulation system calls
 sysc_noemu:
-        lgf     %r8,0(%r8,%r7)    # load address of system call routine
+        lgf     %r8,0(%r7,%r10)   # load address of system call routine
 	tm	__TI_flags+7(%r9),_TIF_SYSCALL_TRACE
         jo      sysc_tracesys
         basr    %r14,%r8          # call sys_xxxx
@@ -225,15 +225,13 @@
 # special linkage: %r12 contains the return address for trace_svc
 #
 sysc_tracesys:
-	lghi    %r0,-ENOSYS
-	stg     %r0,SP_R2(%r15)     # give sysc_trace an -ENOSYS retval
+	srl	%r7,3
+	stg     %r7,SP_R2(%r15)
         brasl   %r14,syscall_trace
-	larl	%r6,.Lc256
-	clc	SP_R2(8,%r15),0(%r6)
-	jnl	sysc_tracego
-	lg      %r2,SP_R2(%r15)
-	sllg    %r2,%r2,3           # strace wants to change the syscall
-	lgf	%r8,0(%r2,%r7)
+	lghi	%r7,255           # strace might have changed the
+	ng	%r7,SP_R2(%r15)   #  the system call
+	sll     %r7,3
+	lgf	%r8,0(%r7,%r10)
 sysc_tracego:
 	lmg     %r3,%r6,SP_R3(%r15)
 	lg      %r2,SP_ORIG_R2(%r15)

