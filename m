Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966141AbWKNQOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966141AbWKNQOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966150AbWKNQOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:14:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966141AbWKNQOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:14:16 -0500
Date: Tue, 14 Nov 2006 08:10:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Komuro <komurojun-mbn@nifty.com>, tglx@linutronix.de,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irq: do not mask interrupts by default
In-Reply-To: <1163492040.28401.76.camel@earth>
Message-ID: <Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org> 
 <1162985578.8335.12.camel@localhost.localdomain>  <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
  <20061108085235.GT4729@stusta.de>  <7813413.118221162987983254.komurojun-mbn@nifty.com>
  <11940937.327381163162570124.komurojun-mbn@nifty.com> 
 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>  <m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
 <1163450677.7473.86.camel@earth>  <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
 <1163492040.28401.76.camel@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, Ingo Molnar wrote:
> 
> 1) disable_irq() is relatively rare (used in about 10% of drivers, but
> there it's overwhelmingly used in some slowpath) so it's performance
> uncritical.

Well, the thing is, the _replay_ if it does happen, is going to be really 
really slow compared to the masking. So at that point, it may well be a 
net performance downside if the masking is going to almost always have an 
interrupt happen while the thing is masked. I dunno.

There's another thing too:

For level-triggered interrupts, I _really_ don't think we should do this. 
The code inside the masked region is sometimes "setup code", which will do 
things that _will_ raise an interrupt, but may read the status register or 
whatever to then unraise it. So in that case, your patch will generate 
different behaviour, something that I really don't want to introduce at 
this point in the 2.6.19 series.

> 2) missing an IRQ while the line is masked is often a lethal regression 
> to the user. An IRQ could be missed even if we think that the IRQ line 
> is 'level-triggered'.

If it's level-triggered, it's going to be missed only if it's de-asserted 
by code inside the masked region, and that is what we have always done on 
purpose, so "missing" it is the right thing to do. It's what we have 
tested all level-triggered interrupts with for the last 15+ years, and 
it's been part of the semantics for masking.

So I absolutely do _not_ think your change is improved semantics. It's new 
semantics, and illogical. If the driver masked the irq line, did some 
testing that raises and clears it again ("let's check if this version of 
the chip raises the interrupt when we do XYZZY"), then the logical thing 
to do would be to not cause the interrupt to happen.

Of course, for edge-triggered APIC interrupts, we _have_ to replay the irq 
(since we don't have any way of even *knowing* whether we might get it 
again), but for level-triggered and for the old legacy i8259 controller 
that gets it right for edges anwyay, we should _not_ send the spurious 
interrupt that is no longer active.

And a lot of code has been tested with either just the i8259 (old machines 
without any APIC) or with PCI-only devices (which are always level- 
triggered), so the fact that edge-triggered things have always seen the 
potential for spurious interrupts is not a reasong to say "well, they have 
to handle it anyway". True PCI drivers generally do _not_ have to handle 
the crazy case, and generally have never seen it.

> so my patch changes the default irq-disable logic of /all/ controllers 
> to "delayed disable". (IRQ chips can still override this by providing a 
> different chip->disable method that just clones their ->mask method, if 
> it is absolutely sure that no IRQs can be lost while masked)

I really think we should do this just for APIC edge triggered interrupts, 
ie keep the old behaviour.

Also, I worry a bit about the patch:

> @@ -272,8 +268,11 @@ handle_simple_irq(unsigned int irq, stru
>  	kstat_cpu(cpu).irqs[irq]++;
>  
>  	action = desc->action;
> -	if (unlikely(!action || (desc->status & IRQ_DISABLED)))
> +	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
> +		if (desc->chip->mask)
> +			desc->chip->mask(irq);
>  		goto out_unlock;
> +	}

The simple-irq case too? That's not even going to replay the thing? So now 
you just mask (without replaying) simple irqs, but then the other irqs you 
mask and replay.. See above on why I don't think this is necessarily a bug 
(since masking is almost always the right thing _anyway_), but now it will 
*STILL* depend on some internal implementation decision on whether the 
replay happens at all. I'd much rather have the replay decision be based 
on hard physical data: we replay _only_ for edge-triggered interrupts, and 
_only_ for controllers that need it. 

In other words, I think we should just make APIC-edge have the "please 
delay masking and replay" bit, and nobody else.

Can you send that patch (for both x86 and x86-64), and we can ask Komuro 
to test it. That would be the "same behaviour as we've always had" thing, 
which I think is also the _right_ behaviour.

		Linus
