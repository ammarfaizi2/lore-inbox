Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWBQAOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWBQAOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWBQAOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:14:35 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:36496 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161119AbWBQAOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:14:34 -0500
Date: Thu, 16 Feb 2006 19:11:26 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: fix singlestepping though a syscall
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602161914_MC3-1-B89C-55BE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Singlestep through a syscall using vsyscall-sysenter had two bugs:

    1.  Setting TIF_SINGLESTEP is not enough to force
        do_notify_resume() to be run on return to user;
        TIF_IRET must also be set.

    2.  do_notify_resume() was being passed masked copies
        of task_thread_flags, so TIF_SINGLESTEP was never
        seen as set when it was called. This was changed
        to use the 'test' instruction instead of 'and';
        a duplicated piece of code was removed instead
        of fixing that part too.

Also changed some misleading 'jne' to 'jnz' to make it
clearer what is happening.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---
 arch/i386/kernel/entry.S |   17 +++++------------
 arch/i386/kernel/traps.c |    1 +
 2 files changed, 6 insertions(+), 12 deletions(-)

--- 2.6.16-rc3-nb.orig/arch/i386/kernel/entry.S
+++ 2.6.16-rc3-nb/arch/i386/kernel/entry.S
@@ -152,9 +152,9 @@ ENTRY(resume_userspace)
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
-	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done on
+	testl $_TIF_WORK_MASK, %ecx	# is there any work to be done on
 					# int/exception return?
-	jne work_pending
+	jnz work_pending
 	jmp restore_all
 
 #ifdef CONFIG_PREEMPT
@@ -301,21 +301,14 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
-	cli				# make sure we don't miss an interrupt
-					# setting need_resched or sigpending
-					# between sampling and the iret
-	movl TI_flags(%ebp), %ecx
-	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done other
-					# than syscall tracing?
-	jz restore_all
-	testb $_TIF_NEED_RESCHED, %cl
-	jnz work_resched
+	jmp resume_userspace
 
+	ALIGN
 work_notifysig:				# deal with pending signals and
 					# notify-resume requests
 	testl $VM_MASK, EFLAGS(%esp)
 	movl %esp, %eax
-	jne work_notifysig_v86		# returning to kernel-space or
+	jnz work_notifysig_v86		# returning to kernel-space or
 					# vm86-space
 	xorl %edx, %edx
 	call do_notify_resume
--- 2.6.16-rc3-nb.orig/arch/i386/kernel/traps.c
+++ 2.6.16-rc3-nb/arch/i386/kernel/traps.c
@@ -795,6 +795,7 @@ debug_vm86:
 
 clear_TF_reenable:
 	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
+	set_tsk_thread_flag(tsk, TIF_IRET);
 	regs->eflags &= ~TF_MASK;
 	return;
 }
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
