Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267885AbTAMSYM>; Mon, 13 Jan 2003 13:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbTAMSYL>; Mon, 13 Jan 2003 13:24:11 -0500
Received: from fmr02.intel.com ([192.55.52.25]:60918 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267885AbTAMSYH>; Mon, 13 Jan 2003 13:24:07 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C17F1C749@orsmsx108.jf.intel.com>
From: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
To: "'george@mvista.com'" <george@mvista.com>
Cc: "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [BUG - HRT patch] disabling timer hangs system when multiple over
	runs
Date: Mon, 13 Jan 2003 10:26:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George -
I'm testing your 2.5.54-bk1 high-res-timers patches and am working on
debugging an issue I'm seeing where my system hangs (i.e., doesn't accept
input and I have to reboot).  It happens when I'm disabling the timer by
setting the it_value to 0.  I've been able to nail it down to know that it
only happens when you have generated multiple overruns (i.e., when I set up
a repeating timer and block it for > 1 timer expiry, my system then hangs
when I try to disable that timer -- I'm disabling before unblocking the
signals).

I know "system hang" is not very descriptive.  If you have input on what
types of logs I should be looking at to figure out what's really going on or
other ways I can debug, I'll do that.

I have added the tests I'm using to reproduce this issue to
http://posixtest.sf.net.  The original one where I noticed it was
posixtestsuite/conformance/interfaces/timer_gettime/2-3.c after Jim
Houston's bug fix.  Then, I added
posixtestsuite/conformance/interfaces/timer_settime/3-2.c and 3-3.c to help
me get to root cause.  To view the issue, you can either run
timer_gettime/2-3.c, or change timer_settime/3-3.c to use a repeating timer
(in nsecs).  I have included the latter below.

==> One related ignorant question I had is I wanted to test this against
your latest version (2.5.54-bk6), but when I went today to get the bk
patches for 2.5.54, I couldn't find them.  Are those only available for the
current kernel version?  That makes sense -- I should have been quicker.
But, just wanted to check if there was another way for me to get that
version.

Additional information is below:
kernel used = 2.5.54-bk1
HRT patches applied = 
 hrtimers-core-2.5.54-bk1-1.0.patch
 hrtimers-hrposix-2.5.54-bk1-1.0.patch
 hrtimers-i386-2.5.54-bk1-1.0.patch
 hrtimers-posix-2.5.54-bk1-1.0.patch
 hrtimers-support-2.5.52-1.0.patch

Thanks.
- Julie Fleischer

timer_settime/3-3.c - with modifications to show issue
/*   
 * Copyright (c) 2002, Intel Corporation. All rights reserved.
 * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 * This file is licensed under the GPL license.  For the full content
 * of this license, see the COPYING file at the top level of this 
 * source tree.

 * Test that if value.it_value = 0, the timer is disarmed.  Test by
 * disarming a currently armed and blocked timer.
 *
 * For this test, signal SIGTOTEST will be used, clock CLOCK_REALTIME
 * will be used.
 */

#include <time.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include "posixtest.h"

#define TIMEREXPIRENSEC 10000000
#define SLEEPTIME 1

#define SIGTOTEST SIGALRM

void handler(int signo)
{
	printf("OK to be in once\n");
}

int main(int argc, char *argv[])
{
	sigset_t set;
	struct sigevent ev;
	struct sigaction act;
	timer_t tid;
	struct itimerspec its;
	struct timespec ts;

	ev.sigev_notify = SIGEV_SIGNAL;
	ev.sigev_signo = SIGTOTEST;

	if (sigemptyset(&set) != 0) {
		perror("sigemptyset() did not return success\n");
		return PTS_UNRESOLVED;
	}

	if (sigaddset(&set, SIGTOTEST) != 0) {
		perror("sigaddset() did not return success\n");
		return PTS_UNRESOLVED;
	}

	if (sigprocmask(SIG_SETMASK, &set, NULL) != 0) {
		perror("sigprocmask() did not return success\n");
		return PTS_UNRESOLVED;
	}

	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
		perror("timer_create() did not return success\n");
		return PTS_UNRESOLVED;
	}

	/*
	 * First set up timer to be blocked
	 */
	its.it_interval.tv_sec = 0;
	its.it_interval.tv_nsec = 5*TIMEREXPIRENSEC;
	its.it_value.tv_sec = 0;
	its.it_value.tv_nsec = TIMEREXPIRENSEC;

	printf("setup first timer\n");
	if (timer_settime(tid, 0, &its, NULL) != 0) {
		perror("timer_settime() did not return success\n");
		return PTS_UNRESOLVED;
	}

	printf("sleep\n");
	sleep(SLEEPTIME);
	printf("awoke\n");

	/*
	 * Second, set value.it_value = 0 and set up handler to catch
	 * signal.
	 */
	act.sa_handler=handler;
	act.sa_flags=0;

	if (sigemptyset(&act.sa_mask) == -1) {
		perror("Error calling sigemptyset\n");
		return PTS_UNRESOLVED;
	}
	if (sigaction(SIGTOTEST, &act, 0) == -1) {
		perror("Error calling sigaction\n");
		return PTS_UNRESOLVED;
	}

	its.it_interval.tv_sec = 0;
	its.it_interval.tv_nsec = 0;
	its.it_value.tv_sec = 0;
	its.it_value.tv_nsec = 0;

	printf("setup second timer\n");
	if (timer_settime(tid, 0, &its, NULL) != 0) {
		perror("timer_settime() did not return success\n");
		return PTS_UNRESOLVED;
	}

	printf("unblock\n");
	if (sigprocmask(SIG_UNBLOCK, &set, NULL) != 0) {
		perror("sigprocmask() did not return success\n");
		return PTS_UNRESOLVED;
	}

	/*
	 * Ensure sleep for TIMEREXPIRE seconds not interrupted
	 */
	ts.tv_sec=SLEEPTIME;
	ts.tv_nsec=0;

	printf("sleep again\n");
	if (nanosleep(&ts, NULL) == -1) {
		printf("nanosleep() interrupted\n");
		printf("Test FAILED\n");
		return PTS_FAIL;
	}

	printf("Test PASSED\n");
	return PTS_PASS;
}

**These views are not necessarily those of my employer.**
