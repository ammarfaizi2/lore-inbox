Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162377AbWKQJMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162377AbWKQJMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162415AbWKQJMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:12:00 -0500
Received: from SMT02002.global-sp.net ([193.168.50.254]:25010 "EHLO
	SMT02002.global-sp.net") by vger.kernel.org with ESMTP
	id S1162377AbWKQJL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:11:58 -0500
Message-ID: <455D7CDD.9000202@privacy.net>
Date: Fri, 17 Nov 2006 10:11:57 +0100
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tglx@timesys.com, mingo@elte.hu, johnstul@us.ibm.com
Subject: Incorrect behavior of timer_settime() for absolute dates in the past
Content-Type: multipart/mixed;
 boundary="------------040406010608060402020801"
X-OriginalArrivalTime: 17 Nov 2006 09:14:20.0195 (UTC) FILETIME=[C3B83F30:01C70A28]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406010608060402020801
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone,

[ NOTE: Email is a bit-bucket. I *do* monitor the mailing list. ]

I'm playing with the POSIX timers API. My platform is x86 running Linux 
2.6.18.1 patched with the high-resolution timer subsystem.

http://www.tglx.de/hrtimers.html

I'm seeing unexpected behavior from timer_settime().

int timer_settime(timer_t timerid, int flags,
   const struct itimerspec *value, struct itimerspec *ovalue);

timer_settime() is used to arm a timer. If the TIMER_ABSTIME flag is 
set, then the timer should fire when the appropriate clock reaches the 
date specified by value. If that date is in the past, the timer should 
fire immediately.

The Open Group Base Specifications Issue 6 states:
http://www.opengroup.org/onlinepubs/009695399/functions/timer_getoverrun.html

"If the flag TIMER_ABSTIME is set in the argument flags, timer_settime() 
shall behave as if the time until next expiration is set to be equal to 
the difference between the absolute time specified by the it_value 
member of value and the current value of the clock associated with 
timerid. That is, the timer shall expire when the clock reaches the 
value specified by the it_value member of value. If the specified time 
has already passed, the function shall succeed and the expiration 
notification shall be made."

In my tests, when timer_settime() is called with an expiration date in 
the past, the timer still takes some time to fire.

Here's a run-down of the code provided as an attachment:

I switch to a SCHED_RR scheduling policy. In other words, whenever my 
process wants the CPU, it gets it. (No other SCHED_RR or SCHED_FIFO 
processes on the system.) I mask the signal that will be delivered on 
timer expiration. I then arm a timer with an expiration date in the 
past, check whether the signal is pending, and block waiting for the 
signal. I then print how long I've had to wait.

# ./a.out
RESOLUTION=1 ns
NOW=969.735545919
SLEEPING 1 SECOND...
NOW=970.735581398
NOW=970.735613525
NOW=970.735749017
nsdiff=135492 ns i.e. 135.5 µs

Any ideas?

Regards,

John

--------------040406010608060402020801
Content-Type: text/plain;
 name="abstimerTEST.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="abstimerTEST.c"

#include <stdio.h>      // printf, puts, perror
#include <string.h>     // memset
#include <unistd.h>     // sleep
#include <signal.h>     // sig*
#include <sched.h>      // sched_setscheduler
#include <time.h>       // clock_gettime, timer_*

#define ZERO(type, name) type name; memset(&name, 0, sizeof name)
#define SIG_TIMER_EXPIRATION SIGRTMIN
#define CLOCK_TYPE CLOCK_MONOTONIC

void set_SCHED_RR(void)
{
  ZERO(struct sched_param, param);
  param.sched_priority = 66;
  if (sched_setscheduler(0, SCHED_RR, &param) != 0) perror("sched_setscheduler");
}

struct timespec get_time_stamp(void)
{
  ZERO(struct timespec, now);
  if (clock_gettime(CLOCK_TYPE, &now) != 0) perror("clock_gettime");
  printf("NOW=%ld.%09ld\n", now.tv_sec, now.tv_nsec);
  return now;
}

int main(void)
{
  set_SCHED_RR();

  sigset_t set;
  sigemptyset(&set);
  sigaddset(&set, SIG_TIMER_EXPIRATION);
  sigprocmask(SIG_BLOCK, &set, NULL);

  ZERO(struct timespec, reso);
  if (clock_getres(CLOCK_TYPE, &reso) != 0) perror("clock_getres");
  printf("RESOLUTION=%ld ns\n", reso.tv_sec*1000000000+reso.tv_nsec);

  timer_t timer;
  ZERO(struct sigevent, event);
  event.sigev_notify = SIGEV_SIGNAL;
  event.sigev_signo = SIG_TIMER_EXPIRATION;
  if (timer_create(CLOCK_TYPE, &event, &timer) != 0) perror("timer_create");

  sigset_t pending;

  struct timespec H = get_time_stamp();
  puts("SLEEPING 1 SECOND..."); sleep(1);
  /* H is now 1 second in the past. */
  get_time_stamp();
  ZERO(struct itimerspec, spec);
  spec.it_value = H;
  if (timer_settime(timer, TIMER_ABSTIME, &spec, NULL) != 0) perror("timer_settime");
  if (sigpending(&pending) != 0) perror("sigpending");
  int res=sigismember(&pending, SIG_TIMER_EXPIRATION);
  if (res < 0) perror("sigismember");
  else if (res) puts("TIMER HAS ALREADY FIRED.");
  
  struct timespec H1 = get_time_stamp();
  sigwaitinfo(&set, NULL);
  struct timespec H2 = get_time_stamp();

  int nsdiff = (H2.tv_sec-H1.tv_sec)*1000000000 + (H2.tv_nsec-H1.tv_nsec);
  printf("nsdiff=%d ns i.e. %d ms\n", nsdiff, nsdiff/1000000);

  return 0;
}

--------------040406010608060402020801--

