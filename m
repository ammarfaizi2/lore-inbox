Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277011AbRJCWZR>; Wed, 3 Oct 2001 18:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRJCWZI>; Wed, 3 Oct 2001 18:25:08 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:20207 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277011AbRJCWYy>; Wed, 3 Oct 2001 18:24:54 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 3 Oct 2001 16:22:10 -0600
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: mingo@elte.hu, jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011003162210.L8954@turbolinux.com>
Mail-Followup-To: Robert Olsson <Robert.Olsson@data.slu.se>, mingo@elte.hu,
	jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.GSO.4.30.0110031138150.4833-100000@shell.cyberus.ca> <Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain> <15291.32311.499838.886628@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15291.32311.499838.886628@robur.slu.se>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 03, 2001  23:08 +0200, Robert Olsson wrote:
> Ingo Molnar writes:
>  > (i did not criticize the list_add/list_del in any way, it's obviously
>  > correct to cycle the polled devices. I highlited that code only to show
>  > that the current patch as-is polls too agressively for generic server
>  > load.)
> 
>  Yes I think we need some data here... 
> 
>  > can you really make it 100% successful for rx? Ie. do you only ever call
>  > the ->poll() function if there is a new packet waiting? How do you know
>  > with a 100% probability that someone on the network just sent a new packet
>  > waiting? (without receiving an interrupt to begin with that is.)
> 
>  Well we need RX-interrupts not to spin away the CPU or exhaust the the PCI-
>  bus. The NAPI scheme is simple, turn off RX-interrupts when the first packet
>  comes and have the kernel to pull packets from the RX-ring. 
> 
>  I tried have pure polling... it easy do just have your driver return
>  "not_done" all the time. Not a good idea. :-) Maybe as sofirq test.

I think it is rather easy to make this self-regulating (I may be wrong).

If you get to the stage where you are turning off IRQs and going to a
polling mode, then don't turn IRQs back on until you have a poll (or
two or whatever) that there is no work to be done.  This will at worst
give you 50% polling success, but in practise you wouldn't start polling
until there is lots of work to be done, so the real success rate will
be much higher.

At this point (no work to be done when polling) there are clearly no
interrupts would be generated (because no packets have arrived), so it
should be reasonable to turn interrupts back on and stop polling (assuming
non-broken hardware).  You now go back to interrupt-driven work until
the rate increases again.  This means you limit IRQ rates when needed,
but only do one or two excess polls before going back to IRQ-driven work.

Granted, I don't know what the overhead of turning the IRQs on and off
is, but since we do it all the time already (for each ISR) it can't be
that bad.

If you are always having work to do when polling, then interrupts will
never be turned on again, but who cares at that point because the work
is getting done?  Similarly, if you have IRQs disabled, but are sharing
IRQs there is nothing wrong in polling all devices sharing that IRQ
(at least conceptually).

I don't know much about IRQ handlers, but I assume that this is already
what happens if you are sharing an IRQ - you don't know which of many
sources it comes from, so you poll all of them to see if they have any
work to be done.  If you are polling some of the shared-IRQ devices too
frequently (i.e. they never have work to do), you could have some sort
of progressive backoff, so you skip polling those for a growing number
of polls (this could also be set by the driver if it knows that it could
only generate real work every X ms, so we skip about X/poll_rate polls).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

