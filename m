Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWEKLt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWEKLt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWEKLt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:49:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:47488 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030233AbWEKLt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:49:28 -0400
Subject: Re: [RFC][PATCH] Cascaded interrupts: a simple solution
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20060511093712.GA26316@elte.hu>
References: <1147325215.30380.45.camel@localhost.localdomain>
	 <20060511093712.GA26316@elte.hu>
Content-Type: text/plain
Date: Thu, 11 May 2006 21:47:47 +1000
Message-Id: <1147348068.20614.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We have solved this problem in the genirq patchset, but in a different 
> way. No matter how much i'd like to see a simple solution for a hard 
> problem, we believe the SA_CASCADEIRQ method is insufficient, for a 
> number of reasons.
> 
> The main goal of genirq: to merge the ARM architecture to the generic 
> IRQ layer and thus make the generic IRQ layer truly generic. Secondary 
> goal: to not disturb any of the current genirq architectures (i.e. stay 
> fully compatible). The ARM IRQ layer is exotic in some respects, but it 
> is certainly the most advanced IRQ layer in terms of PIC-topology 
> handling, given the rich variety of ARM hardware in existence.

Well... I yet have to look at the current ARM stuff from Russell, but
I've looked at Thomas "port" and there's a lot of stuff in there that I
dislike. I yet have to be convinced that whatever it provides can't be
done with the current code. Now of course, I'll be happy to discuss
every single technical detail until we come to an agreement :) But I'm
afraid this won't make it for 2.6.18. If it does, fine. If it doesn't,
I'd like my approach to be merged for that kernel version as I really
want that in for handling some of the upcoming cell stuff.

I plan to spend a few hours as soon as I find the time to explain more
in depth the technical reasons why I don't like some aspects of Thomas
work, but I want first to take the time to better review the current ARM
implementation and I was sort-of waiting for him to go public so we have
an open discussion.

> Just some stats to back this up: arch/arm*/ has 118 separate PIC 
> implementations, and amongst them there are more than 40 that need 
> demultiplex handlers. As a comparison, arch/[ppc/powerpc] sports 27 PIC 
> implementations, amongst which there are 5 that need demultiplex 
> handlers. arch/i386 has 10 PIC implementations and none of them need 
> demultiplex handlers [there are minor forms of cascading in x86 
> hardware, but none need true irq-vector demultiplexing].

Heh, we don't need to do a pissing contest here :)

> Most architectures modeled their IRQ layer after i386 IRQ layer, and 
> this resulted in the first phase of generic IRQ layer being quite 
> similar to the i386 layer. But the largest and most versatile Linux IRQ 
> subsystem was left out of the original genirq design (done by yours 
> truly), and many good bits (amongst them the right way to handle 
> cascading/chaining) i missed.

Heh, I know and that's why I CC'ed you :)

>From what I've seen of Thomas initial work, if you remove all of the
renaming of things and splitting into irq_chip vs. irq_type, it
essentially boils down to having a way to re-implement the do_IRQ logic
(and it's flag/locking manipulations) based on the IRQ type. However,
from what I've seen, compared to the current code, it doens't provide
much that the current code can't do with maybe few bits & pieces
changed, adds overhead (another layer of indirect funciton calls is
expensive) and forces us in a model that don't match most of the
modern/advanced irq controllers nicely without bloat (basically having
spearate irq_type for them).

I'll get in more details later (it's a bit late here and I'm tired :)

> Current status of genirq: it has been part of the -rt tree for more than 
> a year, and an earlier version has been sent to lkml once already - 
> Thomas has submitted an improved version of it to the ARM lists roughly 
> a week ago and it is currently being tested on many ARM boards, with 
> good results.
> 
> (I suspect you are aware of our genirq efforts, hence did you Cc: Thomas 
> and me? If you are aware of it, please address the differences between 
> the two approaches and outline why you chose a different solution - 
> thanks!)

I will. Not tonight though.

> Most PIC implementations do not need to worry about PIC cascading, and 
> neither the SA_CASCADEIRQ nor the genirq approach impacts them. So my 
> analysis of your patch only involves true cascaded PICs and the ways to 
> support them cleanly.
> 
> For cascaded PICs, the main problem with the SA_CASCADEIRQ approach is 
> that it assumes that cascading/demultiplexing can be handled via a 
> "return irq" method, in an iterative way.

Yup.

> But this does not match the demultiplexing model that happens on the 
> majority of ARM boards for example: there a bitmask is read from the 
> secondary interrupt controller, and that bitmask might have multiple 
> bits set.

Which is also what happens on some PowerMacs

>  By returning only one bit [which iteration model your 
> interface forces], the other bits can be lost. On some hardware those 
> missed bits might be regenerated, but there is PIC hardware where that 
> information is permanently lost and we end up losing interrupts.

It's fairly simple to handle that in the cascaded controllre driver by
or'ing read bits into a "pending" mask and clearing them as they get
returned to the upper layer. I don't see the need of adding layers of
indirections to handle that simple trick. Looping is the right way to go
as my patches imlement to then get one of them at a time. Now if you are
worried that we might end up artificially prioritizing the first ones
that way, them we can simply also cache the last bit "scanned" in the
pending mask and start from there on the next iteration. Again, very
simple code that doesn't imho requires turning the whole model upside
down.

> Such mask-based demultiplexing PICs are not limited to ARM, they occur 
> in the PPC world too, for example in arch/ppc/syslib/m82xx_pci.c, 
> pq2pci_irq_demux():

 .../...

> If PCI_INT_MASK_REG is a read-once register, then the SA_CASCADEIRQ 
> method could result in lost interrupts. (i'm not totally sure, but i 
> think in this specific case that register is read-once and it also 
> involves an auto-ack. In any case, there definitely is ARM hardware 
> where this equivalent register is read-once.)

If implemented stupidly it surely would :) But as I wrote above, it can
easily be implemented in a way that won't result in lost interrupts.

> Even if PCI_INT_MASK_REG could be read in a non-destructive way, 
> multiple bits would need multiple iterations and multiple (unnecessary) 
> passes over the whole bitmask - and they would thus also need 
> unnecessary IO cycles to re-fetch the mask itself.

True, my approach would cause re-fetches from the mask though that could
be avoided with careful coding as well (only re-fetching when the
current "pointer" into the mask wraps around). I yet have to be convince
though that your model, while maybe slightly simplifying the
implementation of the cascaded controller "fetch" routine, justifies the
overhead & bloat of the generic code.

An example is controllers like OpenPIC/MPIC that handle masking and
priority stacking transparently currently require very little code in
the begin and end handlers of irq_desc. With Thomas model, begin() and
end() are gone in irq_chip. Thus, I would end up causing a full mask &
umask (significant overhead) if using the standard handlers for level
and edge irq_types. Which basically means that I would have to implement
different irq_types to avoid that.

In a similar vein, I'm losing startup/shutdown from the controller which
I'm using to internally setup the HyperTransport APICs. I could do it
elsewhere but it's not as nice imho... or use custom irq_type's. Same
for XICS.

Finally, set_affinity() is also missing from irq_chip.

So you basically moved all of the previous interface
(begin/end/startup/shutdown/etc...) to the IRQ controller to the new
"irq_type" layer which then "emulates" the functionality of a smart irq
controller on top of an "irq_chip" which represents a totally dumb
controller than can only mask/unmask.

I don't think it's the right approach.

> (Depending on how many different interrupt sources a secondary PIC 
> connects, and how frequently those are risen, this might or might not be 
> a real performance problem. But in any case, the "return irq" method is 
> certainly an ugly and unnatural model for such PICs and there is no 
> clean way to handle this type of cascading via the 'return irq' method.)
> 
> So the solution we took in genirq was to delegate the act of 
> demultiplexing into the _demultiplexing handler_, by adopting the ARM
> IRQ layer's approach of calling desc_handle_irq(irq, desc, regs). For
> example:

The "handler" is the irq_type structure. Looking at all irq_type
implementations in thomas patch, it's actually the only thing that
changes from a type to another.... The rest all goes to 'default'. I
think there is some over-engineering there.

If you guys really want to keep the concept of having a "handler" for
different implementation of controllers/irqs, them it could have simply
been part of the irq_desc.

I yet also have to figure out if your approach allows the cascade to be
shared with a normal IRQ. Mine does. (Yours might, I yt have to figure
out what happens if you end up trying to define more than one type per
irq, I suppose it's not possible but I don't have the code at hand right
now)

> desc_handle_irq() does the locking and the calling of the highlevel irq 
> handler of the secondary PIC. [which then processes the device IRQ 
> handler actions and does any pre/post ACKing logic] There is no impact 
> to non-cascading PIC designs in this model either.

Except for one more level of function pointer indirection which can be
fairly expensive.

> Another, conceptual level problem is that (ab-)using the irq handler 
> methods to return an actual interrupt number is a layering violation. 
> There is not much in common between an IRQ demultiplexer function and an 
> interrupt handler function. The act of cascading two PICs _inevitably_ 
> means that there is a 1:N relationship between the two PICs, while an 
> IRQ handler is normally a 1:1 relationship between a hardware device and 
> a PIC. (there are exceptions like shared interrupts, but the norm we are 
> designing for is a 1:1 relationship) There are many other fundamental 
> differences too. Thus in our genirq work we have separated these two 
> concepts.

This is not completely true. It's actually fairly common that a device
itself is a demuxer. It's interrupt handler then reads a status register
to check which of the many local sources triggered. I don't think there
is any fundamental difference between a cascaded controller and a
device.

> In terms of patch merging (unless there are some arguments i've 
> overlooked), due to the reasons above i'm against merging SA_CASCADEIRQ, 
> even if it's relatively simple. It does not solve the demultiplexing 
> problem for most of the ARM handlers (nor for the PPC example i cited), 
> hence a separate variant has to be implemented anyway which results in 
> unnecessary code and concept duplication.

I think it does solve the problem due to my above explanations :)

> The current PPC/powerpc approach of calling __do_IRQ() might be hacky, 
> but it's functional, so neither is there any instant urgency AFAICS. If 
> our more complete genirq approach is rejected for whatever reason then 
> the SA_CASCADEIRQ patch can still be revisited as a secondary choice.
> 
> Nor can i see any big cleanup effect in terms of per-arch PIC code, the 
> patch actually adds a bit of code:

Not really, it will go away once I remove the special code to handle
cascades at the PIC level that we currently have and that will be made
obsolete by this mecanism.

In addtition, there are other issues imho with the implementation I've
seen in Thomas patch. Since I finally explained most of my concerns
above instead of in a couple of days, I'll finish now which whatever
remains in my mind of reading it yesterday :) That is essentially that i
find the approach of splitting the level and edge handlers less robust.

The current handler has the IN_PROGRESS/PENDING mecanism. The patch
keeps that only for edge interrupts and not for level interrupts. That
might seem fine on the paper, but as soon as an irq controller starts
misbehaving for some reason, the security it provides to avoid
re-entrency in a pending interrupt will be lost for level interrupts.

I think I had a couple of other concerns but I don't have them on the
top of my mind right now. Let's see how we go with that now tough. I've
addressed my main issues I think.

Ben.

