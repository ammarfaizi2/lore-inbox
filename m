Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVCGT00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVCGT00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVCGTZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:25:37 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:13574 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261240AbVCGTL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:11:28 -0500
Message-Id: <200503072038.j27Kc6bc003978@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 8/16] UML - Code cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:38:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Shifting register restore and userspace resume to the
beginning of the userspace loop, we can remove the
identical code done before the loop.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: uml-i386/arch/um/kernel/skas/process.c
===================================================================
--- uml-i386.orig/arch/um/kernel/skas/process.c	2005-03-02 23:39:26.408483443 -0800
+++ uml-i386/arch/um/kernel/skas/process.c	2005-03-02 23:45:55.666136061 -0800
@@ -139,17 +139,20 @@
 	int err, status, op, pid = userspace_pid[0];
 	int local_using_sysemu; /*To prevent races if using_sysemu changes under us.*/
 
-	restore_registers(pid, regs);
-		
-	local_using_sysemu = get_using_sysemu();
+	while(1){
+		restore_registers(pid, regs);
 
-	op = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
-	err = ptrace(op, pid, 0, 0);
+		/* Now we set local_using_sysemu to be used for one loop */
+		local_using_sysemu = get_using_sysemu();
+
+		op = SELECT_PTRACE_OPERATION(local_using_sysemu, singlestepping(NULL));
+
+		err = ptrace(op, pid, 0, 0);
+		if(err)
+			panic("userspace - could not resume userspace process, "
+			      "pid=%d, ptrace operation = %d, errno = %d\n",
+			      op, errno);
 
-	if(err)
-		panic("userspace - PTRACE_%s failed, errno = %d\n",
-		       local_using_sysemu ? "SYSEMU" : "SYSCALL", errno);
-	while(1){
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if(err < 0)
 			panic("userspace - waitpid failed, errno = %d\n", 
@@ -187,19 +190,6 @@
 			/* Avoid -ERESTARTSYS handling in host */
 			PT_SYSCALL_NR(regs->skas.regs) = -1;
 		}
-
-		restore_registers(pid, regs);
-
-		/*Now we ended the syscall, so re-read local_using_sysemu.*/
-		local_using_sysemu = get_using_sysemu();
-
-		op = SELECT_PTRACE_OPERATION(local_using_sysemu, singlestepping(NULL));
-
-		err = ptrace(op, pid, 0, 0);
-		if(err)
-			panic("userspace - PTRACE_%s failed, "
-			      "errno = %d\n",
-			      local_using_sysemu ? "SYSEMU" : "SYSCALL", errno);
 	}
 }
 

