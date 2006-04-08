Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWDHE0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWDHE0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 00:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWDHE0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 00:26:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:59318 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965013AbWDHE0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 00:26:49 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RT task scheduling
Date: Fri, 7 Apr 2006 21:28:35 -0700
User-Agent: KMail/1.8.3
Cc: Bill Huey <billh@gnuppy.monkey.org>, Darren Hart <dvhltc@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200604052025.05679.darren@dvhart.com> <20060407233631.GA17574@gnuppy.monkey.org> <1144465282.30689.62.camel@localhost.localdomain>
In-Reply-To: <1144465282.30689.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072128.36868.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 20:01, Steven Rostedt wrote:
> Hi Bill,
>
> I'm just catching up on this thread.  Is your main concern that a High
> prio task is going to be unnecessary delayed because there's a lower RT
> task on the same CPU and time is needed to push it off to another CPU?
> It's late, so forgive me if this is a stupid question ;)

What I have gathered from this thread is that there are two important (and 
partially conflicting) requirements for better real-time support.

1) Deterministic scheduling algorithms (SWSRPS).  Basically, with uniprocessor 
systems (or smp with a global run queue), it was really easy to say, run the 
highest priority task in the queue.  But when there are several queues that 
are independent of each other, it is difficult.  According to SWSRPS, nr_cpus 
highest priority runnable tasks should _always_ be running (regardless of 
which queue they are on).  This might mean that there are longer latencies a) 
to determine the nr_cpus highest priority tasks and b) because of cache 
issues.

2) Maximum deterministic latency.  A task should be able to say that if it 
relinquishes the processor for now, MAX_LATENCY nanoseconds (or ticks or 
whatever you want to measure time in) later, it will be back in time to meet 
a deadline.

As I understand it, real time is all about determinism.  But there are several 
places where we have to focus on determinism to make it all behave as it 
should.

Priority A > B > C
If a lower priority task C gets run just because it is the highest in that 
CPU's run queue while there is a higher priority task B is sleeping while A 
runs (on a 2 proc system), this is WRONG.  But then again, we need to make 
sure that we can determine the maximum latency to preempt C to run B and try 
to minimize that.

Poof!  More smoke in the air.  I hope that clears it up.

--Vernon

> On Fri, 2006-04-07 at 16:36 -0700, Bill Huey wrote:
> > > Has this cleared some things up?  If not, let me know what else needs
> > > clarification.
> >
> > Yes, but you should really work to clarify terminology. Is this better ?
>
> Goes both ways :)
>
> -- Steve
>
> PS. It's really good to see you back on LKML.  I've missed your posts.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
