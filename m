Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUILOhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUILOhV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 10:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUILOhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 10:37:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:8683 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268065AbUILOhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 10:37:15 -0400
X-Authenticated: #17725021
Date: Sun, 12 Sep 2004 16:33:19 +0200
From: Henry Margies <henry.margies@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a problem in timeval_to_jiffies?
Message-Id: <20040912163319.6e55fbe6.henry.margies@gmx.de>
In-Reply-To: <20040909154828.5972376a.henry.margies@gmx.de>
References: <20040909154828.5972376a.henry.margies@gmx.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


Why is nobody answering my question? I tested my application also on
x86. The result is the same. For me, it looks like there is a problem.
The only difference is, that my x86 has a TICK value of 1ms and my arm
device a value of 10ms

Imagine, there are 3 timers. 

timer1 is for 1s,
timer2 is for 0.1s,
timer3 is for 0.01s.

Now, timer1 should finish after 10 times of timer2 and 100 times of
timer3. But this is not, because every interval is 1ms (10ms on arm)
longer than it should be.

(on x86)
timer1 finishes after 1001ms,
timer2 after 10*101ms = 1010ms,
timer3 after 100*11ms = 1100ms 

(on arm)
timer1 finishes after 1010ms,
timer2 after 10*110ms = 1100ms,
timer3 after 100*20ms = 2000ms!!! 

The output of my test application is the following on x86:

(timer1)
TIMER_INTERVAL          =1000ms
COUNTER                 =1
expected elapsed time   =1000ms
elapsed time            =1000ms and 845ns

(timer2)
TIMER_INTERVAL          =100ms
COUNTER                 =10
expected elapsed time   =1000ms
elapsed time            =1010ms and 29ns

(timer3)
TIMER_INTERVAL          =10ms
COUNTER                 =100
expected elapsed time   =1000ms
elapsed time            =1099ms and 744ns


Please have a look into my test application:

void sig_alarm(int i)
{
        struct timeval tv;

        gettimeofday(&tv, NULL);

        if (c>=COUNTER) {
                int elapsed;
                c = 0;
                elapsed = (tv.tv_sec-start.tv_sec)*1000000
                        + tv.tv_usec-start.tv_usec;

                printf( "TIMER_INTERVAL         =%dms\n"
                        "COUNTER                =%d\n"
                        "expected elapsed time  =%dms\n",
                        TIMER_INTERVAL,
                        COUNTER,
                        TIMER_INTERVAL*COUNTER);

                printf("elapsed time            =%dms and %dns\n\n\n",
                                elapsed/1000, elapsed%1000);

        }

        if (!c) 
                start = tv;

        c++;

}

int main()
{
        struct itimerval itimer;

        itimer.it_interval.tv_sec = 0;
        itimer.it_interval.tv_usec= TIMER_INTERVAL*1000;

        itimer.it_value.tv_sec = 0;
        itimer.it_value.tv_usec= TIMER_INTERVAL*1000;

        signal(SIGALRM, sig_alarm);

        setitimer(ITIMER_REAL, &itimer, NULL);

        getc(stdin);

        return 0;
}


As I wrote, I think the problem is in timeval_to_jiffies. On my arm
device 10ms are converted to 20ticks. On x86, 10ms are converted to
11ticks.

Can somebody agree on that or at least point me to my mistakes?

Thx in advance,

Henry

-- 

Hi! I'm a .signature virus! Copy me into your
~/.signature to help me spread!

