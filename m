Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbTE1Sm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTE1Sm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 14:42:59 -0400
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.234.83]:28804 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S264827AbTE1Smy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 14:42:54 -0400
Date: Wed, 28 May 2003 14:56:15 -0400
Message-Id: <200305281856.h4SIuFZ02449@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: signal queue resource - Posix timers
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

In my continuing work to perfect posix timers, I have started thinking
about the problem of managing signal queuing resources.

The sigqueue structures used to queue siginfo_t structures are
allocated from a slab cache.  The system  limits this allocation to a 
maximum of 1024 queued signals.  This global limit means that 
a process may fail at the whim of an unrelated process.
The attached test program easily consumes all of the available 
sigqueue entries.  It blocks SIGRTMIN and sends itself 2000 SIGRTMIN
signals.  Running this program along with a posix timers test will 
cause the posix timers to fail.  Using realtime signals makes it easy
to consume this resource, but the failure could also occur with many
processes each having only a few pending signals.

Changing from a system wide limit to a per process limit would solve
most of this problem.  It does not protect against having the allocation
from the slab cache fail.  Posix timers are required to fail the 
timer_create with EAGAIN if "the system lacks sufficient signal queuing
resources to honor the request."  The current Linux posix-timers 
implementation doesn't do this.

I'm contemplating changes to kernel/signal.c to allow reserved or
pre-allocated sigqueue structures to be used.  The idea is to do the
allocation in the system call context so the failure can be returned to
the application.

In the pre-allocated approach, the timer code would allocate a sigqueue
structure as part of the timer_create.  I would add new send_sigqueue() and
send_group_sigqueue() which would accept the pointer to the pre-allocated
sigqueue structure rather than a siginfo pointer.  There would also be changes
to the code which dequeues the siginfo structure to recognize these
preallocated sigqueue structures.  In the case of Posix timers using a
preallocated siqueue entry also makes handling overruns easier.  If the timer
code finds that its sigqueue structure is still queued, it can simply increment
the overrun count.

The reservation approach would keep a pre-allocated pool of sigqueue
structures and a reservation count.  The timer_create would reserve
a sigqueue entry which would be place in the pool until it is needed.

I wonder if anyone else is interested in this problem.

Jim Houston - Concurrent Computer Corp.

--

/*
 * Example program which consumes all of the available sigqueue
 * structures.
 */
#include <unistd.h>
#include <stdio.h>
#include <signal.h>

void handler(int sig, siginfo_t *info, void *context)
{
	printf("handler called\n");
	printf("si_signo=%d si_code=%d si_errno=%d\n",
		info->si_signo, info->si_code, info->si_errno);
}

int main(int argc, char **argv)
{
	struct sigaction sa;
	sigset_t s;
	int i, ret;

	sa.sa_sigaction = &handler;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);
	if (sigaction(SIGRTMIN, &sa, 0) != 0) {
		perror("sigaction");
		exit(1);
	}
	sigemptyset(&s);
	sigaddset(&s, SIGRTMIN);
	if (sigprocmask(SIG_SETMASK, &s, NULL) != 0) {
		perror("sigprocmask");
		exit(1);
	}
	for (i = 0; i < 2000; i++)
		if ((ret = kill(getpid(), SIGRTMIN)))
			break;
	if (ret)
		perror("kill");

	sleep(5);
	sigemptyset(&s);
	if (sigprocmask(SIG_SETMASK, &s, NULL) != 0) {
		perror("sigprocmask");
		exit(1);
	}
	sleep(1);
	return(0);
}

