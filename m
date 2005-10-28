Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbVJ1QHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVJ1QHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVJ1QHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:07:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16021 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030269AbVJ1QHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:07:06 -0400
Date: Fri, 28 Oct 2005 18:06:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Steven Rostedt <rostedt@goodmis.org>
cc: tim.bird@am.sony.com, oleg@tv-sign.ru,
       Christoph Hellwig <hch@infradead.org>, paulmck@us.ibm.com,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <1130475130.9574.47.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0510281736340.1386@scrub.home>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0510100213480.3728@scrub.home>  <1129016558.1728.285.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
  <Pine.LNX.4.61.0510150143500.1386@scrub.home>  <1129490809.1728.874.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510170021050.1386@scrub.home>  <20051017075917.GA4827@elte.hu>
  <Pine.LNX.4.61.0510171054430.1386@scrub.home>  <20051017094153.GA9091@elte.hu>
 <20051017025657.0d2d09cc.akpm@osdl.org>  <Pine.LNX.4.61.0510171511010.1386@scrub.home>
  <1129582512.19559.136.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0510180032420.1386@scrub.home> <435449DC.8070109@mvista.com>
  <Pine.LNX.4.61.0510181823560.1386@scrub.home> <4355B4EB.2080307@mvista.com>
  <Pine.LNX.4.61.0510211326400.1386@scrub.home> <435BD3C2.9070705@mvista.com>
  <Pine.LNX.4.61.0510250114100.1386@scrub.home> <1130475130.9574.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Oct 2005, Steven Rostedt wrote:

> Roman, I think I know what you are trying to say here. Although it took
> me several readings of what you wrote and then really just looking at
> Thomas' code.

Thanks for the effort. :-) I know I'm sometimes a bit difficult to 
understand, which makes it easier to simply flame me for a silly mistake.

> It's the old problem with:
> 
> 1          2          3          4     
> +----------+----------+----------+---------->>
>        ^                ^
>        |                |
>      Start             End
> 
> Asking for 2 ms (with both clock and res the same at 1ms). We start the
> clock at 1 but it really is 1.7 and we get the interrupt and return at 3
> but really 3.2, so instead of receiving a wait of 2ms, we return with
> 3.2 - 1.7 = 1.5ms
> 
> Currently, this is not a problem when the clock is at a higher
> frequency, (like the tsc).  So the base->get_time works now since the
> clock is at a higher frequency, but if the get_time returned jiffies,
> this would fail.  And the clock used is also much faster that the delay
> it takes to get back to the calling process (which is much more than a
> nanosecond today).
> 
> Is that what you were trying to say Roman?

Yes.

> Interesting though, I tried to force this scenario, by changing the
> base->get_time to return jiffies.  I have a jitter test and ran this
> several times, and I could never get it to expire early.  I even changed
> HZ back to 100.
> 
> Then I looked at run_ktimer_queue.  And here we have the compare:
> 
> 		timer = list_entry(base->pending.next, struct ktimer, list);
> 		if (ktime_cmp(now, <=, timer->expires))
> 			break;
> 
> So, the timer does _not_ get processed if it is after or _equal_ to the
> current time.  So although the timer may go off early, the expired queue
> does not get executed.  So the above example would not go off at 3.2,
> but some time in the 4 category.
> 
> So the function will _not_ be executed early, although this could mean
> that the timer could actually go off early (in the HRT case), but I
> haven't taken a look there.  That is to say the interrupt goes off
> early, not the function being executed.

You're correct. I missed that comparison, so if clock resolution and timer 
resolution are equal, this indeed works.
It still goes wrong if the resolutions are different. get_time() normally 
wouldn't use jiffies but xtime. Thomas uses a fixed resolution, but xtime 
updates are not constant. On my machine here with HZ=250 the resolution 
would be 4000000ns, but xtime is updated by about 4000150ns every tick. 
This means the timer value is rounded to full 4ms, but this is not enough 
to get it past the next tick.
In the other more common case, where clock resolution is smaller than the 
timer resolution, this means the delay may be larger than really 
necessary.

bye, Roman
