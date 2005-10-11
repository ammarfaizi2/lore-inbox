Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVJKEIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVJKEIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVJKEIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:08:38 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:35968 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751260AbVJKEIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:08:37 -0400
Date: Tue, 11 Oct 2005 00:04:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: i386 spinlock fairness: bizarre test results
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux@horizon.com, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@sw.ru>
Message-ID: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  After seeing Kirill's message about spinlocks I decided to do my own
testing with the userspace program below; the results were very strange.

  When using the 'mov' instruction to do the unlock I was able to reproduce
hogging of the spinlock by a single CPU even on Pentium II under some
conditions, while using 'xchg' always allowed the other CPU to get the
lock:


[me@d2 t]$ gcc -O2 -o spintest.o -Wall -DUSE_MOV=1 spintest.c ; ./spintest.o
parent CPU 1, child CPU 0, using mov instruction for unlock
parent did: 34534 of 10000001 iterations
CPU clocks:     2063591864

[me@d2 t]$ gcc -O2 -o spintest.o -Wall -DUSE_MOV=0 spintest.c ; ./spintest.o
parent CPU 1, child CPU 0, using xchg instruction for unlock
parent did: 5169760 of 10000001 iterations
CPU clocks:     2164689784


  The results were dependent on the alignment of the "lock ; decl" at the start
of the spinlock code.  If that 7-byte instruction spanned two cachelines then
the CPU with that code could somehow hog the spinlock.  Optimizing for
Pentium II forced 16-byte alignment and made the spinlock fairer, but still
somewhat biased when using 'mov':


[me@d2 t]$ gcc -O2 -o spintest.o -Wall -DUSE_MOV=1 -mcpu=pentium2 spintest.c ; ./spintest.o
parent CPU 1, child CPU 0, using mov instruction for unlock
parent did: 4181147 of 10000001 iterations
CPU clocks:     2057436825


  That test machine was a dual 350MHz Pentium II Xeon; on a dual 333MHz Pentium II
Overdrive (with very slow Socket 8 bus) I could not reproduce those results.
However, on that machine the 'xchg' instruction made the test run almost 20%
_faster_ than using 'mov'.

  So I think the i386 spinlock code should be changed to always use 'xchg' to do
spin_unlock.

================================================================================
/* spinlock test
 *
 * Tests spinlock fairness on SMP i386 machine.
 */

/* number of tests  */
#ifndef ITERS
#define ITERS 10000000
#endif

/* use "mov" instruction for spin_unlock instead of "xchg"  */
#ifndef USE_MOV
#define USE_MOV 1
#endif

/* cpu to run parent process; child will use !PARENT_CPU  */
#ifndef PARENT_CPU
#define PARENT_CPU 1
#endif

/* change this to match your version of glibc -- "2" means use 2 args */
#ifndef SETAFFINITY
#define SETAFFINITY 2
#endif

#if SETAFFINITY == 2
#define setaffinity(pid, mask) sched_setaffinity((pid), &(mask))
#else /* 3 args  */
#define setaffinity(pid, mask) sched_setaffinity((pid), sizeof(mask), &(mask))
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
int stk[1024];
int iters, p_iters, c_iters;

static inline void __raw_spin_lock(int *l)
{
	asm volatile(
		"\n1:\t"
		"lock ; decl %0\n\t"
		"jns 3f\n"
		"2:\t"
		"rep;nop\n\t"
		"cmpl $0,%0\n\t"
		"jle 2b\n\t"
		"jmp 1b\n"
		"3:\n\t"
		:"=m" (*l) : : "memory");
}

#if USE_MOV

static inline void __raw_spin_unlock(int *l)
{
	asm volatile("movl $1,%0"
		     : "=m" (*l) : : "memory");
}

#else

static inline void __raw_spin_unlock(int *l)
{
	int oldval = 1;

	asm volatile("xchgl %0,%1"
		     : "=q" (oldval), "=m" (*l)
		     : "0" (oldval) : "memory");
}

#endif /* USE_MOV  */

int do_child(void *vp)
{
	CPU_SET(!PARENT_CPU, &cpuset1);
	if (unlikely(setaffinity(0, cpuset1)))
		perror("child setaffinity");

	/* Add "nop" insns as necessary to make 1st
	 * insn of __raw_spin_lock span cachelines.
	 */
	asm("nop ; nop ; nop");

	__raw_spin_unlock(&strt); /* release parent  */
again:
	__raw_spin_lock(&test);
	c_iters++;
	if (likely(++iters < ITERS)) {
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

	clone(do_child, &stk[1023], CLONE_VM, 0);

	__raw_spin_lock(&strt); /* wait for child to init  */
	RDTSCLL(tsc1);
again:
	__raw_spin_lock(&test);
	p_iters++;
	if (likely(++iters < ITERS)) {
		__raw_spin_unlock(&test);
		goto again;
	}
	__raw_spin_unlock(&test);
	RDTSCLL(tsc2);

	printf("parent CPU %d, child CPU %d, ", PARENT_CPU, !PARENT_CPU);
	printf("using %s instruction for unlock\n", USE_MOV ? "mov" : "xchg");
	printf("parent did: %d of %d iterations\n", p_iters, iters);
	printf("CPU clocks: %14llu\n", tsc2 - tsc1);

	return 0;
}
__
Chuck
