Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWD3FTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWD3FTr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 01:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWD3FTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 01:19:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750962AbWD3FTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 01:19:46 -0400
Date: Sat, 29 Apr 2006 22:19:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <17492.16811.469245.331326@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0604292204270.4616@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <1146345911.3302.36.camel@localhost.localdomain> <Pine.LNX.4.64.0604291453220.3701@g5.osdl.org>
 <17492.16811.469245.331326@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Apr 2006, Neil Brown wrote:
> 
> So what do you propose should be done to better handle such poorly
> built machines?

Well, the thing is, there's not a lot we _can_ do.

We can try to report it. We can also try to handle it as gracefully as we 
can.

> As a concrete example I have a notebook which definitely assigns
> shared interrupts to IRQ-10 (See /proc/interrupts below) yet the ELCR
> only flags IRQ-11 as being level triggered and the rest are edge
> triggered.

Also, do you have the option to enable the IO-APIC? Maybe it's already 
enabled, and your BIOS has just disabled it, but your /proc/interrupts 
implies that you may have compiled your kernel without UP_APIC support.

With the APIC, we might be able to do better. Worth trying out.

> And with this configuration I definitely lose interrupts to the
> wireless ethernet (ra0).
> 
> How do I make this work reliably?
> I could:
> 
> 1/ modify handle_IRQ_event so that it is more resilient to the
>   possibility that shared interrupts are edge triggered.  This can be
>   done be iterating over all action->handlers until they all return
>   IRQ_NONE.

Well, yes. It's worth trying, but as mentioned, we have some drivers that 
return IRQ_HANDLED just because the driver conversion has been lazy. So 
limit it to a few things.

And we really should have some flag that says whether the interrupt 
descriptor ends up beign edge, so that we could do this for edge-triggered 
interrupts _only_.

Anyway, I also do wonder if your irq lossage is due to something else.

On the XT-PIC, disabling the irq will cause an edge when it's re-enabled, 
so you can get the "level" behaviour by disabling the irq over the irq 
handler.

And that's exactly what we do, if I recall correctly. It's been years 
since I worked with that code, but looking at it quickly, it seems to 
match my recollection.

> 2/ Arrange that the ELCR bit is set for any IRQ for which a shared
>   interrupt is registered (on the basis that the code for handling
>   shared interrupts is not resilient against them being edge triggered).

NO.

How many times do I have to say this?

Yes, ELCR sets edge vs level.

BUT IT ALSO SETS THE POLARITY.  If you switch the bit around, it will also 
switch the polarity, and IT WILL NOT WORK. Because you'll end up with a 
level-triggered interrupt that is level-triggered for the wrong polarity, 
and will trigger whenever there is _not_ an interrupt pending.

Now, I will almost guarantee you that there is an exception to this rule 
(hey, it's PC hardware, there's _always_ an exception to any rule ;), and 
on some situations, the ELCR thing will truly only affect edge vs level.

But the point is, we can't just switch to level triggered. There simply is 
no such hardware in general for the old PC interrupts.

(Now, _if_ you use the APIC, you can actually switch polarity and trigger 
mode independently. Which is one reason why I'd like to hear whether you 
perhaps have just disabled the APIC by mistake, rather than have a nasty 
BIOS that disables it for you).

		Linus
