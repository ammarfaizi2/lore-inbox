Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTBXNzT>; Mon, 24 Feb 2003 08:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbTBXNzT>; Mon, 24 Feb 2003 08:55:19 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:62665 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S267089AbTBXNzI>; Mon, 24 Feb 2003 08:55:08 -0500
Date: Mon, 24 Feb 2003 15:05:14 +0100 (CET)
From: fcorneli@elis.rug.ac.be
To: linux-kernel@vger.kernel.org
cc: Frank.Cornelis@elis.rug.ac.be
Subject: [PATCH] ptrace PTRACE_READDATA/WRITEDATA, kernel 2.5.62
Message-ID: <Pine.LNX.4.44.0302241448140.1277-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ported some generic SunOS ptrace requests from my 2.4 exptrace kernel 
patch to the 2.5 tree. The PTRACE_READDATA/WRITEDATA requests have been 
available for a long time for the sparc architecture but I think they're 
also very useful on the i386 arch since PTRACE_PEEKDATA/POKEDATA are way 
too slow when handling large data blocks.

Frank.

diff -Nur linux-2.5.62.orig/arch/i386/kernel/ptrace.c linux-2.5.62/arch/i386/kernel/ptrace.c
--- linux-2.5.62.orig/arch/i386/kernel/ptrace.c	2003-02-17 23:56:10.000000000 +0100
+++ linux-2.5.62/arch/i386/kernel/ptrace.c	2003-02-24 14:12:02.000000000 +0100
@@ -229,7 +229,7 @@
 	return 0;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage int sys_ptrace(long request, long pid, long addr, long data, long addr2)
 {
 	struct task_struct *child;
 	struct user * dummy = NULL;
@@ -355,6 +355,34 @@
 		  }
 		  break;
 
+	case PTRACE_READDATA:
+	case PTRACE_READTEXT: {
+		int res;
+		ret = 0;
+		res = ptrace_readdata(child, addr, (void *)addr2, data);
+		if (res == data)
+			break;
+		if (res >= 0)
+			ret = -EIO;
+		else
+			ret = res;
+		break;
+	}
+
+	case PTRACE_WRITEDATA:
+	case PTRACE_WRITETEXT: {
+		int res;
+		ret = 0;
+		res = ptrace_writedata(child, (void *)addr2, addr, data);
+		if (res == data)
+			break;
+		if (res >= 0)
+			ret = -EIO;
+		else
+			ret = res;
+		break;
+	}
+
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		long tmp;
diff -Nur linux-2.5.62.orig/include/asm-i386/ptrace.h linux-2.5.62/include/asm-i386/ptrace.h
--- linux-2.5.62.orig/include/asm-i386/ptrace.h	2003-02-17 23:55:51.000000000 +0100
+++ linux-2.5.62/include/asm-i386/ptrace.h	2003-02-24 13:54:33.000000000 +0100
@@ -53,6 +53,10 @@
 
 #define PTRACE_GET_THREAD_AREA    25
 #define PTRACE_SET_THREAD_AREA    26
+#define PTRACE_READDATA           27
+#define PTRACE_WRITEDATA          28
+#define PTRACE_READTEXT           29
+#define PTRACE_WRITETEXT          30
 
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))

-----------------------------------------------------------------------
Demo:
#include <stdio.h>
#include <stdlib.h>
#include <sys/ptrace.h>
#include <asm/ptrace.h>
#include <sys/wait.h>
#include <sched.h>
#include <syscall.h>
#include <errno.h>

#define STACK_SIZE (1024*2)

#define DATA_SIZE (1024*64)

#ifndef __NR_ptrace5
#define __NR_ptrace5 __NR_ptrace
#endif

// we need to pass 5 parameters to PTRACE_READDATA/WRITEDATA
_syscall5 (int, ptrace5, int, request, pid_t, pid, void *, addr, void *, data,
		void *, addr2);

static int child_func(void *param);
static volatile int go = 0;
static char *common_data;

int main()
{
	int status, pid, i;
	char *stack, *buf;
	stack = malloc(STACK_SIZE);
	common_data = malloc(DATA_SIZE);
	srand(0);
	for (i = 0; i < DATA_SIZE; i++)
		common_data[i] = (int)(255.0 * rand() / (RAND_MAX + 1.0));
	pid = clone(child_func, stack + STACK_SIZE, SIGCHLD | CLONE_VM, NULL);
	ptrace(PTRACE_ATTACH, pid, NULL, NULL);
	waitpid(pid, &status, 0);
	go = 1;
	buf = malloc(DATA_SIZE);
	for (i = 0; i < DATA_SIZE; i++)
		buf[i] = '\0';
	while (1) {
		ptrace(PTRACE_SYSCALL, pid, NULL, NULL);
		waitpid(pid, &status, 0);
		if (WIFEXITED(status))
			exit(0);
		if (WIFSTOPPED(status) && WSTOPSIG(status) == SIGTRAP) {
			printf("syscall: %d (EAX: %d)\n", 
					(int)ptrace(PTRACE_PEEKUSER, pid, ORIG_EAX * 4, NULL),
					(int)ptrace(PTRACE_PEEKUSER, pid, EAX * 4, NULL));
			if (ptrace5(PTRACE_READDATA, pid, common_data, (void *)DATA_SIZE, buf)) {
				perror("PTRACE_READDATA");
				exit(1);
			}
			for (i = 0; i < DATA_SIZE; i++)
				if (buf[i] != common_data[i]) {
					fprintf(stderr, "PTRACE_READDATA error.\n");
					exit(1);
				}
		}
	}
}

static int child_func(void *param)
{
	while (!go) ;
	getpid();
	getppid();
	return 0;
}

