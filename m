Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTJNX2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTJNX2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:28:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28413 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261427AbTJNX2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:28:25 -0400
Message-ID: <3F8C8692.5010108@mvista.com>
Date: Tue, 14 Oct 2003 16:28:18 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Marshall <tmarshall@real.com>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: missed itimer signals in 2.6
References: <20031013163411.37423e4e.akpm@osdl.org>
In-Reply-To: <20031013163411.37423e4e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030300080406090300060301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------030300080406090300060301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a modified test.  (If you look at the code, please pay 
attention to the variable g_resolution.)  By setting the itimer twice, 
the second time with an address for what it was, we get the actual 
value used by the kernel for the interval time.  We now print this 
value and use it to modify the expected number of ticks (which we 
print after the old value with the label real).  Here is what I see:

[george@zap bug]$ ./itimertest
resolution: asked for 10000us, got 10998us
i=10, ticks=455 (expected 500 ,real 454), elapsed=5.004475, 
drift=-0.000365
resolution: asked for 20000us, got 20996us
i=20, ticks=239 (expected 250 ,real 238), elapsed=5.019538, 
drift=-0.001491
resolution: asked for 30000us, got 30995us
i=30, ticks=162 (expected 166 ,real 161), elapsed=5.021564, 
drift=-0.000369
resolution: asked for 40000us, got 40993us
i=40, ticks=122 (expected 125 ,real 121), elapsed=5.002560, 
drift=-0.001409
resolution: asked for 50000us, got 50992us
i=50, ticks=99 (expected 100 ,real 98), elapsed=5.048553, drift=-0.000341
[george@zap bug]$ uname -a
Linux zap.mvista.com 2.6.0-test5 #22 SMP Thu Sep 18 14:27:08 PDT 2003 
i686 unknown

Since the actual interval used by the system is a bit larger than what 
was asked for, there will be fewer ticks.

Maybe you could save this code if it is part of a test suite....

george

ps. Comments on my machine/directory name are...:)

Andrew Morton wrote:
> You saw this?
> 
> Begin forwarded message:
> 
> Date: Mon, 13 Oct 2003 14:46:49 -0700
> From: Tom Marshall <tmarshall@real.com>
> To: linux-kernel@vger.kernel.org
> Subject: missed itimer signals in 2.6
> 
> 
> It seems that with the 2.6 kernel, ITIMER_REAL becomes inaccurate when the
> interval is set under about 50ms.  Using a 10ms interval, I get 455 signals
> in five seconds (about 9% loss).  The test machine has virtually no load and
> this is reproducible across machines of varying speeds.  The test
> application is attached.
> 
> Typical output under 2.4.22:
> 
>   i=10, ticks=501 (expected 500), elapsed=5.008537, drift=+0.001468
>   i=20, ticks=251 (expected 250), elapsed=5.019925, drift=+0.000076
>   i=30, ticks=167 (expected 166), elapsed=5.009974, drift=+0.000027
>   i=40, ticks=126 (expected 125), elapsed=5.039981, drift=+0.000020
>   i=50, ticks=101 (expected 100), elapsed=5.049980, drift=+0.000021
> 
> Typical output under 2.6.0-test7:
> 
>   i=10, ticks=455 (expected 500), elapsed=5.003323, drift=-0.453316
>   i=20, ticks=239 (expected 250), elapsed=5.018035, drift=-0.238033
>   i=30, ticks=162 (expected 166), elapsed=5.021115, drift=-0.161113
>   i=40, ticks=122 (expected 125), elapsed=5.001113, drift=-0.121111
>   i=50, ticks=99 (expected 100), elapsed=5.048102, drift=-0.098101
> 
> 
> 
> ------------------------------------------------------------------------
> 
> It seems that with the 2.6 kernel, ITIMER_REAL becomes inaccurate when the
> interval is set under about 50ms.  Using a 10ms interval, I get 455 signals
> in five seconds (about 9% loss).  The test machine has virtually no load and
> this is reproducible across machines of varying speeds.  The test
> application is attached.
> 
> Typical output under 2.4.22:
> 
>   i=10, ticks=501 (expected 500), elapsed=5.008537, drift=+0.001468
>   i=20, ticks=251 (expected 250), elapsed=5.019925, drift=+0.000076
>   i=30, ticks=167 (expected 166), elapsed=5.009974, drift=+0.000027
>   i=40, ticks=126 (expected 125), elapsed=5.039981, drift=+0.000020
>   i=50, ticks=101 (expected 100), elapsed=5.049980, drift=+0.000021
> 
> Typical output under 2.6.0-test7:
> 
>   i=10, ticks=455 (expected 500), elapsed=5.003323, drift=-0.453316
>   i=20, ticks=239 (expected 250), elapsed=5.018035, drift=-0.238033
>   i=30, ticks=162 (expected 166), elapsed=5.021115, drift=-0.161113
>   i=40, ticks=122 (expected 125), elapsed=5.001113, drift=-0.121111
>   i=50, ticks=99 (expected 100), elapsed=5.048102, drift=-0.098101
> 
> 
> 
> ------------------------------------------------------------------------
> 
> /*
>  * test itimer
>  */
> 
> #include <stdlib.h>
> #include <stdio.h>
> 
> #include <unistd.h>
> #include <signal.h>
> #include <sys/time.h>
> #include <time.h>
> 
> #define TEST_INTERVAL_SEC 5
> 
> static inline void
> tv_sub(struct timeval* ptv1, struct timeval* ptv2)
> {
>     ptv1->tv_sec  -= ptv2->tv_sec;
>     ptv1->tv_usec -= ptv2->tv_usec;
>     while (ptv1->tv_usec < 0)
>     {
>         ptv1->tv_sec--;
>         ptv1->tv_usec += 1000*1000;
>     }
> }
> 
> static uint             g_ticks;
> static uint             g_interval;
> static struct timeval   g_now;
> 
> void
> itimer_handler(int sig)
> {
>     g_ticks++;
>     g_now.tv_usec += g_interval*1000;
>     while (g_now.tv_usec > 1000*1000)
>     {
>         g_now.tv_usec -= 1000*1000;
>         g_now.tv_sec++;
>     }
> }
> 
> void
> start_itimer(uint ms)
> {
>     struct timeval tv;
>     struct itimerval val;
> 
>     tv.tv_sec = ms/1000;
>     tv.tv_usec = (ms%1000)*1000;
> 
>     val.it_interval = tv;
>     val.it_value = tv;
> 
>     signal(SIGALRM, itimer_handler);
>     g_ticks = 0;
>     g_interval = ms;
>     gettimeofday(&g_now, NULL);
>     setitimer(ITIMER_REAL, &val, NULL);
> }
> 
> void
> stop_itimer(void)
> {
>     struct timeval tv;
>     struct itimerval val;
> 
>     tv.tv_sec = tv.tv_usec = 0;
>     val.it_interval = tv;
>     val.it_value = tv;
> 
>     setitimer(ITIMER_REAL, &val, NULL);
>     signal(SIGALRM, SIG_DFL);
> }
> 
> int
> main(void)
> {
>     int i;
>     struct timeval tv_start;
>     struct timeval tv_now;
> 
>     char drift_sign;
>     struct timeval tv_drift;
>     struct timeval tv_elapsed;
> 
>     for (i = 10; i <= 50; i += 10)
>     {
>         gettimeofday(&tv_start, NULL);
>         start_itimer(i);
>         do
>         {
>             usleep(1000*1000);
>             gettimeofday(&tv_now, NULL);
>             tv_elapsed = tv_now;
>             tv_sub(&tv_elapsed, &tv_start);
>         } while (tv_elapsed.tv_sec < TEST_INTERVAL_SEC);
>         stop_itimer();
> 
>         if (g_now.tv_sec > tv_now.tv_sec ||
>             (g_now.tv_sec == tv_now.tv_sec &&
>              g_now.tv_usec > tv_now.tv_usec))
>         {
>             drift_sign = '+';
>             tv_drift = g_now;
>             tv_sub(&tv_drift, &tv_now);
>         }
>         else
>         {
>             drift_sign='-';
>             tv_drift = tv_now;
>             tv_sub(&tv_drift, &g_now);
>         }
>         printf("i=%d, ticks=%u (expected %u), elapsed=%ld.%06ld, drift=%c%ld.%06ld\n",
>                 i, g_ticks, (TEST_INTERVAL_SEC*1000/i),
>                 tv_elapsed.tv_sec, tv_elapsed.tv_usec,
>                 drift_sign, tv_drift.tv_sec, tv_drift.tv_usec);
>     }
>     return 0;
> }
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------030300080406090300060301
Content-Type: text/plain;
 name="itimertest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="itimertest.c"

/*
 * test itimer
 */

#include <stdlib.h>
#include <stdio.h>

#include <unistd.h>
#include <signal.h>
#include <sys/time.h>
#include <time.h>

#define TEST_INTERVAL_SEC 5

static inline void
tv_sub(struct timeval* ptv1, struct timeval* ptv2)
{
    ptv1->tv_sec  -= ptv2->tv_sec;
    ptv1->tv_usec -= ptv2->tv_usec;
    while (ptv1->tv_usec < 0)
    {
        ptv1->tv_sec--;
        ptv1->tv_usec += 1000*1000;
    }
}

static uint             g_ticks;
static uint             g_interval;
static struct timeval   g_now;
static struct itimerval g_resolution;

void
itimer_handler(int sig)
{
    g_ticks++;
    // g_now.tv_usec += g_interval*1000;
    g_now.tv_usec += g_resolution.it_interval.tv_usec;
    while (g_now.tv_usec > 1000*1000)
    {
        g_now.tv_usec -= 1000*1000;
        g_now.tv_sec++;
    }
}

void
start_itimer(uint ms)
{
    struct timeval tv;
    struct itimerval val;

    tv.tv_sec = ms/1000;
    tv.tv_usec = (ms%1000)*1000;

    val.it_interval = tv;
    val.it_value = tv;

    signal(SIGALRM, itimer_handler);
    g_ticks = 0;
    g_interval = ms;
    gettimeofday(&g_now, NULL);
    setitimer(ITIMER_REAL, &val, NULL);
    setitimer(ITIMER_REAL, &val, &g_resolution);
}

void
stop_itimer(void)
{
    struct timeval tv;
    struct itimerval val;

    tv.tv_sec = tv.tv_usec = 0;
    val.it_interval = tv;
    val.it_value = tv;

    setitimer(ITIMER_REAL, &val, NULL);
    signal(SIGALRM, SIG_DFL);
}

int
main(void)
{
    int i;
    struct timeval tv_start;
    struct timeval tv_now;

    char drift_sign;
    struct timeval tv_drift;
    struct timeval tv_elapsed;

    for (i = 10; i <= 50; i += 10)
    {
        gettimeofday(&tv_start, NULL);
        start_itimer(i);
	printf("resolution: asked for %dus, got %dus\n", i * 1000, 
	       (int)g_resolution.it_interval.tv_usec);
        do
        {
            usleep(1000*1000);
            gettimeofday(&tv_now, NULL);
            tv_elapsed = tv_now;
            tv_sub(&tv_elapsed, &tv_start);
        } while (tv_elapsed.tv_sec < TEST_INTERVAL_SEC);
        stop_itimer();

        if (g_now.tv_sec > tv_now.tv_sec ||
            (g_now.tv_sec == tv_now.tv_sec &&
             g_now.tv_usec > tv_now.tv_usec))
        {
            drift_sign = '+';
            tv_drift = g_now;
            tv_sub(&tv_drift, &tv_now);
        }
        else
        {
            drift_sign='-';
            tv_drift = tv_now;
            tv_sub(&tv_drift, &g_now);
        }
        printf("i=%d, ticks=%u (expected %u ,real %u), elapsed=%ld.%06ld, drift=%c%ld.%06ld\n",
	       i, g_ticks, (TEST_INTERVAL_SEC*1000/i),
	       (TEST_INTERVAL_SEC*1000*1000 / 
		(int)g_resolution.it_interval.tv_usec),
                tv_elapsed.tv_sec, tv_elapsed.tv_usec,
                drift_sign, tv_drift.tv_sec, tv_drift.tv_usec);
    }
    return 0;
}


--------------030300080406090300060301--

