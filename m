Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVASHJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVASHJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVASHJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:09:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:14563 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261606AbVASHJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:09:35 -0500
Subject: Re: [PATCH] dynamic tick patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050119063713.GB26932@atomide.com>
References: <20050119000556.GB14749@atomide.com>
	 <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com>
	 <1106112525.4534.175.camel@gaston>  <20050119063713.GB26932@atomide.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 18:08:52 +1100
Message-Id: <1106118532.5295.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 22:37 -0800, Tony Lindgren wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 21:29]:
> > Hrm... reading more of the patch & Martin's previous work, I'm not sure
> > I like the idea too much in the end... The main problem is that you are
> > just "replaying" the ticks afterward, which I see as a problem for
> > things like sched_clock() which returns the real current time, no ?
> 
> Well so far I haven't found problems with time. Since sched_clock()
> returns the hw time, how does it cause a problem? Do you have some
> example in mind? Maybe there's something I haven't even considered
> yet.
> 
> > I'll toy a bit with my own implementation directly using Martin's work
> > and see what kind of improvement I really get on ppc laptops.
> 
> I'd be interested in what you come up with :)

Well, I did a very simple implementation entirely local to
arch/ppc/kernel, that basically calls timer_interrupt on every do_IRQ, I
don't change timer_interrupt (our implementation already knows how to
"catch up" already if missed ticks and knows how to deal beeing called
to early as well). Then, when going to idle loop, I "override" the
decrementer interrupt setting to be further in the future if
next_timer_interrupt() returns more than 1.

Strangely, I got not measurable improvement on power consumption despite
putting the CPU longer into NAP mode. Note that this may be very
different with earlier (G3 notably) CPUs, since G3 users repeately
reported me havign a significant loss in battery life with HZ=1000

Later, I'll do some stats to check how long I really slept, and see if
it's worth, when I predict a long sleep, flushing the cache and going
into a deeper PM mode where cache coherency is disabled too.

Ben.


