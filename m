Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVKVTG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVKVTG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVKVTG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:06:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965116AbVKVTGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:06:54 -0500
Date: Tue, 22 Nov 2005 11:05:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition 
In-Reply-To: <9497.1132684676@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0511221044340.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org> 
 <E1Ee0G0-0004CN-Az@localhost.localdomain> <24299.1132571556@warthog.cambridge.redhat.com>
 <20051121121454.GA1598@parisc-linux.org> <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
 <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
 <20051121194348.GH1598@parisc-linux.org> <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
 <20051121211544.GA4924@elte.hu> <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
 <1132611631.11842.83.camel@localhost.localdomain>
 <1132657991.15117.76.camel@baythorne.infradead.org>
 <1132668939.20233.47.camel@localhost.localdomain>  <9497.1132684676@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, David Howells wrote:
> 
> > In short: NO_IRQ _is_ 0. Always has been.
> 
> So what? That hasn't stopped you imposing a blanket change before.
> 
> > It's the only sane value.
> 
> Has anyone ever accused you of being sane? :-)

Good arguments, but usually when I'm insane I do blanket changes that I at 
least personally agree with.

So my insanity is a "self-consistent" one, although part of it is that I 
do tend to change my mind (ie I may be self-consistent at any particular 
point in time, but I reserve the right to be inconsistent over the span of 
a day, week, or a year).

> > Anybody who does anything else is a bug waiting to happen.
> 
> My three main concerns are this:
> 
>  (1) Changing the no-irq value away from zero is going to cause problems in
>      certain drivers that assume they can do !dev->irq. I'd like my drivers to
>      work without me having to do anything to them, but there's a lot of
>      rubbish drivers out there, even allowing for this. I suspect this is a
>      tiny part of the problem, and easily fixed in the drivers in the kernel.

Drivers really are the bulk of the kernel. They are a huge problem spot in 
general, because quite often driver writers are pretty limited in their 
understanding of the big picture and the rest of the kernel, which 
together with the fact that drivers are often hard to write _anyway_ (bad 
hw docs if you have any at all, coupled with often the hardware itself 
having strange "features") means that drivers often have the lowest 
quality of code.

To make matters worse, most drivers will have very limited testing anyway, 
because they have a limited audience. There's a few _very_ common drivers, 
but there's a lot of drivers that are relevant to only a small percentage 
of kernel users.

Finally, in this particular case, the notion of NO_IRQ is usually an issue 
only for a small percentage of that small percentage. I bet there are tons 
of drivers that don't even bother to check, because they simply don't need 
to: they always have an interrupt available, or the machine would be so 
broken that it wouldn't ever get used anyway.

This is part of the reason why I'm so adamant that _only_ PC's matter in 
this space. For all other architectures, the small percentage of a small 
percentage of a small percentage basically means that the driver is 
totally irrelevant and has never had any users and absolutely zero 
testing.

So when it comes to drivers, other architectures simply _have_ to look 
like a PC, because if they don't, they'll be sorry. They'll _never_ get 
the kind of testing overhead that PC's get. And even on bog-standard 
Linux/x86, we have several times had an issue of a driver being broken for 
over a _year_ or more, without anybody noticing, and only then being 
fixed (because the users were so few that it took a long time before they 
upgraded).

And this is why I absolutely _hate_ to make changes that you can only test 
by actually having the hardware. Sometimes we have to do it (the big 
interrupt handling changes for SMP), and for all I know we _still_ have 
drivers that simply don't even compile on SMP because they depend on the 
old global "cli/sti" behaviour.

And in this case, I'm 100% convinced we do not want to change that old PC 
behaviour. The fact is, -1 really _is_ technically worse than 0. As 
already mentioned "unsigned int" is actually the canonical form of NO_IRQ, 
so -1 really ends up being "~0u", and that coupled with the fact that some 
people use "int", others use "unsigned long" is just clearly not good.

So my suggested (very _strongly_ suggested) solution is for people to just 
consider "irq" to be a cookie, with the magical value 0 meaning "not 
there" but no inherent meaning otherwise. That just solves all the 
fundamentally hard problems, and has no fundamental problems of its own.

The thing is, we'll have to do that _anyway_ over time.  We _know_ that 
even PCI interrupts are changing. We're clearly moving towards a world 
where an interrupt is _literally_ a cookie from the device, and this very 
much includes PCI. What do you think MSI (message signalled interrupts) 
are all about?

So thinking about "dev->irq" as a cookie is literally the right thing to 
do. It is _not_ an index, and it certainly has nothing to do with things 
like the pci interrupt line register or what the actual hardware 
connection to the CPU is. It's a cookie. And for historical reasons we 
have value 0 being the "no cookie" value.

There are actually some good reasons to think of interrupts as kernel 
_pointers_ (and they'd point to the "irq descriptor"), but quite frankly, 
right now that's just too big of a change. But if we ever do that change, 
the value 0 would _still_ be the "no cookie" value, and you'd _still_ just 
use "if (!dev->irq)" to test whether you had an irq or not.

(If somebody wants to try to make "irq" into a pointer, I'd actually be a 
lot more supportive of it than of this "NO_IRQ" thing. I suspect it's a 
bigger patch than we really want, for not a lot of gain, but at least it 
would result in compile warnings for drivers, which is a way to control 
the damage. That's what we did for the SMP irq disable/enable changes too)

> I'd like to see dev->irq as a pointer to a structure.

Yes, indeed. We already even probably have the right structure (ie likely 
the right thing to do is to just use the current "irq_desc_t *").

If somebody wants to do that, I'll happily accept it. I just suspect it's 
a _lot_ of work.

		Linus
