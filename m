Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVLMJLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVLMJLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVLMJLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:11:34 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43173
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964838AbVLMJLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:11:33 -0500
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com,
       mingo@elte.hu
In-Reply-To: <439E2308.1000600@mvista.com>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>
	 <1133908082.16302.93.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512070347450.1609@scrub.home>
	 <1134148980.16302.409.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512120007010.1609@scrub.home>
	 <1134405768.4205.190.camel@tglx.tec.linutronix.de>
	 <439E2308.1000600@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 13 Dec 2005 10:18:08 +0100
Message-Id: <1134465488.4205.293.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 17:25 -0800, George Anzinger wrote:
> >>The rationale for example talks about "a periodic timer with an absolute 
> >>_initial_ expiration time", so I could also construct a valid example with 
> >>this expectation. The more I read the spec the more I think the current 
> >>behaviour is not correct, e.g. that ABS_TIME is only relevant for 
> >>it_value.
> >>So I'm interested in specific interpretations of the spec which support 
> >>the current behaviour.
> 
> My $0.02 worth: It is clear (from the standard) that the initial time 
> is to be ABS_TIME.  It is also clear that the interval is to be added 
> to that time.  IMHO then, the result should have the same property, 
> i.e. ABS_TIME.  Sort of like adding an offset to a relative address. 
> The result is still relative.

So the only difference between a timer with ABSTIME set and one without
is the notion of the initial expiry value, aside the
clock_settime(CLOCK_REALTIME) speciality.

ABSTIME:
firstexp = it_value
firstexp, firstexp + it_interval, ... firstexp + n * it_interval

non ABSTIME:
firstexp = now + it_value
firstexp, firstexp + it_interval, ... firstexp + n * it_interval

The only limitation of this is that the interval value can not be less
than the resolution of the clock in order to avoid the wrong accounting
of the overflow.

> > Unfortunately you find just the spec all over the place. I fear we have
> > to find and agree on an interpretation ourself.
> > 
> > I agree, that the restriction to the initial it_value is definitely
> > something you can read out of the spec. But it does not make a lot of
> > sense for me. Also the restriction to TIMER_ABSTIME is somehow strange
> > as it converts an CLOCK_REALTIME timer to a CLOCK_MONOTONIC timer. I
> > never understood the rationale behind that.
> 
> I don't think it really does that.  The TIMER_ABSTIME flag just says 
> that the time requested is to be taken as "clock" time (which ever 
> clock) AND that this is to be the expire time regardless of clock 
> setting.  We, in an attempt to simplify the lists, convert the expire 
> time into some common time notation (in most cases we convert relative 
> times to absolute times) but this introduces problems because the 
> caller has _asked_ for a relative or absolute time and not the other. 
>   If the clock can not be set this is not a problem.  If it can, well, 
> we need to keep track of what the caller wanted, absolute or relative.
> 
> It might help others to understand this if you were to remove the 
> clock names from your queues and instead call them "absolute_real" and 
> "up_time".  Then it would be more clear, I think, that we are mapping 
> user requests onto these queues based on the desired functionality 
> without a predilection to put a timer on a given queue just because a 
> particular clock was requested.  At this point it becomes clear, for 
> example, that a TIMER_ABSTIME request on the real clock is the _only_ 
> request that should be mapped to the "absolute_real" list.

In other words. If there is only CLOCK_REALTIME, then the implementation
has to keep track of absolute and relative timers.

The existance of CLOCK_MONOTONIC and the fact that CLOCK_MONOTONIC is
using the same clock source as CLOCK_REALTIME allows us to optimize the
implementation by putting the relative timers on the monotonic list.

	tglx


