Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTJICnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 22:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTJICnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 22:43:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23492 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261722AbTJICnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 22:43:35 -0400
Date: Thu, 9 Oct 2003 03:43:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Message-ID: <20031009024334.GA7665@parcelfarce.linux.theplanet.co.uk>
References: <20031009020000.GZ7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310081904330.2721-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310081904330.2721-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 07:29:10PM -0700, Linus Torvalds wrote:
> >				  If an interrupt comes during that
> > time, we'll get IRQ_INPROGRESS set and not reset until later register_irq()
> > (see handle_irq() for details).  Note that calling disable_irq() after that
> > will kill us on SMP - it will spin waiting for IRQ_INPROGRESS to go away.
> 
> Now _this_ is a bug waiting to happen. I don't think it actually happens 
> now (since anybody who does disable_irq() _will_ either have registered 
> the irq already or will do so soon, but I agree that it's just trouble 
> waiting to happen.

Ummm...  probe_hwif() is a good example of the opposite - it can fail
past the point where it disables irq and that means no register_irq()
after enable_irq() call on cleanup.

> I think the fix to that is to just add a trivial test for "if the handler
> list is empty, don't bother synchronizing" in disable_irq(), since clearly
> if the list is empty there is nothing to synchronize _with_. After all,
> the synchronization is there just to make sure no handler runs
> concurrently on another CPU.

How about
 
        action = NULL;
        if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
                action = desc->action;
                status &= ~IRQ_PENDING; /* we commit to handling */
		if (likely(action))
			status |= IRQ_INPROGRESS; /* we are handling it */
        }
        desc->status = status;

in handle_irq()?

> As far as I can tell, 2.6.x is doing all the right things. Modulo the (not
> really supported) concurrent device probing, and the (not implemented) 
> atomic irq requesting.
> 
> Note that the IRQ_INPROGRESS thing was literally the bit that autodetect
> used to test, it got changed it to IRQ_WAITING to clarify the code and
> avoid bad interactions with the other uses of IRQ_INPROGRESS.
> 
> And note that we do _not_ clear IRQ_INPROGRESS on "action == NULL" very
> much on purpose: that "action == NULL" thing also happens if the IRQ is
> disabled, and we need to get the edge replay right. This is why
> request_irq() literally _needs_ to clear that bit in 2.6.x.

	See above - we shouldn't clear it on action == NULL, but we don't
need to set it, AFAICS.
 
> So the fix is to make 2.4.x do what 2.6.x does, methinks.

ObOtherFun:  There's another bogosity in quoted ide-probe.c code, according
to dwmw2 - he says that there are PCI IDE cards that get IRQ 0, so the
test for hwif->irq is b0rken.  We probably should stop overloading
->irq == 0 for "none given", but I'm not sure that we *have* a value
that would never be used as an IRQ number on all platforms...
