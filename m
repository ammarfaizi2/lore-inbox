Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUKWUxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUKWUxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUKWUwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:52:31 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:11651 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261471AbUKWUls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:41:48 -0500
Message-ID: <41A3A0BC.9080006@sgi.com>
Date: Tue, 23 Nov 2004 14:42:36 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, Dean Roe <roe@sgi.com>,
       Brian Sumner <bls@sgi.com>, John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: scalability of signal delivery for Posix Threads
References: <41A20AF3.9030408@sgi.com> <20041122171932.GA19440@lnx-holt.americas.sgi.com>
In-Reply-To: <20041122171932.GA19440@lnx-holt.americas.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------020803050208060509030506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020803050208060509030506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Robin Holt wrote:

> 
> Ray, can you provide a simple example application that trips this case?
> 

Robin,

Attached is a pthreads program (y.c) that exercises the scaling problem
discussed above.

Compile this as: gcc y.c -o y -lpthread -lm

Call it as: ./y nthread

We start to see problems on Altix with this program at around 76 cpus.

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

--------------020803050208060509030506
Content-Type: text/plain;
 name="y.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="y.c"


#define _GNU_SOURCE

#include <sys/syscall.h>
#include <pthread.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <signal.h>
#include <errno.h>

#define NITER 100000000
#define perrorx(s)      (perror(s), exit(1))
#define MAX_THREADS 512
#define CACHE_LINE_SIZE 128
#define __cache_aligned __attribute__((__aligned__(CACHE_LINE_SIZE)))

static struct itimerval itv;

/* this makes count a per thread variable */
static __thread unsigned volatile long count;

pthread_t ptid[MAX_THREADS];
struct child_state_struct {
	int 	state;
	pid_t 	tid;
	long    start_count;
	long    end_count;
	double  result;
	char    filler[CACHE_LINE_SIZE - (sizeof(int)+sizeof(pid_t)+2*sizeof(long)+sizeof(double))];
};
struct child_state_struct child_state[MAX_THREADS] __cache_aligned;

volatile int go __cache_aligned = 0;
char filler[CACHE_LINE_SIZE - (sizeof(int))];

static void
sigprof_handler(int signo, struct siginfo *sip, void *scp)
{
    ++count;
}

void *func(void *arg)
{
    int i, id = (int)(long)arg;
    double a = 0.1;
    pid_t tid;

    tid = syscall(__NR_gettid);
    child_state[id].tid = tid;
    child_state[id].state = 1;

    if (setitimer(ITIMER_PROF, &itv, 0) < 0) {
	fprintf(stderr, "Setitimer failed: %s\n", strerror(errno));
	exit(1);
    }

    while(go<1);

    child_state[id].start_count = count;
    for (i=0;i<NITER;++i)
	a = cos(asin(a));
    child_state[id].end_count = count;
    child_state[id].result = a;

    child_state[id].state = 2;

    while(go<2);

}

int
main(int argc, char *argv[])
{
    struct sigaction sa;
    int j, started, finished, thread_count;

    if (argc < 2) {
    	printf("Call as '%s NN', where NN is the number of threads to create.\n", argv[0]);
	exit(1);
    }

    thread_count = atol(argv[1]);
    printf("Creating %d threads.\n", thread_count);

    itv.it_value.tv_sec = 0;
    itv.it_value.tv_usec = 1000000.0 / (double)sysconf(_SC_CLK_TCK);
    itv.it_interval = itv.it_value;

    memset(&sa, 0, sizeof(sa));
    sigfillset(&sa.sa_mask);
    sa.sa_sigaction = sigprof_handler;
    sa.sa_flags = SA_RESTART | SA_SIGINFO;

    if (sigaction(SIGPROF, &sa, 0) < 0) {
	fprintf(stderr, "Sigaction failed: %s\n", strerror(errno));
	exit(1);
    }

    for (j=0; j<thread_count; j++) 
    	if (pthread_create(&ptid[j], NULL, &func, (void *)(long) j) < 0)
		perrorx("pthread create");

    do {
    	sleep(1);
	started = 0;
	for (j=0; j<thread_count; j++)
		started += child_state[j].state;
    } while(started < thread_count);

    printf("All threads have started.\n");
    go++;

    do {
    	sleep(1);
	finished = 0;
	for (j=0; j<thread_count; j++)
		finished += (child_state[j].state == 2);
    } while(finished < thread_count);
    printf("All threads have finished.\n");

    for (j=0; j<thread_count; j++) 
    	printf("count[%d]=%d\n",
		j, child_state[j].end_count-child_state[j].start_count);

    return 0;
}

--------------020803050208060509030506--
