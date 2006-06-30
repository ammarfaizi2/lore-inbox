Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWF3QCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWF3QCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWF3QCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:02:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:59343 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932234AbWF3QCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:02:36 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH -RT]Re: 2.6.17-rt1 - mm_struct leak
Date: Fri, 30 Jun 2006 09:02:32 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060618070641.GA6759@elte.hu> <200606231356.56267.vernux@us.ibm.com>
In-Reply-To: <200606231356.56267.vernux@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZsUpETSBAq2aMrO"
Message-Id: <200606300902.33017.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ZsUpETSBAq2aMrO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 23 June 2006 13:56, Vernon Mauery wrote:
> On Sunday 18 June 2006 00:06, Ingo Molnar wrote:
> > i have released the 2.6.17-rt1 tree, which can be downloaded from the
> > usual place:
>
> I was given a test case to run that seemed to cause the machine to run the
> OOM-killer after a bunch of iterations.  The test was run like:
>
> $ for ((i=0;i<50000;i++)); do ./test; done
>
> and somewhere in there, the LowFree would drop very low and the test and
> the bash shell running it would get killed.  And then since that didn't
> free up much memory, the machine would become very unresponsive and would
> have to be rebooted.

I found the problem -- it was in the PI futex code -- lock_queue was getting 
called essentially twice in a row and was continually incrementing the 
mm_count ref count, thus causing the memory leak.  Not completely 
understanding all the intricacies of the PI futex code, I just suggested to 
no make the second call to lock_queue (not realizing __queue_me unlocks the 
queue).  Dinakar Guniguntala provided a proper fix for the problem that 
simply grabs the spinlock for the hash bucket queue rather than calling 
lock_queue.  His fix is below and applies to 2.6.17-rt4.

Attached is a test case I wrote to reproduce the problem.

--Vernon

The second time we do a queue_lock in futex_lock_pi, we really only need to 
take the hash bucket lock.

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
Acked-by: Paul E. McKenney <paulmck@us.ibm.com>

Index: linux-2.6.17-rt4/kernel/futex.c
===================================================================
--- a/kernel/futex.c	2006-06-30 04:39:29.000000000 -0700
+++ b/kernel/futex.c	2006-06-30 04:46:52.000000000 -0700
@@ -1269,7 +1269,7 @@
 	}
 
 	down_read(&curr->mm->mmap_sem);
-	hb = queue_lock(&q, -1, NULL);
+	spin_lock(q.lock_ptr);
 
 	/*
 	 * Got the lock. We might not be the anticipated owner if we




--Boundary-00=_ZsUpETSBAq2aMrO
Content-Type: text/plain;
  charset="iso-8859-1";
  name="mm_leak.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="mm_leak.c"

/*    Filename: mm_leak.c
 *      Author: Vernon Mauery <vernux@us.ibm.com>
 * Description: force a kernel memory leak using pi mutexes
 * Compilation: gcc mm_leak.c -lm -L/usr/lib/nptl -lpthread -lrt -D_GNU_SOURCE -I/usr/include/nptl -o mm_leak
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (C) IBM Corporation, 2006
 *
 * 2006-May-3:	Initial version by Darren Hart <dvhltc@us.ibm.com>
 * 2006-May-4:  Timing fixes reported by Vernon Mauery <vernux@us.ibm.com>
 * 2006-May-4:  Made the med prio threads RT by Darren Hart <dvhltc@us.ibm.com>
 * 2006-May-5:  Modified to use flagging by Vernon Mauery <vernux@us.ibm.com>
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <sched.h>

#define HIGH_PRIO 15
#define ITERATIONS 100

static int count = 0;
static pthread_mutex_t pi_mutex;

struct thread {
	pthread_t pthread;
	pthread_attr_t attr;
};

int create_fifo_thread(struct thread *thread, void*(*func)(void*), void *arg, int prio)
{
	struct sched_param param;

	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + prio;

	pthread_attr_init(&thread->attr);
	pthread_attr_setinheritsched(&thread->attr, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedparam(&thread->attr, &param);
	pthread_attr_setschedpolicy(&thread->attr, SCHED_FIFO);

	if (pthread_create(&thread->pthread, &thread->attr, func, (void*)arg)) {
		perror("pthread_create failed");
		return 1;
	}

	pthread_attr_destroy(&thread->attr);
	return 0;
}

void init_pi_mutex(pthread_mutex_t *m, int use_pi)
{
	pthread_mutexattr_t attr;
	int ret;
	int protocol;

	if (pthread_mutexattr_init(&attr) != 0) {
		printf("Failed to init mutexattr\n");
	}
	if (use_pi) {
		if (pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT) != 0) {
			printf("Can't set protocol prio inherit\n");
		}
	}
	if (pthread_mutexattr_getprotocol(&attr, &protocol) != 0) {
		printf("Can't get mutexattr protocol\n");
	}
	if ((ret = pthread_mutex_init(m, &attr)) != 0) {
		printf("Failed to init mutex: %d\n", ret);
	}
	
	/* FIXME: does any of this need to be destroyed ? */
}

#define THREADS 2
void *thread_one(void *arg)
{
	int iterations = (int)arg;
	while (count < iterations) {
		while (1) {
			pthread_mutex_lock(&pi_mutex);
			if (count % THREADS == 1)
				break;
			pthread_mutex_unlock(&pi_mutex);
			usleep(10);
		}
		printf("1"); fflush(NULL);
		count++;
		pthread_mutex_unlock(&pi_mutex);
	}
	return NULL;
}

void *thread_zero(void *arg) {
	int iterations = (int)arg;
	while (count < iterations) {
		while (1) {
			pthread_mutex_lock(&pi_mutex);
			if (count % THREADS == 0)
				break;
			pthread_mutex_unlock(&pi_mutex);
			usleep(1);
		}
		printf("0"); fflush(NULL);
		count++;
		pthread_mutex_unlock(&pi_mutex);
	}
	return NULL;
}

int main(int argc, char *argv[])
{
	struct thread one;
	int iterations = ITERATIONS;
	int pi = 1, c;

	while ((c=getopt(argc, argv, "i:ph")) >= 0) {
		if (c == 'i') {
			iterations = atoi(optarg);
		} else if (c == 'p') {
			pi = 0;
		} else {
			printf("usage: %s [-i iterations] [-p] [-h]\n", argv[0]);
			printf("\t -i iterations\n");
			printf("\t -p -- do not use pi mutexes\n");
			printf("\t -h -- print this message\n");
			exit(0);
		}
	}

	/* creating the mutex as a PI mutex causes a kernel memory leak */
	init_pi_mutex(&pi_mutex, pi);

	create_fifo_thread(&one, thread_one, (void*)iterations, HIGH_PRIO);

	thread_zero((void*)iterations);

	pthread_join(one.pthread, NULL);
	printf("\n");
	return 0;
}

--Boundary-00=_ZsUpETSBAq2aMrO--
