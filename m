Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282861AbRLRDGK>; Mon, 17 Dec 2001 22:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282859AbRLRDF7>; Mon, 17 Dec 2001 22:05:59 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:24336 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282861AbRLRDFq>; Mon, 17 Dec 2001 22:05:46 -0500
Date: Mon, 17 Dec 2001 19:08:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112171825460.2108-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0112171849490.1577-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Linus Torvalds wrote:

> Quite frankly, I'd be a _lot_ more interested in making the scheduling
> slices _shorter_ during 2.5.x, and go to a 1kHz clock on x86 instead of a
> 100Hz one, _despite_ the fact that it will increase scheduling load even
> more. Because it improves interactive feel, and sometimes even performance
> (ie being able to sleep for shorter sequences of time allows some things
> that want "almost realtime" behaviour to avoid busy-looping for those
> short waits - improving performace exactly _because_ they put more load on
> the scheduler).

I'm ok with increasing HZ but not so ok with decreasing time slices.
When you switch a task you've a fixed cost ( tlb, cache image,... ) that,
if you decrease the time slice, you're going to weigh with a lower run time
highering its percent impact.
The more interactive feel can be achieved by using a real BVT
implementation :

-            p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+            p->counter += NICE_TO_TICKS(p->nice);

The only problem with this is that, with certain task run patterns,
processes can run a long time ( having an high dynamic priority ) before
they get scheduled.
What i was thinking was something like, in timer.c :

        if (p->counter > decay_ticks)
            --p->counter;
        else if (++p->timer_ticks >= MAX_RUN_TIME) {
            p->counter -= p->timer_ticks;
            p->timer_ticks = 0;
            p->need_resched = 1;
        }

Having MAX_RUN_TIME ~= NICE_TO_TICKS(0)
In this way I/O bound tasks can run with high priority giving a better
interactive feel, w/out running too much freezing the system when exiting
from a quite long I/O wait.




- Davide


