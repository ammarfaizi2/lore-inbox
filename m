Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbUL3BPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUL3BPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUL3BPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:15:23 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:15069 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261477AbUL3BOA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:14:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 29 Dec 2004 17:13:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> 
 <53046857041229114077eb4d1d@mail.gmail.com>  <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
 <530468570412291343d1478cf@mail.gmail.com> <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Linus Torvalds wrote:

> On Wed, 29 Dec 2004, Jesse Allen wrote:
> > > 
> > > So instead of removing the setting of TIF_SINGLESTEP in set_singlestep(),
> > > can you test whether removing the _testing_ of it in do_syscall_trace()
> > > makes things happier for you? Hmm?
> > > 
> > 
> > Yes, doing that does work.  But I still have to remove the conditional
> > TF clear.  Here's the diff now to show you.
> 
> Ok. That's a good piece of information. 
> 
> I don't actually understand why do_syscall_trace() does that 
> TIF_SINGLESTEP test in the first place, since the ptrace_notify() should 
> happen as part of the _normal_ TIF_SINGLESTEP handling, afaiks. No 
> apparent need to do it in syscall tracing, and do_syscall_trace() does 
> that bogus fake signal sending.
> 
> Hmm.. That TF_SINGLESTEP test was added by Davide Libenzi in August, and I
> think Davide had some test for exactly this. Davide? Can you recall why
> you did this in the system call tracing code, rather than depend on the
> regular TIF_SINGLESTEP handling in arch/i386/kernel/signal.c:
> do_notify_resume()?

That test went in to be able to have ptrace single step, to see even the 
instruction following the #int instruction (this was the target of the 
patch itself). I just verified that, in 2.6.8 that does not have such test 
anymore, the single-step-after-int capability is lost. Below I inlining a 
simple test program (that I already sent you time ago) to test this. In my 
2.6.8 I get this output:

waiting ...
done: pid=21398  status=1407
sig=5
EIP=0x080485d5
waiting ...
done: pid=21398  status=1407
sig=5
EIP=0x080485da
waiting ...
done: pid=21398  status=1407
sig=5
EIP=0x080485df
waiting ...
done: pid=21398  status=1407
sig=5
EIP=0x080485d5
waiting ...
done: pid=21398  status=1407
sig=5
EIP=0x080485da
waiting ...
done: pid=21398  status=1407
sig=5
EIP=0x080485df

in front of this code:

80485d5:       b8 14 00 00 00          mov    $0x14,%eax
80485da:       cd 80                   int    $0x80
80485dc:       89 45 ec                mov    %eax,0xffffffec(%ebp)
80485df:       eb f4                   jmp    80485d5 <main+0x85>
 
You can see that the "mov %eax,0xffffffec(%ebp)" instruction at 0x80485dc 
is not seen by ptrace single step. With the test in place, it will show up 
again in your traces.



- Davide





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

