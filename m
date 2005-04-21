Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVDUPfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVDUPfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVDUPfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:35:22 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:28545 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261446AbVDUPe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:34:58 -0400
Subject: Re: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer
	behavior in 2.6 vs 2.4  (1 extra tick)]
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, jdavis@accessline.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0504210752560.2344@ppc970.osdl.org>
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
	 <1114052315.5058.13.camel@localhost.localdomain>
	 <1114054816.5996.10.camel@localhost.localdomain>
	 <20050421095109.A25431@flint.arm.linux.org.uk>
	 <1114080708.5996.16.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504210752560.2344@ppc970.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 21 Apr 2005 11:34:34 -0400
Message-Id: <1114097674.5996.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 07:58 -0700, Linus Torvalds wrote:
> 
> On Thu, 21 Apr 2005, Steven Rostedt wrote:
> > 
> > Thanks, I forgot about the guarantee of "at least" the time requested.
> > I took this on because I noticed this in a driver I wrote. With the user
> > passing in a timeval for a periodic condition. I noticed that this would
> > drift quite a bit.
> 
> Your user is doing things wrong. If he wants a non-drifting clock, he 
> should look at _realtime_ and then always re-calculate the "how long do I 
> want to sleep" from that. Because even if the kernel was able to do all 
> offsets with nanosecond precision and wake you up _exactly_, you'd still 
> be drifting because of the time spent in between calls (and scheduling 
> events etc).
> 

It's even stranger than this.  I'm working on a custom kernel for a
customer based off of Ingo's RT patches. They want to be able to make a
process run for a percentage of the CPU. So you can make a process run
10 jiffies out of every 100. Using Ingo's RT patch helps to keep the
latencies down from interrupts.


> >	 I guess I need to write my own timeval_to_jiffies
> > conversion so that i remove the added jiffy. For this case, I actually
> > want a true rounded value to the closest jiffy.
> 
> No, if you're looking at reliable wall-clock time, you really need to use
> wall-clock, not successive time offsets. The time offsets will always
> drift: you can make the drift small enough that your particular
> application doesn't happen to care (or, quite often - make it drift in a
> _direction_ you don't happen to care about), but it's still wrong.
> 

The customer understands that the precision would be in jiffies, and
hopefully better, when/if I can get the high res timers patch working
with this as well.  The problem arises with the API using timeval to
determine the percentage and period. With the added jiffy, the
calculations are wrong.
  
> If you calculate the expected timeout from the time-of-day in the caller,
> your drift not only goes away, but you'll actually be able to handle 
> things like "oops, the machine is under load so I missed an event".
> 

Hopefully there is never a missed event (this is checked for though),
since the process would be running at the highest priority. It's OK for
the process to come in late, as long as it runs the required amount
within the given period.

> Yes, it gets slightly more complicated (and a _lot_ more complicated if
> your app needs to do something special for the missed case, like dropping
> data and re-syncing, which is common in things like video or sound
> streaming), but the fact is, it's just the right thing to do.

This project is much more complicated than what I've mentioned here, but
it shows what I need. Currently we are using jiffies as the timer, but
eventually we will be using a better source and the whole
timeval_to_jiffies conversion wouldn't matter.

-- Steve

