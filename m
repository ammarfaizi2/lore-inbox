Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWBGOdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWBGOdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWBGOdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:33:12 -0500
Received: from mail.ccur.com ([66.10.65.12]:31520 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S965100AbWBGOdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:33:11 -0500
Message-ID: <43E8AFA3.9000303@ccur.com>
Date: Tue, 07 Feb 2006 09:33:07 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>, bugsy@ccur.com
Subject: [PATCH] arch/x86_64/kernel/traps.c PTRACE_SINGLESTEP oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2006 14:33:08.0342 (UTC) FILETIME=[6A149960:01C62BF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

We found a problem with x86_64 kernels with preemption enabled, where
having multiple tasks doing ptrace singlesteps around the same time will
cause the system to 'oops'.  The problem seems that a task can get
preempted out of the do_debug() processing while it is running on the
DEBUG_STACK stack.  If another task on that same cpu then enters do_debug()
and uses the same per-cpu DEBUG_STACK stack, the previous preempted
tasks's stack contents can be corrupted, and the system will oops
when the preempted task is context switched back in again.

The typical oops looks like the following:
-----------------------------------------------------------------------------
Unable to handle kernel paging request at ffffffffffffffae RIP:
<ffffffff805452a1>{thread_return+34}
PGD 103027 PUD 102429067 PMD 0
Oops: 0002 [1] PREEMPT SMP
CPU 0
Modules linked in:
Pid: 3786, comm: ssdd Not tainted 2.6.15.2 #1
RIP: 0010:[<ffffffff805452a1>] <ffffffff805452a1>{thread_return+34}
RSP: 0018:ffffffff80824058  EFLAGS: 000136c2
RAX: ffff81017e12cea0 RBX: 0000000000000000 RCX: 00000000c0000100
RDX: 0000000000000000 RSI: ffff8100f7856e20 RDI: ffff81017e12cea0
RBP: 0000000000000046 R08: ffff8100f68a6000 R09: 0000000000000000
R10: 0000000000000000 R11: ffff81017e12cea0 R12: ffff81000c2d53e8
R13: ffff81017f5b3be8 R14: ffff81000c0036e0 R15: 000001056cbfc899
FS:  00002aaaaaad9b00(0000) GS:ffffffff80883800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffffffffffae CR3: 00000000f6fcf000 CR4: 00000000000006e0
Process ssdd (pid: 3786, threadinfo ffff8100f68a6000, task ffff8100f7856e20)
Stack: ffffffff808240d8 ffffffff8012a84a ffff8100055f6c00 0000000000000020
        0000000000000001 ffff81000c0036e0 ffffffff808240b8 0000000000000000
        0000000000000000 0000000000000000
Call Trace: <#DB> <ffffffff8012a84a>{try_to_wake_up+985} 
<ffffffff8012c0d3>{kick_process+87}
        <ffffffff8013b262>{signal_wake_up+48} 
<ffffffff8013b5ce>{specific_send_sig_info+179}
        <ffffffff80546abc>{_spin_unlock_irqrestore+27} 
<ffffffff8013b67c>{force_sig_info+159}
        <ffffffff801103a0>{do_debug+289} <ffffffff80110278>{sync_regs+103}
        <ffffffff8010ed9a>{paranoid_userspace+35}  <EOE> <1>Unable to 
handle kernel paging request at 00007fffffb7d000 RIP:
<ffffffff8010f2e4>{show_trace+465}
PGD f6f25067 PUD f6fcc067 PMD f6957067 PTE 0
Oops: 0000 [2] PREEMPT SMP
-----------------------------------------------------------------------------
Here is a test that will cause this oops to occur:
-----------------------------------------------------------------------------
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#define NUM_SINGLESTEPS 10000
#define NUM_FORKS	10

#define STATE_EXITED		1
#define STATE_STOPPED		2
#define STATE_UNKNOWN		3
#define STATE_ECHILD		4
#define STATE_SIGNALED		5
#define STATE_EXITED_TSIG	6
#define STATE_EXITED_ERRSTAT	7

static int do_wait(pid_t *wait_pid, int *ret_sig)
{
	int status, child_status;

	while (1) {
	    status = waitpid(-1, &child_status, WUNTRACED|__WALL);
	    if (status == -1) {
		if (errno == EINTR)
		    continue;
		if (errno == ECHILD) {
		    *wait_pid = (pid_t)0;
		    return STATE_ECHILD;
		}
		printf("do_wait: ERROR: waitpid() returned errno %d\n", errno);
		printf("---- Test Failed. ----\n");
		exit(1);
	    }
	    break;
	}
	*wait_pid = (pid_t)status;
	if (WIFEXITED(child_status)) {
	    if (WIFSIGNALED(child_status))
		return STATE_EXITED_TSIG;
	    if (WEXITSTATUS(child_status))
		return STATE_EXITED_ERRSTAT;
	    return STATE_EXITED;
	}
	if (WIFSTOPPED(child_status)) {
	    *ret_sig = WSTOPSIG(child_status);
	    return STATE_STOPPED;
	}
	if (WIFSIGNALED(child_status)) {
	    *ret_sig = WTERMSIG(child_status);
	    return STATE_SIGNALED;
	}
	return STATE_UNKNOWN;
}

static void child_process(void)
{
	pid_t mypid;
	sleep(3);	/* wait for ptrace attach */
	while (1)	/* for singlestepping through arbitrary code */
		mypid = getpid();
}

static int forktests(void)
{
	int i, status, ret_sig;
	long pstatus;
	pid_t child, wait_pid;

	printf("forktests: pid %d\n", getpid());
	child = fork();
	if (child == -1) {
		printf("fork returned errno %d\n", errno);
		exit(1);
	}
	if (!child)
		child_process();
	sleep(1);
	printf("forktests: attaching to child %d...\n", child);
	pstatus = ptrace(PTRACE_ATTACH, child, (void *)0, (void *)0);
	if (pstatus == ~0l) {
		printf("ERROR: attach failed.  errno %d\n", errno);
		printf("---- Test failed. ----\n");
		exit(1);
	}
	status = do_wait(&wait_pid, &ret_sig);
	if (wait_pid != child) {
		printf("ERROR: Unexpected wait pid %d\n", wait_pid );
		printf("---- Test failed. ----\n");
		exit(1);
	}
	if (status != STATE_STOPPED) {
		printf("ERROR: Unexpected child state %d\n", status);
		printf("---- Test failed. ----\n");
		exit(1);
	}

	for (i = 0; i < NUM_SINGLESTEPS; i++) {
	    pstatus = ptrace(
		PTRACE_SINGLESTEP, (pid_t)child, (void *)0, (void *)0);
	    if (pstatus) {
                 printf("ERROR: ptrace singlstep returned %d\n", errno);
                 printf("---- Test failed. ----\n"); exit(1);
	    }
	    status = do_wait(&wait_pid, &ret_sig);
	    if (wait_pid != child) {
		printf("ERROR: Unexpected wait pid %d\n", wait_pid );
		printf("---- Test failed. ----\n");
		exit(1);
	    }
	    if (status != STATE_STOPPED) {
		printf("ERROR: Unexpected child state %d\n", status);
		printf("---- Test failed. ----\n");
		exit(1);
	    }
	    if (ret_sig != SIGTRAP) {
		printf("ERROR: Unexpected child signal %d\n", ret_sig);
		printf("---- Test failed. ----\n");
		exit(1);
	    }
	}
	status = kill(child, SIGKILL);
	if (status) {
		printf("ERROR: kill of child %d returned %d\n", child, errno);
		printf("---- Test failed. ----\n");
		exit(1);
	}
	status = do_wait(&wait_pid, &ret_sig);
	if (wait_pid != child) {
		printf("ERROR: Unexpected wait pid %d\n", wait_pid );
		printf("---- Test failed. ----\n");
		exit(1);
	}
	if (status != STATE_SIGNALED) {
		printf("ERROR: Unexpected child state %d\n", status);
		printf("---- Test failed. ----\n");
		exit(1);
	}
	if (ret_sig != SIGKILL) {
		printf("ERROR: Unexpected child signal %d\n", ret_sig);
		printf("---- Test failed. ----\n");
		exit(1);
	}
	exit(0);
}

int main(int argc, char **argv)
{
	int i, ret_sig, status;
	pid_t child, wait_pid;
	(void)argv; (void)argc;

	for (i = 0; i < NUM_FORKS; i++) {
		child = fork();
		if (child == -1) {
			printf("main: fork returned errno %d\n", errno);
			exit(1);
		}
		if (!child)
			forktests();
	}
	sleep(5);
	for (i = 0; i < NUM_FORKS; i++) {
	    status = do_wait(&wait_pid, &ret_sig);
	    if (status != STATE_EXITED) {
		printf("ERROR: Unexpected child %d state %d\n", child, status);
		printf("---- Test failed. ----\n");
		exit(1);
	    }
	    printf("main: forktest pid %d exited successfully.\n", wait_pid);
	}
	printf("PASS : Test successfully completed.\n");
	exit(0);
}
-----------------------------------------------------------------------------
And lastly, here is an approach for a patch.
This patch disables preemptions for the task upon entry to do_debug(),
before interrupts are reenabled, and then disables preemption before
exiting do_debug(), after disabling interrupts.  I've noticed that the
task can be preempted either at the end of an interrupt,
or on the call to force_sig_info() on the spin_unlock_irqrestore()
processing.  It might be better to attempt to code a fix in entry.S
around the code that calls do_debug(), but that approach is probably
beyond my abilities.
-----------------------------------------------------------------------------
--- linux-2.6.15.2/arch/x86_64/kernel/traps.c	2006-01-31 
01:25:07.000000000 -0500
+++ new/arch/x86_64/kernel/traps.c	2006-02-06 17:01:29.000000000 -0500
@@ -91,6 +91,20 @@
  		local_irq_enable();
  }

+static inline void preempt_conditional_sti(struct pt_regs *regs)
+{
+	preempt_disable();
+	if (regs->eflags & X86_EFLAGS_IF)
+		local_irq_enable();
+}
+
+static inline void preempt_conditional_cli(struct pt_regs *regs)
+{
+	if (regs->eflags & X86_EFLAGS_IF)
+		local_irq_disable();
+	preempt_enable_no_resched();
+}
+
  static int kstack_depth_to_print = 10;

  #ifdef CONFIG_KALLSYMS
@@ -644,7 +658,7 @@
  						SIGTRAP) == NOTIFY_STOP)
  		return;

-	conditional_sti(regs);
+	preempt_conditional_sti(regs);

  	/* Mask out spurious debug traps due to lazy DR7 setting */
  	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
@@ -691,11 +705,13 @@
  	force_sig_info(SIGTRAP, &info, tsk);	
  clear_dr7:
  	set_debugreg(0UL, 7);
+	preempt_conditional_cli(regs);
  	return;

  clear_TF_reenable:
  	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
  	regs->eflags &= ~TF_MASK;
+	preempt_conditional_cli(regs);
  }

  static int kernel_math_error(struct pt_regs *regs, char *str)

