Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUIPJyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUIPJyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUIPJyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:54:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6136 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267882AbUIPJyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:54:44 -0400
Message-ID: <414962DF.5080209@mvista.com>
Date: Thu, 16 Sep 2004 02:54:39 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Henry Margies <henry.margies@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Is there a problem in timeval_to_jiffies?
References: <20040909154828.5972376a.henry.margies@gmx.de>	<20040912163319.6e55fbe6.henry.margies@gmx.de> <20040915203039.369bb866.rddunlap@osdl.org>
In-Reply-To: <20040915203039.369bb866.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Sun, 12 Sep 2004 16:33:19 +0200 Henry Margies wrote:
> 
> | Hello
> | 
> | Why is nobody answering my question? I tested my application also on
> | x86. The result is the same. For me, it looks like there is a problem.
> | The only difference is, that my x86 has a TICK value of 1ms and my arm
> | device a value of 10ms

You, I think, send a bug report.  I replied via bugz.  The open question is what 
value your particular arm platform is using for CLOCK_TICK_RATE.  See below.
> | 
> | Imagine, there are 3 timers. 
> | 
> | timer1 is for 1s,
> | timer2 is for 0.1s,
> | timer3 is for 0.01s.
> | 
> | Now, timer1 should finish after 10 times of timer2 and 100 times of
> | timer3. But this is not, because every interval is 1ms (10ms on arm)
> | longer than it should be.

Timers are constrained by the standard to NEVER finish early.  This means that, 
in order to account for the timer starting between two jiffies, an extra jiffie 
needs to be added to the value.  This will cause a timer to expire sometime 
between the value asked for and that value + the resolution.  The resolution is 
roughly 1/HZ, but this value is not exact.  For example, in the 2.6 x86 kernel 
the CLOCK_TICK_RATE constrains the resolution (also the tick size) for HZ=1000 
to be 999849 nanoseconds.  With a tick of this size the best we can do with each 
of these values is:
.01s 10.998ms
.1s  100.9847ms
1s   1000.8488ms
> | 
> | (on x86)
> | timer1 finishes after 1001ms,
> | timer2 after 10*101ms = 1010ms,
> | timer3 after 100*11ms = 1100ms 
> | 
> | (on arm)
> | timer1 finishes after 1010ms,
> | timer2 after 10*110ms = 1100ms,
> | timer3 after 100*20ms = 2000ms!!! 
> | 
> | The output of my test application is the following on x86:
> | 
> | (timer1)
> | TIMER_INTERVAL          =1000ms
> | COUNTER                 =1
> | expected elapsed time   =1000ms
> | elapsed time            =1000ms and 845ns
1000.8488 expected  That number looks a few nanoseconds too small.
> | 
> | (timer2)
> | TIMER_INTERVAL          =100ms
> | COUNTER                 =10
> | expected elapsed time   =1000ms
> | elapsed time            =1010ms and 29ns
10 * 100.9847ms is 1009.847ms  Looks good.
> | 
> | (timer3)
> | TIMER_INTERVAL          =10ms
> | COUNTER                 =100
> | expected elapsed time   =1000ms
> | elapsed time            =1099ms and 744ns
100 * 10.998ms is 1099.8  This also looks good.
> | 
> | 
> | Please have a look into my test application:
> | 
> | void sig_alarm(int i)
> | {
> |         struct timeval tv;
> | 
> |         gettimeofday(&tv, NULL);
> | 
> |         if (c>=COUNTER) {
> |                 int elapsed;
> |                 c = 0;
> |                 elapsed = (tv.tv_sec-start.tv_sec)*1000000
> |                         + tv.tv_usec-start.tv_usec;
> | 
> |                 printf( "TIMER_INTERVAL         =%dms\n"
> |                         "COUNTER                =%d\n"
> |                         "expected elapsed time  =%dms\n",
> |                         TIMER_INTERVAL,
> |                         COUNTER,
> |                         TIMER_INTERVAL*COUNTER);
> | 
> |                 printf("elapsed time            =%dms and %dns\n\n\n",
> |                                 elapsed/1000, elapsed%1000);
> | 
> |         }
> | 
> |         if (!c) 
> |                 start = tv;
> | 
> |         c++;
> | 
> | }
> | 
> | int main()
> | {
> |         struct itimerval itimer;
> | 
> |         itimer.it_interval.tv_sec = 0;
> |         itimer.it_interval.tv_usec= TIMER_INTERVAL*1000;
> | 
> |         itimer.it_value.tv_sec = 0;
> |         itimer.it_value.tv_usec= TIMER_INTERVAL*1000;
> | 
> |         signal(SIGALRM, sig_alarm);
> | 
> |         setitimer(ITIMER_REAL, &itimer, NULL);
> | 
> |         getc(stdin);
> | 
> |         return 0;
> | }
> | 
> | 
> | As I wrote, I think the problem is in timeval_to_jiffies. On my arm
> | device 10ms are converted to 20ticks. On x86, 10ms are converted to
> | 11ticks.
For the x86 this is correct as 10 ticks would be 9.99849 ms which is less than 
the asked for 10ms.  As to the ARM, we need to know the CLOCK_TICK_RATE.  This 
is used to determine the actual tick size using the following:

#define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
#define SH_DIV(NOM,DEN,LSH) (	((NOM / DEN) << LSH)			\
			     + (((NOM % DEN) << LSH) + DEN / 2) / DEN)

/* HZ is the requested value. ACTHZ is actual HZ ("<< 8" is for accuracy) */
#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))
/* TICK_NSEC is the time between ticks in nsec assuming real ACTHZ and	*/
#define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))

TICK_NSEC is then used in the conversion code.

> | 
> | Can somebody agree on that or at least point me to my mistakes?
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I agree that timeval_to_jiffies() has some serious rounding errors.
> I don't see why it even cares about any of the scaled math in the
> (inline) function.  I rewrote it (for userspace, not kernelspace)
> like so, with expected results:
> 
What you are missing here is that the tick size for HZ=1000 is 999849 nano 
seconds.  THIS is why the scaled math was done.
> 
> static __inline__ unsigned long
> tv_to_jifs(const struct timeval *value)
> {
>         unsigned long sec = value->tv_sec;
>         long usec = value->tv_usec;
> 
>         if (sec >= MAX_SEC_IN_JIFFIES){
>                 sec = MAX_SEC_IN_JIFFIES;
>                 usec = 0;
>         }
>         return (((u64)sec * (u64)HZ) +
>                 (((u64)usec + (u64)HZ - 1LL) / (unsigned long)HZ));
> }
> 
> 
> Results of timeval_to_jiffies() compared to tv_to_jifs() [small sample]:
> (tv_sec is fixed at 5, with tv_usec varying)
> 
>                          +--- timeval_to_jiffies()
>                          V              v--- tv_to_jifs()
> tv_usec: 499000,     jifs: 5500,     jf2: 5499
> tv_usec: 499100,     jifs: 5500,     jf2: 5500
> tv_usec: 499900,     jifs: 5501,     jf2: 5500
> tv_usec: 500000,     jifs: 5501,     jf2: 5500
> tv_usec: 500100,     jifs: 5501,     jf2: 5501
> tv_usec: 500900,     jifs: 5502,     jf2: 5501
> tv_usec: 501000,     jifs: 5502,     jf2: 5501
> tv_usec: 501100,     jifs: 5502,     jf2: 5502
> tv_usec: 501900,     jifs: 5503,     jf2: 5502
> tv_usec: 502000,     jifs: 5503,     jf2: 5502
> tv_usec: 502100,     jifs: 5503,     jf2: 5503
> 
> 
> 
> I think that tv_to_jifs() can be written for kernel use by using
> do_div(), but I haven't tried that yet.

do_div() (or any div) is very expensive.  The scaled math is much faster and 
retains all the precision we need.  The errors are in the 2 digits of parts per 
billion (like 55 ppb).
> 
If you would like I could send you the test code I used to test the conversion 
functions.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

