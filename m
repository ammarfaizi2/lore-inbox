Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136519AbREDV3v>; Fri, 4 May 2001 17:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136527AbREDV3h>; Fri, 4 May 2001 17:29:37 -0400
Received: from bitmover.com ([207.181.251.162]:34328 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136519AbREDV3T>;
	Fri, 4 May 2001 17:29:19 -0400
Date: Fri, 4 May 2001 14:29:15 -0700
From: Larry McVoy <lm@bitmover.com>
To: Adam Radford <aradford@3WARE.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware 6410 RAID 10 performance?
Message-ID: <20010504142915.B12431@work.bitmover.com>
Mail-Followup-To: Adam Radford <aradford@3WARE.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EABAB@siamese>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EABAB@siamese>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 02:03:35PM -0700, Adam Radford wrote:
> Larry,
> 
> If there's anything to fix in the driver for this problem I'd be interested,
> however I have not seen this problem before.
> 
> What benchmark (and options) are you running? bonnie++ ?
> 
> BTW... I am the author of the Linux driver.

First let me say I really like this card.  It's definitely the right
idea and when it works it screams.  I used to work on really large I/O
systems at SGI so I have a fair amount of experience in this area (the
last system I worked on images the entire earth down to about 32 point
fonts, pretty wacky, our tax dollars at work).

Anyway, the benchmark I use is a program called lmdd, it's part of
lmbench but I've pulled all the files together into one and included
it below.  It's really a handy tool, lots of different file system and
disk drive people use it.  For years, I've known I need to wrap a shell
script around it so that we could toss stuff like bonnie and iozone.

The typical ways I run it 

	# allocate and touch a buffer to flush memory
	lmdd opat=1 bs=512m count=1

	# write a file, watching for variation in write times
	lmdd of=XXX bs=100m wt=1 move=2g

	# read a file, watching for variation in read times
	lmdd if=XXX bs=100m rt=1 move=2g

lmdd is a lot like dd(1) but has the following key differences

	a) the default if is an interal form of if=/dev/zero, it
	   doesn't bother with the read from /dev/zero.
	b) the default of is an interal form of of=/dev/null, it
	   doesn't bother with the write to /dev/null.
	c) default blocksize is 8KB

On top of that, it has a number of options not found in dd

	fork=1		fork to do write I/O
	fsync=1		fsync output before exit
	ipat=1		check input for a pattern (see opat)
	mismatch=1	use with ipat, stop at first mismatch
	move=<amt>	move <amt> bytes; takes k, m, and g suffices
			k/m/g are powers of ten, not 2, the disk people
			want powers of ten.  Yeah, it sucks.
	opat=1		put a pattern in the output stream
	rand=<sz>	do randoms over this size
	print=<p>	different output formats, you want print=1 with rand
	rt=1		time and report results for each read
	wt=1		time and report results for each write
	srand=seed	seed the random number generator, used with rand.

There are others, read the source for them, those are the useful ones.

Another tidbit of data on the 3ware card issues - it is definitely associated
with that card or the drives on that card; if I do the same tests on a file
system which is not going through the 3ware card, I get repeatable 27MB/sec
performance.  Yes, I did try it after the 3ware card was wedged, the 
non 3ware performance is still good.

Adam, if you want to ssh in and play with the machine directly, call me
at 415-401-8808 x101 and I'll set you up immediately.

Thanks,

--lm

/*
 * $Id$
 */
#ifndef _BENCH_H
#define _BENCH_H

#ifdef WIN32
#include <windows.h>
typedef unsigned char bool_t;
#endif

#include	<assert.h>
#include        <ctype.h>
#include        <stdio.h>
#ifndef WIN32
#include        <unistd.h>
#endif
#include        <stdlib.h>
#include        <fcntl.h>
#include        <signal.h>
#include        <errno.h>
#ifndef WIN32
#include        <strings.h>
#endif
#include        <sys/types.h>
#ifndef WIN32
#include        <sys/mman.h>
#endif
#include        <sys/stat.h>
#ifndef WIN32
#include        <sys/wait.h>
#include	<time.h>
#include        <sys/time.h>
#include        <sys/socket.h>
#include        <sys/un.h>
#include        <sys/resource.h>
#define PORTMAP
#include	<rpc/rpc.h>
#endif

typedef unsigned int u32;

#ifdef HAVE_u64_t
typedef u64_t u64;
#else
typedef unsigned long long u64;
#endif

#define	NO_PORTMAPPER	/* needs to be up here, lib_*.h look at it */
#include	"stats.h"
#include	"timing.h"


#ifdef	DEBUG
#	define		debug(x) fprintf x
#else
#	define		debug(x)
#endif
#ifdef	NO_PORTMAPPER
#define TCP_SELECT	-31233
#define	TCP_XACT	-31234
#define	TCP_CONTROL	-31235
#define	TCP_DATA	-31236
#define	TCP_CONNECT	-31237
#define	UDP_XACT	-31238
#define	UDP_DATA	-31239
#else
#define	TCP_SELECT	(u_long)404038	/* XXX - unregistered */
#define	TCP_XACT	(u_long)404039	/* XXX - unregistered */
#define	TCP_CONTROL	(u_long)404040	/* XXX - unregistered */
#define	TCP_DATA	(u_long)404041	/* XXX - unregistered */
#define	TCP_CONNECT	(u_long)404042	/* XXX - unregistered */
#define	UDP_XACT 	(u_long)404032	/* XXX - unregistered */
#define	UDP_DATA 	(u_long)404033	/* XXX - unregistered */
#define	VERS		(u_long)1
#endif

#define	UNIX_CONTROL	"/tmp/lmbench.ctl"
#define	UNIX_DATA	"/tmp/lmbench.data"
#define	UNIX_LAT	"/tmp/lmbench.lat"

/*
 * socket send/recv buffer optimizations
 */
#define	SOCKOPT_READ	0x0001
#define	SOCKOPT_WRITE	0x0002
#define	SOCKOPT_RDWR	0x0003
#define	SOCKOPT_PID	0x0004
#define	SOCKOPT_REUSE	0x0008
#define	SOCKOPT_NONE	0

#ifndef SOCKBUF
#define	SOCKBUF		(1024*1024)
#endif

#ifndef	XFERSIZE
#define	XFERSIZE	(64*1024)	/* all bandwidth I/O should use this */
#endif

#if defined(SYS5) || defined(WIN32)
#define	bzero(b, len)	memset(b, 0, len)
#define	bcopy(s, d, l)	memcpy(d, s, l)
#define	rindex(s, c)	strrchr(s, c)
#endif
#define	gettime		usecs_spent
#define	streq		!strcmp
#define	ulong		unsigned long

#ifdef WIN32
#include <process.h>
#define getpid _getpid
#endif

#define	SMALLEST_LINE	32		/* smallest cache line size */
#define	TIME_OPEN2CLOSE

#define	GO_AWAY	signal(SIGALRM, exit); alarm(60 * 60);
#define	REAL_SHORT	   50000
#define	SHORT	 	 1000000
#define	MEDIUM	 	 2000000
#define	LONGER		 7500000	/* for networking data transfers */
#define	ENOUGH		REAL_SHORT

#define	TRIES		11

typedef struct {
	int	N;
	u64	u[TRIES];
	u64	n[TRIES];
} result_t;
void    insertinit(result_t *r);
void    insertsort(u64, u64, result_t *);
void	save_median();
void	save_minimum();
void	save_results(result_t *r);
void	get_results(result_t *r);


#define	BENCHO(loop_body, overhead_body, enough) { 			\
	int 		__i, __N;					\
	double 		__oh;						\
	result_t 	__overhead, __r;				\
	insertinit(&__overhead); insertinit(&__r);			\
	__N = (enough == 0 || get_enough(enough) <= 100000) ? TRIES : 1;\
	if (enough < LONGER) {loop_body;} /* warm the cache */		\
	for (__i = 0; __i < __N; ++__i) {				\
		BENCH1(overhead_body, enough);				\
		if (gettime() > 0) 					\
			insertsort(gettime(), get_n(), &__overhead);	\
		BENCH1(loop_body, enough);				\
		if (gettime() > 0) 					\
			insertsort(gettime(), get_n(), &__r);		\
	}								\
	for (__i = 0; __i < __r.N; ++__i) {				\
		__oh = __overhead.u[__i] / (double)__overhead.n[__i];	\
		__r.u[__i] -= (u64)((double)__r.n[__i] * __oh);	\
	}								\
	save_results(&__r);						\
}

#define	BENCH(loop_body, enough) { 					\
	long		__i, __N;					\
	result_t 	__r;						\
	insertinit(&__r);						\
	__N = (enough == 0 || get_enough(enough) <= 100000) ? TRIES : 1;\
	if (enough < LONGER) {loop_body;} /* warm the cache */		\
	for (__i = 0; __i < __N; ++__i) {				\
		BENCH1(loop_body, enough);				\
		if (gettime() > 0) 					\
			insertsort(gettime(), get_n(), &__r);		\
	}								\
	save_results(&__r);						\
}

#define	BENCH1(loop_body, enough) { 					\
	double		__usecs;					\
	BENCH_INNER(loop_body, enough);  				\
	__usecs = gettime();						\
	__usecs -= t_overhead() + get_n() * l_overhead();		\
	settime(__usecs >= 0. ? (u64)__usecs : 0.);			\
}
	
#define	BENCH_INNER(loop_body, enough) { 				\
	static u_long	__iterations = 1;				\
	int		__enough = get_enough(enough);			\
	u_long		__n;						\
	double		__result = 0.;					\
									\
	while(__result < 0.95 * __enough) {				\
		start(0);						\
		for (__n = __iterations; __n > 0; __n--) {		\
			loop_body;					\
		}							\
		__result = stop(0,0);					\
		if (__result < 0.99 * __enough 				\
		    || __result > 1.2 * __enough) {			\
			if (__result > 150.) {				\
				double	tmp = __iterations / __result;	\
				tmp *= 1.1 * __enough;			\
				__iterations = (u_long)(tmp + 1);	\
			} else {					\
				if (__iterations > (u_long)1<<27) {	\
					__result = 0.;			\
					break;				\
				}					\
				__iterations <<= 3;			\
			}						\
		}							\
	} /* while */							\
	save_n((u64)__iterations); settime((u64)__result);	\
}


/*
 * Generated from msg.x which is included here:

	program XACT_PROG {
	    version XACT_VERS {
		char
		RPC_XACT(char) = 1;
    	} = 1;
	} = 3970;

 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include <rpc/types.h>

#define XACT_PROG ((u_long)404040)
#define XACT_VERS ((u_long)1)
#define RPC_XACT ((u_long)1)
#define RPC_EXIT ((u_long)2)
extern char *rpc_xact_1();
extern char *client_rpc_xact_1();

#endif /* _BENCH_H */
#ifndef _STATS_H
#define _STATS_H

#include "bench.h"
#include "timing.h"

#define ABS(x)	((x) < 0 ? -(x) : (x))

int	int_compare(const void *a, const void *b);
int	u64_compare(const void *a, const void *b);
int	double_compare(const void *a, const void *b);

typedef	int (*int_stat)(int *values, int size);
typedef	u64 (*u64_stat)(u64 *values, int size);
typedef	double (*double_stat)(double *values, int size);

int	int_median(int *values, int size);
u64	u64_median(u64 *values, int size);
double	double_median(double *values, int size);

int	int_mean(int *values, int size);
u64	u64_mean(u64 *values, int size);
double	double_mean(double *values, int size);

int	int_min(int *values, int size);
u64	u64_min(u64 *values, int size);
double	double_min(double *values, int size);

int	int_max(int *values, int size);
u64	u64_max(u64 *values, int size);
double	double_max(double *values, int size);

double	int_stderr(int *values, int size);
double	u64_stderr(u64 *values, int size);
double	double_stderr(double *values, int size);

double	int_bootstrap_stderr(int *values, int size, int_stat f);
double	u64_bootstrap_stderr(u64 *values, int size, u64_stat f);
double	double_bootstrap_stderr(double *values, int size, double_stat f);

void	regression(double *x, double *y, double *sig, int n,
		   double *a, double *b, double *sig_a, double *sig_b, 
		   double *chi2);

#endif /* _STATS_H */
/*
 * $Id$
 */
#ifndef _TIMING_H
#define _TIMING_H

char	*p64(u64 big);
char	*p64sz(u64 big);
double	Delta(void);
double	Now(void);
void	adjust(int usec);
void	bandwidth(u64 bytes, u64 times, int verbose);
int	bytes(char *s);
void	context(u64 xfers);
u64	delta(void);
int	get_enough(int);
u64	get_n(void);
void	kb(u64 bytes);
double	l_overhead(void);
char	last(char *s);
void	latency(u64 xfers, u64 size);
void	mb(u64 bytes);
void	micro(char *s, u64 n);
void	micromb(u64 mb, u64 n);
void	milli(char *s, u64 n);
void	morefds(void);
void	nano(char *s, u64 n);
u64	now(void);
void	ptime(u64 n);
void	rusage(void);
void	save_n(u64);
void	settime(u64 usecs);
void	start(struct timeval *tv);
u64	stop(struct timeval *begin, struct timeval *end);
u64	t_overhead(void);
double	timespent(void);
void	timing(FILE *out);
u64	tvdelta(struct timeval *, struct timeval *);
void	tvsub(struct timeval *tdiff, struct timeval *t1, struct timeval *t0);
void	use_int(int result);
void	use_pointer(void *result);
u64	usecs_spent(void);
void	touch(char *buf, int size);

#if defined(hpux) || defined(__hpux)
int	getpagesize();
#endif

#endif /* _TIMING_H */
/*
 * a timing utilities library
 *
 * Requires 64bit integers to work.
 *
 * %W% %@%
 *
 * Copyright (c) 1994-1998 Larry McVoy.
 */
#define	 _LIB /* bench.h needs this */
#include "bench.h"

#define	nz(x)	((x) == 0 ? 1 : (x))

/*
 * I know you think these should be 2^10 and 2^20, but people are quoting
 * disk sizes in powers of 10, and bandwidths are all power of ten.
 * Deal with it.
 */
#define	MB	(1000*1000.0)
#define	KB	(1000.0)

static struct timeval start_tv, stop_tv;
FILE		*ftiming;
volatile u64	use_result_dummy;	/* !static for optimizers. */
static	u64	iterations;
static	void	init_timing(void);

#if defined(hpux) || defined(__hpux)
#include <sys/mman.h>
#endif

#ifdef	RUSAGE
#include <sys/resource.h>
#define	SECS(tv)	(tv.tv_sec + tv.tv_usec / 1000000.0)
#define	mine(f)		(int)(ru_stop.f - ru_start.f)

static struct rusage ru_start, ru_stop;

void
rusage(void)
{
	double  sys, user, idle;
	double  per;

	sys = SECS(ru_stop.ru_stime) - SECS(ru_start.ru_stime);
	user = SECS(ru_stop.ru_utime) - SECS(ru_start.ru_utime);
	idle = timespent() - (sys + user);
	per = idle / timespent() * 100;
	if (!ftiming) ftiming = stderr;
	fprintf(ftiming, "real=%.2f sys=%.2f user=%.2f idle=%.2f stall=%.0f%% ",
	    timespent(), sys, user, idle, per);
	fprintf(ftiming, "rd=%d wr=%d min=%d maj=%d ctx=%d\n",
	    mine(ru_inblock), mine(ru_oublock),
	    mine(ru_minflt), mine(ru_majflt),
	    mine(ru_nvcsw) + mine(ru_nivcsw));
}

#endif	/* RUSAGE */
/*
 * Redirect output someplace else.
 */
void
timing(FILE *out)
{
	ftiming = out;
}

/*
 * Start timing now.
 */
void
start(struct timeval *tv)
{
	if (tv == NULL) {
		tv = &start_tv;
	}
#ifdef	RUSAGE
	getrusage(RUSAGE_SELF, &ru_start);
#endif
	(void) gettimeofday(tv, (struct timezone *) 0);
}

/*
 * Stop timing and return real time in microseconds.
 */
u64
stop(struct timeval *begin, struct timeval *end)
{
	if (end == NULL) {
		end = &stop_tv;
	}
	(void) gettimeofday(end, (struct timezone *) 0);
#ifdef	RUSAGE
	getrusage(RUSAGE_SELF, &ru_stop);
#endif

	if (begin == NULL) {
		begin = &start_tv;
	}
	return tvdelta(begin, end);
}

u64
now(void)
{
	struct timeval t;
	u64	m;

	(void) gettimeofday(&t, (struct timezone *) 0);
	m = t.tv_sec;
	m *= 1000000;
	m += t.tv_usec;
	return (m);
}

double
Now(void)
{
	struct timeval t;

	(void) gettimeofday(&t, (struct timezone *) 0);
	return (t.tv_sec * 1000000.0 + t.tv_usec);
}

u64
delta(void)
{
	static struct timeval last;
	struct timeval t;
	struct timeval diff;
	u64	m;

	(void) gettimeofday(&t, (struct timezone *) 0);
	if (last.tv_usec) {
		tvsub(&diff, &t, &last);
		last = t;
		m = diff.tv_sec;
		m *= 1000000;
		m += diff.tv_usec;
		return (m);
	} else {
		last = t;
		return (0);
	}
}

double
Delta(void)
{
	struct timeval t;
	struct timeval diff;

	(void) gettimeofday(&t, (struct timezone *) 0);
	tvsub(&diff, &t, &start_tv);
	return (diff.tv_sec + diff.tv_usec / 1000000.0);
}

void
save_n(u64 n)
{
	iterations = n;
}

u64
get_n(void)
{
	return (iterations);
}

/*
 * Make the time spend be usecs.
 */
void
settime(u64 usecs)
{
	bzero((void*)&start_tv, sizeof(start_tv));
	stop_tv.tv_sec = usecs / 1000000;
	stop_tv.tv_usec = usecs % 1000000;
}

void
bandwidth(u64 bytes, u64 times, int verbose)
{
	struct timeval tdiff;
	double  mb, secs;

	tvsub(&tdiff, &stop_tv, &start_tv);
	secs = tdiff.tv_sec;
	secs *= 1000000;
	secs += tdiff.tv_usec;
	secs /= 1000000;
	secs /= times;
	mb = bytes / MB;
	if (!ftiming) ftiming = stderr;
	if (verbose) {
		(void) fprintf(ftiming,
		    "%.4f MB in %.4f secs, %.4f MB/sec\n",
		    mb, secs, mb/secs);
	} else {
		if (mb < 1) {
			(void) fprintf(ftiming, "%.6f ", mb);
		} else {
			(void) fprintf(ftiming, "%.2f ", mb);
		}
		if (mb / secs < 1) {
			(void) fprintf(ftiming, "%.6f\n", mb/secs);
		} else {
			(void) fprintf(ftiming, "%.2f\n", mb/secs);
		}
	}
}

void
kb(u64 bytes)
{
	struct timeval td;
	double  s, bs;

	tvsub(&td, &stop_tv, &start_tv);
	s = td.tv_sec + td.tv_usec / 1000000.0;
	bs = bytes / nz(s);
	if (!ftiming) ftiming = stderr;
	(void) fprintf(ftiming, "%.0f KB/sec\n", bs / KB);
}

void
mb(u64 bytes)
{
	struct timeval td;
	double  s, bs;

	tvsub(&td, &stop_tv, &start_tv);
	s = td.tv_sec + td.tv_usec / 1000000.0;
	bs = bytes / nz(s);
	if (!ftiming) ftiming = stderr;
	(void) fprintf(ftiming, "%.2f MB/sec\n", bs / MB);
}

void
latency(u64 xfers, u64 size)
{
	struct timeval td;
	double  s;

	if (!ftiming) ftiming = stderr;
	tvsub(&td, &stop_tv, &start_tv);
	s = td.tv_sec + td.tv_usec / 1000000.0;
	if (xfers > 1) {
		fprintf(ftiming, "%d %dKB xfers in %.2f secs, ",
		    (int) xfers, (int) (size / KB), s);
	} else {
		fprintf(ftiming, "%.1fKB in ", size / KB);
	}
	if ((s * 1000 / xfers) > 100) {
		fprintf(ftiming, "%.0f millisec%s, ",
		    s * 1000 / xfers, xfers > 1 ? "/xfer" : "s");
	} else {
		fprintf(ftiming, "%.4f millisec%s, ",
		    s * 1000 / xfers, xfers > 1 ? "/xfer" : "s");
	}
	if (((xfers * size) / (MB * s)) > 1) {
		fprintf(ftiming, "%.2f MB/sec\n", (xfers * size) / (MB * s));
	} else {
		fprintf(ftiming, "%.2f KB/sec\n", (xfers * size) / (KB * s));
	}
}

void
context(u64 xfers)
{
	struct timeval td;
	double  s;

	tvsub(&td, &stop_tv, &start_tv);
	s = td.tv_sec + td.tv_usec / 1000000.0;
	if (!ftiming) ftiming = stderr;
	fprintf(ftiming,
	    "%d context switches in %.2f secs, %.0f microsec/switch\n",
	    (int)xfers, s, s * 1000000 / xfers);
}

void
nano(char *s, u64 n)
{
	struct timeval td;
	double  micro;

	tvsub(&td, &stop_tv, &start_tv);
	micro = td.tv_sec * 1000000 + td.tv_usec;
	micro *= 1000;
	if (!ftiming) ftiming = stderr;
	fprintf(ftiming, "%s: %.0f nanoseconds\n", s, micro / n);
}

void
micro(char *s, u64 n)
{
	struct timeval td;
	double	micro;

	tvsub(&td, &stop_tv, &start_tv);
	micro = td.tv_sec * 1000000 + td.tv_usec;
	micro /= n;
	if (!ftiming) ftiming = stderr;
	fprintf(ftiming, "%s: %.4f microseconds\n", s, micro);
#if 0
	if (micro >= 100) {
		fprintf(ftiming, "%s: %.1f microseconds\n", s, micro);
	} else if (micro >= 10) {
		fprintf(ftiming, "%s: %.3f microseconds\n", s, micro);
	} else {
		fprintf(ftiming, "%s: %.4f microseconds\n", s, micro);
	}
#endif
}

void
micromb(u64 sz, u64 n)
{
	struct timeval td;
	double	mb, micro;

	tvsub(&td, &stop_tv, &start_tv);
	micro = td.tv_sec * 1000000 + td.tv_usec;
	micro /= n;
	mb = sz;
	mb /= MB;
	if (!ftiming) ftiming = stderr;
	if (micro >= 10) {
		fprintf(ftiming, "%.6f %.0f\n", mb, micro);
	} else {
		fprintf(ftiming, "%.6f %.3f\n", mb, micro);
	}
}

void
milli(char *s, u64 n)
{
	struct timeval td;
	u64 milli;

	tvsub(&td, &stop_tv, &start_tv);
	milli = td.tv_sec * 1000 + td.tv_usec / 1000;
	milli /= n;
	if (!ftiming) ftiming = stderr;
	fprintf(ftiming, "%s: %d milliseconds\n", s, (int)milli);
}

void
ptime(u64 n)
{
	struct timeval td;
	double  s;

	tvsub(&td, &stop_tv, &start_tv);
	s = td.tv_sec + td.tv_usec / 1000000.0;
	if (!ftiming) ftiming = stderr;
	fprintf(ftiming,
	    "%d in %.2f secs, %.0f microseconds each\n",
	    (int)n, s, s * 1000000 / n);
}

u64
tvdelta(struct timeval *start, struct timeval *stop)
{
	struct timeval td;
	u64	usecs;

	tvsub(&td, stop, start);
	usecs = td.tv_sec;
	usecs *= 1000000;
	usecs += td.tv_usec;
	return (usecs);
}

void
tvsub(struct timeval * tdiff, struct timeval * t1, struct timeval * t0)
{
	tdiff->tv_sec = t1->tv_sec - t0->tv_sec;
	tdiff->tv_usec = t1->tv_usec - t0->tv_usec;
	if (tdiff->tv_usec < 0 && tdiff->tv_sec > 0) {
		tdiff->tv_sec--;
		tdiff->tv_usec += 1000000;
		assert(tdiff->tv_usec >= 0);
	}

	/* time shouldn't go backwards!!! */
	if (tdiff->tv_usec < 0 || t1->tv_sec < t0->tv_sec) {
		tdiff->tv_sec = 0;
		tdiff->tv_usec = 0;
	}
}

u64
gettime(void)
{
	return (tvdelta(&start_tv, &stop_tv));
}

double
timespent(void)
{
	struct timeval td;

	tvsub(&td, &stop_tv, &start_tv);
	return (td.tv_sec + td.tv_usec / 1000000.0);
}

static	char	p64buf[10][20];
static	int	n;

char	*
p64(u64 big)
{
	char	*s = p64buf[n++];

	if (n == 10) n = 0;
#ifdef  linux
	{
        int     *a = (int*)&big;

        if (a[1]) {
                sprintf(s, "0x%x%08x", a[1], a[0]);
        } else {
                sprintf(s, "0x%x", a[0]);
        }
	}
#endif
#ifdef	__sgi
        sprintf(s, "0x%llx", big);
#endif
	return (s);
}

char	*
p64sz(u64 big)
{
	double	d = big;
	char	*tags = " KMGTPE";
	int	t = 0;
	char	*s = p64buf[n++];

	if (n == 10) n = 0;
	while (d > 512) t++, d /= 1024;
	if (d == 0) {
		return ("0");
	}
	if (d < 100) {
		sprintf(s, "%.4f%c", d, tags[t]);
	} else {
		sprintf(s, "%.2f%c", d, tags[t]);
	}
	return (s);
}

char
last(char *s)
{
	while (*s++)
		;
	return (s[-2]);
}

int
bytes(char *s)
{
	int	n = atoi(s);

	if ((last(s) == 'k') || (last(s) == 'K'))
		n *= 1024;
	if ((last(s) == 'm') || (last(s) == 'M'))
		n *= (1024 * 1024);
	return (n);
}

void
use_int(int result) { use_result_dummy += result; }

void
use_pointer(void *result) { use_result_dummy += (int)result; }

void
insertinit(result_t *r)
{
	int	i;

	r->N = 0;
	for (i = 0; i < TRIES; i++) {
		r->u[i] = 0;
		r->n[i] = 1;
	}
}

/* biggest to smallest */
void
insertsort(u64 u, u64 n, result_t *r)
{
	int	i, j;

	if (u == 0) return;

	for (i = 0; i < r->N; ++i) {
		if (u/(double)n > r->u[i]/(double)r->n[i]) {
			for (j = r->N; j > i; --j) {
				r->u[j] = r->u[j-1];
				r->n[j] = r->n[j-1];
			}
			break;
		}
	}
	r->u[i] = u;
	r->n[i] = n;
	r->N++;
}

static result_t results;

void
print_results(void)
{
	int	i;

	for (i = 0; i < results.N; ++i) {
		fprintf(stderr, "%.2f ", (double)results.u[i]/results.n[i]);
	}
}

void
get_results(result_t *r)
{
	*r = results;
}

void
save_results(result_t *r)
{
	results = *r;
	save_median();
}

void
save_minimum()
{
	if (results.N == 0) {
		save_n(1);
		settime(0);
	} else {
		save_n(results.n[results.N - 1]);
		settime(results.u[results.N - 1]);
	}
}

void
save_median()
{
	int	i = results.N / 2;
	u64	u, n;

	if (results.N == 0) {
		n = 1;
		u = 0;
	} else if (results.N % 2) {
		n = results.n[i];
		u = results.u[i];
	} else {
		n = (results.n[i] + results.n[i-1]) / 2;
		u = (results.u[i] + results.u[i-1]) / 2;
	}
	save_n(n); settime(u);
}

/*
 * The inner loop tracks bench.h but uses a different results array.
 */
static long *
one_op(register long *p)
{
	BENCH_INNER(p = (long *)*p, 0);
	return (p);
}

static long *
two_op(register long *p, register long *q)
{
	BENCH_INNER(p = (long *)*q; q = (long*)*p, 0);
	return (p);
}

static long	*p = (long *)&p;
static long	*q = (long *)&q;

double
l_overhead(void)
{
	int	i;
	u64	N_save, u_save;
	static	double overhead;
	static	int initialized = 0;
	result_t one, two, r_save;

	init_timing();
	if (initialized) return (overhead);

	initialized = 1;
	if (getenv("LOOP_O")) {
		overhead = atof(getenv("LOOP_O"));
	} else {
		get_results(&r_save); N_save = get_n(); u_save = gettime(); 
		insertinit(&one);
		insertinit(&two);
		for (i = 0; i < TRIES; ++i) {
			use_pointer((void*)one_op(p));
			if (gettime() > t_overhead())
				insertsort(gettime() - t_overhead(), get_n(), &one);
			use_pointer((void *)two_op(p, q));
			if (gettime() > t_overhead())
				insertsort(gettime() - t_overhead(), get_n(), &two);
		}
		/*
		 * u1 = (n1 * (overhead + work))
		 * u2 = (n2 * (overhead + 2 * work))
		 * ==> overhead = 2. * u1 / n1 - u2 / n2
		 */
		save_results(&one); save_minimum();
		overhead = 2. * gettime() / (double)get_n();
		
		save_results(&two); save_minimum();
		overhead -= gettime() / (double)get_n();
		
		if (overhead < 0.) overhead = 0.;	/* Gag */

		save_results(&r_save); save_n(N_save); settime(u_save); 
	}
	return (overhead);
}

/*
 * Figure out the timing overhead.  This has to track bench.h
 */
u64
t_overhead(void)
{
	u64		N_save, u_save;
	static int	initialized = 0;
	static u64	overhead = 0;
	struct timeval	tv;
	result_t	r_save;

	init_timing();
	if (initialized) return (overhead);

	initialized = 1;
	if (getenv("TIMING_O")) {
		overhead = atof(getenv("TIMING_O"));
	} else if (get_enough(0) <= 50000) {
		/* it is not in the noise, so compute it */
		int		i;
		result_t	r;

		get_results(&r_save); N_save = get_n(); u_save = gettime(); 
		insertinit(&r);
		for (i = 0; i < TRIES; ++i) {
			BENCH_INNER(gettimeofday(&tv, 0), 0);
			insertsort(gettime(), get_n(), &r);
		}
		save_results(&r);
		save_minimum();
		overhead = gettime() / get_n();

		save_results(&r_save); save_n(N_save); settime(u_save); 
	}
	return (overhead);
}

/*
 * Figure out how long to run it.
 * If enough == 0, then they want us to figure it out.
 * If enough is !0 then return it unless we think it is too short.
 */
static	int	long_enough;
static	int	compute_enough();

int
get_enough(int e)
{
	init_timing();
	return (long_enough > e ? long_enough : e);
}


static void
init_timing(void)
{
	static	int done = 0;

	if (done) return;
	done = 1;
	long_enough = compute_enough();
	t_overhead();
	l_overhead();
}

typedef long TYPE;

static TYPE **
enough_duration(register long N, register TYPE ** p)
{
#define	ENOUGH_DURATION_TEN(one)	one one one one one one one one one one
	while (N-- > 0) {
		ENOUGH_DURATION_TEN(p = (TYPE **) *p;);
	}
	return (p);
}

static u64
duration(long N)
{
	u64	usecs;
	TYPE   *x = (TYPE *)&x;
	TYPE  **p = (TYPE **)&x;

	start(0);
	p = enough_duration(N, p);
	usecs = stop(0, 0);
	use_pointer((void *)p);
	return (usecs);
}

/*
 * find the minimum time that work "N" takes in "tries" tests
 */
static u64
time_N(long N)
{
	int     i;
	u64	usecs;
	result_t r;

	insertinit(&r);
	for (i = 1; i < TRIES; ++i) {
		usecs = duration(N);
		insertsort(usecs, N, &r);
	}
	save_results(&r);
	save_minimum();
	return (gettime());
}

/*
 * return the amount of work needed to run "enough" microseconds
 */
static long
find_N(int enough)
{
	int		tries;
	static long	N = 10000;
	static u64	usecs = 0;

	if (!usecs) usecs = time_N(N);

	for (tries = 0; tries < 10; ++tries) {
		if (0.98 * enough < usecs && usecs < 1.02 * enough)
			return (N);
		if (usecs < 1000)
			N *= 10;
		else {
			double  n = N;

			n /= usecs;
			n *= enough;
			N = n + 1;
		}
		usecs = time_N(N);
	}
	return (-1);
}

/*
 * We want to verify that small modifications proportionally affect the runtime
 */
static double test_points[] = {1.015, 1.02, 1.035};
static int
test_time(int enough)
{
	int     i;
	long	N;
	u64	usecs, expected, baseline, diff;

	if ((N = find_N(enough)) <= 0)
		return (0);

	baseline = time_N(N);

	for (i = 0; i < sizeof(test_points) / sizeof(double); ++i) {
		usecs = time_N((int)((double) N * test_points[i]));
		expected = (u64)((double)baseline * test_points[i]);
		diff = expected > usecs ? expected - usecs : usecs - expected;
		if (diff / (double)expected > 0.0025)
			return (0);
	}
	return (1);
}


/*
 * We want to find the smallest timing interval that has accurate timing
 */
static int     possibilities[] = { 5000, 10000, 50000, 100000 };
static int
compute_enough()
{
	int     i;

	if (getenv("ENOUGH")) {
		return (atoi(getenv("ENOUGH")));
	}
	for (i = 0; i < sizeof(possibilities) / sizeof(int); ++i) {
		if (test_time(possibilities[i]))
			return (possibilities[i]);
	}

	/* 
	 * if we can't find a timing interval that is sufficient, 
	 * then use SHORT as a default.
	 */
	return (SHORT);
}

/*
 * This stuff isn't really lib_timing, but ...
 */
void
morefds(void)
{
#ifdef	RLIMIT_NOFILE
	struct	rlimit r;

	getrlimit(RLIMIT_NOFILE, &r);
	r.rlim_cur = r.rlim_max;
	setrlimit(RLIMIT_NOFILE, &r);
#endif
}

void
touch(char *buf, int nbytes)
{
	static	psize;

	if (!psize) {
		psize = getpagesize();
	}
	while (nbytes > 0) {
		*buf = 1;
		buf += psize;
		nbytes -= psize;
	}
}

#if defined(hpux) || defined(__hpux)
int
getpagesize()
{
	return (sysconf(_SC_PAGE_SIZE));
}
#endif

#ifdef WIN32
int
getpagesize()
{
	SYSTEM_INFO s;

	GetSystemInfo(&s);
	return ((int)s.dwPageSize);
}

LARGE_INTEGER
getFILETIMEoffset()
{
	SYSTEMTIME s;
	FILETIME f;
	LARGE_INTEGER t;

	s.wYear = 1970;
	s.wMonth = 1;
	s.wDay = 1;
	s.wHour = 0;
	s.wMinute = 0;
	s.wSecond = 0;
	s.wMilliseconds = 0;
	SystemTimeToFileTime(&s, &f);
	t.QuadPart = f.dwHighDateTime;
	t.QuadPart <<= 32;
	t.QuadPart |= f.dwLowDateTime;
	return (t);
}

int
gettimeofday(struct timeval *tv, struct timezone *tz)
{
	LARGE_INTEGER			t;
	FILETIME			f;
	double					microseconds;
	static LARGE_INTEGER	offset;
	static double			frequencyToMicroseconds;
	static int				initialized = 0;
	static BOOL				usePerformanceCounter = 0;

	if (!initialized) {
		LARGE_INTEGER performanceFrequency;
		initialized = 1;
		usePerformanceCounter = QueryPerformanceFrequency(&performanceFrequency);
		if (usePerformanceCounter) {
			QueryPerformanceCounter(&offset);
			frequencyToMicroseconds = (double)performanceFrequency.QuadPart / 1000000.;
		} else {
			offset = getFILETIMEoffset();
			frequencyToMicroseconds = 10.;
		}
	}
	if (usePerformanceCounter) QueryPerformanceCounter(&t);
	else {
		GetSystemTimeAsFileTime(&f);
		t.QuadPart = f.dwHighDateTime;
		t.QuadPart <<= 32;
		t.QuadPart |= f.dwLowDateTime;
	}

	t.QuadPart -= offset.QuadPart;
	microseconds = (double)t.QuadPart / frequencyToMicroseconds;
	t.QuadPart = microseconds;
	tv->tv_sec = t.QuadPart / 1000000;
	tv->tv_usec = t.QuadPart % 1000000;
	return (0);
}
#endif
char	*id = "$Id: lmdd.c,v 1.23 1997/12/01 23:47:59 lm Exp $\n";
/*
 * defaults:
 *	bs=8k
 *	count=forever
 *	if=internal
 *	of=internal
 *	ipat=0
 *	opat=0
 *	mismatch=0
 *	rusage=0
 *	flush=0
 *	rand=0
 *	print=0
 *	direct=0
 *	rt=0
 *	rtmax=0
 *	wtmax=0
 *	rtmin=0
 *	wtmin=0
 *	label=""
 * shorthands:
 *	k, m, g are 2^10, 2^20, 2^30 multipliers.
 *	K, M, G are 10^3, 10^6, 10^9 multipliers.
 *	recognizes "internal" as an internal /dev/zero /dev/null file.
 *
 * Copyright (c) 1994-1998 by Larry McVoy.  All rights reserved.
 * See the file COPYING for the licensing terms.
 *
 * TODO - rewrite this entire thing from scratch.  This is disgusting code.
 */

#ifndef __Lynx__
#define	FLUSH
#endif

#include	<fcntl.h>
#include	<stdio.h>
#include	<stdlib.h>
#include	<signal.h>
#include	<string.h>
#include	<malloc.h>
#include	<unistd.h>
#include	<sys/types.h>
#include	<sys/wait.h>
#ifdef	USE_BDS
#include	"bds.h"
#endif
#include	<sys/time.h>
#include	"bench.h"

#define ALIGN(x, bs)    ((x + (bs - 1)) & ~(bs - 1))

#ifdef	FLUSH
#include	<sys/mman.h>
#include	<sys/stat.h>
void		flush(void);
#endif

#define	USE_VALLOC
#ifdef	USE_VALLOC
#define	VALLOC	valloc
#else
#define	VALLOC	malloc
#endif

extern	double	drand48();

#ifdef	__sgi
#	define	LSEEK(a,b,c)	(u64)lseek64(a, (off64_t)b, c)
#	define	ATOL(s)		atoll(s)
#else
#	define	LSEEK(a,b,c)	(u64)lseek(a, b, c)
#	define	ATOL(s)		atol(s)
#endif


int     awrite, poff, out, Print, Fsync, Sync, Flush, Bsize, ru;
u64	Start, End, Rand, int_count;
int	hash;
int	Realtime, Notrunc;
int	Rt, Rtmax, Rtmin, Wt, Wtmax, Wtmin;
int	rthist[12];		/* histogram of read times */
int	wthist[12];		/* histogram of write times */
char	*Label;
u64	*norepeat;
int	norepeats = -1;
#ifdef	USE_BDS
	bds_msg	*m1, *m2;
#endif

u64	getarg();
int	been_there(u64 off);
int	getfile(char *s, int ac, char **av);

char   *cmds[] = {
	"bs",			/* block size */
	"bufs",			/* use this many buffers round robin */
	"count",		/* number of blocks */
#ifdef	DBG
	"debug",		/* set external variable "dbg" */
#endif
#ifdef	O_DIRECT
	"direct",		/* direct I/O on input and output */
	"idirect",		/* direct I/O on input */
	"odirect",		/* direct I/O on output */
#endif
#ifdef	FLUSH
	"flush",		/* map in out and invalidate (flush) */
#endif
	"fork",			/* fork to do write I/O */
	"fsync",		/* fsync output before exit */
	"if",			/* input file */
	"ipat",			/* check input for pattern */
	"label",		/* prefix print out with this */
	"mismatch",		/* stop at first mismatch */
	"move",			/* instead of count, limit transfer to this */
	"of",			/* output file */
	"opat",			/* generate pattern on output */
	"print",		/* report type */
	"rand",			/* do randoms over the specified size */
				/* must be power of two, not checked */
	"poff",			/* Print the offsets as we do the io. */
#ifdef	RUSAGE
	"rusage",		/* dump rusage stats */
#endif
	"skip",			/* skip this number of blocks */
	"sync",			/* sync output before exit */
	"touch",		/* touch each buffer after the I/O */
#if	!defined(hpux)
	"usleep",		/* sleep this many usecs between I/O */
#endif
	"hash",			/* hash marks like FTP */
	"append",		/* O_APPEND */
	"rt",			/* time reads */
	"wt",			/* time writes */
	"rtmax",		/* read latency histogram max in mills */
	"wtmax",		/* write latency histogram max in mills */
	"rtmin",		/* read latency histogram max in mills */
	"wtmin",		/* write latency histogram max in mills */
	"realtime",		/* create files as XFS realtime files */
	"notrunc",		/* overwrite rather than truncing out file */
	"end",			/* limit randoms to this size near the
				 * Rand endpoints. */
	"start",		/* Add this to Rand */
	"time",			/* Run for this many seconds only. */
	"srand",		/* Seed the random number generator */
	"padin",		/* Pad an extra untimed block_size read */
#ifdef	USE_BDS
	"awrite",		/* use async writes and pipeline them. */
#endif
	"norepeat",		/* don't ever do the same I/O twice */
#ifdef	sgi
	"mpin",			/* pin the buffer */
#endif
	"timeopen",		/* include open time in results */
	"nocreate",		/* just open for writing, don't create/trunc it */
#ifdef	O_SYNC
	"osync",		/* O_SYNC */
#endif
	0,
};


void error(char *);
void    done();
#ifdef	DBG
extern int dbg;
#endif

int 
main(int ac, char **av)
{
	u32  *buf;
	u32  *bufs[10];
	int	nbufs, nextbuf = 0;
	int     Fork, misses, mismatch, outpat, inpat, in, timeopen, gotcnt;
	int	slp;
	u64	skip, size, count;
	void	chkarg();
	int     i;
	u64	off = 0;
	int	touch;
	int	time;
	int	mills;
	int	pad_in;
	int	pid = 0;
	struct timeval	start_tv;
	struct timeval	stop_tv;

	if (sizeof(int) != 4) {
		fprintf(stderr, "sizeof(int) != 4\n");
		exit(1);
	}
	for (i = 1; i < ac; ++i) {
		chkarg(av[i]);
	}
	signal(SIGINT, done);
	signal(SIGALRM, done);
	misses = mismatch = getarg("mismatch=", ac, av);
	inpat = getarg("ipat=", ac, av);
	outpat = getarg("opat=", ac, av);
	Bsize = getarg("bs=", ac, av);
	if (Bsize < 0)
		Bsize = 8192;
#if	!defined(hpux)
	slp = getarg("usleep=", ac, av);
#endif
	Fork = getarg("fork=", ac, av);
	Fsync = getarg("fsync=", ac, av);
	Sync = getarg("sync=", ac, av);
	Rand = getarg("rand=", ac, av);
	Start = getarg("start=", ac, av);
	End = getarg("end=", ac, av);
	time = getarg("time=", ac, av);
	if ((End != -1) && (Rand != -1) && (End > Rand)) {
		End = Rand;
	}
	if (getarg("srand=", ac, av) != -1) {
		srand48((long)getarg("srand=", ac, av));
	}
	poff = getarg("poff=", ac, av) != -1;
	Print = getarg("print=", ac, av);
	nbufs = getarg("bufs=", ac, av);
	Realtime = getarg("realtime=", ac, av);
	Rtmax = getarg("rtmax=", ac, av);
	if ((Rtmax != -1) && (Rtmax < 10))
		Rtmax = 10;
	Rtmin = getarg("rtmin=", ac, av);
	if ((Rtmax != -1) && (Rtmin == -1)) {
		Rtmin = 0;
	}
	Rt = getarg("rt=", ac, av);
	Wtmax = getarg("wtmax=", ac, av);
	if ((Wtmax != -1) && (Wtmax < 10))
		Wtmax = 10;
	Wtmin = getarg("wtmin=", ac, av);
	if ((Wtmax != -1) && (Wtmin == -1)) {
		Wtmin = 0;
	}
	Wt = getarg("wt=", ac, av);
	if ((Rtmin && !Rtmax) || (Wtmin && !Wtmax)) {
		fprintf(stderr, "Need a max to go with that min.\n");
		exit(1);
	}
	if ((Rtmin > Rtmax) || (Wtmin > Wtmax)) {
		fprintf(stderr,
		    "min has to be less than max, R=%d,%d W=%d,%d\n",
		    Rtmax, Rtmin, Wtmax, Wtmin);
		exit(1);
	}
	timeopen = getarg("timeopen=", ac, av);
	pad_in = getarg("padin=", ac, av);
	if (pad_in == -1) pad_in = 0;
	
	if (nbufs == -1) nbufs = 1;
	if (nbufs > 10) { printf("Too many bufs\n"); exit(1); }
#ifdef	DBG
	dbg = getarg("debug=", ac, av) != -1;
#endif
#ifdef	RUSAGE
	ru = getarg("rusage=", ac, av);
#endif
	touch = getarg("touch=", ac, av) != -1;
	hash = getarg("hash=", ac, av) != (u64)-1;
	Label = (char *)(u32)getarg("label=", ac, av);
	count = getarg("count=", ac, av);
	size = getarg("move=", ac, av);
	if (size != (u64)-1)
		count = size / Bsize;
	if (Rand != -1) {
		size = Rand - Bsize;
		size = ALIGN(size, Bsize);
	}

#ifdef	FLUSH
	Flush = getarg("flush=", ac, av);
#endif
	if (count == (u64)-1)
		gotcnt = 0;
	else
		gotcnt = 1;
	int_count = 0;
	skip = getarg("skip=", ac, av);
	if (getarg("norepeat=", ac, av) != -1) {
		if (gotcnt) {
			norepeat = (u64*)calloc(count, sizeof(u64));
		} else {
			norepeat = (u64*)calloc(10<<10, sizeof(u64));
		}
	}

	if ((inpat != -1 || outpat != -1) && (Bsize & 3)) {
		fprintf(stderr, "Block size 0x%x must be word aligned\n", Bsize);
		exit(1);
	}
	if ((Bsize >> 2) == 0) {
		fprintf(stderr, "Block size must be at least 4.\n");
		exit(1);
	}
	for (i = 0; i < nbufs; i++) {
		if (!(bufs[i] = (u32 *) VALLOC((unsigned) Bsize))) {
			perror("VALLOC");
			exit(1);
		}
		bzero((char *) bufs[i], Bsize);
#ifdef sgi
		if (getarg("mpin=", ac, av) != -1) {
			if (mpin((void *)bufs[i], (size_t)Bsize)) {
				perror("mpin for adam");
			}
		}
#endif
	}

	if (time != -1) {
		alarm(time);
	}
	if (timeopen != -1) {
		start(NULL);
	}
	in = getfile("if=", ac, av);
	out = getfile("of=", ac, av);
	if (timeopen == -1) {
		start(NULL);
	}
	if ((Rtmax != -1) && in < 0) {
		fprintf(stderr, "I think you wanted wtmax, not rtmax\n");
		exit(1);
	}
	if ((Wtmax != -1) && out < 0) {
		fprintf(stderr, "I think you wanted rtmax, not wtmax\n");
		exit(1);
	}
	if (skip != (u64)-1) {
		off = skip;
		off *= Bsize;
		if (in >= 0) {
			LSEEK(in, off, 0);
		}
		if (out >= 0) {
			LSEEK(out, off, 0);
		}
		if (poff) {
			fprintf(stderr, "%s ", p64sz(off));
		}
	}
	for (;;) {
		register int moved;

		if (gotcnt && count-- <= 0) {
			done();
		}

		/*
		 * If End is set, it means alternate back and forth
		 * between the end points of Rand, doing randoms within
		 * the area 0..End and Rand-End..Rand
		 */
		if (End != -1) {
			static	u64 start = 0;

			start = start ? 0 : Rand - End;
			do {
				off = drand48() * End;
				off = ALIGN(off, Bsize);
				off += start;
				if (Start != -1) {
					off += Start;
				}
			} while (norepeat && been_there(off));
			if (norepeat) {
				norepeat[norepeats++] = off;
				if (!gotcnt && (norepeats == 10<<10)) {
					norepeats = 0;
				}
			}
			if (in >= 0) {
				LSEEK(in, off, 0);
			}
			if (out >= 0) {
				LSEEK(out, off, 0);
			}
		}
		/*
		 * Set the seek pointer if doing randoms
		 */
		else if (Rand != -1) {
			do {
				off = drand48() * (size - Bsize);
				if (Start != -1) {
					off += Start;
				}
				off = ALIGN(off, Bsize);
			} while (norepeat && been_there(off));
			if (norepeat) {
				norepeat[norepeats++] = off;
			}
			if (!gotcnt && (norepeats == 10<<10)) {
				norepeats = 0;
			}
			if (in >= 0) {
				LSEEK(in, off, 0);
			}
			if (out >= 0) {
				LSEEK(out, off, 0);
			}
		}
		if (poff) {
			fprintf(stderr, "%s ", p64sz(off));
		}

		buf = bufs[nextbuf];
		if (++nextbuf == nbufs) nextbuf = 0;
		if (in >= 0) {
			if ((Rt != -1) || (Rtmax != -1) || (Rtmin != -1)) {
				start(&start_tv);
			}
			moved = read(in, buf, Bsize);
			
			if (pad_in) { /* ignore this run, restart clock */
			    pad_in = 0;
			    count++;
			    start(NULL);
			    continue;
			}
			
			if (Rt) {
				int mics = stop(&start_tv, &stop_tv);
				
				mills = mics / 1000;
				fprintf(stderr,
				    "READ: %.02f milliseconds offset %s, ",
				    ((float)mics) / 1000,
				    p64sz(LSEEK(in, 0, SEEK_CUR)));
				fprintf(stderr, "%.02f MB/sec\n",
				    (double)moved/mics);
			} else if ((Rtmax != -1) || (Rtmin != -1)) {
				int mics = stop(&start_tv, &stop_tv);
				
				mills = mics / 1000;
				if ((mills > Rtmax) || (mills < Rtmin)) {
					fprintf(stderr,
					  "READ: %.02f milliseconds offset %s\n",
						((float)mics) / 1000,
						p64sz(LSEEK(in, 0, SEEK_CUR)));
				}
				/*
				 * Put this read time in the histogram.
				 * The buckets are each 1/10th of Rtmax.
				 */
				if (mills >= Rtmax) {
					rthist[11]++;
				} else if (mills < Rtmin) {
					rthist[0]++;
				} else {
					int	step = (Rtmax - Rtmin) / 10;
					int	i;

					for (i = 1; i <= 10; ++i) {
						if (mills < i * step + Rtmin) {
							rthist[i]++;
							break;
						}
					}
				}
			}
		} else {
			moved = Bsize;
		}
		if (moved == -1) {
			perror("read");
		}
		if (moved <= 0) {
			done();
		}
		if (inpat != -1) {
			register int foo, cnt;

			for (foo = 0, cnt = moved/sizeof(int); cnt--; foo++) {
				if (buf[foo] != (u32) (off + foo*sizeof(int))) {
					fprintf(stderr,
					    "off=%u want=%x got=%x\n",
					    (u32)off,
					    (u32)(off + foo*sizeof(int)),
					    buf[foo]);
					if (mismatch != -1 && --misses == 0) {
						done();
					}
				}
			}
		}
		if ((in >= 0) && touch) {
			int	i;

			for (i = 0; i < moved; i += 4096) {
				((char *)buf)[i] = 0;
			}
		}
		if (out >= 0) {
			int	moved2;

			if (Fork != -1) {
				if (pid) {
					waitpid(pid, 0, 0);
				}
				if ((pid = fork())) {
					off += moved;
					int_count += (moved >> 2);
					continue;
				}
			}
			if (outpat != -1) {
				register int foo, cnt;

				for (foo = 0, cnt = moved/sizeof(int);
				    cnt--; foo++) {
					buf[foo] =
					    (u32)(off + foo*sizeof(int));
				}
			}
			if ((Wt != -1) || (Wtmax != -1) || (Wtmin != -1)) { 
				start(&start_tv);
			}
#ifdef	USE_BDS
			/*
			 * The first time through, m1 & m2 are null.
			 * The Nth time through, we start the I/O into
			 * m2, and wait on m1, then switch.
			 */
			if (awrite) {
				if (m1) {
					m2 = bds_awrite(out, buf, moved);
					moved2 = bds_adone(out, m1);
					m1 = m2;
				} else {
					m1 = bds_awrite(out, buf, moved);
					goto writedone;
				}
			} else {
				moved2 = write(out, buf, moved);
			}
#else
			moved2 = write(out, buf, moved);
#endif

			if (moved2 == -1) {
				perror("write");
			}
			if (moved2 != moved) {
				fprintf(stderr, "write: wanted=%d got=%d\n",
				    moved, moved2);
				done();
			}
			if (Wt) {
				int mics = stop(&start_tv, &stop_tv);
				
				mills = mics / 1000;
				fprintf(stderr,
				    "WRITE: %.02f milliseconds offset %s, ",
				    ((float)mics) / 1000,
				    p64sz(LSEEK(out, 0, SEEK_CUR)));
				fprintf(stderr, "%.02f MB/sec\n",
				    (double)moved/mics);
			} else if ((Wtmax != -1) || (Wtmin != -1)) {
				int mics = stop(&start_tv, &stop_tv);

				mills = mics / 1000;
				if ((mills > Wtmax) || (mills < Wtmin)) {
					fprintf(stderr,
					  "WRITE: %.02f milliseconds offset %s\n",
						((float)mics) / 1000,
						p64sz(LSEEK(out, 0, SEEK_CUR)));
				}
				/*
				 * Put this write time in the histogram.
				 * The buckets are each 1/10th of Wtmax.
				 */
				if (mills >= Wtmax) {
					wthist[11]++;
				} else if (mills < Wtmin) {
					wthist[0]++;
				} else {
					int	step = (Wtmax - Wtmin) / 10;
					int	i;

					for (i = 1; i <= 10; ++i) {
						if (mills < i * step + Wtmin) {
							wthist[i]++;
							break;
						}
					}
				}
			}

			if (moved2 == -1) {
				perror("write");
			}
			if (moved2 != moved) {
				done();
			}

			if (touch) {
				int	i;

				for (i = 0; i < moved; i += 4096) {
					((char *)buf)[i] = 0;
				}
			}
		}
#ifdef	USE_BDS
writedone:	/* for the first async write */
#endif
		off += moved;
		int_count += (moved >> 2);
#if	!defined(hpux)
		if (slp != -1) {
			usleep(slp);
		}
#endif
		if (hash) {
			fprintf(stderr, "#");
		}
		if (Fork != -1) {
			exit(0);
		}
	}
}

int
been_there(u64 off)
{
	register int i;

	for (i = 0; i <= norepeats; ++i) {
		if (off == norepeat[i]) {
			fprintf(stderr, "norepeat on %u\n", (u32)off);
			return (1);
		}
	}
	return (0);
}

void 
chkarg(char *arg)
{
	int	i;
	char	*a, *b;

	for (i = 0; cmds[i]; ++i) {
		for (a = arg, b = cmds[i]; *a && *b && *a == *b; a++, b++)
			;
		if (*a == '=')
			return;
	}
	fprintf(stderr, "Bad arg: %s, possible arguments are: ", arg);
	for (i = 0; cmds[i]; ++i) {
		fprintf(stderr, "%s ", cmds[i]);
	}
	fprintf(stderr, "\n");
	exit(1);
	/*NOTREACHED*/
}

void 
done(void)
{
	int	i;
	int	step;
	int	size;

#ifdef	USE_BDS
	if (awrite && m1) {
		bds_adone(out, m1);
	}
#endif
	if (Sync > 0)
		sync();
	if (Fsync > 0)
		fsync(out);
#ifdef	FLUSH
	if (Flush > 0)
		flush();
#endif
	stop(NULL, NULL);
#ifdef	RUSAGE
	if (ru != -1)
		rusage();
#endif
	if (hash || poff) {
		fprintf(stderr, "\n");
	}
	if ((long)Label != -1) {
		fprintf(stderr, "%s", Label);
	}
	int_count <<= 2;
	switch (Print) {
	    case 0:	/* no print out */
	    	break;

	    case 1:	/* latency type print out */
		latency((u64)(int_count / Bsize), (u64)Bsize);
		break;

	    case 2:	/* microsecond per op print out */
		micro("", (u64)(int_count / Bsize));
		break;

	    case 3:	/* kb / sec print out */
		kb(int_count);
		break;

	    case 4:	/* mb / sec print out */
		mb(int_count);
		break;

	    case 5:	/* Xgraph output */
		bandwidth(int_count, 1, 0);
		break;

	    default:	/* bandwidth print out */
		bandwidth(int_count, 1, 1);
		break;
	}
	if (Rtmax != -1) {
		printf("READ operation latencies\n");
		step = (Rtmax - Rtmin) / 10;
		if (rthist[0]) {
			printf("%d- ms: %d\n", Rtmin, rthist[0]);
		}
		for (i = 1, size = Rtmin; i <= 10; i++, size += step) {
			if (!rthist[i])
				continue;
			printf("%d to %d ms: %d\n",
			       size, size + step - 1, rthist[i]);
		}
		if (rthist[11]) {
			printf("%d+ ms: %d\n", Rtmax, rthist[11]);
		}
	}
	if (Wtmax != -1) {
		printf("WRITE operation latencies\n");
		step = (Wtmax - Wtmin) / 10;
		if (wthist[0]) {
			printf("%d- ms: %d\n", Wtmin, wthist[0]);
		}
		for (i = 1, size = Wtmin; i <= 10; i++, size += step) {
			if (!wthist[i])
				continue;
			printf("%d to %d ms: %d\n",
			       size, size + step - 1, wthist[i]);
		}
		if (wthist[11]) {
			printf("%d+ ms: %d\n", Wtmax, wthist[11]);
		}
	}
	exit(0);
}

u64 
getarg(char *s, int ac, char **av)
{
	register u64 len, i;

	len = strlen(s);

	for (i = 1; i < ac; ++i) {
		if (!strncmp(av[i], s, len)) {
			register u64 bs = ATOL(&av[i][len]);

			switch (av[i][strlen(av[i]) - 1]) {
			    case 'K': bs *= 1000; break;
			    case 'k': bs <<= 10; break;
			    case 'M': bs *= 1000000; break;
			    case 'm': bs <<= 20; break;
			    case 'G': bs *= 1000000000L; break;
			    case 'g': bs <<= 30; break;
			}

			if (!strncmp(av[i], "label", 5)) {
				return (u64)(u32)(&av[i][len]);	/* HACK */
			}
			if (!strncmp(av[i], "bs=", 3)) {
				return (u64)(bs);
			}
			return (bs);
		}
	}
	return ((u64)-1);
}

char	*output;

int 
getfile(char *s, int ac, char **av)
{
	register int ret, len, i;
	int	append = getarg("append=", ac, av) != -1;
	int	notrunc = getarg("notrunc=", ac, av) != -1;
	int	nocreate = getarg("nocreate=", ac, av) != -1;
#ifdef	O_SYNC
	int	osync = getarg("osync=", ac, av) != -1;
#endif
	int	oflags;

	len = strlen(s);

	for (i = 1; i < ac; ++i) {
		if (!strncmp(av[i], s, len)) {
			if (av[i][0] == 'o') {
				if (!strcmp("of=internal", av[i]))
					return (-2);
				if (!strcmp("of=stdout", av[i]))
					return (1);
				if (!strcmp("of=1", av[i]))
					return (1);
				if (!strcmp("of=-", av[i]))
					return (1);
				if (!strcmp("of=stderr", av[i]))
					return (2);
				if (!strcmp("of=2", av[i]))
					return (2);
				oflags = O_WRONLY;
				oflags |= (notrunc || append) ? 0 : O_TRUNC;
				oflags |= nocreate ? 0 : O_CREAT;
				oflags |= append ? O_APPEND : 0;
#ifdef O_SYNC
				oflags |= osync ? O_SYNC : 0;
#endif
				ret = open(&av[i][len], oflags,0644);
#ifdef	O_DIRECT
				if ((getarg("odirect=", ac, av) != -1) ||
				    (getarg("direct=", ac, av) != -1)) {
					close(ret);
					ret = open(&av[i][len], oflags|O_DIRECT);
					awrite =
					    getarg("awrite=", ac, av) != -1;
				}
#endif
				if (ret == -1)
					error(&av[i][len]);
#ifdef F_FSSETXATTR
				if (Realtime == 1) {
					struct fsxattr fsxattr;
				
					bzero(&fsxattr,sizeof(struct fsxattr));
					fsxattr.fsx_xflags = 0x1;
					if (fcntl(ret,F_FSSETXATTR,&fsxattr)){
						printf("WARNING: Could not make %s a real time file\n",
						       &av[i][len]);
					}
				}
#endif
				output = &av[i][len];
				return (ret);
			} else {
				if (!strcmp("if=internal", av[i]))
					return (-2);
				if (!strcmp("if=stdin", av[i]))
					return (0);
				if (!strcmp("if=0", av[i]))
					return (0);
				if (!strcmp("if=-", av[i]))
					return (0);
				ret = open(&av[i][len], 0);
#ifdef	O_DIRECT
				if ((getarg("idirect=", ac, av) != -1) ||
				    (getarg("direct=", ac, av) != -1)) {
					close(ret);
					ret = open(&av[i][len], O_RDONLY|O_DIRECT);
				}
#endif
				if (ret == -1)
					error(&av[i][len]);
				return (ret);
			}
		}
	}
	return (-2);
}

#ifdef	FLUSH
int 
warning(char *s)
{
	if ((long)Label != -1) {
		fprintf(stderr, "%s: ", Label);
	}
	perror(s);
	return (-1);
}

void
flush(void)
{
	int	fd;
	struct	stat sb;
	caddr_t	where;

	if (output == NULL || (fd = open(output, 2)) == -1) {
		warning("No output file");
		return;
	}
	if (fstat(fd, &sb) == -1 || sb.st_size == 0) {
		warning(output);
		return;
	}
	where = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	msync(where, sb.st_size, MS_INVALIDATE);
	munmap(where, sb.st_size);
}
#endif

void 
error(char *s)
{
	if ((long)Label != -1) {
		fprintf(stderr, "%s: ", Label);
	}
	perror(s);
	exit(1);
}
