Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317704AbSGVRJW>; Mon, 22 Jul 2002 13:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317705AbSGVRJW>; Mon, 22 Jul 2002 13:09:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15369 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317704AbSGVRJV>; Mon, 22 Jul 2002 13:09:21 -0400
Date: Mon, 22 Jul 2002 10:13:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <Pine.LNX.4.44.0207221248250.4519-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207221004420.2504-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jul 2002, Ingo Molnar wrote:
>
> So what i did in my tree was to introduce the following 5 core means of
> manipulating the local interrupt flags:
>
> 	irq_off()
> 	irq_on()
> 	irq_save(flags)
> 	irq_save_off(flags)
> 	irq_restore(flags)

Ugh.

I'd much rather keep the current "local_xxx" versions, since they clearly
say that it's local to the CPU. Let's face it, people SHOULD NOT USE
THESE!

You should use "spin_lock_irq()" and friends, since those are the only
sane interfaces for doing real irq-safe locking.

So what's wrong with just keeping the things that we've advocated for a
long while, and not try to break source compatibility "just because".

Keeping the old names will make it a lot easier to maintain drivers that
do want to use them, and it means not having to change old drivers that do
the right thing.

So I vote for

	local_irq_save(flags)		- save and disable
	local_irq_restore(flags)	- restore
	local_irq_disable()		- disable
	local_irq_enable()		- enable

and that's it. Yes, the "calling convention" for local_irq_save() is
strange, but it makes it easier for some architectures, and other
architectures can just always make it

	#define local_irq_save(flags) \
		do { (flags) = arch_irq_save(); } while (0)

and it's not worth breaking existing practices over (besides, that's the
calling convention that "read_lock_irqsave()" also has, and I do _not_
want to change all of that _too_).

As to needing to do a save without a disable, show me where that really
matters..

I agree that we should get rid of __cli / __sti / __restore_flags /
__save_flags and company, but that is no excuse for breaking backwards
compatibility for stuff that has used the new interfaces

I really think that "local_" prefix is worth it. It makes people who are
used to, and work exclusively with, UP think twice about what the thing
actually does.

		Linus

