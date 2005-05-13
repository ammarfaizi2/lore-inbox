Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVEMPJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVEMPJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVEMPJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:09:57 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:44145 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262405AbVEMPHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:07:41 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,107,1114984800"; 
   d="c'?scan'208"; a="9294470:sNHT55182496"
Message-ID: <4284C2B5.5040604@fujitsu-siemens.com>
Date: Fri, 13 May 2005 17:07:33 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Weigand <uweigand@de.ibm.com>
CC: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: Again: UML on s390 (31Bit)
References: <200505042133.j44LX8Xk010820@53v30g15.boeblingen.de.ibm.com> <427B6B6D.5080609@fujitsu-siemens.com>
In-Reply-To: <427B6B6D.5080609@fujitsu-siemens.com>
Content-Type: multipart/mixed;
 boundary="------------090506040807090608040206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090506040807090608040206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bodo Stroesser wrote:
> Ulrich Weigand wrote:
> 
>> Bodo Stroesser wrote:
>>
>>
>>> Unfortunately, I guess this will not help. But maybe I'm missing
>>> something, as I don't even understand, what the effect of the
>>> attached patch should be.
>>
>>
>> Have you tried it?

Meanwhile I've tried.

Your patch absolutely doesn't change host's behavior in the situation,
that is relevant to UML.

I've prepared and attached a small program that easily can reproduce
the problem. I hope this will help to find a viable solution.

Regards
		Bodo

>>
>>
>>> AFAICS, after each call to do_signal(),
>>> entry.S will return to user without regs->trap being checked again.
>>> do_signal() is the only place, where regs->trap is checked, and
>>> it will be called on return to user exactly once.
>>
>>
>> It will be called multiple times if *multiple* signals are pending,
>> and this is exactly the situation in your problem case (some other
>> signal is pending after the ptrace intercept SIGTRAP was delievered).
> 
> No, that's not the situation, we talk about.
> 
> UML runs its child with ptrace(PTRACE_SYSCALL).
> The syscall-interceptions do not use *real* signals. Instead, before
> and after it calls the syscall-handler, entry.S calls syscall_trace(),
> which again uses ptrace_notify() to inform the father.
> The father will see an event similar to the child receiving SIGTRAP or
> (SIGTRAP|0x80), but there will be no signal queued and do_signal() will
> not be called.
> 
> UML does all changes to its child on these two interceptions. It reads
> syscall-number and register contents from the first syscall-interception,
> writes a dummy number to the syscall-number, restarts the child with
> ptrace(PTRACE_SYSCALL) and waits until the second interception for the
> syscall happens. Next it internally executes its syscall-handler for the
> original syscall-number and writes the resulting register contents to
> the child. Now syscall-handling in UML is finished and the child is
> resumed with ptrace(PTRACE_SYSCALL). Host's do_signal() is not called
> while doing all this.
> 
> UML does not know, whether a signal is pending or not. It would not
> even help, if there would be a way to retrieve this information. A
> signal still could come in between retrieving the info and the child
> being scheduled after ptrace(PTRACE_SYSCALL).
> 
> If there is a signal pending for the child, entry.S now jumps to
> sysc_return, which again jumps to sysc_work, which calls do_signal()
> exactly once. As trap still indicates a syscall, do_signal() possibly
> modifies psw and gpr2, which makes UML fail.
> 
> The signal is not related to the syscall. UML does not know, if it is
> delivered while returning from syscall, with do_signal() changing
> registers, or later, without changes from do_signal(). So UML can't
> undo the changes done by do_signal().
> 
> To UML the signal is an interrupt, and normally when returning from
> interrupt it doesn't want to modify child's psw or gprs. So UML
> normally does not modify psw or gprs on signal interceptions.
> 
> Having said all this, unfortunately I don't see a way to satisfy UML's
> need with the current host implementation.
> 
> Regards,
> Bodo
> 
>>
>>
>>> So a practical solution should allow to reset regs->trap while the
>>> child is on the first or second syscall interception.
>>
>>
>> This is exactly what this patch is supposed to do: whenever during
>> a ptrace intercept the PSW is changed (as it presumably is by your
>> sigreturn implementation), regs->trap is automatically reset.
>>
>> Bye,
>> Ulrich
>>
> 
> 


--------------090506040807090608040206
Content-Type: text/plain;
 name="check_restart_skip.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="check_restart_skip.c"

/*
 * This is a tool to test syscall invalidation via ptrace on s390.
 * It is based on arch/um/os-Linux/start_up.c
 */

#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sched.h>
#include <errno.h>
#include <stdarg.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <asm/unistd.h>
#include <asm/page.h>
#include <linux/ptrace.h>
#include <stddef.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>

#define ERESTARTNOINTR  513

static int ptrace_child(void *arg)
{
	int ret;
	int pid = getpid();
	int sc_result;

	/* Child wants to be ptraced */
	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
		perror("ptrace");
		kill(pid, SIGKILL);
	}
	/* Child stops itself */
	kill(pid, SIGSTOP);

	/* The following part is run under PTRACE_SYSCALL */

	/* Here we have "svc __NR_getpid" twice. Father will invalidate the
	 * first and skip the second by adding 6 to PSWADDR.
	 * If the host does the unwanted syscall restarting, the second svc
	 * will be done and the result will be child's pid instead of
	 * -ERESTARTNOINTR
	 */
	__asm__ __volatile__ (
		"    svc %b1\n"
		"    .long 0\n"
		"    svc %b1\n"
		"    lr  %0,2"
		: "=d" (sc_result)
		: "i" (__NR_getpid)
		: "2" );

	/* Here we are back running PTRACE_CONT */
	
	/* Now we check the result of the syscall */
	if (sc_result == -ERESTARTNOINTR)
		ret = 0; /* Expected result: syscall was invalidated, no
			    syscall restart is done */
	else if (sc_result == pid)
		ret = 1; /* This is wrong, as it is the normal result of
			    getpid(). Probably host did a syscall restart! */
	else
		ret = 2; /* We don't know, what happened. There may be a bug in
			    this test tool */

	/* Give father a status indicating success or failure */
	exit(ret);
}

static void errout(char *str, int error)
{
	printf(str, error);
	putchar('\n');
	exit(1);
}

static int start_ptraced_child(void **stack_out)
{
	void *stack;
	unsigned long sp;
	int pid, n, status;
	
	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if(stack == MAP_FAILED)
		errout("start_ptraced_child : mmap failed, errno = %d", errno);
	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
	pid = __clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
	if(pid < 0)
		errout("start_ptraced_child : clone failed, errno = %d", errno);
	n = waitpid(pid, &status, WUNTRACED);
	if(n < 0)
		errout("start_ptraced_child : wait failed, errno = %d", errno);
	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP))
		errout("start_ptraced_child : expected SIGSTOP, "
		       "got status = 0x%x", status);

	*stack_out = stack;
	return(pid);
}

static int stop_ptraced_child(int pid, void *stack)
{
	int status, n;

	/* We resume our child and let it check it's result */
	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
		errout("stop_ptraced_child : ptrace failed, errno = %d", errno);

	/* Now, we wait for the child to exit */
	n = waitpid(pid, &status, 0);
	if(!WIFEXITED(status))
		errout("\nstop_ptraced_child: error: child didn't exit,"
		       " status 0x%x\n", status);

	if(munmap(stack, PAGE_SIZE) < 0)
		errout("stop_ptraced_child : munmap failed, errno = %d", errno);

	/* Return child's exit status */
	return WEXITSTATUS(status);
}

int main(void)
{
	void *stack;
	int pid, syscall, n, status;
	unsigned long addr;

	printf("Checking if syscall restart handling in host can be skipped...");
	fflush(stdout);

	/* First create a child and wait, until it stops itself */
	pid = start_ptraced_child(&stack);

	/* Now resume the child */
	if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
		errout("check_restart_skip : ptrace failed, "
		       "errno = %d", errno);

	/* wait, until child does a syscall */
	n = waitpid(pid, &status, WUNTRACED);
	if(n < 0)
		errout("check_restart_skip : wait failed, "
		       "errno = %d", errno);
	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
		errout("check_restart_skip : expected "
		       "SIGTRAP, got status = %d", status);

	/* Check, if syscall is __NR_getpid */
	syscall = ptrace(PTRACE_PEEKUSR, pid, PT_GPR2, 0);
	if(syscall != __NR_getpid)
		errout("check_restart_skip: unexpected syscall %d\n", syscall);

	/* Modify syscall number to -1 */
	n = ptrace(PTRACE_POKEUSR, pid, PT_GPR2, -1);
	if(n < 0)
		errout("check_restart_skip : failed to "
		       "modify system call, errno = %d", errno);

	/* Resume child and wait for second syscall interception */
	if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
		errout("check_restart_skip : ptrace failed, "
		       "errno = %d", errno);
	n = waitpid(pid, &status, WUNTRACED);
	if(n < 0)
		errout("check_restart_skip : wait failed, "
		       "errno = %d", errno);
	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
		errout("check_restart_skip : expected "
		       "SIGTRAP, got status = %d", status);

	/* Now, modify PSW_ADDR to skip second syscall */
	addr = ptrace(PTRACE_PEEKUSR, pid, PT_PSWADDR, 0);
	n = ptrace(PTRACE_POKEUSR, pid, PT_PSWADDR, addr+6);
	if(n < 0)
		errout("check_restart_skip : failed to modify PSWADDR,"
		       " errno = %d", errno);

	/* Set syscall result to -ERESTARTNOINTR */
	n = ptrace(PTRACE_POKEUSR, pid, PT_GPR2, -ERESTARTNOINTR);
	if(n < 0)
		errout("check_restart_skip : failed to modify system "
		       "call result, errno = %d", errno);

	/* Here "accidentally" a signal is queued for the child */
	kill(pid, SIGALRM);

	/* We resume the child again and wait for next interception */
	if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
		errout("check_restart_skip : ptrace failed, "
		       "errno = %d", errno);
	n = waitpid(pid, &status, WUNTRACED);
	if(n < 0)
		errout("check_restart_skip : wait failed, "
		       "errno = %d", errno);

	/* The interception must be for the signal, not for a syscall
	   Here, UML would do some interrupt processing */
	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGALRM))
		errout("check_restart_skip : expected "
		       "SIGALRM, got status = %d", status);

	/* At the end of interrupt processing, UML would resume the child
	 * doing ptrace(PTRACE_SYSCALL), but without modifying the regs.
	 * Here we call stop_ptraced_child, which will resume the child
	 * with ptrace(PTRACE_CONT). Then the child will check the "result"
	 * and will exit with
	 *    0 if the result is -ERESTARTNOINTR
	 *    1 if the result is child's pid (host did syscall restart)
	 *    2 if we have an unexpected result
	 */
	n = stop_ptraced_child(pid, stack);
	if (n)
		printf("failed, result = %d\n", n);
	else
		printf("OK\n");

	return n;
}

--------------090506040807090608040206--
