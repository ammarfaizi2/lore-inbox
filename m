Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTJIC3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 22:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTJIC3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 22:29:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:46244 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261879AbTJIC3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 22:29:19 -0400
Date: Wed, 8 Oct 2003 19:29:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
In-Reply-To: <20031009020000.GZ7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310081904330.2721-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Executive summary: I think 2.6.x does the right thing as-is, although 
  there is definitely some ugly corners there. ]

On Thu, 9 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> 	Current code (at least on x86 and alpha) appears to assume that
> you can't call disable_irq()/enable_irq() unless you have registered
> that irq.

Why? It was definitely not designed to do that - the irq disable is an irq 
_descriptor_ feature, not a irq handler feature. 

So irq registration should have absolutely zero to do with anything.

> That happens *way* before we call register_irq().  Current tree barfs on
> that in all sorts of interesting ways.  Most notably, we get irq enabled
> and with NULL ->action for a while.

Which should be perfectly fine. In fact, it's _designed_ to be perfectly 
fine, since this is how irq probing is also implemented.

This is not "barfing".

>				  If an interrupt comes during that
> time, we'll get IRQ_INPROGRESS set and not reset until later register_irq()
> (see handle_irq() for details).  Note that calling disable_irq() after that
> will kill us on SMP - it will spin waiting for IRQ_INPROGRESS to go away.

Now _this_ is a bug waiting to happen. I don't think it actually happens 
now (since anybody who does disable_irq() _will_ either have registered 
the irq already or will do so soon, but I agree that it's just trouble 
waiting to happen.

I think the fix to that is to just add a trivial test for "if the handler
list is empty, don't bother synchronizing" in disable_irq(), since clearly
if the list is empty there is nothing to synchronize _with_. After all,
the synchronization is there just to make sure no handler runs
concurrently on another CPU.

(We can't add that test to "synchronize_irq()" itself without more
surgery, since the irq _freeing_ path actually removes the entry from the
queue first, so in that case synchronize_irq() will normally see an empty
irq handler list)

> Moreover, if somebody calls register_irq() while we are at it, we'll get
> ->depth reset to 0.  enable_irq() will try to decrement depth and will get
> very unhappy about the situation.

Yeah, that depth reset I actually worried about at some time. It's never
been a problem though, since concurrent device probing just doesn't happen
and basically isn't really supported. We discussed it for bus probing, and 
the rule is to just not do it.

The reason I worried about the depth reset is actually different: we've
historically not had a good way to atomically enable a PCI device _and_
request its interrupt. Nobody has ever really complained, but if anybody 
ever wants to do this, then the way to do it would be to

 - find out the irq
 - disable it
 - request the irq
 - enable the PCI routing for it
 - set up the device
 - enable the irq

and the thing is, the disable should actually happen _before_ we request 
the irq, because we potentially could not afford to take an interrupt with 
the device incompletely set up.

NOTE! This is not something we support, and it's not something I've heard 
people complain about, but it is something I think makes sense. And it 
definitely implies that we should be able to
 - disable irq's regardless of whether we have registered them
 - not reset the disable depth on irq request.

> What do we really want to do here?  I see only two variants:
> 	a) allow enable_irq()/disable_irq() regardless of having the thing
> registered.

Absolutely.

> 	b) have ide-probe.c register a dummy handler for that period.

No. That's wrong. That just causes lockups with level-triggered PCI 
devices, so the "dummy handler" really needs to know a lot about how to 
turn the interrupt off. Which is nasty before the driver has even set up 
the device completely, and may be in the middle of futzing with it.

This is why "disable_irq()" really exists. Which is why (a) is what the 
current code is _supposed_ to do.

> 	Note that scenario above is absolutely real - 2.4.21 and later
> hang on DS10 since their IDE chipset (alim15x3.c) does generate an interrupt
> after the probe code had called enable_irq().  With obvious results -
> ide_intr() is never called afterwards.  On 2.6 it doesn't happen only
> because register_irq() forcibly drops IRQ_INPROGRESS, which hides that
> problem, but doesn't help with other scenarios (e.g. somebody sharing the
> same IRQ and doing register_irq() before we call enable_irq()).

As far as I can tell, 2.6.x is doing all the right things. Modulo the (not
really supported) concurrent device probing, and the (not implemented) 
atomic irq requesting.

Note that the IRQ_INPROGRESS thing was literally the bit that autodetect
used to test, it got changed it to IRQ_WAITING to clarify the code and
avoid bad interactions with the other uses of IRQ_INPROGRESS.

And note that we do _not_ clear IRQ_INPROGRESS on "action == NULL" very
much on purpose: that "action == NULL" thing also happens if the IRQ is
disabled, and we need to get the edge replay right. This is why
request_irq() literally _needs_ to clear that bit in 2.6.x.

So the fix is to make 2.4.x do what 2.6.x does, methinks.

Possibly with a more robust implementation (ie the conditional
synchronize_irq() thing in disable_irq()).

And while I agree that the depth clearing is bogus, but I'd be worried
about removing it in case some driver actually depends on it (ie
historically it has actually been ok to do:

	disable_irq(irq);
	.. set up device ..
	request_irq(irq, ..);	// This will also enable the irq

even though it's ugly, and I hope nobody does it).

		Linus

