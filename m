Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWESXPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWESXPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 19:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWESXPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 19:15:33 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:58897 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751431AbWESXPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 19:15:32 -0400
Date: Fri, 19 May 2006 16:13:43 -0700
From: Tim Mann <mann@vmware.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: mann@vmware.com, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: Fix time going backward with clock=pit [1/2]
Message-ID: <20060519161343.5472c777@mann-lx.eng.vmware.com>
In-Reply-To: <Pine.LNX.4.64.0605191424360.32445@scrub.home>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
	<Pine.LNX.4.64.0605181249020.17704@scrub.home>
	<20060518115022.0561c24d@mann-lx.eng.vmware.com>
	<Pine.LNX.4.64.0605190108010.32445@scrub.home>
	<20060518190220.2a9aa33e@mann-lx.eng.vmware.com>
	<Pine.LNX.4.64.0605191424360.32445@scrub.home>
Organization: VMware, Inc.
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > It's not that important if it's not completely correct for SMP systems, 
> > > they usually have other sources, but for the few systems there this is the 
> > > only time source, we should at least make an effort to avoid the read 
> > > error.
> > 
> > Hmm.  If you don't care about SMP systems, that makes the problem
> > tractable.  In that case get_offset_pit can assume that acknowledging
> > the interrupt and incrementing jiffies happen atomically (since that's
> > done at interrupt level), so checking whether there's an unacknowledged
> > interrupt is a sound approach.  I'm definitely not expert enough to be
> > sure how/if you can do that correctly, though.  The current code in
> > do_timer_overflow may be correct for systems using PIC interrupt
> > routing, but it doesn't seem to work in the APIC systems I've tried it
> > on, and I don't have a suggestion for how to fix that case.  Maybe
> > someone else does...?
> > 
> > It also would be preferable to fix the SMP case so that at least time
> > doesn't go backward there, in case someone tries to use the pit
> > clocksource there.  It's quite easy to hit the window where one CPU
> > calls gettimeofday while another one has ack'd a timer interrupt but
> > hasn't incremented jiffies yet.  Or I suppose we could disable the pit
> > clocksource for SMP systems, but that seems a bit draconian.
> 
> We should at least add a warning that the clock is not usable for precise 
> timekeeping (in the resolution limits one would expect from it).
> 
> In the UP case we can live without the underflow information, if we assume 
> the function is called with interrupts enabled and it's properly restarted 
> in case of an underflow via the timer interrupt. If we do this, we also 
> have to document this somewhere that it relies on the current seq_lock 
> bevaviour.

I think it's cleanest to put a loop into get_offset_pit itself,
something like this:

{
        static unsigned long jiffies_p = INITIAL_JIFFIES;
        unsigned long jiffies1, jiffies2;
        static int count_p = LATCH;
        int count;

        /*
         * It's difficult to get a jiffies value and count that are
         * guaranteed to be coherent, because count can wrap at any
         * time, generating an interrupt which may not be handled
         * immediately.
         *
         * The algorithm below is correct in the uniprocessor case and
         * if interrupts are enabled.  It works because although we
         * cannot read jiffies and count in one atomic operation, they
         * are effectively updated atomically: when count wraps, that
         * causes an interrupt that is handled by the one and only
         * CPU, and the interrupt hander increments jiffies. Thus,
         * code that runs with interrupts enabled cannot read the
         * count and then subsequently read an *older* value of
         * jiffies.
         *
         * In the SMP case, however, the interrupt may be routed to a
         * different CPU and handled there, and that CPU may not yet
         * have gotten around to incrementing jiffies before we next
         * read it.  So as a band-aid for the SMP case, we store the
         * last (jiffies, count) value returned by this function and
         * make sure that time never appears to go backward.  However,
         * time can still spuriously jump forward by up to almost 1
         * jiffy (though usually less) and stick there until real time
         * catches up.
         */
        jiffies1 = jiffies;
        do {
                jiffies2 = jiffies1;
                count = <read pit counter>;
                jiffies1 = jiffies;
        } while (jiffies1 != jiffies2);

        if (jiffies1 == jiffies_p && count > count_p) {
                /*
                 * Should happen only on SMP systems or due to Neptun
                 * bug.  (Well, or if you call this routine with
                 * interrupts disabled.)
                 */
                count = count_p;
        }

        jiffies_p = jiffies1;
        count_p = count;

        <...>
}

I think this actually ends up producing the same results as what I
originally sent out, but it's commented better, it does its own retries
instead of relying on the essentially incidental fact that it's called
from inside a seqlock retry loop, and it's a little easier to reason
about because it stores a value in (jiffies_p, count_p) only if it
passes the jiffies1 == jiffies2 test.

I'll try this idea in real code and update my patch, and will also
update the corresponding fix for clocksource=pit in John's rework.

> I guess in the SMP IO-APIC case we can't do much more than print the 
> warning and make sure the time doesn't go backwards as you suggested.
>
> If the underflow information is usable from the PIC, we could make proper 
> use of it as I suggested and this had the advantange it's safe to use with 
> interrupts disabled and doesn't require retrying.

Do you know if we need this code to work with interrupts disabled?
I can try to find out...

> Although to make it safe 
> for SMP it would also require synchronisation with the interrupt 
> acknowledgement.
>
> Anyway, the current underflow handling is next to useless, so I guess it's 
> better to remove it and just document the current limitations. If someone 
> cares enough, he can then do an alternative offset function properly using 
> the information from the PIC.

-- 
Tim Mann  work: mann@vmware.com  home: tim@tim-mann.org
          http://www.vmware.com  http://tim-mann.org
