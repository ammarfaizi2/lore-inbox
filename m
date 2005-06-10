Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVFJPl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVFJPl4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVFJPkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:40:17 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:30726 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262580AbVFJPep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:34:45 -0400
Message-Id: <200506101529.j5AFTUwD008281@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/4] UML - use fork instead of clone
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Jun 2005 11:29:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the boot-time host ptrace testing from clone to fork.  They were
essentially doing fork anyway.  This cleans up the code a bit, and makes
valgrind a bit happier about grinding it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/process.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/process.c	2005-06-07 15:11:53.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/process.c	2005-06-08 10:58:03.000000000 -0400
@@ -130,7 +130,7 @@ int start_fork_tramp(void *thread_arg, u
 	return(arg.pid);
 }
 
-static int ptrace_child(void *arg)
+static int ptrace_child(void)
 {
 	int ret;
 	int pid = os_getpid(), ppid = getppid();
@@ -159,20 +159,16 @@ static int ptrace_child(void *arg)
 	_exit(ret);
 }
 
-static int start_ptraced_child(void **stack_out)
+static int start_ptraced_child(void)
 {
-	void *stack;
-	unsigned long sp;
 	int pid, n, status;
 	
-	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
-		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	if(stack == MAP_FAILED)
-		panic("check_ptrace : mmap failed, errno = %d", errno);
-	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
-	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
+	pid = fork();
+	if(pid == 0)
+		ptrace_child();
+
 	if(pid < 0)
-		panic("check_ptrace : clone failed, errno = %d", errno);
+		panic("check_ptrace : fork failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if(n < 0)
 		panic("check_ptrace : wait failed, errno = %d", errno);
@@ -180,7 +176,6 @@ static int start_ptraced_child(void **st
 		panic("check_ptrace : expected SIGSTOP, got status = %d",
 		      status);
 
-	*stack_out = stack;
 	return(pid);
 }
 
@@ -188,12 +183,12 @@ static int start_ptraced_child(void **st
  * just avoid using sysemu, not panic, but only if SYSEMU features are broken.
  * So only for SYSEMU features we test mustpanic, while normal host features
  * must work anyway!*/
-static int stop_ptraced_child(int pid, void *stack, int exitcode, int mustpanic)
+static int stop_ptraced_child(int pid, int exitcode, int mustexit)
 {
 	int status, n, ret = 0;
 
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
-		panic("check_ptrace : ptrace failed, errno = %d", errno);
+		panic("stop_ptraced_child : ptrace failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
@@ -204,15 +199,13 @@ static int stop_ptraced_child(int pid, v
 		printk("check_ptrace : child exited with exitcode %d, while "
 		      "expecting %d; status 0x%x", exit_with,
 		      exitcode, status);
-		if (mustpanic)
+		if (mustexit)
 			panic("\n");
 		else
 			printk("\n");
 		ret = -1;
 	}
 
-	if(munmap(stack, PAGE_SIZE) < 0)
-		panic("check_ptrace : munmap failed, errno = %d", errno);
 	return ret;
 }
 
@@ -234,12 +227,11 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 
 static void __init check_sysemu(void)
 {
-	void *stack;
 	int pid, syscall, n, status, count=0;
 
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
 		goto fail;
@@ -257,7 +249,7 @@ static void __init check_sysemu(void)
 		panic("check_sysemu : failed to modify system "
 		      "call return, errno = %d", errno);
 
-	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+	if (stop_ptraced_child(pid, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 1;
@@ -265,7 +257,7 @@ static void __init check_sysemu(void)
 	set_using_sysemu(!force_sysemu_disabled);
 
 	printk("Checking advanced syscall emulation patch for ptrace...");
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 	while(1){
 		count++;
 		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
@@ -290,7 +282,7 @@ static void __init check_sysemu(void)
 			break;
 		}
 	}
-	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+	if (stop_ptraced_child(pid, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 2;
@@ -301,18 +293,17 @@ static void __init check_sysemu(void)
 	return;
 
 fail:
-	stop_ptraced_child(pid, stack, 1, 0);
+	stop_ptraced_child(pid, 1, 0);
 fail_stopped:
 	printk("missing\n");
 }
 
 void __init check_ptrace(void)
 {
-	void *stack;
 	int pid, syscall, n, status;
 
 	printk("Checking that ptrace can change system call numbers...");
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 
 	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
@@ -339,7 +330,7 @@ void __init check_ptrace(void)
 			break;
 		}
 	}
-	stop_ptraced_child(pid, stack, 0, 1);
+	stop_ptraced_child(pid, 0, 1);
 	printk("OK\n");
 	check_sysemu();
 }
@@ -371,11 +362,10 @@ void forward_pending_sigio(int target)
 static inline int check_skas3_ptrace_support(void)
 {
 	struct ptrace_faultinfo fi;
-	void *stack;
 	int pid, n, ret = 1;
 
 	printf("Checking for the skas3 patch in the host...");
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
 	if (n < 0) {
@@ -390,7 +380,7 @@ static inline int check_skas3_ptrace_sup
 	}
 
 	init_registers(pid);
-	stop_ptraced_child(pid, stack, 1, 1);
+	stop_ptraced_child(pid, 1, 1);
 
 	return(ret);
 }

