Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWERSuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWERSuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWERSuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:50:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:30726 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751340AbWERSuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:50:24 -0400
Date: Thu, 18 May 2006 11:50:22 -0700
From: Tim Mann <mann@vmware.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: mann@vmware.com, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: Fix time going backward with clock=pit [1/2]
Message-ID: <20060518115022.0561c24d@mann-lx.eng.vmware.com>
In-Reply-To: <Pine.LNX.4.64.0605181249020.17704@scrub.home>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
	<Pine.LNX.4.64.0605181249020.17704@scrub.home>
Organization: VMware, Inc.
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2006 13:51:36 +0200 (CEST), Roman Zippel <zippel@linux-m68k.org> wrote:
> Hi,
> 
> On Wed, 17 May 2006, Tim Mann wrote:
> 
> > 2) do_timer_overflow was trying to detect the case where the counter
> >    has wrapped since jiffies was incremented by checking whether the
> >    timer interrupt is still pending in the PIC.  This is bogus for a
> >    couple of reasons: (a) There is a window between the point where
> >    the PIC interrupt is acknowledged and jiffies is incremented.  
> >    (b) Most systems use the IOAPIC for interrupt routing now.  The
> >    kernel has code that tries to also route the timer interrupt to the
> >    PIC and acknowledge it there, but this does not appear to work; in
> >    my testing on a couple of IOAPIC systems, do_timer_overflow always
> >    thought a timer interrupt was pending.  Also, this code has the
> >    same window as in (a).
> 
> Do you (or anyone else) have more information about this? If it's not 
> possible to detect the underflow,

I don't know of a reliable way to detect when we're in the state that
the PIT has wrapped but the resulting interrupt hasn't yet been handled
far enough to cause jiffies to be incremented.  I doubt there is one. 
Here are two ideas that work in other roughly-similar cases but not here:

1) Generally, on counters that don't interrupt when they wrap, you can
watch for the high-order bit to toggle and detect the wrap that way, and
that method doesn't require handling an interrupt atomically with
reading the counter.  However, this is only reliable if you can be
certain to read the counter often enough to detect all the wraps, which
isn't the case with the PIT counter -- it wraps way too often.

2) There are algorithms for reading multi-word hardware counters that
increment atomically but can't be read atomically; for example:

   high1 = <read high word of counter>;
   do {
     high2 = high1;
     low = <read low word of counter>;
     high1 = high2;
   } while (high1 != high2);

... but that doesn't work either, because there still could be a pending
PIT timer interrupt that was routed to another CPU and not handled yet.
The unpredictable delay between the PIT wrapping and jiffies getting
incremented is a killer.

> it would mean that PIT isn't usable
> as clock in these cases, as the clock would still jump around (just not 
> visibly backwards).

Yeah, the PIT counter is still not a very good clock source.  It's
better on average than just returning the jiffy count, but in the worst
case you can still get a time that's old by up to almost a jiffy (using
the code I sent, and I don't see how to do better).

> >  	if( jiffies_t == jiffies_p ) {
> >  		if( count > count_p ) {
> >  			/* the nutcase */
> > -			count = do_timer_overflow(count);
> > +			count = count_p;
> >  		}
> >  	} else
> >  		jiffies_p = jiffies_t;
> 
> IMO the else part is not correct.

The else part is correct if we eliminate the possibility that jiffies
gets incremented between reading count and reading jiffies (by reading
jiffies first).  It looks like you're trying to solve that problem
without moving the read of jiffies above count, but your code is too
sketchy.  Also, I don't really see why you want to do that.

> I think the whole think should look 
> something like this:
> 
> 	if (jiffies_t == jiffies_p) {
> 		if (count > count_p) {
> 			underflow or crappy timer;

What should the code do in this case?

> 		}
> 	} else {
> 		jiffies_p = jiffies_t;
> 		if (count > LATCH/2 && underflow)
> 			count -= LATCH;

I think I see what you're aiming at here: in the case where we read
count, then the counter wraps, then we read jiffies, you want to detect
that and fix it.  Actually if you could detect that, the right way to
fix it would be to set count = LATCH, since the old count is, well, old:
the current time is right after the jiffy.

However, we don't really have a way to detect that this case happened --
the "&& underflow" in your code is a handwave.

> 	}
> 
> This would also basically solve the ordering problem, retrying the 
> function would produce the correct result.
> 
> So we basically have two issues:
> 1. Fix the timekeeping to produce correct results.
> 2. Broken underflow handling.
> 
> If the second isn't fixable, it would make the whole thing practically 
> unusable. I hope that it's at least detectable, so we don't use it as a 
> clock, which would be IMO preferable instead of completely removing the 
> underflow check (which would make the clock unreliable for everyone).
> 
> BTW another bug here is the wrong initialization of jiffies_p (it should 
> be INITIAL_JIFFIES).
> 
> bye, Roman


-- 
Tim Mann  work: mann@vmware.com  home: tim@tim-mann.org
          http://www.vmware.com  http://tim-mann.org
