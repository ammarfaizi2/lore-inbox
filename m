Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTELQgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTELQgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:36:16 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:30914 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262269AbTELQgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:36:11 -0400
Message-ID: <3EBFD086.CC2E6C4A@Bull.Net>
Date: Mon, 12 May 2003 18:49:10 +0200
From: Eric Piel <Eric.Piel@Bull.Net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: george anzinger <george@mvista.com>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: [BUG] (clock_) nanosleep() too short
Content-Type: multipart/mixed;
 boundary="------------0FF5AFC92A3FBF31ED6D6CF5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0FF5AFC92A3FBF31ED6D6CF5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,
Running high-res-timers test suite on a vanilla kernel 2.5.69 fails on
my IA64 (4x Itanium2), in didn't in 2.5.67 (basically). The errors come
from the clock_nanosleep test:
:
:
clock_nanosleeptest.c,198:slept too  short!
 requested:     1052757759s 403952000ns
 now:           1052757759s 403735000ns
 diff is -0.000217000sec
clock_nanosleeptest.c,198:slept too  short!
 requested:     1052757760s 403924000ns
 now:           1052757760s 403719000ns
 diff is -0.000205000sec
:
:

Attached are two codes with which I measured the time of a
clock_nanosleep() and a nanosleep(). They display how long took the
nanosleep calls depending on different time requested.

With a kernel where FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP is undefined I
obtain:

TIME REQUESTED    TIME MEASURED
$ ./clock_nanosleep 
 0.000000100      0.000587000
 0.000001000      0.000855000
 0.000010000      0.000954000
 0.000100000      0.000962000
 0.001000000      0.001940000
 0.010000000      0.010729000
 0.100000000      0.100573000
 1.000000100      0.999952000
 1.000001000      0.999959000
 1.000010000      0.999957000
 1.000100000      0.999953000
 1.001000000      1.000933000
 1.010000000      1.009726000
 1.100000000      1.099567000
 2.000000100      1.999947000

$ ./nanosleep 
 0.000000100      0.002036000
 0.000001000      0.001831000
 0.000010000      0.001936000
 0.000100000      0.001940000
 0.001000000      0.002916000
 0.010000000      0.011704000
 0.100000000      0.101549000
 1.000000100      1.000929000
 1.000001000      1.000936000
 1.000010000      1.000936000
 1.000100000      1.000932000
 1.001000000      1.001908000
 1.010000000      1.010702000
 1.100000000      1.100544000
 2.000000100      2.000920000

clock_nanosleep() is slightly shorter than requested and on a vanilla
kernel nanosleep() is also affected!
I guess it comes from the modifications made on clock_* few days ago but
first I wonder if only IA64 has this problem. Maybe the fact that
HZ=1/1024 is important.
If some people could try to run nanosleep on their x86 that would
already help a lot to find where to look for the bug.

cheers
Eric


PS: you need the library of the high-res-timers test suite to compile
clock_nanosleep.c
--------------0FF5AFC92A3FBF31ED6D6CF5
Content-Type: text/plain; charset=us-ascii;
 name="clock_nanosleep.c"
Content-Disposition: inline;
 filename="clock_nanosleep.c"
Content-Transfer-Encoding: 7bit

/* should gives effective times of a nanosleep() */

#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include "lib/posix_time.h"

#define USEC_PER_SEC	1000000
#define NSEC_PER_SEC	1000000000L

#define timerdiff(a,b) ((double)((a)->tv_sec - (b)->tv_sec) + \
                         (double)((a)->tv_usec - (b)->tv_usec)/USEC_PER_SEC)

main()
{
	struct timeval pre_time, post_time;
	struct timespec req;
	double diff;
	int i;
	
	req.tv_sec = 0;
	req.tv_nsec = 10;
	for (i=0; i<15; i++){
		req.tv_nsec *= 10;
		if (req.tv_nsec >= NSEC_PER_SEC) {
			req.tv_nsec = 100;
			req.tv_sec++;
		}
		gettimeofday(&pre_time, NULL);
		clock_nanosleep(CLOCK_REALTIME, 0, &req, NULL);
		gettimeofday(&post_time, NULL);

		diff = timerdiff(&post_time, &pre_time);
		printf("%12.9f\t %12.9f\n", (double)req.tv_sec + ((double)req.tv_nsec/NSEC_PER_SEC), diff);
	}


}

--------------0FF5AFC92A3FBF31ED6D6CF5
Content-Type: text/plain; charset=us-ascii;
 name="nanosleep.c"
Content-Disposition: inline;
 filename="nanosleep.c"
Content-Transfer-Encoding: 7bit

/* should gives effective times of a nanosleep() */

#include <stdio.h>
#include <sys/time.h>
#include <time.h>

#define USEC_PER_SEC	1000000
#define NSEC_PER_SEC	1000000000L

#define timerdiff(a,b) ((double)((a)->tv_sec - (b)->tv_sec) + \
                         (double)((a)->tv_usec - (b)->tv_usec)/USEC_PER_SEC)

main()
{
	struct timeval pre_time, post_time;
	struct timespec req;
	double diff;
	int i;
	
	req.tv_sec = 0;
	req.tv_nsec = 10;
	for (i=0; i<15; i++){
		req.tv_nsec *= 10;
		if (req.tv_nsec >= NSEC_PER_SEC) {
			req.tv_nsec = 100;
			req.tv_sec++;
		}
		gettimeofday(&pre_time, NULL);
		nanosleep(&req, NULL);
		gettimeofday(&post_time, NULL);

		diff = timerdiff(&post_time, &pre_time);
		printf("%12.9f\t %12.9f\n", (double)req.tv_sec + ((double)req.tv_nsec/NSEC_PER_SEC), diff);
	}


}

--------------0FF5AFC92A3FBF31ED6D6CF5--

