Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263584AbRFSE6r>; Tue, 19 Jun 2001 00:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263605AbRFSE6i>; Tue, 19 Jun 2001 00:58:38 -0400
Received: from jalon.able.es ([212.97.163.2]:65256 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S263584AbRFSE6U>;
	Tue, 19 Jun 2001 00:58:20 -0400
Date: Tue, 19 Jun 2001 01:34:06 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Dan Kegel <dank@kegel.com>
Cc: Pete Wyckoff <pw@osc.edu>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: getrusage vs /proc/pid/stat?
Message-ID: <20010619013406.A2531@werewolf.able.es>
In-Reply-To: <3B2D8ED0.40B299B5@kegel.com> <20010618134433.C9415@osc.edu> <3B2E7094.D53308BD@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3B2E7094.D53308BD@kegel.com>; from dank@kegel.com on Mon, Jun 18, 2001 at 23:20:20 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010618 Dan Kegel wrote:
>Pete Wyckoff wrote:
>> 
>> dank@kegel.com said:
>> > I'd like to monitor CPU, memory, and I/O utilization in a
>> > long-running multithreaded daemon under kernels 2.2, 2.4,
>> > and possibly also Solaris (#ifdefs are ok).
>> 
>> getrusage() isn't really the system call you want for this.
>
>I'll buy that.  Looks like a lot of unices don't implement that
>call fully, and Linux is one of them.
>
>What is the proper way to measure total CPU time used by a multithreaded program?

I have just the same problem. getrusage() did not catch the CPU time for
children, even if the man page said that. Now I am using times(2), that
seems to work in Solaris, but gives nothing in Linux.

I you look at time(1) manpage, it says time is implemented over the times(2)
system call. But if I include that call, it gives me only zero.

This is the output on Solaris:

den:~/ask/tst/cbox0> time box @options
Rendering box.jpg: 64x64
****************************************************************
Wall Time:0000:00:00.241
User Time:0000:00:00.600
Sys  Time:0000:00:00.000

real    0m0.59s
user    0m0.76s
sys     0m0.07s

(user is greater, cause it uses 4 cpus and times is cumulative)

And this is the output on Linux (2.4.5-ac15, glibc2.2.3)

werewolf:~/ask/tst/cbox0> time -p box @options
Rendering box.jpg: 64x64
****************************************************************
Wall Time:0000:00:01.299
User Time:0000:00:00.000
Sys  Time:0000:00:00.000
real 1.43
user 2.63
sys 0.02

????? time gives good results for summed CPU time, but my own call
to times(2) fails ???

If they can help you (and if you see any error) here is my Timer:

timer.h:

#ifndef AST_TIMER_H
#define AST_TIMER_H

#include <ast/api.h>

class __apit Timer
{
protected:
	double	wstart,wlast,wnow;
	double	ustart,ulast,unow;
	double	sstart,slast,snow;
public:
static char*	format(double t);
	Timer();

	void reset();
	void update();

	double wall();
	double user();
	double system();

	double ewall();
	double euser();
	double esystem();
};

#endif // AST_TIMER_H 

timer.cc:

#include <ast/timer.h>
#include <ast/stream.h>
#include <string.h>
#include <stdio.h>
#include <time.h>

#ifdef __UNX__
#include <sys/time.h>
#include <sys/times.h>
#include <sys/resource.h>
#include <unistd.h>
#endif

//#define USE_GETRUSAGE

char *Timer::format(double t)
{
	int	h  = int(t/3600);
	int	m  = int((t-h*3600)/60);
	int	s  = int(t-h*3600-m*60);
	int	ms = int(1000*(t-h*3600-m*60-s));

	char* str = new char[64];
	ostrstream ss(str,64,ios::trunc);
	ss << setfill('0');
	ss << setw(4) << h;
	ss << ":" << setw(2) << m;
	ss << ":" << setw(2) << s;
	ss << "." << setw(3) << ms;
	ss << ends;

	return str;
}

Timer::Timer()
{
	reset();
}

void Timer::reset()
{
	update();

	wstart = wnow;
	ustart = unow;
	sstart = snow;
}

void Timer::update()
{
// Wall clock time
#ifdef __UNX__
	struct timeval tv;

	gettimeofday(&tv,NULL);
	wnow = 1000*tv.tv_sec+1e-3*tv.tv_usec;
#endif
#ifdef __WIN__
	wnow = ::time(NULL)*1000;
#endif
#ifdef __MAC__
	wnow = ::time(NULL)*1000;
#endif

// CPU User and System times
#ifdef __UNX__
#ifdef USE_GETRUSAGE
	struct rusage rus,ruc;
	getrusage(RUSAGE_SELF,&rus);
	getrusage(RUSAGE_CHILDREN,&ruc);

	double s,u;

	s = rus.ru_utime.tv_sec+ruc.ru_utime.tv_sec;
	u = rus.ru_utime.tv_usec+ruc.ru_utime.tv_usec;
	unow = 1000*s+1e-3*u;

	s = rus.ru_stime.tv_sec+ruc.ru_stime.tv_sec;
	u = rus.ru_stime.tv_usec+ruc.ru_stime.tv_usec;
	snow = 1000*s+1e-3*u;
#else
	struct tms t;
	times(&t);

	double s;

	s = t.tms_utime+t.tms_cutime;
#ifdef __linux__
	unow = double(1000*s)/double(sysconf(_SC_CLK_TCK));
#else
	unow = double(1000*s)/double(CLK_TCK);
#endif

	s = t.tms_stime+t.tms_cstime;
#ifdef __linux__
	snow = double(1000*s)/double(sysconf(_SC_CLK_TCK));
#else
	snow = double(1000*s)/double(CLK_TCK);
#endif

#endif
#endif
#ifdef __WIN__
	unow = ::time(NULL)*1000;
	snow = 0;
#endif
#ifdef __MAC__
	unow = ::time(NULL)*1000;
	snow = 0;
#endif

	wlast = wnow;
	ulast = unow;
	slast = snow;
}

double Timer::wall()
{
	update();
	return 0.001*(wnow-wstart);
}

double Timer::user()
{
	update();
	return 0.001*(unow-ustart);
}

double Timer::system()
{
	update();
	return 0.001*(snow-sstart);
}

double Timer::ewall()
{
	double last = wlast;
	update();
	return 0.001*(wnow-last);
}

double Timer::euser()
{
	double last = ulast;
	update();
	return 0.001*(unow-last);
}

double Timer::esystem()
{
	double last = slast;
	update();
	return 0.001*(snow-last);
}

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac15 #2 SMP Sun Jun 17 02:12:45 CEST 2001 i686
