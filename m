Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWEMCY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWEMCY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 22:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWEMCY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 22:24:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28346 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750938AbWEMCY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 22:24:57 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: lkml <linux-kernel@vger.kernel.org>
Subject: rt20 scheduling latency testcase and failure data
Date: Fri, 12 May 2006 19:24:53 -0700
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1NUZEdIDjBKOdz6"
Message-Id: <200605121924.53917.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_1NUZEdIDjBKOdz6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have been noticing unexpected intermittant large latencies.  I wrote the 
attached test case to try and capture some information on them.  The librt.h 
file contains convenience functions I use for writing other tests as well, so 
much of it is irrelevant, but the test case itself is pretty clear I believe.

The test case emulates a periodic thread that wakes up on time%PERIOD=0, so 
rather than sleeping the same amount of time each round, it checks now 
against the start of its next period and sleeps for that length of time.  
Every so often it will miss it's period, I've captured that data and included 
a few of the interesting bits below.  The results are from a run with a 
period of 5ms, although I have seen them with periods as high as 17ms.  The 
system was under heavy network load for some of the time, but not all.



One scenario is when we just sleep longer than we planned to.  Note below that 
the actual delta is much larger that the requested sleep, so the latency is 
very high there, high enough that we woke up well into the next period.

ITERATION DELAY(US) MAX_DELAY(US) FAILURES
--------- --------- ------------- --------
     1514     11588         11588        1

PERIOD MISSED!
     scheduled delta:     4080 us
        actual delta:    15666 us
             latency:    11585 us
---------------------------------------
      previous start:  7581588 us
                 now:  7582504 us
     scheduled start:  7575000 us
next scheduled start is in the past!



In another scenario, far more common in my experience, is to awake with a very 
reasonable latency (6us more than requested here), but by the time we 
complete the loop and look at how long we need to sleep for until the next 
period, we see that it's deadline has already passed (scheduled_start < now).

ITERATION DELAY(US) MAX_DELAY(US) FAILURES
--------- --------- ------------- --------
     1240         9            14        0

PERIOD MISSED!
     scheduled delta:     4072 us
        actual delta:     4079 us
             latency:        6 us
---------------------------------------
      previous start:  6200009 us
                 now:  6210989 us
     scheduled start:  6205000 us
next scheduled start is in the past!


I'd appreciate any feedback on the test case, and in particular suggestions on 
how I can go about determining where this lost time is being spent.

Thanks,
-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
Phone: 503 578 3185
  T/L: 775 3185

--Boundary-00=_1NUZEdIDjBKOdz6
Content-Type: text/x-chdr;
  charset="us-ascii";
  name="librt.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="librt.h"

/*    Filename: librt.h
 *      Author: Darren Hart <dvhltc@us.ibm.com>
 * Description: A set of commonly used convenience functions for writing
 *              threaded realtime test cases.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (C) IBM Corporation, 2006
 *
 * 2006-Apr-26:	Initial version by Darren Hart
 * 2006-May-08:	Added atomic_{inc,set,get}, thread struct, debug function,
 * 				rt_init, buffered printing -- Vernon Mauery
 * 2006-May-09:	improved command line argument handling
 */

#ifndef LIBRT_H
#define LIBRT_H

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <time.h>
#include <string.h>
#include <pthread.h>
#include <sched.h>
#include <errno.h>
#include <unistd.h>
#include <getopt.h>
#include <sys/syscall.h>

extern int optind, opterr, optopt;
extern char *optarg;

#define _MAXTHREADS 256
#define ITERS_PER_US 5 /* appropriate for an LS20 @ 1993.842 MHz */
#define NS_PER_MS 1000000
#define NS_PER_US 1000
#define NS_PER_SEC 1000000000
#define US_PER_MS 1000
#define US_PER_SEC 1000000
#define MS_PER_SEC 1000

typedef unsigned long long nsec_t;

struct thread {
	pthread_t pthread;
	pthread_attr_t attr;
	pthread_mutex_t mutex;
	pthread_cond_t cond;
	void *arg;
	void *(*func)(void*);
	int priority;
	int policy;
	int flags;
	int id;
};
typedef struct { volatile int counter; } atomic_t;

// flags for threads
#define THREAD_START 1
#define THREAD_QUIT  2
#define thread_quit(T) (((T)->flags) & THREAD_QUIT)


static struct thread _threads[_MAXTHREADS];
static atomic_t _thread_count = {-1};

static pthread_mutex_t _buffer_mutex;
static char * _print_buffer = NULL;
static int _print_buffer_offset = 0;
#define PRINT_BUFFER_SIZE (1024*1024*4)
static int _dbg_lvl = 0;
static int _use_pi = 1;

/* function prototypes */

/* atomic_add - add integer to atomic variable
 * i: integer value to add
 * v: pointer of type atomic_t
 */
static inline int atomic_add(int i, atomic_t *v)
{
	int __i;
	__i = i;
	asm volatile(
			"lock; xaddl %0, %1;"
			:"=r"(i)
			:"m"(v->counter), "0"(i));
	return i + __i;
}
/* atomic_inc: atomically increment the integer passed by reference
 */
static inline int atomic_inc(atomic_t *v)
{
	return atomic_add(1, v);
}

/* atomic_get: atomically get the integer passed by reference
 */
//#define atomic_get(v) ((v)->counter)
static inline int atomic_get(atomic_t *v)
{
	return v->counter;
}

/* atomic_set: atomically get the integer passed by reference
 */
//#define atomic_set(i,v) ((v)->counter = (i))
static inline void atomic_set(int i, atomic_t *v)
{
	v->counter = i;
}

/* buffer_init: initialize the buffered printing system
 */
void buffer_init();

/* buffer_print: prints the contents of the buffer
 */
void buffer_print();

/* buffer_fini: destroy the buffer
 */
void buffer_fini();

/* debug: do debug prints at level L (see DBG_* below).  If buffer_init
 * has been called previously, this will print to the internal memory
 * buffer rather than to stderr.
 * L: debug level (see below) This will print if L is lower than _dbg_lvl
 * A: format string (printf style)
 * B: args to format string (printf style)
 */
static volatile int _debug_count = 0;
#define debug(L,A,B...) do {\
	if ((L) <= _dbg_lvl) {\
		pthread_mutex_lock(&_buffer_mutex);\
		if (_print_buffer) {\
			if (PRINT_BUFFER_SIZE - _print_buffer_offset < 1000)\
				buffer_print();\
			_print_buffer_offset += snprintf(&_print_buffer[_print_buffer_offset],\
					PRINT_BUFFER_SIZE - _print_buffer_offset, "%06d: "A, _debug_count++, ##B);\
		} else {\
			fprintf(stderr, "%06d: "A, _debug_count++, ##B);\
		}\
		pthread_mutex_unlock(&_buffer_mutex);\
	}\
} while(0)
#define DBG_ERR  1
#define DBG_WARN 2
#define DBG_INFO 3
#define DBG_DEBUG 4

/* rt_init: initialize librt
 * options: pass in an getopt style string of options -- e.g. "ab:cd::e:"
 *          if this or parse_arg is null, no option parsing will be done
 *          on behalf of the calling program (only internal args will be parsed)
 * parse_arg: a function that will get called when one of the above
 *            options is encountered on the command line.  It will be passed
 *            the option -- e.g. 'b' -- and the value.  Something like:
 *            // assume we passed "af:z::" to rt_init
 *            int parse_my_options(int option, char *value) {
 *                int handled = 1;
 *                switch (option) {
 *                    case 'a':
 *                        alphanum = 1;
 *                        break;
 *                    case 'f':
 *                    // we passed f: which means f has an argument
 *                        freedom = strcpy(value);
 *                        break;
 *                    case 'z':
 *                    // we passed z:: which means z has an optional argument
 *                        if (value)
 *                            zero_size = atoi(value);
 *                        else
 *                            zero_size++;
 *                    default:
 *                        handled = 0;
 *                }
 *                return handled;
 *            }           
 * argc: passed from main
 * argv: passed from main
 */
int rt_init(const char *options, int (*parse_arg)(int option, char *value), int argc, char *argv[]);

/* create_fifo_thread: spawn a SCHED_FIFO thread with priority prio running
 * func as the thread function with arg as it's parameter.
 * func:
 * arg: argument to func
 * prio: 1-100, 100 being highest priority
 */
int create_fifo_thread(void*(*func)(void*), void *arg, int prio);

/* create_other_thread: spawn a SCHED_OTHER thread
 * func as the thread function with arg as it's parameter.
 * func: 
 * arg: argument to func
 */
int create_other_thread(void*(*func)(void*), void *arg);

/* all_threads_quit: signal all threads to quit */
void all_threads_quit(void);

/* join_threads: wait for all threads to finish
 * (calls all_threads_quit interally)
 */
void join_threads();

/* signal thread i to quit and then call join */
void join_thread(int i);

/* return the delta in ts_delta
 * ts_end > ts_start
 * if ts_delta is not null, the difference will be returned in it
 */
void ts_minus(struct timespec *ts_end, struct timespec *ts_start, struct timespec *ts_delta);

/* return the sum in ts_sum
 * all arguments are not null
 */
void ts_plus(struct timespec *ts_a, struct timespec *ts_b, struct timespec *ts_sum);

/* put a ts into proper form (nsec < NS_PER_SEC)
 * ts must not be null
 */
void ts_normalize(struct timespec *ts);

/* convert nanoseconds to a timespec 
 * ts must not be null
 */
void nsec_to_ts(nsec_t ns, struct timespec *ts);

/* convert a timespec to nanoseconds
 * ts must not be null
 */
int ts_to_nsec(struct timespec *ts, nsec_t *ns);

/* rt_nanosleep: sleep for ns nanoseconds using clock_nanosleep
 */
void rt_nanosleep(nsec_t ns);

/* rt_gettime: get CLOCK_MONOTONIC time in nanoseconds
 */
nsec_t rt_gettime();

/* busy_work_ms: do busy work for ms milliseconds
 */
void *busy_work_ms(int ms);

/* busy_work_us: do busy work for us microseconds
 */
void *busy_work_us(int us);

/* function implementations */
int rt_init(const char *options, int (*parse_arg)(int option, char *value), int argc, char *argv[])
{
	int use_buffer = 1;
	int i, c;
	opterr = 0;
	char *all_options, *opt_ptr;
	static const char my_options[] = "bp:v::";

	if (options) {
		opt_ptr = all_options = (char *)malloc(sizeof(my_options) + strlen(options) + 1);
		for (i=0; i<strlen(options); i++) {
			char opt = options[i];
			if (opt != ':' && !strchr(my_options, opt)) {
				*opt_ptr++ = opt;
				if (options[i+1] == ':') {
					*opt_ptr++ = ':';
					i++;
				}
			} else {
				printf("Programmer error -- argument -%c already used by librt.h\n", opt);
			}
		}
		strcpy(opt_ptr, my_options);
	} else {
		all_options = (char *)my_options;
	}

	while ((c = getopt(argc, argv, all_options)) != -1) {
		switch (c) {
			case 'b':
				use_buffer = atoi(optarg);
				break;
			case 'p':
				_use_pi = atoi(optarg);
				break;
			case 'v':
				if (optarg)
					_dbg_lvl = atoi(optarg);
				else
					_dbg_lvl++;
				break;
			default:
				if (parse_arg) {
					if (!parse_arg(c, optarg)) {
						printf("option -%c not recognized\n", optopt);
					}
				}
		}
	}
	if (!_use_pi)
		printf("Priority Inheritance has been disabled for this run.\n");
	if (use_buffer)
		buffer_init();
	atexit(buffer_fini);
	return 0;
}

void buffer_init(void)
{
	_print_buffer = (char *)malloc(PRINT_BUFFER_SIZE);
	if (!_print_buffer)
		fprintf(stderr, "insufficient memory for print buffer - printing directly to stderr\n");
	else
		memset(_print_buffer, 0, PRINT_BUFFER_SIZE);
}

void buffer_print(void)
{
	if (_print_buffer) {
		fprintf(stderr, "%s", _print_buffer);
		memset(_print_buffer, 0, PRINT_BUFFER_SIZE);
		_print_buffer_offset = 0;
	}
}

void buffer_fini(void)
{
	if (_print_buffer)
		free(_print_buffer);
	_print_buffer = NULL;
}

int create_fifo_thread(void*(*func)(void*), void *arg, int prio)
{
	struct sched_param param;
	int id;
	struct thread *thread;

	id = atomic_inc(&_thread_count);
	if (id >= _MAXTHREADS)
		return -1;

	thread = &_threads[id];
	thread->id = id;
	thread->priority = prio;
	thread->policy = SCHED_FIFO;
	thread->flags = 0;
	thread->arg = arg;
	thread->func = func;
	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + prio;

	pthread_attr_init(&thread->attr);
	pthread_attr_setinheritsched(&thread->attr, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedparam(&thread->attr, &param);
	pthread_attr_setschedpolicy(&thread->attr, SCHED_FIFO);

	if (pthread_create(&thread->pthread, &thread->attr, func, (void*)thread)) {
		perror("pthread_create failed");
	}

	pthread_attr_destroy(&thread->attr);
	return id;
}

int create_other_thread(void*(*func)(void*), void *arg)
{
	int id;
	struct thread *thread;

	id = atomic_inc(&_thread_count);
	if (id >= _MAXTHREADS)
		return -1;

	thread = &_threads[id];
	thread->id = id;
	thread->priority = 0;
	thread->policy = SCHED_OTHER;
	thread->flags = 0;
	thread->arg = arg;
	thread->func = func;

	pthread_attr_init(&thread->attr);
	pthread_attr_setinheritsched(&thread->attr, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&thread->attr, SCHED_OTHER);

	if (pthread_create(&thread->pthread, &thread->attr, func, (void*)thread)) {
		perror("pthread_create failed");
	}

	pthread_attr_destroy(&thread->attr);
	return id;
}

void join_thread(int i)
{
	_threads[i].flags |= THREAD_QUIT;
	pthread_join(_threads[i].pthread, 0);
}
void all_threads_quit(void)
{
    int i;

    for (i = 0; i < atomic_get(&_thread_count); i++) {
		_threads[i].flags |= THREAD_QUIT;
    }
}
void join_threads(void)
{
    int i;

	all_threads_quit();
    for (i = 0; i < atomic_get(&_thread_count); i++) {
        pthread_join(_threads[i].pthread, 0);
    }
}

void ts_minus(struct timespec *ts_end, struct timespec *ts_start, struct timespec *ts_delta)
{
	if (ts_end == NULL || ts_start == NULL || ts_delta == NULL) {
		printf("ERROR in %s: one or more of the timespecs is NULL", __FUNCTION__);
		return;
	}

	ts_delta->tv_sec = ts_end->tv_sec - ts_start->tv_sec;
	ts_delta->tv_nsec = ts_end->tv_nsec - ts_start->tv_nsec;
	ts_normalize(ts_delta);
}

void ts_plus(struct timespec *ts_a, struct timespec *ts_b, struct timespec *ts_sum)
{
	if (ts_a == NULL || ts_b == NULL || ts_sum == NULL) {
		printf("ERROR in %s: one or more of the timespecs is NULL", __FUNCTION__);
		return;
	}

	ts_sum->tv_sec = ts_a->tv_sec + ts_b->tv_sec;
	ts_sum->tv_nsec = ts_a->tv_nsec + ts_b->tv_nsec;
	ts_normalize(ts_sum);
}

void ts_normalize(struct timespec *ts)
{
	if (ts == NULL) {
		/* FIXME: write a real error logging system */
		printf("ERROR in %s: ts is NULL\n", __FUNCTION__);
		return;
	}
	
	/* get the abs(nsec) < NS_PER_SEC */
	while (ts->tv_nsec > NS_PER_SEC) {
		ts->tv_sec++;
		ts->tv_nsec -= NS_PER_SEC;
	}
	while (ts->tv_nsec < -NS_PER_SEC) {
		ts->tv_sec--;
		ts->tv_nsec += NS_PER_SEC;
	}

	/* get the values to the same polarity */
	if (ts->tv_sec > 0 && ts->tv_nsec < 0) {
		ts->tv_sec--;
		ts->tv_nsec += NS_PER_SEC;
	}
	if (ts->tv_sec < 0 && ts->tv_nsec > 0) {
		ts->tv_sec++;
		ts->tv_nsec -= NS_PER_SEC;
	}
}

int ts_to_nsec(struct timespec *ts, nsec_t *ns)
{
	struct timespec t;
	if (ts == NULL) {
		/* FIXME: write a real error logging system */
		printf("ERROR in %s: ts is NULL\n", __FUNCTION__);
		return -1;
	}
	t.tv_sec = ts->tv_sec;
	t.tv_nsec = ts->tv_nsec;
	ts_normalize(&t);

	if (t.tv_sec <= 0 && t.tv_nsec < 0) {
		printf("ERROR in %s: ts is negative\n", __FUNCTION__);
		return -1;
	}

	*ns = (nsec_t)ts->tv_sec*NS_PER_SEC + ts->tv_nsec;
	return 0;
}

void nsec_to_ts(nsec_t ns, struct timespec *ts)
{
	if (ts == NULL) {
		/* FIXME: write a real error logging system */
		printf("ERROR in %s: ts is NULL\n", __FUNCTION__);
		return;
	}
	ts->tv_sec = ns/NS_PER_SEC;
	ts->tv_nsec = ns%NS_PER_SEC;
}

void rt_nanosleep(nsec_t ns) {
	struct timespec ts_sleep, ts_rem;
	int rc;
	nsec_to_ts(ns, &ts_sleep);
	rc = clock_nanosleep(CLOCK_MONOTONIC, 0, &ts_sleep, &ts_rem);
	/* FIXME: when should we display the remainder ? */
	if (rc != 0) {
		printf("WARNING: rt_nanosleep() returned early by %d s %d ns\n",
			ts_rem.tv_sec, ts_rem.tv_nsec);
	}
}

nsec_t rt_gettime() {
	struct timespec ts;
	nsec_t ns;
	int rc;

	rc = clock_gettime(CLOCK_MONOTONIC, &ts);
	if (rc != 0) {
		printf("ERROR in %s: clock_gettime() returned %d\n", __FUNCTION__, rc);
		perror("clock_gettime() failed");
		return 0;
	}
	
	ts_to_nsec(&ts, &ns);
	return ns;
}

void *busy_work_ms(int ms)
{
	busy_work_us(ms*US_PER_MS);
	return NULL;
}

void *busy_work_us(int us)
{
	int i;
	int scale;
	double pi_scaled;
	double pi_value;
	nsec_t start, now;
	int delta; /* time in us */

	scale = us * ITERS_PER_US;
	pi_scaled = 0;
	start = rt_gettime();
	for (i = 0; i < scale; i++) {
		double pi = 16 * atan(1.0 / 5.0) - 4 * atan(1.0 / 239.0);
		pi_scaled += pi;
	}
	pi_value = pi_scaled / scale;
	now = rt_gettime();
	delta = (now - start)/NS_PER_US;
	/* uncomment to tune to your machine */
        /* printf("busy_work_us requested: %dus  actual: %dus\n", us, delta); */
	return NULL;
}

#endif /* LIBRT_H */

--Boundary-00=_1NUZEdIDjBKOdz6
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="sched_latency_lkml.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched_latency_lkml.c"

/*    Filename: sched_latency_lkml.c
 *      Author: Darren Hart <dvhltc@us.ibm.com>
 * Description: Measure the latency involved with periodic scheduling.
 * Compilation: gcc -O2 -g -D_GNU_SOURCE -I/usr/include/nptl -I -L/usr/lib/nptl -lpthread -lrt -lm sched_latency_lkml.c -o sched_latency_lkml
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (C) IBM Corporation, 2006
 *
 * 2006-May-10:	Initial version by Darren Hart <dvhltc@us.ibm.com>
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "librt.h"

#define PRIO 98
//#define PERIOD 17*NS_PER_MS
//#define ITERATIONS 100
#define ITERATIONS 10000
#define PERIOD 5*NS_PER_MS
#define PASS_US 100

nsec_t start;

void *periodic_thread(void *arg)
{
	struct thread *t = (struct thread *)arg;
	int i;
	int delay, avg_delay = 0, start_delay, min_delay = 0x7FFFFFF, max_delay = 0;
	int failures = 0;
	nsec_t next=0, now=0, sched_delta=0, delta=0, prev=0;

	prev = start;
	next = start;
	now = rt_gettime();
	start_delay = (now - start)/NS_PER_US;

	printf("ITERATION DELAY(US) MAX_DELAY(US) FAILURES\n");
	printf("--------- --------- ------------- --------\n");
	for (i = 1; i <= ITERATIONS; i++) {
		/* wait for the period to start */
		next += PERIOD;
		prev = now;
		now = rt_gettime();

		if (next < now) {
			printf("\n\nPERIOD MISSED!\n");
			printf("     scheduled delta: %8llu us\n", sched_delta/1000);
			printf("        actual delta: %8llu us\n", delta/1000);
			printf("             latency: %8llu us\n", (delta-sched_delta)/1000);
			printf("---------------------------------------\n");
			printf("      previous start: %8llu us\n", (prev-start)/1000);
			printf("                 now: %8llu us\n", (now-start)/1000);
			printf("     scheduled start: %8llu us\n", (next-start)/1000);
			printf("next scheduled start is in the past!\n");
			break;
		}

		sched_delta = next - now; /* how long we should sleep */
		delta = 0;
		do {
			rt_nanosleep(next - now);
			delta += rt_gettime() - now; /* how long we did sleep */
			now = rt_gettime();
		} while (now < next);

		/* start of period */
		now = rt_gettime();
		delay = (now - start - (nsec_t)i*PERIOD)/NS_PER_US;
		if (delay < min_delay)
			min_delay = delay;
		if (delay > max_delay)
			max_delay = delay;
		if (delay > PASS_US)
			failures++;
		avg_delay += delay;

		/* continuous status ticker */
		printf("%9i %9i %13i %8i\r", i, delay, max_delay, failures);
		fflush(stdout);
		
		busy_work_ms(1);
	}

	avg_delay /= ITERATIONS;
	printf("\n\n");
	printf("Start Latency: %4d us: %s\n", start_delay, 
		start_delay < PASS_US ? "PASS" : "FAIL");
	printf("Min Latency:   %4d us: %s\n", min_delay,
		min_delay < PASS_US ? "PASS" : "FAIL");
	printf("Avg Latency:   %4d us: %s\n", avg_delay,
		avg_delay < PASS_US ? "PASS" : "FAIL");
	printf("Max Latency:   %4d us: %s\n", max_delay,
		max_delay < PASS_US ? "PASS" : "FAIL");
	printf("Failed Iterations: %d\n\n", failures);

	return NULL;
}

int main(int argc, char *argv[])
{
	int per_id, mas_id;

	printf("-------------------------------\n");
	printf("Scheduling Latency\n");
	printf("-------------------------------\n\n");
	printf("Running %d iterations with a period of %d ms\n", ITERATIONS, PERIOD/NS_PER_MS);
	printf("Expected running time: %d s\n\n", (nsec_t)ITERATIONS*PERIOD/NS_PER_SEC);

	start = rt_gettime();
	per_id = create_fifo_thread(periodic_thread, (void*)0, PRIO);

	join_thread(per_id);
	join_threads();

	return 0;
}

--Boundary-00=_1NUZEdIDjBKOdz6--
