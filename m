Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVG2UnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVG2UnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVG2Uk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:40:29 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:47240 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S262817AbVG2Ujp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:39:45 -0400
Date: Fri, 29 Jul 2005 16:36:05 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: i387 floating-point test program/benchmark
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200507291639_MC3-1-A5E6-856D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/* fp.c: i387 benchmark/test program */

#define FP_VERSION "0.10"
#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <sched.h>

#define COND_YIELD(iters, ctr)			\
	if ((iters) > 0 && ++(ctr) > (iters)) {	\
		(ctr) = 0;			\
		sched_yield();			\
	}
#define RDTSCLL(r) __asm__ __volatile__("rdtsc" : "=A" (r))

int fp = 0, in = 0, yi = 0;
volatile int lo = 0, lo2 = 0;
int p_ctr = 0, c_ctr = 0, get;
long long i, c_iters, p_iters = 0; 
long double c_res, p_res;
unsigned long long tsc1, tsc2;
cpu_set_t cpuset;

static void handler(int sig)
{
	lo = 0;  /* child exited -- stop looping */
}
struct sigaction sa = {
	.sa_handler = handler,
};

void usage(char *prog)
{
	printf("\n i387 floating point benchmark/test program v" FP_VERSION);
	printf("\n\n Usage:\n");
	printf("\t%s [-f] [-i] [-a] [-y count] loops\n\n", prog);
	printf("\t-f : loop in parent process waiting for child to exit\n");
	printf("\t-i : do integer math while looping instead of FP math\n");
	printf("\t     (-f and -i: do one FP operation, then use integer math)\n");
	printf("\t-a : run parent and child on single cpu\n");
	printf("\t-y : yield CPU every 'count' loops in parent and child\n\n");
	exit(1);
}

static void do_parent()
{
	if (fp)
		__asm__ __volatile__("fld1 ; fldz");

	while (lo) {
		if (fp & !in)
			__asm__ __volatile__("fadd %st(1), %st(0)");
		else
			p_iters++;

		COND_YIELD(yi, p_ctr);
	}

	if (fp)
		__asm__ __volatile__("fxch ; fstpt p_res ; fstpt p_res");
	if (fp & !in)
		p_iters = (long long)p_res;

	printf("Parent did: %12lld loops\n", p_iters);
}

static void do_child()
{
	RDTSCLL(tsc1);
	__asm__ __volatile__("fld1 ; fldz");
	for (i = 0; i < c_iters; i++) {
		__asm__ __volatile__("fadd %st(1), %st(0)");
		COND_YIELD(yi, c_ctr);
	}
	__asm__ __volatile__("fxch ; fstpt c_res ; fstpt c_res");
	RDTSCLL(tsc2);

	if (c_res != (long double)c_iters)
		printf("FP error! Result was %Lg; expected %lld\n", c_res, c_iters);

	printf("CPU clocks: %12llu\n", tsc2 - tsc1);
}

int main(int argc, char * argv[])
{
	do {
		get = getopt(argc, argv, "fiay:");
		switch (get) {
		case 'f':
			fp = 1;
			break;
		case 'i':
			in = 1;
			break;
		case 'a':
			memset(&cpuset, sizeof(cpuset), 0);
			CPU_SET(1, &cpuset);
			sched_setaffinity(0, &cpuset);
			break;
		case 'y':
			yi = atoi(optarg);
			if (yi == 0)
				get = '?';
			break;
		default:
			break;
		}

	} while (get != -1 && get != '?');

	if (get == '?' || optind >= argc)
		usage(argv[0]);

	c_iters = atoll(argv[optind]);

	if (fp | in) {
		sigaction(SIGCHLD, &sa, NULL);
		lo2 = lo = 1;
	}

	if (fork())
		if (lo2)
			do_parent();
		else
			wait(NULL);
	else
		do_child();

	return 0;
}
