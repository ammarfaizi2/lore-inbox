Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268503AbUIQJ7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268503AbUIQJ7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUIQJ7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:59:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:7394 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268503AbUIQJ7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:59:24 -0400
X-Authenticated: #17725021
Date: Fri, 17 Sep 2004 11:55:02 +0200
From: Henry Margies <henry.margies@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a problem in timeval_to_jiffies?
Message-Id: <20040917115502.33831479.henry.margies@gmx.de>
In-Reply-To: <4149F56E.50406@mvista.com>
References: <20040909154828.5972376a.henry.margies@gmx.de>
	<20040912163319.6e55fbe6.henry.margies@gmx.de>
	<20040915203039.369bb866.rddunlap@osdl.org>
	<414962DF.5080209@mvista.com>
	<20040916200203.6259e113.henry.margies@gmx.de>
	<4149F56E.50406@mvista.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: %3lz3@K$hA\]+AEANQT9>.M`@Pfo]3I,M,_JWswT5MBOpjXQ'VST8|DGMhkv8j,9Xb%j3jG
 |onl!dcPab\nF3>j.1\:ixCGSM)nHq&UXeDDhN@x^5I
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, first of all I want to show you the output of my program
running on my arm device.

TIMER_INTERVAL          =1000ms
COUNTER                 =1
expected elapsed time   =1000ms
elapsed time            =1010ms and 14ns

TIMER_INTERVAL          =1000ms
COUNTER                 =1
expected elapsed time   =1000ms
elapsed time            =1009ms and 981ns

TIMER_INTERVAL          =1000ms
COUNTER                 =1
expected elapsed time   =1000ms
elapsed time            =1010ms and 12ns

As you can see, it is always about 10ms late. The 14ns, -19ns and
12ns difference are because of latency.

TIMER_INTERVAL          =100ms
COUNTER                 =10
expected elapsed time   =1000ms
elapsed time            =1100ms and 9ns

TIMER_INTERVAL          =100ms
COUNTER                 =10
expected elapsed time   =1000ms
elapsed time            =1099ms and 994ns

TIMER_INTERVAL          =100ms
COUNTER                 =10
expected elapsed time   =1000ms
elapsed time            =1100ms and 8ns

Much more interesting is the output for 10ms timers.

TIMER_INTERVAL          =10ms
COUNTER                 =100
expected elapsed time   =1000ms
elapsed time            =2000ms and 0ns

TIMER_INTERVAL          =10ms
COUNTER                 =100
expected elapsed time   =1000ms
elapsed time            =1999ms and 998ns

TIMER_INTERVAL          =10ms
COUNTER                 =100
expected elapsed time   =1000ms
elapsed time            =2000ms and 3ns


Now, you can maybe see my problem. If I want to write a program
which should just send something every 10ms with the current 2.6
implementation, it will only send something every 20ms. I don't
care about the time between timers that much. But for 10ms
interval timers, I want to have 100 triggered timers within one
second.

The precision of timers can never be better than the size of
one jiffie. But with the old 2.4 solution the maximum deviation
is +/- 10ms, with your solution (the current 2.6 approach) it
is +20ms (for arm platform, where a jiffie size is 10ms).
The bad thing is, that the average deviation for 2.4 kernels is
0ms and for 2.6 kernels 10ms.

I see the problem for x86 architecture, where the size of one
jiffie is 999849ns. That means, that 

jiffie: 0 s0ms 0ns
jiffie: 1 s0ms 999849ns
jiffie: 2 s1ms 999698ns
jiffie: 3 s2ms 999547ns
jiffie: 4 s3ms 999396ns
jiffie: 5 s4ms 999245ns
jiffie: 6 s5ms 999094ns
jiffie: 7 s6ms 998943ns
jiffie: 8 s7ms 998792ns
jiffie: 9 s8ms 998641ns
jiffie: 10 s9ms 998490ns

Right? But for arm, with a jiffie size of 10000000, it is much
more easier. And that is why I don't understand why an one second
interval is converted to 101 jiffies (on arm).


On Thu, 16 Sep 2004 13:19:58 -0700
George Anzinger <george@mvista.com> wrote:

> [...] However, the standard seems to
> say that what you should measure is the expected arrival time
> (i.e. assume zero latency).  In this case the standard calls
> for timers NEVER to be early.

I agree. But then, why adding one jiffie to every interval? If
there is no latency, the timer should appear right at the
beginning of a jiffie. For x86 you are right, because 10 jiffies
are less then 10ms. But for arm, 1 jiffie is precisely 10ms. 


> > So, what about adding this rounding value just to it_value to
> > guarantee that the first occurrence is in it least this time?
> 
> The it_value and the it_interval are, indeed, computed
> differently.  The it_value needs to have 1 additional
> resolution size period added to it to account for the initial
> time starting between ticks.  The it_interval does not have
> this additional period added to it.  Both values, however, are
> first rounded up to the next resolution size value.

Ok, I will have a closer look to the rounding. Maybe it is just
not working for arm.

Please, can you send me your test application?

Best regards,

Henry

-- 

Hi! I'm a .signature virus! Copy me into your
~/.signature to help me spread!

