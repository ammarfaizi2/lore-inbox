Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271651AbTGQXzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271655AbTGQXzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:55:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:12697 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S271651AbTGQXzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:55:38 -0400
X-Sieve: CMU Sieve 2.2
Message-ID: <3F1347C6.3030105@mvista.com>
Date: Mon, 14 Jul 2003 17:16:06 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       Amos Waterland <apw@us.ibm.com>
Subject: Re: Fw: Re: 2.5 kernel regression in alarm() syscall behaviour?
References: <20030714101656.73cdb75f.akpm@osdl.org>
In-Reply-To: <20030714101656.73cdb75f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jul 2003 00:16:45.0321 (UTC) FILETIME=[5FF04F90:01C34A66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Begin forwarded message:
> 
> Date: Mon, 14 Jul 2003 09:39:33 -0500
> From: Amos Waterland <apw@us.ibm.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: 2.5 kernel regression in alarm() syscall behaviour?
> 
> 
> I think Wes' mail client mangled his testcase a bit.  Here is a cleaned
> up version.

I suppose we are going to have a lot of these.  The test calls alarm 
which sets up an itimer for the specified number of seconds and 
returns the number of seconds remaining on the old itimer.  If any 
useconds remain, seconds is boosted by 1.  The test expects the number 
returned to be the same as what was sent, i.e. 1 second wait is 
expected to return 1 second if it is immeadiatly queried.

The problem with this test is that it assumes that seconds can be 
translated into jiffies with out any error.  Jiffies, however, is now 
defined to be close but not equal to 1/HZ.  In fact, on the x86 
jiffies is 999848 nano seconds.  The conversion of a second with the 
proper round up gives 1001 jiffies and converting this back to seconds 
gives 1.000847848 seconds.  It is this 0.000847848 that is forcing the 
subject test to report a number higher than expected.

IMHO it is the test that is wrong, not the kernel.

-g
> 
> Compile with:
> 
>   % gcc -Wall -Werror alarm.c -o alarm
> 
> Output on 2.4 kernel is:
> 
>   % ./alarm
>   [1058193354] alarm(0), want retval:0; got retval:0 (PASS)
>   ...
>   [1058193354] alarm(9), want retval:8; got retval:8 (PASS)
>   0/10 tests failed
> 
> Output on 2.5 kernel is: many failures.  The number of failures go down
> when the system is heavily stressed.
> 
> ---- Begin alarm.c ----
> 
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/time.h>
> 
> #define MINVAL 0
> #define MAXVAL 10
> #define NOALARM 0
> 
> int main(int argc, char **argv)
> {
>     int retval = 0, failed = 0, tests = MAXVAL, prev = 0, curr = 0;
>     struct timeval time;
> 
>     if (argc > 1)
>         if (sscanf(argv[1], "%d", &tests) != 1)
>             return 1;
> 
>     for (curr = MINVAL; curr < tests; curr++) {
>         retval = alarm(curr);
>         gettimeofday(&time, NULL);
>         printf("[%li] alarm(%d), want retval:%d; ",
>                time.tv_sec, curr, prev);
>         /* was there a previous alarm? */
>         if (retval == NOALARM && prev == NOALARM) {
>             printf("got retval:0 (PASS)");
>         } else if (retval == NOALARM && prev > NOALARM) {
>             printf("got retval:0 (FAIL)");
>             failed++;
>         } else if (retval != prev) {
>             printf("got retval:%d (FAIL)", retval);
>             failed++;
>         } else {
>             printf("got retval:%d (PASS)", retval);
>         }
>         printf("\n");
>         prev = curr;
>     }
>     printf("%d/%d tests failed\n", failed, tests);
>     return failed;
> }
> 
> ---- End alarm.c ----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

