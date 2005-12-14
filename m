Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVLNT2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVLNT2p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLNT2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:28:45 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:59104 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932083AbVLNT2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:28:44 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1134569078.18921.48.camel@localhost.localdomain>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1134568080.18921.42.camel@localhost.localdomain>
	 <1134569078.18921.48.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-rUeeTrMpGt5giPDTleYE"
Date: Wed, 14 Dec 2005 14:28:28 -0500
Message-Id: <1134588508.13138.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rUeeTrMpGt5giPDTleYE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-12-14 at 09:04 -0500, Steven Rostedt wrote:
> On Wed, 2005-12-14 at 08:48 -0500, Steven Rostedt wrote:
> 
> > And going into gdb, I get:
> > 
> > (gdb) li *0xc0136b98
> > 0xc0136b98 is in hrtimer_cancel (kernel/hrtimer.c:671).
> > 666     int hrtimer_cancel(struct hrtimer *timer)
> > 667     {
> > 668             for (;;) {
> > 669                     int ret = hrtimer_try_to_cancel(timer);
> > 670
> > 671                     if (ret >= 0)
> > 672                             return ret;
> > 673             }
> > 674     }
> > 675
> > 
> > So it may not really be locked, and if I waited a couple of hours, it
> > might actually finish (the test usually takes a couple of minutes to
> > run, and I let it run here for about 20 minutes).

Ingo,

Running my jitter test shows a slow down on the responsiveness of
nanosleep.

In 2.6.14-rt2 (the only 2.6.14-rtx laying around still) I get:

reported res = 0.000001000
starting calibrate
finished calibrate: 736.0509MHz 736050890

  Requested time         Max             error
  --------------         ---             -----
  0.000001000           0.000032218     0.000031218
  0.000010000           0.000033196     0.000023196
  0.000100000           0.000124324     0.000024324
  0.001000000           0.001027797     0.000027797
  0.010000000           0.010025151     0.000025151
  0.100000000           0.100020185     0.000020185
  1.000000000           1.000024266     0.000024266
  1.000001000           1.000028153     0.000027153
  1.000010000           1.000036685     0.000026685
  1.000100000           1.000122415     0.000022415
  1.001000000           1.001023463     0.000023463
  1.010000000           1.010021942     0.000021942
  1.100000000           1.100025656     0.000025656
  2.000000000           2.000028559     0.000028559

errors off by 20 - 32 usecs

On 2.6.15-rc5-rt1 (with my patches) on the same machine I get:

reported res = 0.000001000
starting calibrate
finished calibrate: 736.0510MHz 736051025

  Requested time         Max             error
  --------------         ---             -----
  0.000001000           0.000089476     0.000088476
  0.000010000           0.000045054     0.000035054
  0.000100000           0.000135034     0.000035034
  0.001000000           0.001041864     0.000041864
  0.010000000           0.010042513     0.000042513
  0.100000000           0.100031702     0.000031702
  1.000000000           1.000041268     0.000041268
  1.000001000           1.000044342     0.000043342
  1.000010000           1.000055852     0.000045852
  1.000100000           1.000157908     0.000057908
  1.001000000           1.001055853     0.000055853
  1.010000000           1.010036436     0.000036436
  1.100000000           1.100040173     0.000040173
  2.000000000           2.000060079     0.000060079


errors off by 35 - 89 usecs

Is this normal??

Attached is the jitter test that I ran (also the test that will crash
the system without my patches).

-- Steve


--=-rUeeTrMpGt5giPDTleYE
Content-Disposition: attachment; filename=jitter_inc.c
Content-Type: text/x-csrc; name=jitter_inc.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <getopt.h>
#include <sched.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>

#define rdtsc(low,high) \
     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))

#define rdtscl(low) \
     __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")

#define rdtscll(val) \
     __asm__ __volatile__("rdtsc" : "=A" (val))

#define LOOPS 10.0

static void wait_for_second(struct timeval *tv)
{
	struct timeval stv;
	
	gettimeofday(&stv, NULL);
	do {
		gettimeofday(tv, NULL);
	} while(tv->tv_sec == stv.tv_sec);
}

int main(int argc, char **argv)
{
	int c;
	unsigned long long start, end, tps = 0;
	double cal;
	double max=0,min=0,avg=0;
	double times[] = { 
			   0.000001, 0.00001, 0.0001,
			   0.001, 0.01, 0.1, 1.0,
			   1.000001, 1.00001, 1.0001,
			   1.001, 1.01, 1.1, 2.0 };
	int i;
	int x;
	pid_t pid;
	struct sched_param sp;
	double sleeptime;
	unsigned long sec,nsec;
	struct timeval stv, tv;
	struct timespec ts;

	clock_getres(CLOCK_MONOTONIC, &ts);
	printf("reported res = %ld.%09ld\n",
			ts.tv_sec,
			ts.tv_nsec);

	pid = getpid();

	memset(&sp,0,sizeof(sp));
	sp.sched_priority = sched_get_priority_max(SCHED_FIFO);
	sched_setscheduler(pid,SCHED_FIFO,&sp);

	while ((c=getopt(argc,argv,"c:")) != -1) {
		switch (c) {
			case 'c':
				tps = strtoll(optarg,NULL,10);
				break;
			default:
				exit(0);
		}
	}

	if (!tps) {
		printf("starting calibrate\n");
		wait_for_second(&stv);
		rdtscll(start);
		do {
			gettimeofday(&tv, NULL);
		} while(tv.tv_sec < stv.tv_sec+4);
		rdtscll(end);

		tps = end - start;
		tps >>= 2;
		printf("finished calibrate: ");
	} else {
		printf("passed in calibrate: ");
	}
	cal = tps;
	cal /= 1000000.0;

	printf("%.4fMHz %llu\n\n",cal,tps);

	printf("  Requested time\t Max \t\t error\n");
	printf("  --------------\t --- \t\t -----\n");

	for (x=0; x < sizeof(times)/sizeof(double); x++) {
		sleeptime = times[x];
		sec = sleeptime;
		nsec = (sleeptime-(double)sec) * 1000000000;
	
		for (i=-1; i < LOOPS; i++) {
			struct timespec req = { sec, nsec };
			unsigned long long t;
			rdtscll(start);
			nanosleep(&req,NULL);
			rdtscll(end);
			t = end - start;
			if (i < 0)
				continue;
			cal = t;
			cal /= (double)tps;
			if (!i || cal > max)
				max = cal;
			if (!i || cal < min)
				min = cal;
			avg += cal;
		}
		
		avg /= LOOPS;
		
		printf("  %.9f\t\t%.9f\t%.9f\n",
		       sleeptime, max, max - sleeptime);
	}

	
	exit(0);
}

--=-rUeeTrMpGt5giPDTleYE--

