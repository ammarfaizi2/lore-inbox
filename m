Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <156375-17165>; Thu, 3 Dec 1998 09:31:51 -0500
Received: from chiara.csoma.elte.hu ([157.181.71.18]:25399 "EHLO chiara.csoma.elte.hu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <156391-17165>; Thu, 3 Dec 1998 06:39:16 -0500
Date: Thu, 3 Dec 1998 14:53:26 +0100 (CET)
From: MOLNAR Ingo <mingo@chiara.csoma.elte.hu>
Reply-To: MOLNAR Ingo <mingo@chiara.csoma.elte.hu>
To: Colin Plumb <colin@nyx.net>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: Linux timekeeping plans
In-Reply-To: <199812030607.XAA12107@nyx10.nyx.net>
Message-ID: <Pine.LNX.3.96.981203143111.20781A-100000@chiara.csoma.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


On Wed, 2 Dec 1998, Colin Plumb wrote:

> The one thing that I'm still stuck on is SMP issues.  While it appears
> that the TSC counters are kept synchronized by current SMP PC hardware,
> this is not guaranteed, and other processors probably behave differently.

on PC SMP hardware you can take this as guaranteed. If anything breaks
this, we will fix it up during SMP initialization.

> Currently, as I understand it, external interrupts are delivered to one
> processor, but how that processor is chosen is undefined.  It may or
> may not be the same processor that received the last instance of that
> external interrupt.  And in particular, there is no guarantee that a
> particular processor will ever see a particular external interrupt.

exactly.

> This makes generating a single systemwide clock a bit tricky.  Some
> inter-processor interrupts will definitely be required, but I don't
> know if I can create a special one for timekeeping purposes.
> Can I create a broadcast interrupt which all processors use for
> timekeeping?

this timekeeping architecture is already in place. The concept is: all
processors have a 'local' interrupt, which is used for profiling, process
time accounting and process timeslice rescheduling. And there is a global
external interrupt that expires timers.

> The one tricky thing about interrupts is that they can be delayed.
> Rather a lot, in fact.  Fortunately, they can never arrive early,
> so in the case of inter-processor synchronization, there's an easy
> fix.  If I suspect that processor 2's clock is fast relative to
> processor 1, I have processor 2 send an interrupt to processor 1.
> Each processor keeps track of the time of the interrupt.  If the
> time that processor 1 thinks it arrived is before the time that
> processor 2 thinks it sent it, then there is definitely an error.

you can safely assume that there is globally valid TSC on SMP systems. 
(last i checked this was true for all SMP Intel, Alpha and Sparc systems) 
If you use cli/sti you can make any readout of the TSC value and the timer
tick counter atomic. 

-- mingo


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
