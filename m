Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUIPDby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUIPDby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 23:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUIPDby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 23:31:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:42628 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267403AbUIPDbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 23:31:46 -0400
Date: Wed, 15 Sep 2004 20:30:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Henry Margies <henry.margies@gmx.de>
Cc: linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: Is there a problem in timeval_to_jiffies?
Message-Id: <20040915203039.369bb866.rddunlap@osdl.org>
In-Reply-To: <20040912163319.6e55fbe6.henry.margies@gmx.de>
References: <20040909154828.5972376a.henry.margies@gmx.de>
	<20040912163319.6e55fbe6.henry.margies@gmx.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 16:33:19 +0200 Henry Margies wrote:

| Hello
| 
| Why is nobody answering my question? I tested my application also on
| x86. The result is the same. For me, it looks like there is a problem.
| The only difference is, that my x86 has a TICK value of 1ms and my arm
| device a value of 10ms
| 
| Imagine, there are 3 timers. 
| 
| timer1 is for 1s,
| timer2 is for 0.1s,
| timer3 is for 0.01s.
| 
| Now, timer1 should finish after 10 times of timer2 and 100 times of
| timer3. But this is not, because every interval is 1ms (10ms on arm)
| longer than it should be.
| 
| (on x86)
| timer1 finishes after 1001ms,
| timer2 after 10*101ms = 1010ms,
| timer3 after 100*11ms = 1100ms 
| 
| (on arm)
| timer1 finishes after 1010ms,
| timer2 after 10*110ms = 1100ms,
| timer3 after 100*20ms = 2000ms!!! 
| 
| The output of my test application is the following on x86:
| 
| (timer1)
| TIMER_INTERVAL          =1000ms
| COUNTER                 =1
| expected elapsed time   =1000ms
| elapsed time            =1000ms and 845ns
| 
| (timer2)
| TIMER_INTERVAL          =100ms
| COUNTER                 =10
| expected elapsed time   =1000ms
| elapsed time            =1010ms and 29ns
| 
| (timer3)
| TIMER_INTERVAL          =10ms
| COUNTER                 =100
| expected elapsed time   =1000ms
| elapsed time            =1099ms and 744ns
| 
| 
| Please have a look into my test application:
| 
| void sig_alarm(int i)
| {
|         struct timeval tv;
| 
|         gettimeofday(&tv, NULL);
| 
|         if (c>=COUNTER) {
|                 int elapsed;
|                 c = 0;
|                 elapsed = (tv.tv_sec-start.tv_sec)*1000000
|                         + tv.tv_usec-start.tv_usec;
| 
|                 printf( "TIMER_INTERVAL         =%dms\n"
|                         "COUNTER                =%d\n"
|                         "expected elapsed time  =%dms\n",
|                         TIMER_INTERVAL,
|                         COUNTER,
|                         TIMER_INTERVAL*COUNTER);
| 
|                 printf("elapsed time            =%dms and %dns\n\n\n",
|                                 elapsed/1000, elapsed%1000);
| 
|         }
| 
|         if (!c) 
|                 start = tv;
| 
|         c++;
| 
| }
| 
| int main()
| {
|         struct itimerval itimer;
| 
|         itimer.it_interval.tv_sec = 0;
|         itimer.it_interval.tv_usec= TIMER_INTERVAL*1000;
| 
|         itimer.it_value.tv_sec = 0;
|         itimer.it_value.tv_usec= TIMER_INTERVAL*1000;
| 
|         signal(SIGALRM, sig_alarm);
| 
|         setitimer(ITIMER_REAL, &itimer, NULL);
| 
|         getc(stdin);
| 
|         return 0;
| }
| 
| 
| As I wrote, I think the problem is in timeval_to_jiffies. On my arm
| device 10ms are converted to 20ticks. On x86, 10ms are converted to
| 11ticks.
| 
| Can somebody agree on that or at least point me to my mistakes?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I agree that timeval_to_jiffies() has some serious rounding errors.
I don't see why it even cares about any of the scaled math in the
(inline) function.  I rewrote it (for userspace, not kernelspace)
like so, with expected results:


static __inline__ unsigned long
tv_to_jifs(const struct timeval *value)
{
        unsigned long sec = value->tv_sec;
        long usec = value->tv_usec;

        if (sec >= MAX_SEC_IN_JIFFIES){
                sec = MAX_SEC_IN_JIFFIES;
                usec = 0;
        }
        return (((u64)sec * (u64)HZ) +
                (((u64)usec + (u64)HZ - 1LL) / (unsigned long)HZ));
}


Results of timeval_to_jiffies() compared to tv_to_jifs() [small sample]:
(tv_sec is fixed at 5, with tv_usec varying)

                         +--- timeval_to_jiffies()
                         V              v--- tv_to_jifs()
tv_usec: 499000,     jifs: 5500,     jf2: 5499
tv_usec: 499100,     jifs: 5500,     jf2: 5500
tv_usec: 499900,     jifs: 5501,     jf2: 5500
tv_usec: 500000,     jifs: 5501,     jf2: 5500
tv_usec: 500100,     jifs: 5501,     jf2: 5501
tv_usec: 500900,     jifs: 5502,     jf2: 5501
tv_usec: 501000,     jifs: 5502,     jf2: 5501
tv_usec: 501100,     jifs: 5502,     jf2: 5502
tv_usec: 501900,     jifs: 5503,     jf2: 5502
tv_usec: 502000,     jifs: 5503,     jf2: 5502
tv_usec: 502100,     jifs: 5503,     jf2: 5503



I think that tv_to_jifs() can be written for kernel use by using
do_div(), but I haven't tried that yet.

--
~Randy
