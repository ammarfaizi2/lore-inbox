Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSLDTn0>; Wed, 4 Dec 2002 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbSLDTn0>; Wed, 4 Dec 2002 14:43:26 -0500
Received: from fmr01.intel.com ([192.55.52.18]:2280 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267044AbSLDTnU>;
	Wed, 4 Dec 2002 14:43:20 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C0CCC1FB9@orsmsx108.jf.intel.com>
From: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
To: "'george@mvista.com'" <george@mvista.com>
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [Bug? - HRT] clock_settime w/tp out of bounds
Date: Wed, 4 Dec 2002 11:24:43 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another bug report for the high-res-timers project from my running
the POSIX Test Suite Timers tests against the high-res-timers
implementation.

Description:  clock_settime() is not failing as expected when tp has a
nanosecond value < 0 or >= 1000 million.

Details:
The POSIX spec (2001 - lines 6659-6660; 1993 - lines 127-128) states that if
a struct timespec *tp is passed that has a nanosecond value < 0 or >= 1000
million, the clock_settime() function will fail with errno EINVAL and return
-1.

In the high-res-timers implementation, if tp.tv_nsec is < 0 or >= 1000
million, the function returns 0 and sets the time as if tv_nsec were a valid
value.

Additional information is below:
kernel used = 2.5.50
HRT patches applied =
  hrtimers-posix-2.5.50-1.0.patch
  hrtimers-core-2.5.50-1.0.patch
  hrtimers-i386-2.5.50-1.0.patch
  hrtimers-hrposix-2.5.50-1.0.patch
relevant lines of .config =
  CONFIG_HIGH_RES_TIMERS=y
  # CONFIG_HIGH_RES_TIMER_ACPI_PM is not set
  CONFIG_HIGH_RES_TIMER_TSC=y
  # CONFIG_HIGH_RES_TIMER_PIT is not set

I have created one large test case which reproduces the issue on various
nsec values < 0 and >= 1000 (19-1.c).  Note:  Because it actually sets the
time, if it is run, you'll need to sync your time back to the correct time
at the end.

Compiled with:
gcc -g -O2 -Wall -Werror 19-1.c -L/lib/libposixtime.so -lposixtime

**These views are not necessarily those of my employer.**

Test 19-1.c - also on-line at (sorry about the breaks):
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/posixtest/posixtestsuite/conf
ormance/behavior/clock_settime/19-1.c?rev=HEAD
-----------

/*   
 * Copyright (c) 2002, Intel Corporation. All rights reserved.
 * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 * This file is licensed under the GPL license.  For the full content
 * of this license, see the COPYING file at the top level of this 
 * source tree.
 *
 * Test that clock_settime() sets errno=EINVAL if tp has a nsec value < 0 or

 * >= 1000 million.
 *
 * Test calling clock_settime() with the following tp.tv_nsec values:
 *   MIN INT = INT32_MIN
 *   MAX INT = INT32_MAX
 *   MIN INT - 1 = 2147483647  (this is what gcc will set to)
 *   MAX INT + 1 = -2147483647 (this is what gcc will set to)
 *   unassigned value = -1073743192 (ex. of what gcc will set to)
 *   unassigned value = 1073743192 (ex. of what gcc will set to)
 *   -1
 *   1000000000
 *   1000000001
 *
 * The clock_id CLOCK_REALTIME is used.
 */
#include <stdio.h>
#include <time.h>
#include <errno.h>
#include <stdint.h>

#define PTS_PASS 0
#define PTS_FAIL 1
#define PTS_UNRESOLVED 2

#define NUMINVALIDTESTS 9

static int invalid_tests[NUMINVALIDTESTS] = {
		INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192, 
		1073743192, -1, 1000000000, 1000000001
};

int main(int argc, char *argv[])
{
	struct timespec tsset, tscurrent;
	int i;
	int failure = 0;

	if (clock_gettime(CLOCK_REALTIME, &tscurrent) != 0) {
		printf("clock_gettime() did not return success\n");
		return PTS_UNRESOLVED;
	}

	for (i = 0; i < NUMINVALIDTESTS; i++) {
		tsset.tv_sec = tscurrent.tv_sec;
		tsset.tv_nsec = invalid_tests[i];

		printf("Test %d sec %d nsec\n",
				(int) tsset.tv_sec, (int) tsset.tv_nsec);
		if (clock_settime(CLOCK_REALTIME, &tsset) == -1) {
			if (EINVAL != errno) {
				printf("errno != EINVAL\n");
				failure = 1;
			}
		} else {
			printf("clock_settime() did not return -1\n");
			failure = 1;
		}
	}

	if (failure) {
		printf("At least one test FAILED -- see above\n");
		return PTS_FAIL;
	} else {
		printf("All tests PASSED\n");
		return PTS_PASS;
	}

	return PTS_UNRESOLVED;
}
