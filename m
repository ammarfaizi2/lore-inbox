Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292554AbSCGESZ>; Wed, 6 Mar 2002 23:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292873AbSCGESQ>; Wed, 6 Mar 2002 23:18:16 -0500
Received: from [202.135.142.194] ([202.135.142.194]:43019 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S292554AbSCGESN>; Wed, 6 Mar 2002 23:18:13 -0500
Date: Thu, 7 Mar 2002 15:21:31 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: Futexes V :
Message-Id: <20020307152131.610b4c2e.rusty@rustcorp.com.au>
In-Reply-To: <20020306203522.4994A3FE06@smtp.linux.ibm.com>
In-Reply-To: <E16i8x2-0008TV-00@wagner.rustcorp.com.au>
	<20020306185420.29df1bf2.rusty@rustcorp.com.au>
	<20020306161229.0821D3FE06@smtp.linux.ibm.com>
	<20020306203522.4994A3FE06@smtp.linux.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002 15:36:25 -0500
Hubertus Franke <frankeh@watson.ibm.com> wrote:

> On Wednesday 06 March 2002 11:13 am, Hubertus Franke wrote:
> 
> I cut a new version with what I was previously discussing.
> Now we have two kind of wakeup mechanism 
> 
> (a) regular wakeup   (as was) which basically gives you convoy avoidance
> (b) fair wakeup         (will first wake a waiting process up .. FIFO)
> 
> Basically integrated 2 prior patches of Rusty

I like your numbers.  Since I think fairness is nice, but lack of starvation
is vital, I've been trying to starve a process.

So far, I've not managed it.  Please hack on the below code, and see if
you can manage it.  If not, I think we can say "not a problem in real life",
and just stick with the fastest implementation.

Thanks!
Rusty.

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>
#include <signal.h>
#include "usersem.h"

#ifndef PROT_SEM
#define PROT_SEM 0x8
#endif


static void spinner(struct futex *sem, int hold)
{
	while (1) {
		futex_down(sem);
		if (hold) sleep(1);
		futex_up(sem);
	}
}

/* Test maximum time to lock given furious spinners. */
int main(int argc, char *argv[])
{
	struct futex *sem;
	unsigned int i;
	unsigned long maxtime = 0;
	pid_t children[100];

	if (argc != 3) {
		fprintf(stderr, "Usage: starve <numspinners> <iterations>\n");
		exit(1);
	}

	sem = malloc(sizeof(*sem));
	futex_region(sem, sizeof(*sem));
	futex_init(sem);
	for (i = 0; i < atoi(argv[1]); i++) {
		children[i] = fork();
		if (children[i] == 0)
			spinner(sem, i < atoi(argv[1])/2);
	}

	for (i = 0; i < atoi(argv[2]); i++) {
		struct timeval start, end, diff;

		sleep(1);
		gettimeofday(&start, NULL);
		futex_down(sem);
		gettimeofday(&end, NULL);
		futex_up(sem);
		timersub(&end, &start, &diff);
		printf("Wait time: %lu.%06lu\n", diff.tv_sec, diff.tv_usec);
		if (diff.tv_sec * 1000000 + diff.tv_usec > maxtime)
			maxtime = diff.tv_sec * 1000000 + diff.tv_usec;
	}

	/* Kill children */
	for (i = 0; i < atoi(argv[1]); i++)
		kill(children[i], SIGTERM);

	printf("Worst case: %lu\n", maxtime);
	exit(0);
}

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
