Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVHAJKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVHAJKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 05:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVHAJKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 05:10:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:39831 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261959AbVHAJKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 05:10:45 -0400
Subject: Re: revert yenta free_irq on suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507301404240.29650@g5.osdl.org>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
	 <20050730210306.D26592@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0507301335050.29650@g5.osdl.org>
	 <20050730215403.J26592@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0507301404240.29650@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 11:06:49 +0200
Message-Id: <1122887210.18835.119.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 14:10 -0700, Linus Torvalds wrote:
> 
> On Sat, 30 Jul 2005, Russell King wrote:
> > 
> > I don't think so - I believe one of the problem cases is where you
> > have a screaming interrupt caused by an improperly setup device.
> 
> Not a problem.
> 
> The thing is, this is trivially solved by
>  - disable irq controller last on shutdown
>  - re-enable irq controller last on resume
> 
> Think about it. Even if you have screaming irq's (and thus we'll shut
> things down somewhere during the resume), when we then get to re-enable
> the irq controller thing, we'll have them all back again at that point.
> Problem solved.

That is nasty. That means every single driver must be careful not to
ever "wait" for the device interrupt to happen at resume. I'm not
talking about adding a timeout or such (that should be done anyway to
deal with hot unplug) but having something like IDE -> queues wakeup
request and blocks til it's dealt with. That sort of thing. It's
annoying, it means no driver can rely on IRQs actually working in their
resume callback. Not nice.

Also, once a driver has woken up, it doesn't really have an idea that
the rest of the system is not yet fully up (or that it actually is), and
thus doesn't really know if interrupts are still globally off or not if
we implement your scheme. That may cause nasty effects too I suppose...

> You can have variations on this, of course - you can enable the irq
> controller early _and_ late in the resume process. Ie do a minimal "get
> the basics working" early - you might want to make sure that timers etc
> work early on, for example, and then a "fix up the details" thing late.
> 
> An interrupt controller is clearly a special case, so it's worth spending 
> some effort on handling it.
> 
> In contrast, what is _not_ worth doing is screweing over every single
> driver we have.

I'm not fan of the free/request irq on suspend & resume for various
reasons, and I don't think it actually fixes the problem discussed
anyway because of shared interrupts, but heh, the problem is real on x86
it seems (BIOS crap !). Not sure what the best fix is.

Ben.


