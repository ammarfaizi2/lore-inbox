Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131278AbRCKGxK>; Sun, 11 Mar 2001 01:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131282AbRCKGxA>; Sun, 11 Mar 2001 01:53:00 -0500
Received: from linuxcare.com.au ([203.29.91.49]:52490 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131278AbRCKGw4>; Sun, 11 Mar 2001 01:52:56 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sun, 11 Mar 2001 17:50:22 +1100
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: Jonathan Lahr <lahr@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
Message-ID: <20010311175022.E1951@linuxcare.com>
In-Reply-To: <20010306144552.G6451@w-lahr.des.sequent.com> <Pine.LNX.4.10.10103062318190.26554-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.10.10103062318190.26554-100000@sphinx.mythic-beasts.com>; from matthew@hairy.beasts.org on Tue, Mar 06, 2001 at 11:39:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> In the slow path of a spinlock_acquire they busy wait for a few
> cycles, and then call schedule with a zero timeout assuming that
> it'll basically do the same as a sched_yield() but more portably.

The obvious problem with this is that we bounce in and out of schedule()
a few times before moving on to the next task. I see this also with
sched_yield().

I had this patch lying around which I think came about when I was playing
with pthreads (which for spinlocks does sched_yield() for a while before
sleeping)

--- linux/kernel/sched.c	Fri Mar  9 10:26:56 2001
+++ linux_intel/kernel/sched.c	Fri Mar  9 08:42:39 2001
@@ -505,6 +505,9 @@
 		goto out_unlock;
 	}
 #else
+	if (prev->policy & SCHED_YIELD)
+		prev->counter = (prev->counter >> 4);
+
 	prev->policy &= ~SCHED_YIELD;
 #endif /* CONFIG_SMP */
 }

Anton


/* test sched_yield */

#include <stdio.h>
#include <sched.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#undef USE_SELECT

void waste_time()
{
	int i;
	for(i = 0; i < 10000; i++)
		;
}

void do_stuff(int i)
{
#ifdef USE_SELECT
	struct timeval tv;
#endif

	while(1) {
		fprintf(stderr, "%d\n", i);
		waste_time();
#ifdef USE_SELECT
		tv.tv_sec = 0;
		tv.tv_usec = 0;
		select(0, NULL, NULL, NULL, &tv);
#else
		sched_yield();
#endif
	}
}

int main()
{
	int i, pid;

	for(i = 0; i < 10; i++) {
		pid = fork();

		if (!pid)
			do_stuff(i);
	}

	do_stuff(i+1);

	return 0;
}
