Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263047AbVG3L32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbVG3L32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbVG3L22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:28:28 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:29869 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S263047AbVG3L2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:28:12 -0400
Date: Sat, 30 Jul 2005 07:23:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: i387 floating point benchmark/test v0.12
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Puneet Vyas <vyas.puneet@gmail.com>
Message-ID: <200507300727_MC3-1-A5F5-3763@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/* fptst.c: i387 benchmark/test program for Linux
 * Build this program with optimization (-O2 may be faster than -O3)
 *
 * v0.11 should work on a wider variety of glibc versions (tested: 2.3.2,
2.3.3)
 *      (See below...)
 * v0.12 fixed bug in setaffinity: CPU set was empty
 *
 * Comments welcome.
 * Author: Chuck Ebbert <76306.1226@compuserve.com>
 */

/* Uncomment this if you get compile errors with the setaffinity function
*/
/* #define SETAFFINITY_TAKES_2_ARGS */

#define FPTST_VERSION "0.12"
#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <errno.h>
#include <sched.h>

#define COND_YIELD(iters, ctr)                  \
        if ((iters) > 0 && ++(ctr) > (iters)) { \
                (ctr) = 0;                      \
                sched_yield();                  \
        }

#define RDTSCLL(r) __asm__ __volatile__("rdtsc" : "=A" (r))

#ifdef SETAFFINITY_TAKES_2_ARGS
#define setaffinity(pid, mask) sched_setaffinity((pid), &(mask))
#else
#define setaffinity(pid, mask) sched_setaffinity((pid), sizeof(mask),
&(mask))
#endif

long double c_res, p_res;
long long i, c_iters, p_iters = 0; 
unsigned long long tsc1, tsc2;
cpu_set_t cpuset;
int fp = 0, in = 0, yi = 0;
int p_ctr = 0, c_ctr = 0, get;
volatile int lo = 1;

static void handler(int sig)
{
        lo = 0;  /* child exited -- stop looping */
}
struct sigaction sa = {
        .sa_handler = handler,
};

void usage(char *prog)
{
        printf("\n i387 floating point benchmark/test program v"
FPTST_VERSION);
        printf("\n\n Usage:\n");
        printf("\t%s [-f] [-i] [-a] [-y count] loops\n\n", prog);
        printf("\t-f : loop in parent process waiting for child to
exit\n");
        printf("\t-i : do integer math while looping instead of FP
math\n");
        printf("\t     (-f and -i: do one FP operation, then use integer
math)\n");
        printf("\t-a : run parent and child on single CPU (requires
SMP)\n");
        printf("\t-y : yield CPU every 'count' loops in parent and
child\n\n");
        exit(1);
}

static void do_parent()
{
        if (fp)
                __asm__ ("fld1 ; fldz");

        while (lo) {
                if (fp & !in)
                        __asm__ ("fadd %st(1), %st(0)");
                else
                        p_iters++;

                COND_YIELD(yi, p_ctr);
        }

        if (fp)
                __asm__ ("fxch ; fstpt p_res ; fstpt p_res");
        if (fp & !in)
                p_iters = (long long)p_res;

        printf("Parent did: %14lld loops\n", p_iters);
}

static void do_child()
{
        RDTSCLL(tsc1);
        __asm__ ("fld1 ; fldz");
        for (i = 0; i < c_iters; i++) {
                __asm__ ("fadd %st(1), %st(0)");
                COND_YIELD(yi, c_ctr);
        }
        __asm__ ("fxch ; fstpt c_res ; fstpt c_res");
        RDTSCLL(tsc2);

        if (c_res != (long double)c_iters)
                printf("FP error! Result was %Lg; expected %lld\n", c_res,
c_iters);

        printf("CPU clocks: %14llu\n", tsc2 - tsc1);
}

int main(int argc, char * const argv[])
{
        do {
                switch (get = getopt(argc, argv, "fiay:")) {
                case 'f':
                        fp = 1;
                        break;
                case 'i':
                        in = 1;
                        break;
                case 'a':
                        memset(&cpuset, 0, sizeof(cpuset));
                        CPU_SET(1, &cpuset);
                        if (setaffinity(0, cpuset)) {
                                perror("While setting CPU affinity");
                                get = '?';
                        }
                        break;
                case 'y':
                        yi = atoi(optarg);
                        if (yi <= 0) {
                                printf("-y: count must be greater than
zero\n");
                                get = '?';
                        }
                        break;
                default:
                        break;
                }

        } while (get != -1 && get != '?');

        if (get == '?' || optind >= argc)
                usage(argv[0]);

        c_iters = atoll(argv[optind]);

        if (fp | in)
                sigaction(SIGCHLD, &sa, NULL);

        if (fork())
                if (fp | in)
                        do_parent();
                else
                        wait(NULL);
        else
                do_child();

        return 0;
}
