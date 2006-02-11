Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWBKC6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWBKC6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 21:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWBKC57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 21:57:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:63419 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932122AbWBKC57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 21:57:59 -0500
Subject: [BUG -rt] -rt16 hang w/ realtime thread test
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Content-Type: multipart/mixed; boundary="=-xzODBkNk9kTFmCpvJal4"
Date: Fri, 10 Feb 2006 18:57:54 -0800
Message-Id: <1139626674.28536.30.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xzODBkNk9kTFmCpvJal4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Ingo,
	I've been hunting a report that lower priority realtime threads are not
preempting higher priority realtime threads. However, in generating test
cases, I found I was locking the system quite frequently.

The attached test runs to completion on 2.6.15, but with 2.6.15-rt16, it
hangs the box. It could very well be a test issue, but I'm not sure I
see where the problem is.

thanks
-john


--=-xzODBkNk9kTFmCpvJal4
Content-Disposition: attachment; filename=hangbox.c
Content-Type: text/x-csrc; name=hangbox.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <time.h>
#include <string.h>
#include <pthread.h>
#include <sched.h>
#include <errno.h>
#include <sys/syscall.h>


#define MAXTHREADS 256
#define TEST_LENGTH 5

volatile int test_finished;
volatile int running_count;

pthread_mutex_t     mutex = PTHREAD_MUTEX_INITIALIZER;


void *busy(void* arg)
{
	struct timeval start, now;

    	pthread_mutex_lock(&mutex);
	running_count = running_count + 1;
    	pthread_mutex_unlock(&mutex);

	gettimeofday(&start,0);
	while (!test_finished){
		gettimeofday(&now,0);
		if (now.tv_sec - start.tv_sec > 10) {
			printf("Something is broken\n");
			break;
		}
		sched_yield();
	}
    	pthread_mutex_lock(&mutex);
	running_count--;
    	pthread_mutex_unlock(&mutex);

}

void create_thread(pthread_t *thread, void*(*func)(void*), int prio)
{
	pthread_attr_t attr;
	struct sched_param param;

	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + prio;

	pthread_attr_init(&attr);
	pthread_attr_setinheritsched (&attr, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedparam(&attr, &param);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

	if (pthread_create(thread, &attr, func, (void *)0)) {
		perror("pthread_create failed");
	}

	pthread_attr_destroy(&attr);
}

int main(int argc, char* argv[])
{
	struct sched_param param;
	int num_threads;
	int priority;
	int thread_count = 0;
	pthread_t thread_id[MAXTHREADS];
	int i;

	if (argc != 2) {
		printf("Usage: %s num_threads\n", argv[0]);
		exit(1);
	}

	num_threads = atoi(argv[1]);


	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + 80;
	sched_setscheduler(0, SCHED_FIFO, &param);

	priority = 30;
	for (i = 0; i < num_threads; i++)
		create_thread(&thread_id[thread_count++],
				busy, priority);
	while (running_count < num_threads)
		usleep(100);


	sleep(TEST_LENGTH);
	test_finished = 1;

	for (i = 0; i < thread_count; i++)
		pthread_join(thread_id[i], 0);

	return 0;
}


--=-xzODBkNk9kTFmCpvJal4--

