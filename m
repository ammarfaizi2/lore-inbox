Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314908AbSDVXIM>; Mon, 22 Apr 2002 19:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314916AbSDVXIL>; Mon, 22 Apr 2002 19:08:11 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:11464 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314908AbSDVXH4>;
	Mon, 22 Apr 2002 19:07:56 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15556.38775.439624.762586@argo.ozlabs.ibm.com>
Date: Tue, 23 Apr 2002 09:06:31 +1000 (EST)
To: Robert Love <rml@tech9.net>
Cc: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: in_interrupt race
In-Reply-To: <1019512494.1465.5.camel@phantasy>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:

> We have two cases: 
> 
> (a) we are in an interrupt or softirq, 
> (b) we are not in an interrupt or softirq. 
> 
> If (a), we are not preemptible and thus do _not_ need explicit
> preemption disabling.

True.

> If (b) we are preemptible, and then it does not matter what happens
> during this check, since we are not preemptible and the check won't
> return a false true.

Huh?  First you say we are preemptible, then you say we are not, in
the same sentence?

> Now, if we are actually using in_interrupt() as "is this exact CPU
> processing an interrupt?" we may not get what we want (because we could
> end up on CPU#2 from #1, and now #1 is indeed in an interrupt).  But
> that is rarely (if ever?) the point of the call.
> 
> The majority, if not all, uses of in_interrupt is to see if you entered
> the current code from an interrupt.  Like in schedule, "did we enter
> this function off an interrupt?"  Thus, with or without preemption:
> 
> 	if (in_interrupt())
> 		/* yep! */
> 
> will _always_ return false if your current CPU is not in an interrupt. 

No.  The point is that in_interrupt() asks two separate questions:
(1) which cpu are we on?  (2) is that cpu in interrupt context?
If we switch cpus between (1) and (2) then we can get a false positive
from in_interrupt().

> This says nothing of the CPU you may of been on, but then who cares
> about it?

We don't care about any cpu, what we want to know is whether the
current thread of execution is in process context or not.  Which is
why it is bogus for in_interrupt to need to ask which cpu we are on,
and why the local_bh_count and local_irq_count should go in the
thread_info struct IMHO.  I am working on that now. :)

Paul.
