Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUCQRGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUCQRGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:06:08 -0500
Received: from fmr05.intel.com ([134.134.136.6]:49799 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261496AbUCQRFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:05:52 -0500
From: Mark Gross <mgross@linux.co.intel.com>
Organization: Intel
To: Jamie Lokier <jamie@shareable.org>, Mark Gross <mgross@linux.co.intel.com>
Subject: Call for HRT in 2.6 kernel was Re: finding out the value of HZ from userspace
Date: Wed, 17 Mar 2004 08:48:01 -0800
User-Agent: KMail/1.5.4
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <200403161757.48786.mgross@linux.intel.com> <20040317023059.GD19564@mail.shareable.org>
In-Reply-To: <20040317023059.GD19564@mail.shareable.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BFIWAwftWQrIdTm"
Message-Id: <200403170848.01156.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_BFIWAwftWQrIdTm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 16 March 2004 18:30, Jamie Lokier wrote:
> Mark Gross wrote:
> > What can I do to help get high res timers available in the base kernel?
>
> Patches were written long ago, by George Anzinger I think.
>
> They were not accepted.  You might want to look into why not.  I think
> the reason was nothing to do with the quality of code, but rather that
> the clock programming overhead and code bloat wasn't desirable, and
> the gains not worth it.
>
> That is less true now that the kernel is pre-emptive.  Before,
> high-res timers couldn't provide any useful scheduling guarantee: you
> might receive a timer at exactly 1.56ms, but your code might still not
> run for another 150ms anyway.

Thats not what we see using the HRT patch on 2.4.40, or with the RHT patch on 2.6.

Yes, preemptive kernels are cool.

>
> Now there is still no guarantee, but the statistical response is much
> better.

Its A LOT better in practice with HRT, and more or less good enough for interactive  and multi-media uses.

>
> > I have some internal folks I've been assigned to help out that need
> > a low jitter time base to do some VoIP and need jitter < 250usec on
> > a ~2ms timer for the DSP computations to be do-able in user space.
> >
> > I would love to help get the existing HRT patches updated so as to
> > be acceptible, or failing that perhaps write a simple low jitter
> > time base driver vareant of the rtc driver.
>
> If it's appropriate for your application, just use one of the existing
> real-time linuxes (RTAI etc.).  They all offer high-res timers and
> will give much better VoIP guarantees than any of the high-res timer
> patches for non-real-time linux.
>

Nope, we need something thats in the future typical distribution or this product is not viable.

This isn't an embedded gadgit these guys are working on, so shipping an HRT patched kernel
is a show stopper for the product.

> If, however, you can't do that, consider: on i386 HZ is currently
> 1000.  So your request for 2ms timer is perfectly satisfiable using
> the standard timers.  Remember to turn on CONFIG_PREEMPT, and use a
> SCHED_FIFO sceduling policy.
>

They tested that a long time ago, an I re-tested it recently.  It doesn't work.
The Jitter is just way too high doing this without HR timers.

Check out the non-HRT timer code it rounds up to the next jiffies, always.  

Running with the HRT patch, we get a lot closer to what is being asked for.  

> If you measure the jitter and find it is unacceptable, be aware that
> none of the high-res timer patches for non-real-time linux will
> improve that.

Not true.  The HRT patch does indeed improve things a lot.  In fact it more or less does the job and it
enables the application.  Its not perfect, but its good.

The high res timer patch re-programs the PIT to produce an interrupt as close to the timeout as it 
can, where just the jiffies clock will wake up on the following jiffies tick.  On average 1 jiffies late!  Thats
a LOT of jitter.  If you look at the code and follow through the logic, if you ask for a 2ms sleep, you are basically 
going to get a 3ms sleep.   If you ask for a 1.1ms sleep you get a 2ms (with random larger jitters) sleep.  
To change this without doing some of the things in the HRT patch opens up the timer code to waking up 
the process too early.  Also a bad thing.  

This just isn't good enough for an entire class of applications that could exist on linux if it weren't for this issue.

>
> > Yup, and the human ear is even more sensitive.
> > Busted lip synch on video playback is embarassing under linux.
>
> Lip sync isn't a problem for buffered audio+video, if the playback
> code is able to adapt to the sound card's slight deviation from the
> nominal sample rate.  The sound card itself provides the regular
> clock.  A small difference between audio and video times is ok, as
> long as it stays consistent.
>
> The difficulty occurs with two-way communication, i.e. VoIP and video,
> when you can't buffer much.
>

Communications is definitely a harder problem calling for good low jitter time base services

> > My faverate flash animation web sites have a hard time with this as well.
>
> Btw, I noticed that flash animations seem visually smoother on
> Netscape 4 than Mozilla 1.2, on the same fast box running 2.6.
> Strange -- do they have different flash implementations?
>

I don't know, but my home box doesn't play back flash too well when booted into Mandrake or Fedora, where
you-know-who's OS works just fine.  Its a BP-6 box, not too speedy.  Regardless, my point is that without
an OS standard low jitter time base in the OS all the ISV's will be cobbling together there own hacks to get
low jitter time bases for their applications.  Some will work well, others will be flaky, more will have coexistence
issues sharing time base sources like the /dev/rtc.  

If the OS provides such support they would all tend to do the same thing and programs 
needing this type of time base features would all just work better.

> > Linux needs a low jitter time base standard for desktop multi-media
> > applications of many types.
>
> That's one of the reasons why HZ was changed to 1000 on x86 for 2.6
> kernels, and the major motivation for adding CONFIG_PREEMPT.
>

I know, but the current solution still isn't good enough, on a number of levels.


--mgross

--Boundary-00=_BFIWAwftWQrIdTm
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="jitter_test_noHRT.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="jitter_test_noHRT.c"

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

#define NOF_JITTER (500 * 60) /* 1 minute test 2ms*500*60 */

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

	retval = timer_create(CLOCK_REALTIME, NULL, &t);
	if (retval) {
		perror("timer_create(CLOCK_REALTIME) failed");
	}
	assert(retval == 0);

	retval = clock_gettime(CLOCK_REALTIME, &ispec.it_value);
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

--Boundary-00=_BFIWAwftWQrIdTm--

