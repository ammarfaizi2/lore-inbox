Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267734AbTAHRep>; Wed, 8 Jan 2003 12:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbTAHReo>; Wed, 8 Jan 2003 12:34:44 -0500
Received: from fmr02.intel.com ([192.55.52.25]:492 "EHLO caduceus.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267734AbTAHRen>;
	Wed, 8 Jan 2003 12:34:43 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C17F1C71E@orsmsx108.jf.intel.com>
From: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
To: "'george@mvista.com'" <george@mvista.com>
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [BUG - HRT patch] nanosleep returns 0 on failure
Date: Wed, 8 Jan 2003 08:41:23 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George -
In the latest 2.5.54-bk1 high-res-timers patches, it appears that
nanosleep() is returning 0 (success) and not setting errno when an rqtp
argument is sent that specifies a nsec value < 0 or >= 1000 million.  In
this instance, the POSIX System Interfaces doc states that errno is supposed
to be set to EINVAL, and nanosleep should return -1.

In the 2.5.50 high-res-timers patches, behavior was as expected (i.e.,
returned -1 and set errno=EINVAL).  Unfortunately, I haven't looked at any
patches since then to know exactly which patch stopped behaving as expected.
A plain 2.5.54-bk1 kernel also behaves as expected (returns -1, sets
errno=EINVAL).

The tests I am using to reproduce this issue are part of the POSIX Test
Suite at http://posixtest.sf.net under
posixtestsuite/conformance/interfaces/nanosleep.  5-1.c (sending -1 nsec),
6-1.c (sending multiple nsec values < 0 and >= 1,000 million), and 10000-1.c
(sending other nsec values < 0 and >= 1,000 million) are failing.  I've
included 5-1.c below.

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

----
test 5-1.c below
(Output was:  nanosleep() did not return -1 on failure)

/*   
 * Copyright (c) 2002, Intel Corporation. All rights reserved.
 * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 * This file is licensed under the GPL license.  For the full content
 * of this license, see the COPYING file at the top level of this 
 * source tree.

 * Test that nanosleep() returns -1 on failure.
 * Simulate failure condition by sending -1 as the nsec to sleep for.
 */
#include <stdio.h>
#include <time.h>

#define PTS_PASS        0
#define PTS_FAIL        1
#define PTS_UNRESOLVED  2

int main(int argc, char *argv[])
{
	struct timespec tssleepfor, tsstorage;
	int sleepnsec = -1;

	tssleepfor.tv_sec=0;
	tssleepfor.tv_nsec=sleepnsec;
	if (nanosleep(&tssleepfor, &tsstorage) == -1) {
		printf("Test PASSED\n");
		return PTS_PASS;
	} else {
		printf("nanosleep() did not return -1 on failure\n");
		return PTS_FAIL;
	}

	printf("This code should not be executed.\n");
	return PTS_UNRESOLVED;
}

**These views are not necessarily those of my employer.**
