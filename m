Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267971AbTAHVGp>; Wed, 8 Jan 2003 16:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbTAHVGo>; Wed, 8 Jan 2003 16:06:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:505 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267971AbTAHVGk>;
	Wed, 8 Jan 2003 16:06:40 -0500
Message-ID: <3E1C86BB.3D7C3AD7@mvista.com>
Date: Wed, 08 Jan 2003 12:14:51 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
CC: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG - HRT patch] nanosleep returns 0 on failure
References: <D9223EB959A5D511A98F00508B68C20C17F1C724@orsmsx108.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fleischer, Julie N" wrote:
> 
> > george anzinger wrote:
> > If you don't mind, I will add your test code to my
> > clock_nanosleep test code so this does not creep back in.
> 
> Sure.  It's all GPL.  The 6-1.c test case (attached below) probably has the
> best test because it does multiple values, some < 0, some >= 1000 million.
> 
> One other thing I forgot to write in my previous report is that
> clock_nanosleep() appeared to behave as expected, just nanosleep() showed
> the issue of returning 0 on failure.

Yes, I found the problem.  Thanks for the code and the heads
up.

-g
> 
> Thanks.
> - Julie
> 
> ----
> test 6-1.c
> /*
>  * Copyright (c) 2002, Intel Corporation. All rights reserved.
>  * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
>  * This file is licensed under the GPL license.  For the full content
>  * of this license, see the COPYING file at the top level of this
>  * source tree.
> 
>  * Test that nanosleep() sets errno to EINVAL if rqtp contained a
>  * nanosecond value < 0 or >= 1,000 million
>  */
> #include <stdio.h>
> #include <time.h>
> #include <errno.h>
> 
> #define PTS_PASS        0
> #define PTS_FAIL        1
> #define PTS_UNRESOLVED  2
> 
> #define NUMTESTS 7
> 
> int main(int argc, char *argv[])
> {
>         struct timespec tssleepfor, tsstorage;
>         int sleepnsec[NUMTESTS] = {-1, -5, -1000000000, 1000000000,
>                 1000000001, 2000000000, 2000000000 };
>         int i;
>         int failure = 0;
> 
>         tssleepfor.tv_sec=0;
> 
>         for (i=0; i<NUMTESTS;i++) {
>                 tssleepfor.tv_nsec=sleepnsec[i];
>                 printf("sleep %d\n", sleepnsec[i]);
>                 if (nanosleep(&tssleepfor, &tsstorage) == -1) {
>                         if (EINVAL != errno) {
>                                 printf("errno != EINVAL\n");
>                                 failure = 1;
>                         }
>                 } else {
>                         printf("nanosleep() did not return -1 on
> failure\n");
>                         return PTS_UNRESOLVED;
>                 }
>         }
> 
>         if (failure) {
>                 printf("At least one test FAILED\n");
>                 return PTS_FAIL;
>         } else {
>                 printf("All tests PASSED\n");
>                 return PTS_PASS;
>         }
> }
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
