Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSKVSzC>; Fri, 22 Nov 2002 13:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265205AbSKVSzB>; Fri, 22 Nov 2002 13:55:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41977 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265196AbSKVSy5>;
	Fri, 22 Nov 2002 13:54:57 -0500
Message-ID: <3DDE7EF8.9598E484@mvista.com>
Date: Fri, 22 Nov 2002 11:01:12 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Fleischer, Julie N" <julie.n.fleischer@intel.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Running POSIX Timers tests against HRT implementation
References: <D9223EB959A5D511A98F00508B68C20C0CCC1F7D@orsmsx108.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fleischer, Julie N" wrote:
> 
> George -
> Thanks to your help in getting the bk2 kernel patches, I am finally able to
> run the POSIX Timers suite against your latest patches.
> 
> I think I may be finding some conformance issues that would interest you,
> and I'm wondering how you would want me to communicate these?  From people
> here, I hear patches are submitted by sending a mail to the owner and cc'ing
> the project mailing list and LKML.  But, these aren't patches, since I'm
> just finding the issues, but not fixing them (Or, at least, I don't have
> that ability to yet....).
> 
> I've attached an example of the types of reports I might generate (This is
> actually the one issue I've found that I've actually investigated enough to
> feel comfortable reporting it.).   I just wanted to check with you first to
> know how to get this kind of information to you (if you think it is useful).
> Also, any input you have on how I could make these reports more useful would
> be appreciated.

This report is more than enough.  You can report them to me
and the two mailing lists.  This gives me a framework from
which to respond without folks wondering "what is this
about".

Now, as to this particular issue, the 1003.1b-1993 standard
in paragraph 14.2.1.2 says "The effect of setting a clock
via clock_settime() on armed per process timers associated
with that clock is implementation defined."

I took the easy way out here and did not choose to correct
absolute timers on clock setting.  I did, however, follow
the standard on the clock_nanosleep() call where the
standard is not so forgiving. 

Even here, I am afraid is fudged a little.  Clock_realtime
is just the standard linux wall clock (i.e. gettimeofday())
which is changed by the NTP stuff.  I do not requeue
clock_nanosleep() absolute times when NTP changes the
clock.  I am would like the long range solution to this
problem to be that NTP affects CLOCK_MONOTONIC and that
CLOCK_REALTIME would then be a fixed offset from this
clock.  Clock_settime() would then just mess with this
offset.  This would fix other time issues in the kernel
having to do with differences between the timer clock
(CLOCK_MONOTONIC) and the wall clock.

-g
> 
> Thanks.
> - Julie
> 
> ======
> REPORT
> ======
> Absolute timers appear to be behaving like relative timers if the clock is
> changed using clock_settime() before the absolute timer expires.
> 
> Additional information is below:
> kernel used = 2.5.48-bk2
> HRT patches applied =
>   hrtimers-core-2.5.48-bk2-1.0.patch
>   hrtimers-hrposix-2.5.48-bk2-1.0.patch
>   hrtimers-i386-2.5.48-bk2-1.0.patch
>   hrtimers-posix-2.5.48-bk2-1.0.patch
>   hrtimers-support-2.5.44-1.0.patch
> hardware = Dual P3, STL2 motherboard,
>            933MHz, 512 RAM
> relevant lines of .config =
> CONFIG_HIGH_RES_TIMERS=y
> # CONFIG_HIGH_RES_TIMER_ACPI_PM is not set
> CONFIG_HIGH_RES_TIMER_TSC=y
> # CONFIG_HIGH_RES_TIMER_PIT is not set
> 
> The two test cases which reproduce this issue are below (I believe these
> test cases are valid, but I'd appreciate hearing if I'm doing anything
> incorrectly.):
> 
> 4-1.c - Creates an absolute timer.  Moves the clock forward.  Waits for the
> timer to expire. ==> The timer expires afer the relative amount of time has
> passed, not at the absolute time the timer was set to as expected per POSIX
> 1003.1-2001, lines 6004-6006.
> 
> 4-2.c - Creates an absolute timer.  Moves the clock forward past the time
> the timer would
> expire. ==>  The timer expires after the relative amount of time has passed,
> not immeidiately as expected per POSIX 1003.1-2001, lines 6007-6009.
> 
> Compiled with:
> gcc -g -O2 -Wall -Werror 4-1.c -L/lib/libposixtime.so -lposixtime
> 
> Test source available on-line at:
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/
> posixtest/posixtestsuite/conformance/
> behavior/clock_settime/
> 
> Tests
> -----
> 4-1.c
> /*
>  * Copyright (c) 2002, Intel Corporation. All rights reserved.
>  * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
>  * This file is licensed under the GPL license.  For the full content
>  * of this license, see the COPYING file at the top level of this
>  * source tree.
>  *
>  * Test that if clock_settime() changes the value for CLOCK_REALTIME,
>  * then any absolute timers will use the new time for expiration.
>  *
>  * Steps:
>  * - get time T0
>  * - create/enable a timer to expire at T1 = T0 + TIMEROFFSET
>  * - sleep SLEEPTIME seconds (SLEEPTIME should be < TIMEROFFSET,
>  *                              but > ACCEPTABLEDELTA)
>  * - set time back to T0
>  * - wait for the timer to expire
>  * - get time T2
>  * - ensure that:  T2 >= T1 and (T2-T1) <= ACCEPTABLEDELTA
>  *
>  * signal SIGTOTEST is used.
>  */
> #include <stdio.h>
> #include <time.h>
> #include <signal.h>
> #include <unistd.h>
> 
> #define PASS 0
> #define FAIL 1
> #define UNRESOLVED 2
> 
> // SLEEPTIME < TIMEROFFSET
> // SLEEPTIME > ACCEPTABLEDELTA
> #define SLEEPTIME 3
> #define TIMEROFFSET 9
> #define ACCEPTABLEDELTA 1
> 
> #define SIGTOTEST SIGALRM
> 
> int main(int argc, char *argv[])
> {
>         struct sigevent ev;
>         struct timespec tpT0, tpT2;
>         struct itimerspec its;
>         timer_t tid;
>         int delta;
>         int sig;
>         sigset_t set;
>         int flags = 0;
> 
>         /*
>          * set up sigevent for timer
>          * set up signal set for sigwait
>          */
>         ev.sigev_notify = SIGEV_SIGNAL;
>         ev.sigev_signo = SIGTOTEST;
> 
>         if (sigemptyset(&set) != 0) {
>                 perror("sigemptyset() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (sigaddset(&set, SIGTOTEST) != 0) {
>                 perror("sigaddset() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (clock_gettime(CLOCK_REALTIME, &tpT0) != 0) {
>                 perror("clock_gettime() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
>                 perror("timer_create() did not return success\n");
>                 return UNRESOLVED;
>         }
> 
>         flags |= TIMER_ABSTIME;
>         its.it_interval.tv_sec = 0;
>         its.it_interval.tv_nsec = 0;
>         its.it_value.tv_sec = tpT0.tv_sec + TIMEROFFSET;
>         its.it_value.tv_nsec = tpT0.tv_nsec;
>         if (timer_settime(tid, flags, &its, NULL) != 0) {
>                 perror("timer_settime() did not return success\n");
>                 return UNRESOLVED;
>         }
> 
>         sleep(SLEEPTIME);
>         if (clock_settime(CLOCK_REALTIME, &tpT0) != 0) {
>                 printf("clock_settime() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (sigwait(&set, &sig) == -1) {
>                 perror("sigwait() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (clock_gettime(CLOCK_REALTIME, &tpT2) != 0) {
>                 printf("clock_gettime() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         delta = tpT2.tv_sec - its.it_value.tv_sec;
> 
>         if ( (delta <= ACCEPTABLEDELTA) && (delta >= 0) ) {
>                 printf("Test PASSED\n");
>                 return PASS;
>         } else {
>                 printf("FAIL:  Ended %d, not %d\n",
>                                 (int) tpT2.tv_sec,
>                                 (int) its.it_value.tv_sec);
>                 return FAIL;
>         }
> 
>         return UNRESOLVED;
> }
> 
> 4-2.c
> /*
>  * Copyright (c) 2002, Intel Corporation. All rights reserved.
>  * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
>  * This file is licensed under the GPL license.  For the full content
>  * of this license, see the COPYING file at the top level of this
>  * source tree.
>  *
>  * Test that if clock_settime() changes the value for CLOCK_REALTIME,
>  * an absolute timer which would now have expired in the past
>  * will expire immediately (with no error).
>  *
>  * Steps:
>  * - get time T0
>  * - create/enable a timer to expire at T1 = T0 + TIMEROFFSET
>  * - set time forward to T1 + CLOCKOFFSET
>  * - ensure that timer has expired with no error
>  *
>  * signal SIGTOTEST is used.
>  */
> #include <stdio.h>
> #include <time.h>
> #include <signal.h>
> #include <unistd.h>
> #include <stdlib.h>
> 
> #define PASS 0
> #define FAIL 1
> #define UNRESOLVED 2
> 
> // SLEEPTIME < TIMEROFFSET
> // SLEEPTIME > ACCEPTABLEDELTA
> #define TIMEROFFSET 9
> #define CLOCKOFFSET 4
> 
> #define SHORTTIME 1
> 
> #define SIGTOTEST SIGALRM
> 
> void handler(int signo)
> {
>         printf("Caught signal\n");
>         printf("Test PASSED\n");
>         exit(PASS);
> }
> 
> int main(int argc, char *argv[])
> {
>         struct sigevent ev;
>         struct sigaction act;
>         struct timespec tpT0, tpclock;
>         struct itimerspec its;
>         timer_t tid;
>         //int sig;
>         sigset_t set;
>         int flags = 0;
> 
>         /*
>          * set up sigevent for timer
>          * set up signal set for sigwait
>          * set up sigaction to catch signal
>          */
>         ev.sigev_notify = SIGEV_SIGNAL;
>         ev.sigev_signo = SIGTOTEST;
> 
>         act.sa_handler=handler;
>         act.sa_flags=0;
> 
>         if ( (sigemptyset(&set) != 0) ||
>                 (sigemptyset(&act.sa_mask) != 0) ) {
>                 perror("sigemptyset() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (sigaddset(&set, SIGTOTEST) != 0) {
>                 perror("sigaddset() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (sigaction(SIGTOTEST, &act, 0) != 0) {
>                 perror("sigaction() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (clock_gettime(CLOCK_REALTIME, &tpT0) != 0) {
>                 perror("clock_gettime() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
>                 perror("timer_create() did not return success\n");
>                 return UNRESOLVED;
>         }
> 
>         flags |= TIMER_ABSTIME;
>         its.it_interval.tv_sec = 0;
>         its.it_interval.tv_nsec = 0;
>         its.it_value.tv_sec = tpT0.tv_sec + TIMEROFFSET;
>         its.it_value.tv_nsec = tpT0.tv_nsec;
>         if (timer_settime(tid, flags, &its, NULL) != 0) {
>                 perror("timer_settime() did not return success\n");
>                 return UNRESOLVED;
>         }
> 
>         tpclock.tv_sec = its.it_value.tv_sec + CLOCKOFFSET;
>         tpclock.tv_nsec = its.it_value.tv_nsec;
>         if (clock_settime(CLOCK_REALTIME, &tpclock) != 0) {
>                 printf("clock_settime() was not successful\n");
>                 return UNRESOLVED;
>         }
> 
>         sleep(SHORTTIME);
>         printf("timer should have expired _immediately_\n");
>         return FAIL;
> }
> **These views are not necessarily those of my employer.**

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
