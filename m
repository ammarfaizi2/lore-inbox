Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286382AbRL0RjI>; Thu, 27 Dec 2001 12:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286386AbRL0Riu>; Thu, 27 Dec 2001 12:38:50 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:13830 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286382AbRL0Rin>; Thu, 27 Dec 2001 12:38:43 -0500
Date: Thu, 27 Dec 2001 09:41:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, Momchil Velikov <velco@fadata.bg>,
        george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011226200124.A566@hq2>
Message-ID: <Pine.LNX.4.40.0112270931520.1558-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001, Victor Yodaiken wrote:

> On Mon, Dec 24, 2001 at 10:52:46AM -0800, Davide Libenzi wrote:
> > I know what you're saying but my goal now is to fix the scheduler not the
> > overall RT latency ( at least not the one that does not depend on the
>
> my bias is to fix the cause of the problem, but go ahead.
>
>
> > scheduler ). Just take for example your 17us for your 800MHz machine, in
> > my dual PIII 733 MHz with an rqlen of 4 the scheduler latency ( with that
> > std scheduler ) is about 0.9us ( real one, not lat_ctx ). That means the
> > the scheduler responsibility in your 17us is about 5%, and the remaining
> > 95% is due "external" kernel paths. With an rqlen of 16 ( std scheduler )
>
> No: we've measured. The time in our system, which does not follow any
> Linux kernel paths, is dominated by motherboard bus delays.

17us of bus delay ?!
UP or SMP ?
Under which kind of bus load ?


> > the latency peaks up to ~2.4us going to ~14-15% of scheduler responsibility.
> > I've coded this simple app :
> >
> > http://www.xmailserver.org/linux-patches/lnxsched.html#RtLats
> >
> > and i use it with the cpuhog ( hi-tech software that is available inside
> > the same link ) to load the run queue. I'm going to plot the measured
> > latency versus the runqueue length. Thanks to OSDLAB i'll have an 8 way
> > machine to make some test on these big SMPs. I'll code even the simple
> > app you're proposing but the real problem is how to load the system. The
> > cpuhog load is a runqueue load and is "neutral", that means that is the
> > same on all the systems. Loading the system with other kind of loads can
> > introduce a device-driver/hw dependency on the measure ( much or less run
> > time with irq disabled for example ).
>
> Try
> 	ping -f  localhost&
> 	ping -f  onsamelocalnet &
> 	dd if=/dev/hda1 of=/dev/null &
> 	make clean; make bzImage;
>
>
> as a simple start

Below is dumped the skeleton of a test app but i need an high res timer
patch to sleep 2-5ms




- Davide





/*
 *  rtttest  by Davide Libenzi ( linux kernel scheduler rt latency sampler )
 *  Version 0.16 - Copyright (C) 2001  Davide Libenzi
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  Davide Libenzi <davidel@xmailserver.org>
 *
 *
 *  The purpose of this tool is to measure the scheduler latency for
 *  real time tasks using the "latsched" kernel patch.
 *  Build:
 *
 *  gcc -o rtttest rtttest.c -lrt
 *
 *  Use:
 *
 *  rtttest [--test-stime s] [--sleep-mstime ms] [--pause-mstime ms] [--priority p]
 *          [--sched-fifo] [--sched-rr] [-- cmdpath [arg] ...]
 *
 *  --test-stime   = Set the test time in seconds
 *  --sleep-mstime = Set the sleep time in milliseconds
 *  --pause-mstime = Set the pause time in milliseconds
 *  --priority     = Set the real time task priority ( 1..99 )
 *  --sched-fifo   = Set the real time task policy to FIFO
 *  --sched-rr     = Set the real time task policy to RR
 *  --             = Separate the optional command to be executed during the test time
 *  cmdpath        = Command to be executed
 *  arg            = Command argouments
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>
#include <signal.h>
#include <sched.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/timex.h>


#define STD_SLEEP_TIME	4
#define PAUSE_SLEEP_TIME	200
#define STD_TEST_TIME	8


static volatile int stop_test = 0;


void sig_int(int sig)
{
	++stop_test;
	signal(sig, sig_int);
}


int main(int argc, char *argv[]) {
	int ii, icmd, pausetime = PAUSE_SLEEP_TIME, testtime = STD_TEST_TIME,
		policy = SCHED_FIFO, priority = 1, sleeptime = STD_SLEEP_TIME, numsamples;
	pid_t expid = -1;
	cycles_t cys, cye, cylat = 0, mscycles;
	cycles_t *samples;
	struct sched_param sp;
	struct timespec ts1, ts2;

	for (ii = 1; ii < argc; ii++) {
		if (strcmp(argv[ii], "--test-stime") == 0) {
			if (++ii < argc)
				testtime = atoi(argv[ii]);
			continue;
		}
		if (strcmp(argv[ii], "--sleep-mstime") == 0) {
			if (++ii < argc)
				sleeptime = atoi(argv[ii]);
			continue;
		}
		if (strcmp(argv[ii], "--pause-mstime") == 0) {
			if (++ii < argc)
				pausetime = atoi(argv[ii]);
			continue;
		}
		if (strcmp(argv[ii], "--priority") == 0) {
			if (++ii < argc)
				priority = atoi(argv[ii]);
			continue;
		}
		if (strcmp(argv[ii], "--sched-fifo") == 0) {
			policy = SCHED_FIFO;
			continue;
		}
		if (strcmp(argv[ii], "--sched-rr") == 0) {
			policy = SCHED_RR;
			continue;
		}
		if (strcmp(argv[ii], "--") == 0) {
			icmd = ++ii;
			break;
		}
	}

	numsamples = (testtime * 1000) / pausetime + 1;
	if (!(samples = (cycles_t *) malloc(numsamples * sizeof(cycles_t)))) {
		perror("malloc");
		return 1;
	}

	if (icmd > 0 && icmd < argc) {
		expid = fork();
		if (expid == -1) {
			perror("fork");
			return 5;
		} else if (expid == 0) {
			setpgid(0, getpid());
			execv(argv[icmd], &argv[icmd]);
			exit(0);
		}
	}

	memset(&sp, 0, sizeof(sp));
	sp.sched_priority = priority;

	if (sched_setscheduler(0, policy, &sp)) {
		perror("sched_setscheduler");
		if (expid > 0 && kill(-expid, SIGKILL))
			perror("SIGKILL");
		return 4;
	}

	signal(SIGINT, sig_int);

	clock_getres(CLOCK_REALTIME, &ts1);
	fprintf(stderr, "timeres=%ld\n", ts1.tv_nsec / 1000);

	clock_gettime(CLOCK_REALTIME, &ts1);
	cys = get_cycles();
	sleep(1);
	clock_gettime(CLOCK_REALTIME, &ts2);
	cye = get_cycles();
	mscycles = (cye - cys) / ((ts2.tv_sec - ts1.tv_sec) * 1000 + (ts2.tv_nsec - ts1.tv_nsec) / 1000000);

	for (ii = 0; ii < numsamples && !stop_test; ii++) {
		ts1.tv_sec = 0;
		ts1.tv_nsec = sleeptime * 1000000;

		cys = get_cycles();
		clock_nanosleep(CLOCK_REALTIME, 0, &ts1, &ts2);
		cye = get_cycles();

		samples[ii] = (cye - cys) / mscycles;
		if (samples[ii] > cylat)
			cylat = samples[ii];

		usleep(pausetime * 1000);
	}

	numsamples = ii;

	memset(&sp, 0, sizeof(sp));
	sp.sched_priority = 0;

	if (sched_setscheduler(0, SCHED_OTHER, &sp)) {
		perror("sched_setscheduler");
		if (expid > 0 && kill(-expid, SIGKILL))
			perror("SIGKILL");
		return 6;
	}

	if (expid > 0 && kill(-expid, SIGKILL))
		perror("SIGKILL");

	for (ii = 0; ii < numsamples; ii++) {

	}

	fprintf(stdout, "maxlat=%llu\n", cylat);

	return 0;

}





