Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbULGDK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbULGDK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 22:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbULGDK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 22:10:26 -0500
Received: from siaag1ac.compuserve.com ([149.174.40.5]:42171 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S261746AbULGDKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 22:10:15 -0500
Date: Mon, 6 Dec 2004 22:05:42 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: How to measure i386 timer interrupt overhead
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200412062209_MC3-1-902F-B102@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this program actually works, then the SMP timer interrupt on this
system takes 1200-1420 cycles, with 448 of 945 taking 1200-1219 cycles.
(All the normal interrupts are bound to CPU 0.)

Is this a valid test program?

$ taskset 2 ./t 6800 332490000 | sort -g | uniq -c | grep -v '^      [1-9]'
Elasped time: 945 ticks (assuming Hz = 1000)
   9731 0
     35 10
    224 1200
    204 1210
     16 1220
     14 1270
     65 1300
    131 1310
     33 1320
     14 1370
     20 1380
     22 1420

$ cat t.c
/* Measure i386 timer overhead by timing loops with TSC and
 * subtracting out the minimum time.  Rounds to granularity 10.
 * (Run this on an otherwise idle system.)
 */
#include <stdio.h>
#define HZ              1000
#define NUM_TESTS       (11000 + 1)
unsigned long long t0, t1, t2, t3;
unsigned long long sample[NUM_TESTS], min = 1000000;
unsigned int loop_iters, tsc_per_tick, i, j;

main (int argc, char **argv) {
        if (argc < 3) {
                fprintf(stderr, "Usage: %s <loop_size> <CPU Hz>\n", argv[0]);
                exit(1);
        }
        loop_iters   = atoi(argv[1]);
        tsc_per_tick = atoll(argv[2]) / HZ;
restart:
        asm volatile ("rdtsc" : "=A"(t0));
        for (i = 0; i < NUM_TESTS; i++) {
                asm volatile ("rdtsc" : "=A"(t1));
                for (j = 0; j < loop_iters; j++)
                        /* empty */;
                asm volatile ("rdtsc" : "=A"(t2));
                sample[i] = t2 - t1;
        }
        asm volatile ("rdtsc" : "=A"(t3));
        if (t3 < t0)
                goto restart;
        for (i = 1; i < NUM_TESTS; i++) { /* skip first sample */
                if (min > sample[i])
                        min = sample[i];
        }
        for (i = 1; i < NUM_TESTS; i++)
                printf("%llu\n", (sample[i] - min) / 10 * 10);
        fprintf(stderr, "Elasped time: %d ticks (assuming Hz = %d)\n",
                        (int)((t3 - t0) / tsc_per_tick), HZ);
}

--Chuck Ebbert  06-Dec-04  22:03:04
