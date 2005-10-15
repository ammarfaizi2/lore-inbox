Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVJOBdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVJOBdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 21:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVJOBdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 21:33:00 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:2005 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750952AbVJOBdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 21:33:00 -0400
Date: Fri, 14 Oct 2005 21:24:19 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.14-rc4] i386: spinlock optimization
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200510142128_MC3-1-ACAD-8CD3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20051014180414.GD3502@verdi.suse.de>

On Fri, 14 Oct 2005 at 20:04:14 +0200, Andi Kleen wrote:
> I doubt your change adds any noticeable delay on a aggressive
> OOO CPU, which are pretty much all modern x86s. It's probably
> a nop.

 Well it certainly improves the spinlock fairness when owner releases
the lock and tries to re-acquire it.  And on the test machine with a slow
bus my program runs faster even though the spinlock ping-pongs more often
with the new code than with the old.  ("Total runs" == number of times
spinlock changes hands during test run; "run length" == how many cycles
in a row the current owner held the spinlock.) Timer interrupts skew these
results a bit by stealing the CPU, so don't take them too literally.


--------------------------------------------
Dual Pentium II Xeon 350 running 2.6.14-rc4:
--------------------------------------------

$ gcc -O2 -Wall -o spintest.o -DSETAFFINITY=2 -DFAST_SPINLOCK=0 -mcpu=pentium2 spintest.c
$ ./spintest.o
Parent CPU 1, child CPU 0, using old code for lock
CPU clocks: 2066947815
Parent did: 5033294 of 10000001 iterations
Run length histogram:
   1: 4
   2: 105
   3: 1161
   4: 502
   5: 113
   6: 130
   7: 56
   8: 54
   9: 81
  10: 60
  11: 72
  12: 57
  13: 72
  14: 43
  15: 85
>=16: 94661
Total runs 97256, longest was 2713 iterations, average was 102

$ gcc -O2 -Wall -o spintest.o -DSETAFFINITY=2 -DFAST_SPINLOCK=1 -mcpu=pentium2 spintest.c
$ ./spintest.o
Parent CPU 1, child CPU 0, using new code for lock
CPU clocks: 2818166922
Parent did: 4148727 of 10000001 iterations
Run length histogram:
   1: 52346
   2: 383050
   3: 137185
   4: 42970
   5: 36475
   6: 8407
   7: 11177
   8: 2666
   9: 1033
  10: 791
  11: 763
  12: 870
  13: 726
  14: 1075
  15: 1041
>=16: 68272
Total runs 748847, longest was 3488 iterations, average was 13

-----------------------------------------------------------------
Dual Pentium II OverDrive 333 with Socket 8 bus running 2.6.13.4:
-----------------------------------------------------------------

$ gcc -O2 -Wall -DSETAFFINITY=3 -DFAST_SPINLOCK=0 -o spintest.o -mcpu=pentium2 spintest.c
$ ./spintest.o
Parent CPU 1, child CPU 0, using old code for lock
CPU clocks: 5635093038
Parent did: 4825431 of 10000001 iterations
Run length histogram:
   1: 2264420
   2: 1137639
   3: 565597
   4: 7039
   5: 560015
   6: 5832
   7: 240
   8: 128
   9: 82
  10: 37
  11: 24
  12: 11
  13: 16
  14: 20
  15: 21
>=16: 3312
Total runs 4544433, longest was 31193 iterations, average was 2

$ gcc -O2 -Wall -DSETAFFINITY=3 -DFAST_SPINLOCK=1 -o spintest.o -mcpu=pentium2 spintest.c
$ ./spintest.o
Parent CPU 1, child CPU 0, using new code for lock
CPU clocks: 5250078921
Parent did: 4831071 of 10000001 iterations
Run length histogram:
   1: 2792457
   2: 2596109
   3: 201958
   4: 28941
   5: 82932
   6: 8071
   7: 518
   8: 207
   9: 75
  10: 58
  11: 38
  12: 11
  13: 6
  14: 6
  15: 8
>=16: 3254
Total runs 5714649, longest was 29512 iterations, average was 1

-------------
Test program:
-------------

/* spinlock test
 *
 * Tests Linux spinlock fairness on SMP i386 machine.
 * 32-bit spinlocks instead of Linux's 8-bit locks.
 */

/* number of tests  */
#ifndef ITERS
#define ITERS 10000000
#endif

/* cpu to run parent process; child will use !PARENT_CPU  */
#ifndef PARENT_CPU
#define PARENT_CPU 1
#endif

/* use faster spinlock code  */
#ifndef FAST_SPINLOCK
#define FAST_SPINLOCK 0
#endif

/* change this to match your version of glibc -- "3" means use 3 args */
#ifndef SETAFFINITY
#define SETAFFINITY 3
#endif

#if SETAFFINITY == 3
#define setaffinity(pid, mask) sched_setaffinity((pid), sizeof(mask), &(mask))
#else /* 2 args  */
#define setaffinity(pid, mask) sched_setaffinity((pid), &(mask))
#endif

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <asm/user.h>

#define likely(x)	__builtin_expect(!!(x), 1)
#define unlikely(x)	__builtin_expect(!!(x), 0)

#define RDTSCLL(r) asm volatile("rdtsc" : "=A" (r))

unsigned long long tsc1, tsc2;
cpu_set_t cpuset0, cpuset1;
int test = 1; /* for testing -- starts unlocked  */
int strt = 0; /* sync startup  -- starts locked  */
unsigned int i, runs;
int stk[2048];
int shrd_iters __attribute__ ((aligned(64)));
struct stats
{
	unsigned int iters;
	unsigned int prev;
	unsigned int run, max_run;
	unsigned int hist[16];
};
struct stats p __attribute__ ((aligned(64)));
struct stats c __attribute__ ((aligned(64)));

static inline void __raw_spin_lock(int *l)
{
	asm volatile(
		"\n1:\t"
		"lock ; decl %0\n\t"
		"jns 3f\n"
		"2:\t"
		"rep;nop\n\t"
		"cmpl $0,%0\n\t"
#if FAST_SPINLOCK == 1
		"jg 1b\n\t"
		"jmp 2b\n"
#else
		"jle 2b\n\t"
		"jmp 1b\n"
#endif
		"3:\n\t"
		:"=m" (*l) : : "memory");
}

static inline void __raw_spin_unlock(int *l)
{
	asm volatile("movl $1,%0"
		     : "=m" (*l) : : "memory");
}

int do_child(void *vp)
{
	CPU_SET(!PARENT_CPU, &cpuset1);
	if (unlikely(setaffinity(0, cpuset1)))
		perror("child setaffinity");

	__raw_spin_unlock(&strt); /* release parent  */
again:
	__raw_spin_lock(&test);
	c.iters++;
	if (shrd_iters == c.prev)
		c.run++;
	else {
		if (c.run > c.max_run)
			c.max_run = c.run;
		c.hist[c.run <= 15 ? c.run : 15]++;
		c.run = 0;
	}
	if (likely(++shrd_iters < ITERS)) {
		c.prev = shrd_iters;
		__raw_spin_unlock(&test);
		goto again;
	}
	__raw_spin_unlock(&test);

	return 0;
}

int main(int argc, char * const argv[])
{
	CPU_SET(PARENT_CPU, &cpuset0);
	if (unlikely(setaffinity(0, cpuset0)))
		perror("parent setaffinity");

	clone(do_child, &stk[2047], CLONE_VM, 0);
	__raw_spin_lock(&strt); /* wait for child to init  */

	RDTSCLL(tsc1);
again:
	__raw_spin_lock(&test);
	p.iters++;
	if (shrd_iters == p.prev)
		p.run++;
	else {
		if (p.run > p.max_run)
			p.max_run = p.run;
		p.hist[p.run <= 15 ? p.run : 15]++;
		p.run = 0;
	}
	if (likely(++shrd_iters < ITERS)) {
		p.prev = shrd_iters;
		__raw_spin_unlock(&test);
		goto again;
	}
	__raw_spin_unlock(&test);
	RDTSCLL(tsc2);

	printf("Parent CPU %d, child CPU %d, ", PARENT_CPU, !PARENT_CPU);
	printf("using %s code for lock\n", FAST_SPINLOCK == 1 ? "new" : "old");
	printf("CPU clocks: %llu\n", tsc2 - tsc1);
	printf("Parent did: %u of %u iterations\n", p.iters, shrd_iters);
	printf("Run length histogram:\n");
	for (i = 0; i < 16; i++) {
		printf ("%s%2u: %u\n", i == 15 ? ">=" : "  ",
			i + 1, p.hist[i] + c.hist[i]);
		runs += p.hist[i] + c.hist[i];
	}
	printf("Total runs %u, longest was %u iterations, average was %u\n",
		runs, p.max_run > c.max_run ? p.max_run : c.max_run,
		shrd_iters / runs);

	return 0;
}
__
Chuck
