Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWIGNhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWIGNhh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWIGNhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:37:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39808 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751469AbWIGNhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:37:34 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060907102621.GC4125@elte.hu> 
References: <20060907102621.GC4125@elte.hu>  <20060906125626.GA3718@elte.hu> <20060906094301.GA8694@elte.hu> <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> <13982.1157545856@warthog.cambridge.redhat.com> <17274.1157553962@warthog.cambridge.redhat.com> <8934.1157622928@warthog.cambridge.redhat.com> 
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       john stultz <johnstul@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Sep 2006 14:34:35 +0100
Message-ID: <4922.1157636075@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> > So, again, why _should_ I use the generic IRQ stuff? [...]
> 
> To have shared code between architectures?

That's reasonable as far as it goes, the algorithms are similar per-arch, but
the PICs are quite ofter quite different.  My FRV board here has three very
different ones, none of them compatible with anything else as far as I know.

> To make generic API updates easier for all of us?

That's reasonable.

> To have less cruft in interrupt.h?

That's specious.  The whole point of having arch-specific code is to support
arch-specific stuff.

> To not having to add last-minute patches to v2.6.18 because some arch
> defines its own IRQ prototypes and a difficult generic feature like irqtrace
> breaks?

Specious again.  If whoever it was made the changes got them right in the
first place, then it wouldn't have required a last minute patch for the
LOCKDEP=n case now would it?

If you're going to insist on the genirq stuff being used, than you should take
CONFIG_GENERIC_HARDIRQS away and force everyone else to move to what you've
decided they should use, right?

> To get new IRQ subsystem features for free like preemptible irqs, irqpoll or
> SHIRQ debugging?

That's reasonable, but you don't get necessarily get features for "free" when
you add up the cost of having support there for them.  The features appear for
the subscribed arches automatically, and so do the costs.

> hm, could you take a look at why that difference happens? Do you make 
> use of __do_IRQ()?

I did say I used it.  In fact, as far as I can tell, I have to use it
recursively.  There doesn't seem to be any other way in that's correct.

> Do you make use of all the various flow handlers that are offered in
> handle.c?

Some of them.

> Could you #ifdef out all the functions that are unused? The kernel build
> process doesnt remove them and i havent (yet) put them into a library.

I could get away with commenting out:

	no_action()
	set_irq_wake()
	can_request_irq()
	set_irq_type()
	set_irq_data()
	set_irq_chip_data()
	handle_simple_irq()
	handle_fasteio_irq()
	bits of handle_irq_name() corresponding to the previous two

This results in a small shrinkage of text and a slight increase in the amount
of data used:

	   text    data     bss     dec     hex filename
	1993023   77908  166964 2237895  2225c7 vmlinux [before]
	1991407   77912  166964 2236283  221f7b vmlinux [after]
	---------------------------------------
	   1616      -4       0    1612

The increase in data size is slightly puzzling, but may have something to do
with there being fewer strings in handle_irq_name().  The text decrease is
about 12% of the unmodified total:

	   text    data     bss     dec     hex filename
	  10908    3272      12   14192    3770 kernel/irq/built-in.o
	   1548      64       4    1616     650 arch/frv/kernel/irq.o
	    744     192       0     936     3a8 arch/frv/kernel/irq-mb93091.o
	---------------------------------------
	  13200    3528      16   16744         total

> the same "why should we share code" argument could be made for the VFS too.

That argument doesn't really follow.  We only have one interrupt system in the
kernel, but we have lots of different filesystems.

> Sharing code has a (small) price most of the time, but it's also very much
> worth it. I think the size increases you are seeing are artificial

Artificial in what manner?  I haven't added extra code to genirq to make it
look bad or anything like that.

> and most of it is not caused by the indirections. If they were caused by the
> indirections i'd probably agree with you.

I think most of the size increase is due to the core genirq function set being
large, not the indirections themselves.  There aren't many indirections
implemented in the core set.

The indirected functions exist in the arch code for the most part, and where
they are implemented they are generally very small.  In FRV's case, one lot in
arch/frv/kernel/irq.c for the CPU and one lot in arch/frv/kernel/irq-mb93091.c
or similar for the on-motherboard FPGA.

> if your argument were true every arch should run its whole Linux kernel 
> in arch/frv, with zero sharing with anyone else.

Not really.  eCos manages this more efficiently than Linux, with generally
fewer indirections through the use of macros and inline functions.

At some point you do have to draw a line and do common stuff.  The VFS is
definitely in the common region.  It has little need of arch-specific stuff in
there, and that that it does is quite readily encapsulated in inline functions
where it has little effect on the space.  I'm not entirely convinced that this
applies to interrupt handling though.  That is at the basic level very
arch-dependent.

> There's always a lot of 'unnecessary' stuff all around the kernel that is
> just a hindrance for FRV.

Or any other platform, embedded or otherwise, that doesn't want it.  A lot of
it I can disable - the block layer now, for instance - but some of it I can't
(like interrupt handling).

> In reality what makes us stronger is to work together.  I dont for a minute
> say that we should overdo code sharing

So who defines what is "overdone"?  You seem to have decided that you do.

> - if it's not possible then it must not be forced, but just the pure fact of
> "more indirections" or "what does this bring me _now_" isnt a good enough
> reason i believe - it simply makes _future_ changes easier.

And makes the kernel larger and slower and makes it consume more stack space
and less easy for the compiler to optimise.

David
