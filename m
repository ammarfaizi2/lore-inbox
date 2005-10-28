Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVJ1Ewy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVJ1Ewy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 00:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVJ1Ewy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 00:52:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44198 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965091AbVJ1Ewx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 00:52:53 -0400
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: tim.bird@am.sony.com, oleg@tv-sign.ru, hch@infradead.org,
       paulmck@us.ibm.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>
In-Reply-To: <Pine.LNX.4.61.0510250114100.1386@scrub.home>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510100213480.3728@scrub.home>
	 <1129016558.1728.285.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
	 <Pine.LNX.4.61.0510150143500.1386@scrub.home>
	 <1129490809.1728.874.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510170021050.1386@scrub.home>
	 <20051017075917.GA4827@elte.hu>
	 <Pine.LNX.4.61.0510171054430.1386@scrub.home>
	 <20051017094153.GA9091@elte.hu> <20051017025657.0d2d09cc.akpm@osdl.org>
	 <Pine.LNX.4.61.0510171511010.1386@scrub.home>
	 <1129582512.19559.136.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510180032420.1386@scrub.home> <435449DC.8070109@mvista.com>
	 <Pine.LNX.4.61.0510181823560.1386@scrub.home> <4355B4EB.2080307@mvista.com>
	 <Pine.LNX.4.61.0510211326400.1386@scrub.home> <435BD3C2.9070705@mvista.com>
	 <Pine.LNX.4.61.0510250114100.1386@scrub.home>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 28 Oct 2005 00:52:10 -0400
Message-Id: <1130475130.9574.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 22:23 +0200, Roman Zippel wrote:

> 
> Next question would be what happens if timer and clock resolution differs? 
> For example if the clock has a resolution of 1us and the timer runs every 
> 1ms. For relative timer this would mean we can keep the error within 
> 1.001ms and for absolute timer within 1ms. Do we really have to force an 
> error larger than really necessary?
> 
> Interesting is now that Thomas doesn't take the clock resolution into 
> account at all. Let's say clock and timer resolution are 1ms (or HZ=1000). 
> If we program a normal kernel timer, we do something like this:
> 
> 	timer->expires = jiffies + 1 + usecs_to_jiffies(timeout);
> 
> Thomas does now basically this:
> 
> 	timer->expires = jiffies * res + round(timeout, res);
> 
> IOW if the clock resolution is larger than the interrupt delay, the timer 
> may expire early.

Roman, I think I know what you are trying to say here. Although it took
me several readings of what you wrote and then really just looking at
Thomas' code.

It's the old problem with:

1          2          3          4     
+----------+----------+----------+---------->>
       ^                ^
       |                |
     Start             End

Asking for 2 ms (with both clock and res the same at 1ms). We start the
clock at 1 but it really is 1.7 and we get the interrupt and return at 3
but really 3.2, so instead of receiving a wait of 2ms, we return with
3.2 - 1.7 = 1.5ms

Currently, this is not a problem when the clock is at a higher
frequency, (like the tsc).  So the base->get_time works now since the
clock is at a higher frequency, but if the get_time returned jiffies,
this would fail.  And the clock used is also much faster that the delay
it takes to get back to the calling process (which is much more than a
nanosecond today).

Is that what you were trying to say Roman?

Interesting though, I tried to force this scenario, by changing the
base->get_time to return jiffies.  I have a jitter test and ran this
several times, and I could never get it to expire early.  I even changed
HZ back to 100.

Then I looked at run_ktimer_queue.  And here we have the compare:

		timer = list_entry(base->pending.next, struct ktimer, list);
		if (ktime_cmp(now, <=, timer->expires))
			break;

So, the timer does _not_ get processed if it is after or _equal_ to the
current time.  So although the timer may go off early, the expired queue
does not get executed.  So the above example would not go off at 3.2,
but some time in the 4 category.

So the function will _not_ be executed early, although this could mean
that the timer could actually go off early (in the HRT case), but I
haven't taken a look there.  That is to say the interrupt goes off
early, not the function being executed.

-- Steve


