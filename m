Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277194AbRJDR1X>; Thu, 4 Oct 2001 13:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277189AbRJDR1O>; Thu, 4 Oct 2001 13:27:14 -0400
Received: from [208.129.208.52] ([208.129.208.52]:59656 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277194AbRJDR0y>;
	Thu, 4 Oct 2001 13:26:54 -0400
Date: Thu, 4 Oct 2001 10:32:10 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andreas Dilger <adilger@turbolabs.com>
cc: Robert Olsson <Robert.Olsson@data.slu.se>, <mingo@elte.hu>,
        jamal <hadi@cyberus.ca>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011003162210.L8954@turbolinux.com>
Message-ID: <Pine.LNX.4.40.0110041024180.1607-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Andreas Dilger wrote:

> If you get to the stage where you are turning off IRQs and going to a
> polling mode, then don't turn IRQs back on until you have a poll (or
> two or whatever) that there is no work to be done.  This will at worst
> give you 50% polling success, but in practise you wouldn't start polling
> until there is lots of work to be done, so the real success rate will
> be much higher.
>
> At this point (no work to be done when polling) there are clearly no
> interrupts would be generated (because no packets have arrived), so it
> should be reasonable to turn interrupts back on and stop polling (assuming
> non-broken hardware).  You now go back to interrupt-driven work until
> the rate increases again.  This means you limit IRQ rates when needed,
> but only do one or two excess polls before going back to IRQ-driven work.
>
> Granted, I don't know what the overhead of turning the IRQs on and off
> is, but since we do it all the time already (for each ISR) it can't be
> that bad.
>
> If you are always having work to do when polling, then interrupts will
> never be turned on again, but who cares at that point because the work
> is getting done?  Similarly, if you have IRQs disabled, but are sharing
> IRQs there is nothing wrong in polling all devices sharing that IRQ
> (at least conceptually).
>
> I don't know much about IRQ handlers, but I assume that this is already
> what happens if you are sharing an IRQ - you don't know which of many
> sources it comes from, so you poll all of them to see if they have any
> work to be done.  If you are polling some of the shared-IRQ devices too
> frequently (i.e. they never have work to do), you could have some sort
> of progressive backoff, so you skip polling those for a growing number
> of polls (this could also be set by the driver if it knows that it could
> only generate real work every X ms, so we skip about X/poll_rate polls).

This seems a pretty nice solution that achieve 1) to limit the irq
frequency 2) avoid the huge shared irqs latency given by the irq masking.
By having a per irq # poll callbacks could give the opportunity to poll
"time to time" sharing devices during the offending device poll loop.



- Davide


