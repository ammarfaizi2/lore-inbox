Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWEQGRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWEQGRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 02:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWEQGRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 02:17:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:18142 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932433AbWEQGRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 02:17:44 -0400
Subject: Re: [patch 00/50] genirq: -V3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060517001310.GA12877@elte.hu>
References: <20060517001310.GA12877@elte.hu>
Content-Type: text/plain
Date: Wed, 17 May 2006 16:11:56 +1000
Message-Id: <1147846317.4025.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Thomas !

Ok, I think it's better :) But I also think it's not there yet....

Separate flow handlers as "the standard recommended way to go" isn't
the right thing to do imho.

While I agree to leave room for such flow handlers per irq_desc for
really broken interrupt controllers, I'm still not convinced that the
"generic" one (ie. __do_IRQ) can't be used for pretty much everything
(maybe with a few changes), and having those 4 separate "default" flow
handlers presented as beeing "the way to go" by the documentation
isn't quite right.

In fact, I also think it would be less robust (I'll give an example later).

I also have reservations on the way the arch code is supposed to
decide how/when to call the various handle_irq_* handlers with
variable locking requirements and is responsible for getting to the
irq_desc (at least a helper here would be of some use).

To summarize before I explain (heh), while I agree that it _might_ be
useful to give the option of having separate flow handlers, I don't
think it should be the default/recommended practice and we shouldn't have
to provide specialized flow handlers in the generic code. In fact, one
standard robust flow handler that deals with the most common cases of
edge,level and percpu interrupts. I'll explain in more details some of
my reasons below.

Let's first go through the changes to irq_chip/hw_interrupt_type
before I dig into the rationale of having (or not having) split
handlers:

>From your previous implementation, you removed the distinction between
irq_type and irq_chip, they are no longer separate structures.
But you still basically merged all the "new" fields together. Thus we
end up with things like both enable/disable/ack/end "high level" and
mask+ack/unmask "low level" callbacks in the irq chip. That makes
things confusing. 

If we go back to the initial hw_interrupt_type (which was a misnamed
hw_interrupt_controller, or irq_chip, I'm not opposing the name
change), we have the enable/disable/ack/end "API" to the main old flow
handler (__do_IRQ) and other API functions. I am not convinced that it
makes sense to add "lower level" functions to it at this level.
Essentially, I think those new callbacks are either redundant or not
necessary. If your intent is to expose a "high level" vs. a "low
level" interface to the controller, then I disagree with the design
since that "low level" interface is essentially tied to the usage of
split flow level handlers and to the way "very dumb" interrupt
controllers work (and even with those, I think it's not necessary).
But let's first look at the callbacks themselves:

First disable/enable at the controller level is essentially identical
to mask/unmask. There is some clear redundancy there. The depth
counting or flag checking shall be done by the caller in any case,
thus the controller enable/disable should just be what they are,
low level dumb mask/unmask.

The remaining one is mask_and_ack. I don't personally think it is
needed, ack is enough. Wether ack should mask or not is, I think,
local to the irq_chip implementation.
If a given chip wants to mask some type of interrupts when ack'ing
them, it's free to do so and unmask them in end() based on the
IRQ_LEVEL flags for example, I don't think it mandates en entire level
of abstraction (separate flow handlers that is) to handle that simple
case. Since a flow handler should imho be specific to a given (broken)
interrupt chip that can't use for some (unknown) reason use the
default one, I see no problem having that irq_chip implementation
of ack do something specifically matching the needs of whatever flow
handler it's using. One could argue that it will add an "if ()" or two
in the ack implementation, and my answer is that's better than an
indirect function call (see later why I think the default handler
shouldn't be a function pointer, same reason)

Now, back to the root of my problem which is why I don't think we need
to generalise having separate flow handlers and keep that a special
case for broken controllers.

First, as we discussed on IRC, I yet have to find a convincing example
of an irq controller that cannot fit the current __do_IRQ() flow
handler.
I've turned the example you gave me of a cascaded demuxer that does edge
interrupts all the ways around, I still can't see why it can't be done
properly without special flow handlers. I suspect such a controller
also has HW/design bugs that I haven't guessed, an explanation from
Russell King would be welcome here.

Despite that, I agreed that it might be ok to leave the _option_ of
overriding the main flow handler for a given irq_desc. But that should
be clearly presented as an option for use by special case/broken
controllers.

For an example (among others) of why I find the split handlers
approach less robust is the logic of handling an IRQ that is already
in progress. This logic is useful for edge interrupts in the normal
case and thus you implemented it in your edge handler. But why remove
it from the level handler ? For "normal" level interrupts, it's not
supposed to happens, but IRQ controllers have bugs, especially smarter
ones, and that logic can't harm. For example, some SMP distributed irq
controllers might occasionally incorrectly deliver a given IRQ to more
than one CPU at once. Depending on the timing and the architecture
(how the vectors are send to the processor), this can result in just a
spurrious interrupt (no vector) or a "short" irq. In that case, with
your "simplified" level handler, you'll end up potentially re-entering
the "user" (ie driver) action handler. With the "security", the worse
that can happen is that the "user" action handler will be called for
an interrupt that is no longer pending, it will do nothing, return
IRQ_NONE and we'll take note of a spurrious interrupt. Probably only
one, since even if it's a level interrupt, it shouldn't re-occur right
away as it's a "short" interrupt. In any way, it's handled in a robust
way, while potentially re-entering the driver handler isn't. I like
that kind of by-design safety.

Also, the "split" handlers enforce the semantic that, for example, a
level interrupt needs to be mask'ed and ack'ed, to be unmasked later
while an edge interrupt should be left free to flow after ack. That
sounds good on paper and matches probably the requirements of dumb
controllers but doesn't quite agrees with smarter things like
OpenPIC/MPIC, XICS, or even hypervisors. As I wrote above, I think the
generic flow handler calling ack() and end() is plenty enough, it's up to
the irq_chip implementation of those two to decide wether they should
mask a certain type of interrupt (and later unmask it).

Of course that means 2 or 3 more lines of code in the implementation
of dumb interrupt chips with one classical source of bugs which is the
unmasking in end() which should only be done if the interrupt didn't
get disabled while being handled. I understand that you are trying to
make life easier for those. Maybe one option here would be to provide
"helpers" for use by these things. The simplest would be in the form
of an irq_end_shall_unmask() function that can be called in end() to
know wether to unmask or not. A more complex option would be to have a
irq_dumb_chip which contains those additional "low level" functions
and have pair of "helper" versions of ack and end that can be used by
a dumb_chip... That's more like we do in linux:

 Core ----> irq_chip (std set of callbacks)
                 |
		 |
		 |--> irq_dumb_chip (extended set of callbacks)

That is the "standard" interface to the driver is the high level one,
and we can provide pluggable helper functions to implement it on top
of a low level driver

But again, that is provided you really think it's important to save
those few lines of code that needs to be implemented in the ack() and
end() handlers of dmub chips... I don't :)


Now, previously, I also said why I didn't like indirect function calls
and that if's are imho better... If you look at the current __do_IRQ()
you might think it would make sense for example to have percpu
handling be a separate flow handler. But in practice, especially with
heavy pipelined CPUs, it tends to actually be a lot slower to branch
through a function pointer than to handle an if. Maybe it's worth
moving that percpu flow handler to a spearate static function, but the
construct:

  if (special_case) {
  	do_special_case();
	return;
  }
  do_normal_case();

Is faster in many situations than calling a function pointer that can
be either do_special_case() or do_normal_case(). The function pointer
abstraction is still useful in many circumstances and has it's own
justification, but I think in our case, we don't want it.

That's also why we should provide a toplevel:

  extern irqreturn_t handle_irq(unsigned int irq, struct pt_regs *regs);

That essentially boils down to:

  if (desc->flow_handler)
  	return desc->flow_handler();
  normal_flow_handler();

(with the later being either a function call, or just the expanded
thing that currently is called __do_IRQ())

I don't like in your current approach what seems to be (unless I
missed something) that the arch code (toplevel) is supposed to find
the irq desc and do the desc locking.

Such a handle_irq() should also will also be called from within a
cascade handler obviously. (Unless you want to use my SA_CASCADE
approach, but I'm not sure it's that useful here).

I think the arch should have a single function (as above) to call when
it gets a toplevel interrupt. That function handles the picking up of
the irq_desc, the locking,... Ideally, the arch shouldn't need to know
irq_desc outside of the actual irq_chip implementation code.

Also note that I'm calling the flow handler without the lock. Your
code seems to be slightly inconsistent in your locking rules for the
flow handlers. I think it should be local to the flow handler (some
flow handlers might operate lockless like percpu interrupts do).

Ok, that's pretty much all, unless I missed a bit or two. There is a
lot of good stuff in your patches, don't get me wrong, I just think the
flow handler thing is a bit "too much" in it's current incarnation, at
least until somebody proves me that it's really useful :)

All of the cleanups look good, the new flags too (NOPROBE,NOREQUEST,
etc...)

Cheers,
Ben.

