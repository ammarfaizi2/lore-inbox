Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUCQVno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUCQVno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:43:44 -0500
Received: from fmr05.intel.com ([134.134.136.6]:9603 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262092AbUCQVnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:43:20 -0500
From: Mark Gross <mgross@linux.co.intel.com>
Organization: Intel
To: Jamie Lokier <jamie@shareable.org>, Mark Gross <mgross@linux.co.intel.com>
Subject: Re: Call for HRT in 2.6 kernel was Re: finding out the value of HZ from userspace
Date: Wed, 17 Mar 2004 13:25:28 -0800
User-Agent: KMail/1.5.4
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <200403170848.01156.mgross@linux.intel.com> <20040317200702.GA25293@mail.shareable.org>
In-Reply-To: <20040317200702.GA25293@mail.shareable.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IJMWAEsj/MbQFcg"
Message-Id: <200403171325.28993.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_IJMWAEsj/MbQFcg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 17 March 2004 12:07, Jamie Lokier wrote:
> That's what I did with my old "Snake" program: determine when select()
> will round up, and then wake up early and busy-wait in a loop calling
> gettimeofday() until the precise time arrives.
>
> It's not good, although the busy wait is limited to the length of 1
> jiffie, or less if you can structure your program to compute
> synchronised with the jiffie clock.
>

Is this not a very strong argument for some type of HRT support in the kernel?

> > This just isn't good enough for an entire class of applications that
> > could exist on linux if it weren't for this issue.
>
> Hmm.
>
> For VoIP, I'm wondering why you need a timebase other than the sound
> card.  Won't it provide an interrupt for every new sound fragment?
>

I don't know the application the team I'm trying to help out well enough to say if thats workable.

We are exploring different "plan -B"s in case we can't get George's HRT patch updated and
into the base.  I would rather put my effort into helping George and the HRT 
implementation than writing another RTC like driver with crappy non-posix interface.

> > > > Linux needs a low jitter time base standard for desktop multi-media
> > > > applications of many types.
> > >
> > > That's one of the reasons why HZ was changed to 1000 on x86 for 2.6
> > > kernels, and the major motivation for adding CONFIG_PREEMPT.
> >
> > I know, but the current solution still isn't good enough, on a
> > number of levels.
>
> To demonstrate that 1000Hz ticks aren't good enough, because you need
> much smaller jitter than 1ms on "ordinary machines" i.e. standard
> distros, you'll have to demonstrate that you really are seeing much
> smaller jitter than 1ms in your HRT-patched kernels and that it makes
> a useful difference.

I'm trying!  

I think I have demostrated that you cannot get a 1ms timer 
by code inspection.

I've also demonstrated that asking for a 2ms periodic wake up will 
result in a 3ms periodic wake up.

The application I'm trying to enable spec's out a 0.25ms jitter on a 2ms 
periodic event clock to support doing some audio dsp.  However; I 
cannot argue the validity of the 0.25ms requierment.  I think its a valid requierment.

Attached is the jitter test using the HRT.  Running on 2.6.3 + a rebase of the source 
forge patch gets me a 2ms wave form with some jitter < 0.25ms.  On my oscilloscope
it "looks" like about +/- 0.2 ms.  

It makes a useful difference today.

I should state the HRT patch for 2.6 on the source forge site is a bit out 
of date WRT 2.6 and needs some updating.  It works for the test application, but has 
some problems that don't happen with the 2.4  version of the patch.  George 
tells me he's rolling in some fixes he has binned up "soon".  Running the same test
using the 2.4.20 + HRT + preemption patch gives less jitter than the 2.6 version.
I'm here to help get that fixed up for 2.6.

The point here is that the rebased version of the current 2.6 HRT patch works good
enough for the application I'm worried about.


>
> The pre-emptive patches was initially rejected, but Linus changed his
> mind after a lot of good experimental data showing significant and
> consistent improvements in latency statistics, the fact that the
> patches were remarkeably non-invasive (because most of the work had
> been done to support fine-grained SMP by then), and perhaps most
> importantly, and surprisingly, I/O performance improved.
>
> So there is hope with HRT, but it needs more than an implementation to
> get into the standard tree (IMHO): it has to be fairly small,
> non-invasive, not harm existing performance, and backed by convincing
> experimental data showing worthwhile improvements.
>

Hope is good.

> On the bright side, HRT makes it possible to eliminate the jiffie tick
> entirely, which is quite likely to be good for performance and power
> consumption.  The objection to that has been that changing code which
> depends on the timer tick to not use it any more would complicate that
> code without much gain, and it's just not worth complicating anything
> for it.  But maybe, as for kernel pre-emption, it will turn out
> simpler than expected.

Perhaps.

--mgross

--Boundary-00=_IJMWAEsj/MbQFcg
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="jitter_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="jitter_test.c"

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <sys/io.h>
#include <sched.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <errno.h>
#include <signal.h>
#include <assert.h>

#define __NR_timer_create	259
#define __NR_timer_settime	(__NR_timer_create+1)
#define __NR_timer_gettime	(__NR_timer_create+2)
#define __NR_timer_getoverrun	(__NR_timer_create+3)
#define __NR_timer_delete	(__NR_timer_create+4)
#define __NR_clock_settime	(__NR_timer_create+5)
#define __NR_clock_gettime	(__NR_timer_create+6)
#define __NR_clock_getres	(__NR_timer_create+7)
#define __NR_clock_nanosleep	(__NR_timer_create+8)
#include "high-res-timers/lib/posix_time.h"
#include "high-res-timers/lib/syscall_timer.c"


#define NOF_JITTER (500*60) /* 1 minute test 2ms * 500 * 60 */

int jitter[NOF_JITTER];
int ijit;
struct timeval start;

void alrm_handler(int signo, siginfo_t *info, void *context)
{
  struct timeval end;
  int delta;
  static int bla=0;
  static int first = 1;

  printf(".\n");

  ioperm(0x378,3,1);

  gettimeofday(&end, NULL);

  if(bla) {
     outb(0x1,0x378);
     bla = 0;
   } else { 
     outb(0x0,0x378);
     bla = 1;

  }
	

  delta = (end.tv_sec - start.tv_sec) * 1000000 +
    (end.tv_usec - start.tv_usec);
  delta -= 2000;
  start = end;
  if (first) { first = 0; return; }
  if(ijit >= NOF_JITTER)
	printf("out of number already... \n");
  jitter[ijit++] = delta;
}

void print_hist(void)
{
#define HISTSIZE 1000*5 * 10

  int hist[50000+ 1];
  int i;

  printf("jitter[0] = %d\n", jitter[0]);
  memset(hist, 0, sizeof(hist));

  for (i = 1; i < NOF_JITTER; i++) {
    if (jitter[i] >= HISTSIZE/2) {
      printf("sample %d over max hist: %d\n", i, jitter[i]);
      hist[HISTSIZE]++;
    }
    else if (jitter[i] <= -HISTSIZE/2) {
      printf("sample %d over min hist: %d\n", i, jitter[i]);
      hist[0]++;
    }
    else {
      hist[jitter[i] + HISTSIZE/2]++;
    }
  }
  for (i = 1; i < HISTSIZE; i++) {
    if (hist[i]) {
      printf("%d: %d\n", i-HISTSIZE/2, hist[i]);
    }
  }
  printf("HC-: %d\n", hist[0]);
  printf("HC+: %d\n", hist[HISTSIZE]);
}

void print_avg(void)
{
  double sum;
  int i;

  sum = 0;
  for (i = 1; i < NOF_JITTER; i++) {
    sum += jitter[i];
  }

  printf("avg. jitter: %f\n", sum/(NOF_JITTER-1));
}

int main(void)
{
	int retval;
	timer_t t = 0;
	struct itimerspec ispec;
	struct itimerspec ospec;
	struct sigaction sa;
	struct sched_param sched;
#if 1 
	retval = mlockall(MCL_CURRENT|MCL_FUTURE);
	if (retval) {
	  perror("mlockall(MCL_CURRENT|MCL_FUTURE) failed");
	}
	assert(retval == 0);

	sched.sched_priority = 2;
	retval = sched_setscheduler(0, SCHED_FIFO, &sched); 
	if (retval) {
	  perror("sched_setscheduler(SCHED_FIFO)");
	}
	assert(retval == 0);
#endif

	sa.sa_sigaction = alrm_handler;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);

	if (sigaction(SIGALRM, &sa, NULL)) {
		perror("sigaction failed");
		exit(1);
	}

	if (sigaction(SIGRTMIN, &sa, NULL)) {
		perror("sigaction failed");
		exit(1);
	}

	retval = timer_create(CLOCK_REALTIME_HR, NULL, &t);
	if (retval) {
		perror("timer_create(CLOCK_REALTIME) failed");
	}
	assert(retval == 0);

	retval = clock_gettime(CLOCK_REALTIME_HR, &ispec.it_value);
	if (retval) {
		perror("clock_gettime(CLOCK_REALTIME) failed");
	}
	ispec.it_value.tv_sec += 1;
	ispec.it_value.tv_nsec = 0;
	ispec.it_interval.tv_sec = 0;
	ispec.it_interval.tv_nsec = 2*1000*1000; /* 100 Hz */

	retval = timer_settime(t, TIMER_ABSTIME, &ispec, &ospec);
	if (retval) {
		perror("timer_settime(TIMER_ABSTIME) failed");
	}

	do { pause(); } while (ijit < NOF_JITTER);

	retval = timer_delete(t);
	if (retval) {
		perror("timer_delete(existing timer) failed");
	}
	assert(retval == 0);

	print_hist();

	print_avg();

	return 0;
}

--Boundary-00=_IJMWAEsj/MbQFcg--

