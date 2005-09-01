Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbVIAWX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbVIAWX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbVIAWX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:23:56 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:29456 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030464AbVIAWXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:23:54 -0400
Message-Id: <200509012217.j81MHMKt011572@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 11/12] UML - Fix advanced sysemu check
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:17:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

cleanup and fix the check for advanced sysemu
(PTRACE_SYSEMU_SINGLESTEP option)

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/os-Linux/start_up.c
===================================================================
--- test.orig/arch/um/os-Linux/start_up.c	2005-09-01 17:19:47.000000000 -0400
+++ test/arch/um/os-Linux/start_up.c	2005-09-01 17:21:35.000000000 -0400
@@ -161,7 +161,7 @@
 static void __init check_sysemu(void)
 {
 	void *stack;
-	int pid, syscall, n, status, count=0;
+ 	int pid, n, status, count=0;
 
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
@@ -192,6 +192,12 @@
 
 	printk("Checking advanced syscall emulation patch for ptrace...");
 	pid = start_ptraced_child(&stack);
+
+	if(ptrace(PTRACE_OLDSETOPTIONS, pid, 0, 
+		  (void *) PTRACE_O_TRACESYSGOOD) < 0)
+		panic("check_ptrace: PTRACE_OLDSETOPTIONS failed, errno = %d",
+		      errno);
+
 	while(1){
 		count++;
 		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
@@ -199,15 +205,10 @@
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected (SIGTRAP|SYSCALL_TRAP), "
-			      "got status = %d", status);
-
-		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
-				 0);
-		if(syscall == __NR_getpid){
+		if(WIFSTOPPED(status) && (WSTOPSIG(status) == (SIGTRAP|0x80))){
 			if (!count)
-				panic("check_ptrace : SYSEMU_SINGLESTEP doesn't singlestep");
+				panic("check_ptrace : SYSEMU_SINGLESTEP "
+				      "doesn't singlestep");
 			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
 				   os_getpid());
 			if(n < 0)
@@ -215,6 +216,11 @@
 				      "call return, errno = %d", errno);
 			break;
 		}
+		else if(WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP))
+			count++;
+		else
+			panic("check_ptrace : expected SIGTRAP or "
+			      "(SIGTRAP|0x80), got status = %d", status);
 	}
 	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;
@@ -250,8 +256,8 @@
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP + 0x80))
-			panic("check_ptrace : expected SIGTRAP + 0x80, "
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP|0x80)))
+			panic("check_ptrace : expected (SIGTRAP|0x80), "
 			      "got status = %d", status);
 		
 		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,

