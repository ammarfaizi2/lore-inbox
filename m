Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVCQGzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVCQGzB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 01:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVCQGzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 01:55:01 -0500
Received: from fmr24.intel.com ([143.183.121.16]:26819 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S263006AbVCQGyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 01:54:50 -0500
Subject: Re: [PATCH 2.6] fix POSIX timers expire before their scheduled time
From: Hong Liu <hong.liu@intel.com>
To: george@mvista.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <423923D9.4050801@mvista.com>
References: <1111026022.2994.54.camel@devlinux-hong>
	 <423923D9.4050801@mvista.com>
Content-Type: multipart/mixed; boundary="=-Chr4alsonl9Lazt+iu2Z"
Message-Id: <1111042088.2994.66.camel@devlinux-hong>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Mar 2005 14:48:08 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Chr4alsonl9Lazt+iu2Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-03-17 at 14:29, George Anzinger wrote:
> Liu, Hong wrote:
> > POSIX says: POSIX timers should not expire before their scheduled time.
> > 
> > Due to the timer started between jiffies, there are cases that the timer
> > will expire before its scheduled time.
> > This patch ensures timers will not expire early.
> > 
> > --- a/kernel/posix-timers.c     2005-03-10 15:46:27.329333664 +0800
> > +++ b/kernel/posix-timers.c     2005-03-10 15:50:11.884196136 +0800
> > @@ -957,7 +957,8 @@
> >                             &expire_64, &(timr->wall_to_prev))) {
> >                 return -EINVAL;
> >         }
> > -       timr->it_timer.expires = (unsigned long)expire_64;
> > +       timr->it_timer.expires = (unsigned long)expire_64 + 1;
> >         tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
> >         timr->it_incr = (unsigned long)expire_64;
> > 
> Has this happened??  The following code (in adjust_abs_time()) is supposed to 
> prevent this sort of thing:
> 
> 	if (oc.tv_sec | oc.tv_nsec) {
> 		oc.tv_nsec += clock->res;
> 		timespec_norm(&oc);
> 	}
> 
> Also, we run rather extensive tests for this sort of thing.
> 
The attached case from PosixTestSuite(http://posixtest.sourceforge.net)
failed on IA64 platform.
And if I changed the time interval to N*clock_res in this case, it will
also fail on IA32 platform.


BTW, I can't find the code piece you mentioned in 2.6.11 kernel.

--=-Chr4alsonl9Lazt+iu2Z
Content-Disposition: attachment; filename=9-1.c
Content-Type: text/x-csrc; name=9-1.c; charset=utf-8
Content-Transfer-Encoding: 7bit

/*   
 * Copyright (c) 2002, Intel Corporation. All rights reserved.
 * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 * This file is licensed under the GPL license.  For the full content
 * of this license, see the COPYING file at the top level of this 
 * source tree.
 *
 * Test that timers are not allowed to expire before their scheduled
 * time.
 *
 * Test for a variety of timer values on relative timers.
 *
 * For this test, signal SIGTOTEST will be used, clock CLOCK_REALTIME
 * will be used.
 */

#include <time.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define PTS_PASS        0
#define PTS_FAIL        1
#define PTS_UNRESOLVED  2
#define PTS_UNSUPPORTED 4
#define PTS_UNTESTED    5

#define SIGTOTEST SIGALRM
#define TIMERVALUESEC 2
#define TIMERINTERVALSEC 5
#define INCREMENT 1
#define ACCEPTABLEDELTA 1

#define NUMTESTS 6

static int timeroffsets[NUMTESTS][2] = { {0, 30000000}, {1, 0}, 
					{1, 30000000}, {2, 0},
					{1, 5000}, {1, 5} };

int main(int argc, char *argv[])
{
	struct sigevent ev;
	timer_t tid;
	struct itimerspec its;
	struct timespec tsbefore, tsafter;
	sigset_t set;
	int sig;
	int i;
	int failure = 0;
	unsigned long totalnsecs, testnsecs; // so long was we are < 2.1 seconds, we should be safe

	/*
	 * set up signal set containing SIGTOTEST that will be used
	 * in call to sigwait immediately after timer is set
	 */

	if (sigemptyset(&set) == -1 ) {
		perror("sigemptyset() failed\n");
		return PTS_UNRESOLVED;
	}

	if (sigaddset(&set, SIGTOTEST) == -1) {
		perror("sigaddset() failed\n");
		return PTS_UNRESOLVED;
	}

        if (sigprocmask (SIG_BLOCK, &set, NULL) == -1) {
                perror("sigprocmask() failed\n");
                return PTS_UNRESOLVED;
        }

	/*
	 * set up timer to perform action SIGTOTEST on expiration
	 */
	ev.sigev_notify = SIGEV_SIGNAL;
	ev.sigev_signo = SIGTOTEST;

	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
		perror("timer_create() did not return success\n");
		return PTS_UNRESOLVED;
	}

	for (i = 0; i < NUMTESTS; i++) {
		its.it_interval.tv_sec = 0; its.it_interval.tv_nsec = 0;
		its.it_value.tv_sec = timeroffsets[i][0];
		its.it_value.tv_nsec = timeroffsets[i][1];

		printf("Test for value %d sec %d nsec\n", 
				(int) its.it_value.tv_sec,
				(int) its.it_value.tv_nsec);

		if (clock_gettime(CLOCK_REALTIME, &tsbefore) != 0) {
			perror("clock_gettime() did not return success\n");
			return PTS_UNRESOLVED;
		}
		
		if (timer_settime(tid, 0, &its, NULL) != 0) {
			perror("timer_settime() did not return success\n");
			return PTS_UNRESOLVED;
		}
	
		if (sigwait(&set, &sig) == -1) {
			perror("sigwait() failed\n");
			return PTS_UNRESOLVED;
		}
	
		if (clock_gettime(CLOCK_REALTIME, &tsafter) != 0) {
			perror("clock_gettime() did not return success\n");
			return PTS_UNRESOLVED;
		}
	
		
		printf("tsbefore: sec--%lu, nsec--%lu\n", tsbefore.tv_sec,
							tsbefore.tv_nsec);
		printf("tsafter:  sec--%lu, nsec--%lu\n", tsafter.tv_sec,
							tsafter.tv_nsec);
		totalnsecs = (unsigned long) (tsafter.tv_sec-tsbefore.tv_sec)*
					1000000000 +
					(tsafter.tv_nsec-tsbefore.tv_nsec);
		testnsecs = (unsigned long) its.it_value.tv_sec*1000000000 + 
					its.it_value.tv_nsec;
		printf("total %lu test %lu\n", totalnsecs, testnsecs);
		if (totalnsecs < testnsecs) {
			printf("FAIL:  Expired %ld < %ld\n", totalnsecs,
							testnsecs);
			failure = 1;
		}
	}

	if (timer_delete(tid) != 0) {
		perror("timer_delete() did not return success\n");
		return PTS_UNRESOLVED;
	}

	if (failure) {
		printf("timer_settime() failed on at least one value\n");
		return PTS_FAIL;
	} else {
		printf("Test PASSED\n");
		return PTS_PASS;
	}
}

--=-Chr4alsonl9Lazt+iu2Z--

