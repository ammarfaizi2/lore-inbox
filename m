Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbULCT3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbULCT3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbULCT2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:28:48 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:9220
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262471AbULCT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:27:03 -0500
Message-Id: <200412032143.iB3Lh3ZW004663@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - Add TRACESYSGOOD support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:43:03 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser:

Patch 1/3 to implement usage of PTRACE_O_TRACESYSGOOD
This is necessary, to fix UMLs bad behavior when a process does
a systemcall with syscall-number less than 0.

Insert a check for availability and function of
ptrace(PTRACE_SETOPTIONS,,,PTRACE_O_TRACESYSGOOD)
into the normal ptrace checks at startup.

Patch 2/3 to implement usage of PTRACE_O_TRACESYSGOOD
This is necessary, to fix UMLs bad behavior when a process does
a systemcall with syscall-number less than 0.

This patch makes SKAS-mode use PTRACE_O_TRACESYSGOOD and fixes
the problems in SKAS.

Patch 3/3 to implement usage of PTRACE_O_TRACESYSGOOD
This is necessary, to fix UMLs bad behavior when a process does
a systemcall with syscall-number less than 0.

This patch makes TT-mode use PTRACE_O_TRACESYSGOOD and fixes
the problems in TT.
I'm not quite sure, that this patch doesn't cause problems with
debugger usage. It should be testet by someone, who has more
know how about TT-mode debugger.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/process.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/process.c	2004-12-01 23:43:12.000000000 -0500
+++ 2.6.9/arch/um/kernel/process.c	2004-12-01 23:47:11.000000000 -0500
@@ -13,6 +13,7 @@
 #include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/ptrace.h>
@@ -285,6 +286,9 @@
 	printk("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child(&stack);
 
+	if(ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
+
 	while(1){
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			panic("check_ptrace : ptrace failed, errno = %d", 
@@ -292,8 +296,8 @@
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected SIGTRAP, "
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP + 0x80)))
+			panic("check_ptrace : expected SIGTRAP + 0x80, "
 			      "got status = %d", status);
 		
 		syscall = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET,
Index: 2.6.9/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/process.c	2004-12-01 23:43:12.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/process.c	2004-12-01 23:47:11.000000000 -0500
@@ -11,6 +11,7 @@
 #include <sched.h>
 #include <sys/wait.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/mman.h>
 #include <sys/user.h>
 #include <asm/unistd.h>
@@ -60,14 +61,9 @@
 /*To use the same value of using_sysemu as the caller, ask it that value (in local_using_sysemu)*/
 static void handle_trap(int pid, union uml_pt_regs *regs, int local_using_sysemu)
 {
-	int err, syscall_nr, status;
+	int err, status;
 
-	syscall_nr = PT_SYSCALL_NR(regs->skas.regs);
-	UPT_SYSCALL_NR(regs) = syscall_nr;
-	if(syscall_nr < 0){
-		relay_signal(SIGTRAP, regs);
-		return;
-	}
+	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->skas.regs);
 
 	if (!local_using_sysemu)
 	{
@@ -82,7 +78,7 @@
 			      "errno = %d\n", errno);
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
-		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP + 0x80)))
 			panic("handle_trap - failed to wait at end of syscall, "
 			      "errno = %d, status = %d\n", errno, status);
 	}
@@ -131,6 +127,10 @@
 		panic("start_userspace : expected SIGSTOP, got status = %d",
 		      status);
 
+	if (ptrace(PTRACE_SETOPTIONS, pid, NULL, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("start_userspace : PTRACE_SETOPTIONS failed, errno=%d\n", 
+		      errno);
+
 	if(munmap(stack, PAGE_SIZE) < 0)
 		panic("start_userspace : munmap failed, errno = %d\n", errno);
 
@@ -166,9 +166,13 @@
 			case SIGSEGV:
 				handle_segv(pid);
 				break;
-			case SIGTRAP:
+			case SIGTRAP + 0x80:
 			        handle_trap(pid, regs, local_using_sysemu);
 				break;
+			case SIGTRAP:
+				UPT_SYSCALL_NR(regs) = -1;
+				relay_signal(SIGTRAP, regs);
+				break;
 			case SIGIO:
 			case SIGVTALRM:
 			case SIGILL:
Index: 2.6.9/arch/um/kernel/tt/exec_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/exec_user.c	2004-12-01 23:43:03.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/exec_user.c	2004-12-01 23:47:11.000000000 -0500
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <signal.h>
 #include "user_util.h"
 #include "kern_util.h"
@@ -37,6 +38,9 @@
 
 	kill(old_pid, SIGKILL);
 
+	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
+
 	if(ptrace_setregs(new_pid, regs) < 0)
 		tracer_panic("do_exec failed to start new proc - errno = %d",
 			     errno);
Index: 2.6.9/arch/um/kernel/tt/include/tt.h
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/include/tt.h	2004-12-01 23:43:03.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/include/tt.h	2004-12-01 23:47:11.000000000 -0500
@@ -27,6 +27,7 @@
 extern void syscall_handler(int sig, union uml_pt_regs *regs);
 extern void exit_kernel(int pid, void *task);
 extern int do_syscall(void *task, int pid, int local_using_sysemu);
+extern void do_sigtrap(void *task);
 extern int is_valid_pid(int pid);
 extern void remap_data(void *segment_start, void *segment_end, int w);
 
Index: 2.6.9/arch/um/kernel/tt/syscall_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/syscall_user.c	2004-12-01 23:43:03.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/syscall_user.c	2004-12-01 23:47:11.000000000 -0500
@@ -43,21 +43,19 @@
 	record_syscall_end(index, result);
 }
 
+void do_sigtrap(void *task)
+{
+	UPT_SYSCALL_NR(TASK_REGS(task)) = -1;
+}
+
 int do_syscall(void *task, int pid, int local_using_sysemu)
 {
 	unsigned long proc_regs[FRAME_SIZE];
-	union uml_pt_regs *regs;
-	int syscall;
 
 	if(ptrace_getregs(pid, proc_regs) < 0)
 		tracer_panic("Couldn't read registers");
-	syscall = PT_SYSCALL_NR(proc_regs);
-
-	regs = TASK_REGS(task);
-	UPT_SYSCALL_NR(regs) = syscall;
 
-	if(syscall < 0)
-		return(0);
+	UPT_SYSCALL_NR(TASK_REGS(task)) = PT_SYSCALL_NR(proc_regs);
 
 	if((syscall != __NR_sigreturn) &&
 	   ((unsigned long *) PT_IP(proc_regs) >= &_stext) && 
Index: 2.6.9/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/tracer.c	2004-12-01 23:43:12.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/tracer.c	2004-12-01 23:47:11.000000000 -0500
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include "user.h"
@@ -71,6 +72,8 @@
 	   (ptrace(PTRACE_CONT, pid, 0, 0) < 0))
 		tracer_panic("OP_FORK failed to attach pid");
 	wait_for_stop(pid, SIGSTOP, PTRACE_CONT, NULL);
+	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		tracer_panic("OP_FORK: PTRACE_SETOPTIONS failed, errno = %d", errno);
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		tracer_panic("OP_FORK failed to continue process");
 }
@@ -140,7 +143,7 @@
 	 * any more, the trace of those will land here.  So, we need to just 
 	 * PTRACE_SYSCALL it.
 	 */
-	case SIGTRAP:
+	case (SIGTRAP + 0x80):
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			tracer_panic("sleeping_process_signal : Failed to "
 				     "PTRACE_SYSCALL pid %d, errno = %d\n",
@@ -196,6 +199,10 @@
 		printf("waitpid on idle thread failed, errno = %d\n", errno);
 		exit(1);
 	}
+	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0) {
+		printf("Failed to PTRACE_SETOPTIONS for idle thread, errno = %d\n", errno);
+		exit(1);
+	}
 	if((ptrace(PTRACE_CONT, pid, 0, 0) < 0)){
 		printf("Failed to continue idle thread, errno = %d\n", errno);
 		exit(1);
@@ -326,14 +333,22 @@
 				 */
 				pid = cpu_tasks[proc_id].pid;
 				break;
+			case (SIGTRAP + 0x80):
+				if(!tracing && (debugger_pid != -1)){
+					child_signal(pid, status & 0x7fff);
+					continue;
+				}
+				tracing = 0;
+				do_syscall(task, pid, local_using_sysemu);
+				sig = SIGUSR2;
+				break;
 			case SIGTRAP:
 				if(!tracing && (debugger_pid != -1)){
 					child_signal(pid, status);
 					continue;
 				}
 				tracing = 0;
-				if(do_syscall(task, pid, local_using_sysemu))
-					sig = SIGUSR2;
+				do_sigtrap(task);
 				break;
 			case SIGPROF:
 				if(tracing) sig = 0;

