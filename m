Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVKVLQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVKVLQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVKVLQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:16:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:58580 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964921AbVKVLQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:16:52 -0500
Date: Tue, 22 Nov 2005 12:16:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>,
       pluto@agmk.net, john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
Message-ID: <20051122111623.GA948@elte.hu>
References: <20051115090827.GA20411@elte.hu> <1132608728.4805.20.camel@cmn3.stanford.edu> <20051121221511.GA7255@elte.hu> <20051121221941.GA11102@elte.hu> <Pine.LNX.4.58.0511212012020.5461@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511212012020.5461@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I'm running -rt13 with the following command line:
> 
> root=/dev/md0 ro console=ttyS0,115200 console=tty0 nmi_watchdog=2 lapic
> earlyprintk=ttyS0,115200 idle=poll
> 
> I just got the following output:
> 
> $ ./time-warp-test
> #CPUs: 2
> running 2 tasks to check for time-warps.
> warp ..        -5 cycles, ... 0000004fc2ab2b7f -> 0000004fc2ab2b7a ?
> warp ..       -12 cycles, ... 000000506d1d558c -> 000000506d1d5580 ?
> warp ..       -97 cycles, ... 000000536c8868d3 -> 000000536c886872 ?
> warp ..       -99 cycles, ... 00000059ae9d49a1 -> 00000059ae9d493e ?
> warp ..      -110 cycles, ... 00000059ed0f05d6 -> 00000059ed0f0568 ?
> warp ..      -118 cycles, ... 0000007392963142 -> 00000073929630cc ?
> warp ..      -122 cycles, ... 0000007d6a94bc76 -> 0000007d6a94bbfc ?
> warp ..      -346 cycles, ... 0000008acf28a18e -> 0000008acf28a034 ?
> warp ..      -390 cycles, ... 0000008b2fc61fef -> 0000008b2fc61e69 ?

i've attached an updated utility below. But i too can see similar output 
on an X2. A TSC-warp of 390 cycles _might_ be OK, but there are no 
guarantees. It wont show up as a usecs-level (i.e. gettimeofday()) warp, 
because 390 cycles is still much lower than the ~2000 cycles one 
microsecond takes, but it could cause problems for other TSC users.
 
Basically if there is an observable and provable warp in the TSC output 
then it must not be used for any purpose that is not strictly 
per-CPU-ified (such as userspace threads bound to a single CPU, and the 
TSC never used between threads).

	Ingo

---------{ time-warp-test.c }--------->
/*
 * Copyright (C) 2005, Ingo Molnar
 *
 * time-warp-test.c: check TSC synchronity on x86 CPUs. Also detects
 *                   gettimeofday()-level time warps.
 */
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <linux/unistd.h>
#include <unistd.h>
#include <string.h>
#include <pwd.h>
#include <grp.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <regex.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <dlfcn.h>
#include <popt.h>
#include <sys/socket.h>
#include <ctype.h>
#include <assert.h>
#include <sched.h>

#define TEST_TSC 1
#define TEST_TOD 1

#if !TEST_TSC && !TEST_TOD
# error this makes no sense ...
#endif

#if DEBUG
# define Printf(x...) printf(x)
#else
# define Printf(x...) do { } while (0)
#endif

/*
 * Shared locks and variables between the test tasks:
 */
enum {
	SHARED_TSC = 0,
	SHARED_LOCK = 2,
	SHARED_TOD = 3,
	SHARED_WORST_TSC = 5,
	SHARED_WORST_TOD = 7,
	SHARED_NR_TSC_WARPS = 9,
	SHARED_NR_TOD_WARPS = 10,
};

#define SHARED(x)	(*(shared + SHARED_##x))
#define SHARED_LL(x)	(*(long long *)(shared + SHARED_##x))

#define BUG_ON(c) assert(!(c))

typedef unsigned long long cycles_t;
typedef unsigned long long usecs_t;

#define rdtscll(val)					\
do {							\
	__asm__ __volatile__("rdtsc" : "=A" (val));	\
} while (0)

#define rdtod(val)					\
do {							\
	struct timeval tv;				\
							\
	gettimeofday(&tv, NULL);			\
	(val) = tv.tv_sec * 1000000LL + tv.tv_usec;	\
} while (0)

static unsigned long *setup_shared_var(void)
{
	char zerobuff [4096] = { 0, };
	int ret, fd;
	unsigned long *buf;

	fd = creat(".tmp_mmap", 0700);
	BUG_ON(fd == -1);
	close(fd);

	fd = open(".tmp_mmap", O_RDWR|O_CREAT|O_TRUNC);
	BUG_ON(fd == -1);
	ret = write(fd, zerobuff, 4096);
	BUG_ON(ret != 4096);

	buf = (void *)mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	BUG_ON(buf == (void *)-1);

	close(fd);

	return buf;
}

#define LOOPS 1000000

static inline unsigned long
cmpxchg(volatile unsigned long *ptr, unsigned long old, unsigned long new)
{
	unsigned long prev;

	__asm__ __volatile__("lock; cmpxchg %b1,%2"
			     : "=a"(prev)
			     : "q"(new), "m"(*(ptr)), "0"(old)
			     : "memory");
	return prev;
}

static inline void lock(unsigned long *flag)
{
	while (cmpxchg(flag, 0, 1) != 0)
		/* nothing */;
}

static inline void unlock(unsigned long *flag)
{
	*flag = 0;
}

static void print_status(unsigned long *shared)
{
	const char progress[] = "\\|/-";
	static usecs_t prev_tod;
	static int count1, count2;

	usecs_t tod;

	count1++;
	if (count1 < 1000)
		return;
	count1 = 0;

	rdtod(tod);
	if (tod - prev_tod < 100000ULL)
		return;
	prev_tod = tod;
	count2++;

	if (TEST_TSC)
		printf("| # of TSC-warps:%ld", SHARED(NR_TSC_WARPS));

	if (TEST_TOD)
		printf(" | # of TOD-warps:%ld", SHARED(NR_TOD_WARPS));

	printf(" %c\r", progress[count2 & 3]);
	fflush(stdout);
}

static inline void test_TSC(unsigned long *shared)
{
#if TEST_TSC
	cycles_t t0, t1;
	long long delta;

	lock(&SHARED(LOCK));
	rdtscll(t1);
	t0 = SHARED_LL(TSC);
	SHARED_LL(TSC) = t1;

	delta = t1-t0;
	if (delta < 0) {
		SHARED(NR_TSC_WARPS)++;
		if (delta < SHARED_LL(WORST_TSC)) {
			SHARED_LL(WORST_TSC) = delta;
			fprintf(stderr, "\rnew TSC-warp maximum: %9Ld cycles, %016Lx -> %016Lx\n",
				delta, t0, t1);
		}
	}
	unlock(&SHARED(LOCK));
#endif
}

static inline void test_TOD(unsigned long *shared)
{
#if TEST_TOD
	usecs_t T0, T1;
	long long delta;

	lock(&SHARED(LOCK));
	rdtod(T1);
	T0 = SHARED_LL(TOD);
	SHARED_LL(TOD) = T1;

	delta = T1-T0;
	if (delta < 0) {
		SHARED(NR_TOD_WARPS)++;
		if (delta < SHARED_LL(WORST_TOD)) {
			SHARED_LL(WORST_TOD) = delta;
			fprintf(stderr, "\rnew TOD-warp maximum: %9Ld usecs,  %016Lx -> %016Lx\n",
				delta, T0, T1);
		}
	}
	unlock(&SHARED(LOCK));
#endif
}

int main(int argc, char **argv)
{
	int i, parent, me;
	unsigned long *shared;
	unsigned long cpus, tasks;

	cpus = system("exit `grep processor /proc/cpuinfo  | wc -l`");
	cpus = WEXITSTATUS(cpus);

	if (argc > 2) {
usage:
		fprintf(stderr,
			"usage: tsc-sync-test <threads>\n");
		exit(-1);
	}
	if (argc == 2) {
		tasks = atol(argv[1]);
		if (!tasks)
			goto usage;
	} else
		tasks = cpus;

	printf("%ld CPUs, running %ld parallel test-tasks.\n", cpus, tasks);
	printf("checking for time-warps via:\n"
#if TEST_TSC
	"- read time stamp counter (RDTSC) instruction (cycle resolution)\n"
#endif
#if TEST_TOD
	"- gettimeofday (TOD) syscall (usec resolution)\n"
#endif
		"\n"
		);
	shared = setup_shared_var();

	parent = getpid();

	for (i = 1; i < tasks; i++)
		if (!fork())
			break;
	me = getpid();

	while (1) {
		test_TSC(shared);
		test_TOD(shared);

		if (me == parent)
			print_status(shared);
	}

	return 0;
}
