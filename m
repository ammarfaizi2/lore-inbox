Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135179AbRDLNPZ>; Thu, 12 Apr 2001 09:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135185AbRDLNPF>; Thu, 12 Apr 2001 09:15:05 -0400
Received: from anarchy.io.com ([199.170.88.101]:30795 "EHLO anarchy.io.com")
	by vger.kernel.org with ESMTP id <S135179AbRDLNO5>;
	Thu, 12 Apr 2001 09:14:57 -0400
Date: Thu, 12 Apr 2001 08:14:54 -0500 (CDT)
From: Bret Indrelee <bret@io.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer!
Message-ID: <Pine.LNX.4.21.0104120814220.6650-100000@eris.io.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Mark Salisbury wrote:
> On Wed, 11 Apr 2001, Bret Indrelee wrote:
> > Current generation PCs can easily handle 1000s of
> > interrupts a second if you keep the overhead small.
> 
> the PC centric implementation of the ticked system is one of its major flaws.
> 
> there are architectures which the cost of a fixed interval is the same as a
> variable interval, i.e. no reload register, so you must explicitely load a
> value each interrupt anyway. and if you want accurate intervals, you must
> perform a calculation each reload, and not just load a static value, because
> you don't know how many cycles it took from the time the interrupt happened
> till you get to the reload line because the int may have been masked or lower
> pri than another interrupt.

People were saying the cost of adjusting the PIT was high.

On those archs where this is true, you would want to avoid changing the
interval timer.

On a more reasonable architechure, you would change it each time the head
of the timer list changed.

> also, why handle 1000's of interrupts if you only need to handle 10?

There is no reason.

I was pointing out that current hardware can easily handle this sort of
load, not advocating that distributions change HZ to 1000.


On Linux 2.2, if you change HZ to 400 your system is going to run at
about 70% of speed. The thing is it is limited to this value, bumping it
any higher doesn't cause a change.

If you reprogram the RTC to generate a 1000 HZ interrupt pulse, as I 
recall there is about a 3% change in performance. This is with a constant
rate interrupt, making it variable rate would reduce this.

You can verify this yourself. Get whatever benchmark you prefer. Run it on
a system. Rebuild after changing HZ to 400 and run it again. Restore HZ
and use the RTC driver to produce an interval of 1024 HZ, run your
benchmark again. Changing HZ had a huge performance impact in 2.2.13, I'm
pretty sure it didn't change much in later 2.2 releases.

Seems to me like there is a problem here. I'm pretty sure it is a
combination of the overhead of the cascaded timers combined with the
very high overhead of the scheduler that causes this. Someday this should
be fixed.


What I would like to see is support for a higher resolution timer in
Linux, for those of us that need times down to about 1mSec. Those systems
that can quickly reprogram the interval timer would do so each time a new
value was at the head of list, others would have to do it more
intelligently.

Regardless of how it is done, forcing the system to run a constant 1000 HZ
interrupt through the system should not impact system performance more
than a few percent. If it does, something was done wrong. When there is
need for the higher resolution timer, people will accept the overhead. On
most systems it would not be used, so there would be no reason to run the
higher rate timer.


-Bret

------------------------------------------------------------------------------
Bret Indrelee |  Sometimes, to be deep, we must act shallow!
bret@io.com   |  -Riff in The Quatrix


