Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVASHbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVASHbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVASHbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:31:45 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:34705 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261613AbVASHbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:31:42 -0500
Date: Tue, 18 Jan 2005 23:31:19 -0800
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119073119.GA29020@atomide.com>
References: <20050119000556.GB14749@atomide.com> <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com> <1106112525.4534.175.camel@gaston> <20050119063713.GB26932@atomide.com> <1106118532.5295.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106118532.5295.3.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 23:09]:
> On Tue, 2005-01-18 at 22:37 -0800, Tony Lindgren wrote:
> > * Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 21:29]:
> > > Hrm... reading more of the patch & Martin's previous work, I'm not sure
> > > I like the idea too much in the end... The main problem is that you are
> > > just "replaying" the ticks afterward, which I see as a problem for
> > > things like sched_clock() which returns the real current time, no ?
> > 
> > Well so far I haven't found problems with time. Since sched_clock()
> > returns the hw time, how does it cause a problem? Do you have some
> > example in mind? Maybe there's something I haven't even considered
> > yet.
> > 
> > > I'll toy a bit with my own implementation directly using Martin's work
> > > and see what kind of improvement I really get on ppc laptops.
> > 
> > I'd be interested in what you come up with :)
> 
> Well, I did a very simple implementation entirely local to
> arch/ppc/kernel, that basically calls timer_interrupt on every do_IRQ, I
> don't change timer_interrupt (our implementation already knows how to
> "catch up" already if missed ticks and knows how to deal beeing called
> to early as well). Then, when going to idle loop, I "override" the
> decrementer interrupt setting to be further in the future if
> next_timer_interrupt() returns more than 1.

That sounds interesting, I'll check it out. Do you already have it
available somewhere?

BTW, It would be nice to be able to just skip ticks, maybe Martin's 
cputime patch allows that.

> Strangely, I got not measurable improvement on power consumption despite
> putting the CPU longer into NAP mode. Note that this may be very
> different with earlier (G3 notably) CPUs, since G3 users repeately
> reported me havign a significant loss in battery life with HZ=1000

Yeah, it could be that NAP mode wakes up too early. I haven't looked
much what happens on my machine with ACPI, but I have feeling C2 idle
mode wakes up before the next timer interrupt.

It could also be that the difference between idling the cpu more 
is minimal. But if there's a difference with HZ=1000, it sounds like
idling the cpu longer should make a difference. Unless of course
calling next_timer_interrupt() continuously eats away the gain :)

> Later, I'll do some stats to check how long I really slept, and see if
> it's worth, when I predict a long sleep, flushing the cache and going
> into a deeper PM mode where cache coherency is disabled too.

I think that's where there should be some real power savings showing up.

Regards,

Tony
