Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWERJj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWERJj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWERJj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:39:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:50564 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751152AbWERJj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:39:27 -0400
Subject: Re: [patch 00/50] genirq: -V3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060518073853.GA27687@flint.arm.linux.org.uk>
References: <20060517001310.GA12877@elte.hu>
	 <1147846317.4025.18.camel@localhost.localdomain>
	 <20060517222734.GC30073@flint.arm.linux.org.uk>
	 <1147912361.10703.40.camel@localhost.localdomain>
	 <20060518073853.GA27687@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 18 May 2006 19:33:37 +1000
Message-Id: <1147944818.5192.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell !

> That is incredibly wasteful for level interrupts - what you're suggesting
> means that to service a level interrupt, you take an interrupt exception,
> start processing it, take another interrupt exception, disable the source,
> return from that interrupt and continue to service it.  No thanks.

Oh no, that's not what I mean... I've come to agree with having several
flow handlers and thus the level flow handler would mask & ack, then
handle, then unmask is it should be for a level interrupt... What I
meant is that disable_irq could do soft-disable in all cases like it
seems to happen right now in the ARM code but not in Thomas patch.

> I thought you were the one concerned about interrupt handling overhead
> (about the overhead introduced by function pointer calls.) but that
> idea _far_ outweighs function pointer overheads.

I think you misunderstood what I meant by soft-disable :) Basically
bring in more of what ARM does in disable_irq/enable_irq.

> Sigh, I'm not teaching you to suck eggs - I was trying to justify
> clearly _why_ we have these different "flow" handlers on ARM and why
> they are important by contrasting the differences between them.

Yup, and I've finally been convinced, and Thomas patch _does_ have
different flow handlers. However, it doesn't do soft-disable or
lazy-disable as your prefer for disable_irq which means that you'll
still lose edge irqs on ARM. There are 2 ways out:

make disable_irq/enable_irq go through a specific implementation by the
flow handler or just ... generically have disable_irq just mark the
interrupt as disabled in the descriptor, and only actually disable it if
it happens to occur while it was marked disabled (in which case it can
be marked "pending" and possibly re-triggered on enable_irq if the
controller doesn't latch). I even had an idea of how to avoid the
re-trigger on controllers that _do_ latch properly easily: by having
chip->unmask return wether it needs re-emitting or not.

> Obviously, I should've just ignored your email since you know everything
> already.

Bah, don't take it that way please ! I was making a joke ...

Cheers,
Ben.


