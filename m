Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271180AbRHUWcb>; Tue, 21 Aug 2001 18:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRHUWcU>; Tue, 21 Aug 2001 18:32:20 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:20740 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S271180AbRHUWcM>;
	Tue, 21 Aug 2001 18:32:12 -0400
Date: Wed, 22 Aug 2001 01:32:57 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: lucho <lucho@haemimont.bg>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: The round robin scheduling policy doesn't work
Message-ID: <Pine.LNX.4.33.0108220015390.1077-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

lucho wrote:

> The round robin scheduling policy does not work.

	Yes, I tested it too and I see the same problems on UP and
on 2.2.19. But your example is wrong, see the appended one. In your
example the processes can block. May be this is the reason Richard to
generate different results. In the below example the child terminates
after the parent and is not scheduled for 2 seconds. I tested it with
more childs too but the showed is with one child. The scheduler looks
broken for SCHED_RR.

	For the kernel gurus: may be this is off-topic but isn't
possible the SCHED_FIFO semantic (schedule after process block) to
be implemented for these thread groups in 2.4. This will allow threads
that run in one group to use the SCHED_FIFO scheduling in their group but
not to block the other SCHED_OTHER processes. This will allow the
threads implementations to use something like spinlocks plus something
like postwait calls and will avoid the signal notifications that I see in
some of them. Why this semantic is allowed only for the real time
processes which usually block the normal SCHED_OTHER processes. I know
that the standards talk about scheduling contention scopes and two-level
scheduling models but it sounds too complex as a change. Is there
something working-in-progress for Linux that will allow such sched_fifo
semantics for normal non-realtime threads? How these thread groups
will be extended?

Regards

--
Julian Anastasov <ja@ssi.bg>


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#include <sched.h>

int child=0;

void sig (int a)
{
	time_t t;

	time(&t);
	printf("%s terminated - %ld\n",
		child? "child" : "parent", t);
	exit(1);
}

int main()
{
	struct sched_param sp;

	printf("Start: %ld\n", time(0));
	fflush(stdout);
	signal(SIGALRM, sig);
	sp.sched_priority = 1;
	sched_setscheduler(0, SCHED_RR, &sp);

	if (fork() == 0)
	{
		child = 1;
		sig(0);
	}
	else
	{
		alarm(2);
		while(1)
		{
			 sched_yield();
		}
	}

	return 0;
}


