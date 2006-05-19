Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWESCCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWESCCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWESCCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:02:21 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:39184 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932184AbWESCCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:02:20 -0400
Date: Thu, 18 May 2006 19:02:20 -0700
From: Tim Mann <mann@vmware.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: mann@vmware.com, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: Fix time going backward with clock=pit [1/2]
Message-ID: <20060518190220.2a9aa33e@mann-lx.eng.vmware.com>
In-Reply-To: <Pine.LNX.4.64.0605190108010.32445@scrub.home>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
	<Pine.LNX.4.64.0605181249020.17704@scrub.home>
	<20060518115022.0561c24d@mann-lx.eng.vmware.com>
	<Pine.LNX.4.64.0605190108010.32445@scrub.home>
Organization: VMware, Inc.
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006 02:09:29 +0200 (CEST), Roman Zippel <zippel@linux-m68k.org> wrote:
> Hi,
> 
> On Thu, 18 May 2006, Tim Mann wrote:
> 
> > > I think the whole think should look 
> > > something like this:
> > > 
> > > 	if (jiffies_t == jiffies_p) {
> > > 		if (count > count_p) {
> > > 			underflow or crappy timer;
> > 
> > What should the code do in this case?
> 
> Basically the current do_timer_overflow().

Oh, I see, you were also assuming there's a way to fix that.

> > > 		}
> > > 	} else {
> > > 		jiffies_p = jiffies_t;
> > > 		if (count > LATCH/2 && underflow)
> > > 			count -= LATCH;
> > 
> > I think I see what you're aiming at here: in the case where we read
> > count, then the counter wraps, then we read jiffies, you want to detect
> > that and fix it.  Actually if you could detect that, the right way to
> > fix it would be to set count = LATCH, since the old count is, well, old:
> > the current time is right after the jiffy.
> 
> It's really "-= LATCH". :)

Yeah.  :-)

Tangentially, let me point out another thing: letting get_offset_pit
return more than a jiffy is dangerous if we can ever lose a tick (due to
interrupts being disabled for too long, etc.).  If that happens,
get_offset_pit might advance time past the lost tick, but when the next
non-lost tick comes in, jiffies is incremented by only 1 and count
recycles again, so time effectively snaps backward to the point where
the lost tick occurred.  Losing ticks is bad in itself, of course, but
having that make time actually go backward by about a jiffy (rather than
just stop for one jiffy) seems a bit worse.

> > However, we don't really have a way to detect that this case happened --
> > the "&& underflow" in your code is a handwave.
> 
> Ok, I'm not that familiar with Intel hardware (it must be crappier than I 
> thought). Is there really no way to detect the pending interrupt (e.g. 
> what do_timer_overflow() does)? Without that information one can really 
> only guess the time.
>
> It's not that important if it's not completely correct for SMP systems, 
> they usually have other sources, but for the few systems there this is the 
> only time source, we should at least make an effort to avoid the read 
> error.

Hmm.  If you don't care about SMP systems, that makes the problem
tractable.  In that case get_offset_pit can assume that acknowledging
the interrupt and incrementing jiffies happen atomically (since that's
done at interrupt level), so checking whether there's an unacknowledged
interrupt is a sound approach.  I'm definitely not expert enough to be
sure how/if you can do that correctly, though.  The current code in
do_timer_overflow may be correct for systems using PIC interrupt
routing, but it doesn't seem to work in the APIC systems I've tried it
on, and I don't have a suggestion for how to fix that case.  Maybe
someone else does...?

It also would be preferable to fix the SMP case so that at least time
doesn't go backward there, in case someone tries to use the pit
clocksource there.  It's quite easy to hit the window where one CPU
calls gettimeofday while another one has ack'd a timer interrupt but
hasn't incremented jiffies yet.  Or I suppose we could disable the pit
clocksource for SMP systems, but that seems a bit draconian.

-- 
Tim Mann  work: mann@vmware.com  home: tim@tim-mann.org
          http://www.vmware.com  http://tim-mann.org
