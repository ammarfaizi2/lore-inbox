Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbUBBClp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 21:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUBBClo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 21:41:44 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:29851 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265563AbUBBClk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 21:41:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 1 Feb 2004 18:41:41 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
In-Reply-To: <20040202005212.GA26719@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0402011840130.12618-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004, Daniel Jacobowitz wrote:

> On Sun, Feb 01, 2004 at 01:41:48PM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Sun, 1 Feb 2004, Daniel Jacobowitz wrote:
> > > 
> > > Here you go.  The bug turns out not to be related directly to
> > > CLONE_DETACHED.  Compile testcase with -DNOTHREAD to use fork (well,
> > > clone, but without the fancy flags), without -DNOTHREAD to use
> > > CLONE_DETACHED | CLONE_THREAD.
> > 
> > I don't think this bug has anything to do with anything else.
> > 
> > This program seems to show that PTRACE_KILL simply doesn't work.
> 
> > and the thing is, it looks like the signal handling changes have totally
> > made the child ignore the "exit_code" thing, unless I'm seriously
> > misreading something.
> 
> That may be (though I don't think so) but it reproduces without
> PTRACE_KILL too.  Try the attached, which just replaced PTRACE_KILL
> with PTRACE_CONT/tkill(pid, SIGKILL).  Still get zombies.  I haven't
> tried reproducing entirely without ptrace yet.

Here w/out ptrace works as advertised.



- Davide




/* -DBUG to kill the parent before the child -> hang.  */
/* -DNOTHREAD to us fork instead of clone.  */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <signal.h>
#include <sched.h>
#include <errno.h>
#include <sys/wait.h>


int stack_one[8192], stack_two[8192];
int fds1[2], fds2[2];


int thread_func_two()
{

	fprintf(stdout, "Thread 2: ppid = %d\n", getppid());
	while (1) {
		sleep (1);
		fprintf(stdout, "Thread 2: ppid = %d\n", getppid());
	}
}

int thread_func_one()
{
	int ret;

	fprintf(stdout, "Thread 1\n");

	read(fds1[0], &ret, sizeof(int));

	fprintf(stdout, "Thread 1 cloning\n");

	ret = clone (thread_func_two, stack_two + 8192,
#ifdef NOTHREAD
		     SIGCHLD,
#else
		     CLONE_DETACHED | CLONE_THREAD | CLONE_SIGHAND | CLONE_VM | CLONE_FS,
#endif
		     NULL);

	fprintf(stdout, "child2 = %d\n", ret);

	write(fds2[1], &ret, sizeof(int));

	fprintf(stdout, "Thread 1 sleeping\n");
	while (1)
		sleep (1);
}

int main()
{
	int ret, wstat, child, child2;

	if (pipe(fds1) < 0 || pipe(fds2)) {
		perror("pipe");
		return 1;
	}

	child = fork();
	if (child == 0)
		return thread_func_one();

	fprintf(stdout, "child = %d\n", child);

	write(fds1[1], &child, sizeof(int));
	read(fds2[0], &child2, sizeof(int));

	fprintf(stdout, "parent got child2 = %d\n", child2);

#ifndef BUG
	kill(child2, SIGKILL);
	ret = waitpid (child2, &wstat, __WALL);
	fprintf(stdout, "waitpid(%d) = %d (%s)\n", child2, ret, strerror(errno));
#endif

	kill(child, SIGKILL);
	ret = waitpid (child, &wstat, __WALL);
	fprintf(stdout, "waitpid(%d) = %d (%s)\n", child, ret, strerror(errno));

#ifdef BUG
	sleep(2);

	kill(child2, SIGKILL);
	ret = waitpid (child2, &wstat, __WALL);
	fprintf(stdout, "waitpid(%d) = %d (%s)\n", child2, ret, strerror(errno));
#endif

	return 0;
}



