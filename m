Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271648AbTGQX5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271646AbTGQX40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:56:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10144 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S271654AbTGQXzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:55:43 -0400
Date: Mon, 14 Jul 2003 20:53:03 -0500
From: Amos Waterland <apw@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: 2.5 kernel regression in alarm() syscall behaviour?
Message-ID: <20030715015303.GA4845@kvasir.austin.ibm.com>
References: <20030714101656.73cdb75f.akpm@osdl.org> <3F1347C6.3030105@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1347C6.3030105@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 05:16:06PM -0700, george anzinger wrote:
> I suppose we are going to have a lot of these.  The test calls alarm
> which sets up an itimer for the specified number of seconds and
> returns the number of seconds remaining on the old itimer.  If any
> useconds remain, seconds is boosted by 1.  The test expects the number
> returned to be the same as what was sent, i.e. 1 second wait is
> expected to return 1 second if it is immeadiatly queried.
> 
> The problem with this test is that it assumes that seconds can be
> translated into jiffies with out any error.  Jiffies, however, is now
> defined to be close but not equal to 1/HZ.  In fact, on the x86
> jiffies is 999848 nano seconds.  The conversion of a second with the
> proper round up gives 1001 jiffies and converting this back to seconds
> gives 1.000847848 seconds.  It is this 0.000847848 that is forcing the
> subject test to report a number higher than expected.
> 
> IMHO it is the test that is wrong, not the kernel.

Thanks for your explanation.

The language of the SuSv3[1] seems a little vague:

  If there is a previous alarm() request with time remaining, alarm()
  shall return a non-zero value that is the number of seconds until the
  previous request would have generated a SIGALRM signal.

It leaves open to interpretation the question of what the return value
should be if the delta between calling alarm(1) and alarm(n) is near 0s,
about .5s, and near 1s.  I think the issue can be boiled down to an
implementation choice of floor(delta), round(delta), ceil(delta).

Linux 2.4, Solaris, OpenBSD take the floor() approach.  Running
alarm2.c[2] on them gives results similar to the following; where
'delta' is the difference in microseconds between calling alarm(1) and
alarm(2), and 'ret' is the return value of the alarm(2) call:

t1      t2      delta   ret
------  ------  ------  ------
940284  947913  7629    1
948336  57230   108894  1
57697   266358  208661  1
266826  576979  310153  1
577455  986953  409498  1
987447  497109  509662  1
497576  106690  609114  1
107173  817304  710131  1
817767  626956  809189  1
Alarm clock

That is, even when 809ms have passed between calling alarm(1) and
alarm(2), Linux 2.4/Solaris/OpenBSD report that there is 1s "until the
previous request would have generated a SIGALRM signal."

Since 2.5 is incrementing tv_sec if any tv_usec remain, it is much
closer to taking a ceil() approach: 1.000847848 gets converted to 2,
rather than 1.

I guess the question boils down to: does Linux 2.6 want to make a
different implementation choice than 2.4 and other Unix variants?

----

[1] http://www.opengroup.org/onlinepubs/007904975/functions/alarm.html

[2]

#include <unistd.h>
#include <stdio.h>
#include <sys/time.h>

/* Returns the difference in usecs between now and before.
 */
long delta_t(struct timeval now, struct timeval before)
{
    if (now.tv_sec == before.tv_sec && now.tv_usec >= before.tv_usec) {
        return now.tv_usec - before.tv_usec;
    } else if (now.tv_sec > before.tv_sec) {
        return (now.tv_usec + 1000000) - before.tv_usec;
    }

    return -1;
}

int main(int argc, char **argv)
{
    int i, ret, fails = 0;
    struct timeval t1, t2;

    printf("t1\tt2\tdelta\tret\n------\t------\t------\t------\n");

    for (i = 0; ; i += 100000) {
        gettimeofday(&t1, NULL);

        alarm(1);
        usleep(i);
        ret = alarm(2);

        gettimeofday(&t2, NULL);

        printf("%li\t%li\t%li\t%i\n", t1.tv_usec,
               t2.tv_usec, delta_t(t2, t1), ret);
    }

    return fails;
}

