Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266194AbUG1Xai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUG1Xai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267331AbUG1X2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:28:05 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:56015 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266194AbUG1XYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:24:19 -0400
Date: Wed, 28 Jul 2004 19:24:16 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>, Bill Huey <bhuey@lnxw.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728232416.GF6685@yoda.timesys>
References: <20040727225040.GA4370@yoda.timesys> <20040728062722.GA15283@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728062722.GA15283@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:27:22AM +0200, Ingo Molnar wrote:
> > 4. This might be a good time to get around to moving the bulk of the
> > arch/whatever/kernel/irq.c into generic code, as the code said was
> > supposed to happen in 2.5.  This patch is currently only for x86
> > (though we've run IRQ threads on many different platforms in the
> > past).
> 
> agreed. I punted this one for the time being as it's clearly separate
> from the issue of latencies and it's deeply intrusive to 2.6.

The intrusiveness is somewhat mitigated by not having to convert all
architectures at once, though; the generic code would only be
included for those architectures that set the relevant CONFIG_.  At
that point, it basically is just moving code from one file to another
(for x86), and doing minor tweaks for those architectures that are
close to what x86 does.

> > 5. Is there any reason why an IRQ controller might want to have its
> > end() called even if IRQ_DISABLED or IRQ_INPROGRESS is set?  It'd be
> > nice to merge those checks in with the
> > IRQ_THREADPENDING/IRQ_THREADRUNNING checks.
> 
> e.g. in the IO-APIC case if we ack the local APIC only in the end()
> function then we must do that - an un-acked local APIC prevents other
> IRQs from being delivered. We do this for level-triggered IO-APIC irqs.

Yes, but the IO-APIC code needs to be changed anyway to work properly
with IRQ threads.

> what do you think about making the i8259A's interrupt priorities
> configurable? (a'la rtirq patch) Does it make any sense, given how early
> we mask the source irq and ack the interrupt controller [hence giving
> all other interrupts a fair chance to arrive ASAP]?

It could be useful for SA_NOTHREAD interrupts, but I don't think it
buys much for threaded interrupts (as you'd have to wait until normal
IRQs are enabled to schedule the handler thread anyway).

> Bernhard Kuhn's rtirq patch is for IO-APIC/APICs, but i think the
> latency issues could be equally well fixed by not keeping the local APIC
> un-ACK-ed during level triggered irqs, but doing the mask & ack thing.
> This will be slightly slower but should make them both redirectable and
> more symmetric and fair.

I agree.  How much slower would it be (is it worth an #ifdef for irq
threads)?  Hopefully PIC operations aren't as slow as they are on the
8259...

-Scott
