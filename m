Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUCFE6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 23:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUCFE6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 23:58:38 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:45197 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261587AbUCFE62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 23:58:28 -0500
Message-ID: <404959A5.6040809@pacbell.net>
Date: Fri, 05 Mar 2004 20:55:01 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>	<20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com>	<16289.55171.278494.17172@napali.hpl.hp.com>	<3FA28C9A.5010608@pacbell.net> <16457.12968.365287.561596@napali.hpl.hp.com>
In-Reply-To: <16457.12968.365287.561596@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> OK, finally a bit of progress.  If you remember back in October 2003 I
> reported:
> 
>  > One-line summary: plug-in your USB keyboard, see your machine die.
> 
>  > So, I have this non-name USB keyboard (with built-in 2-port USB
>  > hub) which reliably crashes 2.6.0-test{8,9} on both x86 and ia64.
>  > In retrospect, it's clear to me that the same keyboard also
>  > occasionally crashes 2.4 kernels, but there the problem appears
>  > more seldom.  
> 
> Specifically, after upgrading to 2.6.4-rc2, _all_ of the ia64 machines
> I tested would crash as soon as they had _any_ USB keyboard plugged
> in.  That is, the problem no longer was limited to the BTC keyboard,
> which is special because it has a built-in hub.  This was encouraging.
> 
> Turns out it's this patch that was causing the crashes:
> 
>  http://linux.bkbits.net:8080/linux-2.5/cset@1.1619.1.17

Maybe in 2.6.4-rc2... but not in 2.6.0-test{8,9}!!

There's something wierd going on recently for sure, and it's
not caused just by that patch.  I'm not sure reverting that
would make things better overall right now; hard to say.

I'm thinking the "disable periodic schedule" patch is also
worth looking at.  I can imagine some silicon having bugs
if that's turned off (just like some _systems_ have issues
when it's left on).


> That was strange, because even to my USB-untrained eye the patch
> looked obviously correct.  However, I think the root cause of the
> problem really has to do with a race-condition between the controller
> and the driver.  In particular, if I apply the patch below, my USB
> keyboards (including the BTC keyboard) work just fine!
> 
> ...
> -	ed->tick = OHCI_FRAME_NO(ohci->hcca) + 1;
> +	ed->tick = OHCI_FRAME_NO(ohci->hcca) + 2;

I've seen that _change_ behavior in some regression tests
(usbtest test11/test12), as if the extra msec let things
quiesce (so only one of two broken states showed, and
not the oopsable one) but not _fix_ it.


> However, I think the root-cause of the problem may be this optimization
> in ohci_irq():
> 
> 	/* we can eliminate a (slow) readl() if _only_ WDH caused this irq */
> 
> Indeed, if I apply this patch instead:
> 
> ...
>  	/* we can eliminate a (slow) readl() if _only_ WDH caused this irq */
> -	if ((ohci->hcca->done_head != 0)
> +	if (0 && (ohci->hcca->done_head != 0)
> ...
> 
> there are no crashes either.

See this post from Martin Diehl ... my response isn't out yet:

   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107850825815775&w=2

The reason I keep ending up thinking that readl-elimination
must be OK (me agreeing with Martin) is that the memory there
came from dma_alloc_coherent() ... so if anything's wrong,
it'd be at most lack of rmb(), not a stale-cache kind of thing.


> So my theory is that I was seeing this sequence of events:
> 
>  - HCD signals WDH interrupt & sends DMA to update the frame number in
>    the host-controller communication area (HCCA)
> 
>  - host gets interrupt, but skips readl() and hence reads a stale
>    frame number N instead of the up-to-date value (N+1)

It reads the frame number directly from the controller, so it's
not possible that it can be so stale that an rmb() wouldn't fix
sequencing issues.

What might be possible though is that the donelist gets modified
by the time the unlinks get processed, with some extra TDs changing
state (from HC perspective) ... haven't explored that possibility.


>  - HCD cancels a transfer descriptor (TD), moves it to the "remove list"
>    and calculates the frame number at which it can be remove from
>    the host-controller's list as N+1

That'd be an ED on the remove list, not a TD.  Also in dma-coherent
memory.  The cancelation would apply to one or more of the TDs
queued to that ED.


>  - SOF interrupt arrives (probably was pending already?)
> 
>  - interrupt handler does a readl() and now sees the updated
>    frame-number N+1
> 
>  - HCD sees that the cancelled TD's time stamp N+1 is <= the current
>    current time stamp (N+1) and goes ahead and removes it from the
>    host-list, while the controller is still looking at the entry being
>    removed

This ED-level disagreement between the HC and HCD might explain
some issues.  I think the current trouble cases are usually where
there's only one TD queued to the ED, so that TD and the dummy
keep ping-ponging back and forth.  The HC certainly seems to
overwrite the "dummy TD" --

>  - HCD ends up dereferencing a bad pointer and ends up reading from
>    address 0xf0000000, which on our ia64 machines is a read-only area,
>    which then results in a machine-check abort

I'm surprised that DMA from a read-only area would be a problem!  :)
If OHCI is getting a PCI error, I'd expect a "UE" IRQ.


> Does this sound plausible?

Parts of it.  There's definite recent nastiness.  Of the type
that other eyes sometimes see better.


> What beats me is why UHCI would have the same issue.  I know even less
> about UHCI than I do about OHCI but perhaps there is a similar
> problem.

I still suspect some problem in the HID code.  But right now
I'm quite certain of a recent-ish OHCI issue.

- Dave


> 
> 	--david
> 


