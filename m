Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVKUWUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVKUWUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVKUWUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:20:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17346 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751169AbVKUWUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:20:22 -0500
Date: Mon, 21 Nov 2005 23:19:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: test time-warps [was: Re: 2.6.14-rt13]
Message-ID: <20051121221941.GA11102@elte.hu>
References: <20051115090827.GA20411@elte.hu> <1132608728.4805.20.camel@cmn3.stanford.edu> <20051121221511.GA7255@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121221511.GA7255@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Tue, 2005-11-15 at 10:08 +0100, Ingo Molnar wrote:
> > i have released the 2.6.14-rt13 tree, which can be downloaded from the 
> > usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > lots of fixes in this release affecting all supported architectures, all 
> > across the board. Big MIPS update from John Cooper.
> 
> Can someone tell me if 2.6.14-rt13 is supposed to be fixed re: the 
> problems I was having with random screensaver triggering and keyboard 
> repeats?
> 
> It is apparently not fixed.
> 
> I just had a short burst of key repeats and saw one random screen 
> blank. Right now everything seems normal but I was not allucinating 
> :-)

is this on the dual-core X2 box, running 32-bit code? Did it happen with 
idle=poll? Without idle=poll the TSCs run apart and a number of 
artifacts may happen. With idle=poll specified the TSC _should_ be fully 
synchronized.

To make sure could you run the attached time-warp-test utility i wrote 
today? Compile it with:

  gcc -Wall -O2 -o time-warp-test time-warp-test.c

it detects and reports time-warps (and does a maximum search for them 
over time, that way you can see systematic drifts too). (It auto-detects 
the # of CPUs and runs the appropriate number of tasks.)

running this tool on a X2 with idle=poll and an -rt kernel should give a 
silent test-output.

running a vanilla kernel should give TSC level time warps:

 #CPUs: 2
 running 2 tasks to check for time-warps.
 warp ..        -1 cycles, ... 00000277ed9520c6 -> 00000277ed9520c5 ?
 warp ..       -18 cycles, ... 00000277ed97ac77 -> 00000277ed97ac65 ?
 warp ..       -19 cycles, ... 00000277edaedd54 -> 00000277edaedd41 ?
 warp ..       -84 cycles, ... 00000277ede0558a -> 00000277ede05536 ?
 warp ..       -97 cycles, ... 00000278035328a5 -> 0000027803532844 ?
 warp ..      -224 cycles, ... 000002781ed2db04 -> 000002781ed2da24 ?

(because the vanilla kernel doesnt do TSC synchronization accurately)

running it without idle=poll should give some really big time warps:

 neptune:~> ./time-warp-test
 #CPUs: 2
 running 2 tasks to check for time-warps.
 warp ..   -435934 cycles, ... 00000101a2db4a8f -> 00000101a2d4a3b1 ?
 WARP ..      -123 usecs, .... 0003e96c2f3bb579 -> 0003e96c2f3bb4fe ?
 WARP ..      -198 usecs, .... 0003e96c2f3bb625 -> 0003e96c2f3bb55f ?
 WARP ..      -199 usecs, .... 0003e96c2f3bb659 -> 0003e96c2f3bb592 ?
 warp ..   -436117 cycles, ... 00000101a2e5aaf0 -> 00000101a2df035b ?
 warp ..   -437143 cycles, ... 00000101a2e84590 -> 00000101a2e199f9 ?
 warp ..   -437314 cycles, ... 00000101a2ead1b1 -> 00000101a2e4256f ?
 warp ..   -437363 cycles, ... 00000101a2ed9b19 -> 00000101a2e6eea6 ?
 WARP ..  -1951680 usecs, .... 0003e96c2f597f70 -> 0003e96c2f3bb7b0 ?
 WARP ..  -1951879 usecs, .... 0003e96c2f598016 -> 0003e96c2f3bb78f ?
 WARP ..  -1951681 usecs, .... 0003e96c2f598014 -> 0003e96c2f3bb853 ?
 warp ..   -437365 cycles, ... 00000101a4c5be7b -> 00000101a4bf1206 ?
 warp ..   -437366 cycles, ... 00000101a8f4af76 -> 00000101a8ee0300 ?
 warp ..   -437367 cycles, ... 00000101a968a34a -> 00000101a961f6d3 ?

these time warps will get worse over time - as the two cores drift 
apart. (note that they wont drift during the test itself, because the 
test makes all cores artificially busy and the X2 TSC drifting depends 
on the core being idle)

but in any case, -rt13 should be silent and there should be no time 
warps. If there are any then those could cause the keyboard repeat 
problems.

	Ingo

-------{ CUT HERE time-warp-test.c }-------------->

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

#define TEST_TSC
#define TEST_TOD

#define MAX_TASKS 128

#if DEBUG
# define Printf(x...) printf(x)
#else
# define Printf(x...) do { } while (0)
#endif

enum {
	SHARED_TSC = 0,
	SHARED_LOCK = 2,
	SHARED_TOD = 3,
	SHARED_WORST_TSC = 5,
	SHARED_WORST_TOD = 7,
	SHARED_LOCK2 = 200,
};

#define BUG_ON(c) assert(!(c))

typedef unsigned long long cycles_t;
typedef unsigned long long usecs_t;

#define rdtscll(val) \
	__asm__ __volatile__("rdtsc" : "=A" (val))

#define rdtod(val)					\
do {							\
	struct timeval tv;				\
							\
	gettimeofday(&tv, NULL);			\
	(val) = tv.tv_sec * 1000000LL + tv.tv_usec;	\
} while (0)

#define mb() \
	__asm__ __volatile__("lock; addl $0, (%esp)")

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
	mb();
}

static void print_status(void)
{
	const char progress[] = "\\|/-";
	static usecs_t prev_tod;
	static int count;

	usecs_t tod;

	rdtod(tod);
	if (tod - prev_tod < 100000ULL)
		return;
	prev_tod = tod;
	count++;
	printf("%c\r", progress[count & 3]);
	fflush(stdout);
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

	printf("#CPUs: %ld\n", cpus);
	printf("running %ld tasks to check for time-warps.\n", tasks);
	shared = setup_shared_var();

	parent = getpid();

	for (i = 1; i < tasks; i++)
		if (!fork())
			break;
	me = getpid();

	while (1) {
		cycles_t t0, t1;
		usecs_t T0, T1;
		long long delta;

#ifdef TEST_TSC
		lock(shared + SHARED_LOCK);
		rdtscll(t1);
		t0 = *(cycles_t *)(shared + SHARED_TSC);
		*(cycles_t *)(shared + SHARED_TSC) = t1;
		unlock(shared + SHARED_LOCK);

		delta = t1-t0;
		if (delta < *(long long *)(shared + SHARED_WORST_TSC)) {
			*(long long *)(shared + SHARED_WORST_TSC) = delta;
			printf("\rwarp .. %9Ld cycles, ... %016Lx -> %016Lx ?\n",
				delta, t0, t1);
		}

		// occasionally disturb things a bit
		if (!(t0 & 7)) {
			lock(shared + SHARED_LOCK2);
			unlock(shared + SHARED_LOCK2);
		}
#endif

#ifdef TEST_TOD
		lock(shared + SHARED_LOCK);
		rdtod(T1);
		T0 = *(usecs_t *)(shared + SHARED_TOD);
		*(usecs_t *)(shared + SHARED_TOD) = T1;
		unlock(shared + SHARED_LOCK);

		delta = T1-T0;
		if (delta < *(long long *)(shared + SHARED_WORST_TOD)) {
			*(long long *)(shared + SHARED_WORST_TOD) = delta;
			printf("\rWARP .. %9Ld usecs, .... %016Lx -> %016Lx ?\n",
				delta, T0, T1);
		}
		if (!(T0 & 7)) {
			lock(shared + SHARED_LOCK2);
			unlock(shared + SHARED_LOCK2);
		}
#endif

		if (me == parent)
			print_status();
	}

	return 0;
}
