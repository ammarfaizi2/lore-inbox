Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267936AbTAHUpL>; Wed, 8 Jan 2003 15:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTAHUpK>; Wed, 8 Jan 2003 15:45:10 -0500
Received: from fmr02.intel.com ([192.55.52.25]:24563 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267936AbTAHUpG>; Wed, 8 Jan 2003 15:45:06 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C17F1C724@orsmsx108.jf.intel.com>
From: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
To: "'george anzinger'" <george@mvista.com>,
       "Fleischer, Julie N" <julie.n.fleischer@intel.com>
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: RE: [BUG - HRT patch] nanosleep returns 0 on failure
Date: Wed, 8 Jan 2003 12:53:45 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> george anzinger wrote:
> If you don't mind, I will add your test code to my
> clock_nanosleep test code so this does not creep back in.

Sure.  It's all GPL.  The 6-1.c test case (attached below) probably has the
best test because it does multiple values, some < 0, some >= 1000 million.

One other thing I forgot to write in my previous report is that
clock_nanosleep() appeared to behave as expected, just nanosleep() showed
the issue of returning 0 on failure.

Thanks.
- Julie

----
test 6-1.c
/*   
 * Copyright (c) 2002, Intel Corporation. All rights reserved.
 * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 * This file is licensed under the GPL license.  For the full content
 * of this license, see the COPYING file at the top level of this 
 * source tree.

 * Test that nanosleep() sets errno to EINVAL if rqtp contained a 
 * nanosecond value < 0 or >= 1,000 million
 */
#include <stdio.h>
#include <time.h>
#include <errno.h>

#define PTS_PASS        0
#define PTS_FAIL        1
#define PTS_UNRESOLVED  2

#define NUMTESTS 7

int main(int argc, char *argv[])
{
	struct timespec tssleepfor, tsstorage;
	int sleepnsec[NUMTESTS] = {-1, -5, -1000000000, 1000000000, 
		1000000001, 2000000000, 2000000000 };
	int i;
	int failure = 0;

	tssleepfor.tv_sec=0;

	for (i=0; i<NUMTESTS;i++) {
		tssleepfor.tv_nsec=sleepnsec[i];
		printf("sleep %d\n", sleepnsec[i]);
		if (nanosleep(&tssleepfor, &tsstorage) == -1) {
			if (EINVAL != errno) {
				printf("errno != EINVAL\n");
				failure = 1;
			}
		} else {
			printf("nanosleep() did not return -1 on
failure\n");
			return PTS_UNRESOLVED;
		}
	}

	if (failure) {
		printf("At least one test FAILED\n");
		return PTS_FAIL;
	} else {
		printf("All tests PASSED\n");
		return PTS_PASS;
	}
}
**These views are not necessarily those of my employer.**
