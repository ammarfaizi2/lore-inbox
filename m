Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030626AbWAHJtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbWAHJtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbWAHJtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:49:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:4244 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030626AbWAHJtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:49:19 -0500
Date: Sun, 8 Jan 2006 10:48:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PowerPC fastpaths for mutex subsystem
Message-ID: <20060108094839.GA16887@elte.hu>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net> <43BFFF1D.7030007@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BFFF1D.7030007@austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Schopp <jschopp@austin.ibm.com> wrote:

> Tested on a 4 core (2 SMT threads/core) Power5 machine with gcc 3.3.2.

> Test results from synchro-test.ko:
> 
> All tests run for default 5 seconds
> Threads semaphores  mutexes     mutexes+attached
> 1       63,465,364  58,404,630  62,109,571
> 4       58,424,282  35,541,297  37,820,794
> 8       40,731,668  35,541,297  40,281,768
> 16      38,372,769  37,256,298  41,751,764
> 32      38,406,895  36,933,675  38,731,571
> 64      37,232,017  36,222,480  40,766,379

interesting. Could you try two things? Firstly, could you add some 
minimal delays to the lock/unlock path, of at least 1 usec? E.g.  
"synchro-test.ko load=1 interval=1". [but you could try longer delays 
too, 10 usecs is still realistic.]

secondly, could you try the VFS creat+unlink test via the test-mutex.c 
code below, with something like:

	./test-mutex V 16 10

(this tests with 16 tasks, for 10 seconds.) You'll get a useful ops/sec 
number out of this test, but the other stats will only be calculated if 
you implement the rdtsc() macro to read cycles - right now it defaults 
to 'always 0' on ppc, i386 and ia64 has it implemented. Also, beware 
that the default atomic_inc()/dec() is unsafe (only i386 and ia64 has 
the real thing implemented), you might want to add a safe PPC 
implementation.

thirdly, could you run 'vmstat 1' during the tests, and post those lines 
too? Here i'm curious about two things: the average runqueue length 
(whether we have overscheduling), and CPU utilization and idle time left 
(how efficiently cycles are preserved in contention). [btw., does ppc 
have an idle=poll equivalent mode of idling?]

also, there seems to be some fluctuation in the numbers - could you try 
to run a few more to see how stable the numbers are?

	Ingo

------------
/*
 * Copyright (C) 2005, Ingo Molnar <mingo@redhat.com>
 */

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <linux/unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
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

#ifdef __ia64__
#include <sys/ioctl.h>
#include "mmtimer.h"
int mmtimer_fd;

unsigned long __mm_timer_clock_res;
unsigned long *__mm_clock_dev;
unsigned long __mm_clock_offset;
#endif

unsigned long *shared;

#define mutex_lock()    gettimeofday((void *)0, (void *)10)
#define mutex_unlock()  gettimeofday((void *)0, (void *)20)
#define down()          gettimeofday((void *)0, (void *)100)
#define up()            gettimeofday((void *)0, (void *)200)
#define down_write()    gettimeofday((void *)0, (void *)1000)
#define up_write()      gettimeofday((void *)0, (void *)2000)
#define down_read()     gettimeofday((void *)0, (void *)10000)
#define up_read()       gettimeofday((void *)0, (void *)20000)

/*
 * Shared locks and variables between the test tasks:
 */
#define CACHELINE_SIZE (128/sizeof(long))

enum {
	SHARED_DELTA_SUM		= 0*CACHELINE_SIZE,
	SHARED_DELTA_MAX		= 1*CACHELINE_SIZE,
	SHARED_DELTA2_SUM		= 2*CACHELINE_SIZE,
	SHARED_DELTA2_MAX		= 3*CACHELINE_SIZE,
	SHARED_DELTA3_SUM		= 4*CACHELINE_SIZE,
	SHARED_DELTA3_MAX		= 5*CACHELINE_SIZE,
	SHARED_DELTA_DELTA_SUM		= 6*CACHELINE_SIZE,
	SHARED_COUNT			= 7*CACHELINE_SIZE,
	SHARED_SUM			= 8*CACHELINE_SIZE,
	SHARED_LOCK			= 9*CACHELINE_SIZE,
	SHARED_END			= 10*CACHELINE_SIZE,
};

#define SHARED(x)	(*(shared + SHARED_##x))
#define SHARED_LL(x)	(*(unsigned long long *)(shared + SHARED_##x))

#define BUG_ON(c)	assert(!(c))

static unsigned long *setup_shared_var(void)
{
	char zerobuff [4096] = { 0, };
	int ret, fd;
	unsigned long *buf;
	char tmpfile[100];

	sprintf(tmpfile, ".tmp_mmap-%d", getpid());

	fd = creat(tmpfile, 0700);

	BUG_ON(fd == -1);
	close(fd);

	fd = open(tmpfile, O_RDWR|O_CREAT|O_TRUNC);
	unlink(tmpfile);
	BUG_ON(fd == -1);
	ret = write(fd, zerobuff, 4096);
	BUG_ON(ret != 4096);

	buf = (void *)mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	BUG_ON(buf == (void *)-1);

	close(fd);

	return buf;
}

#define LOOPS 10000

#ifdef __ia64__
static int setup_mmtimer(void)
{
	unsigned long regoff;
	int fd, _t;
	size_t pagesize;

	if ((fd = open ("/dev/mmtimer", O_RDONLY)) == -1)
		perror("missing /dev/mmtimer");
	else {
		pagesize = getpagesize();
		__mm_clock_dev = mmap(0, pagesize, PROT_READ,
				      MAP_SHARED, fd, 0);
		if (__mm_clock_dev != MAP_FAILED) {
			regoff = ioctl(fd, MMTIMER_GETOFFSET, 0);
			if (regoff >= 0) {
				__mm_clock_dev += regoff;
				__mm_clock_offset = *__mm_clock_dev;
			} else
				perror("reg offset ioctl failed");
			_t = ioctl(fd, MMTIMER_GETFREQ, &__mm_timer_clock_res);
			if (_t)
				perror("get freq ioctl fail");
		}
	}
}


#define ia64_fetchadd8_rel(p, inc)					\
({									\
	__u64 ia64_intri_res;						\
	asm volatile ("fetchadd8.rel %0=[%1],%2"			\
				: "=r"(ia64_intri_res) : "r"(p), "i" (inc) \
				: "memory");				\
									\
	ia64_intri_res;							\
})

static inline void atomic_inc(unsigned long *flag)
{
	ia64_fetchadd8_rel(flag, 1);
}

static inline void atomic_dec(unsigned long *flag)
{
	ia64_fetchadd8_rel(flag, -1);
}
#elif defined(__i386__)
static inline void atomic_inc(unsigned long *flag)
{
	__asm__ __volatile__(
		"lock; incl %0\n"
			     : "=g"(*flag) : : "memory");
}

static inline void atomic_dec(unsigned long *flag)
{
	__asm__ __volatile__(
		"lock; decl %0\n"
			     : "=g"(*flag) : : "memory");
}
#else
static inline void atomic_inc(unsigned long *flag)
{
	++*flag;
}

static inline void atomic_dec(unsigned long *flag)
{
	--*flag;
}
#endif

static void LOCK(unsigned long *shared)
{
	for (;;) {
		atomic_inc(&SHARED(LOCK));
		if (SHARED(LOCK) == 1)
			break;
		atomic_dec(&SHARED(LOCK));
		usleep(1);
	}
}

static void UNLOCK(unsigned long *shared)
{
	atomic_dec(&SHARED(LOCK));
}


static void sigint(int sig)
{
	atomic_inc(&SHARED(END));
}

static void print_status(unsigned long *shared)
{
	unsigned long count;

	count = SHARED(COUNT);
	SHARED(COUNT) = 0;
	SHARED_LL(SUM) += count;

	printf("\r| loops/sec: %ld    \r", count);
	fflush(stdout);
}

enum {
	TYPE_MUTEX,
	TYPE_SEM,
	TYPE_RSEM,
	TYPE_WSEM,
	TYPE_VFS,
	NR_TYPES
};

const char * type_names[NR_TYPES] =
	{	"Mutex",
		"Semaphore",
		"RW-semaphore Read",
		"RW-semaphore Write",
		"VFS"
	};


typedef unsigned long long cycles_t;
typedef unsigned long long usecs_t;

#ifdef __ia64__
# define rdtscll(val)					\
do {							\
	val = *__mm_clock_dev;				\
} while (0)
#elif defined(__i386__)
# define rdtscll(val)					\
do {							\
	__asm__ __volatile__("rdtsc" : "=A" (val));	\
} while (0)
#else
# define rdtscll(val) \
	do { (val) = 0LL; } while (0)
#endif

#define rdtod(val)					\
do {							\
	struct timeval tv;				\
							\
	gettimeofday(&tv, NULL);			\
	(val) = tv.tv_sec * 1000000ULL + tv.tv_usec;	\
} while (0)

#define max(x,y) ({ \
	typeof(x) _x = (x);	\
	typeof(y) _y = (y);	\
	(void) (&_x == &_y);		\
	_x > _y ? _x : _y; })

#define unlikely(x) __builtin_expect(!!(x), 0)

int main(int argc, char **argv)
{
	int i, parent, me, first = 1;
	unsigned long cpus, tasks, seconds = 0;
	cycles_t t0, t01, t1, delta, delta2, delta3, delta_sum = 0,
		delta2_sum = 0, delta3_sum = 0, delta_delta,
		delta_delta_sum = 0, prev_delta,
		delta_max = 0, delta2_max = 0, delta3_max = 0;
	char str[100];
	double freq;
	int type;

	if (argc <= 1 || argc > 4) {
usage:
		fprintf(stderr,
			"usage: test-mutex [Mutex|Sem|Rsem|Wsem|Vfs creat+unlink] <threads> <seconds>\n");
		exit(-1);
usage2:
		fprintf(stderr, "the Mutex/Sem/Rsem/Wsem tests are not available.\n");
		goto usage;
	}

	switch (argv[1][0]) {
		case 'M': type = TYPE_MUTEX; goto usage2; break;
		case 'S': type = TYPE_SEM; goto usage2;  break;
		case 'R': type = TYPE_RSEM; goto usage2; break;
		case 'W': type = TYPE_WSEM; goto usage2; break;
		case 'V': type = TYPE_VFS; break;
		 default: goto usage;
	}

	system("rm -f /tmp/* 2>/dev/null >/dev/null");
	cpus = system("exit `grep processor /proc/cpuinfo  | wc -l`");
	cpus = WEXITSTATUS(cpus);

	tasks = cpus;
	if (argc >= 3) {
		tasks = atol(argv[2]);
		if (!tasks)
			goto usage;
	}

	if (argc >= 4)
		seconds = atol(argv[3]);
	else
		seconds = -1;

#ifdef __ia64__
	setup_mmtimer();
#endif

	printf("%ld CPUs, running %ld parallel test-tasks.\n", cpus, tasks);
	printf("checking %s performance.\n", type_names[type]);

	shared = setup_shared_var();

	signal(SIGINT, sigint);
	signal(SIGHUP, sigint);

	parent = getpid();

	for (i = 0; i < tasks; i++)
		if (!fork())
			break;
	sleep(1);
	me = getpid();
	sprintf(str, "/tmp/tmp-%d", me);

	if (me == parent) {
		unsigned long long total_count;
		int i = 0, j;

		for (;;) {
			sleep(1);
			if (i == seconds || SHARED(END))
				break;
			i++;
			print_status(shared);
		}
		atomic_inc(&SHARED(END));
		total_count = SHARED(SUM);
		for (j = 0; j < tasks; j++)
			wait(NULL);

		if (i)
			printf("\navg ops/sec:               %Ld\n", total_count / i);
		LOCK(shared);
//		printf("delta_sum: %Ld\n", SHARED_LL(DELTA_SUM));
//		printf("delta_delta_sum: %Ld\n", SHARED_LL(DELTA_DELTA_SUM));
#ifdef __ia64__
		freq = 25.0;
#else
		freq = 700.0;
#endif

		printf("average cost per op:       %.2f usecs\n",
			(double)SHARED_LL(DELTA_SUM)/total_count/freq);
		printf("average cost per lock:     %.2f usecs\n",
			(double)SHARED_LL(DELTA2_SUM)/total_count/freq);
		printf("average cost per unlock:   %.2f usecs\n",
			(double)SHARED_LL(DELTA3_SUM)/total_count/freq);
		printf("max cost per op:           %.2f usecs\n",
			(double)SHARED_LL(DELTA_MAX)/freq);
		printf("max cost per lock:         %.2f usecs\n",
			(double)SHARED_LL(DELTA2_MAX)/freq);
		printf("max cost per unlock:       %.2f usecs\n",
			(double)SHARED_LL(DELTA3_MAX)/freq);
		printf("average deviance per op:   %.2f usecs\n",
			(double)SHARED_LL(DELTA_DELTA_SUM)/total_count/freq/2.0);
		UNLOCK(shared);
		exit(0);
	}

	for (;;) {
		rdtscll(t0);

		switch (type) {
			case TYPE_MUTEX:
				mutex_lock();
				rdtscll(t01);
				mutex_unlock();
				break;
			case TYPE_SEM:
				down();
				rdtscll(t01);
				up();
				break;
			case TYPE_RSEM:
				down_read();
				rdtscll(t01);
				up_read();
				break;
			case TYPE_WSEM:
				down_write();
				rdtscll(t01);
				up_write();
				break;
			case TYPE_VFS:
			{
				int fd;

				fd = creat(str, S_IRWXU);
				rdtscll(t01);
				close(fd);

				break;
			}
		}
		rdtscll(t1);

		delta = t1-t0;
		if (unlikely(delta > delta_max))
			delta_max = delta;
		delta_sum += delta;

		delta2 = t01-t0;
		if (unlikely(delta2 > delta2_max))
			delta2_max = delta2;
		delta2_sum += delta2;

		delta3 = t1-t01;
		if (unlikely(delta3 > delta3_max))
			delta3_max = delta3;
		delta3_sum += delta3;

		if (!first) {
			if (prev_delta < delta)
				delta_delta = delta - prev_delta;
			else
				delta_delta = prev_delta - delta;
			delta_delta_sum += delta_delta;
#if 0
			printf("%Ld-%Ld {%Ld} prev: {%Ld} / [%Ld]\n",
				t0, t1, delta, prev_delta, delta_delta);
			printf("  {%Ld} - {%Ld}\n",
				delta_sum, delta_delta_sum);
#endif
		} else
			first = 0;

		prev_delta = delta;

		atomic_inc(&SHARED(COUNT));

		if (unlikely(SHARED(END))) {
			LOCK(shared);
			SHARED_LL(DELTA_SUM) += delta_sum;
			SHARED_LL(DELTA_MAX) = max(SHARED_LL(DELTA_MAX),
							delta_max);
			SHARED_LL(DELTA2_SUM) += delta2_sum;
			SHARED_LL(DELTA2_MAX) = max(SHARED_LL(DELTA2_MAX),
							delta2_max);
			SHARED_LL(DELTA3_SUM) += delta3_sum;
			SHARED_LL(DELTA3_MAX) = max(SHARED_LL(DELTA3_MAX),
							delta3_max);
			SHARED_LL(DELTA_DELTA_SUM) += delta_delta_sum;
#if 0
			printf("delta_sum: %Ld\n", delta_sum);
			printf("delta_delta_sum: %Ld\n", delta_delta_sum);
			printf("DELTA_SUM: %Ld\n", SHARED_LL(DELTA_SUM));
			printf("DELTA_DELTA_SUM: %Ld\n", SHARED_LL(DELTA_DELTA_SUM));
#endif
			UNLOCK(shared);

			exit(0);
		}
	}

	return 0;
}
