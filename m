Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSCPK15>; Sat, 16 Mar 2002 05:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310219AbSCPK1r>; Sat, 16 Mar 2002 05:27:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31950 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S310214AbSCPK1k>;
	Sat, 16 Mar 2002 05:27:40 -0500
Date: Sat, 16 Mar 2002 10:23:21 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Joe Korty <joe.korty@ccur.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
In-Reply-To: <200203152214.WAA27958@rudolph.ccur.com>
Message-ID: <Pine.LNX.4.44.0203161009270.2866-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Mar 2002, Joe Korty wrote:

> >> It is an idle cpu that is spending those 200 cycles.
> > 
> > wrong. When it's woken up it's *not* an idle CPU anymore, and it's the
> > freshly woken up task that is going to execute 200 cycles later...
> 
> I have to disagree.  It is the woken up task *running on the otherwise
> idle CPU* that burns up 200 cycles at the tail.

what do you disagree with? It's a fact that any overhead added to the
idle-wakeup path is not 'idle time' but adds latency (overhead) to the
freshly woken up task's runtime.

> A cpu is wasting, say, 5,000,000 cycles (1GHz/100/2, or 1/2 tick) in hlt
> when it could have been doing work.  Why worry about an alternative
> wakeup path that burns up 200-400 cycles of that on the otherwise idling
> cpu, even if it is at the tail.

it's *not* idle time, it's naive to think that "it's in the idle task, so
it must be idle time". Latency added to the idle-wakeup shows up as direct
overhead in the woken up task. Lets look at an example, CPU0 is waking up
bdflush that will run on CPU1, CPU1 is idle currently:

         CPU0                           CPU1
         [wakeup bdflush]
         [send IPI]
                    [... IPI delivery latency ...]
                                        [IRQ entry/exit]
                                        [idle thread context switches]
                                        [bdflush runs on CPU1]

contrasted with the idle=poll situation:

         CPU0                           CPU1
         [wakeup bdflush]
         [set need_resched]
                                        [idle thread context switches]
                                        [bdflush runs on CPU1]

as you can see, the overhead of 'send IPI', 'IPI delivery' and 'IRQ
entry/exit' delays bdflush.  Even assuming that sending and receiving an
IPI is as fast as setting & detecting need_resched [which it theoretically
can be], the IPI variant still has the cost of IRQ entry (and exit), which
is 200 cycles only optimistically, it's more like thousands of cycles on a
GHZ box.

[ as mentioned before, the default idle method has power saving advantages
(even if it's not HLT, some of the better methods do save considerable
amount of power), but idle=poll is clearly an option for the truly
performance-sensitive applications. ]

	Ingo

