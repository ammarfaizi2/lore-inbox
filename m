Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314824AbSDVV4A>; Mon, 22 Apr 2002 17:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314832AbSDVVz6>; Mon, 22 Apr 2002 17:55:58 -0400
Received: from zero.tech9.net ([209.61.188.187]:59659 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314824AbSDVVyt>;
	Mon, 22 Apr 2002 17:54:49 -0400
Subject: Re: in_interrupt race
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <3CC48321.5855B08A@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 17:54:53 -0400
Message-Id: <1019512494.1465.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-22 at 17:39, george anzinger wrote: 

> Robert Love wrote:
> > Or perhaps leave the code as-is but make the rule preemption needs to be
> > disabled before calling (either implicitly or explicitly).  I.e., via a
> > call to preempt_disable or because interrupts are disabled, a lock is
> > held, etc ...
> 
> Right, getting a consistant flag is not much use if it isn't used within
> the same context.

Oh, wait ... someone clue me in to what I am missing, but the context
does not matter - in fact, we do not need even my fix. 

We have two cases: 

(a) we are in an interrupt or softirq, 
(b) we are not in an interrupt or softirq. 

If (a), we are not preemptible and thus do _not_ need explicit
preemption disabling.

If (b) we are preemptible, and then it does not matter what happens
during this check, since we are not preemptible and the check won't
return a false true.

Now, if we are actually using in_interrupt() as "is this exact CPU
processing an interrupt?" we may not get what we want (because we could
end up on CPU#2 from #1, and now #1 is indeed in an interrupt).  But
that is rarely (if ever?) the point of the call.

The majority, if not all, uses of in_interrupt is to see if you entered
the current code from an interrupt.  Like in schedule, "did we enter
this function off an interrupt?"  Thus, with or without preemption:

	if (in_interrupt())
		/* yep! */

will _always_ return false if your current CPU is not in an interrupt. 
This says nothing of the CPU you may of been on, but then who cares
about it?

	Robert Love

