Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVAAWE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVAAWE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 17:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVAAWE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 17:04:29 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:2191 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261185AbVAAWEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 17:04:12 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 1 Jan 2005 14:04:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Jesse Allen <the3dfxdude@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412311359460.2280@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501011357030.3870@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <1104401393.5128.24.camel@gamecube.scs.ch>  <1104411980.3073.6.camel@littlegreen>
  <200412311413.16313.sailer@scs.ch>  <1104499860.3594.5.camel@littlegreen>
 <53046857041231074248b111d5@mail.gmail.com> <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412311359460.2280@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004, Linus Torvalds wrote:

> 
> 
> On Fri, 31 Dec 2004, Davide Libenzi wrote:
> > 
> > I don't think Linus ever posted a POPF-only patch. Try to comment those 
> > lines in his POPF patch ...
> 
> Here the two patches are independently, if people want to take a look.
> 
> If somebody wants to split (and test) the TF-careful thing further (the
> "send_sigtrap()" changes are independent, I think), that would be
> wonderful... Hint hint.

I used the test program below on 2.4.27, 2.6.8.1 and latest BK + TF-careful. 
In all cases single stepping over POPF succeeded. In the 2.4.27 and 2.6.8.1
cases, we lost the instruction following "int $0x80" (since 2.6.8.1 
removed the test I put in do_syscall_trace()). The latest BK plus TF-careful 
gets things right WRT single-step-after-syscall case. What was your test 
case about non-working single step over POPF?




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


#define INEXT(i, n) ((i + 1) % n)



int main(int ac, char **av) {
	int i, nins, miss, status, res;
	long start, end;
	long inss[32];
	pid_t cpid, pid;
	struct user_regs_struct ur;
	struct sigaction sa;

	sigemptyset(&sa.sa_mask);
	sa.sa_flags = 0;
	sa.sa_handler = SIG_DFL;
	sigaction(SIGCHLD, &sa, NULL);

	if (ac > 1) {
		fprintf(stderr, "tracee child: pid=%d\n", getpid());

	loop:
	l0:
		__asm__ volatile ("mov %0, %%eax\n\t":: "I" (__NR_getpid));
	l1:
		__asm__ volatile ("int $0x80\n\t");
	l2:
		__asm__ volatile ("xor %eax, %eax\n\t");
	l3:
		__asm__ volatile ("pushf\n\t");
	l4:
		__asm__ volatile ("pop %eax\n\t");
	l5:
		__asm__ volatile ("orl $0x100, %eax\n\t");
	l6:
		__asm__ volatile ("push %eax\n\t");
	l7:
		__asm__ volatile ("popf\n\t");
	l8:
		__asm__ volatile ("xor %eax, %eax\n\t");
	l9:
		goto loop;
	endloop:
		exit(0);
	}

	if ((cpid = fork()) == 0) {
		fprintf(stderr, "tracee: pid=%d\n", getpid());
		ptrace(PTRACE_TRACEME, 0, NULL, NULL);

		execl(av[0], av[0], "child", NULL);
		exit(1);
	}

	start = (long) &&loop;
	end = (long) &&endloop;
	nins = 0;
	inss[nins++] = (long) &&l0;
	inss[nins++] = (long) &&l1;
	inss[nins++] = (long) &&l2;
	inss[nins++] = (long) &&l3;
	inss[nins++] = (long) &&l4;
	inss[nins++] = (long) &&l5;
	inss[nins++] = (long) &&l6;
	inss[nins++] = (long) &&l7;
	inss[nins++] = (long) &&l8;
	inss[nins++] = (long) &&l9;

	fprintf(stderr, "tracer: child=%d\n", cpid);

	for (;;) {
		pid = wait(&status);
		if (pid != cpid)
			continue;
		res = WSTOPSIG(status);
		if (ptrace(PTRACE_GETREGS, pid, NULL, &ur)) {
			perror("ptrace(PTRACE_GETREGS)");
			return 1;
		}

		if (ptrace(PTRACE_SINGLESTEP, pid, NULL, res != SIGTRAP ? res: 0)) {
			perror("ptrace(PTRACE_SINGLESTEP)");
			return 1;
		}

		if (ur.eip == start)
			break;
	}
	fprintf(stdout, "EIP=0x%08x (0)\n", ur.eip);
	for (i = 1;;) {
		fprintf(stderr, "waiting ...\n");
		pid = wait(&status);
		fprintf(stderr, "done: pid=%d  status=0x%08x (%d)\n",
			pid, status, status);
		if (pid != cpid)
			continue;
		res = WSTOPSIG(status);
		fprintf(stderr, "sig=%d\n", res);
		if (ptrace(PTRACE_GETREGS, pid, NULL, &ur)) {
			perror("ptrace(PTRACE_GETREGS)");
			return 1;
		}
		for (miss = 0; miss < nins && inss[i] != ur.eip; miss++) {
			fprintf(stderr, "missed ins at 0x%08x (%d)\n", inss[i], i);
			i = INEXT(i, nins);
		}
		if (miss == nins) {
			fprintf(stderr, "EIP=0x%08x - lost contact with apollo-%d\n",
				ur.eip, cpid);
			break;
		}
		fprintf(stdout, "EIP=0x%08x (%d)\n", ur.eip, i);
		i = INEXT(i, nins);
		if (ur.eip == start)
			break;

		if (ptrace(PTRACE_SINGLESTEP, pid, NULL, res != SIGTRAP ? res: 0)) {
			perror("ptrace(PTRACE_SINGLESTEP)");
			return 1;
		}
	}
	if (ptrace(PTRACE_CONT, cpid, NULL, SIGKILL)) {
		perror("ptrace(PTRACE_CONT)");
		return 1;
	}

	return 0;
}

