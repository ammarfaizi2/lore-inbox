Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbUKVNuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbUKVNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbUKVNsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:48:55 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:19647 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262106AbUKVNqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:46:45 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 22 Nov 2004 05:46:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411220539270.19254@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de>
 <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004, Linus Torvalds wrote:

> Ok, how about this patch?
> 
> It does basically two things:
> 
>  - it makes the x86 version of ptrace be a lot more careful about the TF 
>    bit in eflags, and in particular it never touches it _unless_ the 
>    tracer has explicitly asked for it (ie we set TF only when doing a
>    PTRACE_SINGESTEP, and we clear it only when it has been set by us, not 
>    if it has been set by the program itself).
> 
>    This patch also cleans up the codepaths by doing all the common stuff
>    in set_singlestep()/clear_singlestep().
> 
>  - It clarifies signal handling, and makes it clear that we always push 
>    the full eflags onto the signal stack, _except_ if the TF bit was set 
>    by an external ptrace user, in which case we hide it so that the tracee 
>    doesn't see it when it looks at its stack contents.
> 
>    It also adds a few comments, and makes it clear that the signal handler
>    itself is always set up with TF _clear_. But if we were single-stepped 
>    into it, we will have notified the debugger, so the debugger obviously 
>    can (and often will) decide to continue single-stepping.

Looks like a nice cleanup. What does the test program below print for you?



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


