Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbTAOIZA>; Wed, 15 Jan 2003 03:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbTAOIZA>; Wed, 15 Jan 2003 03:25:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47863 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265886AbTAOIYz>;
	Wed, 15 Jan 2003 03:24:55 -0500
Message-ID: <3E248E9D.68CC1CBB@mvista.com>
Date: Tue, 14 Jan 2003 14:26:37 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
CC: "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG - HRT patch] disabling timer hangs system when multiple 
 overruns
References: <D9223EB959A5D511A98F00508B68C20C17F1C749@orsmsx108.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fleischer, Julie N" wrote:
> 
> George -
> I'm testing your 2.5.54-bk1 high-res-timers patches and am working on
> debugging an issue I'm seeing where my system hangs (i.e., doesn't accept
> input and I have to reboot).  It happens when I'm disabling the timer by
> setting the it_value to 0.  I've been able to nail it down to know that it
> only happens when you have generated multiple overruns (i.e., when I set up
> a repeating timer and block it for > 1 timer expiry, my system then hangs
> when I try to disable that timer -- I'm disabling before unblocking the
> signals).
> 
> I know "system hang" is not very descriptive.  If you have input on what
> types of logs I should be looking at to figure out what's really going on or
> other ways I can debug, I'll do that.\

I suspect that you have run into a bug I fixed in the latest
version having to do with handing off a timer from id look
up to the spin lock on the timer.  I was releasing the look
up lock prior to taking the timer lock which allowed an
interrupt to sneek in there and set up a dead lock with the
interrupt code.  Most likey to happen when processing
overruning timers.

This is fixed in the latest patch.


> 
> I have added the tests I'm using to reproduce this issue to
> http://posixtest.sf.net.  The original one where I noticed it was
> posixtestsuite/conformance/interfaces/timer_gettime/2-3.c after Jim
> Houston's bug fix.  Then, I added
> posixtestsuite/conformance/interfaces/timer_settime/3-2.c and 3-3.c to help
> me get to root cause.  To view the issue, you can either run
> timer_gettime/2-3.c, or change timer_settime/3-3.c to use a repeating timer
> (in nsecs).  I have included the latter below.
> 
> ==> One related ignorant question I had is I wanted to test this against
> your latest version (2.5.54-bk6), but when I went today to get the bk
> patches for 2.5.54, I couldn't find them.  Are those only available for the
> current kernel version?  That makes sense -- I should have been quicker.
> But, just wanted to check if there was another way for me to get that
> version.

Oh, you mean the kernel.org patches, yes they are only on
kernel.org until the next version.  It is a rather large
patch.  I suppose I could send it if you can stand MB
attachments.

I have been off line trying to bring up my new computer on
RH8.0 so I have not moved to the latest kernel as yet.

-g
> 
> Additional information is below:
> kernel used = 2.5.54-bk1
> HRT patches applied =
>  hrtimers-core-2.5.54-bk1-1.0.patch
>  hrtimers-hrposix-2.5.54-bk1-1.0.patch
>  hrtimers-i386-2.5.54-bk1-1.0.patch
>  hrtimers-posix-2.5.54-bk1-1.0.patch
>  hrtimers-support-2.5.52-1.0.patch
> 
> Thanks.
> - Julie Fleischer
> 
> timer_settime/3-3.c - with modifications to show issue
> /*
>  * Copyright (c) 2002, Intel Corporation. All rights reserved.
>  * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
>  * This file is licensed under the GPL license.  For the full content
>  * of this license, see the COPYING file at the top level of this
>  * source tree.
> 
>  * Test that if value.it_value = 0, the timer is disarmed.  Test by
>  * disarming a currently armed and blocked timer.
>  *
>  * For this test, signal SIGTOTEST will be used, clock CLOCK_REALTIME
>  * will be used.
>  */
> 
> #include <time.h>
> #include <signal.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include "posixtest.h"
> 
> #define TIMEREXPIRENSEC 10000000
> #define SLEEPTIME 1
> 
> #define SIGTOTEST SIGALRM
> 
> void handler(int signo)
> {
>         printf("OK to be in once\n");
> }
> 
> int main(int argc, char *argv[])
> {
>         sigset_t set;
>         struct sigevent ev;
>         struct sigaction act;
>         timer_t tid;
>         struct itimerspec its;
>         struct timespec ts;
> 
>         ev.sigev_notify = SIGEV_SIGNAL;
>         ev.sigev_signo = SIGTOTEST;
> 
>         if (sigemptyset(&set) != 0) {
>                 perror("sigemptyset() did not return success\n");
>                 return PTS_UNRESOLVED;
>         }
> 
>         if (sigaddset(&set, SIGTOTEST) != 0) {
>                 perror("sigaddset() did not return success\n");
>                 return PTS_UNRESOLVED;
>         }
> 
>         if (sigprocmask(SIG_SETMASK, &set, NULL) != 0) {
>                 perror("sigprocmask() did not return success\n");
>                 return PTS_UNRESOLVED;
>         }
> 
>         if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
>                 perror("timer_create() did not return success\n");
>                 return PTS_UNRESOLVED;
>         }
> 
>         /*
>          * First set up timer to be blocked
>          */
>         its.it_interval.tv_sec = 0;
>         its.it_interval.tv_nsec = 5*TIMEREXPIRENSEC;
>         its.it_value.tv_sec = 0;
>         its.it_value.tv_nsec = TIMEREXPIRENSEC;
> 
>         printf("setup first timer\n");
>         if (timer_settime(tid, 0, &its, NULL) != 0) {
>                 perror("timer_settime() did not return success\n");
>                 return PTS_UNRESOLVED;
>         }
> 
>         printf("sleep\n");
>         sleep(SLEEPTIME);
>         printf("awoke\n");
> 
>         /*
>          * Second, set value.it_value = 0 and set up handler to catch
>          * signal.
>          */
>         act.sa_handler=handler;
>         act.sa_flags=0;
> 
>         if (sigemptyset(&act.sa_mask) == -1) {
>                 perror("Error calling sigemptyset\n");
>                 return PTS_UNRESOLVED;
>         }
>         if (sigaction(SIGTOTEST, &act, 0) == -1) {
>                 perror("Error calling sigaction\n");
>                 return PTS_UNRESOLVED;
>         }
> 
>         its.it_interval.tv_sec = 0;
>         its.it_interval.tv_nsec = 0;
>         its.it_value.tv_sec = 0;
>         its.it_value.tv_nsec = 0;
> 
>         printf("setup second timer\n");
>         if (timer_settime(tid, 0, &its, NULL) != 0) {
>                 perror("timer_settime() did not return success\n");
>                 return PTS_UNRESOLVED;
>         }
> 
>         printf("unblock\n");
>         if (sigprocmask(SIG_UNBLOCK, &set, NULL) != 0) {
>                 perror("sigprocmask() did not return success\n");
>                 return PTS_UNRESOLVED;
>         }
> 
>         /*
>          * Ensure sleep for TIMEREXPIRE seconds not interrupted
>          */
>         ts.tv_sec=SLEEPTIME;
>         ts.tv_nsec=0;
> 
>         printf("sleep again\n");
>         if (nanosleep(&ts, NULL) == -1) {
>                 printf("nanosleep() interrupted\n");
>                 printf("Test FAILED\n");
>                 return PTS_FAIL;
>         }
> 
>         printf("Test PASSED\n");
>         return PTS_PASS;
> }
> 
> **These views are not necessarily those of my employer.**
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

