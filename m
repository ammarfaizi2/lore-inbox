Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVEPQ7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVEPQ7C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVEPQ7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:59:02 -0400
Received: from mail.ccur.com ([208.248.32.212]:59348 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261754AbVEPQ6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:58:19 -0400
Message-ID: <4288D128.3030401@ccur.com>
Date: Mon, 16 May 2005 12:58:16 -0400
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ak@suse
Subject: [PATCH] arch/x86_64/kernel/ptrace.c linux-2.6.11.8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2005 16:58:17.0533 (UTC) FILETIME=[74DE6ED0:01C55A38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

We have noticed a small hole in the x86_64 version of sys_ptrace() for
the PTRACE_PEEKUSR and PTRACE_POKEUSR commands, where if you specify the
offset/addr location just beyond the end of the user_regs_struct, the
code incorrectly lets you peek or (more importantly) poke that location.

Also included is a small example test to show the problem.

Thank you for your time and consideration.


diff -ru linux-2.6.11.8/arch/x86_64/kernel/ptrace.c 
new/arch/x86_64/kernel/ptrace.c
--- linux-2.6.11.8/arch/x86_64/kernel/ptrace.c	2005-05-16 
11:56:52.121795891 -0400
+++ new/arch/x86_64/kernel/ptrace.c	2005-05-16 10:59:56.970748305 -0400
@@ -247,7 +247,8 @@
  			break;

  		switch (addr) {
-		case 0 ... sizeof(struct user_regs_struct):
+		case 0 ... (sizeof(struct user_regs_struct)
+			- sizeof(unsigned long)):
  			tmp = getreg(child, addr);
  			break;
  		case offsetof(struct user, u_debugreg[0]):
@@ -292,7 +293,8 @@
  			break;

  		switch (addr) {
-		case 0 ... sizeof(struct user_regs_struct):
+		case 0 ... (sizeof(struct user_regs_struct)
+			- sizeof(unsigned long)):
  			ret = putreg(child, addr, data);
  			break;
  		/* Disallows to set a breakpoint into the vsyscall */




----------------------------------------------------------------------
example test:   gcc -o test test.c
----------------------------------------------------------------------
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/user.h>
#include <linux/ptrace.h>
#include <errno.h>

static void
do_pokeusr_test(pid_t child)
{
	int was_error = 0;
	long pstatus;

	printf("calling PTRACE_POKEUSR with offset 0x%lx (%ld) data 0\n",
		sizeof(struct user_regs_struct),
		sizeof(struct user_regs_struct));
	pstatus = ptrace(PTRACE_POKEUSR,
		child, (void *)(sizeof(struct user_regs_struct)), (void *)0);
	if (pstatus)
		printf("ptrace pokeusr returned %d\n", errno);
}

static void child_process(void)
{
	printf("child pid %d parent pid %d\n", getpid(), getppid());
	while ( sleep(5)) ;
	exit(0);
}

int
main(int argc, char *argv[])
{
	int status, child_status;
	long pstatus;
	pid_t child;

	child = fork();
	if (child == -1) {
		printf("ERROR: fork returned errno %d\n", errno);
		exit(1);
	}
	if (!child)
		child_process();
	sleep(1);
	printf("Attaching to child ...\n");
	pstatus = ptrace(PTRACE_ATTACH, child, (void *)0, (void *)0);
	if (pstatus == ~0l) {
		printf("ERROR: attach failed.  errno %d\n", errno);
		exit(1);
	}
	status = waitpid(-1, &child_status, WUNTRACED);
	if (status == -1) {
	    printf("ERROR: waitpid() returned errno %d\n", errno);
	    printf("---- Test Failed. ----\n");
	    exit(1);
	}
	printf("waitpid(): child pid %d child_status %d\n",
		status, child_status);

	do_pokeusr_test(child);

	printf("Continuing child process.\n");
	pstatus = ptrace(PTRACE_CONT, (pid_t)child, (void *)0, (void *)0);
	if (pstatus) {
		printf("ERROR: ptrace continue returned %d\n", errno);
		exit(1);
	}
	status = waitpid(-1, &child_status, WUNTRACED);
	if (status == -1) {
	    printf("ERROR: waitpid() returned errno %d\n", errno);
	    printf("---- Test Failed. ----\n");
	    exit(1);
	}
	printf("waitpid(): child pid %d child_status %d\n",
		status, child_status);
	return 0;
}

