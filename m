Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUEKXaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUEKXaB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbUEKXaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:30:00 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:33707 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265057AbUEKX1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:27:17 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 11 May 2004 16:27:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] really-ptrace-single-step2 ...
Message-ID: <Pine.LNX.4.58.0405111047450.25232@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch lets a ptrace process on x86 to "see" the instruction 
following the INT #80h op. This has been tested on 2.6.6 using the 
appended test source. Running over this:

80485a9:       b8 14 00 00 00          mov    $0x14,%eax
80485ae:       cd 80                   int    $0x80
80485b0:       89 45 ec                mov    %eax,0xffffffec(%ebp)
80485b3:       eb f4                   jmp    80485a9 <main+0x85>

it produces:

waiting ...
done: pid=12387  status=1407
sig=5
EIP=0x080485a9
waiting ...
done: pid=12387  status=1407
sig=5
EIP=0x080485ae
waiting ...
done: pid=12387  status=1407
sig=5
EIP=0x080485b0
waiting ...
done: pid=12387  status=1407
sig=5
EIP=0x080485b3




- Davide




----------------------------- TEST ------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <linux/user.h>
#include <linux/unistd.h>


int main(int ac, char **av) {
	int i, status, res;
	long start, end;
	pid_t cpid, pid;
	struct user_regs_struct ur;
	struct sigaction sa;

	sigemptyset(&sa.sa_mask);
	sa.sa_flags = 0;
	sa.sa_handler = SIG_DFL;
	sigaction(SIGCHLD, &sa, NULL);

	printf("nargs=%d\n", ac);
	if (ac == 1)
		goto tracer;

	printf("arg=%s\n", av[1]);
loop:
	__asm__ volatile ("int $0x80"
			  : "=a" (res)
			  : "0" (__NR_getpid));
	goto loop;
endloop:
	exit(0);


tracer:
	if ((cpid = fork()) != 0)
		goto parent;

	printf("child=%d\n", getpid());
	ptrace(PTRACE_TRACEME, 0, NULL, NULL);

	execl(av[0], av[0], "child", NULL);

	exit(0);

parent:
	start = (long) &&loop;
	end = (long) &&endloop;

	printf("pchild=%d\n", cpid);

	for (;;) {
		pid = wait(&status);
		if (pid != cpid)
			continue;
		res = WSTOPSIG(status);
		if (ptrace(PTRACE_GETREGS, pid, NULL, &ur)) {
			printf("[%d] error: ptrace(PTRACE_GETREGS, %d)\n",
			       pid, pid);
			return 1;
		}

		if (ptrace(PTRACE_SINGLESTEP, pid, NULL, res != SIGTRAP ? res: 0)) {
			perror("ptrace(PTRACE_SINGLESTEP)");
			return 1;
		}

		if (ur.eip >= start && ur.eip <= end)
			break;
	}


	for (i = 0; i < 15; i++) {
		printf("waiting ...\n");
		pid = wait(&status);
		printf("done: pid=%d  status=%d\n", pid, status);
		if (pid != cpid)
			continue;
		res = WSTOPSIG(status);
		printf("sig=%d\n", res);
		if (ptrace(PTRACE_GETREGS, pid, NULL, &ur)) {
			printf("[%d] error: ptrace(PTRACE_GETREGS, %d)\n",
			       pid, pid);
			return 1;
		}

		printf("EIP=0x%08x\n", ur.eip);

		if (ptrace(PTRACE_SINGLESTEP, pid, NULL, res != SIGTRAP ? res: 0)) {
			perror("ptrace(PTRACE_SINGLESTEP)");
			return 1;
		}
	}

	if (ptrace(PTRACE_CONT, cpid, NULL, SIGKILL)) {
		perror("ptrace(PTRACE_SINGLESTEP)");
		return 1;
	}

	return 0;
}



--------------------------- PATCH ----------------------------------

arch/i386/kernel/entry.S       |    2 +-
arch/i386/kernel/ptrace.c      |    7 ++++++-
include/asm-i386/thread_info.h |    2 +-
3 files changed, 8 insertions(+), 3 deletions(-)




Index: arch/i386/kernel/entry.S
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/entry.S,v
retrieving revision 1.83
diff -u -r1.83 entry.S
--- a/arch/i386/kernel/entry.S	12 Apr 2004 20:29:12 -0000	1.83
+++ b/arch/i386/kernel/entry.S	11 May 2004 18:49:56 -0000
@@ -354,7 +354,7 @@
 	# perform syscall exit tracing
 	ALIGN
 syscall_exit_work:
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT), %cl
+	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
 	sti				# could let do_syscall_trace() call
 					# schedule() instead
Index: arch/i386/kernel/ptrace.c
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/ptrace.c,v
retrieving revision 1.23
diff -u -r1.23 ptrace.c
--- a/arch/i386/kernel/ptrace.c	10 May 2004 21:25:52 -0000	1.23
+++ b/arch/i386/kernel/ptrace.c	11 May 2004 21:33:20 -0000
@@ -147,6 +147,7 @@
 { 
 	long tmp;
 
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 	tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 	put_stack_long(child, EFL_OFFSET, tmp);
 }
@@ -369,6 +370,7 @@
 		else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
 	/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
@@ -390,6 +392,7 @@
 		if (child->state == TASK_ZOMBIE)	/* already dead */
 			break;
 		child->exit_code = SIGKILL;
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET, tmp);
@@ -410,6 +413,7 @@
 		}
 		tmp = get_stack_long(child, EFL_OFFSET) | TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET, tmp);
+		set_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
@@ -534,7 +538,8 @@
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    !test_thread_flag(TIF_SINGLESTEP))
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
Index: include/asm-i386/thread_info.h
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/include/asm-i386/thread_info.h,v
retrieving revision 1.19
diff -u -r1.19 thread_info.h
--- a/include/asm-i386/thread_info.h	12 Apr 2004 20:29:12 -0000	1.19
+++ b/include/asm-i386/thread_info.h	11 May 2004 18:47:03 -0000
@@ -165,7 +165,7 @@
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP))
 #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
 
 /*
