Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbUKLX4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbUKLX4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUKLXyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:54:46 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:28164
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262725AbUKLXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:48:33 -0500
Message-Id: <200411130200.iAD20upT005879@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/11] - UML - fix setting of interrupted syscall return value
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:00:56 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - handle_signal now checks whether it is being called
from a system call invocation.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 16:24:17.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 18:05:27.000000000 -0500
@@ -44,45 +44,37 @@
 {
 	void (*restorer)(void);
 	unsigned long sp;
-	int err, error, ret;
+	int err;
 
-	error = PT_REGS_SYSCALL_RET(&current->thread.regs);
-	ret = 0;
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-	switch(error){
-	case -ERESTART_RESTARTBLOCK:
-	case -ERESTARTNOHAND:
-		ret = -EINTR;
-		break;
-
-	case -ERESTARTSYS:
-		if (!(ka->sa.sa_flags & SA_RESTART)) {
-			ret = -EINTR;
+ 
+	/* Did we come from a system call? */
+	if(PT_REGS_SYSCALL_NR(regs) >= 0){
+		/* If so, check system call restarting.. */
+		switch(PT_REGS_SYSCALL_RET(regs)){
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			PT_REGS_SYSCALL_RET(regs) = -EINTR;
 			break;
-		}
+
+		case -ERESTARTSYS:
+			if (!(ka->sa.sa_flags & SA_RESTART)) {
+				PT_REGS_SYSCALL_RET(regs) = -EINTR;
+				break;
+			}
 		/* fallthrough */
-	case -ERESTARTNOINTR:
-		PT_REGS_RESTART_SYSCALL(regs);
-		PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
-
-		/* This is because of the UM_SET_SYSCALL_RETURN and the fact
-		 * that on i386 the system call number and return value are
-		 * in the same register.  When the system call restarts, %eax
-		 * had better have the system call number in it.  Since the
-		 * return value doesn't matter (except that it shouldn't be
-		 * -ERESTART*), we'll stick the system call number there.
-		 */
-		ret = PT_REGS_SYSCALL_NR(regs);
-		break;
+		case -ERESTARTNOINTR:
+			PT_REGS_RESTART_SYSCALL(regs);
+			PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
+			break;
+		}
 	}
 
 	sp = PT_REGS_SP(regs);
 	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	if(error != 0) PT_REGS_SET_SYSCALL_RETURN(regs, ret);
-
 	if (ka->sa.sa_flags & SA_RESTORER) 
 		restorer = ka->sa.sa_restorer;
 	else restorer = NULL;

