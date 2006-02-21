Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWBUXIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWBUXIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWBUXIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:08:48 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:36058 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751208AbWBUXIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:08:47 -0500
Date: Tue, 21 Feb 2006 18:03:25 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: another possible singlestep fix
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602211806_MC3-1-B8F2-C8A7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0602171412210.916@g5.osdl.org>

On Fri, 17 Feb 2006 at 14:14:06 -0800, Linus Torvalds wrote:
> 
> On Fri, 17 Feb 2006, Chuck Ebbert wrote:
> >
> > When entering kernel via int80, TIF_SINGLESTEP is not set
> > when TF has been set in eflags by the user.  This patch
> > does that.
> 
> This really shouldn't matter.
> 
> When we enter the kernel through "int 0x80", we don't need to do anything 
> about TIF_SINGLESTEP, because unlike the "sysenter" path, the "int" 
> instruction will automatically do the right thing (save old eflags on the 
> stack).
> 
> So afaik, this won't actually do anything (except make _the_ most 
> timing-critical path in the kernel slower). Have you actually seen any 
> effects of it?

OK, I found what I was looking for.  If TIF_SINGLESTEP is not set and
someone is ptracing us, do_syscall_trace() never gets called on syscall
exit [see entry.S::syscall_exit_work] and thus send_sigtrap() doesn't get
called [ptrace.c line 699].  The result is some missed SIGTRAPS and in
the case of returning from signal handlers, tracing just stops.

Here is output from the below test program before and after applying the patch.
(I used i386-allow-disabling-x86_feature_sep-at-boot.patch from -mm and booted
with the 'nosep' option for these tests.)

Here is the program's output before patching:

child stopped @ ffffe402, signal 10, eflags 00000246 [syscall ret = 0]
Passing signal 10 to child...
child stopped @ 0804854c, signal 5, eflags 00000246
child stopped @ 0804854d, signal 5, eflags 00000246
child stopped @ 0804854f, signal 5, eflags 00000246
child stopped @ 08048554, signal 5, eflags 00000246
child stopped @ ffffe400, signal 5, eflags 00000246 [syscall #20]
child stopped @ 0804855a, signal 5, eflags 00000246
child stopped @ 0804855b, signal 5, eflags 00000246
child stopped @ ffffe440, signal 5, eflags 00000246 [sigreturn]
child stopped @ ffffe445, signal 5, eflags 00000246
child exited with retcode 0


And here is output afterward.  Note the signal delivery upon
syscall exit and much more output.  Also you can see the final
syscall made by the child [sys_exit_group]:

child stopped @ ffffe402, signal 10, eflags 00000246 [syscall ret = 0]
Passing signal 10 to child...
child stopped @ 0804854c, signal 5, eflags 00000246
child stopped @ 0804854d, signal 5, eflags 00000246
child stopped @ 0804854f, signal 5, eflags 00000246
child stopped @ 08048554, signal 5, eflags 00000246
child stopped @ ffffe400, signal 5, eflags 00000246 [syscall #20]
child stopped @ ffffe402, signal 5, eflags 00000246 [syscall ret = 1855]
child stopped @ 0804855a, signal 5, eflags 00000246
child stopped @ 0804855b, signal 5, eflags 00000246
child stopped @ ffffe440, signal 5, eflags 00000246 [sigreturn]
child stopped @ ffffe445, signal 5, eflags 00000246
child stopped @ ffffe402, signal 5, eflags 00000246 [syscall ret = 0]
child stopped @ 080485b4, signal 5, eflags 00000217
<..................... 29 lines skipped .......................>
child stopped @ ffffe400, signal 5, eflags 00000246 [syscall #252]
child exited with retcode 0


/* ptrace test program 
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <asm/user.h>

#define GETPID	20
//#define ENTER_KERNEL "int $0x80\n\t"
#define ENTER_KERNEL "call *vsyscall_addr\n\t"

static int parent, child, status;
static struct user_regs_struct regs;
static struct sigaction sa;
static void * const vsyscall_addr = (void *)0xffffe400;

static void handler(int nr, siginfo_t *si, void *vuc)
{
	asm (ENTER_KERNEL : : "a" (GETPID));
}

void do_child()
{
	child = getpid();

	sa.sa_sigaction = handler;
	sa.sa_flags     = SA_SIGINFO;
	sigaction(SIGUSR1, &sa, NULL);

	ptrace(PTRACE_TRACEME, 0, 0, 0);
	kill(child, SIGUSR1);
}

void do_parent()
{
	unsigned long eip;
again:
	waitpid(child, &status, 0);
	if (WIFEXITED(status)) {
		fprintf(stderr, "child exited with retcode %d\n",
				WEXITSTATUS(status));
		return;
	}
	if (WIFSIGNALED(status)) {
		fprintf(stderr, "child exited on unhandled signal %d\n",
				WTERMSIG(status));
		return;
	}
	if (WIFSTOPPED(status)) {
		int signo = WSTOPSIG(status);
		ptrace(PTRACE_GETREGS, child, 0, &regs);

		eip = regs.eip;
		if (eip >> 24 != 0x08 && eip >> 8 != 0xffffe4)
			goto skip_print;

		fprintf(stderr, "child stopped @ %08x, signal %d, eflags %08x",
				eip, signo, (unsigned long)regs.eflags);
		if (eip == 0xffffe400)
			fprintf(stderr, " [syscall #%d]", (int)regs.eax);
		/* vsyscall-int80 returns to 0xffffe402 and there is a 'ret' there */
		if (eip == 0xffffe410 || (eip == 0xffffe402 && *(unsigned char *)eip == 0xc3))
			fprintf(stderr, " [syscall ret = %d]", (int)regs.eax);
		if (eip == 0xffffe420 || eip == 0xffffe440)
			fprintf(stderr, " [sigreturn]");
		fprintf(stderr, "\n");
	skip_print:
		if (signo == SIGTRAP) signo = 0;
		if (signo)
			fprintf(stderr, "Passing signal %d to child...\n", signo);
		ptrace(PTRACE_SINGLESTEP, child, NULL, (void *)signo);
	}
	goto again;
}


int main(int argc, char * const argv[])
{
	parent = getpid();
	child  = fork();

	if (child) do_parent();
	else	   do_child();

	return 0;
}
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
